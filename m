Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E7C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9774613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9774613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607616EE50;
	Fri,  7 May 2021 15:00:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133BD6EE52
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6RYC23N1spPrSOF1mjaf/pmJRkqLyI7HblBdZvTA33cLfFKrbFLao/j97/cQBPh9rP3xXBNRL3TxwWRFIC5Oob9UDr6R2RyuyJZZO6/+4MXnyJGpxcQfJkLgkeDxy3Q1wvKQpQ7b0v2F0sgc9l4yWRVAYggE6y70n2JFD/A9hFMZEwT2tqGfXleYuTgR0fsQyjrM2v1RL7OAtRtqe0k5eaaZ0B6CQWUV5FEW26Ly6I6Bzg9y3to7Y3ha9XB0c6ePtuWYQj5z06RRtNo5qbP6xFcAN+5l8uyXcQANV0zLXxwCUnAVuGuh787hQZrV8XCNYTAUg4XUz1qz259w874MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDGRr9qq3WnTqQsthsZR5RYt6CWgJ+r4raBg04cM28=;
 b=O0Tv8PZPlmiX8SKpxHgVY9HygFRCiy76nLVOyHe90G+2v2k1LYXf2pn6ewxmQWISLq/Au40HyW2eqyWC1GknAlwl5y5FgruX3buHROO/4Bqd33BNNXzyT0qNQ7Wp8C3PC6iLKBo8V6e8WldULpshIEJSwv63g9AXy3gxbaxBtDCHGowxZME3lnQQG323U2Rv4Hlo3yvA7nh3DyU3xc1Nw5sXpouI/70nnQF50M4b57jwI1+rYDszLTnlRNwBbaFu9lhMctlyLq9KhCYbMTBAOvzPs7ikiAAx/rYeE8xaGlToY6PL3W05mCILRKMEKnowN2ZHyDaOkH9jRAzC5jvyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDGRr9qq3WnTqQsthsZR5RYt6CWgJ+r4raBg04cM28=;
 b=r6O1WIoXehbfeO5T2dQOEpcEesPX4Pet0Wi+vtpN0WmJB/Uy88l9Sjm9kMUQP83r1i92asefC3/rwQpPgspbLVW/Ye82P6pTA6RE55CNELABML9Ko6NIOeF191A5dOye/1ApHLBiaja7Ylbp2ACpHC7YkQgGuyvl1aTpMY+SYxg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:00:24 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 15:00:24 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/14] drm/amd/display: 3.2.135.1
Date: Fri,  7 May 2021 22:58:22 +0800
Message-Id: <20210507145822.248029-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b81db55-4d6a-45e6-20e4-08d91168d740
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17868BC24572FFA151D722F1FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmD8FEHCHH3We9fplvN4DUyxFbkv84MuYCFwbkThpFhcqkLVFwdmXmiKps2vkJoEhYc91Zy9I9aJ3lCul/mVOd0dXH9Lfa49lJ3F62moYaf/A/mSYyBz3/8fDbJCabwRQ/mZR72QKHZhTxKZo0BhJQRGjDWHQWD9zpzBuhpEMe8ek65FNh2NiAV7iK7T+sFW2oav/y+RGQaK9XH9MLffzWah/uFBXDII+Ac+KtcWjeF2RwW9hnrZEfpD9vVzVbghX8Ww0r8ij8gEOzkBCRLuCyBZs+xsh/CfgqTJBWXi55qKPQ9ZND8URfKhbbiwCWqGHUiHGQYMtoqfOCLNkXPd6IPlu6hmslgcwUBakLAn+kIXL5LCbJAykCuDAr+g3tfE3on/EhNiihiTIzPjLynt7vz3x4Tpffnxv+vL4o7ePLvf1riUEEvlSNPwxuVNxxPHLywxmdGpBSDZB/9g4aYKFbeOhpdGQXlzMWYcoZLtI5Ogzoiw8avMlBSGZL+wj5nYGTI+9kq2qMoXWcdgO+Gl4G+vsxiKm6eWo/fPC/2ipFYktwWIyL0gOhJUGZQn/KZup84n8axKUzAJqaoSvzevAivPPLlgBQ3H21+jLnBVSnNDdizZOxOSEk5YYignY2+9+BAroIsaysuqUN9soFiOO+p4rzV09YsqAqKXIs2wG88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(4744005)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XKCa8kPRFWVzm/GlbQPMv/SKAneTTxOjYZ1YLplvOS/2Dcu68qeG6j5Z8nZX?=
 =?us-ascii?Q?oTocvFiDk6e6RwTa1Qp7j4QH2O+z5PRVyfsqSN+eF4t0mpDzihtb7/sUxhi4?=
 =?us-ascii?Q?5gqBMmqNklw0QYHukoqiGZlrir72PVHC9ORezwazrhEdL3Zct0UnP9BksCN/?=
 =?us-ascii?Q?pvVr88NOGMnb0rRXjCg7enHLVq65dlUbnOmWstBGPU9du8gEQ4tAxmoBrfPz?=
 =?us-ascii?Q?J3ZRXeuwc8nKGpKhd5iGGr0WOcFZUhCken0WgJR7Rd615JBAfmuT5KQN6pVA?=
 =?us-ascii?Q?e0zu0FUUcg8gEXUsxL63W8WbtSftwL2AO8duUq5+yHdudGkkblgA5XY2Qf9o?=
 =?us-ascii?Q?6bRLfSc8AGja0jjevOulx43wYvr1oj3nMzelmCwVIg1R/YuTzdiYWkaJaafT?=
 =?us-ascii?Q?1S9xNoh4swnR06yxO+6uUZbPdZWG7uI1JSsIYaw86Fkmz7E6XbkQ78jz+xOD?=
 =?us-ascii?Q?/fDfiHVtV4Qp7gyJAR9oGyQmqsUvtCufNcyTiiOaf0mgW2RQ//L287coOj//?=
 =?us-ascii?Q?IagjD9gWYOGgw5Cv99jFPI0rkwjYyMLz5sfKq9vQEu+2Id9EDcU2yiKwsAyx?=
 =?us-ascii?Q?zzDKPPL/bun1u/BPvF9AY8XWvWOupgm9vutYmOybCAF6HA/i6JWofU9+cKb0?=
 =?us-ascii?Q?iFFkB4KL3iFbZfveqGEaqdFri/UMCt+DNvf/XLeiIMQUvF38YbKmhWAoAX3t?=
 =?us-ascii?Q?54ldd5RVzCbbI05rXxqwbHBjsuO61AypznAmT9bbr5nLlihraQuzro4USr+k?=
 =?us-ascii?Q?zieF56gexIKrjizhzS+H14UUdhULpexSRC77fAC2FDwBlfaoqPktOxRRl7PO?=
 =?us-ascii?Q?Bj06PFhDnQiagcb8ZaD1auqLMBgVPdWUXKFzQA201+76w7uADCRVvDebwSUs?=
 =?us-ascii?Q?roOzck5mykW34062PITiSMOe6eB+XZ3A1csSsd587H1682VkCv4aYVfIYoMW?=
 =?us-ascii?Q?X8LWKWQjqlY2ntJHeH70aW+bNc2ZeUJM3rCfd6j3h6XjPl0/gfJV9KVv3j8b?=
 =?us-ascii?Q?wYVEEYLwpBfTnQz2J3sON4D96tiIbeylC/jQGul8pPdZLdpNtM+zg99X7NOt?=
 =?us-ascii?Q?I9h9pD/74+lsEP13ZSrCKDIPM08enawRI0g39NUhRfjjLK2LOp6SrY+Jq1DG?=
 =?us-ascii?Q?TXJqUA//1bfeillQMfyTVG7Wwkchqw96YNGIkaczFW36b/p9wBdfdayoaeXj?=
 =?us-ascii?Q?PlZjfv0dL1pqkv2Inrsf6u90Kr9OD21KKC9B5Mdb7i1JpO5ydMwTGHuk5tPQ?=
 =?us-ascii?Q?CwXTblQUtsFRCevuXsLo6sD+oECoj6eunLsHufi8MpVwQbepuSwcQULu8Qw2?=
 =?us-ascii?Q?Y3p3lkLtiIoIfe3Gtz/kL8IG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b81db55-4d6a-45e6-20e4-08d91168d740
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:00:23.8839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl1cePDskflKc9MvLKfZv+QKM8vZu21PeGEGZOrILkO9Neihxc/7lpC4KWtzqaHsQQnM/45JO7ydFSafI4zmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- adding missed FW promotion

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 213a6cb05d11..d26153ab9d62 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.135"
+#define DC_VER "3.2.135.1"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
