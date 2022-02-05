Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372B2C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAB110E31D;
	Sat,  5 Feb 2022 01:51:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16F510E31D
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQl8ERbP4XkDY3duCXLaV3qNldHVx6Nn7SfI85yjrqHpIHeDzsWLSPS40PYfe1a12Sih7OMdjp3Yl4YwNBziO0//C+LOwsgX0yoKQ13BRtCgXF8HnyjcqwmHlB4eBukyDdxiCpiSSMQ7yhCtT4vVV/Iu/Z7zwsr5i8Ahm5/edKbghMlkeOLn42BcP/hmTejYSPsPlxnlJXcqSQiLQi/Bzdj/tOM+9D8IU1BDoAS5vc8LGK4AClVjip3FW9VdWmeb8VckYbopK8n0yHG6v/vO7IbW8t+mOgbNeP7iaphxWKLGcXq744j61Y1uTem3uNO9mr4uFKldR7jvEgziLZvtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmrJIq20LMDaSlikLYg+v0klhr9uiKewVmdkHLxoMoY=;
 b=NLuU5HKcXv2KsRvW//7ygSv6VNJ5MU93c3bLli3xldZ0zKH5FRDvPytdL/YqlMxWy/ByDakJZhDUvpe4NzMuTjRI3M1Uz3Vdl4/VcWxPB3qMUKLGo4DrNhx3dKHdpgs6AgoZtIFF95ZFR3Y1Byrk5ZO9PtNvHngAU2EGDOnTufo9M31JsnZ8OcNHxncdYOXFDjLbmFuVEy/WadLU+DymWVPhQpxU3SP2PWI7gYQ1sOEsYEmJ7A/kJ+K6hskG52eziyT/C4zxtdjR4xZguGG7405h6jPYE4B7TiDEoRHhKTu3fFYN0P9/0YwdNWVLj073zbXx+gSN2ZOHLa/bjKJs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmrJIq20LMDaSlikLYg+v0klhr9uiKewVmdkHLxoMoY=;
 b=3jo/RNmKlZCwuSYhyAfD2VBojz+Hwe55NTthMfgtAHh35Zq8cEcIPsIDhNgiaPSrRbyFn6G9gEoBHg+vVJo3FOC8mzvPwkq41uOTBspWm/inJTFn2dNFcFgBQpdUo4s8Mu0I1CgDPhAKCpKoFa4vbtBV5VS+HPGKEt3KPrRve9Y=
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by DM6PR12MB4794.namprd12.prod.outlook.com (2603:10b6:5:163::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sat, 5 Feb
 2022 01:50:57 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::7e) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:56 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:55 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: fix yellow carp wm clamping
Date: Fri, 4 Feb 2022 20:50:22 -0500
Message-ID: <20220205015029.143768-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9839a43a-21e4-45c3-da6e-08d9e849f3d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4794:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB479488E519FC3797F67AA357FB2A9@DM6PR12MB4794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIdgS0e0YUR2g5gqQZA+BRvakzLHKOQtVZti75kvKFJyqBMmKmNW4X0NPPgKUxHM2IoHur+S2hlT2L44uvAX8FGCuBw3zC+WtuO+1C8fvs0VimlIoV1OgnIIGtuBiWZ0Yjpm22KuI1D1JfRaTHY2+LHngxT+WbcjApOJpxq+i2rrgyll06R5rrD6aIuTCWAiMy3ayyfJGGio3depftJiMGCMd6xhZ2cq/BjLD5a3u9mj3rtYh2rVkydv7a/LTLaj9+RIGDDNC4KKkzruKJ4T/HXr79QLaeNQOy9ZCW7iQV23mhsH4/w4LKP5n1WIsVCT9pTnTS9ZhPRryffpykefCOBqTosfAFNYPdfDIwGrsJGy4JDT79EM3to6v2okuJ2EQB0P8h4ujoAK+Je7xGqJWzDZzUcZbSHuJAxlNJVzO/FAYQvBi20SIT8EStmyVbwp4noF1+oEZuvCpEDronCHOPYosUHgzv6OjhEXNo7wTPDShEWpDJlfyxYaOKpG2JEUUytk+F/fgMulxDjhaL3WFjXUjbNvm3dTiGAr3LL5xl9cX6aEc+fQFIPeF4XVDLeRDLRUEY3Do1K292R64E5YeInLZ4GhHMsvq3wYnJf+p8fbgDQgnxNCuhcyTyLRh4VI79Tz2em/LhRQQISzbOlGBtQkRDPmB6b0NjU4/XuoK6fOTYQ6b/ndTMvoBxR8HZZsOXcbE28s9tLhVmqxkg5PWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(426003)(5660300002)(81166007)(26005)(36860700001)(47076005)(336012)(186003)(82310400004)(1076003)(2616005)(16526019)(356005)(508600001)(30864003)(4326008)(6916009)(54906003)(70586007)(70206006)(8936002)(8676002)(36756003)(6666004)(2906002)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:56.8830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9839a43a-21e4-45c3-da6e-08d9e849f3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4794
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Fix clamping to match register field size

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 61 ++++++++++---------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 90c73a1cb986..5e3bcaf12cac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -138,8 +138,11 @@ static uint32_t convert_and_clamp(
 	ret_val = wm_ns * refclk_mhz;
 	ret_val /= 1000;
 
-	if (ret_val > clamp_value)
+	if (ret_val > clamp_value) {
+		/* clamping WMs is abnormal, unexpected and may lead to underflow*/
+		ASSERT(0);
 		ret_val = clamp_value;
+	}
 
 	return ret_val;
 }
@@ -159,7 +162,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->a.urgent_ns > hubbub2->watermarks.a.urgent_ns) {
 		hubbub2->watermarks.a.urgent_ns = watermarks->a.urgent_ns;
 		prog_wm_value = convert_and_clamp(watermarks->a.urgent_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, 0,
 				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, prog_wm_value);
 
@@ -193,7 +196,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->a.urgent_latency_ns > hubbub2->watermarks.a.urgent_latency_ns) {
 		hubbub2->watermarks.a.urgent_latency_ns = watermarks->a.urgent_latency_ns;
 		prog_wm_value = convert_and_clamp(watermarks->a.urgent_latency_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, prog_wm_value);
 	} else if (watermarks->a.urgent_latency_ns < hubbub2->watermarks.a.urgent_latency_ns)
@@ -203,7 +206,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->b.urgent_ns > hubbub2->watermarks.b.urgent_ns) {
 		hubbub2->watermarks.b.urgent_ns = watermarks->b.urgent_ns;
 		prog_wm_value = convert_and_clamp(watermarks->b.urgent_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, 0,
 				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, prog_wm_value);
 
@@ -237,7 +240,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->b.urgent_latency_ns > hubbub2->watermarks.b.urgent_latency_ns) {
 		hubbub2->watermarks.b.urgent_latency_ns = watermarks->b.urgent_latency_ns;
 		prog_wm_value = convert_and_clamp(watermarks->b.urgent_latency_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, prog_wm_value);
 	} else if (watermarks->b.urgent_latency_ns < hubbub2->watermarks.b.urgent_latency_ns)
@@ -247,7 +250,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->c.urgent_ns > hubbub2->watermarks.c.urgent_ns) {
 		hubbub2->watermarks.c.urgent_ns = watermarks->c.urgent_ns;
 		prog_wm_value = convert_and_clamp(watermarks->c.urgent_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, 0,
 				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, prog_wm_value);
 
@@ -281,7 +284,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->c.urgent_latency_ns > hubbub2->watermarks.c.urgent_latency_ns) {
 		hubbub2->watermarks.c.urgent_latency_ns = watermarks->c.urgent_latency_ns;
 		prog_wm_value = convert_and_clamp(watermarks->c.urgent_latency_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, prog_wm_value);
 	} else if (watermarks->c.urgent_latency_ns < hubbub2->watermarks.c.urgent_latency_ns)
@@ -291,7 +294,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->d.urgent_ns > hubbub2->watermarks.d.urgent_ns) {
 		hubbub2->watermarks.d.urgent_ns = watermarks->d.urgent_ns;
 		prog_wm_value = convert_and_clamp(watermarks->d.urgent_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, 0,
 				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, prog_wm_value);
 
@@ -325,7 +328,7 @@ static bool hubbub31_program_urgent_watermarks(
 	if (safe_to_lower || watermarks->d.urgent_latency_ns > hubbub2->watermarks.d.urgent_latency_ns) {
 		hubbub2->watermarks.d.urgent_latency_ns = watermarks->d.urgent_latency_ns;
 		prog_wm_value = convert_and_clamp(watermarks->d.urgent_latency_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0x3fff);
 		REG_SET(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, 0,
 				DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, prog_wm_value);
 	} else if (watermarks->d.urgent_latency_ns < hubbub2->watermarks.d.urgent_latency_ns)
@@ -351,7 +354,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_A calculated =%d\n"
@@ -367,7 +370,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->a.cstate_pstate.cstate_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_A calculated =%d\n"
@@ -383,7 +386,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_A calculated =%d\n"
@@ -399,7 +402,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->a.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_A calculated =%d\n"
@@ -416,7 +419,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_B calculated =%d\n"
@@ -432,7 +435,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->b.cstate_pstate.cstate_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_B calculated =%d\n"
@@ -448,7 +451,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_B calculated =%d\n"
@@ -464,7 +467,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->b.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_B calculated =%d\n"
@@ -481,7 +484,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_C calculated =%d\n"
@@ -497,7 +500,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->c.cstate_pstate.cstate_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_C calculated =%d\n"
@@ -513,7 +516,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_C calculated =%d\n"
@@ -529,7 +532,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->c.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_C calculated =%d\n"
@@ -546,7 +549,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_EXIT_WATERMARK_D calculated =%d\n"
@@ -562,7 +565,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->d.cstate_pstate.cstate_exit_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_exit_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_D calculated =%d\n"
@@ -578,7 +581,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_D calculated =%d\n"
@@ -594,7 +597,7 @@ static bool hubbub31_program_stutter_watermarks(
 				watermarks->d.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_D calculated =%d\n"
@@ -625,7 +628,7 @@ static bool hubbub31_program_pstate_watermarks(
 				watermarks->a.cstate_pstate.pstate_change_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.pstate_change_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, 0,
 				DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_A calculated =%d\n"
@@ -642,7 +645,7 @@ static bool hubbub31_program_pstate_watermarks(
 				watermarks->b.cstate_pstate.pstate_change_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.pstate_change_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, 0,
 				DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_B calculated =%d\n"
@@ -659,7 +662,7 @@ static bool hubbub31_program_pstate_watermarks(
 				watermarks->c.cstate_pstate.pstate_change_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.pstate_change_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, 0,
 				DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_C calculated =%d\n"
@@ -676,7 +679,7 @@ static bool hubbub31_program_pstate_watermarks(
 				watermarks->d.cstate_pstate.pstate_change_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.pstate_change_ns,
-				refclk_mhz, 0x1fffff);
+				refclk_mhz, 0xffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, 0,
 				DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("DRAM_CLK_CHANGE_WATERMARK_D calculated =%d\n"
-- 
2.25.1

