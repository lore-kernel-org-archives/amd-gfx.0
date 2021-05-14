Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7066C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D0A61447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D0A61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246DA6E202;
	Fri, 14 May 2021 04:50:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472A16E202
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diBPXbr/JPgtknwOY58sHskU+qEM3WNf0O+BP7dy0COnFtp+EsqmLK3mNOTVluVM7MOnLuCdz+r2AcwH8ltn059nkH0orfE2vuuFKnO3HVlvIVtHTXp3vzC7wQxWe22wHWmw/ySTBRDPuqG2CZ0D83w8edflFqWLHWM47+0pkrSmx6I8VtMnJCF55lVnSu6P940X5oqsG/BXfhG4BuhrtD5mjMu8CvEXYcetT9QSt8ioDp2XfO2rri0DAfsKCbUdeY+jxsT8HenCyuAtBlAk5NBTYBJ7XCIVuQrNqP6Hc7fcqIrAoGewc2UNQTujwXqofSy3W7RXpSunSdM2UucoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjRqeXXa1HJ6AkLM40Dhh/AFZkuEOaX24Haa+QnGKSI=;
 b=RrvYU4ztID9/X7tSfzAuwGm1+l6kAZzxUvRem4mid95+W1ZDHf/2ZeJ46qbaSQasUrMjHGxhfUVn9cT8n+m1QjGhLZ29lPz/NGUeHbeUqbOdSXkE9Z2cSP++0fW4clLzsp7R6PDAMPhaRqYXkqJF+nKUrwUMfmCpKXE6elDaQv8vYbsbVwWjmYtJK6pJArnuytOMJ/SgDK3rkZmc07U2MJ670shoDWRPB+WdgicphKUAtkI8eroOgAlpZN2Wqtp/9Bg5bwsmo2ga3QW1Y4TB/ikTyaxPNo6tX/VJtvLI/Bl5QYjs0YbhHjz4/CAIS4jlWbYKNLOifhml9YweG6uGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjRqeXXa1HJ6AkLM40Dhh/AFZkuEOaX24Haa+QnGKSI=;
 b=xhhpA12yNECmj9W6Moed0EsUyKqgBQUb0K8TbiYwLHc53QwfqgPPRdoQnm7DXzu4y71NJayWvek8L7WMGJjT7dXIcSbTVyTBd7Kl0AONqp0LDh/2lwMX2dfZ8pdWg6N1jfz9/qKKuU9Hn9FD7q3HZNHnov+dUnQk5FkO+8F4voc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:42 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:42 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/20] drm/amd/display: Remove legacy comments
Date: Fri, 14 May 2021 12:49:47 +0800
Message-Id: <20210514045003.3069681-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b89d30d6-3422-4bc6-d2f9-08d91693d411
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129072B7C0C15777A7565E6FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCpMhbfvrsd2ceryfFFfleYlSD+HHeYXGaRI118em8/d3x7ECbCceRvXGyv3tjJA6nHS6jFi9OKJnRpsqzdN03VCBGBkbU+555eU4edTTFRDkvShIeiEXdfNiPqpMixULZGzxEmFbtAF9HOltFztTUyf4hi1htRgOKGbe09O+gBnAI8PUyHwjNCXEv3VOK5/nJTCKjyvNVeX238cJms41YKy7XSMNWG0c3C+4WceRSS65UBGA0r8CE2gJiEdVblgmTwY/CYQ7DwNIfvpP0YDEnwnKi8g8Q7enopH2YihCpYZFtALmh5QkE8H5oL65K7tf/pB7/lOeofhiMNU1OCfIxiM1wPKOgn0MQ/3dJQUDMhbpIUOK1oqc4oGTj78CunsUGHLdVb7sMCfu9Ep2cCRYWhmvAGXJzwGLoRNBpKbh1vPgsWTsXZnnyJmQXdX91Vd8+zYCUiGPpR7czKDK9u0A9INHxGg1Kl1yEeKA2COjz5zprjxYCa7c+MHHok07gkhkEybdYFRfS6U/zmrm7IVsYZSzKj7JmXsoliuTesJKl7L/ubirrxntTClna42dotc9/UsYmiHIgzWpO9+eUjaS2ZC0Aead2+VtXcouCY8+1KEKFciL7rUg5cHieEK7y/VR1JkNM1eiLDi3Tow2/fInvjnGpq63ld1NtplFN6pMJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F/JQBxhyO/M7gcPUxLkjkEp1LNjQAOMhzVHm2R+oMwa1xZAVmVg5u+hkjUou?=
 =?us-ascii?Q?Ff+xAy9e/ImAWKAmolda6cp8qFj4tIuajDP2xrvHacRIlDs9FSjqQM4bQEIQ?=
 =?us-ascii?Q?YDouoNqNpCIbwylCjO//Jw3S+QUtvXJH9bk1//WU5YRxEGWGAYRmmGzglcVM?=
 =?us-ascii?Q?1FJlsD7iKrVdQjGwe7B7y2IB2bEuWH+mE+wp7my5NyOzVXc85WE/glI7UXpF?=
 =?us-ascii?Q?nkFJeBn9i/ETAuW272q7O50JxTLE1sydqHn2PXOttYQgxkgs+hmPcMhiVLRX?=
 =?us-ascii?Q?DaWKrq6xQpdi5zqnF5ay20p7cRjflw/U3c0zBgtS0smflZNGAWGBovrwYeZU?=
 =?us-ascii?Q?N/PpUEaeHU9NNi8Tlt96IoAvZa4kwJYR+Pn+/GzdQHxtE+I1Uq0hYuhsHtx+?=
 =?us-ascii?Q?Ta2uWn/HzAur6du8FjpFjXtAj9Ndv8+38DOKOcjD/rWliOdl2XJBkNDMBnKL?=
 =?us-ascii?Q?NC9UzHQmKo1pVM/4FHkvPPYjd0n17sLiLQc+E5dY2U9OEBKqjUKFrA+LzF9u?=
 =?us-ascii?Q?YjNdXlIHjwCkYCXcAcTnKwlcKBG42Zb2/NNcDGrdD1NCZ4QgKhpjDDumb65N?=
 =?us-ascii?Q?P+wGUTGOM6xsMStb8ZWTPrwmUnOXnlQikp26sK50xuc0ueQRGApbhw8Bq0HI?=
 =?us-ascii?Q?5+5xWwTWn776PNU1tgcE/JRdO5GLja1fChb3EWvEsEmme0xQcRdm7+1xfdrm?=
 =?us-ascii?Q?bzCupTL7q45Em39L1SgcZQ1TKS5ON4+KBuq9cIh07j4Oo1m8Vw85mP5vAl6W?=
 =?us-ascii?Q?gJqAhSZ21qJ4h8EFm1zYltrMeWbuxah03AvFYYgwGWu9NLCZ0oJf8REpYHxH?=
 =?us-ascii?Q?gc+IIpaIz4IrnLVF957kJxZBba+XyIeWgam3sGqvd1BN/26GmeYv2Qqlx/sr?=
 =?us-ascii?Q?kKQP5n//3cT7ucBxyFk6nC7oBlFX1pe2jdewiyybV02AwR+H6PGF/VUBgVdb?=
 =?us-ascii?Q?dSQuxp/NiQChnWNXcTDTMlj2y6plPcgePgRm0nqUCRQ1L0UB6IuzDE8a0/wp?=
 =?us-ascii?Q?VqTrI9cQUc3qV68by3zDBZuiWDScs3YRghW5Nj5kmqtxTNQjaVRenBFlljR7?=
 =?us-ascii?Q?TqhdFzKryDWnd2SyGx5o+DjJfve32j9gaBJk252cfwc2pZfEw5zvW0Gs3ea0?=
 =?us-ascii?Q?KgGOv16EUSLs72qzh00JMhfcbzrQlFAEpXcf54XGXN4VnJZDsFdCkAsu9whx?=
 =?us-ascii?Q?fgEH1emfesaz2Gxf4Q3qRKKs8AQpqxjy/AelSvsFsbi334htS3ZzP4+3i1YJ?=
 =?us-ascii?Q?OqTCNfOw4PwygMTx3P54lAZA0zqBO7mOpqSXb2nNxMaT03DGbLT5lrAWrz3D?=
 =?us-ascii?Q?5QgaKccR4ZJ3HdKUJ6xdA8kP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d30d6-3422-4bc6-d2f9-08d91693d411
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:42.5686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE7EAwu75BunBDi/ESN6xj/e7uOlTF0lWO7vSEpHYnEGDOTw0xYmFrG2hxq3gxHZjJzcd2vQK5E1JanItARcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

To improve the code readability, this commit removes a set of commented
and not used functions for a long time. Notice that now we have the
amdgpu_dm_dtn_log, which prints all the relevant information that we
need.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 160 ------------------
 1 file changed, 160 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 90cd8f8529d3..8f11e2b58cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2199,129 +2199,6 @@ void dcn10_enable_per_frame_crtc_position_reset(
 	DC_SYNC_INFO("Multi-display sync is complete\n");
 }
 
-/*static void print_rq_dlg_ttu(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx)
-{
-	DC_LOG_BANDWIDTH_CALCS(dc->ctx->logger,
-			"\n============== DML TTU Output parameters [%d] ==============\n"
-			"qos_level_low_wm: %d, \n"
-			"qos_level_high_wm: %d, \n"
-			"min_ttu_vblank: %d, \n"
-			"qos_level_flip: %d, \n"
-			"refcyc_per_req_delivery_l: %d, \n"
-			"qos_level_fixed_l: %d, \n"
-			"qos_ramp_disable_l: %d, \n"
-			"refcyc_per_req_delivery_pre_l: %d, \n"
-			"refcyc_per_req_delivery_c: %d, \n"
-			"qos_level_fixed_c: %d, \n"
-			"qos_ramp_disable_c: %d, \n"
-			"refcyc_per_req_delivery_pre_c: %d\n"
-			"=============================================================\n",
-			pipe_ctx->pipe_idx,
-			pipe_ctx->ttu_regs.qos_level_low_wm,
-			pipe_ctx->ttu_regs.qos_level_high_wm,
-			pipe_ctx->ttu_regs.min_ttu_vblank,
-			pipe_ctx->ttu_regs.qos_level_flip,
-			pipe_ctx->ttu_regs.refcyc_per_req_delivery_l,
-			pipe_ctx->ttu_regs.qos_level_fixed_l,
-			pipe_ctx->ttu_regs.qos_ramp_disable_l,
-			pipe_ctx->ttu_regs.refcyc_per_req_delivery_pre_l,
-			pipe_ctx->ttu_regs.refcyc_per_req_delivery_c,
-			pipe_ctx->ttu_regs.qos_level_fixed_c,
-			pipe_ctx->ttu_regs.qos_ramp_disable_c,
-			pipe_ctx->ttu_regs.refcyc_per_req_delivery_pre_c
-			);
-
-	DC_LOG_BANDWIDTH_CALCS(dc->ctx->logger,
-			"\n============== DML DLG Output parameters [%d] ==============\n"
-			"refcyc_h_blank_end: %d, \n"
-			"dlg_vblank_end: %d, \n"
-			"min_dst_y_next_start: %d, \n"
-			"refcyc_per_htotal: %d, \n"
-			"refcyc_x_after_scaler: %d, \n"
-			"dst_y_after_scaler: %d, \n"
-			"dst_y_prefetch: %d, \n"
-			"dst_y_per_vm_vblank: %d, \n"
-			"dst_y_per_row_vblank: %d, \n"
-			"ref_freq_to_pix_freq: %d, \n"
-			"vratio_prefetch: %d, \n"
-			"refcyc_per_pte_group_vblank_l: %d, \n"
-			"refcyc_per_meta_chunk_vblank_l: %d, \n"
-			"dst_y_per_pte_row_nom_l: %d, \n"
-			"refcyc_per_pte_group_nom_l: %d, \n",
-			pipe_ctx->pipe_idx,
-			pipe_ctx->dlg_regs.refcyc_h_blank_end,
-			pipe_ctx->dlg_regs.dlg_vblank_end,
-			pipe_ctx->dlg_regs.min_dst_y_next_start,
-			pipe_ctx->dlg_regs.refcyc_per_htotal,
-			pipe_ctx->dlg_regs.refcyc_x_after_scaler,
-			pipe_ctx->dlg_regs.dst_y_after_scaler,
-			pipe_ctx->dlg_regs.dst_y_prefetch,
-			pipe_ctx->dlg_regs.dst_y_per_vm_vblank,
-			pipe_ctx->dlg_regs.dst_y_per_row_vblank,
-			pipe_ctx->dlg_regs.ref_freq_to_pix_freq,
-			pipe_ctx->dlg_regs.vratio_prefetch,
-			pipe_ctx->dlg_regs.refcyc_per_pte_group_vblank_l,
-			pipe_ctx->dlg_regs.refcyc_per_meta_chunk_vblank_l,
-			pipe_ctx->dlg_regs.dst_y_per_pte_row_nom_l,
-			pipe_ctx->dlg_regs.refcyc_per_pte_group_nom_l
-			);
-
-	DC_LOG_BANDWIDTH_CALCS(dc->ctx->logger,
-			"\ndst_y_per_meta_row_nom_l: %d, \n"
-			"refcyc_per_meta_chunk_nom_l: %d, \n"
-			"refcyc_per_line_delivery_pre_l: %d, \n"
-			"refcyc_per_line_delivery_l: %d, \n"
-			"vratio_prefetch_c: %d, \n"
-			"refcyc_per_pte_group_vblank_c: %d, \n"
-			"refcyc_per_meta_chunk_vblank_c: %d, \n"
-			"dst_y_per_pte_row_nom_c: %d, \n"
-			"refcyc_per_pte_group_nom_c: %d, \n"
-			"dst_y_per_meta_row_nom_c: %d, \n"
-			"refcyc_per_meta_chunk_nom_c: %d, \n"
-			"refcyc_per_line_delivery_pre_c: %d, \n"
-			"refcyc_per_line_delivery_c: %d \n"
-			"========================================================\n",
-			pipe_ctx->dlg_regs.dst_y_per_meta_row_nom_l,
-			pipe_ctx->dlg_regs.refcyc_per_meta_chunk_nom_l,
-			pipe_ctx->dlg_regs.refcyc_per_line_delivery_pre_l,
-			pipe_ctx->dlg_regs.refcyc_per_line_delivery_l,
-			pipe_ctx->dlg_regs.vratio_prefetch_c,
-			pipe_ctx->dlg_regs.refcyc_per_pte_group_vblank_c,
-			pipe_ctx->dlg_regs.refcyc_per_meta_chunk_vblank_c,
-			pipe_ctx->dlg_regs.dst_y_per_pte_row_nom_c,
-			pipe_ctx->dlg_regs.refcyc_per_pte_group_nom_c,
-			pipe_ctx->dlg_regs.dst_y_per_meta_row_nom_c,
-			pipe_ctx->dlg_regs.refcyc_per_meta_chunk_nom_c,
-			pipe_ctx->dlg_regs.refcyc_per_line_delivery_pre_c,
-			pipe_ctx->dlg_regs.refcyc_per_line_delivery_c
-			);
-
-	DC_LOG_BANDWIDTH_CALCS(dc->ctx->logger,
-			"\n============== DML RQ Output parameters [%d] ==============\n"
-			"chunk_size: %d \n"
-			"min_chunk_size: %d \n"
-			"meta_chunk_size: %d \n"
-			"min_meta_chunk_size: %d \n"
-			"dpte_group_size: %d \n"
-			"mpte_group_size: %d \n"
-			"swath_height: %d \n"
-			"pte_row_height_linear: %d \n"
-			"========================================================\n",
-			pipe_ctx->pipe_idx,
-			pipe_ctx->rq_regs.rq_regs_l.chunk_size,
-			pipe_ctx->rq_regs.rq_regs_l.min_chunk_size,
-			pipe_ctx->rq_regs.rq_regs_l.meta_chunk_size,
-			pipe_ctx->rq_regs.rq_regs_l.min_meta_chunk_size,
-			pipe_ctx->rq_regs.rq_regs_l.dpte_group_size,
-			pipe_ctx->rq_regs.rq_regs_l.mpte_group_size,
-			pipe_ctx->rq_regs.rq_regs_l.swath_height,
-			pipe_ctx->rq_regs.rq_regs_l.pte_row_height_linear
-			);
-}
-*/
-
 static void mmhub_read_vm_system_aperture_settings(struct dcn10_hubp *hubp1,
 		struct vm_system_aperture_param *apt,
 		struct dce_hwseq *hws)
@@ -2429,43 +2306,6 @@ static void dcn10_enable_plane(
 			pipe_ctx->stream_res.opp,
 			true);
 
-/* TODO: enable/disable in dm as per update type.
-	if (plane_state) {
-		DC_LOG_DC(dc->ctx->logger,
-				"Pipe:%d 0x%x: addr hi:0x%x, "
-				"addr low:0x%x, "
-				"src: %d, %d, %d,"
-				" %d; dst: %d, %d, %d, %d;\n",
-				pipe_ctx->pipe_idx,
-				plane_state,
-				plane_state->address.grph.addr.high_part,
-				plane_state->address.grph.addr.low_part,
-				plane_state->src_rect.x,
-				plane_state->src_rect.y,
-				plane_state->src_rect.width,
-				plane_state->src_rect.height,
-				plane_state->dst_rect.x,
-				plane_state->dst_rect.y,
-				plane_state->dst_rect.width,
-				plane_state->dst_rect.height);
-
-		DC_LOG_DC(dc->ctx->logger,
-				"Pipe %d: width, height, x, y         format:%d\n"
-				"viewport:%d, %d, %d, %d\n"
-				"recout:  %d, %d, %d, %d\n",
-				pipe_ctx->pipe_idx,
-				plane_state->format,
-				pipe_ctx->plane_res.scl_data.viewport.width,
-				pipe_ctx->plane_res.scl_data.viewport.height,
-				pipe_ctx->plane_res.scl_data.viewport.x,
-				pipe_ctx->plane_res.scl_data.viewport.y,
-				pipe_ctx->plane_res.scl_data.recout.width,
-				pipe_ctx->plane_res.scl_data.recout.height,
-				pipe_ctx->plane_res.scl_data.recout.x,
-				pipe_ctx->plane_res.scl_data.recout.y);
-		print_rq_dlg_ttu(dc, pipe_ctx);
-	}
-*/
 	if (dc->config.gpu_vm_support)
 		dcn10_program_pte_vm(hws, pipe_ctx->plane_res.hubp);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
