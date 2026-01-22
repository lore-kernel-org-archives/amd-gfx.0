Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C0CD3EE75
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD8210E9D9;
	Thu, 22 Jan 2026 15:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVfOTVma";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EB410E9D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ9YxK5Cjpm2w2Dbyxifz/E8re8s6/i/pHCuXGwhGaNxoSgoYP7RGm/YejGOq5qXsYnD8sviZ6DsbhGw+lfEeoF/erktVmqOZKCoDNN5+UkJuXwKKEjkO+j1Nasn49fZOzeNflpAfTJfcyO8rL+yUMe1tUcbKSRi1AKoH8wWlNSLb6d8gsFqXCtlnQT1J+vduMKDWzpfWc4PAKZ0ADdd8fDZEcJ5qQ5garR/z+e7Ueiz+OygmsNyuZQxXw7ssoxRBxnTI/FNhGsKdAuqlXsffp3VgS3Mt/jLULR9Od8FbTttkk/KTdTaCFdyTRYEfFtu1tioVlg0w3NB4tOibbro2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0+LMLvBSHoZAgOq12oPFTDAzKeQVvfhP+oR0lXCwEU=;
 b=uwLV1bhlCvE5j7RMhxRpamphPEZ9SiPavTtZztBTIOOg19IrT3oqjiZXA+k5ryk6pWTiIX9/Cgn/N1H15W1EHG837eoMqStoUKDeoj9dFiYYGVY6lKbe6LjsPh5v9ktMEzVuCb7a5pKQgHwZvFWmVzZPHsi94b017wMnX2tONP2/Ubr0Zj2LN/xCTMzbkcByNMeBqYGmNgsMI5bxQs0xPjX9fR8lllPeWxl0PDpMB60Cr/chin8VKI3VrGSI6n8P3UfzQRICF2ZsnMFaeozqIYd8rENuMMWskXxE02THPyHh4PwfepHpSu75WhGnhLVNuR6Oo3h8G6kT5oGIOhPyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0+LMLvBSHoZAgOq12oPFTDAzKeQVvfhP+oR0lXCwEU=;
 b=UVfOTVmay1JUY2PR8rzMc/M/MpbW1rcB94gEm30ZoMgXEHK7na+pfrHOhKXiiTceHUL8151ao9LKiJ80b8Y+yZsL64DXTgMwvzzkz3fiB9HnYLIXU4pGT8quuOZ8r6iOrkJnFcFsQVvAjIR/mB16VovjVk0S+0erFAkHV9GSUQo=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 15:09:35 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::db) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 15:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 15:09:29 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:09:28 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <david.belanger@amd.com>, <chris.freehill@amd.com>,
 <harish.kasiviswanathan@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2] drm/amdgpu/uapi: add profiler interface
Date: Thu, 22 Jan 2026 10:09:16 -0500
Message-ID: <20260122150916.3069923-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: c30bfa69-7d0e-4144-2c83-08de59c83d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fyv0Oqh8fgEV4E062Ql2TQdvsiRo1XoCs2liGA5EfLAL1Z93hYJVF2WQhCwf?=
 =?us-ascii?Q?gX/orbKZa03pjGHBhd6gElH66BBj6E56hJy2+98OVe0o6WVvH5hRyAgXZGRr?=
 =?us-ascii?Q?T0xFH2aKmR5OZ6VpPrDRZ4nXDmjMCl411YEBzZt+6DiOLojj4Io2WhL1kSRN?=
 =?us-ascii?Q?9YfdrvKv7dvIrizmynyeVFBOGqPTLldzTQj9nS+KIa7ac7QiX9U8NNzjbJWf?=
 =?us-ascii?Q?umTx5TGI0kLRCeOow5KhbaGb8LJpo+an0SumGNqzli89D3828mAPjbVQhce5?=
 =?us-ascii?Q?Ty8Zvb2bkxydZTxNNuRAcdxI2VhNOvYLtN1+9VadrlXj8+Z0NnQ3O2cy6VNS?=
 =?us-ascii?Q?69PZaSeajHOz0LLz2B/7dA7p60WHHaMRqNICy08jLbrVIhyk7JCPw7WUloW9?=
 =?us-ascii?Q?di9oufa+acme9vLAG4gE5aSw25jfX+TkWTpFbKV4va6NpAjMxOQyUDfWjpKI?=
 =?us-ascii?Q?vkLGM/DPvoSFKacOq2jvQqTJh1Vse4W2FYEhaDzCoV53vpC6/iwEoXEsjOOa?=
 =?us-ascii?Q?26WjJZWXM/8ftCsvznNGXM/FH9A2swQkvm17EVC6n7/w7lKZNGrsDl3KYOyR?=
 =?us-ascii?Q?KEVuKF5uyblPbc2Kl9bcoSuycb9pLYJoisGcSWOxEf0QKt2qXT3UPShe+dL6?=
 =?us-ascii?Q?xcZoCnzif2F6QISyO+2rR66NI8p35Rb4jXhHMVGXX8q2LBC7Tzx8pFqWFNFg?=
 =?us-ascii?Q?a0rbL/ZBHUy1Vc7Zky+kTAo3l6k53E9s6ntjFbJA9GNhefMGKHbM8ygmO/d4?=
 =?us-ascii?Q?L+nvVCT6+yLcAIT8Xr71BmfQQA0D5UAIRtF8y4ufW1eye4olCUip/Xjd6dsB?=
 =?us-ascii?Q?OBs//HwpmU0bdvkOIGbrbhFAjkPkG1fCGnm45FCov1wmAF/l6M+I5hcL0SPT?=
 =?us-ascii?Q?DEi1eZtpEFzLf4nMFuNtL0euZ+GOF/Z0JA0C2YMXhhjX0tduYlkNThxDt6um?=
 =?us-ascii?Q?3JdJUUqyQlO688Y/AgZcT+NiWOUNTBvgoBoVjeRSRF+qY1bA9pdXUZR6nAU1?=
 =?us-ascii?Q?YOEQsibs0wn3+AS+FNEJ8IAsY6TlanN6bVVGH1TTWm7yeLGUcMG5jvtn/XAW?=
 =?us-ascii?Q?mz4RalZb5lydNKuZgwvAp2pW9lF8RNuR5GtgMqICQioFZDtuN+hRcFr9oJD/?=
 =?us-ascii?Q?MtQjPeqxlnwAgaPX+tjT+jNQKsYun9gJOKsD1NF4y/QQ66pUppkkozBRWhEZ?=
 =?us-ascii?Q?wdnYVmpTE2pV1YxYspTizC0Qw3NhsZTStZrsM7iO86sigz0S881o6ixwrZyv?=
 =?us-ascii?Q?1OZh6D6XDABYCFuoeR9FACjpB/Amq1mR/rrYfXzWSUh/1dGI8nXrhqN9VWT8?=
 =?us-ascii?Q?/Ax2OJ/UnhJh4BFtHbFf4gbid1pzUzzxMljLugrCkSjBTGGojB/8acEUxmCZ?=
 =?us-ascii?Q?LwiOwsoNi3A4ofdC+rHV5j5dwfvujMFR7tZcWr5fHweH+WmScvkBCrCRF82K?=
 =?us-ascii?Q?7Yc5LJ6moOBP84VcFTl4frvF73nqAd2OBHH8fm+9sQOT3S35ST0xvU7BydC9?=
 =?us-ascii?Q?X8viuqlDiI5yGnJryv/GKo6xfiu1YWmjqa6cySJcC1Zsfw3GhDcdYj8VWZs0?=
 =?us-ascii?Q?vmPawb4WWsDPFEIFodIIT3ilYeQu+Vf10nTz55bHTmv42wbqVQL/q9fuL8wn?=
 =?us-ascii?Q?v38ynqF6wbCf4Ple+yo7StEyddHzplbM7O37JM08xAFVQrVfN+2iJCe9nUli?=
 =?us-ascii?Q?UiBt/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:09:29.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30bfa69-7d0e-4144-2c83-08de59c83d6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

to contain profiler kernel driver changes.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 114 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  69 +++++++++++
 include/uapi/drm/amdgpu_drm.h                |  19 ++++
 7 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ebe08947c5a3..835900318353 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_profiler.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 314a498c5726..bf3ad584dd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -115,6 +115,7 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_profiler.h"
 #include "amdgpu_eviction_fence.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -1319,6 +1320,8 @@ struct amdgpu_device {
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
 
+	struct amdgpu_profiler_mgr      prof_mgr;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cee90f9e58a9..18d83f0c47a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2936,6 +2936,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_profiler_mgr_fini(fpriv_to_prof_mgr(fpriv), fpriv);
 		drm_dev_exit(idx);
 	}
 
@@ -3044,6 +3045,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 75976ca00ccf..6ea4d52c8634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1573,6 +1573,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
 
+	r = amdgpu_profiler_mgr_init(fpriv_to_prof_mgr(fpriv), fpriv);
+	if (r)
+		DRM_WARN("Can't setup profiler\n");
+
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
 		goto error_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..157e6d2f888e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,114 @@
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
+ * Profiler revision change log
+ *
+ * 1.1 - Initial revision
+ */
+
+#define AMDGPU_PROFILER_VERSION_MAJOR 1
+#define AMDGPU_PROFILER_VERSION_MINOR 1
+
+int amdgpu_profiler_ioctl(
+		struct drm_device *dev,
+		void __user *data,
+		struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct amdgpu_profiler_mgr *prof_mgr = fpriv_to_prof_mgr(fpriv);
+	struct drm_amdgpu_profiler_args *args = data;
+
+	dev_dbg(adev->dev, "Profiler IOCTL op %d on render node %d xcp %d",
+		args->op, adev->ddev.render->index, AMDGPU_XCP_ID(fpriv->xcp_id));
+
+	switch (args->op) {
+	case AMDGPU_PROFILER_VERSION:
+		args->version = AMDGPU_PROFILER_VERSION_MAJOR << 16 |
+					AMDGPU_PROFILER_VERSION_MINOR;
+		return 0;
+
+	default:
+		dev_err(adev->dev, "Invalid option: %i\n", args->op);
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+int amdgpu_profiler_mgr_init(
+		struct amdgpu_profiler_mgr *prof_mgr,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 0;
+
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (prof_xcp_mgr->is_init) {
+		kref_get(&prof_xcp_mgr->ref);
+		return 0;
+	}
+
+	dev_dbg(adev->dev, "Initialize profiler on render node %d xcp %d",
+		adev->ddev.render->index, fpriv->xcp_id);
+	kref_init(&prof_xcp_mgr->ref);
+	mutex_init(&prof_xcp_mgr->mutex);
+	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
+
+	prof_xcp_mgr->is_init = true;
+
+	return 0;
+}
+
+void amdgpu_profiler_mgr_release(struct kref *ref)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
+		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
+
+	if (!prof_xcp_mgr->is_init)
+		return;
+
+	mutex_destroy(&prof_xcp_mgr->mutex);
+	prof_xcp_mgr->is_init = false;
+}
+
+void amdgpu_profiler_mgr_fini(
+		struct amdgpu_profiler_mgr *prof_mgr,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return;
+
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (!prof_xcp_mgr->is_init)
+		return;
+
+	kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..18da6267562a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,69 @@
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
+ *
+ */
+
+#ifndef AMDGPU_PROFILER_H_
+#define AMDGPU_PROFILER_H_
+
+#define AMDGPU_XCC_MASK(adev) ((1U << NUM_XCC(adev->gfx.xcc_mask)) - 1)
+
+#define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
+
+#define fpriv_to_prof_mgr(fpriv) (&fpriv->userq_mgr.adev->prof_mgr)
+
+#define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
+
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
+struct amdgpu_profiler_xcp_mgr {
+	struct mutex                      mutex;
+	uint32_t                          xcp_id;
+	bool                              is_init;
+	struct kref                       ref;
+};
+
+struct amdgpu_profiler_mgr {
+	struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];
+};
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void __user *data,
+					struct drm_file *filp);
+int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
+					struct amdgpu_fpriv *fpriv);
+void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
+					struct amdgpu_fpriv *fpriv);
+
+#endif /* AMDGPU_PROFILER_H_ */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1a961f62724e..5d8439174fd0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_PROFILER			0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1708,6 +1710,23 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+	AMDGPU_PROFILER_VERSION = 0,
+};
+
+struct drm_amdgpu_profiler_args {
+	__u32 op;                        /* amdgpu_profiler_op */
+	union {
+	    __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
+	                                  * lower 16 bit: minor
+	                                  * higher 16 bit: major
+	                                  */
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

