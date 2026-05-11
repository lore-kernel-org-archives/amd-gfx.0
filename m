Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792BDCD484C
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B24D10E7E2;
	Mon, 11 May 2026 15:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sk8I28Yz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD5010E7F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqZ33lz2P2s+o+B+0ajpildFw5XFcbC0wAfeVsnp9Sghr6BZAShkbns3SOrwgNS/OOaNPXpwBTv3zRDWZjfYKgDFAFMC+Pf47h2sS4XRJGIigum5/C8+eKQ/Pg90kwQvoxfS1Zi+qEHDJywlZ3hzkHaH70wpLKLg/4Mj5JME0h+ai3cnlVDVjfGej7dzMD+DH6BfyyAeEUec58hAaIfj5GOnsJE50SaVyL3f/j1/LfSkK9o6OVi0Jyr7ciJhNaeAuTNuIG4P1XvCNz2SqAHWKBygqh+yyyx9i2J85ENLADOUu25lGVpY673CebFhUHhdbm+Qs6XJazpNw2yIc7x8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvOnBDrvhwSCD2cdn5akr9nOnaL21wnsplI71rpUCB0=;
 b=q32sWCAxp52k7p/tTmJiKJefcdF5amQlN/sydaJ+Tnow2KOBHGZZJPQWYjK4i9UndxwhxbojJ4P7ptsilWMvV1GRbN+dc7S7Y+mN2e2XwSnKguhBnekMG2KyRTcCQebiq0Hqy6wxLJB27/PAKeNzA0oVVR1W6bF2/axgV/VlserVEqEBLQQ7jtgo43WoiU1GFI8QbbbLcqOwhRnVmvmXwGXowR2iDAkSC8UL9Ntqy7kNOoB2NC4Uc5/gSTJ7zEWaB5LS/VYOUujk42sC7RdKSyEZtMKCffIdMjlbZMS9tJx2JeH4DXcW/SR+sDUBs6sQj+sHkxODtFIaisVAekMgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvOnBDrvhwSCD2cdn5akr9nOnaL21wnsplI71rpUCB0=;
 b=sk8I28Yzq3L69ibcc2oOUV6h9IPcwYs8MbbZaOgZHWXzTiIZMgwVFSyuuBAOpygKDD/OX1t1YX3scg57WSm2D8Cj8W5or4LE7cdBKMDlzVHRlTaU9xUPSa+RiukEm5cgPjwQky+XSC/cb61dIfm1Ebyom5tYc8yZLuayWSP4+x0=
Received: from MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 15:52:30 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::43) by MN2PR16CA0051.outlook.office365.com
 (2603:10b6:208:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 15:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:52:25 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:24 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH RESEND v3 11/14] drm/amd/display: Tie FRL support into
 amdgpu_dm
Date: Mon, 11 May 2026 11:52:08 -0400
Message-ID: <20260511155212.73586-12-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: b19af712-56e5-40f9-abc1-08deaf754eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|11063799003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: /wrZ7RYB28NAsMSzjkR9zYQXP8GD52FlWTpsGFfTLGRIJR6m1nm3TSN4w0o4Z/inqBJWWAnirtYJWRni2i8o4H7zkiWOJ/HjMugXSPAgqb87AWMik/J7nocaMwGFDYShRX6sskbMNHzQG+XNhekAaHfjTwds1jn1yCCaTBL6BlzhaQRU9Ysoj9UiWY22Qh+4qgmqcGSkwBktBMHBCzMYGLsOtBAzsXqT2l2xqQ5LpkauHLCHO3c7tpXyOgL2BJ772hMq0wNhLEvvK+vx8zLETxgov0iZrPJ1c0luSPTke7GHkeGiYqgoCfkYYpjQgnFcp5vlilW8cayTieVQxka3o/LWyKbla165xtz0xyaZ8SI2xiXF1U2d9ePdq/q7mHVHHLbRWQoOy3WcmPt3U9SYptqh/dk3ZjuBiNZPIrpTvllGV6t2wJNgKxILBtPYb0xomaUq8bPTM5RVCH1eMgiTfJDQvbpmv5F+o+Zn1gEq+GHDqeNSyQUjigp0mhdAGKn3+KqA2T7PNe8Yr8ox4TxZwPNxBgLx49s7G7DZBJtsi+aiBWP+gOnYyE6wRM731zdpxW57wexDxOn3NMBqXAWZA/bksrcnY88NsgVgrFAJT4VRAkr1B7uuee7oFa+Fh6JZErEIErmMBP2RjEM9/jFN+sCS6NWiZk1+bE24trt/JiQx3L+qB1L3SEXFG37QOHXdq5e591W9q/rQNHj6vOwmEP8g9bqByWEtnkuotXug1rI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(11063799003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CHynvpMcCXH70Y+6ajk83zPsNs1AtQ6iSXIORlG8RO0wiXwCYFSPCj/Opkt4DEhdzDmprHhKMJjKter50Ft46/VxlMzeA6z4n2YZlLlDcsXOfNEsGnfVSaKU/dtEARmYkggK515IsI57YHQiaUtNZU6G1oGnP2tMlRufqvWG4qLsh6qsJk1xoxrhexM0MQ0J6JGHprO6A+qEztuuhyXfELE3kp9n825M2H2UlE6+W4GQlnqH2Z0M37Jo+WUw4r+gbY7X2JyK27VdtMdQQWTS3Q2Qo5SHlUd3dUrPDrF5xuGxOeixG3H3OcqZLmmbhS7HOBWQBCVd76vDnwko+7HApdB3D3VOw6RrSz2wMWJxIuM3/+K2lpEPm5zXj+A9O9klYqjrWuVar9tx670g6OJj7mo3C/+SMV6FOOEglU5DFWcA4hnl5fkES5zDmM3eKN5G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:29.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19af712-56e5-40f9-abc1-08deaf754eac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

