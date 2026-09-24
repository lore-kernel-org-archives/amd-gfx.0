Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B389C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C1210F6D4;
	Thu, 24 Sep 2026 17:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24tvSIDK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E008710F6D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gROhBLiOSr0uYIGpAxE0qGmXRaWQ1lHShZcWKGO5ZwgPp0d30e/pgxRRXRPAECq/FPv/xJuhmVQYi7eOIQY44fuqd/+Kb8cpfzDHRg7qQEpfzuPHs1A4utA9FvM1N97OJvPu7DgCPU15nGwjP1JBeLK2f+/A46ahfkmzz2L3wJ6vGf124CEBh+jJCLlvWnm0IgEphdIYJ022Bp4s2gTqeYh0oc+kXkt1ofoeMbWGlVN8nPxhzTLZnZgnksFlg+EFliFfA3OhrhEDkGJfDgejVPQE7PIzlTnFNNlX5OKRb2BV9oEvGIBJs0sbEbAOeBs6aOxRNf26/WkVTYm4ZX7qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTQlf2O5483jz2wncpE/q6hWf/zmCkbsCz+KM963FHs=;
 b=AzUQer7NT7SxFO6QjSDrjOtWFO5XPsfYw/Dc5n2KP+ZylqzDicC7v1SkWg+/xQJmhP0QIdhwotRKBSgN76UiJC7WuHbSbnzvhmsozRg5i00eF2sQRb64KGpEavQKOrs/ToRVuiqA2kPPAvMJwIH03ACNG74JWtdNInD5VK0ZrEuy+JGk94ZSsCW9aOeumhFP9shv08ImRnvO6A7dY87xm5mu10xAiNLzMCSQHEQzn+aIgcaxgQ2m0HxdBLOqgLWTU6OWQdVGLbRYrLkG4v0Igq+stq0MQ3mxGI+iuBfn+IcnbJUsqOcflvPAUV2Jxi+W9pxZKEpzuBfBscRYiP5D2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTQlf2O5483jz2wncpE/q6hWf/zmCkbsCz+KM963FHs=;
 b=24tvSIDKEXf3zr3J34L5EUroK0kDEAxytv2bkxjXK5agEP/XDiQVUZdQG1ooxe6fPKJ77jeGYHgVTQjHuPDKd6Nj8/4y3wLnH5bxNFWz42Xr4rDf94LwaLvki3MfnP/WB3QUI3KMIJlKh4Mi2t67Ket0pDzXRvLLw70pbHJd6JE=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 17:55:09 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::57) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 17:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: use PCRU0 C2PMSG for Uniras on psp v15_0_3
Date: Thu, 24 Sep 2026 13:54:43 -0400
Message-ID: <20260924175443.636193-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175443.636193-1-alexander.deucher@amd.com>
References: <20260924175443.636193-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: f2332e70-b0bf-4f42-aa65-08df1a64f88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|3023799007|6133799003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: oH+DMQL79ynAiDyR42Gh7I4b7E9JJBxiwQi2eq6Bh/TewVwh8eSN7Gp0o23uTpkfDLR3WoT/bM4R4ButavhXeQMsUQte7a0wMIY+tPwf3Dm4j6UD1WySkO92LJd0RuSoMbQYs2bkQPjqJy3JD+ImC7XiKnY5LKqiT7uqJK+UUiCQEDp2FEoAlMN6tQyHtwl8NngzIv6A8dvDrU7LLn0pYjBvpobB8lfVDEDDZAiqQVwCajqNZ1t2mzQWbmeZYQ7MV0+X7jtbX+PhTb7NwRX/ysIsZmNCuxdy+gPRFWEVZFWikzVZYt5wUlVxcyffqAo8+Pbx4Rq/UdmfpKq6kxBedKSHAIUSRRNsR0AHVXDZBytgxfjF1+qgVs4OfFt25qXLTdy38iE90+a2xcgHoX1/+Kqi9SdGZE/yysEnoekOgk9wb+3FI554Oh7KEJvZNlIACMcdeXmwe5EOLILJn3+oBh9E8YHge3Yx+i5bf6j/ZYZ1WMjisMhFelneDbmCzgI1iNas7PI4PgjPIB2f8/q5nT4UCkQbfmQFGy/KurkIKLnQkufiKhu+moKnmrEImkm2jX/aIUzGVER3IL3RIgd/ITwcgpIzFLTT9mh6wxJ/U2NuLsYKaNL37MmhGpnTD1DEAPWP2C9dWSfWhab0twktTIeiayUb7uECU+aGqrhckIQazWYB7KrKhYaZ0SVs6cDmzj3a9eTwIKs4LMxNHGIYDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(3023799007)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pesuDJa93i5C2EJtbV6FRfvmwYLxKqbcAfpwe8YtnqXfcyEQ9OVF1CBd4LnQXTsEXZAghpk6Qo+0eENx8h6yO8AusIERUqOhCD6cVu8/aXAEugntvA17imqYCJXa1C8SwTbf+UYEhCxBAm+6B0NumwUx9sb1ZMy4ZunuHujxmbrOYA4Jmz7ECWmars50J+cP0QMcvA4ea0ShYcvr3rhnpb3+PKlEa9QXcMVH9mfDfhPDNOiPrI7Flic0VzHkCt1UokvbIEeVVc4RX4uYHQGRcDciuB7JTvJ/xMJHVgkiMJ+QRlKNpNuNxp3vaG3H8bCBXIRgQFPI9xsCyJ8LnpNCNhS52GCK+5x9aUl5INK3X2we7nuKv2Q8cQHKPBHxBxXp+5gucTu+NwpOmSvn2GRG+9NrK2/zgNwQdLrUbhyy6D2Y8kVuE8DzZdurVhRQJCmf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:07.7731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2332e70-b0bf-4f42-aa65-08df1a64f88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

From: Candice Li <candice.li@amd.com>

Add a dedicated ras_psp_v15_0_3 ip_func using PCRU0 C2PMSG_67/127
for psp ring wptr and RAS capability query.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile         |   1 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c        |   2 +
 .../gpu/drm/amd/ras/core/ras_psp_v15_0_3.c    | 114 ++++++++++++++++++
 .../gpu/drm/amd/ras/core/ras_psp_v15_0_3.h    |  31 +++++
 4 files changed, 148 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 2c73d0405a489..49bac67cb09f9 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -44,6 +44,7 @@ RAS_CORE_FILES = core.o \
 			ras_psp.o \
 			ras_psp_v13_0.o \
 			ras_psp_v15_0.o \
+			ras_psp_v15_0_3.o \
 			eeprom_fw.o \
 			ras_mce.o
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index f7416bf184ede..11019ee596e69 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -26,6 +26,7 @@
 #include "ras_psp.h"
 #include "ras_psp_v13_0.h"
 #include "ras_psp_v15_0.h"
+#include "ras_psp_v15_0_3.h"
 
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
@@ -48,6 +49,7 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 	case IP_VERSION(13, 0, 12):
 		return &ras_psp_v13_0;
 	case IP_VERSION(15, 0, 3):
+		return &ras_psp_v15_0_3;
 	case IP_VERSION(15, 0, 8):
 		return &ras_psp_v15_0;
 	default:
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c
new file mode 100644
index 0000000000000..f49d88369acec
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include "ras.h"
+#include "ta_if.h"
+#include "ras_psp_v15_0_3.h"
+
+/* PCRU0 C2PMSG_67 (ring_get/set_wptr), C2PMSG_127 (RAS caps) */
+#define regMPASP_PCRU0_MPASP_C2PMSG_67                   0x4283
+#define regMPASP_PCRU0_MPASP_C2PMSG_67_BASE_IDX          2
+#define regMPASP_PCRU0_MPASP_C2PMSG_127                  0x42bf
+#define regMPASP_PCRU0_MPASP_C2PMSG_127_BASE_IDX         2
+
+static struct ras_block_map   ras_block_maps_v15_0_3[] = {
+	{RAS_BLOCK_ID__UMC,         RAS_TA_MPASP_BLOCK__UMC},
+	{RAS_BLOCK_ID__SDMA,        RAS_TA_MPASP_BLOCK__SDMA},
+	{RAS_BLOCK_ID__GFX,         RAS_TA_MPASP_BLOCK__GFX},
+	{RAS_BLOCK_ID__MMHUB,       RAS_TA_MPASP_BLOCK__MMHUB},
+	{RAS_BLOCK_ID__ATHUB,       RAS_TA_MPASP_BLOCK__ATHUB},
+	{RAS_BLOCK_ID__PCIE_BIF,    RAS_TA_MPASP_BLOCK__PCIE},
+	{RAS_BLOCK_ID__SMN,         RAS_TA_MPASP_BLOCK__SMN},
+};
+
+static uint32_t ras_psp_v15_0_3_ring_wptr_get(struct ras_core_context *ras_core)
+{
+	return RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0,
+				    regMPASP_PCRU0_MPASP_C2PMSG_67);
+}
+
+static int ras_psp_v15_0_3_ring_wptr_set(struct ras_core_context *ras_core,
+					 uint32_t value)
+{
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP0, 0,
+			     regMPASP_PCRU0_MPASP_C2PMSG_67, value);
+
+	return 0;
+}
+
+static int ras_psp_v15_0_3_get_ras_block_maps(struct ras_core_context *ras_core,
+			struct ras_block_map **blk_maps, uint32_t *maps_size)
+{
+	if (!blk_maps || !maps_size)
+		return -EINVAL;
+
+	*blk_maps = ras_block_maps_v15_0_3;
+	*maps_size = ARRAY_SIZE(ras_block_maps_v15_0_3);
+
+	return 0;
+}
+
+static int ras_psp_v15_0_3_get_ras_hw_caps(struct ras_core_context *ras_core,
+				struct ras_hw_caps *ras_cap)
+{
+	uint32_t ras_hw_cap, bit;
+	uint32_t i;
+
+	if (!ras_cap)
+		return -EINVAL;
+
+	ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0,
+					  regMPASP_PCRU0_MPASP_C2PMSG_127);
+
+	ras_cap->poison_supported = (ras_hw_cap & BIT_ULL(31)) ? true : false;
+	ras_cap->flex_mca_enabled = (ras_hw_cap & BIT_ULL(30)) ? true : false;
+
+	ras_cap->features.value = 0;
+	for (bit = 0; bit <= 29; bit++) {
+		if (!(ras_hw_cap & BIT_ULL(bit)))
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(ras_block_maps_v15_0_3); i++) {
+			if (ras_block_maps_v15_0_3[i].ta_id == bit) {
+				if (ras_block_maps_v15_0_3[i].ras_id < MAX_SUPPORTED_RAS_BLOCK_ID)
+					ras_cap->features.block_mask |=
+						BIT_ULL(ras_block_maps_v15_0_3[i].ras_id);
+				else
+					RAS_DEV_WARN(ras_core->dev,
+						"RAS block maps v15_0_3 error: invalid ras block id %u\n",
+						ras_block_maps_v15_0_3[i].ras_id);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+const struct ras_psp_ip_func ras_psp_v15_0_3 = {
+	.psp_ras_ring_wptr_get = ras_psp_v15_0_3_ring_wptr_get,
+	.psp_ras_ring_wptr_set = ras_psp_v15_0_3_ring_wptr_set,
+	.get_ras_block_maps = ras_psp_v15_0_3_get_ras_block_maps,
+	.get_ras_hw_caps = ras_psp_v15_0_3_get_ras_hw_caps,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h
new file mode 100644
index 0000000000000..2bf870f0a87cb
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0_3.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __RAS_PSP_V15_0_3_H__
+#define __RAS_PSP_V15_0_3_H__
+#include "ras_psp.h"
+
+extern const struct ras_psp_ip_func ras_psp_v15_0_3;
+
+#endif
-- 
2.55.0

