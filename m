Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEE5C4363D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C4520789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TmZSxkAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C4520789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D246B6E8D5;
	Wed,  7 Oct 2020 12:42:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77CF893D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRnyc7ItIlzSK2b9HcSBjglNT8I5gGGNEuY/6Geh+92LSjIG8on2jGRbcll9tvdm+EZwCRdechjU8jhJewVp7G3/I2yXJqQC4/fK9mmkm/epjoo2Vu5wTQibhvYpqjYavkoJaOKjs6Ev64Xge3nocLS1fR3mljaaoIeYkTvwPxo15+QpmUk3jwOE3A1RBeXQca50Jt+5XO7uFGCHkoBt1N0DbzQFoH3QTgJ321+nOrRVRxa89muB3PZYlZsA9t3hDrMZ36BFTHBxm1WT668b/W44Wum1WIABxnE0KaOcQTSXh7mAqpuWIHhyV9FnxhRcWf3vqKnPbYyEJEZOCnwzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smR9du/tdowfPUxeD2r73j6ctz6VGWzroCi2FtJiWv4=;
 b=mMWvrLJt+UeSPr0ki0kXEyzC/kJuVKdoD/mygu5g5XpnEdd2oI2u0CUB0ET1km4SIGNe/Il8E5ePz/zFhVwPZN4Ta5n+F0a0EuAiu4XGB9j8yTywal46tiSIfvjfH4N3BFgWYRtq34ABLNfwgEhSi/yP4ntUr286Tklp/AMVO7oG54n34bXT3W4a1l1twNGZcsgE5HI304bCDOZMXHJTbTias2ASEr8xM8IV4EZ0RgRD5Xlh5JVZEP3tVa8+KrxjN/MNXJAcWUdN1vzUFsWvy/VI5an7qnjnlsvcoyW+cVLEI8Sj2+z+kjst3ye2F63RohQ7CoqhEX9cyvVbyKU6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smR9du/tdowfPUxeD2r73j6ctz6VGWzroCi2FtJiWv4=;
 b=TmZSxkAbuUFyF6nMQfXn3acwlGvHSqAYorPQlVpxSSGM0rvE+BbSGNgKBW+F+pQKa/YV/W5sHFXsEttltHo4/tBR8CxcEtUDZMYHSDTZkcjntEkaD7VN8grF1lYn1CCEyuD2enXw2pPO9JYw6gKr5y0/JK2hoVUCBbNcNtsF8Wo=
Received: from DM5PR12CA0018.namprd12.prod.outlook.com (2603:10b6:4:1::28) by
 BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34; Wed, 7 Oct 2020 12:42:28 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::7a) by DM5PR12CA0018.outlook.office365.com
 (2603:10b6:4:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:27 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:27 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: add dcn21 bw validation
Date: Wed, 7 Oct 2020 08:42:15 -0400
Message-ID: <20201007124224.18789-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a20f215-447b-4fed-31d5-08d86abe7360
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1252BF00544A88E2F43CB3D98B0A0@BN6PR12MB1252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfpYuhCXecYglmln0IUYt7WuzUwK3ITgOMoJFIpS/hltVpG7bC7K+NS6Rgb02kPBreOFZLxd++YJ6v34bCXujGgXLiC54YllEiGv2GDg99mFwtBE7ZBphmCYAnwYdDQHdEtgS4HMr5vEtVsaRLsw296kkXRrCepVaDKP2ydPsj/TDgo2kKK4JuT6qp4nR4XpaGQyePDcJTPfNAhN0Tbsj2mMzdWY/gQhipUZ028CY24vd3YWHs3nh25hLq6xD+PLa5Pm/xY4KtqI1yaB9KCLBqgkwwgjxnvVrKiuSTxlCqprygsXbSxQinn/wVV2kx7ecz0Wdr4uq5PQowKZxGBgznxSOgjoOqgLwN0FER1L/nuA3LAOnosJsMp+DLpIQB8j462QSAWQE/wmPaJ/RZ9Ypg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(70586007)(70206006)(1076003)(5660300002)(186003)(81166007)(6916009)(36756003)(426003)(356005)(336012)(2616005)(8936002)(82310400003)(478600001)(86362001)(83380400001)(44832011)(8676002)(54906003)(47076004)(4326008)(26005)(6666004)(2906002)(7696005)(316002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:28.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a20f215-447b-4fed-31d5-08d86abe7360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why&How]
Create a separate dcn21_fast_validate_bw function for dcn21.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   3 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 119 +++++++++++++++++-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1b3b6ba20d18..01fa8de8ff86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2582,7 +2582,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 	return secondary_pipe;
 }
 
-static void dcn20_merge_pipes_for_validate(
+void dcn20_merge_pipes_for_validate(
 		struct dc *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index cdd39ee9761d..64bce14fefa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -118,6 +118,9 @@ void dcn20_set_mcif_arb_params(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt);
 bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
+void dcn20_merge_pipes_for_validate(
+		struct dc *dc,
+		struct dc_state *context);
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 72cbc13ce3da..c5108029f75e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1171,6 +1171,123 @@ void dcn21_calculate_wm(
 }
 
 
+static bool dcn21_fast_validate_bw(
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int *pipe_cnt_out,
+		int *pipe_split_from,
+		int *vlevel_out)
+{
+	bool out = false;
+	int split[MAX_PIPES] = { 0 };
+	int pipe_cnt, i, pipe_idx, vlevel;
+
+	ASSERT(pipes);
+	if (!pipes)
+		return false;
+
+	dcn20_merge_pipes_for_validate(dc, context);
+
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
+
+	*pipe_cnt_out = pipe_cnt;
+
+	if (!pipe_cnt) {
+		out = true;
+		goto validate_out;
+	}
+
+	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	if (vlevel > context->bw_ctx.dml.soc.num_states)
+		goto validate_fail;
+
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+
+	/*initialize pipe_just_split_from to invalid idx*/
+	for (i = 0; i < MAX_PIPES; i++)
+		pipe_split_from[i] = -1;
+
+	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *hsplit_pipe = pipe->bottom_pipe;
+
+		if (!pipe->stream || pipe_split_from[i] >= 0)
+			continue;
+
+		pipe_idx++;
+
+		if (!pipe->top_pipe && !pipe->plane_state && context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx]) {
+			hsplit_pipe = dcn20_find_secondary_pipe(dc, &context->res_ctx, dc->res_pool, pipe);
+			ASSERT(hsplit_pipe);
+			if (!dcn20_split_stream_for_odm(
+					dc, &context->res_ctx,
+					pipe, hsplit_pipe))
+				goto validate_fail;
+			pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
+			dcn20_build_mapped_resource(dc, context, pipe->stream);
+		}
+
+		if (!pipe->plane_state)
+			continue;
+		/* Skip 2nd half of already split pipe */
+		if (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state)
+			continue;
+
+		/* We do not support mpo + odm at the moment */
+		if (hsplit_pipe && hsplit_pipe->plane_state != pipe->plane_state
+				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx])
+			goto validate_fail;
+
+		if (split[i] == 2) {
+			if (!hsplit_pipe || hsplit_pipe->plane_state != pipe->plane_state) {
+				/* pipe not split previously needs split */
+				hsplit_pipe = dcn20_find_secondary_pipe(dc, &context->res_ctx, dc->res_pool, pipe);
+				ASSERT(hsplit_pipe);
+				if (!hsplit_pipe) {
+					context->bw_ctx.dml.vba.RequiredDPPCLK[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] *= 2;
+					continue;
+				}
+				if (context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx]) {
+					if (!dcn20_split_stream_for_odm(
+							dc, &context->res_ctx,
+							pipe, hsplit_pipe))
+						goto validate_fail;
+					dcn20_build_mapped_resource(dc, context, pipe->stream);
+				} else {
+					dcn20_split_stream_for_mpc(
+							&context->res_ctx, dc->res_pool,
+							pipe, hsplit_pipe);
+					resource_build_scaling_params(pipe);
+					resource_build_scaling_params(hsplit_pipe);
+				}
+				pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
+			}
+		} else if (hsplit_pipe && hsplit_pipe->plane_state == pipe->plane_state) {
+			/* merge should already have been done */
+			ASSERT(0);
+		}
+	}
+	/* Actual dsc count per stream dsc validation*/
+	if (!dcn20_validate_dsc(dc, context)) {
+		context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states] =
+				DML_FAIL_DSC_VALIDATION_FAILURE;
+		goto validate_fail;
+	}
+
+	*vlevel_out = vlevel;
+
+	out = true;
+	goto validate_out;
+
+validate_fail:
+	out = false;
+
+validate_out:
+	return out;
+}
+
 bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
@@ -1189,7 +1306,7 @@ bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn20_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
