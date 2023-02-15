Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C740C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CA310EB28;
	Wed, 15 Feb 2023 18:44:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2323B10E0B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju8OVQ3p5CFjzrnqfBkkmxC5cb1l17zBsw9W3KpwlHr/Do341PE2pqPTEKJE5idTHU5jtmOzLAaCa9ifTcrFDl7h317pxy46NbkPC7ySJzLdahwfj544PVZvjazZgc42+xDj0XDEMaC1+j9DGmqkLJRfw+AKL901ulF8CGc+k4YlKLpb3whZeIQCSO0I/xlBlFmxpTu1eE0DXvyY6dGvRJcojwH4sFWDHnnkZkSabdq1O1yYnqdtetjo48CM/lWAiaodq8y/WRF/can61N30yfcc5WD6NY+vNwBr2ZRXiMI2gJ6Rwwc7UPVDq2uJBqGK9sLMJHJvYsLAqwFhtW9YxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bv5y34q2jZRA3MQ33kgjj6DsGguf2rrqLZ36nWBg/s=;
 b=FpZSN2dLIW484hBMiEmGf+poW9bTv9DxBzJY5/Qh0ia0yaY+W1doPLWMr+rigK0/3ODNZzGbnuCVYrfW+dH6pTMVXyHU3PrFHzE63H027bYYNcS8LBFbqXsZ+nB+jM1GT5MAeW91ZGPkdebnYDEpz9CHtoOsMXAXN/wGzpFckTgGqU7RkBY9d2dBq6QbYIfsdwdvwmYoUlYUgrxDmAcjpzlfxVJc4AHZEAuBlOn9H3ZhGeMaW4qwN0FFdvdre5V87gse7xy+kRd281DqUoG9+//fs9hWuQQQ/e7xkJC/tX3Nd3mGzv7m3V2oiA1tj73yB6KAGw2oV58i9N/X1n+gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bv5y34q2jZRA3MQ33kgjj6DsGguf2rrqLZ36nWBg/s=;
 b=TzWdTS6ZTpfwCcQpuHeS2NPk1vg6LP2mFm2Zq4yPkC3e+UcpPiFAo1ratftdXhCVjZZmYk1h+gt1+44kh7zcaoCxVIOUOz8B4wIaf7eB7DVSVAWMQ4Jn2Y2MPajWi7eTLWcQVlg15M4nmW0hSQF95FabOjYmIeiTOEgXLG0LieA=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 18:44:31 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::4c) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:31 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:29 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/9] drm/amdgpu: add usermode queue base code
Date: Wed, 15 Feb 2023 19:43:50 +0100
Message-ID: <20230215184356.2205-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fc2499-7cba-43c2-31c5-08db0f84acfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bu6Jnfd7qZ9rtd4iTggUmNdBrz23qgvJ39dOgkwvMM2Ss/r67Knt1yCQLrct23y6ds4k9AElg8hy9rmig2KOyaEquOZGoOkicdS4LHQunR29O3DyAIvsudgIS8EtcVFrVm03w6ybKIQ2mRsN5uYPfaGXImLBTgcV7E/E0tcvK2tWMH4IPFGs+kbIGlizNozrNHQKuYCXTKwNKiV39fXmCG2rEHrTmZiZuR3gOY1mN4AOb+/MEnfEo8fz/LBA5smHlcBx+54s9r0iJdRRtTnkVy40iZVYxZJDS+xVUAzUNB8QqERK4/E3CO+tpKgA3zcTkgIHwKOBDXtOMZiTDyEeeeCvoDFmRpUcF9bCo8JkLNmOD8fJPLWchPLPkEV5p4R2h2VhKvWeWibhJfyPPyvmt9VwJE8uq7iYfOT7wvfq8rfSGmjKmtNMEc4aQy1odEUwrabEHmsDRYAOolbUlHoNXd5jZTksvX9tN33F6bGy68h/dBaJW2wsQvk5mh23FuCcon+mLUG07xvLAZeUyXtiOjCrB60nJKQYmqHjW7szPV8ESI4+TysXA6+L1W9qih8Dqu6RozqW/LIH1dFR1G2yRe7roKXxUFO/wCYIPboH5errfowff7hW4P7jr5V4PKBn2SLsD8FemU576AL46XR4RTwUMbyLKRMSKhXGiRZk70BB+h4SpuVXE2AF72zqRP1O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(86362001)(41300700001)(356005)(44832011)(5660300002)(6916009)(8676002)(82740400003)(4326008)(2906002)(66899018)(70206006)(81166007)(82310400005)(70586007)(36860700001)(40480700001)(316002)(336012)(2616005)(83380400001)(426003)(478600001)(54906003)(6666004)(40460700003)(47076005)(7696005)(36756003)(1076003)(26005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:31.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fc2499-7cba-43c2-31c5-08db0f84acfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds skeleton code for amdgpu usermode queue. It contains:
- A new files with init functions of usermode queues.
- A queue context manager in driver private data.

V1: Worked on design review comments from RFC patch series:
(https://patchwork.freedesktop.org/series/112214/)
- Alex: Keep a list of queues, instead of single queue per process.
- Christian: Use the queue manager instead of global ptrs,
           Don't keep the queue structure in amdgpu_ctx

V2:
 - Reformatted code, split the big patch into two

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 49 +++++++++++++++++++
 6 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 798d0e9a60b7..764801cc8203 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -210,6 +210,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6b74df446694..c5f9af0e74ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
 	uint32_t		align;
 };
 
+/* Gfx usermode queues */
+struct amdgpu_userq_mgr {
+	struct idr userq_idr;
+	struct mutex userq_mutex;
+	struct amdgpu_device *adev;
+	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
+};
+
 /* sub-allocation buffer */
 struct amdgpu_sa_bo {
 	struct list_head		olist;
@@ -470,7 +478,6 @@ struct amdgpu_flip_work {
 	bool				async;
 };
 
-
 /*
  * file private structure
  */
@@ -482,6 +489,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b4f2d61ea0d5..2d6bcfd727c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,6 +52,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_userqueue.h"
 
 /*
  * KMS wrapper.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7aa7e52ca784..b16b8155a157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_userqueue.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
+	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
new file mode 100644
index 000000000000..13e1eebc1cb6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -0,0 +1,39 @@
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
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
+{
+    mutex_init(&userq_mgr->userq_mutex);
+    idr_init_base(&userq_mgr->userq_idr, 1);
+    userq_mgr->adev = adev;
+
+    return 0;
+}
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
+{
+    idr_destroy(&userq_mgr->userq_idr);
+    mutex_destroy(&userq_mgr->userq_mutex);
+}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
new file mode 100644
index 000000000000..7eeb8c9e6575
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -0,0 +1,49 @@
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
+#ifndef AMDGPU_USERQUEUE_H_
+#define AMDGPU_USERQUEUE_H_
+
+#include "amdgpu.h"
+#define AMDGPU_MAX_USERQ 512
+
+struct amdgpu_usermode_queue {
+	int queue_id;
+	int queue_type;
+	uint64_t flags;
+	uint64_t doorbell_handle;
+	struct amdgpu_vm *vm;
+	struct amdgpu_userq_mgr *userq_mgr;
+	struct amdgpu_mqd_prop userq_prop;
+};
+
+struct amdgpu_userq_funcs {
+	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+};
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
+
+#endif
-- 
2.34.1

