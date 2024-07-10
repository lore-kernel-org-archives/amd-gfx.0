Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F402C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288D810E8A4;
	Wed, 10 Jul 2024 19:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzQYEGQu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6388610E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFht3kg7nbvikfxhF2/SFyDDDv+3pDnCgrfaxrzTRxrWjaw/c013xT2p93Du2AVzs+Aw6wyEwGKP6Wy8yimHGZwz727g2d+bKsgSFxNvenV13iiDEbqPGtj08nh+fooAbjlfSk0tl2vqjZ4YEQC1/Wx1yUvfCt8nBUUKZJFSzlojJhFYJq6wufF1ytwtl7LknCnGjW1lheuvYkCvAeqNw818GwxNNbjBUwOag5Fy11lwNX0dE0FfNmt0mxi0gFrMcnIBqtugvIAWAX+bAm0qYKA6bfyHHT6trX5KoU6iOteAJcwgXPCyaY1Ji6xmGOwun6Rkeh3c7q7rmWVOpL3aHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig2/Ui6DYmAO1tSrPRAYTQWxHhRJIclIT8bDZGTiZCM=;
 b=CQK3MtZh0XuGxy6Ks86c9aP0ikeCe3+B82sm/sEqlX1M7i3g+9rgiYLPmQ8KnbV7PM5mzsDhsO9I6f9TztfZYkfFnCt/MxqCyp8EBTdhvEFGSo5bffllUepgcab4+7UTEBU3Ck+gxT+EbDjLTJVu2KlegEIDpedQO9T7VJJeWdM327uaX3cxS6uexsvStxt4e1+33QvUWVhN1VMGw0hOrUmSvlu8Ux9+YVpicKJyi8TgFHE0wW2amYK/P59Zu/gm3oHN/N+8tMxf0TJx8OQT2BuF5UjN6CD1o2GxYxD4Hc6kXpVoM3V1waoSxWNmxi29l61dOr3e1WxhjJ44FBLHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig2/Ui6DYmAO1tSrPRAYTQWxHhRJIclIT8bDZGTiZCM=;
 b=CzQYEGQuozQY5jrk65CZNfwFFdn0Mk3Mh46ojZrxKTD7PdWs3X8msZL5lKY+/hevv75ruEXbqgNbHyd/+YLgpvc4sa9VaXQedIU70wC+yNz5Ye5Om/1ccOA02del+WGBmJvnSJKOC+JsHSyNTcvLiCVAE7iLcWyfcd3YDsstmrY=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:37:47 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::25) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:44 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:39 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/50] drm/amd/display: fix dscclk programming sequence on
 DCN401
Date: Wed, 10 Jul 2024 15:36:25 -0400
Message-ID: <20240710193707.43754-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f23fb27-a229-42ab-9520-08dca117c6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQecgMzq9plpn6Z7cpw76I2wrcHFXxGEWdhwBeEra9tT63kquKPiEPPc5kI1?=
 =?us-ascii?Q?7/G2nJu1Fop6eNXnEsCFncSF+wxBim0Dc3eD/2s9aCldLdnyJiLGM0DE2m4u?=
 =?us-ascii?Q?4ubYxc5G59pbqTtvidUJdHdt4gqCE/wuhaZnvFUFuoqdwRmSkczDNTOQv+Lb?=
 =?us-ascii?Q?Hi1b6SsSw00yQEJcVpzqT15MgT9jG4DKW9Rpz98Q5nHuarKVhpFUjcRMClaI?=
 =?us-ascii?Q?ByKJEIfj+Oek4qLeLapOeObfiAtZWsGs3aw00IPbeJgoPbhMU45YVisiBm4/?=
 =?us-ascii?Q?ByQMfkzvG86L58YiK5cfDtqpHIePeZSewubqd7Kyufh3ZPdE88WmlSnKrDTl?=
 =?us-ascii?Q?k9MJepz8411XjUVOb5x/Ux1hPH7L1U5CV+NMTTTALH5IHI2hOY4O6CC9xHlf?=
 =?us-ascii?Q?8ZXtHguVUHS8B/CY0gSa0XbrwGgfNY5C/xtBoG+HVnUp2CgZUB28+JKENYlC?=
 =?us-ascii?Q?WQkwMV7elDYMJJLPnK0SIuH+Ngu+IRHB1CrOWb5mlDKdNRbJYkffvQYZX2QT?=
 =?us-ascii?Q?Kt0UaVbz9GEgGwGdTtJqPKjtTmUIIeOBa8jLYrUsmqj9X6X1V2b0DLT4fm0p?=
 =?us-ascii?Q?8j0AU1Dh5PdYp6kOdqQaCdFYR4pOfG+K6U5LPAOqUCFxtmCJkU5s9VjzMpKt?=
 =?us-ascii?Q?ZcMFqXY1DElPQFOfuZzydEmIlX88eR5fSGp5oQUrzo/oqBGE4Rxh9TEb46Bm?=
 =?us-ascii?Q?UqXGaCVxJao+t1r8MdSmo4AJ89LNzxaBrE+MCtQd17AFfzCFgGoRgykB/1st?=
 =?us-ascii?Q?kzoloMG06jzIfvDmeLzJyOZb6BBF+QY6vlpMvBZlRHrH8TSks9YA7SZ/Gkla?=
 =?us-ascii?Q?T1h7fq0w230cc1690TS4eIvo0PQ97GEEUPyy4j0ZnmgSvzz7dY3PfUv3pJ8u?=
 =?us-ascii?Q?vlpQPjK8y2T5aqJrsVNEnwZhqycedX90mur12HIlaYXfVm37JHxqAB2cMJ1Z?=
 =?us-ascii?Q?2Sw14hz1JgUjpbi+t45fyZUklf0/HCsyLPjWREGLTvzJ13UILmCkh835Yug9?=
 =?us-ascii?Q?CXGzDUQHkRvBbrIHnqoJKGSZGCksL529pW4Xt6gs+Dfaz1UZmwqSEzWmjyAy?=
 =?us-ascii?Q?tK3UsbC+lUPmo8pli+bZ2MPeqJcscXM3GRr5zUsnlYrW7NM3O2sen9bytpXr?=
 =?us-ascii?Q?qS7MeYtDv6NZot/9Bmop5uXj2LcroU6NXZlSXhfUSUtdSAg27XzWAASau/ki?=
 =?us-ascii?Q?28nOlWL2InVvWGubR5L1xqfm9cn6HV5iHVE8RNhHs+dl9AwZxH4ccuiwj9yo?=
 =?us-ascii?Q?xPFBfTCUV/GZ6/78iqQ76Is/allxVkRUFWqMl5Ks8Wr0DQGQzE+rbYjfWJxo?=
 =?us-ascii?Q?Pbusl0/Axb5dgNO4572IQupzS6RGTdnT7ykZ1CSMt+u1PpRCV3jZNqaHK1oY?=
 =?us-ascii?Q?5RMEPz1erpbMZTTaN2bkdigK/y0CiJK0sEoFHFEMAWeRgtL9QPuO2eAL6ITb?=
 =?us-ascii?Q?980HWJZjGFUu1R8Rijr5cwYUjOBp94XR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:46.5899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f23fb27-a229-42ab-9520-08dca117c6a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The mux to switch between refclk and dto_dsc_clk is non double buffered.
However dto dsc clk's phase and modulo divider registers are currently
configured as double buffered update. This causes a problem when we switch to
use dto dsc clk and program phase and modulo in the same sequence. In this
sequence dsc clk is switched to dto but the clock divider programming doesn't
take effect until next frame. When we try to program DSCC registers, SMN bus
will hang because dto dsc clk divider phase is set to 0.

[how]
Configure phase and modulo to take effect immediately. Always switch to dto dsc
clk before DSC clock is unagted. Switch back to refclk after DSC clock is gated.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  6 +--
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 32 ++++++++++-----
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |  4 --
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 21 +++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  6 +--
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 +--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 41 ++++++++++++-------
 8 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 1e0292861244..6ac2bd86c4db 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -346,11 +346,7 @@
 	type SYMCLK32_LE3_SRC_SEL;\
 	type SYMCLK32_LE2_EN;\
 	type SYMCLK32_LE3_EN;\
-	type DP_DTO_ENABLE[MAX_PIPES];\
-	type DSCCLK0_DTO_DB_EN;\
-	type DSCCLK1_DTO_DB_EN;\
-	type DSCCLK2_DTO_DB_EN;\
-	type DSCCLK3_DTO_DB_EN;
+	type DP_DTO_ENABLE[MAX_PIPES];
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 07f1f396ba52..0b889004509a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -730,35 +730,35 @@ void dccg401_init(struct dccg *dccg)
 	}
 }
 
-static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, bool enable)
+static void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	uint32_t phase = enable ? 1 : 0;
 
 	switch (inst) {
 	case 0:
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK0_EN, 1, DSCCLK0_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
-				DSCCLK0_DTO_PHASE, phase,
+				DSCCLK0_DTO_PHASE, 1,
 				DSCCLK0_DTO_MODULO, 1);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 1);
+
 		break;
 	case 1:
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1, DSCCLK1_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
-				DSCCLK1_DTO_PHASE, phase,
+				DSCCLK1_DTO_PHASE, 1,
 				DSCCLK1_DTO_MODULO, 1);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1);
 		break;
 	case 2:
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1, DSCCLK2_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
-				DSCCLK2_DTO_PHASE, phase,
+				DSCCLK2_DTO_PHASE, 1,
 				DSCCLK2_DTO_MODULO, 1);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1);
 		break;
 	case 3:
-		REG_UPDATE_2(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1, DSCCLK3_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
-				DSCCLK3_DTO_PHASE, phase,
+				DSCCLK3_DTO_PHASE, 1,
 				DSCCLK3_DTO_MODULO, 1);
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -774,15 +774,27 @@ static void dccg401_set_ref_dscclk(struct dccg *dccg,
 	switch (dsc_inst) {
 	case 0:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 0);
+		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
+				DSCCLK0_DTO_PHASE, 0,
+				DSCCLK0_DTO_MODULO, 0);
 		break;
 	case 1:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 0);
+		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
+				DSCCLK1_DTO_PHASE, 0,
+				DSCCLK1_DTO_MODULO, 0);
 		break;
 	case 2:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 0);
+		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
+				DSCCLK2_DTO_PHASE, 0,
+				DSCCLK2_DTO_MODULO, 0);
 		break;
 	case 3:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 0);
+		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
+				DSCCLK3_DTO_PHASE, 0,
+				DSCCLK3_DTO_MODULO, 0);
 		break;
 	default:
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index 8bcddc836347..a196ce9e8127 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -117,10 +117,6 @@
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_EN, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_DB_EN, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_DB_EN, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_DB_EN, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_DTO_DB_EN, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 2532ad410cb5..ea9bedf65d84 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2186,9 +2186,9 @@ static void post_unlock_reset_opp(struct dc *dc,
 			 * yet power gated.
 			 */
 			dsc->funcs->dsc_wait_disconnect_pending_clear(dsc);
+			dsc->funcs->dsc_disable(dsc);
 			if (dccg->funcs->set_ref_dscclk)
 				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
-			dsc->funcs->dsc_disable(dsc);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 05d8f81daa06..4534843ba66a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1029,24 +1029,20 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
-		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, true);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
-			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, true);
 		}
-		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
-		dsc_cfg.pic_width *= opp_cnt;
-
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-
 		/* Enable DSC in OPTC */
 		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
 		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
@@ -1060,13 +1056,9 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				OPTC_DSC_DISABLED, 0, 0);
 
 		/* only disconnect DSC block, DSC is disabled when OPP head pipe is reset */
-		if (dccg->funcs->set_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, pipe_ctx->stream_res.dsc->inst, false);
-		dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
+		dsc->funcs->dsc_disconnect(pipe_ctx->stream_res.dsc);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			ASSERT(odm_pipe->stream_res.dsc);
-			if (dccg->funcs->set_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_pipe->stream_res.dsc->inst, false);
 			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
 		}
 	}
@@ -1137,10 +1129,7 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
 				current_pipe_ctx->next_odm_pipe->stream_res.dsc) {
 			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
-			struct dccg *dccg = dc->res_pool->dccg;
 
-			if (dccg->funcs->set_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, dsc->inst, false);
 			/* disconnect DSC block from stream */
 			dsc->funcs->dsc_disconnect(dsc);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 2c50c0f745a0..b9378f18c020 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1542,7 +1542,6 @@ static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
 	struct pipe_ctx *old_pipe;
 	struct pipe_ctx *new_pipe;
 	struct pipe_ctx *old_opp_heads[MAX_PIPES];
-	struct dccg *dccg = dc->res_pool->dccg;
 	struct pipe_ctx *old_otg_master;
 	int old_opp_head_count = 0;
 
@@ -1568,12 +1567,9 @@ static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
 		for (i = 0; i < old_opp_head_count; i++) {
 			old_pipe = old_opp_heads[i];
 			new_pipe = &context->res_ctx.pipe_ctx[old_pipe->pipe_idx];
-			if (old_pipe->stream_res.dsc && !new_pipe->stream_res.dsc) {
-				dccg->funcs->set_dto_dscclk(dccg,
-						old_pipe->stream_res.dsc->inst, false);
+			if (old_pipe->stream_res.dsc && !new_pipe->stream_res.dsc)
 				old_pipe->stream_res.dsc->funcs->dsc_disconnect(
 						old_pipe->stream_res.dsc);
-			}
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 4fb1aacee894..d619eb229a62 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -211,10 +211,7 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
-	void (*set_dto_dscclk)(
-			struct dccg *dccg,
-			uint32_t dsc_inst,
-			bool enable);
+	void (*set_dto_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 65607589495f..d6550b904b16 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -817,17 +817,17 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
-		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, true);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
-			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, true);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -879,19 +879,32 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* disable DSC block */
-		if (dccg->funcs->set_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, pipe_ctx->stream_res.dsc->inst, false);
-		pipe_ctx->stream_res.dsc->funcs->dsc_disconnect(pipe_ctx->stream_res.dsc);
-		if (dccg->funcs->set_ref_dscclk)
-			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
-		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			if (dccg->funcs->set_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_pipe->stream_res.dsc->inst, false);
+		for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
+			/*
+			 * TODO - dsc_disconnect is a double buffered register.
+			 * by the time we call dsc_disable, dsc may still remain
+			 * connected to OPP. In this case OPTC will no longer
+			 * get correct pixel data because DSCC is off. However
+			 * we also can't wait for the  disconnect pending
+			 * complete, because this function can be called
+			 * with/without OTG master lock acquired. When the lock
+			 * is acquired we will never get pending complete until
+			 * we release the lock later. So there is no easy way to
+			 * solve this problem especially when the lock is
+			 * acquired. DSC is a front end hw block it should be
+			 * programmed as part of front end sequence, where the
+			 * commit sequence without lock and update sequence
+			 * with lock are completely separated. However because
+			 * we are programming dsc as part of back end link
+			 * programming sequence, we don't know if front end OPTC
+			 * master lock is acquired. The back end should be
+			 * agnostic to front end lock. DSC programming shouldn't
+			 * belong to this sequence.
+			 */
+			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
 			if (dccg->funcs->set_ref_dscclk)
 				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
-			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
 		}
 	}
 }
-- 
2.34.1

