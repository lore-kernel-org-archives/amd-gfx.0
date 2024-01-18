Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6A0C47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040010E83B;
	Thu, 18 Jan 2024 14:35:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1BE10E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8EvoZqTB4psAzEj6RUvKGxc8zZT5E3F2DtdloWyTIDAiP18veMVJtYU46FHv28AOY3PvpAP7hqdKHlme9l02EiLQuQjzKkH1tc8PUy3AUJdBa6LwhdW1BHytPbu3DKWfJtQV4r+xhLuorUP/bbCbuDnOAhkDqk5oaMg2IosPTjL4CsBxAyhde85YAwEC8ue6zqMGVdeMr1d8p+L0hV1PeHVaRMdvrDSiEvM9FzJHY1emGUQQ8tasJtS580/vYkHPvFs84WcqJ8Nv3Mze6Pu8QyC33V3hI2O1qQU3ARuT1v4JY3zEhqOBLV0IOLW2l2m0p2KkzWAx9WjP9a8Wjy2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTFhozzz5XRoyfjRhcnse7a1jutgnXMAyl067Rqw3IQ=;
 b=mXcL7cTtHIxYtLDW5+Z4Oclxh/3fZtPtPuSJPPs/Z7AVPRuCQPF8E1qyeGiNhLSTez2lcjqY9m9JHswEMsQI10LyR9fd4GVI1aQDNsOsrtSETkJyxyHGsUgdazKTEkpzzNDKeCLtBs1wJlVGVl5u0wuangfnHc0OV3R1FAXWe6na+8ZJZvqmLEsihi3wmO9qENGs/kvPFQstEYv0q9UazcupMv+qqLwb8VqSvme7rT/eR9S5qrW7WG2FlWw0zqhd7rwEs/SORzL/vBi37cXLXmQe6K+HfWo96aFe1WkxUvq4qHtboCX7PNJzYclMUorvtuBbUfcYQ9TnZxiA4jr8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTFhozzz5XRoyfjRhcnse7a1jutgnXMAyl067Rqw3IQ=;
 b=xjk+fmOKFVrB+ReBKe0MszTbt184s+r5C5iYFoZ3v5IsdmfftlfOwkkYORiqB3PQzmMna8MJYrhdKfbQTjEQcYkjd8cTsnECtoBrrvE4lJdcLH6ji67xDu70EPfi09d0s5B43WybRtX9A6DOAeyqjVuqEe6On5wB8TrTFfyRAv4=
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:34:48 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::d3) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:40 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:39 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Add usb4_bw_alloc_support flag
Date: Thu, 18 Jan 2024 09:33:51 -0500
Message-ID: <20240118143400.1001088-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: d897728f-a882-4853-1185-08dc18329fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8IxO7OBTxNEpXOap6jUk0Ki99MLiG1y5fDZ2ypZL3YH9vU4x47vfD1yLF5M5Lb6CMF0x2kL8ATBchO+UYmRvcwV4KrSUW+C/fFOvtLNFqchmWnZnSDWiZVA3ZrXrdkCnvBbrUZPNRV5Ey6QR+4BzYwqnpt//0a3vJTEaPydEoYoR6HtaA6jSc2A49HmRmy8c5/QCVtf1PGo79vKrgQQQXnBfm5nP5gOj2jasyFv+oao5RPPBH/yulBZ24yBVuXriVxbIiBKGXgrWDEZWGl6fxAkcuXmMjCuytA+DUEjDUkeohHfN8V1EEL9g/KUguGPpRGey/kaA+tUqwjO5em7Py/ino4LEcX/ZqV9Cc+ZAURvZDt9GDWirTb3WY9yaePohP6abNab3RE8y88BA5AYXOEFq0T7c3At73/TsmxBvhJm0hBcaQj+XcaOidrJDi6ZWhM6PU713YDIGIqJ01CfWhP8nKr9gaNu01iPL15VBu9w8zYdxTTpFTVIQoLFGV4LO56bIrQ5O89nF2umwxMnTdKl3R455yj1ATWe65TUPzPFcifH3K8GJjX/Itpc2Vrs7tJuOOIhEBDlNnxV0emclhKyEfz5n4QtUKh1gTidsKipoLsUZS6LJD1f0NqW2Yk68ELZL6/eWTWABECSJYIy8px+lm2KsXT4mHPB+T1tNf/WfGtuY4cdkkH66sqgQOxHH4HS2/vXim1A6MIfa9Y3FrdbTU1j0pEzwUfdYW93HB3KRFDeJsU3C2pERg0B8x7GkWPy7NpEulu+ZFHg5lwGLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(7696005)(6666004)(1076003)(336012)(2616005)(426003)(26005)(36860700001)(5660300002)(47076005)(83380400001)(4326008)(2876002)(2906002)(70206006)(54906003)(8676002)(70586007)(6916009)(316002)(478600001)(8936002)(41300700001)(36756003)(82740400003)(81166007)(86362001)(356005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:48.5166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d897728f-a882-4853-1185-08dc18329fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Peichen Huang <peichen.huang@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peichen Huang <peichen.huang@amd.com>

[Why]
dc should have a flag for DM to enable usb4_bw_alloc in dptx

[How]
- Add usb4_bw_alloc_support flag in dc_config

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  | 18 ++++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 58 +++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 432ae08462e4..e338576f95a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -435,6 +435,7 @@ struct dc_config {
 	bool enable_auto_dpm_test_logs;
 	unsigned int disable_ips;
 	unsigned int disable_ips_in_vpb;
+	bool usb4_bw_alloc_support;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 24153b0df503..b8c4a04dd175 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -41,6 +41,7 @@
 #include "protocols/link_dp_dpia.h"
 #include "protocols/link_dp_phy.h"
 #include "protocols/link_dp_training.h"
+#include "protocols/link_dp_dpia_bw.h"
 #include "accessories/link_dp_trace.h"
 
 #include "link_enc_cfg.h"
@@ -991,6 +992,23 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
 				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
+
+			/*
+			 * If this is DP over USB4 link then we need to:
+			 * - Enable BW ALLOC support on DPtx if applicable
+			 */
+			if (dc->config.usb4_bw_alloc_support) {
+				if (link_dp_dpia_set_dptx_usb4_bw_alloc_support(link)) {
+					/* update with non reduced link cap if bw allocation mode is supported */
+					if (link->dpia_bw_alloc_config.nrd_max_link_rate &&
+						link->dpia_bw_alloc_config.nrd_max_lane_count) {
+						link->reported_link_cap.link_rate =
+							link->dpia_bw_alloc_config.nrd_max_link_rate;
+						link->reported_link_cap.lane_count =
+							link->dpia_bw_alloc_config.nrd_max_lane_count;
+					}
+				}
+			}
 			break;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 3cbfbf8d107e..a72de44a5747 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2197,6 +2197,64 @@ static enum dc_status enable_link(
 
 static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int bw)
 {
+	struct dc_link *link = stream->sink->link;
+	int req_bw = bw;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	if (!link->dpia_bw_alloc_config.bw_alloc_enabled)
+		return false;
+
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		int sink_index = 0;
+		int i = 0;
+
+		for (i = 0; i < link->sink_count; i++) {
+			if (link->remote_sinks[i] == NULL)
+				continue;
+
+			if (stream->sink->sink_id != link->remote_sinks[i]->sink_id)
+				req_bw += link->dpia_bw_alloc_config.remote_sink_req_bw[i];
+			else
+				sink_index = i;
+		}
+
+		link->dpia_bw_alloc_config.remote_sink_req_bw[sink_index] = bw;
+	}
+
+	/* get dp overhead for dp tunneling */
+	link->dpia_bw_alloc_config.dp_overhead = link_dp_dpia_get_dp_overhead_in_dp_tunneling(link);
+	req_bw += link->dpia_bw_alloc_config.dp_overhead;
+
+	if (link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw)) {
+		if (req_bw <= link->dpia_bw_alloc_config.allocated_bw) {
+			DC_LOG_DEBUG("%s, Success in allocate bw for link(%d), allocated_bw(%d), dp_overhead(%d)\n",
+					__func__, link->link_index, link->dpia_bw_alloc_config.allocated_bw,
+					link->dpia_bw_alloc_config.dp_overhead);
+		} else {
+			// Cannot get the required bandwidth.
+			DC_LOG_ERROR("%s, Failed to allocate bw for link(%d), allocated_bw(%d), dp_overhead(%d)\n",
+					__func__, link->link_index, link->dpia_bw_alloc_config.allocated_bw,
+					link->dpia_bw_alloc_config.dp_overhead);
+			return false;
+		}
+	} else {
+		DC_LOG_DEBUG("%s, usb4 request bw timeout\n", __func__);
+		return false;
+	}
+
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		int i = 0;
+
+		for (i = 0; i < link->sink_count; i++) {
+			if (link->remote_sinks[i] == NULL)
+				continue;
+			DC_LOG_DEBUG("%s, remote_sink=%s, request_bw=%d\n", __func__,
+					(const char *)(&link->remote_sinks[i]->edid_caps.display_name[0]),
+					link->dpia_bw_alloc_config.remote_sink_req_bw[i]);
+		}
+	}
+
 	return true;
 }
 
-- 
2.34.1

