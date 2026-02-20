Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11F1C5AD57
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C3A10E82B;
	Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uY9c6EsF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF4E10E82B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9HPKIGSH1xX9e2X1Mbzjth3UHUYppkNrGzbdg5Il4iRfXG/VwZixBA72VxStFYVSenyPQ5xY5IyCQYZAO2YjiZm5qinlScVlJoandZYeZMEN0OvHiWovna8rlud3iC5JHe+V5DUTVh6DTwW/U/glbB/SNYkpOGnMmVDUNaoK7pxNzG+CCXdzLvRiI/8BrhCYZEs+MJaQRJNzngEf3IdM5EPcIFbEtivsLsD/PPsbM0iaEEzEe5E7SafrqrjxUz8mHdlZqIhFUDIG7ZQOb0mGnPnW/YQc1OGYWWL9ZQXijTWHSBvaqheSLcajmB5OEwxTVdMg1xRL57yr6nXwwueYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cubZ8gtRwmcZpDd7ovzQwQ8uekoV9QPchr1Qd/h9E9s=;
 b=NYMwhmczHr2kPy8RBlAtBD1LFm9SYhWRQrn78AL8A6ZsFMZa8e+H4GEK7RomRxaK+R4h7hKSao0wo8nZYMvAyKfhVkqlqTLRJT/58WIVGk70JNRZDNj2+4FY2vtGFMPu3i6Oi64k+grFXRLqQ1LcRyl1DAnfGGR8MX08puIcHajGGv2wl1DngvTErPfRqme+pHWhw2Ao36DtQdPtf53wlh+qQ3bKHm4VZPGDDBW0xzJLcBcR55qW0GbJ3F3rrGvKUvHpGY9CTQa4JOGEEwfg8qu4Rm6iL0JGMqVwvKgpcep3GxwCAU6dbqrbUVqw7f0cNlqEcIDMjfyAjbsdKiwquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cubZ8gtRwmcZpDd7ovzQwQ8uekoV9QPchr1Qd/h9E9s=;
 b=uY9c6EsFSvEwhVYtVP4sTARMYROF1on2Bpde+Tb4qHkLJw1uTVVhOeanF1IwJuA6+Jec3j1IYZ2Mz89pm09dPU2UHUtlVqCUtTcprDU5018JuByos2cMgtaIrZm8j/wqNrt/TCkVR4u5BhmR4r79me17a6BIAWjR/A1avuYBvfc=
Received: from PH1PEPF00013302.namprd07.prod.outlook.com (2603:10b6:518:1::11)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 19:23:04 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013302.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:04 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:53 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 07/17] drm/amdgpu: add profiler/spm manager initialization and
 release
Date: Fri, 20 Feb 2026 14:22:26 -0500
Message-ID: <20260220192236.3121556-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 991e524d-f5a2-42c5-8d6f-08de70b5785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q0U6lr32mwDiFX0E5bMINZC3dWcFaSuqjCGlVl9FIE4+fSxRFnkTgNLDsxT1?=
 =?us-ascii?Q?HyVOqxf5bNsYE8ZbpCxqnouWDifE5shXS5to3H75JmRb8nd2DCvEnG5ZQxxt?=
 =?us-ascii?Q?FpGFSbaIU4a2PRC14b89g+018oT3r3Qm0sw2OiA7+LldQPx9Tq3T/iWPpEIu?=
 =?us-ascii?Q?seMz6sDM9MzheVAiWfCYD35iBYky85ZcXiQqimii/rTvkJ47RgSe8qBI3dno?=
 =?us-ascii?Q?7iCOP16m3B+Jv9BiGqB3jNL832S3bPT5Hnt3cyxa+1Yw86umlpBurnjl8Iyw?=
 =?us-ascii?Q?SaV2Hu72Qzhh3K7pjd30rNkOzZy5TU6M+ycuy53vb/isUXz4ZcPa8OiJlCDq?=
 =?us-ascii?Q?uUazN7NBWeRIjAFwB+rYFgBuWDHSGTegIoAx3w4BDtICXmth5HpFmZviyiZ5?=
 =?us-ascii?Q?5DpxTJI8UGawBKy2z09ObGffte2ablxsGiqWypDu+xkD0bco/78oAl9fwmra?=
 =?us-ascii?Q?gMv+hgmNnEyuHATFZDQ9kz2vbWzL12na0V6K2DeVYfFQMQotr47AaxUPOZ2U?=
 =?us-ascii?Q?niqAIQHFMLMZOLcsm58073OXMCB2SVp9WlfCJvdPGiGdJjjVSS9Re4Cw//8q?=
 =?us-ascii?Q?96ldVMsL3IV0mrbqSFW/TAO12t5ciC8yB6f5/8uogRajMrZyqZIsb2HrJSfj?=
 =?us-ascii?Q?zB0Oym3ReMrQHxTNlhgiKR4umBpjEEq/LxqjvN1QkerHoKfhxC1EWNBUMciJ?=
 =?us-ascii?Q?Hqc+Cu4u8DR38Yr08RhfoH2yySgFi762PiG7qNfxDx3IIPmCqgxvyDVCxDYV?=
 =?us-ascii?Q?BIzU//mU8JD95p2MpbozbYnAjiTVSOj3aSOIrUO0tsm/8JtC0cnLqDFtXTLI?=
 =?us-ascii?Q?X5AM3gpBolui2d/H+EpgMcTdwRmNQAsxby/JXthDBPc8fwrR++ZfiS4tSLas?=
 =?us-ascii?Q?cLZbn4/f4ivJ+rckXXIseS6UkSeiidnoo1dEnNvEJb/w4aV1cTiRwhxtnWJx?=
 =?us-ascii?Q?V4WR/HYdC2j5yGDzOV3MC02cMXDM+E7SjJu4CFxxlk8TdB3wQlTvWUbTrDYJ?=
 =?us-ascii?Q?itE6ZUDuQ/UdhlXV2IgiTa8qlbjeWb7zk4Vbn9gGDouZjMfs9iNjnkPgD2ad?=
 =?us-ascii?Q?omAWA/DKLR2yi5W3p6hYB48jUR3X+zNQXGnRYZAign1GcSGFHRDMR99gePov?=
 =?us-ascii?Q?4v97XZWM/PkTixOPCjYg980ypYEWheZgti0j3hxDGvB4VJUjpjsrKBXdSfoy?=
 =?us-ascii?Q?qRjD8eFo4xzMVRxs3euUHSBRzysMoSLuvWtWzYINuCt3mKw6eYfWWo8+CvwF?=
 =?us-ascii?Q?j8//pLNtcnc+FEsGLlFAIversJNDfRFb1izNCBUCpWFOKcaYpFbwTQ8RMzqu?=
 =?us-ascii?Q?UvQqbzYSyGUmDdhNyNit5dNJL8XdORd4LYN/oOyTEr+cTSzQoGxAzYoQFaZY?=
 =?us-ascii?Q?ik6T/DvOk/jLQFuwzRgX3LtXSLmatYFyh8r9SPQ50aNmj1DQwYxg4XnmCZRT?=
 =?us-ascii?Q?cWoDzoBs4/pgfJHXCnrw9o7dmXPD9HS2bsAE4S/SiS3GMLSF55nh7ElcjAsQ?=
 =?us-ascii?Q?Z2CUtRjFSeNIQta592DAZiCMTMgPibD7FI7a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QWoARfpck7chzf5tRLv4uUnppJrW9e4GUXxCqyimPm9Z1A5sH80Ta7svCDZ0Mk0JrI88mXWl8IrfJZFZ/OScuVLVZFqHtbr2MeLiza2qoAVhoDYov0nErxTeqqu06MwwMnRrXBm75ojx/cDT6tCijl3svG7Xe6ZjKAJqN/VxZLXlXMl3wK0n/sFe3rE26b1A271B5b5ZEUiaqElF5Ls6NZl3GNe1dxpMOVX23WwxAxXAOgoyvtVKXdoKh+YvX9rlNpjBty3AwNSo7CPplwXg7HMzX08mthSmjYepeCtG9oqrlEAls2aGshP5Yzr50c4k2zFer4eYpDMuXyphIwmlbCydzsyozoFC+xNJ60S14FpIy366mB7FX6Qt2MkIUrTvUFUpdOOzcbXns7P+ZI1p7TNWxVxTA6kTPctGgiX78iB7t15QacRbp8jBiDR1zWQ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:04.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991e524d-f5a2-42c5-8d6f-08de70b5785e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

when render node open and close.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 21 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 62 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      | 33 +++++++++++
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 835900318353..e50c0b9ab4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -68,7 +68,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_profiler.o
+	amdgpu_profiler.o amdgpu_spm.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 5e4a1c36198c..05ecb8e3855a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -82,6 +82,7 @@ int amdgpu_profiler_mgr_init(
 	mutex_init(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
 
+	amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
 	prof_xcp_mgr->is_init = true;
 
 	mutex_unlock(&prof_mgr->mutex);
@@ -93,6 +94,8 @@ static void amdgpu_profiler_mgr_release(struct kref *ref)
 	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
 		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
 
+	amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+
 	mutex_destroy(&prof_xcp_mgr->mutex);
 	prof_xcp_mgr->is_init = false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 3f4d969ea0ea..369833f6e684 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -25,15 +25,36 @@
 #ifndef AMDGPU_PROFILER_H_
 #define AMDGPU_PROFILER_H_
 
+#include "amdgpu_spm.h"
+
 #define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&fpriv->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
 
+#define prof_mgr_to_adev(x) \
+	container_of(x, struct amdgpu_device, prof_mgr)
+
+#define to_prof_xcp_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_xcp_mgr, y)
+
+#define xcp_to_prof_mgr(x, y) \
+	container_of(x, struct amdgpu_profiler_mgr, y)
+
+#define mgr_to_adev(x, y) \
+({	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(x, y); \
+	struct amdgpu_profiler_mgr *prof_mgr = \
+		xcp_to_prof_mgr(prof_xcp_mgr, prof_xcp_mgr[prof_xcp_mgr->xcp_id]);\
+	prof_mgr_to_adev(prof_mgr); })
+
 struct amdgpu_profiler_xcp_mgr {
 	struct mutex                   mutex;
 	uint32_t                       xcp_id;
 	bool                           is_init;
 	struct kref                    ref;
+
+	union {
+		struct amdgpu_spm_mgr      spm_mgr;
+	};
 };
 
 struct amdgpu_profiler_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
new file mode 100644
index 000000000000..181aca333151
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ */
+
+#include "amdgpu.h"
+
+/*
+ * SPM revision change log
+ *
+ * 0.1 - Initial revision
+ */
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+
+static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
+{
+	/* TODO */
+}
+
+static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	amdgpu_spm_release(spm_mgr, filp);
+}
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	/* TODO */
+	return 0;
+}
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
+{
+	amdgpu_spm_init_device(spm_mgr);
+	return 0;
+}
+
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
+{
+	if (spm_mgr->file) {
+		amdgpu_spm_release_device(spm_mgr, spm_mgr->file);
+		spm_mgr->file = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
new file mode 100644
index 000000000000..e8a44fc1d278
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef AMDGPU_SPM_H_
+#define AMDGPU_SPM_H_
+
+struct amdgpu_spm_mgr {
+	struct drm_file *file;
+};
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+
+#endif
-- 
2.34.1

