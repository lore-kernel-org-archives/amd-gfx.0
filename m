Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF583CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7327910E7B1;
	Wed, 24 Sep 2025 18:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Te7teGck";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6A410E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXQ79JtagPpKkxHcAW072Cf7UDcEcqC18XoQKMzAxzSPghHW9+aL8fjlN7trDNxUqFrWj/oq+YLGFzcUWsTYe9CKSamvmaDlJJWOedHrQqBg+Tk5e5a3J4mG0t1eR98EDjVo1RETlSzsunalvL7e7v8qwjprjmH2PF5Tl+4YvwTxXVTork23eYuz0PKqnVL61CH/zb3viNwOKQRRFQuPSjC2GxcpydRM+N5AcqfVMSb0ndxEKtlYnF5xkb4j5ZdrXi5NWrkHNABmmkZmoc5do/+q94I1P3YJT6g0COO8u+fLS1yL/ICfmtKwxz2xFt7OFTjKNC4+sP+hg8mphBFOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3I5KR12pKBA0a08x6LqZKtfF5tkn5+u9zau29Rbeqo=;
 b=GrqcrnnbmJHzbQKMDzZ26nMz95BLJzeieAoLNmr9tp7UXbf8owMpj0QkvHqvaoER4JhKdEozpIYnOnNYtCqpN3L2Xxubgkf7pPdND5cwhnC0fk/Q05SKGWZ1WqQX8WMT+NVhLedkBUHy9ucFWrRSrx8/9sN2zW7k+dyyT4RtrL1n8V2kW0c/rO8UjomLT1+39hG0gx3q8ENF3RNI2LHEwfGjYWtR9hZA3qJDiuHtmaTdXBq2AyyITyYHNToPvGawq+/LwJUeFtmVjT1QnGAQ4cDPtPJlDxdbE6Q5i+X/O5E0MzlkfcbpRl29II/wqe6a2HYwuoj6DwzdSbTbflij6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3I5KR12pKBA0a08x6LqZKtfF5tkn5+u9zau29Rbeqo=;
 b=Te7teGckUbVGB4BTpR/8hCFxiRzBan4PIBnmMNMgW/PnvAgOhn6loEMO1NB8mxe/yXiPdxZA0v0dlAPot6hj0WxuUDKxwVt7dG9n5/VT9v8WNJW8n5Gh+dgCESBF64Wu9N8/j6Kf2+VTcCwl81FwWuEZHsNJbUlgsE9aRTz2/FY=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 18:22:38 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::a2) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 18:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:30 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:24 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 08/10] drm/amd/display: Prevent Gating DTBCLK before It Is
 Properly Latched
Date: Wed, 24 Sep 2025 14:21:59 -0400
Message-ID: <20250924182201.1049389-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 41af61d6-b894-4656-e2f4-08ddfb975775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i34+Crg5104/G12+H5313y934APylY7aR8/kByVY3u4XpQ8eUX3CRB7eHLyr?=
 =?us-ascii?Q?glHJGGeEY+OYku9S90zUuHlXrbVWnCaAnZnHbAqwhJszjRQC7TtnpYmMD6Lt?=
 =?us-ascii?Q?eAiwA5sTGLSyrlGf6Ph6jFKSksrQXCIaSRBDlpyd/5CNsuESYCUPl5X4pBWg?=
 =?us-ascii?Q?P5H60ndn7cnbpGtvuXqNSwraHsNE0HOOpd5iR2Thi6J0uOeMDft+QqPMgbBU?=
 =?us-ascii?Q?he8+D1bgUI9jcLBPM8QkrP9GmRX/Pardt3bDmWhMm5DBcxNEycNTMyYtSirO?=
 =?us-ascii?Q?TfzdToDqNyMzBut9GOr3+AKrlkSNW0RQKx0o71tPrpfFcBETQwx2PFwXIKr+?=
 =?us-ascii?Q?M+9kK6zl8aXIp1ZPy2LkECIlESeJQ9q0wNAKj0WefGTG9LTxEFfylLi4Eafr?=
 =?us-ascii?Q?vfrt2VtD1X05YkV1mUQoCmhxDgqn91rgEu20jf+IB9HqKLpeTs6452gCarPS?=
 =?us-ascii?Q?wrot9PzWYtAfqm+a92aY+u/T8/xhfXeLsbvXOdDw3etzDM4tRsNxkONYZkbK?=
 =?us-ascii?Q?Wkof8WSZl4HZn02lMAcbhjWnVSQFzoCT0N0VfeIWc0wOOJY2pP0u487y4iaX?=
 =?us-ascii?Q?dM4KY1AQBfealH/wLC0AcQgqS0gqoTQ/zRHzqvXZXX1CculaJaTt5FQ9Bkfo?=
 =?us-ascii?Q?mWXlq9t55KEDQv6ii+hPXF//au1YK3fBvK6VBpiLXnxkISDRfRBgWCgaVPOj?=
 =?us-ascii?Q?ljRLc48x1gjThjApsuZMXeT80728DHrmvzp2QcMJvSdavhRb0rQoZLIAyt0E?=
 =?us-ascii?Q?ZShd3pX+gQOUZ6vXB1Jo761wGPd1Wwdw0yF4pwOoS7Hv9z24iFgq0nXjRWPH?=
 =?us-ascii?Q?j1VOkZiv1kNqHIagZl2tYkIXUich8BZYBbQlOl1mgJs0OWABDyQEb35reDBh?=
 =?us-ascii?Q?Pwwlhzr5JIh9/rh0Lb/rjrOPB1kThtD234qQ0/6hQkZwLMfv4jBHH4lDOQN6?=
 =?us-ascii?Q?ZeG3bJoT6vbCqaMPV81+4o15lM9Km2WOMwMHWhCddY47T4IjwKCTvz9c3bqy?=
 =?us-ascii?Q?fBnPc4EsYO2EZBMV4kTelulINlKJP55oog44YPxYL2ch9bthZMB+BMAkjybS?=
 =?us-ascii?Q?yEJLljoAjYZNbM0Bt/NsgAiTu+KmixKB/cxW1KtO+Y6wHfqOkmeqeaV/7NHg?=
 =?us-ascii?Q?pGqbNLcgjjyeC4b3Y3Ugw6xAGYz2x/ru+fC9ac3DB8jN3atDzt/P+Ldv74nj?=
 =?us-ascii?Q?8waoZ6gdWuUc+djJXhzVXIklrbO53VsEwjprhiJ/cO2n6X4B+Uj/Q8fyzYbT?=
 =?us-ascii?Q?cNyFvWwqj0NDIUsfftNe4zPpUaPj/09+AlmVyVRMI4EDIENR99MCPFgYUiRu?=
 =?us-ascii?Q?lO29FOaiv7PLz45yUs5SJa7ehB2iAAhlGVvavOfpf5CB41bTaVw4yKkT94yj?=
 =?us-ascii?Q?RKnNyoIoLP8zWVvgdS4vTJSR4S1d1K0nh2Z8Q1v8Mo3fnw6EWZmuMyX6jGCV?=
 =?us-ascii?Q?/hpQ/i8zkECugicVOK3M1lpZPaTc927KCsetyh/Nj9cG1i6FwWMMyUxVW5Bu?=
 =?us-ascii?Q?phPc7Zg2pnnGPl0Kkg+5vNqTK4djcZUqJBGE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:38.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41af61d6-b894-4656-e2f4-08ddfb975775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[why]
1. With allow_0_dtb_clk enabled, the time required to latch DTBCLK to 600 MHz
depends on the SMU. If DTBCLK is not latched to 600 MHz before set_mode completes,
gating DTBCLK causes the DP2 sink to lose its clock source.

2. The existing DTBCLK gating sequence ungates DTBCLK based on both pix_clk and ref_dtbclk,
but gates DTBCLK when either pix_clk or ref_dtbclk is zero.
pix_clk can be zero outside the set_mode sequence before DTBCLK is properly latched,
which can lead to DTBCLK being gated by mistake.

[how]
Consider both pixel_clk and ref_dtbclk when determining when it is safe to gate DTBCLK;
this is more accurate.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c       | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b11383fba35f..1eb04772f5da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -394,6 +394,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	display_count = dcn35_get_active_display_cnt_wa(dc, context, &all_active_disps);
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
+	else if (!new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz > 590000)
+		new_clocks->ref_dtbclk_khz = 0;
 
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
@@ -435,7 +437,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
 
-			if (actual_dtbclk) {
+			if (actual_dtbclk > 590000) {
 				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index de6d62401362..c899c09ea31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1411,7 +1411,7 @@ static void dccg35_set_dtbclk_dto(
 				__func__, params->otg_inst, params->pixclk_khz,
 				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
 
-	} else {
+	} else if (!params->ref_dtbclk_khz && !req_dtbclk_khz) {
 		switch (params->otg_inst) {
 		case 0:
 			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 0);
-- 
2.34.1

