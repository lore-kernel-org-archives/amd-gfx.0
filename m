Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73F9C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62110E5EE;
	Tue, 10 Jan 2023 15:45:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89F410E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsYx7ZjdbULb9t97jYWRnKEoQzMu/tl2jh1XswMmpNPoM4WzMIZuAHDcsW7y3MwCBS+6jP4iqaCaVOIOzzU4fua/uJdAxeX0GOvsLcpbylTKim2j47xabY4T0/UQRyD1PTKUvKTbC39WZ9wYd6nTe6niMFAbKV8OqNAy3cEFFBrlGflLaWqEDWk8++xNdZ9vqyS5SpeV3LCkYw0c8kawYd0XHxyQ1He5MP5fZZRmzd257cXx8zjm0n4zLJVQWk4dDJQmsZfmb9sN2PTeambCXc54EzlHx2ILx0tzke7NACdRyEmTN4wlAAly6nsihBMfHLscSFwE1RgylsGJm5cTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKmcCooDPBc5leu8+nmPHyy2Mjh8+l8HxzjJJr2Z6dQ=;
 b=Veg2K9OW5UmKgvFRt+vCtkWsITwlziKkR5LF1X0gvaxrgUSWsWDss8hxZENCdC36x1pXxEEPNQcYvG68H2lJBamHcgH3vApas2rqUDfb+zJztVly+WW0p/60pRWo0yTCS1BQ8nK+IrKhCmdZnFjttrCf11kSYbU4R1XyoARnfuGBhnGqQzHhfj27wScMlHJ1HremomDodbQNesGtyeA2It5c6jIodW2POERspnVcK4MfC5v71xr8i8sk3OrR8Z1OEZq/aSpXtZpnLBtFlDKiasy+EIzEILWnRofvXNAUzSfNVys38WHTKhhjhO9YeVhh18eKoCiN+scr1nzJkure4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKmcCooDPBc5leu8+nmPHyy2Mjh8+l8HxzjJJr2Z6dQ=;
 b=WCXuywrtsg2fRBgl6YOzxHRSJQsM2VMU3/JxcYBOA8PmFWMwvKF9mw7ifP6krXXrItlJzrEGQau1kcX8EmtOKVBcKtQk9BeAbJ+NPpoU4O31TKfciUM3iQUhZKXD31l476HBKKNVQ9F+9Ru19vSAysHgqHjhdnjKGUOXoXPJafg=
Received: from DM6PR07CA0037.namprd07.prod.outlook.com (2603:10b6:5:74::14) by
 BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:23 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ce) by DM6PR07CA0037.outlook.office365.com
 (2603:10b6:5:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 15:45:23 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Move DynamicMetadataVMExtraLatency to
 UseMinimumDCFCLK_vars
Date: Tue, 10 Jan 2023 10:43:20 -0500
Message-ID: <20230110154325.3350916-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
References: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|BL0PR12MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 75920a93-31d0-4d74-59ce-08daf321afc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REr4Z2fUf/+Blf7MIFDR/+hJhzlAr4KDsAb25M2xIaKlebq2O22mQOmKkjKjGwZj6Yq+3m7JRiIptJsQXBDlPzUeDQF8xpimgV+hM4CL6BS4u6bLWKmaAcDksUoEI3eWELf3bp9HOnJs3kj2TTHszSNCxNi6ecKtk8wHyBs4QnIiCbxKnTxt+NA05NAcPNqW4g8iP2dhYtG+pqEnbu/NAf+T48UtI5d/l4HyaDqWEZ6LlNLTTp9CxlMzuwHB9FEEtVS2HGukvRYm6zGRILyWhZ8Fopg1+iJfBY+TzjyJMWv6KUcMTz5dsuHu44r5nnQ2GKskRp7wi1k5jv0YJHupRCuB/vrf01PsjUNu3ly1TDgYP6kMxQ649W1XHvw5Jk1GT5eYXXWdJXCeMu7xWhf99LQK1eUnecylRvcB/wxAkChRaxjYtMQWel65fpvfuQg5ecz1t0VdIinxUycI7wCBKwAsQIAFRFJFNZV4nFfK1/YzniM0GQl9vAOTzEwhbY4ZLfrf2urzgBSmVHz1hWEzIzYoco6wBFGLGqxgg4Ci5d5YNAVIF/yUJmnJnhHWL3PjyrGNmnfXfLFJkuvqI7QK/gkAcns1MHD2ylnG8sRY6/o9wZWoB9bn0SuWyjnUyI3iJHiaiNniWLr824saBJXTRhFRig0Mm5ULmYUqfAvUGdv8PB8GTi7ZZrHLFjWhu4nY1V79xHIvD6WMSXCLwESpNfSGXFc8js/WvUllcpK8pnjjOK9DyHt8v3bUuwdxiY1C6C3rDZE4iNnva/gIuK6g8yiVDDTULuX3cTNXKj63Aek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(36860700001)(426003)(2906002)(81166007)(356005)(82740400003)(41300700001)(8936002)(82310400005)(5660300002)(19627235002)(40480700001)(186003)(40460700003)(478600001)(6666004)(966005)(8676002)(1076003)(16526019)(2616005)(336012)(4326008)(316002)(26005)(54906003)(70206006)(110136005)(66899015)(86362001)(6636002)(70586007)(7696005)(36756003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:23.2979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75920a93-31d0-4d74-59ce-08daf321afc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It was reported that on kernel v6.2-rc1, we have the following stack
size issue:

make[3]: *** [/kisskb/src/scripts/Makefile.build:504: drivers/media]
Error 2
[...]/display/dc/dml/dcn31/display_mode_vba_31.c: In function
'UseMinimumDCFCLK':
[...]/display/dc/dml/dcn31/display_mode_vba_31.c:7082:1: error: the
frame size of 2224 bytes is larger than 2048 bytes
[-Werror=frame-larger-than=]

This commit move the array of doubles DynamicMetadataVMExtraLatency to a
separated struct (UseMinimumDCFCLK_vars) to reduce the stack size.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c   | 9 ++++-----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h    | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8175f3603f00..904703353958 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6932,7 +6932,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
 			double NonDPTEBandwidth;
 			double DPTEBandwidth;
@@ -6992,14 +6991,14 @@ static void UseMinimumDCFCLK(
 				v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
 				ExpectedPrefetchBWAcceleration = (v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k])
 						/ (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k]);
-				DynamicMetadataVMExtraLatency[k] =
+				v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k] =
 						(v->GPUVMEnable == true && v->DynamicMetadataEnable[k] == true && v->DynamicMetadataVMEnabled == true) ?
 								v->UrgLatency[i] * v->GPUVMMaxPageTableLevels * (v->HostVMEnable == true ? v->HostVMMaxNonCachedPageTableLevels + 1 : 1) : 0;
 				PrefetchTime = (v->MaximumVStartup[i][j][k] - 1) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait
 						- v->UrgLatency[i]
 								* ((v->GPUVMMaxPageTableLevels <= 2 ? v->GPUVMMaxPageTableLevels : v->GPUVMMaxPageTableLevels - 2)
 										* (v->HostVMEnable == true ? v->HostVMMaxNonCachedPageTableLevels + 1 : 1) - 1)
-						- DynamicMetadataVMExtraLatency[k];
+						- v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 
 				if (PrefetchTime > 0) {
 					double ExpectedVRatioPrefetch;
@@ -7041,7 +7040,7 @@ static void UseMinimumDCFCLK(
 							&dummy2,
 							&dummy3);
 					AllowedTimeForUrgentExtraLatency = v->MaximumVStartup[i][j][k] * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - TSetupPipe - TdmbfPipe - TdmecPipe
-							- TdmsksPipe - DynamicMetadataVMExtraLatency[k];
+							- TdmsksPipe - v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 					if (AllowedTimeForUrgentExtraLatency > 0) {
 						v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = dml_max(
 								v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k],
@@ -7062,7 +7061,7 @@ static void UseMinimumDCFCLK(
 							0);
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 				double MaximumTvmPlus2Tr0PlusTsw;
-				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - DynamicMetadataVMExtraLatency[k];
+				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4) {
 					DCFCLKRequiredForPeakBandwidth = v->DCFCLKPerState[i];
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 4c5206bfad38..01c767f08b38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -254,6 +254,7 @@ struct UseMinimumDCFCLK_vars {
 	double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
 	double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
 	double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
+	double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 };
 
 struct dummy_vars {
-- 
2.39.0

