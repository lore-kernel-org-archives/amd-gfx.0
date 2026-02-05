Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801FEE91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F2C10E385;
	Thu,  5 Feb 2026 06:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sc+LSiCO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9790F10E385
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdNMKzNWdC/9JgjORvFYYOmGS12TZAT8MDPF5xNMYKvFZaSmq7NakQU6L11YtiS8WKCFUezPx8HJ1H5M9pD7WIPUVJnKPmnOAPuVNm4cXZC19wfAIjK3qZTZxaD5licO/EoqVoMfmTaDsHDKov4aGtRWk7beu1KcLbMuHL3LD+28kAjze1dCtveL02HCzxpfnzAG6XYWRe9LcbkEpzCCy8tjQE7Jb2YFLm3nqosaMzTxK1lUzaS/3nRMi/xML/bn0KIzIXf1uc1gw+AkrzZqnxi7r1UW1Zp6epmB7F1c8Qw7DSSyoZxIUv18dWwZK5Cf33aXYPwogYDszrVY9HWi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1BTuzU7GWgmmQND4X9EjmvzNsRahvq6TFqR+xFX3PU=;
 b=qd+Z9+F7NKQtpzUAtGkSRwB/wYEyOXSBtZZdtbsvO83Ine7TaSSedb7qmTBhpo3+tFCqqZe+dphgE2nj/iGYiOyseCewkTzUfbeuzfLQo/89Vhe0rwx6SSfl7if6Y3ARptSKThbgmKU1JewOGz8Q7+8N86+kaWYCHQFxuD/JqtUQCjrMpBbk3Jkm2PN7qvIB5xjdlBGKXtodENgrzm4nvZ8OyQwSU6p3tYinSl5t1I3KYE98491ZBRgMJxIUWMJSmd94Jh4cOyB/djYIx2BzsCGXe39EHwxGWxMuppDCCZ6h5Xiwgr4vTI31ralUqGhw8uIi/Rl6HLBkF9jZC4g/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1BTuzU7GWgmmQND4X9EjmvzNsRahvq6TFqR+xFX3PU=;
 b=Sc+LSiCOsxhOlLDDn53K2G2SBrzeefpuPYxU55F/NJYjhBPr6tPEPogoPDDe1ecm6LVWj+sshCjEpuZT65o+Ns1+WNqHXN4qwTV9b0NklqQ92inn9GCLUZFDKsqCvSF0KLDvCCHM9DJedyydxi26CmpaaKUjgM9lFk8lvkiIjRY=
Received: from CY5P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::34) by
 BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:18 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::a9) by CY5P221CA0062.outlook.office365.com
 (2603:10b6:930:4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:10 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 22/22] drm/amdgpu: add amdgpu_ptl.h for PTL format and command
 definitions
Date: Thu, 5 Feb 2026 14:51:30 +0800
Message-ID: <20260205065130.654921-22-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dadd1e-3dd6-41e9-d37e-08de64831a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pvCsVRCN6oq+NHzhhirKvyZGbAWGBNU8ImH7Vg46vgD0M5trS+FEnN73wFjh?=
 =?us-ascii?Q?xALZw2zA1X6XCItCa/HzQgCD0jr0//fCXDcqgPzFeN63Wt26in6M/GcNpAEy?=
 =?us-ascii?Q?B12pIwv172Ge/vB3HfZkYIskuwY9s+HqPUvFyewlGm5GzZPDjuZuEK3zcbxn?=
 =?us-ascii?Q?PtUjbwIn9OmOl9hwJezDK3m2PX0YAX/UBqdUTvI0DuXcacNdAptJqaTdfgBZ?=
 =?us-ascii?Q?Se6+VSi7CtcEyTkV28JskyhP13IJLWwQgm1Xyk6EZjPBG30Y7OqJOQ7wJMhp?=
 =?us-ascii?Q?U3p3QlE/JDaAx4EUs/nTtpTnHWNh96A13suuQRL6wRgwljvUh8R4MMWt2MDK?=
 =?us-ascii?Q?leWCkioL2GpHG8rtETs7T9Nj4Clv6QaP9YNGWU/qE5WiP/JQX4M6Ee9MUBlg?=
 =?us-ascii?Q?sjwQ60vICM7/OFmelZ3Zrk7XMLMB5/XXrscJV3pXOOWR+IFzWnRTJq4BMZ+s?=
 =?us-ascii?Q?lyDCRtJsT5jbWDBXva60HEhY1s/C4LAkmyTWIcc3yHgFcca1x4cxLIATFw55?=
 =?us-ascii?Q?dmrOISRq0IjqJxKzubiaAaIq3dx/oGdjM1Kk//nf4ZYveoAVXeE+ERC6BEiO?=
 =?us-ascii?Q?LmDeHzu8b/f6cwoyBIZhyi1NBQWBvKS04r9+9DGB7xG9qlva0lEAQkHYA8pP?=
 =?us-ascii?Q?SB748TgsCJ04fjIAxOIqMcojwy87Mfw3sfJsgXY1SEfUbFNINoAlJ5Qz8I9l?=
 =?us-ascii?Q?51g3FFjRbv69VFYmd+MFw7oEeR3N5xO02mFXUblaH2dRya2RBOKY5GfRUarG?=
 =?us-ascii?Q?utHgpS7ehymafu74lOYSq7UB1em3q944Yw+XV2p9zPk0GYa6gaK1Q56lD2oj?=
 =?us-ascii?Q?kQJgQjsCBR9RPjWfQ9Te44gyFJVLbhpFcc8TKaB5MWYtSfENgTHWp96i02k0?=
 =?us-ascii?Q?8zFeMQu/Db19S7rrMiNASaDB18+wPVfW5SLL0zF2ilQJjQTRAe7Wc1sNpdxT?=
 =?us-ascii?Q?FxOqgfA3VaIwYYooM+n8BoTK+1NX1exPjEdgfbMH+63Dy3Q8I8KuVvGF3CAM?=
 =?us-ascii?Q?sbvGU3/2T9+EMrXWt5jkHPLdgkK4LUX1VVBkYD5X0Wx+vSAZhRNKBl81DLX3?=
 =?us-ascii?Q?8fjtfEGFE8JsoLFqWyw1vmCPEr7xurQNui7bG6VjxcqmE+38amQN+68OVanq?=
 =?us-ascii?Q?dz/xCklfjgJsVDGId4VSbWENW2PDCM0j8nfa8criRqVVAGoNosnmCZOFJP5u?=
 =?us-ascii?Q?Qb3gQWXt0fO3CX0sHVKYMITm4yKyQI12MIEfIFFoC/8AHdsXzLOkMM0ZxcI3?=
 =?us-ascii?Q?rSC/BYaeyA2s186AsjBm4CLuSwg6ocl6ldkvzoNKtJcT7pfOy6MBqN7LzVOT?=
 =?us-ascii?Q?jeu1xojMsbkyj3UzL5EoUZ/yhLSler9/cEY5YwktXdAlr6dmn9zCY67MXHRy?=
 =?us-ascii?Q?GIQf4elaXpp5Yl7K4a7rgGqMTFcBUSS3Cb+oBYWe/uLlgQFpDiKSYjcRywPb?=
 =?us-ascii?Q?zaAX9whTtKICU2GUAQTFlFZIZ3QSHLrc1qOMeMdTdTU4peOG7ZVtgjAfg8ZE?=
 =?us-ascii?Q?SPEYvhPvbQw9avCtNedh6e1e+5oNWdF8Cq2lNIqUJlj4Zbf3riF26Ny601hG?=
 =?us-ascii?Q?vpzVXRZPmsJLRaHPrcXqObu5iEhpk0LIY3VNuVCt3qzJHCQ8OlWOUWciMPlq?=
 =?us-ascii?Q?iht7NL4aLBQDZ5ryX+CPZskYNMN21SVtvly16w8VJgqEhwmAJZ0AMMLchXkc?=
 =?us-ascii?Q?bA1BaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QFh376pr4lL9ybiIMC84XJmvXfRfNRcFyqLjsPgCPHi4W7ud3JfU727P+mwvH59zIDTt+FhBdr49TBdPVo3NSJmTqOub2wLT1+JoxfQVVT6iJRwAXv9Gpvx1WxsGsWQ1K7qKXI079rXw0bDbg06e2cMy0Vais53bDWXOMrlkYmjiP8VYGMyinapY/iBE6WmccRFjkVUifNwuRqVpqc3AvYl2NiPGLpGOXXFal2CSCdKt9coG2sSUnADtSvhyRltbEpmQStLElcxR0/+DAQeINg8U5NBlBTSMM0nBhFB1g8DUjbS50H9GgMnoe4etA7/vQoUdYmuFqqjbJwuck0J9OsRpwAFBz1qYEkZgdWrLju0uDT4kgpTrTFhU8mkreNpMa61ZmDerQt7rhjpTYC5If2uHkxEAAod3tL/f2Ody7NgHnSJZOATKt8VNyRkOK/vf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:17.6921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dadd1e-3dd6-41e9-d37e-08de64831a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

Collect amdgpu_ptl_fmt in one header so both GFX, KFD and PSP drivers
can share them without duplication.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       | 23 +------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  1 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h      | 60 +++++++++++++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
 include/uapi/linux/kfd_ioctl.h                | 11 ----
 6 files changed, 65 insertions(+), 33 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..4fee011c2e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,6 +38,8 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_xcp.h"
 #include "kfd_topology.h"
+#include "amdgpu_ptl.h"
+
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 enum TLB_FLUSH_TYPE {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c6a896003596..562f731bf16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -32,6 +32,7 @@
 #include "ta_rap_if.h"
 #include "ta_secureDisplay_if.h"
 #include <linux/bitops.h>
+#include "amdgpu_ptl.h"
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
@@ -64,7 +65,6 @@
 #define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
 
 extern const struct attribute_group amdgpu_flash_attr_group;
-extern const struct attribute_group amdgpu_ptl_attr_group;
 
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
@@ -385,24 +385,6 @@ struct psp_ptl_perf_req {
 	uint32_t pref_format2;
 };
 
-enum amdgpu_ptl_disable_source {
-	AMDGPU_PTL_DISABLE_SYSFS = 0,
-	AMDGPU_PTL_DISABLE_PROFILER,
-	AMDGPU_PTL_DISABLE_MAX,
-};
-
-struct amdgpu_ptl {
-	enum amdgpu_ptl_fmt		fmt1;
-	enum amdgpu_ptl_fmt		fmt2;
-	bool				enabled;
-	bool				hw_supported;
-	bool				permanently_disabled;
-	/* PTL disable reference counting */
-	atomic_t			disable_ref;
-	struct mutex			mutex;
-	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
-};
-
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
@@ -679,7 +661,4 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 
 int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 			       u32 *ptl_state, u32 *fmt1, u32 *fmt2);
-int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
-void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f375dffcbdf6..eacb2ab25a6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -44,6 +44,7 @@
 #include "kfd_smi_events.h"
 #include "amdgpu_dma_buf.h"
 #include "kfd_debug.h"
+#include "amdgpu_ptl.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
new file mode 100644
index 000000000000..19eb8f6a765c
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -0,0 +1,60 @@
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
+ */
+
+#ifndef __AMDGPU_PTL_H__
+#define __AMDGPU_PTL_H__
+
+enum amdgpu_ptl_fmt {
+        AMDGPU_PTL_FMT_I8   = 0,
+        AMDGPU_PTL_FMT_F16  = 1,
+        AMDGPU_PTL_FMT_BF16 = 2,
+        AMDGPU_PTL_FMT_F32  = 3,
+        AMDGPU_PTL_FMT_F64  = 4,
+        AMDGPU_PTL_FMT_F8   = 5,
+        AMDGPU_PTL_FMT_VECTOR  = 6,
+        AMDGPU_PTL_FMT_INVALID = 7,
+};
+
+enum amdgpu_ptl_disable_source {
+	AMDGPU_PTL_DISABLE_SYSFS = 0,
+	AMDGPU_PTL_DISABLE_PROFILER,
+	AMDGPU_PTL_DISABLE_MAX,
+};
+
+struct amdgpu_ptl {
+	enum amdgpu_ptl_fmt		fmt1;
+	enum amdgpu_ptl_fmt		fmt2;
+	bool				enabled;
+	bool				hw_supported;
+	bool				permanently_disabled;
+	/* PTL disable reference counting */
+	atomic_t			disable_ref;
+	struct mutex			mutex;
+	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
+};
+
+int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
+
+extern const struct attribute_group amdgpu_ptl_attr_group;
+
+#endif /* __AMDGPU_PTL_H__ */
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 295ce9364362..44e225e097d0 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_ptl.h"
 
 struct pci_dev;
 struct amdgpu_device;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 905acff01700..32550e581673 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1558,17 +1558,6 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
-enum amdgpu_ptl_fmt {
-	AMDGPU_PTL_FMT_I8   = 0,
-	AMDGPU_PTL_FMT_F16  = 1,
-	AMDGPU_PTL_FMT_BF16 = 2,
-	AMDGPU_PTL_FMT_F32  = 3,
-	AMDGPU_PTL_FMT_F64  = 4,
-	AMDGPU_PTL_FMT_F8   = 5,
-	AMDGPU_PTL_FMT_VECTOR  = 6,
-	AMDGPU_PTL_FMT_INVALID = 7,
-};
-
 #define KFD_IOC_PROFILER_VERSION_NUM 1
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
-- 
2.34.1

