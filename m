Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4F8C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E24310EAD8;
	Fri, 21 Feb 2025 15:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBkQmmpL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E223C10EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4jVN9wUuHoHw60Gfs6KmkjX75oTjWdFmMm3PKNdznVTEzsYiDq0pUjiXwJu6+9QnEIE58/eJLmZROLAHxJev17lIkF1eK8gAcCsgqR8IP8ld2eoinSj2B9mRVzX6HyFKRPAyUlxMwE8QQik988uGCm350h2FMS0GEKRvAUqoqjhFejJP5rVhQcQq36VhNo6tmxVptfIAnObNWFNiC0KAqGdrSf670QwkU62TtbJ7cW5XtZDjFZGQnyaRyk6J/4d8kKu9DMFDuKh4CmHtKEnjWGm9SLyBh55kzvGPIPN9ztYPMOEddv4OsEiFS/G8QlPry/OUw2mQAjjd2ozDcFcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLAFUd6DXgARALC7omnO2dd+gm/EUE3BwVOS4Jwkvew=;
 b=G6YjLhdVSrMFpmHsjcnOygmf0xaHN7Aykh2u8vFwx/0XsfuoxNrp0czz8emNVERTJ3UnL+xBrz1/fVDFnS5wJ2F8WutRfRdmbh9x16Xz2Gkp8wWmwv983r0SqLv0+b49k7lRvEYMPMUMGIv+Ggx9fGiIpYUDc3gWfoRE+T8Zhp4iJYOc/1jQ5d2egMqXbqK4sm9zg0PLmnAHVkNK50ZvULbzpxw0HQzoJprvpqOyOS+nEh1Nw25/uQpYwtll9kVlf5DP4X3OvSsbI9g7+Vhv5rBAW2pFRyWfDmDzNuNfmIKCMzGDTUqgBtgJxreqlEfkZzcrXtxMXXsqLjBtXe+C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLAFUd6DXgARALC7omnO2dd+gm/EUE3BwVOS4Jwkvew=;
 b=lBkQmmpLZd8wncf+mqZzdjpl6cWZra53qvx1w4gOf9to6OnhvDXjOT8Mqcil0XiAiMu8qWRwQxsvadXz31KlI0RcxxC1nI9GAbSmS1U8HgytRaVQUavRh8xniKlrvCUgXwmbVDK9K8J9sTYfW9UMKXvR4C0vBmCI5wG67EIfUlU=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:58:01 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::89) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:58:01 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:58 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 11/24] drm/amd/display: replace dio encoder access
Date: Fri, 21 Feb 2025 10:57:08 -0500
Message-ID: <20250221155721.1727682-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2788e7-5e31-4639-f12f-08dd529084f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hyv4dMc1cA43QAMqIm8cB7IzIy/mlaSU1Z3K1i4HHWJC48ZM3MFitEXsrgAZ?=
 =?us-ascii?Q?tSv0haMZObcZ96/SX/IUGrseogfrgwRO47qdt61NhVOezsXOlXApGwNtqr9t?=
 =?us-ascii?Q?q/TvyIjryN9FAUJcswBOEDhhnYefJ04n6lZl6qr0UrjMPkzjldLEKEulIAEl?=
 =?us-ascii?Q?BXhAjuKNJk4ug58VL4CZlNnXGCGpx1WC+W2MHC+oNdl1CMXQJzcnbAnDQCht?=
 =?us-ascii?Q?knDY29t7KslJ9oKrwoz88KDhfSpPaYOYZ9SHCXpGiGTm8PGh+bQJFHwV50E/?=
 =?us-ascii?Q?MKge+uASDhnNmJu+EQV6ekYtbR5eXHiI3r4yMcTA/JNAvsE2ro8JkjT+OY7v?=
 =?us-ascii?Q?6Hy25ghpGg+Gu2SeL3u+ZJC6p2ycWTgJQCbVblMyX/Qmxd8nqkjlBgxFLevx?=
 =?us-ascii?Q?DmFdZ7mT5NZ5awI9aySHjUHfKIkIAF2yTWc3L0CUQlU8vWlEuzA8zo8CRQHk?=
 =?us-ascii?Q?qFs1kRLX6cn6Sz5bVGb58tGwX3zQtWSppB+q2rCb1ky8Zs+VUEYje56+cAE0?=
 =?us-ascii?Q?X+oFag25xLwfKvuMCMyIwzCluZXXpIxlv+a9uOyVppRpvq0w9Wc8/XQ4t8Lo?=
 =?us-ascii?Q?k7FdMsRNdqFlYXbIAYeiQPq/GOY8Dr/mQG2sSRVBGQ/qpfnHZd1vMB+5ohuG?=
 =?us-ascii?Q?89UTYv57hcTDnfVxFTYmr5GUr7VAzuIeM/VTwRPjC+TztBjEhz1Sf4/PmUFL?=
 =?us-ascii?Q?4x/FJXz1trAEjUeAIPmtnuS+/3UqBI9TTLFQHGIFGXICzZSHMLxFPoTomIKP?=
 =?us-ascii?Q?7gB2Qf6hV3N5rJvMATeuSZUWQwsYZUktCVC5HTzzgrwZqMNzi+twA4qMmC27?=
 =?us-ascii?Q?fIz4plL6fHw7X9Mw9AxiDC15sz4auB4ujsiNEdWo1uItBIRmeaeT0VaNlD53?=
 =?us-ascii?Q?H+JefzFPLJOWjoLVZERCqJUqJwupZPwYvhojVf8TU01LRIXpu/nVWQMXwGnZ?=
 =?us-ascii?Q?F+RCKweeW4t2OTCC/X9KbqVBjumxYltUahpfDZvVmW+RGq78iBe0aQdrXkRj?=
 =?us-ascii?Q?u9JC5J48qqJzDgTMzaM5jHmqAACqGeMszY4x/GkRiPQaz2uU6kXN0mdQIaVu?=
 =?us-ascii?Q?ImI2niuSTz4HuEpypZZQ4aPPCpd2ZHspfDRob2RC3cgqPyW8fRCmgbAg1Clk?=
 =?us-ascii?Q?MwcrEIvMSMxhC4quvByaM9ATpX1jH3JFevPIKL/2CuOxDrLwP+jwvet9BWau?=
 =?us-ascii?Q?vfoogrHMm7lLStE+jh3gVbnl6zUlG/CaJCNRvbIMnUTJboeEtyj125xHQn7z?=
 =?us-ascii?Q?KO4F/NpObgY+JGxuj99ioGKVauXAGuF2q6qBtIeS1x4Bwgz3Ifzm0PXbN4fX?=
 =?us-ascii?Q?4oH0m/dOK6B47vO1rIg7ynv5i0PGxSRaqBe6Iy4NKIzvgO6j0mnGECVHWOCt?=
 =?us-ascii?Q?Q8V+6wrVsk+B58GK2bSONoWSSrjxdj0rKRhiG2qr+1wlJufOnnaPEfWE+eLp?=
 =?us-ascii?Q?IL6WYvsmvfRVGhNiCsN5WB4L95oNKH2DKf2RBtdRJl0xcaiaTO0daUteNoSv?=
 =?us-ascii?Q?MF48avdO6vcImz4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:58:01.5176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2788e7-5e31-4639-f12f-08dd529084f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
replace dio encoder access to work with new dio encoder
assignment.

[HOW}
1. before validation, access dio encoder by get_temp_dio_link_enc()
2. after validation, access dio encoder through pipe_ctx->link_res

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  5 ++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  | 66 ++++++++++++++++---
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |  5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 20 ++++--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 15 +++--
 .../dc/link/protocols/link_dp_capability.c    | 21 ++++--
 .../dc/link/protocols/link_dp_capability.h    |  1 +
 .../display/dc/link/protocols/link_dp_phy.c   | 16 +++--
 .../display/dc/link/protocols/link_dp_phy.h   |  3 +-
 .../dc/link/protocols/link_dp_training.c      | 20 ++++--
 .../dc/link/protocols/link_dp_training.h      |  2 +
 .../protocols/link_dp_training_128b_132b.c    |  4 +-
 .../protocols/link_dp_training_128b_132b.h    |  1 +
 .../link/protocols/link_dp_training_8b_10b.c  |  5 +-
 .../link/protocols/link_dp_training_8b_10b.h  |  3 +-
 .../link/protocols/link_dp_training_auxless.c |  1 +
 .../dc/link/protocols/link_dp_training_dpia.c |  1 +
 .../dc/resource/dcn20/dcn20_resource.c        |  5 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  5 +-
 23 files changed, 161 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7eb91612b60d..0bd3e7c072a1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5191,7 +5191,7 @@ void get_audio_check(struct audio_info *aud_modes,
 	}
 }
 
-static struct link_encoder *get_temp_dio_link_enc(
+struct link_encoder *get_temp_dio_link_enc(
 		const struct resource_context *res_ctx,
 		const struct resource_pool *const pool,
 		const struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 8280e3652171..9c9947fc5d44 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1153,9 +1153,12 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->stop_hdmi_info_packets(
 			pipe_ctx->stream_res.stream_enc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b158eb1045a1..a5a3e0823e21 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3020,9 +3020,12 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	enum phyd32clk_clock_source phyd32clk;
 	int dp_hpo_inst;
 
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		dto_params.otg_inst = tg->inst;
 		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c4a37a95e812..39668d8cc13a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -927,9 +927,12 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 	int dp_hpo_inst = 0;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
 	dcn401_enable_stream_calc(pipe_ctx, &dp_hpo_inst, &phyd32clk,
 				&tmds_div, &early_control);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 042e04f924a2..9458187b834d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -647,4 +647,9 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 int resource_calculate_det_for_stream(struct dc_state *state, struct pipe_ctx *otg_master);
 
 bool resource_is_hpo_acquired(struct dc_state *context);
+
+struct link_encoder *get_temp_dio_link_enc(
+		const struct resource_context *res_ctx,
+		const struct resource_pool *const pool,
+		const struct dc_link *link);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 06faa461067b..4a3578a9586e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -48,9 +48,16 @@ void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 
 void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
+	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
+
 	link_enc->funcs->connect_dig_be_to_fe(link_enc,
 			pipe_ctx->stream_res.stream_enc->id, true);
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
@@ -71,9 +78,16 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 
 void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
+	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
+
 	if (!stream_enc)
 		return;
 
@@ -142,7 +156,14 @@ void enable_dio_dp_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
 
 	if (dc_is_dp_sst_signal(signal))
 		link_enc->funcs->enable_dp_output(
@@ -162,11 +183,16 @@ void disable_dio_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
 
-	if (link_enc != NULL)
-		link_enc->funcs->disable_output(link_enc, signal);
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
 
+	link_enc->funcs->disable_output(link_enc, signal);
 	link->dc->link_srv->dp_trace_source_sequence(link,
 			DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
@@ -175,7 +201,14 @@ void set_dio_dp_link_test_pattern(struct dc_link *link,
 		const struct link_resource *link_res,
 		struct encoder_set_dp_phy_pattern_param *tp_params)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
 
 	link_enc->funcs->dp_set_phy_pattern(link_enc, tp_params);
 	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
@@ -186,7 +219,14 @@ void set_dio_dp_lane_settings(struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
 
 	link_enc->funcs->dp_set_lane_settings(link_enc, link_settings, lane_settings);
 }
@@ -195,9 +235,15 @@ void update_dio_stream_allocation_table(struct dc_link *link,
 		const struct link_resource *link_res,
 		const struct link_mst_stream_allocation_table *table)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link_enc) {
+		ASSERT(link_enc);
+		return;
+	}
 
-	ASSERT(link_enc);
 	link_enc->funcs->update_mst_stream_allocation_table(link_enc, table);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
index a6d1d7641ab4..e1dff4e3f446 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
@@ -127,7 +127,10 @@ static void set_dio_fixed_vs_pe_retimer_dp_link_test_pattern(struct dc_link *lin
 		const struct link_resource *link_res,
 		struct encoder_set_dp_phy_pattern_param *tp_params)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (!set_dio_fixed_vs_pe_retimer_dp_link_test_pattern_override(
 			link, link_res, tp_params, get_dio_link_hwss())) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 36adf95744fe..81d5085e322f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -35,12 +35,15 @@ static void update_dpia_stream_allocation_table(struct dc_link *link,
 		const struct link_resource *link_res,
 		const struct link_mst_stream_allocation_table *table)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
 	static enum dc_status status;
 	uint8_t mst_alloc_slots = 0, prev_mst_slots_in_use = 0xFF;
 	int i;
 	DC_LOGGER_INIT(link->ctx->logger);
 
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
 	for (i = 0; i < table->stream_count; i++)
 		mst_alloc_slots += table->stream_allocations[i].slot_count;
 
@@ -61,7 +64,10 @@ static void set_dio_dpia_link_test_pattern(struct dc_link *link,
 	if (tp_params->dp_phy_pattern != DP_TEST_PATTERN_VIDEO_MODE)
 		return;
 
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (!link_enc)
 		return;
@@ -83,7 +89,10 @@ static void enable_dpia_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (link_enc != NULL) {
 		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->enable_dpia_output) {
@@ -119,7 +128,10 @@ static void disable_dpia_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+	struct link_encoder *link_enc = link_res->dio_link_enc;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (link_enc != NULL) {
 		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->disable_dpia_output) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index ec7de9c01fab..321fd1785370 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -652,15 +652,15 @@ static void write_i2c_redriver_setting(
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
-	struct link_encoder *link_enc = NULL;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct cp_psp_stream_config config = {0};
 	enum dp_panel_mode panel_mode =
 			dp_get_panel_mode(pipe_ctx->stream->link);
 
 	if (cp_psp == NULL || cp_psp->funcs.update_stream_config == NULL)
 		return;
-
-	link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	ASSERT(link_enc);
 	if (link_enc == NULL)
 		return;
@@ -1924,7 +1924,7 @@ static void disable_link_dp(struct dc_link *link,
 
 	if (link_dp_get_encoding_format(&link_settings) ==
 			DP_8b_10b_ENCODING) {
-		dp_set_fec_enable(link, false);
+		dp_set_fec_enable(link, link_res, false);
 		dp_set_fec_ready(link, link_res, false);
 	}
 }
@@ -2122,7 +2122,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		fec_enable = true;
 
 	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
-		dp_set_fec_enable(link, fec_enable);
+		dp_set_fec_enable(link, &pipe_ctx->link_res, fec_enable);
 
 	// during mode set we do DP_SET_POWER off then on, aux writes are lost
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
@@ -2461,7 +2461,7 @@ void link_set_dpms_on(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->sink->link;
 	enum dc_status status;
-	struct link_encoder *link_enc;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
@@ -2486,7 +2486,8 @@ void link_set_dpms_on(
 		}
 	}
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index e3e7fcb07f19..f6e0868507f7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -330,9 +330,12 @@ bool dp_is_fec_supported(const struct dc_link *link)
 	/* TODO - use asic cap instead of link_enc->features
 	 * we no longer know which link enc to use for this link before commit
 	 */
-	struct link_encoder *link_enc = NULL;
+	struct resource_context *res_ctx = &link->dc->current_state->res_ctx;
+	struct resource_pool *res_pool = link->dc->res_pool;
+	struct link_encoder *link_enc = get_temp_dio_link_enc(res_ctx, res_pool, link);
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	return (dc_is_dp_signal(link->connector_signal) && link_enc &&
@@ -2093,14 +2096,17 @@ void detect_edp_sink_caps(struct dc_link *link)
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
 {
-	struct link_encoder *link_enc = NULL;
+	struct resource_context *res_ctx = &link->dc->current_state->res_ctx;
+	struct resource_pool *res_pool = link->dc->res_pool;
+	struct link_encoder *link_enc = get_temp_dio_link_enc(res_ctx, res_pool, link);
 
 	if (!max_link_enc_cap) {
 		DC_LOG_ERROR("%s: Could not return max link encoder caps", __func__);
 		return false;
 	}
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (link_enc && link_enc->funcs->get_max_link_cap) {
@@ -2128,10 +2134,13 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	struct dc_link_settings max_link_cap = {0};
 	enum dc_link_rate lttpr_max_link_rate;
 	enum dc_link_rate cable_max_link_rate;
-	struct link_encoder *link_enc = NULL;
+	struct resource_context *res_ctx = &link->dc->current_state->res_ctx;
+	struct resource_pool *res_pool = link->dc->res_pool;
+	struct link_encoder *link_enc = get_temp_dio_link_enc(res_ctx, res_pool, link);
 	bool is_uhbr13_5_supported = true;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	/* get max link encoder capability */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 8f0ce97f2362..0ce0af3ddbeb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -67,6 +67,7 @@ bool dp_is_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 /* Initialize output parameter lt_settings. */
 void dp_decide_training_settings(
 	struct dc_link *link,
+	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting,
 	struct link_training_settings *lt_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index c27ffec5d84f..49521ac4b0e8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -142,11 +142,12 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	 * if the sink supports it and leave it enabled on link.
 	 * If FEC is not supported, disable it.
 	 */
-	struct link_encoder *link_enc = NULL;
+	struct link_encoder *link_enc = link_res->dio_link_enc;
 	enum dc_status status = DC_OK;
 	uint8_t fec_config = 0;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 	if (link_enc->funcs->fec_set_ready == NULL)
 		return DC_NOT_SUPPORTED;
@@ -176,13 +177,14 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	return status;
 }
 
-void dp_set_fec_enable(struct dc_link *link, bool enable)
+void dp_set_fec_enable(struct dc_link *link, const struct link_resource *link_res, bool enable)
 {
-	struct link_encoder *link_enc = NULL;
+	struct link_encoder *link_enc = link_res->dio_link_enc;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
-	if (link_enc->funcs->fec_set_enable == NULL)
+	if (!link->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (link_enc == NULL || link_enc->funcs == NULL || link_enc->funcs->fec_set_enable == NULL)
 		return;
 
 	if (enable && dp_should_enable_fec(link)) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
index 1eb0619d6710..ab1c1f8f1f8b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
@@ -52,7 +52,8 @@ void dp_set_drive_settings(
 enum dc_status dp_set_fec_ready(struct dc_link *link,
 		const struct link_resource *link_res, bool ready);
 
-void dp_set_fec_enable(struct dc_link *link, bool enable);
+void dp_set_fec_enable(struct dc_link *link,
+		const struct link_resource *link_res, bool enable);
 
 void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 751c18e592ea..40ac17ba9479 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -801,19 +801,23 @@ enum dc_dp_training_pattern decide_cr_training_pattern(
 }
 
 enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings)
 {
-	struct link_encoder *link_enc;
+	struct link_encoder *link_enc = link_res->dio_link_enc;
 	struct encoder_feature_support *enc_caps;
 	struct dpcd_caps *rx_caps = &link->dpcd_caps;
 	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_2;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
-	enc_caps = &link_enc->features;
-
 	switch (link_dp_get_encoding_format(link_settings)) {
 	case DP_8b_10b_ENCODING:
+		if (!link->dc->config.unify_link_enc_assignment)
+			link_enc = link_enc_cfg_get_link_enc(link);
+
+		if (!link_enc)
+			break;
+
+		enc_caps = &link_enc->features;
 		if (enc_caps->flags.bits.IS_TPS4_CAPABLE &&
 				rx_caps->max_down_spread.bits.TPS4_SUPPORTED)
 			pattern = DP_TRAINING_PATTERN_SEQUENCE_4;
@@ -886,13 +890,14 @@ void dp_decide_lane_settings(
 
 void dp_decide_training_settings(
 		struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		struct link_training_settings *lt_settings)
 {
 	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
-		decide_8b_10b_training_settings(link, link_settings, lt_settings);
+		decide_8b_10b_training_settings(link, link_res, link_settings, lt_settings);
 	else if (link_dp_get_encoding_format(link_settings) == DP_128b_132b_ENCODING)
-		decide_128b_132b_training_settings(link, link_settings, lt_settings);
+		decide_128b_132b_training_settings(link, link_res, link_settings, lt_settings);
 }
 
 
@@ -1556,6 +1561,7 @@ enum link_training_result dp_perform_link_training(
 	/* decide training settings */
 	dp_decide_training_settings(
 			link,
+			link_res,
 			link_settings,
 			&lt_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index 0b18aa35c33c..574b083e0936 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -104,6 +104,7 @@ void start_clock_recovery_pattern_early(struct dc_link *link,
 
 void dp_decide_training_settings(
 		struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		struct link_training_settings *lt_settings);
 
@@ -117,6 +118,7 @@ enum dc_dp_training_pattern decide_cr_training_pattern(
 		const struct dc_link_settings *link_settings);
 
 enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings);
 
 enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index db87cfe37b5c..11565f187ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -204,6 +204,7 @@ enum link_training_result dp_perform_128b_132b_link_training(
 		struct link_training_settings legacy_settings;
 
 		decide_8b_10b_training_settings(link,
+				link_res,
 				&lt_settings->link_settings,
 				&legacy_settings);
 		return dp_perform_8b_10b_link_training(link, link_res, &legacy_settings);
@@ -227,6 +228,7 @@ enum link_training_result dp_perform_128b_132b_link_training(
 }
 
 void decide_128b_132b_training_settings(struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		struct link_training_settings *lt_settings)
 {
@@ -238,7 +240,7 @@ void decide_128b_132b_training_settings(struct dc_link *link,
 			LINK_SPREAD_05_DOWNSPREAD_30KHZ;
 
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_settings);
-	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_settings);
+	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_res, link_settings);
 	lt_settings->eq_pattern_time = 2500;
 	lt_settings->eq_wait_time_limit = 400000;
 	lt_settings->eq_loop_count_limit = 20;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.h
index 2147f24efc8b..901a42edafa1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.h
@@ -34,6 +34,7 @@ enum link_training_result dp_perform_128b_132b_link_training(
 		struct link_training_settings *lt_settings);
 
 void decide_128b_132b_training_settings(struct dc_link *link,
+		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		struct link_training_settings *lt_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index ae95ec48e572..34d2e097ca2e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -93,7 +93,8 @@ static uint32_t get_eq_training_aux_rd_interval(
 }
 
 void decide_8b_10b_training_settings(
-	 struct dc_link *link,
+	struct dc_link *link,
+	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting,
 	struct link_training_settings *lt_settings)
 {
@@ -115,7 +116,7 @@ void decide_8b_10b_training_settings(
 			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
 	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
-	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
+	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_res, link_setting);
 	lt_settings->enhanced_framing = 1;
 	lt_settings->should_set_fec_ready = true;
 	lt_settings->disallow_per_lane_settings = true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.h
index d26de15ce954..ea0de701d83f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.h
@@ -54,7 +54,8 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link);
 
 void decide_8b_10b_training_settings(
-	 struct dc_link *link,
+	struct dc_link *link,
+	const struct link_resource *link_res,
 	const struct dc_link_settings *link_setting,
 	struct link_training_settings *lt_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
index 4c6b886a9da8..f99d26290bc0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_auxless.c
@@ -39,6 +39,7 @@ bool dp_perform_link_training_skip_aux(
 
 	dp_decide_training_settings(
 			link,
+			link_res,
 			link_setting,
 			&lt_settings);
 	override_training_settings(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 39e4b7dc9588..6e2d08cfc546 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -110,6 +110,7 @@ static enum link_training_result dpia_configure_link(
 
 	dp_decide_training_settings(
 		link,
+		link_res,
 		link_setting,
 		lt_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 5c6dc710e96c..e4eca3e32c1b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1220,7 +1220,7 @@ static void get_pixel_clock_parameters(
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 	struct dc_link *link = stream->link;
-	struct link_encoder *link_enc = NULL;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dce_hwseq *hws = dc->hwseq;
 
@@ -1229,7 +1229,8 @@ static void get_pixel_clock_parameters(
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	if (link_enc)
 		pixel_clk_params->encoder_object_id = link_enc->id;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 4e842f29d4c4..7436dfbdf927 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1666,12 +1666,13 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct link_encoder *link_enc = NULL;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct pixel_clk_params *pixel_clk_params = &pipe_ctx->stream_res.pix_clk_params;
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
-	link_enc = link_enc_cfg_get_link_enc(link);
+	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
 	if (link_enc)
 		pixel_clk_params->encoder_object_id = link_enc->id;
 
-- 
2.34.1

