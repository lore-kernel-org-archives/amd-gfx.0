Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB51C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 07:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AEE10E571;
	Thu, 27 Jan 2022 07:52:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91FC10E571
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 07:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU3wmfRpw+ufKXSjVxdKCUakPqK7zFr+n/s8K8eCidrJ4w4CEio0D+xxHrbDjCJkO2amlUk7hMMCE+69JhnSqDraBLYjPw9BqWkQdyVSCUWNcAEdqbLrxxc2ZJ2AWJnecvxHg6OuYdeT9J4Z3J8rl3a90f5VAngLZKBAo6GT/Kekr/RG2yJMqY7eV2j35+t6jeavGTO2Mjzc+BXZZxWXll1DIxyEBgTuOi36khNyAeYqCz8eUxD0Lp7reZJjtq/cHuhkcMoFfW501W6zz/OpTBcE+CweIC0gZjH+82sKQNAZkZIG69hlUKJbOTkuC/GP8Pshijo5fN2HU9VBiZxCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLhLETy3HZbjuMvcn8Pm63qhuJs7whOvEaJ9AyXKqEw=;
 b=V2lRqt6yh772wz3VkEIAzRDf41j3FBEMeezg7RBuRMs9FZmE85rauQ9oZZFnYFsHeJXgjLrxu072C3LGQWBxrMDUSTJZThiGwYvvfHYUcFBfA8sCeEFSUHXDSZHC09RdkpKFomIcgva5hdxFuS41Kl2aIY3ZOFMdxAMBsiE5VPgAfHcaT+R2QXbsJkz2CMZ0W7ArE44PFSNo2amrFQe6N/T9FbK3jZRa/LsWIODrXLBPfZC94ptDqA+/na/sxOwztJdxK4it7m4eTk+Q3giE1MuOd0WvRvYrc6KK62P23GFrfU6S4iy3+YUcEWNTeik76jqYQGCbQrek+OGKJZs7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLhLETy3HZbjuMvcn8Pm63qhuJs7whOvEaJ9AyXKqEw=;
 b=VEl1KfehZMuO3DAQ5Tm3U1V0GlrMFCrcAL8l+Tn1jVtbb4QT+Dv0aNqDTxhwSSYzOm2oE9LO8D5SbOYynSoYTHDDPlSg1m2EBr8M3PwXvxbATV2PPCRWWgqEY7+mGGN/vx5NfZH0xffXDzJT1W0q4cAL86BkCu5ZydipyiUkouE=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:52:40 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::79) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:52:40 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 01:52:37 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init(V2)
Date: Thu, 27 Jan 2022 15:52:25 +0800
Message-ID: <20220127075225.3040986-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac4c78e-3162-405b-6052-08d9e169fe8f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362E3FCB5A974747E70B824F0219@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm5qHZXSg0Rr/5t1pDd/TkjlqbJ2YN/MKkj7eTnZzNPTnqvGwjU+VmSvFQBCsAnRD9WKIWIjEteH4OUXJYH6m1K861SxSCKZw/iwEezTLr2KYjOv7UVadEwzilHHbvIRUMGG0Lx+h/2VVEhC19SO9AdxbpW7Jcv04R06Fci4akxzqQHg09gnADx/7MHUaDVJ+f80DOEXbmvwCb1LeQ5DMxwPJVnNa1yg22xTF7oaZ6xXIS7etXXIS1BYLAzzFWITb5+GWF5Rv0Rk03hytTB/LaQFuMetdcijZ4ALDD2o6UoQLbwBsbklQO2OOMXwTtk6uQJMc0denWulJPels5ZYQpKiHPeZrigcI6AH7lQE7OrsqNUfeGu9Rv3SSNPzK0cUfrhQKSLsjHel9f76gmAgAY3MWRRc4xH1cDmcZL5H3TCYSbYEyH9mhWnhVq+zn/mhiNY2rWKKglpg7UovBjAExMRoyxHxkM8Ck9LstuVLEBqLo6SH5xR2LoW5QoL+vmohlDmxa4ns9w6pyCgiMqX4rxbLuMz9wm5yA/BkvyNmhyzEEBtqSm9WFWxukBePWCPvkzNrDt3WJv6c3L5nIr5QnqrySIcFzCUZeiUi0EEYHlHldkDk+BH+zwwov5F5tmBn1wOUpa5jJB/O9K8P6bMSzthB5OLrgNnVIqS0bWTVEY9xmNYOpLPTQykdJDNnwXlWLoxAP36G4CSlwPtmPZtw0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(47076005)(5660300002)(44832011)(8936002)(8676002)(86362001)(36756003)(54906003)(40460700003)(6916009)(316002)(81166007)(83380400001)(7696005)(356005)(6666004)(82310400004)(26005)(16526019)(70586007)(2616005)(70206006)(336012)(1076003)(2906002)(36860700001)(426003)(4326008)(186003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:52:40.7635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac4c78e-3162-405b-6052-08d9e169fe8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
Cc: ruili.ji@amd.com, jonathan.kim@amd.com, felix.kuehling@amd.com,
 Aaron Liu <aaron.liu@amd.com>, Ray.Huang@amd.com, Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The below patch causes system hang for harvested ASICs.
d015e9861e55 drm/amdgpu: improve debug VRAM access performance using sdma

The root cause is that GTT buffer should be allocated after GC SA harvest
programming completed.

For harvested AISC, the GC SA harvest process(see utcl2_harvest) is
programmed in gmc_v10_0_hw_init function. This is a hardware programming.
Therefore should be located in hw init. Hence need to move GTT allocation
from gmc_v*_0_sw_init to gmc_v*_0_hw_init.

V2: expand to all gmc_v*_0_hw_init functions.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  8 --------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 13 +++++++++----
 8 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d426de48d299..ac75bde8ac61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,3 +876,24 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_gmc_allocate_sdma_access_gtt(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+
+	if (ret)
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
+	return ret;
+}
+
+void amdgpu_gmc_free_sdma_access_gtt(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 93505bb0a36c..b8ba16de5e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -338,4 +338,7 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
 uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
+int amdgpu_gmc_allocate_sdma_access_gtt(struct amdgpu_device *adev);
+void amdgpu_gmc_free_sdma_access_gtt(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d8a20956b74..7ce0478b2908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1823,12 +1823,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_GTT,
-				&adev->mman.sdma_access_bo, NULL,
-				&adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
-
 	return 0;
 }
 
@@ -1850,8 +1844,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (adev->mman.stolen_reserved_size)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 				      NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..d923e4127c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1062,7 +1062,7 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
 
-	return 0;
+	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
 }
 
 /**
@@ -1082,6 +1082,8 @@ static int gmc_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gmc_free_sdma_access_gtt(adev);
+
 	gmc_v10_0_gart_disable(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ec291d28edff..ca397d4d4aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -919,16 +919,21 @@ static int gmc_v6_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return r;
+	}
+
+	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gmc_free_sdma_access_gtt(adev);
+
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v6_0_gart_disable(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 344d819b4c1b..11f87f8adae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1107,16 +1107,21 @@ static int gmc_v7_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return r;
+	}
+
+	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gmc_free_sdma_access_gtt(adev);
+
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v7_0_gart_disable(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ca9841d5669f..c90f9016d093 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1238,16 +1238,21 @@ static int gmc_v8_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return r;
+	}
+
+	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gmc_free_sdma_access_gtt(adev);
+
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v8_0_gart_disable(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4595027a8c63..9b4b1d9a0769 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1852,10 +1852,13 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return r;
+	}
+
+	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
 }
 
 /**
@@ -1875,6 +1878,8 @@ static int gmc_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gmc_free_sdma_access_gtt(adev);
+
 	gmc_v9_0_gart_disable(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.25.1

