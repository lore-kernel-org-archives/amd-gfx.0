From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu/display: fix build error without CONFIG_DRM_AMD_DC_DSC_SUPPORT
Date: Mon, 26 Aug 2019 16:57:07 +0800
Message-ID: <20190826085707.12504-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jun.Lei@amd.com, Dmytro.Laktyushkin@amd.com, Bhawanpreet.Lakha@amd.com, joshua.aberback@amd.com, Wenjing.Liu@amd.com, charlene.liu@amd.com, martin.leung@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

If CONFIG_DRM_AMD_DC_DSC_SUPPORT is not set, build fails:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: In function dcn20_hw_sequencer_construct:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2099:28:
 error: dcn20_dsc_pg_control undeclared (first use in this function); did you mean dcn20_dpp_pg_control?
  dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
                            ^~~~~~~~~~~~~~~~~~~~
                            dcn20_dpp_pg_control

Use CONFIG_DRM_AMD_DC_DSC_SUPPORT to guard this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8a31820b1218 ("drm/amd/display: Make init_hw and init_pipes generic for seamless boot")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e146d1d..54d67f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2092,7 +2092,11 @@ void dcn20_hw_sequencer_construct(struct dc *dc)
 	dc->hwss.enable_power_gating_plane = dcn20_enable_power_gating_plane;
 	dc->hwss.dpp_pg_control = dcn20_dpp_pg_control;
 	dc->hwss.hubp_pg_control = dcn20_hubp_pg_control;
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 	dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
+#else
+	dc->hwss.dsc_pg_control = NULL;
+#endif
 	dc->hwss.disable_vga = dcn20_disable_vga;
 
 	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-- 
2.7.4
