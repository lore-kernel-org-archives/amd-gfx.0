From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: lock/unlock mismatch in ttm_bo.c
Date: Tue, 23 Jan 2018 14:25:20 -0500
Message-ID: <6c1faffd-5347-5763-e377-fd18f2e65928@amd.com>
References: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
 <81e40cdf-6869-57fa-6858-eb77dbfb45a8@amd.com>
 <57fdd509-5de6-a7d8-9588-cb2c63b8f451@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------8F4655812D9325756B414422"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57fdd509-5de6-a7d8-9588-cb2c63b8f451-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------8F4655812D9325756B414422
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/01/18 01:42 AM, Chunming Zhou wrote:
> 
> 
> On 2018年01月20日 02:23, Tom St Denis wrote:
>> On 19/01/18 01:14 PM, Tom St Denis wrote:
>>> Hi all,
>>>
>>> In the function ttm_bo_cleanup_refs() it seems possible to get to 
>>> line 551 without entering the block on 516 which means you'll be 
>>> unlocking a mutex that wasn't locked.
>>>
>>> Now it might be that in the course of the API this pattern cannot be 
>>> expressed but it's not clear from the function alone that that is the 
>>> case.
>>
>>
>> Looking further it seems the behaviour depends on locking in parent 
>> callers.  That's kinda a no-no right?  Shouldn't the lock be 
>> taken/released in the same function ideally?
> Same feelings
> 
> Regards,
> David Zhou

Attached is a patch that addresses this.

I can't see any obvious race in functions that call 
ttm_bo_cleanup_refs() between the time they let go of the lock and the 
time it's taken again in the call.

Running it on my system doesn't produce anything notable though the 
KASAN with DRI_PRIME=1 issue is still there (this patch neither causes 
that nor fixes it).

Tom

--------------8F4655812D9325756B414422
Content-Type: text/x-patch;
 name="0001-drm-ttm-Force-lock-to-be-taken-released-inside-ttm_b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-ttm-Force-lock-to-be-taken-released-inside-ttm_b.pa";
 filename*1="tch"

>From 017ebff407e8d9313f09e4ddd109ac54c3a23fba Mon Sep 17 00:00:00 2001
From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 22 Jan 2018 06:54:21 -0500
Subject: [PATCH] drm/ttm: Force lock to be taken/released inside
 ttm_bo_cleanup_refs()

The function ttm_bo_cleanup_refs() had conditional behaviour on
the global LRU lock taken outside the function.

This patch changes it so the lock is always untaken before the
function ttm_bo_cleanup_refs() is called and the function takes
the lock itself.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d33a6bb742a1..cbc4277eb76f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -487,9 +487,6 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
  * If bo idle, remove from delayed- and lru lists, and unref.
  * If not idle, do nothing.
  *
- * Must be called with lru_lock and reservation held, this function
- * will drop the lru lock and optionally the reservation lock before returning.
- *
  * @interruptible         Any sleeps should occur interruptibly.
  * @no_wait_gpu           Never wait for gpu. Return -EBUSY instead.
  * @unlock_resv           Unlock the reservation lock as well.
@@ -503,6 +500,8 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	struct reservation_object *resv;
 	int ret;
 
+	spin_lock(&glob->lru_lock);
+
 	if (unlikely(list_empty(&bo->ddestroy)))
 		resv = bo->resv;
 	else
@@ -586,17 +585,12 @@ static bool ttm_bo_delayed_delete(struct ttm_bo_device *bdev, bool remove_all)
 		kref_get(&bo->list_kref);
 		list_move_tail(&bo->ddestroy, &removed);
 
+		spin_unlock(&glob->lru_lock);
 		if (remove_all || bo->resv != &bo->ttm_resv) {
-			spin_unlock(&glob->lru_lock);
 			reservation_object_lock(bo->resv, NULL);
-
-			spin_lock(&glob->lru_lock);
 			ttm_bo_cleanup_refs(bo, false, !remove_all, true);
-
 		} else if (reservation_object_trylock(bo->resv)) {
 			ttm_bo_cleanup_refs(bo, false, !remove_all, true);
-		} else {
-			spin_unlock(&glob->lru_lock);
 		}
 
 		kref_put(&bo->list_kref, ttm_bo_release_list);
@@ -782,6 +776,7 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 	kref_get(&bo->list_kref);
 
 	if (!list_empty(&bo->ddestroy)) {
+		spin_unlock(&glob->lru_lock);
 		ret = ttm_bo_cleanup_refs(bo, ctx->interruptible,
 					  ctx->no_wait_gpu, locked);
 		kref_put(&bo->list_kref, ttm_bo_release_list);
@@ -1730,6 +1725,7 @@ int ttm_bo_swapout(struct ttm_bo_global *glob, struct ttm_operation_ctx *ctx)
 	kref_get(&bo->list_kref);
 
 	if (!list_empty(&bo->ddestroy)) {
+		spin_unlock(&glob->lru_lock);
 		ret = ttm_bo_cleanup_refs(bo, false, false, locked);
 		kref_put(&bo->list_kref, ttm_bo_release_list);
 		return ret;
-- 
2.14.3


--------------8F4655812D9325756B414422
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------8F4655812D9325756B414422--
