Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E85D10E915;
	Fri, 25 Feb 2022 18:06:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54C410E90E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3zEPGdubkypW7EDo8YrY1H1hQ6Vpizo8cqgtGwpci+/pEf4VXVt5moAbPjMyIdRyAZRK8CAbB240N0T+ZA9H86Cd91opv0TkYP3PWed94NNEmubw7wrQkW7Vm2spHiIv/LTKyQmMR3nh/B8tmQ1WtCdRoLPjw3j4fgiYwbhgu3EO7HKkxg/a5sNyo73k+6XTTGHJgU8ut8ND7gqiSh58nV6gS6qzROp3WX4WQEvfoiFpaPAkpoI7COcmhJjFsaNvVnUMOXAw0hQAV54pdSX/XCu+RAeWEVOKp8flPFQG6zJXuCpE+tE6J+f641h3QqdfufrhkOsDKqRqfjkWu0wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXPDoxo+qiUAvpZLti23OsMbc7FcFiwLlRFiz2l5pvM=;
 b=AMkEpFCzy/JCpn44v+KSo0AqK5zhaY2kUhpfJ2nNQLEwiYSqGjO4L31Q/ynU0uCmjQuEo2kFs65rVqHoAYAWJMoYcCELWEV+WUSQwZxyN+UQvZ1KmCUHacanH2BnahquzGEIqOgDoo/AU1lpReivfBKUq3/H7gQ8UgcudLBCHIQ0bG7f4nHiq78NLQmZSHtvmZ8G/lG2ZhO6jfwunLJjjZT6Q4Rll1zyOhyVN816+YK81q2XTgjvgGMkIXWZOdv7WQTSjdzT/SeZrj36FSLULGyGOkjabnWlIKPDXcBtL8bpkcEoy/FdLSX/DBZ4j5mQww2fCeILVVciWOKwam7Fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXPDoxo+qiUAvpZLti23OsMbc7FcFiwLlRFiz2l5pvM=;
 b=UCVw9y0erKl0BbpSQ+dxu1BQtqUi9ZBUQKAcSEFcHcabshHRviAvXVP3n7QUBLzTPqKwMNjIwZgaahGA7YDdnGeYzuztvNn+PuUUAYEDLZDkD4PYXkA4dBu9WnvJieSx1LD80zpTNFJPdQ9mZiv2up2E2T42dCHw6rS9+k3XVjs=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 25 Feb
 2022 18:06:39 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::5b) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:35 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 5/9] drm/amdkfd: Add GPU recoverable fault SMI event
Date: Fri, 25 Feb 2022 13:06:15 -0500
Message-ID: <20220225180619.21732-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b24f920a-1edf-47f3-2087-08d9f88991b3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366E540FA58D49599525E36E63E9@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/Umoew+i5VmQpp8FBvXTtGP6q9Z2aGMgwVlwr7tOvXx5HJyEWbcJhx8Mbz+3FDf7kiGp0oJFqgTOuQ+gV+2riwoIvRpHfWUG3P6yBHnsMgl86SPMWfL17N7gg/Ddq2pWPR6i2bRWlrwyJ1CTLAqbVtZnIG6Xh185TLclSFrb+qLlppsTyEqxsKPW8pk1HdSUgCuae2C7XkQjlFeGGun9IOaVE7ZAMELKSDxPTpmOISBDFm+WfBjOzZ2ozHM59/CU8a7H929+cBJYbkPgX3aJO+8GTTicXc7W7cRLIprgDelk5+4lsykzwsWejux5QiCev+02YxrRj9TYUW1aeDYfEYsJDHpiHMXlx6WHCOBPvLUMxPZmp4pMScXR+3rpty2T4U+MSAplWAHqdwQMKJrdF/+jln8/1wVwCWR5jRvcbrc93EKqpWaqvWRKaAyz+rfom3lT2tDFlfzyW7ba6JIl8E9DFJ2VZBGlmiFYSoNHSHga2RE73KbQlwdRQv6LVswwXhtSjBlU62GJgrEY/hfprrHz8FGasm8+pXOgl/PgiO5NwY7M1C2CjqPRLe4rnXIHnKxC1/mlNseTvUKMlWpWGqKpqt0VCeU7tmySD4j4ITMJZyzw0xHzk1x0EpCxrk+g8WQ0WHrRBNjVf4HwatJALnZSP39V3UquYaR0lOSVlktlqp7GS4laFUrQwIxgn2kRx9EqCC5z5tskh2RRA/gPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(4326008)(82310400004)(508600001)(47076005)(36756003)(7696005)(70206006)(83380400001)(70586007)(8676002)(186003)(16526019)(81166007)(356005)(1076003)(2616005)(6666004)(40460700003)(5660300002)(26005)(8936002)(336012)(6916009)(54906003)(36860700001)(426003)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:38.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24f920a-1edf-47f3-2087-08d9f88991b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 21 +++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h        |  2 +-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 2e0a26159662..8e147a175fea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -243,6 +243,23 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
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

