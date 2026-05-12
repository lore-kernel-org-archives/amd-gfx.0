Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A65CD4F40
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B3D10EB76;
	Tue, 12 May 2026 15:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="toxm7Nvs";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE8B10EB4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0ydMQx6eIokC2Rgq4Ys4pePXZjB91FxdFS7KuGJIR0zZ02KPbRIcPNrZjJ37S0O9gkHhWjpVG4oZggWIE/oOlxALwt/i8RFgdJvOkSj8r2h9hUqrS4HYGGfoTmNscOegC9QsJNA0VgKV6ShADEdKH+TMZc75+waGiF556nJmsU694iIor8OXX/1Xr15exv3wElV1bc448icwjwCcgGxlgcXbEq8/WJJ6eZPadwfiuI3qT/Gk4M8+EueLubYmEkytbUS76ZL9obk1Pzg2r159Ke47WZnTeDTcSbu5ryN+elF2sJYPDPoR8JGyXtcEOC03+BHt1E9d/TVCzoQB5BnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKDqHl0gM0Z+9fWlAeVEpqwQYNIQ/CeUjDP2lqN52Yk=;
 b=fEBhNhFBEs0sEM1Z1xwnFeALlQSBnAvYNI5NwoHfnenez9FyO/MwCcB0xLU+swoIuF4+7ourDYLS3LAgOrO91D6ZG4ebZPE4P5UL0VreD8XQE2Ij4JvRIa3/2usUrf9W8jYUgnJ0K0xF8tikMkLYVOjhwqcKEKPtvZaG4u9b5Q0lkbj/Sit/Ckimm51YbkvOe+NtjpVtpmHY4JJjC0uTwDMdoKE+K436nqmz2J5rYDudnggzrcgSvmDNojAn8MoQ53UrbukgtLwxDCoaNTJzoa2A2O+iET3GuWlQbTr3E27nurRaH7Y8eO75DGV1hjzZN1bfB0LgpRS5eB27ikxTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKDqHl0gM0Z+9fWlAeVEpqwQYNIQ/CeUjDP2lqN52Yk=;
 b=toxm7NvsOf7Bfhv+KKUa2U2AmXnBhzA434ujIibSTZk7DC4UyiWE+4ReJbeUhun/WRi0sc0kV3IY2z914KgvPHM6U1oCkgEqiowHIvna2FJtj0lpj3J9+fWsrIxws+3zKpldt/v3DgQI9iMMfzN8tkrSilw8ypblXWdrSpaPSoI=
Received: from MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:52:55 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::c0) by MN2PR06CA0010.outlook.office365.com
 (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 15:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:52:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 10:52:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 08:52:53 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 10:52:53 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v5 10/13] drm/amd/display: Update HDCP and info_packet modules
 for FRL
Date: Tue, 12 May 2026 11:52:41 -0400
Message-ID: <20260512155244.403854-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: e379923d-3944-4eaa-5a15-08deb03e8822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799003|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: /S2jLZ2fudVtdwXHCP0M3EozMcwavA4Yq2AUrzjeJuRk37qnHMTqxHv3bKYpPVZIKJzu2r313+ZF5fI8EaptdZG7tkknmvmqV0ob6odxyyLhbI9KzCRFMKejg/Pb2XxvtUIsNNCC/fgYm587SJcH2rH6d4eqiwwBB9JdllGI8lUk6LmtjN82ggjqVbnYuSFNqG65a8DaMeRgiQBAYItEmWNC3EJU1PiwYKyPZv4Dx3yQ2poACxs3b/iCN5JJsfjK3flUCTHZyYdMkhCeti0GxyLXwyHHR+lLY688VI4Rry3v6I5Ic+UFfE6Ct1Fkra80wev4EBYwsckbUxlwxsNCgdhLU50Oc9djm4l+F28G8jZk/CRk8wvWgiScv+T8QZ1r46MKznQV6ikBZXZXzQ+JtjrTP04tD16jgvLSaGVTNDfBsazjWGdiyu7b7ONqoXh8fDtIgRd++vx6j3PCb2o0G6bLBD2JsKP61I+k9i9s/VbHf5fej+USmbvgUtCdCKAiWxI92Ty6XBx1vWCIRm7qCEjP1wAhze1BF4xs9bkxAWO7JdTGobGgePZlBizM1wjztD18B/nHDnex0BbreTeuRbjgerUa0K7oX4iu+kg/v781H+V8/Nfj/9qiOJ08pAc3tyVIh2pdo9wtR8J5ylU/t1S99SvLmgmQy9ADAUM9J+MhGrUI1nEuX30MiMYFN9r+2AKnHY8yR6rFc96P1by0W3MaYII8fD8LD25s9VMJd80=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799003)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hm3OVZi2Ow4n7Jq3MXFRxUBHbeh2KaAGUkd3puBM3AnV0l9ZDWi1/wNj/y1DVLncTsnSnuJSVVWLmhQHqiQnuxQ+ndmOQIjW7DhE7j8pLfvlWoO9hkR5D8u22Fi6dR+qkqSUjXYU/trAQI3c+zkLHbYio9DZehWKS02ckjc2a32p6v4lxAKlOFA1vDKfPH9NvMr/BfG2dDR9ZIip1aag1my3b8Tz8JG59N4aQITVFLkwaxRsREp17c7CuD/Dkepo1x0qUyMDX91WhE/UMfyq2Rp8K+amstKkTXzkmYld8/sU6nBsyUl1IfkWQ750FhLJw+Q9P5tJrv7Sh45+E0Y6MaU3flHOYHjK0UoF5jEAs/u5wiqVVCDc5y1LRGeecHqMH6QYzfacb9rIiE8B+YnNfNSHfh4q+EDJRUQ0FC7Ak8lDpZTMUwSuBHllvpgk6Aca
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:52:55.1164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e379923d-3944-4eaa-5a15-08deb03e8822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

The HDCP module has a minor update for FRL, and info_packet is
updated for ALLM.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   6 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |   2 +
 .../amd/display/modules/inc/mod_freesync.h    |   3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 .../amd/display/modules/inc/mod_info_packet.h |   2 +-
 .../display/modules/info_packet/info_packet.c | 122 ++++++++++++++----
 9 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c41f017fe8f2..370991b38ab2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7581,7 +7581,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	update_stream_signal(stream, sink);
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
+		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index ca402ddcdacc..fbab100c0e7b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -66,6 +66,7 @@ static uint8_t is_cp_desired_hdcp1(struct mod_hdcp *hdcp)
 
 	return is_auth_needed &&
 			!hdcp->connection.link.adjust.hdcp1.disable &&
+			!is_frl_hdcp(hdcp) &&
 			!hdcp->connection.is_hdcp1_revoked;
 }
 
@@ -584,6 +585,7 @@ enum mod_hdcp_operation_mode mod_hdcp_signal_type_to_operation_mode(
 	switch (signal) {
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 		mode = MOD_HDCP_MODE_DEFAULT;
 		break;
 	case SIGNAL_TYPE_EDP:
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index d07387a961dd..92c128ffe2dd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -406,6 +406,12 @@ static inline uint8_t is_hdmi_dvi_sl_hdcp(struct mod_hdcp *hdcp)
 	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DEFAULT);
 }
 
+static inline uint8_t is_frl_hdcp(struct mod_hdcp *hdcp)
+{
+	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DEFAULT &&
+			hdcp->connection.link.hdmi.frl_enabled);
+}
+
 /* hdcp state helpers */
 static inline uint8_t current_state(struct mod_hdcp *hdcp)
 {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 6b7db8ec9a53..d32df3b869f9 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -200,6 +200,8 @@ static enum mod_hdcp_status add_display_to_topology_v3(
 			TA_DTM_HDCP_VERSION_MAX_SUPPORTED__2_3;
 	dtm_cmd->dtm_in_message.topology_update_v3.encoder_type = TA_DTM_ENCODER_TYPE__DIG;
 	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+	if (is_frl_hdcp(hdcp))
+		dtm_cmd->dtm_in_message.topology_update_v3.encoder_type = TA_DTM_ENCODER_TYPE__FRL;
 	dtm_cmd->dtm_in_message.topology_update_v3.phy_id = link->phy_idx;
 	dtm_cmd->dtm_in_message.topology_update_v3.link_hdcp_cap = link->hdcp_supported_informational;
 	dtm_cmd->dtm_in_message.topology_update_v3.dio_output_type = link->dp.usb4_enabled ?
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index 7844ea91650b..1f9ac8537d53 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -84,6 +84,7 @@ struct ta_dtm_topology_update_input_v2 {
 	uint32_t dig_fe;
 	uint32_t dp_mst_vcid;
 	uint32_t is_assr;
+	/*uint32_t is_frl;*/ /*todo*/
 	uint32_t max_hdcp_supported_version;
 };
 
@@ -91,6 +92,7 @@ struct ta_dtm_topology_update_input_v2 {
 /* Security code will check real HW register values and these SW enum values */
 enum ta_dtm_encoder_type {
 	TA_DTM_ENCODER_TYPE__INVALID    = 0,
+	TA_DTM_ENCODER_TYPE__FRL        = 0x20,
 	TA_DTM_ENCODER_TYPE__DIG        = 0x10
 };
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 57916ed98c86..c042fb1bf49c 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -90,6 +90,7 @@ struct mod_vrr_params_flip_interval {
 struct mod_vrr_params {
 	bool supported;
 	bool send_info_frame;
+	bool m_const_engaged; // this is used when m_const is set up in OPTC so no overriding happens from FreeSync Module
 	enum mod_vrr_state state;
 
 	uint32_t min_refresh_in_uhz;
@@ -98,6 +99,8 @@ struct mod_vrr_params {
 	uint32_t min_duration_in_us;
 	uint32_t fixed_refresh_in_uhz;
 
+	uint32_t m_const;
+
 	struct dc_crtc_timing_adjust adjust;
 
 	struct mod_vrr_params_fixed_refresh fixed;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index 835467225458..d492a59e0939 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -114,6 +114,7 @@ struct mod_hdcp_displayport {
 };
 
 struct mod_hdcp_hdmi {
+	uint8_t frl_enabled;
 	uint8_t reserved;
 };
 enum mod_hdcp_operation_mode {
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 11b127eb13d8..eee8206bc531 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -46,7 +46,7 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		enum color_transfer_func tf);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet);
+		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue);
 
 enum adaptive_sync_sdp_version {
 	AS_SDP_VER_0 = 0x0,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 55c7250f18d8..fa05547c615a 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -504,13 +504,16 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
  *  @info_packet: output structure where to store VSIF
  */
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet)
+		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue)
 {
 		unsigned int length = 5;
 		bool hdmi_vic_mode = false;
 		uint8_t checksum = 0;
 		uint32_t i = 0;
 		enum dc_timing_3d_format format;
+		bool bALLM = (bool)ALLMEnabled;
+		bool bALLMVal = (bool)ALLMValue;
+		int CCBPC = 0;
 
 		info_packet->valid = false;
 		format = stream->timing.timing_3d_format;
@@ -523,47 +526,110 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 				&& format == TIMING_3D_FORMAT_NONE)
 			hdmi_vic_mode = true;
 
-		if ((format == TIMING_3D_FORMAT_NONE) && !hdmi_vic_mode)
+		if ((format == TIMING_3D_FORMAT_NONE) && !hdmi_vic_mode && !bALLM)
 			return;
 
-		info_packet->sb[1] = 0x03;
-		info_packet->sb[2] = 0x0C;
-		info_packet->sb[3] = 0x00;
+		if (!bALLM) {
+			info_packet->sb[1] = 0x03;
+			info_packet->sb[2] = 0x0C;
+			info_packet->sb[3] = 0x00;
 
-		if (format != TIMING_3D_FORMAT_NONE)
-			info_packet->sb[4] = (2 << 5);
+			if (format != TIMING_3D_FORMAT_NONE)
+				info_packet->sb[4] = (2 << 5);
+			else if (hdmi_vic_mode)
+				info_packet->sb[4] = (1 << 5);
 
-		else if (hdmi_vic_mode)
-			info_packet->sb[4] = (1 << 5);
+			switch (format) {
+			case TIMING_3D_FORMAT_HW_FRAME_PACKING:
+			case TIMING_3D_FORMAT_SW_FRAME_PACKING:
+				info_packet->sb[5] = (0x0 << 4);
+				break;
 
-		switch (format) {
-		case TIMING_3D_FORMAT_HW_FRAME_PACKING:
-		case TIMING_3D_FORMAT_SW_FRAME_PACKING:
-			info_packet->sb[5] = (0x0 << 4);
-			break;
+			case TIMING_3D_FORMAT_SIDE_BY_SIDE:
+			case TIMING_3D_FORMAT_SBS_SW_PACKED:
+				info_packet->sb[5] = (0x8 << 4);
+				length = 6;
+				break;
 
-		case TIMING_3D_FORMAT_SIDE_BY_SIDE:
-		case TIMING_3D_FORMAT_SBS_SW_PACKED:
-			info_packet->sb[5] = (0x8 << 4);
-			length = 6;
-			break;
+			case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
+			case TIMING_3D_FORMAT_TB_SW_PACKED:
+				info_packet->sb[5] = (0x6 << 4);
+				break;
 
-		case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
-		case TIMING_3D_FORMAT_TB_SW_PACKED:
-			info_packet->sb[5] = (0x6 << 4);
-			break;
+			default:
+				break;
+			}
 
-		default:
-			break;
+			if (hdmi_vic_mode) {
+				ASSERT(stream->timing.hdmi_vic <= 0xFF);
+				info_packet->sb[5] = (uint8_t)stream->timing.hdmi_vic;
+			}
+		} else {
+			info_packet->sb[1] = 0xD8;
+			info_packet->sb[2] = 0x5D;
+			info_packet->sb[3] = 0xC4;
+			info_packet->sb[4] = HF_VSIF_VERSION;
+
+			if (format != TIMING_3D_FORMAT_NONE) {
+				info_packet->sb[5] |= 0x01;
+				length = 6;
+				switch (format) {
+				case TIMING_3D_FORMAT_HW_FRAME_PACKING:
+				case TIMING_3D_FORMAT_SW_FRAME_PACKING:
+					info_packet->sb[6] = (0x0 << 4);
+					break;
+
+				case TIMING_3D_FORMAT_SIDE_BY_SIDE:
+				case TIMING_3D_FORMAT_SBS_SW_PACKED:
+					info_packet->sb[6] = (0x8 << 4);
+					break;
+
+				case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
+				case TIMING_3D_FORMAT_TB_SW_PACKED:
+					info_packet->sb[6] = (0x6 << 4);
+					break;
+
+				default:
+					break;
+				}
+			}
+
+			info_packet->sb[5] = (info_packet->sb[5] & ~0x02) | (bALLMVal << 1);
+
+			switch (stream->timing.display_color_depth) {
+			case COLOR_DEPTH_888:
+				CCBPC = 1;
+				break;
+			case COLOR_DEPTH_101010:
+				CCBPC = 3;
+				break;
+			case COLOR_DEPTH_121212:
+				CCBPC = 5;
+				break;
+			case COLOR_DEPTH_161616:
+				CCBPC = 9;
+				break;
+
+			case COLOR_DEPTH_UNDEFINED:
+			case COLOR_DEPTH_666:
+#ifdef CONFIG_DRM_AMD_DC_DCN2_0
+			case COLOR_DEPTH_999:
+			case COLOR_DEPTH_111111:
+#endif
+			case COLOR_DEPTH_141414:
+			default:
+				break;
+			}
+
+			info_packet->sb[5] = (uint8_t)((info_packet->sb[5] & ~0xF0) | (CCBPC << 4));
 		}
 
-		if (hdmi_vic_mode)
-			info_packet->sb[5] = stream->timing.hdmi_vic;
-
 		info_packet->hb0 = HDMI_INFOFRAME_TYPE_VENDOR;
 		info_packet->hb1 = 0x01;
 		info_packet->hb2 = (uint8_t) (length);
 
+
+
 		checksum += info_packet->hb0;
 		checksum += info_packet->hb1;
 		checksum += info_packet->hb2;
-- 
2.54.0

