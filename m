Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80864C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BC8613D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BC8613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC6F6E049;
	Fri,  7 May 2021 03:37:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CAFC6E045
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrcpsq3iu7lHjY6+mcLWx7aJJFwmksZ320mxdmYCbTVlWKZcTuJGKevZXNJfMdUZA4tKD6HO9LNIa2BTdGzRcZGyVzCa1mCaxR+t6iF9vkW0NCCMuSn5PnCOo4noK+0moS6f0C440Iu3yFVrKExLnOwSEX3V/+URVdC+WedgBvBxWMbiuFa36gVNyAziVAAgMRuLrhb+t32/EFYr7SVWo7kvh5FZJS5zJvtlxCEAZ56buoQKaVOeS6vczYr9oUvqalcnCJDZxwr78zygPIOTy/RqHNuAqLgtj7HQnie2wE+JsPgmX78lqLgXpWNY33q4knApdCNDD6FIqjTT7HhE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auPKoeX7mPL2sGziSLQgjFpZPsSpcpyS7c7FGSphmlY=;
 b=cX3z5eTjgsixBnPpWh9FyEgq/ysDrZ5jlIi06xQB0Ibb8F4fkr9bKpJiE6KxIu3FfinBgIeuQrQtQ7Kkm0FfAAZWE+fK9F7uoazSE5J4ft5mYfYi8kbLMCfSn8DN3x0fWKj2NJ9f89xYzjfKpZQP2j2naptSHdzLbWSPbhYWPyVU8ooPJxUimaILWxgJdoxE7TcSYGFBJCCErQE00ephP0Z6WhIfbAVzNeyjtz1ngzXSxxnjHbR8kD/qo4f+7mal+YBvNP+MtBAYj+1GgB7rdzuwSKRiDzYuW/KJjmiQcccvSoNJ29SbDj+DKCH/Wxya2BYPYuZxFEM5EVQkd2Yzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auPKoeX7mPL2sGziSLQgjFpZPsSpcpyS7c7FGSphmlY=;
 b=qeAAfoNx1cn7To6F/mQV6EZ1Ikts4YBqZc0EdgyWLkE4c09S0NmB/z1Apocswv5mthai4XgWLa89b+tAAlluYtm/1QD28DGsPUfpZ+9VyXfmnlj/H6jZcAYdnWqhrJnwb9/eW7GVOGdfuqWBryFhF3FlrY97hxbrCuSWt3z1f4w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 03:37:17 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 03:37:17 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdkfd: add owner ref param to get hmm pages
Date: Thu,  6 May 2021 22:36:34 -0500
Message-Id: <20210507033637.29622-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507033637.29622-1-alex.sierra@amd.com>
References: <20210507033637.29622-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Fri, 7 May 2021 03:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85bda5f-9096-427d-2968-08d911096967
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365E0B59E6D26F1A71BAD3AFD579@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyAqjsTHAuFZD4EYlgN/Hs53lgUoqnNbJKuY13t3ULqgimjLdRhces3P8UBVwieKnbMtgIp5/jLVk6WZuMTJuhsPcWeuSKE5s8n83ZQjWu0fegdQJbVjkXkdpmGnYOqi14O6rYSWQjLbMzTrLev4x6nDl9GjDH3sNc7puj89fGXwBwPIByTAxcCmWh9+4YAJ5pxUot53nJiom4SlYWk8Bs48MqXEI6L/KMToFQjqeGL/XMZ2MoVkahzbwgENOOH3Pxe4VCpRmih3gafrA0fcMr/fIL0JNelW9j7y26FyMm0J9YQhEM/p9JJrcePbeAv5clmD21QcanGZhvxQH3NHgNFOqgsC8njAGBcH7dwEKcFWzdRgWD6TPl3/aS3LBxwv7Se0qvDaqyH/0X/ygRsSXBnGAM2bNxppocAykn6NFFaR2dfPfO5nXMXfPmKse5zbo4a7eozDOznEAGJr/6MsEIGvpa6d5W2dywCJbzuDNKnLsAAigXDeb7zg7zTnOBXCw+/9EKsi+4Ek40ba2fraAKzyI9GQGVW5Hxd/Hf6rMMkV+WgCRU2MTduEExPsolB/fRa0tZrNZ4ztj9+1be8zV0pcFaitW3rbbIQp9lfDaStFPl/Qjv0Sbem4GRFeyrp2TB1Lvd2TA4cSrSG7I7jwmefU+yR3PvNVErQ2cuMdN24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(26005)(8936002)(66556008)(4326008)(52116002)(2616005)(66946007)(16526019)(186003)(7696005)(38350700002)(478600001)(66476007)(38100700002)(6486002)(44832011)(956004)(36756003)(86362001)(316002)(6666004)(6916009)(2906002)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Uh8UBZqMRa1nAcy8qSI7qGjwQ1ATaJ736/QPjf4i7vn4dec+LPOERsXnwScf?=
 =?us-ascii?Q?esV+O8v8TRkNX6j1uEIJkSLHgu4xdAmcv833enUuA7+zBefTHH4k7re+0pOM?=
 =?us-ascii?Q?X36R33FrjMdqJlk4/DFnbKLc+yE5j4aMWbMa54iDOyW7hjzbf/7e263d49+J?=
 =?us-ascii?Q?Vlr0Vl82Lw/3k2gHkqY3nn/ShO+YjERM+a+Etkkp04lBY6wTv6TEioSQWy0c?=
 =?us-ascii?Q?TmeZ7jyWiO5bEgInJaSjtZWV8z1rqzznVx2b3+jbURXbEOgYBV2tdkF+9gkt?=
 =?us-ascii?Q?JhiasS85Eg+r3d7t1r47qiahZd5ubmZfuewJ3+ycjkkYa9H82IqtKgPp+Q91?=
 =?us-ascii?Q?7uxM2Sa84n1aQl4bnA9J2u16a85+4FEcKBkwqTRwC54//7glPDDUGegux/nR?=
 =?us-ascii?Q?Dl3p/m1qjbzd7/OXun3s8OysR4kb2i/th+1s/o7lK9mQ4gXGTLsHISACSwy1?=
 =?us-ascii?Q?vfEY72nm5v/9el0JgIFdwvX29cb0shVOEiiZM1akHT4mIpqa5er0tpPhU35s?=
 =?us-ascii?Q?MJbE8E46ix6qys2qZOYQsnhdE/k35LunnOGR4RIqCoDqucvc2+iuHksISh0l?=
 =?us-ascii?Q?hkkOvA+SS4S3AxIOpwQfLM0dbBmvF3zLH61akPO756nfxiECpMFvauBnQr70?=
 =?us-ascii?Q?f2//CnRA6b+mfF0zEZSuKZN67+hOj76Bf/t0Tu+4z6S9bN4Cbf0N20cWWy1A?=
 =?us-ascii?Q?QApB32M1Kb1TTF10YfvkW8M4+rkWgVwn3Vq8O8eYcowcMqNdJVtKSWvinATv?=
 =?us-ascii?Q?oDwb5ve9QYbhrlKAtlr46MzK846+r5TSzIjdmKsgKLmskNgd/dgYj/h9jJe+?=
 =?us-ascii?Q?c67m38cfczlCMiLAEWQ8Qq6uxOs2/SHZqpX/j/P6LvxEDdB8wOLVyMYnA/UA?=
 =?us-ascii?Q?ZJnRhnmjPSOOByIdsQHT6UqQEjNnV98MUFVNveg7sxulRhQ2K6EtKmvOprnb?=
 =?us-ascii?Q?a0S8XommA9YcxfboCnWnIO358JjePPziTyXtsK5x121OZtf9TfCQrdyqqm1i?=
 =?us-ascii?Q?Oiz7Lf6NS9LbWZZ2s4Sq9ZFkzatG96oxxnUmNR+pqIPzZ1H1OQcHrADjR1eG?=
 =?us-ascii?Q?f3fT6wjF3b0MXyhf18FJwv29SP6wMnbnEuoTlILesKv4oGSDW/O3z3S1ZXhq?=
 =?us-ascii?Q?ByuYtnBp0uKqftvhVn+91k30Mnm1q+UehdRIai/Fizk6OcQI3hfY+B//r2jW?=
 =?us-ascii?Q?Djn9uzyFHWmDkD2BBKClRyKB1/+EQMCE7NRKmURl5lcVqAzi2OeNIRK1kZGp?=
 =?us-ascii?Q?6OiZYq/6Fri6dZdnIktnoTBulYE39mNzT4Lc+/mMjFDpeNby4+yE/BvIYEMP?=
 =?us-ascii?Q?ZN5+PqdQ0Bs6Bzx80P/lX6Os?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85bda5f-9096-427d-2968-08d911096967
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:37:17.1825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBFvAZhVe/SuLw3ps9nor8+qvqlYctGiyL1rGWCBPRuSjQnIH6zF9Q2VddMnH56/oreDK8uK8vc38mGcE6fK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The parameter is used in the dev_private_owner to decide if device
pages in the range require to be migrated back to system memory, based
if they are or not in the same memory domain.
In this case, this reference could come from the same memory domain
with devices connected to the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 2741c28ff1b5..378c238c2099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -160,7 +160,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct mm_struct *mm, struct page **pages,
 			       uint64_t start, uint64_t npages,
 			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked)
+			       bool mmap_locked, void *owner)
 {
 	struct hmm_range *hmm_range;
 	unsigned long timeout;
@@ -185,6 +185,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range->hmm_pfns = pfns;
 	hmm_range->start = start;
 	hmm_range->end = start + npages * PAGE_SIZE;
+	hmm_range->dev_private_owner = owner;
 
 	/* Assuming 512MB takes maxmium 1 second to fault page address */
 	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 7f7d37a457c3..14a3c1864085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -34,7 +34,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct mm_struct *mm, struct page **pages,
 			       uint64_t start, uint64_t npages,
 			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked);
+			       bool mmap_locked, void *owner);
 int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7e7d8330d64b..c13f7fbfc070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -709,7 +709,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
 				       ttm->num_pages, &gtt->range, readonly,
-				       false);
+				       false, NULL);
 out_putmm:
 	mmput(mm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a165e51c4a1c..540496d27c07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1386,7 +1386,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true);
+					       false, true, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
@@ -2653,7 +2653,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true);
+				       false, true, NULL);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
