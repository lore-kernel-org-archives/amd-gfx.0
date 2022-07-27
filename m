Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBADBC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8ACC7BD1;
	Wed, 27 Jul 2022 22:19:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43338C7846
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJCxi0AS98ODMaa6Q2pvEIa7xYVvmC16e2UzQczP6F7BSNdp9pPYoTA9opbio1MIjbddEAxXPJHQlBf+jheQeBcI5TwxvBeNDBYzG+HTfEFwfjbXLRf0lngSBCAiJdenzLjISk6s5FcAGhNhShIjzlum7GLoROr2jBd7GyH2Uoi4kRDjodkYClc12VDY8MuQeyWT2PmLki+0ijZlbBYVTLM42Iv2fCQFpX6YYBMpwoXiEJ5xplzTzyuUJlo/SnPILfwo9oSI+PTX00de4O6K9ysRs8Ie0WoXegq2g92qr0E8bx9GmhZYaeX8gPhplqIVLx2OKsxCydIsjMErpNr5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7WNY3IWgzsGCoc41WK247bc6FfovxpR6PFprFVLQAQ=;
 b=cviNMe74dTTGXg6heOD8eNLbRA0ABj0QQMOQxc30Y8D7+Zne/MQH62fegVP5qgPK+7+9ONfyKQB1zlTPHY1ZVPBtebXNmIZ9IGDNfdgKWKkwLdE6PXdyJ8Ghze/UAiEksH1Z5uf0424nd8JhZ3kYsd3gKU3UH5QNisShBbVXNmJHcG9BhPUET7935lcqy/NlKy2Xq+A/OOI8rW1VndcDdvssb8qw74OEH0gxdMyr20mElWLeQfebeHDtT+r8Heo+i5Kq8oVgZ0bOJaRGV9xVhtiq8sfzDqFUvOltBiM5YTIUOLJAoRt/Asoi+UbyL/xYPr288TthW3M4W1MPCx12Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7WNY3IWgzsGCoc41WK247bc6FfovxpR6PFprFVLQAQ=;
 b=N+mEsPT7iyaLQZX1t2vxy6XWc3weyekEeRRPqlmmJ5yQ4h7OvAepDSZQC63CHY++b4rXMtRh9xJOaxMilJVVI1t0FfvngPzPwMt39F4YTfcW3LbNUJzmSYEiQd6s1ps6LkqV6yh9DShcRrhkmfOeVWnaXmIkC6wZZu4XCSEXbHw=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 22:19:24 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::d0) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 22:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 22:19:23 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 17:19:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] Revert "drm/amd/display: reduce stack for
 dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
Date: Wed, 27 Jul 2022 18:18:53 -0400
Message-ID: <20220727221855.324361-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
References: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb94c57b-c626-4c4e-55d9-08da701e0f8d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCuprBbnzM46ki6JJRhF1e14UK2+hAywi7Ev4ivmnfAkA75pgMQzLuH2oMB3PnnyLKma/wKbV+7dkKmMlYcad6ynyetADIdLlbs4KP/0NTjrArFvJdjE3ggwNkKVC3EqL5fBAAouEr8PAhMtSMAgFds1O+yz2EZoRG59lT5i1l84Fg0CfTWO5Wv61FycKAz2dpLAYb2197GjufjFINuwB/+z8bEzQRwAvq0Q89tWj1Zw6EVXj/J84Ts6DYYVC/NIXIWSoDr+E4iJGrz6ZCbxy/26hdN0Kph3Aq04IkLfGRl97ueruI78QpDr2ehgFACsAPncSSk05ybA5Ke1OKsWdQ50uXq0C3N3pSWQYUxmM7nUwIXKC3EqRKXRpHItOtfj6OrvG/9sTy7IAeekdwRHi8ul51xcFBbhKlRgBEjy6FkfkuwW6r5zqALBF2ZGr2lbIuzxT9GNAHxBKlb5Ado0vpi7fJqM9zz8sWMtUBk6gxcWi7gDjJ+phhYeG5dLCZyh4+rM44mVTz6ocL7GMvX+ZTt3fA3R3FKwWyCY6k1c3HQaLSz1yQHn2sg5ibKDnYapMPFErG0jSm4cJ2LZkKH8R/oqk8AMn5CXh86vJxtXhPt24IGX5Ka+r6e8ijEk42gHYvada/xRVeOI4HIIdK+fEaHFAlArcmX1XqGL1myRErs9g1+vvRtN+ClGYwTUQxU99yviobFAv9ceJnErb4ZCvtxXbgtR/RKbVv+1EW01BqgmUGwI6TjLNttef1mnLjKCteSDN86stxHMTg3xS3Q5xWOXNJdWh8Py9JTA3FN/9D4pmnWxK1r8rMatMWbF/dSnxNQrivlrGzJN/35hLB3X2u1VGOZnXE1SfnAzCujlLK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(40470700004)(36840700001)(46966006)(19627235002)(2616005)(83380400001)(316002)(478600001)(47076005)(36860700001)(41300700001)(1076003)(8936002)(2906002)(40460700003)(6916009)(40480700001)(54906003)(8676002)(70206006)(30864003)(82740400003)(82310400005)(86362001)(4326008)(336012)(356005)(186003)(5660300002)(70586007)(7696005)(26005)(16526019)(6666004)(81166007)(36756003)(426003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:19:23.6722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb94c57b-c626-4c4e-55d9-08da701e0f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: Leo Li <sunpeng.li@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f2dbf5a4dd1eaa8893afe7a970cd89f075316d18.

This commit was a part of a patchset responsible for reducing the stack
size. However, after some other changes, this commit becomes
unnecessary, so we are reverting it here.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 187 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  34 ----
 4 files changed, 104 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 04f1eefdabe8..55f351d5b610 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1165,7 +1165,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
 
 		dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
-			&v->dummy_vars.dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport,
 			mode_lib->vba.USRRetrainingRequiredFinal,
 			mode_lib->vba.UsesMALLForPStateChange,
 			mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
@@ -3563,7 +3562,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 			{
 				dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
-						&v->dummy_vars.dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport,
 						mode_lib->vba.USRRetrainingRequiredFinal,
 						mode_lib->vba.UsesMALLForPStateChange,
 						mode_lib->vba.PrefetchModePerState[i][j],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 54dde0ea424a..c0dab2b2c446 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4185,7 +4185,6 @@ void dml32_CalculateFlipSchedule(
 } // CalculateFlipSchedule
 
 void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
-		struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport *st_vars,
 		bool USRRetrainingRequiredFinal,
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int PrefetchMode,
@@ -4247,15 +4246,37 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 		double ActiveDRAMClockChangeLatencyMargin[])
 {
 	unsigned int i, j, k;
-
-	st_vars->SurfaceWithMinActiveFCLKChangeMargin = 0;
-	st_vars->DRAMClockChangeSupportNumber = 0;
-	st_vars->DRAMClockChangeMethod = 0;
-	st_vars->FoundFirstSurfaceWithMinActiveFCLKChangeMargin = false;
-	st_vars->MinActiveFCLKChangeMargin = 0.;
-	st_vars->SecondMinActiveFCLKChangeMarginOneDisplayInVBLank = 0.;
-	st_vars->TotalPixelBW = 0.0;
-	st_vars->TotalActiveWriteback = 0;
+	unsigned int SurfaceWithMinActiveFCLKChangeMargin = 0;
+	unsigned int DRAMClockChangeSupportNumber = 0;
+	unsigned int LastSurfaceWithoutMargin;
+	unsigned int DRAMClockChangeMethod = 0;
+	bool FoundFirstSurfaceWithMinActiveFCLKChangeMargin = false;
+	double MinActiveFCLKChangeMargin = 0.;
+	double SecondMinActiveFCLKChangeMarginOneDisplayInVBLank = 0.;
+	double ActiveClockChangeLatencyHidingY;
+	double ActiveClockChangeLatencyHidingC;
+	double ActiveClockChangeLatencyHiding;
+    double EffectiveDETBufferSizeY;
+	double     ActiveFCLKChangeLatencyMargin[DC__NUM_DPP__MAX];
+	double     USRRetrainingLatencyMargin[DC__NUM_DPP__MAX];
+	double TotalPixelBW = 0.0;
+	bool    SynchronizedSurfaces[DC__NUM_DPP__MAX][DC__NUM_DPP__MAX];
+	double     EffectiveLBLatencyHidingY;
+	double     EffectiveLBLatencyHidingC;
+	double     LinesInDETY[DC__NUM_DPP__MAX];
+	double     LinesInDETC[DC__NUM_DPP__MAX];
+	unsigned int    LinesInDETYRoundedDownToSwath[DC__NUM_DPP__MAX];
+	unsigned int    LinesInDETCRoundedDownToSwath[DC__NUM_DPP__MAX];
+	double     FullDETBufferingTimeY;
+	double     FullDETBufferingTimeC;
+	double     WritebackDRAMClockChangeLatencyMargin;
+	double     WritebackFCLKChangeLatencyMargin;
+	double     WritebackLatencyHiding;
+	bool    SameTimingForFCLKChange;
+
+	unsigned int    TotalActiveWriteback = 0;
+	unsigned int LBLatencyHidingSourceLinesY[DC__NUM_DPP__MAX];
+	unsigned int LBLatencyHidingSourceLinesC[DC__NUM_DPP__MAX];
 
 	Watermark->UrgentWatermark = mmSOCParameters.UrgentLatency + mmSOCParameters.ExtraLatency;
 	Watermark->USRRetrainingWatermark = mmSOCParameters.UrgentLatency + mmSOCParameters.ExtraLatency
@@ -4287,13 +4308,13 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 #endif
 
 
-	st_vars->TotalActiveWriteback = 0;
+	TotalActiveWriteback = 0;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (WritebackEnable[k] == true)
-			st_vars->TotalActiveWriteback = st_vars->TotalActiveWriteback + 1;
+			TotalActiveWriteback = TotalActiveWriteback + 1;
 	}
 
-	if (st_vars->TotalActiveWriteback <= 1) {
+	if (TotalActiveWriteback <= 1) {
 		Watermark->WritebackUrgentWatermark = mmSOCParameters.WritebackLatency;
 	} else {
 		Watermark->WritebackUrgentWatermark = mmSOCParameters.WritebackLatency
@@ -4303,7 +4324,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 		Watermark->WritebackUrgentWatermark = Watermark->WritebackUrgentWatermark
 				+ mmSOCParameters.USRRetrainingLatency;
 
-	if (st_vars->TotalActiveWriteback <= 1) {
+	if (TotalActiveWriteback <= 1) {
 		Watermark->WritebackDRAMClockChangeWatermark = mmSOCParameters.DRAMClockChangeLatency
 				+ mmSOCParameters.WritebackLatency;
 		Watermark->WritebackFCLKChangeWatermark = mmSOCParameters.FCLKChangeLatency
@@ -4333,14 +4354,14 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 #endif
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		st_vars->TotalPixelBW = st_vars->TotalPixelBW + DPPPerSurface[k] * (SwathWidthY[k] * BytePerPixelDETY[k] * VRatio[k] +
+		TotalPixelBW = TotalPixelBW + DPPPerSurface[k] * (SwathWidthY[k] * BytePerPixelDETY[k] * VRatio[k] +
 				SwathWidthC[k] * BytePerPixelDETC[k] * VRatioChroma[k]) / (HTotal[k] / PixelClock[k]);
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 
-		st_vars->LBLatencyHidingSourceLinesY[k] = dml_min((double) MaxLineBufferLines, dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthY[k] / dml_max(HRatio[k], 1.0)), 1)) - (VTaps[k] - 1);
-		st_vars->LBLatencyHidingSourceLinesC[k] = dml_min((double) MaxLineBufferLines, dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthC[k] / dml_max(HRatioChroma[k], 1.0)), 1)) - (VTapsChroma[k] - 1);
+		LBLatencyHidingSourceLinesY[k] = dml_min((double) MaxLineBufferLines, dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthY[k] / dml_max(HRatio[k], 1.0)), 1)) - (VTaps[k] - 1);
+		LBLatencyHidingSourceLinesC[k] = dml_min((double) MaxLineBufferLines, dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthC[k] / dml_max(HRatioChroma[k], 1.0)), 1)) - (VTapsChroma[k] - 1);
 
 
 #ifdef __DML_VBA_DEBUG__
@@ -4351,72 +4372,72 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 		dml_print("DML::%s: k=%d, VTaps              = %d\n", __func__, k, VTaps[k]);
 #endif
 
-		st_vars->EffectiveLBLatencyHidingY = st_vars->LBLatencyHidingSourceLinesY[k] / VRatio[k] * (HTotal[k] / PixelClock[k]);
-		st_vars->EffectiveLBLatencyHidingC = st_vars->LBLatencyHidingSourceLinesC[k] / VRatioChroma[k] * (HTotal[k] / PixelClock[k]);
-		st_vars->EffectiveDETBufferSizeY = DETBufferSizeY[k];
+		EffectiveLBLatencyHidingY = LBLatencyHidingSourceLinesY[k] / VRatio[k] * (HTotal[k] / PixelClock[k]);
+		EffectiveLBLatencyHidingC = LBLatencyHidingSourceLinesC[k] / VRatioChroma[k] * (HTotal[k] / PixelClock[k]);
+		EffectiveDETBufferSizeY = DETBufferSizeY[k];
 
 		if (UnboundedRequestEnabled) {
-			st_vars->EffectiveDETBufferSizeY = st_vars->EffectiveDETBufferSizeY
+			EffectiveDETBufferSizeY = EffectiveDETBufferSizeY
 					+ CompressedBufferSizeInkByte * 1024
 							* (SwathWidthY[k] * BytePerPixelDETY[k] * VRatio[k])
-							/ (HTotal[k] / PixelClock[k]) / st_vars->TotalPixelBW;
+							/ (HTotal[k] / PixelClock[k]) / TotalPixelBW;
 		}
 
-		st_vars->LinesInDETY[k] = (double) st_vars->EffectiveDETBufferSizeY / BytePerPixelDETY[k] / SwathWidthY[k];
-		st_vars->LinesInDETYRoundedDownToSwath[k] = dml_floor(st_vars->LinesInDETY[k], SwathHeightY[k]);
-		st_vars->FullDETBufferingTimeY = st_vars->LinesInDETYRoundedDownToSwath[k] * (HTotal[k] / PixelClock[k]) / VRatio[k];
+		LinesInDETY[k] = (double) EffectiveDETBufferSizeY / BytePerPixelDETY[k] / SwathWidthY[k];
+		LinesInDETYRoundedDownToSwath[k] = dml_floor(LinesInDETY[k], SwathHeightY[k]);
+		FullDETBufferingTimeY = LinesInDETYRoundedDownToSwath[k] * (HTotal[k] / PixelClock[k]) / VRatio[k];
 
-		st_vars->ActiveClockChangeLatencyHidingY = st_vars->EffectiveLBLatencyHidingY + st_vars->FullDETBufferingTimeY
+		ActiveClockChangeLatencyHidingY = EffectiveLBLatencyHidingY + FullDETBufferingTimeY
 				- (DSTXAfterScaler[k] / HTotal[k] + DSTYAfterScaler[k]) * HTotal[k] / PixelClock[k];
 
 		if (NumberOfActiveSurfaces > 1) {
-			st_vars->ActiveClockChangeLatencyHidingY = st_vars->ActiveClockChangeLatencyHidingY
+			ActiveClockChangeLatencyHidingY = ActiveClockChangeLatencyHidingY
 					- (1 - 1 / NumberOfActiveSurfaces) * SwathHeightY[k] * HTotal[k]
 							/ PixelClock[k] / VRatio[k];
 		}
 
 		if (BytePerPixelDETC[k] > 0) {
-			st_vars->LinesInDETC[k] = DETBufferSizeC[k] / BytePerPixelDETC[k] / SwathWidthC[k];
-			st_vars->LinesInDETCRoundedDownToSwath[k] = dml_floor(st_vars->LinesInDETC[k], SwathHeightC[k]);
-			st_vars->FullDETBufferingTimeC = st_vars->LinesInDETCRoundedDownToSwath[k] * (HTotal[k] / PixelClock[k])
+			LinesInDETC[k] = DETBufferSizeC[k] / BytePerPixelDETC[k] / SwathWidthC[k];
+			LinesInDETCRoundedDownToSwath[k] = dml_floor(LinesInDETC[k], SwathHeightC[k]);
+			FullDETBufferingTimeC = LinesInDETCRoundedDownToSwath[k] * (HTotal[k] / PixelClock[k])
 					/ VRatioChroma[k];
-			st_vars->ActiveClockChangeLatencyHidingC = st_vars->EffectiveLBLatencyHidingC + st_vars->FullDETBufferingTimeC
+			ActiveClockChangeLatencyHidingC = EffectiveLBLatencyHidingC + FullDETBufferingTimeC
 					- (DSTXAfterScaler[k] / HTotal[k] + DSTYAfterScaler[k]) * HTotal[k]
 							/ PixelClock[k];
 			if (NumberOfActiveSurfaces > 1) {
-				st_vars->ActiveClockChangeLatencyHidingC = st_vars->ActiveClockChangeLatencyHidingC
+				ActiveClockChangeLatencyHidingC = ActiveClockChangeLatencyHidingC
 						- (1 - 1 / NumberOfActiveSurfaces) * SwathHeightC[k] * HTotal[k]
 								/ PixelClock[k] / VRatioChroma[k];
 			}
-			st_vars->ActiveClockChangeLatencyHiding = dml_min(st_vars->ActiveClockChangeLatencyHidingY,
-					st_vars->ActiveClockChangeLatencyHidingC);
+			ActiveClockChangeLatencyHiding = dml_min(ActiveClockChangeLatencyHidingY,
+					ActiveClockChangeLatencyHidingC);
 		} else {
-			st_vars->ActiveClockChangeLatencyHiding = st_vars->ActiveClockChangeLatencyHidingY;
+			ActiveClockChangeLatencyHiding = ActiveClockChangeLatencyHidingY;
 		}
 
-		ActiveDRAMClockChangeLatencyMargin[k] = st_vars->ActiveClockChangeLatencyHiding - Watermark->UrgentWatermark
+		ActiveDRAMClockChangeLatencyMargin[k] = ActiveClockChangeLatencyHiding - Watermark->UrgentWatermark
 				- Watermark->DRAMClockChangeWatermark;
-		st_vars->ActiveFCLKChangeLatencyMargin[k] = st_vars->ActiveClockChangeLatencyHiding - Watermark->UrgentWatermark
+		ActiveFCLKChangeLatencyMargin[k] = ActiveClockChangeLatencyHiding - Watermark->UrgentWatermark
 				- Watermark->FCLKChangeWatermark;
-		st_vars->USRRetrainingLatencyMargin[k] = st_vars->ActiveClockChangeLatencyHiding - Watermark->USRRetrainingWatermark;
+		USRRetrainingLatencyMargin[k] = ActiveClockChangeLatencyHiding - Watermark->USRRetrainingWatermark;
 
 		if (WritebackEnable[k]) {
-			st_vars->WritebackLatencyHiding = WritebackInterfaceBufferSize * 1024
+			WritebackLatencyHiding = WritebackInterfaceBufferSize * 1024
 					/ (WritebackDestinationWidth[k] * WritebackDestinationHeight[k]
 							/ (WritebackSourceHeight[k] * HTotal[k] / PixelClock[k]) * 4);
 			if (WritebackPixelFormat[k] == dm_444_64)
-				st_vars->WritebackLatencyHiding = st_vars->WritebackLatencyHiding / 2;
+				WritebackLatencyHiding = WritebackLatencyHiding / 2;
 
-			st_vars->WritebackDRAMClockChangeLatencyMargin = st_vars->WritebackLatencyHiding
+			WritebackDRAMClockChangeLatencyMargin = WritebackLatencyHiding
 					- Watermark->WritebackDRAMClockChangeWatermark;
 
-			st_vars->WritebackFCLKChangeLatencyMargin = st_vars->WritebackLatencyHiding
+			WritebackFCLKChangeLatencyMargin = WritebackLatencyHiding
 					- Watermark->WritebackFCLKChangeWatermark;
 
 			ActiveDRAMClockChangeLatencyMargin[k] = dml_min(ActiveDRAMClockChangeLatencyMargin[k],
-					st_vars->WritebackFCLKChangeLatencyMargin);
-			st_vars->ActiveFCLKChangeLatencyMargin[k] = dml_min(st_vars->ActiveFCLKChangeLatencyMargin[k],
-					st_vars->WritebackDRAMClockChangeLatencyMargin);
+					WritebackFCLKChangeLatencyMargin);
+			ActiveFCLKChangeLatencyMargin[k] = dml_min(ActiveFCLKChangeLatencyMargin[k],
+					WritebackDRAMClockChangeLatencyMargin);
 		}
 		MaxActiveDRAMClockChangeLatencySupported[k] =
 				(UseMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe) ?
@@ -4435,41 +4456,41 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 					HTotal[i] == HTotal[j] && VTotal[i] == VTotal[j] &&
 					VActive[i] == VActive[j]) || (SynchronizeDRRDisplaysForUCLKPStateChangeFinal &&
 					(DRRDisplay[i] || DRRDisplay[j]))) {
-				st_vars->SynchronizedSurfaces[i][j] = true;
+				SynchronizedSurfaces[i][j] = true;
 			} else {
-				st_vars->SynchronizedSurfaces[i][j] = false;
+				SynchronizedSurfaces[i][j] = false;
 			}
 		}
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if ((UseMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe) &&
-				(!st_vars->FoundFirstSurfaceWithMinActiveFCLKChangeMargin ||
-				st_vars->ActiveFCLKChangeLatencyMargin[k] < st_vars->MinActiveFCLKChangeMargin)) {
-			st_vars->FoundFirstSurfaceWithMinActiveFCLKChangeMargin = true;
-			st_vars->MinActiveFCLKChangeMargin = st_vars->ActiveFCLKChangeLatencyMargin[k];
-			st_vars->SurfaceWithMinActiveFCLKChangeMargin = k;
+				(!FoundFirstSurfaceWithMinActiveFCLKChangeMargin ||
+				ActiveFCLKChangeLatencyMargin[k] < MinActiveFCLKChangeMargin)) {
+			FoundFirstSurfaceWithMinActiveFCLKChangeMargin = true;
+			MinActiveFCLKChangeMargin = ActiveFCLKChangeLatencyMargin[k];
+			SurfaceWithMinActiveFCLKChangeMargin = k;
 		}
 	}
 
-	*MinActiveFCLKChangeLatencySupported = st_vars->MinActiveFCLKChangeMargin + mmSOCParameters.FCLKChangeLatency;
+	*MinActiveFCLKChangeLatencySupported = MinActiveFCLKChangeMargin + mmSOCParameters.FCLKChangeLatency;
 
-	st_vars->SameTimingForFCLKChange = true;
+	SameTimingForFCLKChange = true;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		if (!st_vars->SynchronizedSurfaces[k][st_vars->SurfaceWithMinActiveFCLKChangeMargin]) {
+		if (!SynchronizedSurfaces[k][SurfaceWithMinActiveFCLKChangeMargin]) {
 			if ((UseMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe) &&
-					(st_vars->SameTimingForFCLKChange ||
-					st_vars->ActiveFCLKChangeLatencyMargin[k] <
-					st_vars->SecondMinActiveFCLKChangeMarginOneDisplayInVBLank)) {
-				st_vars->SecondMinActiveFCLKChangeMarginOneDisplayInVBLank = st_vars->ActiveFCLKChangeLatencyMargin[k];
+					(SameTimingForFCLKChange ||
+					ActiveFCLKChangeLatencyMargin[k] <
+					SecondMinActiveFCLKChangeMarginOneDisplayInVBLank)) {
+				SecondMinActiveFCLKChangeMarginOneDisplayInVBLank = ActiveFCLKChangeLatencyMargin[k];
 			}
-			st_vars->SameTimingForFCLKChange = false;
+			SameTimingForFCLKChange = false;
 		}
 	}
 
-	if (st_vars->MinActiveFCLKChangeMargin > 0) {
+	if (MinActiveFCLKChangeMargin > 0) {
 		*FCLKChangeSupport = dm_fclock_change_vactive;
-	} else if ((st_vars->SameTimingForFCLKChange || st_vars->SecondMinActiveFCLKChangeMarginOneDisplayInVBLank > 0) &&
+	} else if ((SameTimingForFCLKChange || SecondMinActiveFCLKChangeMarginOneDisplayInVBLank > 0) &&
 			(PrefetchMode <= 1)) {
 		*FCLKChangeSupport = dm_fclock_change_vblank;
 	} else {
@@ -4479,7 +4500,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 	*USRRetrainingSupport = true;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if ((UseMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe) &&
-				(st_vars->USRRetrainingLatencyMargin[k] < 0)) {
+				(USRRetrainingLatencyMargin[k] < 0)) {
 			*USRRetrainingSupport = false;
 		}
 	}
@@ -4490,42 +4511,42 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 				UseMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe &&
 				ActiveDRAMClockChangeLatencyMargin[k] < 0) {
 			if (PrefetchMode > 0) {
-				st_vars->DRAMClockChangeSupportNumber = 2;
-			} else if (st_vars->DRAMClockChangeSupportNumber == 0) {
-				st_vars->DRAMClockChangeSupportNumber = 1;
-				st_vars->LastSurfaceWithoutMargin = k;
-			} else if (st_vars->DRAMClockChangeSupportNumber == 1 &&
-					!st_vars->SynchronizedSurfaces[st_vars->LastSurfaceWithoutMargin][k]) {
-				st_vars->DRAMClockChangeSupportNumber = 2;
+				DRAMClockChangeSupportNumber = 2;
+			} else if (DRAMClockChangeSupportNumber == 0) {
+				DRAMClockChangeSupportNumber = 1;
+				LastSurfaceWithoutMargin = k;
+			} else if (DRAMClockChangeSupportNumber == 1 &&
+					!SynchronizedSurfaces[LastSurfaceWithoutMargin][k]) {
+				DRAMClockChangeSupportNumber = 2;
 			}
 		}
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (UseMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame)
-			st_vars->DRAMClockChangeMethod = 1;
+			DRAMClockChangeMethod = 1;
 		else if (UseMALLForPStateChange[k] == dm_use_mall_pstate_change_sub_viewport)
-			st_vars->DRAMClockChangeMethod = 2;
+			DRAMClockChangeMethod = 2;
 	}
 
-	if (st_vars->DRAMClockChangeMethod == 0) {
-		if (st_vars->DRAMClockChangeSupportNumber == 0)
+	if (DRAMClockChangeMethod == 0) {
+		if (DRAMClockChangeSupportNumber == 0)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
-		else if (st_vars->DRAMClockChangeSupportNumber == 1)
+		else if (DRAMClockChangeSupportNumber == 1)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
 		else
 			*DRAMClockChangeSupport = dm_dram_clock_change_unsupported;
-	} else if (st_vars->DRAMClockChangeMethod == 1) {
-		if (st_vars->DRAMClockChangeSupportNumber == 0)
+	} else if (DRAMClockChangeMethod == 1) {
+		if (DRAMClockChangeSupportNumber == 0)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vactive_w_mall_full_frame;
-		else if (st_vars->DRAMClockChangeSupportNumber == 1)
+		else if (DRAMClockChangeSupportNumber == 1)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vblank_w_mall_full_frame;
 		else
 			*DRAMClockChangeSupport = dm_dram_clock_change_unsupported;
 	} else {
-		if (st_vars->DRAMClockChangeSupportNumber == 0)
+		if (DRAMClockChangeSupportNumber == 0)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vactive_w_mall_sub_vp;
-		else if (st_vars->DRAMClockChangeSupportNumber == 1)
+		else if (DRAMClockChangeSupportNumber == 1)
 			*DRAMClockChangeSupport = dm_dram_clock_change_vblank_w_mall_sub_vp;
 		else
 			*DRAMClockChangeSupport = dm_dram_clock_change_unsupported;
@@ -4539,7 +4560,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 
 		dst_y_pstate = dml_ceil((mmSOCParameters.DRAMClockChangeLatency + mmSOCParameters.UrgentLatency) / (HTotal[k] / PixelClock[k]), 1);
 		src_y_pstate_l = dml_ceil(dst_y_pstate * VRatio[k], SwathHeightY[k]);
-		src_y_ahead_l = dml_floor(DETBufferSizeY[k] / BytePerPixelDETY[k] / SwathWidthY[k], SwathHeightY[k]) + st_vars->LBLatencyHidingSourceLinesY[k];
+		src_y_ahead_l = dml_floor(DETBufferSizeY[k] / BytePerPixelDETY[k] / SwathWidthY[k], SwathHeightY[k]) + LBLatencyHidingSourceLinesY[k];
 		sub_vp_lines_l = src_y_pstate_l + src_y_ahead_l + meta_row_height[k];
 
 #ifdef __DML_VBA_DEBUG__
@@ -4547,7 +4568,7 @@ dml_print("DML::%s: k=%d, DETBufferSizeY               = %d\n", __func__, k, DET
 dml_print("DML::%s: k=%d, BytePerPixelDETY             = %f\n", __func__, k, BytePerPixelDETY[k]);
 dml_print("DML::%s: k=%d, SwathWidthY                  = %d\n", __func__, k, SwathWidthY[k]);
 dml_print("DML::%s: k=%d, SwathHeightY                 = %d\n", __func__, k, SwathHeightY[k]);
-dml_print("DML::%s: k=%d, LBLatencyHidingSourceLinesY  = %d\n", __func__, k, st_vars->LBLatencyHidingSourceLinesY[k]);
+dml_print("DML::%s: k=%d, LBLatencyHidingSourceLinesY  = %d\n", __func__, k, LBLatencyHidingSourceLinesY[k]);
 dml_print("DML::%s: k=%d, dst_y_pstate      = %d\n", __func__, k, dst_y_pstate);
 dml_print("DML::%s: k=%d, src_y_pstate_l    = %d\n", __func__, k, src_y_pstate_l);
 dml_print("DML::%s: k=%d, src_y_ahead_l     = %d\n", __func__, k, src_y_ahead_l);
@@ -4558,7 +4579,7 @@ dml_print("DML::%s: k=%d, sub_vp_lines_l    = %d\n", __func__, k, sub_vp_lines_l
 
 		if (BytePerPixelDETC[k] > 0) {
 			src_y_pstate_c = dml_ceil(dst_y_pstate * VRatioChroma[k], SwathHeightC[k]);
-			src_y_ahead_c = dml_floor(DETBufferSizeC[k] / BytePerPixelDETC[k] / SwathWidthC[k], SwathHeightC[k]) + st_vars->LBLatencyHidingSourceLinesC[k];
+			src_y_ahead_c = dml_floor(DETBufferSizeC[k] / BytePerPixelDETC[k] / SwathWidthC[k], SwathHeightC[k]) + LBLatencyHidingSourceLinesC[k];
 			sub_vp_lines_c = src_y_pstate_c + src_y_ahead_c + meta_row_height_chroma[k];
 			SubViewportLinesNeededInMALL[k] = dml_max(sub_vp_lines_l, sub_vp_lines_c);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index ecd4f1e7d1f7..974006e5ecb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -810,7 +810,6 @@ void dml32_CalculateFlipSchedule(
 		bool *ImmediateFlipSupportedForPipe);
 
 void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
-		struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport *st_vars,
 		bool USRRetrainingRequiredFinal,
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int PrefetchMode,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 42e4e4c5e656..b326184cfa4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -214,39 +214,6 @@ struct dml32_CalculateVMRowAndSwath {
 	bool one_row_per_frame_fits_in_buffer[DC__NUM_DPP__MAX];
 };
 
-struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport {
-	unsigned int SurfaceWithMinActiveFCLKChangeMargin;
-	unsigned int DRAMClockChangeSupportNumber;
-	unsigned int LastSurfaceWithoutMargin;
-	unsigned int DRAMClockChangeMethod;
-	bool FoundFirstSurfaceWithMinActiveFCLKChangeMargin;
-	double MinActiveFCLKChangeMargin;
-	double SecondMinActiveFCLKChangeMarginOneDisplayInVBLank;
-	double ActiveClockChangeLatencyHidingY;
-	double ActiveClockChangeLatencyHidingC;
-	double ActiveClockChangeLatencyHiding;
-	double EffectiveDETBufferSizeY;
-	double ActiveFCLKChangeLatencyMargin[DC__NUM_DPP__MAX];
-	double USRRetrainingLatencyMargin[DC__NUM_DPP__MAX];
-	double TotalPixelBW;
-	bool SynchronizedSurfaces[DC__NUM_DPP__MAX][DC__NUM_DPP__MAX];
-	double EffectiveLBLatencyHidingY;
-	double EffectiveLBLatencyHidingC;
-	double LinesInDETY[DC__NUM_DPP__MAX];
-	double LinesInDETC[DC__NUM_DPP__MAX];
-	unsigned int LinesInDETYRoundedDownToSwath[DC__NUM_DPP__MAX];
-	unsigned int LinesInDETCRoundedDownToSwath[DC__NUM_DPP__MAX];
-	double FullDETBufferingTimeY;
-	double FullDETBufferingTimeC;
-	double WritebackDRAMClockChangeLatencyMargin;
-	double WritebackFCLKChangeLatencyMargin;
-	double WritebackLatencyHiding;
-	bool SameTimingForFCLKChange;
-	unsigned int TotalActiveWriteback;
-	unsigned int LBLatencyHidingSourceLinesY[DC__NUM_DPP__MAX];
-	unsigned int LBLatencyHidingSourceLinesC[DC__NUM_DPP__MAX];
-};
-
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -320,7 +287,6 @@ struct dummy_vars {
 	struct dml32_ModeSupportAndSystemConfigurationFull dml32_ModeSupportAndSystemConfigurationFull;
 	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
 	struct dml32_CalculateVMRowAndSwath dml32_CalculateVMRowAndSwath;
-	struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport;
 };
 
 struct vba_vars_st {
-- 
2.35.1

