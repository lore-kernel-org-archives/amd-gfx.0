Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A1C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 01:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD834619B2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 01:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD834619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9236EAD2;
	Wed, 24 Mar 2021 01:24:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824456EAD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 01:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+rsHX6t7FuCbW3u0/Kt5u/BEid+eD/uCRqtOkQuzufNq2Ll5EBo8J3nZ1wH7lASkLXnpvz4dAVuI7Vk6ebocNZ3+Yq67NAs6jl1juUJteRLUpU6QldRGCrVVazdIxb4xXAlVz1SKKLeSday7DAK1qmYQx4TAmUheCyJ3Y0qsGxgze5aeY1/WEAILDZ8ZZWCrLPAG1VXi2l4gtX0kiTkcTuwjAJJYFHsrd0ylJlHR0PwzAFh2inTtO7Wrn2pblMDnZwwWyIFHJzggq9M56NEGwzQjmn4sd9P3/e0i7v/WTAQThLt45T2shfQr+tXzpQeHZ0YW+SZh9bCNBRqH4QS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHCDihxIYy0Kx7MRuV7qjpCRiWtwjX1ptv2zaiSlWKE=;
 b=A+vkwIGqdrIbjCTcNKo4+ydxMrrKcSFCdvzjsmZLiFYsEFTnTOCxxKW+fWA/lIz+6MJMmjlUy8zZfaLwhXwKF24YnuHW2dPNUi99qtjtCOX4Rq5cad4oOYN/kc6HHIDm/prhffMoy4BzmFxwXHYTqtJPFKrfH6OZxv9sAeyfeQXYBbHAwgdBL2bVZCNKqHL/U92CGdhoTc7xUuu8YXiDpl5Lu8m4hZi6DrBlGPzdc0FWK6A/3uLs8xwyun+vBAkI834636UFFi+ZcDntFGrRQd6ZEfrNTLSvKKt6sgvNvL8wTfcTgNFBLpMj1w/b+RD0+KjGGByGgUkHlz2FtFGZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHCDihxIYy0Kx7MRuV7qjpCRiWtwjX1ptv2zaiSlWKE=;
 b=yUMwrjRNi+ukzMoJpMn9+MHBEEUWW96+5NasmoooOD7v6DzeM1fyUgLldB12DeSUHa1nLIUodjqI03x1EymmkO7GKG0faRLw7BfWhRH/AK6y32t0pki3CyKyeErdxx9oG+X4v1JvJlfw+TQBvGuXULHnoocgsXDxJRyhwRNtEHI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 01:24:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 01:24:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: To modify the condition in
 indicating branch device"
Date: Tue, 23 Mar 2021 21:24:18 -0400
Message-Id: <20210324012418.1850055-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32)
 To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 01:24:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58d6713e-3066-4ff5-a2fd-08d8ee639817
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063D6AFF674DF628C4C61F8F7639@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9ysFP1IsFF221AbhE/T4QJyHRCQhiPXHCVHVXdsMPqzxboRebKOBKGEJOEvLt2PLgPzT3GMCLciLfm/uK92WL+E2VCWloyocC9DiTI0FvMuqaVJk+XA6tUeJhMKXUGY5ejlx4QsXZae08DhRV7eXYXA501fm1vPERQIYaIb9JmnBgH+Mm4aWcSaxyefjh4TvFBvUpU9YMIjMKoPRafSzBve8IxKJ64cbHK0XKZVrVDoEa+LimsHEKzCqXCqtAFEXoVZ5ghvssBSJfQP9rlZa0Q1hpTC83T/lttsMjiy6ouh/x+RHo4DZWzW33YoOVIk2SgR7l9ATuww+RDmS9CXN4jF/VJ//InclcWhQzJVjq/HcF8kRS8v9Tq0Jirr0cTf5SNxrUw3BPHC/6aTh+I64NnrWplCqr1koLoy6M0TzG+ualeVA6hiUHVc76iAGEXwmHiuCdADwOkv7alKhsIA+QoCsv4sFWwP0oO58yxwprOcOtTTiJjDwnliQ9GEa2oE4iPuUMmY8WHv6qJyhBBw8r9AVBZ8WAEVIh55OZh8PN7dxekj+j60+FGRKy8p9ZhCtYHEG94AwZcdre9DRtgSNagASUG9bAJJk81IKNvBfcmbPItgrwoKFXAg9fEQniIom4SA1XIKyNa9Cxm1GJM/yFS5k8ESJ5zDeXAoskVH6TKoEw5qHilSOv6suvSwUR+c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(5660300002)(478600001)(8936002)(86362001)(6666004)(6486002)(1076003)(83380400001)(966005)(4326008)(66476007)(8676002)(7696005)(6916009)(2616005)(54906003)(52116002)(2906002)(956004)(36756003)(186003)(38100700001)(26005)(66556008)(16526019)(316002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k6CoS52PW7VwTvbkCyk6xgmILVr1d6A53B8lHAxCN8sPp1+NYDt8A5aZQPJU?=
 =?us-ascii?Q?rl5epVK2dn40VRP2NMDdpvBe3fVePUcfGwmY/NNbb3m3OprJmpn1JEYdRz2u?=
 =?us-ascii?Q?ej5RWGGgSuFhaZvqUbgIwoku+XkBQTpeg4dYodzghDiHxqjFnl5iMVFvexAk?=
 =?us-ascii?Q?9eis76UMm+EE0gH6kW9ZWNm0/GOcbUaLIxzabRgHFBorBb6SomEN3BBuhSJf?=
 =?us-ascii?Q?gh3/vWh7Bb3p1zfHi5ayFhsPP3EidfhFqeRyamkgymYTTInKkR2m2iJ3JmC9?=
 =?us-ascii?Q?MtcnO1ts5pCxnqBWav6w9zhExsQZHofSxCtRwKPS6iX291FviDXG0NYBSany?=
 =?us-ascii?Q?lWT03me0nVqTldkyYQrTW7oePVKRQgxRJqQ2Db+oCYzXx5pYdZ5p2lAyrZUo?=
 =?us-ascii?Q?1x8qRAXfgj0Li/aeLwbUXsKMrou8J49PayWYVzfl5f+RFBLYHqCYpRW+QUaU?=
 =?us-ascii?Q?aOAMucRMa9qyiDrimYeFdc+kC/a2tu6rfINL2/M31UQB9VrBRdsVkr+S7zOz?=
 =?us-ascii?Q?BbbzZoKUxqj/YQcWAemPo2mSJaw8T/K9HZ4ZEcoZTrvEcES1zfoDV47RCOYT?=
 =?us-ascii?Q?g0bv2UciVIdcNc7Y9CM+rvDg7J4R8RA48qU5q+4woCHYZEnJX26lw1Y6FmNK?=
 =?us-ascii?Q?TajFNQNMuHnKJxj+eLs37NOTE/GlE7u8Ba72amiHBrypyOmG0Ao78Q9/t8CP?=
 =?us-ascii?Q?jNRu0H9WtNQW0Nu3NtoqkCFk3SltwZtxlRw7cP2vcvp3zbKsm9pTKk847J71?=
 =?us-ascii?Q?eXt42ns4e5VGDUoqRMXqyMcrAbyLeNAGDXSPYl9+2FcvjBhFdVUDHTEBoJ/O?=
 =?us-ascii?Q?jtoGACfa6t09apbAIO0PWndMGXCCGPd2k6COkZhIuWwlTERb3+k1rBYe/9sJ?=
 =?us-ascii?Q?xBr/StN4To7WeyQ/yceNt+YO4vW/seRSbj+Y94wRjPXUD2OCxC7fbbeGHCqg?=
 =?us-ascii?Q?bSbzHblQv+Z5qBjU4Va1vgZyq7tL0PAJpZxD6xuA5lRhncteHuPhXLshO1hl?=
 =?us-ascii?Q?AhePhV+1x1boi4qkP7jOGHIUYmEt7h0Jb3SdQEgjFbWNNDWHQRkpZIK684Bs?=
 =?us-ascii?Q?Th0A0GkdOhdhvYQrgaENRWJAcQFFPkEUsRMi+7mYM0Upfy1lshBMeS3HYjHu?=
 =?us-ascii?Q?7r5NW8lh6btEAbpJYTeL58NnmD5Ytnhk40kmB92dGigZWP26uQZiaQx4lFGA?=
 =?us-ascii?Q?pzfl/5p25eHa3++QFOvTi49gULmEkdTrtPcphxTtR1lNOhFtEn3+SqDZkFyd?=
 =?us-ascii?Q?InzXygDdm26tXJeQZmP8sM172XC0HRXsg2ESQf6qz5GMyWvwTzPEW2Kv6724?=
 =?us-ascii?Q?YLeiP9iJBP0EHnal04nf9SIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d6713e-3066-4ff5-a2fd-08d8ee639817
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 01:24:39.6432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /af0yLpgmIb3BykN3wgsGgHDn9YYE/1AVN6k+XaRn/o2X7WYod9hFAPnTedYIRTlJiomjDPVjMlyolIl2tvTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Martin Tsai <martin.tsai@amd.com>,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This breaks HDMI audio.

This reverts commit 9413b23fadad3861f5afd626ac44ef83ad8068ab.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1536
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Martin Tsai <martin.tsai@amd.com>
Cc: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 484d96f78ade..18adf4ea6044 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3192,7 +3192,13 @@ static void get_active_converter_info(
 	}
 
 	/* DPCD 0x5 bit 0 = 1, it indicate it's branch device */
-	link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
+	if (ds_port.fields.PORT_TYPE == DOWNSTREAM_DP) {
+		link->dpcd_caps.is_branch_dev = false;
+	}
+
+	else {
+		link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
+	}
 
 	switch (ds_port.fields.PORT_TYPE) {
 	case DOWNSTREAM_VGA:
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
