Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A20FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D1210F2EB;
	Fri, 17 Jun 2022 19:35:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B222E10F2B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyhyXAFRgkVa9Uh+XtuxfkIlPXiUsWPhhfCAr+EZv6rl0L/XdSqQ5OfherICMPOA5FNA+OIM/6x8vDginj/ZAPKrD11Bak9LIXmIxA3KluCXyX+7owPfwsUNziE9xA4ZoOHXKXRxGuTeIZ8Lz9wpnGW20I6OdN4Z3rHVgHjp+S/vYdIicOzizlpRg/oUzH+C988BdUk9bYtTgLF551OYlyUTa1PmmQKTBVaQWLUYmA3anNrfs5hH2ZokNAUDSOYSDHkJ4UDQKGmmDDZCc66PZjWk47a1xoE/tkB3tMjMBpGRlKfthy3djNMicJVhEHRc6lhKDwVWYJTfOD5uERFFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quLNMBEFbHofYOtt98RWdCWJsVJzyzVQyoWZeZPJtpk=;
 b=nbvmv2PR534+dUWcR9PunEAfxexInfucM823JeTaK73g4GCR9rbDH+emHJMMMkPLjmvHrxwjQ6Ut+ApjLRG64f8Ssted3bus51NIuayDBlaKwQhHDBHDc25b0vF6knz0olxFtPLT1bHIiiqHEmz7HE+f0Y9avoNGHXn0ojfuPBOEJE0bdBLdzwnxdaKovEE0aj++PRXWgSH/Zu+1JPYAGD1uRsxhifi9/PvzwGaZIxrz9Um8HUVwVaqpHYpqHfRuxZGE4bP7OqZ6tULc1BLUuBoW/DJ56/v2RaX2ZMP8Myz/J/xfkfiwbUn4KxwLrrKm5FcxWG/r4BblBjiLhMNKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quLNMBEFbHofYOtt98RWdCWJsVJzyzVQyoWZeZPJtpk=;
 b=uScoVVwqHU60+oUtTMrH/7wOh6odgyfGKIf0VtjR6u0VKIsG4CqW+mVcqitoaw5Cz9SsmQHn+q8CgIn18IN0GzUFOxE5xpwraN3f+F9dLSGH1MNWBycgQiU9r6RGAOQQloF6fYz7AwXQm3oDZuCsTPkez9yoC//E8n10l95sORg=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:41 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::36) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:40 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/31] drm/amd/display: Release remote dc_sink under mst
 scenario
Date: Fri, 17 Jun 2022 15:34:45 -0400
Message-ID: <20220617193512.3471076-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5568eb4e-45f5-4cf0-d737-08da50989000
X-MS-TrafficTypeDiagnostic: DS7PR12MB5911:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5911ED213BB98FF5C0153ADF98AF9@DS7PR12MB5911.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I+Q/iQRKN001CIKnCt5dMWb92kzjO1spTTPHlCapKXiQhknXV+fASfmXkooz86gkIuleBNSBUpaObZ6J7fYqTfzvdqVltMAX6pHvkpeXnPigOAD8RyzEa93D4fsa8h/bjB3jhPM8OQd3lcueGXeTQHyyaScC03h1/HZ9AhDPlmaqkiiRhxxDEhHVitz38EGPjDoPBRCikVEcN1/SO5y+s/sebB3VLkVUpjqUeqIN5pQqjKdaJRdLpZGAF68nwj8mPlicCJWvywRCrvjEuf3cSoxROWCteJfz9YI98IkdknNyEklba8k1NSK0+G5zSgzijv8eSQ8jAIONF2favpjrjDytP2hyMIq0mUzSJvlqJnUn0lFsN5MSmpccIzvcRFQaSAXVTFtcbdmnpHZ6gCGTYZLrwu3ktJY4cJ//oiLdh5B391kmPuMxACdTHqUk3WK2W16V68nmUKPXj0gXIE00PfxJ1HxufZbe5JiiDTXZLXFWwqxq28UWsyWzFfkWQkbu3QFJcge2HJ3RlxbTz35jfKDVqk8KeIFWXZxj/klEPRSislzzrlNBcN1oejo/+hn098G+bkHtGV/nqiBIQlK2pSe7Rzbe9SAxDplAQFG9KnzCU+bqpSlshSqVhmNsVB5jd6Z/PCKRhUjVCUk30YqB/DQZDTQ8WoyVcnZphSPRjSAwfLAnA3+VdagwT4NOmU98mKn8udPE936FzQDDQuoZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(316002)(70206006)(5660300002)(54906003)(4326008)(70586007)(1076003)(2906002)(40460700003)(8936002)(82310400005)(498600001)(6666004)(16526019)(356005)(186003)(426003)(26005)(47076005)(6916009)(86362001)(81166007)(336012)(2616005)(83380400001)(7696005)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:40.6946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5568eb4e-45f5-4cf0-d737-08da50989000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Observe that we have several problems while releasing remote dc_sink
under mst cases.

- When unplug mst branch device from the source, we now try to free all
  remote dc_sinks in dm_helpers_dp_mst_stop_top_mgr(). However, there are
  bugs while we're releasing dc_sinks here. First of all,
  link->remote_sinks[] array get shuffled within
  dc_link_remove_remote_sink(). As the result, increasing the array index
  within the releasing loop is wrong. Secondly, it tries to call
  dc_sink_release() to release the dc_sink of the same aconnector every
  time in the loop. Which can't release dc_sink of all aconnector in the
  mst topology.
- There is no code path for us to release remote dc_sink for disconnected
  sst monitor which unplug event is notified by CSN sideband message. Which
  means we'll use stale dc_sink data to represent later on connected
  monitor. Also, has chance to break the maximum remote dc_sink number
  constraint.

[How]
Distinguish unplug event of mst scenario into 2 cases.

* Unplug sst/legacy stream sink off the mst topology
- Release related remote dc_sink in detec_ctx().

* Unplug mst branch device off the mst topology
- Release related remote dc_sink in early_unregister()

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +---------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 34 +++++++++++++++++--
 3 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0c90667f682a..c2fc32dac712 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2200,7 +2200,8 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		} else {
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
-				drm_dp_mst_topology_mgr_set_mst(mgr, false);
+				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
 				need_hotplug = true;
 			}
 		}
@@ -10599,7 +10600,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * added MST connectors not found in existing crtc_state in the chained mode
 		 * TODO: need to dig out the root cause of that
 		 */
-		if (!aconnector || (!aconnector->dc_sink && aconnector->mst_port))
+		if (!aconnector)
 			goto skip_modeset;
 
 		if (modereset_required(new_crtc_state))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 7c799ddc1d27..137645d40b72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -451,7 +451,6 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_link *link)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
-	uint8_t i;
 
 	if (!aconnector) {
 		DRM_ERROR("Failed to find connector for link!");
@@ -463,22 +462,7 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 
 	if (aconnector->mst_mgr.mst_state == true) {
 		drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, false);
-
-		for (i = 0; i < MAX_SINKS_PER_LINK; i++) {
-			if (link->remote_sinks[i] == NULL)
-				continue;
-
-			if (link->remote_sinks[i]->sink_signal ==
-			    SIGNAL_TYPE_DISPLAY_PORT_MST) {
-				dc_link_remove_remote_sink(link, link->remote_sinks[i]);
-
-				if (aconnector->dc_sink) {
-					dc_sink_release(aconnector->dc_sink);
-					aconnector->dc_sink = NULL;
-					aconnector->dc_link->cur_link_settings.lane_count = 0;
-				}
-			}
-		}
+		link->cur_link_settings.lane_count = 0;
 	}
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index bdfe5a9a08dd..d005bb6a2956 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -140,11 +140,28 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
-	struct amdgpu_dm_connector *amdgpu_dm_connector =
+	struct amdgpu_dm_connector *aconnector =
 		to_amdgpu_dm_connector(connector);
-	struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
+	struct drm_dp_mst_port *port = aconnector->port;
+	struct amdgpu_dm_connector *root = aconnector->mst_port;
+	struct dc_link *dc_link = aconnector->dc_link;
+	struct dc_sink *dc_sink = aconnector->dc_sink;
 
 	drm_dp_mst_connector_early_unregister(connector, port);
+
+	/*
+	 * Release dc_sink for connector which its attached port is
+	 * no longer in the mst topology
+	 */
+	drm_modeset_lock(&root->mst_mgr.base.lock, NULL);
+	if (dc_sink) {
+		if (dc_link->sink_count)
+			dc_link_remove_remote_sink(dc_link, dc_sink);
+
+		dc_sink_release(dc_sink);
+		aconnector->dc_sink = NULL;
+	}
+	drm_modeset_unlock(&root->mst_mgr.base.lock);
 }
 
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
@@ -351,7 +368,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		return connector_status_disconnected;
 
 	connection_status = drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
-				      aconnector->port);
+							aconnector->port);
 
 	if (port->pdt != DP_PEER_DEVICE_NONE && !port->dpcd_rev) {
 		uint8_t dpcd_rev;
@@ -385,6 +402,17 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		port->dpcd_rev = 0;
 	}
 
+	/*
+	 * Release dc_sink for connector which unplug event is notified by CSN msg
+	 */
+	if (connection_status == connector_status_disconnected && aconnector->dc_sink) {
+		if (aconnector->dc_link->sink_count)
+			dc_link_remove_remote_sink(aconnector->dc_link, aconnector->dc_sink);
+
+		dc_sink_release(aconnector->dc_sink);
+		aconnector->dc_sink = NULL;
+	}
+
 	return connection_status;
 }
 
-- 
2.25.1

