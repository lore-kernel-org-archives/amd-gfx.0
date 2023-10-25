Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA7DC25B70
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 04:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143EE10E547;
	Wed, 25 Oct 2023 04:24:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F0E10E547
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 04:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZixGtxrWzMXVZ4zT6CdWUysXfahrFoUIe4R2AHEpC2xssoj/0WAt3H1OIq6o5TFyIomcBdQsSPsrgycGgSYuK7flCMTM3jbW6+ANUzMkQUo8Swc53JSv4A+DCjEtN1Y9mbZJdzzv4ZN8jhHpu2kQ7n65LpXDoHnji9rStZdY6O6cYxo2TK3gNp36d21YpqMz7NKG2fTf0OskyE9zEavBl+smU5uvX9VxU+NTgICfdGQQ663SG7Qfi+0XL81b2UGxAGhsHyfc0JiYdxLiN5FxHXKqgx3B3LjIrpg5JT3fyCgtII0EJdsNI9LjLXiGlYe3OgGofz7IIiO9cWv9xaXGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k49lM0MGnDKstaNz/vYSnx6M84B5REszrXyV4GkFrsU=;
 b=aA/13sSSOoT4XeisUfpCIknaw+EhwplVrykOmK96neXje6fPO7zv99s91pyfyKe3DM1gg5kA2UJ26PVCXva6js7L4to1GXBtB2S0zVE4OF+oyIm8+LGlgC6N5sFInkyl/mCNdKy+wzELWmLUTe2EHzdAvmwmz2KkKIfcH6z0HGDuN7+CkCazzdNQVoLE1LvR27jUZyAIb0RLEkwEMCAKg6Xhj4l0N2AkBM46HP0XKDiUnW5gfGr21O1JnMeVVKeHakw0Nz9afn/XrK+d5ktnwM//n7a+wxgAkpQu90GwuC6r2oU4NA9Oy9ZWfcEEvWfds+6kVZU+FYBWwsTJQ2Zo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k49lM0MGnDKstaNz/vYSnx6M84B5REszrXyV4GkFrsU=;
 b=k1d3XarwA6fXpebmyR4jJ2CfuwUsL06JHdcqRz82fd4pf7SieH3QYLtH8IDbCR095o25oNdKKLo19d1ek/gGMDeUrLdoMprMZswiohArUldsSSiQ9hhFupgiF7a8kHWOdSxyBL6de7St4EUBySVRC/WMup54E4NT5KLgMKrAXz4=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 04:24:25 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::f1) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 04:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 04:24:24 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 23:24:22 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH] drm/amdgpu: move buffer funcs setting up a level (v2)
Date: Wed, 25 Oct 2023 00:24:03 -0400
Message-ID: <20231025042403.10222-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <dd6969ae-8ba9-43c2-bc50-11277613b27a@amd.com>
References: <dd6969ae-8ba9-43c2-bc50-11277613b27a@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f474ab5-f1c8-40a4-e7eb-08dbd51244f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTYRjDqVoPI8PbE1v+8Q5TPFYbYTMGgUz4IGMQRYgwLiUoJcq8ny0KHZ0N5Ud/qpjPnC86jpqRZtG9e+mm/Lq70KowafPqq5FFolVSCVcFCS0oWrth0NQ1jfQyQ+coZi1uMbkW7e0G89B3oKlTNsZCtT/MJiDcCTvT5gs8N7CEu8wYI5JnWEq3InNVjP64QsEO+gIfU9BLBfOlouUCCzbz71m/krWxxeYYTjiHVazXHVYrZq9WppzfCvzUAISCGbu9lXU0znAt0EmKVFns32xGIrkm7Fcv3SPC45QTP4t00b9gqR94EZNFWW/fiXm/RVUwtX5Y8PbXbwwiM7JfJ1JoA+Yjys7E+2fbPJux4mbeBprvjh83CZQ5Est5bUOLxh9BrmxMsCr5aOdACvmDG8YFxHFlvmAkS2eGjeHhK9TVTNKEvZ3qzbFYJcPV0+9tHdbmZABemqEKff+SRtWk4T1r1qWcCsGjizYMiIBS+Izxk/Fr9KnWmofYPtwACIFaQnLjpmB7TNwlbtqfEK+ZF5+slpVOc/MAwM90e+yIGLoNccLvo7orDk7o+AQizOWnHKXTYIwEO1PlGcPyWWVQzrnBA+xKqEvZOiMrUSdW0aRw8DKeW3OoixkoLrjJYGKZX/yHXY1jQvUMsF9EpMtvQG6AYg7GKQodKyCHWqig9bpvtBVuR4TbA0nbcP59BqtU8J9V3Pp9+gFXKgTLgRoAZThZB+44+pnTpwFqEFusk5iyomXB8d6Vs+5g3w1diAw9T9ZOVmlSJrTc8qQmOmgeNEIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(7696005)(44832011)(8936002)(5660300002)(4326008)(47076005)(8676002)(40460700003)(356005)(426003)(2906002)(83380400001)(30864003)(36756003)(2616005)(1076003)(26005)(336012)(16526019)(81166007)(82740400003)(86362001)(36860700001)(6666004)(54906003)(316002)(478600001)(110136005)(70206006)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 04:24:24.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f474ab5-f1c8-40a4-e7eb-08dbd51244f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Rather than doing this in the IP code for the SDMA paging
engine, move it up to the core device level init level.
This should fix the scheduler init ordering.

v2: Fix checkpatch parens complaint; long lines. (Luben)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
 11 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ec32b44df052f..47c1e60109c14c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2662,6 +2662,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	amdgpu_sdma_set_buffer_funcs_helper(adev);
+
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (!adev->gmc.xgmi.pending_reset) {
 		kgd2kfd_init_zone_device(adev);
@@ -3260,6 +3262,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
 		return r;
@@ -3449,6 +3453,8 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
+	amdgpu_sdma_set_buffer_funcs_helper(adev);
+
 	return r;
 }
 
@@ -4236,6 +4242,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
@@ -4407,6 +4415,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_suspend(adev);
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
@@ -5178,6 +5188,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
+				amdgpu_sdma_set_buffer_funcs_helper(tmp_adev);
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e8cbc4142d8021..c4d642b06f3c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -292,6 +292,27 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	return err;
 }
 
+void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *sdma;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.has_page_queue) {
+			sdma = &adev->sdma.instance[i].page;
+			if (adev->mman.buffer_funcs_ring == sdma && sdma->sched.ready) {
+				amdgpu_ttm_set_buffer_funcs_status(adev, true);
+				break;
+			}
+		}
+		sdma = &adev->sdma.instance[i].ring;
+		if (adev->mman.buffer_funcs_ring == sdma && sdma->sched.ready) {
+			amdgpu_ttm_set_buffer_funcs_status(adev, true);
+			break;
+		}
+	}
+}
+
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *sdma;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 513ac22120c1fa..33209593e97461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -169,6 +169,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
+void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev);
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ee5dce6f604369..a3fccc4c1f4375 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
@@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index b58a13bd75db8f..45377a1752503b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c5ea32687eb5e8..2ad615be4bb3d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 683d51ae4bf10c..3d68dd5523c65a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
@@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
@@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 			r = amdgpu_ring_test_helper(page);
 			if (r)
 				return r;
-
-			if (adev->mman.buffer_funcs_ring == page)
-				amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		}
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return r;
@@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
 	if (adev->in_s0ix) {
 		sdma_v4_0_enable(adev, true);
 		sdma_v4_0_gfx_enable(adev, true);
-		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index c1ff5eda89619f..3c485e5a531a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_0_ctx_switch_enable(adev, false);
 	sdma_v5_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7d1e57189c8c69..83c240f741b519 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 7e4d5188cbfa85..3c7ddd219de850 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 0);
@@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 42c4547f32ec9c..9aa0e11ee67327 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	unsigned i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		/* dma0 */
 		rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
@@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;

base-commit: fefaa6c51e990dc8e5142729accef661f475a731
-- 
2.42.0

