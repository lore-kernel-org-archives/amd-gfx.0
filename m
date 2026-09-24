Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A441CC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A4810F2D8;
	Thu, 24 Sep 2026 07:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jo99vzxT";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3FF10F2D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhbbxJmOSOrSvJA3nZNzQFRGvHsDhITlOjY9xBO+nNxZN2uyjHb366otJ8CAeJIqnvHA+Kty/zo2CekhIOl2K6pX7+0xLlsUbr0Ds5rW2WFq5rqrXjmwuRwxhGqwjIIL44O/DgSq6IWjCFzFo+prNCSFkKqXJtIEKDfXMNZVJWWcy7GHYdmtDegJZHja/QUnJHp0WTUEPq+kNRGZI1wI0PrzqZ7uxVrcgpygbkTXhCTvyXGiA5HxkpAscvGOZl1WC7xl75uYyhwfMPVSLaO5xVINzyK33o5BCNzGa0+WYrbtbGwsEKWPSlMbo6XLEBdUzQB7qt+u6lkE8lDb1ZCWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvpRmTsjH3NTIkU98uikzbwJiszZQ5SqxI3XP0+cuC8=;
 b=j/aBpsYkPTRz5BjLJ3IbfkWNhMaMRrrWJLL7P/ehKhj9JWHkjl/IjtlQlSct8lGoZiQ+WNf+Y9amEgWy89ggSg0eqC/YUsD5fDIPnxrqZVqGP3Mca+HSzZOmsADCdvRDHWkG0I8nq57gbmoY64ZPWipMK1hu2Iccda+gGfmxn4ghoe4be43EUJlCiNxBBPweM9IuDuLiErU25dP5VoU0pZ4RFnl2QYpKYJt0Rg1wSwcESdCdERbtYq/G0R8/eAdtuKkafmPgtuS/lr5SdompvSSftghF46CyoJrUVxmzVC1T+6ynsOFmy24SMBtS2ZeWbZTymjoS/AYmtUF7M8BbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvpRmTsjH3NTIkU98uikzbwJiszZQ5SqxI3XP0+cuC8=;
 b=jo99vzxTEj84zAlMysh+aQwKuuR/EMWrkQ3JevmPITX7Ubd26OXLmeJ2rh1wprRByUx702VrGz9uZ2AuO3StL6ezgG48/khYszvnrqEms8n5Rptc2XHIBBSzcwFhYlFdMdhtx6FRylg/UpTYq/jgaaoW1+s1Z2Iwi85giZSiXGA=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:01:32 +0000
Received: from BN3PEPF00022BBF.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::39) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Thu,
 24 Sep 2026 07:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBF.mail.protection.outlook.com (10.167.248.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 07:01:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:30 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 24 Sep 2026 02:01:29 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu: skip PF-only programming on the VF
Date: Thu, 24 Sep 2026 15:01:28 +0800
Message-ID: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBF:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: c74b51c5-400f-4dd7-83bc-08df1a09a9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: UOKi3t58Ub6yKdXANO9wVapM11HO36dvrdHv/SoVczzIDTUCFRQ9sQWv83o6wA2XiY2Rcw98tbpM0zrzSbbPMD28f/ScAlmLgsjQ3rku8FAB8rDcqdQSghXchWbln821s6eJJdMwmNr0sKCxaVJd1LvpgS3JWA8iLCc7cuadwsgFjinFBNrfmR2Z3R5C5c4bQf+z8BuOXBMMZp5SfXk7bYjpBc7BqJ84PqplPAfEnHtSMhOrUwbtvUylKvj+DwuHblq69pYy+4cSx2dbyHWTXqo5f+Z3zolAAhzJYJBfDgewZ/rFvP2Lgzz3UcD1B+UovwHKjU16X5Aui6ZwocTGyDwUTcRL2kp3vZaU5k5Y796WpmW3NzgzDQ9ZNTW86bik9QnD//esbEMFuiTUbtdrH43EbXfgCa0vtPV5wwAhomgfWviRV5mZjLG8Rqt99HcDKP/Y26+5qtlRzX3SPLbq+UT/iu2OqAuuXvhs1PUsCTlaZs4ePFg0e9UNeJAaikXqa/McClu6tw02HQrxNzMJoiVxxRreAOALQJsfyyuwnPrl1FTVEvDRz7ZktiCUMZ3qRbHoPBBPrdHBslSUAVdDJTcxYf06wnIDwAf9cq9RY8VW2TuxWYmGKNdXsu9gzAeGAhumxKoV08UlsgFL1KGo3d9uAHwaxnExakx8xwHxQjggJFWUGdWiHrbH3xzGO3Jyv1jJ/eMRBHDl49+T+AC5aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t5FHlazlpM71HOwifdWppAzwASar+UFUXid6wSXt9QcVEagLt1JrVfTN4/qoQ4/8ESg7jDR16iZfkVU8qLnNHsKwttzMfQAAMrJbHx5vjTjHiwShcNZW5JqsSHs5LgZMoTEAhzwLfTpTzQfUQ3RftWHe+w70HSJqv9H0S4LjmBbRomJvw7N0kfdLVMT1ZQDkcsZ/CzAT47QFu59EuvXw4+DvNOzhmS3eCEbEHLGiAxC9Ss7+HY+VYQYfPm6Ktt9YMB1O7ew13ffKEBv+7qIKPP+E5sV9t+z3bgkBzw1GMSmK8RLw55HrF1ZCnPPNgdzpq4CzRldpMY4vb6PU4cEOKU8jdrvGq4zdsUo+7h0dxjlDw2GYlFRsFIjeAcWADQ/D7okpmvrCKPTvvdbqv3Bxp+4eZo0gd9zYwiScDHaqZ+g35Dib1aYOxApeiVRGDBGc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:01:31.4306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74b51c5-400f-4dd7-83bc-08df1a09a9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

Golden register init, the SDMA RB command switch setup, the GFXHUB
L2 protection fault controls and the guest-side FB_LOCATION programming
all touch registers a VF does not own, so leave them to the PF.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 24 +++--------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c    |  3 ++-
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index db541939555b..4f6eac30b235 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2665,7 +2665,8 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	gfx_v12_1_init_golden_registers(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfx_v12_1_init_golden_registers(adev);
 
 	gfx_v12_1_constants_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 7fa451b373fc..b13967a1c8fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -482,27 +482,6 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
 static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
 					uint32_t xcc_mask)
 {
-	uint32_t i;
-
-	if (amdgpu_sriov_vf(adev)) {
-		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
-		 * VBIO post does not program them at boot up phase
-		 * Need driver to program them from guest side */
-		for_each_inst(i, xcc_mask) {
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_FB_LOCATION_BASE_LO32,
-				     lower_32_bits(adev->gmc.vram_start >> 24));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_FB_LOCATION_BASE_HI32,
-				     upper_32_bits(adev->gmc.vram_start >> 24));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_FB_LOCATION_TOP_LO32,
-				     lower_32_bits(adev->gmc.vram_end >> 24));
-			WREG32_SOC15(GC, GET_INST(GC, i),
-				     regGCMC_VM_FB_LOCATION_TOP_HI32,
-				     upper_32_bits(adev->gmc.vram_end >> 24));
-		}
-	}
 	/* GART Enable. */
 	gfxhub_v12_1_xcc_init_gart_aperture_regs(adev, xcc_mask);
 	gfxhub_v12_1_xcc_init_system_aperture_regs(adev, xcc_mask);
@@ -576,6 +555,9 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
 	u32 tmp;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	for_each_inst(i, xcc_mask) {
 		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
 				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 321c67e01443..d1e09acc684a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1397,7 +1397,8 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 
-	sdma_v7_1_rb_cmd_switch(adev, inst_mask);
+	if (!amdgpu_sriov_vf(adev))
+		sdma_v7_1_rb_cmd_switch(adev, inst_mask);
 
 	r = sdma_v7_1_inst_start(adev, inst_mask);
 	if (r)
-- 
2.34.1

