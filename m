Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7202C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B188610E846;
	Thu, 20 Jan 2022 23:13:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BECA10E810
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neNl8zXK15wGGQ+rAv5cAU5kUY2P8FQe7NhQ6KcJAaJvVNm4qjXBPai5Y135u9v8fnpfpPaAxd9TbMhElYu5aM3A/EZ7QAVabj51TRSc0F4KsW/U7Dt+Ig5892IWsIgnO6LUbIYR8bAs7T3tR0BkFgkW6geeris7iTkl0CQbbEAyMGp6LWH61A3Ek+XLDLI/w1ZOOLAurubjiYBI8Bi2uvlbAActcqzEk+gnA+azTfuu3jDwVGVGt2d/YggqNrdTN1jXcsUuu2p2WALtC/6VltHPA5XN+vI0im057WGrA6bjySWijdMxrF584aZ8BAfvnsx1E6zCe2VwWqYoL9xnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZD5fctYJVe9G0+C0CXVg0TGGyDqEaDmWexVSlNDcMs=;
 b=bFq8sZ/eCKTXLocJdvI4U95BGS2+F1UtNI/tHObAxSul5OpACFLMsAUwWX0UIKOh5JKOO2droXJQIgtQzO5ZAc/lnqxQcRU08f8QSYNm4OlToU5Ivi6+NdJBgduUpH/51Dqb6YK9c0CQQmlCaLbpx1jr6LW23d7ybMrCCcIQ+2pZIEZbPXsTRVIBYX9aWN3AJOuBRbDWWnPtzK/xVw0o6JjnwzoRjYZLEvc3nJsFyJovdlIVqqIaIdmO2hhzJt9w8U34ljbPFReQrJsSW6rS/oXa9Sp3WGPmt7VhH8a0auSeLrQarEw4ZCYF8kpCResx8GcAEk5uVfZiH1RPmpovXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZD5fctYJVe9G0+C0CXVg0TGGyDqEaDmWexVSlNDcMs=;
 b=LsjneuPSj5KX53ZkW3uW4H77KNF9yWH6V029yTSMUSEGtHcq5x8Q9xGTQprMgjSivvYHrOqkZRCZOX9iMLUQqzS3p160XPXElO8Byn9FlsyOFncCaCfWkRClq0nb6V+GMWpW5WGNXAMuE35ogGOeGAlgpdLYYovkC33KmJpl3jw=
Received: from MWHPR19CA0082.namprd19.prod.outlook.com (2603:10b6:320:1f::20)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 23:13:39 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::7b) by MWHPR19CA0082.outlook.office365.com
 (2603:10b6:320:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:36 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/8] drm/amdkfd: Add GPU recoverable fault SMI event
Date: Thu, 20 Jan 2022 18:13:18 -0500
Message-ID: <20220120231322.10321-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3ec542-c183-45ed-5a4a-08d9dc6a7e6c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB420664B8DE3014730B7A3EB5E65A9@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ8MSQL6gQxD+jiu60NbkSk+593KzaVH6taZSDm7evHJVc3SKfoAjKI9jYFer851974WGvCey1ZbwREIPpbn/tn01iAJefXlwmoQCH+rjDUWqPAL8/IMN0fLN1w5kqwCWSuoi98OMdqHbj1+0us+O0or7BfYbfs2r37e/cQWMDAD5XXUC/0SavnvFu5rUaEqm2Iki2ctupuSyu+H2AjsPS7wcZX52RXueXTPKdKHJylf9WJc7hXdIyjMIkU5ZTE5IOJ7/o0JOOb4fMCx0VvtMqNP/Ricv2mKWNRWmI7DTZwGUKJbb0yGgEIpKPs7+eGqMkeYcEo2juUNSZSe+rUPMPqG3yMfHFNXnTNKm9sC9HvJeRUDDCX9Uwm/Q3Lq0ow0Kh7GvlR/Mi+R2y8EQuPk0SHayzaM0iv8fuxu0PRGVg38zRjr5nmaU9M//TAFtGcMfFK68z1tjlg2oOJ0Xp4VgHxaZaKgp86cHUUprmffrmzEIriXJkQuEql8CS4emKmOqz8PBWFUqSAEhBCD7QPXTZpDHhEZj5PKujZtfVoMfdK1cKSWh4LQbRx5FZIYQglEGhlxsy1IFix52pTx9mpWF+NjeyUh3C4RkWoK9ee/Kg8iwNoond0Cn6xKCr4X28Trxj70GzmS95UG/6hzsmhx0s7sMAE0xot+V/sFRet95hMJaYTBDY3C4BSlAsOQHbyLWpmj9gt51Wqx4sriCyYuvI7DdL5tnUyqVdVKUqwx53ar5K0/ytzkA6AFeEYumBha1qWPyMQFcMllnCoCmeTNRbvJyFMb1WPb0gxZhi4Cm1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36860700001)(336012)(40460700001)(8676002)(26005)(316002)(426003)(2616005)(2906002)(82310400004)(8936002)(356005)(4326008)(186003)(36756003)(86362001)(5660300002)(54906003)(6666004)(47076005)(7696005)(83380400001)(70206006)(6916009)(508600001)(70586007)(16526019)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:39.3591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ec542-c183-45ed-5a4a-08d9dc6a7e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

Output timestamp when GPU recoverable fault starts, ends and duration to
recover the fault, if migration happened or only GPU page table is
updated, fault address, read or write fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 48 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  7 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 17 ++++++--
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 68c93701c5f7..080eba0d3be0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -266,6 +266,54 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
+static bool kfd_smi_event_duration(struct kfd_dev *dev, uint64_t ts,
+				   uint64_t *duration)
+{
+	if (list_empty(&dev->smi_clients))
+		return false;
+
+	*duration = ktime_get_boottime_ns() - ts;
+	return true;
+}
+
+void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+				    unsigned long address, bool write_fault,
+				    uint64_t ts)
+{
+	char fifo_in[64];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%lx(%x) %c\n",
+		       KFD_SMI_EVENT_PAGE_FAULT_START, ts, pid, address,
+		       dev->id, write_fault ? 'W' : 'R');
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START, fifo_in,
+			   len);
+}
+
+void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, bool migration,
+				  uint64_t ts)
+{
+	char fifo_in[64];
+	uint64_t duration;
+	int len;
+
+	if (!kfd_smi_event_duration(dev, ts, &duration))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in),
+		       "%x %lld(%lld) -%d @%lx(%x) %c\n",
+		       KFD_SMI_EVENT_PAGE_FAULT_END, ktime_get_boottime_ns(),
+		       duration, pid, address, dev->id, migration ? 'M' : 'm');
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END, fifo_in,
+			   len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index bffd0c32b060..7f70db914d2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -28,5 +28,10 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
-
+void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
+				    unsigned long address, bool write_fault,
+				    uint64_t ts);
+void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, bool migration,
+				  uint64_t ts);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2d2cae05dbea..08b21f9759ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -1596,7 +1597,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_unreserve_bos(&ctx);
 
 	if (!r)
-		prange->validate_timestamp = ktime_to_us(ktime_get());
+		prange->validate_timestamp = ktime_get_boottime_ns();
 
 	return r;
 }
@@ -2665,11 +2666,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
-	uint64_t timestamp;
+	uint64_t timestamp = ktime_get_boottime_ns();
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
+	bool migration = false;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
@@ -2745,9 +2747,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
-	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
+	if (div_u64(timestamp -  prange->validate_timestamp, 1000000) <
+	    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
 		r = 0;
@@ -2783,7 +2785,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -2812,6 +2818,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
 
+	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
+				     migration, timestamp);
+
 out_unlock_range:
 	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
-- 
2.17.1

