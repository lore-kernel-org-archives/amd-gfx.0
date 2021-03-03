Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A48A64EDC
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A48A64EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CC489FD4;
	Wed,  3 Mar 2021 09:26:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF5E89FAD
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 09:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRU1cZMyTcEdu7i8SyKDhURLDKz5tKmAMcimT9r1TSddhfhnFscdvafWnHgnSxEWRKPJMWJIuyWoJyx/+2pKbf8eFeOM8Ky+6Plw4MrfxECy81HEogXvAfl1oecOsqD6cmVd3btJh415g960kjCtqPdnVYUOYuUHdSSVMoe+d93yIBy/e9FQyqA+m4GICdIZTffNi+iKsXDj1lBAsH5u4PkLBscYCjim+/tWJlbh7dKtXa2A1KR1TsEuEEcZoIgXH7O1ggpDpx7GnDr3Uv6Y3ia4mUyQhgc52ZBM38Og/7+zcq8tAtW4wJZqc5AXR4mMmR9MfPJq+WfL6IupWK0SKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0CrNbPJauTjXaOLKjuIRGzCmF/NeHxtcE49/rbKnA=;
 b=M0icMVs5GtxOMYNu6pcmd03eF4xzwjmvL3Gc4Esf2+Oa2d7S8TGFgqvN18Ej7kzZco1qQuB1X3NeKeMjLmXYFsn3wD7b5LrHIyKOT28E2IZSZmPkE8qQ6NOFZa/bVKHTwSH10fl1NtwMxUhNJxfWX6guSF7ytMZfUmwKgjQg3cH9thrfudaQyq4LuF3uW7s2WddDFTSlY9iiZBTPV6qFH7Drgomn+Z7g5/Zflq/41X718Qk1zYPSECEMlZu9R/dn0OelmVOghVqNgTVmf/jZ08olISajODcM0hEn3HhsdjlYhyRUfXPw+33LtR3duBRELjE6BB+adcFP29M7u9i4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0CrNbPJauTjXaOLKjuIRGzCmF/NeHxtcE49/rbKnA=;
 b=KPjFw7tduzBNrPxj+QKKSgOv6Y2iQ38e0U2Oz72xubYfhzNQL7fK2VFYureOfXIrJBbUmqHVPuP3yqLWdg1JKWJBiCF0No0rcf6ppbMmWeylxR9LVX5itrl9Ku8X1975zTukdNq/6W/VO/n/t1HeP8f+o7wD/P0l7TN/iH3m084=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 09:26:06 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 09:26:06 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH v2 3/3] drm/amdgpu: drm/amdkfd: add amdgpu_kfd_bo struct
Date: Wed,  3 Mar 2021 10:25:50 +0100
Message-Id: <20210303092550.110816-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303092550.110816-1-nirmoy.das@amd.com>
References: <20210303092550.110816-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.59.224]
X-ClientProxiedBy: AM0PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:208:be::46) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.59.224) by
 AM0PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:208:be::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:26:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68eb98b8-1713-400c-c32b-08d8de265f50
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB246840DCCCF58B4CE1C4BDBC8B989@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yhLhKIbPw3KL+K853mGUniJI0jW5K6ChFRJrnX+FwB2pLPiPGLvzZeJgMkh424BTMEE26eNBCZPBgSKHUi02QZWJKt1737TpSg35btcr84cAKLmGocy/pmTcIJ2JODQI4BrSDTnQtpCfufkWeMNIjzN/f5qJOJAnMtuNO9VIMlcD6FVjHzZSnSjXJOBrnX27pEec8nf1RpomaPxHIA1hqud6EgFqhdij4DyFnGvWnkqBEdIqGNnqG9/1Ir2TPKHkSFN+4ckc2ir70oZAKoa0rU43xvkzZ0IBdD4csmfPzV2YCf922MgjL6IYMmROpG22Ai1FkQU1KsCUnpJUqiGbAc7OH6O2CIPRRslrzqbuinloIlCf1AJO4rNs9ag3oJrahtkh7Yl5QYb1Tq8DAuryauRVvWD3pvskscpROJqBvfs8VrBBKL6erP5DYMHAkkA/8gjrLm5yL49Zy2EaRic19GnJJBZQZTX7h2sRSmS+RXu0sI//PRG8fWMLK5UWH0ews8WdzNWAO5mooSi10RchQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(52116002)(478600001)(5660300002)(66946007)(6666004)(36756003)(956004)(66476007)(316002)(8676002)(1076003)(6506007)(44832011)(66556008)(16526019)(86362001)(2906002)(26005)(186003)(6636002)(4326008)(6486002)(6512007)(83380400001)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ReYkafAfwbrf0ORjJ9vH6nH9gYRzumfVqhXG97+CAYI0Mt4Wnqh55BKH9UWX?=
 =?us-ascii?Q?Ff2myPDSfviN17oEuYkupGTaBSv7Bos2vpXkTRUGEFzUgjRBx23E9gAqodUV?=
 =?us-ascii?Q?Eb9VfxdtLsmoHSZiMMox4Xv/b6qKz9RUuzirZUJYilWeglP3JMnKHaY6yWpu?=
 =?us-ascii?Q?4c/4g7a2u0T4L7XSPwHts1YUC5fCuNrm/l2PnwULrv2fHf93JyCMrXh9e5zG?=
 =?us-ascii?Q?muRaygjpjsh3wKAONgEiWP/CrplFaQZhuZVxJ99Ven97GPJhU/+zs0sTeksT?=
 =?us-ascii?Q?MhPmZWDRoC8wZM42d6hCjb9lMhKo7SEEwE29xAFutQIIZ70uf4U8YrgBStq+?=
 =?us-ascii?Q?PWvm+a/jrU8haaLeGP4s/TuqsoyWWrQJR/LQcv7GAq/OtVMsLQJpELgIXcIT?=
 =?us-ascii?Q?QR/Xd5o0gEActbE67s03caXM6XN1pygis62+wsN9JG1ZKjwXAMGWPsdWcmX8?=
 =?us-ascii?Q?raYzP9NpKjlCzMXWHtnQIac38vCaUO2U+TEcaUfCumOovZqAiHVKfwKstzZ6?=
 =?us-ascii?Q?xv8OYba4CfxI5l/vEcqCbgF1hqSwgxDG3JaFX1Vt6LCvvjwz1B+7J7RYslLT?=
 =?us-ascii?Q?7M1i57TWy49plQo+Af/hjFV7BAw347p9l6XAxzfUl00nAsIveIdlC0DKwwUB?=
 =?us-ascii?Q?gKd6lfwKWtrorwHArCdqTL6Emm18vFpM1dGIS6IrAoc02Eytx7NeImF65zNM?=
 =?us-ascii?Q?Src92yv+CcLqovM2vUrq4T2gmzJ35EUdM8ZhyNopVAZ9aSymp8M4rbUYUFDP?=
 =?us-ascii?Q?bdD97s6CIJsIWdHm80kbWagNkrDs347dzPVuSzKYWc0uG4icfJdhBqTcQMI6?=
 =?us-ascii?Q?7tOuayy73G/DVdLGIYrkxYkglzRA0umRSCvJDPgx7y94XF2o3kJvyPxnPIdc?=
 =?us-ascii?Q?3aA9avjVzgJsb50x8Z2nS0zGZdofdaOugWhngtCNsIKxY1d8UMT5fiEjEeEU?=
 =?us-ascii?Q?sHYIrupgVti1RGTc25n7iYjx08rqUBpl/H+ITfLGk+2f17c7uJWF4ucToYM7?=
 =?us-ascii?Q?gTb+Rzzlyhsg/6wZjn64dFKeJKsWYdJimcY2t2i5iZKL1oYZubRFUjsU6SZv?=
 =?us-ascii?Q?vb80neuKuj9Ic2Y0es/cRyo0uoKIdajaL8l14E3E+FQi5fkblkSZ4t4kV71s?=
 =?us-ascii?Q?576NT4qI57iSILAPTrOsqE1v9TvHskzRdd/FlOoj5N8jaeYRU5xHUOwMNAV7?=
 =?us-ascii?Q?Qg6ynTjHvsA2We335U8RAjA8uNxroJ4X8SiPlqEEjJ5hik87LOhNuoCYvOwq?=
 =?us-ascii?Q?Y20LDYiohwTgpuExSALyaFCiBxb8uJZTgWQ349l+FwnMKm43CXN5Nc9WBFcj?=
 =?us-ascii?Q?/7YmViO/y25rf3OT3tHncU0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb98b8-1713-400c-c32b-08d8de265f50
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:26:06.4176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tDB9depPMUQP80dfPR/D6X4TVF7+rgfvXmqUjNy1ptKst5fH0LILzNCmh6/3KYqxE12gL/3mi6p/nQuhubUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement a new struct based on amdgpu_bo base class
for BOs created by kfd device so that kfd related memeber
of amdgpu_bo can be moved there.

v2: rename AMDGPU_GEM_USER_KFD -> AMDGPU_GEM_CREATE_KFD

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 32 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  8 ++++-
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 57798707cd5f..1f52ae4de609 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1152,6 +1152,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
 	struct amdgpu_bo *bo;
+	struct amdgpu_kfd_bo *kbo;
 	struct amdgpu_bo_param bp;
 	u32 domain, alloc_domain;
 	u64 alloc_flags;
@@ -1227,17 +1228,20 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	bp.flags = alloc_flags;
 	bp.type = bo_type;
 	bp.resv = NULL;
-	ret = amdgpu_kfd_bo_create(adev, &bp, &bo);
+	ret = amdgpu_kfd_bo_create(adev, &bp, &kbo);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 				domain_string(alloc_domain), ret);
 		goto err_bo_create;
 	}
+
+	bo = &kbo->bo;
 	if (bo_type == ttm_bo_type_sg) {
 		bo->tbo.sg = sg;
 		bo->tbo.ttm->sg = sg;
 	}
-	bo->kfd_bo = *mem;
+
+	kbo->kfd_bo = *mem;
 	(*mem)->bo = bo;
 	if (user_addr)
 		bo->flags |= AMDGPU_AMDKFD_USERPTR_BO;
@@ -1261,7 +1265,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(

 allocate_init_user_pages_failed:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
-	amdgpu_bo_unref(&bo);
+	amdgpu_kfd_bo_unref(&kbo);
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 1da67cf812b1..eaaf4940abcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -102,6 +102,7 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
 				     unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
+	struct amdgpu_kfd_bo *kbo = container_of(bo, struct amdgpu_kfd_bo, bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);

 	if (!mmu_notifier_range_blockable(range))
@@ -111,7 +112,7 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,

 	mmu_interval_set_seq(mni, cur_seq);

-	amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
+	amdgpu_amdkfd_evict_userptr(kbo->kfd_bo, bo->notifier.mm);
 	mutex_unlock(&adev->notifier_lock);

 	return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1b41b4870c99..787eb99119a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -551,8 +551,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,

 	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
 				       sizeof(struct amdgpu_bo));
+	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
+		bp->bo_ptr_size = sizeof(struct amdgpu_bo);

-	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
+	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
@@ -714,35 +716,37 @@ int amdgpu_bo_create(struct amdgpu_device *adev,

 int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
 			 struct amdgpu_bo_param *bp,
-			 struct amdgpu_bo **bo_ptr)
+			 struct amdgpu_kfd_bo **kfd_bo_ptr)
 {
+	struct amdgpu_bo *bo_ptr;
 	u64 flags = bp->flags;
 	int r;

 	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->flags = bp->flags | AMDGPU_GEM_CREATE_KFD;
-	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
+	bp->bo_ptr_size = sizeof(struct amdgpu_kfd_bo);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;

+	*kfd_bo_ptr = (struct amdgpu_kfd_bo *)bo_ptr;
 	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
 		if (!bp->resv)
-			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
+			WARN_ON(dma_resv_lock((*kfd_bo_ptr)->bo.tbo.base.resv,
 							NULL));

-		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
+		r = amdgpu_bo_create_shadow(adev, bp->size, &(*kfd_bo_ptr)->bo);

 		if (!bp->resv)
-			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
+			dma_resv_unlock((*kfd_bo_ptr)->bo.tbo.base.resv);

 		if (r)
-			amdgpu_bo_unref(bo_ptr);
+			amdgpu_kfd_bo_unref(kfd_bo_ptr);
 	}

 	return r;
 }

-
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
@@ -910,6 +914,18 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
 	*bo = NULL;
 }

+void amdgpu_kfd_bo_unref(struct amdgpu_kfd_bo **kbo)
+{
+	struct ttm_buffer_object *tbo;
+
+	if ((*kbo) == NULL)
+		return;
+
+	tbo = &((*kbo)->bo.tbo);
+	ttm_bo_put(tbo);
+	*kbo = NULL;
+}
+
 /**
  * amdgpu_bo_pin_restricted - pin an &amdgpu_bo buffer object
  * @bo: &amdgpu_bo buffer object to be pinned
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 665ee0015f06..fa98a1fe2574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -43,6 +43,8 @@ struct amdgpu_bo_param {
 	u32				domain;
 	u32				preferred_domain;
 	u64				flags;
+	/* size of a subclass using amdgpu_bo as base class */
+	u32				bo_ptr_size;
 	enum ttm_bo_type		type;
 	bool				no_wait_gpu;
 	struct dma_resv	*resv;
@@ -109,7 +111,10 @@ struct amdgpu_bo {
 #endif

 	struct list_head		shadow_list;
+};

+struct amdgpu_kfd_bo {
+	struct amdgpu_bo		bo;
 	struct kgd_mem                  *kfd_bo;
 };

@@ -247,7 +252,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo **bo_ptr);
 int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
 			 struct amdgpu_bo_param *bp,
-			 struct amdgpu_bo **bo_ptr);
+			 struct amdgpu_kfd_bo **bo_ptr);
 int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 			      unsigned long size, int align,
 			      u32 domain, struct amdgpu_bo **bo_ptr,
@@ -266,6 +271,7 @@ void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
 struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
 void amdgpu_bo_unref(struct amdgpu_bo **bo);
+void amdgpu_kfd_bo_unref(struct amdgpu_kfd_bo **kbo);
 int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
 int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			     u64 min_offset, u64 max_offset);
--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
