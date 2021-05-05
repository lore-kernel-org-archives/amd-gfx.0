Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE6C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58AE613C9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58AE613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4D06EC7A;
	Wed,  5 May 2021 23:00:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623F66EC79
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 23:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd31cIc2lshuVn2IE4IW+/6oCDyozLZ39D196wVvZif93/CdnIn7UaEebmpezrhql9IGNW3R/p14fWoBXk3V5PK2KN6ANAt/7kdtzUuMFH+G51gIWQYdAAOCtFSAV4bix2nJQiIu91NszAf6f4d6mnGSF6O5HSIFRT3YiWMBafSXzviLCpFw7voe7NBb6lgVH/s3QRhq6vdVcoMigAveKh0DgGYf2UqZhHSgYpw2LZUtBe301PuRZuom2kyHWCeG+GWybBTCZmA6RkKoJzN5eg9aVBW7tZ8NK7PQQfoEEhH+m5tfP0pTEePHSpECTPZKVk8mrEUk0lLmUbJiVBPV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M+aNkTwSiRPPY66McXaoMFOH8w12rErywhWFNwfnAE=;
 b=KZaPWjiUqJ3oArsIjp4O8iNSM3sPYqueXI+XTgaC/ZVzQobb2EbM702UWGWQhlCr6cRT4C00GPnFDHfjYiwqQEPKMRZvLPq4da4VLcKmhGzhYquUzsykAZO2JuEIwM2d7rr0YZmDezPcPFHO73gxXtbwTxpJqvVc4tQHd1Ptu1zXDlogbdy6M/wgNr/zGk1GY2WlfELxuXIBVIZj+ev5EIGqvzaIBgmhoo7I6aOtLxXBp4AKtOnU7FPjZvQ6spoArJpDrBAHFt1rINqH1l/HMXvGYH10ltiz1hjoMDB9c6aAxejv8AGT4fNqBdAJ5kc20W9pi5k9+hgk8hnvwHzHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M+aNkTwSiRPPY66McXaoMFOH8w12rErywhWFNwfnAE=;
 b=LGtYm2bR7XEMSKQWQkyWiPZpiYLKsT0S47tAl9u2Z0YKHjuvzVVVI83t+Vcr+GrxjQL1FXor1+7LSWJ368ObMbLVE7MnIwEVFBF2+bWveQwxXx5QzwpJIGRFAIS0j2gIi9sphIcSewAeJX11LASIei7TE8gNkY7tBjQHtWgNSFU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 23:00:19 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 23:00:18 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdkfd: use dev_private_owner ref to get hmm pages
Date: Wed,  5 May 2021 17:59:43 -0500
Message-Id: <20210505225944.4425-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505225944.4425-1-alex.sierra@amd.com>
References: <20210505225944.4425-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR10CA0019.namprd10.prod.outlook.com (2603:10b6:806:a7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 23:00:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64af76d4-46fc-4ad2-4da0-08d910198daf
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2717FC1FC582853CF885421BFD599@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eiwuez2soV3OzgUirwNke09M622S7ZufDGi6uxD0x5R2tPZhX7O4SYjYmNZEgSxf45E8W7U2ehwZ4LdLTCQL+ZqC+rXVBIFZkcynFGds7nT70QazY6nefKy2UUDs/h7EJOcDBw9iDg+fPz81NOfssbsLiTCM2D+iMIjYuBYlTIDMpM8SNtOaul8kd1+AjHjZTJ8kfa4tH4bNHisSy3ZAeqnLFNTlnAgg3iyvoi3SGshD7JfXrDbveKgM+Y0twascxPfRmkaNLGKS2ZUYJLUciiWArORbPPh98xWGBmG59LpcJSb0Mfh6lOBUgi5A7lLB2tpk4vN4MAA6sI/swa7tSKhQnCveCq3sUD9hV8Y6STUSS4nKIeLcS4391pplt6CP3fEyUJdt45tQW3EGnmNpoNB1eZKhEcWihqfDqqWnZqbqe3Em9KsKuiXQpuSidWET2HgmMTJPutsxGKUUHTTD5wMGUmA5KE7KrJP9v6jV8v66EpwDDJPuQLEiD4kxI11fRyynJ7xV5yUXZhBWiBvy3kuLCS2h9SkR2WKcQdjteUSVe7JaRwcQ9ZQgzRX0JBxA1TtjobLAVhEUqYZZnhVdcr2U7djek98hYGAnTv/QpCuc6QB1UfknwdOZ6iTBPSTRfa97apTuZNW5Ico5JvZwqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(83380400001)(2616005)(16526019)(8676002)(26005)(478600001)(44832011)(86362001)(38100700002)(6916009)(8936002)(956004)(6666004)(186003)(316002)(6486002)(2906002)(52116002)(66556008)(36756003)(4326008)(66946007)(1076003)(7696005)(38350700002)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KFE/koSHPOLH0oXXFXys6uZg2JZAxGV8yzKq+BzA8v+jwGSn2vuStp5qhSx/?=
 =?us-ascii?Q?RgVX3kdop6yCkbWcOU2dkow6QKxpibeU6xXW1ywUIwIidEO+wwBjqQRc+Z27?=
 =?us-ascii?Q?E0htY6o2GoAKEeavkfuNk0goxnRSFor1Lz9Rlri7CSaj8JRADhi9dW+kY8yF?=
 =?us-ascii?Q?TpJcUh7tRCW7MrWxseIviv2viehCkp4/+mniWRIOOIMqn2VMS0FMCAl2idXy?=
 =?us-ascii?Q?zG4CJW0UaLfDBY9kgfxd66mPSZzY/xpy22uEYPomSjcUX2Fwbza9L8Zj31ff?=
 =?us-ascii?Q?J9p5F0pLRV8teW9NCmukphPs1yqChWATtVvVAGu5PbyUuoO7xG2aaDbDT4k4?=
 =?us-ascii?Q?XAX+pd9O4sjo+cO2o3S76CQPSoI5gNNlLFnOsj1oG7q/AvoZ/xtDkhEm2PII?=
 =?us-ascii?Q?5c8h97HumInut1+yj9soLeB12eI301a03/EbrPqgKenlT2TsMWrRVkogZ5gZ?=
 =?us-ascii?Q?jMgYP1z/sLqLh2fra5ciLq437A3dGG53yfDdNG/mk6OITB+qE+RqbZBoLwt3?=
 =?us-ascii?Q?bgu5Y/8p3TbvLortmIHd25mqrF7Y3m1p3313Es7x30iUmKY9VQTC9YO7VrQd?=
 =?us-ascii?Q?j+6I7YXn/xct38UvZkC2a4Nwwkn+Ur+cAHBsICCAwokwqqzhontMMjAzCCF8?=
 =?us-ascii?Q?/pYcre2XLH//9DcLQtw0JVQthHgwsDyMzD6GeiWOkkBV1ZhEPB/1bVqPv+Wj?=
 =?us-ascii?Q?dJctcyImPgIF5UglMEqihqWEIFW+mypRIAJ4omwCZTSTYW4womTKVY8/fR4s?=
 =?us-ascii?Q?p1LMH5jpHptLuBG8gSHsGEX5BuOmQhsoPTspYagcxTb9VM9sCD19hLGjl4hW?=
 =?us-ascii?Q?OxK/IpIqEWktBZnGlWP4ADFovdo5/0UQ0fG5g0+OuRtdwOgE/tb1J4EHRMwC?=
 =?us-ascii?Q?H/k9xkZlUXS4ZBftBPcT8BrtA4wuhWm9w9Ujf4Pru2JvY0VFl3U7XzeaSOFz?=
 =?us-ascii?Q?ga1ZbDmYWgOfOms2rqwWHEdivOGLSFIgnurWFWSpTrC9nJm51V8NBnnH9ajV?=
 =?us-ascii?Q?/pBayDC0+L4RuDPzTdpwtRTQ8GgSeADMNHQZW/9Cio7Zm6CRU9VlwxOAfEMf?=
 =?us-ascii?Q?sWkZBPqcXM7Ff57zn9BlKTtbMZ/tZUP602sAxBRd44825wphaeUVhJyIiniN?=
 =?us-ascii?Q?ytRNC6DekzCKnV5T7OFaScpTdrCUupL54/OuaqLxrLIc3/097w1p1UzGpvwT?=
 =?us-ascii?Q?Wk8U6cP7eg2YhZoN2+IYb+9fiRHcHS9VGzWXL8BJmd1wNSeIou3j6dZIKXjS?=
 =?us-ascii?Q?JWYHwIj5gaCeMLPlTu1FzX3UU566QaFxP/wFil/cO+0BbDQvpd/9i5JXi1HJ?=
 =?us-ascii?Q?UrBEhpx4KrSRIg/kAaXm1Mam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64af76d4-46fc-4ad2-4da0-08d910198daf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 23:00:18.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnBTta3TCLTiIM0mPycA8ZaCiSTZthPJRVc9cfHQOQG9hUr/6ZzYsflVTQROMfWcI1ApFz0xVrPDB0JEg4uDdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
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

This reference helps hmm to decide if device pages in the range
require to be migrated back to system memory, based if they are or
not in the same memory domain.
In this case, this reference could come from the same memory domain
with devices connected to the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 30 +++++++++++++++++++++++--
 4 files changed, 32 insertions(+), 5 deletions(-)

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
index d9111fea724b..7104762a0119 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1304,6 +1304,16 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
 	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
 }
 
+static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
+{
+	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
+
+	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	adev = (struct amdgpu_device *)pdd->dev->kgd;
+
+	return (adev->hive) ? (void *)adev->hive : (void *)adev;
+}
 /*
  * Validation+GPU mapping with concurrent invalidation (MMU notifiers)
  *
@@ -1334,7 +1344,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
+	void *owner;
+	struct kfd_process *p;
 	int r = 0;
+	int i = 0;
+	int32_t idx;
 
 	ctx.process = container_of(prange->svms, struct kfd_process, svms);
 	ctx.prange = prange;
@@ -1380,10 +1394,22 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_reserve_bos(&ctx);
 
 	if (!prange->actual_loc) {
+
+		p = container_of(prange->svms, struct kfd_process, svms);
+		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+							     MAX_GPU_INSTANCE));
+		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+
+			if (kfd_svm_page_owner(p, idx) != owner) {
+				owner = NULL;
+				break;
+			}
+		}
+
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true);
+					       false, true, owner);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
@@ -2650,7 +2676,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
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
