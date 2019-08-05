From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] gpu: drm: amd: display: dc: dcn20: Remove redudant condition
Date: Mon, 5 Aug 2019 23:02:57 +0530
Message-ID: <20190805173257.GA4917@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nikola Cornij <nikola.cornij@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Colin Ian King <colin.king@canonical.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Remove redudant codition "dsc_cfg->dc_dsc_cfg.num_slices_v".

fixes coverity defect 1451853

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index e870caa..42133bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -302,7 +302,7 @@ static bool dsc_prepare_config(struct display_stream_compressor *dsc, const stru
 		    dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
 	ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
 
-	if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_v ||
+	if (!dsc_cfg->dc_dsc_cfg.num_slices_v ||
 		!(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
 		!dsc_cfg->pic_width || !dsc_cfg->pic_height ||
 		!((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
-- 
2.7.4
