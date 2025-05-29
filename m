Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B18C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 19:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B70810E03F;
	Thu, 29 May 2025 19:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWbrfl2a";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC8D10E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 19:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCEi+1fHW1hKvckLiCkhSnZeDrlnoohLOtkXIJEqQIuWQSWGW4LLHycoWyZ6JS94BKa/VZvoBrKdyn32AkwTmFYqoIPS8WtkrQBW8u2YcEB2T9H6v2Toi7Cf7/bagv94vmh5S1d7bmH/7Twx1kHCHELEiDEEFypybNbKmxp04xvZbTifuZpzFRgvmr484hyD9cGharJsxNz417d3+/lMrEsQvJPM3WeJoup9F00LkP/yxWF/MUsUCC6mOKW8Sa44CUxRfrw6zCfEMBFo27w02xrALY2mb7zegHtIl9FviyHYLIEUzuAjCmzHjki+WmOWCYVVk/Nd+LuDP/v4pYppsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJQ6xCveETpLU9LnJO1lxpEY1AgG1iKqF0Dv+UH3iF8=;
 b=hlQKn9KeqPeGBE/9t080g9PzMHUJHb5yz0T/U5f/bzQFm476CoyE2v/5HfmnevaEIS1vpwZU0Lp+L6epu5uFqOJaPQIRo6K0+7ZP07HVmqwJswtAvI9mDHUGlRL+Z3mQ0pVNdCJHdigtQ7QtgSIw80++4g9q3s9AhSeq1xgC5XmxGCa6asXeHojsivabAd04sjzyfu/DWj/PFXwC6MZH3XTkm/wmv87/u11h6hSkdHnOct2O8JL08VrervCCpdg05as9D1pqh8nFUKbus8t76LsUOhy8Q/z5LOOKTZ7bd0bY0LJYJOXGtwdsC6yw0NbA2A7JoqFKXQLx8ohnUottGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJQ6xCveETpLU9LnJO1lxpEY1AgG1iKqF0Dv+UH3iF8=;
 b=pWbrfl2avJ++vkh9fXjXB4ObyyZDCOi7iplK4d7KzeMEQ8G1FmsHSZzcwYGFEuEgE55KTmfRd5nRyHzRv1vrk74FUGyOq9ra861u91buzqG231if2JNXsyrvjYDROzmvlj6+WhSYVS/+drwkWOOh2OGS4kpFkpffwd+ZKgJBS8Q=
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 19:09:53 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::d8) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 19:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 19:09:52 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 14:09:52 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: allow compute partition mode switch with cgroup
 exclusions
Date: Thu, 29 May 2025 15:09:45 -0400
Message-ID: <20250529190945.4052-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 31caf7cb-adcd-4c90-387d-08dd9ee46433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DrDhNuXGkFahggeKTrunJU/Mny3jbc8occTF0VetVa5KgVkgpI9y0j01IHQh?=
 =?us-ascii?Q?iYmUTLS2QhkyBJ8HfVJxXGOE6rGK0XKYFAG3OEWBO6eXCgELizq9bMaEQIVu?=
 =?us-ascii?Q?73pczw93UOHe16zlw5eQof/i34dOPkCgVDFU2QdjqCAY/T9RDjLPJIBXJJ80?=
 =?us-ascii?Q?M0J6/WItpaBZ5cvpkPGnpcpswUNi+Tap5bYWMF5cXWmCmOZvaa+8Pq5ehOCO?=
 =?us-ascii?Q?iPpkKLE9QhXNJ9GBsQgsmTQFciddyi9OIHY+oGVoOWh7B9eO73wUUAgm5pO0?=
 =?us-ascii?Q?Xmi1+dzvNmtpmKtEXVLZcHR+DNNExQgKJW2qDvI6IgHFz88h+i0iqT5aZ88P?=
 =?us-ascii?Q?6SFEKFMQg4Pcgs9z+Rgz6fTFb9jRNd1giFMYzI4/7h/uUR6KLlvlAy3G1Rsi?=
 =?us-ascii?Q?8ImWMBFCygkG/y6UkiJo7/xld/z78iSmTrmoQBsw7h6RMD5nzIFhYWjWCLwr?=
 =?us-ascii?Q?C6M1dm6uCxwlpNjAi/5449cyB0T6krDxPBIkPPw+lGqCbfzijKMj2vtzJ4Qm?=
 =?us-ascii?Q?Hca4Ze653zg11FV4KFX9SA2/XfIQuBXocVh8DC6wyxJuy4Lf3G8Nz6YUs9Xi?=
 =?us-ascii?Q?M5qYSfG0/v/x37DPxhkEDnXROOwAijRWOr+qxq+TXCJnQJCT3sH07QJ7t4P3?=
 =?us-ascii?Q?xa/6tA7MwAtEbsZjzm0cJAKmv6UTjMBWVFSxJyuHD8StsW+UXGaizkwhul1e?=
 =?us-ascii?Q?501u1IBlsY3+BeYBd/hJkRzBlXX+hSTl5ciYqX+8yrkPLW7yDr5aIc91JA6m?=
 =?us-ascii?Q?R68+7cFCr8cvrbQ6LpQOnwQlJMW9Gcl7dRNYRTlQ2fwb0F5k3WJwGF3US8MM?=
 =?us-ascii?Q?QSqP8ogE5wxKiuGOMMTvLixPJ4npaiwGAfIBX3v97roGliMY3kQqhH8hmczS?=
 =?us-ascii?Q?XMOk3P5VTzi1tHAxkTaXSsb9Rx1qeKTANcpBokxXXKJacH2gpoEqEaR54uH7?=
 =?us-ascii?Q?grePBTI5od3v4IkXw8TNIa741X7s1tcRvutfRWlirZ2G4gIHs/WVQhduJZ8R?=
 =?us-ascii?Q?uUPDjrlhoML87/68VfDXH7NHoCAdKvuZSYAL+jtVhjKLGk4qddRhm6tS2LPU?=
 =?us-ascii?Q?M8yGzN7uVcC34GL0TD2NVXqGFHHEOKTZNcTgymjZjWBo83W35HXwVAIXu0X7?=
 =?us-ascii?Q?Smw3KEstSmO9DeYOeGBCLq4+gQvDw9HS0QvC7s/0iLBDbphQoH82ARiW+M+s?=
 =?us-ascii?Q?+7+XFSJKzxMNeJFYX1p1zZM5zEYWAMJARlgnVOVJczOWxW2fcn7plWZegyAg?=
 =?us-ascii?Q?nXdSlEnqPundobS/ZJ83WxQPAPb0nwCP+JW0YH4e2ETK1lMmogq8TEy8Pcqf?=
 =?us-ascii?Q?OMyG1vnpnPWhan8sIMvtAsNY/ZDiz1IJbGDvYogq5O5ERq4bBOQbQKanDvzH?=
 =?us-ascii?Q?Q1OpHbptmYwKdYOVEFfZxvPOPhD7pebEv5EaFjI9JMZfCWPx82aJdHxhGuij?=
 =?us-ascii?Q?OdEvd7YqDqmzBTSbZPFCoRQHyQSt3TwwsydRjokgHSuI/b9Ckz7V4Awmkmf2?=
 =?us-ascii?Q?WoLIw+hoIHaAW+ADrsKWoUIZ+lHmVpXoOGeh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 19:09:52.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31caf7cb-adcd-4c90-387d-08dd9ee46433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
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

The KFD currently bars a compute partition mode switch while a KFD
process exists.

Since cgroup excluded devices remain excluded for the lifetime of a KFD
process and user space is able to mode switch single devices, allow
users to mode switch a device with any running process that has been
cgroup excluded from this device.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 69 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  2 +-
 5 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..7cfe4677bf56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -746,12 +746,12 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
 {
-	return kgd2kfd_check_and_lock_kfd();
+	return kgd2kfd_check_and_lock_kfd(adev->kfd.dev);
 }
 
 void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 {
-	kgd2kfd_unlock_kfd();
+	kgd2kfd_unlock_kfd(adev->kfd.dev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..3d5812269ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -419,8 +419,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
-int kgd2kfd_check_and_lock_kfd(void);
-void kgd2kfd_unlock_kfd(void);
+int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd);
+void kgd2kfd_unlock_kfd(struct kfd_dev *kfd);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
@@ -489,12 +489,12 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 }
 
-static inline int kgd2kfd_check_and_lock_kfd(void)
+static inline int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 {
 	return 0;
 }
 
-static inline void kgd2kfd_unlock_kfd(void)
+static inline void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bf0854bd5555..a12e1433943d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1013,10 +1013,30 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	return 0;
 }
 
-bool kfd_is_locked(void)
+bool kfd_is_locked(struct kfd_dev *kfd)
 {
+	uint8_t id  = 0;
+	struct kfd_node *dev;
+
 	lockdep_assert_held(&kfd_processes_mutex);
-	return  (kfd_locked > 0);
+
+	/* check reset/suspend lock */
+	if (kfd_locked > 0)
+		return true;
+
+	if (kfd)
+		return kfd->kfd_dev_lock > 0;
+
+	/* check lock on all cgroup accessible devices */
+	while (kfd_topology_enum_kfd_devices(id++, &dev) == 0) {
+		if (!dev || kfd_devcgroup_check_permission(dev))
+			continue;
+
+		if (dev->kfd->kfd_dev_lock > 0)
+			return true;
+	}
+
+	return false;
 }
 
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
@@ -1442,24 +1462,53 @@ unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *node)
 		kfd_get_num_sdma_engines(node);
 }
 
-int kgd2kfd_check_and_lock_kfd(void)
+int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 {
+	struct kfd_process *p;
+	int r = 0, temp, idx;
+
 	mutex_lock(&kfd_processes_mutex);
-	if (!hash_empty(kfd_processes_table) || kfd_is_locked()) {
-		mutex_unlock(&kfd_processes_mutex);
-		return -EBUSY;
+
+	if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
+		goto out;
+
+	/* fail under system reset/resume or kfd device is partition switching. */
+	if (kfd_is_locked(kfd)) {
+		r = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * ensure all running processes are cgroup excluded from device before mode switch.
+	 * i.e. no pdd was created on the process socket.
+	 */
+	idx = srcu_read_lock(&kfd_processes_srcu);
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		int i;
+
+		for (i = 0; i < p->n_pdds; i++) {
+			if (p->pdds[i]->dev->kfd != kfd)
+				continue;
+
+			r = -EBUSY;
+			goto proc_check_unlock;
+		}
 	}
 
-	++kfd_locked;
+proc_check_unlock:
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+out:
+	if (!r)
+		++kfd->kfd_dev_lock;
 	mutex_unlock(&kfd_processes_mutex);
 
-	return 0;
+	return r;
 }
 
-void kgd2kfd_unlock_kfd(void)
+void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
 {
 	mutex_lock(&kfd_processes_mutex);
-	--kfd_locked;
+	--kfd->kfd_dev_lock;
 	mutex_unlock(&kfd_processes_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d221c58dccc3..67694bcd9464 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -372,6 +372,9 @@ struct kfd_dev {
 
 	/* bitmap for dynamic doorbell allocation from doorbell object */
 	unsigned long *doorbell_bitmap;
+
+	/* for dynamic partitioning */
+	int kfd_dev_lock;
 };
 
 enum kfd_mempool {
@@ -1536,7 +1539,7 @@ static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 int kfd_send_exception_to_runtime(struct kfd_process *p,
 				unsigned int queue_id,
 				uint64_t error_reason);
-bool kfd_is_locked(void);
+bool kfd_is_locked(struct kfd_dev *kfd);
 
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 722ac1662bdc..5be28c6c4f6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -854,7 +854,7 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	 */
 	mutex_lock(&kfd_processes_mutex);
 
-	if (kfd_is_locked()) {
+	if (kfd_is_locked(NULL)) {
 		pr_debug("KFD is locked! Cannot create process");
 		process = ERR_PTR(-EINVAL);
 		goto out;
-- 
2.34.1

