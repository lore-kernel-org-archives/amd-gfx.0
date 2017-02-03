From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Subject: drm/ttm: Fix unused variable warning
Date: Fri, 3 Feb 2017 12:16:31 -0500
Message-ID: <124f223e-07df-197e-6126-8787c8b06406@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------95618E3AA507DDFF23191A06"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------95618E3AA507DDFF23191A06
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

This cleans up a remnant from Christian's patch (drm/ttm: revert "add 
optional LRU removal callback v2")

  Kent


--------------95618E3AA507DDFF23191A06
Content-Type: text/x-patch;
	name="0001-drm-ttm-Fix-unused-variable-warning.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-drm-ttm-Fix-unused-variable-warning.patch"

>From dfdf89a8dff0e378db6fa9578f75b02eec02ca0e Mon Sep 17 00:00:00 2001
From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 31 Jan 2017 06:44:10 -0500
Subject: [PATCH] drm/ttm: Fix unused variable warning

Remove an unused variable in ttm_bo

Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index dfaeac4..bdb5812 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -230,7 +230,6 @@ EXPORT_SYMBOL(ttm_bo_del_sub_from_lru);
 
 void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo)
 {
-	struct ttm_bo_device *bdev = bo->bdev;
 	int put_count = 0;
 
 	lockdep_assert_held(&bo->resv->lock.base);
-- 
2.7.4


--------------95618E3AA507DDFF23191A06
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------95618E3AA507DDFF23191A06--
