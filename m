Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F90BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D7623A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D7623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CBC6E8D2;
	Fri,  8 Jan 2021 21:51:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFACB6E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJVY62UStPFCmInCK+dloT86EtwJGCK3k3qFcX64V+7XNt/Y+0xoa3p65e2qZHa6ltKuIJNaxX6j02XvlAQVcFo6jeIBu1uKcuiXXmKxBqgFmWP0kmxCRPqFiK/EQBAiIoezAL7fQVKKf6q8W+uRGpkmbDkwFw9d1AoPEp+zBwq/z/Uxy5de6t5E772TIqJffFdOWtRkZGUD/2cGXp80aM8eqZLzsg36KoERNURB5yWTaVb6E7KKsDJKeVQfyqmnAJ8lR1kE92RmyMYGZm3LGDpn4HL7kUKNzfeb5TK+VK+m1zGLQ2gUHW3YThwwwbe0+OTz+wsVkwnl4rvWNIioLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgIVF5VfF+wBA/rq7vOwBGjnASH6y41TzFcnkbTtRM8=;
 b=bAbudrFVBhXYerIeCWW/2bhoMrFN373Y2S1sEQgjFV+gcRFCkKRFzXPGJxmmiuuxbS721C1uH3Q2vnfEEEvuFssJKf0h+Qh/eeXYjKZbvG/NtcK5OvtrvQK0QNJSTJ+LeYlXhgeA76vyDDP+jDecUtBDcOKOd/o+ZWWB1y/mVnqdKXvNeIx3G8Ec+6payKZEpbMgRg6tRry7R5WD8mZK+3+SJOzq9r9SASLlMsTgrdggsdfOy7rdi07LEbXz+l8lkgkpHZ2yKQ1Y2DTGlZ2Ojr8VxcD4w6j3jSphkk2pY3f6D03u1P5d8ZLqcHPD9zmWrZPGLIQ/QW6zRxU6f0uuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgIVF5VfF+wBA/rq7vOwBGjnASH6y41TzFcnkbTtRM8=;
 b=VG+iIlkLOxbgBrwEzkWqsaja2BuO32LGqrP8VS/vPb5M3AMR2VMU81msvdi939/UvYLULeUq91wUkI3+ObIRq2ONM2KZo1Czq5/aCyHLbiblsMqe1XpUr0cn01Ju/QKmPAuqMFxdQwMzNVvVB2MemiYHFaMKXaElD8bxg/p1zSI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:51:21 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:51:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/21] drm/amd/display: disable dcn10 pipe split by default
Date: Fri,  8 Jan 2021 16:50:06 -0500
Message-Id: <20210108215007.851249-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7d0bd9d-056b-4ebe-9e7b-08d8b41f8926
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882404D62F59173DDFA575598AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SapBvyuyHlP2IXHmrx0g0AiKo5Y2tLwCAqRiOqI9+h3FUkQwcGuvTl00C1MFKb3nFYUW9xG7J01KSRtsd2EPxjiLKJId/mBDq/ufDmr24kojG6DyyMKWDaPYTO9CzGg6Vzkf02ZtlYIz+fYS2PyzLlIbd/ooyb4N30xdUXKRRyMMHIMQMAUV264BQzLSYoGpXSz0S3/MzlS4sZvM2HaxuzbaobT2Sa9NXxO3r2aEfQ+Riiq3ScajrnmnpXxPkenql5ThNvAgCiDvsPcdHkPduyxrM4MsyxZQYLWmtEUSZfLECkXSSPB7ynZ/OUo7FoswZXjXCfmwc7UYRvQAx83fEvk9h3Z++ZI81ucm2Evoq87XUmENo3qk4Y5uWnvVnB8JKEDFSsC9Z799i4WfH66AHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CN2lJ3tVpFPjCdq82Z2j8VTqGbrMhLn0wiKQWJjvE+t+G8b2nGmVYDKuPNRB?=
 =?us-ascii?Q?r6XwwEI/tDDREwAU2glo3lyvRUF7He1kY8zsi/SIjxZmnjTl5eV1Td6PlAnG?=
 =?us-ascii?Q?HKeWg0Szx3eCTXv95q+jm00e4RsehR5KhbOgYbdW3x2jFeXEBd66abzQIbsM?=
 =?us-ascii?Q?e5GKI5exFINbEVDhP9XppOeOTaZ2lFenh+KAE13NTFT3ikowuJJ7VJtbvzWm?=
 =?us-ascii?Q?1o7s4h1g+yyV/DqBME+tg5fcB54qnZe/LCE0qIgYG90hBLFVLrc0Heb84zK7?=
 =?us-ascii?Q?sp8xy1KU3frcbKlserV3pz131W7uS/ObGML/HpqYLJ+xBJnJOlCVoxj9VolH?=
 =?us-ascii?Q?Y8wTq7k83QmtzBdEJbFmGqAPvlTuY1fRPxZyMZfl4tfaVTiJ0umQBH7PvmtU?=
 =?us-ascii?Q?UqOLo4mec3IYOLOO3Xt2p0ZVTHtOLHDDQuWKrQbta1VrB4gpqFK1J8gL+vMR?=
 =?us-ascii?Q?pzhWtR3FID+DFj8IRNLq3GpY4CkUWjDK8jqp1qrJnkmRtKKsio+fjhb09Dxb?=
 =?us-ascii?Q?5l2GeiHXfkiGgqBup7RXF/Osza7D+wPTZr+ApIFHob+qtmcVgW0Fg7vgqAZz?=
 =?us-ascii?Q?FF9++sRjX0f1BzzHXn9fn/Z9om9CcNkrglguHYBIXMSCoELoj42Gc8fb5SP8?=
 =?us-ascii?Q?7t07S0c1Tq/KbuHWG+mB4IwmlX48ie60k5UaezjT+ry2HTL9kbW9fLaXeXEH?=
 =?us-ascii?Q?ha+wQZ2ZEYuFfzzfNkhMWAWyqQRrsd8acD47tQT4X3XvxvSFyp54bx52bn+o?=
 =?us-ascii?Q?J9GfEUdNFMcWo1nEwgdjANhoo88bpwPe8sq+cJsocRc3CuQ3VvSKqg3KfbLN?=
 =?us-ascii?Q?b9WGn0J7qwmxvR3kxr4rh/7wzFuYpElFXpSXHlH/lXWJk0xXGsGx0ZqmFrDS?=
 =?us-ascii?Q?2scwG9aDqMD78R1q6ir6VzkSiqeKofaJlEu7yrAGdeoXJ5hN3Xg6qM+vsvd0?=
 =?us-ascii?Q?pOyRLxpQcA4vBUdd/3t6puTqBdJkFaEyLqm5ZdxeRbsTwAp20wvyriy8wwoP?=
 =?us-ascii?Q?dEasD5H4lP7KXUg42rCqZ9QxwR4bZR8MnghqlTZ/2sU4QCXPvMtCzWVTJfLe?=
 =?us-ascii?Q?z35KkNOd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:51:20.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d0bd9d-056b-4ebe-9e7b-08d8b41f8926
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHg6y11hBqbUIkpix3BclK/lAdwoJariWPyFY/k++7qZWTaCwHulG2ZDubs7mPv3rxx93lUZS+b5wEpVda+pIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, "Li,
 Roman" <Roman.Li@amd.com>, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Li, Roman" <Roman.Li@amd.com>

[Why]
The initial purpose of dcn10 pipe split is to support some high
bandwidth mode which requires dispclk greater than max dispclk. By
initial bring up power measurement data, it showed power consumption is
less with pipe split for dcn block. This could be reason for enable pipe
split by default. By battery life measurement of some Chromebooks,
result shows battery life is longer with pipe split disabled.

[How]
Disable pipe split by default. Pipe split could be still enabled when
required dispclk is greater than max dispclk.

Signed-off-by: hersen wu <hersenxs.wu@amd.com<mailto:hersenxs.wu@amd.com>>
Reviewed-by: Roman Li <Roman.Li@amd.com<mailto:Roman.Li@amd.com>>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 36745193c391..90e912fef2b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -608,8 +608,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_pplib_clock_request = false,
 		.disable_pplib_wm_range = false,
 		.pplib_wm_report_mode = WM_REPORT_DEFAULT,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
-		.force_single_disp_pipe_split = true,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
+		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.voltage_align_fclk = true,
 		.disable_stereo_support = true,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
