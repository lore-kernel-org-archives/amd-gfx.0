Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43958C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC3F60FC1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DC3F60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC106E598;
	Tue, 19 Oct 2021 18:15:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB086E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ickg501vvocAKakVrcGVUsLo8kdZMXo/Z+pSoz5Lf4zpv/E2v7vWbaVYeoRRdUP/KX65gC8hYMYY+AF8r4oVXP+mLLljSTrochFnuWHWklcYpZHLZB+ckoGGjhtDVx8HDzBNxCXoY5PF38cp3wGnw+xk3jI2t84o5Jq3TwO65UwhxgQNTmNtLLT4jU5msd8kQhlv1oLZuRtOeTfwo0B9dJ/ytpEZdRYhZmHY5TJcBvv+uVxkRSKFh0yHWH5jpaNMmwHvVdp2EkAGAxtw8hhf4uqBchMH+rHTC3rkraNIoRnKQoOJPL2QsVfalcR6FdO0JJ3HSjClF+uNM2ENGytq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgrPEczdWo/XpnBUef6h1DslrLlekqjnkHqjD06+yCo=;
 b=M6mGPnSbYniGMM5JCfcF76tvMvzORCqZdNv9DOx7t6V1D3J7x5j4WtBgMTzL4G4kUtGmkuEAzH/tTN4XRYPq3fRF4A9R3O2E6oXUPmI/qyQX//mTzSLu8ZW1Pex23UOgVPGx8ba3IE6fLUCQqZh1qV+vxjUxwUXRnGLetE8g7z64/i4Die8GsrZy9OTg6aB+f51Z42wRiyBk74tyhuzl/zfle6wWQvn5E8gx+3Ff1/VpI2gt+iveuQtuUxsNujCJAhXurBiVl05ql0vtGP2f+Ppd+tWL/twwSwKzR5MLNC0QyViA+05JNGgnCtr8nVDuY969MZWv5zzRZw+jV5WZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgrPEczdWo/XpnBUef6h1DslrLlekqjnkHqjD06+yCo=;
 b=Ii99exFsLPyfJEYiW0JMtz3TqON/aH8qLHNvgNsJCW7NYakdtPJmvkxMhv/rI7YTAGvlk0KwXK35ACNcHmFbs3l0yR4/hZrgHcIzzTnFP/bOXjYmN+GT3WVPaGBAMliIKIPDuzf0vUgF1B4e4Vty52SYiu6cDe5okHi+gee/2x8=
Received: from BN9PR03CA0910.namprd03.prod.outlook.com (2603:10b6:408:107::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 18:15:12 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::90) by BN9PR03CA0910.outlook.office365.com
 (2603:10b6:408:107::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 18:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 18:15:11 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 13:15:07 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Date: Tue, 19 Oct 2021 20:14:49 +0200
Message-ID: <20211019181449.12356-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019181449.12356-1-nirmoy.das@amd.com>
References: <20211019181449.12356-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7721e1d6-9a09-48f7-2d01-08d9932c640f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302B23681780B2F076E4FBE8BBD9@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbAWuaEgNJG6+C834knHDBanHGG/myjz56+LfbJbRb0Qk9yMMsz+2f0K/tW0sFAZsUejKwMMDqcoLlW7Bw1xYQ7b74UTwNCeK0fE/LBGhNrIK7w9oUJsTp2HhERgE3lfmr57wqfBmqh+WTVhG+uiE2Q05+anJHgXrB7AWKVbisx2m4YRaSGzPGbYWBqwtxtGW3V6u8DOpj2NVVd7VlrzPh0lldIQTOt0DGZKFl9yovYw6ZIgfYwZATB9Wa0sDrQGqGX0T5Tuiqs+KspC0ttVDPkIgH1gu5njZ2+YE73ASzGMoScsKQl3hYS/jGf/JLrq81f/nD+O89H2B3vVewK/baoNmz16MCLFZvu+G9pWhBwAg7LwHrHtg7+QNQ1PWmLXmlVR0FU9j92lUYs5TfbO97hMM7lMvlZzVITGdazZkyXNKGD6zghjIORqsTSrxLpMZAQ8ptitojzcEVJoZGUrnFRqByquzJaIHtAtwdQnaOLmD20zb6OlkM0WoWsDSFyIKxythfVs+nAAdY3TqgX1179RpSj4wdUs3nn4/zo1WGmW1txnjhZyCY7ybNA8nkTn351UKOtdnQmIkiHxsrjmtvaII5CnVSDyVJjFJchr9jPEgL3bQaMzXryhTCmlUUoq1QLYM+6WnismXWcgtVsib5yzxeUQ5fg8pArwL+bkuvPf1le8RX5O5+QcdQH1W8ZUDOLKLrc5jdsSYpfwIV2/nOzZIR808je2aRDIPHBRsgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(16526019)(356005)(36860700001)(6666004)(26005)(54906003)(5660300002)(8936002)(2906002)(82310400003)(1076003)(8676002)(70206006)(4326008)(508600001)(316002)(336012)(2616005)(47076005)(36756003)(86362001)(81166007)(6916009)(70586007)(83380400001)(426003)(44832011)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:15:11.5702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7721e1d6-9a09-48f7-2d01-08d9932c640f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
 6 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5807df52031c..f69e613805db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_fence_driver_hw_fini(adev);

 	amdgpu_device_ip_suspend_phase2(adev);
-	/* This second call to evict device resources is to evict
-	 * the gart page table using the CPU.
-	 */
-	amdgpu_device_evict_resources(adev);

 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index d3e4203f6217..97a9f61fa106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * Allocate video memory for GART page table
+ * Allocate and pin video memory for GART page table
  * (pcie r4xx, r5xx+).  These asics require the
  * gart table to be in video memory.
  * Returns 0 for success, error for failure.
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
+	struct amdgpu_bo_param bp;
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
+	if (adev->gart.bo != NULL)
+		return 0;
+
+	memset(&bp, 0, sizeof(bp));
+	bp.size = adev->gart.table_size;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
+		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
+	if (r)
+		return r;
+
+	r = amdgpu_gart_table_vram_pin(adev);
+	if (r)
+		return r;
+
 	return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..75d584e1b0e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}

-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (adev->in_suspend) {
+		r = amdgpu_gtt_mgr_recover(adev);
+		if (r)
+			return r;
+	}

 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
@@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 static int gmc_v10_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0a50fdaced7e..02e90d9443c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+
+	if (adev->in_suspend) {
+		r = amdgpu_gtt_mgr_recover(adev);
+		if (r)
+			return r;
+	}

 	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);

@@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 492ebed2915b..dc2577e37688 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+
+	if (adev->in_suspend) {
+		r = amdgpu_gtt_mgr_recover(adev);
+		if (r)
+			return r;
+	}

 	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);

@@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..732d91dbf449 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}

-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (adev->in_suspend) {
+		r = amdgpu_gtt_mgr_recover(adev);
+		if (r)
+			return r;
+	}

 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
@@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }

 static int gmc_v9_0_hw_fini(void *handle)
--
2.32.0

