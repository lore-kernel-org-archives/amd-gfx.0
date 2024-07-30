Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BA6C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 20:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A96110E58C;
	Tue, 30 Jul 2024 20:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4lDZI1xu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D81C10E58E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 20:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG9/MmbGSabDXoHvTUX7HoUCOfmXMdhlTofAE0AJaxc6eCdpGWustvxDRM2z/IpZkCdMNm3CKySGPHgx5twzj9+1xwML/mhS2jOnEG+4Wqrgn0dQ5H+cnByJ7/u/ruVMITTJDGW0ON0zMkto0IkUJpPgYCB9QrjvUMb7Q86r6LjRBG/9lI/kPI4xjXZIYdQrd2fXe3UltrJi857Gj3n9A1OmGQ7Q8Imx+pn2ydvb2Y43V+snt8pTBwwyDsJXI42FS8Zi99Hua2l7AHEC9PVBM0zZd+cYlSgp6p58wjXcaVCsZM5UZKC1G+z6yJqsQqFKV4zcmkv9bVy1Yan+oG7eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFJJoJ7/WGpSDogWVK80gH5Qf8NToxF2NnH250HRzoc=;
 b=w/gB/QweyFqud6LT1UN5O96g7SYwETOIGaqXOnKAdEkmas8HOyjzTveCE180NS+NVieCw4rfjQgznrtkJeoBm3uU/Cp0xhJ4iXc1yATi1wO0tnLQpIz5vUFQeLQ1P0nyCDHu11agP/eLav/Y7b0czcjkDXelPxSDhmgBL5wWCoPMhUWyFMN89DCNVGIp2KkFIgtelYeS43w0F5yc4PDZgCI7HMaAMdAzEl67Ah3sOur1E3OJ0H4W0w9LC2ZAThYtXR0UVMAZDvWyAHwMNDQfRCOYul4jomD98SF4/KmEERW6D2jFOr2Uod5e+K3aI2TqcEuilr9uj/OqYNOTsEkA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFJJoJ7/WGpSDogWVK80gH5Qf8NToxF2NnH250HRzoc=;
 b=4lDZI1xuBHwd7+iyW4Q4ql9Gy97AyeBt+KuvgUcz13RFzk/j/hUI+gJAPOHV63Vib32wWPVK0D53AB2Ni+zo5rdyPTWHzVhigbi954FUdWzRGbYwOtpwXfpYMPZ7JG+a/cw+lC/DncNn9UwYslPNMHkQrKT7q0ShTL97XN4rXSc=
Received: from MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 20:16:26 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::1) by MW2PR2101CA0020.outlook.office365.com
 (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.3 via Frontend
 Transport; Tue, 30 Jul 2024 20:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 20:16:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 15:16:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/4] drm/amdkfd: Document and define SVM events message
 macro
Date: Tue, 30 Jul 2024 16:15:44 -0400
Message-ID: <20240730201547.13590-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240730201547.13590-1-Philip.Yang@amd.com>
References: <20240730201547.13590-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 279e045c-9abe-4b9f-a0ad-08dcb0d47d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?taJ7gbYI7N7iupgaye2mwVf6Qra/AA0ySmFw1JA395xl8cdEMNuAnXTVxzV1?=
 =?us-ascii?Q?qkUYPeoliQLwqeST60mxWhf7/LVivni0zYPa4mp40M7cXtoNebx7iD2oHqKW?=
 =?us-ascii?Q?ik/DeGt8WYCncJAr1Y4cVJhmdl4i504jRvhEgs3CIao/wVBkdUGpOxw5Pw8k?=
 =?us-ascii?Q?HCTPmN4VajdlL567WHXK9iykHlY8qUppvV7QFddUeLczDfFN+Ek7zlrAA3AT?=
 =?us-ascii?Q?CUWoe4utb/GGtB3OEoarqZaGerQeY8VmC0c8iXStj25r3dZ6apZakrnj+a5T?=
 =?us-ascii?Q?/rdLEpgKAv8WJv1kDeJV7I3z2VK002LFD1GWBXc6vGDXDgCIvcX5Akk5i9d7?=
 =?us-ascii?Q?Y1pEiTAXNDIcU5QAqGL9P4gVntlhmypdGRBvXvWPlNdL13FtGbH7bjv03pgm?=
 =?us-ascii?Q?H8u85B23owPcYzbY0wZLVdX7r9qzOlu0X0PL0TODg2CxvqFHggrgxHWAnmY7?=
 =?us-ascii?Q?NoTfEpVt5zss3rUTl54aiDAvuCARW13yLntmIPLHs8lqHg/To2J+yXumAUfp?=
 =?us-ascii?Q?h/c+oKCIbNFjyQVkh/Sq+PKPMrXuRa+7mcaUB1xz/kRI+JtupvrALRkTAbSf?=
 =?us-ascii?Q?iVLYxZWOtPV/uoJoZvvV5+l3yM5NHxqd3PkgnPXLMx7h5FztUPaO5H+rI/yX?=
 =?us-ascii?Q?39f9x6qfupXUzetvSDPTEoC4wldNjUml/ItFQPQH/PKzqqfyVi/GdiIawN8T?=
 =?us-ascii?Q?Xlsj3GJVaOo9KqypsTVO5EKt5UdMBr3GwFlhfX+dBaN3Wy2vT7KYgzADi3Rd?=
 =?us-ascii?Q?dqClt/FSS9qsFU5F70OK266OZgihYO3HkJtWtvqx6MVujAALv2XiFyRjhESC?=
 =?us-ascii?Q?S6BUuEM2LmGBodz+24dqZ69S+3wmVLcpbJHliOCLQa2pu2q27BAlcrLKhVex?=
 =?us-ascii?Q?zEttoRMFsrQjaidJDLUN0rUwDhPqKXa98ystPFfV6OM59uIVWxgBJMONLtBV?=
 =?us-ascii?Q?kG5+lOBrtI68V6I5Siq+EQanBMGJY9yXb4d88lkK4UYZCKZwGZD4E3fgEAgZ?=
 =?us-ascii?Q?WsAtetlP+b6TfhbX2y1gzh2QLv6T+bfaVi7iK+BGoH4IRah8FnmIAL3VHeOE?=
 =?us-ascii?Q?Ei8D3ukUcUT2YBpKDVHB20s8JZl1x6FsBTRzpvQmuWOfg2fwks7BEGVbu5mt?=
 =?us-ascii?Q?OFb+yGaWACbdvcRZ1+H1vo7qRuUWcsG4phPOjcFpK7sb4yXCG2PYE1cpf9xn?=
 =?us-ascii?Q?FRc1TpemSRdt74B851BRtVNJQDPqSPUTDr4fMZW7V/JX1j47nT8919P+vfiN?=
 =?us-ascii?Q?fk0+f2uSYJhczRB51N/F+o9Smyl2D/ebRv5TOwjzcZ46gwYH2OAiv1qz97Vj?=
 =?us-ascii?Q?mQ92eeA8L3Y96NO0iuz7yFeLR/m1fbXwRUVOsgXlAtZJnRaWVR3W9S5g7uZE?=
 =?us-ascii?Q?gcCjNaNAhhspG66zIMtbUFjVUg1CM3Eo4zcxQptUfRh2RKdR/ew/pQ/FTsyB?=
 =?us-ascii?Q?Ma1OYwpZDknGUsZzyECWw2/ixbfLjBgv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 20:16:25.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279e045c-9abe-4b9f-a0ad-08dcb0d47d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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
index 71a7ce5f2d4c..c94182ad8fb8 100644
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
+	KFD_MIGRATE_TRIGGER_PREFETCH,		/* Prefetch to GPU */
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

