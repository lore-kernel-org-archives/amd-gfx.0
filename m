Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB29BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62F86113A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A62F86113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410246E0BF;
	Tue, 24 Aug 2021 19:23:38 +0000 (UTC)
X-Greylist: delayed 961 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 19:23:36 UTC
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFC46E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afv3yEyGur1O8IqLocfeYT28yFAPQMx/GBvKgDRAivMupkK+cSPiEtGtSGOx+ax1TllUyaL4TPgsVahflNX9DV/FZzxNqO+NF9yx92id2NtRGTYEUrvp2yK0i5bWB3tqoscw9PhdFg79DRTxmcw0v+jVCDwHHaqmiCaw6RDxbp57YT4ifCmL/D6OJODz7lL/nPtcU8RIUhsTbh+WrQ+o8+EpedGsCsGtMn8OtF8c6dDRbC3RmhjZtYevs6Z9lslnDqkeEtIaVIy6AE2DDWBCGm2MkER0yMfkNkhDOIlfPPpU756x/hOCDwTalsfOem6kWJbOiDYyESxga4mEBrZwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGOPkuKbXpf23UhB8rh/xRBA8Ypjdu9ABS/1KvFSXKc=;
 b=abH71GrOh8SG7JYHa6A9hZiIVkCbZNEJS6yqH/14bAuZc/umAcpmhKNiKHjMrfEzucLig8E94Stj1CAWvMIK3k3RglfdFehPKJLKidjTgaQlkJpuPLp0E73dSzi9Srqu8A6v5/QwgzIBXjLYx/oUEVWOzNRPNckkllo25YobucWX0JFILjOoy2+Nwin7afZKz0GS9baQTim6fnaTj842PVXlP3h4jT4obL5VhJmrcCxRhfghoVhGbh3CZtvznEdkqSsHqaMUNZ0FN3XjfBNwFlQQisSZ2QWFDg9+60WgV0c+Nx79R5TiamF0IYyjERxryS9/tT2ih442wZSAsgYjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGOPkuKbXpf23UhB8rh/xRBA8Ypjdu9ABS/1KvFSXKc=;
 b=uKxTjBDji3wOVYiXx5Sdx94bC2RByr1wzGTZEqu8tSc9eiHCIZZ3AnLTRLrexwVHLT93ieQ4dHNJ6YyMyLVNErB1Qp3fESFzj3xIUMjNHkc9E23d5sIqcKuYRy2OoiFMm3jG9jZMYA6rZVyEm8gG4kNmTV83qLPVil0QHj3ulnM=
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 BN8PR12MB3140.namprd12.prod.outlook.com (2603:10b6:408:67::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Tue, 24 Aug 2021 19:07:38 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::3f) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:37 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:33 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 07/18] drm/amdkfd: CRIU Implement KFD resume ioctl
Date: Tue, 24 Aug 2021 15:06:28 -0400
Message-ID: <20210824190639.6288-8-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a744c9b-2d68-4729-fa54-08d967326fdf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3140:
X-Microsoft-Antispam-PRVS: <BN8PR12MB314093F1880138428C49668E95C59@BN8PR12MB3140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGz7RaoH1wiKUaRn8BJSGBiN1dF6CbE4k6dU7zE6ckNEsVGDfTxplDl2sm0pJbQRZ2kIx4boF5p5/wvYpfrx097BBT8TvOT+5xWsQemzHCX+0bqNMCXn/gpdKKaScLc5G0hpks5yYDSf0WN0cGHKHRTLVwt0O3aogQhxplx677zqYyBdW5g5HJPKwQmYeP8ZhOnmzsBkP51hPREA8dKZz85Zm67n0ICTAIwWHBQrawJIxVEzNMBNVHwWN+1a9hbc0ozOA1iJU1XXOiG5+s8kl2ylclq1PGHqbsd0cyZfeDjs/R6cc1Ar5wyXHkAV7mu8TP8LOdKRlHYEHOwTIQavvpQ1WVdrGI6QbfI51L/LHZ9bhvuHRWzAHzdTa1vlQ/a8GC3EMi3vNSBdFPZQcvtcXp3GgIDpIDnfrQSTdY3doxvkwOaImoBAYUQ4Sw5IovsDebGbBLN2vRJLf2Yz+3LBWTGE3sjcr4BOHM2iyOLVBUsMx+yvzYC2ms9n9BMTY+FEMtni01Q/peu/ASXKBbXkcQoHHMLqnxPAuiu9inoiosxx+LhyVIa0QELlO5bTIkq0AIRyeB4E/Buy5Ev5uXQ+pMh8g1pQFwgqw4FRwEwRDk2JWGladHLlG7VMQgGPvrdmqIRzpIzMZ/PK6ReKArVWomEc3GUmhvGMJXmMRYjmvPqbIL1P7+dpA0Z3bdhQvKix4c4s4TSig9PuoeA983NCzswIydNCidhV8HqQDisldic=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(2616005)(82740400003)(356005)(83380400001)(82310400003)(47076005)(70586007)(6916009)(30864003)(4326008)(5660300002)(2906002)(70206006)(426003)(86362001)(316002)(8676002)(36860700001)(336012)(1076003)(7696005)(16526019)(186003)(6666004)(36756003)(26005)(478600001)(8936002)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:37.1551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a744c9b-2d68-4729-fa54-08d967326fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3140
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This adds support to create userptr BOs on restore and introduces a new
ioctl to restart memory notifiers for the restored userptr BOs.
When doing CRIU restore MMU notifications can happen anytime after we call
amdgpu_mn_register. Prevent MMU notifications until we reach stage-4 of the
restore process i.e. criu_resume ioctl is received, and the process is
ready to be resumed. This ioctl is different from other KFD CRIU ioctls
since its called by CRIU master restore process for all the target
processes being resumed by CRIU.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
(cherry picked from commit 1f0300f5a4dc12b3c1140b0f0953300b4a6ac81f)
(cherry picked from commit 5c5ae6026ea795ae39acff06db862a7ef2fc6aa9)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 51 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 40 +++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 36 +++++++++++--
 5 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 313ee49b9f17..158130a4f4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -117,6 +117,7 @@ struct amdkfd_process_info {
 	atomic_t evicted_bos;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
+	bool block_mmu_notifications;
 };
 
 int amdgpu_amdkfd_init(void);
@@ -249,7 +250,9 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct kgd_dev *kgd, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
-		uint64_t *offset, uint32_t flags);
+		uint64_t *offset, uint32_t flags, bool criu_resume);
+void amdgpu_amdkfd_block_mmu_notifications(void *p);
+int amdgpu_amdkfd_criu_resume(void *p);
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *drm_priv,
 		uint64_t *size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index dfa025d694f8..ad8818844526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -597,7 +597,8 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
  *
  * Returns 0 for success, negative errno for errors.
  */
-static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr)
+static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
+			   bool criu_resume)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	struct amdgpu_bo *bo = mem->bo;
@@ -619,6 +620,17 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr)
 		goto out;
 	}
 
+	if (criu_resume) {
+		/*
+		 * During a CRIU restore operation, the userptr buffer objects
+		 * will be validated in the restore_userptr_work worker at a
+		 * later stage when it is scheduled by another ioctl called by
+		 * CRIU master process for the target pid for restore.
+		 */
+		atomic_inc(&mem->invalid);
+		mutex_unlock(&process_info->lock);
+		return 0;
+	}
 	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
 	if (ret) {
 		pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
@@ -982,6 +994,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
+		info->block_mmu_notifications = false;
 		*process_info = info;
 		*ef = dma_fence_get(&info->eviction_fence->base);
 	}
@@ -1139,10 +1152,37 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
 	return avm->pd_phys_addr;
 }
 
+void amdgpu_amdkfd_block_mmu_notifications(void *p)
+{
+	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
+
+	pinfo->block_mmu_notifications = true;
+}
+
+int amdgpu_amdkfd_criu_resume(void *p)
+{
+	int ret = 0;
+	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
+
+	mutex_lock(&pinfo->lock);
+	pr_debug("scheduling work\n");
+	atomic_inc(&pinfo->evicted_bos);
+	if (!pinfo->block_mmu_notifications) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	pinfo->block_mmu_notifications = false;
+	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+
+out_unlock:
+	mutex_unlock(&pinfo->lock);
+	return ret;
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct kgd_dev *kgd, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
-		uint64_t *offset, uint32_t flags)
+		uint64_t *offset, uint32_t flags, bool criu_resume)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
@@ -1247,7 +1287,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
 	if (user_addr) {
-		ret = init_user_pages(*mem, user_addr);
+		pr_debug("creating userptr BO for user_addr = %llu\n", user_addr);
+		ret = init_user_pages(*mem, user_addr, criu_resume);
 		if (ret)
 			goto allocate_init_user_pages_failed;
 	}
@@ -1742,6 +1783,10 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
 	int evicted_bos;
 	int r = 0;
 
+	/* Do not process MMU notifications until stage-4 IOCTL is received */
+	if (process_info->block_mmu_notifications)
+		return 0;
+
 	atomic_inc(&mem->invalid);
 	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
 	if (evicted_bos == 1) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 59b5c4131f48..7ca56ed02694 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1301,7 +1301,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		dev->kgd, args->va_addr, args->size,
 		pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
-		flags);
+		flags, false);
 
 	if (err)
 		goto err_unlock;
@@ -2064,6 +2064,7 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 {
 	uint8_t *objects, *private_data;
 	struct kfd_criu_bo_bucket *bo_buckets;
+	const bool criu_resume = true;
 	int ret = 0, i, j = 0;
 
 	if (args->objects_size != args->num_objects *
@@ -2072,6 +2073,9 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 		return -EINVAL;
 	}
 
+	/* Prevent MMU notifications until stage-4 IOCTL (CRIU_RESUME) is received */
+	amdgpu_amdkfd_block_mmu_notifications(p->kgd_process_info);
+
 	objects = kmalloc(args->objects_size, GFP_KERNEL);
 	if (!objects)
 		return -ENOMEM;
@@ -2150,6 +2154,7 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 			offset = bo_priv->user_addr;
 		}
 
+
 		/* Create the BO */
 		ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(dev->kgd,
 						bo_bucket->addr,
@@ -2157,7 +2162,8 @@ static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restore
 						pdd->drm_priv,
 						(struct kgd_mem **) &mem,
 						&offset,
-						bo_bucket->alloc_flags);
+						bo_bucket->alloc_flags,
+						criu_resume);
 		if (ret) {
 			pr_err("Could not create the BO\n");
 			ret = -ENOMEM;
@@ -2320,9 +2326,35 @@ static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void
 static int kfd_ioctl_criu_resume(struct file *filep,
 				struct kfd_process *p, void *data)
 {
-	pr_debug("Inside %s\n", __func__);
+	struct kfd_ioctl_criu_resume_args *args = data;
+	struct kfd_process *target = NULL;
+	struct pid *pid = NULL;
+	int ret = 0;
 
-	return 0;
+	pr_debug("Inside %s, target pid for criu restore: %d\n", __func__,
+		 args->pid);
+
+	pid = find_get_pid(args->pid);
+	if (!pid) {
+		pr_err("Cannot find pid info for %i\n", args->pid);
+		return -ESRCH;
+	}
+
+	pr_debug("calling kfd_lookup_process_by_pid\n");
+	target = kfd_lookup_process_by_pid(pid);
+	if (!target) {
+		pr_debug("Cannot find process info for %i\n", args->pid);
+		put_pid(pid);
+		return -ESRCH;
+	}
+
+	mutex_lock(&target->mutex);
+	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
+	mutex_unlock(&target->mutex);
+
+	put_pid(pid);
+	kfd_unref_process(target);
+	return ret;
 }
 
 static int kfd_ioctl_criu_process_info(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8c9f2b3ac85d..719982605587 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -931,6 +931,7 @@ void *kfd_process_device_translate_handle(struct kfd_process_device *p,
 					int handle);
 void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 					int handle);
+struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
 
 bool kfd_has_process_device_data(struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bc133c3789d8..bbf21395fb06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -65,7 +65,8 @@ static struct workqueue_struct *kfd_process_wq;
  */
 static struct workqueue_struct *kfd_restore_wq;
 
-static struct kfd_process *find_process(const struct task_struct *thread);
+static struct kfd_process *find_process(const struct task_struct *thread,
+					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
 static struct kfd_process *create_process(const struct task_struct *thread);
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep);
@@ -670,7 +671,8 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	int err;
 
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd, gpu_va, size,
-						 pdd->drm_priv, &mem, NULL, flags);
+						 pdd->drm_priv, &mem, NULL, flags,
+						 false);
 	if (err)
 		goto err_alloc_mem;
 
@@ -773,7 +775,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	mutex_lock(&kfd_processes_mutex);
 
 	/* A prior open of /dev/kfd could have already created the process. */
-	process = find_process(thread);
+	process = find_process(thread, false);
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
@@ -852,7 +854,7 @@ struct kfd_process *kfd_get_process(const struct task_struct *thread)
 	if (thread->group_leader->mm != thread->mm)
 		return ERR_PTR(-EINVAL);
 
-	process = find_process(thread);
+	process = find_process(thread, false);
 	if (!process)
 		return ERR_PTR(-EINVAL);
 
@@ -871,13 +873,16 @@ static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 	return NULL;
 }
 
-static struct kfd_process *find_process(const struct task_struct *thread)
+static struct kfd_process *find_process(const struct task_struct *thread,
+					bool ref)
 {
 	struct kfd_process *p;
 	int idx;
 
 	idx = srcu_read_lock(&kfd_processes_srcu);
 	p = find_process_by_mm(thread->mm);
+	if (p && ref)
+		kref_get(&p->ref);
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 
 	return p;
@@ -1578,6 +1583,27 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 		idr_remove(&pdd->alloc_idr, handle);
 }
 
+/* This increments the process->ref counter. */
+struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid)
+{
+	struct task_struct *task = NULL;
+	struct kfd_process *p    = NULL;
+
+	if (!pid) {
+		task = current;
+		get_task_struct(task);
+	} else {
+		task = get_pid_task(pid, PIDTYPE_PID);
+	}
+
+	if (task) {
+		p = find_process(task, true);
+		put_task_struct(task);
+	}
+
+	return p;
+}
+
 /* This increments the process->ref counter. */
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
 {
-- 
2.17.1

