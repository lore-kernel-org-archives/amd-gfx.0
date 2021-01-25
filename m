Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D7C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90B822240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90B822240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0D389F75;
	Mon, 25 Jan 2021 13:44:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7666689F0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpUV+oyar7cojiKxWKTzzD1E7iIHNQvINdz+LiojPdsdYJYC+YkS0+igp4nmTJB97q8DZGdxsFxc3fK8FAknEcoAu385dlmHgAos4ehqjjz1fsVOX2jiZquKcN/W6IQ0c/DVx48CFI5NCzmEaUEfCwoIxgVzK091BQe+fmx7OdeUnHbD7z5b3SOuLgWs7K5rHBKPoFmLaomx2viFxCFHcf1u/aX+Uvkeu2aedIpHvbeBAYfviuiDmFH/bSi3Cne734bAJfD+dsbC+1WIi/JJXCwxUGzgzfrZ8XWGQZ9WCPSRH3HyOlmFI0rj2oWl6GCeX6rhwCBIfh1BKn5IQc6wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va6RxLEABGgFSB8DDDQXXH5Wh/I3tUxpO/V4s+FbJsg=;
 b=O9Rw+YPpxZ5OjVD5gYvayw1dlfhbzfNh+KoCXwugoXk7OjsYgOjbqUnKWoJ3j+jurlAvIe6fmc4k7QyaN3JvdxO+Zkfa7T49NlCAChw5/Jv57ntMJHf8DERSs+nF34vE6fO3Vw2pCKnORudwxSvYCc5hVDzv1YHt6tYuGcGw+91CjeThzlhaan1Fj6QTucV3ih0TfzLbo/L6tU3kQzvGM//s7Xk3VPDQPcfe1qFSvNejTKQeqn+Mn45fIwjr6F1UpRf1GzCjKtuaJ8xCV8/xvSbMHU2HGTuBdHj2DIkV4QyF4vEM+5EHEufLHJgifJplqqA9eG/GC7+zIDB+REna2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va6RxLEABGgFSB8DDDQXXH5Wh/I3tUxpO/V4s+FbJsg=;
 b=wAl6JWWSPr6R3MU3coF7Pg42yCn8iFmJxT+7/Ci9rC6qGQ6miVl29SgJpp8N24Vs7n9GddkVvXvmmj5sYDuQyH74pC3KB/6wsVw9hzyzJoEClRXi2PQSKBjr4Vawlyy81G17GBqIpfMoRL77kJ5HTXJHNbVYXpkycgOQSyJdLGk=
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
Subject: [RFC 2/7] drm/amd/display: Moves dcn30_set_mcif_arb_params to FPU
 folder
Date: Mon, 25 Jan 2021 08:43:08 -0500
Message-Id: <20210125134313.305184-3-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3dbe6239-663d-40e6-3aa0-08d8c1374f7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041B0FC2A7D5815F0E459D598BD9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ev8Y96BDv8HJT+d9L/oZefHQT/pu5Q/9WQVEnGKMmLlmL+B92MG8g3NmhKjHzh8sq7cCPZuQuGocuiH2qge+c7LMvJgGn2qi01/GHKAGgr8dhnapT1v+ZiV99jKTWGYnMQ3JLHg85nr44PIDnvAYFI73OuaNMDtzgd2JK1JLpe5/ZdAaMXEUVk0DLumtVdt2qc8vwXYiXr0gJ+ninSepD95v+wIYeJRAv7C0BDRBQH/6rEbIfYWyxB0hv1i7MThh3wnVoI+KN2jlJkjRc03hKpEXFQrZFcCp/dSIF6eTbc5psp/7lupk8ICv4WrPb7i788gDZForWG199Qi9LLfPrp0Q8oG5mzH7s06xgngiC+ZW0B9AnUv5Rw81Zh1myur7/6/aOe4JMnH8I0cLBWTSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(2616005)(316002)(16526019)(4326008)(6916009)(1076003)(30864003)(66946007)(5660300002)(66556008)(478600001)(66476007)(54906003)(6506007)(6666004)(52116002)(36756003)(8936002)(6512007)(83380400001)(8676002)(2906002)(86362001)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tposJGVtNNmrQfq1p95+n1vsnDMXXAcgRVlHECk/lgQX5+O4ldAWy2o6O5dS?=
 =?us-ascii?Q?xYaAfJwSjT3MYfHaOKlnTDH5eGB/IqicPFSMPViYZeum2n01BrbGCGMMUeXZ?=
 =?us-ascii?Q?gbMZo1gy06gF/zOiHjrtW9PrWm72ApDwE6oYPMrEmx5qf060rpvbixb0r++D?=
 =?us-ascii?Q?i1c57SkvvvJitc9QNnj0j9oP1HWr6q7Ri0uIAwNuqi+ea9oqrqbF3CBj4lIc?=
 =?us-ascii?Q?lDggWq7jsjCec3Z5vgQVDcCEU/GnmUzc32QJCeh0AczRdysdANXLQRUubSDO?=
 =?us-ascii?Q?kWNwEFY3g3dAKfGzcH7F2mAG621dU3wfruJ7CH7xZJHf3vfayWDFO7v9ucA/?=
 =?us-ascii?Q?SyNJwXlSFm+i/FrGwaKiHbS8YEMcXgSh+yinn0xSwwrQyspJqDAq3aDc9GEc?=
 =?us-ascii?Q?yqRvbyf/FvZLK8DBFw5K6iPpG3WigfpsuyHNm3PFCoEmqwqwkcN43mIgbrwl?=
 =?us-ascii?Q?1r41hLl+c3ghLhmUyZgKUo6K7zPBLsnhMievMUH4afQZnjHT3JQBX7SP87rm?=
 =?us-ascii?Q?gB3wlOS+Qbzl86VTtMI0hIyy2Eo8UYEZi+QDmwzGfP6G5hBK8TF6ltGm/1mf?=
 =?us-ascii?Q?x+w6WImIEAHvqDYoofYMnlYWwrchA9Wcl5ck4qJE/L1nAfsIWbNpU0HNiEyW?=
 =?us-ascii?Q?xyV7UOuFTp7k4t7/jlzEkmychch3UVmAAwWLNmNAj17zugz7RkSmxrvfS/i/?=
 =?us-ascii?Q?7T1pBIyMPaSypjfjeUarw6MXnOB1x5v878bjoN4F35TUFy9GhhbctwlM20x4?=
 =?us-ascii?Q?N95h5zUdaaQbbsYlSJjktpAxbkjAckgGybkVD652Z/+q4xd/xkiBFra+38UU?=
 =?us-ascii?Q?RFmjUjJcYWyo7l5PdB7fRLUCFwK2gkeUy5liNVDDnFIcQGuaDYG7eVnx+nP1?=
 =?us-ascii?Q?jXVc3CSTngzcb2uV0Zssc1ad8fyAiV3yjV0C+1WwJcpTZfLucfKKtWCep2vZ?=
 =?us-ascii?Q?BDwlgApECHMiqaofH2Ussx95m8FLTldcOlphpaYXFCR9InBh4XCkU8Cw0X8o?=
 =?us-ascii?Q?S0Z29S2x65M06Ppfu4juh7V/V25iZh/dHMm3Z8ccdkMttDZHw2u7T5lIBdvL?=
 =?us-ascii?Q?WGD7PmjNeryWjZ7N3qjAzs5XsqvWTq91Spcvi3ZjAqhaHnG5NGJR74IaTpRW?=
 =?us-ascii?Q?iHDE/uwceNNo9+0kPO0wZCPFDwADZ1Lt+Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbe6239-663d-40e6-3aa0-08d8c1374f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:17.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3eiWsr4K5qr6prhHLbBPK9GlyM36D4WNEBh3OIZMGok8qOKsGKbn/TeW8LD32i0SZxs2n7EZZ/UBmd7GMCaTw==
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

The function dcn30_set_mcif_arb_params uses some double-precision
operation; for this reason, this commit moves this function to the
directory fpu_operation, where all FPU operations should be centralized.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 81 +-----------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h | 11 ---
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |  2 +-
 .../display/dc/fpu_operation/dcn3x_commons.c  | 84 +++++++++++++++++++
 .../display/dc/fpu_operation/dcn3x_commons.h  |  3 +
 6 files changed, 90 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 02e3107f04ee..b82d616f8a21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1471,85 +1471,6 @@ int dcn30_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-unsigned int dcn30_calc_max_scaled_time(
-		unsigned int time_per_pixel,
-		enum mmhubbub_wbif_mode mode,
-		unsigned int urgent_watermark)
-{
-	unsigned int time_per_byte = 0;
-	unsigned int total_free_entry = 0xb40;
-	unsigned int buf_lh_capability;
-	unsigned int max_scaled_time;
-
-	if (mode == PACKED_444) /* packed mode 32 bpp */
-		time_per_byte = time_per_pixel/4;
-	else if (mode == PACKED_444_FP16) /* packed mode 64 bpp */
-		time_per_byte = time_per_pixel/8;
-
-	if (time_per_byte == 0)
-		time_per_byte = 1;
-
-	buf_lh_capability = (total_free_entry*time_per_byte*32) >> 6; /* time_per_byte is in u6.6*/
-	max_scaled_time   = buf_lh_capability - urgent_watermark;
-	return max_scaled_time;
-}
-
-void dcn30_set_mcif_arb_params(
-		struct dc *dc,
-		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt)
-{
-	enum mmhubbub_wbif_mode wbif_mode;
-	struct display_mode_lib *dml = &context->bw_ctx.dml;
-	struct mcif_arb_params *wb_arb_params;
-	int i, j, k, dwb_pipe;
-
-	/* Writeback MCIF_WB arbitration parameters */
-	dwb_pipe = 0;
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		for (j = 0; j < MAX_DWB_PIPES; j++) {
-			struct dc_writeback_info *writeback_info = &context->res_ctx.pipe_ctx[i].stream->writeback_info[j];
-
-			if (writeback_info->wb_enabled == false)
-				continue;
-
-			//wb_arb_params = &context->res_ctx.pipe_ctx[i].stream->writeback_info[j].mcif_arb_params;
-			wb_arb_params = &context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[dwb_pipe];
-
-			if (writeback_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_ARGB ||
-				writeback_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_RGBA)
-				wbif_mode = PACKED_444_FP16;
-			else
-				wbif_mode = PACKED_444;
-
-			for (k = 0; k < sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]); k++) {
-				wb_arb_params->cli_watermark[k] = get_wm_writeback_urgent(dml, pipes, pipe_cnt) * 1000;
-				wb_arb_params->pstate_watermark[k] = get_wm_writeback_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
-			}
-			wb_arb_params->time_per_pixel = (1000000 << 6) / context->res_ctx.pipe_ctx[i].stream->phy_pix_clk; /* time_per_pixel should be in u6.6 format */
-			wb_arb_params->slice_lines = 32;
-			wb_arb_params->arbitration_slice = 2; /* irrelevant since there is no YUV output */
-			wb_arb_params->max_scaled_time = dcn30_calc_max_scaled_time(wb_arb_params->time_per_pixel,
-					wbif_mode,
-					wb_arb_params->cli_watermark[0]); /* assume 4 watermark sets have the same value */
-			wb_arb_params->dram_speed_change_duration = dml->vba.WritebackAllowDRAMClockChangeEndPosition[j] * pipes[0].clks_cfg.refclk_mhz; /* num_clock_cycles = us * MHz */
-
-			dwb_pipe++;
-
-			if (dwb_pipe >= MAX_DWB_PIPES)
-				return;
-		}
-		if (dwb_pipe >= MAX_DWB_PIPES)
-			return;
-	}
-
-}
-
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -2402,7 +2323,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
-	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.set_mcif_arb_params = dcn3x_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index b91e2856097f..42960574cce9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -42,17 +42,6 @@ struct resource_pool *dcn30_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
-void dcn30_set_mcif_arb_params(
-		struct dc *dc,
-		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt);
-
-unsigned int dcn30_calc_max_scaled_time(
-		unsigned int time_per_pixel,
-		enum mmhubbub_wbif_mode mode,
-		unsigned int urgent_watermark);
-
 bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate);
 void dcn30_calculate_wm_and_dlg(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index e57f365aef95..8369b009a853 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1632,7 +1632,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
-	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.set_mcif_arb_params = dcn3x_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index c0f4a6d10cb6..0554a3dd3214 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1242,7 +1242,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 		.populate_dml_writeback_from_context = dcn3x_populate_dml_writeback_from_context,
-		.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+		.set_mcif_arb_params = dcn3x_set_mcif_arb_params,
 		.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 		.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
index 767ca59551c1..707f782127a7 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
@@ -137,6 +137,90 @@ static void _dcn3x_populate_dml_writeback_from_context(struct dc *dc,
 
 }
 
+static unsigned int dcn3x_calc_max_scaled_time(unsigned int time_per_pixel,
+	enum mmhubbub_wbif_mode mode, unsigned int urgent_watermark)
+{
+	unsigned int time_per_byte = 0;
+	unsigned int total_free_entry = 0xb40;
+	unsigned int buf_lh_capability;
+	unsigned int max_scaled_time;
+
+	if (mode == PACKED_444) /* packed mode 32 bpp */
+		time_per_byte = time_per_pixel/4;
+	else if (mode == PACKED_444_FP16) /* packed mode 64 bpp */
+		time_per_byte = time_per_pixel/8;
+
+	if (time_per_byte == 0)
+		time_per_byte = 1;
+
+	buf_lh_capability = (total_free_entry*time_per_byte*32) >> 6; /* time_per_byte is in u6.6*/
+	max_scaled_time   = buf_lh_capability - urgent_watermark;
+	return max_scaled_time;
+}
+
+static void _dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt)
+{
+	enum mmhubbub_wbif_mode wbif_mode;
+	struct display_mode_lib *dml = &context->bw_ctx.dml;
+	struct mcif_arb_params *wb_arb_params;
+	int i, j, k, dwb_pipe;
+
+	/* Writeback MCIF_WB arbitration parameters */
+	dwb_pipe = 0;
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		for (j = 0; j < MAX_DWB_PIPES; j++) {
+			struct dc_writeback_info *writeback_info = &context->res_ctx.pipe_ctx[i].stream->writeback_info[j];
+
+			if (writeback_info->wb_enabled == false)
+				continue;
+
+			//wb_arb_params = &context->res_ctx.pipe_ctx[i].stream->writeback_info[j].mcif_arb_params;
+			wb_arb_params = &context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[dwb_pipe];
+
+			if (writeback_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_ARGB ||
+				writeback_info->dwb_params.cnv_params.fc_out_format == DWB_OUT_FORMAT_64BPP_RGBA)
+				wbif_mode = PACKED_444_FP16;
+			else
+				wbif_mode = PACKED_444;
+
+			for (k = 0; k < sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]); k++) {
+				wb_arb_params->cli_watermark[k] = get_wm_writeback_urgent(dml, pipes, pipe_cnt) * 1000;
+				wb_arb_params->pstate_watermark[k] = get_wm_writeback_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
+			}
+			wb_arb_params->time_per_pixel = (1000000 << 6) / context->res_ctx.pipe_ctx[i].stream->phy_pix_clk; /* time_per_pixel should be in u6.6 format */
+			wb_arb_params->slice_lines = 32;
+			wb_arb_params->arbitration_slice = 2; /* irrelevant since there is no YUV output */
+			wb_arb_params->max_scaled_time = dcn3x_calc_max_scaled_time(wb_arb_params->time_per_pixel,
+					wbif_mode,
+					wb_arb_params->cli_watermark[0]); /* assume 4 watermark sets have the same value */
+			wb_arb_params->dram_speed_change_duration = dml->vba.WritebackAllowDRAMClockChangeEndPosition[j] * pipes[0].clks_cfg.refclk_mhz; /* num_clock_cycles = us * MHz */
+
+			dwb_pipe++;
+
+			if (dwb_pipe >= MAX_DWB_PIPES)
+				return;
+		}
+		if (dwb_pipe >= MAX_DWB_PIPES)
+			return;
+	}
+
+}
+
+void dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt)
+{
+	DC_FP_START();
+	_dcn3x_set_mcif_arb_params(dc, context, pipes, pipe_cnt);
+	DC_FP_END();
+}
+
 void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
 	struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
index c3d6297d3585..b3b6d8a66c28 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
@@ -29,4 +29,7 @@
 void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
 	struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
 
+void dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
+	display_e2e_pipe_params_st *pipes, int pipe_cnt);
+
 #endif /* _DCN3X_COMMONS_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
