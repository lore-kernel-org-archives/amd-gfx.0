Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24C9C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2380910E5DC;
	Sat,  5 Sep 2026 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PcX0ja2j";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29B010E5DA
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVEq+2FpYRZrg2M7jA6zZRElHSS5ReUOINWOokVKU/0d6qDkbwYBqQJfW5AB03omeySVZP7ukqbyCFvqa3PfzzQQozCUpwi92MOreNBnectDJvpKjWcMe4zMxPfqug+kGYskXF17XDSudz3K/FC6v/II/wttQxJ5j6dIey7NdzZxCQYEM9NTOiwK0w6xqkHuyZ4tv8iNgMvo7Fo0U2eProj2ppCciv1oWBoaGVZrcDUDabbHVHbemWOaBan9/akQwRJDyWYrpgIBrad0Zoln1ixvK4nL7Az7M00AhZWZ5A+YTn6gEG/MypVOzFFlcBD6n1jq4QrsjkUeHH5Pzc9zYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxjKcCi1EsZc6EgLnHzUZ2GmvmCwPO2GQ+pNbGL1DrU=;
 b=ADNDIkCcxknsTz0sIgSMgJxKzaJJ/xzQyMWrATAh+WhLIcMDe4EUC4EFAqFqirTk5Qomjj1x3RYnx76pDy6roGbQeLhfEobVxHKwqZX5vrJqnC52te28JA0EL2oem6nxNmnTU9HA6LXUQvEGfFOm4opVnfriLq65S6+v8SBolpGQ8HTeFqCGtoYqCFGr1hUrSWgJuHbFRu/EiSsvYgdsT3bP8IgguVmbzOg+3RAer3fK2nc7kdjJ+b9M2auGGYNu2sJJQxUYKnvRf+ab0PVxwVRYMz+61vTPqXGccwlCD3gvkygqIl8ZK3JQv707qVlyUpJ16bDZQQY57WQf7O4baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxjKcCi1EsZc6EgLnHzUZ2GmvmCwPO2GQ+pNbGL1DrU=;
 b=PcX0ja2jbCvWFIjErsfgLqwQhFuF/TRgr3pPqXuH7qLS8yqHVXQjV8AfcckAfyhOK1+SroV8p7ubwIuq6HDavuvUNNbvGfd0Qx1PTtCmn/HJda/eMHGcqNTYSqA/56g7yAflnfEgaxnXkZudn3glQ0mCefg2v7BZm6odJNSzsdQ=
Received: from DS1PR02CA0027.namprd02.prod.outlook.com (2603:10b6:8:44a::7) by
 SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sat, 5 Sep 2026 10:06:25 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::8c) by DS1PR02CA0027.outlook.office365.com
 (2603:10b6:8:44a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:25 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:23 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: Add nbif v4_10_0 ip headers
Date: Sat, 5 Sep 2026 18:05:34 +0800
Message-ID: <20260905100538.12877-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: c198cf5f-d563-44c5-ed19-08df0b35583a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|11063799006|10067099003|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 3FhZsvgNrmzIYWXSSmibxLExC4GeGLINmKIjieLvCeUFjwMxKE4y2dKtzyK/q8FS0jHtYB/anQahUX3jkyZ5RBPWQrG7kUjfKbxviami8sNr4Jb85eLOVJHHgbOdoSC+a4kDFUfF+n5sNKSLlfkyZ+nr2Vy8hpXE2xkCGWRyghLTr6fm3IIFfPMRn9lpeaT7n5NjbxF9rtXgRNW50wWA2tyBuOaO9QOzbRvXl8u9bOwEKpfE0FarfcOFVz9ucByDSNCQ/3C7ecOT/NZRXsYuW7Sixs70GZHLLklxNvKXoRPPJgGw39PL7fabJdbI8XuR5Zh382LIfyUIXGjes/TPReuoZdjpjggQx71QHLBcSPJN/z5JQsk62Mc953Vq8C3WXN3nkaqfRE5m5ZJV+cFiygaMxWN5Rq9VrPrhYHVa/9k7m/4iSfo6xsLiYA85s5kT9E2o3hJOKmieZ0SfcwNWAN8RYAP+2HkLW2SFax4q4+P+4na75tVulYDS4qm8zoVKrqCMrupOFpAXZOVGT3TgnVx2HJU7QBeenVtGdaeZWU57PCzJbUnVw+T14q7HG8tlu5fwkiT8TU8tDAgV6rxeXoQdZS2FPZ8sFtNso8W0qqkXhrW5sRI2O9DT9vLc6QCo9v5pTvnyyJXWr8xLjHlIHfmrku6hYg5HQP2xwZi8ODpJtXAwtUQ5N6tlV9OS0dVeZwfYydit1XHI37nC13MFjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 14GDkv83nsCw4IfFs4NINdeRw247J3WUgDs4rvMAN8ztzfVufcewzlTCFgFtJnOxNEUGNiyp+4mjV8GWVboEiz05aVlc/Xsvyq8p26cjz8rHBHReBR5eb8og1urdegIkNn0CiSme7jutS67PjhFP4EDn3wJC12XvPmttuMKgPHvYCLKz5Hy5x0uTYptynNwOc2JFzcOqJZ6PcPLtCfG2fGQnwwZGPBfmSYyJrj8aBatHclLx7ApFymzRr2KNeOK7HYPm5mDioa1+7ieHjjYbKjJDyBgGtyz+Or0TlhugL4nAYHrBXeKlEgc55TJ7CnvbR7g2lYnFPi/EW0SpFPjQFTv5e3miNjGxflIolCEI4S7/sMDISgAyLbmXwoGVdRVQsYhXYqBuFRk496CrO1jjRgTp3H2Yhz1zDwGxplqy5CyCuOOQIuusgKL1fRG48/Rz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:25.0852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c198cf5f-d563-44c5-ed19-08df0b35583a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

Add header files for nbif v4_10_0 register offsets
and shift masks

These register definitions are derived from nbif
v6_3_1 source file which uses the _nbif_4_10 suffix

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../asic_reg/nbif/nbif_4_10_0_offset.h        | 103 ++++
 .../asic_reg/nbif/nbif_4_10_0_sh_mask.h       | 573 ++++++++++++++++++
 2 files changed, 676 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h
new file mode 100644
index 000000000000..fe0e0d588c06
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h
@@ -0,0 +1,103 @@
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
+#ifndef _nbif_4_10_0_OFFSET_HEADER
+#define _nbif_4_10_0_OFFSET_HEADER
+
+#define regBIF_BX_PF0_RSMU_INDEX                                                                        0x0000
+#define regBIF_BX_PF0_RSMU_INDEX_BASE_IDX                                                               1
+#define regBIF_BX_PF0_RSMU_DATA                                                                         0x0001
+#define regBIF_BX_PF0_RSMU_DATA_BASE_IDX                                                                1
+#define regBIF_BX0_PCIE_INDEX                                                                           0x000c
+#define regBIF_BX0_PCIE_INDEX_BASE_IDX                                                                  0
+#define regBIF_BX0_PCIE_DATA                                                                            0x000d
+#define regBIF_BX0_PCIE_DATA_BASE_IDX                                                                   0
+#define regRCC_STRAP0_RCC_BIF_STRAP2                                                                    0x0006
+#define regRCC_STRAP0_RCC_BIF_STRAP2_BASE_IDX                                                           2
+#define regRCC_STRAP0_RCC_BIF_STRAP3                                                                    0x0007
+#define regRCC_STRAP0_RCC_BIF_STRAP3_BASE_IDX                                                           2
+#define regRCC_STRAP0_RCC_BIF_STRAP5                                                                    0x0009
+#define regRCC_STRAP0_RCC_BIF_STRAP5_BASE_IDX                                                           2
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0                                                              0x0021
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_BASE_IDX                                                     2
+#define regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL                                                            0x0054
+#define regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL_BASE_IDX                                                   2
+#define regRCC_DEV0_EPF0_RCC_DOORBELL_APER_EN                                                           0x00c0
+#define regRCC_DEV0_EPF0_RCC_DOORBELL_APER_EN_BASE_IDX                                                  2
+#define regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE                                                           0x00c3
+#define regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE_BASE_IDX                                                  2
+#define regBIF_BX0_INTERRUPT_CNTL                                                                       0x00f1
+#define regBIF_BX0_INTERRUPT_CNTL_BASE_IDX                                                              2
+#define regBIF_BX0_INTERRUPT_CNTL2                                                                      0x00f2
+#define regBIF_BX0_INTERRUPT_CNTL2_BASE_IDX                                                             2
+#define regBIF_BX0_BIF_DOORBELL_INT_CNTL                                                                0x00fe
+#define regBIF_BX0_BIF_DOORBELL_INT_CNTL_BASE_IDX                                                       2
+#define regBIF_BX0_BIF_FB_EN                                                                            0x0100
+#define regBIF_BX0_BIF_FB_EN_BASE_IDX                                                                   2
+#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL                                                             0x012d
+#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_BASE_IDX                                                    2
+#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL                                                             0x012e
+#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_BASE_IDX                                                    2
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH                                              0x00f3
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_BASE_IDX                                     2
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW                                               0x00f4
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_BASE_IDX                                      2
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL                                                   0x00f5
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_BASE_IDX                                          2
+#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL                                                      0x00f7
+#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_BASE_IDX                                             2
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ                                                                 0x0106
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_BASE_IDX                                                        2
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE                                                                0x0107
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_BASE_IDX                                                       2
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL                                                           0x4f0aeb
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1                                                          0x4f0aec
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL                                                           0x4f0aed
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1                                                          0x4f0aee
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL                                                           0x4f0aef
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1                                                          0x4f0af0
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL                                                           0x4f0af1
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1                                                          0x4f0af2
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL                                                           0x4f0af3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1                                                          0x4f0af4
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL                                                           0x4f0af5
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1                                                          0x4f0af6
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_BASE_IDX                                                 3
+#define regRCC_DEV0_EPF2_STRAP2                                                                         0xd102
+#define regRCC_DEV0_EPF2_STRAP2_BASE_IDX                                                                5
+#define regREGS_ROM_OFFSET_CTRL                                                                         0xcc23
+#define regREGS_ROM_OFFSET_CTRL_BASE_IDX                                                                5
+#define regRCC_DEV0_EPF0_1_RCC_CONFIG_MEMSIZE                                                           0x2ffc0de3
+#define regRCC_DEV0_EPF0_1_RCC_CONFIG_MEMSIZE_BASE_IDX                                                  5
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h
new file mode 100644
index 000000000000..d8164039a4d3
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h
@@ -0,0 +1,573 @@
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
+#ifndef _nbif_4_10_0_SH_MASK_HEADER
+#define _nbif_4_10_0_SH_MASK_HEADER
+
+//BIF_BX_PF0_RSMU_INDEX
+#define BIF_BX_PF0_RSMU_INDEX__RSMU_INDEX__SHIFT                                                              0x0
+#define BIF_BX_PF0_RSMU_INDEX__RSMU_INDEX_MASK                                                                0xFFFFFFFFL
+//BIF_BX_PF0_RSMU_DATA
+#define BIF_BX_PF0_RSMU_DATA__RSMU_DATA__SHIFT                                                                0x0
+#define BIF_BX_PF0_RSMU_DATA__RSMU_DATA_MASK                                                                  0xFFFFFFFFL
+//BIF_BX0_PCIE_INDEX
+#define BIF_BX0_PCIE_INDEX__PCIE_INDEX__SHIFT                                                                 0x0
+#define BIF_BX0_PCIE_INDEX__PCIE_INDEX_MASK                                                                   0xFFFFFFFFL
+//BIF_BX0_PCIE_DATA
+#define BIF_BX0_PCIE_DATA__PCIE_DATA__SHIFT                                                                   0x0
+#define BIF_BX0_PCIE_DATA__PCIE_DATA_MASK                                                                     0xFFFFFFFFL
+//RCC_STRAP0_RCC_BIF_STRAP2
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PCIESWUS_INDEX_APER_RANGE__SHIFT                                     0x0
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWUS_SPT__SHIFT                                                      0x1
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWDS_SPT__SHIFT                                                      0x2
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ENDP_LINKDOWN_DROP_DMA__SHIFT                                        0x5
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWITCH_LINKDOWN_DROP_DMA__SHIFT                                      0x6
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWUS_SEC_LVL_OVRD_EN__SHIFT                                          0x7
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_GMI_DNS_SDP_CLKREQ_TOGGLE_DIS__SHIFT                                 0x8
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ACS_MSKSEV_EP_HIDE_DIS__SHIFT                                        0x9
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_CFG_PG_FW_INTERLOCK_EXIT_EN__SHIFT                                   0xa
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_USB_PD_FUNC_DIS__SHIFT                                               0xc
+#define RCC_STRAP0_RCC_BIF_STRAP2__RESERVED_BIF_STRAP2__SHIFT                                                 0xd
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS__SHIFT                                             0xe
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_GFXAZ_POWERSTATE_INTERLOCK_EN__SHIFT                                 0xf
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PWRBRK_DEGLITCH_CYCLE__SHIFT                                         0x10
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PWRBRK_DEGLITCH_BYPASS__SHIFT                                        0x18
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ARI_EN_UP__SHIFT                                                     0x19
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_VLINK_PMETO_LDN_EXIT_BY_LNKRST_DIS__SHIFT                            0x1f
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PCIESWUS_INDEX_APER_RANGE_MASK                                       0x00000001L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWUS_SPT_MASK                                                        0x00000002L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWDS_SPT_MASK                                                        0x00000004L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ENDP_LINKDOWN_DROP_DMA_MASK                                          0x00000020L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWITCH_LINKDOWN_DROP_DMA_MASK                                        0x00000040L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_SWUS_SEC_LVL_OVRD_EN_MASK                                            0x00000080L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_GMI_DNS_SDP_CLKREQ_TOGGLE_DIS_MASK                                   0x00000100L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ACS_MSKSEV_EP_HIDE_DIS_MASK                                          0x00000200L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_CFG_PG_FW_INTERLOCK_EXIT_EN_MASK                                     0x00000C00L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_USB_PD_FUNC_DIS_MASK                                                 0x00001000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__RESERVED_BIF_STRAP2_MASK                                                   0x00002000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK                                               0x00004000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_GFXAZ_POWERSTATE_INTERLOCK_EN_MASK                                   0x00008000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PWRBRK_DEGLITCH_CYCLE_MASK                                           0x00FF0000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_PWRBRK_DEGLITCH_BYPASS_MASK                                          0x01000000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_ARI_EN_UP_MASK                                                       0x02000000L
+#define RCC_STRAP0_RCC_BIF_STRAP2__STRAP_VLINK_PMETO_LDN_EXIT_BY_LNKRST_DIS_MASK                              0x80000000L
+//RCC_STRAP0_RCC_BIF_STRAP3
+#define RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT                                         0x0
+#define RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT                                       0x10
+#define RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK                                           0x0000FFFFL
+#define RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK                                         0xFFFF0000L
+//RCC_STRAP0_RCC_BIF_STRAP5
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT                                         0x0
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ON_SWUS_LDN_EN__SHIFT                                      0x10
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ON_SWUS_SECRST_EN__SHIFT                                   0x11
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_ENTER_COMPLIANCE_DIS__SHIFT                                    0x12
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_IGNORE_PSN_ON_VDM1_DIS__SHIFT                                        0x13
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_SMN_ERR_STATUS_MASK_EN_UPS__SHIFT                                    0x14
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_REG_PROTECTION_DIS__SHIFT                                            0x15
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_SMN_ERRRSP_DATA_FORCE__SHIFT                                         0x16
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_INTERMEDIATERSP_DATA_ALLF_DATA_FORCE__SHIFT                          0x18
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_EMER_POWER_REDUCTION_SUPPORTED__SHIFT                                0x19
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_EMER_POWER_REDUCTION_INIT_REQ__SHIFT                                 0x1b
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_PWRBRK_STATUS_TIMER__SHIFT                                           0x1c
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_BIF_GFX_REG_APER_REMAPPING_EN__SHIFT                                 0x1f
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK                                           0x0000FFFFL
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ON_SWUS_LDN_EN_MASK                                        0x00010000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ON_SWUS_SECRST_EN_MASK                                     0x00020000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_ENTER_COMPLIANCE_DIS_MASK                                      0x00040000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_IGNORE_PSN_ON_VDM1_DIS_MASK                                          0x00080000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_SMN_ERR_STATUS_MASK_EN_UPS_MASK                                      0x00100000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_REG_PROTECTION_DIS_MASK                                              0x00200000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_SMN_ERRRSP_DATA_FORCE_MASK                                           0x00C00000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_INTERMEDIATERSP_DATA_ALLF_DATA_FORCE_MASK                            0x01000000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_EMER_POWER_REDUCTION_SUPPORTED_MASK                                  0x06000000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_EMER_POWER_REDUCTION_INIT_REQ_MASK                                   0x08000000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_PWRBRK_STATUS_TIMER_MASK                                             0x70000000L
+#define RCC_STRAP0_RCC_BIF_STRAP5__STRAP_BIF_GFX_REG_APER_REMAPPING_EN_MASK                                   0x80000000L
+//RCC_STRAP0_RCC_DEV0_EPF0_STRAP0
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_DEVICE_ID_DEV0_F0__SHIFT                                       0x0
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_MAJOR_REV_ID_DEV0_F0__SHIFT                                    0x10
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_MINOR_REV_ID_DEV0_F0__SHIFT                                    0x14
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT                                      0x18
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_FUNC_EN_DEV0_F0__SHIFT                                         0x1c
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_LEGACY_DEVICE_TYPE_EN_DEV0_F0__SHIFT                           0x1d
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D1_SUPPORT_DEV0_F0__SHIFT                                      0x1e
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D2_SUPPORT_DEV0_F0__SHIFT                                      0x1f
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_DEVICE_ID_DEV0_F0_MASK                                         0x0000FFFFL
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_MAJOR_REV_ID_DEV0_F0_MASK                                      0x000F0000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_MINOR_REV_ID_DEV0_F0_MASK                                      0x00F00000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK                                        0x0F000000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_FUNC_EN_DEV0_F0_MASK                                           0x10000000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_LEGACY_DEVICE_TYPE_EN_DEV0_F0_MASK                             0x20000000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D1_SUPPORT_DEV0_F0_MASK                                        0x40000000L
+#define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D2_SUPPORT_DEV0_F0_MASK                                        0x80000000L
+//RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_SHORT_VALUE__SHIFT                                      0x0
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_LONG_VALUE__SHIFT                                       0x3
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_REQUIREMENT__SHIFT                                      0x6
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_SHORT_VALUE__SHIFT                                     0x7
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_LONG_VALUE__SHIFT                                      0xa
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_REQUIREMENT__SHIFT                                     0xd
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0__SHIFT                               0xe
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_RST_LTR_IN_DL_DOWN__SHIFT                                 0xf
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__TX_CHK_FC_FOR_L1__SHIFT                                            0x10
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_DSTATE_USING_WDATA_EN__SHIFT                                   0x11
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_SHORT_VALUE_MASK                                        0x00000007L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_LONG_VALUE_MASK                                         0x00000038L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_S_REQUIREMENT_MASK                                        0x00000040L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_SHORT_VALUE_MASK                                       0x00000380L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_LONG_VALUE_MASK                                        0x00001C00L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_NS_REQUIREMENT_MASK                                       0x00002000L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK                                 0x00004000L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_RST_LTR_IN_DL_DOWN_MASK                                   0x00008000L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__TX_CHK_FC_FOR_L1_MASK                                              0x00010000L
+#define RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_DSTATE_USING_WDATA_EN_MASK                                     0x00020000L
+//RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN
+#define RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN__BIF_DOORBELL_APER_EN__SHIFT                                       0x0
+#define RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN__BIF_DOORBELL_APER_EN_MASK                                         0x00000001L
+//RCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE
+#define RCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE__CONFIG_MEMSIZE__SHIFT                                             0x0
+#define RCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE__CONFIG_MEMSIZE_MASK                                               0xFFFFFFFFL
+//BIF_BX0_INTERRUPT_CNTL
+#define BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE__SHIFT                                                   0x0
+#define BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_EN__SHIFT                                                         0x1
+#define BIF_BX0_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN__SHIFT                                                     0x3
+#define BIF_BX0_INTERRUPT_CNTL__IH_INTR_DLY_CNTR__SHIFT                                                       0x4
+#define BIF_BX0_INTERRUPT_CNTL__GEN_IH_INT_EN__SHIFT                                                          0x8
+#define BIF_BX0_INTERRUPT_CNTL__BIF_RB_REQ_NONSNOOP_EN__SHIFT                                                 0xf
+#define BIF_BX0_INTERRUPT_CNTL__DUMMYRD_BYPASS_IN_MSI_EN__SHIFT                                               0x10
+#define BIF_BX0_INTERRUPT_CNTL__ALWAYS_SEND_INTPKT_AFTER_DUMMYRD_DIS__SHIFT                                   0x11
+#define BIF_BX0_INTERRUPT_CNTL__BIF_RB_REQ_RELAX_ORDER_EN__SHIFT                                              0x12
+#define BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK                                                     0x00000001L
+#define BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_EN_MASK                                                           0x00000002L
+#define BIF_BX0_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK                                                       0x00000008L
+#define BIF_BX0_INTERRUPT_CNTL__IH_INTR_DLY_CNTR_MASK                                                         0x000000F0L
+#define BIF_BX0_INTERRUPT_CNTL__GEN_IH_INT_EN_MASK                                                            0x00000100L
+#define BIF_BX0_INTERRUPT_CNTL__BIF_RB_REQ_NONSNOOP_EN_MASK                                                   0x00008000L
+#define BIF_BX0_INTERRUPT_CNTL__DUMMYRD_BYPASS_IN_MSI_EN_MASK                                                 0x00010000L
+#define BIF_BX0_INTERRUPT_CNTL__ALWAYS_SEND_INTPKT_AFTER_DUMMYRD_DIS_MASK                                     0x00020000L
+#define BIF_BX0_INTERRUPT_CNTL__BIF_RB_REQ_RELAX_ORDER_EN_MASK                                                0x00040000L
+//BIF_BX0_INTERRUPT_CNTL2
+#define BIF_BX0_INTERRUPT_CNTL2__IH_DUMMY_RD_ADDR__SHIFT                                                      0x0
+#define BIF_BX0_INTERRUPT_CNTL2__IH_DUMMY_RD_ADDR_MASK                                                        0xFFFFFFFFL
+//BIF_BX0_BIF_DOORBELL_INT_CNTL
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS__SHIFT                                       0x0
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_STATUS__SHIFT                                      0x1
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS__SHIFT                            0x2
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR__SHIFT                                        0x10
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_CLEAR__SHIFT                                       0x11
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR__SHIFT                             0x12
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_ERR_EVENT_INTERRUPT_ENABLE__SHIFT                            0x17
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_DISABLE__SHIFT                                      0x18
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_DISABLE__SHIFT                                     0x19
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE__SHIFT                           0x1a
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_DB_INTR_STATUS_WHEN_RB_ENABLE__SHIFT                               0x1c
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_IOH_RAS_INTR_STATUS_WHEN_RB_ENABLE__SHIFT                          0x1d
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_ATH_RAS_INTR_STATUS_WHEN_RB_ENABLE__SHIFT                          0x1e
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__TIMEOUT_ERR_EVENT_INTERRUPT_ENABLE__SHIFT                              0x1f
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS_MASK                                         0x00000001L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_STATUS_MASK                                        0x00000002L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS_MASK                              0x00000004L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR_MASK                                          0x00010000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_CLEAR_MASK                                         0x00020000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR_MASK                               0x00040000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_ERR_EVENT_INTERRUPT_ENABLE_MASK                              0x00800000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_DISABLE_MASK                                        0x01000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_DISABLE_MASK                                       0x02000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE_MASK                             0x04000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_DB_INTR_STATUS_WHEN_RB_ENABLE_MASK                                 0x10000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_IOH_RAS_INTR_STATUS_WHEN_RB_ENABLE_MASK                            0x20000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__SET_ATH_RAS_INTR_STATUS_WHEN_RB_ENABLE_MASK                            0x40000000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__TIMEOUT_ERR_EVENT_INTERRUPT_ENABLE_MASK                                0x80000000L
+//BIF_BX0_BIF_FB_EN
+#define BIF_BX0_BIF_FB_EN__FB_READ_EN__SHIFT                                                                  0x0
+#define BIF_BX0_BIF_FB_EN__FB_WRITE_EN__SHIFT                                                                 0x1
+#define BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK                                                                    0x00000001L
+#define BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK                                                                   0x00000002L
+//BIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL
+#define BIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL__ADDRESS__SHIFT                                                      0x2
+#define BIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL__ADDRESS_MASK                                                        0x0007FFFCL
+//BIF_BX0_REMAP_HDP_REG_FLUSH_CNTL
+#define BIF_BX0_REMAP_HDP_REG_FLUSH_CNTL__ADDRESS__SHIFT                                                      0x2
+#define BIF_BX0_REMAP_HDP_REG_FLUSH_CNTL__ADDRESS_MASK                                                        0x0007FFFCL
+//BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH__DOORBELL_SELFRING_GPA_APER_BASE_HIGH__SHIFT          0x0
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH__DOORBELL_SELFRING_GPA_APER_BASE_HIGH_MASK            0xFFFFFFFFL
+//BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW__DOORBELL_SELFRING_GPA_APER_BASE_LOW__SHIFT            0x0
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW__DOORBELL_SELFRING_GPA_APER_BASE_LOW_MASK              0xFFFFFFFFL
+//BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_EN__SHIFT                      0x0
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_MODE__SHIFT                    0x1
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_SIZE__SHIFT                    0x8
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_EN_MASK                        0x00000001L
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_MODE_MASK                      0x00000002L
+#define BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL__DOORBELL_SELFRING_GPA_APER_SIZE_MASK                      0x000FFF00L
+//BIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL
+#define BIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL__HDP_MEM_FLUSH_ADDR__SHIFT                                    0x0
+#define BIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL__HDP_MEM_FLUSH_ADDR_MASK                                      0x00000001L
+//BIF_BX_PF0_GPU_HDP_FLUSH_REQ
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP0__SHIFT                                                              0x0
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP1__SHIFT                                                              0x1
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP2__SHIFT                                                              0x2
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP3__SHIFT                                                              0x3
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP4__SHIFT                                                              0x4
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP5__SHIFT                                                              0x5
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP6__SHIFT                                                              0x6
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP7__SHIFT                                                              0x7
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP8__SHIFT                                                              0x8
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP9__SHIFT                                                              0x9
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__SDMA0__SHIFT                                                            0xa
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__SDMA1__SHIFT                                                            0xb
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG0__SHIFT                                                        0xc
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG1__SHIFT                                                        0xd
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG2__SHIFT                                                        0xe
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG3__SHIFT                                                        0xf
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG4__SHIFT                                                        0x10
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG5__SHIFT                                                        0x11
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG6__SHIFT                                                        0x12
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG7__SHIFT                                                        0x13
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG8__SHIFT                                                        0x14
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG9__SHIFT                                                        0x15
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG10__SHIFT                                                       0x16
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG11__SHIFT                                                       0x17
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG12__SHIFT                                                       0x18
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG13__SHIFT                                                       0x19
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG14__SHIFT                                                       0x1a
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG15__SHIFT                                                       0x1b
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG16__SHIFT                                                       0x1c
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG17__SHIFT                                                       0x1d
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG18__SHIFT                                                       0x1e
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG19__SHIFT                                                       0x1f
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP0_MASK                                                                0x00000001L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP1_MASK                                                                0x00000002L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP2_MASK                                                                0x00000004L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP3_MASK                                                                0x00000008L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP4_MASK                                                                0x00000010L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP5_MASK                                                                0x00000020L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP6_MASK                                                                0x00000040L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP7_MASK                                                                0x00000080L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP8_MASK                                                                0x00000100L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__CP9_MASK                                                                0x00000200L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__SDMA0_MASK                                                              0x00000400L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__SDMA1_MASK                                                              0x00000800L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG0_MASK                                                          0x00001000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG1_MASK                                                          0x00002000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG2_MASK                                                          0x00004000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG3_MASK                                                          0x00008000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG4_MASK                                                          0x00010000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG5_MASK                                                          0x00020000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG6_MASK                                                          0x00040000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG7_MASK                                                          0x00080000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG8_MASK                                                          0x00100000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG9_MASK                                                          0x00200000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG10_MASK                                                         0x00400000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG11_MASK                                                         0x00800000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG12_MASK                                                         0x01000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG13_MASK                                                         0x02000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG14_MASK                                                         0x04000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG15_MASK                                                         0x08000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG16_MASK                                                         0x10000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG17_MASK                                                         0x20000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG18_MASK                                                         0x40000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_REQ__RSVD_ENG19_MASK                                                         0x80000000L
+//BIF_BX_PF0_GPU_HDP_FLUSH_DONE
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0__SHIFT                                                             0x0
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1__SHIFT                                                             0x1
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2__SHIFT                                                             0x2
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3__SHIFT                                                             0x3
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4__SHIFT                                                             0x4
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5__SHIFT                                                             0x5
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6__SHIFT                                                             0x6
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7__SHIFT                                                             0x7
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8__SHIFT                                                             0x8
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9__SHIFT                                                             0x9
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0__SHIFT                                                           0xa
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1__SHIFT                                                           0xb
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG0__SHIFT                                                       0xc
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG1__SHIFT                                                       0xd
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG2__SHIFT                                                       0xe
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG3__SHIFT                                                       0xf
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG4__SHIFT                                                       0x10
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG5__SHIFT                                                       0x11
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG6__SHIFT                                                       0x12
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG7__SHIFT                                                       0x13
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG8__SHIFT                                                       0x14
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG9__SHIFT                                                       0x15
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG10__SHIFT                                                      0x16
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG11__SHIFT                                                      0x17
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG12__SHIFT                                                      0x18
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG13__SHIFT                                                      0x19
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG14__SHIFT                                                      0x1a
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG15__SHIFT                                                      0x1b
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG16__SHIFT                                                      0x1c
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG17__SHIFT                                                      0x1d
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG18__SHIFT                                                      0x1e
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG19__SHIFT                                                      0x1f
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK                                                               0x00000001L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK                                                               0x00000002L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK                                                               0x00000004L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK                                                               0x00000008L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK                                                               0x00000010L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK                                                               0x00000020L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK                                                               0x00000040L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK                                                               0x00000080L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK                                                               0x00000100L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK                                                               0x00000200L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK                                                             0x00000400L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK                                                             0x00000800L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK                                                         0x00001000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK                                                         0x00002000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK                                                         0x00004000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK                                                         0x00008000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK                                                         0x00010000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK                                                         0x00020000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK                                                         0x00040000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK                                                         0x00080000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK                                                         0x00100000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG9_MASK                                                         0x00200000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG10_MASK                                                        0x00400000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG11_MASK                                                        0x00800000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG12_MASK                                                        0x01000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG13_MASK                                                        0x02000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG14_MASK                                                        0x04000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG15_MASK                                                        0x08000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG16_MASK                                                        0x10000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG17_MASK                                                        0x20000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG18_MASK                                                        0x40000000L
+#define BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG19_MASK                                                        0x80000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL__S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1__S2A_DOORBELL_PORT0_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL__S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1__S2A_DOORBELL_PORT1_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL__S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1__S2A_DOORBELL_PORT2_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL__S2A_DOORBELL_PORT3_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1__S2A_DOORBELL_PORT3_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL__S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1__S2A_DOORBELL_PORT4_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_ENABLE__SHIFT                                  0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_AWID__SHIFT                                    0x1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_FENCE_ENABLE__SHIFT                            0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_RANGE_OFFSET__SHIFT                            0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_RANGE_SIZE__SHIFT                              0x11
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_64BIT_SUPPORT_DIS__SHIFT                       0x19
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_NEED_DEDUCT_RANGE_OFFSET__SHIFT                0x1a
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_DROP_EN__SHIFT                                 0x1b
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE__SHIFT                      0x1c
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_ENABLE_MASK                                    0x00000001L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_AWID_MASK                                      0x0000003EL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_FENCE_ENABLE_MASK                              0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_RANGE_OFFSET_MASK                              0x0001FF80L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_RANGE_SIZE_MASK                                0x01FE0000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_64BIT_SUPPORT_DIS_MASK                         0x02000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_NEED_DEDUCT_RANGE_OFFSET_MASK                  0x04000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_DROP_EN_MASK                                   0x08000000L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL__S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE_MASK                        0xF0000000L
+//GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_PORT_TYPE__SHIFT                       0x0
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_DIEID__SHIFT                           0x2
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_PORT_ID__SHIFT                         0x4
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_OVERRIDE_POISON_DATA__SHIFT                   0x6
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_4K_PAGE_DECODE_DISABLE__SHIFT                 0x7
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_PORT_TYPE_MASK                         0x00000003L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_DIEID_MASK                             0x0000000CL
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_TARGET_PORT_ID_MASK                           0x00000030L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_OVERRIDE_POISON_DATA_MASK                     0x00000040L
+#define GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1__S2A_DOORBELL_PORT5_4K_PAGE_DECODE_DISABLE_MASK                   0x00000080L
+//RCC_DEV0_EPF2_STRAP2
+#define RCC_DEV0_EPF2_STRAP2__STRAP_TEE_EXCLUSIVE_ATTR_SUPPORTED_DEV0_F2__SHIFT                               0x4
+#define RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2__SHIFT                                              0x7
+#define RCC_DEV0_EPF2_STRAP2__STRAP_RESIZE_BAR_EN_DEV0_F2__SHIFT                                              0x8
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MAX_PASID_WIDTH_DEV0_F2__SHIFT                                            0x9
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MSI_PERVECTOR_MASK_CAP_DEV0_F2__SHIFT                                     0xe
+#define RCC_DEV0_EPF2_STRAP2__STRAP_AER_EN_DEV0_F2__SHIFT                                                     0x10
+#define RCC_DEV0_EPF2_STRAP2__STRAP_ACS_EN_DEV0_F2__SHIFT                                                     0x11
+#define RCC_DEV0_EPF2_STRAP2__STRAP_CPL_ABORT_ERR_EN_DEV0_F2__SHIFT                                           0x14
+#define RCC_DEV0_EPF2_STRAP2__STRAP_DPA_EN_DEV0_F2__SHIFT                                                     0x15
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MSI_MULTI_CAP_DEV0_F2__SHIFT                                              0x18
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_EN_DEV0_F2__SHIFT                                                   0x1c
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_EXE_PERMISSION_SUPPORTED_DEV0_F2__SHIFT                             0x1d
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_GLOBAL_INVALIDATE_SUPPORTED_DEV0_F2__SHIFT                          0x1e
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_PRIV_MODE_SUPPORTED_DEV0_F2__SHIFT                                  0x1f
+#define RCC_DEV0_EPF2_STRAP2__STRAP_TEE_EXCLUSIVE_ATTR_SUPPORTED_DEV0_F2_MASK                                 0x00000010L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK                                                0x00000080L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_RESIZE_BAR_EN_DEV0_F2_MASK                                                0x00000100L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MAX_PASID_WIDTH_DEV0_F2_MASK                                              0x00003E00L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MSI_PERVECTOR_MASK_CAP_DEV0_F2_MASK                                       0x00004000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_AER_EN_DEV0_F2_MASK                                                       0x00010000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_ACS_EN_DEV0_F2_MASK                                                       0x00020000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_CPL_ABORT_ERR_EN_DEV0_F2_MASK                                             0x00100000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_DPA_EN_DEV0_F2_MASK                                                       0x00200000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_MSI_MULTI_CAP_DEV0_F2_MASK                                                0x07000000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_EN_DEV0_F2_MASK                                                     0x10000000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_EXE_PERMISSION_SUPPORTED_DEV0_F2_MASK                               0x20000000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_GLOBAL_INVALIDATE_SUPPORTED_DEV0_F2_MASK                            0x40000000L
+#define RCC_DEV0_EPF2_STRAP2__STRAP_PASID_PRIV_MODE_SUPPORTED_DEV0_F2_MASK                                    0x80000000L
+//REGS_ROM_OFFSET_CTRL
+#define REGS_ROM_OFFSET_CTRL__ROM_OFFSET__SHIFT                                                               0x0
+#define REGS_ROM_OFFSET_CTRL__ROM_OFFSET_MASK                                                                 0x7FL
+//RCC_DEV0_EPF0_1_RCC_CONFIG_MEMSIZE
+#define RCC_DEV0_EPF0_1_RCC_CONFIG_MEMSIZE__CONFIG_MEMSIZE__SHIFT                                             0x0
+#define RCC_DEV0_EPF0_1_RCC_CONFIG_MEMSIZE__CONFIG_MEMSIZE_MASK                                               0xFFFFFFFFL
+
+#endif
-- 
2.17.1

