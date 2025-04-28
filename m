Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39E7C3ABA4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D4E10E55E;
	Mon, 28 Apr 2025 13:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCGRw4GW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A199C10E560
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw0OBz1awB6YHWE3/nMRdtAAh2GXp2LB5SxdXBp06RYmZu7gJgDHyVjCfdncfuLIj2cbwiI8mdU9BYL2yB3JYB4zA61bjQZGe1NB5QbwvzD6VVBha2v/VVk9aX3SDHNqDx9oeQ4Qmgd4M421siGlKSpmKKCwWBOIhdzmgDMz2tF8qiE8lsX+FeMlm7HfxmHOpc2RgKjrYGSrpfcomStIfc0yJXXY5RoquaMArJso9byBKzU+WWIS7vW/QiIrzacrr/VCuiGEg0olujoFmyav3eP4cCNSA963bLP2SVy3VUeW6eWUUDbu+nd63JFG3fJIxKes0PO72iTG1CnDpGr+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0pr9Yk6Cd0RtrvafR7LOgZ6/i8ArbtFmDBbqWdQrTI=;
 b=LvEabe5xxeRPLtepj4Jkp4AA0covxV2muf7x5KbhWXN5+cuPYmINuSM1mtjDZT5+F9iVojIfXhnC6zlowSKqh+ZrU8x8DwxIHRz9s5TbkJ3izgxIPezu+AVwAr2h/gPd/xIxnQTAqmUbkMvUCqPnlOStO2rHVE/LsiFHtaMnKhbpunUBgHKAehT7tDNmlqQGBllWuSXFh8m7rll37fYQXwqVfxE1QU6nRPDEmp7HvMifDkEUrkvEDDdUui1k5Ra12GsbNaADK6NGVbp3xqNJ+/rOVYLgBgZhygJhMZ50tdUz9AV3mPGXwoRTC73e8Gq+2ddXkPX8TRfiUvuKvU2DcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pr9Yk6Cd0RtrvafR7LOgZ6/i8ArbtFmDBbqWdQrTI=;
 b=RCGRw4GWKRhOOiU9d26N7W8D05TpBXkkPa63g25fhNgHLQvBOS7kEVZKXvHHvrZoCoImA06PmHaFCD11gb2mC9sOugTr4/+iJpGWLKt6bwZlVmO4ckl/fsdKUFnGUZAKzOXaNo9qoiS0aya/2yP6SabutjQzjTm4gSq61JGYw5I=
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:56:32 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f1) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:31 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:27 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Charlene
 Liu" <Charlene.Liu@amd.com>, Hansen Dsouza <hansen.dsouza@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 11/28] drm/amd/display: disable DPP RCG before DPP CLK enable
Date: Mon, 28 Apr 2025 21:50:41 +0800
Message-ID: <20250428135514.20775-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 79da262b-1814-473a-4e3f-08dd865c7b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sCHcYTq0RahzxqSCsJlhjFnukN6mY9V69XKUIPGULSpgOItbOep+kzb0NGTO?=
 =?us-ascii?Q?r4owwCgaXSdiU4OTbJfmxZNHi0lqLbUQi7qCyEVcJJos+wvBsny/TpAOcRM9?=
 =?us-ascii?Q?zhgIrgFd3BFrm9HFw8OLrhE7DtzAA+32F1la8I+SaxgkR8Mpn+ET28cGXASR?=
 =?us-ascii?Q?0WEhzUQEfNE+ofnMN3hCBxvM5A2Z0OMvXx6dXtr394qBGlHnMtYWsjRcgBV+?=
 =?us-ascii?Q?r708A8yff73VkBdapw0axJjyBxJScQQyRmkk1dTiMFQrA+jCLnMwxXovLNMu?=
 =?us-ascii?Q?bfk95M0WbU2UNegOgU6gpxxSbqIDtxMLM28xRuEZYu1BhQtiHBs5fFGeYGmE?=
 =?us-ascii?Q?yxxDcbZve5iq0bT0LgnazxfxVotFwXrsPOR05O2K65zP0Ijk+dOdSBY6F6tH?=
 =?us-ascii?Q?j/C5nujq5Sc4D0JwNsgM69TU9UdKF3AXKkZL1HIkzbqn8AJg0KOlUfCs/U3n?=
 =?us-ascii?Q?mopTzMkWqZZVeh+cuO2AHZLYXwGLQmUW7h+9FveSMKTh48mV2wuvfejc/XcN?=
 =?us-ascii?Q?DiM0HYipn+zfsu1D+YQUHYuMuoRgcDIz1hHvkLz1jkArHltikNEdON+l8Jm5?=
 =?us-ascii?Q?PLQYAtYAFYdEaKbkjoERyELELUP37YaLa09JblIEYasMaSNMNAFaQZ9sz7XI?=
 =?us-ascii?Q?lYptqkN1CqmAWhUud71U9aI4Z73CH/VCbosT5CyrI209rzcs3iXoyCR46d1a?=
 =?us-ascii?Q?2wZm+6iL0QG3QIp6Xqngo7wRRxoiTcVF3+P2ZU5euS62d5i2G5B2wgmOy971?=
 =?us-ascii?Q?ZVOU0X9ijZdd1+YEbINKVtCnlQSwDUKtkYD6+zs22olHj54R94Y+7duotHZI?=
 =?us-ascii?Q?0ao0glgy1VEKGZ7KhoWlrzJGqKu2Pv5pnJGeWDjU3S7xwp7yIa1jQYmaSym4?=
 =?us-ascii?Q?zqKOCRU+MbetilPCkyDvNSw5+jc8YtTWR1gp8Ka0LR3cOWssJ1G/vJ3PjU6M?=
 =?us-ascii?Q?CNczg6AugZ7spp65L4SC58tgyIUGgxELv0BpPMHjXIxTeIAXIUCQypi+zF1L?=
 =?us-ascii?Q?9JxyNGcAEkw6aHbSYXymNxDC4lKlBdPMZvCkyvzq1OlqlWmAKm/m9DLwoZwC?=
 =?us-ascii?Q?O/OOlyHi6yelFgm4Qi+3BxFymeb1WKPDdT386LpC4xfgu3BRbejcYrOE5edp?=
 =?us-ascii?Q?Po2phrm8it4Vv9RHOsJDDAHdlJbMAiFgDH0p8x7sKzXlVWdOjmqUunTp/xN+?=
 =?us-ascii?Q?R9yiQrNvAUxZOrIGeCKoEdBdRtjOkUCDEz1aQvYit7XRP+j9+1aHywbSut1M?=
 =?us-ascii?Q?tYo3oga5ASSXdRM+UpzO7siTeV9/S4YkqUL24gScJDytUkLKozdo0gJoRr4g?=
 =?us-ascii?Q?rtSOvATuipY80EzeyEt507SExeluAKJGzO4tpJJOUbNTJe68wEoZuU6vWcT5?=
 =?us-ascii?Q?A7P/sPi6qVTkXNjeiP0YR2u1l7K73QVtXWgWomTluQx0muZl2JG/kTHzBVTi?=
 =?us-ascii?Q?pzO5PPUxGoo5F+1iWt6y7EZU+ePgKFVGhp9LoPooPOymzXiMVX4mNPDoe0RU?=
 =?us-ascii?Q?Uo+EpnRjEfwy4N8QC7n1B5EVpTOJdNpamkup?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:31.9227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da262b-1814-473a-4e3f-08dd865c7b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

[why]
DPP CLK enable needs to disable DPPCLK RCG first.
The DPPCLK_en in dccg should always be enabled when the corresponding
pipe is enabled.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 38 ++++++++++++-------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 21 ++++++----
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 6c5d6956612e..58c84f555c0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -391,6 +391,7 @@ static void dccg35_set_dppclk_rcg(struct dccg *dccg,
 
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+
 	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp && enable)
 		return;
 
@@ -411,6 +412,8 @@ static void dccg35_set_dppclk_rcg(struct dccg *dccg,
 	BREAK_TO_DEBUGGER();
 		break;
 	}
+	//DC_LOG_DEBUG("%s: inst(%d) DPPCLK rcg_disable: %d\n", __func__, inst, enable ? 0 : 1);
+
 }
 
 static void dccg35_set_dpstreamclk_rcg(
@@ -1113,30 +1116,24 @@ static void dcn35_set_dppclk_enable(struct dccg *dccg,
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+
 	switch (dpp_inst) {
 	case 0:
 		REG_UPDATE(DPPCLK_CTRL, DPPCLK0_EN, enable);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK0_ROOT_GATE_DISABLE, enable);
 		break;
 	case 1:
 		REG_UPDATE(DPPCLK_CTRL, DPPCLK1_EN, enable);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK1_ROOT_GATE_DISABLE, enable);
 		break;
 	case 2:
 		REG_UPDATE(DPPCLK_CTRL, DPPCLK2_EN, enable);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK2_ROOT_GATE_DISABLE, enable);
 		break;
 	case 3:
 		REG_UPDATE(DPPCLK_CTRL, DPPCLK3_EN, enable);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK3_ROOT_GATE_DISABLE, enable);
 		break;
 	default:
 		break;
 	}
+	//DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
 
 }
 
@@ -1164,14 +1161,18 @@ static void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst,
 			ASSERT(false);
 			phase = 0xff;
 		}
+		dccg35_set_dppclk_rcg(dccg, dpp_inst, false);
 
 		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
 				DPPCLK0_DTO_PHASE, phase,
 				DPPCLK0_DTO_MODULO, modulo);
 
 		dcn35_set_dppclk_enable(dccg, dpp_inst, true);
-	} else
+	} else {
 		dcn35_set_dppclk_enable(dccg, dpp_inst, false);
+		/*we have this in hwss: disable_plane*/
+		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
+	}
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
 
@@ -1183,6 +1184,7 @@ static void dccg35_set_dppclk_root_clock_gating(struct dccg *dccg,
 	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
 		return;
 
+
 	switch (dpp_inst) {
 	case 0:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK0_ROOT_GATE_DISABLE, enable);
@@ -1199,6 +1201,8 @@ static void dccg35_set_dppclk_root_clock_gating(struct dccg *dccg,
 	default:
 		break;
 	}
+	//DC_LOG_DEBUG("%s: dpp_inst(%d) rcg: %d\n", __func__, dpp_inst, enable);
+
 }
 
 static void dccg35_get_pixel_rate_div(
@@ -1522,28 +1526,30 @@ static void dccg35_set_physymclk_root_clock_gating(
 	switch (phy_inst) {
 	case 0:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 1:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 2:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 3:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 4:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	//DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE:\n", __func__, phy_inst, enable ? 0 : 1);
+
 }
 
 static void dccg35_set_physymclk(
@@ -1644,6 +1650,8 @@ static void dccg35_dpp_root_clock_control(
 		return;
 
 	if (clock_on) {
+		dccg35_set_dppclk_rcg(dccg, dpp_inst, false);
+
 		/* turn off the DTO and leave phase/modulo at max */
 		dcn35_set_dppclk_enable(dccg, dpp_inst, 1);
 		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
@@ -1655,6 +1663,8 @@ static void dccg35_dpp_root_clock_control(
 		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
+		/*we have this in hwss: disable_plane*/
+		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 922b8d71cf1a..63077c1fad85 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -241,11 +241,6 @@ void dcn35_init_hw(struct dc *dc)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
-	if (res_pool->dccg->funcs->dccg_root_gate_disable_control) {
-		for (i = 0; i < res_pool->pipe_count; i++)
-			res_pool->dccg->funcs->dccg_root_gate_disable_control(res_pool->dccg, i, 0);
-	}
-
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
@@ -901,12 +896,18 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context)
 {
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dccg *dccg = dc->res_pool->dccg;
+
+
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
 
 	/* initialize HUBP on power up */
 	pipe_ctx->plane_res.hubp->funcs->hubp_init(pipe_ctx->plane_res.hubp);
-
+	/*make sure DPPCLK is on*/
+	dccg->funcs->dccg_root_gate_disable_control(dccg, dpp->inst, true);
+	dpp->funcs->dpp_dppclk_control(dpp, false, true);
 	/* make sure OPP_PIPE_CLOCK_EN = 1 */
 	pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control(
 			pipe_ctx->stream_res.opp,
@@ -923,6 +924,7 @@ void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 		// Program system aperture settings
 		pipe_ctx->plane_res.hubp->funcs->hubp_set_vm_system_aperture_settings(pipe_ctx->plane_res.hubp, &apt);
 	}
+	//DC_LOG_DEBUG("%s: dpp_inst(%d) =\n", __func__, dpp->inst);
 
 	if (!pipe_ctx->top_pipe
 		&& pipe_ctx->plane_state
@@ -938,6 +940,8 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dccg *dccg = dc->res_pool->dccg;
+
 
 	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe_ctx);
 
@@ -955,7 +959,8 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	hubp->funcs->hubp_clk_cntl(hubp, false);
 
 	dpp->funcs->dpp_dppclk_control(dpp, false, false);
-/*to do, need to support both case*/
+	dccg->funcs->dccg_root_gate_disable_control(dccg, dpp->inst, false);
+
 	hubp->power_gated = true;
 
 	hubp->funcs->hubp_reset(hubp);
@@ -967,6 +972,8 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->top_pipe = NULL;
 	pipe_ctx->bottom_pipe = NULL;
 	pipe_ctx->plane_state = NULL;
+	//DC_LOG_DEBUG("%s: dpp_inst(%d)=\n", __func__, dpp->inst);
+
 }
 
 void dcn35_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx)
-- 
2.43.0

