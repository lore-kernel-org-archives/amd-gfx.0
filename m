Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DB9C27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDD010E3C6;
	Wed, 16 Aug 2023 21:30:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242B010E3C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY781NSf8HSTyTGpF4CFSkOG0NbJNvZ/+Z+9z4Mnl4UYNLgoLb9SCf6ON2E7a7UadwkBC0H8FiqxgC+b4AHB8HYju0iTsSKo9NHUg2n+WssSq4mWivSTmzGfqTCPcLtJxz1vCUfmZn/iRb54x8siJ+kKDAex+5/KIh9nsCQwiMfAjkuksOfYApGvrFc8bcJ1vvEKrNZaPT+cEiYcpu19ciA1OSTBhQOYu+V4xVEPzbwXBGDl3MZnoqCH3Deny0pChyLOlibS/54L0M7smLa3DE2170CBdGqSYpU7uZm0x/QCh36VL89HwUIE7T/5N2YtAuLFQ3n+mTnPPjX7OY/Gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnmv8ByWbTF5zIxywzI/+Ax4b3/Zr5ZaD2jWp6JMteA=;
 b=OfFFptYEnFrIvXE92FP2fGq8gYOMAVNMwFUN6T8xRIWXQSCj5U4TE9RCtCCMeBq3c1Uvu526moCGode36sYkyIE6OPq383wDBDiHWsL1If9wv+CWdX8rm6DVykgjJZilFHNx+kmtV3a11Aeubr+BIsbe98xer0lBwFRNzFHL9MKXRjBS/WvZ3mmVu9wEWiSAvmZ6lbnhjYFw92UNkXgy4hRx18hBswPC0975G6fKLLL/t2mVIRyicfUQBc+SQvAjZF3TK8bMMrfu0RpZ1QXtBU194iTtAiJ1tTQ2+kZi/qNTJlNxH4W25c+ORJfQLdlRs1Xp+X7f1sbhlAfFvHbErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnmv8ByWbTF5zIxywzI/+Ax4b3/Zr5ZaD2jWp6JMteA=;
 b=djEkdoyXrRDu3s8nEA5L9v9+L+jBGKaogypgFGjQ122OlRXvIGdqlv+tWPkcNuYSKldFe2qmqO2k8arD/f6EHZ9NBxhW2jCWp6K00f1XWgTws87W8iGirI2cGE13HAVMicx5fTp+GrtsuDUhYfyq7uroz3g7uWawzPVyyv1iQU0=
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:30:02 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::e4) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:30:02 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:30:00 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/18] drm/amd/display: Use drm_connector in
 create_validate_stream_for_sink
Date: Wed, 16 Aug 2023 15:26:15 -0600
Message-ID: <20230816212626.987519-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2489c8-1d1a-44c9-6605-08db9e9ff34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwymoecqjl8+kuxfHasVR9g+kUQbNxYhKaUeGWDzFE7vTi7jOez4zMMCIkpd8srPcQUmLdj5lATL182+BpW4N6CiySvzBIY56F+zKu3KSbIfkqItB3xbsxfTz+m1JMUMHwJr6KYahJdAQSHuNpqZD3te9g+yuzcyyDuvN+Hrn/6Og/bUIQgKaeOGpUgaXWn4O39d7yLe0UM6rb91k3pouxXBHiny6qo0iOpBSjBg4/X9b4rMiO/B7BWacEqks1lXgDjZ6Hbl8JoWgKH3Lfk2WIZN8SHDcK42jtv91lw5AIQAGIIsrVEvjh6qUUBb8GGcb6pLVYhm9P3SEhX44EiBYYqZwThUDAdbU6SZNCMBRArTxH6Z17XX8o/v5m8J2oxU9xQr25vOHzc+0wXr0lKPBnSlL3YGIjl9KggSF0v930Mev2w/utorYpGlR7lfo9Z8kQ4f+D/IvUeYI9I3+xzQu+a5GYKoxfzJR++Mqi6d0wkA0yhV7cJ88p29V1Ij996qCkWCfzPGLpm9F6cSQnqVMrEfchUTlGVgQyfo1Yjr4DxRZMdb+AC3z4Blag2AeyCXTDBde/QEgUCTPrKoCY1rSzV3IIWzPUPmZZI74HbdEX2q+8sKxgTYlFEwIrwD+STOxqtn4dirbzxZtG0gxY7oGH+3QYKvXm7nuoZ4dqCML4atILaFf8Mjvh0lxI6aOQJpYQoXnOdnwCovEMQgojsd5eKgGa2uLzAPUrrh4+xOKXR0WkElb32Y8oipzGv9viBZrvPGqUbzSt0d9NgmLuP9/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:30:02.1109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2489c8-1d1a-44c9-6605-08db9e9ff34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
Again, we need to use this function for writeback connectors,
which are not of type amdgpu_dm_connector. Use the common base
drm_connector instead.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++---
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a7d2a3f35f74..33e7c463a0d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6546,18 +6546,21 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
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
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		aconnector = to_amdgpu_dm_connector(connector);
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
@@ -6568,10 +6571,14 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		}
 
 		dc_result = dc_validate_stream(adev->dm.dc, stream);
+
+		if (!aconnector) /* writeback connector */
+			return stream;
+
 		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
 
-		if (dc_result == DC_OK)
+		if (dc_result == DC_OK && connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
@@ -6593,7 +6600,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		DRM_DEBUG_KMS("Retry forcing YCbCr420 encoding\n");
 
 		aconnector->force_yuv420_output = true;
-		stream = create_validate_stream_for_sink(aconnector, drm_mode,
+		stream = create_validate_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream);
 		aconnector->force_yuv420_output = false;
 	}
@@ -6608,6 +6615,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	struct dc_sink *dc_sink;
 	/* TODO: Unhardcode stream count */
 	struct dc_stream_state *stream;
+	/* we always have an amdgpu_dm_connector here since we got
+	 * here via the amdgpu_dm_connector_helper_funcs
+	 */
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) ||
@@ -6630,7 +6640,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 		goto fail;
 	}
 
-	stream = create_validate_stream_for_sink(aconnector, mode,
+	stream = create_validate_stream_for_sink(connector, mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);
 	if (stream) {
@@ -9304,7 +9314,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			goto skip_modeset;
 
-		new_stream = create_validate_stream_for_sink(aconnector,
+		new_stream = create_validate_stream_for_sink(connector,
 							     &new_crtc_state->mode,
 							     dm_new_conn_state,
 							     dm_old_crtc_state->stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5a8d07a27e9b..a2d0ab881c44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -828,7 +828,7 @@ int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int
 bool check_seamless_boot_capability(struct amdgpu_device *adev);
 
 struct dc_stream_state *
-	create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
+	create_validate_stream_for_sink(struct drm_connector *connector,
 					const struct drm_display_mode *drm_mode,
 					const struct dm_connector_state *dm_state,
 					const struct dc_stream_state *old_stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1975b9d96cb8..687dba32cde3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1495,7 +1495,6 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 
 		if (ind >= 0) {
 			struct drm_connector *connector;
-			struct amdgpu_dm_connector *aconnector;
 			struct drm_connector_state *drm_new_conn_state;
 			struct dm_connector_state *dm_new_conn_state;
 			struct dm_crtc_state *dm_old_crtc_state;
@@ -1503,15 +1502,14 @@ int pre_validate_dsc(struct drm_atomic_state *state,
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
2.41.0

