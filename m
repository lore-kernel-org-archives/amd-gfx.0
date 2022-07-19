Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1762AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 21:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202FB882A9;
	Tue, 19 Jul 2022 21:15:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02D814B715
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 21:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvfboxH6+6O2nN5EtCWNUBlIs5ho2AwzYFaDL6NJAeeqv9L8l+OiAfTYSOO/pzFhUAwd1aKI8s6YWqrM0KB6/5S7R25atzvK3ptu7wWDrPfcqZl7jCjiej1ULnqWQPeY/+Ddr0oDwgd269O3nm8nm+t0VUzy3fJnozg1uvE469tbSPumwp/DsASBEURU1KbVz/fUR3Yr4sDv1NJ2UyMoeXK7ZoEt9+mjbPXXDK8/hee9x5iD/5T1xMRvXprbGWXoyq4MmVFSWV161pMhivKnqJhIBYwglqUgSqjEAaoDOOUYqrajjV0ZBJikFxZjzb27OtBhFKrGCJEH2NPVwpYGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljISpooiziwlkcSrtCrKhFiuixZ+/gVI/h+zlfmZJxQ=;
 b=T3/h1WgBC1L4jUuacxVJxpuks1iLBRj222ZRLnOJpRRNb0GKRRs/GZ2fUChLvivDrypWwXVYCLtOP06Xf4XT+F4/Kb0bglluETA2ErapCOdF0B9oB79Pb9BR2n6r6dmKTKoPJzraUBAHMMeqgMJ3HUaWkHtyhNsBKz0SEEIweLtc2qVxmjz8pVLn+Gj19CWLtcgZ3T/exfPGzs+e5qLqBkSYvnyjPOujFfFXLCoyWOxuSL0oHqbNPo78U4eKbC55l93znIXEJNhaYRK4br6H8I28AprsHRFHcnWridE1euxah4VoF6ifQ7F8LYwOaBKleHzyO1fNSFI/4rM7qDGscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljISpooiziwlkcSrtCrKhFiuixZ+/gVI/h+zlfmZJxQ=;
 b=hXrmq/VAwVWxwXe7mshoFHptFt2G0StssY5sBnhci2CA2RzS4UO0q92MHAYTAnQc68Fdr+w92BdhmnhjsaqJqxN0YOYFhgoI98XimKiuYJgE08oz9OBNjSu16w2uCvVTZcumO+A2pTVbB9NtUrRCpx5Crmi02yJE08RRiPEzh6w=
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 21:15:29 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::96) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Tue, 19 Jul 2022 21:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 19 Jul 2022 21:15:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 16:15:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: reduce stack size in dcn32 dml
Date: Tue, 19 Jul 2022 17:14:48 -0400
Message-ID: <20220719211448.2873045-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deaf675f-3c9e-4430-1854-08da69cbcb6a
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDb9TrTCtc8NyZ4W+ZFlE+f+InvSrMvBJnb6WVdzY0RZ9pPI7RYRk//+++o8xVUje9WcRB7b6goet2K7N4QX9zAUQS9jc84SU6Q+fO/8f1L0b3AJ4AYhhLzC73PBsuUsGruUb28JjgDztSutIcQM0KEWTA8E8m6F3O55EKAk/n4cFibXU0q1Z95oy3oJlo/zgR2MoolFsvDydEcUqJjtu/f4j0+NAMiyl1nyQK2GYk/OSUtj+u42VLPcie+5oANfmUNmnisq2+Mw53JVobf3IP9DRHKJVlVXWbPTSuRWsqVBf8tI9o0cMaStgH4C/ANuT/jaSOon2keZ3aYiLMJXlZfyJle/98H9Q4NjXaOQ641S67VipKRClu9ZauD3gy6sF2PeS+rRAbTYIEoj/zu1BvcoGtip7ub4aPhz/eK3rUpBQ2z4smQcDP21m1/+45eouvE2v0qbkK9L1kOCJntMUEc01xqT5Jbeo/mYqUSg/2WAUY87Ow/mbsAmrEE375B9WyP91xxOw/k4k4AvBr+Ym4jOK2F2IBkjZeIw6LCwMHeBmFOGSj0KIfVolirKcB8KLO3TcsLTPSYjq2upcxtHunOS7rL8U8dPOHSa0RDac313TqRxOLmhKk5t+/hsIRr+0NMNaPJeR2wxPq/dAsyiukBRbdVWgRLYkhnRs9tkS7NNQ9WWtJ4G1A+ilemHSb/oinmRhPKz2JH5Wok3/y0M4Jhp/sEoECRNbYMj9HECYXjflET9PkScL9p0gIZYtabjx7Oh/eyWpuVUqu6kUJMVsvzPqI3TIQR9dZfLzG6GHGXNqxFDqr2hHoX0W/Vu24A6h/krDgrg/mBOnOdVAVJylw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(40470700004)(36840700001)(46966006)(2906002)(81166007)(7696005)(86362001)(47076005)(8936002)(82740400003)(70586007)(426003)(478600001)(83380400001)(336012)(8676002)(6666004)(186003)(41300700001)(70206006)(40460700003)(356005)(16526019)(26005)(30864003)(40480700001)(54906003)(4326008)(19627235002)(2616005)(6916009)(5660300002)(316002)(36860700001)(36756003)(82310400005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 21:15:23.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deaf675f-3c9e-4430-1854-08da69cbcb6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move additional dummy structures off the stack and into
the dummy vars structure.

Fixes the following:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 1659 | }
      | ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 3799 | } // ModeSupportAndSystemConfigurationFull
      | ^

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 214 ++++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h |   3 +
 2 files changed, 100 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 349e36ae9333..441311cb9a86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -67,6 +67,18 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	int iteration;
 	double MaxTotalRDBandwidth;
 	unsigned int NextPrefetchMode;
+	double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
+	bool DestinationLineTimesForPrefetchLessThan2 = false;
+	bool VRatioPrefetchMoreThanMax = false;
+	double dummy_unit_vector[DC__NUM_DPP__MAX];
+	double TWait;
+	double dummy_single[2];
+	bool dummy_boolean[1];
+	enum clock_change_support dummy_dramchange_support;
+	enum dm_fclock_change_support dummy_fclkchange_support;
+	bool dummy_USRRetrainingSupport;
+	double TotalWRBandwidth = 0;
+	double WRBandwidth = 0;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: --- START ---\n", __func__);
@@ -702,11 +714,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	NextPrefetchMode = mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb];
 
 	do {
-		double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
-		bool DestinationLineTimesForPrefetchLessThan2 = false;
-		bool VRatioPrefetchMoreThanMax = false;
-		double dummy_unit_vector[DC__NUM_DPP__MAX];
-
 		MaxTotalRDBandwidth = 0;
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: Start loop: VStartup = %d\n", __func__, mode_lib->vba.VStartupLines);
@@ -715,41 +722,39 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			/* NOTE PerfetchMode variable is invalid in DAL as per the input received.
 			 * Hence the direction is to use PrefetchModePerState.
 			 */
-			double TWait = dml32_CalculateTWait(
-					mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
-					mode_lib->vba.UsesMALLForPStateChange[k],
-					mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
-					mode_lib->vba.DRRDisplay[k],
-					mode_lib->vba.DRAMClockChangeLatency,
-					mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
-					mode_lib->vba.SREnterPlusExitTime);
-
-			DmlPipe myPipe;
-
-			myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
-			myPipe.Dispclk = mode_lib->vba.DISPCLK;
-			myPipe.PixelClock = mode_lib->vba.PixelClock[k];
-			myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
-			myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
-			myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
-			myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
-			myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
-			myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
-			myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
-			myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
-			myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
-			myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
-			myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
-			myPipe.HTotal = mode_lib->vba.HTotal[k];
-			myPipe.HActive = mode_lib->vba.HActive[k];
-			myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
-			myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
-			myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
-			myPipe.BytePerPixelY = v->BytePerPixelY[k];
-			myPipe.BytePerPixelC = v->BytePerPixelC[k];
-			myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
+			TWait = dml32_CalculateTWait(
+				mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
+				mode_lib->vba.UsesMALLForPStateChange[k],
+				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
+				mode_lib->vba.DRRDisplay[k],
+				mode_lib->vba.DRAMClockChangeLatency,
+				mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
+				mode_lib->vba.SREnterPlusExitTime);
+
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dispclk = mode_lib->vba.DISPCLK;
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HTotal = mode_lib->vba.HTotal[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HActive = mode_lib->vba.HActive[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelY = v->BytePerPixelY[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelC = v->BytePerPixelC[k];
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
 			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
-					&myPipe, v->DSCDelay[k],
+					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe, v->DSCDelay[k],
 					mode_lib->vba.DPPCLKDelaySubtotal + mode_lib->vba.DPPCLKDelayCNVCFormater,
 					mode_lib->vba.DPPCLKDelaySCL,
 					mode_lib->vba.DPPCLKDelaySCLLBOnly,
@@ -898,8 +903,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 #endif
 
 		{
-			double dummy_single[1];
-
 			dml32_CalculatePrefetchBandwithSupport(
 					mode_lib->vba.NumberOfActiveSurfaces,
 					mode_lib->vba.ReturnBW,
@@ -931,8 +934,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			dummy_unit_vector[k] = 1.0;
 
 		{
-			double  dummy_single[1];
-			bool dummy_boolean[1];
 			dml32_CalculatePrefetchBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
 					mode_lib->vba.ReturnBW,
 					v->NoUrgentLatencyHidingPre,
@@ -1039,8 +1040,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			}
 
 			{
-				double  dummy_single[2];
-				bool dummy_boolean[1];
 				dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
 						mode_lib->vba.ReturnBW,
 						mode_lib->vba.ImmediateFlipRequirement,
@@ -1149,22 +1148,17 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 	//Watermarks and NB P-State/DRAM Clock Change Support
 	{
-		SOCParametersList mmSOCParameters;
-		enum clock_change_support dummy_dramchange_support;
-		enum dm_fclock_change_support dummy_fclkchange_support;
-		bool dummy_USRRetrainingSupport;
-
-		mmSOCParameters.UrgentLatency = v->UrgentLatency;
-		mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
-		mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
-		mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
-		mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
-		mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
-		mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
-		mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
-		mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
-		mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
-		mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.UrgentLatency = v->UrgentLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
+		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
 
 		dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 			mode_lib->vba.USRRetrainingRequiredFinal,
@@ -1182,7 +1176,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->dpte_group_bytes,
 			v->meta_row_height,
 			v->meta_row_height_chroma,
-			mmSOCParameters,
+			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters,
 			mode_lib->vba.WritebackChunkSize,
 			mode_lib->vba.SOCCLK,
 			v->DCFCLKDeepSleep,
@@ -1486,9 +1480,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 	{
 		//Maximum Bandwidth Used
-		double TotalWRBandwidth = 0;
-		double WRBandwidth = 0;
-
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.WritebackEnable[k] == true
 					&& mode_lib->vba.WritebackPixelFormat[k] == dm_444_32) {
@@ -1582,9 +1573,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 #ifdef __DML_VBA_ALLOW_DELTA__
 	{
-		double dummy_single[2];
 		unsigned int dummy_integer[1];
-		bool dummy_boolean[1];
 
 		// Calculate z8 stutter eff assuming 0 reserved space
 		dml32_CalculateStutterEfficiency(v->CompressedBufferSizeInkByte,
@@ -1669,20 +1658,33 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	unsigned int TotalNumberOfActiveDP2p0;
 	unsigned int TotalNumberOfActiveDP2p0Outputs;
 	unsigned int TotalDSCUnitsRequired;
-	unsigned int m;
 	unsigned int ReorderingBytes;
 	bool FullFrameMALLPStateMethod;
 	bool SubViewportMALLPStateMethod;
 	bool PhantomPipeMALLPStateMethod;
 	unsigned int MaximumMPCCombine;
+	bool NoChroma;
+	bool TotalAvailablePipesSupportNoDSC;
+	unsigned int NumberOfDPPNoDSC;
+	enum odm_combine_mode ODMModeNoDSC = dm_odm_combine_mode_disabled;
+	double RequiredDISPCLKPerSurfaceNoDSC;
+	bool TotalAvailablePipesSupportDSC;
+	unsigned int NumberOfDPPDSC;
+	enum odm_combine_mode ODMModeDSC = dm_odm_combine_mode_disabled;
+	double RequiredDISPCLKPerSurfaceDSC;
+	double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
+	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
+	unsigned int TotalSlots;
+	double VMDataOnlyReturnBWPerState;
+	double HostVMInefficiencyFactor;
+	unsigned int NextPrefetchModeState;
+	struct vba_vars_st *v = &mode_lib->vba;
+	int i, j;
+	unsigned int k, m;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: called\n", __func__);
 #endif
-	struct vba_vars_st *v = &mode_lib->vba;
-
-	int i, j;
-	unsigned int k;
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
@@ -1991,21 +1993,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	for (i = 0; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
-			bool NoChroma;
 			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
 			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
 
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-
-				bool TotalAvailablePipesSupportNoDSC;
-				unsigned int NumberOfDPPNoDSC;
-				enum odm_combine_mode ODMModeNoDSC = dm_odm_combine_mode_disabled;
-				double RequiredDISPCLKPerSurfaceNoDSC;
-				bool TotalAvailablePipesSupportDSC;
-				unsigned int NumberOfDPPDSC;
-				enum odm_combine_mode ODMModeDSC = dm_odm_combine_mode_disabled;
-				double RequiredDISPCLKPerSurfaceDSC;
-
 				dml32_CalculateODMMode(
 						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
 						mode_lib->vba.HActive[k],
@@ -2147,8 +2138,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.Output[0])) {
 				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
 						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
-					double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
-					unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
 
 					for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 						if (mode_lib->vba.MPCCombineUse[k]
@@ -2264,8 +2253,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	for (i = 0; i < v->soc.num_states; ++i) {
-		unsigned int TotalSlots;
-
 		mode_lib->vba.ExceededMultistreamSlots[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
@@ -2474,8 +2461,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*DSC Delay per state*/
 	for (i = 0; i < v->soc.num_states; ++i) {
-		unsigned int m;
-
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
 					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
@@ -3120,9 +3105,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double VMDataOnlyReturnBWPerState;
-			double HostVMInefficiencyFactor;
-			unsigned int NextPrefetchModeState;
 
 			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
 
@@ -3191,8 +3173,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
 
 				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-					DmlPipe myPipe;
-
 					mode_lib->vba.TWait = dml32_CalculateTWait(
 							mode_lib->vba.PrefetchModePerState[i][j],
 							mode_lib->vba.UsesMALLForPStateChange[k],
@@ -3202,34 +3182,34 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
 							mode_lib->vba.SREnterPlusExitTime);
 
-					myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
-					myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
-					myPipe.PixelClock = mode_lib->vba.PixelClock[k];
-					myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
-					myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
-					myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
-					myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
-					myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
-					myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
-					myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
-					myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
-					myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
-					myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
-					myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
-					myPipe.HTotal = mode_lib->vba.HTotal[k];
-					myPipe.HActive = mode_lib->vba.HActive[k];
-					myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
-					myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
-					myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
-					myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
-					myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
-					myPipe.ProgressiveToInterlaceUnitInOPP =
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HTotal = mode_lib->vba.HTotal[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HActive = mode_lib->vba.HActive[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ProgressiveToInterlaceUnitInOPP =
 							mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
 
 					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
 						dml32_CalculatePrefetchSchedule(
 							HostVMInefficiencyFactor,
-							&myPipe,
+							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
 							mode_lib->vba.DSCDelayPerState[i][k],
 							mode_lib->vba.DPPCLKDelaySubtotal +
 								mode_lib->vba.DPPCLKDelayCNVCFormater,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 47b149d4bfcf..b3905a55772b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -197,6 +197,8 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
 	unsigned int ReorderBytes;
 	unsigned int VMDataOnlyReturnBW;
 	double HostVMInefficiencyFactor;
+	DmlPipe myPipe;
+	SOCParametersList mmSOCParameters;
 };
 
 struct dml32_ModeSupportAndSystemConfigurationFull {
@@ -212,6 +214,7 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
 	double DSTXAfterScaler[DC__NUM_DPP__MAX];
 	double MaxTotalVActiveRDBandwidth;
 	bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
+	DmlPipe myPipe;
 };
 
 struct dummy_vars {
-- 
2.35.3

