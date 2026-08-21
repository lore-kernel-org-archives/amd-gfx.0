Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062DDC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975E310F4A4;
	Fri, 21 Aug 2026 19:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I9+q+Lvi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B118110F4A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU4NNxTNfe/M7yLPuhUNqcg7WW+/WJfJwZdNLdEx8wVtIlSG5cUZkRID74hCcJQ0zf/2rNe0Lu4Ufv9RUE8dl5YPsnABezMqw9YeG4O2uQYk9RRISAEoXVCCf707ZY2YB6vdr2GMIaasEnIgh7nXt/6nso2vXOlwC+OTBpCV33VStjGXi9kypJkoHLTBadTVssdyCeilhntF5u68HtRyWH/o01hsipdNBRUc2IOm3cEOqGRu3rADAHr7T8+KrdUDJfAi/lEc2tEKBXoh8Kdf2yp/30f040fbJr/0OKF+1uw0ras6FEGEIwW8E98dhnx7+wq2jjeAo0/tqrlZklbReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln9Asr+0VhXPA+If66wLh73wVN8/cWSv6lOnhjjgXaE=;
 b=iqHI7TRkoe7T7h76CdkRgbEdta0Xcx8/gqu9t2YAbGUKAVxJJp1Uw3+VmIj7W0uRm5X2HvtUhmUglwnZHN0GuIRDjEA6AKYZ3Ao4o59RcahdeGBd7AgHOfgIh7YgHga3rFbubqrtgCYHMVuHiPXjasN5/wCO0Stu2CjYQlFbPKvF44o9ASEXRCR9f+UzBVZRIE+GN1VZ8E9yE7Hp8C4Bffz42dZRXlfxyN4hGbslk1WXQv90FxDdDgjky9/gvcXfpCSQTJJqvcQziGhKR6O7haB/8Mfx7ILDx02Uz1sJvn6bZl3Cg2B1PfPyjMRaXPr6mOHo+sPkt79NYoW04N4JDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln9Asr+0VhXPA+If66wLh73wVN8/cWSv6lOnhjjgXaE=;
 b=I9+q+LviRAVUmWDYDnnzZuL3mPu04+khOno9jJ7wjJDeVX9iyRM54ZJQGQ869pYZVr2L9cyf6EUwFBoeGj3MbOQPOffj9SuxU1UPdksNpNwdENAga5tf3CkG2qJMuro0zZPcF9SavZfxpdpfelxxhWDbsnKb3uc+h0o+8HVxuJQ=
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:03 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::36) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 75/95] drm/amdgpu: Separate out ualink init sequences
Date: Fri, 21 Aug 2026 15:34:38 -0400
Message-ID: <20260821193458.808626-76-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbdcb79-f742-4c0f-f6e3-08deffbb6feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: V2IGbhP9dE4kPVuNN4lVnPmaskInsTy+SjW0nZlw7Ut22SAtQxEEcalAjWw0h5PLpr2KxJxf0Jc5g00rZRWXT24K4G/wmLjvK9JKtbObd9xH8OQvqAMSYnmNDksZJP7rgw8GGuAEGEgPlcBxfg5Q/kukSywH/PD43wCbkLmI7MY3zRrzcvRf5+gRCVMhxDTMj1rKdjC8XvkJN6/HkCqDuYCy2RnXqhgOFSuh5oaJdNPLzPBE5S8K7ekgdKcGiGF89HfFDrKgpG/ClYVu/o8YQhxfZK1zTfR/uYsG6lJsd8o6H16XEXRXabmigZU41phnQdtkkGwM6X0kNzZfmJPTR40RXNwZq2KPlTfOozRuHIm7z4I4dwJsKAh6m+H/l4SFCpk+LVOPLuY81VEynNMWPBT3uc9Q8qjmGJTq2AtZGF7nZgpjpZW7u6TaKHP9Ee2/QVFkxsnUinJIkb8taBP1iFmRshW2yx3iCxinJZ+ZhlmFp9ocjqn0xfXLBSGETZcxtWbk+lN7INPv8se/3xumF8cRyulhrTK0/rlUvu2oQuBCpwu0mqHAQ6egdexXbXLjMElpGKtUejW8vdRj837qqqX86MjaSUSo9aRQ22RvZgPYiScMlhN+nxGZVbhOxe4AnJ2RYZ94xqdzVWedOXRmUjChkdyn6LcnLQ1hKmmzvCxYQgtNq1jXW3b9CY6bfESp/nFAt88NWo/WB/BzNJuRWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UoBh8M7uYHxjMx0wMbyWwJ49C7uOtnsbgkdMRGSUqMBeTM3W8JmeUXYItryY/1Dc8Qa5lJIqvyjPv6WoOkKB0yFJx3avRaGa4TaPOpawo0pSVjjnTCN9XFFJVqMl5+a0iWnUk4ipAMUuyZ184A1zIcndB0L8dO/z2fEnGReJRw10ONyGpBE6ufVvGpBIs7hj6WwWUxHtP8ox4FHiAgI6Lm3iaizKTuGBVrGWj5sq9Fb92SPw9vbOh7/PTbvg5ZmqjsW+soQ5t3iyvX8Vww/fdnJI57ILyvGx8++O7PZ465/a5UVskOu/w/QYumHe67M4NjBtCKBpZylAhAHISAW9KC1Dk1VKm9iUX5e4xqVy5zUkqHZlPzfiIcWzKh0y+WjUoNUNfcBpEVE0tp+GqHaodD4fB/R+GePlq9+4jfRGcHgCs0+3hYDwcoS+muCXTnsQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:03.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbdcb79-f742-4c0f-f6e3-08deffbb6feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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

From: Lijo Lazar <lijo.lazar@amd.com>

Separate out sw_init and hw_init part of ualink. ualink init errors
are ignored temporarily. Keep ualink sysfs init together with sysfs init
sequence of other IPs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 300 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  16 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  23 --
 4 files changed, 188 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c3180dfd26d5..715cc2e85105c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2456,6 +2456,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_ualink_mgr_sw_init(adev);
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
@@ -2482,6 +2484,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	amdgpu_ualink_mgr_hw_init(adev);
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -2765,6 +2769,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ualink_mgr_late_init(adev);
+
 	r = amdgpu_ras_late_init(adev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_ras_late_init failed %d", r);
@@ -2957,6 +2963,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
+	amdgpu_ualink_mgr_sw_fini(adev);
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
@@ -3726,6 +3734,7 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
 	amdgpu_xcp_sysfs_init(adev);
 	amdgpu_uma_sysfs_init(adev);
 	amdgpu_ptl_sysfs_init(adev);
+	amdgpu_ualink_sysfs_init(adev);
 
 	return r;
 }
@@ -3747,6 +3756,7 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 	amdgpu_xcp_sysfs_fini(adev);
 	amdgpu_uma_sysfs_fini(adev);
 	amdgpu_ptl_sysfs_fini(adev);
+	amdgpu_ualink_sysfs_fini(adev);
 }
 
 static bool
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f45edc882b2f2..bc53d37534222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -80,57 +80,90 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_ualink_init(struct amdgpu_device *adev)
+static bool amdgpu_ualink_supported(struct amdgpu_device *adev)
+{
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP))
+		return false;
+
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(15, 0, 8))
+		return false;
+
+	return true;
+}
+
+static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
+{
+	if (!adev->ualink.info)
+		return;
+
+	kobject_put(&adev->ualink.stations->kobj);
+	kobject_put(&adev->ualink.config->kobj);
+	kobject_put(&adev->ualink.setup->kobj);
+	kobject_put(&adev->ualink.info->kobj);
+	adev->ualink.stations = NULL;
+	adev->ualink.config = NULL;
+	adev->ualink.setup = NULL;
+	adev->ualink.info = NULL;
+}
+
+int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	/* UALink relies on PSP services. If the PSP IP block is not present
-	 * just skip UALink initialization.
-	 */
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
-		adev->ualink.psp_if_ver = 0xffffffff;
+	if (!adev->ualink.info)
 		return 0;
-	}
 
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
-		dev_err(adev->dev,
-			"UALink interface version detection failed: %d", r);
-		return r;
+		dev_info(adev->dev,
+			 "UALink disabled, PSP interface version detection failed: %d\n",
+			 r);
+		goto disable;
 	}
 	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
 		 adev->ualink.psp_if_ver);
 
-	/* Query initial configuration from ASP */
 	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
 			       adev->ualink.info);
 	if (r) {
-		dev_err(adev->dev,
-			"Failed to query initial UALink config: %d\n", r);
-		return r;
+		dev_info(adev->dev,
+			 "UALink disabled, failed to query initial config: %d\n",
+			 r);
+		goto disable;
 	}
 
+	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_HW;
+
+	return 0;
+
+disable:
+	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_ERROR;
+	return 0;
+}
+
+int amdgpu_ualink_mgr_late_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
+		return 0;
+
 	r = amdgpu_ualink_drm_client_create(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
 			r);
-		return r;
+		goto error;
 	}
 
-	r = amdgpu_ualink_init_interrupt(adev);
-	if (r) {
-		dev_err(adev->dev,
-			"Failed to enable UALink irq: %d\n", r);
-		return r;
-	}
+	/* Consider UALink initialized only at this stage */
+	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_COMPLETE;
 
 	return 0;
-}
 
-void amdgpu_ualink_fini(struct amdgpu_device *adev)
-{
-	/* empty */
+error:
+	adev->ualink.mgr_state = AMDGPU_UALINK_INIT_ERROR;
+	return r;
 }
 
 /****************************************************************************
@@ -430,9 +463,7 @@ static const struct attribute *ualink_info_attrs[] = {
 
 static void ualink_info_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_info *info = to_ualink_info(kobj);
-
-	kfree(info);
+	kfree(to_ualink_info(kobj));
 }
 
 static const struct kobj_type ualink_info_ktype = {
@@ -537,9 +568,7 @@ static const struct attribute *ualink_ppod_setup_attrs[] = {
 
 static void ualink_ppod_setup_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_ppod_setup *setup = to_ualink_ppod_setup(kobj);
-
-	kfree(setup);
+	kfree(to_ualink_ppod_setup(kobj));
 }
 
 static const struct kobj_type ualink_ppod_setup_ktype = {
@@ -875,9 +904,7 @@ static const struct attribute *ualink_vpod_config_attrs[] = {
 
 static void ualink_vpod_config_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_vpod_config *config = to_ualink_vpod_config(kobj);
-
-	kfree(config);
+	kfree(to_ualink_vpod_config(kobj));
 }
 
 static const struct kobj_type ualink_vpod_config_ktype = {
@@ -995,9 +1022,7 @@ static const struct attribute *ualink_station_config_attrs[] = {
 
 static void ualink_station_config_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
-
-	kfree(stations);
+	kfree(to_ualink_station_config(kobj));
 }
 
 static const struct kobj_type ualink_station_config_ktype = {
@@ -1005,20 +1030,29 @@ static const struct kobj_type ualink_station_config_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
-int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
+int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_ualink_station_config *stations = NULL;
-	struct amdgpu_ualink_vpod_config *vpod_config = NULL;
-	struct amdgpu_ualink_ppod_setup *ppod_setup = NULL;
-	struct amdgpu_ualink_info *info = NULL;
 	int r;
 
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP))
+	struct amdgpu_ualink_station_config *stations;
+	struct amdgpu_ualink_vpod_config *vpod_config;
+	struct amdgpu_ualink_ppod_setup *ppod_setup;
+	struct amdgpu_ualink_info *info;
+
+	if (!amdgpu_ualink_supported(adev))
 		return 0;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
+	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
+	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
+	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
+	if (!info || !ppod_setup || !vpod_config || !stations) {
+		kfree(info);
+		kfree(ppod_setup);
+		kfree(vpod_config);
+		kfree(stations);
 		return -ENOMEM;
+	}
 
 	info->ppod.accel_id = 0xffffffff;
 	info->ppod.bandwidth = 0xffffffff;
@@ -1026,115 +1060,103 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	info->vpod.id = 0xffffffff;
 	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_MAX;
 
-	r = kobject_init_and_add(&info->kobj, &ualink_info_ktype,
-				 &adev->dev->kobj, "ualink");
-	if (r)
-		goto err_put_info;
-	r = sysfs_create_files(&info->kobj, ualink_info_attrs);
-	if (r)
-		goto err_del_info;
+	/*
+	 * Initialize the kobjects here so their lifetime is tied to the UALink
+	 * manager software state. amdgpu_ualink_object_fini() drops the final
+	 * reference via kobject_put().
+	 */
+	kobject_init(&info->kobj, &ualink_info_ktype);
+	kobject_init(&ppod_setup->kobj, &ualink_ppod_setup_ktype);
+	kobject_init(&vpod_config->kobj, &ualink_vpod_config_ktype);
+	kobject_init(&stations->kobj, &ualink_station_config_ktype);
 
-	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
-	if (!ppod_setup) {
-		r = -ENOMEM;
-		goto err_remove_info_files;
+	adev->ualink.info = info;
+	adev->ualink.setup = ppod_setup;
+	adev->ualink.config = vpod_config;
+	adev->ualink.stations = stations;
+
+	r = amdgpu_ualink_init_interrupt(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
+		return r;
 	}
-	r = kobject_init_and_add(&ppod_setup->kobj, &ualink_ppod_setup_ktype,
-				 &info->kobj, "setup");
+
+	return 0;
+}
+
+void amdgpu_ualink_mgr_sw_fini(struct amdgpu_device *adev)
+{
+	amdgpu_ualink_object_fini(adev);
+}
+
+static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
+			   const char *name, const struct attribute **attrs)
+{
+	int r;
+
+	r = kobject_add(kobj, parent, "%s", name);
 	if (r)
-		goto err_put_ppod_setup;
-	r = sysfs_create_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
+		return r;
+	r = sysfs_create_files(kobj, attrs);
 	if (r)
-		goto err_del_ppod_setup;
+		kobject_del(kobj);
 
-	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
-	if (!vpod_config) {
-		r = -ENOMEM;
-		goto err_remove_ppod_setup_files;
-	}
-	r = kobject_init_and_add(&vpod_config->kobj, &ualink_vpod_config_ktype,
-				 &info->kobj, "config");
-	if (r)
-		goto err_put_vpod_config;
-	r = sysfs_create_files(&vpod_config->kobj, ualink_vpod_config_attrs);
+	return r;
+}
+
+int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	int r;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
+		return 0;
+
+	/* ualink parent node */
+	r = ualink_kobj_add(&info->kobj, &adev->dev->kobj, "ualink",
+			    ualink_info_attrs);
 	if (r)
-		goto err_del_vpod_config;
+		goto err;
 
-	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
-	if (!stations) {
-		r = -ENOMEM;
-		goto err_remove_vpod_config_files;
-	}
-	r = kobject_init_and_add(&stations->kobj, &ualink_station_config_ktype,
-				 &info->kobj, "stations");
+	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
+			    ualink_ppod_setup_attrs);
 	if (r)
-		goto err_put_stations;
-	r = sysfs_create_files(&stations->kobj, ualink_station_config_attrs);
+		goto err_info;
+
+	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
+			    ualink_vpod_config_attrs);
 	if (r)
-		goto err_del_stations;
+		goto err_setup;
 
-	adev->ualink.stations = stations;
-	adev->ualink.config = vpod_config;
-	adev->ualink.setup = ppod_setup;
-	adev->ualink.info = info;
+	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
+			    "stations", ualink_station_config_attrs);
+	if (r)
+		goto err_config;
 
-	return r;
+	adev->ualink.sysfs_init = true;
+	return 0;
 
-err_del_stations:
-	kobject_del(&stations->kobj);
-err_put_stations:
-	kobject_put(&stations->kobj);
-err_remove_vpod_config_files:
-	sysfs_remove_files(&vpod_config->kobj, ualink_vpod_config_attrs);
-err_del_vpod_config:
-	kobject_del(&vpod_config->kobj);
-err_put_vpod_config:
-	kobject_put(&vpod_config->kobj);
-err_remove_ppod_setup_files:
-	sysfs_remove_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
-err_del_ppod_setup:
-	kobject_del(&ppod_setup->kobj);
-err_put_ppod_setup:
-	kobject_put(&ppod_setup->kobj);
-err_remove_info_files:
-	sysfs_remove_files(&info->kobj, ualink_info_attrs);
-err_del_info:
+err_config:
+	kobject_del(&adev->ualink.config->kobj);
+err_setup:
+	kobject_del(&adev->ualink.setup->kobj);
+err_info:
 	kobject_del(&info->kobj);
-err_put_info:
-	kobject_put(&info->kobj);
-	return r;
+err:
+	dev_warn(adev->dev, "Failed to create UALink sysfs: %d\n", r);
+	return 0;
 }
 
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->ualink.stations) {
-		sysfs_remove_files(&adev->ualink.stations->kobj,
-				   ualink_station_config_attrs);
-		kobject_del(&adev->ualink.stations->kobj);
-		kobject_put(&adev->ualink.stations->kobj);
-		adev->ualink.stations = NULL;
-	}
-	if (adev->ualink.config) {
-		sysfs_remove_files(&adev->ualink.config->kobj,
-				   ualink_vpod_config_attrs);
-		kobject_del(&adev->ualink.config->kobj);
-		kobject_put(&adev->ualink.config->kobj);
-		adev->ualink.config = NULL;
-	}
-	if (adev->ualink.setup) {
-		sysfs_remove_files(&adev->ualink.setup->kobj,
-				   ualink_ppod_setup_attrs);
-		kobject_del(&adev->ualink.setup->kobj);
-		kobject_put(&adev->ualink.setup->kobj);
-		adev->ualink.setup = NULL;
-	}
-	if (adev->ualink.info) {
-		sysfs_remove_files(&adev->ualink.info->kobj,
-				   ualink_info_attrs);
-		kobject_del(&adev->ualink.info->kobj);
-		kobject_put(&adev->ualink.info->kobj);
-		adev->ualink.info = NULL;
-	}
+	if (!adev->ualink.sysfs_init)
+		return;
+
+	kobject_del(&adev->ualink.stations->kobj);
+	kobject_del(&adev->ualink.config->kobj);
+	kobject_del(&adev->ualink.setup->kobj);
+	kobject_del(&adev->ualink.info->kobj);
+	adev->ualink.sysfs_init = false;
 }
 
 static int amdgpu_ualink_npa_alloc_va(struct amdgpu_device *adev,
@@ -5356,6 +5378,12 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	u32 local_acc_id;
 	int handled = 1;
 
+	if (unlikely(adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)) {
+		dev_dbg(adev->dev,
+			"UALink manager not initialized, dropping irq\n");
+		return handled;
+	}
+
 	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
 		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
 		entry->client_id, entry->src_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 407220710d9b4..3c5bfdd3af5bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -109,6 +109,13 @@ enum amdgpu_ualink_addr_mode {
 	AMDGPU_UALINK_ADDR_MODE_MAX
 };
 
+enum amdgpu_ualink_mgr_state {
+	AMDGPU_UALINK_INIT_NONE = 0,
+	AMDGPU_UALINK_INIT_HW,
+	AMDGPU_UALINK_INIT_COMPLETE,
+	AMDGPU_UALINK_INIT_ERROR
+};
+
 /* Physical pod info shared between query and setup API */
 struct amdgpu_ualink_ppod_info {
 	u32 accel_id;
@@ -295,6 +302,8 @@ struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
 	struct amdgpu_ualink_station_config *stations;
+	bool sysfs_init;
+	enum amdgpu_ualink_mgr_state mgr_state;
 
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
@@ -362,10 +371,13 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
 
+int amdgpu_ualink_mgr_sw_init(struct amdgpu_device *adev);
+void amdgpu_ualink_mgr_sw_fini(struct amdgpu_device *adev);
+int amdgpu_ualink_mgr_hw_init(struct amdgpu_device *adev);
+int amdgpu_ualink_mgr_late_init(struct amdgpu_device *adev);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
-int amdgpu_ualink_init(struct amdgpu_device *adev);
-void amdgpu_ualink_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 84cdb09f731e5..757da0a30fdc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -439,25 +439,6 @@ static int soc_v1_0_common_late_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
 
-	/* Depends on PSP being initialized */
-	amdgpu_ualink_init(adev);
-
-	return 0;
-}
-
-static int soc_v1_0_common_sw_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	return amdgpu_ualink_sysfs_init(adev);
-}
-
-static int soc_v1_0_common_sw_fini(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	amdgpu_ualink_sysfs_fini(adev);
-
 	return 0;
 }
 
@@ -475,8 +456,6 @@ static int soc_v1_0_common_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	amdgpu_ualink_fini(adev);
-
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
@@ -515,8 +494,6 @@ static const struct amd_ip_funcs soc_v1_0_common_ip_funcs = {
 	.name = "soc_v1_0_common",
 	.early_init = soc_v1_0_common_early_init,
 	.late_init = soc_v1_0_common_late_init,
-	.sw_init = soc_v1_0_common_sw_init,
-	.sw_fini = soc_v1_0_common_sw_fini,
 	.hw_init = soc_v1_0_common_hw_init,
 	.hw_fini = soc_v1_0_common_hw_fini,
 	.suspend = soc_v1_0_common_suspend,
-- 
2.55.0

