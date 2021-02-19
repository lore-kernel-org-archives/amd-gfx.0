Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40117C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8AC64E28
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8AC64E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFB66E8A3;
	Fri, 19 Feb 2021 01:19:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEAD6E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 01:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3EYazHi0vz8DaG325LuhAFvhYZNd4vIzJXFEIrqgldQA2VozoECVQ8V+LHaisPl2ziCduFWdNQnP2yogHgsWKZEn+kqn67gIBuLyG9D7HYyLLmAJMi0IBly7d14uA9PJzb9IXslpxFlEWdtBJqZgC/UcArPKhXoJG+Uh8iPOhZx9qcF8hmq5f1gJ+ZtdLFjog79I21ti22HzWPSjvSo3RAhs0dn08WG2MxD56/tPQ39Uu4oo0kVnOWX7cQczNhtOlnuVdXJ44n4BXMVYdgoG/+rpSF8vNia9bhV465VCFtY4rAQKbyAVFdSwc0Z8a/Sk5NIJJKOko8Io/pdnDHzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LzC08OWzgM6WnoTorvTlH2gqSfNJfZJ4I7wEoZsZU=;
 b=CTxTWtG9/3ONUmqXJeqoYDsU+TMKj/RJYbmCbhRJI87nfIIbWhnMa22oopBoUABzwHCvpStQVFVRxezn/in1Ww75VJmmpJHfsUauiV9BevDoYfWe9qY4HM9+BAHvtp7ZE+FHbT0qcinTSowFC6MLYtiW30Bah1ZzoQutXK95mkjaVrpwh9WADrUNyTBFX1YkirKXtJu8N1y93zeShFqCaZGtBTeDZC6qV66TaqDbmrUrKZR8ZdtXEx6YhKWuOv+/CtgObNJK0/fbBj3+yFdktlILeQW+kR53oZYeSarBVGkWjhLQPKKlBIP0MMaphL0PCabYLA4qZ47kByDFWw4zkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LzC08OWzgM6WnoTorvTlH2gqSfNJfZJ4I7wEoZsZU=;
 b=mdBCarmufAXnQzw0jgO7qFJW+bxbBmTzcQjl9qZuHX6EaT/sWLtRIxqyMgQ7R8oT88Y/Hek+CcfLIU+sBDv0uIjNF7aQxYL6aMG4YD1g8Xkjx/TP0VOnvN7wEVDhrbzuyYpRItPbFlWbHzvwucHX/6mbKIT6D1wW6QwUs+Cu500=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 19 Feb
 2021 01:19:26 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 01:19:26 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
Date: Thu, 18 Feb 2021 20:19:13 -0500
Message-Id: <20210219011913.28464-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.35 via Frontend Transport; Fri, 19 Feb 2021 01:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bbb4420-ece7-4fa0-ad67-08d8d47465cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860E929484082D86838B1A3F4849@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0n6qdCll5clD75nvDhvuNX1zkmFbTeeH4AVsuhtM7vRSkCol+IYvcYOmUU4BDCKEEuis1jJ/5tsIvH2239qZm+/pm1i9qb1WxT0a08tL3CYYzdJccoDdNXA+N/z6KOLLNN4PYL5n+RUlmszSWmO/ctjXs60tAankKS0JfzkRZdLsItp1aKw8majOmt9FIgVKwHJOt6kw52kYYlYZBcK3ea/jVotDzaZdiv3nL9UlfrLBGQS3oXA9Ozly/HC3UNTyWFE5tUR0I/9YraBuzeihlEqcw1U9+4oHgTpinAR2VWbXQ7QFpY1Ektfs6xj8xmtVU+ZczN0LoI4+sATivERam/faUw3vGCCb0we3SwPELu4GRZNnYwjl7ht/FJo80mURW6ZU5yS6yj5cHGpQU5/29M8tjKm7hv4BKfQzk+aalleqLEcmfkQIMKCRSh8+xDyTNsP45njcJ9jCNcFaAf9Q6+sOe26ubpNFZtX3ZZ4ziAOzNeHBKysPBEngcnsNtnLhCsm0axLqrGEachrJEL5d4bw/OUp4XAJ6nhytcW0ksWmih5csS2ApkKpzxUfKNuR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(16526019)(478600001)(5660300002)(7696005)(66556008)(8676002)(6916009)(8936002)(6666004)(86362001)(4326008)(1076003)(186003)(52116002)(66946007)(66476007)(26005)(316002)(36756003)(2616005)(2906002)(83380400001)(6486002)(956004)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Bl8GFqZGEkwGhzJe9Q/6i8cH1UsRN4ysHxQffzbqUNtFzT+vtAlblFCiDSS?=
 =?us-ascii?Q?yXMctTedFM6yymfzAhcvtLoSc53iK+7OcFMAyLh5TdLquA/rRduJ++T0P081?=
 =?us-ascii?Q?l3d69yG6HTd8BiUM7J1pKDe73o5niRhND0ahf98kJLGlbSNCcV11ILQ+as1l?=
 =?us-ascii?Q?3bmKJvzGzHT6kstRv2Z+Cin/neHn2gy2c3aYwD6FnmG6gqN+jC8s3ArKbiAe?=
 =?us-ascii?Q?rI5MjEEbdTIhG6KBbp7OyToC54whaMWy+7IBD+C4QjhbhzBmLm8ldGWxh2Bq?=
 =?us-ascii?Q?gilytCB9NQfqsdudnc05xItGwY/FNuPokNaBxnuwKjzJyUIohFEJqAtQ/Szk?=
 =?us-ascii?Q?Kj4WsWcjt65Pi77lYuJBCiITI4VgCxnDt+R9aeu/tIbQsHTk+V8Zf21ywzZn?=
 =?us-ascii?Q?gYAxZnsnH9OFDtBrBm1rrDVeV4fNFoaQh6crbW0fUK1GGu/B4HHkd88jbWmm?=
 =?us-ascii?Q?ay77VpwKKHdBfC0BjYM8Ii7BLG9qBzWVHqDDXafd1gef5NhoxNK1QoJ+U8cA?=
 =?us-ascii?Q?/DAHt6KyVeaLVrUiEiInLULKIZ54AR4jeQXM1FCmvS24UiYBi50KNQt0nkXW?=
 =?us-ascii?Q?5MnzzIHRYiDpWlVqcwn9QDnldwHjSlm+euzpM+cjawotoAklkZAcSYJRdAgq?=
 =?us-ascii?Q?yEj1lC5xTwDtuzQT+mm8Q+Iul+1rUD2c7YNHiNpSncsHDeWBHterPoBMfv0K?=
 =?us-ascii?Q?IHqFyceROKEx5xmlqF9wmDSs6GMOJPSVhBIp7Qok9l/tDnJri7MWEZNW1/wl?=
 =?us-ascii?Q?80/wnNdLzQ4nHOPIj8k4Ht3Bw6g5cr+oR0T2t+uzuu7lSAHFizv1kyBlChfP?=
 =?us-ascii?Q?9OevQK+C5LB1lFeCEDP49yJGQPfsmB76W7rEBN7Z8NUff7JoPaujp8zm1niZ?=
 =?us-ascii?Q?euafcmDvHw+6eUM1TkaokhuagfRdk/rn9BevXX3H0rqvN2kz+HB1Z3U/ByVS?=
 =?us-ascii?Q?QR5ifsXjVsd2M1gv7TGsXNDnyXpxIrKx3zzzJPv17BIKBE4TqaowowccewTB?=
 =?us-ascii?Q?VITCQeY2ieqIlru2CU4ajd6pOgfqwff55y4m85J3PNk6dStw9kwCaTSBXLNc?=
 =?us-ascii?Q?uxX5XyoVOPkXkNxVuy5hIcJTGjDI9qBQrVgDUrJ2mHrnFs9yHB+JVxJLXzK0?=
 =?us-ascii?Q?wRhvhDRedJC7ZCnr2WshXBMi4/1uAFKarfZ4tgpRdsPZPPwKzCIOO3ZDnS3C?=
 =?us-ascii?Q?nYTkmyQ+KskSGAGB8mLSD5DSUu7o/JGxi3/2TNS7Q5r4yXi9vNa+rn9/Ub/x?=
 =?us-ascii?Q?SemGJRGi3QquqsWWOk+WRErpeq2agP6GjIRVYCUaf8JDh2earbDwJ8v4KjL1?=
 =?us-ascii?Q?DbplIArXou8oQI5B0zrvkDC2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbb4420-ece7-4fa0-ad67-08d8d47465cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 01:19:26.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LypQwf6brG1P0m+0up6IOJp1ASaPnAaRsYlA6wkro+b2ZUKL7QhK4F9tX4J+gQIItvBcCC0CDrSW8L9bboikkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver need to get XGMI info function earlier before ip_init since driver need to check
the XGMI setting to determine how to perform reset during init

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3686e777c76c..3e6bfab5b855 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
+	/* Need to get xgmi info earlier to decide the reset behavior*/
+	if (adev->gmc.xgmi.supported)
+		adev->gfxhub.funcs->get_xgmi_info(adev);
+
 	return 0;
 }
 
@@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 	adev->need_swiotlb = drm_need_swiotlb(44);
 
-	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
