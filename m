Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9266ECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9627E10E67D;
	Mon,  9 Sep 2024 20:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QO240W1x";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6ED10E67D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IybH+fk+2CsQMW/ZH9J4Be7i9BBwIVdbyrXMSkjxXz9GMZ86Mj8igCGaHd2M6/xDI+e24BvaP3Ea4MmELyfvM2soENP191zw9zQo396Y+pEPQyMIEKAK1h9dG3WXWf1XM+on6dFzV8MJDYryx+7MJhfpSeKL8FiF+mBhr7a5n6BH3yh6dpCHpxrKcTbKXDdBcJr1YArdChE98zXu98ayn9m231v/LApD9XWNmH9mAuP2QtWJNzXFvsXIoZN4256jrstA7x1pdQ2lDsRbRqu0oIJUv+g0TF3hss5MWtUqICgguNXheQMoMzpq9miod4orQAuyc6KJtD1fgtABcPPWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Tf+d2ogsPXoQnSzJ4xX0pCtr+8Z5wqp++BVpKTFfA=;
 b=MWpvl8ekbw/zz6N9yRAIlAGKQh5CWLGcTkpWwMb6JGBVOGYSRQIupKSQFwHRmhcYHGtzy/a6AovzJ3/8JpTchl16PVyMapphqweJ+T3C9sejqiA419vmiBLWb8Eyo/1fK2gr5mtL7Am39fY7nBz5iC6OD8z+GHfrPVAAYD6QHTark3VCFkU/3vWwbpziNH5hKSBBTtLL+rqhjVMElVKx+wtyZMvZ5YKUrSNC9qZKhKZQOltnSAzHyRxPGvUY8p80CSnUOUgxBfeXnc3Kbk7y6UJxHYAv17qLmWcgcU44sYxlEnFbVMNDl4hIZ7LLzdgk0RU0Y6W9FMNL646N39sFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Tf+d2ogsPXoQnSzJ4xX0pCtr+8Z5wqp++BVpKTFfA=;
 b=QO240W1x6GsWQ9NwDmwiTD+OR7afY1OKUOlOmp7cquDRKzCSjeD4VD78nhHmLeV5C6VGK6zisPJdEYfml6VhaQT4h73dMek7y4tR5aidJY9wW/SfQXAwtvhn0CVY+fxNeC9IGa6lKKmzuhLpG+JioCJChNMVHfwfD0cX0evlaVY=
Received: from SA0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:806:130::9)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 20:06:58 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::d8) by SA0PR13CA0004.outlook.office365.com
 (2603:10b6:806:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:06:57 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:06:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v11 02/28] drm/amdgpu: add usermode queue base code
Date: Mon, 9 Sep 2024 22:05:53 +0200
Message-ID: <20240909200614.481-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eefb706-3a55-4dc3-e91e-08dcd10af569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtGcDFkZ0NycXNnWVQzT043MGZWQ1EzSDNiekpjempvalVqRUMzNWNzT1Vh?=
 =?utf-8?B?MXRWYmkxa2tHQy93akNFZHF4TkhmZU5CekEybmxnQUZFaDRmelREbmtCREpn?=
 =?utf-8?B?Z2RhVWVSV2w1V2hTeWo0NS9EcFo1SC9YS0Q4dnp0dU1JQkR0WXpKSzZRV1I0?=
 =?utf-8?B?amg5bmxvc0ZUSmhwVDU1QlFWcWlMYkVrcm1yN2ZvYU4xRHpNYVpBelRTWVFM?=
 =?utf-8?B?Qzhnc2g3Q1lVMkxMQmJQOVBTMWhKMGRuZnE1RGFNNklUVmpUV3BNWitHaG9U?=
 =?utf-8?B?Q3JqdUU0OHU1MExIbVJlYXVKcXBmV042QlAvVnVzeTYvSEJWZXg1LzNRNWZr?=
 =?utf-8?B?ajhEcERZSktaRmlpQjAzaGZPNkxMNTJaWC9COEVRVHIwdUtzR21ZR1l1cnRn?=
 =?utf-8?B?T0ZWU1hmOG5ZTEkvSm5SNnM0QW5PQnlETVgrN2V3NlJLbUdGWWpUbDhUcjRE?=
 =?utf-8?B?eEltV1U0SDRJd2lRUSsxemtKR1hmOVRhUHg0N1l5NnVaSEVlRC9BZm8vWGRz?=
 =?utf-8?B?OUpkNDRUcTZCL2NpNG1KZ0k0Q2hvbDJyMzdwU1RaOU9BVXZabTlWZnJ0aGJL?=
 =?utf-8?B?MUJaQjhCMzBldUwwZnZVaktXMis1TDd6R2xyWWFKRDBkTWJvRXFyQ25Gdk05?=
 =?utf-8?B?VDhpcFozU0ViZ0NjT201Vlp1Sjh2UDBtR1h1cit5TDVQSC9FeFJvQjZZaUdJ?=
 =?utf-8?B?V2hMYVMzQjRxTUkvZGJab0lZcWwvNG1UcWFyUGVPMXk0SURCM0plNHRtNzg1?=
 =?utf-8?B?MjgyM1pOUkVtbC9QK2JSTEJyT01ONjhCMERTcXpUUDIyU2tzQWxJV1VoVFNV?=
 =?utf-8?B?NFhrakhlWVJNNmFPcE80cGFGci9CdVFWQ2Q5M2I0Z1lkQVROemlBbDd6VTlG?=
 =?utf-8?B?cmhuUnN0N0ZNelc0VTRMeVpwcWZQOXZFS3AyTzdUUmw3bkJRMHVPZVJLYnc2?=
 =?utf-8?B?T1RaYk5FdkZSYmFDTUsxUkQrNWhjK3JVb3pGZVFaVGpWY3JKM09INFlDOWl6?=
 =?utf-8?B?dS9IR0cxd2Y0NjRhUXpkZEszOXUrQk8yYktyTlNoelUrZDdJY2k5S2tyeWFX?=
 =?utf-8?B?RmVZLytkOTNJenNlOWhpeGMza1NZZlZvSWEyWXllVmVDYWV3enlObDhDYmJR?=
 =?utf-8?B?amNOUWduMFdNNUdhUkk4QjBVWmtGWEd5bmNIV25RQk55UWp4TUdzY0VKaTBN?=
 =?utf-8?B?K21RVzFmbUl0a0pkcXZmMHcrYzdMNmhpTDdiS2kxSTBPRjBSUXVEYmZLNjJC?=
 =?utf-8?B?bTFrcFVuSjdBUVJ4bFFac0g4S3dlTkN0MEJZL2ZZSlNzR3NxU1BXNElOd09h?=
 =?utf-8?B?UVo3VFVxUUdsbHpDN2hZSHE3MzhxQy8vRDNqNjh5c25aRmxzWUd4OTNNUDMv?=
 =?utf-8?B?VkRtRHZDa29ZNldrSWxiS3J1UTlheGJTemloQ3RsdzRlUVFvbEhKbGtoL0h0?=
 =?utf-8?B?UE1Wckwrd2hyYmYyWi9zM2xoc0FSc1puL2xMM3I4TFZTZWZZWGxFYkMvVFVi?=
 =?utf-8?B?SjFxY2lhSHdRdFovOXNiUzB0d2IwMWFhTFE3YXhHY0d4MW5rT1MxRjB1cGpO?=
 =?utf-8?B?MmpVYzlaV1BjYkkyTzJPRTUxSjVWV25FR0plSEEwcjhLMGVGY1dKbm81YkJa?=
 =?utf-8?B?NmY5QjlCQVdZandoVitHRXRiMkZ5eTZjR1BWaFlzZ2drcVd2eVNtMU56cHBH?=
 =?utf-8?B?Vm9jdExlSWFtZllHbkVqdG5wbjFuRmFCcEM4SDc4eWh0clFYaTQ0Mk53T2JC?=
 =?utf-8?B?UlJ6Q1d6am5nY1pqa2lQU2lkRllKdnkrRXhPZlo2SVBOWDZKMUh3RUVRMVFY?=
 =?utf-8?B?UTIxakVNRHMwQnEraWd4ZkY3Um82QkVoUnlNbUpXQnBzaC8zYi80Z2JOY0wv?=
 =?utf-8?Q?wrnTnab13j3i3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:06:57.6067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eefb706-3a55-4dc3-e91e-08dcd10af569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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
Change-Id: I6585d012a7ead1105bf43a7b91f361d7dd20a9a9
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
index 34943b866687..dcf64b965bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -250,6 +250,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add gfx usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6e6580ab7e04..57a418eec3d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_userqueue.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -493,6 +494,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -1052,6 +1054,7 @@ struct amdgpu_device {
 	bool                            enable_uni_mes;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 82bde5132dc6..d92f01f3ea44 100644
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
index d9fde38f6ee2..019a377620ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -45,6 +45,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
+#include "amdgpu_userqueue.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1392,6 +1393,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1461,6 +1466,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
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
2.45.1

