Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6695C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8389364E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8389364E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CBB89E1B;
	Mon, 15 Mar 2021 11:22:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8247589DDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvRnBfnQUjgqZguiix6kpDMgeccS/JuPkxXFkRRGPJBfhXR4PfTALdG97ZHGJoStr/x8IpRKhzxL3RGgTXqxUTkKUhHrzVaVxRUabSz74nF4HANU8my/a7ec5u1Xwei1x5rVrnHvYcNr5gzhTP+iunmkd0I6aVzKIa6uRMGEHXsIHuAVOTU6dgmd5NBjoLTrveKXVuBLcAW0Tga5v9DPpHV415CnUtnnlg/N2xwfajWY0/IuVq0UG+D1vp7dbfXs93BSsWVyseX5hBlamUrFgTcSjyYpf1rFjQFaA2yvBUSHLVFY2v3zwwnjb+e1YxC8jYeiTqlmuARVoTJvFZpEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpqWN9YMMB/SSym+R2GXNywlnFVwWnvltGEXskTlHEI=;
 b=Rl4QBNgqlXbEGQuNMqQzXa6UV/kI6YpOIuxAmR3WySGojJ/t2meAF9P+grzS6hmHp9a8POcm/to6wyOujIzvljINayuYlm1Z9pNy+8IrznfGpnoNwhWaQ6xYM113fpnPOR9yiUgUFL7yw/nEakXIn8/wf5P5R7NHjYcDDIWukFAKQSCro3nntseyQzaYa+Ih3oN1rNR8GvHZvP/8cHleb6REPkSdL6vnxBGYqOOjWVUQ2wiq6dbSBHjti7oHNHcj3pkr9K4lQPjRqlyqvlOcduIgBXS8n2xuBS/ony/HLkn2ppETtC5Zc3c9adyuVsv3mjAIaC5mFb0iPDyw0SwxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpqWN9YMMB/SSym+R2GXNywlnFVwWnvltGEXskTlHEI=;
 b=gISKRBTv57qp1EEtE6YprG3m9Ymcl6u72TwlRX+jeX/2zVa5WYE4LZ8ZucTvHynskRNeU8y9UvK0ZagxcneSe5T/sHFSZQffMFPqFB9IG/OvUatjaEA6paj3I/M2jMNa8N4K0IN3UKq5ZajTIOaAdMPagoEQiWIzC8siIVo/+18=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:54 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:54 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/23] drm/amd/display: Add changes for dsc bpp in 16ths and
 unify bw calculations
Date: Mon, 15 Mar 2021 09:39:56 +0800
Message-Id: <20210315014010.16238-10-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da9abff0-bb44-42e8-d32f-08d8e7a4ad6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46170AAD71A5923D17D8B318976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTL99W1+XgmivPVMeMuMxE2tRqDoCtlWhfAgEuEPhgmnnhHN2XmwWLOdGd6ACkN0reznYpEqc4Zv7Y/bgB43d3sXrwo9YP1ntFD2vhr+tP+J9PyBK/7ryWKbGnaj5A0zOdEn7IhrtHe1fJLZshjDJvP5N0KMEGRvPneReLNUpuRO13g5yvQsKlcdO8UzixesH8+/UZ7b/ixicG8Eph5JTwsZy21lizItHlP2sf3RI+gxmaFrazDVkn5BatEHwp1ZDkm/SfvCxg8qMb2WSfi+6RjBIvu5WyiTaxQqlwot2X1dnxx1cpsRXpBCGcxux9Bnc2yA54FMcF3v7erGh7fOIY/3kuqv/Q5wdDW+Sr5T3nv4V+D523hpfi8WPBybnQuITqCh2vB13DTjRVaNZ5LePBfD7+Ek4S9Sri72+JYNf9vHX9YwEupJnb/1awSzt4EbOnbFna2cpTaOhYns7uQvXjlco/mnNw3vHeJUMf4A0QNojtYy5mFlf2NAVns4REmXEktuCwhBn5z4BmWkl99yjg6VsGZ+3If+vmt4xSGYhW1xWUBWgqpoTg5Gn6qxP/ur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(30864003)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1tBMbv59mOVAKkch6MQSXoz8uVQNdiOu+Vc8KD1P4SkRPou4S2TcVpZgU84F?=
 =?us-ascii?Q?zL48A5nMF2yEgc0jZ2kaLR0wq0eUBM/DJH7BNldmsRO+wt0riqMhpdZD7Z/9?=
 =?us-ascii?Q?/4NbNa+HwNOcRkmHBBcaQiPb5+1zY1S9LtvnVpuKdGp/a0IpCf+pt6T40ITe?=
 =?us-ascii?Q?Ek2vTLA69Xf+6355FqgDRBkGITD4TpgFHw1HfYflxAk2H7Qm99JCsdZ/PQ9z?=
 =?us-ascii?Q?UdvDACM0tlkSbsNmhuRdRumcXpnVfiy0n0vK56a8lAiPsfnDz5RcjJdwGR+G?=
 =?us-ascii?Q?hW3YZ87SWvH8EQ0H3R06eQRO7LerT1wS4XG7/qbipGWITBIcjm+nwmaYsGjY?=
 =?us-ascii?Q?UhaAt5CYlYVOvDVBiCFskPDz2ech/QsK9A95oBxJDaVkMeHn6AO0pRHQF/52?=
 =?us-ascii?Q?FSeDGBwqW9bjx52qoLFrYOqRY/zcvBfgNMg8D3aE5MDpRSgda4GsdUiWeSTq?=
 =?us-ascii?Q?K98qFPPp1RJuO9ht2WhR6mjG5PGXiDyp62J0GswqCtln0c5zKcAML2epFP6X?=
 =?us-ascii?Q?emexsoprDb4u5RaG0xCIASyGAMQOZFtsNj3y4EJexbw32rSBOeYv3sb7XQ1D?=
 =?us-ascii?Q?NHxBXkekoeEtQbkUvXXP6UgDvpKqbqCz/W74JOcGIDCx/KnlHNF8RH5Z1tgi?=
 =?us-ascii?Q?ROJJHX5IpXeMVGWGrA4TYmGl3cvKV/yYF/NUGZbh6bfUZiHxRkPEluiMyn0J?=
 =?us-ascii?Q?xKqEANElPl425cOjqRYaaQIX8acOnaGkbrJhIu9E+NODn3sNH8mJ7eh/glne?=
 =?us-ascii?Q?Azr5E0Msg98cazSaAJoaI+dZ7P+HHD9NAfAsaTp+kU9tqdIjwbadMj1lLrmL?=
 =?us-ascii?Q?WoPQTlkDs7CWceihxHjdHXFUTgUfNe8Xkp4GaD+PfwNSXZOVln5/3ayG3t5N?=
 =?us-ascii?Q?mBgEKnt1iYIHDxOfi9cvmhVQRpCB3ufhJ2INf6hgSolCEGRsUtHX3gMVXnK6?=
 =?us-ascii?Q?R2nz6cSyRhaWvtLCDq/DMm9rs0H1jN50YL3hCO8j2Tu+1b3Fuuq3QWhmWhzU?=
 =?us-ascii?Q?H63I+scg6p6z2oJtgOHlP6EvAIHTL4KlEVHpYp95ezOgVZkORiSw4bMwx5HI?=
 =?us-ascii?Q?gbg9Mv367r37+os+S8XC6KrLehMxSLM+gUipcarkvcQnAvVCVhbw+3Q9JvKF?=
 =?us-ascii?Q?0KTDbw3ipd9xMqTpY5s2wXqDrIsfDji7jF0J48cTMCKHkhvZfVYtfnBmabZL?=
 =?us-ascii?Q?JaLo3AzuzStGjErnx0FrLi6lV2CQuFeD8AMDQThU9qPmKdI9Ga8WISAIU+De?=
 =?us-ascii?Q?ZkGvOa/3kjlPDfPkbXTVDdhSm9ICqh6c/SbA9yCDISRo2J5d2l8DoeWRW0uE?=
 =?us-ascii?Q?26v4Y6ugMf7q9qqu7gDDvNmwBbwqtBwaFuF4IWvorzEluw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9abff0-bb44-42e8-d32f-08d8e7a4ad6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:54.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV1Shz1C4pueVLOPunNZU1U5//s7vqDma+zwCC+6iz4VEHXX1IwPMwiziqQMrY82RhA8vG9T3mplLUH8tEN/4Q==
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
Cc: Dillon Varone <dillon.varone@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why?]
Some code still expected bpp to be used in whole bits, not 16ths.  dsc.c uses
redundant function now found in dc to calculate stream bandwidth from timing.

[How?]
Fix code to work with 16ths instead of whole bits for dsc bpp.
Refactor get_dsc_bandwidth to accept inputs in 16ths of a bit.
Use dc function to calculate bandwidth from timing, and make dsc bw calculation
a part of dsc.c.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   9 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 105 ++++++------------
 3 files changed, 43 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9337e87a73e7..30263009851e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3497,19 +3497,16 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 	}
 }
 
+uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
+
 uint32_t dc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing)
 {
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
-	struct fixed31_32 link_bw_kbps;
 
 	if (timing->flags.DSC) {
-		link_bw_kbps = dc_fixpt_from_int(timing->pix_clk_100hz);
-		link_bw_kbps = dc_fixpt_div_int(link_bw_kbps, 160);
-		link_bw_kbps = dc_fixpt_mul_int(link_bw_kbps, timing->dsc_cfg.bits_per_pixel);
-		kbps = dc_fixpt_ceil(link_bw_kbps);
-		return kbps;
+		return dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, timing->dsc_cfg.bits_per_pixel);
 	}
 
 	switch (timing->display_color_depth) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index ec55b77727d5..0c5d98524536 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -51,6 +51,7 @@ struct dc_dsc_policy {
 	int min_slice_height; // Must not be less than 8
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
+	uint32_t preferred_bpp_x16;
 	bool enable_dsc_when_not_needed;
 };
 
@@ -62,8 +63,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp,
-		uint32_t max_bpp,
+		uint32_t min_bpp_x16,
+		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range);
@@ -77,8 +78,10 @@ bool dc_dsc_compute_config(
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg);
 
+uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
+
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
-		uint32_t max_target_bpp_limit_override,
+		uint32_t max_target_bpp_limit_override_x16,
 		struct dc_dsc_policy *policy);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index c62d0eddc9c6..be57088d185d 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -37,59 +37,6 @@ static uint32_t dsc_policy_max_target_bpp_limit = 16;
 /* default DSC policy enables DSC only when needed */
 static bool dsc_policy_enable_dsc_when_not_needed;
 
-static uint32_t dc_dsc_bandwidth_in_kbps_from_timing(
-	const struct dc_crtc_timing *timing)
-{
-	uint32_t bits_per_channel = 0;
-	uint32_t kbps;
-
-	if (timing->flags.DSC) {
-		kbps = (timing->pix_clk_100hz * timing->dsc_cfg.bits_per_pixel);
-		kbps = kbps / 160 + ((kbps % 160) ? 1 : 0);
-		return kbps;
-	}
-
-	switch (timing->display_color_depth) {
-	case COLOR_DEPTH_666:
-		bits_per_channel = 6;
-		break;
-	case COLOR_DEPTH_888:
-		bits_per_channel = 8;
-		break;
-	case COLOR_DEPTH_101010:
-		bits_per_channel = 10;
-		break;
-	case COLOR_DEPTH_121212:
-		bits_per_channel = 12;
-		break;
-	case COLOR_DEPTH_141414:
-		bits_per_channel = 14;
-		break;
-	case COLOR_DEPTH_161616:
-		bits_per_channel = 16;
-		break;
-	default:
-		break;
-	}
-
-	ASSERT(bits_per_channel != 0);
-
-	kbps = timing->pix_clk_100hz / 10;
-	kbps *= bits_per_channel;
-
-	if (timing->flags.Y_ONLY != 1) {
-		/*Only YOnly make reduce bandwidth by 1/3 compares to RGB*/
-		kbps *= 3;
-		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
-			kbps /= 2;
-		else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
-			kbps = kbps * 2 / 3;
-	}
-
-	return kbps;
-
-}
-
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
 {
 
@@ -315,18 +262,18 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
  * and uncompressed bandwidth.
  */
 static void get_dsc_bandwidth_range(
-		const uint32_t min_bpp,
-		const uint32_t max_bpp,
+		const uint32_t min_bpp_x16,
+		const uint32_t max_bpp_x16,
 		const struct dsc_enc_caps *dsc_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
 {
 	/* native stream bandwidth */
-	range->stream_kbps = dc_dsc_bandwidth_in_kbps_from_timing(timing);
+	range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
 
 	/* max dsc target bpp */
-	range->max_kbps = dsc_div_by_10_round_up(max_bpp * timing->pix_clk_100hz);
-	range->max_target_bpp_x16 = max_bpp * 16;
+	range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, max_bpp_x16);
+	range->max_target_bpp_x16 = max_bpp_x16;
 	if (range->max_kbps > range->stream_kbps) {
 		/* max dsc target bpp is capped to native bandwidth */
 		range->max_kbps = range->stream_kbps;
@@ -334,8 +281,8 @@ static void get_dsc_bandwidth_range(
 	}
 
 	/* min dsc target bpp */
-	range->min_kbps = dsc_div_by_10_round_up(min_bpp * timing->pix_clk_100hz);
-	range->min_target_bpp_x16 = min_bpp * 16;
+	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, min_bpp_x16);
+	range->min_target_bpp_x16 = min_bpp_x16;
 	if (range->min_kbps > range->max_kbps) {
 		/* min dsc target bpp is capped to max dsc bandwidth*/
 		range->min_kbps = range->max_kbps;
@@ -363,12 +310,17 @@ static bool decide_dsc_target_bpp_x16(
 
 	memset(&range, 0, sizeof(range));
 
-	get_dsc_bandwidth_range(policy->min_target_bpp, policy->max_target_bpp,
+	get_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
 			dsc_common_caps, timing, &range);
 	if (!policy->enable_dsc_when_not_needed && target_bandwidth_kbps >= range.stream_kbps) {
 		/* enough bandwidth without dsc */
 		*target_bpp_x16 = 0;
 		should_use_dsc = false;
+	} else if (policy->preferred_bpp_x16 > 0 &&
+			policy->preferred_bpp_x16 <= range.max_target_bpp_x16 &&
+			policy->preferred_bpp_x16 >= range.min_target_bpp_x16) {
+		*target_bpp_x16 = policy->preferred_bpp_x16;
+		should_use_dsc = true;
 	} else if (target_bandwidth_kbps >= range.max_kbps) {
 		/* use max target bpp allowed */
 		*target_bpp_x16 = range.max_target_bpp_x16;
@@ -545,7 +497,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		int min_slice_height_override,
-		int max_dsc_target_bpp_limit_override,
+		int max_dsc_target_bpp_limit_override_x16,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -564,7 +516,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override, &policy);
+	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override_x16, &policy);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -865,8 +817,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp,
-		uint32_t max_bpp,
+		uint32_t min_bpp_x16,
+		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
@@ -883,10 +835,10 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				dsc_min_slice_height_override, max_bpp, &config);
+				dsc_min_slice_height_override, max_bpp_x16, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp, max_bpp, &dsc_common_caps, timing, range);
+		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
 }
@@ -908,11 +860,20 @@ bool dc_dsc_compute_config(
 			&dsc_enc_caps,
 			target_bandwidth_kbps,
 			timing, dsc_min_slice_height_override,
-			max_target_bpp_limit_override, dsc_cfg);
+			max_target_bpp_limit_override * 16, dsc_cfg);
 	return is_dsc_possible;
 }
 
-void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override, struct dc_dsc_policy *policy)
+uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16)
+{
+	struct fixed31_32 link_bw_kbps;
+	link_bw_kbps = dc_fixpt_from_int(pix_clk_100hz);
+	link_bw_kbps = dc_fixpt_div_int(link_bw_kbps, 160);
+	link_bw_kbps = dc_fixpt_mul_int(link_bw_kbps, bpp_x16);
+	return dc_fixpt_ceil(link_bw_kbps);
+}
+
+void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override_x16, struct dc_dsc_policy *policy)
 {
 	uint32_t bpc = 0;
 
@@ -967,13 +928,15 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t
 		return;
 	}
 
+	policy->preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
+
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
 
 	/* apply override */
-	if (max_target_bpp_limit_override && policy->max_target_bpp > max_target_bpp_limit_override)
-		policy->max_target_bpp = max_target_bpp_limit_override;
+	if (max_target_bpp_limit_override_x16 && policy->max_target_bpp > max_target_bpp_limit_override_x16 / 16)
+		policy->max_target_bpp = max_target_bpp_limit_override_x16 / 16;
 
 	/* enable DSC when not needed, default false */
 	if (dsc_policy_enable_dsc_when_not_needed)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
