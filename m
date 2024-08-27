Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A97C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EB510E3CB;
	Tue, 27 Aug 2024 17:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKbLAzC7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5725B10E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaF+u6gatFXxh/8PW6LcIOo5BgNtTsNCp+oZzH5tx8/sv0z0KyuqOl/7Ne9gUwH7BzQuDai5I/O7gORJLFwd8YfCQ+ijJlwo3Rs3bGjsDuFM9zAQS6806bi6YLVsP+WyHknDq2nbUcH5Q/Qn2FgdxBcw5AYFAvCjJvy1Zva10GlWxl54AISgqUW1vn4p/5YsaeduWOJJK55z9//6TUC7OEEGN+OJZ6MuV5YpJgUFn2VxegDyNDbnrWGkJu1pIiMxJs+asbesOGWzdLOblS6aoOuJM1BH1WUB9alrdpRXtcC/2gshVUaSOn/tRRl3srCEnrniNzS2BsJaOZIVp+9LwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EgjUpV6EElPUZTI8rO/lMCGErbL3z/Dgb4VALB3RKU=;
 b=uAbev3CWN0ZDNefuSy4eqeS4PuTScZiGiHy/N1ToU2f8YypLDP2f2UaqMEq7yVXSftgYW6OonQ5gqjPPZYN+R55bBCA9RoLrKj4IhKdAGveDJYJGD3WFBFNsrnGkejDeXAvy5VYaeQ1Vb2pQ3wI6pTjN5mw5+pkBt3wsQrkeA35I5O1QFUJV9QHXi6L6PHHq3TO96Lzhavi9hYAcaRB0a6JSSP8c5junLiBQhMMRzSHw0VO/cT/EL8Tmotw0+uu9vJLK+foB8c+rN4J0Tt4izrFD7IZWwx+o8d5IpmQ73l3261I+T637HISUS7jF/aMfWv8U4CAsdmX0XD4A+Fba7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EgjUpV6EElPUZTI8rO/lMCGErbL3z/Dgb4VALB3RKU=;
 b=yKbLAzC7AvB/UH3rxdwmdDbatP/KRNuM2cGad1CePGKWIYp0Cadkwv84bDbFjiwlxBJUBqSKs+RvbHTJ5v45zPYYoJLYnzir14/7+pBCyI1yIQAnhc7YHQXOkSxZpdE152DgSBN/+TBBOiR6cbHPmi267J41K1VcYvZQts+dZfs=
Received: from BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:11:29 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::c9) by BY5PR20CA0001.outlook.office365.com
 (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 17:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3 1/4] drm/amdkfd: Document and define SVM events message
 macro
Date: Tue, 27 Aug 2024 13:10:22 -0400
Message-ID: <20240827171027.12910-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240827171027.12910-1-Philip.Yang@amd.com>
References: <20240827171027.12910-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 67df3852-0b0e-4ae3-6fd5-08dcc6bb4a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TB3ugPMyD4/9EMo3wXl7gynMSLvSxXqMgV4/jd2r4U6lC4MZKEZHqzeQMXzf?=
 =?us-ascii?Q?jIjfryEss2asB/EFKXheUWgR+g7JSJrq0iDp+9UYbA8K1wkAvf+3yxXngBFp?=
 =?us-ascii?Q?MHCeIccxhpp4Dx268Cadbgi9pGB4Aw14EAHiRNjENAoLodVInsQcgKMhzWYH?=
 =?us-ascii?Q?WkL+aX5eeVtj9v8YoxTcm6lCxVPwvLa2YdRicVUS4faF8/NjNxtxQFJ+KtwZ?=
 =?us-ascii?Q?TBR/URSL+sanIgT7nTVINKlQJwlYzgiAdUtEMkoV89eQyFetOQ55QhSLDhDk?=
 =?us-ascii?Q?IpzTqxFsQZtXQXKWW/BFccNKK5icqKu4rDl4q/4l3dWfe+7djgAHHUhZaVI3?=
 =?us-ascii?Q?MNNhjT6sSCNIGtA1X2rDd/pMGTkexOXHzR1h1/sLtjGhb93b76B0+lXjWF/0?=
 =?us-ascii?Q?JyZRXGkcz4XzmfIl6lkkujqJD6ksN5FGItz4RfMc2XWXK7NcCxR9WSCnQIyF?=
 =?us-ascii?Q?kezT4379lEEGhfyM951Rc/q+ut088H2BDZ5ci9HV4qXK/yV3TgfbkfDbVUGA?=
 =?us-ascii?Q?zTagE3AbY7zrPanopNIjvtoVLOogeVpTfwdkHzYZa3Ze5SBIuUPsnuLLqGA5?=
 =?us-ascii?Q?+mJpVD+vAUIPPJKBOqiSnAkJPOAzdah8+qnRSnIgacdrJvcNycX/U3q/+fvS?=
 =?us-ascii?Q?z6qiPxVxjLwy995L5FsqtJiLHEQYHtBDKjf1ygwploe6QcOhsX2HFKZbV6Ur?=
 =?us-ascii?Q?z5AbOy/v+KrhE/9GD2Pa+63JPIkDbifIBxdoEeEF3+MQ5SN/BRLVMfZ69ER2?=
 =?us-ascii?Q?mCYl/rlDTvIEERtZLhoy1F0IssJyIwkBHmKb7yjP2keXali97ck99UJtk+3S?=
 =?us-ascii?Q?Q3YjHLLWqM7gE9dzUTihs51rmMq0kXCYv/toVDqlcDIQLc3k5GWePj3Qh11L?=
 =?us-ascii?Q?F1qLQMMoRltEi+4Rsan8o7PHJ4esmlr7KorXaruHRCveJjI3J48gHWJ/kNAO?=
 =?us-ascii?Q?GYfESe/KdEgu4mb81FrHhSMja8LhS6dNFkOE8IbpZO9KPcZtc4OBZcb1gYuS?=
 =?us-ascii?Q?vaYMi0XNYmaK8oFeqUCiurAMtHyz6sVO7dTRFfZMYd1yrl53+CV/PdUr0CUP?=
 =?us-ascii?Q?Ir0NB/IfsV1esNmYTke9u7kHbr8/nBJxIhPqW2WMLb3s0DwzVvXo5QY64VgU?=
 =?us-ascii?Q?N8G/avg7KzTHF6S0FKLEoiTQwJIzkySh8o+2J4arb0GHbAj6e/Dyj17gMKLA?=
 =?us-ascii?Q?6xaAWy6ihhw7l7CI+9HK9+GikdTX+uk3RqBOGOp4AtIeXRa272xKJGuEkU/N?=
 =?us-ascii?Q?MSLZGBn0gZh6glB0cV8KTfDyasOzH58smc4EjxLhahTp2OdvSTOwwEtnWf/t?=
 =?us-ascii?Q?YhdT0CSS1d+L28Ky+gQ5mT1y47Dtvf03qKHGEBpEyyIhUMMPi6G3c7QwfZmb?=
 =?us-ascii?Q?2upIAYngPTMeCAyxUkAHXplINTcHLNVtDp7DZ/4qA2QRdTpx+RlPzzcgRqeK?=
 =?us-ascii?Q?64Kyx6QhiTUlHQFcSM2yLJSEG9AJYWWI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:28.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df3852-0b0e-4ae3-6fd5-08dcc6bb4a86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

Document how to use SMI system management interface to enable and
receive SVM events. Document SVM event triggers.

Define SVM events message string format macro that could be used by user
mode for sscanf to parse the event. Add it to uAPI header file to make
it obvious that is changing uAPI in future.

No functional changes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  45 +++++----
 include/uapi/linux/kfd_ioctl.h              | 100 +++++++++++++++++---
 2 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ea6a8e43bd5b..de8b9abf7afc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -235,17 +235,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 		amdgpu_reset_get_desc(reset_context, reset_cause,
 				      sizeof(reset_cause));
 
-	kfd_smi_event_add(0, dev, event, "%x %s\n",
-			  dev->reset_seq_num,
-			  reset_cause);
+	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+			  dev->reset_seq_num, reset_cause));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(
 			  throttle_bitmask,
-			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
+			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
@@ -256,8 +255,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info->pid)
-			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
-					 task_info->pid, task_info->task_name);
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
+					  task_info->pid, task_info->task_name));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
@@ -267,16 +266,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
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
@@ -286,9 +285,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 				   uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
+			  KFD_EVENT_FMT_MIGRATE_START(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, prefetch_loc, preferred_loc, trigger);
+			  from, to, prefetch_loc, preferred_loc, trigger));
 }
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
@@ -296,24 +295,24 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-			  "%lld -%d @%lx(%lx) %x->%x %d\n",
+			  KFD_EVENT_FMT_MIGRATE_END(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger);
+			  from, to, trigger));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
-			  node->id, trigger);
+			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,
+			  node->id, trigger));
 }
 
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
-			  node->id);
+			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
+			  node->id, 0));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -330,8 +329,8 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 
 		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
 				  KFD_SMI_EVENT_QUEUE_RESTORE,
-				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
-				  p->lead_thread->pid, pdd->dev->id, 'R');
+				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
+				  p->lead_thread->pid, pdd->dev->id, 'R'));
 	}
 	kfd_unref_process(p);
 }
@@ -341,8 +340,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
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
index 71a7ce5f2d4c..717307d6b5b7 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -540,26 +540,29 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_ALL_PROCESS = 64
 };
 
+/* The reason of the page migration event */
 enum KFD_MIGRATE_TRIGGERS {
-	KFD_MIGRATE_TRIGGER_PREFETCH,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-	KFD_MIGRATE_TRIGGER_TTM_EVICTION
+	KFD_MIGRATE_TRIGGER_PREFETCH,		/* Prefetch to GPU VRAM or system memory */
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,	/* GPU page fault recover */
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,	/* CPU page fault recover */
+	KFD_MIGRATE_TRIGGER_TTM_EVICTION	/* TTM eviction */
 };
 
+/* The reason of user queue evition event */
 enum KFD_QUEUE_EVICTION_TRIGGERS {
-	KFD_QUEUE_EVICTION_TRIGGER_SVM,
-	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
-	KFD_QUEUE_EVICTION_TRIGGER_TTM,
-	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
-	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
-	KFD_QUEUE_EVICTION_CRIU_RESTORE
+	KFD_QUEUE_EVICTION_TRIGGER_SVM,		/* SVM buffer migration */
+	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,	/* userptr movement */
+	KFD_QUEUE_EVICTION_TRIGGER_TTM,		/* TTM move buffer */
+	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,	/* GPU suspend */
+	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,	/* CRIU checkpoint */
+	KFD_QUEUE_EVICTION_CRIU_RESTORE		/* CRIU restore */
 };
 
+/* The reason of unmap buffer from GPU event */
 enum KFD_SVM_UNMAP_TRIGGERS {
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
-	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,	/* MMU notifier CPU buffer movement */
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,/* MMU notifier page migration */
+	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU	/* Unmap to free the buffer */
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
@@ -570,6 +573,77 @@ struct kfd_ioctl_smi_events_args {
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
+ *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
+ *    rw: 'W' for write page fault, 'R' for read page fault
+ *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
+ */
+#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
+		"%x %s\n", (reset_seq_num), (reset_cause)
+
+#define KFD_EVENT_FMT_THERMAL_THROTTLING(bitmask, counter)\
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
+#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node, rescheduled)\
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
2.43.2

