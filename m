Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6363FC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1BA10E6DE;
	Fri,  3 Mar 2023 15:50:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622C410E6DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic+ae6RDtUot081qpbDnD+B4ey9qQkiTRookEQSlKGXaq+w0wspFmWpfr/6lJD9trMNEW2uXj7jnVQHef6CYnTfqOd1BLXU21gLEdzBIRmn1JbGoEHElaXf/wS1rNnISSwP46PovtOtfYulY6msE5xrcjoi6eDDZCOkIEImudhZxavjuqjUdnCadQ4Uj7sSwfsAx7cEfe/mokJ4YuBJYygIt/o+mkI3swqO5FF34bLraz2SZs2ir0jmBrpu6eLjogwLPangB5j+u9/xaefKWcawVvzumE7ZfhlCeMJ3xHfoqT+3frfDulCZyV1Ak2tV20vBckjMF+ZEYhreHyyxV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrH1nLpxs6VA2HZoy1vxAEf2i0FKLacESWnVUeozJpo=;
 b=GBjXGN4hY4UczH/ZywNjKB0AZUsmrTTAClAPtfFJcq0W9H6QvO0xRm8rarZvzUnyq4vurgxwx0wmj9/XHuYveHK7W+CKe/kdfmiTELKvTAVRwlET8i0Y5hMxkU1fiN1t0Fr1Io/1LMsrbUd1Thtp0EsF98ohpq5UHAHdMF5KIjTnGHVcuNyimodtehKD11mT9QqFt7kGGAdZePV7LYq5xu0krazXQTKyqMKHK3t64qnrf116oJBO6FXZpLWDIHE6eS2GeDKrTBzVsLE2l+Wit59H5GCM1kmodxF7B3q4SxO+dJ6GM7V5zbBNiTyuAShQaHRI52KhQ9CBm5ZPbITWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrH1nLpxs6VA2HZoy1vxAEf2i0FKLacESWnVUeozJpo=;
 b=y2NzqIrBn8ISkuzGm94tBINBq9HMRZSWuHSBjLT3ZX9XYYNaQ8rZkEMD/V0Kv8bynSyvq+ri2qLVZbcZhJDp4Yq+ZUrKYkt4HU6V9MJDYmU1Ao0HYMVBwTaEYFmzjMyyaN8kj0GJhLYR+Mu/woutT7EAvADioLyweM3HxHkeJ24=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Fri, 3 Mar
 2023 15:50:10 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::5e) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:50:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:49:51 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/33] drm/amd/display: Drop unnecessary DCN guards
Date: Fri, 3 Mar 2023 10:40:09 -0500
Message-ID: <20230303154022.2667-21-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|CH2PR12MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ced2d3-4b52-4480-d102-08db1bfef852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJOj6B3y+Tr556T5NDdPojLYSngn/1YUYwVmYbq5SG9DBgWQiG8qhPAJ/BC0QpHN+US0cCkgHtpWs1sZ49eHQeOxpx8BC7VRUYBZo46MBG1uOsq0pr0pBaiBjFl4MEvgUGrHMW41Y6hhLPjIEf9kMGIfNCp2MgN5sOcr/zHLDUElOhKy2bDpN137C2pqiTpFRt8kMFF0WvbTjhVVcFQUntALjgEtRpCRuxxGhaeoswb2PRzi8el6SfCDOfaENKiD8kRozelLZjO7x0Itj8XpPT90DTwY6I0KqwEzup8XliPnQjxauzLR+wUzQrvMxstraR+5mxUd2te643add2lhhQGNWNkvpwhsE1Gx9fqAEujlLZx9ptAOphc1N+YbIfpuRHPNdY4KHtGrw6whSjV/kQG+iiicBjEJzu14l9RWNTc4LaU4gDAfVOrlD2Hk0RwBnuV+a1ApNh2l2GxeDmYQyLrLW9+KhjeQ94PRIFkUENKoS4SoPpwJ76fBRouXrgN86yrJUFcFu5FsrjO9QvQrP1147A3CNBaO8KoZXkVeh2Nh3LqZLtzuay3PxHeQj7vC9Yk4MXQIa/bNBRuctKa4Tcyegfs/sp4hw67NNDYIlBOB2DyhGu1f3Yud0xrA/ZBnb+wtndMogIMunNZ2B8f012V4hVb3MG098n9ZHKR8U48j0fUqQMGq3axAPiUt/7y+APKaAs7k3ex4yDxdA3ZIjGkKUc6coyDQDItT+zeinRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(54906003)(86362001)(36756003)(82310400005)(40460700003)(16526019)(40480700001)(186003)(44832011)(1076003)(36860700001)(41300700001)(4326008)(8676002)(6916009)(70206006)(70586007)(336012)(47076005)(478600001)(2906002)(26005)(316002)(6666004)(356005)(2616005)(426003)(30864003)(8936002)(5660300002)(83380400001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:50:10.4096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ced2d3-4b52-4480-d102-08db1bfef852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why]
DM is littered with DCN guards leading to frequent
breakages on non-DCN builds when new code is added.

[How]
Remove all guards that are not needed.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 -------------------
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  8 -------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 14 ------------
 3 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c7f32e46945..b560a6711682 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5736,7 +5736,6 @@ static bool is_freesync_video_mode(const struct drm_display_mode *mode,
 		return true;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 			    struct dc_sink *sink, struct dc_stream_state *stream,
 			    struct dsc_dec_dpcd_caps *dsc_caps)
@@ -5891,7 +5890,6 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
 		stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
 }
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
@@ -5914,9 +5912,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int mode_refresh;
 	int preferred_refresh = 0;
 	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
-#endif
 
 	struct dc_sink *sink = NULL;
 
@@ -6015,12 +6011,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		stream->timing = *aconnector->timing_requested;
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* SST DSC determination policy */
 	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
 	if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported)
 		apply_dsc_policy_for_stream(aconnector, sink, stream, &dsc_caps);
-#endif
 
 	update_stream_scaling_settings(&mode, dm_state, stream);
 
@@ -6749,7 +6743,6 @@ const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
 	.atomic_check = dm_encoder_helper_atomic_check
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 					    struct dc_state *dc_state,
 					    struct dsc_mst_fairness_vars *vars)
@@ -6823,7 +6816,6 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	}
 	return 0;
 }
-#endif
 
 static int to_drm_connector_type(enum signal_type st)
 {
@@ -9760,7 +9752,6 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	return 0;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
@@ -9786,7 +9777,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 
 	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->mst_mgr);
 }
-#endif
 
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
@@ -9823,10 +9813,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct drm_dp_mst_topology_mgr *mgr;
 	struct drm_dp_mst_topology_state *mst_state;
-#endif
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	enum dc_status status;
@@ -9834,9 +9822,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	bool lock_and_validation_needed = false;
 	bool is_top_most_overlay = true;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_mst_fairness_vars vars[MAX_PIPES];
-#endif
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
@@ -9867,7 +9853,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			new_crtc_state->connectors_changed = true;
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dc_resource_is_dsc_encoding_supported(dc)) {
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
@@ -9879,7 +9864,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			}
 		}
 	}
-#endif
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -10017,13 +10001,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dc_resource_is_dsc_encoding_supported(dc)) {
 		ret = pre_validate_dsc(state, &dm_state, vars);
 		if (ret != 0)
 			goto fail;
 	}
-#endif
 
 	/* Run this here since we want to validate the streams we created */
 	ret = drm_atomic_helper_check_planes(dev, state);
@@ -10089,7 +10071,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		lock_and_validation_needed = true;
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* set the slot info for each mst_state based on the link encoding format */
 	for_each_new_mst_mgr_in_state(state, mgr, mst_state, i) {
 		struct amdgpu_dm_connector *aconnector;
@@ -10109,7 +10090,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 		drm_connector_list_iter_end(&iter);
 	}
-#endif
 
 	/**
 	 * Streams and planes are reset when there are changes that affect
@@ -10137,7 +10117,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 		if (ret) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
@@ -10149,7 +10128,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			DRM_DEBUG_DRIVER("dm_update_mst_vcpi_slots_for_dsc() failed\n");
 			goto fail;
 		}
-#endif
 
 		/*
 		 * Perform validation of MST topology in the state:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1583157da355..1be04c613deb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -525,7 +525,6 @@ bool dm_helpers_submit_i2c(
 	return result;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
@@ -693,7 +692,6 @@ static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 
 	return ret;
 }
-#endif
 
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
@@ -719,13 +717,11 @@ bool dm_helpers_dp_write_dsc_enable(
 		if (!aconnector->dsc_aux)
 			return false;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		// apply w/a to synaptics
 		if (needs_dsc_aux_workaround(aconnector->dc_link) &&
 		    (aconnector->mst_downstream_port_present.byte & 0x7) != 0x3)
 			return write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 				aconnector->dsc_aux, stream, enable_dsc);
-#endif
 
 		port = aconnector->mst_output_port;
 
@@ -763,17 +759,13 @@ bool dm_helpers_dp_write_dsc_enable(
 	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
-#endif
 			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 			DC_LOG_DC("Send DSC %s to SST RX\n", enable_dsc ? "enable" : "disable");
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
 			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 			DC_LOG_DC("Send DSC %s to DP-HDMI PCON\n", enable_dsc ? "enable" : "disable");
 		}
-#endif
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 248f25943748..2739bef9b90c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -198,7 +198,6 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 	.early_unregister = amdgpu_dm_mst_connector_early_unregister,
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool needs_dsc_aux_workaround(struct dc_link *link)
 {
 	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
@@ -268,7 +267,6 @@ static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnect
 
 	return true;
 }
-#endif
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
@@ -375,7 +373,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->edid);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (!validate_dsc_caps_on_connector(aconnector))
 				memset(&aconnector->dc_sink->dsc_caps,
 				       0, sizeof(aconnector->dc_sink->dsc_caps));
@@ -383,7 +380,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			if (!retrieve_downstream_port_device(aconnector))
 				memset(&aconnector->mst_downstream_port_present,
 					0, sizeof(aconnector->mst_downstream_port_present));
-#endif
 		}
 	}
 
@@ -642,8 +638,6 @@ int dm_mst_get_pbn_divider(struct dc_link *link)
 			dc_link_get_link_cap(link)) / (8 * 1000 * 54);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 struct dsc_mst_fairness_params {
 	struct dc_crtc_timing *timing;
 	struct dc_sink *sink;
@@ -1427,7 +1421,6 @@ static unsigned int kbps_from_pbn(unsigned int pbn)
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 					  struct dc_dsc_bw_range *bw_range)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_dsc_policy dsc_policy = {0};
 
 	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy);
@@ -1439,17 +1432,13 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 				       &stream->timing, bw_range);
 
 	return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
-#endif
-	return false;
 }
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream)
 {
 	int bpp, pbn, branch_max_throughput_mps = 0;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_link_settings cur_link_settings;
 	unsigned int end_to_end_bw_in_kbps = 0;
 	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
@@ -1491,16 +1480,13 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 	} else {
-#endif
 		/* check if mode could be supported within full_pbn */
 		bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
 		pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
 
 		if (pbn > aconnector->mst_output_port->full_pbn)
 			return DC_FAIL_BANDWIDTH_VALIDATE;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	}
-#endif
 
 	/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
 	switch (stream->timing.pixel_encoding) {
-- 
2.34.1

