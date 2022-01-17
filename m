Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CECC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A100210EBFE;
	Mon, 17 Jan 2022 05:42:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8145C10EBF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwpi/uMX5EQ1kjqTi6J9KNPxjY1S1Dkx2J5meh7591QDhO5h1KptOMiWFFiaPYyZYP6Onyl/n78zb5byRY5LrVKJum6CtNZJDOowo1xQRXEG+je6PO5BccFLfXbE8d83wMvVq9q6HN6HdAZ9FSJZBjIZZv8SmfCTBNZcdjABoLh0KcW/qrTYwG9de08oqfWjDZVzk0eivLY5aSEqeFKzgQqoqAZiqWWxH4+d7ZJHGeTJeSimzuWxedI2jYMR6XClAWoyu9in6+tvWphh2fT47X1NUEkbvW+TvS3iDk38D50EHdcFlKTUdEcrVsp7Nz3TRXjgDA6NMtbHdfa+juab8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWaiiyjIAeuDD4ZmMRg5jNfjQJMDucjd/H7syf1e9YU=;
 b=dVcf+dMzSEkJ+TDbfGcUAWMK1jq4tcKLHauNHEna48T0DnfovPHt6fskvnjlewhYgh7ZGyLhsmdFNzMDjcw8cFmpkK4lDWVG8L95BYncpxqf31G2fkK4XCij6qBtuMZhtQus04B0HZnlW0upxoAk3rS1we3/d7dX9IgY/JiF1AXxU6b6jMrw55q9KZ+fb/aS6rZXrmRPC7uYIbTiZOj1ySCQU98DBpBw0Di6WNUz5EppgxgbclvzlPB1qN5RzekS5YlsbcB+XhOoKptfT5duLKq/LHMhoPM7yDT7PYc/ld+02TyFzsEVjzQ96Udcki3OfGe/AlTb8jZFmm4Gwacphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWaiiyjIAeuDD4ZmMRg5jNfjQJMDucjd/H7syf1e9YU=;
 b=yeTOMMF8Q3NvF2MNM1dvcyA+cUlKSVB8abY0WkqKwvjaJzHfh7iwxSZG2eOIM1V+ILoXCzW4wTEelbPze7oLIPJPT4UOk2S1F1MCly2yV25UQL3oLfq0gyEtyZGq4xMLt/8FfezeX8WWRwvsD/FDBgo+8vLVcX8niIT4jrTXs3w=
Received: from BN6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:404:10a::16)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 05:42:35 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::7a) by BN6PR13CA0006.outlook.office365.com
 (2603:10b6:404:10a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.6 via Frontend
 Transport; Mon, 17 Jan 2022 05:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 05:42:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 16 Jan
 2022 23:42:33 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/7] drm/amd/pm: drop unneeded feature->mutex
Date: Mon, 17 Jan 2022 13:41:50 +0800
Message-ID: <20220117054151.124838-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220117054151.124838-1-evan.quan@amd.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c30de883-e238-4e21-94e2-08d9d97c2a24
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055A9B13CCDFDF47BD84E83E4579@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoDkAdqTiLqHXaEaDeJsPa3y++0Eeqv2IWYG6kAYgH11Zi0GdaCXw4WOFoOhO2No+PtcD58pJSZIwb6lKXs0hl9cJBrO8HgSMLd1Gj0+0UvIL/8SZ4VJ1zZYlHX1myY2w/EyUSluSLaFl9LQjVqR/rMUfvGZGjayd2C0RPPl7s/w/96ZFqVKKJ8nkGho1BM0pHeNA0gkPZLLZvAm4SfT9179Gl3fa7RCeg0fSJOhfBWoXed7vpXpgehnCwG4ujl887a2hb97KSOHF/dxrds1CrebrWlUhlo2Z0CyGGw4agzoBOJZT8orM9UanXHrwMuBgI2LPTVZEAIyTLH6Q2pUAO1+1ODU0Mq35iVhisSgxEkJQRGMbD6Pw8SMaavQLgwGXI1avaGpV3ScqJHFj/VwyVXu0Z5eL9TfUsM3Kg8UIRrikCip/k/gsf3hku8mkin+Rj2idpLtsDb0BNIA0+Q7B3AUUhWkZPKa4YQJyTysslXkDXD9UczCNz5oDK4CoXKKCQ8RbX/MdIp2QW6tyLk0I/+UFVip9OQ++ADKMShthAya/iaG5qbwwtQxdOvmSJtmNXemZhq45nFcLMDKjFsQDk+SwSNvBafNQKD/+4Cu/Fg+VReE6nVwrWi1h/Nr3XSaYcsud0aywa2FXcRtqxLSvWr5vfIf5UzZ/7fueQTkamPJXZyHo9dDtMuU/zzURL8fVXJ6wINbiApxJT+shCem4QH/n2XJtns6LfvEGmAyKHUR0uWxGSCzbHnsgQlzbbs2zX8BpcYyLyC6AwcuLYlQ892/Dv7ykcuOIqeH1TUgOcM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(426003)(316002)(4326008)(36756003)(8936002)(8676002)(86362001)(36860700001)(6666004)(2616005)(54906003)(16526019)(1076003)(26005)(81166007)(2906002)(6916009)(44832011)(336012)(47076005)(70586007)(7696005)(5660300002)(40460700001)(508600001)(70206006)(83380400001)(356005)(186003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 05:42:35.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30de883-e238-4e21-94e2-08d9d97c2a24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
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
index 7cc3886ddee4..198c2ac7b04d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -948,7 +948,6 @@ static int smu_sw_init(void *handle)
 
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

