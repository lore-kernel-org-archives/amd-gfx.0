Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8068C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77810E540;
	Tue, 15 Feb 2022 21:23:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5A210E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIHO4TZmUp1bLG8gS1JmKZSQN3x3VkQujtMNOfA4/pZgbF+Y5IWXX6QDvtUt57mJ0TZajAAY/g2X5die7YXGjf6eN7qa0USthZZw8wWPcHVmd8HVUrPiVj77ns6FPjshTYgC2aqWfH+nRekYuX7APChbyy0UqTjKUoh5H8SALrN/xG25dfZRIxc6T6D+U3oKMEhdQlnB79Qt1rHZCTfhNTrMzoAyDl29tqHdfkUEyE6zXw9+VFfPUiCgAoM5nhCq8ID3sl0grqeUMPY4m8u4OPbK+i/t9Jb2Ua415BD/2l0iisYTKvLKtiLGDyEIMNAzHqMTwqTl5MNktyBwx5kxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYBTZJKGWUtX4CfnfkXlnFVpwsivk8Z020fylSwTmZI=;
 b=bU/Tqs1VLP+LWKAWpec9dlXxeY7nXAS8GMX/HpfIyR7Oky6zSAM8eHM3O/GbnY72eKkw/sV05J4n8MTLeQQ42JdFkpQoe+JNN1+d2JfDG+2rnMRWNOBdtxcpFWV64Z4c4uwQg80RltVmeS2gLhUr5qZHXoTVP2VyNziXkWAM1X6MUJCOJ/D3KHMsZ6m0qJaNJo464WyHAKRPp6WxuwZPgnRchPbOG1ZO3qCM0G2XC89VHhxkJrMBKqc/qwv9OMTHn0/O2zoP/4wStZtDztr0oyjhs8HEH6R2iEvDoTR9vjheR86NlXDyQqiu/XkRxW9xpfZOkegGAth7BoE8MY3E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYBTZJKGWUtX4CfnfkXlnFVpwsivk8Z020fylSwTmZI=;
 b=hI0O1oXZ1dlT98pAMp5K/mTWIvl4kukR2RWIBlamCNoPY98L3Z3ocYTPgWxIZLQzZ7iFNUJ1w3chFj+J0hvmpRPVJSGjoHLbl9FvdzIA/hZawp5ksK4UZmlqFeY0qM4ooXErx0DCrMR4jwsLoHrr2v2w/khBD7aPBCmtlrXcWts=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by BYAPR12MB4632.namprd12.prod.outlook.com (2603:10b6:a03:110::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 21:23:12 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::9d) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/8] drm/amdkfd: Add unmap from GPU SMI event
Date: Tue, 15 Feb 2022 16:22:46 -0500
Message-ID: <20220215212247.16228-8-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8328cefa-6a32-4a18-e58d-08d9f0c95efe
X-MS-TrafficTypeDiagnostic: BYAPR12MB4632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4632031D0BC143DE1014D824E6349@BYAPR12MB4632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogKOl4s8P3GPdHxKd8O7Jv+jnQAE1JRG2vYWJ2endzEF75rQ4GEqxtj/TC+9LPt9JjTPsC/lAJhfO0Yfh2VNJrMdSlF5iO1d7ZL67AHMcAZg8B6QvyBLVjRuc7I0J8Ynm6oqbow9UzRJTrzgWCosGB5RLCCivdrs9Ky0WVqFgll52s1p8zgUxKLueP6ZMtl80BIhY/2ubOBTMoR6SspWWCw8oX70Sqd4ebwHZFmo9wWNmUXJG2Verp9Rb7X34w/J8VIh6/+fRXrdsEyJfPhJvGzYSXc/llVVo6bGJ90hQdJ6r+f4QzXBniKRzK1MzAVXG2t3MJXLlGe/+3H2JhXI7jtZJ8vcDNmNDXxLamI/DUnQJVT1O/jIhOkxSVBsloL0qP/VFqvcRW4ATXPZIN+f68Ev4x9el6TDtw38ThIxrhlOwB7tq7mPG+lGgfurwXQQBquM0/RpgSO7MzilELnk5sQihkUsJGfiwGN0J55Ryq9QaogRMYg7UtLHDmPl+XsTZwYnpkELh9JjFlJL2qWkjuGjBRRMXZktoC4+v98qFTgzxpTUz0KEHZJCgowIGzSzrzyRwqv7tv3GtmqlQTtzoxQfpSrV/qY/JT4L68Z5iI+WckeQh7YztkOANLCo4/ctq9WMtRJai4s8Rz1yqVkdcREq2NUZuU9pHg0dsVc2SfoHu+L7ZRdAQmd+9/mqNR22dTWeWjP6ZHEBi9R7QQAMEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(82310400004)(336012)(4326008)(426003)(36860700001)(47076005)(83380400001)(40460700003)(54906003)(36756003)(86362001)(70206006)(8936002)(2616005)(508600001)(1076003)(5660300002)(26005)(186003)(7696005)(16526019)(2906002)(81166007)(70586007)(316002)(6916009)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:12.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8328cefa-6a32-4a18-e58d-08d9f0c95efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
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

SVM range unmapped from GPUs when range is unmapped from CPU, or with
xnack on from MMU notifier when range is evicted or migrated.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 18 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 25 +++++++++++++++------
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 2ee092f90f16..ec83671892ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -397,6 +397,24 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 	kfd_unref_process(p);
 }
 
+void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, unsigned long last,
+				  uint32_t trigger)
+{
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%lx(%lx) %x %d\n",
+		       KFD_SMI_EVENT_UNMAP_FROM_GPU, ktime_get_boottime_ns(),
+		       pid, address, last - address + 1, dev->id, trigger);
+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_UNMAP_FROM_GPU, fifo_in,
+			   len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index b23292637239..76fe4e0ec2d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -46,4 +46,7 @@ void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
 				  uint32_t trigger);
 void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid);
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
+void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, unsigned long last,
+				  uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1833ee7bcd95..f24facabc783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1196,7 +1196,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last)
+			  unsigned long last, uint32_t trigger)
 {
 	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	struct kfd_process_device *pdd;
@@ -1217,6 +1217,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			return -EINVAL;
 		}
 
+		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
+					     start, last, trigger);
+
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
 					     drm_priv_to_vm(pdd->drm_priv),
 					     start, last, &fence);
@@ -1735,7 +1738,8 @@ static void svm_range_restore_work(struct work_struct *work)
  */
 static int
 svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
-		unsigned long start, unsigned long last)
+		unsigned long start, unsigned long last,
+		enum mmu_notifier_event event)
 {
 	struct svm_range_list *svms = prange->svms;
 	struct svm_range *pchild;
@@ -1780,6 +1784,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
 		unsigned long s, l;
+		uint32_t trigger;
+
+		if (event == MMU_NOTIFY_MIGRATE)
+			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
+		else
+			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY;
 
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
 			 prange->svms, start, last);
@@ -1788,13 +1798,13 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			s = max(start, pchild->start);
 			l = min(last, pchild->last);
 			if (l >= s)
-				svm_range_unmap_from_gpus(pchild, s, l);
+				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&pchild->lock);
 		}
 		s = max(start, prange->start);
 		l = min(last, prange->last);
 		if (l >= s)
-			svm_range_unmap_from_gpus(prange, s, l);
+			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
 
 	return r;
@@ -2207,6 +2217,7 @@ static void
 svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			 unsigned long start, unsigned long last)
 {
+	uint32_t trigger = KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU;
 	struct svm_range_list *svms;
 	struct svm_range *pchild;
 	struct kfd_process *p;
@@ -2234,14 +2245,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		s = max(start, pchild->start);
 		l = min(last, pchild->last);
 		if (l >= s)
-			svm_range_unmap_from_gpus(pchild, s, l);
+			svm_range_unmap_from_gpus(pchild, s, l, trigger);
 		svm_range_unmap_split(mm, prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
 	s = max(start, prange->start);
 	l = min(last, prange->last);
 	if (l >= s)
-		svm_range_unmap_from_gpus(prange, s, l);
+		svm_range_unmap_from_gpus(prange, s, l, trigger);
 	svm_range_unmap_split(mm, prange, prange, start, last);
 
 	if (unmap_parent)
@@ -2306,7 +2317,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
 		break;
 	default:
-		svm_range_evict(prange, mni->mm, start, last);
+		svm_range_evict(prange, mni->mm, start, last, range->event);
 		break;
 	}
 
-- 
2.17.1

