Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25989606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C8m9VacS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B373D10E0E1;
	Mon, 16 Nov 2026 19:12:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB77310E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLWRWCO6P7nbf/uspDt4ErMcIMDB75IyJsuoRX6gflJ3m/rEZ1345QTFO6IMa9n5a+buvK0lGCFCuncj/TTMIHFIaneLzEEgkVYhMAGX0zsbDbhgkpSACm0x9Majj00nT0XOLiTkotqHAZnLWYtzRhGllHWsZ7PwzJ87PXEhVEunJjN7jT+V9H/6mJGhei/9xhMdlJtqHRIzU6H3kKxLjX7RJBxMzN5RS5r8jrafsK1W+j6xGPm/ckPKsY6VmDY50+Z003D/uesFPdBvd089ZGfAJMFePmD6BOlIGw6iHceaV5wdyAFI+bOAAN4AXKhG7/sLFvbCFvndb/IHN9LjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6TePPHnhfy7Irlhp6dVkXjH4XvURYFjbUTFrrQi480=;
 b=M1D2NVLi7BsQpG+8kTZLJ+QhTIRGKmEvnHragQRTKsYfAKYCXwW3VBmBX/T1PE3TYa3R3kJfBQPHMC3t1Mj4LUnOuxiu8ZfIUj3PMq8bmQqwDYlVFCjsDeCYVc5VaZ1+lSTkGzAW/NcJKZCRw8OY51QEvKPGjtJ8SpqVpqrHJDMJU4XnY1U2oie+voethEOBqjhiUaHDQEbD0Ct0lguts9OhKQdzBhGM0PpWpPSBAqFF/mi1V1TulNzX4KVg3wCaSXPiaRyq/ullcuRblvw6PbRUgk7h6HOGM7C2BndoiZGq8q+j8PEsRRUzMgGTA0RFqcpfUJwbC6p2D6lDvkRT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6TePPHnhfy7Irlhp6dVkXjH4XvURYFjbUTFrrQi480=;
 b=C8m9VacScTPixSyRJ4CLS2/nnNOBiUqTTugrZkCskIDTmM49nuUqY8BmU6RExAZh9b3y+eqS5rGZM+Xv7oQBkO/au66z15GKa7SA3dRXGbOvyG9+aniXX3YrYxURZGOg+OfZD1iCJL9ESB22CjKmZP/r5l2FnmpO6FnCM/hn8iU=
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:11:55 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::39) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:11:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:11:54 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:11:54 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
Date: Mon, 16 Nov 2026 14:11:41 -0500
Message-ID: <20261116191141.145348-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 6482291f-ebcc-4b45-d404-08df44157a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: le9cTPQEVDTVdMvL97TJUdTIoB+4vHqPdntrmqLXzeKtWZk01IpuY61PvotGbjSLoYfUMw044LWKsmp0zbrSzmD6ephoYJSiAevuBXFma5y3+2YojF0JZmxxmMV+jNG8K+BKwM3N2meYKFBRp5mPo5NIYjQ9JPfaUFkNYG6HEn6GOO+N7TUAM9cxVQ2DqmU1wgdaZEnWqP7q39AUo0ylBcCUE+CbN9eV23A/wbAmROnGakh1+u8Tc5nnwfLi9uaZK1/8hDvnHck2pzW966Ylfx+DqLZxiNM2Os4ZME09QQrGmaSZ3o33++o3jd6HTKsuS+OgcOvPzDbgU7h2H5cRJ+a1QoSM/dwPEgKUV3N+rn9RPacObf76iX+N6UWJ3aio5rFD5NrsnVBE6PGoE8frDb/63EHOkRL2s2qLQVFE4eWXPrObKsDG63e9Z7h1ngBbozMr6iP4FOkplXfIK09OaeEAaSAZCrwrtImddbO+zFwtzSDgT9pl8KeFSioQsNY5rQq8KCMpGV6pP/XljoOZi+C0NVLUHQXKGYlujAz8vxloMtY8aCZ+0i9ihnC2L489mzq0EzpPXPunZD6kZ0TOJ+3wF3l4VjmVrGscy2Gh/p/zmwBb9xyDwvqaton1osqLzrOXrvOgDMyNPv/DJqxEr75xMUv9hGioJX7zjp9ZKXXP4xN/LaVXRj5rPYZGwpSlf4TiG3JSqTwzbDhqoc36GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sdtQ/GCu9ouKssv9sNU8EabQpcAYxTd+1uwqA16BoNfTR77josPPrnqRuKghgeIIbQKQdmUa0sPabUjPztvT2EMsVjuKOCDvztKuwpCO/HmOzNSe9OFNfdXb09bLB0CvgTEDrOA8TVoLhVMpPf1+I/ETBuJRWLMyJ8ICv2GhQ0NV1CU+4kJWPSqKkDiWds+O8uvHdMMSDY/RJDCYUf2hu29VSREfJgYZ9/YMykVXrVVk4kfrmBa/vu42f9SxWZAkRdtToLy5HOLlQQ/tYOOpG6WKpEBsq5JJPcFWWsa0ImrZlmsl2wUjg0L9qQQB+oX/PK8kLjgUQkfUVlA5xuV8XrMLP/3mxPt7psjSOsCO9DubhahT3fTbX/EQqbh0W6BgHvXoUx45RpE51c4j3pG3hx+HK/t/KlDgTKE1oUzAozCj5e2IV2T7qSuugrzrjdLN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:11:54.5693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6482291f-ebcc-4b45-d404-08df44157a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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

This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		gmc->noretry = 1;
 	else
 		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
+
+	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
+	if (gc_ver == IP_VERSION(12, 1, 0)) {
+		if (amdgpu_noretry == 0)
+			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
+		gmc->noretry = 1;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c04..034cc3fd07f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
 {
 	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
 
-	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
-		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	/* XNACK cannot be enabled for GFX12.1 */
+	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 	return sh_mem_config;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..3b62b9e5ecda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 
 	mutex_lock(&p->mutex);
 	if (args->xnack_enabled >= 0) {
+		int i;
+
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
 			r = -EBUSY;
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 			goto out_unlock;
 		}
 
+		/* XNACK cannot be enabled for gfx12.1 */
+		for (i = 0; i < p->n_pdds; i++) {
+			struct kfd_node *dev = p->pdds[i]->dev;
+
+			if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) {
+				r = -EPERM;
+				goto out_unlock;
+			}
+		}
+
 		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *adev = dqm->dev->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	bool xnack_enabled;
 
 	pdd = qpd_to_pdd(qpd);
 	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 		qpd->sh_mem_ape1_base = 0;
 	}
 
-	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
-			pdd->process->xnack_enabled :
-			!pdd->dev->kfd->noretry;
-
-	if (!xnack_enabled) {
-		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		qpd->vm_cntx_cntl &=
-			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	} else {
-		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
-		qpd->vm_cntx_cntl |=
-			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	}
+	/* XNACK cannot be enabled for gfx12.1 */
+	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	qpd->vm_cntx_cntl &=
+		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
 
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59a..059e22cd7f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		    KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
 			return false;
 
+		/* XNACK cannot be enabled on GFX12.1 . While dev->kfd->noretry
+		 * should propagate this requirement, adding it explicitly here
+		 * will help cover any possible future reworks
+		 */
+		if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
+			return false;
+
 		if (dev->kfd->noretry)
 			return false;
 	}
-- 
2.43.0

