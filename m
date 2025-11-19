Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D29CF34C9
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B28F10E656;
	Wed, 19 Nov 2025 15:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1awD5Lr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CC010E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU7W1b5PX9kzsoae0icS4cXVsOiej43x8bzFXxdZ9SPwrihsMOitfqH2s0BWNz9zBNOTPVRplcvR08+Qu7EFNbugPwil1DNfcdkvYP+cQ/RSMTwsE8GzqwFDMZrhq8L0tt2Dnq08eAadzgdTtrGtY6nKNTQr1xi0sBkXd/l3jEZ0VSx0Nt0acoFoAFJMeR8iw5HCIWjTll6lVMLvMJgEybaXa7DQmsXZIMH905GLNG8ZM94NvaIHVGZJ22g52tPcvIm/KKXFjXdArR8hnzFWLJ6hsXG69b7HArZ2u+miTnvftEANjR6k3AmB8i+5MPyadDraxKx8a2+QFQyKgd70kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqKMJTBI5o0q5XMyzszdRGBFr8enmbSei8jKmCb3g0A=;
 b=vMdlKanO9IruSX1HiLTY0TxDn0IH9OPPyH+iArT/Iu+t/8ptQAEuKSMzDJcMB/PRt65SAinwxawgTR9NoPCD5JidtdcdDoogqySn1vme0MdUIoikdnk+xTTuQfIvniMmw3osgSOqs6kw9BTK757s2OLc+2XPrtVZ1nhD3b7ep0jvU0kEfaDj12WSqq9uu/yi/otuZAAhcO/y7CD672hdS+b3wUx9yU1Qg268O3aoVvxyK1scb6i6AzLfuBEX4bsZtQDNNGRvuTebkMwhDFPOGgwbHS8YYG1tKc/uM9iEQbU3BPk0dMRTb4VvN4xN9HX134WLwpHdkM2lL0MLhVFk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqKMJTBI5o0q5XMyzszdRGBFr8enmbSei8jKmCb3g0A=;
 b=r1awD5LroTLzyC+t5Wd8nCFqfJpYXhVz8t5ORO8w7qNNRG8SzC6s+E+XQWI/ydmRAlL7q++6bXoArji6mPej9qIUk5gPGsbFZBKfxPHRGjHYe8VIo3N8R5+kbkwGMMYZ2VoyuotZoDoeFoB/XjQdh7XJQSDL/pPH2sP9B5Yc8IM=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:16 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::59) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 19 Nov 2025 15:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:16 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:14 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Add gmc v12_1 gmc callbacks
Date: Wed, 19 Nov 2025 10:05:55 -0500
Message-ID: <20251119150600.3663611-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 845c8d3c-af7a-405a-6d5f-08de277d304a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DcUChXl2aXXwfxAyKbBKB1RwrwsjUJNNPRgY7Lj/rskNv7zIOpZY9P/czbXT?=
 =?us-ascii?Q?HmJIvvpm/gpZ0J1SNGViP9Geodh13D4IqwZLK3lNkJfp13d38foybK/MtklU?=
 =?us-ascii?Q?adOn0oTCAKNiRnVl7lCEtf6z86LPsFf0zBx9wOkyAR0q/jw+nZpc9evwFsEn?=
 =?us-ascii?Q?dW0xgkZ03JbkOik8USqS7wQPFcaIRqpSsPjRz5j2+qJudeSqSKVfxYFNfuyo?=
 =?us-ascii?Q?VULCB3h2m35fPL2/kKjpsAO/yPVG/3r9PAHi6ecAKXvHC2ZtJMV1goSXGVYc?=
 =?us-ascii?Q?tEtEoiuxwg+4UTvKThZ48pXM3zZrIvD8X8gh0rPnPTBz9mPYOcxdIXbw55s2?=
 =?us-ascii?Q?v83njFlyp04Gs/yTlB/jbpEsO1WvTRcsUD4fyjIjJN5Q/s/1W8gBDujyIgw6?=
 =?us-ascii?Q?MswfnW+tKcLVk4dlQAgbuAgkppLZBxhrrSHWMbd0PZiAxj8nppU9r0w3X+KN?=
 =?us-ascii?Q?Ytp05beBE6DEGSWXWSD6wgzhXsnvexvG0bK5e8T2u3znCeev+17wEUciktJN?=
 =?us-ascii?Q?LxuPJi5KmzkCEwF5qeJ4NQhU4DqcSBgtWgTrlLCIolk6pEbWtKjd0oXZkKmk?=
 =?us-ascii?Q?9SYR5oEy4KfvabDqttAkyCPhxnSlAjvlRxGfsEs4HxOn2RV95y8e9Lk3LjAy?=
 =?us-ascii?Q?Al2xK0kxu/FZAT7g5ULRpNTSJUmXDNS6cjIiTB1PcdDnZ9y3QxOG3TcNuu96?=
 =?us-ascii?Q?GrXErnvDxDIA3icNfAtBM5gnpstz6l5P09wn+hslgZeU0a0lAUA3nrItDYZC?=
 =?us-ascii?Q?5Q+V7j4M3qlfWdzSF504FWWrMemquyDKB9i/i94miVwzLPKihc9tZ2xf/AIr?=
 =?us-ascii?Q?5zDhQW1Q2DnyL/VhHfTcdmNmud9UIPywRGlE90/ka3g+P7pvblOuN4/WDHl8?=
 =?us-ascii?Q?KJnX2L0xo8bw79KwgHAZA5bnExguz/EPIj6xk6/Q9GNOcIvBNreJiKX14s4C?=
 =?us-ascii?Q?jSCvOZASUJ+K3yOzpnD1+gnSBWCpv8adELgM2pwV/Ith6EuNplKmut8oGhwX?=
 =?us-ascii?Q?OIMbQMQQwkjCLzWmdU/KjHZZcmbGi8KSo8BpNlNm1eznpurUqKZTU/8UA3vX?=
 =?us-ascii?Q?G46Yn1R15OxQnMGFZMQ7mBESPde3CfFxDmD8t7Btq4d2WD9pwyUuA+pXdzyL?=
 =?us-ascii?Q?s8KfVgZLph93zbg4cLYWHzX0DINrIQ3NLJahQYRjUIv6lqURLEnVKHV7UXRE?=
 =?us-ascii?Q?Fx4R+OQc+HPd/OyW2tZZT7u4R3r2neqQIdW+Em7u7mniK2uHSbuk1p2wnI+f?=
 =?us-ascii?Q?7s8gie6Php+Bw/Nvzk8VdKDZYcFaR5G82mcHY2S8vIzBAFaT1+kn9iQqEMkU?=
 =?us-ascii?Q?ssrsF1bsJYqwgA+PLy3qEP3gNXe6eXtQWMbD30C1sIia/BcftoKYnQuUHI/C?=
 =?us-ascii?Q?K3BcFnZiqcR8QuqhCRHatA2hoa6j0S+izUY+VFxQ0M6NbD3OamvL7oWLv/sv?=
 =?us-ascii?Q?M3Pz7yOgyUX9gP/qLp4zUyZG6Qmz7NL5e7NnoiMDJfWuGYMJu9cE9Otkozi/?=
 =?us-ascii?Q?Hk/qyPe4QiBiGu/qB8RTcJ7cTCuOz8fvbLDExpM7/nqa8IgXOnUm5v9QzO8Z?=
 =?us-ascii?Q?GyHwkEB/G/R5/KtQBI0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:16.7323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845c8d3c-af7a-405a-6d5f-08de277d304a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

Implement gmc v12_1 gmc callbacks

v2: revert temporary PDE MTYPE to UC setting

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 323 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h |  29 +++
 4 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 0c2779047ace7..a9b89994c6de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -105,7 +105,7 @@ amdgpu-y += \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
 	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o \
 	gfxhub_v11_5_0.o mmhub_v4_1_0.o gfxhub_v12_0.o gmc_v12_0.o \
-	mmhub_v4_2_0.o gfxhub_v12_1.o
+	mmhub_v4_2_0.o gfxhub_v12_1.o gmc_v12_1.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index d22c762473424..3cb61d2c58f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v12_0.h"
+#include "gmc_v12_1.h"
 #include "athub/athub_4_1_0_sh_mask.h"
 #include "athub/athub_4_1_0_offset.h"
 #include "oss/osssys_7_0_0_offset.h"
@@ -623,9 +624,16 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 1, 0):
+		gmc_v12_1_set_gmc_funcs(adev);
+		break;
+	default:
+		gmc_v12_0_set_gmc_funcs(adev);
+		break;
+	}
 	gmc_v12_0_set_gfxhub_funcs(adev);
 	gmc_v12_0_set_mmhub_funcs(adev);
-	gmc_v12_0_set_gmc_funcs(adev);
 	gmc_v12_0_set_irq_funcs(adev);
 	gmc_v12_0_set_umc_funcs(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
new file mode 100644
index 0000000000000..347be0ef07ec8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -0,0 +1,323 @@
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
+#include "gmc_v12_1.h"
+#include "soc15_common.h"
+#include "soc_v1_0_enum.h"
+#include "oss/osssys_7_1_0_offset.h"
+#include "oss/osssys_7_1_0_sh_mask.h"
+
+static bool gmc_v12_1_get_vmid_pasid_mapping_info(struct amdgpu_device *adev,
+						  uint8_t vmid, uint16_t *p_pasid)
+{
+	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
+
+	return !!(*p_pasid);
+}
+
+/*
+ * GART
+ * VMID 0 is the physical GPU addresses as used by the kernel.
+ * VMIDs 1-15 are used for userspace clients and are handled
+ * by the amdgpu vm/hsa code.
+ */
+
+static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
+				   unsigned int vmhub, uint32_t flush_type)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 tmp;
+	/* Use register 17 for GART */
+	const unsigned eng = 17;
+	unsigned int i;
+	unsigned char hub_ip = 0;
+
+	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
+		   GC_HWIP : MMHUB_HWIP;
+
+	spin_lock(&adev->gmc.invalidate_lock);
+
+	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
+
+	/* Wait for ACK with a delay.*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
+				    hub->eng_distance * eng, hub_ip);
+		tmp &= 1 << vmid;
+		if (tmp)
+			break;
+
+		udelay(1);
+	}
+
+	/* Issue additional private vm invalidation to MMHUB */
+	if ((vmhub != AMDGPU_GFXHUB(0)) &&
+	    (hub->vm_l2_bank_select_reserved_cid2) &&
+		!amdgpu_sriov_vf(adev)) {
+		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
+		inv_req |= (1 << 25);
+		/* Issue private invalidation */
+		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
+		/* Read back to ensure invalidation is done*/
+		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+	}
+
+	spin_unlock(&adev->gmc.invalidate_lock);
+
+	if (i < adev->usec_timeout)
+		return;
+
+	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
+}
+
+/**
+ * gmc_v12_1_flush_gpu_tlb - gart tlb flush callback
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
+ *
+ * Flush the TLB for the requested page table.
+ */
+static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+				    uint32_t vmhub, uint32_t flush_type)
+{
+	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
+		return;
+
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
+	 */
+	if (((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
+		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+		const unsigned eng = 17;
+		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+				1 << vmid, GET_INST(GC, 0));
+		return;
+	}
+
+	mutex_lock(&adev->mman.gtt_window_lock);
+	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	return;
+}
+
+/**
+ * gmc_v12_1_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ * @flush_type: the flush type
+ * @all_hub: flush all hubs
+ * @inst: is used to select which instance of KIQ to use for the invalidation
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					  uint16_t pasid, uint32_t flush_type,
+					  bool all_hub, uint32_t inst)
+{
+	uint16_t queried;
+	int vmid, i;
+
+	for (vmid = 1; vmid < 16; vmid++) {
+		bool valid;
+
+		valid = gmc_v12_1_get_vmid_pasid_mapping_info(adev, vmid,
+							      &queried);
+		if (!valid || queried != pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask,
+					 AMDGPU_MAX_VMHUBS)
+				gmc_v12_1_flush_gpu_tlb(adev, vmid, i,
+							flush_type);
+		} else {
+			gmc_v12_1_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
+						flush_type);
+		}
+	}
+}
+
+static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
+					     unsigned vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+	unsigned eng = ring->vm_inv_eng;
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
+					    req, 1 << vmid);
+
+	return pd_addr;
+}
+
+static void gmc_v12_1_emit_pasid_mapping(struct amdgpu_ring *ring,
+					 unsigned vmid, unsigned pasid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reg;
+
+	if (ring->vm_hub == AMDGPU_GFXHUB(0))
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
+	else
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM) + vmid;
+
+	amdgpu_ring_emit_wreg(ring, reg, pasid);
+}
+
+/*
+ * PTE format:
+ * 63 P
+ * 62:59 reserved
+ * 58 D
+ * 57 G
+ * 56 T
+ * 55:54 M
+ * 53:52 SW
+ * 51:48 reserved for future
+ * 47:12 4k physical page base address
+ * 11:7 fragment
+ * 6 write
+ * 5 read
+ * 4 exe
+ * 3 Z
+ * 2 snooped
+ * 1 system
+ * 0 valid
+ *
+ * PDE format:
+ * 63 P
+ * 62:58 block fragment size
+ * 57 reserved
+ * 56 A
+ * 55:54 M
+ * 53:52 reserved
+ * 51:48 reserved for future
+ * 47:6 physical base address of PD or PTE
+ * 5:3 reserved
+ * 2 C
+ * 1 system
+ * 0 valid
+ */
+
+static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
+				 uint64_t *addr, uint64_t *flags)
+{
+	if (!(*flags & AMDGPU_PDE_PTE_GFX12) && !(*flags & AMDGPU_PTE_SYSTEM))
+		*addr = adev->vm_manager.vram_base_offset + *addr -
+			adev->gmc.vram_start;
+	BUG_ON(*addr & 0xFFFF00000000003FULL);
+
+	if (!adev->gmc.translate_further)
+		return;
+
+	if (level == AMDGPU_VM_PDB1) {
+		/* Set the block fragment size */
+		if (!(*flags & AMDGPU_PDE_PTE_GFX12))
+			*flags |= AMDGPU_PDE_BFS_GFX12(0x9);
+
+	} else if (level == AMDGPU_VM_PDB0) {
+		if (*flags & AMDGPU_PDE_PTE_GFX12)
+			*flags &= ~AMDGPU_PDE_PTE_GFX12;
+	}
+}
+
+static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_bo *bo,
+				 uint32_t vm_flags,
+				 uint64_t *flags)
+{
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
+
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+		break;
+	}
+
+	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
+		*flags |= AMDGPU_PTE_NOALLOC;
+	else
+		*flags &= ~AMDGPU_PTE_NOALLOC;
+
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
+		*flags |= AMDGPU_PTE_SNOOPED;
+		*flags |= AMDGPU_PTE_SYSTEM;
+		*flags |= AMDGPU_PTE_IS_PTE;
+		*flags &= ~AMDGPU_PTE_VALID;
+	}
+
+	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
+			       AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+}
+
+static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
+	.flush_gpu_tlb = gmc_v12_1_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v12_1_flush_gpu_tlb_pasid,
+	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
+	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
+	.get_vm_pde = gmc_v12_1_get_vm_pde,
+	.get_vm_pte = gmc_v12_1_get_vm_pte,
+};
+
+void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev)
+{
+	adev->gmc.gmc_funcs = &gmc_v12_1_gmc_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
new file mode 100644
index 0000000000000..cc52db3a9908d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
@@ -0,0 +1,29 @@
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
+#ifndef __GMC_V12_1_H__
+#define __GMC_V12_1_H__
+
+void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev);
+
+#endif
-- 
2.51.1

