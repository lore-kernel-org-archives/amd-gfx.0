From: Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH] drm/amdgpu/display: fix compile error
Date: Thu, 17 Oct 2019 14:19:32 +0800
Message-ID: <1571293172-116998-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, alexander.deucher@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

From: Chenwandun <chenwandun@huawei.com>

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1913:48: error: struct dc_crtc_timing_flags has no member named DSC
   if (res_ctx->pipe_ctx[i].stream->timing.flags.DSC)
						^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1914:73: error: struct dc_crtc_timing has no member named dsc_cfg
   pipes[pipe_cnt].dout.output_bpp = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.bits_per_pixel / 16.0;
									^
Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 914e378..4f03318 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1910,8 +1910,10 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].dout.output_bpp = output_bpc * 3;
 		}
 
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		if (res_ctx->pipe_ctx[i].stream->timing.flags.DSC)
 			pipes[pipe_cnt].dout.output_bpp = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.bits_per_pixel / 16.0;
+#endif
 
 		/* todo: default max for now, until there is logic reflecting this in dc*/
 		pipes[pipe_cnt].dout.output_bpc = 12;
-- 
2.7.4
