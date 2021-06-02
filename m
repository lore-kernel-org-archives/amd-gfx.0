Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF028C47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D3261C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D3261C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7306ED9E;
	Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085846ED99
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCtp44UWmlXkLJJNvyAK0kK3vmffW0nqaIbrmUqS88zTln6Vr8bLmHGg6zecpVx322Y4ik92t5q3rUtOUZBAlcp3Kp5CL3B/1JbeO0YZfgurBuSVI4OSfad635nJQ7FGpKVdmtXckUglHYER3Tw6wCUC54y6PiNc2rabeA0UkxrW3JYiY1YGuR9hovg810nsnU6GsBwbC/Ug6R/XkFEdtZcsFYXxOiGdG66dvhEAelsEFKNATwgd6pe2tdTikfWjia6ABC3IVxBHb8W0ZDFkk1hze4ZJVArD7/FdFdrvHXkbJfZKRcvlc90dnN87a61TRxoqGgSGGUIJ9iUxmy2kuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/jgUR7y7hg25a46daDAM6z/CLYzYOS1IddmLjRB6N0=;
 b=lquQNtRvr0yiQnxhIeO6+zExpY3NXsDXioK0+b9OKGuvoQVouQGJ7jc794/0ucUoF0NAkZGErteUne+FlYM1y091BOVYqSYWn+zCOPz7r7PgJ4Es4+CC1/w2U1DPTcyckXei+9nMwrI0PNzDnGy5jTYF0KtdUboWLd95mGZnPuyGXN1rwUA5lgwaKB8sxwwihJsvW9oMAKq+8OLAWjVHw2AqhVqy2OeNCnputR5t2s95nF4SHN5vGKC4BwLZxdEhU2QBClxO2qrpylIj6a8acXenKOBlMW7Rdh/UBFHtL3h75Q1Z2fLLJ1jaY/7k+li1LsSimTdpxTPmcnsBkDb2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/jgUR7y7hg25a46daDAM6z/CLYzYOS1IddmLjRB6N0=;
 b=WR+Rdhh+D3SXbcRuxK3CtEh97cQagsFdSy25rh94xgQavgGSqlYBiC8WFj5oPPMPjCSdbd2OJ+NFUQZCjLOGwFbzbIZB0Fa2E/z3Ipr6lZ5thHiWFGebKhvTkARNCeFb9ZUAt7uFZ618n2sTjuTuw3j82pOpBYvDFxZ1Kdv0/QE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/89] drm/amdgpu/pm: set_pp_feature is unsupport for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:07 -0400
Message-Id: <20210602164908.2848791-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ecd536-a31e-4524-2315-08d925e66ea0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063F389EE58C43BE5BAC936F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDNMs25obOWXZ2ewwTbrUbpub/7l1MRtOJtAn1hoSwip/mB7PFFpeybyGLpMcOliWp765Y0Kq8P+iC3PhDZhlfd4JVbekyZbFpzzRf2WVzvf0NNAlYXHnJyGnuybLnvdfyAP4m8qpZfHADjhBr+71TW08KVaLpWIv9sm0Pc33szz8afxH4y9wp+g1DBieox/T+iU86a/fMaumnLW1RTvw2f/1kB9MLylz/iywnrTb4d/CPLE9mhwvSXOX2r+s4xx7fePU9DnUHNnDnrrXbEXIDe6UlObe9qbPWZ8rEzUH2JW5DBo5ozJ4aOU108E3USGOnmOVYr7wyrlf2L8CklJ5BELe2TfGG+6vbvXrHJ2tkSut+7dr+WCwA/tt9GnPq1k0quirUhM/bBEna7BUUT5vtqhdTvJNt+9XoyuCGjY2IzRi7HJtqzJubqU1BU0fpcc3pCrjdHr2bWhzRN1ffS55lufnyhA+FEAf/TO/9EKzFEB/boE2HscsbeMAjrVxeF4v/fWQvasIs+M+8wRCAj0c3EtvuyI2GoivNS27l8BLtewcnUBWrKsqfRcDDt2ivuyExAo0Z8jHfLenfY4ZEpxXipoiZHjuB7z2jkPXgyEQwyzFtjsfQ6tmDmYbNjRuo2WQlXxA15nveOzDmmD3UFePxgmRNuUyKEMW6Mlc+xSZqd4+dICEakjq3D2fTXuIRuw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W4foUKLyqWYqTjvXEQ9zfkghKnAWUlN4G894sV4vOKXCHl4nCAnr4iw+FVZ/?=
 =?us-ascii?Q?eDR02QxMxumrrcbSabV7VnRc3/ZOI209s221PYUc2DNRjKshfifb+xwH3CPn?=
 =?us-ascii?Q?FdH5i7hgM+5kOsPPKoUU9THF8Yod0kcfUAIc0gMAWSMxbNec+XmRMXi8CsJH?=
 =?us-ascii?Q?zfEUAyiyWPc86neYerkA4kKEZx0aikW9dPPo1IfHozOUim2j+gokw8Lji/i2?=
 =?us-ascii?Q?MMXcaD3rZXGavfyr1eX/qr970LRiDRwq8PZ4KeU1EHeJArKYPDmeU5ykdOHr?=
 =?us-ascii?Q?YdHG3JSX2gua+780KVoJcVBSWZTBt+GlSDnX97y8kOax3zwRpgro86j1+u1k?=
 =?us-ascii?Q?9tjruSon3LDVKa5PnragBNQUwfxz2HKn2N+KKGjc0DtZMcDKwH1FSlDoz/H7?=
 =?us-ascii?Q?f/lXrF8OTirrlzwnJPbYGCIzPpnVDuV4YajbCrAY9e/ge6Gezsy0gGmpLj/u?=
 =?us-ascii?Q?PBy7fE44239h6UF7US7/LvPysKmr6d2Ys0STWcYAHxP0gQDKXpdFRj03af6D?=
 =?us-ascii?Q?GWpQFA+EpLuCLdVL/nvghAGzrztl20fLsCfxbNDs7DrSTtPgjud83bO9zz72?=
 =?us-ascii?Q?tz2jwUIbh+xrF4cWdxD9tNj5u9ZsRZTlGhJQmWDQYTkPxe3pQp1Aa7Mx/AMa?=
 =?us-ascii?Q?zk0Uq933FfBWXAScWkKiNrEpaB7ywKKLVY8AEcXiKcIIp1m7YLZUe2zpSwcA?=
 =?us-ascii?Q?zqFxsm5Q+dIF5JP4vk01lJfEiMrUK3cIXcQBxb1iKaeguAHRlgTrfUbLma21?=
 =?us-ascii?Q?Wzu6FX+mifLEVEbW0wF087QtqYXo0vszgrHLjm0bTSA67YF5xotCKS7cckld?=
 =?us-ascii?Q?VxWEt27aqPcJfBMHZNunteQW6Qe6qZxgJ6Xv6c0gJhzJzdCOcB3KRsBxTLQv?=
 =?us-ascii?Q?1+LsU6WQb1Xq8QqZ+gpMhs70c8dwY2kcG+aZOrcOLuQrpzGvU5UZxsR6v/Vj?=
 =?us-ascii?Q?rDjf7NTeFcO+smwyQFMcjYi8UInUs/KkAaQhSo4FPtW8bdVKQpG0zX/gaORU?=
 =?us-ascii?Q?SD62MEYRHiwEglOrt7GEhzxQvb1cVYVCBYHqsNN+A17opeDLctH4EkARXdSF?=
 =?us-ascii?Q?p3+eP7oAJUbGAqGJsDV4yTqksuZ0vmOxS4dmGbBwfByY1D224yAh/3434MCj?=
 =?us-ascii?Q?a+lG6We7+i3bXNSFzNIbIm/aJnEwR6ST9ZwPlM06u8cz/PTWEwVEz09s+iza?=
 =?us-ascii?Q?XoGwjAxVTJcMAUeWXzj3kDslAvjne4lPU6e4RaYyQ22r8L9Or1qDwaT2l+WY?=
 =?us-ascii?Q?Fm2Bm3/myti6JYXWxg2P3DLWtBE6rfnuPKIkFE5IPwDpTxlDUC/psA9fv/gF?=
 =?us-ascii?Q?85GBAdDwpTDX6fbFnz4JO46Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ecd536-a31e-4524-2315-08d925e66ea0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:48.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPn6Vs3iGQlo5VfdCzla7sMGto8MivSGBlgp4OSoejNVA/5oYWm73Ui9nU5F8NP4xRSoooHKDgCTv9FEMzV5CA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

For yellow carp, SMU firmware just only supports get_pp_feature.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index fd6b3f043efb..d849fa83f01f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -149,9 +149,8 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
 	.is_dpm_running = yellow_carp_is_dpm_running,
+	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
-	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 };
 
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
