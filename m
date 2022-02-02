Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AC1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 18:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1585610E3D9;
	Wed,  2 Feb 2022 18:50:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8464A10E3D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 18:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3a4xtGNGqU5nxdVN+L0BvNZ3t9YZUZ0M8ow3RXFWug93mboudDQ5fFJ7V4QUaklxHNjDYNU7Sq6SqVu7+IM9/A/5QQO2HtCtvPLCQ77tQfRYC9Jf9lE0b/KWedeK7oumOBmdnHuB40oGNJbqOkGKpulm4QklFzOSdlWAQfqQtxJCkTweCUIad8nm+/4zGaYhhft3YlKNJo396Rl8DIyf2es4CeF4FaPfNtaq8wCY0yna75CR7Y1GtC1/LbmaxqnKyG4TO0I9rlm1JQgfihXsI+/FOeZyeRiW4UfTbfys8LT000EnBQK0VAyjhIvcMi7RJaJVC2RZtJyCgFQjkJRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MpJYLnAIloE84ZPfGq9lBikr323BNUdiM4ocJgMFZ4=;
 b=iYolA7bwXMUnnqD067HL1WhAjyFjBv5c9DT2noui9D3SX8gCwXZNBcAmM7qN+IeWndj79rxh7YoBhHmEgJbAG3vab0yBfqzR+85N1uiavMOVW2jCmAeTTVDHFRRNx8i7ws4DgyVE0udnaGu9w2ObFn/jhEkc989Kd8Ib7CclLgns75cu6sVOEChZjF8J/D2bru+VC+HaxgAu3Nq1M/1LTH7kt5QTSJR0jyvbo6xp6aNnXif+Csh7JK3Xp0EuF4SHy277cweAMT4rhLEbIr+6ecdVLGvXulHrLQE2MErNUrK5YCjcWdfntn2DWSEIHjAHda+r1ibpZfBzDiBB/WQXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MpJYLnAIloE84ZPfGq9lBikr323BNUdiM4ocJgMFZ4=;
 b=Y3VXsMqOC1sWVV0ay6GZSA1jn6Szvaz/5gcmiipUjHbFzHgRTQtvXQGNDtE7pf0Ps0xudmcNd3kalBn20B0/53y1+VQb8h3FNF0OKJkeyCF8cyrCCr8PgpYDCPUtcsINWGyBGPDFKyR0oOT8Eua/a6DSN/l7ufNALLQGYounc6o=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by DM6PR12MB3881.namprd12.prod.outlook.com (2603:10b6:5:148::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 18:50:07 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d1) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Wed, 2 Feb 2022 18:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 18:50:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 12:50:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 12:50:06 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 2 Feb 2022 12:50:00 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <wayne.lin@amd.com>
Subject: [PATCH] drm/amd/display: Handle removed connector in early_unregister
Date: Wed, 2 Feb 2022 13:49:56 -0500
Message-ID: <20220202184956.464527-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f32495a-b2e2-4220-416d-08d9e67cd503
X-MS-TrafficTypeDiagnostic: DM6PR12MB3881:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3881F274702FCC0C83393FEEE5279@DM6PR12MB3881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XIEHz0ghxs33NI3mVyZp3FFqD/KWcLBxTr9UxpjiMuV4UpTB4xlXPTYFU2eiNc+58YbDFvVCfYcR47gdOVpJOaCPGbPmkpvvF1vwBaM0UP3xoqckSbqCwSEN79C8B2hDC13y97FQjnSK+KGkxp/BCNn3F/jvfi+Jp4aRfWTuvtZzR8SEDSoJ5+nN0QU0GyG+H/yHdj3bf1/srl4jYk2SnuE4J/xc1Q53tBMffOlJ9Sp2cJ/Z1AmaMqtZgKbFnG/vjlgCrizZ1mZBUUlYu1y+Y3sth2nAR2DGZAxlujHSU4ydlpSFHPoU4r3PcClMgvewM0YP8WT+huwr2yeB7e6uAu8kkM+GI2ZLwOpO1XmT7DngL09FrYzaQTAvItBIrC8pcVmRrN/PKIn6MWA21NYQBitNZ81Kpek9g4ijtOUjB6IY5eukBbVNec4GgQYlB8SRLULS3hAZyfjkquqjZnkshM6RVr/jmfsTugIqBuSFQlqMBBtVMItxGAmfalbRq+FWtNGp6wqPBq7QLmeOJ20vHgvEx1U/PRZ4SvbdkD/d2O4H0ufGY6463qb4uCQLBF/RV/ApWj9zsPcb7eG+ZMqdlN4h2jcq4GojWhRYf89hv5ghrQ4+Rnw6KeT3WrJI+BXq7CtDaRl3R5l6HkVcH8VGn9NgWRYD0LLa/N+Pv2Zx1zHyJSVOjyRBhSaHGRZWBUYJg3PJOROrYiO7YkrNJzBTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(316002)(40460700003)(47076005)(356005)(86362001)(70206006)(6666004)(8676002)(8936002)(70586007)(110136005)(54906003)(4326008)(6636002)(36756003)(508600001)(7696005)(5660300002)(1076003)(426003)(186003)(26005)(2616005)(36860700001)(2906002)(82310400004)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 18:50:07.2948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f32495a-b2e2-4220-416d-08d9e67cd503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3881
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
commit "drm/amd/display: turn DPMS off on connector unplug" and
commit "drm/amd/display: Clear dc remote sinks on MST disconnect"
were trying to resolve the resource problem when we connectors get
disconnected under MST scenarios. However, these patches don't
really clean up all remote sinks. Nor turns DPMS off on all affected
streams. Also, these can't handle disconnected connectors reported by CSN.

[How]
- Revise commit "drm/amd/display: turn DPMS off on connector unplug"
a bit to handle none mst case only.
- Revert commit "drm/amd/display: Clear dc remote sinks on MST disconnect"
- Revise a bit the logic in above patches and change to turn DPMS
off/clear dc remote sink within amdgpu_dm_mst_connector_early_unregister().
Since drm will call .early_unregister for all disconnected connectors,
we can ensure to also handle disconnected connectors reported by CSN.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 41 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 12 ++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f5941e59e5ad..529b3ddaa10b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3034,6 +3034,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
+	enum dc_connection_type old_connection_type = aconnector->dc_link->type;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 	struct dm_crtc_state *dm_crtc_state = NULL;
@@ -3074,7 +3075,13 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_hotplug_event(dev);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
+		/**
+		 * MST cases are handled within .early_unregister where we
+		 * can handle disconnected conectors reported by long HPD
+		 * and CSN.
+		 */
 		if (new_connection_type == dc_connection_none &&
+			old_connection_type != dc_connection_mst_branch &&
 		    aconnector->dc_link->type == dc_connection_none &&
 		    dm_crtc_state)
 			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8e97d21bdf5c..411b55596b00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -139,11 +139,46 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
-	struct amdgpu_dm_connector *amdgpu_dm_connector =
-		to_amdgpu_dm_connector(connector);
-	struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
+	struct amdgpu_dm_connector *aconnector =
+                to_amdgpu_dm_connector(connector);
+	struct drm_dp_mst_port *port = aconnector->port;
+	struct dc_stream_update stream_update;
+	struct dc_stream_state *stream_state;
+	struct drm_device *ddev = aconnector->base.dev;
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct dc_link *dc_link = aconnector->dc_link;
+	struct dc_sink *dc_sink = aconnector->dc_sink;
+	bool dpms_off = true;
 
 	drm_dp_mst_connector_early_unregister(connector, port);
+
+	ASSERT(dc_link);
+
+	if (dc_sink) {
+			mutex_lock(&ddev->mode_config.mutex);
+			mutex_lock(&adev->dm.dc_lock);
+
+			memset(&stream_update, 0, sizeof(stream_update));
+			stream_update.dpms_off = &dpms_off;
+
+			/*set stream dpms_off*/
+			stream_state = dc_stream_get_stream_by_sink(dc_sink);
+			if (stream_state != NULL) {
+					stream_update.stream = stream_state;
+					dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
+											stream_state, &stream_update,
+											stream_state->ctx->dc->current_state);
+			}
+
+			/*clear the remote sink of the link*/
+			dc_link_remove_remote_sink(dc_link, dc_sink);
+			dc_sink_release(dc_sink);
+			aconnector->dc_sink = NULL;
+
+			mutex_unlock(&adev->dm.dc_lock);
+			mutex_unlock(&ddev->mode_config.mutex);
+	}
+
 }
 
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 57cf4cb82370..a77c90c14e85 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -739,3 +739,15 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			stream->link->link_index);
 }
 
+struct dc_stream_state *dc_stream_get_stream_by_sink(struct dc_sink *sink)
+{
+	uint8_t i;
+	struct dc_context *ctx = sink->ctx;
+
+	for (i = 0; i < ctx->dc->current_state->stream_count; i++) {
+		if (ctx->dc->current_state->streams[i]->sink == sink)
+			return ctx->dc->current_state->streams[i];
+	}
+
+	return NULL;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f631b61abedd..89f67c711161 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -321,6 +321,7 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
 uint8_t dc_get_current_stream_count(struct dc *dc);
 struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
 struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
+struct dc_stream_state *dc_stream_get_stream_by_sink(struct dc_sink *sink);
 
 /*
  * Return the current frame counter.
-- 
2.25.1

