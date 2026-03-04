Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A7FEFCE38
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 18:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BFE10EA97;
	Wed,  4 Mar 2026 18:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUcefKv/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60AA10EA97
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 18:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RftT5dyCjR9gAUTLGePi+LWP+qz6/DJ2r9HUSKTTApFAus3dVDwgz5/6hWKseCyiAac29U4fhbjWg4PodTvNl7v2CxVxNi4BDu28+Xdc0APXxygyvGNd//Y3qKguUaFw2nsAZx5aIFtL/OUqHTinG07BudwwzJK7d9aTAZP1QiVqz8LmsZz7ywyg1pr5LOkUrTIflRlHwgGlnj9lmTdPRc3wPoThqaAccn78bqF81NU2KEvdZbluWZa3Qs1QoSdu2WF72wp/bpuqcuPfU/vOCjiIbPtjNth1O1Gv1FJ1HFUjeubyh91ZdVmCbRoHLyuc74C/PcHsanbqMfjqxC40eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXAhGFQX0wX+VWAGp5WbJpQP7jde5Nmk55SKkOIJrDE=;
 b=dePMq8VjFqgku92fO3wzZ2AU0xYZo523V9oxlw0HubITuFnTDwSnnJeQSm7W5MFGTSFM6tlGIYpXWyLvzfCPjZyqRflWsFfxsigpOm2G9D/PYfHpvF3QxcMaNxNOkvyKMJO3TFFB1SR+idSHwwwUscRX3U01DYnjwTjlJYbXw8wrSK6y30RwUJ9lR9q3b5Vv6LZa4H6AEqCIgyNsE2ESOvra2gqKYd+6rEbGka8thhU7uoVuo19Vq3jUj3gufX04WUaQk9e4QxFUqoRIuC6OG+XzRcnVBnWAhac0mcOv5kUwHKm4owynJzET3jGAmxHcvkB0YfCn0XzTWinI2Ju4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXAhGFQX0wX+VWAGp5WbJpQP7jde5Nmk55SKkOIJrDE=;
 b=TUcefKv/CYiHafFlOpLNLZCwVvtlzFeT1j09J8yqI3bwNek/oxOU2/9tfnYLpALynvy7AET4jHO5w/HGIHAn+8lWnUW8xTo3PSyGPhOpiGXVOrTNEsyWeCLp2WSe2ZcUwYAnAn+aPn3yBX5WB6YHnU0SbnEgMrfYBUwlVH82YBU=
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 18:33:20 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1a) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Wed,
 4 Mar 2026 18:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 18:33:19 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 12:33:18 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdgpu: Check for multiplication overflow in checkpoint
 stack size
Date: Wed, 4 Mar 2026 13:33:03 -0500
Message-ID: <20260304183303.1116307-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: ace94a1a-b8f4-47c1-c6a0-08de7a1c8205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: YZ3vX8V3jMpAiynFgKKfkbqvFTq8IElXpLl5Y3SytfzZTUFw2DSSkWBuTr73kcacT2rQhrQZjhUUJVICs83Bj+4mI3KAVSidsUcFTKf87oaGZjStT2z0KfNlIoC1hQ2Qo37jh0v/m5bFpgTbHqp+iNHVvJxN2mlS1vxuvb2oPAnnMYegj7EGMgzMssQdUDOYdO7JuHUvQyP81DcSqyQcUjcRc7iK7Z0XCAT4Q1leUSQlrTKHzZ0BeGB1UseW+DAe4QWTzGAG7YAjmgUE4l9Lb62nDQYvIm4KohEByDNuNsTSwzarObQojWPHYrnSLW4h0psG47dmNkbDl1qxSbD9hDvtsO+GMm1OpcnJcELA3zjlRgfPZ+kypyX5XW81sbQlq+EBTGmoKBmiQZrJbn/CNfyBdzLGRc2xWnMCt5BMojQ6fNorLg1V+4QeZe+CoOJi2yB6Xys7lxfVYV+GPRnY5hz7QCdbVD+hx8RnBE0/VrBE3D2bxlnkinQRW9Rd/HRy2ElDLskK36aOpOMfmHUA0Pl3VLYUiFtfter2zMIZgwx/AdQ1geA6TC6oBzoLqIPOwBsg3zAIgxPzVvkLN0D7GRS/XsW9aEfJ1/pzDqNf0rNjWQKXgj/es/7okjmp1VmKg6CTVlWWy8sxKAaKmB03NoH/wlgz3I2p9PFbfihJ52D1lP049hs7ve4n7n8S7gqVK4gQAykLR/VdqjT/tX7uB7UuEDmha51cHwW7qEkgBXJd9CWZGc03fDTHJwYpzJ4evsfGFc3WcncuPkPC/2/5hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sqRg/pXjsuqk6iPFIj4dKyM+NJQq3BrIAqehNmo8jaaqhKMponiY6nGLLN5hWi17R5ZprD3IOthk00WHFz0rb5yE2NxK/NsIJcJQ8QCHHp8TAvBHIdmpJv88gcjECo0ITRSfXgHcpmQ22bd/t/aJzxD4YQp88h019bfm0GywknSlQR1YsUn9pb3x49MmbAnsWdjUygo2k3GlFEYm8gAqSavQ3UC/kbq+9P37QD/0qxCNYLFmEbBXP2w66dB2rX1Z/+80+wNwXLzmt315mN5lWGBwJCVgMjloblgP2WTXGvkYxc8Vs5ysrGAX6Ai5gXN4508+/MV9Ce+uTG4aCSW/+rMwUg6Ziuoh1cJuU8hpIYcUFeL5rnB5FxiLc8HScwfbYXVlJaaTq7aBCRDRMZTrr3Pbpq3kENTtj9iJDA/5LknneHQmwQxD0CEXI3SU41NP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:33:19.1178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace94a1a-b8f4-47c1-c6a0-08de7a1c8205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

get_checkpoint_info() in kfd_mqd_manager_v9.c finds 32-bit value
ctl_stack_size by multiplying two 32-bit values. This can overflow to a
lower value, which could result in copying outside the bounds of
a buffer in checkpoint_mqd() in the same file.

Put in a check for the overflow, and fail with -EINVAL if detected.

v2: use check_mul_overflow()

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 +++++++-
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 804851632c4c..18bc5ba25f8f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2720,7 +2720,7 @@ static int get_wave_state(struct device_queue_manager *dqm,
 			ctl_stack, ctl_stack_used_size, save_area_used_size);
 }
 
-static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
+static int get_queue_checkpoint_info(struct device_queue_manager *dqm,
 			const struct queue *q,
 			u32 *mqd_size,
 			u32 *ctl_stack_size)
@@ -2728,6 +2728,7 @@ static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	enum KFD_MQD_TYPE mqd_type =
 			get_mqd_type_from_queue_type(q->properties.type);
+	int ret = 0;
 
 	dqm_lock(dqm);
 	mqd_mgr = dqm->mqd_mgrs[mqd_type];
@@ -2735,9 +2736,11 @@ static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
 	*ctl_stack_size = 0;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->get_checkpoint_info)
-		mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, ctl_stack_size);
+		ret = mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, ctl_stack_size);
 
 	dqm_unlock(dqm);
+
+	return ret;
 }
 
 static int checkpoint_mqd(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index ef07e44916f8..3272328da11f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -192,7 +192,7 @@ struct device_queue_manager_ops {
 
 	int (*reset_queues)(struct device_queue_manager *dqm,
 					uint16_t pasid);
-	void	(*get_queue_checkpoint_info)(struct device_queue_manager *dqm,
+	int	(*get_queue_checkpoint_info)(struct device_queue_manager *dqm,
 				  const struct queue *q, u32 *mqd_size,
 				  u32 *ctl_stack_size);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 2429d278ef0e..06ca6235ff1b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -102,7 +102,8 @@ struct mqd_manager {
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
 
-	void	(*get_checkpoint_info)(struct mqd_manager *mm, void *mqd, uint32_t *ctl_stack_size);
+	int	(*get_checkpoint_info)(struct mqd_manager *mm, void *mqd,
+				       uint32_t *ctl_stack_size);
 
 	void	(*checkpoint_mqd)(struct mqd_manager *mm,
 				  void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 273d52c8d332..8630f679a5d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -385,11 +385,14 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
 {
 	struct v9_mqd *m = get_mqd(mqd);
 
-	*ctl_stack_size = m->cp_hqd_cntl_stack_size * NUM_XCC(mm->dev->xcc_mask);
+	if (check_mul_overflow(m->cp_hqd_cntl_stack_size, NUM_XCC(mm->dev->xcc_mask), ctl_stack_size))
+		return -EINVAL;
+
+	return 0;
 }
 
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index c192c66a5c7b..499d366db91c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -274,10 +274,11 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
 {
 	/* Control stack is stored in user mode */
 	*ctl_stack_size = 0;
+	return 0;
 }
 
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 449be58e884c..cb2416687137 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1069,6 +1069,7 @@ int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 				  uint32_t *ctl_stack_size)
 {
 	struct process_queue_node *pqn;
+	int ret;
 
 	pqn = get_queue_by_qid(pqm, qid);
 	if (!pqn) {
@@ -1081,9 +1082,14 @@ int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 		return -EOPNOTSUPP;
 	}
 
-	pqn->q->device->dqm->ops.get_queue_checkpoint_info(pqn->q->device->dqm,
+	ret = pqn->q->device->dqm->ops.get_queue_checkpoint_info(pqn->q->device->dqm,
 						       pqn->q, mqd_size,
 						       ctl_stack_size);
+	if (ret) {
+		pr_debug("amdkfd: Overflow while computing stack size for queue %d\n", qid);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

