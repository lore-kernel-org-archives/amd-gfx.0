Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 09:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5E610F52C;
	Tue, 10 May 2022 09:58:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2214810F52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuBhJU2bc4LAVKY4JPsW5xk2XJXFj0EgA6fifEupZW1lFF+fx8kx5kYv1hpmw5Rp2aPZSnsFzEPcpuw7D8/Y0MSTHQiyDwEvSgSSRHY1BmJuKGQBS849yD268UPRK9TFLMn0QJWEG90Ll3yrL7zuXDVSb1K1zAORNS2xB6gonoQX1uz7xI4gMHaE5Tl+06cUCTGgHMpX0JQyZ5+EM3rZO92hDB/lzU6KPuv20NVZ6JVKQrVZevhOMZoT8NimbR7//A3rlIiD5dekvyEYgl6JpfOhZJcpV8hLIdal0NMnfUsahn0jujKT55Li2YR+J/ML+mJobXom69YTcSUbNUTurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ20eZ8jn12AYr7znKhLOdjOSAnTW+rxGImwzrRSjVE=;
 b=mOI3oG99rrWidPWr7RHbB2c2N7GxQDvOqWfZjuY05Qj/nwQDQXYzMw+lIEb3Q3GameN8obgCFI/iR2rtINLsx/Kpr9gFOexYWpNEY5WoYdAsX+rGupeGRal9uwhkKm3wXUM7c+n0FjQQgXkEJaIGvsSN3rwc5L+GvYTF2WrkdU4XwRxxj079p7038mePgimLJsPiVPD4+MPDIJ4+ocCb6FDBi0gSA8q5WCOlXY2MGzf7YwxsTlb2nK+z4zjPzpnjAS0AFs0qIG0SB0HERSklLfWaZXN9BIo9y0FJ79c//skxr8OpcwcZwqF1McPzesPcFBxes+dSndnP1W1huIQt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ20eZ8jn12AYr7znKhLOdjOSAnTW+rxGImwzrRSjVE=;
 b=4UUhQpC9gMHxVSDGFV8yYhi4Jy/5oWG4R+U8VxuzwJfseIIc7A5wJvm+SgPOL0GkGi5OosfbCtCzONPWl/Ji2uUiiFo5aUnh27hZCMnsoaTiPtZcQMzimm6qi6/G8Az4BUHZtMmZlNJ89jYHJVQ7jaQe/BkrPArJxP1gdifAm9M=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 09:58:06 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::6a) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 09:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 09:58:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 04:58:06 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 10 May 2022 04:58:03 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Release remote dc_sink under mst scenario
Date: Tue, 10 May 2022 17:57:01 +0800
Message-ID: <20220510095701.57375-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510095701.57375-1-Wayne.Lin@amd.com>
References: <20220510095701.57375-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb70df0-53a3-4884-746c-08da326b94d9
X-MS-TrafficTypeDiagnostic: SN6PR12MB4623:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB462339676D3A53457D355C22FCC99@SN6PR12MB4623.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vs3jbomQfkrKoXzNchigrsmwSdgPo7yOWYJVx6ur7/0A0mN0nGoIIJ0Zhx85yFNz5DF0RQcJARTwN/C4HbAcbuhQ5q1uy1c0DVLRuIrM1+3QTROfTFZsMrcklCyDcQ6D4OO8iJ/wRxwYHknOSON/EWSQcFmig58PZtOoRHlW/5mtDPqJibGe/TYqO7aNzF/nxoA4qWmoO8Hg3hmjo9flRwtMo2kBE1Pwneznq3l8Iv5rEUbaDRCdrsF/zp2ubRtHrs6RXKqyumB0hh4bPai58twhuK2PMkAMPQFAlyj/uT8P/xxrmmR7SNO+rMM5EP+VgfX+KgF4xlcOOCNBRB1wd6x5q9N4AkFU0wXQsOgMN3AIGxeXwhFb4cHEIQsNRo4iL2XbT8E3z5sDRfE5PdSuUGipsXwdKVuWw5jE77320AHnUSH0i35n9WvCOcTaJ4cXwUUxo2BbUfnMCwjqBqIB22M5TY6OO4aj5IvLyEx9V2sm8e0tSUmPIAUk06a+zRIOxt1JTotfpY3ZD4EO9jQs1KaSpZScZ6e45vEwuhXL06za/1FjlEkGxQgOtmbwPNucW7R7VFbRp5vwZQvbN1tShBtwE7mnEjy/odWD92151B5B9xcLlN9TRRfxH0ioorh9GF64OWoD0GxRpR919RuK3ul0l/ExScEAppzafdH3oh+47FlPyjbu3Uq3HTP8bTuMxPlY5J2gtjqoFE6+nv54PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(36756003)(356005)(81166007)(8936002)(70586007)(70206006)(54906003)(4326008)(6916009)(8676002)(316002)(426003)(47076005)(336012)(40460700003)(36860700001)(508600001)(26005)(2906002)(5660300002)(186003)(86362001)(1076003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:58:06.5890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb70df0-53a3-4884-746c-08da326b94d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4623
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +--------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 39 +++++++++++++++++--
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d81b9ef11dba..f53f8962e6da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2191,7 +2191,8 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		} else {
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
-				drm_dp_mst_topology_mgr_set_mst(mgr, false);
+				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
 				need_hotplug = true;
 			}
 		}
@@ -10359,7 +10360,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * added MST connectors not found in existing crtc_state in the chained mode
 		 * TODO: need to dig out the root cause of that
 		 */
-		if (!aconnector || (!aconnector->dc_sink && aconnector->mst_port))
+		if (!aconnector)
 			goto skip_modeset;
 
 		if (modereset_required(new_crtc_state))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 28cf24f6ab32..e4fb19a68ccd 100644
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
index 0542034530b1..e0531a569a14 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -142,11 +142,28 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
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
@@ -346,12 +363,26 @@ dm_dp_mst_detect(struct drm_connector *connector,
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
+	int connection_status;
 
 	if (drm_connector_is_unregistered(connector))
 		return connector_status_disconnected;
 
-	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
-				      aconnector->port);
+	connection_status = drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+							aconnector->port);
+
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
+	return connection_status;
 }
 
 static int dm_dp_mst_atomic_check(struct drm_connector *connector,
-- 
2.36.1

