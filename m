Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE0C433E9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032D022240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032D022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C7B6E114;
	Mon, 25 Jan 2021 13:44:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D876E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q58MYzy0YSHGAU9WK6/syGUB8+4GZRTZBU9H9p2zC+vRQ4PKG7+PikG6tCimUtEM7GEiu1oN0rRGDY4D7WUoRrjHvobAiYNkkEUlFAXfs79I7z8DHjoOeytmEkpEXxffBjTi/LVJf9yAK8wbC+x20ZJ8H0ZsMO0lF7gug6pEFk76OEqqWuvpy4JDLaEw/VSwnEHcJqZAdNAvef9AqgNSJj3bo6TesTRjfNZSnhPlSlflcSqMwOtmwAl7v0HHE6+6U+Nqo/HCJ0mH6mcRST5QJ/yJcSptgF0yc/XkgGV0kR8AC+VmxYs2UM/wIA30JNvatt0l7pVuWermjzgJJ070TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onlIsOJgVFal1iPPkvicooeFAaCIEXBM9U+YItgR320=;
 b=hBhzZFInb/FP51qG49wcQQrZ0fmeb0czrNcbV3DD1U5LybaDaVRcCpvOzwvzy2jWi+qPT0vCk4NJgCWhCXYMzRqPZXD68TpENgbQDB95sI79JwykWePAvDlqokXzLbQ4iIwE9OYWuTKSGIITmYZ8YPiq2FH6m0QPVGOv4/0Tj+5tcauYUGxm5QpdoVZ7Qba4Qt02Vclv7LviXEGtEr9ZrVEII/Ye/Pl/cm3q/vHeu1Lg44FIkwNPRV9j1/X8ClviiJiFGcgRw13z+ISiO+wjoxhkNxgwGNN2XhN2m4TZuqY+/mbA/K28ICEOXx9ToNbaTt1JHL0LNPDYFZ4yYySgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onlIsOJgVFal1iPPkvicooeFAaCIEXBM9U+YItgR320=;
 b=gYz4bp/F70RxMYwBx9F4bxtbH5bvu1wimfIqE+0qnPhn4iZg3mnSErUR9S5dNTPoSFU6SgviJPTXGuKUu6gCr7FDJXd/tuJKXxO1U2LeUJIn6hr7/wJmvB905yb0Rn20AIsT6+7evKQYgJNRHQP/cgDENSZDswFGSt+/b2ursew=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Mon, 25 Jan 2021 13:44:20 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:20 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 6/7] drm/amd/display: Move bounding box functions to FPU folder
Date: Mon, 25 Jan 2021 08:43:12 -0500
Message-Id: <20210125134313.305184-7-Rodrigo.Siqueira@amd.com>
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
 Transport; Mon, 25 Jan 2021 13:44:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8865e46b-1d92-4111-212f-08d8c137512a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43407319CBCE3BD9CCA1331298BD9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ygeExsz14HDJVijTjd7pmmndie4L1/Aa9hR4eTJYrsuosoYkDcz2wOZY0jpUMiLp4U8onQgcXWS24QHxi/CVfalxCa3yyYcFYzM15NW7zIW4Vr266aWE2ht4AGqG34QzchO4LxMZH7FCoNXLLdKckvYLFV9f/xc0gcsaTcw4JVw/wUQgUbCYXumlTqANKNJguBRUO2aQ1DTe1tJuB5+qpeDqmbyOXnwGgANA+CcDm7wuyIgYpI4UQPVJq2kfmKqiS/G8dYz+bsoyYGYk1cqOsaX3vIRUqrngBiqaFoGrC0KfL0UZRug1TxYl87aQdEIm77VtNjAd2kr2RzjlLaacxdXu3wmH/gnBQV8VAXcGronPD4anzSn12hj5YSlj7Ry+R2DgTvLYFgmn5h8oZll0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(52116002)(54906003)(6512007)(16526019)(6506007)(5660300002)(4326008)(8936002)(316002)(83380400001)(186003)(2906002)(66556008)(66946007)(66476007)(478600001)(30864003)(6486002)(86362001)(2616005)(8676002)(6666004)(6916009)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mxvB4dAhKRnih3nu1VvDf4JNBtTXPaxM0SLXt+dPhMQS/XsAkDQgeHjtv+Ht?=
 =?us-ascii?Q?Gl/eXp0G57y6YYpa9YjtrKXtp6n1+ME9vHnMBxi1YWwzLueI/Mi/1bxQPjGC?=
 =?us-ascii?Q?wJW7o/B6SBVClIOL2vNIDCb0XWVcCnEoVfZ9UREsgQUr77ZyAHD/qJe1YG8j?=
 =?us-ascii?Q?AK4cfNpsxrOLGB4yE5YGcX3c/2E/SDDnpRbg18ICQMZ0PayxK3KAkLfOKUQS?=
 =?us-ascii?Q?Pmw7LE0u0AmLIKMFURp89R2h/Y3Xq40AhpRJridp6aIm48mn1bTd7tM79HrJ?=
 =?us-ascii?Q?emWVVhePrlwcFcNLrkUWHfebAEJszvIRN+ELstU63yXcYXB0gXpZ/nyEPDKV?=
 =?us-ascii?Q?FemVNLvhtE9ax9yz0qEZIcCt//b8rPhgRqqRCPykM3GHxH9AdleU42wxDiOh?=
 =?us-ascii?Q?pcrTH+iADq6Pz1VtyYKcn3K4o4Uv9A1XDon2NRfJTxlFDKiWPSv0pJKfrMEf?=
 =?us-ascii?Q?7EZiSWueQmKy4RLb7GHv7448iT6xaHKSpTcalc/7V2cs7UtmaoKOw+69RWiM?=
 =?us-ascii?Q?H0UbF4OjLZiXKz2Sjh2S9jNGcB/8ofbkA/NbWtt8pKUqtmPYhWkFIOh1c5DY?=
 =?us-ascii?Q?Nf/ScIIuS91U/80kO2YcRtCw7lfepqNDqBnhHJSz736z9oM9KjWWt62xIMwB?=
 =?us-ascii?Q?0JMo7fCwoqYZNQuxnxeU4o4it4hbmbbUbXjNprrK5qOuoHoeQ2HNEp6/eoC+?=
 =?us-ascii?Q?34x+DM3j9ELTw0wcsxrgewFA5ngr6B19/9yxn7wZG5zI/UxGO8THcmLAYIRc?=
 =?us-ascii?Q?yFtt7whsWKV06CdCURLpu3XNpbAq0FIv2ZiPPTxj6gRv+pDGZ+mxASTVhRir?=
 =?us-ascii?Q?D29ld18KLz6Ev3YlJxTDSa8MwbNg/mVCTVNs0OBIIAKh7vZ6OlZQrvifz+cy?=
 =?us-ascii?Q?1IkxV6/+QAcJy0+C5ixNM/IgsSaeuLQbTJk/Mb4WgikNyqVvnT36ZN3o1CDS?=
 =?us-ascii?Q?1O6sPHzdwL72q7DNExyGYFtLtQtiWXugac1z5c4KmHZw1cE2i6FOhvBKBYdR?=
 =?us-ascii?Q?yUjCqQNWxk9oAiWF4vWZKxPxm20J2gPPRLIpH3j4Zc43pe+gKIohtzxScfDN?=
 =?us-ascii?Q?DUgmNptAX9T9Q4EzepkjLgR1LzrRR1l1k1rVpYSgfSxjv8iYOtgC5IwYVhut?=
 =?us-ascii?Q?2CDpRczXN5BsT6HGsT8AcrwbayL9aLYsbQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8865e46b-1d92-4111-212f-08d8c137512a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:20.3791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdfx7mWPE2QqrWbtOHxZPpPFFJv79EMsxEHZhRyVHx5071KcMmLWdCxaDzZBiVmVz2Cs3ZgnX/apQ0tuCHqrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

This commit moves all operations and data structures related to the
bounding box for DCN30 to the FPU folders.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 325 +----------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   2 -
 .../display/dc/fpu_operation/dcn3x_commons.c  | 335 ++++++++++++++++++
 .../display/dc/fpu_operation/dcn3x_commons.h  |   6 +
 4 files changed, 342 insertions(+), 326 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 98acc8be698f..cd2598bd193f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -93,137 +93,6 @@
 
 #define DC_LOGGER_INIT(logger)
 
-struct _vcs_dpi_ip_params_st dcn3_0_ip = {
-	.use_min_dcfclk = 1,
-	.clamp_min_dcfclk = 0,
-	.odm_capable = 1,
-	.gpuvm_enable = 0,
-	.hostvm_enable = 0,
-	.gpuvm_max_page_table_levels = 4,
-	.hostvm_max_page_table_levels = 4,
-	.hostvm_cached_page_table_levels = 0,
-	.pte_group_size_bytes = 2048,
-	.num_dsc = 6,
-	.rob_buffer_size_kbytes = 184,
-	.det_buffer_size_kbytes = 184,
-	.dpte_buffer_size_in_pte_reqs_luma = 84,
-	.pde_proc_buffer_size_64k_reqs = 48,
-	.dpp_output_buffer_pixels = 2560,
-	.opp_output_buffer_lines = 1,
-	.pixel_chunk_size_kbytes = 8,
-	.pte_enable = 1,
-	.max_page_table_levels = 2,
-	.pte_chunk_size_kbytes = 2,  // ?
-	.meta_chunk_size_kbytes = 2,
-	.writeback_chunk_size_kbytes = 8,
-	.line_buffer_size_bits = 789504,
-	.is_line_buffer_bpp_fixed = 0,  // ?
-	.line_buffer_fixed_bpp = 0,     // ?
-	.dcc_supported = true,
-	.writeback_interface_buffer_size_kbytes = 90,
-	.writeback_line_buffer_buffer_size = 0,
-	.max_line_buffer_lines = 12,
-	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
-	.writeback_chroma_buffer_size_kbytes = 8,
-	.writeback_chroma_line_buffer_width_pixels = 4,
-	.writeback_max_hscl_ratio = 1,
-	.writeback_max_vscl_ratio = 1,
-	.writeback_min_hscl_ratio = 1,
-	.writeback_min_vscl_ratio = 1,
-	.writeback_max_hscl_taps = 1,
-	.writeback_max_vscl_taps = 1,
-	.writeback_line_buffer_luma_buffer_size = 0,
-	.writeback_line_buffer_chroma_buffer_size = 14643,
-	.cursor_buffer_size = 8,
-	.cursor_chunk_size = 2,
-	.max_num_otg = 6,
-	.max_num_dpp = 6,
-	.max_num_wb = 1,
-	.max_dchub_pscl_bw_pix_per_clk = 4,
-	.max_pscl_lb_bw_pix_per_clk = 2,
-	.max_lb_vscl_bw_pix_per_clk = 4,
-	.max_vscl_hscl_bw_pix_per_clk = 4,
-	.max_hscl_ratio = 6,
-	.max_vscl_ratio = 6,
-	.hscl_mults = 4,
-	.vscl_mults = 4,
-	.max_hscl_taps = 8,
-	.max_vscl_taps = 8,
-	.dispclk_ramp_margin_percent = 1,
-	.underscan_factor = 1.11,
-	.min_vblank_lines = 32,
-	.dppclk_delay_subtotal = 46,
-	.dynamic_metadata_vm_enabled = true,
-	.dppclk_delay_scl_lb_only = 16,
-	.dppclk_delay_scl = 50,
-	.dppclk_delay_cnvc_formatter = 27,
-	.dppclk_delay_cnvc_cursor = 6,
-	.dispclk_delay_subtotal = 119,
-	.dcfclk_cstate_latency = 5.2, // SRExitTime
-	.max_inter_dcn_tile_repeaters = 8,
-	.odm_combine_4to1_supported = true,
-
-	.xfc_supported = false,
-	.xfc_fill_bw_overhead_percent = 10.0,
-	.xfc_fill_constant_bytes = 0,
-	.gfx7_compat_tiling_supported = 0,
-	.number_of_cursors = 1,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
-	.clock_limits = {
-			{
-				.state = 0,
-				.dispclk_mhz = 562.0,
-				.dppclk_mhz = 300.0,
-				.phyclk_mhz = 300.0,
-				.phyclk_d18_mhz = 667.0,
-				.dscclk_mhz = 405.6,
-			},
-		},
-	.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
-	.num_states = 1,
-	.sr_exit_time_us = 12,
-	.sr_enter_plus_exit_time_us = 20,
-	.urgent_latency_us = 4.0,
-	.urgent_latency_pixel_data_only_us = 4.0,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-	.urgent_latency_vm_data_only_us = 4.0,
-	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
-	.max_avg_sdp_bw_use_normal_percent = 60.0,
-	.max_avg_dram_bw_use_normal_percent = 40.0,
-	.writeback_latency_us = 12.0,
-	.max_request_size_bytes = 256,
-	.fabric_datapath_to_dcn_data_return_bytes = 64,
-	.dcn_downspread_percent = 0.5,
-	.downspread_percent = 0.38,
-	.dram_page_open_time_ns = 50.0,
-	.dram_rw_turnaround_time_ns = 17.5,
-	.dram_return_buffer_per_channel_bytes = 8192,
-	.round_trip_ping_latency_dcfclk_cycles = 191,
-	.urgent_out_of_order_return_per_channel_bytes = 4096,
-	.channel_interleave_bytes = 256,
-	.num_banks = 8,
-	.gpuvm_min_page_size_bytes = 4096,
-	.hostvm_min_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 404,
-	.dummy_pstate_latency_us = 5,
-	.writeback_dram_clock_change_latency_us = 23.0,
-	.return_bus_width_bytes = 64,
-	.dispclk_dppclk_vco_speed_mhz = 3650,
-	.xfc_bus_transport_time_us = 20,      // ?
-	.xfc_xbuf_latency_tolerance_us = 4,  // ?
-	.use_urgent_burst_bw = 1,            // ?
-	.do_urgent_latency_adjustment = true,
-	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
-};
-
 enum dcn30_clk_src_array_id {
 	DCN30_CLK_SRC_PLL0,
 	DCN30_CLK_SRC_PLL1,
@@ -1537,52 +1406,6 @@ bool dcn30_release_post_bldn_3dlut(
 #define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
 #define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
 
-static bool is_soc_bounding_box_valid(struct dc *dc)
-{
-	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
-
-	if (ASICREV_IS_SIENNA_CICHLID_P(hw_internal_rev))
-		return true;
-
-	return false;
-}
-
-static bool init_soc_bounding_box(struct dc *dc,
-				  struct dcn30_resource_pool *pool)
-{
-	struct _vcs_dpi_soc_bounding_box_st *loaded_bb = &dcn3_0_soc;
-	struct _vcs_dpi_ip_params_st *loaded_ip = &dcn3_0_ip;
-
-	DC_LOGGER_INIT(dc->ctx->logger);
-
-	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
-		return false;
-	}
-
-	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
-	loaded_ip->max_num_dpp = pool->base.pipe_count;
-	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
-	dcn_patch_bounding_box(dc, loaded_bb);
-
-	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = {0};
-
-		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-			if (bb_info.dram_clock_change_latency_100ns > 0)
-				dcn3_0_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_0_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_0_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
-		}
-	}
-
-	return true;
-}
-
 static bool dcn30_split_stream_for_mpc_or_odm(
 		const struct dc *dc,
 		struct resource_context *res_ctx,
@@ -1989,150 +1812,6 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-                                                       unsigned int *optimal_dcfclk,
-                                                       unsigned int *optimal_fclk)
-{
-       double bw_from_dram, bw_from_dram1, bw_from_dram2;
-
-       bw_from_dram1 = uclk_mts * dcn3_0_soc.num_chans *
-                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / 100);
-       bw_from_dram2 = uclk_mts * dcn3_0_soc.num_chans *
-                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100);
-
-       bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
-
-       if (optimal_fclk)
-               *optimal_fclk = bw_from_dram /
-               (dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
-
-       if (optimal_dcfclk)
-               *optimal_dcfclk =  bw_from_dram /
-               (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
-}
-
-void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-{
-	unsigned int i, j;
-	unsigned int num_states = 0;
-
-	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
-	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
-	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
-	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
-
-	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
-	unsigned int num_dcfclk_sta_targets = 4;
-	unsigned int num_uclk_states;
-
-	if (dc->ctx->dc_bios->vram_info.num_chans)
-		dcn3_0_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
-
-	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-		dcn3_0_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
-	dcn3_0_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-
-	if (bw_params->clk_table.entries[0].memclk_mhz) {
-
-		if (bw_params->clk_table.entries[1].dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
-			dcfclk_sta_targets[num_dcfclk_sta_targets] = bw_params->clk_table.entries[1].dcfclk_mhz;
-			num_dcfclk_sta_targets++;
-		} else if (bw_params->clk_table.entries[1].dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
-			for (i = 0; i < num_dcfclk_sta_targets; i++) {
-				if (dcfclk_sta_targets[i] > bw_params->clk_table.entries[1].dcfclk_mhz) {
-					dcfclk_sta_targets[i] = bw_params->clk_table.entries[1].dcfclk_mhz;
-					break;
-				}
-			}
-			// Update size of array since we "removed" duplicates
-			num_dcfclk_sta_targets = i + 1;
-		}
-
-		num_uclk_states = bw_params->clk_table.num_entries;
-
-		// Calculate optimal dcfclk for each uclk
-		for (i = 0; i < num_uclk_states; i++) {
-			DC_FP_START();
-			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
-					&optimal_dcfclk_for_uclk[i], NULL);
-			DC_FP_END();
-			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
-				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
-			}
-		}
-
-		// Calculate optimal uclk for each dcfclk sta target
-		for (i = 0; i < num_dcfclk_sta_targets; i++) {
-			for (j = 0; j < num_uclk_states; j++) {
-				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
-					optimal_uclk_for_dcfclk_sta_targets[i] =
-							bw_params->clk_table.entries[j].memclk_mhz * 16;
-					break;
-				}
-			}
-		}
-
-		i = 0;
-		j = 0;
-		// create the final dcfclk and uclk table
-		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
-				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-			} else {
-				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
-					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
-				} else {
-					j = num_uclk_states;
-				}
-			}
-		}
-
-		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
-			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-		}
-
-		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
-				optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
-			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
-		}
-
-		for (i = 0; i < dcn3_0_soc.num_states; i++) {
-			dcn3_0_soc.clock_limits[i].state = i;
-			dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
-			dcn3_0_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-			dcn3_0_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
-
-			/* Fill all states with max values of all other clocks */
-			dcn3_0_soc.clock_limits[i].dispclk_mhz = bw_params->clk_table.entries[1].dispclk_mhz;
-			dcn3_0_soc.clock_limits[i].dppclk_mhz  = bw_params->clk_table.entries[1].dppclk_mhz;
-			dcn3_0_soc.clock_limits[i].phyclk_mhz  = bw_params->clk_table.entries[1].phyclk_mhz;
-			dcn3_0_soc.clock_limits[i].dtbclk_mhz = dcn3_0_soc.clock_limits[0].dtbclk_mhz;
-			/* These clocks cannot come from bw_params, always fill from dcn3_0_soc[1] */
-			/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
-			dcn3_0_soc.clock_limits[i].phyclk_d18_mhz = dcn3_0_soc.clock_limits[0].phyclk_d18_mhz;
-			dcn3_0_soc.clock_limits[i].socclk_mhz = dcn3_0_soc.clock_limits[0].socclk_mhz;
-			dcn3_0_soc.clock_limits[i].dscclk_mhz = dcn3_0_soc.clock_limits[0].dscclk_mhz;
-		}
-		/* re-init DML with updated bb */
-		dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
-		if (dc->current_state)
-			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
-	}
-
-	/* re-init DML with updated bb */
-	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
-	if (dc->current_state)
-		dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
-}
-
 static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
@@ -2293,9 +1972,7 @@ static bool dcn30_resource_construct(
 	}
 
 	/* PP Lib and SMU interfaces */
-	init_soc_bounding_box(dc, pool);
-
-	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+	init_bounding_box_alongside_dml(dc, pool);
 
 	/* IRQ */
 	init_data.ctx = dc->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 694ae4e4e88e..9b63638308f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -68,6 +68,4 @@ enum dc_status dcn30_add_stream_to_ctx(
 		struct dc_state *new_ctx,
 		struct dc_stream_state *dc_stream);
 
-void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
-
 #endif /* _DCN30_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
index c3b06a8cf765..edcfbfcbc71d 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
@@ -44,11 +44,190 @@
 
 #include "clk_mgr.h"
 #include "resource.h"
+#include "dcn30/dcn30_resource.h"
 #include "dml/dcn30/display_mode_vba_30.h"
 
 #include "fpu_operation/fpu_commons.h"
 #include "fpu_operation/dcn3x_commons.h"
 
+static struct _vcs_dpi_ip_params_st dcn3_0_ip = {
+	.use_min_dcfclk = 1,
+	.clamp_min_dcfclk = 0,
+	.odm_capable = 1,
+	.gpuvm_enable = 0,
+	.hostvm_enable = 0,
+	.gpuvm_max_page_table_levels = 4,
+	.hostvm_max_page_table_levels = 4,
+	.hostvm_cached_page_table_levels = 0,
+	.pte_group_size_bytes = 2048,
+	.num_dsc = 6,
+	.rob_buffer_size_kbytes = 184,
+	.det_buffer_size_kbytes = 184,
+	.dpte_buffer_size_in_pte_reqs_luma = 84,
+	.pde_proc_buffer_size_64k_reqs = 48,
+	.dpp_output_buffer_pixels = 2560,
+	.opp_output_buffer_lines = 1,
+	.pixel_chunk_size_kbytes = 8,
+	.pte_enable = 1,
+	.max_page_table_levels = 2,
+	.pte_chunk_size_kbytes = 2,  // ?
+	.meta_chunk_size_kbytes = 2,
+	.writeback_chunk_size_kbytes = 8,
+	.line_buffer_size_bits = 789504,
+	.is_line_buffer_bpp_fixed = 0,  // ?
+	.line_buffer_fixed_bpp = 0,     // ?
+	.dcc_supported = true,
+	.writeback_interface_buffer_size_kbytes = 90,
+	.writeback_line_buffer_buffer_size = 0,
+	.max_line_buffer_lines = 12,
+	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
+	.writeback_chroma_buffer_size_kbytes = 8,
+	.writeback_chroma_line_buffer_width_pixels = 4,
+	.writeback_max_hscl_ratio = 1,
+	.writeback_max_vscl_ratio = 1,
+	.writeback_min_hscl_ratio = 1,
+	.writeback_min_vscl_ratio = 1,
+	.writeback_max_hscl_taps = 1,
+	.writeback_max_vscl_taps = 1,
+	.writeback_line_buffer_luma_buffer_size = 0,
+	.writeback_line_buffer_chroma_buffer_size = 14643,
+	.cursor_buffer_size = 8,
+	.cursor_chunk_size = 2,
+	.max_num_otg = 6,
+	.max_num_dpp = 6,
+	.max_num_wb = 1,
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 6,
+	.max_vscl_ratio = 6,
+	.hscl_mults = 4,
+	.vscl_mults = 4,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dispclk_ramp_margin_percent = 1,
+	.underscan_factor = 1.11,
+	.min_vblank_lines = 32,
+	.dppclk_delay_subtotal = 46,
+	.dynamic_metadata_vm_enabled = true,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_cnvc_formatter = 27,
+	.dppclk_delay_cnvc_cursor = 6,
+	.dispclk_delay_subtotal = 119,
+	.dcfclk_cstate_latency = 5.2, // SRExitTime
+	.max_inter_dcn_tile_repeaters = 8,
+	.odm_combine_4to1_supported = true,
+
+	.xfc_supported = false,
+	.xfc_fill_bw_overhead_percent = 10.0,
+	.xfc_fill_constant_bytes = 0,
+	.gfx7_compat_tiling_supported = 0,
+	.number_of_cursors = 1,
+};
+
+static struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
+	.clock_limits = {
+			{
+				.state = 0,
+				.dispclk_mhz = 562.0,
+				.dppclk_mhz = 300.0,
+				.phyclk_mhz = 300.0,
+				.phyclk_d18_mhz = 667.0,
+				.dscclk_mhz = 405.6,
+			},
+		},
+	.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
+	.num_states = 1,
+	.sr_exit_time_us = 12,
+	.sr_enter_plus_exit_time_us = 20,
+	.urgent_latency_us = 4.0,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+	.max_avg_sdp_bw_use_normal_percent = 60.0,
+	.max_avg_dram_bw_use_normal_percent = 40.0,
+	.writeback_latency_us = 12.0,
+	.max_request_size_bytes = 256,
+	.fabric_datapath_to_dcn_data_return_bytes = 64,
+	.dcn_downspread_percent = 0.5,
+	.downspread_percent = 0.38,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 191,
+	.urgent_out_of_order_return_per_channel_bytes = 4096,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.gpuvm_min_page_size_bytes = 4096,
+	.hostvm_min_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 404,
+	.dummy_pstate_latency_us = 5,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+	.dispclk_dppclk_vco_speed_mhz = 3650,
+	.xfc_bus_transport_time_us = 20,      // ?
+	.xfc_xbuf_latency_tolerance_us = 4,  // ?
+	.use_urgent_burst_bw = 1,            // ?
+	.do_urgent_latency_adjustment = true,
+	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
+};
+
+static bool is_soc_bounding_box_valid(struct dc *dc)
+{
+	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
+
+	if (ASICREV_IS_SIENNA_CICHLID_P(hw_internal_rev))
+		return true;
+
+	return false;
+}
+
+
+static bool init_soc_bounding_box(struct dc *dc,
+				  struct dcn30_resource_pool *pool)
+{
+	struct _vcs_dpi_soc_bounding_box_st *loaded_bb = &dcn3_0_soc;
+	struct _vcs_dpi_ip_params_st *loaded_ip = &dcn3_0_ip;
+
+	//DC_LOGGER_INIT(dc->ctx->logger);
+
+	if (!is_soc_bounding_box_valid(dc)) {
+		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		return false;
+	}
+
+	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
+	loaded_ip->max_num_dpp = pool->base.pipe_count;
+	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
+	dcn_patch_bounding_box(dc, loaded_bb);
+
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = {0};
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_0_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+
+	return true;
+}
+
 static void _dcn3x_populate_dml_writeback_from_context(struct dc *dc,
 		struct resource_context *res_ctx,
 		display_e2e_pipe_params_st *pipes)
@@ -380,6 +559,162 @@ static noinline void _dcn30_calculate_wm_and_dlg_fp(struct dc *dc,
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 }
 
+static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+                                                       unsigned int *optimal_dcfclk,
+                                                       unsigned int *optimal_fclk)
+{
+       double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+       bw_from_dram1 = uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / 100);
+       bw_from_dram2 = uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+       bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+       if (optimal_fclk)
+               *optimal_fclk = bw_from_dram /
+               (dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+       if (optimal_dcfclk)
+               *optimal_dcfclk =  bw_from_dram /
+               (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
+void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	unsigned int i, j;
+	unsigned int num_states = 0;
+
+	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
+	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
+
+	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
+	unsigned int num_dcfclk_sta_targets = 4;
+	unsigned int num_uclk_states;
+
+	if (dc->ctx->dc_bios->vram_info.num_chans)
+		dcn3_0_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+		dcn3_0_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
+	dcn3_0_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	if (bw_params->clk_table.entries[0].memclk_mhz) {
+
+		if (bw_params->clk_table.entries[1].dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
+			dcfclk_sta_targets[num_dcfclk_sta_targets] = bw_params->clk_table.entries[1].dcfclk_mhz;
+			num_dcfclk_sta_targets++;
+		} else if (bw_params->clk_table.entries[1].dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
+			for (i = 0; i < num_dcfclk_sta_targets; i++) {
+				if (dcfclk_sta_targets[i] > bw_params->clk_table.entries[1].dcfclk_mhz) {
+					dcfclk_sta_targets[i] = bw_params->clk_table.entries[1].dcfclk_mhz;
+					break;
+				}
+			}
+			// Update size of array since we "removed" duplicates
+			num_dcfclk_sta_targets = i + 1;
+		}
+
+		num_uclk_states = bw_params->clk_table.num_entries;
+
+		// Calculate optimal dcfclk for each uclk
+		for (i = 0; i < num_uclk_states; i++) {
+			DC_FP_START();
+			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+					&optimal_dcfclk_for_uclk[i], NULL);
+			DC_FP_END();
+			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
+				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
+			}
+		}
+
+		// Calculate optimal uclk for each dcfclk sta target
+		for (i = 0; i < num_dcfclk_sta_targets; i++) {
+			for (j = 0; j < num_uclk_states; j++) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
+					optimal_uclk_for_dcfclk_sta_targets[i] =
+							bw_params->clk_table.entries[j].memclk_mhz * 16;
+					break;
+				}
+			}
+		}
+
+		i = 0;
+		j = 0;
+		// create the final dcfclk and uclk table
+		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+			} else {
+				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
+					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+				} else {
+					j = num_uclk_states;
+				}
+			}
+		}
+
+		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
+			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+		}
+
+		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
+				optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
+			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+		}
+
+		for (i = 0; i < dcn3_0_soc.num_states; i++) {
+			dcn3_0_soc.clock_limits[i].state = i;
+			dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+			dcn3_0_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+			dcn3_0_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
+			/* Fill all states with max values of all other clocks */
+			dcn3_0_soc.clock_limits[i].dispclk_mhz = bw_params->clk_table.entries[1].dispclk_mhz;
+			dcn3_0_soc.clock_limits[i].dppclk_mhz  = bw_params->clk_table.entries[1].dppclk_mhz;
+			dcn3_0_soc.clock_limits[i].phyclk_mhz  = bw_params->clk_table.entries[1].phyclk_mhz;
+			dcn3_0_soc.clock_limits[i].dtbclk_mhz = dcn3_0_soc.clock_limits[0].dtbclk_mhz;
+			/* These clocks cannot come from bw_params, always fill from dcn3_0_soc[1] */
+			/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
+			dcn3_0_soc.clock_limits[i].phyclk_d18_mhz = dcn3_0_soc.clock_limits[0].phyclk_d18_mhz;
+			dcn3_0_soc.clock_limits[i].socclk_mhz = dcn3_0_soc.clock_limits[0].socclk_mhz;
+			dcn3_0_soc.clock_limits[i].dscclk_mhz = dcn3_0_soc.clock_limits[0].dscclk_mhz;
+		}
+		/* re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+	}
+
+	/* re-init DML with updated bb */
+	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+	if (dc->current_state)
+		dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+}
+
+bool init_bounding_box_alongside_dml(struct dc *dc, struct dcn30_resource_pool *pool)
+{
+	bool ret = true;
+
+	DC_FP_START();
+	ret = init_soc_bounding_box(dc, pool);
+	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+	DC_FP_END();
+
+	return ret;
+}
+
 void dcn3x_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
 				int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
index 7521498bbd3b..c5a002faf79f 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
@@ -35,4 +35,10 @@ void dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
 void dcn3x_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel);
 
+void dcn30_update_bw_bounding_box(struct dc *dc,
+	struct clk_bw_params *bw_params);
+
+bool init_bounding_box_alongside_dml(struct dc *dc,
+	struct dcn30_resource_pool *pool);
+
 #endif /* _DCN3X_COMMONS_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
