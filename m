Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5861DE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ABA10F064;
	Fri, 20 Dec 2024 21:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HL5FEFxg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE9010E094
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFxvTqDYAbYK/eG9kLwnW8YRV8dfsAHDcmJCsc1ppYvBBvRkXxfKnnk4XuB5K8XbK4DRlxe0eETShWmMvzyXoyOneyVQ4VlVg80HDaI3TzHJHKveaGjsfg3ekVM/M/tDVxUf/IU1g1oq9aT5Gcwhqo61qXD4wE03hcJ2yqV1qlOwTheqXumUJh6mFNmwXWvCJgo64OreNRmdbgsudCg4UXPUwiT5towos3bhS03KUJtztYEjAackcFLkR34qPLOrfbLfQJ55oyZL47q0pAtNgtydQGZzWgo9OVO4fHkomnkLduu9FUAf2auyclT2dyCBnyvZrYqZ7hkpg4J+BKwbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqwSeR8V9Af6UbNVz0GFU+7MRVaOMXo89bxBI+xNi14=;
 b=jC+2K324QYRY2E3zkBN706hjUubY28aQvSXMk6aCtIPVJAWdtI4OEVUqU8IMtJgUJz8lmtS0O8DE8gysZIjO6yF1Y70a/bRKxoOMy/ubJp6G0/nzLnKT6jt/y/0JDmvUc1URJXcBxRFZfe3beYSxbDb/lCUWa1Nnvyv+EoiMyeuOzhblX71HEAybSeDEMUz6oBEPGjldgUdAqGyCmLFXDu18gaHpCZFNGEcnZAq/Lmm6AKB3Thpmkmb1rpsEa2H5fqIjenwLAaen/oXx1JS6gZgKSgK2RlhmE6ENmwF3Vz5FbzMW8fm3fKcbKLbj6aq99VCZmHQV5QRlSbPLlxPODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqwSeR8V9Af6UbNVz0GFU+7MRVaOMXo89bxBI+xNi14=;
 b=HL5FEFxg5SlQ2WXjGV2LY0b3C8Sved6XHmZD72gwXrqXEfI8SKmNd/fskjad5zwr0+TASYENM4wuokqLR7B+6GwBRRdWP0lAPIvolyDb4jkEbTUTMGYqm/IPZH9tZti+A92/XR8rWcKVVdHxgUoUqZEuq4DGoHmzeYFLT8OnCPU=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:50 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::fc) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:49 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:48 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 04/28] drm/amd/display: Parse RECEIVE_PORT0_CAP capabilities
 from DPCD
Date: Fri, 20 Dec 2024 16:48:31 -0500
Message-ID: <20241220214855.2608618-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f0e867-cc63-49e7-ab03-08dd21405ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKQI4YZqk4ccOcNQoB/Woh2AhiCHBFiw6UqQYr5KZaIoi7VIXa1/Fpo3wowq?=
 =?us-ascii?Q?JlDF1VmuSOQ4dnDg4CTI0Re77og6hgvaC+PgUZlZaPo2Z0TqTaJqCdc2fp1Y?=
 =?us-ascii?Q?wevOH/CF2VFSdjBYqOTrK5HHQSjkc77DOvcztbPrB/uhCbOW9pkQFA0art+B?=
 =?us-ascii?Q?6SEhx/fRWGcJi0+lZUB1FmmpvMjqYoEik63LfvxMY2573Q+6IZ0uGE8cV3RT?=
 =?us-ascii?Q?w9URrnew0JFJLmBnh4EeUKuPApMm/Vy//2B3uOojAGXOXn9AWWubX4VBmiuH?=
 =?us-ascii?Q?k0CaJoowJlpSmblkvtpI/ujM1dE8Nhk35ziw/OQXseQnPV+Mk2YPG0yTI4UF?=
 =?us-ascii?Q?top6KkS8+YoQtBtmHnF9woXDHSNn8aLptiUV4jQY3AGa7dRL/lZh1rI6Ibhs?=
 =?us-ascii?Q?WC8C1ttIzYlKePhRACZY/t5tNf73DtEFNdSOVGrdTCvVX8Pjgspx0APVLj89?=
 =?us-ascii?Q?czDWlRF2NIPSLf+d2LfrDc+JsVBbKF14goG9axrR6PfWdN0byRA3w17mxepn?=
 =?us-ascii?Q?b19XpRplLSz9vTCSPR9ze+YA1MKR5RXVrFsAyzgI68f3DkN8/nBxuH82VMAy?=
 =?us-ascii?Q?/XEyDCd+U1IFkzDyY7lhedb8aqqsqSAENMGxlpBZDRtVHz4/OhS9rm+l2eaP?=
 =?us-ascii?Q?QsjqHXbVMWQCCv9y6W0YFk9Y0IaYRP5CDBvYN/dw9lJj6Xiz7InNTzqTlCHH?=
 =?us-ascii?Q?c8dGzstdbwGT8FkkeFU/hPLSBbDigCPYrjkuyE6YHh9+XNOY5LCn1CoNbKBo?=
 =?us-ascii?Q?9natYrthhVb3GvxG8MP9JFh2drBPs4pRp7yh1zL+tkp2PCQVR7SICYCQYsEI?=
 =?us-ascii?Q?17cDP0R6pF9sAtmlDTH9Y/dPN9ucyXAr9m9zrUZ6o88N6cx3ReL/LUzq+/xM?=
 =?us-ascii?Q?iDsJEKdBg5RNx+F929XQHWLFnLF+k8AlMvWU9JifuNZoTQyCPzxfDlCe9zGx?=
 =?us-ascii?Q?1r1H9ae8aD//eA2anhhgDUO28dglBdNAbAJ0tYJMROWk8XqTyFzpMnTm34ay?=
 =?us-ascii?Q?KzcZffLGyA6k+F1LZ0LmNJ1zXYVEGCf3o9F40czPb/fgZEaGqu6QBc/6t/UZ?=
 =?us-ascii?Q?TRJY9KjylgFPSuagKYV/Vb0Pdf6e76ixOrXPukmKGBvvrd4WNdcdFqi5ftaZ?=
 =?us-ascii?Q?xCKGhtaV6mREPolKkeqd+si5I9pE+aWZSnpbBfEdkkumdnXmLwWGJTNgjLHj?=
 =?us-ascii?Q?2B9MuNmlPQsojfN8xr5ZW2Dy1sl/cspt5fPopbedT0KUBE/Sbpc1wi3JQFyq?=
 =?us-ascii?Q?NSegyXnm9EkOFq9yHtL2q6fYwY7VRQFYsThuxUO0fkT++nBJ2aaWdMStbBtU?=
 =?us-ascii?Q?5UQzuhwPytQeToVnPYBsif7h8V1Iam4Qyq5AadXkEoniGOrpuKowfYLRWcuD?=
 =?us-ascii?Q?kPcO7p8mQ1xINjv/oSZFvR+43Gp3TkOFx0XBUwHVhnB7yJXEzRyUlQHXqjHl?=
 =?us-ascii?Q?z5HO78a0V8dPEJiJ87gAzZ6rnEWy7U5nlKedr0kwG9uP37co47egAZAHvpoO?=
 =?us-ascii?Q?oQkn/0eRwNC1WKQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:50.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f0e867-cc63-49e7-ab03-08dd21405ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

From: George Shen <george.shen@amd.com>

[Why]
DPCD register RECEIVE_PORT0_CAP contains HBlank expansion/reduction
capabilities of a DP device. These capabilities are required to enable
HBlank expansion/reduction logic.

[How]
Read raw RECEIVE_PORT0_CAP register values and store parsed fields.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  8 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h        |  8 ++++++++
 .../dc/link/protocols/link_dp_capability.c       |  5 +++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cccffffaf768..01f22706d27c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2383,6 +2383,13 @@ struct dc_sink_dsc_caps {
 	struct dsc_dec_dpcd_caps dsc_dec_caps;
 };
 
+struct dc_sink_hblank_expansion_caps {
+	// 'true' if these are virtual DPCD's HBlank expansion caps (immediately upstream of sink in MST topology),
+	// 'false' if they are sink's HBlank expansion caps
+	bool is_virtual_dpcd_hblank_expansion;
+	struct hblank_expansion_dpcd_caps dpcd_caps;
+};
+
 struct dc_sink_fec_caps {
 	bool is_rx_fec_supported;
 	bool is_topology_fec_supported;
@@ -2409,6 +2416,7 @@ struct dc_sink {
 	struct scdc_caps scdc_caps;
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
+	struct dc_sink_hblank_expansion_caps hblank_expansion_caps;
 
 	bool is_vsc_sdp_colorimetry_supported;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 8dd6eb044829..94ce8fe74481 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -969,6 +969,21 @@ union dp_sink_video_fallback_formats {
 	uint8_t raw;
 };
 
+union dp_receive_port0_cap {
+	struct {
+		uint8_t RESERVED					:1;
+		uint8_t LOCAL_EDID_PRESENT			:1;
+		uint8_t ASSOCIATED_TO_PRECEDING_PORT:1;
+		uint8_t HBLANK_EXPANSION_CAPABLE	:1;
+		uint8_t BUFFER_SIZE_UNIT			:1;
+		uint8_t BUFFER_SIZE_PER_PORT		:1;
+		uint8_t HBLANK_REDUCTION_CAPABLE	:1;
+		uint8_t RESERVED2:1;
+		uint8_t BUFFER_SIZE:8;
+	} bits;
+	uint8_t raw[2];
+};
+
 union dpcd_max_uncompressed_pixel_rate_cap {
 	struct {
 		uint16_t max_uncompressed_pixel_rate_cap	:15;
@@ -1193,6 +1208,7 @@ struct dpcd_caps {
 
 	struct replay_info pr_info;
 	uint16_t edp_oled_emission_rate;
+	union dp_receive_port0_cap receive_port0_cap;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index edf4df1d03b5..2792ef448d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -875,6 +875,14 @@ struct dsc_dec_dpcd_caps {
 	bool is_dp; /* Decoded format */
 };
 
+struct hblank_expansion_dpcd_caps {
+	bool expansion_supported;
+	bool reduction_supported;
+	bool buffer_unit_bytes; /* True: buffer size in bytes. False: buffer size in pixels*/
+	bool buffer_per_port; /* True: buffer size per port. False: buffer size per lane*/
+	uint32_t buffer_size; /* Add 1 to value and multiply by 32 */
+};
+
 struct dc_golden_table {
 	uint16_t dc_golden_table_ver;
 	uint32_t aux_dphy_rx_control0_val;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ce9d799d2386..d1d869cc85c7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1779,6 +1779,11 @@ static bool retrieve_link_cap(struct dc_link *link)
 	link->test_pattern_enabled = false;
 	link->compliance_test_state.raw = 0;
 
+	link->dpcd_caps.receive_port0_cap.raw[0] =
+			dpcd_data[DP_RECEIVE_PORT_0_CAP_0 - DP_DPCD_REV];
+	link->dpcd_caps.receive_port0_cap.raw[1] =
+			dpcd_data[DP_RECEIVE_PORT_0_BUFFER_SIZE - DP_DPCD_REV];
+
 	/* read sink count */
 	core_link_read_dpcd(link,
 			DP_SINK_COUNT,
-- 
2.34.1

