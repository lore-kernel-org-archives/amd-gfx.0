Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE1FC0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44C210E381;
	Fri, 31 Jan 2025 16:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eNxr43yi";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78C010E381
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ssdzr7WtmpX9rs/gyG5+g9RHLGDNS8U7UCk0hBJuOxt36D30iHoQYFoIYwTWkEQpiK3v9/CMbDvktlHrKq+91u6eqqjtgljumcwdLer1VhmJPQ7Ek1ZyTBCaPlqYCd25YDtWc2h4TDFAKGV6cHPYrWWG7nEICR5a417gvbxBdbTOLCbEnXr/0BfLQfk0GZCFMm5T/GXfi5Il5mbc+bfqe/b6EHra+qXEpKv7M8bXIt6FJwzd5vyCvHSwup+9KQ5UW1JunRRr6pdFxA4A7f3jAg+tnPtT+fRjtaehwiNxB7mTQnRHvdWsevjd8BozHnUTvaHfcwSOY7gn3hBwX/nTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YeDErUlmIwKnv51U733FB4WH48vOZL/UoyH5nijlVw=;
 b=Gx6OWeLuO7aDwAe3g+f956nyHcFAJgkRk0PKEt9GO+ed4ngfOAtVEMtVqfBDVq8FEzYJ81c7F4fAgt7s5P0WzAByLrKKl1WdJPodxuuptgXfUUy8EYxohGDADaDzb/DXJry86eHQUux5Wt0gA3yuahlSHVSzpGLV+LlzKmRfwBdrPmDejkCjh6bToR/yx2V92/srSF14oF/5DV6qGU5b0BNTcs5L6oZzBEDVhzeIDka1GKC3ipxrprMBERJYF6HTb7TJKC3cdbJzw+PAAwDPhjtbpLOCJX8hwjmQ8jIQui687ztBjtv8b9Dy6lWxbHlE0IA8AZZHm6Zh5F87R8HX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YeDErUlmIwKnv51U733FB4WH48vOZL/UoyH5nijlVw=;
 b=eNxr43yiDc4RqprHJEMz0/jO7FWCOXPmN5vfEpLpIrmXlCkrylLgiIm7BO7jedRAi7FqnCZcLFf1woTZbapQKYUGszANkB1J1YajPDs545a3ARmeACHC/9xWbUMt+E+N+gYMu+ZIKW5ngA18QU/OT58/JDsDtXmjFpoFNTymc2A=
Received: from PH7P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::9)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:24:58 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::5d) by PH7P221CA0078.outlook.office365.com
 (2603:10b6:510:328::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 16:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:24:58 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:24:55 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Per-instance init func for JPEG2_5_0
Date: Fri, 31 Jan 2025 21:53:19 +0530
Message-ID: <20250131162321.563314-6-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a14e0c-2fee-47f0-58a5-08dd4213cdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTlaR3RBZ3R6aWtOTGFVeWhLMis2Z2ZFbWRkamEyODAwc2ZxWUlnOTZ2eUJ3?=
 =?utf-8?B?czlmbVBWSTBuME1uOENzREhzT21uZ3oxNnA1VmlSOTN2eDZQSnJqVVhRUFhy?=
 =?utf-8?B?YU9TMEN3MXNkcGxJUi9OSm51Z2FLTTV1bndZYkpVZ0lWZkJ2OERNT3daVjll?=
 =?utf-8?B?UEJMZVl3cTV5NEJJMmljMlJobkt0TXhyRXpxOS82MDVoMktMNmtnUWkzSCtG?=
 =?utf-8?B?Vjdoc2phRXlkYkdyVUJpRUdtd2lkRzlkSlorR2dKNTRKTFdvOUl3aU15ZVpx?=
 =?utf-8?B?dXVJaVozd1hJVDhqbjQrV2lzVmtseFZ5NEQvaHd2b3ZaaVJaL0tReEZWUjNq?=
 =?utf-8?B?TW5PRXF5Z2NKN2NUT0dhalk5Wjd2RmtPSnd4MkpJRFBRb3I2TzlWOVB4Z2JV?=
 =?utf-8?B?RTNkWE1PWjFkOWR3VksxcUxPb3FDWHJHTkVMZFVOaytPUFAyUkU1QVdlRE9x?=
 =?utf-8?B?cGREenJUMnBpbzRSbVpBWmFOTjZjVHBScXEwdnNzVjRDNWg5UUxzdnpvT1VV?=
 =?utf-8?B?RUZaR0NIbmc4WGp2WCtHazVRQ0lFWHU1cWRXSzhUK3ZOeXJ3OWJ4S1FpRm1C?=
 =?utf-8?B?L3psM2JCenNYMzgzdEdNYUM3VFBuc081K0RUdCtabWdRSmZXUmR2QkI4dDJJ?=
 =?utf-8?B?Q09zUmJCOEZaYWFsaGo1eVhMellCN1RsY1Y0RzZsTmh3aUUwN0gzUmFKUUZt?=
 =?utf-8?B?Q0x4VkcwVW9pc0wzZjRGY1NSeFRwTExhZVVPNDBKYVUvd0t6cWVEQXJ6UWVy?=
 =?utf-8?B?TzFUdFV5SGViTWNnRWlYKzgxdVhSV1pBSVRtemtSUytwNUx1QnZVZGkvMUZ2?=
 =?utf-8?B?T0pXUVFZYkFuVEpBcjFEZ3RpRFhML0h4aWxrQlJlVWhXVHBYVXU4SWdOdnJQ?=
 =?utf-8?B?d0xKbmtuQjZFekthVlpHU3JCcnZldU5qTy9zTFBEVVRIRzArL29RT3BLTGlF?=
 =?utf-8?B?dkRzSzdqaVB0WVEweVAxVXRVUC9JK3RnV2tyRlJINlVvWnE2Mmt4VnJUZXdw?=
 =?utf-8?B?WDZXZ044NStBcVF6TWk4MDNxU05mKzZoWDlGZ1Y3bG5mWkR1aHRxaGlCTTR1?=
 =?utf-8?B?U1JDVUh3OVpYbmI1aVlFNXowRXFqR2EvQlFGNWFPWEM3dFkreDdic1d2dUxD?=
 =?utf-8?B?NUtkb01pN2tibjVlblRIZG9Sd291YXF5MkhWcExuSU5kTXl3NS9ISk1RNUsz?=
 =?utf-8?B?TkxlcG5ZUHdYdjR0S2tJYkJIY0lBY2VJVU4wOW1WZUYzeFh4U1FzSW5zVjA4?=
 =?utf-8?B?QzFIdW1yMG0rSU91NTlmV1ZVSGhTdWUwSnJUSktINDROajVxcEMxR24yU0lK?=
 =?utf-8?B?bXVMQlpJUzJFQlZZSmtOZUM2eFdGd0xWVTd0cHREM01EQU1hZmw3bUtyV2xy?=
 =?utf-8?B?QU1KbGlJRE5odDBLamtWaVhsdUNnSDJmMjM1aERtR1dSYy8zRlgvOHZQcjdh?=
 =?utf-8?B?NlNoV25wUW43cWVCM2ZKZVJLeEw5UjJFeXRTdFFZcm5xWU9rQUc2ZGJTRjhv?=
 =?utf-8?B?a2NTZUZnTGJ0WGtNdlJGWU1tTWN3VHcwcWZpbWhCMWdIV2xwczBqNG14U0Rn?=
 =?utf-8?B?NlFwL2xrOVBQVmlpc29wUmVNTk1IcG9xUmR2d1ZiWloxZWRScThrR2tOdVUv?=
 =?utf-8?B?NjFoamhHYTdqWEJHeUhEampubThrdmxEQSt3NThVQ0NseVJlOG9xQ2I5Ni9X?=
 =?utf-8?B?ZUl1Zm10L2ZCdDFsZStadUtOaFlBUEYyRmRVT3IzQVFYUm1hS05zNFpaemxX?=
 =?utf-8?B?OERuUTcwYWh1QkIyc1JnK2RTL09PRUdNUlcvcXB3OHBvQWRJVVlTOWtjR2li?=
 =?utf-8?B?VXRGVHFxVk1HMm4xVFlDdVhrS2VWQ0VNRlU3ZUhJMVNBYmVmNjg2SklpQkxm?=
 =?utf-8?B?aTBGcjdlTENuQ09IanE4UzhlYmNJQ2g2ZS94dWhtNEM3YW1kUXhPRjdiZFh0?=
 =?utf-8?B?OXFCbjMvZVVwYm9NN2RMTUxoZXhOQUpnYzA2a1NKM0RsMWo5VzR4dTNHRnBO?=
 =?utf-8?Q?rD7KrMQzo+TKHjbOZDX/nTgn70I/i8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:24:58.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a14e0c-2fee-47f0-58a5-08dd4213cdeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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

Add helper functions to handle per-instance initialization
and deinitialization in JPEG2_5_0.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 102 +++++++++++++------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b19724928ce4..0490b672d8d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -330,6 +330,44 @@ static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(JPEG, inst, mmJPEG_CGC_GATE, data);
 }
 
+static void jpeg_v2_5_start_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst[i].ring_dec;
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* JPEG disable CGC */
+	jpeg_v2_5_disable_clock_gating(adev, i);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC_MASK,
+		~JPEG_SYS_INT_EN__DJRBC_MASK);
+
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR);
+}
+
 /**
  * jpeg_v2_5_start - start JPEG block
  *
@@ -339,52 +377,33 @@ static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
  */
 static int jpeg_v2_5_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
 	int i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
+		jpeg_v2_5_start_inst(adev, i);
 
-		ring = adev->jpeg.inst[i].ring_dec;
-		/* disable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS), 0,
-			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		/* JPEG disable CGC */
-		jpeg_v2_5_disable_clock_gating(adev, i);
-
-		/* MJPEG global tiling registers */
-		WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* enable JMI channel */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL), 0,
-			~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		/* enable System Interrupt for JRBC */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmJPEG_SYS_INT_EN),
-			JPEG_SYS_INT_EN__DJRBC_MASK,
-			~JPEG_SYS_INT_EN__DJRBC_MASK);
-
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_VMID, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_RPTR, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, 0x00000002L);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_SIZE, ring->ring_size / 4);
-		ring->wptr = RREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR);
 	}
 
 	return 0;
 }
 
+static void jpeg_v2_5_stop_inst(struct amdgpu_device *adev, int i)
+{
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v2_5_enable_clock_gating(adev, i);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+}
+
 /**
  * jpeg_v2_5_stop - stop JPEG block
  *
@@ -399,18 +418,7 @@ static int jpeg_v2_5_stop(struct amdgpu_device *adev)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
-
-		/* reset JMI */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL),
-			UVD_JMI_CNTL__SOFT_RESET_MASK,
-			~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		jpeg_v2_5_enable_clock_gating(adev, i);
-
-		/* enable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS),
-			UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+		jpeg_v2_5_stop_inst(adev, i);
 	}
 
 	return 0;
-- 
2.25.1

