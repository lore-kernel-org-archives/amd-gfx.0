Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02623C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD3F64E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD3F64E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFDC89949;
	Mon, 15 Mar 2021 11:22:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A30B89933
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEPESUDt05p6uqBVjMIie0p6bXl4FlnGKDXAl6s6oJzrqSZP94AfDzSAKJfr4ij8oujIx82hHXYMsHSxQh+2KfUUTNfFbc1cs5mo0lyDlgzZzjYpjGAE6jIM1OuefmgochbweI9dERqzGIiOkvbmBl11orEgBgRBqVfuIPri9ZKDDzz2hKyhHnV4OzXZOm0EasuDFJ2Y9V/EWh6kQsHWR3ZEMEjE2BAfZHyE2tPbFid9T17rMFrrP2bpwxWtAo222IYSWm5Gan4rFp4aM1XPmgQ6VLkLXGDm28EpTD4ICIVNMD4/1JX+PLsSK60Kr52LnPFNpdFMo/v2NjXM09uncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3LdxYvkanCstpadNf4RzQC9s7T1cKtgq7jTndC+JVs=;
 b=NsUORN1ouFfokm/N5hG7uoFP75fABEYr0cruznLJAK7AzK7T1NEJ+Lctb/LScg+CmGsNQqDtImRnIl8At32LfVtGZ+WsQevupiw0zfUJTVVWrF9bjk6Ojsy8+ldajkZXHEdgrdb4dfnkLl3SjvFm5vyyN341E2IVqJ+qY4t5T5i6qAJYj+BY9A5N5lbffcR8IT2cRsdN7KaxW88dtZS/4CdDyeQSLxw2/to8sR89NIGrRdIoLRffvLe46VKTtBH9IYNz/wEh0jxYKLaYGB3zC9UoJ9h0zGPSDho+VVA3wkRCH+X93BgAyvljs2pSYdQ9O4SyrW7Jv5PDt/eVDZKIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3LdxYvkanCstpadNf4RzQC9s7T1cKtgq7jTndC+JVs=;
 b=qLIiYEwTDWG4NjX4HNGSAMdscVLfPGUjNs1gY2FO+Zjnsxl4bo8gs//gDQXUsskOdtUFndvdbI4xg+roq2GiKsg/7Kk1nDxy+MSBxxlBP+N2c8XL6XG78ddlm5dL7iIKgGkSaQMcSp+hR61Z646s9YAxMrVp+waLZEL5/aTujLc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:28 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:28 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/23] drm/amd/display: use max lb for latency hiding
Date: Mon, 15 Mar 2021 09:39:50 +0800
Message-Id: <20210315014010.16238-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19d6030e-9aa6-4b34-f770-08d8e7a49dd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46179551982D7C56D415DCD2976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIgziDtah2Flvi7zsbroCvdssPuHfDc3wzmcpinMcD3fJMUiVyGo+49E/V8iktdvRIjnjUR3s91FgoKPOJq/FtWwX0iCbLTQcRvV8bUhLQceR+FAsX/VKMNYJRz3niIonxOs9h/2ooQwtJC6TuhAhNNAE4fL+2G/saYXxxHPmz7qpzd0SY+cVMZvyjFCtTrZvtKSRcGQjeeLsJ3VUyFk3ubYzYP1Ezec+Y3zuhUlVWlKE3kRUVodEmEHjRyke/jKVAbadVAJ+mETFPhUWEpdWbI4vtb1+l+ebfVacGQ3LFAQ0/SeQojK1ue0oMJ8cvwn9JRAspXcqTwExaIOMiBDwUom1KYO/J2ktlzsxpcedwaXFo/nUG+Ty4zOLzWvpCaPQmDLApfjf5tQRQHed3Mf/J4zpvSPP8EHgpQQ31O8wwoWJ1+8Auet08tbJZemIjxNg33GhRPfncQ0TTeEoDTfPcI6cbGEjZZXipbnEGCx846jBDbdtvwhCB8O8wHUCEgqFHBfNuDGsx3BbHW+GdMdPwIhxuPq+4NqEjme1LR4/S+zqvrtbEY93cm5Ha9z9hWq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hAVQ5TTBIpF/i0nKhodk85BOqUoQ3I/IP/UfJoD/4CIvImZn8Ir/fxg3bT3Q?=
 =?us-ascii?Q?Uo+WZSd3hc4jhWvk8sDm3Xy+bfWw7kWDYWn2iToLyaGcObYoZoux46XXKGH1?=
 =?us-ascii?Q?k143sBoTBH+cj/GNf33Yc382/pDSNN3muopFiP425GuE5dIZtIfAGhTii9UP?=
 =?us-ascii?Q?Q1vqrnJ0HOS4nolRdLgVkX8yR5A3hh7xOTl+yk2rdHAZ5C3raBCjHBUve9Hn?=
 =?us-ascii?Q?1ODUNoD3uTk0gJJlHts2n+GcGWXNIx3e80xinMV9xZF15j0GQ5Txa+r3OYR5?=
 =?us-ascii?Q?atxjnO7DfwdpTdOt58o52jk1fNS7QG81voGZKjCnbf7Ktw+FN/5BEbup9/Ct?=
 =?us-ascii?Q?430psv4Y3nCiKh1ust58hMOWTe18f2Vkt/JBZdgY+Ca/J4C2FeiMCXR9sxXG?=
 =?us-ascii?Q?gslZDb6yv6eEvkfq6NbgdBL8d9PGPt1MIQDzZbgjVNAQxosBtz4ReG8jmt6p?=
 =?us-ascii?Q?jksw739n5nfOKMkzB9D+zLS4Vne9eaLqFXbUl8c5Qqu26tMdCBoDbp4JmjeI?=
 =?us-ascii?Q?Xn20TvYTWuHweT+vwGV9a07WvSg3QrYEqh+pLfKW+PD+S94Fld2QxHySq6y8?=
 =?us-ascii?Q?nJ0D9N/W9+gyj0RL7NQFde0sZi7vlDjQNmgOkEL9TBhpFsZZaImKL3FxhZC0?=
 =?us-ascii?Q?iM2PG6/8xTfq6F4CmX2622LzWAbqaL8zY0waoDdhtd8u8kfiwbw9zUZ+oJJK?=
 =?us-ascii?Q?JVmPKZD9keYSneppY2wIsnMDjHlfjVbV3RDx76SRqmzhJ7GwGmBvTebkrEu+?=
 =?us-ascii?Q?/+SU76bqAB6h9aQseHfudx84Nv/p0UuRIwfmI+CW+zhbcb/uou/e5Ny2xr1H?=
 =?us-ascii?Q?YUwg5Up0XlMMtHc9Woc1n3/S7iYXVqOvLtrRInfAE+o1oQKN61KYoC3pSULC?=
 =?us-ascii?Q?XKnTY4OwURhAUbCBGbkjjQG44bzEjkkoEhWSE3eZwhmsBWmQZbv93TgwZjAw?=
 =?us-ascii?Q?UQw34SDURB3AmDTmVU36SY6pqxNKW6WPkfcv54MzbImA2GJBr9+iLQDImTpL?=
 =?us-ascii?Q?mdNMUSat/TWwK6hE9mFRaAXe8YmTvQyKLe5+592yF5kSP4+SBfHbeAwnxUrQ?=
 =?us-ascii?Q?sweg3vhj9e3JOOoqoEpCsGeCypG3yhqeegJ2gv+ZZai2S/TDry6N2yKeRxFv?=
 =?us-ascii?Q?PIaL2f1NBSczAWFujdCaiqv6USyucalZqiE+/BLW9Z1EaEV6BWjvqFzElXTA?=
 =?us-ascii?Q?OP6E+0pwIA0/Tc/7JpBuyPQ68PUiMPdqQzbetiapUHXp4wTVDRpx9h3fQGSc?=
 =?us-ascii?Q?Oi//LwD81uJPW8G/KsjTy6TY61jBj+fpgPAnFoFNImJ7D+5TU9GyGdcSyo57?=
 =?us-ascii?Q?j8tC5A84ZZYCSacCJovrR6k8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d6030e-9aa6-4b34-f770-08d8e7a49dd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:28.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UlBdI60R4ABrqTQT4PfNX/x2AYHQo6M/Aoz8HsjrS00HPN5QxDqud+d7BfgaphcB7SKDmFATTj3fdG96DUo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Enable max memory lb config to improve stutter efficiency and
latency hiding. Also increase max number of lb lines to be
used by dml since experiments have shown that there isnt a hard max
beyond what fits in lb.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 +++-
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 90e912fef2b3..33811953585b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -82,7 +82,7 @@ const struct _vcs_dpi_ip_params_st dcn1_0_ip = {
 	.meta_chunk_size_kbytes = 2,
 	.writeback_chunk_size_kbytes = 2,
 	.line_buffer_size_bits = 589824,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.IsLineBufferBppFixed = 0,
 	.LineBufferFixedBpp = -1,
 	.writeback_luma_buffer_size_kbytes = 12,
@@ -619,6 +619,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.recovery_enabled = false, /*enable this by default after testing.*/
 		.max_downscale_src_width = 3840,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -630,6 +631,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_clock_request = true,
 		.disable_pplib_wm_range = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.use_max_lb = true
 };
 
 static void dcn10_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index a65efed63fbf..9ae12a87d685 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -112,7 +112,7 @@ struct _vcs_dpi_ip_params_st dcn2_0_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -180,7 +180,7 @@ static struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -1075,6 +1075,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -1091,6 +1092,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.scl_reset_length10 = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_tri_buf = true,
+		.use_max_lb = true
 };
 
 void dcn20_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 2c4e309d1836..bd8e4c0f92db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -115,7 +115,7 @@ struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -882,7 +882,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = true,
 		.disable_48mhz_pwrdwn = false,
-		.usbc_combo_phy_reset_wa = true
+		.usbc_combo_phy_reset_wa = true,
+		.dmub_command_table = true,
+		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -898,7 +900,8 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_stutter = true,
 		.disable_48mhz_pwrdwn = true,
 		.disable_psr = true,
-		.enable_tri_buf = true
+		.enable_tri_buf = true,
+		.use_max_lb = true
 };
 
 enum dcn20_clk_src_array_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 71e2d5e02571..a3ac7e275f3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -120,7 +120,7 @@ struct _vcs_dpi_ip_params_st dcn3_0_ip = {
 	.dcc_supported = true,
 	.writeback_interface_buffer_size_kbytes = 90,
 	.writeback_line_buffer_buffer_size = 0,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -852,6 +852,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
 	.disable_psr = false,
+	.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -870,6 +871,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.dmub_command_table = true,
 	.disable_psr = true,
 	.enable_tri_buf = true,
+	.use_max_lb = true
 };
 
 void dcn30_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index c494235016e0..6358b2b266cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -116,7 +116,7 @@ struct _vcs_dpi_ip_params_st dcn3_01_ip = {
 	.dcc_supported = true,
 	.writeback_interface_buffer_size_kbytes = 90,
 	.writeback_line_buffer_buffer_size = 656640,
-	.max_line_buffer_lines = 12,
+	.max_line_buffer_lines = 32,
 	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -873,6 +873,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
+	.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -889,6 +890,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
+	.use_max_lb = true
 };
 
 void dcn301_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 4b659b63f75b..98b464e8b25e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -101,7 +101,7 @@ struct _vcs_dpi_ip_params_st dcn3_02_ip = {
 		.dcc_supported = true,
 		.writeback_interface_buffer_size_kbytes = 90,
 		.writeback_line_buffer_buffer_size = 0,
-		.max_line_buffer_lines = 12,
+		.max_line_buffer_lines = 32,
 		.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 		.writeback_chroma_buffer_size_kbytes = 8,
 		.writeback_chroma_line_buffer_width_pixels = 4,
@@ -223,6 +223,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
+		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -241,6 +242,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
 		.disable_psr = true,
+		.use_max_lb = true
 };
 
 enum dcn302_clk_src_array_id {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
