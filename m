Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A5C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B04661074
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B04661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75F989DC1;
	Tue,  6 Apr 2021 09:49:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5399F89DC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 09:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP2CznxpyvYPqkjIVugnMM0ECr68D7T8Fgut0SqVRTjr2pTwKWVTb0vMhdOhyEJowl/bjp2vP4GqyDpb3viTEj5CUPgL6YE7DjgbArjIMBYa9o3g84kXbB0Sj778NoB74V3Je3WbMR+mb4R5Cu/u0mI2+1maj8BJWrQU3798JNXyJxNtqU92z+FET30vfy+F5tCk/ta+jQGO+9Qu9RM8Z5q8ou1Qtbvfcm+FUBik94VyIPr2NNUaLKxIj6VTHrcD2kvnD+9cAxbufnhwsula1UeXv5XEIvRPr9EX1j1ce4t+boH2x0amIwXuOs7Nj9z215WYU1s35YItkvOy9Nidsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As6VuAH3+FV0Y+k3tfszA7bafYBt1uKtC3fX/GgDJyg=;
 b=OK+yl6t8hsg4Gu5T6D/SozdKiGph5fmihEw7kYONYXaUcRlM41IafAmEBRe1L/Mui+2Gv7vUu+U5/xk1Ox2SGCgL/9wyhg+N0S8CoyrsgrCi346JOWGtpx7PKSvHY5aeu9nGzOdhW0Z464poDPolXjK9p4C81sCerco39HHp/5dViIyfrt9v/GHL2zgLOPugqAX1hclVUmCu0QHPTtmiYIUTJ55vGuM2uGlXK4PnSbiLA5S5+2pmeg74pn+UF1bkDBpNBzvyqLd440F+/pp/Y72mMdAIqPtyk00fyD0Brc1P/y6wZ4Vg5mjBOiproN2ylh5xNeSWzFuFXEkXd57IUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As6VuAH3+FV0Y+k3tfszA7bafYBt1uKtC3fX/GgDJyg=;
 b=4lFMNQTr1ONauxKEoLy38vlLG2QgWkjL1xZrBV8QhHQ/tT1MBp+ckzarD+nvVa/EciXprpfwj5DkgZlvtG6EEvaIN8vzhiS9hAneUsTd1XBFkZaIw7pUU/HO1z5ahY0GvZ2HMbQ3gQ8csJWB1hHFY6IQ/jmS2Syz5LnPX0gnqps=
Received: from BN0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:e7::17)
 by BN6PR12MB1268.namprd12.prod.outlook.com (2603:10b6:404:1a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 09:49:23 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::7d) by BN0PR03CA0042.outlook.office365.com
 (2603:10b6:408:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 09:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 09:49:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 04:49:22 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Tue, 6 Apr 2021 04:49:20 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add show_fdinfo() interface
Date: Tue, 6 Apr 2021 17:49:15 +0800
Message-ID: <20210406094915.22984-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7581ba25-093f-40f4-d23d-08d8f8e141ea
X-MS-TrafficTypeDiagnostic: BN6PR12MB1268:
X-Microsoft-Antispam-PRVS: <BN6PR12MB126898F67B851C9719223F22FF769@BN6PR12MB1268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVeTOMgZGZ0Lj+QbHePzDbWmlDXRqNAzbLBg4ipaZ43XluNfQ8rvr9CU6aQSzZWYh6175HMn9MumU6gpt5sbfNl64ExxI8AGTlX9LhFR00f8BTC15RccNggIi2EiVL7wBaJKxZbK0HEzXSyFt1F7MkEm0OmwBGw4eYBkIEeukz7swb/OhzPN4zeD15cKHMhzEsXv7QTULIG3OADatnL/ufssDJkYxEsHRXGlRJppjW3E2gSXN5gLc/+HZeAQHO7CPUrV8aKzsVJpKrpFicDb8xFT2fVG33133klh9KRNcJH/IFV1Po/HMpH5VKHqJKwtIGWH55RpOAT2AhBXZ9YDWEP7woq0CHKGCfnK+sDLog2D+XTmKNVUgckN/Qhd3lleBjMUpVZ7RDipTO59J51Ye8YEh1LqBWOD1JVRut9OwwQj8OwsjX1Xk17okBVBh7GnfU5Tj00FjiiGiEyDZWv8kdzl4mMUVIOr8OjIxLcul8oNOjDZdVzuuctDaYmgCs31JmMLIz/it+geYpRQB9A51+0FV0YughLntkDU1zZUQbk2R/SDiEnGXDPf6ZCfUN65QP7AzoxRS2AvM+1rt6y6wK2IP/9d2N32JKzyzs7XBc2IfrAmz6Py/lyLd7g4Asgk621LKlTsdJOWD93OxH5uDn2CjBNBYT/4wxXc7OaFHnrPTSdGJ/YPsWsEy/1DMb55
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(6916009)(186003)(86362001)(336012)(82310400003)(8676002)(426003)(70206006)(54906003)(36756003)(36860700001)(5660300002)(4326008)(83380400001)(1076003)(30864003)(70586007)(356005)(6666004)(8936002)(81166007)(316002)(2906002)(7696005)(82740400003)(2616005)(478600001)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 09:49:22.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7581ba25-093f-40f4-d23d-08d8f8e141ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1268
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
Cc: Alexander.Deucher@amd.com, Roy Sun <Roy.Sun@amd.com>,
 David M Nieto <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tracking devices, process info and fence info using
/proc/pid/fdinfo

Signed-off-by: David M Nieto <David.Nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    | 282 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h    |  58 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
 drivers/gpu/drm/scheduler/sched_main.c        |  11 +-
 8 files changed, 371 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee85e8aba636..f9de1acc65dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
-	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
+	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o amdgpu_fdinfo.o\
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616c85a01299..35843c8d133d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_fdinfo.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -477,6 +478,8 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct drm_file		*file;
+	struct amdgpu_proc	*proc;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e93850f2f3b1..702fd9054883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1042,13 +1042,15 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 					  struct dma_fence **ef)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *new_vm;
 	int ret;
 
-	new_vm = kzalloc(sizeof(*new_vm), GFP_KERNEL);
-	if (!new_vm)
+	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
+	if (!fpriv)
 		return -ENOMEM;
 
+	new_vm = &fpriv->vm;
 	/* Initialize AMDGPU part of the VM */
 	ret = amdgpu_vm_init(adev, new_vm, AMDGPU_VM_CONTEXT_COMPUTE, pasid);
 	if (ret) {
@@ -1063,12 +1065,14 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 
 	*vm = (void *) new_vm;
 
+	amdgpu_fdinfo_init(adev, fpriv, pasid);
+
 	return 0;
 
 init_kfd_vm_fail:
 	amdgpu_vm_fini(adev, new_vm);
 amdgpu_vm_init_fail:
-	kfree(new_vm);
+	kfree(fpriv);
 	return ret;
 }
 
@@ -1142,6 +1146,8 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
+	struct amdgpu_fpriv *fpriv =
+		container_of(avm, struct amdgpu_fpriv, vm);
 
 	if (WARN_ON(!kgd || !vm))
 		return;
@@ -1149,8 +1155,9 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 	pr_debug("Destroying process vm %p\n", vm);
 
 	/* Release the VM context */
+	amdgpu_fdinfo_fini(adev, fpriv);
 	amdgpu_vm_fini(adev, avm);
-	kfree(vm);
+	kfree(fpriv);
 }
 
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4bcc03c4c6c5..07aed377dec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -42,7 +42,7 @@
 #include "amdgpu_irq.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_sched.h"
-
+#include "amdgpu_fdinfo.h"
 #include "amdgpu_amdkfd.h"
 
 #include "amdgpu_ras.h"
@@ -1691,6 +1691,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = amdgpu_show_fdinfo
+#endif
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
new file mode 100644
index 000000000000..5208fab6e35d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,282 @@
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
+#include <linux/debugfs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/reboot.h>
+#include <linux/syscalls.h>
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_debugfs.h>
+
+#include "amdgpu.h"
+#include "amdgpu_fdinfo.h"
+
+
+static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
+	[AMDGPU_HW_IP_GFX]	=	"gfx",
+	[AMDGPU_HW_IP_COMPUTE]	=	"compute",
+	[AMDGPU_HW_IP_DMA]	=	"dma",
+	[AMDGPU_HW_IP_UVD]	=	"dec",
+	[AMDGPU_HW_IP_VCE]	=	"enc",
+	[AMDGPU_HW_IP_UVD_ENC]	=	"enc_1",
+	[AMDGPU_HW_IP_VCN_DEC]	=	"dec",
+	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
+	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
+};
+
+struct amdgpu_proc {
+	struct amdgpu_device *adev;
+	struct amdgpu_fpriv *priv;
+	int pasid;
+};
+
+int amdgpu_fdinfo_init(struct amdgpu_device *adev,
+	struct amdgpu_fpriv *fpriv, int pasid)
+{
+	struct amdgpu_proc *proc;
+
+	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
+	if (!proc)
+		return -ENOMEM;
+	proc->pasid = pasid;
+	proc->adev = adev;
+	proc->priv = fpriv;
+	fpriv->proc = proc;
+
+	return 0;
+}
+
+int amdgpu_fdinfo_fini(struct amdgpu_device *adev,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_proc *proc = fpriv->proc;
+
+	if (proc)
+		kfree(proc);
+
+	fpriv->proc = NULL;
+	return 0;
+}
+
+uint64_t amdgpu_get_proc_mem(struct amdgpu_fpriv *fpriv)
+{
+	int id;
+	struct drm_gem_object *gobj;
+	uint64_t total = 0;
+
+	spin_lock(&fpriv->file->table_lock);
+	idr_for_each_entry(&fpriv->file->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		unsigned int domain = amdgpu_mem_type_to_domain(
+			bo->tbo.mem.mem_type);
+
+		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
+			total += amdgpu_bo_size(bo);
+	}
+	spin_unlock(&fpriv->file->table_lock);
+
+	if (fpriv->vm.process_info) {
+		struct kgd_mem *mem;
+
+		mutex_lock(&fpriv->vm.process_info->lock);
+		list_for_each_entry(mem, &fpriv->vm.process_info->kfd_bo_list,
+			validate_list.head) {
+			struct amdgpu_bo *bo = mem->bo;
+			unsigned int domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
+
+			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
+				total += amdgpu_bo_size(bo);
+			}
+
+		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
+			validate_list.head) {
+			struct amdgpu_bo *bo = mem->bo;
+			unsigned int domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
+
+			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
+				total += amdgpu_bo_size(bo);
+		}
+
+		mutex_unlock(&fpriv->vm.process_info->lock);
+	}
+
+	return total;
+}
+
+uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed)
+{
+	struct amdgpu_ctx_entity *centity;
+	struct idr *idp;
+	struct amdgpu_ctx *ctx;
+	uint32_t id, i;
+	uint64_t now, t1, t2;
+	uint64_t total = 0, min = 0;
+
+
+	if (idx >= AMDGPU_MAX_ENTITY_NUM)
+		return 0;
+
+	idp = &fpriv->ctx_mgr.ctx_handles;
+
+	mutex_lock(&fpriv->ctx_mgr.lock);
+	idr_for_each_entry(idp, ctx, id) {
+		if (!ctx->entities[hwip][idx])
+			continue;
+
+		centity = ctx->entities[hwip][idx];
+
+		for (i = 0; i < amdgpu_sched_jobs; i++) {
+			struct dma_fence *fence;
+			struct drm_sched_fence *s_fence;
+
+			spin_lock(&ctx->ring_lock);
+			fence = dma_fence_get(centity->fences[i]);
+			spin_unlock(&ctx->ring_lock);
+			if (!fence)
+				continue;
+			s_fence = to_drm_sched_fence(fence);
+			if (!dma_fence_is_signaled(&s_fence->scheduled))
+				continue;
+			now = ktime_to_ns(ktime_get());
+			t1 = ktime_to_ns(s_fence->scheduled.timestamp);
+			t2 = !dma_fence_is_signaled(&s_fence->finished) ?
+				0 : ktime_to_ns(s_fence->finished.timestamp);
+			dma_fence_put(fence);
+
+			t1 = now - t1;
+			t2 = (t2 == 0) ? 0 : now - t2;
+			total += t1 - t2;
+			if (t1 > min)
+				min = t1;
+		}
+
+	}
+
+	mutex_unlock(&fpriv->ctx_mgr.lock);
+
+	if (elapsed)
+		*elapsed = min;
+
+	return total;
+}
+
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id)
+{
+	enum amd_ip_block_type type;
+	uint32_t count = 0;
+	int i;
+
+	switch (id) {
+	case AMDGPU_HW_IP_GFX:
+		type = AMD_IP_BLOCK_TYPE_GFX;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		type = AMD_IP_BLOCK_TYPE_GFX;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		type = AMD_IP_BLOCK_TYPE_SDMA;
+		break;
+	case AMDGPU_HW_IP_UVD:
+		type = AMD_IP_BLOCK_TYPE_UVD;
+		break;
+	case AMDGPU_HW_IP_VCE:
+		type = AMD_IP_BLOCK_TYPE_VCE;
+		break;
+	case AMDGPU_HW_IP_UVD_ENC:
+		type = AMD_IP_BLOCK_TYPE_UVD;
+		break;
+	case AMDGPU_HW_IP_VCN_DEC:
+	case AMDGPU_HW_IP_VCN_ENC:
+		type = AMD_IP_BLOCK_TYPE_VCN;
+		break;
+	case AMDGPU_HW_IP_VCN_JPEG:
+		type = (amdgpu_device_ip_get_ip_block(adev,
+			AMD_IP_BLOCK_TYPE_JPEG)) ?
+			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
+		break;
+	default:
+		return 0;
+	}
+
+	for (i = 0; i < adev->num_ip_blocks; i++)
+		if (adev->ip_blocks[i].version->type == type &&
+		    adev->ip_blocks[i].status.valid &&
+		    count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
+			count++;
+	return count;
+
+}
+
+#ifdef CONFIG_PROC_FS
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_device *adev;
+	uint32_t bus, dev, fn, i;
+
+	if (amdgpu_file_to_fpriv(f, &fpriv))
+		return;
+
+	adev = fpriv->proc->adev;
+	bus = adev->pdev->bus->number;
+	dev = PCI_SLOT(adev->pdev->devfn);
+	fn = PCI_FUNC(adev->pdev->devfn);
+	seq_printf(m, "amdgpu_%02x:%02x.%d:pasid:\t%u\n", bus, dev, fn,
+			fpriv->proc->pasid);
+
+	seq_printf(m, "amdgpu_%02x:%02x.%d:mem:\t%llu kB\n", bus, dev, fn,
+			amdgpu_get_proc_mem(fpriv)/1024UL);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		uint32_t enabled = amdgpu_get_ip_count(adev, i);
+		uint32_t count = amdgpu_ctx_num_entities[i];
+		int idx = 0;
+		uint64_t total = 0, min = 0;
+		uint32_t perc, frac;
+
+		if (enabled) {
+			for (idx = 0; idx < count; idx++) {
+				total = amdgpu_get_fence_usage(fpriv,
+					i, idx, &min);
+
+				if ((total == 0) || (min == 0))
+					continue;
+
+				perc = div64_u64(10000 * total, min);
+				frac = perc % 100;
+
+				seq_printf(m, "amdgpu_%02x:%02x.%d:%s%d:\t%d.%d%%\n",
+						bus, dev, fn,
+						amdgpu_ip_name[i],
+						idx, perc/100, frac);
+			}
+		}
+	}
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
new file mode 100644
index 000000000000..1f776b3a5f45
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -0,0 +1,58 @@
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
+ * Authors: David Nieto
+ */
+#ifndef __AMDGPU_SMI_H__
+#define __AMDGPU_SMI_H__
+
+#include <linux/idr.h>
+#include <linux/kfifo.h>
+#include <linux/rbtree.h>
+#include <drm/gpu_scheduler.h>
+#include <drm/drm_file.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <linux/sched/mm.h>
+
+#include "amdgpu_sync.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ids.h"
+
+struct amdgpu_proc;
+struct amdgpu_ctx;
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
+
+uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
+
+uint64_t amdgpu_get_proc_mem(struct amdgpu_fpriv *fpriv);
+
+int amdgpu_fdinfo_init(struct amdgpu_device *adev,
+		struct amdgpu_fpriv *fpriv, int pasid);
+
+int amdgpu_fdinfo_fini(struct amdgpu_device *adev,
+		struct amdgpu_fpriv *fpriv);
+
+#ifdef CONFIG_PROC_FS
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+#endif
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..c2407c08b2ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -41,6 +41,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_fdinfo.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1139,6 +1140,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
 
 	file_priv->driver_priv = fpriv;
+	fpriv->file = file_priv;
+	amdgpu_fdinfo_init(adev, fpriv, pasid);
 	goto out_suspend;
 
 error_vm:
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..4e5d8d4af010 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
 
 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from pending list
  *
  * @sched: scheduler instance
  * @max: job numbers to relaunch
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 static struct drm_sched_job *
 drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *next;
 
 	/*
 	 * Don't destroy jobs while the timeout worker is running  OR thread
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+		/* account for the next fence in the queue */
+		next = list_first_entry_or_null(&sched->pending_list,
+				struct drm_sched_job, list);
+		if (next) {
+			next->s_fence->scheduled.timestamp =
+				job->s_fence->finished.timestamp;
+		}
 	} else {
 		job = NULL;
 		/* queue timeout for next job */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
