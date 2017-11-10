From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amd/display/dc/core/dc_resource: use swap macro in
 rect_swap_helper
Date: Fri, 10 Nov 2017 16:38:13 -0600
Message-ID: <20171110223813.GA32508@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Make use of the swap macro instead of _manually_ swapping values
and remove unnecessary variable temp.

This makes the code easier to read and maintain.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d1cdf9f..ee216f2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -426,15 +426,8 @@ static enum pixel_format convert_pixel_format_to_dalsurface(
 
 static void rect_swap_helper(struct rect *rect)
 {
-	uint32_t temp = 0;
-
-	temp = rect->height;
-	rect->height = rect->width;
-	rect->width = temp;
-
-	temp = rect->x;
-	rect->x = rect->y;
-	rect->y = temp;
+	swap(rect->height, rect->width);
+	swap(rect->x, rect->y);
 }
 
 static void calculate_viewport(struct pipe_ctx *pipe_ctx)
-- 
2.7.4
