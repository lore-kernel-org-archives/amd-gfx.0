Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6215C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 16:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6100F10E9E0;
	Fri, 26 Jul 2024 16:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZrZiuf9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B59910E9EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 16:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGZFdZnXomzE3x9nJm9mz8AKp5q5T2mUPu366RiKVVH/SQVc/O7Mr4nzt39xa1t4ChDV5d9AuniJMZnjHCloWtszbMfnb1w58SLMpUgwEZVXaAT/7HzfCURCFXcb/JVxt8enKsomBC3omLKtwkjxU6+GdJkLc7cELh1sRexqoBRqr0k9RTJfLAPQU+maMFBHuzkRlWJfOy8IrrrUuszu893iBQgRl+m3yo5aiEptb+LwD+NWJtS/hq1fQlP/ka99saIaMy/jYay9U+Pwb32FVC3ORxGXwH9VlZS3nCAIo+kuhnea4aXfrpT2Q0CkAo2AhNHfjtgIzwVTxqXNtByH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAGTgHJXVy+ZiHhLF0TAxcUBxSb1keEaYxm3wfkLNbs=;
 b=I+3z3u6LnH8s+agK8P+5dLc+nCvhgukl/r1U7Q3kmFYIH9q8YzVWyK8Fke4vK6RIn2Okm0jDdeDaYQ7bawh3uiBbQS8HpbBf9do+39FBPb+da66Ki8HUOSz2LNE+vOIZnRDJx8jiIthtWMvzQijb3fgnSDcuYQ+uZrJVoyROKf39TV05c8RU2qcCuSPb7VaNHodEehzW00T0fBqdzzHyh4HwRvMbu6zB3FIGOeW395XNxg2bDYW4n5au+SjMhvSYJy+GVIeaTn0yTAdSbPVE/4r+IV7X43OcvwUR89xubjVlwbT/qRhnjxnLSHYBSGt2nRl0LyLXaWh/xvRoyNgPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAGTgHJXVy+ZiHhLF0TAxcUBxSb1keEaYxm3wfkLNbs=;
 b=wZrZiuf9jN1GdJbnuVUWx01dQftleKmEMI4HXAUdAurgaJqq5KtRjdPLCimyTLEuWZR30OapE30gxQekJdej9brEe6MzJUdD6MZx37sZwIZjtPX5mnjEvGQcs1S4JMNMSpIE5PA8QxiTOx2aapsIJAxe6ADRUxyQ/HxcB+8tRQg=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Fri, 26 Jul
 2024 16:18:00 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::cf) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 16:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 16:18:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 11:17:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 11:17:59 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 26 Jul 2024 11:17:54 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v4] drm/amdkfd: Change kfd/svm page fault drain handling
Date: Fri, 26 Jul 2024 11:20:38 -0500
Message-ID: <20240726162038.137284-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 357247ef-16bd-4b90-3e3b-08dcad8e849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YL8tNeh8U5RtIT4rPoLxj0xPakzCzLFpPhvNTRAXJimbSY+E8B62Jj0k1zG6?=
 =?us-ascii?Q?qLZMJ6iYOhmRvx3/NCHXQNLt9G+FS60kQPhUl5aMMuP6yieSk0GXRvS0Dyq3?=
 =?us-ascii?Q?3cA1f3vjaRy/bJnCo2u2tcmB1JOv1sMNMgNxGYhrT63BUR5mTDCGlN8jfMGU?=
 =?us-ascii?Q?P86+7iY4POnTxHRJQUOVXWruL6yJ/pOZ5RqnCUUXPyQ32YhlGv0qCjCX/Qkz?=
 =?us-ascii?Q?9oILAYviWFuuKWOIe+kpkZfU8kUmIcqxBubt+r9gwprRXvzz72qT4wC1vDqA?=
 =?us-ascii?Q?b2LW9oZKe/SskYFZLMVUZ3HtjKNMx7nySbkDFpvHicaJ7mDjyU4je07IR3U+?=
 =?us-ascii?Q?gcFntCNslAACUrCjz6m3c1l8tL3F+EpD/lkZ+ZvbmA3x/gZ58YJvIfRzlwkK?=
 =?us-ascii?Q?f7JkEkwkXghb/wY+bwcSwImKVZL7C23u83BUm1ZbTDq1NV0mINEinm3mIzb2?=
 =?us-ascii?Q?uPJZxjK9l1oVGxbKg76R4FvGlmwjfxSJIJVNzJb1HjiEIwasElsQULsKE2RN?=
 =?us-ascii?Q?28z3s6bzOqRWPGEZocFNIGlo/pcvfEQ3ycQDjB3Uxuv87x0QOZHrij/NoQRy?=
 =?us-ascii?Q?umUYzMV2WPEqMpAQHeCYK6eMrxxDQ9cy4OpOmv/0llkqdLz+33nnV0+Kz/ZF?=
 =?us-ascii?Q?gndn/0D/ncUfpFQqDd/yPj4QgyZMtjgfBKAY47LBgQ56kyu1JHtkbZuwgjCC?=
 =?us-ascii?Q?8LuFEa7ucQNkJciv+0rk4BJoXqrXPo0QbelfzHgkDBEGY5eCKwXMZWUfNpBA?=
 =?us-ascii?Q?swcCWuGGXyneqlndcWZkq/u23iaWPHKa9CnU1GMwKoDl1knzIyK5o2O5sZHz?=
 =?us-ascii?Q?nRYHUZlU/xVtotyYfWhwb+hLUA6iSLaOKr6E9CzA++YAgur602gHRpEEaxta?=
 =?us-ascii?Q?Qujg8yqw6n3VKMgoqnaUMAskDRyRJF4xfO6KOUpzLrJ/qtdIFvJaHSUlKwem?=
 =?us-ascii?Q?Js3uaK67QZB34i8v9suJ4cXk/6OtNu4Hxjj8ym63pmKqWsDvs5TuuKC2Yka2?=
 =?us-ascii?Q?W8CIpCIUeOk3vUEl7Ng3Yu81obS8Lge8X/+0LKXUuAEGkoTfY9eJD65jtQrV?=
 =?us-ascii?Q?Lh1g9X6o/bHIuNkUB7NjI3VsWcQeKltSymMujt3izY0cbJFIiyyDDpG/6QDr?=
 =?us-ascii?Q?LBSiD/QBUYU7u3dLS3hCMasgDAZSsOHMpnBTuG3ceN3mqihuLZJ2LxgGHdKn?=
 =?us-ascii?Q?/YlXetaf3/eNBbvDOUjStD/8MINSrwjcNIFkNvsr/rD3LURWJIGxQs0eKHiK?=
 =?us-ascii?Q?oiJtVFExRyv/sWNoe0b97RVmxs+YH0qnu9VByrblGMFA/T/kBoNpM0CiNtLh?=
 =?us-ascii?Q?VECMkvGON3jtnIfMlEUhBjwELw/6A0dMHkKrTYNYgNWV2TQS2oMtYd/dvBWX?=
 =?us-ascii?Q?oQwXWqUMZ8lFGjqH/wGpwuGv9HkQGgK8jqD2mOmuWpGVbZ/PC5pQLP8DEY2T?=
 =?us-ascii?Q?8+4QDIrB4zbTTMj6Kct0s2fNx4zgP11j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 16:18:00.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357247ef-16bd-4b90-3e3b-08dcad8e849c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of "not handle page fault"
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page page to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happens on unmapped ranges after unmap events is app bug that
accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 128 +++++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 68 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..d90b7ea3f020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..1d6a1381ede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..3596cc2ee7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
+					   entry->timestamp, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..ac08d9424feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry->src_data[2] & 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						     addr, write_fault);
+						     addr, entry->timestamp, write_fault);
 			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, write_fault))
+						   addr, entry->timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..48d858e77d93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,11 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..416b103550fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2259,43 +2259,6 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 	}
 }
 
-static void svm_range_drain_retry_fault(struct svm_range_list *svms)
-{
-	struct kfd_process_device *pdd;
-	struct kfd_process *p;
-	int drain;
-	uint32_t i;
-
-	p = container_of(svms, struct kfd_process, svms);
-
-restart:
-	drain = atomic_read(&svms->drain_pagefaults);
-	if (!drain)
-		return;
-
-	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
-		pdd = p->pdds[i];
-		if (!pdd)
-			continue;
-
-		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
-
-		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
-				pdd->dev->adev->irq.retry_cam_enabled ?
-				&pdd->dev->adev->irq.ih :
-				&pdd->dev->adev->irq.ih1);
-
-		if (pdd->dev->adev->irq.retry_cam_enabled)
-			amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
-				&pdd->dev->adev->irq.ih_soft);
-
-
-		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
-	}
-	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
-		goto restart;
-}
-
 static void svm_range_deferred_list_work(struct work_struct *work)
 {
 	struct svm_range_list *svms;
@@ -2315,17 +2278,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange->start, prange->last, prange->work_item.op);
 
 		mm = prange->work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2446,6 +2400,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2410,39 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing "phantom faults".
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&svms->drain_pagefaults);
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+
+		/* Check and drain ih1 ring if cam not available */
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svms->checkpoint_ts[i],
+				   amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+			continue;
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svms->checkpoint_ts[i],
+				   amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+			continue;
+		}
+	}
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -2900,7 +2883,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2893,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,11 +2913,31 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
-	if (atomic_read(&svms->drain_pagefaults)) {
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid/gpuidex for node_id: %d \n", node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (READ_ONCE(svms->checkpoint_ts[gpuidx]) != 0 &&
+		      amdgpu_ih_ts_after(ts,  READ_ONCE(svms->checkpoint_ts[gpuidx]))) {
 		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 		r = 0;
 		goto out;
-	}
+	} else
+		/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+		 * to zero to avoid following ts wrap around give wrong comparing
+		 */
+		WRITE_ONCE(svms->checkpoint_ts[gpuidx], 0);
 
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
@@ -2952,13 +2955,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
@@ -3170,13 +3166,6 @@ void svm_range_list_fini(struct kfd_process *p)
 	/* Ensure list work is finished before process is destroyed */
 	flush_work(&p->svms.deferred_list_work);
 
-	/*
-	 * Ensure no retry fault comes in afterwards, as page fault handler will
-	 * not find kfd process and take mm lock to recover fault.
-	 */
-	atomic_inc(&p->svms.drain_pagefaults);
-	svm_range_drain_retry_fault(&p->svms);
-
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
@@ -3197,7 +3186,6 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&svms->lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
-	atomic_set(&svms->drain_pagefaults, 0);
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..5f447c3642cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
-- 
2.25.1

