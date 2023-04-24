Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8664C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5219610E5BC;
	Mon, 24 Apr 2023 17:39:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0520810E59D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC5j/n0o4nFRCY5+FRuCemnW2iM9ancSTpzozNTmUyYqi+YDwYGZJVu/TQRL9CNGnmx/99R9SHb+e37hJfvNFY75bW6YLzc15YZe0Kfaxb8/3q5qil1eINAsJdGMBGI2LigL9M9Z8uvVbzrGxYY70XFGljOVxjc/nLnwUkWFp44d4ai2pwboeuUI58Ss5P6tO5OeEv7WF5szYvd2s94h34QQ7a78g48Doci7PjxgMloPlAX7/gurSEsqwKM2jSSwvOxW7H37QT1PCsCM4aVTuUF2T39Ph6GXd7llqCi71z6Zj0zCMeOH3JOfX3EPV+rpkHqlZGZVeEfUKwmb3nu2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVJjYDh+2wNn5FFr2CdcOfmnTKTFaRyTQ+FkPoUk8Qo=;
 b=nSfQ3/2gaAU4ZP8zXWXwWni0Stg5rp971aCFGE3eEwu7/rhOiaQX5+fhgDqdC1SFWMc5/GYIMMyp4VrxnqOXtgPdzJxkEwxIA6Yg+j1dUPSvVfYZLv5+JtESkjDeqkxEZMDy1LWphiymTuQEFuY33sBD+jhuh59vqXYMcfy+K0L3NOd2egZJ4zfZY+Lv3PYj/iGC7n93cBjA+M5Iq/mHU1tUpoEQ0BQzlytP+rMSPxyiO0rtht1UtiMRXba8OJghw1ViJIqFK2RWuLh3pDgnpTAaN2Bn+7XHqiVv/ZyLIP2dJf64AmA2UUYSIPOJ9kmXqMFskXgTBE/6bmtmlRbgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVJjYDh+2wNn5FFr2CdcOfmnTKTFaRyTQ+FkPoUk8Qo=;
 b=xJnyGhaTF3p0A9nhiXENd1dDl+REQzNFHLrZunBDLhzqmijjLoTnrEgouHatm36uDaWybVlgAs+JsMNrIGQyiITVL5s1YD9kx87iyNk5Eq1OwRZyvi8xaJgnAZq1PGwT1h5Iv+2FbrPYdvYWdZtLWbc5o+jyjfFlwqJdW0FtK1s=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:07 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::45) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:07 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:05 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 02/10] drm/amdgpu: add usermode queue base code
Date: Mon, 24 Apr 2023 19:38:27 +0200
Message-ID: <20230424173836.1441-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b6c3c7-e922-4ff5-693a-08db44eace36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb9dgixLjnfc2nMILZ19p5zIxc55ECmpk3Stj4rJ5iCoqbykC1U6m6942y00FtICIrDZ+TFGG2HJHDsilGA73fbr73bOD8iIn2y2EOys5U4Vai4MtEaNsETvLd5PDDD6LAF5Q8tZwTw78VQqolqlTetYe6UH1bjz3zokLti+owhhu34y/+vNMn7yYZJ+QpclGaEVXYoG0it7uyFI4wDea9j3X9WsqQqf4EnPoe6zDUTz9nxn064yj55VN/ePcP78smXts+784SjY2HotNbG3JNx1cnyTp93Q+tIK7Ifrr3WNC8LIkmuHScvuDR6uEWv3/mH0tZx1a8fucU7ypEjiIFVBoHDvsLjW5mByrfru736SU9Ov+szS2j/S1+Px+3Ewm0yNTXZcOFStwgC/VixSG6fSGZaP0RQUHi0S975bIA36sVK/T9a0NbJfDyGQ63HnFNHcIQcO983+BrjM7BfyTotzL6B7poPWGQMMsR3S66VUK1YA6On9JxP8WnkF04q3FkX2VpEMPE3PGSTeDzliehXax+dR0WxQWFut+IEwe1uQqoAJ0n82ScsmpQqfNGqKH78vtjcBnqCc1T3jBCBIKWP63pWmMTcbnhIQgJH7SXaIAO/pFUvtq+5ZpgiUdf8YrlIyxshnucs76EcuepnoVAWphNRWNnNxqeI+iaFI9cmdqu5ww3cpAH5oa5YBO51K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(16526019)(66899021)(54906003)(86362001)(36756003)(186003)(26005)(82310400005)(1076003)(40480700001)(6666004)(4326008)(6916009)(316002)(82740400003)(44832011)(83380400001)(70206006)(70586007)(36860700001)(2906002)(336012)(356005)(426003)(41300700001)(81166007)(8676002)(7696005)(5660300002)(8936002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:07.4359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b6c3c7-e922-4ff5-693a-08db44eace36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
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
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
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

V4:
- Align the structure member names to the largest member's column
  (Luben)
- Added SPDX license (Luben)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 +++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 50 +++++++++++++++++++
 6 files changed, 108 insertions(+), 1 deletion(-)
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
index 7aa7e52ca784..e1b6e658d51d 100644
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
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
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
index 000000000000..effc0c7c02cf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+	mutex_init(&userq_mgr->userq_mutex);
+	idr_init_base(&userq_mgr->userq_idr, 1);
+	userq_mgr->adev = adev;
+
+	return 0;
+}
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
+{
+	idr_destroy(&userq_mgr->userq_idr);
+	mutex_destroy(&userq_mgr->userq_mutex);
+}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
new file mode 100644
index 000000000000..6fe5d8d73f37
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+	int			queue_id;
+	int			queue_type;
+	uint64_t		doorbell_handle;
+	uint64_t		flags;
+	struct amdgpu_mqd_prop	userq_prop;
+	struct amdgpu_userq_mgr *userq_mgr;
+	struct amdgpu_vm	*vm;
+};
+
+struct amdgpu_userq_funcs {
+	int  (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
+	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
+};
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
+
+#endif
-- 
2.40.0

