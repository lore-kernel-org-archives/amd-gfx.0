Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1537FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F610E225;
	Fri, 14 Jan 2022 20:39:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E03710E21A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PblrffQZt56pGuGgzTszVgXHjcGBV7Lqm7rq3g4hQDSOAX50bkeAPnc/79E3yR5dlG3i2cnibSLTJsDtOHh0AEARGrzm+OD/CddtyEzKVLB9Bz+VR2Ha64TDZ6y+K0kC8icc7pLZgQGT++pva8/1DdiIZwxQtU/b4RLiFfjYLe7a0dFB50CVB8L8FYclHr/ADRQHN0896SS3n2lPwnzKerz3xxLzrwikxjPTx+9s+V/ow3UuxH2wcifr5EXuS5iDPjwkoPOrjc3DZWKNb7HCkAi+fAScsAlFMedo/OWcviuJPU6zXTiEBHNb38QMYdN2zM2yxLbcMSxt72xA2scx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QabtFjr/i67fouaW051aBdOrcPt/aM5d0PMKYVwaF3o=;
 b=jxPMXFrKpp7+quxi57PLmdevK7N5vShvx3TTEp2oAwbqVbvvRsU5KdDkBWd3wHc8OXXNqI2gMS1cxb58gWq1FyFg87oXt96GmeHwp3JleKKER6MgHtTyDG7l2xkoQQ1kHkNTBLZqc6tZjtBJ8dlIlCYnpLrZYdI9uLaQx4FTs5EYUlHRyohd61MuK8cXB5HOpyRnzVJQHxj34vkZieUQbV2E83/R2re49W6pd26TUir8rogTfSBo56D2tc6zPDVOhPO56dOpcCbq/HqqSapbly8gkZHUgyRSFI9vCW13OLjFaGNexQtqPmwyW+rDC6qGlMkz7FrmOQFdl4bem5zNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QabtFjr/i67fouaW051aBdOrcPt/aM5d0PMKYVwaF3o=;
 b=rO2ty7KQ2L5lzA58yXjeG+oK+ZwYEaQ2kT/myBz0a5dplIdphPFJrRZ2KO4OzneB2Rcx7TnVporQbU0qfypAp0TJ3dRBVGcXE2OJLsjV4nzZFB5ZMW/56urDHZmXEADMOeU27z5+N+GCPEh8jL87UjEYe23VGopq43c9k4P+V7o=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 14 Jan 2022 20:38:55 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::2b) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 20:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:38:55 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:38:54 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: add page fault SMI event
Date: Fri, 14 Jan 2022 15:38:37 -0500
Message-ID: <20220114203839.21707-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203839.21707-1-Philip.Yang@amd.com>
References: <20220114203839.21707-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6fb6ea2-ec31-49ba-81be-08d9d79de253
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2667879EF73BEC497670C9ADE6549@DM6PR12MB2667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzCqnXBN0f04gYDlTKo7paJNx3qmqbIIJ2jdSy36pJ6yMRVTIs5ZnIqE3bB9io/pbrYU+4pvWIm0E+DN5eNN1ErArzAFgggcEDYsyyATE5CQoSZuvpAgDuOK96j/jNcRA7fgMJyf8ZhBJuqyec7u7yhLIMeNu7PnDPRL07C9IW3fqp9mNbVZhpaE1V8eeILjRcVHUzFR5VWXuPwzq9e8T2NVRZJDOyFYorxVxTPuB3+c7tQN2rLn53gUuYw90aC0nGTocDtnpNUWIgNRl19S0QGm8M2A+IL+gVbDCuxqe7k8TJDP7C8NVq151qEAIOufM6O5UHzxqmBmK56FDv81VbRunCLWBiQzi+ykIqd5EfP7dugQRnz0HAHsD/48GFm2k5bTMiOBaO+gtacnnqiqz0rsKifwZD+/eMwUSmywGXhApR7Gdi/nv8Xn6+ZzB6JLNAJMj/3wDaIGwKZPQ/7GWS/PNgOYXWLjCX9BK+dCW0ENqs1BJHTE/T9Xs+7cvaHs4uY82IqJk9ju1eYFUy7VKV3OjKU/Mtz+5wORk/R/ftpTC/fkj+OLuby6PpYYOnFzeks6GK1y1CHCo9WDghtSQueoe/q5llMTYVDkSsIJ4x0/iezDAxPqHbtQTBlvFC9hX0W6hYIe2sr5vnd9UP3AQv5/aV42uNCayl0NH3QeGJauJwwLTOAhghlzn09lfCQZWCueeVe/HW70/oYJoQbzS8srQ+fDZSnYkCHz+uC8FycQoIQs6UhqxJiV715EUnt1RK47JxLL1rML+dfR/hfFHwMSWhrkKMUhvUki4ftTh10=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(16526019)(82310400004)(316002)(186003)(81166007)(1076003)(8676002)(2616005)(426003)(2906002)(26005)(4326008)(508600001)(7696005)(83380400001)(5660300002)(47076005)(8936002)(36860700001)(356005)(54906003)(70206006)(36756003)(70586007)(6666004)(336012)(6916009)(40460700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:38:55.5659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fb6ea2-ec31-49ba-81be-08d9d79de253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2667
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

