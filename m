Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9CEC2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 17:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD1710ED79;
	Fri, 12 Jul 2024 17:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0R9ebITs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637D410ED79
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 17:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frGB4BpJHZ/zjktpZuJNQggfHKvrpuz9oX/LVllPST22leRaFhlzdUN5rnHYZeNgahJ/ggZeJBEANuO9SpuUrhYgykXEN3rgr+Uij5drm8xN4TyAEVsAO8D2h6dOnrYC5JeVPFWxLdEAurdddRjrv7Le68vBzqMfIB06OdBfhTrUTP4Hco0MODOHhovfW1Y3mZ3A2CmYTmmN3NjVYNU/tu+agIe0L+KHBOTNwT3mYzvOLntpjVO0rZgBeElYhx1iJDUW5Hh8K2ro/g391XCKGsw4SD33jLfcCePrEi05a5lhT+lB0NbvuZl7+iYOZdIKC+d2gx9qBNRc+AbR8tzf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlxRvxznJUpSZy7azhpW1yyOmV8GoF9YqlUHSC+fMs4=;
 b=p3nNfeyTuAWEOyEZ4Uc4Z3zoncA6k/rj9sUyLJEK6t1MdIShhcWjU2NexP8Nf9KCxCfmod4mAT8t9pTXSCccX3UxjI9w7uxv2tl/G5pu18WDncbln0wEqwVCb53r7ocJR168C6HpH9ti0tj87LheBJ5n3XcbIe0q357SstS70JhBisAlwEXfB5hCVPduGH0UaeYXS4WcIs0U0OTm2FcKeCGOxu4EjtuheWr66/v6EFdkjtQ9n7NKVGUg0i5sU50aJrd0C+S1D6q1ScCpdJDDSg2dYGw8Xb6iitsRwA3I6pqCyCfdLCkk0XnryXaHoGIhpPc/Wi8af9aTkn8MFRu74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlxRvxznJUpSZy7azhpW1yyOmV8GoF9YqlUHSC+fMs4=;
 b=0R9ebITsRDNk0moTMoOVvvbLjsgkzG03Msy2ilpgaHdWbU7+QO/fTm5m1Q0MY9LrFuyecsZfAcONPIdElsv8SqF8HDAFvaAZBgV/CTUVDOt+CixpLuHmVbfymWfgmP/E9+6PBhJqhyE1M8Yok21LBhEDEUKsRiPpEqzKTX0oNI4=
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:29:36 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::9d) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 17:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 17:29:35 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 12:29:34 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix atomics on GFX12
Date: Fri, 12 Jul 2024 13:29:13 -0400
Message-ID: <20240712172913.1876626-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf7607b-ebeb-4a08-3587-08dca298335d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z+lN0j/PVOT11lCGv+k/tLRoNZJRHM15P20Gqikc5hj4OCQrqyCoUThUXqrI?=
 =?us-ascii?Q?0VnyTq6GaMz6JIwROuGAMqz2YljdJhAZWl2tMjySHhalapBDdvDOfKbp/SCZ?=
 =?us-ascii?Q?vcqBHKSPYDSiGm+yoBeZndNjnm/10H8HCovotlSEbPJWQGNgcCgdbNIos8m+?=
 =?us-ascii?Q?nCSd6EpsYSuaq45rMHtON7p6h/QSZfg/cM6LDodwdWRugnAQsDG+ECNKVucA?=
 =?us-ascii?Q?7/n1eNS8iPjl3SPoFYKGveV8r86MaEwrVw5V+xfzqYBecrCQVnafgCpP4tQ9?=
 =?us-ascii?Q?9a1HU53MzXzIlOg2fWUb8l8SK64SF29W/yEfPyuCrb97WUe1cJfeNAM6XUra?=
 =?us-ascii?Q?qbn/zdsRWSpYL/t0F861k/ZqxuiIHshrbfAtskMT7yKYw9O8TzPjC3bvrjaq?=
 =?us-ascii?Q?7PQM6A4npwP1KnxHEFWc3fMhDt/REFf2/vLKXpzULMcHVbXFJXEtjdId4diI?=
 =?us-ascii?Q?7Lg7HqCZWcqZgUqwLBXIJLlNxbhnJgHeIccItatWyh0dbmlUAZse289VE8WR?=
 =?us-ascii?Q?41K1wHHwSwkKS4T5BFfMB2tQocLQ4vwm0pI2LuoOw1VhFO8eGXuGrhvnn5bx?=
 =?us-ascii?Q?8sTkl92Q55yLn9rTXVAjlJO9pJesHbaa8vYIEgY2IfXwGHMNMuPObJlxALk4?=
 =?us-ascii?Q?RgWM/gVxloZTiMwC+87i4c37SQMxTfAA/nvYzN8FY75uzUPlIgDkYNg71sW2?=
 =?us-ascii?Q?8+F82yclzNeiZf7GXSe2IOhFd9f+03CphpiU+uFPgXT0bXz5HG8OqF13TBwU?=
 =?us-ascii?Q?LalwwGPQpiALjl3B187FMSKjVhaHWR+Dji+iBuc3Kw69wHT8DqeGN4aa9RIr?=
 =?us-ascii?Q?W99GjhZm2UsFwLELvbKvIUMkmfwA4jfkWKugZKIo9bOI0J+LUl2zlJkqfzK1?=
 =?us-ascii?Q?eh2S6XLt0HMwYfntiEakqKoxqp7UMVvTVko17cxqodbfwAXSUl408GBcN88i?=
 =?us-ascii?Q?AXwGqWExykmn28z/XiT3JQ2i/zz3jthk2LoOHw1Hh/ndesR9BcT6PhC1HpPx?=
 =?us-ascii?Q?OfRneHgOQynvxrB8nsn5euEX62R7qaiuqiZFdmUNbPebQX0YCZQVUy5/BuGb?=
 =?us-ascii?Q?X4zBCClkdFbXCxU259jecQSeNz33x6GGBYSr46E8I3Q6LA3h+I4LsVoau2i6?=
 =?us-ascii?Q?toKJxHyBdNvluWh3n84puTJaSqDjVKamAPTUq3CAfPU57BGo/JED3DALfbw7?=
 =?us-ascii?Q?AxDOnH/T1/yQ2YMid5J0uB57SZW21oguBvEhkMaouve5AeKvu8xNarwQkVGH?=
 =?us-ascii?Q?qn1yP1L5i0k4ACMRWMHepCPaqfV0jGykz2fmYEd7fnXntpeawOXwQAS3+Kag?=
 =?us-ascii?Q?jdqDXy/giMt277ahihOVhNWLIReIVDTL9Z9xM/oUqcC7h1IBZ15BKAG/X42V?=
 =?us-ascii?Q?/PSfIp6uX9YgmM8To7DRCkRy83a6+TxDTjgDLHGksHpz2J39Mu7hTUKmtFGT?=
 =?us-ascii?Q?edgtcW8yItY4dlyddvnIEMfEDhTuIE1X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 17:29:35.8993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf7607b-ebeb-4a08-3587-08dca298335d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

If PCIe supports atomics, configure register to prevent DF from
breaking atomics in separate load/store operations.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/df_v4_15.c         | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v4_15.h         | 30 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  4 ++
 .../amd/include/asic_reg/df/df_4_15_offset.h  | 28 ++++++++++++
 .../amd/include/asic_reg/df/df_4_15_sh_mask.h | 28 ++++++++++++
 8 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_15.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_15.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_sh_mask.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index eddbb69a179f..ec099aadf334 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -106,7 +106,8 @@ amdgpu-y += \
 	df_v1_7.o \
 	df_v3_6.o \
 	df_v4_3.o \
-	df_v4_6_2.o
+	df_v4_6_2.o \
+	df_v4_15.o
 
 # add GMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 1538b2dbfff1..eb605e79ae0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -33,6 +33,7 @@ struct amdgpu_df_hash_status {
 struct amdgpu_df_funcs {
 	void (*sw_init)(struct amdgpu_device *adev);
 	void (*sw_fini)(struct amdgpu_device *adev);
+	void (*hw_init)(struct amdgpu_device *adev);
 	void (*enable_broadcast_mode)(struct amdgpu_device *adev,
 				      bool enable);
 	u32 (*get_fb_channel_number)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b241f61fe9c9..ac108fca64fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -37,6 +37,7 @@
 #include "df_v3_6.h"
 #include "df_v4_3.h"
 #include "df_v4_6_2.h"
+#include "df_v4_15.h"
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
@@ -2803,6 +2804,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 6, 2):
 		adev->df.funcs = &df_v4_6_2_funcs;
 		break;
+	case IP_VERSION(4, 15, 0):
+	case IP_VERSION(4, 15, 1):
+		adev->df.funcs = &df_v4_15_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_15.c b/drivers/gpu/drm/amd/amdgpu/df_v4_15.c
new file mode 100644
index 000000000000..2a573e33908b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_15.c
@@ -0,0 +1,45 @@
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
+#include "amdgpu.h"
+#include "df_v4_15.h"
+
+#include "df/df_4_15_offset.h"
+#include "df/df_4_15_sh_mask.h"
+
+static void df_v4_15_hw_init(struct amdgpu_device *adev)
+{
+	if (adev->have_atomics_support) {
+		uint32_t tmp;
+		uint32_t dis_lcl_proc = (1 <<  1 |
+					1 <<  2 |
+					1 << 13);
+
+		tmp = RREG32_SOC15(DF, 0, regNCSConfigurationRegister1);
+		tmp |= (dis_lcl_proc << NCSConfigurationRegister1__DisIntAtomicsLclProcessing__SHIFT);
+		WREG32_SOC15(DF, 0, regNCSConfigurationRegister1, tmp);
+	}
+}
+
+const struct amdgpu_df_funcs df_v4_15_funcs = {
+	.hw_init = df_v4_15_hw_init
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_15.h b/drivers/gpu/drm/amd/amdgpu/df_v4_15.h
new file mode 100644
index 000000000000..dddf2422112a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_15.h
@@ -0,0 +1,30 @@
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
+
+#ifndef __DF_V4_15_H__
+#define __DF_V4_15_H__
+
+extern const struct amdgpu_df_funcs df_v4_15_funcs;
+
+#endif /* __DF_V4_15_H__ */
+
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d27fb4ea6612..7d641d0dadba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -484,6 +484,10 @@ static int soc24_common_hw_init(void *handle)
 	 */
 	if (adev->nbio.funcs->remap_hdp_registers)
 		adev->nbio.funcs->remap_hdp_registers(adev);
+
+	if (adev->df.funcs->hw_init)
+		adev->df.funcs->hw_init(adev);
+
 	/* enable the doorbell aperture */
 	soc24_enable_doorbell_aperture(adev, true);
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_offset.h
new file mode 100644
index 000000000000..c2b009752f60
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_offset.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2024  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _df_4_15_OFFSET_HEADER
+#define _df_4_15_OFFSET_HEADER
+
+#define regNCSConfigurationRegister1               0x0901
+#define regNCSConfigurationRegister1_BASE_IDX           4
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_sh_mask.h
new file mode 100644
index 000000000000..9868a9c32795
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_sh_mask.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2024  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _df_4_15_SH_MASK_HEADER
+#define _df_4_15_SH_MASK_HEADER
+
+#define NCSConfigurationRegister1__DisIntAtomicsLclProcessing__SHIFT         0x3
+#define NCSConfigurationRegister1__DisIntAtomicsLclProcessing_MASK    0x0003FFF8L
+
+#endif
-- 
2.41.0

