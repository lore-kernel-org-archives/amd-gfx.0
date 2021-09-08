Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A980C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BBD60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66BBD60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1C46E19C;
	Wed,  8 Sep 2021 14:54:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3194D6E19C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdydW8jIYpkuUuFlhi/ziCyOCLLvta+wZOxc7hO/0ONtZ//n+OcJcOmwTy4sh9l3ZsR49w7u1UU7WuNQ2ODZJNp/iqIuE9nRpfZpJ/E8xDRnml74Xrqwkr0P6SJL5c1cSwxmPw7ZOYFvUAwZGeBnEaHmbJZLB9wmnzXdgSaRLOlEdNAAnl2kI6+pXDu39QPocPIzewdIjX2xOyvq1zc6eWiILxY7Hmuq1/eQPUW4kDJCpNxwMI34tRb75nwGP/LaYU40TTzRwtZPZFeFd+JhXESojlcMCBwKkPz5PMb4i5HZZEzerYOPtTScWj0tnmKfVKg40o2BShlqnQziY1EW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0JMt2BRdxSHG+ekNG/4HzC55i0yOw/Yc0LQ0B4eo5H0=;
 b=XOgjGRqXNrHNszjiN5OtDaADk7VmuG91o8UxfCvB3AlXkeOSmmJERIEdMXUOSN4SmCyHNWg3o9BH2EA0M66h8CYwACBKNIcARht6U/jluhynsm8UC7OMuXZs95RMu8v5OCZR8M1YP15JcjVWE3c1L0Ngqd/Y+1rmMMrwPPUBKD2m2oYVNUz3tFCRw6E4FY9Ehyh4raa7sVRpulcEfQqqFhO29FKlmE3bsj8MXOsJ669jhP/ao4MV8CS3fwbQkH5hIohFoHdLQ7qb9ax2IUKbD0TiGghYUjRbkCPifw2UyQqVih2pDa13OWzNndl5du86qyqf7Ywp5Y/rGP8+wQhl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JMt2BRdxSHG+ekNG/4HzC55i0yOw/Yc0LQ0B4eo5H0=;
 b=Zspx+Ji0ut7QlAns2R8L4Zglz41KELMPosFmn/BzisVJhsbEEE5FhD1onJvhH4sYf+Z0GTyjQurFuH1s9kDghscC83HJ3s+h6p7sxsTo+/cmmMtrO6zEjbNxaTuDux8qdCt1sxIUQJqrltWMmBFnRQh4DFbOmHgiG0y+PCzP4kw=
Received: from DM5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:3:23::17) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:54:49 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::1d) by DM5PR13CA0007.outlook.office365.com
 (2603:10b6:3:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:49 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:42 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 08/33] drm/amd/display: Add flag to detect dpms force off
 during HPD
Date: Wed, 8 Sep 2021 10:53:59 -0400
Message-ID: <20210908145424.3311-9-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e404f8b-41cf-43fc-9559-08d972d89b77
X-MS-TrafficTypeDiagnostic: DM6PR12MB4169:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41693DAC1AA6CA4FDA5EE583E4D49@DM6PR12MB4169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Wsqur0QGWGiA6e3LP7cZTn82pF+bLEiM42yYn2BdsRNMwJpYXJYBLyeGqeBvOCjkSvtESp6uo72uUmDhpFpqZgQSChx8ov9ERvNtWA+06JJQPToOy7ncn7/XsbxLMNgW514JzD92Ds0A3sY394E+koFanyJiCVD46b26JqRkFFANKSxLexzbN353E0EJrpmbNq9WgdRkVz8QKLuUZZGxY4WvVMrsDJKUhRj1KQ1EiaMZ0+JLei73W1sRnA2xe12kpICIah07Gb1UBLo/+90EUOrN3WEGisX3OiUHNu78dafSmSHmOZj1MrW/jKznJnjSoo8A0RE/CJzmPRtCYS/o+alL9nIabpNlMIWSDLzEojnMb4+5Ke88vRpuRtryq7B4uKqBjFzLaZZWu5ascGD0HTM/AAAVF+9EImluU3wkXNeYWVyg1axeJM6kbj1v5xEaHFxlGNg1htfkT8+utDoTYQCRltPoM5kxyfo2TtA9y1nyDaAO4ALGouXdwpUErv08dEq75gr12/qVhdh9M9HoCfYeb3SmekNUMXkk3b0+eQueb1k6HUamcazan4WRyPfAgkezRgx5wi37Osfuw1oGEedpiRFUR8P0ZsPaj1TmS6QvryoroCyjpPVaEVvKgXYNC/cr6BGSSVnkh0XHXIIUBB8lLroPACP0QcSDLXKXEXN25/104JemdO8ecD1xHVEixn1uOTG1+G6tRzRzQtqv+FjHsKfIVasOHMPD5Tty7E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(6916009)(356005)(86362001)(36860700001)(70586007)(426003)(1076003)(8676002)(82310400003)(83380400001)(81166007)(16526019)(47076005)(5660300002)(54906003)(336012)(478600001)(44832011)(316002)(186003)(82740400003)(2616005)(36756003)(70206006)(6666004)(8936002)(2906002)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:49.2386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e404f8b-41cf-43fc-9559-08d972d89b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why] When a connector is unplugged, dpms is forced off so that some
connector allocations are cleared off. This is done outside the commit
sequence from the userspace. This causes HUBP blank. Due to the blank
hubp, a non blocking commit which queues flip will encounter a timeout
waiting for the flip_done because prior to writing the surface flip
address, hubp was in blank.

[How] Add a marker to DM's crtc state and use this field to indicate
whether dpms was forced off during an HPD. Check for this marker before
queuing the flip.

Reviewed-by: Anson Jacob <Anson.Jacob@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 18 ++++++++++++++----
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c8ef72702e60..a6c8c30f8c2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2409,7 +2409,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
-static void dm_set_dpms_off(struct dc_link *link)
+static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_state)
 {
 	struct dc_stream_state *stream_state;
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -2430,6 +2430,7 @@ static void dm_set_dpms_off(struct dc_link *link)
 	}
 
 	stream_update.stream = stream_state;
+	acrtc_state->force_dpms_off = true;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
 				     stream_state, &stream_update,
 				     stream_state->ctx->dc->current_state);
@@ -2873,13 +2874,16 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
-#endif
+	struct dm_crtc_state *dm_crtc_state = NULL;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
 
+	if (dm_con_state->base.state && dm_con_state->base.crtc)
+		dm_crtc_state = to_dm_crtc_state(drm_atomic_get_crtc_state(
+					dm_con_state->base.state,
+					dm_con_state->base.crtc));
 	/*
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
@@ -2911,8 +2915,9 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
 		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none)
-			dm_set_dpms_off(aconnector->dc_link);
+		    aconnector->dc_link->type == dc_connection_none &&
+		    dm_crtc_state)
+			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -6253,6 +6258,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
+	state->force_dpms_off = cur->force_dpms_off;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
@@ -8914,7 +8920,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * and rely on sending it from software.
 		 */
 		if (acrtc_attach->base.state->event &&
-		    acrtc_state->active_planes > 0) {
+		    acrtc_state->active_planes > 0 &&
+		    !acrtc_state->force_dpms_off) {
 			drm_crtc_vblank_get(pcrtc);
 
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a038c70037b5..a85b09986aab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -629,6 +629,8 @@ struct dm_crtc_state {
 
 	bool dsc_force_changed;
 	bool vrr_supported;
+
+	bool force_dpms_off;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c5f1dc3b5961..c5f61be1f6b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -448,6 +448,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
+	struct dc_sink *sink = NULL;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	bool link_is_hdcp14 = false;
+#endif
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -460,8 +464,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->index = aconnector->base.index;
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
-	if (aconnector->dc_sink != NULL)
-		link->mode = mod_hdcp_signal_type_to_operation_mode(aconnector->dc_sink->sink_signal);
+	if (aconnector->dc_sink)
+		sink = aconnector->dc_sink;
+	else if (aconnector->dc_em_sink)
+		sink = aconnector->dc_em_sink;
+
+	if (sink != NULL)
+		link->mode = mod_hdcp_signal_type_to_operation_mode(sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
 	display->dig_fe = config->dig_fe;
@@ -470,8 +479,9 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->stream_enc_idx = config->stream_enc_idx;
 	link->link_enc_idx = config->link_enc_idx;
 	link->phy_idx = config->phy_idx;
-	link->hdcp_supported_informational = dc_link_is_hdcp14(aconnector->dc_link,
-			aconnector->dc_sink->sink_signal) ? 1 : 0;
+	if (sink)
+		link_is_hdcp14 = dc_link_is_hdcp14(aconnector->dc_link, sink->sink_signal);
+	link->hdcp_supported_informational = link_is_hdcp14;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
-- 
2.25.1

