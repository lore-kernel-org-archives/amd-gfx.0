Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F48606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qqW1iWrC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BE010F8B6;
	Wed, 11 Nov 2026 01:40:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF2610F8BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZGr26HJVNu97nHZk9rsySiCcqzSVyJDQaH/xwCSI+QvgjwutXtU9QuhQuPktAnsHh9nE687ari7H1TcVNsaIh3PllMcCXrD68ufcnG8pY9S3iWT+WDDswBzpughc+fISxz0rY5GS3xmBSe8oAyzKdVKoAb8L+Es00z1VQbZ+P+euMUUPVWj0tsq5cn4izFfASE+cndI+8TyuelN7N1WnkuR5mMK5scsGmlEyBLqJOqhXvBHzDeK8iFT1M0Bfs/jOT/0jF7F3UQRLPzLQJv3lyOEvpbn0JNWUdO0FOsx6YstGASMiK3Z+4hTY7Vh1zPLs3Zxm7hx4LqLB98tiH+bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujuArJ+61T5j/qXN2TisUgtadG/58K3QY5qW8jUYRZs=;
 b=EuTLzF8i1ohJmJ19SZdnb7x909F98+85eSykhdMViIz79rq2VHt7GkzeA8i6+0tPSAHS+dkOHITrAZI+nHmydnhyXbQ0v0omm1GriDQqoMuaJlUqOmk5DDNCBuQ2VysuBLBoLTRXclwst4SXUVcpe1HCHuspMbLiJaWrSiTe2wBz0gS376pOra1tCk0E+nsBIAsyI5fzjyBwyqwBBSlfXhw/w0gp2ZdmsUNuTEygZkd5E2fw8MRuaOuY0fiSDQhSHQC25Ckj32lbJO9y8jfLaET6iGlijVAmFarlLLepZy1dXz31Rvlt+CKA6K5ppYQFzaw3WrbEkFWKFNlB/54KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujuArJ+61T5j/qXN2TisUgtadG/58K3QY5qW8jUYRZs=;
 b=qqW1iWrC40fu8nltIDuYOeZosxwTFAms3XwjK3Z+K6OWYv3aW6NMFjruQqQWkmIOlAgbpGXNHLdEzjgAMxm6g3yKmYYHh0CVUNrZ6xg9Gqu3dlXEPsS553Q6tKxnYZ53Y922shVX6frgdlNSpn1QWqteUP0JEf/0visZWMG/yv0=
Received: from SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:40:47 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a8) by SJ0PR05CA0140.outlook.office365.com
 (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Wed, 11
 Nov 2026 01:40:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:46 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 06/74] drm/amd/display: Add leaf BLS entries for a virtual
 commit
Date: Wed, 11 Nov 2026 09:28:12 +0800
Message-ID: <20261111014100.3596072-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4c764b-3459-4cb5-8cad-08df3f94cf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261009223027099003|261009221227099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QSKkAyUCco/iqCUGTICHD+9QC+uVqkuuCvpwoxkc3chohRYLhPiADd4v60+XpfcdH1ITbhOHrNd9nfP5BtxXlGX3DfTLb/wtbz25nFPdT5mAoULu8pmnJEjLA0hqLkXZHoh3sSRSciMIWqIT6t3DoVVrSDM6d8oUR27Tf0VC8/XA/fO2sS8dssrfzuPs/2iqW6ZqeAKgKAAn9lvVjzRZQs6ZyHALY9hQZD7s/mFE1CM1tqAYtebT93DXbttXt6tDnYA+9oNDiMv02GBlg6ztVZX6Q/6HYU8HfiI2bQ2wsrrtTbtGn7RsEmpHpW/Tf2YTz+ol1oNjlhpwUt8rlGx813osEWSbMV+ixqG0dnLeucJgwe3Sg9GNChmh3JxDsp2E46UJg4nvJ14EPNVtdCYDBqsmEg/DBWg1VUIMHKykr4UgwmyTptoA/hQ2ffe47Yk/TIAzKeJVXvRsPwQ494hSjuHLyoISQKYSgB4icxx02zMzQVg/UIAJ3Na4Hme9j9TNap9LhA62Cg93/AXbieWKe8yqAwaoajkvICEgpUghRYBWWhQLcaXL9zz7/YhGQQqG8o/dw98mK94qahHNTeVSFKS/k2WMhoAd3YAOA9BQNddUNteYgLV1BMZ5YUyI3uoykhFXf1NmUqwQDpMP6MKmlX+NSKxxJ71NWoEviuYT+nAEf+rBavTwFad+IHeaV5qSIqZY+UHQqYwMb4k5iigbYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OTDXr/I9YVwabBNysib5rs+waoXbyCUanllMsSozTVBLZFP1bJ0Xdd/d8xSSPxo7G/p8CjyjeebF0m53PXTvZlzOSaAtkS9LY6FCCbSObMLZhImflNJsTc92zB39Xi9iD+CjyC1h/eid+JQtFk/J0Tbk5TzWkxOEt3LKHZEf1qsm4zGYFLEBiVKW9wZDnuYy0aJfANnLBWgItWnEASsfUi57OKGRUCWpvvRSq4CJxJPz//OBFFjA0v/gYvE3f+k7eR9p65RpLA0jtVNk1Y2E8tBbqRBXJJPzqI7PT+49tEseQWLnvtFwzwxjeagD0cIVD18qhKZ2od3gdwdfWs9Lp5OKKdjqyE9QwQLg7M15zal8i9bL3KZqDWtS78+L0mrDBmORfcFJZg4CZjy2gCN5+w2uky2xdusWy7lp1omAusqlGBD32XtQtufvT2YwehCJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:47.4477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4c764b-3459-4cb5-8cad-08df3f94cf50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

From: Tony Cheng <tony.cheng@amd.com>

The virtual enable and stream-off that DC1 performs sit inside HWSS
and link helpers: dcn401_enable_stream, link_set_dpms_on,
link_set_dpms_off, dcn401_prepare_bandwidth and
dcn20_wait_for_blank_complete. The DC2 executor has no leaf entry
for those calls, so a builder cannot emit them without calling DC1.

Add one block_sequence entry per call, with its params next to the
enum in hw_sequencer.h, and a DC2 case that makes that single call.
Entries the virtual path already shares with other builders keep
their enum values and params. TG_LOCK calls lock or unlock
directly; preflight rejects the DMUB-inbox1 and triple-buffer
variants because they are not leaf calls. HUBP_PG_CONTROL and
DC_IP_REQUEST_CNTL stay hwseq calls because the hwseq owns those
registers. Preflight checks the block, the function and any pointer
payload before the sequence runs.

Match DC1 when a call fails. enable_crtc, disable_crtc and
program_pix_clk stop the sequence. A blank-wait timeout and a
failed cs_power_down follow continue_on_error, because DC1 only
logs them. A clock raise whose program_watermarks or
program_arbiter reports a change sets dc->optimized_required.

DC1 never emits the new enum values, and hwss_execute_sequence is
unchanged, so the legacy commit is unaffected. The builder that
orders these entries follows in a later patch.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/bls_executor/bls_executor.c    | 584 ++++++++++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 192 ++++++
 2 files changed, 776 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 7600954c3478..5111c65fd961 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -13,8 +13,12 @@
 #include "abm.h"
 #include "audio.h"
 #include "dchubbub.h"
+#include "hubp.h"
+#include "dpp.h"
+#include "mpc.h"
 #include "dio.h"
 #include "link_encoder.h"
+#include "vpg.h"
 #include "panel_cntl.h"
 #include "link_service.h"
 #include "dc_bios_types.h"
@@ -31,6 +35,15 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 	struct clk_mgr *clk_mgr;
 	struct dccg *dccg;
 	struct dc_context *ctx;
+	struct hubbub *hubbub;
+	struct timing_generator *tg;
+	struct output_pixel_processor *opp;
+	struct clock_source *cs;
+	struct link_encoder *link_enc;
+	struct dce_hwseq *hws;
+	struct hubp *hubp;
+	struct dpp *dpp;
+	struct mpc *mpc;
 
 	switch (step->func) {
 	case LEGACY_CLK_MGR_INIT_CLOCKS:
@@ -283,6 +296,197 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 		return hubbub && hubbub->funcs &&
 				hubbub->funcs->force_pstate_change_control;
 	}
+	case CLK_MGR_UPDATE_CLOCKS_FOR_STATE:
+		clk_mgr = step->params.clk_mgr_update_clocks_for_state_params
+				.clk_mgr;
+		return clk_mgr && clk_mgr->funcs && clk_mgr->funcs->update_clocks &&
+				step->params.clk_mgr_update_clocks_for_state_params
+				.context;
+	case HUBBUB_PROGRAM_WATERMARKS:
+		hubbub = step->params.hubbub_program_watermarks_params.hubbub;
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->program_watermarks &&
+				step->params.hubbub_program_watermarks_params
+				.watermarks;
+	case HUBBUB_PROGRAM_ARBITER:
+		hubbub = step->params.hubbub_program_arbiter_params.hubbub;
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->program_arbiter &&
+				step->params.hubbub_program_arbiter_params.arb_regs;
+	case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
+		hubbub = step->params.hubbub_program_compbuf_segments_params
+				.hubbub;
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->program_compbuf_segments;
+	case HUBP_PROGRAM_DET_SEGMENTS:
+		hubbub = step->params.program_det_segments_params.hubbub;
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->program_det_segments;
+	case TG_LOCK: {
+		const struct tg_lock_params *p = &step->params.tg_lock_params;
+
+		/* DMUB inbox1 and triple-buffer locks are not leaf calls. */
+		return p->tg && p->tg->funcs && !p->use_dmub_inbox1 &&
+				!p->triplebuffer_flips &&
+				(p->lock ? p->tg->funcs->lock : p->tg->funcs->unlock);
+	}
+	case TG_ENABLE_CRTC:
+		tg = step->params.tg_enable_crtc_params.tg;
+		return tg && tg->funcs && tg->funcs->enable_crtc;
+	case TG_DISABLE_CRTC:
+		tg = step->params.tg_disable_crtc_params.tg;
+		return tg && tg->funcs && tg->funcs->disable_crtc;
+	case TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR:
+		tg = step->params.tg_wait_odm_doublebuffer_pending_clear_params.tg;
+		return tg && tg->funcs &&
+				tg->funcs->wait_odm_doublebuffer_pending_clear;
+	case TG_PROGRAM_STEREO:
+		tg = step->params.tg_program_stereo_params.tg;
+		return tg && tg->funcs && tg->funcs->program_stereo &&
+				step->params.tg_program_stereo_params.timing;
+	case OPP_PROGRAM_STEREO:
+		opp = step->params.opp_program_stereo_params.opp;
+		return opp && opp->funcs && opp->funcs->opp_program_stereo &&
+				step->params.opp_program_stereo_params.timing;
+	case TG_WAIT_FOR_STATE:
+		tg = step->params.tg_wait_for_state_params.tg;
+		return tg && tg->funcs && tg->funcs->wait_for_state;
+	case TG_SETUP_VERTICAL_INTERRUPT2:
+		tg = step->params.tg_setup_vertical_interrupt2_params.tg;
+		return tg && tg->funcs && tg->funcs->setup_vertical_interrupt2;
+	case OPTC_SET_ODM_BYPASS:
+		tg = step->params.set_odm_bypass_params.tg;
+		return tg && tg->funcs && tg->funcs->set_odm_bypass &&
+				step->params.set_odm_bypass_params.timing;
+	case TG_ENABLE_OPTC_CLOCK:
+		tg = step->params.tg_enable_optc_clock_params.tg;
+		return tg && tg->funcs && tg->funcs->enable_optc_clock;
+	case TG_PROGRAM_TIMING:
+		tg = step->params.tg_program_timing_params.tg;
+		return tg && tg->funcs && tg->funcs->program_timing &&
+				step->params.tg_program_timing_params.timing;
+	case TG_SET_H_TIMING_DIV_MANUAL_MODE:
+		tg = step->params.tg_set_h_timing_div_manual_mode_params.tg;
+		return tg && tg->funcs &&
+				tg->funcs->set_h_timing_div_manual_mode;
+	case TG_SET_DRR:
+		tg = step->params.tg_set_drr_params.tg;
+		return tg && tg->funcs && tg->funcs->set_drr;
+	case TG_SET_STATIC_SCREEN_CONTROL:
+		tg = step->params.tg_set_static_screen_control_params.tg;
+		return tg && tg->funcs && tg->funcs->set_static_screen_control;
+	case TG_SET_OUT_MUX:
+		tg = step->params.tg_set_out_mux_params.tg;
+		return tg && tg->funcs && tg->funcs->set_out_mux;
+	case TG_SET_EARLY_CONTROL:
+		tg = step->params.tg_set_early_control_params.tg;
+		return tg && tg->funcs && tg->funcs->set_early_control;
+	case OPP_PROGRAM_FMT:
+		opp = step->params.opp_program_fmt_params.opp;
+		return opp && opp->funcs && opp->funcs->opp_program_fmt &&
+				step->params.opp_program_fmt_params.fmt_bit_depth &&
+				step->params.opp_program_fmt_params.clamping;
+	case OPP_SET_DYN_EXPANSION:
+		opp = step->params.opp_set_dyn_expansion_params.opp;
+		return opp && opp->funcs && opp->funcs->opp_set_dyn_expansion;
+	case OPP_PIPE_CLOCK_CONTROL:
+		opp = step->params.opp_pipe_clock_control_params.opp;
+		return opp && opp->funcs && opp->funcs->opp_pipe_clock_control;
+	case OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL:
+		opp = step->params.opp_program_left_edge_extra_pixel_params.opp;
+		return opp && opp->funcs &&
+				opp->funcs->opp_program_left_edge_extra_pixel;
+	case OPP_SET_DISP_PATTERN_GENERATOR:
+		opp = step->params.opp_set_disp_pattern_generator_params.opp;
+		return opp && opp->funcs &&
+				opp->funcs->opp_set_disp_pattern_generator;
+	case OPP_WAIT_FOR_BLANK_COMPLETE:
+		opp = step->params.opp_wait_for_blank_complete_params.opp;
+		return opp && opp->funcs && opp->funcs->dpg_is_pending &&
+				opp->funcs->dpg_is_blanked &&
+				step->params.opp_wait_for_blank_complete_params
+				.polling_interval_us;
+	case DCCG_SET_PIXEL_RATE_DIV:
+		dccg = step->params.dccg_set_pixel_rate_div_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->set_pixel_rate_div;
+	case DCCG_DISABLE_SYMCLK_SE:
+		dccg = step->params.dccg_disable_symclk_se_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->disable_symclk_se;
+	case DCCG_ENABLE_SYMCLK_SE:
+		dccg = step->params.dccg_enable_symclk_se_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->enable_symclk_se;
+	case DCCG_SET_DTBCLK_P_SRC:
+		dccg = step->params.dccg_set_dtbclk_p_src_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->set_dtbclk_p_src;
+	case CLK_SRC_PROGRAM_PIX_CLK: {
+		const struct clk_src_program_pix_clk_params *p =
+				&step->params.clk_src_program_pix_clk_params;
+
+		return p->clock_source && p->clock_source->funcs &&
+				p->clock_source->funcs->program_pix_clk &&
+				p->pix_clk_params && p->pll_settings;
+	}
+	case CLK_SRC_POWER_DOWN:
+		cs = step->params.clk_src_power_down_params.clock_source;
+		return cs && cs->funcs && cs->funcs->cs_power_down;
+	case DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE:
+		link_enc = step->params.link_enc_connect_dig_be_to_fe_params
+				.link_enc;
+		return link_enc && link_enc->funcs &&
+				link_enc->funcs->connect_dig_be_to_fe;
+	case DIO_LINK_ENC_ENABLE_DP_OUTPUT:
+		link_enc = step->params.link_enc_enable_dp_output_params
+				.link_enc;
+		return link_enc && link_enc->funcs &&
+				link_enc->funcs->enable_dp_output &&
+				step->params.link_enc_enable_dp_output_params
+				.link_settings;
+	case DIO_LINK_ENC_DISABLE_OUTPUT:
+		link_enc = step->params.link_enc_disable_output_params.link_enc;
+		return link_enc && link_enc->funcs &&
+				link_enc->funcs->disable_output;
+	case BIOS_SET_SCRATCH_CRITICAL_STATE: {
+		struct dc_bios *dcb =
+				step->params.bios_set_scratch_critical_state_params.dcb;
+
+		return dcb && dcb->funcs && dcb->funcs->set_scratch_critical_state;
+	}
+	case HUBP_PG_CONTROL:
+		hws = step->params.hubp_pg_control_params.hws;
+		return hws && hws->funcs.hubp_pg_control;
+	case DC_IP_REQUEST_CNTL:
+		hws = step->params.dc_ip_request_cntl_params.hws;
+		return hws && hws->funcs.dc_ip_request_cntl;
+	case HUBP_CLK_CNTL:
+		hubp = step->params.hubp_clk_cntl_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_clk_cntl;
+	case HUBP_SET_BLANK:
+		hubp = step->params.hubp_set_blank_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->set_blank;
+	case HUBP_UPDATE_MALL_SEL:
+		hubp = step->params.hubp_update_mall_sel_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_update_mall_sel;
+	case HUBP_SET_FLIP_CONTROL_GSL:
+		hubp = step->params.set_flip_control_gsl_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_set_flip_control_surface_gsl;
+	case HUBP_RESET:
+		hubp = step->params.hubp_reset_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_reset;
+	case DPP_RESET:
+		dpp = step->params.dpp_reset_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_reset;
+	case MPC_ASSERT_IDLE_MPCC:
+		mpc = step->params.mpc_assert_idle_mpcc_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->wait_for_idle;
+	case DPP_DPPCLK_CONTROL:
+		dpp = step->params.dpp_dppclk_control_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_dppclk_control;
+	case MPC_REMOVE_MPCC:
+		mpc = step->params.mpc_remove_mpcc_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->remove_mpcc &&
+				step->params.mpc_remove_mpcc_params.mpc_tree_params &&
+				step->params.mpc_remove_mpcc_params.mpcc_to_remove;
 	default:
 		return false;
 	}
@@ -346,6 +550,21 @@ static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_dmub_gpint(
 	return DC2_BLS_EXEC_OK;
 }
 
+static noinline_for_stack bool dc2_bls_wait_for_blank_complete(
+		const struct opp_wait_for_blank_complete_params *w)
+{
+	unsigned int waited_us;
+
+	for (waited_us = 0; w->opp->funcs->dpg_is_pending(w->opp);
+			waited_us += w->polling_interval_us) {
+		if (waited_us >= w->timeout_us)
+			return false;
+		udelay(w->polling_interval_us);
+	}
+
+	return w->opp->funcs->dpg_is_blanked(w->opp);
+}
+
 enum dc2_bls_exec_result dc2_bls_execute(
 		struct dc2 *dc2,
 		const struct block_sequence *steps,
@@ -354,6 +573,13 @@ enum dc2_bls_exec_result dc2_bls_execute(
 	enum dc2_bls_exec_result result = DC2_BLS_EXEC_OK;
 	const struct block_sequence *entry;
 	enum dc2_bls_exec_result sent;
+	struct timing_generator *tg;
+	struct output_pixel_processor *opp;
+	struct clock_source *cs;
+	struct link_encoder *link_enc;
+	struct hubp *hubp;
+	struct dpp *dpp;
+	struct mpc *mpc;
 	unsigned int i;
 
 	if (!steps || num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE)
@@ -693,6 +919,364 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					p->num_chans, p->words_per_umc);
 			break;
 		}
+		case CLK_MGR_UPDATE_CLOCKS_FOR_STATE: {
+			const struct clk_mgr_update_clocks_for_state_params *p =
+					&entry->params
+					.clk_mgr_update_clocks_for_state_params;
+			bool *p_state = &p->context->bw_ctx.bw.dcn.clk
+					.p_state_change_support;
+			bool saved = *p_state;
+
+			if (p->disallow_p_state_change)
+				*p_state = false;
+			p->clk_mgr->funcs->update_clocks(p->clk_mgr, p->context,
+					p->safe_to_lower);
+			*p_state = saved;
+			break;
+		}
+		case HUBBUB_PROGRAM_WATERMARKS: {
+			const struct hubbub_program_watermarks_params *p =
+					&entry->params.hubbub_program_watermarks_params;
+			bool changed = p->hubbub->funcs->program_watermarks(
+					p->hubbub, p->watermarks, p->refclk_mhz,
+					p->safe_to_lower);
+
+			if (p->dc && !p->safe_to_lower)
+				p->dc->optimized_required |= changed;
+			break;
+		}
+		case HUBBUB_PROGRAM_ARBITER: {
+			const struct hubbub_program_arbiter_params *p =
+					&entry->params.hubbub_program_arbiter_params;
+			bool changed = p->hubbub->funcs->program_arbiter(p->hubbub,
+					p->arb_regs, p->safe_to_lower);
+
+			if (p->dc && !p->safe_to_lower)
+				p->dc->optimized_required |= changed;
+			break;
+		}
+		case HUBBUB_PROGRAM_COMPBUF_SEGMENTS: {
+			const struct hubbub_program_compbuf_segments_params *p =
+					&entry->params
+					.hubbub_program_compbuf_segments_params;
+
+			p->hubbub->funcs->program_compbuf_segments(p->hubbub,
+					p->compbuf_size, p->safe_to_lower);
+			break;
+		}
+		case HUBP_PROGRAM_DET_SEGMENTS: {
+			const struct program_det_segments_params *p =
+					&entry->params.program_det_segments_params;
+
+			p->hubbub->funcs->program_det_segments(p->hubbub,
+					p->hubp_inst, p->det_size);
+			break;
+		}
+		case TG_LOCK: {
+			const struct tg_lock_params *p =
+					&entry->params.tg_lock_params;
+
+			if (p->lock)
+				p->tg->funcs->lock(p->tg);
+			else
+				p->tg->funcs->unlock(p->tg);
+			break;
+		}
+		case TG_ENABLE_CRTC:
+			tg = entry->params.tg_enable_crtc_params.tg;
+			if (!tg->funcs->enable_crtc(tg))
+				return DC2_BLS_EXEC_ERROR;
+			break;
+		case TG_DISABLE_CRTC:
+			tg = entry->params.tg_disable_crtc_params.tg;
+			if (!tg->funcs->disable_crtc(tg))
+				return DC2_BLS_EXEC_ERROR;
+			break;
+		case TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR:
+			tg = entry->params
+					.tg_wait_odm_doublebuffer_pending_clear_params.tg;
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+			break;
+		case TG_PROGRAM_STEREO: {
+			const struct tg_program_stereo_params *p =
+					&entry->params.tg_program_stereo_params;
+			struct crtc_stereo_flags flags = p->flags;
+
+			p->tg->funcs->program_stereo(p->tg, p->timing, &flags);
+			break;
+		}
+		case OPP_PROGRAM_STEREO: {
+			const struct opp_program_stereo_params *p =
+					&entry->params.opp_program_stereo_params;
+
+			p->opp->funcs->opp_program_stereo(p->opp, p->enable,
+					p->timing);
+			break;
+		}
+		case TG_WAIT_FOR_STATE:
+			tg = entry->params.tg_wait_for_state_params.tg;
+			tg->funcs->wait_for_state(tg,
+					entry->params.tg_wait_for_state_params.state);
+			break;
+		case TG_SETUP_VERTICAL_INTERRUPT2:
+			tg = entry->params.tg_setup_vertical_interrupt2_params.tg;
+			tg->funcs->setup_vertical_interrupt2(tg, entry->params
+					.tg_setup_vertical_interrupt2_params.start_line);
+			break;
+		case OPTC_SET_ODM_BYPASS:
+			tg = entry->params.set_odm_bypass_params.tg;
+			tg->funcs->set_odm_bypass(tg,
+					entry->params.set_odm_bypass_params.timing);
+			break;
+		case TG_ENABLE_OPTC_CLOCK:
+			tg = entry->params.tg_enable_optc_clock_params.tg;
+			tg->funcs->enable_optc_clock(tg,
+					entry->params.tg_enable_optc_clock_params.enable);
+			break;
+		case TG_PROGRAM_TIMING: {
+			const struct tg_program_timing_params *p =
+					&entry->params.tg_program_timing_params;
+
+			p->tg->funcs->program_timing(p->tg, p->timing,
+					p->vready_offset, p->vstartup_start,
+					p->vupdate_offset, p->vupdate_width,
+					p->pstate_keepout, p->signal, p->use_vbios);
+			break;
+		}
+		case TG_SET_H_TIMING_DIV_MANUAL_MODE:
+			tg = entry->params.tg_set_h_timing_div_manual_mode_params.tg;
+			tg->funcs->set_h_timing_div_manual_mode(tg, entry->params
+					.tg_set_h_timing_div_manual_mode_params
+					.manual_mode);
+			break;
+		case TG_SET_DRR:
+			tg = entry->params.tg_set_drr_params.tg;
+			tg->funcs->set_drr(tg, &entry->params.tg_set_drr_params.drr);
+			break;
+		case TG_SET_STATIC_SCREEN_CONTROL: {
+			const struct tg_set_static_screen_control_params *p =
+					&entry->params
+					.tg_set_static_screen_control_params;
+
+			p->tg->funcs->set_static_screen_control(p->tg,
+					p->event_triggers, p->num_frames);
+			break;
+		}
+		case TG_SET_OUT_MUX:
+			tg = entry->params.tg_set_out_mux_params.tg;
+			tg->funcs->set_out_mux(tg,
+					entry->params.tg_set_out_mux_params.dest);
+			break;
+		case TG_SET_EARLY_CONTROL:
+			tg = entry->params.tg_set_early_control_params.tg;
+			tg->funcs->set_early_control(tg, entry->params
+					.tg_set_early_control_params.early_cntl);
+			break;
+		case OPP_PROGRAM_FMT:
+			opp = entry->params.opp_program_fmt_params.opp;
+			opp->funcs->opp_program_fmt(opp,
+					entry->params.opp_program_fmt_params
+					.fmt_bit_depth,
+					entry->params.opp_program_fmt_params.clamping);
+			break;
+		case OPP_SET_DYN_EXPANSION: {
+			const struct opp_set_dyn_expansion_params *p =
+					&entry->params.opp_set_dyn_expansion_params;
+
+			p->opp->funcs->opp_set_dyn_expansion(p->opp,
+					p->color_space, p->color_depth, p->signal);
+			break;
+		}
+		case OPP_PIPE_CLOCK_CONTROL:
+			opp = entry->params.opp_pipe_clock_control_params.opp;
+			opp->funcs->opp_pipe_clock_control(opp, entry->params
+					.opp_pipe_clock_control_params.enable);
+			break;
+		case OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL: {
+			const struct opp_program_left_edge_extra_pixel_params *p =
+					&entry->params
+					.opp_program_left_edge_extra_pixel_params;
+
+			p->opp->funcs->opp_program_left_edge_extra_pixel(p->opp,
+					p->pixel_encoding, p->is_otg_master);
+			break;
+		}
+		case OPP_SET_DISP_PATTERN_GENERATOR: {
+			const struct opp_set_disp_pattern_generator_params *p =
+					&entry->params
+					.opp_set_disp_pattern_generator_params;
+
+			p->opp->funcs->opp_set_disp_pattern_generator(p->opp,
+					p->test_pattern, p->color_space,
+					p->color_depth,
+					p->use_solid_color ? &p->solid_color : NULL,
+					p->width, p->height, p->offset,
+					p->disable_dyn_exp_for_test_pattern);
+			break;
+		}
+		case OPP_WAIT_FOR_BLANK_COMPLETE:
+			if (dc2_bls_wait_for_blank_complete(&entry->params
+					.opp_wait_for_blank_complete_params))
+				break;
+			if (!entry->params.opp_wait_for_blank_complete_params
+					.continue_on_error)
+				return DC2_BLS_EXEC_ERROR;
+			result = DC2_BLS_EXEC_CONTINUED_ON_ERROR;
+			break;
+		case DCCG_SET_PIXEL_RATE_DIV: {
+			const struct dccg_set_pixel_rate_div_params *p =
+					&entry->params.dccg_set_pixel_rate_div_params;
+
+			p->dccg->funcs->set_pixel_rate_div(p->dccg, p->otg_inst,
+					p->k1, p->k2);
+			break;
+		}
+		case DCCG_DISABLE_SYMCLK_SE: {
+			const struct dccg_disable_symclk_se_params *p =
+					&entry->params.dccg_disable_symclk_se_params;
+
+			p->dccg->funcs->disable_symclk_se(p->dccg,
+					p->stream_enc_inst, p->link_enc_inst);
+			break;
+		}
+		case DCCG_ENABLE_SYMCLK_SE: {
+			const struct dccg_enable_symclk_se_params *p =
+					&entry->params.dccg_enable_symclk_se_params;
+
+			p->dccg->funcs->enable_symclk_se(p->dccg,
+					p->stream_enc_inst, p->link_enc_inst);
+			break;
+		}
+		case DCCG_SET_DTBCLK_P_SRC: {
+			const struct dccg_set_dtbclk_p_src_params *p =
+					&entry->params.dccg_set_dtbclk_p_src_params;
+
+			p->dccg->funcs->set_dtbclk_p_src(p->dccg, p->src,
+					p->otg_inst);
+			break;
+		}
+		case CLK_SRC_PROGRAM_PIX_CLK: {
+			const struct clk_src_program_pix_clk_params *p =
+					&entry->params.clk_src_program_pix_clk_params;
+
+			if (!p->clock_source->funcs->program_pix_clk(
+					p->clock_source, p->pix_clk_params,
+					p->encoding, p->pll_settings))
+				return DC2_BLS_EXEC_ERROR;
+			break;
+		}
+		case CLK_SRC_POWER_DOWN:
+			cs = entry->params.clk_src_power_down_params.clock_source;
+			if (cs->funcs->cs_power_down(cs))
+				break;
+			if (!entry->params.clk_src_power_down_params
+					.continue_on_error)
+				return DC2_BLS_EXEC_ERROR;
+			result = DC2_BLS_EXEC_CONTINUED_ON_ERROR;
+			break;
+		case DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE: {
+			const struct link_enc_connect_dig_be_to_fe_params *p =
+					&entry->params
+					.link_enc_connect_dig_be_to_fe_params;
+
+			p->link_enc->funcs->connect_dig_be_to_fe(p->link_enc,
+					p->engine, p->connect);
+			break;
+		}
+		case DIO_LINK_ENC_ENABLE_DP_OUTPUT: {
+			const struct link_enc_enable_dp_output_params *p =
+					&entry->params.link_enc_enable_dp_output_params;
+
+			p->link_enc->funcs->enable_dp_output(p->link_enc,
+					p->link_settings, p->clock_source);
+			break;
+		}
+		case DIO_LINK_ENC_DISABLE_OUTPUT:
+			link_enc = entry->params.link_enc_disable_output_params
+					.link_enc;
+			link_enc->funcs->disable_output(link_enc,
+					entry->params.link_enc_disable_output_params
+					.signal);
+			break;
+		case BIOS_SET_SCRATCH_CRITICAL_STATE: {
+			const struct bios_set_scratch_critical_state_params *p =
+					&entry->params
+					.bios_set_scratch_critical_state_params;
+
+			p->dcb->funcs->set_scratch_critical_state(p->dcb, p->state);
+			break;
+		}
+		case HUBP_PG_CONTROL: {
+			const struct hubp_pg_control_params *p =
+					&entry->params.hubp_pg_control_params;
+
+			p->hws->funcs.hubp_pg_control(p->hws, p->hubp_inst,
+					p->power_on);
+			break;
+		}
+		case DC_IP_REQUEST_CNTL: {
+			const struct dc_ip_request_cntl_params *p =
+					&entry->params.dc_ip_request_cntl_params;
+
+			p->hws->funcs.dc_ip_request_cntl(p->hws, p->enable);
+			break;
+		}
+		case HUBP_CLK_CNTL:
+			hubp = entry->params.hubp_clk_cntl_params.hubp;
+			hubp->funcs->hubp_clk_cntl(hubp,
+					entry->params.hubp_clk_cntl_params.enable);
+			hubp->power_gated =
+					!entry->params.hubp_clk_cntl_params.enable;
+			break;
+		case HUBP_SET_BLANK:
+			hubp = entry->params.hubp_set_blank_params.hubp;
+			hubp->funcs->set_blank(hubp,
+					entry->params.hubp_set_blank_params.blank);
+			break;
+		case HUBP_UPDATE_MALL_SEL: {
+			const struct hubp_update_mall_sel_params *p =
+					&entry->params.hubp_update_mall_sel_params;
+
+			p->hubp->funcs->hubp_update_mall_sel(p->hubp, p->mall_sel,
+					p->cache_cursor);
+			break;
+		}
+		case HUBP_SET_FLIP_CONTROL_GSL: {
+			const struct set_flip_control_gsl_params *p =
+					&entry->params.set_flip_control_gsl_params;
+
+			p->hubp->funcs->hubp_set_flip_control_surface_gsl(p->hubp,
+					p->flip_immediate);
+			break;
+		}
+		case HUBP_RESET:
+			hubp = entry->params.hubp_reset_params.hubp;
+			hubp->funcs->hubp_reset(hubp);
+			break;
+		case DPP_RESET:
+			dpp = entry->params.dpp_reset_params.dpp;
+			dpp->funcs->dpp_reset(dpp);
+			break;
+		case MPC_ASSERT_IDLE_MPCC:
+			mpc = entry->params.mpc_assert_idle_mpcc_params.mpc;
+			mpc->funcs->wait_for_idle(mpc,
+					entry->params.mpc_assert_idle_mpcc_params.mpcc_id);
+			break;
+		case DPP_DPPCLK_CONTROL:
+			dpp = entry->params.dpp_dppclk_control_params.dpp;
+			dpp->funcs->dpp_dppclk_control(dpp,
+					entry->params.dpp_dppclk_control_params
+					.dppclk_div,
+					entry->params.dpp_dppclk_control_params.enable);
+			break;
+		case MPC_REMOVE_MPCC: {
+			const struct mpc_remove_mpcc_params *p =
+					&entry->params.mpc_remove_mpcc_params;
+
+			p->mpc->funcs->remove_mpcc(p->mpc, p->mpc_tree_params,
+					p->mpcc_to_remove);
+			break;
+		}
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 9f97503a02ff..3042785cb8fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -29,6 +29,7 @@
 #include "inc/clock_source.h"
 #include "inc/hw/timing_generator.h"
 #include "inc/hw/opp.h"
+#include "inc/hw/dccg.h"
 #include "inc/hw/link_encoder.h"
 #include "inc/core_status.h"
 #include "inc/hw/hw_shared.h"
@@ -285,6 +286,143 @@ struct bios_is_accelerated_mode_params {
 	bool *out_accelerated_mode;
 };
 
+struct clk_mgr_update_clocks_for_state_params {
+	struct clk_mgr *clk_mgr;
+	struct dc_state *context;
+	bool safe_to_lower;
+	/* Clears context's p_state_change_support for this call only. */
+	bool disallow_p_state_change;
+};
+
+struct tg_enable_optc_clock_params {
+	struct timing_generator *tg;
+	bool enable;
+};
+
+struct tg_program_timing_params {
+	struct timing_generator *tg;
+	const struct dc_crtc_timing *timing;
+	int vready_offset;
+	int vstartup_start;
+	int vupdate_offset;
+	int vupdate_width;
+	int pstate_keepout;
+	enum signal_type signal;
+	bool use_vbios;
+};
+
+struct tg_set_h_timing_div_manual_mode_params {
+	struct timing_generator *tg;
+	bool manual_mode;
+};
+
+struct tg_set_drr_params {
+	struct timing_generator *tg;
+	struct drr_params drr;
+};
+
+struct tg_set_static_screen_control_params {
+	struct timing_generator *tg;
+	uint32_t event_triggers;
+	uint32_t num_frames;
+};
+
+struct tg_set_out_mux_params {
+	struct timing_generator *tg;
+	enum otg_out_mux_dest dest;
+};
+
+struct tg_set_early_control_params {
+	struct timing_generator *tg;
+	uint32_t early_cntl;
+};
+
+struct tg_disable_crtc_params {
+	struct timing_generator *tg;
+};
+
+struct tg_wait_odm_doublebuffer_pending_clear_params {
+	struct timing_generator *tg;
+};
+
+struct tg_program_stereo_params {
+	struct timing_generator *tg;
+	const struct dc_crtc_timing *timing;
+	struct crtc_stereo_flags flags;
+};
+
+struct opp_program_stereo_params {
+	struct output_pixel_processor *opp;
+	bool enable;
+	const struct dc_crtc_timing *timing;
+};
+
+struct opp_wait_for_blank_complete_params {
+	struct output_pixel_processor *opp;
+	unsigned int polling_interval_us;
+	unsigned int timeout_us;
+	bool continue_on_error;
+};
+
+struct dccg_set_pixel_rate_div_params {
+	struct dccg *dccg;
+	uint32_t otg_inst;
+	enum pixel_rate_div k1;
+	enum pixel_rate_div k2;
+};
+
+struct dccg_disable_symclk_se_params {
+	struct dccg *dccg;
+	uint32_t stream_enc_inst;
+	uint32_t link_enc_inst;
+};
+
+struct dccg_enable_symclk_se_params {
+	struct dccg *dccg;
+	uint32_t stream_enc_inst;
+	uint32_t link_enc_inst;
+};
+
+struct dccg_set_dtbclk_p_src_params {
+	struct dccg *dccg;
+	enum streamclk_source src;
+	uint32_t otg_inst;
+};
+
+struct clk_src_program_pix_clk_params {
+	struct clock_source *clock_source;
+	struct pixel_clk_params *pix_clk_params;
+	enum dp_link_encoding encoding;
+	struct pll_settings *pll_settings;
+};
+
+struct clk_src_power_down_params {
+	struct clock_source *clock_source;
+	bool continue_on_error;
+};
+
+struct link_enc_connect_dig_be_to_fe_params {
+	struct link_encoder *link_enc;
+	enum engine_id engine;
+	bool connect;
+};
+
+struct link_enc_enable_dp_output_params {
+	struct link_encoder *link_enc;
+	const struct dc_link_settings *link_settings;
+	enum clock_source_id clock_source;
+};
+
+struct link_enc_disable_output_params {
+	struct link_encoder *link_enc;
+	enum signal_type signal;
+};
+
+struct bios_set_scratch_critical_state_params {
+	struct dc_bios *dcb;
+	bool state;
+};
+
 struct lsdma_send_pio_copy_params {
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint64_t src_addr;
@@ -1350,6 +1488,37 @@ union block_sequence_params {
 			clk_mgr_initialize_min_clocks_params;
 	struct clk_mgr_notify_wm_ranges_params clk_mgr_notify_wm_ranges_params;
 	struct bios_is_accelerated_mode_params bios_is_accelerated_mode_params;
+	struct clk_mgr_update_clocks_for_state_params
+			clk_mgr_update_clocks_for_state_params;
+	struct tg_enable_optc_clock_params tg_enable_optc_clock_params;
+	struct tg_program_timing_params tg_program_timing_params;
+	struct tg_set_h_timing_div_manual_mode_params
+			tg_set_h_timing_div_manual_mode_params;
+	struct tg_set_drr_params tg_set_drr_params;
+	struct tg_set_static_screen_control_params
+			tg_set_static_screen_control_params;
+	struct tg_set_out_mux_params tg_set_out_mux_params;
+	struct tg_set_early_control_params tg_set_early_control_params;
+	struct tg_disable_crtc_params tg_disable_crtc_params;
+	struct tg_wait_odm_doublebuffer_pending_clear_params
+			tg_wait_odm_doublebuffer_pending_clear_params;
+	struct tg_program_stereo_params tg_program_stereo_params;
+	struct opp_program_stereo_params opp_program_stereo_params;
+	struct opp_wait_for_blank_complete_params
+			opp_wait_for_blank_complete_params;
+	struct dccg_set_pixel_rate_div_params dccg_set_pixel_rate_div_params;
+	struct dccg_disable_symclk_se_params dccg_disable_symclk_se_params;
+	struct dccg_enable_symclk_se_params dccg_enable_symclk_se_params;
+	struct dccg_set_dtbclk_p_src_params dccg_set_dtbclk_p_src_params;
+	struct clk_src_program_pix_clk_params clk_src_program_pix_clk_params;
+	struct clk_src_power_down_params clk_src_power_down_params;
+	struct link_enc_connect_dig_be_to_fe_params
+			link_enc_connect_dig_be_to_fe_params;
+	struct link_enc_enable_dp_output_params
+			link_enc_enable_dp_output_params;
+	struct link_enc_disable_output_params link_enc_disable_output_params;
+	struct bios_set_scratch_critical_state_params
+			bios_set_scratch_critical_state_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
@@ -1559,6 +1728,29 @@ enum block_sequence_func {
 	HUBBUB_SET_REQUEST_LIMIT,
 	BIOS_IS_ACCELERATED_MODE,
 	DMUB_FAMS2_UPDATE_CONFIG,
+	CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
+	TG_ENABLE_OPTC_CLOCK,
+	TG_PROGRAM_TIMING,
+	TG_SET_H_TIMING_DIV_MANUAL_MODE,
+	TG_SET_DRR,
+	TG_SET_STATIC_SCREEN_CONTROL,
+	TG_SET_OUT_MUX,
+	TG_SET_EARLY_CONTROL,
+	TG_DISABLE_CRTC,
+	TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
+	TG_PROGRAM_STEREO,
+	OPP_PROGRAM_STEREO,
+	OPP_WAIT_FOR_BLANK_COMPLETE,
+	DCCG_SET_PIXEL_RATE_DIV,
+	DCCG_DISABLE_SYMCLK_SE,
+	DCCG_ENABLE_SYMCLK_SE,
+	DCCG_SET_DTBCLK_P_SRC,
+	CLK_SRC_PROGRAM_PIX_CLK,
+	CLK_SRC_POWER_DOWN,
+	DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
+	DIO_LINK_ENC_ENABLE_DP_OUTPUT,
+	DIO_LINK_ENC_DISABLE_OUTPUT,
+	BIOS_SET_SCRATCH_CRITICAL_STATE,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

