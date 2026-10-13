Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487B8CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89F10F65B;
	Tue, 13 Oct 2026 09:22:19 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C80210E75E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjLAoQxvcawmQg7w62OamCluh22cLW6bqJvhmbribdb4ye4eFLoPQ5o9vlaVdLvvbJK5/zLGed9uDQh0+p4VcnHbZuCumg9zGPgyuuSmbVdsJArld2iPn5xns6tdkSVOfdIgJF7MuWcaA/nkHROevUMIjNV9ARrMABBFZ/OsT4QfSYMGDYqmEu94Sngr3EGrOYlgNCelC3XeDsXMS17u98Kyj9riaF8GBICmp49ghzClko9lr6chOvGFk5PeqFqG/i4oSm2bSYdUMYPDhCcipI3dhD+ZDQ4CCNJC/hG4IMzzpd52prw2UJMEr6383XM4ufkj6Ce0l59WGiXz1Ip52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjFSo+ZLpJfi4Ho313pn6AN0ePq0+HPA7MIk1jxGf8w=;
 b=a9ZviSPG9P1xLSb4IZ2RMNL0rWgmHJtosOxC0dDKDogXbIVIQaAMMz3eXl62qBGiXK0fPOSxRYnYGMbxg5O+AJapf09uUxEcS82G2cX/WMFwBDpy9a1SgbgQM90LGP6vjqX9Q45lB3HwHlCKin5ehtZd/SbocX01RT/yPLlilbYz7eMEeIBkxtPeH5aMOKd9gllCzP01+PblbZDS8c4UmC+lzjYSUAQ0D7DEDH2GL2BDwpXUmidFuisklEdwXX9R8TYiZruJpTkiA2sJY42An5I9tpFHkU3phth48aXmD4LV9WSBvfiS2ehiNPCAfhq1nsdNJFfCshDdzDTvBSfmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjFSo+ZLpJfi4Ho313pn6AN0ePq0+HPA7MIk1jxGf8w=;
 b=JNA/Hg1xAoHMK2TEJpizeVKU3mvhyASkjxT5D2Iw5Mc66+LhCcws+2Nwb2rEwv2biSZYuX26KbbGGsF8V91INKWNmNtw+XWZ1QvFpVnHLFAtgRqjjcQIAkHUUXoRXFySIx0OCeXwMQoZdv0YR52nNc0mECcTLmkmRgAFsNqgkIs=
Received: from SJ0PR05CA0175.namprd05.prod.outlook.com (2603:10b6:a03:339::30)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 09:22:06 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::70) by SJ0PR05CA0175.outlook.office365.com
 (2603:10b6:a03:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 09:22:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:22:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:22:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:21:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 04:21:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: send SMI process and VM fault events only to
 allowed clients
Date: Tue, 13 Oct 2026 17:20:44 +0800
Message-ID: <20261013092158.2261502-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d543de-6c16-4924-bd88-08df290b7303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: qfRzGkdYYyylEQ5k+i2MZ5Nrs5hbDJjPJ1Aa67yGjLAv59ygQ/W4uAnOMK6PEi3eVmSzMZnsa40z/D1xwO/pSkN9NAnhPCuEMpH5vffVb3bTGG6bxh0OLCIG14K3t3nQRmXN+gMufNi6PWwVuXDXqIdAnpbMhHGtSRa7qYz8vzBok9lpGgEXVUha1b2DSrAJfZ492VuwRSCQUlM2I9Ok5pMl2nWME0tNsJof/6x0uLqpdZ1WxcjGM65jYSl5VI1V7WU+NmPxsyvDeerEwajJbPcUJp6t985+cP+fr3FQ9AFJ7DRilH9Bv2zNkPyifARK7dpvyo9GYh0XILnsUlZssuxWERg9g79hIpeB/mpAIuNe25yh0JaPN2wldKe8VfKRaY4qaNN1wB9ce/i8XkDavwuY/wpjDEz2fzQkBLLSXBs+KAqR1s2NXDLysmaIE+j69t5HUdzBkJighoCb4sPNALLZ8cZbaZQ8Lrj3f2/xA8b+z0KcL0D6ANc3Dk1nujbCZwYYIBW1/Og9AVpdEOhgUOs8daNqkJ9NDZPdd8zqEATQqyr85BfGWy2wM54XzDMZv1VOVxN/wkCccHGx//a7m4uATLO9wnAbzZ92G0K76JKNFHsdHUjei7OEjKffakrh6aPBxrIAna91VsjDaoXVqoCq4ID7Knd/y2fPbYsrv+/W8apIclFTNjA2tq8OXV8DXYiM0T+/Kdz1H70OlqzdjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jai10j9zBLXzBvONQ1Likf1DdMpbwtSqebU+ZSQDf0JiqxVNXq/jQHNIV5mV6yof02BOvOdtYfkeZS/LC1xvmKvCbJTy/buZZX13ASWOXkKKs4YN2vFHRQWk9bjV6/1XpPsAE+sGGJCo4w1l9LSqu7tRd8kanlyc6+IW3YVgqiYMmCPeDcgrmmC6Xd8kV9r8YIqI43ICjgW67hPsJ+RNwN4KfNgq9RJYImVqvT8p59MGbjuYhFE5j6vt8t0DOyhHL/IAMKec2e1sc5RYEbNmjEfNroBn+49nN+9xMcT/ulP3b7knp/eZ+5nsyiW4ubI6XpqOD9qf96jTr4n4jueTp9DNEWJZ7IqC88So8cwe/42kMxHpUgbJ8RxwNRTTjSpvjRZMl8wsghXOcympySNxva85lFWBfdhkwbV/R+AQDyyWt9l6RqFtSeza0iLos2ya
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:22:05.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d543de-6c16-4924-bd88-08df290b7303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

Commit a403d3f65c79 ("drm/amdkfd: fix SMI event cross-process
information leak") made the VMFAULT and PROCESS_START/END SMI events
carry the pid of the process they are about, so that
kfd_smi_ev_enabled() only passes them to clients of that process and to
privileged clients. Commit fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID
reporting for containers") then switched kfd_smi_event_add() to take a
task and passed NULL for these events, i.e. pid 0, which every client
receives again.

On navi31, an unprivileged SMI client (uid 1000) subscribed to
PROCESS_START/END sees root running rocminfo:

  event: c 223a9 rocminfo
  event: d 223a9 rocminfo

The same commit also made the filter compare PIDs of different
namespaces: the client stores its PID in its own namespace and events
use the PID of the task in the task's namespace, so a client that is
PID 1 in one container receives the events of PID 1 in another. And an
exited task has no PID in its namespace anymore, which gives pid 0 for
PROCESS_END.

Match clients by global TGID, which is unique and stays valid after the
task exited, and keep showing the namespace PID in the event text. Pass
the TGID of the process for the process and VM fault events again. With
this the unprivileged client gets nothing, a root client still gets both
events, and an unprivileged client that is PID 1 in its own PID
namespace no longer gets the events of rocminfo running as PID 1 in
another one.

Fixes: fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID reporting for containers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 50 ++++++++++++---------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6a7b4d959541..2950b871cb7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -210,27 +210,33 @@ static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)
 	return task ? task_tgid_nr_ns(task, task_active_pid_ns(task)) : 0;
 }
 
+/*
+ * Clients are matched by global TGID, which is unique across PID namespaces
+ * and stays valid after the task exited. Events show kfd_smi_task_to_pid().
+ */
+static inline pid_t kfd_smi_task_tgid(struct task_struct *task)
+{
+	return task ? task_tgid_nr(task) : 0;
+}
+
 __printf(4, 5)
-static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *dev,
+static void kfd_smi_event_add(pid_t tgid, struct kfd_node *dev,
 			      unsigned int event, char *fmt, ...)
 {
 	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 	va_list args;
-	pid_t pid;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	pid = kfd_smi_task_to_pid(task);
-
 	len = scnprintf(fifo_in, sizeof(fifo_in), "%x ", event);
 
 	va_start(args, fmt);
 	len += vscnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
 	va_end(args);
 
-	add_event_to_kfifo(pid, dev, event, fifo_in, len);
+	add_event_to_kfifo(tgid, dev, event, fifo_in, len);
 }
 
 void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
@@ -252,14 +258,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 		amdgpu_reset_get_desc(reset_context, reset_cause,
 				      sizeof(reset_cause));
 
-	kfd_smi_event_add(NULL, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
 			  dev->reset_seq_num, reset_cause));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
 			  KFD_EVENT_FMT_THERMAL_THROTTLING(
 			  throttle_bitmask,
 			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
@@ -271,10 +277,14 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 
 	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
 	if (task_info) {
-		/* Report VM faults from user applications, not retry from kernel */
+		/*
+		 * Report VM faults from user applications, not retry from
+		 * kernel, and only to clients allowed to see that process.
+		 */
 		if (task_info->task.pid)
-			kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
-					  task_info->task.pid, task_info->task.comm));
+			kfd_smi_event_add(task_info->tgid, dev, KFD_SMI_EVENT_VMFAULT,
+					  KFD_EVENT_FMT_VMFAULT(task_info->task.pid,
+								task_info->task.comm));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
@@ -283,7 +293,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
 				    unsigned long address, bool write_fault,
 				    ktime_t ts)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_START,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_START,
 			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
 			  kfd_smi_task_to_pid(task), address, node->id,
 			  write_fault ? 'W' : 'R'));
@@ -292,7 +302,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
 void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struct *task,
 				  unsigned long address, bool migration)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_END,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_END,
 			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), address, node->id,
 			  migration ? 'M' : 'U'));
@@ -304,7 +314,7 @@ void kfd_smi_event_migration_start(struct kfd_node *node, struct task_struct *ta
 				   uint32_t prefetch_loc, uint32_t preferred_loc,
 				   uint32_t trigger)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_START,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_START,
 			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), start, end - start, from,
 			  to, prefetch_loc, preferred_loc, trigger));
@@ -315,7 +325,7 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
 				 uint32_t from, uint32_t to, uint32_t trigger,
 				 int error_code)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_END,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_END,
 			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), start, end - start, from,
 			  to, trigger, error_code));
@@ -324,14 +334,14 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
 void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struct *task,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_EVICTION,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_EVICTION,
 			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), node->id, trigger));
 }
 
 void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct *task)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_RESTORE,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_RESTORE,
 			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), node->id, '0'));
 }
@@ -348,7 +358,7 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		kfd_smi_event_add(p->lead_thread, pdd->dev,
+		kfd_smi_event_add(kfd_smi_task_tgid(p->lead_thread), pdd->dev,
 				  KFD_SMI_EVENT_QUEUE_RESTORE,
 				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
 				  kfd_smi_task_to_pid(p->lead_thread),
@@ -361,7 +371,7 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struct *tas
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(task, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
+	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
 			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
 			  kfd_smi_task_to_pid(task), address,
 			  last - address + 1, node->id, trigger));
@@ -379,7 +389,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
 	task_info = amdgpu_vm_get_task_info_vm(avm);
 
 	if (task_info) {
-		kfd_smi_event_add(NULL, pdd->dev,
+		kfd_smi_event_add(kfd_smi_task_tgid(pdd->process->lead_thread), pdd->dev,
 				  start ? KFD_SMI_EVENT_PROCESS_START :
 				  KFD_SMI_EVENT_PROCESS_END,
 				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,
@@ -408,7 +418,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
-	client->pid = kfd_smi_task_to_pid(current);
+	client->pid = kfd_smi_task_tgid(current);
 	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
-- 
2.50.1

