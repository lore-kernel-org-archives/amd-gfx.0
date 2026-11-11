Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC940606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zfQdSRrG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3057C10F8D9;
	Wed, 11 Nov 2026 01:43:07 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2018F10F8D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr/ZVC7/yYHqO5C9+60PoX7eadEoL/dZXek+A5lUPskE7R1xT+c+IOsnaOqZjJTAZhFRP3dM0EmUGT3bk8v5tv9FkhciEvdaS20DkyWho8WXi2UGKrKac6dOQQVgaCUfRalqMU15hIZJFb5rkmk2x8aZTNuO2tjYpDN5chQgFFwDsOkd9OLSsDixepJSiooLAVltA/d+FtxzQCVfAZTuCKCy8ITUCorZBX4KZFO1s3ejvF1eHMtjyxHVCtX5VRfN+V7BPZPjqDrPABszOFHGil9dpU5Lgesx0h4p6J7V0Z+q56ucMYMp3AvVXvDf+C4Lr0LIqlVUIaNL7leHFd3h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swWuZmertMreouIXm7ZfFA82ax1clF3E0waSYPkwhGo=;
 b=tqf1l918Y7gPtmzU7+BMtQlQ/sLMwVVL+DRlgc6PMkcoGjbeR1a6MyN888Dzt6W+8YcALL+6fQs30Pc4nfByrsce58oISfUBe3M5UhDV1jv4mqN6DahZ/DP/Yv5RgsTmPU+sYYA56TlM98DUHEHB5afOuTxRKcW6W3h8Sk7aAeSBEH0BW7Yvwh27QsVrcBE45WpKG6O6oPYloP3ECiR9kFCU4s7riijrrPKVvQFJVQdurrURrKYdz3Dbb0x5QkrXzQpqlVX5tWuKPVpUds8teX+mBWALuN7/Gm/goL1XpIOOBzbmzuI0mcbu7XasCNEkd98zYMRt0nszBOXDXgyx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swWuZmertMreouIXm7ZfFA82ax1clF3E0waSYPkwhGo=;
 b=zfQdSRrGDEyHiFU9A25lEZXsGAshYG0wQtH0bd0KZV0tAvwONIKqjnMst33lUTwMwUYDOxZGwNWbRPJkyTVqxsxIIuOIUyimOKjalB1+VAzdFH+PlPmZ3S07dMlhUIYo1bb3jE1cg9LBxYXQZdb3RDjMyzg+sNjI1avqK+yH4os=
Received: from CH0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:610:77::10)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:54 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::4e) by CH0PR04CA0035.outlook.office365.com
 (2603:10b6:610:77::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:53 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:53 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:49 -0600
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
Subject: [PATCH 38/74] drm/amd/display: Fix DSC teardown gating in post-unlock
 BLS sequence
Date: Wed, 11 Nov 2026 09:28:44 +0800
Message-ID: <20261111014100.3596072-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 92378352-e807-4ebd-cf7f-08df3f951a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: AkdkBDeClpYwlpz73+d72csQhc1/F2ujMCntSHFJZ6luXQppqb+SjnG0zguUeGrUFPfcHtFaTKXFGuthsX0I1S7n9n8qxVlMkDkcjFaLVVz31R80ejn1ZiX2vDO7P7ue2j2klWAW+UpDTB84j0Bpi4dmQMcXllDDR6qEQX2ppvQH+h7/KCWNgjGbMBrR7Szk0xvY2cEhgqdOwjUXZwkT9w1YYwXH5BYEXTdjuxjxfPeHEIRKo/bCpHEb+KRSaTIi0eWhiPxipwKwZUIULao9sVWUcUqdZ7/MQjntDQDfugBOM/lB6htVxrLH4kPxfcDGg4A/xJNJLhe3o8FS989gbf3hnHy73LXvF7Ybv27KmABonMhlfirwu3kfBfCmlIG1eaQJq5WFVaFGouRfN8tJO+4W/tmQturDjwPW6VdQvTEaQRvwsI3cJ5r9Xo297uUtFvE6tYzP8cuyyqTA1u3Wg2gm+kQzdEMaBLGHYTWOqXF96wU7M5jcKYCYMJFn4kOHUSXtmCySBn817bdaeUtgxy42lS1OrVi60b6ukz9EixmcBoY6heVhL/3ie3jhpA0a4b70qy88keGa20ZdZCo0wU7IMbkC8ZAEC/T3KVFqXj5G0WqTvwx+BHteuRgXIKILHufowT+H/OmrJGjqig12KsQQnyoJhQvvZhO7dPAyWIMHZK+wWBbyRRoNWnL3hxmuvBvFdCSCeWnSTU0c5EtBaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EjPjsj+gRMRucXSznQb0dWo6SalQVviwkuHY3k379Q00+7izpb3BzImh4+kqiCcXDmjyHP5EL3kDYNauKy5QzhlVCriMKimGX9BGJdqCZ8VySfbWqGCZCauiiqr+3EuBxfp71jhKC4yyCSJeOAJTE/HnWjQK5rFwrRj4DmusBMSaoSqoxGJFJa1aRMF/hnC69A0kqOVZjJfvhTUT9zpX1RPHb4QntUV9SeftBEXtMHZs1ww9KGekXlKeughZuPdaKVUy7Jy3iqQH7QELHbyjRLGIM3W9T46JgAnw81WoDxjrJRv3nNXW3KaUAc0GvcgJETsmCDeQvYi95fDm7VIL9XgSTS8a9SG9JTw0n6B0oksqLm29WrMDHFhLqR0T0so77KEBQdOWjlDGRUA8PbRXJ8PN1HNu7MFJ9zkQ8k5CfzM0i8fdIbGoDQGsbLuJNsmN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:53.7779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92378352-e807-4ebd-cf7f-08df3f951a8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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
- The builder passed a NULL is_ungated, so these steps never programmed
  under BLS: DSC_WAIT_DISCONNECT_PENDING_CLEAR, DSC_DISABLE,
  DCCG_SET_REF_DSCCLK. The immediate path does program them.

[How]
- Store the DSC_PG_STATUS result in the new dsc->pg_ungated; the three
  steps read it at execute time.
- Pass the DSC pointer to the four adders instead of dsc_inst and
  is_ungated.
- hwss_add_dsc_pg_status returns whether it emitted a step; if not, the
  builder emits no dependent steps.
- Adders validate their arguments and hooks; executors only program.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 81 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 20 +++--
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  9 +++
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |  1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 22 ++---
 7 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 32a33d29835e..c5e8a88d051d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4033,22 +4033,16 @@ void hwss_disable_phantom_crtc(union block_sequence_params *params)
 void hwss_dsc_pg_status(union block_sequence_params *params)
 {
 	struct dce_hwseq *hws = params->dsc_pg_status_params.hws;
-	int dsc_inst = params->dsc_pg_status_params.dsc_inst;
+	struct display_stream_compressor *dsc = params->dsc_pg_status_params.dsc;
 
-	if (hws && hws->funcs.dsc_pg_status)
-		params->dsc_pg_status_params.is_ungated = hws->funcs.dsc_pg_status(hws, dsc_inst);
+	dsc->pg_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
 }
 
 void hwss_dsc_wait_disconnect_pending_clear(union block_sequence_params *params)
 {
 	struct display_stream_compressor *dsc = params->dsc_wait_disconnect_pending_clear_params.dsc;
 
-	if (!params->dsc_wait_disconnect_pending_clear_params.is_ungated)
-		return;
-	if (*params->dsc_wait_disconnect_pending_clear_params.is_ungated == false)
-		return;
-
-	if (dsc && dsc->funcs->dsc_wait_disconnect_pending_clear)
+	if (dsc->pg_ungated)
 		dsc->funcs->dsc_wait_disconnect_pending_clear(dsc);
 }
 
@@ -4056,27 +4050,17 @@ void hwss_dsc_disable(union block_sequence_params *params)
 {
 	struct display_stream_compressor *dsc = params->dsc_disable_params.dsc;
 
-	if (!params->dsc_disable_params.is_ungated)
-		return;
-	if (*params->dsc_disable_params.is_ungated == false)
-		return;
-
-	if (dsc && dsc->funcs->dsc_disable)
+	if (dsc->pg_ungated)
 		dsc->funcs->dsc_disable(dsc);
 }
 
 void hwss_dccg_set_ref_dscclk(union block_sequence_params *params)
 {
 	struct dccg *dccg = params->dccg_set_ref_dscclk_params.dccg;
-	int dsc_inst = params->dccg_set_ref_dscclk_params.dsc_inst;
-
-	if (!params->dccg_set_ref_dscclk_params.is_ungated)
-		return;
-	if (*params->dccg_set_ref_dscclk_params.is_ungated == false)
-		return;
+	const struct display_stream_compressor *dsc = params->dccg_set_ref_dscclk_params.dsc;
 
-	if (dccg && dccg->funcs->set_ref_dscclk)
-		dccg->funcs->set_ref_dscclk(dccg, dsc_inst);
+	if (dsc->pg_ungated)
+		dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
 }
 
 void hwss_dpp_pg_control(union block_sequence_params *params)
@@ -5457,54 +5441,65 @@ void hwss_add_disable_phantom_crtc(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
+bool hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
-		int dsc_inst,
-		bool is_ungated)
+		struct display_stream_compressor *dsc)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = DSC_PG_STATUS;
-		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.hws = hws;
-		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.dsc_inst = dsc_inst;
-		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.is_ungated = is_ungated;
-		(*seq_state->num_steps)++;
-	}
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+	    !hws || !hws->funcs.dsc_pg_status || !dsc)
+		return false;
+
+	if (*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return false;
+
+	seq_state->steps[*seq_state->num_steps].func = DSC_PG_STATUS;
+	seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.hws = hws;
+	seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.dsc = dsc;
+	(*seq_state->num_steps)++;
+
+	return true;
 }
 
 void hwss_add_dsc_wait_disconnect_pending_clear(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		bool *is_ungated)
+		struct display_stream_compressor *dsc)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+	    !dsc || !dsc->funcs || !dsc->funcs->dsc_wait_disconnect_pending_clear)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DSC_WAIT_DISCONNECT_PENDING_CLEAR;
 		seq_state->steps[*seq_state->num_steps].params.dsc_wait_disconnect_pending_clear_params.dsc = dsc;
-		seq_state->steps[*seq_state->num_steps].params.dsc_wait_disconnect_pending_clear_params.is_ungated = is_ungated;
 		(*seq_state->num_steps)++;
 	}
 }
 
 void hwss_add_dsc_disable(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		bool *is_ungated)
+		struct display_stream_compressor *dsc)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+	    !dsc || !dsc->funcs || !dsc->funcs->dsc_disable)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DSC_DISABLE;
 		seq_state->steps[*seq_state->num_steps].params.dsc_disable_params.dsc = dsc;
-		seq_state->steps[*seq_state->num_steps].params.dsc_disable_params.is_ungated = is_ungated;
 		(*seq_state->num_steps)++;
 	}
 }
 
 void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
 		struct dccg *dccg,
-		int dsc_inst,
-		bool *is_ungated)
+		const struct display_stream_compressor *dsc)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+	    !dccg || !dccg->funcs || !dccg->funcs->set_ref_dscclk || !dsc)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DCCG_SET_REF_DSCCLK;
 		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.dccg = dccg;
-		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.dsc_inst = dsc_inst;
-		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.is_ungated = is_ungated;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.dsc = dsc;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index de169ed3b3b7..99592d5bb3c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -43,6 +43,7 @@ struct display_stream_compressor {
 	const struct dsc_funcs *funcs;
 	struct dc_context *ctx;
 	int inst;
+	bool pg_ungated;
 };
 
 struct dc_dsc_policy {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f14cba867111..cc78b4794cef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1828,7 +1828,8 @@ static void dcn401_add_dsc_sequence_for_odm_change(struct dc *dc, struct dc_stat
 	if (otg_master->stream_res.dsc && otg_master->stream->timing.flags.DSC) {
 		if (!hwss_add_dsc_sequence_for_stream(seq_state, otg_master,
 				otg_master->dsc_padding_params.dsc_hactive_padding, NULL)) {
-			ASSERT(false);
+			/* DSC sequence is deliberately skipped while the stream is dpms off */
+			ASSERT(otg_master->stream->dpms_off);
 			return;
 		}
 	} else if (otg_master->stream_res.dsc && !otg_master->stream->timing.flags.DSC) {
@@ -3635,12 +3636,10 @@ void dcn401_post_unlock_reset_opp_sequence(
 	if (dc->hwss.wait_for_mpcc_disconnect_sequence)
 		dc->hwss.wait_for_mpcc_disconnect_sequence(dc, dc->res_pool, opp_head, seq_state);
 
-	if (dsc) {
-		bool *is_ungated = NULL;
-		/* Check DSC power gate status */
-		if (dc->hwseq && dc->hwseq->funcs.dsc_pg_status)
-			hwss_add_dsc_pg_status(seq_state, dc->hwseq, dsc->inst, false);
-
+	/* Check DSC power gate status; the result is kept in dsc->pg_ungated and
+	 * gates the steps below at execute time.
+	 */
+	if (dsc && hwss_add_dsc_pg_status(seq_state, dc->hwseq, dsc)) {
 		/* Seamless update specific where we will postpone non
 		 * double buffered DSCCLK disable logic in post unlock
 		 * sequence after DSC is disconnected from OPP but not
@@ -3648,14 +3647,13 @@ void dcn401_post_unlock_reset_opp_sequence(
 		 */
 
 		/* DSC wait disconnect pending clear */
-		hwss_add_dsc_wait_disconnect_pending_clear(seq_state, dsc, is_ungated);
+		hwss_add_dsc_wait_disconnect_pending_clear(seq_state, dsc);
 
 		/* DSC disable */
-		hwss_add_dsc_disable(seq_state, dsc, is_ungated);
+		hwss_add_dsc_disable(seq_state, dsc);
 
 		/* Set reference DSCCLK */
-		if (dccg && dccg->funcs->set_ref_dscclk)
-			hwss_add_dccg_set_ref_dscclk(seq_state, dccg, dsc->inst, 0);
+		hwss_add_dccg_set_ref_dscclk(seq_state, dccg, dsc);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index f8254dfe1ce7..8a38b7f0bef0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -1332,3 +1332,12 @@ bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	return true;
 }
+
+bool dcn60_dsc_pg_status(struct dce_hwseq *hws, unsigned int dsc_inst)
+{
+	(void)hws;
+	(void)dsc_inst;
+
+	/* DCN6.0 has no DSC power-gate domain, so the DSC is always ungated. */
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
index b880988ff1fc..b88f4304b1b9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
@@ -29,6 +29,7 @@ void dcn60_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx
 
 void dcn60_program_perfmon(struct dc *dc, struct dc_state *context);
 bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable);
+bool dcn60_dsc_pg_status(struct dce_hwseq *hws, unsigned int dsc_inst);
 
 bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 9fde7d1be3e5..d5c8dcc86a9f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -159,7 +159,7 @@ static const struct hwseq_private_funcs dcn60_private_funcs = {
 	.update_odm = dcn401_update_odm,
 	.update_odm_sequence = dcn401_update_odm_sequence,
 	.dsc_pg_control = NULL,
-	.dsc_pg_status = NULL,
+	.dsc_pg_status = dcn60_dsc_pg_status,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.set_hdr_multiplier_sequence = dcn401_set_hdr_multiplier_sequence,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6996ce12a17d..c4f3ec532572 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1037,24 +1037,20 @@ struct dc_ip_request_cntl_params {
 
 struct dsc_pg_status_params {
 	struct dce_hwseq *hws;
-	int dsc_inst;
-	bool is_ungated;
+	struct display_stream_compressor *dsc;
 };
 
 struct dsc_wait_disconnect_pending_clear_params {
 	struct display_stream_compressor *dsc;
-	bool *is_ungated;
 };
 
 struct dsc_disable_params {
 	struct display_stream_compressor *dsc;
-	bool *is_ungated;
 };
 
 struct dccg_set_ref_dscclk_params {
 	struct dccg *dccg;
-	int dsc_inst;
-	bool *is_ungated;
+	const struct display_stream_compressor *dsc;
 };
 
 struct dccg_update_dpp_dto_params {
@@ -2919,23 +2915,19 @@ void hwss_add_dpp_dppclk_control(struct block_sequence_state *seq_state,
 void hwss_add_disable_phantom_crtc(struct block_sequence_state *seq_state,
 		struct timing_generator *tg);
 
-void hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
+bool hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
-		int dsc_inst,
-		bool is_ungated);
+		struct display_stream_compressor *dsc);
 
 void hwss_add_dsc_wait_disconnect_pending_clear(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		bool *is_ungated);
+		struct display_stream_compressor *dsc);
 
 void hwss_add_dsc_disable(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		bool *is_ungated);
+		struct display_stream_compressor *dsc);
 
 void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
 		struct dccg *dccg,
-		int dsc_inst,
-		bool *is_ungated);
+		const struct display_stream_compressor *dsc);
 
 bool hwss_is_dpp_root_clock_control_allowed(struct dce_hwseq *hws, bool clock_on);
 
-- 
2.43.0

