Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB43C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E549710E827;
	Thu, 20 Jan 2022 23:13:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D5D10E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTmxZ4oUdBrvzJCMIvK3heQKLier6asIwm9MF2zfUSOX1GUzsnlv6q9+pAHSVum+ipbS3kJDjzSnM/8BjORPyl8Y2UFFfIo0JZHR10Rg4EPOA/Ai224KAUhhZjezmHxLiCrWHXG6aUtSwI9YwbrGu1GYOsjxBZEWNOKK7k+SWycLeurAMcafL0OjmDyF0SsW7RNapxHH76TbF/n7f0IJZz3OcKzBYApfk8C/TWKA0u96jYg2hkzhnG2YJZ8QImCDzbiapxHD6ZidxJsgfUoJHfeNtc2a6r38IrFs4DDSQR/QeyU1AhG+RceICbqEJ+jxhhVz7mAGaxqMH5jVeUtAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j8AAfDKebClLANe5XecPapMOg8ok95sQnXWyUWBLfA=;
 b=DFZi4C4YrptpZ2NXTPGhzKoR1mIkSpj7aqQGLGhP8vLrYI+A7sPi6yJSaNft/SCzwjojw9t1Xe8oDbGAiRIQKrFrklIZR9UI7WTGw1y5nFrIr++KsKqnZapq5+tcdKpkYVS3LSGJs35x6zEnzq6NfhAtaAEvhtGeIFbIkHseLfrcAdqYJ6hGH66MKtVJjGBredf+IU0iBWw9jqZenxEX5nJ+ldyyX3AH9RnB/9THHCoCLvLSFFVieQdWl+qbqadaBJaVqyHP89+SXQhwSRixDeKca5MsdZ5RYvsU6kcj7BROQKgsL7w/9kgr/PNelu5jKN8sW1/cmnz5/hyo+hMSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j8AAfDKebClLANe5XecPapMOg8ok95sQnXWyUWBLfA=;
 b=C1UFXMMK4ey35Rm7p5Pajb7BN8zu0hg2tCJN+AOI1IvBGxQWu1l/kP9bosLWkS/n4DrOwa39BvT+ysffJz95Jlb0LWDtBA/ZVOYOOzl2SGbG43kMduLhHTvm9m0X9dX+XU6J3YAi5XvqdkXE8HYknDe+wZUgL53qYkBIwnjc0Js=
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 23:13:41 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::85) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/8] drm/amdkfd: Add unmap from GPU SMI event
Date: Thu, 20 Jan 2022 18:13:21 -0500
Message-ID: <20220120231322.10321-8-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 504fa2a7-1263-4d98-e3ce-08d9dc6a7f5c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3872236365FCCAFB728AD7FDE65A9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGfyhF/6Cyr8VS09qwtsozw/8NoHgdPZ+5i+zcQyxlVg/XVNtwwYXQAmFZ3n4rnWMCEO7NliZFExlJsf4SGWz8GD8EbwWt/DdFuoknncsytGY9Wbj5hE1BMbXtrZk+7YfK90nzs7YErkaqmHZHhHRSgTLUFQwjSpRCOicJeZ1P5k9f3MoQGRHxn7P1EC6Oz5UTk6bzHSXxFsuJT2dXJzu2YEk7uGs0LgkPvD6RSHvKbWIdRnZ3PjrhLAUni3Cnp9qm06AC9hkIcPH4If327SjTThiUDhWxIOgbncPFJ7LCgBybm1g65G/uu25nVVJkfybdK2ycOA2yZRmpDcPvCipoBfO6hA847LjTJycm00nnd8pdal9XrdVvHucYpE1JGB3Y3YVQvT85vO61cRtRZuqcOAR6BUD3Ka1httswxIqXpIs8mxv+zZvAJRK2+rsbW3hJAUxCkaL1CJNg9rgq5Ie30cCMVjnSVRK62LFonWZIUcG0LRNNfvsjtYU0bYn7Tz9UtoYNXSN7vAg54IRCWwnhctWRVwlFi3WUy1jvxZQ70LsysLEnwUybNZPoal2/YtWjXmJ7zb198D9TDvFUTSMGLOPsx6PN6Y785QP9ClNMfJXgn8wm+kH4PBq5V+Ezrs7jdC8bHRmHjkOgo7gKwRI8wUXv5fGGD/RAEsGBnDg6SgQSzXMV6NcHmqQQ8EAjbuOzDbZ75lNaOBl6+LtyWhJVKAGCt0JWsW5D8JnzK+FF8a/H/sxbDWjk+yC7TAWDJARIV/zmeGL7FdWj0Lu0pQ0HDBelSeaDbhNhPWUEVDy/g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(16526019)(70586007)(356005)(83380400001)(1076003)(4326008)(6666004)(508600001)(70206006)(7696005)(2906002)(47076005)(5660300002)(186003)(8936002)(82310400004)(426003)(86362001)(6916009)(336012)(2616005)(36860700001)(316002)(8676002)(36756003)(40460700001)(81166007)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:40.9355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504fa2a7-1263-4d98-e3ce-08d9dc6a7f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
xnack on when range is evicted or migrated.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 14 +++++++++-----
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index facc8d7627d8..736d8d0c9666 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -377,6 +377,24 @@ void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
 			   fifo_in, len);
 }
 
+void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, unsigned long last,
+				  uint32_t trigger)
+{
+	char fifo_in[64];
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
index d85300b5af23..7d348452d8c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -43,4 +43,7 @@ void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
 				  uint32_t trigger);
 void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
 					  bool rescheduled);
+void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
+				  unsigned long address, unsigned long last,
+				  uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 30aaa9764067..f8e6c8269743 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1191,7 +1191,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last)
+			  unsigned long last, uint32_t trigger)
 {
 	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	struct kfd_process_device *pdd;
@@ -1212,6 +1212,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			return -EINVAL;
 		}
 
+		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
+					     start, last, trigger);
+
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
 					     drm_priv_to_vm(pdd->drm_priv),
 					     start, last, &fence);
@@ -1795,13 +1798,13 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2214,6 +2217,7 @@ static void
 svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			 unsigned long start, unsigned long last)
 {
+	uint32_t trigger = UNMAP_FROM_CPU;
 	struct svm_range_list *svms;
 	struct svm_range *pchild;
 	struct kfd_process *p;
@@ -2241,14 +2245,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
-- 
2.17.1

