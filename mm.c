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

// requests and initialises new pages
void *new_page(void) {
	uint64_t *ptr = mem_sbrk(pagesize);
	if (ptr == NULL) {
		return NULL;
	}

	return (void *) ptr;
}

// initialises a block in the heap
void *set_block(block b) {

	assert(b.payload_bytes + WORD_TO_BYTE(2) == b.block_bytes);

	uint64_t *ptr = (uint64_t *) b.begin;
	// Header
	ptr--;
	*ptr = (b.payload_bytes << 1) | b.is_used;
	// Footer
	ptr += BYTE_TO_WORD(b.payload_bytes) + 1;
	*ptr = (b.payload_bytes << 1) | b.is_used;
	//printf("setblock footer %p, %llu\n", ptr, *ptr);

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

//debug prints the block
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

void *get_next_ptr(void *begin) {
	uint64_t *ptr = (uint64_t *)begin;
	if (ptr - 1 == NULL) {
		return NULL;
	}
	block b = get_block(begin);
	
	uint64_t *ptr_next = (uint64_t *)b.begin + BYTE_TO_WORD(b.block_bytes);
	if (ptr_next - 1 == NULL) {
		return NULL;
	}
	return (void *) ptr_next;
}
void *get_prev_ptr(void *begin) {
	uint64_t *ptr = (uint64_t *)begin;
	if (ptr - 1 == NULL) {
		return NULL;
	}
	if (ptr - 2 == NULL) {
		return NULL;
	}
	uint64_t *ptr_next = ptr - BYTE_TO_WORD((*(ptr - 2)) >> 1) - 2; // TODO fix this jumping to below base heap ptr

	return (void *) ptr_next;
}

// void *coalesce(void *begin) {
// 	printf("DEBUG: COALSESCE");
// 	block b = get_block(begin);
// 	print_block(begin);
// 	
// 	uint64_t *ptr = (uint64_t *) begin;
// 	uint64_
// }

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
 * mm_malloc - Allocate a block by incrementing the brk pointer.
 *     Always allocate a block whose size is a multiple of the alignment.
 */
void *mm_malloc(size_t size)
{
	assert(size < pagesize - WORD_TO_BYTE(10));

	size_t payload_bytes = ALIGN(size);
	size_t required_bytes = ALIGN(size + WORD_TO_BYTE(2));
	// always points to next usable memory region
	uint64_t *ptr = ((uint64_t *) begin + 3);
	// tracks bottom of current page
	//uint64_t **page = (uint64_t **) begin;

	printf("request payload %zu required_bytes %zu size %zu\n", payload_bytes, required_bytes, size);

	while(1) {
		
		block b = get_block((void *)ptr);

		printf("\n");

		print_block(get_prev_ptr(b.begin));
		print_block(b.begin);
		print_block(get_next_ptr(b.begin));
		
		if (*(ptr - 1) == 0) {
		
			// assuming sbrk is contiguous
			uint64_t *next_page = (uint64_t *) new_page();
			if (next_page == NULL) {
				return NULL;
			}
			
			assert(next_page == ptr + 1);
			
			//zeroheader
			*(next_page + (BYTE_TO_WORD(pagesize))-2) = 0;
			
			block y = {
				0,
				pagesize - WORD_TO_BYTE(2),
				pagesize,
				(void *) (next_page - 1)
			};
			ptr = set_block(y);
			// TODO coalesing with previous potential freeblock (once coalescing functionality exists)
			continue;
		}

		// block is free and of proper size
		if (!b.is_used && (b.block_bytes == required_bytes || b.block_bytes >= required_bytes + WORD_TO_BYTE(4))) {
			// block is free and of proper size;
			

			if (b.block_bytes == required_bytes) {
				block x = {
					1,
					payload_bytes,
					required_bytes,
					(void *) ptr
				};
				return set_block(x);
			} else {
				size_t remaining_bytes = b.block_bytes - required_bytes;

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
				return set_block(x);
			}
		} else {
			ptr += BYTE_TO_WORD(b.block_bytes);
		}
	}
}

/*
 * mm_free - Freeing a block does nothing.
 */
void mm_free(void *ptr)
{
}

/*
 * mm_realloc - Implemented simply in terms of mm_malloc and mm_free
 */
void *mm_realloc(void *ptr, size_t size)
{
    // void *oldptr = ptr;
    // void *newptr;
    // size_t copySize;
    // 
    // newptr = mm_malloc(size);
    // if (newptr == NULL)
    //   return NULL;
    // copySize = *(size_t *)((char *)oldptr - SIZE_T_SIZE);
    // if (size < copySize)
    //   copySize = size;
    // memcpy(newptr, oldptr, copySize);
    // mm_free(oldptr);
    // return newptr;
    return ptr;
}





