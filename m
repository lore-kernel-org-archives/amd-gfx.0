Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12068C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 05:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E4D10E53A;
	Fri, 14 Aug 2026 05:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRFtMS4h";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E4610E53A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 05:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXZUh29XHTAVwOghRAKp7nSAUuvTGFCaMsS4qdiOg5irgx8yU2HM/DrEQvJ+QYecmJv5RvCklpayjnfJyspow0dlTOD0fzvhYgnKo4uLYzktmIStoduVXnXkJ0CqsRWTxfkHBvczZh9jPjqplo76VeX13fj51R2eTuw6EBx/2T1vP0li9xtgHc7o/ejlXz4XNmzdGADsBgZ8o+6zvu4OReODyOqHF3a0fSir8ieTL1/b0AEEtxeu0dC7rinJ0LGa/65WSbrDO5G6nvCv4pmMTK0pyNeqmSOJnIarO+1ZcPqdR5NxDLaL/c59zYdnrPKvDr9q0Mnx2Hs40gCZEiQOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sdMmGeZINiGmzXtgKVSUzsk1LoWPeWuApcXZVwOxxU=;
 b=VlqZxsDjx409vbvnbGx1R7CKr3Adq4VxnSnPajjTr8U3mPjMpv4tm34V2gk2b6TxexESA8DwShqSjEf2goeWhnZ13zAGFuqpnfVz+Wc+7Egr87zg+66wYvDFtDyjifS+Sdw59PnoP0Jnc4VxWoSfMs5Vxg2vNJGlKauOR0KLgll3IKF7BbDmQtQsnsX5iM4fhIFACovm2aZcjwWYH0HE5Y/atrj5f4AJarhmrzb7BhQLEbcYW4I4R0ZPGv0fi26m/bJkVyp/DopjI5DxA/gFPLlO2xnQykZOd4Jd3z2smK/dRoRGKbk9sWDzjOQiR8Vpt6dmNNFjn6LlKjQzjbq4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sdMmGeZINiGmzXtgKVSUzsk1LoWPeWuApcXZVwOxxU=;
 b=RRFtMS4hdFRtDVaPsc1xPaZoEZrW1B9daQ0yi8tvLa0wP0UJny0OaZ6z+a9N/1iU1dAb2o820TTYOlTUlZX3ep4C72WfoOHzNTo9Znyl39FioaQqBGlpnsHyQ2jzBnik9JBKLHphDgOk5jN8QSCjlFMhRoB/Sj8hI/yxu7lGoO8=
Received: from CH0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:610:77::18)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 05:29:01 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::46) by CH0PR04CA0043.outlook.office365.com
 (2603:10b6:610:77::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 05:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 05:29:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 00:28:58 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: Snapshot PPT limits for suspend and reset recovery
Date: Fri, 14 Aug 2026 13:28:48 +0800
Message-ID: <20260814052848.1293509-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 362516eb-7919-4414-d2e0-08def9c4f206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: nT6mWU3j+KhKWmmBU9OOnd/NLCM4CVPBT6Jqtxhiguwl4Ddez0Xbe/ej5C3lPs4/f5ANnlWb4c+4EmUzoe5Jyn9tbA5SPgo3k3oW+3jWCWMiciPCPsBOA9R83/M8c0Scgd1X51iENVsoInNys/94sa9b7PsgFamIeOrru+1FZGCdmC8AVXyqHODqnjy9imHuEMIioDxlhicwFfSWJ1CB6wNI93382I+XXOhhRR8lpspCYGoxxE8ZKsJLVtzxgRF/aJaY/811lFxcMqAAHMX1XM80mQlxoMK5w5KSVwzxslkiinSe06T59l0UiSuIrFu8wuF4m+BedrlTOZjmIXHgkAakNjW2mgmQR93QxM2Lh/tSU/WPPKZIKtX/+3OwxZOAF+zYbAZc/FYOEp+hHduCmn+dqsLY57oCO4NPHfKjNQBCj3Fm71k2gcM1HW2JDW98G8iWaWA6O1tHt3q+7VtdZimO0wz0RotTe0jNyhAI3iBPp/IzPaiYL8te+T0aqoZZhxIWGrdCUKVVcBdbkUU064Sj7ffIrIVWlZU+Op6iwbSBVTblnRg/jOOoZ/vL3P9JnAxGi/1fm3s4N09C3yWA5+E1Rx8iahsnIQN/+csl1pL6xbKBj9lg4dwhBKV3cSUOb79rmxbPbJ+BLiToIXy09rGysXkXv2zkiI99ERJjIkv3oiZZ0j53FpfKr7VT2EIsVSPTHTOrC2kyjilNKC13wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hUpaz9VXMaLIMwT/Jv4QD/BAGTXB6EAFMgr/V0iYrYi6v/ZhPJ0UkYZVxgxUrA1Tr+DUMFhgwvBPbxJFvCdMSgASbjeiN2+iTF8cSVrb9iiTaPFA0TsscXMITFhSTae4Wv+0QYUawuIwp6+GlxzI5l76cc7nZIMLqxhidEhzrmBWH1JigAqfadfeNcsWxzTneIRuWs+O5EK7jkHvjGlzaSHWSOWFDZzWT3doNj9Ua5/CESauLtcVTKKx3TYIfZqLLICFcWgQXEZ3sEwwqS9Z6ELi1QGQ13a6BEEYwEqrAUdliIOmnu+u40ZNY7AOZ8S56LAajRdtcNRD6jiy0KZODy4nARoLzWqE90OW6AqSrqkEhJCZhaktdEtsu+nB46BOkawLJ/M2SQHrkLxS2pcZTzayhPd32nFWpskYAWSG+G4VpFF0D/NB27xacuAw4Kwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 05:29:00.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362516eb-7919-4414-d2e0-08def9c4f206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
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

The DPM user profile records driver-programmed policy, not the effective
PMFW limits. Replaying it after recovery can restore stale policy.

Maintain a PMFW PPT snapshot:
- Query supported PPT controllers before suspend and mode1 reset.
- Save successful queries with the current OS AC/DC source.
- Clear the selected source mask before capture to prevent stale replay.
- Refresh the OS power source before recovery.
- Synchronize the current source with PMFW before restoring PPT limits.
- Restore PPT limits only when the snapshot source still matches.
- Do not replay PPT policy on normal AC/DC changes.

Capture reset state before DPM and PMFW teardown.
Add debug logging for the snapshot, restore order, and PMFW AC/DC sync.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 152 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   8 +-
 3 files changed, 117 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index ce526db4d24a..c3688b3b12cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 			amdgpu_dpm_notify_ac_dc(adev);
 
 		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+			smu_set_ac_dc(adev->powerplay.pp_handle);
 
 		mutex_unlock(&adev->pm.mutex);
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bfe2c0bf426d..e5cb8d0420ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -489,44 +489,122 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 		return;
 }
 
-static void smu_restore_ppt_limits(struct smu_context *smu,
-				   bool restore_defaults)
+static void smu_save_ppt_limits(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	enum smu_power_src_type power_source;
-	struct smu_ppt_limit_range *range;
-	uint32_t restore_mask;
-	uint32_t limit;
+	u32 limit;
 	int i, ret;
 
-	power_source = smu->adev->pm.ac_power ?
+	/* AC/DC is maintained by the OS and driver power-source events. */
+	smu->ppt_limits.saved_ac_power = adev->pm.ac_power;
+	power_source = adev->pm.ac_power ?
 		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
-	restore_mask = smu->user_dpm_profile.ppt_limit_user_mask[power_source] &
-		smu->ppt_limits.supported_mask;
-	if (!restore_mask && !restore_defaults)
-		return;
-
-	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
+	smu->ppt_limits.saved_mask[power_source] = 0;
+	dev_dbg(adev->dev, "PPT snapshot: source=%s\n",
+		adev->pm.ac_power ? "AC" : "DC");
 
 	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
 		if (!(smu->ppt_limits.supported_mask & BIT(i)))
 			continue;
 
-		if (restore_mask & BIT(i)) {
-			limit = smu->user_dpm_profile.ppt_limits[power_source][i];
-		} else if (restore_defaults) {
-			range = &smu->ppt_limits.range[power_source][i];
-			limit = range->default_value;
-		} else {
+		ret = smu_get_asic_ppt_limit(smu, i, &limit);
+		if (ret) {
+			dev_err(adev->dev,
+				"Failed to save PPT%d limit: %d\n", i, ret);
 			continue;
 		}
 
+		smu->ppt_limits.saved_values[power_source][i] = limit;
+		smu->ppt_limits.saved_mask[power_source] |= BIT(i);
+		dev_dbg(adev->dev, "PPT%d snapshot: source=%s limit=%u\n",
+			i, adev->pm.ac_power ? "AC" : "DC", limit);
+	}
+
+	dev_dbg(adev->dev, "PPT snapshot complete: source=%s mask=%#x\n",
+		adev->pm.ac_power ? "AC" : "DC",
+		smu->ppt_limits.saved_mask[power_source]);
+}
+
+static int smu_restore_ac_dc(struct smu_context *smu, u32 *restore_mask)
+{
+	struct amdgpu_device *adev = smu->adev;
+	enum smu_power_src_type current_source;
+	enum smu_power_src_type saved_source;
+
+	*restore_mask = 0;
+
+	if (adev->in_suspend || amdgpu_reset_in_recovery(adev)) {
+		/* The power source may change while the device is suspended. */
+		adev->pm.ac_power = power_supply_is_system_supplied() > 0;
+		current_source = adev->pm.ac_power ?
+			SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+		saved_source = smu->ppt_limits.saved_ac_power ?
+			SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+		*restore_mask = smu->ppt_limits.saved_mask[saved_source] &
+			smu->ppt_limits.supported_mask;
+		dev_dbg(adev->dev,
+			"PPT restore: saved source=%s mask=%#x, current source=%s\n",
+			smu->ppt_limits.saved_ac_power ? "AC" : "DC",
+			*restore_mask, adev->pm.ac_power ? "AC" : "DC");
+		/*
+		 * A snapshot is valid only for the source under which it was
+		 * captured. Do not replay an AC snapshot after switching to DC,
+		 * or vice versa. The current OS power source takes precedence.
+		 */
+		if (current_source != saved_source) {
+			dev_dbg(adev->dev,
+				"Discard PPT snapshot after source change: %s to %s\n",
+				smu->ppt_limits.saved_ac_power ? "AC" : "DC",
+				adev->pm.ac_power ? "AC" : "DC");
+			*restore_mask = 0;
+		}
+	}
+
+	/*
+	 * NOTE: Synchronize PMFW with the OS AC/DC source before restoring PPT
+	 * limits so both sides use the same power policy. GPIO-controlled
+	 * platforms perform the synchronization in PMFW.
+	 */
+	return smu_set_ac_dc(smu);
+}
+
+static int smu_restore_ppt_limits(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	enum smu_power_src_type power_source;
+	u32 restore_mask;
+	u32 limit;
+	int i, ret;
+
+	ret = smu_restore_ac_dc(smu, &restore_mask);
+	if (ret)
+		return ret;
+	if (!restore_mask)
+		return 0;
+
+	power_source = adev->pm.ac_power ?
+		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+
+	dev_dbg(adev->dev, "PPT restore: source=%s mask=%#x\n",
+		adev->pm.ac_power ? "AC" : "DC", restore_mask);
+
+	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
+		if (!(restore_mask & BIT(i)))
+			continue;
+
+		limit = smu->ppt_limits.saved_values[power_source][i];
 		ret = smu_set_ppt_limit(smu, i, limit);
 		if (ret)
-			dev_err(smu->adev->dev,
+			dev_err(adev->dev,
 				"Failed to restore PPT%d limit: %d\n", i, ret);
+		else
+			dev_dbg(adev->dev,
+				"PPT%d restored: source=%s limit=%u\n", i,
+				adev->pm.ac_power ? "AC" : "DC", limit);
 	}
 
-	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
+	return 0;
 }
 
 /**
@@ -954,15 +1032,9 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
-	/*
-	 * Explicitly notify PMFW the power mode the system in. Since
-	 * the PMFW may boot the ASIC with a different mode.
-	 * For those supporting ACDC switch via gpio, PMFW will
-	 * handle the switch automatically. Driver involvement
-	 * is unnecessary.
-	 */
-	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
-	smu_set_ac_dc(smu, false);
+	ret = smu_restore_ppt_limits(smu);
+	if (ret)
+		return ret;
 
 	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
@@ -997,8 +1069,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
-	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
-		smu_restore_ppt_limits(smu, false);
 	smu_restore_dpm_user_profile(smu);
 
 	return 0;
@@ -2202,6 +2272,9 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!smu->pm_enabled)
 		return 0;
 
+	if (amdgpu_in_reset(adev))
+		smu_save_ppt_limits(smu);
+
 	adev->pm.dpm_enabled = false;
 
 	ret = smu_smc_hw_cleanup(smu);
@@ -2263,6 +2336,8 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	if (!smu->pm_enabled)
 		return 0;
 
+	smu_save_ppt_limits(smu);
+
 	adev->pm.dpm_enabled = false;
 
 	ret = smu_smc_hw_cleanup(smu);
@@ -2778,7 +2853,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 	return smu_set_watermarks_table(smu, clock_ranges);
 }
 
-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
+int smu_set_ac_dc(struct smu_context *smu)
 {
 	int ret = 0;
 
@@ -2796,11 +2871,12 @@ int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
 				smu->adev->pm.ac_power ? "AC" : "DC");
 			return ret;
 		}
+	} else {
+		dev_dbg(smu->adev->dev,
+			"PMFW controls %s mode through GPIO\n",
+			smu->adev->pm.ac_power ? "AC" : "DC");
 	}
 
-	if (restore_ppt_policy)
-		smu_restore_ppt_limits(smu, true);
-
 	return 0;
 }
 
@@ -3057,12 +3133,6 @@ static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t limit)
 	ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
 	if (ret)
 		return ret;
-	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
-		smu->user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
-		smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
-			BIT(limit_type);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d30951121e1f..9f85b302060e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -238,6 +238,10 @@ struct smu_ppt_limit_range {
 struct smu_ppt_limit_context {
 	struct smu_ppt_limit_range
 		range[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
+	/* PMFW state saved before suspend or mode1 reset. */
+	u32 saved_values[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
+	u32 saved_mask[SMU_POWER_SOURCE_COUNT];
+	bool saved_ac_power;
 	uint32_t supported_mask;
 };
 
@@ -251,8 +255,6 @@ enum smu_memory_pool_size {
 
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
-	uint32_t ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
-	uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
 	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
@@ -1954,7 +1956,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
 
-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
+int smu_set_ac_dc(struct smu_context *smu);
 
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
 			   enum pp_xgmi_plpd_mode mode);
-- 
2.54.0

