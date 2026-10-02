Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B58CA5FE5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041DB10FA06;
	Fri,  2 Oct 2026 19:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wh72bvDs";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBFB10FA01
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaJDZ/h9VMT6HO8kjXiRaniEzFV5Lh9+x7jhQxOw9b2W/7ysmvAsnEqn2cIGsH9K86Hnf+RTn8LVhr+1hLKe0smF9ugGnV67Q7okQ6UhRaNyPLcvNfPDLaRuVb2SUJwW8Yf7YqypV/vs7wUoWITJo8HgOWKPbARJJ5tUqO7Akh+m8OIOld+xKM928f32GINwNCG77mY3KyQQh64VFcn8FXBzjb9FxD4D5/dFYhj7ppRQtc/YAFD+zjMPzRKIj+y6unRzExndgWD6UR5oq2HcAtyFe0434smQZmqNqTRTCjzuAMaoIrG6EG4uC20Q4Wv/XlVkLYGVEpwl4qJl9xgsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4/zTVBWDcjJuHvMEgTJSwwXiUN2zm1HH9rtQzVtA9U=;
 b=DL/WHm2A96ITOQJDPpDBe0nLReVlXkK3db+a41vPSynNdqaDt0gEVMdSUcEOvU/2OwiTmvhDlpuCwXsdIWcB3PCLFn6sRbROBNaUd6g/xBJxM2Gt1ROPyaS/HP+Y0d0LExplnOLD7WW0i8FTjArz4qiRn0Xo/vF82NEQnrbyg5R8YlaVyMFfnQiWod9kfnE9z+00WUHsX308TAzGL2yul37IiczgV5gu1kG/QjjPHzq4kDr4mC2iinhqzyFq2RtVpu9HSrlXheO23+4IftlFjYCSK1b06qiipBAJcCIyZBAxnKPhfCWLd36+Fcrh3xMZvuvkTY+pwDmSjWmiqo34Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4/zTVBWDcjJuHvMEgTJSwwXiUN2zm1HH9rtQzVtA9U=;
 b=wh72bvDsVzswCziyRmS5LVFqosbWhpbqn40xI2Fgxldi5wphWFs3CrxmRWSF2bm/3ZkWdz8afdcMJEOvOhAb0jQNqAWcBtAMqmdAxx1SFAKARZ9bQ4HNwW0iFW/IPX3LyC5qwrILZ5zmnlGeViAA5CfrwUA1D7nwzIEwIwuC6tE=
Received: from BN0PR04CA0207.namprd04.prod.outlook.com (2603:10b6:408:e9::32)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 19:33:30 +0000
Received: from BN3PEPF00022BD7.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::3f) by BN0PR04CA0207.outlook.office365.com
 (2603:10b6:408:e9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD7.mail.protection.outlook.com (10.167.248.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:25 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:25 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
Subject: [PATCH 16/17] drm/amd/display: Send HDMI VRR metadata in VTEM info
 packet slot
Date: Fri, 2 Oct 2026 15:32:39 -0400
Message-ID: <20261002193240.3441018-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD7:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: e91d9132-f4a7-4e94-6ff4-08df20bc0913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fCPbaFjHd3vfzPVK/7/hyj5hmSlxp+XQB2l3EU0AMeE5yIJh8u69c3lcz48FKTRKvbAEBMKH+5zSyjUu4kVIkvA+fxq14LrCQwFQuEQIP7qbK9CV97JXsYPiiCZ6pSAdhCShb5o8Hw1D8L86uHsCq8+PSM4bS3Vi+GXNFziOfqLr4Ae26TWtNaNF1zMHSvq46DXMVikVTmtl8DrxCr1g7IrlyiPBvC/xRLMAxUcS4UYTCqxgWFYDosBOSNdYDUliNtpKtFW1fLWhXyjRXR8JQJMfSD2+xz9wLiqfItYhsa1Gd4R+2TYPQv+Qnm5DWQJoVVfpOJ31Mh+J+lEgFUC1320eBskMI2oPsVuapT34+WDa4W6wUSsU+WrKbYjn3tur6dkM0U3vwtaCc6Xx8vXc42YuYVerLU8HgyTiziPbC4pis2YDkziL7ALh3NTNImvrWkwGaow9a8QsbAU9YhHQ4kzPN59aKw3yP7Ixd676bgVag9PWPH9DB1XOcta+xcSNd9DJD34q49YNYNUJANBaT9lIPnk10Nfvd6vgqB2pHFl0OYFJc2VfFPz4gonrzdH/E4EnBpMwQ0Eoiqyo0CvBMPoRnBaun0U8d+p5R9TsUojF2njhbN3oIXI2IkJV3lt3v/IbJIsW0UzSETD6Ls9FcBwOR8Yrqy42UiT4xNNbQ1iCmC+W/y5+/21lPFLPuu/fMvj+5vGqBXs5q3vxTSbk4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tIZpE4P/fPVPuIvP6Sr5mZTFyoTx9l1k7mSyrgKJ8uqjwUtwvYW5TF5fNMIr8PUvMdVVpqS7eJnlSYBbFUmMuuNkDXXURULx8W1jdJ2mQOTQVtK8yN9PmPrgCPusn2xgpDRgCob0d9AAfCdbYA2SayFZYyXM3qf5TMum/9LpWvup6qYh5BAKt4OfXUjQr2+ykHwC8wuWwfqiJP7yZn4NzhDCQvTD6T8ls6STvN7Sh8a/MmNB/Gq+Ud8hKTaU/3QrDubHlbi7dMsEfQSYIbPT2vqhv/wB8CVNgEucTP/8OnepZvxabaRmDjJwGT2db8dM+MaJpTmJHKfwLeRaLyTK+xGrFSq0+WPSDBj0ifpyvdzQR7rn2Mvkn8g/nAAJh7AKFDzBlN4Hj3kyQsPrjyHH9Z64OW5h7OD+TaEv/EtaHoOGvo6R0ogr/yi9ewUxBuEJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:28.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91d9132-f4a7-4e94-6ff4-08df20bc0913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
Brief blank on HDMI each time VRR engaged and disengaged, with no modeset
at either transition.

amdgpu_dm_update_freesync_state_on_stream() built the VTEM on top of the
buffer holding the AMD FreeSync SPD payload, which becomes
stream->vrr_infopacket. DC routes that to HDMI generic slot 3 (SPD) and
vtem_infopacket to slot 6 (VTEM), and vtem_infopacket was never populated.
So slot 3 carried a VTEM payload the sink parsed as an SPD
InfoFrame, no VTEM was sent, and v_total varied with no valid metadata
describing it. DP uses the VSC/AS-SDP path and is unaffected.

[How]
Build the VTEM into a separate vtem_infopacket, gated on the sink not
advertising AMD FreeSync. Track it in dm_crtc_state, include it in the
freesync_vrr_info_changed comparison and the reset path, and pass it
through bundle->stream_update.vtem_infopacket.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 26 +++++++++++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6e5dbe0bd82e..f3ed3fef59f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4141,6 +4141,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			if (acrtc_state->freesync_vrr_info_changed) {
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
+				bundle->stream_update.vtem_infopacket =
+					&acrtc_state->stream->vtem_infopacket;
 				bundle->stream_update.vsp_infopacket =
 					&acrtc_state->stream->vsp_infopacket;
 				stream_update_needed = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2ead9bc8e439..594d275918d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1076,6 +1076,7 @@ struct dm_crtc_state {
 	bool vrr_supported;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
+	struct dc_info_packet vtem_infopacket;
 
 	int abm_level;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 1d9148ccfd4f..f4ce389fd0aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -107,6 +107,8 @@ void amdgpu_dm_reset_freesync_config_for_crtc(
 
 	memset(&new_crtc_state->vrr_infopacket, 0,
 	       sizeof(new_crtc_state->vrr_infopacket));
+	memset(&new_crtc_state->vtem_infopacket, 0,
+	       sizeof(new_crtc_state->vtem_infopacket));
 }
 EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
 
@@ -172,6 +174,7 @@ void amdgpu_dm_update_freesync_state_on_stream(
 {
 	struct mod_vrr_params vrr_params;
 	struct dc_info_packet vrr_infopacket = {0};
+	struct dc_info_packet vtem_infopacket = {0};
 	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
@@ -238,21 +241,34 @@ void amdgpu_dm_update_freesync_state_on_stream(
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
-	/* Per HDMI 2.1, VTEM is valid on TMDS as well as FRL */
-	if (new_stream->signal == SIGNAL_TYPE_HDMI_FRL ||
-	    (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A &&
-	     aconn && aconn->base.display_info.hdmi.vrr_cap.supported))
-		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
+	/*
+	 * If the sink does not support FreeSync, but it does support VRR,
+	 * we need to build a VTEM packet to enable VRR.
+	 */
+	if (aconn && !aconn->vsdb_info.freesync_supported &&
+	    aconn->base.display_info.hdmi.vrr_cap.supported &&
+	    (new_stream->signal == SIGNAL_TYPE_HDMI_FRL ||
+	     new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)) {
+		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vtem_infopacket);
+		memset(&vrr_infopacket, 0, sizeof(vrr_infopacket));
+	}
 
 	new_crtc_state->freesync_vrr_info_changed |=
 		(memcmp(&new_crtc_state->vrr_infopacket,
 			&vrr_infopacket,
 			sizeof(vrr_infopacket)) != 0);
 
+	new_crtc_state->freesync_vrr_info_changed |=
+		(memcmp(&new_crtc_state->vtem_infopacket,
+			&vtem_infopacket,
+			sizeof(vtem_infopacket)) != 0);
+
 	acrtc->dm_irq_params.vrr_params = vrr_params;
 	new_crtc_state->vrr_infopacket = vrr_infopacket;
+	new_crtc_state->vtem_infopacket = vtem_infopacket;
 
 	new_stream->vrr_infopacket = vrr_infopacket;
+	new_stream->vtem_infopacket = vtem_infopacket;
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
 	/*
-- 
2.34.1

