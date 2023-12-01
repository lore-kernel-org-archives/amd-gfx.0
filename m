Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E8C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB7310E897;
	Fri,  1 Dec 2023 13:29:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2234910E890
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f50a6omyTTg8YcWyLQzYd4Fgs09H23iwkrWTrNd2AQvKlSDop7TxgIswyJIEgc3+2zCdLpxXi05SJ1qY/NlnFXFpSoNild/ZKtDvnhS/ZYzhxxdvjYWwK0E58zIPc63+DzQ9rflv5E2TF9KFbinwWsnlH0t2hkezSWuGD32vDbNsSntnDY1dFPXXhEajILA5nDsKOSmOkJ9uyNcEt/ZqOBHbqburOGt0kibXzJvcQfMhLIqdSFZjM8P4170ISR2g7kjq+NWtqV43KB4FnZrsRBbwlHTiPcwjpvTrSefLSTSjTtK6tjbo1pNsjU/Wm/c4x65i8T0zmZkHYv+T/MB87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIFpAU2tn3aGxDuZFBnHK8sT3qMeoKwI5PHu38K7vws=;
 b=eT5KsByvB3EKY2pj7MvVxv4f9qL6qp9vXwQ3oCIkuboyoMf1LDAWDuw+ThLek0vB8Q9DHx89P6v0ovoJDcYaelETOMTRQjZZk7koG4yd+OqaY3aGCh6JUsTe7HL1WiDlJb/BbznIlTl4qIDTbGvtgdkHDrA6TREBcxS1TFAeRlDiX0MhfeqR4A2xAnGWrpgJwIE4ydIQkyTWQVmjMuGpN380Y01SIr8mZYXhgORNiDeCfthl5+2QAKMMPZA+eRUHzljd85lJuT7hPfoz6O9vMaV34lvcmqO7G/TtEknypJZ0D4G6nzjk00+8ygKm2cO9ShHhu6KTG3Fu7xltgNrgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIFpAU2tn3aGxDuZFBnHK8sT3qMeoKwI5PHu38K7vws=;
 b=ovcn0+v6F8/nGI+bqZWtfRF6R7M8hxpAntSFoeePk7KB4Dqpo81HX5iC5EFigE2gnpddiTYfl2KJYtjOAoVtFIMeYSpD9ok4M9GHsBlKSOUNwBR8bLet0SXij3ySeV4wj8nb3aFG6ul48hslF1xzSGkNrn0AyuYE4r3bQJwiI84=
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 13:29:11 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::91) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:08 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/47] drm/amd/display: Use drm_connector in
 create_stream_for_sink
Date: Fri, 1 Dec 2023 06:25:27 -0700
Message-ID: <20231201132731.2354141-32-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8218c6a2-df3f-4a05-ef27-08dbf27180d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RI5iKVzvXq7b7BwzlnPjyN7FG4l+PmZ3O+dL3llcsGxhEWR+UwT11xxRTcu1OQiCETpE1x6VODLjcSNSR6BHavOXMnNCIhE+Am5iA27vljvyuDhlpXDTRQgBCD1itrJNIecPQdaBvceLEduYhl2U4g3ccDgKLP4wdtrl3jd20/foiEHR1ekk3oMKNA4p03eQJQIs6tWF8CQB9fC1b3h19NxvPfAjZbwQEqXcomCq1vlHJ/UxxFM59256h60XYwEuoKdJ6SG5LjG4OTJWrGSo7fQTw0ZcvRrvvFKprNAhx6vHsZM2ABD09SQoFBpbjqspBbcVhhrFZeRMK7taFE486sl5amo7/n1yi6XbL+eULx1a6xV1FZiUSdZ7QznVtuVDDcd3WMi/E7RlOTxhBvOk/dPBcx/WDGM7MrBVpWhhcdEL+qwsE86INqkplGJvyca3fUkVkv06cnCWagTJs7YOPTnIg8vuAhY1R6HtR2N/0ReiZxlea+xdp9Ey6+67fizJGX+Fo5MRsm6SuAdVa6x6b5Jyhd/oSVO39vcOhQDdsOi1+LtCMDG9wgEG9w8AaQrtDOAgNoj1OjlHQs2KPka3kEehSqcC0TMjmiLRMzl4vcxWlWanbBQAJU958lQp+q2QSwz5UE3Un2wrXpLhlYhdrJ1idnxk4u/cb1ad7QHZmsAzkedTm0htFSEV2dMgMQm4DABURngghSSZbIjnZozKPuqOiL9NPcCAEqhaRZt685I2Zxvq/V4jxjlQJutWd5qFdi3LJWOQzwOrtE/ptUvAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(26005)(40480700001)(40460700003)(36860700001)(356005)(82740400003)(81166007)(47076005)(1076003)(5660300002)(2906002)(336012)(16526019)(426003)(83380400001)(6666004)(2616005)(478600001)(70206006)(316002)(70586007)(36756003)(41300700001)(6916009)(86362001)(8936002)(4326008)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:10.8940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8218c6a2-df3f-4a05-ef27-08dbf27180d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
We need to use this function for both amdgpu_dm_connectors
and drm_writeback_connectors. Modify it to operate on
a drm_connector as a common base.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 65 +++++++++++--------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 944b1ce7f30a..09ce6de09039 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5538,6 +5538,7 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if (drm_mode_is_420_also(info, mode_in)
+			&& aconnector
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
@@ -5573,7 +5574,7 @@ static void fill_stream_properties_from_drm_display_mode(
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-	if (is_freesync_video_mode(mode_in, aconnector)) {
+	if (aconnector && is_freesync_video_mode(mode_in, aconnector)) {
 		timing_out->h_addressable = mode_in->hdisplay;
 		timing_out->h_total = mode_in->htotal;
 		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
@@ -6050,14 +6051,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
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
@@ -6076,20 +6077,22 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
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
@@ -6099,12 +6102,13 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
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
@@ -6113,7 +6117,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	}
 	if (!native_mode_found)
 		preferred_mode = list_first_entry_or_null(
-				&aconnector->base.modes,
+				&connector->modes,
 				struct drm_display_mode,
 				head);
 
@@ -6127,7 +6131,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
-	} else {
+	} else if (aconnector) {
 		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
@@ -6150,13 +6154,17 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
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
 		drm_dbg(aconnector->base.dev,
 			"overriding timing for automated test, bpc %d, changing to %d\n",
@@ -6174,7 +6182,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	fill_audio_info(
 		&stream->audio_info,
-		drm_connector,
+		connector,
 		sink);
 
 	update_stream_signal(stream, sink);
@@ -6642,7 +6650,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	enum dc_status dc_result = DC_OK;
 
 	do {
-		stream = create_stream_for_sink(aconnector, drm_mode,
+		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
 						requested_bpc);
 		if (stream == NULL) {
@@ -9398,15 +9406,16 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
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
@@ -9553,7 +9562,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * added MST connectors not found in existing crtc_state in the chained mode
 		 * TODO: need to dig out the root cause of that
 		 */
-		if (!aconnector)
+		if (!connector)
 			goto skip_modeset;
 
 		if (modereset_required(new_crtc_state))
@@ -9596,7 +9605,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * We want to do dc stream updates that do not require a
 	 * full modeset below.
 	 */
-	if (!(enable && aconnector && new_crtc_state->active))
+	if (!(enable && connector && new_crtc_state->active))
 		return 0;
 	/*
 	 * Given above conditions, the dc state cannot be NULL because:
-- 
2.42.0

