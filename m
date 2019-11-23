From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use NULL for pointer assignment in copy_stream_update_to_stream
Date: Sat, 23 Nov 2019 12:36:39 -0700
Message-ID: <20191123193639.55297-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Nikola Cornij <nikola.cornij@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1965:26: warning:
expression which evaluates to zero treated as a null pointer constant of
type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
                                update->dsc_config = false;
                                                     ^~~~~
../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1971:25: warning:
expression which evaluates to zero treated as a null pointer constant of
type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
                        update->dsc_config = false;
                                             ^~~~~
2 warnings generated.

Fixes: f6fe4053b91f ("drm/amd/display: Use a temporary copy of the current state when updating DSC config")
Link: https://github.com/ClangBuiltLinux/linux/issues/777
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c7db4f4810c6..2645d20e8c4c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1962,13 +1962,13 @@ static void copy_stream_update_to_stream(struct dc *dc,
 			if (!dc->res_pool->funcs->validate_bandwidth(dc, dsc_validate_context, true)) {
 				stream->timing.dsc_cfg = old_dsc_cfg;
 				stream->timing.flags.DSC = old_dsc_enabled;
-				update->dsc_config = false;
+				update->dsc_config = NULL;
 			}
 
 			dc_release_state(dsc_validate_context);
 		} else {
 			DC_ERROR("Failed to allocate new validate context for DSC change\n");
-			update->dsc_config = false;
+			update->dsc_config = NULL;
 		}
 	}
 }
-- 
2.24.0
