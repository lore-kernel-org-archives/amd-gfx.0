Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAC761288
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAC761288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22916E591;
	Mon, 12 Apr 2021 12:57:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443E589FF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 12:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG7qTMm2U/zNLA/ENyE5VyNyaGu8AeLIsUdW6QcHUthyGzi2E/ITLtnnVRDxP4EdqDd2Ix5KE/5ayCBkZbByHOsNdl7shMku4weU5gGJaG1V2JcmyBVMiUo0hHlNaUw1XWZck5J+rxQjoASR/GwP6jHCD8bTkLMZ9kfdB6tI3fuOGvQ76UTg6U/g1C9i/2wWL2i/dxj5YE0iaVWIiKjA6P/IX6+Q6hgiJviqnSDyQ8lFYXJAdL/VyrSsYQ+DvyEuI1pCQ/bxlWELuIygpeDgM7QBrjrWTbKuK5AjgxAYV3eTF97sQJ61LOsP5SqpfO4ISggf7+mYKETbKhkvGT9YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aptqj/nldWZ+U4uoi6wY3qifJ3WQuMDjDiqDxOqp2eI=;
 b=SImuXGztMsIWfgfvF4z1F4RMr8KJec+qphyi0yqUZ1kU0lmmZJvvH8F+pyubE3nVUwdLz6SP+Iqm6Oy4x3Y8+pnc6EWpzkV4gyKxtpegMDFVPhHdyN1IbHyj44TYf7/AUBwH9CY8XVAss99D0XrerKCR1mTbImk0gfZoh599RLXxYNRHMV/wNktVdeYHgMFqFMvTdMQdnfI/2LR56e0VGrw5CFDMVJzNzZSi5hdyUJs5f9rS29eZcUTc7AZxeYCb3zumMs7rsms3uwFydYZESd2S6Kl2t19LfdmSnkqOMce5WSE5ygMWt4RWjobwOz2YavR/MFUDXRtrNj7p0kLDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aptqj/nldWZ+U4uoi6wY3qifJ3WQuMDjDiqDxOqp2eI=;
 b=1SmR06MnEbWt2NDqOKk9pRNhDqvqgo+K489DuN8AACc8CzsOWKDqg0lTWCsddWQks9ZdS73EzxX/eUlVpt6zQBrmJnrdWCIysAkKgwxkJpKHmVTZ/UGS1q9dtDHLkmP3riU8a+gEgr0Yu38wz/66aiGkc03VZa64117YU9p98Wk=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Mon, 12 Apr 2021 12:57:53 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::33) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 12:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 12:57:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 07:57:52 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Mon, 12 Apr 2021 07:57:51 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Date: Mon, 12 Apr 2021 20:57:51 +0800
Message-ID: <20210412125751.25812-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412125751.25812-1-Roy.Sun@amd.com>
References: <20210412125751.25812-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a86b229-4778-46ea-c5bc-08d8fdb295a3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1545:
X-Microsoft-Antispam-PRVS: <DM5PR12MB154556C5279391A1B758B195FF709@DM5PR12MB1545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vV/iECEGboToTStyhMjqrxlYD72UR9X3NZJyv86gFbSsDxK1PiN5gr9M7lrtL8eUa25DQnCWCqeauELTsaAXRGsEdPs9hkCcMvL25uB6ulbmGJWp+sh9YtYOP6UeozYdxfrY6VX+kAQ0ngv7S3MWp1dMfWPvd2Q8rsw2zWzJSDmV+i0e78CrDfNmfdZ+/5iBhXD26SQgC8ZpiFGZfAv4ft3um0RtE4mgr+Y7hOjB2K4Ty8MsAeFybNhXaWevCanl3XgMnAyJyfgAyDXBh0/6u2UoZ50u+wzc92qXmCLgonxCgESenB2vn2OHOLWXDdE7M3lmix/bTjy9jHBqQY9bgcOhZ7+SrRECtcZHeIfDXhMcxyDDuAiHF/yeH2G7Zo8hmx53TUkyiKYsI9riuZyhFGjyvrTM4DHpDOlR5kskNRpLHzGQYVqnKXxozSai191MaXDysKswKtjP/WjxXWvzaye5jwc826gQWon/8GBwPZzl3kkIMdES6JTJSbhvjSo281e1PYYx27WBsj/qdlPBJgFG+++yuzBH0WfKe4t1MyWNDtSZ0Yg6og7Yw4jCM/7xbcoiOsYiM89c5RbQ0AzNdDWOrrYwH6NEygNibj21pgSXgsyvZBjPq5phdjq7cAsTexQd5k3fB4cY07SvQtg73Uqdch890+/5LfIxI/iEO7Uq6EuDhKmy/l3dH7k8lFPr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(83380400001)(6916009)(426003)(2616005)(2906002)(30864003)(7696005)(26005)(5660300002)(1076003)(356005)(86362001)(4326008)(82310400003)(186003)(336012)(8676002)(54906003)(36860700001)(316002)(36756003)(70586007)(82740400003)(81166007)(478600001)(8936002)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 12:57:52.9029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a86b229-4778-46ea-c5bc-08d8fdb295a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: Roy Sun <Roy.Sun@amd.com>, David M Nieto <David.Nieto@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 207 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  50 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  21 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  35 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   2 +
 10 files changed, 325 insertions(+), 2 deletions(-)
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
index 000000000000..b6523fb141c2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: MIT
+/* Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "amdgpu_vm.h"
+#include "amdgpu_gem.h"
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
 There are 2 lock in this function.Could you give me some suggestion to improve it?
 Thank you a lot!
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
+			t1 = ktime_sub(now, t1);
+			t2 = (t2 == 0) ? 0 : ktime_sub(now, t2);
+
+			total += ktime_sub(t1, t2);
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
+			return 1;
+	return 0;
+}
+
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct amdgpu_fpriv *fpriv;
+	uint32_t bus, dev, fn, i;
+	uint64_t vram_mem, gtt_mem;
+	struct drm_file *file = f->private_data;
+	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+
+	if (amdgpu_file_to_fpriv(f, &fpriv))
+		return;
+	bus = adev->pdev->bus->number;
+	dev = PCI_SLOT(adev->pdev->devfn);
+	fn = PCI_FUNC(adev->pdev->devfn);
+
+	vram_mem = amdgpu_vm_memory(fpriv, AMDGPU_GEM_DOMAIN_VRAM) +
+		amdgpu_gem_memory(file, AMDGPU_GEM_DOMAIN_VRAM, fpriv);
+	gtt_mem = amdgpu_vm_memory(fpriv, AMDGPU_GEM_DOMAIN_GTT) +
+		amdgpu_gem_memory(file, AMDGPU_GEM_DOMAIN_GTT, fpriv);
+	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+			fpriv->vm.pasid);
+	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
+	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		uint32_t enabled = amdgpu_get_ip_count(adev, i);
+		uint32_t count = amdgpu_ctx_num_entities[i];
+		int idx = 0;
+		uint64_t total = 0, min = 0;
+		uint32_t perc, frac;
+
+		if (enabled) {
+
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
index 000000000000..06bb15c1c0b7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: MIT
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
+
+struct amdgpu_proc;
+struct amdgpu_ctx;
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
+
+uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
+
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 311bcdc59eda..6711c7653c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -740,6 +740,27 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+uint64_t amdgpu_gem_memory(struct drm_file *file, unsigned int domain,
+			struct amdgpu_fpriv *fpriv)
+{
+	int id;
+	struct drm_gem_object *gobj;
+	uint64_t total = 0;
+
+	spin_lock(&file->table_lock);
+	idr_for_each_entry(&file->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		unsigned int m_domain = amdgpu_mem_type_to_domain(
+			bo->tbo.mem.mem_type);
+
+		if (m_domain == domain)
+			total += amdgpu_bo_size(bo);
+	}
+	spin_unlock(&file->table_lock);
+
+	return total;
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 637bf51dbf06..017f034370fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -70,5 +70,6 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
-
+uint64_t amdgpu_gem_memory(struct drm_file *file, unsigned int domain,
+			struct amdgpu_fpriv *fpriv);
 #endif
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index daf926a63c51..073205f2fce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -25,6 +25,7 @@
  *          Alex Deucher
  *          Jerome Glisse
  */
+
 #include <linux/dma-fence-array.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/idr.h>
@@ -3286,6 +3287,40 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	get_task_comm(vm->task_info.process_name, current->group_leader);
 }
 
+uint64_t amdgpu_vm_memory(struct amdgpu_fpriv *fpriv,
+			unsigned int domain)
+{
+	uint64_t total = 0;
+
+	if (fpriv->vm.process_info) {
+		struct kgd_mem *mem;
+
+		mutex_lock(&fpriv->vm.process_info->lock);
+		list_for_each_entry(mem, &fpriv->vm.process_info->kfd_bo_list,
+			validate_list.head) {
+			struct amdgpu_bo *bo = mem->bo;
+			unsigned int m_domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
+
+			if (m_domain == domain)
+				total += amdgpu_bo_size(bo);
+			}
+
+		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
+			validate_list.head) {
+			struct amdgpu_bo *bo = mem->bo;
+			unsigned int m_domain = amdgpu_mem_type_to_domain(
+				bo->tbo.mem.mem_type);
+			if (m_domain == domain)
+				total += amdgpu_bo_size(bo);
+		}
+
+		mutex_unlock(&fpriv->vm.process_info->lock);
+	}
+
+	return total;
+}
+
 /**
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 976a12e5a8b9..88e4950dccfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -447,6 +447,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+uint64_t amdgpu_vm_memory(struct amdgpu_fpriv *fpriv, unsigned int domain);
+
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
