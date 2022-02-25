Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C12CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323A410E912;
	Fri, 25 Feb 2022 18:06:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C5910E90F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQsmiCAM+yH9bB7vZ/OIe0Qworgs9RL0XlKjPxafQwsZiEZIWKn7BkmdMmEHTuNohN3LTIV2ig2KiG4bMWwH7Zbj543c6Gr/UiYQINUIFZh5/nwPF+IrGpTQweaTJuyFm10LhyRXl0MFdym2XEcJy+J8j9mCji9eHEvwTWhwPkwU3xGM8PzerMzRRVPMlXH+Df+Okz5LfJG/cfCmaFEfOqa/S8UC7KZg59LGRCtHLZVX+UMHVvX1B3jVRV7DLUETGEdxL3bZdt+6GK0YOSFjED9I9Vd+Lvsw0Tt84KkkdHl0IhD9lN9UmKT+CECxIsydPX/gAhYobWDvNQTkWx4c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMr9AGMADw8EMhwzIQTM461BMgiBLBEzSZgy477w2jg=;
 b=cKd0pt5O4C5Q/2Nr7LxP9Sc6lNZ25Tz6VvCXlumnaNvkyupx9Ozf9VsvxWvs8/v+XzIqhWJdPX/A2glyKwOSCpZ9B6FcKjWYZplbzBO+upiSQW7KHUfZxzkZpVc1eUDLyHVxeWAu3q1G4iPxS6+ttT+M9F6G3y0LZndo3l4j5YsXSGi0ZM6P9FmSEEnPQmtePWAd64SEi3DboMkqZ4zXQLvX49NMr1sm3SSHm4sF6poJDaT4CKHZdRAccuZ2dp/1yTkAwJMDhQ3XXEPpUquRgjo7ynr+6X+LWsrfmuS9P29IB8Rw0CisJt77R9ll6OctQgbMeV8Yt6fZKstINJBD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMr9AGMADw8EMhwzIQTM461BMgiBLBEzSZgy477w2jg=;
 b=y6e93xhQ6PWI8tNVO0xD8JiCPAiy4xGgANHDsmruEh43eQbovgefcctBR34CCJoUZYlUl+aH5N6Wdo2ZhjoJ5mMFFTglVVvOFeTptALCaR+kHAkUITfLdr5IhL+Arswgp3Y19hpH588ogYFNxHeo/r9zoO6BZB0UneKD4iFzgAo=
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 18:06:42 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::3b) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:42 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:36 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 8/9] drm/amdkfd: Add unmap from GPU SMI event
Date: Fri, 25 Feb 2022 13:06:18 -0500
Message-ID: <20220225180619.21732-9-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1429a40-4475-410b-672c-08d9f88993a5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52511E522AED06227CE31510E63E9@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHVOi19lFRUftho7MpTpclswK4tm4RTZ2GgJNylcI74nivC3LsOh1cEwIw0KVlE/qytW+CxyG8ue3ajd9Y2F2G8z2PLNKjbkNHdAxMrI2hjgg5A2B03WEsWqe6MyUYCgtp0Nz1SnKy9jCrl8I4tCLwImdjHqrzDUyZZGkKgwur6GducyOYNvOmhHJX8EOQjOxGs+M1KM4m/XT8dchZHamo99J5G+alOoTPj0wlkOFFyrLYNQiK1A947MwxlK/zHjzXn4u8g1V611wokUheIHAAniKDirJalVRg76vOTjr+AI8nVTM9F/rDcw/t42w/gfqyVuWo2CAdnxi3Am7O1mt+wV59JDn5sJY8YKEuurQxeQfIFvvwtn/2ezQaBH6Aq/4TQOkAchL39AUWjiKfcp1TjTtZjz561c4trKEhy2SDeQ3tLHorIRNTf2xAIvggL8RTE4/IGkD/SLLLrlK9Z3yoUM0PPNomvm4udAsEq8qma1LG4Efichmz967/JnAz8SpL3LUdlmTYTELVMv3F5UEGoBCFWukzOBpwxjMGvgYIrXJiZgAI1IE3Ag6J2aDRu+d6CEP9XeqEP2wYNEpcblsQpcYXXWfYkBcnndbIxTz5so1FGLQ/FycmuOIzRwD8ahUdjt/pEkedTvZzK6Jzp7Qm+WV6SSWu38nuF7O8sB6meswh8vLqH9myCNjQHOBbg9yKRXZiw69RXUmJFmrx5C3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(1076003)(40460700003)(2616005)(316002)(336012)(70206006)(26005)(186003)(86362001)(426003)(36756003)(6916009)(16526019)(36860700001)(4326008)(8676002)(81166007)(70586007)(83380400001)(2906002)(356005)(7696005)(82310400004)(6666004)(47076005)(508600001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:42.0309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1429a40-4475-410b-672c-08d9f88993a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 25 +++++++++++++++------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index a0539088adb6..f30cdc18380d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -317,6 +317,15 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
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

