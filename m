Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5CEC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F5810E6FB;
	Wed, 21 Aug 2024 22:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYGJKJzU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B091110E6FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKTsXITLtv4AykzdjtV1Mi+g/nBtJx59UcK+I/Dmja/7tG4iadkQPTTIjgpPo01Xt6uNUpBLGDODLUTZmKteaGa0+knJfdCpLIjZtuwut/lp5Gtlx3GS789LHBZ5U3oIE/h2R3OO6jJrCCW4stoCsbafKB127cxo5Ds5n9YZ/1RK6DCmoi2awqZBY4JwiuU0d40He7/97btFgqcB74xQZGcp9q077ObDa+fB0hPqX1h/QNKK43XReZPxw9L70Mz+kOfGVrN+8V9CQhGlNQzhB+hh015uGtvizJfp7xTsCVKCCQTeHgn29RnS1IStB8HuaDo1rbFfEROOhsYdI4JgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUgjRPXTu1OCEXoP3wU4+bo8qxfWg93fKKbxKLYyjVE=;
 b=flrqmYsPhO4K9aNdX8Xq0RyRIE3xMehbNgWS1yaVNfGW3TYIv7r0+Z+bFbY41RrjFVbAKY8ph9b+mSQ7d9P3iIDZIQsGmKGwsn/y5tols0M5CRjQ4QNDHvkxPrG5O3qI2YW5NT27xaN+GCXQsizr6daHWxLEm/lmzEh78oUMOVUyPTpRutvahOqocHcLLb3QIoMJl4uA5m3ITBm8FBMSHBiQVa2xS28ny2NAXqllPs1PjOPb9v5nF7U89RRpoYTeq6iFAdoNkrDJBnQUX4VgV3Wv8rxuhts/TRY9V+DuZ+PBzhVhCwbQ3advfrV/zzDX2hz7uMW5Hw+6KaMcXQTzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUgjRPXTu1OCEXoP3wU4+bo8qxfWg93fKKbxKLYyjVE=;
 b=tYGJKJzUooEwxBSgJiajzP/LhlsSNTNGXb22XvHzOOH26W4HqOfYOxrAKf/FjqYE+Wi1ivR4XH5FFGpbSvKVQx04ei1CxoX/DGVgSWydCBFGnzd8SzmIIrl51pLpE7/M4CB8H19/1/ZesUqxOh8QSW4p7iN1pU+NTWKJnrFClDw=
Received: from CYZPR19CA0009.namprd19.prod.outlook.com (2603:10b6:930:8e::18)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:01:35 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::19) by CYZPR19CA0009.outlook.office365.com
 (2603:10b6:930:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:01:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:01:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:01:34 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 Aug 2024 17:01:29 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <Felix.Kuehling@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v6] drm/amdkfd: Change kfd/svm page fault drain handling
Date: Wed, 21 Aug 2024 17:01:33 -0500
Message-ID: <20240821220133.25975-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: a20f47de-0556-4116-23a9-08dcc22cd2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fBjNSrPGMGo+0DWp4SUlfCtb/t/NkB2vpSLfrsE0o2e+eN3oow87PpEIMCyo?=
 =?us-ascii?Q?1SbmQENmMIkisIeYdh5luZrjCjLNZT0zviIKgLBshGT1uJRwLTT4S2+py6ys?=
 =?us-ascii?Q?dv57Kf5+XYSFVQMuwO9SWoV2kN3YwPp0AFgc4sp7JjCiWsCAb3G2A2lzOSXA?=
 =?us-ascii?Q?T1qeIMKkYIgn6eDM7hPz6Dsv/0zdtUCprcS/1JkPkEnbZfj/hW2mraxhN6L+?=
 =?us-ascii?Q?f7hCd90huRnAGYONjCxYpz42GD2LZ0NAazI5ECfR0iEVIKjVe1z/AJQXpxXj?=
 =?us-ascii?Q?m+GhoP6srTZUQCQo6AKJbD3RiTLVL1RA26fHvgTlmAJ1eNwDztDiTxklagNa?=
 =?us-ascii?Q?8KgsaNwP5IQePUow76dz24u6faXNq81IMVAjD7ohD/LmqMYjpuwTt+ACMH9O?=
 =?us-ascii?Q?BOmPzaKhF1dv/Y02gm2kHrmaymBHWOjg22Tv2I23KQYQBWpq3DDeZBXYk8+/?=
 =?us-ascii?Q?szDgAYbVJosDBfHxyOIjeRhIs6F38qNkE8BEtWo8x2h9+yZgTUyQPErfKSNX?=
 =?us-ascii?Q?9qWYrgF1w2ScVhPzfinmTWb1gn+PHWWP0j4YPITehVyt3MfrfDMAgCFTZMs0?=
 =?us-ascii?Q?rH+waLmJUvkd0WNPQ5z43PIYyDJuLQM2QiE6bMDL/xSOChM9S62aXLa5HEuf?=
 =?us-ascii?Q?4OWgNc1K9zIyoFBq9rrKspLUz9vG31KlHvAWDH0BtOhKm8gWvsyVNR9gVlw7?=
 =?us-ascii?Q?OGvi/2qOWC7zQpNYfPkVaYpYSxKBalHh5tRg8sptbT45MsX6CmVLJy2JxE+H?=
 =?us-ascii?Q?P9EV5Ix28ohcUsW6ULl8uBGe13dgVY6C2XYlWkPQopjBe4XMRgHMHeHN02Ep?=
 =?us-ascii?Q?zSmrDu8LyCz4lm7qHKChDoleGYVSWa/VrytUzTwCQOVKNfWflJi+1MfLY0qN?=
 =?us-ascii?Q?OEEQsg9J5j7seVNz9ZReEe9YuJuk30dy82R0sRHbABHnbVWwfATUdfmd6+vS?=
 =?us-ascii?Q?7t/9ek/ytfNVaZp4Nw0Q5hR9UnDqh7HV7zAzRbe1HXMEFbKJhu7jP+Y+0J4K?=
 =?us-ascii?Q?duUtLHfGU07u91FEYt8MFnOFX3kGv7Jal2kBprroMh9lNX4XNtWV/B9PvbEZ?=
 =?us-ascii?Q?I6Bv64jnTVr7on0Y03+oBpDPGk4H80mmmsVqyK8kWq25+J6aHQMIp97xTiZc?=
 =?us-ascii?Q?QS5xCY+U5UCZ40uqmNYJbGN+niJaLjg0IC3tpTbWBlDgHrmeI/A8BGuzF5BU?=
 =?us-ascii?Q?/4WaqrZX7VwGSW0fJOUiMKp46bPAF9fL/oBC7NFbiiETizt7iyI927Wi1fLR?=
 =?us-ascii?Q?BZ7CBouzFxy42SOLtY7geNwZ/V1lrI40c5ML1mwKXitPrQRBdMIGPz0WmOlW?=
 =?us-ascii?Q?Equh7csViDBJDo0a0A7zBJe1JRIsP/GCjNpdEXXj0SjoazyP3aBt1k/fV2zw?=
 =?us-ascii?Q?s7xQMWgshLoQ+jTaYHNnRYtgAPiW46L7LLWzWyUoVTniA7KbpFzrPLhJ8lHE?=
 =?us-ascii?Q?bPKEFfeBGxoG7RBkB2EheiEYp8aQVtdX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:01:35.2370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20f47de-0556-4116-23a9-08dcc22cd2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

This patch uses time stamp of incoming page fault to decide to drop or recover
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happened on unmapped ranges after unmap events is application
bug that accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 98 +++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  2 +-
 7 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a060c28f0877..d89a4c14bbb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2764,7 +2764,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2790,7 +2790,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..d12d66dca8e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -558,7 +558,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f0ceab3ce5bf..9784a2892185 100644
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
index b73136d390cc..c76ac0dfe572 100644
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
index 4190fa339913..288ebf02fa1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -863,6 +863,8 @@ struct svm_range_list {
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10b1a1f64198..e30c644e44a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2256,16 +2256,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
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
@@ -2285,8 +2279,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2308,17 +2300,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
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
@@ -2439,6 +2422,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
@@ -2458,11 +2442,37 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
+			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}
+	}
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -2903,7 +2913,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2913,7 +2923,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2934,11 +2944,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
 	if (atomic_read(&svms->drain_pagefaults)) {
-		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		pr_debug("page fault handling disabled, drop fault 0x%llx\n", addr);
 		r = 0;
 		goto out;
 	}
 
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid/gpuidex for node_id: %d\n", node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = 0;
+			goto out;
+		} else
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+	}
+
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -2955,13 +2992,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3176,9 +3206,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&p->svms.drain_pagefaults);
+	atomic_set(&p->svms.drain_pagefaults, 1);
 	svm_range_drain_retry_fault(&p->svms);
+	atomic_set(&p->svms.drain_pagefaults, 0);
 
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 747325a2ea89..974bbc6b14c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -174,7 +174,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
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

