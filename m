Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8E8D35665
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB69E10E608;
	Wed, 28 Jan 2026 02:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hpDIbgrp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5218B10E60A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7FUp0YoPPm2NffJv7Ip1x4hpOksJG8yv8AGMCokCzljnszLc0lNKNGyk26o41mIyYdSzE41vTFGyZwW6a08zrBuEklqw23ii6sABUqEcFniuuleyz3P1zFe0H3OQcSL4+dux8U+0QsnaUZlpl+pZ2Am6KOA9q0RecdX7aTCzv4Wc+kDnzkGD0vHIPWPONrXYvoyOIQ6ddGJSCro59FDAdpXBwMMX0gV39XCFxvO2gW4D6xKp1q0VSacZ5gTq28Ho+Qa/hmeMrqg/kbsOfT6Z1KRSXCPl+5txZA5zbzK8D6HGyth1WeaCgE+5waZjqRC1wUDPGYT9xR7jp1nJg0i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqX2weYp3lKdaf/Oyd4qiZ436TZQ0cTasUMXu7wKpuw=;
 b=CgnUSPvNBe4cVqIA+qotd7/FvRWdP0jua6p93DBHrGbJrT1YJQ6D8qX9mh0cx8x1M0o2AwMY0tnlb8iqH7LVRaIe5iOrYCg0v4ROOTc9Hed22FOD3ZpJmfWbCO8fAE578BrbshZgldkx/EqytE45GfiKDTUa1O6reNk9TFE7d/EK5XbKx9mKTg61coXDOz7dncytBkrlo4fjYOoY/KP7IFBcg+X3zSsMjloqF5BVfuZOZmXKblTfXbHQWTmkJYowuxRW0lWh3aYh1A+gp7eBzNny+0DUrttB6p1JGXIw6bWVmqgJwuEjk994Hx1tKrWnYMTiLEOZs8YztwswVc4YfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqX2weYp3lKdaf/Oyd4qiZ436TZQ0cTasUMXu7wKpuw=;
 b=hpDIbgrp+v6LwNJMUxF6wC7LXyRgOvn5zZaSLWcCTb4dqS2g8c0xTLvpBqiPSmTRpxSTBT6MVu2Fg/bS9/OGLOSZFwK+eSKE8rHRqSPI1SKSMWN1o7X+sI81qlTmXwsRlghrgSLL+lTLPIUMsl4v/LvjhK9mY/f+l68WN8sRR58=
Received: from PH7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::10)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 28 Jan
 2026 02:21:26 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::5b) by PH7P222CA0027.outlook.office365.com
 (2603:10b6:510:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:21:25 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:21:23 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: Adjust parameter of allocate_mqd
Date: Wed, 28 Jan 2026 10:21:10 +0800
Message-ID: <20260128022111.281082-3-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128022111.281082-1-lang.yu@amd.com>
References: <20260128022111.281082-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c370d1c-0869-4014-2ebd-08de5e13effd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PrGCKjI+CjDbLToECWebeO9hTqQGB2dINHb4FSxl7vktMhVZ79DTGOvT0n+P?=
 =?us-ascii?Q?VEAVIEqcpbvA3yjx1aF/ZBt0WKzpCCMD34c8YYZLA9Ii5bcHjAOKpYd/Uql7?=
 =?us-ascii?Q?ho/ALxDPO1A9bB2Xj9jl0uKH2SuHbmK8rdlQXSQA+Y0/l0UmDLrksyBjQvBZ?=
 =?us-ascii?Q?ErLn6N9D8c4W7Gdr9jm6Y/20EvqkSClpDePeTmANuLLiv8vauscpVXKSs5pi?=
 =?us-ascii?Q?g9zN7Tu2zt/VUz2V8uUM/+UOy0EdySa8X6oJaTUFd9DMY3HAlAVSFXTp3Njt?=
 =?us-ascii?Q?aYpBV16fxKOwXETtCzNGnmTVIvZ2ixs7gnV4qFTGxFqvLrYq+12ih6PMhi6J?=
 =?us-ascii?Q?GAJ42htoBlAxJkzxkWBj2/zy6Hs7axslm4l2CnoRPNNgpWxci5KbuI87oXFm?=
 =?us-ascii?Q?THCuWl66YAwZcfUV+WngjSX8LOYLDI+rKxNMmm7yKTYUkT61N4ymDg0LThhL?=
 =?us-ascii?Q?zb/SepQkBKK64nNa5PC8es0N6WanFHrjbMIiMwTzvFofMrjE+ZZaGHIkP99K?=
 =?us-ascii?Q?21Lt5dy/9YmCk5M4+iXnEVy1rNf4t+oTtJhhAisZHjj4XbBRKniCkANne9WG?=
 =?us-ascii?Q?ahynf/wNxfp73t83Q17xoxJGNuxA1i88R+tmAMwPmWIjrhUrDaRkFvKR9v+J?=
 =?us-ascii?Q?xsb5a5NVoouVDw4jIO36gdvx+5ufgACSS7i8ntuhCuXlcoE8lAoYffjDC4/e?=
 =?us-ascii?Q?LVObLyQdNKesgOITuKbJA5iY/zuN9Olx/uTHiUwRSuaDoPmYxrqcWb6NOHKO?=
 =?us-ascii?Q?cI77S8qsSRGVklcW0W5r0cW9/w2OVSs8+9iKd43tAlELHfqNEERcSZksJb81?=
 =?us-ascii?Q?tHlwETQwroEUsLGVLvu/4tDfnvs0MQ3vQAYvPMK2nmwmVJi/9I8+s8Gx2xDI?=
 =?us-ascii?Q?GEzimSb7cQNCYfubNc23KmdVLQtX4pcqgcMLVpFGfWMSBnsisMPfPulld0Mr?=
 =?us-ascii?Q?mq7kUNmrnraqrnB3S9B2RHePlDCw1JmD5Lq+jsK7JNXLipX5+B1eqcrxUD0Z?=
 =?us-ascii?Q?7y5pXDk887gZMvZxQT7HMIVSuj07Btv59WttfgACuVCHJKlGenNgl547pLEc?=
 =?us-ascii?Q?xy+6byoOWrhGoSJhUgEpo+qstYf0dWEXPbXB8yHL4VXO7LhKXvORQ+FqZXjK?=
 =?us-ascii?Q?10p5EgMGiC0zOtlkcsfZFCwsGb0slFgHsRySm47uMRuMYWgFYhURMFBTnYtx?=
 =?us-ascii?Q?tzzjuW7TLdNn7S5wXX1YWMULdeCbwWamWp1sMVi66pROhnWpUXGsW1kn+wsy?=
 =?us-ascii?Q?XmQspeA3JObniYODaUunnBa+1/eb4sVCk+RffDaFyxtMlzhYCV8tRRdudjpA?=
 =?us-ascii?Q?ATry5VWC4hay/Zpik9lH9OPoXwQuQlnZczxFHOt1ni/PtjIFaeyYU4F7zOwq?=
 =?us-ascii?Q?pLZBUqEb6G5IkCAUZwj9j/JuCVWRESnJSXfyUBacMykF1Qsi0M4yz799jgDI?=
 =?us-ascii?Q?JQ/ADreoGkdmCJmN+bnu528gIp5ouw5cif3To5OW3/uaDFKnojZ8Lvm+nZhM?=
 =?us-ascii?Q?MUkS5CFSdl+fzsPUPpsRy5OaGOCbqaauAwDbUxCwdmL4tfn1G/Zi1jJl1wcp?=
 =?us-ascii?Q?e5lh2+IoJAIgKmO9qMGhsyOeGlLqCV6rZDFkqXFPzFzlcCK2mPmwo1ZIULq4?=
 =?us-ascii?Q?A3FQQV5TQ48nFvR0w8X4xz0/B3bFnlsu1ijEtng9bBk/Mxe8DJUWj1dOmXy0?=
 =?us-ascii?Q?4fQQ0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:21:25.6295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c370d1c-0869-4014-2ebd-08de5e13effd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

Make allocate_mqd consistent with other callbacks.
Prepare for next patch to use mqd_manager->mqd_size.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c         | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c          | 6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h          | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c       | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c       | 3 ++-
 11 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b542de9d50d1..804851632c4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -676,7 +676,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 
 	/* Temporarily release dqm lock to avoid a circular lock dependency */
 	dqm_unlock(dqm);
-	q->mqd_mem_obj = mqd_mgr->allocate_mqd(mqd_mgr->dev, &q->properties);
+	q->mqd_mem_obj = mqd_mgr->allocate_mqd(mqd_mgr, &q->properties);
 	dqm_lock(dqm);
 
 	if (!q->mqd_mem_obj) {
@@ -2002,7 +2002,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
 	q->properties.tba_addr = qpd->tba_addr;
 	q->properties.tma_addr = qpd->tma_addr;
-	q->mqd_mem_obj = mqd_mgr->allocate_mqd(mqd_mgr->dev, &q->properties);
+	q->mqd_mem_obj = mqd_mgr->allocate_mqd(mqd_mgr, &q->properties);
 	if (!q->mqd_mem_obj) {
 		retval = -ENOMEM;
 		goto out_deallocate_doorbell;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 961a4b84e974..d987ff7ccfc9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -130,7 +130,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq->queue->device = dev;
 
-	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
+	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr,
 					&kq->queue->properties);
 	if (!kq->queue->mqd_mem_obj)
 		goto err_allocate_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..ceb6566ff3e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -46,9 +46,10 @@ int pipe_priority_map[] = {
 	KFD_PIPE_PRIORITY_CS_HIGH
 };
 
-struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev, struct queue_properties *q)
+struct kfd_mem_obj *allocate_hiq_mqd(struct mqd_manager *mm, struct queue_properties *q)
 {
 	struct kfd_mem_obj *mqd_mem_obj;
+	struct kfd_node *dev = mm->dev;
 
 	mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 	if (!mqd_mem_obj)
@@ -61,10 +62,11 @@ struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev, struct queue_properti
 	return mqd_mem_obj;
 }
 
-struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
+struct kfd_mem_obj *allocate_sdma_mqd(struct mqd_manager *mm,
 					struct queue_properties *q)
 {
 	struct kfd_mem_obj *mqd_mem_obj;
+	struct kfd_node *dev = mm->dev;
 	uint64_t offset;
 
 	mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 17cc1f25c8d0..2429d278ef0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -68,7 +68,7 @@
  */
 extern int pipe_priority_map[];
 struct mqd_manager {
-	struct kfd_mem_obj*	(*allocate_mqd)(struct kfd_node *kfd,
+	struct kfd_mem_obj*	(*allocate_mqd)(struct mqd_manager *mm,
 		struct queue_properties *q);
 
 	void	(*init_mqd)(struct mqd_manager *mm, void **mqd,
@@ -153,10 +153,10 @@ struct mqd_user_context_save_area_header {
 	uint32_t wave_state_size;
 };
 
-struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev,
+struct kfd_mem_obj *allocate_hiq_mqd(struct mqd_manager *mm,
 				struct queue_properties *q);
 
-struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
+struct kfd_mem_obj *allocate_sdma_mqd(struct mqd_manager *mm,
 					struct queue_properties *q);
 void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
 				struct kfd_mem_obj *mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 05f3ac2eaef9..90ac3a30e81d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -73,9 +73,10 @@ static void set_priority(struct cik_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *kfd,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 					struct queue_properties *q)
 {
+	struct kfd_node *kfd = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
 	if (kfd_gtt_sa_allocate(kfd, sizeof(struct cik_mqd),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 1695dd78ede8..97055f808d4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -73,9 +73,10 @@ static void set_priority(struct v10_compute_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *kfd,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	struct kfd_node *kfd = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
 	if (kfd_gtt_sa_allocate(kfd, sizeof(struct v10_compute_mqd),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 3c0ae28c5923..5c44d0987737 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -99,9 +99,10 @@ static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 	int size;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 729df66ebfb3..b7ac2dea8775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -80,9 +80,10 @@ static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 558216395a4d..0b0d802a0917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -145,9 +145,10 @@ static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
+	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 	unsigned int size;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d867dccae675..dcf4bbfa641b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -120,10 +120,11 @@ static bool mqd_on_vram(struct amdgpu_device *adev)
 	}
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
 	int retval;
+	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj = NULL;
 
 	/* For V9 only, due to a HW bug, the control stack of a user mode
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index c1fafc502515..09483f0862d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -76,9 +76,10 @@ static void set_priority(struct vi_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
-static struct kfd_mem_obj *allocate_mqd(struct kfd_node *kfd,
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 					struct queue_properties *q)
 {
+	struct kfd_node *kfd = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
 
 	if (kfd_gtt_sa_allocate(kfd, sizeof(struct vi_mqd),
-- 
2.34.1

