Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE81C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171BC6E0A2;
	Wed,  8 Dec 2021 02:37:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214056E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6EOERsoJMGHknA9rNdWBqbu33NOnxro7yqmmOHg3TEAmL7LQAFyCK5UhMMH9h7jul+0eC71mTgK9gRghCsVPsKa/KYHLLMFLUm/PNXcicrgiUxCfLzkkGg6gesG/AlUAMRwOSuGxef8z9zO/Wteqcm434JKAmzrEuuyejsO24+FurRPrTDXJQVVFHfzLsOGBcqrhkUitibzSkBBo/FtCZeIyccMzVUj4zJdo75m8OjgUtrPwehL6FukE95Koe4DY4h83mMLRDUzwHyJ86K2hQoZqgu8x/12q3E2s+0TrM02cfSbWcRQXsSp6Fx1KhIZ/HFPLYmefWf66UbbtF+8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXb9YsSvJzHGHLEkKCoi1EQFcBZAbPfKR0jXtH2x6D4=;
 b=J/k7Xra4gtHCilXecUV6Sj5Ab5eNZEIjDWnTCGH+1SpY07BoHJrUC1qj3GGGJhCe9GppZ6XhKZg3CeL8toCavDVyKdB9eRwoUq4Qlsxp+xZdKSIKljNbaglXoVbb6s0eZeN3hi5qeZFObdHGffY2r7cc8BjU0eW00ufeEWMB1y/Uq3Qp64rs7PdTR8deywKowNH7koF0msVQFFF5w2HmZ9SUna6ddHKvNhpWNEMPdm3GSU1iEsWbefdnDOzWUGEknin0rgOg6rh3bsT3y223kfcDz5/8zDDHZwQE/kB3t8ee7cr0TpjHEGK6FvYJMpURFRl1n91qv6bkMoxVcq9naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXb9YsSvJzHGHLEkKCoi1EQFcBZAbPfKR0jXtH2x6D4=;
 b=ZM3OiEKWPp7ShvWU8M4T0UhvEGkLJTDBfcwq2lID4HdJX8VRxzvVUAz4FdGu37vJmawMXDiQZoFti5wuq2i80r+gaYXTvCjW2Tn6kfSUWITCRD/P5jKg17HnFC8tGqNzQOzVlEYGw0hYyuE0v+fidUx1NbFKtqamA82E52Prz/g=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 02:37:46 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e4) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:42 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/pm: drop unneeded feature->mutex
Date: Wed, 8 Dec 2021 10:37:06 +0800
Message-ID: <20211208023707.1814122-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a7d459d-2ee6-4e65-5d9e-08d9b9f3b766
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB536390F399D172C094C6BE58E46F9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPfvcOCy7hdeglsyMS6O7Zqab7b9cLE41bLKCM+hujTbCuhY84xNfZlAnc8gT8HAP3WxFS1jegIocqU+MxT5tVqrAL+WZ2X3pbzKTmfy/h+ZqtJMHGo1wEC+73JC2UJQC+oGQOFKz7wSITD0BmlnT2frSbdKZlnnGhcvHjuYfi9lkp/EEr2i6VmKHnic+jFzwpgqa7wlT+A/Harb3ClU3pr7VVfQ8BEXV4jWUZVsc2e3UPzSX1b8g7ggvOGjLVF9/ucJxtzFcgEa9f/EBpSX8zSvmalVW6PNM0ZJsmv8aMvL81aCQbkXFmG5BTJUz3x6KUC0lbEaFlC/fYlDziKABHLcAQZGcKdDHxnITlNhIIZQz0hhppUcSaSHC+22J5CmbrbwhQmiyidETZz0PUxEx/wZ+f7zO8UvlKamkf8lR4QwYM/XVaxqyh/0sebn93yfFcsfP6uUzyCtJc5l6zPQVmhmW6f/LjERMvdzfmhzLDC/6Eu/raIlmvzOWLEW0okPR8otm/+xzYQPwH3f6kCRVNIWJwbtdHsqCh9p6tWOYrOm2+souXJ1cU+64wwrRLtzm9sQRpLR3fQpq1c3UkhQnKFPyAg5KWZ6YW3kABJn61Acn7W4DQREn5qJ8OvY5CVmpdzWmOUygYhAoir/nf8ccECoKyeR/ZUzTtdVYlRMbvpUrrtOjXSRf4DjFClKljqUtfRPREmE6ec1pCH4PSlkHZ352jCCnASr/XpAS4xesWxBtJyA6BN9PQHjxOnAJdzeSRZk3qtvQac2HrzeFbvgtyaLk3g/Rr7Fpw/JO/QoP1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(16526019)(83380400001)(26005)(70206006)(5660300002)(4326008)(508600001)(36860700001)(44832011)(316002)(36756003)(70586007)(1076003)(6916009)(426003)(6666004)(8676002)(54906003)(2616005)(2906002)(82310400004)(81166007)(336012)(47076005)(8936002)(40460700001)(86362001)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:45.3009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d459d-2ee6-4e65-5d9e-08d9b9f3b766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As all those related APIs are already well protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia2c752ff22e8f23601484f48b66151cfda8c01b5
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 20 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 19 ++----------------
 4 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 81ecbeae18cd..c35a82178dec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
-	mutex_init(&smu->smu_feature.mutex);
 	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 313266e4ab13..1ed096584a25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -391,7 +391,6 @@ struct smu_feature
 	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
-	struct mutex mutex;
 };
 
 struct smu_clocks {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1635916be851..ec9081918875 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -717,25 +717,21 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	mutex_lock(&feature->mutex);
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
-		goto failed;
+	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	    feature->feature_num < 64)
+		return -EINVAL;
 
 	bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
 	if (ret)
-		goto failed;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
-					      feature_mask[0], NULL);
-	if (ret)
-		goto failed;
+		return ret;
 
-failed:
-	mutex_unlock(&feature->mutex);
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetAllowedFeaturesMaskLow,
+					       feature_mask[0],
+					       NULL);
 }
 
 int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 289aa77ba7bd..32c571e0dd3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -459,7 +459,6 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
-	int ret = 0;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
 						    CMN2ASIC_MAPPING_FEATURE,
@@ -469,11 +468,7 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 
 	WARN_ON(feature_id > feature->feature_num);
 
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->supported);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
+	return test_bit(feature_id, feature->supported);
 }
 
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
@@ -482,7 +477,6 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	int feature_id;
-	int ret = 0;
 
 	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
 		return 1;
@@ -495,11 +489,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 
 	WARN_ON(feature_id > feature->feature_num);
 
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->enabled);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
+	return test_bit(feature_id, feature->enabled);
 }
 
 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -644,14 +634,12 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 			return ret;
 	}
 
-	mutex_lock(&feature->mutex);
 	if (enabled)
 		bitmap_or(feature->enabled, feature->enabled,
 				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
 	else
 		bitmap_andnot(feature->enabled, feature->enabled,
 				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-	mutex_unlock(&feature->mutex);
 
 	return ret;
 }
@@ -821,11 +809,8 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 	}
 
 	if (no_hw_disablement) {
-		mutex_lock(&feature->mutex);
 		bitmap_andnot(feature->enabled, feature->enabled,
 				(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
-		mutex_unlock(&feature->mutex);
-
 		return 0;
 	} else {
 		return smu_cmn_feature_update_enable_state(smu,
-- 
2.29.0

