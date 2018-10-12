From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/radeon/r300: Mark expected switch fall-throughs
Date: Fri, 12 Oct 2018 18:12:36 +0200
Message-ID: <20181012161236.GA21768@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced "Pass through." with
"Fall through.", which is what GCC is expecting to find.

Addresses-Coverity-ID: 114734 ("Missing break in switch")
Addresses-Coverity-ID: 114735 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/radeon/r300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 21161aa..652126f 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -814,7 +814,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
 					  ((idx_value >> 21) & 0xF));
 				return -EINVAL;
 			}
-			/* Pass through. */
+			/* Fall through. */
 		case 6:
 			track->cb[i].cpp = 4;
 			break;
@@ -965,7 +965,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 			/* The same rules apply as for DXT3/5. */
-			/* Pass through. */
+			/* Fall through. */
 		case R300_TX_FORMAT_DXT3:
 		case R300_TX_FORMAT_DXT5:
 			track->textures[i].cpp = 1;
-- 
2.7.4
