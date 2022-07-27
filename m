Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623A6C19F21
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A2DC784D;
	Wed, 27 Jul 2022 22:19:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF86DC78A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrRxd7/G//9E8b7vXiZYPiGERjEuunPUx2kPXF31P4j8h4KID5HFZo53TM+uqLqkFbWnXfy2Q0KTKaoco/NkTo7lmXfFBKnhrto1jHcV3FB4HBZ+RlrqQlFqOL6PSxvT47LnAj26M7pBNsGUhJpqWDHLohpZbVt2iF46dWm0FxZzgiFBaC45il5+Izq0zek7T7TY/zAWYIBl3wu+zFWiG0V3InCgtGtYZfRDGhFlG9yi4mIWaaVdArMR51rvnh+ad6Zp7dS/FNu5BVnkPshaBWrClcZd4+bYKAcEALY5JE+oBi8vigGNB012IrzYosuhNHLi7EVwukLTYAZ9EIKdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak8f4g1PmdEboMsymwCY1S5ukdOakmyTk/xFo1VbZtY=;
 b=JasUhwyVKX8yU6wtem43F8IYHUEVHZ8gF8/Vf7ZFa15nLsGugigecqqV7bHrxMngW082Xv90rdKe6uJYmT5/qtsIxrMobVTaaYkoi5H2I7apIRo4iYdEy98wgtKDuzVmgQtSHGLQNKUF4Xmox7TKaOynj+ROlmJcxSuJ6BNPoJpe6Uyos2z/mS4u3C6WjFWqR7RgymyWGhdWIuFqIjZUAqyFzAY0s6XsRG7tA8h6xhJWhBxxMWiwJzOjfRyipSjxDYhA6XxSf0YoD170TTUj8YgTmM33A32ns1BgNb/KzKZC8l0rzsy5oZqDmNgh9+OhBFMVVOZvNJpUFamhlwjn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak8f4g1PmdEboMsymwCY1S5ukdOakmyTk/xFo1VbZtY=;
 b=MY+051MCRkSGz4vAgpBLh5bDNjZpiNEUlT3r0kVtZfa9ePtpjevR0TN+JUMRvmoR5k9uaEC9KvvOZQ1G6G1jjfHMw7C3eC6Kn8OGpv9gUKWeODaMo8LM0z/zTWyQPL6bGJEKZQR7dKv9q7EJvGIP8ZIjr4Lz/HiBl4uXlyBZGZc=
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 22:19:23 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::76) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 22:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 22:19:22 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 17:19:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] Revert "drm/amd/display: reduce stack for
 dml32_CalculatePrefetchSchedule"
Date: Wed, 27 Jul 2022 18:18:52 -0400
Message-ID: <20220727221855.324361-2-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d43b331-6358-4057-3908-08da701e0eeb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aH0J7CHI5RQHAtIdGCHYDJlryEoPIza2FD6fgudORwf9kH61bCTLus9vugttlNpbDXxH6Cg05QNrTTKRkQKW160IalR3CxlZlHayKFyrct68GC7lhAarJ7H6WSFn0mqSuvd0RB9paBVmwE857sXcK9I3G2ckxITJq1cREmldkL6qk0w5jJVGS2oj0T9XGPc8hplLvQ7Zgq+CoCm4AiXeSbW0ptXlSEyVk4xAxj8bMaL7yA3dh4S7wLeNlqnfdQ5B+YcKBqmKfMMMhl4YgTsFJvhqQ4HCjr9bF4acHnFsKiwNcXbh/NfbtFvk/VOHgOfqtR/CYd32ysMgGQFAcD3iNFn7QTB+HrJcg9GTOS2Vd1NtkvNhpvHPc5PR2b5BUuV9O3NZu2wtuyGQpQ9qhCghLw7Q9tVVBtSU6Ko+AWX4WYOv8YU73bUifbMrzWPghNoD3cJiZb8Ljm+13K0+3gYzCa5mNcmg+myCmPNH2rPSUMteq/oiPMgg5/w3QsuV6HOikL912A3Ui68Tmx6CzANJOYIsL4F9Rj3jHXXhOpRvvZNlPuUpsmh3pXKq1upIBLxjSJ0wuvrHo55dc5Kg7OUBPZMC7rAVPrrOJ1B59VJPa+tB50t7ClXPN7zq87NjT5FyotG8+rLDQlXv1xDXb1GC/tBVZtj4lzD64fFgjWaaeNuzi3enA/xlfgOuVTEGZRl0o/lPDmbqon1QSBDT9dbWXQ5RlkYdDznuTWJ1vOe8DOnQJrojujxlUgekIHmXK588cjbXaOXuLIzHc4ZlcRH/E3fOudmHcmpd9iD21HxwLW8bH2/HCoCVvfiC0149Aq5USwKyteRpeKrNfgPUS75O/MTjRxPKtElPbdrTSrE6IVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(6666004)(16526019)(8676002)(186003)(81166007)(336012)(8936002)(2906002)(1076003)(36756003)(86362001)(6916009)(83380400001)(478600001)(7696005)(2616005)(41300700001)(426003)(40460700003)(54906003)(47076005)(26005)(36860700001)(30864003)(40480700001)(19627235002)(5660300002)(316002)(82740400003)(70586007)(70206006)(356005)(82310400005)(4326008)(36900700001)(579004)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:19:22.6254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d43b331-6358-4057-3908-08da701e0eeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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

This reverts commit 361e705e712d2255f5b0f6e6cc69687043d4fcc9.

This commit was a part of a patchset responsible for reducing the stack
size. However, after some other changes, this commit becomes
unnecessary, so we are reverting it here.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   5 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 394 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  38 --
 4 files changed, 211 insertions(+), 227 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 890612db08dc..04f1eefdabe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -757,9 +757,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelY = v->BytePerPixelY[k];
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelC = v->BytePerPixelC[k];
 			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
-			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(
-					&v->dummy_vars.dml32_CalculatePrefetchSchedule,
-					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
+			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
 					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe, v->DSCDelay[k],
 					mode_lib->vba.DPPCLKDelaySubtotal + mode_lib->vba.DPPCLKDelayCNVCFormater,
 					mode_lib->vba.DPPCLKDelaySCL,
@@ -3266,7 +3264,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
 						dml32_CalculatePrefetchSchedule(
-							&v->dummy_vars.dml32_CalculatePrefetchSchedule,
 							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
 							mode_lib->vba.DSCDelayPerState[i][k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 07f8f3b8626b..54dde0ea424a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3342,7 +3342,6 @@ double dml32_CalculateExtraLatency(
 } // CalculateExtraLatency
 
 bool dml32_CalculatePrefetchSchedule(
-		struct dml32_CalculatePrefetchSchedule *st_vars,
 		double HostVMInefficiencyFactor,
 		DmlPipe *myPipe,
 		unsigned int DSCDelay,
@@ -3406,18 +3405,45 @@ bool dml32_CalculatePrefetchSchedule(
 		double   *VReadyOffsetPix)
 {
 	bool MyError = false;
-
-	st_vars->TimeForFetchingMetaPTE = 0;
-	st_vars->TimeForFetchingRowInVBlank = 0;
-	st_vars->LinesToRequestPrefetchPixelData = 0;
-	st_vars->max_vratio_pre = __DML_MAX_VRATIO_PRE__;
-	st_vars->Tsw_est1 = 0;
-	st_vars->Tsw_est3 = 0;
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
+	double TimeForFetchingMetaPTE = 0;
+	double TimeForFetchingRowInVBlank = 0;
+	double LinesToRequestPrefetchPixelData = 0;
+	unsigned int HostVMDynamicLevelsTrips;
+	double  trip_to_mem;
+	double  Tvm_trips;
+	double  Tr0_trips;
+	double  Tvm_trips_rounded;
+	double  Tr0_trips_rounded;
+	double  Lsw_oto;
+	double  Tpre_rounded;
+	double  prefetch_bw_equ;
+	double  Tvm_equ;
+	double  Tr0_equ;
+	double  Tdmbf;
+	double  Tdmec;
+	double  Tdmsks;
+	double  prefetch_sw_bytes;
+	double  bytes_pp;
+	double  dep_bytes;
+	unsigned int max_vratio_pre = __DML_MAX_VRATIO_PRE__;
+	double  min_Lsw;
+	double  Tsw_est1 = 0;
+	double  Tsw_est3 = 0;
 
 	if (GPUVMEnable == true && HostVMEnable == true)
-		st_vars->HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
+		HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
 	else
-		st_vars->HostVMDynamicLevelsTrips = 0;
+		HostVMDynamicLevelsTrips = 0;
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: GPUVMEnable = %d\n", __func__, GPUVMEnable);
 	dml_print("DML::%s: GPUVMPageTableLevels = %d\n", __func__, GPUVMPageTableLevels);
@@ -3440,19 +3466,19 @@ bool dml32_CalculatePrefetchSchedule(
 			TSetup,
 
 			/* output */
-			&st_vars->Tdmbf,
-			&st_vars->Tdmec,
-			&st_vars->Tdmsks,
+			&Tdmbf,
+			&Tdmec,
+			&Tdmsks,
 			VUpdateOffsetPix,
 			VUpdateWidthPix,
 			VReadyOffsetPix);
 
-	st_vars->LineTime = myPipe->HTotal / myPipe->PixelClock;
-	st_vars->trip_to_mem = UrgentLatency;
-	st_vars->Tvm_trips = UrgentExtraLatency + st_vars->trip_to_mem * (GPUVMPageTableLevels * (st_vars->HostVMDynamicLevelsTrips + 1) - 1);
+	LineTime = myPipe->HTotal / myPipe->PixelClock;
+	trip_to_mem = UrgentLatency;
+	Tvm_trips = UrgentExtraLatency + trip_to_mem * (GPUVMPageTableLevels * (HostVMDynamicLevelsTrips + 1) - 1);
 
 	if (DynamicMetadataVMEnabled == true)
-		*Tdmdl = TWait + st_vars->Tvm_trips + st_vars->trip_to_mem;
+		*Tdmdl = TWait + Tvm_trips + trip_to_mem;
 	else
 		*Tdmdl = TWait + UrgentExtraLatency;
 
@@ -3462,15 +3488,15 @@ bool dml32_CalculatePrefetchSchedule(
 #endif
 
 	if (DynamicMetadataEnable == true) {
-		if (VStartup * st_vars->LineTime < *TSetup + *Tdmdl + st_vars->Tdmbf + st_vars->Tdmec + st_vars->Tdmsks) {
+		if (VStartup * LineTime < *TSetup + *Tdmdl + Tdmbf + Tdmec + Tdmsks) {
 			*NotEnoughTimeForDynamicMetadata = true;
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: Not Enough Time for Dynamic Meta!\n", __func__);
 			dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n",
-					__func__, st_vars->Tdmbf);
-			dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, st_vars->Tdmec);
+					__func__, Tdmbf);
+			dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, Tdmec);
 			dml_print("DML::%s: Tdmsks: %fus - time before active dmd must complete transmission at dio\n",
-					__func__, st_vars->Tdmsks);
+					__func__, Tdmsks);
 			dml_print("DML::%s: Tdmdl: %fus - time for fabric to become ready and fetch dmd\n",
 					__func__, *Tdmdl);
 #endif
@@ -3482,21 +3508,21 @@ bool dml32_CalculatePrefetchSchedule(
 	}
 
 	*Tdmdl_vm =  (DynamicMetadataEnable == true && DynamicMetadataVMEnabled == true &&
-			GPUVMEnable == true ? TWait + st_vars->Tvm_trips : 0);
+			GPUVMEnable == true ? TWait + Tvm_trips : 0);
 
 	if (myPipe->ScalerEnabled)
-		st_vars->DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCL;
+		DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCL;
 	else
-		st_vars->DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCLLBOnly;
+		DPPCycles = DPPCLKDelaySubtotalPlusCNVCFormater + DPPCLKDelaySCLLBOnly;
 
-	st_vars->DPPCycles = st_vars->DPPCycles + myPipe->NumberOfCursors * DPPCLKDelayCNVCCursor;
+	DPPCycles = DPPCycles + myPipe->NumberOfCursors * DPPCLKDelayCNVCCursor;
 
-	st_vars->DISPCLKCycles = DISPCLKDelaySubtotal;
+	DISPCLKCycles = DISPCLKDelaySubtotal;
 
 	if (myPipe->Dppclk == 0.0 || myPipe->Dispclk == 0.0)
 		return true;
 
-	*DSTXAfterScaler = st_vars->DPPCycles * myPipe->PixelClock / myPipe->Dppclk + st_vars->DISPCLKCycles *
+	*DSTXAfterScaler = DPPCycles * myPipe->PixelClock / myPipe->Dppclk + DISPCLKCycles *
 			myPipe->PixelClock / myPipe->Dispclk + DSCDelay;
 
 	*DSTXAfterScaler = *DSTXAfterScaler + (myPipe->ODMMode != dm_odm_combine_mode_disabled ? 18 : 0)
@@ -3506,10 +3532,10 @@ bool dml32_CalculatePrefetchSchedule(
 			+ ((myPipe->ODMMode == dm_odm_mode_mso_1to4) ? myPipe->HActive * 3 / 4 : 0);
 
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: DPPCycles: %d\n", __func__, st_vars->DPPCycles);
+	dml_print("DML::%s: DPPCycles: %d\n", __func__, DPPCycles);
 	dml_print("DML::%s: PixelClock: %f\n", __func__, myPipe->PixelClock);
 	dml_print("DML::%s: Dppclk: %f\n", __func__, myPipe->Dppclk);
-	dml_print("DML::%s: DISPCLKCycles: %d\n", __func__, st_vars->DISPCLKCycles);
+	dml_print("DML::%s: DISPCLKCycles: %d\n", __func__, DISPCLKCycles);
 	dml_print("DML::%s: DISPCLK: %f\n", __func__,  myPipe->Dispclk);
 	dml_print("DML::%s: DSCDelay: %d\n", __func__,  DSCDelay);
 	dml_print("DML::%s: ODMMode: %d\n", __func__,  myPipe->ODMMode);
@@ -3522,9 +3548,9 @@ bool dml32_CalculatePrefetchSchedule(
 	else
 		*DSTYAfterScaler = 0;
 
-	st_vars->DSTTotalPixelsAfterScaler = *DSTYAfterScaler * myPipe->HTotal + *DSTXAfterScaler;
-	*DSTYAfterScaler = dml_floor(st_vars->DSTTotalPixelsAfterScaler / myPipe->HTotal, 1);
-	*DSTXAfterScaler = st_vars->DSTTotalPixelsAfterScaler - ((double) (*DSTYAfterScaler * myPipe->HTotal));
+	DSTTotalPixelsAfterScaler = *DSTYAfterScaler * myPipe->HTotal + *DSTXAfterScaler;
+	*DSTYAfterScaler = dml_floor(DSTTotalPixelsAfterScaler / myPipe->HTotal, 1);
+	*DSTXAfterScaler = DSTTotalPixelsAfterScaler - ((double) (*DSTYAfterScaler * myPipe->HTotal));
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: DSTXAfterScaler: %d (final)\n", __func__,  *DSTXAfterScaler);
 	dml_print("DML::%s: DSTYAfterScaler: %d (final)\n", __func__, *DSTYAfterScaler);
@@ -3532,132 +3558,132 @@ bool dml32_CalculatePrefetchSchedule(
 
 	MyError = false;
 
-	st_vars->Tr0_trips = st_vars->trip_to_mem * (st_vars->HostVMDynamicLevelsTrips + 1);
+	Tr0_trips = trip_to_mem * (HostVMDynamicLevelsTrips + 1);
 
 	if (GPUVMEnable == true) {
-		st_vars->Tvm_trips_rounded = dml_ceil(4.0 * st_vars->Tvm_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
-		st_vars->Tr0_trips_rounded = dml_ceil(4.0 * st_vars->Tr0_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
+		Tvm_trips_rounded = dml_ceil(4.0 * Tvm_trips / LineTime, 1.0) / 4.0 * LineTime;
+		Tr0_trips_rounded = dml_ceil(4.0 * Tr0_trips / LineTime, 1.0) / 4.0 * LineTime;
 		if (GPUVMPageTableLevels >= 3) {
-			*Tno_bw = UrgentExtraLatency + st_vars->trip_to_mem *
-					(double) ((GPUVMPageTableLevels - 2) * (st_vars->HostVMDynamicLevelsTrips + 1) - 1);
+			*Tno_bw = UrgentExtraLatency + trip_to_mem *
+					(double) ((GPUVMPageTableLevels - 2) * (HostVMDynamicLevelsTrips + 1) - 1);
 		} else if (GPUVMPageTableLevels == 1 && myPipe->DCCEnable != true) {
-			st_vars->Tr0_trips_rounded = dml_ceil(4.0 * UrgentExtraLatency / st_vars->LineTime, 1.0) /
-					4.0 * st_vars->LineTime; // VBA_ERROR
+			Tr0_trips_rounded = dml_ceil(4.0 * UrgentExtraLatency / LineTime, 1.0) /
+					4.0 * LineTime; // VBA_ERROR
 			*Tno_bw = UrgentExtraLatency;
 		} else {
 			*Tno_bw = 0;
 		}
 	} else if (myPipe->DCCEnable == true) {
-		st_vars->Tvm_trips_rounded = st_vars->LineTime / 4.0;
-		st_vars->Tr0_trips_rounded = dml_ceil(4.0 * st_vars->Tr0_trips / st_vars->LineTime, 1.0) / 4.0 * st_vars->LineTime;
+		Tvm_trips_rounded = LineTime / 4.0;
+		Tr0_trips_rounded = dml_ceil(4.0 * Tr0_trips / LineTime, 1.0) / 4.0 * LineTime;
 		*Tno_bw = 0;
 	} else {
-		st_vars->Tvm_trips_rounded = st_vars->LineTime / 4.0;
-		st_vars->Tr0_trips_rounded = st_vars->LineTime / 2.0;
+		Tvm_trips_rounded = LineTime / 4.0;
+		Tr0_trips_rounded = LineTime / 2.0;
 		*Tno_bw = 0;
 	}
-	st_vars->Tvm_trips_rounded = dml_max(st_vars->Tvm_trips_rounded, st_vars->LineTime / 4.0);
-	st_vars->Tr0_trips_rounded = dml_max(st_vars->Tr0_trips_rounded, st_vars->LineTime / 4.0);
+	Tvm_trips_rounded = dml_max(Tvm_trips_rounded, LineTime / 4.0);
+	Tr0_trips_rounded = dml_max(Tr0_trips_rounded, LineTime / 4.0);
 
 	if (myPipe->SourcePixelFormat == dm_420_8 || myPipe->SourcePixelFormat == dm_420_10
 			|| myPipe->SourcePixelFormat == dm_420_12) {
-		st_vars->bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC / 4;
+		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC / 4;
 	} else {
-		st_vars->bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
+		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
 	}
 
-	st_vars->prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY
+	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY
 			+ PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
-	st_vars->prefetch_bw_oto = dml_max(st_vars->bytes_pp * myPipe->PixelClock / myPipe->DPPPerSurface,
-			st_vars->prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * st_vars->LineTime));
+	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerSurface,
+			prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
 
-	st_vars->min_Lsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / st_vars->max_vratio_pre;
-	st_vars->min_Lsw = dml_max(st_vars->min_Lsw, 1.0);
-	st_vars->Lsw_oto = dml_ceil(4.0 * dml_max(st_vars->prefetch_sw_bytes / st_vars->prefetch_bw_oto / st_vars->LineTime, st_vars->min_Lsw), 1.0) / 4.0;
+	min_Lsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre;
+	min_Lsw = dml_max(min_Lsw, 1.0);
+	Lsw_oto = dml_ceil(4.0 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1.0) / 4.0;
 
 	if (GPUVMEnable == true) {
-		st_vars->Tvm_oto = dml_max3(
-				st_vars->Tvm_trips,
-				*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / st_vars->prefetch_bw_oto,
-				st_vars->LineTime / 4.0);
+		Tvm_oto = dml_max3(
+				Tvm_trips,
+				*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / prefetch_bw_oto,
+				LineTime / 4.0);
 	} else
-		st_vars->Tvm_oto = st_vars->LineTime / 4.0;
+		Tvm_oto = LineTime / 4.0;
 
 	if ((GPUVMEnable == true || myPipe->DCCEnable == true)) {
-		st_vars->Tr0_oto = dml_max4(
-				st_vars->Tr0_trips,
-				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / st_vars->prefetch_bw_oto,
-				(st_vars->LineTime - st_vars->Tvm_oto)/2.0,
-				st_vars->LineTime / 4.0);
+		Tr0_oto = dml_max4(
+				Tr0_trips,
+				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / prefetch_bw_oto,
+				(LineTime - Tvm_oto)/2.0,
+				LineTime / 4.0);
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: Tr0_oto max0 = %f\n", __func__,
-				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / st_vars->prefetch_bw_oto);
-		dml_print("DML::%s: Tr0_oto max1 = %f\n", __func__, st_vars->Tr0_trips);
-		dml_print("DML::%s: Tr0_oto max2 = %f\n", __func__, st_vars->LineTime - st_vars->Tvm_oto);
-		dml_print("DML::%s: Tr0_oto max3 = %f\n", __func__, st_vars->LineTime / 4);
+				(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / prefetch_bw_oto);
+		dml_print("DML::%s: Tr0_oto max1 = %f\n", __func__, Tr0_trips);
+		dml_print("DML::%s: Tr0_oto max2 = %f\n", __func__, LineTime - Tvm_oto);
+		dml_print("DML::%s: Tr0_oto max3 = %f\n", __func__, LineTime / 4);
 #endif
 	} else
-		st_vars->Tr0_oto = (st_vars->LineTime - st_vars->Tvm_oto) / 2.0;
+		Tr0_oto = (LineTime - Tvm_oto) / 2.0;
 
-	st_vars->Tvm_oto_lines = dml_ceil(4.0 * st_vars->Tvm_oto / st_vars->LineTime, 1) / 4.0;
-	st_vars->Tr0_oto_lines = dml_ceil(4.0 * st_vars->Tr0_oto / st_vars->LineTime, 1) / 4.0;
-	st_vars->dst_y_prefetch_oto = st_vars->Tvm_oto_lines + 2 * st_vars->Tr0_oto_lines + st_vars->Lsw_oto;
+	Tvm_oto_lines = dml_ceil(4.0 * Tvm_oto / LineTime, 1) / 4.0;
+	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
+	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 
-	st_vars->dst_y_prefetch_equ = VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / st_vars->LineTime -
+	dst_y_prefetch_equ = VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime -
 			(*DSTYAfterScaler + (double) *DSTXAfterScaler / (double) myPipe->HTotal);
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: HTotal = %d\n", __func__, myPipe->HTotal);
-	dml_print("DML::%s: min_Lsw = %f\n", __func__, st_vars->min_Lsw);
+	dml_print("DML::%s: min_Lsw = %f\n", __func__, min_Lsw);
 	dml_print("DML::%s: *Tno_bw = %f\n", __func__, *Tno_bw);
 	dml_print("DML::%s: UrgentExtraLatency = %f\n", __func__, UrgentExtraLatency);
-	dml_print("DML::%s: trip_to_mem = %f\n", __func__, st_vars->trip_to_mem);
+	dml_print("DML::%s: trip_to_mem = %f\n", __func__, trip_to_mem);
 	dml_print("DML::%s: BytePerPixelY = %d\n", __func__, myPipe->BytePerPixelY);
 	dml_print("DML::%s: PrefetchSourceLinesY = %f\n", __func__, PrefetchSourceLinesY);
 	dml_print("DML::%s: swath_width_luma_ub = %d\n", __func__, swath_width_luma_ub);
 	dml_print("DML::%s: BytePerPixelC = %d\n", __func__, myPipe->BytePerPixelC);
 	dml_print("DML::%s: PrefetchSourceLinesC = %f\n", __func__, PrefetchSourceLinesC);
 	dml_print("DML::%s: swath_width_chroma_ub = %d\n", __func__, swath_width_chroma_ub);
-	dml_print("DML::%s: prefetch_sw_bytes = %f\n", __func__, st_vars->prefetch_sw_bytes);
-	dml_print("DML::%s: bytes_pp = %f\n", __func__, st_vars->bytes_pp);
+	dml_print("DML::%s: prefetch_sw_bytes = %f\n", __func__, prefetch_sw_bytes);
+	dml_print("DML::%s: bytes_pp = %f\n", __func__, bytes_pp);
 	dml_print("DML::%s: PDEAndMetaPTEBytesFrame = %d\n", __func__, PDEAndMetaPTEBytesFrame);
 	dml_print("DML::%s: MetaRowByte = %d\n", __func__, MetaRowByte);
 	dml_print("DML::%s: PixelPTEBytesPerRow = %d\n", __func__, PixelPTEBytesPerRow);
 	dml_print("DML::%s: HostVMInefficiencyFactor = %f\n", __func__, HostVMInefficiencyFactor);
-	dml_print("DML::%s: Tvm_trips = %f\n", __func__, st_vars->Tvm_trips);
-	dml_print("DML::%s: Tr0_trips = %f\n", __func__, st_vars->Tr0_trips);
-	dml_print("DML::%s: prefetch_bw_oto = %f\n", __func__, st_vars->prefetch_bw_oto);
-	dml_print("DML::%s: Tr0_oto = %f\n", __func__, st_vars->Tr0_oto);
-	dml_print("DML::%s: Tvm_oto = %f\n", __func__, st_vars->Tvm_oto);
-	dml_print("DML::%s: Tvm_oto_lines = %f\n", __func__, st_vars->Tvm_oto_lines);
-	dml_print("DML::%s: Tr0_oto_lines = %f\n", __func__, st_vars->Tr0_oto_lines);
-	dml_print("DML::%s: Lsw_oto = %f\n", __func__, st_vars->Lsw_oto);
-	dml_print("DML::%s: dst_y_prefetch_oto = %f\n", __func__, st_vars->dst_y_prefetch_oto);
-	dml_print("DML::%s: dst_y_prefetch_equ = %f\n", __func__, st_vars->dst_y_prefetch_equ);
+	dml_print("DML::%s: Tvm_trips = %f\n", __func__, Tvm_trips);
+	dml_print("DML::%s: Tr0_trips = %f\n", __func__, Tr0_trips);
+	dml_print("DML::%s: prefetch_bw_oto = %f\n", __func__, prefetch_bw_oto);
+	dml_print("DML::%s: Tr0_oto = %f\n", __func__, Tr0_oto);
+	dml_print("DML::%s: Tvm_oto = %f\n", __func__, Tvm_oto);
+	dml_print("DML::%s: Tvm_oto_lines = %f\n", __func__, Tvm_oto_lines);
+	dml_print("DML::%s: Tr0_oto_lines = %f\n", __func__, Tr0_oto_lines);
+	dml_print("DML::%s: Lsw_oto = %f\n", __func__, Lsw_oto);
+	dml_print("DML::%s: dst_y_prefetch_oto = %f\n", __func__, dst_y_prefetch_oto);
+	dml_print("DML::%s: dst_y_prefetch_equ = %f\n", __func__, dst_y_prefetch_equ);
 #endif
 
-	st_vars->dst_y_prefetch_equ = dml_floor(4.0 * (st_vars->dst_y_prefetch_equ + 0.125), 1) / 4.0;
-	st_vars->Tpre_rounded = st_vars->dst_y_prefetch_equ * st_vars->LineTime;
+	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
+	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, st_vars->dst_y_prefetch_equ);
-	dml_print("DML::%s: LineTime: %f\n", __func__, st_vars->LineTime);
+	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, dst_y_prefetch_equ);
+	dml_print("DML::%s: LineTime: %f\n", __func__, LineTime);
 	dml_print("DML::%s: VStartup: %d\n", __func__, VStartup);
 	dml_print("DML::%s: Tvstartup: %fus - time between vstartup and first pixel of active\n",
-			__func__, VStartup * st_vars->LineTime);
+			__func__, VStartup * LineTime);
 	dml_print("DML::%s: TSetup: %fus - time from vstartup to vready\n", __func__, *TSetup);
 	dml_print("DML::%s: TCalc: %fus - time for calculations in dchub starting at vready\n", __func__, TCalc);
-	dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n", __func__, st_vars->Tdmbf);
-	dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, st_vars->Tdmec);
+	dml_print("DML::%s: Tdmbf: %fus - time for dmd transfer from dchub to dio output buffer\n", __func__, Tdmbf);
+	dml_print("DML::%s: Tdmec: %fus - time dio takes to transfer dmd\n", __func__, Tdmec);
 	dml_print("DML::%s: Tdmdl_vm: %fus - time for vm stages of dmd\n", __func__, *Tdmdl_vm);
 	dml_print("DML::%s: Tdmdl: %fus - time for fabric to become ready and fetch dmd\n", __func__, *Tdmdl);
 	dml_print("DML::%s: DSTYAfterScaler: %d lines - number of lines of pipeline and buffer delay after scaler\n",
 			__func__, *DSTYAfterScaler);
 #endif
-	st_vars->dep_bytes = dml_max(PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor,
+	dep_bytes = dml_max(PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor,
 			MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor);
 
-	if (st_vars->prefetch_sw_bytes < st_vars->dep_bytes)
-		st_vars->prefetch_sw_bytes = 2 * st_vars->dep_bytes;
+	if (prefetch_sw_bytes < dep_bytes)
+		prefetch_sw_bytes = 2 * dep_bytes;
 
 	*PrefetchBandwidth = 0;
 	*DestinationLinesToRequestVMInVBlank = 0;
@@ -3665,61 +3691,61 @@ bool dml32_CalculatePrefetchSchedule(
 	*VRatioPrefetchY = 0;
 	*VRatioPrefetchC = 0;
 	*RequiredPrefetchPixDataBWLuma = 0;
-	if (st_vars->dst_y_prefetch_equ > 1) {
+	if (dst_y_prefetch_equ > 1) {
 		double PrefetchBandwidth1;
 		double PrefetchBandwidth2;
 		double PrefetchBandwidth3;
 		double PrefetchBandwidth4;
 
-		if (st_vars->Tpre_rounded - *Tno_bw > 0) {
+		if (Tpre_rounded - *Tno_bw > 0) {
 			PrefetchBandwidth1 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + 2 * MetaRowByte
 					+ 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor
-					+ st_vars->prefetch_sw_bytes) / (st_vars->Tpre_rounded - *Tno_bw);
-			st_vars->Tsw_est1 = st_vars->prefetch_sw_bytes / PrefetchBandwidth1;
+					+ prefetch_sw_bytes) / (Tpre_rounded - *Tno_bw);
+			Tsw_est1 = prefetch_sw_bytes / PrefetchBandwidth1;
 		} else
 			PrefetchBandwidth1 = 0;
 
-		if (VStartup == MaxVStartup && (st_vars->Tsw_est1 / st_vars->LineTime < st_vars->min_Lsw)
-				&& st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - *Tno_bw > 0) {
+		if (VStartup == MaxVStartup && (Tsw_est1 / LineTime < min_Lsw)
+				&& Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - *Tno_bw > 0) {
 			PrefetchBandwidth1 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + 2 * MetaRowByte
 					+ 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-					/ (st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - *Tno_bw);
+					/ (Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - *Tno_bw);
 		}
 
-		if (st_vars->Tpre_rounded - *Tno_bw - 2 * st_vars->Tr0_trips_rounded > 0)
-			PrefetchBandwidth2 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + st_vars->prefetch_sw_bytes) /
-			(st_vars->Tpre_rounded - *Tno_bw - 2 * st_vars->Tr0_trips_rounded);
+		if (Tpre_rounded - *Tno_bw - 2 * Tr0_trips_rounded > 0)
+			PrefetchBandwidth2 = (PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor + prefetch_sw_bytes) /
+			(Tpre_rounded - *Tno_bw - 2 * Tr0_trips_rounded);
 		else
 			PrefetchBandwidth2 = 0;
 
-		if (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded > 0) {
+		if (Tpre_rounded - Tvm_trips_rounded > 0) {
 			PrefetchBandwidth3 = (2 * MetaRowByte + 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor
-					+ st_vars->prefetch_sw_bytes) / (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded);
-			st_vars->Tsw_est3 = st_vars->prefetch_sw_bytes / PrefetchBandwidth3;
+					+ prefetch_sw_bytes) / (Tpre_rounded - Tvm_trips_rounded);
+			Tsw_est3 = prefetch_sw_bytes / PrefetchBandwidth3;
 		} else
 			PrefetchBandwidth3 = 0;
 
 
 		if (VStartup == MaxVStartup &&
-				(st_vars->Tsw_est3 / st_vars->LineTime < st_vars->min_Lsw) && st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 *
-				st_vars->LineTime - st_vars->Tvm_trips_rounded > 0) {
+				(Tsw_est3 / LineTime < min_Lsw) && Tpre_rounded - min_Lsw * LineTime - 0.75 *
+				LineTime - Tvm_trips_rounded > 0) {
 			PrefetchBandwidth3 = (2 * MetaRowByte + 2 * PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-					/ (st_vars->Tpre_rounded - st_vars->min_Lsw * st_vars->LineTime - 0.75 * st_vars->LineTime - st_vars->Tvm_trips_rounded);
+					/ (Tpre_rounded - min_Lsw * LineTime - 0.75 * LineTime - Tvm_trips_rounded);
 		}
 
-		if (st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded - 2 * st_vars->Tr0_trips_rounded > 0) {
-			PrefetchBandwidth4 = st_vars->prefetch_sw_bytes /
-					(st_vars->Tpre_rounded - st_vars->Tvm_trips_rounded - 2 * st_vars->Tr0_trips_rounded);
+		if (Tpre_rounded - Tvm_trips_rounded - 2 * Tr0_trips_rounded > 0) {
+			PrefetchBandwidth4 = prefetch_sw_bytes /
+					(Tpre_rounded - Tvm_trips_rounded - 2 * Tr0_trips_rounded);
 		} else {
 			PrefetchBandwidth4 = 0;
 		}
 
 #ifdef __DML_VBA_DEBUG__
-		dml_print("DML::%s: Tpre_rounded: %f\n", __func__, st_vars->Tpre_rounded);
+		dml_print("DML::%s: Tpre_rounded: %f\n", __func__, Tpre_rounded);
 		dml_print("DML::%s: Tno_bw: %f\n", __func__, *Tno_bw);
-		dml_print("DML::%s: Tvm_trips_rounded: %f\n", __func__, st_vars->Tvm_trips_rounded);
-		dml_print("DML::%s: Tsw_est1: %f\n", __func__, st_vars->Tsw_est1);
-		dml_print("DML::%s: Tsw_est3: %f\n", __func__, st_vars->Tsw_est3);
+		dml_print("DML::%s: Tvm_trips_rounded: %f\n", __func__, Tvm_trips_rounded);
+		dml_print("DML::%s: Tsw_est1: %f\n", __func__, Tsw_est1);
+		dml_print("DML::%s: Tsw_est3: %f\n", __func__, Tsw_est3);
 		dml_print("DML::%s: PrefetchBandwidth1: %f\n", __func__, PrefetchBandwidth1);
 		dml_print("DML::%s: PrefetchBandwidth2: %f\n", __func__, PrefetchBandwidth2);
 		dml_print("DML::%s: PrefetchBandwidth3: %f\n", __func__, PrefetchBandwidth3);
@@ -3732,9 +3758,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth1 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth1
-						>= st_vars->Tvm_trips_rounded
+						>= Tvm_trips_rounded
 						&& (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-								/ PrefetchBandwidth1 >= st_vars->Tr0_trips_rounded) {
+								/ PrefetchBandwidth1 >= Tr0_trips_rounded) {
 					Case1OK = true;
 				} else {
 					Case1OK = false;
@@ -3745,9 +3771,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth2 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth2
-						>= st_vars->Tvm_trips_rounded
+						>= Tvm_trips_rounded
 						&& (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor)
-						/ PrefetchBandwidth2 < st_vars->Tr0_trips_rounded) {
+						/ PrefetchBandwidth2 < Tr0_trips_rounded) {
 					Case2OK = true;
 				} else {
 					Case2OK = false;
@@ -3758,9 +3784,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 			if (PrefetchBandwidth3 > 0) {
 				if (*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / PrefetchBandwidth3 <
-						st_vars->Tvm_trips_rounded && (MetaRowByte + PixelPTEBytesPerRow *
+						Tvm_trips_rounded && (MetaRowByte + PixelPTEBytesPerRow *
 								HostVMInefficiencyFactor) / PrefetchBandwidth3 >=
-								st_vars->Tr0_trips_rounded) {
+								Tr0_trips_rounded) {
 					Case3OK = true;
 				} else {
 					Case3OK = false;
@@ -3770,80 +3796,80 @@ bool dml32_CalculatePrefetchSchedule(
 			}
 
 			if (Case1OK)
-				st_vars->prefetch_bw_equ = PrefetchBandwidth1;
+				prefetch_bw_equ = PrefetchBandwidth1;
 			else if (Case2OK)
-				st_vars->prefetch_bw_equ = PrefetchBandwidth2;
+				prefetch_bw_equ = PrefetchBandwidth2;
 			else if (Case3OK)
-				st_vars->prefetch_bw_equ = PrefetchBandwidth3;
+				prefetch_bw_equ = PrefetchBandwidth3;
 			else
-				st_vars->prefetch_bw_equ = PrefetchBandwidth4;
+				prefetch_bw_equ = PrefetchBandwidth4;
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: Case1OK: %d\n", __func__, Case1OK);
 			dml_print("DML::%s: Case2OK: %d\n", __func__, Case2OK);
 			dml_print("DML::%s: Case3OK: %d\n", __func__, Case3OK);
-			dml_print("DML::%s: prefetch_bw_equ: %f\n", __func__, st_vars->prefetch_bw_equ);
+			dml_print("DML::%s: prefetch_bw_equ: %f\n", __func__, prefetch_bw_equ);
 #endif
 
-			if (st_vars->prefetch_bw_equ > 0) {
+			if (prefetch_bw_equ > 0) {
 				if (GPUVMEnable == true) {
-					st_vars->Tvm_equ = dml_max3(*Tno_bw + PDEAndMetaPTEBytesFrame *
-							HostVMInefficiencyFactor / st_vars->prefetch_bw_equ,
-							st_vars->Tvm_trips, st_vars->LineTime / 4);
+					Tvm_equ = dml_max3(*Tno_bw + PDEAndMetaPTEBytesFrame *
+							HostVMInefficiencyFactor / prefetch_bw_equ,
+							Tvm_trips, LineTime / 4);
 				} else {
-					st_vars->Tvm_equ = st_vars->LineTime / 4;
+					Tvm_equ = LineTime / 4;
 				}
 
 				if ((GPUVMEnable == true || myPipe->DCCEnable == true)) {
-					st_vars->Tr0_equ = dml_max4((MetaRowByte + PixelPTEBytesPerRow *
-							HostVMInefficiencyFactor) / st_vars->prefetch_bw_equ, st_vars->Tr0_trips,
-							(st_vars->LineTime - st_vars->Tvm_equ) / 2, st_vars->LineTime / 4);
+					Tr0_equ = dml_max4((MetaRowByte + PixelPTEBytesPerRow *
+							HostVMInefficiencyFactor) / prefetch_bw_equ, Tr0_trips,
+							(LineTime - Tvm_equ) / 2, LineTime / 4);
 				} else {
-					st_vars->Tr0_equ = (st_vars->LineTime - st_vars->Tvm_equ) / 2;
+					Tr0_equ = (LineTime - Tvm_equ) / 2;
 				}
 			} else {
-				st_vars->Tvm_equ = 0;
-				st_vars->Tr0_equ = 0;
+				Tvm_equ = 0;
+				Tr0_equ = 0;
 #ifdef __DML_VBA_DEBUG__
 				dml_print("DML: prefetch_bw_equ equals 0! %s:%d\n", __FILE__, __LINE__);
 #endif
 			}
 		}
 
-		if (st_vars->dst_y_prefetch_oto < st_vars->dst_y_prefetch_equ) {
-			*DestinationLinesForPrefetch = st_vars->dst_y_prefetch_oto;
-			st_vars->TimeForFetchingMetaPTE = st_vars->Tvm_oto;
-			st_vars->TimeForFetchingRowInVBlank = st_vars->Tr0_oto;
-			*PrefetchBandwidth = st_vars->prefetch_bw_oto;
+		if (dst_y_prefetch_oto < dst_y_prefetch_equ) {
+			*DestinationLinesForPrefetch = dst_y_prefetch_oto;
+			TimeForFetchingMetaPTE = Tvm_oto;
+			TimeForFetchingRowInVBlank = Tr0_oto;
+			*PrefetchBandwidth = prefetch_bw_oto;
 		} else {
-			*DestinationLinesForPrefetch = st_vars->dst_y_prefetch_equ;
-			st_vars->TimeForFetchingMetaPTE = st_vars->Tvm_equ;
-			st_vars->TimeForFetchingRowInVBlank = st_vars->Tr0_equ;
-			*PrefetchBandwidth = st_vars->prefetch_bw_equ;
+			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
+			TimeForFetchingMetaPTE = Tvm_equ;
+			TimeForFetchingRowInVBlank = Tr0_equ;
+			*PrefetchBandwidth = prefetch_bw_equ;
 		}
 
-		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * st_vars->TimeForFetchingMetaPTE / st_vars->LineTime, 1.0) / 4.0;
+		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
 
 		*DestinationLinesToRequestRowInVBlank =
-				dml_ceil(4.0 * st_vars->TimeForFetchingRowInVBlank / st_vars->LineTime, 1.0) / 4.0;
+				dml_ceil(4.0 * TimeForFetchingRowInVBlank / LineTime, 1.0) / 4.0;
 
-		st_vars->LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
+		LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
 				*DestinationLinesToRequestVMInVBlank - 2 * *DestinationLinesToRequestRowInVBlank;
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: DestinationLinesForPrefetch = %f\n", __func__, *DestinationLinesForPrefetch);
 		dml_print("DML::%s: DestinationLinesToRequestVMInVBlank = %f\n",
 				__func__, *DestinationLinesToRequestVMInVBlank);
-		dml_print("DML::%s: TimeForFetchingRowInVBlank = %f\n", __func__, st_vars->TimeForFetchingRowInVBlank);
-		dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
+		dml_print("DML::%s: TimeForFetchingRowInVBlank = %f\n", __func__, TimeForFetchingRowInVBlank);
+		dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
 		dml_print("DML::%s: DestinationLinesToRequestRowInVBlank = %f\n",
 				__func__, *DestinationLinesToRequestRowInVBlank);
 		dml_print("DML::%s: PrefetchSourceLinesY = %f\n", __func__, PrefetchSourceLinesY);
-		dml_print("DML::%s: LinesToRequestPrefetchPixelData = %f\n", __func__, st_vars->LinesToRequestPrefetchPixelData);
+		dml_print("DML::%s: LinesToRequestPrefetchPixelData = %f\n", __func__, LinesToRequestPrefetchPixelData);
 #endif
 
-		if (st_vars->LinesToRequestPrefetchPixelData >= 1 && st_vars->prefetch_bw_equ > 0) {
-			*VRatioPrefetchY = (double) PrefetchSourceLinesY / st_vars->LinesToRequestPrefetchPixelData;
+		if (LinesToRequestPrefetchPixelData >= 1 && prefetch_bw_equ > 0) {
+			*VRatioPrefetchY = (double) PrefetchSourceLinesY / LinesToRequestPrefetchPixelData;
 			*VRatioPrefetchY = dml_max(*VRatioPrefetchY, 1.0);
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: VRatioPrefetchY = %f\n", __func__, *VRatioPrefetchY);
@@ -3851,12 +3877,12 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: VInitPreFillY = %d\n", __func__, VInitPreFillY);
 #endif
 			if ((SwathHeightY > 4) && (VInitPreFillY > 3)) {
-				if (st_vars->LinesToRequestPrefetchPixelData > (VInitPreFillY - 3.0) / 2.0) {
+				if (LinesToRequestPrefetchPixelData > (VInitPreFillY - 3.0) / 2.0) {
 					*VRatioPrefetchY =
 							dml_max((double) PrefetchSourceLinesY /
-									st_vars->LinesToRequestPrefetchPixelData,
+									LinesToRequestPrefetchPixelData,
 									(double) MaxNumSwathY * SwathHeightY /
-									(st_vars->LinesToRequestPrefetchPixelData -
+									(LinesToRequestPrefetchPixelData -
 									(VInitPreFillY - 3.0) / 2.0));
 					*VRatioPrefetchY = dml_max(*VRatioPrefetchY, 1.0);
 				} else {
@@ -3870,7 +3896,7 @@ bool dml32_CalculatePrefetchSchedule(
 #endif
 			}
 
-			*VRatioPrefetchC = (double) PrefetchSourceLinesC / st_vars->LinesToRequestPrefetchPixelData;
+			*VRatioPrefetchC = (double) PrefetchSourceLinesC / LinesToRequestPrefetchPixelData;
 			*VRatioPrefetchC = dml_max(*VRatioPrefetchC, 1.0);
 
 #ifdef __DML_VBA_DEBUG__
@@ -3879,11 +3905,11 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: VInitPreFillC = %d\n", __func__, VInitPreFillC);
 #endif
 			if ((SwathHeightC > 4)) {
-				if (st_vars->LinesToRequestPrefetchPixelData > (VInitPreFillC - 3.0) / 2.0) {
+				if (LinesToRequestPrefetchPixelData > (VInitPreFillC - 3.0) / 2.0) {
 					*VRatioPrefetchC =
 						dml_max(*VRatioPrefetchC,
 							(double) MaxNumSwathC * SwathHeightC /
-							(st_vars->LinesToRequestPrefetchPixelData -
+							(LinesToRequestPrefetchPixelData -
 							(VInitPreFillC - 3.0) / 2.0));
 					*VRatioPrefetchC = dml_max(*VRatioPrefetchC, 1.0);
 				} else {
@@ -3898,25 +3924,25 @@ bool dml32_CalculatePrefetchSchedule(
 			}
 
 			*RequiredPrefetchPixDataBWLuma = (double) PrefetchSourceLinesY
-					/ st_vars->LinesToRequestPrefetchPixelData * myPipe->BytePerPixelY * swath_width_luma_ub
-					/ st_vars->LineTime;
+					/ LinesToRequestPrefetchPixelData * myPipe->BytePerPixelY * swath_width_luma_ub
+					/ LineTime;
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: BytePerPixelY = %d\n", __func__, myPipe->BytePerPixelY);
 			dml_print("DML::%s: swath_width_luma_ub = %d\n", __func__, swath_width_luma_ub);
-			dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
+			dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
 			dml_print("DML::%s: RequiredPrefetchPixDataBWLuma = %f\n",
 					__func__, *RequiredPrefetchPixDataBWLuma);
 #endif
 			*RequiredPrefetchPixDataBWChroma = (double) PrefetchSourceLinesC /
-					st_vars->LinesToRequestPrefetchPixelData
+					LinesToRequestPrefetchPixelData
 					* myPipe->BytePerPixelC
-					* swath_width_chroma_ub / st_vars->LineTime;
+					* swath_width_chroma_ub / LineTime;
 		} else {
 			MyError = true;
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML:%s: MyErr set. LinesToRequestPrefetchPixelData: %f, should be > 0\n",
-					__func__, st_vars->LinesToRequestPrefetchPixelData);
+					__func__, LinesToRequestPrefetchPixelData);
 #endif
 			*VRatioPrefetchY = 0;
 			*VRatioPrefetchC = 0;
@@ -3925,15 +3951,15 @@ bool dml32_CalculatePrefetchSchedule(
 		}
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML: Tpre: %fus - sum of time to request meta pte, 2 x data pte + meta data, swaths\n",
-			(double)st_vars->LinesToRequestPrefetchPixelData * st_vars->LineTime +
-			2.0*st_vars->TimeForFetchingRowInVBlank + st_vars->TimeForFetchingMetaPTE);
-		dml_print("DML:  Tvm: %fus - time to fetch page tables for meta surface\n", st_vars->TimeForFetchingMetaPTE);
+			(double)LinesToRequestPrefetchPixelData * LineTime +
+			2.0*TimeForFetchingRowInVBlank + TimeForFetchingMetaPTE);
+		dml_print("DML:  Tvm: %fus - time to fetch page tables for meta surface\n", TimeForFetchingMetaPTE);
 		dml_print("DML: To: %fus - time for propagation from scaler to optc\n",
-			(*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * st_vars->LineTime);
+			(*DSTYAfterScaler + ((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime);
 		dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre - To > 0\n");
-		dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", VStartup * st_vars->LineTime -
-			st_vars->TimeForFetchingMetaPTE - 2*st_vars->TimeForFetchingRowInVBlank - (*DSTYAfterScaler +
-			((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * st_vars->LineTime - TWait - TCalc - *TSetup);
+		dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", VStartup * LineTime -
+			TimeForFetchingMetaPTE - 2*TimeForFetchingRowInVBlank - (*DSTYAfterScaler +
+			((double) (*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime - TWait - TCalc - *TSetup);
 		dml_print("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %d\n",
 				PixelPTEBytesPerRow);
 #endif
@@ -3941,7 +3967,7 @@ bool dml32_CalculatePrefetchSchedule(
 		MyError = true;
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: MyErr set, dst_y_prefetch_equ = %f (should be > 1)\n",
-				__func__, st_vars->dst_y_prefetch_equ);
+				__func__, dst_y_prefetch_equ);
 #endif
 	}
 
@@ -3957,10 +3983,10 @@ bool dml32_CalculatePrefetchSchedule(
 			dml_print("DML::%s: HostVMInefficiencyFactor = %f\n", __func__, HostVMInefficiencyFactor);
 			dml_print("DML::%s: DestinationLinesToRequestVMInVBlank = %f\n",
 					__func__, *DestinationLinesToRequestVMInVBlank);
-			dml_print("DML::%s: LineTime = %f\n", __func__, st_vars->LineTime);
+			dml_print("DML::%s: LineTime = %f\n", __func__, LineTime);
 #endif
 			prefetch_vm_bw = PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor /
-					(*DestinationLinesToRequestVMInVBlank * st_vars->LineTime);
+					(*DestinationLinesToRequestVMInVBlank * LineTime);
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: prefetch_vm_bw = %f\n", __func__, prefetch_vm_bw);
 #endif
@@ -3977,7 +4003,7 @@ bool dml32_CalculatePrefetchSchedule(
 			prefetch_row_bw = 0;
 		} else if (*DestinationLinesToRequestRowInVBlank > 0) {
 			prefetch_row_bw = (MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) /
-					(*DestinationLinesToRequestRowInVBlank * st_vars->LineTime);
+					(*DestinationLinesToRequestRowInVBlank * LineTime);
 
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: MetaRowByte = %d\n", __func__, MetaRowByte);
@@ -4000,12 +4026,12 @@ bool dml32_CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		st_vars->TimeForFetchingMetaPTE = 0;
-		st_vars->TimeForFetchingRowInVBlank = 0;
+		TimeForFetchingMetaPTE = 0;
+		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		st_vars->LinesToRequestPrefetchPixelData = 0;
+		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 37a314ce284b..ecd4f1e7d1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -715,7 +715,6 @@ double dml32_CalculateExtraLatency(
 		unsigned int HostVMMaxNonCachedPageTableLevels);
 
 bool dml32_CalculatePrefetchSchedule(
-		struct dml32_CalculatePrefetchSchedule *st_vars,
 		double HostVMInefficiencyFactor,
 		DmlPipe *myPipe,
 		unsigned int DSCDelay,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 8460aefe7b6d..42e4e4c5e656 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -247,43 +247,6 @@ struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport {
 	unsigned int LBLatencyHidingSourceLinesC[DC__NUM_DPP__MAX];
 };
 
-struct dml32_CalculatePrefetchSchedule {
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
-	double TimeForFetchingMetaPTE;
-	double TimeForFetchingRowInVBlank;
-	double LinesToRequestPrefetchPixelData;
-	unsigned int HostVMDynamicLevelsTrips;
-	double trip_to_mem;
-	double Tvm_trips;
-	double Tr0_trips;
-	double Tvm_trips_rounded;
-	double Tr0_trips_rounded;
-	double Lsw_oto;
-	double Tpre_rounded;
-	double prefetch_bw_equ;
-	double Tvm_equ;
-	double Tr0_equ;
-	double Tdmbf;
-	double Tdmec;
-	double Tdmsks;
-	double prefetch_sw_bytes;
-	double bytes_pp;
-	double dep_bytes;
-	unsigned int max_vratio_pre;
-	double min_Lsw;
-	double Tsw_est1;
-	double Tsw_est3;
-};
-
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -358,7 +321,6 @@ struct dummy_vars {
 	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
 	struct dml32_CalculateVMRowAndSwath dml32_CalculateVMRowAndSwath;
 	struct dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport;
-	struct dml32_CalculatePrefetchSchedule dml32_CalculatePrefetchSchedule;
 };
 
 struct vba_vars_st {
-- 
2.35.1

