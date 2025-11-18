Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BB8CF2563
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8065C10E53B;
	Tue, 18 Nov 2025 22:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gae8+DlY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5E810E539
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvte4qT4Qv0xeG/QI4J324s9Inynxj3HE/nODn/UjCjHEN72JXCNDnsfrZd+72zGOUV9goXbpPc7KsLkp/C1kjAnzfuWX/0jMVgozqtKGSU8Imi/2nGC7qXFTzbYOy4d0oVPmG0FKP8s+zkDiv8S9vKnHyf9DxXxnPZ0iLKb1mgWNhmcSGeVpNEsm2vvWittzNkmH5uhtb6KGU5l6UgHJJj00vj1D6jhQSZFney8IMbdEsvQlmS/2mt0Feogm5vEJQIk76niq9GqjLep7K24+DrTHn05sZbzDl9iGBWLohQY4iTAMz3K9gWBvrZSLbE50AEvm4uhJpxw2pKsj5ABgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JJpRlauBWRkzg7FvUFaq2XrEMMx5IsT9wLWfi9YxkY=;
 b=ZK2+y3vmTjjO/Xz3phaMVLAbxOzq473NNdPgeRFEx9JvVGrvIwKjyfU93FP7S6fy459LA2HuROohFrJwAQj7C3jkLdrZFGbz/ffHv1w0W/9ujsb2Bbya0sevp603zLzM9PzQECVSrWEuhlqDjEbD4jSklFenCxQsIPzLo80Vu/WFJxPv7q6EFXjnLlYXOd03N6nAc+bMqyMfeamyzMY4zWPjmpG00u8Ab+U6FznXw74XZMtUZarYRoidPCmmTKTj9xIvDBc4mLgTMNp01JcNZ3N20RZL7d4yIfSJidXqCDeuVVhMJc+mmgY07X9VEk5nnnTnKIZ3Whxsfc9ZzlFX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JJpRlauBWRkzg7FvUFaq2XrEMMx5IsT9wLWfi9YxkY=;
 b=gae8+DlY+OogqSkOAXXmARPsOjQMmFIaR5LGQAbLKvFlxfRtmc701p9/ZvD65Gr45VlMUVZbAV0QBzIbB4vTuPvYbznNSq3ldq/El8O784EuXT2H+DSwpg+PzVv1DpYLA9h1ASN467BFvOxS8mEzKoooJmDzvwaAhk19YG/QmNg=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:54:55 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::2b) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 22:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:54:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:54:54 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add smuio v15_0_8 support v4
Date: Tue, 18 Nov 2025 17:54:37 -0500
Message-ID: <20251118225440.3613071-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: f349330a-387e-43bc-a56d-08de26f57e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?biu/IjLX24oxJTk/WRnKPTxZMrt1MRzjDlLtgTdI+GfQ729f8nyIR6kp1nCW?=
 =?us-ascii?Q?13Mvju5cNly5jl2vzMFG1wB6YD/kpzHk19g14vOuojUREz9E0LY6MOcSaEkc?=
 =?us-ascii?Q?7Z8BYIRCwtI9obbRZsrf6YeDR+0s6Q7Ldt/L3QpeGIOhkLzOEEpDzX8PxWhl?=
 =?us-ascii?Q?Rl00F9qNs+Os4moY29swcrOgzSgjDf5kwZg0iy12BMtVBd6ncul6PzLEVDyg?=
 =?us-ascii?Q?xWTtnfLmEgmKHeIfYIKaZbOfHlFqybt710Mh2K5Abe5hLqPAF8lJnNHeozKJ?=
 =?us-ascii?Q?ATdUOZ/74SgyxQwtd0Rkf2VX+rEk6k45XBX7CNmLlQ8VsbKw4SYj2NPvnUeY?=
 =?us-ascii?Q?WkZv7F12utYTPzIUJfTZXRghicAlYatiFKz+eun4bQf1GPlr7UjnLvjxgs7O?=
 =?us-ascii?Q?BKIEVFK3zOySVDwd6ffwsBOJiPICjkGd/E6wvYfMqxB+SDJR1w0P6R5mvzzS?=
 =?us-ascii?Q?tQDdOeZ5Ow6zL54S0zKUDpgpYXJ914AvuwC08ZuQtdpElljbYylTGZngdm6v?=
 =?us-ascii?Q?YT59u9gdnwVpRIqy0a4pOiDiXgcjf1QpndGLTWfSY6P/HRq/Cyu+BgnCb7+t?=
 =?us-ascii?Q?O6/8zLB5YFhOpt3J2ATNmJEyaub/qC2lbQYK+1Oak0Km3AmIb1slJe0cgzr7?=
 =?us-ascii?Q?y25t0gBQ16sZfHT70nDGdr3Em+NJKb7bPq2y71ZwV/7FgZCNJj6H4Z9IgiIt?=
 =?us-ascii?Q?gV4FBoHCHwSJi9h4qrDk2PgkmplSZuFrLFnboWfN5c0JaZ2EBRWbHNtqeLRr?=
 =?us-ascii?Q?yYOKr3OYLn+/Urxf3DOVIaeUu0KOwyY7JBTxXQtJ2AMfk288/svVvf4bE303?=
 =?us-ascii?Q?yx5ixmG5wbjBoAlTkn9k2LoiuJ7RK6a1gThOFbf64wq7AsSK3y6Q/B4xrRub?=
 =?us-ascii?Q?PdJ49KH+x2m4PFN7mCneSq2Nh1+3nESLnbs+hOxmTeT6KiVgF46e3nhoBGQq?=
 =?us-ascii?Q?JtJEyeJstrp5lrYQ71nxhb94dCMXgJPC+dY43wUkUJDqV11ac56ZlQeWejx9?=
 =?us-ascii?Q?EFtdQwqfM3Tc+dn6xPvpzauOamblRD9SQm2qdFYg+MeS/KV5KVsKYC60UKQF?=
 =?us-ascii?Q?R8cPJvyz4VS6jM4rjzs27W26JDlQoD44KLm5edAUwRUbT/hUjnV7o4UDnVEH?=
 =?us-ascii?Q?+BuRrx4cYDd8I+zXMMA8OGDDd6OIuMNT34CgqOXUzc1XeluKSyK+n21HVVD8?=
 =?us-ascii?Q?V7hD8Wl8RKp07L8ROkifWch4feHMRoO8Wdpo4o9v0RaVrkFEkG0Q/wamHKrS?=
 =?us-ascii?Q?peYcGLSYHarEsVAJ45NvrrwINDwtcvUp6a6yipuS4qwLhokgObsWOrb8YDgZ?=
 =?us-ascii?Q?bpy7d+sSadVngjSU97Uuw3F4h5RJdmF2p4Spl1q3h6gQZuEzmDU7QcySevMv?=
 =?us-ascii?Q?HzU9y2+A/ekz1iaRGMJsIuVE1tW+e9l9jjM5oDW4lCuqcuHTrY9ZGQTJwjpW?=
 =?us-ascii?Q?ph+03CkzWQJh0phXmIwXYfLixk+OaUAhKjAcyG2ryg7Wscc+BNiVkSWKb1d/?=
 =?us-ascii?Q?qeXbWjnd43G4dTiuqvIU8SNUDz4gwZX8uWipxnyx+DgavoxXHo/HbpIbqDPn?=
 =?us-ascii?Q?Ik4O5z7p3Uift7CKyuo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:54:55.5836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f349330a-387e-43bc-a56d-08de26f57e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

v15_0_8 is a new generation smuio ip block
v2: Add smuio callbacks for interface id
v3: Add smuio callback to identify custom hbm
v4: comment out unused functions (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h  |   3 +
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.c | 213 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.h |  30 +++
 4 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c88760fb52ea5..b10e9988a831f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -244,7 +244,8 @@ amdgpu-y += \
 	smuio_v13_0.o \
 	smuio_v13_0_3.o \
 	smuio_v13_0_6.o \
-	smuio_v14_0_2.o
+	smuio_v14_0_2.o \
+	smuio_v15_0_8.o
 
 # add reset block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index ec9d12f85f39f..124b13a68f3f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -27,6 +27,7 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_APU = 2,
 	AMDGPU_PKG_TYPE_CEM = 3,
 	AMDGPU_PKG_TYPE_OAM = 4,
+	AMDGPU_PKG_TYPE_BB  = 5,
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
@@ -44,6 +45,8 @@ struct amdgpu_smuio_funcs {
 	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	enum amdgpu_pkg_type (*get_pkg_type)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
+	bool (*is_connected_with_ethernet_switch)(struct amdgpu_device *adev);
+	bool (*is_custom_hbm_supported)(struct amdgpu_device *adev);
 	u64 (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.c
new file mode 100644
index 0000000000000..ef29424c26cce
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.c
@@ -0,0 +1,213 @@
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
+ *
+ */
+#include "amdgpu.h"
+#include "smuio_v15_0_8.h"
+#include "smuio/smuio_15_0_8_offset.h"
+#include "smuio/smuio_15_0_8_sh_mask.h"
+
+#define SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK	0x00000001L
+#define SMUIO_MCM_CONFIG__ETHERNET_SWITCH_MASK	0x00000008L
+#define SMUIO_MCM_CONFIG__CUSTOM_HBM_MASK	0x00000001L
+
+static u32 smuio_v15_0_8_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_INDEX);
+}
+
+static u32 smuio_v15_0_8_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
+}
+
+static void smuio_v15_0_8_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+{
+	return;
+}
+
+static u64 smuio_v15_0_8_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	u64 clock;
+	u64 clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	preempt_disable();
+	clock_counter_hi_pre = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	/* the clock counter may be udpated during polling the counters */
+	clock_counter_hi_after = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	if (clock_counter_hi_pre != clock_counter_hi_after)
+		clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	preempt_enable();
+
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
+
+	return clock;
+}
+
+static void smuio_v15_0_8_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
+{
+	u32 data;
+
+	/* CGTT_ROM_CLK_CTRL0 is not available for APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	data = RREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0);
+	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
+		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+}
+
+/**
+ * smuio_v15_0_8_get_die_id - query die id from FCH.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns die id
+ */
+static u32 smuio_v15_0_8_get_die_id(struct amdgpu_device *adev)
+{
+	u32 data, die_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	die_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, DIE_ID);
+
+	return die_id;
+}
+
+/**
+ * smuio_v15_0_8_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v15_0_8_get_socket_id(struct amdgpu_device *adev)
+{
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+/**
+ * smuio_v15_0_8_is_host_gpu_xgmi_supported - detect xgmi interface between cpu and gpu/s.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns true on success or false otherwise.
+ */
+static bool smuio_v15_0_8_is_host_gpu_xgmi_supported(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+	/* data[4:0]
+	 * bit 0 == 0 host-gpu interface is PCIE
+	 * bit 0 == 1 host-gpu interface is Alternate Protocal
+	 * for AMD, this is XGMI
+	 */
+	data &= SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK;
+
+	return data ? true : false;
+}
+
+#if 0
+/*
+ * smuio_v15_0_8_is_connected_with_ethernet_switch - detect systems connected with ethernet switch
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns true on success or false otherwise.
+ */
+static bool smuio_v15_0_8_is_connected_with_ethernet_switch(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	if (!(adev->flags & AMD_IS_APU))
+		return false;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+	/* data[4:0]
+	 * bit 3 == 0 systems connected with ethernet switch
+	 */
+	data &= SMUIO_MCM_CONFIG__ETHERNET_SWITCH_MASK;
+
+	return data ? false : true;
+}
+#endif
+
+static enum amdgpu_pkg_type smuio_v15_0_8_get_pkg_type(struct amdgpu_device *adev)
+{
+	enum amdgpu_pkg_type pkg_type;
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, PKG_TYPE);
+
+	/* data [3:0]
+	 bit 2 and bit 3 identifies the pkg type */
+	switch (data & 0xC) {
+	case 0x0:
+		pkg_type = AMDGPU_PKG_TYPE_BB;
+		break;
+	case 0x8:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	default:
+		pkg_type = AMDGPU_PKG_TYPE_UNKNOWN;
+		break;
+	}
+
+	return pkg_type;
+}
+
+#if 0
+static bool smuio_v15_0_8_is_custom_hbm_supported(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, PKG_TYPE);
+
+	/* data [3:0]
+	 * bit 0 identifies custom HBM module */
+	data &= SMUIO_MCM_CONFIG__CUSTOM_HBM_MASK;
+
+	return data ? true : false;
+}
+#endif
+
+const struct amdgpu_smuio_funcs smuio_v15_0_8_funcs = {
+	.get_rom_index_offset = smuio_v15_0_8_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v15_0_8_get_rom_data_offset,
+	.get_gpu_clock_counter = smuio_v15_0_8_get_gpu_clock_counter,
+	.get_die_id = smuio_v15_0_8_get_die_id,
+	.get_socket_id = smuio_v15_0_8_get_socket_id,
+	.is_host_gpu_xgmi_supported = smuio_v15_0_8_is_host_gpu_xgmi_supported,
+	.update_rom_clock_gating = smuio_v15_0_8_update_rom_clock_gating,
+	.get_clock_gating_state = smuio_v15_0_8_get_clock_gating_state,
+	.get_pkg_type = smuio_v15_0_8_get_pkg_type,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.h b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.h
new file mode 100644
index 0000000000000..508547fcce035
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_8.h
@@ -0,0 +1,30 @@
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
+ *
+ */
+#ifndef __SMUIO_V15_0_8_H__
+#define __SMUIO_V15_0_8_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v15_0_8_funcs;
+
+#endif /* __SMUIO_V15_0_8_H__ */
-- 
2.51.1

