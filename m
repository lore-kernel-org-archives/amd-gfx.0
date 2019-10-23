From: zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH] dc.c:use kzalloc without test
Date: Wed, 23 Oct 2019 16:32:23 +0800
Message-ID: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, David.Francis@amd.com, Dmytro.Laktyushkin@amd.com, anthony.koo@amd.com, Wenjing.Liu@amd.com, nicholas.kazlauskas@amd.com, Aidan.Wood@amd.com, Chris.Park@amd.com, Eric.Yang2@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, zhongshiqi <zhong.shiqi@zte.com.cn>
List-Id: amd-gfx.lists.freedesktop.org

dc.c:583:null check is needed after using kzalloc function

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d1aded..4b8819c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -580,6 +580,10 @@ static bool construct(struct dc *dc,
 #ifdef CONFIG_DRM_AMD_DC_DCN2_0
 	// Allocate memory for the vm_helper
 	dc->vm_helper = kzalloc(sizeof(struct vm_helper), GFP_KERNEL);
+	if (!dc->vm_helper) {
+		dm_error("%s: failed to create dc->vm_helper\n", __func__);
+		goto fail;
+	}
 
 #endif
 	memcpy(&dc->bb_overrides, &init_params->bb_overrides, sizeof(dc->bb_overrides));
-- 
2.9.5
