Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEA8CD484E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8E910E7FC;
	Mon, 11 May 2026 15:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WH+f/Ll2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048010E7F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Yx6upWyMXmiRPV2qqd0G0IWYzxElRbcL1lT6Q8BBMsJHlvegSN5kZJHQeoJp7cBe5QuvzgaX4Ywj11EjbswbMqLb7u1VKUddvNbAHQpS7EJN9FwDFj0ZahEVL6yyveCqNkqyu7HGmU/DKuX83LUbu1gnoqQMgmTNRO0S2S9MSAHu4G9maePJ4jUh+ZeA1RhG0/HDkJbAx+iJYtmwnO+DyxRqDzLYYMh2ig9cKf5TYtzQebxY2wMkhnfZEgqlpKnskK8A8MZqN0yZr9STsmpM3lWxA51tfgxTDpxGQ7KVe2VH4JRgmtDSluZLKmUs5kZSF43nUugTMUGeBBvGR8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5QXdI8LGAsFoOqq3W19Zud61+fLomttUNnFBWMjsCI=;
 b=qn2UpRp7IAu+tYZqDWjxlfalhUwo17QyQqewLpdws1ozINR/m25d940miNmich6tUiNg80xdAxsc8KVdkri3blJiEFR/X0nCJUql4QHwEEVVbLsaPSl32/OPOx87SOSfe366Si8mKXH0zyApTAyF6GJpJTEx4hxXQjHUWSZ13Oy4NxQfRaH137+bBT8pmwHHp/RSC6uqNDPi737VF4fCM0ATI2BT6BYBVJoHvpA96jT85vPzX8zvhfyqLHduFPyn1sGIa9nvmXJVAo1XpIQl42HFeDkbnd8cFbtd70veXUXyyXTjCOn5W/4sH3jvhPjHlgjK8Eh84l7gu1Ci5Zm+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5QXdI8LGAsFoOqq3W19Zud61+fLomttUNnFBWMjsCI=;
 b=WH+f/Ll2G1AauCoB2IVNaWp0WiekU1hbECmQ6xXw2gzbzvGqy76SGl7ZJ16SilnZpkgrwO2hsuzmMqje19ReKNsnGAn05Xcoe3ajvOMqAJTL5WV6y7AcWeRJhmOEWTHIcHhyFxFfTjcunjaPL8BnGfjZ8z/onNe3qTxbMcX/C0s=
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:52:30 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::9f) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 15:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:52:24 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:24 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH RESEND v3 10/14] drm/amd/display: Update HDCP and info_packet
 modules for FRL
Date: Mon, 11 May 2026 11:52:07 -0400
Message-ID: <20260511155212.73586-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f313988-0bed-41a2-2993-08deaf754e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: jM+3DcCLo6NdB6DO9FqFFPXruj29WerUDMvCYj+3tl8D+TsI4i1wdcRjSS4yPGf3s3I0qft2ue4lez7z9gHEsqGmF+1JR1Bx8LHURJWCl3LUS4xv19S3djnZ18bkgjn9jxfnCSulj8vlAe1XgYbSe24Jc1fTou/XGbzIQngGHcEgRfJwm2aOaGxs6dtaJo+UphNTM5nRUoLE8XzVE7ropleYrAdGyZX7mFnToVP6ny4tbUyUf3if/ZVt9Jr9WwI4ZJSRwlrLXeKWIZQMyXQ9HxBKjBBKdKwMW+m5ztBUlbfHKsvy/NmQ8fNGUuZYj1tAvF6pd+ipVk+pk31RcYs2sCzkzkYk2LjmULqSu6P2fZZKPL+7yaf4k2Z+d5dkKdZFssfNGo5JynNwAMzdsOyq+k8mUPmABkHO49CNLBcCeL2NMN0twkz+aMD9RiYq7BH7lkf4gjLgMIKaoIjDtNRariGFK1doBbpWw7NHGXkD3MXCc36914b5yxf8ytJorOd4zHDLrdpgtHAIAh6O9/qjDu0y+Ny6v5Bc6J5X9SSG8D2Y6vGuwAErwvTTnC0y4DmtnEVN3JO/xY3OLR8LyT64cvU24SO1HXrPqkhFQvAg84/fLc0umF1AFwgsNk92WgqKs389lNfimoq+8/AM9zK0zxN4nOfedX1/fKxetnV1Rh+FZve/GHwLX3vNm3GsdmGUqrj36lKLtmx5hprU/0L3P/blGhcr812OUK9T1BPDEDA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1fjGObBo+/xIl2bmNXF9Nyfy14ANWMzW3oo2ZmB5zt9ZdV/zh1JKRBjY2NJlgC2e/UCBw6vrZkakd0iehuBcjp5gYwb305aypPrlcrbHjUuCZayXFuNx3t4jcYqCJ6A5HVlft0ep4pjCU0rpzhdKldGqrlAzaSkJtqpabPbOE7twTAJPqNI/FzlFsolek3WEnnvRcivjZeaZp+YuJLa3kIkbJspUne4JdX7wbRYH2IfiwvinSvHJRjhIQQC+TwQpESWXneH6wKw7zv65fvDy8VRvEkLW2jAed2dN2tO1szu3PZ67ieXXdPWLMzMS9wXG6nZgGWX6lgk9rkAgcsp2D3cv/jbfOHQl6FNUmxGXUJjYreVqeEDzS1eaDJ8dPAyTCZ++v27OmoOjToIirU58gx4oXq82z9ULjguMJGFW9QKFaJHf2WtOGPBqzTSnMefz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:29.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f313988-0bed-41a2-2993-08deaf754e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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
index 3fa4dbda4517..847f76d60228 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7577,7 +7577,7 @@ create_stream_for_sink(struct drm_connector *connector,
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
index ddd64b7e4c04..88dd1d508a27 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -45,7 +45,7 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		enum color_transfer_func tf);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet);
+		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue);
 
 enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
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

