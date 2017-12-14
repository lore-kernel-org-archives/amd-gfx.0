From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH] drm/ttm: init locked again to prevent incorrect unlock
Date: Thu, 14 Dec 2017 11:15:39 +0800
Message-ID: <1513221339-9927-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Roger He <Hongbo.He@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Change-Id: Icc8b5112570429f24e90d52484df2728c546f85b
Signed-off-by: Roger He <Hongbo.He@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/ttm/ttm_bo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a3f908c..098b22e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -735,6 +735,7 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 								      place)) {
 				if (locked)
 					reservation_object_unlock(bo->resv);
+				locked = false;
 				continue;
 			}
 			break;
-- 
2.7.4
