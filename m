Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C97E77179
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE5E10E610;
	Fri,  6 Dec 2024 09:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UnDA2G8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D454B10E610
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp0U5j02rMJspFnXuoqoIPZBeq41nCeC70KlPa2KMj3pS+XwqU7xIvdYfBL6GST1NptlzwYOIIYorxe/rhXuBEfguXwQ0Urzo8mN8zs5d1ChDhydxnvstbKWmaQxYVfflKBt2BWKU62Tnn1svgwHHcKubCPEH6X/PHICqAwa8DlXvKZsIrYnjdoUE6FVbn8DkWINwG8ziJU9alPAKZ287fFgbiVr9EP9fAO5+B5/x0NyWXeBG7feovVGdnhJiyQSD9/tykIC1clDgNzSltD3k85XS3GiormmAWMFyAmo41s17F9F0WhxuJKXUeK8pqUghv34g3kCfmFIMhbXRd6xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnr7E+R4luA7UUbVVEIMm1s/IDX9IC+oF9sp+5/j+T8=;
 b=g61HMDUKXBzbjUE+nVxP78/Txj4jWLXnQsaKk3LS9cVlTKW1c0k7eYRrvDdEpqT9NM/scxc4eTu4Cvsnx52ggnKOOYvS6HPvNaK/1uRmyms9xr+dUCUDwRxetmG/oiHgANzodmRYCXKqgUT+hz8AHE21DN0lcMPmEiksflij/gr20ZEoCvcIAG2So/CictLMdvZNTWrJGCnIo31nybPgSgUbq28Snsi1pUNbjjd7iDXZlGVFITx3oy1U5sOrw69wER/p5cpL9c2GJfMM1W+OOKARqvrQ4PfIhLLWlt8+vkjqnJuMW4ezZ7NRygtw/OrlKztR0h56zumQwElkjqqp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnr7E+R4luA7UUbVVEIMm1s/IDX9IC+oF9sp+5/j+T8=;
 b=1UnDA2G8Yli/wQxZ8YztwKs1j/Sz5X4jHrmXKCQeiEfAU5X2OJUL9f5PPZy7g1XHQU3bv73oqBAHtA5ESRXsgE0wJCHexaBPvTUdHSoO1va42N9UzvMtm0xTQGfQplnvn+Aiah33XPhAMS0PaIzbHPrG603g2+JVbmdTqLTE8+4=
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 09:05:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::3e) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 09:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 09:05:26 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 03:05:24 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add umc v8_14 ras functions
Date: Fri, 6 Dec 2024 17:04:54 +0800
Message-ID: <20241206090455.182520-3-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206090455.182520-1-candice.li@amd.com>
References: <20241206090455.182520-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a197dd-3c65-4142-7d7c-08dd15d52040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RffMI7WeURLOwIoAhlNycIS7kadlMDNW7QwhNhHIOdrMe2oVUMO4lUFDwecZ?=
 =?us-ascii?Q?jymllMIEaTdvi1Opplrx4uMb5lSSb79/rN27QJZSwJhv5lB0tOiwf8eJSQ/T?=
 =?us-ascii?Q?D6rhvSy7F/iT4RsA8Sb4LEVvet6q+9oa7r4sfNmc7D5z+T1N9N5lXGB93mxj?=
 =?us-ascii?Q?BFyKAPiP/M9OFXjM3L4SlB8xo4EhX245Sa1penYT76kzZuYTKPb/RrFHqR52?=
 =?us-ascii?Q?pyEI/i7LKoX8IfoGtPyTBWXU0Oa+S5A4paPTNQ0lFOF/MjlDN0FO/VAw0CbM?=
 =?us-ascii?Q?JgcgTxrO52/z9nNoBbSnA/s103MHJioWErzmyTKKtz3X7HPhqTbpnmxobkAD?=
 =?us-ascii?Q?pHjxPDjfC1aFK+0H0cTDYZfcm4wqlbNTdRsMqhmZw7TsQbWR7AvVoVZkAhNy?=
 =?us-ascii?Q?PkM+rDcLrPQ+Q7VzTrcDGDSTRwu00obtTBQSp8hgqEmJrGhbK/xVdwwDWJxW?=
 =?us-ascii?Q?+zEGmOT0+DsJWem1H+ZikcshvgqB+Mz80eek30mxWlrxWhijmMqLyo1T7G/t?=
 =?us-ascii?Q?i7vYu3e0z+FZzyU5azxniQCcZE1BOJtNV02fRaxY0ENRLv3hn8ap/P+lv8GH?=
 =?us-ascii?Q?U1/kKatRtnGntHggmWtCXtqF02E2TxpBjDq974VqZAxFkTNncMynq3NY4Fa8?=
 =?us-ascii?Q?lqpjbRd4gA7T5c8aC4a3xJfYoynZ3fLw8zPjWhP9weAC9l4BU2DJRgGGM0h+?=
 =?us-ascii?Q?aOk9JNMSzkKDildYCJnPrMjsu5TY4XKwPBLL/Yo/2GPPF/iDuXGBXDXeM0uW?=
 =?us-ascii?Q?ngP+eiImJY1JAWNHNT/Z/rF53Lc/PiKmj6EPDSEJbGchGYjpb+4/s6SJKPwS?=
 =?us-ascii?Q?fEtpXl6mj/szmGkaOzLtmeqqhAEJ8MeMt0oUzd/KRvIFTv3zlH6arlDz9U6/?=
 =?us-ascii?Q?wpw6FZdDV3vVmSBvg6trpJCRWlI0K88dmVPi45gZ6BAc31mXytLQw/cWjZL2?=
 =?us-ascii?Q?c8hHxv9UVNG/Pt+70S10jry7QpiYJ16wMmwOYz5EHE+cmnThHRSRj0kYpLh9?=
 =?us-ascii?Q?OD3bCBE8WpR54YkxPECqiDZJldYWnuRdW2la/peE4L4de/U5jVlbrsvXAlEi?=
 =?us-ascii?Q?L+BYV0WNIcwbsQh5bxsfGWqKZfQFBUtF4YcW+J8VZyMO/omYffKl/rw0MyN1?=
 =?us-ascii?Q?TUaH+JS92CCBOiMT4LdWXYSA4LLMTixk0tCP/hFd4BgQ7scm3WCw6wxCVrVA?=
 =?us-ascii?Q?3ho9YFcZiINrU7w2rgJXZVE9zrxFTnv/avpWqQQ4G4fuEmZ+ius1lX3SXcIF?=
 =?us-ascii?Q?IrWvXCOVwWadJZmlRlO3l6KEzp53VnoB1TeDoG5ZvTwzYlGqnA4++KXFMg4q?=
 =?us-ascii?Q?iScxriQ4Xe/0xf2vSrbXg+phFABghenpY2aCHD9vCRMTzgFClcHUbjU/KThm?=
 =?us-ascii?Q?UfSSOF5btfrORppEhWt5/cQTi40bn8KL3r23Sz8Hl4xC4vQ/JQAuRlEZjfT8?=
 =?us-ascii?Q?9LC7QEpLPycoHvpV9FGnzQYzKpCfH1Y+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:05:26.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a197dd-3c65-4142-7d7c-08dd15d52040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Add umc v8_14 ras functions.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  18 ++-
 drivers/gpu/drm/amd/amdgpu/umc_v8_14.c | 160 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_14.h |  51 ++++++++
 4 files changed, 229 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_14.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_14.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 502adcda7b65cd..88caac49e46e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -106,7 +106,7 @@ amdgpu-y += \
 
 # add UMC block
 amdgpu-y += \
-	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v12_0.o
+	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v12_0.o umc_v8_14.o
 
 # add IH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 621769255ffac2..b749f1c3f6a9af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -40,7 +40,7 @@
 #include "gfxhub_v12_0.h"
 #include "mmhub_v4_1_0.h"
 #include "athub_v4_1_0.h"
-
+#include "umc_v8_14.h"
 
 static int gmc_v12_0_ecc_interrupt_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *src,
@@ -581,6 +581,18 @@ static void gmc_v12_0_set_gmc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v12_0_set_umc_funcs(struct amdgpu_device *adev)
 {
+	switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+	case IP_VERSION(8, 14, 0):
+		adev->umc.channel_inst_num = UMC_V8_14_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V8_14_UMC_INSTANCE_NUM(adev);
+		adev->umc.node_inst_num = 0;
+		adev->umc.max_ras_err_cnt_per_query = UMC_V8_14_TOTAL_CHANNEL_NUM(adev);
+		adev->umc.channel_offs = UMC_V8_14_PER_CHANNEL_OFFSET;
+		adev->umc.ras = &umc_v8_14_ras;
+		break;
+	default:
+		break;
+	}
 }
 
 
@@ -829,6 +841,10 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vm_manager_init(adev);
 
+	r = amdgpu_gmc_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_14.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_14.c
new file mode 100644
index 00000000000000..eaca10a3c4a9df
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_14.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#include "umc_v8_14.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+#include "amdgpu.h"
+#include "umc/umc_8_14_0_offset.h"
+#include "umc/umc_8_14_0_sh_mask.h"
+
+static inline uint32_t get_umc_v8_14_reg_offset(struct amdgpu_device *adev,
+					    uint32_t umc_inst,
+					    uint32_t ch_inst)
+{
+	return adev->umc.channel_offs * ch_inst + UMC_V8_14_INST_DIST * umc_inst;
+}
+
+static int umc_v8_14_clear_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	uint32_t ecc_err_cnt_addr;
+	uint32_t umc_reg_offset =
+		get_umc_v8_14_reg_offset(adev, umc_inst, ch_inst);
+
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_GeccErrCnt);
+
+	/* clear error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V8_14_CE_CNT_INIT);
+
+	return 0;
+}
+
+static void umc_v8_14_clear_error_count(struct amdgpu_device *adev)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v8_14_clear_error_count_per_channel, NULL);
+}
+
+static void umc_v8_14_query_correctable_error_count(struct amdgpu_device *adev,
+						   uint32_t umc_reg_offset,
+						   unsigned long *error_count)
+{
+	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
+
+	/* UMC 8_14 registers */
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_GeccErrCnt);
+
+	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
+	*error_count +=
+		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_GeccErrCnt, GeccErrCnt) -
+		 UMC_V8_14_CE_CNT_INIT);
+}
+
+static void umc_v8_14_query_uncorrectable_error_count(struct amdgpu_device *adev,
+						      uint32_t umc_reg_offset,
+						      unsigned long *error_count)
+{
+	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
+	/* UMC 8_14 registers */
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_GeccErrCnt);
+
+	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
+	*error_count +=
+		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_GeccErrCnt, GeccUnCorrErrCnt) -
+		 UMC_V8_14_CE_CNT_INIT);
+}
+
+static int umc_v8_14_query_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint32_t umc_reg_offset =
+		get_umc_v8_14_reg_offset(adev, umc_inst, ch_inst);
+
+	umc_v8_14_query_correctable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ce_count));
+	umc_v8_14_query_uncorrectable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ue_count));
+
+	return 0;
+}
+
+static void umc_v8_14_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v8_14_query_error_count_per_channel, ras_error_status);
+
+	umc_v8_14_clear_error_count(adev);
+}
+
+static int umc_v8_14_err_cnt_init_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+	uint32_t ecc_err_cnt_addr;
+	uint32_t umc_reg_offset =
+		get_umc_v8_14_reg_offset(adev, umc_inst, ch_inst);
+
+	ecc_err_cnt_sel_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_GeccErrCntSel);
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_GeccErrCnt);
+
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4);
+
+	/* set ce error interrupt type to APIC based interrupt */
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_GeccErrCntSel,
+					GeccErrInt, 0x1);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+	/* set error count to initial value */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V8_14_CE_CNT_INIT);
+
+	return 0;
+}
+
+static void umc_v8_14_err_cnt_init(struct amdgpu_device *adev)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v8_14_err_cnt_init_per_channel, NULL);
+}
+
+const struct amdgpu_ras_block_hw_ops umc_v8_14_ras_hw_ops = {
+	.query_ras_error_count = umc_v8_14_query_ras_error_count,
+};
+
+struct amdgpu_umc_ras umc_v8_14_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v8_14_ras_hw_ops,
+	},
+	.err_cnt_init = umc_v8_14_err_cnt_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_14.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_14.h
new file mode 100644
index 00000000000000..20a258f0017aa1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_14.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#ifndef __UMC_V8_14_H__
+#define __UMC_V8_14_H__
+
+#include "soc15_common.h"
+#include "amdgpu.h"
+
+/* number of umc channel instance with memory map register access */
+#define UMC_V8_14_CHANNEL_INSTANCE_NUM		2
+/* number of umc instance with memory map register access */
+#define UMC_V8_14_UMC_INSTANCE_NUM(adev)		((adev)->umc.node_inst_num)
+
+/* Total channel instances for all available umc nodes */
+#define UMC_V8_14_TOTAL_CHANNEL_NUM(adev) \
+	(UMC_V8_14_CHANNEL_INSTANCE_NUM * (adev)->gmc.num_umc)
+
+/* UMC register per channel offset */
+#define UMC_V8_14_PER_CHANNEL_OFFSET		0x400
+
+#define UMC_V8_14_INST_DIST		0x40000
+
+/* EccErrCnt max value */
+#define UMC_V8_14_CE_CNT_MAX		0xffff
+/* umc ce interrupt threshold */
+#define UMC_V8_14_CE_INT_THRESHOLD		0xffff
+/* umc ce count initial value */
+#define UMC_V8_14_CE_CNT_INIT	(UMC_V8_14_CE_CNT_MAX - UMC_V8_14_CE_INT_THRESHOLD)
+
+extern struct amdgpu_umc_ras umc_v8_14_ras;
+#endif
-- 
2.25.1

