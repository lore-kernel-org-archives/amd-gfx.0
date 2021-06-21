Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D36C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB00C60724
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB00C60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F4A6E1F6;
	Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABAB6E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsIZ3ag+bJytYErUU7jx8cBzLUGJsPF9YklS7x63FaqcfIM/8oacLj/tmokveSPk1tRQb8JP1TnfCY93S6jpNbESx+3QNMJP56N4XWMwpzzF7Qo9VAsfdrQTmqbwsn6SW3f0zC7xq0UjMo74YElJMwNfbvJB/QaWwp0IkGVr4bb2AbFWpdjkI5iswd1RC1EpPTaFR2TsuipgrE0Ec4JYBOCXQzoj+dUHDuiBTwohgBbiwTjFMDLG+0zztuJPUD5g1+Y/fKiyJWQ3KUE3/0i+oIW3uT06LwFxCJ1iyZv9vNxxx3UPVSAxIsR658yEu918d3Q93BDytTd1Da3cSCmBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mYUU5KITuu8U/A6kaa2QD27FiCrNCYzB1XJ1w8M5iE=;
 b=Gj9gZ4yrFWYs7FWrjUtrJ7Y+nTZF6MWG/N8R3g3v3AWHHcHnwSLj8NCNNnLCq5YBn0aX/c4R8x70cOgrAohT3NI3zXmBMTzQuqUaJunQPwFYtJ/zaPjaJoJF58PMjwBA588xKyuHOYyxX4jD4P2NsGycmP1QRSkx5k4iww1KFtHCALXD75BlHs3x479MoCN/wLTzY8e+4NHvhKyzr/rKdcanPufgnqysi/tDVUboj/0Is3kYvNYPLSzPXmigei/ut3zh1MEQgHT4ivTcZlIbJ+Apks5yvsMO0E3CvuXUi4nBGWCKJI+vpRkHcDUG+vsItL0d8CRtA1sqTszPC+powg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mYUU5KITuu8U/A6kaa2QD27FiCrNCYzB1XJ1w8M5iE=;
 b=DkMOg+Rb/eDJmy+FYtjLJL6MNwdMP+pMGNI2VlgcnU9kM7S3W8BJL7LURjWJWd0ZLoZWD3SXeVL7XHSs6946H4a5apyrMEudtjcw+KgIgRPScaOkKtmFFB63WrzjncJBJ28V1qop1SJS4ktZHHVNx1i0NeRfwvFECKHhffeORIE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 16:04:42 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:42 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/10] drm/amdkfd: protect svm_bo ref in case prange has forked
Date: Mon, 21 Jun 2021 11:04:23 -0500
Message-Id: <20210621160423.3517-10-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca903a03-b9ae-413b-2492-08d934ce4788
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-Microsoft-Antispam-PRVS: <SA0PR12MB43652D627AE51A3053F0F156FD0A9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hn8Coh8T6hSK1tYRWDEQTfsPOhafDPCdM98lWeG0ilKoIiShDqavTvt2NDdJuzM3+qV0zLvg3UYP3FcUTUVy0eZRiNJKbiiA57fImQkqm1DN2h1OMoRVzjeQFmXM3NUi4JPXiWrg/znOJiQu9vaewPhfLP0dAGHaYbjWdfsxoSXpVxx2ck59eOXVlU1ZUD0s+xbhHrRnubOIDzt53vfMNpj9nnKj6vMiwPQfNFypv7wQb1AZMpLuVxJO944PE11Fotl6wD6ffuGas6+Md7a8/5dg99DgYpXOHv4jSKc1W80nLdh0kqSGiURbsHEMhXsvbDbx9u6QPOKhxQMjK6QG0legdvUHAwWZU5tLnv2B4+5wXq7LPNdJYoyHOfd89xAaXRvcmu9teraOoGmS971QWjbjfLiqX/W1tWS9zm/yqhHHGSdJ99+UJcpTqIseg76463dmD10Y3kZpJXciK0/kLBbkxR61Vs4fZonqjh2Oz9AnWKV2qB8LtQULMOojrgkqZvuzweggbMlKWHhHj+uPfVDzakfAQyf9i+trgH4kIYYxxN/s6boxDkVrMgoxAAJNw6RNB+lUUeHRYOYGwYJPiyvejtMAzlgAHREUISTQFW4bBsWFDF0ZhZeQAZIZKE41ZbSVe85W3g4NAhXl5oWianpJ7XExOB0uBmlMjaYzGac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(8936002)(7696005)(52116002)(16526019)(8676002)(26005)(186003)(83380400001)(2906002)(316002)(6916009)(956004)(44832011)(66556008)(6666004)(6486002)(1076003)(86362001)(66946007)(478600001)(38100700002)(5660300002)(36756003)(38350700002)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4f9y14zbInX1m62k4r2gclH8HdGp+VAD+IjIfypbXlqgcCJcIWkwBzAM4C6?=
 =?us-ascii?Q?LwoXU7TRT1XEqqIiRJuRqw8ZEwky9u/5sA00jWJiZLO6HaYc9DCXUyGe/Kh0?=
 =?us-ascii?Q?YS3dLZuR6hGEn2s+xjqIr+An0ywN4JBO+StuYC2J8On1pfKgPs3wgKcJKLMj?=
 =?us-ascii?Q?GBsmnyJQ9Efy+B7wMbxH67FteaA81J7RXVeaa3bjCyzir60BdMcWc1XWuR4/?=
 =?us-ascii?Q?tQT7JtiauCzFKie2EBkfVyfPiTqxvACFKvSS1wvpJdw1oQWjfUcTjAATz1EG?=
 =?us-ascii?Q?35tugmR8CH8+tT1xRCLAZP4GdpivG2/W/zbjib6cKHqkDDAZdZ2Rlm+IDI47?=
 =?us-ascii?Q?qRzzJ7eYPcx5BmaIHyT0XOMTnnC5OVUzRkU2MY9Ii36LkCCv+IPutym/TyYB?=
 =?us-ascii?Q?0D+r1kzvUfK4OBQ51aiVSK3i6eHT7D4I5axS4O2/f20Y9xxaG6FqhdFd8F79?=
 =?us-ascii?Q?PhfbBYRckQfnINL8eFbo8jcz0NVMyseFU+1HIqDMx4d+j8muB80z1xXaXWaj?=
 =?us-ascii?Q?r+L1eCCdTqBpxRtB0+yVgCZ4DeIdUlmwYbudNobnwC9Ajwpso7MCjc4wfuPM?=
 =?us-ascii?Q?cHOyDmD7oeF3MBbB90PP7VNNr6xgGHgRXzwd3kLaMAJijU9n7X35Q/gEKm0t?=
 =?us-ascii?Q?Mdz/XKSaC+lM7G7fUdiun+JNEyKe/Er4yUxwdJnx2wdFUb0Ph037+pdkekNS?=
 =?us-ascii?Q?qrMYwKtNoZO2wtDhE7ca77Jbfdofi1hlnWLPlKt1IYx3l4d9OhJsGhqmjrpD?=
 =?us-ascii?Q?4wWUjofcS3Qae1+Rjetc889SsDKptwUChhU3degYlU7uQEp8X91YM6mY1vco?=
 =?us-ascii?Q?+9XxG1cK7ISO4YJkkHWPK1jEQqH7KpzfIsE2ymVD6StquxMQDiioVc3LEbsZ?=
 =?us-ascii?Q?nH6I5MDsJzO9g0+zfZMRCEJVMxKscQSx3f2ytlfBoXf7C8vy7reepR6x1O2h?=
 =?us-ascii?Q?X8lc2413kbhNPu57MLyiBnBcbbHoMsGuoUQiz/RayGF0FVcaIZ98zC9n1Asz?=
 =?us-ascii?Q?ahH0Ev0zA2qceVoArYHPJvOCLCOaKkScibvLZs06mB18UH/rWZ7qn8Ne3O4Q?=
 =?us-ascii?Q?VI7P87i1XaN2bRTZmiHDa8g+7uFHctkQ1whXfSp1BwxGQx+gLlesK4PzmbmE?=
 =?us-ascii?Q?ho8ZuGFdTUv/3cf/aaaYKW4ss9Zfk/r7ad8x9Mq9fwCU++KSHRxFbvTgicID?=
 =?us-ascii?Q?6dZfNAwfrX0PCvYk/vEbS6iSkUexsPXPAbSCCKatCIeP0l86EFz//CAfIooY?=
 =?us-ascii?Q?Vr9SdNygwl4Ni8DfgEIsPD2MD6zZLKXPSOSvbcx2asCiwiTY/KWE2ByEiArc?=
 =?us-ascii?Q?sC2X/zNeGbAq/Uxmbft5U6UM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca903a03-b9ae-413b-2492-08d934ce4788
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:41.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ik3Tg9Gnhp4+Yoy8Tl3/f0L33//lcGiBxrFJWqyGKJe58Ev8mSlrMliot8YNJ36hddCFtgKi3wNrc4Z5j11zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Keep track of all the pages inside of pranges referenced to
the same svm_bo. This is done, by using the ref count inside this object.
This makes sure the object has freed after the last prange is not longer
at any GPU. Including references shared between a parent and child during
a fork.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Change-Id: Ibfe5efbfed28c2d7681fe091264a5d0d5f3657b2
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 10 +---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 10 +++++++++-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index acb9f64577a0..c8ca3252cbc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -245,7 +245,7 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	struct page *page;
 
 	page = pfn_to_page(pfn);
-	page->zone_device_data = prange;
+	page->zone_device_data = prange->svm_bo;
 	get_page(page);
 	lock_page(page);
 }
@@ -336,6 +336,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			svm_migrate_get_vram_page(prange, migrate->dst[i]);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			migrate->dst[i] |= MIGRATE_PFN_LOCKED;
+			svm_range_bo_ref(prange->svm_bo);
 		}
 		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
 			spage = migrate_pfn_to_page(migrate->src[i]);
@@ -540,7 +541,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 static void svm_migrate_page_free(struct page *page)
 {
-	/* Keep this function to avoid warning */
+	struct svm_range_bo *svm_bo = page->zone_device_data;
+
+	if (svm_bo) {
+		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
+		svm_range_bo_unref(svm_bo);
+	}
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ebc1ae7e5193..4b5fc2375641 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,14 +309,6 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 	return true;
 }
 
-static struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
-{
-	if (svm_bo)
-		kref_get(&svm_bo->kref);
-
-	return svm_bo;
-}
-
 static void svm_range_bo_release(struct kref *kref)
 {
 	struct svm_range_bo *svm_bo;
@@ -355,7 +347,7 @@ static void svm_range_bo_release(struct kref *kref)
 	kfree(svm_bo);
 }
 
-static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
+void svm_range_bo_unref(struct svm_range_bo *svm_bo)
 {
 	if (!svm_bo)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 27fbe1936493..21f693767a0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -150,6 +150,14 @@ static inline void svm_range_unlock(struct svm_range *prange)
 	mutex_unlock(&prange->lock);
 }
 
+static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
+{
+	if (svm_bo)
+		kref_get(&svm_bo->kref);
+
+	return svm_bo;
+}
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
@@ -178,7 +186,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 void svm_range_free_dma_mappings(struct svm_range *prange);
 void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
 			void *owner);
-
+void svm_range_bo_unref(struct svm_range_bo *svm_bo);
 #else
 
 struct kfd_process;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
