Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456A9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 20:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3411A10E7AB;
	Thu, 17 Feb 2022 20:19:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9018D10E79F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 20:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgxb2MwYM4OurTTKHzSax/P/C9fSFu/+CKhw2ev8moh/pXkfZGTHda92Os+9vGm6X6lzIvqgwIend9ks1vu/JLtzAmxlhDmfIh2JN4eBvOIqroY5PHRaF0QhlP04SDXL7Pl7IEFs66NllYM+D3ITW1yKciPew4Z7jcOciYTnxdGv8UZNYLF1hMj56CSqkq+1skdBOVn4uspMtu2E7EiXy/+2fTh7nxTBPwBhU8bUku08/WBJLzlXlazploqjEnbhAPo7uVuqdVMDRwIe9KRD7JC2VmHbE9n+TJqy7swr5jAjbKUZho8mUwvlzmXjp/thvT8sGmhv5VbemlfB2qdV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37z7ROzVhA76/ves88qFGyxOBYlukRITcqZNzOOBU+E=;
 b=LlGPq4f58t3yWJORSy5FMQowW6mjEUn5E3OTUXBrD7UxcOZmMPRQadedR1A90qTp9vnNwmY2m9vBtx/IhyidsMf+7snCaBIQo1JzloOaD6h6luin5fiwceIcDqb6sHcnMGRwUOHBHoCnpZKuIRsg40Q2VpClC0mPP4pf5/C0uCUX09ka3LC9BtaNqLmxs/kw+hdIMNb4eq46N8tkeTjpVL802lXhZbEdSa3c2tl9SljbrD1seVhRl6eCHO2Hjv1U+cz+ozEMbeXljXSrkO3tB13e5/SdbY735vzRdamVw3POtx3EK3cq9mVTe6d/jRYsYZ8j5cFSFJpmQNyDnBzN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37z7ROzVhA76/ves88qFGyxOBYlukRITcqZNzOOBU+E=;
 b=gz/+vTpbcyGygwtX9gZVlKPMKaCDB7EVKAVgK8qGnIthcopeY9Ov9Q9BXw+6IBoaVBpBNBAa0DMgs+YNEHs3vn6kOdzOqyZWsPsM6eSPyLEstIZ+0VpbGAm5CRY/Y1lrM4w+fobZqh4zBRFhNBxAhoOUQw/Vp/CbQcjDNkJfVXU=
Received: from BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 20:19:42 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::c3) by BN6PR18CA0010.outlook.office365.com
 (2603:10b6:404:121::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Thu, 17 Feb 2022 20:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 20:19:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 14:19:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: add smu_v13_0_5_ppt implementation
Date: Thu, 17 Feb 2022 15:19:26 -0500
Message-ID: <20220217201926.302025-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217201926.302025-1-alexander.deucher@amd.com>
References: <20220217201926.302025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e223f86c-c14c-466f-80c4-08d9f252d4c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125EF083C1A1EBB388533C6F7369@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aTJjK2TaTlitQZogKLoJaaFFKlxKj/X3YKg9YAUlHq4NZ2nmE+p8AE29DxPDHc0aIlQPfyEoqLqO0MO/mBweJNI+EVDk4N1ydUgLxZW0gdszLFFHjH10L/fZP712ARUVFHwMt3Dn+x0Z6ujMFgVj2vunJXLd1JKGcNhWBdqX9SlCWBhlj9rwnuas6FzhHiFMFC3CVZdjo4vD4FhrzhbOGxV6AZ/cOnhnNINjqd6UEoGrxIfUHsvsP20u86/n2xT3IJrossCT70YlzYZ8oUJvHAaiP91AbWfvxYOFvVFUVfSH0U+XLcgdlvSBF0e2K1HY1HCStquWjut148tpUVKnTvvcoMPVKhPorStXhzXxY0JfH5L5ZiSYtbfl3Yt8aJpX9ENuyWgSt3PBteEsgemUwLGxC8KzoyAQVS4TfLaeFHZpcZsI596t+m1k1xggbwVz/dQwfSAU0YNDvBE+d9WS5KlRsElq0y20/yE97bhEhEzqLHredIpFtey4mxUhyzc+nlXf8zQBzWkTSV33qkixfxf5UySXD7NJFYz6M0lwHp+tmhTX2j3ema+NeMXJzXq0tdsIXj9qPMf1s8iAZ9q3nSP5Z4ZQRJW85cButo+c9kM+B8qgzNQm4nP7SROWNs9HS3ogCc8GNx+8WiOSwAPagQX+kNnCN9OZDVzpxO6E338HT/flaoxoRP/t7Ke2jjU8x1aZ/8m5mCER+RMyTqp0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(83380400001)(8676002)(2616005)(4326008)(16526019)(36756003)(30864003)(40460700003)(26005)(186003)(1076003)(6916009)(54906003)(508600001)(5660300002)(19627235002)(82310400004)(47076005)(36860700001)(7696005)(316002)(336012)(426003)(356005)(8936002)(2906002)(6666004)(81166007)(86362001)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 20:19:41.9651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e223f86c-c14c-466f-80c4-08d9f252d4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds smu_v13_0_5_ppt implementation.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    4 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |    3 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 1142 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |   28 +
 8 files changed, 1183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e07cd65a4d28..9ec7f723242b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1340,6 +1340,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cd22f15e8707..7e79a67bb8ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -37,6 +37,7 @@
 #include "aldebaran_ppt.h"
 #include "yellow_carp_ppt.h"
 #include "cyan_skillfish_ppt.h"
+#include "smu_v13_0_5_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -535,6 +536,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 		yellow_carp_set_ppt_funcs(smu);
 		break;
+	case IP_VERSION(13, 0, 5):
+		smu_v13_0_5_set_ppt_funcs(smu);
+		break;
 	case IP_VERSION(11, 0, 8):
 		cyan_skillfish_set_ppt_funcs(smu);
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index ff8a0bcbd290..d787c3b9fc52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -190,6 +190,7 @@
 	__SMU_DUMMY_MAP(PowerUpCvip),                    \
 	__SMU_DUMMY_MAP(PowerDownCvip),                  \
        __SMU_DUMMY_MAP(EnableGfxOff),                   \
+       __SMU_DUMMY_MAP(DisableGfxOff),                   \
        __SMU_DUMMY_MAP(SetSoftMinGfxclk),               \
        __SMU_DUMMY_MAP(SetSoftMinFclk),                 \
        __SMU_DUMMY_MAP(GetThermalLimit),                \
@@ -229,6 +230,7 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
+	__SMU_DUMMY_MAP(Spare0),                  \
 	__SMU_DUMMY_MAP(UnforceGfxVid),           \
 	__SMU_DUMMY_MAP(HeavySBR),
 
@@ -362,6 +364,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(SMUIO_CG),			\
        __SMU_DUMMY_MAP(THM_CG),				\
        __SMU_DUMMY_MAP(CLK_CG),				\
+       __SMU_DUMMY_MAP(DATA_CALCULATION),				\
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 44af23ae059e..d0d5b9b2c65b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,6 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index d4c4c495762c..613cdd0d8e83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o
+SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o smu_v13_0_5_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index df6cbb7feef7..261a3749c089 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -221,6 +221,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(13, 0, 8):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
+	case IP_VERSION(13, 0, 5):
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_5;
+		break;
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
 			adev->ip_versions[MP1_HWIP][0]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
new file mode 100644
index 000000000000..093b9144464b
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -0,0 +1,1142 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#define SWSMU_CODE_LAYER_L2
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v13_0.h"
+#include "smu13_driver_if_v13_0_5.h"
+#include "smu_v13_0_5_ppt.h"
+#include "smu_v13_0_5_ppsmc.h"
+#include "smu_v13_0_5_pmfw.h"
+#include "smu_cmn.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE ( \
+	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
+	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT))
+
+static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
+	MSG_MAP(EnableGfxOff,             PPSMC_MSG_EnableGfxOff,		1),
+	MSG_MAP(DisableGfxOff,                   PPSMC_MSG_DisableGfxOff,			1),
+	MSG_MAP(PowerDownVcn,                    PPSMC_MSG_PowerDownVcn,			1),
+	MSG_MAP(PowerUpVcn,                 PPSMC_MSG_PowerUpVcn,		1),
+	MSG_MAP(SetHardMinVcn,                   PPSMC_MSG_SetHardMinVcn,			1),
+	MSG_MAP(SetSoftMinGfxclk,                     PPSMC_MSG_SetSoftMinGfxclk,			1),
+	MSG_MAP(Spare0,                  PPSMC_MSG_Spare0,		1),
+	MSG_MAP(GfxDeviceDriverReset,            PPSMC_MSG_GfxDeviceDriverReset,		1),
+	MSG_MAP(SetDriverDramAddrHigh,            PPSMC_MSG_SetDriverDramAddrHigh,      1),
+	MSG_MAP(SetDriverDramAddrLow,          PPSMC_MSG_SetDriverDramAddrLow,	1),
+	MSG_MAP(TransferTableSmu2Dram,           PPSMC_MSG_TransferTableSmu2Dram,		1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu ,	1),
+	MSG_MAP(GetGfxclkFrequency,          PPSMC_MSG_GetGfxclkFrequency,	1),
+	MSG_MAP(GetEnabledSmuFeatures,           PPSMC_MSG_GetEnabledSmuFeatures,		1),
+	MSG_MAP(SetSoftMaxVcn,          PPSMC_MSG_SetSoftMaxVcn,	1),
+	MSG_MAP(PowerDownJpeg,         PPSMC_MSG_PowerDownJpeg,	1),
+	MSG_MAP(PowerUpJpeg,                  PPSMC_MSG_PowerUpJpeg,		1),
+	MSG_MAP(SetSoftMaxGfxClk,             PPSMC_MSG_SetSoftMaxGfxClk,		1),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		1),
+	MSG_MAP(AllowGfxOff,               PPSMC_MSG_AllowGfxOff,		1),
+	MSG_MAP(DisallowGfxOff,               PPSMC_MSG_DisallowGfxOff,		1),
+	MSG_MAP(SetSoftMinVcn,         PPSMC_MSG_SetSoftMinVcn,	1),
+	MSG_MAP(GetDriverIfVersion,           PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(PrepareMp1ForUnload,                  PPSMC_MSG_PrepareMp1ForUnload,		1),
+};
+
+static struct cmn2asic_mapping smu_v13_0_5_feature_mask_map[SMU_FEATURE_COUNT] = {
+	FEA_MAP(DATA_CALCULATION),
+	FEA_MAP(PPT),
+	FEA_MAP(TDC),
+	FEA_MAP(THERMAL),
+	FEA_MAP(PROCHOT),
+	FEA_MAP(CCLK_DPM),
+	FEA_MAP_REVERSE(FCLK),
+	FEA_MAP(LCLK_DPM),
+	FEA_MAP(DF_CSTATES),
+	FEA_MAP(FAN_CONTROLLER),
+	FEA_MAP(CPPC),
+	FEA_MAP_HALF_REVERSE(GFX),
+	FEA_MAP(DS_GFXCLK),
+	FEA_MAP(S0I3),
+	FEA_MAP(VCN_DPM),
+	FEA_MAP(DS_VCN),
+	FEA_MAP(DCFCLK_DPM),
+	FEA_MAP(ATHUB_PG),
+	FEA_MAP_REVERSE(SOCCLK),
+	FEA_MAP(SHUBCLK_DPM),
+	FEA_MAP(GFXOFF),
+};
+
+static struct cmn2asic_mapping smu_v13_0_5_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP_VALID(WATERMARKS),
+	TAB_MAP_VALID(SMU_METRICS),
+	TAB_MAP_VALID(CUSTOM_DPM),
+	TAB_MAP_VALID(DPMCLOCKS),
+};
+
+static int smu_v13_0_5_init_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+	if (!smu_table->clocks_table)
+		goto err0_out;
+
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		goto err1_out;
+	smu_table->metrics_time = 0;
+
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		goto err2_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err3_out;
+
+	return 0;
+
+err3_out:
+	kfree(smu_table->watermarks_table);
+err2_out:
+	kfree(smu_table->metrics_table);
+err1_out:
+	kfree(smu_table->clocks_table);
+err0_out:
+	return -ENOMEM;
+}
+
+static int smu_v13_0_5_fini_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	kfree(smu_table->clocks_table);
+	smu_table->clocks_table = NULL;
+
+	kfree(smu_table->metrics_table);
+	smu_table->metrics_table = NULL;
+
+	kfree(smu_table->watermarks_table);
+	smu_table->watermarks_table = NULL;
+
+	return 0;
+}
+
+static int smu_v13_0_5_system_features_control(struct smu_context *smu, bool en)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (!en && !adev->in_s0ix)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
+	return ret;
+}
+
+static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (enable)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
+						      0, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
+						      0, NULL);
+
+	return ret;
+}
+
+static int smu_v13_0_5_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg,
+						      0, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_PowerDownJpeg, 0,
+						      NULL);
+
+	return ret;
+}
+
+
+static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
+{
+	int ret = 0;
+	uint64_t feature_enabled;
+
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+
+	if (ret)
+		return false;
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
+
+static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
+{
+	/*
+	struct amdgpu_device *adev = smu->adev;
+	*/
+	int ret = 0;
+
+	/* allow message will be sent after enable gfxoff on smu 13.0.5 */
+	/*
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
+	if (ret)
+		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
+	*/
+	return ret;
+}
+
+static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
+{
+	int ret = 0, index = 0;
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+				SMU_MSG_GfxDeviceDriverReset);
+	if (index < 0)
+		return index == -EACCES ? 0 : index;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to mode reset!\n");
+
+	return ret;
+}
+
+static int smu_v13_0_5_mode2_reset(struct smu_context *smu)
+{
+	return smu_v13_0_5_mode_reset(smu, SMU_RESET_MODE_2);
+}
+
+static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
+							MetricsMember_t member,
+							uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
+		return ret;
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->GfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->SocclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->VclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = metrics->DclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->MemclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->GfxActivity / 100;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->UvdActivity;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->GfxTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->SocTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->Voltage[0];
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = metrics->Voltage[1];
+		break;
+#if 0
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOpnLimit > 0)
+			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+			*value = (metrics->dGpuPower * 100) /
+				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
+		else
+			*value = 0;
+		break;
+#endif
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_5_read_sensor(struct smu_context *smu,
+					enum amd_pp_sensors sensor,
+					void *data, uint32_t *size)
+{
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_GFXACTIVITY,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_SOCKETPOWER,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_TEMPERATURE_EDGE,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_TEMPERATURE_HOTSPOT,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_UCLK,
+								(uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_GFXCLK,
+								(uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_VOLTAGE_VDDGFX,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+								METRICS_VOLTAGE_VDDSOC,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+						       METRICS_SS_APU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+						       METRICS_SS_DGPU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_5_set_watermarks_table(struct smu_context *smu,
+				struct pp_smu_wm_range_sets *clock_ranges)
+{
+	int i;
+	int ret = 0;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
+
+	if (!table || !clock_ranges)
+		return -EINVAL;
+
+	if (clock_ranges) {
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+			clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
+			return -EINVAL;
+
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+			table->WatermarkRow[WM_DCFCLK][i].MinClock =
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
+		}
+
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
+		}
+
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+	}
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_cmn_write_watermarks_table(smu);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
+}
+
+static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
+						void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	/*
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature;
+	*/
+
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.UvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_gfx_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	/*
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 8);
+	*/
+
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
+
+	/*
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency;
+	*/
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_1);
+}
+
+static int smu_v13_0_5_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
+static int smu_v13_0_5_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
+					long input[], uint32_t size)
+{
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+	int ret = 0;
+
+	/* Only allowed in manual mode */
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
+			if (input[1] < smu->gfx_default_hard_min_freq) {
+				dev_warn(smu->adev->dev,
+					"Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_hard_min_freq = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > smu->gfx_default_soft_max_freq) {
+				dev_warn(smu->adev->dev,
+					"Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_soft_max_freq = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+		}
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+				dev_err(smu->adev->dev,
+					"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+					smu->gfx_actual_hard_min_freq,
+					smu->gfx_actual_soft_max_freq);
+				return -EINVAL;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+									smu->gfx_actual_hard_min_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set hard min sclk failed!");
+				return ret;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+									smu->gfx_actual_soft_max_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set soft max sclk failed!");
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_5_get_current_clk_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		member_type = METRICS_AVERAGE_SOCCLK;
+		break;
+	case SMU_VCLK:
+	    member_type = METRICS_AVERAGE_VCLK;
+		break;
+	case SMU_DCLK:
+		member_type = METRICS_AVERAGE_DCLK;
+		break;
+	case SMU_MCLK:
+		member_type = METRICS_AVERAGE_UCLK;
+		break;
+	case SMU_FCLK:
+		return smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_GetFclkFrequency, 0, value);
+	default:
+		return -EINVAL;
+	}
+
+	return smu_v13_0_5_get_smu_metrics_data(smu, member_type, value);
+}
+
+static int smu_v13_0_5_get_dpm_level_count(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *count)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		*count = clk_table->NumSocClkLevelsEnabled;
+		break;
+	case SMU_VCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_DCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_MCLK:
+		*count = clk_table->NumDfPstatesEnabled;
+		break;
+	case SMU_FCLK:
+		*count = clk_table->NumDfPstatesEnabled;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int smu_v13_0_5_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	if (!clk_table || clk_type >= SMU_CLK_COUNT)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->SocClocks[dpm_level];
+		break;
+	case SMU_VCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->VClocks[dpm_level];
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DClocks[dpm_level];
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		if (dpm_level >= clk_table->NumDfPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->DfPstateTable[dpm_level].MemClk;
+		break;
+	case SMU_FCLK:
+		if (dpm_level >= clk_table->NumDfPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->DfPstateTable[dpm_level].FClk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool smu_v13_0_5_clk_dpm_is_enabled(struct smu_context *smu,
+						enum smu_clk_type clk_type)
+{
+	enum smu_feature_mask feature_id = 0;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+		feature_id = SMU_FEATURE_DPM_FCLK_BIT;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		feature_id = SMU_FEATURE_DPM_GFXCLK_BIT;
+		break;
+	case SMU_SOCCLK:
+		feature_id = SMU_FEATURE_DPM_SOCCLK_BIT;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		feature_id = SMU_FEATURE_VCN_DPM_BIT;
+		break;
+	default:
+		return true;
+	}
+
+	return smu_cmn_feature_is_enabled(smu, feature_id);
+}
+
+static int smu_v13_0_5_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+	uint32_t clock_limit;
+	uint32_t max_dpm_level, min_dpm_level;
+	int ret = 0;
+
+	if (!smu_v13_0_5_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_FCLK:
+			clock_limit = smu->smu_table.boot_values.fclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		case SMU_VCLK:
+			clock_limit = smu->smu_table.boot_values.vclk;
+			break;
+		case SMU_DCLK:
+			clock_limit = smu->smu_table.boot_values.dclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = clk_table->MaxGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+		case SMU_FCLK:
+			max_dpm_level = 0;
+			break;
+		case SMU_SOCCLK:
+			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			max_dpm_level = clk_table->VcnClkLevelsEnabled - 1;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = clk_table->MinGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+		case SMU_FCLK:
+			min_dpm_level = clk_table->NumDfPstatesEnabled - 1;
+			break;
+		case SMU_SOCCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			min_dpm_level = 0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
+			if (ret)
+				goto failed;
+		}
+	}
+
+failed:
+	return ret;
+}
+
+static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t min,
+							uint32_t max)
+{
+	enum smu_message_type msg_set_min, msg_set_max;
+	int ret = 0;
+
+	if (!smu_v13_0_5_clk_dpm_is_enabled(smu, clk_type))
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
+		break;
+	case SMU_FCLK:
+		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
+		break;
+	case SMU_SOCCLK:
+		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		msg_set_min = SMU_MSG_SetHardMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (ret)
+		goto out;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
+				enum smu_clk_type clk_type, char *buf)
+{
+	int i, size = 0, ret = 0;
+	uint32_t cur_value = 0, value = 0, count = 0;
+
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
+	switch (clk_type) {
+	case SMU_OD_SCLK:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		break;
+	case SMU_OD_RANGE:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		break;
+	case SMU_SOCCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_MCLK:
+	case SMU_FCLK:
+		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			goto print_clk_out;
+
+		ret = smu_v13_0_5_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			goto print_clk_out;
+
+		for (i = 0; i < count; i++) {
+			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			if (ret)
+				goto print_clk_out;
+
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+					cur_value == value ? "*" : "");
+		}
+		break;
+	default:
+		break;
+	}
+
+print_clk_out:
+	return size;
+}
+
+static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
+				enum smu_clk_type clk_type, uint32_t mask)
+{
+	uint32_t soft_min_level = 0, soft_max_level = 0;
+	uint32_t min_freq = 0, max_freq = 0;
+	int ret = 0;
+
+	soft_min_level = mask ? (ffs(mask) - 1) : 0;
+	soft_max_level = mask ? (fls(mask) - 1) : 0;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		if (ret)
+			goto force_level_out;
+
+		ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		if (ret)
+			goto force_level_out;
+
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		if (ret)
+			goto force_level_out;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+force_level_out:
+	return ret;
+}
+
+static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
+						enum amd_dpm_forced_level level)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t fclk_min = 0, fclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
+	int ret = 0;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		sclk_min = sclk_max;
+		fclk_min = fclk_max;
+		socclk_min = socclk_max;
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		sclk_max = sclk_min;
+		fclk_max = fclk_min;
+		socclk_max = socclk_min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
+	default:
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	if (sclk_min && sclk_max) {
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
+							    SMU_SCLK,
+							    sclk_min,
+							    sclk_max);
+		if (ret)
+			return ret;
+
+		smu->gfx_actual_hard_min_freq = sclk_min;
+		smu->gfx_actual_soft_max_freq = sclk_max;
+	}
+
+	if (fclk_min && fclk_max) {
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
+							    SMU_FCLK,
+							    fclk_min,
+							    fclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
+							    SMU_SOCCLK,
+							    socclk_min,
+							    socclk_max);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_5_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
+static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
+	.check_fw_status = smu_v13_0_check_fw_status,
+	.check_fw_version = smu_v13_0_check_fw_version,
+	.init_smc_tables = smu_v13_0_5_init_smc_tables,
+	.fini_smc_tables = smu_v13_0_5_fini_smc_tables,
+	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
+	.system_features_control = smu_v13_0_5_system_features_control,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
+	.dpm_set_vcn_enable = smu_v13_0_5_dpm_set_vcn_enable,
+	.dpm_set_jpeg_enable = smu_v13_0_5_dpm_set_jpeg_enable,
+	.set_default_dpm_table = smu_v13_0_5_set_default_dpm_tables,
+	.read_sensor = smu_v13_0_5_read_sensor,
+	.is_dpm_running = smu_v13_0_5_is_dpm_running,
+	.set_watermarks_table = smu_v13_0_5_set_watermarks_table,
+	.get_gpu_metrics = smu_v13_0_5_get_gpu_metrics,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_driver_table_location = smu_v13_0_set_driver_table_location,
+	.gfx_off_control = smu_v13_0_gfx_off_control,
+	.post_init = smu_v13_0_5_post_smu_init,
+	.mode2_reset = smu_v13_0_5_mode2_reset,
+	.get_dpm_ultimate_freq = smu_v13_0_5_get_dpm_ultimate_freq,
+	.od_edit_dpm_table = smu_v13_0_5_od_edit_dpm_table,
+	.print_clk_levels = smu_v13_0_5_print_clk_levels,
+	.force_clk_levels = smu_v13_0_5_force_clk_levels,
+	.set_performance_level = smu_v13_0_5_set_performance_level,
+	.set_fine_grain_gfx_freq_parameters = smu_v13_0_5_set_fine_grain_gfx_freq_parameters,
+};
+
+void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
+{
+	smu->ppt_funcs = &smu_v13_0_5_ppt_funcs;
+	smu->message_map = smu_v13_0_5_message_map;
+	smu->feature_map = smu_v13_0_5_feature_mask_map;
+	smu->table_map = smu_v13_0_5_table_map;
+	smu->is_apu = true;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
new file mode 100644
index 000000000000..d2e872c93650
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __SMU_V13_0_5_PPT_H__
+#define __SMU_V13_0_5_PPT_H__
+
+extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);
+
+#endif
-- 
2.35.1

