Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D295C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928D610E909;
	Thu,  3 Feb 2022 18:17:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED6B10E909
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYxlF2U9LeLmWxUQR8oOrnAeuxyDiqcOv6qRc9/2dvT4ZJ9b+LvkMH9JV5AfJr3uw3qwBAhmo1jWC0ir7A2Tm1mBvb8XAqAMCfrGOPTBOGIYQ3EYoTJHytFO94orNwBiht6BeI7HNGgHjSfBENyEQSUmmnomVkbnPfec6ce/3DvudA7qWtlsiFBXHfuvOgovNY9PTsvCxRDvoc7EeNH0Hdk6byZftr2+3Yo+Eu1hyVkjXs880125yqxNyBSGUd2Xb8y0S91OWJZGbfqzdOeCZ8XbZbsYagckgTtj5u/1gAS0vz/rzEXZrrs2uwVWbwFkzYWfsnMrr9uNjtCXe9s7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1IRJDqmE8swpc6YYnUE2D6zwGz3z25z6pWcsci4w5w=;
 b=llB59tMaxUwpOIz1tHI+LkklBGQda1OaEmqYPBg7k6nOzRcJ6AMD5chIp69/sa7cc74hdRtPw2mCWJJUMuWZibyD95u7Dabi6rvtvelIlc/NyGNvRy30sMTYgtXVrPxU/o5e9+qtke63THJ3zrsa8Uma9A6y5QGMZ5CZYhf/K01ta7MEFkowYNZHXCsN3OcZ8q+SiOMOBUgqqqgMDfQNVZsRdfgFHBOwIninnZzE2o+WrbYdE8B3RvKC0JZIQcfnKMZxyZuXyTY2UtqzAjRfjrAxxwnkV3jU4av/g55oCuonWL3vey1rI9a+jXAjvVmpv1ImVVHvJ89qzjau7uPaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1IRJDqmE8swpc6YYnUE2D6zwGz3z25z6pWcsci4w5w=;
 b=vVicc1xaE6DMSt1K2erKA+d/AaZ4W63c/EwUaJ6oHY7XV6CVws+ffgI4IOsA8nMBVbulVADZIEB217f/szlIsUV0ROWlZA466U5gIN3Wm2bRPAA54OA9LxrqrJ/Wqq6TctCJNkumyYMAuS9JCVwoAHgU8TIoQAwnbJZXb9lcRdg=
Received: from BN6PR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:405:4c::17) by MW5PR12MB5621.namprd12.prod.outlook.com
 (2603:10b6:303:193::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 18:17:36 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::92) by BN6PR1201CA0007.outlook.office365.com
 (2603:10b6:405:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 18:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 18:17:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:17:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 10:17:35 -0800
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Feb 2022 12:17:30 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <wayne.lin@amd.com>
Subject: [PATCH v2] drm/amd/display: Handle removed connector in
 early_unregister
Date: Thu, 3 Feb 2022 13:17:08 -0500
Message-ID: <20220203181708.473871-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5acd4e-4a47-45bd-47de-08d9e74174ae
X-MS-TrafficTypeDiagnostic: MW5PR12MB5621:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5621701FFD02076D88BEE58FE5289@MW5PR12MB5621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxo6YJ+RxMrgpua7DeK4oOsRmdpYiPkw/foOtgThkHWv5XttRwSkuydYjuqskL09+OSEIHcq+vWuC4ZMa+nCcIsNObbpZFyfiKLSy1MgQ2EcBPRc+7xe7FWVg1Q24XTO8wOxNiecvOJ9tOOMITkTC7PlBs8ncYo/GGqXqAsKR+gp4CkvjHUPnZu4aVCe3WLwwM5Qct6lNCHZAEHfZAzumGn0w+7KVjZk9RUpl9F9gW0aREVdO7fbIDxZq9khbi6zI/xunKTGsw1bbVvDRapL+fnNt6s2PYFWzWmKgDiubQ2KeAcGKIViY3d/Eu6ZDqJUgLASAYtGPghCl4ge4YPcmM7nqTqd86MKiP3bREATTASVlmoxmQWoGQlw9xFHyin+p64MZEBYc/DfS1xRO8vm4WhgjiYqIWiRZqhN3n0xId3/P70U1lzwpowQojUEIevL7xWkfDZq0oNldLHVDmFNiNxEj3KBvEYZ+TTr63aIiaEv1LCowJZB0VI8sY7pHWkzQnXLQpwCf0cJkvdebHwRABCBRUb8gEGH9QxWNACuyyhxl0LsebDSUDw/ORy7ndKyIG8/lpALQYQTUGZmnWJnjhS+Tczay/VY5t3aRPocT4WbuGjTIOypmNLF4baHx6NAJ2kvE5fnBf6BcniR475cJyyleTsug4xzW/Wx2f4kSdfDZfF+jvtrHyivP60a2RXOENt6USpkL9ttojJojYH09w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6636002)(36860700001)(70586007)(316002)(86362001)(2906002)(8936002)(4326008)(8676002)(81166007)(356005)(70206006)(82310400004)(83380400001)(6666004)(54906003)(1076003)(2616005)(40460700003)(186003)(5660300002)(426003)(36756003)(508600001)(110136005)(47076005)(336012)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:17:36.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5acd4e-4a47-45bd-47de-08d9e74174ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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

This patch lived in our internal branch since August
but somehow missed the merge to upstream.

Original patch description:

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
index 8e97d21bdf5c..7cd1f1f57d6e 100644
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
+		mutex_lock(&ddev->mode_config.mutex);
+		mutex_lock(&adev->dm.dc_lock);
+
+		memset(&stream_update, 0, sizeof(stream_update));
+		stream_update.dpms_off = &dpms_off;
+
+		/*set stream dpms_off*/
+		stream_state = dc_stream_get_stream_by_sink(dc_sink);
+		if (stream_state != NULL) {
+				stream_update.stream = stream_state;
+				dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
+										stream_state, &stream_update,
+										stream_state->ctx->dc->current_state);
+		}
+
+		/*clear the remote sink of the link*/
+		dc_link_remove_remote_sink(dc_link, dc_sink);
+		dc_sink_release(dc_sink);
+		aconnector->dc_sink = NULL;
+
+		mutex_unlock(&adev->dm.dc_lock);
+		mutex_unlock(&ddev->mode_config.mutex);
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

