Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E5CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA7010F89B;
	Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1A210F891
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6hG0E47NEoDKd7ZDyMc/hrtfu1yAmSQ1gCpahtfzJCBjdP0SLJF1hJkXzCmf+5YYCF2/hkmjS9q07OFClJ/dyjxLpSQYliCCRHJxzRRUurrzHsPEJLZipD2OLwbCmjX05ZGyozgJrCgIb/vLave+J/5gU3QOh29RaiNQSOZCk9xwq/r2e/D84QAtB3SCwpBFGSQgljVoppp60fv9n8qTCed1kWoPmFhDB5mzt0UdhQ6VsExiE1GnNBinJ2XqrY5lBAtc61YNjjPbUXKxfi9iPsO8IRPulNbUc9QIVQhBR503vxtvih4xjNCN2A4S5AWMfLpXEsQiadv53aw3B2ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBCfOqB6nPzto+oy+sODLV9V7+RC+luYOw3AJHG+yVY=;
 b=EHX7EsQOTZZILOZgbj5u/Lg8uJ2afKqd0AeR5QkcBtFS0XXvcXtSaDzHEk9tidAoUJP4TL+qb529SzJc+WQPkP8IYMyaZpVZ4F0LO+tofDoyyi1QRWPqubkdOZrUJxUCO69MR0h4RvLzR6c2TKGRr0b+z+vhcDA0RiMsDcBYMZZV2ohWM+f7ooJryHahSmDiJYlCTeEPVgdzkjAh7JuEm19f5RTUF+i7zB/uvrjrMvvzsHuml7+jYMx2VzlGaTY0RoWLIQhpYjcNN3lQsQZtOrZYdLHg3z2vFyuSuAwU8OQyAERv3jMI7jX57Ui3OeFJPb1TmQh1s9CVUAomTUwZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBCfOqB6nPzto+oy+sODLV9V7+RC+luYOw3AJHG+yVY=;
 b=dTxPByE8gVW+rho4m4jPQWz5u0FN/NkbJS+f6oWv+M2544xM/++khDuka8dU+/WOqpMcMCTk8Fuu7xoz8VThoMS4+J2YE2+qNTgcUTvt/Qx12LC9LhWkVwn0+WNDko75VcZaxIF+C5QxSBzZrLsx1d1LPBbavKRCpSX9wotcz3s=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by DM5PR1201MB0251.namprd12.prod.outlook.com (2603:10b6:4:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 18:02:50 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::74) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/29] drm/amdgpu: support imu for gfx11
Date: Fri, 29 Apr 2022 14:02:16 -0400
Message-ID: <20220429180226.536084-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03730710-55f8-4c38-4e22-08da2a0a7997
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0251:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0251A71B93355891C07ACA3AF7FC9@DM5PR1201MB0251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpV6LR3jQQJA1/BI9tbryZ1PIc/jozytTKm9OzTt9YCK2A0pTflFfOj9Igy7q99kpBA/x638bFfDxoZVf8i2+wNznp6sLyJhgntwiHI54RrYxdob7eYls0tO025kuADAj7p6j7sTsVpJe1fSFzcb23vV7EgJwfvhCGDQLJvNNRSFrB9XK3BtSLo/1Jm7M1aOo4IvNWZjjtrBiJUnmR4UzgTKzuOAt0umDe4Ob4yKfyZnmeT/DmusZbU1fk3goq17klNFOjoXlCyMKGvUuQ7Vnaoi7mHFp4SHFMuuLTP5dizZYFUN8UWOdmPdHjt0KJJobIYTKbt0qtMlwgNohvcnD8P42xpf22/s71XrdPlNUwdjbHBykolQNC79xItSRAweQZD530tZWfVT3EjdiNkZIgwePXCIDUEsaUujRh/9Jnb8BOdXYPhxANXGvTlzkbswK5bKcMMK6pPll4mK6nzQGa0bLBjdfAOvC+r3oIazCB6fOaZ1ipExLK8VJodHNrzltqKh3tJGnIoaZSwukS5xcDIxrSM/ahVF5SlMugnekCXALRmRMWI8HTnEV2bEwkCPoHLZna9nGmB7t0eAxb9onyClgx3wJZT8wIwWgXbakROHwBD8XnrPMEtAJeHuCqVq9SbI+7nMTwaqKpt/4CJSjKiLR6tHDRitb66XNesOGotf+O369++YlF33P3ulCSy9TZ8bOVEqSJbEXxVicjtSgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(186003)(40460700003)(356005)(1076003)(47076005)(336012)(83380400001)(426003)(4326008)(36756003)(8936002)(8676002)(5660300002)(30864003)(2906002)(6666004)(2616005)(82310400005)(7696005)(54906003)(26005)(70586007)(70206006)(36860700001)(81166007)(6916009)(86362001)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:50.2001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03730710-55f8-4c38-4e22-08da2a0a7997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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

Add support to initialize imu for gfx v11.
IMU is a new power management block for
gfx which manages gfx power.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h   |  51 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  13 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c    | 286 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.h    |  30 +++
 6 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 803e7f5dc458..e74bf1bde8b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -130,7 +130,8 @@ amdgpu-y += \
 	gfx_v9_0.o \
 	gfx_v9_4.o \
 	gfx_v9_4_2.o \
-	gfx_v10_0.o
+	gfx_v10_0.o \
+	imu_v11_0.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8e18d3fc4fab..15749016d8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -30,6 +30,7 @@
 #include "clearstate_defs.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_rlc.h"
+#include "amdgpu_imu.h"
 #include "soc15.h"
 #include "amdgpu_ras.h"
 
@@ -274,6 +275,7 @@ struct amdgpu_gfx {
 	struct amdgpu_me		me;
 	struct amdgpu_mec		mec;
 	struct amdgpu_kiq		kiq;
+	struct amdgpu_imu		imu;
 	struct amdgpu_scratch		scratch;
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
@@ -287,6 +289,8 @@ struct amdgpu_gfx {
 	uint32_t			mec_fw_version;
 	const struct firmware		*mec2_fw; /* MEC2 firmware */
 	uint32_t			mec2_fw_version;
+	const struct firmware		*imu_fw; /* IMU firmware */
+	uint32_t			imu_fw_version;
 	uint32_t			me_feature_version;
 	uint32_t			ce_feature_version;
 	uint32_t			pfp_feature_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
new file mode 100644
index 000000000000..56cf127cdf93
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_IMU_H__
+#define __AMDGPU_IMU_H__
+
+struct amdgpu_imu_funcs {
+    int (*init_microcode)(struct amdgpu_device *adev);
+    int (*load_microcode)(struct amdgpu_device *adev);
+    void (*setup_imu)(struct amdgpu_device *adev);
+    int (*start_imu)(struct amdgpu_device *adev);
+    void (*program_rlc_ram)(struct amdgpu_device *adev);
+};
+
+struct imu_rlc_ram_golden {
+    u32 hwip;
+    u32 instance;
+    u32 segment;
+    u32 reg;
+    u32 data;
+    u32 addr_mask;
+};
+
+#define IMU_RLC_RAM_GOLDEN_VALUE(ip, inst, reg, data, addr_mask) \
+    { ip##_HWIP, inst, reg##_BASE_IDX, reg, data, addr_mask }
+
+struct amdgpu_imu {
+    const struct amdgpu_imu_funcs *funcs;
+};
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 00fa7822458b..d5b52bf9e5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -126,6 +126,19 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
+void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
+{
+	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
+	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
+
+	DRM_DEBUG("IMU\n");
+	amdgpu_ucode_print_common_hdr(hdr);
+
+	if (version_major != 1) {
+		DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
+	}
+}
+
 void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
new file mode 100644
index 000000000000..81952a6767d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -0,0 +1,286 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_imu.h"
+
+#include "gc/gc_11_0_0_offset.h"
+#include "gc/gc_11_0_0_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+
+static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
+{
+	char fw_name[40];
+	char ucode_prefix[30];
+	int err;
+	const struct imu_firmware_header_v1_0 *imu_hdr;
+	struct amdgpu_firmware_info *info = NULL;
+
+	DRM_DEBUG("\n");
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
+	err = request_firmware(&adev->gfx.imu_fw, fw_name, adev->dev);
+	if (err)
+		goto out;
+	err = amdgpu_ucode_validate(adev->gfx.imu_fw);
+	if (err)
+		goto out;
+	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
+	//adev->gfx.imu_feature_version = le32_to_cpu(imu_hdr->ucode_feature_version);
+	
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes), PAGE_SIZE);
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes), PAGE_SIZE);
+	}
+
+out:
+	if (err) {
+		dev_err(adev->dev,
+			"gfx11: Failed to load firmware \"%s\"\n",
+			fw_name);
+		release_firmware(adev->gfx.imu_fw);
+	}
+
+	return err;
+}
+
+static int imu_v11_0_load_microcode(struct amdgpu_device *adev)
+{
+	const struct imu_firmware_header_v1_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	if (!adev->gfx.imu_fw)
+		return -EINVAL;
+
+	hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	//amdgpu_ucode_print_rlc_hdr(&hdr->header);
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->imu_iram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+			le32_to_cpu(hdr->imu_iram_ucode_size_bytes));
+	fw_size = le32_to_cpu(hdr->imu_dram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	return 0;
+}
+
+static void imu_v11_0_setup(struct amdgpu_device *adev)
+{
+	int imu_reg_val;
+
+	//enable IMU debug mode
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
+
+	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
+	imu_reg_val |= 0x1;
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+
+	//disble imu Rtavfs, SmsRepair, DfllBTC, and ClkB
+	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
+	imu_reg_val |= 0x10007;
+	WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
+}
+
+static int imu_v11_0_start(struct amdgpu_device *adev)
+{
+	int imu_reg_val, i;
+
+	//Start IMU by set GFX_IMU_CORE_CTRL.CRESET = 0
+	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
+	imu_reg_val &= 0xfffffffe;
+	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
+		if ((imu_reg_val & 0x1f) == 0x1f)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11[] =
+{
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_RD_COMBINE_FLUSH, 0x00055555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_WR_COMBINE_FLUSH, 0x00055555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_DRAM_COMBINE_FLUSH, 0x00555555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC2, 0x00001ffe, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_CREDITS , 0x003f3fff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_TAG_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE0, 0x00041000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE0, 0x00040000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC, 0x00000017, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_ENABLE, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_CREDITS , 0x003f3fbf, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE0, 0x10201000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE1, 0x00000080, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE0, 0x1d041040, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE1, 0x80000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_IO_PRIORITY, 0x88888888, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MAM_CTRL, 0x0000d800, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ARB_FINAL, 0x000003f7, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ENABLE, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, 0x00020000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL, 0x0000000c, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_CACHEABLE_DRAM_ADDRESS_END, 0x000fffff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MISC, 0x0c48bff0, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SA_UNIT_DISABLE, 0x00fffc01, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_PRIM_CONFIG, 0x000fffe1, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_RB_BACKEND_DISABLE, 0x0fffff01, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG, 0xfffe0001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000500, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END, 0x000fffff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_TOP_OF_DRAM_SLOT1, 0xff800000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_LOWER_TOP_OF_DRAM2, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_UPPER_TOP_OF_DRAM2, 0x00000fff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, 0x00001ffc, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000501, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL, 0x00080603, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL2, 0x00000003, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL3, 0x00100003, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL5, 0x00003fe0, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT0_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES, 0x00000c00, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT1_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES, 0x00000c00, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x00000545, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_0, 0x13455431, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_1, 0x13455431, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_2, 0x76027602, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_3, 0x76207620, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x00000345, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCUTCL2_HARVEST_BYPASS_GROUPS, 0x0000003e, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_BASE, 0x00006000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_TOP, 0x000061ff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL, 0x0000000c, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BASE, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BOT, 0x00000002, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_TOP, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, 0x00020000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA0_UCODE_SELFLOAD_CONTROL, 0x00000210, 0), 
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA1_UCODE_SELFLOAD_CONTROL, 0x00000210, 0), 
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPC_PSP_DEBUG, CPC_PSP_DEBUG__GPA_OVERRIDE_MASK, 0), 
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__GPA_OVERRIDE_MASK, 0)
+};
+
+void program_imu_rlc_ram(struct amdgpu_device *adev,
+				const struct imu_rlc_ram_golden *regs,
+				const u32 array_size)
+{
+	const struct imu_rlc_ram_golden *entry;
+	u32 reg, data;
+	int i;
+
+	for (i = 0; i < array_size; ++i) {
+		entry = &regs[i];
+		reg =  adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		reg |= entry->addr_mask;
+
+		data = entry->data;
+		if (entry->reg == regGCMC_VM_AGP_BASE)
+			data = 0x00ffffff;
+		else if (entry->reg == regGCMC_VM_AGP_TOP)
+			data = 0x0;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_BASE)
+			data = adev->gmc.vram_start >> 24;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_TOP)
+			data = adev->gmc.vram_end >> 24;
+
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
+	}
+	//Indicate the latest entry
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+}
+
+static void imu_v11_0_program_rlc_ram(struct amdgpu_device *adev)
+{
+	u32 reg_data;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
+
+	program_imu_rlc_ram(adev,
+				  imu_rlc_ram_golden_11,
+				  (const u32)ARRAY_SIZE(imu_rlc_ram_golden_11));
+
+	//Indicate the contents of the RAM are valid
+	reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
+	reg_data |= GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
+}
+
+const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs = {
+	.init_microcode = imu_v11_0_init_microcode,
+	.load_microcode = imu_v11_0_load_microcode,
+	.setup_imu = imu_v11_0_setup,
+	.start_imu = imu_v11_0_start,
+	.program_rlc_ram = imu_v11_0_program_rlc_ram,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.h b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.h
new file mode 100644
index 000000000000..e71f96fc2f06
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __IMU_V11_0_H__
+#define __IMU_V11_0_H__
+
+extern const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs;
+
+#endif
+
-- 
2.35.1

