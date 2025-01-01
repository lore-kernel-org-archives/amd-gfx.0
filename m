Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACBE7718B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2025 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C1B10E0CC;
	Wed,  1 Jan 2025 08:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W5RXg23t";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43ECA10E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2025 08:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7w6vqrU8HYWW4zIV5Btjb3MOXJ2FGUbAIyQYpof9JVC3wv3awRItsfhzJTF6Na2kd/BLs7VXX2wEvjjp2kuY/7I4YdszhreXcJUoaudE2tHW8bsJHHe1s3FbdWZDxRBpcW6EtlqcWTNgsgcJOl/6uK5npl+HY3y4bzTIzhpgoUZIz4bRH2vBRStMfkAPf+X6Rp166P/32w0nq/fksPwV6aA1JIibBVsq0YTgPXRBHkoV1euZCaPXAPkbsubnRGBeSYRM04Z/f7o41XHUYU8N+XG45f0/NX31iFiCBrUhQjitrHIgvsR0wUOqFX7dsk8u+d0zl9abX84EOa5c+u/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQSPpgyoxZsn56PJ7+oH9hLQpGvO5+qymEZ8JTse8PM=;
 b=bQ7ME0jeP+vX/Wj+RqoAvpRA2I/FiWPP9SShbRZkLClnzCQj8/H+1PboVK6poFcEfyJ0mpYCneiuju7dZ39L6PI3JetMZiKdxMIc4qOJjm4fQyfszmU0p5RCKhwhTX0tR2p9Er2twatXdDMbJlJGxpIQkwZsANNoGHI5gdk89DFQRz0yJcuGy0DryX6Lr2iW1ruGFBFNSlGLfMXS/vja9uq39ePlyrYco4gO8F9eEEcJsyMKQubnv9KLX/Akc6cUFLqfAfI+xFMf6q3myKrMXbbNrxBCNBzht+Cj4Z5mlJN6a+lxYwR8oQPKsxz1bvl2aY8onDnD1R7o6/xrCcevow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQSPpgyoxZsn56PJ7+oH9hLQpGvO5+qymEZ8JTse8PM=;
 b=W5RXg23t4fgIDAW17eAa7wlJUQGQRmtawDbppF695rQw9tNuankvRizz1av9JA4Wfv4Gr2w7yaMqNXcw9ZCMfc2ciB2SFIUAUJS9np1t4zuzQEcK54suKD+GSnXqN3IWA835Zsjq/mCx+y1I8XKJswSXsR+g1pQ4RixGYtf8nFI=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 08:52:54 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::c4) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Wed,
 1 Jan 2025 08:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Wed, 1 Jan 2025 08:52:53 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 1 Jan 2025 02:52:51 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
Date: Wed, 1 Jan 2025 14:22:29 +0530
Message-ID: <20250101085229.1053652-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 372a36cc-6bcf-4821-9e88-08dd2a41adfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BOS601lx6CC5TdYSH/j1WT049Q49An31voFYXUZ39mC1VPvs6Qc6MSY0gUH?=
 =?us-ascii?Q?nwl9FEhz6nVarWPKZvd2f7v531Zl5pnQxoODtHHb/PLTUsXwKRGAAVyVlup7?=
 =?us-ascii?Q?NOoLuHrydhZALquBJ9gdu+vSywQMV5vUvxoo73WiCBzJEnD5QVoESWRkX9ty?=
 =?us-ascii?Q?qO8On8pl6rhFiZrFI4xbETsDvZA2je0WjAyC6yxMzsKVbKIngknuk3WLSPxR?=
 =?us-ascii?Q?LIz8za/faPnIDxDoK5tGIb1I8L6tTbVZ6SSZo5Lj2VfLL4VmlbR+4B/d0kDQ?=
 =?us-ascii?Q?pWs0VYf89n5Cd7dEroAxc4rCmmyLQVJ/fZZG4Lzw/TJFXhmTxZZyDA6vWuSf?=
 =?us-ascii?Q?lF1VDkBjshCDs6Nbf2wn1aoU6xb4Y/Qll7n9yJM8Tn/nefx+OxovXcF/3S64?=
 =?us-ascii?Q?nLBU59Tm7O6nsZhTqy8Cn+uj75dRjyI12R6hDAlViAFPeo3n/iWugW77rbwd?=
 =?us-ascii?Q?qcu3FMP8m0orjwJ85r+Ac6E+YH6NLAdKkA3UnNo7eIfquaTBITox0ZgZfTEw?=
 =?us-ascii?Q?mO/wly/A94NYlr1T4rMcbGPtbcs0jf9y9/4zQwpJRTkJhv7OZwepjTUoRNEP?=
 =?us-ascii?Q?sDomEQ7pP0usFAFsZwuIYNfmWO3s9m471n+SOhioVECfKOmmi6VHQCFn5htA?=
 =?us-ascii?Q?FD09qRPWN2d+z3MGJKLvw8lz+ekfksfBoAeJPTTF23lrl5Y7jwtyB5SAREVN?=
 =?us-ascii?Q?zsvPOF+d02yZhYfbK/Ep8bTYi9seSbHBuueQ1pffurftMIzh3mLlpit1rh23?=
 =?us-ascii?Q?+dfoFVhVV+No4PD2QER5TZZAZEK4zA0Tf2OfrBYDSFCQr/q6DikB/k7uvXip?=
 =?us-ascii?Q?TjZDyqDDVJhgXSw2e7Q3Ls8B1A92hZCg1rleqH05n1VX/Q3SDguvYBbOt9jO?=
 =?us-ascii?Q?q/dmhOGd3QREPEwZGpz6gSGVAtoLUGn3CKioDPjMcDTCVxeWDCkPwCqfqCLE?=
 =?us-ascii?Q?3h2hAymE5+NF4jL78+YZmjZLYracUDkBQocqAhztpbXJM0v/ort25FO3IbkH?=
 =?us-ascii?Q?NjsQlf4mAWyiFkfkVFn1J3B0bndOmgdEbJ6F5Ni1NwyAMJ2GCfzi27riZWlP?=
 =?us-ascii?Q?rpc82EiVokEgGzShJmzRBq3XDo9ON+QwNuY/rt7uUH14o+rwfmEBHxf8QGUf?=
 =?us-ascii?Q?4RnWfnp4VNppcmc/MJfrr69KNBtUa5ccv0nD7S52rSPdJGHNFrn2xRrQLFtK?=
 =?us-ascii?Q?DtJ+zvHBabC+L/fysqKBqrPQRnqXnchX+nfNI0P9soCemQQdjCak+zf/G0C2?=
 =?us-ascii?Q?9P/KUqYIFJQfcankgZ90mD4mqZZ65mkCOyAJc4iBlHaUOkfJkOhJTnHAm9uy?=
 =?us-ascii?Q?0am+d/aUFObZwC6daBeboz/M/hmNPzS67U/EPKONJfpjcq3SUUk2bGstZu6Y?=
 =?us-ascii?Q?Nt0wUoDMNkDAouUigNGhX5Q61/kZZehNA/31SZGLjbxaIgsIgdJ1emJtuKW6?=
 =?us-ascii?Q?Hm9nuuRXsix+zbkORwkIZht5+/krOco58rNd/wRdvjHkatzkIBNlReUI6wYJ?=
 =?us-ascii?Q?NuvAYqrZVIEsEU4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 08:52:53.6042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372a36cc-6bcf-4821-9e88-08dd2a41adfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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
  - Allocate memory with GFP_ATOMIC.

v3:
  - Moved to 2 xa approach.

v4:(Christian)
  - Lock the xa_for_each blocks and memory allocation part
    as well to make sure that xa is not modified in between
    the 2 xa_for_each blocks.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2e7271362ace..5bc86ba77437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -229,23 +229,25 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		unsigned long index, count = 0;
 		int i = 0;
 
+		xa_lock(&userq->fence_drv_xa);
 		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
 		userq_fence->fence_drv_array =
 			kvmalloc_array(count,
 				       sizeof(struct amdgpu_userq_fence_driver *),
-				       GFP_KERNEL);
+				       GFP_ATOMIC);
 
 		if (userq_fence->fence_drv_array) {
 			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->fence_drv_xa, index);
+				__xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
 
 		userq_fence->fence_drv_array_count = i;
+		xa_unlock(&userq->fence_drv_xa);
 	} else {
 		userq_fence->fence_drv_array = NULL;
 		userq_fence->fence_drv_array_count = 0;
-- 
2.25.1

