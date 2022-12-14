Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875FEC001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 13:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841DA10E3FE;
	Wed, 14 Dec 2022 13:06:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FC510E402
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 13:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZebjA2o7dqX59KPyq5IEp3++3W3IKIrx+u93AE0r1+eHy1gYkMOUdKBtqtgvcWa0n1BlsngoTZ73EobSiDK9mPtLc40hquYYIWrIZg26e1HkTuEudS/Oa7rwEu6C7l9GrrN846Pni1iUipIcr0tRcEOtzOykURpHRmma0+3d/IUWeEpk/50KMZZLr/qeaMUEasE+ZGvjXmsI+cWM1YYGFl+z7Xvni0HmCE7MkSaWuvv6fX6mDeOdmM1M9oly6wtWnJbaNyOgrFJxD3zf8E1WI/wQY/hq/Bv+YpsMLLR+osCveVoLaGzPcj7+SjvJHMo6NGfP2/SkKIFnwyAwaPwxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uf/nBnLQ6kbC/vIfDAehcJC9k4+z4PFmxuMMCu3Xzs=;
 b=jl0GvYfyf89TZLgI5Wx6rck8iw816+CL+JbRhtKxuQVObYGSFKXonkSb+Qd9qasGcAbkmv1bZHlMHzrIhU/3gCHH/K0NjROHPaWmiT3ZQ50v0/CshiFtccK24C/G7AXo46w3oR8zlRPNkFRLUep4GU71dTiZIaER3dyDa0UeQz3UDOzf0JzS+SYMHF4WacqfpYLIHtRM1WQCrwRsdIlsZmaKwl8NVF4NahnRkvrtlAbVxxCpWy0D1B1fjW6jgylaGIdoTbYdprwITQnCycY5RlloKzBs39tIJyBWfJuo4WoyU8m2UGdOUH+Q3EQAxM/GAxCTZGJBDLJVftIhVd9Faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uf/nBnLQ6kbC/vIfDAehcJC9k4+z4PFmxuMMCu3Xzs=;
 b=A4q60aVF5eSWm62BLo0Ev4dBaI/n8FX92b61kirz9lnAoe2jkMW8xVdM8kaPnicD/UBBU6uO4vhpm+r77hcdsZlXyQeKKJEqK89JfYRWzxf7gEi7h0ypirFBzVWmOD7WNS/u4LLL8joXJXlG40z+PfFfMEopPKsPYrwZYTB0oXI=
Received: from MW4PR04CA0345.namprd04.prod.outlook.com (2603:10b6:303:8a::20)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 13:06:34 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::39) by MW4PR04CA0345.outlook.office365.com
 (2603:10b6:303:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 13:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 13:06:33 +0000
Received: from candice-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 07:06:32 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add poison mode query for df v4_3
Date: Wed, 14 Dec 2022 21:06:19 +0800
Message-ID: <20221214130619.1027585-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: a87f69ea-5d11-437f-fd11-08daddd406a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bti0R1qPgwpE/7xK/KHrxsbC5Ezdd794MhzYAhZjAfnN8lCtCWFQQ/ujQ3yRTEpVdHSO2A4lZ7U7PHOXANJpr55DDAxskYzBYBbHTyeDGg+Kg8ckySPj2kUFbGU6nzTB0aYlo67Duffq3fIHEKRQ9CUbsCfDxHuS+QkReRybh18UYyb0vaABScgHBJfGJpOavthJ+2S5+nZw2MLcqI6A+Jfc8gnd0olceQmDaHEFl8fd82kW8k9+onEuAPEYWJ0DICQonvPLdmPnGLNIWjBFyLat5X+TcpWVgFkIg/Irs2iFZWAaoOz1Pa7YZGevGCzqQRF6vxAnKHQlFcqFVFuMylCfuHKUVAN9YXze2aykivIzaE6hndWjxnp8ML1DlcOBA2aUzAXBiQJoX4H1bXf0vMDn+tejqinrGq9Wl6zizCptxp/yN3cRdDp7Xji8c0LiEDv2xK02XGv/mmaOwQ4ju1PAg1zYwE9LXGfXBFXArxcNmm2fs/ECSPTo2iPWV91aIZptgyr6q63wEhj0rOvPVeuOTxxT3W2ZhLLy7SO/cXo7iu50kaAANUYW0Tyhh8x5qdA1067N1MF730wBSzHBT7YLYrHRUQFsl62MwCG623Z5pR0OIxJ2Q33yH2twlWIhrixY1Zgr9YhT5LqupGjZbvHUyUFKusPe24sUiazZ0Bf9KySllvINrrGwFw1qANADEHmYStl3lzycv7FlKvZ5OV0O7TdkVwamw2QOd5b1l4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(81166007)(4326008)(356005)(8676002)(70206006)(70586007)(186003)(7696005)(16526019)(478600001)(1076003)(86362001)(2616005)(40480700001)(6916009)(82310400005)(36756003)(54906003)(426003)(47076005)(316002)(40460700003)(336012)(66899015)(36860700001)(2906002)(41300700001)(8936002)(44832011)(26005)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 13:06:33.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87f69ea-5d11-437f-fd11-08daddd406a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add poison mode query support on df v4_3.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/df_v4_3.c          | 61 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v4_3.h          | 31 ++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 798d0e9a60b7dc..332cf8bda7a2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -81,7 +81,8 @@ amdgpu-y += \
 # add DF block
 amdgpu-y += \
 	df_v1_7.o \
-	df_v3_6.o
+	df_v3_6.o \
+	df_v4_3.o
 
 # add GMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1bbd56029a4f90..b719852daa071a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -33,6 +33,7 @@
 #include "gmc_v9_0.h"
 #include "df_v1_7.h"
 #include "df_v3_6.h"
+#include "df_v4_3.h"
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
@@ -2329,6 +2330,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 2):
 		adev->df.funcs = &df_v1_7_funcs;
 		break;
+	case IP_VERSION(4, 3, 0):
+		adev->df.funcs = &df_v4_3_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_3.c b/drivers/gpu/drm/amd/amdgpu/df_v4_3.c
new file mode 100644
index 00000000000000..e8b9e19ede2e11
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_3.c
@@ -0,0 +1,61 @@
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
+#include "amdgpu.h"
+#include "df_v4_3.h"
+
+#include "df/df_4_3_offset.h"
+#include "df/df_4_3_sh_mask.h"
+
+static bool df_v4_3_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	uint32_t hw_assert_msklo, hw_assert_mskhi;
+	uint32_t v0, v1, v28, v31;
+
+	hw_assert_msklo = RREG32_SOC15(DF, 0,
+				regDF_CS_UMC_AON0_HardwareAssertMaskLow);
+	hw_assert_mskhi = RREG32_SOC15(DF, 0,
+				regDF_NCS_PG0_HardwareAssertMaskHigh);
+
+	v0 = REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk0);
+	v1 = REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk1);
+	v28 = REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk28);
+	v31 = REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk31);
+
+	if (v0 && v1 && v28 && v31)
+		return true;
+	else if (!v0 && !v1 && !v28 && !v31)
+		return false;
+	else {
+		dev_warn(adev->dev, "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
+				v0, v1, v28, v31);
+		return false;
+	}
+}
+
+const struct amdgpu_df_funcs df_v4_3_funcs = {
+	.query_ras_poison_mode = df_v4_3_query_ras_poison_mode,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_3.h b/drivers/gpu/drm/amd/amdgpu/df_v4_3.h
new file mode 100644
index 00000000000000..06ef0724edd3d7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_3.h
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
+#ifndef __DF_V4_3_H__
+#define __DF_V4_3_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_df_funcs df_v4_3_funcs;
+
+#endif
-- 
2.25.1

