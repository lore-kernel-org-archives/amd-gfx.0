Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C8CD6E4A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 04:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B4310E2C3;
	Tue,  2 Jun 2026 04:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIIlsiKN";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5BC10E2C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 04:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpDtL3ZVG8f1sB7tlBb3+YIKjpFIXe3z5/xWInnlcXAUs41VI7NmHoU84hr62oXUJFOs1nMVu0V+YA/WnV+td1XQzgT7Ytj4FmVZ319XtolO4gYyVTbb3lGHtEqdDBh+kHsCj3GoEWHy4FX5FKO+ChOcoYvrxqgW+VG61Brw6xZ+xGdFnXV3UFepshy0t2Y1RPfGMbiXTlPWSx/jp83QcXchdBwiJziYptdFFbPqy2TZpW4nu/XeG9MsaXOXqnipJqrV6Q2NL1o0bMFaPu4AtfPefhoIHmiFv0yOCgo1ekgPQWPN64KkzFSZrUD0/rpIncSXUBTgvxJMfFyw+U0NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN48xtrX3LXJwMJcyun5sFjDpk6hM2um7xiKjV9x9MM=;
 b=u+XwylhGA4/cAgI+ykX0mzike8yY2odD5Rq5R+dVmgoX5fMlVb816Rzj2wVrWhTMk7RfQ0uV9bW+vv6IFaOLa4GOB/RQimUmS7AGBrZC3m14HFgOOsRGGcszRIh30DVhq/4d+bBXHDAaRArTmcXXe6uLEzW5WJdsvxklcM2uarrACAEJEjZLymEKwXBM01L8uiF03VQW7gWQusJGH4rSVtgY9cadcwnw2H1QL4ZhdYXFiJujYk9avb03wBtvwVnaERtmyYD5PUiXo9KpeJFtuy8U1m1OTCgVcKGEGTJsNeoB8TdzEp0r3ibGZym1Tlb4q6KrNByVMZETpwpCS5xeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN48xtrX3LXJwMJcyun5sFjDpk6hM2um7xiKjV9x9MM=;
 b=qIIlsiKNFZTnC9OmDA1Jyhx/Cn1LMQoSP6kMB1v2S1PUJbVDKHLrbOPOajYNeJ3eqBHFHy01+fR6CylltuBcK+EdRj/0g8FZyStf3Lm2zRN2AT8USCqYewyS4xqljdA/BRt1Qp57KYxTsOF5Hjac91sKD8YLSZGRQlirQGNTrwg=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 04:46:51 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::22) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 04:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 04:46:50 +0000
Received: from amir-devpc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 23:46:49 -0500
From: Amir Shetaia <amir.shetaia@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <david.yatsin@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>, Amir Shetaia
 <amir.shetaia@amd.com>
Subject: [PATCH] drm/amdkfd: distinguish rescheduled queue restore in SMI
 events
Date: Tue, 2 Jun 2026 00:46:34 -0400
Message-ID: <20260602044634.3285829-1-amir.shetaia@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e139d18-6347-45b9-0a66-08dec061f61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|5023799004|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: K94LXCzE512PVa+rddhJn01S6NAutQ59T/0yvxN2gDM7SyiQijvgLmpTlp1YXf9jaXR+cCceCgR0ny9nuusQzPCPEAb0XdpDqsPs80RFMa9u5FLo9jyz2sIUttha4uvMhWg3HvZrbqnGBub4wZn0S25B+jEBhJ4eMjxxDj0VoXBq+ekqINfOXXhlJyFkjibga7nAQLCiQd1/47lgfs/Ho0iKNfBCFnDVJlixe/nSPeBGo3v+SV9urnYlR7ek/nwp5lfmCLEJyVnNRXiB+18fgPesOeWBtxY6/Ks066ehqXIbgOpNhRyvgULhm+EsFM8BPDH+1q5XvGt0QoT3BB8bkIchC4UeB4eMdWVM7R6fO776ep9LXqKvBR1AF0X7ZcqMOjw/E21B7InPS8MgirPpM3B4aJDE2EaLeyuVzGDaS01a2Y9roGY2Ejsw6Q4XNSP3EH7Zh7eW5wUVAgDzYpWYg8XbKcPrJAcyte9Fr5RtrzrN+tox6gqd9GvhSqGocuD8DJSimLiBZza9M3mRFP/0+t1WuGdSSHMRncLqC0D3wr3YS0d9tK/H97IenSUg6aBNw8/EWLaIwzoJKv564El6lqELNEmJXnJ/Z2DDNNlxje8sIhguELsUbJp9ZEjw0MfQHfSnvtMujM1zHzVO6U/EHI2Q4Wpjf8N96Dip2CVLNLkPvxU6nhq2o2vLJB+62fHRJVDGXW24PeRWSaNSCmfArFoFpbAS/USyH90ChE1i1S8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(5023799004)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5tS4O7gr9zuxSFOMERWtob5dpBJ/llizvb0eWl88X6LzxZDo927hVn7czSRBRNtc0VQXdLMYISsvUTVaJKptfCK+J97etbRI+FUUDlx4XqCrYfD2caIpnDWepV6vl6gd7/ylzhXw3vIloE3mV1Wx9MHQDMoAjNZas3L9m1iHuSUmnTDDNuoBe9JhY4ducWJhE1trBPqBqdRs5hZvysE0iPStNXcQN/JlCw4/ifMfwS1PpCSqzONdrQS0NVqdWgdZwNZTXtYEgoA8RZyn38SydrKwmhbjLmrV63nHRWMaEsxzzuktY/B3UkncaLUJfRrWkH35VTLxVzZtACS/RwFqRpUZ4bPExLSJoGUr7DOWfHDJbYdHzF4ZLaoB5gH304w57Jd27LtYxhmp3po/dqaQ3n13e3272E7UhrvtafpPUZddoMUt+2A4rhfGet8ncfOs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 04:46:50.5262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e139d18-6347-45b9-0a66-08dec061f61c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SMI event interface used one ID, KFD_SMI_EVENT_QUEUE_RESTORE, for
both kfd_smi_event_queue_restore() (queues were actually resumed) and
kfd_smi_event_queue_restore_rescheduled() (the restore_work cmpxchg
failed and the work was requeued). The only differentiator was a
trailing '0' vs 'R' character in the QUEUE_RESTORE payload format,
which userspace consumers commonly do not parse: rocr-runtime's
svm_profiler.cpp reads only %x for the gpuid in its QUEUE_RESTORE
case and discards the trailing byte. As a result, real restores and
reschedule retries appear identical in HSA_SVM_PROFILE logs, making
it impossible to tell whether a high QUEUE_RESTORE count reflects
actual queue resume work or workqueue retry churn from a stream of
mmu notifier evictions racing svm_range_restore_work.

Encoding semantically different events as the same event ID + a
trailing discriminator byte also makes the QUEUE_RESTORE payload
format inconsistent with every other KFD SMI event, which use a
clean (timestamp, pid, gpuid [, trigger]) layout. This complicates
parsers that handle multiple event types and is the kind of
asymmetry a uniform format avoids in the first place.

Add a new KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 14 enum value
and switch kfd_smi_event_queue_restore_rescheduled() to emit it.
Drop the trailing %c discriminator from KFD_EVENT_FMT_QUEUE_RESTORE
so both emitters now produce a clean payload of (ns, pid, node) that
matches the shape used by other events. New consumers can subscribe
to the new event index via
KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED)
to receive only reschedule notifications. Old userspace that does
not subscribe to the new bit will stop seeing reschedule events in
its QUEUE_RESTORE stream, which is the desired behavior; old
userspace that relied on the trailing %c byte in the QUEUE_RESTORE
payload will now read nothing past the gpuid, which matches the
format every other SMI event has always used.

This is a uAPI-additive change for the enum (no existing index
renumbered) and a payload-format simplification for QUEUE_RESTORE.
The companion ROCr patch updates svm_profiler.cpp to subscribe to
the new event index and surface it as a distinct log string.

Signed-off-by: Amir Shetaia <amir.shetaia@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  6 +++---
 include/uapi/linux/kfd_ioctl.h              | 12 +++++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..a7870fe81ace 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -312,7 +312,7 @@ void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
 			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
-			  node->id, '0'));
+			  node->id));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -328,9 +328,9 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 		struct kfd_process_device *pdd = p->pdds[i];
 
 		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
-				  KFD_SMI_EVENT_QUEUE_RESTORE,
+				  KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
 				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
-				  p->lead_thread->pid, pdd->dev->id, 'R'));
+				  p->lead_thread->pid, pdd->dev->id));
 	}
 	kfd_unref_process(p);
 }
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 9584b5aab727..e911edf1911e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -545,6 +545,7 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
 	KFD_SMI_EVENT_PROCESS_START = 12,
 	KFD_SMI_EVENT_PROCESS_END = 13,
+	KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 14,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -623,8 +624,13 @@ struct kfd_ioctl_smi_events_args {
  *        stops during suspend
  *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
  *    rw: 'W' for write page fault, 'R' for read page fault
- *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
  *    error_code: migrate failure error code, 0 if no error
+ *
+ *    KFD_SMI_EVENT_QUEUE_RESTORE indicates queues were resumed after eviction.
+ *    KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED indicates the restore work
+ *    failed validation and the workqueue was requeued. Subscribers wanting to
+ *    distinguish the two should subscribe to both event indices; the payload
+ *    format is identical (ns, pid, node).
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
 		"%x %s\n", (reset_seq_num), (reset_cause)
@@ -653,8 +659,8 @@ struct kfd_ioctl_smi_events_args {
 #define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
 		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
 
-#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node, rescheduled)\
-		"%lld -%d %x %c\n", (ns), (pid), (node), (rescheduled)
+#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
+		"%lld -%d %x\n", (ns), (pid), (node)
 
 #define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
 		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
-- 
2.43.0

