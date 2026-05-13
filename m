Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2314CD4F3E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6755E10EED7;
	Wed, 13 May 2026 14:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxigJEZL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A766F10EEBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mdr+HPm0+FzC5TAkwTpH8nZRpkeNdNMFRmsxOt4aMx95EMqQ6ALu+yHuI7VPMFX2yU6HxHIy9dluAtWx99PZQuL98GEx3buB52zCEXo1JCCQMD0cBEd+Hkk9i45LnigiX9L02oCZWnwtZfF6aQ2TJKG1+4pYRq0lbU8CgmWjQCvn1M5hcmbILPDi0HiPmxCHRL46meGgR7tU5xsoa4sEKS2ixv84l5lCUIjd40xJX7FsJovUu7uoTspyp7DFcQmiL90KSTH7lKxBo0SO0J9S1j13uKl2DZExnESiQ9DEtek5utxvbxzHCdW2BVtNzs6FyUzAEQTcko8LV98qgEx59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWUs1ZnvWxGsZMMWDWPniE9pdwOIDzWnpGuhMhU5rng=;
 b=Rp/qST9Rnbjsr2KYEUib+YgHbxqc51io9vdzrujmdvLeJDMN4HQQqrwxBMQy/6SlZKlyxKqrakdg5pasXVvxg5iozOQUYUQPRV3alYGQx5f6JzGj4cdfobsmQwfUKBdF1g+O50IvNJXocjT0PbHQVtLl829tzJmKXVx9CGwiO34X2ZHXu7t54GtcF4tQ6IBvUrvs0e00HinhLzd2QBwBhFCGf0gG4aJ3QuJyEZFsbeIlWwaKVPcVpvuxr1p4kj/QbItSbnSBSl9HJ3VLNDdULAFbUQh1cjJXy24AyVyhwdLJwl49g9rkDSnFJ0IYtHgypRqCLKu9gEANrXrGaTtibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWUs1ZnvWxGsZMMWDWPniE9pdwOIDzWnpGuhMhU5rng=;
 b=HxigJEZLGuBAZ1n9W+gNcLjQaQxhmEx0S/xPtNEl5gn5ns2m+Hzc95scqxAoJaXn1vdHPvXxHzXaUdblEEEjCdl1lgneRotOPz6BjjwXbY3hCgkIiHEc/Aa8Hnc/khPyrTWiYULx+Vn5OqjBi1p35ikz9yRH3vYVqqRUlk708cE=
Received: from CYZPR19CA0015.namprd19.prod.outlook.com (2603:10b6:930:8e::11)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:33:29 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::bc) by CYZPR19CA0015.outlook.office365.com
 (2603:10b6:930:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:23 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:22 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Lohita Mudimela <lohita.mudimela@amd.com>, "Anthony
 Koo" <anthony.koo@amd.com>
Subject: [PATCH 13/28] drm/amd/display: Refactor PSR functionality into
 dedicated power_psr module
Date: Wed, 13 May 2026 10:29:35 -0400
Message-ID: <20260513143213.1852892-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: eb52f948-5325-4726-1205-08deb0fc995a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|20052099010|11063799003|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nHen3tWKSjaXCVp1UYivUyKxh43yg1vRAT1GxpKJqvHa1SPa98j487pcBTRoYqGLhuEUZynUdXCE2DgHTxDvRHrcWkP+5jdpKo8gq7z+eYNvW5qva1M+A66yEV9kf52+iJxoDRflKpOc+90ip3Op2Ams0iCdTkyi2y1SWlltdcmG5KHx68/GN/S9CP4v1hPQBbZp+NiWG+iPyQXBuYr6UpaE1PydyHV/YQuXF4cyDqb7EFLQZytedNAfXFARFr+BWX9yvJ3OViz3JDMZ8tDRaEjSh9Eppf6TH9qPCvjjFyWwJXnjDNHc/LeksqD7Cpe7E6EgyPBtlKc9W/N7M3BYimKWoq3hip/lUjBim+NtKfV5o8sCTuvJSFGMxpw5XzVAWHP8Kh3whnxyJ98e/k+1DldDX4PyR+v4ZhyQygMimgiEhBgWcGXjG8NCpuXi7t5nLwiyQA+3GsZADiOQV6YFTlIR/O1sDA2iknOQ/g6OcL3Gq8GEgL3n8WA2nBsX/Rl9bBR0tMezMTn9hA+5KIXufbU20Zhuz9/CjypTp5hqV124i0PyY1hxG0HAUmaMA0uHUc0xImXKglTCTmtT09mI7uiB6BS/+Vx/HGinmH03SQpowHas9n4xB2qd3xVCjzr4pMwDm8FdT+gQLo0BdahwtfVrA2U7+cWI76EzRAxllfa9F+11HaGnpeZ0HJ+/4Oux5xvm9i/MlGZIUqtG0q+pTAGI8UU2TjMoVWjCiCHnh3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(20052099010)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BqttN7O8PA0Bmz5iUH8L9+55tM8wfckPdrZgTLgnmVHAlJ4aATZ1xYY5ELOYUX5ZgVeI6rUZS1ovnc0ruTElXTs5Dt6UHkCze779nltMkrEhFyP2xxlqyBjM6zjrUHRn6Oe5J1hzAJKzzHdMGsvMfoEyzBa38zxa1WeFAyX23McvI8q5oXNIbDnFIwr81uaw9/UbDqwGVtzC89TCj0KdslbLOxAuw+JXoBNdoDIYtKTvneicMG+4JiIv7V77pxk+hXFwAUcn6SKg2YHmD+C/xMtumrrtvtFdR+A0ChnAtwHL6b18ApYguSLGqF+7zNavnePwhLmdClM6e8emCXcJVZPZ9XRMyY1lP3JnczhINY1TvM+Of4aBD2CNUHiLdAE+G0638t+0oHUJQ55mOfeErBqIpOZU17kp2QMRFEOeijmrEMHaGx5skxfAMM63rd7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:28.3996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb52f948-5325-4726-1205-08deb0fc995a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lohita Mudimela <lohita.mudimela@amd.com>

[Why]
Extract all PSR (Panel Self Refresh) related functions from power.c
into a new power_psr.c module for better code organization and
maintainability.

[How]
Create new power_psr.c file containing all PSR-related functions
moved from power.c. Remove static qualifier from shared functions
to enable cross-file access:
- psr_context_to_mod_power_psr_context: Convert PSR context to
  module power PSR context
- map_index_from_stream: Map stream to power entity index
- delay_two_frames: Wait for two frame periods

Add function declarations to header. Maintain forward declaration of struct
core_power for type compatibility.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/modules/inc/mod_power.h   |  23 -
 .../drm/amd/display/modules/power/Makefile    |   2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 562 +--------------
 .../drm/amd/display/modules/power/power_abm.c |  96 ---
 .../amd/display/modules/power/power_helpers.c | 158 -----
 .../amd/display/modules/power/power_helpers.h | 116 +++
 .../drm/amd/display/modules/power/power_psr.c | 665 ++++++++++++++++++
 7 files changed, 785 insertions(+), 837 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_psr.c

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 440e4284b6f0..f9814cf7bbdb 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -414,27 +414,4 @@ bool mod_power_backlight_nits_to_percent(struct mod_power *mod_power,
 		unsigned int backlight_millinit,
 		unsigned int *backlight_millipercent);
 
-void initialize_backlight_caps(struct core_power *core_power, unsigned int inst);
-
-unsigned int backlight_millipercent_to_pwm(
-		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
-
-unsigned int backlight_millipercent_to_millinit(
-		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
-
-void fill_backlight_level_params(struct core_power *core_power,
-	struct set_backlight_level_params *backlight_level_params,
-	int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
-	enum backlight_control_type backlight_control_type,
-	unsigned int backlight_millinit, unsigned int transition_time_millisec,
-	bool is_hdr);
-
-bool mod_power_hw_init_backlight(struct mod_power *mod_power);
-
-void mod_power_update_backlight_on_mode_change(
-    struct core_power *core_power,
-    struct dc_link *link,
-    unsigned int panel_inst,
-    uint8_t aux_inst,
-    bool is_hdr);
 #endif /* MODULES_INC_MOD_POWER_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
index dd11f7d5617d..fc4ba5873fad 100644
--- a/drivers/gpu/drm/amd/display/modules/power/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'power' sub-module of DAL.
 #
 
-MOD_POWER = power_helpers.o power.o power_abm.o
+MOD_POWER = power_helpers.o power.o power_abm.o power_psr.o
 
 AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
 #$(info ************  DAL POWER MODULE MAKEFILE ************)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index f8a0b252c745..214ecc1f550d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -42,101 +42,6 @@
 #define SMOOTH_BRIGHTNESS_ADJUSTMENT_TIME_IN_MS 500
 #define LOW_REFRESH_RATE_DURATION_US_UPPER_BOUND 25000
 
-
-struct backlight_state {
-	/* HW uses u16.16 format for backlight PWM */
-	unsigned int backlight_pwm;
-	/* DM may call power module to set backlight
-	 * targeting percent brightness
-	 */
-	unsigned int backlight_millipercent;
-	/* DM may call power module to set backlight based on an explicit
-	 * nits value.
-	 */
-	unsigned int backlight_millinit;
-	unsigned int frame_ramp;
-	bool smooth_brightness_enabled;
-	bool isHDR;
-};
-struct power_entity {
-	struct dc_stream_state *stream;
-	struct psr_caps *caps;
-	struct mod_power_psr_context *psr_context;
-
-	/*PSR cached properties*/
-	bool psr_enabled;
-	unsigned int psr_events;
-	unsigned int psr_power_opt;
-	unsigned int replay_events;
-};
-
-struct pwr_backlight_properties {
-	bool use_nits_based_brightness;
-	bool disable_fractional_pwm;
-
-	unsigned int min_abm_backlight;
-	unsigned int num_backlight_levels;
-
-	bool backlight_ramping_override;
-	unsigned int backlight_ramping_reduction;
-	unsigned int backlight_ramping_start;
-
-	/* Backlight cached properties */
-	unsigned int ac_backlight_percent;
-	unsigned int dc_backlight_percent;
-
-	/* backlight LUT stored in HW u16.16 format*/
-	unsigned int *backlight_lut;
-	unsigned int min_backlight_pwm;
-	unsigned int max_backlight_pwm;
-	unsigned int backlight_range;
-
-	/* Describes the panel's min and max luminance in millinits measured
-	 * on full white screen, in min and max backlight settings.
-	 */
-	unsigned int min_brightness_millinits;
-	unsigned int max_brightness_millinits;
-	unsigned int nits_range;
-
-	bool backlight_caps_valid;
-	bool use_custom_backlight_caps;
-	unsigned int custom_backlight_caps_config_no;
-	bool use_linear_backlight_curve;
-};
-
-struct dmcu_varibright_cached_properties {
-	unsigned int varibright_config_setting;
-	unsigned int varibright_level;
-	unsigned int varibright_hw_level;
-	unsigned int def_varibright_level;
-	bool varibright_user_enable;
-	bool varibright_active;
-};
-
-struct core_power {
-	struct mod_power mod_public;
-	struct dc *dc;
-	struct power_entity *map;
-	struct dmcu_varibright_cached_properties varibright_prop;
-	struct pwr_backlight_properties bl_prop[MAX_NUM_EDP];
-	struct backlight_state bl_state[MAX_NUM_EDP];
-	unsigned int edp_num;
-
-	bool psr_smu_optimizations_support;
-	bool multi_disp_optimizations_support;
-
-	unsigned int num_entities;
-};
-
-union dmcu_abm_set_bl_params {
-	struct {
-		unsigned int gradual_change : 1; /* [0:0] */
-		unsigned int reserved : 15; /* [15:1] */
-		unsigned int frame_ramp : 16; /* [31:16] */
-	} bits;
-	unsigned int u32All;
-};
-
 /* If system or panel does not report some sort of brightness percent to nits
  * mapping, we will use following default values so backlight control using
  * nits based interfaces will still work, but might not describe panel
@@ -155,24 +60,10 @@ static const unsigned int default_dc_backlight_percent   = 70;
 #define MOD_POWER_TO_CORE(mod_power)\
 		container_of(mod_power, struct core_power, mod_public)
 
-static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
-{
-	/* Initialize fail-safe to 2 static frames. */
-	unsigned int num_frames_static = 2;
-
-	/* Calculate number of frames such that at least 30 ms has passed.
-	 * Round up to ensure the static period is not shorter than 30 ms.
-	 */
-	if (vsync_rate_hz != 0)
-		num_frames_static = DIV_ROUND_UP(30000 * vsync_rate_hz, 1000000);
-
-	return num_frames_static;
-}
-
 /* Given a specific dc_stream* this function finds its equivalent
  * on the core_freesync->map and returns the corresponding index
  */
-static unsigned int map_index_from_stream(struct core_power *core_power,
+unsigned int map_index_from_stream(struct core_power *core_power,
 		const struct dc_stream_state *stream)
 {
 	unsigned int index = 0;
@@ -572,11 +463,8 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,
 	unsigned int stream_index = 0;
 	struct core_power *core_power = NULL;
 	struct dc_link *link = NULL;
-	struct psr_config psr_config = {0};
-	struct psr_context psr_context = {0};
 	struct dc *dc = NULL;
 	unsigned int panel_inst = 0;
-	int active_psr_events = 0;
 	int active_replay_events = 0;
 
 	if ((mod_power == NULL) || (stream == NULL))
@@ -594,7 +482,6 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,
 
 	dc = core_power->dc;
 	link = dc_stream_get_link(stream);
-	active_psr_events = core_power->map[stream_index].psr_events;
 	active_replay_events = core_power->map[stream_index].replay_events;
 	if (link != NULL && dc_get_edp_link_panel_inst(dc, link, &panel_inst)) {
 		ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
@@ -602,38 +489,8 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,
 
 		mod_power_update_backlight_on_mode_change(core_power, link, panel_inst, aux_inst, is_hdr);
 
-		mod_power_calc_psr_configs(&psr_config, link, stream);
-
-		psr_config.psr_exit_link_training_required = core_power->map[stream_index].caps->psr_exit_link_training_required;
-
-		if (dc->ctx->asic_id.chip_family >= AMDGPU_FAMILY_GC_11_0_1)
-			psr_config.allow_smu_optimizations =
-					core_power->psr_smu_optimizations_support && dc_is_embedded_signal(stream->signal);
-		else
-			psr_config.allow_smu_optimizations =
-					core_power->psr_smu_optimizations_support && mod_power_only_edp(dc->current_state, stream);
-
-		psr_config.allow_multi_disp_optimizations = core_power->multi_disp_optimizations_support;
-
-		psr_config.rate_control_caps = core_power->map[stream_index].caps->rate_control_caps;
-
-		if (active_psr_events & psr_event_os_request_force_ffu) {
-			psr_config.os_request_force_ffu = true;
-		}
-		/*
-		* DSC support:
-		* DSC slice height value must be 'mod' by su_y_granularity.
-		* According to Panel Vendor, there might be varied conditions to fulfill.
-		* Right now, DSC slice height value must be multiple of su_y_granularity.
-		*
-		* The value of DSC slice height is determined in DSC Driver but it does not
-		* propagated out here, so we need to calculate it as below 'slice_height'.
-		*/
-		psr_su_set_dsc_slice_height(dc, link,
-					(struct dc_stream_state *) stream,
-					&psr_config);
-
-		dc_link_setup_psr(link, stream, &psr_config, &psr_context);
+		/* Handle PSR notification */
+		mod_power_psr_notify_mode_change(mod_power, stream, link, stream_index);
 
 		link->replay_settings.replay_smu_opt_enable =
 			(link->replay_settings.config.replay_smu_opt_supported &&
@@ -650,419 +507,6 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,
 	return true;
 }
 
-static void mod_power_psr_set_power_opt(struct mod_power *mod_power,
-	struct dc_stream_state *stream,
-	unsigned int active_psr_events,
-	bool psr_enable_request)
-{
-	(void)psr_enable_request;
-	struct core_power *core_power = NULL;
-	struct dc_link *link = NULL;
-	unsigned int stream_index = 0;
-	unsigned int power_opt = 0;
-
-	if (!stream)
-		return;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	stream_index = map_index_from_stream(core_power, stream);
-	if (!core_power->map[stream_index].caps->psr_version)
-		return;
-
-	link = dc_stream_get_link(stream);
-
-	if (active_psr_events == 0) {
-		/* Static Screen */
-		power_opt |= (psr_power_opt_smu_opt_static_screen | psr_power_opt_z10_static_screen |
-					psr_power_opt_ds_disable_allow);
-	}
-
-	/* psr_power_opt_flag is a configuration parameter into the module that determines
-	 * which optimizations to enable during psr
-	 */
-	power_opt &= core_power->map[stream_index].caps->psr_power_opt_flag;
-	if (core_power->map[stream_index].psr_power_opt != power_opt) {
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
-				WPP_BIT_FLAG_Firmware_PsrState,
-				"mod_power set_power_opt: psr_power_opt=0x%04x, power_opt=0x%04x"
-				"active_psr_events=0x%04x, psr_power_opt_flag=0x%04x",
-				core_power->map[stream_index].psr_power_opt,
-				power_opt,
-				active_psr_events,
-				core_power->map[stream_index].caps->psr_power_opt_flag);
-		dc_link_set_psr_allow_active(link, NULL, false, false, &power_opt);
-		core_power->map[stream_index].psr_power_opt = power_opt;
-	}
-}
-
-static bool set_psr_enable(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		bool psr_enable,
-		bool wait,
-		bool force_static)
-{
-	struct core_power *core_power = NULL;
-	enum dc_psr_state state = PSR_STATE0;
-	unsigned int retry_count;
-	const unsigned int max_retry = 1000;
-	struct dc_link *link = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0) {
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: ERROR: stream=%p num_entities=%u",
-							stream,
-							core_power->num_entities);
-		return false;
-	}
-
-	if (psr_enable)	{
-		unsigned int vsync_rate_hz;
-		struct dc_static_screen_params params = {0};
-
-		vsync_rate_hz = (unsigned int)div_u64(div_u64((
-				stream->timing.pix_clk_100hz * 100),
-				stream->timing.v_total),
-				stream->timing.h_total);
-
-		params.triggers.cursor_update = true;
-		params.triggers.overlay_update = true;
-		params.triggers.surface_update = true;
-		params.num_frames = calc_psr_num_static_frames(vsync_rate_hz);
-
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: CALCS: pix_clk_100hz=%u v_total=%u h_total=%u vsync_rate_hz=%u num_frames=%u",
-							stream->timing.pix_clk_100hz,
-							stream->timing.v_total,
-							stream->timing.h_total,
-							vsync_rate_hz,
-							params.num_frames);
-
-		dc_stream_set_static_screen_params(core_power->dc,
-						   &stream, 1,
-						   &params);
-	}
-
-	link = dc_stream_get_link(stream);
-
-	if (!dc_link_set_psr_allow_active(link, &psr_enable, false, force_static, NULL)) {
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: ERROR: stream=%p link=%p psr_enable=%d",
-							stream,
-							link,
-							psr_enable);
-		return false;
-	}
-
-	if (wait == true) {
-
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: BEGIN WAIT: psr_enable=%d",
-							(int)psr_enable);
-
-		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
-			dc_link_get_psr_state(link, &state);
-			if (psr_enable) {
-				if (state != PSR_STATE0 &&
-						(!force_static || state == PSR_STATE3))
-					break;
-			} else {
-				if (state == PSR_STATE0)
-					break;
-			}
-			udelay(500);
-		}
-
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: END WAIT: psr_enable=%d",
-							(int)psr_enable);
-
-		/* assert if max retry hit */
-		if (retry_count >= max_retry) {
-			ASSERT(0);
-			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-								WPP_BIT_FLAG_Firmware_PsrState,
-								"set psr enable: ERROR: retry_count=%u: Unexpectedly long wait for PSR state change.",
-								retry_count);
-		}
-	} else {
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: PSR state change initiated (wait=false): psr_enable=%d",
-							(int)psr_enable);
-	}
-
-	return true;
-}
-
-bool mod_power_get_psr_event(struct mod_power *mod_power,
-			struct dc_stream_state *stream,
-			unsigned int *active_psr_events)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (!core_power->map[stream_index].caps->psr_version)
-		return false;
-
-	*active_psr_events = core_power->map[stream_index].psr_events;
-
-	return true;
-}
-
-bool mod_power_set_psr_event(struct mod_power *mod_power,
-		struct dc_stream_state *stream, bool set_event,
-		enum psr_event event, bool wait)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-	unsigned int active_psr_events = 0;
-	bool psr_enable_request = false;
-	bool force_static = false;
-
-	if (mod_power == NULL || stream == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (core_power->num_entities == 0) {
-		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-							WPP_BIT_FLAG_Firmware_PsrState,
-							"mod_power set_psr_event: ERROR: stream=%p event=%d num_entities=%u",
-							stream,
-							(int)event,
-							core_power->num_entities);
-		return false;
-	}
-
-	if (!core_power->map[stream_index].caps->psr_version)
-		return false;
-
-	if (set_event)
-		core_power->map[stream_index].psr_events |= event;
-	else
-		core_power->map[stream_index].psr_events &= ~event;
-
-	active_psr_events = core_power->map[stream_index].psr_events;
-
-	// ignore other events when we're in forced psr enabled state
-	if (active_psr_events & psr_event_dynamic_display_switch &&
-			event != psr_event_dynamic_display_switch)
-		return false;
-
-	// ignore other events when we're in forced psr enabled state
-	if (active_psr_events & psr_event_os_override_hold &&
-			event != psr_event_os_override_hold)
-		return false;
-
-	// ignore other events when we're in forced psr enabled state
-	// dds events need to be processed while in dynamic_link_rate_control
-	if (active_psr_events & psr_event_dynamic_link_rate_control &&
-			event != psr_event_dynamic_link_rate_control &&
-			event != psr_event_dds_defer_stream_enable &&
-			event != psr_event_dynamic_display_switch)
-		return false;
-
-	if (active_psr_events & (psr_event_test_harness_disable_psr | psr_event_os_request_disable))
-		psr_enable_request = false;
-	else if (active_psr_events & psr_event_pause)
-		psr_enable_request = false;
-	else if (active_psr_events & psr_event_test_harness_enable_psr)
-		psr_enable_request = true;
-	else if (active_psr_events & psr_event_dynamic_display_switch) {
-		psr_enable_request = true;
-		force_static = true;
-	} else if (active_psr_events & psr_event_dynamic_link_rate_control) {
-		psr_enable_request = true;
-		force_static = true;
-	} else if (active_psr_events & psr_event_edp_panel_off_disable_psr)
-		psr_enable_request = false;
-	else if (active_psr_events & (psr_event_hw_programming |
-			psr_event_defer_enable |
-			psr_event_dds_defer_stream_enable |
-			psr_event_vrr_transition |
-			psr_event_immediate_flip))
-		psr_enable_request = false;
-	else if (active_psr_events & psr_event_big_screen_video)
-		psr_enable_request = true;
-	else if (active_psr_events & psr_event_full_screen)
-		psr_enable_request = false;
-	else if (active_psr_events & psr_event_mpo_video_selective_update)
-		psr_enable_request = true;
-	else if (active_psr_events & psr_event_vsync)
-		psr_enable_request = false;
-	else if (active_psr_events & psr_event_crc_window_active)
-		psr_enable_request = false;
-	else
-		psr_enable_request = true;
-
-	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
-						WPP_BIT_FLAG_Firmware_PsrState,
-						"mod_power set_psr_event: before: psr_enabled=%d -> request: set_event=%d event=0x%04x -> result: psr_events=0x%04x psr_enable_request=%d",
-						(int)core_power->map[stream_index].psr_enabled,
-						(int)set_event,
-						(unsigned int)event,
-						(unsigned int)core_power->map[stream_index].psr_events,
-						(int)psr_enable_request);
-	mod_power_psr_set_power_opt(mod_power, stream, active_psr_events, psr_enable_request);
-
-	if (core_power->map[stream_index].psr_enabled != psr_enable_request || force_static) {
-		if (set_psr_enable(mod_power, stream, psr_enable_request, wait, force_static)) {
-			core_power->map[stream_index].psr_enabled = psr_enable_request;
-		}
-	}
-
-	return true;
-}
-
-bool mod_power_get_psr_state(struct mod_power *mod_power,
-		const struct dc_stream_state *stream,
-		enum dc_psr_state *state)
-{
-	struct core_power *core_power = NULL;
-	const struct dc_link *link = NULL;
-
-	if (!stream)
-		return false;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	link = dc_stream_get_link(stream);
-	return dc_link_get_psr_state(link, state);
-}
-
-bool mod_power_get_psr_enabled_status(struct mod_power *mod_power,
-		const struct dc_stream_state *stream,
-		bool *psr_enabled)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (!core_power->map[stream_index].caps->psr_version)
-		return false;
-
-	*psr_enabled = core_power->map[stream_index].psr_enabled;
-
-	return true;
-}
-
-void mod_power_psr_residency(struct mod_power *mod_power,
-		const struct dc_stream_state *stream,
-		unsigned int *residency,
-		const uint8_t mode)
-{
-	struct core_power *core_power = NULL;
-	const struct dc_link *link = NULL;
-
-	if (!stream)
-		return;
-
-	if (mod_power == NULL)
-		return;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return;
-
-	link = dc_stream_get_link(stream);
-
-	if (link != NULL)
-		link->dc->link_srv->edp_get_psr_residency(link, residency, mode);
-}
-bool mod_power_psr_get_active_psr_events(struct mod_power *mod_power,
-		const struct dc_stream_state *stream, unsigned int *active_psr_events)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-
-	if (!stream)
-		return false;
-
-	if (mod_power == NULL)
-		return false;
-
-	if (active_psr_events == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	*active_psr_events = core_power->map[stream_index].psr_events;
-	return true;
-}
-
-bool mod_power_psr_set_sink_vtotal_in_psr_active(struct mod_power *mod_power,
-		const struct dc_stream_state *stream,
-		uint16_t psr_vtotal_idle,
-		uint16_t psr_vtotal_su)
-{
-	struct core_power *core_power = NULL;
-	unsigned int stream_index = 0;
-	const struct dc_link *link = NULL;
-
-	if (!stream)
-		return false;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (!core_power->map[stream_index].caps->psr_version)
-		return false;
-
-	link = dc_stream_get_link(stream);
-
-	return link->dc->link_srv->edp_set_sink_vtotal_in_psr_active(
-			link, psr_vtotal_idle, psr_vtotal_su);
-}
-
 static bool mod_power_set_replay_active(struct dc_stream_state *stream,
 	bool replay_active,
 	bool wait,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index c41ace406519..8ed7ce26476e 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -233,102 +233,6 @@ struct iram_table_v_2_2 {
 #define MOD_POWER_MAX_CONCURRENT_STREAMS 32
 #define SMOOTH_BRIGHTNESS_ADJUSTMENT_TIME_IN_MS 500
 
-
-
-struct backlight_state {
-	/* HW uses u16.16 format for backlight PWM */
-	unsigned int backlight_pwm;
-	/* DM may call power module to set backlight
-	 * targeting percent brightness
-	 */
-	unsigned int backlight_millipercent;
-	/* DM may call power module to set backlight based on an explicit
-	 * nits value.
-	 */
-	unsigned int backlight_millinit;
-	unsigned int frame_ramp;
-	bool smooth_brightness_enabled;
-	bool isHDR;
-};
-struct power_entity {
-	struct dc_stream_state *stream;
-	struct psr_caps *caps;
-	struct mod_power_psr_context *psr_context;
-
-	/*PSR cached properties*/
-	bool psr_enabled;
-	unsigned int psr_events;
-	unsigned int psr_power_opt;
-	unsigned int replay_events;
-};
-
-struct pwr_backlight_properties {
-	bool use_nits_based_brightness;
-	bool disable_fractional_pwm;
-
-	unsigned int min_abm_backlight;
-	unsigned int num_backlight_levels;
-
-	bool backlight_ramping_override;
-	unsigned int backlight_ramping_reduction;
-	unsigned int backlight_ramping_start;
-
-	/* Backlight cached properties */
-	unsigned int ac_backlight_percent;
-	unsigned int dc_backlight_percent;
-
-	/* backlight LUT stored in HW u16.16 format*/
-	unsigned int *backlight_lut;
-	unsigned int min_backlight_pwm;
-	unsigned int max_backlight_pwm;
-	unsigned int backlight_range;
-
-	/* Describes the panel's min and max luminance in millinits measured
-	 * on full white screen, in min and max backlight settings.
-	 */
-	unsigned int min_brightness_millinits;
-	unsigned int max_brightness_millinits;
-	unsigned int nits_range;
-
-	bool backlight_caps_valid;
-	bool use_custom_backlight_caps;
-	unsigned int custom_backlight_caps_config_no;
-	bool use_linear_backlight_curve;
-};
-
-struct dmcu_varibright_cached_properties {
-	unsigned int varibright_config_setting;
-	unsigned int varibright_level;
-	unsigned int varibright_hw_level;
-	unsigned int def_varibright_level;
-	bool varibright_user_enable;
-	bool varibright_active;
-};
-
-struct core_power {
-	struct mod_power mod_public;
-	struct dc *dc;
-	struct power_entity *map;
-	struct dmcu_varibright_cached_properties varibright_prop;
-	struct pwr_backlight_properties bl_prop[MAX_NUM_EDP];
-	struct backlight_state bl_state[MAX_NUM_EDP];
-	unsigned int edp_num;
-
-	bool psr_smu_optimizations_support;
-	bool multi_disp_optimizations_support;
-
-	unsigned int num_entities;
-};
-
-union dmcu_abm_set_bl_params {
-	struct {
-		unsigned int gradual_change : 1; /* [0:0] */
-		unsigned int reserved : 15; /* [15:1] */
-		unsigned int frame_ramp : 16; /* [31:16] */
-	} bits;
-	unsigned int u32All;
-};
-
 /* If system or panel does not report some sort of brightness percent to nits
  * mapping, we will use following default values so backlight control using
  * nits based interfaces will still work, but might not describe panel
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 1046fc35f8f9..2fc2e2929e95 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -33,129 +33,6 @@
 #define bswap16_based_on_endian(big_endian, value) \
 	((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
 
-/*
- * is_psr_su_specific_panel() - check if sink is AMD vendor-specific PSR-SU
- * supported eDP device.
- *
- * @link: dc link pointer
- *
- * Return: true if AMDGPU vendor specific PSR-SU eDP panel
- */
-bool is_psr_su_specific_panel(struct dc_link *link)
-{
-	bool isPSRSUSupported = false;
-	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
-
-	if (dpcd_caps->edp_rev >= DP_EDP_14) {
-		if (dpcd_caps->psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
-			isPSRSUSupported = true;
-		/*
-		 * Some panels will report PSR capabilities over additional DPCD bits.
-		 * Such panels are approved despite reporting only PSR v3, as long as
-		 * the additional bits are reported.
-		 */
-		if (dpcd_caps->sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8) {
-			/*
-			 * This is the temporary workaround to disable PSRSU when system turned on
-			 * DSC function on the sepcific sink.
-			 */
-			if (dpcd_caps->psr_info.psr_version < DP_PSR2_WITH_Y_COORD_IS_SUPPORTED)
-				isPSRSUSupported = false;
-			else if (dpcd_caps->dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
-				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
-				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
-				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
-				isPSRSUSupported = false;
-			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
-				isPSRSUSupported = true;
-		}
-	}
-
-	return isPSRSUSupported;
-}
-
-/**
- * mod_power_calc_psr_configs() - calculate/update generic psr configuration fields.
- * @psr_config: [output], psr configuration structure to be updated
- * @link: [input] dc link pointer
- * @stream: [input] dc stream state pointer
- *
- * calculate and update the psr configuration fields that are not DM specific, i.e. such
- * fields which are based on DPCD caps or timing information. To setup PSR in DMUB FW,
- * this helper is assumed to be called before the call of the DC helper dc_link_setup_psr().
- *
- * PSR config fields to be updated within the helper:
- * - psr_rfb_setup_time
- * - psr_sdp_transmit_line_num_deadline
- * - line_time_in_us
- * - su_y_granularity
- * - su_granularity_required
- * - psr_frame_capture_indication_req
- * - psr_exit_link_training_required
- *
- * PSR config fields that are DM specific and NOT updated within the helper:
- * - allow_smu_optimizations
- * - allow_multi_disp_optimizations
- */
-void mod_power_calc_psr_configs(struct psr_config *psr_config,
-		struct dc_link *link,
-		const struct dc_stream_state *stream)
-{
-	unsigned int num_vblank_lines = 0;
-	unsigned int vblank_time_in_us = 0;
-	unsigned int sdp_tx_deadline_in_us = 0;
-	unsigned int line_time_in_us = 0;
-	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
-	const int psr_setup_time_step_in_us = 55;	/* refer to eDP spec DPCD 0x071h */
-
-	/* timing parameters */
-	num_vblank_lines = stream->timing.v_total -
-			 stream->timing.v_addressable -
-			 stream->timing.v_border_top -
-			 stream->timing.v_border_bottom;
-
-	vblank_time_in_us = (stream->timing.h_total * num_vblank_lines * 1000) / (stream->timing.pix_clk_100hz / 10);
-
-	line_time_in_us = ((stream->timing.h_total * 1000) / (stream->timing.pix_clk_100hz / 10)) + 1;
-
-	/**
-	 * psr configuration fields
-	 *
-	 * as per eDP 1.5 pg. 377 of 459, DPCD 0x071h bits [3:1], psr setup time bits interpreted as below
-	 * 000b <--> 330 us (default)
-	 * 001b <--> 275 us
-	 * 010b <--> 220 us
-	 * 011b <--> 165 us
-	 * 100b <--> 110 us
-	 * 101b <--> 055 us
-	 * 110b <--> 000 us
-	 */
-	psr_config->psr_rfb_setup_time =
-		(6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME) * psr_setup_time_step_in_us;
-
-	if (psr_config->psr_rfb_setup_time > vblank_time_in_us) {
-		link->psr_settings.psr_frame_capture_indication_req = true;
-		link->psr_settings.psr_sdp_transmit_line_num_deadline = num_vblank_lines;
-	} else {
-		sdp_tx_deadline_in_us = vblank_time_in_us - psr_config->psr_rfb_setup_time;
-
-		/* Set the last possible line SDP may be transmitted without violating the RFB setup time */
-		link->psr_settings.psr_frame_capture_indication_req = false;
-		link->psr_settings.psr_sdp_transmit_line_num_deadline = sdp_tx_deadline_in_us / line_time_in_us;
-	}
-
-	psr_config->psr_sdp_transmit_line_num_deadline = link->psr_settings.psr_sdp_transmit_line_num_deadline;
-	psr_config->line_time_in_us = line_time_in_us;
-	psr_config->su_y_granularity = dpcd_caps->psr_info.psr2_su_y_granularity_cap;
-	psr_config->su_granularity_required = dpcd_caps->psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED;
-	psr_config->psr_frame_capture_indication_req = link->psr_settings.psr_frame_capture_indication_req;
-	psr_config->psr_exit_link_training_required =
-		!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
-}
-
 void init_replay_config(struct dc_link *link, struct replay_config *pr_config)
 {
 	link->replay_settings.config = *pr_config;
@@ -166,41 +43,6 @@ bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_s
 	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
 }
 
-bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
-			      struct dc_stream_state *stream,
-			      struct psr_config *config)
-{
-	uint32_t pic_height;
-	uint32_t slice_height;
-
-	config->dsc_slice_height = 0;
-	if (!(link->connector_signal & SIGNAL_TYPE_EDP) ||
-	    !dc->caps.edp_dsc_support ||
-	    link->panel_config.dsc.disable_dsc_edp ||
-	    !link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
-	    !stream->timing.dsc_cfg.num_slices_v)
-		return true;
-
-	pic_height = stream->timing.v_addressable +
-		stream->timing.v_border_top + stream->timing.v_border_bottom;
-
-	if (stream->timing.dsc_cfg.num_slices_v == 0)
-		return false;
-
-	slice_height = pic_height / stream->timing.dsc_cfg.num_slices_v;
-	config->dsc_slice_height = (uint16_t)slice_height;
-
-	if (slice_height) {
-		if (config->su_y_granularity &&
-		    (slice_height % config->su_y_granularity)) {
-			ASSERT(0);
-			return false;
-		}
-	}
-
-	return true;
-}
-
 void set_replay_frame_skip_number(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint32_t coasting_vtotal_refresh_rate_uhz,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 94d2521355ce..3a2ba87be706 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -47,7 +47,99 @@ struct dmcu_iram_parameters {
 	unsigned int min_abm_backlight;
 	unsigned int set;
 };
+struct backlight_state {
+	/* HW uses u16.16 format for backlight PWM */
+	unsigned int backlight_pwm;
+	/* DM may call power module to set backlight
+	 * targeting percent brightness
+	 */
+	unsigned int backlight_millipercent;
+	/* DM may call power module to set backlight based on an explicit
+	 * nits value.
+	 */
+	unsigned int backlight_millinit;
+	unsigned int frame_ramp;
+	bool smooth_brightness_enabled;
+	bool isHDR;
+};
+struct power_entity {
+	struct dc_stream_state *stream;
+	struct psr_caps *caps;
+	struct mod_power_psr_context *psr_context;
+
+	/*PSR cached properties*/
+	bool psr_enabled;
+	unsigned int psr_events;
+	unsigned int psr_power_opt;
+	unsigned int replay_events;
+};
+
+struct pwr_backlight_properties {
+	bool use_nits_based_brightness;
+	bool disable_fractional_pwm;
+
+	unsigned int min_abm_backlight;
+	unsigned int num_backlight_levels;
+
+	bool backlight_ramping_override;
+	unsigned int backlight_ramping_reduction;
+	unsigned int backlight_ramping_start;
+
+	/* Backlight cached properties */
+	unsigned int ac_backlight_percent;
+	unsigned int dc_backlight_percent;
+
+	/* backlight LUT stored in HW u16.16 format*/
+	unsigned int *backlight_lut;
+	unsigned int min_backlight_pwm;
+	unsigned int max_backlight_pwm;
+	unsigned int backlight_range;
 
+	/* Describes the panel's min and max luminance in millinits measured
+	 * on full white screen, in min and max backlight settings.
+	 */
+	unsigned int min_brightness_millinits;
+	unsigned int max_brightness_millinits;
+	unsigned int nits_range;
+
+	bool backlight_caps_valid;
+	bool use_custom_backlight_caps;
+	unsigned int custom_backlight_caps_config_no;
+	bool use_linear_backlight_curve;
+};
+
+struct dmcu_varibright_cached_properties {
+	unsigned int varibright_config_setting;
+	unsigned int varibright_level;
+	unsigned int varibright_hw_level;
+	unsigned int def_varibright_level;
+	bool varibright_user_enable;
+	bool varibright_active;
+};
+
+struct core_power {
+	struct mod_power mod_public;
+	struct dc *dc;
+	struct power_entity *map;
+	struct dmcu_varibright_cached_properties varibright_prop;
+	struct pwr_backlight_properties bl_prop[MAX_NUM_EDP];
+	struct backlight_state bl_state[MAX_NUM_EDP];
+	unsigned int edp_num;
+
+	bool psr_smu_optimizations_support;
+	bool multi_disp_optimizations_support;
+
+	unsigned int num_entities;
+};
+
+union dmcu_abm_set_bl_params {
+	struct {
+		unsigned int gradual_change : 1; /* [0:0] */
+		unsigned int reserved : 15; /* [15:1] */
+		unsigned int frame_ramp : 16; /* [31:16] */
+	} bits;
+	unsigned int u32All;
+};
 bool dmcu_load_iram(struct dmcu *dmcu,
 		struct dmcu_iram_parameters params);
 bool dmub_init_abm_config(struct resource_pool *res_pool,
@@ -87,4 +179,28 @@ bool fill_custom_backlight_caps(unsigned int config_no,
 void reset_replay_dsync_error_count(struct dc_link *link);
 void change_replay_to_psr(struct dc_link *link);
 void change_psr_to_replay(struct dc_link *link);
+void initialize_backlight_caps(struct core_power *core_power, unsigned int inst);
+unsigned int backlight_millipercent_to_pwm(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
+unsigned int backlight_millipercent_to_millinit(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
+void fill_backlight_level_params(struct core_power *core_power,
+	struct set_backlight_level_params *backlight_level_params,
+	int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
+	enum backlight_control_type backlight_control_type,
+	unsigned int backlight_millinit, unsigned int transition_time_millisec,
+	bool is_hdr);
+bool mod_power_hw_init_backlight(struct mod_power *mod_power);
+void mod_power_update_backlight_on_mode_change(
+    struct core_power *core_power,
+    struct dc_link *link,
+    unsigned int panel_inst,
+    uint8_t aux_inst,
+    bool is_hdr);
+unsigned int map_index_from_stream(struct core_power *core_power,
+		const struct dc_stream_state *stream);
+bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
+	const struct dc_stream_state *stream,
+	struct dc_link *link,
+	unsigned int stream_index);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
new file mode 100644
index 000000000000..5ecb570c204e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "dm_services.h"
+#include "dc.h"
+#include "mod_power.h"
+#include "core_types.h"
+#include "dmcu.h"
+#include "abm.h"
+#include "power_helpers.h"
+#include "dce/dmub_psr.h"
+#include "dal_asic_id.h"
+#include "link_service.h"
+#include <linux/math.h>
+
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGEP(...) /* do nothing */
+#include "dc/inc/hw/dmcu.h"
+#include "dc/inc/hw/abm.h"
+#include "dmub_cmd.h"
+
+#define MOD_POWER_TO_CORE(mod_power)\
+		container_of(mod_power, struct core_power, mod_public)
+
+static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
+{
+	/* Initialize fail-safe to 2 static frames. */
+	unsigned int num_frames_static = 2;
+
+	/* Calculate number of frames such that at least 30 ms has passed.
+	 * Round up to ensure the static period is not shorter than 30 ms.
+	 */
+	if (vsync_rate_hz != 0)
+		num_frames_static = DIV_ROUND_UP(30000 * vsync_rate_hz, 1000000);
+
+	return num_frames_static;
+}
+
+bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
+	const struct dc_stream_state *stream,
+	struct dc_link *link,
+	unsigned int stream_index)
+{
+	struct core_power *core_power = NULL;
+	struct dc *dc = NULL;
+	struct psr_config psr_config = {0};
+	struct psr_context psr_context = {0};
+	int active_psr_events = 0;
+
+	if ((mod_power == NULL) || (stream == NULL) || (link == NULL))
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	dc = core_power->dc;
+
+	// NO num_entities check here - already validated by caller
+	// stream_index is passed as validated parameter
+	active_psr_events = core_power->map[stream_index].psr_events;
+
+	/* Calculate PSR configurations */
+	mod_power_calc_psr_configs(&psr_config, link, stream);
+
+	psr_config.psr_exit_link_training_required =
+			core_power->map[stream_index].caps->psr_exit_link_training_required;
+	if (dc->ctx->asic_id.chip_family >= AMDGPU_FAMILY_GC_11_0_1)
+		psr_config.allow_smu_optimizations =
+				core_power->psr_smu_optimizations_support && dc_is_embedded_signal(stream->signal);
+	else
+		psr_config.allow_smu_optimizations =
+				core_power->psr_smu_optimizations_support &&
+				mod_power_only_edp(dc->current_state, stream);
+
+	psr_config.allow_multi_disp_optimizations = core_power->multi_disp_optimizations_support;
+
+	psr_config.rate_control_caps = core_power->map[stream_index].caps->rate_control_caps;
+
+	if (active_psr_events & psr_event_os_request_force_ffu)
+		psr_config.os_request_force_ffu = true;
+
+	/*
+	 * DSC support:
+	 * DSC slice height value must be 'mod' by su_y_granularity.
+	 * According to Panel Vendor, there might be varied conditions to fulfill.
+	 * Right now, DSC slice height value must be multiple of su_y_granularity.
+	 *
+	 * The value of DSC slice height is determined in DSC Driver but it does not
+	 * propagated out here, so we need to calculate it as below 'slice_height'.
+	 */
+	psr_su_set_dsc_slice_height(dc, link,
+				(struct dc_stream_state *) stream,
+				&psr_config);
+
+	dc_link_setup_psr(link, stream, &psr_config, &psr_context);
+
+	return true;
+}
+
+static void mod_power_psr_set_power_opt(struct mod_power *mod_power,
+	struct dc_stream_state *stream,
+	unsigned int active_psr_events,
+	bool psr_enable_request)
+{
+	(void)psr_enable_request;
+	struct core_power *core_power = NULL;
+	struct dc_link *link = NULL;
+	unsigned int stream_index = 0;
+	unsigned int power_opt = 0;
+
+	if (!stream)
+		return;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	stream_index = map_index_from_stream(core_power, stream);
+	if (!core_power->map[stream_index].caps->psr_version)
+		return;
+
+	link = dc_stream_get_link(stream);
+
+	if (active_psr_events == 0) {
+		/* Static Screen */
+		power_opt |= (psr_power_opt_smu_opt_static_screen | psr_power_opt_z10_static_screen |
+					psr_power_opt_ds_disable_allow);
+	}
+
+	/* psr_power_opt_flag is a configuration parameter into the module that determines
+	 * which optimizations to enable during psr
+	 */
+	power_opt &= core_power->map[stream_index].caps->psr_power_opt_flag;
+	if (core_power->map[stream_index].psr_power_opt != power_opt) {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+				WPP_BIT_FLAG_Firmware_PsrState,
+				"mod_power set_power_opt: psr_power_opt=0x%04x, power_opt=0x%04x active_psr_events=0x%04x, psr_power_opt_flag=0x%04x",
+				core_power->map[stream_index].psr_power_opt,
+				power_opt,
+				active_psr_events,
+				core_power->map[stream_index].caps->psr_power_opt_flag);
+		dc_link_set_psr_allow_active(link, NULL, false, false, &power_opt);
+		core_power->map[stream_index].psr_power_opt = power_opt;
+	}
+}
+
+static bool set_psr_enable(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		bool psr_enable,
+		bool wait,
+		bool force_static)
+{
+	struct core_power *core_power = NULL;
+	enum dc_psr_state state = PSR_STATE0;
+	unsigned int retry_count;
+	const unsigned int max_retry = 1000;
+	struct dc_link *link = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0) {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: ERROR: stream=%p num_entities=%u",
+							stream,
+							core_power->num_entities);
+		return false;
+	}
+
+	if (psr_enable)	{
+		unsigned int vsync_rate_hz;
+		struct dc_static_screen_params params = {0};
+
+		vsync_rate_hz = (unsigned int)div_u64(div_u64((
+				stream->timing.pix_clk_100hz * 100),
+				stream->timing.v_total),
+				stream->timing.h_total);
+
+		params.triggers.cursor_update = true;
+		params.triggers.overlay_update = true;
+		params.triggers.surface_update = true;
+		params.num_frames = calc_psr_num_static_frames(vsync_rate_hz);
+
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: CALCS: pix_clk_100hz=%u v_total=%u h_total=%u vsync_rate_hz=%u num_frames=%u",
+							stream->timing.pix_clk_100hz,
+							stream->timing.v_total,
+							stream->timing.h_total,
+							vsync_rate_hz,
+							params.num_frames);
+
+		dc_stream_set_static_screen_params(core_power->dc,
+						   &stream, 1,
+						   &params);
+	}
+
+	link = dc_stream_get_link(stream);
+
+	if (!dc_link_set_psr_allow_active(link, &psr_enable, false, force_static, NULL)) {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: ERROR: stream=%p link=%p psr_enable=%d",
+							stream,
+							link,
+							psr_enable);
+		return false;
+	}
+
+	if (wait == true) {
+
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: BEGIN WAIT: psr_enable=%d",
+							(int)psr_enable);
+
+		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
+			dc_link_get_psr_state(link, &state);
+			if (psr_enable) {
+				if (state != PSR_STATE0 &&
+						(!force_static || state == PSR_STATE3))
+					break;
+			} else {
+				if (state == PSR_STATE0)
+					break;
+			}
+			udelay(500);
+		}
+
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: END WAIT: psr_enable=%d",
+							(int)psr_enable);
+
+		/* assert if max retry hit */
+		if (retry_count >= max_retry) {
+			ASSERT(0);
+			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								WPP_BIT_FLAG_Firmware_PsrState,
+								"set psr enable: ERROR: retry_count=%u: Unexpectedly long wait for PSR state change.",
+								retry_count);
+		}
+	} else {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"set psr enable: PSR state change initiated (wait=false): psr_enable=%d",
+							(int)psr_enable);
+	}
+
+	return true;
+}
+
+bool mod_power_get_psr_event(struct mod_power *mod_power,
+			struct dc_stream_state *stream,
+			unsigned int *active_psr_events)
+{
+	struct core_power *core_power = NULL;
+	unsigned int stream_index = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return false;
+
+	stream_index = map_index_from_stream(core_power, stream);
+
+	if (!core_power->map[stream_index].caps->psr_version)
+		return false;
+
+	*active_psr_events = core_power->map[stream_index].psr_events;
+
+	return true;
+}
+
+bool mod_power_set_psr_event(struct mod_power *mod_power,
+		struct dc_stream_state *stream, bool set_event,
+		enum psr_event event, bool wait)
+{
+	struct core_power *core_power = NULL;
+	unsigned int stream_index = 0;
+	unsigned int active_psr_events = 0;
+	bool psr_enable_request = false;
+	bool force_static = false;
+
+	if (mod_power == NULL || stream == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	stream_index = map_index_from_stream(core_power, stream);
+
+	if (core_power->num_entities == 0) {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+							WPP_BIT_FLAG_Firmware_PsrState,
+							"mod_power set_psr_event: ERROR: stream=%p event=%d num_entities=%u",
+							stream,
+							(int)event,
+							core_power->num_entities);
+		return false;
+	}
+
+	if (!core_power->map[stream_index].caps->psr_version)
+		return false;
+
+	if (set_event)
+		core_power->map[stream_index].psr_events |= event;
+	else
+		core_power->map[stream_index].psr_events &= ~event;
+
+	active_psr_events = core_power->map[stream_index].psr_events;
+
+	// ignore other events when we're in forced psr enabled state
+	if (active_psr_events & psr_event_dynamic_display_switch &&
+			event != psr_event_dynamic_display_switch)
+		return false;
+
+	// ignore other events when we're in forced psr enabled state
+	if (active_psr_events & psr_event_os_override_hold &&
+			event != psr_event_os_override_hold)
+		return false;
+
+	// ignore other events when we're in forced psr enabled state
+	// dds events need to be processed while in dynamic_link_rate_control
+	if (active_psr_events & psr_event_dynamic_link_rate_control &&
+			event != psr_event_dynamic_link_rate_control &&
+			event != psr_event_dds_defer_stream_enable &&
+			event != psr_event_dynamic_display_switch)
+		return false;
+
+	if (active_psr_events & (psr_event_test_harness_disable_psr | psr_event_os_request_disable))
+		psr_enable_request = false;
+	else if (active_psr_events & psr_event_pause)
+		psr_enable_request = false;
+	else if (active_psr_events & psr_event_test_harness_enable_psr)
+		psr_enable_request = true;
+	else if (active_psr_events & psr_event_dynamic_display_switch) {
+		psr_enable_request = true;
+		force_static = true;
+	} else if (active_psr_events & psr_event_dynamic_link_rate_control) {
+		psr_enable_request = true;
+		force_static = true;
+	} else if (active_psr_events & psr_event_edp_panel_off_disable_psr)
+		psr_enable_request = false;
+	else if (active_psr_events & (psr_event_hw_programming |
+			psr_event_defer_enable |
+			psr_event_dds_defer_stream_enable |
+			psr_event_vrr_transition |
+			psr_event_immediate_flip))
+		psr_enable_request = false;
+	else if (active_psr_events & psr_event_big_screen_video)
+		psr_enable_request = true;
+	else if (active_psr_events & psr_event_full_screen)
+		psr_enable_request = false;
+	else if (active_psr_events & psr_event_mpo_video_selective_update)
+		psr_enable_request = true;
+	else if (active_psr_events & psr_event_vsync)
+		psr_enable_request = false;
+	else if (active_psr_events & psr_event_crc_window_active)
+		psr_enable_request = false;
+	else
+		psr_enable_request = true;
+
+	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+						WPP_BIT_FLAG_Firmware_PsrState,
+						"mod_power set_psr_event: before: psr_enabled=%d -> request: set_event=%d event=0x%04x -> result: psr_events=0x%04x psr_enable_request=%d",
+						(int)core_power->map[stream_index].psr_enabled,
+						(int)set_event,
+						(unsigned int)event,
+						(unsigned int)core_power->map[stream_index].psr_events,
+						(int)psr_enable_request);
+	mod_power_psr_set_power_opt(mod_power, stream, active_psr_events, psr_enable_request);
+
+	if (core_power->map[stream_index].psr_enabled != psr_enable_request || force_static) {
+		if (set_psr_enable(mod_power, stream, psr_enable_request, wait, force_static))
+			core_power->map[stream_index].psr_enabled = psr_enable_request;
+	}
+
+	return true;
+}
+
+bool mod_power_get_psr_state(struct mod_power *mod_power,
+		const struct dc_stream_state *stream,
+		enum dc_psr_state *state)
+{
+	struct core_power *core_power = NULL;
+	const struct dc_link *link = NULL;
+
+	if (!stream)
+		return false;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return false;
+
+	link = dc_stream_get_link(stream);
+	return dc_link_get_psr_state(link, state);
+}
+
+bool mod_power_get_psr_enabled_status(struct mod_power *mod_power,
+		const struct dc_stream_state *stream,
+		bool *psr_enabled)
+{
+	struct core_power *core_power = NULL;
+	unsigned int stream_index = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return false;
+
+	stream_index = map_index_from_stream(core_power, stream);
+
+	if (!core_power->map[stream_index].caps->psr_version)
+		return false;
+
+	*psr_enabled = core_power->map[stream_index].psr_enabled;
+
+	return true;
+}
+
+void mod_power_psr_residency(struct mod_power *mod_power,
+		const struct dc_stream_state *stream,
+		unsigned int *residency,
+		const uint8_t mode)
+{
+	struct core_power *core_power = NULL;
+	const struct dc_link *link = NULL;
+
+	if (!stream)
+		return;
+
+	if (mod_power == NULL)
+		return;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return;
+
+	link = dc_stream_get_link(stream);
+
+	if (link != NULL)
+		link->dc->link_srv->edp_get_psr_residency(link, residency, mode);
+}
+bool mod_power_psr_get_active_psr_events(struct mod_power *mod_power,
+		const struct dc_stream_state *stream, unsigned int *active_psr_events)
+{
+	struct core_power *core_power = NULL;
+	unsigned int stream_index = 0;
+
+	if (!stream)
+		return false;
+
+	if (mod_power == NULL)
+		return false;
+
+	if (active_psr_events == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return false;
+
+	stream_index = map_index_from_stream(core_power, stream);
+
+	*active_psr_events = core_power->map[stream_index].psr_events;
+	return true;
+}
+
+bool mod_power_psr_set_sink_vtotal_in_psr_active(struct mod_power *mod_power,
+		const struct dc_stream_state *stream,
+		uint16_t psr_vtotal_idle,
+		uint16_t psr_vtotal_su)
+{
+	struct core_power *core_power = NULL;
+	unsigned int stream_index = 0;
+	const struct dc_link *link = NULL;
+
+	if (!stream)
+		return false;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power->num_entities == 0)
+		return false;
+
+	stream_index = map_index_from_stream(core_power, stream);
+
+	if (!core_power->map[stream_index].caps->psr_version)
+		return false;
+
+	link = dc_stream_get_link(stream);
+
+	return link->dc->link_srv->edp_set_sink_vtotal_in_psr_active(
+			link, psr_vtotal_idle, psr_vtotal_su);
+}
+/*
+ * is_psr_su_specific_panel() - check if sink is AMD vendor-specific PSR-SU
+ * supported eDP device.
+ *
+ * @link: dc link pointer
+ *
+ * Return: true if AMDGPU vendor specific PSR-SU eDP panel
+ */
+bool is_psr_su_specific_panel(struct dc_link *link)
+{
+	bool isPSRSUSupported = false;
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+
+	if (dpcd_caps->edp_rev >= DP_EDP_14) {
+		if (dpcd_caps->psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
+			isPSRSUSupported = true;
+		/*
+		 * Some panels will report PSR capabilities over additional DPCD bits.
+		 * Such panels are approved despite reporting only PSR v3, as long as
+		 * the additional bits are reported.
+		 */
+		if (dpcd_caps->sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8) {
+			/*
+			 * This is the temporary workaround to disable PSRSU when system turned on
+			 * DSC function on the sepcific sink.
+			 */
+			if (dpcd_caps->psr_info.psr_version < DP_PSR2_WITH_Y_COORD_IS_SUPPORTED)
+				isPSRSUSupported = false;
+			else if (dpcd_caps->dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
+				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
+				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
+				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
+				isPSRSUSupported = false;
+			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
+				isPSRSUSupported = true;
+		}
+	}
+
+	return isPSRSUSupported;
+}
+
+/**
+ * mod_power_calc_psr_configs() - calculate/update generic psr configuration fields.
+ * @psr_config: [output], psr configuration structure to be updated
+ * @link: [input] dc link pointer
+ * @stream: [input] dc stream state pointer
+ *
+ * calculate and update the psr configuration fields that are not DM specific, i.e. such
+ * fields which are based on DPCD caps or timing information. To setup PSR in DMUB FW,
+ * this helper is assumed to be called before the call of the DC helper dc_link_setup_psr().
+ *
+ * PSR config fields to be updated within the helper:
+ * - psr_rfb_setup_time
+ * - psr_sdp_transmit_line_num_deadline
+ * - line_time_in_us
+ * - su_y_granularity
+ * - su_granularity_required
+ * - psr_frame_capture_indication_req
+ * - psr_exit_link_training_required
+ *
+ * PSR config fields that are DM specific and NOT updated within the helper:
+ * - allow_smu_optimizations
+ * - allow_multi_disp_optimizations
+ */
+void mod_power_calc_psr_configs(struct psr_config *psr_config,
+		struct dc_link *link,
+		const struct dc_stream_state *stream)
+{
+	unsigned int num_vblank_lines = 0;
+	unsigned int vblank_time_in_us = 0;
+	unsigned int sdp_tx_deadline_in_us = 0;
+	unsigned int line_time_in_us = 0;
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	const int psr_setup_time_step_in_us = 55;	/* refer to eDP spec DPCD 0x071h */
+
+	/* timing parameters */
+	num_vblank_lines = stream->timing.v_total -
+			 stream->timing.v_addressable -
+			 stream->timing.v_border_top -
+			 stream->timing.v_border_bottom;
+
+	vblank_time_in_us = (stream->timing.h_total * num_vblank_lines * 1000) / (stream->timing.pix_clk_100hz / 10);
+
+	line_time_in_us = ((stream->timing.h_total * 1000) / (stream->timing.pix_clk_100hz / 10)) + 1;
+
+	/**
+	 * psr configuration fields
+	 *
+	 * as per eDP 1.5 pg. 377 of 459, DPCD 0x071h bits [3:1], psr setup time bits interpreted as below
+	 * 000b <--> 330 us (default)
+	 * 001b <--> 275 us
+	 * 010b <--> 220 us
+	 * 011b <--> 165 us
+	 * 100b <--> 110 us
+	 * 101b <--> 055 us
+	 * 110b <--> 000 us
+	 */
+	psr_config->psr_rfb_setup_time =
+		(6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME) * psr_setup_time_step_in_us;
+
+	if (psr_config->psr_rfb_setup_time > vblank_time_in_us) {
+		link->psr_settings.psr_frame_capture_indication_req = true;
+		link->psr_settings.psr_sdp_transmit_line_num_deadline = num_vblank_lines;
+	} else {
+		sdp_tx_deadline_in_us = vblank_time_in_us - psr_config->psr_rfb_setup_time;
+
+		/* Set the last possible line SDP may be transmitted without violating the RFB setup time */
+		link->psr_settings.psr_frame_capture_indication_req = false;
+		link->psr_settings.psr_sdp_transmit_line_num_deadline = sdp_tx_deadline_in_us / line_time_in_us;
+	}
+
+	psr_config->psr_sdp_transmit_line_num_deadline = link->psr_settings.psr_sdp_transmit_line_num_deadline;
+	psr_config->line_time_in_us = line_time_in_us;
+	psr_config->su_y_granularity = dpcd_caps->psr_info.psr2_su_y_granularity_cap;
+	psr_config->su_granularity_required = dpcd_caps->psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED;
+	psr_config->psr_frame_capture_indication_req = link->psr_settings.psr_frame_capture_indication_req;
+	psr_config->psr_exit_link_training_required =
+		!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
+}
+
+bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
+			      struct dc_stream_state *stream,
+			      struct psr_config *config)
+{
+	uint32_t pic_height;
+	uint32_t slice_height;
+
+	config->dsc_slice_height = 0;
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP) ||
+	    !dc->caps.edp_dsc_support ||
+	    link->panel_config.dsc.disable_dsc_edp ||
+	    !link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
+	    !stream->timing.dsc_cfg.num_slices_v)
+		return true;
+
+	pic_height = stream->timing.v_addressable +
+		stream->timing.v_border_top + stream->timing.v_border_bottom;
+
+	if (stream->timing.dsc_cfg.num_slices_v == 0)
+		return false;
+
+	slice_height = pic_height / stream->timing.dsc_cfg.num_slices_v;
+	config->dsc_slice_height = (uint16_t)slice_height;
+
+	if (slice_height) {
+		if (config->su_y_granularity &&
+		    (slice_height % config->su_y_granularity)) {
+			ASSERT(0);
+			return false;
+		}
+	}
+
+	return true;
+}
-- 
2.43.0

