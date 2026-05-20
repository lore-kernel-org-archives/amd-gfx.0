Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6435CD5BAE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 20:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA2410E38F;
	Wed, 20 May 2026 20:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cx7oaah1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F08110E38F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 20:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCFeJFm6u2rcxWsIGcrfr9GgSKyIJPDM5CWizIGasYFTHPzm7Khj5O2iSg5lhd8Gr5HjCLBLX+HHBJI9VGUZFYxdR9NWT5kRQ+oXoTRi2YE0z8xIQMc3lOqqMpw8pldNz69NLrMevSYU/RbUdoJb2ZMNyKQwQDqe42Lgh7LZl9EndcWgtE6aBPnGhF0wdmadl9Voz9A1f59QAbnqn/hh9nIKUGlNJ7sFmYxFz1GAo7h0re4gcXgX8MbePo6A0oEChR5zmeSTfer09c6sBiVAAxp1+OOtQZt5thoLb2wno/anAZHwKCt9kuzdIkXMXUXHLrN71u5Y4PKEr2ijeL6lWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2TCN41l0WGybTmG2xA2PNk4MzsJkkffnH2qOrp0fN8=;
 b=hmi2UOa/azSspqw/J3ulE83KZGYPMTDXjAuBRXbOmjXrcpYwegoJynsMnTH+OTnOuLOkRCInm66gVc8oAErh1O0MjYpyTEozlQK3iB1wfB64VLtUey4tPZCDnhJokINzepPCegc0rdcNOp5bppIq2BAQ6Mu4pjmoZTo++i9QdxTg/K+PwtXuV43oYHorHqlErlihnwAUat1kEnzxcEAYM/0z/4aOyP+Ld3imimumVL91eYquEJAJsLyn5hmLQAp1PaMyKxuBuABrWJwX9szBGgsoobjXvqgpiM//YGbGjRS+JYB29koj9yiREHbx3L1ESbscRbyZDzifI5WcyJdKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2TCN41l0WGybTmG2xA2PNk4MzsJkkffnH2qOrp0fN8=;
 b=cx7oaah1Q9JpNQfldY+e08tAH4gml3sqPA97xqgMscECsWEPC8A729Xe6K9D3rDlCVRmzhtuLy7ROfHQSOz67RLXvQHstroe3eVSOha/3j9UX82WqVLb2qS6ir4T+OoTWxRyftFL9UN/8YSLnFi7wXJ+QzBf30O9NSBvAjWkxWw=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 20:29:41 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::a6) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:29:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 15:29:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 15:29:40 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 15:29:40 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v6 11/15] drm/amd/display: Update HDCP and info_packet modules
 for FRL
Date: Wed, 20 May 2026 16:29:24 -0400
Message-ID: <20260520202929.555119-12-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520202929.555119-1-harry.wentland@amd.com>
References: <20260520202929.555119-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c49ac04-e5fa-42c6-1dd0-08deb6ae8589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: aUtVv4sk2pqVVtIIfFvQRDXW9QJAI2c6RwCbK8v/M/+icBdkV8tqz22oo/wutIvnGX4cEYyln6ZdhRWX5ZzMKMNRjf5/WsLb7OtOSgDHZQWjuh3qqnb1c5TxCxjFpYiRLgE6cMUZviW8ZjqsA76iDpH1seMe/gerdcHLSQyraq/zmXp1ZYFXSfoqkLp5YieaGO6ou626kXwrIHXrDidoUHOOvRvWZ/mavL0At/MJQE+pcUrt+f3M5dImvAsL6lWZx2O1KqyJP5uvckeiPzIUNbgstwKcAhgNOZHs9bgKuChvW9p3ihAZtcmcDnHzmLesBsZKjKXzNWE2tl1wbRAty5g+tQ8mns/A56dfxlgLrL6q4oAlZIChgbEWR6JWNRv84Tl/RqmljUQsT/j6vzPegReya6bcGtSHF6NQE5ld/c4AsO6d67LpeCBWdT7rX6DQjHI4i31q2ShRd1G95ugRADcJgsIJmnxWe31f2lgfyVLQ9OmOQnl1PdubDhsYIWZPtbnJtZPRyKNthan9X3+4PZcNmp3r/qEES8AZy4OXHs+mExQatHv8P/Y8MiO0rrC24qBqIJuvqPjLMVm1ulrJGfs1CbdyRXb8PZXQ+q8HKKWNhQYr/f0dF7YRDIwcpF9f6H5BsIayJC5ImfGIKMqJiU/41DY7aS8HNY0/PLl6u614h0a59FPBP52htFFl3Z/1L+jTHD72qJ9jYUt2c/b45YFB+Z9u+ME9LLcMr/EZK5E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QbIGe/OkwO2UrV20oMAsh3MRJfZUTMg/KFRNdExjaeQ5lTRhW1U1T6MwXyWy1fBvfcjW1naKV/F4VVVL9Wav/Rc/PLWLeTRxFoeYpx5bZ4cAdaqSMPE+0wUeEZLNL0XOFfy0suF878dQhA4aQR0nmyqctmL789VNyDIblFTyKSEWrTmlOfMIRrQd6Mf24gveYQsgDz4Tp/6rYV5zg9j4zbngKin8hInPEoO2culbUy6Mp4P9XRHFvxcJ9/9qNqzVohZTUKNOMlJtbtDL1SGNTSsbqRLnF3M/rmLLfgQTYYRS40gBN95RJfxVOLLcXrN6MnepyMHWGsNjLLxFn8M0W6rTvwBrqxazs8BkTtvpOMPscLLrzfKcbpjIo+dCxSIpt2XMLdpKiEx+gi4SlDjR3y3kcBvEPqBfBeEaFhy28ZaXCXc/C29lwN5cbgYg/FGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:29:41.3787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c49ac04-e5fa-42c6-1dd0-08deb6ae8589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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
index d6eba4c37647..c53dd69cb3b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7598,7 +7598,7 @@ create_stream_for_sink(struct drm_connector *connector,
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

