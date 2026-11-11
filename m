Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F675606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KmjIKN/8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CD310F8C3;
	Wed, 11 Nov 2026 01:41:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A261A10F8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H04Sq+JLXpTbM2pwC1/3A+cXrH97hbCACiukOWp1K91oag4TnYu7uRdlGGuwmSsNWTxNoIF8S+PryAXzFV22pBK+Vf30yn3P/NfC5/pLqyfF8A4682IoL1Bx9PwCu6qnbk2Goh4zoDdrhVg9ERUQTLOiYyBvHa9z6DCDhhdZB+foY7X42ujc+3StAOYtaZCXap0ZSNm7f1d+Ro5b7uYlRwRuB38hu8gozFME/K7QPiM8H5uoQPuNJPeQjklXfmq+07CzQiZfPl46vq9UQey/yYXXUj9agdeID2pSdAypoC5ZwHmE2BJM21PmwdCQbhH8iOrqxgxcMKvi0sjGYwHzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWB3MCbWb/VvfFu2rGu2n5nuZoBh22JARZy4QZibYx4=;
 b=uDJVmkg2Cz3269QbfpNvv2hWntBPl6kpvUAcT3Ytb98UUp4ljbEACHOXLlGNpE1rVTnhtaJb/sfYI4l+n58TIQuBuXbljwSuv2BLtpuTD3h7e1nIp2dvRzWApg9cswD9DoaQkhZgp16lBduA/JwDe4YRhx3wNLZd84/3TuO6q8zU07Gd1OQozizUURVxypa21e+a8+rf7kpw5S2hFg+BYnF2hxCCDq38Uw5yucaFhTjY48IqyY51Oapu7rk22dj8ftKVuImvO1nrwZmN2UB9/JLEg/igz3b6OXgbK/5Hr3w59sBy6xuVM1r63+Mbtve6OUOzmzvc28c9V8aJz3hLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWB3MCbWb/VvfFu2rGu2n5nuZoBh22JARZy4QZibYx4=;
 b=KmjIKN/8OA7foVXU2V9g4bt26dqwBk2kos2crCeg7iKSfMJVGCwzP1Yjj6feEQMro/ojryKcJPXjc3mCuvWTiFxQkOpR2gsvqeqhjvtdx0F5E9F0BJZSQ0zodGREIKt+H6SwcY9qNRyNGq1Dg6SU5XDGmoz9k1LvWeGIozQV/z8=
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:31 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a6) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:24 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:20 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 16/74] drm/amd/display: HWSS Refactor - Watermarks
Date: Wed, 11 Nov 2026 09:28:22 +0800
Message-ID: <20261111014100.3596072-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 097a49d6-7b60-43ab-1260-08df3f94e786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003|10067099003|261009223027099003|261026140227099003|261026121527099003|261009221227099003|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|3023799007|261028144727099003;
X-Microsoft-Antispam-Message-Info: BuyU8FeGphWDjbRYcPLpwEb1F9ZT/YcygA5/hTjsWDFEcttYg2PJMqJJZvZNZbnRv4p8miBTK7FYR5cjM4fRt6CAEjeMdwY3Vsn0pKhBrG8sB+z4cytWTPiZspiaCa7WAvn9Ber2tpVbMhVYvXxWI8bLf7LKcAdPma3wNCoLjR8egOoVHjeaOSDb1/cAOPjyotzhbp1bh4N8TRZvCZ1PGTVLoQEoZwROXuiEB1dTEbKa7n2oz+C0uAhKxV2uQJcAcQZ5denODCcaxrFIhwNViTq9cjQ/vLWv5HzrR8CJ4wHeTB+C1vd2pzCgvGpnq3Je751+9hHfFOfc3DZez1iB5jI85Xa+XK+FI4gHmCIY3XCNX7wKP2KGRR4JFxBjaT00EevRfWTK9QLEA9GyuW5XIR4uDEpuVWNjCjrrHhXVAgeXXZq2I7dZ8MNLvT5BpfaUD8BlbSIHLDUcXFpQMAHZpfcU2+IVansbi/v5UAvnLicosOowXfGPDxmHCcQG0Cd6WlIpmqdVeIzuftxyktuHW1DfGrjWKOgMPSiX+hB9pL8iD5B8fFzHMC7Q1rqFvll9Aw1AywiqeU5RWJzll5U53OxVfWPL8C/1zMLafyJPKUtinJN0McoKNsN/85ok8iwTjcf8y0XiHfnV5WpSd1sXz127E08yL92YnjYannZH8v9ovIakOYENsW4MW8gBkO3f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261026140227099003)(261026121527099003)(261009221227099003)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(3023799007)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zqe7tBa2Y2vD2DRKBYRNjD3s4V7Gz9eizPn+XyxXVfMDbxj0HvyWeasbqByJRknbQVoL33w4t8j3v45JEySpkGs2TllOmrI7IKyU9RTmw00D4caBm5cTpWeU1rucW7eiuz+H0ihkYfKrrmIRDqLcCkcuuLswCP4+gSXklbmCwcaton9O8gzsXGl80QOfXcg6fQhHQupjAZ1ycp8F1bKZgRxWrRqj8OXZkQnojWeMJ4B4YrowaDQBBIDTHkNbkH2MB9BhHsnesh+AdIVfkLsQqOLvMBKWiKPsBaBJe5VUILJpvq1HApz0+zFdsG6/OmKLSXggn29eMByPx7xO42cgGtPmGPktjI8VyxAyWFb1nbn51W9dtBPy1mwzhH2PZYzul3H4SwMCa+ur86KBCAWJTo5FKA7pgYU5IMu4sGUW26Yhy4RWcortCt/jMyFE4P5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:28.0892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a49d6-7b60-43ab-1260-08df3f94e786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
BLS prepare_bandwidth (DPMS on) did not match the legacy path:
- DC_SET_OPTIMIZED_REQUIRED, HUBBUB_PROGRAM_WATERMARKS and
  HUBBUB_PROGRAM_ARBITER steps kept a dc pointer and read dc->debug and
  clk_mgr state at execution, so a step depended on state outside the
  sequence.
- prepare_bandwidth_sequence set dc->optimized_required while building,
  so the flag changed before the sequence ran instead of at its position
  in it.

[How]
Modified opcodes (flat params, no dc pointer):
- DC_SET_OPTIMIZED_REQUIRED: the executor returns the value and the
  dispatcher assigns dc->optimized_required.
- HUBBUB_PROGRAM_WATERMARKS, HUBBUB_PROGRAM_ARBITER: debug policy,
  p-state transition policy and arbiter values are resolved at build
  time. Executors return pending work and the dispatcher ORs it into
  dc->optimized_required when !safe_to_lower.

Interface:
- hubbub_funcs.program_watermarks takes struct hubbub_watermark_policy;
  program_arbiter takes pstate_stall_threshold and
  allow_sdpif_rate_limit_when_cstate_req. All hubbub implementations are
  updated without functional change (on DCN42 pstate_stall_threshold is
  unused because firmware manages the P-state stall threshold).
- hwss_prepare_hubbub_program_{watermarks,arbiter}() fill the step
  parameters. Legacy DCN10/20/401 prepare/optimize_bandwidth use them too,
  so both paths resolve the policy in one place.
- dcn401_prepare_bandwidth_sequence adds DC_SET_OPTIMIZED_REQUIRED steps
  instead of writing dc->optimized_required at build time.

The DCN401 DC2 commit builder fills the watermark and arbiter params with
the same helpers. The DC2 executor passes the policy and flat arbiter
arguments and ORs optimized_required onto dc2.

Notes:
- The watermarks step keeps a pointer to the context watermarks (a copy
  would add ~160 B per step); they must not change between build and
  execution.
- Builders validate their arguments, ASSERT, and add no step on invalid
  input.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/bls_builder/dcn401_commit_builder.c    |  23 ++-
 .../display/dc/bls_executor/bls_executor.c    |  17 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 138 ++++++++++++------
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   6 +-
 .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |   3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |   5 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   5 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  23 ++-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   7 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  12 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |   3 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |  20 +--
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  14 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  43 ++++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  36 +++--
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  22 ++-
 25 files changed, 265 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index 340d1aec2f4c..5fe4a1ec7166 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -871,23 +871,18 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 				&p->clk_mgr_update_clocks_for_state_params);
 		break;
 	case HUBBUB_PROGRAM_WATERMARKS:
-		p->hubbub_program_watermarks_params.dc = dc;
-		p->hubbub_program_watermarks_params.hubbub =
-				dc->res_pool->hubbub;
-		p->hubbub_program_watermarks_params.watermarks =
-				&bw->watermarks;
-		p->hubbub_program_watermarks_params.refclk_mhz =
+		p->hubbub_program_watermarks_params =
+				hwss_prepare_hubbub_program_watermarks(dc,
+				dc->res_pool->hubbub, &bw->watermarks,
 				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz /
-				1000;
-		p->hubbub_program_watermarks_params.safe_to_lower =
-				m->hubbub_program_watermarks.safe_to_lower;
+				1000,
+				m->hubbub_program_watermarks.safe_to_lower);
 		break;
 	case HUBBUB_PROGRAM_ARBITER:
-		p->hubbub_program_arbiter_params.dc = dc;
-		p->hubbub_program_arbiter_params.hubbub = dc->res_pool->hubbub;
-		p->hubbub_program_arbiter_params.arb_regs = &bw->arb_regs;
-		p->hubbub_program_arbiter_params.safe_to_lower =
-				m->hubbub_program_arbiter.safe_to_lower;
+		p->hubbub_program_arbiter_params =
+				hwss_prepare_hubbub_program_arbiter(
+				dc->res_pool->hubbub, &bw->arb_regs,
+				m->hubbub_program_arbiter.safe_to_lower);
 		break;
 	case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
 		p->hubbub_program_compbuf_segments_params.hubbub =
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 5111c65fd961..3a80c9261710 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -311,8 +311,7 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 	case HUBBUB_PROGRAM_ARBITER:
 		hubbub = step->params.hubbub_program_arbiter_params.hubbub;
 		return hubbub && hubbub->funcs &&
-				hubbub->funcs->program_arbiter &&
-				step->params.hubbub_program_arbiter_params.arb_regs;
+				hubbub->funcs->program_arbiter;
 	case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
 		hubbub = step->params.hubbub_program_compbuf_segments_params
 				.hubbub;
@@ -939,20 +938,22 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					&entry->params.hubbub_program_watermarks_params;
 			bool changed = p->hubbub->funcs->program_watermarks(
 					p->hubbub, p->watermarks, p->refclk_mhz,
-					p->safe_to_lower);
+					p->policy, p->safe_to_lower);
 
-			if (p->dc && !p->safe_to_lower)
-				p->dc->optimized_required |= changed;
+			if (dc2 && !p->safe_to_lower)
+				dc2->dc.optimized_required |= changed;
 			break;
 		}
 		case HUBBUB_PROGRAM_ARBITER: {
 			const struct hubbub_program_arbiter_params *p =
 					&entry->params.hubbub_program_arbiter_params;
 			bool changed = p->hubbub->funcs->program_arbiter(p->hubbub,
-					p->arb_regs, p->safe_to_lower);
+					p->pstate_stall_threshold,
+					p->allow_sdpif_rate_limit_when_cstate_req,
+					p->safe_to_lower);
 
-			if (p->dc && !p->safe_to_lower)
-				p->dc->optimized_required |= changed;
+			if (dc2 && !p->safe_to_lower)
+				dc2->dc.optimized_required |= changed;
 			break;
 		}
 		case HUBBUB_PROGRAM_COMPBUF_SEGMENTS: {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6b90c88b6cc3..9d871a821c8d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4412,7 +4412,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 					if (dpms_pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
 						hwss_add_disable_audio_stream(&seq_state, dpms_pipe_ctx);
 
-					hwss_add_dc_set_optimized_required(&seq_state, dc, true);
+					hwss_add_dc_set_optimized_required(&seq_state, true);
 
 				} else {
 					if (get_seamless_boot_stream_count(context) == 0 && dc->hwss.prepare_bandwidth_sequence)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 512e128d52b3..2384cbf16ee1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1913,7 +1913,7 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_mpc_remove_mpcc(params);
 			break;
 		case DC_SET_OPTIMIZED_REQUIRED:
-			hwss_dc_set_optimized_required(params);
+			dc->optimized_required = hwss_dc_set_optimized_required(params);
 			break;
 		case HUBP_DISCONNECT:
 			hwss_hubp_disconnect(params);
@@ -2217,10 +2217,10 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_clk_mgr_update_clocks(params);
 			break;
 		case HUBBUB_PROGRAM_WATERMARKS:
-			hwss_hubbub_program_watermarks(params);
+			dc->optimized_required |= hwss_hubbub_program_watermarks(params);
 			break;
 		case HUBBUB_PROGRAM_ARBITER:
-			hwss_hubbub_program_arbiter(params);
+			dc->optimized_required |= hwss_hubbub_program_arbiter(params);
 			break;
 		case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
 			hwss_hubbub_program_compbuf_segments(params);
@@ -3593,12 +3593,12 @@ void hwss_mpc_remove_mpcc(union block_sequence_params *params)
 	mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_remove);
 }
 
-void hwss_dc_set_optimized_required(union block_sequence_params *params)
+bool hwss_dc_set_optimized_required(union block_sequence_params *params)
 {
-	struct dc *dc = params->dc_set_optimized_required_params.dc;
-	bool optimized_required = params->dc_set_optimized_required_params.optimized_required;
+	if (!params)
+		return false;
 
-	dc->optimized_required = optimized_required;
+	return params->dc_set_optimized_required_params.optimized_required;
 }
 
 void hwss_hubp_disconnect(union block_sequence_params *params)
@@ -4655,35 +4655,41 @@ void hwss_clk_mgr_update_clocks(union block_sequence_params *params)
 /*
  * Hubbub executor functions
  */
-void hwss_hubbub_program_watermarks(union block_sequence_params *params)
+bool hwss_hubbub_program_watermarks(union block_sequence_params *params)
 {
-	struct dc *dc = params->hubbub_program_watermarks_params.dc;
-	struct hubbub *hubbub = params->hubbub_program_watermarks_params.hubbub;
-	union dcn_watermark_set *watermarks = params->hubbub_program_watermarks_params.watermarks;
-	unsigned int refclk_mhz = params->hubbub_program_watermarks_params.refclk_mhz;
-	bool safe_to_lower = params->hubbub_program_watermarks_params.safe_to_lower;
+	struct hubbub_program_watermarks_params *wm;
+	bool pending;
 
-	if (hubbub && hubbub->funcs && hubbub->funcs->program_watermarks) {
-		bool wm_changed = hubbub->funcs->program_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (!params)
+		return false;
 
-		if (dc && !safe_to_lower)
-			dc->optimized_required |= wm_changed;
-	}
+	wm = &params->hubbub_program_watermarks_params;
+	if (!wm->hubbub || !wm->hubbub->funcs || !wm->hubbub->funcs->program_watermarks ||
+			!wm->watermarks)
+		return false;
+
+	pending = wm->hubbub->funcs->program_watermarks(wm->hubbub, wm->watermarks,
+		wm->refclk_mhz, wm->policy, wm->safe_to_lower);
+
+	return !wm->safe_to_lower && pending;
 }
 
-void hwss_hubbub_program_arbiter(union block_sequence_params *params)
+bool hwss_hubbub_program_arbiter(union block_sequence_params *params)
 {
-	struct dc *dc = params->hubbub_program_arbiter_params.dc;
-	struct hubbub *hubbub = params->hubbub_program_arbiter_params.hubbub;
-	struct dml2_display_arb_regs *arb_regs = params->hubbub_program_arbiter_params.arb_regs;
-	bool safe_to_lower = params->hubbub_program_arbiter_params.safe_to_lower;
+	struct hubbub_program_arbiter_params *arb;
+	bool pending;
 
-	if (hubbub && hubbub->funcs && hubbub->funcs->program_arbiter) {
-		bool arb_changed = hubbub->funcs->program_arbiter(hubbub, arb_regs, safe_to_lower);
+	if (!params)
+		return false;
 
-		if (dc && !safe_to_lower)
-			dc->optimized_required |= arb_changed;
-	}
+	arb = &params->hubbub_program_arbiter_params;
+	if (!arb->hubbub || !arb->hubbub->funcs || !arb->hubbub->funcs->program_arbiter)
+		return false;
+
+	pending = arb->hubbub->funcs->program_arbiter(arb->hubbub, arb->pstate_stall_threshold,
+		arb->allow_sdpif_rate_limit_when_cstate_req, arb->safe_to_lower);
+
+	return !arb->safe_to_lower && pending;
 }
 
 void hwss_hubbub_program_compbuf_segments(union block_sequence_params *params)
@@ -4837,11 +4843,15 @@ void hwss_add_dsc_disconnect(struct block_sequence_state *seq_state,
 }
 
 void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
-		struct dc *dc, bool optimized_required)
+		bool optimized_required)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps) {
+		ASSERT(false);
+		return;
+	}
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DC_SET_OPTIMIZED_REQUIRED;
-		seq_state->steps[*seq_state->num_steps].params.dc_set_optimized_required_params.dc = dc;
 		seq_state->steps[*seq_state->num_steps].params.dc_set_optimized_required_params.optimized_required = optimized_required;
 		(*seq_state->num_steps)++;
 	}
@@ -6421,20 +6431,45 @@ void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
 /*
  * Hubbub helper functions
  */
+struct hubbub_program_watermarks_params hwss_prepare_hubbub_program_watermarks(
+		const struct dc *dc,
+		struct hubbub *hubbub,
+		union dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower)
+{
+	struct hubbub_program_watermarks_params prepared = {};
+
+	prepared.hubbub = hubbub;
+	prepared.watermarks = watermarks;
+	prepared.refclk_mhz = refclk_mhz;
+	prepared.policy.urgent_watermark_override = dc->debug.urgent_watermark_override;
+	prepared.policy.disable_stutter = dc->debug.disable_stutter;
+	prepared.policy.disable_stutter_for_program = dc->debug.disable_stutter_for_wm_program;
+	prepared.policy.force_usr_allow = dc->debug.force_usr_allow;
+	prepared.safe_to_lower = safe_to_lower;
+
+	return prepared;
+}
+
 void hwss_add_hubbub_program_watermarks(struct block_sequence_state *seq_state,
-		struct dc *dc,
+		const struct dc *dc,
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !dc || !watermarks ||
+			!hubbub || !hubbub->funcs || !hubbub->funcs->program_watermarks) {
+		ASSERT(false);
+		return;
+	}
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PROGRAM_WATERMARKS;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params.hubbub = hubbub;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params.watermarks = watermarks;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params.refclk_mhz = refclk_mhz;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params.safe_to_lower = safe_to_lower;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_program_watermarks_params =
+			hwss_prepare_hubbub_program_watermarks(dc, hubbub, watermarks,
+					refclk_mhz, safe_to_lower);
 		(*seq_state->num_steps)++;
 	}
 }
@@ -6451,18 +6486,37 @@ void hwss_add_dp_trace_source_sequence(struct block_sequence_state *seq_state,
 	}
 }
 
+struct hubbub_program_arbiter_params hwss_prepare_hubbub_program_arbiter(
+		struct hubbub *hubbub,
+		const struct dml2_display_arb_regs *arb_regs,
+		bool safe_to_lower)
+{
+	struct hubbub_program_arbiter_params prepared = {};
+
+	prepared.hubbub = hubbub;
+	prepared.pstate_stall_threshold = arb_regs->pstate_stall_threshold;
+	prepared.allow_sdpif_rate_limit_when_cstate_req =
+			arb_regs->allow_sdpif_rate_limit_when_cstate_req != 0;
+	prepared.safe_to_lower = safe_to_lower;
+
+	return prepared;
+}
+
 void hwss_add_hubbub_program_arbiter(struct block_sequence_state *seq_state,
-		struct dc *dc,
 		struct hubbub *hubbub,
-		struct dml2_display_arb_regs *arb_regs,
+		const struct dml2_display_arb_regs *arb_regs,
 		bool safe_to_lower)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !arb_regs ||
+			!hubbub || !hubbub->funcs || !hubbub->funcs->program_arbiter) {
+		ASSERT(false);
+		return;
+	}
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PROGRAM_ARBITER;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_arbiter_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_arbiter_params.hubbub = hubbub;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_arbiter_params.arb_regs = arb_regs;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_program_arbiter_params.safe_to_lower = safe_to_lower;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_program_arbiter_params =
+			hwss_prepare_hubbub_program_arbiter(hubbub, arb_regs, safe_to_lower);
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index 4e33648f74bb..faad1c6f4509 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -584,6 +584,7 @@ bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
@@ -606,7 +607,7 @@ bool hubbub1_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 68);
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
 #if 0
 	REG_UPDATE_2(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 53fac324748d..581e2c1578b5 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -606,6 +606,7 @@ bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower);
 
 void hubbub1_allow_self_refresh_control(struct hubbub *hubbub, bool allow);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index e5b55fe502ca..46e43a51ab22 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -592,6 +592,7 @@ static bool hubbub2_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
@@ -611,8 +612,7 @@ static bool hubbub2_program_watermarks(
 	 * here we are going to LOWER watermarks to go to dummy p-state only, but this has
 	 * to be done prepare_bandwidth, not optimize
 	 */
-	if (hubbub1->base.ctx->dc->clk_mgr->clks.prev_p_state_change_support == true &&
-		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
+	if (policy.force_safe_to_lower)
 		safe_to_lower = true;
 
 	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
@@ -622,7 +622,7 @@ static bool hubbub2_program_watermarks(
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 180);
 
-	hubbub->funcs->allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub->funcs->allow_self_refresh_control(hubbub, !policy.disable_stutter);
 	return wm_pending;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
index e6b527cd2047..d626c1de92a7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
@@ -54,6 +54,7 @@ static bool hubbub201_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
@@ -70,7 +71,7 @@ static bool hubbub201_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 68);
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
index 881e91e9385d..3a92682c9cda 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
@@ -575,6 +575,7 @@ bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
@@ -610,7 +611,7 @@ bool hubbub21_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL,
 			DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h
index ab2ce0313529..626c864f9535 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h
@@ -129,6 +129,7 @@ bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower);
 bool hubbub21_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index 582d647da812..71f45e07c10e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -97,6 +97,7 @@ bool hubbub3_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
@@ -129,8 +130,8 @@ bool hubbub3_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || policy.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
index 9e14de3ccaee..321024242412 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
@@ -126,6 +126,7 @@ bool hubbub3_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower);
 
 void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 786843362061..2af656c2c529 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -719,6 +719,7 @@ static bool hubbub31_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	bool wm_pending = false;
@@ -750,8 +751,8 @@ static bool hubbub31_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || policy.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 	return wm_pending;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index dd9bc1f08b56..ee01d52e6944 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -761,14 +761,16 @@ static bool hubbub32_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
-	struct dc *dc = hubbub->ctx->dc;
+	const uint32_t hw_internal_rev = hubbub->ctx->asic_id.hw_internal_rev;
+	const bool sdp_control_wa = policy.disable_stutter_for_program &&
+			(ASICREV_IS_GC_11_0_0(hw_internal_rev) ||
+			ASICREV_IS_GC_11_0_3(hw_internal_rev));
 	bool wm_pending = false;
 
-	if (!safe_to_lower && dc->debug.disable_stutter_for_wm_program &&
-			(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
-			ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+	if (!safe_to_lower && sdp_control_wa) {
 		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
 		wm_pending = true;
 		hubbub32_set_sdp_control(hubbub, false);
@@ -807,18 +809,15 @@ static bool hubbub32_program_watermarks(
 
 	if (safe_to_lower) {
 		/* after lowering watermarks, stutter setting is restored, SDP control given to DC */
-		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+		hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
-		if (dc->debug.disable_stutter_for_wm_program &&
-				(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
-				ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+		if (sdp_control_wa)
 			hubbub32_set_sdp_control(hubbub, true);
-		}
-	} else if (dc->debug.disable_stutter) {
-		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+	} else if (policy.disable_stutter) {
+		hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 	}
 
-	hubbub32_force_usr_retraining_allow(hubbub, dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, policy.force_usr_allow);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index ad333cd3241b..771e209a0b3f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -301,6 +301,7 @@ bool hubbub35_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	bool wm_pending = false;
@@ -328,10 +329,10 @@ bool hubbub35_program_watermarks(
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, 0xA);/*hw delta*/
 	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || policy.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, policy.force_usr_allow);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index ddc614c98234..831b9888c831 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -365,6 +365,7 @@ bool hubbub35_program_watermarks(
 	struct hubbub *hubbub,
 	union dcn_watermark_set *watermarks,
 	unsigned int refclk_mhz,
+	struct hubbub_watermark_policy policy,
 	bool safe_to_lower);
 void hubbub35_init_watermarks(struct hubbub *hubbub);
 void dcn35_program_compbuf_size(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 957e8f5a6475..c18457c779de 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -455,6 +455,7 @@ static bool hubbub401_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	bool wm_pending = false;
@@ -490,9 +491,9 @@ static bool hubbub401_program_watermarks(
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);
 	*/
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, policy.force_usr_allow);
 
 	return wm_pending;
 }
@@ -1194,19 +1195,20 @@ void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 	}
 }
 
-bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower)
+bool dcn401_program_arbiter(struct hubbub *hubbub, uint32_t pstate_stall_threshold,
+		bool allow_sdpif_rate_limit_when_cstate_req, bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
 	bool wm_pending = false;
 	uint32_t temp;
-	bool allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req != 0;
 
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
 
 	/* P-State stall threshold */
-	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
+	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2,
+			DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, pstate_stall_threshold);
 
 	if (safe_to_lower || allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
 		hubbub2->allow_sdpif_rate_limit_when_cstate_req = allow_sdpif_rate_limit_when_cstate_req;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index 346bead81504..2694b9769bb4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -198,7 +198,8 @@ bool hubbub401_get_dcc_compression_cap(
 
 bool dcn401_program_arbiter(
 	struct hubbub *hubbub,
-	struct dml2_display_arb_regs *arb_regs,
+	uint32_t pstate_stall_threshold,
+	bool allow_sdpif_rate_limit_when_cstate_req,
 	bool safe_to_lower);
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 244f3f2824ed..b8ebe44c69c6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -27,10 +27,10 @@
 static bool hubbub42_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
+		uint32_t urgent_floor,
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
-	const unsigned int urgent_floor = hubbub->ctx->dc->debug.urgent_watermark_override;
 	const unsigned int urgent_a = max(urgent_floor,
 		watermarks->dcn4x.a.urgent);
 	const unsigned int urgent_b = max(urgent_floor,
@@ -445,17 +445,19 @@ static bool hubbub42_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	bool wm_pending = false;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
-	if (!safe_to_lower && hubbub->ctx->dc->debug.disable_stutter_for_wm_program) {
+	if (!safe_to_lower && policy.disable_stutter_for_program) {
 		/* before raising watermarks, stutter must be disabled */
 		wm_pending = true;
 		hubbub42_allow_self_refresh_control(hubbub, false);
 	}
-	if (hubbub42_program_urgent_watermarks(hubbub, watermarks, safe_to_lower))
+	if (hubbub42_program_urgent_watermarks(hubbub, watermarks,
+			policy.urgent_watermark_override, safe_to_lower))
 		wm_pending = true;
 
 	if (hubbub42_program_stutter_watermarks(hubbub, watermarks, safe_to_lower))
@@ -477,9 +479,9 @@ static bool hubbub42_program_watermarks(
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, 0xA);/*hw delta*/
 	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub42_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	if (safe_to_lower || policy.disable_stutter)
+		hubbub42_allow_self_refresh_control(hubbub, !policy.disable_stutter);
+	hubbub32_force_usr_retraining_allow(hubbub, policy.force_usr_allow);
 
 	return wm_pending;
 }
@@ -494,14 +496,14 @@ static void hubbub42_set_request_limit(struct hubbub *hubbub, int memory_channel
 	REG_UPDATE(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, request_limit);
 }
 
-static bool dcn42_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs,
-				  bool safe_to_lower)
+static bool dcn42_program_arbiter(struct hubbub *hubbub, uint32_t pstate_stall_threshold,
+		bool allow_sdpif_rate_limit_when_cstate_req, bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
 	bool wm_pending = false;
 	uint32_t temp;
-	bool allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req != 0;
+	(void)pstate_stall_threshold;
 
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 07282b78972a..db29e56f2367 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -606,6 +606,7 @@ static bool hubbub60_program_watermarks(
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
+		struct hubbub_watermark_policy policy,
 		bool safe_to_lower)
 {
 	bool wm_pending = false;
@@ -619,7 +620,7 @@ static bool hubbub60_program_watermarks(
 	if (hubbub60_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
 		wm_pending = true;
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	hubbub1_allow_self_refresh_control(hubbub, !policy.disable_stutter);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index f1d14b97977f..46a134301526 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3420,6 +3420,7 @@ void dcn10_prepare_bandwidth(
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	struct hubbub_program_watermarks_params wm;
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 
 	if (dc->debug.sanity_checks)
@@ -3433,10 +3434,10 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub, &context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, true);
 	dc->optimized_required = hubbub->funcs->program_watermarks(hubbub,
-			&context->bw_ctx.bw.dcn.watermarks,
-			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-			true);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
 	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE) {
@@ -3458,6 +3459,7 @@ void dcn10_optimize_bandwidth(
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	struct hubbub_program_watermarks_params wm;
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 
 	if (dc->debug.sanity_checks)
@@ -3471,10 +3473,10 @@ void dcn10_optimize_bandwidth(
 			context,
 			true);
 
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub, &context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, true);
 	hubbub->funcs->program_watermarks(hubbub,
-			&context->bw_ctx.bw.dcn.watermarks,
-			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-			true);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 636cbd947918..696c0d5b8132 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2438,6 +2438,7 @@ void dcn20_prepare_bandwidth(
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	unsigned int compbuf_size_kb = 0;
 	unsigned int cache_wm_a = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns;
+	struct hubbub_program_watermarks_params wm;
 	unsigned int i;
 
 	dc->clk_mgr->funcs->update_clocks(
@@ -2459,10 +2460,13 @@ void dcn20_prepare_bandwidth(
 	 * For assigning optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub, &context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, false);
+	/* Read after update_clocks(): P-state support is being lost, lower to dummy P-state now */
+	wm.policy.force_safe_to_lower = dc->clk_mgr->clks.prev_p_state_change_support &&
+			!dc->clk_mgr->clks.p_state_change_support;
 	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
-					&context->bw_ctx.bw.dcn.watermarks,
-					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-					false);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 
 	// Restore the real watermark so we can commit the value to DMCUB
 	// DMCUB uses the "original" watermark value in SubVP MCLK switch
@@ -2487,6 +2491,7 @@ void dcn20_optimize_bandwidth(
 		struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	struct hubbub_program_watermarks_params wm;
 	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -2500,10 +2505,10 @@ void dcn20_optimize_bandwidth(
 	}
 
 	/* program dchubbub watermarks */
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub, &context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, true);
 	hubbub->funcs->program_watermarks(hubbub,
-					&context->bw_ctx.bw.dcn.watermarks,
-					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-					true);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled) {
 		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 508749496826..f14cba867111 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1421,6 +1421,8 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 	unsigned int compbuf_size = 0;
+	struct hubbub_program_watermarks_params wm;
+	struct hubbub_program_arbiter_params arb;
 
 	/* Any transition into P-State support should disable MCLK switching first to avoid hangs */
 	if (p_state_change_support) {
@@ -1446,19 +1448,25 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 	 * For assigning optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub,
+			&context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, false);
 	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
-					&context->bw_ctx.bw.dcn.watermarks,
-					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-					false);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 	/* update timeout thresholds */
 	if (hubbub->funcs->program_arbiter) {
-		dc->optimized_required |= hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, false);
+		arb = hwss_prepare_hubbub_program_arbiter(hubbub,
+				&context->bw_ctx.bw.dcn.arb_regs, false);
+		dc->optimized_required |= hubbub->funcs->program_arbiter(hubbub,
+				arb.pstate_stall_threshold,
+				arb.allow_sdpif_rate_limit_when_cstate_req, arb.safe_to_lower);
 	}
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_segments) {
 		compbuf_size = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
-		dc->optimized_required |= (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
+		dc->optimized_required |= (compbuf_size !=
+				dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
 
 		hubbub->funcs->program_compbuf_segments(hubbub, compbuf_size, false);
 	}
@@ -1489,7 +1497,7 @@ void dcn401_prepare_bandwidth_sequence(struct dc *dc,
 
 	/* Any transition into P-State support should disable MCLK switching first to avoid hangs */
 	if (p_state_change_support) {
-		dc->optimized_required = true;
+		hwss_add_dc_set_optimized_required(seq_state, true);
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
 
@@ -1510,12 +1518,13 @@ void dcn401_prepare_bandwidth_sequence(struct dc *dc,
 					false);
 
 	if (hubbub->funcs->program_arbiter)
-		hwss_add_hubbub_program_arbiter(seq_state, dc, hubbub,
+		hwss_add_hubbub_program_arbiter(seq_state, hubbub,
 				&context->bw_ctx.bw.dcn.arb_regs, false);
 
 	if (hubbub->funcs->program_compbuf_segments) {
 		compbuf_size = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
-		dc->optimized_required |= (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
+		if (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size)
+			hwss_add_dc_set_optimized_required(seq_state, true);
 
 		hwss_add_hubbub_program_compbuf_segments(seq_state, hubbub, compbuf_size, false);
 	}
@@ -1536,6 +1545,8 @@ void dcn401_optimize_bandwidth(
 {
 	unsigned int i;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	struct hubbub_program_watermarks_params wm;
+	struct hubbub_program_arbiter_params arb;
 
 	/* enable fams2 if needed */
 	if (dc->debug.fams2_config.bits.enable) {
@@ -1548,13 +1559,17 @@ void dcn401_optimize_bandwidth(
 	}
 
 	/* program dchubbub watermarks */
+	wm = hwss_prepare_hubbub_program_watermarks(dc, hubbub,
+			&context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000, true);
 	hubbub->funcs->program_watermarks(hubbub,
-					&context->bw_ctx.bw.dcn.watermarks,
-					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-					true);
+			wm.watermarks, wm.refclk_mhz, wm.policy, wm.safe_to_lower);
 	/* update timeout thresholds */
 	if (hubbub->funcs->program_arbiter) {
-		hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, true);
+		arb = hwss_prepare_hubbub_program_arbiter(hubbub,
+				&context->bw_ctx.bw.dcn.arb_regs, true);
+		hubbub->funcs->program_arbiter(hubbub, arb.pstate_stall_threshold,
+				arb.allow_sdpif_rate_limit_when_cstate_req, arb.safe_to_lower);
 	}
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled) {
@@ -1611,7 +1626,7 @@ void dcn401_optimize_bandwidth_sequence(struct dc *dc,
 					true);
 
 	if (hubbub->funcs->program_arbiter)
-		hwss_add_hubbub_program_arbiter(seq_state, dc, hubbub,
+		hwss_add_hubbub_program_arbiter(seq_state, hubbub,
 				&context->bw_ctx.bw.dcn.arb_regs, true);
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
@@ -3300,7 +3315,7 @@ void dcn401_plane_atomic_disconnect_sequence(struct dc *dc,
 	}
 
 	/* Step 3: Set optimized required flag */
-	hwss_add_dc_set_optimized_required(seq_state, dc, true);
+	hwss_add_dc_set_optimized_required(seq_state, true);
 
 	/* Step 4: Disconnect HUBP if function exists */
 	if (hubp->funcs->hubp_disconnect)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 3042785cb8fc..d02834639ab3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -732,7 +732,6 @@ struct mpc_remove_mpcc_params {
 };
 
 struct dc_set_optimized_required_params {
-	struct dc *dc;
 	bool optimized_required;
 };
 
@@ -1264,17 +1263,21 @@ struct dccg_initialize_clocks_params {
 };
 
 struct hubbub_program_watermarks_params {
-	struct dc *dc;
 	struct hubbub *hubbub;
+	/* Workaround: watermarks by value would add ~160 B to every step (~158 KiB per dc_state).
+	 * TODO: pass by value once block_sequence storage moves from dc_state to dc-owned scratch.
+	 * The pointed-to watermarks must not change between build and execution.
+	 */
 	union dcn_watermark_set *watermarks;
 	unsigned int refclk_mhz;
+	struct hubbub_watermark_policy policy;
 	bool safe_to_lower;
 };
 
 struct hubbub_program_arbiter_params {
-	struct dc *dc;
 	struct hubbub *hubbub;
-	struct dml2_display_arb_regs *arb_regs;
+	uint32_t pstate_stall_threshold;
+	bool allow_sdpif_rate_limit_when_cstate_req;
 	bool safe_to_lower;
 };
 
@@ -2345,7 +2348,7 @@ void hwss_set_abm_immediate_disable(union block_sequence_params *params);
 
 void hwss_mpc_remove_mpcc(union block_sequence_params *params);
 
-void hwss_dc_set_optimized_required(union block_sequence_params *params);
+bool hwss_dc_set_optimized_required(union block_sequence_params *params);
 
 void hwss_hubp_disconnect(union block_sequence_params *params);
 
@@ -2664,7 +2667,7 @@ void hwss_add_dsc_disconnect(struct block_sequence_state *seq_state,
 		struct display_stream_compressor *dsc);
 
 void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
-		struct dc *dc, bool optimized_required);
+		bool optimized_required);
 
 void hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx);
@@ -3139,9 +3142,9 @@ void hwss_add_link_set_dpms_on(struct block_sequence_state *seq_state,
 void hwss_clk_mgr_set_max_memclk(union block_sequence_params *params);
 void hwss_clk_mgr_update_clocks(union block_sequence_params *params);
 
-void hwss_hubbub_program_watermarks(union block_sequence_params *params);
+bool hwss_hubbub_program_watermarks(union block_sequence_params *params);
 
-void hwss_hubbub_program_arbiter(union block_sequence_params *params);
+bool hwss_hubbub_program_arbiter(union block_sequence_params *params);
 
 void hwss_hubbub_program_compbuf_segments(union block_sequence_params *params);
 
@@ -3153,17 +3156,28 @@ void hwss_add_clk_mgr_set_max_memclk(struct block_sequence_state *seq_state,
 void hwss_add_clk_mgr_update_clocks(struct block_sequence_state *seq_state,
 		struct clk_mgr *clk_mgr);
 
+struct hubbub_program_watermarks_params hwss_prepare_hubbub_program_watermarks(
+		const struct dc *dc,
+		struct hubbub *hubbub,
+		union dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
 void hwss_add_hubbub_program_watermarks(struct block_sequence_state *seq_state,
-		struct dc *dc,
+		const struct dc *dc,
 		struct hubbub *hubbub,
 		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
+struct hubbub_program_arbiter_params hwss_prepare_hubbub_program_arbiter(
+		struct hubbub *hubbub,
+		const struct dml2_display_arb_regs *arb_regs,
+		bool safe_to_lower);
+
 void hwss_add_hubbub_program_arbiter(struct block_sequence_state *seq_state,
-		struct dc *dc,
 		struct hubbub *hubbub,
-		struct dml2_display_arb_regs *arb_regs,
+		const struct dml2_display_arb_regs *arb_regs,
 		bool safe_to_lower);
 
 void hwss_add_hubbub_program_compbuf_segments(struct block_sequence_state *seq_state,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index b33273b61abd..7280f57f75bf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -35,6 +35,24 @@
 
 #include "dc/dc_hw_types.h"
 
+/*
+ * Watermark programming policy resolved by the caller from dc state, clock manager
+ * state and debug options. Backends must not read mutable dc state (debug options,
+ * clock manager state); static ASIC identification from ctx is allowed.
+ */
+ struct hubbub_watermark_policy {
+	uint32_t urgent_watermark_override;
+	bool disable_stutter;
+	bool disable_stutter_for_program;
+	bool force_usr_allow;
+	/*
+	 * P-state support is being lost, lower watermarks to dummy P-state in prepare.
+	 * Not set by hwss_prepare_hubbub_program_watermarks(); set by the immediate prepare
+	 * path after clk_mgr->funcs->update_clocks(). Consumed by hubbub2 only.
+	 */
+	bool force_safe_to_lower;
+};
+
 enum dcc_control {
 	dcc_control__256_256_xxx,
 	dcc_control__128_128_xxx,
@@ -207,6 +225,7 @@ struct hubbub_funcs {
 			struct hubbub *hubbub,
 			union dcn_watermark_set *watermarks,
 			unsigned int refclk_mhz,
+			struct hubbub_watermark_policy policy,
 			bool safe_to_lower);
 
 	bool (*is_allow_self_refresh_enabled)(struct hubbub *hubbub);
@@ -255,7 +274,8 @@ struct hubbub_funcs {
 	void (*program_det_segments)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
-	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
+	bool (*program_arbiter)(struct hubbub *hubbub, uint32_t pstate_stall_threshold,
+			bool allow_sdpif_rate_limit_when_cstate_req, bool safe_to_lower);
 	void (*dchvm_init)(struct hubbub *hubbub);
 	void (*override_utm_client_qc_profile)(struct hubbub *hubbub, uint8_t qc_profile, int index);
 
-- 
2.43.0

