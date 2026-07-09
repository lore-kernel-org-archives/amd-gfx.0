Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3168AC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 08:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EE710F467;
	Thu,  9 Jul 2026 08:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tv8LgBXv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C704210F467
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 08:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeM6L62S+5PX0b5oggDQhpNVBntWXDzRoVmj25qohYts8KETqX6DA2VI0Hs4Wu5fnMAjNNhtly4pcGBknQtJF/n7lmbDWnBYGO2rfUbNLf2tcQpnRMx+DCXm58RZlP83WxfTlg/ZOQlzSdZwkVebXY0bWLGIQQP8LgATks6NjUEoxmZb+Cwv2X/8uwEK+9WdiB1z0VuZ/dGIPVUF+kNuR8WDTsRG2GdJIFGyd8Vvkbv96HlVSjUraTlhkIsPxjdDSI/2CUL1J096caEgTSSzmnJOuvSSegi9NG85G1W0t8nqWg0CXA/Lz4JWRtWHgD6IrE6Wfh200kqW1TKn8sLiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNf5aZ8XmwrmNHq4sbL4QMSEoPlDYGquwvHy37uDFAU=;
 b=YKkv4yh4aEh6uX4sVyJVoy6KkEPf1gfUaw+YxgPhvi4NggcyRRdOYVwV//wgO319/eoZNPTduVQHCvzk4JpsV7KThcaZg+gobUmX1h89B47Lh6mKDuyyTIRxQbrHLFgcgZL5Q4qBpguD7R5Ou4n74EhiSqDYx+YcfhQcyerxv1kU3U/uZpumvCcvsMfdD//FU9Smwi0g1vENo23Wcli4ujrsOl384xAvye3dUubuXbnydaVEjO2aGtMbhF8FJKQyzsER6O9wQlKL6vxWiXbIIOUU2xl4zOcwgW/MhYsJjUkEcnf5GN7Nb6PrMWAoun3PklOHD/8ITDuB2NF4Rv9Ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNf5aZ8XmwrmNHq4sbL4QMSEoPlDYGquwvHy37uDFAU=;
 b=Tv8LgBXvzGPafjHy4cxUgn2YttO+y1GR64HElVzIHjh13gRYtW9U9pjqLcsKZP5aipylrrcAdZ/gqj+TZfHWFsvSOxIImgyupQdwetwbu0H0bWJB1Uo4v4x5rmWM7OL+XB+JgCUInywk4TeyEcNGJfeUWrB/kx2oQ9q691aEHEQ=
Received: from SA0PR11CA0020.namprd11.prod.outlook.com (2603:10b6:806:d3::25)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:04:02 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::70) by SA0PR11CA0020.outlook.office365.com
 (2603:10b6:806:d3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 08:04:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:04:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 03:03:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 David Francis <David.Francis@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all
Date: Thu, 9 Jul 2026 16:03:34 +0800
Message-ID: <20260709080353.1896894-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d45c85-4cce-4d69-be57-08dedd90a31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FBgQK10LqPpZo2xMMR4Fuyemf/0KNgivk8Zevm2f3JfzQoSepAhhTmugFHsoeRhVDMv8rOFp3w1UR3QEnMNAXVgA8EFZ6l52ZEPtw8KilewQ782DtrMSdYCHIHQYttm9FSDiMrTivKJbU8wu1Z9RRzseAvD2qXQcgwUdaB0IbA95gZwmhW6b6n/khQtvHjVaw2OYfEMG5Y+4sFvtQ0kr0iRrG7OiOpbmuKodGifE26Q4Cs1voxJvx/V6aQsM7MWxSOVStn/7aoLQ6nTcDNG4Mwg3lXPmKM9JJ/1i4wmJeuEuKZ2MuDbZZKjvxI+9EPiIvfiOBtwTKslb7ZJk4QNWsPNnPOy18Kwh/wYRHMyvmZn/Sa941MDHn6uQRliZFwUySgRACe0a5CzcmsSziGK9FP9Z981WjbVj9ZcVMfBP8sne6SMf6VqMb91Im6SBYLpwGUbK2qeYxdfg38VSH+JJjI+VgP9JStvwPX/xqls1psH7fJXOUDjXtZTXHuUfnBHSvoMpy3yhjGv/Tbyf4gZJNAsB6GGt/9zx/vfMtWUBj4rzzpV1h8tE7lYkMJfWiXW73vnjVWZROCM8r4t0Akx5XgIixhIsItAq59GNAtFrxzsR5TjgHbxZoq9/6BlpV3Rm41guTh8TQ5ymIrQnAbwNikUUMGcoWI6SYBnHpSGyuPRo6gIaxx3KUd7/YefFaI6hZ0ZGAE/n6A530g3RGxELhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yOdtcAhoUqvNc5V+Xk+r/4nHbu8xN5eySgf3okUjgqxDnt4NRDvp67d2VMVzyeCAPt13QcG+PlethbB5dXNvtI524ZZnnlgXn+SuO/l5Qo7Tg94y+jCgyo2YMbouAFXFZWlERQc7nmY7VOPo45HCgV6lsxdn4drWoV2WadWE9gZA2p0dQeBOA3rQB5pm3cgO2/iWgSqpeY1JOBitbfApDTeFTYWIQbqgO6LQXwT6zkU7qEANHf8cu3pewYtjc8TVO1+1fZh5DMwjBhYVp8jiWddffzc2DhKmj7p/79oKrS1m/Cr6NvX5npgIk5IpM1mTGNhlI/a9WyFRshR/wZYWGQ0y6oZbCEujL56+H9owq9zAg4V6uGZFbUKVMs8fJKkr/ZblHPsZ7zhAcPjv1uW4MrKZYFIJrOXxGk7l1ykR0IdAssrCk90g9nE2w1pCFrZt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:04:01.4367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d45c85-4cce-4d69-be57-08dedd90a31b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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

amdgpu_userq_evict_all() dereferenced queue->fw_obj.obj->vm_bo->vm to
reach the process VM when bumping the queue eviction counter. The fw_obj
is a kernel-allocated, GTT-pinned firmware/MQD buffer object that is
never added to the process VM, so its vm_bo is always NULL. On the first
eviction of any user queue, this faulted:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2941.106372] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
[ 2941.106585] RIP: 0010:amdgpu_userq_evict+0xc7/0x140 [amdgpu]
[ 2941.106729] Code: ff ff ff ff 48 c7 45 d8 00 00 00 00 e8 92 5b 02 f7 49 89 c4 48 85 c0 74 62 45 31 ed 49 8b 44 24 78 31 f6 48 8b 80 60 02 00 00 <48> 8b 38 e8 c1 b8 ce ff 4c 89 e7 e8 19 db ff ff b9 08 00 00 00 48
[ 2941.106739] RSP: 0018:ffffd4bd485fbdc0 EFLAGS: 00010246
[ 2941.106743] RAX: 0000000000000000 RBX: ffff8e5bd3358cb0 RCX: 0000000000000000
[ 2941.106747] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffd4bd485fbd58
[ 2941.106751] RBP: ffffd4bd485fbde8 R08: ffff8e5bdd888000 R09: ffffd4bd485fbb38
[ 2941.106755] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8e5bd2820c00
[ 2941.106759] R13: 0000000000000000 R14: ffff8e5bd9cf7360 R15: ffff8e5bd3358cb0
[ 2941.106764] FS:  0000000000000000(0000) GS:ffff8e5f342c9000(0000) knlGS:0000000000000000
[ 2941.106769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2941.106773] CR2: 0000000000000000 CR3: 000000001d840000 CR4: 0000000000750ef0
[ 2941.106778] PKRU: 55555554
[ 2941.106780] Call Trace:
[ 2941.106783]  <TASK>
[ 2941.106787]  amdgpu_eviction_fence_suspend_worker+0xd8/0x160 [amdgpu]
[ 2941.106898]  process_scheduled_works+0xa6/0x420
[ 2941.106904]  worker_thread+0x12a/0x270
[ 2941.106907]  kthread+0x10d/0x230
[ 2941.106911]  ? __pfx_worker_thread+0x10/0x10
[ 2941.106915]  ? __pfx_kthread+0x10/0x10
[ 2941.106918]  ret_from_fork+0x17c/0x1f0
[ 2941.106922]  ? __pfx_kthread+0x10/0x10
[ 2941.106926]  ret_from_fork_asm+0x1a/0x30
[ 2941.106931]  </TASK>

The queue already carries a direct pointer to its VM in queue->vm, which
is the value the counter helper actually wants. Use it instead of walking
through the fw_obj BO.

Fixes: 4c131aa02bc4 ("drm/amdgpu: Add profiling counters in fdinfo")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d5316e7bbb48..cf915ec8926c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1358,7 +1358,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		amdgpu_vm_increment_process_counter(queue->fw_obj.obj->vm_bo->vm, AMDGPU_VM_QUEUE_EVICTION_COUNTER);
+		amdgpu_vm_increment_process_counter(queue->vm, AMDGPU_VM_QUEUE_EVICTION_COUNTER);
 
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
-- 
2.49.0

