Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B03C02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EE510E9CC;
	Thu, 13 Feb 2025 03:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wLxf1wa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BF510E9CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erWso5dSBlZVHBOgsgWFgqRb9Q7+yCcK2n4fTZhQ/T2ektZoKoTvDAR1fZ1+5DTnpaSVRMs3gYzAfLYlBmUl5EsCrv4UKoVaz29eJFsxDnqdxgT1lULlK1TJ5sPp11umLntxLT0QbkzoriioBfHJtn460vELfuUYArG5aI5eXGgh2FAGWWE/1A/ZSB33RyesNMboqoiOep6sP5dBfJfucxbs8JIUkAjWwqktshU+jv8k6gXQFKv/aoU8f5DEbt4dRsjLkSOEcX1lc9OiijxYuSUo5k8sCV6nc7wxU5c+9yM975Bfx5jAjLx9J4b9yaX6Xoo3onSdf9YQt4kBIKCfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQkQm9hgmaqSOOlYvsMMcq4UZp99oEMjjfyJAm1C7yg=;
 b=buLAx+ijvK5fNFbD7gVdMJfwtsosgc8sTI4iOvTFv9TACvLNCwZjMwR0qStykSPVCalGtBhkk81RJLAdappm/oX4LZXvxqW2xe4fOIzCZ5kQ7Y50L8JIEdk5k8r4qxrREzBBIcNoOm8DNJRdy5/T2rIIbho/mMFytvslWkkBVU2J0hlKU9lbR1V89weJ4JnUEztQi6ni1w8NjiBvr8A/0iki1lzBCRXIcvca0EwAVrwtSGWO5VBsHLsY0v9+kTfTi1mEP+G0cb6w/va2iQJ13XsZ2scSxAQ8xSnX4IgWyEEnKhqpux3+NzslQpDfqMQvmCbT+Ytn/yZ9jBLFvaL7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQkQm9hgmaqSOOlYvsMMcq4UZp99oEMjjfyJAm1C7yg=;
 b=3wLxf1waYBWnuoQqcbf3RYSMCZA31LADa0jC2fbLVmFOBCSFPq0KD8X2FB6gR4aQyFpGfElPPddPKF+j3ddZF6RHluG1bGBRrx0xKctizY03fvbZAw0zSrD+pPnDiO1AspDVs/wPulNMz7sNPMB3JRuCJ4jDRJAYjrxc4/8phts=
Received: from CH2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:610:5a::18)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:07:35 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::50) by CH2PR08CA0008.outlook.office365.com
 (2603:10b6:610:5a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 03:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:07:03 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:04:24 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 4/6] drm/amdgpu: Per-instance init func for JPEG2_5_0
Date: Thu, 13 Feb 2025 08:24:06 +0530
Message-ID: <20250213025408.2402828-5-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f6237d-6d0c-4ba1-1b79-08dd4bdb90ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHlJb1BOODlud05YYlJYa0Y3REMzUmdGWlVPczNDSDdWYVlsYU9BcU95WG9C?=
 =?utf-8?B?R1ZQdGlrcllBdmRlZnBiK0ttSU54RHNnVGNpOWoyYS9SZXUvLy8vWmZ0dm1l?=
 =?utf-8?B?ckhrM2lMQzRLL3N1eExBdGdZd0NqanJDM3p1NnJqTFlEa3ZmS0VpRTQ0dHU0?=
 =?utf-8?B?V1owWUpuVFZjM0dnYUFlNUFqeGVkMDQwZktGMS9CcmJRdytFYnJvQ3MzcjJY?=
 =?utf-8?B?eE5sT0pya3JTcERFNU1OZ3NEYXU2anpKMDZqckliRzNmWUFYMW5HVzh3U29B?=
 =?utf-8?B?RFpiQ1ZuM1QxUWx3amwxVmcvU29uNnN1QWhyY1plbi9DME11T2lWQlJGZndN?=
 =?utf-8?B?K1ZPQURpRVg4MmNXRXkyZ2s5MStmMU9DWGFic0ZYczFjd2RRbGt1M09yTnV6?=
 =?utf-8?B?c3JlWUQzZ0pRWXVZcTJNdjNIYkhPTGlTNjhnYVBLdDFsbFY0cFhHek9zVUhj?=
 =?utf-8?B?NUFKd0hMTmFia2tIT2JqUWJOeWlRa2o5RUxoUEhwNy91ZTRXRklMdTlBeHQ5?=
 =?utf-8?B?WVd6bjV5OGRONm5yQVhVOEkyY0ZucUR0YWQyTVdEYW85Z25YZHU5azVxU2t0?=
 =?utf-8?B?S0lSM3gyc0tsalZCSE1sbDV1SDRtYWc0SGxZOFpyWWI3dCttQnM3UnBkYkNi?=
 =?utf-8?B?ekVaN2ptRzlqU2hSQmdDRDBMT2t3VjBNbHZLTm5MZ0xiamxIL25ycUdPVEha?=
 =?utf-8?B?VnFvekxRb3hKanZaVFlMVFVnTXJ6L0RwYnBMOVN4aXVqQkFpVXlndVpSSXdk?=
 =?utf-8?B?MzZBOWoxY2UwcTVXN3QyNGhQNlNmRkMvc284ZXIzbS8wTXhyZGYrVWpsV1lN?=
 =?utf-8?B?Z3J6Y202WUpBNDZBZ1FJZ2JhdHJad1RScDdXbTRVUXAxQ0pIUENrWXY4eXNG?=
 =?utf-8?B?ODUrV0lPbnpNdGtsdGFLN0N1SjZUenoxNW44MDJ2OVE1aDhiSXlDcmN3MzhM?=
 =?utf-8?B?Y1RkR2VBSi9hTW1ibXZ4V2VHS2dQTDIyL2xMT081MlM1SWZzNURIVVI4OEZE?=
 =?utf-8?B?Uy8rVFNLMysxV1A5OFdOWlJUc0JMbUJsaG5pU2FnOXZFS2N0aGJWZTFzV0Jn?=
 =?utf-8?B?bUcxdVl3Sm5UVjVmUzVTNVZEV2JVMDdpR0tVb3JteVErQ2svVVpseWVGc09x?=
 =?utf-8?B?aHVMYUJmMkJBRGJTb0QzUUg5YXEzRXE0ck85OHBLNDlyb1F6Y2s3b0k2bzBo?=
 =?utf-8?B?akpVVTZ3OWdhVUJSd0pxeWRzQlpZalNQWmZCdVNPU3NzbVhrM0VXVEo4RHJZ?=
 =?utf-8?B?aGJoanF3Y3FoNzA0OGt6VFlpQnk5N3RwNEJwNjlWaG5EZnF0TjlORTJTcDZm?=
 =?utf-8?B?dWdpaUZ2SGl5OWExUFBhcFBWeUV2QXNuajBZOHEzZHhhcWErWE1qRTkvMU1p?=
 =?utf-8?B?TWdIdk55TGN4aU1SV2tROHMxTGxXUnpUNTdxOGRFV29FWFJJbUI5cXkxN3I3?=
 =?utf-8?B?OFZLa29nY1JSbnNMalFETlRlSVMzbnR1UldlZGIyZmQ5Z01DRGs5bnlxa3ZS?=
 =?utf-8?B?cnRvMDg3c2ZCWlNmUWYvcm9ud1FDUWlza1I3bC9MUGc4SUUrNExMcld4cWtZ?=
 =?utf-8?B?RFRPaW5FSzZZSnhoVjVNc2R1Q3pUR0J4SGRETXdOT0w1OUJlV2ZKQ0hsb2ZX?=
 =?utf-8?B?cXhMWDVQOXZsS0xIWTRNcFpnR3pTUi83MDVFQlhadllqZ0hDdlN5R0RxVWNS?=
 =?utf-8?B?eVBZSXFkcm96K2lWRDFxWm0zN3NaaEVIU0VuQ0xtK28ybE5vT2FBcUlnVHRm?=
 =?utf-8?B?ZnI0OGkzbC9jTWJSY1VkaENIZEJ0dnR1dCsyVGFLN3lVTXJwTW5hWFNGR0dM?=
 =?utf-8?B?U0lITjlMMUpzcmxKcWpTbUVuZDMycmc1VHF1ZW5SaXMzMlhaUk5QakIzeHJu?=
 =?utf-8?B?UXdNTG9LTGhJOU0zYTdLRGthZzFmWXN0ck5aeFRRNmlNaHptUUl3Z1hFNmcv?=
 =?utf-8?B?RWZqTU0zUFNmS0tDRmtPOHE3Nm41a3oyUFkwMHBkR210K0NjMVVQWDBSS2cx?=
 =?utf-8?Q?2AA/+KkYubCXwP8+8V4Fdr4rOgMYbk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:07:03.6758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f6237d-6d0c-4ba1-1b79-08dd4bdb90ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

