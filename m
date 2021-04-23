Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECEC43460
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8771D6113D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8771D6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329696EB21;
	Fri, 23 Apr 2021 02:04:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF05C6EB20
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9YlyjtAZzS68yVTkQo1hv/W8vvJY4DhDD2vf+Uxv2FMfxwS9lxaYWHrZBhfMeHfMdSlDk2sX26qYAAIPKBgWKSCKZ+ez2GDQ/w9riUZu4niDfbi8t1sUwA20XblHmT9GffrCDmlLnRBJhObIiHUoPu8TnBslXhOTDnsqayyUABuvpAGrojniXIcJp07OOKt68ZXevGuuvSrlag8A4R7D4beUjNdsjh0i2E8Iu8qMAOZd2lv0RCpJt3y3CHBAhpLe78TYP/PGIWMp/fmNnn5ZBwOoReJNMLi7n194II4JuSkwm2WDLd6vDbuzCc3d/nbJHRMxfEwfo3/plwNq/LiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru3a0zOvAmGvgXbmR5BKiBSbUjho7UIfPdoyzLZ6kbM=;
 b=hJCLJBQedHfWFthkFnKvlZfspJKC+I0tKb9suh6/jj7jpRkP3s+a5WDxS9WICvvOh5Cut1Pk9ij+S/hAltoLlQ5xKXBuvolHSD+BbI/Ugi7+X+6oDxN0mt31vOPfbedUhND6Mm3bLRqXQWxsIIMnmMelVScDQwVSKEt+aZvRo59Ty6U/BHgT8o2zSpttCH22DqGAAen6yqT1ps5O/yJIDaltsBxMXcLSn/MAgWBUCPhHC1RzyzwPJYnS3JIEDgkmQIf9ooin/AN+twXiB+F/8SrC1N6Fg6N6S9YxLaYyjveBSUjBYcUt/GmxPDZ+wjnPrUH17eOis5VZFmfqCCAnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru3a0zOvAmGvgXbmR5BKiBSbUjho7UIfPdoyzLZ6kbM=;
 b=lko/SqgYHIZ24okvyyStkC55Kc7O6cXh0qSfz4T2B1QIKieU/BzGcwREwoV++coeDG0mxuJNh3Jxx3GnknS3fz+MV4mAQvCMjqN8iWAVd+WqzylRKGq6L+MGBUYe/CZtNbGDkpzVon8XC2GnxB+JfbaBa6di1KKBwI/FDwcnKEQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Fri, 23 Apr 2021 02:04:12 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Fri, 23 Apr 2021
 02:04:12 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: enable subsequent retry fault
Date: Thu, 22 Apr 2021 22:03:57 -0400
Message-Id: <20210423020357.31102-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423020357.31102-1-Philip.Yang@amd.com>
References: <20210423020357.31102-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2345dc-e78c-4b48-6011-08d905fc16cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4010E218717B944F13C6E278E6459@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l61ysjBlE04o9Nzal3YznwbTBwJ58qbmn93fnbdtBTI1RJS4BJrovLIfk32+W0v/dXeo3HEdnBC8X71e+jnOFev0gNZ4GOJkHYATBpE+KfIMaKNu27w9J8WXGWAnoQfX6Kf1QKuAqrH322RupVDOee6eBthKTIChlgND+iyp6PMt5qiiv83t/CAmLtIb8HME5wdiStOKZ/0REZdh9qVeBq5mwx+fkOuoOv8fCpLXcN5zBti1Q9px+lunLIBb+udbNsEJSiujOK/HpqMQnm1BxMZDAdFguvz39fOGl/S4pq3w2VdHgUy1Mox1Q5/qjC5vO8MOTU3ZoyHU7mJRx18hDyp/0Df2IvVBfUUG1LEEIH5fEWHRyTWv5AGaWZBzAQ6cQbp8UuM4AXgPJkySXzwfGbAZ63Sly6hRfgjmr7OpMbbESkLOxOsIzua6/lXcIGXLrOwaYikgfOvqk3JRImrJub9yltcttKM+p+FVp/TzogGex6TJIEr9j2HDxWplNqXdxBLCO59J6027Pl//E+lGkvfhd0zNs3EbxoCXpi9MgunxgYmxd+gMsRt951xspjp2Y1Nl3xvT3kW009j9zSzkxRdEBj2jpxo+kSlLwYzW1IC+36dsS8SVT0OoQ17be+kY5uhi3KrzA0p2S4ZEFtY0Wyd6oTFl+QJgsRlS8Ec2NUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(1076003)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(6666004)(26005)(186003)(16526019)(2616005)(956004)(83380400001)(6916009)(2906002)(8936002)(8676002)(4326008)(478600001)(86362001)(52116002)(7696005)(6486002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0qayqJCAIcFVV73vYCvBi1IH/mLVUUFju5JOCumL18bPFt/0LPgBOwcXpkKA?=
 =?us-ascii?Q?Xqs3MCV/k5JrD0NV7KxeMYs9VnrhUbdTIue2Ob/ZciO+7ABhS3vO2N5Y17KC?=
 =?us-ascii?Q?Yg1BczeYcHzLvkEa0UKNfMGHvvD5R83Z32+aLosYlPLsdystawaldX+r2e4B?=
 =?us-ascii?Q?wbgoe54EnEgSWc9JhXbS8LqBgf8I9vXLrYMrBmVW+wBrfA141PDBVo7PvJ86?=
 =?us-ascii?Q?hWw8S2plkt7ZIXCsj0UNrJmocVTRIgN8Y1W8LKtmKufpOJ8mOeBiAI8qN/EI?=
 =?us-ascii?Q?ljJq5U0lYtTbIZg9/EqDmMtlTePzc7khwwMaYUG84kJEuhJDxJekeg/g3GpP?=
 =?us-ascii?Q?v+bUSs9nzgilGAZG60r9wWxGu7J2KNyfDKU4KPh5A7bKywYPw11+3qjy4S69?=
 =?us-ascii?Q?FQnzu91q6YABFM8i4VxH1BrombmVmXUgqhSyQyZktj0vZP0YHQavp6mWFwC/?=
 =?us-ascii?Q?dJDilSwuOuASIhT6FL1pJZlhZ79PgOSSuyAYYm94cjTVLqPMgnDvmWrHad3J?=
 =?us-ascii?Q?vTB+yOj48/z0xSfFhLRzLAm/GrCtJwEbA4rmPrUSZsYzJXEPMcErOp5ty8LT?=
 =?us-ascii?Q?6+vWDhrT0y4FeXnXWXk7jBabxTMcgDD6xPbL1Bdns9Evk4fuQRWcvSRz96D5?=
 =?us-ascii?Q?5P79cUIYxkWqhLsWEXy0JSgTvX18Xq9LXR+c14WWO7iiLfeg8CsO0nh77PYz?=
 =?us-ascii?Q?4c4LuXMr1XNP0do5OxJydyHTu3zHB6KVgUM6w18bIB+i+u0XL2rg0czdH7e+?=
 =?us-ascii?Q?8CoWAstJux9lWxqlJqZfOxV1Wm5yAIVLl4ZQiB44ewjdgt3j19BNRK/6REzO?=
 =?us-ascii?Q?xDXLCQoGOEGAaemqqJoZyJY2spNvrCuSjeziSSNJBcbo2l+/mjGqDDcqDq10?=
 =?us-ascii?Q?cwvuWPkfug3qCo2fhRoDnj1ux3zmu6oH6cyXiFhBhV1mpUyHcyYvj8s4yiae?=
 =?us-ascii?Q?Hp6/0w4dwQdkXT3C739n9H+31/z+n0leabLSbONeOjJ0ZKMAgSc0V0lbbuEo?=
 =?us-ascii?Q?kPWavOOOuYAudRaPrpzEyPqnKoYCNZ+4xhuAEXJJjs3mYlIlqOVvJFhFmwE5?=
 =?us-ascii?Q?HeIDYRiC0WgBw0GcWa8/V6Hg1aRr7i+tu3u6vbglWFBg0B46GIA9L055br6l?=
 =?us-ascii?Q?nDMb72geU+gd+kuZfod5xzm0Y2uIxMtbDycn9sw+6TE8HBV9B/l2juOXhKkb?=
 =?us-ascii?Q?J9DnR8zIfsf44nYzbKRGRmV+U4wdfEbzoCsdvm1j69VvPBnmB4nf6s9FiiFU?=
 =?us-ascii?Q?OhXjGjzwh79gWM7QV78uboskAIb43zaDDWpMHy37c3FTwSIaZDQE3F+S07x3?=
 =?us-ascii?Q?xdnE1w1LL4mkztyNw33PlWNS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2345dc-e78c-4b48-6011-08d905fc16cf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:04:12.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFcWf0FrQS1OzfRWHU5qDxJAhlTxmj7ItCCw6NJj6VUX4Hm0Qb3dklOBW91obSya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After draining the stale retry fault, or failed to validate the range
to recover, have to remove the fault address from fault filter ring, to
be able to handle subsequent retry interrupt on same address. Otherwise
the retry fault will not be processed to recover until timeout passed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c102c0a6dc7d..96b566815626 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2363,8 +2363,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	mutex_lock(&prange->migrate_mutex);
 
-	if (svm_range_skip_recover(prange))
+	if (svm_range_skip_recover(prange)) {
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		goto out_unlock_range;
+	}
 
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
@@ -2426,6 +2428,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		r = 0;
 	}
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
