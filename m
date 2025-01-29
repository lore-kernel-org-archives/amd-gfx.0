Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC079C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F4B10E760;
	Wed, 29 Jan 2025 08:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1iufYmK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1439410E760
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUsawoaWX0xAEp1Rx+1brSRyIrWRSIr0PH9KIX87wadxDV3j6TNWNO2YlZBL83GT7xrNXx/Cx2yWpM+8+xxVI3WI8ew84VUsBBIEHIPh9YGUakWdNuQt7+H5PIL7RJyiq3VOOSvnKQ/M/MUwnkFWChUAce8zts7CZKF8CBon1oqjcf1rh3Mf3ElnvuR71GAecVwz/V8LouBJv6RZqHlkQHSlaF4n6Ot6eC+9k5189kSK559QN/xL7LIPPBr5hSx3vwj6jn9NyUToP9BRQIpQnXqiVH1Mse8uyByC3tOQ7Mvcr1bSsyaXzstpPerLqyTwyum0rNCKR2PJz6TFhWRPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzuzREBQaxUi4pGvqSGOlQqKCVvwO7Q9VKaTCAV3L/8=;
 b=jDe7ffYG8J+0Ux9BDmC1TBzVBl2fijy93whvuhLz1f/2UwCqo19GpE4cVVXJTQ4LLwFR1QwsCWUNP4tlltqllEisG6KTKwRB5WWJKRNu1xjvjY5bdz6Bq15Z8xU6vLk/jI8rOWwerK6uxs9jBCXf4ppkta0woYGCsuPAAAXyRo1wrUpxBEy0DafAtxsfbx3LjmV5HBDao6rYH19xrQySAkvtOvSw1kLJt1agZcTlTDySgW9HevnxBLnCzS8hfIeLr3vucvKF2A1ZCfLpVpGCmfqX5D9iCd+hTJ2Hxmx9+ibQRiB8EGTiUfU46AJG6pjdSdM6Sg8MUylFf5AkAG/5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzuzREBQaxUi4pGvqSGOlQqKCVvwO7Q9VKaTCAV3L/8=;
 b=U1iufYmKEs3tnaPCSQtNIGfNJG9zHWkz3VJBxY/6R8ns/gZeqOZWPEnvvL0kMsU2LkXNGRJvW6CIE7NJMaUWKqAGMzIMnpsoZsUkNXvBlkCY3KYDcqvzxoxbUJW1eNrJ5IqoGFcVn4rqblD3gNW4GTQWQrwXVrtRoOJ29t78B20=
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Wed, 29 Jan 2025 08:47:14 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::ba) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 29 Jan 2025 08:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:47:13 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:47:11 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 1/9] drm/amdgpu: Add a func for core specific reg offset
Date: Wed, 29 Jan 2025 14:16:35 +0530
Message-ID: <20250129084643.507727-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 68819e1c-3f38-497f-9d15-08dd40418724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGpiWElNbStleVdoS05EU0FGUEVoSm94enlIZU5Lb2FNWTJGMk9XcFZucGZN?=
 =?utf-8?B?TlVydXR1ODJmOEtOakNqRTlrcTJRdHNOeWxYc2dvckY1eHg1VHB5YU1ZcW0r?=
 =?utf-8?B?WTNWQ0MzYkROcjZ6WVFZVCtBdjJzR3MyMW9uMlJkNTAvaTl0eXRJTCttbm12?=
 =?utf-8?B?cjg2SlNEd1plREovV0pOZGF1aWhCTHRsdDZ6em5Sc1RickxVTUJqbWdQR2Er?=
 =?utf-8?B?UEd5djB2UGhZMjB0OC9TMHVIVlc4TVJBQUtVYVlTR3FnbDJOcTdTMXlFekZQ?=
 =?utf-8?B?U3lZZzVIOGNWRVFJRXFWNktmL0I0ZWkvUFBNWmsvZUc1Yzk0dmF2UnQzazJq?=
 =?utf-8?B?ejhrZGtiUkMyeGdmV0UxM3lING9VU29naWo5ZjhHWXprVngxb1pkdDIvYTNE?=
 =?utf-8?B?Yis2djVSVFhJS3M2SnhkSGU1NzlLUHltRmNqaTRMTnFGVmtJWTVzUktCTThz?=
 =?utf-8?B?V0hnQ294R2FVSUZOd3htMXBxOWZTcDNDYVFUVUE0eDJuMWEwTk1SdTZ6VWJu?=
 =?utf-8?B?L3hGSFkwWU43TEV1RWIwOVpaQmFXZjlkVzFEQnp6ZWpGeGxxYjNGSm11ZXFt?=
 =?utf-8?B?L2I0Mmc2UlQ2b3ZHdVBQU0xHMnZKS29ZSFoxSUVsb2tSWU50V1FXSnQxcmlu?=
 =?utf-8?B?KzBySGY0SU1ZekJGaVVNemNTMVUzS0wvL3lxR2RKanpsRWNyWXZOUDBsc0t1?=
 =?utf-8?B?Nkp6NGJFNzF0cHVNSjB3YTExV05qZFhzblVERFVySHVOUVhZNFBFd3BEcDlL?=
 =?utf-8?B?b01xVHZHQU5LSXBiRHZkUklUSlljbGIrSy90TDFGalpZRXhmOUI4ZHZ1ZXlG?=
 =?utf-8?B?Z1JYSUVIYUNHNGdldXhhNUxLU0lxY0NGRjFvenZYUlhBbWZNSDh4a0UwYVJ4?=
 =?utf-8?B?dmZOMGtkSzlIcnNya1ppRVlqRzJjZ0tJR29SdnFEUlEvSWtvb01LdGdNWlkz?=
 =?utf-8?B?eTJnSUhQUng0WGNTUVJqajhoUXhiTDh5SlVOaGlkaStqMk5QWlJrR1ZsUmdX?=
 =?utf-8?B?UjRSbURPVS9DNWh1cm5SSlFoZGxYeDRGNmdVL0tQYkdteEwyZHM1VmU4R1Zj?=
 =?utf-8?B?dDJvODVkOEtXZlFoVmZVMk4xUDlrT1VubDByTG81bHdmRDV2aE5JN3hZUVZt?=
 =?utf-8?B?OFg5QUpWRGlEV1ducDc1VHBycFNiei9sNWJ2bWxRR1RuTVVKc2JJVmpramY5?=
 =?utf-8?B?TnZRYmZ0MHhOL3g4M1RKcVpDdGhHdmJESUFTNVpHUlVJYUpLVTFrSDNNVk9O?=
 =?utf-8?B?cWI4dTRqK05qMzhhR0J5QkZ4c1l4Ri8zaG5pR2x2R0oxWHNZRlQ0VGg2UWV5?=
 =?utf-8?B?TXJTRHAybVFwdVk3UnR5ZzBUZHZ6bUdBS29BbHBwQWdMbXN2d2x2L0VTZlRQ?=
 =?utf-8?B?L3NYVkhteDdCWWRURm9ZRHdONStydCs4S0dlWk9LbXMrZXRnNDI0TjhNQUxl?=
 =?utf-8?B?ZjAyUngrRXNUL1RZQ0gzdmpyRkIrM2xpQlRxT2N5NHdjcWdQWkhMWmZUMVFS?=
 =?utf-8?B?VU93c2Y0UEV4Mktaa01EVm5RL0M4VkQxcjZKdlBsRFlsRHkvdjRQRDNYYmdE?=
 =?utf-8?B?OUI4NUUxQ2owaGFycVpvQnFaYTk0YXVSNDlyby9FTGlnNFVYZ0dJYkdQUldk?=
 =?utf-8?B?MGw5QWtpNmFMRkY0d0R3Q1laek1NUzRoNUhIYkpEK29ueVZlOTZnTGk5RE1r?=
 =?utf-8?B?SmlPK0ZaNDNzeCs2WmlrakdMYkFZNklxUngzUFY1Ly95d2U5dVhLeTU4cloy?=
 =?utf-8?B?UFE5Y0s0SU5CUEZ4ZXA4cE9Oa0I3Y0krVmZHNXNFOFl2aHdVYUlZWlZGc2ZD?=
 =?utf-8?B?ZUwxSU1FL1FZSXp4SU85LytJZzNRY2ZaSUgvZnBWbFh2TnBSNW9JTkxrM3ZX?=
 =?utf-8?B?V3ZLbEx6L2FNM0w1UlRucXZNMDZxTUNpcC9rNEt2TWZCUFkxK1dEdHFwMzBl?=
 =?utf-8?B?TTArYUJsZml0dnM0N3J2Tk54eGw0ZkYzRXdVL3R2NlFianR0eU9lK1JoZU16?=
 =?utf-8?Q?Knpl6c/dNRUaC4odEoT3Eho6cDDbnk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:47:13.9916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68819e1c-3f38-497f-9d15-08dd40418724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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

Add an inline function to calculate core specific register offsets for
JPEG v4.0.3 and reuse it, makes code more readable and easier to align.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 54 +++++++++++-------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 9459e8cc7413..bc21f12daea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -64,6 +64,14 @@ static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
 }
 
+static inline int jpeg_v4_0_3_core_reg_offset(u32 pipe)
+{
+	if (pipe)
+		return ((0x40 * pipe) - 0xc80);
+	else
+		return 0;
+}
+
 /**
  * jpeg_v4_0_3_early_init - set function pointers
  *
@@ -143,10 +151,8 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->jpeg.internal.jpeg_pitch[j] =
 				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
 			adev->jpeg.inst[i].external.jpeg_pitch[j] =
-				SOC15_REG_OFFSET1(
-					JPEG, jpeg_inst,
-					regUVD_JRBC0_UVD_JRBC_SCRATCH0,
-					(j ? (0x40 * j - 0xc80) : 0));
+				SOC15_REG_OFFSET1(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
+						  jpeg_v4_0_3_core_reg_offset(j));
 		}
 	}
 
@@ -521,7 +527,7 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
+			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
 
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 
@@ -616,9 +622,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15_OFFSET(
-		JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
-		ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 /**
@@ -634,11 +639,9 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell)
 		return adev->wb.wb[ring->wptr_offs];
-	else
-		return RREG32_SOC15_OFFSET(
-			JPEG, GET_INST(JPEG, ring->me),
-			regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
@@ -663,10 +666,8 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
-				    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-				    (ring->pipe ? (0x40 * ring->pipe - 0xc80) :
-						  0),
+		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				    jpeg_v4_0_3_core_reg_offset(ring->pipe),
 				    lower_32_bits(ring->wptr));
 	}
 }
@@ -919,13 +920,9 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= ((RREG32_SOC15_OFFSET(
-					 JPEG, GET_INST(JPEG, i),
-					 regUVD_JRBC0_UVD_JRBC_STATUS,
-					 reg_offset) &
-				 UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+			ret &= ((RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j)) &
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 		}
 	}
@@ -941,13 +938,10 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= SOC15_WAIT_ON_RREG_OFFSET(
-				JPEG, GET_INST(JPEG, i),
-				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
+			ret &= (SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j),
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
 		}
 	}
 	return ret;
-- 
2.25.1

