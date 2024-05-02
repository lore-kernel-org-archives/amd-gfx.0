Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB505C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0868410F684;
	Thu,  2 May 2024 16:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AVK9jrkD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27B110F684
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4h0zzj/whP3J2yW2EWDnSypcuBZxMB7AGQBrwgfpDU1tH4fd0sZZuSK4Lc0CkVXpM1H2n93LCWclGzVrS2tfr+KSUcenXzyxPh1gscPCZHI8k1+yNV3bqxnFNemfeE8EPIFaxQayGMv/1zm/5fYFyMCwJDfoj6S2ZEzO3gfAwfrM1zLOiG/eFRKWIcsZXLo9CJGv7ctxXwcvqB6saT7maUl59NLmcRlCQVOtfVhGyoXkAaLpUG4tvPXlBmmElgI47CjOm4kuW3iCsOg3aqcebkJLSdy1Wftn1nH8h65NIM/ejVtDbnosdFCFVaPwkoOJgMkBz9b/MwDo6sMAEn9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XISwf7Z/FKXsl4Mlsqx+86FeTXQUQkeQFahC3J8th8=;
 b=D8bMCNwKbEA7SpOfwBtY06/2aj1SE9tg1Pghl5flLJaheNyuz4+eVtDAjHENtRf6AYp8NkxqlahGQgh0JFezKOC1ci0zWBXC/pZt+qJ1EKPQCAj0XQDXBh8hlp+XbibFT4m6PGgmcvs813aIM+5KfSM7Uk7EgUPR7JNhBWR9GO34RfNm0QLLZhGzQgXNwRnuWBIPLtuOkA0eEju11Ym+hcanzsah8TxI1fI2sycBtfaQ+wl1mwmh5FFXfcxmRALu8M7Uh1n8mKcFK+vvDgirxACnvNYWCTcdE9OEa9txFfOs5S+VU5OdM4NhSzYEwwaCwj1XeFLdl7Ry474azeEQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XISwf7Z/FKXsl4Mlsqx+86FeTXQUQkeQFahC3J8th8=;
 b=AVK9jrkDJeU9ZIFuR3TNgFIYLBYKujPiHAfrdJKiP29O1txMnxjor6KqLC4v/Kq07aIW9F1esNnhe9gVHWEiZgFryoePCcEThcAQQfwz6XFbCcpAdxPjY6cohY4bfnGGW36MB9XtamUT33G86QAFEJPck/riVHimAsBdyIy1Yzw=
Received: from BN8PR15CA0032.namprd15.prod.outlook.com (2603:10b6:408:c0::45)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 16:32:30 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::f3) by BN8PR15CA0032.outlook.office365.com
 (2603:10b6:408:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:23 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 02/14] drm/amdgpu: add usermode queue base code
Date: Thu, 2 May 2024 18:31:39 +0200
Message-ID: <20240502163152.1382-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: cd23a435-045a-42b4-500b-08dc6ac575e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekRzSXg2Y21OY2dXYk4rbUJKUTNnekNMNTY3NytWUVE3cXhMN2ZUTER5NWVs?=
 =?utf-8?B?V0pOR3VSL0F3bFVxcUtOZWJDSmxHcFpTRGVWd1FHZUxaeVNwUER4eGJ6QnR5?=
 =?utf-8?B?V2RnSUtRSTR6MWlJeXRFMjJ2ZktRTWtCcm5pYmtNcHV4MzZkdUs4QkdDWk1y?=
 =?utf-8?B?eXZieHhCdm5pbFVvV0JIbHErT3oyN3hXSkJMZ0VsaVBJdkppYk5oL21aUTdh?=
 =?utf-8?B?cWtnTEF0TlE2UC9OSXpGcnJhMWRtTGpLL25hOG5BakFhcXVlSkdMK09Udzh0?=
 =?utf-8?B?emZwazArQzdiS055ZTZkaFlIMExLQ1lxWWdJZmRwNmVRYjJTQzkrbldRVzhL?=
 =?utf-8?B?T3ZHL3NHOHA4dnFlWU5KL1REYXZhZGdOTndSZjBXNmtBSnB2ekJyc0IyZzUv?=
 =?utf-8?B?YkVMc3AxTmpQaHNhSUxEUmhldTJNR09MKzlaTG5ndzNDYjAyMm9WcXRnWDZZ?=
 =?utf-8?B?dURUeTEyRVovUkE1R2owWmhIcjNwMjRVOGRmam0zd2dFYzdVZm9Qcmx3d20z?=
 =?utf-8?B?UllzS29QcGlTU0N0Y3dCdXNZWXVSZkh4R3AyV1BtZHFYeVM5MUpOYnVGaW15?=
 =?utf-8?B?QjJIY1ZVY3JPN21DaHdCUW9XZ2toeW5oOUd2dmxEOGNHNDUvWW9ESGpDOEha?=
 =?utf-8?B?QjJkUis5dFB2L2tDQS9PZTM5VW54VzZ2M3cyc0VLY2FubENVSVFCUjhab3ln?=
 =?utf-8?B?MXdjdHkvT3RRalJzUE5PTWJwMlBkbVV2cmY3R3N5V3Q0aFphUGVOWEVEWDU5?=
 =?utf-8?B?OWorTlk0U3F5V3FnelhqdFNvU3E4Q2c1Zm5KckVhQWhYWGJ5VEJESnZjNXY3?=
 =?utf-8?B?cmMwYjVyUWdsb25VQytVVUVxYUpvc09wQVZlSThJU1hjbmt6Vys2M2dLMGY3?=
 =?utf-8?B?aGJKcklaZm02bHQzY2swY3pyaFl2M1NXS0R1YUFMaFNML2lQNFhGSnlTMmtE?=
 =?utf-8?B?amJhUHVtRFZZeHN2UHY4R2dVRENlTzYrZmcyb3cwVjNlbkhKNlA0WFpmTG10?=
 =?utf-8?B?d3RIOE56QWJLd0k0cFFxUkY1RFVtRzQvQUN0VVlBK1V2T0hGdmQ2Q2x1UWFt?=
 =?utf-8?B?OEZ0ckZqd1pDOGFhdlJocTliME9KUENtSVNKU2VRb0dXK3BlYTQ0SkxYa3Q0?=
 =?utf-8?B?VWJ5M3ZTbDFOS005RGpyL2NrbnlQcWVMQjBpOEUyQXBDeFVBdzRoSDFtOW8v?=
 =?utf-8?B?UVhjMnNZckdoZlJXbUExTmZibURId011K1UrNWhNUFQvNWtoYmRnSkkrZ1gy?=
 =?utf-8?B?SnN6aGR0Y09tRmo5aXJWTW1nZU04cjNXSmxPRmg0d0ttcTRvL1RVTllVYzVJ?=
 =?utf-8?B?MzdMc2NmSlQraUVyYzhPRkpJd2ZnYmlHV1JpYk1HcUFlWGxOU3dCMDZHWnJZ?=
 =?utf-8?B?cWI5N0VkTURpeVE0eFQ0V05jbmJKUElnUXVmeWgvaGFwcUxyRW5UcFNxZWlG?=
 =?utf-8?B?VG04ZzNYM3NnazZBS0R1VHZZeTM2OUVhT0QyZnZYcjE5a2l4RnR3RGNzeThQ?=
 =?utf-8?B?ckd3Ty9uYnVEU2wwZlZLbmd6ejZnT0NpaW9PRHVaNkNmWHkrMUgvVytYbFpy?=
 =?utf-8?B?VjRIRDJaZHZXQU5KbFYrT2JDWCtYdWM4Nm56NThFckxjR0x4MHFZc2hKS0Rt?=
 =?utf-8?B?eEtRTU9wRTQvWU9lZVZmTjZaTXc0RmEzRktrWkJjbC9YeG9vcEM0aTBMTEQ1?=
 =?utf-8?B?V2p2ekhjVGROZFUrYkpxWWNUclJaWW9ESGhGQWFZU1NZSG04M3pYN25pa1p0?=
 =?utf-8?Q?UYhOtGhIAj5qoogIk+adg2rFlJf5oOpIJB4zaT8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:29.8403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd23a435-045a-42b4-500b-08dc6ac575e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

This patch adds IP independent skeleton code for amdgpu
usermode queue. It contains:
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
V10: Rebase + Alex's R-B

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
index de7b76327f5b..2d421f17626d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -266,6 +266,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8bb8b414d511..c24e9f9d37e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_userqueue.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -486,6 +487,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -1050,6 +1052,7 @@ struct amdgpu_device {
 	bool                            enable_uni_mes;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 447fa858c654..b52442e2d04a 100644
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
index a0ea6fe8d060..76d02dc330a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -44,6 +44,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 #include "amd_pcie.h"
+#include "amdgpu_userqueue.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1357,6 +1358,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1426,6 +1431,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
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

