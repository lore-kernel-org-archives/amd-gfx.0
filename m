From: Thomas Hellstrom <thomas@shipmail.org>
Subject: Re: [PATCH] drm/ttm: enable eviction for Per-VM-BO
Date: Fri, 15 Dec 2017 12:35:31 +0100
Message-ID: <63abed46-c23c-4eb8-30be-3d6cd50972eb@shipmail.org>
References: <1513239041-32734-1-git-send-email-Hongbo.He@amd.com>
 <89163c6a-6002-c3db-3680-3c7b19918b1c@shipmail.org>
 <fb224ee5-7762-e31f-224c-5f32d62f6793@amd.com>
 <cf03dbda-68f7-1423-3256-462f82c95a7b@shipmail.org>
 <bedd8993-78ef-cbe2-4aca-fa68d7f90b0a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------87071215BE9CFE08742F883C"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <bedd8993-78ef-cbe2-4aca-fa68d7f90b0a@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com, Roger He <Hongbo.He@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--------------87071215BE9CFE08742F883C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/2017 10:53 AM, Christian König wrote:
>
>> Well this is more or less replicating what you are doing currently 
>> but instead of spreading the checks and locking state all over the 
>> code, both as local variables and parameters this is keeping it in a 
>> single place with correctness checks.
>
> I don't see how that can be correct. 

In what sense? It should be doing *exactly* what you're doing now but 
use an abstraction. No more no less. But with correctness checks, and 
less of passing state around. Specifically what I'm referring to are 
things like the locking test this patch is proposing, the "locked" 
variable in ttm_mem_evict_first(), and the parameter special code in 
ttm_mem_cleanup_refs() that I think are hard to follow and error prone. 
Conditional locking like in ttm_mem_clenup_refs() also typically trip 
static lock balance checkers.

> As far as I can see it makes TTM responsible about locking again

No it doesn't. It's a helper. The only TTM state in my suggestion was 
the "bo::reserved"  debug variable, which could either be ommited or 
count the recursive reservation to aid making sure that all recursive 
reservations you do in TTM are undone in TTM.

> and to be honest TTM is a bloody mess regarding this already.

Hmm. IMO strong unspecific wording like this in a design descussions 
should be avoided. It tends to take away focus from what's actually 
being dicussed by making either part feel bad. And it's typically 
unproductive.


>
> My intention in the long term is rather to remove logic from TTM and 
> move it back into the drivers. The end result I have in mind is that 
> TTM becomes a toolbox instead of the midlayer it is currently.

I'm in favour of that. But I don't think what I proposed is a step away 
from that direction. On the contrary.  I've attached a POC patch with 
the correctness checks stripped, not compile-tested. Much easier to 
follow if you ask me, but if you feel so strongly against it, never mind.

Thanks,
Thomas


>
> Regards,
> Christian. qq
>
>>
>>
>> I agree recursive locking is generally frowned upon, but you're 
>> already doing it, not by using recursive locks, but by passing 
>> locking state around which IMO is worse.
>>
>> Collecting the state in a the operation_ctx will make that 
>> usage-pattern more obvious but will help make the code cleaner and 
>> less error prone.
>>
>> /Thomas
>>
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 15.12.2017 um 08:01 schrieb Thomas Hellstrom:
>>>> Roger and Chrisitian,
>>>>
>>>> Correct me if I'm wrong, but It seems to me like a lot of the 
>>>> recent changes to ttm_bo.c are to allow recursive reservation 
>>>> object locking in the case of shared reservation objects, but only 
>>>> in certain functions and with special arguments so it doesn't look 
>>>> like recursive locking to the lockdep checker. Wouldn't it be a lot 
>>>> cleaner if we were to hide all this in a resurrected 
>>>> __ttm_bo_reserve something along the lines of
>>>>
>>>> int __ttm_bo_reserve(struct ttm_bo *bo, struct ttm_operation_ctx 
>>>> *ctx) {
>>>>     if (ctx && ctx->resv == bo->resv) {
>>>> #ifdef CONFIG_LOCKDEP
>>>>         WARN_ON(bo->reserved);
>>>> lockdep_assert_held(&ctx->resv);
>>>>         ctx->reserve_count++;
>>>> bo->reserved = true;
>>>> #endif
>>>>         return0;
>>>>      } else {
>>>>         int ret = reservation_object_lock(bo->resv, NULL) ? 0:-EBUSY;
>>>>
>>>>         if (ret)
>>>>             return ret;
>>>> #ifdef CONFIG_LOCKDEP
>>>>         WARN_ON(bo->reserved);
>>>>         bo->reserved = true;
>>>> #endif
>>>>         return 0;
>>>> }
>>>>
>>>> And similar for tryreserve and unreserve? Perhaps with a 
>>>> ww_acquire_ctx included somewhere as well...
>>>>
>>>> /Thomas
>>>>
>>>>
>>>>
>>>>
>>>> On 12/14/2017 09:10 AM, Roger He wrote:
>>>>> Change-Id: I0c6ece0decd18d30ccc94e5c7ca106d351941c62
>>>>> Signed-off-by: Roger He <Hongbo.He@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/ttm/ttm_bo.c | 11 +++++------
>>>>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c 
>>>>> b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> index 098b22e..ba5b486 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> @@ -707,7 +707,6 @@ bool ttm_bo_eviction_valuable(struct 
>>>>> ttm_buffer_object *bo,
>>>>>   EXPORT_SYMBOL(ttm_bo_eviction_valuable);
>>>>>     static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
>>>>> -                   struct reservation_object *resv,
>>>>>                      uint32_t mem_type,
>>>>>                      const struct ttm_place *place,
>>>>>                      struct ttm_operation_ctx *ctx)
>>>>> @@ -722,8 +721,9 @@ static int ttm_mem_evict_first(struct 
>>>>> ttm_bo_device *bdev,
>>>>>       spin_lock(&glob->lru_lock);
>>>>>       for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
>>>>>           list_for_each_entry(bo, &man->lru[i], lru) {
>>>>> -            if (bo->resv == resv) {
>>>>> -                if (list_empty(&bo->ddestroy))
>>>>> +            if (bo->resv == ctx->resv) {
>>>>> +                if (!ctx->allow_reserved_eviction &&
>>>>> +                    list_empty(&bo->ddestroy))
>>>>>                       continue;
>>>>>               } else {
>>>>>                   locked = reservation_object_trylock(bo->resv);
>>>>> @@ -835,7 +835,7 @@ static int ttm_bo_mem_force_space(struct 
>>>>> ttm_buffer_object *bo,
>>>>>               return ret;
>>>>>           if (mem->mm_node)
>>>>>               break;
>>>>> -        ret = ttm_mem_evict_first(bdev, bo->resv, mem_type, 
>>>>> place, ctx);
>>>>> +        ret = ttm_mem_evict_first(bdev, mem_type, place, ctx);
>>>>>           if (unlikely(ret != 0))
>>>>>               return ret;
>>>>>       } while (1);
>>>>> @@ -1332,8 +1332,7 @@ static int ttm_bo_force_list_clean(struct 
>>>>> ttm_bo_device *bdev,
>>>>>       for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
>>>>>           while (!list_empty(&man->lru[i])) {
>>>>>               spin_unlock(&glob->lru_lock);
>>>>> -            ret = ttm_mem_evict_first(bdev, NULL, mem_type,
>>>>> -                          NULL, &ctx);
>>>>> +            ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
>>>>>               if (ret)
>>>>>                   return ret;
>>>>>               spin_lock(&glob->lru_lock);
>>>>
>>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------87071215BE9CFE08742F883C
Content-Type: text/x-patch;
 name="0001-drm-ttm-tryreserve_shared-POC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-ttm-tryreserve_shared-POC.patch"

>From 3d992baf41109fcedc311a97b13186076827d7f0 Mon Sep 17 00:00:00 2001
From: Thomas Hellstrom <thellstrom@vmware.com>
Date: Fri, 15 Dec 2017 12:24:50 +0100
Subject: [PATCH] drm/ttm tryreserve_shared POC.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d6986b9..f2102d2 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -46,6 +46,31 @@
 #define TTM_DEBUG(fmt, arg...)
 #define TTM_BO_HASH_ORDER 13
 
+
+static int __ttm_bo_reserve_shared(struct ttm_bo *bo, struct ttm_operation_ctx *ctx)
+{
+	if (ctx && ctx->resv == bo->resv)
+		return 0;
+	else
+		return reservation_object_lock(bo->resv, NULL) ? 0 : -EBUSY;
+}
+
+static bool __ttm_bo_tryreserve_shared(struct ttm_bo *bo, struct ttm_operation_ctx *ctx)
+{
+	if (ctx && ctx->resv == bo->resv)
+		return true;
+	else
+		return reservation_object_trylock(bo->resv, NULL);
+}
+
+static void __ttm_bo_unreserve_shared(struct ttm_bo *bo, struct ttm_operation_ctx *ctx)
+{
+	if (ctx && ctx->resv == bo->resv)
+		return;
+	else
+		reservation_object_unlock(bo->resv);
+}
+
 static int ttm_bo_swapout(struct ttm_mem_shrink *shrink);
 static void ttm_bo_global_kobj_release(struct kobject *kobj);
 
@@ -491,16 +516,14 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
  * If not idle, do nothing.
  *
  * Must be called with lru_lock and reservation held, this function
- * will drop the lru lock and optionally the reservation lock before returning.
+ * will drop the lru lock before returning.
  *
  * @interruptible         Any sleeps should occur interruptibly.
  * @no_wait_gpu           Never wait for gpu. Return -EBUSY instead.
- * @unlock_resv           Unlock the reservation lock as well.
  */
-
-static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
-			       bool interruptible, bool no_wait_gpu,
-			       bool unlock_resv)
+static int ttm_bo_cleanup_refs_and_unlock(struct ttm_buffer_object *bo,
+					  bool interruptible, bool no_wait_gpu,
+					  struct ttm_operation_ctc *ctx)
 {
 	struct ttm_bo_global *glob = bo->glob;
 	struct reservation_object *resv;
@@ -519,8 +542,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	if (ret && !no_wait_gpu) {
 		long lret;
 
-		if (unlock_resv)
-			reservation_object_unlock(bo->resv);
+		__ttm_bo_unreserve_shared(bo, ctx);
 		spin_unlock(&glob->lru_lock);
 
 		lret = reservation_object_wait_timeout_rcu(resv, true,
@@ -533,7 +555,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 			return -EBUSY;
 
 		spin_lock(&glob->lru_lock);
-		if (unlock_resv && !reservation_object_trylock(bo->resv)) {
+		if (!__ttm_bo_tryreserve_shared(bo, ctx)) {
 			/*
 			 * We raced, and lost, someone else holds the reservation now,
 			 * and is probably busy in ttm_bo_cleanup_memtype_use.
@@ -549,8 +571,6 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	}
 
 	if (ret || unlikely(list_empty(&bo->ddestroy))) {
-		if (unlock_resv)
-			reservation_object_unlock(bo->resv);
 		spin_unlock(&glob->lru_lock);
 		return ret;
 	}
@@ -562,9 +582,6 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	spin_unlock(&glob->lru_lock);
 	ttm_bo_cleanup_memtype_use(bo);
 
-	if (unlock_resv)
-		reservation_object_unlock(bo->resv);
-
 	return 0;
 }
 
@@ -593,7 +610,8 @@ static bool ttm_bo_delayed_delete(struct ttm_bo_device *bdev, bool remove_all)
 		reservation_object_lock(bo->resv, NULL);
 
 		spin_lock(&glob->lru_lock);
-		ttm_bo_cleanup_refs(bo, false, !remove_all, true);
+		ttm_bo_cleanup_refs_and_unlock(bo, false, !remove_all, NULL);
+		reservation_object_unlock(bo->resv);
 
 		kref_put(&bo->list_kref, ttm_bo_release_list);
 		spin_lock(&glob->lru_lock);
@@ -709,6 +727,7 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
 static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
+			       struct reservation_object *resv,
 			       uint32_t mem_type,
 			       const struct ttm_place *place,
 			       struct ttm_operation_ctx *ctx)
@@ -716,27 +735,18 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 	struct ttm_bo_global *glob = bdev->glob;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
 	struct ttm_buffer_object *bo = NULL;
-	bool locked = false;
 	unsigned i;
 	int ret;
 
 	spin_lock(&glob->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
 		list_for_each_entry(bo, &man->lru[i], lru) {
-			if (bo->resv == ctx->resv) {
-				if (!ctx->allow_reserved_eviction &&
-				    list_empty(&bo->ddestroy))
-					continue;
-			} else {
-				locked = reservation_object_trylock(bo->resv);
-				if (!locked)
-					continue;
-			}
+			if (!__ttm_bo_tryreserve_shared(bo, ctx))
+				continue;
 
 			if (place && !bdev->driver->eviction_valuable(bo,
 								      place)) {
-				if (locked)
-					reservation_object_unlock(bo->resv);
+				__ttm_bo_unreserve_shared(bo);
 				continue;
 			}
 			break;
@@ -757,8 +767,8 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 	kref_get(&bo->list_kref);
 
 	if (!list_empty(&bo->ddestroy)) {
-		ret = ttm_bo_cleanup_refs(bo, ctx->interruptible,
-					  ctx->no_wait_gpu, locked);
+		ret = ttm_bo_cleanup_refs_and_unlock(bo, ctx->interruptible,
+						     ctx->no_wait_gpu, ctx);
 		kref_put(&bo->list_kref, ttm_bo_release_list);
 		return ret;
 	}
-- 
2.9.5


--------------87071215BE9CFE08742F883C
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------87071215BE9CFE08742F883C--
