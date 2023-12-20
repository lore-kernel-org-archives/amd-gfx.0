Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E50AC46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0419B10E5F6;
	Wed, 20 Dec 2023 16:37:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAEC10E5F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZNOwyt4mSuQAoCZB/9fOVITx7SvUesn4uT+TmsvalnA3en3PonO29qzW32EgeGHaQ8+64uQsg28QmxTyb6vH8Rks9K1BXkVeA4qkEv9ez1UY0pYxiBKKccgvBvPyQ0ENk/K6d8KXjGaCfeCn3FUtJQEgU0g719iGSJTDJwYRNpj5mjx6ZK1+G8yAcw70EnF89Ma8vPrvi7GZL7KRt1a+jyjMK5ylg1ewgD4aARvD6iosno3U1/2Xv4+sx3vCSclco8M+UYErAXFL+hjQi0unpu6r/gUw9Ard1pgjcHqt1+CeAeU6xDQezZjWlcMN5CI5eKtt+4UVCsybH6KOmUMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTBXjKklANgt7jrAlqz1620hH1JKP3SOKon0LDEYEOo=;
 b=hIcSCnLGlfWQqDgk7TTemCReAUlg571ZALaGMF/DjOFv7eIE7ib7bCJdYVriCOnCEfU3V8Loj/5x8ltbo8E1PHS+KuVnfmXzWPgmgd7jWBQwGKrgXJ+U5qgRuQ2u0Uq07XOpX5P1IC2uHRenCMy0pIyClsbj+D//oJudOranYpPaBlrt7W5MLKauVL0t8+zbfcWI0yykShf15CxFBIC77nooSuUxLhS+T91mYUPEhI9U+f9uvfkIoKs148JHxKLhm0vHAXUZww9yyDP08WTGe+NOop9D6mUwowh/zF0Y604ubPyTjUk3YkGL2Dv+nuaDwQVvZjo+cjXAW6cGRZ+9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTBXjKklANgt7jrAlqz1620hH1JKP3SOKon0LDEYEOo=;
 b=LQBS8h90oiZg8k/TWpTPmieJ4QkZ2TbMO2aAexf5Wb1KZUxOtLi/aMK1pbauP/0UXn5qhGsx529W/Awbwsef9M9mFwJEzncwwbbbzx6IHZiKjWvYuDw50rgLh3B4kdzHHKU869msp4XqX84iNaV31VkpnR4Yw8rfgu9GNYshxCM=
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:14 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::3c) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:09 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/20] drm/amd/display: Fix Mismatch between pipe and stream
Date: Wed, 20 Dec 2023 09:33:49 -0700
Message-ID: <20231220163538.1742834-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d2351-34e7-483f-cd68-08dc0179ec19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNWWbaRSaAJtxoZDlS1CyXk6QwUzVhPOdIW+SiN1Cysbp+7gIgPtlwChYlIjizwe6lKtbqC+5ypXL9qBP8HPYFwUlwxuPph2fGTcrpOW0GwnzSORX+CnhO966jKrY6a0cbSCLJkk1atpahCV4BAMpBK+Ra94P7ybISL70R4csB4tpXOPJddeViFt8qbOXgUtU5ykLQB1IUbvjeT+kK4B6unkGjXTZWHBiXyoFeStqtPH03U2vwS5P0bzjNn+370vyq6I8d+Z2LUUz0RLAKE7zodMD8SabmCuiJVI6gpD2Cb+sOlCpdhgO4YmvXtmvsjPlLbFqiIgoD8/LcwKNhWTQVKHBsvnBXVF7c+E/lDuEiPlHmKY+MSRW8dPqvQUgHOpH1qLw/m+KWyCVY1PdEkgbEIOHq5mVT/ClPyc0c5OR+yls7jcxPN+VC8y8oBj59QKJbCfXObKijajj7T91CzM/fOFuD07zNfPje5TNkv+F2Ym4+8V0BaWJWUYzCj30qS0W0CHqhjRyOFp0ybUx2XzhbF1Gw/WbSzzNssh65ZZuBsMwTvJ+7UE+/6EuhxvGEthdI52QDJGcfwUAySzqU74xB6oeI2JbzehJBhbdbZDPbsUV9MwcjPN6y4uQrJ0GBgWxHuSOsjY+lEIyy8b7NcRVTZo0R9FAtC8MSN3UOj04lO/9mpjCnKCRS8Fs9VCEo/AOqkTtlzKJsYQAlGUfrEDtu3dZtmXbgv7ANbD/ol2+H8ODmrk6G/3/jMHx3/xLNWkxUFe8vpVz/+Y2WejHIk7Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(8676002)(8936002)(47076005)(4326008)(36756003)(82740400003)(81166007)(86362001)(41300700001)(2906002)(356005)(36860700001)(5660300002)(26005)(16526019)(2616005)(1076003)(40480700001)(6666004)(478600001)(40460700003)(70586007)(70206006)(54906003)(83380400001)(316002)(6916009)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:14.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d2351-34e7-483f-cd68-08dc0179ec19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, Gabe
 Teeger <gabe.teeger@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Failing mode validation during dc_commit, leading to blackscreen with an
8k DP2 display during mode change.

[What]
Fix mixmatch between pipe and stream, which prevented us from
recognizing the link as DP2.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c    | 16 +++++++++++++---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c |  6 +++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index bc2959fda5be..fa6a93dd9629 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -1049,9 +1049,10 @@ static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2,
 
 void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
 {
-	int i = 0, j = 0;
+	int i = 0, j = 0, k = 0;
 	int disp_cfg_stream_location, disp_cfg_plane_location;
 	enum mall_stream_type stream_mall_type;
+	struct pipe_ctx *current_pipe_context;
 
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
 		dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id_valid[i] = false;
@@ -1071,6 +1072,15 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
 
 	for (i = 0; i < context->stream_count; i++) {
+		current_pipe_context = NULL;
+		for (k = 0; k < MAX_PIPES; k++) {
+			/* find one pipe allocated to this stream for the purpose of getting
+			info about the link later */
+			if (context->streams[i] == context->res_ctx.pipe_ctx[k].stream) {
+				current_pipe_context = &context->res_ctx.pipe_ctx[k];
+				break;
+			}
+		}
 		disp_cfg_stream_location = map_stream_to_dml_display_cfg(dml2, context->streams[i], dml_dispcfg);
 		stream_mall_type = dc_state_get_stream_subvp_type(context, context->streams[i]);
 
@@ -1080,7 +1090,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
-		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], &context->res_ctx.pipe_ctx[i]);
+		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context);
 		switch (context->streams[i]->debug.force_odm_combine_segments) {
 		case 2:
 			dml2->v20.dml_core_ctx.policy.ODMUse[disp_cfg_stream_location] = dml_odm_use_policy_combine_2to1;
@@ -1137,7 +1147,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 
 				if (j >= 1) {
 					populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_plane_location, context->streams[i]);
-					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], &context->res_ctx.pipe_ctx[i]);
+					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], current_pipe_context);
 					switch (context->streams[i]->debug.force_odm_combine_segments) {
 					case 2:
 						dml2->v20.dml_core_ctx.policy.ODMUse[disp_cfg_plane_location] = dml_odm_use_policy_combine_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 8c0794af5ade..1068b962d1c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -155,12 +155,12 @@ unsigned int dml2_util_get_maximum_odm_combine_for_output(bool force_odm_4to1, e
 
 bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 {
+	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
+		return false;
+
 	/* If this assert is hit then we have a link encoder dynamic management issue */
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
 
-	if (pipe_ctx->stream == NULL)
-		return false;
-
 	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
 	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
 		return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-- 
2.42.0

