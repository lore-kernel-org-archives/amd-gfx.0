Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0DEC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452C510E5D4;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC70F10E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADXeESLZoc7TXQx0m91VocSntgLsnil1Pq0xekMcskNwQew3DCCt2/OEp5TccjUnxAKWJJ1ZDY1A3hcWDw9NBsd7tHMIgGwIVV4F3Z32qW3yGS7QNmxPjJUjIfyK4tVXhPdpZiEGjqZNkplnMw7urpTQvK3CMTFSSbYETMiGEqrdOGnlIAzMzX3yeu0qTaEr1AOXOpIsbYxDzW7CgEwynSyUzrEukijm4fnde75PUcmvsB90TBsQuXq6X3UliJgTA8u0h/vyVu630co1zC4YwTsFW982cZqCZXqhvzqn5wxkgN7J+qK+lFVJs3LRYQuWk0VnfL3IF1O3YbXqDLH8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El1WYKu0eIf/Pa75JfiAw9m8TfYHxYu43ijY1dwPXJ0=;
 b=mjeqkXpPwqIdC09WPWUDcD+9mkyFFtSx5q8y1EpFML1SucNAkrSfo+m6S1KNZa0m4ogrug8fg2vfsZhabKpzuxpwqMCfSI8g9/YOCVxFVNrfOf2X9SshSqe2EpqwtlO3sXxWGFUvyT5vYzDcuQ9xLR9ZgiIEXmQE1UI2vRNYBuRfIccHNMO7H2395jP06p0EkCOyT2zfjHEHy6617p0PIgloP/RaSLu+G6EOrmo8f7C9RyZRDDmMkxK7OFHY0tOiZuuT565yNfWL0f7TSIj4lfCPFNGjTx2yuytZyZ4eFh9d4DSdAeiDL8sVtRGi5J0tOZNMkbmOI+MH1/8Chsxyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El1WYKu0eIf/Pa75JfiAw9m8TfYHxYu43ijY1dwPXJ0=;
 b=vH/is04Spzn6LXR1aUd7V+mDXyvkX/rpET4Bqqx7q5YFCnwsrnOmbaZ6P8nciFf421Sc3A9CxKQFvHbrVfG3/8jww118Qs19lCY/k3ycu/MQBQFY2mHGoTi4coVwZxDpf/KF8Xr4BRc0Y5m94ycI236i9WH/6wBFBwzYJ32HhzE=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::50) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amdgpu: add VPE 6.1.0 support
Date: Thu, 24 Aug 2023 17:31:23 -0400
Message-ID: <20230824213127.2725850-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5228b7-1fa1-4c09-25f0-08dba4e989a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBwLrM3ULtTfDhnTwHdwieqyib5qctZKUiho1ZOyJBZtzjtHoDjPi6shDAY+DqNJ7cMyFgOIoMGA1PVYc4CR1Rc7z4f9vqPMpcU4BicpaZoCW5cotoObOm7foa6NPXLhy5Na5uXHu493dtz8UcDrKA8MvSG4/oMzbDcj6J4Nla243E1ZcU1hrC1ukvHEs2BbusTizWa1rpoQOdQKAtpKwNDs+2rheXyJnyySEp+ygy+RfDgqxOZjmNdO47Ap28MALPTOypOjdpi2omYYc6piL5PaBT17RL9BTypDZpoUteW+Wx9D/Juldr1PlKDAv9aeJnloz9qDfHlM6lgbyfpwTfffnsv4ph6oRwIN2bqun3rDYoa2LViM7Q9qp983k7gUuV2H2dJSLJtIQYuIWDE/L9F6SfkuA58TUPrebkIMedBaKahDNpGK1pp1yXN+93SS4Kto5ij2AQUxcq8+ecnVJTIt9Z4+x5aRFDpsJc08X3GV/K/2CkpgDdIzrDknSXhDMK5Td1kcIuyAnMyOzv8L8Nr4sIN6V7UdobUXuSVXfeGbqzKk8VpWOXho2Fch02FD4c8D++KSYKWw0R03hLplh7SwJu3i6M/iELHuG0eFuDCscuMwwrvTIEHR9vhXUa/gUYvWYEBMWxFzB+qrUpTzzyZpk30sHDMrHhQNYprgPlSLD7h++J9ZudeaaojnOMsFHwqypP/C+yFKjaBUOpRxFZ7VLaab4vPBwhAL1ZYJZIBaEwRCFOpiegiLPhB6qzhhPyMrZV2W6sk7bLcaERODSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(7696005)(86362001)(2906002)(8936002)(8676002)(4326008)(66899024)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(30864003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:54.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5228b7-1fa1-4c09-25f0-08dba4e989a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add skeleton driver code. (Ray)
Add initial support for Video Processing Engine. (Lang)

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 622 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  86 ++++
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 272 +++++++++++
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h   |  29 ++
 6 files changed, 1019 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2a4d960b8347..58f01bfd57a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -214,6 +214,12 @@ amdgpu-y += \
 	jpeg_v4_0.o \
 	jpeg_v4_0_3.o
 
+# add VPE block
+amdgpu-y += \
+	amdgpu_vpe.o \
+	vpe_v6_1.o
+
+#
 # add ATHUB block
 amdgpu-y += \
 	athub_v1_0.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6827ae37ad80..1b83a419f680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -80,6 +80,7 @@
 #include "amdgpu_vce.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_vpe.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
@@ -948,6 +949,9 @@ struct amdgpu_device {
 	/* jpeg */
 	struct amdgpu_jpeg		jpeg;
 
+	/* vpe */
+	struct amdgpu_vpe		vpe;
+
 	/* firmwares */
 	struct amdgpu_firmware		firmware;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
new file mode 100644
index 000000000000..f573a44d5d87
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -0,0 +1,622 @@
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
+ */
+
+#include <linux/firmware.h>
+#include <drm/drm_drv.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ucode.h"
+#include "amdgpu_vpe.h"
+#include "soc15_common.h"
+#include "vpe_v6_1.h"
+
+#define VPE_FW_NAME_LEN		64
+
+#define AMDGPU_CSA_VPE_SIZE 	64
+/* VPE CSA resides in the 4th page of CSA */
+#define AMDGPU_CSA_VPE_OFFSET 	(4096 * 3)
+
+static void vpe_set_ring_funcs(struct amdgpu_device *adev);
+
+int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	const struct vpe_firmware_header_v1_0 *vpe_hdr;
+	char fw_name[VPE_FW_NAME_LEN];
+	char fw_prefix[VPE_FW_NAME_LEN];
+	int ret;
+
+	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", fw_prefix);
+
+	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, fw_name);
+	if (ret)
+		goto out;
+
+	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw->data;
+	adev->vpe.fw_version = le32_to_cpu(vpe_hdr->header.ucode_version);
+	adev->vpe.feature_version = le32_to_cpu(vpe_hdr->ucode_feature_version);
+
+	return 0;
+out:
+	dev_err(adev->dev, "fail to initialize vpe microcode\n");
+	release_firmware(adev->vpe.fw);
+	adev->vpe.fw = NULL;
+	return ret;
+}
+
+int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = container_of(vpe, struct amdgpu_device, vpe);
+	struct amdgpu_ring *ring = &vpe->ring;
+	int ret;
+
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	ring->doorbell_index = (adev->doorbell_index.vpe_ring << 1);
+	snprintf(ring->name, 4, "vpe");
+
+	ret = amdgpu_ring_init(adev, ring, 1024, &vpe->trap_irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe)
+{
+	amdgpu_ring_fini(&vpe->ring);
+
+	return 0;
+}
+
+static int vpe_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	switch (adev->ip_versions[VPE_HWIP][0]) {
+	case IP_VERSION(6, 1, 0):
+		vpe_v6_1_set_funcs(vpe);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vpe_set_ring_funcs(adev);
+	vpe_set_regs(vpe);
+
+	return 0;
+}
+
+static int vpe_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	int ret;
+
+	ret = vpe_irq_init(vpe);
+	if (ret)
+		goto out;
+
+	ret = vpe_ring_init(vpe);
+	if (ret)
+		goto out;
+
+	ret = vpe_init_microcode(vpe);
+	if (ret)
+		goto out;
+out:
+	return ret;
+}
+
+static int vpe_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	release_firmware(vpe->fw);
+	vpe->fw = NULL;
+
+	vpe_ring_fini(vpe);
+
+	return 0;
+}
+
+static int vpe_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	int ret;
+
+	ret = vpe_load_microcode(vpe);
+	if (ret)
+		return ret;
+
+	ret = vpe_ring_start(vpe);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vpe_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	vpe_ring_stop(vpe);
+
+	return 0;
+}
+
+static int vpe_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return vpe_hw_fini(adev);
+}
+
+static int vpe_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return vpe_hw_init(adev);
+}
+
+static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
+{
+	int i;
+
+	amdgpu_ring_write(ring, ring->funcs->nop |
+				VPE_CMD_NOP_HEADER_COUNT(count - 1));
+
+	for (i = 0; i < count - 1; i++)
+		amdgpu_ring_write(ring, 0);
+}
+
+static void vpe_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
+{
+	uint32_t pad_count;
+	int i;
+
+	pad_count = (-ib->length_dw) & 0x7;
+
+	ib->ptr[ib->length_dw++] = ring->funcs->nop |
+				   VPE_CMD_NOP_HEADER_COUNT(pad_count - 1);
+
+	for (i = 0; i < pad_count - 1; i++)
+		ib->ptr[ib->length_dw++] = 0;
+
+}
+
+static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t index = 0;
+	uint64_t csa_mc_addr;
+
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
+		return 0;
+
+	csa_mc_addr = amdgpu_csa_vaddr(adev) + AMDGPU_CSA_VPE_OFFSET +
+		      index * AMDGPU_CSA_VPE_SIZE;
+
+	return csa_mc_addr;
+}
+
+static void vpe_ring_emit_ib(struct amdgpu_ring *ring,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib,
+			     uint32_t flags)
+{
+	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
+	uint64_t csa_mc_addr = vpe_get_csa_mc_addr(ring, vmid);
+
+	/* IB packet must end on a 8 DW boundary */
+	vpe_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_INDIRECT, 0) |
+				VPE_CMD_INDIRECT_HEADER_VMID(vmid & 0xf));
+
+	/* base must be 32 byte aligned */
+	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0);
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, ib->length_dw);
+	amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr));
+	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
+}
+
+static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
+				uint64_t seq, unsigned int flags)
+{
+	int i = 0;
+
+	do {
+		/* write the fence */
+		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
+		/* zero in first two bits */
+		WARN_ON_ONCE(addr & 0x3);
+		amdgpu_ring_write(ring, lower_32_bits(addr));
+		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write(ring, i == 0 ? lower_32_bits(seq) : upper_32_bits(seq));
+		addr += 4;
+	} while ((flags & AMDGPU_FENCE_FLAG_64BIT) && (i++ < 1));
+
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
+		/* generate an interrupt */
+		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_TRAP, 0));
+		amdgpu_ring_write(ring, 0);
+	}
+
+}
+
+static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+{
+	uint32_t seq = ring->fence_drv.sync_seq;
+	uint64_t addr = ring->fence_drv.gpu_addr;
+
+	/* wait for idle */
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_POLL_REGMEM,
+				VPE_POLL_REGMEM_SUBOP_REGMEM) |
+				VPE_CMD_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
+				VPE_CMD_POLL_REGMEM_HEADER_MEM(1));
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, seq); /* reference */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
+	amdgpu_ring_write(ring, VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+				VPE_CMD_POLL_REGMEM_DW5_INTERVAL(4));
+}
+
+static void vpe_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+{
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_REG_WRITE, 0));
+	amdgpu_ring_write(ring,	reg << 2);
+	amdgpu_ring_write(ring, val);
+}
+
+static void vpe_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				   uint32_t val, uint32_t mask)
+{
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_POLL_REGMEM,
+				VPE_POLL_REGMEM_SUBOP_REGMEM) |
+				VPE_CMD_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
+				VPE_CMD_POLL_REGMEM_HEADER_MEM(0));
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, val); /* reference */
+	amdgpu_ring_write(ring, mask); /* mask */
+	amdgpu_ring_write(ring, VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+				VPE_CMD_POLL_REGMEM_DW5_INTERVAL(10));
+}
+
+static void vpe_ring_emit_vm_flush(struct amdgpu_ring *ring, unsigned int vmid,
+				   uint64_t pd_addr)
+{
+	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+}
+
+static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring)
+{
+	unsigned int ret;
+
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0));
+	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
+	amdgpu_ring_write(ring, 1);
+	ret = ring->wptr & ring->buf_mask;/* this is the offset we need patch later */
+	amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and patch it later */
+
+	return ret;
+}
+
+static void vpe_ring_patch_cond_exec(struct amdgpu_ring *ring, unsigned int offset)
+{
+	unsigned int cur;
+
+	WARN_ON_ONCE(offset > ring->buf_mask);
+	WARN_ON_ONCE(ring->ring[offset] != 0x55aa55aa);
+
+	cur = (ring->wptr - 1) & ring->buf_mask;
+	if (cur > offset)
+		ring->ring[offset] = cur - offset;
+	else
+		ring->ring[offset] = (ring->buf_mask + 1) - offset + cur;
+}
+
+static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	uint32_t preempt_reg = vpe->regs.queue0_preempt;
+	int i, r = 0;
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* emit the trailing fence */
+	ring->trail_seq += 1;
+	amdgpu_ring_alloc(ring, 10);
+	vpe_ring_emit_fence(ring, ring->trail_fence_gpu_addr, ring->trail_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	/* assert IB preemption */
+	WREG32(vpe_get_reg_offset(vpe, ring->me, preempt_reg), 1);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		dev_err(adev->dev, "ring %d failed to be preempted\n", ring->idx);
+	}
+
+	/* deassert IB preemption */
+	WREG32(vpe_get_reg_offset(vpe, ring->me, preempt_reg), 0);
+
+	/* deassert the preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+
+	return r;
+}
+
+static int vpe_set_clockgating_state(void *handle,
+				     enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static int vpe_set_powergating_state(void *handle,
+				     enum amd_powergating_state state)
+{
+	return 0;
+}
+
+static uint64_t vpe_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	uint64_t rptr;
+
+	if (ring->use_doorbell) {
+		rptr = atomic64_read((atomic64_t *)ring->rptr_cpu_addr);
+		dev_dbg(adev->dev, "rptr/doorbell before shift == 0x%016llx\n", rptr);
+	} else {
+		rptr = RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_rptr_hi));
+		rptr = rptr << 32;
+		rptr |= RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_rptr_lo));
+		dev_dbg(adev->dev, "rptr before shift [%i] == 0x%016llx\n", ring->me, rptr);
+	}
+
+	return (rptr >> 2);
+}
+
+static uint64_t vpe_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	uint64_t wptr;
+
+	if (ring->use_doorbell) {
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		dev_dbg(adev->dev, "wptr/doorbell before shift == 0x%016llx\n", wptr);
+	} else {
+		wptr = RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_hi));
+		wptr = wptr << 32;
+		wptr |= RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_lo));
+		dev_dbg(adev->dev, "wptr before shift [%i] == 0x%016llx\n", ring->me, wptr);
+	}
+
+	return (wptr >> 2);
+}
+
+static void vpe_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	if (ring->use_doorbell) {
+		dev_dbg(adev->dev, "Using doorbell, \
+			wptr_offs == 0x%08x, \
+			lower_32_bits(ring->wptr) << 2 == 0x%08x, \
+			upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+			ring->wptr_offs,
+			lower_32_bits(ring->wptr << 2),
+			upper_32_bits(ring->wptr << 2));
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr << 2);
+		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+	} else {
+		dev_dbg(adev->dev, "Not using doorbell, \
+			regVPEC_QUEUE0_RB_WPTR == 0x%08x, \
+			regVPEC_QUEUE0_RB_WPTR_HI == 0x%08x\n",
+			lower_32_bits(ring->wptr << 2),
+			upper_32_bits(ring->wptr << 2));
+		WREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_lo),
+		       lower_32_bits(ring->wptr << 2));
+		WREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_hi),
+		       upper_32_bits(ring->wptr << 2));
+	}
+}
+
+static int vpe_ring_test_ring(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const uint32_t test_pattern = 0xdeadbeef;
+	uint32_t index, i;
+	uint64_t wb_addr;
+	int ret;
+
+	ret = amdgpu_device_wb_get(adev, &index);
+	if (ret) {
+		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
+		return ret;
+	}
+
+	adev->wb.wb[index] = 0;
+	wb_addr = adev->wb.gpu_addr + (index * 4);
+
+	ret = amdgpu_ring_alloc(ring, 4);
+	if (ret) {
+		dev_err(adev->dev, "amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, ret);
+		goto out;
+	}
+
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
+	amdgpu_ring_write(ring, lower_32_bits(wb_addr));
+	amdgpu_ring_write(ring, upper_32_bits(wb_addr));
+	amdgpu_ring_write(ring, test_pattern);
+	amdgpu_ring_commit(ring);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (le32_to_cpu(adev->wb.wb[index]) == test_pattern)
+			goto out;
+		udelay(1);
+	}
+
+	ret = -ETIMEDOUT;
+out:
+	amdgpu_device_wb_free(adev, index);
+
+	return ret;
+}
+
+static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const uint32_t test_pattern = 0xdeadbeef;
+	struct amdgpu_ib ib = {};
+	struct dma_fence *f = NULL;
+	uint32_t index;
+	uint64_t wb_addr;
+	int ret;
+
+	ret = amdgpu_device_wb_get(adev, &index);
+	if (ret) {
+		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
+		return ret;
+	}
+
+	adev->wb.wb[index] = 0;
+	wb_addr = adev->wb.gpu_addr + (index * 4);
+
+	ret = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	if (ret)
+		goto err0;
+
+	ib.ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
+	ib.ptr[1] = lower_32_bits(wb_addr);
+	ib.ptr[2] = upper_32_bits(wb_addr);
+	ib.ptr[3] = test_pattern;
+	ib.ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib.ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib.ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib.ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib.length_dw = 8;
+
+	ret = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	if (ret)
+		goto err1;
+
+	ret = dma_fence_wait_timeout(f, false, timeout);
+	if (ret <= 0) {
+		ret = ret ? : -ETIMEDOUT;
+		goto err1;
+	}
+
+	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
+
+err1:
+	amdgpu_ib_free(adev, &ib, NULL);
+	dma_fence_put(f);
+err0:
+	amdgpu_device_wb_free(adev, index);
+
+	return ret;
+}
+
+static const struct amdgpu_ring_funcs vpe_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_VPE,
+	.align_mask = 0xf,
+	.nop = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0),
+	.support_64bit_ptrs = true,
+	.get_rptr = vpe_ring_get_rptr,
+	.get_wptr = vpe_ring_get_wptr,
+	.set_wptr = vpe_ring_set_wptr,
+	.emit_frame_size =
+		5 + /* vpe_ring_init_cond_exec */
+		6 + /* vpe_ring_emit_pipeline_sync */
+		10 + 10 + 10 + /* vpe_ring_emit_fence */
+		/* vpe_ring_emit_vm_flush */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6,
+	.emit_ib_size = 7 + 6,
+	.emit_ib = vpe_ring_emit_ib,
+	.emit_pipeline_sync = vpe_ring_emit_pipeline_sync,
+	.emit_fence = vpe_ring_emit_fence,
+	.emit_vm_flush = vpe_ring_emit_vm_flush,
+	.emit_wreg = vpe_ring_emit_wreg,
+	.emit_reg_wait = vpe_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.insert_nop = vpe_ring_insert_nop,
+	.pad_ib = vpe_ring_pad_ib,
+	.test_ring = vpe_ring_test_ring,
+	.test_ib = vpe_ring_test_ib,
+	.init_cond_exec = vpe_ring_init_cond_exec,
+	.patch_cond_exec = vpe_ring_patch_cond_exec,
+	.preempt_ib = vpe_ring_preempt_ib,
+};
+
+static void vpe_set_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->vpe.ring.funcs = &vpe_ring_funcs;
+}
+
+const struct amd_ip_funcs vpe_ip_funcs = {
+	.name = "vpe_v6_1",
+	.early_init = vpe_early_init,
+	.late_init = NULL,
+	.sw_init = vpe_sw_init,
+	.sw_fini = vpe_sw_fini,
+	.hw_init = vpe_hw_init,
+	.hw_fini = vpe_hw_fini,
+	.suspend = vpe_suspend,
+	.resume = vpe_resume,
+	.soft_reset = NULL,
+	.set_clockgating_state = vpe_set_clockgating_state,
+	.set_powergating_state = vpe_set_powergating_state,
+};
+
+const struct amdgpu_ip_block_version vpe_v6_1_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VPE,
+	.major = 6,
+	.minor = 1,
+	.rev = 0,
+	.funcs = &vpe_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
new file mode 100644
index 000000000000..010fa7f308fd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -0,0 +1,86 @@
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
+ */
+
+#ifndef __AMDGPU_VPE_H__
+#define __AMDGPU_VPE_H__
+
+#include "amdgpu_ring.h"
+#include "amdgpu_irq.h"
+#include "vpe_6_1_fw_if.h"
+
+struct amdgpu_vpe;
+
+struct vpe_funcs {
+	uint32_t (*get_reg_offset)(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset);
+	void (*set_regs)(struct amdgpu_vpe *vpe);
+	int (*irq_init)(struct amdgpu_vpe *vpe);
+	int (*init_microcode)(struct amdgpu_vpe *vpe);
+	int (*load_microcode)(struct amdgpu_vpe *vpe);
+	int (*ring_init)(struct amdgpu_vpe *vpe);
+	int (*ring_start)(struct amdgpu_vpe *vpe);
+	int (*ring_stop)(struct amdgpu_vpe *vpe);
+	int (*ring_fini)(struct amdgpu_vpe *vpe);
+};
+
+struct vpe_regs {
+	uint32_t queue0_rb_rptr_lo;
+	uint32_t queue0_rb_rptr_hi;
+	uint32_t queue0_rb_wptr_lo;
+	uint32_t queue0_rb_wptr_hi;
+	uint32_t queue0_preempt;
+};
+
+struct amdgpu_vpe {
+	struct amdgpu_ring		ring;
+	struct amdgpu_irq_src		trap_irq;
+
+	const struct vpe_funcs		*funcs;
+	struct vpe_regs			regs;
+
+	const struct firmware		*fw;
+	uint32_t			fw_version;
+	uint32_t			feature_version;
+};
+
+int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
+int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
+int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
+
+#define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
+#define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
+#define vpe_ring_stop(vpe) ((vpe)->funcs->ring_stop ? (vpe)->funcs->ring_stop((vpe)) : 0)
+#define vpe_ring_fini(vpe) ((vpe)->funcs->ring_fini ? (vpe)->funcs->ring_fini((vpe)) : 0)
+
+#define vpe_get_reg_offset(vpe, inst, offset) \
+		((vpe)->funcs->get_reg_offset ? (vpe)->funcs->get_reg_offset((vpe), (inst), (offset)) : 0)
+#define vpe_set_regs(vpe) \
+		((vpe)->funcs->set_regs ? (vpe)->funcs->set_regs((vpe)) : 0)
+#define vpe_irq_init(vpe) \
+		((vpe)->funcs->irq_init ? (vpe)->funcs->irq_init((vpe)) : 0)
+#define vpe_init_microcode(vpe) \
+		((vpe)->funcs->init_microcode ? (vpe)->funcs->init_microcode((vpe)) : 0)
+#define vpe_load_microcode(vpe) \
+		((vpe)->funcs->load_microcode ? (vpe)->funcs->load_microcode((vpe)) : 0)
+
+extern const struct amdgpu_ip_block_version vpe_v6_1_ip_block;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
new file mode 100644
index 000000000000..1a483d38e70d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -0,0 +1,272 @@
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
+ */
+
+#include <linux/firmware.h>
+#include <drm/drm_drv.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ucode.h"
+#include "amdgpu_vpe.h"
+#include "vpe_v6_1.h"
+#include "soc15_common.h"
+#include "ivsrcid/vpe/irqsrcs_vpe_6_1.h"
+#include "vpe/vpe_6_1_0_offset.h"
+#include "vpe/vpe_6_1_0_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/vpe_6_1_0.bin");
+
+#define VPE_THREAD1_UCODE_OFFSET	0x8000
+
+static uint32_t vpe_v6_1_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
+{
+	uint32_t base;
+
+	base = vpe->ring.adev->reg_offset[VPE_HWIP][0][0];
+
+	return base + offset;
+}
+
+static void vpe_v6_1_halt(struct amdgpu_vpe *vpe, bool halt)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	uint32_t f32_cntl;
+
+	f32_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL));
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, halt ? 1 : 0);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, halt ? 1 : 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL), f32_cntl);
+}
+
+static int vpe_v6_1_irq_init(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = container_of(vpe, struct amdgpu_device, vpe);
+	int ret;
+
+	ret = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_VPE,
+				VPE_6_1_SRCID__VPE_TRAP,
+				&adev->vpe.trap_irq);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	const struct vpe_firmware_header_v1_0 *vpe_hdr;
+	const __le32 *data;
+	uint32_t ucode_offset[2], ucode_size[2];
+	uint32_t i, size_dw;
+	uint32_t ret;
+
+	// disable UMSCH_INT_ENABLE
+	ret = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+	ret = REG_SET_FIELD(ret, VPEC_CNTL, UMSCH_INT_ENABLE, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), ret);
+
+	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw->data;
+
+	/* Thread 0(command thread) ucode offset/size */
+	ucode_offset[0] = le32_to_cpu(vpe_hdr->header.ucode_array_offset_bytes);
+	ucode_size[0] = le32_to_cpu(vpe_hdr->ctx_ucode_size_bytes);
+	/* Thread 1(control thread) ucode offset/size */
+	ucode_offset[1] = le32_to_cpu(vpe_hdr->ctl_ucode_offset);
+	ucode_size[1] = le32_to_cpu(vpe_hdr->ctl_ucode_size_bytes);
+
+	vpe_v6_1_halt(vpe, true);
+
+	for (i = 0; i < 2; i++) {
+		if (i > 0)
+			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_ADDR), VPE_THREAD1_UCODE_OFFSET);
+		else
+			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_ADDR), 0);
+
+		data = (const __le32 *)(adev->vpe.fw->data + ucode_offset[i]);
+		size_dw = ucode_size[i] / sizeof(__le32);
+
+		while (size_dw--) {
+			if (amdgpu_emu_mode && size_dw % 500 == 0)
+				msleep(1);
+			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_DATA), le32_to_cpup(data++));
+		}
+
+	}
+
+	vpe_v6_1_halt(vpe, false);
+
+	return 0;
+}
+
+static int vpe_v6_1_ring_start(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_ring *ring = &vpe->ring;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t rb_bufsz, rb_cntl;
+	uint32_t ib_cntl;
+	uint32_t doorbell, doorbell_offset;
+	int ret;
+
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_VMID, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR), 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_HI), 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR), 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR_HI), 0);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+
+	ring->wptr = 0;
+
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 1);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+	doorbell = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL));
+	doorbell_offset = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL_OFFSET));
+
+	doorbell = REG_SET_FIELD(doorbell, VPEC_QUEUE0_DOORBELL, ENABLE, ring->use_doorbell ? 1 : 0);
+	doorbell_offset = REG_SET_FIELD(doorbell_offset, VPEC_QUEUE0_DOORBELL_OFFSET, OFFSET, ring->doorbell_index);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL), doorbell);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
+
+	adev->nbio.funcs->vpe_doorbell_range(adev, 0, ring->use_doorbell, ring->doorbell_index, 2);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+	ib_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
+
+	ring->sched.ready = true;
+
+	ret = amdgpu_ring_test_helper(ring);
+	if (ret) {
+		ring->sched.ready = false;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vpe_v_6_1_ring_stop(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	uint32_t rb_cntl, ib_cntl;
+
+	rb_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+	ib_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
+
+	vpe->ring.sched.ready = false;
+
+	return 0;
+}
+
+static int vpe_v6_1_set_trap_irq_state(struct amdgpu_device *adev,
+				       struct amdgpu_irq_src *source,
+				       unsigned int type,
+				       enum amdgpu_interrupt_state state)
+{
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	uint32_t vpe_cntl;
+
+	vpe_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+	vpe_cntl = REG_SET_FIELD(vpe_cntl, VPEC_CNTL, TRAP_ENABLE,
+				 state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), vpe_cntl);
+
+	return 0;
+}
+
+static int vpe_v6_1_process_trap_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry)
+{
+
+	dev_dbg(adev->dev, "IH: VPE trap\n");
+
+	switch (entry->client_id) {
+	case SOC21_IH_CLIENTID_VPE:
+		amdgpu_fence_process(&adev->vpe.ring);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
+{
+	vpe->regs.queue0_rb_rptr_lo = regVPEC_QUEUE0_RB_RPTR;
+	vpe->regs.queue0_rb_rptr_hi = regVPEC_QUEUE0_RB_RPTR_HI;
+	vpe->regs.queue0_rb_wptr_lo = regVPEC_QUEUE0_RB_WPTR;
+	vpe->regs.queue0_rb_wptr_hi = regVPEC_QUEUE0_RB_WPTR_HI;
+	vpe->regs.queue0_preempt = regVPEC_QUEUE0_PREEMPT;
+}
+
+static const struct vpe_funcs vpe_v6_1_funcs = {
+	.get_reg_offset = vpe_v6_1_get_reg_offset,
+	.set_regs = vpe_v6_1_set_regs,
+	.irq_init = vpe_v6_1_irq_init,
+	.init_microcode = amdgpu_vpe_init_microcode,
+	.load_microcode = vpe_v6_1_load_microcode,
+	.ring_init = amdgpu_vpe_ring_init,
+	.ring_start = vpe_v6_1_ring_start,
+	.ring_stop = vpe_v_6_1_ring_stop,
+	.ring_fini = amdgpu_vpe_ring_fini,
+};
+
+static const struct amdgpu_irq_src_funcs vpe_v6_1_trap_irq_funcs = {
+	.set = vpe_v6_1_set_trap_irq_state,
+	.process = vpe_v6_1_process_trap_irq,
+};
+
+void vpe_v6_1_set_funcs(struct amdgpu_vpe *vpe)
+{
+	vpe->funcs = &vpe_v6_1_funcs;
+	vpe->trap_irq.funcs = &vpe_v6_1_trap_irq_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h
new file mode 100644
index 000000000000..a9bea7905a77
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h
@@ -0,0 +1,29 @@
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
+ */
+#ifndef __VPE_V6_1_H__
+#define __VPE_V6_1_H__
+
+#include "amdgpu_vpe.h"
+
+void vpe_v6_1_set_funcs(struct amdgpu_vpe *vpe);
+
+#endif
-- 
2.41.0

