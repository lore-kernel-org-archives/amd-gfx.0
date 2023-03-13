Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D149C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A809A10E462;
	Mon, 13 Mar 2023 01:44:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F2110E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAAVJ31pwnenv4QXsxRziBjDEJnGa8o/Eu9lVucj+/sKdf15n/6BIETLEzlCTHRSenFj/+QDwA8vTQftqu/GagsP9vx/U1B121yNzoBY/APzegpclIAZQ2M5DtLT4lhfqEZLMiGCAcdHMo1liPKbPne+sK1NUnwxajIRTIbwRL1TwsajUASmpdjOX9UZvStaU02iizKBrcvhNkrSgAPYULasKj0m8IXlm7fhoh3Q3j8gDS08G+NQbRV8gM3dQYW8JNGaBiRMRwiejj3gaxepwADQ3omH8V26y56oJAWAzbhs3FQ4JyPNlcd+lD3fQXfvE6/nD+B65ZLQN2a2DbEacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTiqRIn5YmNI0t1SM81coUP+WHH5ew8XkQiqTLEVg2E=;
 b=BwOHiqd/7ZMAW6KTt5n90vigd+GXWNNJHOuvLscczvxVQB3FAVhmRMX6B1lPjGER1KCIoJh+jdDQMRV7n/U19c3rBOyWpxuNmqW36N1OW4PBA2d98NnVrZQ4g+DZwZGu0+QW7lvABRqmPYMGgo3DWbNjprhFx61EjYkmC4rJXx5T/VD68wnDnAVVl3DjjIFyYjjMqzfN6CauaYUX1vaO3pblO/2z2HZIu9jS4tGGB1pbq19MUbdFdc75is9S24g2nidlaRZv73OUhlvbW/xcnCB95s2+jTXNQkgSQ20gSzVXHO/8MAqKDPKSWt4/J/CKeC94SmOLPbTIlZCRoSC9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTiqRIn5YmNI0t1SM81coUP+WHH5ew8XkQiqTLEVg2E=;
 b=sCFNpcWgFT3A4Lp91Q92DejuTFzI1M3Gx9YmL3p5BPeGMLr5fRNE7p44WW1tjuQybiXEeDDd+QXY3Wsfhz5RQ3jAS2O50i9NHcg52/LMaD7FzCgjq6OqDw4tHwZtNLhjlIQTrX/pYuA6DdClPHJ3Cl4gQLBcry3hnukOLG5LYuA=
Received: from BN9PR03CA0907.namprd03.prod.outlook.com (2603:10b6:408:107::12)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:44 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::54) by BN9PR03CA0907.outlook.office365.com
 (2603:10b6:408:107::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:44 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:41 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: Move mmhub ras block init to ras sw_init
Date: Mon, 13 Mar 2023 09:43:58 +0800
Message-ID: <20230313014403.21903-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 396fb750-1ada-482f-56ff-08db2364852f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY4qPJAqLvrT0mtYFYPPWqpqMa5PxF946nbzRRsPwtjGxUdgX2pNcdArXstZ25vgxz2d1OjqsP+XW5htMXIyksEDFK07P0a1BBa7XVAk0pLVW8OVo7vBNIVRXKFPPQAwlujDp6lQ/+Gl1iPb3JEVrGOBjQmLHzPQqOJXfFg9t3nm6+NJyXBSuFI8HJ57NjPBsEJIv35zViq5iC0JGv+H0v1IO2FXYR3G/uKc5dHypb0URL4iXKURyUbyieSdziethu4z4mt5bQdGbGRKSPl1u2oIwZfFzPMXRh+NLsMA0tR8yuRBPR23CH6Myw+j9cEAaB8HuoNTYcmDmuo3ok0GsES12LScPkTmk1AUXEhrE+ftJJMm8H8KA3tWJ8ki2aSDlFMCqFo+Q0a+oD6eqN6YVemi0R8E1oJDE42iDI4Tro1gCp1/VlpESySps9Uq+Ys5c802b/msRaa4f7JYXkgdaihoDMdybXQRubk+7wXtHVJd7x2BVFJqC2Y33wu05Q6kEtqmeOsbNXfTsh8JuFLt1rtjTZ9NuQHvMbHqDkyg3pwFips66RtavzyngN+C2Lp4L2sh8IziMJQ3qpgTYMbzdM4EaCErxvz1q2816quU2pU133F1OAP2FiGDGvQzocpjiYZ98fkMrLKuCgGXvceMwqz1rt2Hoxt/0YCIdJ2X0+wN0q+Kx7V8uElOe7GPQrknWaIKYBfbf4IniDFbKSv0ZrWFWUyX0EwNz4KKqQlcvJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(81166007)(66899018)(2906002)(82740400003)(83380400001)(36756003)(40460700003)(5660300002)(40480700001)(70206006)(70586007)(41300700001)(8936002)(4326008)(356005)(8676002)(36860700001)(6636002)(86362001)(110136005)(316002)(82310400005)(478600001)(16526019)(47076005)(426003)(186003)(336012)(2616005)(26005)(6666004)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:44.0918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396fb750-1ada-482f-56ff-08db2364852f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize mmhub ras block only when mmhub ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_init.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 46 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  9 -----
 5 files changed, 54 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d4dfd48451ce..00c33ce38761 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
-	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
+	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c764b57957e8..a15bc513dd67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -455,6 +455,11 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* mmhub ras block */
+	r = amdgpu_mmhub_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
new file mode 100644
index 000000000000..0f6b1021fef3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2023  Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+
+int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_mmhub_ras *ras;
+
+	if (!adev->mmhub.ras)
+		return 0;
+
+	ras = adev->mmhub.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register mmhub ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "mmhub");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->mmhub.ras_if = &ras->ras_block.ras_comm;
+
+	/* mmhub ras follows amdgpu_ras_block_late_init_default for late init */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 93430d3823c9..d21bb6dae56e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -48,5 +48,7 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
+int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev);
+
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e9b6599e790c..b3bb70210122 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1351,15 +1351,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 		/* mmhub ras is not available */
 		break;
 	}
-
-	if (adev->mmhub.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
-
-		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
-		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
-		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
-	}
 }
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
-- 
2.17.1

