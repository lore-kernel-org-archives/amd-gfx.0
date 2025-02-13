Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C65C02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6953910E9D3;
	Thu, 13 Feb 2025 03:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gi1dCvL9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A1510E9D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7xAIYmkMwUApJpfS6bz1I5Yn4qOHoJnEwYcUHsK+s4jumBTEq3nm6ohqGhxTbF50goxQQA1OR7noU80Goxervx3dN+LW5ODOrAHDHMW37OCVqCgnIGkAbDiwa7iB8jtaQG6ogLtjnJ1KvlyEg44CN3Z3GdPWgZ8ohT7lUuO4UJfLAw9zzlojaBHr+c1lFYfKYqMhwTUyWrkAC5YO4v/FHYZRHbsMjwlQuXZDl7Uopp/vBva4NpO9VGXqO7dSbFzrhmePmTj+IM+Lx1iMc3byI4041RIihsvTMwLs8VUOfsiB/P2mvTGaiIO5jyXuOPCY8ZpeFRifRxX//p5Efdj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUJtJ/CsLjnDC4f79V4Ra2zjjMTovdlxhbJHGjPBJsU=;
 b=c7/86DYFkyvajfAPEFrOleKXLic4/JNwHAFjwRJQQvfDd2CV6+BMRspKLvvBQ+mWf8mwbMM0mU68U+4brgAjvFNFj8TgDUytR9eiA8ch4Zt63ePF6H2JNd+CzEfIBVJoCkFEH/mkA4VJleuTwUDAxAU++6xt2WB4E0386nRti0qs/aiQFYmU/bNzxsPGkLwjAe6WPa8tTIlgjJAzppFyV61B5q1iEvuKHET2ajNaXfwlKJ7SKK69IFiwweGY68lyrgeFM3P5/35pKjlAY2JT/IClfe1aCv+Z6ERmSWA5dDgvv6aGAarTaLDwA1eucpm/yP86xxRfr6Ty8ynO9gfOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUJtJ/CsLjnDC4f79V4Ra2zjjMTovdlxhbJHGjPBJsU=;
 b=gi1dCvL99CBUnLZH4oxcUISxQ0wHH6vNgokkXJiY/WsQlLhAYri2g5RoJsGRLNqN4XDLU019+15zzwsIHD0iOxmX29tp9x/MDAfGXoGw5NHtFEGBTI1ZHxVjYQM+OLumPr/e1kdd8a5WZSOg9IhERZ4PTomFTcRfI06WSYulM/I=
Received: from SA0PR11CA0188.namprd11.prod.outlook.com (2603:10b6:806:1bc::13)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 03:19:34 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f5) by SA0PR11CA0188.outlook.office365.com
 (2603:10b6:806:1bc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 03:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:19:33 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:18:47 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
Date: Thu, 13 Feb 2025 08:48:08 +0530
Message-ID: <20250213031808.2403728-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 9051655e-e543-4772-036a-08dd4bdd3cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJocnlWeFprSGs0a2dYVzBTeUlXQnFvSTJOSkU4YjdVTVU2L3J4UUhFc0VO?=
 =?utf-8?B?dlFvZEJOZWdJcTJSTmR4eDBONnRCV0xaclQ4dEI5dmtGTm1pc3VkVXkvclpH?=
 =?utf-8?B?NEp1OFZiYlE3QmRxS1Q2ZGFJM2VDKzhtSGxaQllrZjVZQlpWZmFrNU9jTUhC?=
 =?utf-8?B?Q1YrbE95dUxrMjJnVVZsd3I2bWhpYS92NGlCUHBMQ2pjajdObitvNkYvU1Bz?=
 =?utf-8?B?ai9aUFpZOUlKSncrNW00MHVPWlZ5VlVZMUV3WVBkTHdTeEN5aEFjS3RSeGIw?=
 =?utf-8?B?REN0YzZHc1cyQlNEM2lIdDhzTTJYbnk3dmh3WHY3NnQzcS8ybEpEZHFIL2hr?=
 =?utf-8?B?VXdVRFRpSVVoTG1lSkdIS0syQmZ0dXJqemMvVFdkZElUU2hyYW5oemp5b3dQ?=
 =?utf-8?B?UVJRaTl2NEdNbVVMUlNPaG1jV3MyTXlmckZ6dEx1UFhIc3FVZkpKUVJCSWth?=
 =?utf-8?B?Y0VTbGJWRGp3ZzdJdnNzUW5ZVG42SkYvemp5bmFmbmVEWVdWQkdOWkxIdXdn?=
 =?utf-8?B?L0dDZVVzVk9WRnJBdUUvRHg1RVlqTENFN0xVM0F2cFAwNHV6dDc5L1FGNDRR?=
 =?utf-8?B?dWZRajlEY1ExY0xZNFRQZFFBVnRCeGJrWk1nTjM3SVgwdWV2WGdrL2hoNUJZ?=
 =?utf-8?B?UGU0c2h1YTNWbG5hTlhiZkNjT2t3TmhLZ1JCRHdEeEdHZC9FY0pkcCtCZ1d4?=
 =?utf-8?B?RG5xRmN4L2VvN3ozZjF5a2FSMWlhOTJzcGxqMTRod2hZbWUrcDdleHd0bmRI?=
 =?utf-8?B?VXkvaE5jR3ZWcHNodGdHZ3RGMkdQWjJuOGNXY1FucU1Ya3hFaW5jNGZCTCtU?=
 =?utf-8?B?ZXBFbXZGa3dCV0cxZE9UVGdBVkhkRXNnVElGMmQyWE82Y0JKTlZiY2FJaitm?=
 =?utf-8?B?dkRJMFF5aUx4bnZxeUNteE1iblRFL0liUUhSbS9lcGlMRU80ZjEzd1MzRy9a?=
 =?utf-8?B?N2lYTWMwaTNENTZJZlAxZWQ0aTV5YUxCcmxBVEE0NzRmaWYzK1c1RG8xdmdN?=
 =?utf-8?B?ejFYMHA4OENIRWFkOHlhT1ZmVlFiQWM3RmlHZ3BHR1kzZGYzNGd2Ny9RY0Mr?=
 =?utf-8?B?T0JJU3d4ZEtyRUR0a1BWM2U4OGh0dTRySXlHekpURVdsOHFqTFZVOTRicWFI?=
 =?utf-8?B?TGU2aXZXR0x0Y2hCOWRQNHhkMXhrWjY5ZDVmb2ZaSVRDZUF5Snc4dTdWblk3?=
 =?utf-8?B?WStJV01iRWpuMEFPL0dtc2NGTmlTMmxoYlB2SVF0VitjL0Voc1Y2ckw2cnJi?=
 =?utf-8?B?L2NlT01oTUtYaGordUEzbWd1Q1N5alowTFpNRlNoTitkbkZrYlM3WDl2VHVT?=
 =?utf-8?B?TTE5V2NhWjI4K2o5bmVtbVBOUGh1RTIwRFNpcXRvQm9hMFllbllDbWNBUGg5?=
 =?utf-8?B?bXB2UHFkN0dpN29mcFpUcFluNnE1TDQ5NXVzakE1dld3ODV1QXU3cUZIaE5m?=
 =?utf-8?B?Z0VNTXBLNGVGQnZYNUpxVUlIT3R5QW9Vd3EyQS83NU54YkFGajJrYkpSYSs5?=
 =?utf-8?B?MGRQZHVPL0hVZ1p3T1dHdWtvbi8xbkdDMHl3a1JyeDVkN09FYU5MMHVYM2tS?=
 =?utf-8?B?dExmNmxPK0FDMk5BUmZXMHJFcDZoUlZvZDh3WnlESitCVklRMVZvQmQ5TG4v?=
 =?utf-8?B?RGd0UEcydFV3bW9nclAwRXNCdkxBQkdsMCtFenVkUytXNndEOFBLS0YweENq?=
 =?utf-8?B?SEpNY0pMZEtZUnVpTTF2cWlqa0QxeTd1UlA4T3NFeE43ZWtQS0tsN1ZoR3BU?=
 =?utf-8?B?NklPdG9rdkpLY29MMlJycEVTRUVLSlh0Y1RMOXZFZUZKWXoxbEY5Rm9jTGlD?=
 =?utf-8?B?c2UySWpFcUtURUlOcDNYNUl1aXloZWhEQ1RPTnVDR2NFMWxVVXBpRTR1cDU4?=
 =?utf-8?B?OHhPMWREcjlXS3JjMk8vL2ordG9Kc2NNVzFqSFBvcktpSVh3UWdkVmhydTIv?=
 =?utf-8?B?aGVjN3ZPdzRaWWV0Z0p2RTVVWXBuWTJxejR6MGpOSEJwcVp6cG0zYjlZdmZk?=
 =?utf-8?Q?kCOcj6OQgofRJT3LoltCyRQy9GYm6E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:19:33.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9051655e-e543-4772-036a-08dd4bdd3cc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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

Add helper functions to handle per-instance and per-core
initialization and deinitialization in JPEG4_0_3.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
 1 file changed, 98 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 2a97302a22d3..e355febd9b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -525,6 +525,75 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
 }
 
+static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int inst)
+{
+	int jpeg_inst = GET_INST(JPEG, inst);
+
+	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
+		     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
+			   UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
+			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* JPEG disable CGC */
+	jpeg_v4_0_3_disable_clock_gating(adev, inst);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+}
+
+static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
+		 JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
+		 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
+			    reg_offset,
+			    (0x00000001L | 0x00000002L));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			    reg_offset, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			    reg_offset, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
+			    reg_offset, 0x00000002L);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
+			    reg_offset, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+					 reg_offset);
+}
+
 /**
  * jpeg_v4_0_3_start - start JPEG block
  *
@@ -535,84 +604,42 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
 static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	int i, j, jpeg_inst;
+	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-
-		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
-			     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(
-			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDJ_PWR_ON
-				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
-
-		/* disable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-					  regUVD_JPEG_POWER_STATUS),
-			 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		/* JPEG disable CGC */
-		jpeg_v4_0_3_disable_clock_gating(adev, i);
-
-		/* MJPEG global tiling registers */
-		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-
-		/* enable JMI channel */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
+		jpeg_v4_0_3_start_inst(adev, i);
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
-
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-
-			/* enable System Interrupt for JRBC */
-			WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-						  regJPEG_SYS_INT_EN),
-				 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
-				 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
-
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
-					    reg_offset,
-					    (0x00000001L | 0x00000002L));
-			WREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst,
-				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-				reg_offset, lower_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst,
-				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-				reg_offset, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
-					    reg_offset, 0x00000002L);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
-					    reg_offset, ring->ring_size / 4);
-			ring->wptr = RREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-				reg_offset);
+			jpeg_v4_0_3_start_jrbc(ring);
 		}
 	}
 
 	return 0;
 }
 
+static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
+{
+	int jpeg_inst = GET_INST(JPEG, inst);
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
+		 UVD_JMI_CNTL__SOFT_RESET_MASK,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v4_0_3_enable_clock_gating(adev, inst);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
+		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG
+		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_OFF << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+}
+
 /**
  * jpeg_v4_0_3_stop - stop JPEG block
  *
@@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
 {
-	int i, jpeg_inst;
+	int i;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-		/* reset JMI */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
-			 UVD_JMI_CNTL__SOFT_RESET_MASK,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		jpeg_v4_0_3_enable_clock_gating(adev, i);
-
-		/* enable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-					  regUVD_JPEG_POWER_STATUS),
-			 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-			 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
-			     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(
-			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDJ_PWR_OFF
-				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
-	}
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		jpeg_v4_0_3_stop_inst(adev, i);
 
 	return 0;
 }
-- 
2.25.1

