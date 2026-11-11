Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B6606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4IGMqy5f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6A510F8CF;
	Wed, 11 Nov 2026 01:42:25 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C5D10F8CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKKGyaHXrnetbFEsd5/M4kiMAfXOPILm4akiywrHCFJDsHouFoDTgPcrSFMX/B27M3BQJiHUxElb0VZN6ggLpIYIbbkGMm7UsKKwmcZVhZ+9n2RBujjdbfoNOpjiweQGD/PIMCtft6/eHe68sFTqj9WFSReE22y3tDQLISOGgZO/xpzpRasBzb4htW2D8g+lcDDuFBT3rKkOKMma3uqeLi/uFTHGyEZ5ovekr89aPr8mFJ0N8h8YW38zeWg7ik2p/9QAtnaFq0Uq1OedzSHW8AcMBn9QXSh/k2uIAxcKggonulwIWMKVjWRqBWEoQ2ZozwENZkmeObahO+5QI3Eqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku9IQ9gx9qmxe27Tl62iB8sQtHy1FdSVXrugv8AI8L0=;
 b=A+4/IMBbqMtgqouHQb8CS7/XYhlzv1hN3OzPHIET26zv4JaWch5s5jwUfbYvs+5ZHl6qCAqMD3UxKltx21D5fY8e/grV5K6Sl+JtJ0PD22zpIWJ8IFB6eS0D+Ctbm0ArTnUFvd3s+55o6ANA6VJuuzyP55v2ZfV0MNqB0N2y67O13FdAwOuZYdEYVX4mAZslRLERH9mVmBpAn5Q3KLqEqmI5uhtsWpEQGZI8P4/SR2qTRHP14uiWzrJTT96m8K+jk0WTrlcSSdV0oXRPj50sgZFnL8W8NZhjcY/RR4ZShQt4OSBatlLXCWwFqwgoxkWnPNW5fCIlunVLLCu44wLO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku9IQ9gx9qmxe27Tl62iB8sQtHy1FdSVXrugv8AI8L0=;
 b=4IGMqy5fLv+mJbjULuR1DrgGsbYkiF8yOkNGsmnI5NgAitPQQyh41HKDAq3mgX2IolFUK3n0/8UViRPT/Wgsc+eVNbnNKRMcFT0P/TsoB7gfh9fDq8cc2AZZFjIlY0nfrg2hGQ6MQnJUuDe8q0/qvrRgsigDaVYzSg3k2w9pO0Q=
Received: from CH2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:610:60::12)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 01:42:02 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::9d) by CH2PR14CA0002.outlook.office365.com
 (2603:10b6:610:60::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:01 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:58 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ashwin Santhosh <Ashwin.Santhosh@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 26/74] drm/amd/display: Skip visual confirm color programming
 when FW owns it
Date: Wed, 11 Nov 2026 09:28:32 +0800
Message-ID: <20261111014100.3596072-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b559fd-cb2d-45fc-ee19-08df3f94fbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: OCxtbJ/JGUyhhSJSFmBUuramzrjYCoLXe8fc5JXkS+N3ARETZIFUwq/3wDt7ccW3kChW8eix7TuqEXf9rOFoOpzPlkvTbAs2VtjDQT7elwxGEe31hKCz/4TQxHnrYJVfW1JqtIeSPL4yAOn7cfQkFNnL4iwU//7CErrOJoGV1blCFv2Q2r0WELAJiroBXoR6rTGekzGngTyRGwj1pQefelP5L5JWG4pQFJXA39PdtMSSaF/rNc6bO4eW37q7kMlORd9asUHWnWsdXDlk2PfwACVX0obXOhpi9aLjypF1HtHDoo7qkafHFAJcXP/3v/gUDPRBFALy/41jpr99OjlphcfQh1F5WBWvtM8NtQBaQWPpDhBCTgL5DxJGEj84IjK6xldJCuQaRLSYUPnAg5pUy2Pt3GwQ4lDa/5x0/VBMOMD8s9yLB4q3IFQEN0E+CcOoBLYx5GGNyZqRuUbxBg0TSUsE68xH+f6mqFDM3aGc/Z3OmM5sb44BNlssMtArsRBxcxtZL3fOJddHQpTUNJDrmwjYMQb6Ghtkv6Ruo4qrIxmrT2yoefkrW/VVO7BCDOdwsdW/CPLM+TdGCmUFzdx1CplqRo7jN+JcSS2RPiMxFDe/86aekM2WpL3+nto5+GEsKhnxWtBCjnBjGnXK3ktUsKBPulD+mtnzUmirbSGKsMaevfZbtxITZOmAvjVtkCCwC/RhR0/RWe4MXv2QVBgQRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kfzh84ugyRS3FPqxenfV+tmhrvoZ/zz0Kn82bnH7ZZF6xKk6KNXT55qZxZbcq8f7s+6+vAxDasZfE2T7vSq7QDb2dkgSS3pP+XQWBzf9Zi62T5+ubzz3rLmcC/LlDkUvJ3cfeFxq5dH2WWh0POmfepgWmTDTG6dJ+oVCwVHTHx4CkPWtH5+sBiD2lJ1qnfC8LDlh4rtxVKFJ+pjrJBqyKv/ph+Qilwtr5Oz/G+ixvYFuYkTIAF4j/eaqGxpOp+qfWyYvteR3rFm3S4dp9whhlt1xCTnHd2CHSdHaSzJSTVze+E/P8gnQwdJiV3wfp4hH5LslTSWCK/HffaiSqa+9wA1U2srvThXHY0ED5ck4IULzGDxqOwkNL4NM2434H16kdXG4YRuooWTbufMIBcpri50+eNy7eDOS7LW4sAN8KNCM1MRvZFnccpWpPt0Whqz6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:02.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b559fd-cb2d-45fc-ee19-08df3f94fbf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

why:
For some visual confirm modes DMCUB programs the MPCC background color and
the driver leaves the pipe color all zero to signal that. The driver still
programmed that placeholder on every plane update, which stomped the color
firmware had written. Firmware only repaints across a modeset, so with
visual confirm set to FAMS2 the bar went black after resizing a window and
stayed black until the next mode change. The same stomp applies to the PSR,
FAMS, and REPLAY, which also leave the color to firmware.

how:
Add should_driver_program_visual_confirm, which returns false when visual
confirm is disabled or set to a mode whose color firmware owns. For FAMS2
the driver still paints all pipes grey while FAMS2 is not in use, so
that case checks dc_state_is_fams2_in_use rather than blocking the mode
outright.
Call the helper from dcn10_update_visual_confirm_color, which covers every
caller of the hwss hook, and from hwss_build_fast_sequence, which programs
the color directly and is the only path that bypasses the hook.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 24 ++++++++++++++++++-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  3 +++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  7 ++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2384cbf16ee1..32a33d29835e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -806,6 +806,28 @@ void get_fams2_visual_confirm_color(
 	}
 }
 
+bool should_driver_program_visual_confirm(const struct dc *dc, const struct dc_state *context)
+{
+	switch (dc->debug.visual_confirm) {
+	case VISUAL_CONFIRM_DISABLE:
+		return false;
+	/* DMCUB owns the color for these modes. Programming ours stomps what FW
+	 * wrote, and FW only repaints across a modeset, so the bar stays stale.
+	 */
+	case VISUAL_CONFIRM_PSR:
+	case VISUAL_CONFIRM_FAMS:
+	case VISUAL_CONFIRM_REPLAY:
+		return false;
+	case VISUAL_CONFIRM_FAMS2:
+		/* FW owns the color only while FAMS2 runs. When it is not in use the
+		 * driver paints all pipes grey, and FW does not cover that case.
+		 */
+		return !dc_state_is_fams2_in_use(dc, context);
+	default:
+		return true;
+	}
+}
+
 static bool get_update_dchubp_dpp_flags_status(struct pipe_ctx *pipe)
 {
 	if (!pipe->plane_state) {
@@ -1644,7 +1666,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
 				(*num_steps)++;
 			}
-			if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE &&
+			if (should_driver_program_visual_confirm(dc, context) &&
 				dc->hwss.update_visual_confirm_color) {
 				block_sequence[*num_steps].params.update_visual_confirm_params.mpc = dc->res_pool->mpc;
 				block_sequence[*num_steps].params.update_visual_confirm_params.color = &current_mpc_pipe->visual_confirm_color;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 46a134301526..79c0f55d11e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2951,6 +2951,9 @@ void dcn10_update_visual_confirm_color(struct dc *dc,
 {
 	struct mpc *mpc = dc->res_pool->mpc;
 
+	if (!should_driver_program_visual_confirm(dc, dc->current_state))
+		return;
+
 	if (mpc->funcs->set_bg_color) {
 		mpc->funcs->set_bg_color(mpc, &(pipe_ctx->visual_confirm_color), mpcc_id);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d02834639ab3..a6c743d0cc58 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -2157,6 +2157,13 @@ void get_fams2_visual_confirm_color(
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
 
+/* False for modes whose confirm color DMCUB programs, so the driver leaves
+ * MPCC_BG alone instead of stomping it. Pass the state being programmed.
+ */
+bool should_driver_program_visual_confirm(
+	const struct dc *dc,
+	const struct dc_state *context);
+
 void get_mclk_switch_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-- 
2.43.0

