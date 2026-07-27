Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576B9C53209
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 19:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87D610E455;
	Mon, 27 Jul 2026 19:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B7NSjVtF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4D110E2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 19:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0HfPP30EdGlCkC1cCkRNmRo1ygSBj9QIOB7sDEgfBxkp0FCb7wxvgEn7AKO9o3DSjnt3IJd8RTEEFYGiHNJSqFNLq5yKhuVZp69CArmff1WgTldd+JgvUdLGjlqfz2s2TF3JKZ+dTxYi2bmILoIVzKjmcryeS+6mQIvDN/Ad7CxXdgzSKsctIYffOhPJU630KP9YLdsyuPQvPx+OxL+c7SzN//k+0p3f83RHX6y6cwftuFOqRrs7Pj0nJqVvXoQv+w/zlyxiO1Ite1f49eCivP049POV36culsVj2OGpmBi6RUOIS/1NtZFMb7rC1Ndtfty+FxEbsJ7eOG8rAGglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVzjs8vGoaz5ZeJF9ndzlKuGysIn1AvyqUEpBtQzu7M=;
 b=H5RoNg6umLH1uNs8wYWcD2iTfIUmVGs9lqmhvGeaPQx77UnBMGhT1CWuwRlNMK8hC5hOHmcxUS1uhM/UFHBNj0+nrTDB8qkLx9sziuXCPOFFYYETx2ehgIz9bUFKTsCTFFJyH5ltXAsvoYEjvPFeMpdz8XUzlnjg4SENDsvjp/dKB1P/Q/Kamerc0VRZgy9URxBuB02+b9w4Qw1t6JrbOPcE+mm/LRFK+cvHHi2C8ROqMzsQnycVV7NqLnWfKyC+jwFlOSkVeCQEbhPAIFEmvIRq4BjKBSMFCy1CZNTUPK+DWdKWdimDVVI3QXuoJhzZ5GicIhF7CjyfmPSo4sas+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVzjs8vGoaz5ZeJF9ndzlKuGysIn1AvyqUEpBtQzu7M=;
 b=B7NSjVtFAwhR8iuXcTxopJFVqxdZEPQS9HN6AAhhBIvo/1jFM3PkDVnF3n1TQgKwAjP2qb47KpAeQ2J7tCLfsHNVew6Tk8ss9Ot5uysaRMzlY11Y0QS47jczl46SBxYifbr300ZQjj5G3qd8dyweM6VmvjF2y24N7YAaR/oLg7E=
Received: from MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:39:58 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:23d:cafe::3a) by MN2PR06CA0005.outlook.office365.com
 (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 19:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 19:39:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:39:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Add helper
 svm_range_update_checkpoint_timestamp
Date: Mon, 27 Jul 2026 15:39:29 -0400
Message-ID: <20260727193930.612490-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260727193930.612490-1-Philip.Yang@amd.com>
References: <20260727193930.612490-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1426ef94-4dce-40df-d18a-08deec16d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uKrkeYGFPpm9uU1zmP/Nt/6mJemb02JCM1AoLADVXDHNT0SW2zY2Aw/Zgy7P8BBY/UFBnhw6z0D8DfkzYh1bhef9d+ilCVltLxbm1nxd9Hyd0+EMTO2yK57LpTisXJn9JpE3dPU9VZC64YYbQeaU/yvNBwotGM/d8VGeDpzP6lF1fh5ndXKgUzeeUwoc6ubiug8V2SmMgPG3AlEd3EEWOmbO0MmxjqtxVuMi5e1OZfG5APYR4rCMH7ZNufqZpgPvbbQHs9CTy2ZHIeJ6T2zW48pqFSs/1S9C9fzYZVh2y61crY9jnV26Qih9OSVCos/Ax64FdiVg5IzLkHUAzEWys0sNiOYDoA7RwcWcqMyq+t21T5ZfG+zaoMAwzNsf6vwv1NvgjHKmU9Zr00twMjd8cGyPH6AhSUoGMIS2r7W/qYfNrU3nsCJl17IQRTW5cwkZAXirdXmTzMWOT1mV2xzLO1+fUJ7SAMlGqAeZLvSPBc+Mp3fCQ17yiVmgdiRiQRBJfq/enbWn0bv1i33MKTGx7QPlVuFk/k8P2oALS3lMp6aGsake21DyGOU+ZdETNqv7HbRcXe6ru8+GQX+cF5Cj0CbVnrmUc0lbTsC/oZJas+ohXsT/yrQDSEpL1Rldz9kKHQo8JyDdtrAI1Csn7HwjOp/4S/dgyVxKQ4ld4PyC7YgqW/3wup5QOgwulQOKt8LTlYcpEOj7CPiKRTy12Aq14Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EGbXQHkXdrRo/cSQxk3X4xaXb4CNIT48Q/TLc5++dQ94ZJlDqA4C4qCZWzWvFCyrLWaghsavfFwGSaCrsz563yFt0Te6exCWKzwT/IAPtgHtLvm71fbZZnkyyOuGfu38dvSXcQkDlIuBYcFHRsObQcZsgcXZ4X/vvsdGM1wj+uwUmfYhPeML7SpH0kOfwm6t35mnU+pRRk0u1coV/HFVzjaxk3nZwLUiC9fDfF6csVqGkQhc88xizUdcF3FNhDEC8bicDRy2MOFD88phgm21qPbSNfFtSZzAFesNGHXhvSiJFd7UxYpz8i6KHYABCoQ7cuoEnY9unfFYAdzt8gDi74vffzp9JUyTUt3Mv+taKwFBuAStGA13Bal/NAzCc1Lr4inI9U1pe5YEWiFsLbxza8wZZezix7Zk9Wv2TD4aCNmUjeDEciGlSIhLPdzZcV6a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:39:58.5150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1426ef94-4dce-40df-d18a-08deec16d7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

Extract svm_range_update_checkpoint_timestamp() from
svm_range_unmap_from_cpu(). The next patch calls it when the app sets
the no-access attribute.

Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
svm_range_restore_pages() can read it from the page fault handler
without holding the svms lock.

No functional change, preparation for the next patch.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 83 +++++++++++++++------------
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c1657..bcb929002839 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -895,7 +895,7 @@ struct svm_range_list {
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
-	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 
 	/* Default granularity to use in buffer migration
 	 * and restoration of backing memory while handling
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 30ad10bbd47e..c10d4edc8813 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
 	return 0;
 }
 
+static void svm_range_update_checkpoint_timestamp(struct kfd_process *p)
+{
+	struct svm_range_list *svms;
+	int i;
+
+	svms = &p->svms;
+
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
+	 */
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+
+		/* Check and drain ih1 ring if cam not available */
+		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+			ih = &adev->irq.ih1;
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			if (ih->rptr != checkpoint_wptr) {
+				atomic64_set(&svms->checkpoint_ts[i],
+					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+				continue;
+			}
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr)
+			atomic64_set(&svms->checkpoint_ts[i],
+				     amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+	}
+}
+
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
@@ -2556,7 +2598,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
-	uint32_t i;
 
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
@@ -2576,38 +2617,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* calculate time stamps that are used to decide which page faults need be
-	 * dropped or handled before unmap pages from gpu vm
-	 */
-	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
-		struct kfd_process_device *pdd;
-		struct amdgpu_device *adev;
-		struct amdgpu_ih_ring *ih;
-		uint32_t checkpoint_wptr;
-
-		pdd = p->pdds[i];
-		if (!pdd)
-			continue;
-
-		adev = pdd->dev->adev;
-
-		/* Check and drain ih1 ring if cam not available */
-		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
-			ih = &adev->irq.ih1;
-			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-			if (ih->rptr != checkpoint_wptr) {
-				svms->checkpoint_ts[i] =
-					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-				continue;
-			}
-		}
-
-		/* check if dev->irq.ih_soft is not empty */
-		ih = &adev->irq.ih_soft;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr)
-			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-	}
+	svm_range_update_checkpoint_timestamp(p);
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -3117,8 +3127,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_lock(&svms->lock);
 
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+	if (atomic64_read(&svms->checkpoint_ts[gpuidx]) != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,
+		    atomic64_read(&svms->checkpoint_ts[gpuidx]))) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			if (write_locked)
 				mmap_write_downgrade(mm);
@@ -3128,7 +3139,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
 			 * to zero to avoid following ts wrap around give wrong comparing
 			 */
-			svms->checkpoint_ts[gpuidx] = 0;
+			atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
 		}
 	}
 
-- 
2.50.1

