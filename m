Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB6C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D261419
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D261419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6882B6EC80;
	Wed, 12 May 2021 17:32:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A720E6EC7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfaiVDxOXCaFsF4xIXAlUrvaKh1+nBQj1GF7ajbDuasPPUgrvXXQagaO0YAcp5Cw15A50fkhpP7SSOKrH1RJcVg9AcJ8sXvhz8XUmTTMb4IbbIPIXTMQMkMWYd7EKuG2MBeeJd59DplRtd7YOmaEqPAWuWm+oFZma5UuKOOYb7N1QnHIDP+kqhXzw54QALeN61hI8ZjJai6eq3QSMk/csALvU1KYas2k4yVgeILHB4GMzmOBw8JV69rbYDgkIApbxfq0w+KPWgDraQQDCNlvSH7vuXJua9CUEQtvdQGBFgrFWVlHVe3HZk3ePb/4n01lG8zJr1Qr1u1YSwixMINvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8z0MX7sml2NEnr7NRWneQ0BdJGo6geXhb0RRUtb+zw=;
 b=FwyErUyeReCkCFKlUC7upBaZB4pKOo/22jVw00iiX36WNHV7ZIzzRsQv4Ksee0ZwYtFqZPWoF+nX+EK3rEcbMLqQpQ8xIPl2jA0NO350K2iL5NbeG08KxfhW/SXyoLF2/sadRCEHGJ7E0bY5ooS/vC9UVK0V1Gq1NQMOqBXLZBn4fCQvww2ia3WQhSQMhdklxk3uhK5lszxWeIGiLZEdSIxarCKREjtvy3PByJvsIo+tqwLpfRn5mTUFd1D4GqECu6sT8ZGdqjssqI3/Xq0TwRPogCjqzt8uoQU8n3k6ehznPUet798IVbXwphCXYV3XQ2qslOfXaZop0b+pvEIMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8z0MX7sml2NEnr7NRWneQ0BdJGo6geXhb0RRUtb+zw=;
 b=pCQQu3j+dTwBZNy3Oqu273HAK/e+cQtTKOBsCHAbHMq322HVhblrNMoTGvyeL79APbanryFv9wlLzx32lalXWtkrF3R+VpfWtjmKr4jME2Tt0URs4Hs9V5jQ3ZJqp/nFZGkDLMrIniWCih0QCQTpOyX/u+ej0/1B6KegQ18MZEU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:06 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/49] drm/amdgpu: enable hdp CG and LS for beige_goby
Date: Wed, 12 May 2021 13:30:38 -0400
Message-Id: <20210512173053.2347842-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 219c75fc-7f20-4d01-de51-08d9156bca5f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25643DB35F05C5FA84C83540F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kff3ARIJj4LO5+IepWiWmemD1Hv2rv92epAvlxfF2dXVJsT6bagmZE7nuyNg3yK8k7s4/6UzGVegDyGUIih/0Lu1OzUk1p3pKMoaAg9LKwg01TbwcADqJ8I699gQMwVVEr5BsyugRW8Y2sRFuH9UBu4KVezOgZp2gdYpykuCYUislRGJ5lvo0FfGV4mMdqZmNKbd5AIwlrQuSNdW67BQqxvLGrKjyi7BG9O0COAIOHLwC5a7Uh5GeGI60rGh8LZwRo+R/8UbBxLJxEcE1ewDx9ykjZIM44IYtS3qBxH2HcE4VS/RkvBPEVa2+CQa59p8+UrQDvvtWK8+/7n2DEJbTP5aootJmHWWQgcCXKBeB5ATRF1nlLwTJPb1Qlm79VvsxdRey30oUNw4gA87NubxXsm5W4Ou7Nz/HbiNkWRGZqgnayByfEDheBRliQkajSae+OF+etkI7J/Gy1TGd+pFOpPeyRpC9l5ZG0eXIJFp+Xsh49J7HX9PDJNP9nwkFzBeA9ynEPMxx1mf1KVb1/0eH1H2/u2wUsTrRAW/tW5Z7oNNEqAwsbher1SQV2KDeTCotlWe1YtpCF62co+zCnj5aLuxuVDjaMXTrXBiWkA48lL70A/7+fcdb4JXFHVDJZyE0sLMriPbwnyaGVPzdHIXD1La3TCzkPwAd0dBlN/wM2ySwjQWvwU+zBBMiD8LYfpg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m/H6WhY3QvbCrW+yujlD3b8XCvGuZDOYxHsqcIzoY06cvJPIX5dN3KsPVf2B?=
 =?us-ascii?Q?IZ/7IfeyavRcTOguacz4fOvFzqEdY03oHFTpMDnDp27drNHdM4dgtcXSKGgO?=
 =?us-ascii?Q?Efp8Io00SjdJ9+EML9gy/tJL3kYDMlnOoB2rhkWMoHKd8JolX14jipp/yohn?=
 =?us-ascii?Q?HHlnX4TO8WB3z3erbpDNNG3LUCovmebF1WTS7bCaIBi+1ZVWKzMlL7tfAqhO?=
 =?us-ascii?Q?ESkn6LZ+92vj4IG7fRylCmjylo09+1WD33AINDkG4EXA3D3ZB4YQlbymakjR?=
 =?us-ascii?Q?fAmNN1k3FgY8Z9gZy83s1Q2/RVa0gJABz0kbBASVWuKmVk9RcLaGwyppEqQC?=
 =?us-ascii?Q?dipztPyB1IIWwtKNp+zsG1GH2GjSy2CcN7cBScfMs1IABgGBDMh1rUZO46Q4?=
 =?us-ascii?Q?o28I1neLLxuvnyaz6RYI6+vlEmTxGYNKnjHhIWs/bNjFbqdlQ1ijDVL8Orke?=
 =?us-ascii?Q?uMqyF2di6YQITILeAwzAJ1FeF5HgzRnyUDtFyVHUgj6PPRmqwc6fCoHMKJ5i?=
 =?us-ascii?Q?89zHTcYindDGvtRjK7/eesNybzwK3SiWlwmyl2jSiT8222VWwEop9adb1xt4?=
 =?us-ascii?Q?BDrhuLQ4socsB5qs67/dg4IGploReez4MS+SFK9n7n6g5TxCGioy8j+6eqKB?=
 =?us-ascii?Q?edWIAc5YCAgW/gUIXE+Vxc7f1MEfaMI3TH0ar+5+0FIwYDZUPXFP5egbc1eH?=
 =?us-ascii?Q?PaMVu4SnEDCAP+RWcH2TXHUOqH1V/vfJVbIoYYMC82/rmV2s95TWps1MsRmx?=
 =?us-ascii?Q?rH9o33YtU4dD4tISu6Kqx2jNnAgCIhV99CDbUhZqv0bb/Yzjr669i2LoawhA?=
 =?us-ascii?Q?TadKTB4r2phSl7jFNontfyV8iB8KoL5btDm+1jlEnegMDdD9z4b+O6bbjKFm?=
 =?us-ascii?Q?qJr5zC8+o/F2rHi+MMZUzCZgj3axl0tr1i4uh4rfgEAuouELKwKVMIRNpKyU?=
 =?us-ascii?Q?qfQ0obhIxKTqcG6A8WhQBrPw+IHyN7zJJVTL/h6iWHEglLJE4vshPSyvS4YL?=
 =?us-ascii?Q?qC7mfozQahBwirQP9zeDYKIKV6S6NcLzkwcDShnzUHSN0YFnyOC15HmpVlcB?=
 =?us-ascii?Q?h6IDTF0c0MZpVUBbc74antDlH3VjqCtkCR//MpBVtjKfTYT+f8TCPyVzsFc4?=
 =?us-ascii?Q?jZqCqInDWsAA/c0uvjnxIuJF45LcF/Z2uXyzZJH7ePh7jrpody7Z9EY7tVB6?=
 =?us-ascii?Q?sIrmUg2aOahCX/Hp2LrjhddAFcqVhVoQ0E/0V+RfLWHYj6ZyBOvttvqJv9Qq?=
 =?us-ascii?Q?HO51HxWXaPTn4P/ESLKKQYKlgwESEixtGhpw7jfYKscFThQjtETBEwXL7hRH?=
 =?us-ascii?Q?xv0sHnkuL4ouPpsmVjsNdAtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219c75fc-7f20-4d01-de51-08d9156bca5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:35.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvh3sKGf+AiH5Acsa+xq0IwRNz3Ijpulw87f710qN6D3IkYsPAjKfT33ZO4O4876XuxoF6hsTReY4MN0WHEVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable hdp MGCG and LS for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index bb516eea8101..6253845d5017 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1176,7 +1176,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_ATHUB |
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
