Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057CC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C98410E8B4;
	Fri,  3 Feb 2023 19:09:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424E610E8AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5eoTwwqLO1FMc1DvZkdBPy/reLs6zyQiG+IwmyJi8AP0LsY/sb0apbMvO7ZhGfinLHP0pg1LhI/pRO9s3FeNMQMZQjL6SOE4DZFk8bxBn2WHJRD24EyC0T009UYSgjdaOzKzg5jiYUXAk2Re4whKMnZpR4EiGyY/VPtGJUv5osba7bMV7Hp3T3h/XszpiW8IixUsxXjt2cLooiRH3IbF7mBOgSUjxOUaPmyhEXTxquXK/Gdtezs8ymkR9wHjCVxl1WFKrcNX7uKCovGoGVcV+Ai6sGb5ld3jdLNVl8XU0zYa/0TnXSRyKCmr2umXCw2c9mKIGM7dX5ofEZr2dS6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl62eKqi4QASAXg6y3vpd1yzWCObd3FV8kDKO4SLySE=;
 b=mpLjqcmy+KiY6pNT7XsyS4YoqihBGxH45UefMX5TU+snvEdPv5XoCMsfwSjX0s6ubORkVTZ7ceipBnVI4dxDLC2mielYuv0sJSX3bb/59St0Qmc7eIf//nvv6U4I9UF6qZeIr8ddfX1xBImJOyYvmBJ7oYy3FtUbzJYWAhufBlmCuI2BSe9SWAW5JY6Gekdo0H0tFBBkn84mcs6V/c+Rc0mVusN+iC47j9san1N6k7PNQLuIP52/FD59vfph7bQtSbylgKEhCnU8KmC/eAhF+ez2OEpRVbmoyDNCQYW46cy6sa3FhJbHfqOay8IXT8oazodESMYl5JoeViPXWEPRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl62eKqi4QASAXg6y3vpd1yzWCObd3FV8kDKO4SLySE=;
 b=W8dNfhEGe/U+C4sJlZc2VZHX+Va9AEzfrU0tZq6fzmm+wWJDYb3EA2eJOv2XvOov0KLwanndVImvPdoeSay0Ln2QeyIj4d37+gtuWehPiOnlRpxY36Z/z0UQRGy+4vnWey+B7EGtH45vzCYted2cPZN7PuRgAwka4CydT6UZDng=
Received: from DM6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:5:80::45) by
 CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27; Fri, 3 Feb 2023 19:09:39 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::99) by DM6PR08CA0032.outlook.office365.com
 (2603:10b6:5:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:37 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: introduce doorbell bo in kernel
Date: Fri, 3 Feb 2023 20:08:36 +0100
Message-ID: <20230203190836.1987-20-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: c2477fd3-ed28-4c87-9c90-08db061a3270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkgaM5NpQ0fMxQKvOXoOysBSm5312bL0w1ZYFtMyiDonSO5r+p2Rfahsazok/Zw+JViQYuaS4vNt2BXHOavliT1SUhb+0nvcmc6MBcDy2R+MPXhQnNgWegk9s337twJWo/KQUP4LYSQBehrpFPs2jYwoM024sHb43CPLzmSjF5nLYtdgHR8H/jXtVrBUVWyUIpjPZqtXbFjgpAr0KWOQGceyb+4Fk7n+uGdMOXnV6hgRVy+wNRAvJv/fsUhU+z/GEaOrssDIRz7bp7/2n5F10qNo+pJoxcejjmvq9hzkJy5cBtbFHeBtDhh25fDDbA5uVyUyRoH/APnuc+kqmsHjyDzim97bJFZDIZff/HUhfElGZPrZhT01Fvtz8zZoK1cvIDWVfFKTc33kkd8bYdHygeHvIYrnph6gMZPdzbVm1S+Dkstf0y9X8cCMyyBedLGCjlltMclsj+C1JoS5r7+7tQirYFTrNfhwFgTu7xP10rLb9aX1MtOPQZyFbitRyeWqZ/NsDOCO53nuOrSNQp54Tzx13wGdZ5InpYboN3DGQv8oT4n6477cODg0mFXbGq39iQCepw1syaEb5H1RrKPqMmYswOTixn+IgfO3E4Gh1WiDH/pl2tgjHjYapY7t4VWs2GNiDP3R+eTZ4ZVafD+JyAfGfDbpu2PZ0trwx64xBqiFP3HTqbSNaVPTg8vCIBv5kzXsnAJ4e1iN1LpXdyNIR5iUMBI9xt8+GEeG9v32L88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(356005)(81166007)(40480700001)(336012)(47076005)(2616005)(426003)(83380400001)(82740400003)(40460700003)(36860700001)(8676002)(70586007)(6916009)(70206006)(44832011)(8936002)(41300700001)(86362001)(5660300002)(2906002)(4326008)(7696005)(478600001)(26005)(54906003)(82310400005)(316002)(186003)(1076003)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:38.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2477fd3-ed28-4c87-9c90-08db061a3270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch does the following:
- Removes doorbell ptr from adev.
- Moves doorbell.num_doorbells into mman.num_doorbells.
- Introduces a kernel bo for doorbell management in form of mman.doorbell_kernel_bo.
  This bo holds the doorbell space now.
- Introduces mman.doorbell_bo_size: to save total doorbell memory size.
- Also introduces mman.doorbell_va to save CPU address of doorbell BO
  mapping. This ptr will be used now for doorbell read/write from doorbell BAR.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 16 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 24 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  6 +++++
 6 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e1c1a360614e..dd3875ae1ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -834,7 +834,6 @@ struct amdgpu_device {
 	spinlock_t audio_endpt_idx_lock;
 	amdgpu_block_rreg_t		audio_endpt_rreg;
 	amdgpu_block_wreg_t		audio_endpt_wreg;
-	struct amdgpu_doorbell		doorbell;
 
 	/* clock/pll info */
 	struct amdgpu_clock            clock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 28076da2258f..aea943e337df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 		*aperture_base = adev->gmc.doorbell_aper_base;
 		*aperture_size = 0;
 		*start_offset = 0;
-	} else if (adev->gmc.doorbell_aper_size > adev->doorbell.num_doorbells *
-						sizeof(u32)) {
+	} else if (adev->gmc.doorbell_aper_size > adev->mman.doorbell_kernel_bo_size) {
 		*aperture_base = adev->gmc.doorbell_aper_base;
 		*aperture_size = adev->gmc.doorbell_aper_size;
-		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
+		*start_offset = adev->mman.doorbell_kernel_bo_size;
 	} else {
 		*aperture_base = 0;
 		*aperture_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c21ffe63ebc..9c3ce1ae66ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -593,8 +593,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return readl(adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_doorbells) {
+		return readl(adev->mman.doorbell_va + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -616,8 +616,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_doorbells) {
+		writel(v, adev->mman.doorbell_va + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -637,8 +637,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
+	if (index < adev->mman.num_doorbells) {
+		return atomic64_read((atomic64_t *)(adev->mman.doorbell_va + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -660,8 +660,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
+	if (index < adev->mman.num_doorbells) {
+		atomic64_set((atomic64_t *)(adev->mman.doorbell_va + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 464be28da4fb..97298a98561f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -24,10 +24,6 @@
 /*
  * GPU doorbell structures, functions & helpers
  */
-struct amdgpu_doorbell {
-	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
-};
-
 /* Reserved doorbells for amdgpu (including multimedia).
  * KFD can use all the rest in the 2M doorbell bar.
  * For asic before vega10, doorbell is 32-bit, so the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e38720b91958..8f0537f16cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1742,7 +1742,7 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type < CHIP_BONAIRE) {
 		adev->gmc.doorbell_aper_base = 0;
 		adev->gmc.doorbell_aper_size = 0;
-		adev->doorbell.num_doorbells = 0;
+		adev->mman.num_doorbells = 0;
 		adev->mman.doorbell_aper_base_kaddr = NULL;
 		return 0;
 	}
@@ -1759,13 +1759,13 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
                                                     adev->gmc.doorbell_aper_size);
 
 	if (adev->enable_mes) {
-		adev->doorbell.num_doorbells =
+		adev->mman.num_doorbells =
 			adev->gmc.doorbell_aper_size / sizeof(u32);
 	} else {
-		adev->doorbell.num_doorbells =
+		adev->mman.num_doorbells =
 			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
 			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_doorbells == 0)
+		if (adev->mman.num_doorbells == 0)
 			return -EINVAL;
 
 		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
@@ -1775,7 +1775,7 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
 		 * the max num_doorbells should + 1 page (0x400 in dword)
 		 */
 		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_doorbells += 0x400;
+			adev->mman.num_doorbells += 0x400;
 	}
 
 	return 0;
@@ -1901,6 +1901,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	adev->mman.doorbell_kernel_bo_size = adev->mman.num_doorbells * sizeof(u32);
+	r = amdgpu_bo_create_kernel_at(adev,
+					  0,
+					  adev->mman.doorbell_kernel_bo_size,
+					  AMDGPU_GEM_DOMAIN_DOORBELL,
+					  &adev->mman.doorbell_kernel_bo,
+					  &adev->mman.doorbell_va);
+	if (r) {
+		DRM_ERROR("Failed to create doorbell BO\n");
+		return r;
+	}
+
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
@@ -1992,6 +2004,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL, NULL);
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+	amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
+			      NULL, &adev->mman.doorbell_va);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a492de079c2e..405294ca9834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -98,6 +98,12 @@ struct amdgpu_mman {
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
+
+	/* doorbells reserved for the kernel driver */
+	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
+	uint64_t		doorbell_kernel_bo_size;
+	struct amdgpu_bo	*doorbell_kernel_bo;
+	void			*doorbell_va;
 };
 
 struct amdgpu_copy_mem {
-- 
2.34.1

