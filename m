Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E163CC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B491410EA13;
	Thu, 22 Sep 2022 00:20:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9140910E9FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c30TalB+T9AeznCrXstFg18HNZKlhkSgkqiG2vtGloxCQz6zYHO/YQrU/t00If0GHXSzGBuCBBtvjZ5DeMyFg3+hPhDNqXfS/hcv3kQ9MA7QWsvpY2xgKYEhcQOAxiGc2UgZoGGs5pbKqvmPhW2YwbhO7A45KXK2c7AtJbjfJ2fLkcG+G5/OrdC5x3+PR/8WnajFwr5l+eU/F4HsRQg+fiVso/sY2RCTfnh7EmFUbbzKwYwO/ySwXBExKiug08ly0zUDGef+KV7zbnw9nW/qWWB0tAnG7F8NRtqvXSSw7gtisImEXsPzERT85IBGI3Qt7HTJfeYGBfmmjPf6GGy6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY/fAi4SE4ffr75xiOMMeFTZ4M8/t6+/c71y0EH8niA=;
 b=OZcA56WnNGA0+lkJYAVRvqdXpotMfh87Y4ltDXV+OQTcH0jD5/32ZJEIwBUad6a3ruv0q2s1vQfNTGVmXUKGeQ00hhknXOAP45C2tW3+7ol1erYEyd3EUlCVRmM3YsD1IiqfOTp7Ia6Dqg6njSotCb7ZeVP/oTBNA5ivS8B9Tw1JITC0fORdu70VOuM/hhnZcxPUCiFy7TNzX0Izx4suIIVu6A497JPW+QAbIEdrzlUvquN4qw9RVLkEdK0LRayrCI2tNbfUkHGcvxGqbnMKEGdimxXDMWMw0DW70WAEPgc97Aml4ytTMtE+KovQfdAxWLsI+rDIp9JlZafaMGDj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY/fAi4SE4ffr75xiOMMeFTZ4M8/t6+/c71y0EH8niA=;
 b=aOqxKCxVtCL0X4R8I9FoIKcyWED3n7f75MDCW/5aVtLAA2BFDkLkS/LxalLV7kJE35C3H36qamGCtgxqNDcU0CSXbLoCcOp0UNcny7Mo/yTWsa4UUSbBX0DVkxco74SlWX/K8VYrhWA1xh92THbRxSUI5CHf1IyTztOSa1RejbA=
Received: from BN8PR15CA0025.namprd15.prod.outlook.com (2603:10b6:408:c0::38)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 00:19:34 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::7) by BN8PR15CA0025.outlook.office365.com
 (2603:10b6:408:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:33 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:31 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/31] drm/amd/display: refactor CalculateWriteBackDelay to
 use vba_vars_st ptr
Date: Wed, 21 Sep 2022 20:18:20 -0400
Message-ID: <20220922001821.320255-31-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: c11a861d-821b-4dfe-1a0b-08da9c30202c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOkcucib8kuo3NWtuLq4B8/ufsF9Z0TclVhLuWrj8ae5dLu18sE83pfhfjydDPRmykSB9S+XSjE6n88iVb4YUnsoBdYHBXTUgowrDjaqu/PzRxhF8JA+AddkRtRfNqlaL8WU1xGAYxTa3Z4fK6yf6lnqhYzbZFbxltvV1Mtq9rHm/pS0f7s0Da6LAwdDepWVfgKO+f89QXoCssKf6fBJbHzD/3ZxcQmbGW2RrkyrSfyn1Hmq1jTt8JNtdGrB4l0qSJSe0Z4AuMje8u5SzkZl7hEC6wHaRKgHSPaexMbq01tgaUG+Dd54UphcksshzHbVRRdHSdDlaOBnQ6GXyv4Z6V0MC0kh60ZE3mFoSe2ej7C8ZeGpjyzxa3dQXEPW6wwlXpcvUAJa+Gu4JxaLEdyj7XlFEMI2OYz0zseVO4biLvtDWowMIxkFxA/qFlkn+45ZMsWyMZ1AoB7+5Hm8jiQyx37yQGAGJ5IXw0kvpE5knuskqikU/ubM1tNyPg7dD3uHoPcLyznjG+ofz8kVhdqtSLudpc2j18XVIFQdrV/oH5YGvKFJdkeR9A74TXJ7lXySPveW2dIT2Qb0JDhAVqQd3lLnq6iByku81yfGqv6kiL6hAd/uXcJiPZ5ZgCkNfxlZrU8+VsBjpJFCDzjj1Ht3wCB7Cp7nwRC/+3fHONr7PvCbu1hhW+g25aPYlmsEOCMpu5CJSlGntrtjGWL905xLKeW+8ExAMevM2BkULC2g86S/4NHjOjJFf5DpXZFJpFdB2Pc2Paru1uBgsWs4XXynwZDHpkkIsg5N+KU0iV10CEo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(26005)(478600001)(6666004)(41300700001)(426003)(47076005)(2616005)(83380400001)(336012)(1076003)(16526019)(186003)(82310400005)(2906002)(5660300002)(30864003)(40460700003)(40480700001)(54906003)(6916009)(316002)(8936002)(70206006)(4326008)(70586007)(8676002)(81166007)(356005)(82740400003)(36860700001)(36756003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:33.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11a861d-821b-4dfe-1a0b-08da9c30202c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Tom Rix <trix@redhat.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Mimimize the function signature by passing a pointer and an index instead
of passing several elements of the pointer.

The dml2x,dml3x families uses the same algorithm.  Remove the duplicates.
Use dml20_ and dml30_ prefix to distinguish the two variants.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        |  78 +++---------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 115 ++----------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 114 +----------------
 .../dc/dml/dcn30/display_mode_vba_30.c        |  74 +++--------
 .../dc/dml/dcn31/display_mode_vba_31.c        |  76 +-----------
 .../dc/dml/dcn314/display_mode_vba_314.c      |  76 +-----------
 .../dc/dml/dcn32/display_mode_vba_32.c        |  42 +------
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  30 -----
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  10 +-
 9 files changed, 63 insertions(+), 552 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 56c9c097823d..4ca080950924 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -217,16 +217,8 @@ static void CalculateFlipSchedule(
 		double *DestinationLinesToRequestRowInImmediateFlip,
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth);
 
+double dlm20_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i);
 static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
 static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
 		struct display_mode_lib *mode_lib);
@@ -1085,6 +1077,7 @@ static unsigned int CalculateVMAndRowBytes(
 static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
 		struct display_mode_lib *mode_lib)
 {
+	struct vba_vars_st *v = &mode_lib->vba;
 	unsigned int j, k;
 
 	mode_lib->vba.WritebackDISPCLK = 0.0;
@@ -1980,36 +1973,15 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			if (mode_lib->vba.WritebackEnable[k] == true) {
 				mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k] =
-						mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k])
-										/ mode_lib->vba.DISPCLK;
+					mode_lib->vba.WritebackLatency + dlm20_CalculateWriteBackDelay(v, k) / mode_lib->vba.DISPCLK;
 			} else
 				mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k] = 0;
 			for (j = 0; j < mode_lib->vba.NumberOfActivePlanes; ++j) {
 				if (mode_lib->vba.BlendingAndTiming[j] == k
 						&& mode_lib->vba.WritebackEnable[j] == true) {
 					mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k] =
-							dml_max(
-									mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k],
-									mode_lib->vba.WritebackLatency
-											+ CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[j],
-													mode_lib->vba.WritebackHRatio[j],
-													mode_lib->vba.WritebackVRatio[j],
-													mode_lib->vba.WritebackLumaHTaps[j],
-													mode_lib->vba.WritebackLumaVTaps[j],
-													mode_lib->vba.WritebackChromaHTaps[j],
-													mode_lib->vba.WritebackChromaVTaps[j],
-													mode_lib->vba.WritebackDestinationWidth[j])
-													/ mode_lib->vba.DISPCLK);
+							dml_max(mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k],
+								mode_lib->vba.WritebackLatency + dlm20_CalculateWriteBackDelay(v, j) / mode_lib->vba.DISPCLK);
 				}
 			}
 		}
@@ -2975,16 +2947,17 @@ static double CalculateRemoteSurfaceFlipDelay(
 	return result;
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth)
+double dlm20_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i)
 {
+	const enum source_format_class WritebackPixelFormat = vba->WritebackPixelFormat[i];
+	const double WritebackHRatio = vba->WritebackHRatio[i];
+	const double WritebackVRatio = vba->WritebackVRatio[i];
+	const unsigned int WritebackLumaHTaps = vba->WritebackLumaHTaps[i];
+	const unsigned int WritebackLumaVTaps = vba->WritebackLumaVTaps[i];
+	const unsigned int WritebackChromaHTaps = vba->WritebackChromaHTaps[i];
+	const unsigned int WritebackChromaVTaps = vba->WritebackChromaVTaps[i];
+	const unsigned int WritebackDestinationWidth = vba->WritebackDestinationWidth[i];
+
 	double CalculateWriteBackDelay =
 			dml_max(
 					dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
@@ -4619,15 +4592,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
 					if (mode_lib->vba.WritebackEnable[k] == true) {
 						locals->WritebackDelay[i][k] = mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k]) / locals->RequiredDISPCLK[i][j];
+							+ dlm20_CalculateWriteBackDelay(locals, k) / locals->RequiredDISPCLK[i][j];
 					} else {
 						locals->WritebackDelay[i][k] = 0.0;
 					}
@@ -4636,15 +4601,8 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 								&& mode_lib->vba.WritebackEnable[m]
 										== true) {
 							locals->WritebackDelay[i][k] = dml_max(locals->WritebackDelay[i][k],
-											mode_lib->vba.WritebackLatency + CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[m],
-													mode_lib->vba.WritebackHRatio[m],
-													mode_lib->vba.WritebackVRatio[m],
-													mode_lib->vba.WritebackLumaHTaps[m],
-													mode_lib->vba.WritebackLumaVTaps[m],
-													mode_lib->vba.WritebackChromaHTaps[m],
-													mode_lib->vba.WritebackChromaVTaps[m],
-													mode_lib->vba.WritebackDestinationWidth[m]) / locals->RequiredDISPCLK[i][j]);
+											       mode_lib->vba.WritebackLatency +
+											       dlm20_CalculateWriteBackDelay(locals, m) / locals->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 6b54be569691..2b4dcae4e432 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -241,15 +241,7 @@ static void CalculateFlipSchedule(
 		double *DestinationLinesToRequestRowInImmediateFlip,
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth);
+double dlm20_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i);
 
 static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
 static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
@@ -1145,6 +1137,7 @@ static unsigned int CalculateVMAndRowBytes(
 static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
 		struct display_mode_lib *mode_lib)
 {
+	struct vba_vars_st *v = &mode_lib->vba;
 	unsigned int j, k;
 
 	mode_lib->vba.WritebackDISPCLK = 0.0;
@@ -2016,17 +2009,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			if (mode_lib->vba.WritebackEnable[k] == true) {
 				mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k] =
-						mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k])
-										/ mode_lib->vba.DISPCLK;
+					mode_lib->vba.WritebackLatency + dlm20_CalculateWriteBackDelay(v, k) / mode_lib->vba.DISPCLK;
 			} else
 				mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k] = 0;
 			for (j = 0; j < mode_lib->vba.NumberOfActivePlanes; ++j) {
@@ -2036,16 +2019,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 							dml_max(
 									mode_lib->vba.WritebackDelay[mode_lib->vba.VoltageLevel][k],
 									mode_lib->vba.WritebackLatency
-											+ CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[j],
-													mode_lib->vba.WritebackHRatio[j],
-													mode_lib->vba.WritebackVRatio[j],
-													mode_lib->vba.WritebackLumaHTaps[j],
-													mode_lib->vba.WritebackLumaVTaps[j],
-													mode_lib->vba.WritebackChromaHTaps[j],
-													mode_lib->vba.WritebackChromaVTaps[j],
-													mode_lib->vba.WritebackDestinationWidth[j])
-													/ mode_lib->vba.DISPCLK);
+									+ dlm20_CalculateWriteBackDelay(v, j) / mode_lib->vba.DISPCLK);
 				}
 			}
 		}
@@ -3031,66 +3005,6 @@ static double CalculateRemoteSurfaceFlipDelay(
 	return result;
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth)
-{
-	double CalculateWriteBackDelay =
-			dml_max(
-					dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
-					WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1)
-							* dml_ceil(
-									WritebackDestinationWidth
-											/ 4.0,
-									1)
-							+ dml_ceil(1.0 / WritebackVRatio, 1)
-									* (dml_ceil(
-											WritebackLumaVTaps
-													/ 4.0,
-											1) + 4));
-
-	if (WritebackPixelFormat != dm_444_32) {
-		CalculateWriteBackDelay =
-				dml_max(
-						CalculateWriteBackDelay,
-						dml_max(
-								dml_ceil(
-										WritebackChromaHTaps
-												/ 2.0,
-										1)
-										/ (2
-												* WritebackHRatio),
-								WritebackChromaVTaps
-										* dml_ceil(
-												1
-														/ (2
-																* WritebackVRatio),
-												1)
-										* dml_ceil(
-												WritebackDestinationWidth
-														/ 2.0
-														/ 2.0,
-												1)
-										+ dml_ceil(
-												1
-														/ (2
-																* WritebackVRatio),
-												1)
-												* (dml_ceil(
-														WritebackChromaVTaps
-																/ 4.0,
-														1)
-														+ 4)));
-	}
-	return CalculateWriteBackDelay;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -4728,15 +4642,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
 					if (mode_lib->vba.WritebackEnable[k] == true) {
 						locals->WritebackDelay[i][k] = mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k]) / locals->RequiredDISPCLK[i][j];
+							+ dlm20_CalculateWriteBackDelay(locals, k) / locals->RequiredDISPCLK[i][j];
 					} else {
 						locals->WritebackDelay[i][k] = 0.0;
 					}
@@ -4745,15 +4651,8 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 								&& mode_lib->vba.WritebackEnable[m]
 										== true) {
 							locals->WritebackDelay[i][k] = dml_max(locals->WritebackDelay[i][k],
-											mode_lib->vba.WritebackLatency + CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[m],
-													mode_lib->vba.WritebackHRatio[m],
-													mode_lib->vba.WritebackVRatio[m],
-													mode_lib->vba.WritebackLumaHTaps[m],
-													mode_lib->vba.WritebackLumaVTaps[m],
-													mode_lib->vba.WritebackChromaHTaps[m],
-													mode_lib->vba.WritebackChromaVTaps[m],
-													mode_lib->vba.WritebackDestinationWidth[m]) / locals->RequiredDISPCLK[i][j]);
+											       mode_lib->vba.WritebackLatency +
+											       dlm20_CalculateWriteBackDelay(locals, m) / locals->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index d2dfa82d52a1..df4b52b2ed4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -273,15 +273,7 @@ static void CalculateFlipSchedule(
 		double *DestinationLinesToRequestRowInImmediateFlip,
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth);
+double dlm20_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i);
 static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		struct display_mode_lib *mode_lib,
 		unsigned int PrefetchMode,
@@ -2042,17 +2034,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			if (mode_lib->vba.WritebackEnable[k] == true) {
 				locals->WritebackDelay[mode_lib->vba.VoltageLevel][k] =
-						mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k])
-										/ mode_lib->vba.DISPCLK;
+					mode_lib->vba.WritebackLatency + dlm20_CalculateWriteBackDelay(locals, k) / mode_lib->vba.DISPCLK;
 			} else
 				locals->WritebackDelay[mode_lib->vba.VoltageLevel][k] = 0;
 			for (j = 0; j < mode_lib->vba.NumberOfActivePlanes; ++j) {
@@ -2062,16 +2044,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 							dml_max(
 									locals->WritebackDelay[mode_lib->vba.VoltageLevel][k],
 									mode_lib->vba.WritebackLatency
-											+ CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[j],
-													mode_lib->vba.WritebackHRatio[j],
-													mode_lib->vba.WritebackVRatio[j],
-													mode_lib->vba.WritebackLumaHTaps[j],
-													mode_lib->vba.WritebackLumaVTaps[j],
-													mode_lib->vba.WritebackChromaHTaps[j],
-													mode_lib->vba.WritebackChromaVTaps[j],
-													mode_lib->vba.WritebackDestinationWidth[j])
-													/ mode_lib->vba.DISPCLK);
+									+ dlm20_CalculateWriteBackDelay(locals, j) / mode_lib->vba.DISPCLK);
 				}
 			}
 		}
@@ -3045,66 +3018,6 @@ static double CalculateRemoteSurfaceFlipDelay(
 	return result;
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackLumaHTaps,
-		unsigned int WritebackLumaVTaps,
-		unsigned int WritebackChromaHTaps,
-		unsigned int WritebackChromaVTaps,
-		unsigned int WritebackDestinationWidth)
-{
-	double CalculateWriteBackDelay =
-			dml_max(
-					dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
-					WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1)
-							* dml_ceil(
-									WritebackDestinationWidth
-											/ 4.0,
-									1)
-							+ dml_ceil(1.0 / WritebackVRatio, 1)
-									* (dml_ceil(
-											WritebackLumaVTaps
-													/ 4.0,
-											1) + 4));
-
-	if (WritebackPixelFormat != dm_444_32) {
-		CalculateWriteBackDelay =
-				dml_max(
-						CalculateWriteBackDelay,
-						dml_max(
-								dml_ceil(
-										WritebackChromaHTaps
-												/ 2.0,
-										1)
-										/ (2
-												* WritebackHRatio),
-								WritebackChromaVTaps
-										* dml_ceil(
-												1
-														/ (2
-																* WritebackVRatio),
-												1)
-										* dml_ceil(
-												WritebackDestinationWidth
-														/ 2.0
-														/ 2.0,
-												1)
-										+ dml_ceil(
-												1
-														/ (2
-																* WritebackVRatio),
-												1)
-												* (dml_ceil(
-														WritebackChromaVTaps
-																/ 4.0,
-														1)
-														+ 4)));
-	}
-	return CalculateWriteBackDelay;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -4727,15 +4640,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
 					if (mode_lib->vba.WritebackEnable[k] == true) {
 						locals->WritebackDelay[i][k] = mode_lib->vba.WritebackLatency
-								+ CalculateWriteBackDelay(
-										mode_lib->vba.WritebackPixelFormat[k],
-										mode_lib->vba.WritebackHRatio[k],
-										mode_lib->vba.WritebackVRatio[k],
-										mode_lib->vba.WritebackLumaHTaps[k],
-										mode_lib->vba.WritebackLumaVTaps[k],
-										mode_lib->vba.WritebackChromaHTaps[k],
-										mode_lib->vba.WritebackChromaVTaps[k],
-										mode_lib->vba.WritebackDestinationWidth[k]) / locals->RequiredDISPCLK[i][j];
+							+ dlm20_CalculateWriteBackDelay(locals, k) / locals->RequiredDISPCLK[i][j];
 					} else {
 						locals->WritebackDelay[i][k] = 0.0;
 					}
@@ -4744,15 +4649,8 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 								&& mode_lib->vba.WritebackEnable[m]
 										== true) {
 							locals->WritebackDelay[i][k] = dml_max(locals->WritebackDelay[i][k],
-											mode_lib->vba.WritebackLatency + CalculateWriteBackDelay(
-													mode_lib->vba.WritebackPixelFormat[m],
-													mode_lib->vba.WritebackHRatio[m],
-													mode_lib->vba.WritebackVRatio[m],
-													mode_lib->vba.WritebackLumaHTaps[m],
-													mode_lib->vba.WritebackLumaVTaps[m],
-													mode_lib->vba.WritebackChromaHTaps[m],
-													mode_lib->vba.WritebackChromaVTaps[m],
-													mode_lib->vba.WritebackDestinationWidth[m]) / locals->RequiredDISPCLK[i][j]);
+											mode_lib->vba.WritebackLatency +
+											       dlm20_CalculateWriteBackDelay(locals, m) / locals->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e62bc56e4e9a..74f5d9742f59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -268,15 +268,7 @@ static void CalculateFlipSchedule(
 		double *DestinationLinesToRequestRowInImmediateFlip,
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		long WritebackDestinationWidth,
-		long WritebackDestinationHeight,
-		long WritebackSourceHeight,
-		unsigned int HTotal);
+double dml30_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i, unsigned int HTotal);
 static void CalculateDynamicMetadataParameters(
 		int MaxInterDCNTileRepeaters,
 		double DPPCLK,
@@ -2360,29 +2352,15 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->BlendingAndTiming[k] == k) {
 			if (v->WritebackEnable[k] == true) {
 				v->WritebackDelay[v->VoltageLevel][k] = v->WritebackLatency +
-						CalculateWriteBackDelay(v->WritebackPixelFormat[k],
-									v->WritebackHRatio[k],
-									v->WritebackVRatio[k],
-									v->WritebackVTaps[k],
-									v->WritebackDestinationWidth[k],
-									v->WritebackDestinationHeight[k],
-									v->WritebackSourceHeight[k],
-									v->HTotal[k]) / v->DISPCLK;
+					dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->DISPCLK;
 			} else
 				v->WritebackDelay[v->VoltageLevel][k] = 0;
 			for (j = 0; j < v->NumberOfActivePlanes; ++j) {
 				if (v->BlendingAndTiming[j] == k
 						&& v->WritebackEnable[j] == true) {
 					v->WritebackDelay[v->VoltageLevel][k] = dml_max(v->WritebackDelay[v->VoltageLevel][k],
-							v->WritebackLatency + CalculateWriteBackDelay(
-											v->WritebackPixelFormat[j],
-											v->WritebackHRatio[j],
-											v->WritebackVRatio[j],
-											v->WritebackVTaps[j],
-											v->WritebackDestinationWidth[j],
-											v->WritebackDestinationHeight[j],
-											v->WritebackSourceHeight[j],
-											v->HTotal[k]) / v->DISPCLK);
+											v->WritebackLatency +
+											dml30_CalculateWriteBackDelay(v, j, v->HTotal[k]) / v->DISPCLK);
 				}
 			}
 		}
@@ -3233,20 +3211,18 @@ double dml30_CalculateWriteBackDISPCLK(
 	return dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		long         WritebackDestinationWidth,
-		long         WritebackDestinationHeight,
-		long         WritebackSourceHeight,
-		unsigned int HTotal)
+double dml30_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i, unsigned int HTotal)
 {
-	double CalculateWriteBackDelay = 0;
-	double Line_length = 0;
-	double Output_lines_last_notclamped = 0;
-	double WritebackVInit = 0;
+	const double WritebackVRatio = vba->WritebackVRatio[i];
+	const unsigned int WritebackVTaps = vba->WritebackVTaps[i];
+	const long WritebackDestinationWidth = vba->WritebackDestinationWidth[i];
+	const long WritebackDestinationHeight = vba->WritebackDestinationHeight[i];
+	const long WritebackSourceHeight = vba->WritebackSourceHeight[i];
+
+	double CalculateWriteBackDelay;
+	double Line_length;
+	double Output_lines_last_notclamped;
+	double WritebackVInit;
 
 	WritebackVInit = (WritebackVRatio + WritebackVTaps + 1) / 2;
 	Line_length = dml_max((double) WritebackDestinationWidth, dml_ceil(WritebackDestinationWidth / 6.0, 1) * WritebackVTaps);
@@ -4562,15 +4538,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				if (v->BlendingAndTiming[k] == k) {
 					if (v->WritebackEnable[k] == true) {
 						v->WritebackDelayTime[k] = v->WritebackLatency
-								+ CalculateWriteBackDelay(
-										v->WritebackPixelFormat[k],
-										v->WritebackHRatio[k],
-										v->WritebackVRatio[k],
-										v->WritebackVTaps[k],
-										v->WritebackDestinationWidth[k],
-										v->WritebackDestinationHeight[k],
-										v->WritebackSourceHeight[k],
-										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
+							+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->RequiredDISPCLK[i][j];
 					} else {
 						v->WritebackDelayTime[k] = 0.0;
 					}
@@ -4579,15 +4547,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->WritebackDelayTime[k] = dml_max(
 									v->WritebackDelayTime[k],
 									v->WritebackLatency
-											+ CalculateWriteBackDelay(
-													v->WritebackPixelFormat[m],
-													v->WritebackHRatio[m],
-													v->WritebackVRatio[m],
-													v->WritebackVTaps[m],
-													v->WritebackDestinationWidth[m],
-													v->WritebackDestinationHeight[m],
-													v->WritebackSourceHeight[m],
-													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
+									+ dml30_CalculateWriteBackDelay(v, m, v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 338db0cac8c3..8a641fd855fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -258,15 +258,7 @@ static void CalculateFlipSchedule(
 		double PDEAndMetaPTEBytesPerFrame,
 		double MetaRowBytes,
 		double DPTEBytesPerRow);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		int WritebackDestinationWidth,
-		int WritebackDestinationHeight,
-		int WritebackSourceHeight,
-		unsigned int HTotal);
+double dml30_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i, unsigned int HTotal);
 
 static void CalculateVupdateAndDynamicMetadataParameters(
 		int MaxInterDCNTileRepeaters,
@@ -2508,15 +2500,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->BlendingAndTiming[k] == k) {
 			if (v->WritebackEnable[k] == true) {
 				v->WritebackDelay[v->VoltageLevel][k] = v->WritebackLatency
-						+ CalculateWriteBackDelay(
-								v->WritebackPixelFormat[k],
-								v->WritebackHRatio[k],
-								v->WritebackVRatio[k],
-								v->WritebackVTaps[k],
-								v->WritebackDestinationWidth[k],
-								v->WritebackDestinationHeight[k],
-								v->WritebackSourceHeight[k],
-								v->HTotal[k]) / v->DISPCLK;
+					+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->DISPCLK;
 			} else
 				v->WritebackDelay[v->VoltageLevel][k] = 0;
 			for (j = 0; j < v->NumberOfActivePlanes; ++j) {
@@ -2524,15 +2508,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->WritebackDelay[v->VoltageLevel][k] = dml_max(
 							v->WritebackDelay[v->VoltageLevel][k],
 							v->WritebackLatency
-									+ CalculateWriteBackDelay(
-											v->WritebackPixelFormat[j],
-											v->WritebackHRatio[j],
-											v->WritebackVRatio[j],
-											v->WritebackVTaps[j],
-											v->WritebackDestinationWidth[j],
-											v->WritebackDestinationHeight[j],
-											v->WritebackSourceHeight[j],
-											v->HTotal[k]) / v->DISPCLK);
+							+ dml30_CalculateWriteBackDelay(v, j, v->HTotal[k]) / v->DISPCLK);
 				}
 			}
 		}
@@ -3367,32 +3343,6 @@ double dml31_CalculateWriteBackDISPCLK(
 	return dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		int WritebackDestinationWidth,
-		int WritebackDestinationHeight,
-		int WritebackSourceHeight,
-		unsigned int HTotal)
-{
-	double CalculateWriteBackDelay;
-	double Line_length;
-	double Output_lines_last_notclamped;
-	double WritebackVInit;
-
-	WritebackVInit = (WritebackVRatio + WritebackVTaps + 1) / 2;
-	Line_length = dml_max((double) WritebackDestinationWidth, dml_ceil(WritebackDestinationWidth / 6.0, 1) * WritebackVTaps);
-	Output_lines_last_notclamped = WritebackDestinationHeight - 1 - dml_ceil((WritebackSourceHeight - WritebackVInit) / WritebackVRatio, 1);
-	if (Output_lines_last_notclamped < 0) {
-		CalculateWriteBackDelay = 0;
-	} else {
-		CalculateWriteBackDelay = Output_lines_last_notclamped * Line_length + (HTotal - WritebackDestinationWidth) + 80;
-	}
-	return CalculateWriteBackDelay;
-}
-
 static void CalculateVupdateAndDynamicMetadataParameters(
 		int MaxInterDCNTileRepeaters,
 		double DPPCLK,
@@ -4837,15 +4787,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				if (v->BlendingAndTiming[k] == k) {
 					if (v->WritebackEnable[k] == true) {
 						v->WritebackDelayTime[k] = v->WritebackLatency
-								+ CalculateWriteBackDelay(
-										v->WritebackPixelFormat[k],
-										v->WritebackHRatio[k],
-										v->WritebackVRatio[k],
-										v->WritebackVTaps[k],
-										v->WritebackDestinationWidth[k],
-										v->WritebackDestinationHeight[k],
-										v->WritebackSourceHeight[k],
-										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
+							+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->RequiredDISPCLK[i][j];
 					} else {
 						v->WritebackDelayTime[k] = 0.0;
 					}
@@ -4854,15 +4796,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->WritebackDelayTime[k] = dml_max(
 									v->WritebackDelayTime[k],
 									v->WritebackLatency
-											+ CalculateWriteBackDelay(
-													v->WritebackPixelFormat[m],
-													v->WritebackHRatio[m],
-													v->WritebackVRatio[m],
-													v->WritebackVTaps[m],
-													v->WritebackDestinationWidth[m],
-													v->WritebackDestinationHeight[m],
-													v->WritebackSourceHeight[m],
-													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
+									+ dml30_CalculateWriteBackDelay(v, m, v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index e17b253208cf..7c448eb09dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -272,15 +272,7 @@ static void CalculateFlipSchedule(
 		double PDEAndMetaPTEBytesPerFrame,
 		double MetaRowBytes,
 		double DPTEBytesPerRow);
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		int WritebackDestinationWidth,
-		int WritebackDestinationHeight,
-		int WritebackSourceHeight,
-		unsigned int HTotal);
+double dml30_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i, unsigned int HTotal);
 
 static void CalculateVupdateAndDynamicMetadataParameters(
 		int MaxInterDCNTileRepeaters,
@@ -2532,15 +2524,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->BlendingAndTiming[k] == k) {
 			if (v->WritebackEnable[k] == true) {
 				v->WritebackDelay[v->VoltageLevel][k] = v->WritebackLatency
-						+ CalculateWriteBackDelay(
-								v->WritebackPixelFormat[k],
-								v->WritebackHRatio[k],
-								v->WritebackVRatio[k],
-								v->WritebackVTaps[k],
-								v->WritebackDestinationWidth[k],
-								v->WritebackDestinationHeight[k],
-								v->WritebackSourceHeight[k],
-								v->HTotal[k]) / v->DISPCLK;
+					+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->DISPCLK;
 			} else
 				v->WritebackDelay[v->VoltageLevel][k] = 0;
 			for (j = 0; j < v->NumberOfActivePlanes; ++j) {
@@ -2548,15 +2532,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->WritebackDelay[v->VoltageLevel][k] = dml_max(
 							v->WritebackDelay[v->VoltageLevel][k],
 							v->WritebackLatency
-									+ CalculateWriteBackDelay(
-											v->WritebackPixelFormat[j],
-											v->WritebackHRatio[j],
-											v->WritebackVRatio[j],
-											v->WritebackVTaps[j],
-											v->WritebackDestinationWidth[j],
-											v->WritebackDestinationHeight[j],
-											v->WritebackSourceHeight[j],
-											v->HTotal[k]) / v->DISPCLK);
+							+ dml30_CalculateWriteBackDelay(v, j, v->HTotal[k]) / v->DISPCLK);
 				}
 			}
 		}
@@ -3479,32 +3455,6 @@ double dml314_CalculateWriteBackDISPCLK(
 	return dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
 }
 
-static double CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		int WritebackDestinationWidth,
-		int WritebackDestinationHeight,
-		int WritebackSourceHeight,
-		unsigned int HTotal)
-{
-	double CalculateWriteBackDelay;
-	double Line_length;
-	double Output_lines_last_notclamped;
-	double WritebackVInit;
-
-	WritebackVInit = (WritebackVRatio + WritebackVTaps + 1) / 2;
-	Line_length = dml_max((double) WritebackDestinationWidth, dml_ceil(WritebackDestinationWidth / 6.0, 1) * WritebackVTaps);
-	Output_lines_last_notclamped = WritebackDestinationHeight - 1 - dml_ceil((WritebackSourceHeight - WritebackVInit) / WritebackVRatio, 1);
-	if (Output_lines_last_notclamped < 0) {
-		CalculateWriteBackDelay = 0;
-	} else {
-		CalculateWriteBackDelay = Output_lines_last_notclamped * Line_length + (HTotal - WritebackDestinationWidth) + 80;
-	}
-	return CalculateWriteBackDelay;
-}
-
 static void CalculateVupdateAndDynamicMetadataParameters(
 		int MaxInterDCNTileRepeaters,
 		double DPPCLK,
@@ -4951,15 +4901,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				if (v->BlendingAndTiming[k] == k) {
 					if (v->WritebackEnable[k] == true) {
 						v->WritebackDelayTime[k] = v->WritebackLatency
-								+ CalculateWriteBackDelay(
-										v->WritebackPixelFormat[k],
-										v->WritebackHRatio[k],
-										v->WritebackVRatio[k],
-										v->WritebackVTaps[k],
-										v->WritebackDestinationWidth[k],
-										v->WritebackDestinationHeight[k],
-										v->WritebackSourceHeight[k],
-										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
+							+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / v->RequiredDISPCLK[i][j];
 					} else {
 						v->WritebackDelayTime[k] = 0.0;
 					}
@@ -4968,15 +4910,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->WritebackDelayTime[k] = dml_max(
 									v->WritebackDelayTime[k],
 									v->WritebackLatency
-											+ CalculateWriteBackDelay(
-													v->WritebackPixelFormat[m],
-													v->WritebackHRatio[m],
-													v->WritebackVRatio[m],
-													v->WritebackVTaps[m],
-													v->WritebackDestinationWidth[m],
-													v->WritebackDestinationHeight[m],
-													v->WritebackSourceHeight[m],
-													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
+									+ dml30_CalculateWriteBackDelay(v, m, v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 75be1e1ce543..1255586a97f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -597,15 +597,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			if (mode_lib->vba.WritebackEnable[k] == true) {
 				v->WritebackDelay[mode_lib->vba.VoltageLevel][k] = mode_lib->vba.WritebackLatency
-						+ dml32_CalculateWriteBackDelay(
-								mode_lib->vba.WritebackPixelFormat[k],
-								mode_lib->vba.WritebackHRatio[k],
-								mode_lib->vba.WritebackVRatio[k],
-								mode_lib->vba.WritebackVTaps[k],
-								mode_lib->vba.WritebackDestinationWidth[k],
-								mode_lib->vba.WritebackDestinationHeight[k],
-								mode_lib->vba.WritebackSourceHeight[k],
-								mode_lib->vba.HTotal[k]) / mode_lib->vba.DISPCLK;
+					+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / mode_lib->vba.DISPCLK;
 			} else
 				v->WritebackDelay[mode_lib->vba.VoltageLevel][k] = 0;
 			for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
@@ -614,15 +606,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->WritebackDelay[mode_lib->vba.VoltageLevel][k] =
 						dml_max(v->WritebackDelay[mode_lib->vba.VoltageLevel][k],
 						mode_lib->vba.WritebackLatency +
-						dml32_CalculateWriteBackDelay(
-								mode_lib->vba.WritebackPixelFormat[j],
-								mode_lib->vba.WritebackHRatio[j],
-								mode_lib->vba.WritebackVRatio[j],
-								mode_lib->vba.WritebackVTaps[j],
-								mode_lib->vba.WritebackDestinationWidth[j],
-								mode_lib->vba.WritebackDestinationHeight[j],
-								mode_lib->vba.WritebackSourceHeight[j],
-								mode_lib->vba.HTotal[k]) / mode_lib->vba.DISPCLK);
+							dml30_CalculateWriteBackDelay(v, j, v->HTotal[k]) / mode_lib->vba.DISPCLK);
 				}
 			}
 		}
@@ -2866,16 +2850,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					if (mode_lib->vba.WritebackEnable[k] == true) {
 						mode_lib->vba.WritebackDelayTime[k] =
 							mode_lib->vba.WritebackLatency
-						+ dml32_CalculateWriteBackDelay(
-							mode_lib->vba.WritebackPixelFormat[k],
-							mode_lib->vba.WritebackHRatio[k],
-							mode_lib->vba.WritebackVRatio[k],
-							mode_lib->vba.WritebackVTaps[k],
-							mode_lib->vba.WritebackDestinationWidth[k],
-							mode_lib->vba.WritebackDestinationHeight[k],
-							mode_lib->vba.WritebackSourceHeight[k],
-							mode_lib->vba.HTotal[k])
-							/ mode_lib->vba.RequiredDISPCLK[i][j];
+							+ dml30_CalculateWriteBackDelay(v, k, v->HTotal[k]) / mode_lib->vba.RequiredDISPCLK[i][j];
 					} else {
 						mode_lib->vba.WritebackDelayTime[k] = 0.0;
 					}
@@ -2885,16 +2860,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.WritebackDelayTime[k] =
 								dml_max(mode_lib->vba.WritebackDelayTime[k],
 									mode_lib->vba.WritebackLatency
-								+ dml32_CalculateWriteBackDelay(
-									mode_lib->vba.WritebackPixelFormat[m],
-									mode_lib->vba.WritebackHRatio[m],
-									mode_lib->vba.WritebackVRatio[m],
-									mode_lib->vba.WritebackVTaps[m],
-									mode_lib->vba.WritebackDestinationWidth[m],
-									mode_lib->vba.WritebackDestinationHeight[m],
-									mode_lib->vba.WritebackSourceHeight[m],
-									mode_lib->vba.HTotal[m]) /
-									mode_lib->vba.RequiredDISPCLK[i][j]);
+									+ dml30_CalculateWriteBackDelay(v, m, v->HTotal[m]) / mode_lib->vba.RequiredDISPCLK[i][j]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ad66e241f9ae..f5bc9c61bcd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -2882,36 +2882,6 @@ void dml32_CalculateDCFCLKDeepSleep(
 #endif
 } // CalculateDCFCLKDeepSleep
 
-double dml32_CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		unsigned int         WritebackDestinationWidth,
-		unsigned int         WritebackDestinationHeight,
-		unsigned int         WritebackSourceHeight,
-		unsigned int HTotal)
-{
-	double CalculateWriteBackDelay;
-	double Line_length;
-	double Output_lines_last_notclamped;
-	double WritebackVInit;
-
-	WritebackVInit = (WritebackVRatio + WritebackVTaps + 1) / 2;
-	Line_length = dml_max((double) WritebackDestinationWidth,
-			dml_ceil((double)WritebackDestinationWidth / 6.0, 1.0) * WritebackVTaps);
-	Output_lines_last_notclamped = WritebackDestinationHeight - 1 -
-			dml_ceil(((double)WritebackSourceHeight -
-					(double) WritebackVInit) / (double)WritebackVRatio, 1.0);
-	if (Output_lines_last_notclamped < 0) {
-		CalculateWriteBackDelay = 0;
-	} else {
-		CalculateWriteBackDelay = Output_lines_last_notclamped * Line_length +
-				(HTotal - WritebackDestinationWidth) + 80;
-	}
-	return CalculateWriteBackDelay;
-}
-
 void dml32_UseMinimumDCFCLK(
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		bool DRRDisplay[],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 55cead0d4237..2fa91527f08b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -572,15 +572,7 @@ void dml32_CalculateDCFCLKDeepSleep(
 		/* Output */
 		double *DCFClkDeepSleep);
 
-double dml32_CalculateWriteBackDelay(
-		enum source_format_class WritebackPixelFormat,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackVTaps,
-		unsigned int         WritebackDestinationWidth,
-		unsigned int         WritebackDestinationHeight,
-		unsigned int         WritebackSourceHeight,
-		unsigned int HTotal);
+double dml30_CalculateWriteBackDelay(struct vba_vars_st *vba, unsigned int i, unsigned int HTotal);
 
 void dml32_UseMinimumDCFCLK(
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
-- 
2.25.1

