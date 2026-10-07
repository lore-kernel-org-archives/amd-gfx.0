Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F1CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCCB10E634;
	Wed,  7 Oct 2026 17:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFD4ahGV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEA410E634
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLlPzWajBsuZ04eEc151hqcDNA/JnyVr6KXTeFiWHgaVLfVCTbDs8DR1xYf2nRBQyC+csgdtFdREpJJ88fH2m6sfETpUrREZfTcD/o55ofOREEdBCnNYzCpUZaNBeIpCHGnRELgKk8PgKAtddyJm0f8VUeaj4UF9Be5dBVJBF2LMz/mJIns3NiPLaafFFTjLf3oO0rxmrNX8ulBpgLtkI4VSlaP7KCUPY2vMc0dtJwUXrnYlHAHWVNxCYJkQdaRvdqcl2oH7zyEbtfR6mK+zuOpFfVwwzLpol4d6p7nhrFtqajHqq2lbePyFZe3aTUMSxDk992UKA/Knnrb+tq4obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSSGdjMxmT7jtcsym2rDUwe2qBKTWxIYrfoR2Qf/bAA=;
 b=mzlCUFRHi/xJMrpWm3Bnt2WlbMvhfLWDkTWyAjFxTFjgJsjqWxv1zJ7UldPTOxJX+VsLM19sNLXjBtN53DkvRgvfZ6VcgtECKtXuHJ7FLcBbIooZDh3UtBrKDilSjZfSZzzmwZ4MQL2pbc3P1FqATByG9hy6ff4KBTVgEQoh84uheLcbvAfspMkcuFpSpnZcu6KDREQYYQ+mu8aFFcHLGaSYiBfThxSa+4hfBhnXIRUoZE2us1fIaMuh4NGIP5TYHdODvlYEgpWjcMvtj4w0wjC/W9/IlNwYNdQCnb0I6sGngbBX0TxHORZlNX1ufrqL62Avd7nm3WJnik6CAL7+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSSGdjMxmT7jtcsym2rDUwe2qBKTWxIYrfoR2Qf/bAA=;
 b=AFD4ahGVgwuVucYmCPNYo5PjS61QGEVow7cwrSLqgufRxZNDdL+gLXpHYJLqYmbNCetpl2JPTf3pDm+VhRDaB0n7qz46RQbzQexKp6lcMjXH5/3EIKPznp0F4zYa9t3/uLPDl8XHHBMbnTAYDEIXk7vWarfZdJ3pkw2uIrWoFAw=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 17:04:20 +0000
Received: from MW1PEPF00018891.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::82) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018891.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:18 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/19] drm/amd/display: HWSS Refactor - DPP root clock control
Date: Wed, 7 Oct 2026 12:59:36 -0400
Message-ID: <20261007170412.1898315-4-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018891:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee7d356-c3d2-4043-f715-08df2495076f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PejFEAyK0PqQgiZiCYcxdr66Km8f8IsZTmDKlBNmpXWooYHRchjelngRoKSSi0wGkyO+70+ivIhPW1Wj3dKRZNOWYye5rybepnX4aqoIzgrycwsl75iFP9JkfHbdytWyE/ZyOAW+enQg6842LviH0NNJl6f/7pU89U8ARjJmrQfxH1H42NWKLeGZ1BJOhEiCAVE111vZizLEHxj3acXD5Ke+PnpcwEMKuWbFWyQIvhtfSQ884rOSINbbEk7oD01lCTb9PbC2RSHDVRSpwEL3u5J202+exHPahaHOjcX0yrlTkDq7SfMPwqbq/jef4FK+sVMzn0OHR8cLZeWfIiekiD6zyfVl1Wh/tvBOPTrp3o2A2MTwkbvsVtmTXq6YRMfm1dyx1Jc2yKhb8DoSOdv4CaNACwxZxV5PNrcRTdjDTZtbXhhMdj6tkC/+mgqAeD+x/TR5KkytPTbBb8Z8SbM4qEWPQ+7fBOGIk3oXQjwDOsfb65ZL65zcDaYQTZ26tn2Z19rpcvmBJzrHUuaathfR7jB+qI/1QfK+znr9RJZKMnLWzMwXNfMLeDLubnR3ECl18s1q7PGdHB8Q1YnVj5vkGkpLoGBUPvg9+t40u8VZ64R1b+Z8G/rLT02VPcCBYJxG+1t4AzAa8mLyW2DIIIsW8AD2MkjzWkEK0kD+6gQEeHLRwpeoC6u25Fz3OFUk7i032sPn09jfXiiVpqwkAmjzvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tvisg/BvywfhS6DA+Y9Syf5vxgW4hrF3I9eQEpYs2idY6AZcO3l7Dhb4SYsv4QSmpGg5RyJ2xGy4+Cx/+4Xk9yG2PZpiP80GNBsv5HJ8Ce2r7T7Nc9fcG9fej9z2e952yFKhxlqOXMfN4rzX7TWjZIMmMT2uafwtMlrVwMGxj/HiSsb2X1+XF4ghzTt/QmHx9pcbQ50WisKl3QLp+TadTqtrV4tM+6zmxKzWfwsjfZzmDsUGCj60Nx4YvMZ/C+3FmQqF+6OquOlemUyhCQUD3YIpCSHTso2dACJRJ5nxyjxfiAmMEZDY5NSPacl/nTMuYvLPTKCvX2Xf/PvUXDfL4e1eMemZ1HhNG8RwbJO9yJp2GH9WqxtwnzDrILek7QPJhgIX7ASLwQTAtoFHjbsZRFlUbCFZqb27wQy7sO+Cq8yDRfTPLij7lB7+zc8ztRUq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:20.2583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee7d356-c3d2-4043-f715-08df2495076f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018891.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[WHY]
DPP_ROOT_CLOCK_CONTROL carried a dce_hwseq handle and re-evaluated
dc->debug in the executor, mixing build-time policy with execution.
DCCG DPP root clock gating also read dc->debug directly, so the policy
lived in several layers and could diverge.

[HOW]
- Store struct dccg *dccg in struct dpp_root_clock_control_params. The
  executor calls dccg->funcs->dpp_root_clock_control on the captured
  instance without looking up dc or policy.
- Add is_dpp_root_clock_control_supported(root_clock_optimization_dpp,
  clock_on) to hwseq_private_funcs as a pure ASIC policy: DCN314 needs
  the optimization for both directions, DCN35/351/42 only for gating.
- Add hwss_is_dpp_root_clock_control_allowed() as the single
  qualification point for the BLS builder and legacy HWSS call-sites.
  Without an ASIC hook it applies the DCN35 rule. The hwseq
  dpp_root_clock_control wrappers become pass-through.
- The builder skips the step instead of emitting a no-op when the hwseq
  hook is absent or the policy rejects the direction.
- Add root_clock_optimization_dpp to struct dccg as a mirror of
  dc->debug.root_clock_optimization.bits.dpp. dc core syncs it for all
  ASICs after resource pool creation and before every init_hw, so DM
  overrides applied after dc_create are honored. DCCG35/42 no longer
  read dc->debug for the DPP bit; the RCG allow check moves from
  dccg35_set_dppclk_rcg to its callers.
- Validate builder and executor inputs, including physical DPP index
  bounds for harvested configurations.
- Update BLS/DCCG documentation, golden serialization, DML2.1 stub
  headers and unit tests in core, dccg and hwss.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 61 ++++++++++++++++---
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |  4 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 21 ++++---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |  3 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  6 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 12 ++--
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 17 ++++--
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  6 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 +-
 .../display/dc/hwss/hw_sequencer_private.h    |  3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  6 +-
 20 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7b93f57aff85..430dc7a220ef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4041,12 +4041,12 @@ void hwss_dpp_reset(union block_sequence_params *params)
 
 void hwss_dpp_root_clock_control(union block_sequence_params *params)
 {
-	struct dce_hwseq *hws = params->dpp_root_clock_control_params.hws;
+	struct dccg *dccg = params->dpp_root_clock_control_params.dccg;
 	unsigned int dpp_inst = params->dpp_root_clock_control_params.dpp_inst;
 	bool clock_on = params->dpp_root_clock_control_params.clock_on;
+	bool root_clock_optimization_dpp = params->dpp_root_clock_control_params.root_clock_optimization_dpp;
 
-	if (hws->funcs.dpp_root_clock_control)
-		hws->funcs.dpp_root_clock_control(hws, dpp_inst, clock_on);
+	dccg->funcs->dpp_root_clock_control(dccg, dpp_inst, clock_on, root_clock_optimization_dpp);
 }
 
 void hwss_dc_ip_request_cntl(union block_sequence_params *params)
@@ -5433,18 +5433,59 @@ void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
 	}
 }
 
+bool hwss_is_dpp_root_clock_control_allowed(struct dce_hwseq *hws, bool clock_on)
+{
+	bool root_clock_optimization_dpp;
+
+	if (!hws || !hws->ctx || !hws->ctx->dc)
+		return false;
+
+	root_clock_optimization_dpp = hws->ctx->dc->debug.root_clock_optimization.bits.dpp;
+
+	if (hws->funcs.is_dpp_root_clock_control_supported)
+		return hws->funcs.is_dpp_root_clock_control_supported(
+				root_clock_optimization_dpp, clock_on);
+
+	/* Without ASIC policy only gating depends on the optimization */
+	return root_clock_optimization_dpp || clock_on;
+}
+
 void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
 		unsigned int dpp_inst,
 		bool clock_on)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = DPP_ROOT_CLOCK_CONTROL;
-		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.hws = hws;
-		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.dpp_inst = dpp_inst;
-		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.clock_on = clock_on;
-		(*seq_state->num_steps)++;
-	}
+	struct dc *dc;
+	struct dccg *dccg;
+
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return;
+
+	if (!hws || !hws->funcs.dpp_root_clock_control || !hws->ctx || !hws->ctx->dc)
+		return;
+
+	dc = hws->ctx->dc;
+
+	if (!dc->res_pool || !dc->res_pool->dccg)
+		return;
+
+	dccg = dc->res_pool->dccg;
+
+	if (!dccg->funcs || !dccg->funcs->dpp_root_clock_control ||
+			dpp_inst >= ARRAY_SIZE(dccg->dpp_clock_gated))
+		return;
+
+	if (!hwss_is_dpp_root_clock_control_allowed(hws, clock_on))
+		return;
+
+	seq_state->steps[*seq_state->num_steps].func = DPP_ROOT_CLOCK_CONTROL;
+	seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.dccg = dccg;
+	seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.dpp_inst = dpp_inst;
+	seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.clock_on = clock_on;
+	seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.root_clock_optimization_dpp =
+			dc->debug.root_clock_optimization.bits.dpp;
+	(*seq_state->num_steps)++;
 }
 
 void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index a71851779b37..7bfe7be2bc1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -352,10 +352,12 @@ static void dccg314_set_valid_pixel_rate(
 static void dccg314_dpp_root_clock_control(
 		struct dccg *dccg,
 		unsigned int dpp_inst,
-		bool clock_on)
+		bool clock_on,
+		bool root_clock_optimization_dpp)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	(void)root_clock_optimization_dpp;
 	if (dccg->dpp_clock_gated[dpp_inst] != clock_on)
 		return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index ba624f442915..6dce2a4beca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -395,9 +395,6 @@ static void dccg35_set_dppclk_rcg(struct dccg *dccg, int inst, bool allow_rcg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dpp && allow_rcg)
-		return;
-
 	switch (inst) {
 	case 0:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DPPCLK0_ROOT_GATE_DISABLE, allow_rcg ? 0 : 1);
@@ -1145,7 +1142,8 @@ static void dccg35_disable_dpp_clk_new(
 	REG_SET_2(DPPCLK_DTO_PARAM[inst], 0,
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
-	dccg35_set_dppclk_rcg(dccg, inst, true);
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		dccg35_set_dppclk_rcg(dccg, inst, true);
 }
 
 static void dccg35_disable_dscclk_new(struct dccg *dccg,
@@ -1301,7 +1299,8 @@ void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 		dcn35_set_dppclk_enable(dccg, dpp_inst, true);
 	} else {
 		dcn35_set_dppclk_enable(dccg, dpp_inst, false);
-		dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
+			dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 	udelay(10);
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
@@ -1868,7 +1867,8 @@ static void dccg35_set_valid_pixel_rate(
 	dccg35_set_dtbclk_dto(dccg, &dto_params);
 }
 
-void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on)
+void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on,
+		bool root_clock_optimization_dpp)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -1890,7 +1890,8 @@ void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, boo
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
 		/*we have this in hwss: disable_plane*/
-		dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
+		if (root_clock_optimization_dpp)
+			dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 
 	// wait for clock to fully ramp
@@ -2505,7 +2506,8 @@ static void dccg35_update_dpp_dto_cb(struct dccg *dccg, int dpp_inst,
 static void dccg35_dpp_root_clock_control_cb(
 	struct dccg *dccg,
 	unsigned int dpp_inst,
-	bool power_on)
+	bool power_on,
+	bool root_clock_optimization_dpp)
 {
 	if (dccg->dpp_clock_gated[dpp_inst] == power_on)
 		return;
@@ -2514,7 +2516,8 @@ static void dccg35_dpp_root_clock_control_cb(
 	 * Since clock source is not passed restore to refclock on ungate
 	 * Redundant as gating when enabled is acheived through update_dpp_dto
 	 */
-	dccg35_set_dppclk_rcg(dccg, dpp_inst, !power_on);
+	if (power_on || root_clock_optimization_dpp)
+		dccg35_set_dppclk_rcg(dccg, dpp_inst, !power_on);
 
 	dccg->dpp_clock_gated[dpp_inst] = !power_on;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index 58f4c1e998b3..7dbb0c90d352 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -260,7 +260,8 @@ void dccg35_set_dpstreamclk_root_clock_gating(struct dccg *dccg, int dp_hpo_inst
 
 void dccg35_set_hdmistreamclk_root_clock_gating(struct dccg *dccg, bool enable);
 
-void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on);
+void dccg35_dpp_root_clock_control(struct dccg *dccg, unsigned int dpp_inst, bool clock_on,
+		bool root_clock_optimization_dpp);
 
 void dccg35_disable_symclk32_se(struct dccg *dccg, int hpo_se_inst);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index cf6fffc2b26e..96c01ddeed61 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -304,7 +304,7 @@ static void dccg42_init(struct dccg *dccg)
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
 		for (i = 0; i < res_pool->pipe_count; i++) {
-			dccg35_dpp_root_clock_control(dccg, i, true);
+			dccg35_dpp_root_clock_control(dccg, i, true, true);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 771555ec1431..c42e493720bc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1059,7 +1059,8 @@ static void power_on_plane_resources(
 {
 	DC_LOGGER_INIT(hws->ctx);
 
-	if (hws->funcs.dpp_root_clock_control)
+	if (hws->funcs.dpp_root_clock_control &&
+	    hwss_is_dpp_root_clock_control_allowed(hws, true))
 		hws->funcs.dpp_root_clock_control(hws, plane_id, true);
 
 	if (REG(DC_IP_REQUEST_CNTL)) {
@@ -1566,7 +1567,8 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 				"Power gated front end %d\n", hubp->inst);
 	}
 
-	if (hws->funcs.dpp_root_clock_control)
+	if (hws->funcs.dpp_root_clock_control &&
+	    hwss_is_dpp_root_clock_control_allowed(hws, false))
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e8b9495c799f..27b886e78998 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1303,7 +1303,8 @@ static void dcn20_power_on_plane_resources(
 
 	DC_LOGGER_INIT(hws->ctx->logger);
 
-	if (hws->funcs.dpp_root_clock_control)
+	if (hws->funcs.dpp_root_clock_control &&
+	    hwss_is_dpp_root_clock_control_allowed(hws, true))
 		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
 
 	if (REG(DC_IP_REQUEST_CNTL)) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 93d8483d6f80..583007c1fee3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -465,14 +465,18 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 	}
 }
 
-void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+bool dcn314_is_dpp_root_clock_control_supported(bool root_clock_optimization_dpp, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
-		return;
+	(void)clock_on;
+	return root_clock_optimization_dpp;
+}
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+{
 	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control)
 		hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control(
-			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
+			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on,
+			hws->ctx->dc->debug.root_clock_optimization.bits.dpp);
 }
 
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index 6c072d0274ea..e33237fb74be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -45,6 +45,8 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
+bool dcn314_is_dpp_root_clock_control_supported(bool root_clock_optimization_dpp, bool clock_on);
+
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
 void dcn314_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 2b04598b0935..69b020e2c4b2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -145,6 +145,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
+	.is_dpp_root_clock_control_supported = dcn314_is_dpp_root_clock_control_supported,
 	.hubp_pg_control = dcn31_hubp_pg_control,
 	.dpp_pg_control = dcn314_dpp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 23c09801f12f..fbf4d0f95c5c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -496,14 +496,17 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	}
 }
 
-void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+bool dcn35_is_dpp_root_clock_control_supported(bool root_clock_optimization_dpp, bool clock_on)
 {
-	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp && !clock_on)
-		return;
+	return root_clock_optimization_dpp || clock_on;
+}
 
+void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+{
 	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control) {
 		hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control(
-			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
+			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on,
+			hws->ctx->dc->debug.root_clock_optimization.bits.dpp);
 	}
 }
 
@@ -1365,7 +1368,8 @@ void dcn35_root_clock_control(struct dc *dc,
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
-				if (dc->hwseq->funcs.dpp_root_clock_control)
+				if (dc->hwseq->funcs.dpp_root_clock_control &&
+				    hwss_is_dpp_root_clock_control_allowed(dc->hwseq, power_on))
 					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
 			}
 			if (update_state->pg_pipe_res_update[PG_DPSTREAM][i])
@@ -1398,7 +1402,8 @@ void dcn35_root_clock_control(struct dc *dc,
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
-				if (dc->hwseq->funcs.dpp_root_clock_control)
+				if (dc->hwseq->funcs.dpp_root_clock_control &&
+				    hwss_is_dpp_root_clock_control_allowed(dc->hwseq, power_on))
 					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
 			}
 			if (update_state->pg_pipe_res_update[PG_DPSTREAM][i])
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 96b836b2ae71..0ae2f44cfb9f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -39,6 +39,8 @@ void dcn35_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool pow
 
 void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
+bool dcn35_is_dpp_root_clock_control_supported(bool root_clock_optimization_dpp, bool clock_on);
+
 void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hpo_inst, bool clock_on);
 
 void dcn35_hdmistream_root_clock_control(struct dce_hwseq *hws, bool clock_on);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index f8c8ab12bdf9..2119a8e000e9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -163,6 +163,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	//.plane_atomic_disable = dcn20_plane_atomic_disable,/*todo*/
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.is_dpp_root_clock_control_supported = dcn35_is_dpp_root_clock_control_supported,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 82a8d87f9428..0e148c6e5c50 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -152,6 +152,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	//.plane_atomic_disable = dcn20_plane_atomic_disable,/*todo*/
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.is_dpp_root_clock_control_supported = dcn35_is_dpp_root_clock_control_supported,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index efff09784f45..d237061236af 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3130,7 +3130,8 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	DC_LOG_DEBUG(
 			"Power gated front end %d\n", hubp->inst);
 
-	if (hws->funcs.dpp_root_clock_control)
+	if (hws->funcs.dpp_root_clock_control &&
+	    hwss_is_dpp_root_clock_control_allowed(hws, false))
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 34bfe62296e6..b1cc09df5e63 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -1117,7 +1117,8 @@ void dcn42_root_clock_control(struct dc *dc,
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
-				if (dc->hwseq->funcs.dpp_root_clock_control)
+				if (dc->hwseq->funcs.dpp_root_clock_control &&
+				    hwss_is_dpp_root_clock_control_allowed(dc->hwseq, power_on))
 					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
 			}
 			if (update_state->pg_pipe_res_update[PG_DPSTREAM][i])
@@ -1150,7 +1151,8 @@ void dcn42_root_clock_control(struct dc *dc,
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
-				if (dc->hwseq->funcs.dpp_root_clock_control)
+				if (dc->hwseq->funcs.dpp_root_clock_control &&
+				    hwss_is_dpp_root_clock_control_allowed(dc->hwseq, power_on))
 					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
 			}
 			if (update_state->pg_pipe_res_update[PG_DPSTREAM][i])
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index 775da50e945e..6711283afcd7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -163,6 +163,7 @@ static const struct hwseq_private_funcs dcn42_private_funcs = {
 	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.program_cm_hist = dcn42_program_cm_hist,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.is_dpp_root_clock_control_supported = dcn35_is_dpp_root_clock_control_supported,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index bd005aaf9317..7e7054608d74 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -705,9 +705,10 @@ struct dpp_reset_params {
 };
 
 struct dpp_root_clock_control_params {
-	struct dce_hwseq *hws;
+	struct dccg *dccg;
 	unsigned int dpp_inst;
 	bool clock_on;
+	bool root_clock_optimization_dpp;
 };
 
 struct dc_ip_request_cntl_params {
@@ -2455,6 +2456,8 @@ void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
 		int dsc_inst,
 		bool *is_ungated);
 
+bool hwss_is_dpp_root_clock_control_allowed(struct dce_hwseq *hws, bool clock_on);
+
 void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
 		unsigned int dpp_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index b2e63363066f..9c5e9abf5a95 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -135,6 +135,9 @@ struct hwseq_private_funcs {
 			struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool clock_on);
+	bool (*is_dpp_root_clock_control_supported)(
+			bool root_clock_optimization_dpp,
+			bool clock_on);
 	void (*dpstream_root_clock_control)(
 			struct dce_hwseq *hws,
 			unsigned int dpp_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 1fe703e866fc..8538b16c9748 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -314,10 +314,8 @@ struct dccg_funcs {
 	void (*trigger_dio_fifo_resync)(
 			struct dccg *dccg);
 
-	void (*dpp_root_clock_control)(
-			struct dccg *dccg,
-			unsigned int dpp_inst,
-			bool clock_on);
+	void (*dpp_root_clock_control)(struct dccg *dccg, unsigned int dpp_inst, bool clock_on,
+			bool root_clock_optimization_dpp);
 
 	void (*enable_symclk_se)(
 			struct dccg *dccg,
-- 
2.43.0

