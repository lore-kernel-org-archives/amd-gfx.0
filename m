Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEC6C021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D65F10ECC1;
	Fri, 14 Feb 2025 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qBBkfkTc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47EE10ECB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6xthPiJ+tU41OCVLc60+FwUbmp0O1ICVIjAVMlM7fErGRiwxpJNbyJW/Ei6hRlSoTYOij8kLW7Ar773JygQjfqhPxKtJu7obuKzgxUSiwvM0B+dydujOMjs13oa5X2qQGhqEtNHNMR0/uwGTwk1d7KJO3t/3KzTlsB1cE5Zgxyz4jU6N4S+H1osrj04aW2apom6CW5N0pQxKPIAjLOFars+ZDQDOsHPNYZFQY1aCKRT2gMkT2bRWmaixkU/cIMkkNqz4GxsKn4hYb1UzZ4wXVoIcMuIHcW5ElK9nIFoLTFay0J/kPqdnD8czo/2WIuyeOXw+ztGbuw/NyxECVTzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJwNRYJW3/Nqvhci8hRAVb6t8dgsR2XSjp43VSuPfc=;
 b=mEXV4xVhvLgSQAj4g51E6uSS/eSz68lDjjzpanZtqV77f2FZaTgXNQgGQaVDvkz7fWUttEN8qAQPu4B/eEIoGg+5sKbUHk/0vUVy4/Izn7a1tJi/atyvg4IgA/GAinbWImHC5fuS8WXN69jIl9Fs8q5r7HnAllcaYdXtigLcD/VuyKZsor2BAaXbbYeiWcZYEIQbaRKrP8cN2CC9OLvW7AHdfm7nfvxSNJ7i1zMlCdP95qm1adK4Eh01+g95pTg4Kqd1u/fdIMK4nXA+ZYlDy0umWhs1ApvZm7LMwOC79DBBGjvJqLTwpirdCsATiGVmwkTHKbtvd3/Gdhp7s7x/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJwNRYJW3/Nqvhci8hRAVb6t8dgsR2XSjp43VSuPfc=;
 b=qBBkfkTc2uxq2zCBZmY0uj7vrX62uBMulyXvBGS/4whd6s+GaTSEg255EsjWIRKXF39DRmhlG73HkQiEGab9L1xwNUgl0U3FG+3n8ngnyIY940RE8QVHR0YzISqGc0urbLGpNawRZAoJt9iBvbqzE9PqQ1GqVSsyVPsQoCzBgcY=
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 15:01:36 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::99) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:32 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:31 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Don't treat wb connector as physical
 in create_validate_stream_for_sink
Date: Fri, 14 Feb 2025 10:00:19 -0500
Message-ID: <20250214150033.767978-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 53624b21-3f5f-4a69-78b2-08dd4d0879f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Vjv7Wte+co40LOxAzkKwlJ9ac/UvmIfKetDFV1Qmi8QdVoXc3uSlq/XUFFn?=
 =?us-ascii?Q?n02lzOBKKJLX+LHcabEVywGS+Nb12k2IPQPAPJm7TpdWIGY2wGOqOeBWkYrS?=
 =?us-ascii?Q?3nMlopo/c6dhIdbETpDzCYbUXl/zZxOccNACsCd0345IkpHVZ8GSnlAhqNDb?=
 =?us-ascii?Q?eh9UmOxgAHZethcECKz1ykDdh40O0sKMyVBxe1Vb5qIpDGtd4aTIB3ZH8trA?=
 =?us-ascii?Q?nlwsu3L5GFYjG/R9PUagR2a8zbvckdU5FPHQhcTGIvc4kI86guV7TBrp4yFF?=
 =?us-ascii?Q?EvI+tQGnb9M8Cv+qcH6i8KcmohN/uYhvFMFgiCraI8tQBim17eCvyAFvhRVB?=
 =?us-ascii?Q?NmcrVviYAe/Pq0iXtMQnnUz5cZhTIQtyefAPo32S7S8jzjafq0CIhfejmKQk?=
 =?us-ascii?Q?xYeiLgAFfK5sWC4xSI+H4HGu0C6yRqygigjKrUnhHvcVhK4BG3FZoMiWkbNj?=
 =?us-ascii?Q?ZwCGpAVmekWy4U9zZ88kwolkUscv/oa6iNE8oCRrHYa79w6AZaD9uNHbiUXH?=
 =?us-ascii?Q?1VTyE+13JZBn6gkLgF5S4kbdcRIXzeKNypP4csLA085KlmpSt+4w97TgVNWO?=
 =?us-ascii?Q?yfInAGmYrkwU5o/xD4tIGikGvf36OrKIlVnKiOS6zktjp/JzbVI6DZ2LbO34?=
 =?us-ascii?Q?RcNHjnH2bwNMtysKQ/86lliiQKBfPmcXFK8gg2bocSDFZqNVcz212zOwfbxn?=
 =?us-ascii?Q?nUCrL3jjBq6YH2EB3uc2EdeFh1uTxxX55ZtePRbN4seda4KdRfZPBYXWKWi3?=
 =?us-ascii?Q?2mRF5T1xx7HYEWchbdF+/bJfMN4KTshkWOgQ1e0/Ts3YVYXjO0UF3HMLi0/K?=
 =?us-ascii?Q?bntJ7QfH8k5+EtEHbCoJjkLeFNo0noK7q22Qi1uD8Y63euRgjpRCjbq+71GL?=
 =?us-ascii?Q?8Rt3C6tfWtdmKUYG7zMPIRoVa/4CHnQYNtDXNSsOjDxfdmW96mUXYdqv+uM8?=
 =?us-ascii?Q?ifqKwBI3DLEiv5KJEEMV+mP5Wd1UVxGhLcPAqKxwagxhptGv8Ba9AdHImeTc?=
 =?us-ascii?Q?yTlEkAaheJqBUBq1736oh6jvYEV9eJ3YqiXVZEs1sa823PQRzYkBessZtq1b?=
 =?us-ascii?Q?QQ7G3jTiTX3SbVZ9aV2s859l5zXssajdZIOntyZns554APwSA5yIsWGJY0/R?=
 =?us-ascii?Q?xbUQZfacR82rXtJ5gO1QCUTkWveiN7WPT46/TbgJPZFIpUrJkKxmWFp+3zco?=
 =?us-ascii?Q?cnXITxsvUZTp8/xKb2TOZklh9yoXb4mCJzolkM//5lAqGVc3pH62BydSFyqg?=
 =?us-ascii?Q?+xGuV3tJdt9/NpghohQbiZjEnFG4XOGO9L0Tzh9vvwyy++1ozTtkJuxUVJp8?=
 =?us-ascii?Q?oC7scbvKOz1f8dyvPnVlpzha8DYqqSTvt8r7WWaydeQ0ElyrzYp78pNVL8NE?=
 =?us-ascii?Q?+6tx/dp0xHzR0JBxHTLOgtzjObV8w8BsgVEj3cZm1wu5w1fhDP8q/ToZldCx?=
 =?us-ascii?Q?jzbs0bZ9hvqluZkHd0zPNjrTEUpMyTQMzP6SBcru3krf5bs4AhKfrewlBRQO?=
 =?us-ascii?Q?uBO6iHwg6hya8g8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:35.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53624b21-3f5f-4a69-78b2-08dd4d0879f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

From: Harry Wentland <harry.wentland@amd.com>

Don't try to operate on a drm_wb_connector as an amdgpu_dm_connector.
While dereferencing aconnector->base will "work" it's wrong and
might lead to unknown bad things. Just... don't.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b26ae1dd1fd7..b1b5f352b9aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7448,12 +7448,12 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 }
 
 struct dc_stream_state *
-create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
+create_validate_stream_for_sink(struct drm_connector *connector,
 				const struct drm_display_mode *drm_mode,
 				const struct dm_connector_state *dm_state,
 				const struct dc_stream_state *old_stream)
 {
-	struct drm_connector *connector = &aconnector->base;
+	struct amdgpu_dm_connector *aconnector = NULL;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dc_stream_state *stream;
 	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
@@ -7464,8 +7464,12 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	if (!dm_state)
 		return NULL;
 
-	if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-	    aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+		aconnector = to_amdgpu_dm_connector(connector);
+
+	if (aconnector &&
+	    (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	     aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 		bpc_limit = 8;
 
 	do {
@@ -7477,10 +7481,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			break;
 		}
 
-		if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		dc_result = dc_validate_stream(adev->dm.dc, stream);
+
+		if (!aconnector) /* writeback connector */
 			return stream;
 
-		dc_result = dc_validate_stream(adev->dm.dc, stream);
 		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
 
@@ -7510,7 +7515,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				     __func__, __LINE__);
 
 		aconnector->force_yuv420_output = true;
-		stream = create_validate_stream_for_sink(aconnector, drm_mode,
+		stream = create_validate_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream);
 		aconnector->force_yuv420_output = false;
 	}
@@ -7525,6 +7530,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	struct dc_sink *dc_sink;
 	/* TODO: Unhardcode stream count */
 	struct dc_stream_state *stream;
+	/* we always have an amdgpu_dm_connector here since we got
+	 * here via the amdgpu_dm_connector_helper_funcs
+	 */
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) ||
@@ -7549,7 +7557,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 
 	drm_mode_set_crtcinfo(mode, 0);
 
-	stream = create_validate_stream_for_sink(aconnector, mode,
+	stream = create_validate_stream_for_sink(connector, mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);
 	if (stream) {
@@ -10600,7 +10608,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			goto skip_modeset;
 
-		new_stream = create_validate_stream_for_sink(aconnector,
+		new_stream = create_validate_stream_for_sink(connector,
 							     &new_crtc_state->mode,
 							     dm_new_conn_state,
 							     dm_old_crtc_state->stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ef60e80de19c..f3bc00e587ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -996,7 +996,7 @@ int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int
 					struct set_config_cmd_payload *payload, enum set_config_status *operation_result);
 
 struct dc_stream_state *
-	create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
+	create_validate_stream_for_sink(struct drm_connector *connector,
 					const struct drm_display_mode *drm_mode,
 					const struct dm_connector_state *dm_state,
 					const struct dc_stream_state *old_stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e096fb562122..0d14a0d5def3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1624,7 +1624,6 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 
 		if (ind >= 0) {
 			struct drm_connector *connector;
-			struct amdgpu_dm_connector *aconnector;
 			struct drm_connector_state *drm_new_conn_state;
 			struct dm_connector_state *dm_new_conn_state;
 			struct dm_crtc_state *dm_old_crtc_state;
@@ -1632,15 +1631,14 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 			connector =
 				amdgpu_dm_find_first_crtc_matching_connector(state,
 									     state->crtcs[ind].ptr);
-			aconnector = to_amdgpu_dm_connector(connector);
 			drm_new_conn_state =
 				drm_atomic_get_new_connector_state(state,
-								   &aconnector->base);
+								   connector);
 			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
 			dm_old_crtc_state = to_dm_crtc_state(state->crtcs[ind].old_state);
 
 			local_dc_state->streams[i] =
-				create_validate_stream_for_sink(aconnector,
+				create_validate_stream_for_sink(connector,
 								&state->crtcs[ind].new_state->mode,
 								dm_new_conn_state,
 								dm_old_crtc_state->stream);
-- 
2.34.1

