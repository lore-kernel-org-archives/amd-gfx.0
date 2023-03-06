Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EA5C678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5C410E08A;
	Mon,  6 Mar 2023 02:33:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E0610E08A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxFyGg9nN0h07s5FurmrhjjDCb/4nHOhy6kP/tiMSTfBUvVZlnhpyD6Z5brdJFpQDUJ77H8gXpWLU8qBhJKp2EoJGbcB6mhbpXY+m2JZQJpndF+ueI/8Qr5paWtY6E2sQ1WZTFUD993TvwOxT66dW9OlEudkNtM8WGM57KB6dHczMRSlVUwZSNoo363nGD2f59ujNgcS+OpmynW2yXmBQK5vSfq9Dkncl2mXe+GomJXDNR8ZeP8kTOzsEWywi3J9n7IDfpwJUajvacuQdDOMDw2TtutOFRB/M9K9xLJ5cc3LVcfP1u+JjxkXFEuTjNll0NbyBZNOJTdhEbgJbK31Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvK9iz1HtgiNOnbw129NdaV2zkE0nNHiC1ErjKEQ94c=;
 b=NiAfbdeybcBGs05lkNjJz2m/J1j2CLWKKtKcCFRgL+RO1a8J+Xrldv6vLoYlVj0V90wNuXL2yZKmX/yA9lH7fz1qVoWKHjnDBdHjD0h3/A6uOKwwpYBnvQ2RG9HFwNor1NaanqWBMbUSLuH9sRPdqY+JQfHEvaxeR+hoDDCDEx8jreq7nwsUcGwY1wI/bNqP1Y2vcVShxoTgR81nROoS1b0Gj4GQQFxZVqlLE9Rd3WfL7vsJ5GCoH4rdaSK/AO9PJ9DbJJFM2OdJKSqi0gZaFNIm4D0OgKblSrvfSCXIT1DfNsQxKxOmv2dwKOcrtNISTcyvadUvQN1a8EBl22VVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvK9iz1HtgiNOnbw129NdaV2zkE0nNHiC1ErjKEQ94c=;
 b=wbXTHze2GGu8msxRFm3vej+LtZFZCn3AwtmtJKBpqUxywLvoQ2pV7G6LMbjqyv1Axt1HRKKOd9TluQszjEilQ+qFM6EkGOBIiTD7Ag5N0u+ABY/8nNWSQuHoC0Kn7txbEVWoUx9rP1qOxMrMgyuiaQJfd7Pa44ErzeEz9n26hlc=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 02:33:03 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::1f) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:33:03 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:33:01 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 06/11] drm/amdgpu: Move mmhub ras block init to ras sw_init
Date: Mon, 6 Mar 2023 10:31:55 +0800
Message-ID: <20230306023200.29158-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af6cd1e-0b6b-404c-5d6d-08db1deb1c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTk72wrKJjU7b+UbmOkqY17G+u2X6TNT1vQmkT41azPplbJxqzgKzysv334FFcpL6P38q2q0aTa+vyGfgGuFTDoh5VC2GsmMmcUGN7n+wy3iIi057ACHWrPy8AA9tag0Gb6sGboovgLDnhGAnltcLDseLaxB2C5O0MU3zeDQtFm43jVNzcIUJ98cdhqnBgD4zukBYo0pdgzq8gSCROOS6fhUjHqBznDO0p8euFG6Z0kmXnHA2BjFsSEFZ+P7Q00oMW2VBwW7tFGiTJqPDr7eEboSyuSjWqxZ3HlDly/ozfJkM26PLeUvIjgoyeUCjj9Y3AYGNnShYdXuNXfRIK+ieHQVwSNFba/ncsMS2VaY2bjeRKjaRIIxhWSEkOsG6ntQ3m9L5AfGe4iqHTVnxCoI8Lt+g3U4L/h71kalqQThUmZLaf6Wc8wCNIR0Gw+Roeox19nimoOfRZCjgLqH5LS4JSDFGwsc5b/lpH+KGw7Hba26ehTKj1Nh4omzrT7ryQc6GQQVAtYMfRntj5VJbPDWCKQWzrJ+dA3KL+kaxnCDae442C2g879Jjs/rL+Y+Q4dzYnVaZpiZbNGJ8AT4r9ay4Ek69edEfdxPiPklELBclrvyJdetVjkrW5AAg8e1YIXgC9XETIsbRGEdR1k/pKigFcOK+J0tWBsg26ypb6uczG+EKsiawp7GLzPwkOXPQKC39G3qI9bni5PRDei69iE44LCm+F/rM7qh8N1//F5PyPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(36756003)(6666004)(82310400005)(426003)(47076005)(83380400001)(7696005)(478600001)(36860700001)(186003)(40460700003)(336012)(2616005)(16526019)(26005)(1076003)(70586007)(2906002)(41300700001)(40480700001)(8936002)(4326008)(8676002)(70206006)(86362001)(5660300002)(81166007)(110136005)(6636002)(82740400003)(356005)(316002)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:33:03.5479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af6cd1e-0b6b-404c-5d6d-08db1deb1c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  9 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 46 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  9 -----
 5 files changed, 58 insertions(+), 10 deletions(-)
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
index 97a12d8d786a..e90c59693c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -459,6 +459,15 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* mmhub ras block */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		r = amdgpu_mmhub_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize mmhub ras block!\n");
+			return r;
+		}
+	}
+
 	/* xgmi ras block */
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
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

