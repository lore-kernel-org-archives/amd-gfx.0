Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C7EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B39614A7
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B39614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282936E30C;
	Fri, 19 Mar 2021 02:18:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F4B6E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 02:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVtoW8Gsi+uei+g9ZmJtlXyVy9895KVpGKVrhSBJqhBd7hUwCAp1n6aVBaLmZuNvRMyrT/P6aktP8wsgWBDPbGXI4CX9PvS5kdww5GcSxf4D1FKgS9VthXIJ7lCiLTlpVjhY0kWe6fLIYp6K/+hZ5vVuUtB85I9NKYR2sR6MmAfXQfBkItsoRtrnjCKekmW4gW4aMe+kZKZLilRzf8x1jXeTePLSboAsOrwQl1VmfqIgNXjzzD8MU4GMLjfE/KPkRS1tIQvn3QpU6bGj+oHXLdOvFI+TuY7FyurURi2K2464BuEaKPNQ979qVqssgww4tYhrAGHqq7iFfQ2R3C6Aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEKjQZ9HGLarZOPLbEKPGxVTuSNkkvO8RXTmNqW5qYc=;
 b=JDSntIqpk/+O+HSiq8ZO4zcvGzTduCrSOYXXiWcrtzI88m/MdX6PM7PvSUNDN7b25KckhoPWbyVnF8Y3quA+bqt17iyEsEXEZT3MgjmXoa3g6RtlU3XBr+hwZtKI9zk9aLluFUJZtWCPUlbdgPr7BpLlP4WAVIxnx8nPJ2sbfKzH43MsckIJZnqSkhNY9K6RNWLbNzP/cgWREkZ1CBs0Ir0tKYpZZnUJ9O2u6ZdRraD73eQ4ydg+jE8oN5cOh37M1birn/CvvjqC0K+Mfc9IJDj9C+jrTzKx6efEZZWtibhL8Pkdti3kSHD4smjlX/6LSQotZm5k+2GOOr2DpZiPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEKjQZ9HGLarZOPLbEKPGxVTuSNkkvO8RXTmNqW5qYc=;
 b=osuzPpAg6bUefA4ACmS+S0v2x1TnBX7OKOd46lULtn//+UgTvZNev8dxfuDPZPrl9Svxfb7anqTkrPNbl2sUnV/tYJ5RoJYSoZci0C6oKeOf5J6tvQ/RDlFp3Q2zhJCQVv4RRGyg7AaxDzqDYQPDkqd+W3ODcuQ52vzErhyW3Ww=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 02:18:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 02:18:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: properly guard
 dc_dsc_stream_bandwidth_in_kbps
Date: Thu, 18 Mar 2021 22:17:43 -0400
Message-Id: <20210319021743.493548-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 02:18:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06018b37-ce45-4418-a03a-08d8ea7d3bdb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4472C5C8A1DEB3448038B3C7F7689@MN2PR12MB4472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v75xacc4W2J+xOH4IenLBq6mCTSB5ycUcsJot3fDkSVuVFsE73UiMyMBx31Rm7oHWIHQxsPDpOvt0qCFGSe3Y/UNYKa0p639qv937q3HgSOojoSqUZGuIUJlruyIPkNu+eI/uFQZ6KdINSHRGDZK+wQwQ76pPHBBQDldx9m+lnl3cXW2n0Pjex1pcVy4P06XfbDMv1p837m3xLBBv3xskgzgokTEKSmuFg6gz/vlKbUZuqRUm/uoneBVewLY/9o1zuJjfyf2wRrj1LRciLKzyLVqqWQflxmibxzZyoSa0jVF7jgKJOz0kJwJJPfnFDIv5lodji54mBayHJ3gqHwHltR8xQ/pWbYkdGNkOALa0Lpqyo+WqKvbvqf/eZqCQ3K4GS9be4ngMeXVJEihZIItrqQ8ldlC3lH1ePf6CtYk0uAx0NUDe/dQHDPltYam7iB/GIq8x5KPYqnSbdZ+xRUz2CWpWT08kXDC4BsDSNSxPqFWZh5PH+fKzXKQrwcOPHVzFc/L4FbGn4ltmFInwJXxhP/rD9LK35G98EtogoR02gc6GiQpt03Ot94+0FMXVrlhFVWRRWtF6KqG4+smGX5ASW7FWlHW5cY8JtOQVlO1mnSq9BjO5WxZNOVh9XtVtspex3jqWAnMrauF6WTbPOGOucmH4eVWGC7a1txNTxqx3lA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(478600001)(6486002)(6666004)(2906002)(36756003)(38100700001)(8936002)(6916009)(4326008)(83380400001)(2616005)(52116002)(66556008)(66946007)(66476007)(956004)(1076003)(54906003)(7696005)(5660300002)(86362001)(16526019)(8676002)(186003)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L8AkpvXQPe9UchC7KLKb7jW4SycUUKrH+Nt8ImObCwC8oGOIxtAxB3blz+XA?=
 =?us-ascii?Q?wbL0mxRn8LTvwA1rjQ3YNdiWCpAqErasjq6GjDAhL5po5bgzfHXklnafvc4i?=
 =?us-ascii?Q?4gsEEEzxZgHLHN6tfefbPZA9NILI0L56Mqr7iBY3cOMGN80TaxZNZp/P4CKQ?=
 =?us-ascii?Q?nnJ5fGY/T3WsPcRhrisKxhSohgBZkoAZAe2F3DCIoYsMuJy5oa6HD3b6w2Ty?=
 =?us-ascii?Q?uQtfsHZSuuuudCrm/Ie8aVhkPLNAPIX/TDiZ0MtLSac79mxr1Sx6sbXN64sp?=
 =?us-ascii?Q?nEpaq4Qcfe+O6OR+MORzDQUPEnp3VFbdl8r23uWwsrx2/5PcsOnGZVsdJcTk?=
 =?us-ascii?Q?pvqCcUu3EhFekueJ4MlVN4sqqfVio8gLB0uekyKk8W57H5YBcmUJ3P3gPubm?=
 =?us-ascii?Q?2j3SXCa/ZjB7vUiZcZdLdwmlOVkaDofMjJWLBPwK9/0FkXNfbYfMvI4u4JAA?=
 =?us-ascii?Q?zqvoI3g5d8nVTuHUNKJQ99I3AIJ1td1GHV3+anLUh24/FMKL+zvnRPIiiwYo?=
 =?us-ascii?Q?IPLikxzgoLOhGYB3QpZuKDVznB5a/RhZDdYeq+3DLKZo64LLhf5hCASjfCQc?=
 =?us-ascii?Q?Dydpv4o187tdS5vBJmnDnQsIYcCpOIisdlpr4hnjfDBki1oNoqypaNv921JO?=
 =?us-ascii?Q?GGJlCEfQA7ZxVfXTdjelY8nP+2jTR4HAtVJwN/c2lTaaT1K1IYxcgaxZW4By?=
 =?us-ascii?Q?QtrkVwTTtzuvCVZDbN4LfHaeLOpF3bCj/JjisLOJ1juOt2xnGqIELruBeTgP?=
 =?us-ascii?Q?hzR4luE6o6p5YwWqRjUDUYc3YkcizqLl6AnmxmFoTtu6rnwqYEC9r5Uu9yv5?=
 =?us-ascii?Q?mn+okrBIPVkQVnW0Et5ys3MVxLm832248o6x0zGwPOJsc2bISYpWAgGVe+03?=
 =?us-ascii?Q?qnYfsJR6z6T9KxJeWdTZ4V3C32MTN4LyhQ93/1HImQm1XTKc0NXAPfYzUod8?=
 =?us-ascii?Q?HOU2QsIUcFOsUcAkkOjcN8Fe9wgjHk3j7oAGLcLZC9iNDmu1zFS0/ZjhXmjY?=
 =?us-ascii?Q?m77Zm4xwO1OwjFurowi/N/VKmco8tgCkcq1yM9y1gDlqCDN6Fw5uyxr0qFCz?=
 =?us-ascii?Q?XfZ9xI5oknTcwiWMEq7T+lT4+XWpSFKRIgr3oqa6QzDRnWw9wThXbBjDjtvQ?=
 =?us-ascii?Q?9j3T+/cai1eB0In02GWbJlIkXIoW5PbGho28O/wQZ6AYdCTjjpmU5275xet3?=
 =?us-ascii?Q?/QXZylM8fJbkrL1yLvszHXmnfrG/QrmNNl0L3Bq88chVoUc/qkpRILd7HwmZ?=
 =?us-ascii?Q?elRDkaF+W+fSGB2qo/s5P9/qJweiqI+EPwfo4tXhATL5/ze+bMNZgi+Zp7mS?=
 =?us-ascii?Q?c1nhpO3OPXEi9zjDXohENgOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06018b37-ce45-4418-a03a-08d8ea7d3bdb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 02:18:07.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVymzY5fEchd5K1HSO1gQErcN4xrE0O03+oYlIpinRZCi3+y3L02nH+6DreccjO8ZNY1igPim+6/UswSFIUeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
 Stephen Rothwell <sfr@canb.auug.org.au>, Dillon Varone <dillon.varone@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the function protoype to the right header and guard
the call with CONFIG_DRM_AMD_DC_DCN as DSC is only available
with DCN.

Fixes: a03f6c0e26b2 ("drm/amd/display: Add changes for dsc bpp in 16ths and unify bw calculations")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 10e34e411e06..f9a33dc52c45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3498,17 +3498,17 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 	}
 }
 
-uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
-
 uint32_t dc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing)
 {
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (timing->flags.DSC) {
 		return dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, timing->dsc_cfg.bits_per_pixel);
 	}
+#endif
 
 	switch (timing->display_color_depth) {
 	case COLOR_DEPTH_666:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 0c5d98524536..c51d2d961b7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -88,4 +88,6 @@ void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
 
 void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
 
+uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
+
 #endif
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
