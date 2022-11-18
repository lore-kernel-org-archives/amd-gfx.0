Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40466C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F8110E78D;
	Fri, 18 Nov 2022 17:00:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3D510E78C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqfFC+4hmgcMm3lOsSRtZC7kJ9kcC0jJU/lJbKLsVHVcokuwXEj18j8hJeWXVSsTPmTj4EiFccCyNuoTMwPyFWP2Sa8BoWB+wwERAYtJ+SP59+LZi2SU5wpahYTfXRfxrEQ/PS/ubNbY+Kyo01e6WhkikTRqDm7+mJbZKKfw+BegNDnHp9VDIu5djuXhfJmT61pqvyT0XpueUG/PfKl3JIAiJOho71DJ8Q0wSa64P55HM1YU1XA9bEh6bNH85E6eS0klT7GINX4OBj+dNavrf7tTn1LYsuJ7X72eOvDV2UkPTcTsvimulQrsyipN1r0ms4jzI4EeMeia/EGvHSXPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/Whh7a1wcxw9o2cZCuVhr42SuUPDimLgOiJ6PACwAQ=;
 b=Mv5yjvKkxHye18NGUSDZREMyafPv+lqwohkhDhajHUpP3ZFvIlEv3hsJr1J447Zw6ps7oFLkuzDdSdpW6UYZuXVojvNfboyr7HtMyOg5pLhRgR+asayRrsd5iamqf1ZBF/KxkGg+5GovNsk8XycTQDcfeCLr0LYV54jNvvfQI9twq4CjEDqHzuvVHOoAv/+9rW/RIHvczzjdRvdyrs6eVs/uaKJ19S4Jgh/Px0y4Mh7jBv4bV5NrEV7hKgQn6Ea/offLHpLyJtbEM9qHzSG1mQsHJov20V6gCDCs4YorGECe4pmwmWSx/QBjDwrRGr7N0chmIGThBn8ZeHECNUllFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Whh7a1wcxw9o2cZCuVhr42SuUPDimLgOiJ6PACwAQ=;
 b=BseB99I3EnD/KRLxOvxJXBxkjQv+oIeQ3G3BdLNIZYAI6h76ZRuljAy4uV7aciEr60FUWYoDfg8I33Gj1OkObh3vMkUV9yMXuqVq/ptIgY2R4TglJSr11lL1jEChES77kl/5aD9TWThOXHNOU6CmUTxQsfLainmK8k3L5ry8JRQ=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 16:59:57 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::5a) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:56 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:52
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: Add check for DET fetch latency hiding
 for dcn32
Date: Fri, 18 Nov 2022 20:59:22 +0800
Message-ID: <20221118125935.4013669-10-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ae9064-93d7-4c31-d8d4-08dac9865263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/rld3J4qKn54hLVjoJjizJuvLrS+6DB1znEPXMaPS8uoTYC73wRxZs1dt/6eNTimm7OBo0CzmZ6KKcQnHbx6MZ1v5MiBAaoIReI3iBA0Xsk63qzSouWF339KuUOX6G+kYthZUITy9U49DVl90W9YNsE0UK+N4uIfUUbN7FFPX98A48gkd2IHU+ctt9ml67po8vqmGl3Z2qCAIxqmXN4L8hXd088SwXIzm+r57C65AKN1lS2cXPlcblagjm1BMqKFHXbbjJm5Y2yGC56N6ZfwIlXH6EI5QVMIfivpUjkKBx7MWu4vEM5rauDnxTQac//Bl9BuRBPFoM4x6SKbwE1cMr/CGIHASHHeNi9yLk0OFntGUEVSvcz6+1qpeNAwGNzwTISCDWmlRjFce8ngd0Tdrq68kDy4TvLkoRAV3NLxUExbpYWltvM3Wno2lZw3YeUKOBQZsUZglbqQlhP+VWExxyISlGbsKU1XVZnWcSFkTXxevif+817P3zVshiyvQlFbcBX6OzJwU1XqbEEL8CokT6BRu7fY9H8AjiEfQIAJBdG9LHTQVzoglupJ1rTcaM2juVPzUfhXD5clhXanB2mlF7PsYJ2q0cNOAKEKNRGsf2UHLfEUKbGkXEg5XvKGS2lE0FCPirntrBeWaw/W9RxyPqCVJGTN2Xt0wxJ2vrK69GepOPdHcDU9iPPtDJXEoCvG8K9K7fxeTF6xT3cjzwXpBLQrLHgGfyyVI2SrY3onfjfhbvn9eBWbgSAL+nBNvNHnxPX0s6bM/f9dqrEtwskHcOJYxDd+vTHU+dSJjTjPUo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(54906003)(6666004)(7696005)(6916009)(1076003)(4326008)(8936002)(8676002)(336012)(5660300002)(26005)(41300700001)(70206006)(186003)(2616005)(36756003)(40460700003)(81166007)(82310400005)(426003)(47076005)(2906002)(83380400001)(316002)(356005)(86362001)(82740400003)(40480700001)(70586007)(36860700001)(43062005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:57.0797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ae9064-93d7-4c31-d8d4-08dac9865263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Some configurations are constructed with very marginal DET buffers relative to
the worst possible time required to fetch a swath.

[HOW?]
Add a check to see that the DET buffer allocated for each pipe can hide the
latency for all pipes to fetch at least one swath.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 39 +++++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 69 +++++++++++++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.h   | 18 +++++
 .../drm/amd/display/dc/dml/display_mode_vba.h |  2 +
 4 files changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e5c8f6a71b5b..cb801eace8f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -670,6 +670,25 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		v->cursor_bw[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0] * mode_lib->vba.CursorBPP[k][0] / 8 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
 	}
 
+	v->NotEnoughDETSwathFillLatencyHiding = dml32_CalculateDETSwathFillLatencyHiding(
+						mode_lib->vba.NumberOfActiveSurfaces,
+						mode_lib->vba.ReturnBW,
+						v->UrgentLatency,
+						mode_lib->vba.SwathHeightY,
+						mode_lib->vba.SwathHeightC,
+						v->swath_width_luma_ub,
+						v->swath_width_chroma_ub,
+						v->BytePerPixelDETY,
+						v->BytePerPixelDETC,
+						mode_lib->vba.DETBufferSizeY,
+						mode_lib->vba.DETBufferSizeC,
+						mode_lib->vba.DPPPerPlane,
+						mode_lib->vba.HTotal,
+						mode_lib->vba.PixelClock,
+						mode_lib->vba.VRatio,
+						mode_lib->vba.VRatioChroma,
+						mode_lib->vba.UsesMALLForPStateChange);
+
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 		v->MaxVStartupLines[k] = ((mode_lib->vba.Interlace[k] &&
 				!mode_lib->vba.ProgressiveToInterlaceUnitInOPP) ?
@@ -1664,6 +1683,7 @@ static void mode_support_configuration(struct vba_vars_st *v,
 				&& mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.NonsupportedDSCInputBPC == false
+				&& mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] == false
 				&& !mode_lib->vba.ExceededMALLSize
 				&& ((mode_lib->vba.HostVMEnable == false
 				&& !mode_lib->vba.ImmediateFlipRequiredFinal)
@@ -3158,6 +3178,25 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.UrgentBurstFactorChroma,
 					mode_lib->vba.UrgentBurstFactorCursor);
 
+			mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] = dml32_CalculateDETSwathFillLatencyHiding(
+					mode_lib->vba.NumberOfActiveSurfaces,
+					mode_lib->vba.ReturnBWPerState[i][j],
+					mode_lib->vba.UrgLatency[i],
+					mode_lib->vba.SwathHeightYThisState,
+					mode_lib->vba.SwathHeightCThisState,
+					mode_lib->vba.swath_width_luma_ub_this_state,
+					mode_lib->vba.swath_width_chroma_ub_this_state,
+					mode_lib->vba.BytePerPixelInDETY,
+					mode_lib->vba.BytePerPixelInDETC,
+					mode_lib->vba.DETBufferSizeYThisState,
+					mode_lib->vba.DETBufferSizeCThisState,
+					mode_lib->vba.NoOfDPPThisState,
+					mode_lib->vba.HTotal,
+					mode_lib->vba.PixelClock,
+					mode_lib->vba.VRatio,
+					mode_lib->vba.VRatioChroma,
+					mode_lib->vba.UsesMALLForPStateChange);
+
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
 					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.FabricClockPerState[i],
 					mode_lib->vba.DRAMSpeedPerState[i]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index debe46b24a3e..5af601cff1a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6228,3 +6228,72 @@ void dml32_CalculateImmediateFlipBandwithSupport(unsigned int NumberOfActiveSurf
 	*ImmediateFlipBandwidthSupport = (*TotalBandwidth <= ReturnBW);
 	*FractionOfUrgentBandwidth = *TotalBandwidth / ReturnBW;
 }
+
+bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurfaces,
+		double ReturnBW,
+		double UrgentLatency,
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
+		unsigned int SwathWidthY[],
+		unsigned int SwathWidthC[],
+		double  BytePerPixelInDETY[],
+		double  BytePerPixelInDETC[],
+		unsigned int    DETBufferSizeY[],
+		unsigned int    DETBufferSizeC[],
+		unsigned int	NumOfDPP[],
+		unsigned int	HTotal[],
+		double	PixelClock[],
+		double	VRatioY[],
+		double	VRatioC[],
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[DC__NUM_DPP__MAX])
+{
+	int k;
+	double SwathSizeAllSurfaces = 0;
+	double SwathSizeAllSurfacesInFetchTimeUs;
+	double DETSwathLatencyHidingUs;
+	double DETSwathLatencyHidingYUs;
+	double DETSwathLatencyHidingCUs;
+	double SwathSizePerSurfaceY[DC__NUM_DPP__MAX];
+	double SwathSizePerSurfaceC[DC__NUM_DPP__MAX];
+	bool NotEnoughDETSwathFillLatencyHiding = false;
+
+	/* calculate sum of single swath size for all pipes in bytes*/
+	for (k = 0; k < NumberOfActiveSurfaces; k++) {
+		SwathSizePerSurfaceY[k] += SwathHeightY[k] * SwathWidthY[k] * BytePerPixelInDETY[k] * NumOfDPP[k];
+
+		if (SwathHeightC[k] != 0)
+			SwathSizePerSurfaceC[k] += SwathHeightC[k] * SwathWidthC[k] * BytePerPixelInDETC[k] * NumOfDPP[k];
+		else
+			SwathSizePerSurfaceC[k] = 0;
+
+		SwathSizeAllSurfaces += SwathSizePerSurfaceY[k] + SwathSizePerSurfaceC[k];
+	}
+
+	SwathSizeAllSurfacesInFetchTimeUs = SwathSizeAllSurfaces / ReturnBW + UrgentLatency;
+
+	/* ensure all DET - 1 swath can hide a fetch for all surfaces */
+	for (k = 0; k < NumberOfActiveSurfaces; k++) {
+		double LineTime = HTotal[k] / PixelClock[k];
+
+		/* only care if surface is not phantom */
+		if (UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe) {
+			DETSwathLatencyHidingYUs = (dml_floor(DETBufferSizeY[k] / BytePerPixelInDETY[k] / SwathWidthY[k], 1.0) - SwathHeightY[k]) / VRatioY[k] * LineTime;
+
+			if (SwathHeightC[k] != 0) {
+				DETSwathLatencyHidingCUs = (dml_floor(DETBufferSizeC[k] / BytePerPixelInDETC[k] / SwathWidthC[k], 1.0) - SwathHeightC[k]) / VRatioC[k] * LineTime;
+
+				DETSwathLatencyHidingUs = dml_min(DETSwathLatencyHidingYUs, DETSwathLatencyHidingCUs);
+			} else {
+				DETSwathLatencyHidingUs = DETSwathLatencyHidingYUs;
+			}
+
+			/* DET must be able to hide time to fetch 1 swath for each surface */
+			if (DETSwathLatencyHidingUs < SwathSizeAllSurfacesInFetchTimeUs) {
+				NotEnoughDETSwathFillLatencyHiding = true;
+				break;
+			}
+		}
+	}
+
+	return NotEnoughDETSwathFillLatencyHiding;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 3989c2a28fae..779c6805f599 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -1141,4 +1141,22 @@ void dml32_CalculateImmediateFlipBandwithSupport(unsigned int NumberOfActiveSurf
 		double  *FractionOfUrgentBandwidth,
 		bool *ImmediateFlipBandwidthSupport);
 
+bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurfaces,
+		double ReturnBW,
+		double UrgentLatency,
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
+		unsigned int SwathWidthY[],
+		unsigned int SwathWidthC[],
+		double  BytePerPixelInDETY[],
+		double  BytePerPixelInDETC[],
+		unsigned int    DETBufferSizeY[],
+		unsigned int    DETBufferSizeC[],
+		unsigned int	NumOfDPP[],
+		unsigned int	HTotal[],
+		double	PixelClock[],
+		double	VRatioY[],
+		double	VRatioC[],
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[DC__NUM_DPP__MAX]);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index d46aa4817e70..d8a6b8e22504 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1050,6 +1050,7 @@ struct vba_vars_st {
 	double MinFullDETBufferingTime;
 	double AverageReadBandwidthGBytePerSecond;
 	bool   FirstMainPlane;
+	bool NotEnoughDETSwathFillLatencyHiding;
 
 	unsigned int ViewportWidthChroma[DC__NUM_DPP__MAX];
 	unsigned int ViewportHeightChroma[DC__NUM_DPP__MAX];
@@ -1233,6 +1234,7 @@ struct vba_vars_st {
 	unsigned int BlockWidthC[DC__NUM_DPP__MAX];
 	unsigned int SubViewportLinesNeededInMALL[DC__NUM_DPP__MAX];
 	bool VActiveBandwithSupport[DC__VOLTAGE_STATES][2];
+	bool NotEnoughDETSwathFillLatencyHidingPerState[DC__VOLTAGE_STATES][2];
 	struct dummy_vars dummy_vars;
 };
 
-- 
2.25.1

