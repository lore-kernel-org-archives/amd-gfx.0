Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABFACD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1118710E890;
	Wed, 10 Jun 2026 09:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfVf1L6e";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F4910E890
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdv1gdCCbfExUSwOwe+evocV5Qu20zELBT51oFiqhWrazvtWr5t4kvM8QOF156tkVG3pfirV18ek+4GxKhmON+Eat98t2mq5pO6g++4hHt6LL4W8uGeQVrAhHmOgkoFuQ8yjayVV2b2/0lXlC6mSPnvZwCdd4RZ6U7POsYB70DMhKz0WoJMBYjGQvf2suZwTVlbdPYXlMliEUuMknbBUZodtwgPj8z9HMr41PX5h7IVeOuKLmvW+iVcHGaInI22ImizGGVx6aSkYNpiVdGRx4oWxpN89F//HlOuOpRFArj9BtJoeOirKY2Igi6mGCi/DyxccI3F0eryQ64sVGam0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T0ucaW0Cfi59a1LY2VDBGez7HiktAPcugVrf2Y0yBs=;
 b=lc2VbSncD1LCuVnlK7sAw9H8C8U3wW8yTeHKG0tDkQBM6jpxqwGWJ/uYLCRwCIu7JUaKkwJ1M64ASPWlxoWcvtdmNfqZ6yHjJWHQl630tADKcctWlrjN7PDBmzzvksy7EQZKhJzWGrJj9+FiDy2pMmytyS3DT91DKB+FlQvHKUfxKVXjuKj50iUsSOf/1aTjfwpCqHqnWFDJfPH6zCQXM9XXK/YHYtqKpA419qc7VjHpATdtb8EWOQFIRUKr359NtpxOXoDTG4Zuaghfxr3nOEwWN+X72J2H4oVqLES9wZDx0yPTfmPKo0u+hTEmvGcxRNC4alqGEuuUar7OSHC19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T0ucaW0Cfi59a1LY2VDBGez7HiktAPcugVrf2Y0yBs=;
 b=dfVf1L6eShKII4cj0QMeWGA6zpE8T6BA/vzZ5y3vPXLhfVZkT6ZG0mdzjuo4Pu0fQeFXBsNQkpghTrwmQb38A+X29REcdxzz0Ix1mbk0GeaLLpChwGCT1kqAt7XkkIH+XDw3pVUlUpB30pz+qakXk1Lsqz2olpytEOshgt3FUYk=
Received: from PH7P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::34)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:52:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::b) by PH7P221CA0023.outlook.office365.com
 (2603:10b6:510:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:06 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:57 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 27/32] drm/amd/display: Add more KUnit tests for
 amdgpu_dm_pp_smu
Date: Wed, 10 Jun 2026 17:45:11 +0800
Message-ID: <20260610094639.1965367-28-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1978da6d-46b1-40cf-554d-08dec6d5eed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IXyXvGhpD814z2UJZa0kWk154Z6c3nUNsOd4X0gtSZRkxrfUQs0yFsauqFN4zfCeAtgpVj+jhZz/6CBkBDabiD8Cbw1alf/grUcmqHv7dTBTlID5mJt6Jf8jxbjRgBOKBPV+//8Ott4Zkc1JwMbkatKOWCEq+fQEbHSvNPqSSDoLbeA6YoGvAiXjiXkubMMQ25jnh+x+gzpbSBmrC/dCOBNGcSLE0AkQUdwfH8FZcL8GU7SDg1dozOfttecjNRHyuJti1fr8KzvV9m6Vxf+fwI4GlgR+idnqq8Lbq09CcbmSIoKdMxkW+3RPdXvdWqP9yE/PgMejU9NX6RGXZRB7R8G7GBPnYa113VVZWUVDGcCnSVRA7BFfr6OOedMgkqW0+vWCxdxSfwnX1WCLlB931+ZlTPr0e35dVeIHhhYDDozz+fRouJnS0Uk+L1LdlsOybARqZc1llO+X99ggLVaskWu7icDJ/A4R+t/FQ6hp39TNokW9E3sIuVw3vN9fuBNmHuxR6JPjkewc2JrN0FivABjhf5aL9YB+YauLzi/H+ggg+eO7N49lLtIMinHwso4IkYEyYybG+9ZfuMk3hG8yFZBj9AaH6XouheS5bikARUds+vYpN1oVCphWhdbIZuSfgDxrVVNmoGPshfGfSVPIoKlVnoCllyJhkS4Mfl0qB28frZkyY9ktQq4F4wY3s6QyWoeHUAhxAkIV9YbzpBqSRdhKC869VeWqnXEXa6uqDoY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 41zoYY4JHGtktly2S1/nk+rQeL3qHXRLjLGA5qP4RGjAtKuxH8acXAB56+U0x5s8DIwyfa4tiVe9TXIvhHkJ10JxEppXnz+z2ULZ0iGivjl2lT+unv/d+zxMAGyoqnCcKwY+hi/sHyMuYVvZU9++zCC/ojoIIK4tdeFAVE/CUVhc2J3qiyLceeWhCrGoUA0n2HqR0tuU2JU916t9Xis+Di78e6ACxvJcgFiQexgu2o+2kxtiZCmp+QbgXz7nf6ahrzGibezW0he+Gwp/U6pwBaD3TKKncSPs+4iQubCDfua37Pfuwr4H/jeBZHPlXEqNqhjFJjyc0+GpuKkcI+mlJl1/k3qanPvJW2n+2JrAgl37Z5VKWvDlynLyxQTDNAInv8AQfGubgeewpJP4vOrP5bYXXWPcH6T9IGO9wmEx9myviBWTsYDQpFvgqJJQ2B+2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:07.0042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1978da6d-46b1-40cf-554d-08dec6d5eed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

From: Alex Hung <alex.hung@amd.com>

Expand KUnit coverage of amdgpu_dm_pp_smu.c and extract several pure
translation helpers so they can be unit tested in isolation.

Extract pure logic into testable helpers:
- build_pm_display_cfg() from dm_pp_apply_display_requirements()
- build_wm_clock_ranges_soc15() from pp_rv_set_wm_ranges()
- cap_clock_levels_to_validation() from dm_pp_get_clock_levels_by_type()
- pp_smu_nv_clock_id_to_pp() from pp_nv_set_voltage_by_freq()

Tests cover:
- pp_to_dc_clock_levels: within-limit copy and count capping
- pp_to_dc_clock_levels_with_latency: field copy and count capping
- pp_to_dc_clock_levels_with_voltage: field copy and count capping
- dm_pp_get_funcs: RV, RV 1.01, NV, RN, and unsupported versions
- dm_pp_apply_display_requirements: DPM-disabled early-return path
- dm_pp_apply_clock_for_voltage_request: invalid clock type path
- build_pm_display_cfg: scalar field scaling and per-display mapping
- build_wm_clock_ranges_soc15: DMIF and MCIF range translation
- cap_clock_levels_to_validation: engine/memory capping and floor
- pp_smu_nv_clock_id_to_pp: valid ids and invalid-id rejection

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 234 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |  22 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 736 ++++++++++++++++++
 3 files changed, 889 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index ca7141dbdf6a..e0fe4cb97f31 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -36,72 +36,64 @@
 #include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_dm_pp_smu.h"
 
-bool dm_pp_apply_display_requirements(
-		const struct dc_context *ctx,
+STATIC_IFN_KUNIT void build_pm_display_cfg(
+		struct amd_pp_display_configuration *pm_display_cfg,
 		const struct dm_pp_display_configuration *pp_display_cfg)
 {
-	struct amdgpu_device *adev = ctx->driver_context;
 	int i;
 
-	if (adev->pm.dpm_enabled) {
+	memset(pm_display_cfg, 0, sizeof(*pm_display_cfg));
 
-		memset(&adev->pm.pm_display_cfg, 0,
-				sizeof(adev->pm.pm_display_cfg));
+	pm_display_cfg->cpu_cc6_disable = pp_display_cfg->cpu_cc6_disable;
+	pm_display_cfg->cpu_pstate_disable = pp_display_cfg->cpu_pstate_disable;
+	pm_display_cfg->cpu_pstate_separation_time = pp_display_cfg->cpu_pstate_separation_time;
+	pm_display_cfg->nb_pstate_switch_disable = pp_display_cfg->nb_pstate_switch_disable;
 
-		adev->pm.pm_display_cfg.cpu_cc6_disable =
-			pp_display_cfg->cpu_cc6_disable;
+	pm_display_cfg->num_display = pp_display_cfg->display_count;
+	pm_display_cfg->num_path_including_non_display = pp_display_cfg->display_count;
 
-		adev->pm.pm_display_cfg.cpu_pstate_disable =
-			pp_display_cfg->cpu_pstate_disable;
+	pm_display_cfg->min_core_set_clock = pp_display_cfg->min_engine_clock_khz/10;
+	pm_display_cfg->min_core_set_clock_in_sr =
+			pp_display_cfg->min_engine_clock_deep_sleep_khz/10;
+	pm_display_cfg->min_mem_set_clock = pp_display_cfg->min_memory_clock_khz/10;
 
-		adev->pm.pm_display_cfg.cpu_pstate_separation_time =
-			pp_display_cfg->cpu_pstate_separation_time;
+	pm_display_cfg->min_dcef_deep_sleep_set_clk =
+			pp_display_cfg->min_engine_clock_deep_sleep_khz/10;
+	pm_display_cfg->min_dcef_set_clk = pp_display_cfg->min_dcfclock_khz/10;
 
-		adev->pm.pm_display_cfg.nb_pstate_switch_disable =
-			pp_display_cfg->nb_pstate_switch_disable;
+	pm_display_cfg->multi_monitor_in_sync = pp_display_cfg->all_displays_in_sync;
+	pm_display_cfg->min_vblank_time = pp_display_cfg->avail_mclk_switch_time_us;
 
-		adev->pm.pm_display_cfg.num_display =
-				pp_display_cfg->display_count;
-		adev->pm.pm_display_cfg.num_path_including_non_display =
-				pp_display_cfg->display_count;
+	pm_display_cfg->display_clk = pp_display_cfg->disp_clk_khz/10;
 
-		adev->pm.pm_display_cfg.min_core_set_clock =
-				pp_display_cfg->min_engine_clock_khz/10;
-		adev->pm.pm_display_cfg.min_core_set_clock_in_sr =
-				pp_display_cfg->min_engine_clock_deep_sleep_khz/10;
-		adev->pm.pm_display_cfg.min_mem_set_clock =
-				pp_display_cfg->min_memory_clock_khz/10;
+	pm_display_cfg->dce_tolerable_mclk_in_active_latency =
+			pp_display_cfg->avail_mclk_switch_time_in_disp_active_us;
 
-		adev->pm.pm_display_cfg.min_dcef_deep_sleep_set_clk =
-				pp_display_cfg->min_engine_clock_deep_sleep_khz/10;
-		adev->pm.pm_display_cfg.min_dcef_set_clk =
-				pp_display_cfg->min_dcfclock_khz/10;
+	pm_display_cfg->crtc_index = pp_display_cfg->crtc_index;
+	pm_display_cfg->line_time_in_us = pp_display_cfg->line_time_in_us;
 
-		adev->pm.pm_display_cfg.multi_monitor_in_sync =
-				pp_display_cfg->all_displays_in_sync;
-		adev->pm.pm_display_cfg.min_vblank_time =
-				pp_display_cfg->avail_mclk_switch_time_us;
+	pm_display_cfg->vrefresh = pp_display_cfg->disp_configs[0].v_refresh;
+	pm_display_cfg->crossfire_display_index = -1;
+	pm_display_cfg->min_bus_bandwidth = 0;
 
-		adev->pm.pm_display_cfg.display_clk =
-				pp_display_cfg->disp_clk_khz/10;
-
-		adev->pm.pm_display_cfg.dce_tolerable_mclk_in_active_latency =
-				pp_display_cfg->avail_mclk_switch_time_in_disp_active_us;
+	for (i = 0; i < pp_display_cfg->display_count; i++) {
+		const struct dm_pp_single_disp_config *dc_cfg =
+					&pp_display_cfg->disp_configs[i];
+		pm_display_cfg->displays[i].controller_id = dc_cfg->pipe_idx + 1;
+		pm_display_cfg->displays[i].pixel_clock = dc_cfg->pixel_clock;
+	}
+}
+EXPORT_IF_KUNIT(build_pm_display_cfg);
 
-		adev->pm.pm_display_cfg.crtc_index = pp_display_cfg->crtc_index;
-		adev->pm.pm_display_cfg.line_time_in_us =
-				pp_display_cfg->line_time_in_us;
+bool dm_pp_apply_display_requirements(
+		const struct dc_context *ctx,
+		const struct dm_pp_display_configuration *pp_display_cfg)
+{
+	struct amdgpu_device *adev = ctx->driver_context;
 
-		adev->pm.pm_display_cfg.vrefresh = pp_display_cfg->disp_configs[0].v_refresh;
-		adev->pm.pm_display_cfg.crossfire_display_index = -1;
-		adev->pm.pm_display_cfg.min_bus_bandwidth = 0;
+	if (adev->pm.dpm_enabled) {
 
-		for (i = 0; i < pp_display_cfg->display_count; i++) {
-			const struct dm_pp_single_disp_config *dc_cfg =
-						&pp_display_cfg->disp_configs[i];
-			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
-			adev->pm.pm_display_cfg.displays[i].pixel_clock = dc_cfg->pixel_clock;
-		}
+		build_pm_display_cfg(&adev->pm.pm_display_cfg, pp_display_cfg);
 
 		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
 
@@ -110,6 +102,7 @@ bool dm_pp_apply_display_requirements(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_pp_apply_display_requirements);
 
 STATIC_IFN_KUNIT void get_default_clock_levels(
 		enum dm_pp_clock_type clk_type,
@@ -187,7 +180,7 @@ STATIC_IFN_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 }
 EXPORT_IF_KUNIT(dc_to_pp_clock_type);
 
-static void pp_to_dc_clock_levels(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
 		struct dm_pp_clock_levels *dc_clks,
 		enum dm_pp_clock_type dc_clk_type)
@@ -212,8 +205,9 @@ static void pp_to_dc_clock_levels(
 		dc_clks->clocks_in_khz[i] = pp_clks->clock[i];
 	}
 }
+EXPORT_IF_KUNIT(pp_to_dc_clock_levels);
 
-static void pp_to_dc_clock_levels_with_latency(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_latency(
 		const struct pp_clock_levels_with_latency *pp_clks,
 		struct dm_pp_clock_levels_with_latency *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -239,8 +233,9 @@ static void pp_to_dc_clock_levels_with_latency(
 		clk_level_info->data[i].latency_in_us = pp_clks->data[i].latency_in_us;
 	}
 }
+EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_latency);
 
-static void pp_to_dc_clock_levels_with_voltage(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_voltage(
 		const struct pp_clock_levels_with_voltage *pp_clks,
 		struct dm_pp_clock_levels_with_voltage *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -267,6 +262,41 @@ static void pp_to_dc_clock_levels_with_voltage(
 		clk_level_info->data[i].voltage_in_mv = pp_clks->data[i].voltage_in_mv;
 	}
 }
+EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_voltage);
+
+STATIC_IFN_KUNIT void cap_clock_levels_to_validation(
+		struct dm_pp_clock_levels *dc_clks,
+		enum dm_pp_clock_type clk_type,
+		const struct amd_pp_simple_clock_info *validation_clks)
+{
+	uint32_t i;
+
+	/* Determine the highest non-boosted level from the Validation Clocks */
+	if (clk_type == DM_PP_CLOCK_TYPE_ENGINE_CLK) {
+		for (i = 0; i < dc_clks->num_levels; i++) {
+			if (dc_clks->clocks_in_khz[i] > validation_clks->engine_max_clock) {
+				/* This clock is higher the validation clock.
+				 * Than means the previous one is the highest
+				 * non-boosted one.
+				 */
+				DRM_INFO("DM_PPLIB: reducing engine clock level from %d to %d\n",
+						dc_clks->num_levels, i);
+				dc_clks->num_levels = i > 0 ? i : 1;
+				break;
+			}
+		}
+	} else if (clk_type == DM_PP_CLOCK_TYPE_MEMORY_CLK) {
+		for (i = 0; i < dc_clks->num_levels; i++) {
+			if (dc_clks->clocks_in_khz[i] > validation_clks->memory_max_clock) {
+				DRM_INFO("DM_PPLIB: reducing memory clock level from %d to %d\n",
+						dc_clks->num_levels, i);
+				dc_clks->num_levels = i > 0 ? i : 1;
+				break;
+			}
+		}
+	}
+}
+EXPORT_IF_KUNIT(cap_clock_levels_to_validation);
 
 bool dm_pp_get_clock_levels_by_type(
 		const struct dc_context *ctx,
@@ -276,7 +306,6 @@ bool dm_pp_get_clock_levels_by_type(
 	struct amdgpu_device *adev = ctx->driver_context;
 	struct amd_pp_clocks pp_clks = { 0 };
 	struct amd_pp_simple_clock_info validation_clks = { 0 };
-	uint32_t i;
 
 	if (amdgpu_dpm_get_clock_by_type(adev,
 		dc_to_pp_clock_type(clk_type), &pp_clks)) {
@@ -304,30 +333,7 @@ bool dm_pp_get_clock_levels_by_type(
 	validation_clks.engine_max_clock *= 10;
 	validation_clks.memory_max_clock *= 10;
 
-	/* Determine the highest non-boosted level from the Validation Clocks */
-	if (clk_type == DM_PP_CLOCK_TYPE_ENGINE_CLK) {
-		for (i = 0; i < dc_clks->num_levels; i++) {
-			if (dc_clks->clocks_in_khz[i] > validation_clks.engine_max_clock) {
-				/* This clock is higher the validation clock.
-				 * Than means the previous one is the highest
-				 * non-boosted one.
-				 */
-				DRM_INFO("DM_PPLIB: reducing engine clock level from %d to %d\n",
-						dc_clks->num_levels, i);
-				dc_clks->num_levels = i > 0 ? i : 1;
-				break;
-			}
-		}
-	} else if (clk_type == DM_PP_CLOCK_TYPE_MEMORY_CLK) {
-		for (i = 0; i < dc_clks->num_levels; i++) {
-			if (dc_clks->clocks_in_khz[i] > validation_clks.memory_max_clock) {
-				DRM_INFO("DM_PPLIB: reducing memory clock level from %d to %d\n",
-						dc_clks->num_levels, i);
-				dc_clks->num_levels = i > 0 ? i : 1;
-				break;
-			}
-		}
-	}
+	cap_clock_levels_to_validation(dc_clks, clk_type, &validation_clks);
 
 	return true;
 }
@@ -411,26 +417,26 @@ bool dm_pp_apply_clock_for_voltage_request(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_pp_apply_clock_for_voltage_request);
 
-static void pp_rv_set_wm_ranges(struct pp_smu *pp,
-		struct pp_smu_wm_range_sets *ranges)
+STATIC_IFN_KUNIT void build_wm_clock_ranges_soc15(
+		const struct pp_smu_wm_range_sets *ranges,
+		struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges)
 {
-	const struct dc_context *ctx = pp->dm;
-	struct amdgpu_device *adev = ctx->driver_context;
-	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
-	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks = wm_with_clock_ranges.wm_dmif_clocks_ranges;
-	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks = wm_with_clock_ranges.wm_mcif_clocks_ranges;
+	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks =
+			wm_with_clock_ranges->wm_dmif_clocks_ranges;
+	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks =
+			wm_with_clock_ranges->wm_mcif_clocks_ranges;
 	int32_t i;
 
-	wm_with_clock_ranges.num_wm_dmif_sets = ranges->num_reader_wm_sets;
-	wm_with_clock_ranges.num_wm_mcif_sets = ranges->num_writer_wm_sets;
+	wm_with_clock_ranges->num_wm_dmif_sets = ranges->num_reader_wm_sets;
+	wm_with_clock_ranges->num_wm_mcif_sets = ranges->num_writer_wm_sets;
 
-	for (i = 0; i < wm_with_clock_ranges.num_wm_dmif_sets; i++) {
+	for (i = 0; i < wm_with_clock_ranges->num_wm_dmif_sets; i++) {
 		if (ranges->reader_wm_sets[i].wm_inst > 3)
 			wm_dce_clocks[i].wm_set_id = WM_SET_A;
 		else
-			wm_dce_clocks[i].wm_set_id =
-					ranges->reader_wm_sets[i].wm_inst;
+			wm_dce_clocks[i].wm_set_id = ranges->reader_wm_sets[i].wm_inst;
 		wm_dce_clocks[i].wm_max_dcfclk_clk_in_khz =
 				ranges->reader_wm_sets[i].max_drain_clk_mhz * 1000;
 		wm_dce_clocks[i].wm_min_dcfclk_clk_in_khz =
@@ -441,12 +447,11 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 				ranges->reader_wm_sets[i].min_fill_clk_mhz * 1000;
 	}
 
-	for (i = 0; i < wm_with_clock_ranges.num_wm_mcif_sets; i++) {
+	for (i = 0; i < wm_with_clock_ranges->num_wm_mcif_sets; i++) {
 		if (ranges->writer_wm_sets[i].wm_inst > 3)
 			wm_soc_clocks[i].wm_set_id = WM_SET_A;
 		else
-			wm_soc_clocks[i].wm_set_id =
-					ranges->writer_wm_sets[i].wm_inst;
+			wm_soc_clocks[i].wm_set_id = ranges->writer_wm_sets[i].wm_inst;
 		wm_soc_clocks[i].wm_max_socclk_clk_in_khz =
 				ranges->writer_wm_sets[i].max_fill_clk_mhz * 1000;
 		wm_soc_clocks[i].wm_min_socclk_clk_in_khz =
@@ -456,6 +461,17 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		wm_soc_clocks[i].wm_min_mem_clk_in_khz =
 				ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000;
 	}
+}
+EXPORT_IF_KUNIT(build_wm_clock_ranges_soc15);
+
+static void pp_rv_set_wm_ranges(struct pp_smu *pp,
+		struct pp_smu_wm_range_sets *ranges)
+{
+	const struct dc_context *ctx = pp->dm;
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
+
+	build_wm_clock_ranges_soc15(ranges, &wm_with_clock_ranges);
 
 	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
 						    &wm_with_clock_ranges);
@@ -604,27 +620,38 @@ static enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	return PP_SMU_RESULT_OK;
 }
 
-static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
-		enum pp_smu_nv_clock_id clock_id, int mhz)
+STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
+		enum amd_pp_clock_type *clock_type)
 {
-	const struct dc_context *ctx = pp->dm;
-	struct amdgpu_device *adev = ctx->driver_context;
-	struct pp_display_clock_request clock_req;
-	int ret = 0;
-
 	switch (clock_id) {
 	case PP_SMU_NV_DISPCLK:
-		clock_req.clock_type = amd_pp_disp_clock;
+		*clock_type = amd_pp_disp_clock;
 		break;
 	case PP_SMU_NV_PHYCLK:
-		clock_req.clock_type = amd_pp_phy_clock;
+		*clock_type = amd_pp_phy_clock;
 		break;
 	case PP_SMU_NV_PIXELCLK:
-		clock_req.clock_type = amd_pp_pixel_clock;
+		*clock_type = amd_pp_pixel_clock;
 		break;
 	default:
-		break;
+		return false;
 	}
+
+	return true;
+}
+EXPORT_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
+
+static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+		enum pp_smu_nv_clock_id clock_id, int mhz)
+{
+	const struct dc_context *ctx = pp->dm;
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct pp_display_clock_request clock_req;
+	int ret = 0;
+
+	if (!pp_smu_nv_clock_id_to_pp(clock_id, &clock_req.clock_type))
+		return PP_SMU_RESULT_FAIL;
+
 	clock_req.clock_freq_in_khz = mhz * 1000;
 
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
@@ -744,3 +771,4 @@ void dm_pp_get_funcs(
 		break;
 	}
 }
+EXPORT_IF_KUNIT(dm_pp_get_funcs);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
index 827b60d5affe..e851e3ee5b63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
@@ -8,9 +8,31 @@
 
 #include "dm_pp_interface.h"
 
+struct amd_pp_display_configuration;
+struct pp_smu_wm_range_sets;
+struct dm_pp_wm_sets_with_clock_ranges_soc15;
+
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void build_pm_display_cfg(struct amd_pp_display_configuration *pm_display_cfg,
+			  const struct dm_pp_display_configuration *pp_display_cfg);
+void build_wm_clock_ranges_soc15(const struct pp_smu_wm_range_sets *ranges,
+		struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges);
 void get_default_clock_levels(enum dm_pp_clock_type clk_type, struct dm_pp_clock_levels *clks);
 enum amd_pp_clock_type dc_to_pp_clock_type(enum dm_pp_clock_type dm_pp_clk_type);
+void pp_to_dc_clock_levels(const struct amd_pp_clocks *pp_clks,
+			   struct dm_pp_clock_levels *dc_clks,
+			   enum dm_pp_clock_type dc_clk_type);
+void pp_to_dc_clock_levels_with_latency(const struct pp_clock_levels_with_latency *pp_clks,
+					struct dm_pp_clock_levels_with_latency *clk_level_info,
+					enum dm_pp_clock_type dc_clk_type);
+void pp_to_dc_clock_levels_with_voltage(const struct pp_clock_levels_with_voltage *pp_clks,
+					struct dm_pp_clock_levels_with_voltage *clk_level_info,
+					enum dm_pp_clock_type dc_clk_type);
+void cap_clock_levels_to_validation(struct dm_pp_clock_levels *dc_clks,
+				    enum dm_pp_clock_type clk_type,
+				    const struct amd_pp_simple_clock_info *validation_clks);
+bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
+			      enum amd_pp_clock_type *clock_type);
 #endif
 
 #endif /* __AMDGPU_DM_PP_SMU_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
index 556473f55ebe..dbb6dfd5c284 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -9,6 +9,9 @@
 #include <linux/types.h>
 
 #include "dc.h"
+#include "dm_services.h"
+#include "dm_pp_smu.h"
+#include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_pp_smu.h"
@@ -210,6 +213,704 @@ static void dm_test_dc_to_pp_clock_type_invalid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(0), 0);
 }
 
+/* ---- Tests for pp_to_dc_clock_levels ---- */
+
+/**
+ * dm_test_pp_to_dc_clock_levels_within_limit - Test normal copy within limit
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels correctly copies clock values when the
+ * count is within DM_PP_MAX_CLOCK_LEVELS.
+ */
+static void dm_test_pp_to_dc_clock_levels_within_limit(struct kunit *test)
+{
+	struct amd_pp_clocks pp_clks = {};
+	struct dm_pp_clock_levels dc_clks = {};
+
+	pp_clks.count = 3;
+	pp_clks.clock[0] = 300000;
+	pp_clks.clock[1] = 500000;
+	pp_clks.clock[2] = 700000;
+
+	pp_to_dc_clock_levels(&pp_clks, &dc_clks, DM_PP_CLOCK_TYPE_ENGINE_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 3U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[0], 300000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[1], 500000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[2], 700000U);
+}
+
+/**
+ * dm_test_pp_to_dc_clock_levels_caps_at_max - Test count capping at max
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels caps num_levels at DM_PP_MAX_CLOCK_LEVELS
+ * when the input count exceeds the maximum.
+ */
+static void dm_test_pp_to_dc_clock_levels_caps_at_max(struct kunit *test)
+{
+	struct amd_pp_clocks pp_clks = {};
+	struct dm_pp_clock_levels dc_clks = {};
+	uint32_t i;
+
+	pp_clks.count = DM_PP_MAX_CLOCK_LEVELS + 1;
+	for (i = 0; i < DM_PP_MAX_CLOCK_LEVELS; i++)
+		pp_clks.clock[i] = (i + 1) * 100000;
+
+	pp_to_dc_clock_levels(&pp_clks, &dc_clks, DM_PP_CLOCK_TYPE_ENGINE_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, (uint32_t)DM_PP_MAX_CLOCK_LEVELS);
+}
+
+/* ---- Tests for pp_to_dc_clock_levels_with_latency ---- */
+
+/**
+ * dm_test_pp_to_dc_clock_levels_latency_within_limit - Test normal copy
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels_with_latency correctly copies clock
+ * and latency values when count is within limits.
+ */
+static void dm_test_pp_to_dc_clock_levels_latency_within_limit(struct kunit *test)
+{
+	struct pp_clock_levels_with_latency pp_clks = {};
+	struct dm_pp_clock_levels_with_latency dc_clks = {};
+
+	pp_clks.num_levels = 2;
+	pp_clks.data[0].clocks_in_khz = 400000;
+	pp_clks.data[0].latency_in_us = 10;
+	pp_clks.data[1].clocks_in_khz = 800000;
+	pp_clks.data[1].latency_in_us = 20;
+
+	pp_to_dc_clock_levels_with_latency(&pp_clks, &dc_clks,
+					   DM_PP_CLOCK_TYPE_ENGINE_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 2U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[0].clocks_in_khz, 400000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[0].latency_in_us, 10U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[1].clocks_in_khz, 800000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[1].latency_in_us, 20U);
+}
+
+/**
+ * dm_test_pp_to_dc_clock_levels_latency_caps_at_max - Test count capping
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels_with_latency caps num_levels at
+ * DM_PP_MAX_CLOCK_LEVELS when input exceeds the maximum.
+ */
+static void dm_test_pp_to_dc_clock_levels_latency_caps_at_max(struct kunit *test)
+{
+	struct pp_clock_levels_with_latency pp_clks = {};
+	struct dm_pp_clock_levels_with_latency dc_clks = {};
+
+	pp_clks.num_levels = DM_PP_MAX_CLOCK_LEVELS + 1;
+
+	pp_to_dc_clock_levels_with_latency(&pp_clks, &dc_clks,
+					   DM_PP_CLOCK_TYPE_ENGINE_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, (uint32_t)DM_PP_MAX_CLOCK_LEVELS);
+}
+
+/* ---- Tests for pp_to_dc_clock_levels_with_voltage ---- */
+
+/**
+ * dm_test_pp_to_dc_clock_levels_voltage_within_limit - Test normal copy
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels_with_voltage correctly copies clock
+ * and voltage values when count is within limits.
+ */
+static void dm_test_pp_to_dc_clock_levels_voltage_within_limit(struct kunit *test)
+{
+	struct pp_clock_levels_with_voltage pp_clks = {};
+	struct dm_pp_clock_levels_with_voltage dc_clks = {};
+
+	pp_clks.num_levels = 2;
+	pp_clks.data[0].clocks_in_khz = 300000;
+	pp_clks.data[0].voltage_in_mv = 800;
+	pp_clks.data[1].clocks_in_khz = 600000;
+	pp_clks.data[1].voltage_in_mv = 950;
+
+	pp_to_dc_clock_levels_with_voltage(&pp_clks, &dc_clks,
+					   DM_PP_CLOCK_TYPE_MEMORY_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 2U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[0].clocks_in_khz, 300000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[0].voltage_in_mv, 800U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[1].clocks_in_khz, 600000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.data[1].voltage_in_mv, 950U);
+}
+
+/**
+ * dm_test_pp_to_dc_clock_levels_voltage_caps_at_max - Test count capping
+ * @test: KUnit test context
+ *
+ * Verify that pp_to_dc_clock_levels_with_voltage caps num_levels at
+ * DM_PP_MAX_CLOCK_LEVELS when input exceeds the maximum.
+ */
+static void dm_test_pp_to_dc_clock_levels_voltage_caps_at_max(struct kunit *test)
+{
+	struct pp_clock_levels_with_voltage pp_clks = {};
+	struct dm_pp_clock_levels_with_voltage dc_clks = {};
+
+	pp_clks.num_levels = DM_PP_MAX_CLOCK_LEVELS + 1;
+
+	pp_to_dc_clock_levels_with_voltage(&pp_clks, &dc_clks,
+					   DM_PP_CLOCK_TYPE_MEMORY_CLK);
+
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, (uint32_t)DM_PP_MAX_CLOCK_LEVELS);
+}
+
+/* ---- Tests for dm_pp_get_funcs ---- */
+
+/**
+ * dm_test_get_funcs_rv - Test Raven PP SMU function table setup
+ * @test: KUnit test context
+ *
+ * Verify that DCN 1.0 initializes the Raven SMU function table and stores
+ * the DC context in the PP SMU handle.
+ */
+static void dm_test_get_funcs_rv(struct kunit *test)
+{
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu_funcs *funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	ctx->dce_version = DCN_VERSION_1_0;
+
+	dm_pp_get_funcs(ctx, funcs);
+
+	KUNIT_EXPECT_EQ(test, funcs->ctx.ver, PP_SMU_VER_RV);
+	KUNIT_EXPECT_PTR_EQ(test, funcs->rv_funcs.pp_smu.dm, ctx);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_wm_ranges != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_pme_wa_enable != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_display_count != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_min_deep_sleep_dcfclk != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_hard_min_dcfclk_by_freq != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_hard_min_fclk_by_freq != NULL);
+	KUNIT_EXPECT_FALSE(test, funcs->rv_funcs.set_hard_min_socclk_by_freq != NULL);
+}
+
+/**
+ * dm_test_get_funcs_rv_101 - Test DCN 1.01 Raven PP SMU setup
+ * @test: KUnit test context
+ *
+ * Verify that DCN 1.01 uses the same Raven SMU function table as DCN 1.0.
+ */
+static void dm_test_get_funcs_rv_101(struct kunit *test)
+{
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu_funcs *funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	ctx->dce_version = DCN_VERSION_1_01;
+
+	dm_pp_get_funcs(ctx, funcs);
+
+	KUNIT_EXPECT_EQ(test, funcs->ctx.ver, PP_SMU_VER_RV);
+	KUNIT_EXPECT_PTR_EQ(test, funcs->rv_funcs.pp_smu.dm, ctx);
+	KUNIT_EXPECT_TRUE(test, funcs->rv_funcs.set_display_count != NULL);
+}
+
+/**
+ * dm_test_get_funcs_nv - Test Navi PP SMU function table setup
+ * @test: KUnit test context
+ *
+ * Verify that DCN 2.0 initializes the Navi SMU function table and leaves the
+ * unsupported PME workaround callback unset.
+ */
+static void dm_test_get_funcs_nv(struct kunit *test)
+{
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu_funcs *funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	ctx->dce_version = DCN_VERSION_2_0;
+
+	dm_pp_get_funcs(ctx, funcs);
+
+	KUNIT_EXPECT_EQ(test, funcs->ctx.ver, PP_SMU_VER_NV);
+	KUNIT_EXPECT_PTR_EQ(test, funcs->nv_funcs.pp_smu.dm, ctx);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_display_count != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_hard_min_dcfclk_by_freq != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_min_deep_sleep_dcfclk != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_voltage_by_freq != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_wm_ranges != NULL);
+	KUNIT_EXPECT_FALSE(test, funcs->nv_funcs.set_pme_wa_enable != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_hard_min_uclk_by_freq != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.get_maximum_sustainable_clocks != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.get_uclk_dpm_states != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->nv_funcs.set_pstate_handshake_support != NULL);
+}
+
+/**
+ * dm_test_get_funcs_rn - Test Renoir PP SMU function table setup
+ * @test: KUnit test context
+ *
+ * Verify that DCN 2.1 initializes the Renoir SMU function table.
+ */
+static void dm_test_get_funcs_rn(struct kunit *test)
+{
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu_funcs *funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	ctx->dce_version = DCN_VERSION_2_1;
+
+	dm_pp_get_funcs(ctx, funcs);
+
+	KUNIT_EXPECT_EQ(test, funcs->ctx.ver, PP_SMU_VER_RN);
+	KUNIT_EXPECT_PTR_EQ(test, funcs->rn_funcs.pp_smu.dm, ctx);
+	KUNIT_EXPECT_TRUE(test, funcs->rn_funcs.set_wm_ranges != NULL);
+	KUNIT_EXPECT_TRUE(test, funcs->rn_funcs.get_dpm_clock_table != NULL);
+}
+
+/**
+ * dm_test_get_funcs_unsupported - Test unsupported DCE version handling
+ * @test: KUnit test context
+ *
+ * Verify that unsupported DCE versions do not initialize a PP SMU version or
+ * function table callbacks.
+ */
+static void dm_test_get_funcs_unsupported(struct kunit *test)
+{
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu_funcs *funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	ctx->dce_version = DCE_VERSION_MAX;
+
+	dm_pp_get_funcs(ctx, funcs);
+
+	KUNIT_EXPECT_EQ(test, funcs->ctx.ver, PP_SMU_UNSUPPORTED);
+	KUNIT_EXPECT_FALSE(test, funcs->rv_funcs.set_wm_ranges != NULL);
+}
+
+/* ---- Tests for amdgpu_device-backed entry points ---- */
+
+/**
+ * dm_test_apply_display_requirements_dpm_disabled - Test DPM-disabled path
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_apply_display_requirements returns true without touching
+ * the display configuration when DPM is disabled.
+ */
+static void dm_test_apply_display_requirements_dpm_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_display_configuration cfg = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	adev->pm.dpm_enabled = false;
+	ctx->driver_context = adev;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_apply_display_requirements(ctx, &cfg));
+}
+
+/**
+ * dm_test_apply_clock_for_voltage_invalid_type - Test invalid clock type path
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_apply_clock_for_voltage_request returns false for a clock
+ * type that does not map to a valid PP clock type, taking the early-return
+ * path before any SMU request is issued.
+ */
+static void dm_test_apply_clock_for_voltage_invalid_type(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_for_voltage_req req = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->driver_context = adev;
+	req.clk_type = (enum dm_pp_clock_type)0xffff;
+	req.clocks_in_khz = 500000;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_apply_clock_for_voltage_request(ctx, &req));
+}
+
+/* ---- Tests for build_pm_display_cfg ---- */
+
+/**
+ * dm_test_build_pm_display_cfg_scalar_fields - Test scalar field translation
+ * @test: KUnit test context
+ *
+ * Verify that build_pm_display_cfg copies the pass-through fields and applies
+ * the /10 (10 kHz) scaling, and sets the fixed constants.
+ */
+static void dm_test_build_pm_display_cfg_scalar_fields(struct kunit *test)
+{
+	struct amd_pp_display_configuration *pm =
+		kunit_kzalloc(test, sizeof(*pm), GFP_KERNEL);
+	struct dm_pp_display_configuration *pp =
+		kunit_kzalloc(test, sizeof(*pp), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, pm);
+	KUNIT_ASSERT_NOT_NULL(test, pp);
+
+	pp->cpu_cc6_disable = true;
+	pp->cpu_pstate_disable = true;
+	pp->cpu_pstate_separation_time = 7;
+	pp->nb_pstate_switch_disable = true;
+	pp->display_count = 2;
+	pp->min_engine_clock_khz = 300000;
+	pp->min_engine_clock_deep_sleep_khz = 50000;
+	pp->min_memory_clock_khz = 800000;
+	pp->min_dcfclock_khz = 600000;
+	pp->all_displays_in_sync = true;
+	pp->avail_mclk_switch_time_us = 11;
+	pp->disp_clk_khz = 400000;
+	pp->avail_mclk_switch_time_in_disp_active_us = 13;
+	pp->crtc_index = 3;
+	pp->line_time_in_us = 17;
+	pp->disp_configs[0].v_refresh = 60;
+
+	build_pm_display_cfg(pm, pp);
+
+	KUNIT_EXPECT_TRUE(test, pm->cpu_cc6_disable);
+	KUNIT_EXPECT_TRUE(test, pm->cpu_pstate_disable);
+	KUNIT_EXPECT_EQ(test, pm->cpu_pstate_separation_time, 7);
+	KUNIT_EXPECT_TRUE(test, pm->nb_pstate_switch_disable);
+	KUNIT_EXPECT_EQ(test, pm->num_display, 2);
+	KUNIT_EXPECT_EQ(test, pm->num_path_including_non_display, 2);
+	KUNIT_EXPECT_EQ(test, pm->min_core_set_clock, 30000);
+	KUNIT_EXPECT_EQ(test, pm->min_core_set_clock_in_sr, 5000);
+	KUNIT_EXPECT_EQ(test, pm->min_mem_set_clock, 80000);
+	KUNIT_EXPECT_EQ(test, pm->min_dcef_deep_sleep_set_clk, 5000);
+	KUNIT_EXPECT_EQ(test, pm->min_dcef_set_clk, 60000);
+	KUNIT_EXPECT_TRUE(test, pm->multi_monitor_in_sync);
+	KUNIT_EXPECT_EQ(test, pm->min_vblank_time, 11);
+	KUNIT_EXPECT_EQ(test, pm->display_clk, 40000);
+	KUNIT_EXPECT_EQ(test, pm->dce_tolerable_mclk_in_active_latency, 13);
+	KUNIT_EXPECT_EQ(test, pm->crtc_index, 3);
+	KUNIT_EXPECT_EQ(test, pm->line_time_in_us, 17);
+	KUNIT_EXPECT_EQ(test, pm->vrefresh, 60);
+	KUNIT_EXPECT_EQ(test, pm->crossfire_display_index, -1);
+	KUNIT_EXPECT_EQ(test, pm->min_bus_bandwidth, 0);
+}
+
+/**
+ * dm_test_build_pm_display_cfg_per_display - Test per-display translation
+ * @test: KUnit test context
+ *
+ * Verify that build_pm_display_cfg maps each display config, applying the
+ * controller_id = pipe_idx + 1 offset and copying the pixel clock.
+ */
+static void dm_test_build_pm_display_cfg_per_display(struct kunit *test)
+{
+	struct amd_pp_display_configuration *pm =
+		kunit_kzalloc(test, sizeof(*pm), GFP_KERNEL);
+	struct dm_pp_display_configuration *pp =
+		kunit_kzalloc(test, sizeof(*pp), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, pm);
+	KUNIT_ASSERT_NOT_NULL(test, pp);
+
+	pp->display_count = 2;
+	pp->disp_configs[0].pipe_idx = 0;
+	pp->disp_configs[0].pixel_clock = 148500;
+	pp->disp_configs[1].pipe_idx = 4;
+	pp->disp_configs[1].pixel_clock = 297000;
+
+	build_pm_display_cfg(pm, pp);
+
+	KUNIT_EXPECT_EQ(test, pm->displays[0].controller_id, 1);
+	KUNIT_EXPECT_EQ(test, pm->displays[0].pixel_clock, 148500);
+	KUNIT_EXPECT_EQ(test, pm->displays[1].controller_id, 5);
+	KUNIT_EXPECT_EQ(test, pm->displays[1].pixel_clock, 297000);
+}
+
+/* ---- Tests for build_wm_clock_ranges_soc15 ---- */
+
+/**
+ * dm_test_build_wm_clock_ranges_dmif - Test reader (DMIF) watermark sets
+ * @test: KUnit test context
+ *
+ * Verify that build_wm_clock_ranges_soc15 copies the reader set count,
+ * maps wm_inst to wm_set_id (clamping instances > 3 to WM_SET_A), and
+ * converts every clock from MHz to kHz (x1000) into the DMIF clock ranges.
+ */
+static void dm_test_build_wm_clock_ranges_dmif(struct kunit *test)
+{
+	struct pp_smu_wm_range_sets *ranges =
+		kunit_kzalloc(test, sizeof(*ranges), GFP_KERNEL);
+	struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm =
+		kunit_kzalloc(test, sizeof(*wm), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ranges);
+	KUNIT_ASSERT_NOT_NULL(test, wm);
+
+	ranges->num_reader_wm_sets = 2;
+	/* set 0: wm_inst within range -> preserved */
+	ranges->reader_wm_sets[0].wm_inst = 2;
+	ranges->reader_wm_sets[0].max_drain_clk_mhz = 600;
+	ranges->reader_wm_sets[0].min_drain_clk_mhz = 300;
+	ranges->reader_wm_sets[0].max_fill_clk_mhz = 800;
+	ranges->reader_wm_sets[0].min_fill_clk_mhz = 400;
+	/* set 1: wm_inst > 3 -> clamped to WM_SET_A */
+	ranges->reader_wm_sets[1].wm_inst = 5;
+	ranges->reader_wm_sets[1].max_drain_clk_mhz = 700;
+	ranges->reader_wm_sets[1].min_drain_clk_mhz = 350;
+	ranges->reader_wm_sets[1].max_fill_clk_mhz = 900;
+	ranges->reader_wm_sets[1].min_fill_clk_mhz = 450;
+
+	build_wm_clock_ranges_soc15(ranges, wm);
+
+	KUNIT_EXPECT_EQ(test, wm->num_wm_dmif_sets, 2U);
+	KUNIT_EXPECT_EQ(test, wm->num_wm_mcif_sets, 0U);
+
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[0].wm_set_id, WM_SET_C);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[0].wm_max_dcfclk_clk_in_khz, 600000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[0].wm_min_dcfclk_clk_in_khz, 300000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[0].wm_max_mem_clk_in_khz, 800000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[0].wm_min_mem_clk_in_khz, 400000U);
+
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[1].wm_set_id, WM_SET_A);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[1].wm_max_dcfclk_clk_in_khz, 700000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[1].wm_min_dcfclk_clk_in_khz, 350000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[1].wm_max_mem_clk_in_khz, 900000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_dmif_clocks_ranges[1].wm_min_mem_clk_in_khz, 450000U);
+}
+
+/**
+ * dm_test_build_wm_clock_ranges_mcif - Test writer (MCIF) watermark sets
+ * @test: KUnit test context
+ *
+ * Verify that build_wm_clock_ranges_soc15 copies the writer set count and
+ * maps the writer clocks into the MCIF ranges: fill clocks become socclk
+ * and drain clocks become mem clk, each converted from MHz to kHz.
+ */
+static void dm_test_build_wm_clock_ranges_mcif(struct kunit *test)
+{
+	struct pp_smu_wm_range_sets *ranges =
+		kunit_kzalloc(test, sizeof(*ranges), GFP_KERNEL);
+	struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm =
+		kunit_kzalloc(test, sizeof(*wm), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ranges);
+	KUNIT_ASSERT_NOT_NULL(test, wm);
+
+	ranges->num_writer_wm_sets = 1;
+	ranges->writer_wm_sets[0].wm_inst = 1;
+	ranges->writer_wm_sets[0].max_fill_clk_mhz = 1200;
+	ranges->writer_wm_sets[0].min_fill_clk_mhz = 600;
+	ranges->writer_wm_sets[0].max_drain_clk_mhz = 1000;
+	ranges->writer_wm_sets[0].min_drain_clk_mhz = 500;
+
+	build_wm_clock_ranges_soc15(ranges, wm);
+
+	KUNIT_EXPECT_EQ(test, wm->num_wm_dmif_sets, 0U);
+	KUNIT_EXPECT_EQ(test, wm->num_wm_mcif_sets, 1U);
+
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_set_id, WM_SET_B);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_max_socclk_clk_in_khz, 1200000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_min_socclk_clk_in_khz, 600000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_max_mem_clk_in_khz, 1000000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_min_mem_clk_in_khz, 500000U);
+}
+
+/* ---- Tests for cap_clock_levels_to_validation ---- */
+
+/**
+ * dm_test_cap_clock_levels_engine_caps - Test engine clock level capping
+ * @test: KUnit test context
+ *
+ * Verify that for engine clocks, num_levels is reduced to the index of the
+ * first level whose frequency exceeds the engine validation clock.
+ */
+static void dm_test_cap_clock_levels_engine_caps(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	struct amd_pp_simple_clock_info validation = {
+		.engine_max_clock = 450000,
+		.memory_max_clock = 800000,
+	};
+
+	clks.num_levels = 3;
+	clks.clocks_in_khz[0] = 300000;
+	clks.clocks_in_khz[1] = 400000;
+	clks.clocks_in_khz[2] = 500000;
+
+	cap_clock_levels_to_validation(&clks, DM_PP_CLOCK_TYPE_ENGINE_CLK, &validation);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 2U);
+}
+
+/**
+ * dm_test_cap_clock_levels_engine_first_exceeds - Test floor of one level
+ * @test: KUnit test context
+ *
+ * Verify that when the very first engine clock level already exceeds the
+ * validation clock, num_levels is clamped to 1 rather than 0.
+ */
+static void dm_test_cap_clock_levels_engine_first_exceeds(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	struct amd_pp_simple_clock_info validation = {
+		.engine_max_clock = 100000,
+		.memory_max_clock = 800000,
+	};
+
+	clks.num_levels = 3;
+	clks.clocks_in_khz[0] = 300000;
+	clks.clocks_in_khz[1] = 400000;
+	clks.clocks_in_khz[2] = 500000;
+
+	cap_clock_levels_to_validation(&clks, DM_PP_CLOCK_TYPE_ENGINE_CLK, &validation);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 1U);
+}
+
+/**
+ * dm_test_cap_clock_levels_memory_caps - Test memory clock level capping
+ * @test: KUnit test context
+ *
+ * Verify that for memory clocks, num_levels is reduced based on the memory
+ * validation clock (and is unaffected by the engine validation clock).
+ */
+static void dm_test_cap_clock_levels_memory_caps(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	struct amd_pp_simple_clock_info validation = {
+		.engine_max_clock = 100000,
+		.memory_max_clock = 700000,
+	};
+
+	clks.num_levels = 2;
+	clks.clocks_in_khz[0] = 333000;
+	clks.clocks_in_khz[1] = 800000;
+
+	cap_clock_levels_to_validation(&clks, DM_PP_CLOCK_TYPE_MEMORY_CLK, &validation);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 1U);
+}
+
+/**
+ * dm_test_cap_clock_levels_within_limit - Test no capping when within limit
+ * @test: KUnit test context
+ *
+ * Verify that num_levels is left unchanged when no level exceeds the
+ * validation clock.
+ */
+static void dm_test_cap_clock_levels_within_limit(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	struct amd_pp_simple_clock_info validation = {
+		.engine_max_clock = 999000,
+		.memory_max_clock = 999000,
+	};
+
+	clks.num_levels = 3;
+	clks.clocks_in_khz[0] = 300000;
+	clks.clocks_in_khz[1] = 400000;
+	clks.clocks_in_khz[2] = 500000;
+
+	cap_clock_levels_to_validation(&clks, DM_PP_CLOCK_TYPE_ENGINE_CLK, &validation);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 3U);
+}
+
+/**
+ * dm_test_cap_clock_levels_other_type - Test non-engine/memory types ignored
+ * @test: KUnit test context
+ *
+ * Verify that for clock types other than engine or memory, num_levels is
+ * left unchanged regardless of the validation clocks.
+ */
+static void dm_test_cap_clock_levels_other_type(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	struct amd_pp_simple_clock_info validation = {
+		.engine_max_clock = 1,
+		.memory_max_clock = 1,
+	};
+
+	clks.num_levels = 3;
+	clks.clocks_in_khz[0] = 300000;
+	clks.clocks_in_khz[1] = 400000;
+	clks.clocks_in_khz[2] = 500000;
+
+	cap_clock_levels_to_validation(&clks, DM_PP_CLOCK_TYPE_DISPLAY_CLK, &validation);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 3U);
+}
+
+/* ---- Tests for pp_smu_nv_clock_id_to_pp ---- */
+
+/**
+ * dm_test_nv_clock_id_dispclk - Test DISPCLK id mapping
+ * @test: KUnit test context
+ *
+ * Verify that PP_SMU_NV_DISPCLK maps to amd_pp_disp_clock and returns true.
+ */
+static void dm_test_nv_clock_id_dispclk(struct kunit *test)
+{
+	enum amd_pp_clock_type clock_type = amd_pp_mem_clock;
+
+	KUNIT_EXPECT_TRUE(test, pp_smu_nv_clock_id_to_pp(PP_SMU_NV_DISPCLK, &clock_type));
+	KUNIT_EXPECT_EQ(test, clock_type, amd_pp_disp_clock);
+}
+
+/**
+ * dm_test_nv_clock_id_phyclk - Test PHYCLK id mapping
+ * @test: KUnit test context
+ *
+ * Verify that PP_SMU_NV_PHYCLK maps to amd_pp_phy_clock and returns true.
+ */
+static void dm_test_nv_clock_id_phyclk(struct kunit *test)
+{
+	enum amd_pp_clock_type clock_type = amd_pp_mem_clock;
+
+	KUNIT_EXPECT_TRUE(test, pp_smu_nv_clock_id_to_pp(PP_SMU_NV_PHYCLK, &clock_type));
+	KUNIT_EXPECT_EQ(test, clock_type, amd_pp_phy_clock);
+}
+
+/**
+ * dm_test_nv_clock_id_pixelclk - Test PIXELCLK id mapping
+ * @test: KUnit test context
+ *
+ * Verify that PP_SMU_NV_PIXELCLK maps to amd_pp_pixel_clock and returns true.
+ */
+static void dm_test_nv_clock_id_pixelclk(struct kunit *test)
+{
+	enum amd_pp_clock_type clock_type = amd_pp_mem_clock;
+
+	KUNIT_EXPECT_TRUE(test, pp_smu_nv_clock_id_to_pp(PP_SMU_NV_PIXELCLK, &clock_type));
+	KUNIT_EXPECT_EQ(test, clock_type, amd_pp_pixel_clock);
+}
+
+/**
+ * dm_test_nv_clock_id_invalid - Test unknown id is rejected
+ * @test: KUnit test context
+ *
+ * Verify that an unknown clock id returns false and leaves the output
+ * clock_type untouched, guarding against the previously uninitialized path.
+ */
+static void dm_test_nv_clock_id_invalid(struct kunit *test)
+{
+	enum amd_pp_clock_type clock_type = amd_pp_dcef_clock;
+
+	KUNIT_EXPECT_FALSE(test, pp_smu_nv_clock_id_to_pp((enum pp_smu_nv_clock_id)0xff,
+							  &clock_type));
+	KUNIT_EXPECT_EQ(test, clock_type, amd_pp_dcef_clock);
+}
+
 static struct kunit_case dm_pp_smu_test_cases[] = {
 	/* get_default_clock_levels */
 	KUNIT_CASE(dm_test_default_clock_levels_display),
@@ -227,6 +928,41 @@ static struct kunit_case dm_pp_smu_test_cases[] = {
 	KUNIT_CASE(dm_test_dc_to_pp_clock_type_phyclk),
 	KUNIT_CASE(dm_test_dc_to_pp_clock_type_dppclk),
 	KUNIT_CASE(dm_test_dc_to_pp_clock_type_invalid),
+	/* pp_to_dc_clock_levels */
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_within_limit),
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_caps_at_max),
+	/* pp_to_dc_clock_levels_with_latency */
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_latency_within_limit),
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_latency_caps_at_max),
+	/* pp_to_dc_clock_levels_with_voltage */
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_voltage_within_limit),
+	KUNIT_CASE(dm_test_pp_to_dc_clock_levels_voltage_caps_at_max),
+	/* dm_pp_get_funcs */
+	KUNIT_CASE(dm_test_get_funcs_rv),
+	KUNIT_CASE(dm_test_get_funcs_rv_101),
+	KUNIT_CASE(dm_test_get_funcs_nv),
+	KUNIT_CASE(dm_test_get_funcs_rn),
+	KUNIT_CASE(dm_test_get_funcs_unsupported),
+	/* amdgpu_device-backed entry points */
+	KUNIT_CASE(dm_test_apply_display_requirements_dpm_disabled),
+	KUNIT_CASE(dm_test_apply_clock_for_voltage_invalid_type),
+	/* build_pm_display_cfg */
+	KUNIT_CASE(dm_test_build_pm_display_cfg_scalar_fields),
+	KUNIT_CASE(dm_test_build_pm_display_cfg_per_display),
+	/* build_wm_clock_ranges_soc15 */
+	KUNIT_CASE(dm_test_build_wm_clock_ranges_dmif),
+	KUNIT_CASE(dm_test_build_wm_clock_ranges_mcif),
+	/* cap_clock_levels_to_validation */
+	KUNIT_CASE(dm_test_cap_clock_levels_engine_caps),
+	KUNIT_CASE(dm_test_cap_clock_levels_engine_first_exceeds),
+	KUNIT_CASE(dm_test_cap_clock_levels_memory_caps),
+	KUNIT_CASE(dm_test_cap_clock_levels_within_limit),
+	KUNIT_CASE(dm_test_cap_clock_levels_other_type),
+	/* pp_smu_nv_clock_id_to_pp */
+	KUNIT_CASE(dm_test_nv_clock_id_dispclk),
+	KUNIT_CASE(dm_test_nv_clock_id_phyclk),
+	KUNIT_CASE(dm_test_nv_clock_id_pixelclk),
+	KUNIT_CASE(dm_test_nv_clock_id_invalid),
 	{}
 };
 
-- 
2.43.0

