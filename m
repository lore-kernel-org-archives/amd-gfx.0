Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0DC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4B910E3BE;
	Tue, 13 May 2025 11:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J4ne/QNE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F43A10E3BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuGqr1u3/qZmxkKZHLXVFlhJ+68OwHQ9mlmWciuis1R7RdYYbOilKrqGkLLJIj5dPE9n1kgFrfeaBk9LKouhlw+roVO5huyyu6pNXBQYbDANh6J0hUSZCGcii0w/9yoZxl1MgCAtCH7XYQQ2qmkp4p603XyTj+GfbC7tKG4/6r8v0rpetKvluirEg+Sc5Hwdw//en1I+JRbn/AZ4wlpvA8anPI36unQyk/CkAwG8UXeO9cIFeGPvvVYv09xf7p/tbwxR6Ik37zbo2lzXAKFcxmA2qym4Xl/Rl0MMZ+suyAuCMMjvb1nc17/jos7D5pB0r9Ayj/V/W2p+YmC/QmeoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyySQS9Zk2DlySajTPlMnyEE/B/ywEsPJb7ZuAvyr6c=;
 b=XyNUW41i7qcnZro6afHKXqvZDiz9FDZLWyz23mtm/xeFLUf1Nb5ntXjlkwY+l3+T3nBTLr4AZpaKuzQozs3We+YinZ1Y6Cjg2vgLWtKQnVXgPRqqsht2kxDn0NtiA2jLtqhKeWeSNBbi+K9VosfJ/BSChM1Q94oXgcCxpGAuzpY9IBw6YF90GkEeqcFP/8jBHdnc6enItd1ayqCiUg6H3Ws8pD7G2Czpg0MQaPYhxjBbo+BX7OhiC+N8mDeKDHl8auaZVnN/TV7l/RKJlzx0ywggpbnR9elQpPGyU9UPmcJgXpyPi6OQryJhbwKhaKaHKMbe9UrFFzYVKjKX85lfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyySQS9Zk2DlySajTPlMnyEE/B/ywEsPJb7ZuAvyr6c=;
 b=J4ne/QNE9p/FCbZ53H06n0UkMgmQ9iamPfybOhSzZZsC0bIGtSVdZcCb2pRFyeqjmzFJVhClJlllJp7d5rkBRRHEkStJeIXXiNrka6ANU+g0eZb7EY/le1d1CxBq7fvqfytgPTBxKKuV8HF2I7JvqRViDOBVjvy11da0vFo1YKU=
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:25:03 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::19) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Tue,
 13 May 2025 11:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:01 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:24:58 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 03/11] drm/amd/display: Support external tunneling feature
Date: Tue, 13 May 2025 19:24:31 +0800
Message-ID: <20250513112439.2295366-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 469bb195-00b7-4e13-d004-08dd9210cded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1K+nJNKgr4lphu44U4XllXm7lR3UaRvTiHYxD05yKVQxAdoTCgDrjxjUjXjS?=
 =?us-ascii?Q?GUB/ZoTbQKWHTG/1jgpc79LaFEFCJa5oPBp+yLafZHWVNs+hFzVMAx3+jHxV?=
 =?us-ascii?Q?3r6xoMmFD1wfE3Ikkmou35oKsSzvPvKTy6bp1BxNb88BsZdPhCf7t40cE51M?=
 =?us-ascii?Q?ik4duGMu3kN8H8iZyrMMuf5RPogbbSSMZl0eVuvD+doq59yA1/6G/ee4DBSH?=
 =?us-ascii?Q?BGxwHkoYBWwei5QKDRwyJfu+RFZh0kpA5I1JWSY5kupZ7Cdu38QwX5jufExd?=
 =?us-ascii?Q?4Yb+mTepAnf5FRSeWBjpXVZkioO88kPLkygVIVjKqEPAZ4go5GW+fU7LSOj5?=
 =?us-ascii?Q?O+eO9Aym3UzzVi2RXegbYn2WyWFP80wGNi1Cd5ovCKJfAWsmr2N66mcldkZ8?=
 =?us-ascii?Q?jMuBjo4usb+NH7ptZLa2t0zpOjKh/XlpHPKh1ey9XlNkGKzIZmWExzUx4Yg6?=
 =?us-ascii?Q?VdkLyZBFeOe1WedEZcaFFAxpDczZRj3YOOOiait0ICP3XkWvfq2lAzinlKtm?=
 =?us-ascii?Q?g9aHpvDhPLO9bUjQAlkK+zyh3cVNvJPAsIgi6wMv0M7yUrVaJ9CakJ40Uuaw?=
 =?us-ascii?Q?3xVrm7HmmM6vqRVzfqP8ESGB7JHCeLWO2zgDDgnSvZaQjjfJNlsXamVuZc8S?=
 =?us-ascii?Q?FpRXwGzKByoE+2GUvGIkp6F7V/FL/ozLerbNepxj+vjfpTeAGj6+FtGWsaX8?=
 =?us-ascii?Q?OahosnPXHu1IL9IgmNamWRLUGSqEZyJjYKewFIyyxlCxWoHuXmKTwvckBQ9g?=
 =?us-ascii?Q?dxj261quiVosqYlqNzeQmux1qaht75v9IJLcVGkmiwkrkxUrPJdxMaiySIz6?=
 =?us-ascii?Q?1R20IKTijb0/Me6s429IeUSwhOh8s6bywjiy3XYUJAdDmbP3oeQIRcA395rh?=
 =?us-ascii?Q?xih16qgU0uK6szc0jMYDOP7vqNLZoTBVlU+kl0dtT5tda7YfC9ft0xLL47I3?=
 =?us-ascii?Q?haRaRWfX2EyYXeARRlZvedIV3gtdW2RPNUjLeC1XDK4Hi8LL1sEHzddWMeBK?=
 =?us-ascii?Q?p4k25M+zRkQUYVbX2o+1+T5i2KqK8HnqEJUTbhpV6Z2EWEcfMLnQurL6ckT/?=
 =?us-ascii?Q?inFmXYyry26ZnkTW+7r/TpeCXwqufagFniM9PiG5ABExL/VR5UbzZEcDADBW?=
 =?us-ascii?Q?kktRsClYsgL+lplRsmwAhzT0Y3A6D2brAWeZ2QLsEBYPlHvNjpb+MN6rK+XA?=
 =?us-ascii?Q?Cv/W9LxJS/TVF+QMG8QCUkgL4aKffA6kOWNuWh5GZpcX6QoSbMXJOXtnhVcU?=
 =?us-ascii?Q?GxAXnhRBfVyIVann5kMVVYF5SDMAtkYc8hzN/6SA6zPkdE9mCMJs/neT17ya?=
 =?us-ascii?Q?B4Fbr8wh/ngBNc+6sPwI/urkp2SZPZ/0AyzLXMXkE53iskA2IIn/S/z4Hca7?=
 =?us-ascii?Q?VTcbH+6nJzNNt59voVt1DBac9ylXCf1zC43tqZUkI+qVlpW4n+z+kM60/9xv?=
 =?us-ascii?Q?kGm6XEX8yJcaxm0y3aukqJang1SkmKznNGA4qbUPAyuRskxwHLkUTN2Es/Nn?=
 =?us-ascii?Q?8/qJwXKsGS8eQ+auXYDnmRPwUOZ9QWDM/B4t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:02.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469bb195-00b7-4e13-d004-08dd9210cded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
The original code only supports the tunneling for embedded one.
To support external tunneling feature, it needs to check
Tunneling_Support bit register.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 21 ++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +
 .../drm/amd/display/dc/link/link_detection.c  | 21 ++----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  6 +-
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../dc/link/protocols/link_dp_capability.c    |  8 +--
 .../display/dc/link/protocols/link_dp_dpia.c  | 54 ++++++++++++--
 .../display/dc/link/protocols/link_dp_dpia.h  |  6 ++
 .../dc/link/protocols/link_dp_dpia_bw.c       | 70 +++++++------------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  4 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  4 +-
 14 files changed, 126 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 13559fe56062..15ef1f26864f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3911,6 +3911,10 @@ enum dc_status resource_map_pool_resources(
 		if (!dc->link_srv->dp_decide_link_settings(stream,
 				&pipe_ctx->link_config.dp_link_settings))
 			return DC_FAIL_DP_LINK_BANDWIDTH;
+
+		dc->link_srv->dp_decide_tunnel_settings(stream,
+				&pipe_ctx->link_config.dp_tunnel_settings);
+
 		if (dc->link_srv->dp_get_encoding_format(
 				&pipe_ctx->link_config.dp_link_settings) == DP_128b_132b_ENCODING) {
 			pipe_ctx->stream_res.hpo_dp_stream_enc =
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 77c87ad57220..0bad8304ccf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -159,6 +159,11 @@ struct dc_link_settings {
 	uint8_t link_rate_set;
 };
 
+struct dc_tunnel_settings {
+	bool should_enable_dp_tunneling;
+	bool should_use_dp_bw_allocation;
+};
+
 union dc_dp_ffe_preset {
 	struct {
 		uint8_t level		: 4;
@@ -943,10 +948,20 @@ union dpia_info {
 	uint8_t raw;
 };
 
+/* DPCD[0xE0020] USB4_DRIVER_BW_CAPABILITY register. */
+union usb4_driver_bw_cap {
+	struct {
+		uint8_t rsvd :7;
+		uint8_t driver_bw_alloc_support :1;
+	} bits;
+	uint8_t raw;
+};
+
 /* DP Tunneling over USB4 */
 struct dpcd_usb4_dp_tunneling_info {
 	union dp_tun_cap_support dp_tun_cap;
 	union dpia_info dpia_info;
+	union usb4_driver_bw_cap driver_bw_cap;
 	uint8_t usb4_driver_id;
 	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
 };
@@ -1486,5 +1501,11 @@ struct dp_trace {
 # ifndef DP_TUNNELING_BW_ALLOC_CAP_CHANGED
 # define DP_TUNNELING_BW_ALLOC_CAP_CHANGED		(1 << 3)
 # endif
+# ifndef DPTX_BW_ALLOC_UNMASK_IRQ
+# define DPTX_BW_ALLOC_UNMASK_IRQ			(1 << 6)
+# endif
+# ifndef DPTX_BW_ALLOC_MODE_ENABLE
+# define DPTX_BW_ALLOC_MODE_ENABLE			(1 << 7)
+# endif
 
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 63077c1fad85..c814d957305a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1550,7 +1550,7 @@ static bool should_avoid_empty_tu(struct pipe_ctx *pipe_ctx)
 	struct dc_link_settings *link_settings = &pipe_ctx->link_config.dp_link_settings;
 	const struct dc *dc = pipe_ctx->stream->link->dc;
 
-	if (pipe_ctx->stream->link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+	if (pipe_ctx->link_config.dp_tunnel_settings.should_enable_dp_tunneling == false)
 		return false;
 
 	// Not necessary for MST configurations
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 051bd83680d1..faa1b4e619de 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -384,7 +384,9 @@ struct link_resource {
 
 struct link_config {
 	struct dc_link_settings dp_link_settings;
+	struct dc_tunnel_settings dp_tunnel_settings;
 };
+
 union pipe_update_flags {
 	struct {
 		uint32_t enable : 1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 2948a696ee12..7d16351bba99 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -207,6 +207,9 @@ struct link_service {
 	bool (*dp_decide_link_settings)(
 		struct dc_stream_state *stream,
 		struct dc_link_settings *link_setting);
+	void (*dp_decide_tunnel_settings)(
+		struct dc_stream_state *stream,
+		struct dc_tunnel_settings *dp_tunnel_setting);
 	enum dp_link_encoding (*mst_decide_link_encoding_format)(
 			const struct dc_link *link);
 	bool (*edp_decide_link_settings)(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index cc9191a5c9e6..9655e6fa53a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -611,6 +611,7 @@ static bool detect_dp(struct dc_link *link,
 		link->dpcd_caps.dongle_type = sink_caps->dongle_type;
 		link->dpcd_caps.is_dongle_type_one = sink_caps->is_dongle_type_one;
 		link->dpcd_caps.dpcd_rev.raw = 0;
+		link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw = 0;
 	}
 
 	return true;
@@ -1007,21 +1008,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
 				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
 
-			/*
-			 * If this is DP over USB4 link then we need to:
-			 * - Enable BW ALLOC support on DPtx if applicable
-			 */
-			if (dc->config.usb4_bw_alloc_support) {
-				if (link_dp_dpia_set_dptx_usb4_bw_alloc_support(link)) {
-					/* update with non reduced link cap if bw allocation mode is supported */
-					if (link->dpia_bw_alloc_config.nrd_max_link_rate &&
-						link->dpia_bw_alloc_config.nrd_max_lane_count) {
-						link->reported_link_cap.link_rate =
-							link->dpia_bw_alloc_config.nrd_max_link_rate;
-						link->reported_link_cap.lane_count =
-							link->dpia_bw_alloc_config.nrd_max_lane_count;
-					}
-				}
+			if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
+					&& link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc
+					&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support) {
+				if (link_dpia_enable_usb4_dp_bw_alloc_mode(link) == false)
+					link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc = false;
 			}
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 53c961f86d43..273a3be6d593 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2374,7 +2374,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
-	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
 		deallocate_usb4_bandwidth(pipe_ctx->stream);
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
@@ -2442,7 +2442,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	if (link->connector_signal == SIGNAL_TYPE_EDP && dc->debug.psp_disabled_wa) {
 		/* reset internal save state to default since eDP is  off */
 		enum dp_panel_mode panel_mode = dp_get_panel_mode(pipe_ctx->stream->link);
-		/* since current psp not loaded, we need to reset it to default*/
+		/* since current psp not loaded, we need to reset it to default */
 		link->panel_mode = panel_mode;
 	}
 }
@@ -2620,7 +2620,7 @@ void link_set_dpms_on(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_set_hblank_reduction_on_rx(pipe_ctx);
 
-	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
 		allocate_usb4_bandwidth(pipe_ctx->stream);
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 0125f2cfc114..1a04f4b74585 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -156,6 +156,7 @@ static void construct_link_service_dp_capability(struct link_service *link_srv)
 	link_srv->dp_get_encoding_format = link_dp_get_encoding_format;
 	link_srv->dp_should_enable_fec = dp_should_enable_fec;
 	link_srv->dp_decide_link_settings = link_decide_link_settings;
+	link_srv->dp_decide_tunnel_settings = link_decide_dp_tunnel_settings;
 	link_srv->mst_decide_link_encoding_format =
 			mst_decide_link_encoding_format;
 	link_srv->edp_decide_link_settings = edp_decide_link_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 9d49e77a24a1..8f79881ad9f1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2021,11 +2021,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 			sizeof(link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw));
 
 	/* Read DP tunneling information. */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-		status = dpcd_get_tunneling_device_data(link);
-		if (status != DC_OK)
-			dm_error("%s: Read DP tunneling device data failed.\n", __func__);
-	}
+	status = dpcd_get_tunneling_device_data(link);
+	if (status != DC_OK)
+		dm_error("%s: Read DP tunneling device data failed.\n", __func__);
 
 	retrieve_cable_id(link);
 	dpcd_write_cable_id_to_dprx(link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index c149210096ac..22bfdced64ab 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -62,6 +62,36 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	if (status != DC_OK)
 		goto err;
 
+	link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw =
+			dpcd_dp_tun_data[DP_TUNNELING_CAPABILITIES_SUPPORT - DP_TUNNELING_CAPABILITIES_SUPPORT];
+
+	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling == false)
+		goto err;
+
+	link->dpcd_caps.usb4_dp_tun_info.dpia_info.raw =
+			dpcd_dp_tun_data[DP_IN_ADAPTER_INFO - DP_TUNNELING_CAPABILITIES_SUPPORT];
+	link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id =
+			dpcd_dp_tun_data[DP_USB4_DRIVER_ID - DP_TUNNELING_CAPABILITIES_SUPPORT];
+
+	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc) {
+		status = core_link_read_dpcd(link, USB4_DRIVER_BW_CAPABILITY,
+				dpcd_dp_tun_data, 1);
+
+		if (status != DC_OK)
+			goto err;
+
+		link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.raw = dpcd_dp_tun_data[0];
+	}
+
+	DC_LOG_DEBUG("%s: Link[%d]  DP tunneling support  (RouterId=%d  AdapterId=%d)  "
+			"DPIA_BW_Alloc_support=%d "
+			"CM_BW_Alloc_support=%d ",
+			__func__, link->link_index,
+			link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id,
+			link->dpcd_caps.usb4_dp_tun_info.dpia_info.bits.dpia_num,
+			link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc,
+			link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support);
+
 	status = core_link_read_dpcd(
 			link,
 			DP_USB4_ROUTER_TOPOLOGY_ID,
@@ -71,13 +101,6 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	if (status != DC_OK)
 		goto err;
 
-	link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw =
-			dpcd_dp_tun_data[DP_TUNNELING_CAPABILITIES_SUPPORT - DP_TUNNELING_CAPABILITIES_SUPPORT];
-	link->dpcd_caps.usb4_dp_tun_info.dpia_info.raw =
-			dpcd_dp_tun_data[DP_IN_ADAPTER_INFO - DP_TUNNELING_CAPABILITIES_SUPPORT];
-	link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id =
-			dpcd_dp_tun_data[DP_USB4_DRIVER_ID - DP_TUNNELING_CAPABILITIES_SUPPORT];
-
 	for (i = 0; i < DPCD_USB4_TOPOLOGY_ID_LEN; i++)
 		link->dpcd_caps.usb4_dp_tun_info.usb4_topology_id[i] = dpcd_topology_data[i];
 
@@ -120,3 +143,20 @@ bool dpia_query_hpd_status(struct dc_link *link)
 	return link->hpd_status;
 }
 
+void link_decide_dp_tunnel_settings(struct dc_stream_state *stream,
+			struct dc_tunnel_settings *dp_tunnel_setting)
+{
+	struct dc_link *link = stream->link;
+
+	memset(dp_tunnel_setting, 0, sizeof(*dp_tunnel_setting));
+
+	if ((stream->signal == SIGNAL_TYPE_DISPLAY_PORT) || (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)) {
+		dp_tunnel_setting->should_enable_dp_tunneling =
+					link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling;
+
+		if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc
+				&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support)
+			dp_tunnel_setting->should_use_dp_bw_allocation = true;
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
index 363f45a1a964..a61edfc9ca7a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
@@ -38,4 +38,10 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
  * Returns true if HPD high.
  */
 bool dpia_query_hpd_status(struct dc_link *link);
+
+/* Decide the DP tunneling settings based on the DPCD capabilities
+ */
+void link_decide_dp_tunnel_settings(struct dc_stream_state *stream,
+			struct dc_tunnel_settings *dp_tunnel_setting);
+
 #endif /* __DC_LINK_DPIA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index a254ead2f7e8..3af7564a84f1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -46,9 +46,10 @@
  */
 static bool link_dp_is_bw_alloc_available(struct dc_link *link)
 {
-	return (link && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA
-		&& link->hpd_status
-		&& link->dpia_bw_alloc_config.bw_alloc_enabled);
+	return (link && link->hpd_status
+		&& link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
+		&& link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc
+		&& link->dpcd_caps.usb4_dp_tun_info.driver_bw_cap.bits.driver_bw_alloc_support);
 }
 
 static void reset_bw_alloc_struct(struct dc_link *link)
@@ -141,7 +142,7 @@ static int get_non_reduced_max_lane_count(struct dc_link *link)
  * granuality, Driver_ID, CM_Group, & populate the BW allocation structs
  * for host router and dpia
  */
-static void init_usb4_bw_struct(struct dc_link *link)
+static void retrieve_usb4_dp_bw_allocation_info(struct dc_link *link)
 {
 	reset_bw_alloc_struct(link);
 
@@ -282,49 +283,26 @@ static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 // ------------------------------------------------------------------
 // PUBLIC FUNCTIONS
 // ------------------------------------------------------------------
-bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
+bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
 {
 	bool ret = false;
-	uint8_t response = 0,
-			bw_support_dpia = 0,
-			bw_support_cm = 0;
+	uint8_t val;
 
-	if (!(link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->hpd_status))
-		goto out;
+	if (link->hpd_status) {
+		val = DPTX_BW_ALLOC_MODE_ENABLE | DPTX_BW_ALLOC_UNMASK_IRQ;
 
-	if (core_link_read_dpcd(
-			link,
-			DP_TUNNELING_CAPABILITIES,
-			&response,
-			sizeof(uint8_t)) == DC_OK)
-		bw_support_dpia = (response >> 7) & 1;
-
-	if (core_link_read_dpcd(
-		link,
-		USB4_DRIVER_BW_CAPABILITY,
-		&response,
-		sizeof(uint8_t)) == DC_OK)
-		bw_support_cm = (response >> 7) & 1;
-
-	/* Send request acknowledgment to Turn ON DPTX support */
-	if (bw_support_cm && bw_support_dpia) {
-
-		response = 0x80;
-		if (core_link_write_dpcd(
-				link,
-				DPTX_BW_ALLOCATION_MODE_CONTROL,
-				&response,
-				sizeof(uint8_t)) != DC_OK) {
-			DC_LOG_DEBUG("%s: FAILURE Enabling DPtx BW Allocation Mode Support for link(%d)\n",
-				__func__, link->link_index);
-		} else {
-			// SUCCESS Enabled DPtx BW Allocation Mode Support
-			DC_LOG_DEBUG("%s: SUCCESS Enabling DPtx BW Allocation Mode Support for link(%d)\n",
-				__func__, link->link_index);
+		if (core_link_write_dpcd(link, DPTX_BW_ALLOCATION_MODE_CONTROL, &val, sizeof(uint8_t)) == DC_OK) {
+			DC_LOG_DEBUG("%s:  link[%d] DPTX BW allocation mode enabled", __func__, link->link_index);
+
+			retrieve_usb4_dp_bw_allocation_info(link);
+
+			if (link->dpia_bw_alloc_config.nrd_max_link_rate && link->dpia_bw_alloc_config.nrd_max_lane_count) {
+				link->reported_link_cap.link_rate = link->dpia_bw_alloc_config.nrd_max_link_rate;
+				link->reported_link_cap.lane_count = link->dpia_bw_alloc_config.nrd_max_lane_count;
+			}
 
-			ret = true;
-			init_usb4_bw_struct(link);
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+			ret = true;
 
 			/*
 			 * During DP tunnel creation, CM preallocates BW and reduces estimated BW of other
@@ -332,11 +310,12 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 			 * to make the CM to release preallocation and update estimated BW correctly for
 			 * all DPIAs per host router
 			 */
+			// TODO: Zero allocation can be removed once the MSFT CM fix has been released
 			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
-		}
+		} else
+			DC_LOG_DEBUG("%s:  link[%d] failed to enable DPTX BW allocation mode", __func__, link->link_index);
 	}
 
-out:
 	return ret;
 }
 
@@ -378,7 +357,8 @@ void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
  */
 void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
 {
-	if (link && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->dpia_bw_alloc_config.bw_alloc_enabled) {
+	if (link && link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling
+			&& link->dpia_bw_alloc_config.bw_alloc_enabled) {
 		//1. Hot Plug
 		if (link->hpd_status && peak_bw > 0) {
 			// If DP over USB4 then we need to check BW allocation
@@ -401,7 +381,7 @@ void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
 	if (link_dp_is_bw_alloc_available(link))
 		link_dpia_send_bw_alloc_request(link, req_bw);
 	else
-		DC_LOG_DEBUG("%s:  Not able to send the BW Allocation request", __func__);
+		DC_LOG_DEBUG("%s:  BW Allocation mode not available", __func__);
 }
 
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 6df9b946b00f..801965b5f9a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -43,13 +43,13 @@ enum bw_type {
 };
 
 /*
- * Enable BW Allocation Mode Support from the DP-Tx side
+ * Enable USB4 DP BW allocation mode
  *
  * @link: pointer to the dc_link struct instance
  *
  * return: SUCCESS or FAILURE
  */
-bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
+bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link);
 
 /*
  * Allocates only what the stream needs for bw, so if:
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 991b8ad4984b..693477413347 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -352,7 +352,7 @@ enum dc_status dp_read_hpd_rx_irq_data(
 			irq_data->raw,
 			DP_SINK_STATUS - DP_SINK_COUNT + 1);
 
-		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling) {
 			retval = core_link_read_dpcd(
 					link, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
 					&irq_data->bytes.link_service_irq_esi0.raw, 1);
@@ -521,7 +521,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		dp_trace_link_loss_increment(link);
 	}
 
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dp_tunneling) {
 		if (hpd_irq_dpcd_data.bytes.link_service_irq_esi0.bits.DP_LINK_TUNNELING_IRQ)
 			dp_handle_tunneling_irq(link);
 	}
-- 
2.34.1

