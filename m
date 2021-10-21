Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D30C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6053F60F0F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6053F60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835616ECAF;
	Thu, 21 Oct 2021 14:32:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E81F6ECB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT3NkUa8upHNOlcLaZsaYr6G8acKJ1anrY5WvRz0/pyluCaH3PRE6Hrcs6d838LE9U4zB5OAs/shAXq0ON8g11H+hl7St5pDL6SV16B2rFsSNgL0Zqj3mnO64BUU4VO2GiF5weayXIMJS9Uf3TRZD+pUJF90oNdqSOyCgj1A2dZBSWyhTx5FN433aoliRfMgSZyEqW1Ck+zDZWX72MUU2H6Kj85zX3efkf4HlaG2TVfYPBBGb0vfgMx6O7wmDueZHpcaN3ZMSxPbBw31dXdOfUF0kfxLL+SxW5BIGJ5bMTMlQ4XiyMTRwYs+k/ffA7fXofiKjkYkCnvbzUOJI5NEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0SSbqwGXldp/x4BYPuLXXYxHx2iBijCYtPsWdOnQpo=;
 b=HFOLX4qHR48ySAEkfBXsE2LO0CZrnbvrG5R/27W03pWeEsIOx2jOCpTi1SCIPPBC/eBSeijKqSr+lccOveaLIdrwRLE8yrFajHb5l9vgkgxQvMwfcqgNS9jM1GAhJOYthXYICjaHFbfu+J9+m8xA6lhDRUMNeHJzFWo8WwEinsOu3uYTtd9JBN1Tsl32q3xVERfj3uzedGak3Z6jDevdOU7w2xU9dFAYFSZjid9hwbJU79oko6vNdHO0W1/7JFbnKSjp6v2G88nglY+hITHYmxcyrXVlnmbwx47bTgrn6HppBQA5fSHaIlEj1WHAlp37jQoBYMc2GX4/IzON6IiyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0SSbqwGXldp/x4BYPuLXXYxHx2iBijCYtPsWdOnQpo=;
 b=vjoa3PF5S+7O8S92XAH7ljzDyXXokAyjRnnkxixMJeYxuYy65SfX8RSs7+isQHox0t62KBj85ntTaXOQNz/mtoXR+kXR8bhDuwAZQ48KYJlL4jHqmFHX8A2XeVkWwQeh97WqGcF+4pZghO0iC5CGTUy6uQIMw8mRKota7D6Cz5c=
Received: from BN9PR03CA0114.namprd03.prod.outlook.com (2603:10b6:408:fd::29)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 14:32:03 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::82) by BN9PR03CA0114.outlook.office365.com
 (2603:10b6:408:fd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 14:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:32:02 +0000
Received: from linux.fritz.box.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 09:32:00 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>,
 <andrey.grodzovsky@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: recover gart table at resume
Date: Thu, 21 Oct 2021 16:31:42 +0200
Message-ID: <20211021143142.4900-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021143142.4900-1-nirmoy.das@amd.com>
References: <20211021143142.4900-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a466a920-fada-4cd2-8cfa-08d9949f8c93
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5329E4FBEC90875DC5D76B438BBF9@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv9h6EDAhVvSfwrnIkgTWxzNdgsDwN9BphszQPL8xQ5WmHAiy2QzAudtOhM05SKlyRalypsslUsT58broXQkpQd20LcPWkf1+6K9sqMeC7P/I/eAwvvi0znAQ+WvtIlhym+T+fI0krzJv4MGWnAXrXL3hmT1JG0kVJ1qIn/MHrRTaNCMPECfSscimxeJ1evI10DOhinGSdtyph+Zv/PdqHl477ynhCCMM12zsteRctq9Kr6gXR2WZRK0D32Am31nKR3YJTQbFIQA6P5M6FrBrL2n5TEdJucuyQT6ZjtZnv1tVH0NAa1/ep+I3qOh2Fl2ZSX0bU4rLVOkFltWIl0iUxnA+arK1nS7B5k6Px4KrD+yEvL9QlDrDiMIOSYfCAzVI756HVDjIa03oSpHA+u7Rkdvz/s4MUPu/x2yG28VDBXzu+iONhFWubpfBEmw99txscOrTnUtZFBdOnVY3p6iO8O7FpisnRoydPDHfCZqSTALZlMGm32As2KwDe0AGzuoTjSJKzcTDFJ56M6pBV97Lh/Z0SqtAuLbfE+oZAZYCLdzHCSfJDkCPVwVnifFSyaud12FiSxNzpnmGXfUzrYC3nwJK5BkAB3mFbA3xGyogtAUKoJ6emI5TO4nzb9B4ks+QpkOEg/RYFVRpfwgkrL4P2WluOcQmCnJSnFn0NaQXOZ3T0SrSISM5aWgJ29E9q9uIcUeNGrXWBUKENdCW+7opFnEuDtdDHc4PwVxigr1LBA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(70206006)(186003)(16526019)(426003)(83380400001)(6916009)(508600001)(5660300002)(82310400003)(26005)(356005)(81166007)(4326008)(316002)(54906003)(47076005)(8936002)(336012)(1076003)(6666004)(86362001)(36860700001)(2616005)(2906002)(8676002)(36756003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:32:02.8397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a466a920-fada-4cd2-8cfa-08d9949f8c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
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

Get rid off pin/unpin of gart BO at resume/suspend and
instead pin only once and try to recover gart content
at resume time. This is much more stable in case there
is OOM situation at 2nd call to amdgpu_device_evict_resources()
while evicting GART table.

v3: remove gart recovery from other places
v2: pin gart at amdgpu_gart_table_vram_alloc()
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 80 ++--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
 7 files changed, 12 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b53d86aebac..f0c70e9d37fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3935,16 +3935,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);

-	/* First evict vram memory */
 	amdgpu_device_evict_resources(adev);

 	amdgpu_fence_driver_hw_fini(adev);

 	amdgpu_device_ip_suspend_phase2(adev);
-	/* This second call to evict device resources is to evict
-	 * the gart page table using the CPU.
-	 */
-	amdgpu_device_evict_resources(adev);

 	return 0;
 }
@@ -4286,8 +4281,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		goto error;

 	amdgpu_virt_init_data_exchange(adev);
-	/* we need recover gart prior to run SMC/CP/SDMA resume */
-	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);

 	r = amdgpu_device_fw_loading(adev);
 	if (r)
@@ -4604,10 +4597,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					amdgpu_inc_vram_lost(tmp_adev);
 				}

-				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
-				if (r)
-					goto out;
-
 				r = amdgpu_device_fw_loading(tmp_adev);
 				if (r)
 					return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index d3e4203f6217..679eec122bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -116,78 +116,16 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
 	int r;

-	if (adev->gart.bo == NULL) {
-		struct amdgpu_bo_param bp;
-
-		memset(&bp, 0, sizeof(bp));
-		bp.size = adev->gart.table_size;
-		bp.byte_align = PAGE_SIZE;
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-		bp.type = ttm_bo_type_kernel;
-		bp.resv = NULL;
-		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
-		if (r) {
-			return r;
-		}
-	}
-	return 0;
-}
-
-/**
- * amdgpu_gart_table_vram_pin - pin gart page table in vram
- *
- * @adev: amdgpu_device pointer
- *
- * Pin the GART page table in vram so it will not be moved
- * by the memory manager (pcie r4xx, r5xx+).  These asics require the
- * gart table to be in video memory.
- * Returns 0 for success, error for failure.
- */
-int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev)
-{
-	int r;
+	if (adev->gart.bo != NULL)
+		return 0;

-	r = amdgpu_bo_reserve(adev->gart.bo, false);
-	if (unlikely(r != 0))
-		return r;
-	r = amdgpu_bo_pin(adev->gart.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				    NULL, (void *)&adev->gart.ptr);
 	if (r) {
-		amdgpu_bo_unreserve(adev->gart.bo);
 		return r;
 	}
-	r = amdgpu_bo_kmap(adev->gart.bo, &adev->gart.ptr);
-	if (r)
-		amdgpu_bo_unpin(adev->gart.bo);
-	amdgpu_bo_unreserve(adev->gart.bo);
-	return r;
-}
-
-/**
- * amdgpu_gart_table_vram_unpin - unpin gart page table in vram
- *
- * @adev: amdgpu_device pointer
- *
- * Unpin the GART page table in vram (pcie r4xx, r5xx+).
- * These asics require the gart table to be in video memory.
- */
-void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
-{
-	int r;
-
-	if (adev->gart.bo == NULL) {
-		return;
-	}
-	r = amdgpu_bo_reserve(adev->gart.bo, true);
-	if (likely(r == 0)) {
-		amdgpu_bo_kunmap(adev->gart.bo);
-		amdgpu_bo_unpin(adev->gart.bo);
-		amdgpu_bo_unreserve(adev->gart.bo);
-		adev->gart.ptr = NULL;
-	}
+	return 0;
 }

 /**
@@ -201,11 +139,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
  */
 void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
 {
-	if (adev->gart.bo == NULL) {
-		return;
-	}
-	amdgpu_bo_unref(&adev->gart.bo);
-	adev->gart.ptr = NULL;
+	 amdgpu_bo_free_kernel(&adev->gart.bo, NULL, (void *)&adev->gart.ptr);
 }

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..2440278a3b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,7 +992,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}

-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;

@@ -1062,7 +1062,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 static int gmc_v10_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0e81e03e9b49..3a8c9d4ee06a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -476,7 +476,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;

@@ -608,7 +608,6 @@ static void gmc_v6_0_gart_disable(struct amdgpu_device *adev)
 	WREG32(mmVM_L2_CNTL3,
 	       VM_L2_CNTL3__L2_CACHE_BIGK_ASSOCIATIVITY_MASK |
 	       (0UL << VM_L2_CNTL3__L2_CACHE_BIGK_FRAGMENT_SIZE__SHIFT));
-	amdgpu_gart_table_vram_unpin(adev);
 }

 static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0a50fdaced7e..ab8adbff9e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -620,7 +620,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;

@@ -758,7 +758,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 492ebed2915b..cd3a4bd8fed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -837,7 +837,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;

@@ -992,7 +992,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..8732da11ad98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1714,7 +1714,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}

-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;

@@ -1793,7 +1793,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 static int gmc_v9_0_hw_fini(void *handle)
--
2.31.1

