Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31A8C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8FF10E6CE;
	Wed, 30 Jul 2025 19:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKzBOOV2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7205110E6CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8t6/Vbw2xFlDExOTimuJcRlijJMY649JTkEUUzLTCQCmwuNFOrH/AMF5SO6du7dOm4wHxLZq8iOH1V+eaTuPMT9FjEv/BjFoNdXCxFY2LoBhqqevONiAvgTAXWHYoaBmJMQXbchQYX00399A+ek5B5Qkc/4rbe6h0G8ALu473q0T9+SLe6Wnz15X//1QOqEdNE93wQbzifvMgT5IfRyL1iod6va2yO2r6sbSLZxGp+n70VXKMZY0G1tlmGpWhVYrpfi9F5F1MDy9nwnMJ3W1ePAuBlogI32SkVfnhDb8G0tfiWTPtbcOFbz7/kyyRzCbAZhU0i3DCJ52PQ3GhTKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgrmpMwkGUN6O4ScDV4B8ZUDeP0qo0yuOCFOp9CE15Q=;
 b=KdRhtZnm1pKi9K5X+QrfJYUvUq+oxwTqRniSRCruf7kcq3LS7OjBtylk9WLarZGbN+EgT6RWIX+pta41eHXM9WWYdqtTJic7PnRBnN+Itpp+zVbISoICJS98KLc2SgobfuznjCZLlYt6LoDOVBhVrJW6rNF2YNdvLk7UeEfTyIaES5jh5CYayDci/kKlzKU6cdPx8Pb99i/ji67w8eOG0kWx3FX10x649p4QzRYSeQijdqt1ILCnpiU7esO9+1METgsAZkZnNoD5ZoXWCbXJdpfDnKtvSYsKpUMQX/Qo8nvnh+jHwuetKGWtM+L0ShnMIsSPqmmiWaRgXK9qdQ2E9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgrmpMwkGUN6O4ScDV4B8ZUDeP0qo0yuOCFOp9CE15Q=;
 b=zKzBOOV2cgXPcEB4qD35uvi4xAb4+htNpqLLkhg6HndnSDO/4Pa8S6QHyk2JiyHWCWqxJ2vwk0NZjR0qggomy7uCgdF4m+AjKa9MgaDPcUwYtwc6JTn8FP6//tynTofMHPu4vcuudjcXXgLzMHuegMjtbQeY7ZQITvjc4HvMbmk=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:02:34 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::92) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Wed,
 30 Jul 2025 19:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:02:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:01:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Muhammad Ahmed <Muhammad.Ahmed@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/12] drm/amd/display: Adding interface to log hw state when
 underflow happens
Date: Wed, 30 Jul 2025 14:59:02 -0400
Message-ID: <20250730185903.1023256-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b35825-2e57-4fb6-0c5b-08ddcf9ba428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YLqhCtwJjHgPag6wIntcQVwMEp2BrXTux5e4ZLyOUip2vakfVidZJ81lM4Bv?=
 =?us-ascii?Q?DDbD4wa9uEA/YDdUftrjZe91D8qumg7d1UZmTsh3zgvEY5cMufj4v+PoHEQA?=
 =?us-ascii?Q?GUB+U5TuADqFaPzoEuhYWLNPLjx30189lF4Eg8esoRIQh3FjYP5GalWeoCLR?=
 =?us-ascii?Q?Fdc3ru9f2wbwVsoWHJ1bpaG2DIFG1kWy6gvapB004S5Wj0VYpZxzT3i/01zb?=
 =?us-ascii?Q?Gk8/UH6kkCUx7+sjwWKWiGa88fpR5/oemkzFgmqq6Uch77bhaXzG2fZCNCUO?=
 =?us-ascii?Q?243omYmcrsmbXXyEGzNE5dQCrTbqvC/QNzDfGr5MGmrtQ6r8y9J7tX2zh7b0?=
 =?us-ascii?Q?GHc85H6F+nwptJE9tXnCgKzjanMu4EHs6HaCGxZSW2YoXlJWB6Baq5+IZCat?=
 =?us-ascii?Q?NYWjnq9KyZcorOYnfrpdeUie4vAh17PoLJU+f66kKVZohELVHm2RVh2AghPT?=
 =?us-ascii?Q?9+lLnx/IHlxlGdBd/bCHhbeIfFU9WYVflWwRqBtopkkVNM1CcbYGS1EiJBrb?=
 =?us-ascii?Q?FQORpLZq3HfGBTs7yLxamvqzTRX/sRosomwrK386GUkaOa1XHQBNdrH2Pxpp?=
 =?us-ascii?Q?2xSFLUPK3Rv/tVOJhI8QiI2hI3LrQ7HdKQWsTnpbxubdOE8D1RRsyrxV1d9O?=
 =?us-ascii?Q?mzxuIOsvkn6LXhckPKiveFoAK/Pwc9AUjtYOsKfYSUr8owlrnxfpSKv/lUqF?=
 =?us-ascii?Q?TEcskjPAOsBDllDoA86YT7pUPLs7iZmCYhHuTQp7plmwKZXojPkVq4kbYjlr?=
 =?us-ascii?Q?D+xK1Y54QcXHGn2ItWdbwzrZmDI6al3nwkRFonaNEVzDTP7hUIngECfndw1H?=
 =?us-ascii?Q?jk4bkLlLBF7CcolSsfFiWPMz12Go6WwvEg/7THHg3wpLz3W+cnifCTCJyFUl?=
 =?us-ascii?Q?6wVCLgGktNxg8/Dt0u13vwPdGDnhfNGssU97anDflZZ/Ccq1uSSE3+ZN4SjV?=
 =?us-ascii?Q?x3SCnANrJ5W6qGyhaaX6hVc6PJ51Cp7xfwSJNxGJqOa16LfN5i+Xq0Dnut4i?=
 =?us-ascii?Q?LI1PCBILjuiA/VW1IH+jDmBXc4wnE/6HMFIw4oq59tvgW5nphm/JkE6mAtdS?=
 =?us-ascii?Q?YDsER2BE8xhy5svmQU/0z1tVTFUY1sZonbTGkLSDgTyrNCKQA1NIiSIkRWol?=
 =?us-ascii?Q?uftvDZ6XfkWSuYReCrNW7ulkQGw2pLDOP+YR30HVl4w2PbpjNVfnDFU9JuKs?=
 =?us-ascii?Q?NkwnYWud6HMMJiTxThil7EuTjzATaylnux4JaQ5s/0cI3Nuq3K3pMh8kYitA?=
 =?us-ascii?Q?Sfn1wHhvzkz4iqDi6qO2mfRxd0+2mKBQT00LYTLrdSjRJ7r6cy/o0SdyTR9j?=
 =?us-ascii?Q?rBUauHdI6xmtk4K7s6sR731w7hZQB122mg6Kn8vAfGbj/5R9+WG5FinV07Nj?=
 =?us-ascii?Q?R+rxiDiBggR5bkkKM7ayLoh+cTDeO4XDyQOXfH8Hji/ZoQTnlrGubR+hYYDA?=
 =?us-ascii?Q?gsoZvetmddMJm/N8eMVbjZ0VoaybuEpF8GU/ErDbhC5tPCNhmM23F8YXDu9e?=
 =?us-ascii?Q?THhLESqZ+V7+xn5ljxGzYbn7p3zd8gK4IHeF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:02:33.7015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b35825-2e57-4fb6-0c5b-08ddcf9ba428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

From: Muhammad Ahmed <Muhammad.Ahmed@amd.com>

[why]
Will help us better debug underflow issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Muhammad Ahmed <Muhammad.Ahmed@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 18 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 30 ++++++++++++
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    | 31 ++++++++++++
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |  6 +++
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  8 +++-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 26 ++++++++++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  8 +++-
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    | 15 ++++++
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.h    |  6 ++-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 ++
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  3 ++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  3 ++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 48 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  5 ++
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  4 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 +
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 31 files changed, 236 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e42cc37eae11..242bcb30dd34 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6339,3 +6339,21 @@ bool dc_can_clear_cursor_limit(struct dc *dc)
 
 	return false;
 }
+
+void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
+				struct dc_underflow_debug_data *out_data)
+{
+	struct timing_generator *tg = NULL;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		if (dc->res_pool->timing_generators[i] &&
+			dc->res_pool->timing_generators[i]->inst == primary_otg_inst) {
+				tg = dc->res_pool->timing_generators[i];
+				break;
+		}
+	}
+
+	dc_exit_ips_for_hw_access(dc);
+	if (dc->hwss.get_underflow_debug_data)
+		dc->hwss.get_underflow_debug_data(dc, tg, out_data);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a83227f6bb14..b68fbdd73dca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1819,6 +1819,23 @@ struct dc_surface_update {
 	struct dc_bias_and_scale bias_and_scale;
 };
 
+struct dc_underflow_debug_data {
+	uint32_t otg_inst;
+	uint32_t otg_underflow;
+	uint32_t h_position;
+	uint32_t v_position;
+	uint32_t otg_frame_count;
+	struct dc_underflow_per_hubp_debug_data {
+		uint32_t hubp_underflow;
+		uint32_t hubp_in_blank;
+		uint32_t hubp_readline;
+		uint32_t det_config_error;
+	} hubps[MAX_PIPES];
+	uint32_t curr_det_sizes[MAX_PIPES];
+	uint32_t target_det_sizes[MAX_PIPES];
+	uint32_t compbuf_config_error;
+};
+
 /*
  * Create a new surface with default parameters;
  */
@@ -2713,4 +2730,17 @@ bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
 bool dc_is_cursor_limit_pending(struct dc *dc);
 bool dc_can_clear_cursor_limit(struct dc *dc);
 
+/**
+ * dc_get_underflow_debug_data_for_otg() - Retrieve underflow debug data.
+ *
+ * @dc: Pointer to the display core context.
+ * @primary_otg_inst: Instance index of the primary OTG that underflowed.
+ * @out_data: Pointer to a dc_underflow_debug_data struct to be filled with debug information.
+ *
+ * This function collects and logs underflow-related HW states when underflow happens,
+ * including OTG underflow status, current read positions, frame count, and per-HUBP debug data.
+ * The results are stored in the provided out_data structure for further analysis or logging.
+ */
+void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, struct dc_underflow_debug_data *out_data);
+
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index d347bb06577a..e7e5f6d4778e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -440,6 +440,35 @@ void hubbub3_init_watermarks(struct hubbub *hubbub)
 	REG_WRITE(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, reg);
 }
 
+void hubbub3_get_det_sizes(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_GET_2(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, &curr_det_sizes[0],
+		DET0_SIZE, &target_det_sizes[0]);
+
+	REG_GET_2(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, &curr_det_sizes[1],
+		DET1_SIZE, &target_det_sizes[1]);
+
+	REG_GET_2(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, &curr_det_sizes[2],
+		DET2_SIZE, &target_det_sizes[2]);
+
+	REG_GET_2(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, &curr_det_sizes[3],
+		DET3_SIZE, &target_det_sizes[3]);
+
+}
+
+uint32_t hubbub3_compbuf_config_error(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t compbuf_config_error = 0;
+
+	REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR,
+		&compbuf_config_error);
+
+	return compbuf_config_error;
+}
+
 static const struct hubbub_funcs hubbub30_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -457,6 +486,8 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub3_init_watermarks,
 	.hubbub_read_state = hubbub2_read_state,
+	.get_det_sizes = hubbub3_get_det_sizes,
+	.compbuf_config_error = hubbub3_compbuf_config_error,
 };
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
index ca6233e8f1f4..49a469969d36 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
@@ -133,4 +133,10 @@ void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
 
 void hubbub3_init_watermarks(struct hubbub *hubbub);
 
+void hubbub3_get_det_sizes(struct hubbub *hubbub,
+	uint32_t *curr_det_sizes,
+	uint32_t *target_det_sizes);
+
+uint32_t hubbub3_compbuf_config_error(struct hubbub *hubbub);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index b98505b240a7..cdb20251a154 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -1071,6 +1071,8 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
+	.get_det_sizes = hubbub3_get_det_sizes,
+	.compbuf_config_error = hubbub3_compbuf_config_error,
 };
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub31,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 32a6be543105..92957398ac0a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -1009,6 +1009,8 @@ static const struct hubbub_funcs hubbub32_funcs = {
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
 	.set_request_limit = hubbub32_set_request_limit,
 	.get_mall_en = hubbub32_get_mall_en,
+	.get_det_sizes = hubbub3_get_det_sizes,
+	.compbuf_config_error = hubbub3_compbuf_config_error,
 };
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 6d41953011f5..a443722a8632 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -589,6 +589,8 @@ static const struct hubbub_funcs hubbub35_funcs = {
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
 	.dchubbub_init = hubbub35_init,
+	.get_det_sizes = hubbub3_get_det_sizes,
+	.compbuf_config_error = hubbub3_compbuf_config_error,
 };
 
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 92fab471b183..a36273a52880 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1247,6 +1247,8 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
 	.program_arbiter = dcn401_program_arbiter,
+	.get_det_sizes = hubbub3_get_det_sizes,
+	.compbuf_config_error = hubbub3_compbuf_config_error,
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index 0b7547d5b488..cf2eb9793008 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -104,7 +104,8 @@
 	SRI(DCN_SURF1_TTU_CNTL1, HUBPREQ, id),\
 	SRI(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),\
 	SRI(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),\
-	SRI(HUBP_CLK_CNTL, HUBP, id)
+	SRI(HUBP_CLK_CNTL, HUBP, id),\
+	SRI(HUBPRET_READ_LINE_VALUE, HUBPRET, id)
 
 /* Register address initialization macro for ASICs with VM */
 #define HUBP_REG_LIST_DCN_VM(id)\
@@ -249,7 +250,8 @@
 	uint32_t CURSOR_POSITION; \
 	uint32_t CURSOR_HOT_SPOT; \
 	uint32_t CURSOR_DST_OFFSET; \
-	uint32_t HUBP_CLK_CNTL
+	uint32_t HUBP_CLK_CNTL; \
+	uint32_t HUBPRET_READ_LINE_VALUE
 
 #define HUBP_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -622,6 +624,8 @@
 	type DCN_VM_SYSTEM_APERTURE_DEFAULT_SYSTEM;\
 	type DCN_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB;\
 	type DCN_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB;\
+	type PIPE_READ_LINE;\
+	type HUBP_SEG_ALLOC_ERR_STATUS;\
 	/* todo:  get these from GVM instead of reading registers ourselves */\
 	type PAGE_DIRECTORY_ENTRY_HI32;\
 	type PAGE_DIRECTORY_ENTRY_LO32;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 0da70b50e86d..556214b2227d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -505,6 +505,30 @@ void hubp3_init(struct hubp *hubp)
 	hubp_reset(hubp);
 }
 
+uint32_t hubp3_get_current_read_line(struct hubp *hubp)
+{
+	uint32_t read_line = 0;
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_GET(HUBPRET_READ_LINE_VALUE,
+		PIPE_READ_LINE,
+		&read_line);
+
+	return read_line;
+}
+
+unsigned int hubp3_get_underflow_status(struct hubp *hubp)
+{
+	uint32_t hubp_underflow = 0;
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_GET(DCHUBP_CNTL,
+		HUBP_UNDERFLOW_STATUS,
+		&hubp_underflow);
+
+	return hubp_underflow;
+}
+
 static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -534,6 +558,8 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_clear_tiling = hubp3_clear_tiling,
+	.hubp_get_underflow_status = hubp3_get_underflow_status,
+	.hubp_get_current_read_line = hubp3_get_current_read_line,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index b7d7adf0b58c..842f4eb72cc8 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -243,7 +243,8 @@
 	HUBP_SF(HUBPREQ0_FLIP_PARAMETERS_6, REFCYC_PER_META_CHUNK_FLIP_C, mask_sh),\
 	HUBP_SF(HUBPREQ0_VBLANK_PARAMETERS_5, REFCYC_PER_VM_GROUP_VBLANK, mask_sh),\
 	HUBP_SF(HUBPREQ0_VBLANK_PARAMETERS_6, REFCYC_PER_VM_REQ_VBLANK, mask_sh),\
-	HUBP_SF(HUBP0_DCHUBP_REQ_SIZE_CONFIG, VM_GROUP_SIZE, mask_sh)
+	HUBP_SF(HUBP0_DCHUBP_REQ_SIZE_CONFIG, VM_GROUP_SIZE, mask_sh),\
+	HUBP_SF(HUBPRET0_HUBPRET_READ_LINE_VALUE, PIPE_READ_LINE, mask_sh)
 
 bool hubp3_construct(
 		struct dcn20_hubp *hubp2,
@@ -299,6 +300,11 @@ void hubp3_init(struct hubp *hubp);
 
 void hubp3_clear_tiling(struct hubp *hubp);
 
+uint32_t hubp3_get_current_read_line(struct hubp *hubp);
+
+uint32_t hubp3_get_underflow_status(struct hubp *hubp);
+
+
 #endif /* __DC_HUBP_DCN30_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 7fd582a8a4ba..47101847c2b7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -68,6 +68,18 @@ void hubp31_program_extended_blank_value(
 	hubp31_program_extended_blank(hubp, min_dst_y_next_start_optimized);
 }
 
+uint32_t hubp31_get_det_config_error(struct hubp *hubp)
+{
+	uint32_t config_error = 0;
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_GET(DCHUBP_CNTL,
+		HUBP_SEG_ALLOC_ERR_STATUS,
+		&config_error);
+
+	return config_error;
+}
+
 static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -98,6 +110,9 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
 	.hubp_clear_tiling = hubp3_clear_tiling,
+	.hubp_get_underflow_status = hubp3_get_underflow_status,
+	.hubp_get_current_read_line = hubp3_get_current_read_line,
+	.hubp_get_det_config_error = hubp31_get_det_config_error,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h
index d688db79b750..5952c4671507 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h
@@ -228,7 +228,9 @@
 	HUBP_SF(HUBPREQ0_FLIP_PARAMETERS_6, REFCYC_PER_META_CHUNK_FLIP_C, mask_sh),\
 	HUBP_SF(HUBPREQ0_VBLANK_PARAMETERS_5, REFCYC_PER_VM_GROUP_VBLANK, mask_sh),\
 	HUBP_SF(HUBPREQ0_VBLANK_PARAMETERS_6, REFCYC_PER_VM_REQ_VBLANK, mask_sh),\
-	HUBP_SF(HUBP0_DCHUBP_REQ_SIZE_CONFIG, VM_GROUP_SIZE, mask_sh)
+	HUBP_SF(HUBP0_DCHUBP_REQ_SIZE_CONFIG, VM_GROUP_SIZE, mask_sh),\
+	HUBP_SF(HUBPRET0_HUBPRET_READ_LINE_VALUE, PIPE_READ_LINE, mask_sh),\
+	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_SEG_ALLOC_ERR_STATUS, mask_sh)
 
 
 bool hubp31_construct(
@@ -246,4 +248,6 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable);
 void hubp31_program_extended_blank_value(
 	struct hubp *hubp, unsigned int min_dst_y_next_start_optimized);
 
+uint32_t hubp31_get_det_config_error(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index f3a21c623f44..a5f23bb2a76a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -206,6 +206,9 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
 	.hubp_clear_tiling = hubp3_clear_tiling,
+	.hubp_get_underflow_status = hubp3_get_underflow_status,
+	.hubp_get_current_read_line = hubp3_get_current_read_line,
+	.hubp_get_det_config_error = hubp31_get_det_config_error,
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index 6d060ba12da8..b140808f21af 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -218,6 +218,9 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
 	.hubp_clear_tiling = hubp3_clear_tiling,
+	.hubp_get_underflow_status = hubp3_get_underflow_status,
+	.hubp_get_current_read_line = hubp3_get_current_read_line,
+	.hubp_get_det_config_error = hubp31_get_det_config_error,
 };
 
 bool hubp35_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 5028180ad80a..0fcbc6a35be6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -1071,6 +1071,9 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
 	.hubp_clear_tiling = hubp401_clear_tiling,
 	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
+	.hubp_get_underflow_status = hubp3_get_underflow_status,
+	.hubp_get_current_read_line = hubp3_get_current_read_line,
+	.hubp_get_det_config_error = hubp31_get_det_config_error,
 };
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 887b479ed1d7..fdabbeec8ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -252,7 +252,9 @@
 	HUBP_SF(HUBP0_DCHUBP_MCACHEID_CONFIG, MCACHEID_MALL_PREF_1H_P0, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_MCACHEID_CONFIG, MCACHEID_MALL_PREF_2H_P0, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_MCACHEID_CONFIG, MCACHEID_MALL_PREF_1H_P1, mask_sh),\
-	HUBP_SF(HUBP0_DCHUBP_MCACHEID_CONFIG, MCACHEID_MALL_PREF_2H_P1, mask_sh)
+	HUBP_SF(HUBP0_DCHUBP_MCACHEID_CONFIG, MCACHEID_MALL_PREF_2H_P1, mask_sh),\
+	HUBP_SF(HUBPRET0_HUBPRET_READ_LINE_VALUE, PIPE_READ_LINE, mask_sh),\
+	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_SEG_ALLOC_ERR_STATUS, mask_sh)
 
 void hubp401_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 37a239219dfe..139a63101488 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1228,3 +1228,51 @@ void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx)
 		}
 	}
 }
+
+void dcn30_get_underflow_debug_data(const struct dc *dc,
+	struct timing_generator *tg,
+	struct dc_underflow_debug_data *out_data)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+
+	if (tg) {
+		uint32_t v_blank_start = 0, v_blank_end = 0;
+
+		out_data->otg_inst = tg->inst;
+
+		tg->funcs->get_scanoutpos(tg,
+					  &v_blank_start,
+					  &v_blank_end,
+					  &out_data->h_position,
+					  &out_data->v_position);
+
+		out_data->otg_frame_count = tg->funcs->get_frame_count(tg);
+
+		out_data->otg_underflow = tg->funcs->is_optc_underflow_occurred(tg);
+	}
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		struct hubp *hubp = dc->res_pool->hubps[i];
+
+		if (hubp) {
+			if (hubp->funcs->hubp_get_underflow_status)
+				out_data->hubps[i].hubp_underflow = hubp->funcs->hubp_get_underflow_status(hubp);
+
+			if (hubp->funcs->hubp_in_blank)
+				out_data->hubps[i].hubp_in_blank = hubp->funcs->hubp_in_blank(hubp);
+
+			if (hubp->funcs->hubp_get_current_read_line)
+				out_data->hubps[i].hubp_readline = hubp->funcs->hubp_get_current_read_line(hubp);
+
+			if (hubp->funcs->hubp_get_det_config_error)
+				out_data->hubps[i].det_config_error = hubp->funcs->hubp_get_det_config_error(hubp);
+		}
+	}
+
+	if (hubbub->funcs->get_det_sizes)
+		hubbub->funcs->get_det_sizes(hubbub, out_data->curr_det_sizes, out_data->target_det_sizes);
+
+	if (hubbub->funcs->compbuf_config_error)
+		out_data->compbuf_config_error = hubbub->funcs->compbuf_config_error(hubbub);
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 4b90b781c4f2..40afbbfb5b9c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -29,6 +29,7 @@
 #include "hw_sequencer_private.h"
 
 struct dc;
+struct dc_underflow_debug_data;
 
 void dcn30_init_hw(struct dc *dc);
 void dcn30_program_all_writeback_pipes_in_tree(
@@ -98,4 +99,8 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 
 void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx);
 
+void dcn30_get_underflow_debug_data(const struct dc *dc,
+	struct timing_generator *tg,
+	struct dc_underflow_debug_data *out_data);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 2ac5d54d1626..d7ff55669bac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -110,6 +110,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.is_abm_supported = dcn21_is_abm_supported,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 556f4fe57eda..5a6a459da224 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -112,6 +112,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index f5112742edf9..a99145a30230 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -115,6 +115,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.calculate_pix_rate_divider = dcn314_calculate_pix_rate_divider,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index b971356d30b1..c19ef075c882 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -121,6 +121,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.program_outstanding_updates = dcn32_program_outstanding_updates,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index a3ccf805bd16..52cc488416ac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -128,6 +128,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.enable_plane = dcn20_enable_plane,
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 58f2be2a326b..e34efcb7bde5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -123,6 +123,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index fe7aceb2f510..d6e11b7e4fce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -104,6 +104,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.enable_plane = dcn20_enable_plane,
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
+	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 9df8030e37f7..1723bbcf2c46 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -47,6 +47,7 @@ struct link_resource;
 struct dc_dmub_cmd;
 struct pg_block_update;
 struct drr_params;
+struct dc_underflow_debug_data;
 
 struct subvp_pipe_control_lock_fast_params {
 	struct dc *dc;
@@ -475,6 +476,9 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*post_unlock_reset_opp)(struct dc *dc,
 			struct pipe_ctx *opp_head);
+	void (*get_underflow_debug_data)(const struct dc *dc,
+			struct timing_generator *tg,
+			struct dc_underflow_debug_data *out_data);
 };
 
 void color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 52b745667ef7..9bee45b36629 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -229,6 +229,8 @@ struct hubbub_funcs {
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
+	void (*get_det_sizes)(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes);
+	uint32_t (*compbuf_config_error)(struct hubbub *hubbub);
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 198a28bd8e28..2b874d2cc61c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -306,6 +306,8 @@ struct hubp_funcs {
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
 	void (*hubp_program_3dlut_fl_config)(struct hubp *hubp, struct hubp_fl_3dlut_config *cfg);
 	void (*hubp_clear_tiling)(struct hubp *hubp);
+	uint32_t (*hubp_get_current_read_line)(struct hubp *hubp);
+	uint32_t (*hubp_get_det_config_error)(struct hubp *hubp);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 82f966cf4ed2..20d714596021 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1141,7 +1141,8 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SRI_ARR(DCN_SURF1_TTU_CNTL1, HUBPREQ, id),                               \
       SRI_ARR(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),                                \
       SRI_ARR(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),                                \
-      SRI_ARR(HUBP_CLK_CNTL, HUBP, id)
+      SRI_ARR(HUBP_CLK_CNTL, HUBP, id),                                        \
+      SRI_ARR(HUBPRET_READ_LINE_VALUE, HUBPRET, id)
 #define HUBP_REG_LIST_DCN2_COMMON_RI(id)                                       \
   HUBP_REG_LIST_DCN_RI(id), HUBP_REG_LIST_DCN_VM_RI(id),                       \
       SRI_ARR(PREFETCH_SETTINGS, HUBPREQ, id),                                 \
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 2ae6831c31ef..0fc66487d800 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -140,7 +140,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id),                                 \
 	HUBP_3DLUT_FL_REG_LIST_DCN401(id),                                       \
 	SRI_ARR(DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE, HUBP, id),              \
-	SRI_ARR(DCHUBP_MCACHEID_CONFIG, HUBP, id)
+	SRI_ARR(DCHUBP_MCACHEID_CONFIG, HUBP, id),								 \
+	SRI_ARR(HUBPRET_READ_LINE_VALUE, HUBPRET, id)
 
 /* ABM */
 #define ABM_DCN401_REG_LIST_RI(id)                                            \
-- 
2.34.1

