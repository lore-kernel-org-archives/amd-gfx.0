Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB3C07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0A210E879;
	Fri,  1 Dec 2023 13:28:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569CE10E873
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcHRPtliBDy6jBgU/vWAlD7ByvEd2WDLV4Uv2D4ciG0YjxxVBLvdOsDh5cJeL8hKsA48S909hCEN9zi3ST+aL8tjLLVyhtbF6Ri7GV+SrzgFX17Z2tRXk60Gqc75+fMrGfiO9iGHWrHHen2cVXFc+2a/VBG/ytl58OSL/H7hDAIm/bKeCDEF0bCglPWyL4MB2ZSSwysTDRnVGv+I3NszEftuBk376hEScXJ66+OCdUQBPshn0WBzafYjtcjEt8StvBdFu3+TWpDo3zRWI36A/Ao0OK1PDmypcEdbWWDPK5cE/iNPkL2FouOpsK9ctmYPclU6S2YrJaPZFA8dpVLeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGDO8l31FUur2Nb8P9bTqM1mWXvxF7zzJSIxse5vZ+U=;
 b=KWxVo16d+kKtcC55pujAgBjszkU8EayNT2GnNEmvYegWBic81PpIKl9N9WajSbKabFA7qCrq3Xf+way7qPgXIU/xdUygPER/PnOJCj5c5+hWWUzR1xk4Fv0h+9gYCnYoGcX/j58NQaWqGF18F/orDAv+1C5QHv30YmYYs+sT94yidOHqLiGrGy9npGNyUGaShHTtDU2wtLaVYux4YuXCVbst7CTP0aqN8SuvvvxmMJUuSsekz6SltQg71Yb/U5e9kcsZKZmiKI2LLByGuS6bShZfohDXVe2e6CfLh8HLWOV98OHu/xI3esUQTPdqZYeYJg9tWVGQth8mZ2ruqbp4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGDO8l31FUur2Nb8P9bTqM1mWXvxF7zzJSIxse5vZ+U=;
 b=OpXQI/g34l3u4H8dHdZHNnv6s9p0pPg1wSr1i6+VhNnsu5T9AUS8MmXqp7dz9yGjG3LDNnFGY1t22Ofc0AyrGaMaQotxSmHNMn06ni/cuVwLnyrvCg2RxWB6SGNInoECa6OyqL+Fssgoun1sQXismj9sV9TaSUoSg/CIXiormFI=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 13:27:56 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::8e) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:27:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:27:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/47] drm/amd/display: Optimize fast validation cases
Date: Fri, 1 Dec 2023 06:24:57 -0700
Message-ID: <20231201132731.2354141-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba75d3d-fcdd-4c5e-aeab-08dbf2715479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYPX0TmZN6wkXOJolHb73HLqBm8KGotboOfBHGA+u/Cpmx4cBgz6AoahJ7vvdMLnV7o6lftv1R+eIdLIR/YWxBae6TihlfQKGNoJ4yjDMswDi70yZpczICMVnwhxiE4f/C8s1nhjPg2VYL3SobhO5J0qoUOJn2QNVGje03oeF+0OZ6V/uJyh8gCqEPMSF7tFrnnVnsOmvt7RtM2kg2qzIiMqgykMUf85h7x8f247ndrkGbA4hRSaFrThAwv2h895J6l9Wy9SzVC9RzhsWWcaL/fy3v3YJGsPRVDfuPhwFSAFic95ZnGmkJy/ApN98mAj989SPaJ34oTEjOct9EnwH+uNhoa9Icx+jm7ljl6JQBpcdAA+HZX1HRIdhU+W+JVazaaAtPp2e0peT1YQLC7tgZ4DMbxqhx0VYk6c0liBIbvDSdTjd8og5a3XfVguuMwVb09Z59/HF6Bpx48LP1uYAdZfZVNy7Mmg37DfJBWpj9X/3F4cJiyPbAjhlhwNp/Hzu6W3ZCAtwTEavYweiDp5+aDPhCh/r5HVWFwr7b5EzaXZTnS95Lc9dw+I+/mcfwrlw4fU6Jj1ERSJR8S4kx/tWrsDUYvK9qwvp+7hpV05SoupBwXRuTdLyOKINUSPp0pNjfOWZ211lZiCCbnxahjx2A94T0Amwknko7AwkpDH4aomnLBz4ak8wdmHdMD85IzOleTJ7JRz3Ws6R3LoiDmHw4pj1xbPkKXBRP8o012aSVyBkqUWAoBG/MqIf9R33T4ONOsbuLEP7HOfTPRZEoi0e6yGOsEWt6Oj0WoOkCrQJXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(26005)(16526019)(2616005)(478600001)(356005)(336012)(1076003)(426003)(36860700001)(41300700001)(47076005)(70206006)(8676002)(8936002)(70586007)(83380400001)(4326008)(54906003)(6916009)(2906002)(316002)(81166007)(82740400003)(5660300002)(36756003)(86362001)(40480700001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:27:56.4762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba75d3d-fcdd-4c5e-aeab-08dbf2715479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Optimize fast validation cases to only validate the highest voltage
level. This works because during fast validation we only care if the
mode can be supported or not (at any vlevel).

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../dc/dml/dcn30/display_mode_vba_30.c        | 29 +++++++++++--------
 .../dc/resource/dcn30/dcn30_resource.c        |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 3686f1e7de3a..63c48c29ba49 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3542,7 +3542,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 {
 	struct vba_vars_st *v = &mode_lib->vba;
 	int MinPrefetchMode, MaxPrefetchMode;
-	int i;
+	int i, start_state;
 	unsigned int j, k, m;
 	bool   EnoughWritebackUnits = true;
 	bool   WritebackModeSupport = true;
@@ -3553,6 +3553,11 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
+	if (mode_lib->validate_max_state)
+		start_state = v->soc.num_states - 1;
+	else
+		start_state = 0;
+
 	CalculateMinAndMaxPrefetchMode(
 		mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank,
 		&MinPrefetchMode, &MaxPrefetchMode);
@@ -3851,7 +3856,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			v->SingleDPPViewportSizeSupportPerPlane,
 			&v->ViewportSizeSupport[0][0]);
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			v->MaxDispclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDispclk[i], v->DISPCLKDPPCLKVCOSpeed);
 			v->MaxDppclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDppclk[i], v->DISPCLKDPPCLKVCOSpeed);
@@ -4007,7 +4012,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*Total Available Pipes Support Check*/
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			if (v->TotalNumberOfActiveDPP[i][j] <= v->MaxNumDPP) {
 				v->TotalAvailablePipesSupport[i][j] = true;
@@ -4046,7 +4051,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 			v->RequiresDSC[i][k] = false;
 			v->RequiresFEC[i][k] = false;
@@ -4174,7 +4179,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			}
 		}
 	}
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		v->DIOSupport[i] = true;
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 			if (!v->skip_dio_check[k] && v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)
@@ -4185,7 +4190,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < v->soc.num_states; ++i) {
 		v->ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 			if (v->BlendingAndTiming[k] == k && v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
@@ -4197,7 +4202,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/* Skip dscclk validation: as long as dispclk is supported, dscclk is also implicitly supported */
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		v->NotEnoughDSCUnits[i] = false;
 		v->TotalDSCUnitsRequired = 0.0;
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
@@ -4217,7 +4222,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	/*DSC Delay per state*/
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 			if (v->OutputBppPerState[i][k] == BPP_INVALID) {
 				v->BPP = 0.0;
@@ -4333,7 +4338,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		v->cursor_bw[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0 / (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
 	}
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
@@ -5075,7 +5080,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*PTE Buffer Size Check*/
 
-	for (i = 0; i < v->soc.num_states; i++) {
+	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			v->PTEBufferSizeNotExceeded[i][j] = true;
 			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
@@ -5136,7 +5141,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	/*Mode Support, Voltage State and SOC Configuration*/
 
-	for (i = v->soc.num_states - 1; i >= 0; i--) {
+	for (i = v->soc.num_states - 1; i >= start_state; i--) {
 		for (j = 0; j < 2; j++) {
 			if (v->ScaleRatioAndTapsSupport == 1 && v->SourceFormatPixelAndScanSupport == 1 && v->ViewportSizeSupport[i][j] == 1
 					&& v->DIOSupport[i] == 1 && v->ODMCombine4To1SupportCheckOK[i] == 1
@@ -5158,7 +5163,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	{
 		unsigned int MaximumMPCCombine = 0;
-		for (i = v->soc.num_states; i >= 0; i--) {
+		for (i = v->soc.num_states; i >= start_state; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
 				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 2b6dcb489b90..37a64186f324 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1682,6 +1682,7 @@ noinline bool dcn30_internal_validate_bw(
 		 * We don't actually support prefetch mode 2, so require that we
 		 * at least support prefetch mode 1.
 		 */
+		context->bw_ctx.dml.validate_max_state = fast_validate;
 		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
 			dm_allow_self_refresh;
 
@@ -1691,6 +1692,7 @@ noinline bool dcn30_internal_validate_bw(
 			memset(merge, 0, sizeof(merge));
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 		}
+		context->bw_ctx.dml.validate_max_state = false;
 	}
 
 	dml_log_mode_support_params(&context->bw_ctx.dml);
-- 
2.42.0

