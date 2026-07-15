Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B84C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE38010E034;
	Wed, 15 Jul 2026 10:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qAlsmd1K";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2731D10E034
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvHRvHN6KXSuDJQn9U4S69JTDjXTQRNIZ3lELwOrW7so8EejCRo0Y0JCA0nGDQzya2m4Zrco2py0xTC5We9nUtSoNeSLYOyqO33l8LuNeTHaER2KeBIw9cR/MnDax8WkOG/L5yYBOgOpH7hvQFNPk2+qMNOurw3iU/nZoEHNy7CU3UYPf+CnUxnY8NhRT9zm6+pQYuVfWmZy3RMHr2c/C3DlX7+9DMH/HYd5ckW04Ffs7x/phkFzG9kS94cqEhcDZFy0KtDM8diuIj92DC01LoEQRSvjqGZ/ni1ja6MJv+tgc5gvAH4Ok60pRpg1czXVwgooe/70bIrcRU/HBPEwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+br/ore7m9arZkA1RRbsJVrXfcWzrw92G4dk+3LpYCQ=;
 b=XIkbYvumGfwbO9QB40uL2Z3IncaN6XdacohUH6i6XRkNqa2pTc9+oueyg0cQ+pnzfgiXDTxJrOQW9amk8YvYMGO5OsVUSI6fqRzVjSabaeYiyng+q3QhOFvws6Zb3roug01rUA+Sp1iq/qPQ5+5CY7CllB7GxNkl2OkiCyBQ7YPpaQsfa/T7ULHCwUi0wSX6km0gfjtG/8y5uTb+EmFWVqsJmU6TtOHrS0H39adv+erdtY6XEzRPam47dDlZj0FVcYvv6CSuj/v4nmNUApB+ywbzoXcXvxCNjJgfS4YIuY9BCDOtj3sf5pzvhKj0yNUqgn/q9pHyXYJ5tm6x1MQoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+br/ore7m9arZkA1RRbsJVrXfcWzrw92G4dk+3LpYCQ=;
 b=qAlsmd1Km5DTVAXIbsXnZWeTM37N7h2ApEcWVR+WcZIysFjYz93kdytDHAY6tduBLx/UjRJpEeJNTOToh8NyTLUl1j5R+63fU8tbFyIKpUzx5XeaMri2SLbUXHdF40g+jtg2GjtIpolIJPfx4GjR0fneipgtf1AvhEi1pEdEriU=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 10:31:27 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7c) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 10:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 10:31:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 05:31:08 -0500
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 05:31:07 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH] drm/amdkfd: save/restore MQD across hibernation when MQD is
 in VRAM
Date: Wed, 15 Jul 2026 18:30:56 +0800
Message-ID: <20260715103056.3529178-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf224fe-2853-414e-80a2-08dee25c39eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6xctO61xpIURNk0ail0ufX1S9+YV0SuGRkFi6MHbqdmXafSJ7xeqLtgVuQbqzx3fPS+2huKA08iPGV0KQkFEvIpvihO/5Pc0TP/6fJrku77PKMYJfLvfMQnZOrUV0prmNvvxe1aTWLDt5uzANwXetexaN5WOtcCU7tDHzFk8p6jIEPMFo3YFs2DgpYiDO7LFJKDttRFc6BOsCLTOQuyjIw7wccWd/v3Ji1oJwYZJEVT9PINvQrV8bTZm8tbR6ns14Nuz4nIRVSBT1QylyKAAfoSp+cQdM55szsSR02aceP+tp8TXxIFrpujgrOFkAfhohgkd2+OOmJsxQi9QAIfG/1Qbvc9L6OZ0GQ7nvHv9YvWV0MhtsdnYp5v3SoKACLZufsa60VvMmeyzEVpmJxPJq12BU1htm0MJRakPKRIKg7g07wXvHBIoe4gcjtiVkBoUcWzpTd3TY/naEMD1pIjg+X45nBji9j+3Hx7xLhvNGKepejgkISeAeamB0MihHunXTRpbGSdaftDNJvzKLndZ5FI/AcXA8EpxkISaD9X3/Vf3WzqseGEJd/KcowAuBHOKQ0tHPcjNQ4nNd+FZ4o9bMOB4sx0NuR8nk8aQUuRn0688W5GI0yoq5HYYVpUah5YpyPTb6OB1xov9etbJ2R69Bb30YGQu358EpE0WcJ9nBvbQFae/n17rulia3A1oRiMHa9n8O7JgDba+fXrBkNVrNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SBA+wtYlwCGFQTdm88gftuCv6yhgpGYBxH3M1ePUDK2u6ouKl3vREKqJtQ6dbnxUE5jvxmtoTBWCtfycAkOAl4EgvTUf807An9qCCQ9tHsdRgnfJr6tleFLw3sfnNbXT73+GDStSNeCuDCHPatoP4UJAJvpLsNPlTzysmol75Eu4u8808z6unSF2xaa5mLcdp70oDJHp/ceOkK0ieNHd3C3Ns5WrJVhwpgy+vtHZJPRt+FBrS/KHEs/tKaHzlvKGcIPdw8M0Mxgz25AiBXPwHUn1oqWyq+M+fq0v9qDmaPNy/971K4cZouN+U3on9RoD1swnnfiUrFpo1fYGfDxBX0gOjqVMaXkGLnmn3rQn63b1B4Ka31e8RdKAJCiellBE6bNHTJHR7KOiaZy2HtMavrZIXukNAijv5wHkgKLC+be1EArCnh41JVt1DgWvW6Kq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:31:26.9295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf224fe-2853-414e-80a2-08dee25c39eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
across S4 hibernation, so the MQD is garbage on resume and the first
submission faults. Save it to a system-RAM shadow at suspend and restore
it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 100 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5446d89a84b3..ba5ddd98891e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager *dqm);
 static void deallocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q);
 
+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct queue *q);
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct queue *q);
+
 static inline void deallocate_hqd(struct device_queue_manager *dqm,
 				struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
@@ -785,6 +788,10 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
 
+	retval = dqm_alloc_mqd_backup(dqm, q);
+	if (retval)
+		goto out_free_mqd;
+
 	if (q->properties.is_active) {
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
@@ -1280,6 +1287,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			 * maintain a consistent eviction state
 			 */
 			ret = retval;
+
+		dqm_save_mqd_backup(dqm, q);
 	}
 
 out:
@@ -1287,6 +1296,88 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 	return ret;
 }
 
+/* MQD software-shadow save/restore across S4 hibernation, reusing the CRIU
+ * checkpoint_mqd/restore_mqd primitives.
+ */
+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct mqd_manager *mqd_mgr;
+	uint32_t mqd_size, ctl_stack_size = 0;
+
+	if (!mqd_on_vram(dqm->dev->adev))
+		return 0;
+	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
+		return 0;
+	if (!q->mqd)
+		return 0;
+
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+	if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
+		return 0;
+
+	mqd_size = AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
+		   NUM_XCC(dqm->dev->xcc_mask);
+	if (mqd_mgr->get_checkpoint_info)
+		mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_size);
+
+	if (!q->mqd_backup) {
+		q->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
+		if (!q->mqd_backup)
+			return -ENOMEM;
+		q->mqd_backup_size = mqd_size;
+	}
+	if (ctl_stack_size && !q->ctl_stack_backup) {
+		q->ctl_stack_backup = kzalloc(ctl_stack_size, GFP_KERNEL);
+		if (!q->ctl_stack_backup) {
+			kfree(q->mqd_backup);
+			q->mqd_backup = NULL;
+			q->mqd_backup_size = 0;
+			return -ENOMEM;
+		}
+		q->ctl_stack_backup_size = ctl_stack_size;
+	}
+
+	return 0;
+}
+
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct mqd_manager *mqd_mgr;
+
+	/* in_s4 is reliably set at evict/suspend time; skip normal runtime eviction
+	 * (pinned VRAM MQD stays intact then).
+	 */
+	if (!dqm->dev->adev->in_s4)
+		return;
+	if (!q->mqd_backup)
+		return;
+	if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
+		return;
+
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+	mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stack_backup);
+	q->mqd_backup_valid = true;
+}
+
+static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct mqd_manager *mqd_mgr;
+
+	if (!q->mqd_backup_valid || !q->mqd_backup)
+		return;
+	if (!q->mqd_mem_obj)
+		return;
+
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+	if (!mqd_mgr->restore_mqd)
+		return;
+
+	mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
+			     &q->properties, q->mqd_backup, q->ctl_stack_backup,
+			     q->ctl_stack_backup_size);
+	q->mqd_backup_valid = false;
+}
+
 static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				      struct qcm_process_device *qpd)
 {
@@ -1333,6 +1424,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				goto out;
 			}
 		}
+
+		dqm_save_mqd_backup(dqm, q);
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1406,6 +1499,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
+		dqm_restore_mqd_backup(dqm, q);
 		q->properties.is_active = true;
 		increment_queue_count(dqm, qpd, q);
 
@@ -1469,6 +1563,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (!QUEUE_IS_ACTIVE(q->properties))
 			continue;
 
+		dqm_restore_mqd_backup(dqm, q);
 		q->properties.is_active = true;
 		increment_queue_count(dqm, &pdd->qpd, q);
 
@@ -2144,6 +2239,10 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
 
+	retval = dqm_alloc_mqd_backup(dqm, q);
+	if (retval)
+		goto out_free_mqd;
+
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 
@@ -2176,6 +2275,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	list_del(&q->list);
 	if (q->properties.is_active)
 		decrement_queue_count(dqm, qpd, q);
+out_free_mqd:
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 	dqm_unlock(dqm);
 out_deallocate_doorbell:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c1657..1f728f13813e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -637,6 +637,15 @@ struct queue {
 	void *gang_ctx_cpu_ptr;
 
 	struct amdgpu_bo *wptr_bo_gart;
+
+	/* system-RAM shadow of a VRAM-resident MQD (+ control stack)
+	 * for hibernation snapshot/restore
+	 */
+	void *mqd_backup;
+	void *ctl_stack_backup;
+	uint32_t mqd_backup_size;
+	uint32_t ctl_stack_backup_size;
+	bool mqd_backup_valid;
 };
 
 enum KFD_MQD_TYPE {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 98a5512b701b..cbc90bf87792 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
+	kfree(q->mqd_backup);
+	kfree(q->ctl_stack_backup);
 	kfree(q);
 }
 
-- 
2.34.1

