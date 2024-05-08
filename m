Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FBFC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6039411312A;
	Wed,  8 May 2024 17:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mMStXfQh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A4F10FCF2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2AmPEraZ7Aci8kI4/EfSjgeTPJ+HfKgHccmafRICzg4HCH9n5qd0TfE9NILo6L7ls27AU3g0AGVrdBufI1xA7iUnmFLPr9hnIzwpIS9Qxuv0UYhWoQVoBTRiFMpzYIE+I8kcyZr8UqXvzndAN4nKMYLurFl4bz1xnuoSU7EYUSpV8F+Wy3rTeHw6tV0Pyxa8sHNYjqZCMwUW/WE1zBsFbu3IhJUfQQlmwNqmmMGKGj6RPNuK/rJsJLSdA67ygdZpG0VRbf46br/oKtRG5gu4Sm4igJGmPOH8p73V0gKR5qDpPOZ/ZbXsxx9kxnkl77f6YTpWahGXNUinRTDhH9zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMt55pK/It3iD8KyCNFpnfLLqe/LBO1DyXncduLsgWY=;
 b=FvFNWXDvZI1njOf/7BEcvJrb85GlsHux+KgjxQVAC+HljtFtrVs+DP5Ktid/EfAycIg6Ta8P0EQkj2BLNWFNa1fiPi4Dbd3Bv1oiqpgKJnEZ/+A6pu0R+u3eFZab9t/oIxls76t9kwiATkp0aI+WEanyMvuPnXLFwozwxSvZ9CYwaCzgP3Hmds47GYqkOJGK6DmC1vYwWnBWfqWB88STpgo3RmP2v2eelssIYri9hYIJLUy1+0kaoD3JtyOknAV27WuVHVnZ5fTVTA6Pk/XJCAfRG0EyDIC2tuD0t1VrCGpo150A73wiRpe6IsMfDKrzdkX8RoUxBguneKWPwP9jUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMt55pK/It3iD8KyCNFpnfLLqe/LBO1DyXncduLsgWY=;
 b=mMStXfQhyWN1Emb/nZ1mHeowABBrr099O2E84N51gqjO+cpJp7w4fxXRxFPpvzSm9qwdpJ+iUsk3NF4djiRJfRXig6w8PoYbu5JBAYw5HYQGQnGPaLPQAghlp0REId/39WGNq+qHq4T6wlJqfcX2cVrM6/Gkqqe1YDAex0znyfM=
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:18:50 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::37) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 17:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:18:49 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:18:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 17/20] drm/amd/display: Refactor dcn401_update_clocks
Date: Wed, 8 May 2024 11:13:17 -0600
Message-ID: <20240508171320.3292065-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: cad16b31-893d-405f-e004-08dc6f82ed6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyZdwgyDCsPxxTb3KAKT1OqMuUfaKxrGhMnU9nk4fi46ORTFwaee4ZFt81w5?=
 =?us-ascii?Q?74xmFhfdW5cCFTv9BJax6V+C8usV+iAhlm3ZBLepijj+r480By/lcS7SLKJH?=
 =?us-ascii?Q?NAbkjl7sD0GZm6xXuX6b3X5xiozpKfhyvfEIFbMaNUVN2bMVIVOpuwtGXkU3?=
 =?us-ascii?Q?CNsRye3eOJui9udTyHvbCrA0Rduvms/8oYKEDgDWNKPeP19Ws6q4MR4RQ1u9?=
 =?us-ascii?Q?0Hpk/E6aQDk7t8w/srEP3qgvHTR4mmtDKDChMr1+UTYn+Ra96Yz1LcnkO1Aw?=
 =?us-ascii?Q?vATN/lW1SpgW32Qhfk3jA24rCakoCsDNBXam1PWwj3nu8lBgXTYuLqWX9C4k?=
 =?us-ascii?Q?BgKk65dkGv6ukso3LSjuqgIR7cj3GLA+Qny8tjuEmscq4Xa7gVwhD1lneLSR?=
 =?us-ascii?Q?5I2L/myMVl2rMvay24pvrfdhfZuqEePr3XRzDcORrwq07FRHEKG6me3IXPbQ?=
 =?us-ascii?Q?PfmhYtTkLhypwd6llfG+6Ys+/uyusqZVhMLll/85H15EYiT0vhxkmCmj4RKE?=
 =?us-ascii?Q?bz+r34BHgSuIi96KRfGuCiANzbgI6+YuM+NUOB7CY+veN6eAL28Sdp0UD2f0?=
 =?us-ascii?Q?UW24Om6R4sXrz77Fws/+kP74GEpQzobI69k/W/QuOt1b75Nve0nIHh0QVa2K?=
 =?us-ascii?Q?MhM8XVyHyY9k5pS5pH8Yb4zGgKSb33XjfxV3jgMIPEjtV0fSZZmvaEYRVYov?=
 =?us-ascii?Q?xYFgH61+1T6pmD7+XdEh+7P6N7WF+Znv3Hie6YkA/fmH+IUVmmlYGPNvM7qv?=
 =?us-ascii?Q?KAD2wFER02JKD6F6NbpvP9fhDgoX/by5K3pxuDhlhr4AERTF/F1PnStsW8J5?=
 =?us-ascii?Q?iHt76zv+Kcxq/Q+MXLks1/I8J0PDpS5Oyz4+ChnFFy5GS2O601Cs7eOBTqAg?=
 =?us-ascii?Q?OUdWcgi/ycsc8GPHOP6g9E0r3akRRAxxcSRKkMOGXp6buKIeBKFhnQjUVpIl?=
 =?us-ascii?Q?LREC/hLoUKXtGKSrWWGywhRI09hjujwcRWjJ7WFNEvzkxefYVj+FI/MTLdp7?=
 =?us-ascii?Q?4us1BmaL/GKcrG5kXWMOhztWLapWIMAn/UESzCT9j0qliwsGujc6xz5yDAkO?=
 =?us-ascii?Q?dHUs6tgHfKWka8TXx/ozUEHnMrfat89s25qOM06ATksC3nhlHlBQsqarnKbM?=
 =?us-ascii?Q?dloZvzB1lCxu+e8OPUNvwxZtuc92j3PmskAXoIMjB4U5PyM3nNi04zZJtjrK?=
 =?us-ascii?Q?1JqKiPkJC/Pm8DfUhIXiVPMN1rrX3HzmyZhzSvnj1UcQ8OUACbucW0l98aYr?=
 =?us-ascii?Q?GAJ4Icx502vEzo+uoV3b0kt8F5sF7Y3nu7HFecP3xAhXmTySEV9/Ca3dxWfh?=
 =?us-ascii?Q?MSp9g7EoMhNCHrr1mA9+5T2BmvxBMxaSLUZ24t6mjNIKPa2ejYcpr9uiWXwd?=
 =?us-ascii?Q?bnitY50XACWy7wp0++wZgCGWp/M5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:18:49.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad16b31-893d-405f-e004-08dc6f82ed6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
Refactor complex code into manageable functions. This also cleans up
some updating logics.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |   8 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 523 +++++++++++++++++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  94 ++++
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |  80 ++-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  10 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |   3 +
 8 files changed, 718 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
index 0d2584437934..5653c7991c62 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
@@ -36,7 +36,13 @@
 #define DALSMC_MSG_SetFclkSwitchAllow             0x11
 #define DALSMC_MSG_SetCabForUclkPstate            0x12
 #define DALSMC_MSG_SetWorstCaseUclkLatency        0x13
-#define DALSMC_Message_Count                      0x14
+#define DALSMC_MSG_DcnExitReset                   0x14
+#define DALSMC_MSG_ReturnHardMinStatus            0x15
+#define DALSMC_MSG_SetAlwaysWaitDmcubResp         0x16
+#define DALSMC_MSG_IndicateDrrStatus              0x17  // PMFW 15811
+#define DALSMC_MSG_ActiveUclkFclk                 0x18
+#define DALSMC_MSG_IdleUclkFclk                   0x19
+#define DALSMC_Message_Count                      0x1A
 
 typedef enum {
   FCLK_SWITCH_DISALLOW,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index bd74ff47fb37..d2abc00a60c5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -67,6 +67,9 @@ static const struct clk_mgr_mask clk_mgr_mask_dcn401 = {
 	CLK_COMMON_MASK_SH_LIST_DCN401(_MASK)
 };
 
+#define TO_DCN401_CLK_MGR(clk_mgr)\
+	container_of(clk_mgr, struct dcn401_clk_mgr, base)
+
 static bool dcn401_is_ppclk_dpm_enabled(struct clk_mgr_internal *clk_mgr, PPCLK_e clk)
 {
 	bool ppclk_dpm_enabled = false;
@@ -112,6 +115,30 @@ static bool dcn401_is_ppclk_dpm_enabled(struct clk_mgr_internal *clk_mgr, PPCLK_
 	return ppclk_dpm_enabled;
 }
 
+static bool dcn401_is_ppclk_idle_dpm_enabled(struct clk_mgr_internal *clk_mgr, PPCLK_e clk)
+{
+	bool ppclk_idle_dpm_enabled = false;
+
+	switch (clk) {
+	case PPCLK_UCLK:
+	case PPCLK_FCLK:
+		if (ASICREV_IS_GC_12_0_0_A0(clk_mgr->base.ctx->asic_id.hw_internal_rev) &&
+				clk_mgr->smu_ver >= 0x681800) {
+			ppclk_idle_dpm_enabled = true;
+		} else if (ASICREV_IS_GC_12_0_1_A0(clk_mgr->base.ctx->asic_id.hw_internal_rev) &&
+				clk_mgr->smu_ver >= 0x661300) {
+			ppclk_idle_dpm_enabled = true;
+		}
+		break;
+	default:
+		ppclk_idle_dpm_enabled = false;
+	}
+
+	ppclk_idle_dpm_enabled &= clk_mgr->smu_present;
+
+	return ppclk_idle_dpm_enabled;
+}
+
 /* Query SMU for all clock states for a particular clock */
 static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, unsigned int *entry_0,
 		unsigned int *num_levels)
@@ -470,7 +497,7 @@ static void dcn401_update_clocks_update_dentist(
 
 }
 
-static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
+static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
 {
@@ -512,7 +539,7 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (clk_mgr->smu_present) {
 		if (enter_display_off == safe_to_lower)
-			dcn30_smu_set_num_of_displays(clk_mgr, display_count);
+			dcn401_smu_set_num_of_displays(clk_mgr, display_count);
 
 		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
 
@@ -542,7 +569,7 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 			clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 			if (dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DCFCLK))
-				dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
+				dcn401_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
 		}
 
 		if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
@@ -668,6 +695,496 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 }
 
+static void dcn401_build_update_clocks_sequence(
+		struct clk_mgr *clk_mgr_base,
+		struct dc_state *context,
+		bool safe_to_lower,
+		unsigned int *num_steps)
+{
+	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
+	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
+	struct dcn401_clk_mgr_block_sequence *block_sequence = clk_mgr401->block_sequence;
+	bool force_reset = false;
+	bool enter_display_off = false;
+	bool update_active_fclk = false;
+	bool update_active_uclk = false;
+	bool update_idle_fclk = false;
+	bool update_idle_uclk = false;
+	bool update_dispclk = false;
+	bool update_dppclk = false;
+	bool dppclk_lowered = false;
+	bool is_idle_dpm_enabled = dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
+			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK) &&
+			dcn401_is_ppclk_idle_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
+			dcn401_is_ppclk_idle_dpm_enabled(clk_mgr_internal, PPCLK_FCLK);
+	int total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+	int active_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz);
+	int active_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.fclk_khz);
+	int idle_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_dramclk_khz);
+	int idle_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_fclk_khz);
+
+	int display_count;
+	bool fclk_p_state_change_support, uclk_p_state_change_support;
+
+	*num_steps = 0;
+
+	/* CLK_MGR401_READ_CLOCKS_FROM_DENTIST */
+	if (clk_mgr_base->clks.dispclk_khz == 0 ||
+			(dc->debug.force_clock_mode & 0x1)) {
+		/* This is from resume or boot up, if forced_clock cfg option used,
+		 * we bypass program dispclk and DPPCLK, but need set them for S3.
+		 * Force_clock_mode 0x1:  force reset the clock even it is the same clock
+		 * as long as it is in Passive level.
+		 */
+		force_reset = true;
+
+		block_sequence[*num_steps].func = CLK_MGR401_READ_CLOCKS_FROM_DENTIST;
+		(*num_steps)++;
+	}
+
+	/* CLK_MGR401_UPDATE_NUM_DISPLAYS */
+	if (clk_mgr_internal->smu_present) {
+		display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
+
+		if (display_count == 0)
+			enter_display_off = true;
+
+		if (enter_display_off == safe_to_lower) {
+			block_sequence[*num_steps].params.update_num_displays_params.num_displays = display_count;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_NUM_DISPLAYS;
+			(*num_steps)++;
+		}
+	}
+
+	/* CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT */
+	clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
+	fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
+	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+		clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
+		update_active_fclk = true;
+		update_idle_fclk = true;
+
+		/* To enable FCLK P-state switching, send FCLK_PSTATE_SUPPORTED message to PMFW */
+		if (clk_mgr_base->clks.fclk_p_state_change_support) {
+			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
+			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
+				block_sequence[*num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_SUPPORTED;
+				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+				(*num_steps)++;
+			}
+		} else {
+			/* P-State is not supported so force max clocks */
+			idle_fclk_mhz =
+					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1].fclk_mhz;
+			active_fclk_mhz = idle_fclk_mhz;
+		}
+	}
+
+	/* UPDATE DCFCLK */
+	if (dc->debug.force_min_dcfclk_mhz > 0)
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
+				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+
+	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
+		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
+		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
+			block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_DCFCLK;
+			block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz);
+			block_sequence[*num_steps].params.update_hardmin_params.response = NULL;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+			(*num_steps)++;
+		}
+	}
+
+	/* CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK */
+	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
+		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
+		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
+			block_sequence[*num_steps].params.update_deep_sleep_dcfclk_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz);
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK;
+			(*num_steps)++;
+		}
+	}
+
+	/* SOCCLK */
+	if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
+		/* We don't actually care about socclk, don't notify SMU of hard min */
+		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
+
+	/* CLK_MGR401_UPDATE_CAB_FOR_UCLK */
+	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
+	clk_mgr_base->clks.prev_num_ways = clk_mgr_base->clks.num_ways;
+
+	if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
+			clk_mgr_base->clks.num_ways < new_clocks->num_ways) {
+		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
+		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
+			block_sequence[*num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
+			(*num_steps)++;
+		}
+	}
+
+	/* UCLK */
+	uclk_p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
+	if (should_update_pstate_support(safe_to_lower, uclk_p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+		clk_mgr_base->clks.p_state_change_support = uclk_p_state_change_support;
+		update_active_uclk = true;
+		update_idle_uclk = true;
+
+		/* to disable P-State switching, set UCLK min = max */
+		if (!clk_mgr_base->clks.p_state_change_support) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled) {
+				/* will never have the functional UCLK min above the softmax
+				 * since we calculate mode support based on softmax being the max UCLK
+				 * frequency.
+				 */
+				active_uclk_mhz = clk_mgr_base->bw_params->dc_mode_softmax_memclk;
+			} else {
+				active_uclk_mhz = clk_mgr_base->bw_params->max_memclk_mhz;
+			}
+			idle_uclk_mhz = active_uclk_mhz;
+		}
+	}
+
+	/* Always update saved value, even if new value not set due to P-State switching unsupported */
+	if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
+		clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
+
+		if (clk_mgr_base->clks.p_state_change_support) {
+			update_active_uclk = true;
+			active_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz);
+		}
+	}
+	if (should_set_clock(safe_to_lower, new_clocks->idle_dramclk_khz, clk_mgr_base->clks.idle_dramclk_khz)) {
+		clk_mgr_base->clks.idle_dramclk_khz = new_clocks->idle_dramclk_khz;
+
+		if (clk_mgr_base->clks.p_state_change_support) {
+			update_idle_uclk = true;
+			idle_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_dramclk_khz);
+		}
+	}
+
+	/* set UCLK to requested value */
+	if ((update_active_uclk || update_idle_uclk) &&
+			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
+			!is_idle_dpm_enabled) {
+		block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
+		block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
+		block_sequence[*num_steps].params.update_hardmin_params.response = NULL;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		(*num_steps)++;
+	}
+
+	/* FCLK */
+	/* Always update saved value, even if new value not set due to P-State switching unsupported */
+	if (should_set_clock(safe_to_lower, new_clocks->fclk_khz, clk_mgr_base->clks.fclk_khz)) {
+		clk_mgr_base->clks.fclk_khz = new_clocks->fclk_khz;
+
+		if (clk_mgr_base->clks.fclk_p_state_change_support) {
+			update_active_fclk = true;
+			active_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.fclk_khz);
+		}
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->idle_fclk_khz, clk_mgr_base->clks.idle_fclk_khz)) {
+		clk_mgr_base->clks.idle_fclk_khz = new_clocks->idle_fclk_khz;
+
+		if (clk_mgr_base->clks.fclk_p_state_change_support) {
+			update_idle_fclk = true;
+			idle_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_fclk_khz);
+		}
+	}
+
+	/* When idle DPM is enabled, need to send active and idle hardmins separately */
+	/* CLK_MGR401_UPDATE_ACTIVE_HARDMINS */
+	if ((update_active_uclk || update_active_fclk) && is_idle_dpm_enabled) {
+		block_sequence[*num_steps].params.update_idle_hardmin_params.uclk_mhz = active_uclk_mhz;
+		block_sequence[*num_steps].params.update_idle_hardmin_params.fclk_mhz = active_fclk_mhz;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_ACTIVE_HARDMINS;
+		(*num_steps)++;
+	}
+
+	/* CLK_MGR401_UPDATE_IDLE_HARDMINS */
+	if ((update_idle_uclk || update_idle_uclk) && is_idle_dpm_enabled) {
+		block_sequence[*num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
+		block_sequence[*num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
+		(*num_steps)++;
+	}
+
+	/* CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK, CLK_MGR401_INDICATE_DRR_STATUS*/
+	if (clk_mgr_base->clks.fw_based_mclk_switching != new_clocks->fw_based_mclk_switching) {
+		clk_mgr_base->clks.fw_based_mclk_switching = new_clocks->fw_based_mclk_switching;
+
+		block_sequence[*num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
+		(*num_steps)++;
+
+		block_sequence[*num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[*num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
+		(*num_steps)++;
+	}
+
+	/* set FCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
+	if ((update_active_fclk || update_idle_fclk)) {
+		/* disable FCLK P-State support if needed */
+		if (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support &&
+				dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
+			block_sequence[*num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_NOTSUPPORTED;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+			(*num_steps)++;
+		}
+
+		/* No need to send active FCLK hardmin, automatically set based on DCFCLK */
+		// block_sequence[*num_steps].update_hardmin_params.clk_mgr = clk_mgr;
+		// block_sequence[*num_steps].update_hardmin_params.ppclk = PPCLK_FCLK;
+		// block_sequence[*num_steps].update_hardmin_params.freq_mhz = active_fclk_mhz;
+		// block_sequence[*num_steps].update_hardmin_params.response = NULL;
+		// block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		// (*num_steps)++;
+	}
+
+	/* CLK_MGR401_UPDATE_CAB_FOR_UCLK */
+	if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
+			clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
+		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
+		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
+			block_sequence[*num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
+			(*num_steps)++;
+		}
+	}
+
+	/* DTBCLK */
+	if (!new_clocks->dtbclk_en && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK))
+		new_clocks->ref_dtbclk_khz = clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
+
+	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
+	if (!dc->debug.disable_dtb_ref_clk_switch &&
+			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000) && //TODO these should be ceiled
+			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK)) {
+		/* DCCG requires KHz precision for DTBCLK */
+		block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
+		block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
+		block_sequence[*num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		(*num_steps)++;
+
+		/* Update DTO in DCCG */
+		block_sequence[*num_steps].params.update_dtbclk_dto_params.context = context;
+		block_sequence[*num_steps].params.update_dtbclk_dto_params.ref_dtbclk_khz = clk_mgr_base->clks.ref_dtbclk_khz;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DTBCLK_DTO;
+		(*num_steps)++;
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
+		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
+			dppclk_lowered = true;
+
+		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
+		clk_mgr_base->clks.actual_dppclk_khz = new_clocks->dppclk_khz;
+
+		update_dppclk = true;
+	}
+
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
+
+		update_dispclk = true;
+	}
+
+	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
+		if (dppclk_lowered) {
+			/* if clock is being lowered, increase DTO before lowering refclk */
+			block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
+			block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.dppclk_khz;
+			block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+			(*num_steps)++;
+
+			block_sequence[*num_steps].params.update_dentist_params.context = context;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DENTIST;
+			(*num_steps)++;
+
+			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				(*num_steps)++;
+
+				block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
+				block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+				(*num_steps)++;
+			}
+		} else {
+			/* if clock is being raised, increase refclk before lowering DTO */
+			if (update_dppclk && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[*num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				(*num_steps)++;
+			}
+
+			if (update_dppclk || update_dispclk) {
+				block_sequence[*num_steps].params.update_dentist_params.context = context;
+				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DENTIST;
+				(*num_steps)++;
+			}
+
+			block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
+			block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.actual_dppclk_khz;
+			block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+			(*num_steps)++;
+		}
+	}
+
+	if (update_dispclk && dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
+		/*update dmcu for wait_loop count*/
+		block_sequence[*num_steps].params.update_psr_wait_loop_params.dmcu = dmcu;
+		block_sequence[*num_steps].params.update_psr_wait_loop_params.wait = clk_mgr_base->clks.dispclk_khz / 1000 / 7;
+		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_PSR_WAIT_LOOP;
+		(*num_steps)++;
+	}
+}
+
+static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
+		struct dc_state *context,
+		bool safe_to_lower)
+{
+	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+
+	unsigned int num_steps = 0;
+
+	unsigned int i;
+	union dcn401_clk_mgr_block_sequence_params *params;
+
+	if (dc->work_arounds.skip_clock_update)
+		return;
+
+	if (dc->debug.enable_legacy_clock_update) {
+		dcn401_update_clocks_legacy(clk_mgr_base, context, safe_to_lower);
+		return;
+	}
+
+	/* build clock update sequence */
+	dcn401_build_update_clocks_sequence(clk_mgr_base,
+			context,
+			safe_to_lower,
+			&num_steps);
+
+	/* execute sequence */
+	for (i = 0; i < num_steps; i++) {
+		params = &clk_mgr401->block_sequence[i].params;
+
+		switch (clk_mgr401->block_sequence[i].func) {
+		case CLK_MGR401_READ_CLOCKS_FROM_DENTIST:
+			dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
+			break;
+		case CLK_MGR401_UPDATE_NUM_DISPLAYS:
+			dcn401_smu_set_num_of_displays(clk_mgr_internal,
+					params->update_num_displays_params.num_displays);
+			break;
+		case CLK_MGR401_UPDATE_HARDMIN_PPCLK:
+			if (params->update_hardmin_params.response)
+				*params->update_hardmin_params.response = dcn401_smu_set_hard_min_by_freq(
+						clk_mgr_internal,
+						params->update_hardmin_params.ppclk,
+						params->update_hardmin_params.freq_mhz);
+			else
+				dcn401_smu_set_hard_min_by_freq(clk_mgr_internal,
+						params->update_hardmin_params.ppclk,
+						params->update_hardmin_params.freq_mhz);
+			break;
+		case CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED:
+			if (params->update_hardmin_optimized_params.response)
+				*params->update_hardmin_optimized_params.response = dcn401_set_hard_min_by_freq_optimized(
+						clk_mgr_internal,
+						params->update_hardmin_optimized_params.ppclk,
+						params->update_hardmin_optimized_params.freq_khz);
+			else
+				dcn401_set_hard_min_by_freq_optimized(clk_mgr_internal,
+						params->update_hardmin_optimized_params.ppclk,
+						params->update_hardmin_optimized_params.freq_khz);
+			break;
+		case CLK_MGR401_UPDATE_ACTIVE_HARDMINS:
+			dcn401_smu_set_active_uclk_fclk_hardmin(
+					clk_mgr_internal,
+					params->update_idle_hardmin_params.uclk_mhz,
+					params->update_idle_hardmin_params.fclk_mhz);
+			break;
+		case CLK_MGR401_UPDATE_IDLE_HARDMINS:
+			dcn401_smu_set_idle_uclk_fclk_hardmin(
+					clk_mgr_internal,
+					params->update_idle_hardmin_params.uclk_mhz,
+					params->update_idle_hardmin_params.fclk_mhz);
+			break;
+		case CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK:
+			dcn401_smu_set_min_deep_sleep_dcef_clk(
+					clk_mgr_internal,
+					params->update_deep_sleep_dcfclk_params.freq_mhz);
+			break;
+		case CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT:
+			dcn401_smu_send_fclk_pstate_message(
+					clk_mgr_internal,
+					params->update_fclk_pstate_support_params.support);
+			break;
+		case CLK_MGR401_UPDATE_CAB_FOR_UCLK:
+			dcn401_smu_send_cab_for_uclk_message(
+				clk_mgr_internal,
+				params->update_cab_for_uclk_params.num_ways);
+			break;
+		case CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK:
+			dcn401_smu_wait_for_dmub_ack_mclk(
+					clk_mgr_internal,
+					params->update_wait_for_dmub_ack_params.enable);
+			break;
+		case CLK_MGR401_INDICATE_DRR_STATUS:
+			dcn401_smu_indicate_drr_status(
+					clk_mgr_internal,
+					params->indicate_drr_status_params.mod_drr_for_pstate);
+			break;
+		case CLK_MGR401_UPDATE_DPPCLK_DTO:
+			dcn401_update_clocks_update_dpp_dto(
+					clk_mgr_internal,
+					params->update_dppclk_dto_params.context,
+					params->update_dppclk_dto_params.safe_to_lower,
+					params->update_dppclk_dto_params.dppclk_khz);
+			break;
+		case CLK_MGR401_UPDATE_DTBCLK_DTO:
+			dcn401_update_clocks_update_dtb_dto(
+					clk_mgr_internal,
+					params->update_dtbclk_dto_params.context,
+					params->update_dtbclk_dto_params.ref_dtbclk_khz);
+			break;
+		case CLK_MGR401_UPDATE_DENTIST:
+			dcn401_update_clocks_update_dentist(
+					clk_mgr_internal,
+					params->update_dentist_params.context);
+			break;
+		case CLK_MGR401_UPDATE_PSR_WAIT_LOOP:
+			params->update_psr_wait_loop_params.dmcu->funcs->set_psr_wait_loop(
+					params->update_psr_wait_loop_params.dmcu,
+					params->update_psr_wait_loop_params.wait);
+			break;
+		default:
+			/* this should never happen */
+			BREAK_TO_DEBUGGER();
+			break;
+		}
+	}
+}
+
 static uint32_t dcn401_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 {
 		struct fixed31_32 pll_req;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index dad203de0dd4..e2a3fbb6c3c3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -5,8 +5,102 @@
 #ifndef __DCN401_CLK_MGR_H_
 #define __DCN401_CLK_MGR_H_
 
+#define DCN401_CLK_MGR_MAX_SEQUENCE_SIZE 30
+
+union dcn401_clk_mgr_block_sequence_params {
+	struct {
+		/* inputs */
+		uint32_t num_displays;
+	} update_num_displays_params;
+	struct {
+		/* inputs */
+		uint32_t ppclk;
+		uint16_t freq_mhz;
+		/* outputs */
+		uint32_t *response;
+	} update_hardmin_params;
+	struct {
+		/* inputs */
+		uint32_t ppclk;
+		int freq_khz;
+		/* outputs */
+		uint32_t *response;
+	} update_hardmin_optimized_params;
+	struct {
+		/* inputs */
+		uint16_t uclk_mhz;
+		uint16_t fclk_mhz;
+	} update_idle_hardmin_params;
+	struct {
+		/* inputs */
+		uint16_t freq_mhz;
+	} update_deep_sleep_dcfclk_params;
+	struct {
+		/* inputs */
+		bool support;
+	} update_fclk_pstate_support_params;
+	struct {
+		/* inputs */
+		unsigned int num_ways;
+	} update_cab_for_uclk_params;
+	struct {
+		/* inputs */
+		bool enable;
+	} update_wait_for_dmub_ack_params;
+	struct {
+		/* inputs */
+		bool mod_drr_for_pstate;
+	} indicate_drr_status_params;
+	struct {
+		/* inputs */
+		struct dc_state *context;
+		int dppclk_khz;
+		bool safe_to_lower;
+	} update_dppclk_dto_params;
+	struct {
+		/* inputs */
+		struct dc_state *context;
+		int ref_dtbclk_khz;
+	} update_dtbclk_dto_params;
+	struct {
+		/* inputs */
+		struct dc_state *context;
+		int ref_dtbclk_khz;
+	} update_dentist_params;
+	struct {
+		/* inputs */
+		struct dmcu *dmcu;
+		unsigned int wait;
+	} update_psr_wait_loop_params;
+};
+
+enum dcn401_clk_mgr_block_sequence_func {
+	CLK_MGR401_READ_CLOCKS_FROM_DENTIST,
+	CLK_MGR401_UPDATE_NUM_DISPLAYS,
+	CLK_MGR401_UPDATE_HARDMIN_PPCLK,
+	CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED,
+	CLK_MGR401_UPDATE_ACTIVE_HARDMINS,
+	CLK_MGR401_UPDATE_IDLE_HARDMINS,
+	CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK,
+	CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT,
+	CLK_MGR401_UPDATE_CAB_FOR_UCLK,
+	CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK,
+	CLK_MGR401_INDICATE_DRR_STATUS,
+	CLK_MGR401_UPDATE_DPPCLK_DTO,
+	CLK_MGR401_UPDATE_DTBCLK_DTO,
+	CLK_MGR401_UPDATE_DENTIST,
+	CLK_MGR401_UPDATE_PSR_WAIT_LOOP,
+};
+
+struct dcn401_clk_mgr_block_sequence {
+	union dcn401_clk_mgr_block_sequence_params params;
+	enum dcn401_clk_mgr_block_sequence_func func;
+};
+
 struct dcn401_clk_mgr {
 	struct clk_mgr_internal base;
+
+	struct dcn401_clk_mgr_block_sequence block_sequence[DCN401_CLK_MGR_MAX_SEQUENCE_SIZE];
 };
 
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 054e8bd686f1..a3d0a48ed7ce 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -105,6 +105,7 @@ void dcn401_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
 unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
 	uint32_t response = 0;
+	bool hard_min_done = false;
 
 	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
 	uint32_t param = (clk << 16) | freq_mhz;
@@ -114,7 +115,84 @@ unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, u
 	dcn401_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetHardMinByFreq, param, &response);
 
-	smu_print("SMU Frequency set = %d KHz\n", response);
+	/* wait until hardmin acknowledged */
+	//hard_min_done = dcn401_smu_wait_get_hard_min_status(clk_mgr, clk);
+	smu_print("SMU Frequency set = %d KHz hard_min_done %d\n", response, hard_min_done);
 
 	return response;
 }
+
+void dcn401_smu_wait_for_dmub_ack_mclk(struct clk_mgr_internal *clk_mgr, bool enable)
+{
+	smu_print("SMU to wait for DMCUB ack for MCLK : %d\n", enable);
+
+	dcn401_smu_send_msg_with_param(clk_mgr, DALSMC_MSG_SetAlwaysWaitDmcubResp, enable ? 1 : 0, NULL);
+}
+
+void dcn401_smu_indicate_drr_status(struct clk_mgr_internal *clk_mgr, bool mod_drr_for_pstate)
+{
+	smu_print("SMU Set indicate drr status = %d\n", mod_drr_for_pstate);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_IndicateDrrStatus, mod_drr_for_pstate ? 1 : 0, NULL);
+}
+
+bool dcn401_smu_set_idle_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
+		uint16_t uclk_freq_mhz,
+		uint16_t fclk_freq_mhz)
+{
+	uint32_t response = 0;
+	bool success;
+
+	/* 15:0 for uclk, 32:16 for fclk */
+	uint32_t param = (fclk_freq_mhz << 16) | uclk_freq_mhz;
+
+	smu_print("SMU Set idle hardmin by freq: uclk_freq_mhz = %d MHz, fclk_freq_mhz = %d MHz\n", uclk_freq_mhz, fclk_freq_mhz);
+
+	success = dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_IdleUclkFclk, param, &response);
+
+	/* wait until hardmin acknowledged */
+	//success &= dcn401_smu_wait_get_hard_min_status(clk_mgr, PPCLK_UCLK);
+	smu_print("SMU hard_min_done %d\n", success);
+
+	return success;
+}
+
+bool dcn401_smu_set_active_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
+		uint16_t uclk_freq_mhz,
+		uint16_t fclk_freq_mhz)
+{
+	uint32_t response = 0;
+	bool success;
+
+	/* 15:0 for uclk, 32:16 for fclk */
+	uint32_t param = (fclk_freq_mhz << 16) | uclk_freq_mhz;
+
+	smu_print("SMU Set active hardmin by freq: uclk_freq_mhz = %d MHz, fclk_freq_mhz = %d MHz\n", uclk_freq_mhz, fclk_freq_mhz);
+
+	success = dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_ActiveUclkFclk, param, &response);
+
+	/* wait until hardmin acknowledged */
+	//success &= dcn401_smu_wait_get_hard_min_status(clk_mgr, PPCLK_UCLK);
+	smu_print("SMU hard_min_done %d\n", success);
+
+	return success;
+}
+
+void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz)
+{
+	smu_print("SMU Set min deep sleep dcef clk: freq_mhz = %d MHz\n", freq_mhz);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SetMinDeepSleepDcfclk, freq_mhz, NULL);
+}
+
+void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays)
+{
+	smu_print("SMU Set num of displays: num_displays = %d\n", num_displays);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_NumOfDisplays, num_displays, NULL);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index 8918bc52c2af..892881d11ce8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -17,5 +17,15 @@ void dcn401_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsi
 void dcn401_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn401_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
+void dcn401_smu_wait_for_dmub_ack_mclk(struct clk_mgr_internal *clk_mgr, bool enable);
+void dcn401_smu_indicate_drr_status(struct clk_mgr_internal *clk_mgr, bool mod_drr_for_pstate);
+bool dcn401_smu_set_idle_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
+		uint16_t uclk_freq_mhz,
+		uint16_t fclk_freq_mhz);
+bool dcn401_smu_set_active_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
+		uint16_t uclk_freq_mhz,
+		uint16_t fclk_freq_mhz);
+void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
+void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
 
 #endif /* __DCN401_CLK_MGR_SMU_MSG_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fd624b1fee25..8a5cc8b80217 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -204,7 +204,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 			dc_version = DCN_VERSION_3_51;
 		break;
 	case AMDGPU_FAMILY_GC_12_0_0:
-		if (ASICREV_IS_DCN401(asic_id.hw_internal_rev))
+		if (ASICREV_IS_GC_12_0_1_A0(asic_id.hw_internal_rev) ||
+			ASICREV_IS_GC_12_0_0_A0(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_4_01;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index eef2f357fe14..d550b6f97039 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -610,6 +610,8 @@ struct dc_clocks {
 	int max_supported_dispclk_khz;
 	int bw_dppclk_khz; /*a copy of dppclk_khz*/
 	int bw_dispclk_khz;
+	int idle_dramclk_khz;
+	int idle_fclk_khz;
 };
 
 struct dc_bw_validation_profile {
@@ -1035,6 +1037,7 @@ struct dc_debug_options {
 	uint32_t dml21_force_pstate_method_value;
 	uint32_t dml21_disable_pstate_method_mask;
 	union dmub_fams2_global_feature_config fams2_config;
+	bool enable_legacy_clock_update;
 	unsigned int force_cositing;
 };
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 25333337461e..090230d29df8 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -266,6 +266,9 @@ enum {
 	GC_12_UNKNOWN = 0xFF,
 };
 
+#define ASICREV_IS_GC_12_0_1_A0(eChipRev)        (eChipRev >= GC_12_0_1_A0 && eChipRev < GC_12_0_0_A0)
+#define ASICREV_IS_GC_12_0_0_A0(eChipRev)        (eChipRev >= GC_12_0_0_A0 && eChipRev < 0xFF)
+
 #define ASICREV_IS_DCN4(eChipRev)	(eChipRev >= GC_12_0_1_A0 && eChipRev < GC_12_0_0_A0)
 #define ASICREV_IS_DCN401(eChipRev)	(eChipRev >= GC_12_0_0_A0 && eChipRev < GC_12_UNKNOWN)
 
-- 
2.34.1

