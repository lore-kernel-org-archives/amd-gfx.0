Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DFAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 15:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF4D10E8C4;
	Mon, 13 Jun 2022 15:20:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9238810E8A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 15:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbRFAlo3EXVlEdo+TXgyIgBStlOEy0EAccYa2iTWP7igzD9o6r6mvqh+hOm2tzTJxSkIRJXufTlPmCq0NjhTY8NByk2xUXtX3stNT3j7f0htEewZlrDeGVlAoCIXSuNc3ko5WgcVldtwxXTCB9gjx0BZMcnXDNSQTtVmhl6DAAyDYiswpu74Zxvx5BXlkDDqf2OK3btfEuCwynN/ECUbwZ11sEF69bHeFfv1ojQyHNmij+OSpvsSdsWpDnP8TOQ3bFnXHSec86JaFqSwtR6cxmsnVjA0cEfanJKOspqnf9Nmy7r/f7iSlsz37L55fYos4fsSHB8zoZ04gjNsGhfFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWkw2Y4eubtPjFyd+Amaeu7MfK6glpkVZbEUwdB0XTg=;
 b=hcgWw0XTo/q67kZW+hXKF5kbIBhLJ2wuP7S1E/HSLBCEZqXG/aOGGDbwaXBE+uK2KJCUa2gngLFsfVQoZTYMPFpTF7ZPXJbTsBNebuGxmk1tdjfhNSfXpWCpqiYutLIg7+vfGnpICB92BiW5dyulmGhIuFMxioSOmbNXunoAbu4QluXaqzjwZXWq1FmRx6+ECd3OuV+lgLOHTJlPNqC49LvhKHZ1TgVnjn2JDfe9l8H2FgvqSVZn+Q9cd/8HwRpDaSolkCZAzb6Vp5xDd0yczuVvKMAdaJt+9XuOsarTZtioT2MyjSgsOEHok3vuOZP/G4puLQ7H85xsrb6loTufmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWkw2Y4eubtPjFyd+Amaeu7MfK6glpkVZbEUwdB0XTg=;
 b=LqMnQuDkXzR4+xAOQALZzZcE8npsxFPix1rhRO6u6WrlZSprggB1s3ghigX7uXBKmAT/QsmoT/nMX0yDuvmw0DbTbl+H7dary8Q4bQER218H5utWZJupSuQEHDIGGvfW+gCtnhmico0VSvl8DIXKaXg2mOpnUxUYFC4ibYAnVh8=
Received: from MWHPR11CA0002.namprd11.prod.outlook.com (2603:10b6:301:1::12)
 by BY5PR12MB4018.namprd12.prod.outlook.com (2603:10b6:a03:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 15:20:17 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::f0) by MWHPR11CA0002.outlook.office365.com
 (2603:10b6:301:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 15:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.13 via Frontend Transport; Mon, 13 Jun 2022 15:20:17 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:20:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Date: Mon, 13 Jun 2022 11:20:00 -0400
Message-ID: <20220613152001.3045911-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613152001.3045911-1-Graham.Sider@amd.com>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af334e45-0bb3-4a98-bdb6-08da4d503915
X-MS-TrafficTypeDiagnostic: BY5PR12MB4018:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40182DC8FB0EB803137183958AAB9@BY5PR12MB4018.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVyjyvm0b6dDwZogxVgBLOftMdad6LdVPk42AL1Cj2L07vL/ftxwLJbaWWgQqAJzPJrpLcBU6OLGZBUzcZWiXO26U9+5g8tfrZHR7sOpym6xv9QaF9zM4ZON/QGw/RBt1Y/U3HSeXETQQNBecVglUP7FmNzcyXKiUGKaQElSe4m47dYGgb9XEygeVTmHACIfiaoqqG4WmWay3g0YtcPlO9BmIEMSZdlMarcIUBweTB29lXCiZrGuiNIsrzwkzn8nOfnZkgAbk4rmVdAF0PAJ4zZervtSuQtwLDthSszdu5nggX0cxKaQRYZuBqqYfLhRlxWBkbpE9QeVFX53j4a/L+3sGUc/kd4PAj2SjEaV+SsljS+CBzuGE25d6KptYhXYxEDx94YxEFvdF+p8/XGu0yKAp6hVFQclxHmX3q+Knb7F4gIHCuebWA2ay9kkJXfPtVtvw64vvLSd8Ht0CVbLAKdq6N0f+VN1NnBLYvSEiiVpfYxLzuKzyPuPiZglRodObRBHE/GQ3RsP+mZVFZtUwlLiD7zy0nJU9amep2kaoRLs3jSWpnhmDf3C5HImBUIppgDH9m1iEQz8AtAs6FFGmkInxAXqZDlLa+JeYWfM2Jz/cPV+BIt3j7DE7sbQlbDMwNLXWFtHS/nJ4PKLiZfARMj+AVBx8ftZPUrfxKG2qnF53/MyHvkCc8dnFFxMioBxKSV1WhKXjWEjsdschW8S5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(336012)(316002)(2616005)(36756003)(186003)(6666004)(81166007)(86362001)(356005)(2906002)(82310400005)(1076003)(6916009)(54906003)(7696005)(40460700003)(16526019)(426003)(47076005)(4326008)(83380400001)(508600001)(5660300002)(36860700001)(70206006)(8676002)(70586007)(8936002)(26005)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 15:20:17.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af334e45-0bb3-4a98-bdb6-08da4d503915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4018
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

v2:
- Update MES_VERSION check from 2 to 3.
v3:
- Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
- Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
- Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
- Cleanup/fix create_queue wptr_bo error handling

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 49 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 37 +++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 17 +++++--
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
index efab923056f4..888d08128a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
+/**
+ * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
+ * @adev: Device to which allocated BO belongs
+ * @bo: Buffer object to be mapped
+ *
+ * Before return, bo reference count is incremented. To release the reference and unpin/
+ * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
+ */
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
+	bo = amdgpu_bo_ref(bo);
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
index e9766e165c38..1789ed8b79f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process = 0;
+	struct amdgpu_bo *wptr_bo = NULL;
 
 	memset(&q_properties, 0, sizeof(struct queue_properties));
 
@@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
+	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
+	 */
+	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 3) {
+		struct amdgpu_bo_va_mapping *wptr_mapping;
+		struct amdgpu_vm *wptr_vm;
+
+		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
+		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+		if (err)
+			goto err_wptr_map_gart;
+
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
+				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
+		amdgpu_bo_unreserve(wptr_vm->root.bo);
+		if (!wptr_mapping) {
+			pr_err("Failed to lookup wptr bo\n");
+			err = -EINVAL;
+			goto err_wptr_map_gart;
+		}
+
+		wptr_bo = wptr_mapping->bo_va->base.bo;
+		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
+		if (err) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto err_wptr_map_gart;
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
 
@@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	return 0;
 
 err_create_queue:
+	if (wptr_bo)
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+err_wptr_map_gart:
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
index f99e09dc43ea..3a17c1ebc527 100644
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
 
@@ -221,6 +222,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+		(*q)->wptr_bo = wptr_bo;
 	}
 
 	pr_debug("PQM After init queue");
@@ -237,6 +239,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -299,7 +302,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -320,7 +323,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
 
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -457,9 +460,13 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
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
 
@@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
+	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
-- 
2.25.1

