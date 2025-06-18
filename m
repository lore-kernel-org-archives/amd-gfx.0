Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC6C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4AB10E8BA;
	Wed, 18 Jun 2025 15:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDs8rbT1";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E0C10E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQqdPA9haHOWXJRwTMllt7uy+kmi9GhtcGjdD8gVqm2dSBrnY46Y1JwUJN/coJgCKReKICquti9teRRYhWyrvadqRN4HUQG0Xj/G5Zp7nzO2siYUhgy30S9XbgqWXm1rbcYOQ/s1jdEo0obgtlrWhF90Pn4Hed4O+XF0JMbd/E3WQrlolLuawSWZj4DC/DCEzQ0HfJNDXLRf4aRTE2BJofMm+Fu2+oR4L1TCghXFpqkED54si4IcRntMINNW64uDAawQ4TdSHC7k1DNVRRRJ7gcOjJfIECoTZ0VOoytZC9VXfj86gNEec7CVhppWZe1jh8BA5W01S6NJdooEp0xJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSshKK8vZxHKTmork9o2xyJv7eCXhnvk0XVWWKvKGT0=;
 b=Lsbot6GDFKkTy8DPr3Rff2mUeED5+N2E987nuuRP8783zeWluCWc2ICgKTs3Ro51y+2n0mopnhdeS/zWUrILwjM91rfAV50SF9APTNVAn2SFyWf8NZ/rWxjDzF2z0KUStWiKyE+Ss1b7qvkXL3NQHHrsS7gIbL3lSUXGY9nuRJSRQYpStoQ13N2Djz4+gy39U6QtwTQiPQyeVoubCLJoljR7q9OEsmOWyDBcpcRzMqJwSJ1/9iZB1cF+sNw5nfeFNbOWPVluDqE8bbIMaauHx5SsxzluhrhyFuAaYesDIY+QyPqy52M1XUS3e2fJ/JZ7G6+68mP/OKBf/1KQHCoRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSshKK8vZxHKTmork9o2xyJv7eCXhnvk0XVWWKvKGT0=;
 b=vDs8rbT19cyO+VwHp4r9Mucup4r/4DNvA6Ec/u9nnv16npDBO+PoPOrI72VGxBL7UL2m5b/wfXtu3IyWG+C49R9btabnNVgMhV1paxnjFPbUHKB2Apv4yT+NueU7zekM1mxBLGoTAakU0tpioC7TkUMIWUhrNgVFOMyLVlO/hSc=
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 15:54:51 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::e3) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Wed,
 18 Jun 2025 15:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:50 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:49 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, PeiChen Huang <peichen.huang@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Add new DP tunnel bandwidth validation
Date: Wed, 18 Jun 2025 11:33:51 -0400
Message-ID: <20250618153936.6472-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: d6819ecd-6bc6-4a9c-6ae1-08ddae8075e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?abmt2DDcCGVm8IgKeeDyjHeVGYTT9plrmauW0NOdvuaekWpgfyN0ntQ/7Wj1?=
 =?us-ascii?Q?FJLKa3P1XWeBKvLlIvoNrWYsVBFXkWNdCic7wvFur0+UNBM8jt9o62rW759r?=
 =?us-ascii?Q?FTze6ZWZ36RdaAsRG0KDjpy0oUsJ93FIfLkozFvZLEaXY4SBUHH1R37gwUti?=
 =?us-ascii?Q?6URMYfK/lqbDLk8xM2geM+v+O2mJ5WPKAeK8BZBdi194t8CiJ0YgH40FJtul?=
 =?us-ascii?Q?5jy5za/5dUqihLfnWQYlT5goPKWcNZmMbgMfsFhXTEniabaYfvWhwUXIWoh9?=
 =?us-ascii?Q?LsHBKlMZaS+P2JaD3hKNjvIBHeX39ixv0XPlWrefkZjnSe/5eDVJEOYq0RXY?=
 =?us-ascii?Q?R5yjo6gGfkD2gHSuACBlRVASaCPCQijX5vZTwNwBZpuLE1vHkAk5lRxYcWx4?=
 =?us-ascii?Q?4cztIwlmdY9gA/8o0vwTvOWJKXvzWxFx11VosEzgFwFGAn56uxRdVDzHsVVB?=
 =?us-ascii?Q?dT0tHGQgFqEzaeL0ILSsKNTRd/wduHD8fNO1bJ+kGvIyNl3zcs5aWK+fyqR1?=
 =?us-ascii?Q?neu7p1/dUu9l7NksVjWlTgtbHjk2fgDhKZ3g6mwKWx3lYOERJevPs3TJJwM3?=
 =?us-ascii?Q?0eAQ+Iq3secp73AXAnA/XoazFb/HnM5R6jy8/WMmW3B9rrxr8Ogj/aSCk8yc?=
 =?us-ascii?Q?5iS484grF1OLsMSvg7bKEgYeqN3+BBOX4J7m/GkyrC+55kfXo7Y49qipgKr/?=
 =?us-ascii?Q?ixXJBUsZFqIX+xwZPJm7+OM0o5Ea8/n6piXp/6RtaCO5i1aRak/DTXp4SrrM?=
 =?us-ascii?Q?ZWXa8MYuaSBkh9iHLap/+PaVetE2FEqxXCGed/PVm1IggKSLUADQWoDuqt4j?=
 =?us-ascii?Q?mdpwfSC8ZSzGjNbT1lwEZt2AcmBernh+Gy8aj55PQZL5SWRlZEk1OJ0H5Z7y?=
 =?us-ascii?Q?cNN8+k/qay0Y8G8Fr36jG6c8jJX/eG18Tq2o4nS8/X99Pp2PDdjjfDdx3tuy?=
 =?us-ascii?Q?uGoOtDZJ9dgGXZclw/3lyOlLz64/1LLXrwlsmYvYALgAswjo0yFdrXt4hS4J?=
 =?us-ascii?Q?VOe/dsTl0tXMSeYApWpFokjFNM1JD94gx+78OG2LEsj0IP3jxzCa7AXmLbbH?=
 =?us-ascii?Q?pEule+53GwsDqjVeVzcxJMVYHHNkH+p2PE/+VpnJyyeivtAb3NJ53iUNnIxN?=
 =?us-ascii?Q?xD9qG7ezKIZ2rtB8dRTNiSyK/iWje9ECWv61oOqZb5PCKeBrRb7+BYsdSyNE?=
 =?us-ascii?Q?CM235buetGRlm7HxP0mLCU6RgyKG/KCSNDrwipelSqq+Ja69m8bfe9zwPJRp?=
 =?us-ascii?Q?dkcycLoRzzQsHpPowMHkj3oiJacXwb4Z5NJ6A4c1d5762y/V1ypeFlRcYDfU?=
 =?us-ascii?Q?GbjmYB/WF6IsaCzkjTWwIQmHvbuBHE8KgBhxWf3Ry4JGtV2AbFDRiOVo1Y7d?=
 =?us-ascii?Q?TMeXGuUF2wPONciWk8iD1YliOP0b0lKx5TZV6WAy5fBwba72OACjirNdTCqH?=
 =?us-ascii?Q?weHzFZ415US+RI2YiSjhTcctBl2mbVINRP1YOgrJ1XJ9P5Hwz+C9vNcpML60?=
 =?us-ascii?Q?6fllSokcARc4LClC/+kFB0SwtWvKj5m3vMB6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:51.2925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6819ecd-6bc6-4a9c-6ae1-08ddae8075e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why & How]
Add new function for DP tunnel bandwidth validation.
It uses the estimated BW and allocated BW to validate the timings.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  14 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  15 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c |  85 ++++++++-
 .../drm/amd/display/dc/link/link_validation.h |   3 +
 .../display/dc/link/protocols/link_dp_dpia.c  |  15 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 169 ++++++++++++++----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  27 ++-
 14 files changed, 302 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 7551d0a3fe82..bbce751b485f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -268,6 +268,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "Insufficient DP link bandwidth";
 	case DC_FAIL_HW_CURSOR_SUPPORT:
 		return "HW Cursor not supported";
+	case DC_FAIL_DP_TUNNEL_BW_VALIDATE:
+		return "Fail DP Tunnel BW validation";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 71e15da4bb69..90c595e88aa0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -519,3 +519,9 @@ bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *strea
 {
 	return dc->link_srv->validate_dpia_bandwidth(streams, count);
 }
+
+enum dc_status dc_link_validate_dp_tunneling_bandwidth(const struct dc *dc, const struct dc_state *new_ctx)
+{
+	return dc->link_srv->validate_dp_tunnel_bandwidth(dc, new_ctx);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 44aed03c37f2..f5df271c8d1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,10 +68,12 @@ struct dmub_notification;
 #define MAX_STREAMS 6
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
-#define MAX_HOST_ROUTERS_NUM 3
-#define MAX_DPIA_PER_HOST_ROUTER 2
 #define MAX_SUPPORTED_FORMATS 7
 
+#define MAX_HOST_ROUTERS_NUM 3
+#define MAX_DPIA_PER_HOST_ROUTER 3
+#define MAX_DPIA_NUM  (MAX_HOST_ROUTERS_NUM * MAX_DPIA_PER_HOST_ROUTER)
+
 /* Display Core Interfaces */
 struct dc_versions {
 	const char *dc_ver;
@@ -2427,6 +2429,14 @@ void dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
 bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *streams,
 		const unsigned int count);
 
+/*
+ * Calculates the DP tunneling bandwidth required for the stream timing
+ * and aggregates the stream bandwidth for the respective DP tunneling link
+ *
+ * return: dc_status
+ */
+enum dc_status dc_link_validate_dp_tunneling_bandwidth(const struct dc *dc, const struct dc_state *new_ctx);
+
 /* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index d346f8ae1634..5ce1be362534 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -162,6 +162,11 @@ struct dc_link_settings {
 struct dc_tunnel_settings {
 	bool should_enable_dp_tunneling;
 	bool should_use_dp_bw_allocation;
+	uint8_t cm_id;
+	uint8_t group_id;
+	uint32_t bw_granularity;
+	uint32_t estimated_bw;
+	uint32_t allocated_bw;
 };
 
 union dc_dp_ffe_preset {
@@ -957,11 +962,21 @@ union usb4_driver_bw_cap {
 	uint8_t raw;
 };
 
+/* DPCD[0xE0021] DP_IN_ADAPTER_TUNNEL_INFORMATION register. */
+union dpia_tunnel_info {
+	struct {
+		uint8_t group_id :3;
+		uint8_t rsvd :5;
+	} bits;
+	uint8_t raw;
+};
+
 /* DP Tunneling over USB4 */
 struct dpcd_usb4_dp_tunneling_info {
 	union dp_tun_cap_support dp_tun_cap;
 	union dpia_info dpia_info;
 	union usb4_driver_bw_cap driver_bw_cap;
+	union dpia_tunnel_info dpia_tunnel_info;
 	uint8_t usb4_driver_id;
 	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index a8afbe5eaf1d..b203ed020cd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1378,4 +1378,11 @@ enum dc_validate_mode {
 	/* validate the mode and get the max state (voltage level) */
 	DC_VALIDATE_MODE_AND_STATE_INDEX = 2,
 };
+
+struct dc_validation_dpia_set {
+	const struct dc_link *link;
+	const struct dc_tunnel_settings *tunnel_settings;
+	uint32_t required_bw;
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index f3696143590c..82085d9c3f40 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -59,6 +59,7 @@ enum dc_status {
 	DC_FAIL_DP_PAYLOAD_ALLOCATION = 27,
 	DC_FAIL_DP_LINK_BANDWIDTH = 28,
 	DC_FAIL_HW_CURSOR_SUPPORT = 29,
+	DC_FAIL_DP_TUNNEL_BW_VALIDATE = 30,
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 7d16351bba99..c92f11095254 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -147,6 +147,9 @@ struct link_service {
 	bool (*validate_dpia_bandwidth)(
 			const struct dc_stream_state *stream,
 			const unsigned int num_streams);
+	enum dc_status (*validate_dp_tunnel_bandwidth)(
+		const struct dc *dc,
+		const struct dc_state *new_ctx);
 
 	uint32_t (*dp_required_hblank_size_bytes)(
 		const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index f16cba4b9119..e15631bead09 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2295,12 +2295,10 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 		}
 
 		link->dpia_bw_alloc_config.remote_sink_req_bw[sink_index] = bw;
+		link->dpia_bw_alloc_config.dp_overhead = link_dpia_get_dp_mst_overhead(link);
+		req_bw += link->dpia_bw_alloc_config.dp_overhead;
 	}
 
-	/* get dp overhead for dp tunneling */
-	link->dpia_bw_alloc_config.dp_overhead = link_dp_dpia_get_dp_overhead_in_dp_tunneling(link);
-	req_bw += link->dpia_bw_alloc_config.dp_overhead;
-
 	link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 1a04f4b74585..3ef2013508a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -101,6 +101,7 @@ static void construct_link_service_validation(struct link_service *link_srv)
 	link_srv->validate_mode_timing = link_validate_mode_timing;
 	link_srv->dp_link_bandwidth_kbps = dp_link_bandwidth_kbps;
 	link_srv->validate_dpia_bandwidth = link_validate_dpia_bandwidth;
+	link_srv->validate_dp_tunnel_bandwidth = link_validate_dp_tunnel_bandwidth;
 	link_srv->dp_required_hblank_size_bytes = dp_required_hblank_size_bytes;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index e2235fd32998..5b88a1c48dac 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -263,6 +263,14 @@ uint32_t dp_link_bandwidth_kbps(
 	return link_rate_per_lane_kbps * link_settings->lane_count / 10000 * total_data_bw_efficiency_x10000;
 }
 
+static uint32_t dp_get_timing_bandwidth_kbps(
+	const struct dc_crtc_timing *timing,
+	const struct dc_link *link)
+{
+	return dc_bandwidth_in_kbps_from_timing(timing,
+			dc_link_get_highest_encoding_format(link));
+}
+
 static bool dp_validate_mode_timing(
 	struct dc_link *link,
 	const struct dc_crtc_timing *timing)
@@ -411,13 +419,88 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 	for (uint8_t i = 0; i < num_dpias; ++i) {
 		int dp_overhead = 0;
 
-		dp_overhead = link_dp_dpia_get_dp_overhead_in_dp_tunneling(dpia_link[i]);
+		dp_overhead = link_dpia_get_dp_mst_overhead(dpia_link[i]);
 		bw_needed[i] += dp_overhead;
 	}
 
 	return dpia_validate_usb4_bw(dpia_link, bw_needed, num_dpias);
 }
 
+static const struct dc_tunnel_settings *get_dp_tunnel_settings(const struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	int i;
+	const struct dc_tunnel_settings *dp_tunnel_settings = NULL;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (context->res_ctx.pipe_ctx[i].stream && (context->res_ctx.pipe_ctx[i].stream == stream)) {
+			dp_tunnel_settings = &context->res_ctx.pipe_ctx[i].link_config.dp_tunnel_settings;
+			break;
+		}
+	}
+
+	return dp_tunnel_settings;
+}
+
+/*
+ * Calculates the DP tunneling bandwidth required for the stream timing
+ * and aggregates the stream bandwidth for the respective DP tunneling link
+ *
+ * return: dc_status
+ */
+enum dc_status link_validate_dp_tunnel_bandwidth(const struct dc *dc, const struct dc_state *new_ctx)
+{
+	struct dc_validation_dpia_set dpia_link_sets[MAX_DPIA_NUM] = { 0 };
+	uint8_t link_count = 0;
+	enum dc_status result = DC_OK;
+
+	for (uint8_t i = 0; (i < MAX_PIPES && i < new_ctx->stream_count); i++) {
+		const struct dc_stream_state *stream = new_ctx->streams[i];
+		const struct dc_link *link;
+		const struct dc_tunnel_settings *dp_tunnel_settings;
+		uint32_t timing_bw;
+
+		if (stream == NULL)
+			continue;
+
+		link = stream->link;
+
+		if (!(link && (stream->signal == SIGNAL_TYPE_DISPLAY_PORT
+				|| stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+				&& link->hpd_status))
+			continue;
+
+		dp_tunnel_settings = get_dp_tunnel_settings(new_ctx, stream);
+
+		if ((dp_tunnel_settings == NULL) || (dp_tunnel_settings->should_use_dp_bw_allocation == false))
+			continue;
+
+		timing_bw = dp_get_timing_bandwidth_kbps(&stream->timing, link);
+
+		for (uint8_t j = 0; j < MAX_DPIA_NUM; j++) {
+			bool is_new_slot = false;
+
+			if (dpia_link_sets[j].link == NULL) {
+				is_new_slot = true;
+				link_count++;
+				dpia_link_sets[j].required_bw = 0;
+				dpia_link_sets[j].link = link;
+			}
+
+			if (is_new_slot || (dpia_link_sets[j].link == link)) {
+				dpia_link_sets[j].tunnel_settings = dp_tunnel_settings;
+				dpia_link_sets[j].required_bw += timing_bw;
+				break;
+			}
+		}
+	}
+
+	if (link_count && link_dpia_validate_dp_tunnel_bandwidth(dpia_link_sets, link_count) == false)
+		result = DC_FAIL_DP_TUNNEL_BW_VALIDATE;
+
+	return result;
+}
+
 struct dp_audio_layout_config {
 	uint8_t layouts_per_sample_denom;
 	uint8_t symbols_per_layout;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index bf398c49c3e8..2a6ccded23df 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -33,6 +33,9 @@ enum dc_status link_validate_mode_timing(
 bool link_validate_dpia_bandwidth(
 		const struct dc_stream_state *stream,
 		const unsigned int num_streams);
+enum dc_status link_validate_dp_tunnel_bandwidth(
+		const struct dc *dc,
+		const struct dc_state *new_ctx);
 uint32_t dp_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index 22bfdced64ab..9b2f1a7da1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -75,12 +75,15 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 
 	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc) {
 		status = core_link_read_dpcd(link, USB4_DRIVER_BW_CAPABILITY,
-				dpcd_dp_tun_data, 1);
+				dpcd_dp_tun_data, 2);
 
 		if (status != DC_OK)
 			goto err;
 
-		link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.raw = dpcd_dp_tun_data[0];
+		link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.raw =
+			dpcd_dp_tun_data[USB4_DRIVER_BW_CAPABILITY - USB4_DRIVER_BW_CAPABILITY];
+		link->dpcd_caps.usb4_dp_tun_info.dpia_tunnel_info.raw =
+			dpcd_dp_tun_data[DP_IN_ADAPTER_TUNNEL_INFO - USB4_DRIVER_BW_CAPABILITY];
 	}
 
 	DC_LOG_DEBUG("%s: Link[%d]  DP tunneling support  (RouterId=%d  AdapterId=%d)  "
@@ -155,8 +158,14 @@ void link_decide_dp_tunnel_settings(struct dc_stream_state *stream,
 					link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling;
 
 		if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc
-				&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support)
+				&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support) {
 			dp_tunnel_setting->should_use_dp_bw_allocation = true;
+			dp_tunnel_setting->cm_id = link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id & 0x0F;
+			dp_tunnel_setting->group_id = link->dpcd_caps.usb4_dp_tun_info.dpia_tunnel_info.bits.group_id;
+			dp_tunnel_setting->estimated_bw = link->dpia_bw_alloc_config.estimated_bw;
+			dp_tunnel_setting->allocated_bw = link->dpia_bw_alloc_config.allocated_bw;
+			dp_tunnel_setting->bw_granularity = link->dpia_bw_alloc_config.bw_granularity;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 642feac5a673..cc1f4e6196ed 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -35,6 +35,8 @@
 
 #define Kbps_TO_Gbps (1000 * 1000)
 
+#define MST_TIME_SLOT_COUNT 64
+
 // ------------------------------------------------------------------
 // PRIVATE FUNCTIONS
 // ------------------------------------------------------------------
@@ -251,32 +253,40 @@ static void dpia_bw_alloc_unplug(struct dc_link *link)
 
 static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 {
-	uint8_t requested_bw;
-	uint32_t temp;
+	uint8_t request_reg_val;
+	uint32_t temp, request_bw;
 
-	/* Error check whether request bw greater than allocated */
-	if (req_bw > link->dpia_bw_alloc_config.estimated_bw) {
-		DC_LOG_ERROR("%s: Request BW greater than estimated BW for link(%d)\n",
-			__func__, link->link_index);
-		req_bw = link->dpia_bw_alloc_config.estimated_bw;
+	if (link->dpia_bw_alloc_config.bw_granularity == 0) {
+		DC_LOG_ERROR("%s:  Link[%d]:  bw_granularity is zero!", __func__, link->link_index);
+		return;
 	}
 
 	temp = req_bw * link->dpia_bw_alloc_config.bw_granularity;
-	requested_bw = temp / Kbps_TO_Gbps;
+	request_reg_val = temp / Kbps_TO_Gbps;
 
 	/* Always make sure to add more to account for floating points */
 	if (temp % Kbps_TO_Gbps)
-		++requested_bw;
+		++request_reg_val;
 
-	/* Error check whether requested and allocated are equal */
-	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw && (req_bw == link->dpia_bw_alloc_config.allocated_bw)) {
-		DC_LOG_ERROR("%s: Request BW equals to allocated BW for link(%d)\n",
-			__func__, link->link_index);
+	request_bw = request_reg_val * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+
+	if (request_bw > link->dpia_bw_alloc_config.estimated_bw) {
+		DC_LOG_ERROR("%s:  Link[%d]:  Request BW (%d --> %d) > Estimated BW (%d)... Set to Estimated BW!",
+				__func__, link->link_index,
+				req_bw, request_bw, link->dpia_bw_alloc_config.estimated_bw);
+		req_bw = link->dpia_bw_alloc_config.estimated_bw;
+
+		temp = req_bw * link->dpia_bw_alloc_config.bw_granularity;
+		request_reg_val = temp / Kbps_TO_Gbps;
+		if (temp % Kbps_TO_Gbps)
+			++request_reg_val;
 	}
 
+	link->dpia_bw_alloc_config.allocated_bw = request_bw;
+	DC_LOG_DC("%s:  Link[%d]:  Request BW:  %d", __func__, link->link_index, request_bw);
+
 	core_link_write_dpcd(link, REQUESTED_BW,
-		&requested_bw,
+		&request_reg_val,
 		sizeof(uint8_t));
 }
 
@@ -331,19 +341,17 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
  */
 void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
 {
+	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
 	if (status & DP_TUNNELING_BW_REQUEST_SUCCEEDED) {
 		DC_LOG_DEBUG("%s: BW Allocation request succeeded on link(%d)",
 				__func__, link->link_index);
 	} else if (status & DP_TUNNELING_BW_REQUEST_FAILED) {
-		link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
-
 		DC_LOG_DEBUG("%s: BW Allocation request failed on link(%d)  allocated/estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
 
 		link_dpia_send_bw_alloc_request(link, link->dpia_bw_alloc_config.estimated_bw);
 	} else if (status & DP_TUNNELING_ESTIMATED_BW_CHANGED) {
-		link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
-
 		DC_LOG_DEBUG("%s: Estimated BW changed on link(%d)  new estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
 	}
@@ -376,9 +384,13 @@ void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pe
 
 void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
 {
-	DC_LOG_DEBUG("%s: ENTER: link(%d), hpd_status(%d), current allocated_bw(%d), req_bw(%d)\n",
+	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
+	DC_LOG_DEBUG("%s: ENTER: link[%d] hpd(%d)  Allocated_BW: %d  Estimated_BW: %d  Req_BW: %d",
 		__func__, link->link_index, link->hpd_status,
-		link->dpia_bw_alloc_config.allocated_bw, req_bw);
+		link->dpia_bw_alloc_config.allocated_bw,
+		link->dpia_bw_alloc_config.estimated_bw,
+		req_bw);
 
 	if (link_dp_is_bw_alloc_available(link))
 		link_dpia_send_bw_alloc_request(link, req_bw);
@@ -389,7 +401,8 @@ void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
 {
 	bool ret = true;
-	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 }, host_router_total_dp_bw = 0;
+	int bw_needed_per_hr[MAX_HOST_ROUTERS_NUM] = { 0 };
+	int host_router_total_dp_bw = 0;
 	uint8_t lowest_dpia_index, i, hr_index;
 
 	if (!num_dpias || num_dpias > MAX_DPIA_NUM)
@@ -417,7 +430,7 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const
 	}
 
 	/* validate against each Host Router max BW */
-	for (hr_index = 0; hr_index < MAX_HR_NUM; ++hr_index) {
+	for (hr_index = 0; hr_index < MAX_HOST_ROUTERS_NUM; ++hr_index) {
 		if (bw_needed_per_hr[hr_index]) {
 			host_router_total_dp_bw = get_host_router_total_dp_tunnel_bw(link[0]->dc, hr_index);
 			if (bw_needed_per_hr[hr_index] > host_router_total_dp_bw) {
@@ -430,29 +443,111 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const
 	return ret;
 }
 
-int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link)
+uint32_t link_dpia_get_dp_mst_overhead(const struct dc_link *link)
 {
-	int dp_overhead = 0, link_mst_overhead = 0;
-
-	if (!link_dp_is_bw_alloc_available(link))
-		return dp_overhead;
+	uint32_t link_mst_overhead = 0;
 
-	/* if its mst link, add MTPH overhead */
 	if ((link->type == dc_connection_mst_branch) &&
-		!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+				!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
 		/* For 8b/10b encoding: MTP is 64 time slots long, slot 0 is used for MTPH
 		 * MST overhead is 1/64 of link bandwidth (excluding any overhead)
 		 */
-		const struct dc_link_settings *link_cap =
-			dc_link_get_link_cap(link);
-		uint32_t link_bw_in_kbps = (uint32_t)link_cap->link_rate *
+		const struct dc_link_settings *link_cap = dc_link_get_link_cap(link);
+
+		if (link_cap) {
+			uint32_t link_bw_in_kbps = (uint32_t)link_cap->link_rate *
 					   (uint32_t)link_cap->lane_count *
 					   LINK_RATE_REF_FREQ_IN_KHZ * 8;
-		link_mst_overhead = (link_bw_in_kbps / 64) + ((link_bw_in_kbps % 64) ? 1 : 0);
+			link_mst_overhead = (link_bw_in_kbps / MST_TIME_SLOT_COUNT)
+						+ ((link_bw_in_kbps % MST_TIME_SLOT_COUNT) ? 1 : 0);
+		}
 	}
 
-	/* add all the overheads */
-	dp_overhead = link_mst_overhead;
+	return link_mst_overhead;
+}
 
-	return dp_overhead;
+/*
+ * Aggregates the DPIA bandwidth usage for the respective USB4 Router.
+ * And then validate if the required bandwidth is within the router's capacity.
+ *
+ * @dc_validation_dpia_set: pointer to the dc_validation_dpia_set
+ * @count: number of DPIA validation sets
+ *
+ * return: true if validation is succeeded
+ */
+bool link_dpia_validate_dp_tunnel_bandwidth(const struct dc_validation_dpia_set *dpia_link_sets, uint8_t count)
+{
+	uint32_t granularity_Gbps;
+	const struct dc_link *link;
+	uint32_t link_bw_granularity;
+	uint32_t link_required_bw;
+	struct usb4_router_validation_set router_sets[MAX_HOST_ROUTERS_NUM] = { 0 };
+	uint8_t i;
+	bool is_success = true;
+	uint8_t rounter_count = 0;
+
+	if ((dpia_link_sets == NULL) || (count == 0))
+		return is_success;
+
+	for (i = 0; i < count; i++) {
+		link = dpia_link_sets[i].link;
+		link_required_bw = dpia_link_sets[i].required_bw;
+		const struct dc_tunnel_settings *dp_tunnel_settings = dpia_link_sets[i].tunnel_settings;
+
+		if ((link == NULL) || (dp_tunnel_settings == NULL) || dp_tunnel_settings->bw_granularity == 0)
+			break;
+
+		if (link->type == dc_connection_mst_branch)
+			link_required_bw += link_dpia_get_dp_mst_overhead(link);
+
+		granularity_Gbps = (Kbps_TO_Gbps / dp_tunnel_settings->bw_granularity);
+		link_bw_granularity = (link_required_bw / granularity_Gbps) * granularity_Gbps +
+				((link_required_bw % granularity_Gbps) ? granularity_Gbps : 0);
+
+		for (uint8_t j = 0; j < MAX_HOST_ROUTERS_NUM; j++) {
+			if (router_sets[j].is_valid == false) {
+				router_sets[j].is_valid = true;
+				router_sets[j].cm_id = dp_tunnel_settings->cm_id;
+				rounter_count++;
+			}
+
+			if (router_sets[j].cm_id == dp_tunnel_settings->cm_id) {
+				uint32_t remaining_bw =
+					dp_tunnel_settings->estimated_bw - dp_tunnel_settings->allocated_bw;
+
+				router_sets[j].allocated_bw += dp_tunnel_settings->allocated_bw;
+
+				if (remaining_bw > router_sets[j].remaining_bw)
+					router_sets[j].remaining_bw = remaining_bw;
+
+				// Get the max estimated BW within the same CM_ID
+				if (dp_tunnel_settings->estimated_bw > router_sets[j].estimated_bw)
+					router_sets[j].estimated_bw = dp_tunnel_settings->estimated_bw;
+
+				router_sets[j].required_bw += link_bw_granularity;
+				router_sets[j].dpia_count++;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < rounter_count; i++) {
+		uint32_t total_bw = 0;
+
+		if (router_sets[i].is_valid == false)
+			break;
+
+		if ((router_sets[i].dpia_count == 1) || (router_sets[i].allocated_bw == 0))
+			total_bw = router_sets[i].estimated_bw;
+		else
+			total_bw = router_sets[i].allocated_bw + router_sets[i].remaining_bw;
+
+		if (router_sets[i].required_bw > total_bw) {
+			is_success = false;
+			break;
+		}
+	}
+
+	return is_success;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 801965b5f9a4..5b5b37486b89 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -28,10 +28,6 @@
 
 #include "link.h"
 
-/* Number of Host Routers per motherboard is 2 */
-#define MAX_HR_NUM			2
-/* Number of DPIA per host router is 2 */
-#define MAX_DPIA_NUM		(MAX_HR_NUM * 2)
 
 /*
  * Host Router BW type
@@ -42,6 +38,16 @@ enum bw_type {
 	HOST_ROUTER_BW_INVALID,
 };
 
+struct usb4_router_validation_set {
+	bool is_valid;
+	uint8_t cm_id;
+	uint8_t dpia_count;
+	uint32_t required_bw;
+	uint32_t allocated_bw;
+	uint32_t estimated_bw;
+	uint32_t remaining_bw;
+};
+
 /*
  * Enable USB4 DP BW allocation mode
  *
@@ -92,7 +98,7 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned
  *
  * return: DP overheads in DP tunneling
  */
-int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link);
+uint32_t link_dpia_get_dp_mst_overhead(const struct dc_link *link);
 
 /*
  * Handle DP BW allocation status register
@@ -104,4 +110,15 @@ int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link);
  */
 void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status);
 
+/*
+ * Aggregates the DPIA bandwidth usage for the respective USB4 Router.
+ *
+ * @dc_validation_dpia_set: pointer to the dc_validation_dpia_set
+ * @count: number of DPIA validation sets
+ *
+ * return: true if validation is succeeded
+ */
+bool link_dpia_validate_dp_tunnel_bandwidth(const struct dc_validation_dpia_set *dpia_link_sets, uint8_t count);
+
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
+
-- 
2.43.0

