Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C02C5B552
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134EE10E7DA;
	Wed,  4 Jun 2025 19:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HzhgDaC4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8865D10E7DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmk2yCgxyZGAkU8MKBkjytarFmElq4uD0pNEdPtfIp3Q0XhQUUISUXXEnfTSlA736H/YtbCSBKR9FtwpDsCLRJw799QtpRBrUkl7e0su0OU8yYR51XKFSvGxymCNJbq5j3n/O27MJEUGNmartVZMtd+/a3BoL4pZMyLNsNDGGRRMRzTfU+OJLrzVtHcr4Rw2T+HPjhEv3z5/YDDErvq8h6gZYC00mjJucNO097PecIfZcqROeVQKmAmqY1wtjALwqsh9CzbJwAlZRPNrZsUy+vuCgK253W53cnjlswwhtEyZXXN69yChH8ANZUP2O1ozBMrpNtL58BaPKy6/Y/acQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmyNMKET607R8vi2fEeMaD+DwKibUgQR6sIsM2Q767Y=;
 b=UGblsD4ens8+9yMHNm8HDjjDNa2BYnjXiKb1+4aA+UiHpr5pcBpMcMw8WtPyAywP68Wiou5OpfwWIORWVQUkBO9W5x5FOsGV1b66/Q5ZKQz4Mls0sQEzsZyMBPhafikjFNyywmzo8SliN7zNuCZw1IIwvG8Uolje8vLpr9+qfA/p2R9VfXm5McbcXiUPyKnPkYAZKyfyjzQGVaFI4CGuipFj/7Wf+0PcJXzGdsgeyfHK9BZBeX40Gooh84aBKO8zfEJ7eDgtkyTmpfKiBJEUpfCo/h82gUCYTI0aFAidOBGxTOzuBzxNH9fFGLbdMetR1XcEHmi+clkICmTKDMWANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmyNMKET607R8vi2fEeMaD+DwKibUgQR6sIsM2Q767Y=;
 b=HzhgDaC4+xUUi+7V89nWUO06lsCCYgN5BYI1hntJXRRUfX6jDPq868mV3ayhyBTfN/nUdpL8GkcFUGHtMS8zJaCSqV/Rr6R9IxsEEfH8c1qZ5cZuBI5GjaY7pzR6NNJnSBdCKFbAnAaWcp2dCq21N6yAjyQ0x7/ndw9XyezPXOQ=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:40:16 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::35) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:40:15 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:40:13 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ausef Yousof
 <Ausef.Yousof@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH 13/23] drm/amd/display: Don't disable dtb as dto src during
 dpms off
Date: Wed, 4 Jun 2025 12:43:24 -0600
Message-ID: <20250604193659.2462225-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c6f1c4-d944-4c94-854e-08dda39fa15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fufMP6cVmIrrqNDY0WI3ZpvaTvXzo61/TwrEgVAabQHU18bGm4n2VqxPj8Cd?=
 =?us-ascii?Q?lXIwXYgs5uz+CoHYXZdZnZ3oQ8dPBPoJsA7fqR8JNx45h6aVc3Wn8fskSvrl?=
 =?us-ascii?Q?/5oPYGybfQcMjKQ2k0Uo1bQerHYoviSan426mJhjOJEycx9ostRsSsrqMuOc?=
 =?us-ascii?Q?Xojpe7oI+EndkivHodB81njSkWuBkADPAjhxv/AFpycCgsUwbsrlEhaIkVVg?=
 =?us-ascii?Q?Y21xFId8cqXucTNbcCkirsHK6l7id3wg/LlgszRzvuMRB5mc5va7huz76uxr?=
 =?us-ascii?Q?AIXmhA2pSDC71yPemwc7MJuOhFNSBfTdxAIoNtlcvxpaJIhHsBxpgF2fZadf?=
 =?us-ascii?Q?P9A2X/mtxoNDtBVmswdk6ppPLlYtHjNDrneka5ey7WQCwl+lSQ97TgnV/avO?=
 =?us-ascii?Q?nb4WX46g9jojGDtHWR1P10oOLfhNFqYfMna2dGEJE+UZF1n0rqR/SnB7wTlg?=
 =?us-ascii?Q?ReGuGkkybOME3iW2Blnc/K9qdJaYdt0FfgoQz+s/g+W6oIWAc+N+MP86tRPI?=
 =?us-ascii?Q?vjbhiGmcmdPGt26uJVFQAEdUDcu2BsmTFxdfD/FLdAylwem/xss9ZlvQZUyH?=
 =?us-ascii?Q?gnSGb32ZhWRyOMMcB6mjpOjwUeNrj7p2CLQJpv9nFuh9ojdB+jIDAXpdB+eh?=
 =?us-ascii?Q?xSBXOXSF1OXVFjS09Zo/DeihNGregRyNq4ZdsKCLUAwuRODdl7RW3dMJXQm/?=
 =?us-ascii?Q?5RA3jCEATB0t4uK9Wegha5s0VuxaxGMtJvdRj55LPxdaQG7GvK3cKqacveg9?=
 =?us-ascii?Q?Bw7TsNWpb3ghj4Hqu8ELGi4Oc+B8JnlfyQoNY70vNQ0gCkipYFoCNGeEs2VF?=
 =?us-ascii?Q?ZPNKikBO57TX4KdNNsjxyUTqg9V9ycqC8iTyJEtG8iQXRBakM0qmJnNQBxbN?=
 =?us-ascii?Q?RY0CKOtPl++jAAzj+DkrjdTk6M0/d3Cg5EEoiK7Szmv3jHhIYbiRhLXNKN+c?=
 =?us-ascii?Q?WpNifwisuSfnPuBRqEPUDssJVAdl+tL3l43/OVMY1SaoF3FVZqDouaseUsdJ?=
 =?us-ascii?Q?4gSrxbkunD2O1XoIysTAapa6/If7iLMjHFSUEKWzYOd5LEGHySIgR6Jm7+0Q?=
 =?us-ascii?Q?EZgBiOS6xarYKE+5bhXIfHATQ7bJFb6zDp/BNY4Se7BmPbJ5Mk4icEo5UuBH?=
 =?us-ascii?Q?FdvpUr9/cnwbUXbufWLJYo7Uy5KgsrVA8U0cSjaZYT5S7/QcaFz4Ld3knYaG?=
 =?us-ascii?Q?En5W0MpNvrfkdImWbS4mjMX7gi97mpeJQA3fGqa7gOs0u0HJ3Gmp/oitr9p2?=
 =?us-ascii?Q?RX5cXBrjgClic8/UQNJjeW6ekdpdBOi9mqRk4QgDoTU1edeH/0CbPXrcWYsN?=
 =?us-ascii?Q?YDGGz6gyQmqpy+pSLOhNaFcNw0n+kUMJmJMzJtouUOpCUtNDWxbXb911L38y?=
 =?us-ascii?Q?TjQiyJ0bLomOpygd8nwRT41RIudX+lTTe21IyDSF2OPFdMn+VYOqUbK2hQw+?=
 =?us-ascii?Q?wvL5PTLHu24plhPaXBpwiHOtOjzyX+OgdBIf2c9UxWSns6r4tWEwsikn9zoK?=
 =?us-ascii?Q?NEoDbw1/iI1qf9GOaYT0w+jGIpYQesdll/mw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:40:15.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c6f1c4-d944-4c94-854e-08dda39fa15f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[WHY & HOW]
Adjusting otg dto programming in this path is unsafe otg may be en at
this time, swapping its src sel for example was discovered to cause
visual artifacts and was moved to dcn31_program_pix_clk (where otg is
guaranteed off) but dto functional clk enable bit is not cleared.

dcn31_program_pix_clk is called during dpms on, so until that point
we will have a otg with functional src sel set (Sel DTBclk) and that
functional clk dto en is unset (i.e DTB DTO EN), which is invalid and tg
will not function and system will hang on something such as flip
incoming from OS during dpms off. will scope out dcn315 as it was
affecting diags tests on certain CI machines (not crbs)

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 6 ++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e8730cc40edb..a9a3001109c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1186,8 +1186,10 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			if (dccg && dccg->funcs->set_dtbclk_dto)
-				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			if (dc->ctx->dce_version == DCN_VERSION_3_15) {
+				if (dccg && dccg->funcs->set_dtbclk_dto)
+					dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			}
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 486f7b723ceb..bc06b7b3d67d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2808,6 +2808,8 @@ void dcn20_reset_back_end_for_pipe(
 {
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct dtbclk_dto_params dto_params = {0};
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
@@ -2868,6 +2870,13 @@ void dcn20_reset_back_end_for_pipe(
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
 			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 		}
+		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg
+			&& dc->ctx->dce_version != DCN_VERSION_3_15) {
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.timing = &pipe_ctx->stream->timing;
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		}
 	}
 
 /*
-- 
2.43.0

