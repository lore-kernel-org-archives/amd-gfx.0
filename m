Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6688FCCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE63810E81C;
	Wed, 29 Oct 2025 17:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="za1nKDXx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CFA10E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKd/k3X/CAaIKLVrBfYG/rTByzqkla9anKILBraIQkKeCi14IPjh0BPlOdHS8HhvQpGyA7K5guIBImcim0v//k7wYm2pN1bIPIDK2PNnynXJmrWfayoXmMa8ULTRGV6Qpu3NginqOS+9LnX7ZvOqCjkHUKamdFQaxgVtj3OxGtMEddep0rsdqCjjUy7tCj4joAGZMLbJEs/Ck5MqhsiA/hyHC3r7DY7fzIjjGjIayoTDjUAz36aUXk7bNuDhnUrFfFOHo5t7CnDXBmAjeXkubh7cWH9nEtnsOSDLiJghUEbLpjXtf7EtKk4yNDs67RBxVaH9DzF6YHRZt6HFBNdO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYW5X7vorMLHE8BqBdYpVvgZPfs3irUouQGbcSrOqqE=;
 b=wZ9vx9x/HieUDlZ4MXf1GwY0toYNSg1YXAz5S43FLMKWqUdIZNazh8eZtOPJ3z9UHLDrUTDvuqQxCmS/a7tckkVGBGqI1RXwqgJ7GdfiWDIkHkjvZqnerhVZ7NRA6uW0jhIOCmC57N2m6KjeC0meTWwFoPmGDDzi/G65tdy650n79FVU77n9cp0U/QME4Q55Sk5cVQUJRzxJsIufDyMupMtSlBLXh81AFdpU4JY1GDURqGkhxV97URDWUQ1OvumnXXMp8a4GpIna+FIoTG4ru+Q9qzFEK3Gu5HRRQ4f3xapvXP3VKxTTFcUCrw9nPA/W0bkISBFbQ8+zt0KLAkWoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYW5X7vorMLHE8BqBdYpVvgZPfs3irUouQGbcSrOqqE=;
 b=za1nKDXxgwYYztAhulrB75fVkmecTKXUl9cidfwIVagaFdk4GNzIO2vPPnxXU6vxiX+IbVVAyj5jz2ZSS2n7dBCHiiIgASRArx26LfmwIfNG6CPaLJl2DSKaokhnh6xGl6GDsX5bWPgOT9V2Qdbsjd1nmUO9aGyP20cR0RnJQbw=
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:56:18 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::86) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 17:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:56:18 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:56:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Add psp v14.0.7 ip block
Date: Wed, 29 Oct 2025 13:55:54 -0400
Message-ID: <20251029175557.2862156-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175557.2862156-1-alexander.deucher@amd.com>
References: <20251029175557.2862156-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6fd581-7f92-487a-3085-08de17147626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grOvQSajKNHttZ+HbZUGNbd/AvyvR+XHrAokwKzRQutUA51YZylwNoR5TabS?=
 =?us-ascii?Q?UB/075A6rhLOok1ThhaSEp6wmZ2tOJQC9KilkDrgRT3QBbDEKes+Ve/lIz0C?=
 =?us-ascii?Q?72eHssXwgXzKV3sZg/muDPIzD9dBdpbwVmbz3ehfoKp3lJ+vBnWP0bNzqrv+?=
 =?us-ascii?Q?579oM3WcdKTMa5d27UDQxaD8eNtqXvwCT4EtRm4HkIpvXdfoGqZum3rq4U1X?=
 =?us-ascii?Q?OYIQ20e/D2LZP4yc+/F8ypAdDIgmuH5xzxVyl0xOVBpI2QTBsP7G3N7Br8we?=
 =?us-ascii?Q?2wOJU+t5F7EXE8Ge3w+3i0dS+UR4wZjgGl+1X2VH5hj4GxKlbie4/8TV5JmD?=
 =?us-ascii?Q?67S9g3FprpvSU9dQwLK3lAmWdZ0a8ScQ9CAe+MM+UZDcPrTt183gXLqi4p/I?=
 =?us-ascii?Q?0XPo4TBh9WH/2814ddzHYMuTK/K5aT6ofS8XRLE85cDXpoBKAwrb7tv7U6Yn?=
 =?us-ascii?Q?I6Ou5gPaiUyo55Q/1yK498xBRGA8L6VJeZ/aYfwHlgtemtJ+iJ711DDpjITs?=
 =?us-ascii?Q?uIRoR3tiUtJW/L/UExQOcZzMZdez4cAD7zRkdYssdTawjeC+s98iq4oKD7A7?=
 =?us-ascii?Q?5y0rdunLKYOfGfeRTT7sekWSIhaPTG0KeAKFdrYUhR1VThJJzZHJsoQWrGqH?=
 =?us-ascii?Q?z43JuFRlswZ/Plb13QCSr390zrEkpLbdLTvfOJmf8ngwXKlYISKdutvcn0xh?=
 =?us-ascii?Q?XUxr8+RaXo3n2ZHqtWBmiiJMBZZ0oB4iyfMozPa9iMkTgutahPUdEhRRXiJL?=
 =?us-ascii?Q?p38eUElafpbB6bGxM9esK6t3r8PSlC0f63Z8q41z36CZ1MhFA/FjJgqsMGNB?=
 =?us-ascii?Q?B08aCvTkPKS4BlUMJw7Cbdog0BrMMNX0Y9tH2hfrab41X/SCa4CmLvWzIygu?=
 =?us-ascii?Q?dAKjZv5sJp5GNIxT9O5E/AH+azT4AmSq2IcrOb2Ux3sc1N0SyEfz1DSsVDvd?=
 =?us-ascii?Q?X2OZZv5w5EKi6qXLAVtpQgY7gXuI8K4E2u0RbjOedBwUByq6apQSKdvRQQEt?=
 =?us-ascii?Q?FPrb3jMtlc5TCFuImz7/12ymhl6tjTpL25w9BMbRiI1GGeN+n3XkUI2rj8v4?=
 =?us-ascii?Q?EpK22ytEGCl8h7v5bH/+D/X0twRR3/p4HikoVUwOY1nfLTYjRvRyYQBdfJOO?=
 =?us-ascii?Q?86u9YEr3akrCVmPnkVwKSpqq41RhR7+ModFs17yIKQIpY67XKjI/HHQloqwl?=
 =?us-ascii?Q?lALYpPYBhUSFNa8bPWKFF5/7KOz8zzmI9/57uKWLXFTIQwaSdooqfQcQ90ns?=
 =?us-ascii?Q?nBULm6kVbEqnVk1aYJAbuEFUJDX9iYmCak7QD4JDs0afN3MSLD73TPLBlxf6?=
 =?us-ascii?Q?8ldxj2E4LuElkzffNl8rwpPDLv28Zj54ZupE/ylS8NR5+yGZ1qrsYCq5YC6L?=
 =?us-ascii?Q?oil0BK5/e0WXkWDhWg4Gxw4EeYeMks54TR1rIWWdEJstRw9OY4Eyxoyqbq9Y?=
 =?us-ascii?Q?0buUA4KZxNmmMwPp4X2bl1E014lj0A2ucXUJV0Enc+vlROvhQKuJVylrtTJu?=
 =?us-ascii?Q?Me7yU1yh/Opu8E7fglgjo7gtFlQmCGX+GxplfXLFlAhoQ9yk13AzssXOGw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:56:18.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6fd581-7f92-487a-3085-08de17147626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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

Add psp_v14_0_7.c for MPASP 14.0.7

v2: drop memory training intf as they are only necessary for GDDR memory

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c | 202 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.h |  30 ++++
 5 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b408a981f4b03..1fc75f46b4273 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -134,7 +134,8 @@ amdgpu-y += \
 	psp_v12_0.o \
 	psp_v13_0.o \
 	psp_v13_0_4.o \
-	psp_v14_0.o
+	psp_v14_0.o \
+	psp_v14_0_7.o
 
 # add DCE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 39d3b4ae82110..bf9a76289f537 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4522,3 +4522,11 @@ const struct amdgpu_ip_block_version psp_v14_0_ip_block = {
 	.rev = 0,
 	.funcs = &psp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version psp_v14_0_7_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 14,
+	.minor = 0,
+	.rev = 7,
+	.funcs = &psp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 237b624aa51ca..2733a7bf4ad6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -534,6 +534,7 @@ extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v14_0_7_ip_block;
 
 int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 		 uint32_t field_val, uint32_t mask, uint32_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
new file mode 100644
index 0000000000000..a13fd866000a8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
@@ -0,0 +1,202 @@
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
+#include "psp_v14_0_7.h"
+
+#include "mp/mp_14_0_7_offset.h"
+#include "mp/mp_14_0_7_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_14_0_7_toc.bin");
+
+static int psp_v14_0_7_init_microcode(struct psp_context *psp)
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
+static int psp_v14_0_7_ring_stop(struct psp_context *psp,
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
+static int psp_v14_0_7_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v14_0_7_ring_stop(psp, ring_type);
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
+static int psp_v14_0_7_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v14_0_7_ring_stop(psp, ring_type);
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
+static uint32_t psp_v14_0_7_ring_get_wptr(struct psp_context *psp)
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
+static void psp_v14_0_7_ring_set_wptr(struct psp_context *psp, uint32_t value)
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
+static const struct psp_funcs psp_v14_0_7_funcs = {
+	.init_microcode = psp_v14_0_7_init_microcode,
+	.ring_create = psp_v14_0_7_ring_create,
+	.ring_stop = psp_v14_0_7_ring_stop,
+	.ring_destroy = psp_v14_0_7_ring_destroy,
+	.ring_get_wptr = psp_v14_0_7_ring_get_wptr,
+	.ring_set_wptr = psp_v14_0_7_ring_set_wptr,
+};
+
+void psp_v14_0_7_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v14_0_7_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.h b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.h
new file mode 100644
index 0000000000000..676628af5c539
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.h
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
+#ifndef __PSP_V14_0_7_H__
+#define __PSP_V14_0_7_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v14_0_7_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.51.0

