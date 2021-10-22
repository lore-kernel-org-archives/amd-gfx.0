Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5259C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7736108D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F7736108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3126ED0D;
	Fri, 22 Oct 2021 10:57:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628CF6ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 10:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwEwMqPpuu4/b7e7DMTduZOEyephnvYlsEWN48GQ1tH6Kek7XXQ2yQsesa5BCR5xrAsKtPTgiJjAX+o86LzxxgH/PXLg2x3pwoMCbBN1RFPZNBUozY9ixZM+0CGRn/RjHHu4NSJ2eJutdYUxMXIag3rsCJbJ7NEWyNU1rRNYwBEGT+Eu8zChOAU9h54JjVpQATzNt6noStmlEaSIc/4vECBxHrxBRaNr9P/sD6Ts/jLsBIvFZtASV+wlfoPVJENrSX0pppQYrbly3fVHqmThbe6SF9vxpfReJufa/g8qEBfIyGWjbtWthbbbIBOa8Fkkj4TFDBbDvQNUXTWjPL5T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqKyVXHAWSz2lPC2giJ7gxLeO/ttprNnSc3QqxyiGr8=;
 b=g3ScT2Pz0OzXCEbNaiepDEz7IF3mXLckzuDs13aXxYr2JwR7gsEETk1q/wKhZ5IZ07rsLfPbvP/TMjml3zjc+5q07fwEHC+uM23uV9Oe5nfs28Fja5SFtF4jDF/beuJyDwqdR51sIPiSeSc5Dbu5wa04dY9k9S8kRbixuC1cqP3JRf7b7OxQ9PaSh8wCHwD0rVPCocWnABKNBpw+ueAalRHSH0mnu/rWtMSG6mlVBNBooj+A59rZPOHiWKVYscJG555J6Th3ZsRDUhdyVvhinJSzbbgwVkCw0sRNbAn0g7tgPzXu78+kB+FDbAE0+XzJlqbefeOY5EMyEnsQ2yZI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqKyVXHAWSz2lPC2giJ7gxLeO/ttprNnSc3QqxyiGr8=;
 b=ZjyPbOAeBJRfO72Xw8Zj8oKiSRqapzA29no8OPi6eQNcM6+8QzptsSOMorVPOfUJUSe29wU9ffyveG1XUGbQaIDh/1pQucMSgC/9Wj6eFCnl3Av8PICK+58xYyMfm9FewATgwj4EnlSX3vCCT5487UPpyOzrpjWYh9OiyL9Ed6o=
Received: from DM5PR07CA0148.namprd07.prod.outlook.com (2603:10b6:3:ee::14) by
 SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 10:56:56 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::4) by DM5PR07CA0148.outlook.office365.com
 (2603:10b6:3:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 10:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 10:56:55 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 05:56:53 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: recover gart table at resume
Date: Fri, 22 Oct 2021 12:56:45 +0200
Message-ID: <20211022105645.106997-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9fed76c-0818-483f-e6e9-08d9954aa980
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4463EEC9316A22A99C1958098B809@SA0PR12MB4463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIlg7kFpqPCcGWL0G5dNvkQNVz12DpP4A/QmUryrBkYJVqX29C5rdwenFWO09uShFeCt0a0T3nmBZkLdJ+XAm/C/2jcrnWvLraQXesPwMGy4AF04nYgxkGNpOHNEe11Zo5rDS2attrqmcG6/QHKCNivlkt5n9hgonO1MAVKwFc3TDqEIr39poKCb2SVf1soo1DFhH4CELb2BCgZsrFIcbMgTTGugfdv9yiEjx5xV0D7tFqwiXUv6kZHdv6ANs6aKpjHX0VzqIsYUYNBqwnF0rSVZWLfcsNsapY8wa+HVya4Qn+v07G9VAB74eQsW7Yt9bEPadeHansCmbqFMfkHe4v3XvlUIMoF+Vf1tgF5rY+DXmbrYlBwnNUdwHb0w3uiTGxoRNGqb8TK4D7R3aVxDsLBnWbJPozh1JEsnnHMP8g/OkOGR7lPt9it+h715sIBM9mY7KcCzi1y6oEKTu8vzdFd4fbgVQC5guWh6805w3ir68nDQC4xU6QU9gBQqE3/Jfb33MJlz0x9pOh1JWmw4+t3zDcvsB8Su2i97suDQAPaTGl7StdzPccIJNz1bdD7kjvOZpnH1VXe3gFek95/UZJ9vVzVb5FWoNyVYKLTeCQMBxSw4KIOpfsAvGaG2A6aGN2KfyBVhYmEtkBA73Grq3gC7KTiXCm7aqeBFG9+7YFjLCHNcye6PGEbmczIuIOHN5rFrQ1HjVYccjcYX0YlDB4E/XtuYdmsKbToPYI7OIKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(6666004)(6916009)(8936002)(508600001)(47076005)(5660300002)(186003)(16526019)(54906003)(7696005)(82310400003)(81166007)(8676002)(44832011)(2906002)(70206006)(36860700001)(70586007)(1076003)(36756003)(356005)(426003)(316002)(336012)(2616005)(26005)(4326008)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 10:56:55.2552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fed76c-0818-483f-e6e9-08d9954aa980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 84 ++--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
 7 files changed, 11 insertions(+), 99 deletions(-)

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
index d3e4203f6217..645950a653a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -114,80 +114,12 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
-	int r;
-
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
@@ -201,11 +133,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
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

