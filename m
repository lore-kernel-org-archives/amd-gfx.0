Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D2FC5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E8D10E7BB;
	Wed,  4 Jun 2025 19:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOC3hzcp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5248010E7BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRf2/iyRbbiXkhIxvj83CnUB/2PZCfZ6E1IRZ+6uLJRWBR+AVrLk2tCgS/PE2H9PsVSnPp7G6NILb7AnGFBsipPxt4QQaE/SM0RomVcMpmy/+RwK55VAKytiZYkIzAH5EhVmpEd5QC+jXsjvtKj0PGsKagylgjVjVHMopRZAVsPo+AQM1OfgdrjxgVHPFCuCHs2BaALze+mGauznZ2NJ/jQzxasQtGWRIa3hmiINqKU+dyilFJtY1/h6ErKY/rzDkUplCU+yXSAZucxEX0XTOnmk2voHOxsZanSgJprJ8Jyt2P7vFZB5mMeC0EVvgujWjmCAbUoYBl/56mQrFMoS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrB3rW5vgxQHmTFZm7eVWmuuPrCDGICqbbouAuU0VM4=;
 b=IKrLbjyDe0vSC+ib44kPn2HZhlt+djc5+UTfQDFKHVsH4aRMv+7b5MzBFyn/susAG2EIjUuTwS3gVB5mXfRz46ErULT+tb3eWJLS7drmzQ1tIortvbrQIKLQy18XAcOPLtFgiv/vxDPRpg9elROKE/oFSJIjyYSWwy6chbL6JUEOaxUeUAmi+X4rubLsSdMouamtisRw6ZeUSoIHi/shtuuJ0eUyBubzqZNN2Hpdg0iChCk7kKPHr0mBtlzRFtNbynbT/4AagGcl1JqSM/2LLNRKvYzZ1vWOqNIb1X8sNy6n+kWr7D/34YY4M5ay1mn9qUEVfwtyjfSdXHMmpa8Nlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrB3rW5vgxQHmTFZm7eVWmuuPrCDGICqbbouAuU0VM4=;
 b=yOC3hzcp32InkdGID6P+xFpky5VPvJNteUh6v7/YiogQe7TtAWVbdoDyA9c88gafGvgjOKWHdVNaJkVLrQd//VEOoS9dyxPp5F8sBBFQTL12k5ICj+aE/6Nlu5lqMJp6b/qi7ndWjAKoiLJIifYZ1YFH9QUvI7xFAIrtyyMTp3U=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:39:23 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::fc) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Wed,
 4 Jun 2025 19:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:39:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:39:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ryan Seto
 <ryanseto@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 09/23] drm/amd/display: Clear DPP 3DLUT Cap
Date: Wed, 4 Jun 2025 12:43:20 -0600
Message-ID: <20250604193659.2462225-10-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: ab72b4af-255c-45fe-a0e5-08dda39f8254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opi0Ml6cd8zGTLOqW+visBczv0glajmnW/sPaSmQtxWz/Sh9oY61Gfa6jnm0?=
 =?us-ascii?Q?mm/EXVwr7hRpbtM8ZCeVwn47Uc/Eeibs8UQNpRw7HxrmzM3Axcy9nHcRZVj8?=
 =?us-ascii?Q?2tre8HMm+riuJVyYiCPptFL/afKJi/XmVKSL2apQ0G3ere6aKcXoVzASmtm6?=
 =?us-ascii?Q?WyvjoAkdwR/XsIPOIoTdbfk7GqlQkAbcRFDLpcU50kBAydCwDtT1ThHlF5kH?=
 =?us-ascii?Q?vABidaJdt4SKfZ0ChBIecPlOPsrycRwzy4DBpkzViCNo3ONkHg1j5kGf/SE7?=
 =?us-ascii?Q?D82SFqxbtIyZNnoNTWErgQalPThaCyPCzIhpSnUyUu5Hdz9R0UBt7+Nwexm1?=
 =?us-ascii?Q?PHBkT1cWYJQCqy2stZ605apuWwbr8py36gqWiylGu7i9LTYSDwnJixNHTBwo?=
 =?us-ascii?Q?UHqjDmDfy3whCm5Qua6Qzsr08uIIDli2JHfuLsGW7nAN8dADeccDBcsIOdb1?=
 =?us-ascii?Q?0oP650sxloLjpk5EPz6TnoIjBZ+9X2CSzU5OmGj3Z5DQohFadnwKzf6giXKd?=
 =?us-ascii?Q?KPbmhR0YTGhd/ohtwSKysNwIkjHUmsLJkKClaW48T1STj6Wwf6Xyv4ySqanD?=
 =?us-ascii?Q?sofFnjkTbXzOQbSd6gBu8QsxjEnPDAvmQip504/3Ccu+bx6PjXmHWQIXBehG?=
 =?us-ascii?Q?9r8GTBLUBwTSq/tynkgLRtP8AI/vaFhNfxXKEXh4PuE3YkVMEfxZxDOhn1Ye?=
 =?us-ascii?Q?sihtOrV/nD4X8sUL1OIVrzavYt3aDmYT9JRXgGephn9brDsopQwaCfyy/N+8?=
 =?us-ascii?Q?BZy8jzJIJ5qyFSmX47qeLkbvgLnRgrSZVmwZnPTkBHwIUr2rsmaI5ZTVxyyD?=
 =?us-ascii?Q?/i9c2cCXKL/E2kHTXizeL/NhJVY3qEnKEjKV2A1apvxe5mI42aTR238yLNiN?=
 =?us-ascii?Q?svZCSDymRbAhtBqaPbOgu0STZQJGvl8A0ImW30/71cOu817CbdchXlmHMtFd?=
 =?us-ascii?Q?2cDoLZSC4nlhFrnwpaqS1aInXJ2Sf/8NeLgv43gGYEffPZvAMAPNPKDZtniP?=
 =?us-ascii?Q?TNaJY/rqCOsUwYOrVrVVXzRDu773HbJO/ictwgi6vLixzIA7wcmBjMNmjm8Z?=
 =?us-ascii?Q?mcacMLmUpcgFHBC2/9cYZuaNzN9Dc6MeGlxfffJgtM3Ys82BCAsJjGuuL2wh?=
 =?us-ascii?Q?O8Mb23UyIkvt1ptfDrYPGDLgUPzU+Zp25kcgCStYD917X82CCXLWy0GELNGQ?=
 =?us-ascii?Q?fRow1MQyJIf4MwNZ8jmY+UOMmSgmHs/Muj7MOeyGUzou3Zu69uuVUwppiud1?=
 =?us-ascii?Q?NEb5OBzjf7tt7EmKnVK+8p1TQK4bszA0FWT0bOPnm6Uctv0EwUfX2Uhsx6lA?=
 =?us-ascii?Q?WSCEt9mt02eiiCs8r3cB5evdy983ysN+t90Lox0EDUnJsqudr0gTDxSlLSQa?=
 =?us-ascii?Q?5n3lvE0pQMGjMTRejY2h27XGNDzIJJBPj/2HnSE0/3sT8ylX//dRVpMsPERn?=
 =?us-ascii?Q?gCroeMbgYIx/ioMtC+yMsULmlkrhNLIlgNbp0enC0U4pKaQQTDWU1Dm2CLHj?=
 =?us-ascii?Q?3Q8QN2FO8LxupoddkiS7HAkcJwlUjbBikkHj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:39:23.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab72b4af-255c-45fe-a0e5-08dda39f8254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

From: Ryan Seto <ryanseto@amd.com>

[WHY & HOW]
Clear DPP 3DLUT Cap flag on ASICs that do not use it

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c | 5 +++--
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c   | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c   | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 7 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fc36beb66d49..4f162905475d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -245,6 +245,7 @@ struct mpc_color_caps {
 	struct rom_curve_caps ogam_rom_caps;
 	struct lut3d_caps mcm_3d_lut_caps;
 	struct lut3d_caps rmcm_3d_lut_caps;
+	bool preblend;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 363e4a094534..d2d321eec221 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2251,7 +2251,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
 	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
@@ -2270,6 +2270,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index ae5a58a48d73..c2f12030928f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1755,8 +1755,8 @@ static bool dcn321_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
+	dc->caps.color.dpp.ogam_ram = 0;
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
@@ -1774,6 +1774,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1f20069018ca..353189ac0d53 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1874,7 +1874,7 @@ static bool dcn35_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
 	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
 	// no OGAM ROM on DCN301
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
@@ -1893,6 +1893,7 @@ static bool dcn35_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 6266fc77c7eb..f9fd36567130 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1846,7 +1846,7 @@ static bool dcn351_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
 	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
 	// no OGAM ROM on DCN301
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
@@ -1865,6 +1865,7 @@ static bool dcn351_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 10d3182b3058..37b18575c376 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1847,7 +1847,7 @@ static bool dcn36_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
 	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
 	// no OGAM ROM on DCN301
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
@@ -1866,6 +1866,7 @@ static bool dcn36_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index b0cf5c9c1cad..14f478df268a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1948,6 +1948,7 @@ static bool dcn401_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
 	dc->config.use_spl = true;
 	dc->config.prefer_easf = true;
 
-- 
2.43.0

