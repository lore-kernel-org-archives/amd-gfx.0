Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5213C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 17:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1160C10E783;
	Wed, 24 Jul 2024 17:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpAtMNW3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7026610E783
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 17:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLab/bZwZGVx2ju16d9zy306N0YsOseF8DubobDsxV6ldhEcA0CkAEaMsf55xLDROV5CPQXe5ox4TljG5lGMzAOApmvo+XhqzwiYSrrNJtIgBbLb5dWfj9ndM4PAif7/pGxOu9YjiR+jMGugYINJ4wBJxA+KSJSnwbqOufx9PtQV/9ZgoFIAXeBI75MU6dt0G6Ct6hZjfwBLiHfYXy72B84qlgNDClT0TAgU4DbAYN1ujLT9kT4PoQWHL66/yNmaPyJKdauf/n/DltXXcdED1mibatHPhWeTPpcvAIIAh/PqEaY8vWJRk2VTzhbX536k32LH2pgFc8NOTfoVxzoP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubUBrUVXC3ieEtcf+DNWWNjnSFJj/q7BVx3i6qWMOKQ=;
 b=xk3euymsMSqKgcDTsaxSCjvLedQOh9vy6cC4T0gL6dRGwqMdkiWfolTVo1lJF5RW/8VB/rvaYYtyq+ScvtLqeocplE32U+8M+piI+PfQWvu/FFbHxE0vxYWlVEctHg85G5f3tu0o2VzafAs1z8wZEX2aD6o611NvnQEG4tR3pk9hpoqEqGvsZcLSnOzi1x25rlEAXOqepEDJfvh6yTLJ++JFDWQ5755eD7Y5uhoprTdQFiSOzKvUGJyiRCmjMYTLt3SA7Qob4rXwWJUMKjhjr6L+43hRjGikBfTXHa7Hs6zVVqhCPB0t7wPFM8nNore7ltqu3AEFXVfsb06J6kCgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubUBrUVXC3ieEtcf+DNWWNjnSFJj/q7BVx3i6qWMOKQ=;
 b=YpAtMNW3+LzlibA5jsj7Jm9WPSKTWf653AVRof8+4ijqZRcGvGd40imh9csAqk3VlhrqdmaAsw15wNdEr4UaLo3nYWJjVMifcgNP5iaAUR/BUYQFjWTYtuSBY29S0jIxkPALS7rUIiHDhpLAvKLNa30ieRk/i6X5QtCSg4dFgYw=
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 17:56:48 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::6f) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Wed, 24 Jul 2024 17:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 17:56:47 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 12:56:46 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jonathan
 Kim" <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: allow users to target recommended SDMA engines
Date: Wed, 24 Jul 2024 13:56:37 -0400
Message-ID: <20240724175637.1080028-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6dec06-049d-4e61-20c8-08dcac09fcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D02xG2y/3Y28UPLMSdpyaLlVtUeIdJWr/6fQscW6GOGfVUsm+933HwQVgTDz?=
 =?us-ascii?Q?0Z81OdBv9p7obl+OheU5htr5GWE7uR/6Tjq6ypMttyDohhf2ITdUgJjC00kX?=
 =?us-ascii?Q?y2zQOiCS2mI1IbTfhRkO3OhQq/Ec2/pYhelRuVVT3TZbDqDmh30hBXmTqzeq?=
 =?us-ascii?Q?+AVLDVbpqO0YzvUhuNKwvV8y0K+fDE3iHhC0EwqhvY1g24Nys9lXRYgpB4cT?=
 =?us-ascii?Q?MWM0DK65b42v7meOHCOrSCi0LhXI3M+tRNwutvt8+Td7YRM/R27aKq9wnhZl?=
 =?us-ascii?Q?33cjxjuExf4jrgGu4La12JXFue0+7J2IhKANhkkPqshTT0S8oIJR4+ZE/mWB?=
 =?us-ascii?Q?G8SWIJR2y8FUal35K4OwrwulTeXt9qb2uMjolrssAKWkWcIDDBQjBQf8UW7i?=
 =?us-ascii?Q?B2ALpuA3B9sx1MmBKYYFlKHu24mPM5e9cDavT9GNJXDwtVNjyjQXqFEwTQbq?=
 =?us-ascii?Q?fK6FtHJd1pWtC2eysIDpto2cBFk3zO2ZkMbHq7pEyuLlVdq12J9viqpgORJ5?=
 =?us-ascii?Q?nD1EPMvzDK1Fx2myYzOy0b1IBb23IkuhNW4Q2bF0X3UzCafX8+4UaV8+09ga?=
 =?us-ascii?Q?FdHJF+n4+GvE+WrV9sRqrF/WppIu7se5wZ/6tptzKHthQnP8HW2Crqg3ZMEW?=
 =?us-ascii?Q?k0+sc8zMUtkvN7u+uvBTkO052JZX2I/UUeSiGcLj+Eb51M7p4F5lFJWV/CPY?=
 =?us-ascii?Q?ucAjF6QBBj8fqrtuiEfsx/gL0rvw1S/xxI4zEDdmGT9r/R69nEGXDGdbLiMx?=
 =?us-ascii?Q?opgjYSOAKFVScQSfabeaNS2v2/dbEaquV75szAATuBgFvLkzWnaEHdunL4SY?=
 =?us-ascii?Q?00Kg65NFgYn9mUbeFOgkFqMzSXc0V77VObPFrOcZ1eLVwXtKmE1UdLDUCooS?=
 =?us-ascii?Q?JMd/RfXBzGhNAJCAoZOYzRuzRPcmW8m7Q8x/ekXRZESBhSr8zY+pqLl7U3SW?=
 =?us-ascii?Q?0HY2Jf3K8hf0POO4ZQSDfkblsghIZqTaua526Rp5fp82SyE72sjyGizLzrFJ?=
 =?us-ascii?Q?IkPd+YTbUyc8H/MY6GXSeCBKpm5CjyyLo3s7Uad/+HBDBQ+ofGxQeP8By9jN?=
 =?us-ascii?Q?rPE6ocgdGXxOXxJ8dO5gnxxIodcQn639iG9k3GnJz1IAonSrHVSpI0zen4C4?=
 =?us-ascii?Q?+O0xUV/cvE8pft5uFmRm+bHqr5wluOigCGHFIVVqT9zxIFYffYS/JwI8gGRV?=
 =?us-ascii?Q?8rHgCZD2UKiUwaROErweUAKpm26QwmsWN9iDkuY8uKnTcxjuTWIDluNjlYxJ?=
 =?us-ascii?Q?1ymBemtL5UxxOIPTEm2o3ZL8LEbFKq4zE1fV+erPcujbZZHbeL+HcGJwL12s?=
 =?us-ascii?Q?+9jRznfFNCFKsbHnpaROugW3Gzefpm4OrJK/g5DKUNABqv7hyUzEITMr+Fsl?=
 =?us-ascii?Q?WkOQ3JzTYNVa1+tBaq+qNBaqBDZHNwwFkAHhJsQa0Hpt1ibT7mCvFWLczAUQ?=
 =?us-ascii?Q?DAn6gdZvcf0gDaW4I8m3/M4V2jLEnIqG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:56:47.7739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6dec06-049d-4e61-20c8-08dcac09fcfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

Certain GPUs have better copy performance over xGMI on specific
SDMA engines depending on the source and destination GPU.
Allow users to create SDMA queues on these recommended engines.
Close to 2x overall performance has been observed with this
optimization.

v2: remove unnecessary crat updates and refactor sdma resource
bit setting logic.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 +++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 52 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  1 +
 include/uapi/linux/kfd_ioctl.h                |  6 ++-
 7 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 32e5db509560..9610cb90a47e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -255,6 +255,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 			args->ctx_save_restore_address;
 	q_properties->ctx_save_restore_area_size = args->ctx_save_restore_size;
 	q_properties->ctl_stack_size = args->ctl_stack_size;
+	q_properties->sdma_engine_id = args->sdma_engine_id;
 	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE ||
 		args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
 		q_properties->type = KFD_QUEUE_TYPE_COMPUTE;
@@ -262,6 +263,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		q_properties->type = KFD_QUEUE_TYPE_SDMA;
 	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
 		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
+	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID)
+		q_properties->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
 	else
 		return -ENOTSUPP;
 
@@ -334,6 +337,18 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	if (q_properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
+		int max_sdma_eng_id = kfd_get_num_sdma_engines(dev) +
+				      kfd_get_num_xgmi_sdma_engines(dev) - 1;
+
+		if (q_properties.sdma_engine_id > max_sdma_eng_id) {
+			err = -EINVAL;
+			pr_err("sdma_engine_id %i exceeds maximum id of %i\n",
+			       q_properties.sdma_engine_id, max_sdma_eng_id);
+			goto err_sdma_engine_id;
+		}
+	}
+
 	if (!pdd->qpd.proc_doorbells) {
 		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
 		if (err) {
@@ -425,6 +440,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	if (wptr_bo)
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
+err_sdma_engine_id:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f48507418d2..69315885519d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1534,6 +1534,41 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
 			kfd_get_num_xgmi_sdma_engines(dqm->dev);
+	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
+		int i, num_queues, num_engines, eng_offset = 0, start_engine;
+		bool free_bit_found = false, is_xgmi = false;
+
+		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
+			num_queues = get_num_sdma_queues(dqm);
+			num_engines = kfd_get_num_sdma_engines(dqm->dev);
+			q->properties.type = KFD_QUEUE_TYPE_SDMA;
+		} else {
+			num_queues = get_num_xgmi_sdma_queues(dqm);
+			num_engines = kfd_get_num_xgmi_sdma_engines(dqm->dev);
+			eng_offset = kfd_get_num_sdma_engines(dqm->dev);
+			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
+			is_xgmi = true;
+		}
+
+		/* Scan available bit based on target engine ID. */
+		start_engine = q->properties.sdma_engine_id - eng_offset;
+		for (i = start_engine; i < num_queues; i += num_engines) {
+
+			if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
+				continue;
+
+			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
+			q->sdma_id = i;
+			q->properties.sdma_queue_id = q->sdma_id / num_engines;
+			free_bit_found = true;
+			break;
+		}
+
+		if (!free_bit_found) {
+			dev_err(dev, "No more SDMA queue to allocate for target ID %i\n",
+				q->properties.sdma_engine_id);
+			return -ENOMEM;
+		}
 	}
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
@@ -1786,7 +1821,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	}
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
-		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
+		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
 		dqm_lock(dqm);
 		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b3ec92981e8..7d26e71dfd04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -414,13 +414,16 @@ enum kfd_unmap_queues_filter {
  * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
  *
  * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
+ *
+ * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDMA engine ID.
  */
 enum kfd_queue_type  {
 	KFD_QUEUE_TYPE_COMPUTE,
 	KFD_QUEUE_TYPE_SDMA,
 	KFD_QUEUE_TYPE_HIQ,
 	KFD_QUEUE_TYPE_DIQ,
-	KFD_QUEUE_TYPE_SDMA_XGMI
+	KFD_QUEUE_TYPE_SDMA_XGMI,
+	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
 };
 
 enum kfd_queue_format {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 21f5a1fb3bf8..8adf20760e67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,6 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	switch (type) {
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
+	case KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:
 		/* SDMA queues are always allocated statically no matter
 		 * which scheduler mode is used. We also do not need to
 		 * check whether a SDMA queue can be allocated here, because
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6f89b06f89d3..f6effaabd4b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -292,6 +292,8 @@ static ssize_t iolink_show(struct kobject *kobj, struct attribute *attr,
 			      iolink->max_bandwidth);
 	sysfs_show_32bit_prop(buffer, offs, "recommended_transfer_size",
 			      iolink->rec_transfer_size);
+	sysfs_show_32bit_prop(buffer, offs, "recommended_sdma_engine_id_mask",
+			      iolink->rec_sdma_eng_id_mask);
 	sysfs_show_32bit_prop(buffer, offs, "flags", iolink->flags);
 
 	return offs;
@@ -1265,6 +1267,55 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 	}
 }
 
+#define REC_SDMA_NUM_GPU	8
+static const int rec_sdma_eng_map[REC_SDMA_NUM_GPU][REC_SDMA_NUM_GPU] = {
+							{ -1, 14, 12, 2, 4, 8, 10, 6 },
+							{ 14, -1, 2, 10, 8, 4, 6, 12 },
+							{ 10, 2, -1, 12, 14, 6, 4, 8 },
+							{ 2, 12, 10, -1, 6, 14, 8, 4 },
+							{ 4, 8, 14, 6, -1, 10, 12, 2 },
+							{ 8, 4, 6, 14, 12, -1, 2, 10 },
+							{ 10, 6, 4, 8, 12, 2, -1, 14 },
+							{ 6, 12, 8, 4, 2, 10, 14, -1 }};
+
+static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
+					     struct kfd_iolink_properties *outbound_link,
+					     struct kfd_iolink_properties *inbound_link)
+{
+	struct kfd_node *gpu = outbound_link->gpu;
+	struct amdgpu_device *adev = gpu->adev;
+	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
+		adev->aid_mask && num_xgmi_nodes &&
+		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
+		      AMDGPU_SPX_PARTITION_MODE) &&
+		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
+
+	if (support_rec_eng) {
+		int src_socket_id = adev->gmc.xgmi.physical_node_id;
+		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
+
+		outbound_link->rec_sdma_eng_id_mask =
+			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
+		inbound_link->rec_sdma_eng_id_mask =
+			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];
+	} else {
+		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
+		int i, eng_offset = 0;
+
+		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
+			eng_offset = num_sdma_eng;
+			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
+		}
+
+		for (i = 0; i < num_sdma_eng; i++) {
+			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
+			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
+		}
+	}
+}
+
 static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 {
 	struct kfd_iolink_properties *link, *inbound_link;
@@ -1303,6 +1354,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
 			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
+			kfd_set_recommended_sdma_engines(peer_dev, link, inbound_link);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2d1c9d771bef..43ba67890f2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -121,6 +121,7 @@ struct kfd_iolink_properties {
 	uint32_t		min_bandwidth;
 	uint32_t		max_bandwidth;
 	uint32_t		rec_transfer_size;
+	uint32_t		rec_sdma_eng_id_mask;
 	uint32_t		flags;
 	struct kfd_node		*gpu;
 	struct kobject		*kobj;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 285a36601dc9..71a7ce5f2d4c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -42,9 +42,10 @@
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  * - 1.16 - Add contiguous VRAM allocation flag
+ * - 1.17 - Add SDMA queue creation with target SDMA engine ID
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 16
+#define KFD_IOCTL_MINOR_VERSION 17
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -56,6 +57,7 @@ struct kfd_ioctl_get_version_args {
 #define KFD_IOC_QUEUE_TYPE_SDMA			0x1
 #define KFD_IOC_QUEUE_TYPE_COMPUTE_AQL		0x2
 #define KFD_IOC_QUEUE_TYPE_SDMA_XGMI		0x3
+#define KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID	0x4
 
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
@@ -78,6 +80,8 @@ struct kfd_ioctl_create_queue_args {
 	__u64 ctx_save_restore_address; /* to KFD */
 	__u32 ctx_save_restore_size;	/* to KFD */
 	__u32 ctl_stack_size;		/* to KFD */
+	__u32 sdma_engine_id;		/* to KFD */
+	__u32 pad;
 };
 
 struct kfd_ioctl_destroy_queue_args {
-- 
2.34.1

