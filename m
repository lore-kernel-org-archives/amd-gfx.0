From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 60/83] drm/amd/display: fix PME notification not working in RV desktop
Date: Tue, 12 Feb 2019 21:36:38 -0500
Message-ID: <20190213023701.20286-60-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Charlene Liu <charlene.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Charlene Liu <charlene.liu@amd.com>

[ Upstream commit 20300db4aec5ba5edf6f0ad6f7111a51fbea7e10 ]

[Why]
PPLIB not receive the PME when unplug.

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0941f3c689bc..5f9492d8f0aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1000,7 +1000,7 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 
 		pipe_ctx->stream_res.audio->funcs->az_enable(pipe_ctx->stream_res.audio);
 
-		if (num_audio == 1 && pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
+		if (num_audio >= 1 && pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
 			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
 			pp_smu->set_pme_wa_enable(&pp_smu->pp_smu);
 		/* un-mute audio */
@@ -1017,6 +1017,8 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx, int option)
 	pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
 			pipe_ctx->stream_res.stream_enc, true);
 	if (pipe_ctx->stream_res.audio) {
+		struct pp_smu_funcs_rv *pp_smu = dc->res_pool->pp_smu;
+
 		if (option != KEEP_ACQUIRED_RESOURCE ||
 				!dc->debug.az_endpoint_mute_only) {
 			/*only disalbe az_endpoint if power down or free*/
@@ -1036,6 +1038,9 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx, int option)
 			update_audio_usage(&dc->current_state->res_ctx, dc->res_pool, pipe_ctx->stream_res.audio, false);
 			pipe_ctx->stream_res.audio = NULL;
 		}
+		if (pp_smu != NULL && pp_smu->set_pme_wa_enable != NULL)
+			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
+			pp_smu->set_pme_wa_enable(&pp_smu->pp_smu);
 
 		/* TODO: notify audio driver for if audio modes list changed
 		 * add audio mode list change flag */
-- 
2.19.1
