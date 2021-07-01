Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EAC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C499D6144B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C499D6144B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2276E217;
	Thu,  1 Jul 2021 08:32:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4FF6E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 08:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBXMZtb5QZWncldN4+FjOcjbfvuHZgLsc+kMEuntlSbe0RwpZwmVXRtkLJ8LY5DWKyM55JczVTfeSCStaerswYgqkNLjdu6CFbaFeZ2LbH0d2p7klx+X7ynlqudShGhCcbJBYDPZQr7q7/6uXb8XvoxS2nxMMgtSW+UhZfgd+q9k4fN0uPcs6nDFsxI32vt1/NFDj7Zj3HulRd+wy/gLEor2GrYDnh8TyX9LMqUsJFrAozjTJOUehhQa20m8+2TiA97By4YJ+Zdeae+cYHJ5Ub7RN89nrgEqNNNW7LPK03YnrfeZHl5W8qLuX/Q4nXQgbrNIpRkCCo+j0kP7kvPJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr/jwJtreN0WsIrIeq4+r739BLXNpMwWLZvVPpacn0U=;
 b=PuBlNBPZsgQNsgck3d144kMd3v3ZBHYWDwhno+831/OiG9pylf+iDmeA3Ygy+jiJjgndkBe7o/wDEOorSBXVDhZh9XRWrXrf5s1FDbUEhxjtjP87axuCBvJs5EA+t4SVrG+MXWAk1fw5GTz9+rjR5RSkw+XMYUn9O5WlEkMsEH3cvJGntDQbEoWcB0SjveVSc4/PDB5KDwYsoxOhddilm/1jO+v91XkPHz6GxLqkcff/ViPlYiLK+q+7mbAAbLTD0cvxCxGYPxnISyIxYp06bktZrEmF/JaK0WZpr+MXi38GWRcsoTKxaXjWFQc0Y5iAWki0S71TOj6OCbEqZMTgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr/jwJtreN0WsIrIeq4+r739BLXNpMwWLZvVPpacn0U=;
 b=QbzEr9VIc/sCsJS5/Cj/NMHv5dy1uvHOYLk+8SEw28qN7ag95Z8+HHIBJLkqWi7vCmL+DYcvE4C2k37mXL8fNKq1ZiQzGLIhBpOdta18tshfFKGrVZPELzu9UtixCPX+66D+ZIWPJPdvNqFsKJk+INLXeNCsOAFtZDK2bKBGGQQ=
Received: from BN8PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:94::45)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 1 Jul
 2021 08:31:58 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::38) by BN8PR03CA0032.outlook.office365.com
 (2603:10b6:408:94::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Thu, 1 Jul 2021 08:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 08:31:57 +0000
Received: from code-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 1 Jul 2021
 03:31:55 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
Date: Thu, 1 Jul 2021 16:31:21 +0800
Message-ID: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b10b4e7-cab6-46ff-eef3-08d93c6ab0cb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB527811F5BC10400F312869D39F009@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK07rNJ7JZ7qW+kV39p6AM8xP5o5pws+xOILEyV+RfcULAKOyJoDc5dhkjymonB/+lKnBhQ42c+i6ZHlsWuV+ejop5dSViSgdAKV9Q1rI6LI4i2lU1tYilQJL82yubYJJF5sfusnhPT/GF1IY2M22s7Hr/lYZNWk+G5DQYVAhuvb1odEVh0u/RDIZ59QlPc14Do/3mRhdWnnqThFU3sGep22K/cdBP68fxwn0oTlpK1ppEY/uRV+NNtEn5uRSZKfFUT+PJS2OnWzg8RlT9OLVkuMqTEHeclvRDPL3zNZhdYMXxJNxbTJ/MC+MRzTREFtbqJtJfvAXqoPvY+3TMqSZ6a+PFT60aMUKrPiRdegFTwhobZgYIhuLuNyO06hcjgka1MyOf1euYGUR8VDtLyVECDb1RGXTA2heFwuNgJgvRuCKreqpWKFo5NGxH5KgKQC6bXLJ6bAGHcllwAS86JKixE/chd5LZaFmrtlMXduVZbC3Wqm3B8BZ9PYu5uX86Q7C2TrGtrBuyNDXovOND51CbHUmX7oO4jz3p3QxPVa26Vd1+XpVcsg7lPhBOWTAztFNqx0qhExqU7fWm3tL1SNJM2AJhVteU0EUVWTjtx4TtWDrvcqiqbaEj+m4RYz2JRSjlSmCqaciQMt43Gj2h6iUKxp/qEZOqaaR6eIj7rFRXBhDieflfOvCEWmBJAJePOPVbA1vJNfzYi6vXAjhkmrPB/z8rgUUdivWAlwxt7zp94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(356005)(81166007)(5660300002)(47076005)(8676002)(6916009)(83380400001)(70586007)(70206006)(6666004)(30864003)(8936002)(82740400003)(4326008)(426003)(16526019)(54906003)(86362001)(316002)(186003)(26005)(7696005)(2616005)(36860700001)(1076003)(82310400003)(336012)(2906002)(36756003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:31:57.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b10b4e7-cab6-46ff-eef3-08d93c6ab0cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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
Cc: Lijo.Lazar@amd.com, Kevin1.Wang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since there's nothing special in smu implementation for yellow carp,
it's better to reuse the common smu_v13_0 interfaces and drop the
specific smu_v13_0_1.c|h files.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  57 ----
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  26 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 311 ------------------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  39 ++-
 6 files changed, 59 insertions(+), 377 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index 6119a36b2cba..3fea2430dec0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,6 +26,7 @@
 #include "amdgpu_smu.h"
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
 
 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
deleted file mode 100644
index b6c976a4d578..000000000000
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#ifndef __SMU_V13_0_1_H__
-#define __SMU_V13_0_1_H__
-
-#include "amdgpu_smu.h"
-
-#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3
-
-/* MP Apertures */
-#define MP0_Public			0x03800000
-#define MP0_SRAM			0x03900000
-#define MP1_Public			0x03b00000
-#define MP1_SRAM			0x03c00004
-
-/* address block */
-#define smnMP1_FIRMWARE_FLAGS		0x3010024
-
-
-#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
-
-int smu_v13_0_1_check_fw_status(struct smu_context *smu);
-
-int smu_v13_0_1_check_fw_version(struct smu_context *smu);
-
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
-
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);
-
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
-
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
-
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable);
-#endif
-#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 9b3a8503f5cd..d4c4c495762c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o yellow_carp_ppt.o
+SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a3dc7194aaf8..cbce982f2717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -41,6 +41,8 @@
 
 #include "asic_reg/thm/thm_13_0_2_offset.h"
 #include "asic_reg/thm/thm_13_0_2_sh_mask.h"
+#include "asic_reg/mp/mp_13_0_1_offset.h"
+#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
 #include "asic_reg/mp/mp_13_0_2_offset.h"
 #include "asic_reg/mp/mp_13_0_2_sh_mask.h"
 #include "asic_reg/smuio/smuio_13_0_2_offset.h"
@@ -210,6 +212,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	case CHIP_ALDEBARAN:
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
+	case CHIP_YELLOW_CARP:
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
@@ -694,6 +699,27 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	switch (adev->asic_type) {
+	case CHIP_YELLOW_CARP:
+		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+			return 0;
+		if (enable)
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		else
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
deleted file mode 100644
index 61917b49f2bf..000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
+++ /dev/null
@@ -1,311 +0,0 @@
-/*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-//#include <linux/reboot.h>
-
-#define SWSMU_CODE_LAYER_L3
-
-#include "amdgpu.h"
-#include "amdgpu_smu.h"
-#include "smu_v13_0_1.h"
-#include "soc15_common.h"
-#include "smu_cmn.h"
-#include "atomfirmware.h"
-#include "amdgpu_atomfirmware.h"
-#include "amdgpu_atombios.h"
-#include "atom.h"
-
-#include "asic_reg/mp/mp_13_0_1_offset.h"
-#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
-
-/*
- * DO NOT use these for err/warn/info/debug messages.
- * Use dev_err, dev_warn, dev_info and dev_dbg instead.
- * They are more MGPU friendly.
- */
-#undef pr_err
-#undef pr_warn
-#undef pr_info
-#undef pr_debug
-
-int smu_v13_0_1_check_fw_status(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t mp1_fw_flags;
-
-	mp1_fw_flags = RREG32_PCIE(MP1_Public |
-				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
-
-	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
-	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-		return 0;
-
-	return -EIO;
-}
-
-int smu_v13_0_1_check_fw_version(struct smu_context *smu)
-{
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return ret;
-
-	smu_major = (smu_version >> 16) & 0xffff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
-
-	switch (smu->adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		smu->smc_driver_if_version = SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP;
-		break;
-
-	default:
-		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
-		smu->smc_driver_if_version = SMU13_0_1_DRIVER_IF_VERSION_INV;
-		break;
-	}
-
-	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
-			 smu_version, smu_major, smu_minor, smu_debug);
-
-	/*
-	 * 1. if_version mismatch is not critical as our fw is designed
-	 * to be backward compatible.
-	 * 2. New fw usually brings some optimizations. But that's visible
-	 * only on the paired driver.
-	 * Considering above, we just leave user a warning message instead
-	 * of halt driver loading.
-	 */
-	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			 "smu fw version = 0x%08x (%d.%d.%d)\n",
-			 smu->smc_driver_if_version, if_version,
-			 smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
-	}
-
-	return ret;
-}
-
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	kfree(smu_table->clocks_table);
-	smu_table->clocks_table = NULL;
-
-	kfree(smu_table->metrics_table);
-	smu_table->metrics_table = NULL;
-
-	kfree(smu_table->watermarks_table);
-	smu_table->watermarks_table = NULL;
-
-	return 0;
-}
-
-static int smu_v13_0_1_atom_get_smu_clockinfo(struct amdgpu_device *adev,
-						uint8_t clk_id,
-						uint8_t syspll_id,
-						uint32_t *clk_freq)
-{
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
-	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
-	int ret, index;
-
-	input.clk_id = clk_id;
-	input.syspll_id = syspll_id;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	*clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	return 0;
-}
-
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu)
-{
-	int ret, index;
-	uint16_t size;
-	uint8_t frev, crev;
-	struct atom_common_table_header *header;
-	struct atom_firmware_info_v3_4 *v_3_4;
-	struct atom_firmware_info_v3_3 *v_3_3;
-	struct atom_firmware_info_v3_1 *v_3_1;
-
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-					    firmwareinfo);
-
-	ret = amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
-					     (uint8_t **)&header);
-	if (ret)
-		return ret;
-
-	if (header->format_revision != 3) {
-		dev_err(smu->adev->dev, "unknown atom_firmware_info version! for smu13\n");
-		return -EINVAL;
-	}
-
-	switch (header->content_revision) {
-	case 0:
-	case 1:
-	case 2:
-		v_3_1 = (struct atom_firmware_info_v3_1 *)header;
-		smu->smu_table.boot_values.revision = v_3_1->firmware_revision;
-		smu->smu_table.boot_values.gfxclk = v_3_1->bootup_sclk_in10khz;
-		smu->smu_table.boot_values.uclk = v_3_1->bootup_mclk_in10khz;
-		smu->smu_table.boot_values.socclk = 0;
-		smu->smu_table.boot_values.dcefclk = 0;
-		smu->smu_table.boot_values.vddc = v_3_1->bootup_vddc_mv;
-		smu->smu_table.boot_values.vddci = v_3_1->bootup_vddci_mv;
-		smu->smu_table.boot_values.mvddc = v_3_1->bootup_mvddc_mv;
-		smu->smu_table.boot_values.vdd_gfx = v_3_1->bootup_vddgfx_mv;
-		smu->smu_table.boot_values.cooling_id = v_3_1->coolingsolution_id;
-		break;
-	case 3:
-		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
-		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
-		smu->smu_table.boot_values.gfxclk = v_3_3->bootup_sclk_in10khz;
-		smu->smu_table.boot_values.uclk = v_3_3->bootup_mclk_in10khz;
-		smu->smu_table.boot_values.socclk = 0;
-		smu->smu_table.boot_values.dcefclk = 0;
-		smu->smu_table.boot_values.vddc = v_3_3->bootup_vddc_mv;
-		smu->smu_table.boot_values.vddci = v_3_3->bootup_vddci_mv;
-		smu->smu_table.boot_values.mvddc = v_3_3->bootup_mvddc_mv;
-		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
-		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
-		break;
-	case 4:
-	default:
-		v_3_4 = (struct atom_firmware_info_v3_4 *)header;
-		smu->smu_table.boot_values.revision = v_3_4->firmware_revision;
-		smu->smu_table.boot_values.gfxclk = v_3_4->bootup_sclk_in10khz;
-		smu->smu_table.boot_values.uclk = v_3_4->bootup_mclk_in10khz;
-		smu->smu_table.boot_values.socclk = 0;
-		smu->smu_table.boot_values.dcefclk = 0;
-		smu->smu_table.boot_values.vddc = v_3_4->bootup_vddc_mv;
-		smu->smu_table.boot_values.vddci = v_3_4->bootup_vddci_mv;
-		smu->smu_table.boot_values.mvddc = v_3_4->bootup_mvddc_mv;
-		smu->smu_table.boot_values.vdd_gfx = v_3_4->bootup_vddgfx_mv;
-		smu->smu_table.boot_values.cooling_id = v_3_4->coolingsolution_id;
-		break;
-	}
-
-	smu->smu_table.boot_values.format_revision = header->format_revision;
-	smu->smu_table.boot_values.content_revision = header->content_revision;
-
-	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-					(uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
-					(uint8_t)0,
-					&smu->smu_table.boot_values.socclk);
-
-	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-					(uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
-					(uint8_t)0,
-					&smu->smu_table.boot_values.dcefclk);
-
-	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-					(uint8_t)SMU11_SYSPLL0_ECLK_ID,
-					(uint8_t)0,
-					&smu->smu_table.boot_values.eclk);
-
-	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-					(uint8_t)SMU11_SYSPLL0_VCLK_ID,
-					(uint8_t)0,
-					&smu->smu_table.boot_values.vclk);
-
-	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-					(uint8_t)SMU11_SYSPLL0_DCLK_ID,
-					(uint8_t)0,
-					&smu->smu_table.boot_values.dclk);
-
-	if ((smu->smu_table.boot_values.format_revision == 3) &&
-	    (smu->smu_table.boot_values.content_revision >= 2))
-		smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-						(uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
-						(uint8_t)SMU11_SYSPLL1_2_ID,
-						&smu->smu_table.boot_values.fclk);
-
-	return 0;
-}
-
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
-}
-
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu)
-{
-	struct smu_table *driver_table = &smu->smu_table.driver_table;
-	int ret = 0;
-
-	if (!driver_table->mc_address)
-		return 0;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_SetDriverDramAddrHigh,
-			upper_32_bits(driver_table->mc_address),
-			NULL);
-
-	if (ret)
-		return ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_SetDriverDramAddrLow,
-			lower_32_bits(driver_table->mc_address),
-			NULL);
-
-	return ret;
-}
-
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable)
-{
-	int ret = 0;
-	struct amdgpu_device *adev = smu->adev;
-
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
-			return 0;
-		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
-		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 7664334d8144..a28352149daa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -25,7 +25,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_v13_0_1.h"
+#include "smu_v13_0.h"
 #include "smu13_driver_if_yellow_carp.h"
 #include "yellow_carp_ppt.h"
 #include "smu_v13_0_1_ppsmc.h"
@@ -186,6 +186,22 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static int yellow_carp_fini_smc_tables(struct smu_context *smu)
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
 static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
@@ -658,6 +674,13 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
+static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
 static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
 					long input[], uint32_t size)
 {
@@ -1202,17 +1225,17 @@ static int yellow_carp_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 }
 
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
-	.check_fw_status = smu_v13_0_1_check_fw_status,
-	.check_fw_version = smu_v13_0_1_check_fw_version,
+	.check_fw_status = smu_v13_0_check_fw_status,
+	.check_fw_version = smu_v13_0_check_fw_version,
 	.init_smc_tables = yellow_carp_init_smc_tables,
-	.fini_smc_tables = smu_v13_0_1_fini_smc_tables,
-	.get_vbios_bootup_values = smu_v13_0_1_get_vbios_bootup_values,
+	.fini_smc_tables = yellow_carp_fini_smc_tables,
+	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = yellow_carp_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = yellow_carp_dpm_set_jpeg_enable,
-	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
+	.set_default_dpm_table = yellow_carp_set_default_dpm_tables,
 	.read_sensor = yellow_carp_read_sensor,
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.set_watermarks_table = yellow_carp_set_watermarks_table,
@@ -1221,8 +1244,8 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_gpu_metrics = yellow_carp_get_gpu_metrics,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
-	.gfx_off_control = smu_v13_0_1_gfx_off_control,
+	.set_driver_table_location = smu_v13_0_set_driver_table_location,
+	.gfx_off_control = smu_v13_0_gfx_off_control,
 	.post_init = yellow_carp_post_smu_init,
 	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
