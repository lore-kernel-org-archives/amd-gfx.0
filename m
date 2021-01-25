Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81770C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2969722AEC
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2969722AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD0989F0A;
	Mon, 25 Jan 2021 13:44:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F94889E86
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdDIpiqSPN9lczwrPYt3195fRQn1vpFzDXhpzcBQGJrt++vpCouVKZ9FKSB5kn4UbUQfak35jljk9j/1RvxWF356Fc0OWTsJnPMFPlBgnFwc/CZaMKIr8gymsNPmvG2B6bAj7i7xxb4aojW1gnN5zk/y1k3DTzyGdmdNvKiJoDzhjByUjV4HPofLlgKBi4jZ/lU6+gvRpvORekMa7rXgH7RpHQB3Wva2BAMoGwpUgA6zrqfDOcO5XV0W1VQxl8SiAvPJ0m1G7hwCidZi0erzhK2A0jKkF1phDlmXqYbEPYtFGoZibNoROeRZSk1weIiB1szWNZh0LVto9d99qdLYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqbj1VyZK6lqDtVrr1qjqDhcq3LxO/Td/RP8Km6iRJw=;
 b=fdXg48HHjHIF8gAGK6VOb/w3nKJiV8VD6B+hpI3TQFWSGkOD2Z0aLNyKG1GKUY+9diaeQu4YDi2lYemkrUTpBoszmxsqKmJCvcwf10kTyOXGqh0SS5NkE+QGXTO6rQYBZLE0jS/DNqClmsL7H5g2owHHEBsl5bkKvPHYu2G225xlFxjWrCC16yI8JCxI9YyM8GniVY9mTDgrit/jR5mSSr06/xo5I3wVaT1Ab0zbyKcZl2BGSm97T55oi48kubiU/eQPBRVClX15VckezyG6HWOKEJA89ndMoUlXCEGrhBIPf38f43HcEEMdzzhzJvtJ+rCvOwaIf6g2vWiYgD9sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqbj1VyZK6lqDtVrr1qjqDhcq3LxO/Td/RP8Km6iRJw=;
 b=VGELMfIrmZ7E7CHGfnnyQlfvw2mH1J5GHNqwWBT/7R6jh0XN1iZ90KDLm0TirNA/dvD7yAnhC5Ex8/PvWtDFMmD05MtGrnII6o9nKUfbvtrBoqVaRAvKt84EpoAvWXHSOLTXQ+OinlMLxFiyJqCGYUZ6oLyJeZtL31dZzsdCPik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Mon, 25 Jan 2021 13:44:17 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 1/7] drm/amd/display: Introduce FPU directory inside DC
Date: Mon, 25 Jan 2021 08:43:07 -0500
Message-Id: <20210125134313.305184-2-Rodrigo.Siqueira@amd.com>
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
 Transport; Mon, 25 Jan 2021 13:44:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cae306ea-2259-47ba-a17a-08d8c1374f11
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40416EA0F59F44778F68231298BD9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsYR2ruxMNVeJLzWpgTB5sD1mEg38tsLQH+a4PoKu5KvIkYiBCE+yNyHbV5Qq1ts8zen9XeQAZRku0qJwyMIfLW4ziucLp2zhz8Ftun0ma1qKcW/Dabu8FM4SDnGsiONv/54mPP8ocBbGvutzpZAuIxI6G2tW3YT/5I/HjHchsP3nS+WsYGuX41t26+B03E5H1lnElRmTauBsUQn3Vr9uwi6mX8+21/mYMBEHyWPrqIMW7Ef2pMV4fUG4ku3P1oMFg9bNs7d9L3AGXMOkKyvYiS1m2pmFKddAfjWclS3tlkMLXptLp9r92TWN/cObipd3eqgpDMIGUeQvsoHnAOvI3GP6KTHY5pfD3BoER1ObHIfO345znxut9BHFpscBhcxWqAMQpEpo+jCYk/sWKjV4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(2616005)(316002)(16526019)(4326008)(6916009)(1076003)(30864003)(66946007)(5660300002)(66556008)(478600001)(66476007)(54906003)(6506007)(6666004)(52116002)(36756003)(8936002)(6512007)(83380400001)(8676002)(2906002)(86362001)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nztuR0J4h15up2odD+jKsCPTaQAeJSc2ZRcMZKRCTtU2lrGQDdtak1MCV/FX?=
 =?us-ascii?Q?OkiVtp3h5G3KQY9qk1uoGQ1FWAF7m8uRNW3S238u3yqUCRd8JT7kXALvN6JV?=
 =?us-ascii?Q?N90QYq4dcx+8t7z3EUKonBiAyKOdxj8YyqotGLQnWTfhidxCi/t2i4PF35zb?=
 =?us-ascii?Q?vwlDbX4YMC1KRv3FZYnqA9qhxuFimh/XmrQ5zBD/vqo4Jt5QSb+6HNTxHpLD?=
 =?us-ascii?Q?IJkLyz3KbVB//jEwjhxSXJmkd6htuoJ0i7B997Ld42Q6OKHo+73MEHFid7uD?=
 =?us-ascii?Q?yCNxzHDZqgvbSmR/FKYoPhtk4hS5DFZbR3nG6OkQgGIIjFL9aPEPhJxr2t+f?=
 =?us-ascii?Q?DYR8cml+vFFCEwbMyaz6n6Q5A1PJv4e81CbNgvxI7+QqjcxsRgLfC1WwUUw8?=
 =?us-ascii?Q?WF2f4IbB7b1UdOtPwRbQSLmIQNH/aQ8w3dKkHB1OKUj7DdOkInq8ma6lk6wj?=
 =?us-ascii?Q?MkRh5SXkcyQPj9Pq/8fxq8ZjC6/LmhUcA2W7lvnqUDuk33h94XOGyFWnT2DX?=
 =?us-ascii?Q?OZotMEU6GJcyUSdM/SH4abfUc+BDUIZzaoafVBXYP7reDYpwjmO4QZsjczZp?=
 =?us-ascii?Q?I88bl7YTWMacwyXr4eurCP5Yid//vGfgK7RhYGgOV4woBDXIYsw3BBgFWXXs?=
 =?us-ascii?Q?NSgah5BijtxNdIw12cPSRbp7EUdZkCC203CNUdDkVULAiyM13rjUOXpapu+q?=
 =?us-ascii?Q?eM/BXg1GQ6RoILl3Jhbv3/bcE/TpRyQocKiPH/jMVMIDqfK/AswLgue7MRN3?=
 =?us-ascii?Q?ra4o9aFYPY4I4svEGh4zkLONL0t+xTOSAIQQeDGKf25d2UVppS38QtFgPil/?=
 =?us-ascii?Q?CdkWj52TfFE7VjXSQvi/Dv4Vup5stdufA85jGmzVNZFJ91//9JIECD0lQ8QN?=
 =?us-ascii?Q?vYa9sNXD/wD2G2yQqFZvD8fxncHHS8jtNQqAigjjlmRaGdFGt3X0Fla8yM7/?=
 =?us-ascii?Q?zs0Ck5cUQQTwTeqEWD50oM5LO0rSRLzzn6vzBi+SX5sqNI/Pa6Okgz3QZJg+?=
 =?us-ascii?Q?XEvpdEEo+3WJ3zOq/qoo3wC3X2myldkN6uJ9eAO4VXF4qUT+b1BtsuFrxaFs?=
 =?us-ascii?Q?Z0FJZlHDQlBrlOyAK9C2lRsdfAX44goXPiqZv/bMcqRxkpRb9ujMBrX3vjZT?=
 =?us-ascii?Q?3VjYkXSvvf6Zlhn2HNRE2m4N/NOzQc2IBg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae306ea-2259-47ba-a17a-08d8c1374f11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:16.9051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slDdelh0DFi02wSeATQTYA03iO96hW8yGIToV82tZOoCt+4CKuTDKnyHpoo5KXb0IXmlzp6oaYofhTwJMmFnFQ==
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

The display core files rely on FPU operation, which requires to be
compiled with special flags. Ideally, we don't want these FPU operations
to get spread around the DC code; nevertheless, it happens in the
current source. This commit introduces a new directory named
fpu_operation that intends to centralize all files that require the FPU
compilation flag. As part of this new component, this patch also moves
one of the functions that require FPU access to a single shared file.
Notice that this is the first part of the work, and it does not fix the
FPU issue yet; we still need other patches for achieving the complete
isolation of this file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  92 +----------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   2 -
 .../amd/display/dc/dcn301/dcn301_resource.c   |   3 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   3 +-
 .../drm/amd/display/dc/fpu_operation/Makefile |  57 +++++++
 .../display/dc/fpu_operation/dcn3x_commons.c  | 146 ++++++++++++++++++
 .../display/dc/fpu_operation/dcn3x_commons.h  |  32 ++++
 8 files changed, 242 insertions(+), 94 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index bf8fe0471b8f..61dd2c5865c7 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -33,6 +33,7 @@ DC_LIBS += dcn21
 DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn302
+DC_LIBS += fpu_operation
 endif
 
 DC_LIBS += dce120
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index dcf848f747a5..02e3107f04ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -34,6 +34,7 @@
 #include "dcn20/dcn20_resource.h"
 
 #include "dcn30_resource.h"
+#include "fpu_operation/dcn3x_commons.h"
 
 #include "dcn10/dcn10_ipp.h"
 #include "dcn30/dcn30_hubbub.h"
@@ -1470,95 +1471,6 @@ int dcn30_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-void dcn30_populate_dml_writeback_from_context(
-	struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
-{
-	int pipe_cnt, i, j;
-	double max_calc_writeback_dispclk;
-	double writeback_dispclk;
-	struct writeback_st dout_wb;
-
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dc_stream_state *stream = res_ctx->pipe_ctx[i].stream;
-
-		if (!stream)
-			continue;
-		max_calc_writeback_dispclk = 0;
-
-		/* Set writeback information */
-		pipes[pipe_cnt].dout.wb_enable = 0;
-		pipes[pipe_cnt].dout.num_active_wb = 0;
-		for (j = 0; j < stream->num_wb_info; j++) {
-			struct dc_writeback_info *wb_info = &stream->writeback_info[j];
-
-			if (wb_info->wb_enabled && wb_info->writeback_source_plane &&
-					(wb_info->writeback_source_plane == res_ctx->pipe_ctx[i].plane_state)) {
-				pipes[pipe_cnt].dout.wb_enable = 1;
-				pipes[pipe_cnt].dout.num_active_wb++;
-				dout_wb.wb_src_height = wb_info->dwb_params.cnv_params.crop_en ?
-					wb_info->dwb_params.cnv_params.crop_height :
-					wb_info->dwb_params.cnv_params.src_height;
-				dout_wb.wb_src_width = wb_info->dwb_params.cnv_params.crop_en ?
-					wb_info->dwb_params.cnv_params.crop_width :
-					wb_info->dwb_params.cnv_params.src_width;
-				dout_wb.wb_dst_width = wb_info->dwb_params.dest_width;
-				dout_wb.wb_dst_height = wb_info->dwb_params.dest_height;
-
-				/* For IP that doesn't support WB scaling, set h/v taps to 1 to avoid DML validation failure */
-				if (dc->dml.ip.writeback_max_hscl_taps > 1) {
-					dout_wb.wb_htaps_luma = wb_info->dwb_params.scaler_taps.h_taps;
-					dout_wb.wb_vtaps_luma = wb_info->dwb_params.scaler_taps.v_taps;
-				} else {
-					dout_wb.wb_htaps_luma = 1;
-					dout_wb.wb_vtaps_luma = 1;
-				}
-				dout_wb.wb_htaps_chroma = 0;
-				dout_wb.wb_vtaps_chroma = 0;
-				dout_wb.wb_hratio = wb_info->dwb_params.cnv_params.crop_en ?
-					(double)wb_info->dwb_params.cnv_params.crop_width /
-						(double)wb_info->dwb_params.dest_width :
-					(double)wb_info->dwb_params.cnv_params.src_width /
-						(double)wb_info->dwb_params.dest_width;
-				dout_wb.wb_vratio = wb_info->dwb_params.cnv_params.crop_en ?
-					(double)wb_info->dwb_params.cnv_params.crop_height /
-						(double)wb_info->dwb_params.dest_height :
-					(double)wb_info->dwb_params.cnv_params.src_height /
-						(double)wb_info->dwb_params.dest_height;
-				if (wb_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_ARGB ||
-					wb_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_RGBA)
-					dout_wb.wb_pixel_format = dm_444_64;
-				else
-					dout_wb.wb_pixel_format = dm_444_32;
-
-				/* Workaround for cases where multiple writebacks are connected to same plane
-				 * In which case, need to compute worst case and set the associated writeback parameters
-				 * This workaround is necessary due to DML computation assuming only 1 set of writeback
-				 * parameters per pipe
-				 */
-				writeback_dispclk = dml30_CalculateWriteBackDISPCLK(
-						dout_wb.wb_pixel_format,
-						pipes[pipe_cnt].pipe.dest.pixel_rate_mhz,
-						dout_wb.wb_hratio,
-						dout_wb.wb_vratio,
-						dout_wb.wb_htaps_luma,
-						dout_wb.wb_vtaps_luma,
-						dout_wb.wb_src_width,
-						dout_wb.wb_dst_width,
-						pipes[pipe_cnt].pipe.dest.htotal,
-						dc->current_state->bw_ctx.dml.ip.writeback_line_buffer_buffer_size);
-
-				if (writeback_dispclk > max_calc_writeback_dispclk) {
-					max_calc_writeback_dispclk = writeback_dispclk;
-					pipes[pipe_cnt].dout.wb = dout_wb;
-				}
-			}
-		}
-
-		pipe_cnt++;
-	}
-
-}
-
 unsigned int dcn30_calc_max_scaled_time(
 		unsigned int time_per_pixel,
 		enum mmhubbub_wbif_mode mode,
@@ -2489,7 +2401,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
+	.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 8ce7f6d39a20..b91e2856097f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -60,8 +60,6 @@ void dcn30_calculate_wm_and_dlg(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
 		int vlevel);
-void dcn30_populate_dml_writeback_from_context(
-		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
 
 int dcn30_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5d4b2c60192e..e57f365aef95 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -35,6 +35,7 @@
 #include "dcn301_resource.h"
 
 #include "dcn20/dcn20_resource.h"
+#include "fpu_operation/dcn3x_commons.h"
 
 #include "dcn10/dcn10_ipp.h"
 #include "dcn301/dcn301_hubbub.h"
@@ -1630,7 +1631,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
+	.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 22ba0be88faf..c0f4a6d10cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -42,6 +42,7 @@
 
 #include "dcn20/dcn20_dsc.h"
 #include "dcn20/dcn20_resource.h"
+#include "fpu_operation/dcn3x_commons.h"
 
 #include "dcn10/dcn10_resource.h"
 
@@ -1240,7 +1241,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-		.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
+		.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
 		.set_mcif_arb_params = dcn30_set_mcif_arb_params,
 		.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 		.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile b/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
new file mode 100644
index 000000000000..8a0957bfa8ba
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
@@ -0,0 +1,57 @@
+# 
+# Copyright 2020 Advanced Micro Devices, Inc.
+# 
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+# 
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+# 
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+# 
+# Authors: AMD
+# 
+# 
+
+DCN3X_COMMONS = dcn3x_commons.o
+
+ifdef CONFIG_X86
+dcn3x_commons_ccflags := -mhard-float -msse
+endif
+
+ifdef CONFIG_PPC64
+dcn3x_commons_ccflags := -mhard-float -maltivec
+endif
+
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef CONFIG_X86
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+dcn3x_commons_ccflags := -mpreferred-stack-boundary=4
+else
+dcn3x_commons_ccflags :=  -msse2
+endif
+endif
+
+CFLAGS_$(AMDDALPATH)/dc/fpu_operation/dcn3x_commons.o += $(dcn3x_commons_ccflags)
+
+AMD_DAL_DCN3X_COMMONS = $(addprefix $(AMDDALPATH)/dc/fpu_operation/,$(DCN3X_COMMONS))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCN3X_COMMONS)
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
new file mode 100644
index 000000000000..767ca59551c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
@@ -0,0 +1,146 @@
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
+
+/**
+ * DOC: overview
+ *
+ * The DCN architecture relies on FPU operations, which require special
+ * compilation flags and the kernel_fpu_begin/end macros. Ideally, we want to
+ * avoid spreading this sort of function across multiple object files for
+ * keeping the FPU work manageable; furthermore, we want to avoid messing with
+ * userspace applications that use double precision. This file aims to
+ * centralize all DCN30  functions that require FPU access - including those
+ * shared between other DCN3x architecture (i.e., DCN3.01 and DCN3.02) - in a
+ * single place. Notice that this file follows the following pattern:
+ *
+ * - Functions shared between multiple DCN architecture starts with dcn3x;
+ * - The functions available in this file are exposed by via public functions
+ *   that calls functions that need FPU operation under the
+ *   kernel_fpu_begin/end macros.
+ */
+
+#include "resource.h"
+#include "dml/dcn30/display_mode_vba_30.h"
+
+#include "fpu_operation/dcn3x_commons.h"
+
+static void _dcn3x_populate_dml_writeback_from_context(struct dc *dc,
+		struct resource_context *res_ctx,
+		display_e2e_pipe_params_st *pipes)
+{
+	int pipe_cnt, i, j;
+	double max_calc_writeback_dispclk;
+	double writeback_dispclk;
+	struct writeback_st dout_wb;
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_stream_state *stream = res_ctx->pipe_ctx[i].stream;
+
+		if (!stream)
+			continue;
+		max_calc_writeback_dispclk = 0;
+
+		/* Set writeback information */
+		pipes[pipe_cnt].dout.wb_enable = 0;
+		pipes[pipe_cnt].dout.num_active_wb = 0;
+		for (j = 0; j < stream->num_wb_info; j++) {
+			struct dc_writeback_info *wb_info = &stream->writeback_info[j];
+
+			if (wb_info->wb_enabled && wb_info->writeback_source_plane &&
+					(wb_info->writeback_source_plane == res_ctx->pipe_ctx[i].plane_state)) {
+				pipes[pipe_cnt].dout.wb_enable = 1;
+				pipes[pipe_cnt].dout.num_active_wb++;
+				dout_wb.wb_src_height = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_height :
+					wb_info->dwb_params.cnv_params.src_height;
+				dout_wb.wb_src_width = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_width :
+					wb_info->dwb_params.cnv_params.src_width;
+				dout_wb.wb_dst_width = wb_info->dwb_params.dest_width;
+				dout_wb.wb_dst_height = wb_info->dwb_params.dest_height;
+
+				/* For IP that doesn't support WB scaling, set h/v taps to 1 to avoid DML validation failure */
+				if (dc->dml.ip.writeback_max_hscl_taps > 1) {
+					dout_wb.wb_htaps_luma = wb_info->dwb_params.scaler_taps.h_taps;
+					dout_wb.wb_vtaps_luma = wb_info->dwb_params.scaler_taps.v_taps;
+				} else {
+					dout_wb.wb_htaps_luma = 1;
+					dout_wb.wb_vtaps_luma = 1;
+				}
+				dout_wb.wb_htaps_chroma = 0;
+				dout_wb.wb_vtaps_chroma = 0;
+				dout_wb.wb_hratio = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_width /
+						(double)wb_info->dwb_params.dest_width :
+					(double)wb_info->dwb_params.cnv_params.src_width /
+						(double)wb_info->dwb_params.dest_width;
+				dout_wb.wb_vratio = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_height /
+						(double)wb_info->dwb_params.dest_height :
+					(double)wb_info->dwb_params.cnv_params.src_height /
+						(double)wb_info->dwb_params.dest_height;
+				if (wb_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_ARGB ||
+					wb_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_RGBA)
+					dout_wb.wb_pixel_format = dm_444_64;
+				else
+					dout_wb.wb_pixel_format = dm_444_32;
+
+				/* Workaround for cases where multiple writebacks are connected to same plane
+				 * In which case, need to compute worst case and set the associated writeback parameters
+				 * This workaround is necessary due to DML computation assuming only 1 set of writeback
+				 * parameters per pipe
+				 */
+				writeback_dispclk = dml30_CalculateWriteBackDISPCLK(
+						dout_wb.wb_pixel_format,
+						pipes[pipe_cnt].pipe.dest.pixel_rate_mhz,
+						dout_wb.wb_hratio,
+						dout_wb.wb_vratio,
+						dout_wb.wb_htaps_luma,
+						dout_wb.wb_vtaps_luma,
+						dout_wb.wb_src_width,
+						dout_wb.wb_dst_width,
+						pipes[pipe_cnt].pipe.dest.htotal,
+						dc->current_state->bw_ctx.dml.ip.writeback_line_buffer_buffer_size);
+
+				if (writeback_dispclk > max_calc_writeback_dispclk) {
+					max_calc_writeback_dispclk = writeback_dispclk;
+					pipes[pipe_cnt].dout.wb = dout_wb;
+				}
+			}
+		}
+
+		pipe_cnt++;
+	}
+
+}
+
+void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
+	struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
+{
+	DC_FP_START();
+	_dcn3x_populate_dml_writeback_from_context(dc, res_ctx, pipes);
+	DC_FP_END();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
new file mode 100644
index 000000000000..c3d6297d3585
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef _DCN3X_COMMONS_H_
+#define _DCN3X_COMMONS_H_
+
+void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
+	struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
+
+#endif /* _DCN3X_COMMONS_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
