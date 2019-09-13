From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: rename variable eanble -> enable
Date: Fri, 13 Sep 2019 09:02:48 +0100
Message-ID: <20190913080248.28695-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the variable name eanble,
rename it to enable.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 1488ffddf4e3..5944524faab9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -606,11 +606,11 @@ static void dce_mi_allocate_dmif(
 	}
 
 	if (dce_mi->wa.single_head_rdreq_dmif_limit) {
-		uint32_t eanble =  (total_stream_num > 1) ? 0 :
+		uint32_t enable =  (total_stream_num > 1) ? 0 :
 				dce_mi->wa.single_head_rdreq_dmif_limit;
 
 		REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
-				ENABLE, eanble);
+				ENABLE, enable);
 	}
 }
 
@@ -636,11 +636,11 @@ static void dce_mi_free_dmif(
 			10, 3500);
 
 	if (dce_mi->wa.single_head_rdreq_dmif_limit) {
-		uint32_t eanble =  (total_stream_num > 1) ? 0 :
+		uint32_t enable =  (total_stream_num > 1) ? 0 :
 				dce_mi->wa.single_head_rdreq_dmif_limit;
 
 		REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
-				ENABLE, eanble);
+				ENABLE, enable);
 	}
 }
 
-- 
2.20.1
