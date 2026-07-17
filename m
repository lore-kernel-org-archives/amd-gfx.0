Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F1C44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 08:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E5610E436;
	Fri, 17 Jul 2026 08:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9kKFrYo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EACC10E436
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 08:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTyOcHmEeR9XjaeJfExCZfVF9vjxXh1niI13JgHMrDI42C/4oTszMxmCyS1mWduIi/OBHyU9B9LbzBgjVpECw8vc1FK4+2Af0DDX1/DSNwraB/ZvqSwb7ylR343bpXVvzKd9x4M3Nhg0nWrYDzF1lQm7DPQygCLxLiqDlxXdohjsCun1LHMhjbWy8rjWXsZ2xJgY3MrcuHg/Wmlkbl4sPHLpcNfErGYYm6QmQsH6abi0/Yw0Bd59650HEg06j83FNHqYkOa4eXHrdmrdgHda4ugVZrxGqyOUTTC8TKxk6R25fJYoRJdI61jEGQaK6byrK6lu8l/KAXgkSCs0SSpuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfgWBHMYX53Ky6NZO7/W93U7x/wXFu7F830RQofXJEs=;
 b=xZHKdkCXoAzkP0vJBCaJo5EqeKzRtyWJ9AF5zHONMCK1JyePXhAXV8265G0WPON/nGxTTi/HzuVrlJVW3Qnq6DIVN+eUYBiWWYV4jIk9zpIPZpgFypdqdxT9+cub6pdcI1ZF7Qcv40cFqKttwqM1Iw2z2/doKFo7cLYKXBsn8ylUTHFUyhlhmlavpCXAGssEhp97ENQWhayMqfvHfoWl5ffG4XYqdLkwInEUdYpGwsMgV/82oAbTctRUEvLUeuyxBGT7ox6SOPbgJYf9i5P7100tF7I5nCXxrIcxZKkiQSB5roKrBX9AvqMHq1iF6gYXppMzEd180DSClmsCf6Av7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfgWBHMYX53Ky6NZO7/W93U7x/wXFu7F830RQofXJEs=;
 b=Z9kKFrYobbb8jkWgr/P1ltHhmB+iDsgT4MKViv2tDj90kSLxR/xp7mNuNpwfe1HScZP6oaoUMIPZ+WqIgkpo9neFOWgujjg9FqC0ensGI0cBOK9Ah+MFmmH3gBucypjtUJSxoNBe+MxrURj888NMNO1qt4EPLR0j2NICOUvHE0M=
Received: from BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::15)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:54:37 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::42) by BL1P221CA0004.outlook.office365.com
 (2603:10b6:208:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Fri,
 17 Jul 2026 08:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 08:54:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 03:54:31 -0500
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 03:54:29 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <felix.kuehling@amd.com>, Shikang Fan
 <shikang.fan@amd.com>
Subject: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when MQD
 is in VRAM
Date: Fri, 17 Jul 2026 16:53:57 +0800
Message-ID: <20260717085357.41610-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715103056.3529178-1-shikang.fan@amd.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 532edb66-de83-44d1-0b8d-08dee3e1078c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Mh0EJIoBe9pjWXM/UciSMisE3Ci+5NpplCmBVvRbu6kFt7MCYUzblKIuuBqGFA9LtDyTgTkVnUctIMwcXhDWrlHTKHWo6Jua2ciQXLr25mz9of4NeFAdMlb6IA0NqUCGmPDmJfeCoZQlqLknbgCI//xHm8HV+2sYX4dJVu6fGgyL96bioJ+d9tFbgUny0SMs8zQV4Ga+Hx6pRzDBqWMu2TcjEdUb+LDg2hNRW/RzwR/bc9j0f7Yl1GiBSIc4Od879voZpOJ65Pp3bFQgCu4XlWvzwBvG+TFbHs8Bg8qkgDg5sAzKeoT+3EEg3xFLz5vgmSV3GZ2AAWEuBlUadsnrIb6rDS8wlg26hBgKwyRYXffb9DitbBsn5DeLCxtpPLbYc2ToPbamDOEolXk47RiDaQU2XXr0rM2LbsI/gPT3HyxLUPwHZ3eZNSKHd6PAQyITN11pe/t1dfsrLzzCp8KgF02ZyxX+SjORpAs5G/TNAQTgPDNnLVK3KzDyhZGJLoCCz6WUOZi40rBI2Qgm1e2LD9Ru3YPjUQ/4iMUnoWLFhsptFDFc/Hpms8Im53xx6c3QNr4a8TWs/JvvuocOp6soZFtR9ZkKemteIH3bYwGDgA0+ClO8dU1srRVyxAdTIX55b5bBKkvcGhR6FS7dIXwtnhdo0dINRhDBABVYi2M+kNwGd+/832IEjBuLUNLJmXHMkigd6CU4s7WR4DdTIv0DnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C0JUq52jYNEj3C0sY7Cg51fmDc1GTot/D8DIVlUEAySq5AIxZvuT1nbz3dW/B0QZIjX5gBKaNQU3E85wg858Ri9anR6uj+LEU4YyG2qMABNP9H+Uw8KWZhrJ6bS+WLsmUgF65bIHNRU6BBgOEeHGxlsefHLLSyACFTmzTxiuUkUlvOHXDwP5aKdjSObymLQuQu5ydYTLEtcgzSpZj2Mg3evE+LyU6cnf1VQ0orECpiU/qsiNIwaPCZMG2u2VrbeMkgCCc8Kx0BpDIfkYtFpXq8jxNNx8nbddHhP9bBwGQHSrUNciMouWSfsLy9m9/lynm/Tn8e1BFE2OedLx826qDEPMFoPi3/pR43w8D81tPnnWRw7FXebWlZpLQ5DJ2nzn7wstdMM7u9jA7Oxp5CElen3ehhLFizGJgqt6a8ow10KiOKZSMAgqvEIoIzMWrDkL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 08:54:36.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532edb66-de83-44d1-0b8d-08dee3e1078c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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

v2:
 - Also snapshot the MQD when a process is already runtime-evicted at
   hibernation start. The qpd->evicted refcount early-return previously
   skipped the save loop, losing the MQD across the VRAM wipe (both the
   cpsch and nocpsch evict paths).

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..d168686ee324 100644
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
@@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
 
+	retval = dqm_alloc_mqd_backup(dqm, q);
+	if (retval)
+		goto out_free_mqd;
+
 	if (q->properties.is_active) {
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
@@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 	int retval, ret = 0;
 
 	dqm_lock(dqm);
-	if (qpd->evicted++ > 0) /* already evicted, do nothing */
+	if (qpd->evicted++ > 0) { /* already evicted, do nothing */
+		/* A process already runtime-evicted when hibernation starts
+		 * skips the save loop below, so snapshot its VRAM MQDs here
+		 * before the S4 image is taken. dqm_save_mqd_backup() is a
+		 * no-op outside S4.
+		 */
+		list_for_each_entry(q, &qpd->queues_list, list)
+			dqm_save_mqd_backup(dqm, q);
 		goto out;
+	}
 
 	pdd = qpd_to_pdd(qpd);
 	pr_debug_ratelimited("Evicting process pid %d queues\n",
@@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			 * maintain a consistent eviction state
 			 */
 			ret = retval;
+
+		dqm_save_mqd_backup(dqm, q);
 	}
 
 out:
@@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
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
@@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	int retval = 0;
 
 	dqm_lock(dqm);
-	if (qpd->evicted++ > 0) /* already evicted, do nothing */
+	if (qpd->evicted++ > 0) { /* already evicted, do nothing */
+		/* A process already runtime-evicted when hibernation starts
+		 * skips the save loop below, so snapshot its VRAM MQDs here
+		 * before the S4 image is taken. dqm_save_mqd_backup() is a
+		 * no-op outside S4.
+		 */
+		list_for_each_entry(q, &qpd->queues_list, list)
+			dqm_save_mqd_backup(dqm, q);
 		goto out;
+	}
 
 	pdd = qpd_to_pdd(qpd);
 
@@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				goto out;
 			}
 		}
+
+		dqm_save_mqd_backup(dqm, q);
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
+		dqm_restore_mqd_backup(dqm, q);
 		q->properties.is_active = true;
 		increment_queue_count(dqm, qpd, q);
 
@@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (!QUEUE_IS_ACTIVE(q->properties))
 			continue;
 
+		dqm_restore_mqd_backup(dqm, q);
 		q->properties.is_active = true;
 		increment_queue_count(dqm, &pdd->qpd, q);
 
@@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
 
+	retval = dqm_alloc_mqd_backup(dqm, q);
+	if (retval)
+		goto out_free_mqd;
+
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 
@@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
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

