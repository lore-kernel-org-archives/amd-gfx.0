Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BC8CD691F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2584B10E1D2;
	Tue, 10 Oct 2023 10:18:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C39B10E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhiAvGxDT4gG1xkyIUEiBj9O6Ed4+kVGAsr69Owa4RX2yZJRytvPj2tZvsZQlE6D7KZgRvO6lJN4lha5kA6KOgdnS7Dvw/1IFjKOiSMwOxyU7HojEUCT6UQHkFRSf6xKoD4nmvYp1VH4HNzsahzsnYw+CG75IH6Fbh7cpxsepet0rI1XWkT185Tlx8fQTIXvPFxn2ONaaLdPzIagXcguzYrr5IBMMjPPeFHSHCNKEYuEZvaELn+i7weeW27SbQ+46jOhcrLXiZTQiEYYnw1a0fdGKzAlck4Xjm21C2950adtxmoBfo6DLa003gQpnR7k+MAYBKYfxmYas0y9enrDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYlJJp8ZxflZ0Xl43Jat136S4ZYFLDHoYBMKFexaiv0=;
 b=fruutrRl768UVA9k+wAGD3krNuclaTq7kQqpGS7/1S7XKeux5Szj6dUIsSbPV7zFQGgPJoFRgZd5xA3EyTVwtJotHoeq8xiE08zkqr7iSUmFA955OUFwomueRZFyNlO6CxFJoSNoLBnL1x+IrgyF9Jugj2/lLJFzeyVsd/gO+TzHwDYLEA+DTJtpUb1hM9wDWOcmOXqrkI4uya0T9Rr8iT7+JxKgUj2nQfxi9EiHAMDA8LeSpLEUZS3vG0K+lS2NZpwaNrFaVCmzCrNa7fTa+KVKQ6arLnx9Ru81HePrG6vKCcR8GIdExNQrVoaa23VyeUVeNa5tCW8aZGdKsIywEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYlJJp8ZxflZ0Xl43Jat136S4ZYFLDHoYBMKFexaiv0=;
 b=qUPdcsZJ0dPwl123ufrTtq7jQZ0LsvaQWVWV5edKOXKOqmehq/+sbjFiGUKKepKRae8rXgF9A8GGqjw2oU07OX3tQH3vKp1W0Ygl3hNLDMSG5P4AIjIluwBEH7iDOKzGb7KzJx5rwt3RPscnaLXAPJPucwRlroeYcSzNV79GUhY=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 10:18:36 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::5a) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 02/12] drm/amdgpu: add usermode queue base code
Date: Tue, 10 Oct 2023 12:17:42 +0200
Message-ID: <20231010101752.1843-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7433a3-472d-4900-1b4e-08dbc97a43a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xQNFOHAM3aYmFDPhCme+U0khHSAc5XZRHhIg3cqyT98iP34yyI6LW9BEZKbWecr10u1uQIFC3ugXetAB1laLthvGe1uKNON1Fp0xLoxMXxUXDeEs6BpZ+Y58QVnCBdMyTjgiQ0hNMwnyulZEsW6gdmtpS8BoWdLkOTRUPlvv5QTrfT5UGomWYGIE0EvKtnIqArdkiRPIHeLdMggd848mXYNyPUDOCPPlaJTfYJtnrAOAZ2WvM8Ik9mgfSor0h59/xO5lMQueOMS4/y5j/+HrG/IcQa/cdvlpaxN5rc+vgjJS4M1J4LJ4mDvbNxZEPDd7BVGKtXivpMRhZfqmWetGFHUu0PjmQ03ZJxVyqFt2kqhK4NTsVmlrPN4ZJYGC2mfIkJyiVFdy5IbsuvR3qigVTcqhqNbpxT/jol0UqkEIdUFt43ynY82qnZAXbAUCmFDld8OsDyjbOpAafB24DDzLdcHCRC9yaeBIQjJ9HD2cHMIxoo2rRSSsPNi6bZto/PRKRejBNwi+R57UKOUA1yN4scAd+fgnt0DKkdX6EhrPQYi5FgS8JEfnppU7Tt8YxurzvePc/emY5oL70H3z+Trz5cgpOsarzPkvWsdWvhlUi2UY9obGXBwEU4IWq/mJ7TB3M8jZGEBud8VsQaxEr7Hzn/k9icFcHWlU0boawOBVbjCcUVZjoD/VVSPC4DB2rjOpjtXRL4XdcoYiIyHOJysLJyEPqSHDNI0cwOC1v0WP0eCUVYe35LjCkgEP6DEwp3L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(478600001)(26005)(1076003)(16526019)(40480700001)(70586007)(70206006)(316002)(7696005)(54906003)(6916009)(5660300002)(8936002)(83380400001)(426003)(336012)(4326008)(8676002)(6666004)(36756003)(66574015)(44832011)(41300700001)(356005)(86362001)(47076005)(36860700001)(2906002)(40460700003)(66899024)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:36.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7433a3-472d-4900-1b4e-08dbc97a43a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds skeleton code for amdgpu usermode queue.
It contains:
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

V5:
- Do not add amdgpu.h in amdgpu_userqueue.h (Christian).
- Move struct amdgpu_userq_mgr into amdgpu_userqueue.h (Christian).

V6: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 61 +++++++++++++++++++
 6 files changed, 113 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 384b798a9bad..a17bbaedfe82 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -240,6 +240,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc2d53081e80..8c12403e51b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_userqueue.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -469,6 +470,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -969,6 +971,7 @@ struct amdgpu_device {
 	bool                            enable_mes_kiq;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81edf66dbea8..e809859de388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -50,6 +50,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_userqueue.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 99f4df133ed3..809883de7664 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -44,6 +44,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 #include "amd_pcie.h"
+#include "amdgpu_userqueue.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1266,6 +1267,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1333,6 +1338,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
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
index 000000000000..93ebe4b61682
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -0,0 +1,61 @@
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
+#define AMDGPU_MAX_USERQ_COUNT 512
+
+struct amdgpu_mqd_prop;
+
+struct amdgpu_usermode_queue {
+	int			queue_type;
+	uint64_t		doorbell_handle;
+	uint64_t		doorbell_index;
+	uint64_t		flags;
+	struct amdgpu_mqd_prop	*userq_prop;
+	struct amdgpu_userq_mgr *userq_mgr;
+	struct amdgpu_vm	*vm;
+};
+
+struct amdgpu_userq_funcs {
+	int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
+			  struct drm_amdgpu_userq_in *args,
+			  struct amdgpu_usermode_queue *queue);
+	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_usermode_queue *uq);
+};
+
+/* Usermode queues for gfx */
+struct amdgpu_userq_mgr {
+	struct idr			userq_idr;
+	struct mutex			userq_mutex;
+	struct amdgpu_device		*adev;
+};
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
+
+#endif
-- 
2.42.0

