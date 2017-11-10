From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amd/display/dc/dce110/dce110_mem_input_v: use swap macro
 in program_size_and_rotation
Date: Fri, 10 Nov 2017 16:31:09 -0600
Message-ID: <20171110223109.GA31549@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Make use of the swap macro instead of _manually_ swapping values
and remove unnecessary variable swap.

This makes the code easier to read and maintain.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c | 28 +++++++---------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index a06c602..7bab8c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -237,26 +237,14 @@ static void program_size_and_rotation(
 	if (rotation == ROTATION_ANGLE_90 ||
 		rotation == ROTATION_ANGLE_270) {
 
-		uint32_t swap;
-		swap = local_size.video.luma_size.x;
-		local_size.video.luma_size.x =
-			local_size.video.luma_size.y;
-		local_size.video.luma_size.y  = swap;
-
-		swap = local_size.video.luma_size.width;
-		local_size.video.luma_size.width =
-			local_size.video.luma_size.height;
-		local_size.video.luma_size.height = swap;
-
-		swap = local_size.video.chroma_size.x;
-		local_size.video.chroma_size.x =
-			local_size.video.chroma_size.y;
-		local_size.video.chroma_size.y  = swap;
-
-		swap = local_size.video.chroma_size.width;
-		local_size.video.chroma_size.width =
-			local_size.video.chroma_size.height;
-		local_size.video.chroma_size.height = swap;
+		swap(local_size.video.luma_size.x,
+		     local_size.video.luma_size.y);
+		swap(local_size.video.luma_size.width,
+		     local_size.video.luma_size.height);
+		swap(local_size.video.chroma_size.x,
+		     local_size.video.chroma_size.y);
+		swap(local_size.video.chroma_size.width,
+		     local_size.video.chroma_size.height);
 	}
 
 	value = 0;
-- 
2.7.4
