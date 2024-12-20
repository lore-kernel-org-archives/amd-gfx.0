Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC8BE7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B33410F06B;
	Fri, 20 Dec 2024 21:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAq/QQhG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4958910F06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwEEyv8zWLSCRxbymmYmJ4NlXQB7bhR3E/bOxRLQPgTI3dsUyCoNQwx0MgIxi0KYbvCAHWc6DGX59nAfQ1fU1SjtUMhpjQNkg4O/QqRsL8Iom83oqylRZINIfXxkPVwZKLBDnEKeRg1CgpVHOI6isfJ02MIZkZa12gP/atdhvWzoXk3+loX6pvjA59dfTPsPTwExa6b56nfA6mNT/21jBP2vblM40bk6YvP1gdSwRX6EIgWOn04yWl49VPhPkbcNOb9eAul5vdvlR56K5Zgbx/9i7342/ysvBzQ7x3MMQtrpuSebP6BAutAfZFkGbWhOfGrJzJQtbGq68VvTSUyTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqKe3WqLLDakkuIe2yN8HYjz5wpR9L8bHpJyJ87nG3Y=;
 b=vWm9CeI+YBNUCf8CT0uAvAEoFDitPG2OwlO/0b3HX/k4DESZ15IHXKbKAzFY5XwMj3GUjOylW4IYED6y7rk13gdsqNpMW4j+pZSfz5qa+jSJ1LrptDKmNv/aBU9KUHQC1j63dGH7ucDOOInZjF0CpueHggv30pwYIcmSlQ+BO/Lx30vmCCQsOdm0t8GTh+fJZc6Sb1XkldMKMNLop3XFvA/8s8t+KiIXRrAB3M2HwVaD4sofUrIevVHErVXPRvvK//Tk4o+KFxV2X4UH9krjY1+LHaOJrJKkV4e1EqQyenzNGht8ZBClT+J9OGYzM7r7r2mzzEyXbZ7fvtQRG6b6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqKe3WqLLDakkuIe2yN8HYjz5wpR9L8bHpJyJ87nG3Y=;
 b=EAq/QQhGDWdtLyh6F3XXM013Q79hGC138ujd610ZwAcFBgoP0WBJFVDYIA7piYs6je3cG2/pzgAxMQhnv22eoerd/JhdDuvi5QvA04zSBfoCtIMhII/M7Mxj11cMnlpZBYSsQZAs6UmsySOli96zBWQhFAz6YHzyuIsXsK9gm+8=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:53 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::7c) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:48 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:48 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/28] drm/amd/display: Cleanup outdated interfaces in
 dcn401_clk_mgr
Date: Fri, 20 Dec 2024 16:48:30 -0500
Message-ID: <20241220214855.2608618-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: e90f306e-6fca-4d24-8243-08dd21405e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HwJyiPXzaSPIAhlnhtQEPyNo/7f52kyu8jgOkGE3XwfPAzI5bsEhYWJVhcxQ?=
 =?us-ascii?Q?54iXQ3meZuWBsmxzgOmxuuoU0mHWB3KqhuW7pNDvkbtBztgbgAYjgdD+AVQk?=
 =?us-ascii?Q?1tA5L6p2/amEr4Y/qAJ4BrELA1jOwMSeS80Lyp/VxmCEzg/zD2Il78PW7655?=
 =?us-ascii?Q?9SJUpDIfICPIE8dpNmZ+rUEU26LPHFviEoCcWQ0CaG/rQ4XAyDIcD2AVg9nw?=
 =?us-ascii?Q?wAjfC8eCvn/kBRpW4sDQ8ZqRHQ/6zb0n/OgTqwDRssuexy0cscWlDVCT2qyz?=
 =?us-ascii?Q?sukoHmA5GCU3pEYYz33316JE/MGHHjBxDNxf4A/D9hmUn3l8jS71ka1U0NT5?=
 =?us-ascii?Q?4CtB14wdClqfFGYBPizucTDm/vYL20TpwFkk5ncoR06BCNWSwUuBkNHcz4xo?=
 =?us-ascii?Q?2d3VgIJlCbDWij1QwyCYpb5dAKe2M38bnAYjmpAq7rX0ms6V7RakL9RA5dgl?=
 =?us-ascii?Q?vzpaPdFcqAomTogLldTXl9f6krSXuzK5t2koRnfjZAdQtv/0y+5z7zniT4Te?=
 =?us-ascii?Q?UfpT0kB1/JiXoMwNPzQeXSVTHztdtcFQOupNaqRyYX0b40W+Z9Haao7sIYKJ?=
 =?us-ascii?Q?lkzn/ilbXVhhr5pkpJqC8gICV+XEV5XAib6qg12+rkf+TBoEmMrGWPNvowie?=
 =?us-ascii?Q?cO5F4HhDjW6jedKqgYX0SrfnzJxjv9jHosDfsekI4xOtNhwQ5ztjjvPM0/GG?=
 =?us-ascii?Q?2RkCmd2Ymqhl4DOyGMX6diAeR19WEbPLyjdxIer6xKAKm2Qo5z00gH+5iJHP?=
 =?us-ascii?Q?YjHjlU32kT7MgDAE0Bh+B7coKWtOneh9GcjUo4QBGEoG/a08h18f0h/YgoxS?=
 =?us-ascii?Q?PubjM34cBpMOCBGV77Rnm/R/J80wnFwSwd/iJ9eRaj47jaIj/5Q86FDmU5VI?=
 =?us-ascii?Q?WLjiugaXtZ32dKPM/+a3g/YlgaRkLaNOY510FwtgrH66kq7oh6c2GVVp+cqJ?=
 =?us-ascii?Q?3ihbxhyxCCB2+37GVptS1fhWVXJHnddaBpVI1P7UOygtAUV4jvaENNbPPwJj?=
 =?us-ascii?Q?2QyjhCxx8ZBg+oJAO3veBq08Qi8ZirWTulvdoK4UAqiAdNNHmdV0rNYxg3AP?=
 =?us-ascii?Q?IdXJVZdBozorsgf19DrcFMX7APdx6K/czU2k8VMjG4gHWcqgW8zTdjn+/Axy?=
 =?us-ascii?Q?oWk558Llw1dQFCPuK6s5xio8J55laoa1QmGxIwiRUWjGGHp1x06oBbesFAbu?=
 =?us-ascii?Q?I3YspjfySNGpoI239SWxiRu4pEsTsClmh19U+xeHSY4FAPvD7U4t6JTpa1Fo?=
 =?us-ascii?Q?Izha8Acnm3IffbE+xnmbZAzUa7FNfekW8DCoVn8xrhoLwjHupaTs9FvhCu1m?=
 =?us-ascii?Q?Bf+eAXsMR7/ngbdb8ifghHGSdnV20ZqnrvJEpT3DrwEb645h5N/It35HtpKH?=
 =?us-ascii?Q?aJrJ47H+HIvr5BZNd81jPgakNxdbpgEqBiDht+PfSvpOpXlhi2md+flQG592?=
 =?us-ascii?Q?H57UwDaR5hymunNmeYi5Ye00RAv27gKr4mBMlaFIEYsqomcs/blhw9xl49Cl?=
 =?us-ascii?Q?sNFjwct2qyDclJE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:50.2780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90f306e-6fca-4d24-8243-08dd21405e8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

[WHY&HOW]
- Remove legacy update clocks sequence
- FCLK P-State allow message is not required

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 240 ++----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 2 files changed, 17 insertions(+), 224 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 5b4e1e8a9ae2..e4360cd6b373 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -628,207 +628,6 @@ static void dcn401_update_clocks_update_dentist(
 
 }
 
-static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
-			struct dc_state *context,
-			bool safe_to_lower)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
-	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
-	bool update_dppclk = false;
-	bool update_dispclk = false;
-	bool enter_display_off = false;
-	bool dpp_clock_lowered = false;
-	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
-	bool force_reset = false;
-	bool update_uclk = false, update_fclk = false;
-	bool p_state_change_support;
-	bool fclk_p_state_change_support;
-	int total_plane_count;
-
-	if (dc->work_arounds.skip_clock_update)
-		return;
-
-	if (clk_mgr_base->clks.dispclk_khz == 0 ||
-			(dc->debug.force_clock_mode & 0x1)) {
-		/* This is from resume or boot up, if forced_clock cfg option used,
-		 * we bypass program dispclk and DPPCLK, but need set them for S3.
-		 */
-		force_reset = true;
-
-		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
-
-		/* Force_clock_mode 0x1:  force reset the clock even it is the same clock
-		 * as long as it is in Passive level.
-		 */
-	}
-	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
-
-	if (display_count == 0)
-		enter_display_off = true;
-
-	if (clk_mgr->smu_present) {
-		if (enter_display_off == safe_to_lower)
-			dcn401_smu_set_num_of_displays(clk_mgr, display_count);
-
-		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
-
-		total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
-		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
-
-		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
-			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
-
-			/* To enable FCLK P-state switching, send PSTATE_SUPPORTED message to PMFW */
-			if (clk_mgr_base->clks.fclk_p_state_change_support) {
-				/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
-				dcn401_smu_send_fclk_pstate_message(clk_mgr, true);
-			}
-		}
-
-		if (dc->debug.force_min_dcfclk_mhz > 0)
-			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-					new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
-
-		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
-			clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-			if (dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DCFCLK))
-				dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
-		}
-
-		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
-			clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
-			if (dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DCFCLK))
-				dcn401_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
-		}
-
-		if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
-			/* We don't actually care about socclk, don't notify SMU of hard min */
-			clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
-
-		clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-		clk_mgr_base->clks.prev_num_ways = clk_mgr_base->clks.num_ways;
-
-		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
-				clk_mgr_base->clks.num_ways < new_clocks->num_ways) {
-			clk_mgr_base->clks.num_ways = new_clocks->num_ways;
-			if (dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
-				dcn401_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
-		}
-
-
-		p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.prev_p_state_change_support)) {
-			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
-			clk_mgr_base->clks.fw_based_mclk_switching = p_state_change_support && new_clocks->fw_based_mclk_switching;
-
-			/* to disable P-State switching, set UCLK min = max */
-			if (!clk_mgr_base->clks.p_state_change_support && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
-				dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
-		}
-
-		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
-		if (safe_to_lower && (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
-			update_fclk = true;
-		}
-
-		if (!clk_mgr_base->clks.fclk_p_state_change_support &&
-				update_fclk &&
-				dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_FCLK)) {
-			/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
-			dcn401_smu_send_fclk_pstate_message(clk_mgr, false);
-		}
-
-		/* Always update saved value, even if new value not set due to P-State switching unsupported */
-		if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
-			clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
-			update_uclk = true;
-		}
-
-		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
-		if (clk_mgr_base->clks.p_state_change_support &&
-				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
-				dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
-			dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
-
-		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
-				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
-			clk_mgr_base->clks.num_ways = new_clocks->num_ways;
-			if (dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
-				dcn401_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
-		}
-	}
-
-	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
-		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
-			dpp_clock_lowered = true;
-
-		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
-		clk_mgr_base->clks.actual_dppclk_khz = new_clocks->dppclk_khz;
-
-		if (clk_mgr->smu_present && !dpp_clock_lowered && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DPPCLK))
-			clk_mgr_base->clks.actual_dppclk_khz = dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DPPCLK, clk_mgr_base->clks.dppclk_khz);
-		update_dppclk = true;
-	}
-
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-
-		if (clk_mgr->smu_present && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK))
-			clk_mgr_base->clks.actual_dispclk_khz = dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DISPCLK, clk_mgr_base->clks.dispclk_khz);
-
-		update_dispclk = true;
-	}
-
-	if (!new_clocks->dtbclk_en && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DTBCLK)) {
-		new_clocks->ref_dtbclk_khz = clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
-	}
-
-	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
-	if (!dc->debug.disable_dtb_ref_clk_switch &&
-			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000) &&
-			dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DTBCLK)) {
-		/* DCCG requires KHz precision for DTBCLK */
-		clk_mgr_base->clks.ref_dtbclk_khz =
-				dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
-
-		dcn401_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
-	}
-
-	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
-		if (dpp_clock_lowered) {
-			/* if clock is being lowered, increase DTO before lowering refclk */
-			dcn401_update_clocks_update_dpp_dto(clk_mgr, context,
-					safe_to_lower, clk_mgr_base->clks.dppclk_khz);
-			dcn401_update_clocks_update_dentist(clk_mgr, context);
-			if (clk_mgr->smu_present && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DPPCLK)) {
-				clk_mgr_base->clks.actual_dppclk_khz = dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DPPCLK,
-						clk_mgr_base->clks.dppclk_khz);
-				dcn401_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower,
-						clk_mgr_base->clks.actual_dppclk_khz);
-			}
-
-		} else {
-			/* if clock is being raised, increase refclk before lowering DTO */
-			if (update_dppclk || update_dispclk)
-				dcn401_update_clocks_update_dentist(clk_mgr, context);
-			/* There is a check inside dcn20_update_clocks_update_dpp_dto which ensures
-			 * that we do not lower dto when it is not safe to lower. We do not need to
-			 * compare the current and new dppclk before calling this function.
-			 */
-			dcn401_update_clocks_update_dpp_dto(clk_mgr, context,
-					safe_to_lower, clk_mgr_base->clks.actual_dppclk_khz);
-		}
-	}
-
-	if (update_dispclk && dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
-		/*update dmcu for wait_loop count*/
-		dmcu->funcs->set_psr_wait_loop(dmcu,
-				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
-}
-
 static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned int num_steps)
 {
 	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -1008,15 +807,15 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		update_active_fclk = true;
 		update_idle_fclk = true;
 
-		/* To enable FCLK P-state switching, send PSTATE_SUPPORTED message to PMFW */
-		if (clk_mgr_base->clks.fclk_p_state_change_support) {
-			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
-			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-				block_sequence[num_steps].params.update_pstate_support_params.support = true;
-				block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
-				num_steps++;
-			}
-		}
+		/* To enable FCLK P-state switching, send PSTATE_SUPPORTED message to PMFW (message not supported on DCN401)*/
+		// if (clk_mgr_base->clks.fclk_p_state_change_support) {
+		// 	/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
+		// 	if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
+		// 		block_sequence[num_steps].params.update_pstate_support_params.support = true;
+		// 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+		// 		num_steps++;
+		// 	}
+		// }
 	}
 
 	if (!clk_mgr_base->clks.fclk_p_state_change_support && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
@@ -1224,14 +1023,14 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		// 	(*num_steps)++;
 		// }
 
-		/* disable FCLK P-State support if needed */
-		if (!fclk_p_state_change_support &&
-				should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_prev_p_state_change_support) &&
-				dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-			block_sequence[num_steps].params.update_pstate_support_params.support = false;
-			block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
-			num_steps++;
-		}
+		/* disable FCLK P-State support if needed (message not supported on DCN401)*/
+		// if (!fclk_p_state_change_support &&
+		// 		should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_prev_p_state_change_support) &&
+		// 		dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
+		// 	block_sequence[num_steps].params.update_pstate_support_params.support = false;
+		// 	block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+		// 	num_steps++;
+		// }
 	}
 
 	if (new_clocks->fw_based_mclk_switching != clk_mgr_base->clks.fw_based_mclk_switching &&
@@ -1412,11 +1211,6 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	unsigned int num_steps = 0;
 
-	if (dc->debug.enable_legacy_clock_update) {
-		dcn401_update_clocks_legacy(clk_mgr_base, context, safe_to_lower);
-		return;
-	}
-
 	/* build bandwidth related clocks update sequence */
 	num_steps = dcn401_build_update_bandwidth_clocks_sequence(clk_mgr_base,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8c6347413038..cccffffaf768 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1060,7 +1060,6 @@ struct dc_debug_options {
 	uint32_t dml21_disable_pstate_method_mask;
 	union fw_assisted_mclk_switch_version fams_version;
 	union dmub_fams2_global_feature_config fams2_config;
-	bool enable_legacy_clock_update;
 	unsigned int force_cositing;
 	unsigned int disable_spl;
 	unsigned int force_easf;
-- 
2.34.1

