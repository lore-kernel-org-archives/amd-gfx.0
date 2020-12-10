Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B751C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E2A22AAF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E2A22AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA2A6EAD2;
	Thu, 10 Dec 2020 18:48:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B1D6EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 18:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU101Ip7wpS7/NZ8Mm3laeuBHXH7LzjJ26gPnGp+ihapPw7GzSYA982b5sXAxZr38dAP1ClV/syBNbYAGIrf+2BMs7aJtTEIYu9P78vclrOGT0tw15Q/wNVZ54HX9TBBTB9TdrkAuuB76hLM8W9W0r5JRnZ04emMZk4NgyNxbQdJLN8yXhuBNIVLE3rT3MyFdIm8xFQTcrpqsfv2H98k2sKqdL/3FNJTiq/iKvuewAPvEW2OuOfNHZclTa98eTRVqOS2Xzs5CDAmo9Ikfn8qcd2TZNoAHddYaGZdP3/GsD6bugsguUDzHAqGVKv/0BYAGH3wlFRHe9lASQD6ZEjhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBgt/T7OXDjrQt2n4sJob/KHK7Oh+cKpcvMcradCIOw=;
 b=Ra7eHe/6EvBDFMi5jOz/PWrXzQCTtk8/+SHv8rgDRT+SWOc3IioDcIdDsLKmxo0lJKt7nOdMtCVF/hELTxVI2ydY9eebdAwZZaNNW3YTYhp1wcLWLR9y3wZV0zvDFxS7yBxSj9IJloDJxty9G9oOyngUSoGowk/CAD+O27bD6DUxbyVAix2zgFGZgAw99l/gLdb6waV35e1ql7fLhJlX0AuEu2PVEueoYQbMdq2UjnXdRuupyVRMSc6NmLH7Bm1M4V0BQWt4gt3sOTQb8Cni8HuMXyW2ayTSFV7C9TYkX0R5R5vllBzqyiS58+pVfjXwb0NXpx5cPA3EJUcpNb96hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBgt/T7OXDjrQt2n4sJob/KHK7Oh+cKpcvMcradCIOw=;
 b=aflyN2GaID8Qx90/kLy5yqoUsgZ2ZSKxX8Jx4kpbL2ydSPHICFlzjeWh82ZndwkMldpJKL1w0q/TeoRsO3dEkgmxxuPh/2uXLka+U9yzUz0cTwxzs8i6wW/19KEmDJ5hT3VDbHrYv2dC+12yCo00f148DeL29a6Y4gIzQF/afjw=
Received: from BN6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:404:b9::20)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 18:48:29 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b9:cafe::90) by BN6PR08CA0058.outlook.office365.com
 (2603:10b6:404:b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 18:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 18:48:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:28 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:28 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 12:48:27 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/display: Skip modeset for front porch change
Date: Thu, 10 Dec 2020 13:48:23 -0500
Message-ID: <20201210184823.285415-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210184823.285415-1-aurabindo.pillai@amd.com>
References: <20201210184823.285415-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1a5d38-b6d0-4f57-3045-08d89d3c2f24
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13859667BAB9D39CFF4AF1D88BCB0@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBMR7OuqaXAiAGt1I+SktdGZzrzixGDQ+RBpWuK+SyMNR7el9DpylAZmV1lOA5Cw+TTdan9aHUlo7QMr68fKS4VLCtlkUo9hbi1Px3/VzGXySYtCxP+9w4PStO/OoTVjl8T9NJcwOJQnJE5sWUtxVwPqIqe01sCwi643XMfRzlgkHWBxo5Aj18oHcdsoclwMBvza9tHnWKusDYS4wS3YtZIh+rJSP246vyTWUTIHSo7gUwUPoXwpCpp5u/X4HQc+cc93wzrk1yBSXyfUmdeUS2fISxcX1GhdjrsZpfiUTahq3nWBEivvK2yZdOMHkdssWpdYgEto/I34k1HceVxwmNQtoh1i6Nn5FrjBM2pd5I46lyVed3cqaoOxpCE5DOzx93J7+jBgKqQ3snyfLCk0tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(4326008)(508600001)(5660300002)(44832011)(54906003)(426003)(36756003)(70586007)(8676002)(30864003)(81166007)(186003)(6916009)(2906002)(7696005)(86362001)(6666004)(47076004)(82310400003)(336012)(8936002)(83380400001)(356005)(70206006)(2616005)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 18:48:28.6974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1a5d38-b6d0-4f57-3045-08d89d3c2f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Cc: stylon.wang@amd.com, shashank.sharma@amd.com, thong.thai@amd.com,
 aurabindo.pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Inorder to enable freesync video mode, driver adds extra
modes based on preferred modes for common freesync frame rates.
When commiting these mode changes, a full modeset is not needed.
If the change in only in the front porch timing value, skip full
modeset and continue using the same stream.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 163 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 2 files changed, 149 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d15453b400d2..9e6aba961edd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
 static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
 
+static bool
+is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
+				 struct drm_crtc_state *new_crtc_state);
 /*
  * dm_vblank_get_counter
  *
@@ -5226,6 +5229,24 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	return m_high;
 }
 
+static bool is_freesync_video_mode(struct drm_display_mode *mode,
+				   struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_display_mode *high_mode;
+
+	high_mode = get_highest_refresh_rate_mode(aconnector, false);
+	if (!high_mode || !mode)
+		return false;
+
+	if (high_mode->clock == 0 ||
+	    high_mode->hdisplay != mode->hdisplay ||
+	    high_mode->vdisplay != mode->vdisplay ||
+	    high_mode->clock != mode->clock)
+		return false;
+	else
+		return true;
+}
+
 static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
@@ -5239,16 +5260,21 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		dm_state ? &dm_state->base : NULL;
 	struct dc_stream_state *stream = NULL;
 	struct drm_display_mode mode = *drm_mode;
+	struct drm_display_mode saved_mode;
+	struct drm_display_mode *freesync_mode = NULL;
 	bool native_mode_found = false;
 	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
 	int mode_refresh;
 	int preferred_refresh = 0;
+	bool is_fs_vid_mode = 0;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
 #endif
 	uint32_t link_bandwidth_kbps;
-
 	struct dc_sink *sink = NULL;
+
+	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
+
 	if (aconnector == NULL) {
 		DRM_ERROR("aconnector is NULL!\n");
 		return stream;
@@ -5301,20 +5327,32 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
-		decide_crtc_timing_for_drm_display_mode(
+		is_fs_vid_mode = is_freesync_video_mode(&mode, aconnector);
+		if (is_fs_vid_mode) {
+			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
+			saved_mode = mode;
+			mode = *freesync_mode;
+		}
+
+		if (!is_fs_vid_mode)
+			decide_crtc_timing_for_drm_display_mode(
 				&mode, preferred_mode,
 				dm_state ? (dm_state->scaling != RMX_OFF) : false);
+
 		preferred_refresh = drm_mode_vrefresh(preferred_mode);
 	}
 
 	if (!dm_state)
 		drm_mode_set_crtcinfo(&mode, 0);
 
-	/*
+	if (dm_state && is_fs_vid_mode)
+		drm_mode_set_crtcinfo(&saved_mode, 0);
+
+       /*
 	* If scaling is enabled and refresh rate didn't change
 	* we copy the vic and polarities of the old timings
 	*/
-	if (!scale || mode_refresh != preferred_refresh)
+	if (!(scale && is_fs_vid_mode) || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(stream,
 			&mode, &aconnector->base, con_state, NULL, requested_bpc);
 	else
@@ -7851,13 +7889,29 @@ static void update_stream_irq_parameters(
 	if (new_crtc_state->vrr_supported &&
 	    config.min_refresh_in_uhz &&
 	    config.max_refresh_in_uhz) {
+		/*
+		 * if freesync compatible mode was set, config.state will be set
+		 * in atomic check
+		 */
+		if (config.state == VRR_STATE_ACTIVE_FIXED &&
+		    config.fixed_refresh_in_uhz && config.max_refresh_in_uhz &&
+		    config.min_refresh_in_uhz &&
+		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
+		     new_crtc_state->freesync_video_mode)) {
+			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
+			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
+			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
+			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
+			goto out;
+		}
+
 		config.state = new_crtc_state->base.vrr_enabled ?
 			VRR_STATE_ACTIVE_VARIABLE :
 			VRR_STATE_INACTIVE;
-	} else {
+	} else
 		config.state = VRR_STATE_UNSUPPORTED;
-	}
 
+out:
 	mod_freesync_build_vrr_params(dm->freesync_module,
 				      new_stream,
 				      &config, &vrr_params);
@@ -8175,7 +8229,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * as part of commit.
 		 */
 		if (amdgpu_dm_vrr_active(dm_old_crtc_state) !=
-		    amdgpu_dm_vrr_active(acrtc_state)) {
+		    amdgpu_dm_vrr_active(acrtc_state) ||
+		    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED ||
+		    acrtc_state->freesync_video_mode) {
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 			dc_stream_adjust_vmin_vmax(
 				dm->dc, acrtc_state->stream,
@@ -8866,6 +8922,7 @@ static void get_freesync_config_for_crtc(
 			to_amdgpu_dm_connector(new_con_state->base.connector);
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
 	int vrefresh = drm_mode_vrefresh(mode);
+	bool fs_vid_mode = false;
 
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
@@ -8873,17 +8930,26 @@ static void get_freesync_config_for_crtc(
 
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
-		config.state = new_crtc_state->base.vrr_enabled ?
-				VRR_STATE_ACTIVE_VARIABLE :
-				VRR_STATE_INACTIVE;
-		config.min_refresh_in_uhz =
-				aconnector->min_vfreq * 1000000;
-		config.max_refresh_in_uhz =
-				aconnector->max_vfreq * 1000000;
+		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED ||
+			new_crtc_state->freesync_video_mode;
+
+		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
+		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
 		config.vsif_supported = true;
 		config.btr = true;
-	}
 
+		if (fs_vid_mode) {
+			config.state = VRR_STATE_ACTIVE_FIXED;
+			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
+			goto out;
+		}
+		else if (new_crtc_state->base.vrr_enabled && !fs_vid_mode)
+			config.state = VRR_STATE_ACTIVE_VARIABLE;
+		else
+			config.state = VRR_STATE_INACTIVE;
+
+	}
+out:
 	new_crtc_state->freesync_config = config;
 }
 
@@ -8896,6 +8962,51 @@ static void reset_freesync_config_for_crtc(
 	       sizeof(new_crtc_state->vrr_infopacket));
 }
 
+static bool
+is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
+				 struct drm_crtc_state *new_crtc_state)
+{
+	struct drm_display_mode old_mode, new_mode;
+
+	if (!old_crtc_state || !new_crtc_state)
+		return false;
+
+	old_mode = old_crtc_state->mode;
+	new_mode = new_crtc_state->mode;
+
+	if (old_mode.clock       == new_mode.clock &&
+	    old_mode.hdisplay    == new_mode.hdisplay &&
+	    old_mode.vdisplay    == new_mode.vdisplay &&
+	    old_mode.htotal      == new_mode.htotal &&
+	    old_mode.vtotal      != new_mode.vtotal &&
+	    old_mode.hsync_start == new_mode.hsync_start &&
+	    old_mode.vsync_start != new_mode.vsync_start &&
+	    old_mode.hsync_end   == new_mode.hsync_end &&
+	    old_mode.vsync_end   != new_mode.vsync_end &&
+	    old_mode.hskew       == new_mode.hskew &&
+	    old_mode.vscan       == new_mode.vscan &&
+	    (old_mode.vsync_end - old_mode.vsync_start) ==
+	    (new_mode.vsync_end - new_mode.vsync_start))
+		return true;
+
+	return false;
+}
+
+static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
+	uint64_t num, den, res;
+	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
+
+	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+
+	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
+	den = (unsigned long long)new_crtc_state->mode.htotal *
+	      (unsigned long long)new_crtc_state->mode.vtotal;
+
+	res = div_u64(num, den);
+	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
+	dm_new_crtc_state->freesync_video_mode = true;
+}
+
 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 				struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
@@ -8986,6 +9097,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * TODO: Refactor this function to allow this check to work
 		 * in all conditions.
 		 */
+		if (dm_new_crtc_state->stream &&
+		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state) &&
+		    amdgpu_exp_freesync_vid_mode)
+			goto skip_modeset;
+
 		if (dm_new_crtc_state->stream &&
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
@@ -9017,6 +9133,23 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (!dm_old_crtc_state->stream)
 			goto skip_modeset;
 
+		if (dm_new_crtc_state->stream &&
+		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state) &&
+		    amdgpu_exp_freesync_vid_mode) {
+			new_crtc_state->mode_changed = false;
+			DRM_DEBUG_DRIVER(
+				"Mode change not required for front porch change, "
+				"setting mode_changed to %d",
+				new_crtc_state->mode_changed);
+
+			set_freesync_fixed_config(dm_new_crtc_state);
+
+			goto skip_modeset;
+		} else if (aconnector &&
+			   is_freesync_video_mode(&new_crtc_state->mode, aconnector) &&
+			   amdgpu_exp_freesync_vid_mode)
+			set_freesync_fixed_config(dm_new_crtc_state);
+
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret)
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 251af783f6b1..28f2d8c9b260 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -453,6 +453,7 @@ struct dm_crtc_state {
 
 	bool freesync_timing_changed;
 	bool freesync_vrr_info_changed;
+	bool freesync_video_mode;
 
 	bool dsc_force_changed;
 	bool vrr_supported;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
