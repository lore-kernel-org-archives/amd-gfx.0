Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F65DC624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7641010EA8F;
	Mon, 31 Aug 2026 18:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezsrIqHL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DEB10EA88
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1SDMuvmu0nG51yF4EWSr/P/CyKo0YB3lNSX5Y8R2h0QqMqYZfm4u0NU7KjJkyRnDUcAuUSgc6COBuuf5Js98ArzV8RDCpg3cmRe4VVZJObUQG/1JCXuDD2hpsQ6Sl6bSN8s5hQcw3Rj2z4007BmTCmfAbv/NvoCaACQxYWDjp40aRkT3w9/rH+zwmt70/F0T7Pj7TIxkt4yH4sN113p1HTJ5go+rBgtpwbRkQ4L0tvVRHM63jkN+O8BRWmCv4V7F587earcgy2vJOpmr4PMfvSb9Qo3r7ZlefbMumbRVbbYwxET2wmeOEHyVqA5fXybJYJjzWf9GFjpLm9Cp4Vsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9RVj3kR2vcQ5KsAnY2QCDOHdjUaFEuOz1XI/WSSek0=;
 b=ST8xzsGuTg0EsgRAVRpd/mVI2cRlZgJbt2qVuGmeHjgAh1x682YPJlq7+1BhyKfGyUKd4IIkOh1sz8S/FTreb9fq7UeINRF1fmSdib4MR6bJqsJhCiogsO6oI/2e3PmGq31ttRmbK7jF6Enu4RfpnO1RoVwrJn064z46BrfUVWRqmR7IuFx9jMfwUyclFZopY9sI9CqVucjBW/Nrf+39OeUgNWmdy+s9i1UK6+jeAY+6WWue6N3rkLzrkRtkMGpyPfrWIiM1et3CngUMMY+K5w66ZTTAkzGDW0T4oARGMGV2lTljSpfcimX9HI9Z3zT/erCAFG+RPRqvZOjxUnwBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9RVj3kR2vcQ5KsAnY2QCDOHdjUaFEuOz1XI/WSSek0=;
 b=ezsrIqHLJQeFWQrTNzhd2kvx/KFVBnu9dkKQQtnMvBrvM5RdBgkqy9BV2NSTYrJnXca/hHTWzb9oZdzJj3HAhXfReMcLH8hZD5EGW+KJRDhDtVXCngAkQwsBC7GZJqqZHTL4zT/Bo71GB2mc66u50HWFL14/XfDEypT+UR1zDbI=
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:11 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::92) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 75/95] drm/amdgpu: Separate out ualink init sequences
Date: Mon, 31 Aug 2026 14:27:34 -0400
Message-ID: <20260831182754.1089811-76-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 71864822-f334-4b01-bf30-08df078dc062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: W/za0IMEz86oecB4xnpLTHguMn+PRQQEwOaPs32pZhojGeq9MigpJsTJuTekxNBA7oCXn0Jv3p46asC9WiYPtajKSkAeSxl2o+QKu8dQKX003henfhrE+kgY2gHo6zIphfZcjoO5BiQXxkHUkt2P0iqkKWSTPpM0Ck86P2Iw/eVfRutsWL6BMETxqIV/qKzmt8aaxcMkUUzSb8Wn5uNuUD8a1K3TY9mFLKStEp0xZh/TqyVJp/qJcnzZUh1wiotEHFddHe+UuW1WDNlfcKUWth3C8X43osGUPGa0efkPbawU+S79OfT5rqUBhBJn28hWIrKYX8WF51UyC8WiORi00biF2RCZHw2aJoMlUoge2CicNN88U5JL74K3fdJ2tS8Unh0CfC7cfJ5MiWWINkblBwMAAZ83YXo6TAue/lKIG/W728b7MW9nPJqt+gtN0hUOFm5sWIwgdv4bzTsfK4haQpx3z1C43aQIcQGFwV8l/cTphgQKTuZzXMSunCL3jQmjl+NnZtU1tIG+3WhcwI0t1slOpn2Hbr1hOOsmGgL5hn2sgAc/RonHEUIwj0q9reRv5LliAyyegfCXjpxtfVWqFlZUJvMWjAcZpKTCbXo9YTul4eG8zbbZSzy6noMin0lBjONsRePayYunsmtvN59sgJ0CUYD71ypCfLS6p77JLAAdfGjCFPinimYX7FjJNAlTpjlADQngVIdGXfAFnHTMUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nTIRbOAzLspMs+eBzGVlOFvy+nz5Z0nzo0qWd7r3eDErKg4S9xOMuwl3wrouGZ0TY3OxkksX5sFgzkPLno9Tz0PTSbAxERAoSTrmNoKZLLx1SGYV7/JD51/Y7q+xlcaGBpWGsBKYympyfBay67d3syi68a4LCwkKxKNmHNKmTdZw36hXDlZYMmuuaP7Zr6QRHvkwmCWuvgSROBpvwfT4TEFOh8/D1akfvEduxbNDoCaXPAGme55oGSoq7m5LRMAEapeVD7bzZxpJF/+2LnEQzlz5u2hASS4RpwnjgGrHM9L5USnJ0iJ+POLCKytYWbxQzXXMTVW5dlD31Rgw6EkuxFsU3Mwz2nvJkUslk8YJy3yJoOfr/uuwy4dxIom8p/U7gpxzzuFJVBIrL9r+bodVHYc6Y/jhbgPZb1xLNTvHNYi+nr76ucOszq5frX0YtRZV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:10.8929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71864822-f334-4b01-bf30-08df078dc062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 329 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  16 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  23 --
 4 files changed, 202 insertions(+), 176 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 18cfa2dbcc2dc..02c4d6956d6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2459,6 +2459,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_ualink_mgr_sw_init(adev);
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
@@ -2485,6 +2487,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	amdgpu_ualink_mgr_hw_init(adev);
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -2768,6 +2772,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ualink_mgr_late_init(adev);
+
 	r = amdgpu_ras_late_init(adev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_ras_late_init failed %d", r);
@@ -2960,6 +2966,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
+	amdgpu_ualink_mgr_sw_fini(adev);
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
@@ -3729,6 +3737,7 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
 	amdgpu_xcp_sysfs_init(adev);
 	amdgpu_uma_sysfs_init(adev);
 	amdgpu_ptl_sysfs_init(adev);
+	amdgpu_ualink_sysfs_init(adev);
 
 	return r;
 }
@@ -3750,6 +3759,7 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 	amdgpu_xcp_sysfs_fini(adev);
 	amdgpu_uma_sysfs_fini(adev);
 	amdgpu_ptl_sysfs_fini(adev);
+	amdgpu_ualink_sysfs_fini(adev);
 }
 
 static bool
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 0f57a7e2c3341..d24bd447c93cd 100644
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
@@ -451,9 +484,7 @@ static const struct attribute *ualink_info_attrs[] = {
 
 static void ualink_info_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_info *info = to_ualink_info(kobj);
-
-	kfree(info);
+	kfree(to_ualink_info(kobj));
 }
 
 static const struct kobj_type ualink_info_ktype = {
@@ -562,9 +593,7 @@ static const struct attribute *ualink_ppod_setup_attrs[] = {
 
 static void ualink_ppod_setup_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_ppod_setup *setup = to_ualink_ppod_setup(kobj);
-
-	kfree(setup);
+	kfree(to_ualink_ppod_setup(kobj));
 }
 
 static const struct kobj_type ualink_ppod_setup_ktype = {
@@ -902,9 +931,7 @@ static const struct attribute *ualink_vpod_config_attrs[] = {
 
 static void ualink_vpod_config_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_vpod_config *config = to_ualink_vpod_config(kobj);
-
-	kfree(config);
+	kfree(to_ualink_vpod_config(kobj));
 }
 
 static const struct kobj_type ualink_vpod_config_ktype = {
@@ -1024,9 +1051,7 @@ static const struct attribute *ualink_station_config_attrs[] = {
 
 static void ualink_station_config_release(struct kobject *kobj)
 {
-	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
-
-	kfree(stations);
+	kfree(to_ualink_station_config(kobj));
 }
 
 static const struct kobj_type ualink_station_config_ktype = {
@@ -1034,20 +1059,29 @@ static const struct kobj_type ualink_station_config_ktype = {
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
@@ -1055,133 +1089,120 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	info->vpod.id = 0xffffffff;
 	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_MAX;
 
-	r = kobject_init_and_add(&info->kobj, &ualink_info_ktype,
-				 &adev->dev->kobj, "ualink");
+	/*
+	 * Initialize the kobjects here so their lifetime is tied to the UALink
+	 * manager software state. amdgpu_ualink_object_fini() drops the final
+	 * reference via kobject_put().
+	 */
+	kobject_init(&info->kobj, &ualink_info_ktype);
+	kobject_init(&ppod_setup->kobj, &ualink_ppod_setup_ktype);
+	kobject_init(&vpod_config->kobj, &ualink_vpod_config_ktype);
+	kobject_init(&stations->kobj, &ualink_station_config_ktype);
+
+	adev->ualink.info = info;
+	adev->ualink.setup = ppod_setup;
+	adev->ualink.config = vpod_config;
+	adev->ualink.stations = stations;
+
+	r = amdgpu_ualink_init_interrupt(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
+		return r;
+	}
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
-		goto err_put_info;
-	r = sysfs_create_files(&info->kobj, ualink_info_attrs);
+		return r;
+	r = sysfs_create_files(kobj, attrs);
 	if (r)
-		goto err_del_info;
+		kobject_del(kobj);
 
-	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
-	if (!ppod_setup) {
-		r = -ENOMEM;
-		goto err_remove_info_files;
-	}
-	r = kobject_init_and_add(&ppod_setup->kobj, &ualink_ppod_setup_ktype,
-				 &info->kobj, "setup");
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
-		goto err_put_ppod_setup;
+		goto err;
+
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	r = sysfs_create_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
+	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
+			    ualink_ppod_setup_attrs);
 	if (r)
-		goto err_del_ppod_setup;
-#endif
+		goto err_info;
 
-	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
-	if (!vpod_config) {
-		r = -ENOMEM;
-		goto err_remove_ppod_setup_files;
-	}
-	r = kobject_init_and_add(&vpod_config->kobj, &ualink_vpod_config_ktype,
-				 &info->kobj, "config");
+	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
+			    ualink_vpod_config_attrs);
 	if (r)
-		goto err_put_vpod_config;
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	r = sysfs_create_files(&vpod_config->kobj, ualink_vpod_config_attrs);
+		goto err_setup;
+
+	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
+			    "stations", ualink_station_config_attrs);
 	if (r)
-		goto err_del_vpod_config;
-#endif
+		goto err_config;
+#else
+	r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
+			"setup");
+	if (r)
+		goto err_info;
 
-	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
-	if (!stations) {
-		r = -ENOMEM;
-		goto err_remove_vpod_config_files;
-	}
-	r = kobject_init_and_add(&stations->kobj, &ualink_station_config_ktype,
-				 &info->kobj, "stations");
+	r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
+			"config");
 	if (r)
-		goto err_put_stations;
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	r = sysfs_create_files(&stations->kobj, ualink_station_config_attrs);
+		goto err_setup;
+
+	r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
+			"stations");
 	if (r)
-		goto err_del_stations;
+		goto err_config;
 #endif
 
-	adev->ualink.stations = stations;
-	adev->ualink.config = vpod_config;
-	adev->ualink.setup = ppod_setup;
-	adev->ualink.info = info;
-
-	return r;
+	adev->ualink.sysfs_init = true;
+	return 0;
 
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-err_del_stations:
-	kobject_del(&stations->kobj);
-#endif
-err_put_stations:
-	kobject_put(&stations->kobj);
-err_remove_vpod_config_files:
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	sysfs_remove_files(&vpod_config->kobj, ualink_vpod_config_attrs);
-err_del_vpod_config:
-#endif
-	kobject_del(&vpod_config->kobj);
-err_put_vpod_config:
-	kobject_put(&vpod_config->kobj);
-err_remove_ppod_setup_files:
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	sysfs_remove_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
-err_del_ppod_setup:
-#endif
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
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-		sysfs_remove_files(&adev->ualink.stations->kobj,
-				   ualink_station_config_attrs);
-#endif
-		kobject_del(&adev->ualink.stations->kobj);
-		kobject_put(&adev->ualink.stations->kobj);
-		adev->ualink.stations = NULL;
-	}
-	if (adev->ualink.config) {
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-		sysfs_remove_files(&adev->ualink.config->kobj,
-				   ualink_vpod_config_attrs);
-#endif
-		kobject_del(&adev->ualink.config->kobj);
-		kobject_put(&adev->ualink.config->kobj);
-		adev->ualink.config = NULL;
-	}
-	if (adev->ualink.setup) {
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-		sysfs_remove_files(&adev->ualink.setup->kobj,
-				   ualink_ppod_setup_attrs);
-#endif
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
@@ -5406,6 +5427,12 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
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
index d4d4ca0199dc7..90116ed532d16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -113,6 +113,13 @@ enum amdgpu_ualink_addr_mode {
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
@@ -299,6 +306,8 @@ struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
 	struct amdgpu_ualink_station_config *stations;
+	bool sysfs_init;
+	enum amdgpu_ualink_mgr_state mgr_state;
 
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
@@ -366,10 +375,13 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
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

