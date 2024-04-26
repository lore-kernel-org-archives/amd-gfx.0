Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB5AC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A06112405;
	Fri, 26 Apr 2024 13:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WlAi2xFx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278A5112406
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI4y8VGCEnG4Sk+HeoRYONqxKHU8bDi0gwHk/xoxK9TvSLyEMrL/Hz8QVDgZVj0mgfdE97rORj7h39yLS7ZRIgAA3bH9PWQNV99Uy98KSXWN/2+3MDIV8OlLR039WuhiGXqgm2tE8FK8ExlRikNgmhY7aJAaW1UmzCPbqklIOaulqu080NJsN4XWDOCDTOaQTWro1mMNCWwJDp6pBcjhJCYSlFrm7xAozokvjNIHW83o//QdxGnCuA24icTelnzXCMmGQwPcFWGpaqIiDO22vRo/xS9pNgoTWMd70ptej0epKqPCH+7PkdR/RTknMAlzn4zGsYsEWCxVHWpnb/Wc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vAkEVpkBptvC2wzOdAL7Tjwqf41hD37zn8vKPR2MCU=;
 b=fQSa3TuQ+sljOKBkzFrRVzeIzZuqY3FOAZYMfePi766b+8WaWrMMZLagRhxCNM+z5UF3iPw/GHC1o7KTGRj0nN8yOFBUOj0nfLEMb6b28DipMnMf8gidiAesX9EODyJyycxhByEcdnffLiR6mR59WCNmtM4tX1Xu5q1lbogplQgbgQ4zA9fjrhRRtjCD1O0tvYP1/Xk5uHCjoa1xX/zrvtvNyBKSDYevniCjMlAG6B112tk7gTyLAOPcYDqajKTQCivMZ3nE6Z1VAaGtGMtOj1Vrxj3rxF69OOoTxaazOyT96iLc+qsL4tSuabEt+JD8zMnyxYNsMVJUu2IomvlU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vAkEVpkBptvC2wzOdAL7Tjwqf41hD37zn8vKPR2MCU=;
 b=WlAi2xFxabwSdwlG8G9n9WjYQAwnsACq0n/6/cSxi8WbYHjvh4E+ci+ntlx8KCefvFSoeQCB8fd0Zlz5bJ3MjREcuzOy9+JqHZFcRIuqFnWYnKQn6lCXBKZ/uCctRXnoUV6b8ht8aXxuC9CAW8q3fGVzd3Fghv0lKpP4mip5Y08=
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:41 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::af) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.27 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 02/14] drm/amdgpu: add usermode queue base code
Date: Fri, 26 Apr 2024 15:47:58 +0200
Message-ID: <20240426134810.1250-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4e0706-d2ac-4a00-d74b-08dc65f794c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWFzWUV4NDhkYVJ6RjNaRUE2YUVuNlU1VXhEdVdGQjRuVEUySXNjeWZlSFh1?=
 =?utf-8?B?S0hxSmczOXFNNmcrR1YwT2lOWUlRR2xob1dFN241L0FYOER2dzIzWHREQXJT?=
 =?utf-8?B?SW02Ty82djBmaFVWYTh5eG1kSnhvQ2JGMEVKMFg0UVU4L0F1UHh6THE0Z2ND?=
 =?utf-8?B?enIvMVd0ZzcyRFVhQzlRZ2NkSHB1OTAySERreDB4ZUpwNlg5VEFjdTNPV0RP?=
 =?utf-8?B?VG1PS3ZYWW95OWk4eXBZNzBPZktuWTdaSmFBYm5zWExCUnErT3QxdVludzMx?=
 =?utf-8?B?OXNaT1YzNjY2bk4vZUlsTllvMGpqWUM5amkxMmxVQ3FwbmFFRjdTenZMdURV?=
 =?utf-8?B?dlVOVElqblRqek9HdWg1cUhOZ21ZYlQ3Z3BORjZWN2EvbHc2eTFnTFdZOG1h?=
 =?utf-8?B?QTArYVZQNUsyNjJ5MFRXOEloaDJyZ0hrR1FMREY1MXlqU0JYUHIxLzVzZWJk?=
 =?utf-8?B?NmxWQnZFYzEyOFZETmJpanpremd5UHNCZ1pVTDhxbnB3Zi9GUS9zUUhkRDg4?=
 =?utf-8?B?VkJVVjhyZEJlcER1SHdBRFlmTmcxaWtKTnpyVWpQVDBOYW0wcHhaTzhEWjAy?=
 =?utf-8?B?Q3lobWlUYTlaMU1pbStSeGUzaXd3NTB0bmtiV093OCszelpzbUxFOWhTckNr?=
 =?utf-8?B?TE9wK21GREZnUWdJamc1TVdoV0RvVit6dHB6dkhGV0d5Z0RSazZFYjEwRGR5?=
 =?utf-8?B?Y1V2aldwalNPUC9Ia3hBQ3RzVnh6NnBtQnkwdnRhVi9VZFlsdFZVUURuMjd4?=
 =?utf-8?B?c3FHdzZYaHhJYXRBMjlqRHJqVDdPelVBZTFRcnJyS3lOa1Iya2hyR0lTaGk3?=
 =?utf-8?B?aEliWmExZE1reU1mZ1V4aWpyRURqY2xYQXgzVWdReDduYXVFWVFkbmNvWlZt?=
 =?utf-8?B?cUxaR3JOQ25pRTFLSzhzV2F1VGFwekpIY0pwUCtQTnMxei84MGtCOW1sSW9v?=
 =?utf-8?B?ZzZhTi93dFhWdWdRUHlkYktBVXpNMko0OFQyNW5zeXczOFJwSm9DRWJRQ2Vt?=
 =?utf-8?B?UVI0YzVpL1l2aThJdmYwTlJzRFROZHJRd2p3K3owYTJ4USs5YVpwMW5ybUQy?=
 =?utf-8?B?bWZUYUFwVm9nQi9KeDB4clhrOFhBSllTZlNmSWYwTWJGUkNVclBSSVJSNS9D?=
 =?utf-8?B?dmtTVkcrVnRrODMyc0FEMEFORGJVRkczUU5iaFlrQlFVcDhxN1N2VjZOWmJ2?=
 =?utf-8?B?MzFtNWV0bGJhNEpQWmhlYTVLV0VESDlGZVduUjRrQ0tqS216eEJwZmE1QWpw?=
 =?utf-8?B?YVZTOG5MQ0JISjkva2FEN2ltdnZJbjkzTy9Kdys4WGFzNHppK1lranN2V1Vk?=
 =?utf-8?B?dGo5WnhkM25RN05raHpjVUxhUnNnVVlJNDZySXpJUDZLZ2kvZzJqbmI3d0Y5?=
 =?utf-8?B?blpoSGdpVjhYQWtIdlVsUWZkSU1LL2NkMjJoc3dIWm1wU2l5dUlxWXpUcGor?=
 =?utf-8?B?NGMreFRpWjJ0bGxrVEdjSWpYMEdweTVYakxtQzlQT2l6UTNPVDJoa2ZFaVlv?=
 =?utf-8?B?czBOemltaVVPZDBuSEpIMXZiWEJhRmMzazUxQTlMbkVZaU1LaFV3SjFlTDBY?=
 =?utf-8?B?dHpLU3lMTEo4WjA0M2RvM2MzVEdNbDBqa2tBTGZGby9DbzNVMnZlYXRHWXdw?=
 =?utf-8?B?NjBQTmFJYndNUVBTN3I2ZHVNaVM4aVZJRWE0dmdyQ2x6Z0tjZjFPUDl3M1hJ?=
 =?utf-8?B?ZWRTUlJRZmpQTVdaMFRxSW5MOGVGakF1eGhMRXEvUXI5ODM4b0JvNmUwMm1w?=
 =?utf-8?Q?QaEGNmchQzsfLlLfooAL5Q11iGUU/mD3SRHFcJS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:40.6201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e0706-d2ac-4a00-d74b-08dc65f794c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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
V9: Rebase

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
index 4536c8ad0e11..05a2d1714070 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -260,6 +260,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b3b84647207e..4ca14b02668b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_userqueue.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -477,6 +478,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -1039,6 +1041,7 @@ struct amdgpu_device {
 	bool                            enable_mes_kiq;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e4277298cf1a..374970984a61 100644
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
index a2df3025a754..d78b06af834e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -44,6 +44,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 #include "amd_pcie.h"
+#include "amdgpu_userqueue.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1388,6 +1389,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1457,6 +1462,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
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
2.43.2

