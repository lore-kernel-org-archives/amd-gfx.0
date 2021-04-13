Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35875C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB7C61026
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB7C61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A416889D60;
	Tue, 13 Apr 2021 12:14:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC9889D60
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR4DVqyHZSMfb9IiC3v9Uy8vt1hTGbq5mEf8ts7WMIUqXsVsBWTeskdehljAQ4d7vVshy9l06BZ7ha/0p86Z+6TVIVqSbN5iFnqBTmpw37SYT7aH4RLUhXs0l8oq0PGmDVkBnxsOGIyxKS9kTk9Jy3OWPL8NGmz/0+AmFNraP2sspjytZWsCjBmn1ELFKAjZGYfuyYAkVhlTeb8D8HJrrWcbRJIi5xw4xH9vuj9fYUcCdV2vRWxE18C0p3jxRWCmBDLkP3gW9HHwv8aIXOzy33F5tBFuVFHhgnbSOXerVZVE1K1zvgJ+qTkbrgiWSEkszoz8xc+ZcKxEpddfHqlO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMclzSl0OzefHtQfLLvQTOPbmj6zKQu2GJCGf7lW4Z8=;
 b=hquBf9cih9FJaTLzjoNQUt0btPywQ7Ngg+dwaDV4k03PuiCj4W5WJfoAXRyUczbcwlvDEcZXYhZAt53jT6rSX5TuXUDiJwKhd5aVJqp0wwwubdUfECs/UUcdcuJ8jaX7SM08YX1cTbfyWF6XWwpWQyOBFwVxEUtCKXGWOOO5q9f1xIdeTO9+IfLwVRiJG6QHtEQvWqRWpXruXQVzl7FAsx6nWvFinAVRh9FgGHxKE3rCqeT0Q4RZPBJ7DaxYoOwd9608aJDRig+ho+vpYn24OGtlzi85fcNDkwCmJJKQdK3HONwsEZbjz6gmwQ9YJZzAS2mcrv3QsK6HDg7YApgwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMclzSl0OzefHtQfLLvQTOPbmj6zKQu2GJCGf7lW4Z8=;
 b=LahbNhQwbl2XyshtEaEImFDcn3+FB2vRZZTqsSCHSXp+TOtE3+oEyCNeefshbYiTM0ltWN7OytZdxzf9ayH9JDEAJVQXObAkP3xyjrpSywsWqIJo0XsYaIDsN39nYx9yLTEqWDW3LJEK/bhL5xInZChxZCB8UfYXBL1dOd1sV/A=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 DM5PR12MB1915.namprd12.prod.outlook.com (2603:10b6:3:10c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Tue, 13 Apr 2021 12:14:34 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::70) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Tue, 13 Apr 2021 12:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 12:14:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 07:14:33 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Tue, 13 Apr 2021 07:14:32 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Date: Tue, 13 Apr 2021 20:14:44 +0800
Message-ID: <20210413121444.36903-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413121444.36903-1-Roy.Sun@amd.com>
References: <20210413121444.36903-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dd0eb7d-7b2a-4055-10b1-08d8fe75b30c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1915:
X-Microsoft-Antispam-PRVS: <DM5PR12MB191575602BB38AB0FE4C9522FF4F9@DM5PR12MB1915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNyOHoMc2ferMUM0WAqYQ2zv1Oa3BQ6H7+iaJUfZxiFjS0vPWvwM5u5+0h1KjKBavNcyXu3XM77UCBZVZc5j3I3d9zlVY7CqRWxFLw37PMAKsVXxf1wBcyGLIHzWT4Rg5bl3edJVcDCKykJPHdn4P1feV+XmTR9ucppnLzGU8HVX2PCj/2QMvzHhgNf5ESk/DdHm8c7Rhw0aDxHK+g/A0WzUVe4dMs+J4qrWWL3ZkEX3KesxNCCLwJyD+kpkiNqufHF4QldJ3pvFXhnirSRaN7ru5zrJquzca5aIziQyIQki3+NBZ9Kztty3FscROHxk9kUwmc26PUUseeJB2T1sXGuYL4+84SoS+rtmGSOW2D7KC1SG+PVPTxlZtl0JjYk7I71SsUxr+hpIG8pF3aJJXcQxBnHcZGV1p5/ssXbFxBhm/rLkpFA0mhvxKikzuTINcdb9/PVH+wjGSeupnxwLDCf/UrJcg7piTKytW81lQfNIiamVnsnGZ73h6IzJvVJ41eCqjX0GtiWXbXHXn5m25cviLqkKUqVy/UL8qWi+Ze/1lEqtHMWeHp6yWsikM53QU2H257enXJVdAeNzPDsBsbYzS9xZRHLEVpbkZyJoFiJt0DUoUsYVJeUftj7Tss/RwNKrnZ82BePxUTdGpJ4p0VGPt0RM+TXQIvp6w0+FIIB6LWxIYlIqPR6E4Y1pyHKt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(2616005)(70586007)(6916009)(426003)(478600001)(82740400003)(70206006)(8676002)(54906003)(81166007)(82310400003)(36860700001)(316002)(7696005)(8936002)(356005)(1076003)(36756003)(47076005)(4326008)(83380400001)(336012)(86362001)(26005)(2906002)(6666004)(186003)(5660300002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:14:34.0466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd0eb7d-7b2a-4055-10b1-08d8fe75b30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  59 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 149 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  43 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  21 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  35 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   2 +
 12 files changed, 321 insertions(+), 3 deletions(-)
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205c4897..8d33571754d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -651,3 +651,62 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
+
+ktime_t amdgpu_ctx_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed)
+{
+	struct amdgpu_ctx_entity *centity;
+	struct idr *idp;
+	struct amdgpu_ctx *ctx;
+	uint32_t id, i;
+	ktime_t now, t1;
+	ktime_t total = 0, max = 0;
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
+		now = ktime_get();
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
+			t1 = s_fence->scheduled.timestamp;
+			if (t1 >= now)
+				continue;
+			if (dma_fence_is_signaled(&s_fence->finished) &&
+						s_fence->finished.timestamp < now)
+				total += ktime_sub(s_fence->finished.timestamp, t1);
+			else
+				total += ktime_sub(now, t1);
+			t1 = ktime_sub(now, t1);
+			dma_fence_put(fence);
+			if (t1 > max)
+				max = t1;
+		}
+
+	}
+
+	mutex_unlock(&fpriv->ctx_mgr.lock);
+
+	if (elapsed)
+		*elapsed = max;
+
+	return total;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index f54e10314661..8ee42f12e5f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -87,5 +87,6 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-
+ktime_t amdgpu_ctx_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
 #endif
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
index 000000000000..6243b79a335f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,149 @@
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
+				total = amdgpu_ctx_fence_usage(fpriv,
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
