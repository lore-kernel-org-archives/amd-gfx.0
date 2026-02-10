Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7240EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C57D10E57E;
	Tue, 10 Feb 2026 13:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EsZ7B7tH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB95410E57C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE2ReV4omMXWpjEhBEraFcue7Yg6MhIfVv3rMJjepFVfSop8IZ+WBO7GSlxaOwNaDwGHD2hlJvraXAuWZvY5VMgnE8fRwnUi4hTWfO4PSBytFUj91YIoTzsQnmGw+6kz0kWE6ddpxgZxLo44EIdduH/rbGgtaPnEkcidSWZIm541OPWUC5/iym30oPkOSAySNYvbqt4P509Izf40Z8PDXWLjX2zuLoJXJ8LZVCgdscvBwQm/bO8i75udQvVkBbN9ENyXYn7dz3V6bA1/VqJK3mSYc5Tnp6MHa4NLtQB+BPySA9IrvqUn3lKfCPXvdCIhheuC5zNzNGNL9XRY/FPfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO2gImRcFmDHc4A3D1TVTMrcc4ARNgcYi2O7AYBDHO0=;
 b=sUxRQdJ5cYqMDRsfyRcnJNLyfNyRQyARjNu/fHrCe3pMOs72RJ0A3BCZesLW6Rs2YMksEzLfeFDJ4sd5hHWsMZVnIBfy45Zg0kN7uK4Emg1Buhrwfz9TCvH4AsKo7G21lLMqpmEDLqsWCunzmDz7ljXbhmmEbxIhl4jM7bbKQMXRdNS9YpaDYck3g1Qz9Wdd1XKeZzopGFNphUGM6QgNv5pUeCNMNXwQqkCF39Ss9rO0k9VD0rAdObVTKtcyfd2pcit0zvZ1Qz0cJ0c+XLYXhhyDo0uqp7ltLbmVxvnBv33lP4Qw/BMNene64LNrEKtKAJfAlBW49XxNLzXf1ohJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO2gImRcFmDHc4A3D1TVTMrcc4ARNgcYi2O7AYBDHO0=;
 b=EsZ7B7tHq7Fx63T6LtPY4njg91aQh5V1befjXQowokztoUvcbcW4C9xxpF5zVo3ggpJpskzf67PouFScoPVaAuy6VWi9Er/xNxwb3SVRgGKF3me+6WRZ2zWP2h0z82sasc/3iEjRj8Bphd8YO3DFxAhT+Ka+ov/9VLdbv0DPkig=
Received: from PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::33)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:54:35 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::ef) by PH7P220CA0172.outlook.office365.com
 (2603:10b6:510:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:54:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Feb
 2026 07:54:33 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:30 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 02/18] drm/amd/display: Refactor fams2 calculations
Date: Tue, 10 Feb 2026 21:49:55 +0800
Message-ID: <20260210135353.848421-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e6d18f-4e8b-49c7-03c2-08de68abec5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4SKrZoynIoEgH3DarPx+exnAK+5AUU1ZvifKXkzxFk9fdYqgF5/IlSCAyJc?=
 =?us-ascii?Q?REiMQEMs53chjdrKod2s2nWeWIBF3529vC3WAUwBNMI2m1E95SbFnFiGJtyr?=
 =?us-ascii?Q?M8o7deIXQph/cOf3thMCB3IFLHmRjM2/qG0pftFAXBPPAfWaojDqB9oqi74V?=
 =?us-ascii?Q?N3uxLHCKFu1BjeGS78CqlGNRNMjY7w5APeInblBVXwjXCbnXmaVsGNV71h7s?=
 =?us-ascii?Q?VoIei8juRhqf5jOT4rZf2PVP7baU5xZYsMSyLtb4z4wSzTNXdxhM5JS7xQ/e?=
 =?us-ascii?Q?lhquR6KDo2+/5vF/VB+C4QjHc1hpDzwjSTIhB66CRJZ5pZFAoVuIsXdE5Lm8?=
 =?us-ascii?Q?+wD1U8ZMzWzjcsY7VmNkwPIppfNICCVnMZgqDtvvcDzbR+4GjUhK95nXKCJV?=
 =?us-ascii?Q?PH7hqEsmHj0RF6hErZHkmhARhpk4orapWNHMMPC6hPNTDf8POPKdGb3chwsb?=
 =?us-ascii?Q?GnlLrEZYda4dedn6fAyodqIsMeUZm0qy6hDeBLQFST4ABXQhVfMvfjjSo57t?=
 =?us-ascii?Q?Lt4QVTbs2AIly/R52iXAiBztghD27aCkOTBAik1ca7Q7Y4t+ApCgF8GMm/ta?=
 =?us-ascii?Q?Aj0CwUaNsRoMNuspj2GvbukVFLgGbyrf4Z/BmWOu0vAWQaZgXFaxMx+LSkOY?=
 =?us-ascii?Q?yJiIu4buVNqg5C6bDJxqO8xymcvn2S6OXKWa+DDZV28ceW1ElQwQIGLjHQuI?=
 =?us-ascii?Q?mBwql55Wpy5rX8/t9DgXAlyy0D6YXgBTmZXuleEyzLCRaaOhzJxamFSU0PsU?=
 =?us-ascii?Q?kQ/3aOe56INw2uA0rCIgCEQTI4x5nCZpdlmCQCOP64zNDckgF8/dVwtSvT5U?=
 =?us-ascii?Q?aHU0Q0ZD3gqJhegyW8Ovg0W8JRbn/4a/+ey1MNTlZjvqZvRKNdR6ZfJYO230?=
 =?us-ascii?Q?bKcMuOsA8Gaeg8ZJG7B9LcytaDPQLXjDuG8l+NvY25ohcHKVlTStK3z2Cb74?=
 =?us-ascii?Q?aUGsroOd3BGMgLtPYejU04wJIsLI1es+rqdKWbLbXEELZcpquh1fXRDctvcV?=
 =?us-ascii?Q?9zyTukYmHz4lDpzgB/9aPjZxOSkCTUD118cYBM25u0zLOPuLSdN9EytKfQ4o?=
 =?us-ascii?Q?y+7o2Bjr4ok6Rz8iYGVV4iHGi9vEMZjCluQfe/aM7wxQ0zWvHPXxLh6pUEC7?=
 =?us-ascii?Q?xqOLsmAV/aD8sP1+oV8cSftHVKPt5K3s/fAvEjhVTa/WEPxa2HiuQh+7fStj?=
 =?us-ascii?Q?CDmgGdN4CCdSDSrDCccAtSu8+pywJuOM4eX+bd0yYJe/j9QNjj9qG1iKAirJ?=
 =?us-ascii?Q?cQ6dSvM8zNPbQQiHo2zdFW81cRe6f8zqAebHC3yzQ72Y+5pIMPhI/4Bs6xsF?=
 =?us-ascii?Q?SbF7YwbgZMWZy/6W48AnHew+/lhNl7Egrw8xn5XJEzA49JCOHvViHu+q79Zi?=
 =?us-ascii?Q?ISt5WkFAa6Wvi0Z3hf5F3sNHxKrs8EJrsZv6S106hPZDf7H6Gqt38viWM1x4?=
 =?us-ascii?Q?1F8GM5j0Jbut+zD/2B7FZetIAOT33AlZh5wuxTr6t+M5vwppctviKjBR/dLS?=
 =?us-ascii?Q?gXinDC5ZCL7hhnbVDwKiai0fG3PQN1RNwnGeNlqgzEqT2kt2kyCmwzZgJIEl?=
 =?us-ascii?Q?1K6O5xhuWylv5/HVNzaiI+22Rp7zRQITtu7UxPPAiKsAXzMMnP52AKz3GPrD?=
 =?us-ascii?Q?mGIq0spodVgpmHAd4kLaiAf0VbDzBczc6nm0bK/W79Bs2Xu63wmfcK1e6tX3?=
 =?us-ascii?Q?1r5vVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lDWBBdHXOFXJVmsj5V1TeRsDFJBYgIZUYLN3gigG38IsEnsfRaCBKI8E+Q3bE2BHwqoZEYvfKh0ZiITkyLh8wLZczy3RtLgqbBnRrabyV6vwZ4bRb6i1WzIJ8S2TYZNRdvUWzrGMdqkLX2H/ijGA2Npo0LC9H2kbmQ9oy+j03dtEQTieOmen1gdeCwj4i2aBWfAPR9gduTfbHxU62nm0UqKQ0ygUH+DNMHEI4LiDkGuPDb5GOy/5L1gatV1rWse4UW0rccwxMAzwkRin/pegoauyJJquuEkzFuvkVKz92jv85BZ27VZvnQnLnQg+LdJrENC7oPmnrzoDcwab2RAjtXqbcIHE0kiMMsKG8Vba2HOz11Jg/+UYkDawjP3RTzLVdBVXomAHiT2Hm9MbHbYbbcGZ/iTBsKVsBTPvq84Ydd932rL3oGGLRLSIbZcBzML8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:34.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6d18f-4e8b-49c7-03c2-08de68abec5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Cleanup calculations based on version to improve for future
expansion.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c | 205 +++++++++---------
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |   1 +
 2 files changed, 107 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index f667026cb43e..732b994b8864 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -374,128 +374,135 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, dc->current_state);
 }
 
-void dml21_build_fams2_programming(const struct dc *dc,
+static unsigned int dml21_build_fams2_stream_programming_v2(const struct dc *dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx)
 {
-	int i, j, k;
+	int dc_stream_idx, dc_plane_idx, dc_pipe_idx;
 	unsigned int num_fams2_streams = 0;
 
-	/* reset fams2 data */
-	memset(&context->bw_ctx.bw.dcn.fams2_stream_base_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
-	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
-	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2, 0, sizeof(union dmub_fams2_stream_static_sub_state_v2) * DML2_MAX_PLANES);
-	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
+	for (dc_stream_idx = 0; dc_stream_idx < context->stream_count; dc_stream_idx++) {
+		int dml_stream_idx;
+		struct dc_stream_state *phantom_stream;
+		struct dc_stream_status *phantom_status;
+		enum fams2_stream_type type = 0;
 
-	if ((dml_ctx->v21.mode_programming.programming->fams2_required) ||
-		(dml_ctx->v21.mode_programming.programming->legacy_pstate_info_for_dmu)) {
-		for (i = 0; i < context->stream_count; i++) {
-			int dml_stream_idx;
-			struct dc_stream_state *phantom_stream;
-			struct dc_stream_status *phantom_status;
-			enum fams2_stream_type type = 0;
+		union dmub_cmd_fams2_config *static_base_state = &context->bw_ctx.bw.dcn.fams2_stream_base_params[num_fams2_streams];
+		union dmub_cmd_fams2_config *static_sub_state = &context->bw_ctx.bw.dcn.fams2_stream_sub_params[num_fams2_streams];
 
-			union dmub_cmd_fams2_config *static_base_state = &context->bw_ctx.bw.dcn.fams2_stream_base_params[num_fams2_streams];
-			union dmub_cmd_fams2_config *static_sub_state = &context->bw_ctx.bw.dcn.fams2_stream_sub_params[num_fams2_streams];
+		struct dc_stream_state *stream = context->streams[dc_stream_idx];
 
-			struct dc_stream_state *stream = context->streams[i];
+		if (context->stream_status[dc_stream_idx].plane_count == 0 ||
+				dml_ctx->config.svp_pstate.callbacks.get_stream_subvp_type(context, stream) == SUBVP_PHANTOM) {
+			/* can ignore blanked or phantom streams */
+			continue;
+		}
 
-			if (context->stream_status[i].plane_count == 0 ||
-					dml_ctx->config.svp_pstate.callbacks.get_stream_subvp_type(context, stream) == SUBVP_PHANTOM) {
-				/* can ignore blanked or phantom streams */
-				continue;
-			}
+		dml_stream_idx = dml21_helper_find_dml_pipe_idx_by_stream_id(dml_ctx, stream->stream_id);
+		if (dml_stream_idx < 0) {
+			ASSERT(dml_stream_idx >= 0);
+			continue;
+		}
 
-			dml_stream_idx = dml21_helper_find_dml_pipe_idx_by_stream_id(dml_ctx, stream->stream_id);
-			if (dml_stream_idx < 0) {
-				ASSERT(dml_stream_idx >= 0);
-				continue;
+		/* copy static state from PMO */
+		memcpy(static_base_state,
+				&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_base_params,
+				sizeof(union dmub_cmd_fams2_config));
+
+		memcpy(static_sub_state,
+				&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params,
+				sizeof(union dmub_cmd_fams2_config));
+
+		switch (dc->debug.fams_version.minor) {
+		case 1:
+		default:
+			type = static_base_state->stream_v1.base.type;
+
+			/* get information from context */
+			static_base_state->stream_v1.base.num_planes = context->stream_status[dc_stream_idx].plane_count;
+			static_base_state->stream_v1.base.otg_inst = context->stream_status[dc_stream_idx].primary_otg_inst;
+
+			/* populate pipe masks for planes */
+			for (dc_plane_idx = 0; dc_plane_idx < context->stream_status[dc_stream_idx].plane_count; dc_plane_idx++) {
+				for (dc_pipe_idx = 0; dc_pipe_idx < dc->res_pool->pipe_count; dc_pipe_idx++) {
+					if (context->res_ctx.pipe_ctx[dc_pipe_idx].stream &&
+							context->res_ctx.pipe_ctx[dc_pipe_idx].stream->stream_id == stream->stream_id &&
+							context->res_ctx.pipe_ctx[dc_pipe_idx].plane_state == context->stream_status[dc_stream_idx].plane_states[dc_plane_idx]) {
+						static_base_state->stream_v1.base.pipe_mask |= (1 << dc_pipe_idx);
+						static_base_state->stream_v1.base.plane_pipe_masks[dc_plane_idx] |= (1 << dc_pipe_idx);
+					}
+				}
 			}
+		}
 
-			/* copy static state from PMO */
-			memcpy(static_base_state,
-					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_base_params,
-					sizeof(union dmub_cmd_fams2_config));
-
-			if (dc->debug.fams_version.major == 3) {
-				memcpy(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2[num_fams2_streams],
-						&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params_v2,
-						sizeof(union dmub_fams2_stream_static_sub_state_v2));
-			} else {
-				memcpy(static_sub_state,
-						&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params,
-						sizeof(union dmub_cmd_fams2_config));
-			}
+
+		/* get per method programming */
+		switch (type) {
+		case FAMS2_STREAM_TYPE_VBLANK:
+		case FAMS2_STREAM_TYPE_VACTIVE:
+		case FAMS2_STREAM_TYPE_DRR:
+			break;
+		case FAMS2_STREAM_TYPE_SUBVP:
+			phantom_stream = dml_ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, stream);
+			if (!phantom_stream)
+				break;
+
+			phantom_status = dml_ctx->config.callbacks.get_stream_status(context, phantom_stream);
+
+			/* phantom status should always be present */
+			ASSERT(phantom_status);
+			if (!phantom_status)
+				break;
 
 			switch (dc->debug.fams_version.minor) {
 			case 1:
 			default:
-				type = static_base_state->stream_v1.base.type;
-
-				/* get information from context */
-				static_base_state->stream_v1.base.num_planes = context->stream_status[i].plane_count;
-				static_base_state->stream_v1.base.otg_inst = context->stream_status[i].primary_otg_inst;
-
-				/* populate pipe masks for planes */
-				for (j = 0; j < context->stream_status[i].plane_count; j++) {
-					for (k = 0; k < dc->res_pool->pipe_count; k++) {
-						if (context->res_ctx.pipe_ctx[k].stream &&
-								context->res_ctx.pipe_ctx[k].stream->stream_id == stream->stream_id &&
-								context->res_ctx.pipe_ctx[k].plane_state == context->stream_status[i].plane_states[j]) {
-							static_base_state->stream_v1.base.pipe_mask |= (1 << k);
-							static_base_state->stream_v1.base.plane_pipe_masks[j] |= (1 << k);
+				static_sub_state->stream_v1.sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+
+				/* populate pipe masks for phantom planes */
+				for (dc_plane_idx = 0; dc_plane_idx < phantom_status->plane_count; dc_plane_idx++) {
+					for (dc_pipe_idx = 0; dc_pipe_idx < dc->res_pool->pipe_count; dc_pipe_idx++) {
+						if (context->res_ctx.pipe_ctx[dc_pipe_idx].stream &&
+								context->res_ctx.pipe_ctx[dc_pipe_idx].stream->stream_id == phantom_stream->stream_id &&
+								context->res_ctx.pipe_ctx[dc_pipe_idx].plane_state == phantom_status->plane_states[dc_plane_idx]) {
+							switch (dc->debug.fams_version.minor) {
+							case 1:
+							default:
+								static_sub_state->stream_v1.sub_state.subvp.phantom_pipe_mask |= (1 << dc_pipe_idx);
+								static_sub_state->stream_v1.sub_state.subvp.phantom_plane_pipe_masks[dc_plane_idx] |= (1 << dc_pipe_idx);
+							}
 						}
 					}
 				}
 			}
+			break;
+		default:
+			ASSERT(false);
+			break;
+		}
 
+		num_fams2_streams++;
+	}
 
-			/* get per method programming */
-			switch (type) {
-			case FAMS2_STREAM_TYPE_VBLANK:
-			case FAMS2_STREAM_TYPE_VACTIVE:
-			case FAMS2_STREAM_TYPE_DRR:
-				break;
-			case FAMS2_STREAM_TYPE_SUBVP:
-				phantom_stream = dml_ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, stream);
-				if (!phantom_stream)
-					break;
-
-				phantom_status = dml_ctx->config.callbacks.get_stream_status(context, phantom_stream);
-
-				/* phantom status should always be present */
-				ASSERT(phantom_status);
-				if (!phantom_status)
-					break;
-
-				switch (dc->debug.fams_version.minor) {
-				case 1:
-				default:
-					static_sub_state->stream_v1.sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
-
-					/* populate pipe masks for phantom planes */
-					for (j = 0; j < phantom_status->plane_count; j++) {
-						for (k = 0; k < dc->res_pool->pipe_count; k++) {
-							if (context->res_ctx.pipe_ctx[k].stream &&
-									context->res_ctx.pipe_ctx[k].stream->stream_id == phantom_stream->stream_id &&
-									context->res_ctx.pipe_ctx[k].plane_state == phantom_status->plane_states[j]) {
-								switch (dc->debug.fams_version.minor) {
-								case 1:
-								default:
-									static_sub_state->stream_v1.sub_state.subvp.phantom_pipe_mask |= (1 << k);
-									static_sub_state->stream_v1.sub_state.subvp.phantom_plane_pipe_masks[j] |= (1 << k);
-								}
-							}
-						}
-					}
-				}
-				break;
-			default:
-				ASSERT(false);
-				break;
-			}
+	return num_fams2_streams;
+}
+
+void dml21_build_fams2_programming(const struct dc *dc,
+		struct dc_state *context,
+		struct dml2_context *dml_ctx)
+{
+	unsigned int num_fams2_streams = 0;
+
+	/* reset fams2 data */
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_base_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2, 0, sizeof(union dmub_fams2_stream_static_sub_state_v2) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
 
-			num_fams2_streams++;
+	if (dml_ctx->v21.mode_programming.programming->fams2_required ||
+			dml_ctx->v21.mode_programming.programming->legacy_pstate_info_for_dmu) {
+		if (dc->debug.fams_version.major == 2) {
+			num_fams2_streams = dml21_build_fams2_stream_programming_v2(dc, context, dml_ctx);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
index 4bff52eaaef8..bff945a4ab3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
@@ -9,6 +9,7 @@
 struct dc_state;
 struct dc_plane_state;
 struct pipe_ctx;
+struct dc_dmub_srv;
 
 struct dml2_context;
 struct dml2_display_rq_regs;
-- 
2.43.0

