Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927ACC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA1910EE8E;
	Wed, 20 Mar 2024 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRF4R7qR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBD810EE8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLdBLhbn7YTTXMHaoxbg75GtrLxOB4FhoYlkdtmA5DeUU6QTE38/LQiRQo7K1cS2QpdbhvyRx2uPQprRJ7NXyJt9KyFVJJGChKR84gvJx0VahIuiJTmhL0+x7AXrnD+GUwVO+HX0MOWLfJhjd919t3EWXkcjkM+Nag+tbojURaZ3WpcWKYfgqUOwhrLL/kvcbvMHN9cNmgJDePL2WeexmanbRzT++txdRRM5tpwOkUbxQe2c6k0f2/7YJCEZhgb/MnDeVi1LfeaQl+bAK5M0RUlKzkjSbyQ/Re0STXEqOkX/y444pU/MsJhrbks4NYBWkdKyTwP6O3vAZDLjclMz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnigoO/Lt0neUiFN+XnCO4AqWRlFXo+3H+iCuMddze8=;
 b=KdHPnd1N+eGU33YeKBWMQWuzmnU5kXwdkc9KtJujTd6IxqiCnYNCm2jaHOrgyAcQBbWRift/SgoRPEakr/qE5FAKoOMeeVkCs/BdF6YBFoe7sQ2UzFh0OexDAHvnZxtSSKOmBBBoVVuOVAvzeujYEK80AhbmD6w6b/GSYq6SRa62PehY94AysH8f2UfJnLQywWSraZliyyfhpDeZmO4NRBJX202d+Vi4E7xKFUy5paoM7rTS6ISXyGC8mCg78/ciWe33/zkOMjRe0vmh6nSLzRIyvcxtjATxHTqERTjEdhCg5Z8LuorIkng1pHeT2GAdxz8R6E/yWeEnau+jrX1hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnigoO/Lt0neUiFN+XnCO4AqWRlFXo+3H+iCuMddze8=;
 b=BRF4R7qRtQMh5i7LmBJPJIij3taxS4hOfgC4w7fFpESbJATFvX+M0pUVZBchetmrelIOj/VorA9rIQIc8ZFSCtm0SThYFlrz0ugDD1BiKxGfUOxI65wXFudOWV+w/sYGdbewQMHwUktJsa+iVXvlPTy40EPCZnbOChzDgvx0W0I=
Received: from MN2PR15CA0034.namprd15.prod.outlook.com (2603:10b6:208:1b4::47)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 06:37:03 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::a5) by MN2PR15CA0034.outlook.office365.com
 (2603:10b6:208:1b4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 14/22] drm/amd/display: Allow Z8 when stutter threshold is not
 met
Date: Wed, 20 Mar 2024 14:35:48 +0800
Message-ID: <20240320063556.1326615-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: fb770816-54e2-4552-b85d-08dc48a82792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2XwhOaDgVOmmjuWqwL1pIxb0DErCAeC35NNCx9AjW6BZfzRV5xBr+2oHfjmguJuZ9fJqzeoNwFdFpT6+0xEQcjpamUMwuAPa0QNSmBY76uGzjXEsME+boRJCooMPMmfTFdUFJT0TVBzYEPs2Ftbh/MFGOXo2p9gG6MeQO7l4fWcFKmRfOI7PIPVTSrLj37H5aIlfFZVlgYGjwsjgbLrNWx7qyguSbjPCYSMaJnlnBsLr7jVeW7S+G4wu4FXUFgmLGYrufFVHfo09f5j40BdgelClyf75WnHem2P4J1ywFXUBnvLJVehOiUHydT7wPf43EyMLzfWdpkgfTE6IvxDWyaA2PRDrjd+vQn1AGP30S2gKn/W6BOBRx1oOu1A5ougA95JpRUDYvw/7MDzRdMH8A+k0BzwxaJtulrHfCcEvSnIbh5Wa/je92pjA3BaUWTrsUwgSBhbb+2ZZoPQHw5OHjEuQTIsWZCMnPImw8qCvf5PmSNM0AQh7Cq2C51RWoohd2GZQoqjsxfF0nf82ih/gjpIjGdefOu+NrT6hig58nAuO99quZ6Io0xebHr6JRvphpctTPf8T3GadeVFcgZJxsAFY4lULeHxBbrDYChF8M9R7DuL/v8pBKi/1FpcuCR2QW4Ju4wMb9VxrdEQbho8bTpj7PLBbIy/BwWwdeUK890d7lCQS4qSZoPoQ9ce1jd/HOzw365lLQyVBaToYkrhTkrPl2Zy+NpqiO4q9B4CdBOlbwDBYr/grBaFqcYJZZ8r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:03.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb770816-54e2-4552-b85d-08dc48a82792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

[Why&How]
Some panels don't meet the stutter threshold (4k etc), this leads to
power regressions. Allow z8 for panels that don't meet the threshold
but support PSR/replay

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c |  9 +++++++--
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 10 +++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 38ab9ad60ef8..9c93a9f1eb0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1085,6 +1085,9 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
+		bool is_psr = (link && (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
+						link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) && !link->panel_config.psr.disable_psr);
+		bool is_replay = link && link->replay_settings.replay_feature_enabled;
 
 		/* Don't support multi-plane configurations */
 		if (stream_status->plane_count > 1)
@@ -1092,13 +1095,15 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 
 		if (is_pwrseq0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
-			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
+		else if (is_pwrseq0 && (is_psr || is_replay))
+			return DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY;
 		else
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
 	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
 	}
+
+	return DCN_ZSTATE_SUPPORT_DISALLOW;
 }
 
 static void dcn20_adjust_freesync_v_startup(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index deb6d162a2d5..59a902313200 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -485,6 +485,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 {
 	int i, pipe_idx, total_det = 0, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	uint32_t cstate_enter_plus_exit_z8_ns;
 
 	dc_assert_fp_enabled();
 
@@ -504,6 +505,13 @@ void dcn31_calculate_wm_and_dlg_fp(
 	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
 	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
 
+	cstate_enter_plus_exit_z8_ns =
+		get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	if (get_stutter_period(&context->bw_ctx.dml, pipes, pipe_cnt) < dc->debug.minimum_z8_residency_time &&
+			cstate_enter_plus_exit_z8_ns < dc->debug.minimum_z8_residency_time * 1000)
+		cstate_enter_plus_exit_z8_ns = dc->debug.minimum_z8_residency_time * 1000;
+
 	/* Set A:
 	 * All clocks min required
 	 *
@@ -514,7 +522,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns = get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns = cstate_enter_plus_exit_z8_ns;
 	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_z8_ns = get_wm_z8_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-- 
2.34.1

