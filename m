Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5867C10E209;
	Fri, 14 Jan 2022 20:33:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690F610E207
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnkTa4UDtFmTv1tjprBb8oRJ5NOLfcURepi/mLFP5w/SRFUvhR2E4AMPb4Ju0TBjyKvBXqJ0G0E1q6hx+Et2xhi0O5DNBtUZkfK8f4L0K7WgiESbzfP1XUAsPERbBFKUjiyC3rco+X5sJvBaj/1FyXx9/mda1fnK66vKldbFIjHyGN+FF2VGmLjWd/VQIWqoCdCEvEX+5szsXw9wAsZ0ci0v07sGMZ94CjBonxgH5pztKAiwovYP4ZnXmmc/opWjuwyxH0uPB2hCAVSu4r3agpoYnrF6B7jsSYScr5C/LdU4tzURUNOOC8LZd1aEnouQl+RAZTJ3g7/HP9v59P1IJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QabtFjr/i67fouaW051aBdOrcPt/aM5d0PMKYVwaF3o=;
 b=V3mZl4/KRZH66aI08t5pZPdP0X+1aZdewAoSxmeSZTlVxZY0RKEyHtPujXy7K+Mnq5nHV3lOkwlQGbp0jItiSka4fFAzQIeGqQeaLR7r2iAR+LfaYb1tubb3Z3bUvMMldcYMcy3arEAgVVpA7laaJU8c+kIzABLHZi6Xzv6r2iG16Cvmq/AEk4fdCeuv9GulO4UlKT35YtsGgqUHywl+Jt92gq1MVes/RP7PIQdQB8zLExmdv7rOKl0LCCDD6IKgZk1/ghTTGPRm6roIzUwiOxkbx+Ru+UdifOnS3Z0ePZ6uCpN7x7QqiQb/APsSXI+Jv1KeD5R90oBBpWNhl3Z6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QabtFjr/i67fouaW051aBdOrcPt/aM5d0PMKYVwaF3o=;
 b=UlIDvNCN+YFCjd5b7xOb6rjyIDn4XU/nXpoF8ePJ48fvESnzqnrV4GOJDTMTF7r7q15QC68VDjtJ/PvkkJ9wV0aBRwCRX+Fh9h8k3dzLaL/K3pS2+6W7ztE3dnt7LnJBNFpJeGFJ79fXrahBDskx0EYKMvGRQ2lLJQAMGG3wDxo=
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 20:33:23 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::53) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: add page fault SMI event
Date: Fri, 14 Jan 2022 15:32:55 -0500
Message-ID: <20220114203256.19821-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
References: <20220114203256.19821-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0563a0cb-b20a-4bfd-35fc-08d9d79d1c16
X-MS-TrafficTypeDiagnostic: DM6PR12MB3897:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3897BDAA00E22831741D1FC4E6549@DM6PR12MB3897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZZQrD9mGZrC1BdQceRPRieF48QADsChnc+yue1GGb8a38JTNLxsQj2GcrKk4dcYx1EZlZttVJqMxrjstOfSljpQdp3E8hPYT5Vm5cMoW12wc0dV57cHDg7caG/zqs95W7Z83j4rt/tsYiF69T9D9ngs5G6ZEhqn6Po0EZcULhjYKvWgxlf2VqA4O78IJVuntpYlEt3+cTM9bDKUoFHutqjOaoqgA/nv+VzsJ3xxi8L8084j93p4zwBWyiZ7JcJ1wduoi7gNm8/ltbWcOzHUD+fely19zeakxyuB79kTv8wjzJEuIYdKuMFhI9d6QSA6AqJcNixC4QhH2RY3aMQOXmpbDPGpStczqeLd2r9WPzEODp+aHDFAWafOjkcl0+0c9DT1zmBkpD9OIIMp6nC2YnnMq/08XoibxQeNMlWi3y4xhYsIxLzO4WWMbXpV0d0hi+KAuG8MmQukG8YIasJ50qQwFPElZ9h6GN1qI5jbmICDVULhaR+ckRmHtTs6QIagjK+plJT1u+lO4z3IAhxuYiBOM3aM5slxQgBzkjPChq8yUrQaubg7KFnVBdRrtNG0nkJfdPFNfGICO20A6I8po/MmOrSql2d6MAX3Pts/KNrqUq3DwvNkz6tFOjPqGGjehKaQvUKOIPeqc6nSa1HKvN3F6JYbcC1je0q2uPIGBT+IH15zIvki7TrDQmssshLkezRQGmxW2Mu1PLgJsIF2t/uqtoxFg8VFn9e8s/esMKTXxlN5XoHLvL+YxKAhiqBeEigCEDPn14zg7hbrkmyU6BRkJRyBFFL7Cn4JuhpjaBs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(82310400004)(6916009)(47076005)(2616005)(40460700001)(70586007)(356005)(4326008)(54906003)(70206006)(426003)(7696005)(336012)(508600001)(6666004)(2906002)(83380400001)(316002)(8676002)(81166007)(186003)(1076003)(36756003)(16526019)(86362001)(8936002)(26005)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:23.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0563a0cb-b20a-4bfd-35fc-08d9d79d1c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After GPU page fault is recovered, output timestamp when fault is
received, duration to recover the fault, if migration or only
GPU page table is updated, fault address, read or write fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 41 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 12 ++++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 5818ea8ad4ce..6ed3d85348d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -265,6 +265,47 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	add_event_to_kfifo(task_info.pid, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
+static bool kfd_smi_event_pid_duration(struct kfd_dev *dev, uint16_t pasid,
+				       pid_t *pid, uint64_t ts,
+				       uint64_t *duration)
+{
+	struct amdgpu_task_info task_info = {0};
+
+	if (list_empty(&dev->smi_clients))
+		return false;
+
+	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
+	if (!task_info.pid) {
+		pr_debug("task is gone\n");
+		return false;
+	}
+	if (pid)
+		*pid = task_info.pid;
+	if (duration)
+		*duration = ktime_get_ns() - ts;
+	return true;
+}
+
+void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
+			      unsigned long address, bool migration,
+			      bool write_fault, uint64_t ts)
+{
+	char fifo_in[128];
+	uint64_t duration;
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_pid_duration(dev, pasid, &pid, ts, &duration))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%d ts=%lld duration=%lld"
+		       " pid=%d pfn=0x%lx write=%d migration=%d\n",
+		       KFD_SMI_EVENT_PAGE_FAULT, ts, duration, pid, address,
+		       write_fault, migration);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT, fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index bffd0c32b060..fa3a8fdad69f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -28,5 +28,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
+void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
+			      unsigned long address, bool migration,
+			      bool write_fault, uint64_t ts);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 37b3191615b6..b81667162dc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -2657,11 +2658,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
-	uint64_t timestamp;
+	uint64_t timestamp = ktime_get_ns();
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
+	bool migration = false;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2737,9 +2739,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
-	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
+	if ((ktime_to_us(timestamp) -  prange->validate_timestamp) <
+	    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
 		r = 0;
@@ -2776,6 +2778,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 prange->actual_loc);
 
 	if (prange->actual_loc != best_loc) {
+		migration = true;
 		if (best_loc) {
 			r = svm_migrate_to_vram(prange, best_loc, mm);
 			if (r) {
@@ -2804,6 +2807,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
 
+	kfd_smi_event_page_fault(adev->kfd.dev, p->pasid, addr, migration,
+				 write_fault, timestamp);
+
 out_unlock_range:
 	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
-- 
2.17.1

