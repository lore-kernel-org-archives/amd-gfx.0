Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6FC0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 22:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1C110E1A4;
	Tue, 11 Feb 2025 22:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2k73Rw1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4283B10E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 22:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+c5QwWP4jx6A57foU0xuwTrw6XUw8EEC96jnTS8Zus1hcPCBEoplvodpBF3fK1lHFKr74eWdahwtDaaaI7VAflQfR+XcJtvtGl7G1B/Mg+N2pugE7sqDJcyHQ8o1LZs4QRw1o36iGtIeM8LtITp//V/TnO9NRDWKtU6FTm8A8qK8HIWGXtE+P4MgLkVFghwNaD+DOYssurH9SRyQ15errAY5LNnlotTkFbZEmkzgrmmN17Xxh9sbw6os2FrbCsuVE/S0E4zZRKHMfzi8kYf+aAy988+coxSpi0391tkdHvQHyJSHd45pXy8X2EkloAmLHLe0zfXl87Z8WXEOrMAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/340QmkLMcgTg8GAqYm+dltHopTnBJPstHVnWJj/ps=;
 b=NXrSbE8JEIerOROrxnvicdBm08CYgJ34HdQPVl8fL7LE4fhMqRXbgre0c/11nIYUb843tMw9mOC80DPmu7GBvA2oggSKuVbAYS9+37rxlMuI9yaUaxMs53bQxvLPFl/DoRSWV/pRwF2a1aV0WUKqCCM5lzgx2nKc6tkQ1X/Xq2siXlBwBTYDbWKBp6cOPZupW0qsyDn3WdCur/lCoNCkbljbXR07jf5TjWbsSKJ4RVJpIDegbxhunrl8E/lfsOvzCbsGsg5yeNr7RfVQsOlV+BWTfR7DKnscC6VtuZZLh2nDQNX9htuJbbdLS+62tZvHeqesLB6dGxuhvPUKSsOMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/340QmkLMcgTg8GAqYm+dltHopTnBJPstHVnWJj/ps=;
 b=P2k73Rw1gdCKk3yRn7IZpygXepSLwRfFqofomeILIOJO/XA9vZF5vS9L9DbBR+7P3zVmvlUrH2XK9Y9x638IZDVfIDHZEa7CKdPkxJiesh1kZ65foQwnKXAAZrqwVBFMrF2w/jbcmH9QthZj9daeViurMEdy/c2KdAiW84Qr/Gw=
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 22:56:29 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2a01:111:f403:c803::2) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 11 Feb 2025 22:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 22:56:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 16:56:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 16:56:27 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 16:56:27 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <chengjun.yao@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Fix pasid value leak
Date: Tue, 11 Feb 2025 16:54:24 -0600
Message-ID: <20250211225424.384523-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a785f-1814-4d18-bf45-08dd4aef51f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5V4hY5OLvBXbYRlPNkwD6SATJrdkfcOMYZoyHL7sEZJu1L6jE9xcXt5aNfo?=
 =?us-ascii?Q?QarPLYWVlmi3KPF5s34CFm1Aufmqzd9MwoEg+Pvev4nGKE5rzwnbTcwqqCNG?=
 =?us-ascii?Q?xmweQ5Yc0Rl/CNMC+WjMj9V4CEa7CadE/uf/EKERHO/CVsi+D7YBqvUnvWgb?=
 =?us-ascii?Q?kZA+91NDfjoAu0a0oB3djHl8+dZxkOfbEeVn0arwGcwcDzT4DbjoHyPjytLY?=
 =?us-ascii?Q?d7wN40XzzXgoqiMaCVq9bsLN/WsauZUD7HbLASauedcFIBFS7yi9dv6ud4bI?=
 =?us-ascii?Q?okOzWIfkIPzRQkV96p2Y/egReLypJnbhW2m6PbuUuNRIeaWVFI0eSRFS9AEa?=
 =?us-ascii?Q?d67OgCibiFhFgbV/m1IclCVK5ROkXiyNup8yxsjO0wOjKs6cH/xVRQM02cPI?=
 =?us-ascii?Q?xJtOP+aTWSYzmdT8++VpRh0tr+4mgtSeKpJ3RK7qEH1oUIJ4LImqnafnNB1W?=
 =?us-ascii?Q?qTuOBxKWWTTvrnfse5Vj74xoBSYo7fREQi+u9iYCCZdZ3V286wgE6i1pX07l?=
 =?us-ascii?Q?XEj10OFzIrUB4N4RaVWtNz2+CAEpHYZCIYBvSJvEQ7VLDqO5gjlvNIwQafm5?=
 =?us-ascii?Q?C3acA/M+L4r5vwt6a5RuLZ2Q06eNQqSUhOZOXn5AyYULrcGN4PfNX5iLPwu7?=
 =?us-ascii?Q?gESn32BHGAQF3bd7BqtwDYimi7zRKXVfbRLKYpdyvM0YWCLX8RrRIsWkY4Ze?=
 =?us-ascii?Q?LX1S0jf5LcyE97IOflrsUYgg81APmMHvPvFt0GVpabJqQWRPcNYdokUg471V?=
 =?us-ascii?Q?zpnRWDbfoExxnK2Z0Ga7NvzLNw+bcQqGK+I16odG/olk6EAOF/vX73PMrTjI?=
 =?us-ascii?Q?zwGSaBHX3FESCmQ1r/Ie6crzqm+tGdGEoBRMaFZw3QiFO/wDa7fKufRbi08V?=
 =?us-ascii?Q?LU/L45K375gcFGU/2FhDHvQ1sJRdLqpLvYX2nVbRBrsz+JMjoM40JyJp445T?=
 =?us-ascii?Q?wvcTTRwFIFTT6n19RSIp7ZY/JzNbqiIM5FqI+YcXfiMOiZ3xSwOcpjy4t4+j?=
 =?us-ascii?Q?wfA4/M6C6TWQvaxHVVXsI0JsbJDGR+ZZa81Wl20APZlcydcsUOKXDt5IDi5u?=
 =?us-ascii?Q?4q+jJEZjF9b36bIufvWya9rBQICGteCa+Cc+U9rXWSTReRZZT4R50qVFN8wa?=
 =?us-ascii?Q?5dCcqvnj9X4KW1zEbJP4Sbup77ru1v6t/4Y7wM+qsE7dJa2V/Wv6iy0AQxEf?=
 =?us-ascii?Q?Rv2qIs73QAo2abWYJR87FzXBuInPK5C9MFS4Nj6jDbscPJoIOhSDes0DIimY?=
 =?us-ascii?Q?+Ky0Cs2+nUp3VdGTGHmH1J9WkwnD2OE1nDiDhI6DL5kgQrzOiC7MWB657XTe?=
 =?us-ascii?Q?jaJe6KUMXkaPmZfsWBgEPhGKixvPLlkF1mH4ijMwGylLSN4aRoc/hKTVu3cf?=
 =?us-ascii?Q?6gHlrB5njRQpoXqj+7Kz5z5sUOZuwzAwj9ytVEKCrqSf/N5DiDQDR9kgQPg6?=
 =?us-ascii?Q?WpUy0/q3fuzDGVwP/TRbbNgD31OH4eLofGE0Z97ORGRDuN5qZlftSMo8uXNM?=
 =?us-ascii?Q?UrkkPC+QHE4KvbY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 22:56:28.8814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a785f-1814-4d18-bf45-08dd4aef51f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

Curret kfd does not allocate pasid values, instead uses pasid value for each
vm from graphic driver. So should not prevent graphic driver from releasing
pasid values since the values are allocated by graphic driver, not kfd driver
anymore. This patch does not stop graphic driver release pasid values.

Fixes: 77b5e447427c(drm/amdkfd: Have kfd driver use same PASID values from
graphic driver)

Signed-off-by: Xiaogang Chen xiaogang.chen@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 --
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 +--
 5 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 092dbd8bec97..236b73e283e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -304,8 +304,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					struct amdgpu_vm *avm,
 					void **process_info,
 					struct dma_fence **ef);
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
-					void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
 size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 					uint8_t xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 60062c10b083..ea3f7ee18923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1586,27 +1586,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 	}
 }
 
-void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
-					    void *drm_priv)
-{
-	struct amdgpu_vm *avm;
-
-	if (WARN_ON(!adev || !drm_priv))
-		return;
-
-	avm = drm_priv_to_vm(drm_priv);
-
-	pr_debug("Releasing process vm %p\n", avm);
-
-	/* The original pasid of amdgpu vm has already been
-	 * released during making a amdgpu vm to a compute vm
-	 * The current pasid is managed by kfd and will be
-	 * released on kfd process destroy. Set amdgpu pasid
-	 * to 0 to avoid duplicate release.
-	 */
-	amdgpu_vm_release_compute(adev, avm);
-}
-
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48b2c0b3b315..ef4fe2df8398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2578,20 +2578,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return r;
 }
 
-/**
- * amdgpu_vm_release_compute - release a compute vm
- * @adev: amdgpu_device pointer
- * @vm: a vm turned into compute vm by calling amdgpu_vm_make_compute
- *
- * This is a correspondant of amdgpu_vm_make_compute. It decouples compute
- * pasid from vm. Compute should stop use of vm after this call.
- */
-void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
-{
-	amdgpu_vm_set_pasid(adev, vm, 0);
-	vm->is_compute_context = false;
-}
-
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 160889e5e64d..daa2f9b33620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -484,7 +484,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c75373fd6ef1..cc5907e96ded 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1059,8 +1059,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_ib_mem(pdd);
 
 		if (pdd->drm_file) {
-			amdgpu_amdkfd_gpuvm_release_process_vm(
-					pdd->dev->adev, pdd->drm_priv);
+			drm_priv_to_vm(pdd->drm_priv)->is_compute_context = false;
 			fput(pdd->drm_file);
 		}
 
-- 
2.25.1

