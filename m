From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2] drm/amd/display: fix struct init in update_bounding_box
Date: Wed, 28 Aug 2019 12:37:58 -0600
Message-ID: <20190828183758.11553-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Raul E Rangel <rrangel@chromium.org>, Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, hersen wu <hersenxs.wu@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nikola Cornij <nikola.cornij@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Harry Wentland <harry.wentland@amd.com>, Charlene Liu <charlene.liu@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Jun Lei <Jun.Lei@amd.com>, Daniel Vetter <daniel@ffwll.ch>
List-Id: amd-gfx.lists.freedesktop.org

dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
  struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
         ^
Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
So apparently `{}` is a gcc extension. The C standard requires at least
one expression. So {{0}} is correct. I got a lint error about {{0}}
needing a space, so i use `{ {0} }`.

Changes in v2:
- Use { {0} } instead of {}

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb..8e6433be2252 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
 static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
+	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = { {0} };
 	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
-- 
2.23.0.187.g17f5b7556c-goog
