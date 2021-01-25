Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B30D22240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B30D22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1565389FD4;
	Mon, 25 Jan 2021 13:44:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6BD89E86
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtmrfGgzo6FuwS8pctMSofykwWaqeST7lrgWv68FwiIrCMkanmPhVk7PNju6uU1Un+4BZ6N9lka4Rd0fYYirJvn/BSDnCs/ciQrDAwmS1+0goRL6ivobZNVc6jMenwL2DX3J+V2NJsAlWjOgqphNREQS5m1WlFiq2YgQI8QxRlxpUJejuqk6GQirrYnk8tvoN7BZy2TvIi8bhpVl4XRty/1z7/cIntyk/fjb6AD2yn7Gmrfa9Vt2fk2uXxCLzHYmUzRLKtOj7IqzOIbcuQwzNHdJ2X7Qwd8diXcpZ0dETvCVYqmexc/+J0N1Sv/JE7PVyomi2uKVQqic890ikHumyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19om+50dVwNsHFOBnS4ofRU/YtkT5ASpcWaFImfVbQ=;
 b=GaOD1toD4zmWywr+FjrnSnkqv/Nnx7v7dtbDdULA37PAJbsG785Mr9knuFh85FS/JoNWXvIcfMskU8CcxaiuCOt20TAHTYmXU3i2W1qq6pOfTZhoSOIeEtD7facWKa+Ykf7TQxUgVnCg9OJ9ygFp+tuo+UW3XXExsmAOS4SDqK3VWenPVdKHNNWN43zRWRpNR3a9ocwhBPXeeZ+vl5/cz91zA7nybN0qovY90+iBbgvb13K2N5/RrZEHMo9e+AmUP9pOWisArjYl2si7h8TnD+RDu+TM6UTwSqmMQN/VYihiEOWFUrsYs+NWjXQPm2PNYf2jS29plt4X0bc7y0ngrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19om+50dVwNsHFOBnS4ofRU/YtkT5ASpcWaFImfVbQ=;
 b=guOP5M3AMFyUNkkDCt6qV8v/26AOH99diblki3adBvzKMWy2NL5fWxVzqiuOX7DSGbDccXc0WFu+9r9+tK62Kj37G33i7xQodn+1q2G52dMdGY8IZ6W/WjILb1T/Ny8Py24gVjtRyRdqq9P2KI0sFichhmWyuuN8ZgYj9RCqZE8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Mon, 25 Jan 2021 13:44:18 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 3/7] drm/amd/display: Add FPU file for functions shared across
 ASICs
Date: Mon, 25 Jan 2021 08:43:09 -0500
Message-Id: <20210125134313.305184-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
References: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:7f86:f3af:1efb:628a]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:7f86:f3af:1efb:628a)
 by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 13:44:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82e9016e-df09-4578-ff4c-08d8c1374fe4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041DF8F7652EC775D1EC04698BD9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yOaI6yRWLDleps9isQVybWFOasdHFHbqoPQwAMK9xFbDJ5A7SunIPLzprONB6EyLB1eLeCuwaF0tRgWQL7NoJFywWf3g77l7rvN4T7DAWRyWQkd3QnSDsvlUjen/JWBcZBgufR/PajDISA1ryambEVTVOEviztruM5PhXBraKIrotTrb8ww8zuKqtN2WoGbQnWlv84sbZErpAyz189Ti7Q3z7pXRQuKhqAP9NhP479SUiwxqnxqKNPYTWvuizqMfTHrGoWOolmTHMqPNGCRY8WwLncOyQ63jH96RXYW6NU1An8RM5Hx/ndUlSP442j6X/4S3eVEBVESYADSFuJHdKl7k6CLOt0n8dDqzDa4bLG/uFY7vzwhJih7XOVsEvZ2ZAwM6Ya3GW0LdQE0X2VnnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(2616005)(316002)(16526019)(4326008)(6916009)(1076003)(30864003)(66946007)(5660300002)(66556008)(478600001)(66476007)(54906003)(6506007)(6666004)(52116002)(36756003)(8936002)(6512007)(83380400001)(8676002)(2906002)(86362001)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FJYer9d++9lrYek7Cy1T/Drvdv3Qrelc6UYGubJUX81A6Y3QYvdFmnkSR4q6?=
 =?us-ascii?Q?yUKczZFoTVu1Xh9CvYJInzraX+Bgky1WrJ4IM2G2iajz+AGzZdvOTIVTBjeL?=
 =?us-ascii?Q?19yUezTQxDK/6383yaRlp/+L/RE4G92c++uwyZtqyhUAH6lk8dPmWVisvXV/?=
 =?us-ascii?Q?Yh1gMCGB861jiqAglO4yWoUTRacIX/yxYw/jkg/OrOh/rOYm0C2Vol+9rPSC?=
 =?us-ascii?Q?UwR8b7I0SOUcsV/sWXqNpibYUKchcjlP8EUkf84h1JSULWDEr2jCJhwgAPSn?=
 =?us-ascii?Q?HViVu8OaH1OWecmqAVVyhcSp+RL3T6fIgZXpEMpRo7sme55813GLfMPc0YkF?=
 =?us-ascii?Q?3foCT/NDyOf8d1GSpbos2/eFSXPwD8ANkOxsljVEnl/vn8AOnqld4AqCb/79?=
 =?us-ascii?Q?lNGh9PQcESIeMvbUqy6g01I3FnmC6jPUr+vFFexQKnZuakzvV4KwlgDDbiXV?=
 =?us-ascii?Q?XrQM8XCals3CUAvB2eu2/YCX1ziQr2+RWH3YZ2P0mjyO1zesR0RA9DqNVOXc?=
 =?us-ascii?Q?q5ot+94jbD/wXWYiI0a9MuYGb/IL8mZU/irE3D5pIRqgNnF7l57LoTK1O0Ki?=
 =?us-ascii?Q?jiLls2qwfJbee3V4XkaUXNzHgHA6kz2WKNL+EmiwanYSHTbu39NqmDbEVkol?=
 =?us-ascii?Q?Knnc3OXfNX/b+38LYMI9yjlrpSJcky3PJjbCSwEY3g14SfO8rz3r7qiJ/pvk?=
 =?us-ascii?Q?9G+W9iCNosqjOhr8HDfehICu+Y7PzABcJZEiy7h33HcpTBBHMicaJLe5Wsms?=
 =?us-ascii?Q?eqNxj0kLgWRkqd5OfVIAffgYHHXC47n+QSMX+jqYwqzP1A1y/Sz+9guoJyQp?=
 =?us-ascii?Q?UOYORGIVtwLtTcTmdey6WOP4y9x6CgptwNFYi1UDvz4Cuu7rzbJhP7vylun9?=
 =?us-ascii?Q?i/p04zVTCE0uNfk5/q1DY4eONGiqBs/KSidZH1KuB1Q3eDsO5PNyC9PQ/+CZ?=
 =?us-ascii?Q?3KMzNIC0cDuQnGZWRn5Hl6mLwIl0FuJMU3siJX6XWOw186bMQWJ6kttsn30J?=
 =?us-ascii?Q?uL5zyeznhi4t7zI5ap6Bwq4LGTy7+4Iq5ebBjq+P1szdnRV8oSHjxvnAPH11?=
 =?us-ascii?Q?K4leUaduuixd4En/J8WktAdnhqIkbBlgBedlV2KvQdAjUTovEVfubEbX/8VZ?=
 =?us-ascii?Q?DSAe6XFEMWK7q8Q9P7oBKL6I1AvfLMf97Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e9016e-df09-4578-ff4c-08d8c1374fe4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:18.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLjMBpTernX9ZlByxUMc6y/BE0ce6MVCm/xvAuztAtraKBiiEH6yb3EKycF+tlfVn2f3PT5f+dFtpyvWhfjy4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In our DC code, we have a couple of functions that use FPU and are
shared between multiples ASICs; this situation complicates the work of
centralizing FPU functions in a single place. This commit tries to
alleviate this problem by creating a file named fpu_commons to
centralize shared functions that use FPU operation in a single file. As
a start point, we move dcn20_calculate_dlg_params to this file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  70 +-----------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   5 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../drm/amd/display/dc/fpu_operation/Makefile |   3 +-
 .../display/dc/fpu_operation/dcn3x_commons.c  |   1 +
 .../display/dc/fpu_operation/fpu_commons.c    | 102 ++++++++++++++++++
 .../display/dc/fpu_operation/fpu_commons.h    |  34 ++++++
 8 files changed, 144 insertions(+), 74 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 064f158ce671..d5bf740b408c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -87,6 +87,8 @@
 
 #include "amdgpu_socbb.h"
 
+#include "fpu_operation/fpu_commons.h"
+
 #define DC_LOGGER_INIT(logger)
 
 struct _vcs_dpi_ip_params_st dcn2_0_ip = {
@@ -3060,74 +3062,6 @@ static void dcn20_calculate_wm(
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 }
 
-void dcn20_calculate_dlg_params(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
-{
-	int i, pipe_idx;
-
-	/* Writeback MCIF_WB arbitration parameters */
-	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
-
-	context->bw_ctx.bw.dcn.clk.dispclk_khz = context->bw_ctx.dml.vba.DISPCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.dcfclk_khz = context->bw_ctx.dml.vba.DCFCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
-	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
-	context->bw_ctx.bw.dcn.clk.fclk_khz = context->bw_ctx.dml.vba.FabricClock * 1000;
-	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-		context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
-							!= dm_dram_clock_change_unsupported;
-	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
-
-	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
-		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
-						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		pipe_idx++;
-	}
-	/*save a original dppclock copy*/
-	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
-	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
-	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dppclk_mhz * 1000;
-	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz * 1000;
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		bool cstate_en = context->bw_ctx.dml.vba.PrefetchMode[vlevel][context->bw_ctx.dml.vba.maxMpcComb] != 2;
-
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg(&context->bw_ctx.dml,
-				&context->res_ctx.pipe_ctx[i].dlg_regs,
-				&context->res_ctx.pipe_ctx[i].ttu_regs,
-				pipes,
-				pipe_cnt,
-				pipe_idx,
-				cstate_en,
-				context->bw_ctx.bw.dcn.clk.p_state_change_support,
-				false, false, true);
-
-		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
-				&context->res_ctx.pipe_ctx[i].rq_regs,
-				pipes[pipe_idx].pipe);
-		pipe_idx++;
-	}
-}
-
 static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index c8f3127bbcdf..11ec655a18e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -160,11 +160,6 @@ bool dcn20_fast_validate_bw(
 		int *pipe_split_from,
 		int *vlevel_out,
 		bool fast_validate);
-void dcn20_calculate_dlg_params(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel);
 
 enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state *context, struct dc_stream_state *stream);
 enum dc_status dcn20_add_stream_to_ctx(struct dc *dc, struct dc_state *new_ctx, struct dc_stream_state *dc_stream);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index b000b43a820d..b1e97caf56c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -89,6 +89,8 @@
 #include "dce/dmub_psr.h"
 #include "dce/dmub_abm.h"
 
+#include "fpu_operation/fpu_commons.h"
+
 #define DC_LOGGER_INIT(logger)
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index b82d616f8a21..c97533b4ad09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -34,6 +34,7 @@
 #include "dcn20/dcn20_resource.h"
 
 #include "dcn30_resource.h"
+#include "fpu_operation/fpu_commons.h"
 #include "fpu_operation/dcn3x_commons.h"
 
 #include "dcn10/dcn10_ipp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile b/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
index 8a0957bfa8ba..e68536c2e225 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
@@ -23,7 +23,7 @@
 # 
 # 
 
-DCN3X_COMMONS = dcn3x_commons.o
+DCN3X_COMMONS = dcn3x_commons.o fpu_commons.o
 
 ifdef CONFIG_X86
 dcn3x_commons_ccflags := -mhard-float -msse
@@ -51,6 +51,7 @@ endif
 endif
 
 CFLAGS_$(AMDDALPATH)/dc/fpu_operation/dcn3x_commons.o += $(dcn3x_commons_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/fpu_operation/fpu_commons.o += $(dcn3x_commons_ccflags)
 
 AMD_DAL_DCN3X_COMMONS = $(addprefix $(AMDDALPATH)/dc/fpu_operation/,$(DCN3X_COMMONS))
 
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
index 707f782127a7..06e9bd6d4d28 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
@@ -45,6 +45,7 @@
 #include "resource.h"
 #include "dml/dcn30/display_mode_vba_30.h"
 
+#include "fpu_operation/fpu_commons.h"
 #include "fpu_operation/dcn3x_commons.h"
 
 static void _dcn3x_populate_dml_writeback_from_context(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
new file mode 100644
index 000000000000..d2089a1dc630
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "resource.h"
+#include "dml/dcn30/display_mode_vba_30.h"
+
+#include "fpu_operation/fpu_commons.h"
+
+static void _dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel)
+{
+	int i, pipe_idx;
+
+	/* Writeback MCIF_WB arbitration parameters */
+	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
+
+	context->bw_ctx.bw.dcn.clk.dispclk_khz = context->bw_ctx.dml.vba.DISPCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.dcfclk_khz = context->bw_ctx.dml.vba.DCFCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
+	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
+	context->bw_ctx.bw.dcn.clk.fclk_khz = context->bw_ctx.dml.vba.FabricClock * 1000;
+	context->bw_ctx.bw.dcn.clk.p_state_change_support =
+		context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
+							!= dm_dram_clock_change_unsupported;
+	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+
+	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
+						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+		pipe_idx++;
+	}
+	/*save a original dppclock copy*/
+	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
+	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
+	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dppclk_mhz * 1000;
+	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz * 1000;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		bool cstate_en = context->bw_ctx.dml.vba.PrefetchMode[vlevel][context->bw_ctx.dml.vba.maxMpcComb] != 2;
+
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg(&context->bw_ctx.dml,
+				&context->res_ctx.pipe_ctx[i].dlg_regs,
+				&context->res_ctx.pipe_ctx[i].ttu_regs,
+				pipes,
+				pipe_cnt,
+				pipe_idx,
+				cstate_en,
+				context->bw_ctx.bw.dcn.clk.p_state_change_support,
+				false, false, true);
+
+		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
+				&context->res_ctx.pipe_ctx[i].rq_regs,
+				pipes[pipe_idx].pipe);
+		pipe_idx++;
+	}
+}
+
+void dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel)
+{
+	DC_FP_START();
+	_dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
new file mode 100644
index 000000000000..8d23fa8e87ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _FPU_COMMONS_H_
+#define _FPU_COMMONS_H_
+
+void dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel);
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
