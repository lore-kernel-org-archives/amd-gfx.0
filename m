Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61540D44C48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 14:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BA410E76B;
	Thu, 15 Jan 2026 14:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0i+jFB4";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CDD10E76B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 14:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE8rGow+c3W7yoOmpcpCGEdVTHzt+//jdWzxEiVmx/X8IarPlxalBYaoAL1k6LzHkZE1iCG/27SC9KTBF05otoyW5okEkwTWZOGzc/9kwyWXvNHXStoqE9LcB1SIQViGJYpLFlGVTcuMKY/5FH9U15oB/RoCHrN6OiVqZGW3I354B+/WjiEFj1UFUgC+pA6VCaRW6LvQYSgnSOjoJAvJ50bKARIwBZ9TApq4SHdeGBf9DJ0FRr6gvrqw7XzI6IAYtMg38eA1QzUXg8jEUEvl+qxZi9pA/u5PN5RnB38JCBzj1iLY8yQwkKyhBoOm57/OdwBXDRM8HhBD/nyL9g1I8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGmpEEZIsdYsbYAaltPKO59B9uVtN2feRTf/2StHufA=;
 b=lhoyehhQqIwex6XGf4S2/fla1V3ZdyDHvGM5CbHBT7kh4UhU6+MtPx7f5/dwbms+onqUVbWfgbmCvGYh43+QnG5/LlHaSAdyNpiMRbfa1ziNUDll0WNGTnFZmpmw+cuAAN0mzTHcPTawNK933gAXWwfZGUwDwZOjpGgqwintBxBmH5yS9gswCmo+JKFuZNuWYy9DX8aFSrQ6gkgUD6xJmnIo5k7bVIPb1K3KJvpuMKATlUeO1+cyGRn41XUO1bEEJ7YtocBTnLLUb/kaWBd8SMJDnijQgsIQeCz9xqLviFKu8D3KMmQuxjuomKGEVc9YRCrXZKqSHUfvlt+MsNq+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGmpEEZIsdYsbYAaltPKO59B9uVtN2feRTf/2StHufA=;
 b=x0i+jFB4SpVvvYslfA3t4+OsQoeqvUm5o9pVpeBfQL+9KmXuMCsyJ49nFc/atg3UrcVqUNo8tNeUrmziDfbMW8zRQZI4R/djBYRXCPWg3du9BUF6nZAdtfzTnygIK6PfvA9StNPwSyaYILfjHF/PpVw2tdBQMeOq6TnaS66se3c=
Received: from PH7PR17CA0014.namprd17.prod.outlook.com (2603:10b6:510:324::29)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:23:28 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::50) by PH7PR17CA0014.outlook.office365.com
 (2603:10b6:510:324::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu,
 15 Jan 2026 14:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 14:23:27 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 08:23:25 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <david.belanger@amd.com>, <chris.freehill@amd.com>,
 <harish.kasiviswanathan@amd.com>, <jamesz@amd.com>
Subject: [PATCH] drm/amdgpu/uapi: add profiler interface
Date: Thu, 15 Jan 2026 09:23:09 -0500
Message-ID: <20260115142309.110845-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ffabdc-ed83-4db3-ab31-08de5441a639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vUt9mlyE/cCzuMkUQXuIFQxUIDXkDjwOt61ts7BRZoBn1Nh6KRWh7Ap4TOTL?=
 =?us-ascii?Q?vshRqatHljLdDpwMviYYUfZmu2XgoDAM1u4DnvrWCDykjPfwyhmW1H7sygfS?=
 =?us-ascii?Q?pW8o/2Kq6p4MdSfF3AIxt3uZn1X6xN/vquGGIOUy9c8QjxSH3U3LU3UH2aYg?=
 =?us-ascii?Q?GliJecTvtx/exSnNSl5+Z7GxGVpEgvemkloIZhsuoA3erTb0nlmYCAFojLX+?=
 =?us-ascii?Q?BHbFqsm7bqQAyRDYfIFJP388wM0f4YxD28LmRDgqzJgOTh62tkaiA/yigh/n?=
 =?us-ascii?Q?OV+mrGVzrpPyAdEsjhh/5fjRQNxyrfMHCE7gP5S+/9bRHmTk6tVGJlYiWHyO?=
 =?us-ascii?Q?C45VO6bgXAol21z5FT7mIMkCMaFP2IuVXaSMjLIrAqwUj48Z3BpQTSuKwnF5?=
 =?us-ascii?Q?jkXkA5u3ffBT4WcgoAYoLqgeesk8N/EDa+6+1X4uzOlKpHJz+EoST14el3B0?=
 =?us-ascii?Q?J0AoZaWGJyoTGsbp7f6RiVvbOmrUbUJf1yyxGLy7jTag44xRWdNzQWDIz+kf?=
 =?us-ascii?Q?w4oZ5wWPXHr9TACOSs4pEGXF0XUP6AVQh3bHXFIcWms1OO8qwjOYWWEapBNm?=
 =?us-ascii?Q?Tol7E0RDH9UJpcy9eRDBlPcDzxd7lsYPuZaWOJ/mWDv20lBqBcL0yx+yENNg?=
 =?us-ascii?Q?9H3KHnuvf0cJYEHGnJc8ID9njcUxq7uyWCzl1x+guvQdRFxrp8LX1cMOWUjv?=
 =?us-ascii?Q?uqkPM49mXMuPirSFkJjwuMujXz0yJDI7VlIGmzI6gx1IX239gAhEj9WXhZWz?=
 =?us-ascii?Q?v2Mius7bPUMvRJyvR1J1zej+CA5opktNiQ/jJ01K3sVzKxFr5R0v2DdbDjlL?=
 =?us-ascii?Q?gr3+nbdAQrna3atajWd/g8W2zxWISS9jos2VhAbeite+NedGMUF6CR8BOFXG?=
 =?us-ascii?Q?5GNoYDGJkSXUxRp+dT/cvLWlaBaWp5Qg3kWW1/yqQ5R5cAaiEzDDLPa8Zwn9?=
 =?us-ascii?Q?sLAEmO+NDruZRvgvlR39CKUQFn0yUAYDlOG/c1TcHwLCWIKThZxQKLmpyw1g?=
 =?us-ascii?Q?3cGYzyiJ2TlfhIfsTUrZDPX+xjNKMRUqBbTS8s9E/jO4gRebuHwJo3umeGHm?=
 =?us-ascii?Q?kak+1hjEGEJHiKuEQkljYg5/IT9PBSl8P5yVq0DZleRp/fpCthFQ8vWEV0wP?=
 =?us-ascii?Q?wOHvsGRuZZdaPMEJSN8K//hsDMoRl01WSxVaeRekUwZNmLm1NbEvNU3o8pkF?=
 =?us-ascii?Q?kJplGTlzZOFl1/BlzCMaTZSj4jr64iRZffBQAbV7/zx/6y6AG54g2YJ/kzx0?=
 =?us-ascii?Q?A5paeMvLjaiUIxFWsclM90GJRSnAFksSM9uPx7fY2Ykqn4VI7HDMcxniNWTM?=
 =?us-ascii?Q?I2+Swq7vnl6DWXfCm+DGVwNwWagB2zoGWdqLznQ/tWKjCwHtC376LHeTORWg?=
 =?us-ascii?Q?VNW0S8QRVz846dj7+n/UkeNCENFhP7jHHsOP7XHlDJBdfpYiw20CxKTNBVhv?=
 =?us-ascii?Q?CwXl5c8cAWU4irq7f/fURyrA03BFgV1Xu6Nhf6GFY+axuQz5i6YWMM/U2y03?=
 =?us-ascii?Q?4L6GZ1g/ynIfK8Hds8lko7pqq9kF2j+vBGPPYoGZZuVc4bQEr8MTQ8NjENhb?=
 =?us-ascii?Q?n/eYqCj2YGV9eVywIUF9owhmOOms0Q7szOpN7FrQwIVqfDwDwhY/khE0Dz6v?=
 =?us-ascii?Q?An3bw52dg/fcKUWFCN9Du0XgM/4xcj7z5AaM/zBy3CFBWnVw+0UVu/1Sf0C2?=
 =?us-ascii?Q?FXIeag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:23:27.0956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ffabdc-ed83-4db3-ab31-08de5441a639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824
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
index 000000000000..a95001a7fcf4
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
+        struct drm_device *dev,
+        void __user *data,
+        struct drm_file *filp)
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
+		args->version = AMDGPU_PROFILER_VERSION_MAJOR << 16|
+			        AMDGPU_PROFILER_VERSION_MINOR;
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
+        struct amdgpu_profiler_mgr *prof_mgr,
+        struct amdgpu_fpriv *fpriv)
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
+		container_of(ref, struct amdgpu_profiler_xcp_mgr , ref);
+
+	if (!prof_xcp_mgr->is_init)
+		return;
+
+	mutex_destroy(&prof_xcp_mgr->mutex);
+	prof_xcp_mgr->is_init = false;
+}
+
+void amdgpu_profiler_mgr_fini(
+        struct amdgpu_profiler_mgr *prof_mgr,
+        struct amdgpu_fpriv *fpriv)
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
index 000000000000..edbd09315f6d
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
+#define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION? 0 : x)
+
+#define fpriv_to_prof_mgr(fpriv) &fpriv->userq_mgr.adev->prof_mgr
+
+#define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
+
+#define prof_mgr_to_adev(x, y) \
+    container_of(x, struct amdgpu_device, y)
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
+	prof_mgr_to_adev(prof_mgr, prof_mgr); })
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
+                          struct drm_file *filp);
+int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
+                             struct amdgpu_fpriv *fpriv);
+void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
+                              struct amdgpu_fpriv *fpriv);
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

