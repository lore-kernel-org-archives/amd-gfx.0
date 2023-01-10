Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59982C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F3510E14F;
	Tue, 10 Jan 2023 16:56:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EEA10E12D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNJMjf4T9Zook97OUXREbqu3aGjs0UYfgForhNbWE+RR1B+fuOLwCd/auHyLAjzVglqkTT1Utbd4JetAGIfbCZEa8s+mjZPhzYpgKu4VQ0s+vbsWOyKpOxpdRxnajh5x38G88cPQpCBBBf+eAwSv4uIIybiUCPU0Lx+BYAVgt4QO6xha2WTrlDInJtD44HKJCCnat5E9eqYxZbEoDBtfxnVtUdguuJJa2YvGvMy7aq0djYTqQrlKzIkEc/1twKhxo1OHEq8xGpDctnSNDiM98FlJR1QvtUUr+qWSnOOhggrtY5xFGtzTHKRJ/sDBF4jjuB8HXBNEI0YgxC37FiDliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb6PW4oBqOYCPQl2hshIqp2xuc0ZAifGFQyUC8h1wcE=;
 b=C+9Qm7MtLxn/TRAQJIRkIyaqUbd5eJxroHaaCaquTUXPVv19pZIUomRPH7DQSttEEO2HPOhGCE2JiNqJrsHirsAfBGyYGbipV6vDhJtm6DsCl9JW/tomjzl2uvFMM8vIZ7dCFCLp2PIdi4kDG9Ja0h9w7lHPMLyw3UDK0oqrkceJlSvkpgkhd+MtD5Of+Qaj7UxKRIW/QUBc2fddHE6UGOumLSwqoKmXp/rwd8uHczs82kXMHgib9cUJI8gJUSu3morHcKKFabYu9qHlMyS5UvSx7/xgydrTpK4fwBhdwd+yd+qaHXdH/Q1KATtL56BUbj7YbXXHkeAis1+gO4cyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb6PW4oBqOYCPQl2hshIqp2xuc0ZAifGFQyUC8h1wcE=;
 b=QGcjGvwLYyQDLEojiBnLH30AiE1MJu++D3DwEpIqlytWC50jmx0zWr7e2iGIiIx9Fc/z204x3OXn0AycIPei+PLKCk6HGTuvsyx77w5AwjX65jFc4JwBhk5HzYzS/0Q0h4Ys68x9uMVag9VAjmGpgT2jlFPgn4G4mFoPlHi2iOE=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:47 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::5e) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:46 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:42 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/37] Revert "drm/amd/display: Speed up DML fast_validate
 path"
Date: Tue, 10 Jan 2023 11:55:00 -0500
Message-ID: <20230110165535.3358492-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 799a7690-d4b7-465f-1b95-08daf32ba8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPzCjvK5HB+kD6jIu5r5qmo9g/FsLjx6nkxAI9dbcwzzt7ceQERD8TYJeCfRfAdkk/ti186SGotqbI7ouOrWXp1Vz6tvfv7Hy+ziZmUaVcMvF6ise6K5KJwIi38Zo4oXrqmxBwcauwKDSHE+UdApJFKi5rXUn4Q4e35/yzyD8Xt3vPx8Xcjx1xalkLuwWg4Qr0aB0u+E6CIXwQm7T57hes6lBElobcYyjalQMacOk20NUWlLjdQfy4hXDUz8Mq+VqW6SwlzKSY8KVVdO7ZKK+XdSNaDSKHmTeBZEbw50h5h9B4Ixe4GZnbqcobk+84pJ2auwhapUS4vRMZCVv4bZZkIIHEwQTiYnOC5va6RkDs5WeDhQJNDs1a6zzl3RM7rtQQ0uk11KadEeOwfUe6+VIPOb3e6IoIYVrWIUOaBm12gNeAL4F3Yl7JtZ/HOl2uIGXdWSub1eS54zGO3VsZQWrp5WzUS28YOBDzU+h1MuQf7TUX3zgm1DeWmeEypP7Rp20uBOHQGFSvgPL6HIaOAtcyJ7L06KFSPD2acDlyzs8cp/cE43QgSBW4uk1JbESfWmdbbVPFztLcnpGXW4sSAR4wYgnYb6A6rsIRjxK2pwXGSUGBIPDJS7XeQcUuAeM38idJqcJ8n8blSRTK1Vd3AUJrUXMMcmFNnRuVPGrq0jiZSEkkABYLpVScakJ0lMnUjVrGktRTGGUVI5jGbANWO8+aItt3k0AoE/7vFP6WpGeBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(83380400001)(36860700001)(2906002)(81166007)(356005)(82740400003)(41300700001)(8936002)(82310400005)(5660300002)(40480700001)(478600001)(186003)(1076003)(40460700003)(6666004)(8676002)(2616005)(336012)(6916009)(16526019)(4326008)(316002)(26005)(54906003)(70206006)(86362001)(70586007)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:46.8129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a7690-d4b7-465f-1b95-08daf32ba8ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

This reverts commit ef4e2703d6c81eb08e1cd29d14c819791e6898a6.

It caused corruption in some media players.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 -
 .../dc/dml/dcn32/display_mode_vba_32.c        | 37 +++++++++----------
 .../drm/amd/display/dc/dml/display_mode_lib.h |  1 -
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e7459fd50bf9..025139a22e84 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1564,7 +1564,6 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 			dm_prefetch_support_fclk_and_stutter;
 
-		context->bw_ctx.dml.validate_max_state = fast_validate;
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
 		/* Last attempt with Prefetch mode 2 (dm_prefetch_support_stutter == 3) */
@@ -1573,7 +1572,6 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				dm_prefetch_support_stutter;
 			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 		}
-		context->bw_ctx.dml.validate_max_state = false;
 
 		if (vlevel < context->bw_ctx.dml.soc.num_states) {
 			memset(split, 0, sizeof(split));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index bc22078751f8..4b8f5fa0f0ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1707,7 +1707,7 @@ static void mode_support_configuration(struct vba_vars_st *v,
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int i, j, start_state;
+	int i, j;
 	unsigned int k, m;
 	unsigned int MaximumMPCCombine;
 	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth;
@@ -1720,10 +1720,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 #endif
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
-	if (mode_lib->validate_max_state)
-		start_state = v->soc.num_states - 1;
-	else
-		start_state = 0;
+
 	/*Scale Ratio, taps Support Check*/
 
 	mode_lib->vba.ScaleRatioAndTapsSupport = true;
@@ -2012,7 +2009,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
 			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = 0; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
 			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
@@ -2289,7 +2286,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = 0; i < v->soc.num_states; ++i) {
 		mode_lib->vba.ExceededMultistreamSlots[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
@@ -2389,7 +2386,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = 0; i < v->soc.num_states; ++i) {
 		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k
@@ -2406,7 +2403,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = 0; i < v->soc.num_states; ++i) {
 		mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = true;
 		mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
@@ -2424,7 +2421,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = 0; i < v->soc.num_states; i++) {
 		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
@@ -2461,7 +2458,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/* Check DSC Unit and Slices Support */
 	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = 0; i < v->soc.num_states; ++i) {
 		mode_lib->vba.NotEnoughDSCUnits[i] = false;
 		mode_lib->vba.NotEnoughDSCSlices[i] = false;
 		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
@@ -2496,7 +2493,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*DSC Delay per state*/
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = 0; i < v->soc.num_states; ++i) {
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
 					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
@@ -2523,7 +2520,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
 	//
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
@@ -2658,7 +2655,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.SurfaceSizeInMALL,
 			&mode_lib->vba.ExceededMALLSize);
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = 0; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 				mode_lib->vba.swath_width_luma_ub_this_state[k] =
@@ -2885,7 +2882,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	//Calculate Return BW
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
@@ -2964,7 +2961,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			&mode_lib->vba.MinPrefetchMode,
 			&mode_lib->vba.MaxPrefetchMode);
 
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j)
 			mode_lib->vba.DCFCLKState[i][j] = mode_lib->vba.DCFCLKPerState[i];
 	}
@@ -3086,7 +3083,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.DCFCLKState);
 	} // UseMinimumRequiredDCFCLK == true
 
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			mode_lib->vba.ReturnBWPerState[i][j] = dml32_get_return_bw_mbps(&mode_lib->vba.soc, i,
 					mode_lib->vba.HostVMEnable, mode_lib->vba.DCFCLKState[i][j],
@@ -3095,7 +3092,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	//Re-ordering Buffer Support Check
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			if ((mode_lib->vba.ROBBufferSizeInKByte - mode_lib->vba.PixelChunkSizeInKByte) * 1024
 					/ mode_lib->vba.ReturnBWPerState[i][j]
@@ -3117,7 +3114,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				+ mode_lib->vba.ReadBandwidthChroma[k];
 	}
 
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j] =
 				dml_min3(mode_lib->vba.ReturnBusWidth * mode_lib->vba.DCFCLKState[i][j]
@@ -3141,7 +3138,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/* Prefetch Check */
 
-	for (i = start_state; i < (int) v->soc.num_states; ++i) {
+	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 
 			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index a9d49ef58fb5..3d643d50c3eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -91,7 +91,6 @@ struct display_mode_lib {
 	struct dal_logger *logger;
 	struct dml_funcs funcs;
 	struct _vcs_dpi_display_e2e_pipe_params_st dml_pipe_state[6];
-	bool validate_max_state;
 };
 
 void dml_init_instance(struct display_mode_lib *lib,
-- 
2.39.0

