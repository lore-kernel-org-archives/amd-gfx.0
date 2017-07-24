From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 14/14] amdgpu: powerplay: Remove unused structure
Date: Mon, 24 Jul 2017 15:35:40 +0200
Message-ID: <20170724133540.32200-15-ricardo.ribalda@gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, Edward O'Callaghan <funfunctor@folklore1984.net>, Kees Cook <keescook@chromium.org>, "Andrew F. Davis" <afd@ti.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Baoyou Xie <baoyou.xie@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Colin Ian King <colin.king@canonical.com>, =?UTF-8?q?Nils=20Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>, Joe Perches <joe@perches.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kern
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Remove unused structure definition amd_pp_display_configuration.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h | 40 -----------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
index ae49af5cc5d1..6b6f2f7c8527 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
@@ -191,46 +191,6 @@ struct single_display_configuration
 
 #define MAX_NUM_DISPLAY 32
 
-struct amd_pp_display_configuration {
-	bool nb_pstate_switch_disable;/* controls NB PState switch */
-	bool cpu_cc6_disable; /* controls CPU CState switch ( on or off) */
-	bool cpu_pstate_disable;
-	uint32_t cpu_pstate_separation_time;
-
-	uint32_t num_display;  /* total number of display*/
-	uint32_t num_path_including_non_display;
-	uint32_t crossfire_display_index;
-	uint32_t min_mem_set_clock;
-	uint32_t min_core_set_clock;
-	/* unit 10KHz x bit*/
-	uint32_t min_bus_bandwidth;
-	/* minimum required stutter sclk, in 10khz uint32_t ulMinCoreSetClk;*/
-	uint32_t min_core_set_clock_in_sr;
-
-	struct single_display_configuration displays[MAX_NUM_DISPLAY];
-
-	uint32_t vrefresh; /* for active display*/
-
-	uint32_t min_vblank_time; /* for active display*/
-	bool multi_monitor_in_sync;
-	/* Controller Index of primary display - used in MCLK SMC switching hang
-	 * SW Workaround*/
-	uint32_t crtc_index;
-	/* htotal*1000/pixelclk - used in MCLK SMC switching hang SW Workaround*/
-	uint32_t line_time_in_us;
-	bool invalid_vblank_time;
-
-	uint32_t display_clk;
-	/*
-	 * for given display configuration if multimonitormnsync == false then
-	 * Memory clock DPMS with this latency or below is allowed, DPMS with
-	 * higher latency not allowed.
-	 */
-	uint32_t dce_tolerable_mclk_in_active_latency;
-	uint32_t min_dcef_set_clk;
-	uint32_t min_dcef_deep_sleep_set_clk;
-};
-
 struct amd_pp_simple_clock_info {
 	uint32_t	engine_max_clock;
 	uint32_t	memory_max_clock;
-- 
2.13.2
