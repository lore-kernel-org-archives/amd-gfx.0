Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77B606A31C
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Nov 2026 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L/5b54TB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F4C112E5E;
	Sat, 28 Nov 2026 01:14:15 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A7C112E5E
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Nov 2026 01:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn6savi2MMicJhIO4CC6PqV50WHf46blf5wjkCUNVYB4Y1lxVdPhTMynyhxfP9lWTVtkPNYvY6CBuoW6fWmwoahNDDeWZlTxzBPG/1ooCKYn4TrKFEBwCeqFB7/a2PDjLswnbxiaqQEYeAIzOyrei7I+KhyhKT9JEmdgBH+WGmqF0PK6MCcgUV5HQJ/pNmtvtM/Vicsevksh+NURppYb2IK5hqeYUV5Cpj7Sr9XXqW1PhKkMxKOrAU03qutHq9le0ZqZy4Y9/2zL01+ZKKDxRVqyim9cVSUnl9eT/+6Rk/AlhrdclBWg1/jy3ewT2YWVZkcsFZfJ3xc3mutvhEZvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=remb/ejmc4gAQj0N9ENJyc3Bmyqa97igNJV8J0xMBBM=;
 b=l9Pew2twByX7+XQEXTZGQP6+xeQ6y5O13ov7TcV6VlAFlQrAcnp/PI4+XSiHa1Ix1Wk+7mf9MwRqOHfydrHUmjxGsqAfK6eE781EW7lOlH0GWrGDewRi01sLuxidK8/MJXwhTDS7piWC7hrnlwMKlzve6g+U3QHA0gkPvCSzV+ihIpUEEwjUQh/D2UTK4i/RFnoTY6by0J/HBDlFtio38lYxXi1jSERAA8J36iZzV3BcEfpXA/NJPou3RkE6E4ounrmfYCgvWCrOcfxSg5aEye8L1ely8K7zpLcLvuwvcwJunPhtuek1aHgNd3GAFC3OcHPLoRz1zPdLUeb/JSovXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=remb/ejmc4gAQj0N9ENJyc3Bmyqa97igNJV8J0xMBBM=;
 b=L/5b54TBhDNLeVwaPw4zBXUtPhpliXwcqBI9FJAC+XsftFyYEAzOtKn0i4WdiAZG05MMUlA4E1EhuOCgMKjQZIirishpF5rF4XQMnmOPkG1IFB0UB8N1rP+2cB+yc/N7dEFj6jKT6TpvdQ/RgxuR+VvcHI9kmRjGq0l5jffPPqc=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Sat, 28 Nov
 2026 01:14:02 +0000
Received: from CH2PEPF00016D48.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::c) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Sat,
 28 Nov 2026 01:14:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00016D48.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Sat, 28 Nov 2026 01:14:01 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 19:14:00 -0600
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: refuse XNACK for a secondary context
Date: Fri, 27 Nov 2026 20:13:45 -0500
Message-ID: <20261128011345.1116041-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00016D48:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 597f4d67-5a50-445d-27b1-08df4cece2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|18092099006|261022075727099003|261021121427099003|56012099006|11063799006|261028144727099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261022115727099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: joDtIrm6CCLh17lzMpTIsUrNX53rgGhmYGwK9lpfvogaJf8tnV4xzCbQ0pxSn8zC5NHfv5clV9DI4nTe6uDYexEh74G6TQ/pYTeeLklSIW/iuoRc8GYoZJCuamGhpbzllfObJAKI5frokETXaxADbbOX6ratXj7rbKEJ1t72qNcGMB0SSya6L7P+g6vvxEUisneqfgGOH+yR6w9PZ95v6ue48YelxGcXtxgTYwSrzIZLeXFhZ3GqdAvBaxnN9Oq+5MLXfC3NuP1n4UNyacgbwrNBY7qjNxGDIqt1V18Mp1rO6ON4yIGOUFphBcz3rawjRktyfQhbvRBEBCxy0JpmN7Co0KF0fJ3juW7wqPEO8sahEzZK4WJY7epZp+ufI2q04WSCjwyseDAvA/sCuZBQwFAN5AIOFgsQxs9EbBwfpiL6D7YtaAvwSLXOE9H9A9IcMpTT7pNt8nTExxk09+Jniltpc2qHtEXCWNMx13uRJRM0EMrFZmH1lCO0iApkOSVrRiFW/TRSeGVTJ92WOfzkP2JoHDQXdcsAw5dRLurUhfGaYgGWVzJ7y29WSBJ0uLSxo80RVEzKimvtCQe/OYa9d/od7ceuiG0jX7VS1vjT/tkkq62/th+TYDpsIKCJsypd1MMbpDwgC/oq2pgSqmxDK+UXn+FwEF9Ip1K7mrL1jI6E7QkeD0HE6oIkwyDlRpgDn04uGtTKQcoJROPGTQg6LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(18092099006)(261022075727099003)(261021121427099003)(56012099006)(11063799006)(261028144727099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022115727099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j3qpiLfUPPt61SsD5OrHacm6IAqzfPMXDtjCtVlDpi0nWqMkeKv11z0gPZpn3MSb6RvkHi2jKi/t8lrj+7v6nXzSyNm0EwRJOIN75g6+mkjaF5W809UE9KMa+5HXL1+OE32gDVMuMMv2eFDl2Cz1SRVUAXwbRhP8NHCGKEK+BE0Tnz1ONxAWSgHfSuIiKT2mrUzov3TCMxePpgH4PyYt7pYNsKj4Lq6pdP2TPxtOeqVarwdNjxAJXiy6VnryH5zJ6xvPbEO6CyU0DMpuHMNcE9VkG/flJQcxodBHuIC0y8giKpJFrEPaK7Xel4BN1xGugdtPkKknY2SZzT1gZjkogDpanKDZUxIBJzkUSsuMARtgyGmDlUH0LaWgvYnKjnfsvIwN4+2k4VTBvJAuUNrOz6CxbZ2ZzpEwlirS7wMS+o9AhDlRmtdnx7d+fjcPWXSb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 01:14:01.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597f4d67-5a50-445d-27b1-08df4cece2f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00016D48.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A secondary kfd_process shares the caller's mm but registers no MMU
notifier and is not torn down when that mm exits. With XNACK enabled,
svm_range_restore_pages() still maps host pages for its PASID, and the
queue keeps those mappings after the pages are freed.

On an unpatched gfx942 kernel, a shader on the secondary context stored
to an unmapped malloc buffer, the process exec'd while that /dev/kfd fd
stayed open, and the GPU then wrote 0x5a5a5a5a into 64 KiB of memory
owned by the new image.

Do not enable XNACK for a non-primary context, reject
AMDKFD_IOC_SET_XNACK_MODE that asks for it, and drop a retry fault that
arrives for one before any host page is mapped.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  8 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 10 ++++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ae5b430a00310..38ece99f70db9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1775,7 +1775,9 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 		if (p->xnack_enabled == args->xnack_enabled)
 			goto out_unlock;
 
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
+		if (args->xnack_enabled &&
+		    (p->context_id != KFD_CONTEXT_ID_PRIMARY ||
+		     !kfd_process_xnack_mode(p, true))) {
 			r = -EPERM;
 			goto out_unlock;
 		}
@@ -2369,14 +2371,15 @@ static int criu_restore_process(struct kfd_process *p,
 	}
 
 	pr_debug("Setting XNACK mode\n");
-	if (process_priv.xnack_mode && !kfd_process_xnack_mode(p, true)) {
+	if (process_priv.xnack_mode &&
+	    (p->context_id != KFD_CONTEXT_ID_PRIMARY ||
+	     !kfd_process_xnack_mode(p, true))) {
 		pr_err("xnack mode cannot be set\n");
 		ret = -EPERM;
 		goto exit;
-	} else {
-		pr_debug("set xnack mode: %d\n", process_priv.xnack_mode);
-		p->xnack_enabled = process_priv.xnack_mode;
 	}
+	pr_debug("set xnack mode: %d\n", process_priv.xnack_mode);
+	p->xnack_enabled = process_priv.xnack_mode;
 
 exit:
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5dc657f32d38c..0c153f9951b38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1782,8 +1782,12 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	if (err != 0)
 		goto err_init_apertures;
 
-	/* Check XNACK support after PDDs are created in kfd_init_apertures */
-	process->xnack_enabled = kfd_process_xnack_mode(process, false);
+	/* Check XNACK support after PDDs are created in kfd_init_apertures.
+	 * Only a primary context is torn down with its address space (it owns
+	 * the MMU notifier), so XNACK retry faults must never map host pages
+	 * into a secondary context.
+	 */
+	process->xnack_enabled = primary && kfd_process_xnack_mode(process, false);
 
 	err = svm_range_list_init(process);
 	if (err)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 32f2ca5b1fdfd..f48eea7cc9e92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3158,6 +3158,16 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 	svms = &p->svms;
 
+	/* A secondary context has no MMU notifier and is not torn down with
+	 * its address space, so it must never map host pages on a retry fault.
+	 */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("retry fault on non-primary kfd process, pasid 0x%x\n",
+			 pasid);
+		r = -EFAULT;
+		goto out;
+	}
+
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
 	if (atomic_read(&svms->drain_pagefaults)) {
-- 
2.43.0

