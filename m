Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21CACD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1858810E645;
	Mon,  1 Jun 2026 05:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0TV6yzAs";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAAE10E645
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHcgMQZwJp0+VT7DOPYhC8meuph+LaCrbdyLCRr7RSkgYWgSRxzraJiuHHhhgwzxj9hEPfLTS9gzhXBTTEtV0CFSYEZXzUCdkGjfFXHB8kK4ejctGg48tlDoNMp+OG8DRUACTFNReasN+ieHcN/U69pD/fWtx36+A8NYJ17KspHorD30C6yEwPBEF8zlxI00u8WUGV/W8WKNk3uxZPBtZnpKijOwoZmsD40xXUiy991KYN/fW9VlT0GC5leguNiNG1QwWWGG2mE9AcDL11/IqHdvzPpgoL77lhd3gnFGGSauEEyn7nnm8L8V+MXbGO/r+ip+TQMxPpdH6jzNrYIvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAjccTjKpFN/ehRmUpVhMUx6GcIxUGbMHoKrge19WSM=;
 b=Ei7jWbIREBjQOeU47R10dOj0JO3SP88Z/JxTOei2dyKUKsstK9n7LzAw+ypQ6G29flFM3IWqeZeZDWuNsE5Yn9lylXNh3jX5qbuGpJdis+buE2HaLkiv4Qvx346abuPtjM5ccySCSa6+mW3bOqCoAY+fXsSubh///dJouZfxd9zRB2KduHXzbRTqzsTGnVigsLiVtTKS/rQ/pVV18liyqlj8Ej9cN8BB16PPARyBw3I9JWaQiFN7ERuQKC67unJj2ZBFC5CqS+48U4V6ga4cqbbQdTXFucfSZOfOdM4Af/GYJSNvJwdnA4yIzAQ7ISBVdcUbPwqNYw3WbS2tzmQ3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAjccTjKpFN/ehRmUpVhMUx6GcIxUGbMHoKrge19WSM=;
 b=0TV6yzAsUWGAGB7p1HuVPLubv4qLEC1Z2x/CrdCCpc/bDR7ei9Z0yl5HyjdDoUtqIqevXDAVPESJIOV49aTQR+ubrbglP9fa1hG1hu+jttrLfjvxKVvl+FzVO4eE3oGREmuK8ub7FOW832VhCkxXQuPGcmjg41cC0+gBEFfjIak=
Received: from CY5PR19CA0085.namprd19.prod.outlook.com (2603:10b6:930:83::9)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:05:31 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:930:83:cafe::9d) by CY5PR19CA0085.outlook.office365.com
 (2603:10b6:930:83::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 05:05:30 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:05:28 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: clean up discovery and preempt sysfs entries
 on shutdown
Date: Mon, 1 Jun 2026 15:05:02 +1000
Message-ID: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f040e9-0ad4-4ab0-bcb4-08debf9b6727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: r3jqjPlE1vt/fpoGh6jNVBJDLkRsoVKxIIuXZtxbDiHISsRQsjkmbwV8Ci/0MPqqcn5oD0n0ACFiW66vBQD/mrUn2wNpfGeluo3v36VP5mnv1Yzla3rNZ4/XiE9ZPCWeCuryKkZKvHO5TovjnVUACLH5iacNMEnyt91rB8UWSoNL26QizT9GHDSKn2gJZY13teDsX8Aom/tcDLDOoAXD4kf/ho2lSezCbRpRJag7SniQgauTyo8PhbIDTAydeYwLJ3isfOWbEe1mlO6tt6EgqqtIkhi0mq1DuxUyupKi/Pf+dfefOUfRxqHog6p5KdV1YRa5OeGp2pxu8Q+ObHkN5psj9qS9rBLiUgV3Tsh+mQgVAetj6Au9TQC1agVPL0HMAUxn6L+ZTsW1psr719a+brx08t7T22pmhjmlXFPz7cqNaVj/AK39wg/xrLySejqDBmznkERBWrsofQr9UV2Jo4pnVFYn/b7k+Np/msJCa9PkipfZvRgdN0eRmFRh1lMwbGu1+gO0Dt3XuXRlxa5FVOwVnKLIOBepQOVHyo9NHFx4bIWRcLJZSk98hIq+ldpEe9d2qPORLcLhm8vuLJMH49vNeDYureKPYhrYGMdZy9YCUaoN8lPf/F+NPGRLsCSQz8Hj96+YqJp6iYuytNiCAL+0jIKiw2lp1Plpbaawx1eZ7HX7CKPhhL+/xKKZMs8zbqB6uuq0OsiSK/KaYsKVrOmw69tdj3bve1uLnRgeyRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CdqjD5/iTz649gzS/E3Jdsknnph4Vmw8ex54W2rV88YOXpu3oQYb3ziT51XoWgAC4NREnZdeFrLoclQG9nD+vypfLLurkk0YUQBKxKoyCRilMU43gBGGmPVBmys/FWIsQPf9AAtYxhhsw39yZ2lpQJxbv3TRzHdCfOauzFy2N6wu8TEAEe64DMi9ACNUBSbRV0oiejZ2L8MgfN0ys2ptmAxWK0TsFyjrbin3x1pMsRTcSzKENpdNVQlk8+QA2O32XBn80npKXyfvWmOtf/5Y4O0Z90ZOrTGygqmxQ+Wq+QHJJTvF1sL2wY3XvsCKXdZwSW8553t7VJABzY66ViyTAsI99mEoO5TzX4jNKX6eyfbUt0Gwi8xSytKBMdOpzDG4dM7SSRSmDybzb4XpluDWZAK/EWfCuVLOnJeZjEcQi5UXgqWKDv1RSEA38OWm8XDD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:05:30.4359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f040e9-0ad4-4ab0-bcb4-08debf9b6727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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
- calling amdgpu_discovery_sysfs_fini() and
  amdgpu_preempt_mgr_sysfs_fini() from amdgpu_device_fini_hw()
- making amdgpu_discovery_sysfs_fini() externally visible and clearing
  adev->discovery.ip_top to prevent reuse
- centralizing preempt sysfs removal into a helper and reusing it from
  both fini paths

This ensures sysfs state is fully cleaned up before reprobe and avoids
duplicate kobject/file creation.

Change-Id: Ib91bf9eac4a1901c05bdb17b20de3e4122323b34
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 +
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff224163bab..ef5cc4997656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4200,6 +4200,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	if (adev->mman.initialized)
 		drain_workqueue(adev->mman.bdev.wq);
+
+	amdgpu_discovery_sysfs_fini(adev);
+	amdgpu_preempt_mgr_sysfs_fini(adev);
+
 	adev->shutdown = true;
 
 	unregister_pm_notifier(&adev->pm_nb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7c2212985273..a2ae26bb11ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -704,8 +704,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return r;
 }
 
-static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
-
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	amdgpu_discovery_sysfs_fini(adev);
@@ -1391,7 +1389,7 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
 	kobject_put(&ip_die_entry->ip_kset.kobj);
 }
 
-static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
+void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 {
 	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
 	struct list_head *el, *tmp;
@@ -1400,6 +1398,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	if (!ip_top)
 		return;
 
+	adev->discovery.ip_top = NULL;
 	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
 	list_for_each_prev_safe(el, tmp, &die_kset->list) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index e0010f6a3eda..cff33ab2cb25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -41,6 +41,7 @@ struct amdgpu_discovery_info {
 	bool reserve_tmr;
 };
 
+void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 34b5e22b44e5..eab81206c050 100644
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
@@ -137,8 +148,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (adev->dev->kobj.sd)
-		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+	amdgpu_preempt_mgr_sysfs_fini(adev);
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
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

