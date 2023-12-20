Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E6EC46CD8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DC610E5F2;
	Wed, 20 Dec 2023 16:37:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E610110E5F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIlKUbwHDvsX5YZcmi9TWJkzJzlWp+6oNR9azDy8nmP+E1WdJQxFXAt1S41FPSUGVIG0rJHN7A9yIrsX72RitkItOBHjn/DLp/cfS0CyT5lFtzwcpwpAMGdMgS1dvvrNqy7S+ZO5Bml2TPot7Fvpt90K2fQc3+IEeH+zGmKIkHpYOUNNe0l3fTDYbHKcFy54z/WGr9EAvfVmDbhwobiTGZiakziUsM12L8+SvKUajOGzzh/qN7v60PV+vUFesSwCk+LiTqMyjqgDAd8hZMEjarP4z7LHZsShRpA5RXaF2ChxX6uiLEcEYlwgVdKJde8jvd9tDDNKzC75yE8zcuCZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5LTZwmAx5AwmGCA3+3D8QUarFq80Wj/4C5hWHPKDSs=;
 b=RyTMacBfvAhrPGCLO0HuJP3tSPcQS9MXN7m6Eow7mKE+P+KTYMooeWVbrjRb6DYHz79l7FbDQS8c3DoiF8u+xSp9k1/WiqwS2+YJVh99u/iMMfDGMc3uaXOL+3J7IXoKUyE7ngKGedViqF3iQLBGr8nEL+uMMgStBiO7Hh8IiIHx/hzkZfapYkXmIj5hYdwXvwOGnpMknbyt9lKBS5fwVWsvjsgpjASGyBmW03h4lIiTe/iSVTp97JdmHMvG/pdB4WGtCf/c/9GIoJcLBRsPA1bc+FA0bh6/GNx7dBEEaakA02ABnf8wObtyUcMcovyDKJQHCMQNcENX5bXik3fUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5LTZwmAx5AwmGCA3+3D8QUarFq80Wj/4C5hWHPKDSs=;
 b=p1FTzK6VsUTAMVhfinb7RnyuOIeDHLiPJcFTESueANJZsehsso2crH2Z6Pq7uu8Es5qC3BVJw9PMxKMWTeMVJuWuv+JmJzPTHV/CK5Y4ObqNZ+LspHW64f2J8iqFj9YtrCLuZntp7HZUB+Gw3LLkOYz/2PCTQTIEhKJxI1a2iuw=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:10 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::25) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:04 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/20] drm/amd/display: Add dpia display mode validation logic
Date: Wed, 20 Dec 2023 09:33:46 -0700
Message-ID: <20231220163538.1742834-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a95e7e4-91c3-47a6-ca0f-08dc0179e9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6H6LkW4kXP/ws50PNNSghgTlmczw3H8mkbx0SQfgj93gekiRFcDxDBeZ+NfJKCYJjQuJTp69HRhvGcBsPLar+JAUFGjc1l8tgSFuBR0C24BI26A2C593hy1zt+7HuIyu2ryrB+n9kXgDDZeUKCQpMOjYU9C/zaNu+6DeAgiMUFLEbgttjIJDsDUbUTEKi5rcB2eRYV75C8tUTzgO89FWI/ljQgUDYLRmk3jT5m6506PhMjCMZI7V1+8mD9vsFesUSAxkKk5cOoPrs+/O8R1uIKYZzTx87v92GYiPjNdy1HdrilMXcve4/8EpGCTtc9JkMNTe5jr3K+DOQGAgjV8XVxz985ZHW7xGYNKmBQJ/N0ZtmNkeLlhgAq58AzNSDaWRm6KPBZOR1e7YkigbihQMkZ32R0g5U3F+BULOHkbDq5TAAbhDVKdFkWbjyHvht0LQhW7W46G2E3m62EWm3tXwnDAwLycy+fSc/0tmJK8NPsJMPA6ou7hBaEAhyIwQv+ZvIOXM6KOUs3aK97ucLj68GDTZz+bmORobzWmks6/jBKITrlKA/isJlRuTdIr650i3x9NTUt8EGHLpLROLUIfIfa0/4IkLEHXMm74SWBZlmd+6YUYsI6IuaFkYDMaBwFjneWcqZ0zoNvzNLcnJGh5/tCeRUgnptHm51HCPsNw+TjbSMYZFn41sPwFsIH3/tOqwxizVoQEuR0N0uIPtT47Jn1+MWh0tYDTyaQ5iH767IjHhOKKsWgo5dcSPAGjW+ruEiTvYi+kVZZeMTBKjbKcDmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(356005)(47076005)(40460700003)(426003)(16526019)(66574015)(83380400001)(336012)(2616005)(1076003)(26005)(86362001)(36756003)(82740400003)(81166007)(478600001)(6666004)(316002)(6916009)(54906003)(70586007)(70206006)(30864003)(4326008)(8676002)(8936002)(5660300002)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:10.6185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a95e7e4-91c3-47a6-ca0f-08dc0179e9e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, PeiChen
 Huang <peichen.huang@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
If bandwidth allocation feature is enabled, connection manager wont
limit the dp tunnel bandwidth. So, need to do display mode validation
for streams on dpia links to avoid oversubscription of dp tunnel
bandwidth.

[How]
- To read non reduced link rate and lane count and update
  reported link capability.
- To calculate the bandwidth required for streams of dpia links
  per host router and validate against the allocated bandwidth for
  the host router.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../dc/link/protocols/link_dp_dpia_bw.c       | 130 +++++++++++++-----
 5 files changed, 104 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index ed94187c2afa..f365773d5714 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -497,7 +497,7 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 	link->dc->link_srv->enable_hpd_filter(link, enable);
 }
 
-bool dc_link_validate(struct dc *dc, const struct dc_stream_state *streams, const unsigned int count)
+bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *streams, const unsigned int count)
 {
 	return dc->link_srv->validate_dpia_bandwidth(streams, count);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c2ee80d6f64c..565de7428b6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2172,11 +2172,11 @@ int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
  *
  * @dc: pointer to dc struct
  * @stream: pointer to all possible streams
- * @num_streams: number of valid DPIA streams
+ * @count: number of valid DPIA streams
  *
  * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
  */
-bool dc_link_validate(struct dc *dc, const struct dc_stream_state *streams,
+bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *streams,
 		const unsigned int count);
 
 /* Sink Interfaces - A sink corresponds to a display output device */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index eeeeeef4d717..1cb7765f593a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1377,6 +1377,12 @@ struct dp_trace {
 #ifndef DP_TUNNELING_STATUS
 #define DP_TUNNELING_STATUS				0xE0025 /* 1.4a */
 #endif
+#ifndef DP_TUNNELING_MAX_LINK_RATE
+#define DP_TUNNELING_MAX_LINK_RATE			0xE0028 /* 1.4a */
+#endif
+#ifndef DP_TUNNELING_MAX_LANE_COUNT
+#define DP_TUNNELING_MAX_LANE_COUNT			0xE0029 /* 1.4a */
+#endif
 #ifndef DPTX_BW_ALLOCATION_MODE_CONTROL
 #define DPTX_BW_ALLOCATION_MODE_CONTROL			0xE0030 /* 1.4a */
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 870cd3932015..4f276169e05a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1151,6 +1151,8 @@ struct dc_dpia_bw_alloc {
 	int bw_granularity;    // BW Granularity
 	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
 	bool response_ready;   // Response ready from the CM side
+	uint8_t nrd_max_lane_count; // Non-reduced max lane count
+	uint8_t nrd_max_link_rate; // Non-reduced max link rate
 };
 
 #define MAX_SINKS_PER_LINK 4
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index d6e1f969bfd5..a7aa8c9da868 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -59,6 +59,7 @@ static void reset_bw_alloc_struct(struct dc_link *link)
 	link->dpia_bw_alloc_config.estimated_bw = 0;
 	link->dpia_bw_alloc_config.bw_granularity = 0;
 	link->dpia_bw_alloc_config.response_ready = false;
+	link->dpia_bw_alloc_config.sink_allocated_bw = 0;
 }
 
 #define BW_GRANULARITY_0 4 // 0.25 Gbps
@@ -104,6 +105,32 @@ static int get_estimated_bw(struct dc_link *link)
 	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 }
 
+static int get_non_reduced_max_link_rate(struct dc_link *link)
+{
+	uint8_t nrd_max_link_rate = 0;
+
+	core_link_read_dpcd(
+			link,
+			DP_TUNNELING_MAX_LINK_RATE,
+			&nrd_max_link_rate,
+			sizeof(uint8_t));
+
+	return nrd_max_link_rate;
+}
+
+static int get_non_reduced_max_lane_count(struct dc_link *link)
+{
+	uint8_t nrd_max_lane_count = 0;
+
+	core_link_read_dpcd(
+			link,
+			DP_TUNNELING_MAX_LANE_COUNT,
+			&nrd_max_lane_count,
+			sizeof(uint8_t));
+
+	return nrd_max_lane_count;
+}
+
 /*
  * Read all New BW alloc configuration ex: estimated_bw, allocated_bw,
  * granuality, Driver_ID, CM_Group, & populate the BW allocation structs
@@ -111,13 +138,20 @@ static int get_estimated_bw(struct dc_link *link)
  */
 static void init_usb4_bw_struct(struct dc_link *link)
 {
-	// Init the known values
+	reset_bw_alloc_struct(link);
+
+	/* init the known values */
 	link->dpia_bw_alloc_config.bw_granularity = get_bw_granularity(link);
 	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+	link->dpia_bw_alloc_config.nrd_max_link_rate = get_non_reduced_max_link_rate(link);
+	link->dpia_bw_alloc_config.nrd_max_lane_count = get_non_reduced_max_lane_count(link);
 
 	DC_LOG_DEBUG("%s: bw_granularity(%d), estimated_bw(%d)\n",
 		__func__, link->dpia_bw_alloc_config.bw_granularity,
 		link->dpia_bw_alloc_config.estimated_bw);
+	DC_LOG_DEBUG("%s: nrd_max_link_rate(%d), nrd_max_lane_count(%d)\n",
+		__func__, link->dpia_bw_alloc_config.nrd_max_link_rate,
+		link->dpia_bw_alloc_config.nrd_max_lane_count);
 }
 
 static uint8_t get_lowest_dpia_index(struct dc_link *link)
@@ -142,39 +176,50 @@ static uint8_t get_lowest_dpia_index(struct dc_link *link)
 }
 
 /*
- * Get the Max Available BW or Max Estimated BW for each Host Router
+ * Get the maximum dp tunnel banwidth of host router
  *
- * @link: pointer to the dc_link struct instance
- * @type: ESTIMATD BW or MAX AVAILABLE BW
+ * @dc: pointer to the dc struct instance
+ * @hr_index: host router index
  *
- * return: response_ready flag from dc_link struct
+ * return: host router maximum dp tunnel bandwidth
  */
-static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
+static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_index)
 {
-	const struct dc *dc_struct = link->dc;
-	uint8_t lowest_dpia_index = get_lowest_dpia_index(link);
-	uint8_t idx = (link->link_index - lowest_dpia_index) / 2, idx_temp = 0;
-	struct dc_link *link_temp;
+	uint8_t lowest_dpia_index = get_lowest_dpia_index(dc->links[0]);
+	uint8_t hr_index_temp = 0;
+	struct dc_link *link_dpia_primary, *link_dpia_secondary;
 	int total_bw = 0;
-	int i;
-
-	for (i = 0; i < MAX_PIPES * 2; ++i) {
 
-		if (!dc_struct->links[i] || dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
-			continue;
+	for (uint8_t i = 0; i < MAX_PIPES * 2; ++i) {
 
-		link_temp = dc_struct->links[i];
-		if (!link_temp || !link_temp->hpd_status)
+		if (!dc->links[i] || dc->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
 
-		idx_temp = (link_temp->link_index - lowest_dpia_index) / 2;
-
-		if (idx_temp == idx) {
-
-			if (type == HOST_ROUTER_BW_ESTIMATED)
-				total_bw += link_temp->dpia_bw_alloc_config.estimated_bw;
-			else if (type == HOST_ROUTER_BW_ALLOCATED)
-				total_bw += link_temp->dpia_bw_alloc_config.sink_allocated_bw;
+		hr_index_temp = (dc->links[i]->link_index - lowest_dpia_index) / 2;
+
+		if (hr_index_temp == hr_index) {
+			link_dpia_primary = dc->links[i];
+			link_dpia_secondary = dc->links[i + 1];
+
+			/**
+			 * If BW allocation enabled on both DPIAs, then
+			 * HR BW = Estimated(dpia_primary) + Allocated(dpia_secondary)
+			 * otherwise HR BW = Estimated(bw alloc enabled dpia)
+			 */
+			if ((link_dpia_primary->hpd_status &&
+				link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) &&
+				(link_dpia_secondary->hpd_status &&
+				link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled)) {
+				total_bw += link_dpia_primary->dpia_bw_alloc_config.estimated_bw +
+					link_dpia_secondary->dpia_bw_alloc_config.sink_allocated_bw;
+			} else if (link_dpia_primary->hpd_status &&
+					link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) {
+				total_bw = link_dpia_primary->dpia_bw_alloc_config.estimated_bw;
+			} else if (link_dpia_secondary->hpd_status &&
+				link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled) {
+				total_bw += link_dpia_secondary->dpia_bw_alloc_config.estimated_bw;
+			}
+			break;
 		}
 	}
 
@@ -194,7 +239,6 @@ static void dpia_bw_alloc_unplug(struct dc_link *link)
 	if (link) {
 		DC_LOG_DEBUG("%s: resetting bw alloc config for link(%d)\n",
 			__func__, link->link_index);
-		link->dpia_bw_alloc_config.sink_allocated_bw = 0;
 		reset_bw_alloc_struct(link);
 	}
 }
@@ -397,7 +441,7 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 		if (!timeout)
 			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
 		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
-			ret = get_host_router_total_bw(link, HOST_ROUTER_BW_ALLOCATED);
+			ret = link->dpia_bw_alloc_config.sink_allocated_bw;
 	}
 	//2. Cold Unplug
 	else if (!link->hpd_status)
@@ -439,29 +483,41 @@ bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
 {
 	bool ret = true;
-	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 };
-	uint8_t lowest_dpia_index = 0, dpia_index = 0;
-	uint8_t i;
+	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 }, host_router_total_dp_bw = 0;
+	uint8_t lowest_dpia_index, i, hr_index;
 
 	if (!num_dpias || num_dpias > MAX_DPIA_NUM)
 		return ret;
 
-	//Get total Host Router BW & Validate against each Host Router max BW
+	lowest_dpia_index = get_lowest_dpia_index(link[0]);
+
+	/* get total Host Router BW with granularity for the given modes */
 	for (i = 0; i < num_dpias; ++i) {
+		int granularity_Gbps = 0;
+		int bw_granularity = 0;
 
 		if (!link[i]->dpia_bw_alloc_config.bw_alloc_enabled)
 			continue;
 
-		lowest_dpia_index = get_lowest_dpia_index(link[i]);
 		if (link[i]->link_index < lowest_dpia_index)
 			continue;
 
-		dpia_index = (link[i]->link_index - lowest_dpia_index) / 2;
-		bw_needed_per_hr[dpia_index] += bw_needed_per_dpia[i];
-		if (bw_needed_per_hr[dpia_index] > get_host_router_total_bw(link[i], HOST_ROUTER_BW_ALLOCATED)) {
+		granularity_Gbps = (Kbps_TO_Gbps / link[i]->dpia_bw_alloc_config.bw_granularity);
+		bw_granularity = (bw_needed_per_dpia[i] / granularity_Gbps) * granularity_Gbps +
+				((bw_needed_per_dpia[i] % granularity_Gbps) ? granularity_Gbps : 0);
 
-			ret = false;
-			break;
+		hr_index = (link[i]->link_index - lowest_dpia_index) / 2;
+		bw_needed_per_hr[hr_index] += bw_granularity;
+	}
+
+	/* validate against each Host Router max BW */
+	for (hr_index = 0; hr_index < MAX_HR_NUM; ++hr_index) {
+		if (bw_needed_per_hr[hr_index]) {
+			host_router_total_dp_bw = get_host_router_total_dp_tunnel_bw(link[0]->dc, hr_index);
+			if (bw_needed_per_hr[hr_index] > host_router_total_dp_bw) {
+				ret = false;
+				break;
+			}
 		}
 	}
 
-- 
2.42.0

