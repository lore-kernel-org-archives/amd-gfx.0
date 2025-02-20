Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D24C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B856010E0FE;
	Thu, 20 Feb 2025 18:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvFgyFpG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F8F10E0FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgIETWFkKDGaT49lZYjiDICj547eyuulw+8Vl8xR2yjA9+eGNBSsKbS8MFGrZ9mr0UQx9JIPOlBdLeYHEL2jdgLa571Bqd7DU/LiIJQk1/fjz7eSsANgXP/+nyoUtm/nbQRRe4kbgk4cdnCzGnvx94YSG9v3K/hHgq5/iL+x7Ropxk2RbFGj5nGfeGTBLmWY04m6Lw1aQ8GxDKOmqsY0Vm9ZOszS+1G/ftbKH6TRjatVdz+jfDUVcHkoS01fGPO0KRBWxlyrin1efMwVWfyG2xhqJA1D54h5HisuLnuRjgVKZLw/PcS7kJ3kQ5+u1McvaopSV9PlVmqIoYq32ckYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGlUf1R9lb6bPh9SgZKpZNRy9KCm/wvZu2R8wR6YEn8=;
 b=FDEOTS/XhC+nk30tyo45UxMF6U7TS7aTqHzL379RvYXm7P8k7nt3uufm2IPONuekKgrmgzGnmD8kzxNCDxhgmmwnJxPEZfjY08ZCvpcPY5BroBwTShwY26KTF3oNxtZsYd3dQUECZ8+rotNF81HkxV9oOpzVN0+fjmNZ7XYMaa53h9wloK6jVeSDuBnS4tXREBIqh1Fv3uT3VCDn3YvLl5Zrf1ZjSNvTLOThj/xUBGi217igklQk9nm0RcPAfvw+hJfUrA5RwbNVcWz5OfkgmQODz8OnJvg+a5tUlWyEpkrV5yAkWFGGyGOCvUX7A7QMUWpuisipdQelYTk1qbDGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGlUf1R9lb6bPh9SgZKpZNRy9KCm/wvZu2R8wR6YEn8=;
 b=yvFgyFpG5FeyUUvjm6+1u/IT5GotPtWtRTEAX3Daxlrg1WbLFb4KC2ZUOvyD2rwOQumKY7r2DH5HAvEFYmgQL6VgEPHeaJGXMPcDa/tZUoRFpChWkcRoOhTdB5xq4uh8xVrcalhPY9Ri7zMx9Se9O9mlAXWkpr/1RnaRWhAvu2c=
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:37:34 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::ac) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 18:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:37:33 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 12:37:25 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Per-instance init func for JPEG5_0_1
Date: Fri, 21 Feb 2025 00:06:51 +0530
Message-ID: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac02314-97eb-49e9-1d3d-08dd51dda3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TThkb3ZnL3FwS1o0bFNVVEtzNXlsNWtTdkxEUUM4S1B0QzVtZ2ZUbTJIbFNG?=
 =?utf-8?B?Tk1sWHcva1gxQlQ0VEd4QnRham5mRG9FeU5XWFVuNmZpdCs2RU5aNTNLQkJ1?=
 =?utf-8?B?MmJXZlg2NHJIdm9qS2lvbGRPd3E2OXRyelQ5OTl0VEtTakdxeEJHeDdMQWNh?=
 =?utf-8?B?b3lkeU5STHNMcW0vRHVwMlBiMFJtUW01MnhyMm5oUzRJVnVXUGorMUFWajBT?=
 =?utf-8?B?NEk1VE5jc1NRT3lGNnRSQ29SS2tzN3gybnQxUjV3VGQvQStUZUZwakdJRUNz?=
 =?utf-8?B?N3VaTi9hL1AxOXd0cnREbS9rdXZMNmh0S2I5bU1tUmdoYkVYS0p2MEJKbmFi?=
 =?utf-8?B?T3h6MEh5KzlqdzVuVEIvSTlEUVJtZlVOOUlCb3VwV0JEVTdBK00zSjhHb2h0?=
 =?utf-8?B?dUZlWWZoRHlIL2p6a3kxTlFaOUwyS2V6QWlRMWFSeUtlTlVUTWpRMkVUNUlJ?=
 =?utf-8?B?cE9UOCtDL1I5ZUNyNEpkc3BoQyt3dVVRbEFmaWxyWXpiNnRUL0UrYldkdHhP?=
 =?utf-8?B?dklITk1UTjFCc2lLZ2R6ZThIMnRYV2QvYUlRQm81UklhNHpCNm9NQW8xaUNN?=
 =?utf-8?B?UDEvQll4L1JMQW1KZFd6TE9VTUhrdzgyTHRoWmtjU3diaUx4M0pIU2hYZDFM?=
 =?utf-8?B?VDJjSDJ6bGJscWk2VHFicVJZUFpzRUppNVZHYjNQanRrUnNrZ3JXcnR2Qjdu?=
 =?utf-8?B?M2NIbUlvTXVNRlFjOXFzenREdDFCOHlrNE5nSlFzY1RFNmlhZ3BqbWlNTkw1?=
 =?utf-8?B?aU9RZWxsWVp3S3A3bHVaOGxJd242ckM2N0N1M1B5RVZKdC8rUWJTZ1RxRmM1?=
 =?utf-8?B?cHRDUGNPSFRnUXhzbm9UR0QwQ2xZSWpONHhtdGk0clVPckttYzRETzBGRnQ1?=
 =?utf-8?B?ZEFOVHp4c3UxbjR3TTZrZkY1YkFqd2I3cnRtblRqeGorTEpETlVsTUZ6T09V?=
 =?utf-8?B?em44WGNyd2hEQ2pEOHhmMnRKYTI0WVMwaG9oejFZeUl5UjRqVjNXVGVGM2RX?=
 =?utf-8?B?TDlvd2tVK25CaU55TnM2QTQwTWRHbEx2ZVpYNEFzREJKU2JNbThPUko5VkMy?=
 =?utf-8?B?VGF3dXdyKzk5bURZZFdDV0RxZHpxYk9wTGhHeVhicXQrMjFodlprWHF4eVJV?=
 =?utf-8?B?SGZWNDRwakdWNjUyZ0l6ZS8rV0wvUFk0QmlsbVNVcFV2d1pXN0xHeUpCa0Fq?=
 =?utf-8?B?bmZndXZKaWVBN25mYjdCNkp0N2UxRVVzMWx2aDZGTDRaRzNabTB0TjdlcURv?=
 =?utf-8?B?VFVUOTZ0ckoydFJvNGVBWUV6S09PUmtUSldlWHJSZkNmUnN0VzJZWXdkQU5Y?=
 =?utf-8?B?THl3VHJxVU5XT1BuYW1KK2c1UzlCa0FtdXd3ejYrWjFTSTRWOWczVThlc2NE?=
 =?utf-8?B?emE1cXlBZG9UU2tVMExDV2hXbncyQ2pPdFVPMXlveUFubnl1ZXlsWGJuNHYz?=
 =?utf-8?B?bjcxR1pwSGgzNkN5ZWhWam5LTzIrNkFSRHdGSTYzWlZUU2hqMUpyS2RDL1ps?=
 =?utf-8?B?NTJaVCtSMFRmYWZrczZUNndHN0FPZkdEYW1BaFVOZDJyeDhVRU5JTlNXSC9p?=
 =?utf-8?B?a2ljOFVoeDArK0JuREthdU5Ka2R1WFRFL2hoaDlGSVdKSnkxRmhoOTJHR1lE?=
 =?utf-8?B?QlowMTJDRGo5bG5BcHo0L09saThzMnhZc1VWM0RkblBZSktvYkJkemNkMndi?=
 =?utf-8?B?bUY5S0tlWXNkZG4xczkwcWJtVWZrYzJ0aTVrc09hNFhuMHlIcXJQK3lQTGdI?=
 =?utf-8?B?UWhHSU5qOFJ1OGZXUWFRam1OZklJTWNDcXptQjJpNUlFTVdaNXNJenRZbVBY?=
 =?utf-8?B?VCs3RXVXM2Z1MkFhWHBtTXdyMHNYalRnVkFkYlUzaFU5Z1VuU0NDdXhaenQ2?=
 =?utf-8?B?cnJsZERseDA2U1pHUm1RejVhcTVHb3N5Y3hPRnJ5bXorVkZ6eHJUK2xHMmd1?=
 =?utf-8?B?SXZCZ1g3VVpUa1B6WUJ1dXNYekMzRnp1S21oK2FtR29QMXl6TnQvNGtLc3Jm?=
 =?utf-8?Q?1w8TOVBMVYBok1TdTZPerOCFK4fjgI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:37:33.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac02314-97eb-49e9-1d3d-08dd51dda3cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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
initialization and deinitialization in JPEG5_0_1.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 150 +++++++++++------------
 1 file changed, 69 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6e3f522e9133..07481cea55c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -326,11 +326,10 @@ static int jpeg_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
-static int jpeg_v5_0_1_disable_antihang(struct amdgpu_device *adev, int inst_idx)
+static void jpeg_v5_0_1_init_inst(struct amdgpu_device *adev, int i)
 {
-	int jpeg_inst;
+	int jpeg_inst = GET_INST(JPEG, i);
 
-	jpeg_inst = GET_INST(JPEG, inst_idx);
 	/* disable anti hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
 		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
@@ -339,20 +338,75 @@ static int jpeg_v5_0_1_disable_antihang(struct amdgpu_device *adev, int inst_idx
 	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS), 0,
 		 ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
 
-	return 0;
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
 }
 
-static int jpeg_v5_0_1_enable_antihang(struct amdgpu_device *adev, int inst_idx)
+static void jpeg_v5_0_1_deinit_inst(struct amdgpu_device *adev, int i)
 {
-	int jpeg_inst;
+	int jpeg_inst = GET_INST(JPEG, i);
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
+		 UVD_JMI_CNTL__SOFT_RESET_MASK,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
-	jpeg_inst = GET_INST(JPEG, inst_idx);
 	/* enable anti hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
 		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+}
 
-	return 0;
+static void jpeg_v5_0_1_init_jrbc(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 reg, data, mask;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0;
+
+	/* enable System Interrupt for JRBC */
+	reg = SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN);
+	if (ring->pipe < AMDGPU_MAX_JPEG_RINGS_4_0_3) {
+		data = JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe;
+		mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe);
+		WREG32_P(reg, data, mask);
+	} else {
+		data = JPEG_SYS_INT_EN__DJRBC0_MASK << (ring->pipe+12);
+		mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << (ring->pipe+12));
+		WREG32_P(reg, data, mask);
+	}
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_VMID,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_CNTL,
+			    reg_offset,
+			    (0x00000001L | 0x00000002L));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			    reg_offset, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			    reg_offset, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_RPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_WPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_CNTL,
+			    reg_offset, 0x00000002L);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC_RB_SIZE,
+			    reg_offset, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC_RB_WPTR,
+					 reg_offset);
 }
 
 /**
@@ -365,69 +419,13 @@ static int jpeg_v5_0_1_enable_antihang(struct amdgpu_device *adev, int inst_idx)
 static int jpeg_v5_0_1_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	int i, j, jpeg_inst, r;
+	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-
-		/* disable antihang */
-		r = jpeg_v5_0_1_disable_antihang(adev, i);
-		if (r)
-			return r;
-
-		/* MJPEG global tiling registers */
-		WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-
-		/* enable JMI channel */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
+		jpeg_v5_0_1_init_inst(adev, i);
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			int reg_offset = (j ? jpeg_v5_0_1_core_reg_offset(j) : 0);
-			u32 reg, data, mask;
-
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-
-			/* enable System Interrupt for JRBC */
-			reg = SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN);
-			if (j < AMDGPU_MAX_JPEG_RINGS_4_0_3) {
-				data = JPEG_SYS_INT_EN__DJRBC0_MASK << j;
-				mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j);
-				WREG32_P(reg, data, mask);
-			} else {
-				data = JPEG_SYS_INT_EN__DJRBC0_MASK << (j+12);
-				mask = ~(JPEG_SYS_INT_EN__DJRBC0_MASK << (j+12));
-				WREG32_P(reg, data, mask);
-			}
-
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_LMI_JRBC_RB_VMID,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC_RB_CNTL,
-					    reg_offset,
-					    (0x00000001L | 0x00000002L));
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-					    reg_offset, lower_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-					    reg_offset, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC_RB_RPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC_RB_WPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC_RB_CNTL,
-					    reg_offset, 0x00000002L);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC_RB_SIZE,
-					    reg_offset, ring->ring_size / 4);
-			ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC_RB_WPTR,
-							 reg_offset);
+			jpeg_v5_0_1_init_jrbc(ring);
 		}
 	}
 
@@ -443,20 +441,10 @@ static int jpeg_v5_0_1_start(struct amdgpu_device *adev)
  */
 static int jpeg_v5_0_1_stop(struct amdgpu_device *adev)
 {
-	int i, jpeg_inst, r;
-
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-		/* reset JMI */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
-			 UVD_JMI_CNTL__SOFT_RESET_MASK,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+	int i;
 
-		/* enable antihang */
-		r = jpeg_v5_0_1_enable_antihang(adev, i);
-		if (r)
-			return r;
-	}
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		jpeg_v5_0_1_deinit_inst(adev, i);
 
 	return 0;
 }
-- 
2.25.1

