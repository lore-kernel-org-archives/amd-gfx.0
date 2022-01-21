Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D37910E94E;
	Fri, 21 Jan 2022 07:45:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D423E10E923
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBivYPiXBiW6VS1E2KvGqmqgIUr1msa206oxa71zw4f3hgIOg0In2LJKl1wtQyHP/CX5RY9qspBSrcuV2+yACtC6PIRmf5fupwKIGkuMDpvufCWfvKKRf+OIEy781tvFpjNJs0Jjj0ce0b1CYXmiSmss9+yKNTrzxK22VfZwN1G1Eb6QMgBm4xmLXH2O0eTgkMWJY6rLevFIcgq2my/TFbvgmh7QlfMxOA3sVH0Yu8QeDpP9yupHN6e8ikGJiL2xOdHXS3ChD58RK7FO92vp6b8Fq4i1H6rFovxu0AoM14yv2mRjva3Phs3CYhouK/QX/a9UHVZkdg7WN6GmOAFUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKznW8HWXAKLWV5LQWml5wuKRvzfFEKaGdGoo49kcyg=;
 b=JFoGoZpmkn3qJEffOrtmi++kDNhr8BzMtJidxl5FOwzBxZk6+hcEnkY2VA0u1A0I7CuMpUHlcPDtjm/yDjvzHuZP1kuHflx5ahB7OGK9spfbfIjvxYcH/GzubTvwizBAwXV0xLArhJkFxb97UWtG0hjunHUwZLdW3t7/06I2ohjYviQzFKyv97evlG1pY30fKJ1F14ZbFhK2Awkr7e8Rowg3mX3xY78MLOy6p9pXab+k1xM4kd1AHcN1B996s69U8QMYcoFqUMuxz2noPouQKEvP4axeIYl1HRWVzCIy8XvLooSC7lp8Ht+3rbiKQLmi/F9eUh9IXoJ9hGPXQt14SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKznW8HWXAKLWV5LQWml5wuKRvzfFEKaGdGoo49kcyg=;
 b=jIZ67knFmMpzoGIp765FG1uesxf9XLQxz8G4H7KGAST6t6rifbigy35qbY7KoSmQxLRDfv4vMMb4SCHE4KCWqW1MnZbOnaSVi+LIfD4vazGbOjTOfXG5USH3fZZ8rf+uof6NRP9vn4F8SDHib6gc7l6/Aad4dflf46QzhwsOO2w=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 07:45:17 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::e0) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:16 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:13 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: drop the cache for enabled ppfeatures
Date: Fri, 21 Jan 2022 15:44:41 +0800
Message-ID: <20220121074443.639392-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121074443.639392-1-evan.quan@amd.com>
References: <20220121074443.639392-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a3fbed-7bba-4af8-5bad-08d9dcb1f742
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47480DE5BD89943F2BCB5D4AE45B9@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvvkeJGL4OeMHyh9YPr8sPqKvNULHZxzfyNdHL/Vx8avdiuC01OYjgpYGZRNxD4c6AiftIg5mVttOitlhWimZz7ADE2km+TdkmK1qTDaO73lPF0Sc43vHJ0l1XMGe/sKm9oVVUN/PW4LhR0ICbjDeSiIxKmoaGYfoX+4NBP2Kpe8ffnd7y3mNa9zqur/DPjEESGaD1C1TAsTtIJjFPF9inQ8xCochDD+a9EqbCtDn0vdcykTj3owVdmIHnVgYs2WZJyGnWNorT8AfmNzW0fdKMuL333eXbpu6Kg2JRIXy1xRtKdtd67VQngFKMT/yOWODk4S8oCkyG+ZG5Ws07qkhT9dYH+eFy+rCrV4aT3HobJqezXdittkGG3mxS2MxWAMy+BrFUr/UeuEghYvZFCDeGEkjnHAjdhw4P2aYOB6sTkBixM+T1JdSnDkvPzLEJZtgdcluRg+Ol+f47Wi+cwWaeR3ZGU8behUd5a9adjWWq5v/ii0ubiPqsGrTWgqtCwbu/dJ0CNV1lGLBrllnqJ96LkTWXxQbaVikWW4MN5ujcV5p6R3+Likhp9uEB19etZ7SzIgPI3uwyaxxG+O7v9+n3yc4paenIQFCVOLnPp5eLKTigAKRzxmacGgeoVm2m+Pu2smI6AMqw1GQWyODX63OXn1mGhGPFRsLiikhrALT6VarJ8Ekp6vFDFGfNLpVP24LB8Cdb1wlPbFeGUDlo+vES+nFLIwMyaJduWV8kCH4ddg4pwwRwyKg3nflJwTztZ3SzJg96ieELeBuwe1UTre5BecqRKYbtZMMvO59ZnZEQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(5660300002)(2906002)(54906003)(26005)(44832011)(82310400004)(47076005)(8936002)(508600001)(1076003)(356005)(2616005)(36860700001)(81166007)(30864003)(7696005)(16526019)(336012)(8676002)(4326008)(316002)(83380400001)(36756003)(186003)(70206006)(86362001)(70586007)(6666004)(40460700001)(6916009)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:16.3560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a3fbed-7bba-4af8-5bad-08d9dcb1f742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following scenarios make the driver cache for enabled ppfeatures
outdated and invalid:
  - Other tools interact with PMFW to change the enabled ppfeatures.
  - PMFW may enable/disable some features behind driver's back. E.g.
    for sienna_cichild, on gfxoff entering, PMFW will disable gfx
    related DPM features. All those are performed without driver's
    notice.
Also considering driver does not actually interact with PMFW such
frequently, the benefit brought by such cache is very limited.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I20ed58ab216e930c7a5d223be1eb99146889f2b3
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 +---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 +------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 23 +---------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 16 +------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 46 +++++--------------
 7 files changed, 17 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5aff66103da2..aceb6e56bc6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
-	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
 	mutex_init(&smu->message_lock);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 46496bed5f61..4ba579cdd203 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -389,7 +389,6 @@ struct smu_feature
 {
 	uint32_t feature_num;
 	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
-	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
 };
 
 struct smu_clocks {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b30885f4ca8e..1c76ee25c30b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -798,27 +798,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
-
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-		if (ret)
-			return ret;
-
-		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-			    feature->feature_num);
-	}
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
 int smu_v11_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 478151e72889..96a5b31f708d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1947,27 +1947,13 @@ static int vangogh_get_dpm_clock_table(struct smu_context *smu, struct dpm_clock
 static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
 	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
 						      RLC_STATUS_OFF, NULL);
 
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (!en)
-		return ret;
-
-	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-	if (ret)
-		return ret;
-
-	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-		    feature->feature_num);
-
-	return 0;
+	return ret;
 }
 
 static int vangogh_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index c1caf61c2bbc..dda3f6d685d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -764,27 +764,8 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
-	uint64_t feature_mask;
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					 SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
-
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-		if (ret)
-			return ret;
-
-		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-			    feature->feature_num);
-	}
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
 int smu_v13_0_notify_display_change(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d89e8a03651b..e90387a84cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -195,27 +195,13 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
 
 static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint64_t feature_mask;
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 
-	bitmap_zero(feature->enabled, feature->feature_num);
-
-	if (!en)
-		return ret;
-
-	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
-	if (ret)
-		return ret;
-
-	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-		    feature->feature_num);
-
-	return 0;
+	return ret;
 }
 
 static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ece6ec230a89..905d6ddd7479 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -479,8 +479,8 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
+	uint64_t enabled_features;
 	int feature_id;
 
 	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
@@ -492,9 +492,12 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	WARN_ON(feature_id > feature->feature_num);
+	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
+		return 0;
+	}
 
-	return test_bit(feature_id, feature->enabled);
+	return test_bit(feature_id, (unsigned long *)&enabled_features);
 }
 
 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -527,7 +530,6 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint64_t *feature_mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t *feature_mask_high;
 	uint32_t *feature_mask_low;
@@ -536,13 +538,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	if (!feature_mask)
 		return -EINVAL;
 
-	if (!bitmap_empty(feature->enabled, feature->feature_num)) {
-		bitmap_copy((unsigned long *)feature_mask,
-			     feature->enabled,
-			     feature->feature_num);
-		return 0;
-	}
-
 	feature_mask_low = &((uint32_t *)feature_mask)[0];
 	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
@@ -597,7 +592,6 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
 	if (enabled) {
@@ -611,8 +605,6 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 						  SMU_MSG_EnableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
-		if (ret)
-			return ret;
 	} else {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_DisableSmuFeaturesLow,
@@ -624,17 +616,8 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 						  SMU_MSG_DisableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
-		if (ret)
-			return ret;
 	}
 
-	if (enabled)
-		bitmap_or(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-	else
-		bitmap_andnot(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-
 	return ret;
 }
 
@@ -642,7 +625,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu,
 				enum smu_feature_mask mask,
 				bool enable)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -651,8 +633,6 @@ int smu_cmn_feature_set_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return -EINVAL;
 
-	WARN_ON(feature_id > feature->feature_num);
-
 	return smu_cmn_feature_update_enable_state(smu,
 					       1ULL << feature_id,
 					       enable);
@@ -774,7 +754,6 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	uint64_t features_to_disable = U64_MAX;
 	int skipped_feature_id;
 
@@ -788,15 +767,12 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 		features_to_disable &= ~(1ULL << skipped_feature_id);
 	}
 
-	if (no_hw_disablement) {
-		bitmap_andnot(feature->enabled, feature->enabled,
-				(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
+	if (no_hw_disablement)
 		return 0;
-	} else {
-		return smu_cmn_feature_update_enable_state(smu,
-							   features_to_disable,
-							   0);
-	}
+
+	return smu_cmn_feature_update_enable_state(smu,
+						   features_to_disable,
+						   0);
 }
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
-- 
2.29.0

