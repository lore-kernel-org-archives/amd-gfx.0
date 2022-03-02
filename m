Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF434C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 21:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DBF10E210;
	Wed,  2 Mar 2022 21:25:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48A810E210
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 21:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsSJjm2h+FyoIaCjlONSN1sd0aXcC0yHr6pip156VnDVlXPR/RoPvkOxhXjptMEz3AdyxKUrd5cjq6UpuN+dtLrPxRFoA2vapkGJf3xZ0ksXZJExBbiI1djIDtIND43xbSJFKC2geRICxXZ2USZSuXytTh1UdLUIx3xHf5pYo0upxCgj1VQhZofqmiWhdWEkbVE+bmteYsfME0cag3TRjgFdyRi60hX57sZ5CwO+wqrxKZUpKr+0FQah03PLnp9GgaVcbOCAY9/mSWAkli3yiILqeoW8M41lVhOFqW4BpcRxyl0gPoq2ts1dsO0aD2PmzAjYy0KTIgmE+9mHz8Nz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNlgm0dkHReu2FiP/fukYgH5Ps6yoD3Kl8s3UCKB5wQ=;
 b=n+y/T0+Kqgjhdh2ju5FhLEt74GMavyv0Rr1HY+on5pjxawG8TJune9X4UEGV20EtELE1ajsinjViAMAmOJwTXIqgZha3M5OyIml5SG5XIyOkzS3BctBQSHTcpBsDwhHgJTRdxAul3X5b+yhGVNSCNDgCRYnIov8D9NXkgB68yt7zo/TbEKIHrcAD1+IXR8v2r5ZLX7A7HevF/hAjfcAKjlGttU6qrIUpAd9UuVD01cUvl/FV2ia/4mh6Cnpo2vE018KPa/kMXs+FiMD0D3Oicoahdgc/LTKiUndLvSoDlFKmfyKG5w8rCqEjBGU50gA/KvSm+c34/XYNlbZGy7dvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNlgm0dkHReu2FiP/fukYgH5Ps6yoD3Kl8s3UCKB5wQ=;
 b=nszkkvdVObccwZ0PFqcHDEZ/L+Vis5C0bLwjIgr1XfrwClqZ8whO9Cbb3GXMvHic54wemNFaIzt/oKzGdbt0vhNuGbQVjdejXJkQMADeiwirlYMNVCYRGFWicr5b18uPmemlMv6GD6seEufdTfrOtuBpJXidBmLbwCudJVsizXs=
Received: from DM5PR19CA0029.namprd19.prod.outlook.com (2603:10b6:3:9a::15) by
 BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Wed, 2 Mar
 2022 21:25:51 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::8e) by DM5PR19CA0029.outlook.office365.com
 (2603:10b6:3:9a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 21:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 21:25:51 +0000
Received: from ruijing-small-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 15:25:49 -0600
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/vcn: Add vcn firmware log
Date: Wed, 2 Mar 2022 16:25:10 -0500
Message-ID: <20220302212510.1743386-2-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302212510.1743386-1-ruijing.dong@amd.com>
References: <20220302212510.1743386-1-ruijing.dong@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8a5c78-69bf-4785-2081-08d9fc9339f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4872:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48728FD2B92038A1485BED4395039@BY5PR12MB4872.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeoOeP4eLdHz8Akf1qGpC2HfOO4BrJgvzWEJbVV37/krE7x2D5zMuzaKd85nUxqGQ0zWwM7830Vx9xBI913rL4df0TQTRs5rSjGOBMqswuVRL2PLPlPBdRbMCh+TvnFGM5qotxYZXmtSreYbpO8nUOk2nuH71HPRm+0FUGiqz8pI74xtnlgSuYshX43IWZbWVzUWDdkz76SqAMTPqwD4CWsz1LvQYchXPjd1HTZlwo6MFi1p/bzesty7vF8CZWxfJRJNQeoAxeCw5ropS+UbwzswySoftjrlo/T1LJPMhsJwJcXkRwgY2kKYcRzbkYfeo4afSyQtwRJKvJwd/WLKm9jlJmYWuZsHaVLpv1HCZOTASuUbBGQelB+yBA5XSd6sNS0gQgPnfwo0W+2h4eQSlw5X2GVMm/ftKAvtwOi9cdS8y6USvdtGeVZ+m9xvODRqPnGieM4gUXREJK6aN0yPqZLaYO3yo3j9uP5VTKbs5LKshzfMCYHcvK5EZvEGsvi2CMaFjn8Z0y7H6CtHY13/1KWaS+JF8NyIxuANMNEoUuUWVzCkxuJwpeudgcM0OS5EgdDplm47LxJuyH3VQDMAw+NwVHMwb0I81NigZLXOKhrLBc61zxL0qPgFQbmqz/g3gfAFmHLlBrv2mUrj4KWEH8kVHZpdrScqeEdCAJJ9RwM8BYQYBiyrkV9cH0YPhFnex76/UwbuJJbBir3f8W+0QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(356005)(2906002)(7696005)(81166007)(47076005)(426003)(336012)(16526019)(186003)(83380400001)(2616005)(82310400004)(6916009)(26005)(1076003)(54906003)(8936002)(316002)(4326008)(8676002)(508600001)(36756003)(70206006)(70586007)(6666004)(30864003)(44832011)(40460700003)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:25:51.0090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8a5c78-69bf-4785-2081-08d9fc9339f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vcn fwlog is for debugging purpose only,
by default, it is disabled.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 122 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c       |   7 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c       |   4 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   3 +
 9 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d990ebfd2afc..704861a4fcae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -233,6 +233,9 @@ extern int amdgpu_cik_support;
 #endif
 extern int amdgpu_num_kcq;
 
+#define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
+extern int amdgpu_vcnfw_log;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2f4f8c5618d8..555ba091da54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1776,6 +1776,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_ring_init(adev, ring);
 	}
 
+	for ( i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (!amdgpu_vcnfw_log)
+			break;
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		amdgpu_debugfs_vcn_fwlog_init(adev, i, &adev->vcn.inst[i]);
+	}
+
 	amdgpu_ras_debugfs_create_all(adev);
 	amdgpu_rap_debugfs_init(adev);
 	amdgpu_securedisplay_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3571df3c1a95..4c20c23d6ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -178,6 +178,7 @@ int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
+int amdgpu_vcnfw_log;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -855,6 +856,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
+/**
+ * DOC: vcnfw_log (int)
+ * Enable vcnfw log output for debugging, the default is disabled.
+ */
+MODULE_PARM_DESC(vcnfw_log, "Enable vcnfw log(0 = disable (default value), 1 = enable)");
+module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
+
 /**
  * DOC: smu_pptable_id (int)
  * Used to override pptable id. id = 0 use VBIOS pptable.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6f3f55e39ab1..f99093f2ebc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -27,6 +27,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/debugfs.h>
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -79,7 +80,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
-	unsigned int fw_shared_size;
+	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
@@ -228,8 +229,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 	fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+	log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
 	bo_size += fw_shared_size;
 
+	if (amdgpu_vcnfw_log)
+		bo_size += AMDGPU_VCNFW_LOG_SIZE;
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -249,6 +254,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 
 		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
 
+		if (amdgpu_vcnfw_log) {
+			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
+		}
+
 		if (adev->vcn.indirect_sram) {
 			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
 					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
@@ -983,3 +994,112 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 }
+
+/*
+ * debugfs for mapping vcn firmware log buffer.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
+                                             size_t size, loff_t *pos)
+{
+	struct amdgpu_vcn_inst *vcn;
+	void *log_buf;
+	volatile struct amdgpu_vcn_fwlog *plog;
+	unsigned int read_pos, write_pos, available, i, read_bytes = 0;
+	unsigned int read_num[2] = {0};
+
+	vcn = file_inode(f)->i_private;
+	if (!vcn)
+		return -ENODEV;
+
+	if (!vcn->fw_shared.cpu_addr || !amdgpu_vcnfw_log)
+		return -EFAULT;
+
+	log_buf = vcn->fw_shared.cpu_addr + vcn->fw_shared.mem_size;
+
+	plog = (volatile struct amdgpu_vcn_fwlog *)log_buf;
+	read_pos = plog->rptr;
+	write_pos = plog->wptr;
+
+	if (read_pos > AMDGPU_VCNFW_LOG_SIZE || write_pos > AMDGPU_VCNFW_LOG_SIZE)
+		return -EFAULT;
+
+	if (!size || (read_pos == write_pos))
+		return 0;
+
+	if (write_pos > read_pos) {
+		available = write_pos - read_pos;
+		read_num[0] = min(size, (size_t)available);
+	} else {
+		read_num[0] = AMDGPU_VCNFW_LOG_SIZE - read_pos;
+		available = read_num[0] + write_pos - plog->header_size;
+		if (size > available)
+			read_num[1] = write_pos - plog->header_size;
+		else if (size > read_num[0])
+			read_num[1] = size - read_num[0];
+		else
+			read_num[0] = size;
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (read_num[i]) {
+			if (read_pos == AMDGPU_VCNFW_LOG_SIZE)
+				read_pos = plog->header_size;
+			if (read_num[i] == copy_to_user((buf + read_bytes),
+			                                (log_buf + read_pos), read_num[i]))
+				return -EFAULT;
+
+			read_bytes += read_num[i];
+			read_pos += read_num[i];
+		}
+	}
+
+	plog->rptr = read_pos;
+	*pos += read_bytes;
+	return read_bytes;
+}
+
+static const struct file_operations amdgpu_debugfs_vcnfwlog_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_vcn_fwlog_read,
+	.llseek = default_llseek
+};
+#endif
+
+void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
+                                   struct amdgpu_vcn_inst *vcn)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	sprintf(name, "amdgpu_vcn_%d_fwlog", i);
+	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, vcn,
+				 &amdgpu_debugfs_vcnfwlog_fops,
+				 AMDGPU_VCNFW_LOG_SIZE);
+#endif
+}
+
+void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn)
+{
+#if defined(CONFIG_DEBUG_FS)
+	volatile uint32_t *flag = vcn->fw_shared.cpu_addr;
+	void *fw_log_cpu_addr = vcn->fw_shared.cpu_addr + vcn->fw_shared.mem_size;
+	uint64_t fw_log_gpu_addr = vcn->fw_shared.gpu_addr + vcn->fw_shared.mem_size;
+	volatile struct amdgpu_vcn_fwlog *log_buf = fw_log_cpu_addr;
+	volatile struct amdgpu_fw_shared_fw_logging *fw_log = vcn->fw_shared.cpu_addr
+                                                         + vcn->fw_shared.log_offset;
+	*flag |= cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
+	fw_log->is_enabled = 1;
+	fw_log->addr_lo = cpu_to_le32(fw_log_gpu_addr & 0xFFFFFFFF);
+	fw_log->addr_hi = cpu_to_le32(fw_log_gpu_addr >> 32);
+	fw_log->size = cpu_to_le32(AMDGPU_VCNFW_LOG_SIZE);
+
+	log_buf->header_size = sizeof(struct amdgpu_vcn_fwlog);
+	log_buf->buffer_size = AMDGPU_VCNFW_LOG_SIZE;
+	log_buf->rptr = log_buf->header_size;
+	log_buf->wptr = log_buf->header_size;
+	log_buf->wrapped = 0;
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f6569a7d6fdb..e2fde88aaf5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -158,6 +158,7 @@
 #define AMDGPU_VCN_FW_SHARED_FLAG_0_RB	(1 << 6)
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
 #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
+#define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
@@ -335,4 +336,7 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
 void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
 
+void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
+void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
+                                   uint8_t i, struct amdgpu_vcn_inst *vcn);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 3799226defc0..7bbb9ba6b80b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -148,6 +148,13 @@ static int vcn_v1_0_sw_init(void *handle)
 
 	adev->vcn.pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
 
+	if (amdgpu_vcnfw_log) {
+		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+
+		fw_shared->present_flag_0 = 0;
+		amdgpu_vcn_fwlog_init(adev->vcn.inst);
+	}
+
 	r = jpeg_v1_0_sw_init(handle);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 36ec877a2a55..319ac8ea434b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -174,6 +174,10 @@ static int vcn_v2_0_sw_init(void *handle)
 
 	fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(adev->vcn.inst);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index e656a6747f0b..1869bae4104b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -198,6 +198,9 @@ static int vcn_v2_5_sw_init(void *handle)
 
 		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
+
+		if (amdgpu_vcnfw_log)
+			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ae9dfb29621f..530e4deae9c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -218,6 +218,9 @@ static int vcn_v3_0_sw_init(void *handle)
 					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
 					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
 		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
+
+		if (amdgpu_vcnfw_log)
+			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.25.1

