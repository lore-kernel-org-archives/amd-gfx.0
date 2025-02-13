Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0AC02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5785C10E2B5;
	Thu, 13 Feb 2025 03:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jciKOD31";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71AA10E2B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD7u85ZxgQJH/tLYF8LQ32KOOxM2IaMI5rFX/Y5B101mpoFd+V9OW/nsZ92UG63zY1rhkw402IGX5uHtBuuetVUz0dye8HJDlfRJCaPty4b6OD2NV+oozZcjKsJREG2HvhsJt4TIephJUfP1to/0fCLTBFtjaGmGNsVx6zfuk0Pz4TO0ZRlC/SbXq2781M2JJ7XCMKWrR7O7osDNTpSr49M2th72FknKaoVw36PTWtJul0hhNXqSUZ8BAWmGzcB95baDJ9dssW5prOxgJ8i7Ac1N2ahavQHeyvBxHw6TEpRKWJ2RijoASF+t0Iz4bf6j1q7oxok73GD8738R9l8Rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQkQm9hgmaqSOOlYvsMMcq4UZp99oEMjjfyJAm1C7yg=;
 b=eGxWyk5SvowbHTgvzfSbSjvwLweYp9WaH/qB6+ZmGqtXJQAJasqnJDWjDMMsy4fxSm7Asn+oDlYpwQNQ3yF2vawrsGG+mt6GmES7nRTP1waKdWV4uyId223SMNceod3r2ODTIV5exy9FwrAMdCg5hjZlA+RTPUvYRUTNz1rU4VV/BdoVd82d1H2U07jIaQpEBQFCB0vXhiMy85KF3wzeDIzDU9nGFGywRWZwNJwr1Yn45uprgVCUYJ2Owju5AgQQ0C8AIahMcSHB1YMaX3LVs9PjTzoU9RykZ85rBRomqFUTmbJVPP/2M0xqRXvPPCa7DQq7yb2RL6gFB/Ts7O8AWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQkQm9hgmaqSOOlYvsMMcq4UZp99oEMjjfyJAm1C7yg=;
 b=jciKOD31Atn6dXyh44v1fv4AJuMs12RjPfBueJ7x8AuwcKEJOmX688PjUPZn6CvqYgX/oaJdPl1aW5Q0uNOBg8jNyzRv0yZxUJsfr68bV39CQr6VMpHdKIM4vRQP9YAqZ2WqXwm9OZiPwWUX+GIJEqWpfvKuBUPb630RKwUs9cY=
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 03:23:42 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::77) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 03:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:23:41 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:20:11 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 4/6] drm/amdgpu: Per-instance init func for JPEG2_5_0
Date: Thu, 13 Feb 2025 08:49:58 +0530
Message-ID: <20250213031958.2403786-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 93defd98-93d2-4f4c-8bff-08dd4bddd095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0NVbk8rb1Nsb2tsVkhDMVZCSVF2am1lU2ZnOWJQMXRIT0JObjVVUU44ZDdj?=
 =?utf-8?B?cVV1QkFrSGFxK1NyVWxCaWdyamJHZGpqWjFnUmZ0QkhONEV4NXhKcEl2NEFh?=
 =?utf-8?B?aTZ1a0dzVDdGdUxoZGk2Z0hDa0xBVTRrWUp0MHM4TEF6em01MmJPK2RkZzVP?=
 =?utf-8?B?WmhJRGVxUThmdWliQjRnMUdvOW1ZVHNIaWtrbHJxbVNSZWFJQUtESmdNdWdK?=
 =?utf-8?B?aGF6b0ZhOGZHdERJWVo2cy9VZjIraUFyNkJISEpkaDhQbXJ2dUhCdm5KZHp5?=
 =?utf-8?B?Y1BObzFrbTQ5OElqOXJiSGRnUyt1M09LY0M4TDlwdDk5NjRBUDhXQU5uQkdZ?=
 =?utf-8?B?TGhnb2oxeFphdUxKWGVkaWxmbmZMRmx1NW1Rcm1LREhsa1lBTHdzb2pBTVl6?=
 =?utf-8?B?cDRYNStHVU0rT3JDTFEyYXRTaTdPR0hMU3IyTXprc3loRm5kT2tGSjE1SEZX?=
 =?utf-8?B?cDVwM0FSb1h0ckY5Rjl6YzdJR1IvaHUyejVVK1Y0Uk1kQ05Jc0RScmtNQVJS?=
 =?utf-8?B?S1hGMit5Yk9hY2dSbXMwZng4YkhReDFiZ21mZG5UZldVMnc5TEczeTdjeHVR?=
 =?utf-8?B?QTVhLy9CS05ZUURXd0VScVdtaTdxY2VmZkNBdjdrQkhsSkIxeENYRW1ZMXJ1?=
 =?utf-8?B?ZkR4SFpUck1mVXMxTXd2Mjgvck9EaFloRzdzeTZBdFdVaTFIRW9rV1h1N0F2?=
 =?utf-8?B?ZVM2VEVMYmx3c29iZDgwZ3ZiN2pZS1k4MmVOdFVVWHJjTmpENWZJV2F4cmhM?=
 =?utf-8?B?REJvN3puM3JKaGtxOFhsSEhCRk9TWjJwSWdhdVpmSXBQTUVLMzFNVHBBSHA2?=
 =?utf-8?B?cG5vVjhnY0hMYUw5R2JTSEFLMWxzQit2WGkzRlpETGJHTG5OM1orVlNOamNp?=
 =?utf-8?B?cWNoRys5YnIrMXRFRG5ZMkxyRkIzWkhlak43cU52RUozejRYbW5aQ2gxMklN?=
 =?utf-8?B?ck8yT2JIUVNsdTVoYnN0MWZNSXlOUlFVMW5KUHNtcVpvYkgzeGRuNE1oTEhV?=
 =?utf-8?B?V2ZwOU5KYTZ0K05NMTJtTHpjZjk0VEV3ckZ5ZStvMHBuTHNMS1czTTdOelp2?=
 =?utf-8?B?dHIwWDZ1ZlFtalJ3RmxYeGxLTFZkVVFOdDZ5djFOYU02bDJGT2o0RkovTnFp?=
 =?utf-8?B?Qm1RVDZ3cE5Id2xKNlU0WTQyYTkvMXFyS3FnaUdobGhzK24vZlQ0MVlnZUpI?=
 =?utf-8?B?Qysyd0V5Mmc4eTNoZmRLWDcwdDNLaVhDVXMzdkovTDM0U0FpRTk3azdybGxX?=
 =?utf-8?B?cVcvVWh4WU9SNXJRNjdkdjAwU0c2SjJvc3ZSZmxzZ0ZGZUVWR2V6WkFDbEc0?=
 =?utf-8?B?cW5jZnozVkFPT2pkSTlUS1Y3aERSVktEN1RrNDdZc0l4dmEzbVVJSjdoNjJy?=
 =?utf-8?B?YVdSaHphY0R3TCtXdjduV2RCWVBzc2ttdjhCdUdaWWRvVHRBa2JaWDI3RzF3?=
 =?utf-8?B?RDBraTlzTGw3Nnh5QnRsYi9zaTVldzZXV2FCZHRsbzdnYnE2d2s5OFVjUmRl?=
 =?utf-8?B?eWlCSjNJcFIyVWozdktrSmFmNFlzZ1RLME1lbFBMYm54MW1yTzVZS1ZzOGFK?=
 =?utf-8?B?NFN3UUt3cXl2WTFBb3EzMThYR2pKSGNuYWxqVDlwZ2lCbG5mcnBCaXZLM25Q?=
 =?utf-8?B?V0NFWlIvRTh2ekNsK3hCRWd6R1FXa29uSVNab0Ryam14QzNPSjh6UDgyaGtp?=
 =?utf-8?B?Q2FoYlVKSHcwSURMQlFQOUQ5VU5GckFzdGNiSkIydm15MFZtY3hGazA1bS9F?=
 =?utf-8?B?bmlDRTI1L2xwWDB3L2ZXV25pa0dIb0hOUU9lTGhOWDZWaVNuMi8rOFNYbUg2?=
 =?utf-8?B?Q3o4aHhIVkNJVk9jWFJOOGVJZDZFbDJua2RGVWpLS1lUK3ZlbXpnbVlOdEtI?=
 =?utf-8?B?Qjd5YmxueEJ2Y0RBQU15WTR2bkluQ0tFbGswVERoandrcjFsdmRvZlpMQVEv?=
 =?utf-8?B?VzM4N3dOWUdxRlVjMWdEcXBFK0FHTUxOelp3UXhQbnhzR1JNSVEwV3B4WHVv?=
 =?utf-8?Q?M96vKYIOUFRUtJXAL6gNgS1CL+HU7k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:23:41.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93defd98-93d2-4f4c-8bff-08dd4bddd095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
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
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
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

