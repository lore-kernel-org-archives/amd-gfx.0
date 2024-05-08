Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C96FC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A424113118;
	Wed,  8 May 2024 17:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHCvwSoU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F5F113110
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIL6fhIjETHjIgqKsABDTPMh4EYtO2yES8aXd660sHI1cJ5Zf0jQKk2cZ4Hm9cT0jQTHW9kWI/fTUZMX6lhu9pe2LjqX/GtniqY5WWSfqC5mq16OKnMtwW2an47eurXlbSn+7t7LhxgZNdBnnCDUs18S5RaybRuBPwf/lVIuHgeHHEMf9MxqrYTzI7XLKK//dkrxvsoryIqY7SoASJ5g5B5EzaPZ6ENJ8O1DNcYWBu7wZXzyOjlcNySWVUlQoNPLJi7ccxpwUzojwI9lYH/v/D8N84Hnp6Xczi0EjJwvTOgmSFp+O6IxoGj5bqAkkdhVMWj1RqWVqocTkffOnLGYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1feEPmvXUtmHgnftBNaJjXJDkRrT0Pf1AcIapp3IvI=;
 b=H8RNk0e44PjUt6bZtiVD1E/n/yxqNcVwWaUtPKIxyuDLpdTPElmcH17N3KLFpd13t14Kfc3Z4burKXtMHNCpS4N6AsNTKGm2m7TnUfpgVkBM2QzseatLMRK5/lwl4SYtZwpaVfKskOxELL2jSGDZQB63s3MAv1t7P6sUdzRlWU8s+k1bt+8uubx6u4fISr4449kVxYqiY/6Tl0m6umcA03wDaFbELfGNbvjY6tujygt23jPbL+A4kR4wWWE0m64TCDz8nzMjPLrI/QyRzVzdcFN55expML5aLzdod4fyGDPQjZjSyiYXGFOc16nUt1aCdhApZKhRoBrX8Z1WoEnVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1feEPmvXUtmHgnftBNaJjXJDkRrT0Pf1AcIapp3IvI=;
 b=zHCvwSoUkXmc+9OZkpZ/XBPt+q/77sNhjA1g71LwT08aFms+4kF91vijLw4A3MH5ZoZPT9zKsFhFjD35jk8KNNuKDU6PFuSoz3Oqz5Honl/8Zb9ahmzeicJvbGv07HWmV3erpYViYnDkvo4xdZ65jLcP8Dqf+koxJxjkPWIDSKc=
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:15:25 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::4b) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:15:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:15:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 02/20] drm/amd/display: Disable AC/DC codepath when unnecessary
Date: Wed, 8 May 2024 11:13:02 -0600
Message-ID: <20240508171320.3292065-3-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a8a7a8-7e8c-44f8-54d6-08dc6f82737a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8E8aDAILsZiv5WKaQo5uwTePPhJCc77bzE72QFviWaQEwFDebuo6GApTJksz?=
 =?us-ascii?Q?owZUNJAUXYxhXl0JV+NL+7mS0yaGvpSXcJUZJNCPtDW/DphbsNKTUUvvvp1C?=
 =?us-ascii?Q?iuOeQ40kHaIgqq5d+0qR+ZSEadnzxiycxH3i+ZR5nxGy3AC9mJM039L9KwHO?=
 =?us-ascii?Q?gns+lz36yywkEgAsOXCSo8jQ2UKh3Yrrsa7ndJW6WjNH34fDIFCxeE7aBRak?=
 =?us-ascii?Q?uBStijVOp/lhTd4fbAVNfNcDjylAhVEDoiA30aTI9kerHIiOMHRN6pD+UEfe?=
 =?us-ascii?Q?WzLaaPtFrpn952a3sKQQ9S+BZ+LAd1z92Lfrvk7YetOj0+la3mZ/zRC8Ym9/?=
 =?us-ascii?Q?I2MDhC057VnexnxXHn/iQUeSqHV7AnhJw+AZoRKjo0jnCC+Xu5+ssOuvOXJV?=
 =?us-ascii?Q?s38kEOqowbx1djut295NQ9pte9tMFCNUmM4QKdXUwLLZA/SAeJIAB6bBWQ0Q?=
 =?us-ascii?Q?DlIRDSIYCnH66Bw/qXehvIhuXycB1sPhDJfz2s7d4M4B6oW45+uCjmgB4E/Z?=
 =?us-ascii?Q?V3XfUHwOfsSXOr82XS3sqXdVHfEIgXiln494tvhOnssj+faQmIbr7/5o7haY?=
 =?us-ascii?Q?rjjpGnUfVhes2lZVIhY6hTBOWBZ7gpxZ0XBr8RpdEAEW4SrpYJ4DVr7AR4Rm?=
 =?us-ascii?Q?dih/WLnPj6dnTU/WIpyJAYleoYv7nzwxGOyuvzOfvr12ykWLxz6SQthgJ4S2?=
 =?us-ascii?Q?ENXclCr1aaXX9vQcmJuxvq0b4RYO3lznOjmUyzJx5z6EezTuHv/Z8dsGSExk?=
 =?us-ascii?Q?wGLnq71ZG/Dz/vMLZrPxR2qDwchsssKeQAEZHuUNw2qUZNkhe6BYAFTexwOD?=
 =?us-ascii?Q?dtZV09SCKRDIxADR1WBquTp5Wbkt7vYdRql5YVk8RyuvOVKPUBzJU+uB8kjZ?=
 =?us-ascii?Q?ZYfwGRl7J1oCpuPVV9bziqyl0c98l+k46n4d44zmjWftmqF3Ts/78CQf15Mv?=
 =?us-ascii?Q?IFaADsqzFz8z2mjGE4Y9/yn3e1DQqBjNLmwMeC5GQj3PpgbxI7pCyG3ZhhYD?=
 =?us-ascii?Q?hYWSm/k4KmNY+kFLoK1kkXPk3IVRGosLzcZfO3WCb2Azs4bXjwwfDnipY30r?=
 =?us-ascii?Q?jYmv8w8dRuZvrl1pYqyn5kJL2UWUMMn8tRfZgNnWW4xw15HK2uE4ipJSy3Uf?=
 =?us-ascii?Q?ajqbYuaBgkq49cziwZxnJC7KNkNgwnPdvnqxTAlLmghJ+u0m+WLUe6tZBZ7+?=
 =?us-ascii?Q?4FxUFfTns+gAtmoIcG2WURlpKaa3dytkIVCDEegAsToWzlkq1QA88BzCoqTd?=
 =?us-ascii?Q?EVmMEj6DdI+XCGE8Tl074fXbGCzWN6bMNZE2UEcuIbEi4O5Hv/4kEdOzIcEz?=
 =?us-ascii?Q?GyFJcvX0zihSpE8y3y+a33cVqgtJdzGYA6zO4BgPYOS8Z6UEEWr0OKihBh7P?=
 =?us-ascii?Q?qEH+n9f/remMBB0SibAeqhykrXqU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:15:25.3127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a8a7a8-7e8c-44f8-54d6-08dc6f82737a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

From: Joshua Aberback <joshua.aberback@amd.com>

[WHY]
If there are no DC clock limits present, or if the DC limits are the same
as the AC limits, we can disable the AC/DC codepath as there won't be any
validation differences between the two modes.

[HOW]
When all DC power mode clock limits are the same as the max clock
values, there won't be any difference between AC mode and DC mode. Zero
out DC limits that equal max and provide a new cap to indicate the
presence of any non-zero DC mode limit. In summary:
 - zero out DC limits that are the same as max clock value
 - new dc cap to indicate the presence of DC mode limits
 - set limits present if any clock has distinct AC and DC values from SMU

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 28 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 12 +++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 1cf750cfed66..bd74ff47fb37 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -180,7 +180,6 @@ static void dcn401_build_wm_range_table(struct clk_mgr *clk_mgr)
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	unsigned int num_levels;
 	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
 	unsigned int i;
 
@@ -208,34 +207,43 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
 			&num_entries_per_clk->num_dcfclk_levels);
 	clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DCFCLK);
+	if (num_entries_per_clk->num_dcfclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz ==
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dcfclk_levels - 1].dcfclk_mhz)
+		clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = 0;
 
 	/* SOCCLK */
 	dcn401_init_single_clock(clk_mgr, PPCLK_SOCCLK,
 					&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
 					&num_entries_per_clk->num_socclk_levels);
 	clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_SOCCLK);
+	if (num_entries_per_clk->num_socclk_levels && clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz ==
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_socclk_levels - 1].socclk_mhz)
+		clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = 0;
 
 	/* DTBCLK */
 	if (!clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch) {
 		dcn401_init_single_clock(clk_mgr, PPCLK_DTBCLK,
 				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
 				&num_entries_per_clk->num_dtbclk_levels);
-		clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz =
-			dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DTBCLK);
+		clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DTBCLK);
+		if (num_entries_per_clk->num_dtbclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz ==
+				clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dtbclk_levels - 1].dtbclk_mhz)
+			clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz = 0;
 	}
 
 	/* DISPCLK */
 	dcn401_init_single_clock(clk_mgr, PPCLK_DISPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
 			&num_entries_per_clk->num_dispclk_levels);
-	num_levels = num_entries_per_clk->num_dispclk_levels;
 	clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DISPCLK);
+	if (num_entries_per_clk->num_dispclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz ==
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dispclk_levels - 1].dispclk_mhz)
+		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 0;
 
 	/* DPPCLK */
 	dcn401_init_single_clock(clk_mgr, PPCLK_DPPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
 			&num_entries_per_clk->num_dppclk_levels);
-	num_levels = num_entries_per_clk->num_dppclk_levels;
 
 	if (num_entries_per_clk->num_dcfclk_levels &&
 			num_entries_per_clk->num_dtbclk_levels &&
@@ -243,7 +251,7 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 		clk_mgr->dpm_present = true;
 
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
-		for (i = 0; i < num_levels; i++)
+		for (i = 0; i < num_entries_per_clk->num_dispclk_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
 					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
@@ -251,7 +259,7 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	}
 
 	if (clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz) {
-		for (i = 0; i < num_levels; i++)
+		for (i = 0; i < num_entries_per_clk->num_dppclk_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
 					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
@@ -842,12 +850,18 @@ static void dcn401_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	}
 
 	clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
+	if (num_entries_per_clk->num_memclk_levels && clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz ==
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_memclk_levels - 1].memclk_mhz)
+		clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = 0;
 	clk_mgr_base->bw_params->dc_mode_softmax_memclk = clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz;
 
 	dcn401_init_single_clock(clk_mgr, PPCLK_FCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
 			&num_entries_per_clk->num_fclk_levels);
 	clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_FCLK);
+	if (num_entries_per_clk->num_fclk_levels && clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz ==
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_fclk_levels - 1].fclk_mhz)
+		clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = 0;
 
 	if (num_entries_per_clk->num_memclk_levels >= num_entries_per_clk->num_fclk_levels) {
 		num_levels = num_entries_per_clk->num_memclk_levels;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8698db8f3e45..2fce8c0303fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -290,6 +290,7 @@ struct dc_caps {
 	uint32_t max_disp_clock_khz_at_vmin;
 	uint8_t subvp_drr_vblank_start_margin_us;
 	bool cursor_not_scaled;
+	bool dcmode_power_limits_present;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d9a3d6c2da1f..3b74c4a9c2a8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -212,9 +212,19 @@ void dcn401_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
+		// mark dcmode limits present if any clock has distinct AC and DC values from SMU
+		dc->caps.dcmode_power_limits_present =
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dcfclk_mhz) ||
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dispclk_mhz) ||
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dtbclk_mhz) ||
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_fclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.fclk_mhz) ||
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.memclk_mhz) ||
+				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_socclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.socclk_mhz);
+	}
+
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
-- 
2.34.1

