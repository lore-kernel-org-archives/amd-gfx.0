Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C195C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEB310EB00;
	Fri, 14 Jan 2022 01:38:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1115110EB00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK9xEM4iFPAdyU982jn6/WOfn/uTChtTt37TUCzjtsSYVdj+joAPCpvybaR4Kbz6I6fkejinO6xG0JbaNxRlrfJTMBpi0QKjXtzwYEXimNCu3AvEb7mWHlyQwmLhN8//CzkmftKUwzZ6kXRr8maIBou16HUmushceLFe2rJtdptsByYZ0e/VVMGxGypqn5fwEdJjBbsYHcPSogiqJ67PNREyKghy5oWBQkZqh8DkJUBzZHMs8mdxMQuzdbHHqDrarXWvxC+6BmQcvTkOmPX6p5vfXBHX65nmf/H77jebRSuUn66NuZranA8SZ1pV9MVlhQnrHV29xl7y2suSYh/IIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqMAHX5rAc9u8sklGfcQVANxZQrdtz3f0RzvdLwuoQ8=;
 b=PQOJ3zUN4O8VpeeVz5As6eFsDFmvn8edZGJdQi+uBlRCFEJ2WCvnZNJ5GNZOCWYABU4J06ueTTp9HvB1w7UGBnouOIBG6RmQghV0787xblaC8/sHRV2tjKEj5H/MzbxDFCUoILXdFq3axKdA/qWB0YSRZp7+jht3KSHiRklbxbPA10RIT3a8M1jXPIGu0+8iSuGQ5JFr16NTKOQvYb3GK3T2PVFu8C8G8sdTrcrWxJ9mSZMc0cRcSI64RrSLV3LmJA6Kn6vpehS5lz6K5pFHOAZzqlthBTXaJnUGTv/Nn301a5kyn7Jlakm0C3YbFfpScM+xnibAR9WLvna0N4f6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqMAHX5rAc9u8sklGfcQVANxZQrdtz3f0RzvdLwuoQ8=;
 b=3yj2+bK5rG2FYOKHp1B2+Cl7JAQz2W86KJyikiMvKF1Yg2hvQQI0gqru7vY7DnB7oAfxtlAjCsNghrFVnZmpd4dWJWR6Fr3pw8NALKE/mNpMKg1kdo4uHPd/jhSraDYamQDJXvuCD4D6tZmof2B/uqL+Ishl3IiznMwEzbLr1sU=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 01:38:05 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::e8) by BN8PR04CA0027.outlook.office365.com
 (2603:10b6:408:70::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 01:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:38:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:38:04 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:38:00 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: update dml to rev.99 and smu clk_table
 w/a
Date: Fri, 14 Jan 2022 09:36:54 +0800
Message-ID: <20220114013657.3119627-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c063d3-45e5-4e86-0d28-08d9d6fe82bd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5101D431FB0E2684F6646535FC549@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:179;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idKJdYwdWjfPnHdqlvi7pMkGR3L+mFDJLjdkryLPh7GYE2eNOaoDiYxIJj5dV4ehlAXdLWIaaD+hOutF8ua0QkW6vl5ol7MkSb6vhqQN3nUGFS6kFhHo2rjG1sTGOJ92EO5NdT+186klB8q9FTAXHJJqQc543wvxmzRE+atADjV5Z3ef5aNi8oTRonZ22rjqCKHMe5JFHAOe/JR3IxdjrGUP3xTvsz0llD+Ay6eqeO3aKVNd1xRXXxCqNfi9Ur9iV43GoEPXp44DhtLP4poHeYMhVzVk7GlrL4JxP1MFIPz30a9k1xOlsHBXLDkrfg6+WZQRxRVglbmHUjAP2MycBkYvrEK/Rlekast8TC0UGzxcGEhv/P32guS5+ZbQEquTTZgQpYlCdCH6b+kqi16F0d0cKQbBmw0d6O1u4DSYsRB38t02MXYVUKw4o64neqvu0EXQ03PGiyq782ZD4P0RrrnF0Edhjoey5o5WIps9AYjVaQJ+yK1tGBCyaw6kc0a8JuBFS5VpORf4dL/1gWoQ3TG2iJUSZPnstU/wdodXpxxj1ttJCZyaiBesbq0xa3VMANM03w9TWJ4p41gcz4LO6FFziEMV/aqkzjqYhYPFu9enCm2giueELsTUXeb1DyRYXk5MyasdihhpVIVSs1fuYsKdc/Ir6zZuT68G5CZ/SGXjkQjVx7i/2tM9Q2zo4lxyNH2G8uQoDGYJKZBOdtGdgyM325h7+dEKSHNWMM7My5kT5gdMaHry5XhL663sL6eJkmif1NFGwDVQ/1Dt22eroBe2RKwiyBvRczehrYajAc+jHLViSTpyN2X3e4mwUxtCL3U8peGNpKu3FEv6Ii+Ayw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(54906003)(40460700001)(19627235002)(81166007)(70206006)(6916009)(1076003)(6666004)(2906002)(316002)(70586007)(8936002)(26005)(7696005)(508600001)(8676002)(186003)(36860700001)(336012)(86362001)(82310400004)(15650500001)(47076005)(356005)(83380400001)(2616005)(4326008)(426003)(5660300002)(36756003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:38:05.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c063d3-45e5-4e86-0d28-08d9d6fe82bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
1. update dml to rev.99
2. add smu clk table w/a: smu gives 1 dtm level with mismatch voltage
   table which causes multiple issues.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../dc/dml/dcn31/display_mode_vba_31.c        | 29 +++++++++++++++++--
 .../drm/amd/display/dc/dml/display_mode_vba.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 6feb23432f8d..e4b9fd31223c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -64,6 +64,8 @@ typedef struct {
 	double DCFCLKDeepSleep;
 	unsigned int DPPPerPlane;
 	bool ScalerEnabled;
+	double VRatio;
+	double VRatioChroma;
 	enum scan_direction_class SourceScan;
 	unsigned int BlockWidth256BytesY;
 	unsigned int BlockHeight256BytesY;
@@ -942,6 +944,7 @@ static bool CalculatePrefetchSchedule(
 	double dst_y_prefetch_equ;
 	double Tsw_oto;
 	double prefetch_bw_oto;
+	double prefetch_bw_pr;
 	double Tvm_oto;
 	double Tr0_oto;
 	double Tvm_oto_lines;
@@ -971,6 +974,7 @@ static bool CalculatePrefetchSchedule(
 	double min_Lsw;
 	double Tsw_est1 = 0;
 	double Tsw_est3 = 0;
+	double  max_Tsw = 0;
 
 	if (GPUVMEnable == true && HostVMEnable == true) {
 		HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
@@ -1111,11 +1115,14 @@ static bool CalculatePrefetchSchedule(
 		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC / 4;
 	else
 		bytes_pp = myPipe->BytePerPixelY + myPipe->BytePerPixelC;
-
+	/*rev 99*/
+	prefetch_bw_pr = dml_min(1, bytes_pp * myPipe->PixelClock / (double) myPipe->DPPPerPlane);
+    max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
 	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
 	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
+    prefetch_bw_oto = dml_max(prefetch_bw_pr, prefetch_sw_bytes / max_Tsw);
 
-	min_Lsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre;
+	min_Lsw = dml_max(1, dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre);
 	Lsw_oto = dml_ceil(4 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1) / 4;
 	Tsw_oto = Lsw_oto * LineTime;
 
@@ -1389,7 +1396,7 @@ static bool CalculatePrefetchSchedule(
 			dml_print("DML::%s: SwathHeightC = %d\n", __func__, SwathHeightC);
 			dml_print("DML::%s: VInitPreFillC = %f\n", __func__, VInitPreFillC);
 #endif
-			if ((SwathHeightC > 4)) {
+			if ((SwathHeightC > 4) || VInitPreFillC > 3) {
 				if (LinesToRequestPrefetchPixelData > (VInitPreFillC - 3.0) / 2.0) {
 					*VRatioPrefetchC = dml_max(
 							*VRatioPrefetchC,
@@ -2663,6 +2670,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			myPipe.DCFCLKDeepSleep = v->DCFCLKDeepSleep;
 			myPipe.DPPPerPlane = v->DPPPerPlane[k];
 			myPipe.ScalerEnabled = v->ScalerEnabled[k];
+			myPipe.VRatio = v->VRatio[k];
+			myPipe.VRatioChroma = v->VRatioChroma[k];
 			myPipe.SourceScan = v->SourceScan[k];
 			myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
 			myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
@@ -3911,6 +3920,9 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 	myPipe.DCFCLKDeepSleep = v->ProjectedDCFCLKDeepSleep[i][j];
 	myPipe.DPPPerPlane = v->NoOfDPP[i][j][k];
 	myPipe.ScalerEnabled = v->ScalerEnabled[k];
+	myPipe.VRatio = mode_lib->vba.VRatio[k];
+	myPipe.VRatioChroma = mode_lib->vba.VRatioChroma[k];
+
 	myPipe.SourceScan = v->SourceScan[k];
 	myPipe.BlockWidth256BytesY = v->Read256BlockWidthY[k];
 	myPipe.BlockHeight256BytesY = v->Read256BlockHeightY[k];
@@ -4987,6 +4999,17 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						&v->meta_row_bandwidth[i][j][k],
 						&v->dpte_row_bandwidth[i][j][k]);
 			}
+			/*DCCMetaBufferSizeSupport(i, j) = True
+			For k = 0 To NumberOfActivePlanes - 1
+			If MetaRowBytes(i, j, k) > 24064 Then
+			DCCMetaBufferSizeSupport(i, j) = False
+			End If
+			Next k*/
+			v->DCCMetaBufferSizeSupport[i][j] = true;
+			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+				if (v->MetaRowBytes[i][j][k] > 24064)
+					v->DCCMetaBufferSizeSupport[i][j] = false;
+			}
 			v->UrgLatency[i] = CalculateUrgentLatency(
 					v->UrgentLatencyPixelDataOnly,
 					v->UrgentLatencyPixelMixedWithVMData,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 90e87961fe3e..8fe74a3b39a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -544,6 +544,8 @@ struct vba_vars_st {
 	bool DTBCLKRequiredMoreThanSupported[DC__VOLTAGE_STATES];
 	double UrgentRoundTripAndOutOfOrderLatencyPerState[DC__VOLTAGE_STATES];
 	bool ROBSupport[DC__VOLTAGE_STATES][2];
+	//based on rev 99: Dim DCCMetaBufferSizeSupport(NumberOfStates, 1) As Boolean
+	bool DCCMetaBufferSizeSupport[DC__VOLTAGE_STATES][2];
 	bool PTEBufferSizeNotExceeded[DC__VOLTAGE_STATES][2];
 	bool TotalVerticalActiveBandwidthSupport[DC__VOLTAGE_STATES][2];
 	double MaxTotalVerticalActiveAvailableBandwidth[DC__VOLTAGE_STATES][2];
-- 
2.25.1

