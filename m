Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CEAC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3326610E3C5;
	Wed, 16 Aug 2023 21:29:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC0510E3C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQstrU3M62uMLHgDRXulikkAKBZlnvHWppyCwTzJwUuCb+PuNxwoKw2K13zcfQL1o6c2QsoMzYpWqiLo9zHju7k0Tcn6e8c14j6L4/wXVdmFg2mzFS1bAfJDi1lnLu4ataOFK5l5ko8V3rzhB9LvpEimQbGlhU/ElUd2OOwZVk7VqyM0nWgSds0D+2/Te6h8AQ6QAOlWViP/YtMxgA0BGBHD5A4pWfO5XOvaml59I7uyoteT2+3mDKxEb8Wpf5+LtDzEyPYluqFB61FRZFUZsJspT1v1vIued33uDXN6Iqpy5b2KDbg5irHx7WKNeaaRkeDVoHHkQfN+bf/y8fcGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr68xiEbVXYghtoTBLptvm7TsyxdmAzJd5DkKS+PzKk=;
 b=XXFriswmU9IQMWYRy4C0EOoBZ+vhqti0kTdhtQOYACw3JZsPpHtd5LwBfPOGsRT50rG2/a6UmpyCtVCTMLQtKXNAodfFnpF7rGjOZi8TAl4aFZWeDhSgkZbUbD3Sgv5OwpcAqyZ/tddd7+YqjpE6ipj5h5U//gu38zkNQdwLk7yjiWOBrGDN/TxVG/wRhTgkpvKLrN+Tjd/zRGWHa2as1aDolDn4x4FU7rzPPtspx6IJb/WrZ6U8XQ9s5A2ii6DKpcm0N0iqa0rsvDMB0E2Me+MtNQ2ABmjmfFNCfTsMFLWiBOEBWOV/p/7VR45fmtb2kNs25BDGg+taU1SiVCrU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr68xiEbVXYghtoTBLptvm7TsyxdmAzJd5DkKS+PzKk=;
 b=q9dtiZQlhuSJX4FNy89haZtFIavS8izZCzlyIR6ChsLTRW1SVTVQkv9YTZr9UycxUrhZ6OZsaqbofppDqxVz+4KLh1yBEbDAS3+UoU+J3nPEnk0TqMO1SQI3wmIT+zSdZisvmbXvZ5PSjD5gwD1n8uw1X8GWTBQi4Qy4AyyG7tU=
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 21:29:50 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::a1) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:29:49 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:29:48 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/18] drm/amd/display: Use drm_connector in
 create_stream_for_sink
Date: Wed, 16 Aug 2023 15:26:14 -0600
Message-ID: <20230816212626.987519-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: a9354b02-ab7f-48dc-f02e-08db9e9febd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BizjBQB0aalhr48O0biVc/wbivGMS1EgssaIW01RdTCOHb1S4XgM3jEH4Q0/RsaPqbhS+oZE6b1NyIBM4HwS4pFnNGddWtn0E8XpGB5C7ZA6lokIpnrGP6WkLKIeEW9m0KdG8hZM9/vNSW+8PTT85f1BsSgEHeT6vMnBXrbalJJ1VWRgbSYk3ekYmmhZhUwiEYPF4vsQqDNp5p/uciAJ4F1MmY6AkxmHkqtfQLR5JXWF7NoOeWPJtm8F5dv7J2vfLf7EcJWKJQBRzpwhcKlvOGgFmcykGryD1TJzYTveiLvgsf8QDqjDo2KxeGruFIO+6GIdzYb6bpMWYyIL4EStqJ5lYj9gbokwy6/AVL6vfg5pP8Lhre4MJRRaaYiJ4rWFgbSzN4iM5G5WpLiIXR5bdpsqtZMmWGvTT473jPbuDTi/2RpKtyIDW6JYHLGvkmOuip3ZVSEAo28jLm9mvoJ8YePZHW86mSKwsTPdy+IdVaSfCe73iXs5cLsMPxAzQvE5RRuorcvQqHtkqTEFbhY7AKTBfXIXQB+G0dhggmcmJpfWacttYb2rK16yp5iVlRuvHnDYZ9sRLzZ/wJLdTjLgj2stHoOl1hbfKve96oMVM+iZBECsQhVudBZvipX42wpcxpqJ9cci3hlVmi0W6xHQkle+WL8SUyb/uqqn7bpTUbVn+0zlwJwscXE1yp86LGVZX74GLllKmhrzhVxVDnV0RNDVsiFJ64jPOVMQ+nzNCCQtpdftYbslnRaE4Neo8Aw8PLIthRp3FAyCpW0mtbwPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:29:49.5815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9354b02-ab7f-48dc-f02e-08db9e9febd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
We need to use this function for both amdgpu_dm_connectors
and drm_writeback_connectors. Modify it to operate on
a drm_connector as a common base.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 65 +++++++++++--------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7bd3ec84ff2e..a7d2a3f35f74 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5455,6 +5455,7 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if (drm_mode_is_420_also(info, mode_in)
+			&& aconnector
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
@@ -5490,7 +5491,7 @@ static void fill_stream_properties_from_drm_display_mode(
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-	if (is_freesync_video_mode(mode_in, aconnector)) {
+	if (aconnector && is_freesync_video_mode(mode_in, aconnector)) {
 		timing_out->h_addressable = mode_in->hdisplay;
 		timing_out->h_total = mode_in->htotal;
 		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
@@ -5966,14 +5967,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 
 static struct dc_stream_state *
-create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
+create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
 		       const struct dc_stream_state *old_stream,
 		       int requested_bpc)
 {
+	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_display_mode *preferred_mode = NULL;
-	struct drm_connector *drm_connector;
 	const struct drm_connector_state *con_state = &dm_state->base;
 	struct dc_stream_state *stream = NULL;
 	struct drm_display_mode mode;
@@ -5992,20 +5993,22 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	drm_mode_init(&mode, drm_mode);
 	memset(&saved_mode, 0, sizeof(saved_mode));
 
-	if (aconnector == NULL) {
-		DRM_ERROR("aconnector is NULL!\n");
+	if (connector == NULL) {
+		DRM_ERROR("connector is NULL!\n");
 		return stream;
 	}
 
-	drm_connector = &aconnector->base;
-
-	if (!aconnector->dc_sink) {
-		sink = create_fake_sink(aconnector);
-		if (!sink)
-			return stream;
-	} else {
-		sink = aconnector->dc_sink;
-		dc_sink_retain(sink);
+	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
+		aconnector = NULL;
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (!aconnector->dc_sink) {
+			sink = create_fake_sink(aconnector);
+			if (!sink)
+				return stream;
+		} else {
+			sink = aconnector->dc_sink;
+			dc_sink_retain(sink);
+		}
 	}
 
 	stream = dc_create_stream_for_sink(sink);
@@ -6015,12 +6018,13 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		goto finish;
 	}
 
+	/* We leave this NULL for writeback connectors */
 	stream->dm_stream_context = aconnector;
 
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE =
-		drm_connector->display_info.hdmi.scdc.scrambling.low_rates;
+		connector->display_info.hdmi.scdc.scrambling.low_rates;
 
-	list_for_each_entry(preferred_mode, &aconnector->base.modes, head) {
+	list_for_each_entry(preferred_mode, &connector->modes, head) {
 		/* Search for preferred mode */
 		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
 			native_mode_found = true;
@@ -6029,7 +6033,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	}
 	if (!native_mode_found)
 		preferred_mode = list_first_entry_or_null(
-				&aconnector->base.modes,
+				&connector->modes,
 				struct drm_display_mode,
 				head);
 
@@ -6043,7 +6047,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
-	} else {
+	} else if (aconnector) {
 		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
@@ -6068,13 +6072,17 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	 */
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
-			stream, &mode, &aconnector->base, con_state, NULL,
+			stream, &mode, connector, con_state, NULL,
 			requested_bpc);
 	else
 		fill_stream_properties_from_drm_display_mode(
-			stream, &mode, &aconnector->base, con_state, old_stream,
+			stream, &mode, connector, con_state, old_stream,
 			requested_bpc);
 
+	/* The rest isn't needed for writeback connectors */
+	if (!aconnector)
+		goto finish;
+
 	if (aconnector->timing_changed) {
 		DC_LOG_DEBUG("%s: overriding timing for automated test, bpc %d, changing to %d\n",
 				__func__,
@@ -6092,7 +6100,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	fill_audio_info(
 		&stream->audio_info,
-		drm_connector,
+		connector,
 		sink);
 
 	update_stream_signal(stream, sink);
@@ -6551,7 +6559,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	enum dc_status dc_result = DC_OK;
 
 	do {
-		stream = create_stream_for_sink(aconnector, drm_mode,
+		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
 						requested_bpc);
 		if (stream == NULL) {
@@ -9274,15 +9282,16 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	acrtc = to_amdgpu_crtc(crtc);
 	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
-	aconnector = to_amdgpu_dm_connector(connector);
+	if (connector && connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+		aconnector = to_amdgpu_dm_connector(connector);
 
 	/* TODO This hack should go away */
-	if (aconnector && enable) {
+	if (connector && enable) {
 		/* Make sure fake sink is created in plug-in scenario */
 		drm_new_conn_state = drm_atomic_get_new_connector_state(state,
-							    &aconnector->base);
+									connector);
 		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
-							    &aconnector->base);
+									connector);
 
 		if (IS_ERR(drm_new_conn_state)) {
 			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
@@ -9429,7 +9438,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * added MST connectors not found in existing crtc_state in the chained mode
 		 * TODO: need to dig out the root cause of that
 		 */
-		if (!aconnector)
+		if (!connector)
 			goto skip_modeset;
 
 		if (modereset_required(new_crtc_state))
@@ -9472,7 +9481,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * We want to do dc stream updates that do not require a
 	 * full modeset below.
 	 */
-	if (!(enable && aconnector && new_crtc_state->active))
+	if (!(enable && connector && new_crtc_state->active))
 		return 0;
 	/*
 	 * Given above conditions, the dc state cannot be NULL because:
-- 
2.41.0

