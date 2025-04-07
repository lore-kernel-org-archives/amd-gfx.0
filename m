Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9C3C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88BE10E1A9;
	Mon,  7 Apr 2025 20:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OAiPYxKF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C755110E1A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXrV7PCx6vOgJ/wDRFWuFzcGaZMy6Qnjho/0ZyEGuxS/sMYax0GF6cp7YVu8YTXx7sQgy8U3zs+XbrnlzjdmJcSKIMdDlQ/G2VMtFDi9AMS1U65g5rZQTCiZueHx5MJut57KrBbV3kHg4nESsAhIepCunqkDFip8NKQo2WNioYu7aREWyQEMz6QLy2HZA+DAREI9vIRZQ/ukAbolaIIXykLq0eNPAfR+KFKywZ51mfc6HQMPwhLioZKJR7NevKFKPtSxQEmtTwCFsDA9rRJDE/pGgwP+3yT1vcH2lkjXNnl+xkSW3wiz7rEqQSaJjIFC0nDwYFpxGmF6FuFrMi+uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zgp83jgb3rGnSQkbtLliChGgzZwJrF4keF0PTyik9gg=;
 b=oShe5V/R7UqfjZwQDgMM2VTzUZb8j9fJz5OSRYyAIB7a12qMCvJqEwRRyymzNk+C3+tDdt8v6cFB3FWVUhi1bBOKWZjXPPzQSlQm/GvXxtMPPrM/lD5QpR+Jp1CUfFl5pXnk22F7AX3BwhYSvpN2Rts6zIBwDkcQglIY4zuZzeKAXYLXQe642yRt4cVX3s3JlIPZVdnL3IsdeB2uoV3IKa+EOgeniU7AqfAF3kmYfuwy7PS7XkEiwvn+Kb3urcWz6/tVf2c1dmAFVeIFAsH6DYRiWk1mmak2amV8y/YveBSYzri0hX4uUyCgDMZUxf1ekZOEHGMiIbR0qKDDlsy2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgp83jgb3rGnSQkbtLliChGgzZwJrF4keF0PTyik9gg=;
 b=OAiPYxKFRcgIUjIr9+vreklr/8YQwGl/4v3QEgf2ehf5bFPUI1ZBgRquIr/+Q2JyPda9mxxPEllKvmsijf59aUiRBUmgLakbFH59bo5bsAYhPGMctvG5gG2tvK7FBr72gos1wbxgU3EVFJx3mukxWe+GMYGA8CKOJXfiK4GY5IY=
Received: from PH7PR13CA0019.namprd13.prod.outlook.com (2603:10b6:510:174::16)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 20:52:59 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::41) by PH7PR13CA0019.outlook.office365.com
 (2603:10b6:510:174::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.11 via Frontend Transport; Mon,
 7 Apr 2025 20:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 20:52:58 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Apr 2025 15:52:56 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add smi events for process start and end
Date: Mon, 7 Apr 2025 16:52:37 -0400
Message-ID: <20250407205237.217164-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 84111c71-e9a8-479f-e655-08dd76162dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AeuNY+K9QkXzJTuOowjeJVWhVI1mT/N4vT89PoDk349DDeheUMqfyCfPacTa?=
 =?us-ascii?Q?FrJkQbGyjcW9I4jXdQrAmIK9M8CdZe+NhV4D48I1UiaC7hj2OYpYARbsi+4M?=
 =?us-ascii?Q?S8JY7FSrjMyxjMkLVwx5+pkGtix9cJEgPR13Ux2h525KeZNyXJmjqv4+ase5?=
 =?us-ascii?Q?Ny69h/8GsckJwBAAZLxphegUyGeoC0gaHPb6Sc0bXX9b+ibsOiA80IRzdqRg?=
 =?us-ascii?Q?0TLOUl2SaDcnka1LdCtqw23uJ/Q9PvYs+GE/3ViM+EQRHOzQ0kN/zH3tc6eN?=
 =?us-ascii?Q?IMu4b5wbrP7KjOyaKt8SNAw8NXzI28mUA6NCTSPeG1piCh5nDht5+dsO7csn?=
 =?us-ascii?Q?fHnPpV5A6+OoiIXEvK0F198rJ1HBVnyUTEyGz0w8hJ6l0Yw6odS0+TDK3Mgr?=
 =?us-ascii?Q?2AvNchEbLeFKhjw+np7so1bGKMPKMqbuF3m09CeUf64/HAP8IGUudetctb+D?=
 =?us-ascii?Q?YHdPDw8sYQi/H4dVSpYZyv7yzhqT9F3s2xnvCjkrF+R7IeAtM+A6Mv3YO3+T?=
 =?us-ascii?Q?R+OieI3qo5DBYzX3BhI/RSWg0c475uAJDqycXUfyCjwEc4u5Jo8csMRyGcZj?=
 =?us-ascii?Q?3mlO7yK2mbejfjkqtCGdIF/dMwOJd0mfNC35ol8cwCxjOVnjD+ZRQ8NbjlBR?=
 =?us-ascii?Q?8Riw5hDsoGnLgZSGXahMGQU8vsRGvHRl9Bsvq7dad2nGyUXMqxiT/xon4/kz?=
 =?us-ascii?Q?uv/YxQNJOEOE67zkEGqqDnMPUoAMnduR6N+ltJZ6ZR2A97sHQkv17MbzqyKS?=
 =?us-ascii?Q?bzOpeQCHgXdFdZeNtvE/d+HOixrECeKnl+0K6ld03TDHYEGZH0zJ7cy4ONba?=
 =?us-ascii?Q?IrkkY2eCxU7uasVMbEINM+HdJzdiOOmY6izQTXIJripobR54+u0boK/vVNFH?=
 =?us-ascii?Q?O0z9STHiCwXd+yEatTDXgISJMAuo6iL2hTgJdRhB95dXgqSgjbhYOlDXXdXj?=
 =?us-ascii?Q?clubctaJZhKtTVUGGzDVGKdMdfyy1QYv85E1NIQdY4fiTe61aSg+Ou8jPaIp?=
 =?us-ascii?Q?sfU7WILUYPORggwHBZzXrfQQDXbuUiEZvvVL9n8xlOVZ9fnNjkGxY269pSbr?=
 =?us-ascii?Q?7r06UbjwsMztAD7X8bljOwkGuvHyA1Ze7kfYCRJBTd+yRy8NSsjoFL0L3iYW?=
 =?us-ascii?Q?QDfdjpJxGQnE5ePtuC01zoI+42fX/Gst4MioYHeRv1dR7Vzm6YQhf9cDtsm4?=
 =?us-ascii?Q?MtFdbme8Y2PgizI127rPdA6V8Qbd5ylE7gnuDhluFu9v2JceqiObKRUQTchI?=
 =?us-ascii?Q?K6gJrEr2IGGSzhrVfdJW8DKv74u6jWsC8r7GqwjBNpTDXp2lN1aVOHhkIJEM?=
 =?us-ascii?Q?VQ0Q8ZWVvGuQZUYxSn2KK/aA9D8VU9NWoWbfvd+gG1Ovey4qwco1c9QC9TBq?=
 =?us-ascii?Q?B01t9yZKD0yyVAQTO8I70Imhyva/AaxmtVRk0vlHEkuxywv/FPAGQcjR74sZ?=
 =?us-ascii?Q?KjLPmnUoxafQH9yVkmgFoi0ZI+NHmqzzli46ud8WL2sG4xmIb0AHjUXABdIJ?=
 =?us-ascii?Q?1ZYTo2BACuCXnXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:52:58.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84111c71-e9a8-479f-e655-08dd76162dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

rocm-smi will be able to show the events for KFD process
start/end, it is the implementation of this feature.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h              |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 7c0c24732481..41d7dc8c2850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1054,6 +1054,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		kfd_smi_event_process(pdd, false);
+
 		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
 			pdd->dev->id, p->lead_thread->pid);
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
@@ -1715,6 +1717,8 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	pdd->pasid = avm->pasid;
 	pdd->drm_file = drm_file;
 
+	kfd_smi_event_process(pdd, true);
+
 	return 0;
 
 err_get_pasid:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 9b8169761ec5..727a4ce29fe6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -345,6 +345,27 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 			  pid, address, last - address + 1, node->id, trigger));
 }
 
+void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
+{
+	struct amdgpu_task_info *task_info;
+	struct amdgpu_vm *avm;
+
+	if (pdd->drm_priv)
+		return;
+
+	avm = drm_priv_to_vm(pdd->drm_priv);
+	task_info = amdgpu_vm_get_task_info_vm(avm);
+
+	if (task_info) {
+		kfd_smi_event_add(0, pdd->dev,
+				  start ? KFD_SMI_EVENT_PROCESS_START :
+				  KFD_SMI_EVENT_PROCESS_END,
+				  KFD_EVENT_FMT_PROCESS(task_info->pid,
+				  task_info->task_name));
+		amdgpu_vm_put_task_info(task_info);
+	}
+}
+
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 503bff13d815..bb4d72b57387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -53,4 +53,5 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
 void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger);
+void kfd_smi_event_process(struct kfd_process_device *pdd, bool start);
 #endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1e59344c5673..04c7d283dc7d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -536,6 +536,8 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
 	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
 	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	KFD_SMI_EVENT_PROCESS_START = 12,
+	KFD_SMI_EVENT_PROCESS_END = 13,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -651,6 +653,9 @@ struct kfd_ioctl_smi_events_args {
 		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
 		(node), (unmap_trigger)
 
+#define KFD_EVENT_FMT_PROCESS(pid, task_name)\
+		"%x %s\n", (pid), (task_name)
+
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
-- 
2.34.1

