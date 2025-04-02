Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F4BC3601C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C3210E82D;
	Wed,  2 Apr 2025 16:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCTMUQch";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6F710E829
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l14hBgps+cY2FxrM6D97I5QcQNiOBTQZbyi1XpJ5XSpJfEmKhCqsIpt7qX0ZeDWaAiU3mTqEdS8nNtX78ZBUBznGUw7IWyKY9xSvfqS07HGQLGV0JpIG7Y6Gr7YaTQ9olRjMv9uca5tlQmUPGspME29QnAFhTMSl8gmPPzrOzpTECAeEoVIrAy8ZyRqPkF1YCzWxmPepZg6oji11YXnFlpARz8Ws0mTb8ALDOXhfQT+7+XAYfTidbjSf+/D2l+HuEN1hViywG/5lm05ChzbWdP9gZNwGkbxVzV7QV3l2hqRPZmn1DY3YsrQ6b81QUf0A8Tyz4lUsyY88NNrxCM57kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBgKyW2d/0nCLB4oqUCXbbawNiP4doHysf8CDaV1lLk=;
 b=BnLfbhvoX0x6MNmeChNpVZpyd2W3P9/83fj7q0XXyXvTlzIRYmpu/aE+9TI9i9hRAkYmVJ5UT6jqHqnXEDKmLa9KcnJFgBCICA9lINGpN/YjCch10WRAx0w3Mr3kvIQ+qNblotewbv5VyC/rqYTV36beh0/ocvDPu+A41UxeXloGJiJFAf8ofcgMRJw++iWqAuoXZ8FP2twq30yIf7sAJbmjHBNVIdWR7e/rqmP/EMQx0OUr4S1pUhtE7W64o1PvdQYKPP017vdY/Mhmc2UDb8kkeZ1cvsSqw1DC2GL/CJR7faepkq32IB99pS1Jwjgvuk5PIEwb0o8piPuEs5Pebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBgKyW2d/0nCLB4oqUCXbbawNiP4doHysf8CDaV1lLk=;
 b=iCTMUQchm4b6IaXO3l6t1gWvtOq7GeHf+GVfWUaW+3I6G7EWkpRUxpI7BfMSEHcqrReRIEUtaN4pREt2g3OwwjtsLFg4SoHfxfsDuZShG1wcRPcqmP6H6V8yuMfSwHedRZPaW807NK2f681hh6aKza01x2Qn+PPXTNnKy/497ck=
Received: from CH2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:610:4f::28)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 16:13:45 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::4e) by CH2PR18CA0018.outlook.office365.com
 (2603:10b6:610:4f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 16:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:43 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Yihan
 Zhu <yihan.zhu@amd.com>
Subject: [PATCH 10/16] drm/amd/display: dont disable dtb as dto src during
 dpms off
Date: Wed, 2 Apr 2025 12:13:14 -0400
Message-ID: <20250402161320.983072-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d08ea6-2ac2-4e89-8f5d-08dd720157cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gOytrfNX28hGSs6tzP+8Hfves0Bthz9VdKe9Kzz1AUf5wvvHhP52+rmdrFtJ?=
 =?us-ascii?Q?moZOWrrDC/S0b7+vZmCy6SM8iz9S81tsfsqj7Nq6FM1O3tEKn+gYW7F4gz13?=
 =?us-ascii?Q?Nxw/qkMNb/LbVvvaScUqCdFMTI+UwwQ1mv0Cbt9nMZNsIp13CSfbQ6lWQmZk?=
 =?us-ascii?Q?JY0CsefFwMMi8vCLj0ItsH8Y1CnHd0W7ERpUdblTI7UotuvrzIUW+1FkJqks?=
 =?us-ascii?Q?V3fL4mvs+Ui5e/cnj7fGfEhmMKQCaWRYcS06K9rZaqqczp5qzLZxANLXVe+K?=
 =?us-ascii?Q?1aTfJzvgKcuQ2szW081DUj9KY88kXKidhbNqH19Lxp6cTb7d8CsuT5TdvXsL?=
 =?us-ascii?Q?ABWZHSUqftP7BJih2IJ7RJ0TlVgnB1+z8NFagByKka3oa8n6myOULRKI7K7p?=
 =?us-ascii?Q?UIPsw493XgkplEV1mK4vm4Jh8SzAd7mBlvaqA5Gg0Sda/hwk4dFaw70GSm6z?=
 =?us-ascii?Q?mfgN08u6wvI1nMbJaD0e2a29i4y0/EWCuQs15RHlKxaGuAT6ecDBlfs7qdPU?=
 =?us-ascii?Q?Ag+cXC+/rNUvd8oeoKpgBXNedZkMqb+zAIYQYhCnYyXV8H0Y3lfZOHbSbumr?=
 =?us-ascii?Q?D0rGOB1m1YWC0dJqPxpK9dVAEOKPk3IuSYVMWKn1wsycudFcxFmtbY25K/Vd?=
 =?us-ascii?Q?MjKW0VX0w0WZynkFlE8hE3Hz0/5OOgfQtw/vRpRpX4pxbNapGTUPYAYKJJpk?=
 =?us-ascii?Q?bwmw6tPciYQJukgiCHQXx+S8+bDWMl1m8T3ietM1pglMiybXZzW65qhhp02f?=
 =?us-ascii?Q?RD7rRA6bGO2zXg1zz3QNz5DQQCUEhaER4NAQoM4rE9Jll4b0Z+nlpickmX+K?=
 =?us-ascii?Q?/Va8kNpFXvfcUlG7jPOMv0n/QMJ3LxC1QyPFytgFXiZThNAjTNYcCyxExd43?=
 =?us-ascii?Q?oxPNB4j403NwUerGHg3kfK8OqXOY/QaSkTWqXXk4oLVVkSTfKyk0D3+LiRoF?=
 =?us-ascii?Q?7+EAgJ9MRFJWyTzAtysOB8CPPo5f1doIVYBzBmlNSd/Kjxf2XV9/JheUFzBM?=
 =?us-ascii?Q?6nO3E69gUWwhKyTBhBkUaIci0HhmUo4YWWwJNaFBZ0bmGJfnvz7029pbUf7e?=
 =?us-ascii?Q?lXiVtyv4TV5Rz2owlU0lqtMZpVr2DuQSs1vzkHoJjNsngvlxb6v+wj1zcRAV?=
 =?us-ascii?Q?S8UsJ7rO6h0Rc1ZBT0GBT/dNND/zYvaezXo6cfXYcmsVkdwJj5SiItdF142Q?=
 =?us-ascii?Q?Q3uAYN9uW3Om3lBHaPjZFQ5Z7S0lNNWTOdMEY9QXjI1/cP+fjHJ7xX0VrtBe?=
 =?us-ascii?Q?PRa3Lr2elN58O3L6nuvy5Kay+dsZ6jWfxCB0NThpUcEmAZCykCif4/csAntC?=
 =?us-ascii?Q?6QA4m90Vk6UF4rlt74Y2jUxKFhGz+0HVueRvePGRY175FtJd20NfUa5X9xKg?=
 =?us-ascii?Q?4pyc4vtb2c63md0Y8VaP4DJXglpmeNO5IrEtnfqp7+hBKGeFJBOpRjnuB1Tq?=
 =?us-ascii?Q?lb570pkgocVtMSoQUfJREw/UtJX9h2VtYBJ6u/FrUG97RepP8msWOUjAb18V?=
 =?us-ascii?Q?cTnvfTyHIBFJGXU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:44.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d08ea6-2ac2-4e89-8f5d-08dd720157cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

fix was previously in 25.20 but was reverted out as it was accompanied
by other changes that caused regression.

[why&how]
Disabling dtb as the dto src during dpms off relies on in the same
instance being able to also alter the dto src bit to dpref (or not dtb
in general), but this was recently changed to only take place in
dcn31_program_pix_clk, as that is where we want to perform any dto src
changes because tg is off at that point, it is unsafe to do that
elsewhere. What this means is now instead of disabling dtb as dto src
and modifying source bit, we are left with the configuration for a given
tg that specifies dtb as dto src and dtb dto en simultaneously is unset.
dcn31_program_pix_clk can rectify this but its possible for us to
perform some tg dependant  operation that would simply hang because when
we go to enable say crtc then, the clk we specify as dto src is "off" en
bit is cleared, source bit was never changed, and program_pix_clk hasnt
been called yet (as apart of dpms on)

We cant disable it as dto src during dpms off if we want the luxury of
performing tg dependant operation during dpms off and before dpms on.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 -----
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5656d10368ad..778b68ec489e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1152,7 +1152,6 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
@@ -1179,14 +1178,10 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
-		dto_params.otg_inst = tg->inst;
-		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			if (dccg && dccg->funcs->set_dtbclk_dto)
-				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 846c9c51f2d9..959cd2fbb250 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2806,6 +2806,8 @@ void dcn20_reset_back_end_for_pipe(
 {
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct dtbclk_dto_params dto_params = {0};
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
@@ -2866,6 +2868,12 @@ void dcn20_reset_back_end_for_pipe(
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
 			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 		}
+		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.timing = &pipe_ctx->stream->timing;
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		}
 	}
 
 /*
-- 
2.34.1

