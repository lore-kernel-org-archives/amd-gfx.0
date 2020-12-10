Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB58C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E8D239D1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E8D239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A546E2E6;
	Thu, 10 Dec 2020 02:45:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022506E2DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXgTf8fT+y6pmNPLRDz/nSCIvwsq6lOHlhkzs+LBLialxreQx/Z5+LfEJcBPD7hn8VNmR+HlukjinVQf97+P+pBkWsw7nnM31b5XS0CGMfmN8SBDFbey4U8J6PtEZgqnGhSKznVl0E8Rc1wFrXGCwDE8S0HHUP6AKKTtUP1Hc31Rh4lyIi7mtjupp7Ke7gZ1OZseOJ6axdl+o8sSzMzdP/t60YvI2rZ0dZC6CTGZp825dwzEEyu8CV0EWeJs84AFpq/tZcNQqu7+UENpxUonSRwfWrQc5iXHvrg+9pwWUS6zz/X9yu+c5Czo+LIM7c4V24pkHeNEoJ5EQYahUyQHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZ4n4GaiTkov6TCI+/g1DwoAFCf7QMYRoCxymy0vS8=;
 b=V8B1UcvPEH5jMzUmwleegi1EzUGdbYmcwcypEKPiK3lyG3fC9of7Rx357isr57r7zlkPQcs29y0O7crXaXnF37qX/VdxFqh+g1XN92kpYbtkiRAqBYctNtpnjU/b4E0hm+99E8/pQj10ImWVHnHNaWpWMHUsmSIE75LZyQBtAxs02bnTTykqAdZmTlRJ4sNzYIhGVCXAGygEIZUKCqkDuzl1NxBwJzjv3bra5NYje330M/cXVffj55x/VnmbyZoHnpguSfnF+q14mBWg/IOfeJtVlc3rYqadVb3j2TqUyUgwpp+lLnGuakshWAK1u+Fa3/HcQzYnRR+FZTjQ0YfS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZ4n4GaiTkov6TCI+/g1DwoAFCf7QMYRoCxymy0vS8=;
 b=4f8Mhjtd4hXLva1bamE6MEf2muDE2j1PyUbiG9icz2qM6OmjUrEYPx8kfX9Mn+6ynq1eFmefxNq7o5h7WyV68VXAGyMCkNK0ejKnbcA8PwxcPmy5K5p2ott1/0yxwPjw2QQr+WTeraRvoJGsWUCe7gdI3NSSQmxZLxvF4w8Epq8=
Received: from BN6PR08CA0088.namprd08.prod.outlook.com (2603:10b6:404:b6::26)
 by DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 10 Dec
 2020 02:45:32 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::b2) by BN6PR08CA0088.outlook.office365.com
 (2603:10b6:404:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 02:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 02:45:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:31 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Dec 2020 20:45:30 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
Date: Wed, 9 Dec 2020 21:45:26 -0500
Message-ID: <20201210024526.1151447-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 035e6d37-0190-4cc5-142c-08d89cb5a9c5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:
X-Microsoft-Antispam-PRVS: <DM5PR12MB119568259F9ABB9C0DE996DB8BCB0@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ykARYLVhLZGlDicn7tg9dnyRgjV3H+kci2cjtWqZB8UYxIolsh7VoIeM/f4EirjPjIUj2bF8LYHh+tr/uZ8C3zSjqBbiE+3n/sj4nrSU1hIFJTLl1uHs3RIZMSytDPY9nb5uLmndB+qt331JOz3BdGkosQ904VLa4rFLhfUVvHtJr3e6lvvNaxO0/d/wMUtCZnsAJlt22BNJrdQ76oy5JtoakAgDfygrQ5TNIdmFILYkuTCzW/MXB9u1fuwnLV5a8ih4NDZeStTJnpoHUYDuROrPYRJv2vTIL96cX7kJEDCWaNaZRlmMN93elwSVKuPy2F6rltvlCPvpvFKmechOBmVsoyHv5SCvfd9JaEFmeMOvy1iz/T9M3jIseQIIc9VE9pNrtAC6nDJhWwE+Jxjqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(5660300002)(54906003)(8936002)(2906002)(82310400003)(7696005)(6666004)(186003)(83380400001)(70586007)(36756003)(70206006)(47076004)(81166007)(336012)(26005)(356005)(2616005)(8676002)(1076003)(44832011)(86362001)(508600001)(4326008)(30864003)(426003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 02:45:32.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e6d37-0190-4cc5-142c-08d89cb5a9c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 2 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f699a3d41cad..c8c72887906a 100644
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
@@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 static void
 decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
-					bool scale_enabled)
+					bool scale_enabled, bool fs_mode)
 {
+	if (fs_mode)
+		return;
+
 	if (scale_enabled) {
 		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else if (native_mode->clock == drm_mode->clock &&
@@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
 	return m_high;
 }
 
+static bool is_freesync_video_mode(struct drm_display_mode *mode,
+				   struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_display_mode *high_mode;
+
+	high_mode = get_highest_freesync_mode(aconnector, false);
+	if (!high_mode)
+		return false;
+
+	if (high_mode->clock == 0 ||
+	    high_mode->hdisplay != mode->hdisplay ||
+	    high_mode->clock != mode->clock ||
+	    !mode)
+		return false;
+	else
+		return true;
+}
+
 static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
@@ -5253,17 +5277,21 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	const struct drm_connector_state *con_state =
 		dm_state ? &dm_state->base : NULL;
 	struct dc_stream_state *stream = NULL;
-	struct drm_display_mode mode = *drm_mode;
+	struct drm_display_mode saved_mode, mode = *drm_mode;
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
@@ -5316,20 +5344,33 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
+		is_fs_vid_mode = is_freesync_video_mode(&mode, aconnector);
+		if (is_fs_vid_mode) {
+			freesync_mode = get_highest_freesync_mode(aconnector, false);
+			if (freesync_mode) {
+				saved_mode = mode;
+				mode = *freesync_mode;
+			}
+		}
+
 		decide_crtc_timing_for_drm_display_mode(
 				&mode, preferred_mode,
-				dm_state ? (dm_state->scaling != RMX_OFF) : false);
+				dm_state ? (dm_state->scaling != RMX_OFF) : false,
+				freesync_mode ? true : false);
 		preferred_refresh = drm_mode_vrefresh(preferred_mode);
 	}
 
 	if (!dm_state)
 		drm_mode_set_crtcinfo(&mode, 0);
 
-	/*
+	if (dm_state && is_fs_vid_mode && freesync_mode)
+		drm_mode_set_crtcinfo(&saved_mode, 0);
+
+       /*
 	* If scaling is enabled and refresh rate didn't change
 	* we copy the vic and polarities of the old timings
 	*/
-	if (!scale || mode_refresh != preferred_refresh)
+	if (!(scale && freesync_mode) || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(stream,
 			&mode, &aconnector->base, con_state, NULL, requested_bpc);
 	else
@@ -7881,13 +7922,29 @@ static void update_stream_irq_parameters(
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
@@ -8205,7 +8262,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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
@@ -8896,6 +8955,7 @@ static void get_freesync_config_for_crtc(
 			to_amdgpu_dm_connector(new_con_state->base.connector);
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
 	int vrefresh = drm_mode_vrefresh(mode);
+	bool fs_vid_mode = false;
 
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
@@ -8903,17 +8963,26 @@ static void get_freesync_config_for_crtc(
 
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
 
@@ -8926,6 +8995,51 @@ static void reset_freesync_config_for_crtc(
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
@@ -9016,6 +9130,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
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
@@ -9047,6 +9166,22 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
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
+			   is_freesync_video_mode(&new_crtc_state->mode, aconnector))
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
