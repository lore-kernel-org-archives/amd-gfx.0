Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338DCC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF21C61930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF21C61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75016E0C9;
	Mon, 22 Mar 2021 03:05:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2183A6E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPO7sWBbsGIvxyVnews8i2/MRHu5hgvt4Kk4MJ6oLqGznKaWfZzBjviqugNDpLSV8L1vqs9M0c8kEzIp7wfD1Jjb3AyXzojJvhybS+2qe9WIKy3lykuXBJseLs1BrMbDk5o+lfvlkPNbK2sYmdheBOVE97lbKJJ38kh7QWIGLttADqSgsaKj3OMyHhZfbO0QBNslBXeSTe30D14I6rCjrC4f8GtbLL/4auhiNj6UyI4wk72znaMLY8cG2hEeHx1ias2xXVLGE0+//6TvUH3T9LGfgb2hBk2OM8wpKbzkWafhem/oniDHyWhyifJt53DXVWPeZ5b2xap7mCwBU5CAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwwxGA72J1iJXc5sCL3A6Dly6IJWWFf/1mECUVc8QS8=;
 b=Jr5Y+gXIxN/xXTal3nqzP8B4JKLy6OldyJXzl0REcSRl3it0HsyXu/Qxgz8MOhi2UpK3po8U+bMy8WIychXJ2CI7BKk86Y6AGChH4fcAYW+P2EYrq5sNqCg5CUw+E+8POQDI3kOJnQO4I/2w4ii/EgD4d0gkN8+3qPSDShlLOUpUFfFWfME4J4RuWERWIlgNtMMmzJpj181uPGO01bG2cD/fuz5Q5HuXAsHi8LybzY44Y7bc+6ogbPUEzvmLX8LD0MAEC1FX5QJ/0WE7OUxFW2v1vkDMPlkp0dGbDamSqoXAH85bb+zbPCjAT1YmaULauk4LB1R1Gr1QOh63OC1EVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwwxGA72J1iJXc5sCL3A6Dly6IJWWFf/1mECUVc8QS8=;
 b=Zb8BjL/3GNY/CrpKGOhN3B+Ed/8rxOsO57HSWVc8G4rT/s+M62ISsPNgUgY/ha+gUuLN05K7SF4S3pWju7ItI/nwrMQY/aiw3KF4afkg+x1CQacQ+VENMiAIIKUYHM5cjzK3W/5ubUiy+53d3DX/3JseXPV/UxwP88R2/dvBdVw=
Received: from BN9PR03CA0897.namprd03.prod.outlook.com (2603:10b6:408:13c::32)
 by MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 03:05:15 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::83) by BN9PR03CA0897.outlook.office365.com
 (2603:10b6:408:13c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:14 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:13 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: SMI-LIB handlers
Date: Mon, 22 Mar 2021 11:05:07 +0800
Message-ID: <20210322030510.31607-3-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322030510.31607-1-Roy.Sun@amd.com>
References: <20210322030510.31607-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22df1911-55c8-44c8-eebe-08d8ecdf50ff
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02089C0B86636675CCB6DE98FF659@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSINZhrEN1Clzut2KfCnfQwsuhHObR0H/2/qUAslUrQHvaKc1UTkVy2eKQKQ7BzhDs3sgJgQ2cpEpztemjBjmj0g+ll+54145P9BXDqBVl2nI72qLbbwu5OZ7W3IBH7Z0ecLUfsJmr+TgmUz4NO65KPS9Pj/DalhdFqJufiyXGFM+02aiVPOd1GGLJLGf09sYCqWLZa8rWX0UiOH9H0qfRkJ6wA5b7HR7a+ZK7Tk/mvttQpNr3OkrCp0n8f+dudsrGTGgFmAjv+Z6CoPItTactOGjuxigFGgsM9lj8F0k/9PnB+8s3JAHYcIzizVYru+3G7+e8D1QWw7ZNrmMplsD6NVm9WCdkpLf/cKoi1huR4sc/mjaLAXc150IUPRmr/joqSEntaDtasXs26CE0iiKop1W0Ej4qwW9lbEhxCpwHpqk9i3qbY/KsOzdtFr7wQ99eRok5JoRlLJkyyzGYWaB4Ij02UOHurH6ONc0Vu5Y9WQydgpB20SYXoGS2Xg3MAb3lN0jPBKGtnWMLJNZGhFWJmhFgERKTaFH5HDzJiHRIwMNCRw1v+narW5vugD1/wLd62iniwPoo7SKFVy7ZLraxUx9ip0IWbA4SPNzoBCc8nrRJ9loowtvEsNOfklVyuiQ7pBo95neiH15Ia5Z6sMl8S5Mnw00i+2Jg+udW+cohVDus4VO0kxdwhZW8hSN9Ej
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(478600001)(6666004)(2616005)(1076003)(30864003)(6916009)(426003)(36860700001)(8676002)(7696005)(5660300002)(2906002)(8936002)(47076005)(82310400003)(54906003)(186003)(26005)(336012)(316002)(36756003)(83380400001)(82740400003)(81166007)(86362001)(356005)(70206006)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:15.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22df1911-55c8-44c8-eebe-08d8ecdf50ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add fence tracking interfaces and core
structures for SMI ioctl management

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_smi.c | 433 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_smi.h |  61 ++++
 4 files changed, 514 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_smi.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_smi.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 741b68874e53..789800d16804 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -36,7 +36,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/include \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
-	-I$(FULL_AMD_PATH)/amdkfd
+	-I$(FULL_AMD_PATH)/amdkfd \
+	-I$(FULL_AMD_PATH)/amdsmi/inc
 
 amdgpu-y := amdgpu_drv.o
 
@@ -56,7 +57,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_smi.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
@@ -236,4 +237,9 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
 
 endif
 
+# SMI component
+AMDSMI_PATH := ../amdsmi
+include $(FULL_AMD_PATH)/amdsmi/Makefile
+amdgpu-y += $(AMDSMI_FILES)
+
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7e1f66120c50..b10632866ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -108,6 +108,7 @@
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
 #include "amdgpu_hdp.h"
+#include "amdgpu_smi.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -268,6 +269,7 @@ struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct amdgpu_atif;
+struct amdgpu_smi_proc;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 
@@ -475,6 +477,9 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct drm_file		*file;
+	struct amdgpu_smi_proc  *proc;
+	void			*smi_priv;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
@@ -824,6 +829,9 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry			*debugfs_proc;
+#endif
 	struct amdgpu_atif		*atif;
 	struct amdgpu_atcs		atcs;
 	struct mutex			srbm_mutex;
@@ -1082,6 +1090,10 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+
+	/* SMI process tracking */
+	struct idr			procs;
+	struct mutex			proc_lock;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.c
new file mode 100644
index 000000000000..c7eb549b7ebb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.c
@@ -0,0 +1,433 @@
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
+ *
+ */
+
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
+#include "amdgpu_smi.h"
+
+#include "smi_core.h"
+
+static const char *amdgpu_smi_ip_name[AMDGPU_HW_IP_NUM] = {
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
+struct amdgpu_smi_proc_hwip {
+	struct dentry *entry;
+	int id;
+};
+
+
+struct amdgpu_smi_proc {
+	struct amdgpu_fpriv *priv;
+	struct dentry *entry;
+	int pasid;
+	struct dentry *d_name;
+	struct dentry *d_pid;
+	struct dentry *d_mem;
+	struct dentry *d_hwdir;
+	struct amdgpu_smi_proc_hwip hwip[AMDGPU_HW_IP_NUM];
+};
+
+uint64_t amdgpu_smi_get_proc_mem(struct amdgpu_fpriv *fpriv)
+{
+	int id;
+	struct drm_gem_object *gobj;
+	uint64_t total = 0;
+
+	spin_lock(&fpriv->file->table_lock);
+	idr_for_each_entry(&fpriv->file->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		unsigned int domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
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
+			    validate_list.head) {
+			struct amdgpu_bo *bo = mem->bo;
+			unsigned int domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
+
+			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
+				total += amdgpu_bo_size(bo);
+		}
+
+		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
+			    validate_list.head) {
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
+static int proc_mem_show(struct seq_file *seq, void *v)
+{
+	struct amdgpu_fpriv *fpriv = seq->private;
+
+	seq_printf(seq, "%lld\n", amdgpu_smi_get_proc_mem(fpriv));
+
+	return 0;
+}
+
+static int proc_mem_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_mem_show, inode->i_private);
+}
+
+static int proc_name_show(struct seq_file *seq, void *v)
+{
+	struct amdgpu_fpriv *fpriv = seq->private;
+
+	seq_printf(seq, "%s\n", fpriv->vm.task_info.process_name);
+
+	return 0;
+}
+
+static int proc_name_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_name_show, inode->i_private);
+}
+
+static int proc_pid_show(struct seq_file *seq, void *v)
+{
+	struct amdgpu_fpriv *fpriv = seq->private;
+
+	seq_printf(seq, "%d\n", fpriv->vm.task_info.pid);
+
+	return 0;
+}
+
+static int proc_pid_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_pid_show, inode->i_private);
+}
+
+static const struct file_operations proc_name_fops = {
+	.owner = THIS_MODULE,
+	.open = proc_name_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations proc_pid_fops = {
+	.owner = THIS_MODULE,
+	.open = proc_pid_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations proc_mem_fops = {
+	.owner = THIS_MODULE,
+	.open = proc_mem_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+
+uint64_t amdgpu_smi_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed)
+{
+	struct amdgpu_ctx_entity *centity;
+	struct idr *idp;
+	struct amdgpu_ctx *ctx;
+	uint32_t id, j;
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
+		for (j = 0; j < amdgpu_sched_jobs; j++) {
+			struct dma_fence *fence;
+			struct drm_sched_fence *s_fence;
+
+			spin_lock(&ctx->ring_lock);
+			fence = dma_fence_get(centity->fences[j]);
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
+			t2 = t2 == 0 ? 0 : now - t2;
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
+static int proc_hwip_seq_show(struct seq_file *seq, void *v)
+{
+	struct amdgpu_smi_proc_hwip *hwip = seq->private;
+	struct amdgpu_smi_proc *proc = container_of(hwip,
+			struct amdgpu_smi_proc, hwip[hwip->id]);
+	struct amdgpu_fpriv *fpriv = proc->priv;
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_ENTITY_NUM; i++) {
+		uint64_t total, min;
+		uint32_t perc, frac;
+
+		total = amdgpu_smi_get_fence_usage(fpriv, hwip->id, i, &min);
+
+		if ((total == 0) || (min == 0))
+			continue;
+
+		perc = div64_u64(10000 * total, min);
+		frac = perc % 100;
+
+		seq_printf(seq, "%s<%d>:%d.%d%%\n",
+				amdgpu_smi_ip_name[hwip->id],
+				i, perc/100, frac);
+	}
+	return 0;
+}
+
+static int proc_hwip_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hwip_seq_show, inode->i_private);
+}
+
+static const struct file_operations proc_hwip_fops = {
+	.owner = THIS_MODULE,
+	.open = proc_hwip_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+uint32_t amdgpu_smi_get_ip_count(struct amdgpu_device *adev, int id)
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
+int amdgpu_smi_create_proc_node(struct amdgpu_device *adev,
+		struct amdgpu_fpriv *fpriv, int pasid)
+{
+	char name[16];
+	struct amdgpu_smi_proc *proc;
+	int i, r, id;
+
+	if (!adev->debugfs_proc)
+		return -EIO;
+
+	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
+
+	if (!proc)
+		return -ENOMEM;
+
+	if (fpriv->file) {
+		r = smi_core_open(fpriv->file);
+
+		if (r) {
+			kfree(proc);
+			return r;
+		}
+	}
+
+	id = idr_alloc(&adev->procs, fpriv, pasid, pasid + 1, GFP_KERNEL);
+
+	snprintf(name, 16, "%d", pasid);
+
+	proc->entry = debugfs_create_dir(name, adev->debugfs_proc);
+
+	if (!proc->entry) {
+		DRM_ERROR("unable to create proc %s debugfs dir\n", name);
+		kfree(proc);
+		return -EIO;
+	}
+
+	proc->pasid = id;
+
+	proc->d_name = debugfs_create_file("name", 0444, proc->entry, fpriv,
+			&proc_name_fops);
+
+	proc->d_pid = debugfs_create_file("pid", 0444, proc->entry, fpriv,
+			&proc_pid_fops);
+
+	proc->d_mem = debugfs_create_file("mem", 0444, proc->entry, fpriv,
+			&proc_mem_fops);
+
+	proc->d_hwdir = debugfs_create_dir("fences", proc->entry);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		if (amdgpu_smi_get_ip_count(adev, i)) {
+			proc->hwip[i].entry =
+				debugfs_create_file(amdgpu_smi_ip_name[i], 0444,
+						proc->d_hwdir, &proc->hwip[i],
+						&proc_hwip_fops);
+				proc->hwip[i].id = i;
+		}
+	}
+
+	fpriv->proc = proc;
+	proc->priv = fpriv;
+
+	return 0;
+}
+
+int amdgpu_smi_remove_proc_node(struct amdgpu_device *adev,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_smi_proc *proc = fpriv->proc;
+	struct smi_ctx *smi_ctx = (struct smi_ctx *) fpriv->smi_priv;
+	int i;
+
+	if (!adev->debugfs_proc)
+		return -EIO;
+
+	if (proc) {
+		idr_remove(&adev->procs, proc->pasid);
+		for (i = 0; i < AMDGPU_HW_IP_NUM; i++)
+			if (proc->hwip[i].entry)
+				debugfs_remove(proc->hwip[i].entry);
+		debugfs_remove(proc->d_hwdir);
+		debugfs_remove(proc->d_pid);
+		debugfs_remove(proc->d_name);
+		debugfs_remove(proc->d_mem);
+		debugfs_remove(proc->entry);
+		kfree(proc);
+	}
+
+	fpriv->proc = NULL;
+
+	if (smi_ctx)
+		smi_core_release(fpriv);
+
+	return 0;
+}
+
+
+int amdgpu_smi_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *filp)
+{
+	struct drm_amdgpu_smi *args = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+
+	return smi_core_ioctl_handler(fpriv->smi_priv, args);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.h
new file mode 100644
index 000000000000..fd6747f090a1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smi.h
@@ -0,0 +1,61 @@
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
+
+struct amdgpu_smi_proc;
+struct amdgpu_smi_ctx;
+
+int amdgpu_smi_create_proc_node(struct amdgpu_device *adev,
+				struct amdgpu_fpriv *fpriv,
+				int pasid);
+
+int amdgpu_smi_remove_proc_node(struct amdgpu_device *adev,
+				struct amdgpu_fpriv *fpriv);
+
+int amdgpu_smi_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *filp);
+
+uint32_t amdgpu_smi_get_ip_count(struct amdgpu_device *adev, int id);
+
+uint64_t amdgpu_smi_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
+
+uint64_t amdgpu_smi_get_proc_mem(struct amdgpu_fpriv *fpriv);
+
+#endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
