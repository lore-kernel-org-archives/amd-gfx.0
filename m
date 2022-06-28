Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3049FC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D8A10FA9F;
	Tue, 28 Jun 2022 14:51:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8074310F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnKprrHcGEjGMbfR0ORSrshR3mFGoqTfmxE8YY7RWRDIOajqN4gQTJVvas6Y5W+1N2PhBx9ePG7x+m6nNi+kr6oRm2MHgFAMBUKrrLlOfH1eHcN8YAa4HKZ1bWNqm11lrU22Nnq94sFgGDBTBL8QSQaSdCEk+sHB6wCEOKvi5WVXhSUz/vfQYaGEcGs/A6JfblOVDCDD12vwUS0rwcRCAbXaxeDIMQjetzIPB85MhbOqCYD1C4mbJscHPefflSjsmgAH9NuYiaqlvV8wUtIc/KTfu98Osads7cBAcJ/0nSVgXfiqo+kZ+9p5GOZAJCOhz9Ma/Hd5Y+6l2E4zArnj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/PZozAZDuFwSM+LLoFH5SdnzpiV2YtOAzvzRnbwL8c=;
 b=Oe4sFfei717Subn/pEWGARsCR73hvfsGDPVZbFe/7IWt/mq8ZgXPXrhVpdeK5SDfQMRuZVIm249VNTZc25QjteDsvdYhqyCRiz2LAds/VcDuMfOJcz6RfQ5Ja9XnlgpFFiGWudrPc5Dxl7EoaIaVpum6bIlAvQg2C8M+fTo39yu/dYz+KFVjrD3ZYzBTAdbViyNslaKslavno1RQu1nzT0m1inbpUn90IAs2W7H0aMURfdnst0oXEQkNoKNcKCf7emlZzm2JAhshCINTg9p4sXf09NZPowX4rXCYcSwmLZNCSsdOpbyuMl9AsWlDv9QXlGCrL6vLDP34n6fVPX4VYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/PZozAZDuFwSM+LLoFH5SdnzpiV2YtOAzvzRnbwL8c=;
 b=qF3eQRFWrMHvEvHx/CL9QPTIBbvWExTaj1PkR3eA3G7lGXLN9LhCfEQqR1VyAfJJ/MgQtoJ+Z1u6wW+KJQ1z9245Qz3p2lrPWQ+u3meZ8kqI4jiQNOmRVsxUBICwlMXbNFo3xjUmn/e9ojmNlDC0eWyxSFEE53u1zTYI/xIHb04=
Received: from MWHPR17CA0095.namprd17.prod.outlook.com (2603:10b6:300:c2::33)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:51:23 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2::4) by MWHPR17CA0095.outlook.office365.com
 (2603:10b6:300:c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:21 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 3/11] drm/amdkfd: Add GPU recoverable fault SMI event
Date: Tue, 28 Jun 2022 10:50:12 -0400
Message-ID: <20220628145020.26925-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1f38c4f-5fe1-47be-8a9a-08da5915abc6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZMtWj1By5itfz92k3HI2Ezj2mtm2Wl5BfgFugRmxrQcweNUF7+aR9P6Ttcqs9ErIzZpKcJD5LdxKc+HwFuRKzDGUZx8vGTC5QeW1SqE3xtULmfvB+cZuwQV2xSmWd3fbO1vXlcbcC5WEOX69NZ4YtvNfjFy5dju7Ncqh+l4KkyOvNv8+RRaQp6RewnXGFjePknzjPpaRvrW77j25LB1cJTY97NTwFyRQ1Vwm24XtPwtcl3VjwV/1MN1EPXZpuANTFLXCxQrQAP417VWRsQ03dPkZZcZYoUoFs4QZVG+HOgd5tlCVkcwLNYFu1M0+7p5mvaLo1tRuADZM6E+qB5QojWo/iFWWA5facYVmv9WuPX36dmYUxJ62/1SOQplQCqGSQ+goM9C9nfTeS+41xFiTDwGq7RZVPUzYl4Famj/Oy+32Qwp+1jaeKmS59bdWnbp4Kuo2YyoCDBaBwB3TIp7MWLfdJBRPkOotWFqwdjhpVyOIswVEqKHC4aWklwKZxruqENfc1uCepZVG0ZShffJax9WQpqMkF0HvjcozY/TUcxiYc62r7iUAUWnFiTJg43IF0ZAGn6ckkHYXiAZ9tyFo7OXG4ojukZzOYb2C98kWGgtd9h+ZJNCq3o7MxY76VR2v+lZj/iouFSBxsHwLrdDd0B5ygyN88O1NHYUYNRXSVs/RJZzwqlCActx6fhJ1vor/oxsVSKBYozr4kvknZDlg/6yP870cA8wouxbac+DKBXX2zJeZlNhtkfhvby0mXjq8vKwN90qoMHu/hd1yk2zE7A6meQiOcM1WBV9JnBYtaWV+J280LFtUEZfOKamPYHRjqOIfxaYObt/gxxu5ExngA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(70586007)(1076003)(186003)(47076005)(16526019)(6916009)(81166007)(6666004)(41300700001)(426003)(8676002)(83380400001)(54906003)(70206006)(478600001)(336012)(26005)(356005)(2616005)(82740400003)(7696005)(8936002)(36860700001)(4326008)(36756003)(5660300002)(2906002)(316002)(82310400005)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:23.5572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f38c4f-5fe1-47be-8a9a-08da5915abc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ktime_get_boottime_ns() as timestamp to correlate with other
APIs. Output timestamp when GPU recoverable fault starts and ends to
recover the fault, if migration happened or only GPU page table is
updated to recover, fault address, if read or write fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h        |  2 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 55ed026435e2..b7e68283925f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -244,6 +244,23 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 			  task_info.pid, task_info.task_name);
 }
 
+void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+				    unsigned long address, bool write_fault,
+				    ktime_t ts)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START,
+			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
+			  address, dev->id, write_fault ? 'W' : 'R');
+}
+
+void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, bool migration)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END,
+			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
+			  pid, address, dev->id, migration ? 'M' : 'U');
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
index d6fc00d51c8c..2ad08a1f38dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -1617,7 +1618,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_unreserve_bos(&ctx);
 
 	if (!r)
-		prange->validate_timestamp = ktime_to_us(ktime_get());
+		prange->validate_timestamp = ktime_get_boottime();
 
 	return r;
 }
@@ -2694,11 +2695,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -2775,9 +2777,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
-	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
+	if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
+				AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
 		r = 0;
@@ -2813,7 +2815,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -2842,6 +2848,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
 
+	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
+				     migration);
+
 out_unlock_range:
 	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 2d54147b4dda..eab7f6d3b13c 100644
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
2.35.1

