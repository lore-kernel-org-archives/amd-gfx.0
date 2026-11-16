Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3985606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fI/rVTLC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F39A10F81B;
	Tue, 17 Nov 2026 17:15:07 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09D010F81B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa6VVSc1QOXpti9thBjsMXlp9iFByLufZX/+sK344zCFsTJQ87mKiBoYXO5IOHr929yb2PgW5p4FxSdvf1pQXU5Jer4tc82IPZFG35mxHiOjx8vKL+r8e4eB8EjC5Ub71/PSH01NEQfuyBzivX+MD8FaE/O4j+2qiec2HKC6BoQO7dKxNmMly3os5B3YMpUHGKboFLURkhrp/9d28jjAZkjICxNEphYBYA/+gNpj2Bug16WTz3doD1bRZ2qtKqosLUfd0HtSIwtrKQZS5/Rz37owY/qcqR1A32kLIVRfdR419oXA0TrJm6uWDe5sJmlAgVV773m+9keAa+ueHJY2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq5a+BgMmS1AOdF+hHETf2UG8mcg3XDNOTfdX6LGTpI=;
 b=Y5t2FDv/n5YZrhQP8C3hKrzBxMCQXdKzxjPO+XcEpm1931rT2sHmzSE+In7s+T4DP4iv3ShtJiysLHCt9vj7EmBLU3zYyxk2hWkrtfy9buhwiWeJJVhzeQxcPfKqDNqG1YD2tAQLhuyidE7BkLHrGJcJqX2yViMvwZdJJT/BjDJ5KtdQ92t7QqUzX5eP94MDh0B5MXlq0ataX9lvFa2HaPH4HKqkVqLmD/ftimQq5RYU/+dp5EX3/wLQrAxMc6XfwcNZwuJJErKXvIq/9zXj1rUf3bG5z7ZQra7t3q7WUZ/3JXE5k5QaUChZt/gMlsew9AL8GngRyxyBR28ENeiRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq5a+BgMmS1AOdF+hHETf2UG8mcg3XDNOTfdX6LGTpI=;
 b=fI/rVTLCySMaHc+LYEu90C7EoYXhwl/Rg06yeQ4J+MlCjtNWhEsijTTxj9RjSOpU0EB71x6rXaVOBSDRldDiNqCRANipUvUAHJ9VKHnSU6cKpoWZqmCh3MXUYFWGEeTlS7jMW7eM+qGpSjNmPC2DsZOqEV1di/Itk3TnoDafQsk=
Received: from CYXPR03CA0044.namprd03.prod.outlook.com (2603:10b6:930:d2::17)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:14:54 +0000
Received: from PH3PEPF0005961D.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::a2) by CYXPR03CA0044.outlook.office365.com
 (2603:10b6:930:d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 17:14:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961D.mail.protection.outlook.com (10.167.243.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:51 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:43 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 16/33] drm/amd/display: Add urgent request and assertion probes
Date: Tue, 17 Nov 2026 05:50:53 +0800
Message-ID: <20261116215641.2800595-17-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961D:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c043d5-31e0-43d9-c190-08df44ce4be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|30052699003|18002099003|6133799003|22082099003|20052099010|261009223027099003|3023799007|56012099006|11063799006|5023799004|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: DBeWyfP/htHhGoHjYJ7Yu5F2AG7rc7MX6BsEVQRfF6GLnNyjgcQUJw7RKx2sekeThB+P3Wm1Da3aEpKthc7/qa+8Yoy9+QJ1TpgtkcEj2pPf9UXYraFHC1mU5ZHhOhBdLMtQ5bh/nCIpD9E5B3yc69DdNZ3epAdIpdFffoyvp7ZmhyoB3e6vCbNHCk5Bkob0K8/TK1SWuoC/TO39fIA70edXC5Q1QSk+ciT+rgV4ag5mvJGenHVL2Ne3Gf5zdecHuSnKqDg8DBOnJm8SsISsZ4Jsr8jyBsln0Xior8SY5QFc7RdFL2nQ+ODucs7CIGx20KqP2ckWeUtk6PRj942+Cbm8JiGiLCJTahq2e1ehtenxqlYAySfhi7wpsCmsx+NytYsehYvDnTPjehPHPQzeAV1kYQSyNkqj7Dl8mZfHzSQINQuZbtEBKlKw35j9nLjizYqFuVZ/qWJnZP4EtDIs9ojjvWRH/TkVG/K2WExBMSd7VwX/j/lDXEh3kcL4bBf1Puuz1oyc2MjH9AP3hYC9hZa7zJCEAVnkMsvc2EgT5BIdsYOKqN/8sCuUB1iqes+YxPbirylP8XqweRqvpF6VvyJ7UhSdM4xUYEreQqqvfgAUVjt1x8Htc3bUfcUeb8DSDyJ+SRruI9ChHZEMIZMAcJRWjZCVVmmX2jp5J3UKByCrgga3UOhD225gGmwubeJsjetpZp7bkF/NOGSb/8861g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(30052699003)(18002099003)(6133799003)(22082099003)(20052099010)(261009223027099003)(3023799007)(56012099006)(11063799006)(5023799004)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DC2nQfxW3Ywc5mnM+NPN1+6BaXf9blFtJ1FRf3f6XhfXg9u3Ni0pDqmfrGxavPZGayJIS7xFl2oNNvUYTIho9V3Do8LYHAm1gBlRfMsRYngrkaKRCF5QMLDKLV1v6S3LFCX0tFZPkDtijXFiRfN6IehqJcnUOvyc5AISkVO7+TejsJgAzjndEY5Hlyd5zQxJDud/ueoHvrJRc8w7pdwzO++286dsNYO56YpH6Ev/pXSgyWNw4ruUrgLu09WXsSJqdT4Az9bFjhwEEBUMphNs83LuMN+f1bTA36ARU0mRMDuQ9th3WBw5CX3YenGsaxPx4MoyJsNtCdBRm5hwsYFZBr8wKpediOaAtAlK0leOoBCWJuEy/M1IZa7srmBHNgWrfaqKywWEII+usG+KxLLR2EtgXDDwYwDA+lUM+7UvHClQRfd0JPj07lL7gWAVstAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:53.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c043d5-31e0-43d9-c190-08df44ce4be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URG_BIZ,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Display debug needs to count urgent signals and data requests
over a selectable part of a frame. The existing probes can only
measure a whole frame.

[How]
Add a stream scope to the probe model, with the stream id and a
start and end line in a union keyed on the scope type.
The urgent assertion count and the new urgent request count poll
with MEASURING, which has no window, or run as a one shot with
MEASURED. A one shot measures one frame of the stream, or a
window when the lines are set. A zero start line is the vblank
start, derived from the stream timing.
Switching to a different polled probe type resets and programs
the new counter first.
The one shot assertion count in a window also reports the
deassertion count and the HUBP requests outstanding, sampled
once after the counter was read. Make the urgent assertion
result a struct to carry them.
A window the position already left when the counter is armed is
missed, and its result is not valid.
Add a wrap-aware, bounded block sequence step to wait for an OTG
line, the hubbub request count start and get steps, and a step to
get the HUBP outstanding requests. Read the outstanding
requests through the register fields.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 183 ++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  44 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  46 +++-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |  61 ++++-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |  80 ++++++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   3 +-
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |  35 +++
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.h    |   1 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 243 ++++++++++++++++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  53 +++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  12 +
 12 files changed, 721 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 061ea11cef0e..241cbe19056d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1895,6 +1895,12 @@ void hwss_execute_sequence(struct dc *dc,
 		case TG_WAIT_FOR_STATE:
 			hwss_tg_wait_for_state(params);
 			break;
+		case TG_WAIT_FOR_POSITION:
+			hwss_tg_wait_for_position(params);
+			break;
+		case HUBP_GET_OUTSTANDING_REQ:
+			hwss_hubp_get_outstanding_req(params);
+			break;
 		case TG_SET_VTG_PARAMS:
 			hwss_tg_set_vtg_params(params);
 			break;
@@ -2025,6 +2031,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBBUB_PERFMON_START_URGENT_ASSERTION_COUNT:
 			hwss_hubbub_perfmon_start_urgent_assertion_count(params);
 			break;
+		case HUBBUB_PERFMON_START_URGENT_REQUEST_COUNT:
+			hwss_hubbub_perfmon_start_urgent_request_count(params);
+			break;
 		case HUBBUB_PERFMON_START_URGENT_RAMP_LATENCY:
 			hwss_hubbub_perfmon_start_urgent_ramp_latency(params);
 			break;
@@ -2043,6 +2052,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT:
 			hwss_hubbub_perfmon_get_urgent_assertion_count(params);
 			break;
+		case HUBBUB_PERFMON_GET_URGENT_REQUEST_COUNT:
+			hwss_hubbub_perfmon_get_urgent_request_count(params);
+			break;
 		case HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE:
 			hwss_hubbub_perfmon_get_prefetch_data_size(params);
 			break;
@@ -2726,6 +2738,46 @@ void hwss_add_tg_wait_for_state(struct block_sequence_state *seq_state,
 	}
 }
 
+/*
+ * Helper function to add TG wait for a vertical position (OTG line) to block sequence
+ */
+/*
+ * Helper function to add a wait for an OTG line to block sequence. When
+ * window_valid is set, line is the end of the window that starts at window_start,
+ * and if the position has already left the window when the step runs, the window
+ * is missed: *window_valid is cleared and the step does not wait out a whole frame.
+ */
+void hwss_add_tg_wait_for_position(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		unsigned int line,
+		unsigned int window_start,
+		bool *window_valid)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_position_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_position_params.line = line;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_position_params.window_start = window_start;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_position_params.window_valid = window_valid;
+		seq_state->steps[*seq_state->num_steps].func = TG_WAIT_FOR_POSITION;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/*
+ * Helper function to add a HUBP outstanding request sample to block sequence
+ */
+void hwss_add_hubp_get_outstanding_req(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint32_t *status)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.hubp_get_outstanding_req_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_get_outstanding_req_params.status = status;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_GET_OUTSTANDING_REQ;
+		(*seq_state->num_steps)++;
+	}
+}
+
 /*
  * Helper function to add TG set VTG params to block sequence
  */
@@ -3529,6 +3581,93 @@ void hwss_tg_wait_for_state(union block_sequence_params *params)
 		tg->funcs->wait_for_state(tg, state);
 }
 
+/*
+ * Poll the TG vertical position until it reaches the target OTG line, at its
+ * next occurrence approached from below. The OTG vertical counter is 0-based
+ * and wraps at v_total, with active starting at OTG_V_BLANK_END (not 0), so the
+ * vblank region can straddle the wrap. The initial position decides the phases,
+ * and is not sampled again to change that decision:
+ *   below target_line - skip phase 1, only phase 2 is needed,
+ *   at or above it    - phase 1 first, which waits out the wrap.
+ * and then the phases:
+ *   phase 1 - advance until the counter is below target_line,
+ *   phase 2 - advance until the counter reaches target_line.
+ * With a window, the initial position must be inside the window, so being at or
+ * above the end line is only valid for a window that crosses the wrap.
+ * target_line must be in [1, v_total-1], 0 and v_total are degenerate and will
+ * simply run out the guard. Each phase is bounded so a stalled or non-moving TG
+ * can never hang the block sequence.
+ */
+void hwss_tg_wait_for_position(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_wait_for_position_params.tg;
+	unsigned int target_line = params->tg_wait_for_position_params.line;
+	struct crtc_position position = {0};
+	unsigned int initial_line;
+	unsigned int guard;
+
+	if (!tg->funcs->get_position)
+		return;
+
+	tg->funcs->get_position(tg, &position);
+	initial_line = position.vertical_count;
+
+	/*
+	 * Arming takes longer than a line. If the position already left the window,
+	 * the end line would only be reached a whole frame later, so report the window
+	 * as missed instead. A window with start at or after end crosses the wrap.
+	 */
+	if (params->tg_wait_for_position_params.window_valid) {
+		unsigned int start_line = params->tg_wait_for_position_params.window_start;
+		bool in_window;
+
+		if (start_line < target_line)
+			in_window = initial_line >= start_line
+					&& initial_line < target_line;
+		else
+			in_window = initial_line >= start_line
+					|| initial_line < target_line;
+
+		if (!in_window) {
+			*params->tg_wait_for_position_params.window_valid = false;
+			return;
+		}
+	}
+
+	/* phase 1: only if the initial position is at or above the target, wait out the wrap */
+	if (initial_line >= target_line) {
+		guard = 100000; /* 100000 * 1us = 100ms cap */
+		do {
+			tg->funcs->get_position(tg, &position);
+			if (position.vertical_count < target_line)
+				break;
+			udelay(1);
+		} while (--guard);
+	}
+
+	/* phase 2: climb to the target */
+	guard = 100000;
+	do {
+		tg->funcs->get_position(tg, &position);
+		if (position.vertical_count >= target_line)
+			break;
+		udelay(1);
+	} while (--guard);
+}
+
+/*
+ * Get the HUBP outstanding request status once and OR it into the caller's
+ * sink, so a sink cleared before a window accumulates everything seen in it.
+ */
+void hwss_hubp_get_outstanding_req(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_get_outstanding_req_params.hubp;
+	uint32_t *status = params->hubp_get_outstanding_req_params.status;
+
+	if (hubp && status && hubp->funcs->hubp_get_outstanding_req_status)
+		*status |= hubp->funcs->hubp_get_outstanding_req_status(hubp);
+}
+
 void hwss_tg_set_vtg_params(union block_sequence_params *params)
 {
 	struct timing_generator *tg = params->tg_set_vtg_params_params.tg;
@@ -3974,6 +4113,14 @@ void hwss_hubbub_perfmon_start_urgent_assertion_count(union block_sequence_param
 		hubbub->funcs->perfmon.start_measuring_urgent_assertion_count(hubbub);
 }
 
+void hwss_hubbub_perfmon_start_urgent_request_count(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_urgent_request_count_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_urgent_request_count)
+		hubbub->funcs->perfmon.start_measuring_urgent_request_count(hubbub);
+}
+
 void hwss_hubbub_perfmon_start_urgent_ramp_latency(union block_sequence_params *params)
 {
 	struct hubbub *hubbub = params->hubbub_perfmon_start_urgent_ramp_latency_params.hubbub;
@@ -4033,10 +4180,20 @@ void hwss_hubbub_perfmon_get_urgent_assertion_count(union block_sequence_params
 	struct hubbub *hubbub   = params->hubbub_perfmon_get_urgent_assertion_count_params.hubbub;
 	uint32_t refclk_mhz    = params->hubbub_perfmon_get_urgent_assertion_count_params.refclk_mhz;
 	uint32_t *count         = params->hubbub_perfmon_get_urgent_assertion_count_params.assertion_count;
+	uint32_t *deassertion_count = params->hubbub_perfmon_get_urgent_assertion_count_params.deassertion_count;
 
 	if (hubbub && hubbub->funcs->perfmon.get_urgent_assertion_count)
 		hubbub->funcs->perfmon.get_urgent_assertion_count(
-				hubbub, refclk_mhz, count, NULL, NULL);
+				hubbub, refclk_mhz, count, deassertion_count, NULL);
+}
+
+void hwss_hubbub_perfmon_get_urgent_request_count(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_get_urgent_request_count_params.hubbub;
+	uint32_t *count       = params->hubbub_perfmon_get_urgent_request_count_params.request_count;
+
+	if (hubbub && count && hubbub->funcs->perfmon.get_urgent_request_count)
+		*count = hubbub->funcs->perfmon.get_urgent_request_count(hubbub);
 }
 
 void hwss_hubbub_perfmon_get_prefetch_data_size(union block_sequence_params *params)
@@ -5415,6 +5572,16 @@ void hwss_add_hubbub_perfmon_start_urgent_assertion_count(struct block_sequence_
 	}
 }
 
+void hwss_add_hubbub_perfmon_start_urgent_request_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_URGENT_REQUEST_COUNT;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_urgent_request_count_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_hubbub_perfmon_start_urgent_ramp_latency(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
 		const struct hubbub_urgent_latency_params *latency_params)
@@ -5482,13 +5649,25 @@ void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *s
 
 void hwss_add_hubbub_perfmon_get_urgent_assertion_count(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t refclk_mhz,
-		uint32_t *assertion_count)
+		uint32_t *assertion_count, uint32_t *deassertion_count)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.hubbub = hubbub;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.refclk_mhz = refclk_mhz;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.assertion_count = assertion_count;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.deassertion_count = deassertion_count;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_urgent_request_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t *request_count)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_URGENT_REQUEST_COUNT;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_request_count_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_request_count_params.request_count = request_count;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7f770a43e1fe..b09490c84438 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4635,33 +4635,53 @@ enum dc_status resource_validate_probe_set(struct dc *dc,
 		return DC_NOT_SUPPORTED;
 
 	for (i = 0; i < probe_count; i++) {
-		switch (probes[i].type) {
+		const struct dc_probe_state *probe = &probes[i];
+		bool supports_polling = false;
+		bool supports_stream = false;
+
+		switch (probe->type) {
 		/* These global probes support a one-frame measurement and reset. */
 		case DC_PROBE_PEAK_MEM_BW:
 		case DC_PROBE_PEAK_MEM_BW_STRESSED:
 		case DC_PROBE_AVG_MEM_BW:
 		case DC_PROBE_MEM_LATENCY:
 		case DC_PROBE_PREFETCH_DATA_SIZE:
-			if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
-				return DC_NOT_SUPPORTED;
-			if (probes[i].target_state != DC_PROBE_NOT_MEASURING &&
-					probes[i].target_state != DC_PROBE_MEASURED)
-				return DC_NOT_SUPPORTED;
 			break;
-		/* The global urgent assertion counter additionally supports polling. */
+		/* The urgent counters additionally support polling, and a stream scope. */
 		case DC_PROBE_URGENT_ASSERTION_COUNT:
-			if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
+		case DC_PROBE_URGENT_REQUEST_COUNT:
+			supports_polling = true;
+			supports_stream = true;
+			break;
+		default:
+			return DC_NOT_SUPPORTED;
+		}
+
+		if (probe->scope.type != DC_PROBE_SCOPE_GLOBAL
+				&& !(probe->scope.type == DC_PROBE_SCOPE_STREAM && supports_stream))
+			return DC_NOT_SUPPORTED;
+
+		switch (probe->target_state) {
+		case DC_PROBE_NOT_MEASURING:
+			/* A release names the probe by its type only, so it has no stream. */
+			if (probe->scope.type != DC_PROBE_SCOPE_GLOBAL)
 				return DC_NOT_SUPPORTED;
-			if (probes[i].target_state != DC_PROBE_NOT_MEASURING &&
-					probes[i].target_state != DC_PROBE_MEASURING &&
-					probes[i].target_state != DC_PROBE_MEASURED)
+			break;
+		case DC_PROBE_MEASURING:
+			/* Polling cannot be limited to a window, a counter only stops when it is reset. */
+			if (!supports_polling || dc_probe_scope_is_windowed(&probe->scope))
+				return DC_NOT_SUPPORTED;
+			break;
+		case DC_PROBE_MEASURED:
+			/* A window must end on a line. Without lines, one whole frame is measured. */
+			if (dc_probe_scope_is_windowed(&probe->scope) && probe->scope.u.stream.end_line == 0)
 				return DC_NOT_SUPPORTED;
 			break;
 		default:
 			return DC_NOT_SUPPORTED;
 		}
 
-		if (probes[i].type == DC_PROBE_PEAK_MEM_BW_STRESSED &&
+		if (probe->type == DC_PROBE_PEAK_MEM_BW_STRESSED &&
 				!dc->res_pool->lsdma_scratch.buffer)
 			return DC_NO_DRAM_BUFFER_RESOURCE;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c9bdfba11a01..4c235520b908 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2228,6 +2228,44 @@ struct dc_probe_latencies {
 	uint32_t min_latency_ns;
 };
 
+/**
+ * union dc_probe_outstanding_req - HUBP requests outstanding after an OTG window.
+ *
+ * @bits.any:              a request is outstanding in HUBP.
+ * @bits.data:             a data request is outstanding.
+ * @bits.chunk_meta_trans: a chunk, meta or translation request is outstanding.
+ * @bits.not_in_blank:     HUBP has not finished requesting for the frame.
+ * @raw:                   DC internal, holds the HW status while the probe sequence
+ *                         executes and is decoded into @bits afterwards.
+ */
+union dc_probe_outstanding_req {
+	struct {
+		uint32_t any              : 1;
+		uint32_t data             : 1;
+		uint32_t chunk_meta_trans : 1;
+		uint32_t not_in_blank     : 1;
+		uint32_t reserved         : 28;
+	} bits;
+	uint32_t raw;
+};
+
+/**
+ * struct dc_probe_urgent_assertion - result of an urgent assertion count probe.
+ *
+ * The fields after @count are only filled for a window of a stream scope, and
+ * are zero otherwise.
+ *
+ * @count:             number of urgent assertion events.
+ * @deassertion_count: number of falling edges of the urgent signal.
+ * @outstanding:       HUBP requests outstanding, sampled once after the
+ *                     window counter was read.
+ */
+struct dc_probe_urgent_assertion {
+	uint32_t count;
+	uint32_t deassertion_count;
+	union dc_probe_outstanding_req outstanding;
+};
+
 /**
  * struct dc_probe_status - results for a probe.
  * @valid: true if a measurement was latched.
@@ -2236,7 +2274,10 @@ struct dc_probe_latencies {
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.
- * @u.urgent_assertion_count: number of urgent assertion events (DC_PROBE_URGENT_ASSERTION_COUNT).
+ * @u.urgent_assertion:       urgent assertion events and outstanding requests
+ *                            (DC_PROBE_URGENT_ASSERTION_COUNT).
+ * @u.urgent_request_count:   number of urgent requests in the window
+ *                            (DC_PROBE_URGENT_REQUEST_COUNT).
  * @u.prefetch_data_size:     total prefetch data in bytes (DC_PROBE_PREFETCH_DATA_SIZE).
  */
 struct dc_probe_status {
@@ -2246,7 +2287,8 @@ struct dc_probe_status {
 	union {
 		uint32_t bandwidth_mbps;
 		struct dc_probe_latencies latency;
-		uint32_t urgent_assertion_count;
+		struct dc_probe_urgent_assertion urgent_assertion;
+		uint32_t urgent_request_count;
 		uint32_t prefetch_data_size;
 	} u;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_probe.h b/drivers/gpu/drm/amd/display/dc/dc_probe.h
index 52bffbebf7ad..14ecb871c3d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_probe.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_probe.h
@@ -12,6 +12,13 @@
  *
  * Each value names a measurable quantity as an abstraction. DC resolves it to
  * whatever HW measurement block fulfills it. DM never selects the HW block.
+ *
+ * DC_PROBE_URGENT_ASSERTION_COUNT and DC_PROBE_URGENT_REQUEST_COUNT are
+ * measured continuously with DC_PROBE_MEASURING, or as a one shot with
+ * DC_PROBE_MEASURED, which can be scoped to one frame or to a window of one
+ * stream with DC_PROBE_SCOPE_STREAM. With a window, the urgent assertion count
+ * result also carries the HUBP outstanding requests, sampled once after the
+ * counter was read so the sample does not disturb the window.
  */
 enum dc_probe_type {
 	DC_PROBE_PEAK_MEM_BW = 0,
@@ -21,6 +28,7 @@ enum dc_probe_type {
 	DC_PROBE_URGENT_ASSERTION_COUNT,
 	DC_PROBE_PREFETCH_DATA_SIZE,
 	DC_PROBE_PEAK_MEM_BW_STRESSED, /* peak BW under synthetic memory contention */
+	DC_PROBE_URGENT_REQUEST_COUNT,
 };
 
 /**
@@ -44,23 +52,66 @@ enum dc_probe_target_state {
 /**
  * enum dc_probe_scope_type - What the probe is scoped to.
  * @DC_PROBE_SCOPE_GLOBAL: whole memory subsystem, no stream/plane selector.
+ * @DC_PROBE_SCOPE_STREAM: lines of one stream, selected by u.stream of
+ *   struct dc_probe_scope.
  *
- * Only GLOBAL is implemented. Per-stream/plane scoping must select targets by
- * stable id, not object pointer — dc_state copy semantics would dangle a raw
- * pointer when the absolute-set commit removes or replaces the target.
+ * Per-stream/plane scoping must select targets by stable id, not object
+ * pointer — dc_state copy semantics would dangle a raw pointer when the
+ * absolute-set commit removes or replaces the target.
  */
 enum dc_probe_scope_type {
 	DC_PROBE_SCOPE_GLOBAL = 0,
+	DC_PROBE_SCOPE_STREAM,
 };
 
 /**
  * struct dc_probe_scope - Selects what a probe measures against.
- * @type: scope kind, only DC_PROBE_SCOPE_GLOBAL is implemented.
+ * @type: scope kind. It selects which member of @u is valid.
+ * @u.stream.stream_id:  stream_id of the stream to measure. A probe on a stream
+ *   that is not in the committed state has nothing to measure, and its status
+ *   is not valid.
+ * @u.stream.start_line: first line of the window, as an OTG vertical position
+ *   of the stream (0-based, wraps at v_total). Zero starts the window at vblank
+ *   start. Otherwise keep it in [1, v_total - 1].
+ * @u.stream.end_line:   last line of the window. A window may cross the v_total
+ *   wrap. Arming the counter takes a few lines. A window the position has
+ *   already left when the counter is armed is missed, and its status is not
+ *   valid, so a window needs to be longer than the arm latency.
+ *
+ * The lines and the target state select what is measured:
+ *
+ * - start_line and end_line both zero is no window. DC_PROBE_MEASURING measures
+ *   continuously, and DC_PROBE_MEASURED measures one whole frame.
+ * - A nonzero end_line is a window from start_line to end_line.
+ *   DC_PROBE_MEASURED measures the next window once, and then stops.
+ *   DC_PROBE_MEASURING is not valid for a window, because a continuous
+ *   measurement cannot be limited to one. A counter only stops when it is
+ *   reset.
+ * - A nonzero start_line with a zero end_line is not valid.
  */
 struct dc_probe_scope {
 	enum dc_probe_scope_type type;
+	union {
+		struct {
+			uint32_t stream_id;
+			uint32_t start_line;
+			uint32_t end_line;
+		} stream;
+	} u;
 };
 
+/**
+ * dc_probe_scope_is_windowed() - Whether a scope selects lines of a stream.
+ * @scope: scope to check
+ *
+ * Return: true if start_line or end_line of a stream scope is set
+ */
+static inline bool dc_probe_scope_is_windowed(const struct dc_probe_scope *scope)
+{
+	return scope->type == DC_PROBE_SCOPE_STREAM
+			&& (scope->u.stream.start_line || scope->u.stream.end_line);
+}
+
 /**
  * struct dc_probe_state - DM-authored descriptor of a single probe.
  *
@@ -70,7 +121,7 @@ struct dc_probe_scope {
  *
  * @type:         what to measure.
  * @target_state: desired lifecycle state for this probe.
- * @scope:        what the probe is scoped to (GLOBAL only for now).
+ * @scope:        what the probe is scoped to.
  */
 struct dc_probe_state {
 	enum dc_probe_type         type;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index db29e56f2367..ab3a63cb2042 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1097,6 +1097,82 @@ static bool hubbub60_perfmon_get_urgent_assertion_count(
 	return updated;
 }
 
+/**
+ * hubbub60_perfmon_start_measuring_urgent_request_count() - Start counting urgent DF requests.
+ * @hubbub: hubbub instance
+ *
+ * Counts SDPIF request-valid events whose UTM QoS profile matches the urgent
+ * profile (event 256, filtered_sdpif_req_vld), over all request types and all
+ * Unit IDs. Counter 0 accumulates at level mode and runs from the moment
+ * PERFMON_STATE is set to run until the counters are reset, so the caller
+ * defines the measurement window in software.
+ */
+static void hubbub60_perfmon_start_measuring_urgent_request_count(
+		struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	/* configure measurement control */
+	REG_SET_5(DCHUBBUB_PERFORMANCE_MEASUREMENT_CNTL, 0,
+			DCHUBBUB_LATENCY_CNT_EN, 0x1,
+			DCHUBBUB_DF_REQ_CMD_LATENCY_SEL, 0x1, // cacheable
+			ARB_LATENCY_REQ_TYPE_SEL, 0x7, // all request types
+			REQ_UNIT_ID_MASK, 0x0, // all Unit IDs
+			REQ_UNIT_ID_SEL, 0x0);
+	REG_SET_2(DCHUBBUB_PERFORMANCE_MEASUREMENT_CNTL2, 0,
+			LATENCY_SOURCE_SEL, 0x2, // df latency
+			UTM_FILTER_SEL, 0x1); // urgent only
+
+	/* program counter 0 to count filtered urgent requests */
+	REG_SET_8(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+			PERFCOUNTER_CNTL_SEL, 0x0,
+			PERFCOUNTER_EVENT_SEL, 256, // filtered_sdpif_req_vld
+			PERFCOUNTER_CVALUE_SEL, 0x0,
+			PERFCOUNTER_INC_MODE, 0x2, // count LSB level
+			PERFCOUNTER_HW_CNTL_SEL, 0x0,
+			PERFCOUNTER_RUNEN_MODE, 0x0,
+			PERFCOUNTER_RESTART_EN, 0x0,
+			PERFCOUNTER_ACTIVE, 1);
+	REG_SET_4(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
+			PERFCOUNTER_CNTL2_SEL, 0x0,
+			PERFCOUNTER_COUNTED_VALUE_TYPE, 0x0, // accumulated
+			PERFCOUNTER_HW_STOP1_SEL, 0x0,
+			PERFCOUNTER_HW_STOP2_SEL, 0x0);
+
+	REG_WRITE(DC_PERFMON5_PERFCOUNTER_STATE, 0);
+
+	/* software controlled window, no OTG start/stop event */
+	REG_SET_2(DC_PERFMON5_PERFMON_CNTL2, 0,
+			PERFMON_RUN_ENABLE_START_SEL, 0x0,
+			PERFMON_RUN_ENABLE_STOP_SEL, 0x0);
+
+	/* start the counter */
+	REG_SET_2(DC_PERFMON5_PERFMON_CNTL, 0,
+			PERFMON_STATE, 0x1,
+			PERFMON_RPT_COUNT, 0xFFFFF);
+}
+
+/**
+ * hubbub60_perfmon_get_urgent_request_count() - Read the urgent request count.
+ * @hubbub: hubbub instance
+ *
+ * Reads the running counter, which keeps counting until the counters are reset.
+ *
+ * Return: number of urgent requests counted since
+ * hubbub60_perfmon_start_measuring_urgent_request_count().
+ */
+static uint32_t hubbub60_perfmon_get_urgent_request_count(
+		struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t count0 = 0;
+
+	REG_SET(DC_PERFMON5_PERFMON_HI, 0, PERFMON_READ_SEL, 0x0);
+	REG_GET(DC_PERFMON5_PERFMON_LOW, PERFMON_LOW, &count0);
+
+	return count0;
+}
+
 /**
  * @brief Configures the performance monitor to measure the urgent ramp
  * latency.
@@ -1952,6 +2028,10 @@ static const struct hubbub_funcs hubbub60_funcs = {
 			hubbub60_perfmon_start_measuring_urgent_assertion_count,
 		.get_urgent_assertion_count =
 			hubbub60_perfmon_get_urgent_assertion_count,
+		.start_measuring_urgent_request_count =
+			hubbub60_perfmon_start_measuring_urgent_request_count,
+		.get_urgent_request_count =
+			hubbub60_perfmon_get_urgent_request_count,
 		.start_measuring_urgent_ramp_latency =
 			hubbub60_perfmon_start_measuring_urgent_ramp_latency,
 		.get_urgent_ramp_latency_ns =
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 3ae06bf89f79..a0bd134c37b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -313,7 +313,8 @@
 	type URGENT_FORCE_EN;\
 	type FORCE_DISP_PREF_TO_VBLANK;\
 	type DST_Y_ALT_CH_DRQ_LIMIT;\
-	type FORCE_CURSOR_TO_DISP_PREF
+	type FORCE_CURSOR_TO_DISP_PREF;\
+	type HUBP_XRQ_NO_OUTSTANDING_REQ
 /*
 	type HUBP_3DLUT_CROSSBAR_SEL_B;\
 	type HUBP_3DLUT_CROSSBAR_SEL_G;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
index 7c2ff310ea99..6604fb880341 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
@@ -409,6 +409,40 @@ void hubp60_read_state(struct hubp *hubp)
 	s->flip_control = REG_READ(DCSURF_FLIP_CONTROL);
 }
 
+/**
+ * hubp60_get_outstanding_req_status() - Sample the outstanding request status of HUBP.
+ * @hubp: hubp instance
+ *
+ * Reads DCHUBP_CNTL once. The no-outstanding fields read 1 when idle, so they are inverted
+ * into HUBP_OUTSTANDING_* bits that are set when something is outstanding.
+ *
+ * Return: HUBP_OUTSTANDING_* and HUBP_NOT_IN_BLANK bits
+ */
+static uint32_t hubp60_get_outstanding_req_status(struct hubp *hubp)
+{
+       struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+       uint32_t no_outstanding_req = 0;
+       uint32_t xrq_no_outstanding_req = 0;
+       uint32_t in_blank = 0;
+       uint32_t status = 0;
+
+       REG_GET_3(DCHUBP_CNTL,
+		HUBP_NO_OUTSTANDING_REQ, &no_outstanding_req,
+		HUBP_XRQ_NO_OUTSTANDING_REQ, &xrq_no_outstanding_req,
+		HUBP_IN_BLANK, &in_blank);
+
+       if (!no_outstanding_req)
+		status |= HUBP_OUTSTANDING_ANY;
+       if (!(xrq_no_outstanding_req & HUBP_XRQ_NO_OUTSTANDING_DRQ))
+		status |= HUBP_OUTSTANDING_DRQ;
+       if (!(xrq_no_outstanding_req & HUBP_XRQ_NO_OUTSTANDING_CRQ_TRQ))
+		status |= HUBP_OUTSTANDING_CRQ_TRQ;
+       if (!in_blank)
+		status |= HUBP_NOT_IN_BLANK;
+
+       return status;
+}
+
 static struct hubp_funcs dcn60_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -438,6 +472,7 @@ static struct hubp_funcs dcn60_hubp_funcs = {
 	.hubp_soft_reset = hubp31_soft_reset,
 	.hubp_set_flip_int = hubp401_set_flip_int,
 	.hubp_in_blank = hubp401_in_blank,
+	.hubp_get_outstanding_req_status = hubp60_get_outstanding_req_status,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = NULL,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
index e502c9330cef..dac20ed6bb0c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
@@ -34,6 +34,7 @@
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_IN_BLANK, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_SOFT_RESET, mask_sh),\
+	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_XRQ_NO_OUTSTANDING_REQ, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, NUM_PIPES, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, PIPE_INTERLEAVE, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, MAX_COMPRESSED_FRAGS, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 8a38b7f0bef0..67b778001bce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -48,7 +48,6 @@
 	hws->regs->reg
 #define DC_LOGGER \
 	dc->ctx->logger
-
 #undef FN
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
@@ -966,29 +965,140 @@ void dcn60_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe_idx);
 }
 
+/**
+ * dcn60_get_otg_master_pipe - Resolve the OTG master pipe of a stream.
+ * @context:   committed dc state to resolve streams from
+ * @stream_id: stream_id of the stream to look for
+ *
+ * Returns the OTG master pipe driving the stream, or NULL when the stream is
+ * not in the committed state.
+ */
+static struct pipe_ctx *dcn60_get_otg_master_pipe(
+		struct dc_state *context,
+		uint32_t stream_id)
+{
+	struct dc_stream_state *stream;
+
+	if (!context)
+		return NULL;
+
+	stream = dc_state_get_stream_from_id(context, stream_id);
+	if (!stream)
+		return NULL;
+
+	return resource_get_otg_master_for_stream(&context->res_ctx, stream);
+}
+
 /**
  * dcn60_get_ref_tg_for_hubbub_probe - Resolve the OTG master for hubbub probing.
  * @context: committed dc state to resolve streams from
+ * @probe:   probe to resolve the OTG master for
  *
  * All probe types gate their measurement window to frame edges of the OTG
- * master of stream 0. Returns NULL when no active stream is present.
+ * master of the probe's stream, or of stream 0 when the probe has no stream.
+ * Returns NULL when that stream is not active.
  */
 static struct timing_generator *dcn60_get_ref_tg_for_hubbub_probe(
-		struct dc_state *context)
+		struct dc_state *context,
+		const struct dc_probe_state *probe)
 {
 	struct pipe_ctx *otg_pipe;
 
 	if (!context || !context->stream_count)
 		return NULL;
 
-	otg_pipe = resource_get_otg_master_for_stream(&context->res_ctx,
-			context->streams[0]);
+	if (probe->scope.type == DC_PROBE_SCOPE_STREAM)
+		otg_pipe = dcn60_get_otg_master_pipe(context, probe->scope.u.stream.stream_id);
+	else
+		otg_pipe = resource_get_otg_master_for_stream(&context->res_ctx,
+				context->streams[0]);
 	if (!otg_pipe)
 		return NULL;
 
 	return otg_pipe->stream_res.tg;
 }
 
+/**
+ * dcn60_build_urgent_window_sequence - Build the BLS sequence for one urgent window.
+ * @dc:        DC structure
+ * @context:   Committed dc state to resolve streams from
+ * @probe:     Urgent probe state scoped to a window of a stream
+ * @status:    Result sink for the sequence
+ * @seq_state: Sequence to append steps to
+ *
+ * Measures one window between the start and end lines of the probe scope, as a one
+ * shot. The perfmon counter is armed at the start line and stopped at the end line.
+ * A zero start line is the vblank start of the stream, which the OTG programs at
+ * v_total - v_front_porch. The waits approach each line from below and are
+ * wrap-aware, so they self-sync to a fresh edge and support a window that crosses
+ * the v_total wrap. Arming takes longer than a line, so a window that is already
+ * over when the end line is waited on is missed, and its status is not valid
+ * instead of a whole frame being measured. For the urgent assertion count, HUBP is
+ * sampled once after the counter has been read, so the sample does not disturb the
+ * window. No steps are added when prerequisites are not met.
+ */
+static void dcn60_build_urgent_window_sequence(
+		struct dc *dc,
+		struct dc_state *context,
+		const struct dc_probe_state *probe,
+		struct dc_probe_status *status,
+		struct block_sequence_state *seq_state)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+	uint32_t refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+	struct pipe_ctx *otg_pipe = dcn60_get_otg_master_pipe(context,
+			probe->scope.u.stream.stream_id);
+	struct timing_generator *ref_tg = otg_pipe ? otg_pipe->stream_res.tg : NULL;
+	struct hubp *ref_hubp = otg_pipe ? otg_pipe->plane_res.hubp : NULL;
+	unsigned int start_line = probe->scope.u.stream.start_line;
+	unsigned int end_line = probe->scope.u.stream.end_line;
+	struct dc_probe_urgent_assertion *assertion = &status->u.urgent_assertion;
+
+	status->valid = false;
+
+	if (probe->target_state != DC_PROBE_MEASURED || !ref_tg)
+		return;
+
+	if (!start_line)
+		start_line = otg_pipe->stream->timing.v_total - otg_pipe->stream->timing.v_front_porch;
+
+	if (probe->type == DC_PROBE_URGENT_REQUEST_COUNT) {
+		if (!hubbub->funcs->perfmon.start_measuring_urgent_request_count ||
+				!hubbub->funcs->perfmon.get_urgent_request_count)
+			return;
+
+		status->valid = true;
+		hwss_add_hubbub_perfmon_reset(seq_state, hubbub);
+		hwss_add_tg_wait_for_position(seq_state, ref_tg, start_line, 0, NULL);
+		hwss_add_hubbub_perfmon_start_urgent_request_count(seq_state, hubbub);
+		hwss_add_tg_wait_for_position(seq_state, ref_tg, end_line, start_line,
+				&status->valid);
+		hwss_add_hubbub_perfmon_get_urgent_request_count(seq_state, hubbub,
+				&status->u.urgent_request_count);
+		return;
+	}
+
+	if (probe->type != DC_PROBE_URGENT_ASSERTION_COUNT ||
+			!hubbub->funcs->perfmon.start_measuring_urgent_assertion_count ||
+			!hubbub->funcs->perfmon.get_urgent_assertion_count)
+		return;
+
+	assertion->outstanding.raw = 0;
+	status->valid = true;
+
+	hwss_add_tg_wait_for_position(seq_state, ref_tg, start_line, 0, NULL);
+	hwss_add_hubbub_perfmon_reset(seq_state, hubbub);
+	hwss_add_hubbub_perfmon_start_urgent_assertion_count(seq_state, hubbub);
+	hwss_add_tg_wait_for_position(seq_state, ref_tg, end_line, start_line,
+				&status->valid);
+	hwss_add_hubbub_perfmon_get_urgent_assertion_count(seq_state, hubbub,
+			refclk_mhz, &assertion->count,
+			&assertion->deassertion_count);
+	if (ref_hubp)
+		hwss_add_hubp_get_outstanding_req(seq_state, ref_hubp,
+				&assertion->outstanding.raw);
+}
+
 /**
  * dcn60_build_hubbub_perfmon_sequence - Build the hubbub perfmon BLS sequence.
  * @dc:             DC structure
@@ -1011,9 +1121,10 @@ static void dcn60_build_hubbub_perfmon_sequence(
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	uint32_t refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
-	struct timing_generator *ref_tg = dcn60_get_ref_tg_for_hubbub_probe(context);
+	struct timing_generator *ref_tg = dcn60_get_ref_tg_for_hubbub_probe(context, probe);
 	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
-	bool was_measuring = status->measuring;
+	/* The running counter can only be reused by a probe of the same type. */
+	bool continuing = status->measuring && status->type == probe->type;
 
 	if (!hubbub || !hubbub->funcs || !hubbub->funcs->perfmon.reset)
 		return;
@@ -1023,20 +1134,49 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		return;
 	}
 
+	if (dc_probe_scope_is_windowed(&probe->scope)) {
+		dcn60_build_urgent_window_sequence(dc, context, probe, status, &seq_state);
+		return;
+	}
+
+	/*
+	 * Polling starts the counter once, then every poll reads the running counter
+	 * without stopping it. Switching to a different probe type resets the counter
+	 * and programs the new configuration first.
+	 */
 	if (probe->target_state == DC_PROBE_MEASURING) {
-		if (probe->type != DC_PROBE_URGENT_ASSERTION_COUNT ||
-				!hubbub->funcs->perfmon.start_measuring_urgent_assertion_count ||
-				!hubbub->funcs->perfmon.get_urgent_assertion_count)
+		switch (probe->type) {
+		case DC_PROBE_URGENT_ASSERTION_COUNT:
+			if (!hubbub->funcs->perfmon.start_measuring_urgent_assertion_count ||
+					!hubbub->funcs->perfmon.get_urgent_assertion_count)
+				return;
+
+			if (!continuing) {
+				hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
+				hwss_add_hubbub_perfmon_start_urgent_assertion_count(&seq_state, hubbub);
+			}
+
+			hwss_add_hubbub_perfmon_get_urgent_assertion_count(&seq_state, hubbub,
+					refclk_mhz, &status->u.urgent_assertion.count, NULL);
 			return;
 
-		if (!was_measuring) {
-			hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
-			hwss_add_hubbub_perfmon_start_urgent_assertion_count(&seq_state, hubbub);
-		}
+		case DC_PROBE_URGENT_REQUEST_COUNT:
+			if (!hubbub->funcs->perfmon.start_measuring_urgent_request_count ||
+					!hubbub->funcs->perfmon.get_urgent_request_count)
+				return;
 
-		hwss_add_hubbub_perfmon_get_urgent_assertion_count(&seq_state, hubbub,
-				refclk_mhz, &status->u.urgent_assertion_count);
-		return;
+			if (!continuing) {
+				hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
+				hwss_add_hubbub_perfmon_start_urgent_request_count(&seq_state, hubbub);
+			}
+
+			hwss_add_hubbub_perfmon_get_urgent_request_count(&seq_state, hubbub,
+					&status->u.urgent_request_count);
+			return;
+
+		default:
+			return;
+		}
 	}
 
 	if (probe->target_state != DC_PROBE_MEASURED || !ref_tg)
@@ -1124,7 +1264,22 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_urgent_assertion_count(&seq_state, hubbub,
-				refclk_mhz, &status->u.urgent_assertion_count);
+				refclk_mhz, &status->u.urgent_assertion.count, NULL);
+		return;
+
+	case DC_PROBE_URGENT_REQUEST_COUNT:
+		if (!hubbub->funcs->perfmon.start_measuring_urgent_request_count ||
+				!hubbub->funcs->perfmon.get_urgent_request_count)
+			return;
+
+		hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
+		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
+		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
+		hwss_add_hubbub_perfmon_start_urgent_request_count(&seq_state, hubbub);
+		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
+		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
+		hwss_add_hubbub_perfmon_get_urgent_request_count(&seq_state, hubbub,
+				&status->u.urgent_request_count);
 		return;
 
 	case DC_PROBE_PREFETCH_DATA_SIZE:
@@ -1143,7 +1298,9 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		return;
 
 	case DC_PROBE_URGENT_RAMP_LATENCY:
-		/* Requires caller-supplied window params not available in probe model. */
+		/* Window params are available in dc_probe_scope, but the ramp latency measurement
+		 * is not implemented.
+		 */
 		return;
 
 	default:
@@ -1151,10 +1308,31 @@ static void dcn60_build_hubbub_perfmon_sequence(
 	}
 }
 
+/**
+ * dcn60_decode_outstanding_req - Decode the HUBP outstanding request status.
+ * @outstanding: raw holds HUBP_OUTSTANDING_* and HUBP_NOT_IN_BLANK bits on entry,
+ *               and the decoded bits on return
+ */
+static void dcn60_decode_outstanding_req(union dc_probe_outstanding_req *outstanding)
+{
+	uint32_t hw_status = outstanding->raw;
+
+	outstanding->raw = 0;
+	outstanding->bits.any = !!(hw_status & HUBP_OUTSTANDING_ANY);
+	outstanding->bits.data = !!(hw_status & HUBP_OUTSTANDING_DRQ);
+	outstanding->bits.chunk_meta_trans = !!(hw_status & HUBP_OUTSTANDING_CRQ_TRQ);
+	outstanding->bits.not_in_blank = !!(hw_status & HUBP_NOT_IN_BLANK);
+}
+
 /**
  * dcn60_update_probe_status - Set the valid flag on a latched probe result.
  * @status: result sink whose u was written by the GET BLS step during execute
  * @probe: current probe state used to determine measurement type and validity
+ *
+ * TODO: the status has no single owner. The builders read the previous status
+ * (measuring), pass pointers into it as the execute output sinks (u, and valid
+ * for a window), and this function then rebuilds it. Build into a scratch result
+ * instead, keep the previous status read-only, and finalize the status once here.
  */
 static void dcn60_update_probe_status(
 		struct dc_probe_status *status,
@@ -1171,6 +1349,17 @@ static void dcn60_update_probe_status(
 	status->measuring = probe->target_state == DC_PROBE_MEASURING;
 	status->u = result.u;
 
+	if (probe->type == DC_PROBE_URGENT_ASSERTION_COUNT) {
+		struct dc_probe_urgent_assertion *assertion = &status->u.urgent_assertion;
+
+		if (dc_probe_scope_is_windowed(&probe->scope)) {
+			dcn60_decode_outstanding_req(&assertion->outstanding);
+		} else {
+			assertion->deassertion_count = 0;
+			assertion->outstanding.raw = 0;
+		}
+	}
+
 	switch (probe->type) {
 	case DC_PROBE_PEAK_MEM_BW:
 	case DC_PROBE_PEAK_MEM_BW_STRESSED:
@@ -1181,12 +1370,17 @@ static void dcn60_update_probe_status(
 	case DC_PROBE_MEM_LATENCY:
 	case DC_PROBE_URGENT_ASSERTION_COUNT:
 	case DC_PROBE_PREFETCH_DATA_SIZE:
+	case DC_PROBE_URGENT_REQUEST_COUNT:
 		status->valid = true;
 		break;
 	default:
 		status->valid = false;
 		break;
 	}
+
+	/* A window is valid only if its sequence was built and the end line was not missed. */
+	if (probe->target_state == DC_PROBE_MEASURED && dc_probe_scope_is_windowed(&probe->scope))
+		status->valid = result.valid;
 }
 
 /**
@@ -1204,6 +1398,7 @@ static bool is_probe_measurement_type_for_hubbub(enum dc_probe_type type)
 	case DC_PROBE_URGENT_ASSERTION_COUNT:
 	case DC_PROBE_PREFETCH_DATA_SIZE:
 	case DC_PROBE_URGENT_RAMP_LATENCY:
+	case DC_PROBE_URGENT_REQUEST_COUNT:
 		return true;
 	default:
 		return false;
@@ -1240,8 +1435,16 @@ void dcn60_program_perfmon(struct dc *dc, struct dc_state *context)
 
 	hwss_execute_sequence(dc, context->block_sequence, context->block_sequence_steps);
 
-	for (i = 0; i < context->probe_count; i++)
+	for (i = 0; i < context->probe_count; i++) {
 		dcn60_update_probe_status(&context->probe_status[i], &context->probes[i]);
+
+		/* A stream that is not in the committed state has nothing to measure. */
+		if (context->probes[i].scope.type == DC_PROBE_SCOPE_STREAM
+				&& context->probes[i].target_state != DC_PROBE_NOT_MEASURING
+				&& !dcn60_get_otg_master_pipe(context,
+						context->probes[i].scope.u.stream.stream_id))
+			context->probe_status[i].valid = false;
+	}
 }
 
 static bool dcn60_has_active_memory_request(const struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c2e256a40128..e447dd2c69ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -671,6 +671,18 @@ struct tg_wait_for_state_params {
 	enum crtc_state state;
 };
 
+struct tg_wait_for_position_params {
+	struct timing_generator *tg;
+	unsigned int line;
+	unsigned int window_start; /* start line of the window that line ends, used with window_valid */
+	bool *window_valid;        /* optional, cleared when line was already passed on entry */
+};
+
+struct hubp_get_outstanding_req_params {
+	struct hubp *hubp;
+	uint32_t *status;
+};
+
 struct tg_set_vtg_params_params {
 	struct timing_generator *tg;
 	struct dc_crtc_timing *timing;
@@ -926,6 +938,10 @@ struct hubbub_perfmon_start_urgent_assertion_count_params {
 	struct hubbub *hubbub;
 };
 
+struct hubbub_perfmon_start_urgent_request_count_params {
+	struct hubbub *hubbub;
+};
+
 struct hubbub_perfmon_start_urgent_ramp_latency_params {
 	struct hubbub *hubbub;
 	struct hubbub_urgent_latency_params latency_params;
@@ -960,6 +976,12 @@ struct hubbub_perfmon_get_urgent_assertion_count_params {
 	struct hubbub *hubbub;
 	uint32_t       refclk_mhz;
 	uint32_t      *assertion_count;
+	uint32_t      *deassertion_count;
+};
+
+struct hubbub_perfmon_get_urgent_request_count_params {
+	struct hubbub *hubbub;
+	uint32_t      *request_count;
 };
 
 struct hubbub_perfmon_get_prefetch_data_size_params {
@@ -1407,6 +1429,8 @@ union block_sequence_params {
 	struct dsc_enable_with_opp_params dsc_enable_with_opp_params;
 	struct tg_program_global_sync_params tg_program_global_sync_params;
 	struct tg_wait_for_state_params tg_wait_for_state_params;
+	struct tg_wait_for_position_params tg_wait_for_position_params;
+	struct hubp_get_outstanding_req_params hubp_get_outstanding_req_params;
 	struct tg_set_vtg_params_params tg_set_vtg_params_params;
 	struct tg_setup_vertical_interrupt2_params tg_setup_vertical_interrupt2_params;
 	struct dpp_set_hdr_multiplier_params dpp_set_hdr_multiplier_params;
@@ -1450,12 +1474,14 @@ union block_sequence_params {
 	struct hubbub_perfmon_start_in_order_bw_params hubbub_perfmon_start_in_order_bw_params;
 	struct hubbub_perfmon_start_memory_latencies_params hubbub_perfmon_start_memory_latencies_params;
 	struct hubbub_perfmon_start_urgent_assertion_count_params hubbub_perfmon_start_urgent_assertion_count_params;
+	struct hubbub_perfmon_start_urgent_request_count_params hubbub_perfmon_start_urgent_request_count_params;
 	struct hubbub_perfmon_start_urgent_ramp_latency_params hubbub_perfmon_start_urgent_ramp_latency_params;
 	struct hubbub_perfmon_start_prefetch_data_size_params hubbub_perfmon_start_prefetch_data_size_params;
 	struct hubbub_perfmon_get_out_of_order_bw_params hubbub_perfmon_get_out_of_order_bw_params;
 	struct hubbub_perfmon_get_in_order_bw_params hubbub_perfmon_get_in_order_bw_params;
 	struct hubbub_perfmon_get_memory_latencies_params hubbub_perfmon_get_memory_latencies_params;
 	struct hubbub_perfmon_get_urgent_assertion_count_params hubbub_perfmon_get_urgent_assertion_count_params;
+	struct hubbub_perfmon_get_urgent_request_count_params hubbub_perfmon_get_urgent_request_count_params;
 	struct hubbub_perfmon_get_prefetch_data_size_params hubbub_perfmon_get_prefetch_data_size_params;
 	struct hubbub_perfmon_get_urgent_ramp_latency_params hubbub_perfmon_get_urgent_ramp_latency_params;
 	struct hubp_clk_cntl_params hubp_clk_cntl_params;
@@ -1657,6 +1683,8 @@ enum block_sequence_func {
 	DSC_ENABLE_WITH_OPP,
 	TG_PROGRAM_GLOBAL_SYNC,
 	TG_WAIT_FOR_STATE,
+	TG_WAIT_FOR_POSITION,
+	HUBP_GET_OUTSTANDING_REQ,
 	TG_SET_VTG_PARAMS,
 	TG_SETUP_VERTICAL_INTERRUPT2,
 	HUBP_PROGRAM_DET_SIZE,
@@ -1767,12 +1795,14 @@ enum block_sequence_func {
 	HUBBUB_PERFMON_START_IN_ORDER_BW,
 	HUBBUB_PERFMON_START_MEMORY_LATENCIES,
 	HUBBUB_PERFMON_START_URGENT_ASSERTION_COUNT,
+	HUBBUB_PERFMON_START_URGENT_REQUEST_COUNT,
 	HUBBUB_PERFMON_START_URGENT_RAMP_LATENCY,
 	HUBBUB_PERFMON_START_PREFETCH_DATA_SIZE,
 	HUBBUB_PERFMON_GET_OUT_OF_ORDER_BW,
 	HUBBUB_PERFMON_GET_IN_ORDER_BW,
 	HUBBUB_PERFMON_GET_MEMORY_LATENCIES,
 	HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT,
+	HUBBUB_PERFMON_GET_URGENT_REQUEST_COUNT,
 	HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE,
 	HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY,
 	LEGACY_CLK_MGR_INIT_CLOCKS,
@@ -2425,6 +2455,10 @@ void hwss_tg_program_global_sync(union block_sequence_params *params);
 
 void hwss_tg_wait_for_state(union block_sequence_params *params);
 
+void hwss_tg_wait_for_position(union block_sequence_params *params);
+
+void hwss_hubp_get_outstanding_req(union block_sequence_params *params);
+
 void hwss_tg_set_vtg_params(union block_sequence_params *params);
 
 void hwss_hubp_enable_3dlut_fl(union block_sequence_params *params);
@@ -2518,6 +2552,8 @@ void hwss_hubbub_perfmon_start_memory_latencies(union block_sequence_params *par
 
 void hwss_hubbub_perfmon_start_urgent_assertion_count(union block_sequence_params *params);
 
+void hwss_hubbub_perfmon_start_urgent_request_count(union block_sequence_params *params);
+
 void hwss_hubbub_perfmon_start_urgent_ramp_latency(union block_sequence_params *params);
 
 void hwss_hubbub_perfmon_start_prefetch_data_size(union block_sequence_params *params);
@@ -2530,6 +2566,8 @@ void hwss_hubbub_perfmon_get_memory_latencies(union block_sequence_params *param
 
 void hwss_hubbub_perfmon_get_urgent_assertion_count(union block_sequence_params *params);
 
+void hwss_hubbub_perfmon_get_urgent_request_count(union block_sequence_params *params);
+
 void hwss_hubbub_perfmon_get_prefetch_data_size(union block_sequence_params *params);
 
 void hwss_hubbub_perfmon_get_urgent_ramp_latency(union block_sequence_params *params);
@@ -2711,6 +2749,13 @@ void hwss_add_tg_program_global_sync(struct block_sequence_state *seq_state,
 void hwss_add_tg_wait_for_state(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, enum crtc_state state);
 
+void hwss_add_tg_wait_for_position(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, unsigned int line,
+		unsigned int window_start, bool *window_valid);
+
+void hwss_add_hubp_get_outstanding_req(struct block_sequence_state *seq_state,
+		struct hubp *hubp, uint32_t *status);
+
 void hwss_add_tg_set_vtg_params(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
 
@@ -2895,6 +2940,9 @@ void hwss_add_hubbub_perfmon_start_memory_latencies(struct block_sequence_state
 void hwss_add_hubbub_perfmon_start_urgent_assertion_count(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub);
 
+void hwss_add_hubbub_perfmon_start_urgent_request_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
 void hwss_add_hubbub_perfmon_start_urgent_ramp_latency(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
 		const struct hubbub_urgent_latency_params *latency_params);
@@ -2916,7 +2964,10 @@ void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *s
 
 void hwss_add_hubbub_perfmon_get_urgent_assertion_count(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t refclk_mhz,
-		uint32_t *assertion_count);
+		uint32_t *assertion_count, uint32_t *deassertion_count);
+
+void hwss_add_hubbub_perfmon_get_urgent_request_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t *request_count);
 
 void hwss_add_hubbub_perfmon_get_prefetch_data_size(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t *prefetch_data_size);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 7280f57f75bf..0b5fe1ca04e0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -294,6 +294,9 @@ struct hubbub_funcs {
 				uint32_t *assertion_count,
 				uint32_t *deassertion_count,
 				uint32_t *timestamp_us);
+		void (*start_measuring_urgent_request_count)(
+				struct hubbub *hubbub);
+		uint32_t (*get_urgent_request_count)(struct hubbub *hubbub);
 		void (*start_measuring_urgent_ramp_latency)(
 				struct hubbub *hubbub,
 				const struct hubbub_urgent_latency_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index d1cbcb87d271..d6b23bd3cdce 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -100,6 +100,16 @@ enum hubp_3dlut_fl_crossbar_bit_slice {
 	hubp_3dlut_fl_crossbar_bit_slice_48_63 = 3
 };
 
+/* Bits returned by hubp_get_outstanding_req_status(), decoded from DCHUBP_CNTL. */
+#define HUBP_OUTSTANDING_ANY		0x1	/* a request is outstanding in HUBP */
+#define HUBP_OUTSTANDING_DRQ		0x2	/* a data request is outstanding */
+#define HUBP_OUTSTANDING_CRQ_TRQ	0x4	/* a chunk/meta or translation request is outstanding */
+#define HUBP_NOT_IN_BLANK		0x8	/* HUBP has not finished requesting for the frame */
+
+/* Request types in the HUBP_XRQ_NO_OUTSTANDING_REQ field of DCHUBP_CNTL, a bit reads 1 when idle. */
+#define HUBP_XRQ_NO_OUTSTANDING_DRQ	0x1
+#define HUBP_XRQ_NO_OUTSTANDING_CRQ_TRQ	0x8
+
 struct hubp {
 	const struct hubp_funcs *funcs;
 	struct dc_context *ctx;
@@ -261,6 +271,8 @@ struct hubp_funcs {
 		struct hubp *hubp,
 		bool enable);
 	bool (*hubp_in_blank)(struct hubp *hubp);
+	/* Decoded outstanding request and blank status, see HUBP_OUTSTANDING_*. */
+	uint32_t (*hubp_get_outstanding_req_status)(struct hubp *hubp);
 	void (*hubp_soft_reset)(struct hubp *hubp, bool reset);
 
 	void (*hubp_set_flip_int)(struct hubp *hubp);
-- 
2.43.0

