Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98999C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C3110EA02;
	Thu, 22 Sep 2022 00:19:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7E710E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivz03fCK+4B4NHP14vrdB8J1gnHkkZbmRwugWoFeTRl/E5vHjUsK6GPnTXh58V2XykgMpX1k6ULJAQ5FcLpvwQnVmJLzLrejj2Jlrc45nZM342fG0hqDQo4jf3nyxL4eoz7R8O+Ab/6dQbp5BvxMkdBQRI9+wVQkd/i2Cv8RzZzJdzlQhxD3rhrCMxZ58CV2yAbRQIoiaGlKoGvozXx368YQkVUo5PvivxYgkVWqmFonyrFH1e/8uCuwckLfFAgu7RWYEwplKz7TcFfp2pnrtVeAFL4sYv14JESVZ7UNqk9/bUhjYP6JqQCbHM3zRrlz1BSvFYCjaRx1TLljN0EtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp3IVaJA6HKXfYEcc/PlP92JDNskOa1M0oXmVdmgt7M=;
 b=PXk9qRS48+vntNXHqslC/ptKHsVjYKqFOJoZrxrfoqkLDai/KDXfuo8LonX17oGqaboIkMyUa4aIKxBc3i6o1KD+5S1C0qJuwwMy+emYBTnMWqtpR2jcTLuC3uEmggqJPPjHqAvFxIcqNfB1ynzfrm/cWax5SZ4s0Zcu9QBZJr4AtjJoTEpXsHrpu7l5XxwKtYMlWMDMxukWvMhWvWgknMVvHdGj+XcxFUTRPHlEcVh/Zej65ONRL2oUCXH3iyz/NUTtElHVKPkiWcI8cDHly4lPUpra0ucrqQU0GB6UeoNjsqvZ4JHcuJJl1LzbkYgKLfldX29DkR1rfVP8WsBTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp3IVaJA6HKXfYEcc/PlP92JDNskOa1M0oXmVdmgt7M=;
 b=Z8ba5cgJ9Jf9zK3tL2xGfvoHWxmd8LB3PEZKkpr9Wu5Bhu791jMjGKlq24ry86StDnPRPrbYOklC5Fen+y0+cQ/hBvXp/IJJ8sgv6Ye2ZFr61AGbpRo450iL6xcxxb0kYr9zPr+SUEaOEV1qSszqVyY4h2Yblb7Euy0icNUFf84=
Received: from BN0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:141::25)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:29 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::35) by BN0PR07CA0018.outlook.office365.com
 (2603:10b6:408:141::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:29 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:25 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/31] drm/amd/display: Reduce number of arguments of dml314's
 CalculateWatermarksAndDRAMSpeedChangeSupport()
Date: Wed, 21 Sep 2022 20:18:17 -0400
Message-ID: <20220922001821.320255-28-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f05c7bd-6606-441d-96ad-08da9c301d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZf+FVF6BRh/FwipQu6HZr8q5JOUwuypJRG4mXdNx64TL0rfRnHVMJNnEcqExlnwZfUldw4sUEicH51ZjEx7YZJnu3Xf7+upMri5yqxG9Y0hLDDLyFwk8B53FHzOZy+HqmCwU0iObF6OND3qWvSYAmoMMH77JKkGjFkgcJLMX2CvvZBzC9ANX+vVovFbZaKXas0vOu+P2lN3dBGaFHkDaWXMKejs9UUEtxbMsVu0sqjd4BtFRFr6jdbhf3oYMu70Z5RBZuXg/LGN3fJiZdCy9DrmtdfkYzFvuVdjcpoXKDBtl4rS0IdjRS/EbRPF+gSWrTWWofiw5e3hzdDQdYw2tXdSM6+wf8SQfqgY95lGAv2ASun6T1AVrrDRf3s3zNtdrzuYFfnOK47nqFWz7wClJt3dZwMb0RTOy31jR5/uPa9BksLkJ9mTeoHrRmqXjpGf2z8pgJ0GQdK4e6hoB6GX9Gw/gTFzI4OttKka/ms0XrvEyS6r6zyYNZNkiH4VYl3V00/NL37ka7NvnKSRVJSnCLxeft3kjjLRZYQkPXdNWEWeqZcWxmT3qZI4aHYZ08FRYEkWE7KvRoGW+KUrFMjeoZGEcpWROykHd50VwWqNpjafHW+F5l2ljX8qOY6b7IZea5YCpXhysiUNAx/OaQ13XsMOJkFe9wU41YDKGv/MAQm5qL/tKSxFNiRasIkAb7ZzvxDK1FEK3TqzHFfOPPXRrEkftnvf0BMjxrO1E8mg+iJIL0rWKdaohJ5zGoHcgdf3A+Jw6AeP2T61018TlQd8VVhGx/lPkL8Fh36o0LICA+ZUFWFzPysHbQYpis92fuX3xxedLemeCEorRTzD6hwnslT2HBGHvFwlRS4eRBorRT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(5660300002)(26005)(8936002)(41300700001)(40480700001)(966005)(30864003)(4326008)(40460700003)(2906002)(36756003)(19627235002)(54906003)(6916009)(316002)(82310400005)(70206006)(70586007)(81166007)(6666004)(356005)(8676002)(1076003)(66574015)(426003)(83380400001)(47076005)(36860700001)(16526019)(186003)(2616005)(82740400003)(336012)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:29.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f05c7bd-6606-441d-96ad-08da9c301d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: stylon.wang@amd.com, "kernelci.org bot" <bot@kernelci.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Nathan Chancellor <nathan@kernel.org>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nathan Chancellor <nathan@kernel.org>

Most of the arguments are identical between the two call sites and they
can be accessed through the 'struct vba_vars_st' pointer. This reduces
the total amount of stack space that
dml314_ModeSupportAndSystemConfigurationFull() uses by 240 bytes with
LLVM 16 (2216 -> 1976), helping clear up the following clang warning:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: error: stack frame size (2216) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
  void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
       ^
  1 error generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/1710
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn314/display_mode_vba_314.c      | 248 ++++--------------
 1 file changed, 52 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 3c6fb98944d6..4c1d0c103933 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -325,64 +325,28 @@ static void CalculateVupdateAndDynamicMetadataParameters(
 static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		struct display_mode_lib *mode_lib,
 		unsigned int PrefetchMode,
-		unsigned int NumberOfActivePlanes,
-		unsigned int MaxLineBufferLines,
-		unsigned int LineBufferSize,
-		unsigned int WritebackInterfaceBufferSize,
 		double DCFCLK,
 		double ReturnBW,
-		bool SynchronizedVBlank,
-		unsigned int dpte_group_bytes[],
-		unsigned int MetaChunkSize,
 		double UrgentLatency,
 		double ExtraLatency,
-		double WritebackLatency,
-		double WritebackChunkSize,
 		double SOCCLK,
-		double DRAMClockChangeLatency,
-		double SRExitTime,
-		double SREnterPlusExitTime,
-		double SRExitZ8Time,
-		double SREnterPlusExitZ8Time,
 		double DCFCLKDeepSleep,
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		unsigned int SwathHeightY[],
 		unsigned int SwathHeightC[],
-		unsigned int LBBitPerPixel[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		double HRatio[],
-		double HRatioChroma[],
-		unsigned int vtaps[],
-		unsigned int VTAPsChroma[],
-		double VRatio[],
-		double VRatioChroma[],
-		unsigned int HTotal[],
-		double PixelClock[],
-		unsigned int BlendingAndTiming[],
 		unsigned int DPPPerPlane[],
 		double BytePerPixelDETY[],
 		double BytePerPixelDETC[],
-		double DSTXAfterScaler[],
-		double DSTYAfterScaler[],
-		bool WritebackEnable[],
-		enum source_format_class WritebackPixelFormat[],
-		double WritebackDestinationWidth[],
-		double WritebackDestinationHeight[],
-		double WritebackSourceHeight[],
 		bool UnboundedRequestEnabled,
 		unsigned int CompressedBufferSizeInkByte,
 		enum clock_change_support *DRAMClockChangeSupport,
-		double *UrgentWatermark,
-		double *WritebackUrgentWatermark,
-		double *DRAMClockChangeWatermark,
-		double *WritebackDRAMClockChangeWatermark,
 		double *StutterExitWatermark,
 		double *StutterEnterPlusExitWatermark,
 		double *Z8StutterExitWatermark,
-		double *Z8StutterEnterPlusExitWatermark,
-		double *MinActiveDRAMClockChangeLatencySupported);
+		double *Z8StutterEnterPlusExitWatermark);
 
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
@@ -3041,64 +3005,28 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		CalculateWatermarksAndDRAMSpeedChangeSupport(
 				mode_lib,
 				PrefetchMode,
-				v->NumberOfActivePlanes,
-				v->MaxLineBufferLines,
-				v->LineBufferSize,
-				v->WritebackInterfaceBufferSize,
 				v->DCFCLK,
 				v->ReturnBW,
-				v->SynchronizedVBlank,
-				v->dpte_group_bytes,
-				v->MetaChunkSize,
 				v->UrgentLatency,
 				v->UrgentExtraLatency,
-				v->WritebackLatency,
-				v->WritebackChunkSize,
 				v->SOCCLK,
-				v->DRAMClockChangeLatency,
-				v->SRExitTime,
-				v->SREnterPlusExitTime,
-				v->SRExitZ8Time,
-				v->SREnterPlusExitZ8Time,
 				v->DCFCLKDeepSleep,
 				v->DETBufferSizeY,
 				v->DETBufferSizeC,
 				v->SwathHeightY,
 				v->SwathHeightC,
-				v->LBBitPerPixel,
 				v->SwathWidthY,
 				v->SwathWidthC,
-				v->HRatio,
-				v->HRatioChroma,
-				v->vtaps,
-				v->VTAPsChroma,
-				v->VRatio,
-				v->VRatioChroma,
-				v->HTotal,
-				v->PixelClock,
-				v->BlendingAndTiming,
 				v->DPPPerPlane,
 				v->BytePerPixelDETY,
 				v->BytePerPixelDETC,
-				v->DSTXAfterScaler,
-				v->DSTYAfterScaler,
-				v->WritebackEnable,
-				v->WritebackPixelFormat,
-				v->WritebackDestinationWidth,
-				v->WritebackDestinationHeight,
-				v->WritebackSourceHeight,
 				v->UnboundedRequestEnabled,
 				v->CompressedBufferSizeInkByte,
 				&DRAMClockChangeSupport,
-				&v->UrgentWatermark,
-				&v->WritebackUrgentWatermark,
-				&v->DRAMClockChangeWatermark,
-				&v->WritebackDRAMClockChangeWatermark,
 				&v->StutterExitWatermark,
 				&v->StutterEnterPlusExitWatermark,
 				&v->Z8StutterExitWatermark,
-				&v->Z8StutterEnterPlusExitWatermark,
-				&v->MinActiveDRAMClockChangeLatencySupported);
+				&v->Z8StutterEnterPlusExitWatermark);
 
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 			if (v->WritebackEnable[k] == true) {
@@ -5496,64 +5424,28 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 			CalculateWatermarksAndDRAMSpeedChangeSupport(
 					mode_lib,
 					v->PrefetchModePerState[i][j],
-					v->NumberOfActivePlanes,
-					v->MaxLineBufferLines,
-					v->LineBufferSize,
-					v->WritebackInterfaceBufferSize,
 					v->DCFCLKState[i][j],
 					v->ReturnBWPerState[i][j],
-					v->SynchronizedVBlank,
-					v->dpte_group_bytes,
-					v->MetaChunkSize,
 					v->UrgLatency[i],
 					v->ExtraLatency,
-					v->WritebackLatency,
-					v->WritebackChunkSize,
 					v->SOCCLKPerState[i],
-					v->DRAMClockChangeLatency,
-					v->SRExitTime,
-					v->SREnterPlusExitTime,
-					v->SRExitZ8Time,
-					v->SREnterPlusExitZ8Time,
 					v->ProjectedDCFCLKDeepSleep[i][j],
 					v->DETBufferSizeYThisState,
 					v->DETBufferSizeCThisState,
 					v->SwathHeightYThisState,
 					v->SwathHeightCThisState,
-					v->LBBitPerPixel,
 					v->SwathWidthYThisState,
 					v->SwathWidthCThisState,
-					v->HRatio,
-					v->HRatioChroma,
-					v->vtaps,
-					v->VTAPsChroma,
-					v->VRatio,
-					v->VRatioChroma,
-					v->HTotal,
-					v->PixelClock,
-					v->BlendingAndTiming,
 					v->NoOfDPPThisState,
 					v->BytePerPixelInDETY,
 					v->BytePerPixelInDETC,
-					v->DSTXAfterScaler,
-					v->DSTYAfterScaler,
-					v->WritebackEnable,
-					v->WritebackPixelFormat,
-					v->WritebackDestinationWidth,
-					v->WritebackDestinationHeight,
-					v->WritebackSourceHeight,
 					UnboundedRequestEnabledThisState,
 					CompressedBufferSizeInkByteThisState,
 					&v->DRAMClockChangeSupport[i][j],
-					&v->UrgentWatermark,
-					&v->WritebackUrgentWatermark,
-					&v->DRAMClockChangeWatermark,
-					&v->WritebackDRAMClockChangeWatermark,
-					&dummy,
 					&dummy,
 					&dummy,
 					&dummy,
-					&v->MinActiveDRAMClockChangeLatencySupported);
+					&dummy);
 		}
 	}
 
@@ -5679,64 +5571,28 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		struct display_mode_lib *mode_lib,
 		unsigned int PrefetchMode,
-		unsigned int NumberOfActivePlanes,
-		unsigned int MaxLineBufferLines,
-		unsigned int LineBufferSize,
-		unsigned int WritebackInterfaceBufferSize,
 		double DCFCLK,
 		double ReturnBW,
-		bool SynchronizedVBlank,
-		unsigned int dpte_group_bytes[],
-		unsigned int MetaChunkSize,
 		double UrgentLatency,
 		double ExtraLatency,
-		double WritebackLatency,
-		double WritebackChunkSize,
 		double SOCCLK,
-		double DRAMClockChangeLatency,
-		double SRExitTime,
-		double SREnterPlusExitTime,
-		double SRExitZ8Time,
-		double SREnterPlusExitZ8Time,
 		double DCFCLKDeepSleep,
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		unsigned int SwathHeightY[],
 		unsigned int SwathHeightC[],
-		unsigned int LBBitPerPixel[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		double HRatio[],
-		double HRatioChroma[],
-		unsigned int vtaps[],
-		unsigned int VTAPsChroma[],
-		double VRatio[],
-		double VRatioChroma[],
-		unsigned int HTotal[],
-		double PixelClock[],
-		unsigned int BlendingAndTiming[],
 		unsigned int DPPPerPlane[],
 		double BytePerPixelDETY[],
 		double BytePerPixelDETC[],
-		double DSTXAfterScaler[],
-		double DSTYAfterScaler[],
-		bool WritebackEnable[],
-		enum source_format_class WritebackPixelFormat[],
-		double WritebackDestinationWidth[],
-		double WritebackDestinationHeight[],
-		double WritebackSourceHeight[],
 		bool UnboundedRequestEnabled,
 		unsigned int CompressedBufferSizeInkByte,
 		enum clock_change_support *DRAMClockChangeSupport,
-		double *UrgentWatermark,
-		double *WritebackUrgentWatermark,
-		double *DRAMClockChangeWatermark,
-		double *WritebackDRAMClockChangeWatermark,
 		double *StutterExitWatermark,
 		double *StutterEnterPlusExitWatermark,
 		double *Z8StutterExitWatermark,
-		double *Z8StutterEnterPlusExitWatermark,
-		double *MinActiveDRAMClockChangeLatencySupported)
+		double *Z8StutterEnterPlusExitWatermark)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
 	double EffectiveLBLatencyHidingY;
@@ -5756,103 +5612,103 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double TotalPixelBW = 0.0;
 	int k, j;
 
-	*UrgentWatermark = UrgentLatency + ExtraLatency;
+	v->UrgentWatermark = UrgentLatency + ExtraLatency;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: UrgentLatency = %f\n", __func__, UrgentLatency);
 	dml_print("DML::%s: ExtraLatency = %f\n", __func__, ExtraLatency);
-	dml_print("DML::%s: UrgentWatermark = %f\n", __func__, *UrgentWatermark);
+	dml_print("DML::%s: UrgentWatermark = %f\n", __func__, v->UrgentWatermark);
 #endif
 
-	*DRAMClockChangeWatermark = DRAMClockChangeLatency + *UrgentWatermark;
+	v->DRAMClockChangeWatermark = v->DRAMClockChangeLatency + v->UrgentWatermark;
 
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: DRAMClockChangeLatency = %f\n", __func__, DRAMClockChangeLatency);
-	dml_print("DML::%s: DRAMClockChangeWatermark = %f\n", __func__, *DRAMClockChangeWatermark);
+	dml_print("DML::%s: v->DRAMClockChangeLatency = %f\n", __func__, v->DRAMClockChangeLatency);
+	dml_print("DML::%s: DRAMClockChangeWatermark = %f\n", __func__, v->DRAMClockChangeWatermark);
 #endif
 
 	v->TotalActiveWriteback = 0;
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
-		if (WritebackEnable[k] == true) {
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+		if (v->WritebackEnable[k] == true) {
 			v->TotalActiveWriteback = v->TotalActiveWriteback + 1;
 		}
 	}
 
 	if (v->TotalActiveWriteback <= 1) {
-		*WritebackUrgentWatermark = WritebackLatency;
+		v->WritebackUrgentWatermark = v->WritebackLatency;
 	} else {
-		*WritebackUrgentWatermark = WritebackLatency + WritebackChunkSize * 1024.0 / 32.0 / SOCCLK;
+		v->WritebackUrgentWatermark = v->WritebackLatency + v->WritebackChunkSize * 1024.0 / 32.0 / SOCCLK;
 	}
 
 	if (v->TotalActiveWriteback <= 1) {
-		*WritebackDRAMClockChangeWatermark = DRAMClockChangeLatency + WritebackLatency;
+		v->WritebackDRAMClockChangeWatermark = v->DRAMClockChangeLatency + v->WritebackLatency;
 	} else {
-		*WritebackDRAMClockChangeWatermark = DRAMClockChangeLatency + WritebackLatency + WritebackChunkSize * 1024.0 / 32.0 / SOCCLK;
+		v->WritebackDRAMClockChangeWatermark = v->DRAMClockChangeLatency + v->WritebackLatency + v->WritebackChunkSize * 1024.0 / 32.0 / SOCCLK;
 	}
 
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 		TotalPixelBW = TotalPixelBW
-				+ DPPPerPlane[k] * (SwathWidthY[k] * BytePerPixelDETY[k] * VRatio[k] + SwathWidthC[k] * BytePerPixelDETC[k] * VRatioChroma[k])
-						/ (HTotal[k] / PixelClock[k]);
+				+ DPPPerPlane[k] * (SwathWidthY[k] * BytePerPixelDETY[k] * v->VRatio[k] + SwathWidthC[k] * BytePerPixelDETC[k] * v->VRatioChroma[k])
+						/ (v->HTotal[k] / v->PixelClock[k]);
 	}
 
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 		double EffectiveDETBufferSizeY = DETBufferSizeY[k];
 
 		v->LBLatencyHidingSourceLinesY = dml_min(
-				(double) MaxLineBufferLines,
-				dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthY[k] / dml_max(HRatio[k], 1.0)), 1)) - (vtaps[k] - 1);
+				(double) v->MaxLineBufferLines,
+				dml_floor(v->LineBufferSize / v->LBBitPerPixel[k] / (SwathWidthY[k] / dml_max(v->HRatio[k], 1.0)), 1)) - (v->vtaps[k] - 1);
 
 		v->LBLatencyHidingSourceLinesC = dml_min(
-				(double) MaxLineBufferLines,
-				dml_floor(LineBufferSize / LBBitPerPixel[k] / (SwathWidthC[k] / dml_max(HRatioChroma[k], 1.0)), 1)) - (VTAPsChroma[k] - 1);
+				(double) v->MaxLineBufferLines,
+				dml_floor(v->LineBufferSize / v->LBBitPerPixel[k] / (SwathWidthC[k] / dml_max(v->HRatioChroma[k], 1.0)), 1)) - (v->VTAPsChroma[k] - 1);
 
-		EffectiveLBLatencyHidingY = v->LBLatencyHidingSourceLinesY / VRatio[k] * (HTotal[k] / PixelClock[k]);
+		EffectiveLBLatencyHidingY = v->LBLatencyHidingSourceLinesY / v->VRatio[k] * (v->HTotal[k] / v->PixelClock[k]);
 
-		EffectiveLBLatencyHidingC = v->LBLatencyHidingSourceLinesC / VRatioChroma[k] * (HTotal[k] / PixelClock[k]);
+		EffectiveLBLatencyHidingC = v->LBLatencyHidingSourceLinesC / v->VRatioChroma[k] * (v->HTotal[k] / v->PixelClock[k]);
 
 		if (UnboundedRequestEnabled) {
 			EffectiveDETBufferSizeY = EffectiveDETBufferSizeY
-					+ CompressedBufferSizeInkByte * 1024 * SwathWidthY[k] * BytePerPixelDETY[k] * VRatio[k] / (HTotal[k] / PixelClock[k]) / TotalPixelBW;
+					+ CompressedBufferSizeInkByte * 1024 * SwathWidthY[k] * BytePerPixelDETY[k] * v->VRatio[k] / (v->HTotal[k] / v->PixelClock[k]) / TotalPixelBW;
 		}
 
 		LinesInDETY[k] = (double) EffectiveDETBufferSizeY / BytePerPixelDETY[k] / SwathWidthY[k];
 		LinesInDETYRoundedDownToSwath[k] = dml_floor(LinesInDETY[k], SwathHeightY[k]);
-		FullDETBufferingTimeY = LinesInDETYRoundedDownToSwath[k] * (HTotal[k] / PixelClock[k]) / VRatio[k];
+		FullDETBufferingTimeY = LinesInDETYRoundedDownToSwath[k] * (v->HTotal[k] / v->PixelClock[k]) / v->VRatio[k];
 		if (BytePerPixelDETC[k] > 0) {
 			LinesInDETC = v->DETBufferSizeC[k] / BytePerPixelDETC[k] / SwathWidthC[k];
 			LinesInDETCRoundedDownToSwath = dml_floor(LinesInDETC, SwathHeightC[k]);
-			FullDETBufferingTimeC = LinesInDETCRoundedDownToSwath * (HTotal[k] / PixelClock[k]) / VRatioChroma[k];
+			FullDETBufferingTimeC = LinesInDETCRoundedDownToSwath * (v->HTotal[k] / v->PixelClock[k]) / v->VRatioChroma[k];
 		} else {
 			LinesInDETC = 0;
 			FullDETBufferingTimeC = 999999;
 		}
 
 		ActiveDRAMClockChangeLatencyMarginY = EffectiveLBLatencyHidingY + FullDETBufferingTimeY
-				- ((double) DSTXAfterScaler[k] / HTotal[k] + DSTYAfterScaler[k]) * HTotal[k] / PixelClock[k] - *UrgentWatermark - *DRAMClockChangeWatermark;
+				- ((double) v->DSTXAfterScaler[k] / v->HTotal[k] + v->DSTYAfterScaler[k]) * v->HTotal[k] / v->PixelClock[k] - v->UrgentWatermark - v->DRAMClockChangeWatermark;
 
-		if (NumberOfActivePlanes > 1) {
+		if (v->NumberOfActivePlanes > 1) {
 			ActiveDRAMClockChangeLatencyMarginY = ActiveDRAMClockChangeLatencyMarginY
-					- (1 - 1.0 / NumberOfActivePlanes) * SwathHeightY[k] * HTotal[k] / PixelClock[k] / VRatio[k];
+					- (1 - 1.0 / v->NumberOfActivePlanes) * SwathHeightY[k] * v->HTotal[k] / v->PixelClock[k] / v->VRatio[k];
 		}
 
 		if (BytePerPixelDETC[k] > 0) {
 			ActiveDRAMClockChangeLatencyMarginC = EffectiveLBLatencyHidingC + FullDETBufferingTimeC
-					- ((double) DSTXAfterScaler[k] / HTotal[k] + DSTYAfterScaler[k]) * HTotal[k] / PixelClock[k] - *UrgentWatermark - *DRAMClockChangeWatermark;
+					- ((double) v->DSTXAfterScaler[k] / v->HTotal[k] + v->DSTYAfterScaler[k]) * v->HTotal[k] / v->PixelClock[k] - v->UrgentWatermark - v->DRAMClockChangeWatermark;
 
-			if (NumberOfActivePlanes > 1) {
+			if (v->NumberOfActivePlanes > 1) {
 				ActiveDRAMClockChangeLatencyMarginC = ActiveDRAMClockChangeLatencyMarginC
-						- (1 - 1.0 / NumberOfActivePlanes) * SwathHeightC[k] * HTotal[k] / PixelClock[k] / VRatioChroma[k];
+						- (1 - 1.0 / v->NumberOfActivePlanes) * SwathHeightC[k] * v->HTotal[k] / v->PixelClock[k] / v->VRatioChroma[k];
 			}
 			v->ActiveDRAMClockChangeLatencyMargin[k] = dml_min(ActiveDRAMClockChangeLatencyMarginY, ActiveDRAMClockChangeLatencyMarginC);
 		} else {
 			v->ActiveDRAMClockChangeLatencyMargin[k] = ActiveDRAMClockChangeLatencyMarginY;
 		}
 
-		if (WritebackEnable[k] == true) {
-			WritebackDRAMClockChangeLatencyHiding = WritebackInterfaceBufferSize * 1024
-					/ (WritebackDestinationWidth[k] * WritebackDestinationHeight[k] / (WritebackSourceHeight[k] * HTotal[k] / PixelClock[k]) * 4);
-			if (WritebackPixelFormat[k] == dm_444_64) {
+		if (v->WritebackEnable[k] == true) {
+			WritebackDRAMClockChangeLatencyHiding = v->WritebackInterfaceBufferSize * 1024
+					/ (v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k] / (v->WritebackSourceHeight[k] * v->HTotal[k] / v->PixelClock[k]) * 4);
+			if (v->WritebackPixelFormat[k] == dm_444_64) {
 				WritebackDRAMClockChangeLatencyHiding = WritebackDRAMClockChangeLatencyHiding / 2;
 			}
 			WritebackDRAMClockChangeLatencyMargin = WritebackDRAMClockChangeLatencyHiding - v->WritebackDRAMClockChangeWatermark;
@@ -5862,14 +5718,14 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 
 	v->MinActiveDRAMClockChangeMargin = 999999;
 	PlaneWithMinActiveDRAMClockChangeMargin = 0;
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 		if (v->ActiveDRAMClockChangeLatencyMargin[k] < v->MinActiveDRAMClockChangeMargin) {
 			v->MinActiveDRAMClockChangeMargin = v->ActiveDRAMClockChangeLatencyMargin[k];
-			if (BlendingAndTiming[k] == k) {
+			if (v->BlendingAndTiming[k] == k) {
 				PlaneWithMinActiveDRAMClockChangeMargin = k;
 			} else {
-				for (j = 0; j < NumberOfActivePlanes; ++j) {
-					if (BlendingAndTiming[k] == j) {
+				for (j = 0; j < v->NumberOfActivePlanes; ++j) {
+					if (v->BlendingAndTiming[k] == j) {
 						PlaneWithMinActiveDRAMClockChangeMargin = j;
 					}
 				}
@@ -5877,11 +5733,11 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	*MinActiveDRAMClockChangeLatencySupported = v->MinActiveDRAMClockChangeMargin + DRAMClockChangeLatency;
+	v->MinActiveDRAMClockChangeLatencySupported = v->MinActiveDRAMClockChangeMargin + v->DRAMClockChangeLatency ;
 
 	SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank = 999999;
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
-		if (!((k == PlaneWithMinActiveDRAMClockChangeMargin) && (BlendingAndTiming[k] == k)) && !(BlendingAndTiming[k] == PlaneWithMinActiveDRAMClockChangeMargin)
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+		if (!((k == PlaneWithMinActiveDRAMClockChangeMargin) && (v->BlendingAndTiming[k] == k)) && !(v->BlendingAndTiming[k] == PlaneWithMinActiveDRAMClockChangeMargin)
 				&& v->ActiveDRAMClockChangeLatencyMargin[k] < SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank) {
 			SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank = v->ActiveDRAMClockChangeLatencyMargin[k];
 		}
@@ -5889,25 +5745,25 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 
 	v->TotalNumberOfActiveOTG = 0;
 
-	for (k = 0; k < NumberOfActivePlanes; ++k) {
-		if (BlendingAndTiming[k] == k) {
+	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+		if (v->BlendingAndTiming[k] == k) {
 			v->TotalNumberOfActiveOTG = v->TotalNumberOfActiveOTG + 1;
 		}
 	}
 
 	if (v->MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
-	} else if ((SynchronizedVBlank == true || v->TotalNumberOfActiveOTG == 1
+	} else if ((v->SynchronizedVBlank == true || v->TotalNumberOfActiveOTG == 1
 			|| SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0) && PrefetchMode == 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
 	} else {
 		*DRAMClockChangeSupport = dm_dram_clock_change_unsupported;
 	}
 
-	*StutterExitWatermark = SRExitTime + ExtraLatency + 10 / DCFCLKDeepSleep;
-	*StutterEnterPlusExitWatermark = (SREnterPlusExitTime + ExtraLatency + 10 / DCFCLKDeepSleep);
-	*Z8StutterExitWatermark = SRExitZ8Time + ExtraLatency + 10 / DCFCLKDeepSleep;
-	*Z8StutterEnterPlusExitWatermark = SREnterPlusExitZ8Time + ExtraLatency + 10 / DCFCLKDeepSleep;
+	*StutterExitWatermark = v->SRExitTime + ExtraLatency + 10 / DCFCLKDeepSleep;
+	*StutterEnterPlusExitWatermark = (v->SREnterPlusExitTime + ExtraLatency + 10 / DCFCLKDeepSleep);
+	*Z8StutterExitWatermark = v->SRExitZ8Time + ExtraLatency + 10 / DCFCLKDeepSleep;
+	*Z8StutterEnterPlusExitWatermark = v->SREnterPlusExitZ8Time + ExtraLatency + 10 / DCFCLKDeepSleep;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: StutterExitWatermark = %f\n", __func__, *StutterExitWatermark);
-- 
2.25.1

