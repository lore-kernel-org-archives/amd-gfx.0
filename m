Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F718C02182
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 17:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E1B10E348;
	Thu, 23 Jan 2025 17:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcbWHB3x";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1452110E348
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 17:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQE3awz38HZPAXDOWra+op4Yys1z81cgvtWfF4mQtipmjN4KOj7O53jYZ1rQJh3AesqSEYANVMCSzRIEV6STVFz+DeswEwJEo0O5Exsh+b36QZwV5tViBeT8+dUwOv9p066jSjnizc16GLPMmIDrzjv5anefjb2RCn2miSscr2O8WshlHLs19E1YLnwVdYzjFBUrZ1ehcI3TrDobZPRc/jTK7BzDUx3RM5GzxhYKf5hGZ+fAKPkhjuEHaH1mZ2ayu8Nx2fV9XBitNjzxudBJlPR8UX/1dtfltgRYd3CqsICWJepjCRpxhd7WBioDuye+7ZIsnjpF4m29CEOTpkVnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX+rdYUVK/pW/3sFjnScgokxHvE2QzPskDxjzrkz3mk=;
 b=vZTwPlzkn/KfHIc5CZMGSY+sdXB4iQgqfcQlB0FMxFHgZ/gPYjGgYmLGoKtYdtMgchx2DpRP0vAxQajLjwwljTl0XDya9yZ10pXU2kZ2IaoMYn9WZx3Gun+pUva/g4YRIhxjqJCqiHWjtYebZzgPF/NwYIOVjWIdK/UlmDvCmOyrVtqFHb8YvFF+uuYit6S2sFfZ7bRNCT0wbw+0HkfpztC1YJ5OkcgWcfhX1cPaXtQ9L26RinmXEquqa478RBNaQgEoH1rC1KnZmgS3J2ZazdCUjCsln1oib9/PmMEk/6raL+/CYo29Vj0EXxsEdkXHnSS+Pi16YJXJlQ6B2M05mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX+rdYUVK/pW/3sFjnScgokxHvE2QzPskDxjzrkz3mk=;
 b=KcbWHB3xWTOoIuokyafRW2sD1tJd52oLbkOeCYIhIXUso6M1JA/sqrOd8JpLiDLLTY3xnYZH0H/n/rUKeV4/3AMkxBA30/kW/WBBIlDMoDCsJKVlq71bj+LsIb9Ka14otD2c4pc28KT0EvENobDleSued5n5Gsgl3xOuRtwlPQM=
Received: from PH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:5::20)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 17:47:05 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::eb) by PH0PR07CA0015.outlook.office365.com
 (2603:10b6:510:5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 17:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 17:47:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 Jan 2025 11:47:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10
Date: Thu, 23 Jan 2025 23:16:49 +0530
Message-ID: <20250123174649.2882048-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a97079-f5ca-42fb-4b96-08dd3bd5f2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFk4V2pWSnNDT0FOUHJGa05udEp2RnpuNVROYnBtczhhVm9nYmEycjl1Yk5W?=
 =?utf-8?B?M1lsUW95c0F4TUpXdzZTRHJzcUwxcmlRcEt0blNEcUlFVXFzWkxFV0pwUHgx?=
 =?utf-8?B?VFp0Um5Sb3pWekZOeWVuRFlhV3B3aXVid1FjaXMzVkpjRWdtQ0p5SlFXUTd6?=
 =?utf-8?B?MkpWTFhpQ013QXhPbUs0RjFYWG8xQ2JrcVJnNDFoVkRJVURiYlVjMEkwRkdY?=
 =?utf-8?B?NnQ0NlpiRHh1WUpITTdKMThHV0tTWVcxZHNjRnhNQjd0UkZET25kZXVzRDk2?=
 =?utf-8?B?WC9JbXYyMFRBbVF5emdUbk1lMXdHc0FyYTFCMGtaaTk5N3VFbkwxY1F3Z3Z2?=
 =?utf-8?B?WE13WnRDWER0SU52QmtFVlZmemk2LzRVc21PUGV6QTBoZjNpdVNLQ2hLbjVN?=
 =?utf-8?B?UWlCUnZxcThvUDJ6LzRLQUw3WVZJNmxoVitRMFN3OFJDMTdRYnI0dUpsZ0c1?=
 =?utf-8?B?bGZMbHErblRxODdPRzU2TVQ5bzd5ZVdKdE4wSjlNbldIRVZ5RXlaTUFNNXNK?=
 =?utf-8?B?TnRNTWNzK2ZkSEhHRkwwYnBVSC9uRDJ2OU9DNmVkWkRNR2wwYldXYTg5cTBp?=
 =?utf-8?B?ekJQR1Jlamo4d25oS2FaSEZCSmFRT3d5blBTcTBvdFdRS2IvbHpzalc3REcv?=
 =?utf-8?B?ZU1kcTRram5GSlhzcDU1RTRWK3pzYTVHVkppSEJ3dkMrY0s1V3JsOTJXa3lL?=
 =?utf-8?B?TEQ4bDJsWlVVOXV3WVVuRDhta2cva2xZcXZ2WTNMSjFkY1BwNDFLQWdkK2pK?=
 =?utf-8?B?R2ZXZmZvODVWQVdNd0dqSStqTm1zM3N3SmpxWlhJU2RWL0NTM2JiNW1GRU9o?=
 =?utf-8?B?SitZSGdPeUVhS3NIYzdWTlNZUzJONW03TG8zTkwrdTd6bGF3Yk9NUHl1bkhv?=
 =?utf-8?B?aXVLalA2Um1Yd0ZzbkN1dG91VGsvUnVVMWYybWRSQ3JWdmV2YjZlZmM3V2Qw?=
 =?utf-8?B?UGhsNU9hWE1hZHdrM3oxL2VuMFZmRWo2MVYrZE5ab3dFL1JEOENxQ21DaThN?=
 =?utf-8?B?SlhXVnFIZm9tZWwzY1ZteEtsS3VWNU1kZCtZaU0vY0hVSGs4dTY5L3UxUWl0?=
 =?utf-8?B?bDhvUkd1SmY4TFZKcTEwSGpYMUdwc1lrNGNRL09HL1dCLzB4TDl2U2NjZGd3?=
 =?utf-8?B?M3QxZ1d6d1FhZDdvMytmajg2MExIQ1V5cWpWaWdZMW50d3FQbnZ5RmQvMFZx?=
 =?utf-8?B?blpHQzdPTnBOcnZtQzBreDlUc2haS29FZUlFOUdvYVBZd3p6cjFvTXlVSFZV?=
 =?utf-8?B?ZlQvc0lXOEcyY2lFMGxKU0FWZXhRUGRuNDFBTHM1MlMyQ2M5NGZjOWJlNWpY?=
 =?utf-8?B?TjkzS0hWU2dldHlZTWltbFNrWWFmZWk4OHFwNHhHOEFmRzg0ZjBoaW9zQ3RV?=
 =?utf-8?B?TmlzQ2o2d3MxdVlHRWs2U1VDaVA1bDdWb28yZktUUUhQenZTL1VXUEt3L3BS?=
 =?utf-8?B?cDZCT3RldDdVYm9YTVVpT3lMZ3c5MTQyZjJuVzFZUTZ2bnF2LzA5RXh4R0JD?=
 =?utf-8?B?dHN0SlRGUFdtVjFjQnVtQldheXpWT0ZEY2xRRXVZd1QxQ3hpVmh2NGd4bzRT?=
 =?utf-8?B?WHRaK3hDbWNXV0p0YWpnMWZDdkpLNUZmRmtWRHN5dzJYZWZxU0hPSTVXd0dP?=
 =?utf-8?B?UlBhbHVFVjFYaENqeFg4RkI4TXlhczFqQ0crWW40OTZob0k5SXRiS2pwVFJR?=
 =?utf-8?B?YXQvTmhTMDFsc2s4OWRmejBmTnNEQTIvSm44ZVdxeTlLWUhUU3IzZDJJZmtw?=
 =?utf-8?B?N3ZZcEZad0xHMEJFMkp1N0QxTHhWb011SUV6cHFhUGpyTTl2cFVpQytxcUR0?=
 =?utf-8?B?bmtZeWxlb3h0emM1U3dKcjIveW1mVVhYRi9FTjlOTDkrOW5XQVZRQzFFS2dV?=
 =?utf-8?B?aE5lUEJXdlBHMTBnM2JiOUNLNy9LbmtYSGg1SE9ybTVKYWIzUHlwMU5KMTlM?=
 =?utf-8?B?SHRLZ0N6L0crWmhTMUdzV1AvNTY2R2NuVmVzdEUrUjdvRFhmNlRRbndabmFo?=
 =?utf-8?Q?N3s6LQz1fG7lscxu9u2tAkU4Zcxu88=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:47:04.4888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a97079-f5ca-42fb-4b96-08dd3bd5f2f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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

This commit adds the cleaner shader microcode for GFX10.1.0 GPUs. The
cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs).

Clearing these resources is important for ensuring data isolation
between different workloads running on the GPU. Without the cleaner
shader, residual data from a previous workload could potentially be
accessed by a subsequent workload, leading to data leaks and incorrect
computation results.

The cleaner shader microcode is represented as an array of 32-bit words
(`gfx_10_1_0_cleaner_shader_hex`). This array is the binary
representation of the cleaner shader code, which is written in a
low-level GPU instruction set.

When the cleaner shader feature is enabled, the AMDGPU driver loads this
array into a specific location in the GPU memory. The GPU then reads
this memory location to fetch and execute the cleaner shader
instructions.

The cleaner shader is executed automatically by the GPU at the end of
each workload, before the next workload starts. This ensures that all
GPU resources are in a clean state before the start of each workload.

This addition is part of the cleaner shader feature implementation. The
cleaner shader feature helps resource utilization by cleaning up GPU
resources after they are used. It also enhances security and reliability
by preventing data leaks between workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  14 ++
 .../drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h |  35 +++++
 .../amdgpu/gfx_v10_1_10_cleaner_shader.asm    | 126 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4b5e65affb81..1878c83ff7e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4794,6 +4794,20 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 1, 10):
+		adev->gfx.cleaner_shader_ptr = gfx_10_1_10_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_1_10_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 101 &&
+		    adev->gfx.pfp_fw_version  >= 158 &&
+		    adev->gfx.mec_fw_version >= 152) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
index 663c2572d440..5255378af53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -21,6 +21,41 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/* Define the cleaner shader gfx_10_1_10 */
+static const u32 gfx_10_1_10_cleaner_shader_hex[] = {
+	0xb0804004, 0xbf8a0000,
+	0xbf068100, 0xbf840023,
+	0xbe8203b8, 0xbefc0380,
+	0x7e008480, 0x7e028480,
+	0x7e048480, 0x7e068480,
+	0x7e088480, 0x7e0a8480,
+	0x7e0c8480, 0x7e0e8480,
+	0xbefc0302, 0x80828802,
+	0xbf84fff5, 0xbe8203ff,
+	0x80000000, 0x87020102,
+	0xbf840012, 0xbefe03c1,
+	0xbeff03c1, 0xd7650001,
+	0x0001007f, 0xd7660001,
+	0x0002027e, 0x16020288,
+	0xbe8203bf, 0xbefc03c1,
+	0xd9382000, 0x00020201,
+	0xd9386040, 0x00040401,
+	0xd70f6a01, 0x000202ff,
+	0x00000400, 0x80828102,
+	0xbf84fff7, 0xbefc03ff,
+	0x00000068, 0xbe803080,
+	0xbe813080, 0xbe823080,
+	0xbe833080, 0x80fc847c,
+	0xbf84fffa, 0xbeea0480,
+	0xbeec0480, 0xbeee0480,
+	0xbef00480, 0xbef20480,
+	0xbef40480, 0xbef60480,
+	0xbef80480, 0xbefa0480,
+	0xbf810000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
+
 /* Define the cleaner shader gfx_10_3_0 */
 static const u32 gfx_10_3_0_cleaner_shader_hex[] = {
 	0xb0804004, 0xbf8a0000,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
new file mode 100644
index 000000000000..9ba3359253c9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 256 Dwords cleaner shader.
+
+// GFX10.1 : Clear SGPRs, VGPRs and LDS
+//   Launch 32 waves per CU (16 per SIMD) as a workgroup (threadgroup) to fill every wave slot
+//   Waves are "wave32" and have 64 VGPRs each, which uses all 1024 VGPRs per SIMD
+//   Waves are launched in "CU" mode, and the workgroup shares 64KB of LDS (half of the WGP's LDS)
+//      It takes 2 workgroups to use all of LDS: one on each CU of the WGP
+//   Each wave clears SGPRs 0 - 107
+//   Each wave clears VGPRs 0 - 63
+//   The first wave of the workgroup clears its 64KB of LDS
+//   The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//       before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+
+
+shader main
+  asic(GFX10.1)
+  type(CS)
+  wave_size(32)
+// Note: original source code from SQ team
+
+//
+// Create 32 waves in a threadgroup (CS waves)
+// Each allocates 64 VGPRs
+// The workgroup allocates all of LDS (64kbytes)
+//
+// Takes about 2500 clocks to run.
+//   (theorhetical fastest = 1024clks vgpr + 640lds = 1660 clks)
+//
+  S_BARRIER
+  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_0
+  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s0 == 1)
+
+  s_mov_b32     s2, 0x00000038  // Loop 64/8=8 times  (loop unrolled for performance)
+  s_mov_b32     m0, 0
+  //
+  // CLEAR VGPRs
+  //
+label_0005:
+  v_movreld_b32     v0, 0
+  v_movreld_b32     v1, 0
+  v_movreld_b32     v2, 0
+  v_movreld_b32     v3, 0
+  v_movreld_b32     v4, 0
+  v_movreld_b32     v5, 0
+  v_movreld_b32     v6, 0
+  v_movreld_b32     v7, 0
+  s_mov_b32         m0, s2
+  s_sub_u32     s2, s2, 8
+  s_cbranch_scc0  label_0005
+  //
+  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wave
+  s_and_b32     s2, s2, s0                                  // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_0023                         // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1        // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1          // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f                    // 64 loop iterations
+  s_mov_b32     m0, 0xffffffff
+  // Clear all of LDS space
+  // Each FirstWave of WorkGroup clears 64kbyte block
+
+label_001F:
+  ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
+  ds_write2_b64  v1, v[4:5], v[4:5] offset0:64 offset1:96
+  v_add_co_u32     v1, vcc, 0x00000400, v1
+  s_sub_u32     s2, s2, 1
+  s_cbranch_scc0  label_001F
+
+  //
+  // CLEAR SGPRs
+  //
+label_0023:
+  s_mov_b32     m0, 0x00000068  // Loop 108/4=27 times  (loop unrolled for performance)
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+
+  //clear vcc
+  s_mov_b64 vcc, 0          //clear vcc
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_lo, 0   //clear  flat scratch lo SGPR
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_hi, 0    //clear  flat scratch hi SGPR
+  s_mov_b64 ttmp0, 0        //Clear ttmp0 and ttmp1
+  s_mov_b64 ttmp2, 0        //Clear ttmp2 and ttmp3
+  s_mov_b64 ttmp4, 0        //Clear ttmp4 and ttmp5
+  s_mov_b64 ttmp6, 0        //Clear ttmp6 and ttmp7
+  s_mov_b64 ttmp8, 0        //Clear ttmp8 and ttmp9
+  s_mov_b64 ttmp10, 0       //Clear ttmp10 and ttmp11
+  s_mov_b64 ttmp12, 0       //Clear ttmp12 and ttmp13
+  s_mov_b64 ttmp14, 0       //Clear ttmp14 and ttmp15
+
+ s_endpgm
+
+end
+
+
-- 
2.34.1

