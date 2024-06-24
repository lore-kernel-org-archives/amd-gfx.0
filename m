Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3205EC2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 17:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9197310E547;
	Mon, 24 Jun 2024 17:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYs5owOo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50D310E53D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 17:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMPQDFr0dKnS5xRvkV7vfzutXnt6zW1DC2jCj2wJxTf3NbQcgaxLeiaRT+PF6SaEZ9SIfLhuUuJhmAUf3nLIcgw5O9dbuAZlSJ7Ac/FUOSmCoGAPTEU6bvWpL8VQF05737Juc9rq3IP4f2Hu4B6QatqnvMa1R6Vmy/07iAwAIFFUrtPJj0HDk0BZ5lUgbRCG9UWV8UsF8vVIFiUTK3mCMx+WEUGMjSCfjLKBlq7GDSUvFoQyNSTP97ZrMh/44h3rkYWCZBNjA72iT1gIglJ6Dlw/TsHEVu5rokozzBhZE6sW4KtkWIyBLEtSvtGu+zxKDDYm6iLR1ZLsBYIvzziALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDNsVxwg8cSF+6xFUcQhBy+0+LgncXmmKKVhD6/oOhI=;
 b=ZjuR7yd2vgwjJqMwlh2g4HoZCD1kLrYRGmiTZ/x4hxoyMZyIHWxAmLjwrCBFR9X8CIoWSA051NfmbPr92rccxaevW+Z8CEzo8IU2ZXtzwzAeFQB+DzQVRFdVHEQ8c0aIHzND9tFHsmwGwLAVjVVxyOL1n1PUA5kc/lUOr+dEV02cHEUxjp6MI83THeMoFIQ/vA8bqGjBnSivb+4N4dGvzEKnnVRHGLa3zieNyqlEspsV1iKR5iJ2ybLAg6MVWTsVQAQYwEWmI1+si5lD1LFiF7iOMEhlhVqiALAol29ywsRzjcbhItCkamZ7P1/Z5NTroK7GZRh8Bnp68eq/lz9Xsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDNsVxwg8cSF+6xFUcQhBy+0+LgncXmmKKVhD6/oOhI=;
 b=SYs5owOoBwe4pHTO7qoz2rNPmikfP1Te2DTNBl+oMsX2Cm549rMWagLdN3qm/6oX0DqpSa2DJHbf8uCFNcHgFAQCSJXKIouB0L/8hDtazwYnId62E0HYf/235NDwt8YSPJxuG0N2Aind+KCvz0EghRlnruvcaPbN6UJqhx1YICE=
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 24 Jun
 2024 17:58:39 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::b4) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:58:39 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 12:58:38 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg5: Add support for DPG mode
Date: Mon, 24 Jun 2024 13:58:20 -0400
Message-ID: <20240624175820.1508394-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 1199be0c-ff71-433f-3cf4-08dc94774723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HoxVqO3rs7qE6yv8Tk3Awj7cYzM1cDxu6InVn0ARZdIV0e4r7zHv8mQXEFG?=
 =?us-ascii?Q?6bUY+4aHQQgw1kHMeviBYsRRFrLbM8njxzIRCxcayHBjApPfPSC9XOAba6Tl?=
 =?us-ascii?Q?JbELqrdUamSgL9XeXqnX1515dbMqO90NLwxMbtsZAh1+c68RgTgDRy6BH2Gk?=
 =?us-ascii?Q?8KUZGOeVlrinUa97RXlUOw6LmMwo4znDmwDO+KJCVSR5qlavR28OcqL/g1KH?=
 =?us-ascii?Q?7yNuvo+UQzHNWptFpuK0ebAAVct/lWgGw5JHM06uPO91Rmnw/bs95ND6mDiT?=
 =?us-ascii?Q?AFybrBsQ3ZsR676VQ9VebYGYDL9G9LYY4F5pAhZpEMRGDG6wwKpqmK2Sgxbl?=
 =?us-ascii?Q?q5YhyWzgKfv15pUXHlPfvZ2ZPcaZzrOped7JptjYApCsLopKMSKYXpB/8awn?=
 =?us-ascii?Q?vWyQE/y19Wlu801uOgnajNLElmKR1IMt6VHFPNg0NxC/RBnnIEgbCiR0c2O3?=
 =?us-ascii?Q?qq+/Tkxf2i8XBADfCH9JKLqWG0aSkyBfMy/GLKAeROzSSnaaxpZDuOu2DeTf?=
 =?us-ascii?Q?sIs5OnWqf9UNiC+VOOmMdF2c5i6wZT6c0PmISf+Zk3v/t4505JyMzvvk6F7l?=
 =?us-ascii?Q?RylkTGQuDkoZKBIaVc/scY3v/dPB1KKI04n7STxPn07boF7BFaDQ8t7H5SOd?=
 =?us-ascii?Q?BfijFlaspHvickS1ynyJiSv38q2XDGoVtvczutjKbf6xUx0RGjEZVPphj7/z?=
 =?us-ascii?Q?5fvdN8+bkApqtnksbbe0NUr7Es+XY/OKsEnzCbJXN1uDvEi2F6am8ax1M1mS?=
 =?us-ascii?Q?4CdXD2xHu2IJhKAxVX3A68A7UDzE47mHv52psS9ENNbDFlsUA66O8GIAgr8Q?=
 =?us-ascii?Q?kduGktuV2p15flOJ5FTEO2tBtd83Kz4o77lbRMrVkiWiJYMMBskK1Fod1F14?=
 =?us-ascii?Q?MtElT5YaxPgJ9cfDnNH//D2NVbHbYf310ujldLumBgRLep7YMsRXAvBk205K?=
 =?us-ascii?Q?Q6wHaHEMGEx/eU9R/NEHQD9WvLPLExs/3nsJsxQoGivhjFPck2FHhCc+N7Zv?=
 =?us-ascii?Q?vInXcNQ1DlsyCBQ2zDn9rAC4SWc8/eFYpyuMlcnZpOLo+pUqEL1+TATtjZL8?=
 =?us-ascii?Q?F1pOztSDA0GxcIfKp7eKDl7cN4v4bPqCT89+vgEkFfcoioeB8nzBszD9/vrS?=
 =?us-ascii?Q?mXtWVGc+3RfXGCdEXm6gWLXfr24yYAeLmic2d87zDqqstkHkXvIvPOzZIsaZ?=
 =?us-ascii?Q?tsIyaUvtv90UcNc1CBnDRQ2pvuaYqG/u39UJlEupvJ5809D7nsbQRNp3kfCz?=
 =?us-ascii?Q?5GMv/qcK+QrDuRQ3oHVfT7VJdQ0FMd3ODbcBYnXnGovvRytIZHrmkA3dftjm?=
 =?us-ascii?Q?Vla8Y2ej5pAUHYNJYdz453wDlEGAP1r/ojYX+eYxuio2GkWAoKi/+VJuK8cH?=
 =?us-ascii?Q?ucaS7/Fu4ACxiNS+k08fk3udWemJ1aUhhORy5avfzCWudp6RAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:58:39.4341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1199be0c-ff71-433f-3cf4-08dc94774723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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

From: Sonny Jiang <sonjiang@amd.com>

Add DPG support for JPEG 5.0

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  31 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 159 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |   6 +
 drivers/gpu/drm/amd/amdgpu/soc24.c       |   1 +
 4 files changed, 180 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index aea31d61d991..f9cdd873ac9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -60,6 +60,37 @@
 		RREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_DATA);				\
 	})
 
+#define WREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, value, indirect)		\
+	do {									\
+		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
+			     regUVD_DPG_LMA_DATA, value);			\
+		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
+			     regUVD_DPG_LMA_MASK, 0xFFFFFFFF);			\
+		WREG32_SOC15(							\
+			JPEG, GET_INST(JPEG, inst_idx),				\
+			regUVD_DPG_LMA_CTL,					\
+			(UVD_DPG_LMA_CTL__READ_WRITE_MASK |			\
+			 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT |	\
+			 indirect << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT));	\
+	} while (0)
+
+#define RREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, mask_en)			\
+	do {									\
+		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
+			regUVD_DPG_LMA_MASK, 0xFFFFFFFF);			\
+		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
+			regUVD_DPG_LMA_CTL,					\
+			(UVD_DPG_LMA_CTL__MASK_EN_MASK |			\
+			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));	\
+		RREG32_SOC15(JPEG, inst_idx, regUVD_DPG_LMA_DATA);		\
+	} while (0)
+
+#define ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, offset, value, indirect)		\
+	do {									\
+		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = offset;	\
+		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
+	} while (0)
+
 struct amdgpu_jpeg_reg{
 	unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e766b9463759..d694a276498a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -31,6 +31,7 @@
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include "jpeg_v5_0_0.h"
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -137,6 +138,10 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
+	/* Skip ring test because pause DPG is not implemented. */
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
+		return 0;
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
@@ -235,7 +240,7 @@ static void jpeg_v5_0_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
 }
 
-static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
+static int jpeg_v5_0_0_disable_power_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
@@ -248,14 +253,10 @@ static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
 		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
 
-	/* keep the JPEG in static PG mode */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
-		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
-
 	return 0;
 }
 
-static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
+static int jpeg_v5_0_0_enable_power_gating(struct amdgpu_device *adev)
 {
 	/* enable anti hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
@@ -273,6 +274,121 @@ static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
+	       int inst_idx, uint8_t indirect)
+{
+	uint32_t data = 0;
+
+	// JPEG disable CGC
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data = 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+
+	if (indirect) {
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
+
+		// Turn on All JPEG clocks
+		data = 0;
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+	} else {
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
+
+		// Turn on All JPEG clocks
+		data = 0;
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+	}
+}
+
+/**
+ * jpeg_v5_0_0_start_dpg_mode - Jpeg start with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Start JPEG block with dpg mode
+ */
+static int jpeg_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
+	uint32_t reg_data = 0;
+
+	jpeg_v5_0_0_enable_power_gating(adev);
+
+	// enable dynamic power gating mode
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+
+	if (indirect)
+		adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
+			(uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
+
+	jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
+
+	/* MJPEG global tiling registers */
+	if (indirect)
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config, indirect);
+	else
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config, 1);
+
+	/* enable System Interrupt for JRBC */
+	if (indirect)
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
+			JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
+	else
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
+			JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
+
+	if (indirect) {
+		/* add nop to workaround PSP size check */
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
+
+		amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
+	}
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_stop_dpg_mode - Jpeg stop with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ *
+ * Stop JPEG block with dpg mode
+ */
+static void jpeg_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+{
+	uint32_t reg_data = 0;
+
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+}
+
 /**
  * jpeg_v5_0_0_start - start JPEG block
  *
@@ -288,8 +404,13 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, true);
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		r = jpeg_v5_0_0_start_dpg_mode(adev, 0, adev->jpeg.indirect_sram);
+		return r;
+	}
+
 	/* disable power gating */
-	r = jpeg_v5_0_0_disable_static_power_gating(adev);
+	r = jpeg_v5_0_0_disable_power_gating(adev);
 	if (r)
 		return r;
 
@@ -300,7 +421,6 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
 	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config);
 
-
 	/* enable JMI channel */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
 		~UVD_JMI_CNTL__SOFT_RESET_MASK);
@@ -340,17 +460,22 @@ static int jpeg_v5_0_0_stop(struct amdgpu_device *adev)
 {
 	int r;
 
-	/* reset JMI */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
-		UVD_JMI_CNTL__SOFT_RESET_MASK,
-		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		jpeg_v5_0_0_stop_dpg_mode(adev, 0);
+	} else {
 
-	jpeg_v5_0_0_enable_clock_gating(adev);
+		/* reset JMI */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+			UVD_JMI_CNTL__SOFT_RESET_MASK,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
-	/* enable power gating */
-	r = jpeg_v5_0_0_enable_static_power_gating(adev);
-	if (r)
-		return r;
+		jpeg_v5_0_0_enable_clock_gating(adev);
+
+		/* enable power gating */
+		r = jpeg_v5_0_0_enable_power_gating(adev);
+		if (r)
+			return r;
+	}
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
index bd348336b215..5abb96159814 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
@@ -24,6 +24,12 @@
 #ifndef __JPEG_V5_0_0_H__
 #define __JPEG_V5_0_0_H__
 
+#define vcnipJPEG_CGC_GATE                                 0x4160
+#define vcnipJPEG_CGC_CTRL                                 0x4161
+#define vcnipJPEG_SYS_INT_EN                               0x4141
+#define vcnipUVD_NO_OP                                     0x0029
+#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
+
 extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
 
 #endif /* __JPEG_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index a15673e2dc99..d27fb4ea6612 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -428,6 +428,7 @@ static int soc24_common_early_init(void *handle)
 
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
-- 
2.45.1

