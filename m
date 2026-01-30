Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D01D49C7C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A75F10E96E;
	Fri, 30 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kCRuLzji";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4CC10E970
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhxPcD9exsknClq516Mlg7Rli/WR1nDlieh1WIinUwIwxnNQwyC4cq61TBz5ym5SmONtrNZcK1IqO+4Jdjm3z6cyqDWs/RVm1K0KMRKVrTWGyyWzX6X4KKHbyvUmvqQBtNNtuNYRmoxCvNzH0wS01tIajOJ0gqg+R6Z+MAO5ByT3Ok63yv9kf6DZBnxKznGnA+OnQ75rzMAiPBldqYW73SQ6g2qMovMjFX9hF9kWwgVPn6MqX/JRJs95wHrWIwfEaaURv8nhvM4xpBa0xBoi6Qj/Oo2fxlMC4vPVN5RWttHH+R14xDg96PdmNwuAOJFxnJynAB3kb/f+HZSrAexNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YyDH3azkqpHeLl0D3ljtIsn39JJ0Tp/PNRDXT3fNTY=;
 b=TxIoa/odJjUJr642fXg+TbThVjQU64JiWjB2873Uwk89NAS7Bv8rRi/bVQOags3s93EEhjPCrEiFz4J7mjNXdPMn8J0Et+ukkaeZVn9F0nqnagPOd5eiwJrgvGJIu20whXNJhVbzy41WLoLT/jNGmaCClT+AZxsfDtMxZ0oRVL+CvWpAd0d1tMOubX56dfBuV0cJN1EDWMrmkJ9VX7mTwYyopFgdw6szvC54Ko+3Wy9YBHumgvcuARntmTqctAZs2I06AZL3EPYfhWXmb3Duy4dnRFRD41ld14AdRYJ+cA9I6j81ATj6DxcXzcGIvl0tCdM6tWthIxdLj1opKGsSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YyDH3azkqpHeLl0D3ljtIsn39JJ0Tp/PNRDXT3fNTY=;
 b=kCRuLzjirgSZGx8qdoAUf466/XIeqKnatDBXsgoRjaPEUaWZSIWcNYQWVcaSMGJ9GegKWoe/vJygb2LAKvq52CXuTHAQqNeou36Fe1H/F3KaSwPu9dRSw3ykAJ5kNMWyvHmJVslxL0ZLMndOeuAT7ZyPGbfXhgU2FUmdTqvznM4=
Received: from BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:09 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::5d) by BYAPR05CA0055.outlook.office365.com
 (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 08:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:05 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 02/11] drm/amdgpu: Add cwsr functions
Date: Fri, 30 Jan 2026 14:07:56 +0530
Message-ID: <20260130084137.2906792-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8f130a-4dd4-43b9-a5fc-08de5fdb74ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/GWb/tXUMXnxR4Vi2s6oJFQ4FcNyeb9X4rbecNFyFuqJK8dBzoGNiSSR2l1q?=
 =?us-ascii?Q?9WWjarwwPC6/oR5PuDfglYKv0NZAUAbVMOOmbvK+TqamMJtdPyiSiF2NnvhR?=
 =?us-ascii?Q?hVEqJHsRRaGE2t79mAtuIxgGP4EOP9M7Wl5cFvr55b87Mxyw4Ab278jtSmAB?=
 =?us-ascii?Q?Kxknf9W9Y/ZK2J5ggxnr4RdASd1fW1tSaBCT4q5JDFYFOem0D30WErpInr3W?=
 =?us-ascii?Q?6dqeJHnORopaN4+hKV+vjEcpyi5Iz/p3ZwSlLGgqu9bXi4FVtHxx/h/r9DqP?=
 =?us-ascii?Q?rHW4EUbWKWtTlyuRc5zpssm+/p0RMJmtU07dG9Mt07jtfMK/Z5Hn9VWXYlfn?=
 =?us-ascii?Q?FSxg0zKLUk04npflfKg/TJbSfRePmMR/PJafipIs/LjMdax1weYfJVyieW0t?=
 =?us-ascii?Q?l5dwj9nej55uv2iPk8uI1I89l957DtyUdjhqUARfZxIpqkRQE116vUARDQ8V?=
 =?us-ascii?Q?BCW7tWr6GTauKYQdh1UARVDTIyFepxAI7GvO1RlSheyWevgEnuvlBQWwjZNT?=
 =?us-ascii?Q?HV/CGHcUK5yhnNltwqUKFu+VNNWyAW3rPnCOM3stGp8ouUO5Djmn5m8FXZ7Q?=
 =?us-ascii?Q?NjPpCEMvgfXqiR8PGGdQcKLBwyoCOEeNLmLQXAjHX9gAQztRr96Rm8NdXZTs?=
 =?us-ascii?Q?BmzU1/gm5+fwNt6f6WO57IWVcAJ6HIySSfwUVCDxxyvD+QwIIXxitbbNhG+O?=
 =?us-ascii?Q?DRDcj39m9DdiWPuMDXe4wVmfyf7DHJBdzmK3S2KFLuaYHnDRtJSpfhViekr2?=
 =?us-ascii?Q?cR3TwN08rWp6XYu7zJm871iqIXQOTLMOMSnh7owrkts2PFxsNKymv4+NAxIG?=
 =?us-ascii?Q?Jot0Ag+txLN67DTXaNwkYTXq98M+ip4KWsgDTETa0EgaJR8LCRLrSIOi9Ghe?=
 =?us-ascii?Q?gtjP2QVAfAc2MbNYrrfmTClwJV/i1gr8UStVkZCCIP90o5YKSIg+96/JTHFB?=
 =?us-ascii?Q?On6TGSBV9tQVzo1gZ4G2FgDzv5KTHtUNIIMAaXMaQBJf4CG7AAx3DG/wOhQv?=
 =?us-ascii?Q?ZJuE66kBf+hJUvsrgL8oyXVkif5MjVP3MF2PknuhMCdN99vh8aeArU2V52ax?=
 =?us-ascii?Q?QuHzt3Utq6PhLDHUlGSrjIjsr/+yBkefYB9IYWJ6VviN+bkUgjuCczpmeXUO?=
 =?us-ascii?Q?bdYPm9jcEiNAagHLh/RpK8HeQL78Xfauad/b6QaZsV1kZwAF04voZyXUYI2P?=
 =?us-ascii?Q?tlRhIpBlLnoy+dS8pQEgXxNZD+sJVElGSZlhNYmqP15Fy0DNBUKDBhCPM8DR?=
 =?us-ascii?Q?sK1QFoGrcJ03wrvZzVgLJSzTLPDDMhfJii4FqrCOG48NsEehVcx+ABvVunin?=
 =?us-ascii?Q?ms/h634wtYoxwiOU+nyavJ964VlG/PKJVA2ROAbP1/k31PPejtadmmqWGTE9?=
 =?us-ascii?Q?w0Fz/vSvur4PlS8ZRnZO3Mi+aZzCbeRU2ZWN5+HHe0xdCdB6b/iEYSQxKxDb?=
 =?us-ascii?Q?IzmrcCM2yp71orE/zdD2rMV1SFuHuSPaWdiaQYVKP2Q4zzR2lvfaWNpG5ApK?=
 =?us-ascii?Q?5P2YW0njEt5d5blJSMFep+G8q2ycTy8l5nMp0AbYG2grZFZXhHC2TTfRXhX0?=
 =?us-ascii?Q?iT6fH4FA4XZ9r+GLZ4HZ9x8sYC1Wss4M400Zx8adqNy76LyLiva5MAXj0KiW?=
 =?us-ascii?Q?otc+q660EezQmZVHotHz53z5ooiyM2jdHKH4kkOxstHquDuOYVk0xc9XlCeN?=
 =?us-ascii?Q?v1DG+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q/L7LKGGgooFB7H4uhHV4ecpBWQaCJMa1mfy3FcQdcHgiTxcNL5JNr8DoMse/kWapQkD4OiGqk5tm/9g3YLjW+6FDTMj+JVoQ2dC6yebH+7A2nLSRNq6YcNPh55OPPUXWGEWWLh2f1RgZZNGYHKlDzr7BoOPKTFnfNtY60Pu6ktRoyh5I9rvYF/pPq7CvmYe3Mw5isOs8dcFMIh9/Viw2vg1CvvQWldyDbXN7tpVYw16QLnUi8jQL5exjTJfU3UYmUK6XNVud3p5wHdguHFEy1R4jeQ/4R6lVfeVrPZ075/C2Dxf9aPenm91ZAu4eJDkqdEhI+uCXKUXN76vPwQ1HhFFnBVZUK4Q8/hETF6Xh0T9NQMLb0olF14Mx8Mz08aAe3s9ZnlVSSv8uqVy06yRzRVGItgplCWmU+y9Zb/rZYFTMk2Udw+48uh/83PKQMVa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:09.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8f130a-4dd4-43b9-a5fc-08de5fdb74ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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

Add functions related to cwsr handling inside amdgpu framework.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 364 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  67 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  13 +-
 5 files changed, 445 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8e22882b66aa..3b563c73bb66 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o  amdgpu_cwsr.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c11535c44c6..0ace28c170bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -328,6 +328,7 @@ struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
+struct amdgpu_cwsr_isa;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -1237,6 +1238,8 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	struct amdgpu_cwsr_info *cwsr_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
new file mode 100644
index 000000000000..f2d3837366bf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -0,0 +1,364 @@
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
+#include <drm/drm_exec.h>
+
+#include "amdgpu.h"
+#include "cwsr_trap_handler.h"
+#include "amdgpu_cwsr.h"
+
+extern int cwsr_enable;
+
+#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
+
+enum amdgpu_cwsr_region {
+	AMDGPU_CWSR_TBA,
+	AMDGPU_CWSR_TMA,
+};
+
+static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
+{
+	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
+
+	addr = amdgpu_gmc_sign_extend(addr);
+
+	return addr;
+}
+
+static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (!cwsr_enable || adev->gfx.disable_uq ||
+	    gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+
+	return true;
+}
+
+static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
+					 struct amdgpu_cwsr_info *cwsr_info)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
+		   gc_ver == IP_VERSION(9, 4, 4)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
+	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
+	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
+	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
+	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
+	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
+		/* The gfx11 cwsr trap handler must fit inside a single
+			   page. */
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
+	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
+	} else {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
+	}
+}
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
+		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
+	void *ptr;
+	int r;
+
+	if (!amdgpu_cwsr_is_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_info)
+		return -ENOMEM;
+	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
+
+	if (!cwsr_info->isa_sz)
+		return -EOPNOTSUPP;
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
+				    NULL, &ptr);
+	if (r)
+		return r;
+
+	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+	adev->cwsr_info = no_free_ptr(cwsr_info);
+
+	return 0;
+}
+
+void amdgpu_cwsr_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return;
+
+	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
+	kfree(adev->cwsr_info);
+	adev->cwsr_info = NULL;
+}
+
+/*
+ * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
+ * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
+ * compute queue can use this virtual address for wave save/restore
+ * operations to support compute preemption.
+ */
+static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  struct amdgpu_cwsr_trap_obj *cwsr,
+				  enum amdgpu_cwsr_region region)
+{
+	uint64_t cwsr_addr, va_flags, va;
+	struct amdgpu_bo_va **bo_va;
+	struct amdgpu_bo *bo;
+	uint32_t size;
+	int r;
+
+	if (!cwsr || !vm)
+		return -EINVAL;
+
+	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
+
+	if (region == AMDGPU_CWSR_TBA) {
+		size = AMDGPU_CWSR_TBA_MAX_SIZE;
+		bo_va = &cwsr->tba_va;
+		bo = adev->cwsr_info->isa_bo;
+		va = cwsr_addr;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			    AMDGPU_VM_PAGE_EXECUTABLE);
+	} else {
+		size = AMDGPU_CWSR_TMA_MAX_SIZE;
+		bo_va = &cwsr->tma_va;
+		bo = cwsr->tma_bo;
+		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
+	}
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va)
+		return -ENOMEM;
+
+	va &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
+	if (r) {
+		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
+			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do page table update of %s region, err=%d\n",
+			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	if (region == AMDGPU_CWSR_TBA)
+		cwsr->tba_gpu_va_addr = va;
+	else
+		cwsr->tma_gpu_va_addr = va;
+
+	return 0;
+}
+
+static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr,
+				    enum amdgpu_cwsr_region region)
+{
+	struct amdgpu_bo_va **bo_va;
+	uint64_t va;
+	int r;
+
+	if (!cwsr)
+		return -EINVAL;
+
+	if (region == AMDGPU_CWSR_TBA) {
+		bo_va = &cwsr->tba_va;
+		va = cwsr->tba_gpu_va_addr;
+	} else {
+		bo_va = &cwsr->tma_va;
+		va = cwsr->tma_gpu_va_addr;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
+			r);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, *bo_va);
+	*bo_va = NULL;
+
+	return r;
+}
+
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_cwsr_trap_obj *cwsr;
+	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+	if (!vm || !trap_obj)
+		return -EINVAL;
+	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
+	if (!cwsr)
+		return -ENOMEM;
+
+	bo = adev->cwsr_info->isa_bo;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve for CWSR allocs: err=%d\n",
+				r);
+			goto err;
+		}
+	}
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
+				    &cwsr->tma_cpu_addr);
+	if (r)
+		goto err;
+
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
+	if (r)
+		goto err;
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
+	if (r) {
+		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
+		goto err;
+	}
+
+err:
+	drm_exec_fini(&exec);
+	if (r) {
+		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
+		kfree(cwsr);
+		*trap_obj = NULL;
+	} else {
+		*trap_obj = cwsr;
+	}
+
+	return r;
+}
+
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_bo *tba_bo;
+	struct amdgpu_bo *tma_bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
+		return;
+	tba_bo = adev->cwsr_info->isa_bo;
+	tma_bo = (*trap_obj)->tma_bo;
+
+	if (!tba_bo || !tma_bo)
+		return;
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec)
+	{
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve CWSR BOs: err=%d\n", r);
+			goto err;
+		}
+	}
+
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
+err:
+	drm_exec_fini(&exec);
+	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
+	kfree(*trap_obj);
+	*trap_obj = NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
new file mode 100644
index 000000000000..26ed9308f70b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -0,0 +1,67 @@
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
+#ifndef AMDGPU_CWSR_H
+#define AMDGPU_CWSR_H
+
+#include <linux/types.h>
+
+struct amdgpu_bo;
+struct amdgpu_bo_va;
+struct amdgpu_device;
+struct amdgpu_vm;
+
+/**
+ * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * @bo: Buffer object for CWSR area
+ * @bo_va: Buffer object virtual address mapping
+ */
+struct amdgpu_cwsr_trap_obj {
+	uint64_t tma_gpu_va_addr;
+	uint64_t tba_gpu_va_addr;
+
+	struct amdgpu_bo *tma_bo;
+	struct amdgpu_bo_va *tba_va;
+	struct amdgpu_bo_va *tma_va;
+	void *tma_cpu_addr;
+};
+
+struct amdgpu_cwsr_info {
+	/* cwsr isa */
+	struct amdgpu_bo *isa_bo;
+	const void *isa_buf;
+	uint32_t isa_sz;
+};
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev);
+void amdgpu_cwsr_fini(struct amdgpu_device *adev);
+
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
+{
+	return adev->cwsr_info != NULL;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..9bde17815a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -176,10 +176,17 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
+/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KFD mapping that needs to be
+ * resolved. Revisit later.
+ */
+#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
+	(AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ_SIZE)
+
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
-						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
-						 AMDGPU_VA_RESERVED_CSA_SIZE)
+#define AMDGPU_VA_RESERVED_TOP                                            \
+	(AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE + \
+	 AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
-- 
2.49.0

