Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B9D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF2310E564;
	Tue, 20 Jan 2026 07:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fw7WEM1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC6510E55A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qc20+5A9oc9UhN0iR0OhmTc7o3BEz69JezNI2WS0e5sFe2e86PWDGXiHYjhmDrFWf6/JFtlqJa0lv2k5XdeQKFyWH+cn4SG0TYmlQOXkEVWpByMu15FrUVSCSI9MA1S50XhZHV5uuJikfBCuFwCGUdwwr+Y96lST73w34gd06B6BddKmlbqnz22yKDfdG8RiNMvxAOG31+RmXt1CYnToEeoC61tEmBQM/pVeKrqBr9lc0EWyUOhc9rwPcLeQE2ZkJR4FwkRqEaXtTJCTzNfx9d5StlowVqg/1Ptxv7AguA9wyx3HytXR9mNOd0HUfdOZELzutv1ISC7TEZzv55Oxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8jcjCf1g/oTIztaJTg1uW4xvmJHTI/M8SVHK9iV1qA=;
 b=FseNpPoyfFcGzofN9Uz3woKNmVpW6ut0sNc1zNwhb5CICDAtMpLGaPSG5lt98+8oJCPWEJ3ogkiZqjP+iod8fKJkHBlR9xTI3YGVv8F2gaIcN1as082BCv5egpm1ml67pRuio6oL5QLFTMLN6alCH9JAH+hEhC3Tprz97+pkkHKfTtLluQPZ9sdgn2TO/jSAe12Ld9ROOdS895BO1v95PjfSD+ERnhofKpDHrpBgVvMGuM1t0BMFWODph2HOydwalGQec8hfeSOWlkqJgsvwGfFqye46DsAu8Le5enBdN/JzJzT7XghWqbcaxEKaIvyeYTUw2rDo+uiZ4bcmGIC0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8jcjCf1g/oTIztaJTg1uW4xvmJHTI/M8SVHK9iV1qA=;
 b=0fw7WEM1JExL48CANGtrSw3TcCw2LaYDxEdpCpe1n/j4cuqQP+RppGnmJJ0WFbEI64/8wz+V+8EV2nMWTMYLmyFe3HpAvB5oG/EmLXiGwwYyypfo3z3V+XAqrmRZXc4JpNo6t/naShUDFP9TujYr74Kwz//c1K3Du8wiRGs85WQ=
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 07:00:13 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5d) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:03 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 07/15] drm/amdgpu: Add audio method to register block
Date: Tue, 20 Jan 2026 12:27:41 +0530
Message-ID: <20260120065931.1300054-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: d9695f20-6520-45b8-76f5-08de57f18ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHOoP4cttGlewMspg1aIT3WJbq7Ja4zaIaYeKvyTDSqbZyK5FF+k8SaPDgaI?=
 =?us-ascii?Q?qr2LJucYUR/6BMaQTSF23IRqEls9cTg5XMyW1Y70nAZcVXi5pSrENxxgz9Tx?=
 =?us-ascii?Q?xszD8kPU3rW0ynjr8bpa6AgG8+d+MNQdWx70jHUC2hX1UC2F8N/29RzhwZ7x?=
 =?us-ascii?Q?8febHkS3rqqXKwdokoQ6Yd9bT/3uhsLbNdz58p4UWrvyDU/Q9ULtvbvUIDBY?=
 =?us-ascii?Q?yATMofo+ErmfesQ4nshExePtgItg8gbeGGfrX1T5yN1iv79kwtNDTXLRdLqe?=
 =?us-ascii?Q?0hXzhqh9ItCk5j+Zmdnvnu6N7w7m83W8erIMHhbt682h4xzAnptl0SNRsW/p?=
 =?us-ascii?Q?pYHf2YEsRCooqRYAGvwaMrmRoIqojYuatSViqnoef+uGlN0rcI1XPNe8pWuG?=
 =?us-ascii?Q?mW+0NxC4V1ftTZ85uHaez/hfDHFxSidUek3FRZALrfDeOGxdwv3mUhymVRBA?=
 =?us-ascii?Q?zpe3xn3PRgsS3VdSNv9SKxWlCnOu3/+yememE9gsAQO1wzPyFS3YnIPg57sT?=
 =?us-ascii?Q?XzdR1K5XKaeEQ9dCHnaITVaUjnLvHclaEMFfgcgszWqlqbcK+2gpaNL49lsF?=
 =?us-ascii?Q?zcrhmN0NyBBxN6a4EW33k/rX6kTnIIliYTs0wq7NrfGvRrJ0boC+YBfg5zhE?=
 =?us-ascii?Q?bmb1JzpoPoa/ZpTjFjowApauoLaQ8hDGRnboZxue/3m/YXCgaciWossTbzqp?=
 =?us-ascii?Q?O/63VyX3bWSy/Rutec/TMKF1Z1uDWo2HxTonUM1WBm0/bmwMW+BbsiChww83?=
 =?us-ascii?Q?4cUTkd3ft+WZYK6MtIMoVArbLBGiPEkQIzZ4VQjkqFAHJUwCHUuBUxgwKd8b?=
 =?us-ascii?Q?4Nkjd29vggdNGj96JHzhdMFg4I0f5Rz2+ktdkx5NB7iXqqyjdk6g2se5K2wL?=
 =?us-ascii?Q?0iRFvG9t34WL9Lm3jFSquwIXcnNKGjQ+D/77I9F4pFXcmMXYc5MQqpqik/0S?=
 =?us-ascii?Q?G9PF9MgBINzBN2i0ZVG1g01+M9TPcgGfjtZWsoI2/UHDWXhWEgXRMHSDWVh6?=
 =?us-ascii?Q?LKlI0ClbrKFQuI5XkAby+jvDtHIiwNeQyAa5EaH8jvmZouljBWtf1PaV9jVC?=
 =?us-ascii?Q?OiW50fg/zXOvBdBieTSUVC8IxUjTyob1DdZrziPxdx1TVQJjDEyEODs/oC54?=
 =?us-ascii?Q?wtnXeEq3nckm1VOt5A2zQGwNo8zd+xTgV7lbsWAYI20Kso33jBhN7pckWrpG?=
 =?us-ascii?Q?ZbJhrlCPw7HNyxXj/wsILt/Dm0dF2dLw+w9K3hyBwJQ5hmJO5quDA/h9gEkD?=
 =?us-ascii?Q?KUiNobl3LyxwhTEp0MHVyxSoSGrLyM2oAKyTwUkQxnNV8Cj1j2F+atvovQLq?=
 =?us-ascii?Q?gL5Q0s13wSNx1ncIKfxdr3KTujJPZ/btiX7UMpuIK2M7yx/+F27tmwhGpRiC?=
 =?us-ascii?Q?+WYoVxfXxMzAGUOCWQHyeIgyc0xrTNg9+UTv5LNPF6w3yvolOlp5YfpEnnea?=
 =?us-ascii?Q?A0ufC+/TRznhOd93MSGqAD+A1uGa1OOQ4ooeACO3V6U3J7SBAk4SS0L9UUYV?=
 =?us-ascii?Q?OccZ84KQUGBUcI+zNITyNxuecIaRAlFryPw2Sf7WpfcQAF21Z9aUEo3WvOXV?=
 =?us-ascii?Q?ccr8uPqvs8cIRsqwtFDe3UIcEgqw+ss9kTa9gz++7ZMDUe2awltTbifC8tVj?=
 =?us-ascii?Q?LK+hye562FbF16eRNWTpdu4XNgMn/hsvCojLU7gSaVli/tUDqsQPG6Kr9gT1?=
 =?us-ascii?Q?natXnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:12.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9695f20-6520-45b8-76f5-08de57f18ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

Move audio endpoint callbacks to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 45 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 26 +++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    | 21 ++++++---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 12 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 12 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 12 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 8 files changed, 66 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4f22b7da4657..29d0f9a756b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -906,10 +906,6 @@ struct amdgpu_device {
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
 	amdgpu_wreg64_ext_t pcie_wreg64_ext;
-	/* protects concurrent ENDPOINT (audio) register access */
-	spinlock_t audio_endpt_idx_lock;
-	amdgpu_block_rreg_t		audio_endpt_rreg;
-	amdgpu_block_wreg_t		audio_endpt_wreg;
 	struct amdgpu_doorbell		doorbell;
 
 	/* clock/pll info */
@@ -1316,8 +1312,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_GC_CAC(reg, v) amdgpu_reg_gc_cac_wr32(adev, (reg), (v))
 #define RREG32_SE_CAC(reg) amdgpu_reg_se_cac_rd32(adev, (reg))
 #define WREG32_SE_CAC(reg, v) amdgpu_reg_se_cac_wr32(adev, (reg), (v))
-#define RREG32_AUDIO_ENDPT(block, reg) adev->audio_endpt_rreg(adev, (block), (reg))
-#define WREG32_AUDIO_ENDPT(block, reg, v) adev->audio_endpt_wreg(adev, (block), (reg), (v))
+#define RREG32_AUDIO_ENDPT(block, reg) \
+	amdgpu_reg_audio_endpt_rd32(adev, (block), (reg))
+#define WREG32_AUDIO_ENDPT(block, reg, v) \
+	amdgpu_reg_audio_endpt_wr32(adev, (block), (reg), (v))
 #define WREG32_P(reg, val, mask)				\
 	do {							\
 		uint32_t tmp_ = RREG32(reg);			\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 137ddce64536..247565abcf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -959,48 +959,6 @@ static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg,
 	BUG();
 }
 
-/**
- * amdgpu_block_invalid_rreg - dummy reg read function
- *
- * @adev: amdgpu_device pointer
- * @block: offset of instance
- * @reg: offset of register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- * Returns the value in the register.
- */
-static uint32_t amdgpu_block_invalid_rreg(struct amdgpu_device *adev,
-					  uint32_t block, uint32_t reg)
-{
-	dev_err(adev->dev,
-		"Invalid callback to read register 0x%04X in block 0x%04X\n",
-		reg, block);
-	BUG();
-	return 0;
-}
-
-/**
- * amdgpu_block_invalid_wreg - dummy reg write function
- *
- * @adev: amdgpu_device pointer
- * @block: offset of instance
- * @reg: offset of register
- * @v: value to write to the register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- */
-static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
-				      uint32_t block,
-				      uint32_t reg, uint32_t v)
-{
-	dev_err(adev->dev,
-		"Invalid block callback to write register 0x%04X in block 0x%04X with 0x%08X\n",
-		reg, block, v);
-	BUG();
-}
-
 static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 {
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
@@ -3861,8 +3819,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
-	adev->audio_endpt_rreg = &amdgpu_block_invalid_rreg;
-	adev->audio_endpt_wreg = &amdgpu_block_invalid_wreg;
 
 	dev_info(
 		adev->dev,
@@ -3908,7 +3864,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->mmio_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
-	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index d75ef23581a0..563b155b15c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -54,6 +54,10 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.se_cac.lock);
 	adev->reg.se_cac.rreg = NULL;
 	adev->reg.se_cac.wreg = NULL;
+
+	spin_lock_init(&adev->reg.audio_endpt.lock);
+	adev->reg.audio_endpt.rreg = NULL;
+	adev->reg.audio_endpt.wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -153,6 +157,28 @@ void amdgpu_reg_se_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
 	adev->reg.se_cac.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_audio_endpt_rd32(struct amdgpu_device *adev, uint32_t block,
+				     uint32_t reg)
+{
+	if (!adev->reg.audio_endpt.rreg) {
+		dev_err_once(adev->dev,
+			     "AUDIO_ENDPT register read not supported\n");
+		return 0;
+	}
+	return adev->reg.audio_endpt.rreg(adev, block, reg);
+}
+
+void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
+				 uint32_t reg, uint32_t v)
+{
+	if (!adev->reg.audio_endpt.wreg) {
+		dev_err_once(adev->dev,
+			     "AUDIO_ENDPT register write not supported\n");
+		return;
+	}
+	adev->reg.audio_endpt.wreg(adev, block, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 63929999cd76..e19b7a531906 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -32,18 +32,30 @@ struct amdgpu_device;
 typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t);
 
+typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
+					uint32_t);
+typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t,
+				    uint32_t);
+
 struct amdgpu_reg_ind {
 	spinlock_t lock;
 	amdgpu_rreg_t rreg;
 	amdgpu_wreg_t wreg;
 };
 
+struct amdgpu_reg_ind_blk {
+	spinlock_t lock;
+	amdgpu_block_rreg_t rreg;
+	amdgpu_block_wreg_t wreg;
+};
+
 struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
 	struct amdgpu_reg_ind uvd_ctx;
 	struct amdgpu_reg_ind didt;
 	struct amdgpu_reg_ind gc_cac;
 	struct amdgpu_reg_ind se_cac;
+	struct amdgpu_reg_ind_blk audio_endpt;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -59,6 +71,10 @@ void amdgpu_reg_gc_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
 uint32_t amdgpu_reg_se_cac_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_se_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t v);
+uint32_t amdgpu_reg_audio_endpt_rd32(struct amdgpu_device *adev, uint32_t block,
+				     uint32_t reg);
+void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
+				 uint32_t reg, uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
@@ -69,11 +85,6 @@ typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
 typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device *, uint64_t, uint64_t);
 
-typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
-					uint32_t);
-typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t,
-				    uint32_t);
-
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t acc_flags);
 uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 72ca6538b2e4..ebf123bf7fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -175,10 +175,10 @@ static u32 dce_v10_0_audio_endpt_rreg(struct amdgpu_device *adev,
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
 	r = RREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 
 	return r;
 }
@@ -188,10 +188,10 @@ static void dce_v10_0_audio_endpt_wreg(struct amdgpu_device *adev,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset, v);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 }
 
 static u32 dce_v10_0_vblank_get_counter(struct amdgpu_device *adev, int crtc)
@@ -2763,8 +2763,8 @@ static int dce_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->audio_endpt_rreg = &dce_v10_0_audio_endpt_rreg;
-	adev->audio_endpt_wreg = &dce_v10_0_audio_endpt_wreg;
+	adev->reg.audio_endpt.rreg = &dce_v10_0_audio_endpt_rreg;
+	adev->reg.audio_endpt.wreg = &dce_v10_0_audio_endpt_wreg;
 
 	dce_v10_0_set_display_funcs(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index acc887a58518..650deb10847f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -138,10 +138,10 @@ static u32 dce_v6_0_audio_endpt_rreg(struct amdgpu_device *adev,
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
 	r = RREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 
 	return r;
 }
@@ -151,11 +151,11 @@ static void dce_v6_0_audio_endpt_wreg(struct amdgpu_device *adev,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset,
 		reg | AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_WRITE_EN_MASK);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset, v);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 }
 
 static u32 dce_v6_0_vblank_get_counter(struct amdgpu_device *adev, int crtc)
@@ -2710,8 +2710,8 @@ static int dce_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->audio_endpt_rreg = &dce_v6_0_audio_endpt_rreg;
-	adev->audio_endpt_wreg = &dce_v6_0_audio_endpt_wreg;
+	adev->reg.audio_endpt.rreg = &dce_v6_0_audio_endpt_rreg;
+	adev->reg.audio_endpt.wreg = &dce_v6_0_audio_endpt_wreg;
 
 	dce_v6_0_set_display_funcs(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 2ccd6aad8dd6..e749f0cb252c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -126,10 +126,10 @@ static u32 dce_v8_0_audio_endpt_rreg(struct amdgpu_device *adev,
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
 	r = RREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 
 	return r;
 }
@@ -139,10 +139,10 @@ static void dce_v8_0_audio_endpt_wreg(struct amdgpu_device *adev,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.audio_endpt.lock, flags);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
 	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset, v);
-	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.audio_endpt.lock, flags);
 }
 
 static u32 dce_v8_0_vblank_get_counter(struct amdgpu_device *adev, int crtc)
@@ -2668,8 +2668,8 @@ static int dce_v8_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->audio_endpt_rreg = &dce_v8_0_audio_endpt_rreg;
-	adev->audio_endpt_wreg = &dce_v8_0_audio_endpt_wreg;
+	adev->reg.audio_endpt.rreg = &dce_v8_0_audio_endpt_rreg;
+	adev->reg.audio_endpt.wreg = &dce_v8_0_audio_endpt_wreg;
 
 	dce_v8_0_set_display_funcs(adev);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4c45ac3c05..99968823eb49 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6001,8 +6001,8 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		adev->mode_info.funcs = &dm_display_funcs;
 
 	/*
-	 * Note: Do NOT change adev->audio_endpt_rreg and
-	 * adev->audio_endpt_wreg because they are initialised in
+	 * Note: Do NOT change adev->reg.audio_endpt.rreg and
+	 * adev->reg.audio_endpt.wreg because they are initialised in
 	 * amdgpu_device_init()
 	 */
 #if defined(CONFIG_DEBUG_KERNEL_DC)
-- 
2.49.0

