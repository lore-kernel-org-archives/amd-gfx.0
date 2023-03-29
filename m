Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2FDC77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA69810EB7F;
	Wed, 29 Mar 2023 16:05:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AE010EB7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU3Z6D+wA3iL01S0fucY3qj82z3YOmcIlMd+kC0TFfPPT8LZ/hCIdQ5PJoAA/gd7/1j3dZ7ZVWJeXDEoerEgthBBh6zmJoxfzrdSZCWShLeA9m5rpSAEYZSRliIY+OcXh6jvCp0Q9LYMWJpp6skHwKQbkkYPnhgOi9LvQ2+AgMugCRQt141KhK00Axl431dvC5q04iIF+mHVA0sye0R7ZTU2JfzdX1eiSckogSV5jdiUabjoaKfj9VJ4ePlOLnG4DQWLUCN+K4roxqX3UOGRZWO2eIRakac+HqSkHn3lGM5tWpTg3WJHrDi9imJrm+AstW1QijuFoI9DLWncdQU+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLdh7A+YTtGppWu+Gkx9fl3LwW2qbsb1BhvGeTDH7Uw=;
 b=hq5I8M0m99b/uK6DmTFhfb45bFeDO+LcV6LqkKabt/AdaDYXsE4jodO5N3aCZ35irGJCkOLT2SCMmMi8EhheCHiXRm4D/GWqKAuWV7KCeYWQpgV8OPvwJUyzlA6ucdKlbm+zITCqtLImglH1dMor1TBd4hlrXWMzz2+YN27fS+HF8qShzPF7nH9OxHvLg4QXw2YHxuhA1A/jIQPIDXctnJSOBPkT8KALG9Gwr8DIdwY0zgZE9MIkk7wfXCf3fuwGwpLRm7ybeKvkIBpVH9u/TsiNa8eeL4F9hsR1PyQ6Qwk16AJKNQmS4G0I4aFiQ/LLDIkBiyKZMuGTTW8FfjFuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLdh7A+YTtGppWu+Gkx9fl3LwW2qbsb1BhvGeTDH7Uw=;
 b=Y+GwOzxXKHAKdyJYSw5InwMWpRgzhkQZ1Gj1rRCg1z3P3J2up6y6LBGL+wbdJjgrqZcaDaHmVdwV7MtSF0THgYwBW7EJ+962NR+lGLhi/1SSDygf8fFxfYjGcZCY4wWZBE/4cUldPuJKks3kSo0t08pfecvI2O6S3pr9egGxd0Y=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 16:05:10 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::6c) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:10 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:08 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/9] drm/amdgpu: add usermode queue base code
Date: Wed, 29 Mar 2023 18:04:38 +0200
Message-ID: <20230329160445.1300-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|CH2PR12MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c007053-23c0-40e6-1074-08db306f5f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74s+Iwlyr+JTSFXIfdozmHTTUsms61ZROVAUZhOsQ1ntK0lQNYBdznLaZ6jO74Ts/QEzGXQTjz0/5JO9NWqNm2+0aoD1NnJkPs0KTwU1aL7qk0LN7mWuyWwPMKtqyF67PvL7YFyFKy/1i0LEQHiSHReaqV7fkd+pR6bjiDsFyYPRGn8jtF6MRNfTrNRR48GR/PwOvKY/zeuWgWLFTSFfyH2IjGa3l+a+4S3SGNIT3GdMhmkUa3ieif+6fGFOgfC8fgisWRawIDMyGEF9tb/Tu5JCJnn4mrFUlBjgTwmrfeCOSDQVs2U5lBUUAWWCVBp+Ld1+HP+rrqaupgaJKDKX5rQFnT0Vy32pUU+rzuNgLJr0CFZZqTGZBfxtjd644C8/+EYt5LaantxRg69qPSApaoKHpjeAb1l4GFCgsZ+rFlL+dMRTOEGFIocZaeZKmP4HTn33FVFNWPfl4qpExdRtT+b5CfD2fYYNvlH/S/ycJMeCkEXXQQ7Im3UOgpDoc9PysV/r9E+FGnDkQ6j14qVgszFfQyGDZrH/EozOhxEc2kmmIlbQLv+DY4vAygbNwd9vcpt6xuLvKNOIAYrr7ijYUsMRb9HW0xtuf4XcFRzOh8T3EhXmFA2xqgpiBHzy6pgYBiiiWJT7i8f4Esj78xT3vtk4xbZRnJN2N5TaSCUGPapkhiSBnJsGIx5zcPA5WO5k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(6666004)(26005)(1076003)(336012)(2616005)(47076005)(36860700001)(186003)(16526019)(426003)(44832011)(8936002)(40460700003)(2906002)(5660300002)(7696005)(316002)(478600001)(54906003)(36756003)(40480700001)(41300700001)(86362001)(70206006)(6916009)(4326008)(82310400005)(70586007)(8676002)(83380400001)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:10.1789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c007053-23c0-40e6-1074-08db306f5f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
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

V3:
- Integration with doorbell manager

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
index 204665f20319..2d90ba618e5d 100644
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
2.40.0

