Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92535C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 17:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D5710E98E;
	Thu,  3 Feb 2022 17:48:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A1110E98C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 17:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYtKsQ+nzniwskJridEnO7xznCHmq5BZGR1dtTzZyzjLMKNmbN8Az6BUjEP8q8fVnF/JJy9UX4dMBfz/pToVJFVTKXroa6mDS5wNmO0c0qeuhlYOrCqNfsl115Z7dYEpHfOuq1yg/OVoY0Rxnc/C7gKZVg3n1HGm/BpfYXYCdb12ECzjAQNIdX/MmUjiLvYg1sPZ4tiCP5YESxzWWQ0Ojj3t6b6+7eMp/AwC/jF7WMxhryCwMPdxC60zWdAo9UiWc+zs0ZDTj2evEaam/F1UBwjZlGOLVgmCssSfLOy6fAFKncnIkSpZQwB1QzKyJ1CnqsEhMh+LiuAx3UkX+nKjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlV0ugBs4xY9WWN/ZSqvw/KY+THPU6ph+c79r65UWbE=;
 b=U9qy3D1J86gaTecmxqw7l+w5HOSSMlG5gdXS0XH7tPaZvppAJN6BF/wTisQi+0BIypEJ1Mo/Of5h0IYj+mKBjVsTIpRH7lWz6jo0NSa04WoRbIV1qHq/nLM8aVD/0KnlG9NBFfUMARGb4da97sWSGmdpfnUJQ9QqfqCrL3ssNzafnqx5oySycHp0k/pu3oDBJffZ7gS97mNBRIy/avIZRcuTubA1TWq5GcXBWUvK96364Riuvn/q5nRUJdJrNlcIZ4YBP61JwSyWnef+3PJhtfoSIel0dcm2a0AU7dZH2kMcuuu/IhAWf7sTC0RqRe4zi5jhpnougdd3bZuDXwntEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlV0ugBs4xY9WWN/ZSqvw/KY+THPU6ph+c79r65UWbE=;
 b=Juqsnk4Tu0BIrBwoRMOcp4lbP97WijQ9n1oxkH7acP3bLCSw2yjT3bcIccjjOxRPf+EkHPUo9UVRU7g9BuBDsG7r2rl5cBIFI+X04ppm0lj9iM+A3tuJI7ajV33QGxADR9X1VjXfZE2nhjIf92S1klre+RHwrqq3n4n+8WTHl/0=
Received: from DM5PR18CA0070.namprd18.prod.outlook.com (2603:10b6:3:22::32) by
 MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Thu, 3 Feb 2022 17:48:10 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::77) by DM5PR18CA0070.outlook.office365.com
 (2603:10b6:3:22::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.13 via Frontend
 Transport; Thu, 3 Feb 2022 17:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:48:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:48:09 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Feb 2022 11:48:03 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <wayne.lin@amd.com>
Subject: [PATCH] drm/amd/display: Handle removed connector in early_unregister
Date: Thu, 3 Feb 2022 12:47:59 -0500
Message-ID: <20220203174759.472973-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e506ce2-0bc9-4329-5af3-08d9e73d57a5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1328C61091D969D243AE4BDAE5289@MWHPR12MB1328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twTRE0IqxveR9rFhJVujxgIFfdc2Px1Q1+h7W5uwi5bhXz7YeO+v2rPMaYWAi5Mk0mF2K+gVeNHd+G4Bn9u4oPeh5Tc60/Jghcyq3w5vBpukV8o2AjaGaqwGuwomGw4QuoHDA2m/28JBCwrSBf3zDVcfe2+qC9kcuO93cxtJE0ubH5o88vV7TnBQrTImgj+teKRqmiyJzQ3u2Lzy3x/MScATpuzdp3OygABM9UrN2Jaa+3YBtttS32RNmzzO9aO4m74Run0ci5QTEwPqsI7gX9vHlucf3hC60fOZe9PepOnT5/Opl1RgGNcXhlPHKsJZTKTzcEhiPLUewVh6CHa+vj0du4BX+bjFhCXDtYRk/jkH1JDoxrWMsVDayxMGGM7Ut2C7eIXVFMFkOLvYCVAJ1vImENzqLb5ygB7H9MlxLYO/0Y7mGIbuKb7JVUe0qLuisAp0KxdwajHnW5oQuWtvNcWPmrYqQd2GQsgfKWFC2bHVzKQLPjmy214PBn+jOEm3f/k7FfOI51ldQ5+XJugrc/evsCU/cu0w3isXx4wAOxTa56rMRoIk4gmZNd3tuB6Y7Ph9JbfD01fD8SxWYICGq6ymN8dkKEdVM7kwcIdXQGPNRyvWBaAxHRTjWhmb2yRIg2cHJUwffaGVTh4AR2Ss/1TNg5ec1S7hHRJ6jSctNT9w+bRRMBlelfOhutFLL86Sm1wiUI9NlvTmfmbKpp44Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(47076005)(316002)(86362001)(6666004)(7696005)(54906003)(508600001)(6636002)(110136005)(82310400004)(5660300002)(70206006)(70586007)(1076003)(2616005)(426003)(26005)(186003)(336012)(8936002)(8676002)(81166007)(4326008)(83380400001)(356005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:48:09.8018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e506ce2-0bc9-4329-5af3-08d9e73d57a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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

Original Patch:
(dc: Handle removed connector in early_unregister)

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

