Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C2AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A116E90E;
	Thu,  2 Dec 2021 03:10:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581736E932
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjrDVbBAnF54j21nIlCtIanJOdlLAhJMAc9TY7mexue+WKA3EohQ036a/SkTEVhlsMD3w63w1GZZipd7NGhnKlu200y0tCSgYvmKusLkfW9OmiZzLzLEXjn0965UCLqAuU/S6JyFnLVkNjSVhD8ZLpuXF/T6XwPX3SCfwxhdOjfCXMMOTzJ1eeCq8GMe+qpIUpKxr6JY4Wsf1+UpaX6OrJkyVGTdDrn0FBxFJMUeWnmk2Jqusb3FJtkgl8SqJLwmIPpz2xJAVsU3qvlP+7PesX8L6q9r9Qpgax6e2mtTifthK37WtifzXb3HPcrV8fDWQx+iHLLn8r99E+KZtJyWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa6bsal0xbSG4hFqX5xuySjXeU8ugTp11TFqvc3p9BA=;
 b=gVOohqkj+qxumvzMzL5Jv65YTaS/ACLb0esv8Q/hoPiIx/qqm7J+H8RlPcuNMz2UPdPNKLJaUAVTzC7JAYI08wp4Vu8XPdM7nY1RqGQ4nP1WMFLPXpSibIlmdhel4RLT/xmp15RfmhCi8JIKO6N2Kz+Aovfn85E/b2Xu8jySJTB09dkHJl652JpnFJ7JFJu68ELsGXe3D3Ja+GlL09wCJ4U2hg7UAi8skjolZNvhm5Om8QEejxa8lm29wo+oOh5ENA4OI4zcUUhjBwiOybBXE0m6Vg8IIq87LaWbC5zS710qiPLRHTSyO9bvULh5EDcdCjeX5jUJKy2vNpGDqvQq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa6bsal0xbSG4hFqX5xuySjXeU8ugTp11TFqvc3p9BA=;
 b=Za4Lbza8uJCXIqGLtW3W8TiVb6HdQn+S9p+ASVOzbz0nqTqoS44yz6ea/ISjHV9om/fNfhj+SWRiNNXZHvGOWS/BPcqPCyrPtSZ0ue5C0f4aWZdJY8DS2jchZ92ooCWZjNHIEV7+CuDhYY9xRNi81iOPPgtmS5+t4+IRieyuo+g=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 03:10:06 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::fc) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:06 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:03 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 03/17] drm/amd/pm: do not expose power implementation
 details to display
Date: Thu, 2 Dec 2021 11:09:16 +0800
Message-ID: <20211202030930.1681278-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc45ba33-070b-4bcd-5a16-08d9b5413da7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR12MB128097000E05A64B06E030ABE4699@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlUebfK0A8MRs+3prVAdRGB21gnkRuHWX6RC2G11GtX86qYQ9DRGy79d9tYc/JDESz9sH5hvIhIJjlxl5wYxTI8OJf72IqdbQzuY9rRLj5485On/qUYM2K2LABNQGeOyhr7jb8b5F4hHuhfXlebkWbSe9K1yheMhSzvd42ydH3kk/2br8inCX4B9FKsmJyNvq0lec78TIWuN/gNul6SWU3m+HmmITsWqCe8fQ8I9knY7kFO+0jEIsQXojG7eyzNW4N0os+QQvTC7ULemorHoDAPWvP11+om0RKMY5D2otJEXWLT4JWCP/4w6Z8PRFeSoKpjbp7i6m04ov+SASCC5MqZbheJ7jthcDryQmnuDn8hGt0ypnzYPm58q2B11RJkhzVbRYGJe2Zuf/yj370tbgjAVN6bsHO2Y4/v7HtIT75pol8orERoJ7jeFp8eop+NfeICQLr7j6K5SqJGY/zjY6XMp9xTRCU0liLIOJP94GKFD/BAyO9CjNk112D/SS7PatcC0elmITK1eQaSWp3jgfu8e8JM6uQGWLcbKeNwlcCTAO+KpTDlr8o8krcbeH/7YPVaeTiyXYWK99uvHUWDFsF5Xlaei1j7ye6FtoOVbtMFJNSEm5FohjP1+TLgvRysHLdObR6Af1cHpFauMLZw/oDTE+L4ughv5RE11yJeIxpr7UMCp5cKExdHqEl3Ojb/Mvf5NMeIZOJGnZIdbc+Z096UwbCT3N1OcLbToq8IWrsH+xm0QlkhPdrCR4hfFhU8U9kaTPKrYpIUsOdavHWpMhSRNBUU9SitP9wHikEhfFOY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(336012)(26005)(186003)(86362001)(81166007)(356005)(83380400001)(6916009)(30864003)(7696005)(2616005)(426003)(1076003)(5660300002)(40460700001)(82310400004)(2906002)(54906003)(8936002)(508600001)(36860700001)(47076005)(36756003)(4326008)(316002)(44832011)(8676002)(6666004)(70206006)(70586007)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:06.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc45ba33-070b-4bcd-5a16-08d9b5413da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Display is another client of our power APIs. It's not proper to spike
into power implementation details there.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic897131e16473ed29d3d7586d822a55c64e6574a
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 246 +++++++-----------
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 218 ++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  38 +++
 4 files changed, 344 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53f7fdf956eb..92480cc57623 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2139,12 +2139,8 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 
 static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 {
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (!is_support_sw_smu(adev))
-		return 0;
-
 	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
 	 * on window driver dc implementation.
 	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
@@ -2183,7 +2179,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ret = smu_write_watermarks_table(smu);
+	ret = amdgpu_dpm_write_watermarks_table(adev);
 	if (ret) {
 		DRM_ERROR("Failed to update WMTABLE!\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index eba270121698..46550811da00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -99,10 +99,7 @@ bool dm_pp_apply_display_requirements(
 			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
 		}
 
-		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->display_configuration_change)
-			adev->powerplay.pp_funcs->display_configuration_change(
-				adev->powerplay.pp_handle,
-				&adev->pm.pm_display_cfg);
+		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
 
 		amdgpu_pm_compute_clocks(adev);
 	}
@@ -298,31 +295,25 @@ bool dm_pp_get_clock_levels_by_type(
 		struct dm_pp_clock_levels *dc_clks)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
 	struct amd_pp_clocks pp_clks = { 0 };
 	struct amd_pp_simple_clock_info validation_clks = { 0 };
 	uint32_t i;
 
-	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_clock_by_type) {
-		if (adev->powerplay.pp_funcs->get_clock_by_type(pp_handle,
-			dc_to_pp_clock_type(clk_type), &pp_clks)) {
-			/* Error in pplib. Provide default values. */
-			get_default_clock_levels(clk_type, dc_clks);
-			return true;
-		}
+	if (amdgpu_dpm_get_clock_by_type(adev,
+		dc_to_pp_clock_type(clk_type), &pp_clks)) {
+		/* Error in pplib. Provide default values. */
+		get_default_clock_levels(clk_type, dc_clks);
+		return true;
 	}
 
 	pp_to_dc_clock_levels(&pp_clks, dc_clks, clk_type);
 
-	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_display_mode_validation_clocks) {
-		if (adev->powerplay.pp_funcs->get_display_mode_validation_clocks(
-						pp_handle, &validation_clks)) {
-			/* Error in pplib. Provide default values. */
-			DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
-			validation_clks.engine_max_clock = 72000;
-			validation_clks.memory_max_clock = 80000;
-			validation_clks.level = 0;
-		}
+	if (amdgpu_dpm_get_display_mode_validation_clks(adev, &validation_clks)) {
+		/* Error in pplib. Provide default values. */
+		DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
+		validation_clks.engine_max_clock = 72000;
+		validation_clks.memory_max_clock = 80000;
+		validation_clks.level = 0;
 	}
 
 	DRM_INFO("DM_PPLIB: Validation clocks:\n");
@@ -370,18 +361,14 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 	struct dm_pp_clock_levels_with_latency *clk_level_info)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
 	struct pp_clock_levels_with_latency pp_clks = { 0 };
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret;
 
-	if (pp_funcs && pp_funcs->get_clock_by_type_with_latency) {
-		ret = pp_funcs->get_clock_by_type_with_latency(pp_handle,
-						dc_to_pp_clock_type(clk_type),
-						&pp_clks);
-		if (ret)
-			return false;
-	}
+	ret = amdgpu_dpm_get_clock_by_type_with_latency(adev,
+					dc_to_pp_clock_type(clk_type),
+					&pp_clks);
+	if (ret)
+		return false;
 
 	pp_to_dc_clock_levels_with_latency(&pp_clks, clk_level_info, clk_type);
 
@@ -394,18 +381,14 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 	struct dm_pp_clock_levels_with_voltage *clk_level_info)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
 	struct pp_clock_levels_with_voltage pp_clk_info = {0};
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret;
 
-	if (pp_funcs && pp_funcs->get_clock_by_type_with_voltage) {
-		ret = pp_funcs->get_clock_by_type_with_voltage(pp_handle,
-						dc_to_pp_clock_type(clk_type),
-						&pp_clk_info);
-		if (ret)
-			return false;
-	}
+	ret = amdgpu_dpm_get_clock_by_type_with_voltage(adev,
+					dc_to_pp_clock_type(clk_type),
+					&pp_clk_info);
+	if (ret)
+		return false;
 
 	pp_to_dc_clock_levels_with_voltage(&pp_clk_info, clk_level_info, clk_type);
 
@@ -417,19 +400,16 @@ bool dm_pp_notify_wm_clock_changes(
 	struct dm_pp_wm_sets_with_clock_ranges *wm_with_clock_ranges)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	/*
 	 * Limit this watermark setting for Polaris for now
 	 * TODO: expand this to other ASICs
 	 */
-	if ((adev->asic_type >= CHIP_POLARIS10) && (adev->asic_type <= CHIP_VEGAM)
-	     && pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
-		if (!pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
+	if ((adev->asic_type >= CHIP_POLARIS10) &&
+	     (adev->asic_type <= CHIP_VEGAM) &&
+	     !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
 						(void *)wm_with_clock_ranges))
 			return true;
-	}
 
 	return false;
 }
@@ -456,12 +436,10 @@ bool dm_pp_apply_clock_for_voltage_request(
 	if (!pp_clock_request.clock_type)
 		return false;
 
-	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->display_clock_voltage_request)
-		ret = adev->powerplay.pp_funcs->display_clock_voltage_request(
-			adev->powerplay.pp_handle,
-			&pp_clock_request);
-	if (ret)
+	ret = amdgpu_dpm_display_clock_voltage_request(adev, &pp_clock_request);
+	if (ret && (ret != -EOPNOTSUPP))
 		return false;
+
 	return true;
 }
 
@@ -471,15 +449,8 @@ bool dm_pp_get_static_clocks(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	struct amd_pp_clock_info pp_clk_info = {0};
-	int ret = 0;
 
-	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_current_clocks)
-		ret = adev->powerplay.pp_funcs->get_current_clocks(
-			adev->powerplay.pp_handle,
-			&pp_clk_info);
-	else
-		return false;
-	if (ret)
+	if (amdgpu_dpm_get_current_clocks(adev, &pp_clk_info))
 		return false;
 
 	static_clk_info->max_clocks_state = pp_to_dc_powerlevel_state(pp_clk_info.max_clocks_state);
@@ -494,8 +465,6 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
 	struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks = wm_with_clock_ranges.wm_dmif_clocks_ranges;
 	struct dm_pp_clock_range_for_mcif_wm_set_soc15 *wm_soc_clocks = wm_with_clock_ranges.wm_mcif_clocks_ranges;
@@ -536,72 +505,48 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 				ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000;
 	}
 
-	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
-		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
-							   &wm_with_clock_ranges);
+	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
+						    &wm_with_clock_ranges);
 }
 
 static void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->notify_smu_enable_pwe)
-		pp_funcs->notify_smu_enable_pwe(pp_handle);
+	amdgpu_dpm_notify_smu_enable_pwe(adev);
 }
 
 static void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!pp_funcs || !pp_funcs->set_active_display_count)
-		return;
-
-	pp_funcs->set_active_display_count(pp_handle, count);
+	amdgpu_dpm_set_active_display_count(adev, count);
 }
 
 static void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (!pp_funcs || !pp_funcs->set_min_deep_sleep_dcefclk)
-		return;
 
-	pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, clock);
+	amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, clock);
 }
 
 static void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!pp_funcs || !pp_funcs->set_hard_min_dcefclk_by_freq)
-		return;
-
-	pp_funcs->set_hard_min_dcefclk_by_freq(pp_handle, clock);
+	amdgpu_dpm_set_hard_min_dcefclk_by_freq(adev, clock);
 }
 
 static void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (!pp_funcs || !pp_funcs->set_hard_min_fclk_by_freq)
-		return;
 
-	pp_funcs->set_hard_min_fclk_by_freq(pp_handle, mhz);
+	amdgpu_dpm_set_hard_min_fclk_by_freq(adev, mhz);
 }
 
 static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
@@ -609,11 +554,8 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
-		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
+	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
@@ -622,14 +564,13 @@ static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
-	if (!pp_funcs || !pp_funcs->set_active_display_count)
+	ret = amdgpu_dpm_set_active_display_count(adev, count);
+	if (ret == -EOPNOTSUPP)
 		return PP_SMU_RESULT_UNSUPPORTED;
-
-	/* 0: successful or smu.ppt_funcs->set_display_count = NULL;  1: fail */
-	if (pp_funcs->set_active_display_count(pp_handle, count))
+	else if (ret)
+		/* 0: successful or smu.ppt_funcs->set_display_count = NULL;  1: fail */
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -640,14 +581,13 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (!pp_funcs || !pp_funcs->set_min_deep_sleep_dcefclk)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	int ret = 0;
 
 	/* 0: successful or smu.ppt_funcs->set_deep_sleep_dcefclk = NULL;1: fail */
-	if (pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, mhz))
+	ret = amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, mhz);
+	if (ret == -EOPNOTSUPP)
+		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -658,12 +598,8 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
-
-	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	int ret = 0;
 
 	clock_req.clock_type = amd_pp_dcef_clock;
 	clock_req.clock_freq_in_khz = mhz * 1000;
@@ -671,7 +607,10 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
+	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
+	if (ret == -EOPNOTSUPP)
+		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -682,12 +621,8 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
-
-	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	int ret = 0;
 
 	clock_req.clock_type = amd_pp_mem_clock;
 	clock_req.clock_freq_in_khz = mhz * 1000;
@@ -695,7 +630,10 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
+	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
+	if (ret == -EOPNOTSUPP)
+		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -706,14 +644,10 @@ static enum pp_smu_status pp_nv_set_pstate_handshake_support(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->display_disable_memory_clock_switch) {
-		if (pp_funcs->display_disable_memory_clock_switch(pp_handle,
-								  !pstate_handshake_supported))
-			return PP_SMU_RESULT_FAIL;
-	}
+	if (amdgpu_dpm_display_disable_memory_clock_switch(adev,
+							  !pstate_handshake_supported))
+		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
 }
@@ -723,12 +657,8 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_display_clock_request clock_req;
-
-	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
-		return PP_SMU_RESULT_UNSUPPORTED;
+	int ret = 0;
 
 	switch (clock_id) {
 	case PP_SMU_NV_DISPCLK:
@@ -748,7 +678,10 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 	/* 0: successful or smu.ppt_funcs->display_clock_voltage_request = NULL
 	 * 1: fail
 	 */
-	if (pp_funcs->display_clock_voltage_request(pp_handle, &clock_req))
+	ret = amdgpu_dpm_display_clock_voltage_request(adev, &clock_req);
+	if (ret == -EOPNOTSUPP)
+		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
 		return PP_SMU_RESULT_FAIL;
 
 	return PP_SMU_RESULT_OK;
@@ -759,16 +692,16 @@ static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
-	if (!pp_funcs || !pp_funcs->get_max_sustainable_clocks_by_dc)
+	ret = amdgpu_dpm_get_max_sustainable_clocks_by_dc(adev,
+							  max_clocks);
+	if (ret == -EOPNOTSUPP)
 		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
+		return PP_SMU_RESULT_FAIL;
 
-	if (!pp_funcs->get_max_sustainable_clocks_by_dc(pp_handle, max_clocks))
-		return PP_SMU_RESULT_OK;
-
-	return PP_SMU_RESULT_FAIL;
+	return PP_SMU_RESULT_OK;
 }
 
 static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
@@ -776,18 +709,17 @@ static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
-	if (!pp_funcs || !pp_funcs->get_uclk_dpm_states)
+	ret = amdgpu_dpm_get_uclk_dpm_states(adev,
+					     clock_values_in_khz,
+					    num_states);
+	if (ret == -EOPNOTSUPP)
 		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
+		return PP_SMU_RESULT_FAIL;
 
-	if (!pp_funcs->get_uclk_dpm_states(pp_handle,
-					   clock_values_in_khz,
-					   num_states))
-		return PP_SMU_RESULT_OK;
-
-	return PP_SMU_RESULT_FAIL;
+	return PP_SMU_RESULT_OK;
 }
 
 static enum pp_smu_status pp_rn_get_dpm_clock_table(
@@ -795,16 +727,15 @@ static enum pp_smu_status pp_rn_get_dpm_clock_table(
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
-	if (!pp_funcs || !pp_funcs->get_dpm_clock_table)
+	ret = amdgpu_dpm_get_dpm_clock_table(adev, clock_table);
+	if (ret == -EOPNOTSUPP)
 		return PP_SMU_RESULT_UNSUPPORTED;
+	else if (ret)
+		return PP_SMU_RESULT_FAIL;
 
-	if (!pp_funcs->get_dpm_clock_table(pp_handle, clock_table))
-		return PP_SMU_RESULT_OK;
-
-	return PP_SMU_RESULT_FAIL;
+	return PP_SMU_RESULT_OK;
 }
 
 static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
@@ -812,11 +743,8 @@ static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
-		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle, ranges);
+	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev, ranges);
 
 	return PP_SMU_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 2c789eb5d066..3a84c3995f2d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1659,6 +1659,14 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
 	}
 }
 
+int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
+{
+	if (!is_support_sw_smu(adev))
+		return 0;
+
+	return smu_write_watermarks_table(&adev->smu);
+}
+
 int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
 			      enum smu_event_type event,
 			      uint64_t event_arg)
@@ -2158,3 +2166,213 @@ void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
 
 	amdgpu_smu_stb_debug_fs_init(adev);
 }
+
+int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
+					    const struct amd_pp_display_configuration *input)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->display_configuration_change)
+		return 0;
+
+	return pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
+						      input);
+}
+
+int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
+				 enum amd_pp_clock_type type,
+				 struct amd_pp_clocks *clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_clock_by_type)
+		return 0;
+
+	return pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
+					   type,
+					   clocks);
+}
+
+int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
+						struct amd_pp_simple_clock_info *clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_display_mode_validation_clocks)
+		return 0;
+
+	return pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
+							    clocks);
+}
+
+int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
+					      enum amd_pp_clock_type type,
+					      struct pp_clock_levels_with_latency *clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_clock_by_type_with_latency)
+		return 0;
+
+	return pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
+							type,
+							clocks);
+}
+
+int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
+					      enum amd_pp_clock_type type,
+					      struct pp_clock_levels_with_voltage *clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_clock_by_type_with_voltage)
+		return 0;
+
+	return pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
+							type,
+							clocks);
+}
+
+int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
+					       void *clock_ranges)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->set_watermarks_for_clocks_ranges)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
+							  clock_ranges);
+}
+
+int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
+					     struct pp_display_clock_request *clock)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->display_clock_voltage_request)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
+						       clock);
+}
+
+int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
+				  struct amd_pp_clock_info *clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_current_clocks)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
+					    clocks);
+}
+
+void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->notify_smu_enable_pwe)
+		return;
+
+	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
+}
+
+int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
+					uint32_t count)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->set_active_display_count)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
+						  count);
+}
+
+int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
+					  uint32_t clock)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->set_min_deep_sleep_dcefclk)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
+						    clock);
+}
+
+void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
+					     uint32_t clock)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
+		return;
+
+	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
+					       clock);
+}
+
+void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
+					  uint32_t clock)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->set_hard_min_fclk_by_freq)
+		return;
+
+	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
+					    clock);
+}
+
+int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
+						   bool disable_memory_clock_switch)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->display_disable_memory_clock_switch)
+		return 0;
+
+	return pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
+							     disable_memory_clock_switch);
+}
+
+int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
+						struct pp_smu_nv_clock_table *max_clocks)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
+							  max_clocks);
+}
+
+enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
+						  unsigned int *clock_values_in_khz,
+						  unsigned int *num_states)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_uclk_dpm_states)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
+					     clock_values_in_khz,
+					     num_states);
+}
+
+int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
+				   struct dpm_clocks *clock_table)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs->get_dpm_clock_table)
+		return -EOPNOTSUPP;
+
+	return pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
+					     clock_table);
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 039c40b1d0cb..fea203a79cb4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -500,6 +500,7 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
 				        enum pp_clock_type type,
 				        uint32_t min,
 				        uint32_t max);
+int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev);
 int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
 int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
@@ -578,4 +579,41 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    size_t size);
 int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
 void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
+int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
+					    const struct amd_pp_display_configuration *input);
+int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
+				 enum amd_pp_clock_type type,
+				 struct amd_pp_clocks *clocks);
+int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
+						struct amd_pp_simple_clock_info *clocks);
+int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
+					      enum amd_pp_clock_type type,
+					      struct pp_clock_levels_with_latency *clocks);
+int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
+					      enum amd_pp_clock_type type,
+					      struct pp_clock_levels_with_voltage *clocks);
+int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
+					       void *clock_ranges);
+int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
+					     struct pp_display_clock_request *clock);
+int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
+				  struct amd_pp_clock_info *clocks);
+void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev);
+int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
+					uint32_t count);
+int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
+					  uint32_t clock);
+void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
+					     uint32_t clock);
+void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
+					  uint32_t clock);
+int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
+						   bool disable_memory_clock_switch);
+int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
+						struct pp_smu_nv_clock_table *max_clocks);
+enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
+						  unsigned int *clock_values_in_khz,
+						  unsigned int *num_states);
+int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
+				   struct dpm_clocks *clock_table);
 #endif
-- 
2.29.0

