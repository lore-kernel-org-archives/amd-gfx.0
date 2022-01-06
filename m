Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30262C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59F41122CA;
	Thu,  6 Jan 2022 05:58:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84011122CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKOG+VNyqWvOaETQC46Gv3rbOq4gzeuqGzG+DesMvG7C8bn26I8UeXAjsHULkC5TtnBdTihLGmfVtdsKYAt6A5VNJcc0WKcVIRxoQvkR10DyFHn4xloEMGoVTlSGJ4TDE3uWlbQ0xQtCRBBGdwRP8vY4j9ZfT6cX7XyZYD6fz1raXUossD3pPdmc1ERBvDF/LXTobY5MafkZEjPqce6Uq7sAD2tOyiXmTPyIiNvtBgpKzyISs8p3Pmy3hqpYAgIQO5sAjiZzTV/mRneZlTTJP42nTHG+kK07bajGBwfrywSdULC+DirsZ8Yth+rYWNH4E3MxJeg+t9icI3/I6d5loA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CFoBmNeCmmdHoh9dy+Fe+Y84SFCeLL7MLGvrzv7SaI=;
 b=U1rRLtmU+lWQ7p8AJwiLtEH+tBJf0q5OXGNhstMNGuwyQ5cnpnqp7tg3rQ9xiavGcGy8CBDfCunB6pmD5Twv/GcOb09xQK3Pu0LHkqpOaCQZivS1JL3WFBFwg6ctvALhhn2HuJj17nE//0hz+EXzg9OQ3lV3BwxlWYmhFOeJotsQaHB3e8q76Le23IVKkKUPWjivj4qo0TU5Vx5K/i9LyaYDk7yHDRg1krIvGRT8irsGlpjxXneQ7WonYd8SSnicgvqNgVnoIOXvWeCWtKfDk0pzHqu4wWgSaGJfymOpT0/ufeh4U6uHuCqh9+apihjv8po83ajAi1hquaRWhp5rdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CFoBmNeCmmdHoh9dy+Fe+Y84SFCeLL7MLGvrzv7SaI=;
 b=hJ67PvwVuRqNOVLGHbawZ54FowleM3KjdXEQqrGI7sCc8uy40IOPySiz/531m2UtQLGq+f/t54RQZfSLVHBW1R33OPqoo/yNJOcX4vj7tOskOK43WDUO0sCgG4c+oVPxq/6bszHSJ6YLZSqNwojRQFhAaO17XLr1FxyK00niIqg=
Received: from BN9PR03CA0404.namprd03.prod.outlook.com (2603:10b6:408:111::19)
 by SN1PR12MB2464.namprd12.prod.outlook.com (2603:10b6:802:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 05:58:02 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::e7) by BN9PR03CA0404.outlook.office365.com
 (2603:10b6:408:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 05:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 05:58:01 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:59 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/pm: drop unneeded feature->mutex
Date: Thu, 6 Jan 2022 13:57:31 +0800
Message-ID: <20220106055732.3073780-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220106055732.3073780-1-evan.quan@amd.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87c0b75-292d-4999-290c-08d9d0d97fba
X-MS-TrafficTypeDiagnostic: SN1PR12MB2464:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2464098E33EA07AC746C83B9E44C9@SN1PR12MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTVVrUFWf/8c1uADQjb9GUkYwaNaVnsQbeWIT1VEdci4LjUR9q+Fxhmc0Wy+3LvYLU2XwAhRh7HCxtBrUL5gohuMIMKShbB36amKP+we8c3diDmZmHh/Ywb4p+aAZzM5PlKrD1Buwd1P1GfyCRDxPtyhjI5Umsv4KVf7l9iCKrHWJ05wxNCB+0iguJY7IqNJ+GZnih+JhGYuEcQa4SsSsI2+t2tlkFXAHMXPJwiiKWPkbzG84xWHF+LAYl6zNAQ0VRogJkPZitgaM2O2wgGc+dTfiHovQLfRpiXcleTCD7ynqx7jRVsh9Zulli+4MDcXhAsG78AhSPmp/iB8PAYm6syee32htjF3fEmFbdEddfXrg1IPH7VlzfXX8KaI4yeDSJcCv2GujiYZNCyEhZ9nCYGuDwNccOdcZL63BSgAeKvf8uJqjcjy9ELlzRSr0OrUJ3NfPCdlSuIu41U8HwjNvIAWc/MSFXmDSZWp6JufqFGCmB48Q7uBuRaL3Af3hO4c+NtJoUwVEJP52Cy3nl8j3x+8TOxF6KrjID/bxMPLtgNCz+QgEOIV0D8O75EOkFXZFuxxXhGTVMFQrjgZ/TYLzvMPhtrhC5qM10q+sbCGriCFV7J1bzZv31wGnwLkm9/Az3L68Rt/rcwluwU/5zibbYNN/+4rZxSrKjle6ZGbc+jC69gtREtCxRwy2tdug7NtzNtn4kbVToKqI1YO7VK7R5FWohsUNglrDrDR996tsKNBshsftmkfo+IJV+lwcHB6wUlz1D1hgDkKupfgY/VCC2LvRs/JZweGo4K7sDmsAZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(54906003)(36860700001)(4326008)(40460700001)(2906002)(47076005)(82310400004)(508600001)(6666004)(336012)(16526019)(186003)(26005)(8676002)(44832011)(70586007)(7696005)(8936002)(2616005)(426003)(70206006)(86362001)(83380400001)(1076003)(6916009)(36756003)(356005)(316002)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:58:01.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87c0b75-292d-4999-290c-08d9d0d97fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2464
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
index 0b9c67743714..1c8d4cb4e791 100644
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
index 79b2a817491c..18f24db7d202 100644
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
index f66d8b9135ca..9b439066a08b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -722,25 +722,21 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
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
index d78e4f689a2a..fcead7c6ca7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -481,7 +481,6 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
-	int ret = 0;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
 						    CMN2ASIC_MAPPING_FEATURE,
@@ -491,11 +490,7 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 
 	WARN_ON(feature_id > feature->feature_num);
 
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->supported);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
+	return test_bit(feature_id, feature->supported);
 }
 
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
@@ -504,7 +499,6 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	int feature_id;
-	int ret = 0;
 
 	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
 		return 1;
@@ -517,11 +511,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 
 	WARN_ON(feature_id > feature->feature_num);
 
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->enabled);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
+	return test_bit(feature_id, feature->enabled);
 }
 
 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -666,14 +656,12 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
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
@@ -843,11 +831,8 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
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

