Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A47CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C749E10FB27;
	Tue, 28 Jun 2022 14:51:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A1E10F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLTrFMIYEjSg+KH30QMK32jbkUbWpw9rZT0bMoz51V2xNRFOoMX0IisOsPEKSRKImWwc3p7sw+rD55WKYCGtSikPcYiJp3QXxE9Wot9TrFEVVm3fE6zbqHej6qaOxHDwDmU8NO6Ub7AvPWsyJPVORj0mngEgywXA39X2Ox1UfiSQesaUC9KobyhYtFyZlmm7Y8OGRSLPtbGatbDlra4LkHULtllxvUzqaLhIyTyxoO/85S8ncRn9Fk0Vxu80KYguJfaxmP2q7Kn64QacbeKAqhIYK0dparCUJ6u7To4VeHj4DowCeUZhGZCxCVmI/1GyL7Ign4eODbp7Vi6wu1vqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCpzuN2S42FfJh43C6iZPAKM3mWUSp6ej4FYg8crN54=;
 b=FnYtbtKlE4IXfgXE8RHiEnmnxHbAlNAjC7WpzY2CH5Gw3MhEjVH70sadtdz5GCNrGMZKz/pyiNxQNJ1oOkE0v3JJM/w4SuKPceBLbirF9/Qgmb14g47QAkRSHjSmBET7jOGhlw4lzwSEAM+DspiCVVad2SdjNWdT/r2rcapNIfRHhPBpuN+Pubhj4savqDgIQjgD8VM/vsmQZzsTh7PO2KHPKFkU5ZgydXz5tvtiYVepJsfsFe5LSY2BefTyFABaPNF1ODYTLQwIIDAvps/OUhhWUOiq8u1Czgtq5d9L7jE1/wsIWcZ6wvvobY0UADlJIA0J+678bxnZqEv7zPjIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCpzuN2S42FfJh43C6iZPAKM3mWUSp6ej4FYg8crN54=;
 b=hji5sWeHB4HZzkS55t6PSD+dvTwlQMiLZuCHdJ69bFap//45kuHRaBAw/N9xRZgJXvPXYKwNBJ2mOXQf7mSnrCgN3E7ru9N9Aoai11pQZ3N6XbCEIG3gUnbLnAQEHOe25kXA0ha0nqP7kf0acjZ+WDYW1exjtdkLCOGzOym0hFg=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 14:51:28 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::3) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 6/11] drm/amdkfd: Add unmap from GPU SMI event
Date: Tue, 28 Jun 2022 10:50:15 -0400
Message-ID: <20220628145020.26925-7-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76f05e27-5fe8-4d3f-20c7-08da5915ae78
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIfKnJLtd2YCbC5hWF5a5GrMQhZpb3ftZAowqqjOQI+ZAUWwi/4FZBABexAPEieSvOWyFh+EwaVwiOjsWvPItCu95JgMzeMhvxEdcs9qWL1wnuZdw2R5iYvHREi5mTAxO7i5G5rCLi4MHxEpNOmhC5J8JyYMDMQUkFpfjTTAFt8J8V5xHXDaOANQm+vTbqSAGyOksLx421GrsJI88oAxJ+qAQzC11900PlKr/5c8ngg2DupXkfuCiYKolmP6/594bQdWAIUTPGrZEj2MYKXLyFCt3kkwxEVj1BHRUwWN6KcZuDC0bzMQblIPOY4SVlGPBWHst+nd7eN/yRfgfzfzkAv1h19szZCfMIsjvQ+GXLaDrVe3TkTUI1lT9N1JJ3qXAZY+bIU/ZRsdRu7lrTcEt/X4peQ3S1nj/ZM/mflNJRYq5H9Ivcdg/NOJSW44k+ZTrV7hn8ThqTHp5qtQvTsyAnLb6onRQNzvjQkUfegse74gcl5mfRlzhROSL/PoIO+uT+kHKwARJ8pUQFAIOGpSbkpRWwFmrfMw8/4UjkmkIwzrPICMMZdypa8sCJ5sT9mnE9L1Q1vsj/yXU+6ORnwGFITZuMw8gpB6YnV6M3ZQUrlY9Xpm0z8xuue4rswyFVBuDBZLST/zmNG0rhmTH45htre81lh6Rs9P9SuT8Z0zUHLNLHHhAlyOOHxyJbSDyoDaho0vIOVZbqR9o4yJkltl6xEcSqElZ7aqBGXg+JVG/FUQPmH7WCsGBaVX85vWW/DIrLx7cJvHzDFczCQWm9y20QXu8NeJFlSVnt0TJ0tV4T5ndtXJ3i/hu1xNetme2AzHFG0GoQCnRlNwCtdKNVzKtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(316002)(4326008)(6916009)(16526019)(8676002)(81166007)(86362001)(54906003)(36860700001)(8936002)(40460700003)(1076003)(40480700001)(5660300002)(36756003)(83380400001)(70206006)(478600001)(70586007)(336012)(426003)(6666004)(47076005)(2616005)(82310400005)(7696005)(356005)(186003)(2906002)(82740400003)(41300700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:28.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f05e27-5fe8-4d3f-20c7-08da5915ae78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

SVM range unmapped from GPUs when range is unmapped from CPU, or with
xnack on from MMU notifier when range is evicted or migrated.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 25 +++++++++++++++------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 3917c38204d0..e5896b7a16dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -318,6 +318,15 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 	kfd_unref_process(p);
 }
 
+void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, unsigned long last,
+				  uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_UNMAP_FROM_GPU,
+			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
+			  pid, address, last - address + 1, dev->id, trigger);
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
index ddc1e4651919..bf888ae84c92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1200,7 +1200,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last)
+			  unsigned long last, uint32_t trigger)
 {
 	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	struct kfd_process_device *pdd;
@@ -1232,6 +1232,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			return -EINVAL;
 		}
 
+		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
+					     start, last, trigger);
+
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
 					     drm_priv_to_vm(pdd->drm_priv),
 					     start, last, &fence);
@@ -1759,7 +1762,8 @@ static void svm_range_restore_work(struct work_struct *work)
  */
 static int
 svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
-		unsigned long start, unsigned long last)
+		unsigned long start, unsigned long last,
+		enum mmu_notifier_event event)
 {
 	struct svm_range_list *svms = prange->svms;
 	struct svm_range *pchild;
@@ -1804,6 +1808,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -1812,13 +1822,13 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2232,6 +2242,7 @@ static void
 svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			 unsigned long start, unsigned long last)
 {
+	uint32_t trigger = KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU;
 	struct svm_range_list *svms;
 	struct svm_range *pchild;
 	struct kfd_process *p;
@@ -2259,14 +2270,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
@@ -2333,7 +2344,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
 		break;
 	default:
-		svm_range_evict(prange, mni->mm, start, last);
+		svm_range_evict(prange, mni->mm, start, last, range->event);
 		break;
 	}
 
-- 
2.35.1

