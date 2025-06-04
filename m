Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD90C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAF710E7A9;
	Wed,  4 Jun 2025 19:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZUmaFXh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B631010E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoNMgwG+5mUSKvuDoktMhFIpdzclBfSdz24hLSp/okYmuODE9i7FKJsJ6QEhziiK38INv9jp2oQZtXQznbwg/PTKkyXl+lb1mL7uCSWr7DKEeYSJi7lFg05zzXHoLYX4O2PlkPyHaOBtJiENbMmRpq58VcqLk+x5eYMWmOmJPM4EY8Fm7sJbj203YXZJDgfNNObjbfPlzw0IUqInh/yUmNACLMG6HBhermQx/d3zk7fPDdfTJcTtaX9eVwwyFmzc1ZVPEVonQEYqoDvdQ8r8jBfsTwELeG+oesid5EuOiCQRhVX1v6axXJXGZU/KxesCfsHrxW5lwSiZ8QTai6l5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBq/nFPXq/ndrlRNUlt00SgWiR1nJpWsxlztH6DoXtA=;
 b=XNhou5myJJ9EwomyO9VFMXmdj6F/2gqEg9NipbBQ9HLHCquC2KXVA7Bm8A6IPsPqZvHy7z1Yav2+MYe/t312QJM855Uwove5K5ZRspYqN7tgoILhbSDuQkGEzVxevDOZiLMNN1kjKzUOZxrESm0Ner4eyVCWvG/Z3/wF3lsHRwwtF/YY+QAEHuPuiMmDjsiOsuVHnmKnMrDxH7PCO0Qni+GBqTn/eXpnoNS7HMzUhuICoR3mo0PP5W5Iw6/9qRM2idX/SQK0j1VAHhnzGsu+UtGMxvYzDSwxYyRvRHuzcjrsjtFTaHnf/SLqNwcTbQON7W+ihLfXMr/WQx98exOluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBq/nFPXq/ndrlRNUlt00SgWiR1nJpWsxlztH6DoXtA=;
 b=GZUmaFXhdtfffBpyov4cxXWbkZy/I0hDZow4eY5NGEnF57t7bwFOOiR44ahAZFwCj10+yuek+3w6QJLTIPfNOd1ZzytVqXJ7FVxVNko90BgSIMYSBbvmH/KApKSMw3HRpM2zhXns227OW6mMxNO8XM+6l1LGTAjrC/Ye34T+VrU=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:38:58 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::8e) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Wed,
 4 Jun 2025 19:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:38:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:38:55 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 07/23] drm/amd/display: Refactor DML2 DC power instance
Date: Wed, 4 Jun 2025 12:43:18 -0600
Message-ID: <20250604193659.2462225-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: c0df923b-d380-4adb-c782-08dda39f72bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpe1L1jqjAw1E55ti57tokYls1es++WJ7HjkNNKMuegvmvAMTYU5OZMYj2c6?=
 =?us-ascii?Q?THiuik4XUVfggh00QoNV0VjpPVXhCv6JQ7fZs+fncgjzO1H1JHbhWzsXyEQj?=
 =?us-ascii?Q?37M6W62FU58kmUUkKAXkYEDtFqYMQvENhLFOFCm8UB+xohBWSnmfLl0PSMdh?=
 =?us-ascii?Q?z0NIgnIC76x3mjWJVMP4bDx0Gf1CItlFNnT08qQA0Yr2NOz0/sYykv/GM1b6?=
 =?us-ascii?Q?Wi4aLI7HOvM/xbL54gYbWKW/5q+NcTS6WayK8KiF2EZmlzHigRIhSqlkgTFB?=
 =?us-ascii?Q?pHrOLb433/K1ukFiPvkt2OMA0lofcH6X3OnZD2KueHRiIVtYsFiZSHVR6TbO?=
 =?us-ascii?Q?Eklxh7BuEdloBDRliMuOF7UVPzbX2vTCxQ+l2Xc3NBAwAmten6Txz8yYW/x4?=
 =?us-ascii?Q?CapC7tEyRGD54DkdPz+9EQg+poyMoLjzPba7O453rGt0A6mrCjxX0JKJOdQk?=
 =?us-ascii?Q?mLJMXFAbNUcneXBE5TC0nzWum1X3TfG5caZAJ3AvBO46uIqPJOKWTx7+bDRC?=
 =?us-ascii?Q?D++KP6k9/dZyNsN1K4izPCOe0r7o4OTZwSZ7lUTuC7eDaZB4ApxfPld9U0Xk?=
 =?us-ascii?Q?YLx5mj2paPhYWlCI7z7s1EryTwNBHH9d6VCjw+0UW5qQ0dpt4ftZoy6taddK?=
 =?us-ascii?Q?EpSDbf4MLi79CMC2GJcpdEJd03ddKScW2nRD87sn0c4AGEM5+1/1zqo+9iRk?=
 =?us-ascii?Q?e8gmaT1tXCqs+kW/WYTVLAERhwNbUjg8M972u0COJFJw3DQPA+X1TTCWpxHp?=
 =?us-ascii?Q?HRbkseAw1GM/4dgm4gkeq56AFpqrg7CS1hEobCf57tQ+zw3TZQXhd2qxN9/4?=
 =?us-ascii?Q?+E80pm2PzIM6Ls6+l7b/vaIWo2CkM41fJU040oCsRtdhDCuYhMaX/bluFWtS?=
 =?us-ascii?Q?FEr+UYwOBTvd9aaA7KImeJPUcfgynExP9NcH0vDwY+tOSTEvMyp0+rMrNc5G?=
 =?us-ascii?Q?Nb9FvD3MN3YELm/uit4lFa9u+csTOedzQsfZkWvRmwBrgbilowgDyFs9lStY?=
 =?us-ascii?Q?S6Gpp/6eQTfEkSkgWsqx73MZhzkfT1Ai07HI/d3hxwaOIykT/Fz1Q5bezipn?=
 =?us-ascii?Q?DBae2Ib5t5LrcOVYHXYGgTEmojJzKvgds7IrFNUxpZ7kd6K1hegxYCmnpkQ8?=
 =?us-ascii?Q?6vCHmkq0QW3KhMfRXgPtsZj4W+NULEkKgWZ0Wco8MA4CvF5BSnAa6mWBD3FX?=
 =?us-ascii?Q?ovFJyw3eYuWckqElCdPpXRbfj/ODU3evuh9dJjZbEhh/klcXck5aIXAApql1?=
 =?us-ascii?Q?Z+sKhe39NyOzRZ8W4EVqzRZorFfU06oUOOwO1jhS203JJaKvhm8eSOzJaWaF?=
 =?us-ascii?Q?rUhtPhW7HQd7Q1NGnTIpOixWxUNYkXJsqtxsoDL06Rtk5tCr6i6auXEiL5HP?=
 =?us-ascii?Q?BnKkqVu8j5cKgDN3XQ8Clco7QgoKAQXvs42B5YnrjDgnhezPXTrMxYhLxb18?=
 =?us-ascii?Q?5I0o7CRn2ATWc3YVl+sjwXHWFQXWnfUHs7BEr6LKnJG3uNS4UtOT4rO/9orF?=
 =?us-ascii?Q?jDdRptTPx6Hoz7uqasdEzpMtIuDKgm9TaprJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:38:57.5857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0df923b-d380-4adb-c782-08dda39f72bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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
Use a dedicated DC power option and instance pair.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 20 +++++++++++++++++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  1 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 11 ++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 ++-------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 ++
 .../dc/resource/dcn32/dcn32_resource.c        | 14 ++++++-------
 .../dc/resource/dcn321/dcn321_resource.c      | 14 ++++++-------
 .../dc/resource/dcn401/dcn401_resource.c      | 14 ++++++-------
 9 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 13334ee987f7..514a5efda102 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -311,6 +311,25 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn401_build_wm_range_table(clk_mgr_base);
 }
 
+bool dcn401_is_dc_mode_present(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return clk_mgr->smu_present && clk_mgr->dpm_present &&
+			((clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz) ||
+			(clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz) ||
+			(clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz) ||
+			(clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz) ||
+			(clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz) ||
+			(clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_socclk_levels &&
+			clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz));
+}
+
 static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
@@ -1496,6 +1515,7 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.get_dispclk_from_dentist = dcn401_get_dispclk_from_dentist,
 		.get_hard_min_memclk = dcn401_get_hard_min_memclk,
 		.get_hard_min_fclk = dcn401_get_hard_min_fclk,
+		.is_dc_mode_present = dcn401_is_dc_mode_present,
 };
 
 struct clk_mgr_internal *dcn401_clk_mgr_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 6c9ae5ca2c7e..616e964df96d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -105,6 +105,7 @@ struct dcn401_clk_mgr {
 };
 
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base);
+bool dcn401_is_dc_mode_present(struct clk_mgr *clk_mgr_base);
 
 struct clk_mgr_internal *dcn401_clk_mgr_construct(struct dc_context *ctx,
 		struct dccg *dccg);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 4db7383720fd..47712a4aec55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -194,11 +194,6 @@ static void init_state(struct dc *dc, struct dc_state *state)
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
 	struct dc_state *state;
-#ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
-
-	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
-#endif
 
 	state = kvzalloc(sizeof(struct dc_state), GFP_KERNEL);
 
@@ -211,14 +206,12 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
-		dml2_opt->use_clock_dc_limits = false;
-		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2)) {
+		if (!dml2_create(dc, &dc->dml2_options, &state->bw_ctx.dml2)) {
 			dc_state_release(state);
 			return NULL;
 		}
 
-		dml2_opt->use_clock_dc_limits = true;
-		if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source)) {
+		if (!dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
 			dc_state_release(state);
 			return NULL;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 83ee6ddaddb7..fc36beb66d49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1701,7 +1701,7 @@ struct dc {
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
-	struct dml2_configuration_options dml2_tmp;
+	struct dml2_configuration_options dml2_dc_power_options;
 	enum dc_acpi_cm_power_state power_state;
 
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 97c3482721db..ffc5f0e600bd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -145,13 +145,8 @@ void dcn401_init_hw(struct dc *dc)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 		// mark dcmode limits present if any clock has distinct AC and DC values from SMU
-		dc->caps.dcmode_power_limits_present =
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dcfclk_mhz) ||
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dispclk_mhz) ||
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.dtbclk_mhz) ||
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_fclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.fclk_mhz) ||
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.memclk_mhz) ||
-				(dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_socclk_levels && dc->clk_mgr->bw_params->dc_mode_limit.socclk_mhz);
+		dc->caps.dcmode_power_limits_present = dc->clk_mgr->funcs->is_dc_mode_present &&
+				dc->clk_mgr->funcs->is_dc_mode_present(dc->clk_mgr);
 	}
 
 	// Initialize the dccg
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index c14d64687a3d..3b736f4687a6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -324,6 +324,8 @@ struct clk_mgr_funcs {
 
 	int (*get_dispclk_from_dentist)(struct clk_mgr *clk_mgr_base);
 
+	bool (*is_dc_mode_present)(struct clk_mgr *clk_mgr);
+
 };
 
 struct clk_mgr {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index a7a78a2752de..363e4a094534 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2061,21 +2061,15 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
-
-	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
-
 	DC_FP_START();
 
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, &dc->dml2_dc_power_options, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
 }
@@ -2551,6 +2545,10 @@ static bool dcn32_resource_construct(
 	if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc->config.sdpif_request_limit_words_per_umc == 0))
 		dc->config.sdpif_request_limit_words_per_umc = 16;
 
+	/* init DC limited DML2 options */
+	memcpy(&dc->dml2_dc_power_options, &dc->dml2_options, sizeof(struct dml2_configuration_options));
+	dc->dml2_dc_power_options.use_clock_dc_limits = true;
+
 	return true;
 
 create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 7db1f7a5613f..ae5a58a48d73 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1580,21 +1580,15 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
-
-	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
-
 	DC_FP_START();
 
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, &dc->dml2_dc_power_options, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
 }
@@ -2046,6 +2040,10 @@ static bool dcn321_resource_construct(
 	dc->dml2_options.max_segments_per_hubp = 18;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;
 
+	/* init DC limited DML2 options */
+	memcpy(&dc->dml2_dc_power_options, &dc->dml2_options, sizeof(struct dml2_configuration_options));
+	dc->dml2_dc_power_options.use_clock_dc_limits = true;
+
 	return true;
 
 create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index aff30274fa96..b0cf5c9c1cad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1607,10 +1607,6 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
-
-	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
-
 	/* re-calculate the available MALL size if required */
 	if (bw_params->num_channels > 0) {
 		dc->caps.max_cab_allocation_bytes = dcn401_calc_num_avail_chans_for_mall(
@@ -1621,13 +1617,11 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	DC_FP_START();
 
-	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, &dc->dml2_dc_power_options, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
 }
@@ -2246,6 +2240,10 @@ static bool dcn401_resource_construct(
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
+	/* init DC limited DML2 options */
+	memcpy(&dc->dml2_dc_power_options, &dc->dml2_options, sizeof(struct dml2_configuration_options));
+	dc->dml2_dc_power_options.use_clock_dc_limits = true;
+
 	return true;
 
 create_fail:
-- 
2.43.0

