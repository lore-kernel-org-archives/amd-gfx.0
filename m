From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Make calculate_integer_scaling static
Date: Mon, 28 Oct 2019 21:34:36 +0800
Message-ID: <20191028133436.30608-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Dmytro.Laktyushkin@amd.com, charlene.liu@amd.com, eric.bernstein@amd.com, Jun.Lei@amd.com, Anthony.Koo@amd.com, Reza.Amini@amd.com, Harmanprit.Tatla@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:963:6:
 warning: symbol 'calculate_integer_scaling' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 70e601a..3769830 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -960,7 +960,7 @@ static bool are_rects_integer_multiples(struct rect src, struct rect dest)
 	return false;
 }
 
-void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
+static void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
 {
 	if (!pipe_ctx->plane_state->scaling_quality.integer_scaling)
 		return;
-- 
2.7.4
