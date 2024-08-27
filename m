Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B665C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F351A10E3C8;
	Tue, 27 Aug 2024 17:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSeSGgkx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9810E3C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZejhrAzJucbQ0MRuBhBlLOEBbts9u2dz2Km7pMzscytit5qpg5t6ymy/4YgxIsJYhnEm9Qvj/QlradirSwSXOcSGRcxUTf8FjUh+5cs3NmI/eAmsA64R50UUQXM8x2KS7dQEu+Dfr2uuSiZBNmhXDLZuqNrIYLB/oD416Lg4WOGmrA6TNPePUVRvivKjTMz7bvQh5b5/TzMdelCCnKlJqCvC54zXejvT9NMRdLay7sIT2bvkgiitJatJuyFjT248MvTjXQyTpkKGvtpWxCQBzdsTEbiajR0AI8tP9UWW018lmI3RuR7i+Ebeg/2lspYmJ4JsmHqu1AYX9ihuMDqNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBwK/yIORntGENsqnxLKEjCHYh+uNzJeyyrZ1iXcNXE=;
 b=E62tVa/cCPpD6Jqckdku26bJfKjctTACqkKIxvnYAuCw82wIrvQz6uhtKTjImOpuCcdT+DpsZipnU/cqPd0G7JE0z+RiBlmSu5n9DVC0xkaxsx9LwozwaXga0jWzwcI7H5UidM6Z5WgR/KMK/chZ9lXHPDhsl8IEmABWnvyz7GESjUWDbz8SiZbzEdtlWRv20ev1TtXTLKV/YW2NDel1/ZGRVWq+xKm7vdL+Ezu5BheFyxNprl2U8HtkKxkryNa5BXWssTR0ma5UfBkusPPfbI+hva4h8O0CQyaYgYY4S1/UH4UpFjX13vThGBprOS23Jnjkq1XESIjSMIohHndVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBwK/yIORntGENsqnxLKEjCHYh+uNzJeyyrZ1iXcNXE=;
 b=CSeSGgkxkvIJsR5/9sFFYobNqIHZghNgf0PgE86lQq1amoi2EWNuyYf82RhoRVbvn95ow681AEd24TvleIXBOrkxVIxkUEVX1+BUF6buCd4Nc9oUmOaRG+vPEcUzq8cmAJFKURY/Ruwea3v3A0RFrLUM2ow/wxRRMhdvDCftTU8=
Received: from BY5PR20CA0012.namprd20.prod.outlook.com (2603:10b6:a03:1f4::25)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:11:29 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::5) by BY5PR20CA0012.outlook.office365.com
 (2603:10b6:a03:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
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
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3 2/4] drm/amdkfd: Output migrate end event if migrate failed
Date: Tue, 27 Aug 2024 13:10:23 -0400
Message-ID: <20240827171027.12910-3-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0fefa6-78fd-4c52-3088-08dcc6bb4ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICdC6OmqtTEtG0Mnh9xKKcKqSozkSL0xjkeVbn/0enVyZOMF1VQZD+szZHUe?=
 =?us-ascii?Q?lNR1pQZL0/aFvXJ4UULlOX2ZbvDgG0ZH0RZfJ4JgfLqbo+JmgGGp/vAU8Cf+?=
 =?us-ascii?Q?+jvYHv0+epstqiMvVWfPYqVw7Oeo1kT/vphpWC4A1o8IG+kVb9gR7xFOGkK+?=
 =?us-ascii?Q?1RTlyABARzdq/NPynefUCw7fyyIg7CZCeX6nsNLQ99/LqOa32TDG0nHlm+Fd?=
 =?us-ascii?Q?YhBOKladu53LdSDEiffSNz+iQscyl12/ag8en0yUz6jcMZR2pp66hsxjDYu5?=
 =?us-ascii?Q?MUqzIleavRHJicWN3SnnD/UMNutEn5dbdEIPOMKjmyFu9b6M5XVt0OGaCWNc?=
 =?us-ascii?Q?JEo6Lgr9CEyuTDZNCiN+gebVKbMJcEcOA8Jr312vXPGqV7wZBLen96JH1gtA?=
 =?us-ascii?Q?rYvJbnBXUYzMRgfL6mbLAEcFgnEl6EV63o9QuQAWnoT4EXGhDf4P0nzt8oru?=
 =?us-ascii?Q?1PG4N/FKM1PLvEs46JlDIafCbksCG3z2VHfRZQdsFou0Lpe7773sW8tjqgLW?=
 =?us-ascii?Q?vplaDdZHYEUlwo3qXrthstKfehvi2O6S7okoB3fRpyC29ky/ctG5iKZdyCd+?=
 =?us-ascii?Q?118K5ZLcDzC60vBae2CYjl7KKgrdwgPICnItO7K+8xnkTsK+H9QMreNqMOJh?=
 =?us-ascii?Q?72V1n0RVjRMJ+c1ArZoZ6ItEOJhd6aS3MrcPjOEZREAzbuM/Mk/pEWmAIokS?=
 =?us-ascii?Q?zA//g2r05HSp2mtSx4aU/3XIwkjkrtME+kvU93ume3ZUwVz3gvtphm5RH0IX?=
 =?us-ascii?Q?YPA+RS0nSN2sGHkRUOEoWWrXLSAgtnUl+byvMFvdxYVv/PJrThexjll6tVrI?=
 =?us-ascii?Q?flf/lrhwwBTCpQ5F8p+LJkcRrZaDv4466V09LFjcEzt5fBGUDI63Gsy/vTcr?=
 =?us-ascii?Q?6SMD3zW+7rwxeiMlMz1UExDTWu6RAS+vZ8FcfgjRvkIhNe+vK4D9djVN9I4r?=
 =?us-ascii?Q?qsY6SYZWWhU7FVsa1ncVsHld7Q9rKJIisLRnjktTkJsHBsbQTX+DaZd/0Cy4?=
 =?us-ascii?Q?rL9cAauJAg9Xkug3bRS6GeaJxp8y4pqgFffTkmOY1LFi2RObHWS/x5k4MU8d?=
 =?us-ascii?Q?vT49w0shvgSl/xkG7PRCCfSmamjrt39CD2so3If+s7zqkQdeMlSP5qxwwMZj?=
 =?us-ascii?Q?dZiDm+qHm+pdlMyQwDcQR+BQ4zeoaN3BWysc4jflGtw2xYBrkxeR+siW3ED+?=
 =?us-ascii?Q?3vte10fmM2RXNpX/NpUjIiq4UuQjDqItIqSM6KP0QWVSaF87EQy9Huub8lz3?=
 =?us-ascii?Q?HmurZAdTnxSnH34MNcdVHOZcZX5Lk48+zlxVHgJWE9PQlWF7OtFCQzj9V7DJ?=
 =?us-ascii?Q?RksjtL8bR+KiECofrLBl7Y1cPidkdJfH7053HTaqY3x+70QEMAWiumJ8vZ6T?=
 =?us-ascii?Q?bhiilpGPRilw2ZO4THiONIK78lLImHLn4gd/q98EFkWuX7i+ipPiw5O2BSYL?=
 =?us-ascii?Q?sFtPVctsXmCVeWDTNrV8NwbcwxthGZkJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:29.6120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0fefa6-78fd-4c52-3088-08dcc6bb4ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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
index 717307d6b5b7..fa9f9846b88e 100644
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

