Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC4C43600
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F8461406
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F8461406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8027A6E0EF;
	Wed, 12 May 2021 18:43:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05AFF6E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 18:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+li+lFLhZ9M2wqCuqpRSja8YujrwBJ9vPGkw6rM0mxddsm3/0uog5OSBcTpZdWWUSihykdBnuYiCb66sp8PIDDlkwc8QyeL76csNkG6xkSoF2j5Vys7uGC9HLEGA86qtX1WuSFhHkB7WuTzdmW2P0MS6jDeHE/xjAc4S7pYHvgsasohU/9ZauIAgYyJ7SEqmUduHQfYGdhCvm3p+9qXiPI3hZzsc4zqUXaTITcbRqlP+M5/L/6Y1DAv5datHjUwjC7Z6GysV3a3Bp1hG9tO5CBKuE6VwInTk6ZtrghRYoOgcz6rfd3qRLW/x3PQy82H9NOoGwS8ab7eWAtU8E/8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTqDKT1ob1gRBPKkeWSn94kBnNJzWGQZ51G+O2P+sfE=;
 b=UDkDUF+33IMXH+sP7YfiOUTiBH8XEyEDfynBnlIYcAH4VmDMQ/uPxpGMk7UKRu4UDIS5Ru5Dn1FZ30a07w7Ca7KVthf9ufmBCryKjeq42RqyaFwACUHEFmJHQw/Bz7tl0v0LzB2kI8PxFaCWyVE3dETJYiq2tvx+aDo9QUwKx7ch9G3aJj/Hi/uyfTCVU+s+E94QrTx9Gow7OylszjadwziqnPs2M9qF1p1DMz/yyIz0qBfxPAHNg87XMEPbDCDMauhA5sYgpscjMMfHD4fYIjQaB6PD2uOiS7i2ftfg5BhDHsNadTn/CPnO3Gb5YZuFL3JByHJ0cj80fxhIAnWhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTqDKT1ob1gRBPKkeWSn94kBnNJzWGQZ51G+O2P+sfE=;
 b=LrAeYhJEGeCRKbNtL/LxZquyV7ubaL96Xh73fqSt8e7f33rZSgtas70JjaFjT5yopBJiy1P9X9z68McCoslM6FNxraS/Ldjcvk21/1ngCLPbH1Uu39bmO7Sc0dnhwxKHavTQ1FXBXh92iuf/NHxNGuzVdDbmj6gvcnb1bTk5Zic=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.29; Wed, 12 May 2021 18:43:54 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 18:43:54 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: flush TLB if valid PDE turns into PTE
Date: Wed, 12 May 2021 14:43:42 -0400
Message-Id: <20210512184342.13149-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512123451.25900-1-Philip.Yang@amd.com>
References: <20210512123451.25900-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 12 May 2021 18:43:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1677b8d3-cb3a-4171-8873-08d91575e4ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25825AF0DCEF401C15AB6EEBE6529@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjc1pA31LUWszdl/KF5PiM1e31Rnwd6Fem0Zk/+jkpEDJk5ORpQilDmViw4RLs//mtkn5Pf2hzvWLdAKrUFP7grNNYFVW6h3LG5fmMoW7VLbzw4ZyJnfX3r9EWR1J1aNOxk30l4624yK2Q5qjVE/11naqsv3NkCwVX5iSU+6YOfjut+ScUa9nOg6jDfgZItg1Z+4tHTSkQSGAynlB7qW52MyKvDZR2vlQ4CJ9rld8GClRViKvototwTGLIMXN/MjMVnrd1e7VvezvA57FLM4uW3bSptUpe1GTNtLdHj3lxOv4txuTm/2gueL3dR1YFjHu2BDN4S6fIZC/M3U+kGP+Hqh6cSeeNlYn28haJehGdfHQS1VQWMo2y3XN1rIGE5MLjEK7Z0x0HkgwNUZy4/4d9AeymHmN4bS8e+TRDrp+QWPi3lFt/EUGELPNCrXUFwCWwxWe8u5pMpaSWzGFGGf6RReyMh3pFti25umtCz+xvbLgxKGLspiuEg9ZHclrOa9tWVaVYgAZv/V8t4gDJa7Fg9f7i/021yyvjbaDycVddVpPAzm/pf22gaVLWyMVpjMPVqxvYYGNaSwarlvWQykjCPZiNdxzQ6vczm95aLDN8K5Sq1v8duyb9irvdDCI5fdTOdbuMmdhVIDnmdXteaOfoUOGJAYPSTHtafDhrbIwIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(6916009)(66556008)(38100700002)(36756003)(498600001)(38350700002)(186003)(8936002)(66946007)(5660300002)(66476007)(7696005)(2616005)(52116002)(956004)(6666004)(26005)(16526019)(83380400001)(8676002)(86362001)(2906002)(6486002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wBgvZg2z1aJnIzeVRJ4K601KQSOyRQVA0Tit4Z7ZXsBLi4IHtM817ojqi9bi?=
 =?us-ascii?Q?Nsuhd3Px60Wzd7ZvnnnZN950NAmtP6n0n/uIJncmikm46mswyJizN9XTVmP7?=
 =?us-ascii?Q?8YLMRw3PH2fc1Whpzk9SkCsEFK/wfGZQQpoGDHTFbUrYWZsuhb/0XjRioouj?=
 =?us-ascii?Q?VoC9cyHu9d6agZvi1xt2uNPUcJZw0OrhGPmkKxtPGzmmZu7k5T6El1zB9O4E?=
 =?us-ascii?Q?UrrBZ8MXR9wIHIDjPel7IwmqmHAUdc/bGe8PUwQj2fW1H+H/cGhvPRF9X2Wi?=
 =?us-ascii?Q?xn69PJhy4VEUrdeMpp4rMTijjX3nFfJURBPk1PEAJgmLQICf7PxGinVPt50W?=
 =?us-ascii?Q?ZD8+2aHXW2jvQupIrfNvP4l2iIzH/yS++JHsxrDDCg06ZVEWht4Fp9M+5mjM?=
 =?us-ascii?Q?kDKmGoODUY3+Y+cqaFXVlw+BuoKZ48qM8bLQqq7/12s6/+4ye7I24xloocto?=
 =?us-ascii?Q?Hwwb1HU+2loC/nQxA7dkpXgDN6cMdrv4A7RqTaorxmJ2UQr53LG/OixstSru?=
 =?us-ascii?Q?2cHcRiP0YpkahCZd9EkANmSepwtpL2UXM1nr1ZMpLP4FwcGiayZcMhPeMFj2?=
 =?us-ascii?Q?Kli5bOENO08bq04k+za4GN8Bn2n3E7XvEhMHcF8YUBybKSpH9loQ/3yETfRG?=
 =?us-ascii?Q?faRkiNFYSlQXp31BA9Z3fKw3ZXt/2P4n/MZEev8jbZO3HvehnkwIYSLzy8dV?=
 =?us-ascii?Q?NuLfdt5yUikAg0VIn4CYSs1KhdC4KQ5cSEAgGFq+UhqqjdcnbHqALVq7iDYz?=
 =?us-ascii?Q?is+TDfe2bcJp51Py51cAsZpoU58LiFmMf+AT67zPqpiXNYCKPaRPjOYRhvsw?=
 =?us-ascii?Q?fMVceNORjO4qN5IHvbLxX0GPdVH1NTWO1dQ8bT6M6P76YjAXECaqyrOOiP3e?=
 =?us-ascii?Q?2TO5sKcgQbdMRXA/ExzWuCmdRIPsbDM4OH+NYHnCwM2bK/ikhhYmvUjI4kFF?=
 =?us-ascii?Q?v1fwrwtBSIuPstxVMnndjwo+Xhce9L4L6Q+0Z/yrskQ6Pxl/kTvqsdS5yRt9?=
 =?us-ascii?Q?+egZdJrJ3eSn1phE61ILqitYrXmjPWI13kWjCIai20vFIalY3SOnDuAresh7?=
 =?us-ascii?Q?DTYttnODkHeQDS4QNyI4qAAX8jDu5xSc9HK0+GT8ShdD7ZnTqQE05EZbLRPc?=
 =?us-ascii?Q?PIKO4dStpUjCeIlhuZow/p5W7lbN9HCB8Cmyrbod9rqNFrv7egioNkcSoCx5?=
 =?us-ascii?Q?PyLgBVxSJlOeIde3hTAsLCLLYdOucfnRnIBwzfTCduXPsRXKAaf4EGZCYOuB?=
 =?us-ascii?Q?NwJubksmZpcYI0sZ/aPP7Ys0m9jjCSilDBKdHnVT6BcisReiG4MlCgs7bbkY?=
 =?us-ascii?Q?psMGX0Zq9bT5a2RunXrl4pio?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1677b8d3-cb3a-4171-8873-08d91575e4ed
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 18:43:54.7084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C+mWa5k2ddfboEDnuW7WGBjoG/mWw/86CpqJxjlKg7BjeJfZnNICl/KpqH3fYNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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

Mapping huge page, 2MB aligned address with 2MB size, uses PDE0 as PTE.
If previously valid PDE0, PDE0.V=1 and PDE0.P=0 turns into PTE, this
requires TLB flush, otherwise page table walker will not read updated
PDE0.

Change page table update mapping to return free_table flag to indicate
the previously valid PDE may have turned into a PTE if page table is
freed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 12 ++++++++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3dcdcc9ff522..f9c00b451a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1583,6 +1583,8 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
+				if (params->free_table)
+					*params->free_table = true;
 			}
 
 		} else if (frag >= shift) {
@@ -1610,6 +1612,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
  * @nodes: array of drm_mm_nodes with the MC addresses
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
+ * @free_table: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -1624,7 +1627,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence)
+				struct dma_fence **fence,
+				bool *free_table)
 {
 	struct amdgpu_vm_update_params params;
 	enum amdgpu_sync_mode sync_mode;
@@ -1637,6 +1641,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.free_table = free_table;
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1879,7 +1884,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, nodes,
-						pages_addr, last_update);
+						pages_addr, last_update, NULL);
 		if (r)
 			return r;
 	}
@@ -2090,7 +2095,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
 						resv, mapping->start,
 						mapping->last, init_pte_value,
-						0, NULL, NULL, &f);
+						0, NULL, NULL, &f, NULL);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -3428,7 +3433,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL,
+					addr, flags, value, NULL, NULL, NULL,
 					NULL);
 	if (r)
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea60ec122b51..41a55b035cda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -231,6 +231,11 @@ struct amdgpu_vm_update_params {
 	 * @num_dw_left: number of dw left for the IB
 	 */
 	unsigned int num_dw_left;
+
+	/**
+	 * @free_table: return true if page table is freed when updating
+	 */
+	bool *free_table;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -404,7 +409,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence);
+				struct dma_fence **fence, bool *free_table);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b665e9ff77e3..4f28052d44bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
 					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence);
+					   NULL, NULL, fence, NULL);
 }
 
 static int
@@ -1137,12 +1137,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	bool free_table = false;
+	struct kfd_process *p;
 	uint64_t pte_flags;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
+	p = container_of(prange->svms, struct kfd_process, svms);
 	if (prange->svm_bo && prange->ttm_res) {
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
 		prange->mapping.bo_va = &bo_va;
@@ -1159,7 +1162,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 					prange->mapping.offset,
 					prange->ttm_res ?
 						prange->ttm_res->mm_node : NULL,
-					dma_addr, &vm->last_update);
+					dma_addr, &vm->last_update,
+					&free_table);
 	if (r) {
 		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
 		goto out;
@@ -1175,6 +1179,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (fence)
 		*fence = dma_fence_get(vm->last_update);
 
+	if (free_table)
+		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+						  p->pasid);
+
 out:
 	prange->mapping.bo_va = NULL;
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
