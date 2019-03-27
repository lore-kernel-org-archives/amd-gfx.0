From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 125/192] drm/amd/display: Disconnect mpcc when changing tg
Date: Wed, 27 Mar 2019 14:09:17 -0400
Message-ID: <20190327181025.13507-125-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 77476360f173c127c191bfe8ca8113130ef283b8 ]

[Why]
This fixes an mpc programming error for the following sequence of
atomic commits when pipe split is enabled:

Commit 1: CRTC0 (plane 4, plane 3)

Pipe 0: old_plane_state = A0, new_plane_state = A1,   new_tg = T0
Pipe 1: old_plane_state = B0, new_plane_state = B1,   new_tg = T0
Pipe 2: old_plane_state = A0, new_plane_state = A1,   new_tg = T0
Pipe 3: old_plane_state = B0, new_plane_state = B1,   new_tg = T0

Commit 2: CRTC0 (plane 3), CRTC1 (plane 2)

Pipe 0: old_plane_state = A1, new_plane_state = A2,   new_tg = T0
Pipe 1: old_plane_state = B1, new_plane_state = B2,   new_tg = T1
Pipe 2: old_plane_state = A1, new_plane_state = NULL, new_tg = NULL
Pipe 3: old_plane_state = B1, new_plane_state = NULL, new_tg = NULL

In the second commit the assertion for mpcc in use is hit because
mpcc disconnect never occurs for pipe 1. This is because the stream
changes for pipe 1 and the opp_list is empty.

This sequence occurs when running the
"igt@kms_plane_multiple@atomic-pipe-A-tiling-none" test with two
displays connected.

[How]
Expand the reset condition to include:

"old_pipe_ctx->stream_res.tg != new_pipe_ctx->stream_res.tg"

...but only when the plane state is non-NULL for both old and new.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 4058b59d9bea..a0355709abd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2336,9 +2336,10 @@ static void dcn10_apply_ctx_for_surface(
 			}
 		}
 
-		if (!pipe_ctx->plane_state &&
-			old_pipe_ctx->plane_state &&
-			old_pipe_ctx->stream_res.tg == tg) {
+		if ((!pipe_ctx->plane_state ||
+		     pipe_ctx->stream_res.tg != old_pipe_ctx->stream_res.tg) &&
+		    old_pipe_ctx->plane_state &&
+		    old_pipe_ctx->stream_res.tg == tg) {
 
 			dc->hwss.plane_atomic_disconnect(dc, old_pipe_ctx);
 			removed_pipe[i] = true;
-- 
2.19.1
