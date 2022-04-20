Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2686C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 11:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECA810F1B5;
	Wed, 20 Apr 2022 11:14:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1A510F1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 11:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXRBCdeJzrKVmCvERbyPUyA7oK0rc6vxQdufGHw6QWAeHqT/1pIItOzmOOrTrEW8Pf1NNkq23sUNC1YGC6H8UWepvD0RGHnRg/Plj68ymyveKTbLxlzny0lfumAsnZti+gcH+/M/qIvcXGClj8tgsTQavfIm6eFogImXXKcH5R8OLd9finTB/F8ttzyrwm1TZlw8tYagtCCNcujoFI23YcLP+mGOmLOcXBTuLYUqUMstesAOwQr9OG3F5nwLB/EcZbCPPJMg77XIw4IMFbmhkqwMBBk8ohLI3n87LvBpyuQeuu/apvjUPszbxdJbrVAJ7N3fOuY8VK1bAM03n54Hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2/ICa0zWcJmk4l03def9pW+lYWrVdlB9qID4NLPD5s=;
 b=a5UCDQ1vvjIw1MLYj4Yj66iUCqQI/CXgpYsaTSYGt6QcSsOjjBr2eAvbil37/HffpjZ1L2S/9LS6bxMQoPQnNQcTQ5XYRbrxWv3GGebrLJqkFpPlLP4MMYN1dn8jVfjqvKZywWfc6kypefkHpVmttewU9n9wgp80PlqMWGKU42nuBJoIhN7cMweiufKtAgNmbPtan7dq5sXbYHjgpTOBOgl29bzmVZtzutxxC2dWpFnrk2lGS+NLzM8Wx4qnCtH+v4OxzQR2CjW1eHAxEu/kDL2BWntAf57/irDszi9V9B2adMhGHW6MWfS2YsKnCjPQ7G6sgYAPDyaQoDWsl76hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2/ICa0zWcJmk4l03def9pW+lYWrVdlB9qID4NLPD5s=;
 b=VEP7gek8zpZceufYxxxoT3yzgabXMU+/XdtwyqDYYoQEzdARR8AsDCLAiD0Qz6kzdYonQusVETOyFMkd7vIk62aGnEUjAHisSDiTBwBS9E8NIQmqy9XJiN5HTIKWum6h6HeRmzn7jn4kzO0NZgWYjAZimsJVb8KcQSurG9N3cZo=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 11:14:19 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::82) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 11:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:14:18 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:14:17 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
Date: Wed, 20 Apr 2022 19:13:57 +0800
Message-ID: <20220420111357.9488-2-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420111357.9488-1-candice.li@amd.com>
References: <20220420111357.9488-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae02de3-da91-4c90-5314-08da22bee9de
X-MS-TrafficTypeDiagnostic: PH7PR12MB5736:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5736B59D23D57BC7F628059A91F59@PH7PR12MB5736.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFmO0tosNa/oSv8AdcItLCJnt/vgGhC9scvXTYeXToEJbvJupRC3yhzhjv8ZWhrqgpI3oYIZZYVW8PIaJ2BCIoQawE6tFn5baeGnbR/mUnlPRCV7sR6kMCe1M+oAz2AfjQB+nR51NlTM7GgW+73Dp+sH4br29L1Tnxtf17RNxSpZs3tcj10+rw6XQpTmT9cHaL+S6qEy881gBJHJRsgfoogtB0Z7jFyEs4Vc+10ltxn35KaZ+8hZRDqxToZpNrPih9z3W9L1WwBzLHJsnUlj5fX+JS+L9yI3qSI6t6lk0mBGh29/hBX8VnAdnvWGo71SMqUKvSeswF7/sTCx07mcXWgHgGl4GJF2NEmwRmc/WN/V0ZMrVG4bvp/klbUg2coA7TeSxHS642g2vurPLOw8tgpBscg3e6bvLglg/o/iyJ+F3DIqQQGxUabmtL4Moo1vOp3CGhMwblED67WJdbRhZCBab3wiHibmBQSECUBYbD60E/rb+ET1zm4RFIRckaeKWKAHgF+B0tnqtada2TdKAfhH1F+cnPlSQExipgfBWz5NZ8Ayin1UxCS64jer47sJG1UCHcIrBb+OLBuVsteN8/nhhPYEKyuN91fAPXY71WIxmSNbVN4SjkUd/x2LlRoTKywHD2ddja2xUs7Vcg25ICf1GY+BUhqiLUCxwbt+y6gfjlsdV6o0jIapnTvIpu9Hmg0/Jc52g359FrSG/o7lEpQcOEeIhdW5TlOP6Jz3VkYuMuvj6tCzdVW8tYfBSWzR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(86362001)(30864003)(336012)(316002)(2906002)(426003)(81166007)(5660300002)(356005)(2616005)(44832011)(8936002)(508600001)(54906003)(1076003)(82310400005)(70586007)(16526019)(186003)(26005)(7696005)(6666004)(70206006)(4326008)(83380400001)(47076005)(6916009)(8676002)(40460700003)(36756003)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:14:18.8670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae02de3-da91-4c90-5314-08da22bee9de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: Candice Li <candice.li@amd.com>, John Clements <john.clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
Add debugfs support to load/unload/invoke TA in runtime.

v2:
1. Update some variables to static.
2. Use PAGE_ALIGN to calculate shared buf size directly.
3. Remove fp check.
4. Update debugfs from read to write.

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
 4 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7d7af43a258f83..b525f9be9326f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-	amdgpu_eeprom.o amdgpu_mca.o
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 13e4d8f9b87449..eedb12f6b8a32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -38,6 +38,7 @@
 #include "amdgpu_umr.h"
 
 #include "amdgpu_reset.h"
+#include "amdgpu_psp_ta.h"
 
 #if defined(CONFIG_DEBUG_FS)
 
@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		DRM_ERROR("registering register debugfs failed (%d).\n", r);
 
 	amdgpu_debugfs_firmware_init(adev);
+	amdgpu_ta_if_debugfs_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
 	if (amdgpu_device_has_dc_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
new file mode 100644
index 00000000000000..247a476e63544c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -0,0 +1,308 @@
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
+#include "amdgpu_psp_ta.h"
+
+static const char *TA_IF_FS_NAME = "ta_if";
+
+struct dentry *dir;
+static struct dentry *ta_load_debugfs_dentry;
+static struct dentry *ta_unload_debugfs_dentry;
+static struct dentry *ta_invoke_debugfs_dentry;
+
+static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
+					    size_t len, loff_t *off);
+static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
+					    size_t len, loff_t *off);
+static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
+					    size_t len, loff_t *off);
+
+
+static uint32_t get_bin_version(const uint8_t *bin)
+{
+	const struct common_firmware_header *hdr =
+			     (const struct common_firmware_header *)bin;
+
+	return hdr->ucode_version;
+}
+
+static void prep_ta_mem_context(struct psp_context *psp,
+					     struct ta_context *context,
+					     uint8_t *shared_buf,
+					     uint32_t shared_buf_len)
+{
+	context->mem_context.shared_mem_size = PAGE_ALIGN(shared_buf_len);
+	psp_ta_init_shared_buf(psp, &context->mem_context);
+
+	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_len);
+}
+
+static bool is_ta_type_valid(enum ta_type_id ta_type)
+{
+	bool ret = false;
+
+	switch (ta_type) {
+	case TA_TYPE_RAS:
+		ret = true;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations ta_load_debugfs_fops = {
+	.write   = ta_if_load_debugfs_write,
+	.llseek = default_llseek,
+	.owner  = THIS_MODULE
+};
+
+static const struct file_operations ta_unload_debugfs_fops = {
+	.write   = ta_if_unload_debugfs_write,
+	.llseek = default_llseek,
+	.owner  = THIS_MODULE
+};
+
+static const struct file_operations ta_invoke_debugfs_fops = {
+	.write   = ta_if_invoke_debugfs_write,
+	.llseek = default_llseek,
+	.owner  = THIS_MODULE
+};
+
+
+/**
+ * DOC: AMDGPU TA debugfs interfaces
+ *
+ * Three debugfs interfaces can be opened by a program to
+ * load/invoke/unload TA,
+ *
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
+ *
+ * How to use the interfaces in a program?
+ *
+ * A program needs to provide transmit buffer to the interfaces
+ * and will receive buffer from the interfaces below,
+ *
+ * - For TA load debugfs interface:
+ *   Transmit buffer:
+ *    - TA type (4bytes)
+ *    - TA bin length (4bytes)
+ *    - TA bin
+ *   Receive buffer:
+ *    - TA ID (4bytes)
+ *
+ * - For TA invoke debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ *    - TA CMD ID (4bytes)
+ *    - TA shard buf length (4bytes)
+ *    - TA shared buf
+ *   Receive buffer:
+ *    - TA shared buf
+ *
+ * - For TA unload debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ */
+
+static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
+{
+	uint32_t ta_type    = 0;
+	uint32_t ta_bin_len = 0;
+	uint8_t  *ta_bin    = NULL;
+	uint32_t copy_pos   = 0;
+	int      ret        = 0;
+
+	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp    = &adev->psp;
+	struct ta_context    context = {0};
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
+	if (ret || (!is_ta_type_valid(ta_type)))
+		return -EINVAL;
+
+	copy_pos += sizeof(uint32_t);
+
+	ret = copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EINVAL;
+
+	copy_pos += sizeof(uint32_t);
+
+	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
+	if (!ta_bin)
+		ret = -ENOMEM;
+	ret = copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
+	if (ret)
+		goto err_free_bin;
+
+	ret = psp_ras_terminate(psp);
+	if (ret) {
+		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+		goto err_free_bin;
+	}
+
+	context.ta_type             = ta_type;
+	context.ta_load_type        = GFX_CMD_ID_LOAD_TA;
+	context.bin_desc.fw_version = get_bin_version(ta_bin);
+	context.bin_desc.size_bytes = ta_bin_len;
+	context.bin_desc.start_addr = ta_bin;
+
+	ret = psp_ta_load(psp, &context);
+
+	if (ret || context.resp_status) {
+		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
+			 ret, context.resp_status);
+		goto err_free_bin;
+	}
+
+	context.initialized = true;
+	ret = copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_t));
+
+err_free_bin:
+	kfree(ta_bin);
+
+	return ret;
+}
+
+static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
+{
+	uint32_t ta_id  = 0;
+	int      ret    = 0;
+
+	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp    = &adev->psp;
+	struct ta_context    context = {0};
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+	if (ret)
+		return -EINVAL;
+
+	context.session_id = ta_id;
+
+	ret = psp_ta_unload(psp, &context);
+	if (!ret)
+		context.initialized = false;
+
+	return ret;
+}
+
+static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
+{
+	uint32_t ta_id          = 0;
+	uint32_t cmd_id         = 0;
+	uint32_t shared_buf_len = 0;
+	uint8_t	 *shared_buf    = NULL;
+	uint32_t copy_pos       = 0;
+	int      ret            = 0;
+
+	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp    = &adev->psp;
+	struct ta_context    context = {0};
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EINVAL;
+	copy_pos += sizeof(uint32_t);
+
+	ret = copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EINVAL;
+	copy_pos += sizeof(uint32_t);
+
+	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EINVAL;
+	copy_pos += sizeof(uint32_t);
+
+	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
+	if (!shared_buf)
+		ret = -ENOMEM;
+	ret = copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len);
+	if (ret)
+		goto err_free_shared_buf;
+
+	context.session_id = ta_id;
+
+	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+
+	ret = psp_ta_invoke_indirect(psp, cmd_id, &context);
+
+	if (ret || context.resp_status) {
+		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
+			 ret, context.resp_status);
+		goto err_free_ta_shared_buf;
+	}
+
+	ret = copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_len);
+
+err_free_ta_shared_buf:
+	psp_ta_free_shared_buf(&context.mem_context);
+
+err_free_shared_buf:
+	kfree(shared_buf);
+
+	return ret;
+}
+
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
+{
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+
+	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+
+	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
+						     &ta_load_debugfs_fops);
+
+	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
+						     adev, &ta_unload_debugfs_fops);
+
+	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
+						     adev, &ta_invoke_debugfs_fops);
+	return dir;
+}
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	dir = amdgpu_ta_if_debugfs_create(adev);
+#endif
+}
+
+void amdgpu_ta_if_debugfs_remove(void)
+{
+	debugfs_remove_recursive(dir);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
new file mode 100644
index 00000000000000..883f89d57616d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -0,0 +1,30 @@
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
+#ifndef __AMDGPU_PSP_TA_H__
+#define __AMDGPU_PSP_TA_H__
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
+void amdgpu_ta_if_debugfs_remove(void);
+
+#endif
-- 
2.17.1

