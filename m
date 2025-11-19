Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B2CF34C3
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C4010E248;
	Wed, 19 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+Kl49pA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FCA10E248
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNpMItwxG+b1RKR2RvmZLP7CTvlyH7zeUUf4wPwLFJuW+Iiqwk0orGPZPrSwwJGefDcRXCzzq+Py8SV0a2RtYrIPs/knC4avc0JIEq/VwrKwCKhHmuqxVIEbV7gmaNnihJUb5vjJlbUFIGG/LjeDcgu75h1XA3ejJiqvPRYedw2w1BIJiERAStHBEJLWEGyFDgABLQwgUDs6zAP28Ki3M4375EEMSyZxTQREW3IeYu0TmPiOigvtRyP1CYZl8v9kP8P7NkT5miQiBiF2aJjNDpe531mpuKo/YczCWLpej+c1vnWO066VAR9TNVCisKx6JsMtURAWbT1qwI41/VaZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsagFBjKCNkytyB03BAp9oJ4cvre2S/O0q7FxFJJFPs=;
 b=al0hqEuveP2laJtausxJnjLfZhAKXflY/daPCdvjycZRSMtk9y480ze66p0o2sD4Qb3JCt/Q6NBljj2O5Uf4Jmnk2Y4rg4ZRxck7OSvDesaNm5jZBtrUjkmptw0+xgun70+KRjUmj1HTQUvq9gA0MQlBBK8Pgj32KhLbBXWvlbDie80lJeABKmCYHXj1CDmqQH6mngzdWYilIpv6W1WLp9RnlONDEjtgf9UF36zB5pqBDoQDWJZXnH/Rx4Hjq19KmWd2rGHQQKHIYUknhJDkgM4fn0KC6fGKWekyQg9Oz9n5z5XC7gPhWZ6b4mSEBUAPGsSUoZ6KxjVpF4O5/TGmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsagFBjKCNkytyB03BAp9oJ4cvre2S/O0q7FxFJJFPs=;
 b=1+Kl49pADieGN+pC/qfySypslHQQGoi/ojd5tZWuXTJwh7ODhlQXjoELevbLxq/iBvbDHe7ZOtBjGMn6gHauv4g7PaeUXcpE8+GsVXaZyAxZZZy+hQ89ak5ueSjUjOhRMafhwOD53Rjse8LBaqtlNlXIMe8Z4QjudRDMHbRRDJ8=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Wed, 19 Nov
 2025 14:58:12 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::17) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 14:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Wed, 19 Nov 2025 14:58:12 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 06:58:07 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add gfxhub v12_1 support
Date: Wed, 19 Nov 2025 09:57:53 -0500
Message-ID: <20251119145753.3663240-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119145753.3663240-1-alexander.deucher@amd.com>
References: <20251119145753.3663240-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: ead94e8e-7e53-4ff6-c1ee-08de277c0f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6EfPzq7sHM/LjsIvgT3LB7aFY6jEHaA2smVbYJRlKzoxs21QoSLe4S/bf6t9?=
 =?us-ascii?Q?myShXAqtHCzpqBHkJpBYrsV/ZBgh7bzhycmPhBGR+dq1OLw4uxjGdWaxUQ41?=
 =?us-ascii?Q?PGZLZLsZ7vHr65x/sN1qupK0lTKOGFe8QAZegtfmu9CHUACQFH51W84QZKyJ?=
 =?us-ascii?Q?mKYbFfB9ohuJNeNKfy5eItMshJ60ZnujUU7hXx11OQdvOdbSOEHt5E36Mehd?=
 =?us-ascii?Q?a7rDlotBgc0vYKO4fiNonnBkiExE6ulF1iLi3s6hHOMT9stW9rQ3EyIsl+C0?=
 =?us-ascii?Q?mehOTFZxXI4wPjs0LfCoADiHRANSslpnSYNxs+6pAcNGCozSDgMG51oo48hI?=
 =?us-ascii?Q?NlcJS8GNl1TKuV0xm4f3fvwKJxr4jtNnYXdSYUm9Q19bzVa26AIoT3Ix3Inp?=
 =?us-ascii?Q?VgIxu211+h2gbT3Q4p6R+vJ7+61+SOJi0AgQuMsWIQBQkJIFqgXU9GZtFi3R?=
 =?us-ascii?Q?4kJN9DSURVZxnt6vbecl+3L1zy6aNwclGqQEQz5WWe+6GDRyj4swSSWceh/T?=
 =?us-ascii?Q?vh3+Ssd2IUdAo9CxV0XSuW00HW3a7Q5roj5oggET6/qq5Z0nI5arBeVd//DZ?=
 =?us-ascii?Q?DTSFffu7E4zP1/HxPpt/XD9MXQxEl5quHNVZgaN0SQy6IJKsS6sj5ynDd8rh?=
 =?us-ascii?Q?w54NMF3gZsY8CeZUYX5wJAIZazqI8U+gnIzACGkNMbwzvjMPd79RZaaC3IlU?=
 =?us-ascii?Q?OOtwHdVcUUlFNUPhCsDmCscPmPL7dTTMbL5WtJ8i2siPqgoK5+slb9iPvzYs?=
 =?us-ascii?Q?70/t4Gvoi+Nc2kJ3vJVyA8SPH4hf8B/o5W7r4950in3hl9cZ5ftAXsu2O7hI?=
 =?us-ascii?Q?8hGmP6sKVfTP8Iwg5I7guP4JQZks/syVV4q4Qz2u8ezhAUycB0nt917r2S4Q?=
 =?us-ascii?Q?fY6KE5PJLC9qT8/mBTq79hTrByzzZ11bZi17mwwN9u+QGMhDgpu/QsgY7XNi?=
 =?us-ascii?Q?LGlyLJiGaa2yB8k6Tpvdn+d4J46ibC8DFs0kAUIsxbDtdtyNowdviVhWDNpM?=
 =?us-ascii?Q?v4fRihYz58HDV1ztIf8jUzGuLKBHGnUZK0lU/ZnpvrGguJynMsKD5ZERLnEa?=
 =?us-ascii?Q?GQqxiODaV2bjuQ2WjozKyD4LrvzbHM38ZavyywNWRca42EypoI/L3VGTIKlE?=
 =?us-ascii?Q?fBzzYeA7yJywNYXFSqB8Xlq+PdYp4UewBz7h3bK7L2Xg2/FhiR/0Ph4KBqSh?=
 =?us-ascii?Q?rqzEgX8iCRUQj5NLZJ6PMcqXHbh5i7Rwq1tedCB05ywmH7s4yx/t+kE8I2/S?=
 =?us-ascii?Q?9oH675fEJatFgAJ5gaZTCFeLwEGmTSKPigdkestcY9XouIscto0QjEk04olm?=
 =?us-ascii?Q?HMDd9lSxUKfBYpQ9475Us38pX2O1tvYS0WWkFSsW4v+CqbE7UyB+c9Z1bRpF?=
 =?us-ascii?Q?NDtBf1OXO7uZLvBm9LbeyghQsiZRJqwROzG9wQjJfwxvIcyTI1/9qUwPSaCD?=
 =?us-ascii?Q?yqNXS1+zrjy10XyHn0t+RYq81F313ypgbH6w0oi/BmJ+1OnSxVtEEs5SFE16?=
 =?us-ascii?Q?1JOpCBD887S47TRIsOYF/vN1BnVzcGxyPsZO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:58:12.2213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead94e8e-7e53-4ff6-c1ee-08de277c0f7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

gfxhub v12_1 is a new generation ip

v2: squash in update to new IP headers

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 896 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h |  31 +
 3 files changed, 928 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 226b022ab40be..0c2779047ace7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -105,7 +105,7 @@ amdgpu-y += \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
 	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o \
 	gfxhub_v11_5_0.o mmhub_v4_1_0.o gfxhub_v12_0.o gmc_v12_0.o \
-	mmhub_v4_2_0.o
+	mmhub_v4_2_0.o gfxhub_v12_1.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
new file mode 100644
index 0000000000000..8ec0a14d3203b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -0,0 +1,896 @@
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
+#include "amdgpu_xcp.h"
+#include "gfxhub_v12_1.h"
+
+#include "gc/gc_12_1_0_offset.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "soc_v1_0_enum.h"
+
+#include "soc15_common.h"
+
+#define regGCVM_L2_CNTL3_DEFAULT		0x80120007
+#define regGCVM_L2_CNTL4_DEFAULT		0x000000c1
+#define regGCVM_L2_CNTL5_DEFAULT		0x00003fe0
+#define regGRBM_GFX_INDEX_DEFAULT			0xe0000000
+
+
+static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base;
+
+	base = RREG32_SOC15(GC, GET_INST(GC, 0),
+			    regGCMC_VM_FB_LOCATION_BASE_LO32);
+	base &= GCMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
+	base <<= 24;
+
+	base |= ((GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
+		  RREG32_SOC15(GC, GET_INST(GC, 0),
+			  regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
+	return base;
+}
+
+static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
+				  regGCMC_VM_FB_OFFSET) << 24);
+}
+
+static void gfxhub_v12_1_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
+					      uint32_t vmid,
+					      uint64_t page_table_base,
+					      uint32_t xcc_mask)
+{
+	struct amdgpu_vmhub *hub;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
+				    regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+				    hub->ctx_addr_distance * vmid,
+				    lower_32_bits(page_table_base));
+
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
+				    regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+				    hub->ctx_addr_distance * vmid,
+				    upper_32_bits(page_table_base));
+	}
+}
+
+static void gfxhub_v12_1_setup_vm_pt_regs(struct amdgpu_device *adev,
+					  uint32_t vmid,
+					  uint64_t page_table_base)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, vmid, page_table_base, xcc_mask);
+}
+
+static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
+						     uint32_t xcc_mask)
+{
+	uint64_t pt_base;
+	int i;
+
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, 0, pt_base, xcc_mask);
+
+	/* If use GART for FB translation, vmid0 page table covers both
+	 * vram and system memory (gart)
+	 */
+	for_each_inst(i, xcc_mask) {
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.fb_start >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.fb_start >> 44));
+
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		} else {
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.gart_start >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.gart_start >> 44));
+
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		}
+	}
+}
+
+static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
+						       uint32_t xcc_mask)
+{
+	uint64_t value;
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_BASE_LO32, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_BASE_HI32, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_BOT_LO32,
+				 lower_32_bits(adev->gmc.agp_start >> 24));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_BOT_HI32,
+				 upper_32_bits(adev->gmc.agp_start >> 24));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_TOP_LO32,
+				 lower_32_bits(adev->gmc.agp_end >> 24));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_AGP_TOP_HI32,
+				 upper_32_bits(adev->gmc.agp_end >> 24));
+
+		if (!amdgpu_sriov_vf(adev)) {
+			/* Program the system aperture low logical page number. */
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+				     lower_32_bits(min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+				     upper_32_bits(min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
+				     lower_32_bits(max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
+				     upper_32_bits(max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18));
+
+			/* Set default page address. */
+			value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				     (u32)(value >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				     (u32)(value >> 44));
+
+			/* Program "protection fault". */
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+				     (u32)(adev->dummy_page_addr >> 12));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+				     (u32)((u64)adev->dummy_page_addr >> 44));
+
+			tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+					   regGCVM_L2_PROTECTION_FAULT_CNTL2);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		}
+
+		/* In the case squeezing vram into GART aperture, we don't use
+		 * FB aperture and AGP aperture. Disable them.
+		 */
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_TOP_LO32, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_TOP_HI32, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_BASE_LO32,
+				     0xFFFFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_BASE_HI32, 1);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_AGP_TOP_LO32, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_AGP_TOP_HI32, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_AGP_BOT_LO32, 0xFFFFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_AGP_BOT_HI32, 1);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+				     0xFFFFFFFF);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+				     0x7F);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
+		}
+	}
+}
+
+static void gfxhub_v12_1_xcc_init_tlb_regs(struct amdgpu_device *adev,
+					   uint32_t xcc_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+				   regGCMC_VM_MX_L1_TLB_CNTL);
+
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_L1_TLB, 1);
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    SYSTEM_ACCESS_MODE, 3);
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    ECO_BITS, 0);
+		tmp = REG_SET_FIELD(tmp,
+				    GCMC_VM_MX_L1_TLB_CNTL,
+				    MTYPE, MTYPE_UC);
+
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCMC_VM_MX_L1_TLB_CNTL, tmp);
+	}
+}
+
+static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
+					     uint32_t xcc_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    ENABLE_L2_CACHE, 1);
+		/*TODO: set ENABLE_L2_FRAGMENT_PROCESSING to 1? */
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    ENABLE_L2_FRAGMENT_PROCESSING, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    L2_PDE0_CACHE_TAG_GENERATION_MODE, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    PDE_FAULT_CLASSIFICATION, 0);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+				    IDENTITY_MODE_FRAGMENT_SIZE, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCVM_L2_CNTL, tmp);
+
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regGCVM_L2_CNTL2);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2,
+				    INVALIDATE_ALL_L1_TLBS, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2,
+				    INVALIDATE_L2_CACHE, 1);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i),
+				 regGCVM_L2_CNTL2, tmp);
+
+		tmp = regGCVM_L2_CNTL3_DEFAULT;
+		if (adev->gmc.translate_further) {
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+		} else {
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 9);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+		}
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regGCVM_L2_CNTL3, tmp);
+
+		tmp = regGCVM_L2_CNTL4_DEFAULT;
+		/* For AMD APP APUs setup WC memory */
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+		}
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regGCVM_L2_CNTL4, tmp);
+
+		tmp = regGCVM_L2_CNTL5_DEFAULT;
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5,
+				    L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regGCVM_L2_CNTL5, tmp);
+	}
+}
+
+static void gfxhub_v12_1_xcc_enable_system_domain(struct amdgpu_device *adev,
+						  uint32_t xcc_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+				   regGCVM_CONTEXT0_CNTL);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
+				    ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
+				    PAGE_TABLE_DEPTH,
+				    adev->gmc.vmid0_page_table_depth);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
+				    PAGE_TABLE_BLOCK_SIZE,
+				    adev->gmc.vmid0_page_table_block_size);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_CONTEXT0_CNTL, tmp);
+	}
+}
+
+static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *adev,
+						       uint32_t xcc_mask)
+{
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+			     0XFFFFFFFF);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+			     0x00001FFF);
+
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+			     0);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+			     0);
+
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32,
+			     0);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32,
+			     0);
+	}
+}
+
+static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
+					       uint32_t xcc_mask)
+{
+	struct amdgpu_vmhub *hub;
+	unsigned int num_level, block_size;
+	uint32_t tmp;
+	int i, j;
+
+	num_level = adev->vm_manager.num_level;
+	block_size = adev->vm_manager.block_size;
+	block_size -= 9;
+
+	for_each_inst(j, xcc_mask) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
+		for (i = 0; i <= 14; i++) {
+			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					          regGCVM_CONTEXT1_CNTL,
+						  i * hub->ctx_distance);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    ENABLE_CONTEXT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    PAGE_TABLE_DEPTH, num_level);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    PAGE_TABLE_BLOCK_SIZE, block_size);
+			/* Send no-retry XNACK on fault to suppress VM fault storm */
+			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+					    !amdgpu_noretry);
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_CONTEXT1_CNTL,
+					    i * hub->ctx_distance, tmp);
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+					    i * hub->ctx_addr_distance,
+					    lower_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+					    i * hub->ctx_addr_distance,
+					    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		}
+
+		hub->vm_cntx_cntl = tmp;
+	}
+}
+
+static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
+						  uint32_t xcc_mask)
+{
+	struct amdgpu_vmhub *hub;
+	unsigned int i, j;
+
+	for_each_inst(j, xcc_mask) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
+
+		for (i = 0 ; i < 18; ++i) {
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+					    i * hub->eng_addr_distance, 0xFFFFFFFF);
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+					    i * hub->eng_addr_distance, 0x3FFF);
+		}
+	}
+}
+
+static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
+					uint32_t xcc_mask)
+{
+	uint32_t i;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
+		 * VBIO post does not program them at boot up phase
+		 * Need driver to program them from guest side */
+		for_each_inst(i, xcc_mask) {
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_BASE_LO32,
+				     lower_32_bits(adev->gmc.vram_start >> 24));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_BASE_HI32,
+				     upper_32_bits(adev->gmc.vram_start >> 24));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_TOP_LO32,
+				     lower_32_bits(adev->gmc.vram_end >> 24));
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGCMC_VM_FB_LOCATION_TOP_HI32,
+				     upper_32_bits(adev->gmc.vram_end >> 24));
+		}
+	}
+	/* GART Enable. */
+	gfxhub_v12_1_xcc_init_gart_aperture_regs(adev, xcc_mask);
+	gfxhub_v12_1_xcc_init_system_aperture_regs(adev, xcc_mask);
+	gfxhub_v12_1_xcc_init_tlb_regs(adev, xcc_mask);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v12_1_xcc_init_cache_regs(adev, xcc_mask);
+
+	gfxhub_v12_1_xcc_enable_system_domain(adev, xcc_mask);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v12_1_xcc_disable_identity_aperture(adev, xcc_mask);
+	gfxhub_v12_1_xcc_setup_vmid_config(adev, xcc_mask);
+	gfxhub_v12_1_xcc_program_invalidation(adev, xcc_mask);
+
+	return 0;
+}
+
+static int gfxhub_v12_1_gart_enable(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	return gfxhub_v12_1_xcc_gart_enable(adev, xcc_mask);
+}
+
+static void gfxhub_v12_1_xcc_gart_disable(struct amdgpu_device *adev,
+					  uint32_t xcc_mask)
+{
+	struct amdgpu_vmhub *hub;
+	u32 tmp;
+	u32 i, j;
+
+	for_each_inst(j, xcc_mask) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
+		/* Disable all tables */
+		for (i = 0; i < 16; i++)
+			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
+					    regGCVM_CONTEXT0_CNTL,
+					    i * hub->ctx_distance, 0);
+
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, GET_INST(GC, j),
+				   regGCMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, j),
+				 regGCMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		/* Setup L2 cache */
+		if (!amdgpu_sriov_vf(adev)) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, j), regGCVM_L2_CNTL);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+			WREG32_SOC15(GC, GET_INST(GC, j), regGCVM_L2_CNTL, tmp);
+			WREG32_SOC15(GC, GET_INST(GC, j), regGCVM_L2_CNTL3, 0);
+		}
+	}
+}
+
+static void gfxhub_v12_1_gart_disable(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_gart_disable(adev, xcc_mask);
+}
+
+static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev,
+						      bool value, uint32_t xcc_mask)
+{
+	u32 tmp;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE3_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+				    value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value ? 0xFFFF:0);
+		tmp = REG_SET_FIELD(tmp,
+				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    OTHER_CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value);
+		if (!value)
+			tmp = REG_SET_FIELD(tmp,
+					    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
+					    CRASH_ON_NO_RETRY_FAULT, 1);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
+
+		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+				   regGCVM_L2_PROTECTION_FAULT_CNTL_HI32);
+		if (!value)
+			tmp = REG_SET_FIELD(tmp,
+					    GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
+					    CRASH_ON_RETRY_FAULT, 1);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGCVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
+	}
+}
+
+/**
+ * gfxhub_v12_1_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void gfxhub_v12_1_set_fault_enable_default(struct amdgpu_device *adev,
+						  bool value)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, xcc_mask);
+}
+
+static uint32_t gfxhub_v12_1_get_invalidate_req(unsigned int vmid,
+						uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR, 0);
+
+	return req;
+}
+
+static const char *gfxhub_v12_1_client_ids[] = {
+	"CB",
+	"DB",
+	"GE1",
+	"GE2",
+	"CPF",
+	"CPC",
+	"CPG",
+	"RLC",
+	"TCP",
+	"SQC (inst)",
+	"SQC (data)",
+	"SQG/PC/SC",
+	"Reserved",
+	"SDMA0",
+	"SDMA1",
+	"GCR",
+	"Reserved",
+	"Reserved",
+	"WGS",
+	"DSM",
+	"PA"
+};
+
+/*TODO: l2 protection fault status is increased to 64bits.
+ * some critical fields like FED are moved to STATUS_HI32 */
+static void gfxhub_v12_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
+							  uint32_t status)
+{
+	u32 cid = REG_GET_FIELD(status,
+				GCVM_L2_PROTECTION_FAULT_STATUS_LO32,
+				CID);
+
+	dev_err(adev->dev,
+		"GCVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		cid >= ARRAY_SIZE(gfxhub_v12_1_client_ids) ?
+		"unknown" : gfxhub_v12_1_client_ids[cid], cid);
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, RW));
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v12_1_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v12_1_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v12_1_get_invalidate_req,
+};
+
+static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
+{
+	struct amdgpu_vmhub *hub;
+	int i;
+
+	for_each_inst(i, xcc_mask) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
+
+		hub->ctx0_ptb_addr_lo32 =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+		hub->ctx0_ptb_addr_hi32 =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+		hub->vm_inv_eng0_sem =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_INVALIDATE_ENG0_SEM);
+		hub->vm_inv_eng0_req =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_INVALIDATE_ENG0_REQ);
+		hub->vm_inv_eng0_ack =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_INVALIDATE_ENG0_ACK);
+		hub->vm_context0_cntl =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_CONTEXT0_CNTL);
+		/* TODO: add a new member to accomandate additional fault status/cntl reg */
+		hub->vm_l2_pro_fault_status =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_L2_PROTECTION_FAULT_STATUS_LO32);
+		hub->vm_l2_pro_fault_cntl =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+				regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
+		hub->ctx_distance =
+				regGCVM_CONTEXT1_CNTL -
+				regGCVM_CONTEXT0_CNTL;
+		hub->ctx_addr_distance =
+				regGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+				regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+		hub->eng_distance =
+				regGCVM_INVALIDATE_ENG1_REQ -
+				regGCVM_INVALIDATE_ENG0_REQ;
+		hub->eng_addr_distance =
+				regGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+				regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+		hub->vm_cntx_cntl_vm_fault =
+			GCVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+		hub->vmhub_funcs = &gfxhub_v12_1_vmhub_funcs;
+	}
+}
+
+static void gfxhub_v12_1_init(struct amdgpu_device *adev)
+{
+	uint32_t xcc_mask;
+
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+	gfxhub_v12_1_xcc_init(adev, xcc_mask);
+}
+
+static int gfxhub_v12_1_get_xgmi_info(struct amdgpu_device *adev)
+{
+	u32 max_num_physical_nodes;
+	u32 max_physical_node_id;
+	u32 xgmi_lfb_cntl;
+	u32 max_region;
+	u64 seg_size;
+
+	xgmi_lfb_cntl = RREG32_SOC15(GC, GET_INST(GC, 0),
+				     regGCMC_VM_XGMI_LFB_CNTL);
+	seg_size = REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, 0),
+				 regGCMC_VM_XGMI_LFB_SIZE),
+				 GCMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+	max_region = REG_GET_FIELD(xgmi_lfb_cntl,
+				   GCMC_VM_XGMI_LFB_CNTL,
+				   PF_MAX_REGION);
+
+	max_num_physical_nodes   = 8;
+	max_physical_node_id     = 7;
+
+	/* PF_MAX_REGION=0 means xgmi is disabled */
+	if (max_region || adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
+
+		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
+			return -EINVAL;
+
+		adev->gmc.xgmi.physical_node_id =
+			REG_GET_FIELD(xgmi_lfb_cntl,
+				      GCMC_VM_XGMI_LFB_CNTL,
+				      PF_LFB_REGION);
+
+		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
+			return -EINVAL;
+
+		adev->gmc.xgmi.node_segment_size = seg_size;
+	}
+
+	return 0;
+}
+
+const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
+	.get_fb_location = gfxhub_v12_1_get_fb_location,
+	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
+	.setup_vm_pt_regs = gfxhub_v12_1_setup_vm_pt_regs,
+	.gart_enable = gfxhub_v12_1_gart_enable,
+	.gart_disable = gfxhub_v12_1_gart_disable,
+	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
+	.init = gfxhub_v12_1_init,
+	.get_xgmi_info = gfxhub_v12_1_get_xgmi_info,
+};
+
+static int gfxhub_v12_1_xcp_resume(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool value;
+
+	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
+		value = false;
+	else
+		value = true;
+
+	gfxhub_v12_1_xcc_set_fault_enable_default(adev, value, inst_mask);
+
+	if (!amdgpu_sriov_vf(adev))
+		return gfxhub_v12_1_xcc_gart_enable(adev, inst_mask);
+
+	return 0;
+}
+
+static int gfxhub_v12_1_xcp_suspend(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v12_1_xcc_gart_disable(adev, inst_mask);
+
+	return 0;
+}
+
+struct amdgpu_xcp_ip_funcs gfxhub_v12_1_xcp_funcs = {
+	.suspend = &gfxhub_v12_1_xcp_suspend,
+	.resume = &gfxhub_v12_1_xcp_resume
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h
new file mode 100644
index 0000000000000..b3f8f0aa00243
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h
@@ -0,0 +1,31 @@
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
+
+#ifndef __GFXHUB_V12_1_H__
+#define __GFXHUB_V12_1_H__
+
+extern const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs;
+
+extern struct amdgpu_xcp_ip_funcs gfxhub_v12_1_xcp_funcs;
+
+#endif
-- 
2.51.1

