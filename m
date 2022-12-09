Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0653DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB57510E560;
	Fri,  9 Dec 2022 16:37:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD4D10E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPYdHwOmekNaLviSJbEvJYYYL3va5rfbGKX9Wmc1dZ3UorB+L9biQ0ThjF1Q4fe/OLKJYjeJYLhWr62odMJmiChLAWzsAz6qbjBpJbTpI0CfCUa0zObW7u3zWrZoyHvMB5LZq8QDMwZHcwC3bcSyib27uQtOtbettcKZvzgloudmEPRovmgRmVcqKf/w85fTaShL3Ton1/IT50loMYeUuxDi1DiK8R9dNPZ+ps7HS6rsDqOTcSJxqNAIxRrNIBjZd2ZYAGioXTUGGo2ZrkJ0ODzQJVsgyHvmaKdjXstJbzFzlCxySIWHzQcGbPmzybhFZGFA72A0FuXIlzprhDcrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN8qNxeBrrIIhW4JTOzANV7F3/Ipg5Imbhn0W0r23Ps=;
 b=U8BEy6CsQRwWgNdXdrhK8S4RaIq2j62M6jVdUyRI1Xavw4kLZRP8x5BTGKi5Sgi1DPCFg0NVqfIf9m8IJzGkOqG75stugBvDZFJvfPWlUjuydnTPRbraYzix1x72Yz7K0QOcin7Nw/T4EalyE5R+bQYeuLd7nLXAyD5QNnojpO/GhFJ8VJT4aIpMqHyJh7673W8ls3YYPjeslXFw63E/VJ7k3Z8fuHsQlOocr+TnBwAvnI5mRlK+9c/qqGMVjmD/lp45y2PIJ7JOCnMZwz+gRyHxphcUSGHPnJifOMdcXNGrkge53UH7Gi5Jrl85G48TkuLUAUZAIRr95qIbNbrosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN8qNxeBrrIIhW4JTOzANV7F3/Ipg5Imbhn0W0r23Ps=;
 b=BCSsyfUbfcwyzofb/yhCl5CRnjCk59wzCyhHlx77LIUhN1eSWmFeq6ESVoldEChMP8q00NEe7VbxLrcK9UeJ2gFOT4egylkGuMvee/sFs6Gzy2eDkQnjcH5Mt0ZRhSqCFrKY1pVfUMdwgrhkU/VjoKezjF4o5B+fRX3cStvLj4I=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:18 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::9d) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:17 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:15 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/23] drm/amd/display: Speed up DML fast_validate path
Date: Fri, 9 Dec 2022 11:36:25 -0500
Message-ID: <20221209163647.25704-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fcf655-28dc-44cc-fe40-08dada03a290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdlchFIvnmUtxNBtsqKdSQN3Dm3wGbqnPr5xeMOwCHYZ0LQsPVJ4Jx5dMtGIIAW4Lv+C/v5TUhKyKb9QPrP3coyn4v8wkpD1BT+UPh5+vna4Y7F8LgyfTF4OuhKZPz/9ZP3XqN1hj0kZYNgZ8eiI/8yQ3G2Xg/KuU/YZCOwxFLD6qCaKwZKHoCh1voNxLbcx+fTPhfhvsAASozzmUx6fLrdoKkxigRXDg+EZWbCiInDaqBypUXCUGpunGGltnTZp9Jf5Fj6Dh+d+Uu/KzAdVN++sE1hTp2mU2BGd6w7qV1N4x6yK4CZ1KcwnxolLXvD5Zaei+LDebmj/2iQOBRVUHnjf+EPXJoNs1ZOUeqTmiDvGyBLphZhz/2pIyDMZHWsVqAiLobkZRHElSzYZSoPyQ5EoMO8pIezjblSPcGUSZX6wGQrXVIuXGWJ9l4YDLX6GBpkZxfL+zCt6Rv5mqtjLtYtnJqYsFZCn5epS9LX7/NKgx44/rRfBNTrxQyRJbb1NX3aVfiyHszO5+hHc2xULW2LDa2N4vZa8q7Ww57iUcPAKcEEk2T79m5Zlx7aqdcLvF5sdUZu6viaNWQqb35FUNfCRmCrnyosEE1OR0bye5oG8UC19Hr0iQb4rdWSqvu0nbrncArda+GgaY9M+rpjcfFkMiFJUpDbQahG1g0bM21KD7HWyneWNzaegx9VKMXfE1bwvfyDXnOckgFHX6FDq/4e5dyCMAaHM3ts02WkPtKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(26005)(6916009)(70586007)(8936002)(41300700001)(8676002)(4326008)(54906003)(70206006)(426003)(47076005)(81166007)(1076003)(36756003)(2906002)(40480700001)(5660300002)(40460700003)(478600001)(6666004)(2616005)(316002)(186003)(82740400003)(16526019)(82310400005)(83380400001)(36860700001)(336012)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:17.2108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fcf655-28dc-44cc-fe40-08dada03a290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Iterating over every voltage state when we need to validate thousands of
configurations all at once (i.e. display hotplug) can take a significant
amount of time.

[How]
Check just the highest voltage state when fast_validate is true to
verify whether the configuration can work at all, then do a proper
validation including all voltage states later when fast_validate is false.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        | 37 ++++++++++---------
 .../drm/amd/display/dc/dml/display_mode_lib.h |  1 +
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f94abd124021..a42ddb911e1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1551,6 +1551,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 			dm_prefetch_support_fclk_and_stutter;
 
+		context->bw_ctx.dml.validate_max_state = fast_validate;
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
 		/* Last attempt with Prefetch mode 2 (dm_prefetch_support_stutter == 3) */
@@ -1559,6 +1560,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				dm_prefetch_support_stutter;
 			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 		}
+		context->bw_ctx.dml.validate_max_state = false;
 
 		if (vlevel < context->bw_ctx.dml.soc.num_states) {
 			memset(split, 0, sizeof(split));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 4b8f5fa0f0ad..05ddddfa0381 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1707,7 +1707,7 @@ static void mode_support_configuration(struct vba_vars_st *v,
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int i, j;
+	int i, j, start_state;
 	unsigned int k, m;
 	unsigned int MaximumMPCCombine;
 	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth;
@@ -1720,7 +1720,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 #endif
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
-
+	if (mode_lib->validate_max_state)
+		start_state = v->soc.num_states - 1;
+	else
+		start_state = 0; 
 	/*Scale Ratio, taps Support Check*/
 
 	mode_lib->vba.ScaleRatioAndTapsSupport = true;
@@ -2009,7 +2012,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
 			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
 			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
@@ -2286,7 +2289,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		mode_lib->vba.ExceededMultistreamSlots[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
@@ -2386,7 +2389,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k
@@ -2403,7 +2406,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = true;
 		mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
@@ -2421,7 +2424,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
@@ -2458,7 +2461,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/* Check DSC Unit and Slices Support */
 	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
 
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		mode_lib->vba.NotEnoughDSCUnits[i] = false;
 		mode_lib->vba.NotEnoughDSCSlices[i] = false;
 		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
@@ -2493,7 +2496,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*DSC Delay per state*/
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
 					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
@@ -2520,7 +2523,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
 	//
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
@@ -2655,7 +2658,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.SurfaceSizeInMALL,
 			&mode_lib->vba.ExceededMALLSize);
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 				mode_lib->vba.swath_width_luma_ub_this_state[k] =
@@ -2882,7 +2885,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	//Calculate Return BW
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
@@ -2961,7 +2964,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			&mode_lib->vba.MinPrefetchMode,
 			&mode_lib->vba.MaxPrefetchMode);
 
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j)
 			mode_lib->vba.DCFCLKState[i][j] = mode_lib->vba.DCFCLKPerState[i];
 	}
@@ -3083,7 +3086,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.DCFCLKState);
 	} // UseMinimumRequiredDCFCLK == true
 
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			mode_lib->vba.ReturnBWPerState[i][j] = dml32_get_return_bw_mbps(&mode_lib->vba.soc, i,
 					mode_lib->vba.HostVMEnable, mode_lib->vba.DCFCLKState[i][j],
@@ -3092,7 +3095,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	//Re-ordering Buffer Support Check
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			if ((mode_lib->vba.ROBBufferSizeInKByte - mode_lib->vba.PixelChunkSizeInKByte) * 1024
 					/ mode_lib->vba.ReturnBWPerState[i][j]
@@ -3114,7 +3117,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				+ mode_lib->vba.ReadBandwidthChroma[k];
 	}
 
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j] =
 				dml_min3(mode_lib->vba.ReturnBusWidth * mode_lib->vba.DCFCLKState[i][j]
@@ -3138,7 +3141,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/* Prefetch Check */
 
-	for (i = 0; i < (int) v->soc.num_states; ++i) {
+	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 
 			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index 3d643d50c3eb..a9d49ef58fb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -91,6 +91,7 @@ struct display_mode_lib {
 	struct dal_logger *logger;
 	struct dml_funcs funcs;
 	struct _vcs_dpi_display_e2e_pipe_params_st dml_pipe_state[6];
+	bool validate_max_state;
 };
 
 void dml_init_instance(struct display_mode_lib *lib,
-- 
2.34.1

