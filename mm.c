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
	size_t bytes;
	void* begin;
} block;

// requests and initialises new pages
void *new_page(void) {
	
	uint64_t *ptr = mem_sbrk(pagesize);
	if (ptr == NULL) {
		return NULL;
	}
	
	// first page points to next page
	*ptr = (uint64_t)NULL;

	// initialise page as one large free-block
	// zerofooter: set to 0 as there exists no block beneath it
	*(ptr + 1) = 0;
	
	// header of free-block: set to total available space leftshiftet by 1, 0: free, 1: inuse 
	size_t avail_space = (pagesize-WORD_TO_BYTE(5)) << 1;
	*(ptr + 2)= avail_space;

	// footer of free-block: 
	*(ptr + (BYTE_TO_WORD(pagesize))-2) = avail_space;

	// zeroheader: set to 0 as there exists no block above it
	*(ptr + (BYTE_TO_WORD(pagesize))-1) = 0;

	return (void *) ptr;	
}

// initialises a block in the heap
void *set_block(block b) {
	uint64_t *ptr = (uint64_t *) b.begin;
	*ptr = b.bytes << 1 | b.is_used;
	*(ptr + BYTE_TO_WORD(b.bytes) -)

block get_block(void *begin) {
	uint64_t *ptr = (uint64_t *) begin;
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
	printf("pagesize: %zu, avail_space: %zu\n", pagesize, *((unsigned long *)begin + 2));
	return 0;	
}

/* 
 * mm_malloc - Allocate a block by incrementing the brk pointer.
 *     Always allocate a block whose size is a multiple of the alignment.
 */
void *mm_malloc(size_t size)
{

	size_t required_bytes = ALIGN(size + WORD_TO_BYTE(2));
	uint64_t *ptr = ((uint64_t *) begin + BYTE_TO_WORD(2));

	while() {
		
		block b = {
			*ptr & 0x1,
			*ptr >> 1,
			(void *)ptr
		};

		// block is free and of proper size
		if (!b.is_used && (b.size == required_bytes || b.size >= required_bytes + WORD_TO_BYTE(4))) { 
			
			// set to inuse
			*ptr += 1;
			
			// convenient case
			if (b.size == required_bytes) {
				return (void *) (ptr + WORD_TO_BYTE(8)); 
			} else {
				size_t remaining_bytes = b.size - required_bytes;

				block x = {

				};
				block y = {

				};
				
			}
			

			// set to inuse
			//*ptr += 1;
			 

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














