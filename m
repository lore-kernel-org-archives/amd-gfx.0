Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D914EC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6657A10E4DB;
	Thu,  4 Jan 2024 15:53:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB38C10E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiFt6A6hrkablevEoI2Sga70nGIJu8Urb2oN/UvUCN/BiFb69KGqaGAYWI/Rt7d4f8eUZc42/Y09B0Ao+x5Ge7BCSoT8C04vBKcbz9QzkICvhQbULuK8MJkPlNp2xeY9g8Ukyic3B79E6Dc7BOpE6brGkRZAn7CkLvUsTbFZJIi+mhHkeCczr3tlf28God2kv+5OpnuliHRhF/xNv2yRevnSDSgL/MW7WA4pgiEr7IwjDMw6f9eoTlR0rUgkRGe5vCxNsg5yCuR8RNfEJZrwgexSbCMqDqzIgg1e5PW1KRaaKwt2tP0fg7rDGUIOWP1HNtPuyDwEK7Hs98tmEa5mrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6V2+wTZ/it97KEwTTFCd5uamj0N4lGWQZB5ODgQw7o=;
 b=Mnyne7JuFADjKIDSSONQceVKbkIClqt5xOM/p4Dk1vPzxMkZIykzAoqwvPPiOxbDPlVjLfpo+e/ERG9JNXIGctHSHc7mBEZHqKAI4c72EAcs8bXnbbNSi86tw5F2Czg21UTpouJm0HbgyQ49VNmgGO1Vnz3tlrGm7rBAFLj959OmQhhBvk2SwucJ28aiz86cXYnqjSb1NT0kxxlc5wKAqfPZ4sk+XmXr/n3DbVpMcj4/qCbYG3uZGHa573eaOPXQm//EbMzmjjxVvCJRcsreYw36NnYGQL1phVw2p7pJAj/TsHDml1d/NlXDL2o5UUMpuU9RPfK4IS7CuLr942hjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6V2+wTZ/it97KEwTTFCd5uamj0N4lGWQZB5ODgQw7o=;
 b=5HkUO/BawQCG3yMUrM9xwDAD+LVrS+H6BF3vUqrXCRMMxPx6QktRiP6gueVZM/jOa09+aDuNwlfjGQkE2nv1CQBl/MpbSkAFATlzMoFhQrCB1dslTLt3b0u6ZUugmwvwmtWPHKUOMzbJdtEiGAXPIXeurMbBZfBqLbJafYT0ob8=
Received: from PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::19)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 15:53:27 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ce) by PH0P220CA0016.outlook.office365.com
 (2603:10b6:510:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:26 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:21 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amd/display: Request usb4 bw for mst streams
Date: Thu, 4 Jan 2024 08:51:02 -0700
Message-ID: <20240104155238.454117-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CO6PR12MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c3285e-a7f2-4408-08d5-08dc0d3d4a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIakrtQbVyYIf7tIQi5FcZFmtgfvcRcNoHVWcIVw4tUD4Gz/hldzEu//FmJbkIjZJ8oo/0LJCPnqiYVm6T73gnO6+pUXWHDMyzfl7b7WijUnaIw2Tmgkt5OKw/ZND2qhn+OE8BEu96UjJBqafUPUDNOV1xDykjopuwHqUkaoAWRXAbwOmK99MNcocOCEwv8O6N1DEsi5f271L+lIvPNyBfS6eN1ojPAg16AFjM2ntmX23nBs922R12nEcspwxeIYtEyZdm+WrFUbLfeAfMcWa+iynrtx7GJedAuXpD4V9U1l6pGkHFaeFGsEehzvlsR+aWlSGVIm6ipBpjLAV8V8cqeBuv6zLUHnLnjLRkD69iYeWGMDJC+uoMFpBuJvNdEUTmkdqJ83/ukLcwVPfSYcUg3FIaoRvNOTkFyDPRJ/i+muyQeFlwgyr/pdLpm8UIfx3Kl9IO4PVKr0zuYCy4ARX5TbyymwNw79kwHOALvKs+EfkiV/pCs+W1Rg8G/heBREffa93M/3VKm+ws0Hn6VGXNv8y4lRbnl9Gdb7s0ngr8C+1NFiOpT9gPrWu4LuPIcqj/PlqXrEYXjrvzmt0EgVx7QET819jR8ncAbshj00q/YkHGkfv11Y0i0PQUXjFPYzkOMSENDs/gX2Qtths/hfLznHF8xg+I8GeVkMJuCZFXmG5/pvxogAz1J5poSxijMmPEBsy885rK3ZbiqaGmK+Z6W/BbRM790pblw4u7FRcm5xU7H7hXzK1GFSCZQDKkjY7lOrKK3KrnbVyEG/OgvINQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(36756003)(66899024)(478600001)(70586007)(70206006)(86362001)(16526019)(83380400001)(66574015)(47076005)(2616005)(81166007)(356005)(426003)(26005)(1076003)(5660300002)(336012)(30864003)(316002)(2906002)(6916009)(6666004)(4326008)(54906003)(82740400003)(41300700001)(36860700001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:26.5495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c3285e-a7f2-4408-08d5-08dc0d3d4a0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Cruise Hung <cruise.hung@amd.com>,
 agustin.gutierrez@amd.com, Peichen Huang <peichen.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peichen Huang <peichen.huang@amd.com>

[WHY]
When usb4 bandwidth allocation mode is enabled, driver need to request
bandwidth from connection manager. For mst link,  the requested
bandwidth should be big enough for all remote streams.

[HOW]
- If mst link, the requested bandwidth should be the sum of all mst
  streams bandwidth added with dp MTPH overhead.
- Allocate/deallcate usb4 bandwidth when setting dpms on/off.
- When doing display mode validation, driver also need to consider total
  bandwidth of all mst streams for mst link.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 12 ++--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 42 ++++++++++---
 .../drm/amd/display/dc/link/link_validation.c | 60 +++++++++++++++----
 .../dc/link/protocols/link_dp_dpia_bw.c       | 59 +++++++++++++-----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  9 +++
 5 files changed, 144 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4f276169e05a..b08ccb8c68bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1140,23 +1140,25 @@ struct dc_panel_config {
 	} ilr;
 };
 
+#define MAX_SINKS_PER_LINK 4
+
 /*
  *  USB4 DPIA BW ALLOCATION STRUCTS
  */
 struct dc_dpia_bw_alloc {
-	int sink_verified_bw;  // The Verified BW that sink can allocated and use that has been verified already
-	int sink_allocated_bw; // The Actual Allocated BW that sink currently allocated
-	int sink_max_bw;       // The Max BW that sink can require/support
+	int remote_sink_req_bw[MAX_SINKS_PER_LINK]; // BW requested by remote sinks
+	int link_verified_bw;  // The Verified BW that link can allocated and use that has been verified already
+	int link_max_bw;       // The Max BW that link can require/support
+	int allocated_bw;      // The Actual Allocated BW for this DPIA
 	int estimated_bw;      // The estimated available BW for this DPIA
 	int bw_granularity;    // BW Granularity
+	int dp_overhead;       // DP overhead in dp tunneling
 	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
 	bool response_ready;   // Response ready from the CM side
 	uint8_t nrd_max_lane_count; // Non-reduced max lane count
 	uint8_t nrd_max_link_rate; // Non-reduced max link rate
 };
 
-#define MAX_SINKS_PER_LINK 4
-
 enum dc_hpd_enable_select {
 	HPD_EN_FOR_ALL_EDP = 0,
 	HPD_EN_FOR_PRIMARY_EDP_ONLY,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 5fe8b4871c77..3de148004c06 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2005,17 +2005,11 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		}
 	}
 
-	/*
-	 * If the link is DP-over-USB4 do the following:
-	 * - Train with fallback when enabling DPIA link. Conventional links are
+	/* Train with fallback when enabling DPIA link. Conventional links are
 	 * trained with fallback during sink detection.
-	 * - Allocate only what the stream needs for bw in Gbps. Inform the CM
-	 * in case stream needs more or less bw from what has been allocated
-	 * earlier at plug time.
 	 */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
 		do_fallback = true;
-	}
 
 	/*
 	 * Temporary w/a to get DP2.0 link rates to work with SST.
@@ -2197,6 +2191,32 @@ static enum dc_status enable_link(
 	return status;
 }
 
+static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int bw)
+{
+	return true;
+}
+
+static bool allocate_usb4_bandwidth(struct dc_stream_state *stream)
+{
+	bool ret;
+
+	int bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
+			dc_link_get_highest_encoding_format(stream->sink->link));
+
+	ret = allocate_usb4_bandwidth_for_stream(stream, bw);
+
+	return ret;
+}
+
+static bool deallocate_usb4_bandwidth(struct dc_stream_state *stream)
+{
+	bool ret;
+
+	ret = allocate_usb4_bandwidth_for_stream(stream, 0);
+
+	return ret;
+}
+
 void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 {
 	struct dc  *dc = pipe_ctx->stream->ctx->dc;
@@ -2232,6 +2252,9 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
+	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		deallocate_usb4_bandwidth(pipe_ctx->stream);
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
 	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
@@ -2474,6 +2497,9 @@ void link_set_dpms_on(
 		}
 	}
 
+	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		allocate_usb4_bandwidth(pipe_ctx->stream);
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		allocate_mst_payload(pipe_ctx);
 	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index b45fda96eaf6..8fe66c367850 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -346,23 +346,61 @@ enum dc_status link_validate_mode_timing(
 	return DC_OK;
 }
 
+/*
+ * This function calculates the bandwidth required for the stream timing
+ * and aggregates the stream bandwidth for the respective dpia link
+ *
+ * @stream: pointer to the dc_stream_state struct instance
+ * @num_streams: number of streams to be validated
+ *
+ * return: true if validation is succeeded
+ */
 bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const unsigned int num_streams)
 {
-	bool ret = true;
-	int bw_needed[MAX_DPIA_NUM];
-	struct dc_link *link[MAX_DPIA_NUM];
-
-	if (!num_streams || num_streams > MAX_DPIA_NUM)
-		return ret;
+	int bw_needed[MAX_DPIA_NUM] = {0};
+	struct dc_link *dpia_link[MAX_DPIA_NUM] = {0};
+	int num_dpias = 0;
 
 	for (uint8_t i = 0; i < num_streams; ++i) {
+		if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT) {
+			/* new dpia sst stream, check whether it exceeds max dpia */
+			if (num_dpias >= MAX_DPIA_NUM)
+				return false;
 
-		link[i] = stream[i].link;
-		bw_needed[i] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
-				dc_link_get_highest_encoding_format(link[i]));
+			dpia_link[num_dpias] = stream[i].link;
+			bw_needed[num_dpias] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
+					dc_link_get_highest_encoding_format(dpia_link[num_dpias]));
+			num_dpias++;
+		} else if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			uint8_t j = 0;
+			/* check whether its a known dpia link */
+			for (; j < num_dpias; ++j) {
+				if (dpia_link[j] == stream[i].link)
+					break;
+			}
+
+			if (j == num_dpias) {
+				/* new dpia mst stream, check whether it exceeds max dpia */
+				if (num_dpias >= MAX_DPIA_NUM)
+					return false;
+				else {
+					dpia_link[j] = stream[i].link;
+					num_dpias++;
+				}
+			}
+
+			bw_needed[j] += dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
+				dc_link_get_highest_encoding_format(dpia_link[j]));
+		}
 	}
 
-	ret = dpia_validate_usb4_bw(link, bw_needed, num_streams);
+	/* Include dp overheads */
+	for (uint8_t i = 0; i < num_dpias; ++i) {
+		int dp_overhead = 0;
+
+		dp_overhead = link_dp_dpia_get_dp_overhead_in_dp_tunneling(dpia_link[i]);
+		bw_needed[i] += dp_overhead;
+	}
 
-	return ret;
+	return dpia_validate_usb4_bw(dpia_link, bw_needed, num_dpias);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index a7aa8c9da868..4ef1a6a1d129 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -54,12 +54,18 @@ static bool get_bw_alloc_proceed_flag(struct dc_link *tmp)
 static void reset_bw_alloc_struct(struct dc_link *link)
 {
 	link->dpia_bw_alloc_config.bw_alloc_enabled = false;
-	link->dpia_bw_alloc_config.sink_verified_bw = 0;
-	link->dpia_bw_alloc_config.sink_max_bw = 0;
+	link->dpia_bw_alloc_config.link_verified_bw = 0;
+	link->dpia_bw_alloc_config.link_max_bw = 0;
+	link->dpia_bw_alloc_config.allocated_bw = 0;
 	link->dpia_bw_alloc_config.estimated_bw = 0;
 	link->dpia_bw_alloc_config.bw_granularity = 0;
+	link->dpia_bw_alloc_config.dp_overhead = 0;
 	link->dpia_bw_alloc_config.response_ready = false;
-	link->dpia_bw_alloc_config.sink_allocated_bw = 0;
+	link->dpia_bw_alloc_config.nrd_max_lane_count = 0;
+	link->dpia_bw_alloc_config.nrd_max_link_rate = 0;
+	for (int i = 0; i < MAX_SINKS_PER_LINK; i++)
+		link->dpia_bw_alloc_config.remote_sink_req_bw[i] = 0;
+	DC_LOG_DEBUG("reset usb4 bw alloc of link(%d)\n", link->link_index);
 }
 
 #define BW_GRANULARITY_0 4 // 0.25 Gbps
@@ -210,8 +216,8 @@ static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_in
 				link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) &&
 				(link_dpia_secondary->hpd_status &&
 				link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled)) {
-				total_bw += link_dpia_primary->dpia_bw_alloc_config.estimated_bw +
-					link_dpia_secondary->dpia_bw_alloc_config.sink_allocated_bw;
+					total_bw += link_dpia_primary->dpia_bw_alloc_config.estimated_bw +
+						link_dpia_secondary->dpia_bw_alloc_config.allocated_bw;
 			} else if (link_dpia_primary->hpd_status &&
 					link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) {
 				total_bw = link_dpia_primary->dpia_bw_alloc_config.estimated_bw;
@@ -264,7 +270,7 @@ static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 
 	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw) {
+	if (req_bw == link->dpia_bw_alloc_config.allocated_bw) {
 		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
 			__func__, link->link_index);
 	}
@@ -387,9 +393,9 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 		DC_LOG_DEBUG("%s: BW REQ SUCCESS for DP-TX Request for link(%d)\n",
 			__func__, link->link_index);
 		DC_LOG_DEBUG("%s: current allocated_bw(%d), new allocated_bw(%d)\n",
-			__func__, link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed);
+			__func__, link->dpia_bw_alloc_config.allocated_bw, bw_needed);
 
-		link->dpia_bw_alloc_config.sink_allocated_bw = bw_needed;
+		link->dpia_bw_alloc_config.allocated_bw = bw_needed;
 
 		link->dpia_bw_alloc_config.response_ready = true;
 		break;
@@ -427,8 +433,8 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 	if (link->hpd_status && peak_bw > 0) {
 
 		// If DP over USB4 then we need to check BW allocation
-		link->dpia_bw_alloc_config.sink_max_bw = peak_bw;
-		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
+		link->dpia_bw_alloc_config.link_max_bw = peak_bw;
+		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.link_max_bw);
 
 		do {
 			if (timeout > 0)
@@ -440,8 +446,8 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 
 		if (!timeout)
 			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
-		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
-			ret = link->dpia_bw_alloc_config.sink_allocated_bw;
+		else if (link->dpia_bw_alloc_config.allocated_bw > 0)
+			ret = link->dpia_bw_alloc_config.allocated_bw;
 	}
 	//2. Cold Unplug
 	else if (!link->hpd_status)
@@ -450,7 +456,6 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 out:
 	return ret;
 }
-
 bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
 {
 	bool ret = false;
@@ -458,7 +463,7 @@ bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int r
 
 	DC_LOG_DEBUG("%s: ENTER: link(%d), hpd_status(%d), current allocated_bw(%d), req_bw(%d)\n",
 		__func__, link->link_index, link->hpd_status,
-		link->dpia_bw_alloc_config.sink_allocated_bw, req_bw);
+		link->dpia_bw_alloc_config.allocated_bw, req_bw);
 
 	if (!get_bw_alloc_proceed_flag(link))
 		goto out;
@@ -523,3 +528,29 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const
 
 	return ret;
 }
+
+int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link)
+{
+	int dp_overhead = 0, link_mst_overhead = 0;
+
+	if (!get_bw_alloc_proceed_flag((link)))
+		return dp_overhead;
+
+	/* if its mst link, add MTPH overhead */
+	if ((link->type == dc_connection_mst_branch) &&
+		!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+		/* For 8b/10b encoding: MTP is 64 time slots long, slot 0 is used for MTPH
+		 * MST overhead is 1/64 of link bandwidth (excluding any overhead)
+		 */
+		const struct dc_link_settings *link_cap =
+			dc_link_get_link_cap(link);
+		uint32_t link_bw_in_kbps =
+			link_cap->link_rate * link_cap->lane_count * LINK_RATE_REF_FREQ_IN_KHZ * 8;
+		link_mst_overhead = (link_bw_in_kbps / 64) + ((link_bw_in_kbps % 64) ? 1 : 0);
+	}
+
+	/* add all the overheads */
+	dp_overhead = link_mst_overhead;
+
+	return dp_overhead;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 981bc4eb6120..3b6d8494f9d5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -99,4 +99,13 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
  */
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, const unsigned int num_dpias);
 
+/*
+ * Obtain all the DP overheads in dp tunneling for the dpia link
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: DP overheads in DP tunneling
+ */
+int link_dp_dpia_get_dp_overhead_in_dp_tunneling(struct dc_link *link);
+
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.43.0

