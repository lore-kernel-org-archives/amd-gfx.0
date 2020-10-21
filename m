Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3FC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7476A2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Ju1Ai4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7476A2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F606EDBB;
	Wed, 21 Oct 2020 14:23:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851756EDB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T27iiSMe585fra57qEKD/AjGkf6VbJQNZIpTClZ5cMz4u0cW3+ilY+3yZQOEvQIgNmJfOnM4HsSPFregjAn/rgvz5OoHDumROuEKM+WEgrPMWNqkN+zUkDLP0qaCp6geMvEguvsg+Pw9VdbUaStw3SYdPCFXGGIzxvOUYAYSOwC1fScCu4JrpltwrLJTk3BRY/KHGKyT3GHIBKlydLIoqMCP7R9tjAzpv7LYB8W2v8SlhF39j3ni6isyhJ5bolF7ffn6qSXb3TBBPG1UOe+DATiVCQ47LabH+DC+LCU0aSOZD4y1F0IfEEni/wyctyBHm/QzxWBcMMfgfC51lV+lXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smR9du/tdowfPUxeD2r73j6ctz6VGWzroCi2FtJiWv4=;
 b=DiqWunbDg2LbVMSKR8SjDKhYAivon9WNNKoGGd95CpkYtUmu+lhKqVZd5mZJh5ZC2OXhR+CO1Jw7I1VjgAkvbPs+Agns2mtK+z07ZQr8XsnpkmhaNyg+xQcrnOfY1KOQPFMZR5oqBfOZtSUO5TxkXZrjcIHSQHrDap96X7CzrkZrx3hfEDORDESEor9YAXienTkUBRVhs9oUVfJs9mlDcNkarLqhuAy5MWJlvRTWIQtTZpbT6Crxw7ov2rPElLDN32IlK+Yz9OOPoEpAKPkmSQp5API73QU9d/nrl68nlPiOFjC5a/HUe6v16hY2cErjRPiI7bltZ0oeYa1lbN/Gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smR9du/tdowfPUxeD2r73j6ctz6VGWzroCi2FtJiWv4=;
 b=4Ju1Ai4nJyycbUeD813VF4WpMVfREgNxwxjMADm3sP4zg3pl4yvBa3mOrkuaOaGuxZFFEXFp0T+Ew1eesndtCc7cP1nsSddwULq2LRTT6Stwj49Ld7Ffn7Hg+teR3MwK/nlBdArLT7jBO3QhuSCSZ0LQB/eedgMWkhJm1xPoaLE=
Received: from DM3PR12CA0048.namprd12.prod.outlook.com (2603:10b6:0:56::16) by
 BN6PR12MB1682.namprd12.prod.outlook.com (2603:10b6:405:4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Wed, 21 Oct 2020 14:23:01 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::33) by DM3PR12CA0048.outlook.office365.com
 (2603:10b6:0:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.23 via Frontend Transport; Wed, 21 Oct 2020 14:23:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:00 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:22:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: add dcn21 bw validation
Date: Wed, 21 Oct 2020 10:22:26 -0400
Message-ID: <20201021142257.190969-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615edf40-b3f7-42f5-f36d-08d875ccd12a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1682:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1682AB1FF54BC38F0C7A36E88B1C0@BN6PR12MB1682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB84a96ChpIjxIbzLbruC+khx1clr3/UGB6NlTkAR7gE13eNGqp1lskl+3fzShfd9SW46EAZRS9bXZVcN6Uw3q0x1jdnFs9hSkGITBUT6xtzESWKLdsiMnBqqDlogjX+oRWusL6oG08b3gtxCUt5VlYqVCjFym8KTfN2YLjTV9Ak5ng28TmSI0MO+PYvDyIU28KtCJJXWfRvJlnnu0qs6Wv67XvZ3jluaEkZEnqalOxxmIQDFaSpZUryygHY1UEJq3LAySuQqQC3fjVIvSUuJpY3gEiunqleNX/AIcRCe3JVhdrDF3imwKkqoRl6HIPMwafqdi2EIiPzqFvPcmPZIeO4htP9m70cQJ0p0rvZPZ6xvBwwtTxebgslHdAxYYqQE8D7F5GioFwKRVmm+cXy8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(478600001)(36756003)(26005)(8676002)(186003)(316002)(82310400003)(54906003)(5660300002)(6666004)(4326008)(2616005)(44832011)(356005)(81166007)(82740400003)(47076004)(336012)(86362001)(8936002)(426003)(6916009)(70206006)(70586007)(7696005)(1076003)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:01.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615edf40-b3f7-42f5-f36d-08d875ccd12a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1682
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
