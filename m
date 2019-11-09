From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
Date: Sat, 9 Nov 2019 17:35:38 +0800
Message-ID: <20191109093538.23964-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, Anthony.Koo@amd.com, Zhan.Liu@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
 variable bpc set but not used [-Wunused-but-set-variable]

It is not used since commit e49f69363adf ("drm/amd/display: use
proper formula to calculate bandwidth from timing")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bdc8be3..53394e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2653,13 +2653,11 @@ static int get_color_depth(enum dc_color_depth color_depth)
 
 static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t bpc;
 	uint64_t kbps;
 	struct fixed31_32 peak_kbps;
 	uint32_t numerator;
 	uint32_t denominator;
 
-	bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
 	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
 
 	/*
-- 
2.7.4
