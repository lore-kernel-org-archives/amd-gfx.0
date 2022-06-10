Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 17:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4455710E478;
	Fri, 10 Jun 2022 17:13:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF0A10E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 17:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEq4uAEPdDe+WA5Zk5IqV3Br90HlYp/bsEVFP49kgy0TNdR5WVP2CNvh+5/wQtM8s++IRmxJW9y6VBJIH9x2qyBGb7xWqAdaDvQewhAaILd4gaFor1FMNZ8a6JkgMd9WRitYZqXBCFH0HMA6dudw1XP8drwjisCz5vGJHKCQpKiRnl4eSlgeuiSKfAMVbow9VOBC0fi7ZpMhgOenEnS5AXw2kEN/xtC+tZTsIFxXxsPWLUw1wifalZPgZJrs38dafNPzAoaSbJrUPyWVEKjKc9UnJDwyigs+t8nBGTzKFfmbY/WyOuCShw/h/dj/MbAyaH475gdasuw+6yUO/REQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkfCpJVzx8/vNcyVyKEgWylwJlC0y4I3iuRK3ORJBuA=;
 b=Zu3e8FgDJ1fUKy6fHxZ6iZq/KB7obTXlWih67WUQT9+sjvwhv0cALcQUjnlu6PfO+059lecsn8nSkgSvSNUSjha79EHkSXXlt0HKGJ6ieLgQYcWU5Bqdwc/Ibyqh1wfZEJoWUQHSGZy77wnuIDrb9r3XoSXDS3LWQxELdlo8cSzbMvStIZ9maCPGPBEIzD/Y1VEves2Yzs16yWoKafD03CvVfN4P8y8BwJn4Q/SgaRT99llaDsphUysNE2WZ+JJp33aq9RGYdidbDqfLaOWeGjk+IfkxIIyA+XQqG3Ja8PUZx4j85AsjE2n8kk9eKX224yd/yFezz81i1tPqEwkbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkfCpJVzx8/vNcyVyKEgWylwJlC0y4I3iuRK3ORJBuA=;
 b=j+L43yg9G3uD4DDLukSyIJ4HVnqjBt4uPqyhWDjkDyYZsVgJ0ReUbD7kGkkKOcHSs7/wvOb37bxvzffmm4jesbo6H9Z/6wsi6J25+4eviWcqZm1dP9cr0PD9vB/MXsQDSJmdtWebXClFHnhXQ2EfZMdlQ3csOrE/QMmTySu2JvQ=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by MWHPR12MB1472.namprd12.prod.outlook.com (2603:10b6:301:11::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 17:13:32 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::9a) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 17:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 17:13:31 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 12:13:30 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Date: Fri, 10 Jun 2022 13:13:15 -0400
Message-ID: <20220610171316.2668611-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610171316.2668611-1-Graham.Sider@amd.com>
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a00300e-63d9-4bde-5f93-08da4b048b92
X-MS-TrafficTypeDiagnostic: MWHPR12MB1472:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14725166136F5E87007C12AB8AA69@MWHPR12MB1472.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NC+S7KxPvNFHHI6NaxvW+oXXQkzxRvs3LODWCDLHZPBxGjZkXpFv715Edwq/nLJRqUtXO+tdqEXBHYNnhjkqGLzj143aniBgC3eOGdspjP7BA/rqyikWJYpgkVEeydg6U1D9fQWjHwVSgOTmyVO23w7HVLqpeKLo7VyW0ccz21Gg+Vrev94OQte92rTJZsXfh/C0+r2r1H7jMLKHhHMHjaN597DMmMrQo3CV4Apcbr5KZ0oXvp4mFiZj/TwJeBqdrwsqTmGyv0K8izlN5rSC7m7xRrGWSLJhVzSZwR9TktmiKLEeL/CmOtOpzv9c3megT9/UO9BIKCuRQGWCa3948QFQ6MGJ/DdTEO6CKONF6SRvf8kOQeDKdGHhqi3NygNYQIEu7akG94Ny8wuLXwa2nMgerODtH5w00t7w4IJtSoPls1aQlp5fk4pybkWw31NnT/YLxPDPZnfPQ9IovNrjHBzBpVLAuOpd6XglieeBdmSQO8/6zBUwfbZeTyn/hEp3SeMtG7cBfRMChszoh/2jzUmCtgcLuERWjYFfr/1qsFHL0Vnoqu3Y9iAAwZqH5YvQ7bJuAWAfoC5xey7mAEjx7K6jtFzGeEfk3zMqgdhH2O8Nz9o+XN0CRo73oxohlzINYnqRCQKPCjNSAvi76ZdwFIRHJQsBotdcjlyAVD/UOnY4IUyuqh8yqWCnoFbrSwFT2z8omDtvNTFlgFjQo1hUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(8676002)(47076005)(426003)(4326008)(26005)(40460700003)(336012)(70206006)(508600001)(6666004)(83380400001)(8936002)(81166007)(5660300002)(356005)(36860700001)(1076003)(54906003)(2906002)(6916009)(2616005)(7696005)(36756003)(82310400005)(86362001)(16526019)(186003)(316002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 17:13:31.8049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a00300e-63d9-4bde-5f93-08da4b048b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1472
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
GART for usermode queues in order to support oversubscription. In the
case that work is submitted to an unmapped queue, MES must have a GART
wptr address to determine whether the queue should be mapped.

This change is accompanied with changes in MES and is applicable for
MES_VERSION >= 3.

v2: Update MES_VERSION check from 2 to 3.

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
index e9766e165c38..58d5ebed1b32 100644
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
+	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 3) {
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

