Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5030C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD80F10E39A;
	Tue, 27 Aug 2024 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ytFk2byQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2230810E396
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryceykkG9UNXLsey+T/gHOsZtkGuaFCijJtA8eS6K1/pzITC5WiJAi9+NtWQSmOVSuL59WI4NFAwOejDwIqXcl+Y+iSbrCaJ07sqkAgb+lmpBKhXRVSFeuCIjMOQ3q/s4yE1TTExty65OwN7DfpppIKIcX1y/jrqPiHX8QQWcc8ssdtY8GXtBq/MhMe1W7LTz9pqxfpuY4pmd9NEauqBd33MDyH9SvP2n7TZ2qZf6Fp82a2tWizqmNQPbp9B+pinYb68XSlah+trQLGwFe0SfpOijs1VvdN6rnTRvT15ksRtXjVKlfLmHs7+3lRdle2dJF1ePTtHC7q6bNwaMCV33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbEHphKcSwMfCl86DAKfSA1hdYh7auJFxlf0bKoWdAI=;
 b=a5E5ka+EphkZdGz2KihDP5l2bSYGFqSYHBSju8+trMFvvz0Mj+tPxd5JZ7aEDssnbEDuFu+3y1TCWZ48pMKCZopoksme+oUzfI9jGZqwlVKq1pn6eCHoE2RBLM0aA2we+HizTHKYtw4Za+KLs2lp5wdPaRQvkke1KHuIHxPLy1KGvrYH+LqzhRTH/rKimCwCxdQFz6I3RoIFKsKoKlAE7sGWd4nhi/ZRum1jlqAnTcbxTpM4Pfqz7rciMlUJvKij76+vXsY4ZDR7Ge7wMVgpexlP7cu8GSS+jxYwxowKSkl2NAVJM09Ktq01iTYAc+fn1UAnmt15ECIBl0SlQKE8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbEHphKcSwMfCl86DAKfSA1hdYh7auJFxlf0bKoWdAI=;
 b=ytFk2byQzMTyAIQV8yERdvg8ZCRZQFHsCtGsy+zLkxjEBlsape6o/kBCtvjaxE0nVg8avGKuge3HlM/HgY/8X+PJANTIN4et+xpB99aAapuYE/HhaCxqhzfCiCCaWdCd0x+qpoCrN5/uZXqSBu3/cp7yysSGGHDq4LqYL+WOthk=
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 16:41:19 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::8d) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:16 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Hansen
 Dsouza" <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>
Subject: [PATCH 13/14] drm/amd/display: Fix flickering caused by dccg
Date: Tue, 27 Aug 2024 12:37:33 -0400
Message-ID: <20240827164045.167557-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: e786cd55-0a29-476f-651a-08dcc6b71357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PVw2OMy897/9bQgjE/eWV11uqin69wYaQ0643sR28RAkMbjaMzpYVU+4k5+?=
 =?us-ascii?Q?uoFXre4aRdDrK0Zo0i945xUfoVNo73qjaJtyt+8T6WYgr3xfGDff3RHkPZdC?=
 =?us-ascii?Q?cjLziN6/DBxTWo4OIXth/1AiHzdSz0VJNN7gv1YqSXIyif1OJ0QrQ3i1HMUj?=
 =?us-ascii?Q?lGqlzix6/Tj2Hb7czpTHEWuK81kl/SBoXrR5D8+nadGKBxyUCiSuwW85QhM3?=
 =?us-ascii?Q?mrECUYT1w5aYJwIhCLCcvIbIIfmT0uW4GWE5JT7wpy1cFF8ZIYx9QLDytOMh?=
 =?us-ascii?Q?B34q3QSX/I97/mcpura75DYGCOvMOTuk4xyDBbqe7CY0+hmyiOLE5WlgRULM?=
 =?us-ascii?Q?twuA3H4AYTYzzih9hnSFmoN1lFVVgZOYhfls6XTIXEwUdEgTA8gGyOrJM/xe?=
 =?us-ascii?Q?2y/SDS/aT9osttA4DygX82zYp2hB27Zk2QyolNX/AdbKS+hiMWXTEjJiRL+k?=
 =?us-ascii?Q?jXwRUwxff1Z7onfWpuJRqj2yun8bP92ww+neRyBaKKV0FuvqluuBbdPnelKP?=
 =?us-ascii?Q?i8DA7s1Z5+Lbmp3u3W4YXsGlZK79OmoALXN7QLhqiQKwe6sE8ZXOnGGqhi39?=
 =?us-ascii?Q?TKDFid99lBEElWkNvV0e7eFZI9461LhxJ+r914awDIYYr8iQ/u+4JKSUP5fa?=
 =?us-ascii?Q?JqZKJtcZ9gAwby124Sm4IyK8t+hGBHnA1XGNhLHHXkl3Ycd+K+Mak0/btoII?=
 =?us-ascii?Q?pBPFlJR/5eVGgB8A5lfN2qw0y2sm2grd803z1ov8ptdpznMPuEsOp+kJ6LqK?=
 =?us-ascii?Q?dU97Io/HeF4hmuXJ8lxGBNVO0JYW0M5T+zCef8Gnon5/jAWrA9gWQG9kiIC6?=
 =?us-ascii?Q?yH9QDORo1fmciWjhP9EaWWkf5T8lTkRKvWyNv9SCXI6ctzQloL6FfblNcqJT?=
 =?us-ascii?Q?Dgl+99e2pvyGoX5KqFC22kKS6QSDpLHShp3YVbXDU7RPXOb3zAYjn1q8zrQY?=
 =?us-ascii?Q?3VVQfrVMfCXVGWNwg0wsjGiewtBDFrRmnLlJ1gVqJ7oqjMyaEOm80vzh4dTD?=
 =?us-ascii?Q?MbhyZFxWKNPxWzENeXIfjvMpmZRCXKWMHR5Hc3JmjyCBeU7EVABLlBPSmA/j?=
 =?us-ascii?Q?HBemcbPgGUKX28EeCzHzX0rHRe0D6ovBTTHyMeqpbRzXCnbpZ0YIQtwL2cWB?=
 =?us-ascii?Q?t8Nqwat0Rvb8OOMkr0I0EEvZ3flCczHM/pOtP3nZ/FuSiohO0mMVxDp2E882?=
 =?us-ascii?Q?EmmQG9tyxiAOS2MD7b6zx7Z6Sn/HyNZ3HAdbtUAsfM8/6BolDKLP4d89pvDP?=
 =?us-ascii?Q?GDrJNnM3HaD2Xt0Q/KlejKH76VNt3RFlEPEkuAO+9McQuKSZqptTYgZ36Gfe?=
 =?us-ascii?Q?RHOvIWJ8Lu+mwNd6wmYvFL7xr7QUJQIuOiuFZFqENAzZt+O6DB+51H53ljzE?=
 =?us-ascii?Q?jyK5DTEgHkOuUTYqD5fnUOfT7tEKrSlmF3B6EjQhRoj2vkkB0B0X6aucoDdd?=
 =?us-ascii?Q?RupMxinyhkq0lckI/zTIvIJQyfhYmc2J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:18.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e786cd55-0a29-476f-651a-08dcc6b71357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

Always allow un-gating. Follow legacy workaround for repeated
dppclk dto updates

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 11 +++
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 89 +++++++++++++------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 45 ----------
 3 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 6ac2bd86c4db..160c299419b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -328,6 +328,17 @@
 	type DPSTREAMCLK1_GATE_DISABLE;\
 	type DPSTREAMCLK2_GATE_DISABLE;\
 	type DPSTREAMCLK3_GATE_DISABLE;\
+	type SYMCLKA_FE_GATE_DISABLE;\
+	type SYMCLKB_FE_GATE_DISABLE;\
+	type SYMCLKC_FE_GATE_DISABLE;\
+	type SYMCLKD_FE_GATE_DISABLE;\
+	type SYMCLKE_FE_GATE_DISABLE;\
+	type SYMCLKA_GATE_DISABLE;\
+	type SYMCLKB_GATE_DISABLE;\
+	type SYMCLKC_GATE_DISABLE;\
+	type SYMCLKD_GATE_DISABLE;\
+	type SYMCLKE_GATE_DISABLE;\
+
 
 #define DCCG401_REG_FIELD_LIST(type) \
 	type OTG0_TMDS_PIXEL_RATE_DIV;\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 8b3722a0011b..838d72eaa87f 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -24,6 +24,7 @@
 
 #include "reg_helper.h"
 #include "core_types.h"
+#include "resource.h"
 #include "dcn35_dccg.h"
 
 #define TO_DCN_DCCG(dccg)\
@@ -136,7 +137,7 @@ static void dccg35_set_dsc_clk_rcg(struct dccg *dccg, int inst, bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc && enable)
 		return;
 
 	switch (inst) {
@@ -165,7 +166,7 @@ static void dccg35_set_symclk32_se_rcg(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se && enable)
 		return;
 
 	/* SYMCLK32_ROOT_SE#_GATE_DISABLE will clock gate in DCCG */
@@ -204,7 +205,7 @@ static void dccg35_set_symclk32_le_rcg(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le && enable)
 		return;
 
 	switch (inst) {
@@ -231,7 +232,7 @@ static void dccg35_set_physymclk_rcg(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk && enable)
 		return;
 
 	switch (inst) {
@@ -262,35 +263,45 @@ static void dccg35_set_physymclk_rcg(
 }
 
 static void dccg35_set_symclk_fe_rcg(
-		struct dccg *dccg,
-		int inst,
-		bool enable)
+	struct dccg *dccg,
+	int inst,
+	bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe && enable)
 		return;
 
 	switch (inst) {
 	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKA_FE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
-				SYMCLKA_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+				   SYMCLKA_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKB_FE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
-				SYMCLKB_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+				   SYMCLKB_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKC_FE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
-				SYMCLKC_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+				   SYMCLKC_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKD_FE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
-				SYMCLKD_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+				   SYMCLKD_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKE_FE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
-				SYMCLKE_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+				   SYMCLKE_FE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -307,27 +318,37 @@ static void dccg35_set_symclk_be_rcg(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* TBD add symclk_be in rcg control bits */
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe && enable)
 		return;
 
 	switch (inst) {
 	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKA_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
 				   SYMCLKA_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKB_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
 				   SYMCLKB_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKC_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
 				   SYMCLKC_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKD_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
 				   SYMCLKD_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
 	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				   SYMCLKE_GATE_DISABLE, enable ? 0 : 1);
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
 				   SYMCLKE_ROOT_GATE_DISABLE, enable ? 0 : 1);
 		break;
@@ -342,7 +363,7 @@ static void dccg35_set_dtbclk_p_rcg(struct dccg *dccg, int inst, bool enable)
 
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp && enable)
 		return;
 
 	switch (inst) {
@@ -370,7 +391,7 @@ static void dccg35_set_dppclk_rcg(struct dccg *dccg,
 
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp && enable)
 		return;
 
 	switch (inst) {
@@ -399,7 +420,7 @@ static void dccg35_set_dpstreamclk_rcg(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream && enable)
 		return;
 
 	switch (inst) {
@@ -436,7 +457,7 @@ static void dccg35_set_smclk32_se_rcg(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se && enable)
 		return;
 
 	switch (inst) {
@@ -1693,6 +1714,12 @@ static void dccg35_disable_symclk32_se(
 	}
 }
 
+static void dccg35_init_cb(struct dccg *dccg)
+{
+	(void)dccg;
+	/* Any RCG should be done when driver enter low power mode*/
+}
+
 void dccg35_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -2024,8 +2051,6 @@ static void dccg35_set_dpstreamclk_cb(
 	enum dtbclk_source dtb_clk_src;
 	enum dp_stream_clk_source dp_stream_clk_src;
 
-	ASSERT(otg_inst >= DP_STREAM_DTBCLK_P5);
-
 	switch (src) {
 	case REFCLK:
 		dtb_clk_src = DTBCLK_REFCLK;
@@ -2080,6 +2105,13 @@ static void dccg35_update_dpp_dto_cb(struct dccg *dccg, int dpp_inst,
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst]) {
+		/*
+		 * Do not update the DPPCLK DTO if the clock is stopped.
+		 */
+		return;
+	}
+
 	if (dccg->ref_dppclk && req_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
 		int modulo, phase;
@@ -2107,19 +2139,20 @@ static void dccg35_update_dpp_dto_cb(struct dccg *dccg, int dpp_inst,
 }
 
 static void dccg35_dpp_root_clock_control_cb(
-		struct dccg *dccg,
-		unsigned int dpp_inst,
-		bool power_on)
+	struct dccg *dccg,
+	unsigned int dpp_inst,
+	bool power_on)
 {
+	if (dccg->dpp_clock_gated[dpp_inst] == power_on)
+		return;
 	/* power_on set indicates we need to ungate
 	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
 	 * Since clock source is not passed restore to refclock on ungate
 	 * Redundant as gating when enabled is acheived through update_dpp_dto
 	 */
-	if (power_on)
-		dccg35_enable_dpp_clk_new(dccg, dpp_inst, DPP_REFCLK);
-	else
-		dccg35_disable_dpp_clk_new(dccg, dpp_inst);
+	dccg35_set_dppclk_rcg(dccg, dpp_inst, !power_on);
+
+	dccg->dpp_clock_gated[dpp_inst] = !power_on;
 }
 
 static void dccg35_enable_symclk32_se_cb(
@@ -2311,7 +2344,7 @@ static const struct dccg_funcs dccg35_funcs_new = {
 	.update_dpp_dto = dccg35_update_dpp_dto_cb,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control_cb,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
-	.dccg_init = dccg35_init,
+	.dccg_init = dccg35_init_cb,
 	.set_dpstreamclk = dccg35_set_dpstreamclk_cb,
 	.set_dpstreamclk_root_clock_gating = dccg35_set_dpstreamclk_root_clock_gating_cb,
 	.enable_symclk32_se = dccg35_enable_symclk32_se_cb,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 7ed75c5fe25e..f3ea32820a40 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -147,37 +147,6 @@ void dcn35_init_hw(struct dc *dc)
 		hws->funcs.bios_golden_init(dc);
 	}
 
-	if (!dc->debug.disable_clock_gate) {
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2,  0);
-
-		/* Disable gating for PHYASYMCLK. This will be enabled in dccg if needed */
-		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, 1,
-				PHYBSYMCLK_ROOT_GATE_DISABLE, 1,
-				PHYCSYMCLK_ROOT_GATE_DISABLE, 1,
-				PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
-				PHYESYMCLK_ROOT_GATE_DISABLE, 1);
-
-		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL4,
-				DPIASYMCLK0_GATE_DISABLE, 0,
-				DPIASYMCLK1_GATE_DISABLE, 0,
-				DPIASYMCLK2_GATE_DISABLE, 0,
-				DPIASYMCLK3_GATE_DISABLE, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0xFFFFFFFF);
-		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
-				DTBCLK_P0_GATE_DISABLE, 0,
-				DTBCLK_P1_GATE_DISABLE, 0,
-				DTBCLK_P2_GATE_DISABLE, 0,
-				DTBCLK_P3_GATE_DISABLE, 0);
-		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
-				DPSTREAMCLK0_GATE_DISABLE, 0,
-				DPSTREAMCLK1_GATE_DISABLE, 0,
-				DPSTREAMCLK2_GATE_DISABLE, 0,
-				DPSTREAMCLK3_GATE_DISABLE, 0);
-
-	}
-
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
@@ -309,20 +278,6 @@ void dcn35_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_FE_GATE_DISABLE, 0,
-				SYMCLKB_FE_GATE_DISABLE, 0,
-				SYMCLKC_FE_GATE_DISABLE, 0,
-				SYMCLKD_FE_GATE_DISABLE, 0,
-				SYMCLKE_FE_GATE_DISABLE, 0);
-		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2, HDMICHARCLK0_GATE_DISABLE, 0);
-		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_GATE_DISABLE, 0,
-				SYMCLKB_GATE_DISABLE, 0,
-				SYMCLKC_GATE_DISABLE, 0,
-				SYMCLKD_GATE_DISABLE, 0,
-				SYMCLKE_GATE_DISABLE, 0);
-
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
 
-- 
2.46.0

