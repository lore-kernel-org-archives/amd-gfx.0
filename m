Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF2CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1852310F0A0;
	Wed, 24 Jun 2026 18:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4/CWcW1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD9F10F0A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEnUANWzS55a4s9Qld4qveYqeMJo+GAUkSOnGp2NePvV4zm1YUhHlF7mW+Um/m7Oi5/plnGjTSQ5IHaqKdkoPxjp+SaYjjckLr7F282+B/wRLcoxRqvAb6bdYOxXhR0k1IX+KlymdM6uIyLW6so3GaFay7H8fGFRYaMVgBkVnMwOMSOr9aDomoKta4atouHTQVXHHX+yt5ee73FDNLH+FdKt6ANaa5LQ7Q+uSZ97Pxvwh3UXh4uVoXj/JvP0dVsLyj2vYZsGjCV2+XOcC6ccpXJx5IbQpSuJwPK9yk7iRV5nz/kvY4HbcpSpcVi5t2aLKTeEVH204AwuINwy4l2JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbjPdSgtcnrhTUvJDnHqKIiRpvQCcEL2lT/sg2UVSLU=;
 b=dc0ijtl/7M5LhFUBdAVsq72Fq2vgWZXn5pCUYdcqSY88jCWcyzeUqq9fKxhGhqizGLCDcTq9Pid7qQualfXt+XwVO43p+q3KCw/QzytY6zBtK1xTA0zUDnOXyCVxIaEHjrcDmARogfqLeiMqfFiIiy/HDa8tfryyeoT03nNSZa84im5K9f6CZOr3xPOyj8p8gkRTSaEu40X7eolixNaWazwxuUBomvI4X/6ENzZkvHw1KZ53CMNsJaIOtuP/FXKmZNmiaKddrDfN+blz/FsDN3SsR4Ehc9BCMwfufLq2Zt1L5BPxREtViificytKRMFy68oQKG+WU5PHRR5OdpkUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbjPdSgtcnrhTUvJDnHqKIiRpvQCcEL2lT/sg2UVSLU=;
 b=D4/CWcW1n2XRoJ1v644HOeNdkerWmtngqrEPuQ2PhxU6gFA3815sNCoiS46E2wB8kmfD3pHsZDHKZAznQ/j38BznZjOJZsQowGzrjosGFZb3eUP/aPPMIFfVjtrEU6XpWTKWUd0rKheslTHxsRCoBoC/iPAFvfCXkOyPJruHJLg=
Received: from SJ0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:33a::11)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 18:09:42 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::4) by SJ0PR03CA0006.outlook.office365.com
 (2603:10b6:a03:33a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:42 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:31 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 20/28] drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
Date: Wed, 24 Jun 2026 14:03:18 -0400
Message-ID: <20260624180829.4775-21-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e2e623-71d3-415e-7db1-08ded21bc3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|6133799003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2DDjoR/ymTJ0o8ydc+KTVxPeyNXvgE4jnWWtZqhtdULVMgVw8hYv5gXGxdPBW/LCw/KdJjjnFyktwnStJ9sAAsdvrRoXpeXCsSOfZ/Vzjmg7/eTNSAV8GSCP83Pdtpo9FO3ikrz+/jfRHvdb3H3QRxnew8j4iOdubV5XfM4i2LXeiod4o0Mq+sUmbkkLUUaTMwwVLjrJtJdpxlx6vwDOqTnTEKPc3V2EN2qP+nJua+JUnmdofvBZCS8JWKDHij6Iz+K5z9TM8gPlA4+qSUznDzY8m67nRs/drPbgbdF81ZA5IMMOOb18dYbBkEcpi2etPsKuWbAXT4aQK0jeRH+OtcRjleKxeUT0a2HmhlIGnCnzTGcgW83IvXW5wIAJToHnQiPBN4F8FKSqln56EnpRaK+PNRbOxMFl4l9vcK4DNWrVBcsyg3XNfbsQeefW9icqlU7i4XT5TVcLaZ9ORmJv0UW1rCcnQ4pA2QzZ6nyWxVGygnhmfuqB8RZzVUOq8ofmtF78yNDRkiG/dZB46yUKplSiTpjYnFjX2QXpk8Bl3YMZqX5pkQQr9AVawWdhU0ihRoQLrqRjT3wkFG6T38RtJNNhKApj0oQa7P8iSvFpInQyVnYL7YsxMgorptAVEBN+SiRyDn9Oz9XCI3PqiWn5IsfzsJl2U7NkNLcya/LB6bBk/uw6HNkKOUBoK6b81tJkHqzhyE17VBUJuFedfhZltg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0wlaTLozNmBR9MASxyzvgwQ98MhPhFgtenIgPMlC8CWfW14b4nVadoRsARHzwFLRcAQQKrEJVDV9JoUnQTw2HyQNqeU1+Cc/W5zQdtOX+ezcV36YN2ATU34sBqxWogrH/zRYBi1sRlpT1/NdlLHJ+bdue1ZiEJoc5M0UAr7BWkKG1p9iis33KbXrTJ6H4pUQHGlxr92YwCJqPq7FMv7/pHZ2iCQXmRyZJMx2X/9toLTnGFRSuKYtsPGTxkyVefx4VDKPff3p8y7aX73n9bX2zbQ2tNhbJOsyxZQei1BWhufi04tLSB3FJL8asZs5AG4XWWzoRpF64EGB3omAt/1aracAjoCJEYfHeX6En3r6YcERhyQV8JyrrH4eDHOryGuLBn6uMxXnd4CnwGLpx+WS5jwpwwN8u6xYFSkCtLLJa0XhsYur5N/hrxSB4RvwfZP9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:42.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e2e623-71d3-415e-7db1-08ded21bc3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Add comprehensive KUnit test coverage for amdgpu_dm_pp_smu.c including:
- Utility functions: dc_to_pp_clock_type, pp_to_dc_clock_levels,
  build_pm_display_cfg, get_default_clock_levels,
  build_wm_clock_ranges_soc15, cap_clock_levels_to_validation
- DPM-backed functions: dm_pp_get_clock_levels_by_type,
  dm_pp_notify_wm_clock_changes, dm_pp_apply_clock_for_voltage_request,
  dm_pp_get_static_clocks
- Raven pass-throughs: pp_rv_set_wm_ranges, pp_rv_set_pme_wa_enable,
  pp_rv_set_active_display_count, pp_rv_set_min_deep_sleep_dcfclk,
  pp_rv_set_hard_min_dcefclk_by_freq, pp_rv_set_hard_min_fclk_by_freq
- Navi functions: pp_nv_set_wm_ranges, pp_nv_get_maximum_sustainable_clocks,
  pp_nv_get_uclk_dpm_states, pp_nv_get_dpm_clock_table
- Renoir: pp_rn_get_dpm_clock_table
- dm_pp_get_funcs ASIC family selection

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   52 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |   23 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 1535 ++++++++++++++++-
 3 files changed, 1592 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index e0fe4cb97f31..0d2e5294d062 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -337,6 +337,7 @@ bool dm_pp_get_clock_levels_by_type(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type);
 
 bool dm_pp_get_clock_levels_by_type_with_latency(
 	const struct dc_context *ctx,
@@ -357,6 +358,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_latency);
 
 bool dm_pp_get_clock_levels_by_type_with_voltage(
 	const struct dc_context *ctx,
@@ -377,6 +379,7 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_voltage);
 
 bool dm_pp_notify_wm_clock_changes(
 	const struct dc_context *ctx,
@@ -396,6 +399,7 @@ bool dm_pp_notify_wm_clock_changes(
 
 	return false;
 }
+EXPORT_IF_KUNIT(dm_pp_notify_wm_clock_changes);
 
 bool dm_pp_apply_clock_for_voltage_request(
 	const struct dc_context *ctx,
@@ -464,7 +468,7 @@ STATIC_IFN_KUNIT void build_wm_clock_ranges_soc15(
 }
 EXPORT_IF_KUNIT(build_wm_clock_ranges_soc15);
 
-static void pp_rv_set_wm_ranges(struct pp_smu *pp,
+STATIC_IFN_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -476,48 +480,54 @@ static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
 						    &wm_with_clock_ranges);
 }
+EXPORT_IF_KUNIT(pp_rv_set_wm_ranges);
 
-static void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
+STATIC_IFN_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
 
 	amdgpu_dpm_notify_smu_enable_pwe(adev);
 }
+EXPORT_IF_KUNIT(pp_rv_set_pme_wa_enable);
 
-static void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
+STATIC_IFN_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
 
 	amdgpu_dpm_set_active_display_count(adev, count);
 }
+EXPORT_IF_KUNIT(pp_rv_set_active_display_count);
 
-static void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
+STATIC_IFN_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
 
 	amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, clock);
 }
+EXPORT_IF_KUNIT(pp_rv_set_min_deep_sleep_dcfclk);
 
-static void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
+STATIC_IFN_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
 
 	amdgpu_dpm_set_hard_min_dcefclk_by_freq(adev, clock);
 }
+EXPORT_IF_KUNIT(pp_rv_set_hard_min_dcefclk_by_freq);
 
-static void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
+STATIC_IFN_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
 
 	amdgpu_dpm_set_hard_min_fclk_by_freq(adev, mhz);
 }
+EXPORT_IF_KUNIT(pp_rv_set_hard_min_fclk_by_freq);
 
-static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -527,8 +537,9 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_wm_ranges);
 
-static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -543,8 +554,9 @@ static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_display_count);
 
-static enum pp_smu_status
+STATIC_IFN_KUNIT enum pp_smu_status
 pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -560,8 +572,9 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_min_deep_sleep_dcfclk);
 
-static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 		struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -583,8 +596,9 @@ static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_hard_min_dcefclk_by_freq);
 
-static enum pp_smu_status
+STATIC_IFN_KUNIT enum pp_smu_status
 pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -606,8 +620,9 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_hard_min_uclk_by_freq);
 
-static enum pp_smu_status pp_nv_set_pstate_handshake_support(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	struct pp_smu *pp, bool pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -619,6 +634,7 @@ static enum pp_smu_status pp_nv_set_pstate_handshake_support(
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_pstate_handshake_support);
 
 STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 		enum amd_pp_clock_type *clock_type)
@@ -641,7 +657,7 @@ STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 }
 EXPORT_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
 
-static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 		enum pp_smu_nv_clock_id clock_id, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -665,8 +681,9 @@ static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_set_voltage_by_freq);
 
-static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 		struct pp_smu *pp, struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -682,8 +699,9 @@ static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_get_maximum_sustainable_clocks);
 
-static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 		unsigned int *clock_values_in_khz, unsigned int *num_states)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -700,8 +718,9 @@ static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_nv_get_uclk_dpm_states);
 
-static enum pp_smu_status pp_rn_get_dpm_clock_table(
+STATIC_IFN_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
 		struct pp_smu *pp, struct dpm_clocks *clock_table)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -716,6 +735,7 @@ static enum pp_smu_status pp_rn_get_dpm_clock_table(
 
 	return PP_SMU_RESULT_OK;
 }
+EXPORT_IF_KUNIT(pp_rn_get_dpm_clock_table);
 
 void dm_pp_get_funcs(
 		struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
index e851e3ee5b63..f918eb71f0d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
@@ -33,6 +33,29 @@ void cap_clock_levels_to_validation(struct dm_pp_clock_levels *dc_clks,
 				    const struct amd_pp_simple_clock_info *validation_clks);
 bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 			      enum amd_pp_clock_type *clock_type);
+void pp_rv_set_wm_ranges(struct pp_smu *pp, struct pp_smu_wm_range_sets *ranges);
+void pp_rv_set_pme_wa_enable(struct pp_smu *pp);
+void pp_rv_set_active_display_count(struct pp_smu *pp, int count);
+void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock);
+void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock);
+void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz);
+enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
+					struct pp_smu_wm_range_sets *ranges);
+enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count);
+enum pp_smu_status pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz);
+enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int mhz);
+enum pp_smu_status pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz);
+enum pp_smu_status pp_nv_set_pstate_handshake_support(struct pp_smu *pp,
+						      bool pstate_handshake_supported);
+enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+					     enum pp_smu_nv_clock_id clock_id, int mhz);
+enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(struct pp_smu *pp,
+							struct pp_smu_nv_clock_table *max_clocks);
+enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
+					     unsigned int *clock_values_in_khz,
+					     unsigned int *num_states);
+enum pp_smu_status pp_rn_get_dpm_clock_table(struct pp_smu *pp,
+					     struct dpm_clocks *clock_table);
 #endif
 
 #endif /* __AMDGPU_DM_PP_SMU_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
index dbb6dfd5c284..e1d5088d8c0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 #include "dc.h"
 #include "dm_services.h"
@@ -16,6 +17,201 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_pp_smu.h"
 
+/* ---- Stub DPM layer ---- */
+
+/**
+ * struct stub_dpm_context - Tracks stub DPM callback invocations
+ * @ret_val: Return value for the next DPM callback
+ * @get_current_clocks_info: Clock info returned by stub get_current_clocks
+ * @get_clock_by_type_clocks: Clocks returned by stub get_clock_by_type
+ * @get_validation_clks: Validation clocks returned by stub
+ * @get_clock_by_type_with_latency_clks: Returned by stub with_latency
+ * @get_clock_by_type_with_voltage_clks: Returned by stub with_voltage
+ * @set_watermarks_ret: Return value for set_watermarks
+ * @display_clock_voltage_ret: Return value for display_clock_voltage_request
+ * @display_disable_memory_clock_switch_ret: Return for disable_memory_clock
+ * @get_max_sustainable_ret: Return for get_max_sustainable_clocks_by_dc
+ * @get_uclk_dpm_ret: Return for get_uclk_dpm_states
+ * @get_dpm_clock_table_ret: Return for get_dpm_clock_table
+ * @set_active_display_count_ret: Return for set_active_display_count
+ * @set_min_deep_sleep_dcefclk_ret: Return for set_min_deep_sleep_dcefclk
+ * @get_validation_clks_ret: Return for get_display_mode_validation_clocks
+ */
+struct stub_dpm_context {
+	int ret_val;
+	struct amd_pp_clock_info get_current_clocks_info;
+	struct amd_pp_clocks get_clock_by_type_clocks;
+	struct amd_pp_simple_clock_info get_validation_clks;
+	int get_validation_clks_ret;
+	struct pp_clock_levels_with_latency get_clock_by_type_with_latency_clks;
+	struct pp_clock_levels_with_voltage get_clock_by_type_with_voltage_clks;
+	int set_watermarks_ret;
+	int display_clock_voltage_ret;
+	int display_disable_memory_clock_switch_ret;
+	int get_max_sustainable_ret;
+	int get_uclk_dpm_ret;
+	int get_dpm_clock_table_ret;
+	int set_active_display_count_ret;
+	int set_min_deep_sleep_dcefclk_ret;
+};
+
+static struct stub_dpm_context *stub_dpm_ctx;
+
+static int stub_get_current_clocks(void *handle, struct amd_pp_clock_info *clocks)
+{
+	if (stub_dpm_ctx->ret_val)
+		return stub_dpm_ctx->ret_val;
+	*clocks = stub_dpm_ctx->get_current_clocks_info;
+	return 0;
+}
+
+static int stub_get_clock_by_type(void *handle, enum amd_pp_clock_type type,
+				  struct amd_pp_clocks *clocks)
+{
+	if (stub_dpm_ctx->ret_val)
+		return stub_dpm_ctx->ret_val;
+	*clocks = stub_dpm_ctx->get_clock_by_type_clocks;
+	return 0;
+}
+
+static int stub_get_display_mode_validation_clocks(void *handle,
+						   struct amd_pp_simple_clock_info *clocks)
+{
+	if (stub_dpm_ctx->get_validation_clks_ret)
+		return stub_dpm_ctx->get_validation_clks_ret;
+	*clocks = stub_dpm_ctx->get_validation_clks;
+	return 0;
+}
+
+static int stub_get_clock_by_type_with_latency(void *handle,
+					       enum amd_pp_clock_type type,
+					       struct pp_clock_levels_with_latency *clocks)
+{
+	if (stub_dpm_ctx->ret_val)
+		return stub_dpm_ctx->ret_val;
+	*clocks = stub_dpm_ctx->get_clock_by_type_with_latency_clks;
+	return 0;
+}
+
+static int stub_get_clock_by_type_with_voltage(void *handle,
+					       enum amd_pp_clock_type type,
+					       struct pp_clock_levels_with_voltage *clocks)
+{
+	if (stub_dpm_ctx->ret_val)
+		return stub_dpm_ctx->ret_val;
+	*clocks = stub_dpm_ctx->get_clock_by_type_with_voltage_clks;
+	return 0;
+}
+
+static void stub_display_configuration_change(void *handle)
+{
+	/* No-op: satisfies display_configuration_changed callback */
+}
+
+static void stub_pm_compute_clocks(void *handle)
+{
+	/* No-op: satisfies pm_compute_clocks callback */
+}
+
+static int stub_set_watermarks_for_clocks_ranges(void *handle, void *clock_ranges)
+{
+	return stub_dpm_ctx->set_watermarks_ret;
+}
+
+static int stub_display_clock_voltage_request(void *handle,
+					      struct pp_display_clock_request *clock)
+{
+	return stub_dpm_ctx->display_clock_voltage_ret;
+}
+
+static int stub_set_active_display_count(void *handle, uint32_t count)
+{
+	return stub_dpm_ctx->set_active_display_count_ret;
+}
+
+static int stub_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
+{
+	return stub_dpm_ctx->set_min_deep_sleep_dcefclk_ret;
+}
+
+static int stub_set_hard_min_dcefclk_by_freq(void *handle, uint32_t clock)
+{
+	return 0;
+}
+
+static int stub_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
+{
+	return 0;
+}
+
+static int stub_notify_smu_enable_pwe(void *handle)
+{
+	return 0;
+}
+
+static int stub_display_disable_memory_clock_switch(void *handle,
+						    bool disable_memory_clock_switch)
+{
+	return stub_dpm_ctx->display_disable_memory_clock_switch_ret;
+}
+
+static int stub_get_max_sustainable_clocks_by_dc(void *handle,
+						 struct pp_smu_nv_clock_table *max_clocks)
+{
+	return stub_dpm_ctx->get_max_sustainable_ret;
+}
+
+static int stub_get_uclk_dpm_states(void *handle,
+				    unsigned int *clock_values_in_khz,
+				    unsigned int *num_states)
+{
+	return stub_dpm_ctx->get_uclk_dpm_ret;
+}
+
+static int stub_get_dpm_clock_table(void *handle, struct dpm_clocks *clock_table)
+{
+	return stub_dpm_ctx->get_dpm_clock_table_ret;
+}
+
+static const struct amd_pm_funcs stub_pp_funcs = {
+	.get_current_clocks = stub_get_current_clocks,
+	.get_clock_by_type = stub_get_clock_by_type,
+	.get_display_mode_validation_clocks = stub_get_display_mode_validation_clocks,
+	.get_clock_by_type_with_latency = stub_get_clock_by_type_with_latency,
+	.get_clock_by_type_with_voltage = stub_get_clock_by_type_with_voltage,
+	.display_configuration_changed = stub_display_configuration_change,
+	.pm_compute_clocks = stub_pm_compute_clocks,
+	.set_watermarks_for_clocks_ranges = stub_set_watermarks_for_clocks_ranges,
+	.display_clock_voltage_request = stub_display_clock_voltage_request,
+	.set_active_display_count = stub_set_active_display_count,
+	.set_min_deep_sleep_dcefclk = stub_set_min_deep_sleep_dcefclk,
+	.set_hard_min_dcefclk_by_freq = stub_set_hard_min_dcefclk_by_freq,
+	.set_hard_min_fclk_by_freq = stub_set_hard_min_fclk_by_freq,
+	.notify_smu_enable_pwe = stub_notify_smu_enable_pwe,
+	.display_disable_memory_clock_switch = stub_display_disable_memory_clock_switch,
+	.get_max_sustainable_clocks_by_dc = stub_get_max_sustainable_clocks_by_dc,
+	.get_uclk_dpm_states = stub_get_uclk_dpm_states,
+	.get_dpm_clock_table = stub_get_dpm_clock_table,
+};
+
+/**
+ * setup_stub_dpm - Initialize a stub DPM environment for testing
+ * @test: KUnit test context
+ * @adev: Pointer to amdgpu_device to configure
+ *
+ * Sets up adev->powerplay.pp_funcs and initializes adev->pm.mutex so that
+ * amdgpu_dpm_* functions can be safely called with stub callbacks.
+ */
+static void setup_stub_dpm(struct kunit *test, struct amdgpu_device *adev)
+{
+	stub_dpm_ctx = kunit_kzalloc(test, sizeof(*stub_dpm_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stub_dpm_ctx);
+
+	adev->powerplay.pp_funcs = &stub_pp_funcs;
+	adev->powerplay.pp_handle = adev;
+	mutex_init(&adev->pm.mutex);
+}
+
 /* ---- Tests for get_default_clock_levels ---- */
 
 /**
@@ -706,23 +902,35 @@ static void dm_test_build_wm_clock_ranges_mcif(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, ranges);
 	KUNIT_ASSERT_NOT_NULL(test, wm);
 
-	ranges->num_writer_wm_sets = 1;
+	ranges->num_writer_wm_sets = 2;
 	ranges->writer_wm_sets[0].wm_inst = 1;
 	ranges->writer_wm_sets[0].max_fill_clk_mhz = 1200;
 	ranges->writer_wm_sets[0].min_fill_clk_mhz = 600;
 	ranges->writer_wm_sets[0].max_drain_clk_mhz = 1000;
 	ranges->writer_wm_sets[0].min_drain_clk_mhz = 500;
+	/* set 1: wm_inst > 3 -> clamped to WM_SET_A */
+	ranges->writer_wm_sets[1].wm_inst = 5;
+	ranges->writer_wm_sets[1].max_fill_clk_mhz = 1400;
+	ranges->writer_wm_sets[1].min_fill_clk_mhz = 700;
+	ranges->writer_wm_sets[1].max_drain_clk_mhz = 1100;
+	ranges->writer_wm_sets[1].min_drain_clk_mhz = 550;
 
 	build_wm_clock_ranges_soc15(ranges, wm);
 
 	KUNIT_EXPECT_EQ(test, wm->num_wm_dmif_sets, 0U);
-	KUNIT_EXPECT_EQ(test, wm->num_wm_mcif_sets, 1U);
+	KUNIT_EXPECT_EQ(test, wm->num_wm_mcif_sets, 2U);
 
 	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_set_id, WM_SET_B);
 	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_max_socclk_clk_in_khz, 1200000U);
 	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_min_socclk_clk_in_khz, 600000U);
 	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_max_mem_clk_in_khz, 1000000U);
 	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[0].wm_min_mem_clk_in_khz, 500000U);
+
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[1].wm_set_id, WM_SET_A);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[1].wm_max_socclk_clk_in_khz, 1400000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[1].wm_min_socclk_clk_in_khz, 700000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[1].wm_max_mem_clk_in_khz, 1100000U);
+	KUNIT_EXPECT_EQ(test, wm->wm_mcif_clocks_ranges[1].wm_min_mem_clk_in_khz, 550000U);
 }
 
 /* ---- Tests for cap_clock_levels_to_validation ---- */
@@ -911,6 +1119,1259 @@ static void dm_test_nv_clock_id_invalid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, clock_type, amd_pp_dcef_clock);
 }
 
+/* ---- Tests using stub DPM layer ---- */
+
+/**
+ * dm_test_get_static_clocks_success - Test successful static clock retrieval
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_get_static_clocks returns true and correctly scales
+ * the max engine and memory clocks from 10kHz to kHz units.
+ */
+static void dm_test_get_static_clocks_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_static_clock_info info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+
+	stub_dpm_ctx->get_current_clocks_info.max_memory_clock = 80000;
+	stub_dpm_ctx->get_current_clocks_info.max_engine_clock = 72000;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_static_clocks(ctx, &info));
+	KUNIT_EXPECT_EQ(test, info.max_mclk_khz, 800000U);
+	KUNIT_EXPECT_EQ(test, info.max_sclk_khz, 720000U);
+	KUNIT_EXPECT_EQ(test, (int)info.max_clocks_state, (int)DM_PP_CLOCKS_STATE_NOMINAL);
+}
+
+/**
+ * dm_test_get_static_clocks_failure - Test DPM error returns false
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_get_static_clocks returns false when the DPM callback
+ * returns an error.
+ */
+static void dm_test_get_static_clocks_failure(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_static_clock_info info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->ret_val = -EINVAL;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_get_static_clocks(ctx, &info));
+}
+
+/**
+ * dm_test_apply_display_requirements_dpm_enabled - Test DPM-enabled path
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_apply_display_requirements calls build_pm_display_cfg
+ * and the DPM callbacks when DPM is enabled, and returns true.
+ */
+static void dm_test_apply_display_requirements_dpm_enabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_display_configuration cfg = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	adev->pm.dpm_enabled = true;
+
+	cfg.display_count = 1;
+	cfg.min_engine_clock_khz = 300000;
+	cfg.disp_configs[0].v_refresh = 60;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_apply_display_requirements(ctx, &cfg));
+	KUNIT_EXPECT_EQ(test, adev->pm.pm_display_cfg.min_core_set_clock, 30000);
+	KUNIT_EXPECT_EQ(test, adev->pm.pm_display_cfg.vrefresh, 60);
+}
+
+/**
+ * dm_test_get_clock_levels_by_type_dpm_error - Test DPM error fallback
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_get_clock_levels_by_type falls back to default clock
+ * levels when amdgpu_dpm_get_clock_by_type returns an error.
+ */
+static void dm_test_get_clock_levels_by_type_dpm_error(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels dc_clks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->ret_val = -EINVAL;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_clock_levels_by_type(ctx,
+				DM_PP_CLOCK_TYPE_DISPLAY_CLK, &dc_clks));
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 6U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[0], 300000U);
+}
+
+/**
+ * dm_test_get_clock_levels_by_type_success - Test successful clock query
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_get_clock_levels_by_type returns the queried clocks
+ * capped by validation clocks.
+ */
+static void dm_test_get_clock_levels_by_type_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels dc_clks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+
+	stub_dpm_ctx->get_clock_by_type_clocks.count = 3;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[0] = 300000;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[1] = 500000;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[2] = 700000;
+
+	/* validation at 60000 * 10 = 600000 kHz → caps to 2 levels */
+	stub_dpm_ctx->get_validation_clks.engine_max_clock = 60000;
+	stub_dpm_ctx->get_validation_clks.memory_max_clock = 80000;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_clock_levels_by_type(ctx,
+				DM_PP_CLOCK_TYPE_ENGINE_CLK, &dc_clks));
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 2U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[0], 300000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[1], 500000U);
+}
+
+/**
+ * dm_test_get_clock_levels_by_type_validation_fallback - Test validation error
+ * @test: KUnit test context
+ *
+ * Verify that dm_pp_get_clock_levels_by_type uses default validation clocks
+ * (engine=720000, memory=800000 kHz) when get_display_mode_validation_clocks
+ * returns an error, capping levels accordingly.
+ */
+static void dm_test_get_clock_levels_by_type_validation_fallback(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels dc_clks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+
+	/* get_clock_by_type succeeds with 3 engine clock levels */
+	stub_dpm_ctx->get_clock_by_type_clocks.count = 3;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[0] = 300000;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[1] = 500000;
+	stub_dpm_ctx->get_clock_by_type_clocks.clock[2] = 800000;
+
+	/* Force validation clocks to fail → triggers default path */
+	stub_dpm_ctx->get_validation_clks_ret = -EINVAL;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_clock_levels_by_type(ctx,
+				DM_PP_CLOCK_TYPE_ENGINE_CLK, &dc_clks));
+	/*
+	 * Default validation: engine_max_clock = 72000 * 10 = 720000 kHz.
+	 * Clocks 300000 and 500000 are within limit, 800000 exceeds it,
+	 * so num_levels is capped to 2.
+	 */
+	KUNIT_EXPECT_EQ(test, dc_clks.num_levels, 2U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[0], 300000U);
+	KUNIT_EXPECT_EQ(test, dc_clks.clocks_in_khz[1], 500000U);
+}
+
+/**
+ * dm_test_get_clock_levels_with_latency_success - Test latency clock query
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_get_clock_levels_by_type_with_latency returns true and
+ * copies the clock/latency data from the DPM backend.
+ */
+static void dm_test_get_clock_levels_with_latency_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels_with_latency info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+
+	stub_dpm_ctx->get_clock_by_type_with_latency_clks.num_levels = 1;
+	stub_dpm_ctx->get_clock_by_type_with_latency_clks.data[0].clocks_in_khz = 600000;
+	stub_dpm_ctx->get_clock_by_type_with_latency_clks.data[0].latency_in_us = 15;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_clock_levels_by_type_with_latency(ctx,
+				DM_PP_CLOCK_TYPE_ENGINE_CLK, &info));
+	KUNIT_EXPECT_EQ(test, info.num_levels, 1U);
+	KUNIT_EXPECT_EQ(test, info.data[0].clocks_in_khz, 600000U);
+	KUNIT_EXPECT_EQ(test, info.data[0].latency_in_us, 15U);
+}
+
+/**
+ * dm_test_get_clock_levels_with_latency_failure - Test latency query error
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_get_clock_levels_by_type_with_latency returns false on DPM error.
+ */
+static void dm_test_get_clock_levels_with_latency_failure(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels_with_latency info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->ret_val = -EINVAL;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_get_clock_levels_by_type_with_latency(ctx,
+				DM_PP_CLOCK_TYPE_ENGINE_CLK, &info));
+}
+
+/**
+ * dm_test_get_clock_levels_with_voltage_success - Test voltage clock query
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_get_clock_levels_by_type_with_voltage returns true and
+ * copies the clock/voltage data from the DPM backend.
+ */
+static void dm_test_get_clock_levels_with_voltage_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels_with_voltage info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+
+	stub_dpm_ctx->get_clock_by_type_with_voltage_clks.num_levels = 1;
+	stub_dpm_ctx->get_clock_by_type_with_voltage_clks.data[0].clocks_in_khz = 400000;
+	stub_dpm_ctx->get_clock_by_type_with_voltage_clks.data[0].voltage_in_mv = 900;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_get_clock_levels_by_type_with_voltage(ctx,
+				DM_PP_CLOCK_TYPE_MEMORY_CLK, &info));
+	KUNIT_EXPECT_EQ(test, info.num_levels, 1U);
+	KUNIT_EXPECT_EQ(test, info.data[0].clocks_in_khz, 400000U);
+	KUNIT_EXPECT_EQ(test, info.data[0].voltage_in_mv, 900U);
+}
+
+/**
+ * dm_test_get_clock_levels_with_voltage_failure - Test voltage query error
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_get_clock_levels_by_type_with_voltage returns false on DPM error.
+ */
+static void dm_test_get_clock_levels_with_voltage_failure(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_levels_with_voltage info = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->ret_val = -EINVAL;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_get_clock_levels_by_type_with_voltage(ctx,
+				DM_PP_CLOCK_TYPE_MEMORY_CLK, &info));
+}
+
+/**
+ * dm_test_notify_wm_clock_changes_polaris - Test Polaris watermark path
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_notify_wm_clock_changes returns true for Polaris ASICs
+ * when the DPM set_watermarks call succeeds.
+ */
+static void dm_test_notify_wm_clock_changes_polaris(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_wm_sets_with_clock_ranges wm = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	adev->asic_type = CHIP_POLARIS10;
+	stub_dpm_ctx->set_watermarks_ret = 0;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_notify_wm_clock_changes(ctx, &wm));
+}
+
+/**
+ * dm_test_notify_wm_clock_changes_non_polaris - Test non-Polaris path
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_notify_wm_clock_changes returns false for non-Polaris ASICs.
+ */
+static void dm_test_notify_wm_clock_changes_non_polaris(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_wm_sets_with_clock_ranges wm = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	adev->asic_type = CHIP_NAVI10;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_notify_wm_clock_changes(ctx, &wm));
+}
+
+/**
+ * dm_test_apply_clock_for_voltage_success - Test successful voltage request
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_apply_clock_for_voltage_request returns true when the DPM
+ * callback succeeds for a valid clock type.
+ */
+static void dm_test_apply_clock_for_voltage_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_for_voltage_req req = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->display_clock_voltage_ret = 0;
+
+	req.clk_type = DM_PP_CLOCK_TYPE_ENGINE_CLK;
+	req.clocks_in_khz = 500000;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_apply_clock_for_voltage_request(ctx, &req));
+}
+
+/**
+ * dm_test_apply_clock_for_voltage_eopnotsupp - Test EOPNOTSUPP treated as success
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_apply_clock_for_voltage_request returns true when the DPM
+ * callback returns -EOPNOTSUPP (not supported is non-fatal).
+ */
+static void dm_test_apply_clock_for_voltage_eopnotsupp(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_for_voltage_req req = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->display_clock_voltage_ret = -EOPNOTSUPP;
+
+	req.clk_type = DM_PP_CLOCK_TYPE_ENGINE_CLK;
+	req.clocks_in_khz = 500000;
+
+	KUNIT_EXPECT_TRUE(test, dm_pp_apply_clock_for_voltage_request(ctx, &req));
+}
+
+/**
+ * dm_test_apply_clock_for_voltage_fail - Test DPM error returns false
+ * @test: KUnit test context
+ *
+ * Verify dm_pp_apply_clock_for_voltage_request returns false when the DPM
+ * callback fails with an error other than -EOPNOTSUPP.
+ */
+static void dm_test_apply_clock_for_voltage_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dm_pp_clock_for_voltage_req req = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	stub_dpm_ctx->display_clock_voltage_ret = -EIO;
+
+	req.clk_type = DM_PP_CLOCK_TYPE_ENGINE_CLK;
+	req.clocks_in_khz = 500000;
+
+	KUNIT_EXPECT_FALSE(test, dm_pp_apply_clock_for_voltage_request(ctx, &req));
+}
+
+/* ---- Tests for pp_nv_set_display_count ---- */
+
+/**
+ * dm_test_nv_set_display_count_ok - Test successful display count set
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_display_count returns PP_SMU_RESULT_OK on success.
+ */
+static void dm_test_nv_set_display_count_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_active_display_count_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_display_count(&pp_smu, 2),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_set_display_count_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_display_count returns PP_SMU_RESULT_UNSUPPORTED when
+ * the DPM callback returns -EOPNOTSUPP.
+ */
+static void dm_test_nv_set_display_count_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_active_display_count_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_display_count(&pp_smu, 2),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_set_display_count_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_display_count returns PP_SMU_RESULT_FAIL on a generic
+ * DPM error.
+ */
+static void dm_test_nv_set_display_count_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_active_display_count_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_display_count(&pp_smu, 2),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_set_voltage_by_freq ---- */
+
+/**
+ * dm_test_nv_set_voltage_by_freq_ok - Test successful voltage-by-freq
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_voltage_by_freq returns PP_SMU_RESULT_OK on success.
+ */
+static void dm_test_nv_set_voltage_by_freq_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_voltage_by_freq(&pp_smu, PP_SMU_NV_DISPCLK, 600),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_set_voltage_by_freq_invalid_id - Test invalid clock id
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_voltage_by_freq returns PP_SMU_RESULT_FAIL for an
+ * unrecognized clock id without calling DPM.
+ */
+static void dm_test_nv_set_voltage_by_freq_invalid_id(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_set_voltage_by_freq(&pp_smu, (enum pp_smu_nv_clock_id)0xff, 600),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_set_pstate_handshake_support ---- */
+
+/**
+ * dm_test_nv_pstate_handshake_ok - Test successful pstate handshake
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_pstate_handshake_support returns PP_SMU_RESULT_OK
+ * when the DPM callback succeeds.
+ */
+static void dm_test_nv_pstate_handshake_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_disable_memory_clock_switch_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_pstate_handshake_support(&pp_smu, true),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_pstate_handshake_fail - Test failed pstate handshake
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_pstate_handshake_support returns PP_SMU_RESULT_FAIL
+ * when the DPM callback returns non-zero.
+ */
+static void dm_test_nv_pstate_handshake_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_disable_memory_clock_switch_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_pstate_handshake_support(&pp_smu, true),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_rn_get_dpm_clock_table ---- */
+
+/**
+ * dm_test_rn_get_dpm_clock_table_ok - Test successful DPM clock table
+ * @test: KUnit test context
+ *
+ * Verify pp_rn_get_dpm_clock_table returns PP_SMU_RESULT_OK on success.
+ */
+static void dm_test_rn_get_dpm_clock_table_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct dpm_clocks clock_table = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_dpm_clock_table_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_rn_get_dpm_clock_table(&pp_smu, &clock_table),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_rn_get_dpm_clock_table_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_rn_get_dpm_clock_table returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_rn_get_dpm_clock_table_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct dpm_clocks clock_table = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_dpm_clock_table_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_rn_get_dpm_clock_table(&pp_smu, &clock_table),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_rn_get_dpm_clock_table_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_rn_get_dpm_clock_table returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_rn_get_dpm_clock_table_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct dpm_clocks clock_table = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_dpm_clock_table_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_rn_get_dpm_clock_table(&pp_smu, &clock_table),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_rv_set_wm_ranges ---- */
+
+/**
+ * dm_test_rv_set_wm_ranges - Test Raven watermark range forwarding
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_wm_ranges converts watermark ranges via
+ * build_wm_clock_ranges_soc15 and forwards them to DPM without crashing.
+ */
+static void dm_test_rv_set_wm_ranges(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct pp_smu_wm_range_sets ranges = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	ranges.num_reader_wm_sets = 1;
+	ranges.reader_wm_sets[0].wm_inst = 0;
+	ranges.reader_wm_sets[0].max_drain_clk_mhz = 600;
+	ranges.reader_wm_sets[0].min_drain_clk_mhz = 300;
+
+	pp_rv_set_wm_ranges(&pp_smu, &ranges);
+
+	/* Reaching here without crash confirms coverage */
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_rv_set_pme_wa_enable ---- */
+
+/**
+ * dm_test_rv_set_pme_wa_enable - Test Raven PME workaround enable
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_pme_wa_enable forwards the call to DPM without crashing.
+ */
+static void dm_test_rv_set_pme_wa_enable(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	pp_rv_set_pme_wa_enable(&pp_smu);
+
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_rv_set_active_display_count ---- */
+
+/**
+ * dm_test_rv_set_active_display_count - Test Raven display count forwarding
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_active_display_count forwards the count to DPM without
+ * crashing.
+ */
+static void dm_test_rv_set_active_display_count(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	pp_rv_set_active_display_count(&pp_smu, 2);
+
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_rv_set_min_deep_sleep_dcfclk ---- */
+
+/**
+ * dm_test_rv_set_min_deep_sleep_dcfclk - Test Raven deep sleep clock
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_min_deep_sleep_dcfclk forwards the clock value to DPM
+ * without crashing.
+ */
+static void dm_test_rv_set_min_deep_sleep_dcfclk(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	pp_rv_set_min_deep_sleep_dcfclk(&pp_smu, 300);
+
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_rv_set_hard_min_dcefclk_by_freq ---- */
+
+/**
+ * dm_test_rv_set_hard_min_dcefclk_by_freq - Test Raven hard min DCEFCLK
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_hard_min_dcefclk_by_freq forwards the frequency to DPM
+ * without crashing.
+ */
+static void dm_test_rv_set_hard_min_dcefclk_by_freq(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	pp_rv_set_hard_min_dcefclk_by_freq(&pp_smu, 600);
+
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_rv_set_hard_min_fclk_by_freq ---- */
+
+/**
+ * dm_test_rv_set_hard_min_fclk_by_freq - Test Raven hard min FCLK
+ * @test: KUnit test context
+ *
+ * Verify pp_rv_set_hard_min_fclk_by_freq forwards the frequency to DPM
+ * without crashing.
+ */
+static void dm_test_rv_set_hard_min_fclk_by_freq(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	pp_rv_set_hard_min_fclk_by_freq(&pp_smu, 800);
+
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for pp_nv_set_wm_ranges ---- */
+
+/**
+ * dm_test_nv_set_wm_ranges - Test Navi watermark range forwarding
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_wm_ranges forwards ranges to DPM and unconditionally
+ * returns PP_SMU_RESULT_OK.
+ */
+static void dm_test_nv_set_wm_ranges(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct pp_smu_wm_range_sets ranges = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+
+	ranges.num_reader_wm_sets = 1;
+	ranges.reader_wm_sets[0].wm_inst = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_wm_ranges(&pp_smu, &ranges),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/* ---- Tests for pp_nv_set_min_deep_sleep_dcfclk ---- */
+
+/**
+ * dm_test_nv_set_min_deep_sleep_dcfclk_ok - Test successful deep sleep set
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_min_deep_sleep_dcfclk returns PP_SMU_RESULT_OK on success.
+ */
+static void dm_test_nv_set_min_deep_sleep_dcfclk_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_min_deep_sleep_dcefclk_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_min_deep_sleep_dcfclk(&pp_smu, 300),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_set_min_deep_sleep_dcfclk_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_min_deep_sleep_dcfclk returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_nv_set_min_deep_sleep_dcfclk_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_min_deep_sleep_dcefclk_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_min_deep_sleep_dcfclk(&pp_smu, 300),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_set_min_deep_sleep_dcfclk_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_min_deep_sleep_dcfclk returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_nv_set_min_deep_sleep_dcfclk_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->set_min_deep_sleep_dcefclk_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_min_deep_sleep_dcfclk(&pp_smu, 300),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_set_hard_min_dcefclk_by_freq ---- */
+
+/**
+ * dm_test_nv_set_hard_min_dcefclk_ok - Test successful hard min DCEFCLK
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_dcefclk_by_freq returns PP_SMU_RESULT_OK.
+ */
+static void dm_test_nv_set_hard_min_dcefclk_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_dcefclk_by_freq(&pp_smu, 600),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_set_hard_min_dcefclk_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_dcefclk_by_freq returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_nv_set_hard_min_dcefclk_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_dcefclk_by_freq(&pp_smu, 600),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_set_hard_min_dcefclk_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_dcefclk_by_freq returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_nv_set_hard_min_dcefclk_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_dcefclk_by_freq(&pp_smu, 600),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_set_hard_min_uclk_by_freq ---- */
+
+/**
+ * dm_test_nv_set_hard_min_uclk_ok - Test successful hard min UCLK
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_uclk_by_freq returns PP_SMU_RESULT_OK.
+ */
+static void dm_test_nv_set_hard_min_uclk_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = 0;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_uclk_by_freq(&pp_smu, 800),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_set_hard_min_uclk_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_uclk_by_freq returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_nv_set_hard_min_uclk_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_uclk_by_freq(&pp_smu, 800),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_set_hard_min_uclk_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_set_hard_min_uclk_by_freq returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_nv_set_hard_min_uclk_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->display_clock_voltage_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test, (int)pp_nv_set_hard_min_uclk_by_freq(&pp_smu, 800),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_get_maximum_sustainable_clocks ---- */
+
+/**
+ * dm_test_nv_get_max_sustainable_clocks_ok - Test successful query
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_maximum_sustainable_clocks returns PP_SMU_RESULT_OK.
+ */
+static void dm_test_nv_get_max_sustainable_clocks_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct pp_smu_nv_clock_table max_clocks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_max_sustainable_ret = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_maximum_sustainable_clocks(&pp_smu, &max_clocks),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_get_max_sustainable_clocks_unsupported - Test EOPNOTSUPP
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_maximum_sustainable_clocks returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_nv_get_max_sustainable_clocks_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct pp_smu_nv_clock_table max_clocks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_max_sustainable_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_maximum_sustainable_clocks(&pp_smu, &max_clocks),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_get_max_sustainable_clocks_fail - Test generic error
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_maximum_sustainable_clocks returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_nv_get_max_sustainable_clocks_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	struct pp_smu_nv_clock_table max_clocks = {};
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_max_sustainable_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_maximum_sustainable_clocks(&pp_smu, &max_clocks),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
+/* ---- Tests for pp_nv_get_uclk_dpm_states ---- */
+
+/**
+ * dm_test_nv_get_uclk_dpm_states_ok - Test successful DPM states query
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_uclk_dpm_states returns PP_SMU_RESULT_OK.
+ */
+static void dm_test_nv_get_uclk_dpm_states_ok(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	unsigned int clock_values[4] = {};
+	unsigned int num_states = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_uclk_dpm_ret = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_uclk_dpm_states(&pp_smu, clock_values, &num_states),
+			(int)PP_SMU_RESULT_OK);
+}
+
+/**
+ * dm_test_nv_get_uclk_dpm_states_unsupported - Test EOPNOTSUPP mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_uclk_dpm_states returns PP_SMU_RESULT_UNSUPPORTED.
+ */
+static void dm_test_nv_get_uclk_dpm_states_unsupported(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	unsigned int clock_values[4] = {};
+	unsigned int num_states = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_uclk_dpm_ret = -EOPNOTSUPP;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_uclk_dpm_states(&pp_smu, clock_values, &num_states),
+			(int)PP_SMU_RESULT_UNSUPPORTED);
+}
+
+/**
+ * dm_test_nv_get_uclk_dpm_states_fail - Test generic error mapping
+ * @test: KUnit test context
+ *
+ * Verify pp_nv_get_uclk_dpm_states returns PP_SMU_RESULT_FAIL.
+ */
+static void dm_test_nv_get_uclk_dpm_states_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct pp_smu pp_smu = {};
+	unsigned int clock_values[4] = {};
+	unsigned int num_states = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	setup_stub_dpm(test, adev);
+	ctx->driver_context = adev;
+	pp_smu.dm = ctx;
+	stub_dpm_ctx->get_uclk_dpm_ret = -EIO;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)pp_nv_get_uclk_dpm_states(&pp_smu, clock_values, &num_states),
+			(int)PP_SMU_RESULT_FAIL);
+}
+
 static struct kunit_case dm_pp_smu_test_cases[] = {
 	/* get_default_clock_levels */
 	KUNIT_CASE(dm_test_default_clock_levels_display),
@@ -963,6 +2424,76 @@ static struct kunit_case dm_pp_smu_test_cases[] = {
 	KUNIT_CASE(dm_test_nv_clock_id_phyclk),
 	KUNIT_CASE(dm_test_nv_clock_id_pixelclk),
 	KUNIT_CASE(dm_test_nv_clock_id_invalid),
+	/* dm_pp_get_static_clocks (with stub DPM) */
+	KUNIT_CASE(dm_test_get_static_clocks_success),
+	KUNIT_CASE(dm_test_get_static_clocks_failure),
+	/* dm_pp_apply_display_requirements (DPM enabled) */
+	KUNIT_CASE(dm_test_apply_display_requirements_dpm_enabled),
+	/* dm_pp_get_clock_levels_by_type */
+	KUNIT_CASE(dm_test_get_clock_levels_by_type_dpm_error),
+	KUNIT_CASE(dm_test_get_clock_levels_by_type_success),
+	KUNIT_CASE(dm_test_get_clock_levels_by_type_validation_fallback),
+	/* dm_pp_get_clock_levels_by_type_with_latency */
+	KUNIT_CASE(dm_test_get_clock_levels_with_latency_success),
+	KUNIT_CASE(dm_test_get_clock_levels_with_latency_failure),
+	/* dm_pp_get_clock_levels_by_type_with_voltage */
+	KUNIT_CASE(dm_test_get_clock_levels_with_voltage_success),
+	KUNIT_CASE(dm_test_get_clock_levels_with_voltage_failure),
+	/* dm_pp_notify_wm_clock_changes */
+	KUNIT_CASE(dm_test_notify_wm_clock_changes_polaris),
+	KUNIT_CASE(dm_test_notify_wm_clock_changes_non_polaris),
+	/* dm_pp_apply_clock_for_voltage_request (with DPM) */
+	KUNIT_CASE(dm_test_apply_clock_for_voltage_success),
+	KUNIT_CASE(dm_test_apply_clock_for_voltage_eopnotsupp),
+	KUNIT_CASE(dm_test_apply_clock_for_voltage_fail),
+	/* pp_nv_set_display_count */
+	KUNIT_CASE(dm_test_nv_set_display_count_ok),
+	KUNIT_CASE(dm_test_nv_set_display_count_unsupported),
+	KUNIT_CASE(dm_test_nv_set_display_count_fail),
+	/* pp_nv_set_voltage_by_freq */
+	KUNIT_CASE(dm_test_nv_set_voltage_by_freq_ok),
+	KUNIT_CASE(dm_test_nv_set_voltage_by_freq_invalid_id),
+	/* pp_nv_set_pstate_handshake_support */
+	KUNIT_CASE(dm_test_nv_pstate_handshake_ok),
+	KUNIT_CASE(dm_test_nv_pstate_handshake_fail),
+	/* pp_rn_get_dpm_clock_table */
+	KUNIT_CASE(dm_test_rn_get_dpm_clock_table_ok),
+	KUNIT_CASE(dm_test_rn_get_dpm_clock_table_unsupported),
+	KUNIT_CASE(dm_test_rn_get_dpm_clock_table_fail),
+	/* pp_rv_set_wm_ranges */
+	KUNIT_CASE(dm_test_rv_set_wm_ranges),
+	/* pp_rv_set_pme_wa_enable */
+	KUNIT_CASE(dm_test_rv_set_pme_wa_enable),
+	/* pp_rv_set_active_display_count */
+	KUNIT_CASE(dm_test_rv_set_active_display_count),
+	/* pp_rv_set_min_deep_sleep_dcfclk */
+	KUNIT_CASE(dm_test_rv_set_min_deep_sleep_dcfclk),
+	/* pp_rv_set_hard_min_dcefclk_by_freq */
+	KUNIT_CASE(dm_test_rv_set_hard_min_dcefclk_by_freq),
+	/* pp_rv_set_hard_min_fclk_by_freq */
+	KUNIT_CASE(dm_test_rv_set_hard_min_fclk_by_freq),
+	/* pp_nv_set_wm_ranges */
+	KUNIT_CASE(dm_test_nv_set_wm_ranges),
+	/* pp_nv_set_min_deep_sleep_dcfclk */
+	KUNIT_CASE(dm_test_nv_set_min_deep_sleep_dcfclk_ok),
+	KUNIT_CASE(dm_test_nv_set_min_deep_sleep_dcfclk_unsupported),
+	KUNIT_CASE(dm_test_nv_set_min_deep_sleep_dcfclk_fail),
+	/* pp_nv_set_hard_min_dcefclk_by_freq */
+	KUNIT_CASE(dm_test_nv_set_hard_min_dcefclk_ok),
+	KUNIT_CASE(dm_test_nv_set_hard_min_dcefclk_unsupported),
+	KUNIT_CASE(dm_test_nv_set_hard_min_dcefclk_fail),
+	/* pp_nv_set_hard_min_uclk_by_freq */
+	KUNIT_CASE(dm_test_nv_set_hard_min_uclk_ok),
+	KUNIT_CASE(dm_test_nv_set_hard_min_uclk_unsupported),
+	KUNIT_CASE(dm_test_nv_set_hard_min_uclk_fail),
+	/* pp_nv_get_maximum_sustainable_clocks */
+	KUNIT_CASE(dm_test_nv_get_max_sustainable_clocks_ok),
+	KUNIT_CASE(dm_test_nv_get_max_sustainable_clocks_unsupported),
+	KUNIT_CASE(dm_test_nv_get_max_sustainable_clocks_fail),
+	/* pp_nv_get_uclk_dpm_states */
+	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_ok),
+	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_unsupported),
+	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_fail),
 	{}
 };
 
-- 
2.53.0

