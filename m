Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4FC4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 15:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1863710E96B;
	Thu, 15 Feb 2024 15:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBHWIkT5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D40F10E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 15:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXZMFEzlPJ3mTgSyXEuf1dmhAuEQI4FO+libjI6y7KzdJTHppzk4SFPG21fj+v80ei1A30Tl0No17Vxz+jD2eTrOu+cDAa2RY7teQy82zqPja2frE7+0aM6K5JfbhKpU3YvwwIL94rHIBG5PctSvQFTSlW+cObYQuWPqgAdqIic9OecPsCH/I71JbdnA6gFSGO9XHFvsR74+wfVnHMdPdS1Z3Qiq0GHIOc14CcgfQ7BlM5UCQ3jDKSwqibPH4slv84rA/OHeXIByv9M29MbuXgFXPGQsi6pv/D3ncqLAkpjjnt15vJH+JAWil9WZnjTSJ9qxsumnuUItmyRwYtDwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whSjoTuDCfg9QPmKGkWQk1fhBtZfKM9u0SI7EoGaRNk=;
 b=bhv2KvLSMefMndm1EcW/90aDUhd1J9s5gZhERdu94H4cG00/fvjMumGREwVyvk9IXWO3gR/uBgN0iA5LrHVH+wZNT82GN4OXyXkk7MkGlkzXmWpZzytVDfvRN5WDuPsPEG6FHq02uSpz9hBG9bCZ2OJlc7lBsVGNqINMTIrtgUIKCG5b+k/5jZesXxv+Kz9iZ3V+2r2SPRbGaoythoOP1YH+kgiQiYF1sOrLrtFA4tnfFR2TXk5r96HWpBhITLSH7meBR41fHibggBav4AlDg8+50esyAtpSEf6+XnbcYflja/Yf/sqkz9ZTY5gqEp05sntWUDI3ij9B+WGXFjohQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whSjoTuDCfg9QPmKGkWQk1fhBtZfKM9u0SI7EoGaRNk=;
 b=lBHWIkT54fKSOJ1W7pNYwg2JS3jgAMU2DgCdHvUB9GHCuXv7kFtypuuK1dJdY/SUuK09dmF+gYFM2EAgXr6ikV3jaaIfE+rYg2QyvDfcew7+nPb9lB0JEw9GSWMNvzcmPKqylpWSB7Xq35TIAtT24XZSYNsAveG5xRXb3imIbXs=
Received: from BYAPR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:e0::47)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 15:20:21 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::8e) by BYAPR05CA0106.outlook.office365.com
 (2603:10b6:a03:e0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.13 via Frontend
 Transport; Thu, 15 Feb 2024 15:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 15:20:21 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 09:20:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Output migrate end event if migration failed
Date: Thu, 15 Feb 2024 10:18:30 -0500
Message-ID: <20240215151830.22416-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240215151830.22416-1-Philip.Yang@amd.com>
References: <20240215151830.22416-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: da4f6837-291d-4245-d400-08dc2e39a065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k85ZV5m8moe3AdjMBSrtXznQ3Ytzl9EnHRKNt3UmaULYxjj/w//LQJ0G1FZtvI7DCDdbcphHoTlBOWB3ZMHka119IF6P+PQCfufR41P0M8kYnGfcy9umZjmQKjkW2ugNWnJraNomesoZr6+llEG1f6MyColEUsmFNKj0+jvmIgcSMRRdoGJDnaZPjvVKEx94g7SLtVscUYfDaNRAd6QF/dDzpLsiEfseK0ZjNBw2E2FZYfVcB6R+MYfd1x/HNh3H2ZpNk1MOJ9ed3YftvERqgGPhL9xk8aItUno2Z/7ZpMMDKzIbqgiRqwpoAuv7wXW0mekTDU75OjNY6c2uPQxBWJIkBLBQGusHvrWOgfEl2RdI6lMLdvkZbTBJ7lK77RszWUxNWBH+p8MOJUQGMmBcuscFge4RZxJv8xzqbXl5SyYfJgp3hb1grrgf20Rn1Hsn9nmTBWOtnul4vbswfC0ooZnjYCQeD3TiPLCVuI977mmJwQWTuOgmm2hmnbRXy0/EOdCBT7QcHj4Oa9ZKuSpCvIQLMxxzIxz6CAZ2P4gkF3F144ryl6YVeDHw3Mimx0GKNK44PzFb6hNB4yzXg9OqBGft3yvkFKESid750piXLW8LCCeM++sardZP9Onlya4uMF4aN6Hmqqn829hcxsZgz0reRwosLGWzE81/8J9w7Bw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36860700004)(40470700004)(46966006)(2906002)(8936002)(8676002)(5660300002)(4326008)(83380400001)(336012)(426003)(1076003)(2616005)(356005)(82740400003)(16526019)(26005)(36756003)(86362001)(81166007)(70586007)(316002)(6916009)(70206006)(54906003)(7696005)(478600001)(6666004)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:20:21.7559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4f6837-291d-4245-d400-08dc2e39a065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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

To track the migrate end-event in case of a migration failure, always
output migrate end event, with the failure result added to the existing
migrate end event string.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  2 +-
 include/uapi/linux/kfd_ioctl.h              |  7 ++++---
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 480e222364d5..23cf9484331e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -445,15 +445,15 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
-				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    0, node->id, trigger);
-
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
 out:
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    0, node->id, trigger, r);
+
 	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
@@ -737,15 +737,15 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	kfd_smi_event_migration_end(node, p->lead_thread->pid,
-				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    node->id, 0, trigger);
-
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
 out:
+	kfd_smi_event_migration_end(node, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    node->id, 0, trigger, r);
+
 	if (!r && cpages) {
 		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 85465eb303a9..d1a567f8a8d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -282,11 +282,12 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 unsigned long start, unsigned long end,
-				 uint32_t from, uint32_t to, uint32_t trigger)
+				 uint32_t from, uint32_t to, uint32_t trigger,
+				 int result)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
 			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
-			  start, end - start, from, to, trigger));
+			  start, end - start, from, to, trigger, result));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index fa95c2dfd587..6c99eaa39f09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -41,7 +41,7 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 			     uint32_t trigger);
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 			     unsigned long start, unsigned long end,
-			     uint32_t from, uint32_t to, uint32_t trigger);
+			     uint32_t from, uint32_t to, uint32_t trigger, int r);
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger);
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 430c01f4148b..5220670a434d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -601,6 +601,7 @@ struct kfd_ioctl_smi_events_args {
  *    migrate_update: the GPU page is recovered by 'M' for migrate, 'U' for update
  *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
  *    rw: 'W' for write page fault, 'R' for read page fault
+ *    result: page mirgate result, 0 for success, otherwise error code
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
 		"%x\n", (reset_seq_num)
@@ -622,9 +623,9 @@ struct kfd_ioctl_smi_events_args {
 		"%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
 		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
 
-#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
-		"%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
-		(from), (to), (migrate_trigger)
+#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger, result)\
+		"%lld -%d @%lx(%lx) %x->%x %d %d\n", (ns), (pid), (start), (size),\
+		(from), (to), (migrate_trigger), (result)
 
 #define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
 		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
-- 
2.35.1

