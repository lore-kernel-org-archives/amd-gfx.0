Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42AC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0492C61059
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0492C61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A421E6EA99;
	Tue,  8 Jun 2021 04:35:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1DA6EA99
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaFq0qIIbNHQ2BopJrzqGrkwrCy8EURbVLBrsv0EEme15rzYcVo6DHX1ANgKGENorW+cF5DL4t+m45/7ibZDfD+KsRjZhe9TTaTDmLVAKwG1d3NYKr4PcpPqd1hwKgEJ9Jn96x31aH41nNa2MBbG15OoandTvcJE8nyQkY6Ai3aXTN0/HFodT2f+eZjoeAAb8lPpBj8uKSE5HBzvXvtV0I1dRqpGo1DVLP+jluZryPBpGGn44ttR/pcFTyLx7M5BEM0HTezWh3ei+p4wDWkeibWSqcrt5skJUIg9XO29ylO6bex9x2u/0PvgMER6mqef2+374fTUgXgjcS2r+NJCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C59MYBVUMOnii/iQ5eqSqg54CnuGnK4zmX5jHbkUdQE=;
 b=T8vMylryK/6ywR4MbQlXhL759xtAJiXAnGGb3yeGtJHOwOp8Q56i217R38q6a+WRs/TaNoQRFtMdkB5JGCan5050Djz7fFM056Bi1glF6eYxpQo/39euLaxxFtOoGpJTHjMFfNLWJNFmtRg+3QPZgU4Kz2OvUBuPMM7/eiqYUWDljUFPQvQyCm8C4CHpND3kA18qzQ8L5bkav2JWd8xuS28I1jvVxbN33jqkFx2LVC1tz/5pW3m9iwEwVNqm+6lGkxYRQj4I1sR3F5UZ/p2pwdabD4b2R9NWgce3SwNJpKZrNctcxquPr6fwIqZ7EhUeqEm7O7bu7Auoeq6iVpJcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C59MYBVUMOnii/iQ5eqSqg54CnuGnK4zmX5jHbkUdQE=;
 b=0bTIFR8sAR2dOKdROrXVTrMe+AyYpyMHOHHSFAIS4WgMSh45Uzo2xXKsPaXcLzh+BY41CIOToINEuXJyYXTxXbd0YYoPTqhnGVOb8Y7pmWo9+IRRA67s0nVs48u3uqMkUxNYDDQY+Pg+IaN7yhMyoiJMCcE1appc6+rAmT0kPx8=
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 04:35:00 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::74) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Tue, 8 Jun 2021 04:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 04:35:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 23:34:58 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 4/5] drm/amd/pm: update the cached dpm feature status
Date: Tue, 8 Jun 2021 12:34:30 +0800
Message-ID: <20210608043431.1855151-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210608043431.1855151-1-evan.quan@amd.com>
References: <20210608043431.1855151-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d168d249-42bf-4c1e-02e2-08d92a36c6c4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5393CF96240F36CB410940E2E4379@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd9z1dbxQKlb3IYl6qnGe63jA0z3MegUtLmyVMC09hGBgsWMYDy65noQLmFG5nW4PMAp5JImrSQswSgJYlUNN9TlsC5xdh8xX1mTbRyzKployhE2voRM1U9gFNE+EXsUJjzyaZVigq9AMdtOeMQuTUHrGaPoaBuahDX9ObjEOfWYNwLr7Bz8NGpAJFmiYeA6kGbdLuLGaFU2Cjw9G8p/qLapH3siBTJq7OtKi97qrAxOQy3eHAxYLhqWYbQuqorTevxrFRI91FelRJ9E/mm7s26bBHmeQmyijj7l0Ld9xRsUHERE0HDLEHRZhip1seYAqjkqLdIFp2w7MJY1xQD5nLGe5fR1cs+J4x9xJeAzt8GFwR2T5aQq9O6rNNm388Ms40A4LenJA+zni5iWlL0+7HMsVz2RMiZ2Ln0sQQF8tlT07TJkXY7Wj7oSzt2FU0fLDmmH/Kk7ECCD95pgUrpZc5cRGKQojCLUSnd7Kyx2vd5xqoPI/dGCKX73MF9aBIU3nD71b/F8Iwqc9Yq5yLaGEuZxvLaEIGzPU9pjhXBmD6ckKTSD9qaJ2puft3gc7baXQA+b+8sDyLHwB+u9AqdaNkFYnz1ac1BSAzmgcInWIns2cDI9Hw2Oc/zCSry8+vnuRUpNiszj8icZ3l9Rxsyc7YCwEqjiFXTzs5mGJkpsdvbtKqSFa0tzQ6F1F2KFGU4d
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(8676002)(316002)(36860700001)(86362001)(2906002)(8936002)(426003)(1076003)(36756003)(70586007)(6916009)(2616005)(82740400003)(81166007)(54906003)(7696005)(4326008)(6666004)(186003)(44832011)(356005)(478600001)(82310400003)(47076005)(5660300002)(15650500001)(70206006)(26005)(336012)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:35:00.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d168d249-42bf-4c1e-02e2-08d92a36c6c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some ASICs, the real dpm feature disablement job is handled by
PMFW during baco reset and custom pptable loading. Cached dpm feature
status need to be updated to pair that.

Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - correct the setting for baco bit(pointed out by Lijo)
v2->v3:
  - Lijo: no new ppt_func
  - fit the logic into existing API
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   |  9 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 47 +++++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h      |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h |  2 +-
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index fb7438224872..46fa10b328e7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -935,7 +935,9 @@ struct pptable_funcs {
 	 * @disable_all_features_with_exception: Disable all features with
 	 *                                       exception to those in &mask.
 	 */
-	int (*disable_all_features_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
+	int (*disable_all_features_with_exception)(struct smu_context *smu,
+						   bool no_hw_disablement,
+						   enum smu_feature_mask mask);
 
 	/**
 	 * @notify_display_change: Enable fast memory clock switching.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 57da4dbe94c0..ae337eb41ffc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1382,7 +1382,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
 	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
-		return 0;
+		return smu_disable_all_features_with_exception(smu,
+							       true,
+							       SMU_FEATURE_COUNT);
 
 	/*
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
@@ -1390,7 +1392,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
 	     use_baco)
-		return 0;
+		return smu_disable_all_features_with_exception(smu,
+							       true,
+							       SMU_FEATURE_BACO_BIT);
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
@@ -1398,6 +1402,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		ret = smu_disable_all_features_with_exception(smu,
+							      false,
 							      SMU_FEATURE_BACO_BIT);
 		if (ret)
 			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0ceb7329838c..a1af6f047fbe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -575,23 +575,52 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 	return ret;
 }
 
+/**
+ * smu_cmn_disable_all_features_with_exception - disable all dpm features
+ *                                               except this specified by
+ *                                               @mask
+ *
+ * @smu:               smu_context pointer
+ * @no_hw_disablement: whether real dpm disablement should be performed
+ *                     true: update the cache(about dpm enablement state) only
+ *                     false: real dpm disablement plus cache update
+ * @mask:              the dpm feature which should not be disabled
+ *                     SMU_FEATURE_COUNT: no exception, all dpm features
+ *                     to disable
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
+						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
+	struct smu_feature *feature = &smu->smu_feature;
 	uint64_t features_to_disable = U64_MAX;
 	int skipped_feature_id;
 
-	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
-							    CMN2ASIC_MAPPING_FEATURE,
-							    mask);
-	if (skipped_feature_id < 0)
-		return -EINVAL;
+	if (mask != SMU_FEATURE_COUNT) {
+		skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
+								    CMN2ASIC_MAPPING_FEATURE,
+								    mask);
+		if (skipped_feature_id < 0)
+			return -EINVAL;
 
-	features_to_disable &= ~(1ULL << skipped_feature_id);
+		features_to_disable &= ~(1ULL << skipped_feature_id);
+	}
 
-	return smu_cmn_feature_update_enable_state(smu,
-						   features_to_disable,
-						   0);
+	if (no_hw_disablement) {
+		mutex_lock(&feature->mutex);
+		bitmap_andnot(feature->enabled, feature->enabled,
+				(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
+		mutex_unlock(&feature->mutex);
+
+		return 0;
+	} else {
+		return smu_cmn_feature_update_enable_state(smu,
+							   features_to_disable,
+							   0);
+	}
 }
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index da6ff6f024f9..7b2a11e998a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -75,6 +75,7 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask);
 
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
+						bool no_hw_disablement,
 						enum smu_feature_mask mask);
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 33101dc93bcc..59f9cfff3d61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -57,7 +57,7 @@
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
-#define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
+#define smu_disable_all_features_with_exception(smu, no_hw_disablement, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_hw_disablement, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
