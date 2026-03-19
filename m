Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DD7107526C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BBC10E8BA;
	Thu, 19 Mar 2026 07:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ynV4QQA/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85C810E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obW8diSfAiXzMai1N5DGrEsisQMMhdz0d+/8Ngy3/OfpBAKrHPRROVpT64/P1lx8+NfTwl3/uCuiSvmlw67xOXGBgPdkk17pOR9EWCmWYxIIgKtrQJK7+CuLp6uoj22BigVv/XnnUByGPOoVpd+7TDW3TYsc0O1ltQrAO973IR8AIx7VcxaVE4rKkMwKR84lRXPB40Idx8X50g/pq+piYmIM5EEU5hFclxGIFDX4xsoEwtZ11Xb9SK7oPRfyxdXXdeX2pbduUdmXH4jfeH/t+WoxeeBt8gmjzTb2zi7qe2+QmPtQCsODglb/5njGCsUqeKqHZovWqdjuO9/AHxkfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRXuPBPNmX9Xqs7qxobtfh+RWrOF0f+wMEzlJqZZ2e0=;
 b=qX4Y2PnFe7ExK7Joxmzr0BvJRSKaNi6h0siLc1+cG37fMVtafaIHY3tIpXcPkoX7OmI4ACxCExZUA/+FRWusNZxqJOIj6Dr/5fkwr9K/RodR6SlWwlv+XYhSLNqQA5Edx3WDE5/QpdHBCgLAC7jmN60W+SPX3+UrWL5ZLU1+lW9ozzUQ3zxdnMI6+RFcrnbiTj23xuxFH12R2OqNLsQI3eQRONzCHyUO8UckraeWoGP61B/W3DdS9m1fuvjovq9SBc+Z2hWxpGZfkCDoNmehnxCLvkt3k1Dqmn+zmfPfHo/gl+QfreqfJU/2KuejbFGWAzd7bvkZ9Re5g81X2G+qzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRXuPBPNmX9Xqs7qxobtfh+RWrOF0f+wMEzlJqZZ2e0=;
 b=ynV4QQA/QRg0YM/NR9y+YpTPUmCmDQAb/S5HS0P0RZXel8CQvpzOVQHRqznSN9LNCFol4ITY8UuTX4TMoikE4uHLRcSYumPCfrXxh7JKpAZnkM68LNznlSIqmUI+KtsDzraTvC9B6WvtuXIclVC+nXv4E0tFP9giwnaQRo5iCTM=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:33:07 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::e) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:33:07 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 02:33:04 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
Date: Thu, 19 Mar 2026 15:32:50 +0800
Message-ID: <20260319073250.147808-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: ae25ffc1-980e-4a6d-bb6c-08de8589c3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4+ZpBXzfGPNeU5X4RSHxO9FGmww54P3GFCtK4IfbMr2XEcUQyrWwK4Bgarjh/6uQUXZuKRRbqPQN9TNpxKpASkvc24mAZsobzZXhzN0+XyCNjSEFZ7kFxlGCgscH4AsTgVp84PFLAigfSUh/XMmwtbc3a9XWmP3pKw3X9rZRvzZqgHAC5F/fX2jGkzzKC3CN70HmjeW4C1tdXa3shmpxwLkhI5xoly70Br2IeRD+E3Bvwa69R4LNLBdiz58MJRslClhERL6S6Og2PdERMePxte3yRzmBbCFNMR8e624e0rKMuFU+GNUbqNTH4M7JWnBAh2KxtC5pcpLkAbD8QgpPIwSaMKRRASQwuHm2bSIC+7rAMjfpNds3cwr20cZIBA49DXl44A6TDA96roM3oWlIQ9RyCUxND5atACHm/jkDlbWNPuV9odUIvawEclnKLWUfkYHm9cSzoDB0Hdi6+sgzzTfSr1L3v4yd0UlYGxBMaT39fG8u4OKlWKbCgqDyJlabBXnizgnPcOVcTkHxa3pN1qe6KAjTbpXNMhkntXm9aPk5iU3a1UUT0Nn2J3FKl+U+atzepRRwjBBnDlnFywuwphm6quPUM0Jw0/KQMRsEgsU9Zv0jQtrrcxMIaRjTYPOeVgTYjPq3Q1DiVQK45UESq4SI1IAP7lRv/GxF+POom/pDRXv7xRHp8NjyalsZM2982Bkmdv9xrXee/W/0UWeLW0+EnCZZCIsHhV6vQlS8u7KWlmseUkPVKXd4MvfkPeC3zQhqqqI75enZUw9msnzOSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EJGy9U0fj2KJpGxy5eaavyQU+a4cqMLSJf/BWchpUYXrj76r+WGVhlH4ZzLIJAF2sq3FgX0JzQCfsEnZBCZsjGCsmqX2ZREc9qwF5FFk3rUkjwTdlKVyMBrYFIgG6fOFhgAtueyzXYQfAIzBhU/p7UxQybW9WrtkHZYyb5c90paW/xnCmZqKBb2I/LdZG9Hmg2kYr6d/E8N2DHxJSYlpB2NVSuLhGdsMyhmdPZR5+HZAiC9Nc/rkXZ50xj0eX+v7hvHyujAzxbLxTg9DmB25xmpujToUGpI2MgemtyLrnt1b1lkXUi878obxDo7IQryGw/tS86qa4cKAULVNaMxvbiBYdNSCCeRf/FG7M0CBVZKzBAmSQEt/SrrXbkX0sohGXeotffsU9ctQ8ZZQgLMu8sywUH2vrYudyuErQywY+NylwcTihZzoUHBN+1dpVGSV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:33:07.1497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25ffc1-980e-4a6d-bb6c-08de8589c3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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

Current apu_prefer_gtt setting only check gtt_size, which could be set
by user to a larger than system memory value (via ttm modules parameter
pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via ttm modules
parameter pages_limit), system memory 31GB. In that case, apu_prefer_gtt
will be set incorrectly. Take system memory into account when set
apu_prefer_gtt.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..a6ee9d9bfafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 	int i;
 	int last_valid_bit;
 
-	amdgpu_amdkfd_gpuvm_init_mem_limits();
-
 	if (adev->kfd.dev) {
 		struct kgd2kfd_shared_resources gpu_resources = {
 			.compute_vmid_bitmap =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..13cada7da4a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
+uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 
@@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8a869fe41acd..4fba7d2f34a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
  *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
  */
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 {
 	struct sysinfo si;
 	uint64_t mem;
 
 	if (kfd_mem_limit.max_system_mem_limit)
-		return;
+		return kfd_mem_limit.max_system_mem_limit;
 
 	si_meminfo(&si);
 	mem = si.totalram - si.totalhigh;
@@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
+
+	return kfd_mem_limit.max_system_mem_limit;
 }
 
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..df98ece071e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
 int amdgpu_ttm_init(struct amdgpu_device *adev)
 {
 	uint64_t gtt_size;
+	uint64_t max_system_mem_limit;
 	int r;
 
 	dma_set_max_seg_size(adev->dev, UINT_MAX);
@@ -2210,8 +2211,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	dev_info(adev->dev, " %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
+
+	max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
+
 	if (adev->flags & AMD_IS_APU) {
-		if (adev->gmc.real_vram_size < gtt_size)
+		if (adev->gmc.real_vram_size < gtt_size &&
+			adev->gmc.real_vram_size < max_system_mem_limit)
 			adev->apu_prefer_gtt = true;
 	}
 
-- 
2.43.0

