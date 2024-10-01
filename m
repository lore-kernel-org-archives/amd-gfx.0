Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F964CF318A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 22:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3C910E331;
	Tue,  1 Oct 2024 22:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8vnB2G5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3076E10E331
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 22:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAuy9G4+9R4Bzq/uzzwHXBaDx7sxlVPzVJuOOMTnzRLVCmVtOR3z6PTKHmN2DRoVuY3kS6eCcgdzb8xAVpcTm/hmEvaqt3wZvNctE/ocdn+x3upS9O2UqSkh19CNRdDNvJSCmVEPfOlvWnfI0S3zwukvZlkvOPf2TW7MsvsrFaiNbI+29rLG8XpJh/5rIk72ESUFwW+tTAUtOn++irmwUHs/I+WoN+CnzBGauwvYvmbOA/DS7yO2XPhbXsxfCyDKejDyRDoRZQdxqtstYRwpM0xnJ+mGw5BhOxIzGaLL5jubzMWD1bMDC+AOYwfOxHlcjxAwC4sxZcQRhla9l2alvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HepSTq46rA3o8X52L2z4TQzznIVjrKmGo0WvH8/HOfA=;
 b=BCuKPm1NfJR5otE8KnlYC3svaKuB1p2qxoOHiUkzwCnlXY5YL5q2KGosLzIyVXDfCKJXX7Ld1az8lbgGg1N94IPhVEG8VG8B4Si+iTsIdFstxExMulpi0roZU5SQlz4vgkR25F1drTWMl1NpPjv5yBiRnW3MUU4xt8SYEYsxkPM9yN2V5bdKfQbwlB4rL/DUSErWeq2JrlO13ofzPgyYq7oGQsAhe4qw5lDPKVP8GqInE+fX1EADp4v0lwvfP6FTg5s/7+yjhlvjoamjgRu2HcvHWPAMw/707eHtVGyRcE+2flJA4IJZe0N6VtXy2KsvR9zg3mw8EZ8DDwdMgfILzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HepSTq46rA3o8X52L2z4TQzznIVjrKmGo0WvH8/HOfA=;
 b=g8vnB2G5psEntSrzZcD1b9WTJk+T5U5LgPGH5sfhGbY583ZNgpb78sqcWxkCQGPyZm7NXXRZa/w/WUjFC1Acfyl03IyTUFQP3IaVgbE2YO5FVuEsjhCsOZpSfLFqhM+QatBeyH92WZuiUdHxEgAWBGbPMz7Hpe8MoHFEkppEmSU=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 22:35:09 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::e1) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28 via Frontend
 Transport; Tue, 1 Oct 2024 22:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 22:35:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 17:35:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 17:35:08 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 17:35:02 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Date: Tue, 1 Oct 2024 17:38:36 -0500
Message-ID: <20241001223836.129671-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ba296f-1e75-43af-447f-08dce2694e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GxFUakagAihTQdOMUaeg/+b2e98VZ863lTDmMKShPGdm9Y6he6X7zRN6f9lj?=
 =?us-ascii?Q?UB05SF8Awih2aaoGpyyrGFclMRD6gcSyJ+uTKr9rmjH3T+Ba/XaDLTG4w4Z+?=
 =?us-ascii?Q?oZfvKH/ftMfZ4P14JZMUSzKY60f+Rd/Evx3vZhnJczaRdSrKWCKcRuOv9QJG?=
 =?us-ascii?Q?ZwflW5ikQiELhIv4ZPwQvglH9KFYc7qsmtmoIjNqV7xxSfTJlPmjjRIn+4rk?=
 =?us-ascii?Q?gtqfT0B1RKAKMkzwgqJy7GO/Hy3NfTsoO60nKFO4ELXuYWlz2MH9ltv60daY?=
 =?us-ascii?Q?ip0YVpTfX4326CL0VQ0wKMx1qbRRlvOHoUKFODzBmQnLc94sEwWy4K5N9KZo?=
 =?us-ascii?Q?MboJ8ls2C8UQoAtMJVWNFLlGr/ZnIivzsEkMFp7Uo4aY526yHzTzWl+OZ9SK?=
 =?us-ascii?Q?OYb9GRdfba36zPsfB9MsZfMz0saRdI+XyYz5iBmC6Nrl9d6kEQ6VfYrdnNHJ?=
 =?us-ascii?Q?KirYcQwpeLH7J1zPYDJg65gyxVxwkeL2uvAx3nmfJNVnYzAyMLHIiaKIldKJ?=
 =?us-ascii?Q?UlQkxscAoxSHY/UaIl0qNWZnHFcn2d3CQlpbmDGECXyIJ/MhPB4lJm52L77K?=
 =?us-ascii?Q?poauczKa+GCaKOP4VOp6F0hKteFg4AIj2V+V3CqrKwgEIVsd27jPEOeqGP0+?=
 =?us-ascii?Q?2B7laX2nPs2kJs5DQ2s7sC5RJE0xzce2qf6KTEATOnu8mRRabC6UmfDX3/Eu?=
 =?us-ascii?Q?3B0yPL0iuz6YLPa9ofirpFX4c0vce4JtF9lHhFjDTyUB5v/dLDl+N3KPVQf9?=
 =?us-ascii?Q?eQ37NF+GpUN/grny83UlRHWOITgprjwCS+QHQQ7rO3a33FafarJTJTICRYBR?=
 =?us-ascii?Q?cmfvga+CLICkEf5hu6dXfb48Tt+Q/ze5z5SeSYA8/IHW6wrbivubTSC5vx3R?=
 =?us-ascii?Q?ZHlCS0UQmKoCjqyAesHEhosD5aVJOnzatER8PERvDiunfyOPS4rF+cy70zJm?=
 =?us-ascii?Q?Fe5OLGcLCBXqVS8nnRpqWy2UHQJgnNDOyQS0W+UCR/kGYLBgLnwC2uALwsX1?=
 =?us-ascii?Q?5cVBaIhp+3u7aguswnlSxrVyFGRgQWezznlC/FZ/PMD1GFGdITTGXdxYlAGp?=
 =?us-ascii?Q?gj/DH13dj7tCU1MHu/ZpwUduPMmj8zux+YkOr+DWi8BDunY6PyvndOOOhZj4?=
 =?us-ascii?Q?/RBHUaENIkXZlh15wUAW2NMvUDw6ZXPyCxNTz1juZ13cFtxDBrcCbC01Zc07?=
 =?us-ascii?Q?LSqlIqkQDSiNaek9mNl9qzvOObZzjhdxKGkCJVahj/ytVwZfHOnp6CL+6F+1?=
 =?us-ascii?Q?bAebxHJL17e83JPObaG7l/eJ06GIT6p0k4oCRB0Ud0hh2x8wawd7Sbusr3bO?=
 =?us-ascii?Q?gyrvAV2IRrASabk6f6DO7Tdm7zD/ouCCB9Y+NfStPwwuTGEmQ5/5+uYYYjjR?=
 =?us-ascii?Q?RpgejBI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 22:35:09.2802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ba296f-1e75-43af-447f-08dce2694e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch allows kfd driver function correctly when AMD gpu devices got
plug/unplug at run time.

When an AMD gpu device got unplug kfd driver gracefully terminates existing kfd
processes after stops all queues, sends SIGTERM to user process. After that user
space can use remaining AMD gpu devices as usual. When all AMD gpu devices got
removed kfd driver will not response new requests.

Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
to function as usual.

The purpose of this patch is having kfd driver behavior as expected during
AMD gpu device plug/unplug.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 77 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 30 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 29 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 +++++++
 8 files changed, 175 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b545940e512b..f91a581dbbbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
 }
 
+void amdgpu_amdkfd_teardown_processes(void)
+{
+       kgd2kfd_teardown_processes();
+}
+
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 {
 	if (adev->kfd.dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 7e0a22072536..93f54c930017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -152,6 +152,7 @@ struct amdkfd_process_info {
 
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
+void amdgpu_amdkfd_teardown_processes(void);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
@@ -431,6 +432,8 @@ int kgd2kfd_check_and_lock_kfd(void);
 void kgd2kfd_unlock_kfd(void);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
+void kgd2kfd_lock_kfd(void);
+void kgd2kfd_teardown_processes(void);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -511,5 +514,14 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return 0;
 }
+
+void kgd2kfd_lock_kfd(void)
+{
+}
+
+void kgd2kfd_teardown_processes(void)
+{
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e47655e02c6..2c34813583b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3315,7 +3315,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	amdgpu_amdkfd_suspend(adev, false);
+	amdgpu_amdkfd_teardown_processes();
 
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fad1c8f2bc83..149ab49ea307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -930,6 +930,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	}
 
 	kfree(kfd);
+
+	/* after remove a kfd device unlock kfd driver */
+	kgd2kfd_unlock_kfd();
 }
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
@@ -1439,6 +1442,14 @@ int kgd2kfd_check_and_lock_kfd(void)
 	return 0;
 }
 
+/* unconditionally lock kfd, pair with kgd2kfd_unlock_kfd */
+void kgd2kfd_lock_kfd(void)
+{
+       mutex_lock(&kfd_processes_mutex);
+       ++kfd_locked;
+       mutex_unlock(&kfd_processes_mutex);
+}
+
 void kgd2kfd_unlock_kfd(void)
 {
 	mutex_lock(&kfd_processes_mutex);
@@ -1485,6 +1496,72 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return node->dqm->ops.halt(node->dqm);
 }
 
+/* check if there is any kfd process in system */
+static bool kgd2kfd_check_idle(void)
+{
+	lockdep_assert_held(&kfd_processes_mutex);
+
+	/* kfd_processes_table is not empty */
+	if (!hash_empty(kfd_processes_table))
+		return false;
+
+	/* kfd_processes_table is empty
+	 * check if all processes are terminated
+	 */
+	return !kfd_has_kfd_process();
+}
+
+/* gracefully tear down all existing kfd processes */
+void kgd2kfd_teardown_processes(void)
+{
+	struct kfd_process *p;
+	struct kfd_node *dev;
+	unsigned int temp;
+	uint8_t idx = 0;
+
+	/* unconditionally lock kfd driver to not allow create new kfd process
+	 * will unlock kfd driver at kgd2kfd_device_exit
+	 */
+	kgd2kfd_lock_kfd();
+
+	mutex_lock(&kfd_processes_mutex);
+
+	/* if there is no kfd process just return */
+	if (kgd2kfd_check_idle()){
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
+
+	/* stop all queues from all kfd nodes */
+	while (kfd_topology_enum_kfd_devices(idx, &dev) == 0) {
+		if (dev && !kfd_devcgroup_check_permission(dev))
+			dev->dqm->ops.stop(dev->dqm);
+
+		idx++;
+	}
+
+	/* signal user space processes their kfd processes terminated */
+	idx = srcu_read_lock(&kfd_processes_srcu);
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
+			kfd_signal_process_terminate_event(p);
+
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	mutex_unlock(&kfd_processes_mutex);
+
+	kfd_cleanup_processes();
+
+	mutex_lock(&kfd_processes_mutex);
+
+	/* wait all kfd processes terminated */
+	while (!kgd2kfd_check_idle())
+		cond_resched();
+
+	mutex_unlock(&kfd_processes_mutex);
+
+	return;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ea3792249209..911080bac6d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1355,3 +1355,33 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 
 	kfd_unref_process(p);
 }
+
+/* signal KFD_EVENT_TYPE_SIGNAL events from process p
+ * send signal SIGTERM to correspondent user space process
+ */
+void kfd_signal_process_terminate_event(struct kfd_process *p)
+{
+	struct kfd_event *ev;
+	uint32_t id;
+
+	rcu_read_lock();
+
+	/* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
+	id = 1;
+	idr_for_each_entry_continue(&p->event_idr, ev, id)
+	if (ev->type == KFD_EVENT_TYPE_SIGNAL) {
+		spin_lock(&ev->lock);
+		set_event(ev);
+		spin_unlock(&ev->lock);
+	}
+
+	/* Send SIGTERM to p->lead_thread */
+	dev_warn(kfd_device,
+			"Sending SIGTERM to process %d (pasid 0x%x)",
+			p->lead_thread->pid, p->pasid);
+
+	send_sig(SIGTERM, p->lead_thread, 0);
+
+	rcu_read_unlock();
+}
+
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6a5bf88cc232..141ff6511fe3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1036,6 +1036,7 @@ struct kfd_process *kfd_create_process(struct task_struct *thread);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+bool kfd_has_kfd_process(void);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
@@ -1161,6 +1162,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
+uint32_t kfd_gpu_node_num(void);
 
 /* Interrupts */
 #define	KFD_IRQ_FENCE_CLIENTID	0xff
@@ -1493,6 +1495,7 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
 void kfd_signal_reset_event(struct kfd_node *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
+void kfd_signal_process_terminate_event(struct kfd_process *p);
 
 static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
 				 enum TLB_FLUSH_TYPE type)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..aac46edcaa67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -844,8 +844,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	 */
 	mutex_lock(&kfd_processes_mutex);
 
+	if (kfd_gpu_node_num() <= 0) {
+		pr_warn("no KFD gpu node! Cannot create process");
+		process = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
 	if (kfd_is_locked()) {
-		pr_debug("KFD is locked! Cannot create process");
+		pr_warn("KFD is locked! Cannot create process");
 		process = ERR_PTR(-EINVAL);
 		goto out;
 	}
@@ -1155,16 +1161,18 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	synchronize_rcu();
 	ef = rcu_access_pointer(p->ef);
-	dma_fence_signal(ef);
 
-	kfd_process_remove_sysfs(p);
+	if (ef) {
+		dma_fence_signal(ef);
+		dma_fence_put(ef);
+		p->ef = NULL;
+	}
 
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
 
 	kfd_process_destroy_pdds(p);
-	dma_fence_put(ef);
 
 	kfd_event_free_process(p);
 
@@ -1173,9 +1181,22 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 	put_task_struct(p->lead_thread);
 
+	/* the last step is removing process entries under /sys
+	 * to indicate the process has been terminated.
+	 */
+	kfd_process_remove_sysfs(p);
+
 	kfree(p);
 }
 
+/* check there is entry under procfs.kobj */
+bool kfd_has_kfd_process(void)
+{
+	WARN_ON_ONCE(kref_read(&procfs.kobj->kref) == 0);
+
+	return procfs.kobj->sd && procfs.kobj->sd->dir.subdirs;
+}
+
 static void kfd_process_ref_release(struct kref *ref)
 {
 	struct kfd_process *p = container_of(ref, struct kfd_process, ref);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3871591c9aec..7809ed0dbc95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2336,6 +2336,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
 	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }
 
+/* kfd_gpu_node_num - Return kfd gpu node number at system */
+uint32_t kfd_gpu_node_num(void)
+{
+	struct kfd_node *dev;
+	uint8_t gpu_num  = 0;
+	uint8_t id  = 0;
+
+	while (kfd_topology_enum_kfd_devices(id, &dev) == 0) {
+		if (!dev || kfd_devcgroup_check_permission(dev)) {
+			/* Skip non GPU devices and devices to which the
+			 * current process have no access to
+			 */
+			id++;
+			continue;
+		}
+		id++;
+		gpu_num++;
+	}
+
+	return gpu_num;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
-- 
2.25.1

