Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DE260FD8
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77DE260FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1E36E927;
	Fri, 22 Oct 2021 09:32:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FD389FA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLdzteKjRdw0+p74/opXKR21O/OKiPgG9lAW9oL9S6pwDHqfY/wS/Y2QV45H/00+ns16VKDU4PisIV5Z72Zp1b7GqfrPN64Sz4ES/dneCbv6Whni+KX6bvvlwWvtqyZB8d3WoC179OAxRMu8ySYH0vCIMsztDRnbpepQpTSXPvH+2QpJ36tcAzlPELJUkevF9ggTw6HLyW2NtHmAC5mrizx56jGhIvoahOdgI+haO2MqYQp1wer9/5aIgXvfE649/aVuUQVxOJEj4qhwrbcaagSxXzNpwt5K9HaugwgUEVrEuOImHVNM0OvkPs+BpWuD85fnqUOpO4wiFF9uBZpFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d/yn1ux2DwsRj3yc18LLqOKh2IzOpoOBtAZYAOUC/4=;
 b=BbmLQ6IiCyW+HFyz2dGd+buMTz0dRmUu6hl6Tru0L6/HOfXwL4r9NoUHgVTRYCoqAmelmkA/vSw1/VO12m8mAeoRLdql5h0xBXsfjGQXXOdJSrtRP54WwyoBnbqCjYy1eZkHVghIvTRu7a5X/uwF8uE2eNJJfInupaB0ooVqGSkxP4XQSSG6AfkdpPQCQxj55G8XrYxEhyLmgE/UItrZIo0OS3w8exzPksTAQs0HKn0GvSbwZmbEelAQ0xk5m0mHeM4Tpd/h7sCEgMQxk92S7+eUIbY49DlKWCPwYyJQ7G3kx/2q6WmvvX/jN92Dal/hl/prhrPZCNU8hYYwPhJrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d/yn1ux2DwsRj3yc18LLqOKh2IzOpoOBtAZYAOUC/4=;
 b=4MbsOh7ec21jyx6nuaKAqSwkgB7c3ObLOIyYcH/Cd90Kd40ns1EE8FgAEUfXk8g+tqWUCA6p42JnCi/WbqumfgjEcnHsvVC3TF0nGG12oakfc3ON5715PpR5mihpfjLLWSKh2e6V7lMNCaPaEbtLMN6muEERhBwJ7r81FdTKV1c=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 09:32:46 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::22) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 09:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 09:32:46 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 04:32:44 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: recover gart table at resume
Date: Fri, 22 Oct 2021 11:32:31 +0200
Message-ID: <20211022093231.7787-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211022093231.7787-1-nirmoy.das@amd.com>
References: <20211022093231.7787-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d604fffe-90e9-4e8a-0c07-08d9953ee820
X-MS-TrafficTypeDiagnostic: BY5PR12MB4051:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40510031E538F92A7D142FAA8B809@BY5PR12MB4051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6d8IjMuPVJ5tQzXHSl8bXsFCnmGLSuimELszpVLmR8wv0pcj8oXGZhq1cCLe5k0fYx0vWhmI2T/1GUNdnYSwrceJnGawQjEtmqxMyvmEXTzQ8W13Pud1nMKwgkLOKa9nUw2QawXQIpIAbOt32gZ50Ea8w04vTIJw4Mj3KF1xVWjVnJm/JhXDjoKSADEkDT3UyVnprVsBNctdEC3WweJFNx+iWnDULKyrjQevCL2NMgMwzcZAx1a7y8F5tw1zQCAZoA6MfKeXkVh159lAUFfDmhWtJySHEvn/hkACYGPtyB1SO2FMte6XGA+j5f4EZDw+WPfVoQM+/9mEa4LwdPIxfKNynpxJIHkK/YOEwLH92ma0Zb+p2cno0jLVY+axSG6RJf/kHLUysc8d4ANFvY+9kuK/kpiNEkj/oZCD6si0A563Qi2+f6pr/PWVvmjOnuydtnJWNe5I+hPNyClSHXueVNP6kP+WgMDKTD34mgkH1Sghto/peM3SR17inx+gxSCHQctIv3DgVzXf6PMcVnuk8wX66UDNugSANV0PUbAY7vEmsy6FVD8VcZxm4opYt3vqxIuGmLMz7VkA6TsqyK9qCRjO3pH0FgWdQ/Zi02Wj/8d5UM16Xb2ZamQWYh0fdtjlWxJC++Ideq4I5abutOCmCGN/R8lWdqr/CDce/8Q+zTyeQizdybNziA+X78hFbczXpwdfyltGTjF0gq3pdBQ3EcL2LL6Ybc78ZXrvduuM05I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(2906002)(8936002)(7696005)(186003)(70586007)(6916009)(83380400001)(426003)(54906003)(81166007)(316002)(70206006)(5660300002)(36860700001)(36756003)(86362001)(82310400003)(336012)(44832011)(508600001)(1076003)(4326008)(16526019)(26005)(8676002)(6666004)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:32:46.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d604fffe-90e9-4e8a-0c07-08d9953ee820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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
2.32.0

