Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC4C433EC
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6D820748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="snPP6dh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6D820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6786ED15;
	Fri, 10 Jul 2020 20:34:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805926E18E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpG1iE2xw6f7PaxCFTzjqEYX8myPI4ijkRuEdr2E9/lsDhAiBU47jtCwNb8q3InWZXe2vCE04+C8AnOB+5vIWmmWNqMBT+wCcD+FNNBpDDR4UOUsG/irxWAFZ1aqvFgA3EWn2z8p0C0o5e4FdcNLMS1vvpkPrDG9QllC6W8kCzXU9djaeOJooIde7NvshWDQO5vEN/CKmwHzwO/4czxr35yrozFbV01kG42Za0hC3ydA5CipqGN/EQAvqJfmD+f8bUKnv2x34lYXAcC07xv5WikO5YoQMDlNw4vYAG+SftdWrj+BpstWHZtlIxAQHDlaQ4fJZDrzC4sEqFPbdHO2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AJ/WYYSQUuqWmG26fHgADMiBm5VxGTltNYFY/ZjjU=;
 b=BcHJiL0ycm/8yPHtRJVxUY6+0T9eC4r7vR8jV4iHf1BjMDbMziQW6v+eGxMw1kxu9D2zLJLt3A5RXN3YUfvxrcdOY30fAwFrgZbM3KOs77TmkY0D9tWKbLoTiXAMM9DBRXO7H4FNgqvS/qT7tWMANI6eZoJd0PYLRutZ9kGz+nAXLYSGLNwZsnGxSJXh4veuZrZ3Rsf2bcTvGJLSbD0wQRZj1l4DcHFjTdmrg6JVvSjXdF7snLZKsSt9W20WvoKgFOh5dtxFJA6lv6RANv1spI9lxuCfKNdbvI/9Romcn7Wo/CRwnYsj7fF3lDgpXtrBuxK9Mk8Mfs6JhUkavmymMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AJ/WYYSQUuqWmG26fHgADMiBm5VxGTltNYFY/ZjjU=;
 b=snPP6dh9oWozA3ZiFGd9gA6li6IKGCQ7EVmChabApCobHzSAlIXZCPAqCzpPjvHOh342LPh8CHKS1bxgyRvGLQ7mnqBTTNEkuokXR9fM3QUqdwEkI5jOYGDYpGdSRMpmn4hN2+A0eOkVbDZP7WKjzQ8jdhnIMaxQ8LoRAQaEjaE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:03 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/10] drm/amd/display: fix dcn3 p_state_change_support
 validation
Date: Fri, 10 Jul 2020 16:33:21 -0400
Message-Id: <20200710203325.1097188-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:02 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e062918f-f5b3-440c-2d05-08d825109560
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB423119510BAD5B7CC5098C0498650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UisnsLIhg/iq8gdtHy1uSwtkp2UQrklj0pBWer3sd4o24L0exB0Ms51hxfcntCx9T8Kiu6R/bDC4PRgKadJsQDdgrKZbR6z9JPLPACll2d+7fX1dDeKlu+H95RQ03F15Sh9sETeSK2bwqnjHwuFebVclo6U0wa+KpKWUAO7bu2uR+FmmuO2yBBy7hf+bYgF9eFdv+XpKRBToTN8fKRnPotxU6mcb0cgpwhn5363p1VB1bOXqSTX5Mxo/Qatz7DL+GwyZavRZA5XApUcvYrrVRTtJMp4uCZFRXZRRUZHYH/XMeNK0meUkvHIl+WJQgsJQJP66ZXMZ09YIYgFNR8S+OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: a2WZwYD0D46tFe4plbaXM1Vi51H3rcK1DzvV9+dPk3fKtAbKZPoD8fkac/XuOyUPVCp+zrX1Ovr2x38sEEnvk+VrIMDb17dPV5YD6XDw8SOKNboPDqSylawRAxP4xcu7OXKQm2hlexS4tgteQFOi5oWAt1BU4BV6N0wL0G2coZU7GjvjRXsdZJq/WFOuZdPuFBJg9FEe/VxlYZwvO0VvmspGb0R9Jg2QmxuY4sF8cx7mR6h17IMn8vmckSJpa5fzQJ0+ypoIbW0MAvbBz0rafHpJLO4x31dZdmwO8qckdv4D7ov0c+iYcFvQ4BjZovFJDjsVVSpfqvIHiXLm3BT++Fe5e5ZTHGd3zuattJlDMzlYNBlvQV0BxOCGVdSfNzP4+AsyOZMoS2ObtJ2zoYP4TMbMicJkoIGlknCHeGq8PxPEod7jAlFXa7KWBxakMv8EHNOLH0i7/dXAQvthVeu4Be62Flw8LSQldzkHZpyeMA8U7iw4v16BMErispRJz4TaaODzgKP0Qsfo13uApTJaVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e062918f-f5b3-440c-2d05-08d825109560
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:03.0529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHeTwpc/An9TcyhyxLGCwmHoeEHr1xtdYnW4Leso4r42AIhq3pFBQn1kZUQ8vHiXCbPKY5qDg5XR43hzvLvmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Our validation is a known mess with actual validation mixed with
topology configuration. This change makes sure topolgical validation is
completed before any topology changes are made so we do not run into
issues where we merge and split a pipe over the course of a single call.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d7ba895de765..653a571e366d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1870,12 +1870,14 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 
 	return true;
 }
-static bool dcn30_fast_validate_bw(
+
+static bool dcn30_internal_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
-		int *vlevel_out)
+		int *vlevel_out,
+		bool fast_validate)
 {
 	bool out = false;
 	bool repopulate_pipes = false;
@@ -1898,7 +1900,38 @@ static bool dcn30_fast_validate_bw(
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+	if (!fast_validate) {
+		/*
+		 * DML favors voltage over p-state, but we're more interested in
+		 * supporting p-state over voltage. We can't support p-state in
+		 * prefetch mode > 0 so try capping the prefetch mode to start.
+		 */
+		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+			dm_allow_self_refresh_and_mclk_switch;
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		/* This may adjust vlevel and maxMpcComb */
+		if (vlevel < context->bw_ctx.dml.soc.num_states)
+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+	}
+	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+		/*
+		 * If mode is unsupported or there's still no p-state support then
+		 * fall back to favoring voltage.
+		 *
+		 * We don't actually support prefetch mode 2, so require that we
+		 * at least support prefetch mode 1.
+		 */
+		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+			dm_allow_self_refresh;
+
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+			memset(split, 0, sizeof(split));
+			memset(merge, 0, sizeof(merge));
+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+		}
+	}
 
 	dml_log_mode_support_params(&context->bw_ctx.dml);
 
@@ -1938,8 +1971,6 @@ static bool dcn30_fast_validate_bw(
 		pipe_idx++;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
-
 	/* merge pipes if necessary */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -2187,7 +2218,8 @@ static void dcn30_calculate_wm(
 	}
 }
 
-bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
+bool dcn30_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
 		bool fast_validate)
 {
 	bool out = false;
@@ -2201,7 +2233,7 @@ bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	BW_VAL_TRACE_COUNT();
 
-	out = dcn30_fast_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
