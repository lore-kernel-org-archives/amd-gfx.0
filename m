Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD92C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 20:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FA010E58F;
	Tue, 30 Jul 2024 20:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IgjwvhId";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B24710E58D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 20:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKizR0L6vc8PRU9Y0WBxGCmiZ+uhwS+v49QHxM4xwmqXChLhUrtg07/hyJ0kqAcaKya7DIo/NhWOX7+rfFNyjJPkz4UtQnidGmshsD0vDNHk27n0hbch2uiAd8a6z353CNkmQi4Wf8dKfVUzZhhPtAZg9oNRL/zlsu7joW+MwTSP0mK1AG5HXY3pYhcjnJ93LmrVBCZju37njm/jxvT9cLEeo/JvTUi6lFgHs4JaYUvfuC4dEN9z9FKYpp3L2IBPr8h3Nc/uf5TEkXMc7wP3S0wAQKH5bRpjjxj6NouS3B8XVphRgmCqqFLSN66/x6aSUlURsgceBC4YvyLLADNzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tps0LfiTZUrlPqtbdpqz3ZjCszzhonYV6ThPXw/xbs=;
 b=T6WB08iLVWey5cLaAwAIvEKE8y/1DL7b+WoBUgvKbDPRhSV1ODQBoHgjSamLcWHrEO+MYOAM0Zid5Xf8S369wQnNK++mEqJyS2BGttCjdAkjkV0tiqfRPxfTVlrl29clLpu+OLn9wu7onWZmxshW6EEoqDqU1oemeTwoAsVZN6l9a7vIceus0610TQoubq1YYQSkNl1rPgGFgm0hIC0nE2btTJ6iAMpNXytAR3z2NWYa+ZVuhcpND2nHkPXEGbRVRJZZt7ism929G7l/k56LI5QlNTXfBlUXjLfbJSGpm7ZxqgSPh/5mplpd4Kw+i2qNgYYwB+ol+TCN0Xbwg+Np/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tps0LfiTZUrlPqtbdpqz3ZjCszzhonYV6ThPXw/xbs=;
 b=IgjwvhIdOuUDHL8Mea2gtpJrwiEjAHA1gy+Ss2R62JSEXwjw52kBvDBTd2WvCEI3uhyLD31NFYNEDCZeeHMbHm2EyNKzd7+JzBeUorOlFyF86jnpj7uASB5/9q/CGUW84GFlqtTrUM+yqdMxLusaAUsJKNafBfqTg+lJlc0mLDE=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 20:16:27 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::80) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Tue, 30 Jul 2024 20:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 20:16:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 15:16:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/4] drm/amdkfd: Output migrate end event if migrate failed
Date: Tue, 30 Jul 2024 16:15:45 -0400
Message-ID: <20240730201547.13590-3-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb144a0-ccb7-4917-acb3-08dcb0d47dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r586k2ovZHxgEFrnsKNoaWTNTNsCVZnshUN1M+/pMBmMCVi5YrsJ/n7RA8Jx?=
 =?us-ascii?Q?wzZHyEViqcO2vhVDmB4dKtmabh0GSvqQn5ja9Andbpi8g5qLeIjXoDExvmFW?=
 =?us-ascii?Q?6nRFeII8W0tREm1DVy5O9WsbNPYXi+S7QI9/U19p3BxevwUw+AkqJeFkzi+B?=
 =?us-ascii?Q?O9Wdas7VhgzzlC5R0dDlgqRS77PRjr7mPZ0kzj+tadKcYJHtF89iTaVcGoU5?=
 =?us-ascii?Q?GzhYXOJ7UkAZTriaRK7e+tvNqFt4TVRbKS+tbI8/uX7G45EAbOjneVw8FBND?=
 =?us-ascii?Q?jZUPDNhk/YZ1g7UtUc6DbSkRgQrCHiUb+Py2kIILzMHSvVTchUJlSjWPWfQf?=
 =?us-ascii?Q?+wLmGdiNFEEQz3qHH1Qu1LMTzEHEgFgdE+nU3ZZuhLOqVnQIySIZhHLW6zvE?=
 =?us-ascii?Q?0gqH1bV+gfl98DBt3nzA9SqX+LTP1UjxVmIgwXN4OJTz9WA3jXxc5IMfu9bI?=
 =?us-ascii?Q?JYUvYPJaaJIbcLM7Yp24yNt5W4bZzWnzqiM5GMQ59vzmFQ6bMBZ7om+X3ZI7?=
 =?us-ascii?Q?AIz7wRhN4RS+21H+ZNnRwbE2Q2JsuotWS1zO4gZJxbthgVhv9j/6mi1+6xXl?=
 =?us-ascii?Q?20BinHHInzboz4+N4m1yi6Dllo9Tr64ws7XYsKxkTcVk2cHRtTiH+R2uuNkd?=
 =?us-ascii?Q?Ot0c0u6VuTOyaeZTTMj1xGclFoUmE+GAos4irpThKBSDgE8iGmElZNJo8kxv?=
 =?us-ascii?Q?BrcOP9K1SAWOqa1KoZ6rp+jueKXu3rJ1lsONJhDkM3R42SlDBQs6pEXbo51z?=
 =?us-ascii?Q?b4vLwXsb+KYt3GgtQOJhTmBMAJxXR7mnNjcMEczKq1SUwZduFLMXAm1Y3JvN?=
 =?us-ascii?Q?f/MYc1SS8feem5BjxwG+U5YgscpVwsiDGwvMpv0FGfvGEVH2N28IP5yJKNg6?=
 =?us-ascii?Q?O2dgrQ2pDh+OsywHi33wYYYOmTu6gB9ElDEeI8WtOPY5by//re4E386V3wfy?=
 =?us-ascii?Q?AerEQnkTUZlZmxLipMenRBDaSOuVPRSERAXJLkhy18vVmj8b2CEqGir8CAF4?=
 =?us-ascii?Q?+gyqHBoggA/y/4NFqd6dz6vbiS+jbdhwG+r0gr9P1VPiIgFExwlmrLsWe3CI?=
 =?us-ascii?Q?EtJ0ia8DBFt+1nB+Pxg+6Vzr5WKCbr16vYUNhZruYyaoq+kbA6OWSoBPeReP?=
 =?us-ascii?Q?mKxXGL4a4gSWet6SiakatXDgmMcFQk66akt/tXD2Qb+REmdchQyzcUko5L/l?=
 =?us-ascii?Q?4Zgk1ALL9aUGE2388YxG1vAT3+bLggoDlYhsqp+EWhs+Dp+6far7fjB7AEKH?=
 =?us-ascii?Q?RO9ehAa481mVB/6jb19JcYOTyJ23XlKvP1vIuWvnQIQFju/G2eIe3nnJcoWN?=
 =?us-ascii?Q?Q7RrN7kTY7d2Hn2Nslhy0oj47tjDnOT0bSnrO+ppU3ouhTe8VK2l1fGJsPL8?=
 =?us-ascii?Q?Rnqxd2kQeRBSnxBi1Qt2q6vLTcUItZY/KvZWbmFDyTGMyS85kWWcAazKs1UN?=
 =?us-ascii?Q?qGgAGVzt/FG+rcJgPXEofeEVaGRcsH9A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 20:16:26.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb144a0-ccb7-4917-acb3-08dcb0d47dc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

If page migration failed, also output migrate end event to match with
migrate start event, with failure error_code added to the end of the
migrate message macro. This will not break uAPI because application uses
old message macro sscanf drop and ignore the error_code.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 ++-
 include/uapi/linux/kfd_ioctl.h              |  7 ++++---
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8ee3d07ffbdf..eacfeb32f35d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -445,14 +445,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
-				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    0, node->id, trigger);
-
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    0, node->id, trigger, r);
 out:
 	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
@@ -751,14 +750,13 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
-				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    node->id, 0, trigger);
-
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    node->id, 0, trigger, r);
 out:
 	if (!r && cpages) {
 		mpages = cpages - upages;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index de8b9abf7afc..1d94b445a060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -292,12 +292,13 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 unsigned long start, unsigned long end,
-				 uint32_t from, uint32_t to, uint32_t trigger)
+				 uint32_t from, uint32_t to, uint32_t trigger,
+				 int error_code)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
 			  KFD_EVENT_FMT_MIGRATE_END(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger));
+			  from, to, trigger, error_code));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 85010b8307f8..503bff13d815 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -44,7 +44,8 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 			     uint32_t trigger);
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 			     unsigned long start, unsigned long end,
-			     uint32_t from, uint32_t to, uint32_t trigger);
+			     uint32_t from, uint32_t to, uint32_t trigger,
+			     int error_code);
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger);
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c94182ad8fb8..e4ed8fec3294 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -609,6 +609,7 @@ struct kfd_ioctl_smi_events_args {
  *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
  *    rw: 'W' for write page fault, 'R' for read page fault
  *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
+ *    error_code: migrate failure error code, 0 if no error
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
 		"%x %s\n", (reset_seq_num), (reset_cause)
@@ -630,9 +631,9 @@ struct kfd_ioctl_smi_events_args {
 		"%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
 		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
 
-#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
-		"%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
-		(from), (to), (migrate_trigger)
+#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger, error_code) \
+		"%lld -%d @%lx(%lx) %x->%x %d %d\n", (ns), (pid), (start), (size),\
+		(from), (to), (migrate_trigger), (error_code)
 
 #define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
 		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
-- 
2.43.2

