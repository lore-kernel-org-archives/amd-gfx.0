Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B59C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5559F10EB25;
	Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rB4+/jvg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F0810EB29
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyL46S2aYaIZfk0KuQ2hukJKrburzNF7XKOOAneGTlY2CLf/d82jnXjafFwbpU6OMvPN4CcrXwbAoyUtMfosEDpgmtZnaZ5rllOHUgdOyalmyeP2lx2L2Lc5KBAMjwshhmpbBhYhykbCqnW8Q3BhQadGL/GdnrT71yRXTBGqRqbK7g/kjHpsaFPzFg4wOePRxPuza6IRSj+b3JnX0m2YCbO6baDYIW+ZzZ9rZ8T4WU6gIPgRtIvt0OZhMETyEOmzqDnLYCwt21gPN+igyMEq9HtOlrcDy2+1uG5T6eycmhgW+T//qPVi3Bc9vJtEQP6TsHTnR88ib2p6lieJtgaxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5WkxgWk36W0zo6WDeOV7zumShkmokHLq923DAsT7aM=;
 b=HklFL2417TYFUT2qz9RarUWAddMpkJGjfb3riRz7OjJ+AK7kMBto3OsPrLJHqdSCVKNSef4KEtQfrUTDGX2CBpiloMkPfczOC9TccIIfKNgXS1ll3wth8aREwwHdCsWGlADrPFs6z5hYgjx23qNnPIR2K0QTEDAzy/uAvQgaOGYe0WZKJU4mfHTsADdUGh7tEAQXpgg8jqW2c21Kw7a8+O+AAoYJ4VBWGs0lIYHpEv8Mf9jyko5RIMU3tnDEaY7QCTVn5ij5QYGqUI47r8aVSfVgWnvhD6a0fLIvWlQTWpHzLFsZyxqM2O/UOwfAblxwjZueg6Mw+A7K97mGSouDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5WkxgWk36W0zo6WDeOV7zumShkmokHLq923DAsT7aM=;
 b=rB4+/jvg2TGsWCz6L4ho2fQSsCYPNavtSrXkdcI0VL+CuOP/Rnr+mdWuc1kabzSCOB6oxpIJFN2F342Cvtt2OoptfO7+skaksAMFJI8gx0GjL+ym9poT2d5pEC6Lkf5RRODELkjVqmVkkUiBnfH0BARDT+91z3HYYFbLhI9JnYg=
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 21:06:17 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::d1) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:14 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 6/9] drm/amdkfd: Validate user queue svm memory residency
Date: Thu, 18 Jul 2024 17:05:55 -0400
Message-ID: <20240718210558.26340-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca1be2a-4d7f-411b-c53a-08dca76d770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T4LDTE/JGlg0OwQf0pmiIKx692y1SiBm5Tg6xszb1AkunyMJI4/fdFbmvuAD?=
 =?us-ascii?Q?1Fi5QE/Rh3am5EXSB390zImrRNKV1HBrKsJl7WDTcHqNPHmNesS36UkIU3Kq?=
 =?us-ascii?Q?R+MbJsRJPZjAizwR2aIyMwkigwkCr9csqhbsdB807Ti84tZa82hlKK2lTeMj?=
 =?us-ascii?Q?fPJ/0hhYQG21CwQ9V/zrsfDYs7lx5pe7Bk5ATHHrIyEAKp2/xLswJFaZ0t4O?=
 =?us-ascii?Q?JH2Mx1NLO1gpdjofVsZ/5PLQrOlJrBcSxbMKDtjefNaCl87cJM+CUnkW/Ro4?=
 =?us-ascii?Q?sXl4aNZuP9/7llLe9F5X0FuyAWFMMktDwznMqCcc6BjF8973toNJQW/UfarI?=
 =?us-ascii?Q?ITKMl532RSvg+ES/n8C1Hup6xZW8yKxiNFfXcdcMvk5ePDs0aZl1jnUbbxlP?=
 =?us-ascii?Q?RXMwI+BJHC+dmv5TyOJpdvMPOfbEaRMxCOCqlYBNCTCXTFiuybgn+Ht114GS?=
 =?us-ascii?Q?7zsZJOGVrGGowMpBQgGcfjijFPSoM/b5hEAxOfXKRQXZy2Unj//ATGHIX8f6?=
 =?us-ascii?Q?IiwYm9p2RP6XIpOFzQVIrV0rf4kH7kfQQ4DKvxbdW4jAkoVO6mi+eSJhXH9+?=
 =?us-ascii?Q?+Zqh0s0Ewb6OW7Hu39jYe4ANxDHJ3Wqru4SuGX47Z+QybHo7lMCOGmLQv8dX?=
 =?us-ascii?Q?IrhLU4P/W/kC0yQNF/nG2H8zxWR1UGgu0nRYBgQyHIrLOUV+Ii5iIip8zG2v?=
 =?us-ascii?Q?vUx65bHbTTkZuES2Drp6//7+461eqH0BdrtBkkOa0Mg9Zo4UFILv2CqJbuqO?=
 =?us-ascii?Q?eJYyuyptirm9gavEP80yql021aUDMMKEuFoSFhDaZ42G7vWqye+sD7BUi30P?=
 =?us-ascii?Q?nLjgzpQTJy/5M6JlkwVBAhJPc7yaei5LWQTvu5rNdCgtkJ7U4yAYgFK1DZOx?=
 =?us-ascii?Q?IrLzjDc62MpaRa8ufV9u09IoEBJKODolWrTshgCf1AyRF/002WW8C8MRAixy?=
 =?us-ascii?Q?jllcMBFXDF/25V4kU2UcrmCs5lLY5cIsAPrDuEgZpGBxpPIaHT/vkVVfhLna?=
 =?us-ascii?Q?aZ01/Oc6TH+/+a0uoNvSnlO0zsysfdoffCRtLF3PcBPdey6iX+cofu1Q9P4n?=
 =?us-ascii?Q?TB1zjM2Td7FRYk/emnmHLJEMJ22ZGK8fHT6ZMlVXYDIzauHQnqoUbPJxV5XZ?=
 =?us-ascii?Q?+JTlZGnhJ1QouqOANFcCaCrXLiwDb4akdbLFW6y5MY8++DKOH2pvaYbfPxdk?=
 =?us-ascii?Q?PAbmSG1OZnpQX8qRnG6cTVZuC4nhJWg+WjVV2BS0r3tjDXQAoh0kipkcM6i3?=
 =?us-ascii?Q?ZeCFp0/XkGq+ubq95awkt/MWkXLaDKejcolc1Vqe72QsPhcdFyTH3GMJgO3h?=
 =?us-ascii?Q?8USh0n1+CmF48cMcoFyFccfbwmElnE/xTMSJWWNRMzJddDQqqtdUChItjyWD?=
 =?us-ascii?Q?SHdT/QZ1JYBZVHn+vdnBNAmk1LfqAXmYRl649vYmUR+A4Vn8bt/NG25500Pf?=
 =?us-ascii?Q?dK1DPJLX9qlpfSCAenycx1PW8CxMv6gq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:16.9429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca1be2a-4d7f-411b-c53a-08dca76d770c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

Queue CWSR area maybe registered to GPU as svm memory, create queue to
ensure svm mapped to GPU with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag.

Add queue_refcount to struct svm_range, to track queue CWSR area usage.

Because unmap mmu notifier callback return value is ignored, if
application unmap the CWSR area while queue is active, pr_warn message
in dmesg log. To be safe, evict user queue.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 110 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  12 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   1 +
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 3fd386dcb011..67242ce051b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -24,6 +24,7 @@
 
 #include <linux/slab.h>
 #include "kfd_priv.h"
+#include "kfd_svm.h"
 
 void print_queue_properties(struct queue_properties *q)
 {
@@ -83,6 +84,100 @@ void uninit_queue(struct queue *q)
 	kfree(q);
 }
 
+static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+{
+	struct kfd_process *p = pdd->process;
+	struct list_head update_list;
+	struct svm_range *prange;
+	int ret = -EINVAL;
+
+	INIT_LIST_HEAD(&update_list);
+	addr >>= PAGE_SHIFT;
+	size >>= PAGE_SHIFT;
+
+	mutex_lock(&p->svms.lock);
+
+	/*
+	 * range may split to multiple svm pranges aligned to granularity boundaery.
+	 */
+	while (size) {
+		uint32_t gpuid, gpuidx;
+		int r;
+
+		prange = svm_range_from_addr(&p->svms, addr, NULL);
+		if (!prange)
+			break;
+
+		if (!prange->mapped_to_gpu)
+			break;
+
+		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
+		if (r < 0)
+			break;
+		if (!test_bit(gpuidx, prange->bitmap_access) &&
+		    !test_bit(gpuidx, prange->bitmap_aip))
+			break;
+
+		if (!(prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED))
+			break;
+
+		list_add(&prange->update_list, &update_list);
+
+		if (prange->last - prange->start + 1 >= size) {
+			size = 0;
+			break;
+		}
+
+		size -= prange->last - prange->start + 1;
+		addr += prange->last - prange->start + 1;
+	}
+	if (size) {
+		pr_debug("[0x%llx 0x%llx] not registered\n", addr, addr + size - 1);
+		goto out_unlock;
+	}
+
+	list_for_each_entry(prange, &update_list, update_list)
+		atomic_inc(&prange->queue_refcount);
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&p->svms.lock);
+	return ret;
+}
+
+static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u64 size)
+{
+	struct kfd_process *p = pdd->process;
+	struct svm_range *prange, *pchild;
+	struct interval_tree_node *node;
+	unsigned long last;
+
+	addr >>= PAGE_SHIFT;
+	last = addr + (size >> PAGE_SHIFT) - 1;
+
+	mutex_lock(&p->svms.lock);
+
+	node = interval_tree_iter_first(&p->svms.objects, addr, last);
+	while (node) {
+		struct interval_tree_node *next_node;
+		unsigned long next_start;
+
+		prange = container_of(node, struct svm_range, it_node);
+		next_node = interval_tree_iter_next(node, addr, last);
+		next_start = min(node->last, last) + 1;
+
+		if (atomic_add_unless(&prange->queue_refcount, -1, 0)) {
+			list_for_each_entry(pchild, &prange->child_list, child_list)
+				atomic_add_unless(&pchild->queue_refcount, -1, 0);
+		}
+
+		node = next_node;
+		addr = next_start;
+	}
+
+	mutex_unlock(&p->svms.lock);
+}
+
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size)
 {
@@ -165,8 +260,17 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
 				   &properties->cwsr_bo, 0);
+	if (!err)
+		goto out_unreserve;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
+				       properties->ctx_save_restore_area_size);
 	if (err)
-		goto out_err_unreserve;
+		goto out_err_release;
+
+	return 0;
 
 out_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
@@ -174,6 +278,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 out_err_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
+out_err_release:
 	kfd_queue_release_buffers(pdd, properties);
 	return err;
 }
@@ -195,5 +300,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
 
 	amdgpu_bo_unreserve(vm->root.bo);
+
+	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address,
+				 properties->ctx_save_restore_area_size);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b671aefab01..10b1a1f64198 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1051,6 +1051,7 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return 0;
 }
@@ -1986,6 +1987,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->vram_pages = old->vram_pages;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return new;
 }
@@ -2438,6 +2440,16 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	unsigned long s, l;
 	bool unmap_parent;
 
+	if (atomic_read(&prange->queue_refcount)) {
+		int r;
+
+		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
+			prange->start << PAGE_SHIFT);
+		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
+		if (r)
+			pr_debug("failed %d to quiesce KFD queues\n", r);
+	}
+
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..747325a2ea89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -137,6 +137,7 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				mapped_to_gpu;
+	atomic_t			queue_refcount;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.43.2

