Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0984CC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7627610E5F2;
	Tue, 10 Jan 2023 15:44:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3141E10E5EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5zRCXVHwbvlZeNZkBt4djq59sLFkfABuyu8Qu2MGA8HmgCGaUwMs/igDU+KrheUy0thD5n44fh92Li+jvc1LHicztrVr60ZeMAPJ1sElzLhuZRKrOEVdD35KjS79U4KuQUI9eoC/T7Op9/ULrrGiTukrvWlVCgMj0sKhRTMK3q6Rlb8t65zfFoIyI79zrO7SqHIYe+SNLcAW6M8RNDIv26EIpoNfVDNYmbdc3BMfdY5G8NNQ0h+0vZAVeGNik9M1IfmU5zOB94lslZAkuggSnbSUwoFXcIWDPFR2xfoP56ZnY5TeGNsxUfCFfk0LQGHd5/HRF0Q6ufz8Sf36fDt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2Ch4MKLi+Rp6Y0EFdLUiCwYO4rkjv6ORSZFmxzVsOQ=;
 b=UW/TW962RS4VCLvYbR4j5BeUwZbVMEFxrNDfjNRSuBel8Hlz0XhwVGGplLfpdOuvZAi7fP/5z4Rk3kU70VGJrD7XmBsckENCuE1qvw2ywFsIwMMwLBH88YChSIlNKjmEcFH73kZij7O/6g4HIioxxMNrZLtgG4VI4EZ8yW1gd/J3LnNBMDacHB2ccBUCPjVAqqkN1zz0LvooXhHthif2r+zthxOv540mPe6Lxu6uzV3ZgkhgnKTsBMATvhwmetkuEV3XD4oZNPrd8VPAn7syvzHnXDugo57UcD8PBaKyiZoYRZ1kVvBciZ6NLk+xPE01avuAyw3vGqG3l2tdWcv6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Ch4MKLi+Rp6Y0EFdLUiCwYO4rkjv6ORSZFmxzVsOQ=;
 b=Nh/7Z3r+H4nHtTNme32xmdfRVX2sd9A+0WXQ7KLqgOAXipUDmrDP2Jek1yVRhp8uPgKsVHc5QW5Paq4TWHv8QVz7yP8GSrwVIpsKyJ8SPRRN+CW+uzxna93bKfTLOhfiG59ALOzax8w6Seo1iSgWITxK0ZdUprdB66xIHfMuSes=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:44:51 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::24) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:44:50 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:46 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 1/9] drm/amd/display: Introduce UseMinimumDCFCLK_vars to
 reduce stack size in DML
Date: Tue, 10 Jan 2023 10:43:17 -0500
Message-ID: <20230110154325.3350916-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d12124-aba2-4184-e569-08daf3219c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BMxVI/47I5fA/pojivJtIyvhH/FWftSpwS8ygLOfGaKEQKHaGL00xGWMC7bvnA8mN98J5MtWZQWY36/tSUu1F/PjGfyXWi+qCCiQL5Byqjg7mMohZZmgOHXIDotpvOvjeFwR6KVXWVV5apdO3WZbxnU67mmHDplsRGzC7U2TFHvuQD8YIrowRQsr8Zc79Atgs3AsDhsXiJAXlhTZ0vCb3/Vcc319rZmZPk/Mh/ZtwdhFjMNgX1bTqFR5wEOolIIsRMqnr4ptiTHXwVGDwfNuBDuZuZltTqfHNGrbAIU5ux5utJT7g9L55l4gX/pmWLb4x8tVKSYrnlYG1GDs40Nm+8+pEyMazaDCWgNJHnoDVvJ0J0nSVK1b/BFh/7apcIq+E5+mk6Mo4yT6/Zsd9AvyfM6VIJTW1wHQPnszJ9sHRddGmtK2b4q5edUoCYQe7rqRJ4UzaSigNLqXDmnotgWHH2Y0zeLIfoE9YZL91dUUFhbmNZ4ET1KtpE3+iOYCWKAyl3Q65OOz5ahaxXjoXeYUtDXVRLkzl3s5ncYkvNpjrCvMS8uCKfaQt3hSCHTZ2pYcTlxnrb1ezNnLVb3l1jSg7uH2SYndGTjxWCeIMCDMLRPaogz1w8IygFkws0giGqBJW77iwctMRP+rXYiR8wepf6Da+juXVev7CqD7KG/1exyueWbBtJepOgY3AJKudMMny8TD2fjbandDRN34Ajy3YPgi7HXPqZdMe4GxI4rqeJLqi6NWp+S6gBEnufJ6jr1Oj2P0mRhC8U7r/OBi0cC0K/kmcpbZz/fGAFChHKu+wY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(66899015)(86362001)(83380400001)(70206006)(54906003)(40460700003)(110136005)(6636002)(8676002)(41300700001)(4326008)(70586007)(81166007)(82740400003)(356005)(36860700001)(7696005)(478600001)(19627235002)(966005)(186003)(26005)(6666004)(2906002)(8936002)(316002)(5660300002)(40480700001)(426003)(2616005)(16526019)(82310400005)(336012)(47076005)(1076003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:44:50.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d12124-aba2-4184-e569-08daf3219c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

This commit introduces a new struct that will accommodate some internal
variables under the UseMinimumDCFCLK function. This change is the first
of a series of patches that gradually move each of the arrays of double
to the new struct to reduce the stack size for DCN31 and DCN314.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 7 +++----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h      | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index ec351c8418cb..00d3c57f0d98 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6928,7 +6928,6 @@ static void UseMinimumDCFCLK(
 	struct vba_vars_st *v = &mode_lib->vba;
 	int dummy1, i, j, k;
 	double NormalEfficiency,  dummy2, dummy3;
-	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
 
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
@@ -6947,9 +6946,9 @@ static void UseMinimumDCFCLK(
 			int NoOfDPPState[DC__NUM_DPP__MAX];
 			double MinimumTvmPlus2Tr0;
 
-			TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
+			v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-				TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
+				v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
 						+ v->NoOfDPP[i][j][k] * v->DPTEBytesPerRow[i][j][k] / (15.75 * v->HTotal[k] / v->PixelClock[k]);
 			}
 
@@ -6960,7 +6959,7 @@ static void UseMinimumDCFCLK(
 			MinimumTWait = CalculateTWait(MaxPrefetchMode, v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
 			NonDPTEBandwidth = v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j];
 			DPTEBandwidth = (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) ?
-					TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
+					v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
 			DCFCLKRequiredForAverageBandwidth = dml_max3(
 					v->ProjectedDCFCLKDeepSleep[i][j],
 					(NonDPTEBandwidth + v->TotalDPTERowBandwidth[i][j]) / v->ReturnBusWidth
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 81e53e67cd0b..660c22a19c8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -249,6 +249,10 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
 	bool dummy_boolean[2];
 };
 
+struct UseMinimumDCFCLK_vars {
+	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
+};
+
 struct dummy_vars {
 	struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
 	DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
@@ -1236,6 +1240,7 @@ struct vba_vars_st {
 	bool VActiveBandwithSupport[DC__VOLTAGE_STATES][2];
 	bool NotEnoughDETSwathFillLatencyHidingPerState[DC__VOLTAGE_STATES][2];
 	struct dummy_vars dummy_vars;
+	struct UseMinimumDCFCLK_vars UseMinimumDCFCLK_stack_reduction;
 };
 
 bool CalculateMinAndMaxPrefetchMode(
-- 
2.39.0

