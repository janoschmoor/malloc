/*
 * Malloc implementation using an implicit list with bidirectional coalescing
 * By Janosch Moor, October 24
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <string.h>

#include "mm.h"
#include "memlib.h"

/* single word (4) or double word (8) alignment */
#define ALIGNMENT 8

/* rounds up to the nearest multiple of ALIGNMENT */
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~0x7)


#define SIZE_T_SIZE (ALIGN(sizeof(size_t)))


// turns byte to word depending on alignment
#define BYTE_TO_WORD(x) (x/ALIGNMENT)
// turn words to bytes
#define WORD_TO_BYTE(x) (x*ALIGNMENT)

// define the global variables
void *begin = NULL;
size_t pagesize;

typedef struct block {
	unsigned is_used;
	size_t payload_bytes;
	size_t block_bytes;
	void* begin;
} block;

void *set_block(block);
void *get_next_ptr(void *);

void *new_page(void) {
	uint64_t *ptr = mem_sbrk(pagesize);
	if (ptr == NULL) {
		return NULL;
	}
	return (void *) ptr;
}

// initialises a block in the heap
void *set_block(block b) {
	// sets header and footer
	assert(b.payload_bytes + WORD_TO_BYTE(2) == b.block_bytes);
	uint64_t *ptr = (uint64_t *) b.begin;
	ptr--;
	*ptr = (b.payload_bytes << 1) | b.is_used;
	ptr += BYTE_TO_WORD(b.payload_bytes) + 1;
	*ptr = (b.payload_bytes << 1) | b.is_used;

	return (void *) (ptr - BYTE_TO_WORD(b.payload_bytes));
}

block get_block(void *begin) {
	uint64_t *ptr = (uint64_t *) begin;
	block b = {
		(*(ptr - 1)) & 0x1,
		((*(ptr - 1)) >> 1),
		((*(ptr - 1)) >> 1) + WORD_TO_BYTE(2),
		begin
	};
	return b;
}

void print_block(void *begin) {
	if (begin == NULL || get_block(begin).payload_bytes == 0) {
		printf("DEBUG: Invalid block at %p\n", begin);
		return;
	}
	block b = get_block(begin);
	printf("DEBUG: block at %p: [ is_used: %u, payload: %zu, block: %zu]\n", (uint64_t *) b.begin, b.is_used, b.payload_bytes, b.block_bytes);
}

void print_heap(void *begin, uint64_t amt_words) {
	uint64_t *ptr = (uint64_t *) begin;
	uint64_t *end = ptr + amt_words;

	while (ptr < end) {	
		printf("@%p: [%llu]\n", ptr, *ptr);
		ptr++;
	}
}

void print_heap_blocks(void *begin) {
	uint64_t *ptr = ((uint64_t *) begin) + 3;
	int t = 1;
	printf(" <-- Begin heap dump\n");
	while (t) {
		printf("\n");
		print_block((void *) ptr);
		print_heap((void *) (ptr - 3), 4);
		ptr = (uint64_t *)get_next_ptr((void *) ptr);
		if (ptr == NULL) {
			t = 0;
			printf("invalid pointer\n");
		} else if (*(ptr - 1) == 0) {
			t = 0;
			printf("\n");
			print_heap((void *) (ptr - 3), 4);
		}
		printf("\n");
	}
	printf(" <-- End of heap dump\n");
}

void *get_next_ptr(void *begin) {
	uint64_t *ptr = (uint64_t *)begin;
	if (*(ptr - 1) == 0) {
		return NULL;
	}
	block b = get_block(begin);
	
	uint64_t *ptr_next = (uint64_t *)b.begin + BYTE_TO_WORD(b.block_bytes);
	if (*(ptr_next - 1) == 0) {
		return NULL;
	}
	return (void *) ptr_next;
}
void *get_prev_ptr(void *begin) {

	uint64_t *ptr = (uint64_t *)begin;	
	if (*(ptr - 1) == 0) {
		return NULL;
	}
	if (*(ptr - 2) == 0) {
		return NULL;
	}
	uint64_t *ptr_next = ptr - BYTE_TO_WORD(((*(ptr - 2)) >> 1)) - 2;

	return (void *) ptr_next;
}

void *coalesce(void *begin) {
	
	uint64_t *prev_ptr = (uint64_t *) get_prev_ptr(begin);
	uint64_t *next_ptr = (uint64_t *) get_next_ptr(begin);

	block b = get_block(begin);
	
	if (b.is_used) {return begin;}

	if (prev_ptr != NULL) {
		block a = get_block(prev_ptr);
		if (!a.is_used) {
			size_t block_bytes = a.block_bytes + b.block_bytes;
			block replacement = {
				0,
				block_bytes - WORD_TO_BYTE(2),
				block_bytes,
				a.begin
			};
			set_block(replacement);
			b = replacement;
		}
	}
	if (next_ptr != NULL) {
		block c = get_block(next_ptr);
		if (!c.is_used) {
			size_t block_bytes = c.block_bytes + b.block_bytes;
			block replacement = {
				0,
				block_bytes - WORD_TO_BYTE(2),
				block_bytes,
				b.begin
			};
			set_block(replacement);
		}
	}
	return b.begin;
}

/* 
 * mm_init - initialize the malloc package.
 */
int mm_init(void)
{
	pagesize = mem_pagesize();
	begin = new_page();
	if (begin == NULL) {
		return -1;
	}
	uint64_t *ptr = (uint64_t *)begin;

	// first entry points to next page
	*ptr = (uint64_t)NULL;
	// zerofooter: set to 0 as there exists no block beneath it
	*(ptr + 1) = 0;
	
	size_t avail_space = pagesize-WORD_TO_BYTE(4);
	block b = {
		0,
		avail_space - WORD_TO_BYTE(2),
		avail_space,
		(void *) (ptr + 3)
	};
	set_block(b);

	// zeroheader: set to 0 as there exists no block above it
	*(ptr + (BYTE_TO_WORD(pagesize))-2) = 0;

	return 0;
}

/* 
 * mm_malloc - Implicit list
 */
void *mm_malloc(size_t size)
{

	size_t payload_bytes = ALIGN(size);
	size_t required_bytes = ALIGN(size + WORD_TO_BYTE(2));
	uint64_t *ptr = ((uint64_t *) begin + 3);


	while(1) {
		
		block b = get_block((void *)ptr);
		if (*(ptr - 1) == 0) {
		
			// assuming sbrk is contiguous
			uint64_t *next_page = (uint64_t *) new_page();
			if (next_page == NULL) {
				return NULL;
			}
			
			//zeroheader
			*(next_page + (BYTE_TO_WORD(pagesize))-2) = 0;
			
			block y = {
				0,
				pagesize - WORD_TO_BYTE(2),
				pagesize,
				(void *) (next_page - 1)
			};
			ptr = set_block(y);
			ptr = coalesce((void *) ptr);
			
			continue;
		}

		if (!b.is_used && (b.block_bytes == required_bytes || b.block_bytes >= required_bytes + WORD_TO_BYTE(4))) {

			// split block or allocate entire block

			if (b.block_bytes == required_bytes) {
				block x = {
					1,
					payload_bytes,
					required_bytes,
					(void *) ptr
				};
				void *ret = set_block(x);
				return ret;
			} else {
				size_t remaining_bytes = b.block_bytes - required_bytes;
				
				assert(remaining_bytes / 8 * 8 == remaining_bytes);

				block x = {
					1,
					payload_bytes,
					required_bytes,
					(void *) ptr
				};
				block y = {
					0,
					remaining_bytes - WORD_TO_BYTE(2),
					remaining_bytes,
					(void *) (ptr + BYTE_TO_WORD(required_bytes))
				};
			
				set_block(y);
				void *ret = set_block(x);
				return ret;
			}
		} else {
			ptr += BYTE_TO_WORD(b.block_bytes);
		}
	}
}

/*
 * mm_free
 */
void mm_free(void *_begin) {
	block b = get_block(_begin);
	b.is_used = 0;
	set_block(b);
	coalesce(_begin);
}

/*
 * mm_realloc
 */
void *mm_realloc(void *_begin, size_t size)
{
	if (_begin == NULL) {
		return mm_malloc(size);
	}
	if (size == 0) {
		mm_free(_begin);
	}

	block b = get_block(_begin);
	void *ret = mm_malloc(size);
	
	if (ret == NULL) {return NULL;}
	
	memcpy(ret, _begin, (b.payload_bytes < size) ? b.payload_bytes : size);
	mm_free(_begin);
	
	return ret;
}





