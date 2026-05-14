Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4BCCD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 23:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D9B10E067;
	Thu, 14 May 2026 23:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fr1Jw9eh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3A510E067
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 23:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2xDxzWId69qy2yMVfI7g5CA/bCmZXHQH+jbMX+VcfQus8JPFmbaJFUEV8CmLduAMyY990ITHBvDqzgh4OBTgrQEfADtU6CoqesRh+bKDtnp1pzitz8fDHlXyTaYEhGngCeVaQH7IkqMYWqf/B5jV4Rr/r2cuu1Fft79R5FHJHKwYF+9dJK/GoM9VgVpLUXOrhgpTlE9KCY5Cik2nb0hV/93gIlC2HmlvpMR+Pp6g29r8oeWGuGZ6E1Mh0TgSjFaWXTV7W9WILpkivFahMfEcgMXCzpTBAF24HP2haabg+Ac1F37rx7SXA8ekhT8Ra2AXJLhTX20Be+hPXzPzL8LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjxLBPlg3H6MQbCy/B+3dJ64FVA5XfPoWVEt72eAtgo=;
 b=hp7LDxbUxCGFYlYhlMw6V6qcGiJUwP241fvz8mLjFX/Ox1DkpuvbcZnJVlhabiPQVxg5DHLIfwvOA7DzdPA1x9WMERR0KMTfQKMzpl6RjwJzjLvoPV4d4pR9Me0Litn6NzFx3+CM4VQlswa6E3u4WfPXxhTX6KuRVpT9otlc8eS9b69vlMPcYJg9xVWjWZ2ivDeN+7tF2hrMjJkoCpy6S/rGlkQAiO7YGiSnHJ7P20mmOP37iHHOL4+IjvPQnaCOVnXVtCXSfEmMpTq+/eT41JFdUWdUelqLD1horK8ihCkkBwY+qCxEaM0yHjj3ZY06bvTzdaBmU7QnhFeWWE9MhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjxLBPlg3H6MQbCy/B+3dJ64FVA5XfPoWVEt72eAtgo=;
 b=fr1Jw9ehBvGwN+RXZU1tTxbFuM4W4FKbDo83cXNNgRPQD7MiBnWM9WMSi4kDyQLn+7y+FVEBFUPFY9haJ9/TVVqcRFwvaFm5mBcL5ZDNdDQwcWE/ogFKuv6XVhZxjSCz4O/p0wmJwSa/tCIiSScBZ3yUsbr6Q4U9TmUVDQG0lSI=
Received: from CH2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:20::24)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 23:23:20 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::e0) by CH2PR07CA0011.outlook.office365.com
 (2603:10b6:610:20::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 23:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 23:23:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 18:23:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 18:23:19 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 18:23:18 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix KASAN slab-out-of-bounds in amdgpu_coredump
 ring dump
Date: Thu, 14 May 2026 19:22:57 -0400
Message-ID: <20260514232307.123284-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b94960-b31d-4f35-eaaa-08deb20fc8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aq9/8tTs/glguU5usQLvTRJkCLwdoWbuiZbU76HFpWKNrJ3BD19iHYl08vD0RGJR/jhpS1hpFW6fEaQEOMl911csHdODT7MQMXMFUo/ZDlz5ceBXVOn6Psd2f8oLS6bvrwpJQb4oij5zd1nTjC/YplyfBnTW+nnLU5VlIF7zul2KE2rjnkYYhffjwF90SzfzA7nhYECtyTaKBJnAbMf1+5gKmHwjMttRZ+f4s4X3Okq2TClx3EQfpRFA2VXz+cplrUqFy1R4ei7MW5Q2qkkOp0HDE3ydard8ffVQO4fqonBNcvTHxENbs5WQLBNW42bg111FjzAwVDRg3Fk8gcb/6B4QmBdMaxmAarytjHxtDLIJnwYgVJbicER5dAsCMwZYdodDBFrY5lV02o1RrQLWsYZs+bpD4P+XrLfAky6XJhvQiEQ739aIrepd+toTiCqSbNBTkK3de33JoxtwVAoMw78RuwVICKf2dQj2NRVyzNymppwUSsBTKxV9JkfAIjaH/RioSIdDrrr4ukF4G2tDMx4sDGnZtmwCTlyTqzM7wTgX69V2Sz1WfXCBEYlMNHnds1M+Bztw+prVc3fcYnTBmTSVAo1yJLwkMKx9EIgWJPsTot32R0K+S+viwfR+U7lOvKswKg9QKNxcPJlLNJ/lznWIPKcygtdfuXfvPOZrj/40L05uuv+FcuDYUUSsp9mJnVzxrosgzfpE21A5kFY5I9dL/HIs5UL8s+jfpcRadcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5C3eiw3NDI070DzA5PtClN7zVtGUKfV+WuqLmLagaYSQFlY6tDp1LUgo7z7vViIDR9S1+KlWeiH/RgWdpA2ymTFODIBBK5IQB+7XpTfNj4KsU1mC+pc/OK+HWoeTVACra53YW2grYd/wayQ2q3kiqV3qfST6TF9g19oKlBirisCbMLYWIK4lovgy+aQ3JZhpvwJoCNspGHU4F7Pv9A0EuDou1t/Enh2+14lFKLyGOpOKH9CTNnwKyEe+2cxJQfeSg8Sxg8rykIBA4NEC2LhXmX8ZbYLel2lpa7ylf/Az3WFUtnQVQNLjny0pjFV2BXRTii3K8V7/BMppB8SM6sNGO3OkbevI9S7fkwLICj/lm/2569oIErFhTxHqPVM7cE+i7bWB0lmSR1UkPKMYvzR/rdALf4sTIn2e2kVC51MdigfNe+dm1PpPDY40lN0sjPtK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 23:23:19.8717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b94960-b31d-4f35-eaaa-08deb20fc8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The ring content dump in amdgpu_coredump() uses two separate loops over
adev->rings[]: the first counts rings with unsignalled fences to size
the allocation, and the second copies ring data into the allocated
buffers.

Both loops use the same condition to skip rings:

    atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq

Because last_seq is an atomic that is updated concurrently by the fence
signalling path, additional rings may appear unsignalled in the second
loop that were signalled during the first. When this happens, idx
exceeds the allocated ring_count and the store to coredump->rings[idx]
writes past the end of the kcalloc-ed buffer.

This was found during IGT stressful test amd_queue_reset which
triggers random GPU resets. The OVERSIZE subtest
(CMD_STREAM_EXEC_INVALID_PACKET_LENGTH_OVERSIZE on GFX ring) provokes
a ring timeout and subsequent coredump, which hits the race between
the counting and copying loops. The failure is non-deterministic and
depends on fence signalling timing during the reset.

KASAN log:

  BUG: KASAN: slab-out-of-bounds in amdgpu_coredump+0x1274/0x12f0 [amdgpu]
  Write of size 4 at addr ffff888106154258 by task kworker/u128:5/23625
  CPU: 16 UID: 0 PID: 23625 Comm: kworker/u128:5 Not tainted 6.19.0+ #35
  Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
  Call Trace:
   <TASK>
   dump_stack_lvl+0xa5/0x110
   print_report+0xd1/0x660
   kasan_report+0xf3/0x130
   __asan_report_store4_noabort+0x17/0x30
   amdgpu_coredump+0x1274/0x12f0 [amdgpu]
   amdgpu_job_timedout+0xef0/0x16c0 [amdgpu]
   drm_sched_job_timedout+0x194/0x5c0 [gpu_sched]
   process_one_work+0x84b/0x1990
   worker_thread+0x6b8/0x11b0
   </TASK>

  Allocated by task 23625:
   kasan_save_stack+0x39/0x70
   __kasan_kmalloc+0xc3/0xd0
   __kmalloc_noprof+0x2ec/0x910
   amdgpu_coredump+0x5c5/0x12f0 [amdgpu]
   amdgpu_job_timedout+0xef0/0x16c0 [amdgpu]

  The buggy address belongs to the object at ffff888106154200
   which belongs to the cache kmalloc-rnd-09-96 of size 96
  The buggy address is located 16 bytes to the right of
   allocated 72-byte region [ffff888106154200, ffff888106154248)

72 bytes = 3 * sizeof(struct amdgpu_coredump_ring), so ring_count was 3
but idx reached 3+, writing ring_index (at struct offset 16) 16 bytes
past the allocation.

Fix by adding an idx < ring_count guard to the copy loop so it cannot
exceed the allocated count even when the fence state changes between
the two passes.

Fixes: 678236b37eee (drm/amdgpu: save ring content before resetting the device)
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..3d5a2abf27c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -553,7 +553,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	coredump->rings_dw = kzalloc(total_ring_size, GFP_NOWAIT);
 	coredump->rings = kcalloc(ring_count, sizeof(struct amdgpu_coredump_ring), GFP_NOWAIT);
 	if (coredump->rings && coredump->rings_dw) {
-		for (i = 0, off = 0, idx = 0; i < adev->num_rings; i++) {
+		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
 			ring = adev->rings[i];
 
 			if (atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq &&
-- 
2.43.0

