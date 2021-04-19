Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CCC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 06:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9BA61104
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 06:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9BA61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7BC6E1A5;
	Mon, 19 Apr 2021 06:26:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766976E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 06:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr1nuQE9P++RYJfPgE3NCUJu8+EBm8FCxwoNdXlLkdMtzlV93c3G76zCb72ecK4zEigwvGvl0q3d+RMNcpzYT21Hjs7n5riJjImHNWtghWhJntb/6ivYTxyUcaVY+ih0UmwOs4Oaakj90eDZGlubp1k4WiMxC2FcJIiTxMvl4HRyDZIYNzbM/IeDRkarWPAIOERnLxL9eepBc1zWtDxDNU/oWrb4Aoi01rj+H2OcoCU9cyneVRMpvHqg+ZtEmcGSUpZcqSJBdNx6j6oCEVoO0S6cH/6Om+fzXAYjm4PTSs06Lr2VxiS3DYLm3ZBPR88KF47hsoYQKNTbCRjHNmilQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHc/lHwQcXxKo6qWgMu4PbXzGxhtBx4c7qklN2GRz4=;
 b=ero3TDfnPY5JS34AS/8u9mR8clIx68hKxrgU+DCKwUUNOMkbW/dD2oBnMWzV2vBD/7yn4alud63VHEH8kfYHsxDFfLPdiotbG1xtRge+i3J0bbNboM2sXwLKbYfGmJoBn2Wek8YX3nocLKOf9yKAJvfRxUMGG/kjdlKWYSwoB99+9Wuol+h6Yz4KQnLcoXm8bpkVlvJhFAbb3TET8mtbau7Bkhwc+UoqsO0vjUaREQdeO/i2VuvsiI9MxNildEsMXHNn0Yqxf88DhyUHMNgwtQQiPtzQEh9eEBkb32jRcBNtfrHHG/3T7PAyFMNrQSSugVpoy2Qk47z9x7J6xNk10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHc/lHwQcXxKo6qWgMu4PbXzGxhtBx4c7qklN2GRz4=;
 b=QwLS4yKKwVTrhaa9Gpls1rYqQF33bUvSCXM2OBatRqqgKQBw9qspAdjgSZEhascjWchgjErV8TMMqbJGCG4DUiYQbgO653OmPiRdwh25zGyEO0TkyU+VOlmwtbgiPTsfq8RdHYEnME+z6duXvQUgeY6WmxXdiaJUVaiHIex8yW8=
Received: from MW4PR04CA0313.namprd04.prod.outlook.com (2603:10b6:303:82::18)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 06:26:35 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a6) by MW4PR04CA0313.outlook.office365.com
 (2603:10b6:303:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 06:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 06:26:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 01:26:34 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Apr 2021 01:26:33 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Date: Mon, 19 Apr 2021 14:26:24 +0800
Message-ID: <20210419062624.27688-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419062624.27688-1-Roy.Sun@amd.com>
References: <20210419062624.27688-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0928243-a273-4afb-ab22-08d902fc14d2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4209:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42091FB2F45C36A1A28B3718FF499@BY5PR12MB4209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viq+tObMfZ7HGrWJZk/GogL+vVO/qkLqgHIeacFq0f0of8iOUZzmIqs6I6ZbYFrQOMkDLQ4yQHv5EaHBeIBNa7ypFHDjghQi0tb6a+hn6YeJxUnkZ0X4VluT3EUfohB9fKl7O5n8pM8HIDKJMVrB5pvlS0DORCAc85TjFHdyGYEZt3Lv1ZraN0/YncOPw0ATwVGDdFXPfVjLavbJ1fOM/MIdrMZeW8cCa/E5G3wprmF786ViELCMJM8AgSZSAHJqcdueOMLsUUJLrh9HUCD3uqUPhiNd7Mo/rPfhVtelvqb8mSSa4vyXzc6/PGMBjBXx+ji5pbTtxgxDox0V/jsiA76vz0Nu4cYIM53GM7bPnu5AC1zwbMMj04+O5JBtdyM3DF/ffX3H8MOi9MrPQv7ah7R8WuNdW/3FH/+pI2HIPOu3RJfMaoXzLdOjV6n4OVErYojmrvqDhC8nEM885kbDMdqm2JCmBAXWTu+DYAxOkRdJu8+nUHsn0uTlROw2qI2NxswuDYaP0PDzcQG5bLBI8zJr39PIUe5VdEGtSXeJ2b2xlXEYmo5uHX5eRnMzFsmQi8mGnEYLNMQPv3EwK3wtSORiOPiW0Gd5JvSCTeqzwaHCelxd1cph4AUuEYbaVavaE17k0DKEz7jQH+HM+AJAg4K84wteo5GFqvfAmlyAxTrk5PoPP19Zmvn4W+kFfYtm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(316002)(36860700001)(86362001)(82310400003)(6916009)(478600001)(6666004)(336012)(426003)(47076005)(36756003)(356005)(70586007)(81166007)(70206006)(82740400003)(2906002)(26005)(1076003)(7696005)(2616005)(186003)(5660300002)(54906003)(83380400001)(8936002)(30864003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 06:26:35.2351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0928243-a273-4afb-ab22-08d902fc14d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 95 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +
 10 files changed, 239 insertions(+), 2 deletions(-)
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
index 125b25a5ce5b..3365feae15e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_fdinfo.h"
 
 #define MAX_GPU_INSTANCE		16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205c4897..01fe60fedcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
+
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
+		ktime_t *total, ktime_t *max)
+{
+	ktime_t now, t1;
+	uint32_t i;
+
+	now = ktime_get();
+	for (i = 0; i < amdgpu_sched_jobs; i++) {
+		struct dma_fence *fence;
+		struct drm_sched_fence *s_fence;
+
+		spin_lock(&ctx->ring_lock);
+		fence = dma_fence_get(centity->fences[i]);
+		spin_unlock(&ctx->ring_lock);
+		if (!fence)
+			continue;
+		s_fence = to_drm_sched_fence(fence);
+		if (!dma_fence_is_signaled(&s_fence->scheduled))
+			continue;
+		t1 = s_fence->scheduled.timestamp;
+		if (t1 >= now)
+			continue;
+		if (dma_fence_is_signaled(&s_fence->finished) &&
+			s_fence->finished.timestamp < now)
+			*total += ktime_sub(s_fence->finished.timestamp, t1);
+		else
+			*total += ktime_sub(now, t1);
+		t1 = ktime_sub(now, t1);
+		dma_fence_put(fence);
+		*max = max(t1, *max);
+	}
+}
+
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed)
+{
+	struct idr *idp;
+	struct amdgpu_ctx *ctx;
+	uint32_t id;
+	struct amdgpu_ctx_entity *centity;
+	ktime_t total = 0, max = 0;
+
+	if (idx >= AMDGPU_MAX_ENTITY_NUM)
+		return 0;
+	idp = &mgr->ctx_handles;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(idp, ctx, id) {
+		if (!ctx->entities[hwip][idx])
+			continue;
+
+		centity = ctx->entities[hwip][idx];
+		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+	}
+
+	mutex_unlock(&mgr->lock);
+	if (elapsed)
+		*elapsed = max;
+
+	return total;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index f54e10314661..10dcf59a5c6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
+		ktime_t *total, ktime_t *max);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0369d3532bf0..01603378dbc9 100644
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
@@ -1692,6 +1692,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
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
index 000000000000..781a06101c22
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,95 @@
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
+#include "amdgpu_ctx.h"
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
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct amdgpu_fpriv *fpriv;
+	uint32_t bus, dev, fn, i;
+	uint64_t vram_mem = 0, gtt_mem = 0;
+	struct drm_file *file = f->private_data;
+	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+
+	if (amdgpu_file_to_fpriv(f, &fpriv))
+		return;
+	bus = adev->pdev->bus->number;
+	dev = PCI_SLOT(adev->pdev->devfn);
+	fn = PCI_FUNC(adev->pdev->devfn);
+
+	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem);
+	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+			fpriv->vm.pasid);
+	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
+	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		uint32_t count = amdgpu_ctx_num_entities[i];
+		int idx = 0;
+		uint64_t total = 0, min = 0;
+		uint32_t perc, frac;
+
+		for (idx = 0; idx < count; idx++) {
+			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
+				i, idx, &min);
+			if ((total == 0) || (min == 0))
+				continue;
+
+			perc = div64_u64(10000 * total, min);
+			frac = perc % 100;
+
+			seq_printf(m, "%s%d:\t%d.%d%%\n",
+					amdgpu_ip_name[i],
+					idx, perc/100, frac);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
new file mode 100644
index 000000000000..41a4c7056729
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -0,0 +1,43 @@
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
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..773acb4437f7 100644
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
@@ -322,6 +323,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->vm = vm;
 	base->bo = bo;
 	base->next = NULL;
+	INIT_LIST_HEAD(&base->bo_head);
 	INIT_LIST_HEAD(&base->vm_status);
 
 	if (!bo)
@@ -329,6 +331,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
+	list_add(&base->bo_head, &vm->bo_list);
 	if (bo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
 		return;
 
@@ -2541,6 +2544,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 
 	spin_lock(&vm->invalidated_lock);
 	list_del(&bo_va->base.vm_status);
+	list_del(&bo_va->base.bo_head);
 	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
@@ -2800,6 +2804,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->bo_list);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -3267,6 +3272,25 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
 }
 
+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
+				uint64_t *gtt_mem)
+{
+	struct amdgpu_vm_bo_base *base = &vm->root.base;
+
+	list_for_each_entry(base, &vm->bo_list, bo_head){
+		struct amdgpu_bo *bo = amdgpu_bo_ref(base->bo);
+		if (!bo)
+			continue;
+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type) ==
+				AMDGPU_GEM_DOMAIN_VRAM)
+				*vram_mem += amdgpu_bo_size(bo);
+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type) ==
+				AMDGPU_GEM_DOMAIN_GTT)
+				*gtt_mem += amdgpu_bo_size(bo);
+		amdgpu_bo_unref(&bo);
+	}
+
+}
 /**
  * amdgpu_vm_set_task_info - Sets VMs task info.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 848e175e99ff..72727117c479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -150,6 +150,7 @@ struct amdgpu_vm_bo_base {
 	/* protected by spinlock */
 	struct list_head		vm_status;
 
+	struct list_head		bo_head;
 	/* protected by the BO being reserved */
 	bool				moved;
 };
@@ -274,6 +275,7 @@ struct amdgpu_vm {
 	struct list_head	invalidated;
 	spinlock_t		invalidated_lock;
 
+	struct list_head	bo_list;
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
 
@@ -458,6 +460,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
+				uint64_t *gtt_mem);
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
