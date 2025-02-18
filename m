Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B30C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 14:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B88210E719;
	Tue, 18 Feb 2025 14:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jGprQ2l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EB310E715
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 14:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm4ZBeR5iVKfICHu0D2qFbMkoU/tDXOLLXJh5xY6zybGW512Jdynb867FeN3OdQ5Tnuk0jC6poh+3Yliv8SlO6s5M2vQCprNYyHZ/dFYsBMyTT3QaFT7lxkKKfgcizVqfw67YE4Afq/f6Rg5GUtFyXtDMmkx6TXl/JE2xTYauUj/+MKN4fh+28TRmlXNmJ5YLqgKax9/K5/Pa3YBD8MW1I/6P6LOFkewpuhPkGBSIBwQxAqIU1ezk9KULeUbppckxPJnyQLY6Yz+Ww3Rqt7WuvwXXRK2PPGu0+XKDeuDjVscmr45zptu0QeCg6Az9j1iLx3LnTC0YoYz9H277InPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bclXo+iTVhK8NIgDuREikrnM+A8CQbtRi8PZmxSMCWg=;
 b=kztrP664KC4fORoGHSmye5tw31EMZRrQ3hyBtXvZ9cKoJQNwoXc/b5D6PEg5RP60Fpb2c7pk9puSlWKVj8Ix2XG8yXwAoon+soyhU64YRKgUkuuRUMAR78WKzKaDi6q2DVJQa0OICwBzUX0xP4wM/MZdHsocGbr+bcm7O4txaxjHREolDTfmBGgPY0S9faXCJ/5xuZQLRzhvCmyeXxPmPc6uFZ+37lnr4XAYbd75mzVFdcvHXqmVyFHEM4usHkrlUwBrnHFq7gYOGFbINji7A9sGyJ/WqYRtpaLIBdlfj5B0FehaKVoltoe2kburn1cKM7bAIZL5cpoS856DFSP+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bclXo+iTVhK8NIgDuREikrnM+A8CQbtRi8PZmxSMCWg=;
 b=5jGprQ2lMnhFQ5kezGcUCiUeDs6CIDuVoVMy2Y9L+NsCNQo/OuWUDiWTdv/8KTYFr3Xr9efLwyUj6QtbATZTrU05q2lsfr951xdmbPgfEOGtBWo6ihLyoXdngaamTOO/yAQENnCH3+vbVOPX/6PcSVhVZ/AELhkRFygZewQkVCA=
Received: from MN2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:208:236::34)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 14:53:51 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::9a) by MN2PR05CA0065.outlook.office365.com
 (2603:10b6:208:236::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 14:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 14:53:51 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Feb 2025 08:53:48 -0600
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <sunil.khatri@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Le Ma
 <le.ma@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix the memleak caused by fence not released
Date: Tue, 18 Feb 2025 20:23:22 +0530
Message-ID: <20250218145322.1500-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 95328320-4f50-4336-5bbf-08dd502c0efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGRSbVFVQUl4Uy90NkNjeXhBU2JSajliUG8rSXg2UUtSWWR2N2drV3pVR3NQ?=
 =?utf-8?B?UnBjT2p0U2hJNU5jMUtHV2hDUktXTkkxT1RVOC84MXlGWWtreWwxdTk5Qkxz?=
 =?utf-8?B?cGpjT2ovMUpFbUtOenUybmNCOWlaaUhvL3hVc1l2cVRkbE83V0E0QWM5RnNx?=
 =?utf-8?B?SHkxTVR0R25pTEE5a1BralFMUnVrUUR5ZEtKalJTMUUrUlMzUjQ5c29BQWpx?=
 =?utf-8?B?ZU54b01xeTJlMUhwUVJFenArendFSVNqWmgwNGd1YjE1Ri9VVkZyNkVENjZr?=
 =?utf-8?B?Q2VKR0M0Yi9ad2VVSEYxVVAwRm5JUTMxbERyK1p5SEduMFRPV2xjdDhOdHE4?=
 =?utf-8?B?L204Z1R3SDBSTDkrVjBKNGdHS2QrbDRrYlh5dlN3SVBHVm5XVGNCWDZRWUg4?=
 =?utf-8?B?S04xWDNOWXY3eFRZQkdBcmZMd2FXM3pSSmF1aHJVM0NDTForVSs1ZWlEdEhV?=
 =?utf-8?B?ZWcxZXRPUGNuR1hLeEo2NGNnUUo5dVNqNXBkMUF3LzlMMmVtM1N5NGVROW1S?=
 =?utf-8?B?UjlyVjFNZWxoVkdzeHBod3BzMnI3SXhJc0pqVmpxU0lyZ3c3NnAxQjAxbnJK?=
 =?utf-8?B?Z2FuczZPd081c0VTdGZTY0tJa1BWMi9YbVRCNVpnVGhhemtXMlZValQxN291?=
 =?utf-8?B?WHExRFk4UFFsQUFMaUdHQTBCc0tocHluai9ZZ3JlSXlsM1NIMjdFbGZqM0Ry?=
 =?utf-8?B?czJXellvekh5OUdEMWRQV0pLVXdkUWlIdW4rdE1XbURRWERjb3RvTnhyTlB6?=
 =?utf-8?B?SkNTU2dvR3dmMHFVS21PUzRrN0gyOEM5Umo2eHBDTUtQRE93MnlUR2ZSNVNS?=
 =?utf-8?B?M0hkNFBOY2xLQVhRQWQ4QnRHSzBXelNCOU03aU16cGRRV3pmb1RlbmZqYTVR?=
 =?utf-8?B?eVZLVFZscVEwVFdMSTVsTTA3YnA0aFIxbm45WTZ4QmJUMnJFN3BNdDhPclBB?=
 =?utf-8?B?Z3VRVittZUVjZkQrYW9nWUowR2NtQkorOG1HR2h3YzBCVnZjR01TbEFORVFN?=
 =?utf-8?B?alBBYmJwMlFhOXUzc1FPVzhKWldVdTZtY1ZobGVQZEx4b2ZaUjRVQU9nNXBD?=
 =?utf-8?B?dSt0bFliY3RwMk5IeUpWMDMwL0JUa2lDNTNpTXFMYTRaVnJHNTRMaVpkYmVK?=
 =?utf-8?B?Y3Z1WW9JS1RtSHhSQU5jMGdYVW5xempTMVBHMlFaem90dFJLeERvK2RmOXhk?=
 =?utf-8?B?QlU1WUc5SFhlRnk2bDE1dG1SQ01Vbmo1QUVFeThpdnlwSThLeGFDRm5tQVh4?=
 =?utf-8?B?L2MrV2dQN2F6WG5ZOHU1SG1ubU9oYjZwdjZ3ZjRuRUZsVXpvZlA4R3Z2d0l2?=
 =?utf-8?B?Snp1MUYzcCtwcE93b2ErbndROHdqT3F6bFhjZEg4SDNaUkVvbTZ6SVhjUGp2?=
 =?utf-8?B?UklhY0tEWVRoeFdnOEVlTkVXdk5vWjVCMkNBaVVZUytoS21VN3o5VlRtS0U2?=
 =?utf-8?B?VWRwdmV3VWhqNVFvUlgyRll1N3BMMThFMWpvQzFMNzFZZlkzZTZSVHpZbG5w?=
 =?utf-8?B?WUs5dklvYVVKSXN6cm05d2xxQmo1dFBLVmlkdlpOTjRiL3JPYktUeDFWOWl5?=
 =?utf-8?B?eTBLQmFieTZibTA1aWIrU0lKVmJXYnArQnBzL3AyS3RiSjJTZHRJZytsUW9t?=
 =?utf-8?B?d0xBU0FUeCtnZGdXMzBJM0h5dHdDS0tQYmd3bzQzck9jYUtBNDRxMXM0eHRP?=
 =?utf-8?B?cVdGVUZIUlY2WEhuaXB0SmlCUU1GOVJHSy9UQkJWbUJCWUpTQ3V0dVdHUTRO?=
 =?utf-8?B?MDFBaEFJUytKVkF5OFNKcVRXY2l0MGFoM1FPeW0reHc3WEg0Wjh3OXR5VlpJ?=
 =?utf-8?B?UTlBZkErZ3ZKV3lqMzJtNEd3c010MEhGVmxDeEpTemNoRzM4NzU1OTdtRnB1?=
 =?utf-8?B?TTJOM25RTTJ2R1JCa0doaVhZclpnTWQrZUkyR2F0T09YdXhzb3kxa3Mwc0tD?=
 =?utf-8?B?U1dHZW53SlZFS0hzcDFURWhJZnVUNFBRM0MxWW9wdGY1MlV3cGpHOEdUTzVN?=
 =?utf-8?Q?LVfO/BtpoEfJ+oBgHi4epNCmowkctQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:53:51.6343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95328320-4f50-4336-5bbf-08dd502c0efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

Encountering a taint issue during the unloading of gpu_sched
due to the fence not being released/put. In this context,
amdgpu_vm_clear_freed is responsible for creating a job to
update the page table (PT). It allocates kmem_cache for
drm_sched_fence and returns the finished fence associated
with job->base.s_fence. In case of Usermode queue this finished
fence is added to the timeline sync object through
amdgpu_gem_update_bo_mapping, which is utilized by user
space to ensure the completion of the PT update.

[  508.900587] =============================================================================
[  508.900605] BUG drm_sched_fence (Tainted: G                 N): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
[  508.900617] -----------------------------------------------------------------------------

[  508.900627] Slab 0xffffe0cc04548780 objects=32 used=2 fp=0xffff8ea81521f000 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[  508.900645] CPU: 3 UID: 0 PID: 2337 Comm: rmmod Tainted: G                 N 6.12.0+ #1
[  508.900651] Tainted: [N]=TEST
[  508.900653] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
[  508.900656] Call Trace:
[  508.900659]  <TASK>
[  508.900665]  dump_stack_lvl+0x70/0x90
[  508.900674]  dump_stack+0x14/0x20
[  508.900678]  slab_err+0xcb/0x110
[  508.900687]  ? srso_return_thunk+0x5/0x5f
[  508.900692]  ? try_to_grab_pending+0xd3/0x1d0
[  508.900697]  ? srso_return_thunk+0x5/0x5f
[  508.900701]  ? mutex_lock+0x17/0x50
[  508.900708]  __kmem_cache_shutdown+0x144/0x2d0
[  508.900713]  ? flush_rcu_work+0x50/0x60
[  508.900719]  kmem_cache_destroy+0x46/0x1f0
[  508.900728]  drm_sched_fence_slab_fini+0x19/0x970 [gpu_sched]
[  508.900736]  __do_sys_delete_module.constprop.0+0x184/0x320
[  508.900744]  ? srso_return_thunk+0x5/0x5f
[  508.900747]  ? debug_smp_processor_id+0x1b/0x30
[  508.900754]  __x64_sys_delete_module+0x16/0x20
[  508.900758]  x64_sys_call+0xdf/0x20d0
[  508.900763]  do_syscall_64+0x51/0x120
[  508.900769]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

v2: call dma_fence_put in amdgpu_gem_va_update_vm
v3: Addressed review comments from Christian.
    - calling amdgpu_gem_update_timeline_node before switch.
    - puting a dma_fence in case of error or !timeline_syncobj.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 33 +++++++++++++------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b67aae6c2fe..40522b4f331b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -125,9 +125,6 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct dma_fence *last_update;
 
-	if (!syncobj)
-		return;
-
 	/* Find the last update fence */
 	switch (operation) {
 	case AMDGPU_VA_OP_MAP:
@@ -839,6 +836,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct drm_exec exec;
 	uint64_t va_flags;
 	uint64_t vm_size;
+	int syncobj_status;
 	int r = 0;
 
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
@@ -931,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	syncobj_status = amdgpu_gem_update_timeline_node(filp,
+					args->vm_timeline_syncobj_out,
+					args->vm_timeline_point,
+					&timeline_syncobj,
+					&timeline_chain);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -957,22 +961,19 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
-
-		r = amdgpu_gem_update_timeline_node(filp,
-						    args->vm_timeline_syncobj_out,
-						    args->vm_timeline_point,
-						    &timeline_syncobj,
-						    &timeline_chain);
-
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 						args->operation);
 
-		if (!r)
-			amdgpu_gem_update_bo_mapping(filp, bo_va,
-						     args->operation,
-						     args->vm_timeline_point,
-						     fence, timeline_syncobj,
-						     timeline_chain);
+		if (syncobj_status || !timeline_syncobj) {
+			dma_fence_put(fence);
+			goto error;
+		}
+
+		amdgpu_gem_update_bo_mapping(filp, bo_va,
+					     args->operation,
+					     args->vm_timeline_point,
+					     fence, timeline_syncobj,
+					     timeline_chain);
 	}
 
 error:
-- 
2.34.1

