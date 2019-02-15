From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amd/display/dce_mem_input: Mark expected switch
 fall-through
Date: Fri, 15 Feb 2019 10:54:42 -0600
Message-ID: <20190215165442.GA30381@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 85686d917636..a24a2bda8656 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -479,7 +479,7 @@ static void program_grph_pixel_format(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		sign = 1;
 		floating = 1;
-		/* no break */
+		/* fall through */
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
 		grph_depth = 3;
-- 
2.20.1
