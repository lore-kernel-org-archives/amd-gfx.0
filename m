Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E101D3B7F8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D27C10E499;
	Mon,  8 Dec 2025 17:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6wyalPh";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6C910E499
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX6HmT0T8txTY5NojuoZGMbgDvUS1rwJDLm7Z0iyl3aGCE18GBtYQZqmuzsd/RaU5n094GPzzqYQQavVImGPIRP8nupaW8LhtwxCEOtCgB2Xa9RnbXYzf4lQ67KhTTq4ALPmDpQD/u7zJhNmxF83Lq/eh2/9dga0/HVL5HXYb/pnF3rntE2xtBXBbeSGiiEhItwtV005NXcL9zst9MOASl9rwm/ACaxObvZ3PrQuCGzLVMIkLQkQbMz23WBt8+shX90sUjF8rLTCV+zumI7HSvpy7FNtosFS3Sh7HEV1MqrqkqgANTDgnRQbuwrJflZT3dp688Kox01Ho3fJw3KkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5Ah85us1PLhtrAr61x0rnSpRtRSywNAFLuI/r3vKn8=;
 b=KxaPoNV3XWYZxyDZG5z869UZs42ZZt6+m7fbY9B+j8xl7n2Qn8PW+xbUYh77VKxedolHjVQIPkvdct+IBZ4vp4Q8myU/Jo5S+iZbUG4yZB3ehkfDSyTWCRBJNx7jTJEZin3WURZ+K/XcGwWNSxTli+9XA+76Mz72T28broK6u71Dxv/Ric8gKhoGxCDZCReJH/gnimaH0rsHm+gjIuVDIpyshWZNseIBtZ+yQFF5BDgVXcznpyQnvgPWl3vZZ5Ym0TfLjDkyiFhwplqcDglz4rDnw66vBCUfNiQNXn/pIluymRJYiU8KxP9pAHSGbLscX2RoaWtgHa0sb6/wcMn3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5Ah85us1PLhtrAr61x0rnSpRtRSywNAFLuI/r3vKn8=;
 b=i6wyalPhWgJt+XbP4lfax9IyuzNzIc9aJ3UZ4HYTWjUG+KZl1ox2YO5HG2aF4fTQpTDstrH+9NmNOOkQQzXK6tsrtciVHAKtDNJDkF2Gh+hMcIlmOuk+a3UmOx1m53v1oDlSXtV/UJrnChT3N1loqR4BWk8YCiW8kUjwoH/O3ms=
Received: from SJ0PR13CA0222.namprd13.prod.outlook.com (2603:10b6:a03:2c1::17)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:48 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::16) by SJ0PR13CA0222.outlook.office365.com
 (2603:10b6:a03:2c1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Mon, 8
 Dec 2025 17:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:47 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: support rlc autoload for muti-xcc
Date: Mon, 8 Dec 2025 12:17:08 -0500
Message-ID: <20251208171720.153355-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f4d52c-c94f-4ec1-6a28-08de367db597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X28HkF8AKi1d7y0RoMmBeeN+dz5bT7BVX6M5mdDeaTOTKYsg15KzH4Xw71ha?=
 =?us-ascii?Q?ynDziAmMmNIWxdF1RFUx+oukv7WDHOqwq4jKDu51+Nz3J/75E1FuqXNvc8au?=
 =?us-ascii?Q?IkoQIuQJzPW8XXt0ZiUkxxsmmBD1IiCctO/XGcRGVqn3Rz/Vksbez6clE18P?=
 =?us-ascii?Q?yLHau0/sghAtV7bQiyNQ7HFKi83GjtGPRIQ9j/JWJ4hVLW0LBbPnW3dxyseU?=
 =?us-ascii?Q?Th5SRaqNX95B/j8Nicx4R0itvy1WGtsGkv4A/xkuKXwM6YYRasoq2Ac63UxC?=
 =?us-ascii?Q?tVkqcDlycwoiudcDLlw6QZau9alhWto/cJulS81jH/nzl4XrPJdVkXHA6c4J?=
 =?us-ascii?Q?D0Jj7Jl12ic+t0K6goox4wEM2U4TdndTW5hcudE6LaIrzTO8R7op5l0nI8B8?=
 =?us-ascii?Q?5PtbVX0H8aqXcAX0OxkbY7R8Asjru4eNKYElFbXo/Ls2/PknmBvUmoYyqdQs?=
 =?us-ascii?Q?PylZR/f/2kZKVa5I/ssV0+PuM58NcQqXhx2PwcI72GXuxuy0pi8n05dZbGpR?=
 =?us-ascii?Q?+qgGF8YrlmrlGmbMi4B5SXF2T+SYezY7U2w+hYj+sK2xRiHZsQsmTqKUvcRq?=
 =?us-ascii?Q?GXgeWluGfIUtQZJ6z4qZMEH6oFF7F8FIXuIXqAZvxoMKq/MPYwx9FoBxGVLM?=
 =?us-ascii?Q?munHywz9Cdp9e89is34R/uteUiNIBi0bN+E+cxH11hQxI4JivcnqvwP+8jxM?=
 =?us-ascii?Q?3lHAtzyciDjGkNCfqf2vdx9tGgzCe/mX4VhR3YrpgrN8ZwHqCdzBYFApNpEH?=
 =?us-ascii?Q?U927FQ6E0RzVmq0BaoxQkMwu7ckET2nbyQ0mqtcL8n70OHRJwTkEDa0RxTXa?=
 =?us-ascii?Q?dDvdTu1VaoDuvj1j7ykco5IOsCkUxPGxfwMHqf+M1qVnixcIS68V5Ti1LPVP?=
 =?us-ascii?Q?QS7FGCaGCSqNVzes4+6tbHOFV2VwnaT6gYXT3lFdqgACk4qEXPbyLO9QZ9f3?=
 =?us-ascii?Q?QrMgtcqlTyx1hKdbS6xDm0q26UF/P3FVYgeOsGGYNmwMVb59A1FHe3vvIkjY?=
 =?us-ascii?Q?PwJ5ubOlFM4VdomRkByKeFhhR6PojK2WFC7H3brq14DZNKLRTcKZDRZdwdq3?=
 =?us-ascii?Q?MicvXaYU9q5JKp9wVyl016cfROq8WhF8pXikUeDH8vhUpcIambawwafz9+10?=
 =?us-ascii?Q?rw+gvq5LQJpBcnTEpWep2+iavkWc/cx6wTSU23o5oSOw1puOdUZL+0AqcKHr?=
 =?us-ascii?Q?3+bin+p6EyItfyTzxrB0nVuHls2cVtVYoT8gDbs665GxhOudkOIExLZ9a0VT?=
 =?us-ascii?Q?apqsoJNDKfiIbitrssokK7/kiVhEZuwnKwz7kC9mVJGY2NMXKHkK2yhgEBpu?=
 =?us-ascii?Q?qq2pwnNjVtJnIqv/+wz+PSX2cbAF8IxqiSjcseJrmKGXuZiaA1sGD+S9/ykg?=
 =?us-ascii?Q?7XIJj7JhKwjNHjRXQC6nS5+Dni0fDUO/Q7YW/da45WE1H2RHkwuo/4B5fZEr?=
 =?us-ascii?Q?ZUlzl5cbD17Bn4HnV4ijp5dvPCHv8Twqjv7LZvE8BdaA7kTMbIIbMQGFE44e?=
 =?us-ascii?Q?65R6rynuPPWo2FqogTRPfPXdyxfQ0Sa1vbqGJAJVhTHym2zZ/Qh8BhDXBEee?=
 =?us-ascii?Q?U7HZclYooli1wIKA/r4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:47.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f4d52c-c94f-4ec1-6a28-08de367db597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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

From: Likun Gao <Likun.Gao@amd.com>

Support rlc autload for muti-xcc on gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 57 +++++++++++++++++---------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 285bc37846ded..d761150410083 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1059,6 +1059,7 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	uint32_t rlc_g_offset, rlc_g_size;
 	uint64_t gpu_addr;
 	uint32_t data;
+	int i, num_xcc;
 
 	/* RLC autoload sequence 2: copy ucode */
 	gfx_v12_1_rlc_backdoor_autoload_copy_sdma_ucode(adev);
@@ -1070,13 +1071,18 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	rlc_g_size = rlc_autoload_info[SOC24_FIRMWARE_ID_RLC_G_UCODE].size;
 	gpu_addr = adev->gfx.rlc.rlc_autoload_gpu_addr + rlc_g_offset - adev->gmc.vram_start;
 
-	WREG32_SOC15(GC, GET_INST(GC, 0),
-		     regGFX_IMU_RLC_BOOTLOADER_ADDR_HI, upper_32_bits(gpu_addr));
-	WREG32_SOC15(GC, GET_INST(GC, 0),
-		     regGFX_IMU_RLC_BOOTLOADER_ADDR_LO, lower_32_bits(gpu_addr));
-
-	WREG32_SOC15(GC, GET_INST(GC, 0),
-		     regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGFX_IMU_RLC_BOOTLOADER_ADDR_HI,
+			     upper_32_bits(gpu_addr));
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGFX_IMU_RLC_BOOTLOADER_ADDR_LO,
+			     lower_32_bits(gpu_addr));
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGFX_IMU_RLC_BOOTLOADER_SIZE,
+			     rlc_g_size);
+	}
 
 	if (adev->gfx.imu.funcs) {
 		/* RLC autoload sequence 3: load IMU fw */
@@ -1085,11 +1091,13 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	}
 
 	/* unhalt rlc to start autoload */
-	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE);
-	data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
-	data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
-	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE, data);
-	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
+	for (i = 0; i < num_xcc; i++) {
+		data = RREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_THREAD_ENABLE);
+		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
+		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
+		WREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_THREAD_ENABLE, data);
+		WREG32_SOC15(GC, GET_INST(GC, i), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
+	}
 
 	return 0;
 }
@@ -1793,15 +1801,16 @@ static void gfx_v12_1_xcc_set_mec_ucode_start_addr(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
+static int gfx_v12_1_xcc_wait_for_rlc_autoload_complete(struct amdgpu_device *adev,
+							int xcc_id)
 {
 	uint32_t cp_status;
 	uint32_t bootload_status;
-	int i, xcc_id;
+	int i;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		cp_status = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_STAT);
-		bootload_status = RREG32_SOC15(GC, GET_INST(GC, 0),
+		cp_status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_STAT);
+		bootload_status = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
 					       regRLC_RLCS_BOOTLOAD_STATUS);
 
 		if ((cp_status == 0) &&
@@ -1815,18 +1824,28 @@ static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "rlc autoload: gc ucode autoload timeout\n");
+		dev_err(adev->dev,
+			"rlc autoload: xcc%d gc ucode autoload timeout\n", xcc_id);
 		return -ETIMEDOUT;
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
-		for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++)
-			gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
+		gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
 	}
 
 	return 0;
 }
 
+static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
+{
+	int xcc_id;
+
+	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++)
+		gfx_v12_1_xcc_wait_for_rlc_autoload_complete(adev, xcc_id);
+
+	return 0;
+}
+
 static void gfx_v12_1_xcc_cp_compute_enable(struct amdgpu_device *adev,
 					    bool enable, int xcc_id)
 {
-- 
2.51.1

