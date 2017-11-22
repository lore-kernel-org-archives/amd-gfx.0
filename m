From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/ttm: add page order support in ttm_pages_put
Date: Wed, 22 Nov 2017 11:00:30 +0100
Message-ID: <f046cb74-c7ee-0961-fdee-53b696261f91@gmail.com>
References: <1511342234-18570-1-git-send-email-Hongbo.He@amd.com>
 <1511342234-18570-3-git-send-email-Hongbo.He@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2AC675C4FF214130DDD5CADB"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511342234-18570-3-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------2AC675C4FF214130DDD5CADB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

That completely negates the advantage of setting write back on multiple 
pages at once.

In other words this way we wouldn't need the array any more at all and 
could remove the whole complicated handling.

I'm pretty close to saying just go ahead with that and even clean up the 
whole stuff with the static array, but I'm not sure if that doesn't 
result in some performance problems.

A possible alternative is the (untested) patch attached, this way we 
move the __free_page()/_free_pages() call out of ttm_pages_put and just 
need to add the correct number of pages to the array in the loop.

Regards,
Christian.

Am 22.11.2017 um 10:17 schrieb Roger He:
> Change-Id: Ia55b206d95812c5afcfd6cec29f580758d1f50f0
> Signed-off-by: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/ttm/ttm_page_alloc.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index 9b48b93..2dc83c0 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -299,13 +299,16 @@ static struct ttm_page_pool *ttm_get_pool(int flags, bool huge,
>   }
>   
>   /* set memory back to wb and free the pages. */
> -static void ttm_pages_put(struct page *pages[], unsigned npages)
> +static void ttm_pages_put(struct page *pages[], unsigned npages,
> +		unsigned int order)
>   {
> -	unsigned i;
> -	if (set_pages_array_wb(pages, npages))
> -		pr_err("Failed to set %d pages to wb!\n", npages);
> -	for (i = 0; i < npages; ++i)
> -		__free_page(pages[i]);
> +	unsigned int i, pages_nr = (1 << order);
> +
> +	for (i = 0; i < npages; ++i) {
> +		if (set_pages_wb(pages[i], pages_nr))
> +			pr_err("Failed to set %d pages to wb!\n", pages_nr);
> +		__free_pages(pages[i], order);
> +	}
>   }
>   
>   static void ttm_pool_update_free_locked(struct ttm_page_pool *pool,
> @@ -368,7 +371,7 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
>   			 */
>   			spin_unlock_irqrestore(&pool->lock, irq_flags);
>   
> -			ttm_pages_put(pages_to_free, freed_pages);
> +			ttm_pages_put(pages_to_free, freed_pages, pool->order);
>   			if (likely(nr_free != FREE_ALL_PAGES))
>   				nr_free -= freed_pages;
>   
> @@ -403,7 +406,7 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
>   	spin_unlock_irqrestore(&pool->lock, irq_flags);
>   
>   	if (freed_pages)
> -		ttm_pages_put(pages_to_free, freed_pages);
> +		ttm_pages_put(pages_to_free, freed_pages, pool->order);
>   out:
>   	if (pages_to_free != static_buf)
>   		kfree(pages_to_free);



--------------2AC675C4FF214130DDD5CADB
Content-Type: text/x-patch;
 name="0001-drm-ttm-move-__free_page-out-of-ttm_pages_put.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-ttm-move-__free_page-out-of-ttm_pages_put.patch"

>From 4fcc6c40e3596e12a9712b01a44d9c0265f04582 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 22 Nov 2017 10:54:58 +0100
Subject: [PATCH] drm/ttm: move __free_page out of ttm_pages_put
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This way we can easier free the pages with the right order.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index 72ea037b7090..4deb9c8441b5 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -286,11 +286,8 @@ static struct ttm_page_pool *ttm_get_pool(int flags, bool huge,
 /* set memory back to wb and free the pages. */
 static void ttm_pages_put(struct page *pages[], unsigned npages)
 {
-	unsigned i;
 	if (set_pages_array_wb(pages, npages))
 		pr_err("Failed to set %d pages to wb!\n", npages);
-	for (i = 0; i < npages; ++i)
-		__free_page(pages[i]);
 }
 
 static void ttm_pool_update_free_locked(struct ttm_page_pool *pool,
@@ -315,7 +312,8 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
 {
 	static struct page *static_buf[NUM_PAGES_TO_ALLOC];
 	unsigned long irq_flags;
-	struct page *p;
+	struct list_head freed;
+	struct page *p, *tmp;
 	struct page **pages_to_free;
 	unsigned freed_pages = 0,
 		 npages_to_free = nr_free;
@@ -333,6 +331,8 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
 		return 0;
 	}
 
+	INIT_LIST_HEAD(&freed);
+
 restart:
 	spin_lock_irqsave(&pool->lock, irq_flags);
 
@@ -345,6 +345,8 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
 		if (freed_pages >= NUM_PAGES_TO_ALLOC) {
 			/* remove range of pages from the pool */
 			__list_del(p->lru.prev, &pool->list);
+			/* and add to freed list */
+			__list_add(&p->lru, &freed, &freed);
 
 			ttm_pool_update_free_locked(pool, freed_pages);
 			/**
@@ -380,6 +382,8 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
 	/* remove range of pages from the pool */
 	if (freed_pages) {
 		__list_del(&p->lru, &pool->list);
+		/* and add to freed list */
+		__list_add(&p->lru, &freed, &freed);
 
 		ttm_pool_update_free_locked(pool, freed_pages);
 		nr_free -= freed_pages;
@@ -392,6 +396,10 @@ static int ttm_page_pool_free(struct ttm_page_pool *pool, unsigned nr_free,
 out:
 	if (pages_to_free != static_buf)
 		kfree(pages_to_free);
+
+	list_for_each_entry_safe(p, tmp, &freed, lru)
+		__free_page(p);
+
 	return nr_free;
 }
 
-- 
2.11.0


--------------2AC675C4FF214130DDD5CADB
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------2AC675C4FF214130DDD5CADB--
