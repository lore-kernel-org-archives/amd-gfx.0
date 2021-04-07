Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C245C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D11601FB
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D11601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C469A6E0E1;
	Wed,  7 Apr 2021 13:31:17 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680056.outbound.protection.outlook.com [40.107.68.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8775D6E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 13:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP+hyXJYVU1ZMbhy/fp0eX2FGAxP2WgTZcbv6SCDaKsqVex6z7vi736IyRIneWjStRdJZiJa9RxbOztAu5LQgdXZLhqZd0zbKKpXIafshMhuEgNPHcdMxoohCGjFKzb9dePl74IY/JdF7hRJhtDA8kV/RcgQVta2DA/qkVr04Py7tR46zzJd6Wjm4a9VJkE0NIhuiZbK0Frv1pqLTKPIWOdsHEm1PBz17LbjmZnn2joSG3WJvw79wnGfdhu1AWZkvL3qk0nEPvqCzgyeZRd+clikNZnaque9Yvipuy3hbzI3fWT/DJwRst2BsbaHGT1TG6PpIUn9yt9VyVAWpGyj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSfvnGbyuljSOrZIcTIvLHIXTOL+zC2Y7R0BjMTjQ2M=;
 b=ZPWSIa3qQIT6p6WfVe2cYhdcQ+vlGpRJqm/kVcdvwFexkFNO10viCb9fo/qVS72uaAHmIaYjBU6OsPdze8VUEjC4UJVqKokEkF7VeUH9Lgjv411d2qzqaas0h6Qfjex7V58MJj1n7PHznGZGG+IcigTtbATpcx7wxb/cGGxvihfXZyXbJF9G3/I3N60LBhe+ePElxO8OngF3A8P3kL0ZprhpapLkwnx2DTkJu35f5L7MHilHurpTKamsOdba9SVQgs2a/aNqTMQviaMcM7SA/35yCvQ34d4g6cYrZKSm+IS2Mrfo7I5JWkplVWf+losrqPqHdvzwI5+/WTgQ/Y9vxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSfvnGbyuljSOrZIcTIvLHIXTOL+zC2Y7R0BjMTjQ2M=;
 b=hZPKEfC3Nt2NgVXHBwyTfds2ScBjLs55aaOiIEe1/chSbL/3HQeIqgxZ0ZbPPxvCzb3C/I9IBXXGoWGCiy0gw+Z4veM0w+ljZR27Yqr9kZqm4Ih2YQBF8TUFkeygUy05zVJFaE/j/xmNM9uahrc4U4C3FqMCjyzmSeRWBtF9PPM=
Received: from BN6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:404:13e::25)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 13:31:14 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::f3) by BN6PR13CA0039.outlook.office365.com
 (2603:10b6:404:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Wed, 7 Apr 2021 13:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 13:31:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 08:31:13 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 7 Apr 2021 08:31:12 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add show_fdinfo() interface
Date: Wed, 7 Apr 2021 21:31:04 +0800
Message-ID: <20210407133105.39702-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8b9981-31c7-4536-75a6-08d8f9c96a73
X-MS-TrafficTypeDiagnostic: SA0PR12MB4464:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4464511F696BDF51A7687D77FF759@SA0PR12MB4464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYpHlJH4FOOZgMS4aMscvfniB8lLRBXNoRLdEQNs7UhSd2xcgR77T4wSrfjrn/2nzgA380wCvIEOwIFZscomlSP5Dshg70mV6MBCCXBkVDXiwLLyEr7KRBHzbSPYvnpC6aHa4j7CYbAc4ybvn4zgdWJOww4k79IMJG7hJ5ovdDIX1PoorUjtmZaZOyV0C1xLH07hMu9kuh45ZN/vuLgmPTopzgK4g7WDvlwwPhcT6L1Y+CUhY/xUXbotwfw/0n9T96ML35YkFZ3CEhjFTkpski9fMWANhyp2ioXpixPILGcWZrsbKGFQ8OuYfRCQWxPzm9vXGc+9p86EFhBFYQqtBtcC7/R12JF2+obUfGMa1yHEhdptmPFXiXXvU/bTlMhi/4osXQtdu9t7sl/5x6Exa16DzO40bXeuQuA60SNSD3kWPzYyjeA8MHIIkVz7amx35zIQzEy8xDvbuYFBVUCO5mhKrZcbofrDkJvMJmJgQaS5YMDKZMzmjeAV4tYDcaRkkJmp9EoX7DqMHFnGOHB4SM6Xrpm/IX3TrYqXiE38GFAr4nTlpznuBrwppPHe4ZIniJnrED6k5VXAJcvT3fHzfoqtpSAAqDy0DA9jwn82Qm3gH9GIZzfcJecfwCebvtgkHmb0319aFGhEvkKtiBGESHCDSyuzCkG59IaWNg+gI1AYJl4PDrSLxQCxUo0sFsbL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(4326008)(336012)(2616005)(47076005)(426003)(82740400003)(8936002)(8676002)(2906002)(36756003)(36860700001)(6916009)(70586007)(82310400003)(83380400001)(30864003)(81166007)(316002)(356005)(186003)(54906003)(5660300002)(478600001)(7696005)(70206006)(1076003)(6666004)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:31:14.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8b9981-31c7-4536-75a6-08d8f9c96a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 247 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  51 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   1 +
 6 files changed, 306 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee85e8aba636..d216b7ecb5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,6 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o
 
+amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
+
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
 # add asic specific block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616c85a01299..c2338a0dd1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_fdinfo.h"
 
 #define MAX_GPU_INSTANCE		16
 
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
index 000000000000..72e61a89c0ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,247 @@
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
+ *          Roy Sun
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
+uint64_t amdgpu_get_proc_mem(struct drm_file *file, struct amdgpu_fpriv *fpriv)
+{
+	int id;
+	struct drm_gem_object *gobj;
+	uint64_t total = 0;
+
+	spin_lock(&file->table_lock);
+	idr_for_each_entry(&file->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		unsigned int domain = amdgpu_mem_type_to_domain(
+			bo->tbo.mem.mem_type);
+
+		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
+			total += amdgpu_bo_size(bo);
+	}
+	spin_unlock(&file->table_lock);
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
+
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
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct amdgpu_fpriv *fpriv;
+	uint32_t bus, dev, fn, i;
+
+	if (amdgpu_file_to_fpriv(f, &fpriv))
+		return;
+	struct drm_file *file = f->private_data;
+	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+
+	bus = adev->pdev->bus->number;
+	dev = PCI_SLOT(adev->pdev->devfn);
+	fn = PCI_FUNC(adev->pdev->devfn);
+	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+			fpriv->vm.pasid);
+
+	seq_printf(m, "mem:\t%llu kB\n", amdgpu_get_proc_mem(file, fpriv)/1024UL);
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
+				seq_printf(m, "%s%d:\t%d.%d%%\n",
+						amdgpu_ip_name[i],
+						idx, perc/100, frac);
+			}
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
new file mode 100644
index 000000000000..4d73a820f7e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
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
+ * Authors: David Nieto
+ *          Roy Sun
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
+uint64_t amdgpu_get_proc_mem(struct drm_file *file, struct amdgpu_fpriv *fpriv);
+
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..b2e774aeab45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -41,6 +41,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_fdinfo.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
