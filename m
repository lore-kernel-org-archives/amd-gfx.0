Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE65C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 19:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F51E6F9C5;
	Thu,  2 Dec 2021 19:52:02 +0000 (UTC)
X-Greylist: delayed 1086 seconds by postgrey-1.36 at gabe;
 Thu, 02 Dec 2021 19:52:00 UTC
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (unknown
 [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67AB6F9C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 19:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSEDkpKt0Hue+soH+hrLTYqVpLzAXKBN5+uuju/14W51jtTxW0v/fjLiCrbYpxf/xo0yQJnBEveW36/3GAhExfFRh7XPkR4Ml3HALiZKgfNwJ+b83zXZ70Pq0vFftccvS6U/FhNsqPb5NiOgwdfEj+HSIvf4mK7nKboM1j+unrwJjruQW9BYI/YrtS6eTcjliIDjkxnqUQSMLQNFdP2M57FfaPu5cEKam0WQTzBNTsbX6YIIwy9JzNI6hJ+19Qcwt7ALtFRztRpLnvgo8syTOpfyXMlPbNwyD6DXXq1VH5ESwt+6PdHPiKNZAu+J5MwYSors1SzSUj/u+B6z+SZHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jaeeZk3SMhUqZiwkFYDn4/ia/jSWamQTXoStoWST4M=;
 b=UH44Sg4QSdzVZF6IMMRNPt2K7Wkr462ZqfiIqxvjzw2bQ48Zb6D2pV3jlrnOe/XgELRLR91KxXsNgvs0XUWAnDjhFSIdwGHdmTlNlSV/xPbUNk1TIU6Yt3NM8plx7io5xounJo7s83McJQpIJ2bj3FiEnkf40GeMnnlxBzBu6H5qvXfYyq24daH1BU/G4m/W0HaBfRz3SIzBAeP27UQfyVOpMITE4rHgEXmJK9MlkkYdjjOg2toBdDVNwdi5B7b2UfdKD1Ir4enifJNmZvfbK0xwCE27jhyTU809CTLqX3rY3aukzLVSYPCLS536DQOHxI2RMmdPgmllA12r/NQD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jaeeZk3SMhUqZiwkFYDn4/ia/jSWamQTXoStoWST4M=;
 b=kgyYZz9C6RiVqG5oMd+X3/ju0aZ/KK+s9+b/RIz77ObICzpzwp5dl8klQPeEYT73WeEXxgC/qFHn3mONY8Z4FJ5qmL/ZvgFSqyP5TGbxXm9Wnp5JDAEDBtV8CZgOr5+wdXiH9fv7sowvmBGEgjnMreT4KG+8fGW+w2Q9JdUp1M8=
Received: from BN6PR2001CA0002.namprd20.prod.outlook.com
 (2603:10b6:404:b4::12) by BN9PR12MB5083.namprd12.prod.outlook.com
 (2603:10b6:408:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 19:19:25 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::d6) by BN6PR2001CA0002.outlook.office365.com
 (2603:10b6:404:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 19:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 19:19:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 13:19:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Date: Thu, 2 Dec 2021 14:19:11 -0500
Message-ID: <20211202191912.6148-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caae6a04-877d-4d2c-9be2-08d9b5c8a70a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-Microsoft-Antispam-PRVS: <BN9PR12MB508371AE6BFBF413C74BF24CF7699@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UetW0JtSH+d1VqFAlgKIgnANqVnFKlBvI+U/NG4fl46D4aguZOmZv7ISAj1w8frWd5XSTswHKB7l6Ct5cwOOSskHnvLYaQSh4MslwVsOeq6LeAVEv176NxDaB/JtsefDTXHo6YkkiQRe3QtqkMeXUwK7oG1DXD5CLh5qWjYOjzyYLHuIs/TpC8yvNod9d3czAsRaTGx3+Hs7s5TunuS8m50oLcZaDB05+UWQ5W+LjcrytyGtNuShe+yVKtOTvsaKMsKfYtlKbrP1yuvTtRfY93en0aHB5vHVEhGCBblFQAEB1guXwspDQU6ORDr/3qwN/hUWkWZZfEMFKl6Tprf6c9VURlQ7M722hjP0ZVLYZZmfvYYQIdPpt13vxzphwSRAurrBEhMJZRSql/RGMbSm2Qn1Bjwlz7VXmVb8lsh2A98TnG/+W5nZS5cdoAQoCX8ws+fCy+/ThxfSEbP0/UA12WJYFUzHU3Vu7nigcYhNUgWOEonQt6meiHoYOHJcA5ovOdqu2ngnYyDZCbTVIngYD61+xptBayNiuHo/179vSM2jqSdv2GMzvNCYIXYfQEs8M4efnQAGvMNyA717TGUh7iFxrl8MvPdOAb0FlRA5HSOqPfgdRpJUL4ffAlfRdXDPQRyTzxe+lB2ItrVsPlTBygZfkSoDAIbBseDfEHUB/ZaLsHhaMziSRli0fK4Bo0c1CPwM/BEucSwnpWHTB64a2UoYcr11e17nBqUzKiBR9Nx/8esaqnZ/8J//gbNvmN5IUT80Q+UoW379efEliSWhBuD2S7iNiYwAQSZmTYoPxvY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(316002)(26005)(426003)(356005)(1076003)(6666004)(40460700001)(30864003)(36860700001)(70586007)(2616005)(83380400001)(336012)(5660300002)(186003)(70206006)(4326008)(81166007)(8676002)(2906002)(86362001)(7696005)(508600001)(16526019)(36756003)(8936002)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 19:19:24.9773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caae6a04-877d-4d2c-9be2-08d9b5c8a70a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds a new IOCTL currently used to implement querying
and setting the stable power state for GPU profiling.  The
stable pstates use fixed clocks and disable certain power
features in order to get accurate pipeline profiling.

Currently this is handled via sysfs, and that is still
available, but this makes it easier for applications
to utilize.  Note that the power state is global so
setting it will affect all applications.  There are currently
no checks in place to prevent multiple applications from
using this interface, but it doesn't make sense to do
profiling while you have multiple applications running in the
first place, so it's up to the user to ensure this in order
to get good results.

This patch add an interface to query what profiling mode is
currently active and to set enable a profiling mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
 include/uapi/drm/amdgpu_drm.h               |  28 +++++
 5 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7fedbb725e17..4cf5bf637a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
-	amdgpu_eeprom.o amdgpu_mca.o
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bc1355c6248d..0e27f9673f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -46,6 +46,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_profile.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
@@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
new file mode 100644
index 000000000000..94fe408e810f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
@@ -0,0 +1,112 @@
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
+#include <drm/amdgpu_drm.h>
+#include "amdgpu.h"
+
+/**
+ * amdgpu_profile_ioctl - Manages settings for profiling.
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_vm
+ * @filp: drm file pointer
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp)
+{
+	union drm_amdgpu_profile *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level current_level, requested_level;
+	int r;
+
+	if (pp_funcs->get_performance_level)
+		current_level = amdgpu_dpm_get_performance_level(adev);
+	else
+		current_level = adev->pm.dpm.forced_level;
+
+	switch (args->in.op) {
+	case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
+		if (args->in.flags)
+			return -EINVAL;
+		switch (current_level) {
+		case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
+			break;
+		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
+			break;
+		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
+			break;
+		case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
+			break;
+		default:
+			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
+			break;
+		}
+		break;
+	case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
+		if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
+			return -EINVAL;
+		switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
+		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
+			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
+			break;
+		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
+			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
+			break;
+		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
+			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
+			break;
+		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
+			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+			break;
+		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
+			requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if ((current_level != requested_level) && pp_funcs->force_performance_level) {
+			mutex_lock(&adev->pm.mutex);
+			r = amdgpu_dpm_force_performance_level(adev, requested_level);
+			if (!r)
+				adev->pm.dpm.forced_level = requested_level;
+			mutex_unlock(&adev->pm.mutex);
+			if (r)
+				return r;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
new file mode 100644
index 000000000000..cd1c597bae11
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
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
+#ifndef __AMDGPU_PROFILE_H__
+#define __AMDGPU_PROFILE_H__
+
+int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp);
+
+#endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 26e45fc5eb1a..b6edf4a826f9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -54,6 +54,7 @@ extern "C" {
 #define DRM_AMDGPU_VM			0x13
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
+#define DRM_AMDGPU_PROFILE		0x16
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -71,6 +72,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
+#define DRM_IOCTL_AMDGPU_PROFILE	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
 
 /**
  * DOC: memory domains
@@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
 	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
 };
 
+/* profile ioctl */
+#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE	1
+#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE	2
+
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK	0xf
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE	0
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD	1
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK	2
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK	3
+#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK	4
+
+struct drm_amdgpu_profile_in {
+	/** AMDGPU_PROFILE_OP_* */
+	__u32	op;
+	__u32	flags;
+};
+
+struct drm_amdgpu_profile_out {
+	__u64	flags;
+};
+
+union drm_amdgpu_profile {
+	struct drm_amdgpu_profile_in in;
+	struct drm_amdgpu_profile_out out;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.31.1

