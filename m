Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FADC5B572
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Aug 2026 17:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E820210E2DC;
	Sun, 16 Aug 2026 17:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrjBjjoa";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2DD10E2DC
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 17:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgSw2EhfxLIfVuJwYs0U8g+WXjWfvXzgnpDn5JTCcF3eC2aDbFT4XbmRseEj7iXpQcQaYielM2wg3V1Oe4YuhIKTJo7ipq0xce771jPaET8JPdm7JT+dHRtPO2IA+Guu+yZdMPGowMVEB2YT9RLFY+ae+2JFptVMQd0QUHq0J9iv4CVARLLA1KvoqbZd8CFLyF+QyJxc6rnuTUCiet771dOxC6WjZUEALMZ68RlG7lJNSDQyHQdR60JAfu97eFejTrmQOzFmvGewd/oOMj3z45Nd/IS44V3eZFt9fxLhRPOF16ySbWDRsFiHN6E6viO1HNu8YH0XkqsreEmM1p/tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDTDTEA6/GFTEMQbPJGGOkeNRygcJ7pzFRplpL7s+58=;
 b=FwQHH0c8sZhhkFIQ27aSfh2iTHyNWg44IaiP9RR2vUEaixromqoOaFgyo6Ie182AmUTthjJ7lB2VL/PMUpy5Qp6UVmPLdT8qYsTXy1jXdqiu3Mfad1uGTwpgylkXPODJ6OzLd7wVZH4Hjy5icEKBjCxq5RYFsOvCKN0ZxsSisAStoeK7pGvtBZQ9fhu7j3h+hwZPLK92o3OvHlhAYWpZQJHyafXdJbl2t6svzG1ZP90uErv+gZ0YpRceU6jvty1q/aXgIf113zuN7v+m8gxarePwlQ7/JdZaYXqlLwQ8m6HiIJnNLmchSv4CFRSeknNGuNULT2hI9ry5kvXUoKcxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDTDTEA6/GFTEMQbPJGGOkeNRygcJ7pzFRplpL7s+58=;
 b=FrjBjjoaeuuTwn9Yq4j/V4RvogekadT9MFSsaaIHT+eDjIAZEPSxmTn1rNTpmkcc2h4ZdqPMxCf2Y8POyB4S1kXxOFNfXP+iegcoMsLClahf9Qyxyabi3YSRaseDiXOM2dsNb2NQeT1cw8gQVuE+LcNbDJtgW61VytA7wVmaaJ4=
Received: from SJ0PR05CA0155.namprd05.prod.outlook.com (2603:10b6:a03:339::10)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 17:12:46 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::61) by SJ0PR05CA0155.outlook.office365.com
 (2603:10b6:a03:339::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Sun, 16
 Aug 2026 17:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 17:12:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 12:12:44 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 12:12:36 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v4] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Sun, 16 Aug 2026 22:42:31 +0530
Message-ID: <20260816171231.14175-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d58086-278f-4236-543e-08defbb99755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: nz+lpfpx3+EShC/sE9EZzVaUwab1SEnn9jL6+JDDxDAyewreqBpT0PtfzZ8/OFPIBJ9sVJ9irdxaIQOL1Mn2kuY/OGglbHmoU+Q/OQEcO5DOpIB99DohXaNRfapHKQwZPD9k3HNb7gcmqSN+9KQApW0+G1jEgk4FBWUckTk4DD3hr6cwiEXm2nSvIC7C7hvsZSy6oHDUmS26xFE+1VowatCpU7oACzCmfIVKRfFfPNrLRgTySOLH4Fg9mYB/9cA2FUNxyxxhP+B+YjGPa7Vu0TEdWs9qruylkiiBtcPjWqdxqqdF4xyzLKUeSovr3WSoWc6SF5xV5rirRbtCw3moomIf8vhhG54YTeA9A+fJecUAph6DiTsM2ZwtW0RhKhnS8wFp5x/eMyUzxTBgTi2Ztq/QoqJLC2URuHd08uquBFDwrsMMFTKfeswLc5uo1j1MuQiYTQcW6Dlqk5bSJ+Ay5dQOgUZ6v53Wg7HXmGmMesq9oz/M6sYxUGBDcfk2omEJ/ROuJuMFdl6D+/hhcdZXWKOthe0AcrjcleqQ8gRrMXs8fdX+HzhPWznnFaqh9fUyBvdFoF6INEJrwvwrrcrGUa1dyscHA6HYY+VirWrzFgYa3o4EJBQK/OIKP45syanIUW9pX266gO9TnQ6MWJ74SoyZJnN7gmCPjUGphr55YwEJSmWmlP9w5gG9tL3SL/q07bOvIZaJrp74+AQDgAU0XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ijUMJKTU9FX3S93CiYXdzy7GFDRdvQWX5T+gbM96mkqmsV0jNtwBobJfo9TXxkxWmtI29fd/kjWzoq/blKAWRIoKfOyyadtm/hCsb8DfOlyVIYH1GQit9AN36YqtWNdQbvcdY7WebnJ41vR5y9ZLRKog9xU7hA6HkPyjQ+qJYb+Ybmy2OVbEUgo+uwPXd1bXugqPxt8JRBiaZ9pMekMnQ/aF6ikW3tboGK1Tfhpc9mvasEqfypVdGsss64owJyw1hEIRTclfMxpqryPIGUsakHanr4CEkRtuissbnkk1gT5A6pLH2vPEQ38XwlVs5vwbDBVdaKflZmFrBO8uvwfVP3FRCr8OdWZeSUvUyui7xgXOe+4KgROeZD81hRoKqngQ4WtNSsRLEsrtbsGKLWDxaD0ML2MkIRbJylwQr4JEEbSrgY+ByYQs4J1JVGNbHpfw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:12:45.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d58086-278f-4236-543e-08defbb99755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
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

MES (Micro Engine Scheduler) does not perform heavy-weight TLB
invalidation after unmapping queues, unlike HWS which does this
automatically. This causes a race condition where in-flight DMA
descriptors can access memory that has been unmapped, leading to page
faults and GPU queue hangs during SVM page migration.

The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest
failures on gfx1151 (Strix Point) with XNACK mode 1 enabled - the GPU
compute queue hangs with packets submitted but never consumed.

Add kfd_flush_tlb() calls after MES queue removal in two locations:
- evict_process_queues_cpsch(): after all queues removed during eviction
- suspend_queues(): after debug/criu queue suspension (with mem_fence barrier)

This ensures all in-flight memory accesses from unmapped queues are
flushed before memory is freed or migrated.

Change-Id: Iaa884d4a7ad1199446bc45f4ad8a9a179ab386e6
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
v4:
  - Dropped userq TLB flush patch (not needed for per-queue unmap)

v3:
  - Split into 2 patches per Alex's review (now reverted to single patch)

v2:
  - Removed "SDMA" from comment as this affects all in-flight memory
    accesses, not just SDMA (Felix Kuehling)
  - Added Reviewed-by tag

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..6002c8a65fbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		dqm_evict_mqd_bo(dqm, q);
 	}
 
+	/*
+	 * Heavy-weight TLB flush after MES removes queues to ensure
+	 * in-flight memory accesses complete before memory is freed/migrated.
+	 * HWS does this automatically, MES does not.
+	 */
+	if (dqm->dev->kfd->shared_resources.enable_mes)
+		kfd_flush_tlb(pdd);
+
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
 		pdd->last_evict_timestamp = get_jiffies_64();
 		retval = execute_queues_cpsch(dqm,
@@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended)
+			if (total_suspended) {
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
+				/* Heavy-weight TLB flush after MES suspends queues */
+				kfd_flush_tlb(pdd);
+			}
 			continue;
 		}
 
-- 
2.43.0

