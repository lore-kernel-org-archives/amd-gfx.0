Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6C3C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 17:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BDB10F1B8;
	Fri, 22 Jul 2022 17:56:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9D011B2CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 17:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXuxCc7iqGJkXXxWOfsfrNQHubIVXrbqRPmXjOF6MiO3Gg+YxLobx+gWosJe8XCrgp4K+zzE3v2uk38fvYecnXnPNAd1QNi9qO0MNosVNPDWlLl3Kvo0gd5v3a8vxFOMvroxYs+Xva5PgSKuBgi5I2f+lv6jMbqGyjRZqnzjGpVxahTVBIrJLUEiN+3gt2zML86bsZ7XlIJwcDi/DPAFXBQhj9ZIvSAq9ZInhDFfBih0vQzTE39qYXrnm62uxW+Xl2kpBeA9rAngT4EIFZh0jQ87d0ymWlMNHZxJdyZ1YNe457OkI5GPBTFoZ2mcxe9Ui6Qx2HOJEI/1yp42lIonPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OANglqwoT18TYrqhD3HUnIjLnYKeQIT5o1Gm2kob+tA=;
 b=Z2gdTjIcPl9cLFyZr7fz0w5iOaN6I0LDJUAxPRyaCmvcx25VMT1AZEVTkHCAtlS/2qe7r4cyQK7iZvg23ia2K6TdAUC33Wmz0Cc6rMKGJCvA2fHmptoUmEzAMi1QsbWOuiTov8xxvRTHOw1lAJP/oBEMoaBORAC60ZlgwvoFL+mCKFfBQ9jGc0ZI7CQ10y3OY8b2XvN9RCZUg1sABPXY4QdzZo8FFeOxqwG4tzdvohM2fCueKAKYToWQDcuVCS8vSHtc3nawCG+GNw5pHkYidlAX2X/V7ICJ5C/6YOXrA7EslpP1dRcbDreAp+ll10kIctFuRn7c3rtma4zkV6BG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OANglqwoT18TYrqhD3HUnIjLnYKeQIT5o1Gm2kob+tA=;
 b=S3B1v+F4wmUqzF0RcnwL02a/IVLND5aAdNVzEmMVzM4myFf1wfFiJBnI4wdbJtPWdwDBTrGrgVw0HyBdnxVdzZDKMQfbqJcsJpnP3dKFUQiOtxzO7lTcfWAo0f1U/nhcWyRcWjG7U8dIrvKXWlzTGOhURnIONnz/uQKDNlxkzzA=
Received: from DM6PR06CA0071.namprd06.prod.outlook.com (2603:10b6:5:54::48) by
 CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 22 Jul 2022 17:56:32 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::32) by DM6PR06CA0071.outlook.office365.com
 (2603:10b6:5:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 17:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 17:56:32 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 12:56:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
Date: Fri, 22 Jul 2022 13:56:17 -0400
Message-ID: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193efbed-7c15-4950-fff2-08da6c0b8305
X-MS-TrafficTypeDiagnostic: CH0PR12MB5041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vH7Lcz2OG3IU4Dyyti+dT/CQfTIhnocnIhE4ZBWYiqe9Xm32ai0kbCWb1MuYYBAc6Kgj6FY/ExByRuLQuBzW2x9tPXD+ri2PdZ8hbJV8oj4yF8jVPfvGjv6ZLeYhN+qkottcUC9bgxuh2j1hpcJrz75wQ3iGC6Ylu2WZ++kONNfcQ3Bs1I5bZRTwAgt69QJ4dpgpQqXTlvi7pn0S4Wr1h5cF5OVGV1EtxtAGtZNOzk3NdGEbAnfKat18w84b4UmopHrBO63z67gmdkFqBbmoLc00YSERDVgF4j4ZArtbVZp/pM42KJyc5kgH1GmtVpYJIi82I9xyj70QsXR3klfL0zdl995K/vZGzwA8qs9HUp4nL9Y+1TkYz6FPFUocHGy6RWDru7dYA2DkfBiKindeCKoNGostCV0OxUSuepv77reIw5X2GseQN721+v8moXIqn1iysMAc2tX9S6bYLdgdagv3iKuGHDOnJN4w4+p/ufF7tTbmWIDYEeTJXGhVDVrJUL12TmUrkuSzVllmLMm+bYXzY1ZWIyyEGC0u+u9LB7XTyHeEWapPEtoG0y+XwiMXUYT5SkuTXhldDz1YqQOfmZK/gwyEL4PhCqFhuKO6ulYT004u1yMGVDSUS2IQVWt7FSpMpikv9s8J2rpzPHp/Tbh2099SAgvs77D2gw7wwIeMXQpSET/4MPI7xpelCG4vEVPcuCfXiLgvrL4cOKRN4NJRwKlra/4w1UvzmXdvsR5gduMdhz2wrlVMHwRlBkNYMWqNE38qNjCg0uo9k2lQb+VKa9gOQ7c94bu8XCvie8LDxjP8PmZ6iCfW94of1FbTdhN0mZij96Fv4k+o+xMEJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(5660300002)(36756003)(8676002)(36860700001)(426003)(336012)(47076005)(1076003)(16526019)(316002)(186003)(8936002)(4326008)(70586007)(70206006)(40480700001)(478600001)(2906002)(6666004)(41300700001)(54906003)(26005)(7696005)(86362001)(2616005)(82310400005)(6916009)(356005)(81166007)(82740400003)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 17:56:32.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193efbed-7c15-4950-fff2-08da6c0b8305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we use the allmodconfig option we see the following error:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
  3799 | } // ModeSupportAndSystemConfigurationFull

This commit fixes this issue by moving part of the mode support
operation from ModeSupportAndSystemConfigurationFull to a dedicated
function.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 132 ++++++++++--------
 1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 573504de1789..465fd240b8fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1654,6 +1654,75 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 #endif
 }
 
+static void mode_support_configuration(struct vba_vars_st *v,
+				  struct display_mode_lib *mode_lib)
+{
+	int i, j;
+
+	for (i = v->soc.num_states - 1; i >= 0; i--) {
+		for (j = 0; j < 2; j++) {
+			if (mode_lib->vba.ScaleRatioAndTapsSupport == true
+				&& mode_lib->vba.SourceFormatPixelAndScanSupport == true
+				&& mode_lib->vba.ViewportSizeSupport[i][j] == true
+				&& !mode_lib->vba.LinkRateDoesNotMatchDPVersion
+				&& !mode_lib->vba.LinkRateForMultistreamNotIndicated
+				&& !mode_lib->vba.BPPForMultistreamNotIndicated
+				&& !mode_lib->vba.MultistreamWithHDMIOreDP
+				&& !mode_lib->vba.ExceededMultistreamSlots[i]
+				&& !mode_lib->vba.MSOOrODMSplitWithNonDPLink
+				&& !mode_lib->vba.NotEnoughLanesForMSO
+				&& mode_lib->vba.LinkCapacitySupport[i] == true && !mode_lib->vba.P2IWith420
+				&& !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
+				&& !mode_lib->vba.DSC422NativeNotSupported
+				&& !mode_lib->vba.MPCCombineMethodIncompatible
+				&& mode_lib->vba.ODMCombine2To1SupportCheckOK[i] == true
+				&& mode_lib->vba.ODMCombine4To1SupportCheckOK[i] == true
+				&& mode_lib->vba.NotEnoughDSCUnits[i] == false
+				&& !mode_lib->vba.NotEnoughDSCSlices[i]
+				&& !mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe
+				&& !mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
+				&& mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] == false
+				&& mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i]
+				&& mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] == false
+				&& !mode_lib->vba.InvalidCombinationOfMALLUseForPState
+				&& !mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
+				&& mode_lib->vba.ROBSupport[i][j] == true
+				&& mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] == true
+				&& mode_lib->vba.TotalAvailablePipesSupport[i][j] == true
+				&& mode_lib->vba.NumberOfOTGSupport == true
+				&& mode_lib->vba.NumberOfHDMIFRLSupport == true
+				&& mode_lib->vba.EnoughWritebackUnits == true
+				&& mode_lib->vba.WritebackLatencySupport == true
+				&& mode_lib->vba.WritebackScaleRatioAndTapsSupport == true
+				&& mode_lib->vba.CursorSupport == true && mode_lib->vba.PitchSupport == true
+				&& mode_lib->vba.ViewportExceedsSurface == false
+				&& mode_lib->vba.PrefetchSupported[i][j] == true
+				&& mode_lib->vba.VActiveBandwithSupport[i][j] == true
+				&& mode_lib->vba.DynamicMetadataSupported[i][j] == true
+				&& mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] == true
+				&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true
+				&& mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
+				&& mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
+				&& mode_lib->vba.NonsupportedDSCInputBPC == false
+				&& !mode_lib->vba.ExceededMALLSize
+				&& ((mode_lib->vba.HostVMEnable == false
+				&& !mode_lib->vba.ImmediateFlipRequiredFinal)
+				|| mode_lib->vba.ImmediateFlipSupportedForState[i][j])
+				&& (!mode_lib->vba.DRAMClockChangeRequirementFinal
+				|| i == v->soc.num_states - 1
+				|| mode_lib->vba.DRAMClockChangeSupport[i][j] != dm_dram_clock_change_unsupported)
+				&& (!mode_lib->vba.FCLKChangeRequirementFinal || i == v->soc.num_states - 1
+				|| mode_lib->vba.FCLKChangeSupport[i][j] != dm_fclock_change_unsupported)
+				&& (!mode_lib->vba.USRRetrainingRequiredFinal
+				|| &mode_lib->vba.USRRetrainingSupport[i][j])) {
+				mode_lib->vba.ModeSupport[i][j] = true;
+			} else {
+				mode_lib->vba.ModeSupport[i][j] = false;
+			}
+		}
+	}
+}
+
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
@@ -3632,68 +3701,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*Mode Support, Voltage State and SOC Configuration*/
-	for (i = v->soc.num_states - 1; i >= 0; i--) {
-		for (j = 0; j < 2; j++) {
-			if (mode_lib->vba.ScaleRatioAndTapsSupport == true
-				&& mode_lib->vba.SourceFormatPixelAndScanSupport == true
-				&& mode_lib->vba.ViewportSizeSupport[i][j] == true
-				&& !mode_lib->vba.LinkRateDoesNotMatchDPVersion
-				&& !mode_lib->vba.LinkRateForMultistreamNotIndicated
-				&& !mode_lib->vba.BPPForMultistreamNotIndicated
-				&& !mode_lib->vba.MultistreamWithHDMIOreDP
-				&& !mode_lib->vba.ExceededMultistreamSlots[i]
-				&& !mode_lib->vba.MSOOrODMSplitWithNonDPLink
-				&& !mode_lib->vba.NotEnoughLanesForMSO
-				&& mode_lib->vba.LinkCapacitySupport[i] == true && !mode_lib->vba.P2IWith420
-				&& !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
-				&& !mode_lib->vba.DSC422NativeNotSupported
-				&& !mode_lib->vba.MPCCombineMethodIncompatible
-				&& mode_lib->vba.ODMCombine2To1SupportCheckOK[i] == true
-				&& mode_lib->vba.ODMCombine4To1SupportCheckOK[i] == true
-				&& mode_lib->vba.NotEnoughDSCUnits[i] == false
-				&& !mode_lib->vba.NotEnoughDSCSlices[i]
-				&& !mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe
-				&& !mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
-				&& mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] == false
-				&& mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i]
-				&& mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] == false
-				&& !mode_lib->vba.InvalidCombinationOfMALLUseForPState
-				&& !mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
-				&& mode_lib->vba.ROBSupport[i][j] == true
-				&& mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] == true
-				&& mode_lib->vba.TotalAvailablePipesSupport[i][j] == true
-				&& mode_lib->vba.NumberOfOTGSupport == true
-				&& mode_lib->vba.NumberOfHDMIFRLSupport == true
-				&& mode_lib->vba.EnoughWritebackUnits == true
-				&& mode_lib->vba.WritebackLatencySupport == true
-				&& mode_lib->vba.WritebackScaleRatioAndTapsSupport == true
-				&& mode_lib->vba.CursorSupport == true && mode_lib->vba.PitchSupport == true
-				&& mode_lib->vba.ViewportExceedsSurface == false
-				&& mode_lib->vba.PrefetchSupported[i][j] == true
-				&& mode_lib->vba.VActiveBandwithSupport[i][j] == true
-				&& mode_lib->vba.DynamicMetadataSupported[i][j] == true
-				&& mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] == true
-				&& mode_lib->vba.VRatioInPrefetchSupported[i][j] == true
-				&& mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
-				&& mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
-				&& mode_lib->vba.NonsupportedDSCInputBPC == false
-				&& !mode_lib->vba.ExceededMALLSize
-				&& ((mode_lib->vba.HostVMEnable == false
-				&& !mode_lib->vba.ImmediateFlipRequiredFinal)
-				|| mode_lib->vba.ImmediateFlipSupportedForState[i][j])
-				&& (!mode_lib->vba.DRAMClockChangeRequirementFinal
-				|| i == v->soc.num_states - 1
-				|| mode_lib->vba.DRAMClockChangeSupport[i][j] != dm_dram_clock_change_unsupported)
-				&& (!mode_lib->vba.FCLKChangeRequirementFinal || i == v->soc.num_states - 1
-				|| mode_lib->vba.FCLKChangeSupport[i][j] != dm_fclock_change_unsupported)
-				&& (!mode_lib->vba.USRRetrainingRequiredFinal
-				|| &mode_lib->vba.USRRetrainingSupport[i][j])) {
-				mode_lib->vba.ModeSupport[i][j] = true;
-			} else {
-				mode_lib->vba.ModeSupport[i][j] = false;
-			}
-		}
-	}
+	mode_support_configuration(v, mode_lib);
 
 	MaximumMPCCombine = 0;
 
-- 
2.35.1

