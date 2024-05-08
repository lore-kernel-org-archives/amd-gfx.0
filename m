Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314DDC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 05:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFEB6113367;
	Wed,  8 May 2024 05:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rftG8MGb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0817113359
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 05:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj8mxlnz12+KHFf6xZIdVFkdvnA4Bfo0hW6+H3dX4DgqgTcpgfkY9h9nA4o83ru+328r8USmRd/swFXRmGQ58RZDbFW4gO1vDMRtT/3fMdVAWVmDw+KR4AjmJVclnrpYxecaaFIugXkwUxJOC9TeTgDjFtdzZXzihNmonxx+nWoSM5Acblf4aWUuWzaxTFlQH8zTQFDXgDGFnBSjtjLJ1bLnIfRA1TctiJ6D0Bmv0h9xN15U4U8ovPYrATau9WO78E7imPsRrYHbXHUIJX8KDHQinuFZ8thtbELtxUV8ITdmsxO2YBa+F3FK4feg9UyRIqAvMGPTSt0auo8bW6W6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2ExYSamopuyg1Dkd/S5OCc5hjaOkDlgZ/tYVWT4mSs=;
 b=TJFmsv3VqWPOPrHcfSm5N3xrfbphy7i1J5Q9IFJVVB+n5i2QYGaD5UrOK1UIzWzIh21IMNM7VUG2M13Vw0nJUgWkX4AXqlxfUYYtt2MaKRnZBKsF7Ru/fGg4bDZNIhmrTatRh9d1Lyfq/F21/0m42YgOXjhuZhDIf70k9qC6RJyybuhdKEJu20Cd42L4Thrn2X2/f+b1P1I+TaJig+QZu2ZimDNEFYA70AGNzavxGCgzCzvTxMDmOnWi19rQ8S/8LX5uyhEyI1+rl3KDxHZEiZxe7ld/k0rRKhwVIgO3jHg2tXdiCH/K4E5/v6lsctJii5WL8eiSuHEPfsL6teL4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ExYSamopuyg1Dkd/S5OCc5hjaOkDlgZ/tYVWT4mSs=;
 b=rftG8MGbj1iD2A6lFqA70Nnbvr4rgq3UIi2aQ8Rg+Cp/a2EUmZUTrcy3J1gnTlKOYrLBbp+ldVMgF3P9XllETwTPI88I4OLatvwJaCiUhwaMMS3nzgYY/CJ1cLs+IMPx0d+6lNGOnHsBUFD7OoG/W7J95PrSIJ5iBchDn/s1rqI=
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 05:50:49 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c6) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 05:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:50:48 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 00:50:45 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>,
 <alexander.deucher@amd.com>
CC: <srinath.rao@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu/umsch: add support to capture fw debug log
Date: Wed, 8 May 2024 11:20:26 +0530
Message-ID: <20240508055026.264218-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: c5509dc9-0d6c-4101-35bb-08dc6f22cff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U64hm8LnGjMkFSfqdhVRSsR9wCn3h0QNvbgmTDfobufOqpMrZy5oKTskkYPt?=
 =?us-ascii?Q?epfmY6ncKsskif0VT3lYsQu7oI2qZJKOc8r1l9C0HfLUPnv9rbesfL3cPCAK?=
 =?us-ascii?Q?tH0/7JQV50tVmFfxmi7You0DTB8bZjK53a4jOQddHOZpLhAHDo+7yMXl2iCD?=
 =?us-ascii?Q?o29KJOZwYhOZHW8dmekdNMd53EtqXBZ9xYjCc3EPSUoXNXh7PduymC1E0fPx?=
 =?us-ascii?Q?gcxqNr61gb9y2mPb+tJlpGKnKmb1OPKEycJx4h9fcjv/qJbqKwQngwN1FlnS?=
 =?us-ascii?Q?Nz4LAPTXhR7adg483G86bBZ0nizqzi/OBZQNYvcHb0eBuoQqQtPVDfVn219n?=
 =?us-ascii?Q?WO7RCFwDB7/O/fktQPIWiK6385I1KjVWLuErBvheZ/ayCJL5lcEeM38OMRp2?=
 =?us-ascii?Q?PCXDevqxN7+gLBmkyni8kxvlASrkFOzgoYkqtKceQhZkIoxQJoIO4OV7zy08?=
 =?us-ascii?Q?+xH4io0WAVctQBAYUhGtQ53KbdUzX4Tm2bfFIwKcgBu+6YIgCQp6R/GZxnuc?=
 =?us-ascii?Q?hOfyMeuvO/ZMscq6lemTtPR4iRS8LGTEHxMmxYYinQOKVSeHhXVcRrGYReyn?=
 =?us-ascii?Q?1q38nxD12Sflw4vcG8rGZLFo17ucCAMpFRS/K8zxcKS9dQdm9YzmOElIHaeM?=
 =?us-ascii?Q?xwHyMpP7HJGUI9xUTRFyMSS16JTfKZahnQwqSit/x0uasc8w9sjoeCCZuD6d?=
 =?us-ascii?Q?blTptnRjJN5B8G8m0IQ3YTJ7ePqpYKX+WcWKNuHN3FseRJRG//TTjxBnlUeD?=
 =?us-ascii?Q?+I7Iycvn5vj66dWVYNQLHVJAPT9nd4zYaTXlQfVRzT6QkkM2qPqTueEN3xG6?=
 =?us-ascii?Q?8fjyOkgWNci1GBsSDqTpSQYmWp5a6396fRd1LLW5DFMVIE1x5vWmewgoRMwf?=
 =?us-ascii?Q?LUqt1HkVCnuCIM3irQ8y1FaR2ffd9ddSAmTHJHLQboi0T+bQ2+C+Vlguy7MR?=
 =?us-ascii?Q?lHTy7WMJLhUGZHxpz5l3QHKMOP/7uZH21DRepme1U4AZwGg0pJxduq07ZgJ2?=
 =?us-ascii?Q?/YQh8V5nMUuEEF7UhZ2USQEbujVQHN1z35qZ1/PYkHtDMveE2nuSsekecTY3?=
 =?us-ascii?Q?t7IHxFfWB3BIpSiq9dcqU0f3UtBPWinbTq/VWD+hNych3jjhffWG9hroySLk?=
 =?us-ascii?Q?4ZBBLe8vaSwQwrJZDJbbvUjoXNC8Z1VOUA4v6Kg6H2+c0OSmeUHaL1kCCI61?=
 =?us-ascii?Q?QUhz4hnw7D9I52uNXkI0t1zQZ0apcvIHb2nzKkzq7td3STBWjS/GNNEd9lzk?=
 =?us-ascii?Q?Uf1qa5G7pC9xyGOr9b2O67VxX3b49nEq8TaZopM6Y+fOe4uyROjkwxBhvMBc?=
 =?us-ascii?Q?dTdv+t7QXap1Uj3Oq9wXX4fji9TDBylnY+XGqe2Z31/W72QwTRWL4U1cHdMF?=
 =?us-ascii?Q?SUsd5BA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:50:48.7249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5509dc9-0d6c-4101-35bb-08dc6f22cff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

Added support to capture unsch fw debug logs in debugfs.
To enable set amdgpu_umschfw_log =1 in boot args.

v1 - reame varibale to umsch_mm_fwlog (Veera)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 119 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h |  18 +++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   |   6 +
 6 files changed, 157 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3..a855600b13e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_umsch_mm.h"
 
 #define MAX_GPU_INSTANCE		64
 
@@ -253,10 +254,12 @@ extern int amdgpu_cik_support;
 extern int amdgpu_num_kcq;
 
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
+#define AMDGPU_UMSCHFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
 extern int amdgpu_umsch_mm;
 extern int amdgpu_seamless;
+extern int amdgpu_umsch_mm_fwlog;
 
 extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..82f6d4ccd537 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2185,6 +2185,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_vcn_fwlog_init(adev, i, &adev->vcn.inst[i]);
 	}
 
+	if (amdgpu_umsch_mm & amdgpu_umsch_mm_fwlog)
+		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
+
 	amdgpu_ras_debugfs_create_all(adev);
 	amdgpu_rap_debugfs_init(adev);
 	amdgpu_securedisplay_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..9a32724b989e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -214,6 +214,7 @@ uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
+int amdgpu_umsch_mm_fwlog;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -965,6 +966,13 @@ MODULE_PARM_DESC(umsch_mm,
 	"Enable Multi Media User Mode Scheduler (0 = disabled (default), 1 = enabled)");
 module_param_named(umsch_mm, amdgpu_umsch_mm, int, 0444);
 
+/**
+ * DOC: umsch_mm_fwlog (int)
+ * Enable umschfw log output for debugging, the default is disabled.
+ */
+MODULE_PARM_DESC(umsch_mm_fwlog, "Enable umschfw log(0 = disable (default value), 1 = enable)");
+module_param_named(umsch_mm_fwlog, amdgpu_umsch_mm_fwlog, int, 0444);
+
 /**
  * DOC: smu_pptable_id (int)
  * Used to override pptable id. id = 0 use VBIOS pptable.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 9f9d6a6d5cf3..2d2dddea8770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -23,7 +23,10 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
 #include <drm/drm_exec.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_umsch_mm.h"
@@ -743,6 +746,17 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_UMSCHFW_LOG_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &adev->umsch_mm.dbglog_bo,
+				    &adev->umsch_mm.log_gpu_addr,
+				    &adev->umsch_mm.log_cpu_addr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to allocate umsch debug bo\n", r);
+		return r;
+	}
+
 	mutex_init(&adev->umsch_mm.mutex_hidden);
 
 	umsch_mm_agdb_index_init(adev);
@@ -789,6 +803,7 @@ static int umsch_mm_sw_init(void *handle)
 	if (r)
 		return r;
 
+	amdgpu_umsch_fwlog_init(&adev->umsch_mm);
 	r = umsch_mm_ring_init(&adev->umsch_mm);
 	if (r)
 		return r;
@@ -815,6 +830,10 @@ static int umsch_mm_sw_fini(void *handle)
 			      &adev->umsch_mm.cmd_buf_gpu_addr,
 			      (void **)&adev->umsch_mm.cmd_buf_ptr);
 
+	amdgpu_bo_free_kernel(&adev->umsch_mm.dbglog_bo,
+				    &adev->umsch_mm.log_gpu_addr,
+				    (void **)&adev->umsch_mm.log_cpu_addr);
+
 	amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
 
 	return 0;
@@ -868,6 +887,106 @@ static int umsch_mm_resume(void *handle)
 	return umsch_mm_hw_init(adev);
 }
 
+void amdgpu_umsch_fwlog_init(struct amdgpu_umsch_mm *umsch_mm)
+{
+#if defined(CONFIG_DEBUG_FS)
+	void *fw_log_cpu_addr = umsch_mm->log_cpu_addr;
+	volatile struct amdgpu_umsch_fwlog *log_buf = fw_log_cpu_addr;
+
+	log_buf->header_size = sizeof(struct amdgpu_umsch_fwlog);
+	log_buf->buffer_size = AMDGPU_UMSCHFW_LOG_SIZE;
+	log_buf->rptr = log_buf->header_size;
+	log_buf->wptr = log_buf->header_size;
+	log_buf->wrapped = 0;
+#endif
+}
+
+/*
+ * debugfs for mapping umsch firmware log buffer.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static ssize_t amdgpu_debugfs_umsch_fwlog_read(struct file *f, char __user *buf,
+					     size_t size, loff_t *pos)
+{
+	struct amdgpu_umsch_mm *umsch_mm;
+	void *log_buf;
+	volatile struct amdgpu_umsch_fwlog *plog;
+	unsigned int read_pos, write_pos, available, i, read_bytes = 0;
+	unsigned int read_num[2] = {0};
+
+	umsch_mm = file_inode(f)->i_private;
+	if (!umsch_mm)
+		return -ENODEV;
+
+	if (!umsch_mm->log_cpu_addr)
+		return -EFAULT;
+
+	log_buf = umsch_mm->log_cpu_addr;
+
+	plog = (volatile struct amdgpu_umsch_fwlog *)log_buf;
+	read_pos = plog->rptr;
+	write_pos = plog->wptr;
+
+	if (read_pos > AMDGPU_UMSCHFW_LOG_SIZE || write_pos > AMDGPU_UMSCHFW_LOG_SIZE)
+		return -EFAULT;
+
+	if (!size || (read_pos == write_pos))
+		return 0;
+
+	if (write_pos > read_pos) {
+		available = write_pos - read_pos;
+		read_num[0] = min_t(size_t, size, available);
+	} else {
+		read_num[0] = AMDGPU_UMSCHFW_LOG_SIZE - read_pos;
+		available = read_num[0] + write_pos - plog->header_size;
+		if (size > available)
+			read_num[1] = write_pos - plog->header_size;
+		else if (size > read_num[0])
+			read_num[1] = size - read_num[0];
+		else
+			read_num[0] = size;
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (read_num[i]) {
+			if (read_pos == AMDGPU_UMSCHFW_LOG_SIZE)
+				read_pos = plog->header_size;
+			if (read_num[i] == copy_to_user((buf + read_bytes),
+							(log_buf + read_pos), read_num[i]))
+				return -EFAULT;
+
+			read_bytes += read_num[i];
+			read_pos += read_num[i];
+		}
+	}
+
+	plog->rptr = read_pos;
+	*pos += read_bytes;
+	return read_bytes;
+}
+
+static const struct file_operations amdgpu_debugfs_umschfwlog_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_umsch_fwlog_read,
+	.llseek = default_llseek
+};
+#endif
+
+void amdgpu_debugfs_umsch_fwlog_init(struct amdgpu_device *adev,
+			struct amdgpu_umsch_mm *umsch_mm)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	sprintf(name, "amdgpu_umsch_fwlog");
+	debugfs_create_file_size(name, S_IFREG | 0444, root, umsch_mm,
+				 &amdgpu_debugfs_umschfwlog_fops,
+				 AMDGPU_UMSCHFW_LOG_SIZE);
+#endif
+}
+
 static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs = {
 	.name = "umsch_mm_v4_0",
 	.early_init = umsch_mm_early_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index 5014b5af95fd..2c771a753778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -58,6 +58,14 @@ struct umsch_mm_set_resource_input {
 	};
 };
 
+struct amdgpu_umsch_fwlog {
+	uint32_t rptr;
+	uint32_t wptr;
+	uint32_t buffer_size;
+	uint32_t header_size;
+	uint32_t wrapped;
+};
+
 struct umsch_mm_add_queue_input {
 	uint32_t process_id;
 	uint64_t page_table_base_addr;
@@ -166,6 +174,11 @@ struct amdgpu_umsch_mm {
 	uint32_t			agdb_index[CONTEXT_PRIORITY_NUM_LEVELS];
 
 	struct mutex			mutex_hidden;
+	struct amdgpu_bo		*dbglog_bo;
+	void				*log_cpu_addr;
+	uint64_t			log_gpu_addr;
+	uint32_t			mem_size;
+	uint32_t			log_offset;
 };
 
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws);
@@ -179,6 +192,11 @@ int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch);
 
 int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch);
 
+void amdgpu_debugfs_umsch_fwlog_init(struct amdgpu_device *adev,
+			struct amdgpu_umsch_mm *umsch);
+
+void amdgpu_umsch_fwlog_init(struct amdgpu_umsch_mm *umsch_mm);
+
 #define WREG32_SOC15_UMSCH(reg, value)								\
 	do {											\
 		uint32_t reg_offset = adev->reg_offset[VCN_HWIP][0][reg##_BASE_IDX] + reg;	\
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index bd57896ab85d..2c5e7b0a73f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -24,6 +24,7 @@
 
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/debugfs.h>
 #include "amdgpu.h"
 #include "soc15_common.h"
 #include "soc21.h"
@@ -143,6 +144,11 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 	WREG32_SOC15_UMSCH(regVCN_MES_GP0_LO, 0);
 	WREG32_SOC15_UMSCH(regVCN_MES_GP0_HI, 0);
 
+#if defined(CONFIG_DEBUG_FS)
+	WREG32_SOC15_UMSCH(regVCN_MES_GP0_LO, lower_32_bits(umsch->log_gpu_addr));
+	WREG32_SOC15_UMSCH(regVCN_MES_GP0_HI, upper_32_bits(umsch->log_gpu_addr));
+#endif
+
 	WREG32_SOC15_UMSCH(regVCN_MES_GP1_LO, 0);
 	WREG32_SOC15_UMSCH(regVCN_MES_GP1_HI, 0);
 
-- 
2.25.1

