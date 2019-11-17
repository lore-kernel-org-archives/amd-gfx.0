From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] drm/amd/display: Fix error returned by program_hpd_filter
Date: Sun, 17 Nov 2019 11:22:34 -0600
Message-ID: <20191117172236.2140-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Jun Lei <Jun.Lei@amd.com>, David Francis <David.Francis@amd.com>, Eric Yang <Eric.Yang2@amd.com>, Nikola Cornij <nikola.cornij@amd.com>, Eric Bernstein <eric.bernstein@amd.com>, Chris Park <Chris.Park@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>, David Galiffi <david.galiffi@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.or
List-Id: amd-gfx.lists.freedesktop.org

program_hpd_filter() currently fails to check for the errors
returned in construct(). This patch returns error in
case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca20b150afcc..bbb648a50c41 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1379,9 +1379,8 @@ static bool construct(
 	 * If GPIO isn't programmed correctly HPD might not rise or drain
 	 * fast enough, leading to bounces.
 	 */
-	program_hpd_filter(link);
+	return program_hpd_filter(link);
 
-	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
 link_enc_create_fail:
-- 
2.17.1
