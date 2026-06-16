Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E723CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F3B10E970;
	Tue, 16 Jun 2026 09:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jPLbhpg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED6D10E96F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxOqBF85nCavcuVZcHkEDm3BPBTfuNlHxtx5tnkI0EgzEnEhyAH/e/gKr1LC+sr22XlrUhGxfJsTN8ELb0ZalsNjU+T+eA8tTOj57ewvByZS7uvYlJz1UgMAVFCSpsSOn0FFVEwlWze+2ldo+hUx+bXYl25WrnAIRmAXwO35epnN44Bcio6R2DxSdsU7DxIQa6B8XXJcNQMa0fBu64Iqtj21gG9gPzfTtp+zcB2pS6g3Tetj4CQfUKut+eZFiPnzoFKpLaHU1BE5jY+M+Ie5P0RRz069QzDs87aAjShDvkG8ryRVA7xXhMSJ+c1zMRaKez9tXvZnKo/MmqTgNKKCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhd6Lv+2C+E9NVNqjFJF6KbHmjUx3HimH1hRIe9CqNs=;
 b=neidjbjgfYBklEY7/JGl9atgp7IAp2YYw+rXZGDsQ0b2/hVVrS2kRUShYoYXNNBCUV9k25Zfzpun5oDHDnZcITv4jZoRA7Habny5tgXsvhAGCHreiHflXE4Os2o6r7jRbsQay1aVJVD5FTLI3WRSeWzZ78FnOz5TCGSb60AZ1j3JYZl/yDy0KFT/3hpHmyGmminmU/Xrz5JhqXRpsk2VqzmERUZZbBHkSRiQD9oSHQh/FSUhVPYpPiZHgrJFPaKK3YFAooOg65dQQ438r0Wd+egVpdGOdvKaKqlIjPF0iGaoyTC0oRYxaX8xSl2ntEucpqgbR881AsyPqOp331m7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhd6Lv+2C+E9NVNqjFJF6KbHmjUx3HimH1hRIe9CqNs=;
 b=5jPLbhpgGx6RPe0WxT3TVKuTOwUb/XEJAzm9fR68IljKDcDry9CdZ83UapQZRbz0eQMbRws+EYrm3VNZ5r4uDdYX5OVM9g3Nymko6GCV/09qQPpV1dgyaejPCvQlBeXI9KTHUM6FKujiqmT45Ywv4rwhm33zYdTXSbFj2xdyWXk=
Received: from CYXPR03CA0006.namprd03.prod.outlook.com (2603:10b6:930:d0::27)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:15:06 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:930:d0:cafe::a8) by CYXPR03CA0006.outlook.office365.com
 (2603:10b6:930:d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:15:05 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:15:03 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2] drm/amdgpu: clean up discovery and preempt sysfs entries
 on shutdown
Date: Tue, 16 Jun 2026 19:14:44 +1000
Message-ID: <20260616091444.25605-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
References: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ef5a11-041a-4e96-5f2f-08decb87c161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: p9j3VHJa5+1/XXH+1BOKglZx2HgK6BymdgDo+67ZaDKhfB2q12rd93aNShIO1qrZOmAb3SQOcAdLnVMVeNZGJqip6BY64ZY4CRF3c0KR/FbfIu+vpaqCvY9sKer6nW55MqDhxfAiPSpeZ5HcjKnPWXhovMvD/aCZdv+NEcaUB/2zvzsqoJyzOqcW1kAZ2IN+M266TVpq6ZW0Ac4YMx0EaTeZm/SBiLeuwX/3GocCt3ZChli8O7NcYft1e1MsOKf+ERXEELqTHhIOnZiiBhWzSgelzaPaxOPnS7+NIj4ST5DMVqwsqm+ct/qiUv0ivvxjReDamxiIH0veblkGZEWepipkSPj72WV2uiKSCSzaS+p6jGT7O3TEiyPISu1Pq/tEYUWYjd/nJIKCR/NcwIH6Ax85raw6/4H+LV1xq4aBTjpSgHgtnLqETnrJliKi8FtPSIWbAR2U575gDmuxesIsqaEMbTyaCRraVSFPMHvUlPMbaVjbtntG4cxWCc8FnD4IvRRMh7hchBI8h0wnYNb/ZIBAL0ENVHuT2t+2KoqQmBXFstaIxbjWRhl1nNmbhqXEuhkCf/IHHv18OZjvmu8SBhUXjZepBSfGrOMMYfT+6xXOK/8OOqjre6C9/7FsOQ8W9nWDMH3E/dImGR4sOgkqKNfQO6TOfNHudBpXWDY+WJYvPVfFZLD5RkkjmIiEPMj1o+R8NJ96Nyc1dsIILPEQC8xtdVoKu24yh8BMB1SfXTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Xrj0lm0Xz3aPDOW/sjZNoMk2MhlipE9cG2N3B6TY/9jdL5suBdZdYfZ7yXXGigu7vewEmzegFN/JhoxvETH9dJcPlSYoPCDUPMGNfiTENVfjhNJIp+bPIBQ3zLW8hmIk+ShNBEqLLLKqb4JsfDnbaENASB5ask6iqgJBzskkjKFb7BiPfF3hMSFqIbipeXvUxl/r0Y+X2mlE5RGTwh0q3o4b+OZtwomveVV1VsY603R3jt62suFCCjQ5ObliONXOf1TQw6cxu20/CGi1YJ/K4zKrogyKwuty6eUpQXnuQFZ8BMFO+l954FZd/d+6UZehkkiQ1dN9ty9AZhmcBkGmu0R+zpCwsEGZNUktlc19i0jI4nbyjiyrIMrLUR7pDWFP6/IF87SQIcNMOaq7LxMXSxX/46UM45BOpN+p79OXOPKBFvubtezCjbTZ0ENRhbq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:15:05.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ef5a11-041a-4e96-5f2f-08decb87c161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
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

From: geomcrae_amdeng <geoffrey.mcrae@amd.com>

Fix a sysfs duplication error when reinitializing the device:

  sysfs: cannot create duplicate filename '.../ip_discovery'
  kobject_add_internal failed for ip_discovery with -EEXIST
  ...
  Failed to create device file mem_info_preempt_used (-17)

The failure is caused by stale sysfs entries not being removed during
device teardown, leading to -EEXIST when the driver is reprobed. In
particular:

- amdgpu_discovery sysfs kobjects were not fully torn down early enough,
  and ip_top remained non-NULL after cleanup
- the preempt manager sysfs attribute was removed only conditionally
  and not during the common hw fini path

Fix this by:
- making amdgpu_discovery_sysfs_fini() externally visible and clearing
  adev->discovery.ip_top to prevent reuse
- calling amdgpu_discovery_sysfs_fini() and
  amdgpu_preempt_mgr_sysfs_fini() from
  amdgpu_device_sys_interface_fini()

This ensures sysfs state is fully cleaned up before reprobe and avoids
duplicate kobject/file creation.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: geomcrae_amdeng <geoffrey.mcrae@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 +
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 91f2506b9529..e72924976994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3678,6 +3678,10 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
+
+	amdgpu_discovery_sysfs_fini(adev);
+	amdgpu_preempt_mgr_sysfs_fini(adev);
+
 	amdgpu_device_attr_sysfs_fini(adev);
 	amdgpu_fru_sysfs_fini(adev);
 
@@ -4211,6 +4215,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	if (adev->mman.initialized)
 		drain_workqueue(adev->mman.bdev.wq);
+
 	adev->shutdown = true;
 
 	unregister_pm_notifier(&adev->pm_nb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0c51e0fead40..a229fe9d043b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -759,8 +759,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return r;
 }
 
-static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
-
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone_mode)
@@ -1483,7 +1481,7 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
 	kobject_put(&ip_die_entry->ip_kset.kobj);
 }
 
-static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
+void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 {
 	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
 	struct list_head *el, *tmp;
@@ -1492,6 +1490,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	if (!ip_top)
 		return;
 
+	adev->discovery.ip_top = NULL;
 	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
 	list_for_each_prev_safe(el, tmp, &die_kset->list) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index edc78184e0f3..5b2b16f68576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -41,6 +41,7 @@ struct amdgpu_discovery_info {
 	bool reserve_tmr;
 };
 
+void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 34b5e22b44e5..37ef5b9eb1cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -46,6 +46,17 @@ static ssize_t mem_info_preempt_used_show(struct device *dev,
 
 static DEVICE_ATTR_RO(mem_info_preempt_used);
 
+/**
+ * amdgpu_preempt_mgr_sysfs_fini - remove PREEMPT manager sysfs attributes
+ *
+ * @adev: amdgpu_device pointer
+ */
+void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (adev->dev->kobj.sd)
+		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+}
+
 /**
  * amdgpu_preempt_mgr_new - allocate a new node
  *
@@ -137,9 +148,6 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (adev->dev->kobj.sd)
-		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
-
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2d72fa217274..00acec7226f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,6 +140,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);
 void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
 int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);
 void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);
+void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
-- 
2.43.0

