Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B343BC02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619DA10E1DF;
	Thu, 13 Feb 2025 03:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azmOYW6R";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6B210E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDd92OGF7Wxm1yk8OWK+YzZhVodX/yrb98NTD49XLODUKN+hwXni3/ui6S4G41VrDAnc7zMm552udt+bsymMYMNyap+nONBgRmIp6C3mQojyfgrxvD2NWKCG8o69AQKbrTly5MG7Q2v0iK9GRmwcm1YEGT3xfW2G9ib592Q8laiBuHtApcCFHRW7HMUbn4vGbPm5jZOMm/r5VrwzeX9W6QvmnmbopdIjm9EyzLAH2cQi2MBLu+H4ucRACFlcmlPc0LZSAD8kAl6v1yke522Xtt98iIl1h5CAcNVbzh+6lHxXNe9do+9Z/53CLaSR8qmow9vA4NoPF+sNqm/eFO9pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUJtJ/CsLjnDC4f79V4Ra2zjjMTovdlxhbJHGjPBJsU=;
 b=eeJvnem+8AY652ckCtymEPD55s7sd7BuO/RMzsI7TqSQclKweMMVd+vYdDkMRQDDTVJGIODXYjs2WrxnPhF63TmhfiOTeKDjApP4FI3WVM5zNDRfv7LS2uYz7otd/OsCaklmkZbOdtRRvx/qox4GQNfG0jV0pnxKBGna0osKjd+kXpiAock6GDHAaDNXXlrDCLIkeYrtBq3k8lbiVH/iNa+bZpZZYMF+pU/2VJFcHCTacHKbODSrh3pIHLD/jy47iQjFCFktz8ymhRd7w0WLZInsdqnrYxp0ojj0lTfSJtk6ACa6f+vG3ZFXaWY+KytAq/LsqKOhQx3rOjA2UP/wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUJtJ/CsLjnDC4f79V4Ra2zjjMTovdlxhbJHGjPBJsU=;
 b=azmOYW6RFeOYr9GbunYyVindZym3ElBsIoM5uN9UjP9t28BhrafLpSnZuUDhDE1uhELhhewFH+OKqKuKtjTuGusJl31zv0+x8dcrqtfKdkwntic3qCDpBH0lx07u4iK1/u0RxlBQDQNmZ16Ovps9e+C91Ng7AVwASjYnjr3DX/8=
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 03:01:19 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::4) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 03:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:01:18 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 20:56:16 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
Date: Thu, 13 Feb 2025 08:24:03 +0530
Message-ID: <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 801169f0-1357-4c5b-3552-08dd4bdab02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3lnRVYvUDNoQVZ3U2NPOFRvSi9MV2pONk1KL0VMb3RSK3NmOGZjbmhsbkNU?=
 =?utf-8?B?cURPYnZkYXFxeEVHK1lzVzI5a3pyOEIrOHNFU081T3ZuUmVaT2ZlTExPcERs?=
 =?utf-8?B?aTdJeHRsc2xscTh2djRkK3NCSnYrUmRTT1hBVjRWSVhmYmhQbU9scDJUTTNp?=
 =?utf-8?B?SEVkVksrdC9HODVRM3FMZitxRFhOai9sQ0RIT0FTbmtoVlVUMW9sWUJ2d0xU?=
 =?utf-8?B?M3JhK0Nsa1lhNXB4cXdFZEE2VVFTZDR3d3o3dnhuYXdySW1WWlZ6am9pRE40?=
 =?utf-8?B?R3k2NXBjM293bnJibHptZjYxZEI3QjZ4SDVGSVBobEYvNUhISjlsa0J6UEFH?=
 =?utf-8?B?Mnh6MDNKNk16QlRudjlJQXM2MmZmR0hZSmNNSEZSeGY4ZVJNdS9jd3E4L2JX?=
 =?utf-8?B?NWNLM2twT29ndmxYVEptOGgxTWU5MUdndHNqN3NOWE9RRXBqOE5FeVZVUGFu?=
 =?utf-8?B?Z1JVR2NUWDIyb2dkMkdGTndjQmx3Q2dPRzlqS0g0Nmczelg1TjlrTkxnQ0lZ?=
 =?utf-8?B?d2ZGVUVsQ1pMOFZrWWZ6MHVMRTJlRXAybHU2UW04QXZ6MzdDQVZGNzRtTFE3?=
 =?utf-8?B?amRscVV2aU5kY28xaUNQcDE3QndNSmt5TmdBRjRXbFlpTXZrMFQzSUhPY1JP?=
 =?utf-8?B?T1pPVk0wUEJjWnZ1ekt0MGNKa3dnd0o3d1JxODh3czVsc3BPSnE2dERITE1q?=
 =?utf-8?B?SG5vRitLcWV3dUFZbzIvTnRyRWhVaWZoQitJZkwraEtzNXZaNm1BRzB6TTgv?=
 =?utf-8?B?VGQzT1lTTmNlQk11TW1zNXh3ZWNkQmhmRTFWa2VkU0drRThGdlRiR21neElU?=
 =?utf-8?B?WTBtQUZQVDJiRithTWtIS3h6cGtpL3BuNEs1Ky90amtrVE1jS1pxZGtYYm94?=
 =?utf-8?B?NEpPSUQ0TVREVzI4b2VxUnlxMWlzRURDODFRVEkzSmxhMlQ3cUtJL3VJRW9L?=
 =?utf-8?B?QmQrV1ZhWkF0ZEE4N0Y1ZWxoNE9DdWhCOUZlUUNVRDZMMDZSaVF6bDY3NVJO?=
 =?utf-8?B?RnI1c3g4SElZVFEyUklOeGxYWTkrNmduUmI3K2JXVnIyVTZHQ3FIeUIwTmZ1?=
 =?utf-8?B?MXNXTEdJUDdFR1NFZUI4aUp0MnNJNEh6d3ZJZWFJNTJZNFJkYmdlQ0QvUXlq?=
 =?utf-8?B?SnVRNnFnTUZoTU1TdDhBRExMVmg1d0lIWVV1SjdxVkhQTGJhNWlmaGdtMzB1?=
 =?utf-8?B?Mzlmc2o4MmpPakdUZVJINGtRc3FrNGc0R2dsdWhxRGx3U2lMS0pmMmxlUlhh?=
 =?utf-8?B?dDJ1c1krY3AreWlaeDgrZkNzYXBJMjBxdmlaZTF1dHV0bmRITjlHaWpvdTJJ?=
 =?utf-8?B?cDdGZkxiQmRhbDNTdnVyS3R3Q3hLUFdvbG1jeExBa0JsMVEwME9NTU5tcE1R?=
 =?utf-8?B?WS9VUEt5bHE3MGJPSm81S3BtR2J5TEo1cFlrQ05aVFN1eDFRV1RzVkpWb3Ju?=
 =?utf-8?B?L1IxQ1VmOTBLU2Z5RnFrRXUwbEF3MnF5VnFzWVhTaER3UXI1MEpocWMvb2JY?=
 =?utf-8?B?b0pqSDlwVG5BQlF2ZVdVanVneUg5UlhuTW1qUlFTM3J1QmJjRmN2VU5CRmFw?=
 =?utf-8?B?WDRnZ1JDZ3J1ZkIyNjNTbFp6K3VpUnlyeTV3VVJPUkI5V0JKckYrREpLM2dZ?=
 =?utf-8?B?d1hEUTZVeDRyL3p3aW1uTGRQcU9RRGdRNCtVR3B4WllVOTlxU0l1Z2JQMGE0?=
 =?utf-8?B?UlRoZ2JZQlNwQ2laRFlFYmtlMzVvdmc3dENzQmFCRzBhejZEZlhxZUhKTnBK?=
 =?utf-8?B?bjVBYWx6Wk5xU0JDUklvZFlNS0QrTzRsSE93ZUNvRW5jS3QrL2lMdmE3dm9P?=
 =?utf-8?B?SnNIVVVwc0VmQVBnUUZONlY4Mml4MVNDZEJLVzYrWnBxQXhpM3dhYW94RFk0?=
 =?utf-8?B?RjFuTWFFTFRQUkN0aEI4emJ6aEFYL21xM0wzVDQ1bXBtK0Y0dCtWdGg0Rm04?=
 =?utf-8?B?QlI0WStwNS9wRjFmblJlYmZRQ1paQXEyaGxnMWJXeUJqYmM3aElWWEZhblBL?=
 =?utf-8?Q?poUMGOX/Km+Qq/kaXc1NkQwuJTZX+A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:01:18.5466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801169f0-1357-4c5b-3552-08dd4bdab02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

