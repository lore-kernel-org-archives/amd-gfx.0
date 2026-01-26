Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9403CF65D0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 10:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A42710E3F6;
	Mon, 26 Jan 2026 10:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uj3AkMag";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9499F10E3F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 10:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjqjDrhRIHv9OyAI7vS9a2ruoCbBnHjdgO7UJhiwrAC/4qNByB4tnFJdCCHFh17nQ42tDcAhVh2sgS1G5mLIPKEjsODvJc/TaocjeN0WW0M6QTS7FjNbXjpTpkVyoAAiq5dXToltvdI0ILzQhccSccaVKqJejLXxf5HfmNJKWsSN6+Ajl4LM1zbKqpEHw/pt2mRb59Jnl1AnfCVFsdhWYPIMCsbk5/xgBZoh60u5pSkUyMUT61gfXxH8SG5AYfdwf/2U8BgRVMDSZck5rhpBFYj7uAihnM38uHZOS7u0XyY5NUBQ1iyLrfDGwqno35MZe9XVULsTuCANov0nF1L+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M11yUEPm4PrzSzpH6SSyj/85ptPQW6X/S3jtMCt8sQI=;
 b=dBg5njfRXUngcHNh13tc2q1RlMbaUkQBwy1jpErFxhom+MwFdHjrmLhaWEcNluQI2hFGcQ8xbvO/jSX3XoJSxpjHk3getTNre6AAdAcIsE/SS9eMqkcT/ZBoNlKM8uX0pQ2+1oe/sTbsHyXjCLvFFuSMLiPILuW6Wn2T8BUFdOExzR1+e9Zqzzr+GS/fkP3bM5QceBEAVtxD+v8tIlhk3YI25MyGZBsQ9icSOdDsRnD5vMWrkpdWswF1XVWUaW9ykN2+NupO2VnIH3rGQWOC+JDSBTF+o7XvLHfuu6JSjlVz5hkXAQbwddrfBw1toQix7mIiTpRaxnTn2x+hfYkx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M11yUEPm4PrzSzpH6SSyj/85ptPQW6X/S3jtMCt8sQI=;
 b=uj3AkMagVZiMTG4O6gSzEb40X/P0a/xL6Dgc0n2n/W7vpZBscRhZcNKoSc6PJ6bcWhQ+ykeoIg+hYr3mBgM3+cZLr/w5j36ZwP5nBGkORDOJ3s3KMHxLOwwqbj1JSlqKpBqdu5HdbdRSybGJjreqcZ3eQldB/liYeqgjoW2zZ2g=
Received: from MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 26 Jan
 2026 10:25:53 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::79) by MN2PR08CA0010.outlook.office365.com
 (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:25:53 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 04:25:51 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: Adjust parameter of allocate_mqd
Date: Mon, 26 Jan 2026 18:25:13 +0800
Message-ID: <20260126102514.273891-3-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126102514.273891-1-lang.yu@amd.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ef4ec5-afe5-4927-5b31-08de5cc5490c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wp1DZpsc8hNSY5AaiGkvaM6i1NLdhu6t4KbgDnIWfkggPXZVjbIY0rHX51fX?=
 =?us-ascii?Q?kvw9dlxNSRA85evgLANGfpzXzw2d+AeOAHXJqRBBUcifodLds0ucg+0JTuAc?=
 =?us-ascii?Q?F1I0CerM9mOtpHilQZ1ThBAX+2vuILaI6TD6EXgXwCAK3cKx7BfQJ8H85exQ?=
 =?us-ascii?Q?0iSmRbrHlNFW+hdGWFB/lKl/jqhByUVBDtw+s34oyAW8hxatrX6ElaV92JaY?=
 =?us-ascii?Q?byVDYm72/YeARb54/NByvh0Aq9pghWSMiS77uVkUP88+Au5I6ft7V5DpMhxX?=
 =?us-ascii?Q?bgf7DwfyIVON3SsdM5Ej2WaHNx1d4ZiQxeCcxCqFqKq/IXm+p3Awci+O1qD+?=
 =?us-ascii?Q?xt4iyvHyb24Fsuaz3e3Tu1b+ofl/15H2I0nXu4aWLn29dbAbvHt5mJYsPC+o?=
 =?us-ascii?Q?s5WNcr9fFr3MEc2qnO7GPkJBNGb48O9Ce0WP+p/KekhVaeDwKeKSXGj3U/Nf?=
 =?us-ascii?Q?F+MI0ozS5Fdk7UIEcLcsYgjqkzSQGa+c6Gj6Xz0fO2agfEnmdlUJZgmC5Vt3?=
 =?us-ascii?Q?zyWgc0MdM5G41HB89OpC8hk01v5QfJv/gS/2ISROh/HgrC9062exr1wiiTy6?=
 =?us-ascii?Q?q80TpLTTuLvgpwFLzwnTw/YeUW5fDR5D6o6rEfyL4YeRt0Ip6pOxgI/N+rOb?=
 =?us-ascii?Q?MS/eNhugqNMsfdzDaUMllh3DueE2NckmdrhJdsSjH0EJvr/IBLAIdbpxe+PX?=
 =?us-ascii?Q?fnhz+jCemOeWhO3Eeex7A682FCnVlm7DwEoT9i4gSvwKS3LNbOVqlBpJOc+R?=
 =?us-ascii?Q?+E1zyqD2LzBH9Z0tjRZ+v0HdBagM1g29vTsD1F0Vo6YeRkMdxgGg54mbcPpY?=
 =?us-ascii?Q?hdkYiMZIP+HPmXtVu9DAPv7CdnErvWWCjqOeA+9TPnT8W3PsMolStcJGUMdW?=
 =?us-ascii?Q?p2wr9kAYVBD5bLYwDG1k1LH5L83Vuq7DS97FjeGPjuR6R7K2g/bCZjvyD4Ih?=
 =?us-ascii?Q?8bQlpsi5WV0+0BA2eMBGx9O7c724QlQNDZ9Ax9wxe6IAiqMAX2Sr9aadozXG?=
 =?us-ascii?Q?A5HCOG7JDad8xwXbj3AvRgyUHmlZveRdIAd0bKJ8yfQt7KgFtP/09QXAcrm/?=
 =?us-ascii?Q?Dq4j8WwVdZmEz5vQK94OBWSthG16NnuL2szirEK3f/6tN6dJgzMB4/MxxlkM?=
 =?us-ascii?Q?1B2hrD/tbDHIfwiVgDiGPswkgaft3AsunTvnlEbNaPGCqiXssA5JttIbAL1E?=
 =?us-ascii?Q?Ks7ZB8BoZabdX7EKmgQds7r0QMma06PfT8OC7xnCzAIfcFJGpsH1rPLiT6of?=
 =?us-ascii?Q?evvFPiwBLsq9FBnobyLscvGAm13oyuZdXZZKEnvoJHggWwyeC3URD9SCVaYD?=
 =?us-ascii?Q?ISocFSi5dYcv/KbuYTWhHecO5qVeT0gGCEDSEgzmCeIM+5dFfyplJytR4p69?=
 =?us-ascii?Q?kC81raxkE88EwjZH/s6fzel3Rc0IY5GoaxcAlEC82QiEXGVRyRYYSzotBFK1?=
 =?us-ascii?Q?zBVZH3CnXPmbFQmoV9598yCd72KdzXbcylQkTQZd+Ijro/jhPXGTfwwI1VlA?=
 =?us-ascii?Q?ZYqoqekyK/zdsxc4pkpzF95cpdV0UeBQWbPekgUowACVF6bjLiDeDcHNK+/g?=
 =?us-ascii?Q?fULRukX+qVLowMZfCzLsbhpr25UwWsDc8TKjyVTZV47gVKnv5PqnQ4LWF2T6?=
 =?us-ascii?Q?SLO/98n+zP9dLWiYEqYQ7Tb6TutctgjOMdW+lBZBRnse7SkP70GmVLIOXTsH?=
 =?us-ascii?Q?/V6ZhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:25:53.6604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef4ec5-afe5-4927-5b31-08de5cc5490c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

