Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9A0CF2562
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC51910E53C;
	Tue, 18 Nov 2025 22:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="goDtPOAX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4410F10E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZyDZG+Lg0RNrvNscdhQfQpeaso20K5CToPR7h7XSXt2veS/g/IWde5GDD93QFIMY6w4glNmyMELl4w/LeU+0WeBjfdn3no9Bz8h21b2C7qRLV9kguEhbJMSPcaY5Uk4/ButPm2JWIkhp3xN1visoOOYto3To4eFir4+nlXs0M3xWxgmHkhwF7DSi7d2Tue8UQoGFGYY54UHo1/k1WYOYjIEFmwbh55NB+ivZ/JyHe8IGg3U1/S6+nPqFT1Z7eUhagTWv3Pcg9meHM9QtRtdfCANg31G3sJsx8jP+5tB6sksWzwDf43+zIGlnt0Jc11oshdkx5VeKeUUIVo+g+diLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDO0mjIwVDECiaYmYOTWgmAAlQIxJsB6Vl4bpjH9S50=;
 b=sX7qeBIecNP4M9n1GHIauZe2IzTG1MhizOMNdFxCs2PoGKh3NJVEXOkhzUpj1b/xfJJmfIzJyoftpWjpFf/ashWqsSF7FVl8vOPXp5B20+Mlnck/n1bE9MFgLmA4fcBAWwwcdY0fYZAzQGMSCEZTnFcfmwg15j1Gb4P6mMJNqOuHmVoe/9e1bOJ1RA3SbbTVFvQrXQfyjRirMtznoGEjoSC6Qw3gH9VKmxPo4CB3XV9dzw+YaQ2fV+HZH2jxDJQt2wESLJNGLzyq17Zh6EFlFObwggZKKNFa5mi9q9ec6LB1X5VDSaMbjkIwPU8MELG2bFtJdBVAhnmR7CX3q268nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDO0mjIwVDECiaYmYOTWgmAAlQIxJsB6Vl4bpjH9S50=;
 b=goDtPOAXzcNG7kcksdtMzVqKZ8T42QKzZmWBDTfWIElkILlEWvCDZLIjntQ8vGKE07wayxcezu2ur590LHuENJhdQzzqDDX9P7xMwZFQMJfQzFPXsRf7P/pg2A2YG6OsjiXDFG0uFjbDVKJ4JksTb60o/ntryzIYwx8VcexCm9w=
Received: from CH2PR17CA0016.namprd17.prod.outlook.com (2603:10b6:610:53::26)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 22:58:04 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e6) by CH2PR17CA0016.outlook.office365.com
 (2603:10b6:610:53::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:58:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:58:02 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add psp v15.0.8 ip block v3
Date: Tue, 18 Nov 2025 17:57:47 -0500
Message-ID: <20251118225750.3613219-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225750.3613219-1-alexander.deucher@amd.com>
References: <20251118225750.3613219-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae00fd2-3877-4e1e-1f57-08de26f5ee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WX+utQLOUiBk1STY5K5WzMoO/Ir1bqx9rX7FxNZJMrWp1AN3US/slLdzL6CA?=
 =?us-ascii?Q?ZIvvHHPPqS4kLA4nSFVcfqwIiM7RMtQhI5FNQ88RS7XFwK6VigtKfYp7OPWD?=
 =?us-ascii?Q?H71S7vcDQBu2mfuR3vMBQX2Pcs7dSNgxigE8LnRcO2k8wup8WpWWW67oJZcL?=
 =?us-ascii?Q?IWRozI2CsKCqGe8dtPXaHC5FuhxQePgzAnRnou/sCeJKisUxJvvgZIs0kTpu?=
 =?us-ascii?Q?zzesCLYmywVfffgs2AQ64CIqj0Xa8Ft34Gw07UtdUpXsDwLcV3l5ycNWqts1?=
 =?us-ascii?Q?NS5dK81Eqfx44XgR+Q5Rx1ruK4384LjOZzUcS0+5Sugf1+EO0cp1iz24eUhS?=
 =?us-ascii?Q?TaNW/oegkv/UlHHq3vaszeWjomuNl6P/qFE7Afb70xfi9qhgLRY1oqWVtE1a?=
 =?us-ascii?Q?nSUHauSZ4iAcUMhJclO9PHDDhYvPxH9xVbX+mXm5SjW/xRldQq9J2mWBw0Z8?=
 =?us-ascii?Q?hp1CXZaLny5xw3MSVyOUm4NwKvhu3S6PG0dW8j2HLXdY5HcFztzPMXjolE6u?=
 =?us-ascii?Q?30rB2DgJ57NHfkHgC1qrD7YEWRlTTxowte2CvqdlHcLhtZOfDwSdy0CC+zyS?=
 =?us-ascii?Q?Odvejk3bqiGqypMl2/bxRFtSO6xg6jkjSrkK+8la75AiflLQ04Z6Ti0VdgNN?=
 =?us-ascii?Q?IPQmornfmhaOvcRLuzraj1werhOOaOXmLYiwiudJ8JyxT3pTFnHmnlyXCDgT?=
 =?us-ascii?Q?zLau+wkGxrDjTD0Ea7aDSHfBYTuzf/4+3qO2b7/uI1PHdZZZx4TqlwYlVAl9?=
 =?us-ascii?Q?NJIe4Cpqg7nfU+DkjQbtMaF+u1t6gx42JHwFpjfsOJV+ox4192PZjtwHAOyq?=
 =?us-ascii?Q?Qqzuf8mPRTUI2rR3bDD3AiMQJnF/wjkaI49ygJk16H9jRb2p4zfI6NOS2tWj?=
 =?us-ascii?Q?RTE9gcUYUlHvFpyFogXmZEmM2RDT7TySsapcplnj182u16CiBUQVjEkmW/59?=
 =?us-ascii?Q?9UtalVe0LSTb0sRCpd1FngaBhm/stPkgOi2PxEmDIGRyYoRHXSGrU+n12esu?=
 =?us-ascii?Q?dDbRHaiAN0Yi48CwwIjqGDbFKKriMsDG7qRbHNOfNLGzJ8NJvMoq1ZWflmOP?=
 =?us-ascii?Q?LNOH0Ew8NlKy3eoz0+XL8BrA6ZwCOdhRCVzMBOV+dnn7azSlUh+r/xKUluJ7?=
 =?us-ascii?Q?i2sR+ETW5vm7jbYI2Cxk1W1MCCHPnhMByHjBTElZx0NLyv7uh4wTcuCJ2owJ?=
 =?us-ascii?Q?BoLMT6IShYWKPVdh5Mtx6Hoj5vIUMIcXrcXvWgEAF4QBRb0MoqLfwhgRXGVA?=
 =?us-ascii?Q?tsEmKA8N83q/KR8imVRCYi/s4emCurMrwKoacnmz/MidONA0oyfMYPzXqsZC?=
 =?us-ascii?Q?Z7P9/8gRwbQQ7OGsqWIAT/ii7D0h8QdQj6kF4rJSOy/GASSDYLuOV/NI7vog?=
 =?us-ascii?Q?5Z32XEUXca7IrphsRy6W1GjZap31fn1XDIznA15JwGvKj8qEqiwVyLeNifMX?=
 =?us-ascii?Q?Ir3+QsiCYXuPnDYaUfaPtwMzrE45EE9xOgmSh5SS9hB1h+Sa1vb9kPSPnnsL?=
 =?us-ascii?Q?4uMcUdtdg2juYONr9kjuhRF6eEotKK1FfU8XPZs7vyvzTf7gVdycJZAWOA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:58:04.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae00fd2-3877-4e1e-1f57-08de26f5ee68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

From: Le Ma <le.ma@amd.com>

Add psp_v15_0_8.c for MPASP 15.0.8

v2: drop memory training intf as they are only
necessary for GDDR memory

v3: Implement psp_v15_0_8_get_fw_type (Feifei)

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 342 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h |  30 ++
 5 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b10e9988a831f..ad57ade4001c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -134,7 +134,8 @@ amdgpu-y += \
 	psp_v12_0.o \
 	psp_v13_0.o \
 	psp_v13_0_4.o \
-	psp_v14_0.o
+	psp_v14_0.o \
+	psp_v15_0_8.o
 
 # add DCE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 480a3c6ae13b2..6619970da250f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4538,3 +4538,11 @@ const struct amdgpu_ip_block_version psp_v14_0_ip_block = {
 	.rev = 0,
 	.funcs = &psp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version psp_v15_0_8_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 15,
+	.minor = 0,
+	.rev = 8,
+	.funcs = &psp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 8f8578054191b..973998a2dc95e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -540,6 +540,7 @@ extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v15_0_8_ip_block;
 
 int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 		 uint32_t field_val, uint32_t mask, uint32_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
new file mode 100644
index 0000000000000..5249f5bd2a10e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -0,0 +1,342 @@
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
+#include <drm/drm_drv.h>
+#include <linux/vmalloc.h>
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v15_0_8.h"
+
+#include "mp/mp_15_0_8_offset.h"
+#include "mp/mp_15_0_8_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc.bin");
+
+static int psp_v15_0_8_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char ucode_prefix[30];
+	int err = 0;
+
+	amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	err = psp_init_toc_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int psp_v15_0_8_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_8_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v15_0_8_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v14_0_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_8_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v15_0_8_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v15_0_8_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v15_0_8_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+}
+
+static int psp_v15_0_8_get_fw_type(struct amdgpu_firmware_info *ucode,
+				   enum psp_gfx_fw_type *type)
+{
+	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type = GFX_FW_TYPE_CAP;
+		break;
+	case AMDGPU_UCODE_ID_SDMA0:
+		*type = GFX_FW_TYPE_SDMA0;
+		break;
+	case AMDGPU_UCODE_ID_SDMA1:
+		*type = GFX_FW_TYPE_SDMA1;
+		break;
+	case AMDGPU_UCODE_ID_SDMA2:
+		*type = GFX_FW_TYPE_SDMA2;
+		break;
+	case AMDGPU_UCODE_ID_SDMA3:
+		*type = GFX_FW_TYPE_SDMA3;
+		break;
+	case AMDGPU_UCODE_ID_SDMA4:
+		*type = GFX_FW_TYPE_SDMA4;
+		break;
+	case AMDGPU_UCODE_ID_SDMA5:
+		*type = GFX_FW_TYPE_SDMA5;
+		break;
+	case AMDGPU_UCODE_ID_SDMA6:
+		*type = GFX_FW_TYPE_SDMA6;
+		break;
+	case AMDGPU_UCODE_ID_SDMA7:
+		*type = GFX_FW_TYPE_SDMA7;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES:
+		*type = GFX_FW_TYPE_RS64_MES;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES_DATA:
+		*type = GFX_FW_TYPE_RS64_MES_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1:
+		*type = GFX_FW_TYPE_RS64_KIQ;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1_DATA:
+		*type = GFX_FW_TYPE_RS64_KIQ_STACK;
+		break;
+	case AMDGPU_UCODE_ID_RLC_P:
+		*type = GFX_FW_TYPE_RLC_P;
+		break;
+	case AMDGPU_UCODE_ID_RLC_V:
+		*type = GFX_FW_TYPE_RLC_V;
+		break;
+	case AMDGPU_UCODE_ID_RLC_G:
+		*type = GFX_FW_TYPE_RLC_G;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM:
+		*type = GFX_FW_TYPE_RLC_IRAM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM:
+		*type = GFX_FW_TYPE_RLC_DRAM_BOOT;
+		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		*type = GFX_FW_TYPE_RLX6_UCODE_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		*type = GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_SMC:
+		*type = GFX_FW_TYPE_SMU;
+		break;
+	case AMDGPU_UCODE_ID_PPTABLE:
+		*type = GFX_FW_TYPE_PPTABLE;
+		break;
+	case AMDGPU_UCODE_ID_VCN:
+		*type = GFX_FW_TYPE_VCN;
+		break;
+	case AMDGPU_UCODE_ID_VCN1:
+		*type = GFX_FW_TYPE_VCN1;
+		break;
+	case AMDGPU_UCODE_ID_VCN0_RAM:
+		*type = GFX_FW_TYPE_VCN0_RAM;
+		break;
+	case AMDGPU_UCODE_ID_VCN1_RAM:
+		*type = GFX_FW_TYPE_VCN1_RAM;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+	case AMDGPU_UCODE_ID_SDMA_RS64:
+		*type = GFX_FW_TYPE_SDMA0;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
+		*type = GFX_FW_TYPE_SDMA_UCODE_TH1;
+		break;
+	case AMDGPU_UCODE_ID_IMU_I:
+		*type = GFX_FW_TYPE_IMU_I;
+		break;
+	case AMDGPU_UCODE_ID_IMU_D:
+		*type = GFX_FW_TYPE_IMU_D;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC:
+		*type = GFX_FW_TYPE_RS64_MEC;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P2_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+		*type = GFX_FW_TYPE_UMSCH_UCODE;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+		*type = GFX_FW_TYPE_UMSCH_DATA;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+		*type = GFX_FW_TYPE_UMSCH_CMD_BUFFER;
+		break;
+	case AMDGPU_UCODE_ID_P2S_TABLE:
+		*type = GFX_FW_TYPE_P2S_TABLE;
+		break;
+	case AMDGPU_UCODE_ID_MAXIMUM:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct psp_funcs psp_v15_0_8_funcs = {
+	.init_microcode = psp_v15_0_8_init_microcode,
+	.ring_create = psp_v15_0_8_ring_create,
+	.ring_stop = psp_v15_0_8_ring_stop,
+	.ring_destroy = psp_v15_0_8_ring_destroy,
+	.ring_get_wptr = psp_v15_0_8_ring_get_wptr,
+	.ring_set_wptr = psp_v15_0_8_ring_set_wptr,
+	.get_fw_type = psp_v15_0_8_get_fw_type,
+};
+
+void psp_v15_0_8_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v15_0_8_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h
new file mode 100644
index 0000000000000..6bb1bb517007b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h
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
+#ifndef __PSP_V15_0_8_H__
+#define __PSP_V15_0_8_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v15_0_8_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.51.1

