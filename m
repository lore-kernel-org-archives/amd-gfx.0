Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A98C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 22:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323FF10FE3E;
	Tue,  7 Jun 2022 22:50:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9905A10FE3D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 22:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/mOFA5BdDxxaWGkbCQEp4tQQUl4FoOatlcA5uwfC3PdQGgNpNyL6Cke7wHQi1FAAnCYjXWTLF0ZTxbsOi+7SxUr38SBRoCi716tnQOdUDyoMQdXZbAR8ifADjsahnhzunpoNxwU44SZEIjydCpttXg4+pLt5dccrX+JtKeNXK2E1AcCInbgdl//rxD3U2zrH1tB6vHXRcHx0BVfP7xn+Cs5N7sceA/GYTB7vErihEWzQQafzuIntNJZ1PHASAHC8LFOQ4px9+0ysNOCJBVotKvyrbtF6ph9LVxRczKgoL7pAZSM1vzsei2VwU7kdKJvIytXEunWq62PstV/gkPkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGPJ00JpkqNc3ICvQ5iN5eKKjWDd9cvGNusdnBQv5qs=;
 b=CYduBbTjtLc9TnbaxYow6GRLpBc38AQsvCi7JcTaW812hG6er6XQFi68MGHDXElIt8wIpxOxXzw3pw8NyHGc2+9RP4I8VBj7Q8OMZoB71LX/XjQDabZwg5tiIZO/ktuviem6ru06KSnfKs2Vm1iJmsoUKyitv4SVglW/GinyotV3pF+0X9/GYpezVmST/4hRst5S/ly98ilGTsS96DtQDKDucZD7zgDhg2xaqZcR6OP1RR0AKnWo0mZ5VCpVs2peqIYWxuWv31MTzRx9VaxiC9ndqQwEJ6CHpzlGHGMut++Vm3vGoHKsMfcCisKvOKoSVJbx2/rYP/UTelIFvWCucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGPJ00JpkqNc3ICvQ5iN5eKKjWDd9cvGNusdnBQv5qs=;
 b=PueSEiIuqDQs1qumC7gZ/wRA0PGTLMP1CSoeZcoJwmuEHdlrtpbiXofwrKNzHhu65HEykd7FIS+VlRQ+aFZPyjzgIYBub3Lk2ARNFm1RWHPPFTYAE3hfRNGOYxK3Yh6T0+LBw+RJRpMZWm8Nd5bCuRLBlP1mlrCnqoGezJ/nrBM=
Received: from MWHPR03CA0019.namprd03.prod.outlook.com (2603:10b6:300:117::29)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 22:50:22 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::35) by MWHPR03CA0019.outlook.office365.com
 (2603:10b6:300:117::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 22:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 22:50:21 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 17:50:19 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: Enable GFX11 usermode queue oversubscription
Date: Tue, 7 Jun 2022 18:50:06 -0400
Message-ID: <20220607225007.1372343-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607225007.1372343-1-Graham.Sider@amd.com>
References: <20220607225007.1372343-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfe45aa0-7b13-4d18-87f1-08da48d81a18
X-MS-TrafficTypeDiagnostic: LV2PR12MB5894:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB589461610A56D62A20276A848AA59@LV2PR12MB5894.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bH3RSCVp+V2MSk6kpoHP6NdSACcuv5Z4Vh9Gn8O6b8YDIcCmt4GmPw3siJ+T45Vdba4DpfcK0RVTbupCTLVF72o1luSxZ5PkCtvZdE/8+OOyzAGY4FOsQBYirzJl53Y1+s41zmGBJBuY807dtkLv32dh3tAtmwKcO1/dbXI2qdmx5cy6yG/1EHfwddpjWPQe1uHWX69KlgtKNziBupIfnxFLnbVE4oMGTiaud792WlNnM35JNccqbw8K1T70HWT6gBeCZFdf0hMdJpv510Q1QUTHIiswjNPbf5D3r5lVtNyDEo5pf7Z0CD6mZbQu/F9cQGmsyDOfrAurUOdgNJnaKIEvpTQPlGzO8Ac5OsiXGthIm2BXdFZ7Y8FAVAwvvdxPUni0qp0SqSpEky1E2rWvuXG12N8ThfPxeDy6qXr5RmVrzEAfxAVcVMTbmTrOltFPTHF9NqIiUa1T4jr1VmNw9r+8e2MifnxASwNiTMxV0iFRL9p036GeCQersyLe4mjCeNhzE8VzWTmsT3mhFYa+nldNh4+6K0n+eiHE/uEEtBkIs0OJSsE8VkjkcOIdaoWEhsgAjuQ0pyzZo1xoVnwZt52tzCehVzGoWJ0gdC3M7DjbBkI+W4J7YWt8aCu4XWuAE2Oy5MkcN07Mp/7MheMnYUSk9jt19X9+YdZv7LSBhJb4Qt2xaQbb/f3KGX+5yNHNBE2HNY5xt5eLQhY9DPgrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(30864003)(70586007)(36756003)(36860700001)(2906002)(7696005)(26005)(82310400005)(6666004)(508600001)(426003)(5660300002)(54906003)(6916009)(336012)(47076005)(2616005)(1076003)(186003)(16526019)(8676002)(4326008)(70206006)(40460700003)(81166007)(316002)(83380400001)(356005)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:50:21.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe45aa0-7b13-4d18-87f1-08da48d81a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
GART for usermode queues in order to support oversubscription. In the
case that work is submitted to an unmapped queue, MES must have a GART
wptr address to determine whether the queue should be mapped.

This change is accompanied with changes in MES and is applicable for
MES_VERSION >= 2.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 19 +++++---
 7 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 429b16ba10bf..dba26d1e3be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index efab923056f4..2d452655eb04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2030,6 +2030,45 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		pr_err("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		pr_err("Failed to pin bo. ret %d\n", ret);
+		goto err_pin_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		pr_err("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_amdkfd_remove_eviction_fence(
+		bo, bo->kfd_bo->process_info->eviction_fence);
+	list_del_init(&bo->kfd_bo->validate_list.head);
+
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+	return ret;
+}
+
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e9766e165c38..b2c7b8f48d25 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -290,6 +290,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process = 0;
 
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct interval_tree_node *wptr_node;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_bo *wptr_bo = NULL;
+
 	memset(&q_properties, 0, sizeof(struct queue_properties));
 
 	pr_debug("Creating queue ioctl\n");
@@ -316,12 +321,44 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	/* Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
+	 * GART for usermode queues in order to support oversubscription. In the
+	 * case that work is submitted to an unmapped queue, MES must have a GART
+	 * wptr address to determine whether the queue should be mapped.
+	 */
+	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 2) {
+		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
+		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+		if (err)
+			goto err_wptr_bo_reserve;
+
+		wptr_node = interval_tree_iter_first(&wptr_vm->va,
+				args->write_pointer_address >> PAGE_SHIFT,
+				args->write_pointer_address >> PAGE_SHIFT);
+		if (!wptr_node) {
+			pr_err("Failed to lookup wptr bo\n");
+			err = -EINVAL;
+			goto err_wptr_bo_lookup;
+		}
+
+		wptr_mapping = container_of((struct rb_node *)wptr_node, struct amdgpu_bo_va_mapping, rb);
+		wptr_bo = wptr_mapping->bo_va->base.bo;
+
+		amdgpu_bo_unreserve(wptr_vm->root.bo);
+
+		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
+		if (err) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto err_wptr_bo_gart_map;
+		}
+	}
+
 	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
-			&doorbell_offset_in_process);
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
+			NULL, NULL, NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -353,7 +390,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev, queue_id, false, NULL, 0);
 	return 0;
 
+err_wptr_bo_lookup:
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
 err_create_queue:
+err_wptr_bo_gart_map:
+err_wptr_bo_reserve:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b39d89c52887..d8de2fbdfc7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -208,6 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
 	int r, queue_type;
+	uint64_t wptr_addr_off;
 
 	if (dqm->is_hws_hang)
 		return -EIO;
@@ -227,7 +228,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.mqd_addr = q->gart_mqd_addr;
-	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
+
+	if (q->wptr_bo) {
+		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
+		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
+	} else
+		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
+
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index f1654b4da856..35e74bdd81da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
 	m->sdmax_rlcx_doorbell_offset =
 		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a5d3963537d7..dcddee0d6f06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -639,6 +639,8 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+
+	struct amdgpu_bo *wptr_bo;
 };
 
 enum KFD_MQD_TYPE {
@@ -1404,6 +1406,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index f99e09dc43ea..ede1462a55c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_dev *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, unsigned int qid)
+				struct file *f, struct amdgpu_bo *wptr_bo,
+				unsigned int qid)
 {
 	int retval;
 
@@ -221,6 +222,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+
+		if (wptr_bo)
+			(*q)->wptr_bo = amdgpu_bo_ref(wptr_bo);
 	}
 
 	pr_debug("PQM After init queue");
@@ -237,6 +241,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -299,7 +304,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -320,7 +325,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
 
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -457,9 +462,13 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pdd->qpd.num_gws = 0;
 		}
 
-		if (dev->shared_resources.enable_mes)
+		if (dev->shared_resources.enable_mes) {
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
 						   pqn->q->gang_ctx_bo);
+			if (pqn->q->wptr_bo)
+				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+
+		}
 		uninit_queue(pqn->q);
 	}
 
@@ -900,7 +909,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
+	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
-- 
2.25.1

