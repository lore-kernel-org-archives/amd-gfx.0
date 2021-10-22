Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8992060F02
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8992060F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DACF6ECFE;
	Fri, 22 Oct 2021 10:54:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DB06ECFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 10:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdYYGLEmpVR0xSrlDNBzT5UP9J0DCpmjqGFwXUGDjnxXjorf5yjROhjermDRa0Do1yFY/tEi+eXaweeDRWDoRoGLv2axBEJIcN9q7HdfdO3W39+OghsqFVQ4w1WTR2azw2VmhBUcRj1L3f02VsFnmG9VpCjlami+QlOgTuMgfFF9uWTiaiZc0ZoVC0/pH111rN0rB6Fkf6BWg8e9GtAK7EC2DfCwfig4RZ/GquPZF000KIxEp6sNqldjc2LqfhfFRnw5/NY8dLOqByxHm/CbvctnBs0ZtVWNUZ3z+uR5x7GfB9/fL20rK2dVdGjx/L3YH08pamUxukMPfkNuu7QVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNlynpdERYYPNoVj8g5fAlfOxSjMlfUQBe9GV9Bel7Y=;
 b=jkKTgSfZsIgkXm7qMMpu92zYmqj0xoi+yvkaYp20voI3kTiuw+efSbZOwIgb2PwTspFRqou/9DpvNBUxjbmn6K7m9qjURelyHgJCuntCTw2vQs4o9TsBaAnljL7vPm+8WJPZ52ITEKaNLXC9em7tL6sFS4uagjx3Ikmlc8NVekSwOiRLzFV2TXhjOoh7jzvWwfaMSfyhgoZZICrWU5nq+6gw2wfiyRnHF5JA0MC6arq06ntomV5MHcn3qKJqheKpRc+Wk6CBB77UmnvP8CcqEvOb+Bc4yptt5xzbmLZ/jvODgztFDDuBgj6qnZqKY2Ppf4kmrKopstKWA17Vg6jTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNlynpdERYYPNoVj8g5fAlfOxSjMlfUQBe9GV9Bel7Y=;
 b=sSaohsqkNljS+8MiXkGrXWZ23us02prNUUU6a7shQVn7ZRkbhQ5VHcY4A9V4Fq6t51zct1s5MdPj+QK7xGrF1NQBElniD12J1DB0eiLJghxdiKt8JBUJ02iezyGHzlx0PcIzUZqEXbrW/VToc7/KPlRcMndIh55b521BGdPRIHs=
Received: from DM6PR13CA0065.namprd13.prod.outlook.com (2603:10b6:5:134::42)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 10:54:38 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::12) by DM6PR13CA0065.outlook.office365.com
 (2603:10b6:5:134::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10 via Frontend
 Transport; Fri, 22 Oct 2021 10:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 10:54:38 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 05:54:35 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu: recover gart table at resume
Date: Fri, 22 Oct 2021 12:54:23 +0200
Message-ID: <20211022105423.69769-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211022105423.69769-1-nirmoy.das@amd.com>
References: <20211022105423.69769-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e9b48e-f4f7-4d6d-a7ec-08d9954a57b7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5491C4D454F31C622B2A35618B809@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pnryqPNb1L/DFOupStQETdC58J/iUsQuT4XaEwTi9YZptKU2OvFWiLTv6aSB4kMF4PRw0C8mE1piap3MOLU2tDO3Tb6DVjTP3Uqj36B96IgnKAUgPYNEK7bVSuCEdueuMdpHWyZy47HqPZxgWeASNWUc70UhD7B7E0sO4ouLzjd91kw3ocYP5Kri4yIYIhq3T5CL6oEmRXFBmqHOqAmYXrgEQOj81afAbvrIqISC9lNeyo4M5Mg8I+/NGmS1Vx34BdxaBjxY5qt3n+PrOOV4f8yf5gKAwLy4G8bRH5odCquczxfomlRyiTuoZxZ3o8h7OJhP8UVbZHc2KYO5LqNH9cyFOcvzPvZiSpv38IY8ZoG0WMcicPxGnKspg9jix1CO7v5TIDx/uuv1FfdCUDm4EXlwvr+L23ee0cnDi5DH1HrDiOJFlLc+lE5xwUBX6h4H/y1mGaJO9uq/9/za1nAzq9W5hCNrUuB9Zt0WO+rapJeGfccGLfSwZ8ZenJn9wyr7QwiPPwbbVqdsrBe+f7b2iT0so2/JN2AzI62YmvrlYjfAxBt+hVI8hlmRoFz+81CDc7gnvGHeFF2BIHUuRMHxJKF572rDr2M0HWrquFgp51uLnt3ETYwJ4Gq17op3LOfVh67B3sHF1zM3rwknPOfJ500gGD56NvUPI1NA9eojTcveIsCP4znNntJxbq4KnlvHb7bPJ6w3VA/jUebKfZemHaUdTSZTXE1RayywFNZX2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(5660300002)(2616005)(47076005)(6666004)(7696005)(86362001)(336012)(8936002)(426003)(36860700001)(81166007)(356005)(4326008)(186003)(44832011)(83380400001)(36756003)(8676002)(82310400003)(54906003)(1076003)(16526019)(508600001)(70586007)(26005)(2906002)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 10:54:38.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e9b48e-f4f7-4d6d-a7ec-08d9954a57b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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

v4: return amdgpu_bo_create_kernel() directly without checking
its return value.
v3: remove gart recovery from other places
v2: pin gart at amdgpu_gart_table_vram_alloc()
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 82 ++--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
 7 files changed, 11 insertions(+), 97 deletions(-)

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
index d3e4203f6217..3525f87dc1af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -116,78 +116,12 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
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
-
-	r = amdgpu_bo_reserve(adev->gart.bo, false);
-	if (unlikely(r != 0))
-		return r;
-	r = amdgpu_bo_pin(adev->gart.bo, AMDGPU_GEM_DOMAIN_VRAM);
-	if (r) {
-		amdgpu_bo_unreserve(adev->gart.bo);
-		return r;
-	}
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
+	if (adev->gart.bo != NULL)
+		return 0;

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
+	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				       NULL, (void *)&adev->gart.ptr);
 }

 /**
@@ -201,11 +135,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
  */
 void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
 {
-	if (adev->gart.bo == NULL) {
-		return;
-	}
-	amdgpu_bo_unref(&adev->gart.bo);
-	adev->gart.ptr = NULL;
+	amdgpu_bo_free_kernel(&adev->gart.bo, NULL, (void *)&adev->gart.ptr);
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

