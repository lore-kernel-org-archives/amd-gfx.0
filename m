Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2EFE77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C2D10EB17;
	Tue,  7 Jan 2025 15:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBAflJ5V";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFF110EB16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg/IeSHpKPMr8/b/Capz5iBqSoYg99OK+mPrwP5tSA5Z/rVXGtcdc4Qy9xjYVen5iM7UPXExviOruztURBLDLfraG44gT6krlZryXijma9NASQoXzj3TEaFyeCzwGHePMufUXTB0WyD9bGbf8eMMpp41M75VEerNgNGJRTklU8dtMw4hiu4jTFbX/fQES9PLLuQJZ/oCupGBj6HSdMJaKBgSA+Bfwd7uBlleqHeCho/XjS+uJ13+Fzl7lzoK7TEydH3qIayyCxJsX7l0mwnB2fPPp2Xu180u34OrowEZyz717AdQJ4DyEMoaRWC0KGsWyeT5e0FUuOyqX/k/sDGe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0Z3N6bBFGDzije70/KAuH4l6TYrXOc73+Z0hlYE1m8=;
 b=jEMk5IzttbYgxdUR8eoUIhnFhIOmJHr++Xyf/8KYG+c70RhTORHysDFi+PqQPtDLv1we9FGDXH1tKqH0YrQWn28Xl0MZoe4G95heO9IBt81bOlhv+rufIGWVslEFyPrdTzyEje6EvPkqX9+aehfCxJCXT4yDVAqAV4hg1fKpoSfBKSygGeiKVmwkc0GV2CA6pwYVOqUc/jyW+8uz4O/O4yb5QPSeo1wRhH4lCvJ2dr8rwrMXbKicoZbjG2jqqAgb3f+BV1D71+rlks/pxgpVbj6/XhhsCVh//Y2Y1C5vqD8W4flAQU7SlRTNefyhGohLGEd4Pwu+f56YyhMe1aMlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0Z3N6bBFGDzije70/KAuH4l6TYrXOc73+Z0hlYE1m8=;
 b=OBAflJ5VAkWZjzVJ2NPK/Wmst67Y5j2HW9KIdcsy3d2Rk7p8nv3GEClVaXapAjQ+HmDOkLWbFui6O8RSdkP4HAu0Q6DQN87C0MI/VTc0a+PyqKpPLr6PP9n+et3lKzuom/DEHoAtvIAj4Gwt20wwZm79rv7VxGboyKmdBevwzwA=
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:31:12 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::a5) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:31:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:52 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:48 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Martin Leung <martin.leung@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>
Subject: [PATCH 23/24] drm/amd/display: avoid reset DTBCLK at clock init
Date: Tue, 7 Jan 2025 23:28:54 +0800
Message-ID: <20250107152855.2953302-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0782df12-8af6-4e35-9fa7-08dd2f3050ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lR5eVO8hfSRhwlSAX4Z2PboGTOnkDxKlCWxLjQHhiUMvGVv9USdM0BAzZySc?=
 =?us-ascii?Q?jkCTymcJQjjPNeXR2F68mxL4TqfGWvFupuifm/+yqAqHEl/8RH0Jlo5VPBuI?=
 =?us-ascii?Q?cVNHw01MY3a3hXy46PKl1uZ0WcK3cxICA1OveYgXvAjsggwkjUDxSJ8KPETI?=
 =?us-ascii?Q?talp8umd5xOGb54xUPDbqgltUWNZygX2C2cnKSkClwokgx6F8nnboqW8nMpr?=
 =?us-ascii?Q?uxHoG1oS6nF+OSb4RxnWVRyFPKEMuFgHCiGU/9dJ7tgLyZCQr121Cuo1z2Q6?=
 =?us-ascii?Q?V94c1zSfv4zXrrr5mUOhZiNKILxqviA/+32Ch+R3eEGNC6XBVGyM53IU7mn6?=
 =?us-ascii?Q?kd5xhBv1EwUmDb1m2lrqVVcjHRkOZDVBaMVPI0SOyZUZb9q/vsNf4A02ITPw?=
 =?us-ascii?Q?Uh60dlIpYFV5I06FLJDx9e5+q+QgUmrisPPzThxiDxTDP+BPwg7un43HU0zR?=
 =?us-ascii?Q?NUNBrilcsZIuO0caGBCiuLbpgIcYM65ztJ9aZYVP4nTfZhNJGg8qnR9jeBDf?=
 =?us-ascii?Q?9OA65jyWOk0FGQRwJu/nwE3oSLAEmRPwDs91gMXiguNTLgNchfWlDpNwEcoo?=
 =?us-ascii?Q?xLAsk6ab5oSpqTyY9yVqoTL1F+5vnBVJ/HbAK/ZHsjTZgeVE5FW6WOT5Y656?=
 =?us-ascii?Q?1SFfWg9frd8lr3jWvbK60iaKW9t5whZMC0FC+BZaHA/00A14sFI+tWiD/AdO?=
 =?us-ascii?Q?mm4zawlEFCKZUROYS3/mav8VU1U/GHqR5U0AM6aemmjQ2pbQThYSTPnWwyZn?=
 =?us-ascii?Q?kGDE6lRcSaXj5u8O0wWpTVyCrwzjCkDYKBeir+C+Zt5kYpfl+7av6LOoXgV3?=
 =?us-ascii?Q?WNyCMrmHQkh3bPUlwmD+n6mwk2rk1Iwhio5RIOZ//UcaKgBv3TR4lFYuLVDv?=
 =?us-ascii?Q?ezrl/CTULHkERyvrkdY0qu+Vjv7sfmbITreeUnIi/Ia/1rzoWOlvEFnZEVoN?=
 =?us-ascii?Q?RJ/jV/2l49C1c0YsJyu/6ZRlAx5+I4ZourMMPHAQfFIi5E5uFq15N94HfxxM?=
 =?us-ascii?Q?mfAFQ+P3sDqOS6Z7SxsGOzqR4ZzkvXAPO1YaW5lI7SVdxS99hgYGEjNKoQaB?=
 =?us-ascii?Q?jw0zUbyEOjCK8Cjve+Jnemd4ezeW0ElVG87pGHlz/MGPo6xV51w+M+MxlGGc?=
 =?us-ascii?Q?WBkZV1TSH9mCiUiWNfNGAmF78zB7UaUY4MIk3C/PH/F32o3d+LTh2hRHfBXr?=
 =?us-ascii?Q?Gs251hxYf0egEGul++QIuJeZO+ch1einAqCzSLkKS2dwq2l7CMOpu07X97Lf?=
 =?us-ascii?Q?HaIQAS/jM5R1G3nbYylg4+YO7/clWC+I0vfSTenIZkOMN5t6kDjccz+ZTWvy?=
 =?us-ascii?Q?9ds+vWoq4urtjEgpeawIBpSfZZWDdAY3Ewp969gib4xcFgRI4690tIK8wk/w?=
 =?us-ascii?Q?eayOMapgrAhPgjRJZ0jqpy374DA3tCCL46uP4Y5p501iHtXUH6bbZbBI/buR?=
 =?us-ascii?Q?phcVmRc7GQMdj1Tlk2tC0WAFbQHh8hxaZ/R0iu5q2fywgt9FJdDXiHsB3YPu?=
 =?us-ascii?Q?dMF6XvseMEmEXIo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:31:11.4188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0782df12-8af6-4e35-9fa7-08dd2f3050ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why & how]
this is to init to HW real DTBCLK.
and use real HW DTBCLK status to update internal logic state

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 2a74140d7ebf..1f974ea3b0c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -401,6 +401,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
 			if (clk_mgr->base.ctx->dc->config.allow_0_dtb_clk)
 				dcn35_smu_set_dtbclk(clk_mgr, false);
+
 			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 		}
 		/* check that we're not already in lower */
@@ -418,11 +419,17 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 
 		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
-			dcn35_smu_set_dtbclk(clk_mgr, true);
-			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+			int actual_dtbclk = 0;
 
 			dcn35_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
-			clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
+			dcn35_smu_set_dtbclk(clk_mgr, true);
+
+			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
+
+			if (actual_dtbclk) {
+				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
+				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+			}
 		}
 
 		/* check that we're not already in D0 */
@@ -584,12 +591,10 @@ static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
-	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	if (clk_mgr_int->smu_ver >= SMU_VER_THRESHOLD)
-		clk_mgr->clks.dtbclk_en = true; // request DTBCLK disable on first commit
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
@@ -600,6 +605,7 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+
 	init_clk_states(clk_mgr);
 
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
-- 
2.34.1

