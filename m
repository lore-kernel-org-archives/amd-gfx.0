Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18755CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE3210ECE0;
	Wed,  6 May 2026 07:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ne+JHruL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F7B10ECE0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCFJzHlrfZWAHmADK8Z9q3ZGFkBNTHZ5Qi+lLJu48Y2DClT/cO4r5jmEqI06DNGlFzXvZ+kX0PHMPkIgIH+bJDNVlgEK2s2NLExfqdjbBdru/T8HfY1re68YNsPhDZAmFBQU9dNh1wsfTlRAo+ZXzsluYtQ3kvCFEuowPaohJeaVZuv6p0Udw+jcidPRT2JFjqfJUh1T1tia9RkXPabVg7Za/qEWHRcxg5BMHXVUpbe/w20k8EDo/7e9BzkGiyXhwcnQ/inhtRjOkfAV8qDnzEtW61iB5zfv2tnL2hgieDeNm6Xp3NxcASqRPoHZAMhLXJvuwPxAcPuxEyUljQ8O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyz0jHtX9nrj8XK7iIg3NKun+92n+vwq1acj8Tk4gH4=;
 b=Ay6Giz/CEzW+PvHj2GhKMfbfjd0HszRcIBI4eaTwShcCP2LP/H2Gyant97dWnHPMCHRkfVmQhNWKxdTOBqeTlxmuypOuHtW/isrGgFzwSbuR3iLtDWHsPV0CI4w2jcGCGkWzHVVe5Y8s9RpPqLm4afDV9WdQuF8NFIhXA7Q6u5YL1kbvjXAzx5SCkvpDgMMNy1YaM5Fvv+25FBIr93P+kBnk1TzXGgvRsEzLJgvelp6DmUVaQwzn+TgokaYb/a2FzPYn2Dks+0c99XsoH2zLvtQJhwzgYWpN6TsVWQ74XLw61/w3Z6dy+2gJml6DpO5XWYu7thMuYO/L9sDgj1Tohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyz0jHtX9nrj8XK7iIg3NKun+92n+vwq1acj8Tk4gH4=;
 b=Ne+JHruL/nGf2JfOh/ozRkXnCmfa+yC4bJNMfdasvuR/bZZSlVFDj5EO3hVS+QOQ5L0DLcdqkm30q4spDdiMUEeBYDEG55ZOh4xEAfNZERSgMsEri3Gzi5vthzDI95BBZc1oYgobJm1QPpZ8B4/YTAH1rIBBr3tGPQXpRJ3AYAc=
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:04:56 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::ba) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:04:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:04:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:04:47 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:04:38 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Lohita Mudimela <lohita.mudimela@amd.com>, "Martin
 Leung" <martin.leung@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 11/20] drm/amd/display: Separate ABM functions into dedicated
 power_abm.c file
Date: Wed, 6 May 2026 12:31:09 +0800
Message-ID: <20260506043342.2164710-12-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffb18c-d6b4-445d-045e-08deab3dc750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: usc1SP3tv1RP1Yqcfow+ym5hNNnSwv8hQNiF4L3PGP5l+B04UWYahR95Ddj1IchYsCb6H+6+dGX04bAuv3Fu1xmddSwiRDRSfodCAQh5Mhy4w+rFFgfMqOrM1NusqUq4DNWtFWVdLWGYFjhlczKp/jAtuLSONTALXN7BvNdOuJy6mgacD25XZVK7sHd2jNFydlW0kEAGmhdmQ5SdrEXV48nzubcMWj7wvj9cWJfPR4iyVdME34bFJLGUMdohGaJaPSDJgL8PEreIYj9bVdI0iEn+5i2aV0jxqUq7en9RYbgHZwV/xE33cz8XJU76yOD7LmGWN1uu/uo1zu2UIoHFumc7VlJJxrisyTliUOraU1EEStIt0vhpYdF9zKLnTHjjBpy/M1csWkg5/F8FyBA7TRACxNxHTm+poU7VliAO5TgvrxYzHeFPiLPeFi6TDS+7kySavdJnSQ53i8F1Qo87uQbWZvL9x6k8HIKvhmQO3xtBGM6Q/F5jbq7S1vW2geBx54q0YPJU2C/HNZz/hGgdxoZoFulz7Iod/0GVTYV2AkTY6YaQh4jCRLIIkVd/zggbCT3c2UVG0PQ4/DHqbx+xzqku3ihpJyVrYEhz6+TNQHa7qcBUsWTkNr1SrLsImZHMzqgIhizJaw7jU4WvmqTeZ+nCmTzAF+S2+66bDMnm21TYRLaz3ffO+YA3F+ZfpiPfivltF2YZGyjER+/7F0QelJBFB/lo+5amSvIaUO34IYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Sg9NnhmMgaXzijcn9tUEfrD6L8u6DPWcTQILeVj7fYDljBL7LNVhA1XLbgc3+BDwlG2PZin3JaQNRqR1sOjSP46XbfJLWThG4uITNe/tJWG18DQjRwLUMe9tg0YsGx9RRaedmf3X+o1PltmbFs3hqwTmA52GgIuPu4b7C3uu47ynjZ8Y8fjsPcjFmll00B99qfpE/4/OYrsBfc1xQ1Xihjc2M6BrWNOlFci0I6mlFX1/o0bs3/MjWSvtgP37ErYqqONSgHdB31wM1tudoBnjr59BfVpzW1s0be7p/yh+2lbk6CjgopqFbWKCwNEZYG1s6PYZbfXxovCBgJFHo9NQ8Q+XbT/scNqyLMABqTK5MRH1pHpc9V4OFnvP8+k1+FNZ7wHCy1eFAbdQw0xAP6w5N3rVW97xWHe6P5YaXhQ8+lN7AVshudWqPyd85vzGN+9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:04:55.7997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffb18c-d6b4-445d-045e-08deab3dc750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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
Improves code organization by separating Adaptive Backlight
Modulation functionality from general power management.
This modular approach enhances maintainability and makes the
codebase easier to navigate.

[How]
Create new power_abm.c file containing all ABM-related functions moved from power.c.
Remove static qualifier from shared functions to enable cross-file access:
- initialize_backlight_caps: Initialize backlight capabilities
- validate_ext_backlight_caps: Validate external backlight capabilities
- backlight_millipercent_to_pwm: Convert brightness percent to PWM
- backlight_millipercent_to_millinit: Convert brightness percent to nits
- fill_backlight_level_params: Populate backlight level parametersAdd function
declarations to mod_power.h header. Update CMakeLists.txt to include power_abm.c in build.
Maintain forward declaration of struct core_power for type compatibility.
Rename struct core_power field from 'public' to 'mod_public'.
Move internal structures (backlight_state, backlight_properties,
dmcu_varibright_cached_properties, core_power) to power_helpers.h to
ensure consistent memory layouts across compilation units.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/modules/inc/mod_power.h   |   25 +
 .../drm/amd/display/modules/power/Makefile    |    2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 1323 +---------
 .../drm/amd/display/modules/power/power_abm.c | 2160 +++++++++++++++++
 .../amd/display/modules/power/power_helpers.c |  815 -------
 .../amd/display/modules/power/power_helpers.h |    1 +
 6 files changed, 2251 insertions(+), 2075 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_abm.c

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 89037f7b7961..440e4284b6f0 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -5,6 +5,8 @@
 
 #include "dm_services.h"
 
+struct core_power;
+
 struct mod_power_init_params {
 
 	bool disable_fractional_pwm;
@@ -412,4 +414,27 @@ bool mod_power_backlight_nits_to_percent(struct mod_power *mod_power,
 		unsigned int backlight_millinit,
 		unsigned int *backlight_millipercent);
 
+void initialize_backlight_caps(struct core_power *core_power, unsigned int inst);
+
+unsigned int backlight_millipercent_to_pwm(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
+
+unsigned int backlight_millipercent_to_millinit(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
+
+void fill_backlight_level_params(struct core_power *core_power,
+	struct set_backlight_level_params *backlight_level_params,
+	int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
+	enum backlight_control_type backlight_control_type,
+	unsigned int backlight_millinit, unsigned int transition_time_millisec,
+	bool is_hdr);
+
+bool mod_power_hw_init_backlight(struct mod_power *mod_power);
+
+void mod_power_update_backlight_on_mode_change(
+    struct core_power *core_power,
+    struct dc_link *link,
+    unsigned int panel_inst,
+    uint8_t aux_inst,
+    bool is_hdr);
 #endif /* MODULES_INC_MOD_POWER_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
index b27a1ff3d86b..dd11f7d5617d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'power' sub-module of DAL.
 #
 
-MOD_POWER = power_helpers.o power.o
+MOD_POWER = power_helpers.o power.o power_abm.o
 
 AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
 #$(info ************  DAL POWER MODULE MAKEFILE ************)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 1ee671119ddd..f8a0b252c745 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -114,7 +114,7 @@ struct dmcu_varibright_cached_properties {
 };
 
 struct core_power {
-	struct mod_power public;
+	struct mod_power mod_public;
 	struct dc *dc;
 	struct power_entity *map;
 	struct dmcu_varibright_cached_properties varibright_prop;
@@ -153,7 +153,7 @@ static const unsigned int default_ac_backlight_percent   = 100;
 static const unsigned int default_dc_backlight_percent   = 70;
 
 #define MOD_POWER_TO_CORE(mod_power)\
-		container_of(mod_power, struct core_power, public)
+		container_of(mod_power, struct core_power, mod_public)
 
 static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
 {
@@ -199,467 +199,12 @@ static unsigned int map_index_from_stream(struct core_power *core_power,
 	return 0;
 }
 
-static uint16_t backlight_8_to_16(unsigned int backlight_8bit)
-{
-	return (uint16_t)(backlight_8bit * 0x101);
-}
-
-
-static unsigned int backlight_millipercent_to_millinit(
-		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
-{
-	unsigned int millinit = 0;
-	unsigned long long numerator = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	numerator = ((unsigned long long)millipercent) *
-				core_power->bl_prop[inst].nits_range;
-	millinit = ((unsigned int)div_u64(numerator, 100000)) +
-			core_power->bl_prop[inst].min_brightness_millinits;
-
-	return millinit;
-}
-
-static unsigned int backlight_millinit_to_millipercent(
-		struct core_power *core_power, unsigned int millinit, unsigned int inst)
-{
-	unsigned int millipercent = 0;
-	unsigned long long numerator = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	if (millinit <= core_power->bl_prop[inst].min_brightness_millinits)
-		return 0;
-
-	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
-		return (100 * 1000);
-
-	numerator = (((unsigned long long)millinit) -
-			core_power->bl_prop[inst].min_brightness_millinits) * 100000;
-	millipercent = ((unsigned int)div_u64(numerator,
-				core_power->bl_prop[inst].nits_range));
-
-	return millipercent;
-}
-
-static unsigned int backlight_pwm_to_millipercent(
-		struct core_power *core_power, unsigned int pwm, unsigned int inst)
-{
-	unsigned int millipercent = 0;
-	unsigned int max_index = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	if (!core_power->bl_prop[inst].backlight_caps_valid)
-		return 0;
-
-	/* Doesn't really make sense to have one single backlight level
-	 * possible...
-	 */
-	if (core_power->bl_prop[inst].num_backlight_levels < 2)
-		return 0;
-
-	max_index = core_power->bl_prop[inst].num_backlight_levels - 1;
-
-	if (pwm <= core_power->bl_prop[inst].backlight_lut[0])
-		return 0;
-
-	if (pwm > core_power->bl_prop[inst].backlight_lut[max_index])
-		return (100 * 1000);
-
-	/* We need to do a binary search over the array for where the pwm level
-	 * is in the lut. Based on the index we can determine percentage.
-	 */
-	unsigned int min = 0;
-	unsigned int max = max_index;
-	unsigned int mid = 0;
-
-	while (max >= min) {
-		mid = (min + max) / 2; /* floor of half range */
-
-		if (core_power->bl_prop[inst].backlight_lut[mid] < pwm)
-			min = mid + 1;
-		else if (core_power->bl_prop[inst].backlight_lut[mid] > pwm)
-			max = mid - 1;
-		else
-			break;
-	}
-
-	/* In this case, exact match is not found. Check if mid/min/max
-	 * value is actually closer.
-	 */
-	if (max < min) {
-		unsigned int min_delta;
-		unsigned int mid_delta;
-		unsigned int max_delta;
-
-		min_delta = (core_power->bl_prop[inst].backlight_lut[min] > pwm) ?
-				core_power->bl_prop[inst].backlight_lut[min] - pwm :
-				pwm - core_power->bl_prop[inst].backlight_lut[min];
-
-		mid_delta = (core_power->bl_prop[inst].backlight_lut[mid] > pwm) ?
-				core_power->bl_prop[inst].backlight_lut[mid] - pwm :
-				pwm - core_power->bl_prop[inst].backlight_lut[mid];
-
-		max_delta = (core_power->bl_prop[inst].backlight_lut[max] > pwm) ?
-				core_power->bl_prop[inst].backlight_lut[max] - pwm :
-				pwm - core_power->bl_prop[inst].backlight_lut[max];
-
-		if ((min_delta < mid_delta) && (min_delta < max_delta))
-			mid = min;
-
-		if ((max_delta < mid_delta) && (max_delta < min_delta))
-			mid = max;
-	}
-
-	/* No interpolation, just take closest index */
-	millipercent = 1000 * 100 * mid / max_index;
-
-	return millipercent;
-}
-
-static unsigned int backlight_pwm_to_millinit(
-		struct core_power *core_power, unsigned int pwm, unsigned int inst)
-{
-	unsigned int millinit = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	if (pwm <= core_power->bl_prop[inst].min_backlight_pwm)
-		return core_power->bl_prop[inst].min_brightness_millinits;
-
-	if (pwm >= core_power->bl_prop[inst].max_backlight_pwm)
-		return core_power->bl_prop[inst].max_brightness_millinits;
-
-	millinit = ((unsigned int)div_u64(((unsigned long long)pwm -
-				core_power->bl_prop[inst].min_backlight_pwm) *
-				core_power->bl_prop[inst].nits_range,
-				core_power->bl_prop[inst].backlight_range));
-
-	millinit += core_power->bl_prop[inst].min_brightness_millinits;
-
-	if (millinit > core_power->bl_prop[inst].max_brightness_millinits)
-		millinit = core_power->bl_prop[inst].max_brightness_millinits;
-
-	return millinit;
-}
-
-static unsigned int backlight_millipercent_to_pwm(
-		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
-{
-	unsigned int pwm = (unsigned int)-1;
-	unsigned int index = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	// Bypass the brightness mapping LUT
-	if (core_power->bl_prop->use_linear_backlight_curve) {
-		pwm = core_power->bl_prop[inst].min_backlight_pwm +
-			(unsigned int) div_u64((unsigned long long) millipercent *
-			core_power->bl_prop[inst].backlight_range,
-			100000);
-
-		if (pwm > core_power->bl_prop[inst].max_backlight_pwm)
-			pwm = core_power->bl_prop[inst].max_backlight_pwm;
-
-		return pwm;
-	}
-
-	if (millipercent >= (100 * 1000))
-		return core_power->bl_prop[inst].backlight_lut[core_power->bl_prop[inst].num_backlight_levels - 1];
-
-	/* This will give the floor index. */
-	index = ((core_power->bl_prop[inst].num_backlight_levels - 1) *
-						millipercent) / 100000;
-	/* Null check otherwise eDP doesn't lightup when connected to DP1 */
-	if (core_power->bl_prop[inst].backlight_lut == NULL)
-		return pwm;
-
-	pwm = core_power->bl_prop[inst].backlight_lut[index];
-
-	return pwm;
-}
-
-static unsigned int backlight_millinit_to_pwm(
-		struct core_power *core_power, unsigned int millinit, unsigned int inst)
-{
-	unsigned int pwm = 0;
-
-	if (core_power == NULL)
-		return 0;
-
-	/* For nits based brightness, the signal will be a value
-	 * between the minimum and maximum value.
-	 */
-	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
-		return core_power->bl_prop[inst].max_backlight_pwm;
-	else if (millinit <= core_power->bl_prop[inst].min_brightness_millinits)
-		return core_power->bl_prop[inst].min_backlight_pwm;
-
-	pwm = ((unsigned int)div_u64(((unsigned long long)millinit -
-			core_power->bl_prop[inst].min_brightness_millinits) *
-			core_power->bl_prop[inst].backlight_range,
-			core_power->bl_prop[inst].nits_range));
-
-	pwm += core_power->bl_prop[inst].min_backlight_pwm;
-
-	if (pwm > core_power->bl_prop[inst].max_backlight_pwm)
-		pwm = core_power->bl_prop[inst].max_backlight_pwm;
-
-	return pwm;
-}
-
-static bool validate_ext_backlight_caps(
-		struct dm_acpi_atif_backlight_caps *ext_backlight_caps)
-{
-	unsigned int i;
-	unsigned int num_of_data_points = 0;
-	unsigned int last_signal_level = 0;
-	unsigned int last_luminance = 0;
-
-	num_of_data_points = ext_backlight_caps->num_data_points;
-
-	/* Validation rules:
-	 * 1. BIOS should carry customized data points and
-	 * the number of data points should not be larger than 99.
-	 * 2. The max_input_signal should be larger than min_input_signal.
-	 * 3. For each data point:
-	 *	a. luminance should be in ascending order and
-	 *	should not be 0 or 100 since the corresponding signal_level
-	 *	are assigned by min_input_signal and max_input_signal.
-	 *	b. signal_level should be in ascending order and
-	 *	be within the range of min/max_input_signal.
-	 */
-	if (num_of_data_points > BL_DATA_POINTS)
-		return false;
-
-	if (ext_backlight_caps->min_input_signal >= ext_backlight_caps->max_input_signal)
-		return false;
-
-	last_signal_level = ext_backlight_caps->min_input_signal;
-	for (i = 0; i < num_of_data_points; i++) {
-		unsigned int luminance = ext_backlight_caps->data_points[i].luminance;
-		unsigned int signal_level = ext_backlight_caps->data_points[i].signal_level;
-
-		if ((luminance <= last_luminance) || (luminance > BL_DATA_POINTS))
-			return false;
-
-		if ((signal_level <= last_signal_level) || (signal_level >= ext_backlight_caps->max_input_signal))
-			return false;
-
-		last_signal_level = signal_level;
-		last_luminance = luminance;
-	}
-
-	return true;
-}
-
-/* hard coded to default backlight curve. */
-static void initialize_backlight_caps(struct core_power *core_power, unsigned int inst)
-{
-	unsigned int i;
-	struct dm_acpi_atif_backlight_caps *ext_backlight_caps = NULL;
-	bool custom_curve_present = false;
-	unsigned int num_levels = 0;
-	struct dc *dc = NULL;
-	enum dm_acpi_display_type acpi_display_type =
-		(inst == 0) ? AcpiDisplayType_LCD1 : AcpiDisplayType_LCD2;
-
-	if (core_power == NULL)
-		return;
-	dc = core_power->dc;
-
-	num_levels = core_power->bl_prop[inst].num_backlight_levels;
-
-	/* Allocate memory for ATIF output
-	 * (do not want to use 256 bytes on the stack)
-	 */
-	ext_backlight_caps = (struct dm_acpi_atif_backlight_caps *)
-		(kzalloc(sizeof(struct dm_acpi_atif_backlight_caps),
-				GFP_KERNEL));
-
-	if (ext_backlight_caps == NULL)
-		return;
-
-	/* Retrieve ACPI extended brightness caps */
-	if (dm_query_extended_brightness_caps
-		(dc->ctx, acpi_display_type, ext_backlight_caps)) {
-		custom_curve_present = validate_ext_backlight_caps(ext_backlight_caps);
-	}
-
-	if (core_power->bl_prop[inst].use_custom_backlight_caps &&
-			fill_custom_backlight_caps(
-					core_power->bl_prop[inst].custom_backlight_caps_config_no,
-					ext_backlight_caps)) {
-		custom_curve_present = validate_ext_backlight_caps(ext_backlight_caps);
-	}
-
-	if (custom_curve_present) {
-		unsigned int index = 1;
-		unsigned int num_of_data_points = ext_backlight_caps->num_data_points;
-
-		core_power->bl_prop[inst].ac_backlight_percent =
-			ext_backlight_caps->ac_level_percentage;
-		core_power->bl_prop[inst].dc_backlight_percent =
-			ext_backlight_caps->dc_level_percentage;
-		core_power->bl_prop[inst].backlight_lut[0] =
-			backlight_8_to_16(
-				ext_backlight_caps->min_input_signal);
-		core_power->bl_prop[inst].backlight_lut[num_levels - 1] =
-			backlight_8_to_16(
-				ext_backlight_caps->max_input_signal);
-
-		/* Filling translation table from data points -
-		 * between every two provided data points we
-		 * lineary interpolate missing values
-		 */
-		for (i = 0; i < num_of_data_points; i++) {
-			unsigned int luminance =
-				ext_backlight_caps->data_points[i].luminance;
-			unsigned int signal_level =
-				backlight_8_to_16(
-					ext_backlight_caps->data_points[i].signal_level);
-
-			/* Since luminance is a percentage, scale it by num_levels*/
-			luminance = (luminance * num_levels) / 101;
-
-			/* Lineary interpolate missing values */
-			if (index < luminance) {
-				unsigned int base_value =
-					core_power->bl_prop[inst].backlight_lut[index-1];
-				unsigned int delta_signal =
-					signal_level - base_value;
-				unsigned int delta_luma =
-					luminance - index + 1;
-				unsigned int step  = delta_signal;
-
-				for (; index < luminance; index++) {
-					core_power->bl_prop[inst].backlight_lut[index] =
-						base_value + (step / delta_luma);
-					step += delta_signal;
-				}
-			}
-
-			/* Now [index == luminance],
-			 * so we can add data point to the translation table
-			 */
-			core_power->bl_prop[inst].backlight_lut[index++] = signal_level;
-		}
-
-		/* Complete the final segment of interpolation -
-		 * between last datapoint and maximum value
-		 */
-		if (index < num_levels - 1) {
-			unsigned int base_value =
-				core_power->bl_prop[inst].backlight_lut[index-1];
-			unsigned int delta_signal =
-				core_power->bl_prop[inst].backlight_lut[num_levels - 1] -
-								base_value;
-			unsigned int delta_luma = num_levels - index;
-			unsigned int step = delta_signal;
-
-			for (; index < num_levels - 1; index++) {
-				core_power->bl_prop[inst].backlight_lut[index] =
-						base_value + (step / delta_luma);
-				step += delta_signal;
-			}
-		}
-	/* Build backlight translation table based on default curve */
-	} else {
-		/* Defines default backlight curve F(x) = A(x*x) + Bx + C.
-		 *
-		 * Backlight curve should always  satisfy:
-		 * F(0) = min, F(100) = max,
-		 * So polynom coefficients are:
-		 * A is 0.0255 - B/100 - min/10000 - (255-max)/10000 =
-		 * (max - min)/10000 - B/100
-		 * B is adjustable factor to modify the curve.
-		 * Bigger B results in less concave curve.
-		 * B range is [0..(max-min)/100]
-		 * C is backlight minimum
-		 */
-		unsigned int backlight_curve_coeff_a_factor =
-				num_levels * num_levels;
-		unsigned int backlight_curve_coeff_b = num_levels;
-		unsigned int delta =
-			core_power->bl_prop[inst].backlight_lut[num_levels - 1] -
-				core_power->bl_prop[inst].backlight_lut[0];
-		unsigned int coeffC = core_power->bl_prop[inst].backlight_lut[0];
-		unsigned int coeffB =
-				(backlight_curve_coeff_b < delta ?
-					backlight_curve_coeff_b : delta);
-		unsigned long long coeffA = delta - coeffB; /* coeffB is B*100 */
-
-		for (i = 1; i < num_levels - 1; i++) {
-			uint64_t lut_val = div_u64(coeffA * i * i, backlight_curve_coeff_a_factor) +
-				div_u64((uint64_t)coeffB * i, backlight_curve_coeff_b) + coeffC;
-
-			ASSERT(lut_val <= 0xFFFFFFFF);
-			core_power->bl_prop[inst].backlight_lut[i] = (unsigned int)lut_val;
-		}
-	}
-
-	if (ext_backlight_caps != NULL)
-		kfree(ext_backlight_caps);
-
-	/* Successfully initialized */
-	core_power->bl_prop[inst].backlight_caps_valid = true;
-}
-
-static void varibright_set_level(struct core_power *core_power)
-{
-	if (!core_power->varibright_prop.varibright_active ||
-		!core_power->varibright_prop.varibright_user_enable)
-		core_power->varibright_prop.varibright_hw_level = 0;
-	else
-		core_power->varibright_prop.varibright_hw_level =
-			core_power->varibright_prop.varibright_level;
-}
-
 bool mod_power_hw_init(struct mod_power *mod_power)
 {
-	struct core_power *core_power = NULL;
-	struct dc *dc = NULL;
-	struct dmcu *dmcu = NULL;
-	struct dmcu_iram_parameters params;
-	unsigned int i;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	dc = core_power->dc;
+	/* Call backlight initialization */
+	return mod_power_hw_init_backlight(mod_power);
 
-	for (i = 0; i < core_power->edp_num; i++) {
-		params.set = core_power->varibright_prop.varibright_config_setting;
-		params.backlight_ramping_override = core_power->bl_prop[i].backlight_ramping_override;
-		params.backlight_ramping_reduction = core_power->bl_prop[i].backlight_ramping_reduction;
-		params.backlight_ramping_start = core_power->bl_prop[i].backlight_ramping_start;
-		params.backlight_lut_array = core_power->bl_prop[i].backlight_lut;
-		params.backlight_lut_array_size = core_power->bl_prop[i].num_backlight_levels;
-		params.min_abm_backlight = core_power->bl_prop[i].min_abm_backlight;
-
-		dmcu = dc->res_pool->dmcu;
-
-		// In the case where abm is implemented on dmcub,
-		// dmcu object will be null.
-		// ABM 2.4 and up are implemented on dmcub.
-		if (dmcu) {
-			//DMCU does not support multiple eDP
-			return dmcu_load_iram(dmcu, params);
-		} else if (dc->ctx->dmub_srv) {
-			if (!dmub_init_abm_config(dc->res_pool, params, i))
-				return false;
-		} else
-			return false;
-	}
-	return true;
+	/* Future: Add other HW init here */
 }
 
 struct mod_power *mod_power_create(struct dc *dc,
@@ -829,7 +374,7 @@ struct mod_power *mod_power_create(struct dc *dc,
 		core_power->bl_state[inst].backlight_millipercent, inst);
 	}
 
-	return &core_power->public;
+	return &core_power->mod_public;
 
 fail_bad_brightness_range:
 fail_alloc_backlight_array:
@@ -1020,831 +565,91 @@ bool mod_power_replace_stream(struct mod_power *mod_power,
 	return true;
 }
 
-static bool set_backlight_millinits_aux(struct core_power *core_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millinits,
-		unsigned int transition_time_millisec,
-		unsigned int inst)
+bool mod_power_notify_mode_change(struct mod_power *mod_power,
+		const struct dc_stream_state *stream,
+		bool is_hdr)
 {
+	unsigned int stream_index = 0;
+	struct core_power *core_power = NULL;
 	struct dc_link *link = NULL;
+	struct psr_config psr_config = {0};
+	struct psr_context psr_context = {0};
+	struct dc *dc = NULL;
+	unsigned int panel_inst = 0;
+	int active_psr_events = 0;
+	int active_replay_events = 0;
 
-	if (core_power == NULL)
+	if ((mod_power == NULL) || (stream == NULL))
 		return false;
 
-	if (stream == NULL)
-		return true;
-
-	link = dc_stream_get_link(stream);
-
-	return dc_link_set_backlight_level_nits(link, core_power->bl_state[inst].isHDR,
-			backlight_millinits, transition_time_millisec);
-}
-
-static bool set_backlight(struct core_power *core_power,
-		struct dc_stream_state *stream,
-		struct set_backlight_level_params *backlight_level_params,
-		unsigned int inst)
-{
-	bool retv = false;
-	unsigned int frame_ramp = 0;
-	unsigned int vsync_rate_hz;
-	union dmcu_abm_set_bl_params params;
-	const struct dc_link *link = NULL;
-	unsigned int backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
-	unsigned int transition_time_millisec = backlight_level_params->transition_time_in_ms;
+	core_power = MOD_POWER_TO_CORE(mod_power);
 
-	if (core_power == NULL)
+	if (core_power->num_entities == 0)
 		return false;
 
-	core_power->bl_state[inst].backlight_pwm = backlight_pwm_u16_16;
-
-	if (stream == NULL)
-		return true;
+	stream_index = map_index_from_stream(core_power, stream);
 
-	if (stream->link->connector_signal != SIGNAL_TYPE_EDP)
+	if (stream_index >= core_power->num_entities)
 		return false;
 
-	if (transition_time_millisec != 0) {
-		unsigned int v_total =
-			(stream->adjust.v_total_max == 0) ? stream->timing.v_total : stream->adjust.v_total_max;
-
-		vsync_rate_hz = (unsigned int)div_u64(div_u64((stream->
-			timing.pix_clk_100hz * 100),
-			v_total),
-			stream->timing.h_total);
-
-		if (core_power->bl_state[inst].smooth_brightness_enabled)
-			frame_ramp = ((vsync_rate_hz *
-				transition_time_millisec) + 500) / 1000;
-	}
-
-	core_power->bl_state[inst].frame_ramp = frame_ramp;
-	params.u32All = 0;
-	params.bits.gradual_change = (frame_ramp > 0);
-	params.bits.frame_ramp = frame_ramp;
+	dc = core_power->dc;
 	link = dc_stream_get_link(stream);
+	active_psr_events = core_power->map[stream_index].psr_events;
+	active_replay_events = core_power->map[stream_index].replay_events;
+	if (link != NULL && dc_get_edp_link_panel_inst(dc, link, &panel_inst)) {
+		ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
+		uint8_t aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
 
-	mod_power_set_psr_event(&core_power->public, stream, true, psr_event_hw_programming, true);
-	mod_power_set_replay_event(&core_power->public, stream, true, replay_event_hw_programming, true);
+		mod_power_update_backlight_on_mode_change(core_power, link, panel_inst, aux_inst, is_hdr);
 
-	backlight_level_params->frame_ramp = params.u32All;
-	retv = dc_link_set_backlight_level(link, backlight_level_params);
+		mod_power_calc_psr_configs(&psr_config, link, stream);
 
-	mod_power_set_psr_event(&core_power->public, stream, false, psr_event_hw_programming, false);
-	mod_power_set_replay_event(&core_power->public, stream, false, replay_event_hw_programming, false);
+		psr_config.psr_exit_link_training_required = core_power->map[stream_index].caps->psr_exit_link_training_required;
 
-	return retv;
-}
+		if (dc->ctx->asic_id.chip_family >= AMDGPU_FAMILY_GC_11_0_1)
+			psr_config.allow_smu_optimizations =
+					core_power->psr_smu_optimizations_support && dc_is_embedded_signal(stream->signal);
+		else
+			psr_config.allow_smu_optimizations =
+					core_power->psr_smu_optimizations_support && mod_power_only_edp(dc->current_state, stream);
 
-static void fill_backlight_level_params(struct core_power *core_power,
-	struct set_backlight_level_params *backlight_level_params,
-	int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
-	enum backlight_control_type backlight_control_type,
-	unsigned int backlight_millinit, unsigned int transition_time_millisec,
-	bool is_hdr)
-{
-	struct pwr_backlight_properties *bl_prop = &core_power->bl_prop[panel_inst];
-
-	backlight_level_params->aux_inst = aux_inst;
-	backlight_level_params->backlight_pwm_u16_16 = backlight_pwm;
-	backlight_level_params->control_type = backlight_control_type;
-	backlight_level_params->backlight_millinits = backlight_millinit;
-	backlight_level_params->transition_time_in_ms = transition_time_millisec;
-	backlight_level_params->min_luminance = bl_prop->min_brightness_millinits;
-	backlight_level_params->max_luminance = bl_prop->max_brightness_millinits;
-	backlight_level_params->min_backlight_pwm = bl_prop->min_backlight_pwm;
-	backlight_level_params->max_backlight_pwm = bl_prop->max_backlight_pwm;
-
-	if (backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
-		backlight_level_params->control_type = BACKLIGHT_CONTROL_PWM;
-}
+		psr_config.allow_multi_disp_optimizations = core_power->multi_disp_optimizations_support;
 
-bool mod_power_set_backlight_nits(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millinit,
-		unsigned int transition_time_millisec,
-		bool skip_aux,
-		bool is_hdr)
-{
-	struct core_power *core_power = NULL;
-	unsigned int backlight_pwm;
-	unsigned int panel_inst = 0;
-	struct set_backlight_level_params backlight_level_params = { 0 };
-	const struct dc_link *link = NULL;
-	uint8_t aux_inst = 0;
+		psr_config.rate_control_caps = core_power->map[stream_index].caps->rate_control_caps;
 
-	if (mod_power == NULL)
-		return false;
+		if (active_psr_events & psr_event_os_request_force_ffu) {
+			psr_config.os_request_force_ffu = true;
+		}
+		/*
+		* DSC support:
+		* DSC slice height value must be 'mod' by su_y_granularity.
+		* According to Panel Vendor, there might be varied conditions to fulfill.
+		* Right now, DSC slice height value must be multiple of su_y_granularity.
+		*
+		* The value of DSC slice height is determined in DSC Driver but it does not
+		* propagated out here, so we need to calculate it as below 'slice_height'.
+		*/
+		psr_su_set_dsc_slice_height(dc, link,
+					(struct dc_stream_state *) stream,
+					&psr_config);
 
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	link = dc_stream_get_link(stream);
+		dc_link_setup_psr(link, stream, &psr_config, &psr_context);
 
-	ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-	aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
+		link->replay_settings.replay_smu_opt_enable =
+			(link->replay_settings.config.replay_smu_opt_supported &&
+			mod_power_only_edp(dc->current_state, stream));
 
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
-		return false;
+		if (active_replay_events & replay_event_os_request_force_ffu) {
+			link->replay_settings.config.os_request_force_ffu = true;
+		}
 
-	if (!skip_aux) {
-		if (!set_backlight_millinits_aux(core_power, stream,
-						backlight_millinit, transition_time_millisec, panel_inst))
-			return false;
+		if (dc_is_embedded_signal(stream->signal))
+			dc->link_srv->dp_setup_replay(link, stream);
 	}
-// always send both AUX (above) and PWM (below)
-	core_power->bl_state[panel_inst].backlight_millinit = backlight_millinit;
-
-	core_power->bl_state[panel_inst].backlight_millipercent =
-		backlight_millinit_to_millipercent(
-				core_power, backlight_millinit, panel_inst);
 
-	backlight_pwm = backlight_millinit_to_pwm(
-				core_power, backlight_millinit, panel_inst);
-
-	fill_backlight_level_params(core_power, &backlight_level_params, panel_inst, aux_inst, backlight_pwm,
-		link->backlight_control_type, backlight_millinit, transition_time_millisec, is_hdr);
-
-	return set_backlight(core_power, stream,
-			&backlight_level_params, panel_inst);
+	return true;
 }
 
-
-bool mod_power_backlight_percent_to_nits(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millipercent,
-		unsigned int *backlight_millinit)
-{
-	struct core_power *core_power = NULL;
-	unsigned int inst = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
-		return false;
-
-	*backlight_millinit = backlight_millipercent_to_millinit(
-			core_power, backlight_millipercent, inst);
-	return true;
-}
-
-bool mod_power_backlight_nits_to_percent(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millinit,
-		unsigned int *backlight_millipercent)
-{
-	struct core_power *core_power = NULL;
-	unsigned int inst = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
-		return false;
-
-	*backlight_millipercent = backlight_millinit_to_millipercent(
-			core_power, backlight_millinit, inst);
-	return true;
-}
-
-bool mod_power_set_backlight_percent(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millipercent,
-		unsigned int transition_time_millisec,
-		bool is_hdr)
-{
-	struct core_power *core_power = NULL;
-	struct set_backlight_level_params backlight_level_params = { 0 };
-	const struct dc_link *link = NULL;
-	unsigned int backlight_pwm;
-	unsigned int panel_inst = 0;
-	uint8_t aux_inst = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	link = dc_stream_get_link(stream);
-	ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-	aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
-
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
-		return false;
-	core_power->bl_state[panel_inst].backlight_millipercent = backlight_millipercent;
-
-	core_power->bl_state[panel_inst].backlight_millinit =
-		backlight_millipercent_to_millinit(
-				core_power, backlight_millipercent, panel_inst);
-
-	backlight_pwm = backlight_millipercent_to_pwm(
-				core_power, backlight_millipercent, panel_inst);
-
-	fill_backlight_level_params(core_power, &backlight_level_params, panel_inst,
-		aux_inst, backlight_pwm, link->backlight_control_type,
-		core_power->bl_state[panel_inst].backlight_millinit, transition_time_millisec, is_hdr);
-
-	return set_backlight(core_power, stream,
-			&backlight_level_params, panel_inst);
-}
-
-void mod_power_update_backlight(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millipercent)
-{
-	struct core_power *core_power = NULL;
-	unsigned int inst = 0;
-
-	if (mod_power == NULL)
-		return;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
-		return;
-	core_power->bl_state[inst].backlight_millipercent = backlight_millipercent;
-
-	core_power->bl_state[inst].backlight_millinit =
-		backlight_millipercent_to_millinit(
-			core_power, backlight_millipercent, inst);
-
-	core_power->bl_state[inst].backlight_pwm = backlight_millipercent_to_pwm(
-		core_power, backlight_millipercent, inst);
-}
-
-void mod_power_update_backlight_nits(struct mod_power *mod_power,
-		struct dc_stream_state *stream,
-		unsigned int backlight_millinit)
-{
-	struct core_power *core_power = NULL;
-	unsigned int inst = 0;
-
-	if (mod_power == NULL)
-		return;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
-		return;
-
-	core_power->bl_state[inst].backlight_millinit = backlight_millinit;
-
-	core_power->bl_state[inst].backlight_millipercent = backlight_millinit_to_millipercent(
-		core_power, backlight_millinit, inst);
-	core_power->bl_state[inst].backlight_pwm = backlight_millinit_to_pwm(
-		core_power, backlight_millinit, inst);
-}
-
-bool mod_power_get_backlight_pwm(struct mod_power *mod_power,
-		unsigned int *backlight_pwm,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*backlight_pwm = core_power->bl_state[inst].backlight_pwm;
-
-	return true;
-}
-
-bool mod_power_get_backlight_nits(struct mod_power *mod_power,
-		unsigned int *backlight_millinit,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*backlight_millinit = core_power->bl_state[inst].backlight_millinit;
-
-	return true;
-}
-
-bool mod_power_get_backlight_percent(struct mod_power *mod_power,
-		unsigned int *backlight_millipercent,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*backlight_millipercent = core_power->bl_state[inst].backlight_millipercent;
-
-	return true;
-}
-
-bool mod_power_get_hw_target_backlight_pwm_nits(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_millinit,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-	unsigned int backlight_u16_16 = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (mod_power_get_hw_target_backlight_pwm(mod_power, link,
-							&backlight_u16_16)) {
-		*backlight_millinit =
-			backlight_pwm_to_millinit(core_power,
-					backlight_u16_16, inst);
-		return true;
-	}
-	return false;
-}
-
-bool mod_power_get_hw_target_backlight_pwm_percent(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_millipercent,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-	unsigned int backlight_u16_16 = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (mod_power_get_hw_target_backlight_pwm(mod_power, link,
-							&backlight_u16_16)) {
-		*backlight_millipercent =
-			backlight_pwm_to_millipercent(core_power,
-					backlight_u16_16, inst);
-		return true;
-	}
-	return false;
-}
-
-bool mod_power_get_hw_target_backlight_pwm(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_u16_16)
-{
-	if (mod_power == NULL)
-		return false;
-
-	*backlight_u16_16 = dc_link_get_target_backlight_pwm(link);
-
-	return true;
-}
-
-bool mod_power_get_hw_backlight_pwm_nits(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_millinit,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-	unsigned int backlight_u16_16 = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (mod_power_get_hw_backlight_pwm(mod_power, link, &backlight_u16_16)) {
-		*backlight_millinit =
-			backlight_pwm_to_millinit(core_power,
-					backlight_u16_16, inst);
-		return true;
-	}
-	return false;
-}
-
-bool mod_power_get_hw_backlight_aux_nits(struct mod_power *mod_power,
-		struct dc_stream_state **streams, int num_streams,
-		unsigned int *backlight_millinit_avg,
-		unsigned int *backlight_millinit_peak)
-{
-	struct core_power *core_power = NULL;
-	struct dc_link *link = NULL;
-	int stream_index;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power == NULL)
-		return false;
-
-	if (num_streams < 1)
-		return true;
-
-	for (stream_index = 0; stream_index < num_streams; stream_index++)
-		if (streams[stream_index]->link->connector_signal == SIGNAL_TYPE_EDP ||
-				streams[stream_index]->link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT)
-			break;
-
-	if (stream_index == num_streams)
-		return false;
-
-	link = dc_stream_get_link(streams[stream_index]);
-	if (link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 0)
-		return false;
-
-	return dc_link_get_backlight_level_nits(link, backlight_millinit_avg,
-			backlight_millinit_peak);
-}
-
-bool mod_power_get_hw_backlight_pwm_percent(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_millipercent,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-	unsigned int backlight_u16_16 = 0;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (mod_power_get_hw_backlight_pwm(mod_power, link, &backlight_u16_16)) {
-		*backlight_millipercent =
-			backlight_pwm_to_millipercent(core_power,
-					backlight_u16_16, inst);
-		return true;
-	}
-	return false;
-}
-
-bool mod_power_get_hw_backlight_pwm(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int *backlight_u16_16)
-{
-	if (mod_power == NULL)
-		return false;
-
-	*backlight_u16_16 = dc_link_get_backlight_level(link);
-
-	return true;
-}
-
-bool mod_power_get_panel_backlight_boundaries(
-				struct mod_power *mod_power,
-				unsigned int *out_min_backlight,
-				unsigned int *out_max_backlight,
-				unsigned int *out_ac_backlight_percent,
-				unsigned int *out_dc_backlight_percent,
-				unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	/* If cache was successfully updated,
-	 * copy the values to output structure and return success
-	 */
-	if (core_power->bl_prop[inst].backlight_caps_valid) {
-		*out_min_backlight = core_power->bl_prop[inst].backlight_lut[0];
-		*out_max_backlight =
-			core_power->bl_prop[inst].backlight_lut[
-				core_power->bl_prop[inst].num_backlight_levels - 1];
-		*out_ac_backlight_percent =
-			core_power->bl_prop[inst].ac_backlight_percent;
-		*out_dc_backlight_percent =
-			core_power->bl_prop[inst].dc_backlight_percent;
-
-		return true;
-	}
-
-	return false;
-}
-
-bool mod_power_set_smooth_brightness(struct mod_power *mod_power,
-		bool enable_brightness,
-		unsigned int inst)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	core_power->bl_state[inst].smooth_brightness_enabled = enable_brightness;
-
-	return true;
-}
-
-bool mod_power_notify_mode_change(struct mod_power *mod_power,
-		const struct dc_stream_state *stream,
-		bool is_hdr)
-{
-	unsigned int stream_index = 0;
-	struct core_power *core_power = NULL;
-	struct dc_link *link = NULL;
-	struct psr_config psr_config = {0};
-	struct psr_context psr_context = {0};
-	struct dc *dc = NULL;
-	unsigned int panel_inst = 0;
-	int active_psr_events = 0;
-	int active_replay_events = 0;
-
-	if ((mod_power == NULL) || (stream == NULL))
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (core_power->num_entities == 0)
-		return false;
-
-	stream_index = map_index_from_stream(core_power, stream);
-
-	if (stream_index >= core_power->num_entities)
-		return false;
-
-	dc = core_power->dc;
-	link = dc_stream_get_link(stream);
-	active_psr_events = core_power->map[stream_index].psr_events;
-	active_replay_events = core_power->map[stream_index].replay_events;
-	if (link != NULL && dc_get_edp_link_panel_inst(dc, link, &panel_inst)) {
-		struct set_backlight_level_params backlight_level_params = { 0 };
-
-		ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-		uint8_t aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
-
-		if (link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
-			link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
-			dc_link_set_backlight_level_nits(link, core_power->bl_state[panel_inst].isHDR,
-				core_power->bl_state[panel_inst].backlight_millinit, 0);
-
-		backlight_level_params.frame_ramp = 0;
-
-		fill_backlight_level_params(core_power, &backlight_level_params, panel_inst, aux_inst,
-			core_power->bl_state[panel_inst].backlight_pwm, link->backlight_control_type,
-			core_power->bl_state[panel_inst].backlight_millinit, 0, is_hdr);
-
-		dc_link_set_backlight_level(link, &backlight_level_params);
-
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
-
-		link->replay_settings.replay_smu_opt_enable =
-			(link->replay_settings.config.replay_smu_opt_supported &&
-			mod_power_only_edp(dc->current_state, stream));
-
-		if (active_replay_events & replay_event_os_request_force_ffu) {
-			link->replay_settings.config.os_request_force_ffu = true;
-		}
-
-		if (dc_is_embedded_signal(stream->signal))
-			dc->link_srv->dp_setup_replay(link, stream);
-	}
-
-	return true;
-}
-
-bool mod_power_varibright_feature_enable(struct mod_power *mod_power, bool enable,
-		struct dc_stream_update *stream_update)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	core_power->varibright_prop.varibright_user_enable = enable;
-
-	/* find abm hw level to program, and save in stream update */
-	varibright_set_level(core_power);
-	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
-
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">ABM feature enable: enable=%u su->varibright_level=%u varibright_hw_level=%u",
-						(unsigned int) enable,
-						*stream_update->abm_level,
-						core_power->varibright_prop.varibright_hw_level);
-	return true;
-}
-
-bool mod_power_varibright_activate(struct mod_power *mod_power,
-		bool activate,
-		struct dc_stream_update *stream_update)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	core_power->varibright_prop.varibright_active = activate;
-
-	/* find abm hw level to program, and save in stream update */
-	varibright_set_level(core_power);
-	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
-
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">ABM activate: activate=%u su->varibright_level=%u",
-						(unsigned int) activate,
-						*stream_update->abm_level);
-	return true;
-}
-bool mod_power_varibright_set_level(struct mod_power *mod_power, unsigned int level,
-		struct dc_stream_update *stream_update)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-	core_power->varibright_prop.varibright_level = level;
-	core_power->varibright_prop.varibright_hw_level = level;
-
-	/* find abm hw level to program, and save in stream update */
-	varibright_set_level(core_power);
-	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
-
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">ABM set level: level=%u -> (varibright_level=%u varibright_hw_level=%u) -> su->varibright_level=%u",
-						level,
-						core_power->varibright_prop.varibright_level,
-						core_power->varibright_prop.varibright_hw_level,
-						*stream_update->abm_level);
-	return true;
-}
-
-bool mod_power_varibright_set_hw_level(struct mod_power *mod_power, unsigned int level,
-		struct dc_stream_update *stream_update)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	if (level == 0 || level == ABM_LEVEL_IMMEDIATE_DISABLE)
-		core_power->varibright_prop.varibright_active = 0;
-	else
-		core_power->varibright_prop.varibright_active = 1;
-	core_power->varibright_prop.varibright_hw_level = level;
-	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
-
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">ABM set level: level=%u -> (varibright_level=%u varibright_hw_level=%u) -> su->varibright_level=%u",
-						level,
-						core_power->varibright_prop.varibright_level,
-						core_power->varibright_prop.varibright_hw_level,
-						*stream_update->abm_level);
-	return true;
-}
-
-bool mod_power_get_varibright_level(struct mod_power *mod_power,
-		unsigned int *varibright_level)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*varibright_level = core_power->varibright_prop.varibright_level;
-
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">get varibright level: cp->varibright_level=%u",
-						*varibright_level);
-	return true;
-
-}
-
-bool mod_power_get_varibright_hw_level(struct mod_power *mod_power,
-		unsigned int *varibright_level)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*varibright_level = core_power->varibright_prop.varibright_hw_level;
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">get varibright HW level: hw_level=%u",
-						*varibright_level);
-	return true;
-}
-
-bool mod_power_get_varibright_default_level(struct mod_power *mod_power,
-		unsigned int *varibright_level)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*varibright_level = core_power->varibright_prop.def_varibright_level;
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">get varibright default level: def_varibright_level=%u",
-						*varibright_level);
-	return true;
-}
-
-bool mod_power_get_varibright_enable(struct mod_power *mod_power,
-		bool *varibright_enable)
-{
-	struct core_power *core_power = NULL;
-
-	if (mod_power == NULL)
-		return false;
-
-	core_power = MOD_POWER_TO_CORE(mod_power);
-
-	*varibright_enable = core_power->varibright_prop.varibright_user_enable;
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-				WPP_BIT_FLAG_Backlight_ABM,
-				">get varibright enable state: varibright_user_enable=%u",
-				(unsigned int) (*varibright_enable));
-	return true;
-}
-
-bool mod_power_is_abm_active(struct mod_power *mod_power,
-		const struct dc_link *link,
-		unsigned int inst)
-{
-	unsigned int user_backlight = 0;
-	unsigned int current_backlight = 0;
-	bool is_active = false;
-
-	if (mod_power == NULL)
-		return false;
-
-	mod_power_get_backlight_pwm(mod_power, &user_backlight, inst);
-	mod_power_get_hw_backlight_pwm(mod_power, link,	&current_backlight);
-
-	if (user_backlight != current_backlight)
-		is_active = true;
-	else
-		is_active = false;
-	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
-						WPP_BIT_FLAG_Backlight_ABM,
-						">get ABM active state: is_active=%u (user_backlight_pwm=%u, current_backlight_pwm=%u)",
-						(unsigned int)is_active,
-						user_backlight,
-						current_backlight);
-	return is_active;
-}
-
-
 static void mod_power_psr_set_power_opt(struct mod_power *mod_power,
 	struct dc_stream_state *stream,
 	unsigned int active_psr_events,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
new file mode 100644
index 000000000000..c41ace406519
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -0,0 +1,2160 @@
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
+
+#define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
+#define bswap16_based_on_endian(big_endian, value) \
+	((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
+
+/* Possible Min Reduction config from least aggressive to most aggressive
+ *  0    1     2     3     4     5     6     7     8     9     10    11   12
+ * 100  98.0 94.1  94.1  85.1  80.3  75.3  69.4  60.0  57.6  50.2  49.8  40.0 %
+ */
+static const unsigned char min_reduction_table[13] = {
+0xff, 0xfa, 0xf0, 0xf0, 0xd9, 0xcd, 0xc0, 0xb1, 0x99, 0x93, 0x80, 0x82, 0x66};
+
+/* Possible Max Reduction configs from least aggressive to most aggressive
+ *  0    1     2     3     4     5     6     7     8     9     10    11   12
+ * 96.1 89.8 85.1  80.3  69.4  64.7  64.7  50.2  39.6  30.2  30.2  30.2  19.6 %
+ */
+static const unsigned char max_reduction_table[13] = {
+0xf5, 0xe5, 0xd9, 0xcd, 0xb1, 0xa5, 0xa5, 0x80, 0x65, 0x4d, 0x4d, 0x4d, 0x32};
+
+/* Possible ABM 2.2 Min Reduction configs from least aggressive to most aggressive
+ *  0    1     2     3     4     5     6     7     8     9     10    11   12
+ * 100  100   100   100   100   100   100   100  100  92.2  83.1  75.3  75.3 %
+ */
+static const unsigned char min_reduction_table_v_2_2[13] = {
+0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xeb, 0xd4, 0xc0, 0xc0};
+
+/* Possible ABM 2.2 Max Reduction configs from least aggressive to most aggressive
+ *  0    1     2     3     4     5     6     7     8     9     10    11   12
+ * 96.1 89.8 74.9  69.4  64.7  52.2  48.6  39.6  30.2  25.1  19.6  12.5  12.5 %
+ */
+static const unsigned char max_reduction_table_v_2_2[13] = {
+0xf5, 0xe5, 0xbf, 0xb1, 0xa5, 0x85, 0x7c, 0x65, 0x4d, 0x40, 0x32, 0x20, 0x20};
+
+/* Predefined ABM configuration sets. We may have different configuration sets
+ * in order to satisfy different power/quality requirements.
+ */
+static const unsigned char abm_config[abm_defines_max_config][abm_defines_max_level] = {
+/*  ABM Level 1,    ABM Level 2,    ABM Level 3,    ABM Level 4 */
+{       2,              5,              7,              8       },	/* Default - Medium aggressiveness */
+{       2,              5,              8,              11      },	/* Alt #1  - Increased aggressiveness */
+{       0,              2,              4,              8       },	/* Alt #2  - Minimal aggressiveness */
+{       3,              6,              10,             12      },	/* Alt #3  - Super aggressiveness */
+};
+
+struct abm_parameters {
+	unsigned char min_reduction;
+	unsigned char max_reduction;
+	unsigned char bright_pos_gain;
+	unsigned char dark_pos_gain;
+	unsigned char brightness_gain;
+	unsigned char contrast_factor;
+	unsigned char deviation_gain;
+	unsigned char min_knee;
+	unsigned char max_knee;
+	unsigned short blRampReduction;
+	unsigned short blRampStart;
+};
+
+static const struct abm_parameters abm_settings_config0[abm_defines_max_level] = {
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
+	{0xff,   0xbf,    0x20,       0x00,     0xff,        0x99,     0xb3, 0x40,     0xe0,     0xf777,  0xcccc},
+	{0xde,   0x85,    0x20,       0x00,     0xe0,        0x90,     0xa8, 0x40,     0xc8,     0xf777,  0xcccc},
+	{0xb0,   0x50,    0x20,       0x00,     0xc0,        0x88,     0x78, 0x70,     0xa0,     0xeeee,  0x9999},
+	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,     0xe333,  0xb333},
+};
+
+static const struct abm_parameters abm_settings_config1[abm_defines_max_level] = {
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed  blStart
+	{0xf0,   0xd9,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0xcd,   0xa5,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0x99,   0x65,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0x82,   0x4d,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+};
+
+static const struct abm_parameters abm_settings_config2[abm_defines_max_level] = {
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
+	{0xf0,   0xbf,    0x20,       0x00,     0x88,        0x99,     0xb3, 0x40,     0xe0,    0x0000,  0xcccc},
+	{0xd8,   0x85,    0x20,       0x00,     0x70,        0x90,     0xa8, 0x40,     0xc8,    0x0700,  0xb333},
+	{0xb8,   0x58,    0x20,       0x00,     0x64,        0x88,     0x78, 0x70,     0xa0,    0x7000,  0x9999},
+	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,    0xc333,  0xb333},
+};
+
+static const struct abm_parameters * const abm_settings[] = {
+	abm_settings_config0,
+	abm_settings_config1,
+	abm_settings_config2,
+};
+
+static const struct dm_bl_data_point custom_backlight_curve0[] = {
+		{2, 14}, {4, 16}, {6, 18}, {8, 21}, {10, 23}, {12, 26}, {14, 29}, {16, 32}, {18, 35},
+		{20, 38}, {22, 41}, {24, 44}, {26, 48}, {28, 52}, {30, 55}, {32, 59}, {34, 62},
+		{36, 67}, {38, 71}, {40, 75}, {42, 80}, {44, 84}, {46, 88}, {48, 93}, {50, 98},
+		{52, 103}, {54, 108}, {56, 113}, {58, 118}, {60, 123}, {62, 129}, {64, 135}, {66, 140},
+		{68, 146}, {70, 152}, {72, 158}, {74, 164}, {76, 171}, {78, 177}, {80, 183}, {82, 190},
+		{84, 197}, {86, 204}, {88, 211}, {90, 218}, {92, 225}, {94, 232}, {96, 240}, {98, 247}};
+
+struct custom_backlight_profile {
+	uint8_t  ac_level_percentage;
+	uint8_t  dc_level_percentage;
+	uint8_t  min_input_signal;
+	uint8_t  max_input_signal;
+	uint8_t  num_data_points;
+	const struct dm_bl_data_point *data_points;
+};
+
+static const struct custom_backlight_profile custom_backlight_profiles[] = {
+		{100, 32, 12, 255, ARRAY_SIZE(custom_backlight_curve0), custom_backlight_curve0},
+};
+
+#define NUM_AMBI_LEVEL    5
+#define NUM_AGGR_LEVEL    4
+#define NUM_POWER_FN_SEGS 8
+#define NUM_BL_CURVE_SEGS 16
+#define IRAM_SIZE 256
+
+#define IRAM_RESERVE_AREA_START_V2 0xF0  // reserve 0xF0~0xF6 are write by DMCU only
+#define IRAM_RESERVE_AREA_END_V2 0xF6  // reserve 0xF0~0xF6 are write by DMCU only
+
+#define IRAM_RESERVE_AREA_START_V2_2 0xF0  // reserve 0xF0~0xFF are write by DMCU only
+#define IRAM_RESERVE_AREA_END_V2_2 0xFF  // reserve 0xF0~0xFF are write by DMCU only
+
+#pragma pack(push, 1)
+/* NOTE: iRAM is 256B in size */
+struct iram_table_v_2 {
+	/* flags                      */
+	uint16_t min_abm_backlight;					/* 0x00 U16  */
+
+	/* parameters for ABM2.0 algorithm */
+	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x02 U0.8 */
+	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x16 U0.8 */
+	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x2a U2.6 */
+	uint8_t bright_neg_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x3e U2.6 */
+	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x52 U2.6 */
+	uint8_t dark_neg_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x66 U2.6 */
+	uint8_t iir_curve[NUM_AMBI_LEVEL];				/* 0x7a U0.8 */
+	uint8_t deviation_gain;						/* 0x7f U0.8 */
+
+	/* parameters for crgb conversion */
+	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];			/* 0x80 U3.13 */
+	uint16_t crgb_offset[NUM_POWER_FN_SEGS];			/* 0x90 U1.15 */
+	uint16_t crgb_slope[NUM_POWER_FN_SEGS];				/* 0xa0 U4.12 */
+
+	/* parameters for custom curve */
+	/* thresholds for brightness --> backlight */
+	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];		/* 0xb0 U16.0 */
+	/* offsets for brightness --> backlight */
+	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];			/* 0xd0 U16.0 */
+
+	/* For reading PSR State directly from IRAM */
+	uint8_t psr_state;						/* 0xf0       */
+	uint8_t dmcu_mcp_interface_version;				/* 0xf1       */
+	uint8_t dmcu_abm_feature_version;				/* 0xf2       */
+	uint8_t dmcu_psr_feature_version;				/* 0xf3       */
+	uint16_t dmcu_version;						/* 0xf4       */
+	uint8_t dmcu_state;						/* 0xf6       */
+
+	uint16_t blRampReduction;					/* 0xf7       */
+	uint16_t blRampStart;						/* 0xf9       */
+	uint8_t dummy5;							/* 0xfb       */
+	uint8_t dummy6;							/* 0xfc       */
+	uint8_t dummy7;							/* 0xfd       */
+	uint8_t dummy8;							/* 0xfe       */
+	uint8_t dummy9;							/* 0xff       */
+};
+
+struct iram_table_v_2_2 {
+	/* flags                      */
+	uint16_t flags;							/* 0x00 U16  */
+
+	/* parameters for ABM2.2 algorithm */
+	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x02 U0.8 */
+	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x16 U0.8 */
+	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x2a U2.6 */
+	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x3e U2.6 */
+	uint8_t hybrid_factor[NUM_AGGR_LEVEL];				/* 0x52 U0.8 */
+	uint8_t contrast_factor[NUM_AGGR_LEVEL];			/* 0x56 U0.8 */
+	uint8_t deviation_gain[NUM_AGGR_LEVEL];				/* 0x5a U0.8 */
+	uint8_t iir_curve[NUM_AMBI_LEVEL];				/* 0x5e U0.8 */
+	uint8_t min_knee[NUM_AGGR_LEVEL];				/* 0x63 U0.8 */
+	uint8_t max_knee[NUM_AGGR_LEVEL];				/* 0x67 U0.8 */
+	uint16_t min_abm_backlight;					/* 0x6b U16  */
+	uint8_t pad[19];						/* 0x6d U0.8 */
+
+	/* parameters for crgb conversion */
+	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];			/* 0x80 U3.13 */
+	uint16_t crgb_offset[NUM_POWER_FN_SEGS];			/* 0x90 U1.15 */
+	uint16_t crgb_slope[NUM_POWER_FN_SEGS];				/* 0xa0 U4.12 */
+
+	/* parameters for custom curve */
+	/* thresholds for brightness --> backlight */
+	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];		/* 0xb0 U16.0 */
+	/* offsets for brightness --> backlight */
+	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];			/* 0xd0 U16.0 */
+
+	/* For reading PSR State directly from IRAM */
+	uint8_t psr_state;						/* 0xf0       */
+	uint8_t dmcu_mcp_interface_version;				/* 0xf1       */
+	uint8_t dmcu_abm_feature_version;				/* 0xf2       */
+	uint8_t dmcu_psr_feature_version;				/* 0xf3       */
+	uint16_t dmcu_version;						/* 0xf4       */
+	uint8_t dmcu_state;						/* 0xf6       */
+
+	uint8_t dummy1;							/* 0xf7       */
+	uint8_t dummy2;							/* 0xf8       */
+	uint8_t dummy3;							/* 0xf9       */
+	uint8_t dummy4;							/* 0xfa       */
+	uint8_t dummy5;							/* 0xfb       */
+	uint8_t dummy6;							/* 0xfc       */
+	uint8_t dummy7;							/* 0xfd       */
+	uint8_t dummy8;							/* 0xfe       */
+	uint8_t dummy9;							/* 0xff       */
+};
+#pragma pack(pop)
+
+#define MOD_POWER_MAX_CONCURRENT_STREAMS 32
+#define SMOOTH_BRIGHTNESS_ADJUSTMENT_TIME_IN_MS 500
+
+
+
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
+
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
+
+/* If system or panel does not report some sort of brightness percent to nits
+ * mapping, we will use following default values so backlight control using
+ * nits based interfaces will still work, but might not describe panel
+ * correctly. In this case percentage based backlight control should ideally
+ * be used.
+ * Min = 5 nits
+ * Max = 300 nits
+ */
+
+#define MOD_POWER_TO_CORE(mod_power)\
+		container_of(mod_power, struct core_power, mod_public)
+
+
+
+static uint16_t backlight_8_to_16(unsigned int backlight_8bit)
+{
+	return (uint16_t)(backlight_8bit * 0x101);
+}
+
+unsigned int backlight_millipercent_to_millinit(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
+{
+	unsigned int millinit = 0;
+	unsigned long long numerator = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	numerator = ((unsigned long long)millipercent) *
+				core_power->bl_prop[inst].nits_range;
+	millinit = ((unsigned int)div_u64(numerator, 100000)) +
+			core_power->bl_prop[inst].min_brightness_millinits;
+
+	return millinit;
+}
+
+static unsigned int backlight_millinit_to_millipercent(
+		struct core_power *core_power, unsigned int millinit, unsigned int inst)
+{
+	unsigned int millipercent = 0;
+	unsigned long long numerator = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	if (millinit <= core_power->bl_prop[inst].min_brightness_millinits)
+		return 0;
+
+	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
+		return (100 * 1000);
+
+	numerator = (((unsigned long long)millinit) -
+			core_power->bl_prop[inst].min_brightness_millinits) * 100000;
+	millipercent = ((unsigned int)div_u64(numerator,
+				core_power->bl_prop[inst].nits_range));
+
+	return millipercent;
+}
+
+static unsigned int backlight_pwm_to_millipercent(
+		struct core_power *core_power, unsigned int pwm, unsigned int inst)
+{
+	unsigned int millipercent = 0;
+	unsigned int max_index = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	if (!core_power->bl_prop[inst].backlight_caps_valid)
+		return 0;
+
+	/* Doesn't really make sense to have one single backlight level
+	 * possible...
+	 */
+	if (core_power->bl_prop[inst].num_backlight_levels < 2)
+		return 0;
+
+	max_index = core_power->bl_prop[inst].num_backlight_levels - 1;
+
+	if (pwm <= core_power->bl_prop[inst].backlight_lut[0])
+		return 0;
+
+	if (pwm > core_power->bl_prop[inst].backlight_lut[max_index])
+		return (100 * 1000);
+
+	/* We need to do a binary search over the array for where the pwm level
+	 * is in the lut. Based on the index we can determine percentage.
+	 */
+	unsigned int min = 0;
+	unsigned int max = max_index;
+	unsigned int mid = 0;
+
+	while (max >= min) {
+		mid = (min + max) / 2; /* floor of half range */
+
+		if (core_power->bl_prop[inst].backlight_lut[mid] < pwm)
+			min = mid + 1;
+		else if (core_power->bl_prop[inst].backlight_lut[mid] > pwm)
+			max = mid - 1;
+		else
+			break;
+	}
+
+	/* In this case, exact match is not found. Check if mid/min/max
+	 * value is actually closer.
+	 */
+	if (max < min) {
+		unsigned int min_delta;
+		unsigned int mid_delta;
+		unsigned int max_delta;
+
+		min_delta = (core_power->bl_prop[inst].backlight_lut[min] > pwm) ?
+				core_power->bl_prop[inst].backlight_lut[min] - pwm :
+				pwm - core_power->bl_prop[inst].backlight_lut[min];
+
+		mid_delta = (core_power->bl_prop[inst].backlight_lut[mid] > pwm) ?
+				core_power->bl_prop[inst].backlight_lut[mid] - pwm :
+				pwm - core_power->bl_prop[inst].backlight_lut[mid];
+
+		max_delta = (core_power->bl_prop[inst].backlight_lut[max] > pwm) ?
+				core_power->bl_prop[inst].backlight_lut[max] - pwm :
+				pwm - core_power->bl_prop[inst].backlight_lut[max];
+
+		if ((min_delta < mid_delta) && (min_delta < max_delta))
+			mid = min;
+
+		if ((max_delta < mid_delta) && (max_delta < min_delta))
+			mid = max;
+	}
+
+	/* No interpolation, just take closest index */
+	millipercent = 1000 * 100 * mid / max_index;
+
+	return millipercent;
+}
+
+static unsigned int backlight_pwm_to_millinit(
+		struct core_power *core_power, unsigned int pwm, unsigned int inst)
+{
+	unsigned int millinit = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	if (pwm <= core_power->bl_prop[inst].min_backlight_pwm)
+		return core_power->bl_prop[inst].min_brightness_millinits;
+
+	if (pwm >= core_power->bl_prop[inst].max_backlight_pwm)
+		return core_power->bl_prop[inst].max_brightness_millinits;
+
+	millinit = ((unsigned int)div_u64(((unsigned long long)pwm -
+				core_power->bl_prop[inst].min_backlight_pwm) *
+				core_power->bl_prop[inst].nits_range,
+				core_power->bl_prop[inst].backlight_range));
+
+	millinit += core_power->bl_prop[inst].min_brightness_millinits;
+
+	if (millinit > core_power->bl_prop[inst].max_brightness_millinits)
+		millinit = core_power->bl_prop[inst].max_brightness_millinits;
+
+	return millinit;
+}
+
+unsigned int backlight_millipercent_to_pwm(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
+{
+	unsigned int pwm = (unsigned int)-1;
+	unsigned int index = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	// Bypass the brightness mapping LUT
+	if (core_power->bl_prop->use_linear_backlight_curve) {
+		pwm = core_power->bl_prop[inst].min_backlight_pwm +
+			(unsigned int) div_u64((unsigned long long) millipercent *
+			core_power->bl_prop[inst].backlight_range,
+			100000);
+
+		if (pwm > core_power->bl_prop[inst].max_backlight_pwm)
+			pwm = core_power->bl_prop[inst].max_backlight_pwm;
+
+		return pwm;
+	}
+
+	if (millipercent >= (100 * 1000))
+		return core_power->bl_prop[inst].backlight_lut[core_power->bl_prop[inst].num_backlight_levels - 1];
+
+	/* This will give the floor index. */
+	index = ((core_power->bl_prop[inst].num_backlight_levels - 1) *
+						millipercent) / 100000;
+	/* Null check otherwise eDP doesn't lightup when connected to DP1 */
+	if (core_power->bl_prop[inst].backlight_lut == NULL)
+		return pwm;
+
+	pwm = core_power->bl_prop[inst].backlight_lut[index];
+
+	return pwm;
+}
+
+static unsigned int backlight_millinit_to_pwm(
+		struct core_power *core_power, unsigned int millinit, unsigned int inst)
+{
+	unsigned int pwm = 0;
+
+	if (core_power == NULL)
+		return 0;
+
+	/* For nits based brightness, the signal will be a value
+	 * between the minimum and maximum value.
+	 */
+	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
+		return core_power->bl_prop[inst].max_backlight_pwm;
+	else if (millinit <= core_power->bl_prop[inst].min_brightness_millinits)
+		return core_power->bl_prop[inst].min_backlight_pwm;
+
+	pwm = ((unsigned int)div_u64(((unsigned long long)millinit -
+			core_power->bl_prop[inst].min_brightness_millinits) *
+			core_power->bl_prop[inst].backlight_range,
+			core_power->bl_prop[inst].nits_range));
+
+	pwm += core_power->bl_prop[inst].min_backlight_pwm;
+
+	if (pwm > core_power->bl_prop[inst].max_backlight_pwm)
+		pwm = core_power->bl_prop[inst].max_backlight_pwm;
+
+	return pwm;
+}
+
+static bool validate_ext_backlight_caps(
+		struct dm_acpi_atif_backlight_caps *ext_backlight_caps)
+{
+	unsigned int i;
+	unsigned int num_of_data_points = 0;
+	unsigned int last_signal_level = 0;
+	unsigned int last_luminance = 0;
+
+	num_of_data_points = ext_backlight_caps->num_data_points;
+
+	/* Validation rules:
+	 * 1. BIOS should carry customized data points and
+	 * the number of data points should not be larger than 99.
+	 * 2. The max_input_signal should be larger than min_input_signal.
+	 * 3. For each data point:
+	 *	a. luminance should be in ascending order and
+	 *	should not be 0 or 100 since the corresponding signal_level
+	 *	are assigned by min_input_signal and max_input_signal.
+	 *	b. signal_level should be in ascending order and
+	 *	be within the range of min/max_input_signal.
+	 */
+	if (num_of_data_points > BL_DATA_POINTS)
+		return false;
+
+	if (ext_backlight_caps->min_input_signal >= ext_backlight_caps->max_input_signal)
+		return false;
+
+	last_signal_level = ext_backlight_caps->min_input_signal;
+	for (i = 0; i < num_of_data_points; i++) {
+		unsigned int luminance = ext_backlight_caps->data_points[i].luminance;
+		unsigned int signal_level = ext_backlight_caps->data_points[i].signal_level;
+
+		if ((luminance <= last_luminance) || (luminance > BL_DATA_POINTS))
+			return false;
+
+		if ((signal_level <= last_signal_level) || (signal_level >= ext_backlight_caps->max_input_signal))
+			return false;
+
+		last_signal_level = signal_level;
+		last_luminance = luminance;
+	}
+
+	return true;
+}
+
+/* hard coded to default backlight curve. */
+void initialize_backlight_caps(struct core_power *core_power, unsigned int inst)
+{
+	unsigned int i;
+	struct dm_acpi_atif_backlight_caps *ext_backlight_caps = NULL;
+	bool custom_curve_present = false;
+	unsigned int num_levels = 0;
+	struct dc *dc = NULL;
+	enum dm_acpi_display_type acpi_display_type =
+		(inst == 0) ? AcpiDisplayType_LCD1 : AcpiDisplayType_LCD2;
+
+	if (core_power == NULL)
+		return;
+	dc = core_power->dc;
+
+	num_levels = core_power->bl_prop[inst].num_backlight_levels;
+
+	/* Allocate memory for ATIF output
+	 * (do not want to use 256 bytes on the stack)
+	 */
+	ext_backlight_caps = (struct dm_acpi_atif_backlight_caps *)
+		(kzalloc(sizeof(struct dm_acpi_atif_backlight_caps),
+				GFP_KERNEL));
+
+	if (ext_backlight_caps == NULL)
+		return;
+
+	/* Retrieve ACPI extended brightness caps */
+	if (dm_query_extended_brightness_caps
+		(dc->ctx, acpi_display_type, ext_backlight_caps)) {
+		custom_curve_present = validate_ext_backlight_caps(ext_backlight_caps);
+	}
+
+	if (core_power->bl_prop[inst].use_custom_backlight_caps &&
+			fill_custom_backlight_caps(
+					core_power->bl_prop[inst].custom_backlight_caps_config_no,
+					ext_backlight_caps)) {
+		custom_curve_present = validate_ext_backlight_caps(ext_backlight_caps);
+	}
+
+	if (custom_curve_present) {
+		unsigned int index = 1;
+		unsigned int num_of_data_points = ext_backlight_caps->num_data_points;
+
+		core_power->bl_prop[inst].ac_backlight_percent =
+			ext_backlight_caps->ac_level_percentage;
+		core_power->bl_prop[inst].dc_backlight_percent =
+			ext_backlight_caps->dc_level_percentage;
+		core_power->bl_prop[inst].backlight_lut[0] =
+			backlight_8_to_16(
+				ext_backlight_caps->min_input_signal);
+		core_power->bl_prop[inst].backlight_lut[num_levels - 1] =
+			backlight_8_to_16(
+				ext_backlight_caps->max_input_signal);
+
+		/* Filling translation table from data points -
+		 * between every two provided data points we
+		 * lineary interpolate missing values
+		 */
+		for (i = 0; i < num_of_data_points; i++) {
+			unsigned int luminance =
+				ext_backlight_caps->data_points[i].luminance;
+			unsigned int signal_level =
+				backlight_8_to_16(
+					ext_backlight_caps->data_points[i].signal_level);
+
+			/* Since luminance is a percentage, scale it by num_levels*/
+			luminance = (luminance * num_levels) / 101;
+
+			/* Lineary interpolate missing values */
+			if (index < luminance) {
+				unsigned int base_value =
+					core_power->bl_prop[inst].backlight_lut[index-1];
+				unsigned int delta_signal =
+					signal_level - base_value;
+				unsigned int delta_luma =
+					luminance - index + 1;
+				unsigned int step  = delta_signal;
+
+				for (; index < luminance; index++) {
+					core_power->bl_prop[inst].backlight_lut[index] =
+						base_value + (step / delta_luma);
+					step += delta_signal;
+				}
+			}
+
+			/* Now [index == luminance],
+			 * so we can add data point to the translation table
+			 */
+			core_power->bl_prop[inst].backlight_lut[index++] = signal_level;
+		}
+
+		/* Complete the final segment of interpolation -
+		 * between last datapoint and maximum value
+		 */
+		if (index < num_levels - 1) {
+			unsigned int base_value =
+				core_power->bl_prop[inst].backlight_lut[index-1];
+			unsigned int delta_signal =
+				core_power->bl_prop[inst].backlight_lut[num_levels - 1] -
+								base_value;
+			unsigned int delta_luma = num_levels - index;
+			unsigned int step = delta_signal;
+
+			for (; index < num_levels - 1; index++) {
+				core_power->bl_prop[inst].backlight_lut[index] =
+						base_value + (step / delta_luma);
+				step += delta_signal;
+			}
+		}
+	/* Build backlight translation table based on default curve */
+	} else {
+		/* Defines default backlight curve F(x) = A(x*x) + Bx + C.
+		 *
+		 * Backlight curve should always  satisfy:
+		 * F(0) = min, F(100) = max,
+		 * So polynom coefficients are:
+		 * A is 0.0255 - B/100 - min/10000 - (255-max)/10000 =
+		 * (max - min)/10000 - B/100
+		 * B is adjustable factor to modify the curve.
+		 * Bigger B results in less concave curve.
+		 * B range is [0..(max-min)/100]
+		 * C is backlight minimum
+		 */
+		unsigned int backlight_curve_coeff_a_factor =
+				num_levels * num_levels;
+		unsigned int backlight_curve_coeff_b = num_levels;
+		unsigned int delta =
+			core_power->bl_prop[inst].backlight_lut[num_levels - 1] -
+				core_power->bl_prop[inst].backlight_lut[0];
+		unsigned int coeffC = core_power->bl_prop[inst].backlight_lut[0];
+		unsigned int coeffB =
+				(backlight_curve_coeff_b < delta ?
+					backlight_curve_coeff_b : delta);
+		unsigned long long coeffA = delta - coeffB; /* coeffB is B*100 */
+
+		for (i = 1; i < num_levels - 1; i++) {
+			uint64_t lut_val = div_u64(coeffA * i * i, backlight_curve_coeff_a_factor) +
+				div_u64((uint64_t)coeffB * i, backlight_curve_coeff_b) + coeffC;
+
+			ASSERT(lut_val <= 0xFFFFFFFF);
+			core_power->bl_prop[inst].backlight_lut[i] = (unsigned int)lut_val;
+		}
+	}
+
+	if (ext_backlight_caps != NULL)
+		kfree(ext_backlight_caps);
+
+	/* Successfully initialized */
+	core_power->bl_prop[inst].backlight_caps_valid = true;
+}
+
+static void varibright_set_level(struct core_power *core_power)
+{
+	if (!core_power->varibright_prop.varibright_active ||
+		!core_power->varibright_prop.varibright_user_enable)
+		core_power->varibright_prop.varibright_hw_level = 0;
+	else
+		core_power->varibright_prop.varibright_hw_level =
+			core_power->varibright_prop.varibright_level;
+}
+
+bool mod_power_hw_init_backlight(struct mod_power *mod_power)
+{
+	struct core_power *core_power = NULL;
+	struct dc *dc = NULL;
+	struct dmcu *dmcu = NULL;
+	struct dmcu_iram_parameters params;
+	unsigned int i;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	dc = core_power->dc;
+
+	for (i = 0; i < core_power->edp_num; i++) {
+		params.set = core_power->varibright_prop.varibright_config_setting;
+		params.backlight_ramping_override = core_power->bl_prop[i].backlight_ramping_override;
+		params.backlight_ramping_reduction = core_power->bl_prop[i].backlight_ramping_reduction;
+		params.backlight_ramping_start = core_power->bl_prop[i].backlight_ramping_start;
+		params.backlight_lut_array = core_power->bl_prop[i].backlight_lut;
+		params.backlight_lut_array_size = core_power->bl_prop[i].num_backlight_levels;
+		params.min_abm_backlight = core_power->bl_prop[i].min_abm_backlight;
+
+		dmcu = dc->res_pool->dmcu;
+
+		// In the case where abm is implemented on dmcub,
+		// dmcu object will be null.
+		// ABM 2.4 and up are implemented on dmcub.
+		if (dmcu) {
+			//DMCU does not support multiple eDP
+			return dmcu_load_iram(dmcu, params);
+		} else if (dc->ctx->dmub_srv) {
+			if (!dmub_init_abm_config(dc->res_pool, params, i))
+				return false;
+		} else
+			return false;
+	}
+	return true;
+}
+
+void mod_power_update_backlight_on_mode_change(
+    struct core_power *core_power,
+    struct dc_link *link,
+    unsigned int panel_inst,
+    uint8_t aux_inst,
+    bool is_hdr)
+{
+    struct set_backlight_level_params backlight_level_params = { 0 };
+
+		if (link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+			link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
+			dc_link_set_backlight_level_nits(link, core_power->bl_state[panel_inst].isHDR,
+				core_power->bl_state[panel_inst].backlight_millinit, 0);
+
+		backlight_level_params.frame_ramp = 0;
+
+		fill_backlight_level_params(core_power, &backlight_level_params, panel_inst, aux_inst,
+			core_power->bl_state[panel_inst].backlight_pwm, link->backlight_control_type,
+			core_power->bl_state[panel_inst].backlight_millinit, 0, is_hdr);
+
+		dc_link_set_backlight_level(link, &backlight_level_params);
+}
+
+static bool set_backlight_millinits_aux(struct core_power *core_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millinits,
+		unsigned int transition_time_millisec,
+		unsigned int inst)
+{
+	struct dc_link *link = NULL;
+
+	if (core_power == NULL)
+		return false;
+
+	if (stream == NULL)
+		return true;
+
+	link = dc_stream_get_link(stream);
+
+	return dc_link_set_backlight_level_nits(link, core_power->bl_state[inst].isHDR,
+			backlight_millinits, transition_time_millisec);
+}
+
+static bool set_backlight(struct core_power *core_power,
+		struct dc_stream_state *stream,
+		struct set_backlight_level_params *backlight_level_params,
+		unsigned int inst)
+{
+	bool retv = false;
+	unsigned int frame_ramp = 0;
+	unsigned int vsync_rate_hz;
+	union dmcu_abm_set_bl_params params;
+	const struct dc_link *link = NULL;
+	unsigned int backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
+	unsigned int transition_time_millisec = backlight_level_params->transition_time_in_ms;
+
+	if (core_power == NULL)
+		return false;
+
+	core_power->bl_state[inst].backlight_pwm = backlight_pwm_u16_16;
+
+	if (stream == NULL)
+		return true;
+
+	if (stream->link->connector_signal != SIGNAL_TYPE_EDP)
+		return false;
+
+	if (transition_time_millisec != 0) {
+		unsigned int v_total =
+			(stream->adjust.v_total_max == 0) ? stream->timing.v_total : stream->adjust.v_total_max;
+
+		vsync_rate_hz = (unsigned int)div_u64(div_u64((stream->
+			timing.pix_clk_100hz * 100),
+			v_total),
+			stream->timing.h_total);
+
+		if (core_power->bl_state[inst].smooth_brightness_enabled)
+			frame_ramp = ((vsync_rate_hz *
+				transition_time_millisec) + 500) / 1000;
+	}
+
+	core_power->bl_state[inst].frame_ramp = frame_ramp;
+	params.u32All = 0;
+	params.bits.gradual_change = (frame_ramp > 0);
+	params.bits.frame_ramp = frame_ramp;
+	link = dc_stream_get_link(stream);
+
+	mod_power_set_psr_event(&core_power->mod_public, stream, true, psr_event_hw_programming, true);
+	mod_power_set_replay_event(&core_power->mod_public, stream, true, replay_event_hw_programming, true);
+
+	backlight_level_params->frame_ramp = params.u32All;
+	retv = dc_link_set_backlight_level(link, backlight_level_params);
+
+	mod_power_set_psr_event(&core_power->mod_public, stream, false, psr_event_hw_programming, false);
+	mod_power_set_replay_event(&core_power->mod_public, stream, false, replay_event_hw_programming, false);
+
+	return retv;
+}
+
+void fill_backlight_level_params(struct core_power *core_power,
+	struct set_backlight_level_params *backlight_level_params,
+	int panel_inst, uint8_t aux_inst, unsigned int backlight_pwm,
+	enum backlight_control_type backlight_control_type,
+	unsigned int backlight_millinit, unsigned int transition_time_millisec,
+	bool is_hdr)
+{
+	struct pwr_backlight_properties *bl_prop = &core_power->bl_prop[panel_inst];
+
+	backlight_level_params->aux_inst = aux_inst;
+	backlight_level_params->backlight_pwm_u16_16 = backlight_pwm;
+	backlight_level_params->control_type = backlight_control_type;
+	backlight_level_params->backlight_millinits = backlight_millinit;
+	backlight_level_params->transition_time_in_ms = transition_time_millisec;
+	backlight_level_params->min_luminance = bl_prop->min_brightness_millinits;
+	backlight_level_params->max_luminance = bl_prop->max_brightness_millinits;
+	backlight_level_params->min_backlight_pwm = bl_prop->min_backlight_pwm;
+	backlight_level_params->max_backlight_pwm = bl_prop->max_backlight_pwm;
+
+	if (backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
+		backlight_level_params->control_type = BACKLIGHT_CONTROL_PWM;
+}
+
+bool mod_power_set_backlight_nits(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millinit,
+		unsigned int transition_time_millisec,
+		bool skip_aux,
+		bool is_hdr)
+{
+	struct core_power *core_power = NULL;
+	unsigned int backlight_pwm;
+	unsigned int panel_inst = 0;
+	struct set_backlight_level_params backlight_level_params = { 0 };
+	const struct dc_link *link = NULL;
+	uint8_t aux_inst = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	link = dc_stream_get_link(stream);
+
+	ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
+	aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
+		return false;
+
+	if (!skip_aux) {
+		if (!set_backlight_millinits_aux(core_power, stream,
+						backlight_millinit, transition_time_millisec, panel_inst))
+			return false;
+	}
+// always send both AUX (above) and PWM (below)
+	core_power->bl_state[panel_inst].backlight_millinit = backlight_millinit;
+
+	core_power->bl_state[panel_inst].backlight_millipercent =
+		backlight_millinit_to_millipercent(
+				core_power, backlight_millinit, panel_inst);
+
+	backlight_pwm = backlight_millinit_to_pwm(
+				core_power, backlight_millinit, panel_inst);
+
+	fill_backlight_level_params(core_power, &backlight_level_params, panel_inst, aux_inst, backlight_pwm,
+		link->backlight_control_type, backlight_millinit, transition_time_millisec, is_hdr);
+
+	return set_backlight(core_power, stream,
+			&backlight_level_params, panel_inst);
+}
+
+bool mod_power_backlight_percent_to_nits(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millipercent,
+		unsigned int *backlight_millinit)
+{
+	struct core_power *core_power = NULL;
+	unsigned int inst = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
+		return false;
+
+	*backlight_millinit = backlight_millipercent_to_millinit(
+			core_power, backlight_millipercent, inst);
+	return true;
+}
+
+bool mod_power_backlight_nits_to_percent(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millinit,
+		unsigned int *backlight_millipercent)
+{
+	struct core_power *core_power = NULL;
+	unsigned int inst = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
+		return false;
+
+	*backlight_millipercent = backlight_millinit_to_millipercent(
+			core_power, backlight_millinit, inst);
+	return true;
+}
+
+bool mod_power_set_backlight_percent(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millipercent,
+		unsigned int transition_time_millisec,
+		bool is_hdr)
+{
+	struct core_power *core_power = NULL;
+	struct set_backlight_level_params backlight_level_params = { 0 };
+	const struct dc_link *link = NULL;
+	unsigned int backlight_pwm;
+	unsigned int panel_inst = 0;
+	uint8_t aux_inst = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	link = dc_stream_get_link(stream);
+	ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
+	aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
+		return false;
+	core_power->bl_state[panel_inst].backlight_millipercent = backlight_millipercent;
+
+	core_power->bl_state[panel_inst].backlight_millinit =
+		backlight_millipercent_to_millinit(
+				core_power, backlight_millipercent, panel_inst);
+
+	backlight_pwm = backlight_millipercent_to_pwm(
+				core_power, backlight_millipercent, panel_inst);
+
+	fill_backlight_level_params(core_power, &backlight_level_params, panel_inst,
+		aux_inst, backlight_pwm, link->backlight_control_type,
+		core_power->bl_state[panel_inst].backlight_millinit, transition_time_millisec, is_hdr);
+
+	return set_backlight(core_power, stream,
+			&backlight_level_params, panel_inst);
+}
+
+void mod_power_update_backlight(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millipercent)
+{
+	struct core_power *core_power = NULL;
+	unsigned int inst = 0;
+
+	if (mod_power == NULL)
+		return;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
+		return;
+	core_power->bl_state[inst].backlight_millipercent = backlight_millipercent;
+
+	core_power->bl_state[inst].backlight_millinit =
+		backlight_millipercent_to_millinit(
+			core_power, backlight_millipercent, inst);
+
+	core_power->bl_state[inst].backlight_pwm = backlight_millipercent_to_pwm(
+		core_power, backlight_millipercent, inst);
+}
+
+void mod_power_update_backlight_nits(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millinit)
+{
+	struct core_power *core_power = NULL;
+	unsigned int inst = 0;
+
+	if (mod_power == NULL)
+		return;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &inst))
+		return;
+
+	core_power->bl_state[inst].backlight_millinit = backlight_millinit;
+
+	core_power->bl_state[inst].backlight_millipercent = backlight_millinit_to_millipercent(
+		core_power, backlight_millinit, inst);
+	core_power->bl_state[inst].backlight_pwm = backlight_millinit_to_pwm(
+		core_power, backlight_millinit, inst);
+}
+
+bool mod_power_get_backlight_pwm(struct mod_power *mod_power,
+		unsigned int *backlight_pwm,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*backlight_pwm = core_power->bl_state[inst].backlight_pwm;
+
+	return true;
+}
+
+bool mod_power_get_backlight_nits(struct mod_power *mod_power,
+		unsigned int *backlight_millinit,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*backlight_millinit = core_power->bl_state[inst].backlight_millinit;
+
+	return true;
+}
+
+bool mod_power_get_backlight_percent(struct mod_power *mod_power,
+		unsigned int *backlight_millipercent,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*backlight_millipercent = core_power->bl_state[inst].backlight_millipercent;
+
+	return true;
+}
+
+bool mod_power_get_hw_target_backlight_pwm_nits(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_millinit,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	unsigned int backlight_u16_16 = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (mod_power_get_hw_target_backlight_pwm(mod_power, link,
+							&backlight_u16_16)) {
+		*backlight_millinit =
+			backlight_pwm_to_millinit(core_power,
+					backlight_u16_16, inst);
+		return true;
+	}
+	return false;
+}
+
+bool mod_power_get_hw_target_backlight_pwm_percent(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_millipercent,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	unsigned int backlight_u16_16 = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (mod_power_get_hw_target_backlight_pwm(mod_power, link,
+							&backlight_u16_16)) {
+		*backlight_millipercent =
+			backlight_pwm_to_millipercent(core_power,
+					backlight_u16_16, inst);
+		return true;
+	}
+	return false;
+}
+
+bool mod_power_get_hw_target_backlight_pwm(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_u16_16)
+{
+	if (mod_power == NULL)
+		return false;
+
+	*backlight_u16_16 = dc_link_get_target_backlight_pwm(link);
+
+	return true;
+}
+
+bool mod_power_get_hw_backlight_pwm_nits(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_millinit,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	unsigned int backlight_u16_16 = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (mod_power_get_hw_backlight_pwm(mod_power, link, &backlight_u16_16)) {
+		*backlight_millinit =
+			backlight_pwm_to_millinit(core_power,
+					backlight_u16_16, inst);
+		return true;
+	}
+	return false;
+}
+
+bool mod_power_get_hw_backlight_aux_nits(struct mod_power *mod_power,
+		struct dc_stream_state **streams, int num_streams,
+		unsigned int *backlight_millinit_avg,
+		unsigned int *backlight_millinit_peak)
+{
+	struct core_power *core_power = NULL;
+	struct dc_link *link = NULL;
+	int stream_index;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (core_power == NULL)
+		return false;
+
+	if (num_streams < 1)
+		return true;
+
+	for (stream_index = 0; stream_index < num_streams; stream_index++)
+		if (streams[stream_index]->link->connector_signal == SIGNAL_TYPE_EDP ||
+				streams[stream_index]->link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT)
+			break;
+
+	if (stream_index == num_streams)
+		return false;
+
+	link = dc_stream_get_link(streams[stream_index]);
+	if (link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 0)
+		return false;
+
+	return dc_link_get_backlight_level_nits(link, backlight_millinit_avg,
+			backlight_millinit_peak);
+}
+
+bool mod_power_get_hw_backlight_pwm_percent(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_millipercent,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+	unsigned int backlight_u16_16 = 0;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (mod_power_get_hw_backlight_pwm(mod_power, link, &backlight_u16_16)) {
+		*backlight_millipercent =
+			backlight_pwm_to_millipercent(core_power,
+					backlight_u16_16, inst);
+		return true;
+	}
+	return false;
+}
+
+bool mod_power_get_hw_backlight_pwm(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int *backlight_u16_16)
+{
+	if (mod_power == NULL)
+		return false;
+
+	*backlight_u16_16 = dc_link_get_backlight_level(link);
+
+	return true;
+}
+
+bool mod_power_get_panel_backlight_boundaries(
+				struct mod_power *mod_power,
+				unsigned int *out_min_backlight,
+				unsigned int *out_max_backlight,
+				unsigned int *out_ac_backlight_percent,
+				unsigned int *out_dc_backlight_percent,
+				unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	/* If cache was successfully updated,
+	 * copy the values to output structure and return success
+	 */
+	if (core_power->bl_prop[inst].backlight_caps_valid) {
+		*out_min_backlight = core_power->bl_prop[inst].backlight_lut[0];
+		*out_max_backlight =
+			core_power->bl_prop[inst].backlight_lut[
+				core_power->bl_prop[inst].num_backlight_levels - 1];
+		*out_ac_backlight_percent =
+			core_power->bl_prop[inst].ac_backlight_percent;
+		*out_dc_backlight_percent =
+			core_power->bl_prop[inst].dc_backlight_percent;
+
+		return true;
+	}
+
+	return false;
+}
+
+bool mod_power_set_smooth_brightness(struct mod_power *mod_power,
+		bool enable_brightness,
+		unsigned int inst)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	core_power->bl_state[inst].smooth_brightness_enabled = enable_brightness;
+
+	return true;
+}
+
+bool mod_power_varibright_feature_enable(struct mod_power *mod_power, bool enable,
+		struct dc_stream_update *stream_update)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	core_power->varibright_prop.varibright_user_enable = enable;
+
+	/* find abm hw level to program, and save in stream update */
+	varibright_set_level(core_power);
+	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
+
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">ABM feature enable: enable=%u su->varibright_level=%u varibright_hw_level=%u",
+						(unsigned int) enable,
+						*stream_update->abm_level,
+						core_power->varibright_prop.varibright_hw_level);
+	return true;
+}
+
+bool mod_power_varibright_activate(struct mod_power *mod_power,
+		bool activate,
+		struct dc_stream_update *stream_update)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	core_power->varibright_prop.varibright_active = activate;
+
+	/* find abm hw level to program, and save in stream update */
+	varibright_set_level(core_power);
+	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
+
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">ABM activate: activate=%u su->varibright_level=%u",
+						(unsigned int) activate,
+						*stream_update->abm_level);
+	return true;
+}
+bool mod_power_varibright_set_level(struct mod_power *mod_power, unsigned int level,
+		struct dc_stream_update *stream_update)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	core_power->varibright_prop.varibright_level = level;
+	core_power->varibright_prop.varibright_hw_level = level;
+
+	/* find abm hw level to program, and save in stream update */
+	varibright_set_level(core_power);
+	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
+
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">ABM set level: level=%u -> (varibright_level=%u varibright_hw_level=%u) -> su->varibright_level=%u",
+						level,
+						core_power->varibright_prop.varibright_level,
+						core_power->varibright_prop.varibright_hw_level,
+						*stream_update->abm_level);
+	return true;
+}
+
+bool mod_power_varibright_set_hw_level(struct mod_power *mod_power, unsigned int level,
+		struct dc_stream_update *stream_update)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	if (level == 0 || level == ABM_LEVEL_IMMEDIATE_DISABLE)
+		core_power->varibright_prop.varibright_active = 0;
+	else
+		core_power->varibright_prop.varibright_active = 1;
+	core_power->varibright_prop.varibright_hw_level = level;
+	*stream_update->abm_level = core_power->varibright_prop.varibright_hw_level;
+
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">ABM set level: level=%u -> (varibright_level=%u varibright_hw_level=%u) -> su->varibright_level=%u",
+						level,
+						core_power->varibright_prop.varibright_level,
+						core_power->varibright_prop.varibright_hw_level,
+						*stream_update->abm_level);
+	return true;
+}
+
+bool mod_power_get_varibright_level(struct mod_power *mod_power,
+		unsigned int *varibright_level)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*varibright_level = core_power->varibright_prop.varibright_level;
+
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">get varibright level: cp->varibright_level=%u",
+						*varibright_level);
+	return true;
+
+}
+
+bool mod_power_get_varibright_hw_level(struct mod_power *mod_power,
+		unsigned int *varibright_level)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*varibright_level = core_power->varibright_prop.varibright_hw_level;
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">get varibright HW level: hw_level=%u",
+						*varibright_level);
+	return true;
+}
+
+bool mod_power_get_varibright_default_level(struct mod_power *mod_power,
+		unsigned int *varibright_level)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*varibright_level = core_power->varibright_prop.def_varibright_level;
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">get varibright default level: def_varibright_level=%u",
+						*varibright_level);
+	return true;
+}
+
+bool mod_power_get_varibright_enable(struct mod_power *mod_power,
+		bool *varibright_enable)
+{
+	struct core_power *core_power = NULL;
+
+	if (mod_power == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+
+	*varibright_enable = core_power->varibright_prop.varibright_user_enable;
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+				WPP_BIT_FLAG_Backlight_ABM,
+				">get varibright enable state: varibright_user_enable=%u",
+				(unsigned int) (*varibright_enable));
+	return true;
+}
+
+bool mod_power_is_abm_active(struct mod_power *mod_power,
+		const struct dc_link *link,
+		unsigned int inst)
+{
+	unsigned int user_backlight = 0;
+	unsigned int current_backlight = 0;
+	bool is_active = false;
+
+	if (mod_power == NULL)
+		return false;
+
+	mod_power_get_backlight_pwm(mod_power, &user_backlight, inst);
+	mod_power_get_hw_backlight_pwm(mod_power, link,	&current_backlight);
+
+	if (user_backlight != current_backlight)
+		is_active = true;
+	else
+		is_active = false;
+	DC_TRACE_LEVEL_MESSAGEP(DAL_TRACE_LEVEL_INFORMATION,
+						WPP_BIT_FLAG_Backlight_ABM,
+						">get ABM active state: is_active=%u (user_backlight_pwm=%u, current_backlight_pwm=%u)",
+						(unsigned int)is_active,
+						user_backlight,
+						current_backlight);
+	return is_active;
+}
+
+static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
+		struct iram_table_v_2 *table)
+{
+	unsigned int i;
+	unsigned int num_entries = NUM_BL_CURVE_SEGS;
+	unsigned int lut_index;
+
+	table->backlight_thresholds[0] = 0;
+	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
+	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
+	table->backlight_thresholds[num_entries-1] = 0xFFFF;
+	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
+	table->backlight_offsets[num_entries-1] =
+		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
+
+	/* Setup all brightness levels between 0% and 100% exclusive
+	 * Fills brightness-to-backlight transform table. Backlight custom curve
+	 * describes transform from brightness to backlight. It will be defined
+	 * as set of thresholds and set of offsets, together, implying
+	 * extrapolation of custom curve into 16 uniformly spanned linear
+	 * segments.  Each threshold/offset represented by 16 bit entry in
+	 * format U4.10.
+	 */
+	for (i = 1; i+1 < num_entries; i++) {
+		lut_index = (params.backlight_lut_array_size - 1) * i / (num_entries - 1);
+
+		ASSERT(lut_index < params.backlight_lut_array_size);
+
+		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
+		unsigned int offset_val = params.backlight_lut_array[lut_index];
+
+		ASSERT(threshold_val <= 0xFFFF);
+		ASSERT(offset_val <= 0xFFFF);
+
+		table->backlight_thresholds[i] = cpu_to_be16((uint16_t)threshold_val);
+		table->backlight_offsets[i]    = cpu_to_be16((uint16_t)offset_val);
+	}
+}
+
+static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters params,
+		struct iram_table_v_2_2 *table, bool big_endian)
+{
+	unsigned int i;
+	unsigned int num_entries = NUM_BL_CURVE_SEGS;
+	unsigned int lut_index;
+
+	table->backlight_thresholds[0] = 0;
+	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
+	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
+	table->backlight_thresholds[num_entries-1] = 0xFFFF;
+	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
+	table->backlight_offsets[num_entries-1] =
+		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
+
+	/* Setup all brightness levels between 0% and 100% exclusive
+	 * Fills brightness-to-backlight transform table. Backlight custom curve
+	 * describes transform from brightness to backlight. It will be defined
+	 * as set of thresholds and set of offsets, together, implying
+	 * extrapolation of custom curve into 16 uniformly spanned linear
+	 * segments.  Each threshold/offset represented by 16 bit entry in
+	 * format U4.10.
+	 */
+	for (i = 1; i+1 < num_entries; i++) {
+		lut_index = DIV_ROUNDUP((i * params.backlight_lut_array_size), num_entries);
+		ASSERT(lut_index < params.backlight_lut_array_size);
+
+		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
+		unsigned int offset_val = params.backlight_lut_array[lut_index];
+
+		ASSERT(threshold_val <= 0xFFFF);
+		ASSERT(offset_val <= 0xFFFF);
+
+		table->backlight_thresholds[i] = (big_endian) ?
+			cpu_to_be16((uint16_t)threshold_val) : cpu_to_le16((uint16_t)threshold_val);
+		table->backlight_offsets[i] = (big_endian) ?
+			cpu_to_be16((uint16_t)offset_val) : cpu_to_le16((uint16_t)offset_val);
+	}
+}
+
+static void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters params)
+{
+	unsigned int set = params.set;
+
+	ram_table->min_abm_backlight =
+			cpu_to_be16(params.min_abm_backlight);
+	ram_table->deviation_gain = 0xb3;
+
+	ram_table->blRampReduction =
+		cpu_to_be16(params.backlight_ramping_reduction);
+	ram_table->blRampStart =
+		cpu_to_be16(params.backlight_ramping_start);
+
+	ram_table->min_reduction[0][0] = min_reduction_table[abm_config[set][0]];
+	ram_table->min_reduction[1][0] = min_reduction_table[abm_config[set][0]];
+	ram_table->min_reduction[2][0] = min_reduction_table[abm_config[set][0]];
+	ram_table->min_reduction[3][0] = min_reduction_table[abm_config[set][0]];
+	ram_table->min_reduction[4][0] = min_reduction_table[abm_config[set][0]];
+	ram_table->max_reduction[0][0] = max_reduction_table[abm_config[set][0]];
+	ram_table->max_reduction[1][0] = max_reduction_table[abm_config[set][0]];
+	ram_table->max_reduction[2][0] = max_reduction_table[abm_config[set][0]];
+	ram_table->max_reduction[3][0] = max_reduction_table[abm_config[set][0]];
+	ram_table->max_reduction[4][0] = max_reduction_table[abm_config[set][0]];
+
+	ram_table->min_reduction[0][1] = min_reduction_table[abm_config[set][1]];
+	ram_table->min_reduction[1][1] = min_reduction_table[abm_config[set][1]];
+	ram_table->min_reduction[2][1] = min_reduction_table[abm_config[set][1]];
+	ram_table->min_reduction[3][1] = min_reduction_table[abm_config[set][1]];
+	ram_table->min_reduction[4][1] = min_reduction_table[abm_config[set][1]];
+	ram_table->max_reduction[0][1] = max_reduction_table[abm_config[set][1]];
+	ram_table->max_reduction[1][1] = max_reduction_table[abm_config[set][1]];
+	ram_table->max_reduction[2][1] = max_reduction_table[abm_config[set][1]];
+	ram_table->max_reduction[3][1] = max_reduction_table[abm_config[set][1]];
+	ram_table->max_reduction[4][1] = max_reduction_table[abm_config[set][1]];
+
+	ram_table->min_reduction[0][2] = min_reduction_table[abm_config[set][2]];
+	ram_table->min_reduction[1][2] = min_reduction_table[abm_config[set][2]];
+	ram_table->min_reduction[2][2] = min_reduction_table[abm_config[set][2]];
+	ram_table->min_reduction[3][2] = min_reduction_table[abm_config[set][2]];
+	ram_table->min_reduction[4][2] = min_reduction_table[abm_config[set][2]];
+	ram_table->max_reduction[0][2] = max_reduction_table[abm_config[set][2]];
+	ram_table->max_reduction[1][2] = max_reduction_table[abm_config[set][2]];
+	ram_table->max_reduction[2][2] = max_reduction_table[abm_config[set][2]];
+	ram_table->max_reduction[3][2] = max_reduction_table[abm_config[set][2]];
+	ram_table->max_reduction[4][2] = max_reduction_table[abm_config[set][2]];
+
+	ram_table->min_reduction[0][3] = min_reduction_table[abm_config[set][3]];
+	ram_table->min_reduction[1][3] = min_reduction_table[abm_config[set][3]];
+	ram_table->min_reduction[2][3] = min_reduction_table[abm_config[set][3]];
+	ram_table->min_reduction[3][3] = min_reduction_table[abm_config[set][3]];
+	ram_table->min_reduction[4][3] = min_reduction_table[abm_config[set][3]];
+	ram_table->max_reduction[0][3] = max_reduction_table[abm_config[set][3]];
+	ram_table->max_reduction[1][3] = max_reduction_table[abm_config[set][3]];
+	ram_table->max_reduction[2][3] = max_reduction_table[abm_config[set][3]];
+	ram_table->max_reduction[3][3] = max_reduction_table[abm_config[set][3]];
+	ram_table->max_reduction[4][3] = max_reduction_table[abm_config[set][3]];
+
+	ram_table->bright_pos_gain[0][0] = 0x20;
+	ram_table->bright_pos_gain[0][1] = 0x20;
+	ram_table->bright_pos_gain[0][2] = 0x20;
+	ram_table->bright_pos_gain[0][3] = 0x20;
+	ram_table->bright_pos_gain[1][0] = 0x20;
+	ram_table->bright_pos_gain[1][1] = 0x20;
+	ram_table->bright_pos_gain[1][2] = 0x20;
+	ram_table->bright_pos_gain[1][3] = 0x20;
+	ram_table->bright_pos_gain[2][0] = 0x20;
+	ram_table->bright_pos_gain[2][1] = 0x20;
+	ram_table->bright_pos_gain[2][2] = 0x20;
+	ram_table->bright_pos_gain[2][3] = 0x20;
+	ram_table->bright_pos_gain[3][0] = 0x20;
+	ram_table->bright_pos_gain[3][1] = 0x20;
+	ram_table->bright_pos_gain[3][2] = 0x20;
+	ram_table->bright_pos_gain[3][3] = 0x20;
+	ram_table->bright_pos_gain[4][0] = 0x20;
+	ram_table->bright_pos_gain[4][1] = 0x20;
+	ram_table->bright_pos_gain[4][2] = 0x20;
+	ram_table->bright_pos_gain[4][3] = 0x20;
+	ram_table->bright_neg_gain[0][0] = 0x00;
+	ram_table->bright_neg_gain[0][1] = 0x00;
+	ram_table->bright_neg_gain[0][2] = 0x00;
+	ram_table->bright_neg_gain[0][3] = 0x00;
+	ram_table->bright_neg_gain[1][0] = 0x00;
+	ram_table->bright_neg_gain[1][1] = 0x00;
+	ram_table->bright_neg_gain[1][2] = 0x00;
+	ram_table->bright_neg_gain[1][3] = 0x00;
+	ram_table->bright_neg_gain[2][0] = 0x00;
+	ram_table->bright_neg_gain[2][1] = 0x00;
+	ram_table->bright_neg_gain[2][2] = 0x00;
+	ram_table->bright_neg_gain[2][3] = 0x00;
+	ram_table->bright_neg_gain[3][0] = 0x00;
+	ram_table->bright_neg_gain[3][1] = 0x00;
+	ram_table->bright_neg_gain[3][2] = 0x00;
+	ram_table->bright_neg_gain[3][3] = 0x00;
+	ram_table->bright_neg_gain[4][0] = 0x00;
+	ram_table->bright_neg_gain[4][1] = 0x00;
+	ram_table->bright_neg_gain[4][2] = 0x00;
+	ram_table->bright_neg_gain[4][3] = 0x00;
+	ram_table->dark_pos_gain[0][0] = 0x00;
+	ram_table->dark_pos_gain[0][1] = 0x00;
+	ram_table->dark_pos_gain[0][2] = 0x00;
+	ram_table->dark_pos_gain[0][3] = 0x00;
+	ram_table->dark_pos_gain[1][0] = 0x00;
+	ram_table->dark_pos_gain[1][1] = 0x00;
+	ram_table->dark_pos_gain[1][2] = 0x00;
+	ram_table->dark_pos_gain[1][3] = 0x00;
+	ram_table->dark_pos_gain[2][0] = 0x00;
+	ram_table->dark_pos_gain[2][1] = 0x00;
+	ram_table->dark_pos_gain[2][2] = 0x00;
+	ram_table->dark_pos_gain[2][3] = 0x00;
+	ram_table->dark_pos_gain[3][0] = 0x00;
+	ram_table->dark_pos_gain[3][1] = 0x00;
+	ram_table->dark_pos_gain[3][2] = 0x00;
+	ram_table->dark_pos_gain[3][3] = 0x00;
+	ram_table->dark_pos_gain[4][0] = 0x00;
+	ram_table->dark_pos_gain[4][1] = 0x00;
+	ram_table->dark_pos_gain[4][2] = 0x00;
+	ram_table->dark_pos_gain[4][3] = 0x00;
+	ram_table->dark_neg_gain[0][0] = 0x00;
+	ram_table->dark_neg_gain[0][1] = 0x00;
+	ram_table->dark_neg_gain[0][2] = 0x00;
+	ram_table->dark_neg_gain[0][3] = 0x00;
+	ram_table->dark_neg_gain[1][0] = 0x00;
+	ram_table->dark_neg_gain[1][1] = 0x00;
+	ram_table->dark_neg_gain[1][2] = 0x00;
+	ram_table->dark_neg_gain[1][3] = 0x00;
+	ram_table->dark_neg_gain[2][0] = 0x00;
+	ram_table->dark_neg_gain[2][1] = 0x00;
+	ram_table->dark_neg_gain[2][2] = 0x00;
+	ram_table->dark_neg_gain[2][3] = 0x00;
+	ram_table->dark_neg_gain[3][0] = 0x00;
+	ram_table->dark_neg_gain[3][1] = 0x00;
+	ram_table->dark_neg_gain[3][2] = 0x00;
+	ram_table->dark_neg_gain[3][3] = 0x00;
+	ram_table->dark_neg_gain[4][0] = 0x00;
+	ram_table->dark_neg_gain[4][1] = 0x00;
+	ram_table->dark_neg_gain[4][2] = 0x00;
+	ram_table->dark_neg_gain[4][3] = 0x00;
+
+	ram_table->iir_curve[0] = 0x65;
+	ram_table->iir_curve[1] = 0x65;
+	ram_table->iir_curve[2] = 0x65;
+	ram_table->iir_curve[3] = 0x65;
+	ram_table->iir_curve[4] = 0x65;
+
+	//Gamma 2.4
+	ram_table->crgb_thresh[0] = cpu_to_be16(0x13b6);
+	ram_table->crgb_thresh[1] = cpu_to_be16(0x1648);
+	ram_table->crgb_thresh[2] = cpu_to_be16(0x18e3);
+	ram_table->crgb_thresh[3] = cpu_to_be16(0x1b41);
+	ram_table->crgb_thresh[4] = cpu_to_be16(0x1d46);
+	ram_table->crgb_thresh[5] = cpu_to_be16(0x1f21);
+	ram_table->crgb_thresh[6] = cpu_to_be16(0x2167);
+	ram_table->crgb_thresh[7] = cpu_to_be16(0x2384);
+	ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
+	ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
+	ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
+	ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
+	ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
+	ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
+	ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
+	ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
+	ram_table->crgb_slope[0]  = cpu_to_be16(0x3147);
+	ram_table->crgb_slope[1]  = cpu_to_be16(0x2978);
+	ram_table->crgb_slope[2]  = cpu_to_be16(0x23a2);
+	ram_table->crgb_slope[3]  = cpu_to_be16(0x1f55);
+	ram_table->crgb_slope[4]  = cpu_to_be16(0x1c63);
+	ram_table->crgb_slope[5]  = cpu_to_be16(0x1a0f);
+	ram_table->crgb_slope[6]  = cpu_to_be16(0x178d);
+	ram_table->crgb_slope[7]  = cpu_to_be16(0x15ab);
+
+	fill_backlight_transform_table(
+			params, ram_table);
+}
+
+static void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params)
+{
+	unsigned int set = params.set;
+
+	ram_table->flags = 0x0;
+
+	ram_table->min_abm_backlight =
+			cpu_to_be16(params.min_abm_backlight);
+
+	ram_table->deviation_gain[0] = 0xb3;
+	ram_table->deviation_gain[1] = 0xa8;
+	ram_table->deviation_gain[2] = 0x98;
+	ram_table->deviation_gain[3] = 0x68;
+
+	ram_table->min_reduction[0][0] = min_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->min_reduction[1][0] = min_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->min_reduction[2][0] = min_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->min_reduction[3][0] = min_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->min_reduction[4][0] = min_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->max_reduction[0][0] = max_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->max_reduction[1][0] = max_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->max_reduction[2][0] = max_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->max_reduction[3][0] = max_reduction_table_v_2_2[abm_config[set][0]];
+	ram_table->max_reduction[4][0] = max_reduction_table_v_2_2[abm_config[set][0]];
+
+	ram_table->min_reduction[0][1] = min_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->min_reduction[1][1] = min_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->min_reduction[2][1] = min_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->min_reduction[3][1] = min_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->min_reduction[4][1] = min_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->max_reduction[0][1] = max_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->max_reduction[1][1] = max_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->max_reduction[2][1] = max_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->max_reduction[3][1] = max_reduction_table_v_2_2[abm_config[set][1]];
+	ram_table->max_reduction[4][1] = max_reduction_table_v_2_2[abm_config[set][1]];
+
+	ram_table->min_reduction[0][2] = min_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->min_reduction[1][2] = min_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->min_reduction[2][2] = min_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->min_reduction[3][2] = min_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->min_reduction[4][2] = min_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->max_reduction[0][2] = max_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->max_reduction[1][2] = max_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->max_reduction[2][2] = max_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->max_reduction[3][2] = max_reduction_table_v_2_2[abm_config[set][2]];
+	ram_table->max_reduction[4][2] = max_reduction_table_v_2_2[abm_config[set][2]];
+
+	ram_table->min_reduction[0][3] = min_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->min_reduction[1][3] = min_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->min_reduction[2][3] = min_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->min_reduction[3][3] = min_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->min_reduction[4][3] = min_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->max_reduction[0][3] = max_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->max_reduction[1][3] = max_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->max_reduction[2][3] = max_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->max_reduction[3][3] = max_reduction_table_v_2_2[abm_config[set][3]];
+	ram_table->max_reduction[4][3] = max_reduction_table_v_2_2[abm_config[set][3]];
+
+	ram_table->bright_pos_gain[0][0] = 0x20;
+	ram_table->bright_pos_gain[0][1] = 0x20;
+	ram_table->bright_pos_gain[0][2] = 0x20;
+	ram_table->bright_pos_gain[0][3] = 0x20;
+	ram_table->bright_pos_gain[1][0] = 0x20;
+	ram_table->bright_pos_gain[1][1] = 0x20;
+	ram_table->bright_pos_gain[1][2] = 0x20;
+	ram_table->bright_pos_gain[1][3] = 0x20;
+	ram_table->bright_pos_gain[2][0] = 0x20;
+	ram_table->bright_pos_gain[2][1] = 0x20;
+	ram_table->bright_pos_gain[2][2] = 0x20;
+	ram_table->bright_pos_gain[2][3] = 0x20;
+	ram_table->bright_pos_gain[3][0] = 0x20;
+	ram_table->bright_pos_gain[3][1] = 0x20;
+	ram_table->bright_pos_gain[3][2] = 0x20;
+	ram_table->bright_pos_gain[3][3] = 0x20;
+	ram_table->bright_pos_gain[4][0] = 0x20;
+	ram_table->bright_pos_gain[4][1] = 0x20;
+	ram_table->bright_pos_gain[4][2] = 0x20;
+	ram_table->bright_pos_gain[4][3] = 0x20;
+
+	ram_table->dark_pos_gain[0][0] = 0x00;
+	ram_table->dark_pos_gain[0][1] = 0x00;
+	ram_table->dark_pos_gain[0][2] = 0x00;
+	ram_table->dark_pos_gain[0][3] = 0x00;
+	ram_table->dark_pos_gain[1][0] = 0x00;
+	ram_table->dark_pos_gain[1][1] = 0x00;
+	ram_table->dark_pos_gain[1][2] = 0x00;
+	ram_table->dark_pos_gain[1][3] = 0x00;
+	ram_table->dark_pos_gain[2][0] = 0x00;
+	ram_table->dark_pos_gain[2][1] = 0x00;
+	ram_table->dark_pos_gain[2][2] = 0x00;
+	ram_table->dark_pos_gain[2][3] = 0x00;
+	ram_table->dark_pos_gain[3][0] = 0x00;
+	ram_table->dark_pos_gain[3][1] = 0x00;
+	ram_table->dark_pos_gain[3][2] = 0x00;
+	ram_table->dark_pos_gain[3][3] = 0x00;
+	ram_table->dark_pos_gain[4][0] = 0x00;
+	ram_table->dark_pos_gain[4][1] = 0x00;
+	ram_table->dark_pos_gain[4][2] = 0x00;
+	ram_table->dark_pos_gain[4][3] = 0x00;
+
+	ram_table->hybrid_factor[0] = 0xff;
+	ram_table->hybrid_factor[1] = 0xff;
+	ram_table->hybrid_factor[2] = 0xff;
+	ram_table->hybrid_factor[3] = 0xc0;
+
+	ram_table->contrast_factor[0] = 0x99;
+	ram_table->contrast_factor[1] = 0x99;
+	ram_table->contrast_factor[2] = 0x90;
+	ram_table->contrast_factor[3] = 0x80;
+
+	ram_table->iir_curve[0] = 0x65;
+	ram_table->iir_curve[1] = 0x65;
+	ram_table->iir_curve[2] = 0x65;
+	ram_table->iir_curve[3] = 0x65;
+	ram_table->iir_curve[4] = 0x65;
+
+	//Gamma 2.2
+	ram_table->crgb_thresh[0] = cpu_to_be16(0x127c);
+	ram_table->crgb_thresh[1] = cpu_to_be16(0x151b);
+	ram_table->crgb_thresh[2] = cpu_to_be16(0x17d5);
+	ram_table->crgb_thresh[3] = cpu_to_be16(0x1a56);
+	ram_table->crgb_thresh[4] = cpu_to_be16(0x1c83);
+	ram_table->crgb_thresh[5] = cpu_to_be16(0x1e72);
+	ram_table->crgb_thresh[6] = cpu_to_be16(0x20f0);
+	ram_table->crgb_thresh[7] = cpu_to_be16(0x232b);
+	ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
+	ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
+	ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
+	ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
+	ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
+	ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
+	ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
+	ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
+	ram_table->crgb_slope[0]  = cpu_to_be16(0x3609);
+	ram_table->crgb_slope[1]  = cpu_to_be16(0x2dfa);
+	ram_table->crgb_slope[2]  = cpu_to_be16(0x27ea);
+	ram_table->crgb_slope[3]  = cpu_to_be16(0x235d);
+	ram_table->crgb_slope[4]  = cpu_to_be16(0x2042);
+	ram_table->crgb_slope[5]  = cpu_to_be16(0x1dc3);
+	ram_table->crgb_slope[6]  = cpu_to_be16(0x1b1a);
+	ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
+
+	fill_backlight_transform_table_v_2_2(
+			params, ram_table, true);
+}
+
+static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params, bool big_endian)
+{
+	unsigned int i, j;
+	unsigned int set = params.set;
+
+	ram_table->flags = 0x0;
+	ram_table->min_abm_backlight = (uint16_t)((big_endian) ?
+		cpu_to_be16(params.min_abm_backlight) :
+		cpu_to_le16(params.min_abm_backlight));
+
+	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+		ram_table->hybrid_factor[i] = (uint8_t)abm_settings[set][i].brightness_gain;
+		ram_table->contrast_factor[i] = abm_settings[set][i].contrast_factor;
+		ram_table->deviation_gain[i] = abm_settings[set][i].deviation_gain;
+		ram_table->min_knee[i] = abm_settings[set][i].min_knee;
+		ram_table->max_knee[i] = abm_settings[set][i].max_knee;
+
+		for (j = 0; j < NUM_AMBI_LEVEL; j++) {
+			ram_table->min_reduction[j][i] = abm_settings[set][i].min_reduction;
+			ram_table->max_reduction[j][i] = abm_settings[set][i].max_reduction;
+			ram_table->bright_pos_gain[j][i] = abm_settings[set][i].bright_pos_gain;
+			ram_table->dark_pos_gain[j][i] = abm_settings[set][i].dark_pos_gain;
+		}
+	}
+
+	ram_table->iir_curve[0] = 0x65;
+	ram_table->iir_curve[1] = 0x65;
+	ram_table->iir_curve[2] = 0x65;
+	ram_table->iir_curve[3] = 0x65;
+	ram_table->iir_curve[4] = 0x65;
+
+	//Gamma 2.2
+	ram_table->crgb_thresh[0] = bswap16_based_on_endian(big_endian, 0x127c);
+	ram_table->crgb_thresh[1] = bswap16_based_on_endian(big_endian, 0x151b);
+	ram_table->crgb_thresh[2] = bswap16_based_on_endian(big_endian, 0x17d5);
+	ram_table->crgb_thresh[3] = bswap16_based_on_endian(big_endian, 0x1a56);
+	ram_table->crgb_thresh[4] = bswap16_based_on_endian(big_endian, 0x1c83);
+	ram_table->crgb_thresh[5] = bswap16_based_on_endian(big_endian, 0x1e72);
+	ram_table->crgb_thresh[6] = bswap16_based_on_endian(big_endian, 0x20f0);
+	ram_table->crgb_thresh[7] = bswap16_based_on_endian(big_endian, 0x232b);
+	ram_table->crgb_offset[0] = bswap16_based_on_endian(big_endian, 0x2999);
+	ram_table->crgb_offset[1] = bswap16_based_on_endian(big_endian, 0x3999);
+	ram_table->crgb_offset[2] = bswap16_based_on_endian(big_endian, 0x4666);
+	ram_table->crgb_offset[3] = bswap16_based_on_endian(big_endian, 0x5999);
+	ram_table->crgb_offset[4] = bswap16_based_on_endian(big_endian, 0x6333);
+	ram_table->crgb_offset[5] = bswap16_based_on_endian(big_endian, 0x7800);
+	ram_table->crgb_offset[6] = bswap16_based_on_endian(big_endian, 0x8c00);
+	ram_table->crgb_offset[7] = bswap16_based_on_endian(big_endian, 0xa000);
+	ram_table->crgb_slope[0]  = bswap16_based_on_endian(big_endian, 0x3609);
+	ram_table->crgb_slope[1]  = bswap16_based_on_endian(big_endian, 0x2dfa);
+	ram_table->crgb_slope[2]  = bswap16_based_on_endian(big_endian, 0x27ea);
+	ram_table->crgb_slope[3]  = bswap16_based_on_endian(big_endian, 0x235d);
+	ram_table->crgb_slope[4]  = bswap16_based_on_endian(big_endian, 0x2042);
+	ram_table->crgb_slope[5]  = bswap16_based_on_endian(big_endian, 0x1dc3);
+	ram_table->crgb_slope[6]  = bswap16_based_on_endian(big_endian, 0x1b1a);
+	ram_table->crgb_slope[7]  = bswap16_based_on_endian(big_endian, 0x1910);
+
+	fill_backlight_transform_table_v_2_2(
+			params, ram_table, big_endian);
+}
+
+bool dmub_init_abm_config(struct resource_pool *res_pool,
+	struct dmcu_iram_parameters params,
+	unsigned int inst)
+{
+	struct iram_table_v_2_2 ram_table;
+	struct abm_config_table config;
+	unsigned int set = params.set;
+	bool result = false;
+	uint32_t i, j = 0;
+
+	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
+		return false;
+
+	memset(&ram_table, 0, sizeof(ram_table));
+	memset(&config, 0, sizeof(config));
+
+	fill_iram_v_2_3(&ram_table, params, false);
+
+	// We must copy to structure that is aligned to 32-bit
+	for (i = 0; i < NUM_POWER_FN_SEGS; i++) {
+		config.crgb_thresh[i] = ram_table.crgb_thresh[i];
+		config.crgb_offset[i] = ram_table.crgb_offset[i];
+		config.crgb_slope[i] = ram_table.crgb_slope[i];
+	}
+
+	for (i = 0; i < NUM_BL_CURVE_SEGS; i++) {
+		config.backlight_thresholds[i] = ram_table.backlight_thresholds[i];
+		config.backlight_offsets[i] = ram_table.backlight_offsets[i];
+	}
+
+	for (i = 0; i < NUM_AMBI_LEVEL; i++)
+		config.iir_curve[i] = ram_table.iir_curve[i];
+
+	for (i = 0; i < NUM_AMBI_LEVEL; i++) {
+		for (j = 0; j < NUM_AGGR_LEVEL; j++) {
+			config.min_reduction[i][j] = ram_table.min_reduction[i][j];
+			config.max_reduction[i][j] = ram_table.max_reduction[i][j];
+			config.bright_pos_gain[i][j] = ram_table.bright_pos_gain[i][j];
+			config.dark_pos_gain[i][j] = ram_table.dark_pos_gain[i][j];
+		}
+	}
+
+	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+		config.hybrid_factor[i] = ram_table.hybrid_factor[i];
+		config.contrast_factor[i] = ram_table.contrast_factor[i];
+		config.deviation_gain[i] = ram_table.deviation_gain[i];
+		config.min_knee[i] = ram_table.min_knee[i];
+		config.max_knee[i] = ram_table.max_knee[i];
+	}
+
+	if (params.backlight_ramping_override) {
+
+		ASSERT(params.backlight_ramping_reduction <= 0xFFFF);
+		ASSERT(params.backlight_ramping_start <= 0xFFFF);
+		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+			config.blRampReduction[i] = (uint16_t)params.backlight_ramping_reduction;
+			config.blRampStart[i]     = (uint16_t)params.backlight_ramping_start;
+		}
+	} else {
+		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+			config.blRampReduction[i] = abm_settings[set][i].blRampReduction;
+			config.blRampStart[i] = abm_settings[set][i].blRampStart;
+		}
+	}
+
+	config.min_abm_backlight = ram_table.min_abm_backlight;
+
+	if (res_pool->multiple_abms[inst]) {
+		result = res_pool->multiple_abms[inst]->funcs->init_abm_config(
+			res_pool->multiple_abms[inst], (char *)(&config), sizeof(struct abm_config_table), inst);
+	} else
+		result = res_pool->abm->funcs->init_abm_config(
+			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table), 0);
+
+	return result;
+}
+
+bool dmcu_load_iram(struct dmcu *dmcu,
+	struct dmcu_iram_parameters params)
+{
+	unsigned char ram_table[IRAM_SIZE];
+	bool result = false;
+
+	if (dmcu == NULL)
+		return false;
+
+	if (dmcu && !dmcu->funcs->is_dmcu_initialized(dmcu))
+		return true;
+
+	memset(&ram_table, 0, sizeof(ram_table));
+
+	if (dmcu->dmcu_version.abm_version == 0x24) {
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
+		result = dmcu->funcs->load_iram(dmcu, 0, (char *)(&ram_table),
+						IRAM_RESERVE_AREA_START_V2_2);
+	} else if (dmcu->dmcu_version.abm_version == 0x23) {
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
+
+		result = dmcu->funcs->load_iram(
+				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+	} else if (dmcu->dmcu_version.abm_version == 0x22) {
+		fill_iram_v_2_2((struct iram_table_v_2_2 *)ram_table, params);
+
+		result = dmcu->funcs->load_iram(
+				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+	} else {
+		fill_iram_v_2((struct iram_table_v_2 *)ram_table, params);
+
+		result = dmcu->funcs->load_iram(
+				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2);
+
+		if (result)
+			result = dmcu->funcs->load_iram(
+					dmcu, IRAM_RESERVE_AREA_END_V2 + 1,
+					(char *)(&ram_table) + IRAM_RESERVE_AREA_END_V2 + 1,
+					sizeof(ram_table) - IRAM_RESERVE_AREA_END_V2 - 1);
+	}
+
+	return result;
+}
+
+bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
+{
+	unsigned int data_points_size;
+	uint64_t caps_size;
+
+	if (config_no >= ARRAY_SIZE(custom_backlight_profiles))
+		return false;
+
+	data_points_size = custom_backlight_profiles[config_no].num_data_points
+			* sizeof(custom_backlight_profiles[config_no].data_points[0]);
+
+	caps_size = sizeof(struct dm_acpi_atif_backlight_caps) - sizeof(caps->data_points) + data_points_size;
+	ASSERT(caps_size <= 0xFFFF);
+	caps->size = (uint16_t)caps_size;
+	caps->flags = 0;
+	caps->error_code = 0;
+	caps->ac_level_percentage = custom_backlight_profiles[config_no].ac_level_percentage;
+	caps->dc_level_percentage = custom_backlight_profiles[config_no].dc_level_percentage;
+	caps->min_input_signal = custom_backlight_profiles[config_no].min_input_signal;
+	caps->max_input_signal = custom_backlight_profiles[config_no].max_input_signal;
+	caps->num_data_points = (uint8_t)custom_backlight_profiles[config_no].num_data_points;
+	memcpy(caps->data_points, custom_backlight_profiles[config_no].data_points, data_points_size);
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index f55c15199fb4..1046fc35f8f9 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -33,796 +33,6 @@
 #define bswap16_based_on_endian(big_endian, value) \
 	((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
 
-/* Possible Min Reduction config from least aggressive to most aggressive
- *  0    1     2     3     4     5     6     7     8     9     10    11   12
- * 100  98.0 94.1  94.1  85.1  80.3  75.3  69.4  60.0  57.6  50.2  49.8  40.0 %
- */
-static const unsigned char min_reduction_table[13] = {
-0xff, 0xfa, 0xf0, 0xf0, 0xd9, 0xcd, 0xc0, 0xb1, 0x99, 0x93, 0x80, 0x82, 0x66};
-
-/* Possible Max Reduction configs from least aggressive to most aggressive
- *  0    1     2     3     4     5     6     7     8     9     10    11   12
- * 96.1 89.8 85.1  80.3  69.4  64.7  64.7  50.2  39.6  30.2  30.2  30.2  19.6 %
- */
-static const unsigned char max_reduction_table[13] = {
-0xf5, 0xe5, 0xd9, 0xcd, 0xb1, 0xa5, 0xa5, 0x80, 0x65, 0x4d, 0x4d, 0x4d, 0x32};
-
-/* Possible ABM 2.2 Min Reduction configs from least aggressive to most aggressive
- *  0    1     2     3     4     5     6     7     8     9     10    11   12
- * 100  100   100   100   100   100   100   100  100  92.2  83.1  75.3  75.3 %
- */
-static const unsigned char min_reduction_table_v_2_2[13] = {
-0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xeb, 0xd4, 0xc0, 0xc0};
-
-/* Possible ABM 2.2 Max Reduction configs from least aggressive to most aggressive
- *  0    1     2     3     4     5     6     7     8     9     10    11   12
- * 96.1 89.8 74.9  69.4  64.7  52.2  48.6  39.6  30.2  25.1  19.6  12.5  12.5 %
- */
-static const unsigned char max_reduction_table_v_2_2[13] = {
-0xf5, 0xe5, 0xbf, 0xb1, 0xa5, 0x85, 0x7c, 0x65, 0x4d, 0x40, 0x32, 0x20, 0x20};
-
-/* Predefined ABM configuration sets. We may have different configuration sets
- * in order to satisfy different power/quality requirements.
- */
-static const unsigned char abm_config[abm_defines_max_config][abm_defines_max_level] = {
-/*  ABM Level 1,    ABM Level 2,    ABM Level 3,    ABM Level 4 */
-{       2,              5,              7,              8       },	/* Default - Medium aggressiveness */
-{       2,              5,              8,              11      },	/* Alt #1  - Increased aggressiveness */
-{       0,              2,              4,              8       },	/* Alt #2  - Minimal aggressiveness */
-{       3,              6,              10,             12      },	/* Alt #3  - Super aggressiveness */
-};
-
-struct abm_parameters {
-	unsigned char min_reduction;
-	unsigned char max_reduction;
-	unsigned char bright_pos_gain;
-	unsigned char dark_pos_gain;
-	unsigned char brightness_gain;
-	unsigned char contrast_factor;
-	unsigned char deviation_gain;
-	unsigned char min_knee;
-	unsigned char max_knee;
-	unsigned short blRampReduction;
-	unsigned short blRampStart;
-};
-
-static const struct abm_parameters abm_settings_config0[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
-	{0xff,   0xbf,    0x20,       0x00,     0xff,        0x99,     0xb3, 0x40,     0xe0,     0xf777,  0xcccc},
-	{0xde,   0x85,    0x20,       0x00,     0xe0,        0x90,     0xa8, 0x40,     0xc8,     0xf777,  0xcccc},
-	{0xb0,   0x50,    0x20,       0x00,     0xc0,        0x88,     0x78, 0x70,     0xa0,     0xeeee,  0x9999},
-	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,     0xe333,  0xb333},
-};
-
-static const struct abm_parameters abm_settings_config1[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed  blStart
-	{0xf0,   0xd9,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
-	{0xcd,   0xa5,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
-	{0x99,   0x65,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
-	{0x82,   0x4d,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
-};
-
-static const struct abm_parameters abm_settings_config2[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
-	{0xf0,   0xbf,    0x20,       0x00,     0x88,        0x99,     0xb3, 0x40,     0xe0,    0x0000,  0xcccc},
-	{0xd8,   0x85,    0x20,       0x00,     0x70,        0x90,     0xa8, 0x40,     0xc8,    0x0700,  0xb333},
-	{0xb8,   0x58,    0x20,       0x00,     0x64,        0x88,     0x78, 0x70,     0xa0,    0x7000,  0x9999},
-	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,    0xc333,  0xb333},
-};
-
-static const struct abm_parameters * const abm_settings[] = {
-	abm_settings_config0,
-	abm_settings_config1,
-	abm_settings_config2,
-};
-
-static const struct dm_bl_data_point custom_backlight_curve0[] = {
-		{2, 14}, {4, 16}, {6, 18}, {8, 21}, {10, 23}, {12, 26}, {14, 29}, {16, 32}, {18, 35},
-		{20, 38}, {22, 41}, {24, 44}, {26, 48}, {28, 52}, {30, 55}, {32, 59}, {34, 62},
-		{36, 67}, {38, 71}, {40, 75}, {42, 80}, {44, 84}, {46, 88}, {48, 93}, {50, 98},
-		{52, 103}, {54, 108}, {56, 113}, {58, 118}, {60, 123}, {62, 129}, {64, 135}, {66, 140},
-		{68, 146}, {70, 152}, {72, 158}, {74, 164}, {76, 171}, {78, 177}, {80, 183}, {82, 190},
-		{84, 197}, {86, 204}, {88, 211}, {90, 218}, {92, 225}, {94, 232}, {96, 240}, {98, 247}};
-
-struct custom_backlight_profile {
-	uint8_t  ac_level_percentage;
-	uint8_t  dc_level_percentage;
-	uint8_t  min_input_signal;
-	uint8_t  max_input_signal;
-	uint8_t  num_data_points;
-	const struct dm_bl_data_point *data_points;
-};
-
-static const struct custom_backlight_profile custom_backlight_profiles[] = {
-		{100, 32, 12, 255, ARRAY_SIZE(custom_backlight_curve0), custom_backlight_curve0},
-};
-
-#define NUM_AMBI_LEVEL    5
-#define NUM_AGGR_LEVEL    4
-#define NUM_POWER_FN_SEGS 8
-#define NUM_BL_CURVE_SEGS 16
-#define IRAM_SIZE 256
-
-#define IRAM_RESERVE_AREA_START_V2 0xF0  // reserve 0xF0~0xF6 are write by DMCU only
-#define IRAM_RESERVE_AREA_END_V2 0xF6  // reserve 0xF0~0xF6 are write by DMCU only
-
-#define IRAM_RESERVE_AREA_START_V2_2 0xF0  // reserve 0xF0~0xFF are write by DMCU only
-#define IRAM_RESERVE_AREA_END_V2_2 0xFF  // reserve 0xF0~0xFF are write by DMCU only
-
-#pragma pack(push, 1)
-/* NOTE: iRAM is 256B in size */
-struct iram_table_v_2 {
-	/* flags                      */
-	uint16_t min_abm_backlight;					/* 0x00 U16  */
-
-	/* parameters for ABM2.0 algorithm */
-	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x02 U0.8 */
-	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x16 U0.8 */
-	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x2a U2.6 */
-	uint8_t bright_neg_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x3e U2.6 */
-	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x52 U2.6 */
-	uint8_t dark_neg_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x66 U2.6 */
-	uint8_t iir_curve[NUM_AMBI_LEVEL];				/* 0x7a U0.8 */
-	uint8_t deviation_gain;						/* 0x7f U0.8 */
-
-	/* parameters for crgb conversion */
-	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];			/* 0x80 U3.13 */
-	uint16_t crgb_offset[NUM_POWER_FN_SEGS];			/* 0x90 U1.15 */
-	uint16_t crgb_slope[NUM_POWER_FN_SEGS];				/* 0xa0 U4.12 */
-
-	/* parameters for custom curve */
-	/* thresholds for brightness --> backlight */
-	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];		/* 0xb0 U16.0 */
-	/* offsets for brightness --> backlight */
-	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];			/* 0xd0 U16.0 */
-
-	/* For reading PSR State directly from IRAM */
-	uint8_t psr_state;						/* 0xf0       */
-	uint8_t dmcu_mcp_interface_version;				/* 0xf1       */
-	uint8_t dmcu_abm_feature_version;				/* 0xf2       */
-	uint8_t dmcu_psr_feature_version;				/* 0xf3       */
-	uint16_t dmcu_version;						/* 0xf4       */
-	uint8_t dmcu_state;						/* 0xf6       */
-
-	uint16_t blRampReduction;					/* 0xf7       */
-	uint16_t blRampStart;						/* 0xf9       */
-	uint8_t dummy5;							/* 0xfb       */
-	uint8_t dummy6;							/* 0xfc       */
-	uint8_t dummy7;							/* 0xfd       */
-	uint8_t dummy8;							/* 0xfe       */
-	uint8_t dummy9;							/* 0xff       */
-};
-
-struct iram_table_v_2_2 {
-	/* flags                      */
-	uint16_t flags;							/* 0x00 U16  */
-
-	/* parameters for ABM2.2 algorithm */
-	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x02 U0.8 */
-	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x16 U0.8 */
-	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];	/* 0x2a U2.6 */
-	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];		/* 0x3e U2.6 */
-	uint8_t hybrid_factor[NUM_AGGR_LEVEL];				/* 0x52 U0.8 */
-	uint8_t contrast_factor[NUM_AGGR_LEVEL];			/* 0x56 U0.8 */
-	uint8_t deviation_gain[NUM_AGGR_LEVEL];				/* 0x5a U0.8 */
-	uint8_t iir_curve[NUM_AMBI_LEVEL];				/* 0x5e U0.8 */
-	uint8_t min_knee[NUM_AGGR_LEVEL];				/* 0x63 U0.8 */
-	uint8_t max_knee[NUM_AGGR_LEVEL];				/* 0x67 U0.8 */
-	uint16_t min_abm_backlight;					/* 0x6b U16  */
-	uint8_t pad[19];						/* 0x6d U0.8 */
-
-	/* parameters for crgb conversion */
-	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];			/* 0x80 U3.13 */
-	uint16_t crgb_offset[NUM_POWER_FN_SEGS];			/* 0x90 U1.15 */
-	uint16_t crgb_slope[NUM_POWER_FN_SEGS];				/* 0xa0 U4.12 */
-
-	/* parameters for custom curve */
-	/* thresholds for brightness --> backlight */
-	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];		/* 0xb0 U16.0 */
-	/* offsets for brightness --> backlight */
-	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];			/* 0xd0 U16.0 */
-
-	/* For reading PSR State directly from IRAM */
-	uint8_t psr_state;						/* 0xf0       */
-	uint8_t dmcu_mcp_interface_version;				/* 0xf1       */
-	uint8_t dmcu_abm_feature_version;				/* 0xf2       */
-	uint8_t dmcu_psr_feature_version;				/* 0xf3       */
-	uint16_t dmcu_version;						/* 0xf4       */
-	uint8_t dmcu_state;						/* 0xf6       */
-
-	uint8_t dummy1;							/* 0xf7       */
-	uint8_t dummy2;							/* 0xf8       */
-	uint8_t dummy3;							/* 0xf9       */
-	uint8_t dummy4;							/* 0xfa       */
-	uint8_t dummy5;							/* 0xfb       */
-	uint8_t dummy6;							/* 0xfc       */
-	uint8_t dummy7;							/* 0xfd       */
-	uint8_t dummy8;							/* 0xfe       */
-	uint8_t dummy9;							/* 0xff       */
-};
-#pragma pack(pop)
-
-static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
-		struct iram_table_v_2 *table)
-{
-	unsigned int i;
-	unsigned int num_entries = NUM_BL_CURVE_SEGS;
-	unsigned int lut_index;
-
-	table->backlight_thresholds[0] = 0;
-	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
-	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
-	table->backlight_thresholds[num_entries-1] = 0xFFFF;
-	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
-	table->backlight_offsets[num_entries-1] =
-		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
-
-	/* Setup all brightness levels between 0% and 100% exclusive
-	 * Fills brightness-to-backlight transform table. Backlight custom curve
-	 * describes transform from brightness to backlight. It will be defined
-	 * as set of thresholds and set of offsets, together, implying
-	 * extrapolation of custom curve into 16 uniformly spanned linear
-	 * segments.  Each threshold/offset represented by 16 bit entry in
-	 * format U4.10.
-	 */
-	for (i = 1; i+1 < num_entries; i++) {
-		lut_index = (params.backlight_lut_array_size - 1) * i / (num_entries - 1);
-
-		ASSERT(lut_index < params.backlight_lut_array_size);
-
-		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
-		unsigned int offset_val = params.backlight_lut_array[lut_index];
-
-		ASSERT(threshold_val <= 0xFFFF);
-		ASSERT(offset_val <= 0xFFFF);
-
-		table->backlight_thresholds[i] = cpu_to_be16((uint16_t)threshold_val);
-		table->backlight_offsets[i]    = cpu_to_be16((uint16_t)offset_val);
-	}
-}
-
-static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters params,
-		struct iram_table_v_2_2 *table, bool big_endian)
-{
-	unsigned int i;
-	unsigned int num_entries = NUM_BL_CURVE_SEGS;
-	unsigned int lut_index;
-
-	table->backlight_thresholds[0] = 0;
-	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
-	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
-	table->backlight_thresholds[num_entries-1] = 0xFFFF;
-	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
-	table->backlight_offsets[num_entries-1] =
-		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
-
-	/* Setup all brightness levels between 0% and 100% exclusive
-	 * Fills brightness-to-backlight transform table. Backlight custom curve
-	 * describes transform from brightness to backlight. It will be defined
-	 * as set of thresholds and set of offsets, together, implying
-	 * extrapolation of custom curve into 16 uniformly spanned linear
-	 * segments.  Each threshold/offset represented by 16 bit entry in
-	 * format U4.10.
-	 */
-	for (i = 1; i+1 < num_entries; i++) {
-		lut_index = DIV_ROUNDUP((i * params.backlight_lut_array_size), num_entries);
-		ASSERT(lut_index < params.backlight_lut_array_size);
-
-		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
-		unsigned int offset_val = params.backlight_lut_array[lut_index];
-
-		ASSERT(threshold_val <= 0xFFFF);
-		ASSERT(offset_val <= 0xFFFF);
-
-		table->backlight_thresholds[i] = (big_endian) ?
-			cpu_to_be16((uint16_t)threshold_val) : cpu_to_le16((uint16_t)threshold_val);
-		table->backlight_offsets[i] = (big_endian) ?
-			cpu_to_be16((uint16_t)offset_val) : cpu_to_le16((uint16_t)offset_val);
-	}
-}
-
-static void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters params)
-{
-	unsigned int set = params.set;
-
-	ram_table->min_abm_backlight =
-			cpu_to_be16(params.min_abm_backlight);
-	ram_table->deviation_gain = 0xb3;
-
-	ram_table->blRampReduction =
-		cpu_to_be16(params.backlight_ramping_reduction);
-	ram_table->blRampStart =
-		cpu_to_be16(params.backlight_ramping_start);
-
-	ram_table->min_reduction[0][0] = min_reduction_table[abm_config[set][0]];
-	ram_table->min_reduction[1][0] = min_reduction_table[abm_config[set][0]];
-	ram_table->min_reduction[2][0] = min_reduction_table[abm_config[set][0]];
-	ram_table->min_reduction[3][0] = min_reduction_table[abm_config[set][0]];
-	ram_table->min_reduction[4][0] = min_reduction_table[abm_config[set][0]];
-	ram_table->max_reduction[0][0] = max_reduction_table[abm_config[set][0]];
-	ram_table->max_reduction[1][0] = max_reduction_table[abm_config[set][0]];
-	ram_table->max_reduction[2][0] = max_reduction_table[abm_config[set][0]];
-	ram_table->max_reduction[3][0] = max_reduction_table[abm_config[set][0]];
-	ram_table->max_reduction[4][0] = max_reduction_table[abm_config[set][0]];
-
-	ram_table->min_reduction[0][1] = min_reduction_table[abm_config[set][1]];
-	ram_table->min_reduction[1][1] = min_reduction_table[abm_config[set][1]];
-	ram_table->min_reduction[2][1] = min_reduction_table[abm_config[set][1]];
-	ram_table->min_reduction[3][1] = min_reduction_table[abm_config[set][1]];
-	ram_table->min_reduction[4][1] = min_reduction_table[abm_config[set][1]];
-	ram_table->max_reduction[0][1] = max_reduction_table[abm_config[set][1]];
-	ram_table->max_reduction[1][1] = max_reduction_table[abm_config[set][1]];
-	ram_table->max_reduction[2][1] = max_reduction_table[abm_config[set][1]];
-	ram_table->max_reduction[3][1] = max_reduction_table[abm_config[set][1]];
-	ram_table->max_reduction[4][1] = max_reduction_table[abm_config[set][1]];
-
-	ram_table->min_reduction[0][2] = min_reduction_table[abm_config[set][2]];
-	ram_table->min_reduction[1][2] = min_reduction_table[abm_config[set][2]];
-	ram_table->min_reduction[2][2] = min_reduction_table[abm_config[set][2]];
-	ram_table->min_reduction[3][2] = min_reduction_table[abm_config[set][2]];
-	ram_table->min_reduction[4][2] = min_reduction_table[abm_config[set][2]];
-	ram_table->max_reduction[0][2] = max_reduction_table[abm_config[set][2]];
-	ram_table->max_reduction[1][2] = max_reduction_table[abm_config[set][2]];
-	ram_table->max_reduction[2][2] = max_reduction_table[abm_config[set][2]];
-	ram_table->max_reduction[3][2] = max_reduction_table[abm_config[set][2]];
-	ram_table->max_reduction[4][2] = max_reduction_table[abm_config[set][2]];
-
-	ram_table->min_reduction[0][3] = min_reduction_table[abm_config[set][3]];
-	ram_table->min_reduction[1][3] = min_reduction_table[abm_config[set][3]];
-	ram_table->min_reduction[2][3] = min_reduction_table[abm_config[set][3]];
-	ram_table->min_reduction[3][3] = min_reduction_table[abm_config[set][3]];
-	ram_table->min_reduction[4][3] = min_reduction_table[abm_config[set][3]];
-	ram_table->max_reduction[0][3] = max_reduction_table[abm_config[set][3]];
-	ram_table->max_reduction[1][3] = max_reduction_table[abm_config[set][3]];
-	ram_table->max_reduction[2][3] = max_reduction_table[abm_config[set][3]];
-	ram_table->max_reduction[3][3] = max_reduction_table[abm_config[set][3]];
-	ram_table->max_reduction[4][3] = max_reduction_table[abm_config[set][3]];
-
-	ram_table->bright_pos_gain[0][0] = 0x20;
-	ram_table->bright_pos_gain[0][1] = 0x20;
-	ram_table->bright_pos_gain[0][2] = 0x20;
-	ram_table->bright_pos_gain[0][3] = 0x20;
-	ram_table->bright_pos_gain[1][0] = 0x20;
-	ram_table->bright_pos_gain[1][1] = 0x20;
-	ram_table->bright_pos_gain[1][2] = 0x20;
-	ram_table->bright_pos_gain[1][3] = 0x20;
-	ram_table->bright_pos_gain[2][0] = 0x20;
-	ram_table->bright_pos_gain[2][1] = 0x20;
-	ram_table->bright_pos_gain[2][2] = 0x20;
-	ram_table->bright_pos_gain[2][3] = 0x20;
-	ram_table->bright_pos_gain[3][0] = 0x20;
-	ram_table->bright_pos_gain[3][1] = 0x20;
-	ram_table->bright_pos_gain[3][2] = 0x20;
-	ram_table->bright_pos_gain[3][3] = 0x20;
-	ram_table->bright_pos_gain[4][0] = 0x20;
-	ram_table->bright_pos_gain[4][1] = 0x20;
-	ram_table->bright_pos_gain[4][2] = 0x20;
-	ram_table->bright_pos_gain[4][3] = 0x20;
-	ram_table->bright_neg_gain[0][0] = 0x00;
-	ram_table->bright_neg_gain[0][1] = 0x00;
-	ram_table->bright_neg_gain[0][2] = 0x00;
-	ram_table->bright_neg_gain[0][3] = 0x00;
-	ram_table->bright_neg_gain[1][0] = 0x00;
-	ram_table->bright_neg_gain[1][1] = 0x00;
-	ram_table->bright_neg_gain[1][2] = 0x00;
-	ram_table->bright_neg_gain[1][3] = 0x00;
-	ram_table->bright_neg_gain[2][0] = 0x00;
-	ram_table->bright_neg_gain[2][1] = 0x00;
-	ram_table->bright_neg_gain[2][2] = 0x00;
-	ram_table->bright_neg_gain[2][3] = 0x00;
-	ram_table->bright_neg_gain[3][0] = 0x00;
-	ram_table->bright_neg_gain[3][1] = 0x00;
-	ram_table->bright_neg_gain[3][2] = 0x00;
-	ram_table->bright_neg_gain[3][3] = 0x00;
-	ram_table->bright_neg_gain[4][0] = 0x00;
-	ram_table->bright_neg_gain[4][1] = 0x00;
-	ram_table->bright_neg_gain[4][2] = 0x00;
-	ram_table->bright_neg_gain[4][3] = 0x00;
-	ram_table->dark_pos_gain[0][0] = 0x00;
-	ram_table->dark_pos_gain[0][1] = 0x00;
-	ram_table->dark_pos_gain[0][2] = 0x00;
-	ram_table->dark_pos_gain[0][3] = 0x00;
-	ram_table->dark_pos_gain[1][0] = 0x00;
-	ram_table->dark_pos_gain[1][1] = 0x00;
-	ram_table->dark_pos_gain[1][2] = 0x00;
-	ram_table->dark_pos_gain[1][3] = 0x00;
-	ram_table->dark_pos_gain[2][0] = 0x00;
-	ram_table->dark_pos_gain[2][1] = 0x00;
-	ram_table->dark_pos_gain[2][2] = 0x00;
-	ram_table->dark_pos_gain[2][3] = 0x00;
-	ram_table->dark_pos_gain[3][0] = 0x00;
-	ram_table->dark_pos_gain[3][1] = 0x00;
-	ram_table->dark_pos_gain[3][2] = 0x00;
-	ram_table->dark_pos_gain[3][3] = 0x00;
-	ram_table->dark_pos_gain[4][0] = 0x00;
-	ram_table->dark_pos_gain[4][1] = 0x00;
-	ram_table->dark_pos_gain[4][2] = 0x00;
-	ram_table->dark_pos_gain[4][3] = 0x00;
-	ram_table->dark_neg_gain[0][0] = 0x00;
-	ram_table->dark_neg_gain[0][1] = 0x00;
-	ram_table->dark_neg_gain[0][2] = 0x00;
-	ram_table->dark_neg_gain[0][3] = 0x00;
-	ram_table->dark_neg_gain[1][0] = 0x00;
-	ram_table->dark_neg_gain[1][1] = 0x00;
-	ram_table->dark_neg_gain[1][2] = 0x00;
-	ram_table->dark_neg_gain[1][3] = 0x00;
-	ram_table->dark_neg_gain[2][0] = 0x00;
-	ram_table->dark_neg_gain[2][1] = 0x00;
-	ram_table->dark_neg_gain[2][2] = 0x00;
-	ram_table->dark_neg_gain[2][3] = 0x00;
-	ram_table->dark_neg_gain[3][0] = 0x00;
-	ram_table->dark_neg_gain[3][1] = 0x00;
-	ram_table->dark_neg_gain[3][2] = 0x00;
-	ram_table->dark_neg_gain[3][3] = 0x00;
-	ram_table->dark_neg_gain[4][0] = 0x00;
-	ram_table->dark_neg_gain[4][1] = 0x00;
-	ram_table->dark_neg_gain[4][2] = 0x00;
-	ram_table->dark_neg_gain[4][3] = 0x00;
-
-	ram_table->iir_curve[0] = 0x65;
-	ram_table->iir_curve[1] = 0x65;
-	ram_table->iir_curve[2] = 0x65;
-	ram_table->iir_curve[3] = 0x65;
-	ram_table->iir_curve[4] = 0x65;
-
-	//Gamma 2.4
-	ram_table->crgb_thresh[0] = cpu_to_be16(0x13b6);
-	ram_table->crgb_thresh[1] = cpu_to_be16(0x1648);
-	ram_table->crgb_thresh[2] = cpu_to_be16(0x18e3);
-	ram_table->crgb_thresh[3] = cpu_to_be16(0x1b41);
-	ram_table->crgb_thresh[4] = cpu_to_be16(0x1d46);
-	ram_table->crgb_thresh[5] = cpu_to_be16(0x1f21);
-	ram_table->crgb_thresh[6] = cpu_to_be16(0x2167);
-	ram_table->crgb_thresh[7] = cpu_to_be16(0x2384);
-	ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
-	ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
-	ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
-	ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
-	ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
-	ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
-	ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
-	ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
-	ram_table->crgb_slope[0]  = cpu_to_be16(0x3147);
-	ram_table->crgb_slope[1]  = cpu_to_be16(0x2978);
-	ram_table->crgb_slope[2]  = cpu_to_be16(0x23a2);
-	ram_table->crgb_slope[3]  = cpu_to_be16(0x1f55);
-	ram_table->crgb_slope[4]  = cpu_to_be16(0x1c63);
-	ram_table->crgb_slope[5]  = cpu_to_be16(0x1a0f);
-	ram_table->crgb_slope[6]  = cpu_to_be16(0x178d);
-	ram_table->crgb_slope[7]  = cpu_to_be16(0x15ab);
-
-	fill_backlight_transform_table(
-			params, ram_table);
-}
-
-static void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params)
-{
-	unsigned int set = params.set;
-
-	ram_table->flags = 0x0;
-
-	ram_table->min_abm_backlight =
-			cpu_to_be16(params.min_abm_backlight);
-
-	ram_table->deviation_gain[0] = 0xb3;
-	ram_table->deviation_gain[1] = 0xa8;
-	ram_table->deviation_gain[2] = 0x98;
-	ram_table->deviation_gain[3] = 0x68;
-
-	ram_table->min_reduction[0][0] = min_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->min_reduction[1][0] = min_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->min_reduction[2][0] = min_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->min_reduction[3][0] = min_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->min_reduction[4][0] = min_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->max_reduction[0][0] = max_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->max_reduction[1][0] = max_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->max_reduction[2][0] = max_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->max_reduction[3][0] = max_reduction_table_v_2_2[abm_config[set][0]];
-	ram_table->max_reduction[4][0] = max_reduction_table_v_2_2[abm_config[set][0]];
-
-	ram_table->min_reduction[0][1] = min_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->min_reduction[1][1] = min_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->min_reduction[2][1] = min_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->min_reduction[3][1] = min_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->min_reduction[4][1] = min_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->max_reduction[0][1] = max_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->max_reduction[1][1] = max_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->max_reduction[2][1] = max_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->max_reduction[3][1] = max_reduction_table_v_2_2[abm_config[set][1]];
-	ram_table->max_reduction[4][1] = max_reduction_table_v_2_2[abm_config[set][1]];
-
-	ram_table->min_reduction[0][2] = min_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->min_reduction[1][2] = min_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->min_reduction[2][2] = min_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->min_reduction[3][2] = min_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->min_reduction[4][2] = min_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->max_reduction[0][2] = max_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->max_reduction[1][2] = max_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->max_reduction[2][2] = max_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->max_reduction[3][2] = max_reduction_table_v_2_2[abm_config[set][2]];
-	ram_table->max_reduction[4][2] = max_reduction_table_v_2_2[abm_config[set][2]];
-
-	ram_table->min_reduction[0][3] = min_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->min_reduction[1][3] = min_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->min_reduction[2][3] = min_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->min_reduction[3][3] = min_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->min_reduction[4][3] = min_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->max_reduction[0][3] = max_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->max_reduction[1][3] = max_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->max_reduction[2][3] = max_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->max_reduction[3][3] = max_reduction_table_v_2_2[abm_config[set][3]];
-	ram_table->max_reduction[4][3] = max_reduction_table_v_2_2[abm_config[set][3]];
-
-	ram_table->bright_pos_gain[0][0] = 0x20;
-	ram_table->bright_pos_gain[0][1] = 0x20;
-	ram_table->bright_pos_gain[0][2] = 0x20;
-	ram_table->bright_pos_gain[0][3] = 0x20;
-	ram_table->bright_pos_gain[1][0] = 0x20;
-	ram_table->bright_pos_gain[1][1] = 0x20;
-	ram_table->bright_pos_gain[1][2] = 0x20;
-	ram_table->bright_pos_gain[1][3] = 0x20;
-	ram_table->bright_pos_gain[2][0] = 0x20;
-	ram_table->bright_pos_gain[2][1] = 0x20;
-	ram_table->bright_pos_gain[2][2] = 0x20;
-	ram_table->bright_pos_gain[2][3] = 0x20;
-	ram_table->bright_pos_gain[3][0] = 0x20;
-	ram_table->bright_pos_gain[3][1] = 0x20;
-	ram_table->bright_pos_gain[3][2] = 0x20;
-	ram_table->bright_pos_gain[3][3] = 0x20;
-	ram_table->bright_pos_gain[4][0] = 0x20;
-	ram_table->bright_pos_gain[4][1] = 0x20;
-	ram_table->bright_pos_gain[4][2] = 0x20;
-	ram_table->bright_pos_gain[4][3] = 0x20;
-
-	ram_table->dark_pos_gain[0][0] = 0x00;
-	ram_table->dark_pos_gain[0][1] = 0x00;
-	ram_table->dark_pos_gain[0][2] = 0x00;
-	ram_table->dark_pos_gain[0][3] = 0x00;
-	ram_table->dark_pos_gain[1][0] = 0x00;
-	ram_table->dark_pos_gain[1][1] = 0x00;
-	ram_table->dark_pos_gain[1][2] = 0x00;
-	ram_table->dark_pos_gain[1][3] = 0x00;
-	ram_table->dark_pos_gain[2][0] = 0x00;
-	ram_table->dark_pos_gain[2][1] = 0x00;
-	ram_table->dark_pos_gain[2][2] = 0x00;
-	ram_table->dark_pos_gain[2][3] = 0x00;
-	ram_table->dark_pos_gain[3][0] = 0x00;
-	ram_table->dark_pos_gain[3][1] = 0x00;
-	ram_table->dark_pos_gain[3][2] = 0x00;
-	ram_table->dark_pos_gain[3][3] = 0x00;
-	ram_table->dark_pos_gain[4][0] = 0x00;
-	ram_table->dark_pos_gain[4][1] = 0x00;
-	ram_table->dark_pos_gain[4][2] = 0x00;
-	ram_table->dark_pos_gain[4][3] = 0x00;
-
-	ram_table->hybrid_factor[0] = 0xff;
-	ram_table->hybrid_factor[1] = 0xff;
-	ram_table->hybrid_factor[2] = 0xff;
-	ram_table->hybrid_factor[3] = 0xc0;
-
-	ram_table->contrast_factor[0] = 0x99;
-	ram_table->contrast_factor[1] = 0x99;
-	ram_table->contrast_factor[2] = 0x90;
-	ram_table->contrast_factor[3] = 0x80;
-
-	ram_table->iir_curve[0] = 0x65;
-	ram_table->iir_curve[1] = 0x65;
-	ram_table->iir_curve[2] = 0x65;
-	ram_table->iir_curve[3] = 0x65;
-	ram_table->iir_curve[4] = 0x65;
-
-	//Gamma 2.2
-	ram_table->crgb_thresh[0] = cpu_to_be16(0x127c);
-	ram_table->crgb_thresh[1] = cpu_to_be16(0x151b);
-	ram_table->crgb_thresh[2] = cpu_to_be16(0x17d5);
-	ram_table->crgb_thresh[3] = cpu_to_be16(0x1a56);
-	ram_table->crgb_thresh[4] = cpu_to_be16(0x1c83);
-	ram_table->crgb_thresh[5] = cpu_to_be16(0x1e72);
-	ram_table->crgb_thresh[6] = cpu_to_be16(0x20f0);
-	ram_table->crgb_thresh[7] = cpu_to_be16(0x232b);
-	ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
-	ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
-	ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
-	ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
-	ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
-	ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
-	ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
-	ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
-	ram_table->crgb_slope[0]  = cpu_to_be16(0x3609);
-	ram_table->crgb_slope[1]  = cpu_to_be16(0x2dfa);
-	ram_table->crgb_slope[2]  = cpu_to_be16(0x27ea);
-	ram_table->crgb_slope[3]  = cpu_to_be16(0x235d);
-	ram_table->crgb_slope[4]  = cpu_to_be16(0x2042);
-	ram_table->crgb_slope[5]  = cpu_to_be16(0x1dc3);
-	ram_table->crgb_slope[6]  = cpu_to_be16(0x1b1a);
-	ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
-
-	fill_backlight_transform_table_v_2_2(
-			params, ram_table, true);
-}
-
-static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params, bool big_endian)
-{
-	unsigned int i, j;
-	unsigned int set = params.set;
-
-	ram_table->flags = 0x0;
-	ram_table->min_abm_backlight = (uint16_t)((big_endian) ?
-		cpu_to_be16(params.min_abm_backlight) :
-		cpu_to_le16(params.min_abm_backlight));
-
-	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-		ram_table->hybrid_factor[i] = (uint8_t)abm_settings[set][i].brightness_gain;
-		ram_table->contrast_factor[i] = abm_settings[set][i].contrast_factor;
-		ram_table->deviation_gain[i] = abm_settings[set][i].deviation_gain;
-		ram_table->min_knee[i] = abm_settings[set][i].min_knee;
-		ram_table->max_knee[i] = abm_settings[set][i].max_knee;
-
-		for (j = 0; j < NUM_AMBI_LEVEL; j++) {
-			ram_table->min_reduction[j][i] = abm_settings[set][i].min_reduction;
-			ram_table->max_reduction[j][i] = abm_settings[set][i].max_reduction;
-			ram_table->bright_pos_gain[j][i] = abm_settings[set][i].bright_pos_gain;
-			ram_table->dark_pos_gain[j][i] = abm_settings[set][i].dark_pos_gain;
-		}
-	}
-
-	ram_table->iir_curve[0] = 0x65;
-	ram_table->iir_curve[1] = 0x65;
-	ram_table->iir_curve[2] = 0x65;
-	ram_table->iir_curve[3] = 0x65;
-	ram_table->iir_curve[4] = 0x65;
-
-	//Gamma 2.2
-	ram_table->crgb_thresh[0] = bswap16_based_on_endian(big_endian, 0x127c);
-	ram_table->crgb_thresh[1] = bswap16_based_on_endian(big_endian, 0x151b);
-	ram_table->crgb_thresh[2] = bswap16_based_on_endian(big_endian, 0x17d5);
-	ram_table->crgb_thresh[3] = bswap16_based_on_endian(big_endian, 0x1a56);
-	ram_table->crgb_thresh[4] = bswap16_based_on_endian(big_endian, 0x1c83);
-	ram_table->crgb_thresh[5] = bswap16_based_on_endian(big_endian, 0x1e72);
-	ram_table->crgb_thresh[6] = bswap16_based_on_endian(big_endian, 0x20f0);
-	ram_table->crgb_thresh[7] = bswap16_based_on_endian(big_endian, 0x232b);
-	ram_table->crgb_offset[0] = bswap16_based_on_endian(big_endian, 0x2999);
-	ram_table->crgb_offset[1] = bswap16_based_on_endian(big_endian, 0x3999);
-	ram_table->crgb_offset[2] = bswap16_based_on_endian(big_endian, 0x4666);
-	ram_table->crgb_offset[3] = bswap16_based_on_endian(big_endian, 0x5999);
-	ram_table->crgb_offset[4] = bswap16_based_on_endian(big_endian, 0x6333);
-	ram_table->crgb_offset[5] = bswap16_based_on_endian(big_endian, 0x7800);
-	ram_table->crgb_offset[6] = bswap16_based_on_endian(big_endian, 0x8c00);
-	ram_table->crgb_offset[7] = bswap16_based_on_endian(big_endian, 0xa000);
-	ram_table->crgb_slope[0]  = bswap16_based_on_endian(big_endian, 0x3609);
-	ram_table->crgb_slope[1]  = bswap16_based_on_endian(big_endian, 0x2dfa);
-	ram_table->crgb_slope[2]  = bswap16_based_on_endian(big_endian, 0x27ea);
-	ram_table->crgb_slope[3]  = bswap16_based_on_endian(big_endian, 0x235d);
-	ram_table->crgb_slope[4]  = bswap16_based_on_endian(big_endian, 0x2042);
-	ram_table->crgb_slope[5]  = bswap16_based_on_endian(big_endian, 0x1dc3);
-	ram_table->crgb_slope[6]  = bswap16_based_on_endian(big_endian, 0x1b1a);
-	ram_table->crgb_slope[7]  = bswap16_based_on_endian(big_endian, 0x1910);
-
-	fill_backlight_transform_table_v_2_2(
-			params, ram_table, big_endian);
-}
-
-bool dmub_init_abm_config(struct resource_pool *res_pool,
-	struct dmcu_iram_parameters params,
-	unsigned int inst)
-{
-	struct iram_table_v_2_2 ram_table;
-	struct abm_config_table config;
-	unsigned int set = params.set;
-	bool result = false;
-	uint32_t i, j = 0;
-
-	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
-		return false;
-
-	memset(&ram_table, 0, sizeof(ram_table));
-	memset(&config, 0, sizeof(config));
-
-	fill_iram_v_2_3(&ram_table, params, false);
-
-	// We must copy to structure that is aligned to 32-bit
-	for (i = 0; i < NUM_POWER_FN_SEGS; i++) {
-		config.crgb_thresh[i] = ram_table.crgb_thresh[i];
-		config.crgb_offset[i] = ram_table.crgb_offset[i];
-		config.crgb_slope[i] = ram_table.crgb_slope[i];
-	}
-
-	for (i = 0; i < NUM_BL_CURVE_SEGS; i++) {
-		config.backlight_thresholds[i] = ram_table.backlight_thresholds[i];
-		config.backlight_offsets[i] = ram_table.backlight_offsets[i];
-	}
-
-	for (i = 0; i < NUM_AMBI_LEVEL; i++)
-		config.iir_curve[i] = ram_table.iir_curve[i];
-
-	for (i = 0; i < NUM_AMBI_LEVEL; i++) {
-		for (j = 0; j < NUM_AGGR_LEVEL; j++) {
-			config.min_reduction[i][j] = ram_table.min_reduction[i][j];
-			config.max_reduction[i][j] = ram_table.max_reduction[i][j];
-			config.bright_pos_gain[i][j] = ram_table.bright_pos_gain[i][j];
-			config.dark_pos_gain[i][j] = ram_table.dark_pos_gain[i][j];
-		}
-	}
-
-	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-		config.hybrid_factor[i] = ram_table.hybrid_factor[i];
-		config.contrast_factor[i] = ram_table.contrast_factor[i];
-		config.deviation_gain[i] = ram_table.deviation_gain[i];
-		config.min_knee[i] = ram_table.min_knee[i];
-		config.max_knee[i] = ram_table.max_knee[i];
-	}
-
-	if (params.backlight_ramping_override) {
-
-		ASSERT(params.backlight_ramping_reduction <= 0xFFFF);
-		ASSERT(params.backlight_ramping_start <= 0xFFFF);
-		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-			config.blRampReduction[i] = (uint16_t)params.backlight_ramping_reduction;
-			config.blRampStart[i]     = (uint16_t)params.backlight_ramping_start;
-		}
-	} else {
-		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-			config.blRampReduction[i] = abm_settings[set][i].blRampReduction;
-			config.blRampStart[i] = abm_settings[set][i].blRampStart;
-		}
-	}
-
-	config.min_abm_backlight = ram_table.min_abm_backlight;
-
-	if (res_pool->multiple_abms[inst]) {
-		result = res_pool->multiple_abms[inst]->funcs->init_abm_config(
-			res_pool->multiple_abms[inst], (char *)(&config), sizeof(struct abm_config_table), inst);
-	} else
-		result = res_pool->abm->funcs->init_abm_config(
-			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table), 0);
-
-	return result;
-}
-
-bool dmcu_load_iram(struct dmcu *dmcu,
-	struct dmcu_iram_parameters params)
-{
-	unsigned char ram_table[IRAM_SIZE];
-	bool result = false;
-
-	if (dmcu == NULL)
-		return false;
-
-	if (dmcu && !dmcu->funcs->is_dmcu_initialized(dmcu))
-		return true;
-
-	memset(&ram_table, 0, sizeof(ram_table));
-
-	if (dmcu->dmcu_version.abm_version == 0x24) {
-		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
-		result = dmcu->funcs->load_iram(dmcu, 0, (char *)(&ram_table),
-						IRAM_RESERVE_AREA_START_V2_2);
-	} else if (dmcu->dmcu_version.abm_version == 0x23) {
-		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
-
-		result = dmcu->funcs->load_iram(
-				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
-	} else if (dmcu->dmcu_version.abm_version == 0x22) {
-		fill_iram_v_2_2((struct iram_table_v_2_2 *)ram_table, params);
-
-		result = dmcu->funcs->load_iram(
-				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
-	} else {
-		fill_iram_v_2((struct iram_table_v_2 *)ram_table, params);
-
-		result = dmcu->funcs->load_iram(
-				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2);
-
-		if (result)
-			result = dmcu->funcs->load_iram(
-					dmcu, IRAM_RESERVE_AREA_END_V2 + 1,
-					(char *)(&ram_table) + IRAM_RESERVE_AREA_END_V2 + 1,
-					sizeof(ram_table) - IRAM_RESERVE_AREA_END_V2 - 1);
-	}
-
-	return result;
-}
-
 /*
  * is_psr_su_specific_panel() - check if sink is AMD vendor-specific PSR-SU
  * supported eDP device.
@@ -1073,31 +283,6 @@ void calculate_replay_link_off_frame_count(struct dc_link *link,
 	link->replay_settings.link_off_frame_count = max_link_off_frame_count;
 }
 
-bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
-{
-	unsigned int data_points_size;
-	uint64_t caps_size;
-
-	if (config_no >= ARRAY_SIZE(custom_backlight_profiles))
-		return false;
-
-	data_points_size = custom_backlight_profiles[config_no].num_data_points
-			* sizeof(custom_backlight_profiles[config_no].data_points[0]);
-
-	caps_size = sizeof(struct dm_acpi_atif_backlight_caps) - sizeof(caps->data_points) + data_points_size;
-	ASSERT(caps_size <= 0xFFFF);
-	caps->size = (uint16_t)caps_size;
-	caps->flags = 0;
-	caps->error_code = 0;
-	caps->ac_level_percentage = custom_backlight_profiles[config_no].ac_level_percentage;
-	caps->dc_level_percentage = custom_backlight_profiles[config_no].dc_level_percentage;
-	caps->min_input_signal = custom_backlight_profiles[config_no].min_input_signal;
-	caps->max_input_signal = custom_backlight_profiles[config_no].max_input_signal;
-	caps->num_data_points = (uint8_t)custom_backlight_profiles[config_no].num_data_points;
-	memcpy(caps->data_points, custom_backlight_profiles[config_no].data_points, data_points_size);
-	return true;
-}
-
 void reset_replay_dsync_error_count(struct dc_link *link)
 {
 	link->replay_settings.replay_desync_error_fail_count = 0;
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 87d31d9dce5a..94d2521355ce 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -28,6 +28,7 @@
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dc/inc/core_types.h"
+#include "mod_power.h"
 
 struct resource_pool;
 
-- 
2.43.0

