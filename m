Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB808C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 22:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3A210E0BD;
	Fri, 19 Jul 2024 22:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBl8i54O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362E110E0BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 22:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5tgfmMco+qxO+jC3JxAP8pDQO7ZkU4dB56sFfLjrwb5an2k0VBbLP++QGygTc87Q5HzVCyH+jthRkgiNy2pFGE03+/24nNIEwtZ0ptJeTXLOXt6VEjUP0yYxjv388L3ida3znZt5WvHLvw2GhTXsFTbU1GZyMmjjmUn31deTQEKcS92/2oM8UU/sNB/VXgb6O7FGDQF0EnZ6PIthqAPMcXqz/2wBWniE8eb1a9MJlbxfN47q/TZMfVcVAlQADmQMyKgqD02J/feQw2iqvdNwKDYlt0PyILQ8SV2XjHBkokAKhOu/UdaIXU1V1IP5SuDLUjZce+5t0ua1JvUB3UnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jexi2AQiAYJlF0oAVGbQCns4IkouZG3yxvcztrbpvYM=;
 b=RmzTYJjcpd3EuSSxNQQf34jDhlfwLGrD89Mxz8g+KVDybuBiNNc5n/vsNQ59/l20ia2R50wsT6jdzNwsphshjWM+tM17VUWpEGV2iHqfP3mXWeNCeIiPv9Y3XLvdD3Sgp8XTG16cJf24WIsg2CnQGl18QmU8KvM27VsegJOKzk1z4N8HWcGS5Zm1Um7mt16RJSkSapRJCVjhDHz68hwujHanN5UP6HmFSlg0TSTW0QsGPfBb2+M661SOSMeTpMSFrUSaM6+q3NhbIF4w5mL284Imcmv+XIKURB6zqKwyRSAJnGPY2BbgvLeQRWYUBLbr9RutSgAWwxGN2Y+KxqxwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jexi2AQiAYJlF0oAVGbQCns4IkouZG3yxvcztrbpvYM=;
 b=aBl8i54O9sJIdiS14gGwt2ISQIOLyzBRXPbUX0KI1VH7muPQQtGTE9zYFnfYDy5MeDDDBEUagGJCgHVJ5GmdiiCxVTh2az/wScJKhkylbIuwzt737wmj5J+WhjQfGKDaJQrPmXmKncqAGTKdY9A49yMZu7lickxYUyO/AqyaLLU=
Received: from BL6PEPF00013DFB.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1f) by CY5PR12MB6178.namprd12.prod.outlook.com
 (2603:10b6:930:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 22:14:58 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2a01:111:f403:f902::) by BL6PEPF00013DFB.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Fri, 19 Jul 2024 22:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 22:14:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 17:14:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 17:14:57 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 19 Jul 2024 17:14:52 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Change kfd/svm page fault drain handling
Date: Fri, 19 Jul 2024 17:17:38 -0500
Message-ID: <20240719221738.26840-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: c748cc4b-d0fe-440b-ce39-08dca84039ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j4AZdKOFghwS4h3gMD8i8TI0/alFuzCdQIvK/jxiTaaiNUUEoqAWbNYIolhi?=
 =?us-ascii?Q?kWegwt4y7pq6S8ehWMB816b9pyWIu05qcvM2E4SeIR9KLRVu3G+uY0uFP6sy?=
 =?us-ascii?Q?kNTl9ZWus4RTZFxTM2/aCb6HgD8gdj78zoDNDe/3kVENco8C84EuJTpMOOpn?=
 =?us-ascii?Q?tpbrRjeUYt5Nib9JJl8mWQ4wf2If8Yv7uhQiWW88y/Ga7Ifbr3bbRI2mHMqS?=
 =?us-ascii?Q?9090Bb/1TPEplY3wWrTqE3/fQt1b1+RHYlNEUbv5sVDBgHZ3jsFFTT2vic2n?=
 =?us-ascii?Q?LLBZExp2GpwYOjo1qMPIF72yampAsW1UwCK2AY5PsudTBw8HjQf2v7B+/VN6?=
 =?us-ascii?Q?HsfGsRwQVXxneJzZR9bHEyDxLujpw9pxXuR6cCGlhsL3jAzOLOPdW2OYKmqX?=
 =?us-ascii?Q?m1iaq97gsoxcls3BEzUpFZn6B+QYkkH0wuYu96Ukf34ebStrGGV6jxRANhKo?=
 =?us-ascii?Q?0CH4V6TC8OQeQHNWKFvo4nwRKIlUdk3tWj0BlChhcn1oox74AuBqC1mXldoU?=
 =?us-ascii?Q?hwLOjAVPdnvcjcev3qkT0UK2m1O7bvFi5VkKQXN1FYwGKuxFxhwBbvIojWEU?=
 =?us-ascii?Q?FgItGLGI38iK23OWK3cx8oHthqVJ8N3g4eAjxbDOcNfjuA65aY9m3HGS6Ovo?=
 =?us-ascii?Q?lKKoz6i6tXXB9PnFqOH2o07O5PL4+VN/g97D0i012QTqK6qil3tpy//nT3rT?=
 =?us-ascii?Q?mx4vZBrce6a3y1oVvnHDq0T22jsZy3HuQ4T6xPwgmGbjNIMxH1nWhxCNrEuH?=
 =?us-ascii?Q?OnVmJFV6VmDMqjI9xdQDXpRyf2eQ8TQ4ajDyjzMwb13cEspUJ+ctij5jQVDk?=
 =?us-ascii?Q?AmPURAs0axmqS2WA8VcRIEmNgjJsgQ7CNfOZoj1NIp1+qfHOnIQlRqxUXN82?=
 =?us-ascii?Q?zKMEqwqKKVAv1EG83YaVot2FDZGmXim/PcZx3lJQj8uPOkqfRcdWZKugzENc?=
 =?us-ascii?Q?UmU1qiGk5mibt2bB/fIfJo4w6pt/+ufk7u8SUmYaXFqoR+sR0TjtRDz//XSy?=
 =?us-ascii?Q?u3QfSkky1B2zYlx2MTs5nQ476OLfJDBdC+O50OpiBX1RbrXrAFIp37VWZkOV?=
 =?us-ascii?Q?O5PLGvrlM8OfW12fgsoT7s+VyE+oX5t+IwwEC60yPUPhSLEm8aEosAgV8xPm?=
 =?us-ascii?Q?aqbixLhuji0BrW1BY3zf/K10vOaX+MSE3b4NrxNTEpZsSNVQV/C8XyRrlwpE?=
 =?us-ascii?Q?LSyEUCSm5VgYFfk4BeodC1Ic07rbHNkClcMVrR52SI3fuFAUK+pkqIBqJ/fd?=
 =?us-ascii?Q?t+BNjbqpR9h3ST4KgXkGcuP2PjVx6oVur/UthY3M6nLpcO8tCqAGC7Idc7ea?=
 =?us-ascii?Q?2BzKA1hvyR7gpMEtJvGwOzorQnx248/9E1QMwL5lRDkDizAeDz3YEFM0lwk6?=
 =?us-ascii?Q?2R86j3NpbY8ceEmWV5a5KODV6ECLlfx9/0e7mnJQOkAUuvBXkVm8nRcsXDGI?=
 =?us-ascii?Q?oyg/lyVp/874CswVyZ/qDBGixSJT7e9L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 22:14:58.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c748cc4b-d0fe-440b-ce39-08dca84039ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 88 insertions(+), 43 deletions(-)

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
index d933e19e0cf5..5cceaba6e5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
+								   entry->timestamp, write_fault))
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
index c51e908f6f19..8b8d5ab9da76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this process */
+	atomic_t			stop_pf_recovery;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..9dd28d06ea2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&svms->drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
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
@@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing "phantom faults".
+	/* first stop kfd page fault handling for this process */
+	atomic_set(&svms->stop_pf_recovery, 1);
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&svms->drain_pagefaults);
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+		uint64_t checkpoint_ts = 0;
+
+		svms->checkpoint_ts[i] = 0;
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+		ih = adev->irq.retry_cam_enabled ? &adev->irq.ih : &adev->irq.ih1;
+
+		if (!ih->enabled || adev->shutdown)
+			continue;
+
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		/* Order wptr with ring data. */
+		rmb();
+		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+
+		if (adev->irq.retry_cam_enabled) {
+			ih = &adev->irq.ih_soft;
+
+			if (!ih->enabled || adev->shutdown)
+				continue;
+
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			rmb();
+			checkpoint_ts = max(checkpoint_ts,
+						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+		}
+		svms->checkpoint_ts[i] = checkpoint_ts;
+	}
+	/* resume kfd page fault handing with time stamp checking */
+	atomic_set(&svms->stop_pf_recovery, 0);
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
-	if (atomic_read(&svms->drain_pagefaults)) {
+	/* kfd page fault recovery is disabled */
+	if (atomic_read(&svms->stop_pf_recovery)) {
+		pr_debug("page fault handing disabled, drop fault 0x%llx\n", addr);
+		r = 0;
+		goto out;
+	}
+
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
+	if (amdgpu_ih_ts_after(ts, svms->checkpoint_ts[gpuidx])) {
 		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 		r = 0;
 		goto out;
@@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&p->svms.drain_pagefaults);
+	atomic_set(&p->svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&p->svms);
+	atomic_set(&p->svms.stop_pf_recovery, 0);
 
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
@@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&svms->lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
-	atomic_set(&svms->drain_pagefaults, 0);
+	atomic_set(&svms->stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
 	INIT_LIST_HEAD(&svms->criu_svm_metadata_list);
 	spin_lock_init(&svms->deferred_list_lock);
 
-	for (i = 0; i < p->n_pdds; i++)
+	for (i = 0; i < p->n_pdds; i++) {
+		svms->checkpoint_ts[i] = 0;
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
+	}
 
 	return 0;
 }
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

