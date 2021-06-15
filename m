Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35EAC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859D86115C
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859D86115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6C189C1A;
	Tue, 15 Jun 2021 09:24:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6AF6E221
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 09:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+YMp71nozke58tHHm+CxAXi1VAdak9ip5psVACMslPykhhjokvZzubyUGMiiewjx4gPxtZ899q9g3aWOBb4+1Xg2LqY4Q8b+tZXjCkqZAA4ifqHvm3WJxQjZTnJ5sf1RO7RA8vJTq81K4304ySHViKHqpgXlGNDpCAAA0gcultq1h5/Bk4uqasNU94j0G7vWy0tfurYnV5hhmixYWwdDGX20j4cTYE/e39rdJVnUxmRrgxlWBCEH9ZRhPPuBZlMS50MPwIj8vBb0Izdpwrtmi6qBOUz7DlCS9vmN2afBbljG70pJeab6qKZxWfV6rdREVpz3wlBBYWQYlIC/xkxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0XdM7Uqb2kOfucSYhP2HJwOYQsX5gp5cl2HaSQESDg=;
 b=DSD5Zi1ts0Z4lI1mJQXq5KIiQP/P1S0GHKmsoa+9eh56sTPHEun4Fd5dARVQjbKxypZRWqQuX8AJ+fcAEmYdAn6gPiKgDqRMJYsBdKFmz61d5A5JRL3w6y6PghCtLCo0D64WlfTne2K33PO+mp1KlVDGCt6YVpaQKPbogro6EJwS7xRHTRHK5GIWGZNEZMwllsDEki2b2ImE1zgY5WSdyjCmhfpX4RSobwWDWZlnBoq3k7Uar6W+cMIUGnmVcnf5AgTszBDGsAkPrSa9SBnkzvR27lHagf79fk02ea9wn1RHlQgyorQSMx0Vsy9ntvjUKP9x8Rc5KPBt4M09xxQYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0XdM7Uqb2kOfucSYhP2HJwOYQsX5gp5cl2HaSQESDg=;
 b=zO/3P4Rmxx+epREWULIwTztoVuuU05Xb2yrNsU/uiJRtPympKP5CFRrzqInUSRJpImX4Ehy4jN37L6901MF6Z1bhgThBFcwEN+Bll6iFon6L4C6AK6UcN6uj6isPWHTH5ogKp7SSwCoE/tknT87c/tOUr/2Cj7HoQSf2OGF6Em0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 09:24:17 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:24:17 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
Date: Tue, 15 Jun 2021 11:24:00 +0200
Message-Id: <20210615092400.5023-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615092400.5023-1-nirmoy.das@amd.com>
References: <20210615092400.5023-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.119.180]
X-ClientProxiedBy: PR0P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::18) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.180) by
 PR0P264CA0126.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 09:24:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 286dda3a-293d-4d15-3657-08d92fdf5910
X-MS-TrafficTypeDiagnostic: BN9PR12MB5290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52903DCF9324F8B7F90341AE8B309@BN9PR12MB5290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08gluhHnG+xp7FOyyALYZEPEFpbmTMCNH1nW6K0R4PerS8Fyx2WikdjUxMymwqWynphIMciQ0DTdWoYdMNaj0Z7Ij6Q4anqEk+64wdXg8x08jw45LySj6dNbxU4N2btf1Vy3svmU6fcQ3zJ3HfqGhswjrwAe0kvQZ4j+7A99RBpMJse1vkOc1CJcxpdebiNFDH6EjItgGO7wkJ1keYIwnixppA0ity7i8mzJZ5bEMmi8r1N3gTefn6xvKAihuq8Gbf/tV0oSxQrHGlT4PRwERSxIF6Zj0OYFCCvrt7BuCfuSwxP5cGVkLVUleyqW+TMYMCTg3e3d71dwP/roPXK0yew0Bzc9tGo18gY0+TSlM/joTZ+qDoU/UkqHEXTMeisMBMX2sT5VtRxrPpsioEZwOvL57LiOm5S+OE0HAY/6/tabpSotSQr8rfDJCENGz9Cb0EHjOojcpYzB+PcdDS/l8Gire3SqAftcodkXCz+lOBjI09YI3dvxc5YPqPTZ46mAbjeOZNfjwFO3VGKsy7ZkpTRmET5H2dQ2kNM39zGcfAvvml2yjbcFVsLwAGDipys2hTrHLGE57smKUypVOrLZu8SGrtkoL9SiS1ImyS4RMeIi97a5NSIr4N9BymzkseBtEV7mGjSkvtNUTkAjCEGzXO3T/fn3zRsAwCzAR+s7Vxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(8936002)(26005)(316002)(6916009)(6512007)(16526019)(6506007)(956004)(2616005)(8676002)(4326008)(52116002)(66476007)(44832011)(1076003)(86362001)(36756003)(2906002)(6486002)(5660300002)(38100700002)(38350700002)(66946007)(66556008)(478600001)(6666004)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8OSozDjN32wcfKFrPkMegJ7WLOFeHYGXwRbkvasZ7+mjcditAekdZ5dOfnN?=
 =?us-ascii?Q?mw1aovOQha9pgsTgNBtZaPrBbXPNbt7sLwldyVGKVFDXBKE3apdpEBufUevw?=
 =?us-ascii?Q?fBjk9IlZMP1VbFTMZjVQroyVpp8QffCbC3MIeeRuKebOAzNjoCESJFtbOjVQ?=
 =?us-ascii?Q?19yxHIJv50WpegPERcaHuCuzzU8q/7kLDR7UYZN7p/cbM5IhEcGBRDqNc6kM?=
 =?us-ascii?Q?guE6fXGMHLmSrDv32xXKXtGU3HI5GVs8JVNgsPXfx8WWwhDeI9KtvIV7gXrd?=
 =?us-ascii?Q?CvHNIRLDDicJHatVzkBWUfCbt26dScWUuUkY9ElYUA24qB02I8UyD1dlm5oJ?=
 =?us-ascii?Q?j3EDHC0Ts6gNfl6nlokPLn6uRdSJOpipAEvuT5dM8nAMYjcoV/TZgIF4vV+E?=
 =?us-ascii?Q?7yfspfPV5YKYKkBfia/g1StGTTqJRA3B2EvF0JZuM1CbntddOAPEl/7zPCdv?=
 =?us-ascii?Q?xE3ufYsDnGumu6mE3b7qKDE8ePrgnFKYFP01q2hLqi/bnOOM8FAjqL/5rVZs?=
 =?us-ascii?Q?/3zec5DiS4+Z+XlYI8eT9kVN7I4k6w6RTkC8eiY43JFOKQsXYrmG6ttt0/yA?=
 =?us-ascii?Q?5cIGhyWaepI8OTr3SaoEI1JEld0pyHVSXZzUcxtvKpaphUFpra6GwYgJp/+F?=
 =?us-ascii?Q?W5s1vPTGlRmhtdRzmP3lZiCjzrZLRkrqsM30VDri80U+SUAckekg/oPRqPlG?=
 =?us-ascii?Q?PDZ1pa7YhW1elsQPV7504XK0msm8v5YmK8T9sR+6jZ8r1Y83f1+DgJy81hZK?=
 =?us-ascii?Q?cPefWNUdb+/lWadMql1HTPNDIv72rjhdxae7TKqd7475+RK96LP6f861Lm9T?=
 =?us-ascii?Q?h/KQJwE6np8e+SmC83DkUfqzMUjMJe9cLrhKAEZsLI/a9gMfH46/7X6x8dkh?=
 =?us-ascii?Q?0MsWo0PZTVkSOtrc31/ENBC3+YH9WA575gqWg0yu2BBnSJkGX47+LrFf9jaZ?=
 =?us-ascii?Q?1wjopbvTDbgqdlw0nszlD2SZ4hznztPmtaZIY9S/TIGZrKFjePxzwRvo+bIp?=
 =?us-ascii?Q?efSJKrLrHPPJeZLH01qU9shWlUEGPIvwKK6bJazyGXLLQKrquBzR/HrleGYp?=
 =?us-ascii?Q?wB1MeZJoLLubOXVs5cjrfnPg5m07IAaWvFiLxAEgJ4YEYXO5a8t5UMRH9+NV?=
 =?us-ascii?Q?Jy7nbWMCl0FqGgqB+2m6jFzOsYRD9XrA8dCIHeO80yRDyXX8HDt8GYbcSht8?=
 =?us-ascii?Q?wpTQJ7Zw7bxXqtJlygKtgDIuC0uJYJv8QjBckzhB25wS5GJ3kdK5pnllXBcJ?=
 =?us-ascii?Q?iPsO3tmuBoD7QGICyrIZbZl/hEcjLAKfKQ9Ng2Wem/cLWNmzJBBXcQOD5P4/?=
 =?us-ascii?Q?y4mDLeP8jZQtyX81BqNFSxSW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286dda3a-293d-4d15-3657-08d92fdf5910
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:24:16.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 126OF5sMDWU+Z/ladcOiTLU/hzZBD2akP64VkHtSi/1x6sNcFzAyMOMSrQBG+nsI2qkxHhVxCoOP/dBIpFnnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move shadow_list to struct amdgpu_bo_vm as shadow BOs
are part of PT/PD BOs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f2636f411a25..3f51b142fc83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4063,6 +4063,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 {
 	struct dma_fence *fence = NULL, *next = NULL;
 	struct amdgpu_bo *shadow;
+	struct amdgpu_bo_vm *vmbo;
 	long r = 1, tmo;
 
 	if (amdgpu_sriov_runtime(adev))
@@ -4072,8 +4073,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
-	list_for_each_entry(shadow, &adev->shadow_list, shadow_list) {
-
+	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
+		shadow = &vmbo->bo;
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.mem.mem_type != TTM_PL_TT ||
 		    shadow->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8473d153650f..7dbf711e41ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -108,11 +108,13 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_vm *vmbo;
 
+	vmbo = to_amdgpu_bo_vm(bo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
-	if (!list_empty(&bo->shadow_list)) {
+	if (!list_empty(&vmbo->shadow_list)) {
 		mutex_lock(&adev->shadow_list_lock);
-		list_del_init(&bo->shadow_list);
+		list_del_init(&vmbo->shadow_list);
 		mutex_unlock(&adev->shadow_list_lock);
 	}
 
@@ -588,7 +590,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
-	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
 		bp->domain;
@@ -718,6 +719,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
+	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
 	return r;
 }
 
@@ -762,12 +764,12 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
  *
  * Insert a BO to the shadow list.
  */
-void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo)
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(vmbo->bo.tbo.bdev);
 
 	mutex_lock(&adev->shadow_list_lock);
-	list_add_tail(&bo->shadow_list, &adev->shadow_list);
+	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
 	mutex_unlock(&adev->shadow_list_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a8c702634e1b..18cb2f28e4de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -109,9 +109,6 @@ struct amdgpu_bo {
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
 #endif
-
-	struct list_head		shadow_list;
-
 	struct kgd_mem                  *kfd_bo;
 };
 
@@ -127,6 +124,7 @@ struct amdgpu_bo_user {
 struct amdgpu_bo_vm {
 	struct amdgpu_bo		bo;
 	struct amdgpu_bo		*shadow;
+	struct list_head		shadow_list;
 	struct amdgpu_vm_bo_base        entries[];
 };
 
@@ -333,7 +331,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 int amdgpu_bo_validate(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 				uint64_t *gtt_mem, uint64_t *cpu_mem);
-void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo);
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
 uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c4c56581780..812c225538a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -936,7 +936,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	}
 
 	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
-	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
+	amdgpu_bo_add_to_shadow_list((*vmbo));
 
 	return 0;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
