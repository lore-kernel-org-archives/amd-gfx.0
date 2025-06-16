Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F77C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D8B10E30B;
	Mon, 16 Jun 2025 09:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSIE2150";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F6910E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3UFrXUKvOWoSxUdREUd2ycyqaT41A4+7yQD9Pa/qlcbF/bjdcy3CKSIFGnJLpeWVaWC/4p3IojazAIQqpfrXZqjSAhiHXFOYKycv44sxzZCyRpzoDyjMEgS1qXjeilWD6DQEYnwlxq9/z+myigrdh+9xxbkhSN68Vd1kEQBAlFURFCr8TdjtyqHpEekaQy3u/VR6ioA75LbY90AyL2P0QPqoptA5vuyIIDL+rZnDqaDODCnPL3S64dax2cPXvM8aJYVg1QFylVjDH0zTfNVscxT4Vt0LZjhfYn6YMOzjbh7+gCrVV9yF1JIc18jH89l2O7TIOi3efcl4kvwkSHoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7czze7u7F+diL0Ls3EjqKrCNfR7DseS/bDMql4OdOE=;
 b=Esu8Rjegj8lNMPbDY9yYFKexp7KQEHJ7jJ0Xu+JlC9LAYzukB6JSoBBouoeBpRveEObyVG4j9AYYbEeUKOvowWY0KdwLegDYLxH4c8gKgx+UCztdodpOZ2FHeX9dnhbTjHHeeO+n0f2A2RgLSe3A/6wfqOhXQmwcwsDvNZ4BJKEjQO/qVrE6JDRHk/s34VSD2ZAR2UPcSogQ7BXNH5W57Jw9MetXG4T1VgHWEMRuMA9SUBVlnqW7zbzhPB3wftO+jo42MUiBhrOL0Bpf977Gc2B792HopXyiT9AWVJCGI5AINRyhVMMp03s3N/MSb0amvAdmaZe8YYDP/wBGtL7P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7czze7u7F+diL0Ls3EjqKrCNfR7DseS/bDMql4OdOE=;
 b=tSIE21506oymJayfpjDc06vmDcZyRcLDXCga1U/7y3yNIzch/93db0Tpo+JZ/YmL7j1UKb7j4CuaxitHdg8Wwi+OYlnmqydxyWCDcJp8d+VJGwilcggaMraG175Vs7tk1J6rpKQaR5JbOqtkktje8SYLG0gAExFCBsCbuGfM8UY=
Received: from CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::17)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 09:38:29 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::8d) by CH5P221CA0017.outlook.office365.com
 (2603:10b6:610:1f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 09:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:38:28 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:38:26 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: make ip map init to common function
Date: Mon, 16 Jun 2025 17:37:47 +0800
Message-ID: <20250616093756.16200-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9646c660-cd35-42b4-60cf-08ddacb98cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C6oggj8OX0c0LrWlwEaJxN+QCYrSkUHgAkKXtejmk2YTACPZMZ7jMveOGjqg?=
 =?us-ascii?Q?figsvkv+mUoU++KuxVvS4SbtaLYSzMPlzP2rcYqARWIOKtuRMCjwoh2OGhBK?=
 =?us-ascii?Q?5rhZjCaugyxGale2p44fR4gMq3i0SrfFCRuYyFW6NrvmjaeUQI3ahtryUphj?=
 =?us-ascii?Q?ScyCISHpb2yeQ9zCPy+mUyb87ZD0wiQqC7RS/GSCZVXnhJJXgddhtXZCW0EM?=
 =?us-ascii?Q?iM7Tv5s9/Mt8Ips8ARse/ODtQRiqx5rglvo4M60ZI4kNEkFqbMGj0XIrlZ1r?=
 =?us-ascii?Q?9ESU4eKBs3GkOUPwEbJGdIU8Eeg959hJT+0hZvQhvcASXPu+rnu5jvhzTT4Z?=
 =?us-ascii?Q?ivTYF1tQ+e1UOi4wewT1EC7oFQ5Sznb+OQPckIUtE7YbQr/CE1QrgrK7ceZ/?=
 =?us-ascii?Q?fiUmQ4O7pBblk71/DsltbTFtRTaqIhnzu6Vh2UmqgY5RpqF49pnLXE9N0A1n?=
 =?us-ascii?Q?UrK4gN6EzV2xhWVPUuibHSu4DF/Ut7nDWGlxPgKzenZ7nj2SwE3t04h9jfou?=
 =?us-ascii?Q?FrZyrdNb1eAaB2Ek5eK307j0DJAgLxp9Sldk7Spj0p9fDpD4t9UKp95XM36D?=
 =?us-ascii?Q?quQUkrSsgLXdGwuJgdMcQiin6NqL5HEFIM/rA211DaVZzR0oyhlGJcZ0Temd?=
 =?us-ascii?Q?anUHsykn8MYqDKjkKD++Bm766zsbCAMC0Huy/UjnkCVORDnEDuXWpuzoObn/?=
 =?us-ascii?Q?8PfRXXMNMamGUqzB/eTuIgURKyFrWWinQwxCwANu9wQa/Ng3H4F+R7TaxDSm?=
 =?us-ascii?Q?1DcFevo3iqc9/zza5Pv6cnvLZbDSmP/RVRs/XXRj9rtUehelnzgQTD9xes4P?=
 =?us-ascii?Q?YbLMhZQc5rp9P/nkAVSVxacKkEYregkihBE/0XFGbzqF/hVuxL93eQsphwzq?=
 =?us-ascii?Q?grKYff2pXYyGVGkwlad6S6WOWYA7gAd84lrFd6DWe3vrAzvGqJem2ImcfrfF?=
 =?us-ascii?Q?gsIB17AJsip4EP38MY6brhEaKayjreJZQX99jTYA/Q3OYf0JwhF/nrKNgwuF?=
 =?us-ascii?Q?m0oaKzD6xeqjsIZax9eIhPHBFNDhG8j/m7ciP9luUspwQg1LKZcBLWiyEOma?=
 =?us-ascii?Q?tdhkepyb04V4Rm0g8RJyqQ7i0C54OKWXWMotLOEU1t+1ONL3N6Ujac8xQPT2?=
 =?us-ascii?Q?QQ893N1e/5USBEypESlinVHoXuo9B4JZketDDv6fofHi8sdNA3teJEv9fUAo?=
 =?us-ascii?Q?zJg0D7kVY2do0RoiNHt/1uEF7SLDgKx0ipEGMSbm2Y90Bl0kaZI4v/gwbHjF?=
 =?us-ascii?Q?JPhOd215aQ4o+FDD9bVFrIyR+mMuw7j+DqwDupU2h3K/PGGHvO+gGFUPHReE?=
 =?us-ascii?Q?usJ4c1jABbWn/WXeX+Nv8G9oDGZgeFAcI0IANfNsrE2uuN1sn6xPZBx2sDlr?=
 =?us-ascii?Q?edrK8xCejz3O0fL9guLoZkvjTtW6ZL1+I4Yel78L/XmCR1wBCsqxFYNRDYPM?=
 =?us-ascii?Q?aWdmXTwOFggYbafJAmGa/MMML7nNb1+ebgjFqA4mV0uKWpNIAnd1SkOKqwSZ?=
 =?us-ascii?Q?BpURlbirttn+Mi7vVGwWQaDdNGWoR9s7gpTf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:38:28.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9646c660-cd35-42b4-60cf-08ddacb98cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

IP instance map init function can be an common function
instead of operation on different ASIC.
V2: Create amdgpu_ip.[ch] file for ip related functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 96 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h | 29 ++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 87080c06e5fc..930de203d533 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -66,7 +66,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
new file mode 100644
index 000000000000..99e1cf4fc955
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -0,0 +1,96 @@
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
+#include "amdgpu.h"
+#include "amdgpu_ip.h"
+
+static int8_t amdgpu_logical_to_dev_inst(struct amdgpu_device *adev,
+					 enum amd_hw_ip_block_type block,
+					 int8_t inst)
+{
+	int8_t dev_inst;
+
+	switch (block) {
+	case GC_HWIP:
+	case SDMA0_HWIP:
+	/* Both JPEG and VCN as JPEG is only alias of VCN */
+	case VCN_HWIP:
+		dev_inst = adev->ip_map.dev_inst[block][inst];
+		break;
+	default:
+		/* For rest of the IPs, no look up required.
+		 * Assume 'logical instance == physical instance' for all configs. */
+		dev_inst = inst;
+		break;
+	}
+
+	return dev_inst;
+}
+
+static uint32_t amdgpu_logical_to_dev_mask(struct amdgpu_device *adev,
+					   enum amd_hw_ip_block_type block,
+					   uint32_t mask)
+{
+	uint32_t dev_mask = 0;
+	int8_t log_inst, dev_inst;
+
+	while (mask) {
+		log_inst = ffs(mask) - 1;
+		dev_inst = amdgpu_logical_to_dev_inst(adev, block, log_inst);
+		dev_mask |= (1 << dev_inst);
+		mask &= ~(1 << log_inst);
+	}
+
+	return dev_mask;
+}
+
+static void amdgpu_populate_ip_map(struct amdgpu_device *adev,
+				   enum amd_hw_ip_block_type ip_block,
+				   uint32_t inst_mask)
+{
+	int l = 0, i;
+
+	while (inst_mask) {
+		i = ffs(inst_mask) - 1;
+		adev->ip_map.dev_inst[ip_block][l++] = i;
+		inst_mask &= ~(1 << i);
+	}
+	for (; l < HWIP_MAX_INSTANCE; l++)
+		adev->ip_map.dev_inst[ip_block][l] = -1;
+}
+
+void amdgpu_ip_map_init(struct amdgpu_device *adev)
+{
+	u32 ip_map[][2] = {
+		{ GC_HWIP, adev->gfx.xcc_mask },
+		{ SDMA0_HWIP, adev->sdma.sdma_mask },
+		{ VCN_HWIP, adev->vcn.inst_mask },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
+		amdgpu_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
+
+	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
+	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
new file mode 100644
index 000000000000..2490fd322aec
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
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
+#ifndef __AMDGPU_IP_H__
+#define __AMDGPU_IP_H__
+
+void amdgpu_ip_map_init(struct amdgpu_device *adev);
+
+#endif /* __AMDGPU_IP_H__ */
-- 
2.17.1

