Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11554C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B93C10E446;
	Mon,  3 Mar 2025 14:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DaN5WYOu";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BA410E22F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 14:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqL2IEn/tKmSYBxMWkZNt7wDbfqMy9nWAlYnLkCjZ65KbEOCabFR7PKosNJIR70nADrObJD8f5cwXtFIwzpMa0UVCuNW+hdZF+m6HQdrUNRsFzITdi5whLhmQzeyOPwyEIdjXyiXdbweJVs9GV59jZrxVmj1vYK1mEV3i9zl/Lc7MlyhUsRIoggu4mKkNHNz3XoZwsb2jDRzBBLK65wdBKzDuCl1vBlXEu3CvU9w2OEJ/+QU+vzY0NDElkrxgXe7qzMJMLUtsPC8k3Vk0Ocp+GXEnGWt9XMsm3cKLWQ6ifs5k6l1YkvWX/xbPQf4qZjnHC9PRg2/Y4KXLFnMxhaUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjq6vhZ/DPpptnrLfIRRYVUW6LZtzhwltsSO3/yTeEo=;
 b=aiCy5T2hqgyoSrgerq6vmWeaquC6MRNNO1ot1HjWieq+MU34QEUBaNXoTBzX8k65qAcF9UmkZb7Q+IV2b5SoL0L2Wkfsgq5v4lI5cXm+olR8Ygw9T6XB6EhUDoOfrjpU84PreeW27/Aak76o1IDApbUpUS1LiPrYa+NQYgERaRFrSvfR8UwRo9JD5Tzi7ZhrdvSmIoYHI1rY7o675vgoGlzRpjHjHKpO8L5IT/4iEDGbey44equiZ9MIrtkHalkvPWwrUkdbeERCF0HWL1L8Dhw1O7qVlM2tAcotrPby5WVry4OMjmEMSGCh9tF596X7W6fC5MQXUl6T/tB/e33/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjq6vhZ/DPpptnrLfIRRYVUW6LZtzhwltsSO3/yTeEo=;
 b=DaN5WYOu5bMu+fP7DsKwJ6dOuHGGKg6LwZao9JD490NHi3H3qDo/mMD92XFFUtrd7ATlniCOaI7Rz5WVrgFTDmEAZ3+U8SBanhN82zHLM2Obqs2o8lCawiKfwdhuaENgULdx13mHRjFLW5vWrv98dVLOrb+2WuQLm//HdOyGjZs=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 14:47:24 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::82) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 14:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 14:47:23 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Mar 2025 08:47:20 -0600
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>,
 <sunil.khatri@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, Arvind Yadav
 <Arvind.Yadav@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Le Ma <le.ma@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH v4] drm/amdgpu: fix the memleak caused by fence not released
Date: Mon, 3 Mar 2025 20:17:03 +0530
Message-ID: <20250303144703.5373-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 52226ad2-a9d7-4120-49b0-08dd5a624eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V29RU0RVNkY5OVVRbUczT2Q3ZWNXQVF1eTcyMkFFOGo2eGtWdHJmRmd4ZmI1?=
 =?utf-8?B?VkhPVStiSUc5Mmg2UGxQQ1FFeDFVSVUxQ21yL2NvNmQ3L3JmSU1YVEJLOFd6?=
 =?utf-8?B?Y1kxZ2txTHQ2dSt5YzRzelJ2YTUzaC9SQmZta3pEclcybGplTDNCN2cxSXZY?=
 =?utf-8?B?Z0VURk1XZzVtMnlmY3J6S0JabGdLRjRLYVd5WUhPQS9PaVBSQ2w2VGJmRmVU?=
 =?utf-8?B?ejAzcDVhYjd1dGJuZU1acHFIZEUyZDhzODZCU013emRORFhmZlhucFZnanZL?=
 =?utf-8?B?cE1PQWd2Y0JJek56c3AydUlPc1VuTnljczF0RnJYemNGbUtHMmptc0VFZHJU?=
 =?utf-8?B?QnJpek9tbzNLQTRhNndqU0dxOEFucWdhNVdxckszY0ZaRGxOQytMd05sMmJG?=
 =?utf-8?B?Z3plbjZRRitrTXJMK3dYSGxZeWZJcVVTL3pZQkFIbzdxSFlXZUh3NUFTTFBV?=
 =?utf-8?B?enY4aWw1SGs5OFdsNlBVVXc1YXN2STFaYnNDK2hldktXU09JZXNWS3Yya21x?=
 =?utf-8?B?SEJUUHFNR0x2ZzQ0VFQyR3BUYW5PQUVZOEFDVjQrRHdqSWMxN2grQmovMWpx?=
 =?utf-8?B?aXgyaC9kM3h0eXlvLzhZR3BxenB3MHhtZnBwTjY2MFI2Z3ZpZUdFRGR0UkQw?=
 =?utf-8?B?dEd4R3ZlUC9SZ1g1THFGZ3NydmtPY3JEczl1cXdlYUx5VVBaQWVseG5qZm1p?=
 =?utf-8?B?YjcxNGg2cTd2d3dGcXZQelhXVkY2Z1VxdnFnTWxZN2dsN3NhSTVxdU4zQlNN?=
 =?utf-8?B?UDh2RllIZno1LzZzbCtjdkVlTGFvUHc4dW5TOEtIL2NzL2xyL1BVUTF5WHpN?=
 =?utf-8?B?VjdkUnY2WkRpY1RyMllOVEtsYTUvVGJqZk1jMGZIUW51c0xRMW5uakIzMDVC?=
 =?utf-8?B?WXZoYVlQVjdlQmpXWHNsRGV3OW0weGFraldHdE14amx0QjhzVlFkVFJybVFW?=
 =?utf-8?B?YmlJeGJIcDN2dS9XNHFKN3NTUmEvQ3RWR0cwU3d6NXFYVWM2U1VLLzFuTU1R?=
 =?utf-8?B?dzJMRkZOcXNvS292aUpyaGc3ZHB6UXhUN1NCamxEajkwZWR3RzUxRy9MQUxa?=
 =?utf-8?B?czYvQ2xjUUpDdUk2aXVubTNIL0tHdUFqS3FiS2VocFhuNFJYbFNrWFNUZlVI?=
 =?utf-8?B?dVMyU3QrU1ErdXZrZmlNSWZZT1lIZ2dzOUVtM2hBcG05UGhZczV1U2R0TTJC?=
 =?utf-8?B?NTdTSyt1a3RnSUQ0dUhxVFlGY1Jpb2JZSjA5aU9ISzBXQWtpbThLZlFnOGZz?=
 =?utf-8?B?V3ZMVnZjUVdwSnBEOWdjaTdmejR5Sk9KUlRVbjVJTVdCcENCZGxaeE53aGdR?=
 =?utf-8?B?VkxqS2NvdWRneUJoVDliTi82R05USktaMnhqWVB4UmRTdUVnVExuU2ovQW9O?=
 =?utf-8?B?d0d6ZGdoMTVRSGZPK2RXK2c2em9UOUdQczBwVTUyVFN3NVRqWmJpWXhlbGt1?=
 =?utf-8?B?NjhYYTIvakFOQnJxbE15a2drTkc4dEVrVzBtZVpROXRzRFgzQ3dNcE1mcVlV?=
 =?utf-8?B?ck1yWm4xa2lGenVzelRCL2dxL1p3TXd1THZlMWNEZ2F4N0cySFFSRDFCUytE?=
 =?utf-8?B?Q003OXpzRUNvNklqUDk0TjhrTkl0WmxuTFFUeW5HLzhTanNnU3Q4bmxKUUdq?=
 =?utf-8?B?NzRob29kZzhHVm1GUmoydkFWVFB2VjhzOFBPdjdNZnkrUC94SkhSK3ZYV2Fo?=
 =?utf-8?B?b1QzUktvVHdiSElvdUwvSkJQVzZtZDhhQjk0Ymc4blVLVzhTZ3JxaXFPZzNy?=
 =?utf-8?B?RzFTUDU4azJURzdJMUovUmREUnhSKzdiNUdBU0VNUkYxQnh5R09CVlFRaTNz?=
 =?utf-8?B?UmtORnlaSDVaTkpDZDlGNDJkV0VIQjRGSU4yb1VIQ01zSWdaNHBjUnFhc0pq?=
 =?utf-8?B?WkdNcjVtMmNNeWNlcGV5UWgvZFVBVFpYMEFBVlcvOXNsS2pta3ZWb2ZIYWdD?=
 =?utf-8?B?VFhKTTR2eDZVS1FUUEpUMVBuQzlJV3Bzelh4aTM2NGZZWjdVdWxyM1NZTjE3?=
 =?utf-8?Q?tetESpJ+YA/RM/EyUAbz9HoqMrJifE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:47:23.3165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52226ad2-a9d7-4120-49b0-08dd5a624eed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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
v4: Addressed review comments from Christian.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b67aae6c2fe..c1d8cee7894b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -931,6 +931,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	r = amdgpu_gem_update_timeline_node(filp,
+					    args->vm_timeline_syncobj_out,
+					    args->vm_timeline_point,
+					    &timeline_syncobj,
+					    &timeline_chain);
+	if (r)
+		goto error;
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -957,22 +965,18 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+		if (timeline_syncobj)
 			amdgpu_gem_update_bo_mapping(filp, bo_va,
-						     args->operation,
-						     args->vm_timeline_point,
-						     fence, timeline_syncobj,
-						     timeline_chain);
+					     args->operation,
+					     args->vm_timeline_point,
+					     fence, timeline_syncobj,
+					     timeline_chain);
+		else
+			dma_fence_put(fence);
+
 	}
 
 error:
-- 
2.34.1

