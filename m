Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAEDC4320E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3EF60E93
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D3EF60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EFC6E9D2;
	Fri, 27 Aug 2021 20:44:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC076E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8AAzu9QsnUpg2bx6/kxPZGCgp8YkwSe3utsjZw7VZzAAUKhL+OldGF3jJLoZs+28o/8kV4A4fr+f6VsdBzaNWIrLe656bEjP7tzDtkoIqVewb9wdItrKFJGr8eWy+6sfj7SSJIic9U2JP7QDY7fYlg55dSofFJf0WBFA+miqb5XXsNoHryVQJLgcDg2n1j2/AAHN7mJsWLTiCVosagQN7Ci/9um577+pL8jC2Je61OcYatzutu0xNYUciyVB4Xr1neKnsmDLFq0yEAO5g7ztfeXoxTzYvgApbRYWIOOD6FuMw4jpIaDH+oZi+b9WQVDlD2xmLiqMIRUivTm+kOQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ4vZm2LU1zMp1pRvSrNWFfc2N4hIlCYW/0DjdyvVb0=;
 b=d6qQR3OKcSvtd5jovSEvP9fXHFN9PWLuCA/dBuepmk7Bv3RcKtP9kbUaVv6lBsegUX7Jl/e7nExHv0T0Bj3KGEaqD9iVGjmLWXPirWzwMGBUVa2JuubFCaHaAMgo4TMg0hyoNtJnqUOgGEDHa0tfemsqNjisIVvydWwKn0lJLQKd8jBHePMWMipFz6Mr0c3trQXVY3CHglPZ3LOLA5fURLD5yfyZkoqMZxive/ABNQEjbBcSvCDcU8xujFtOZgASsWbl6k8oCqTl/qYXeR6yTzjTgaBQAamx8ScaBJUKfoX4tlENxDZJ3BZ4WZ/GgS4XZjbgsofyFa4hvdENxNPm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ4vZm2LU1zMp1pRvSrNWFfc2N4hIlCYW/0DjdyvVb0=;
 b=oZrjbOyLul4r6gvMXlB01hXy7spAnlc9t4lYgfnbwlXA4G9N34gyCgHJVq3B9jwsQlbtTbnNMQo5dsQVZCEOD4F3DC8AtkN1hE92qPsjiFSmk4HzvRhed00nfG7uzkptPy1p+IMBt5HfoMwGfTW5cguDYm1PrlrH6Xqvwk+rD48=
Received: from MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) by
 SN6PR12MB4749.namprd12.prod.outlook.com (2603:10b6:805:e8::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Fri, 27 Aug 2021 20:29:37 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ef) by MW2PR16CA0023.outlook.office365.com
 (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:37 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:34 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/19] drm/amd/display: Add flag to detect dpms force off
 during HPD
Date: Fri, 27 Aug 2021 16:29:02 -0400
Message-ID: <20210827202910.20864-12-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2329348a-b1e1-48ea-1b17-08d96999639a
X-MS-TrafficTypeDiagnostic: SN6PR12MB4749:
X-Microsoft-Antispam-PRVS: <SN6PR12MB474992BC55AAF63664A19FA8E4C89@SN6PR12MB4749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxMfHOEdJS7i2SeifDRDZ9Pftur63l10M15AFofkrxyLEhsl+81WaanpD+X9tYM104gE5V0S6w2JJcVviqJM1o/wD3V9l53ohF7bf7DfxbhvYaCtDIXa0JMpcqEJuCNFhTN81EA1UcKDjrvM6fuXj1HB8nSzR69sm7tXtZt1JJuFCHbEj+rJ8QfNPtQIBK228lXBpcryru3dnn9+BSX9dGim4gNswasXJ8N8PnKhgF4wowUIUQhdLPCeF+O1W1nPhfjmM74AxoeACATRvGMqPMUeYFlAwxtSZw3ynpYCi56oZsllbLsw8v+RxVSihS921w1xwu2KyX3vweIudwMRmN8eTLOPfFm6VX1Xmwg7WAzsqkFK6yGa7ZkZPejSSBKcPJHldfbrTdkbTQ5km937d58T+1A7Y/ywCjkmuskVPAES9evMWuffJWEOy3rAE8ukKeQFRbkgvxqkcmr6fAblyTxOkFLKzqUtE5PY/dlgP/tMCGLzhcfCHgiA/W0sDmkjab9b8fHR+vLTErSVVAxH16SMyE4NZaAWTs3DW1sq/3dtEWyMhJEq4id0JQjslkNRnKp+7ehd4P2Lnhk3j6H4yyNfOLb4R6eNnaRHgNEVBp6/aByZsSBgguKcvh96BN/pAw2Wn3IZ1PwavzQgnWAlytaeIBXt1u7tFtoo9JwEnXLp2XvW+vuCusFuifDIRm+F5wA/tWJyf+6hjRD1nNKdxkpxd4AHVUgXcArQCsg+4Lw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(4326008)(316002)(82740400003)(54906003)(36756003)(8676002)(2906002)(83380400001)(336012)(1076003)(47076005)(86362001)(44832011)(2616005)(8936002)(6916009)(36860700001)(186003)(16526019)(81166007)(70206006)(478600001)(6666004)(82310400003)(356005)(5660300002)(26005)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:37.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2329348a-b1e1-48ea-1b17-08d96999639a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4749
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

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 16 +++++++++++----
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54745ed5898c..0ed0468d0533 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2267,7 +2267,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
-static void dm_set_dpms_off(struct dc_link *link)
+static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_state)
 {
 	struct dc_stream_state *stream_state;
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -2288,6 +2288,7 @@ static void dm_set_dpms_off(struct dc_link *link)
 	}
 
 	stream_update.stream = stream_state;
+	acrtc_state->force_dpms_off = true;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
 				     stream_state, &stream_update,
 				     stream_state->ctx->dc->current_state);
@@ -2725,13 +2726,17 @@ static void handle_hpd_irq(void *param)
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
+
 	/*
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
@@ -2763,8 +2768,9 @@ static void handle_hpd_irq(void *param)
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
 		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none)
-			dm_set_dpms_off(aconnector->dc_link);
+		    aconnector->dc_link->type == dc_connection_none &&
+		    dm_crtc_state)
+			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -6088,6 +6094,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
+	state->force_dpms_off = cur->force_dpms_off;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
@@ -8740,7 +8747,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * and rely on sending it from software.
 		 */
 		if (acrtc_attach->base.state->event &&
-		    acrtc_state->active_planes > 0) {
+		    acrtc_state->active_planes > 0 &&
+		    !acrtc_state->force_dpms_off) {
 			drm_crtc_vblank_get(pcrtc);
 
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9ac932677c55..97b13017ce18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -586,6 +586,8 @@ struct dm_crtc_state {
 
 	bool dsc_force_changed;
 	bool vrr_supported;
+
+	bool force_dpms_off;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index e63c6885c757..f3038e11f1c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -448,6 +448,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
+	struct dc_sink *sink = NULL;
+	bool link_is_hdcp14 = false;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -460,8 +462,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
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
@@ -470,8 +477,9 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
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

