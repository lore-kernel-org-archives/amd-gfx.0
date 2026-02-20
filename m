Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81056C5AD68
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3E110E370;
	Fri, 20 Feb 2026 19:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIDNvljH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1680810E36C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag2E9kcp6S+425Be12zHL/CfdYd/svl3rao4eJradPNgp0KMM+zelAQmWzPtNsUHkhIVySGtMvUoueemFU8CPWnYsOVJq0SYMkWPhNHolGDJnY3OPnuW/olRwQjSjIEWDmEKRwuENXEii54YDLYxaUUtibWBYcz0ZAyniSnjzEDQuiW87Y/e9P9jxdM25r6j4/QubFogn2yn3vZ3aXPJ6Hd14nn95Ou+EJPYab4scL3mMgPT0MgFG+nIwBAD2S6rTyfbQWFvFVLrclFfiap7icqrJnX+4svNvg6PtaUPT2KvRsVVXjDsErqQZAHePOeuLqyrnOWjVsqnRNca9G6zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM/TuBCu1ETPQuJKHV71jJ3cPP1vLhGNSo5Bevd0q30=;
 b=hbVN+92LiPP9qySYNycpDUgxgfEz4jT95C/uR6qCGGiYQHDN+7u6m4gy7v9LTiUSDLsE5E054+/KkoVUh7FLyeH89o9Mn2PHCPL9hnFbfX+6TgP8Vjt3htgRIj80NSZBuzYaqmbIyCXPVCyrG1YBBMaHHZzcOnxHGPHZALz28x18LkdkhGMf/5EYitSsG268nOQlULjVh0m4cGAMz1EG3cmRGIIuFgYKtdfHZBnTKa22zFWqPQCcsrOZWGpvzkhJ16zzL9zfsTDODl7ug/cw9pac4cFFa5vXyEwD6d+tm39rM09rn5k/N0ekVtBYbNqwm28wDH8U0FvYLDGTTePLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM/TuBCu1ETPQuJKHV71jJ3cPP1vLhGNSo5Bevd0q30=;
 b=hIDNvljHkLmUdXOxUZ8oDFOKi63uMfWmicR64APEU3dIdHeO/kgA9ybZto0hHIdBcbp3QykI3uWjHsIUJK+wWeIhY/pDcmefuD6yicfrlUhR+f+Elj5uMjrbOfOz4tjZx5IpqSWtkR84a/PrZEAOI8T5kx5IdFxqXRntjfW26S4=
Received: from PH1PEPF0001330A.namprd07.prod.outlook.com (2603:10b6:518:1::19)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 19:22:55 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF0001330A.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:22:54 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:52 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 03/17] drm/amdgpu: add profiler manager initialization and
 release
Date: Fri, 20 Feb 2026 14:22:22 -0500
Message-ID: <20260220192236.3121556-3-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 437ddd02-ff7b-4587-051c-08de70b57271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFXubR9+h93hqLHJ2lowP40ZEVP8xpMOaLeDw3MXGi3hm15wIT0AikUhywWV?=
 =?us-ascii?Q?FhR4bzaeMWrBwf3bdRY+zBpmRlU9PTF86h1wkWjmWLjTtiPUGExqgYOloE7a?=
 =?us-ascii?Q?MQ+foQHVOn6SB+0vcuPe26yTZhsVKrTkOybLlkezkcX9Ll3SkHVa2jLDVRCb?=
 =?us-ascii?Q?b0ayaDbXJkxi282aEp4XFYEtIei8UlSB7Emxk4YP6ZJz04B8pBUNCTyrOWTc?=
 =?us-ascii?Q?8IEKFqGo1Ma+viqg6//bv/bbm+PLjrXL/Njt0AoX8EIB4KMTwZ9oBEREZ2ll?=
 =?us-ascii?Q?Q9V58RUokmSKLjYHG0M1079mHSd9zjNqVBisGbTy8StJHLHnD4vgOux9zmgd?=
 =?us-ascii?Q?Xp2vvgAAe1bPa4cBhdvC5/BBnwPQjSD62JSYqgTHqUg4dcwWSBdodUBzeUDz?=
 =?us-ascii?Q?n10/tL4CCZosoYI6bNQP7+Pcy/XT4CrRXitN4CnCCQhzsyczwwWOQ9sMCaYx?=
 =?us-ascii?Q?nZR8ot+5kcARFXDA23BLJTMnYTJncPGIVoAVcPN+LKhlakjysiyZOHZormu+?=
 =?us-ascii?Q?g6Rp8ktSZacg0J8fT5/bSKQZwb/uKNCnceyoNriNZ7rwb9bmAePzcBBHV0bT?=
 =?us-ascii?Q?b3z5dFK3CJ5lXwhmFHGXbAiCk3mPv3J+92nsGhza+zPsT49a7XCPyAPnBWEx?=
 =?us-ascii?Q?dTtK0LZ1D70gdE39tnelvqRKuhgdZpWJ++IEDc+s6G0cynh3vA4LAaxv3zZ4?=
 =?us-ascii?Q?c8Ezg2YA/2ZCDw4VN3ruf/Pl2eJ3onepBrELa7fhGycACEzOsLm/xziYIkYV?=
 =?us-ascii?Q?25WDh/MDEKv/Ml2pv2APiZxA8rvGu69V57ALjJRGW7TMBDKnNmAx54Zotz0Y?=
 =?us-ascii?Q?NdDABVS4EWYapXOwNLjGyh9U0ypnCiLZwMhgJFtpTkN1M6jU0dgguUGjnzmq?=
 =?us-ascii?Q?2HW+asmbWqOoI0t+veRE3O8v6M+ZmxJdpCFMGvoXuNgANGSZb8rKkX43pSIp?=
 =?us-ascii?Q?C8GqXwU+nPGh0qs/YAp2XSRrSEZyPpFIYKpY2hWsl5V8Nfe0yeyj9QwGRxOd?=
 =?us-ascii?Q?2nc6Ec/Ut5Nq9qvJVdYuQwf4aw6EgkqufKrxdVBmJ2JFR3MPnVMcFQA4cRAm?=
 =?us-ascii?Q?J1F22VvJECwehHwtjAiSVwmoLiSkHRjmhZmeuqu1k/yRMnHaBEWEdwdXuBcs?=
 =?us-ascii?Q?xz86gj+3LAFRcVXzizjASO9pzk4X2bEIVdgWHG95XbTiw0Lbmn7mJUkE+cIA?=
 =?us-ascii?Q?ziIhN11Pwbf+00/hV2d3JCSlAk6/1VtxpDTOnPl7DvU3ycOk/PQyKkAUz4II?=
 =?us-ascii?Q?v2FH28PfIUTGpSvKlK32rJYWPF6MBr4xBTijEDE0qYtHjmJla3YFGlq+1SnL?=
 =?us-ascii?Q?uk6fC30sG4jZAYY96HecEhx9Ws3iTNGZmGrhpEkaLsbtvVhRAVRuyCDnEucs?=
 =?us-ascii?Q?GpfH5ZP9VrMF5W0wSRXw3LzmIIAjs/F5mWehVCQlpqFasK2xkMoSegDzocYQ?=
 =?us-ascii?Q?QxjfRG0GqKGDByIZM6CbJigNlQ5kZO248RnlkDhvGhcIJO6kpUniYcZankeC?=
 =?us-ascii?Q?SMeHRtQp6/sPa24ySmlYk9B/Al8pmFLRoBYtdczpAOPR+AZqtSiQKO2d4Ice?=
 =?us-ascii?Q?Z8vOGn26h940a2hBcW1rHnF1xYZkJeN93L/1OYZ6EmM1gmcHs+kGm+/IXwou?=
 =?us-ascii?Q?25b7EiG9iNi8xs6ubI9zvERLsuHbNd63KHvBa44yygdLccOUDate2RkwZi0v?=
 =?us-ascii?Q?mpQALw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WysQQqZjxHKoaCvgEs2Jn3YEwh1+UzYWVBC9l/NDBWnFeA0s82xNRZZTy3Sz4jx/T2mKkrcOZlkSi9BHhUYOSTIKqx0doCHmvEJ8l/PQ+75EcGrOZ6957+Ds9SuXet8WH6Gw0vx2zE8YzK1bZqiyc3JlSVQjY/I6UI8/I8wCfqJWAxQb9FGd01X8zL8vV9WK18QVvg+FD5fjoQ9wZYVAoeOoaQE/ohTf5f3hoeM6fDFE9ir/LpoiSdM+q/CWWQV8XZyivWyzSPLKXzcxwwVXrnf1Y67Y61nAyKNlFKmFPZ4A/X8tJNWRvJvC50d2Fs1k4azKAgmb0rksyeIDNeYhLaUoV+n004/hFqqxCbzbxgcUxcF/EamVJC3Aq6S3U+NjEPOMC8U7vS+PX8xtlMb6AmJeAB2Go49zjJIRPZkfiOfgbvqB9Z5TFkAoQhhBQ/+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:22:54.3717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437ddd02-ff7b-4587-051c-08de70b57271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
 drivers/gpu/drm/amd/amdgpu/Makefile          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 89 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 51 +++++++++++
 7 files changed, 151 insertions(+), 1 deletion(-)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 962380af4ee9..e96333efbcf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4557,6 +4557,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	mutex_init(&adev->prof_mgr.mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cee90f9e58a9..ed58931de804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2936,6 +2936,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_profiler_mgr_fini(fpriv_to_prof_mgr(fpriv), fpriv);
 		drm_dev_exit(idx);
 	}
 
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
index 000000000000..98c04ab01132
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,89 @@
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
+	mutex_lock(&prof_mgr->mutex);
+
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (prof_xcp_mgr->is_init) {
+		kref_get(&prof_xcp_mgr->ref);
+		mutex_unlock(&prof_mgr->mutex);
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
+	mutex_unlock(&prof_mgr->mutex);
+	return 0;
+}
+
+static void amdgpu_profiler_mgr_release(struct kref *ref)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
+		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
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
+	mutex_lock(&prof_mgr->mutex);
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (prof_xcp_mgr->is_init)
+		kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
+	mutex_unlock(&prof_mgr->mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..3f4d969ea0ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,51 @@
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
+#define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
+#define fpriv_to_prof_mgr(fpriv) (&fpriv->userq_mgr.adev->prof_mgr)
+#define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
+
+struct amdgpu_profiler_xcp_mgr {
+	struct mutex                   mutex;
+	uint32_t                       xcp_id;
+	bool                           is_init;
+	struct kref                    ref;
+};
+
+struct amdgpu_profiler_mgr {
+	struct mutex                   mutex;
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
-- 
2.34.1

