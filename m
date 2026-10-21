Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D56606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1IBT/5QN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CFD10FAA0;
	Wed, 21 Oct 2026 08:30:44 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D5510FBD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 08:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuTOeEuHi/e+NMTwCkqhyPZTHdB2NkpMSX13v/p+Kup6q4gXPG9PJVK6ORaAb/w17lNudp5WS8cfsFAL3hdoMgt9cdXsZydhXBaup5lUx8mL1YB3jI/tWSf4yiyq6kI2+CYJe8w5Cd5/NhpITk+8K96V1ksVH7HEKWtcSksmwji+Hc8TXOQLA40hRKS1YCGfiFGtEh8TzbHhTTXmMGLPOcdSUpuKdh74bMaz/C95mslQjwZImsRaZ0BaWLQ/7x357TJjpxSfGs561OP9NTxsmOmimBiqr9RBfLfUCC5NNvYtDvoU2GEqlgHKekUw+kDnqR5SsI/VdwEQbDFqmC9IYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+eCt/6RTMhJtHVDFrY2EiwCPX3lk5P8Fep4VE9+9Yg=;
 b=O+q1Y59oOxlIG0eYyOjxM87WsnEhHhziJSqxRmnSF/BWTZiAdSRCLhqEKCF6oJerAStVvTtKdTiTKCQz8gPWf/noRmJFe0VebKZLvhLFfdwadfnL0Hr34VnF7FcIyicLh5g3JXsah7ESU47qHQ6fqrabZczXRAXg7p0vo8O/uP4BUCpUlk7SDuGEG3Q+HeQeMkoJc4b2FY8JUdXhk1dztBSLEQAkNlyu6JFk8airKbAFJKHiQmMU9NQeeK9p3J6tRZYoAF1o1QpvyTRedQlqe10Cm5dO1cmBobQjQ8/oRqJdecKEzE2OdPBmm7RPPgaBHaZ3ZxZ/AiNpttEHSc91UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+eCt/6RTMhJtHVDFrY2EiwCPX3lk5P8Fep4VE9+9Yg=;
 b=1IBT/5QNTn3e+W+18XyMIidnSr3WgPsMFE2bt9UJb9jYKptsRVVJqw3SpIauiwA95M2qkjBcMAo9UNc7pfpGhCLP/3lD0eI4sFFqzEY4QVn6s40n0q70meM8qwPkAqDgMkobL8UanYEKa7o7KU2C7lhbzMOPNlfQcyMEi475Dlo=
Received: from BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::13)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 08:30:31 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::4d) by BN9P222CA0008.outlook.office365.com
 (2603:10b6:408:10c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 08:30:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 08:30:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 03:30:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 03:30:30 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 03:30:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Amber.Lin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: send SMI process and VM fault events only to
 allowed clients
Date: Wed, 21 Oct 2026 16:28:42 +0800
Message-ID: <20261021083027.3460995-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c61dc61-b191-4fae-4492-08df2f4d9142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|5023799004|261009223027099003|10067099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: PcxZg3oaDcryHdXMs94EioMNKl99PDN6vbRurOxiCPmhdsXe46c2oOAMCYUtbIrXnHHAlNlk4awEPeBoC6U/74iIpXZZHv3ZZWEAmC8u9Dpb8joAIc+Rbfs+RfTm92id3HHQV6yqNTvR0H11G9hCN/MACKY+ZkbjbhoBdsueZ42PjDNpvD0uI/HWKlGXsMQf7mDnKpA4meQtXuYB3tAZpAo+4KJkUYVzy4VT08uaUeA6hhydDB2Mn6diJpTGkLTGG8KCK9VC2FnZTh5S2tnODtL/06HJiA/0uxbqMxn5QXYdS0oXJrHmMIUmDQufTLL0Z8pv1+tJ+jxBpO62y+1jXqRpHlLwcqmsYCoVp2/PajAf5k+Kfv3ytQcfsHP7Z+i/1LOXy+MtSQr63FrRkT0R7KX/RF18WzOlF6fAWeyEBsvQLYaHrZOkmscKW2xMaVrgTGnq2dFonm49JbhsXcWwZXF3RfBXKbOzPFarwT9+im+35avmfpZcUXHLtPF7mUb9ijbDCVa2Mc4PCmqzacmNMBON9TVlOik8wd+AGo7/o+XoDgceOYW3151LrvqMhbe+VUexx+ao1EX/gTwlNIsWSngj+dX91woJkADoZ8PpmeR651pzSLj0hRpEr+6dF1b3RYsfwMP1t8G676BTO3mHM5zEFFF3U0K69e8RiOmuAbB1cth097hyOTLrPu6gEgdTi9yD8RlV3jEHm1DwxR/Dew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(5023799004)(261009223027099003)(10067099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1+P/zS8rqgrMb+maHykUgpHWchHclYy/rxsOnsFztN3ONj8+5D5SQh1WTWZHITpQ2dGZBd8E6GBeJd4nHllN3uLo7a5+m0h0LiOWOe0FgDjTcu9V7jr8KjlYQgEVP4byUBx5Y6sgCepqf/C/ZZnMYLbAeSvi3Z2lP/YADc67kGmJ166uQGZ7wJ0cWRHhgO0k8dArOnYFpYp4sdB8u4Q4NiDoUZyi0dkjUD7mracUStEXOc8KPFFPxU6Sf5jdj/t5EzV2plyn6YxPdf+JKHZmTtemr9weBGOKrAkAtPfpKSKp61YX/OmJcJdSBiCLFK9r/VsjUpnWSzqFYQ9HXDj5uWPZJqBHKf3xTWAwziWlqE1D231s8HEGJogvMFkBBxN5B5fTFJvnloTm3TrsHCntDaeNRPg++QXoj5PZZBEpYZ2jpSyL8gfV/JUQANddy9pd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:30:30.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c61dc61-b191-4fae-4492-08df2f4d9142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v2: rename the pid of the clients and of the filter to tgid (Felix)

Fixes: fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID reporting for containers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 60 ++++++++++++---------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6a7b4d959541..c87370a9f5f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -40,7 +40,7 @@ struct kfd_smi_client {
 	struct kfd_node *dev;
 	spinlock_t lock;
 	struct rcu_head rcu;
-	pid_t pid;
+	pid_t tgid;
 	bool suser;
 };
 
@@ -160,18 +160,18 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
+static bool kfd_smi_ev_enabled(pid_t tgid, struct kfd_smi_client *client,
 			       unsigned int event)
 {
 	uint64_t events = READ_ONCE(client->events);
 
-	if (pid && client->pid != pid && !client->suser)
+	if (tgid && client->tgid != tgid && !client->suser)
 		return false;
 
 	return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
 }
 
-static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
+static void add_event_to_kfifo(pid_t tgid, struct kfd_node *dev,
 			       unsigned int smi_event, char *event_msg, int len)
 {
 	struct kfd_smi_client *client;
@@ -179,7 +179,7 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
-		if (!kfd_smi_ev_enabled(pid, client, smi_event))
+		if (!kfd_smi_ev_enabled(tgid, client, smi_event))
 			continue;
 		spin_lock(&client->lock);
 		if (kfifo_avail(&client->fifo) >= len) {
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
+	client->tgid = kfd_smi_task_tgid(current);
 	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
-- 
2.50.1

