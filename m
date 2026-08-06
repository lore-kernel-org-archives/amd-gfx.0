Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7F0C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8E510E274;
	Thu,  6 Aug 2026 06:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ol93Gxrl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A2D10E274
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 06:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYpQIYgMdQvotFHMwJQZtaBHAIEtLaNKEf3bVLqy83uKwdZDmtzTE0xDCN2OrAEZKkfq37DWEXpcVL5mMXOiBiecZHiTnBDWBQvKg7/M9YMbUCTnT4PG69UsXGHdan9kk13D6Tbe4ElbYxBvKx3QpZvAFcGX42QQ87XkiwjVfRxMfNWUHsGgcg+6HXAs9vC58bIJilRlgrpAVwdp4FMwaCoZfAlwXDaTDqjx+EKGB+ZT1QBLQbI5rjePeZLMdTT9c8p4yRG9WaKAKqiLue+3jdt6F4UqnxS0CX9ZMdWRyLaCMQQiXplazFWmWRjKDmcUF77e1iIoSMKSznBvPbGQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxP7MXEuqzj29aERXCxVitVGAT3H8qzET9nTZsYgnKs=;
 b=DAhx96sfyOIHZ7g0T49ln9fJHON9cL63+nFIKtkhfFUn1Vw8ZqTCUm9FuyueG4EToXs6zrgwRtZdXnKf1iW4OoPrVK72tEe7FgNyKjx+qtXCz8ilArEjkDj+WiOTywZyFBwPRFflWrCA+zLNMuMokSqCVTDlPlm/wt8xIPTlkB/yVPXSdAmy2oUkozSiPbIf/qtzvYjLMftHhNuC6a5I0ujLEBZd8h8PlJJdGvTlaBl995ULMb2cm/3QAkng+y8wxWtmz0dgT2a9WdKYK194X6UW+tUa2jWJ63b7aFY8i3WZpnC8CeUA0IKmrKlBKXq/yBeXzLkIH69F3msFhr/3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxP7MXEuqzj29aERXCxVitVGAT3H8qzET9nTZsYgnKs=;
 b=Ol93Gxrl0PSlZJwvquzzZ02a2BPGCl/feWz9Vs9q1O9htb4Pnqnb4n9x122T+6tUuIBbremGfZmcIbTk4FYaioAwxOxbOasO91UNmwDZ8oJvzkeJ2rTFDr8lmxkBceX3zuYIk+t+vJ3ujzfwGWyHr0WueqGy11EhKxgpE4Rj3Gg=
Received: from MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 06:14:32 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::10) by MN2PR08CA0020.outlook.office365.com
 (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 06:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 06:14:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 01:14:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Track current PPT limit for restore
Date: Thu, 6 Aug 2026 11:44:13 +0530
Message-ID: <20260806061413.3720389-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5bf01-e083-4563-aa7c-08def381fad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 8kjeplWLgUtdMNFZ4G560miS7DfK8Sl9d/T4UmMrO7Inj2ULX1GPn18Z6BOxlWkPV3m3aGe98cl2kRKaSbYq3sE1zkcWVW82MNAG6rIgDsOmK1Ryg2QZCQVhPBPXkHqSoEzpWJko+eBUhyw4LqRzbu0oJMc7qJWWQ/Wg2MZmxe0zcPpMKQh4MpbcXYjTLg7/Lm7R7+L/jdrYbU7h5jRKoVpO7MTgsODPpsUY2mtCUhhrb7yZdbV8K7iPnl6bQyX9esP0jbbw/GcStmdndL8ztdZRLFA9gdducMHWLIoRnhr5xokDYAW8UZ3coYxkdbclP5pToIO3ryruiPdS1W2zJqjfuiDN0P6STAW6LRQ/ebHYI1KsLb0vLSAPSd8yekSE2ZUGyL2LIru3bBa2xPH8mIERUjl70gqC3s4NEsp7mMOL8iFWD63qZrfze7+vHMRjn48Q1AXp61HF2KyHtw8RLzNVYtw+yTNXjS3S2sHWlIc8MRpUgkR4Z+frZaJZ/b9QLSP3rbjjfqX7sRC3ZbKtFVfE5WbSujLYBtvqwrTSchPziIhlt7jXv43SFkvGS3bTnVya5puftQ3jqAGSU4heKKH4MKnzLWb4yXIp3SHMVpPeDC3LyId9KA8dkuX7XzRHz0pTmvzcRl6gawzDbxA+zUlB72ywvGeWu1VGfdYqQjD3bZWfHHBLickIU9K4om9o3RAnvlCkTnZh8YwISZH/DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tZsUXeQcUvJ4ychV54NSzQDcGo2YOUQaFKz6EaYF5WkZ9bhDLYZIEuudlLFvLIwmjNkTFqM8GwaLybK14IsVfgXTxyUIT6pQZZfnLHVcaqvcGLMBVn1rEVZdTGjzMsDpYIYH87PwV/WDnVSYBN2sC5zJsm7pZbqu9jWEiVIlp2MVZiSLYFFBpt2U+uI+57EWvCpdIeksf6SY5zJr3yI3B1HUB6MIhx/PE6jBj7jTxhcbbjXo5EBHn9DoNw385vdQTy8vHVAi3zvCGq/wqZIRTg1F3AFNCHGJBpLw+/G4+4RCQvTHe/Ysj4o/FRI40h2LejLpd6PMRhHaglPkQiDQa5FPLdFTXiu7mVTEjhnqzQQqeW2gGr4haRhjy70iKeIp7G4jydC/IHS4r2Ct/BVxUbJnSXAv4W7cf8C2TIvrDT8Eet6a416VDEQEO8G3VSQ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:14:31.7634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5bf01-e083-4563-aa7c-08def381fad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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

Cache the applied PPT limit in the ppt limit range and refresh it on
every get and set. Initialize with the default value on fresh load; a
value equal to default is treated as unset.

On suspend or reset recovery, restore the cached current limit when it
differs from the default, falling back to the default otherwise. This
replaces the user-mask based restore, covering limits changed outside
the user profile path as well.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f45cd4e31415..7edd919a7832 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -495,16 +495,11 @@ static void smu_restore_ppt_limits(struct smu_context *smu,
 {
 	enum smu_power_src_type power_source;
 	struct smu_ppt_limit_range *range;
-	uint32_t restore_mask;
 	uint32_t limit;
 	int i, ret;
 
 	power_source = smu->adev->pm.ac_power ?
 		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
-	restore_mask = smu->user_dpm_profile.ppt_limit_user_mask[power_source] &
-		smu->ppt_limits.supported_mask;
-	if (!restore_mask && !restore_defaults)
-		return;
 
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
@@ -512,14 +507,14 @@ static void smu_restore_ppt_limits(struct smu_context *smu,
 		if (!(smu->ppt_limits.supported_mask & BIT(i)))
 			continue;
 
-		if (restore_mask & BIT(i)) {
-			limit = smu->user_dpm_profile.ppt_limits[power_source][i];
-		} else if (restore_defaults) {
-			range = &smu->ppt_limits.range[power_source][i];
+		range = &smu->ppt_limits.range[power_source][i];
+		if (range->current_value &&
+		    range->current_value != range->default_value)
+			limit = range->current_value;
+		else if (restore_defaults)
 			limit = range->default_value;
-		} else {
+		else
 			continue;
-		}
 
 		ret = smu_set_ppt_limit(smu, i, limit);
 		if (ret)
@@ -875,6 +870,21 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	return smu_init_microcode(smu);
 }
 
+static void smu_init_ppt_limits_current(struct smu_context *smu)
+{
+	struct smu_ppt_limit_range *range;
+	int i, j;
+
+	for (i = SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+		for (j = SMU_PPT_LIMIT_PPT0; j < SMU_LIMIT_TYPE_COUNT; j++) {
+			if (!(smu->ppt_limits.supported_mask & BIT(j)))
+				continue;
+			range = &smu->ppt_limits.range[i][j];
+			range->current_value = range->default_value;
+		}
+	}
+}
+
 static int smu_set_default_dpm_table(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1911,6 +1921,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (ret)
 		dev_err(adev->dev, "Error during wbrf init call\n");
 
+	if (!adev->in_suspend && !amdgpu_reset_in_recovery(adev))
+		smu_init_ppt_limits_current(smu);
+
 	return ret;
 }
 
@@ -2999,6 +3012,9 @@ int smu_get_ppt_limit(void *handle,
 	switch (limit_level) {
 	case SMU_PPT_LIMIT_CURRENT:
 		ret = smu_get_asic_ppt_limit(smu, limit_type, limit);
+		if (!ret)
+			smu->ppt_limits.range[power_source][limit_type].current_value =
+				*limit;
 		break;
 	case SMU_PPT_LIMIT_DEFAULT:
 		*limit = smu->ppt_limits.range[power_source][limit_type].default_value;
@@ -3061,6 +3077,7 @@ static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t limit)
 	ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
 	if (ret)
 		return ret;
+	range->current_value = limit;
 	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
 		smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 92658eb3886d..5222b48eba25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -229,6 +229,7 @@ enum smu_ppt_limit_level {
 
 struct smu_ppt_limit_range {
 	uint32_t default_value;
+	uint32_t current_value;
 	uint32_t min;
 	uint32_t max;
 	uint32_t od_min;
-- 
2.49.0

