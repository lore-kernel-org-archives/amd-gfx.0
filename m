Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A5C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFA510E392;
	Mon, 15 Jul 2024 12:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6pao6LH";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC19A10E38E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w75Mv+HKlpBLHAs3H4ecoCxlj9Ww+64mlXajmOhIAFu/ZRpqRasQM4Hu591SgQ7T59YMux1jOMUxAUW9UVIWpdtZRajCpQTlJgfLePhZdEtVw9te9+Jlf3PhYNbei7KGCD64FLCxYnrdXJFhkF2gei2mZIGDHf5AiTp1gKQP5UVIEyQntj0dkP4DH+WV2TwWqL8WU/54TNPu7yoBET1r/qEC0suXK/KjO00GrvJupKQnzo5UuULSMV1xlhUWPyuXNf7VoVEGuZOtsZEZWOILBJmkUx+npSheYf/vmP3F2hO4cJ84QEkt6wCUDd6XfhaaTMKH8jRGgqeLcr1NxU3veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PaA8odt/sSytEDeGBJ0/W1q3zDfe52LVzm3G7ghZ2k=;
 b=hf+nrzzuRUtp7AX+n5FlcQLjZdGP+azXsNDdirxxOyuaFlhE7Ha0k27g97X/VuWmSVNA9/fVp9UA/lr965E99MC65RgVcm3WCq1DwJkymj0GonavnW4zZ3Xoa3abZ0BHbkfQfeu/D4Xt6JYF87tTzyhGSqk5hsNz96tWx0sMeubVbIogPIpm6Y9BHgKlBpL1kvD+snrKqn8TK6ABfSS4ZhLwaNjMVpACxPdf1y6RQemYIGyfmd2hV/E4IlPb3aT5YEjMt1rmpUmrnONijgH/V+D541pXRpFdLYsPLkt9ZXeLwCk6CqMP5MsogwYEtozkSjNaAvhAugRfEQ6zZKZtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PaA8odt/sSytEDeGBJ0/W1q3zDfe52LVzm3G7ghZ2k=;
 b=D6pao6LHT4h8MFjPQI9gGx2nHUAnMVor9TbuLdzX/43Qfi98kB9lYselZFVrI72BdW9yyQOUuhoTs4bvCDFKMYXjeH29KV2aQ5qyzR8nQIsbJy8j7NGmyaAiUUOZM5WxFw0YQQ3ePCYs5m2Y8nPxQmrcVMxtwZMjSBIOv9Zf7+o=
Received: from BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 12:36:30 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::37) by BL1PR13CA0328.outlook.office365.com
 (2603:10b6:208:2c1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 6/9] drm/amdkfd: Validate user queue svm memory residency
Date: Mon, 15 Jul 2024 08:34:59 -0400
Message-ID: <20240715123502.7013-7-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d69c5f-32c9-4e6f-edbe-08dca4cac0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XCyovAQcDVI76VFWGHmweaBFM1Vwnl/i3Hwa4byBC/3k2eB0iAyWgBw++iXJ?=
 =?us-ascii?Q?cctNl3rcxI7pVV/HBstj33V9OzALTnBirZhZrpak6LLA02v63jEHyHiqEP0T?=
 =?us-ascii?Q?KStKKKwgEZ9GDn5Oy5Cr9MssOb/MFm3JvADyFUSHLo0T4nGxPixp9qtgeyPi?=
 =?us-ascii?Q?VoVhIJivzI5U4i5Wse8v2iyMW9MfbMoMJ9sgrjSVNtqe1Srrakchy+8NOzXY?=
 =?us-ascii?Q?xt9lWOKHcKo925DMgrEfpd/9SKolb0cLS/4r19BsSxaF+Xj7Bbi+05WEryUJ?=
 =?us-ascii?Q?Hi7oDWMIkdmc4U/5GVwVLFLiajglo+dho2SHWXK0rQgcgzbrqDcCExLR41vk?=
 =?us-ascii?Q?i2srr5H3g170ipXlHqynQImeSC+rievPRx3uGo2vDOUwpsZMeJl/PsZlkThh?=
 =?us-ascii?Q?1ctq1C0Dv3jjuiNI1nz8fjqrFCafYa51myDIVYf0kKT11AiAStnXMED0L7c6?=
 =?us-ascii?Q?RjdcnzoYh651U42C2oSNn8/OlXzqWr6tpnP1Ra3uLQvetgqjzaoLU1SyGSwI?=
 =?us-ascii?Q?y48Oy8+I9Lb5Z3EH1lcXrW092YUAPMT7YYfeRSgniUfu6Fz62e4MYILKPlQc?=
 =?us-ascii?Q?BApcSv8R8Lkyv+MWbc2ptiivLnsAlbGEFfqIR72oXmsniPB71tZHM7mgVOVx?=
 =?us-ascii?Q?PTNgg8HQXuLbL/hf8Qi9JoY18uTT9y4o4Tz+X9opaL2IyMAp1tJ+mVWVz+hG?=
 =?us-ascii?Q?cdxv/kis6mpp+GY5Sfy3v9IzvG5Lkc2FVWQt/d40dMqo+I/yO9ZwqFNEJpMu?=
 =?us-ascii?Q?/xaoP8cnqbSkd/wbmWG4F0qYMwA/Jv1RwtGKmcE7y0ezcIH0dFZZxLzQ5P+U?=
 =?us-ascii?Q?OQBtBk1JNNVU9bGsbAw5N6IrE5cSN7t5wz/3/2MgCF3WgTTzEBJ5uxUvgdbY?=
 =?us-ascii?Q?fZTyHF44DnRoBKu4dKOEs3AKmhrmBuFFvUj2ZQQOBMs1mr1Vl4e3nMuX8lfb?=
 =?us-ascii?Q?L5tklUKWoBnceQl05Pqpk0DMJ08eUiqUkQ+wSl+oxVk1zyEC/2ph7aAN5Y8J?=
 =?us-ascii?Q?NhNLl0avTTGsP4gXGwFZIiekiYtHVCuYqbs/7D4HZJPcC8N72qKVymDIbeyK?=
 =?us-ascii?Q?K71cmJ2Ofs1VVZ9NyPWezIErOnoVrarMSccus/nvjgkvetrgVhAcDM07N8In?=
 =?us-ascii?Q?YQgtBORSXgpcH6hOjsYzpzPxCqEfuh4rmNysztydbvTdbpXot/5oC9W12rR1?=
 =?us-ascii?Q?54QE8xGy2nFcicUCHN5qgxrdXulTqCVpQXwyb43QBpFIl7CYKY0FjWdqqIov?=
 =?us-ascii?Q?YJX8dMWAlQj2Mq7HiAtF8/j/1pi91Cly+He4LH6quhyr2LxNUEzQHftiV1jQ?=
 =?us-ascii?Q?Mo/0xg00Rf2C/wPIPAr6i3U8EqAHE62aT0p7dRdixPYwWR4nGDk3JBtu3lAY?=
 =?us-ascii?Q?mSl+ordIZSURFrL0aJMYxLhuygry1Lmgt9+6c0UM9WbGV1W2TBGF43/jCVys?=
 =?us-ascii?Q?k1yGzF3lFP1ZYo1ncYIHvzOYCAlg+8eN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:30.2342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d69c5f-32c9-4e6f-edbe-08dca4cac0ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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
index bd9c2921e0dc..2339bbdf452f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1051,6 +1051,7 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return 0;
 }
@@ -1992,6 +1993,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->vram_pages = old->vram_pages;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return new;
 }
@@ -2444,6 +2446,16 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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

