Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E26E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 10:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D55010E488;
	Thu, 19 Dec 2024 10:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0z7BJD3Q";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEC910E488
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 10:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbZhrquV2SF1z2jSakyCspJI+hRYdtP1bD+znpmci/im8w7tPR5q5wOzbnNPDpWF8YhEhNwWCXB1sNoQ8y3w0g+5Xa6NpdviGdvmF3a3dYzEN1aRKLWSGAdlryT2bzvrm7oDQUmUaD1uZk5+lzRlTRKtLP5kVti+ob6WapIJ/d/Aep/VBL1n1nh3lx+uByxsQLq5OMCbSlZpY9wjqZ9cgjibSKIne6n23gndDaUK8kLJN54RDEQZ9xXLhnE3+Q8XWyVXrnFfTGBJ6jvIiwWZdXE9L4nuzZ/OZtj0cdOfWExMUa7eJLiQ1jwGIVDPWB6zsCuUCeUFiKwk4P86NA57nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt2zPkMFKbnV9hAuxK49ZC7teDjxP7AtmonUP4JsxMY=;
 b=a7LRrJJ6PSR7gfbq4PwHnMKIAouKkt1xWfmXZqQeiqHDsgiumx5biK4V5wZWJbZeMVQFWqWDUj52sT1v6wM+i8NyzaBlpmCTIXiJ9JJMOH3ayqsXZpozxHYPQj5xrBmRVinr0gtV2u+a40SU2NXBmXYhpq1X8AHt6MgIFneUOH2m9U1DDAODiY+xsjAlsm0mQOn740F4v8z0GyWm25RTZZIC/66sn8trj4eCdUTIFRFJ8ulcxMuAxCx9YV68pZGQlbc0G+aDXeCvhs43uh+Io59+iFzykNRb/IhcD/W/67/+Y9zoHpUN3fmhIH2EKIiOGf174MDIAT7JowQoTcBqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt2zPkMFKbnV9hAuxK49ZC7teDjxP7AtmonUP4JsxMY=;
 b=0z7BJD3QZZZDGa4GlpbN3WeK7UZiFFcVASMcfiq8/cdR5HHWNWIgx64iyrHkEM5tvch0QnK16T7XAL96xAGgf9vi2XBr9IKMjUHsUwKxcgdXmhjuphrsBEF6RP+7RoXMTfPighAep12D1l5nxoDlX5CcIUm9igOZ4iPngdOktB8=
Received: from CH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:32::32)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:38:44 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::5e) by CH0PR07CA0027.outlook.office365.com
 (2603:10b6:610:32::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 10:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 10:38:44 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Dec 2024 04:38:42 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
Date: Thu, 19 Dec 2024 16:08:22 +0530
Message-ID: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c7e6ec-1b31-4755-7b7a-08dd20194fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+9GR9HYjnwAumgOd8wGVGEw0Hf5c6lvUsRkBLKGtnlCLp53t+XH8/vcLPkY?=
 =?us-ascii?Q?6gpRtFnYavnaGaaznwKYQDn9fyBrCOCJ/4NP5Lct39HIVZApr9ubfvkX/Cy3?=
 =?us-ascii?Q?yVzZf1odbnMj6eQOFuvAtJlUr/uXa/qXb7nUrFWUvIJSNS4GFmdxlAFVK7uc?=
 =?us-ascii?Q?lxoGEs4IwDL5a7Ck7E6kcU1fFA4nvwhqJ7aupOTd/j0NYzRT/VTVtU5uzNnC?=
 =?us-ascii?Q?mW40Um7GZBOJN8sQVGYcm12L0BbraflIoAxbxi6qTq7ADMrT4rNhRY5sDIjG?=
 =?us-ascii?Q?yPccbjkIiiX3W6IqNX/0gURaJNLwzoImbx9dHhd/V/chcEKGDiwYow4xp7tJ?=
 =?us-ascii?Q?OOmXn3KsVaj0XCUbzB7/nlMbxNgwUmclpb6nAMbKGGaGCg22CLmbZfLF7p1c?=
 =?us-ascii?Q?D+3wOML82SjmYDR92f3f0AWaJoEGOvToYgnuGRFb0iJ4/M2V4UfEJLzd8JFH?=
 =?us-ascii?Q?GPJTwxupkaI5/psfhhtUB2mGzUiLu7B8k237c/0PUZmjc0tbUw1ahnYZCv3Q?=
 =?us-ascii?Q?JZM5NGj1BKgoq/4uFURROvmgWRhwQIaLwcsLYUEITgmtUH5IBad9mBnrQA6J?=
 =?us-ascii?Q?HP3lltlRSbbj9XNaJxy5hM50ZmClrerlDDqFpSIj8AXmB9V6Ea+QBLoDAGiB?=
 =?us-ascii?Q?1m29vEN2iklqLNQD5yr6H3oaBwMzi1ioByzabuzWKMMhwxKhI4tdhcdugB+Y?=
 =?us-ascii?Q?q6+wpA9MgWmKo5IbugCtXjA81ujdkqC/ebfdrF9blKCoHiMtdG9nKE7htZLm?=
 =?us-ascii?Q?JlYIDMtyRy1zyUlk00/J3CL/YGUQ7Dlhmlfuz+g0R2b+I6oFN+uP/t8J+8+1?=
 =?us-ascii?Q?RKQjo4XBPjWGDcpVsuq3DhaxsSIkJPFEZwo2pHw9BhXPULD3/+NrZCSuqfE1?=
 =?us-ascii?Q?YTwxjZoj5msoMaxnCoJwXHuC8Hb6AFOxwRattFKeMSvgZ07IJgT97bpC7JRO?=
 =?us-ascii?Q?w/vYWfEWnuRro1IQ3Qjoz6uxz0Ci+MZeKe4YXxW0Rrvd4R7HjKpyefKvUzCC?=
 =?us-ascii?Q?QBlfW7ljug8pi2akwOGqi554X2KRQxkmRdvacsm52wNbVPCODVbRAFKluKox?=
 =?us-ascii?Q?rFDjM2nA7LgZ4eSPUbMc5semU0R/ODy6pMsQ/ow4ydAoOuAxh5xZeyl8y9Ha?=
 =?us-ascii?Q?z8XsQnqrXhsNfdgk4ERudiGKC7U4CE1qo1ixfyMYQBQTL2PYhstzrL1ucq5r?=
 =?us-ascii?Q?/PRqs7FT31bsfJPL1jygKrv3LX4X6Q/OUQO5WKIowGbe7MpBP77jzHHwmwRw?=
 =?us-ascii?Q?29o7zTiEdRRYeGt1g7E+NUP3fRIK3qnAaNoeN4KxojWA6TSI0NYiCutMMQTy?=
 =?us-ascii?Q?GZEp45rMqDc7u+9mqi6pY/pLUNwXAmavqGG3XLkLHbwneOL9Zv5kyP+8r8p2?=
 =?us-ascii?Q?UbU/COHOcwfGJjynS4G9KfCFuR3tI4gyNH6yuhcmN2lG7DpOa7QqlKtZNT4b?=
 =?us-ascii?Q?1UDUhiI4F/PNl5w9a2qW24KcV+fZnFs4hmiBXGzsWsVJyvY0ya5HqMJ1tDwf?=
 =?us-ascii?Q?av2EKfemIEoNqlE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:38:44.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c7e6ec-1b31-4755-7b7a-08dd20194fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
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

Fix out-of-bounds issue in userq fence create when
accessing the userq xa structure. Added a lock to
protect the race condition.

v2:(Christian)
  - Acquire xa lock only for the xa_for_each blocks and
    not for the kvmalloc_array() memory allocation part.

v3:
  - Replacing the kvmalloc_array() storage with xa_alloc()
    solves the problem.

BUG: KASAN: slab-out-of-bounds in amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000006] Call Trace:
[  +0.000005]  <TASK>
[  +0.000005]  dump_stack_lvl+0x6c/0x90
[  +0.000011]  print_report+0xc4/0x5e0
[  +0.000009]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
[  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  kasan_report+0xdf/0x120
[  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  __asan_report_store8_noabort+0x17/0x20
[  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
[  +0.000408]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
[  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? try_to_wake_up+0x165/0x1840
[  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
[  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
[  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000043]  ? __kasan_check_read+0x11/0x20
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? __kasan_check_write+0x14/0x20
[  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
[  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000044]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
[  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
[  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
[  +0.000009]  x64_sys_call+0x1205/0x20d0
[  +0.000007]  do_syscall_64+0x4d/0x120
[  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000007] RIP: 0033:0x7f7c3d31a94f

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 43 +++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 +-
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2e7271362ace..4289bed6c1f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -122,10 +122,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
+	struct amdgpu_userq_fence_driver *stored_fence_drv;
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
+	unsigned long index;
 	u64 rptr;
-	int i;
 
 	if (!fence_drv)
 		return;
@@ -141,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 
 		dma_fence_signal(fence);
 
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+		xa_for_each(&userq_fence->fence_drv_xa, index, stored_fence_drv)
+			amdgpu_userq_fence_driver_put(stored_fence_drv);
 
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
@@ -221,34 +222,24 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
 		       fence_drv->context, seq);
 
+	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
+
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
 	if (!xa_empty(&userq->fence_drv_xa)) {
 		struct amdgpu_userq_fence_driver *stored_fence_drv;
-		unsigned long index, count = 0;
-		int i = 0;
-
-		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
-			count++;
-
-		userq_fence->fence_drv_array =
-			kvmalloc_array(count,
-				       sizeof(struct amdgpu_userq_fence_driver *),
-				       GFP_KERNEL);
-
-		if (userq_fence->fence_drv_array) {
-			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
-				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->fence_drv_xa, index);
-				i++;
-			}
+		unsigned long index_uq;
+		u32 index_uf;
+		int err;
+
+		xa_for_each(&userq->fence_drv_xa, index_uq, stored_fence_drv) {
+			err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
+					   stored_fence_drv, xa_limit_32b, GFP_KERNEL);
+			if (err)
+				return err;
 		}
-
-		userq_fence->fence_drv_array_count = i;
-	} else {
-		userq_fence->fence_drv_array = NULL;
-		userq_fence->fence_drv_array_count = 0;
+		xa_destroy(&userq->fence_drv_xa);
 	}
 
 	/* Check if hardware has already processed the job */
@@ -300,8 +291,6 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
-
-	kvfree(userq_fence->fence_drv_array);
 	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f1a90840ac1f..3283e5573d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -37,9 +37,8 @@ struct amdgpu_userq_fence {
 	 */
 	spinlock_t lock;
 	struct list_head link;
-	unsigned long fence_drv_array_count;
+	struct xarray fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
-	struct amdgpu_userq_fence_driver **fence_drv_array;
 };
 
 struct amdgpu_userq_fence_driver {
-- 
2.25.1

