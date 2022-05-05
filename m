Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35AFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D2F10E288;
	Thu,  5 May 2022 20:04:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0BF10E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyHG3JB+yAlFEWk+Y0VngHul5bNTl0h+VaMkZ/J+K+lwtQTr1ASrMJH30ZGqm48vDk3YBK7IGyF1pcizFHB99u+0nfThY/WLlzUQCt8VNwFq+SaGVZnGTd23VDkrIk1xrd7rbIzCLvGrUDSnbhAt3eIfcxJ8C82oLgLcH95K+X15A2fJstAcpzrpsICyGDQYc1sQ2kHdJc5jUTOh+/iVDshHOvrbbSUxE93CmFx/SS86feqUoOmgIzn1LJ6KUVOuSkb8fwiIQnTIKFQbUczc//WlROTqii5ZuYcq2pTie2UMGA4OmQSp8Hz2Wkqc20b1SJtQdY/WCClitpfkiVU7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXlNXGBXIIK/+eSaKqE4SxE4SGFDkeJhKuCWC4OQFzI=;
 b=P6u5K62c/c2za8+jP2b4wD67buipBxZOzRjqdb6KUM16YH4CG/DCg3F/RAPjssAiZqki6/paFv8BRPekiIHK+4xOsLqbXaXrGWIIGnxmIhsPge7ed7hLyt/QprmEtnXef9QNv7a4HEtLa223MEXiWoc4fLJnExs7cxjyv/HRGt1umsoCjm7rkb7PzmFRkuYZ3+OAj55FPXr57tjP2ED87GDhU64C636YbvyUF1PBuJwZsuQHSsaiwQhanWvhaRQg6p1FNbcyCSUZY9XsMfET5lGoqIfJ1SCRUzaZaDQ9J0mYZFIP9o+wPL5Hc0R4uhuiowxgX/Jo+8oVUOapMOsqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXlNXGBXIIK/+eSaKqE4SxE4SGFDkeJhKuCWC4OQFzI=;
 b=xEDDHTsQKWl47hywX64j4a+ZCNhKtGEW9YDaekjrHZFamQVoaMvi7S/wWm4KlkjcEtDCzG10JSq+FFG9KSl1P7vPzExq78D65R0KRTjlEoJ00Iprn3Ucfc2XGc0QZoxbyur44XIEoJEWS5l60m63r1/nNSwX3Ac7L4qg9EVjxgs=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:04:20 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::de) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 20:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: add lsdma block
Date: Thu, 5 May 2022 16:04:00 -0400
Message-ID: <20220505200406.1293467-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe122d29-1208-4576-aa58-08da2ed27157
X-MS-TrafficTypeDiagnostic: MN0PR12MB6032:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB603251763832A12C4463E35EF7C29@MN0PR12MB6032.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJp4fMONygeQpC9O6iPqRQAgjsA8z86wfgPn0u+BtAYTjq/76Nhx6Wax3rMfUuLQGMlHGJ2OlaD9nSuaydcEE/+9/wJ+ndCNvGH6MixhGeLY9aTXyjltvoY979BvvNQyMqUEo3+hjr8mzgr2CIJHpcGVDuJgn26z7Q/uiMzHVTav5+Dq4oykaSim4+LGMfyIxvwsXmG23dgrgM/Qm7bJ5bjhPNSyEimNb8qvcDkHR4O36n9Yr+RRIsryf2RMVlmbdKGIm0UfF/pniosUcWYrRmljWP0suHE6UfviQH3tFxDELw0FVw7U4SjDryDZZ25zd+SnDamfHya0Mr1QUHH+f+pf5J/v3lx5nVXZ6Z929d6zsLLN7W7zkzka3PjZFWYqlEjIMZzijiFg9wVK5pPGhhp/tAqZ18OczsNOi/db9SE6V7Aja3nhZHq1rsYFjfSYDCZTJbZ5yOofNU2M44BiZYIHfYBniUo/QlL0AbJULofFGS10OqJCj5MTLhINHKoBXUOfUxRSsKtpqKjARTAIit/mSxQRqFRAFJB218YI2LowQlXAIptcldoX/SlP79yoK3fCL7dU1U7ybdOWBuR0nTwQEEIKqUN68E75+cP1TfpRny0pDrULNU0lCuP0F6sECWdIHuw2Y28waxqAUlK/VhHHLWi9kl0UZloz1uKOCs+HT+umYM2tCdL+P09cBkcGtugAjfd8ExTlykoQg/QY6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(356005)(40460700003)(7696005)(336012)(81166007)(426003)(83380400001)(47076005)(316002)(86362001)(82310400005)(186003)(16526019)(30864003)(36756003)(1076003)(36860700001)(4326008)(8936002)(70206006)(70586007)(6666004)(6916009)(8676002)(54906003)(2906002)(508600001)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:20.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe122d29-1208-4576-aa58-08da2ed27157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add Light SDMA (LSDMA) block and related function. LSDMA
is a small instance of SDMA mainly for kernel driver use.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     | 25 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       | 33 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       | 31 ++++++++++++++++
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     |  1 +
 8 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index de7abc7c371f..9ca9f86e04c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o
+	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 578a405f777c..058f272e40ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -86,6 +86,7 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
+#include "amdgpu_lsdma.h"
 #include "amdgpu_nbio.h"
 #include "amdgpu_hdp.h"
 #include "amdgpu_dm.h"
@@ -643,6 +644,7 @@ enum amd_hw_ip_block_type {
 	SDMA5_HWIP,
 	SDMA6_HWIP,
 	SDMA7_HWIP,
+	LSDMA_HWIP,
 	MMHUB_HWIP,
 	ATHUB_HWIP,
 	NBIO_HWIP,
@@ -909,6 +911,9 @@ struct amdgpu_device {
 	/* sdma */
 	struct amdgpu_sdma		sdma;
 
+	/* lsdma */
+	struct amdgpu_lsdma		lsdma;
+
 	/* uvd */
 	struct amdgpu_uvd		uvd;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 263fedadbf5b..3f9f2d6cc6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -66,6 +66,7 @@
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
+#include "lsdma_v6_0.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
@@ -124,6 +125,7 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[SDMA1_HWID]		= "SDMA1",
 	[SDMA2_HWID]		= "SDMA2",
 	[SDMA3_HWID]		= "SDMA3",
+	[LSDMA_HWID]		= "LSDMA",
 	[ISP_HWID]		= "ISP",
 	[DBGU_IO_HWID]		= "DBGU_IO",
 	[DF_HWID]		= "DF",
@@ -173,6 +175,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[SDMA1_HWIP]	= SDMA1_HWID,
 	[SDMA2_HWIP]    = SDMA2_HWID,
 	[SDMA3_HWIP]    = SDMA3_HWID,
+	[LSDMA_HWIP]    = LSDMA_HWID,
 	[MMHUB_HWIP]	= MMHUB_HWID,
 	[ATHUB_HWIP]	= ATHUB_HWID,
 	[NBIO_HWIP]	= NBIF_HWID,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
new file mode 100644
index 000000000000..af00a66f8282
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "amdgpu_lsdma.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
new file mode 100644
index 000000000000..4df4da423181
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_LSDMA_H__
+#define __AMDGPU_LSDMA_H__
+
+struct amdgpu_lsdma {
+	const struct amdgpu_lsdma_funcs      *funcs;
+};
+
+struct amdgpu_lsdma_funcs
+{
+};
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
new file mode 100644
index 000000000000..b611ade53be2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include <linux/delay.h>
+#include "amdgpu.h"
+#include "lsdma_v6_0.h"
+#include "amdgpu_lsdma.h"
+
+#include "lsdma/lsdma_6_0_0_offset.h"
+#include "lsdma/lsdma_6_0_0_sh_mask.h"
+
+const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
new file mode 100644
index 000000000000..3ef79be1a9bf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __LSDMA_V6_0_H__
+#define __LSDMA_V6_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs;
+
+#endif /* __LSDMA_V6_0_H__ */
diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index c1519d20596a..bc9783da7e96 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -86,6 +86,7 @@
 #define PCS_HWID                                          80
 #define DDCL_HWID                                         89
 #define SST_HWID                                          90
+#define LSDMA_HWID                                        91
 #define IOAGR_HWID                                       100
 #define NBIF_HWID                                        108
 #define IOAPIC_HWID                                      124
-- 
2.35.1

