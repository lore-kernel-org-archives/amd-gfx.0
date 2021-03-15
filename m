Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93215C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5743D64E81
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5743D64E81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A80189E01;
	Mon, 15 Mar 2021 11:23:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C987C89E01
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjW/wL2mWodsMeoKemSVkoq/11jnysgAiOC7uU5xWk/HxstDcIcUSujG5UY0YurUk/Vft46r0uDwn6bsSE3SFsgAPpo364yJLWODT1PPSGgfd38Nsr5dPRsr0bBQTz7CU0NoeFnfFMLEcLxvSZoWKhGCsPcWTGma4o0P3DjrPn6rwpnRUbwUKjg1yHD3p6XXj7udHfbGxMqCTSsbAug27kS+veKeVRS31iMFOTO/tPNUDbdgzRnGF4IF2AM/JjKDSQXW67r2jQBTkc1wd6lwowmY3v2uBefabE69ENrvfrzIj3u5vW96loNNUFxC2AAg7qv3pzXHCCEmMCllbfzo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiKv1VjUYo6NODjvCtPt8/JTGJ4avnrq3igmGIkB/wI=;
 b=L5DcXKFzzvLs3yxdGawWcgcj8618328bwkop6Sai6MIZbkUyY9hcr0PQ+mK5LxUU5CD0ZmfOfl2bWYr7vOU++Dqkh8sbZlv+Tj1e79UPT/MpV+xlAxF8hOLiTnZbwgfZwJp2Yy6hQ8ex+LGyEQh3BwJ8Ly8xRvAdoh3kRzfyvp4LH6XdKG18Q/FSEMTBnjaGgk8aEp49RJQNg+4yExebRvBAT5Gi4mY572a1i8FmsvmvzM+3ahU9JzCPZD8tTZ1zlS5lvZH72x8TSGFRsgDfhtP4Qcrl/6iLYUvZILJqnPWBQgJwRq2M99fBge+wRvM7FsGGVB1QelJ/Hfh/DQtlYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiKv1VjUYo6NODjvCtPt8/JTGJ4avnrq3igmGIkB/wI=;
 b=QLO5VvwVusF516/ngMcF74JJ9LdRqPgSwptlr5zl9X0Y8/qdSFmCzmbuXjlcb5b78RT90xJrP7/8aFhw/7js4N0iQcdUYTCBFNdsjm8uTRsAEyOyAftO3GLZFKGzZhH1qQv7ZGfea4PTL/CvH/MKL+O49dzwuCG5TCp5a36OSKI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:21 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:21 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/23] drm/amd/display: Separate caps for maximum RGB and YUV
 plane counts
Date: Mon, 15 Mar 2021 09:40:02 +0800
Message-Id: <20210315014010.16238-16-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c7c51c4-14e1-4c55-ce4b-08d8e7a4bd3d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46178118E50BAB58E570BC0C976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lliAEDbXsiu1mjPUDAZ6oMjPuOkyWeACw6MsEFQ9x8j22EjwnqXHuPUhPPNPmgEYC1JwwA9mnlKN9KYE5OXBTX4ZmqTPo1baDukobrR+uqr65iD6QNSkT54NrLvMa2dc6dDOg6QHwZLyRznPpNRMf8KfHLtNjkdChWhg8A53DERw9nQFbqTA6uLME9mkF9odzj6SWnOLc5Lt4gT34zA7X389r+R3f+V19vEib20UMvJdNTscrmEwlY6EIlCG+HgfLh44z/SXBnLaq/3KveradOgtZ5iSl0/FI+GrftsHABFogPhPMmVD/K5q6Uvf6ap8iefOwBaNEqb4StM2mQhLoL2rB2GvOE5sVU4o/wfib9sz/ykYwzOaFGn5B8QBBpDSG3Hhd8PNK3WZS5zMiungAgZ07/K6WSTjJTCtDsYNvD0bORaN4A7tcx6o/HaA26TTlyqldx5jcKNSCp7SKVBt6DZbnzlQ54z0jzgn4KSyspHoiNvPovLPkKYkP0Zmw0LdPh9gHicHHQtpQoLJyCUkFUv2VaW/qFOZBJvnHp9TwJtzwqQsjyUuL2w4S+FDlAks
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LxoEkCkzr2Du0hBat2ALHvKNawjeuau5tV/jgpkCXEtf79S+i5eBqpHeiY1H?=
 =?us-ascii?Q?AWGGlJ4XUtlKq0uSPUlgXIw5Y3VD07rS82nNO2nvu3VygxE7O4p96D8VK3YP?=
 =?us-ascii?Q?2BvUcFMA2zcp533ZM607N2pN/3SQvlPXpQ+eYkM/3l6ho9/2OqK4kFWvs84s?=
 =?us-ascii?Q?yOeS4D4sT0Apvnu7mmslI9hTCu8MOicuHL52hitW6WpKlHJUvw7ynIw9T/WA?=
 =?us-ascii?Q?JvHyUqo83AalG/p2c/aE8lvh0LcM/h5Cu5mch3zWdB9CjbRqwmXl8Nd3oDdy?=
 =?us-ascii?Q?khKNWQlh03TbPVBqN0ahBkebOhlKol+DzcVbMWGWt/zk4yj5pyUd9eFabNnl?=
 =?us-ascii?Q?JuJ8F4JDq09DF7TddWoqemLTB91aKOWfvY971XI6N7PI7nDuo49MtuVY64mX?=
 =?us-ascii?Q?+BGbBJIYxWjJjO/ndsq0pnsIa5LFk+PsSMMwEvnyLD9cEcKj2ZI9hBWU4cVd?=
 =?us-ascii?Q?FipbBnXiHzfUqtTANOPWxEDAyG4GajYGVGSafDcY85eaCLD9vnola/WJKJED?=
 =?us-ascii?Q?h3Dzx16bNjFwZzETOwY8NLeOlsHchvZACHqucE6drtiG8e1UFD+8GEpmlx0J?=
 =?us-ascii?Q?7KW+d73j4PU7bWpnU+3zB2A/98NXfsWfRQ4e/HPP2NqRUy7OqrD9fpmAMfYt?=
 =?us-ascii?Q?6RhFqJ5Yvg6pB+PwVXf8+ZCyb1NxaMGwfi6f04fBNkTE7CSyYICGtRibiQfo?=
 =?us-ascii?Q?8hU2LSkb21lJ7MhXltfyt3aGFeFYiGYWttIcFnwNlycn9fARtw8bagbH3vRd?=
 =?us-ascii?Q?eFFjQ5ddjSz47GHwuLVKWdrmF1Pf8RELHE2AinMsTf8zdZNvBOba9SAflk2/?=
 =?us-ascii?Q?yLxi3cXH3paxEKF0MNguu0EeD0cErwr0EW0A5xni7928SZVnjocVCgN0iDgm?=
 =?us-ascii?Q?DL03Hp6KvtFizIGkJ4bk43GrEUjcDXNlKa1f7PdzLsfJZnVGMfZQkkbpTMJj?=
 =?us-ascii?Q?HLAFnxjC2KnNSLjeLps6VtOwWzdjKn6FFbe8ZdC/FpOjTRYJnn4k+EJpkAvV?=
 =?us-ascii?Q?7VoM/Z2G83/AMCqgwnKvVva7Fky8vCaACDsNyOuDQxvSTYuzzM/Le7v6qVUT?=
 =?us-ascii?Q?U7ofCmgmOLRfyianRsuHxwIE9UlrEkDQ6FHH3k4h0JN2WUew9wu8xt34Wnok?=
 =?us-ascii?Q?5xL+pf5J45ImpE4ag+fwfSGqm0avZ+tIP3QhaolaIy3nZtVstEJyKLS8b2PZ?=
 =?us-ascii?Q?5LkUxOwPr4lf8YsJgv/uoxxT9YNfsAtLbdO1XG8LR/re1QJv4yazRA3ylQj9?=
 =?us-ascii?Q?FuPnCXGWl3rLwrIJnn3LkKbCvtB7lmM/idMiiTd13zv8V5BvUpTbtq2GZeGW?=
 =?us-ascii?Q?6qChZOM05Mrk/XVAATAEljK4LL+/t9X2W+3uuSLRWpbNrA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7c51c4-14e1-4c55-ce4b-08d8e7a4bd3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:21.0960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZAYyBjPf/8ZCK2XcCgXekUqpHVhf54vICcJ8rUrHE7DP+y1/ysNDX3H2KCKpG1t0Cn30PBsP7awuqwe28WwvQ==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Atufa Khan <Atufa.Khan@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Atufa Khan <Atufa.Khan@amd.com>

Not all ASICs have same plane capabilities so need to split them
out for proper support handling.

Signed-off-by: Atufa Khan <Atufa.Khan@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 2 ++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2088508dac1a..d26472ef1572 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -155,6 +155,8 @@ struct dc_caps {
 	uint32_t max_links;
 	uint32_t max_audios;
 	uint32_t max_slave_planes;
+	uint32_t max_slave_yuv_planes;
+	uint32_t max_slave_rgb_planes;
 	uint32_t max_planes;
 	uint32_t max_downscale_ratio;
 	uint32_t i2c_speed_in_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index d7fcc5cccdce..ef56eab4e5da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1272,6 +1272,8 @@ static bool underlay_create(struct dc_context *ctx, struct resource_pool *pool)
 
 	/* update the public caps to indicate an underlay is available */
 	ctx->dc->caps.max_slave_planes = 1;
+	ctx->dc->caps.max_slave_yuv_planes = 1;
+	ctx->dc->caps.max_slave_rgb_planes = 0;
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 33811953585b..d079f4e491e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1422,6 +1422,8 @@ static bool dcn10_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 0;
 	dc->caps.is_apu = true;
 	dc->caps.post_blend_color_processing = false;
 	dc->caps.extended_aux_timeout_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 9ae12a87d685..2307b3517821 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3703,6 +3703,8 @@ static bool dcn20_resource_construct(
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index bd8e4c0f92db..e62f931fc269 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1982,6 +1982,8 @@ static bool dcn21_resource_construct(
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index a3ac7e275f3d..deab48806fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2568,6 +2568,8 @@ static bool dcn30_resource_construct(
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 6358b2b266cf..5f29a4f85ef2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1766,6 +1766,8 @@ static bool dcn301_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.is_apu = true;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 98b464e8b25e..daa16a41e6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1483,6 +1483,8 @@ static bool dcn302_resource_construct(
 	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
