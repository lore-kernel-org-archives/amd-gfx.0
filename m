Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD2C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8147910E37C;
	Mon, 15 Jul 2024 12:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLX475eE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3258410E388
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7h+EtawilqID9eA7cL/uGCkD37YbI63xrj6q1KZ2THdyeSQJa8UwRQnrxLyXgIkBlte32OKIN/7UH8EUyv4LLfGd1Lqqcltlq7hBtWbucD9cK/IZ0AEaB2diPbBbZpzOhsjn4b6bNAwit8plE484peE2vNRGmzmVv1WuqF1/0aGKrQQgEqnjoLShsXzkHGOfLksNKYzsJX6UIXgvZH+RqiFQ5TpsYIi+hRA24dw1bgSHM21yfzqT0RJPOH3LHnMgMHEHSNQEO9KNGo6a2m8GHM+JVs+pJswEv8sJFjwXvCtqD1R7DZYGPRcsJlvxqInf8Ek0FQPNZ8/IXMBGtDB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP1jvhwLBWj0QRavLj+wYSftCj57le5TSVKM4Uv6I2Q=;
 b=T4C5gnJIzM+qrL4VJAhVKnFi16Zovytw9eqt/kM7cgmETLKeN3+qHyN3/YtiSMMFH4vYdCb/qq7eQxhTlDCaCd/oUPjPwpCyOJJ15C/1/LwrRvJrcsLswYeQ1A+ZfKHDbSznR+nBjRwc/wzl3LEipEyRrVqbtv19OnXSrA73qca5zxyJaP1NJuKJgd6D3oMnSwoMjPhdW+x9dhPrBK+zPa38BnRYY2yVqu1dk1j82eXNCJGxDUhfleXJXZLkIq7egbuh8SHJiVys3NTL8Q5Iz94LTfvxKeGhuFs9yMbpcNGNFq2hazYrPkbrLEXCVBeK3u8GHgqM8yCdOWOdijKCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP1jvhwLBWj0QRavLj+wYSftCj57le5TSVKM4Uv6I2Q=;
 b=bLX475eEa5QXjt4NJa4GCQjUvnM78PVXAit2pBzOwvbXfLtG6S3JdwerVeZbuDXDkxbURkBXNB+z3i0QNFsqQY3gVydlMHbymmitke9Q45BDI5LxNahKrhj1+rxqyOZF3ltlzGXECJXqcD7CvoietcYoIXPC+pyHh9A13jhBFVw=
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:36:28 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::20) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
Date: Mon, 15 Jul 2024 08:34:56 -0400
Message-ID: <20240715123502.7013-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e807cb-92ee-4478-c088-08dca4cabf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1mdq6KZpscWz1/3jQ3N3y4Phvrhu6zeSnA7DdBCHoZnS6MwgPLmPEP5jIxTP?=
 =?us-ascii?Q?UTieYGzOuj113GBbfkmjFBjpaA1J5bb6/Z8OUwo6YT2E/MsTA6z3z8l5z8kn?=
 =?us-ascii?Q?2bH4fvCx8d9TGAmPW3EN2aZrpfMxF2RiclpsUxy/y66cABsMkZxDV2SkgTuo?=
 =?us-ascii?Q?vXr4Y+S2QPASUeKKyZNU4ACeutLW4ioYhjMUdz14RWyzsT5Ud86mcPFRkDN3?=
 =?us-ascii?Q?AZCbBSJucDSPLaa0+meYJznpV+wLPrDgEhWph/mrAwtuw2U9v9bRDxwa4cFq?=
 =?us-ascii?Q?UWRIZJKAr+RUXw9bVjVe5099gUMO7z9Mf03lLzTv3KZvIBF3bixvkZyn3F0M?=
 =?us-ascii?Q?53EY76zTPfPoP5P34UxKUhBiJOObFWTgPRY51eIZ7Em9DgiNkXJvCGsW9hP0?=
 =?us-ascii?Q?eabAuIAy6t960EmVkOeNvzQSr5HAkDl9pTlK5xgRCpfuGKxlRIaEx6WaV/Cd?=
 =?us-ascii?Q?qGVjJ4OHzafY0fpKi7XqgGSiEOsr7dRqHdypIGASH3RASqeokVVu3piYs+li?=
 =?us-ascii?Q?iqutsuXWkV0WlDQIxJqjDEtdzAcbSUSk2yR1+F1qHt882sZSIGSDadUhUuEY?=
 =?us-ascii?Q?4bCFW4PzIrUjNqE4u2iblkfUGXK1i9W/8R4Zbl78tVmM+8OTc+26zSNu8b69?=
 =?us-ascii?Q?X4rnV0oW+tS0nOz2L3fOB30/4CP3DBQXVbjzDI+jUtOIwjLp7Nrphu8YpQ0h?=
 =?us-ascii?Q?oAQX6XsdHRzG+hHq0G3EM9ChXfv6WDeftgHrHzcNyuS8hhG2m0zyJoP9u9it?=
 =?us-ascii?Q?lRmCiOeEXQTwrlTJa/CznAUo2nZyIp/H1sl94BjVJjNL08NnBFSJ3m11NhDR?=
 =?us-ascii?Q?icuFG6+EOQbrEEVVwYQqfIGiE523FZXb0KbwHz+N2SVk/BLDzaYNRNQCz7yz?=
 =?us-ascii?Q?M6Pre7ZI5gSujz6GSd32+YKH9ERqIxtOFEj4j8TJkXdXsgeSgeX4ad9F8aKT?=
 =?us-ascii?Q?KBJJqT5+4gnd+XZmeCCRRJxFg1jWLJ8lHFl/EybuN7ky6nPQAtdmjQ95mxL/?=
 =?us-ascii?Q?xlOy+Y10w9NZKLb5ib7+vt5nWl2Eceg9PVZemkx0lpgVfjlw1/SM4ybUJwAo?=
 =?us-ascii?Q?14MTTpjSxRI4rQWEGIHE7Q0qRH3QbfK22u6zierlo3eVB+H9Lm/DbusiwTbX?=
 =?us-ascii?Q?2spkY/SKtgVEYYNzs/NW5xM/tlMxVmBJgUptVtQWytLIlrH7DOWiLWzktigI?=
 =?us-ascii?Q?ZfVAev+yuWi6W94jMRLAFXDlGKF+bg0kd8WOGWLdmVg7ec08cBVRCfLDW5v0?=
 =?us-ascii?Q?Zk7C+FJZNkefFXi7t4/LlMJ+Xhn6fSXmAHrsrJ3RCHonySYQdl7YBYrlHEvN?=
 =?us-ascii?Q?P9/hY2ud+kbsCGiqbBDkAa+yABJVt74wMXx3bCT6Gorq1mix+AhbuU6DuQBI?=
 =?us-ascii?Q?a8e06lvwtmvKbzVMciBf5fiS+5U7qsfPYKk58oFLNXPh8z10VFJdckZb3Ozd?=
 =?us-ascii?Q?iKabdVCsL1XE66TUhAK1OazfCDPHv8mH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:28.2186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e807cb-92ee-4478-c088-08dca4cabf89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

Add helper function kfd_queue_acquire_buffers to get queue wptr_bo
reference from queue write_ptr if it is mapped to the KFD node with
expected size.

Move wptr_bo to structure queue_properties from struct queue as queue is
allocated after queue buffers are validated, then we can remove wptr_bo
parameter from pqm_create_queue.

Because amdgpu_bo_unref clear the pointer, queue_properties wptr_bo is
used to acquire and release wptr_bo for validation, add wptr_bo_gart to
queue_propertes, to hold wptr_bo reference for GART mapping and
umapping.

Move MES wptr_bo GART mapping to init_user_queue, the same location with
queue ctx_bo GART mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 56 +++---------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 14 +++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 45 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 57 +++++++++++++++++++
 7 files changed, 116 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 6e591280774b..4ed49265c764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -322,7 +322,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence __rcu **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 199e387d35f4..0ab37e7aec26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2226,11 +2226,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 /**
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
  * @bo: Buffer object to be mapped
+ * @bo_gart: Return bo reference
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
 {
 	int ret;
 
@@ -2257,7 +2258,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 
 	amdgpu_bo_unreserve(bo);
 
-	bo = amdgpu_bo_ref(bo);
+	*bo_gart = amdgpu_bo_ref(bo);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 823f245dc7d0..202f24ee4bd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -247,8 +247,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 	q_properties->priority = args->queue_priority;
 	q_properties->queue_address = args->ring_base_address;
 	q_properties->queue_size = args->ring_size;
-	q_properties->read_ptr = (uint32_t *) args->read_pointer_address;
-	q_properties->write_ptr = (uint32_t *) args->write_pointer_address;
+	q_properties->read_ptr = (void __user *)args->read_pointer_address;
+	q_properties->write_ptr = (void __user *)args->write_pointer_address;
 	q_properties->eop_ring_buffer_address = args->eop_buffer_address;
 	q_properties->eop_ring_buffer_size = args->eop_buffer_size;
 	q_properties->ctx_save_restore_area_address =
@@ -306,7 +306,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process = 0;
-	struct amdgpu_bo *wptr_bo = NULL;
 
 	memset(&q_properties, 0, sizeof(struct queue_properties));
 
@@ -342,53 +341,17 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		}
 	}
 
-	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
-	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
-	 */
-	if (dev->kfd->shared_resources.enable_mes &&
-			((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
-			>> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
-		struct amdgpu_bo_va_mapping *wptr_mapping;
-		struct amdgpu_vm *wptr_vm;
-
-		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
-		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
-		if (err)
-			goto err_wptr_map_gart;
-
-		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
-				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
-		amdgpu_bo_unreserve(wptr_vm->root.bo);
-		if (!wptr_mapping) {
-			pr_err("Failed to lookup wptr bo\n");
-			err = -EINVAL;
-			goto err_wptr_map_gart;
-		}
-
-		wptr_bo = wptr_mapping->bo_va->base.bo;
-		if (wptr_bo->tbo.base.size > PAGE_SIZE) {
-			pr_err("Requested GART mapping for wptr bo larger than one page\n");
-			err = -EINVAL;
-			goto err_wptr_map_gart;
-		}
-		if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
-			pr_err("Queue memory allocated to wrong device\n");
-			err = -EINVAL;
-			goto err_wptr_map_gart;
-		}
-
-		err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
-		if (err) {
-			pr_err("Failed to map wptr bo to GART\n");
-			goto err_wptr_map_gart;
-		}
+	err = kfd_queue_acquire_buffers(pdd, &q_properties);
+	if (err) {
+		pr_debug("failed to acquire user queue buffers\n");
+		goto err_acquire_queue_buf;
 	}
 
 	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
 			NULL, NULL, NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
@@ -422,9 +385,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	return 0;
 
 err_create_queue:
-	if (wptr_bo)
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
-err_wptr_map_gart:
+	kfd_queue_release_buffers(pdd, &q_properties);
+err_acquire_queue_buf:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 420444eb8e98..fdc76c24b2e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -208,10 +208,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.mqd_addr = q->gart_mqd_addr;
 	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
 
-	if (q->wptr_bo) {
-		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
-		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
-	}
+	wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
+	queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->properties.wptr_bo) + wptr_addr_off;
 
 	queue_input.is_kfd_process = 1;
 	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b3ec92981e8..c98ff548313c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -494,8 +494,8 @@ struct queue_properties {
 	uint64_t  queue_size;
 	uint32_t priority;
 	uint32_t queue_percent;
-	uint32_t *read_ptr;
-	uint32_t *write_ptr;
+	void __user *read_ptr;
+	void __user *write_ptr;
 	void __iomem *doorbell_ptr;
 	uint32_t doorbell_off;
 	bool is_interop;
@@ -522,6 +522,9 @@ struct queue_properties {
 	uint64_t tba_addr;
 	uint64_t tma_addr;
 	uint64_t exception_status;
+
+	struct amdgpu_bo *wptr_bo_gart;
+	struct amdgpu_bo *wptr_bo;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
@@ -603,8 +606,6 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
-
-	struct amdgpu_bo *wptr_bo;
 };
 
 enum KFD_MQD_TYPE {
@@ -1284,6 +1285,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties);
 void uninit_queue(struct queue *q);
 void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
+int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
+			 u64 expected_size);
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
@@ -1320,7 +1325,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
-			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 36f0460cbffe..8552400d6d47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -205,18 +205,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 
 	if (dev->kfd->shared_resources.enable_mes) {
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
-		if (pqn->q->wptr_bo)
-			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->properties.wptr_bo_gart);
 	}
 }
 
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
+	struct kfd_process_device *pdd;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q)
+		if (pqn->q) {
+			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
+			kfd_queue_release_buffers(pdd, &pqn->q->properties);
 			pqm_clean_queue_resource(pqm, pqn);
+		}
 
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
@@ -231,8 +234,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_node *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, struct amdgpu_bo *wptr_bo,
-				unsigned int qid)
+				struct file *f, unsigned int qid)
 {
 	int retval;
 
@@ -263,12 +265,32 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
-		(*q)->wptr_bo = wptr_bo;
+
+		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
+		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
+		 */
+		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
+		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
+			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
+				pr_err("Queue memory allocated to wrong device\n");
+				retval = -EINVAL;
+				goto free_gang_ctx_bo;
+			}
+
+			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
+								  &(*q)->properties.wptr_bo_gart);
+			if (retval) {
+				pr_err("Failed to map wptr bo to GART\n");
+				goto free_gang_ctx_bo;
+			}
+		}
 	}
 
 	pr_debug("PQM After init queue");
 	return 0;
 
+free_gang_ctx_bo:
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
 	*q = NULL;
@@ -280,7 +302,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
-			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -351,7 +372,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -372,7 +393,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
 
-		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -490,6 +511,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
+		retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
+		if (retval)
+			goto err_destroy_queue;
+
 		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
@@ -971,7 +996,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
+	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 0f6992b1895c..b4529ec298a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -82,3 +82,60 @@ void uninit_queue(struct queue *q)
 {
 	kfree(q);
 }
+
+int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
+			 u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	u64 size;
+
+	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+
+	if (user_addr != mapping->start || user_addr + size - 1 != mapping->last) {
+		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
+			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
+			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
+		goto out_err;
+	}
+
+	*pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
+	return 0;
+
+out_err:
+	*pbo = NULL;
+	return -EINVAL;
+}
+
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+{
+	struct amdgpu_vm *vm;
+	int err;
+
+	vm = drm_priv_to_vm(pdd->drm_priv);
+	err = amdgpu_bo_reserve(vm->root.bo, false);
+	if (err)
+		return err;
+
+	err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
+	if (err)
+		goto out_unreserve;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return err;
+}
+
+int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+{
+	amdgpu_bo_unref(&properties->wptr_bo);
+	return 0;
+}
-- 
2.43.2

