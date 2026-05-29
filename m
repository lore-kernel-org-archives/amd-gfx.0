Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2EFCD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 01:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F5D10F79F;
	Fri, 29 May 2026 01:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wNluuQB";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DCC10F79F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 01:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0scAiqlxQ/fq32px9LpOCYYviSNQvJNprtm0taLpmpaeiR+zyy8/RsKDnOlXRfvICNNwbotKpojyQwoQi8X7btHRtrdjvyfDQaJCzgDXvx20He6vD93fC7gBT6CsDDpzboEuGz/iTsWSaED4VgvgazwjvQsjNRJRrD4MRoEawiQM+KMbc2L3uLywQ4goPN6/ZqtTCWigNuX+LCbshm8ZRvhSKbqDOWRTnuEunqlDI+wqvQKFRahwf3TQ7WeqK7/0nTHuqCe8g3edO5oS2XjeT1LYdPw+d//fA0u9xeSVZAc6VTtihe2mLKyWLn8W1qhHBVwU4cyvVMy0NqTTXY9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMTrrQcc7YiL5vj1N0eFfMo3tS3FrN72ZQ/FAjKSZgE=;
 b=yfmsrXs/vrIQG9+QDXtRV2Xl7U5UVkiC+PIbvsvfPkK1S6yWVKACv1SOUdvRVRAGStQS03M3twErHhSPsvWW/mkfvCPwrcX7q0Sc/71a1VeP2k7080nTQ05r9+8NAURjk7Ob/7uEir27WhdsVlu3qXZm2SpMOcO4cosTgn03STqD8k8EQKsU+9jfryPurnbiLNbR3OREKwf1iFGoXn4ZZ6SjDYFW/HN8v4gMZH4GbrWEt9aVsJ7THuhQaZgTnjPxoG3E0gTkRgrkvJLkZWg6F67qLxmx3EdEZtwHkS0dfULqMxIJ21XySEoV4n/AYJu1GOcN/psMuPfepOAjvijWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMTrrQcc7YiL5vj1N0eFfMo3tS3FrN72ZQ/FAjKSZgE=;
 b=1wNluuQBCmUWyrIRiHR+P5+8lTj5J1XJ6zfXS6RNpQKyyg+diCEMXV0VHlSRvR7XAt9GtRGFNcjWAweB6IstOruZ0Eir+Rmpx4rxdNFpyDXJNWnJAxcyCjlQFvyQLh94FtiFXVEW5+iAF0s4UFzJUOxzbMxB6Fh+VjieC5cqEmI=
Received: from MN0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::29)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 01:45:15 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::52) by MN0P223CA0016.outlook.office365.com
 (2603:10b6:208:52b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 01:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 01:45:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 20:45:14 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 28 May 2026 20:45:14 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: enable execute permission fault reporting on GFX
 10.1.x
Date: Thu, 28 May 2026 21:44:32 -0400
Message-ID: <20260529014508.115012-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e61a44c-42cb-4c40-e5a7-08debd23ee9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099006|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: Htwb68uklf9vvQFTsBwPfJbSHVZzSY+sG4olLczGWw30sFZx5zGJzM7z+3/G1jWmc+ro/IqHwkJiFgn/7SnqV2ak9FN1mI+7L1tEsZeyPa37S+PUebIs0XPb5CH6Ip5SiNCtuDuOrZxbUlzbAvg7PN2JdothbcMhw53UB8fgCkX5D7NyAefwuUmTO0mD/VZtZwobUSEQXTasR7DJG0StgoHxiT5/qQE7+2hr6JK6EJ09lRUhjRPES7OYSICd14wvd6yvlDtH3LZDTOABQfMOgpBp8tqstHnp+gZ0EpBtEWI2ZxnMZE/+by4Ev51EZSnIhu8xdN1Zim0Gzn9sBfAbNM/g5yLp5OpO4MWNYhKC8sXMTOVuJXtcrEm9fWgP9JlkU11eb4SDgFE/zGUox1JD6CPLkoObpdKLunYNVA8bB+hVjAefOwLVaBk/yKCUnPw5EdrcBSirHU9oLqqkxPjohhFDrIkrh/GrQw4E2WjLK8z1DE0N+zIpMAG6R2AnuJR471kEyih5HqOhf5xbQKj3uG77XsDa9Mv7JNKvK2lJpeOQj83aRNgYhDd5OuaoqUxfXZ0vSvUw90kYyjGwzREvLLQj2Z9FizUC9ADcPWVEUGnjXcyEkXDLibks3fqvMC+0J/UIVJ3OIG1uJEug0Q96tJ5csfnF2SWPc7Dzn4syBAzEmYg8JLzD8lxNI/iWxyN4g+VqB9ZAMqdRRh8J/fELTlsdk9RG7YzeCQRl7pRqWEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099006)(6133799003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wwVJ15cg5pkcJloYbFal+eC5HXA9y/LH4Y99Nztn6tuNecB3UyrVe2yj85KKZ1yoA4y48IhJX5i6o8pZvDiZW19Wqpuwba8io9lzzcKQ9aEK4uTaLT+936cT1VKDAKLvY9TeLgTyo8I5cIx0YI9lztxAxJihJwoikWOVyNU7ivy55nnSLZ9tFFy4pUbfqUI097zl5bq6x3gQOsWkytEwhY6HIo7gD2LfPdr9kJr+AZAF5bADyZ+drSK7I2FOBExlyRzYUfxjsw9A/LDACX+a3AJ3b8TlbRxZClH78af37QafnUG2To3hfr0Q6MS9fj21mwuQuNYWtO6RBeXJkzTiZGownnMpwwrnh89AC7hF00B4w4IWSHYnx7WmHcUYUE9Pt6gT6cs3Jv1hEZ8sj46ljCjEwE2VC62lq7wwoSljkl0yGmIKs8mXdRvy9ljpPGyf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 01:45:15.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e61a44c-42cb-4c40-e5a7-08debd23ee9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
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

Problem
=======
On GFX 10.1.x (Navi10, Navi12, Navi14), execute permission faults are
completely invisible. When a GPU buffer is mapped without VM_PAGE_EXECUTABLE
and the CP attempts to fetch shader instructions from it, the hardware
enters an infinite retry loop with zero diagnostic output:

  - No interrupt is generated
  - No dmesg message appears
  - The CP silently stalls until the scheduler timeout fires (~10s)
  - The only symptom is unexplained GPU job timeouts

This was discovered using the IGT amd_close_race stress test when
VM_PAGE_EXECUTABLE was intentionally removed from IB buffer mappings.
The GPU would hang for ~8 seconds per job with no fault information,
making it impossible to diagnose the root cause from kernel logs alone.

Root Cause
==========
GFX 10.1.x defaults to RETRY_PERMISSION_OR_INVALID_PAGE_FAULT=1
(noretry=0). With retry enabled, UTCL1 handles permission faults
locally: it keeps re-requesting the translation from UTCL2 in a
tight loop, hoping the PTE permissions will change. Since they never
do for a genuine execute permission violation, this loops forever.

Crucially, UTCL1 never propagates the fault to the interrupt handler
(IH) ring -- the L2 protection fault interrupt is never generated.
The gmc_v10_0_process_interrupt() handler is simply never called.

GFX 10.3+ already defaults to noretry=1 (set in amdgpu_gmc_noretry_set),
which makes ALL permission faults generate immediate L2 protection fault
interrupts. GFX 10.1.x was the only remaining generation where this
problem existed.

Fix
===
1. Extend the noretry default to include GFX 10.1.x by changing the
   threshold from IP_VERSION(10, 3, 0) to IP_VERSION(10, 1, 0) in
   amdgpu_gmc_noretry_set(). This aligns Navi10/12/14 behavior with
   all newer GPU generations.

2. Add explicit execute permission fault logging in
   gmc_v10_0_process_interrupt() so that when an execute fault
   arrives (whether via retry or non-retry path), it is clearly
   identified as an execute permission violation rather than a
   generic page fault.

3. Add execute permission fault detection in the KFD interrupt
   handler (kfd_int_process_v10.c) to extract and log the EXE bit
   from the IH ring entry source data.

With noretry=1, the fault path becomes:
  CP fetch -> UTCL1 miss -> UTCL2 lookup -> PTE found but no X bit ->
  L2 protection fault interrupt -> IH ring -> gmc_v10_0_process_interrupt()

The L2_PROTECTION_FAULT_STATUS register then shows PERMISSION_FAULTS=0x8
(execute bit), and the handler prints the faulting address, process name,
VMID, and PASID.

Test Results (Navi10, IP_VERSION 10.1.10)
=========================================
With amd_close_race test (VM_PAGE_EXECUTABLE intentionally removed):

Before fix:
  - Zero fault messages in dmesg
  - CP stalls for ~8s per job, scheduler timeout kills process
  - No way to identify execute permission as the cause

After fix:
  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:64 vmid:4 pasid:592)
  amdgpu 0000:03:00.0:  Process amd_close_race pid 13380 thread amd_close_race:13384
  amdgpu 0000:03:00.0:   in page at address 0x0000000040001000 from client 0x1b (UTCL2)
  amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
  amdgpu 0000:03:00.0:      PERMISSION_FAULTS: 0x8
  amdgpu 0000:03:00.0:      MAPPING_ERROR: 0x0
  amdgpu 0000:03:00.0:      RW: 0x0

  - 200 fault interrupts correctly fired during stress test (20 rounds)
  - PERMISSION_FAULTS: 0x8 = execute permission violation
  - Full process identification available
  - No regressions with normal (properly-mapped) GPU workloads

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 23 +++++++++++++++++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  9 ++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..a9bb01c6cb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1014,7 +1014,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 4, 3) ||
 				gc_ver == IP_VERSION(9, 4, 4) ||
 				gc_ver == IP_VERSION(9, 5, 0) ||
-				gc_ver >= IP_VERSION(10, 3, 0));
+				gc_ver >= IP_VERSION(10, 1, 0));
 
 	/* For GFX12.1 B0, set xnack (retry) on as default */
 	if (gc_ver == IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) == 0x1)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8523833a74fb..554f514e59f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,6 +102,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 {
 	uint32_t vmhub_index = entry->client_id == SOC15_IH_CLIENTID_VMC ?
 			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+	bool exe_fault = !!(entry->src_data[1] &
+			    AMDGPU_GMC9_FAULT_SOURCE_DATA_EXE);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	bool retry_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
@@ -117,9 +119,26 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (retry_fault) {
 		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
 							write_fault);
-		/* Returning 1 here also prevents sending the IV to the KFD */
-		if (ret == 1)
+		/*
+		 * For execute permission faults, always fall through to
+		 * print the fault info. This makes missing VM_PAGE_EXECUTABLE
+		 * mappings visible in dmesg instead of silently stalling
+		 * the CP in an infinite retry loop.
+		 */
+		if (ret == 1 && exe_fault) {
+			dev_err_ratelimited(adev->dev,
+				"[%s] execute permission retry fault "
+				"(src_id:%u ring:%u vmid:%u pasid:%u "
+				"addr:0x%016llx flags:0x%02x)\n",
+				entry->vmid_src ? "mmhub" : "gfxhub",
+				entry->src_id, entry->ring_id,
+				entry->vmid, entry->pasid, addr,
+				(unsigned int)(entry->src_data[1] & 0xff));
+			/* Fall through to print L2 protection fault status */
+		} else if (ret == 1) {
+			/* Returning 1 prevents sending the IV to the KFD */
 			return 1;
+		}
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 19406ab92c5b..800592bc908c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -360,6 +360,15 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		info.prot_valid = ring_id & 0x08;
 		info.prot_read  = ring_id & 0x10;
 		info.prot_write = ring_id & 0x20;
+		info.prot_exec  = ih_ring_entry[5] & 0x10;
+
+		if (info.prot_exec)
+			dev_info_ratelimited(dev->adev->dev,
+				"KFD: execute permission fault "
+				"(vmid:%u pasid:%u addr:0x%llx src_data1:0x%x)\n",
+				vmid, pasid,
+				(uint64_t)info.page_addr << PAGE_SHIFT,
+				le32_to_cpu(ih_ring_entry[5]));
 
 		memset(&exception_data, 0, sizeof(exception_data));
 		exception_data.gpu_id = dev->id;
-- 
2.54.0

