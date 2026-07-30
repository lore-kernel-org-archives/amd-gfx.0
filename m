Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D49C5516E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B55710F010;
	Thu, 30 Jul 2026 17:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hn59afcO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060F910F010
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+qWJ1RV5IONlk2jlf/TN8pUcv1jHXYnvE5JPew9npy1u/8/3HnKxnLFUgxElxYMckyn7UDJPTIsZoXCfkoeUs9G2hsWZ9n3ocarJVwAKWg5S/PhKGsTcRghuhQcFBes7+zePVkpBNwReFPUpsXvZUj1x9cMSARYpbmylJOAEdHJkA4ZjWPx5MBCbC69x+c1urRZFbPeOf+DdjJfbRPgyktTVP3UXaDMuSFefEEc4p5WEH7ty4ugZCSc+jVmbca4XsKkResGH6k1J7KGQXpsK3UXOccUg8lawN2Wnkh+9Ih9dHWhtNzI/xWmXj3/Oc/GTqIgLdhRzf4dZ2DI698BoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXlpvZfvJeJbCSuGPl6oeLXRo8DV3sJGAg9zbReyUCs=;
 b=ZNIiwmbtWZx80yvxAcfIDIN7ZSlJyfq5PvupAwS9RmLms0sFboHarRTHeuLwaKfytdH3cCORCOdkLaWjPH1drJu0ACAk7MYwksqM6P4vwxPBIwuB+W3n4MKubDTTag0h2EJIGPPJGG6NWdu1inXKmXsp7wn/aNsrIaHNp5gf1uRbyJJG4xB9rh5YPCGQLL2Qaexpt+aGiaSRs38Bd9M5M3oL48tgooJcWgEd31vI/r58cQtuPd/RyyLOTzvcn5vwhQyQ6Plrl9wp+8EeEgD/h/z53rtkN80gf4udbMBAFa4U2rxEZniT+2O6i9Or4rYRRrNxKX9phW+7CO5PMNAF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXlpvZfvJeJbCSuGPl6oeLXRo8DV3sJGAg9zbReyUCs=;
 b=hn59afcOnl3WRc44jXQdJ1h7toraUjd6FAQFoosQusEvp1H+fKolR5QAt0GYei6M5ChEhNcgD66PGlqKIoiyqCTD12NEmEb9+C4JbHDnN+dabmgFeaPOAd5BOsYytMgr1dyY1ZCAGNn/xtY3nXE9ZcqnADlBBQ26bh0I7mKJdpk=
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:17:35 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::2e) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 17:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:17:34 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:17:33 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Add HDMI ALLM support
Date: Thu, 30 Jul 2026 13:17:54 -0400
Message-ID: <20260730171754.704049-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730171754.704049-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d07dfb-0a2d-4bc6-6a72-08deee5e7280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|5023799004|11063799006|56012099006|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lYV0UWt5o1/Dj+3wnI5cncdT5pr5SYpiZ2ghdMLh1NX8RKWr7hLNOVUDpemRTx8uhrMdfKb7ybygLmOrchkUA3Ip9OyYg9ZhtUhKOCFxLx1qEKzAeWYwaZL0aGMUwxdKMuQ6gWNRlTR7Uy5aOTgVCDCkw/g9scLP8T8pD57uknuFUWNyypojWvHl/znwwRBGuj2kxXqNZSRU0ocqhLjPADtJo43khbrJl2LpectHrZV5dC2356Vfz+yNdccODDcCxl5FapKFtBwGzO5M2aXJFmFGjcpe9HWuwzg8fo2t6o4bysllnbWFY4fTKCgwJgg2HqPpyhClE37iTcBEOmSXeWYPt9OIMsHaztQwm0JWE/T2usAx8z5cff5gzFlvS/2qIsEaY00KweiQ2lJbgzisKDxy8ux4e++lYyY0loV6gOWWJP5L/x0DeDhzyagXfqyTPh5zsiRmZj+92UOlXBteMQx5+7KacnUiG/bGQeuQNJNBAb87tAbcx58brIWmeWnR5TInu9kp2tRrhqdKV835ApNe2BGikpFnwGsLnwMWmusFiSM93CEj76GlcQwJxZNNsOAuJXhcbRMr8XAVykH5j96drr76/PhRzVA2xycd8eMH87H4UX1IBFgHKhXLuR8q3cTgiEIoYUoVIpH0yCLcI8K+675V6VTHoSpiS1bDx5dUxM48AKAH6fPT0OnxgeOsv50YPs+6qwi/UC51uGxiww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(18092099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 91hz1SZaVTN4cxB5D8u5yW7/YPF+k5ddTbxeMrRKvxE9kG8MuHRVWkz4jZZmlG/3a/Yihl7f/i893G3tbfXUGHIzoX2qhnsMux2anNWiN4V7eQgf+6UQTkquzze6i1kYpRJtUviLtPB9UbjTDj6FC/WSvp74Fjz5+H5sDigbRLWwxwVxQ3rgEhoI3GRNUq9RQzHr9PJLauB8ynQ03OB4fyHmc/AHgyWBFnmLL/st4mNmxNktQsrby20JMRMW47psxXYQVi8sq0pJISdyh1wrCZvzPIdjH69U2nSc0ovjoQTNa0hZsDhB0ptBrgAhVRjjRJh/lh8xotg6nUunhsh2H1Lajre1znfJ3GXYLQtywVv2BR29CSB+qnsDx4UqYuiBM6dzD+abVBmrR6Msg0ehuj+SIbH1tgoopVolIw4r1KtX2JKc15m00gB8oAcCIEiK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:17:34.8122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d07dfb-0a2d-4bc6-6a72-08deee5e7280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

why:
HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
low-latency mode through the HF-VSIF. amdgpu never set ALLM_Mode in the
HF-VSIF, so ALLM was never signalled to the sink.

how:
- Add an allm capability flag to struct dc_edid_caps and populate it in
  dm_helpers_parse_edid_caps() from the HF-VSDB ALLM bit parsed by DRM
  core (connector->display_info.hdmi.allm).
- In create_stream_for_sink(), build the HF-VSIF with ALLM_Mode set when
  the sink advertises ALLM and the content type is Game (content-type =
  Game is how userspace requests low-latency mode, HDMI GCTS HF1-56).
- In update_freesync_state_on_stream(), also set ALLM_Mode when
  Gaming-VRR is active (VRR_EN=1, HDMI GCTS HF1-58 step 8.3.1), and push
  the updated HF-VSIF (vsp_infopacket) as a stream update.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 18 ++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  5 ++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  3 ++
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 223b562f7005..fc3005ecc681 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3895,6 +3895,36 @@ static void update_freesync_state_on_stream(
 	new_stream->vrr_infopacket = vrr_infopacket;
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
+	/*
+	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
+	 * advertises ALLM in the SCDS and either the content type is Game
+	 * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
+	 * HDMI 2.1 7.6.6.
+	 */
+	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		struct dc_info_packet vsp_infopacket = {0};
+		bool allm = new_stream->sink->edid_caps.allm &&
+			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
+			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
+			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);
+		bool allm_changed;
+
+		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
+
+		allm_changed = memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
+				      sizeof(vsp_infopacket)) != 0;
+		new_crtc_state->freesync_vrr_info_changed |= allm_changed;
+		new_stream->vsp_infopacket = vsp_infopacket;
+
+		if (allm_changed)
+			drm_dbg_driver(adev_to_drm(adev),
+				       "ALLM: flip on crtc=%u: sink_allm=%d content_type=%d vrr_state=%d -> ALLM_Mode=%d\n",
+				    new_crtc_state->base.crtc->base.id,
+				    new_stream->sink->edid_caps.allm,
+				    new_stream->content_type, vrr_params.state, allm);
+	}
+
 	if (new_crtc_state->freesync_vrr_info_changed)
 		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
 			      new_crtc_state->base.crtc->base.id,
@@ -4429,9 +4459,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		}
 
 		if (acrtc_state->stream) {
-			if (acrtc_state->freesync_vrr_info_changed)
+			if (acrtc_state->freesync_vrr_info_changed) {
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
+				bundle->stream_update.vsp_infopacket =
+					&acrtc_state->stream->vsp_infopacket;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ebead39939a6..430f1628ced0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1511,8 +1511,22 @@ create_stream_for_sink(struct drm_connector *connector,
 	update_stream_signal(stream, sink);
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
-		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
+	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		/*
+		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
+		 * advertises ALLM in the SCDS and the content type is Game.
+		 * Setting content-type = Game is how userspace requests the
+		 * Sink's low-latency mode (HDMI GCTS HF1-56).
+		 */
+		bool allm = sink->edid_caps.allm &&
+			stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
+
+		drm_dbg_driver(dev,
+			       "ALLM: set mode: sink_allm=%d content_type=%d -> ALLM_Mode=%d\n",
+			    sink->edid_caps.allm, stream->content_type, allm);
+
+		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, allm);
+	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 42f5673acb4d..e69ce0a1b4b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -197,7 +197,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
+	if (connector->display_info.is_hdmi) {
+		edid_caps->edid_hdmi = true;
+		edid_caps->allm = connector->display_info.hdmi.allm;
+	}
 
 	if (edid_caps->edid_hdmi) {
 		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3edeb94fba23..ae409cc59ae4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -226,6 +226,9 @@ struct dc_edid_caps {
 	/*HDMI 2.0 caps*/
 	bool lte_340mcsc_scramble;
 
+	/* HDMI 2.1 caps */
+	bool allm;
+
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
-- 
2.53.0

