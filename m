Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4238C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 09:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D1310F56E;
	Tue, 10 May 2022 09:57:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44A810F578
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTtqSHjJYvrOai0s2clsMB/JXq1ZHi8Hbl/3Jr3X2tYcZZUEXYpaNuSoxhheCSfdEgggy/13coKbFWG8u2wgM15NgBFIc+kznQWSKnd1laOaOGrJ813WXbpl+lgWQMJJk1GDGZdSiU4/QwbbIK3MmNTd3xKbXxI05/IEQnuoPYrgNYTwBGEX3qjXOYMrXTrIhOXRQg5XWYEJ468bZLPpJqTyoKyZeA+rRTxnkqcD33PVg+w5M3QdyD5NdoOgT1jX/0lF/aaFAFj/D3ROiefJnL/pKKW17WkW8hX5nF1hzHe8uX9Y3KCah4bXGkHnusGL+iVvcfm67uGKc1qF+ZFJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdgv96Lr/JwqZvCeKKQBrh0M3swJb4AmX+mfOHN+sAQ=;
 b=fE3ptsOLNCOYT1uWP/d3AHkd/ZYN8NuhBNYU72ErcgZSMM4Z4sgtEKsyKwTTippJSsZU9WoIVXYIgpUWldhdvUGfkONePGdDJxISk4AqH9JG0ZO88uyUliVph4jBawIu76gkD5eL5FZ8UDddZm9/msRHsfPj0zp//xyfxi9/dCMNDeY8CSuOr40ERnEQKa5pD1rVreUQp2IgH/VvcpuKBp6+crvVae6VjKRduNJpghprK3ul6fC0oFPpYX3KD76K9kZoe2m/zJ6CI/xooE/C6HxRyE6R29oDBfGr6IqsriQ9sSIghUyigfLrumBBt5l7408TiGofYh558r9pnjXluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdgv96Lr/JwqZvCeKKQBrh0M3swJb4AmX+mfOHN+sAQ=;
 b=NJ4o1xOLsVQdtUuPQTMmsORthJZrTYIiSdkFB6/HVAnRbI6h2MzLPVyDIozdXGGZc2/aQblbKCDdTO7vgME/DjzMf2VQ9+5vLrP0tnwZFwpSpKmRnoAplqwePizQImT+X4wrlM62K4+dNqr2ZvnviNb/Y5Y4LH5XsqY9lNAX2p4=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 09:57:51 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::33) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 09:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 09:57:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 04:57:49 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 10 May 2022 04:57:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amd/display: Add flag to detect dpms force
 off during HPD"
Date: Tue, 10 May 2022 17:56:59 +0800
Message-ID: <20220510095701.57375-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510095701.57375-1-Wayne.Lin@amd.com>
References: <20220510095701.57375-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34961563-39e3-47a4-b608-08da326b8b76
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5069D114E7B2B663959D7E94FCC99@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7DEgLjZDMD7/dfb0xeQ/BIad/Ow6XjYDW7uT0pblYaycb/irhqClRBiKz/W9rOjAdk5+yHYCPWJlECBGCFB9EXDzwdXluZdznZg345k+q4+pFYJJAxpfRvhwsQiwwASTvQFlJZ2m26eP+ULOj4WUDEj14swyinSL+rPKXnZJ7MqJvWkWUV5zYjQ/qUIVKfDPaC15fZQd5MCYNQxMmd+qqp7fGHAxJGsuOUNZPl9gUfE9N1aVdi+dOX7Tg0oP7bUY0FiSPfBlSqsmmvwi/B9Roxrch3WQS/NUBw+lj0i9pgydsQActxJPJQVHG58hPPucgJZDGzAyLqo97/D0l29YzzwHlP9UK2QlmTD41lZt2GLoMUE3WHPwokqWaSgmdmNd8bNRMe+49Sw4eWuE1EYdyZEHhTYUetMP/FuQqbI8jyACNY5NTVU8nF0+sfd5ieNCfIyzuuMIxDOnr2BC8HNUWezwXMSRPISExGhhQEP7Ph3nh+UKg2AqAKgReqWZVds8KsV5ReJ2MfsqCJCdk08h9QW2dG1ZHj7gYmwOl13zV83xzK6o1dG7z1bd/NR1sJ6rovwFAHV5ejcDlB/XP217bEIsZK2TCcZWSnhZJ03LOiLUHvR7Kbxi8Zjd45/QtlodH7BqrpguH9WQoue/XAwFGyIqAN82iSjKLa5zAfHou5U6nPFfemoIQVQBdJ4QsOaf98q/34Lig+NRDsxU36WKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(26005)(426003)(70586007)(70206006)(316002)(508600001)(47076005)(40460700003)(81166007)(7696005)(36860700001)(186003)(2906002)(54906003)(8676002)(4326008)(336012)(6916009)(86362001)(356005)(82310400005)(2616005)(83380400001)(8936002)(1076003)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:57:50.7017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34961563-39e3-47a4-b608-08da326b8b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 035f54969bb2c1a5ced52f43e4ef393e0c0f6bfa.

[Why & How]
The reverted commit was trying to fix side effect brought by commit:
"3c4d55c9b9be drm/amd/display: turn DPMS off on connector unplug"

However,
* This reverted commit will have mst case never call dm_set_dpms_off()
  which conflicts the idea of original commit:
  commit 3c4d55c9b9be ("drm/amd/display: turn DPMS off on connector
  unplug") That's due to dm_crtc_state is always null since the input
  parameter aconnector is the root device (source) of mst topology.
  It's not an end stream sink within the mst topology.
* Setting dpms off should be triggered by usermode. Besdies, it seems
  usermode does release relevant resource for mst & non-mst case
  when unplug connecotr now. Which means we no longer need both
  commits now:
  - commit 3c4d55c9b9be ("drm/amd/display: turn DPMS off on connector
    unplug")
  - commit 035f54969bb2 ("drm/amd/display: Add flag to detect dpms
    force off during HPD")

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 16 ++++------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00ebda0bea44..01a36c550778 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2575,7 +2575,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
-static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_state)
+static void dm_set_dpms_off(struct dc_link *link)
 {
 	struct dc_stream_state *stream_state;
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -2596,7 +2596,6 @@ static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_st
 	}
 
 	stream_update.stream = stream_state;
-	acrtc_state->force_dpms_off = true;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
 				     stream_state, &stream_update,
 				     stream_state->ctx->dc->current_state);
@@ -3053,16 +3052,13 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
-	struct dm_crtc_state *dm_crtc_state = NULL;
+#endif
 
 	if (adev->dm.disable_hpd_irq)
 		return;
 
-	if (dm_con_state->base.state && dm_con_state->base.crtc)
-		dm_crtc_state = to_dm_crtc_state(drm_atomic_get_crtc_state(
-					dm_con_state->base.state,
-					dm_con_state->base.crtc));
 	/*
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
@@ -3093,9 +3089,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
 		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none &&
-		    dm_crtc_state)
-			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
+		    aconnector->dc_link->type == dc_connection_none)
+			dm_set_dpms_off(aconnector->dc_link);
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -6609,7 +6604,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
-	state->force_dpms_off = cur->force_dpms_off;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
@@ -9340,8 +9334,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * and rely on sending it from software.
 		 */
 		if (acrtc_attach->base.state->event &&
-		    acrtc_state->active_planes > 0 &&
-		    !acrtc_state->force_dpms_off) {
+		    acrtc_state->active_planes > 0) {
 			drm_crtc_vblank_get(pcrtc);
 
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 321279bc877b..38b0dbcb8aab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -645,8 +645,6 @@ struct dm_crtc_state {
 
 	bool dsc_force_changed;
 	bool vrr_supported;
-
-	bool force_dpms_off;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index bf0d50277f8f..d1af5d580e4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -448,8 +448,6 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
-	struct dc_sink *sink = NULL;
-	bool link_is_hdcp14 = false;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -462,13 +460,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->index = aconnector->base.index;
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
-	if (aconnector->dc_sink)
-		sink = aconnector->dc_sink;
-	else if (aconnector->dc_em_sink)
-		sink = aconnector->dc_em_sink;
-
-	if (sink != NULL)
-		link->mode = mod_hdcp_signal_type_to_operation_mode(sink->sink_signal);
+	if (aconnector->dc_sink != NULL)
+		link->mode = mod_hdcp_signal_type_to_operation_mode(aconnector->dc_sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
 	display->dig_fe = config->dig_fe;
@@ -477,9 +470,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->stream_enc_idx = config->stream_enc_idx;
 	link->link_enc_idx = config->link_enc_idx;
 	link->phy_idx = config->phy_idx;
-	if (sink)
-		link_is_hdcp14 = dc_link_is_hdcp14(aconnector->dc_link, sink->sink_signal);
-	link->hdcp_supported_informational = link_is_hdcp14;
+	link->hdcp_supported_informational = dc_link_is_hdcp14(aconnector->dc_link,
+			aconnector->dc_sink->sink_signal) ? 1 : 0;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
-- 
2.36.1

