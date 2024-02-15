Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E80C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 15:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E09310E952;
	Thu, 15 Feb 2024 15:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFvFM+B+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDC810E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 15:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnG4+0Rw8+OeHO/238R0tnHfk5WyGxxjZsodwVRJj0KJqRCS65chvJHfp/IEbPWh+MdgJfP9rCLDn4BCqQsqYjmGfh3vfXGXG50OfVu8AU2/s886k9AkDWYCJAaKdX+BUmzPkgIj9vF1jznVjUcKmTdqhv5vgd3pmQcL/kCruC4hgdeK2u8aOU5+es4P/5wTDQlwOtdWG7wx+fyGDz1uv+kfLSSRukB8OZek3M2J2MuREj7/mr/UmPPoW/TmH4Ef/iQEjPegxtkovRCaZPJ1RZFNt2kcHP2/siQ357t7mOyZfA3bOEUTvJ4DsGJUAFXnyeMM0+s38HxVETqU5bmedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdvOQUB7m9rI/mTUOIr3deGqEHTdTSb/tdworNVwksk=;
 b=BwRUqcd4Z6WMzKB2QIHVx94V+eO5C1Q9wPTN1I+LtmY/Hh/mGZlKFdPTKY7WOn11t3wqbjTWVTXhW6pDjohZNpCeE01gJDiREyeGc/CC/uRApw2rRfxLBSv7yU/raEINg6Bwl4bFjBGJiSqi/G1hBlP/SVcZls5ESDhAdIVpalaj25Wub4AiHPvky+zrHfucNBpt1TgrFlL8E4BF8PrNwRpN2PE7sss75yuF2CUDVNKxu1dug1wBHNgQayxCBGZX5U4S3pZFTTfOltiS9WGw909664tSyQm2oGzIg2uwV3eiZW/4CAEoc+6hnYdhTs4BPdD9NvcvKI93bjAYYPzFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdvOQUB7m9rI/mTUOIr3deGqEHTdTSb/tdworNVwksk=;
 b=uFvFM+B+xvqNStk0ZeoOo0uNRzktgZSdgcyc0Q42vh8HzYOkpgu357EyHtLkJNl7qrDb4Ss6n6PyyePld4N5Fi47sIpeQCw9fmPHEK684lb/cqP1wGaQ5H3lunIQgt55TXaYRQLwYI0Ex6fR9a7jPLHLy6VB0GrMYUvEgzVSIl0=
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Thu, 15 Feb
 2024 15:20:17 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::12) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Thu, 15 Feb 2024 15:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 15:20:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 09:20:14 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Document and define SVM event tracing macro
Date: Thu, 15 Feb 2024 10:18:29 -0500
Message-ID: <20240215151830.22416-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf0d9a5-899f-4789-2630-08dc2e399ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItN61EeeysnIw53eRgHenlc/kbuJ77dlnGcpY1QEGPJFIT+Vcm8xllcyfJKMdJewTgFdrPAHh+4jhV1hapRD115QuLVQglaq+Rw5gvMi8JBgNvsS9cB+gCasIiOZ/mYMpznHaJC9l1op4oUduzcarE6Xg2fDo7glqMRF1z0oKecOwLtlnYSWZEE4SaDbiSr77ig7/oA9kCmrZgYvzm5Y2GnAXrPHjZUTlRZS7uNex9mUrAj4KTeDydm+6z1sKmhFAnX90dp4BQ6pZRduav+nEfLYbNN8KBaq5CdUNey82CcF2PPMkk1hBrcAc/NId46cy/y54xZ9uxLkftFe5kAIatWf5W0bqKn4dSU5SMmiGBINpVnKgIsLQ/I24pTj16nZ6J1MHbFj0fwwYZRHdtp/8MS6h/Gh6RFo2FINFr5r0a1EO0C3oX1nAznTCpf/Nay3Ou2yqjsOtanVMviuFsaxOgujFo+vTFd2XZb3fg41KSC6VfbcMx35O+2PzloY+kyY+Vi2nLG23ie5jPZP7AblBnbVc/eat0BvT66NHOCnqaqcL6qXaiUPH1OadDS4FhSWd+JSnryzIVsL0AMEvzfYsIEta6+fJTiVdFfOrmIZVgjlVFmig28920eNyIrjSV3AjetzgBu8rSCoS+OJKUiQh4DPAlMoXOrZfGF0//aTSEc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(82310400011)(36860700004)(1800799012)(186009)(451199024)(46966006)(40470700004)(7696005)(8936002)(6916009)(8676002)(356005)(4326008)(86362001)(478600001)(5660300002)(82740400003)(70586007)(70206006)(81166007)(2906002)(316002)(426003)(336012)(6666004)(54906003)(36756003)(41300700001)(26005)(16526019)(2616005)(1076003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:20:15.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf0d9a5-899f-4789-2630-08dc2e399ccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
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

Document how to use SMI system management interface to receive SVM
events.

Define SVM events message string format macro that could use by user
mode for sscanf to parse the event. Add it to uAPI header file to make
it obvious that is changing uAPI in future.

No functional changes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 51 +++++++-------
 include/uapi/linux/kfd_ioctl.h              | 77 ++++++++++++++++++++-
 2 files changed, 102 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..85465eb303a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -225,15 +225,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
 	}
-	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
+	kfd_smi_event_add(0, dev, event,
+			  KFD_EVENT_FMT_UPDATE_GPU_RESET(dev->reset_seq_num));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
-			  throttle_bitmask,
-			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
+			  KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(throttle_bitmask,
+			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
@@ -246,8 +247,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (!task_info.pid)
 		return;
 
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
-			  task_info.pid, task_info.task_name);
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
+			  KFD_EVENT_FMT_VMFAULT(task_info.pid, task_info.task_name));
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
@@ -255,16 +256,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    ktime_t ts)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
-			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
-			  address, node->id, write_fault ? 'W' : 'R');
+			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
+			  address, node->id, write_fault ? 'W' : 'R'));
 }
 
 void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
 				  unsigned long address, bool migration)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
-			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
-			  pid, address, node->id, migration ? 'M' : 'U');
+			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
+			  pid, address, node->id, migration ? 'M' : 'U'));
 }
 
 void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
@@ -274,9 +275,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 				   uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
-			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, prefetch_loc, preferred_loc, trigger);
+			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
+			  pid, start, end - start, from, to, prefetch_loc,
+			  preferred_loc, trigger));
 }
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
@@ -284,24 +285,23 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-			  "%lld -%d @%lx(%lx) %x->%x %d\n",
-			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger);
+			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
+			  start, end - start, from, to, trigger));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
-			  node->id, trigger);
+			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
+			  pid, node->id, trigger));
 }
 
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
-			  node->id);
+			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
+			  pid, node->id));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -317,9 +317,10 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 		struct kfd_process_device *pdd = p->pdds[i];
 
 		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
-				  KFD_SMI_EVENT_QUEUE_RESTORE,
-				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
-				  p->lead_thread->pid, pdd->dev->id, 'R');
+				  KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
+				  KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(
+				  ktime_get_boottime_ns(), p->lead_thread->pid,
+				  pdd->dev->id, 'R'));
 	}
 	kfd_unref_process(p);
 }
@@ -329,8 +330,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
-			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, node->id, trigger);
+			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
+			  pid, address, last - address + 1, node->id, trigger));
 }
 
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 9ce46edc62a5..430c01f4148b 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -523,7 +523,8 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
 	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
 	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
-	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 11,
+	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -564,6 +565,80 @@ struct kfd_ioctl_smi_events_args {
 	__u32 anon_fd;	/* from KFD */
 };
 
+/*
+ * SVM event tracing via SMI system management interface
+ *
+ * Open event file descriptor
+ *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
+ *    descriptor to receive SMI events.
+ *    If calling with sudo permission, then file descriptor can be used to receive
+ *    SVM events from all processes, otherwise, to only receive SVM events of same
+ *    process.
+ *
+ * To enable the SVM event
+ *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
+ *    mask to start record the event to the kfifo, use bitmap mask combination
+ *    for multiple events. New event mask will overwrite the previous event mask.
+ *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
+ *    permisson to receive SVM events from all process.
+ *
+ * To receive the event
+ *    Application can poll file descriptor to wait for the events, then read event
+ *    from the file into a buffer. Each event is one line string message, starting
+ *    with the event id, then the event specific information.
+ *
+ * To decode event information
+ *    The following event format string macro can be used with sscanf to decode
+ *    the specific event information.
+ *    event triggers: the reason to generate the event, defined as enum for unmap,
+ *    eviction and migrate events.
+ *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
+ *    addr: user mode address, in pages
+ *    size: in pages
+ *    pid: the process ID to generate the event
+ *    ns: timestamp in nanosecond-resolution, starts at system boot time but
+ *        stops during suspend
+ *    migrate_update: the GPU page is recovered by 'M' for migrate, 'U' for update
+ *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
+ *    rw: 'W' for write page fault, 'R' for read page fault
+ */
+#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
+		"%x\n", (reset_seq_num)
+
+#define KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(bitmask, counter)\
+		"%llx:%llx\n", (bitmask), (counter)
+
+#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
+		"%x:%s\n", (pid), (task_name)
+
+#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
+		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (rw)
+
+#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
+		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (migrate_update)
+
+#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
+		preferred_loc, migrate_trigger)\
+		"%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
+		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
+
+#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
+		"%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
+		(from), (to), (migrate_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
+		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
+		"%lld -%d %x\n", (ns), (pid), (node)
+
+#define KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(ns, pid, node, rescheduled)\
+		"%lld -%d %x %c\n", (ns), (pid), (node), (rescheduled)
+
+#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
+		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
+		(node), (unmap_trigger)
+
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
-- 
2.35.1

