From: Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  amdgpu/dcn10 : fix compile warning
Date: Sat, 15 Sep 2018 23:46:57 +0800
Message-ID: <1537026417-3798-1-git-send-email-peng.hao2@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:
    In function ‘dcn10_update_mpcc’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9:
    warning: missing braces around initializer [-Wmissing-braces]

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cfcc54f..a06a035 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct mpcc_blnd_cfg blnd_cfg = {0};
+	struct mpcc_blnd_cfg blnd_cfg = { {0} };
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
 	int mpcc_id;
 	struct mpcc *new_mpcc;
-- 
1.8.3.1
