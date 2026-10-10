Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEEBCA9EC1
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 16:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B7410E040;
	Sat, 10 Oct 2026 16:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw0DrCFy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF5910E040
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 16:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpIEkec3WTi9ejxK+JMINi4lnHUjZcoqSSHmzwC7pi++suhdoXZZCLxmoMwAZ74gjBXTRUccF5CxfUasX9VL6AJRwFt8iIUjuKN6Jzsv/OlodQdiNTtDuCkKA+Cubmq7vJfXhI8bT4Mi8obHYFDVp6Aj2V1XMI5mqNee0fGtY/4ZXUIHxnmUueFqHYl8JnnleiT3bZ4qZRdn029ui1O9rxIvo+XQCTaL8d+6c6KFZ2jgEH2hojwGPslRx5geWlM9sAZ8KTyKLAOT+n5TaaHjVvXpI3Y77fcQ5asobQvKiZwLakPqQMMZ+XtvFO30l1XStHOomTY09lpuEi/7ybaQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBu+iqH9WrnvL9wZucLnkxwn/vd7LvIrcmiVORljU9k=;
 b=A1keUyIkkbCqoaR/WqBKKtzMZiSK+LOHd2qBtHFPWpvlSTE4XqcDd006Yc8Kf3U6rtMPCckPOdnAQhEO88ETGquEq8k0jvol0fFxGZ29j5U9lSZwg7ahaB+H10AlqMCPBOMYazsn6CRfLutEVoyXqVYCJArZYZaDD7yeScWVDpdsYNtr7fE/zh4CAfn8tZtqVXSV3JlQ6cOI7yQ05EoSCEJLBW7lHQGIrqu6vCrST4Zjrd22WZtefuLi+JBZ5Ipk8lvt8RoamDseeiw1HUpoacDxH5NFUCefNWTIEIGf+yskybtdzMhqt98dOu00mpDZ7iSQytXJlWdC8gGtz27V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBu+iqH9WrnvL9wZucLnkxwn/vd7LvIrcmiVORljU9k=;
 b=Qw0DrCFygj+4jG6FWdhYkaTTuI4J5TSrIBlKZWeh8rdNtT43CbnCypKvs9oW2Nszsc1IIN7ZSPVX/FyV2hLGgYHkcpDGZDEG/0GwgHsPaW04Z/e/2XvM9eOG/BHlHm+tr36FV9zgriT/S5/yrM4H2puCLFfeavEPlRXwxDwzuO8=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 16:27:51 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::62) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sat, 10
 Oct 2026 16:27:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 16:27:50 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 11:27:45 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>
Subject: [PATCH v3] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
Date: Sat, 10 Oct 2026 12:27:34 -0400
Message-ID: <20261010162734.2570564-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135d46e-bdb8-4319-ff6e-08df26eb6d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|261009223327099003|261009221727099003|261009221227099003|6133799003|56012099006|10067099003|18002099003|261009220027099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: b5eIfnx9IF8T+kA29aFTMzNURcc1vgzW4SUnm0Et2f5Zr6wE6ZxIdFOspMcNBfaSHO3XbY44OSizmW7T4wCKq8Qz1yOnvpX9Jkz3FK9bJ8GVsZGw+W8wCqgtcCjd9vAoplP8lH5zpo0si7QrVRkYG7duo9Q93KouLQx5CDE4FlmVUlE8GvAbz3Vsa8A49BuPC1UBETiSVkLR+rvXwrJ9bWQbB9RnPGz2jTVTyB9QH1b0sij6Fezyz4Gv4phFI/reRHgFITuOi9vS4mFmg+tgU0sLUkCgI3X/jAAyqu+yKD6ok9FA4YS+7CK2aiNZdeEvox6POmWbEmHv3kVDKNYt+AeQvJXEum/oY3NkNn+IAE+rNGL2gGHMTIZE2/5eYMP08rrxr+DHknRxso0nqv+0ZlzgD7WSZhkm5tmAuFz6IWCQ5YW8lmX6X6FlKE9AUJdLEEjCDrnKsx6G4LzWVmG6avjZLslbdpoFpeKfgocJ2vJpHbmbMJRGTMipXEaafj5QFBmuGbflJBHpdFDS59ezdxnP1PcF5CfRlI9Z49gimpPkw8wqZU7dP21XGiRP8LwNleHuAnIBPbcDE5en272t4RLcYvUaukvu/SGGJVLVrW5PJMxXDLkJrXhQNvKEjBxx8ft6Kt0nM85T0uNKEkMdJuBsnLejc+WPFvQye/LfCiMTgWczAkPzMmh6Es5Gj8S7gJ+SPWRin/0ofEFe0OnFtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(261009223327099003)(261009221727099003)(261009221227099003)(6133799003)(56012099006)(10067099003)(18002099003)(261009220027099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lPE2IV7EXBnFrbIqJ2QOvuSZdIM0HaeP0p0R9B4MB/Numgfx9VVH1YyY56sQmyjVE8E7wLrd5Q5o2xS9QxOmDhyy4kzJ9Iptjep7sKKZa0UjBNDwTWCrsN23WgWlNr5fNvRhLSSgJqPJpDGQXqaxRBg/HiWPqMdZtsuun1YC+B7cQUZAnuUTuLQBRe1m2TY7oIBtK2X0rmRMtb37bBkoTEhPqJD7/9/uI8EdGBV2H7NQ0/yu2hYXU51MCF2lGVVzZttit51jtChcdnJZvPgLpRKYIFc8kECHdPFcRIEgtmVVBLS9Pw8+5LxyEV4IXo2RxKvogcIIEc7tBpavNWmqWG3m5Mi7heXVJldx+htvZvyceLYfkSvBTopHYlBLnEuBYyV69BhEU/siI65tj5V118NILK7DlavOxf5ETCFuD01Ry2VX3nLqbeC13SXmc/Gs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 16:27:50.3966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135d46e-bdb8-4319-ff6e-08df26eb6d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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

Make amdgpu_amdkfd_pre_reset() take the reset device list and call it
once from gpu_recover() before the reset domain is locked. PCI error
handling keeps calling it under the lock, as before. Return -EIO from
unmap_queues_cpsch() when the HWS is already known to be hung, instead
of waiting out the preemption timeout again.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
v3:
- Make amdgpu_amdkfd_pre_reset() take the device list instead of adding a
  similarly named wrapper (Felix)
- Drop kfd_dqm_can_reach_hw(); pci_channel_state is only valid after
  amdgpu_pci_error_detected() (Felix)
- Return -EIO from unmap_queues_cpsch() when the HWS is hung (Felix)
- PCI error handling keeps calling pre_reset under the reset lock

v2:
- Drop the SRC_USER gate and the helper; run for every reset source
- Cover amdgpu_pci_error_detected() as well as gpu_recover()

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c          | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c          |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 ++
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e023cc734ebc..fcd857fb7d09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -314,15 +314,14 @@ int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev)
 	return r;
 }
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
-			    struct amdgpu_reset_context *reset_context)
+void amdgpu_amdkfd_pre_reset(struct list_head *device_list,
+			     struct amdgpu_reset_context *reset_context)
 {
-	int r = 0;
-
-	if (adev->kfd.dev)
-		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
+	struct amdgpu_device *adev;
 
-	return r;
+	list_for_each_entry(adev, device_list, reset_list)
+		if (adev->kfd.dev)
+			kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
 }
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e3da382ceb3c..7419d3614c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -180,8 +180,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
-			    struct amdgpu_reset_context *reset_context);
+void amdgpu_amdkfd_pre_reset(struct list_head *device_list,
+			     struct amdgpu_reset_context *reset_context);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..7e928d09db34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5534,8 +5534,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
-
 		/*
 		 * Mark these ASICs to be reset as untracked first
 		 * And add them back after reset completed
@@ -5784,6 +5782,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Cannot be called after locking reset domain */
 	amdgpu_ras_pre_reset(adev, &device_list);
 
+	/* Dequeueing takes reset_domain->sem for read */
+	amdgpu_amdkfd_pre_reset(&device_list, reset_context);
+
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
@@ -6233,6 +6234,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 		amdgpu_device_recovery_prepare(adev, &device_list, hive);
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
+		amdgpu_amdkfd_pre_reset(&device_list, &reset_context);
 		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
 					      hive, false);
 		if (hive)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5e57576fba21..c2b069832dbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2832,6 +2832,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 
 	if (!dqm->sched_running)
 		return 0;
+	if (dqm->is_hws_hang)
+		return -EIO;
 	if (!dqm->active_runlist)
 		return 0;
 	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
-- 
2.43.0

