Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9037BC55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7FC10F00E;
	Thu, 30 Jul 2026 17:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1v9WaDXc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A0410F00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGAzZ9mjtxSk+Hcepaniz872AnJtWgxdbAT+Z9Coj/Eynq1pIWtTyebZRZXWeRddHxS7g3E5LxfrdKSbsqDsxg7NZL31f9BHLrJdioIv6gOSSYXi/USd9M6vXCf3pGBtyJAw/By9e8Lqsil5qk+m5MFUXb+VZMDFCozePjJlfQR9Wh+kqgROVAn7QCj8aNMEfYHmSgB0t6u5H2zcykYUTYvtLoDFZ+sGuuh2nCU74bsDq4SkfzswMSkjPXYgjkegcW+YgVjARhUldbgYdsnvIlHnzhljoJuWSNyF0lK5YOQp87i82d9V/2LFeWENjCKFHipBCDRzSQ+/Yj2fOD2xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tij5DmKbUYKWRobghtsad7puvwNINvNpHSvudywsSaM=;
 b=g8R+OPeQ593FGwxAshuwWG4nb1vsA7HZK38g5vIiyAZfqQnYif9vnxyHYGkX7UhQfXJ0r4HGN6duklVANFx9zRwmlT8ly7uDkgmDpDgW08whXQI7nqKiaQOsnvLFTaomsIxY2FKhGYnq/Sfr4tlF2pli/2dl2FAPW4SU3vJ2+j/OzweU/JdWRDpP/oIghyPnLHekqdENwYFDPTsfMjntU8OCJTk7STem4yoyZv4QAGgmN8GeFMMueXcRQXTG4w7SfuUFihhK/q+0/Ir6wi037zdEHv0PfdS/BNFQXmFJ6jEQywRgbxKLIDWIaoRSN2cKBJNJ8ziSkh1lHJGCvfTNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tij5DmKbUYKWRobghtsad7puvwNINvNpHSvudywsSaM=;
 b=1v9WaDXcs+hYcaMb3iSG+FxhHJbbmpjtF2pYAXWp9yzJb59S86g07g0eU91PB7v7HiTVwRUek+pLVAq/bLjZP+0crzxzzU7aDfzC8xIye7TPWHGn1q2xy1bJRdNutoYsMBS7cQ+Ux7sBDYbrUBSXz/Gmf4kMUfOSUWvM+k21EI8=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:17:33 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::33) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 17:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:17:32 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:17:32 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Add 2.1 FreeSync support for AMD VSDB
 EDID Block
Date: Thu, 30 Jul 2026 13:17:51 -0400
Message-ID: <20260730171754.704049-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a050f7-f608-4148-be1a-08deee5e7156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 4GNQsFJ6P4YR/ulXuNglI4G84w0PQb4CqCkZQOURbWtcpX1mzIKCRaZ8IUS0IwcLlW+SeOypHkMSlp1tSzmBL0xRBw1P7f6Z1NuirHYBfaj0AA9zjB28fnIIXrRO5nqtYm5O3+Xcu+IkZ462BzBDbV04vLvTirEnM/o92JCIQlWeWndp/g/5NLDx34KnaNY201ty/bOzN0XAGVZWgovnToBm4z98gfwz8SKzd7FGisEv0lVp1tglnE0flgAiaN231Qu4I9Tl90v/FEESdNkdZ2MB+dY59TcP6NCtry8BiLA3ZH2+5EQfr97DvKlR8/2jDFSD5nDFJ0rlMC4+h8S2FenllGkAcnnMihKbDT9SUA1PuE1MsSZXwEUVWcy29vI8UpnW/UrQKruTXlKf6jmbBHMP23EWOZpbpMenB07xbKTe5mGC9zemZQW9aDOsbbB6hDoi1Sbt7q6RN7mZk46Hyp6Ll3o95DQXoZqTgpRnLh9iavs/NNTXvsOfWdo8Ol+HtzEAwFjlFYx3lfy6bnxO5z4oEpzz+PEcnrSEb4bGTSeD9Nif0XzPAopzGAJxIWOiHWyStTKhJBP3eZ93P8/lbdURnUYONbs1aK8dUKghKwug3xZicI4FoiiVG9Xk9RYOdyppAK+kuyuzWWy8iY9ItuCmxqrv+/gmFdAofrXUL1TuKQYZOaD3tDEa0/wu0O/CAEAa7v0EKJyHwKacwEPMUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j/DJ7a6XO2JQvHfGBOrCbemG32wxBprmDEW8nHRjGK+S6+yGCVJXqItmHP0TOh7BFcwkXzGFY0f7o+8XGwW0N85JCgQhASS7qZz4ipbRqwyOFDHuEcp7ku8hKf8fnKYA5QsCs8wdef1JfZaeMgLTZ+Ki3zaDV8pNcJ4aMHvg0sIBGPSMTmBXFsOclIQon+LkqyovSg5ptqw6hZSLq215LAIV5htUL9DkVP3nKp6SUM1NGOKFQ19Dh7CUNpkZf8E+LcOCVwqPYhZpzU1z7hSeJTBqgRfFsMEot7r2NhPvaAds/ZWcMV3HCC1nnVcmN5DNcLUbXj1y9BRITYRsp0iwY9+WIwvDskpNdiYRiy0IsqsMulMJJNkaxmbkV2RiNbj15PK5m8pCQBIrEpT2uLHOpUoRzHhUp7pNjY9HJ3JXynoqGRI3vugGCihbGG1jm+p4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:17:32.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a050f7-f608-4148-be1a-08deee5e7156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

why:
HDMI FRL sinks were not parsed for the AMD VSDB and no VTEM info packet
was emitted for them, so 2.1 FreeSync over HDMI FRL did not work. It is
backward-compatible with 2.0 FreeSync.

how:
- Accept SIGNAL_TYPE_HDMI_FRL alongside SIGNAL_TYPE_HDMI_TYPE_A when
  parsing the AMD VSDB in amdgpu_dm_update_freesync_caps().
- Build and send the VTEM info packet via mod_build_infopacket_vtem()
  when the stream signal is HDMI FRL during the freesync state update.
- Set the VTEM Data_Set_Length to 0 when no VTEM feature is enabled.
  build_infopacket_header_vtem() hardcodes Data_Set_Length = 4, so a VTEM
  with Data_Set_Length = 4 would be transmitted even when no VTEM feature
  is enabled (VRR_EN = 0 and no FVA), e.g. when the sink advertises
  VRRMIN = 0 and vrr_capable is false. This fails HDMI GCTS HF1-58 step
  6.2.
  The VTEM must keep being transmitted every MTW while VRR is enabled
  (HF1-58 steps 8.1 and 8.3), so it cannot simply be suppressed per
  frame. Instead, follow the MLDS option in HDMI 2.1 10.10.2.4: keep
  transmitting the VTEM but set Data_Set_Length = 0 when no feature is
  enabled. When VRR becomes active the full Data_Set_Length = 4 payload
  with VRR_EN = 1 is sent as before.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   4 +-
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a9afc0607b2..ccf882a22a57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3881,6 +3881,9 @@ static void update_freesync_state_on_stream(
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
+	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
+
 	new_crtc_state->freesync_vrr_info_changed |=
 		(memcmp(&new_crtc_state->vrr_infopacket,
 			&vrr_infopacket,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 5e3dfeaed76b..2deb5abae264 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3631,7 +3631,9 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	} else if (drm_edid &&
+		  (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		   sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index eee8206bc531..5181d889fe7f 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -67,6 +67,10 @@ struct AS_Df_params {
 	struct frame_duration_op decrease;
 };
 
+void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket);
+
 void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		enum adaptive_sync_type asType, const struct AS_Df_params *param,
 		struct dc_info_packet *info_packet);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index f5ac4bf32a78..e956c707ac50 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -291,6 +291,21 @@ void set_vsc_packet_colorimetry_data(
 	info_packet->sb[18] = 0;
 }
 
+static void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)
+{
+	unsigned int shift = 0;
+
+	if (!mask || !dest)
+		return;
+
+	while (!((mask >> shift) & 1))
+		shift++;
+
+	*dest = *dest & ~mask;
+	value = value & (mask >> shift);
+	*dest = *dest | (value << shift);
+}
+
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
 		enum dc_color_space cs,
@@ -644,6 +659,100 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		info_packet->valid = true;
 }
 
+static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket)
+{
+	unsigned int fieldRateInHz;
+
+	/* FVA Factor setting */
+	setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M1,
+			(fva_factor > 0)?(fva_factor-1):0);
+	/* VRR Parameters */
+	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+				vrr->state == VRR_STATE_ACTIVE_FIXED) {
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 1);
+	} else {
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 0);
+	}
+
+	if (vrr->state == VRR_STATE_ACTIVE_FIXED)
+		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__M_CONST, vrr->m_const);
+
+	if (!stream->timing.vic) {
+		setFieldWithMask(&infopacket->sb[VTEM_MD1], MASK_VTEM_MD1__BASE_VFRONT,
+				stream->timing.v_front_porch);
+
+
+		/* TODO: In dal2, we check mode flags for a reduced blanking timing.
+		 * Need a way to relay that information to this function.
+		 * if("ReducedBlanking")
+		 * {
+		 *   setFieldWithMask(&infopacket->sb[VRR_VTEM_MD2], MASK__VRR_VTEM_MD2__RB, 1;
+		 * }
+		 */
+
+		fieldRateInHz = stream->timing.pix_clk_100hz * 100;
+		fieldRateInHz /= stream->timing.h_total;
+		fieldRateInHz = (fieldRateInHz + stream->timing.v_total / 2)
+						/ stream->timing.v_total;
+
+		setFieldWithMask(&infopacket->sb[VTEM_MD2],  MASK_VTEM_MD2__BASE_REFRESH_RATE_98,
+				fieldRateInHz >> 8);
+		setFieldWithMask(&infopacket->sb[VTEM_MD3], MASK_VTEM_MD3__BASE_REFRESH_RATE_07,
+				fieldRateInHz);
+
+	}
+
+	/*
+	 * When no VTEM feature is enabled (neither VRR nor FVA), signal a
+	 * zero-length data set (MLDS) by clearing Data_Set_Length. HDMI 2.1
+	 * 10.10.2.4 requires the Source to either stop transmitting the VTEM
+	 * or set Data_Set_Length = 0 when no feature is enabled; keeping the
+	 * VTEM with Data_Set_Length = 0 preserves the every-MTW cadence while
+	 * staying compliant (e.g. HDMI GCTS HF1-58 step 6.2).
+	 */
+	if (vrr->state != VRR_STATE_ACTIVE_VARIABLE &&
+	    vrr->state != VRR_STATE_ACTIVE_FIXED && fva_factor == 0)
+		setFieldWithMask(&infopacket->sb[VTEM_PB6],
+				 MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 0);
+
+	infopacket->valid = true;
+}
+
+static void build_infopacket_header_vtem(enum signal_type signal,
+		struct dc_info_packet *infopacket)
+{
+	// HEADER
+
+	// HB0, HB1, HB2 indicates PacketType VTEMPacket
+	infopacket->hb0 = 0x7F;
+	infopacket->hb1 = 0xC0;
+	infopacket->hb2 = 0x00; //sequence_index
+
+	setFieldWithMask(&infopacket->sb[VTEM_PB0], MASK_VTEM_PB0__VFR, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB2], MASK_VTEM_PB2__ORGANIZATION_ID, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB3], MASK_VTEM_PB3__DATA_SET_TAG_MSB, 0);
+	setFieldWithMask(&infopacket->sb[VTEM_PB4], MASK_VTEM_PB4__DATA_SET_TAG_LSB, 1);
+	setFieldWithMask(&infopacket->sb[VTEM_PB5], MASK_VTEM_PB5__DATA_SET_LENGTH_MSB, 0);
+	setFieldWithMask(&infopacket->sb[VTEM_PB6], MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 4);
+}
+
+void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
+		const struct mod_vrr_params *vrr, int fva_factor,
+		struct dc_info_packet *infopacket)
+{
+	//VTEM info packet for HdmiVrr
+
+	memset(infopacket, 0, sizeof(struct dc_info_packet));
+
+	//VTEM Packet is structured differently
+	build_infopacket_header_vtem(stream->signal, infopacket);
+	build_vtem_infopacket_data(stream, vrr, fva_factor, infopacket);
+
+	infopacket->valid = true;
+}
+
 void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		enum adaptive_sync_type asType,
 		const struct AS_Df_params *param,
-- 
2.53.0

