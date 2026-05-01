Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE4CD3428
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2353110F552;
	Fri,  1 May 2026 14:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwH0gPD2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D3110F54C
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpsN0NHNLXjxyGocTQqKoW/C+4y/hNXmStYe1C8IH01s8qcmC/J1/F941cd6XkWPgnC45rl3irV9E9IsMbHuQuuKlARx7B91OPjMvS6JLcgbbO2Jr6/16bAFHNv4dqtAacakPEz2M+tfJwsfSaBUwRUwDCf2GY3ieFT5BU9j7pYrg3R6KdnPmIwwr6hzkD0u2aVmIGs2CPW5GB6DM96A0uLev2hlQPg0CFhIssC6ITQ8k7Q0Du4csOshRGpPG3GXogjo3Z/dOsaC+U8/F55G1uTGPqrI4Ba6IUBbTvUP/3KKJoEvI8gqJM2IY0nxWvLbBpoWP93CRl/NcUyNpayUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmzHOyyXJeoU94ZO15sAN9Abr41xRy9RPgxrM+apV4Y=;
 b=tROT1kQ6ZVbNd+gw4kS3OYsRS78F+UtB+Hz71bllNjVFek3O1odsFhzjXtMZoMlqtyj/8o2dp6D0UtYQJMCYgKXbd3iAKw5Cpe4ZAWrAIF5DwNrn0jYzPCUEVmUveAYycU+cbhSCxIs+g7VUZPsin7ph1Q0q7kcVGmZTnC43UiLSOsE3Nq8aLbQxXOSBjXBOi/3DhX/sOHL0JEDzypqRK/d25J5+1gAgYe9lMPwBkJmzk6+d7jsfxaf5bdak7F3nTrhpYtsLR3djPfPmr46uDZlj4lctJukSSWC2ORYAI7dZDpS1AIBmlP6J2UfuDtykjoS5Tus+DnITN0RpfiWqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmzHOyyXJeoU94ZO15sAN9Abr41xRy9RPgxrM+apV4Y=;
 b=uwH0gPD2KWoxVitA9N2DP1Xtua6a+fIIxnIm42FuU2Ndzy4PFFR8gl3Q/pNORvLhl9OU/HowmFnE4gT1FRmSLH29/5hsgLYmMwfjAO/rajhRk4F88xWb7hkSfq5ONG/M9XveqUJDsanGs1RLqvkpc8id+J6uU3NaOSMV9ZBQ2cE=
Received: from CH2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:5a::36)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 14:05:09 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::c1) by CH2PR08CA0026.outlook.office365.com
 (2603:10b6:610:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 1 May 2026 14:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 14:05:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 1 May
 2026 09:05:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 May
 2026 09:05:03 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 09:05:02 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 20/21] drm/amd/display: Tie FRL support into amdgpu_dm
Date: Fri, 1 May 2026 10:04:36 -0400
Message-ID: <20260501140441.41068-21-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501140441.41068-1-harry.wentland@amd.com>
References: <20260501140441.41068-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c67238-9266-4657-47be-08dea78aa7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8LgB0mASLVDmjpykZvFJSNcoScvKe4WElLgNysSMJ0lj1v1rW5S5E2279W5yDBuVJLGZJv18mPAn2y4dPyhYsi+CvVPxZWcQfqJT0Ccc5g4gO/QC6tnv9Sd12OBQgb0Dj13/pcS7hhl2eXYOufMLrQk90omJXTSsnbLPzkbX5bpT3YF2iyOrAuhCXVsLfJ59qLDK6gbVM+T8tmzUYF4vHwtCkXGflHRKT6YKqHM4MN6ZiL9C46t9rv4+t0ZkTv2QpAS392GFZx2Apj8PM7f51TL/fIluq0PQGc48y4ePJ12K+Aww4MsBWhKr+8XhmGhIxDmnlPFu79BWBhyk3Rq+b7GCiH0PsmCRjMh3tPTDZncaec1WNb5d9tvul4DM5EQmvYX1dhpS48uCQaQIhIAErmfBDAn6XYgEk4YizLSAD0A2MAxV1OuHaNOAICSM1EaKxzCzdRrHxb+3kLYOs+1MrW+QG0ot6Xerd5gdhY6UYcMahkWZIsovByAz5k5ll+ULW2eMJEBYC9iVI8iPB15NWYsjPifvp1POFvxMYWnWIvTDicRRIZ81M0gMTVd6yaWxol72FWXYZTMEQyh0gXAEf69F87Umi2C8aH3mi9iVN53WrALnhlQ3sX7JrrTBOW9xpr71HdIEs2dW6qM4sZyWI2w3rHhgLHvu82lHHduKzcFm+SiqJbUa1byBGVQM4Ce/Ig5nFJmKviShZZJupOIvG7aLAeAZSzwiydrrS3v8Org=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zLuhHefUV5Md842HhgCjcMz67lki15jTO6lvcDSl249QHrErdb6ZgtJ3Rrv75dFI+BsstzTQnHv7kn2zQPqru2p1QrBdq/uhIhqYseX2K9xLtu9476jxi6KoUYX+rchNt7oiDKXUFcDkQvklHOlGehN2FO+ItPRS61BzdB2UbRcWMZuRV9jSJYMaDXhnmZC7SWbBMbvb3sRxjCwuSlJ4JK6xnMfJZqe8ugSIgK3+t47sqkdvyn+fwpJ4SljW6VbX8xWeLYc5t5X7SQtdeEvd6F6eEanSseHBU3jUwvrZI4OjtS4B9bk9h7IL58Xbu2FwTsrsY+67aqXVoWqIgPs5aSYjEaj4S5WGwpyiZW9o/pKNsDe4WcDE9NQehr4MNMAgLwZUzQ1oFE8JZf2bH/DPA8LzbomRFhq0147D5N+1pdSjiIMcdzCScAduVIgUeTDe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:05:09.4555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c67238-9266-4657-47be-08dea78aa7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 62 +++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 10 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 23 ++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 79 +++++++++++++++++++
 5 files changed, 176 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 847f76d60228..f998a22b88ef 100644
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
@@ -8279,6 +8319,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 
 	if (aconnector &&
 	    (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	     aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_FRL ||
 	     aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 		bpc_limit = 8;
 
@@ -9175,6 +9216,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		aconnector->hdmi_hpd_debounce_delay_ms = 0;
 	}
 
+	dm->hdmi_frl_status_polling_delay_ms = 200;
+	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
 	 * which means HPD hot plug not supported
@@ -10818,6 +10861,25 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
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

