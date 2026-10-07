Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFF8CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7EC10E63C;
	Wed,  7 Oct 2026 17:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZY34rkKg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17DA10E61C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq1AWj1LOxiuJZgecLe2j0xA0sWVjXkoYFc5vVyDG5JglIdnLltoSng1JBSnwQ5+0lqZ2HMlg3TL6p32Gdw3jMBZUTnRN4fYEWWH7XZgFsumjJWcWEGAOsHhII1UyLYB8ey/g7ZIBgdWrWX3fEr4IkgY0gEkLfrL8RKdAzTyR0fBACENCNAuFQFqUL1vDRj6Y+HO1JteCTzGUZlID3xif+ZMQEYcf+PKkAEUxxWosJdQOIH87I1oCjlQAn7Cl/PebGUbW8hv9Z4VTkN4AS7KmT578Kb/k43dgsaYNRuJV1BnrfQ3kBKbk4Onkh3THJ4LKqluITgYWyZ5CAT9UAqjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdmLjR1dKuExWp1gsiocgY425SFeNu5nXFal5Gt/sQU=;
 b=YH/3WDB1zTAvCuQ84hSzvkb+RIWV36mXsM3TWztGYciENGJv8yJGnON7SlupF7pev2mW+o5sqcbNF2GQzZ+uAtVD0NazJieJjfp5i5Es1tciy8WY2NHTsfbsaUU67GqYHbjT/hRR0F1u4iIVQc/250IzNAgp9Ni3/IDgV0RDz8rvucAf5OrtkkSumPZPaznWFzt22WK9+qCsywxgFR8U+gqfpDo2QAOGk7OamVC4X3Z7D5EWc9b6E4P2ECqVU+lL+paT/7+Ws90a+E1D3OaEHbofwtsX9+esqF6A6CkEKOL8i/R3FpAaGV/aCgCN9hWhBnvdNO9YJYbdHCi3Z+z+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdmLjR1dKuExWp1gsiocgY425SFeNu5nXFal5Gt/sQU=;
 b=ZY34rkKgEWjJ6K45oPUesUnlTeCvhhAZ/6MAcTCAIIqFZC/zMz3xt/i+hMX+TVeRDN2La2qvVuwbZbD+oBBqK6m1X6k4aO7W0BqP2WmuXsduVkBj12wh0MjTMiYkc1zzHy7mok/XDTi2O+mWh7UV9GUOCygF941Gt7x0zEp5MrQ=
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:22 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::27) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:17 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:16 -0500
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
Subject: [PATCH 01/19] drm/amd/display: HWSS Refactor - DC IP request control
Date: Wed, 7 Oct 2026 12:59:34 -0400
Message-ID: <20261007170412.1898315-2-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 129cfb81-633b-4757-e614-08df24950886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XJv4oANZG/h7OlpKIsLoYIuVqq5KQ3PpOUQSx5WYlX/RWQZvTLZEL52gkDXjJNFPziGP02PUO1aH/iveNucdgFD6czwxYCQohNXhtcFmTT+q4KXiM2qcng/AbE2idDNqpK4+lB0pv/6srqUAa4UV5nSGR5kvJh3zAd+582gSKtGozDuE3u/BxR5PtWMhwlllVbmBflSEVKFCkQTy9+GGcFBVll0mIHqQASxUS1HiS+fLGY1cmcZa0KPj1dW+8EtHo+EVfwhYaOuFsX9Zh7hmsxevCOmj5srMM4SP2mQ3foY/zGZ6XEgly0/p/5cWdfCnpMESkvQNeyaKRQa9xjToUB7CBzHfGdIN0jCf2AHs2c2EHVKbRLIJu3YdChpmt2sWYdoObdiKwuI7Los9FEKxPU9tFSCtNB9/qDIJNJLY0546UkNYvlKYRW9uEEjLMQeftVVz9agDKGgQ99PCUF62Sc3DVRXTMznIryQjRoCaIZeA9m4HZUuew+lEM8xOj/Um9U0J8Dgjs8V86Rg9+FLQM3BmAr88RlOesOPfcalNA4I325THwMos8At3F1Xv7/1LvTYspbJcZ347LGjkZO9Mgx17RDotPnCOSuMAxhfgz/RjUwtlgxzoH3RZixuomeAuCo3DE4wZ8aeBrBW1g2Lw2uaICn6XtokbmKkkRQtA5EEHmGoEmXCRncoXIuYaHb3ihs2/fOh/yDgv8JryTODdAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4fvvsR3w28dsMIcWo9wm7jUXJjJ9yhG9hx+8fULBC8PAY0YJNo5/W8JRVC5nMEDyhlN/0PFLK6T2N+bD8otza1vSLbjm52Z0BSwOqdWjNir7pje7nubgB9Eo/+6/kT4C8FFOd2DNXJyofm9uc7c1uRVIpMVPosv3s+naBn30dGqSQ7zZ84tjoKs9TOrcWE0Goq6qOLivpWdKtgiKWq8MnpWXirRoueBw8DT0upKAqed7bm+W+1fsES8YsGeKUOMSVKBi56VqYvMBh/mmIIX1+PgQEtC6dW+BlqdMAobG+Bz/NqG5QcKB1Hw6yrp7j+3doWyIjn7SPVmEMDDRs+A0Spp0tJ9R1QHNGXCJmFFBbNg1Ws2UP70DHJMVH0JREgCvVXy5LdLQj/SmbmpJME0mwOBkUf0XX364jby4TRmcfPBtzoO36o3QFurlXpSXHElr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:22.1262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129cfb81-633b-4757-e614-08df24950886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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
Refactor DC_IP_REQUEST_CNTL to follow BLS rules: replace struct dc *dc
with dce_hwseq handle in parameter structure and vtable signature, and
add comprehensive hardware access guards.

[HOW]
- Update struct dc_ip_request_cntl_params to store struct dce_hwseq *hws
  instead of struct dc *dc.
- Update hwseq_private_funcs.dc_ip_request_cntl signature and dcn401 implementation
  to take (struct dce_hwseq *hws, bool enable).
- Add null checks for hws context, registers, shifts, and masks in dcn401_dc_ip_request_cntl.
- Update hwss_dc_ip_request_cntl executor and hwss_add_dc_ip_request_cntl builder.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c    | 12 +++++++-----
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    |  6 +++---
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h   |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h   |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index da98afee558f..7b93f57aff85 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4051,12 +4051,10 @@ void hwss_dpp_root_clock_control(union block_sequence_params *params)
 
 void hwss_dc_ip_request_cntl(union block_sequence_params *params)
 {
-	struct dc *dc = params->dc_ip_request_cntl_params.dc;
+	struct dce_hwseq *hws = params->dc_ip_request_cntl_params.hws;
 	bool enable = params->dc_ip_request_cntl_params.enable;
-	struct dce_hwseq *hws = dc->hwseq;
 
-	if (hws->funcs.dc_ip_request_cntl)
-		hws->funcs.dc_ip_request_cntl(dc, enable);
+	hws->funcs.dc_ip_request_cntl(hws, enable);
 }
 
 void hwss_dccg_update_dpp_dto(union block_sequence_params *params)
@@ -4964,9 +4962,13 @@ void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		bool enable)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !dc ||
+			!dc->hwseq || !dc->hwseq->funcs.dc_ip_request_cntl)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DC_IP_REQUEST_CNTL;
-		seq_state->steps[*seq_state->num_steps].params.dc_ip_request_cntl_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.dc_ip_request_cntl_params.hws = dc->hwseq;
 		seq_state->steps[*seq_state->num_steps].params.dc_ip_request_cntl_params.enable = enable;
 		(*seq_state->num_steps)++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0abdfc55290c..efff09784f45 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3598,10 +3598,10 @@ void dcn401_post_unlock_reset_opp_sequence(
 	}
 }
 
-void dcn401_dc_ip_request_cntl(struct dc *dc, bool enable)
+void dcn401_dc_ip_request_cntl(struct dce_hwseq *hws, bool enable)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-
+	if (!hws || !hws->ctx || !hws->regs || !hws->shifts || !hws->masks)
+		return;
 	if (REG(DC_IP_REQUEST_CNTL))
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, enable ? 1 : 0);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index ecaeb192bca3..9df72e980e7a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -185,7 +185,7 @@ void dcn401_post_unlock_reset_opp_sequence(
 		struct pipe_ctx *opp_head,
 		struct block_sequence_state *seq_state);
 
-void dcn401_dc_ip_request_cntl(struct dc *dc, bool enable);
+void dcn401_dc_ip_request_cntl(struct dce_hwseq *hws, bool enable);
 
 void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
 				 struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7800b0501c39..bd005aaf9317 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -711,7 +711,7 @@ struct dpp_root_clock_control_params {
 };
 
 struct dc_ip_request_cntl_params {
-	struct dc *dc;
+	struct dce_hwseq *hws;
 	bool enable;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 9586029dcec1..b2e63363066f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -225,7 +225,7 @@ struct hwseq_private_funcs {
 			struct hubp *primary_hubp);
 	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
 	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
-	void (*dc_ip_request_cntl)(struct dc *dc, bool enable);
+	void (*dc_ip_request_cntl)(struct dce_hwseq *hws, bool enable);
 	void (*program_cm_hist)(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		const struct dc_plane_state *plane_state);
-- 
2.43.0

