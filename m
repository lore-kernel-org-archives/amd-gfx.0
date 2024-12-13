Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41157E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E441610F074;
	Fri, 13 Dec 2024 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A4AA1ZXg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB2810F073
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6o3AMMPlprudXMWVXk+E1hzTx0clWaiSzEINVya/yvcnHjJG4Wv8WFny/6RHyAwOVmka6hUhj8qJfXXk4bzi02cLSsSM+52vfvMCH/O8lDCRvzX2VrhEtbFayV78pKvNlvcI5OTWp5CRgx+EE9M/ZiiYCcLtU+NrqH/i9FLXxcxcek2lVfocKxnkjfGL3BoeXnEPrfLMmZdWsGzczDfz6EuwCABcURDfOZro+k5UJNx8ZJmCt6rJRGpzRqGOUhXLKklvaEcJhN7IixhIVPGh4UPBAU67OyHrYK5IWZTXBly9m8y3ZJvgjgiR6B+ry2FFwkDFFljFaiO7qQMDXWe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vooUAapoceIc+w5ZlUBgI58gPgZesSFC2u83R31Zpbc=;
 b=Uc2SAVIxS4j4WT6YwxLvscuf+iOxwc10x/n94CTW48iSrSdPHVLMbXl2EfK7s1PgLikKKFP5ESJ6/wangOQj9R4lm25KmuT+KfVeiyORSZoJOdV1T1grMHKLW3XfiIdHzJS39zQQriCKzaHFKgHxZE1/PmY51mUojiygVKMzRE/V1Tiud3udNUDXZffAJ2bs7VpC8Gq297llPQ3RqrKV6DJlrBcmbcMPSmE/mbQ/Cm+j3PLy0QeqFhZ4jQZqQE/+jDTbaAywuTfmGsQcNfvwXuT+wzGl87elGlcumYc2Q5wAt8Y82EGSzEjwRvzaHqho5mDtNHWoXC1NP5gr9qK0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vooUAapoceIc+w5ZlUBgI58gPgZesSFC2u83R31Zpbc=;
 b=A4AA1ZXgBWMYRz7wLb3o5bjKQlMkKknswwCNX+CxG9Y4MsJc86zyLi+rPMDCW5VkJQUEeK1UTyhXyGAFUzfYlCg0kJ3JDUWt2JHl3Bji/ejgZNMOxd/9BneJMtj4x5Gspspqf2LB9jbpBvrFSnEFYqBXpCaH1pi/TBuVJiVJ9RY=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:54:57 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::5d) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 08/17] drm/amd/display: Add new message for DF throttling
 optimization on dcn401
Date: Fri, 13 Dec 2024 08:52:40 -0700
Message-ID: <20241213155405.393252-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: be5db8e9-0c96-4d66-317d-08dd1b8e7e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RN8LxDzyPWr0FfmYaG2w8Ct/LMT4b+nOyzso1ZVnMgT4GNTf12UE9JsX/9Ce?=
 =?us-ascii?Q?pF8FZ1KRa1n1w0DIWGRNieu2rPbHQN2YzRtkgSmWlygQ2KcXr/HkfswgC77A?=
 =?us-ascii?Q?HmI1oqj6xEmLPIQMbzvx/UQ5sx47grD31mX9pKlEWCiXYC1mOYbiMG/4g4tk?=
 =?us-ascii?Q?uOsH4PCyImUxcFlofKD05Ty96/Rou86NnOV7ehH+RmA2lM0nvJOfPIyz6tPb?=
 =?us-ascii?Q?11wsVCf77ph/qfyCYiROIL2fjZXS6pAKpU5jxvdWb47c6kOwjtECXu22jUeM?=
 =?us-ascii?Q?itKH2MRXnWh4ZSrp+IN6bRtzUNr6rLWy5t+k59VZl/zVhTpulWgwgt01eCZX?=
 =?us-ascii?Q?AMLt+Xmm0i9jVvkrF7yy0ciKIEknxJDQ0ahC3dutKp/l2qcPv3KtnlDBHGZP?=
 =?us-ascii?Q?ul0ogjMmceCfhxwlRqV3ojlFmnFLDdM7h3zzFmzla/TR86DzHHAf5VVvzKcn?=
 =?us-ascii?Q?70erewKt1WBp/3hf19sBuNPTnyMfLkEa939IBdvIgNbOaKbq83wb2XOPSFj/?=
 =?us-ascii?Q?YM885jp7uJLSlX3DpwAUACew5GA5SfnP8B8r1Mq+39AC5IXMuNd0CXrObJy5?=
 =?us-ascii?Q?ECFsdfOalLC0R316cyF2OINhbfkVN0odsNJGZjkkN7pf3LKTI6EvVwwv83LG?=
 =?us-ascii?Q?2T2ajLQYb6NQgYrQDgQddq3tqnwzcIgMhtJD2qxjAQDue3Z5zPoS1atHzpoT?=
 =?us-ascii?Q?oviwOu7+hk713BdIw75RoCKuuHQw5QkglOhFq+hrJSbSZTrB1Wwbg9lF+rYq?=
 =?us-ascii?Q?xTv5oMB1BS/j2atSEXTUKU8wDDnuwLovpFD7sGzodFHHI3RGqRkaSVKEciwX?=
 =?us-ascii?Q?VgU5QkcigAZDmjTnvBz6iAObbDfC5lJGwYiAH5uw3SPZ7oUd4YTmd/zKnM4d?=
 =?us-ascii?Q?g8Ka3HyMPLEKarTYfuaHr57ZfumJ3wBLMz3EHSq5JI6Y0HH1VgHBA3n2a+6f?=
 =?us-ascii?Q?XfcwRGkukB5ALVk/OiCZJMzY6Hc0SPod0WMN8npka5RXEVdOSakHPaeponDZ?=
 =?us-ascii?Q?FdcEbuupiAdwFbDwxXD/E1wCqWl/FB3fb2v10SnHoQ82mc1TpgBqcKfgrMlG?=
 =?us-ascii?Q?QXXByYZYd4s8TsfijOM+tm3HNAkEVqgeApeRFaKveUCHgZBVDkQl51X9PmU6?=
 =?us-ascii?Q?MITl+y3Wt/Fjgp1t0o8nBn7s5twMFbrgOwsUmlJc0jlijNuf9cjxejLbqxyN?=
 =?us-ascii?Q?SjTUWMcgx5meWKwBYNjbXlj4e0D/JtE2Yz4m1Y4EKF9tgEyPmvXwNZ3NPkwH?=
 =?us-ascii?Q?WUXnS+TWWi7fM7KyP+qYyYodCARf6HyxxyE8pZrCsZDBq+fjku+vgmFMf+aa?=
 =?us-ascii?Q?8lMxiCNXuU7MYlFlpgxb06reRccczNYH/ZtPJqn4qzDGMCLEk3QuUJT8VzAY?=
 =?us-ascii?Q?x9PzMp+aoqpD+1ExvaqVSDQ9cvPkb1XCBnVKyImiYDSUMzYiN4DGmPL5iiBC?=
 =?us-ascii?Q?Hfcxbcra4sJeGzLCCsruD1Wauoa1JaH+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:57.5186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5db8e9-0c96-4d66-317d-08dd1b8e7e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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

[WHY]
When effective bandwidth from the SoC is enough to perform SubVP
prefetchs, then DF throttling is not required.

[HOW]
Provide SMU the required clocks for which DF throttling is not required.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 46 +++++++++++++++++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  1 +
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 23 ++++++++++
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 ++
 .../dc/dml2/dml21/dml21_translation_helper.c  |  2 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  5 ++
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c | 43 +++++++++++++++++
 8 files changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 8cfc5f435937..5b4e1e8a9ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -141,6 +141,20 @@ static bool dcn401_is_ppclk_idle_dpm_enabled(struct clk_mgr_internal *clk_mgr, P
 	return ppclk_idle_dpm_enabled;
 }
 
+static bool dcn401_is_df_throttle_opt_enabled(struct clk_mgr_internal *clk_mgr)
+{
+	bool is_df_throttle_opt_enabled = false;
+
+	if (ASICREV_IS_GC_12_0_1_A0(clk_mgr->base.ctx->asic_id.hw_internal_rev) &&
+			clk_mgr->smu_ver >= 0x663500) {
+		is_df_throttle_opt_enabled = !clk_mgr->base.ctx->dc->debug.force_subvp_df_throttle;
+	}
+
+	is_df_throttle_opt_enabled &= clk_mgr->smu_present;
+
+	return is_df_throttle_opt_enabled;
+}
+
 /* Query SMU for all clock states for a particular clock */
 static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, unsigned int *entry_0,
 		unsigned int *num_levels)
@@ -869,6 +883,12 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 					params->update_idle_hardmin_params.uclk_mhz,
 					params->update_idle_hardmin_params.fclk_mhz);
 			break;
+		case CLK_MGR401_UPDATE_SUBVP_HARDMINS:
+			dcn401_smu_set_subvp_uclk_fclk_hardmin(
+					clk_mgr_internal,
+					params->update_idle_hardmin_params.uclk_mhz,
+					params->update_idle_hardmin_params.fclk_mhz);
+			break;
 		case CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK:
 			dcn401_smu_set_min_deep_sleep_dcef_clk(
 					clk_mgr_internal,
@@ -945,15 +965,21 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	bool update_active_uclk = false;
 	bool update_idle_fclk = false;
 	bool update_idle_uclk = false;
+	bool update_subvp_prefetch_dramclk = false;
+	bool update_subvp_prefetch_fclk = false;
 	bool is_idle_dpm_enabled = dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
 			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK) &&
 			dcn401_is_ppclk_idle_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
 			dcn401_is_ppclk_idle_dpm_enabled(clk_mgr_internal, PPCLK_FCLK);
+	bool is_df_throttle_opt_enabled = is_idle_dpm_enabled &&
+		dcn401_is_df_throttle_opt_enabled(clk_mgr_internal);
 	int total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
 	int active_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz);
 	int active_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.fclk_khz);
 	int idle_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_dramclk_khz);
 	int idle_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_fclk_khz);
+	int subvp_prefetch_dramclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.subvp_prefetch_dramclk_khz);
+	int subvp_prefetch_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.subvp_prefetch_fclk_khz);
 
 	unsigned int num_steps = 0;
 
@@ -1109,6 +1135,12 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		}
 	}
 
+	if (should_set_clock(safe_to_lower, new_clocks->subvp_prefetch_dramclk_khz, clk_mgr_base->clks.subvp_prefetch_dramclk_khz)) {
+		clk_mgr_base->clks.subvp_prefetch_dramclk_khz = new_clocks->subvp_prefetch_dramclk_khz;
+		update_subvp_prefetch_dramclk = true;
+		subvp_prefetch_dramclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.subvp_prefetch_dramclk_khz);
+	}
+
 	/* FCLK */
 	/* Always update saved value, even if new value not set due to P-State switching unsupported */
 	if (should_set_clock(safe_to_lower, new_clocks->fclk_khz, clk_mgr_base->clks.fclk_khz)) {
@@ -1129,6 +1161,12 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		}
 	}
 
+	if (should_set_clock(safe_to_lower, new_clocks->subvp_prefetch_fclk_khz, clk_mgr_base->clks.subvp_prefetch_fclk_khz)) {
+		clk_mgr_base->clks.subvp_prefetch_fclk_khz = new_clocks->subvp_prefetch_fclk_khz;
+		update_subvp_prefetch_fclk = true;
+		subvp_prefetch_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.subvp_prefetch_fclk_khz);
+	}
+
 	/* When idle DPM is enabled, need to send active and idle hardmins separately */
 	/* CLK_MGR401_UPDATE_ACTIVE_HARDMINS */
 	if ((update_active_uclk || update_active_fclk) && is_idle_dpm_enabled) {
@@ -1146,6 +1184,14 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		num_steps++;
 	}
 
+	/* CLK_MGR401_UPDATE_SUBVP_HARDMINS */
+	if ((update_subvp_prefetch_dramclk || update_subvp_prefetch_fclk) && is_df_throttle_opt_enabled) {
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = subvp_prefetch_dramclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = subvp_prefetch_fclk_mhz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_SUBVP_HARDMINS;
+		num_steps++;
+	}
+
 	/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 	if (update_active_uclk || update_idle_uclk) {
 		if (!is_idle_dpm_enabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 8b0461992b22..6c9ae5ca2c7e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -90,6 +90,7 @@ enum dcn401_clk_mgr_block_sequence_func {
 	CLK_MGR401_UPDATE_DTBCLK_DTO,
 	CLK_MGR401_UPDATE_DENTIST,
 	CLK_MGR401_UPDATE_PSR_WAIT_LOOP,
+	CLK_MGR401_UPDATE_SUBVP_HARDMINS,
 };
 
 struct dcn401_clk_mgr_block_sequence {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 7700477d019b..b02a41179b41 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -21,6 +21,11 @@
 
 #define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
 
+/* temporary define */
+#ifndef DALSMC_MSG_SubvpUclkFclk
+#define DALSMC_MSG_SubvpUclkFclk 0x1B
+#endif
+
 /*
  * Function to be used instead of REG_WAIT macro because the wait ends when
  * the register is NOT EQUAL to zero, and because the translation in msg_if.h
@@ -296,6 +301,24 @@ bool dcn401_smu_set_active_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 	return success;
 }
 
+bool dcn401_smu_set_subvp_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
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
+			DALSMC_MSG_SubvpUclkFclk, param, &response);
+
+	return success;
+}
+
 void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz)
 {
 	smu_print("SMU Set min deep sleep dcef clk: freq_mhz = %d MHz\n", freq_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index 651fb8d62864..42cf7885a7cb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -23,6 +23,9 @@ bool dcn401_smu_set_idle_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 bool dcn401_smu_set_active_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 		uint16_t uclk_freq_mhz,
 		uint16_t fclk_freq_mhz);
+bool dcn401_smu_set_subvp_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
+		uint16_t uclk_freq_mhz,
+		uint16_t fclk_freq_mhz);
 void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
 void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 961b8245523c..aef70bcde355 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -629,6 +629,8 @@ struct dc_clocks {
 	int bw_dispclk_khz;
 	int idle_dramclk_khz;
 	int idle_fclk_khz;
+	int subvp_prefetch_dramclk_khz;
+	int subvp_prefetch_fclk_khz;
 };
 
 struct dc_bw_validation_profile {
@@ -1072,6 +1074,7 @@ struct dc_debug_options {
 	bool skip_full_updated_if_possible;
 	unsigned int enable_oled_edp_power_up_opt;
 	bool enable_hblank_borrow;
+	bool force_subvp_df_throttle;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 730bf35e6043..efb099905496 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1077,6 +1077,8 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dtbrefclk_khz > 0;
 	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dtbrefclk_khz;
 	context->bw_ctx.bw.dcn.clk.socclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.socclk_khz;
+	context->bw_ctx.bw.dcn.clk.subvp_prefetch_dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz;
+	context->bw_ctx.bw.dcn.clk.subvp_prefetch_fclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz;
 }
 
 void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct dcn_watermarks *watermark, enum dml2_dchub_watermark_reg_set_index reg_set_idx, struct dml2_context *in_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index b2ae6232673b..d2d053f2354d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -387,6 +387,11 @@ struct dml2_display_cfg_programming {
 				unsigned long fclk_khz;
 				unsigned long dcfclk_khz;
 			} svp_prefetch;
+			struct {
+				unsigned long uclk_khz;
+				unsigned long fclk_khz;
+				unsigned long dcfclk_khz;
+			} svp_prefetch_no_throttle;
 
 			unsigned long deepsleep_dcfclk_khz;
 			unsigned long dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 009026950b6c..8a78b9adfc62 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -96,6 +96,7 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	double min_uclk_latency;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
+	/* assumes DF throttling is enabled */
 	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
 	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100);
 
@@ -125,6 +126,37 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	in_out->programming->min_clocks.dcn4x.svp_prefetch.uclk_khz = dml_round_up(min_uclk_bw > min_uclk_latency ? min_uclk_bw : min_uclk_latency);
 	in_out->programming->min_clocks.dcn4x.svp_prefetch.fclk_khz = dml_round_up(min_fclk_bw > min_fclk_latency ? min_fclk_bw : min_fclk_latency);
 	in_out->programming->min_clocks.dcn4x.svp_prefetch.dcfclk_khz = dml_round_up(min_dcfclk_bw > min_dcfclk_latency ? min_dcfclk_bw : min_dcfclk_latency);
+
+	/* assumes DF throttling is disabled */
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
+	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100);
+
+	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
+	min_uclk_urgent = (double)min_uclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100);
+
+	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
+
+	min_fclk_avg = (double)mode_support_result->global.svp_prefetch.average_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
+	min_fclk_avg = (double)min_fclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100);
+
+	min_fclk_urgent = (double)mode_support_result->global.svp_prefetch.urgent_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
+	min_fclk_urgent = (double)min_fclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.fclk_derate_percent / 100);
+
+	min_fclk_bw = min_fclk_urgent > min_fclk_avg ? min_fclk_urgent : min_fclk_avg;
+
+	min_dcfclk_avg = (double)mode_support_result->global.svp_prefetch.average_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
+	min_dcfclk_avg = (double)min_dcfclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100);
+
+	min_dcfclk_urgent = (double)mode_support_result->global.svp_prefetch.urgent_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
+	min_dcfclk_urgent = (double)min_dcfclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dcfclk_derate_percent / 100);
+
+	min_dcfclk_bw = min_dcfclk_urgent > min_dcfclk_avg ? min_dcfclk_urgent : min_dcfclk_avg;
+
+	get_minimum_clocks_for_latency(in_out, &min_uclk_latency, &min_fclk_latency, &min_dcfclk_latency);
+
+	in_out->programming->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz = dml_round_up(min_uclk_bw > min_uclk_latency ? min_uclk_bw : min_uclk_latency);
+	in_out->programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz = dml_round_up(min_fclk_bw > min_fclk_latency ? min_fclk_bw : min_fclk_latency);
+	in_out->programming->min_clocks.dcn4x.svp_prefetch_no_throttle.dcfclk_khz = dml_round_up(min_dcfclk_bw > min_dcfclk_latency ? min_dcfclk_bw : min_dcfclk_latency);
 }
 
 static void calculate_idle_minimums(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out)
@@ -272,6 +304,17 @@ static bool map_soc_min_clocks_to_dpm_fine_grained(struct dml2_display_cfg_progr
 	if (result)
 		result = round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.idle.uclk_khz, &state_table->uclk);
 
+	/* these clocks are optional, so they can fail to map, in which case map all to 0 */
+	if (result) {
+		if (!round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.dcfclk_khz, &state_table->dcfclk) ||
+				!round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz, &state_table->fclk) ||
+				!round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz, &state_table->uclk)) {
+			display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.dcfclk_khz = 0;
+			display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz = 0;
+			display_cfg->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz = 0;
+		}
+	}
+
 	return result;
 }
 
-- 
2.45.2

