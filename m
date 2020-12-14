Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C481C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 02:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041B522240
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 02:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041B522240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D14B89D43;
	Mon, 14 Dec 2020 02:31:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC2A89D43
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 02:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyG/RF5z66kgePitlAhXvNmCSfSodPjoRq8TGrcZNdsMtAebKvLyHoLadMne7T4E9eJt+GrtjlQ5jLh+6JBQkMoDTnZIisHCgjMBQV47R/SyyuQWAEmdlaqlvvUH+NYupjuOCJhy5Rt0QUGBr71H1esZu1shrKgSyxZQQ+fojbGg/EW4PTQYfmeofeuxXZ1zLBp8svOUJY1KjhPbj5Mhz2geQNgFORzGg+Wjxbi3QyGa6bbMlX2nj15Dh0WvILWSvjjoWkXx0Uy6yEi75ZyZghj14mitaVx876FhiVHPIyXg9v+Whzcrwx/oYNe+GlunyrRZar3u2VuH/dnjOAO1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3D0k48mMA1sPo3nkH5LUdp0oOxUKL08i0Nw6eaBfSs=;
 b=BE4n9O7nNiAAha8/OZj8LCdexvp3oHZb9WEWrceLFtgB643qhtaroRdoMCUppbDxyk8uYStBjCVN56onalsaeCprSbfgUZ2J9NM2MxbzWzM0l2F2v61/J85wUpafii2OXmBvD9uamtjz3vxYUthCHuGsTEEwrTJPUg2kj3bPB4YB3GvjIsPT4yTxt+B7jLfy40Nd2ZQyUsSKfhosuIbbNVVbUGrg4CsC9KFkvYd4AO/YGV4RUufzlbNNbRZ7KYhV6UJ0jOPjgNAsVUPsvdWp/u7Z6nMZrW8mOdfNoabhQvM4JrmYQEcspSogdCaLRM+sja5gt6+NFtsrws5+0pIVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3D0k48mMA1sPo3nkH5LUdp0oOxUKL08i0Nw6eaBfSs=;
 b=JV62vlbU5KRGPbn48XAgzDB05SUABd61TyDDsj0QzAlJUHh/ZFwWuL7JwfkChsX5MpcFhf1ga1VEU1JWR3n/GUsw86F/nzPSmTMcsM8SdGqDTzS/woccpQv2pZKQjjUEgyWGuyufjK1r+pUI3q9lVTHP2jM8B1cxZpAyRO22D9U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Mon, 14 Dec
 2020 02:31:46 +0000
Received: from BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28d1:9bc9:2949:8250]) by BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28d1:9bc9:2949:8250%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 02:31:46 +0000
From: Flora Cui <flora.cui@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: drop retired CONFIG_DRM_AMD_DC_DCN3_0
Date: Mon, 14 Dec 2020 10:31:26 +0800
Message-Id: <20201214023126.61332-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To BY5PR12MB3762.namprd12.prod.outlook.com
 (2603:10b6:a03:196::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from flora.amd.com (180.167.199.189) by
 HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.9 via Frontend Transport; Mon, 14 Dec 2020 02:31:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccbd3337-ace1-4310-3b3e-08d89fd86717
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB308033845699216BC45DEDD0FAC70@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtc9FYb2iGEbVET9xQUbm9O3YV/1YrP8NRav+KfR5mZ0rldmRtdB4Hf4gdhwpPXXchuAN5Z2vx2alIkt4h0z0fW9RdsAkUHGnbTI7cTgCb3cQ5Rf2/U/+3IGCPF5FB/qyPtqJ0u58td5/MadIs2dGVmdQKf+dNWp6bgPp8spzcWT5pIiazKfjUNbye47HP81f7SCJd95vdUxdZCaXxAlPLa37v+aj+Z2jV/j1Do69BNhoJZOZHsv2i50jfLTh0rlJe1qGQfsmOu9zJEEtSDPihxe29ZiDd8OIB1Z7lUEfb7ItxJ8M2Q5h9HOGcGJ3xGKc8eCX9FH7XkSQtLUGfBXWVaBjBdk1/cBn+FWRw3prdgRC78EZQBvw7IO2G9l7ned
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(2616005)(508600001)(44832011)(52116002)(7696005)(66946007)(83380400001)(1076003)(86362001)(6916009)(4326008)(66556008)(956004)(6666004)(8936002)(5660300002)(4744005)(26005)(66476007)(8676002)(34490700003)(36756003)(2906002)(16526019)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LiSeaQTKmZe8XIXSqMT7PFHx8h2KXEKS03OspQUKwSDlotu4gU5sCPt+P/Mq?=
 =?us-ascii?Q?wObZ1A2qBjSLulCJml1jRlTNsy8F8DHuUY3dcXzMfWtcRSTz6N4Y+PyFS9JB?=
 =?us-ascii?Q?7tIkYv1qjN+WXTU10YdYUOWff2NMGbt+snpkSvWj+vYsBTuV/XF8+o3qTomL?=
 =?us-ascii?Q?brDP5wJjrXoA/BJCMumrp6dnGEf17kw2R5OgHBvz8J09wy43AEc+bur1Vj4H?=
 =?us-ascii?Q?0PNsetVG9NnXiYkTCT4FiNfNf9ZdbY3TIb81IGoyJoPlXMnmAM1Ry+9d/5sc?=
 =?us-ascii?Q?/kdJdZyel1kHxAXavDR6GQOh0JDtR2WdH1lQJnbcNmxbpr/0ESbO2Qij/fOE?=
 =?us-ascii?Q?Tz5fasohNGcwkac96GWU8trxdG3+Vf0MxHYJAx3+BLzsp3zwrUMMnlQOmXUc?=
 =?us-ascii?Q?9VKAfz/Wu7l/imGFvH0TBgXxQ2n8Ag9OmuGefPHXI2lEyWk2wpBdnG8SaGH/?=
 =?us-ascii?Q?cuGCtdh/QUkUHiU10sM3U5pkleIv6ONZG8GWcs0v2X0vVcJmlpA+Y8oU9GNp?=
 =?us-ascii?Q?Smg4q9Ly+YQ7cNe8i+unK/Nyj2o2jb5CgGwBpZR6wkgtpeYni7mTSVdv03Ju?=
 =?us-ascii?Q?mHgT2l7x5w39/JkwKyRvOvCcU7r8pqSsZnRmedXHk+KITcx69b1rizT0sdiM?=
 =?us-ascii?Q?BVfAbFWMlA7GcxCEO2p3a+9DeJ2VoCFd0rpwkgCImq2fZaOrQIRxJlLNWwce?=
 =?us-ascii?Q?cxw+tKpykj9XPmInQgB/6IlEtJhsAX+Bfv4k0It7UIldMu5+Nxe1GwSq4kFY?=
 =?us-ascii?Q?8nCpKiD0665UjqtJHwODAvZf0HSsH5FmyQtrvaoYilhB12rCrmdZqdc4tClJ?=
 =?us-ascii?Q?4F5nM9Nafx70kqqFK2MmJ7TEog0TwkVwmxum39forxGJIQ2V+1myDX9g9zXd?=
 =?us-ascii?Q?74yn4KpbGIMccV8sytqC5CIK7U1D4+AVWm2nGB73q63VRAgncpTDU4yd5mTd?=
 =?us-ascii?Q?sBey6Sz6Aai7GdchWzafLjoydv0LiuAeypiG4ijjijFQ389qB/H9oAGxROA4?=
 =?us-ascii?Q?fLao?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 02:31:46.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd3337-ace1-4310-3b3e-08d89fd86717
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jc9IsrMF0k7wb2FjC4XmDxrvoa2O55Ed5BAU8/Tc1A8LxRSsKtuOu7T9Ry1C6Q7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Cc: Flora Cui <flora.cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CONFIG_DRM_AMD_DC_DCN3_0 is retired. drop it

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a901baf2aaef..9e1071b2181f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3267,9 +3267,6 @@ void core_link_enable_stream(
 			}
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-#endif
-
 		/* turn off otg test pattern if enable */
 		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
