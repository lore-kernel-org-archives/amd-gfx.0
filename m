Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A8DC05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C26710E8AF;
	Fri,  3 Feb 2023 19:09:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C710210E8AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwxbXQ2d7/zVfYfq94HSoPthyLql2jiF7TgP/moTVyaNTxWGSMyiPLYjSPDGtQ0eocClpKwSvpcTBKChcVHOFKy2Zp0rJVCtZ17Y2wRC6Kv33ttrGtzlXEy4aXZm7LHDUyEecW40uGlxSrcsz1NALOTfUgadDmT77DXYE798+okLigMi1A0XiFcyfWvr+WKPCLc0DmblM2AFCrfsU7TO+fSVBg0l6UkmEuNGcMhh4zZTpLyRJjTZIqL5ZvArIz8P2+/hFCUWUFgYoZW7VWscynankr4YP5K+Ann7RLwv3caxzR1j7FOynRJbhWldzZB9KLRBUgCiw5l9lgR3v1pd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5nwW2DHaUNz3EkoxCm+dwZjSpd6Qs/+642J8q1cdNI=;
 b=RyaXbTARmIdwo24mp2wtlM8rKQmP+23iv+ITmSwmCFbBdENbmmTqWrPkGNkKo4+ZtlKEmyRdb05u1VzMD8Gpl8L4/XCN1vGKNUPSZnOXNOVFWN/ouEjiSB9dqfEuUX/61zbCpOj2uQZ5b+2HUANnE7u+D1ce1psKxqnkvmYQoiQQLgxLEFxA9FBDQZvVUdhFj6faZAi1W76iIUHCf1c7HLYbr67ukfjFnnPMvUBKSXh29FLD7KskinM0JP0Fg4+gzY8gu3vJKFF36b7OycWqIXLhn04IFCHbFF0W8qozG4O0nqap/x3bi3gBwz7XiMBGVeDO8ZGVIdHztWGUiyMISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5nwW2DHaUNz3EkoxCm+dwZjSpd6Qs/+642J8q1cdNI=;
 b=qC/a+3ztz/3X9rE8SScyuYr4dVLpdsytyfb5TFxvniI5m6WzwueXek8pQgVQ63AXKbc6TP7V1BwUEaSchKA6NsHNcE31vaj40XcHCaga78nrnIIqYh62wEPZF6GPyeugHsJo2PuGHQ0EFS1V6/gs495P4D/eyFwkqwdKNRKunug=
Received: from DM6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:5:80::23) by
 CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.29; Fri, 3 Feb 2023 19:09:37 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::c3) by DM6PR08CA0010.outlook.office365.com
 (2603:10b6:5:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:35 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: introduce doorbell bo in kernel
Date: Fri, 3 Feb 2023 20:08:35 +0100
Message-ID: <20230203190836.1987-19-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: a48c643f-a38a-447f-a578-08db061a31b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBVw5/V82oXXR631WTWYbw+oAOgEXf/1rLewq9bXSyP49Fl3p9cZhvwFVvuY1oZwC8RNeBTHFjlLINq0VJnWV0g39qtryaBQVUasCmWRWX1+BOpslEajwnej/mgBrCU0NlJKSeEyppjmf3PffEhS0+Hnx4ANGNKCNw+8zngeAVWubbiIiZfNkYvkq90QlecJjlA+Qki7U6OquiVOUkOWIkgPCpxCG0LfEy6OM2ZW+7Pzmc9yRQviiCcK1889ArKBi5iPwQJToAqMkyyCXkUEyzlDXD9hJvNK/f/5SFtrt3hcb1iZpYgLXNHZXf05I3bzchny8d/ShTWQ1vxE9bBOW/0UeSb/itmXKJHbZxgWrPfIl81WTZ789bnt8+8Qa6WrmLTYP4l8XTUQYid0/IDztlvFCvgnk81S0eJiO92osc70kEt/X0xDLgZXh2G8+DnKoxF4US5QYL5end3kkJiGRuFTlImUYXeuDfddShNLeA4U4mcvkMUhkaLAUzUx7kV3aDV5Rsqnj/PSjSKL9655rFonW5qk7zByfGSPa3+clhhRgP8XZ86680+mt+fLozvwk09TkMXdknCP2H+xTfM6VzuE4Tqmo3NoRohgAnW+mkX1qa+IZ5jOkkkcqnoZek/X/yCCZlsVMRRFfWCBmIl6wNmfttLVGAadZpcWzbH94aOyBStO1dadGPiY/KSRjcO68SQgIJ+H2fFqNJHPm1jcefx54EcmQJSfZBrBT+pvJZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(336012)(2616005)(47076005)(83380400001)(426003)(2906002)(5660300002)(82310400005)(7696005)(82740400003)(36860700001)(186003)(16526019)(54906003)(81166007)(26005)(316002)(44832011)(36756003)(1076003)(356005)(8936002)(8676002)(478600001)(40460700003)(41300700001)(4326008)(86362001)(40480700001)(6916009)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:37.5089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c643f-a38a-447f-a578-08db061a31b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 28 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 14 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  6 +++++
 6 files changed, 36 insertions(+), 22 deletions(-)

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
index cda5387aae50..85c353e4707a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -596,8 +596,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return readl(adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_doorbells) {
+		return readl(adev->mman.doorbell_va + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -619,8 +619,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_doorbells) {
+		writel(v, adev->mman.doorbell_va + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -640,8 +640,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
+	if (index < adev->mman.num_doorbells) {
+		return atomic64_read((atomic64_t *)(adev->mman.doorbell_va + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -663,8 +663,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
+	if (index < adev->mman.num_doorbells) {
+		atomic64_set((atomic64_t *)(adev->mman.doorbell_va + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -1037,7 +1037,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type < CHIP_BONAIRE) {
 		adev->gmc.doorbell_aper_base = 0;
 		adev->gmc.doorbell_aper_size = 0;
-		adev->doorbell.num_doorbells = 0;
+		adev->mman.num_doorbells = 0;
 		adev->mman.doorbell_aper_base_kaddr = NULL;
 		return 0;
 	}
@@ -1052,13 +1052,13 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
 
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
@@ -1068,11 +1068,11 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 		 * the max num_doorbells should + 1 page (0x400 in dword)
 		 */
 		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_doorbells += 0x400;
+			adev->mman.num_doorbells += 0x400;
 	}
 
 	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
-						      adev->doorbell.num_doorbells *
+						      adev->mman.num_doorbells *
 						      sizeof(u32));
 	if (adev->mman.doorbell_aper_base_kaddr == NULL)
 		return -ENOMEM;
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
index 4cec90debe46..5f16023a5991 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1840,6 +1840,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	adev->mman.doorbell_kernel_bo_size = adev->mman.num_doorbells * sizeof(u32);
+	r = amdgpu_bo_create_kernel_at(adev,
+					  0,
+					  adev->mman.doorbell_kernel_bo_size,
+					  AMDGPU_GEM_DOMAIN_DOORBELL,
+					  &adev->mman.doorbell_kernel_bo,
+					  (void **)&adev->mman.doorbell_va);
+	if (r) {
+		DRM_ERROR("Failed to create doorbell BO\n");
+		return r;
+	}
+
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
@@ -1931,6 +1943,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL, NULL);
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+	amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
+			      NULL, (void **)&adev->mman.doorbell_va);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9971665d7d99..3cada4b49ca2 100644
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
+	u32			*doorbell_va;
 };
 
 struct amdgpu_copy_mem {
-- 
2.34.1

