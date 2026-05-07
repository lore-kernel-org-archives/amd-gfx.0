Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2FDCD3447
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8B910F1F9;
	Thu,  7 May 2026 15:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sg7guVic";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DD510F1F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD5G+NG+XC2lJG5tml9FhG6KOabgenJeGSAoU36e+9eQH3GWEElLvKnw3+PeBXmA25xjrdcLjBf6NyXxPJZmZhH9jAeur+UJDkiWji/TgZthZXx4tAVCaIGF/EiFvf/XEJ+aZMm+Uwv3FRmSjE9611Vq2DKXTMXumv/K+aFKV65iHxYTcJBXdrNTvMFLqwzvNQVKHBh/mJ1LRK+JxadZ2/zrBNPzui9smQFQGOobvP3hSQC88ytZlPxQiHM/ROGqNy7WjeeiIhxNun5uY406FPM8vNx50kZqCcjM1vb35ZmEleKFgy4wJcpQAudz1Mkjt5wCbKnJNDMwVv0AnNRLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvOnBDrvhwSCD2cdn5akr9nOnaL21wnsplI71rpUCB0=;
 b=UGGxBdGeB0fSA2NtV4oSkWIVEzJBbJ013dvU3UPFYrPFM+GINR/HsrVm9IlLaOCsdvHNcZxVXknf/x9s9/rOqiWsOTmN9rjXH6e1+MVfqz8sgMKuDuh66uHsjygRMdRFFd+Q8HMCdYPPZl9RURJAeqEFL1Am5K+o/PuAt+MOsxC3GzjNME9dralHzMET5sTYGrR42DruNecng72v1C7+jOOJu6vq6Jnx8DGo/884pw+nawI+3e3v81bvYvw+ZsWPvV69p+AuWicgA/ZKH18SV4jiYQFGA7DMt4cy/hM/sXiJAMqZwzb+ojeHDbjkf2CwinwWVUE94OYL2RBN6S1D9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvOnBDrvhwSCD2cdn5akr9nOnaL21wnsplI71rpUCB0=;
 b=Sg7guVicApex5RZuPV4Ipb1H26H3bpVROVLkDQ/Yp8eRWat1gIObS9ZMrueM7f47ZiKCnD7Y6yRBZmMd8Z0u636SsiRCjHvsZynHCrxsBDPb9UOSipODcwDVEc+TczJ/p5oQ9Y8CS4qWMpeHjmFIie1zFDPpiMo2z+iFrx4lXzc=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 15:52:13 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::62) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 15:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:52:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 10:52:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 10:52:02 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:52:01 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 20/22] drm/amd/display: Tie FRL support into amdgpu_dm
Date: Thu, 7 May 2026 11:51:42 -0400
Message-ID: <20260507155147.182540-21-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155147.182540-1-harry.wentland@amd.com>
References: <20260507155147.182540-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 0450796f-60f1-4a55-a8a4-08deac509b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3fof1dMCZxG6M3SD7vY1UOqsaRYiRkDklta3VT5cJEFNP9Qh+Fy8Fm0eV3rUICQVy3p3AGHF40cYDDD37gRdq6cjCoZfKojlujNRfvsdthh+/H4Y2lxWH4I9WGEK470V2GsBbcSIsLKoDsrq201wVhekmb7hjjwkTaPUE7g8WCXJ+iT48Gt4b/Lh+ViNtUhrtzxxu/yFxNfJIt1ZN2Jx6cOqfYbGEc5jc3LhMeBYjE3EziaaMkWfc0D7QHyK9F23nkd4b2aPsj/H4wvt6jPt/AHiOXxzsKbh8NeWUh2LpjU3Qcm6fXYt5bc4wkpyJE+LhakJUOvc6ol+258HER1deFCVvMSihfgb0f3vbscXUlHF50zKVZ0cOje5C3N2su1hNLH2c15oHmUEvt/buZpqfxmfWBougdTq6jHj7NY4+geG2QaWU4wGU5XxJB9lnd0oDu//GvVFHXlBt8cfa7ESVb0j1213EH3PhNTk5DG1RT65yu4dSU28B+X9u65DUGazjPsP/GCS883URisFQqEtTbZcrEMDUHcMylMet8BCjjriQcaPbf6NWVuTG07UXuoIXEoiYIzZIcQLJQvLZX3hfLAEHTo6Z7eucLdhlNdJLPqKLQDKgVe+tpQnSvkRQA0EeUlHMp4pudAafYMYCrVNfLtkuIkbctjMKNPBxhe3Wdql/XP+ZFDxWm76Rm7A40tnRwVbWATsJH+HBR5MRU+O8QwrMUAdMHUy7JWHi3MIa58=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TzTg8aYkld64838ywPeFk+GTs7hP/aER9dnujOWCAZEpVuDkPj9o3qPft4I5ZMlHrTWLQGotA8mn+9Bfbu4T7OB7JUWapvzFWqm8rn+XETCMTnsiOnYmCJdQBh3EtLIg7ffSaVIQ9hLGv7CmDQrFvBIw0DMx6HY41P7zKdzcFMqWuDK+2wfUYk2cUpI7GoF3Cy2g9/ee2tFuQnWA5EW4Cjg0tCxEkQA+uKqqCViikk3BbYvQkG25MgCcrlereIGxK6YbieHzLCyKqmFA6L2QyBKj2b1ZLP+UJhCHyvkav9wWWOuNEClaya7QYo+UpYV0qNepAZ5XN7+ueDXQ+dNPVSBxherfsQeWAWiX4Ll0YRZNk64Aw7xUYVW+RUsXC3XcxXFuNi6vpGN/TKhHsHImRGirl4FxkYlat9Odv3g9AAMFzCHLHCq0uwc2Gp8egbsL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:52:13.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450796f-60f1-4a55-a8a4-08deac509b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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

Tie FRL support into amdgpu_dm, including the FRL status
polling workqueue.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 68 +++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 10 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 23 ++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 79 +++++++++++++++++++
 5 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 847f76d60228..99d03cb536b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2210,6 +2210,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
+	if (adev->dm.dc->caps.max_links > 0) {
+		adev->dm.hdmi_frl_status_polling_wq =
+			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
+		if (!adev->dm.vblank_control_workqueue)
+			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
+	}
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
 		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
@@ -4279,6 +4285,40 @@ static void hdmi_hpd_debounce_work(struct work_struct *work)
 	}
 }
 
+static void hdmi_frl_status_polling_work(struct work_struct *work)
+{
+	struct amdgpu_display_manager *dm =
+		container_of(to_delayed_work(work), struct amdgpu_display_manager,
+				hdmi_frl_status_polling_work);
+	struct dc *dc = dm->dc;
+	struct dc_link *dc_link;
+	bool link_update = false;
+
+	for (int i = 0; i < MAX_LINKS; i++) {
+		dc_link = dc->links[i];
+
+		if (!dc_link || !dc_link->local_sink)
+			continue;
+
+		if (!dc_is_hdmi_signal(dc_link->connector_signal))
+			continue;
+
+		if (dc_link->connector_signal != SIGNAL_TYPE_HDMI_FRL)
+			continue;
+
+		link_update = dc_link_frl_poll_status_flag(dc_link);
+		if (link_update) {
+			mutex_lock(&dm->dc_lock);
+			dc_link_detect(dc_link, DETECT_REASON_RETRAIN);
+			mutex_unlock(&dm->dc_lock);
+		}
+	}
+
+	queue_delayed_work(dm->hdmi_frl_status_polling_wq,
+			   &dm->hdmi_frl_status_polling_work,
+			   msecs_to_jiffies(dm->hdmi_frl_status_polling_delay_ms));
+}
+
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -6929,7 +6969,8 @@ static void fill_stream_properties_from_drm_display_mode(
 			timing_out->flags.VSYNC_POSITIVE_POLARITY = 1;
 	}
 
-	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		stream->signal == SIGNAL_TYPE_HDMI_FRL) {
 		err = drm_hdmi_avi_infoframe_from_display_mode(&avi_frame,
 							       (struct drm_connector *)connector,
 							       mode_in);
@@ -7576,7 +7617,8 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	update_stream_signal(stream, sink);
 
-	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
@@ -8279,6 +8321,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 
 	if (aconnector &&
 	    (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	     aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_FRL ||
 	     aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 		bpc_limit = 8;
 
@@ -9175,6 +9218,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		aconnector->hdmi_hpd_debounce_delay_ms = 0;
 	}
 
+	dm->hdmi_frl_status_polling_delay_ms = 200;
+	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
 	 * which means HPD hot plug not supported
@@ -10818,6 +10863,25 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
+	bool frl_stream_found = false;
+
+	for (i = 0; i < params.stream_count; i++) {
+		struct dc_stream_state *stream = params.streams[i];
+
+		if (stream->signal != SIGNAL_TYPE_HDMI_FRL) {
+			frl_stream_found = true;
+			break;
+		}
+	}
+	if (frl_stream_found) {
+		if (queue_delayed_work(dm->hdmi_frl_status_polling_wq,
+				       &dm->hdmi_frl_status_polling_work,
+				       msecs_to_jiffies(dm->hdmi_frl_status_polling_delay_ms)))
+			drm_dbg_kms(dev, "200ms frl status polling starts ...\n");
+	} else {
+		if (cancel_delayed_work_sync(&dm->hdmi_frl_status_polling_work))
+			drm_dbg_kms(dev, "200ms frl status polling stops ...\n");
+	}
 	/* Allow idle optimization when vblank count is 0 for display off */
 	if ((dm->active_vblank_irq_count == 0) && amdgpu_dm_is_headless(dm->adev))
 		dc_allow_idle_optimizations(dm->dc, true);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1e0ccf58cdb8..8af11bfda6fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -706,6 +706,14 @@ struct amdgpu_display_manager {
 		struct completion replied;
 		char reply_data[0x40];  // Cannot include dmub_cmd here
 	} fused_io[8];
+	/**
+	 * @hdmi_frl_status_polling_work:
+	 *
+	 * workqueue for 200ms frl status polling
+	 */
+	struct workqueue_struct *hdmi_frl_status_polling_wq;
+	struct delayed_work hdmi_frl_status_polling_work;
+	unsigned int hdmi_frl_status_polling_delay_ms;
 
 	/**
 	 * @dm_boot_time_crc_info:
@@ -852,6 +860,8 @@ struct amdgpu_dm_connector {
 	bool disallow_edp_enter_psr;
 	bool disallow_edp_enter_replay;
 
+	union dwnstream_portxcaps mst_downstream_port_caps;
+
 	/* Record progress status of mst*/
 	uint8_t mst_status;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a10401675f53..5c0d275fcbd6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -578,6 +578,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.mst_enabled = config->mst_enabled;
 	link->dp.dp2_enabled = config->dp2_enabled;
 	link->dp.usb4_enabled = config->usb4_enabled;
+	if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+		link->hdmi.frl_enabled = config->frl_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 2;
 	link->adjust.retry_limit = MAX_NUM_OF_ATTEMPTS;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c53230cdfdc5..05f9a01f223c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1032,9 +1032,32 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 	return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid, connector);
 }
 
+static uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
+{
+	uint8_t max_frl_rate;
+
+	if ((max_lanes == 3) && (max_rate_per_lane == 3))
+		max_frl_rate = 1;
+	else if ((max_lanes == 3) && (max_rate_per_lane == 6))
+		max_frl_rate = 2;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 6))
+		max_frl_rate = 3;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 8))
+		max_frl_rate = 4;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 10))
+		max_frl_rate = 5;
+	else if ((max_lanes == 4) && (max_rate_per_lane == 12))
+		max_frl_rate = 6;
+	else
+		max_frl_rate = 0;
+
+	return max_frl_rate;
+}
+
 void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
 	edid_caps->scdc_present = hdmi->scdc.supported;
+	edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
 }
 
 enum dc_edid_status dm_helpers_read_local_edid(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 67e7e14d8976..8e2a8c2c1d84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1174,6 +1174,77 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	return 0;
 }
 
+static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
+							uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps)
+{
+	unsigned int max_conv_bw_in_kbps = 0;
+	unsigned int max_sink_bw_in_kbps = 0;
+	unsigned int dsc_max_sink_bw_in_kbps = 0;
+
+	if (aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
+	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE == DOWN_STREAM_DETAILED_HDMI) {
+		max_conv_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
+				aconnector->dc_link->dc,
+				aconnector->mst_downstream_port_caps.bytes.byte2.bits.MAX_ENCODED_LINK_BW_SUPPORT);
+		if (aconnector->dc_sink->edid_caps.max_frl_rate && max_conv_bw_in_kbps) {
+			max_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
+					aconnector->dc_link->dc,
+					aconnector->dc_sink->edid_caps.max_frl_rate);
+			dsc_max_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
+					aconnector->dc_link->dc,
+					aconnector->dc_sink->edid_caps.frl_dsc_max_frl_rate);
+
+			*bw_in_kbps = min(max_conv_bw_in_kbps, max_sink_bw_in_kbps);
+			*dsc_bw_in_kbps = min(*bw_in_kbps, dsc_max_sink_bw_in_kbps);
+		}
+	}
+
+	return *bw_in_kbps > 0; // Frl endpoint is detected
+}
+
+static void build_frl_mst_dsc_params(struct amdgpu_dm_connector *aconnector,
+								struct dc_stream_state *stream,
+								struct dc_dsc_policy *dsc_policy,
+								struct dsc_mst_fairness_params *params,
+								uint32_t frl_conv_dsc_bw_in_kbps)
+{
+	uint32_t min_bpp_x16, max_bpp_x16;
+	struct dc_dsc_config_options dsc_options = {0};
+
+	min_bpp_x16 = dsc_policy->min_target_bpp * 16;
+	max_bpp_x16 = dsc_policy->max_target_bpp * 16;
+
+	dc_dsc_get_default_config_option(stream->sink->ctx->dc, &dsc_options);
+	dsc_options.max_target_bpp_limit_override_x16 =
+			stream->sink->edid_caps.panel_patch.max_dsc_target_bpp_limit * 16;
+
+	if (dc_dsc_compute_config(
+			stream->sink->ctx->dc->res_pool->dscs[0],
+			&stream->sink->dsc_caps.dsc_dec_caps,
+			&dsc_options,
+			frl_conv_dsc_bw_in_kbps,
+			&stream->timing,
+			dc_link_get_highest_encoding_format(aconnector->dc_link),
+			&stream->timing.dsc_cfg)) {
+		// The timing can enable dsc
+		if (stream->sink->dsc_caps.dsc_dec_caps.is_vic_all_bpp && min_bpp_x16 <= stream->timing.dsc_cfg.bits_per_pixel) {
+			// with all supported bpp within the range limit
+			params->bw_range.max_target_bpp_x16 = min(stream->timing.dsc_cfg.bits_per_pixel, dsc_policy->max_target_bpp * 16);
+			params->bw_range.min_target_bpp_x16 = min_bpp_x16;
+			params->bw_range.max_kbps = (params->bw_range.max_target_bpp_x16 * stream->timing.pix_clk_100hz + 159) / 160;
+			params->bw_range.min_kbps = (params->bw_range.min_target_bpp_x16 * stream->timing.pix_clk_100hz + 159) / 160;
+		} else if (!stream->sink->dsc_caps.dsc_dec_caps.is_vic_all_bpp &&
+				min_bpp_x16 <= stream->timing.dsc_cfg.bits_per_pixel &&
+				max_bpp_x16 >= stream->timing.dsc_cfg.bits_per_pixel) {
+			// with selected bpp only within the range limit
+			params->bw_range.max_target_bpp_x16 = stream->timing.dsc_cfg.bits_per_pixel;
+			params->bw_range.max_kbps = (params->bw_range.max_target_bpp_x16 * stream->timing.pix_clk_100hz + 159) / 160;
+			params->bw_range.min_target_bpp_x16 = params->bw_range.max_target_bpp_x16;
+			params->bw_range.min_kbps = params->bw_range.max_kbps;
+		}
+	}
+}
+
 static void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
 {
 	int i;
@@ -1199,6 +1270,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	bool debugfs_overwrite = false;
 	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 	struct drm_connector_state *new_conn_state;
+	bool is_frl_endpoint_present;
+	uint32_t frl_conv_bw_in_kbps, frl_conv_dsc_bw_in_kbps;
 
 	memset(params, 0, sizeof(params));
 
@@ -1244,6 +1317,12 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
+		is_frl_endpoint_present = get_conv_frl_bw(aconnector, &frl_conv_bw_in_kbps, &frl_conv_dsc_bw_in_kbps);
+		if (stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported &&
+				is_frl_endpoint_present &&
+				frl_conv_dsc_bw_in_kbps &&
+				stream->sink->dsc_caps.dsc_dec_caps.is_frl)
+			build_frl_mst_dsc_params(aconnector, stream, &dsc_policy, &params[count], frl_conv_dsc_bw_in_kbps);
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
-- 
2.54.0

