Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3876FD41D68
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 17:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C642110E88C;
	Thu, 11 Dec 2025 17:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L46WSDpT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD91B10E88B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 17:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqoB9y1HYSttJU79eW7QvZuBq6Psjo7wfLIpLzIVw8iEDbeOoOIZHGz9rXthOCOz4ynt+2V251wMClWIC2cQ/23OdpWZjKdOPLqqHYePU6aqexCSNrgS4o5LqZKB+N+ekr8oUCz4a/EfCE4mNFyDpV2sTYSFAPfhGvjWAT1JUh1jmyLjzPAXK5MOoLREKYhGS5Uhq0t2bN5gmMWe1NWrLybgj7W7mNEJ03CeHqCnYlEC/BWWkPPGbhkLMzh4qfEYJmn5GIoH0DodXGADcE+qIeozUBpzZu90v1wibQAOONSTCEtdAZL186G9oIjl4Xz3rQ/jO796Rq2ZQ8QLhj0IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pprWKswP2A1IpSf6JBUR1X48EDNad1eNWcuVfPJnsOE=;
 b=FwrRjwCeLc6ao0t/XNwbY56uG3vbH9NdgWM/04LCC7Tc97tICoH6RNaLbyQECYdAlXOLSkxwHvKTaDc0gt6Awpk0Q2n8vZ+6CFZPSCiKIBxsr5bVGmj6qCbaThniMXr65qUN19dACWxkypDdt0GK/43jQIXBw4o5ILF6jdDNA8XXuOCTRsBG8+ylUwbNjol5lDS1KL7pkgbICHoGmWcZUKu+i6UoYvzQweNwPL4bDpebBDib6I4akdufP7jwtbEW0f7jQq5q3pTXhiVDYX5waiPdb22uVtXEgmsH7asSpQ3C9K4RnG2T4HnaL1iYVyGaskbZDPzSLHEGgM7Kw2NfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pprWKswP2A1IpSf6JBUR1X48EDNad1eNWcuVfPJnsOE=;
 b=L46WSDpTMVlyLp8v0P9LuDVbn0xEM4o7ISBA6AWp97rqc9JZgW7iC6ZM3R1pnuFXompkWkKLX/01RaM55ezPyR5w9BwZXzmymmXMm6SWXdyBfL8X/qpLUWkXPynCLyns0vl45ZqBxg2XpbPiMCswhG50l0hcKvUSMxThTHqO5pc=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 17:45:15 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f8) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Thu,
 11 Dec 2025 17:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 17:45:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Dec 2025 11:45:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v4
Date: Thu, 11 Dec 2025 23:14:49 +0530
Message-ID: <20251211174449.558477-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520045410.3404517-1-srinivasan.shanmugam@amd.com>
References: <20250520045410.3404517-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a50465-f18f-43e6-e9cd-08de38dd0a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU51SGdWRi9EQ0hyYnR3eWRtTWFCekxTYWk0RmpraysyRGRDOHEvaVZkM043?=
 =?utf-8?B?VnFxaWRsbG1oV21KTGY3TDFCVnhwVCtKQW5hb2FzSUgza051clN2aGN6RTAr?=
 =?utf-8?B?WWVnWjJUbVg3NXJOcnQ0RHZZWWE3WE0zTjFTeS9HY2ZOdlYwSjlBeVYwSzZD?=
 =?utf-8?B?bHYwK0JpWDJtQU9vTlNUT055Q2Vpc080K2FzWVNZSWpUYS94YUJzQVZjMS9E?=
 =?utf-8?B?RnVDMkYzeWpWVjduM2w0TlluVEEzMzZnTFJRWDZrUkMyN3pZVVk1cEtTOGN2?=
 =?utf-8?B?Q2pvYlVxMzdyZE14SlVHT29zaXlwTTVrTjBxcHIwOFdQakMvMzJsak9YeCtL?=
 =?utf-8?B?dVBPakpBeTd2dUZqaW9tbzYyUjRpV3poRUlRaHh3WGlJNml2WTh5ejBWMkp3?=
 =?utf-8?B?ZE42Z1lTMEpsVVJWUEdXd1R5QUJSOE1HeW45VmhRT0FTeUtIeGhSYkM5bHZO?=
 =?utf-8?B?KzhoT09KaXptUGVzcDgvZnc1OGNqd3prSE5KK0FIaGNpc1FDSDV2S1loeTZD?=
 =?utf-8?B?VmdBenRpdmZRYUtQL3IweTNScWwxMklFY3dweGJzWm1FbWVGa3BjblRlMDNY?=
 =?utf-8?B?VVZFek9vU1ZraU9aMHFHVW5tcUpFVTJpMUIrYzdFQlhWb25jclBQM1E4cW1G?=
 =?utf-8?B?QUd1YTNQYUVkRTh5VUxoK0trNFh6enNDaGFvNkJnZ1JBanBGVnJjdmtuYWNu?=
 =?utf-8?B?QlpHWnBBbnRCTlZTMlZIeVoxQVFTVEpyQkIyZzhYaW1sTUF5UjdFQ21SdlB5?=
 =?utf-8?B?QlhHenhZZEFFQXVESWNGK09jK2FhWjVuVEhoNnpEN20vR2FpRVZrSzBLM3hw?=
 =?utf-8?B?ZGtXc1RMeVF5MW44VGdnQnBlUVlEeVlDNlFCLzlGd0J0OE9NWCtRUGNCN1E2?=
 =?utf-8?B?dk9telBTVloxVStLVU53OGdBSitWN1hjSnI2T2ZEZ3grRndnVlFHZTdjK0VP?=
 =?utf-8?B?WVRkN3Q3UzJuWHptZ0Q4NmdUS1A4R3ZCdnVIUkhwMDVKK2lIcndZeEVQSGtn?=
 =?utf-8?B?ZVFmcUg1emdzS05tVUpVcWlSaXNoeVl4ZTlZbFE2dCtST05tY2VKMmQxMmRP?=
 =?utf-8?B?Zjd6Q0J6U2ZvQVhpQmdtM2UrSkhidFdqZEJad3hMdE5oMGRKdmhiYWYxTUxB?=
 =?utf-8?B?VHdJZEQyZjF0ZmtkRWRhekZZTjJRU1ZVQktOOUZHb2ZVWENuclBsYnZlL2VC?=
 =?utf-8?B?R1dHOEovaHZoK0xqNytuakYvZmJPN1hENUhGN3ZUMEdFSUZTL00wcUF2TmFT?=
 =?utf-8?B?QmRxQTRIc2VLbkRaQ1loVHBSa1dYMVF3WkpWRndrOWVWanZJckhwdDBFNUty?=
 =?utf-8?B?bjM1a3JtYWJkeTJJdGQ5Mmc1Wm1PVGZhRWg3SmdjclN6WmtJUm1PUzd3OHI1?=
 =?utf-8?B?em55WnRQUDFCSytpWFR1VHBJelpidVlzbGFjVXRFTXJqUWkrWHNVVWZ0Rkt5?=
 =?utf-8?B?bGpPUWFLQmFzOFgzSm9ZMnNPeHloOGI2Wmdud3h1Z1g3ZTRPR08wOXZUd3R6?=
 =?utf-8?B?ZzllVHVBeDlXbmlHZWZnT0FML2wxMExOVEJPcHJEQUJFWDFZMFdDK3I5YXF6?=
 =?utf-8?B?UmRlQStkR3F3L1NwMDUwZGtGUWIvK2tkZEY0OVl2TmtvcCtVc3RCWFovTndk?=
 =?utf-8?B?N1U5ZHpQOWFqNmRQdEZCalk2UEh1VDAwSXJncnhaanJOZnRYWEJXZlJ4MGFK?=
 =?utf-8?B?SFE3VklvdkppRlQ5cUJrUlR6QmZ2UmpLVlNSdjFudVRGUmhuYW9LR2k5eXAw?=
 =?utf-8?B?T0RBbitOU0crOUxNcVVkWTFOTUtjQTJIN1MxckU4ZjFXWlA4RWV6bDZLUFQz?=
 =?utf-8?B?L2NRdE5vTGFSRzFvWmdKZDlWNlRQeGQ5MW51UnphdXlOcFZNSGJxZXZIYkdN?=
 =?utf-8?B?bERoOCtybDBBZmNnbUYybExHR3NkR2M0UEFQdlNDaDI4dkNkSnQyUGQ3K1dC?=
 =?utf-8?B?QW14YkFvdWlRRjEwSURSNVAwdGtjS2MwT29MSm1kUVdSMmcwS1ovQVlLcGVp?=
 =?utf-8?Q?3DLrJSjY5WOwuSRO8vqTpelQjulYUE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 17:45:14.2480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a50465-f18f-43e6-e9cd-08de38dd0a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

This commit simplifies the amdgpu_gem_va_ioctl function, key updates
include:
 - Moved the logic for managing the last update fence directly into
   amdgpu_gem_va_update_vm.
 - Introduced checks for the timeline point to enable conditional
   replacement or addition of fences.

v2: Addressed review comments from Christian.
v3: Updated comments (Christian).
v4: The previous version selected the fence too early and did not manage
    its reference correctly, which could lead to stale or freed fences
    being used. This resulted in refcount underflows and could crash when
    updating GPU timelines.
    The fence is now chosen only after the VA mapping work is completed,
    and its reference is taken safely. After exporting it to the
    VM timeline syncobj, the driver always drops its local fence reference,
    ensuring balanced refcounting and avoiding use-after-free on dma_fence.

	Crash signature:
	[  205.828135] refcount_t: underflow; use-after-free.
	[  205.832963] WARNING: CPU: 30 PID: 7274 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
		...
	[  206.074014] Call Trace:
	[  206.076488]  <TASK>
	[  206.078608]  amdgpu_gem_va_ioctl+0x6ea/0x740 [amdgpu]
	[  206.084040]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
	[  206.089994]  drm_ioctl_kernel+0x86/0xe0 [drm]
	[  206.094415]  drm_ioctl+0x26e/0x520 [drm]
	[  206.098424]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
	[  206.104402]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
	[  206.109387]  __x64_sys_ioctl+0x96/0xe0
	[  206.113156]  do_syscall_64+0x66/0x2d0
		...
	[  206.553351] BUG: unable to handle page fault for address: ffffffffc0dfde90
		...
	[  206.553378] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
		...
	[  206.553405] Call Trace:
	[  206.553409]  <IRQ>
	[  206.553415]  ? __pfx_drm_sched_fence_free_rcu+0x10/0x10 [gpu_sched]
	[  206.553424]  dma_fence_signal+0x30/0x60
	[  206.553427]  drm_sched_job_done.isra.0+0x123/0x150 [gpu_sched]
	[  206.553434]  dma_fence_signal_timestamp_locked+0x6e/0xe0
	[  206.553437]  dma_fence_signal+0x30/0x60
	[  206.553441]  amdgpu_fence_process+0xd8/0x150 [amdgpu]
	[  206.553854]  sdma_v4_0_process_trap_irq+0x97/0xb0 [amdgpu]
	[  206.554353]  edac_mce_amd(E) ee1004(E)
	[  206.554270]  amdgpu_irq_dispatch+0x150/0x230 [amdgpu]
	[  206.554702]  amdgpu_ih_process+0x6a/0x180 [amdgpu]
	[  206.555101]  amdgpu_irq_handler+0x23/0x60 [amdgpu]
	[  206.555500]  __handle_irq_event_percpu+0x4a/0x1c0
	[  206.555506]  handle_irq_event+0x38/0x80
	[  206.555509]  handle_edge_irq+0x92/0x1e0
	[  206.555513]  __common_interrupt+0x3e/0xb0
	[  206.555519]  common_interrupt+0x80/0xa0
	[  206.555525]  </IRQ>
	[  206.555527]  <TASK>
		...
	[  206.555650] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
		...
	[  206.555667] Kernel panic - not syncing: Fatal exception in interrupt

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/654669/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 135 ++++++++++++++----------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9b81a6677f90..e5fb8f5346b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
-static void
-amdgpu_gem_update_bo_mapping(struct drm_file *filp,
-			     struct amdgpu_bo_va *bo_va,
-			     uint32_t operation,
-			     uint64_t point,
-			     struct dma_fence *fence,
-			     struct drm_syncobj *syncobj,
-			     struct dma_fence_chain *chain)
-{
-	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct dma_fence *last_update;
-
-	if (!syncobj)
-		return;
-
-	/* Find the last update fence */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
-		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
-			last_update = vm->last_update;
-		else
-			last_update = bo_va->last_pt_update;
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-		last_update = fence;
-		break;
-	default:
-		return;
-	}
-
-	/* Add fence to timeline */
-	if (!point)
-		drm_syncobj_replace_fence(syncobj, last_update);
-	else
-		drm_syncobj_add_point(syncobj, chain, last_update, point);
-}
-
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -773,16 +732,19 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			uint32_t operation)
 {
-	struct dma_fence *fence = dma_fence_get_stub();
+	struct dma_fence *clear_fence = dma_fence_get_stub();
+	struct dma_fence *last_update = NULL;
 	int r;
 
 	if (!amdgpu_vm_ready(vm))
-		return fence;
+		return clear_fence;
 
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	/* First clear freed BOs and get a fence for that work, if any. */
+	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
 	if (r)
 		goto error;
 
+	/* For MAP/REPLACE we also need to update the BO mappings. */
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
@@ -790,13 +752,59 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			goto error;
 	}
 
+	/* Always update PDEs after we touched the mappings. */
 	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		goto error;
+
+	/*
+	 * Decide which fence represents the "last update" for this VM/BO:
+	 *
+	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
+	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
+	 *   (for per-BO updates).
+	 *
+	 * - For UNMAP/CLEAR we rely on the fence returned by
+	 *   amdgpu_vm_clear_freed(), which already covers the page table work
+	 *   for the removed mappings.
+	 */
+	switch (operation) {
+	case AMDGPU_VA_OP_MAP:
+	case AMDGPU_VA_OP_REPLACE:
+		if (bo_va && bo_va->base.bo) {
+			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
+				if (vm->last_update)
+					last_update = dma_fence_get(vm->last_update);
+			} else {
+				if (bo_va->last_pt_update)
+					last_update = dma_fence_get(bo_va->last_pt_update);
+			}
+		}
+		break;
+	case AMDGPU_VA_OP_UNMAP:
+	case AMDGPU_VA_OP_CLEAR:
+		if (clear_fence)
+			last_update = dma_fence_get(clear_fence);
+		break;
+	default:
+		break;
+	}
 
 error:
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
-	return fence;
+	/*
+	 * If we managed to pick a more specific last-update fence, prefer it
+	 * over the generic clear_fence and drop the extra reference to the
+	 * latter.
+	 */
+	if (last_update) {
+		dma_fence_put(clear_fence);
+		return last_update;
+	}
+
+	return clear_fence;
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -822,6 +830,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	/* Validate virtual address range against reserved regions. */
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
@@ -855,6 +864,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Validate operation type. */
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_UNMAP:
@@ -878,6 +888,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	/* Add input syncobj fences (if any) for synchronization. */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
 				       args->num_syncobj_handles);
@@ -900,6 +911,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			goto error;
 	}
 
+	/* Resolve the BO-VA mapping for this VM/BO combination. */
 	if (abo) {
 		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
 		if (!bo_va) {
@@ -912,6 +924,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	/*
+	 * Prepare the timeline syncobj node if the user requested a VM
+	 * timeline update. This only allocates/looks up the syncobj and
+	 * chain node; the actual fence is attached later.
+	 */
 	r = amdgpu_gem_update_timeline_node(filp,
 					    args->vm_timeline_syncobj_out,
 					    args->vm_timeline_point,
@@ -943,18 +960,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	default:
 		break;
 	}
+
+	/*
+	 * Once the VA operation is done, update the VM and obtain the fence
+	 * that represents the last relevant update for this mapping. This
+	 * fence can then be exported to the user-visible VM timeline.
+	 */
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 						args->operation);
 
-		if (timeline_syncobj)
-			amdgpu_gem_update_bo_mapping(filp, bo_va,
-					     args->operation,
-					     args->vm_timeline_point,
-					     fence, timeline_syncobj,
-					     timeline_chain);
-		else
-			dma_fence_put(fence);
+		if (timeline_syncobj && fence) {
+			if (!args->vm_timeline_point) {
+				/* Replace the existing fence when no point is given. */
+				drm_syncobj_replace_fence(timeline_syncobj,
+							  fence);
+			} else {
+				/* Attach the last-update fence at a specific point. */
+				drm_syncobj_add_point(timeline_syncobj,
+						      timeline_chain,
+						      fence,
+						      args->vm_timeline_point);
+			}
+		}
+		dma_fence_put(fence);
 
 	}
 
-- 
2.34.1

