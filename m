Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59689CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 14:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D651E10E896;
	Thu,  8 Oct 2026 14:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C8nYyDH8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6865D10E8A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 14:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIvUVgwG3zldLVJFYSc57yBuCRe3Q4d1fhuuHpjjjrRpDDRP96JySEFGs5EipVtHBzfJNR3LL39Cl4FP7++xxqg/++uVCEcWYFDxVI0kBenfs7cya4qjgvcMG5bEI8xWW/oIS5W20CF+pN4KNUP/RSYPzt7LH9SpOBorJE2lxcFC5CNbqKbDcI2I8MhbNRwp+out8rvsuLSTXkUB+OppzITJpzUzZHJfcnpvDHeJLi2r8RhSml1TVBbjVEpI6OzVZUz1K/B75HmQEGJ8IoxPh1pxfqNIdMGsf+9LTrMmYprxiADnIGSIv1oFrrZgquLXyqxP7iiUkUnX0edLPBvKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1+TH9g3079HgO/yXz4uad86SAdGx1btv228LQW6QUI=;
 b=EMtnY088UUpb0Kiuw7Ut6D+PAqeaKZ1+lxXF8RTOQL5FcOAttsUgxlZuAkcK+bdvdUryWgbG2CsOO5LxBinJH9hpYNYL6gw8pooG8GrFbGr/dyLWosb2XLSS/atMor8CdTd7aXxQqTvw3t967lihw19sRnhb8j8N4Xxec/3qWI5kI0bQz9wm+Dqk3j+D45oK3CIXqq+gMZqaS6FyZ5n6q9DqqF//5B5E1pB/KLVubejnzsqdR6CLiWR76SGRqXdzGwctvVDMWectzhcUhBkU8u8ojAGt680OT9DOL41+oOFztXwIatLet9Tmt4stM9U5GpadqjU5e90hYV9F4k/oDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1+TH9g3079HgO/yXz4uad86SAdGx1btv228LQW6QUI=;
 b=C8nYyDH8JZ6+qEBgtrebH+4VelqSXPq/RVAV8Z/TCNk4+GwY1ZMYMtb4vTwlVgw+G5P+euPv4B1Je6YMYXgquG67a66KbSm/LinI+A1ladqrwn7PLH8pnAp2KAYICz5zfg5Bq/+3nZtvhPCImGOBeCvJhW1ylsjIcuhzB6/5YT8=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 14:01:05 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::7b) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 14:01:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 14:01:04 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 09:00:56 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Felix.Kuehling@amd.com>,
 <kent.russell@amd.com>, <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
Date: Thu, 8 Oct 2026 10:00:45 -0400
Message-ID: <20261008140045.1283288-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 57470a5b-1bc0-4510-3396-08df25449798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2P0s4aH88OSyoVIrB04Y3Pe/XIVi8pYm0gXn2NHhBHR8vccxXE+A8/9JYpdnjxYvADhlixvXoxbxXXUxPIT64ulOX/pQwYkoBq8qwyrAgyNU2EqTH7PIIjnsZ+LgocXIfWkasvWrDZcRlCAfwykayjsAZJe3rpjoc6QM6NCEHNG2fJymlG2oBfElbqIDqlxqWCgQn0Ytubt8Z+4bmM9ik2zJTuYy6EnAviudR2cGQCBMhMKfFIxyqqIZbvAh/BIOxUfiY3zM0+5JRaxS9GEgH9c2OYu7ekEoox+lAASjOZTJvrSabflEBlmJoQHfSqrxBcM8QXlt6GgVKlGqL5pL/enEu5LFpOiyrhk0rSIITYmUFSUv36RnLzsCzJBrbI6cvniOxWgKQUcGwdM9Ls5iTaVXLjZ3AtWeKxIssipEJgjVEppt91mWGtsK3hj4OQJqe6PGBmC9URMkAPKbBzrQP9PbbX2BBAbNh9D7biDUIah+0naBB0A+vM1GteYmx6Xj5fJbf6FjD45v4KsQfbCjEI55bNlEYvM2NlYgFLyAMcLeFqfHR+Ba5Lcg841SDR5jfXz0WQTj6VPxmZ2suVgzQQwvrW3XUtUcBgVd2LkXrzbuLSKL4++Bk5UBoSRk4Lk48QHMJhsddUQtD+MzhsuBFo0iXqs1/EK5QKHFdTUv24xQnXXJR5k2E5lhylSXCAUWLKwdPggzAeOlx/4ElGVgEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VFWqATWU32Ta5LeDloww2CWIpNGIfIIny4Wu1ZVmyi6JnX8QEI8QSlWN2EOAHDpdx3jAk1I7zGRdk5ujYgyvKxlohRorgYKRim2ExRBMibBl6hkpJuIB5tiIY22SSyD1ufXtOxKgit/NfmR6UER+lLKmhFf5pllOKif3eWuHqk5Uu4ZV7emk2X1b4ghxDiBoVfJLPvUZ48bZUIhe8HArgsF/9g7Qn6er4zHPETyB6YSbhEyUfI1qKKHfGW3oEBN5Kzzf7eL8flik1ZE9L5SLROzFQzeiQ5oRd/awMHAPsVzEkpLGYxru9khBJcaw4RRitZSC4fkgLtGy9ztQ+a3HV3R3ILa8VX2GVoWK++Dm3zreixKH2W3fIxRhHPLaRachKyJr9PMQszhow5inuZiSe2bB1RA1c05T0OJCb5OcOztqEw9Z4rr2XgGdV9HIXoy3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:01:04.0426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57470a5b-1bc0-4510-3396-08df25449798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

A GPU reset issued while processes are using the device can Oops the
host in munmap() (free_swap_cache) after SDMA write faults from a user
queue whose process has already exited.

amdgpu_device_gpu_recover() takes reset_domain->sem for write before
amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and no
unmap is sent. stop_cpsch() still clears sched_running, so user queues
keep running while their memory is freed.

Call amdgpu_amdkfd_pre_reset() before the lock, for gpu_recover and PCI
error handling. Skip the dequeue when the HWS is hung or the PCI link is
down, so recovery does not wait out the preemption timeout.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---

Notes:
    v2:
    - Drop the SRC_USER gate and the helper; run for every reset source
    - Cover amdgpu_pci_error_detected() as well as gpu_recover()
    - Skip the dequeue when the HWS is hung or the PCI link is down

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 16 ++++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 14 ++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..8ae6228dbf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5479,6 +5479,16 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 	}
 }
 
+/* Dequeueing needs reset_domain->sem for read, so run before it is write-locked */
+static void amdgpu_device_kfd_pre_reset(struct amdgpu_reset_context *reset_context,
+					struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list)
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
+}
+
 static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
 						  struct list_head *device_list)
 {
@@ -5534,8 +5544,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
-
 		/*
 		 * Mark these ASICs to be reset as untracked first
 		 * And add them back after reset completed
@@ -5784,6 +5792,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Cannot be called after locking reset domain */
 	amdgpu_ras_pre_reset(adev, &device_list);
 
+	/* Cannot be called after locking reset domain either */
+	amdgpu_device_kfd_pre_reset(reset_context, &device_list);
+
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
@@ -6232,6 +6243,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		INIT_LIST_HEAD(&device_list);
 
 		amdgpu_device_recovery_prepare(adev, &device_list, hive);
+		amdgpu_device_kfd_pre_reset(&reset_context, &device_list);
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
 					      hive, false);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5e57576fba21..988fce11a4fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -81,6 +81,16 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 			       struct qcm_process_device *qpd, bool verbose);
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
 
+/*
+ * A dead HWS or an offline PCI link cannot service a dequeue request. Skip it
+ * rather than wait out queue_preemption_timeout_ms per node.
+ */
+static inline bool kfd_dqm_can_reach_hw(struct device_queue_manager *dqm)
+{
+	return !dqm->is_hws_hang &&
+	       dqm->dev->adev->pci_channel_state == pci_channel_io_normal;
+}
+
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
 {
@@ -314,6 +324,8 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 
 	if (!dqm->sched_running || dqm->sched_halt)
 		return 0;
+	if (!kfd_dqm_can_reach_hw(dqm))
+		return 0;
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
@@ -2832,6 +2844,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 
 	if (!dqm->sched_running)
 		return 0;
+	if (!kfd_dqm_can_reach_hw(dqm))
+		return 0;
 	if (!dqm->active_runlist)
 		return 0;
 	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
-- 
2.43.0

