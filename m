Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3E6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 05:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5458C11ADF0;
	Thu, 21 Jul 2022 05:13:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24C11ADEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 05:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5qJaLDucrEWes+gmdsF7FZAtxmY6UCKm8jVZFzk+MDwfzZlOMGl2OLqgAE3oh9pPL77/Vfo1xWszbRG9SKyZCYVjASO7tZCwHosFdPJSKtOlBqggef44P3Y9ntOtWpxdg2IBXo9TwuXywlVgzFtdc2mCTohc9c3nMycstZObLZx7gT38Z7k2MfoORN55AbHRcd1JucE4I/3Nr4uWCb8615cublJ0mUWF3OTXUws2v3qQoLJ9S8iwdBOkvQfpwCHIcCy/CxNckmL1ZtCB48IhArjjHujwlECbVntEwO6i7bKbC2i3sIyuGwc1FbCbO0xhR4h50wz3lQ3DnWatXqa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcX3Yd3XciA2/tkCPkfJ4YEUznr5JjQA+5bVskb6rGM=;
 b=ZOL+GXSi1X4M0Lzm4yF06q0ZSULKZZFTZcpFx+VXExwv6e7jazKfT6vcdct0ERFYF2wAO+nTqwFbCfo16oo4SOR8MP9eS55Ote3tW4vfeGNjhQK63wtqtkJ1AxGPjFcBDrRIMziIZqFWTQHuhVUVDQrlNJ6Zu+x1LQgbIiFFYMDoblYN0kXLuPtgN2iO3OuSn7ff8Ds3K3orQLu9cFCyqhKMOcoGAaDnH31rgEOq8AMIZj7MYyWJrPNJ9oP08mp7HL+461teBY2Ejkx1w0THkghyiFVoNMAW1mUhZPGmteC/NOy/5h2Rca00xcRiwC4bD4hKe/4k9/KOrB61nDQIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcX3Yd3XciA2/tkCPkfJ4YEUznr5JjQA+5bVskb6rGM=;
 b=H53xyZ1OD2DsrmxTWdW/+r2/BvKvQtXPOfec1B2aoty7v0zhrmxDLm/m9ZerSryd7TJxrhNJPl+zxn7008iz3dWRtbYYZdAyRR4rfAx8eAOdJeIklxB62fGKg7tLh5eyZQZmM7RWbJI7V7b9FpZK666jJcYaEY72vhdGts8Oh34=
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Thu, 21 Jul 2022 05:13:26 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::39) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Thu, 21 Jul 2022 05:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 05:13:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 00:13:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/display: reduce stack for
 dml32_CalculatePrefetchSchedule
Date: Thu, 21 Jul 2022 01:13:05 -0400
Message-ID: <20220721051305.1356754-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220721051305.1356754-1-alexander.deucher@amd.com>
References: <20220721051305.1356754-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8eab003-3646-4222-db0a-08da6ad7bdee
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcnaBA8JJ1CtAAItyOcAdRcgPuj2T1AWtVa4gtn7PxBI09CWsy2DEd4KZ7hgzMc7ADJD2FSX5xK081DAWe2zpOF5JMTXV7V+OPoiTF3UKO1iEy85Av0ihBXpjSpCtoHU347Mhd5fIw2LLV+RUPwfagZLcp2IbsQYlgftHik/9/2fZzNU6JlldsZaMh00NUjIBROKn3jj97yp3SDa8L6WT/TVJervCJBpks41N2gHHFpe4Gp+ITLcGZUiMe5O0/BfHD2pydPrD+4A2DQWHa1MoaNqsQKNOAGiuVeCgez8zVgnGfaPpjP9212RyiSIimWRmhWVUaEMGS9vhf5+Qz9ggk1e3bbuduwy2gQIGfE47hrCA78u9h++7CceAUOVoh5Ocu1n6HznNHnjqb1bNug6DBCWRr4Z8ZPi+lQuCON81JgbvyXOip48GiOB3g2UIE35fAjGcRKfhIInCs9S89iV/CbmutQ0Rg+7ZOXlYjS/MNXFnRlSP2gfyWaR16ebNZmIR+i01zvI+HQkZhhJJbLb2L/nwTyYyFxAVH6+Fyax1sTwk4x64Bv5IqjmDjEv0srzis8kbB49/HiUz0lNgfFaj9oTTWYUT566pop8GAw6vFa9+NdTfy698Hi0pH3hWQXQJDmVz99qiDt03hClU2TnBSuOTjsMl1AIp1F9BJwubFFxSWrjql27fLw07nFS5cJgsnOU8p2MDuI+MtNuvMsFF79HBcBHCtiCfAvnE4I+3lC6Gm+AgncIxn9ZuhAHizbsy6T99hx9+cwqs9k0kEYzSqhYWRqvI3Pnxj7ngrpLHWumuGQ0gbAENSD1nzHkyffQbDvvqhLXoUZgOlVRRtMQFS5SC2nXwyfjEwZHKb0P9P4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(356005)(186003)(82740400003)(8676002)(83380400001)(1076003)(81166007)(41300700001)(47076005)(30864003)(478600001)(36756003)(7696005)(426003)(19627235002)(16526019)(336012)(26005)(6666004)(2616005)(54906003)(70206006)(5660300002)(4326008)(36860700001)(8936002)(6916009)(316002)(40460700003)(82310400005)(2906002)(70586007)(36900700001)(579004)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 05:13:26.2313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eab003-3646-4222-db0a-08da6ad7bdee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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

Move stack variables to dummy structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   5 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 394 ++++++++----------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  38 ++
 4 files changed, 227 insertions(+), 211 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f7d108123b07..db3e43499a26 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -757,7 +757,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelY = v->BytePerPixelY[k];
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelC = v->BytePerPixelC[k];
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
-			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
+			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(
+					&v->dummy_vars.dml32_CalculatePrefetchSchedule,
+					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
 					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe, v->DSCDelay[k],
 					mode_lib->vba.DPPCLKDelaySubtotal + mode_lib->vba.DPPCLKDelayCNVCFormater,
 					mode_lib->vba.DPPCLKDelaySCL,
@@ -3195,6 +3197,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
 						dml32_CalculatePrefetchSchedule(
+							&v->dummy_vars.dml32_CalculatePrefetchSchedule,
 							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
 							mode_lib->vba.DSCDelayPerState[i][k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 40b4c88ff2e7..4b010b1b8aed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3342,6 +3342,7 @@ double dml32_CalculateExtraLatency(
 } // CalculateExtraLatency
 
 bool dml32_CalculatePrefetchSchedule(
+		struct dml32_CalculatePrefetchSchedule *st_vars,
 		double HostVMInefficiencyFactor,
 		DmlPipe *myPipe,
 		unsigned int DSCDelay,
@@ -3405,45 +3406,18 @@ bool dml32_CalculatePrefetchSchedule(
 		double   *VReadyOffsetPix)
 {
 	bool MyError = false;
-	unsigned int DPPCycles, DISPCLKCycles;
-	double DSTTotalPixelsAfterScaler;
-	double LineTime;
-	double dst_y_prefetch_equ;
-	double prefetch_bw_oto;
-	double Tvm_oto;
-	double Tr0_oto;
-	double Tvm_oto_lines;
-	double Tr0_oto_lines;
-	double dst_y_prefetch_oto;
-	double TimeForFetchingMetaPTE = 0;
-	double TimeForFetchingRowInVBlank = 0;
-	double LinesToRequestPrefetchPixelData = 0;
-	unsigned int HostVMDynamicLevelsTrips;
-	double  trip_to_mem;
-	double  Tvm_trips;
-	double  Tr0_trips;
-	double  Tvm_trips_rounded;
-	double  Tr0_trips_rounded;
-	double  Lsw_oto;
-	double  Tpre_rounded;
-	double  prefetch_bw_equ;
-	double  Tvm_equ;
-	double  Tr0_equ;
-	double  Tdmbf;
-	double  Tdmec;
-	double  Tdmsks;
-	double  prefetch_sw_bytes;
-	double  bytes_pp;
-	double  dep_bytes;
-	unsigned int max_vratio_pre = __DML_MAX_VRATIO_PRE__;
-	double  min_Lsw;
-	double  Tsw_est1 = 0;
-	double  Tsw_est3 = 0;
+
+	st_vars->TimeForFetchingMetaPTE = 0;
+	st_vars->TimeForFetchingRowInVBlank = 0;
+	st_vars->LinesToRequestPrefetchPixelData = 0;
+	st_vars->max_vratio_pre = __DML_MAX_VRATIO_PRE__;
+	st_vars->Tsw_est1 = 0;
+	st_vars->Tsw_est3 = 0;
 
 	if (GPUVMEnable == true && HostVMEnable == true)
-		HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
+		st_vars->HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
 	else
-		HostVMDynamicLevelsTrips = 0;
+		st_vars->HostVMDynamicLevelsTrips = 0;
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: GPUVMEnable = %d\n", __func__, GPUVMEnable);
 	dml_print("DML::%s: GPUVMPageTableLevels = %d\n", __func__, GPUVMPageTableLevels);
@@ -3466,19 +3440,19 @@ bool dml32_CalculatePrefetchSchedule(
 			TSetup,
 
 			/* output */
-			&Tdmbf,
-			&Tdmec,
-			&Tdmsks,
+			&st_vars->Tdmbf,
+			&st_vars->Tdmec,
+			&st_vars->Tdmsks,
 			VUpdateOffsetPix,
 			VUpdateWidthPix,
 			VReadyOffsetPix);
 
-	LineTime = myPipe->HTotal / myPipe->PixelClock;
-	trip_to_mem = UrgentLatency;
-	Tvm_trips = UrgentExtraLatency + trip_to_mem * (GPUVMPageTableLevels * (HostVMDynamicLevelsTrips + 1) - 1);
+	st_vars->LineTime = myPipe->HTotal / myPipe->PixelClock;
+	st_vars->trip_to_mem = UrgentLatency;
+	st_vars->Tvm_trips = UrgentExtraLatency + st_vars->trip_to_mem * (GPUVMPageTableLevels * (st_vars->HostVMDynamicLevelsTrips + 1) - 1);
 
 	if (DynamicMetadataVMEnabled == true)
-		*Tdmdl = TWait + Tvm_trips + trip_to_mem;
+		*Tdmdl = TWait + st_vars->Tvm_trips + st_vars->trip_to_mem;
 	else
 		*Tdmdl = TWait + UrgentExtraLatency;
 
@@ -3488,15 +3462,15 @@ bool dml32_CalculatePrefetchSchedule(
 #endif
 
 	if (DynamicMetadataEnable == true) {
-		if (VStartup * LineTime < *TSetup + *Tdmdl + Tdmbf + Tdmec + Tdmsks) {
+		if (VStartup * st_vars->LineTime < *TSetup + *Tdmdl + st_vars->Tdmbf + st_vars->Tdmec + st_vars->Tdmsks) {
 			*NotEnoughTimeForDynamicMetadata = true;
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: Not Enough Time for Dynamic Meta!\n", __func__);
 			dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n",
-					__func__, Tdmbf);
-			dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, Tdmec);
+					__func__, st_vars->Tdmbf);
+			dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, st_vars->Tdmec);
 			dml_print("DML::%s: Tdmsks: %fus - time before active dmd must complete transmission at dio\n",
-					__func__, Tdmsks);
+					__func__, st_vars->Tdmsks);
 			dml_print("DML::%s: Tdmdl: %fus - time for fabric to become ready and fetch dmd\n",
 					__func__, *Tdmdl);
 #endif
@@ -3508,21 +3482,21 @@ bool dml32_CalculatePrefetchSchedule(
 	}
 
 	*Tdmdl_vm =  (DynamicMetadataEnable == true && DynamicMetadataVMEnabled == true &&
-			GPUVMEnable == true ? TWait + Tvm_trips : 0);
+			GPUVMEnable == true ? TWait + st_vars->Tvm_trips : 0);
 
 	if (myPipe->ScalerEnabled)
-		DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCL;
+		st_vars->DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCL;
 	else
-		DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCLLBOnly;
+		st_vars->DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCLLBOnly;
 
-	DPPCycles = DPPCycles + myPipe->NumberOfCursors * DPPCLKDelayCNVCCursor;
+	st_vars->DPPCycles = st_vars->DPPCycles + myPipe->NumberOfCursors * DPPCLKDelayCNVCCursor;
 
-	DISPCLKCycles = DISPCLKDelaySubtotal;
+	st_vars->DISPCLKCycles = DISPCLKDelaySubtotal;
 
 	if (myPipe->Dppclk == 0.0 || myPipe->Dispclk == 0.0)
 		return true;
 
-	*DSTXAfterScaler = DPPCycles * myPipe->PixelClock / myPipe->Dppclk + DISPCLKCycles *
+	*DSTXAfterScaler = st_vars->DPPCycles * myPipe->PixelClock / myPipe->Dppclk + st_vars->DISPCLKCycles *
 			myPipe->PixelClock / myPipe->Dispclk + DSCDelay;
 
 	*DSTXAfterScaler = *DSTXAfterScaler + (myPipe->ODMMode != dm_odm_combine_mode_disabled ? 18 : 0)
@@ -3532,10 +3506,10 @@ bool dml32_CalculatePrefetchSchedule(
 			+ ((myPipe->ODMMode == dm_odm_mode_mso_1to4) ? myPipe->HActive * 3 / 4 : 0);
 
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: DPPCycles: %d\n", __func__, DPPCycles);
+	dml_print("DML::%s: DPPCycles: %d\n", __func__, st_vars->DPPCycles);
 	dml_print("DML::%s: PixelClock: %f\n", __func__, myPipe->PixelClock);
 	dml_print("DML::%s: Dppclk: %f\n", __func__, myPipe->Dppclk);
-	dml_print("DML::%s: DISPCLKCycles: %d\n", __func__, DISPCLKCycles);
+	dml_print("DML::%s: DISPCLKCycles: %d\n", __func__, st_vars->DISPCLKCycles);
 	dml_print("DML::%s: DISPCLK: %f\n", __func__,  myPipe->Dispclk);
 	dml_print("DML::%s: DSCDelay: %d\n", __func__,  DSCDelay);
 	dml_print("DML::%s: ODMMode: %d\n", __func__,  myPipe->ODMMode);
@@ -3548,9 +3522,9 @@ bool dml32_CalculatePrefetchSchedule(
 	else
 		*DSTYAfterScaler = 0;
 
-	DSTTotalPixelsAfterScaler = *DSTYAfterScaler * myPipe->HTotal + *DSTXAfterScaler;
-	*DSTYAfterScaler = dml_floor(DSTTotalPixelsAfterScaler / myPipe->HTotal, 1);
-	*DSTXAfterScaler = DSTTotalPixelsAfterScaler - ((double) (*DSTYAfterScaler * myPipe->HTotal));
+	st_vars->DSTTotalPixelsAfterScaler = *DSTYAfterScaler * myPipe->HTotal + *DSTXAfterScaler;
+	*DSTYAfterScaler = dml_floor(st_vars->DSTTotalPixelsAfterScaler / myPipe->HTotal, 1);
+	*DSTXAfterScaler = st_vars->DSTTotalPixelsAfterScaler - ((double) (*DSTYAfterScaler * myPipe->HTotal));
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: DSTXAfterScaler: %d (final)\n", __func__,  *DSTXAfterScaler);
 	dml_print("DML::%s: DSTYAfterScaler: %d (final)\n", __func__, *DSTYAfterScaler);
@@ -3558,132 +3532,132 @@ bool dml32_CalculatePrefetchSchedule(
 
 	MyError = false;
 
-	Tr0_trips = trip_to_mem * (HostVMDynamicLevelsTrips + 1);
+	st_vars->Tr0_trips = st_vars->trip_to_mem * (st_vars->HostVMDynamicLevelsTrips + 1);
 
 	if (GPUVMEnable == true) {
-		Tvm_trips_rounded = dml_ceil(4.0 * Tvm_trips / LineTime, 1.0) / 4.0 * LineTime;
-		Tr0_trips_rounded = dml_ceil(4.0 * Tr0_trips / LineTime, 1.0) / 4.0 * LineTime;
+		st_vars->Tvm_trips_rounded = dml_ceil(4.0 * st_vars->Tvm_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
+		st_vars->Tr0_trips_rounded = dml_ceil(4.0 * st_vars->Tr0_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
 		if (GPUVMPageTableLevels >= 3) {
-			*Tno_bw = UrgentExtraLatency + trip_to_mem *
-					(double) ((GPUVMPageTableLevels - 2) * (HostVMDynamicLevelsTrips + 1) - 1);
+			*Tno_bw = UrgentExtraLatency + st_vars->trip_to_mem *
+					(double) ((GPUVMPageTableLevels - 2) * (st_vars->HostVMDynamicLevelsTrips + 1) - 1);
 		} else if (GPUVMPageTableLevels == 1 && myPipe->DCCEnable != true) {
-			Tr0_trips_rounded = dml_ceil(4.0 * UrgentExtraLatency / LineTime, 1.0) /
-					4.0 * LineTime; // VBA_ERROR
+			st_vars->Tr0_trips_rounded = dml_ceil(4.0 * UrgentExtraLatency / st_vars->LineTime, 1.0) /
+					4.0 * st_vars->LineTime; // VBA_ERROR
 			*Tno_bw = UrgentExtraLatency;
 		} else {
 			*Tno_bw = 0;
 		}
 	} else if (myPipe->DCCEnable == true) {
-		Tvm_trips_rounded = LineTime / 4.0;
-		Tr0_trips_rounded = dml_ceil(4.0 * Tr0_trips / LineTime, 1.0) / 4.0 * LineTime;
+		st_vars->Tvm_trips_rounded = st_vars->LineTime / 4.0;
+		st_vars->Tr0_trips_rounded = dml_ceil(4.0 * st_vars->Tr0_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
 		*Tno_bw = 0;
 	} else {
-		Tvm_trips_rounded = LineTime / 4.0;
-		Tr0_trips_rounded = LineTime / 2.0;
+		st_vars->Tvm_trips_rounded = st_vars->LineTime / 4.0;
+		st_vars->Tr0_trips_rounded = st_vars->LineTime / 2.0;
 		*Tno_bw = 0;
 	}
-	Tvm_trips_rounded = dml_max(Tvm_trips_rounded, LineTime / 4.0);
-	Tr0_trips_rounded = dml_max(Tr0_trips_rounded, LineTime / 4.0);
+	st_vars->Tvm_trips_rounded = dml_max(st_vars->Tvm_trips_rounded, st_vars->LineTime / 4.0);
+	st_vars->Tr0_trips_rounded = dml_max(st_vars->Tr0_trips_rounded, st_vars->LineTime / 4.0);
 
 	if (myPipe->SourcePixelFormat == dm_420_8 || myPipe->SourcePixelFormat == dm_420_10
 			|| myPipe->SourcePixelFormat == dm_420_12) {
-		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC / 4;
+		st_vars->bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC / 4;
 	} else {
-		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
+		st_vars->bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
 	}
 
-	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY
+	st_vars->prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY
 			+ PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
-	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerSurface,
-			prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
+	st_vars->prefetch_bw_oto = dml_max(st_vars->bytes_pp * myPipe->PixelClock / myPipe->DPPPerSurface,
+			st_vars->prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * st_vars->LineTime));
 
-	min_Lsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre;
-	min_Lsw = dml_max(min_Lsw, 1.0);
-	Lsw_oto = dml_ceil(4.0 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1.0) / 4.0;
+	st_vars->min_Lsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / st_vars->max_vratio_pre;
+	st_vars->min_Lsw = dml_max(st_vars->min_Lsw, 1.0);
+	st_vars->Lsw_oto = dml_ceil(4.0 * dml_max(st_vars->prefetch_sw_bytes / st_vars->prefetch_bw_oto / st_vars->LineTime, st_vars->min_Lsw), 1.0) / 4.0;
 
 	if (GPUVMEnable == true) {
-		Tvm_oto = dml_max3(
-				Tvm_trips,
-				*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / prefetch_bw_oto,
-				LineTime / 4.0);
+		st_vars->Tvm_oto = dml_max3(
+				st_vars->Tvm_trips,
+				*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / st_vars->prefetch_bw_oto,
+				st_vars->LineTime / 4.0);
 	} else
-		Tvm_oto = LineTime / 4.0;
+		st_vars->Tvm_oto = st_vars->LineTime / 4.0;
 
 	if ((GPUVMEnable == true || myPipe->DCCEnable == true)) {
-		Tr0_oto = dml_max4(
-				Tr0_trips,
-				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / prefetch_bw_oto,
-				(LineTime - Tvm_oto)/2.0,
-				LineTime / 4.0);
+		st_vars->Tr0_oto = dml_max4(
+				st_vars->Tr0_trips,
+				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / st_vars->prefetch_bw_oto,
+				(st_vars->LineTime - st_vars->Tvm_oto)/2.0,
+				st_vars->LineTime / 4.0);
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: Tr0_oto max0 = %f\n", __func__,
-				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / prefetch_bw_oto);
-		dml_print("DML::%s: Tr0_oto max1 = %f\n", __func__, Tr0_trips);
-		dml_print("DML::%s: Tr0_oto max2 = %f\n", __func__, LineTime - Tvm_oto);
-		dml_print("DML::%s: Tr0_oto max3 = %f\n", __func__, LineTime / 4);
+				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / st_vars->prefetch_bw_oto);
+		dml_print("DML::%s: Tr0_oto max1 = %f\n", __func__, st_vars->Tr0_trips);
+		dml_print("DML::%s: Tr0_oto max2 = %f\n", __func__, st_vars->LineTime - st_vars->Tvm_oto);
+		dml_print("DML::%s: Tr0_oto max3 = %f\n", __func__, st_vars->LineTime / 4);
 #endif
 	} else
-		Tr0_oto = (LineTime - Tvm_oto) / 2.0;
+		st_vars->Tr0_oto = (st_vars->LineTime - st_vars->Tvm_oto) / 2.0;
 
-	Tvm_oto_lines = dml_ceil(4.0 * Tvm_oto / LineTime, 1) / 4.0;
-	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
-	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
+	st_vars->Tvm_oto_lines = dml_ceil(4.0 * st_vars->Tvm_oto / st_vars->LineTime, 1) / 4.0;
+	st_vars->Tr0_oto_lines = dml_ceil(4.0 * st_vars->Tr0_oto / st_vars->LineTime, 1) / 4.0;
+	st_vars->dst_y_prefetch_oto = st_vars->Tvm_oto_lines + 2 * st_vars->Tr0_oto_lines + st_vars->Lsw_oto;
 
-	dst_y_prefetch_equ = VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime -
+	st_vars->dst_y_prefetch_equ = VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / st_vars->LineTime -
 			(*DSTYAfterScaler + (double) *DSTXAfterScaler / (double) myPipe->HTotal);
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: HTotal = %d\n", __func__, myPipe->HTotal);
-	dml_print("DML::%s: min_Lsw = %f\n", __func__, min_Lsw);
+	dml_print("DML::%s: min_Lsw = %f\n", __func__, st_vars->min_Lsw);
 	dml_print("DML::%s: *Tno_bw = %f\n", __func__, *Tno_bw);
 	dml_print("DML::%s: UrgentExtraLatency = %f\n", __func__, UrgentExtraLatency);
-	dml_print("DML::%s: trip_to_mem = %f\n", __func__, trip_to_mem);
+	dml_print("DML::%s: trip_to_mem = %f\n", __func__, st_vars->trip_to_mem);
 	dml_print("DML::%s: BytePerPixelY = %d\n", __func__, myPipe->BytePerPixelY);
 	dml_print("DML::%s: PrefetchSourceLinesY = %f\n", __func__, PrefetchSourceLinesY);
 	dml_print("DML::%s: swath_width_luma_ub = %d\n", __func__, swath_width_luma_ub);
 	dml_print("DML::%s: BytePerPixelC = %d\n", __func__, myPipe->BytePerPixelC);
 	dml_print("DML::%s: PrefetchSourceLinesC = %f\n", __func__, PrefetchSourceLinesC);
 	dml_print("DML::%s: swath_width_chroma_ub = %d\n", __func__, swath_width_chroma_ub);
-	dml_print("DML::%s: prefetch_sw_bytes = %f\n", __func__, prefetch_sw_bytes);
-	dml_print("DML::%s: bytes_pp = %f\n", __func__, bytes_pp);
+	dml_print("DML::%s: prefetch_sw_bytes = %f\n", __func__, st_vars->prefetch_sw_bytes);
+	dml_print("DML::%s: bytes_pp = %f\n", __func__, st_vars->bytes_pp);
 	dml_print("DML::%s: PDEAndMetaPTEBytesFrame = %d\n", __func__, PDEAndMetaPTEBytesFrame);
 	dml_print("DML::%s: MetaRowByte = %d\n", __func__, MetaRowByte);
 	dml_print("DML::%s: PixelPTEBytesPerRow = %d\n", __func__, PixelPTEBytesPerRow);
 	dml_print("DML::%s: HostVMInefficiencyFactor = %f\n", __func__, HostVMInefficiencyFactor);
-	dml_print("DML::%s: Tvm_trips = %f\n", __func__, Tvm_trips);
-	dml_print("DML::%s: Tr0_trips = %f\n", __func__, Tr0_trips);
-	dml_print("DML::%s: prefetch_bw_oto = %f\n", __func__, prefetch_bw_oto);
-	dml_print("DML::%s: Tr0_oto = %f\n", __func__, Tr0_oto);
-	dml_print("DML::%s: Tvm_oto = %f\n", __func__, Tvm_oto);
-	dml_print("DML::%s: Tvm_oto_lines = %f\n", __func__, Tvm_oto_lines);
-	dml_print("DML::%s: Tr0_oto_lines = %f\n", __func__, Tr0_oto_lines);
-	dml_print("DML::%s: Lsw_oto = %f\n", __func__, Lsw_oto);
-	dml_print("DML::%s: dst_y_prefetch_oto = %f\n", __func__, dst_y_prefetch_oto);
-	dml_print("DML::%s: dst_y_prefetch_equ = %f\n", __func__, dst_y_prefetch_equ);
+	dml_print("DML::%s: Tvm_trips = %f\n", __func__, st_vars->Tvm_trips);
+	dml_print("DML::%s: Tr0_trips = %f\n", __func__, st_vars->Tr0_trips);
+	dml_print("DML::%s: prefetch_bw_oto = %f\n", __func__, st_vars->prefetch_bw_oto);
+	dml_print("DML::%s: Tr0_oto = %f\n", __func__, st_vars->Tr0_oto);
+	dml_print("DML::%s: Tvm_oto = %f\n", __func__, st_vars->Tvm_oto);
+	dml_print("DML::%s: Tvm_oto_lines = %f\n", __func__, st_vars->Tvm_oto_lines);
+	dml_print("DML::%s: Tr0_oto_lines = %f\n", __func__, st_vars->Tr0_oto_lines);
+	dml_print("DML::%s: Lsw_oto = %f\n", __func__, st_vars->Lsw_oto);
+	dml_print("DML::%s: dst_y_prefetch_oto = %f\n", __func__, st_vars->dst_y_prefetch_oto);
+	dml_print("DML::%s: dst_y_prefetch_equ = %f\n", __func__, st_vars->dst_y_prefetch_equ);
 #endif
 
-	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
-	Tpre_rounded = dst_y_prefetch_equ * LineTime;
+	st_vars->dst_y_prefetch_equ = dml_floor(4.0 * (st_vars->dst_y_prefetch_equ + 0.125), 1) / 4.0;
+	st_vars->Tpre_rounded = st_vars->dst_y_prefetch_equ * st_vars->LineTime;
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, dst_y_prefetch_equ);
-	dml_print("DML::%s: LineTime: %f\n", __func__, LineTime);
+	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, st_vars->dst_y_prefetch_equ);
+	dml_print("DML::%s: LineTime: %f\n", __func__, st_vars->LineTime);
 	dml_print("DML::%s: VStartup: %d\n", __func__, VStartup);
 	dml_print("DML::%s: Tvstartup: %fus - time between vstartup and first pixel of active\n",
-			__func__, VStartup * LineTime);
+			__func__, VStartup * st_vars->LineTime);
 	dml_print("DML::%s: TSetup: %fus - time from vstartup to vready\n", __func__, *TSetup);
 	dml_print("DML::%s: TCalc: %fus - time for calculations in dchub starting at vready\n", __func__, TCalc);
-	dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n", __func__, Tdmbf);
-	dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, Tdmec);
+	dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n", __func__, st_vars->Tdmbf);
+	dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, st_vars->Tdmec);
 	dml_print("DML::%s: Tdmdl_vm: %fus - time for vm stages of dmd\n", __func__, *Tdmdl_vm);
 	dml_print("DML::%s: Tdmdl: %fus - time for fabric to become ready and fetch dmd\n", __func__, *Tdmdl);
 	dml_print("DML::%s: DSTYAfterScaler: %d lines - number of lines of pipeline and buffer delay after scaler\n",
 			__func__, *DSTYAfterScaler);
 #endif
-	dep_bytes = dml_max(PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor,
+	st_vars->dep_bytes = dml_max(PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor,
 			MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor);
 
-	if (prefetch_sw_bytes < dep_bytes)
-		prefetch_sw_bytes = 2 * dep_bytes;
+	if (st_vars->prefetch_sw_bytes < st_vars->dep_bytes)
+		st_vars->prefetch_sw_bytes = 2 * st_vars->dep_bytes;
 
 	*PrefetchBandwidth = 0;
 	*DestinationLinesToRequestVMInVBlank = 0;
@@ -3691,61 +3665,61 @@ bool dml32_CalculatePrefetchSchedule(
 	*VRatioPrefetchY = 0;
 	*VRatioPrefetchC = 0;
 	*RequiredPrefetchPixDataBWLuma = 0;
-	if (dst_y_prefetch_equ > 1) {
+	if (st_vars->dst_y_prefetch_equ > 1) {
 		double PrefetchBandwidth1;
 		double PrefetchBandwidth2;
 		double PrefetchBandwidth3;
 		double PrefetchBandwidth4;
 
-		if (Tpre_rounded - *Tno_bw > 0) {
+		if (st_vars->Tpre_rounded - *Tno_bw > 0) {
 			PrefetchBandwidth1 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + 2 * MetaRowByte
 					+ 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor
-					+ prefetch_sw_bytes) / (Tpre_rounded - *Tno_bw);
-			Tsw_est1 = prefetch_sw_bytes / PrefetchBandwidth1;
+					+ st_vars->prefetch_sw_bytes) / (st_vars->Tpre_rounded - *Tno_bw);
+			st_vars->Tsw_est1 = st_vars->prefetch_sw_bytes / PrefetchBandwidth1;
 		} else
 			PrefetchBandwidth1 = 0;
 
-		if (VStartup == MaxVStartup && (Tsw_est1 / LineTime < min_Lsw)
-				&& Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - *Tno_bw > 0) {
+		if (VStartup == MaxVStartup && (st_vars->Tsw_est1 / st_vars->LineTime < st_vars->min_Lsw)
+				&& st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - *Tno_bw > 0) {
 			PrefetchBandwidth1 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + 2 * MetaRowByte
 					+ 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-					/ (Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - *Tno_bw);
+					/ (st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - *Tno_bw);
 		}
 
-		if (Tpre_rounded - *Tno_bw - 2 * Tr0_trips_rounded > 0)
-			PrefetchBandwidth2 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + prefetch_sw_bytes) /
-			(Tpre_rounded - *Tno_bw - 2 * Tr0_trips_rounded);
+		if (st_vars->Tpre_rounded - *Tno_bw - 2 * st_vars->Tr0_trips_rounded > 0)
+			PrefetchBandwidth2 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + st_vars->prefetch_sw_bytes) /
+			(st_vars->Tpre_rounded - *Tno_bw - 2 * st_vars->Tr0_trips_rounded);
 		else
 			PrefetchBandwidth2 = 0;
 
-		if (Tpre_rounded - Tvm_trips_rounded > 0) {
+		if (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded > 0) {
 			PrefetchBandwidth3 = (2 * MetaRowByte + 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor
-					+ prefetch_sw_bytes) / (Tpre_rounded - Tvm_trips_rounded);
-			Tsw_est3 = prefetch_sw_bytes / PrefetchBandwidth3;
+					+ st_vars->prefetch_sw_bytes) / (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded);
+			st_vars->Tsw_est3 = st_vars->prefetch_sw_bytes / PrefetchBandwidth3;
 		} else
 			PrefetchBandwidth3 = 0;
 
 
 		if (VStartup == MaxVStartup &&
-				(Tsw_est3 / LineTime < min_Lsw) && Tpre_rounded - min_Lsw * LineTime - 0.75 *
-				LineTime - Tvm_trips_rounded > 0) {
+				(st_vars->Tsw_est3 / st_vars->LineTime < st_vars->min_Lsw) && st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 *
+				st_vars->LineTime - st_vars->Tvm_trips_rounded > 0) {
 			PrefetchBandwidth3 = (2 * MetaRowByte + 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-					/ (Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - Tvm_trips_rounded);
+					/ (st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - st_vars->Tvm_trips_rounded);
 		}
 
-		if (Tpre_rounded - Tvm_trips_rounded - 2 * Tr0_trips_rounded > 0) {
-			PrefetchBandwidth4 = prefetch_sw_bytes /
-					(Tpre_rounded - Tvm_trips_rounded - 2 * Tr0_trips_rounded);
+		if (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded - 2 * st_vars->Tr0_trips_rounded > 0) {
+			PrefetchBandwidth4 = st_vars->prefetch_sw_bytes /
+					(st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded - 2 * st_vars->Tr0_trips_rounded);
 		} else {
 			PrefetchBandwidth4 = 0;
 		}
 
 #ifdef __DML_VBA_DEBUG__
-		dml_print("DML::%s: Tpre_rounded: %f\n", __func__, Tpre_rounded);
+		dml_print("DML::%s: Tpre_rounded: %f\n", __func__, st_vars->Tpre_rounded);
 		dml_print("DML::%s: Tno_bw: %f\n", __func__, *Tno_bw);
-		dml_print("DML::%s: Tvm_trips_rounded: %f\n", __func__, Tvm_trips_rounded);
-		dml_print("DML::%s: Tsw_est1: %f\n", __func__, Tsw_est1);
-		dml_print("DML::%s: Tsw_est3: %f\n", __func__, Tsw_est3);
+		dml_print("DML::%s: Tvm_trips_rounded: %f\n", __func__, st_vars->Tvm_trips_rounded);
+		dml_print("DML::%s: Tsw_est1: %f\n", __func__, st_vars->Tsw_est1);
+		dml_print("DML::%s: Tsw_est3: %f\n", __func__, st_vars->Tsw_est3);
 		dml_print("DML::%s: PrefetchBandwidth1: %f\n", __func__, PrefetchBandwidth1);
 		dml_print("DML::%s: PrefetchBandwidth2: %f\n", __func__, PrefetchBandwidth2);
 		dml_print("DML::%s: PrefetchBandwidth3: %f\n", __func__, PrefetchBandwidth3);
@@ -3758,9 +3732,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth1 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth1
-						>= Tvm_trips_rounded
+						>= st_vars->Tvm_trips_rounded
 						&& (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-								/ PrefetchBandwidth1 >= Tr0_trips_rounded) {
+								/ PrefetchBandwidth1 >= st_vars->Tr0_trips_rounded) {
 					Case1OK = true;
 				} else {
 					Case1OK = false;
@@ -3771,9 +3745,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth2 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth2
-						>= Tvm_trips_rounded
+						>= st_vars->Tvm_trips_rounded
 						&& (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-						/ PrefetchBandwidth2 < Tr0_trips_rounded) {
+						/ PrefetchBandwidth2 < st_vars->Tr0_trips_rounded) {
 					Case2OK = true;
 				} else {
 					Case2OK = false;
@@ -3784,9 +3758,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth3 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth3 <
-						Tvm_trips_rounded && (MetaRowByte + PixelPTEBytesPerRow *
+						st_vars->Tvm_trips_rounded && (MetaRowByte + PixelPTEBytesPerRow *
 								HostVMInefficiencyFactor) / PrefetchBandwidth3 >=
-								Tr0_trips_rounded) {
+								st_vars->Tr0_trips_rounded) {
 					Case3OK = true;
 				} else {
 					Case3OK = false;
@@ -3796,80 +3770,80 @@ bool dml32_CalculatePrefetchSchedule(
 			}
 
 			if (Case1OK)
-				prefetch_bw_equ = PrefetchBandwidth1;
+				st_vars->prefetch_bw_equ = PrefetchBandwidth1;
 			else if (Case2OK)
-				prefetch_bw_equ = PrefetchBandwidth2;
+				st_vars->prefetch_bw_equ = PrefetchBandwidth2;
 			else if (Case3OK)
-				prefetch_bw_equ = PrefetchBandwidth3;
+				st_vars->prefetch_bw_equ = PrefetchBandwidth3;
 			else
-				prefetch_bw_equ = PrefetchBandwidth4;
+				st_vars->prefetch_bw_equ = PrefetchBandwidth4;
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: Case1OK: %d\n", __func__, Case1OK);
 			dml_print("DML::%s: Case2OK: %d\n", __func__, Case2OK);
 			dml_print("DML::%s: Case3OK: %d\n", __func__, Case3OK);
-			dml_print("DML::%s: prefetch_bw_equ: %f\n", __func__, prefetch_bw_equ);
+			dml_print("DML::%s: prefetch_bw_equ: %f\n", __func__, st_vars->prefetch_bw_equ);
 #endif
 
-			if (prefetch_bw_equ > 0) {
+			if (st_vars->prefetch_bw_equ > 0) {
 				if (GPUVMEnable == true) {
-					Tvm_equ = dml_max3(*Tno_bw + PDEAndMetaPTEBytesFrame *
-							HostVMInefficiencyFactor / prefetch_bw_equ,
-							Tvm_trips, LineTime / 4);
+					st_vars->Tvm_equ = dml_max3(*Tno_bw + PDEAndMetaPTEBytesFrame *
+							HostVMInefficiencyFactor / st_vars->prefetch_bw_equ,
+							st_vars->Tvm_trips, st_vars->LineTime / 4);
 				} else {
-					Tvm_equ = LineTime / 4;
+					st_vars->Tvm_equ = st_vars->LineTime / 4;
 				}
 
 				if ((GPUVMEnable == true || myPipe->DCCEnable == true)) {
-					Tr0_equ = dml_max4((MetaRowByte + PixelPTEBytesPerRow *
-							HostVMInefficiencyFactor) / prefetch_bw_equ, Tr0_trips,
-							(LineTime - Tvm_equ) / 2, LineTime / 4);
+					st_vars->Tr0_equ = dml_max4((MetaRowByte + PixelPTEBytesPerRow *
+							HostVMInefficiencyFactor) / st_vars->prefetch_bw_equ, st_vars->Tr0_trips,
+							(st_vars->LineTime - st_vars->Tvm_equ) / 2, st_vars->LineTime / 4);
 				} else {
-					Tr0_equ = (LineTime - Tvm_equ) / 2;
+					st_vars->Tr0_equ = (st_vars->LineTime - st_vars->Tvm_equ) / 2;
 				}
 			} else {
-				Tvm_equ = 0;
-				Tr0_equ = 0;
+				st_vars->Tvm_equ = 0;
+				st_vars->Tr0_equ = 0;
 #ifdef __DML_VBA_DEBUG__
 				dml_print("DML: prefetch_bw_equ equals 0! %s:%d\n", __FILE__, __LINE__);
 #endif
 			}
 		}
 
-		if (dst_y_prefetch_oto < dst_y_prefetch_equ) {
-			*DestinationLinesForPrefetch = dst_y_prefetch_oto;
-			TimeForFetchingMetaPTE = Tvm_oto;
-			TimeForFetchingRowInVBlank = Tr0_oto;
-			*PrefetchBandwidth = prefetch_bw_oto;
+		if (st_vars->dst_y_prefetch_oto < st_vars->dst_y_prefetch_equ) {
+			*DestinationLinesForPrefetch = st_vars->dst_y_prefetch_oto;
+			st_vars->TimeForFetchingMetaPTE = st_vars->Tvm_oto;
+			st_vars->TimeForFetchingRowInVBlank = st_vars->Tr0_oto;
+			*PrefetchBandwidth = st_vars->prefetch_bw_oto;
 		} else {
-			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
-			TimeForFetchingMetaPTE = Tvm_equ;
-			TimeForFetchingRowInVBlank = Tr0_equ;
-			*PrefetchBandwidth = prefetch_bw_equ;
+			*DestinationLinesForPrefetch = st_vars->dst_y_prefetch_equ;
+			st_vars->TimeForFetchingMetaPTE = st_vars->Tvm_equ;
+			st_vars->TimeForFetchingRowInVBlank = st_vars->Tr0_equ;
+			*PrefetchBandwidth = st_vars->prefetch_bw_equ;
 		}
 
-		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
+		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * st_vars->TimeForFetchingMetaPTE / st_vars->LineTime, 1.0) / 4.0;
 
 		*DestinationLinesToRequestRowInVBlank =
-				dml_ceil(4.0 * TimeForFetchingRowInVBlank / LineTime, 1.0) / 4.0;
+				dml_ceil(4.0 * st_vars->TimeForFetchingRowInVBlank / st_vars->LineTime, 1.0) / 4.0;
 
-		LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
+		st_vars->LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
 				*DestinationLinesToRequestVMInVBlank - 2 * *DestinationLinesToRequestRowInVBlank;
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: DestinationLinesForPrefetch = %f\n", __func__, *DestinationLinesForPrefetch);
 		dml_print("DML::%s: DestinationLinesToRequestVMInVBlank = %f\n",
 				__func__, *DestinationLinesToRequestVMInVBlank);
-		dml_print("DML::%s: TimeForFetchingRowInVBlank = %f\n", __func__, TimeForFetchingRowInVBlank);
-		dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
+		dml_print("DML::%s: TimeForFetchingRowInVBlank = %f\n", __func__, st_vars->TimeForFetchingRowInVBlank);
+		dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
 		dml_print("DML::%s: DestinationLinesToRequestRowInVBlank = %f\n",
 				__func__, *DestinationLinesToRequestRowInVBlank);
 		dml_print("DML::%s: PrefetchSourceLinesY = %f\n", __func__, PrefetchSourceLinesY);
-		dml_print("DML::%s: LinesToRequestPrefetchPixelData = %f\n", __func__, LinesToRequestPrefetchPixelData);
+		dml_print("DML::%s: LinesToRequestPrefetchPixelData = %f\n", __func__, st_vars->LinesToRequestPrefetchPixelData);
 #endif
 
-		if (LinesToRequestPrefetchPixelData >= 1 && prefetch_bw_equ > 0) {
-			*VRatioPrefetchY = (double) PrefetchSourceLinesY / LinesToRequestPrefetchPixelData;
+		if (st_vars->LinesToRequestPrefetchPixelData >= 1 && st_vars->prefetch_bw_equ > 0) {
+			*VRatioPrefetchY = (double) PrefetchSourceLinesY / st_vars->LinesToRequestPrefetchPixelData;
 			*VRatioPrefetchY = dml_max(*VRatioPrefetchY, 1.0);
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: VRatioPrefetchY = %f\n", __func__, *VRatioPrefetchY);
@@ -3877,12 +3851,12 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: VInitPreFillY = %d\n", __func__, VInitPreFillY);
 #endif
 			if ((SwathHeightY > 4) && (VInitPreFillY > 3)) {
-				if (LinesToRequestPrefetchPixelData > (VInitPreFillY - 3.0) / 2.0) {
+				if (st_vars->LinesToRequestPrefetchPixelData > (VInitPreFillY - 3.0) / 2.0) {
 					*VRatioPrefetchY =
 							dml_max((double) PrefetchSourceLinesY /
-									LinesToRequestPrefetchPixelData,
+									st_vars->LinesToRequestPrefetchPixelData,
 									(double) MaxNumSwathY * SwathHeightY /
-									(LinesToRequestPrefetchPixelData -
+									(st_vars->LinesToRequestPrefetchPixelData -
 									(VInitPreFillY - 3.0) / 2.0));
 					*VRatioPrefetchY = dml_max(*VRatioPrefetchY, 1.0);
 				} else {
@@ -3896,7 +3870,7 @@ bool dml32_CalculatePrefetchSchedule(
 #endif
 			}
 
-			*VRatioPrefetchC = (double) PrefetchSourceLinesC / LinesToRequestPrefetchPixelData;
+			*VRatioPrefetchC = (double) PrefetchSourceLinesC / st_vars->LinesToRequestPrefetchPixelData;
 			*VRatioPrefetchC = dml_max(*VRatioPrefetchC, 1.0);
 
 #ifdef __DML_VBA_DEBUG__
@@ -3905,11 +3879,11 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: VInitPreFillC = %d\n", __func__, VInitPreFillC);
 #endif
 			if ((SwathHeightC > 4)) {
-				if (LinesToRequestPrefetchPixelData > (VInitPreFillC - 3.0) / 2.0) {
+				if (st_vars->LinesToRequestPrefetchPixelData > (VInitPreFillC - 3.0) / 2.0) {
 					*VRatioPrefetchC =
 						dml_max(*VRatioPrefetchC,
 							(double) MaxNumSwathC * SwathHeightC /
-							(LinesToRequestPrefetchPixelData -
+							(st_vars->LinesToRequestPrefetchPixelData -
 							(VInitPreFillC - 3.0) / 2.0));
 					*VRatioPrefetchC = dml_max(*VRatioPrefetchC, 1.0);
 				} else {
@@ -3924,25 +3898,25 @@ bool dml32_CalculatePrefetchSchedule(
 			}
 
 			*RequiredPrefetchPixDataBWLuma = (double) PrefetchSourceLinesY
-					/ LinesToRequestPrefetchPixelData * myPipe->BytePerPixelY * swath_width_luma_ub
-					/ LineTime;
+					/ st_vars->LinesToRequestPrefetchPixelData * myPipe->BytePerPixelY * swath_width_luma_ub
+					/ st_vars->LineTime;
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: BytePerPixelY = %d\n", __func__, myPipe->BytePerPixelY);
 			dml_print("DML::%s: swath_width_luma_ub = %d\n", __func__, swath_width_luma_ub);
-			dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
+			dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
 			dml_print("DML::%s: RequiredPrefetchPixDataBWLuma = %f\n",
 					__func__, *RequiredPrefetchPixDataBWLuma);
 #endif
 			*RequiredPrefetchPixDataBWChroma = (double) PrefetchSourceLinesC /
-					LinesToRequestPrefetchPixelData
+					st_vars->LinesToRequestPrefetchPixelData
 					* myPipe->BytePerPixelC
-					* swath_width_chroma_ub / LineTime;
+					* swath_width_chroma_ub / st_vars->LineTime;
 		} else {
 			MyError = true;
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML:%s: MyErr set. LinesToRequestPrefetchPixelData: %f, should be > 0\n",
-					__func__, LinesToRequestPrefetchPixelData);
+					__func__, st_vars->LinesToRequestPrefetchPixelData);
 #endif
 			*VRatioPrefetchY = 0;
 			*VRatioPrefetchC = 0;
@@ -3951,15 +3925,15 @@ bool dml32_CalculatePrefetchSchedule(
 		}
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML: Tpre: %fus - sum of time to request meta pte, 2 x data pte + meta data, swaths\n",
-			(double)LinesToRequestPrefetchPixelData * LineTime +
-			2.0*TimeForFetchingRowInVBlank + TimeForFetchingMetaPTE);
-		dml_print("DML:  Tvm: %fus - time to fetch page tables for meta surface\n", TimeForFetchingMetaPTE);
+			(double)st_vars->LinesToRequestPrefetchPixelData * st_vars->LineTime +
+			2.0*st_vars->TimeForFetchingRowInVBlank + st_vars->TimeForFetchingMetaPTE);
+		dml_print("DML:  Tvm: %fus - time to fetch page tables for meta surface\n", st_vars->TimeForFetchingMetaPTE);
 		dml_print("DML: To: %fus - time for propagation from scaler to optc\n",
-			(*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime);
+			(*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * st_vars->LineTime);
 		dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre - To > 0\n");
-		dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", VStartup * LineTime -
-			TimeForFetchingMetaPTE - 2*TimeForFetchingRowInVBlank - (*DSTYAfterScaler +
-			((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime - TWait - TCalc - *TSetup);
+		dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", VStartup * st_vars->LineTime -
+			st_vars->TimeForFetchingMetaPTE - 2*st_vars->TimeForFetchingRowInVBlank - (*DSTYAfterScaler +
+			((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * st_vars->LineTime - TWait - TCalc - *TSetup);
 		dml_print("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %d\n",
 				PixelPTEBytesPerRow);
 #endif
@@ -3967,7 +3941,7 @@ bool dml32_CalculatePrefetchSchedule(
 		MyError = true;
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: MyErr set, dst_y_prefetch_equ = %f (should be > 1)\n",
-				__func__, dst_y_prefetch_equ);
+				__func__, st_vars->dst_y_prefetch_equ);
 #endif
 	}
 
@@ -3983,10 +3957,10 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: HostVMInefficiencyFactor = %f\n", __func__, HostVMInefficiencyFactor);
 			dml_print("DML::%s: DestinationLinesToRequestVMInVBlank = %f\n",
 					__func__, *DestinationLinesToRequestVMInVBlank);
-			dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
+			dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
 #endif
 			prefetch_vm_bw = PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor /
-					(*DestinationLinesToRequestVMInVBlank * LineTime);
+					(*DestinationLinesToRequestVMInVBlank * st_vars->LineTime);
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: prefetch_vm_bw = %f\n", __func__, prefetch_vm_bw);
 #endif
@@ -4003,7 +3977,7 @@ bool dml32_CalculatePrefetchSchedule(
 			prefetch_row_bw = 0;
 		} else if (*DestinationLinesToRequestRowInVBlank > 0) {
 			prefetch_row_bw = (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) /
-					(*DestinationLinesToRequestRowInVBlank * LineTime);
+					(*DestinationLinesToRequestRowInVBlank * st_vars->LineTime);
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: MetaRowByte = %d\n", __func__, MetaRowByte);
@@ -4026,12 +4000,12 @@ bool dml32_CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
+		st_vars->TimeForFetchingMetaPTE = 0;
+		st_vars->TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
+		st_vars->LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index ecd4f1e7d1f7..37a314ce284b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -715,6 +715,7 @@ double dml32_CalculateExtraLatency(
 		unsigned int HostVMMaxNonCachedPageTableLevels);
 
 bool dml32_CalculatePrefetchSchedule(
+		struct dml32_CalculatePrefetchSchedule *st_vars,
 		double HostVMInefficiencyFactor,
 		DmlPipe *myPipe,
 		unsigned int DSCDelay,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 42e4e4c5e656..8460aefe7b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -247,6 +247,43 @@ struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport {
 	unsigned int LBLatencyHidingSourceLinesC[DC__NUM_DPP__MAX];
 };
 
+struct dml32_CalculatePrefetchSchedule {
+	unsigned int DPPCycles, DISPCLKCycles;
+	double DSTTotalPixelsAfterScaler;
+	double LineTime;
+	double dst_y_prefetch_equ;
+	double prefetch_bw_oto;
+	double Tvm_oto;
+	double Tr0_oto;
+	double Tvm_oto_lines;
+	double Tr0_oto_lines;
+	double dst_y_prefetch_oto;
+	double TimeForFetchingMetaPTE;
+	double TimeForFetchingRowInVBlank;
+	double LinesToRequestPrefetchPixelData;
+	unsigned int HostVMDynamicLevelsTrips;
+	double trip_to_mem;
+	double Tvm_trips;
+	double Tr0_trips;
+	double Tvm_trips_rounded;
+	double Tr0_trips_rounded;
+	double Lsw_oto;
+	double Tpre_rounded;
+	double prefetch_bw_equ;
+	double Tvm_equ;
+	double Tr0_equ;
+	double Tdmbf;
+	double Tdmec;
+	double Tdmsks;
+	double prefetch_sw_bytes;
+	double bytes_pp;
+	double dep_bytes;
+	unsigned int max_vratio_pre;
+	double min_Lsw;
+	double Tsw_est1;
+	double Tsw_est3;
+};
+
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -321,6 +358,7 @@ struct dummy_vars {
 	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
 	struct dml32_CalculateVMRowAndSwath dml32_CalculateVMRowAndSwath;
 	struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport;
+	struct dml32_CalculatePrefetchSchedule dml32_CalculatePrefetchSchedule;
 };
 
 struct vba_vars_st {
-- 
2.35.3

