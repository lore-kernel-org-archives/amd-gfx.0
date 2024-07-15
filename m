Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943E6C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C4910E388;
	Mon, 15 Jul 2024 12:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YLXHcjV+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E2C10E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lApJ1hSv00imJg3wSKR77b4/b8FIKK7Acg/7bxgy4ykgMGz2K/qVSfiKgDh3XY/Z/YFre/pWwojzoGcbGe1PosrEHLrMQ3B6YY0/2OBOunHYN7AzKVDOi+sT+g3L/43irkVu90RK/Nh8aHM8dsnEbzJt0yIivtLRwVxlBLoLne7zH4WYmLuDG2nYxUw2s1iKrC774AVWejROVyc1MkuAIEM3n+8GFwrhBwAizN2nMWBFZ3Oj+samWn/aCiZJSyha+n7yJf87XXDkeSZFeMoWSKVI+VDEBmoMkI0WUn4snygQ6nBrsdHLgUx4FsIGsfqndGieI1OlAzUm3AnNGjS/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xis0btyevP9nJWm94XuT6QoXu0tKTh+nikj+geif/78=;
 b=x8uZVG7jPThBZd6CVyvBspHxTaETvU3ZmmNzasLuUpyJxj2Hr6Rt9Bapx139B2ORScGOgff4SKLWEtKbnn7b9a22gpjsRFZZPv6dL5NgeZK0qkhDj3MNSIs021G0ebm7GRatLw/qc4dlIvLUwNbin3eiagZZLuv2cdKWoUrZRoZ2aOCKUqQoegutazYeEfrhJVWW/a63+GXRBW/KUv7kjMXMjEBi6Rlg52+irAOlf5JWG3kflyNvIrWRA2KGcmCM73c6TiK5hdcUJMBlyfQb73b8a0/qPp/hA7LhALHWqASeN8AUrnf/GzXN/Lcs+32ITu2c/24POVkxZfHej7EWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xis0btyevP9nJWm94XuT6QoXu0tKTh+nikj+geif/78=;
 b=YLXHcjV+Q5VQVhRy95UzMm1Vs/ZZfyLK3TAdC9vLFwo+xa3bhlBYrdd2qeXbfRPBtYpZXVHpOXFkDPaGgbR1tnCwDNucW80NZa+UJEcV3z5j5kqchzc9dALBWjCS/2lTSZlOcDe8j3prjoXZJc1VaYl3UFUiigKNjr+4QqRdrgE=
Received: from BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 12:36:27 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::62) by BL1PR13CA0318.outlook.office365.com
 (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/9] drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
Date: Mon, 15 Jul 2024 08:34:55 -0400
Message-ID: <20240715123502.7013-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 335ef45d-e064-48ed-c380-08dca4cabf4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9wdtDwhJ0pmRcrZlDK+i+EiAjwusI6ioWm0DvkGK8meOHoGoFVBuLnQvawB3?=
 =?us-ascii?Q?t1fc5XEeCgyGrvtsEIbZ/aCtjj77cAEJdWT2uJb3TeYNrZNpNHCYVFlCMkRF?=
 =?us-ascii?Q?wDdrJKYlshjCU5WFc9/4OBXX1LpJO0Re0BOph8rPFXRIOJoTV66eMg/lzPvb?=
 =?us-ascii?Q?7u78S0Y9rVo1l6hZa6TBet7IDddqM6oFO6/mCc399GFuztHTUXtDwvsWyGly?=
 =?us-ascii?Q?SOofutO224bFknMNiVktG0wBmLpo1amjsrLB+Usp9DhC9iu11U+zF/Y77oZq?=
 =?us-ascii?Q?eDF82yMxUhGcRdRs397yL8v6shDu3yMEto63siW3HmteYKeljhj572rX6ezN?=
 =?us-ascii?Q?bcqTQQWuEwqnridkGsBBFYjhG9SgbDJnqjVz4oj7yK7nvd9ZhzWLcH5zJ7Tj?=
 =?us-ascii?Q?S7gFIcDlBKjS9cbnbAKNcCeaYfYQTV2y1E2VAhEoBhrDTUZT5QLTDo0uOZxS?=
 =?us-ascii?Q?MoytuUHxPtiHJIPvITh5XPWIGdwEGStl8SoKpXHLAZV25/mGAZ2PCaG/jKEx?=
 =?us-ascii?Q?AYq6+8bpbo+cqsJJDy/IqhkYhPGRTPsP0wzFa8+DrlOI6v/0P4Zhyc1VrKUz?=
 =?us-ascii?Q?jqcURzC9hT49UFrlhCLMfyPs69bAM7b7566wBlAWkzK3e8EwP7mXbGFXDSYj?=
 =?us-ascii?Q?18PjZ/1f7+66fPi3mWQawcoPtJiM/CtKqDtInZUCPy8M6G6u8q3V6MNRrE0K?=
 =?us-ascii?Q?/CYybzGKuQhCIFIAcjZontg1VvScfcKaDUF+yrrqPIOJrwyhJlh/tfR1IS61?=
 =?us-ascii?Q?GyG+06pNl2CNQEydxEznOAqKHNkndvPUA6bIDFBfUL0OHWBj7m9Hr1AyJT3U?=
 =?us-ascii?Q?KdG5rPMoSUx63Ye9DFDJH3TbEuz7cKRiB6VL8JpTgZ0gK2VCyhFk/7hsItu2?=
 =?us-ascii?Q?qnV4DL+7lSJcQln6SdMANikCdg0nirhnjDakofRzcOQSeCvD2IgNOK0IuT8g?=
 =?us-ascii?Q?P1H1u1QsT+kWbt0imDEwsecUzoop2BRQ+7o8R5McfXTiE0oaLcZmxCiFj/8U?=
 =?us-ascii?Q?H0OKs21XPKTzbqZ8WUhn4fsvunxHuoyfKSLit+yjq9gpmIKcIqvIo+AJcFTP?=
 =?us-ascii?Q?An1R6jGxYj9eggOrDv2z8WHAfXxgeoWrWjWWUARpg4dzavMT3howQ46kC4B0?=
 =?us-ascii?Q?rb/Y+x1cX5PI7OlKGyVyklKDjlyb/1tB3OcZqI1L/riw57MtxpgrjwD50aH6?=
 =?us-ascii?Q?72FhPq3anL9Di9hsKkZ9vWZmAD1u4gK3nR+ChPfdkod1trdOj1R7Sc1p6m50?=
 =?us-ascii?Q?Lnn+AIjz+zHpHpciA3+qXCJkpCmlHxsfUIel9XPvO9rbMI17LEVw9n4ppFmi?=
 =?us-ascii?Q?RvdeE0gpErWHaiPJRZjnIwAv3vj20KscfUk0fOwtm1pQYd8OP466Wbct81q/?=
 =?us-ascii?Q?/XEukLxjjl6ps4IXZlmcMXpXF1hmPnD5EG7cLPvd08b4EeUc4cAzSdn1TQ9n?=
 =?us-ascii?Q?DOjKMg6gXub1U458jocwvrK7a2zAJerA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:27.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ef45d-e064-48ed-c380-08dca4cabf4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Pass pointer reference to amdgpu_bo_unref to clear the correct pointer,
otherwise amdgpu_bo_unref clear the local variable, the original pointer
not set to NULL, this could cause use-after-free bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 03205e3c3746..c272461d70a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -364,15 +364,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
-	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
+	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&(bo));
+	amdgpu_bo_reserve(*bo, true);
+	amdgpu_bo_kunmap(*bo);
+	amdgpu_bo_unpin(*bo);
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
 }
 
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 66b1c72c81e5..6e591280774b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -235,7 +235,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d9b21628be7..823f245dc7d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -423,7 +423,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 err_create_queue:
 	if (wptr_bo)
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
 err_wptr_map_gart:
 err_bind_process:
 err_pdd:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f4d20adaa068..6619028dd58b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -907,7 +907,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 alloc_gtt_mem_failure:
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
@@ -925,7 +925,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f48507418d2..420444eb8e98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2621,7 +2621,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 50a81da43ce1..d9ae854b6908 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,7 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d65974f3b34d..70d6359bb5a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1048,7 +1048,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
-						   pdd->proc_ctx_bo);
+						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 21f5a1fb3bf8..36f0460cbffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -204,9 +204,9 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
 		if (pqn->q->wptr_bo)
-			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
 	}
 }
 
-- 
2.43.2

