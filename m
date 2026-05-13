Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CFCD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4662D10EED1;
	Wed, 13 May 2026 14:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="asij/MqU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5BC10EEE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4lx6ap5sOUzulKZd3aNP5jJwO6MP2MqPgSZAwhK5HxdrwLqKw50XObQD9lCEjL7jhKUj4wdClTBpEzKsktyvNaWGkwxmoqr5P4mFkuXJZcxbx3CgGZe12BK5vKsjn5PQ5CoTajiGV+7gecjEG2RAD+L2PQaWEZ3oGRuWDyFiDMGha2Ovtn1HCUi2OvSin6dRdIgzeSb2R282g0fvojRdqxcI5u2SFcDpozo6YIGo0mfDhPgo0d66neV02Zm5kpi8Yq29/QZkD9HNdaa16POybbkGgMFDHoOI7aPOxjzNF7ZXt7iIK4rpSaRVt/jRIgXnkDO6scNvzWU35bT8/GOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UooHWcE5OEb83n9CUoWGHuNZq/RWcezqsSqKfTj7Mic=;
 b=qVPaSav/gKohPeCTZnixFTUiIv8RXhGxe+Q8r9O359wH/MUO7mebBltQgfpbaU0oO/vH3uAQGtj5tt+DgcylIUs2GcMxQu//nRcKPvHd4sqzrdMs7ID5H6Q2GAJ+xOucpINifpfQFk9/hmhfaC+FQ2jeDITb5sTdeSMNd6qqYI9XkIwHxDqlIwVY6ArPLyUM8Gqcqzv/Z+V2eBTrVOv3DFOwhsz1zk/fhVmASlCGcHD3OFREIpGFHNbpQqU2MqvOTVeT7kPH+c+x/lyT6B0M2hiKWA97S/ilJ3CsK8QOYXfOO5+e/pQHijGlOSSspVNug/aKh8EofUUBWeFqh6aCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UooHWcE5OEb83n9CUoWGHuNZq/RWcezqsSqKfTj7Mic=;
 b=asij/MqUQVXlKL9Zj4i6Ev5+P5GlnqfBCJ/fSS5YlWMx0nUwQIy6Efw2nmElZqN6Y7l1JXijGBJdKKjF2xbkGXVa5iQP2SB18UPuaJ58MjuotzlhQInANDBDKJdiffkHO54nTMq5wFu08f3RRhx8D0OWxvaQatRgoVqFcmZiQ+M=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:43 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::40) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 14:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:37 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:36 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Exclude the MST overhead from BW
 deallocation
Date: Wed, 13 May 2026 10:29:41 -0400
Message-ID: <20260513143213.1852892-21-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc3dbe8-ec32-4a20-8f50-08deb0fca24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qdlfHzXAmPL1M+s8EzUuB89qUZdM9/uC1RjB5oLzDVt2BUsHBk3r3W8tSuTYUcScB0/1kny7ClNIUrk7xJfqwMfWDNy67ZlsKOVRetwkfFT5NwAbPPS1Qbc/a/y+uWnrztR9LnHNXtDCEzcGvMAzj46YJ2JZgj1v5DeIazs8L2accw4XZ9wtXFCSFMw+Y0T0LKYUcQJhQ/59dd3eknrD8xb1si9zxV19+eWQm8Puy8ULuRZbrcOMjwhAOwcELjV2QpIjm6BxIyuG+dTQXEYb1ttO0L/tbxxQGGiuRE207L96RN19anewsrirT11y8wAsghMt5dRSl1FTEU60WY/1MFLS2Mq215oVawgBwbv82YImZWccX7h2OhjFU2zr+Z/vXmfY10JZ2+dFv36/X1md2dC1NRLAs7rSmsG+d2yLjFlktcqbN1GJcvjxTbyV+coWobuIw46+eMObb8tCti/OqHhoRZT+EaECzlOIXCS3EsyfBzNRKbapShFwWwMtaZTazU8zjKcKqD2Nk5++Lazfd+s5ackF8FkQhigokIArx4UU+54O0cDAstldPLhV1UUaRIAIepBf7/JaXsXxxpAVRsmZNXE40F4AN56944nYP7EUkBh2kJVkWiLmIXJMyW5wYNYQrrDm+PohAPLBPNsWWDGm3fMe1CQmqH5mReO3Em3tlbrpM8JbRvVGuHh5QxPwPiCUEGCtGrbg/YSzVhO4M+25dlCrTMsPKofj9pl+gn4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ftUGirM6gChyndxtSvcrhBR5nZoIolLbKfhS2UF/BKATJfVgEQUPrhUwFWhxjaLDEumfr6jde8DI8RmW0mxin+3c1/odftYDiPEfLDs4o6qU6/OitQBKncVt1Ua+QUCdiXIh/IugM6VKWOuZsuDPyvxntipj3Eyj75dRNF9Mh2ij39RdgrJSC5/Q+9qoUSpcD6FDllflivZz8oRMwL8qZw3HmjV0AS0QyjmohPQqfH+WW4DpJB4zC8snIypQGP7BLpH2iIIa/BgbybLMB63hVWi2yei2TqkGifW1R2cAmFc+mBAkIwj9L2MJTvqBkuYinGzgpVT+prlxMtgWAGOmoBTByc4YLH4iwgi/TZFQb1GtRg7NteHK8UFeaGDYY8LDXL/iFNnOcfn344Cok0dm4hAiKKvduAMbzxrUVMS4K/nviYhsMJl33oKvqFt/PeoC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:43.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc3dbe8-ec32-4a20-8f50-08deb0fca24f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

[Why]
The MST overhead was incorrectly included
in the requested BW during BW deallocation.

[How]
Exclude the MST overhead from BW deallocation.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d52155e86f0f..21f64946b993 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2097,10 +2097,10 @@ static enum dc_status enable_link(
 	return status;
 }
 
-static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int bw)
+static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int stream_bw)
 {
 	struct dc_link *link = stream->sink->link;
-	int req_bw = bw;
+	int req_bw = stream_bw;
 
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -2108,39 +2108,38 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 		return false;
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		int sink_index = 0;
+		int sink_index = -1;
 		unsigned int i = 0;
 
 		for (i = 0; i < link->sink_count; i++) {
 			if (link->remote_sinks[i] == NULL)
 				continue;
 
-			if (stream->sink->sink_id != link->remote_sinks[i]->sink_id)
+			if (stream->sink->sink_id != link->remote_sinks[i]->sink_id) {
+				DC_LOG_DEBUG("%s: add remote_sink=%s, request_bw=%d\n", __func__,
+					(const char *)(&link->remote_sinks[i]->edid_caps.display_name[0]),
+					link->dpia_bw_alloc_config.remote_sink_req_bw[i]);
+
 				req_bw += link->dpia_bw_alloc_config.remote_sink_req_bw[i];
-			else
+			} else
 				sink_index = i;
 		}
 
-		link->dpia_bw_alloc_config.remote_sink_req_bw[sink_index] = bw;
-	}
+		if (sink_index >= 0)
+			link->dpia_bw_alloc_config.remote_sink_req_bw[sink_index] = stream_bw;
+		else
+			DC_LOG_WARNING("%s: stream sink_id=%u not found in remote_sinks[]\n",
+				__func__, stream->sink->sink_id);
 
-	link->dpia_bw_alloc_config.dp_overhead = link_dpia_get_dp_overhead(link);
-	req_bw += link->dpia_bw_alloc_config.dp_overhead;
+		if (req_bw) {
+			link->dpia_bw_alloc_config.dp_overhead = link_dpia_get_dp_overhead(link);
+			req_bw += link->dpia_bw_alloc_config.dp_overhead;
+		} else
+			link->dpia_bw_alloc_config.dp_overhead = 0;
+	}
 
 	link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw);
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		unsigned int i = 0;
-
-		for (i = 0; i < link->sink_count; i++) {
-			if (link->remote_sinks[i] == NULL)
-				continue;
-			DC_LOG_DEBUG("%s, remote_sink=%s, request_bw=%d\n", __func__,
-					(const char *)(&link->remote_sinks[i]->edid_caps.display_name[0]),
-					link->dpia_bw_alloc_config.remote_sink_req_bw[i]);
-		}
-	}
-
 	return true;
 }
 
-- 
2.43.0

