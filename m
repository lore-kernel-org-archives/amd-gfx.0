Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A41C369B9
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1AD10E7D6;
	Tue, 15 Apr 2025 15:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xdsqFA4V";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5312510E7D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOGGSdwirQEI1EXnh6WIeP/ZzdrInKOM6oNwM0KXJ9YNE/+wH/aDW/9Mp4xt5vxe54A7vfoSPW/IWkKwrUeFt0PFBePz4RFKt3y/+NbkHthHLP5CsBO2vcs/jwJWzCEsKHblU6UYrGe8Kal6DLnfhR6oKmFgAvbFJm1P1/lk97keG8G1gz0cMKVen5EDXKNkV3+UDW/D7E1bT43fVi5NZAopBLrRJuxgx2NOaJjc0TkDoCylyTCmYh8I1Ixb7TA4weoU98fyvNswfauBIHRts+S3+VvtEVAw1yPPfDySJrWQiHfnBlsWjftHCOaR80UiM0H3nh7nP3DBHkxfnFC2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BLRyDPVdVjfhxYWg/F3117pPH+wnhN+sSRjA8OsHQk=;
 b=Oek57yvyOycGx6GzLySKmWjWfl0wAZV2PrxRsbT9rCv/MUMwDlgh4zAQF1x2e27cuuZocQrBQglgl/RQEtpNSqTxoip0FD8c+ce/v/5J0yXX/bksASvXqO+A5xmm5obMFyvaQPJHyCYOg1ECSV4i6tjBbTLxpEWGiL/PdSfwdtSCTw54NP7pg8vQKI7LhAgwmA+rWuSyJJocUohkE+5yhNDzo4nmx7PJo2Zep4hdOQtHPIr1DICGOoAHSNdyc9TpdUSEcrDBE019eJ0fiAkDGrBSRGB4h49eIMB2rN+gh0jTo10fvLzIY8X3AzL1asQs1G2crmI7NfnB/fJ9Wx/Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BLRyDPVdVjfhxYWg/F3117pPH+wnhN+sSRjA8OsHQk=;
 b=xdsqFA4VLl/uNJDB/PDks6j5XlfhKj1Xhfu4pm1KU3aqbEwHFE6OTs044xtxWzKU9zKqW4nhfitKkLNrjxna8YhGWOTI5JTOVao6z3Uoak5ytaoLsB1j0cShbEngwk0MZ+QJApA3825CcjURtZm82JX0XREL0wZTU7+7rFVMPOI=
Received: from SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21) by
 MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 15 Apr
 2025 14:59:59 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::14) by SN6PR01CA0008.outlook.office365.com
 (2603:10b6:805:b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 15:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:59 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:57 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Charlene
 Liu <Charlene.Liu@amd.com>, Gabe Teeger <gabe.teeger@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Revert "not disable dtb as dto src at
 dpms off"
Date: Tue, 15 Apr 2025 10:59:02 -0400
Message-ID: <20250415145908.3790253-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e36695-1707-44d6-e0da-08dd7c2e318a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Y1dkTAZGg2r7KbxAf2/qOrhXVlmF1QXorc6H0Q3537D0WQROC6LTUea5EcK?=
 =?us-ascii?Q?uXGTzRBTqBuEBQgQ6rgTk27T0YrAdsOF6xVUvhpVIlKAfaZ4uAVBJ4KxWdvA?=
 =?us-ascii?Q?8w/ab/Y+n37DI0NyNsOcjFkkgCr8KkSan9bUbdDtlYAQN1psl7wbhmLxRyMR?=
 =?us-ascii?Q?oWQWLoE8lA+Fg3HQYfXHnK4RwBwCLaTyZn3d0Bd1/b+M0yw/7WIzU3HaS2kr?=
 =?us-ascii?Q?gbdJfHIiWRatux0NLR57hWD4mjZimSxMZS7pG8NuoKjpPONjby9kq2W3WaQ5?=
 =?us-ascii?Q?19VN4DHxhtWKArNOZHbfV6ZSoCwtShOrrFvKFeM30r4l/iohdzOwiosFUx30?=
 =?us-ascii?Q?Gh+DUil+gmV7gr8493jq5LvegFZMj2UIx5zzgFsF2Q6yko5y4LRpGc3ov+vE?=
 =?us-ascii?Q?3mbVD1iBXsEEkPLMtmLaRK+mfjFatq0mnh7v5aaGZLX/JGY0+gN7kOtzum8s?=
 =?us-ascii?Q?88Hzt7XqaFs4tfn3M43FYz+Zb2swCxobsmpgD0kLsG23rD2R2BYFNShj67Y2?=
 =?us-ascii?Q?TXrJCrwUydzCs2RNcmj41Fk19900ewkbz/zBfqgPw8QIW4S3wVVduk+yFueJ?=
 =?us-ascii?Q?N03I2SWxwLmDqmeZs6cVwCD+b5/TTipRtFGqcJl/KxXg6MlGzEoATf8j2LgR?=
 =?us-ascii?Q?PdCr/QAKJyKv4nET1fhxp757D0zPCXscI0tOUzhYzdDQwb74/b7hfJUlLJ3R?=
 =?us-ascii?Q?VPZwS/VlmJ+Fk9E34izeSAmxEdiOV0Js+IjTIM7a99hg/eLuZ+DvQ+LWHAAk?=
 =?us-ascii?Q?zZ7bDOVbeVVaQjhBN+1za62zgDfKs1bmjGEPW2w7hjWsJ9dJrcJzX8htN4iW?=
 =?us-ascii?Q?JFkleQtWw7l3hdedhEdv5Tc/HCepQ3QKcXoUPQw90xjzB9di3RAXLvJLEsK8?=
 =?us-ascii?Q?e5C62UA7viSS8yHCRDsk/h4aGtuQVNmugfIPgz1o+5um1Nx6Qhcp3lztnfYa?=
 =?us-ascii?Q?tNlFEkAMLQ7gxMvegPZ1Qqz6fcDDbC1MVV5WLdnpwhwF8cBduvO8bvM2L1M4?=
 =?us-ascii?Q?3LHDcqFR6czAiW7XF/qJTbC7+GxSbEftSk9ulrSwM1qv4UFVjkJkuVnzcYQr?=
 =?us-ascii?Q?EOaEztWnBIOydFXeIHY8eZJqr4D4tg5iu36o61EF0h5qUKEdlYXaukWXJ2lt?=
 =?us-ascii?Q?d/GlAwAaufqZMxOU/G5mEfe7iNQqu+q1FIBoFBH7BFrgbFRQCX5o+uLyChq1?=
 =?us-ascii?Q?7MDFq2+zRDVMSxUOmy28TDXQ2GCd28KHPo/Gu3rTFDVeAzzYYwhPPhQZm2oy?=
 =?us-ascii?Q?u3UBkgIFtqakbwzUGO5KZcYYUKBMi2yvqBrSXu0qVGPuP9JquRmlFlPol0wm?=
 =?us-ascii?Q?Be7ydoQ1fkTEeUmY7wzPEygGuIDsyu2/qYwdB0QaKxHddGi1UDeLEcPOUKC1?=
 =?us-ascii?Q?g852nTEzERQc3tN2mUqOnojUOVrTq3ro18mlgVhlWuC6MECw39fD+zqLIZvr?=
 =?us-ascii?Q?NrGHsiKi41VO9GUf56CxlitUauGVke5MVmW3jF+KZLzwT2Oy0SvUbs2L6Whq?=
 =?us-ascii?Q?y1X+3mIspLYaGYrLrCqcQHGQGsmt54yZHRSn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:59.7378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e36695-1707-44d6-e0da-08dd7c2e318a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
not all the asic using the same code path.
need to revisit and limit the impact.

This reverts commit 075634792e54ef201cbbdf0422c077b8724b907.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 6fe26094addd..23bec5d25ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1152,6 +1152,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
@@ -1178,10 +1179,14 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
+		dto_params.otg_inst = tg->inst;
+		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 959cd2fbb250..846c9c51f2d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2806,8 +2806,6 @@ void dcn20_reset_back_end_for_pipe(
 {
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
-	struct dccg *dccg = dc->res_pool->dccg;
-	struct dtbclk_dto_params dto_params = {0};
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
@@ -2868,12 +2866,6 @@ void dcn20_reset_back_end_for_pipe(
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
 			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 		}
-		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
-			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
-			dto_params.timing = &pipe_ctx->stream->timing;
-			if (dccg && dccg->funcs->set_dtbclk_dto)
-				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-		}
 	}
 
 /*
-- 
2.34.1

