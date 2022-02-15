Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B37C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE09610E3D8;
	Tue, 15 Feb 2022 21:23:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3150810E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbYLHncFM8UDsXL+sO5q+cS2u49gdg7wa1pZtK8vjOa3VjafpqKigZPTTPUfZI0JykU7kXYuQEJP0MaSarlCBLqvs1aasW5iE6L9GHXgtEyhI/dfkxq1gKayRsvWiisfwPOEmc4yYUI5AnowU0wk9wOYGMDwajWWDMLPFNzjB6Zna57254WLzwU8pPWIIr78L7IDorrYPTDlzgBibiF3ISuor0OVavtWq2WcZcvheulJzbyTsBFjbngOljn6yix0f5zs9ZKu9nVCNjFvFN+C70SCsz58L/v8amAmkuVWNEqGPvDr/ueAWhZBUWBgHBnFL78u/0I228jNYq6YxmWyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFTEPtjXszDp6nvn3YQkckLJYD5uNCLFPygarrgrmkk=;
 b=llQTWYzQsTKP2Z7aRX7yzzMmsnPJ++ExU5NL1kfYeCBkpXIqR1KmnIHiVtbeltkXjO0bcne0UdcF+0gHJGtBdEUuAsxWc3XzgfXIJU/DkOmfLkhXQqSephra3c/7BWSWLgNlUHvpBF+YwFcJR31uWn/3L5l/41laJzze4CLqxCOD8xTNJrin9inOejAeJgoTseN6R9hDlPRwpAdKgyNm1GJXrw0YYwDdZkQ1WMt90Jb+6cDSjzduKntHfSaZqkVlFz4oM8aSXk/FinKS8tzWy2vUTDMrcoxMSCstX+R9b7RyS9hfGeWW7f2hKkXtI8GFyoPrEwWEezItNBT9TyEETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFTEPtjXszDp6nvn3YQkckLJYD5uNCLFPygarrgrmkk=;
 b=hzxd0vkVQVQcJ71koLAaFhJ7wZSIj/7buGbF0PSwPcmQXl0QRI5priZGZCn6wg6HdHIi174I+1PZy1mSk0WhbxZhPMKHEpZQEBT0KDYoHvCe9MVqFJiIaSQ6kEhzzYbeqvKBr3VjyWD3VIWc0rOElabW3yeWsnhMDrNzUt+bQmE=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 21:23:11 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/8] drm/amdkfd: Add GPU recoverable fault SMI event
Date: Tue, 15 Feb 2022 16:22:43 -0500
Message-ID: <20220215212247.16228-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc62785-46fb-4085-b208-08d9f0c95e87
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056F993BC9E96C217909100E6349@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1UjOJmejn27i08XJgH/5Z1QcWz6wzQ/UYb0RJnKGHGH4onzh/FiP98mF+eV6OFng8s6Tm4YdE4jgMsEJK13dNGBXYBCsfAbaKyVpota5EhzhvLO85TSYDXVMdMKgu7LMFEweYSHsXUPB1r6oDSgF1PxAKpTieSFWVVZXXRoNWqTCN8vwe5F1tz8ie5kSi6lPmppCjIKKQxsk45cV9hnBMJump+Zg+sGX188BybkioagLvXR3fCn+vDEQ9ayN3mxoNtDUZIQXnyMhdTimuVmwh26r/UrosEat71ylzwa38ArIh1votLD55WlbBPtSvO0dSywPSKDC73oe8aYEQjfdmeT1bBCMNAF7+tSS39V/PyVHSJjSxzfrA97RkRA2Uw7uE/KWjsv3IzyEShAiC5z3pmroUT7HjPDGxgRqv1iERWCSx3ndPuRCiku6GvM+Q0FzhpRaH/d+ZMLNr4fjnyrPC4F502Kpkq4AJZBsZfl/VVhL7zaogDbHhmwFRzRLVoHawdZnyGXqHEx9r1r47N24kJlgDXXgZyKIh8afc+lOyw3g1P0Sl1vl/PFsHoRvAY3ET/AgVlLrpH8sjUcykDbZrVtLP8I/uTeOrudHW3Fs2aSUUNWKt+9hkXWPeZA+20QkexJkeX3e+mucd0iz5WdT5ymxwo7pmadDwf47P47ZBWYelrP7PrrUSGtA5B/AZyQ/0tq8jZrvyYdAyYqbRR4dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(7696005)(6916009)(6666004)(54906003)(2616005)(86362001)(36756003)(8936002)(16526019)(5660300002)(82310400004)(83380400001)(356005)(70586007)(2906002)(40460700003)(4326008)(336012)(508600001)(26005)(1076003)(47076005)(81166007)(8676002)(316002)(186003)(426003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:11.3273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc62785-46fb-4085-b208-08d9f0c95e87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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

Output timestamp when GPU recoverable fault starts and ends to recover
the fault, if migration happened or only GPU page table is updated,
fault address, if read or write fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 36 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  6 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 21 ++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h        |  2 +-
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6b743068057d..c5ed0f2dad45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -267,6 +267,42 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
+void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+				    unsigned long address, bool write_fault,
+				    ktime_t ts)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%lx(%x) %c\n",
+		       KFD_SMI_EVENT_PAGE_FAULT_START, ktime_to_ns(ts), pid,
+		       address, dev->id, write_fault ? 'W' : 'R');
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START, fifo_in,
+			   len);
+}
+
+void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, bool migration)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in),
+		       "%x %lld -%d @%lx(%x) %c\n",
+		       KFD_SMI_EVENT_PAGE_FAULT_END, ktime_get_boottime_ns(),
+		       pid, address, dev->id, migration ? 'M' : 'U');
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END, fifo_in,
+			   len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index dfe101c21166..7903718cd9eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -29,5 +29,9 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
-
+void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+				    unsigned long address, bool write_fault,
+				    ktime_t ts);
+void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, bool migration);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b71d47afd243..c6ea52340abc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -41,9 +42,9 @@
 #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
 
 /* Long enough to ensure no retry fault comes after svm range is restored and
- * page table is updated.
+ * page table is updated, 2ms is safe to let fault of same range go.
  */
-#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	2000
+#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 
 struct criu_svm_metadata {
 	struct list_head list;
@@ -1597,7 +1598,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_unreserve_bos(&ctx);
 
 	if (!r)
-		prange->validate_timestamp = ktime_to_us(ktime_get());
+		prange->validate_timestamp = ktime_get_boottime();
 
 	return r;
 }
@@ -2666,11 +2667,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
-	uint64_t timestamp;
+	ktime_t timestamp = ktime_get_boottime();
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
+	bool migration = false;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2746,9 +2748,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
-	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
+	if (ktime_before(timestamp,
+	    ktime_add_ns(prange->validate_timestamp, AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
 		r = 0;
@@ -2784,7 +2786,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
 
+	kfd_smi_event_page_fault_start(adev->kfd.dev, p->lead_thread->pid, addr,
+				       write_fault, timestamp);
+
 	if (prange->actual_loc != best_loc) {
+		migration = true;
 		if (best_loc) {
 			r = svm_migrate_to_vram(prange, best_loc, mm);
 			if (r) {
@@ -2813,6 +2819,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
 
+	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
+				     migration);
+
 out_unlock_range:
 	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 66c77f00ac3e..c5712f56560f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -125,7 +125,7 @@ struct svm_range {
 	uint32_t			actual_loc;
 	uint8_t				granularity;
 	atomic_t			invalid;
-	uint64_t			validate_timestamp;
+	ktime_t				validate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
-- 
2.17.1

