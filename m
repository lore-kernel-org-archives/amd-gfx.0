Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AABCC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F110EB63;
	Tue,  8 Sep 2026 11:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r6Gmz+ui";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C6A10EB5E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHjaU8b0myFQih0q7WtvtjE8kxqxroo7eu7+bkoh4dELkqH5qi7rtln0YKs3tXQii0ab8eDt06+p48IT1OMer6bX9r1Y/VQ36ZQps4iUhs9t3lOzCjlPDwDidv+azU2wKBMk9O7E2FCh7Rty/TfjAup+sEywme4HNxI6UqCfBdvLeLEEAZjcMwUGs5T/omB2xDIoi3cMC1CgOlh0s0DORMvq7zM3CwjyLvbbetQeDVb41QFrDebS7a3/tGlaXesUYjJCw43eJwJmvdb6hxhtX2onrM2M1BbiEE/ljFashNpHrIwIk3JQnaWROEqlXEM3TQrlRkrSi1jVy6M5JzF+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTb+6cIVWRs2v9cblUGNzB5QaYJEYNKE1IdZFsltxBo=;
 b=AX167knKDqqJYcI55TuGZEcW462aSGriG5REVJUS8FG8tO98EGgsc/XBJp9uV+ilZDIeHfmLKFMlhldTiif2D1JVzrTWEP4swsMEsE33ydbkzmDFshAB3xlNFS7rOfDEmjAvApxTG/ctts3nukEatTEJ4h+XpitvIyBgtth83rRCsAXUrk4Gy4xGrAycQLd3PJYlT+RdTZFjRMEon7M/6VP7WnjX9Oq0g3BXVmymMu4AvsHgZQpkPU70IpIGpAMHSEwajKuHmS2MoiLvwhsGl4bURdwnKhR7nnK/7IKG4G9oiTbwec1Y0Ac0vBRzdKtR12IRYeK4egCmVTzIe64n4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTb+6cIVWRs2v9cblUGNzB5QaYJEYNKE1IdZFsltxBo=;
 b=r6Gmz+uiSvQDOtfi3Q5qVPWku2JGdJMt47CC3JtNuHO6mPL/1Fpe2W8vB9p0YvokC81qKxl/WAL2T4Tu7TTdvPbQ70V/TuoN56z8BwrrZ2Ws6HX0aqyKsc5v4QS98IjTKIznrdXdCzEe8vPueq697iN6hluD/9vYKXt8Eou9Ogg=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 11:38:23 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::1e) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:22 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:14 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 31/66] drm/amd/display: Add urgent assertion counter probe
Date: Tue, 8 Sep 2026 19:31:24 +0800
Message-ID: <20260908113338.2433445-32-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: d8332bcd-c5af-4165-76ac-08df0d9db0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|30052699003|6133799003|10067099003|11063799006|56012099006|20052099010|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iIZ5ufZ0jOmi4a/qzeRzRLl8Y+JDaGR3PxzfHXUH7kC0E5sVeyrl6yCc3yYRN6ZJyJwLU8NKwTNdRE9DfCpwLTBe1+KsYrC9PPDfpa3jRg/HS1bOqNCn9SYjA3US/a2jOiV+HIfYTVSI+4Az4ZyRCw09NIPARLNUTYCwd21T11pMEA3lt0pZIxP96GzumERChogez0JcnSBrx7Y4Gh6SmEb48+99TxxJkoqckXQ9koCddVK6VQPHL2jE/GrvGAUzdd0JMOr5ld3OAzB9DFf5ZXKMOxAnQo28BAoL1vh9aofjOsPNu+tvm5SelY0BIzF5yMnEAwEzLbM0eG6ALgC/2vZO9Xwy889HZwKaKCCoxChCwKsRwxAS+zX/bP85Go1jjQl3dW9zmMZtf0Ybh5ZndbAGpsfdBxm9A2IRDRJbm5PnRzZqQLrl/nibRn+fG4+0hn1Q5dIJild7OA1/QAifjBjGJs+yeMp9vCksbYJxr5l2Nib471xAVMLDFNlBqYQ9OoE4Pzb6uldE0wGLJXnxcmDXcUC/Nv9xm58CqM0lBSZ+7oN70NZyjFw1Gr9nPf7taaTAN/G3vbVa47M7c1AcaNfhJfKt7K9Z/xa041eyEXL+zrHD8tD8Su0KDK4QiGWvXI5IT8rbZKNcUTtOkn2qGUjyNvFNTgt17YqfH1obi1sduzwgXI0OX46o8/nnkj8OFVlCuAcXbZdxlCIF2bq5Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(30052699003)(6133799003)(10067099003)(11063799006)(56012099006)(20052099010)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8hFVfmiTuRZQf+ic2Mrhw0dBIMjWKx2YmuXiGH2hy7F5fQUr+gorO43IKMF3/QemQdx5ISXZjYJ0jNgSrJzUFn75P4jULLebdd5frbtrUuWLnaOf6yfv1hhKzXMGU3TTpwoZn4MMKheewfFIy9p17VfetMbbcjSg3rom8xC/9OfPVE6oRYRTbVc4/7Po7n5SU77j+ZVyp45qjcWnXZw5DDBwmSxZc+E5WFV2maX3odfoqqZ1cdgekuHq7tXeRa5uIg9BKpTpAS3lqDjDAIzhcIIaqQkXIHRACoQpjdLGtWNSaAt3M95fI9TbJrZTghjdsu2+Eh5jxgt4o7Cog82/I9emMULFn8pjvzLp9nObyH69nnA18NZ+otzli+AiiyJ1ZpB0tNYAhokNAopo294pfjGMGLtNI8i5jO0pebDdSCfSq0swk4T9Rzrc5WPC048
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:23.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8332bcd-c5af-4165-76ac-08df0d9db0be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Expose continuous urgent assertion counts for memory QoS debugging.

[How]
Track probe running state and poll the counter through the update path.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 ++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 54 ++++++++++++++-----
 3 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b3889abab6b6..ecbd2b4a0c22 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4581,11 +4581,31 @@ enum dc_status resource_validate_probe_set(struct dc *dc,
 		return DC_NOT_SUPPORTED;
 
 	for (i = 0; i < probe_count; i++) {
-		if (probes[i].target_state == DC_PROBE_MEASURING)
-			return DC_NOT_SUPPORTED;
-
-		if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
+		switch (probes[i].type) {
+		/* These global probes support a one-frame measurement and reset. */
+		case DC_PROBE_PEAK_MEM_BW:
+		case DC_PROBE_PEAK_MEM_BW_STRESSED:
+		case DC_PROBE_AVG_MEM_BW:
+		case DC_PROBE_MEM_LATENCY:
+		case DC_PROBE_PREFETCH_DATA_SIZE:
+			if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
+				return DC_NOT_SUPPORTED;
+			if (probes[i].target_state != DC_PROBE_NOT_MEASURING &&
+					probes[i].target_state != DC_PROBE_MEASURED)
+				return DC_NOT_SUPPORTED;
+			break;
+		/* The global urgent assertion counter additionally supports polling. */
+		case DC_PROBE_URGENT_ASSERTION_COUNT:
+			if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
+				return DC_NOT_SUPPORTED;
+			if (probes[i].target_state != DC_PROBE_NOT_MEASURING &&
+					probes[i].target_state != DC_PROBE_MEASURING &&
+					probes[i].target_state != DC_PROBE_MEASURED)
+				return DC_NOT_SUPPORTED;
+			break;
+		default:
 			return DC_NOT_SUPPORTED;
+		}
 
 		if (probes[i].type == DC_PROBE_PEAK_MEM_BW_STRESSED &&
 				!dc->res_pool->lsdma_scratch.buffer)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7ca5355dbad2..ab8c67ad1b50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2223,6 +2223,7 @@ struct dc_probe_latencies {
 /**
  * struct dc_probe_status - results for a probe.
  * @valid: true if a measurement was latched.
+ * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
@@ -2232,6 +2233,7 @@ struct dc_probe_latencies {
  */
 struct dc_probe_status {
 	bool                       valid;
+	bool                       measuring;
 	enum dc_probe_type         type;
 	union {
 		uint32_t bandwidth_mbps;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 443afcbce5ed..a13d36ad8a9c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -990,7 +990,7 @@ static struct timing_generator *dcn60_get_ref_tg_for_hubbub_probe(
  * @dc:             DC structure
  * @context:        Committed dc state to resolve streams from
  * @probe:          Probe state to build sequence for
- * @status:         Perfmon status to update with probe results
+ * @status:         Prior perfmon status, then the result sink for the sequence
  * @block_sequence: Block sequence to append steps to
  * @num_steps:      Number of steps in the block sequence
  *
@@ -1009,17 +1009,32 @@ static void dcn60_build_hubbub_perfmon_sequence(
 	uint32_t refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
 	struct timing_generator *ref_tg = dcn60_get_ref_tg_for_hubbub_probe(context);
 	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
+	bool was_measuring = status->measuring;
 
 	if (!hubbub || !hubbub->funcs || !hubbub->funcs->perfmon.reset)
 		return;
 
-	status->type = probe->type;
-
 	if (probe->target_state == DC_PROBE_NOT_MEASURING) {
 		hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
 		return;
 	}
 
+	if (probe->target_state == DC_PROBE_MEASURING) {
+		if (probe->type != DC_PROBE_URGENT_ASSERTION_COUNT ||
+				!hubbub->funcs->perfmon.start_measuring_urgent_assertion_count ||
+				!hubbub->funcs->perfmon.get_urgent_assertion_count)
+			return;
+
+		if (!was_measuring) {
+			hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
+			hwss_add_hubbub_perfmon_start_urgent_assertion_count(&seq_state, hubbub);
+		}
+
+		hwss_add_hubbub_perfmon_get_urgent_assertion_count(&seq_state, hubbub,
+				refclk_mhz, &status->u.urgent_assertion_count);
+		return;
+	}
+
 	if (probe->target_state != DC_PROBE_MEASURED || !ref_tg)
 		return;
 
@@ -1059,7 +1074,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
 		hwss_add_hubbub_perfmon_get_out_of_order_bw(&seq_state, hubbub,
 				refclk_mhz, &status->u.bandwidth_mbps, NULL);
-		break;
+		return;
 
 	case DC_PROBE_AVG_MEM_BW:
 		/* In-order counter accumulates over a full frame, so no timing group
@@ -1076,7 +1091,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_in_order_bw(&seq_state, hubbub,
 				refclk_mhz, 0, &status->u.bandwidth_mbps, NULL);
-		break;
+		return;
 
 	case DC_PROBE_MEM_LATENCY:
 		if (!hubbub->funcs->perfmon.start_measuring_memory_latencies ||
@@ -1091,7 +1106,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_memory_latencies(&seq_state, hubbub,
 				refclk_mhz, &status->u.latency);
-		break;
+		return;
 
 	case DC_PROBE_URGENT_ASSERTION_COUNT:
 		if (!hubbub->funcs->perfmon.start_measuring_urgent_assertion_count ||
@@ -1106,7 +1121,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_urgent_assertion_count(&seq_state, hubbub,
 				refclk_mhz, &status->u.urgent_assertion_count);
-		break;
+		return;
 
 	case DC_PROBE_PREFETCH_DATA_SIZE:
 		if (!hubbub->funcs->perfmon.start_measuring_prefetch_data_size ||
@@ -1121,7 +1136,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_prefetch_data_size(&seq_state, hubbub,
 				&status->u.prefetch_data_size);
-		break;
+		return;
 
 	case DC_PROBE_URGENT_RAMP_LATENCY:
 		/* Requires caller-supplied window params not available in probe model. */
@@ -1136,9 +1151,22 @@ static void dcn60_build_hubbub_perfmon_sequence(
  * dcn60_update_probe_status - Set the valid flag on a latched probe result.
  * @status: result sink whose u was written by the GET BLS step during execute
  */
-static void dcn60_update_probe_status(struct dc_probe_status *status)
+static void dcn60_update_probe_status(
+		struct dc_probe_status *status,
+		const struct dc_probe_state *probe)
 {
-	switch (status->type) {
+	struct dc_probe_status result = *status;
+
+	memset(status, 0, sizeof(*status));
+
+	if (probe->target_state == DC_PROBE_NOT_MEASURING)
+		return;
+
+	status->type = probe->type;
+	status->measuring = probe->target_state == DC_PROBE_MEASURING;
+	status->u = result.u;
+
+	switch (probe->type) {
 	case DC_PROBE_PEAK_MEM_BW:
 	case DC_PROBE_PEAK_MEM_BW_STRESSED:
 	case DC_PROBE_AVG_MEM_BW:
@@ -1194,11 +1222,11 @@ void dcn60_program_perfmon(struct dc *dc, struct dc_state *context)
 		return;
 
 	context->block_sequence_steps = 0;
-	memset(context->probe_status, 0, sizeof(context->probe_status));
 
 	for (i = 0; i < context->probe_count; i++) {
 		if (is_probe_measurement_type_for_hubbub(context->probes[i].type))
-			dcn60_build_hubbub_perfmon_sequence(dc, context, &context->probes[i],
+			dcn60_build_hubbub_perfmon_sequence(dc, context,
+					&context->probes[i],
 					&context->probe_status[i],
 					context->block_sequence,
 					&context->block_sequence_steps);
@@ -1207,7 +1235,7 @@ void dcn60_program_perfmon(struct dc *dc, struct dc_state *context)
 	hwss_execute_sequence(dc, context->block_sequence, context->block_sequence_steps);
 
 	for (i = 0; i < context->probe_count; i++)
-		dcn60_update_probe_status(&context->probe_status[i]);
+		dcn60_update_probe_status(&context->probe_status[i], &context->probes[i]);
 }
 
 static bool dcn60_has_active_memory_request(const struct dc *dc)
-- 
2.43.0

