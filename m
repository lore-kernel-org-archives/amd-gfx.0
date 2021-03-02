Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5FC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B7464EF4
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7464EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E306E218;
	Tue,  2 Mar 2021 11:34:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52726E147
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 11:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d82QmWqQzQuETemu3U5SwoJLQxJi1rCuORyY70sU7GTkVdvKBKhDHlaVwNp7Xg0+cKPIiJK356V3h1medPMkdgUUJS1HAou4w1BlcFTz0YyH8P6SgbxhQzxcTTkTf/g7iATQ+QIYA67H9qhEgdAP25n2eK7SoFTcLlXNugKmnanUaOxt8MPJyWc/MlBs6g+yPFobhiFpRQRcVSxwTL7E4ZHutUakWJ65pbyBbjbt3trhKEDVnrbjW2FEhkmUyUiZwBBK6/nLXeuHHNFMOTy9u78oW6Ht0v/smzy1SAIyRIQPdHwdJgU8qAudxYD8hbC9Cj7VNjR5LGCZbnVmFV4hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFs8hLUiOc8gDgeZEEh0tP6eW4pmEmj0j1CQ3wO9BzE=;
 b=dXDL8b1e5ThDjY8jPxi4vQNjd79n09s+JLDc/EkSqY2khKQTk9t4BE1DWyLQG/TsWgtZc4HXPLKojf1E469eNH8INZMvYCkdUanQyZ/6XFcHM+1SyXIQC+EBCLkx7aF8046PWWV+ThiJY6x/m8V6vdLapoSEQ158EIjh+7R2o5Lh8sxo4YJRMdy5Pf+1TxoqNi6dqQS8sCrksRWRCdHvs1/+DH8s8JtZi/vx7G02fVTuMYSbZdqr5Dr4KethcVXsN3jU2KYpWPKukgbz0IYh701e8EGCpJVO8QICnoWKi/RarIuM7BAKakY9c/NWAH4rMMDn6dibZf+eJyelmU01Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFs8hLUiOc8gDgeZEEh0tP6eW4pmEmj0j1CQ3wO9BzE=;
 b=fYa5RzzT2VszEFWtGdOfPsy1sDaDhO54BIY442VmN6Km9llAYteKm3D4rhSstQWEcs4bdRU5wEDrWREvzVAG9cdEi6bHp9rkJZWmJwzMGpNUfRhDBAgjVBGY3FfjnP1nIAdlt97u1FtVJExkL+B0vSP4KB6Jkw2lk+0m5UphYHY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 11:34:04 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 11:34:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH 3/3] drm/amdgpu: drm/amdkfd: add amdgpu_kfd_bo struct
Date: Tue,  2 Mar 2021 12:33:41 +0100
Message-Id: <20210302113341.74813-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302113341.74813-1-nirmoy.das@amd.com>
References: <20210302113341.74813-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.44.238]
X-ClientProxiedBy: AM0PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:208:55::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.44.238) by
 AM0PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:208:55::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 2 Mar 2021 11:34:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 652f7e4d-48b0-40cd-fbf5-08d8dd6f1576
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB13816F62816999438126BFE38B999@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFU26Ep0nBFNL3T5flUvbkRFsdNl4bPD+invCISyuOvaLEUeMVI5K32jhJc+vLsI81chDQUfmdnkfmoz4JH0qYE9eEeQnOMP+XGhirtRTaytmyxctl+kvMGORvyqhmBxZEWCW32LkHdgXyKOwd1hxeURoWObFvZtf5S8zo8akslN7b0hmorkuFl4xPoGOumqwUYAPfSyu+ZUFRpO+p2HMIe6AWvIcYZyeRDfc273CdoUB559xOk7OteGz4J0pfJL8PUKr5Vlk19r/HNVKRnomFuv7QokWduLBZJwWl4Zc/rLxM5DKC7YdcHXLC6quVlBp6jkmMQG1rLijR1dO4QUb39nuG5I1tXi7s1MjMK6td/y4r+2XpanYuHKlZgMXC29zqfTwZwXnpWBt0T9JGaA9jZl5xv7z6n+ioJu04QWUmTTc55VQDw92s/vBuYTU9TdPq9mb5wKLymBkSzDgJTAyd3pqEp/24pInnqLTulroeQ51SYvpbd0khQWY5Sdj/R0F9gczKhCuAShR8lOQYU8UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(478600001)(8676002)(8936002)(1076003)(44832011)(5660300002)(36756003)(66556008)(316002)(6512007)(86362001)(66476007)(66946007)(83380400001)(4326008)(6506007)(52116002)(186003)(16526019)(26005)(2906002)(6666004)(6636002)(956004)(6486002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cvxc2Vkcbr0s/2ZiiaMTjet0vhbcN5fhOdTqwKw6FNm/dXICPLuWCU37ukEl?=
 =?us-ascii?Q?BSsVzQ3cGdujofU3iG7fzK7JHQuaJIIg0cL6g0kxg5hzu0MioAjBdrngKM7T?=
 =?us-ascii?Q?8LlwUq4SAYFss+ujzckvrOEi/l9XKThcT8X551GcNeeHzLNBrCF8dixvfzLP?=
 =?us-ascii?Q?HOb5eCoyZ/hzW9L4kxjLc//9LHd1jxxqLMBWw7luc/IfuaYNo5v02nnZFusF?=
 =?us-ascii?Q?1kTLAQmJ0+1qPvp6IkuVUIXWu5qm05fFjoaLta5V+1Fh5uc8nVt2E8hOABjD?=
 =?us-ascii?Q?DgduLY04FkEsbvejYrqL7Zqbw5mabqIOqgE1BWCrtc5g5T+tVAnPM2ETYpih?=
 =?us-ascii?Q?pPZmucfucuH+OTrY123n+iS8F7cDZHDogankD1eTttPwCbi3FnbHlKN1o06j?=
 =?us-ascii?Q?fYNoW7sC4IeRzmxkKz9wmnK6SrIsu/7hKsW+S9oo2ZZQ9FH6I5iNQsr4bZ9H?=
 =?us-ascii?Q?l9Ftv+SQp7EBYKeHYYdN3YNs1RbWHlAsHZ25E9MJ0RgTMlDGVPrXJlBrVvDn?=
 =?us-ascii?Q?t0FTkEcxR/7xYAKdIW9JMKYGRMdkSikYl7/HUorVTpyAobjUWYzZwkQ2YXz5?=
 =?us-ascii?Q?XZHC8cbWOyx99FzlRbfxC0cGCrKpsnnKFOHlpw9ijlWIqEYOzUbTFGvRRsA0?=
 =?us-ascii?Q?mLw8Z8BdzUYGdFDtq4F0plqkvQOGb3ybGuJUTUVTLCZLnpeUwfnPpUuanqdQ?=
 =?us-ascii?Q?RmnboX64WMnKjMVmKT+VOoHVtvXnpRgPDBFrsm8PFDm+kvqu/Zc8oPX6LoJf?=
 =?us-ascii?Q?vfKjlX/LEHF81pP29viqL+kAzxsl43nh0nxxLacu8c1WNlHAF5LCEgV5BQKD?=
 =?us-ascii?Q?8kPogcAPOb8cj+eSw88ZyyBC+HNThJs/AwCWayf4GA/WKJ31k/Ge8H8MHBxH?=
 =?us-ascii?Q?sNz4zzbntNudjvDDU7qC9oKIGejF8Ba19qnawYvGzDuEeNj5Jnri+DIFIcBZ?=
 =?us-ascii?Q?08acc1BbcvrFHzB8JGPakbq0U4tA2UWNBlZDYBXT4bW1hPd8Kh0dWlbtl810?=
 =?us-ascii?Q?x88zH9Cw972rKPmCXj0gS7ZG/yiG29tjpGP8X8WWKzuMS5kJMKsHt0jFUPvw?=
 =?us-ascii?Q?/TIqjaxd6scT9d7hFv05+ccsoxxkCp/Xlq16XKRJm1Pkg4CJ78pfek1+3KOE?=
 =?us-ascii?Q?17Zogp6Z/70wDhAnmjMDGtkJo4AWVZlIfIU0oDvWVppEsHSkMueEAlcL+JSK?=
 =?us-ascii?Q?DDEOzw2QtIBeIB4LSrXLTFhgsiOqutzJGt/LIO7FojCJDYARWave2Iqxm4ei?=
 =?us-ascii?Q?TlcT9tmHBxJQRLe+I5LBYCkvUBpTMBvsKPzcezPqwiH0NoLaBmRdGBvG+/0A?=
 =?us-ascii?Q?+cDGN4ogSlQVkGBQQzKWVjVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f7e4d-48b0-40cd-fbf5-08d8dd6f1576
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 11:34:04.5952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRLof00tBULyNNjBVc3LwWBvFPpjB7CCnF2DXPgVELzq5YjdNiT+BheYcPxa1mzREKj75mBu7FxdDJCBCXnGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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
index 5ebce6d6784a..af40eb869995 100644
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
 	bp->flags = bp->flags | AMDGPU_GEM_USER_KFD;
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
