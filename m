Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B77EC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3B410E64E;
	Wed, 25 Jun 2025 04:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fv4VRllK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB87E10E64E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7qaZC8HQhGNsYApC6UTDU7FP1zur1wiIksD3SuP/LsQKFhrzOK6BDtidiMUPfjBKsos30tC+wXloRGFoG3oocAHnR47CBWotOdCLlbEl6S4GR2sjIX5jo5R7TK8e2R2mwCoq0++0EqNjrJfazJ7NR+GW4cdYuvXBmP5ke2VRNS7HWOwsoaGKi7io6WcPscOBamazMrc8HamVw4hqirpns/vXh5GGtLFXisaLYPK7GZvG+veccAz2oOM5U9VyvmWNVJBpiqeQCkTVhKUjOcWAb6/cJqPgdOkQGixpwbh26wl7vF+wMMSOSGaUu7T7QbC0mXAqzPYeijnYtka49h8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve+YZ/krrXMzrz9ylPQnEym8hSD9VlFacPUmfdcjJvA=;
 b=XF/CbQCY1mdrC67XdKLKhcS9ZdSaes8UMx5Ve0S1163JlwEHzozBdahK0+viU1m/WPucZi+ixVsIcAgeJbieNnfB1kZGvmfdZRgDgDavFrsbN4fNM7N5/+c0qjjeSXB/ZwqemUsPxb+b39NdUvWmBsdsJy4LTvl0mB5BImVrdGw4hQQkHe0WmnX7IH2lyWlh87DcwG7TM8UTuj6D3IFG6UEGi5A/cnvkzYlpfhwXrD8jK4JeQRUHx/tKmy+IIO+W5XnVXI7z34EfJEgnuHbKMgMpq7A7utbyW4c5NHeoE/Fj6bBXIkCum7Lk5jlNODa5W9dxAOOQHq+VJLjs3O+M1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve+YZ/krrXMzrz9ylPQnEym8hSD9VlFacPUmfdcjJvA=;
 b=Fv4VRllK1Liaa8TAiw9Gpq38Ci7+KvOoYStBs4EQ+u3Divw4ST7ei3NxacJepb+N8GiubyZU+Ev2Bs+9ruRWAaqhPJAzihLAEK8rkQuPEJyBWYqAQYDO/CaIbWKW5YoI13OjlxfGZ5T/c9BHmru2D54xLX3f1Z7MP4wZgEWmRrM=
Received: from DM6PR02CA0111.namprd02.prod.outlook.com (2603:10b6:5:1b4::13)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 04:05:23 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::18) by DM6PR02CA0111.outlook.office365.com
 (2603:10b6:5:1b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 04:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:21 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:18 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 02/11] drm/amd/display: Remove unused tunnel BW validation
Date: Wed, 25 Jun 2025 12:02:20 +0800
Message-ID: <20250625040420.886013-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 017947a0-9792-449a-82fb-08ddb39d8217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AeRDbgCpoRy8Kg8XIZbyZ3RPTIHIOgCUF5Cw9+EnMnlyKhZJ1JIeMCZd+PNH?=
 =?us-ascii?Q?fVQoAOt6FPHPETl2o9Xnr3AWAOzr6GpHoTrrqaeYnLhfYgwD7zfX1S9/jcZh?=
 =?us-ascii?Q?Czr8cgjalSJDHBzAxpxnwVs6SYd2yCQ1QfV2t5y00npQ2AtshglIQMA6HY/t?=
 =?us-ascii?Q?q4YBrqNkmljt2NPtw2nrkAwmSmJnElLGTTVG5Eub7oj2Tu2ohfCcDyOCcyr5?=
 =?us-ascii?Q?3YcRHZDaztlFduLiFFsPNlt96U/d8wK809+LQR3ZtffsCosa6sZ5PhaRCorE?=
 =?us-ascii?Q?UaEIk7hzmdXsTEPQmsP2T1mau5yTL03bvbj9iQNt9IbivsrPLCFvKoLrvZUR?=
 =?us-ascii?Q?6ytSsob54pwWPG9nasriNglfGn0HPU6/Nrv8NL/JqgY9EKTbcBUR3Mtvv+Q7?=
 =?us-ascii?Q?IDhE+WfetpGa6r3ZBsJvJPf4PXduoQcmLNbLODpsoTe1Au90Zh7Zsjl2lv5h?=
 =?us-ascii?Q?Ooz6sw9aomWdgzxUqSs46jzAIj1KoCPiI7IpqXN2nrxVMVUOdcwITfmv963r?=
 =?us-ascii?Q?RszrKRxmOJq6HirYLtOVHIUwIt++r80C3Uy6rLrSMFcmLZEaZhWtMQPbD7MZ?=
 =?us-ascii?Q?QeT7Hrv8T9GPAbDAnQw9ZhTa/DSBKg1UX8hApXu9mGlc5A8Uq5rIzPbm8B9q?=
 =?us-ascii?Q?9c4zg53tLBThhTt5fXw4Q4ULHAW5gNy8peaPuq2UfKCBeMEPTWotdHdA28vv?=
 =?us-ascii?Q?mMmFOA/OZQLR5bZaZ74Do7P7xbBCnDWuGizvsNO8twJ2BqGGMY82QEjejAxx?=
 =?us-ascii?Q?2ycktEjEwqcE+4YpRGUPBs2JL2sIgYMnceF6YzWtASGd97QerM5e42HEffvx?=
 =?us-ascii?Q?Vqk8m/dKgpN5TjdszSh6LfFHWK0gnEu/goPGRegi+lavbssNEq4/4CLn8em5?=
 =?us-ascii?Q?yElbzwAiWceqwm94ktwVY9+EDDJCA3ILTcK0r0KdGH5hPGH+DEtBuiX23WrU?=
 =?us-ascii?Q?E4nLD+juaiYPML6FjwYGtqy7F4+2R5yZMYwR9gx+KVeGCnlxjuMXleGL5EVZ?=
 =?us-ascii?Q?KVaZqUUY2GCgWrdA4BzSso7n6RpbElSU13SAFADXE6tknwZMdpU2TbsvHOyA?=
 =?us-ascii?Q?J0DmMYcAKWKJc+UzA+PizdsZUmmhGk1orJbiKhFh5HnTcswoMxEpto174ZuU?=
 =?us-ascii?Q?DwXqSkH7XWosd/YI1OnVnWzgzPyXIlSxYSPk6i239gkwq1AxRLjpG5eKAe8L?=
 =?us-ascii?Q?0iiVztGX3dedwp4676ZRAIhoe2HgGt0KBvPHT1Nh72FHUJDjftndvykV5Pt1?=
 =?us-ascii?Q?6b4y/P7thVYjz+jD7jnBjb+aFGZ7ZD0/yeqpAWyPs9MqbE0MxhcKu6bI04Uy?=
 =?us-ascii?Q?v3HlhAX3D5nZf1BJSTjV487KGf0vTccluBY8by8O0S1Ob5L5+4PKcJ1SWhPG?=
 =?us-ascii?Q?svk5jTRiJY30c/S5wEcmmcNmRH2D5n7WD8GyQ2zbyTZij6lo+DEIIN+Jd35r?=
 =?us-ascii?Q?Go340w/eM6VZ/ZkIVjP3QdZaKYZr4pKCO2xINIelhTlcnqIpiTb9Q9Hvygs3?=
 =?us-ascii?Q?bQGSbznEhdJQyvlkBlRfUczgIeXL1AOUX5hI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:22.9432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017947a0-9792-449a-82fb-08ddb39d8217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
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
The tunnel BW validation code has changed to the new one.
Remove the unused code.
The DP tunneling overhead is not updated in SST.
Move updating DP tunneling overhead for both SST and MST.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  13 --
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   5 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../drm/amd/display/dc/link/link_validation.c |  61 +-------
 .../drm/amd/display/dc/link/link_validation.h |   3 -
 .../dc/link/protocols/link_dp_dpia_bw.c       | 138 ++----------------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +-
 9 files changed, 19 insertions(+), 224 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 90c595e88aa0..130455f2802a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -515,11 +515,6 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 	link->dc->link_srv->enable_hpd_filter(link, enable);
 }
 
-bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *streams, const unsigned int count)
-{
-	return dc->link_srv->validate_dpia_bandwidth(streams, count);
-}
-
 enum dc_status dc_link_validate_dp_tunneling_bandwidth(const struct dc *dc, const struct dc_state *new_ctx)
 {
 	return dc->link_srv->validate_dp_tunnel_bandwidth(dc, new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c35978214e38..77773d3015ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2416,19 +2416,6 @@ void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
 void dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
 		struct dc_link *link, int peak_bw);
 
-/*
- * Validate the BW of all the valid DPIA links to make sure it doesn't exceed
- * available BW for each host router
- *
- * @dc: pointer to dc struct
- * @stream: pointer to all possible streams
- * @count: number of valid DPIA streams
- *
- * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
- */
-bool dc_link_dp_dpia_validate(struct dc *dc, const struct dc_stream_state *streams,
-		const unsigned int count);
-
 /*
  * Calculates the DP tunneling bandwidth required for the stream timing
  * and aggregates the stream bandwidth for the respective DP tunneling link
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index c92f11095254..f2503402c10e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -144,9 +144,6 @@ struct link_service {
 	uint32_t (*dp_link_bandwidth_kbps)(
 		const struct dc_link *link,
 		const struct dc_link_settings *link_settings);
-	bool (*validate_dpia_bandwidth)(
-			const struct dc_stream_state *stream,
-			const unsigned int num_streams);
 	enum dc_status (*validate_dp_tunnel_bandwidth)(
 		const struct dc *dc,
 		const struct dc_state *new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 8724050b7900..bd51b279ad14 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2295,10 +2295,11 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 		}
 
 		link->dpia_bw_alloc_config.remote_sink_req_bw[sink_index] = bw;
-		link->dpia_bw_alloc_config.dp_overhead = link_dpia_get_dp_mst_overhead(link);
-		req_bw += link->dpia_bw_alloc_config.dp_overhead;
 	}
 
+	link->dpia_bw_alloc_config.dp_overhead = link_dpia_get_dp_overhead(link);
+	req_bw += link->dpia_bw_alloc_config.dp_overhead;
+
 	link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 3ef2013508a4..c5f4e803be84 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -100,7 +100,6 @@ static void construct_link_service_validation(struct link_service *link_srv)
 {
 	link_srv->validate_mode_timing = link_validate_mode_timing;
 	link_srv->dp_link_bandwidth_kbps = dp_link_bandwidth_kbps;
-	link_srv->validate_dpia_bandwidth = link_validate_dpia_bandwidth;
 	link_srv->validate_dp_tunnel_bandwidth = link_validate_dp_tunnel_bandwidth;
 	link_srv->dp_required_hblank_size_bytes = dp_required_hblank_size_bytes;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 5b88a1c48dac..aecaf37eee35 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -367,65 +367,6 @@ enum dc_status link_validate_mode_timing(
 	return DC_OK;
 }
 
-/*
- * This function calculates the bandwidth required for the stream timing
- * and aggregates the stream bandwidth for the respective dpia link
- *
- * @stream: pointer to the dc_stream_state struct instance
- * @num_streams: number of streams to be validated
- *
- * return: true if validation is succeeded
- */
-bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const unsigned int num_streams)
-{
-	int bw_needed[MAX_DPIA_NUM] = {0};
-	struct dc_link *dpia_link[MAX_DPIA_NUM] = {0};
-	int num_dpias = 0;
-
-	for (unsigned int i = 0; i < num_streams; ++i) {
-		if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT) {
-			/* new dpia sst stream, check whether it exceeds max dpia */
-			if (num_dpias >= MAX_DPIA_NUM)
-				return false;
-
-			dpia_link[num_dpias] = stream[i].link;
-			bw_needed[num_dpias] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
-					dc_link_get_highest_encoding_format(dpia_link[num_dpias]));
-			num_dpias++;
-		} else if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			uint8_t j = 0;
-			/* check whether its a known dpia link */
-			for (; j < num_dpias; ++j) {
-				if (dpia_link[j] == stream[i].link)
-					break;
-			}
-
-			if (j == num_dpias) {
-				/* new dpia mst stream, check whether it exceeds max dpia */
-				if (num_dpias >= MAX_DPIA_NUM)
-					return false;
-				else {
-					dpia_link[j] = stream[i].link;
-					num_dpias++;
-				}
-			}
-
-			bw_needed[j] += dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
-				dc_link_get_highest_encoding_format(dpia_link[j]));
-		}
-	}
-
-	/* Include dp overheads */
-	for (uint8_t i = 0; i < num_dpias; ++i) {
-		int dp_overhead = 0;
-
-		dp_overhead = link_dpia_get_dp_mst_overhead(dpia_link[i]);
-		bw_needed[i] += dp_overhead;
-	}
-
-	return dpia_validate_usb4_bw(dpia_link, bw_needed, num_dpias);
-}
-
 static const struct dc_tunnel_settings *get_dp_tunnel_settings(const struct dc_state *context,
 		const struct dc_stream_state *stream)
 {
@@ -454,6 +395,7 @@ enum dc_status link_validate_dp_tunnel_bandwidth(const struct dc *dc, const stru
 	uint8_t link_count = 0;
 	enum dc_status result = DC_OK;
 
+	// Iterate through streams in the new context
 	for (uint8_t i = 0; (i < MAX_PIPES && i < new_ctx->stream_count); i++) {
 		const struct dc_stream_state *stream = new_ctx->streams[i];
 		const struct dc_link *link;
@@ -477,6 +419,7 @@ enum dc_status link_validate_dp_tunnel_bandwidth(const struct dc *dc, const stru
 
 		timing_bw = dp_get_timing_bandwidth_kbps(&stream->timing, link);
 
+		// Find an existing entry for this 'link' in 'dpia_link_sets'
 		for (uint8_t j = 0; j < MAX_DPIA_NUM; j++) {
 			bool is_new_slot = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 2a6ccded23df..9553c81053fe 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -30,9 +30,6 @@ enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
 		const struct dc_crtc_timing *timing);
-bool link_validate_dpia_bandwidth(
-		const struct dc_stream_state *stream,
-		const unsigned int num_streams);
 enum dc_status link_validate_dp_tunnel_bandwidth(
 		const struct dc *dc,
 		const struct dc_state *new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index cc1f4e6196ed..819bf2d8ba53 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -162,78 +162,6 @@ static void retrieve_usb4_dp_bw_allocation_info(struct dc_link *link)
 		link->dpia_bw_alloc_config.nrd_max_lane_count);
 }
 
-static uint8_t get_lowest_dpia_index(struct dc_link *link)
-{
-	const struct dc *dc_struct = link->dc;
-	uint8_t idx = 0xFF;
-	int i;
-
-	for (i = 0; i < MAX_LINKS; ++i) {
-
-		if (!dc_struct->links[i] ||
-				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
-			continue;
-
-		if (idx > dc_struct->links[i]->link_index) {
-			idx = dc_struct->links[i]->link_index;
-			break;
-		}
-	}
-
-	return idx;
-}
-
-/*
- * Get the maximum dp tunnel banwidth of host router
- *
- * @dc: pointer to the dc struct instance
- * @hr_index: host router index
- *
- * return: host router maximum dp tunnel bandwidth
- */
-static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_index)
-{
-	uint8_t lowest_dpia_index = get_lowest_dpia_index(dc->links[0]);
-	uint8_t hr_index_temp = 0;
-	struct dc_link *link_dpia_primary, *link_dpia_secondary;
-	int total_bw = 0;
-
-	for (uint8_t i = 0; i < MAX_LINKS - 1; ++i) {
-
-		if (!dc->links[i] || dc->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
-			continue;
-
-		hr_index_temp = (dc->links[i]->link_index - lowest_dpia_index) / 2;
-
-		if (hr_index_temp == hr_index) {
-			link_dpia_primary = dc->links[i];
-			link_dpia_secondary = dc->links[i + 1];
-
-			/**
-			 * If BW allocation enabled on both DPIAs, then
-			 * HR BW = Estimated(dpia_primary) + Allocated(dpia_secondary)
-			 * otherwise HR BW = Estimated(bw alloc enabled dpia)
-			 */
-			if ((link_dpia_primary->hpd_status &&
-				link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) &&
-				(link_dpia_secondary->hpd_status &&
-				link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled)) {
-					total_bw += link_dpia_primary->dpia_bw_alloc_config.estimated_bw +
-						link_dpia_secondary->dpia_bw_alloc_config.allocated_bw;
-			} else if (link_dpia_primary->hpd_status &&
-					link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) {
-				total_bw = link_dpia_primary->dpia_bw_alloc_config.estimated_bw;
-			} else if (link_dpia_secondary->hpd_status &&
-				link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled) {
-				total_bw += link_dpia_secondary->dpia_bw_alloc_config.estimated_bw;
-			}
-			break;
-		}
-	}
-
-	return total_bw;
-}
-
 /*
  * Cleanup function for when the dpia is unplugged to reset struct
  * and perform any required clean up
@@ -398,54 +326,9 @@ void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
 		DC_LOG_DEBUG("%s:  BW Allocation mode not available", __func__);
 }
 
-bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
-{
-	bool ret = true;
-	int bw_needed_per_hr[MAX_HOST_ROUTERS_NUM] = { 0 };
-	int host_router_total_dp_bw = 0;
-	uint8_t lowest_dpia_index, i, hr_index;
-
-	if (!num_dpias || num_dpias > MAX_DPIA_NUM)
-		return ret;
-
-	lowest_dpia_index = get_lowest_dpia_index(link[0]);
-
-	/* get total Host Router BW with granularity for the given modes */
-	for (i = 0; i < num_dpias; ++i) {
-		int granularity_Gbps = 0;
-		int bw_granularity = 0;
-
-		if (!link[i]->dpia_bw_alloc_config.bw_alloc_enabled)
-			continue;
-
-		if (link[i]->link_index < lowest_dpia_index)
-			continue;
-
-		granularity_Gbps = (Kbps_TO_Gbps / link[i]->dpia_bw_alloc_config.bw_granularity);
-		bw_granularity = (bw_needed_per_dpia[i] / granularity_Gbps) * granularity_Gbps +
-				((bw_needed_per_dpia[i] % granularity_Gbps) ? granularity_Gbps : 0);
-
-		hr_index = (link[i]->link_index - lowest_dpia_index) / 2;
-		bw_needed_per_hr[hr_index] += bw_granularity;
-	}
-
-	/* validate against each Host Router max BW */
-	for (hr_index = 0; hr_index < MAX_HOST_ROUTERS_NUM; ++hr_index) {
-		if (bw_needed_per_hr[hr_index]) {
-			host_router_total_dp_bw = get_host_router_total_dp_tunnel_bw(link[0]->dc, hr_index);
-			if (bw_needed_per_hr[hr_index] > host_router_total_dp_bw) {
-				ret = false;
-				break;
-			}
-		}
-	}
-
-	return ret;
-}
-
-uint32_t link_dpia_get_dp_mst_overhead(const struct dc_link *link)
+uint32_t link_dpia_get_dp_overhead(const struct dc_link *link)
 {
-	uint32_t link_mst_overhead = 0;
+	uint32_t link_dp_overhead = 0;
 
 	if ((link->type == dc_connection_mst_branch) &&
 				!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
@@ -458,12 +341,12 @@ uint32_t link_dpia_get_dp_mst_overhead(const struct dc_link *link)
 			uint32_t link_bw_in_kbps = (uint32_t)link_cap->link_rate *
 					   (uint32_t)link_cap->lane_count *
 					   LINK_RATE_REF_FREQ_IN_KHZ * 8;
-			link_mst_overhead = (link_bw_in_kbps / MST_TIME_SLOT_COUNT)
+			link_dp_overhead = (link_bw_in_kbps / MST_TIME_SLOT_COUNT)
 						+ ((link_bw_in_kbps % MST_TIME_SLOT_COUNT) ? 1 : 0);
 		}
 	}
 
-	return link_mst_overhead;
+	return link_dp_overhead;
 }
 
 /*
@@ -484,11 +367,13 @@ bool link_dpia_validate_dp_tunnel_bandwidth(const struct dc_validation_dpia_set
 	struct usb4_router_validation_set router_sets[MAX_HOST_ROUTERS_NUM] = { 0 };
 	uint8_t i;
 	bool is_success = true;
-	uint8_t rounter_count = 0;
+	uint8_t router_count = 0;
 
 	if ((dpia_link_sets == NULL) || (count == 0))
 		return is_success;
 
+	// Iterate through each DP tunneling link (DPIA).
+	// Aggregate its bandwidth requirements onto the respective USB4 router.
 	for (i = 0; i < count; i++) {
 		link = dpia_link_sets[i].link;
 		link_required_bw = dpia_link_sets[i].required_bw;
@@ -498,17 +383,18 @@ bool link_dpia_validate_dp_tunnel_bandwidth(const struct dc_validation_dpia_set
 			break;
 
 		if (link->type == dc_connection_mst_branch)
-			link_required_bw += link_dpia_get_dp_mst_overhead(link);
+			link_required_bw += link_dpia_get_dp_overhead(link);
 
 		granularity_Gbps = (Kbps_TO_Gbps / dp_tunnel_settings->bw_granularity);
 		link_bw_granularity = (link_required_bw / granularity_Gbps) * granularity_Gbps +
 				((link_required_bw % granularity_Gbps) ? granularity_Gbps : 0);
 
+		// Find or add the USB4 router associated with the current DPIA link
 		for (uint8_t j = 0; j < MAX_HOST_ROUTERS_NUM; j++) {
 			if (router_sets[j].is_valid == false) {
 				router_sets[j].is_valid = true;
 				router_sets[j].cm_id = dp_tunnel_settings->cm_id;
-				rounter_count++;
+				router_count++;
 			}
 
 			if (router_sets[j].cm_id == dp_tunnel_settings->cm_id) {
@@ -531,12 +417,14 @@ bool link_dpia_validate_dp_tunnel_bandwidth(const struct dc_validation_dpia_set
 		}
 	}
 
-	for (i = 0; i < rounter_count; i++) {
+	// Validate bandwidth for each unique router found.
+	for (i = 0; i < router_count; i++) {
 		uint32_t total_bw = 0;
 
 		if (router_sets[i].is_valid == false)
 			break;
 
+		// Determine the total available bandwidth for the current router based on aggregated data
 		if ((router_sets[i].dpia_count == 1) || (router_sets[i].allocated_bw == 0))
 			total_bw = router_sets[i].estimated_bw;
 		else
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 5b5b37486b89..41efcb3e44e2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -79,18 +79,6 @@ void link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
  */
 void dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
 
-/*
- * Handle the validation of total BW here and confirm that the bw used by each
- * DPIA doesn't exceed available BW for each host router (HR)
- *
- * @link[]: array of link pointer to all possible DPIA links
- * @bw_needed[]: bw needed for each DPIA link based on timing
- * @num_dpias: Number of DPIAs for the above 2 arrays. Should always be <= MAX_DPIA_NUM
- *
- * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
- */
-bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned int num_dpias);
-
 /*
  * Obtain all the DP overheads in dp tunneling for the dpia link
  *
@@ -98,7 +86,7 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned
  *
  * return: DP overheads in DP tunneling
  */
-uint32_t link_dpia_get_dp_mst_overhead(const struct dc_link *link);
+uint32_t link_dpia_get_dp_overhead(const struct dc_link *link);
 
 /*
  * Handle DP BW allocation status register
-- 
2.43.0

