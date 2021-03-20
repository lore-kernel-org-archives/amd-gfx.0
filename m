Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEDC433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6681B6196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681B6196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331276EB1C;
	Sat, 20 Mar 2021 04:19:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BF76EB1C
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEEU3MSf4lQrWQC41kOtmkHAKufkffM5HGyFpqUxMTeV8vJpywh3tikJ4KnN1CmpL785MXfQnO7D4kinHUvA6dJV37OKxWlPcoE4D6xhjnDvBCiI6UUG7/xR/7O8z5Ic1xnbXdXtRbA6H4TRjwIpUKjbuifIBAHxsfaVdHT0wjN7AbChU+lE8Paac2kdIR94+7YoK0r6BaPvGnoNYTb2FQxhqXSbQkn6zULcepmIp64fN7sHy1ZwzpGKwRcVIPixrftWVnXe0XX66lS6ZCd6vu2qw3PES2dFLOKSx26FBoKCs8+YFJE5qGAa3nBdJ1HwJ1Zqv2AZHDuYeCJV/8MwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzKpeRoDWRt/7GdwIjj64UZjEVzW+6nd4gbJI/YPxMA=;
 b=aSjVmYCYVGEmjhG3E8D96SWB/PF68TNe58Vs8OwwPQXtlFJmUK68HGieSkFNeWNXzzrWM8acpRf3eRZZQKRQzl0B0WpuP3Xfg78d1c0fnIIwJQaI6JCpaIFm/Dw1QkGiNuVh8x1FTQIHw0RnjCw3gkPrBiGIhzOFnryFUH004rns6U+G4P+hv/6Pzt9my+i14Dzq6q1y/W1MZ3ONcndlb1EXk9PuJwu/wQYzTmph4R+uJcw87XAkO/jtVxzUAtf15WsY7AUEsOvCAhOomtRzRvH7Lisry9ZHeyY2T9XWtsPK9m6Mu/903sfPgwQrN2Kojae+L6LI3b1+hKpx3osKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzKpeRoDWRt/7GdwIjj64UZjEVzW+6nd4gbJI/YPxMA=;
 b=ZmuaJITd4wd9WO17kr8KtPprjBoOvt/9oaFebIiMln1N4yn9ionkmBV6eSIH7agHLlVZtMFfmjKvv5+tXVzSex8vVZIey2aRhZhzy/BPox2AFcblixrRB2zosnOK/UxUMprn6VGt7Z8FjUN1/dw6motIO0w5DTqzPjlyy3DbRJY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:11 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:11 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/14] drm/amd/display: revert max lb use by default for n10
Date: Sat, 20 Mar 2021 09:46:49 +0800
Message-Id: <20210320014656.23350-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b31550e1-870a-4a44-9f7c-08d8eb57501f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704072FCA70B9E3F885333197679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqIkDwzn2rnbzfwQ+1p0qvUknTc3N6qBC15L/gCnN7G61z5enMsjkIdeGylD7Md3yC+hdxCl3wl5tDmxhpsiS3gTKv5uH3OpXVXlrk7nkKkIQrvaAWTipTgNTuVL15/Idwn3CWFOvHEUHe4plLftnRAJNJ8Q3o2YgVOw5iaPjHpj6HK+L8WgX1nGcahumtQgR6oxF6gRW95oB7pI+UyJgBurcCLK9tc0b5EkGHkS9CRgXQr5xLby/cduO08KRG2JGr9y/rhzsSPtuoJVUuATH80YCl2LQK6DGNGGzU35omAmt6UCq2Qu5mgClKcbKQ6oaHEig6k5J7FmGV3rL/sK1cPNlAdQZ9foLT2eGfc0fY6OkS4RAVNZrKUbFy3EP3SHELdhuVNT+Z9STJksj7mOW/nxTIFJJxGVB7KoNsCuYhnsI0iAlP4m9JVzRCIyfSGZFAGuXI4ZASCziPc29xp8pYc8uXnwI5arUb23rhiKKeQUk0AJbuUHR63fdFRIJiVgyG7bkMb2Mfa3W1PupKlaoyEROa9gVEBxyERcAqoWvUlL/l/dMQsrmrjKzdD1AHy4D5DYVuOslmFngEaOes0tTYIfx5MwWyQ6exzHBYQq1npbiFBRK0HtJUoaJD2EDXUJNF8vtFJ0cD+8NNInzWdAK14qKcxkkvNHJ/KUKzOondI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZsuFU3RPwMXDYXNixz0ZzRZKEVxl8688ijRR8hDqt21/typwJjNUHH/ReI5Y?=
 =?us-ascii?Q?qGqzOAHnk7OPCQvCwaRbtTQT7tUpnidW+W290JQla6m+DTT57Day0SvuHcJs?=
 =?us-ascii?Q?5qjwVi9177BeVeOtq+yIolBrAKA3qZ6PRCqMd4cAem+l7QpoNCJQSXv1A6cv?=
 =?us-ascii?Q?osq0PEGFz71IPkLqyfnGSYHmKIkoxwjzz+OZmXD/KlyqQf7ventpOgs9JD/R?=
 =?us-ascii?Q?MGmuuyIdU/3/pNl/EYDV2HT2YKgfNYyosR9Yv4zTjf14Yo0p9rzJgp4hNtmd?=
 =?us-ascii?Q?7Eq1WQ4MNuYJ2LZOlezxGDEYbkTIw/Kbm8wpU6zMkC1/QpdciTphwWwTJAoO?=
 =?us-ascii?Q?Y02PULpgtENVqQ0ia+aV7rfTOrkSCkTZK50nnZCMx50RPJb6KYRV1kL3xG6Y?=
 =?us-ascii?Q?BCOTdQXy1W3ePCxd3jhMENhmN5w+j4OMjlefl4dWAzM0m69nu+qA92oj/7IB?=
 =?us-ascii?Q?fjqMp3Mh0zss7TAQRpsRRr3wAuKUwrp9jCQtl9rMBk/V+ZZJr19jbhsi9M6a?=
 =?us-ascii?Q?JtHLnJeXYlKZ621t6pxTvAsEcZKMgD1KjCqxuPaa8EWIreKW7yZLbl0cisbr?=
 =?us-ascii?Q?E9q5uR+qNHAS1qUD89lmZ6AUYqWHPx58FC1Og4CQCSaYzwLEfTmFQzNpzVve?=
 =?us-ascii?Q?RfZjm4HbQ2YwFL3Kc4X60UuBHAy2fWwNcct3k3pmGx5wi9Ecu5JmAwN+OuCr?=
 =?us-ascii?Q?0TaO0G/FE1v8ML13iVls1pl4Pq4D+iZy3ErymDOA2wt4L8q7D2SiJN3wghBa?=
 =?us-ascii?Q?i9bATBGH4Cd9tX3v2xB2cYiVhl0I+xDhoa+66P5YBvzAphEwvB8ahKyXHmt/?=
 =?us-ascii?Q?ibZoqXoHCjGt8qnPz04XcKvsynYl6jt55llab/1ORkK7K1SvD0t6k5YBJd5J?=
 =?us-ascii?Q?UDQqbgJ+U4I1mjHISudwgjze5RVMvSP9BeBmqQGNlzbslVt82an6KGdR21zr?=
 =?us-ascii?Q?nIzZR0QdAD0wsYHUPGtkBHKWEpP0fSiG0i7sTK1/vguG8SbJv+LfAeQejPDR?=
 =?us-ascii?Q?69cS0UT15jD0TeIY+HWWekrAx/ERBLSbIR0wIuEIsrJh2aMmKt3BIxwSoqt9?=
 =?us-ascii?Q?Q0S5yc2h4jhWFtKyv91PeE/3ZFz8pms9HAYypLJP7G6XHkrDSn79hmjxB26C?=
 =?us-ascii?Q?XTPrE+g+nHojulIjnh2ZwLt9BFETog/rjs+lymY+tPza3O5H9vQGTSSqHiZb?=
 =?us-ascii?Q?41K7CLMp1/+9Mmilu/3q7W0nirW1rd1skc/7OkUk1JVkcwGWQM9xZ+p6APzm?=
 =?us-ascii?Q?r/7rEvcSFzPXaD3lBKZO+5w1edqzhVtd2rMt5jcRBkcV0vYFqLDvKZECPWRl?=
 =?us-ascii?Q?2fZRD1PFhQQebBn1qDZqtXhj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31550e1-870a-4a44-9f7c-08d8eb57501f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:11.5035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ7p9TYHWBf/9DqB+Wvsg5pl+EZi+3NrZDGthCWVkPjUCy7gw3rTl8YuEBuHLcRYH8hVIktsqkB1PxPtKtYhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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

This is causing a pstate change underflow regression for
unknown reason

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 2 --
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 0b1000d782a8..f962b905e79e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -619,7 +619,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.recovery_enabled = false, /*enable this by default after testing.*/
 		.max_downscale_src_width = 3840,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -631,7 +630,6 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_clock_request = true,
 		.disable_pplib_wm_range = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.use_max_lb = true
 };
 
 static void dcn10_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b8acad7acd94..28a3b4185424 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1075,7 +1075,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.use_max_lb = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -1092,7 +1091,6 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.scl_reset_length10 = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_tri_buf = true,
-		.use_max_lb = true
 };
 
 void dcn20_dpp_destroy(struct dpp **dpp)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
