Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F7DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB56410FA8F;
	Fri, 28 Jan 2022 07:05:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C808510FA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoUmvgYDj36NV/Rl3/ZlDx3hvuZA5mc/R1F5Ni4YwKhgZErOyjf31faHLmS+rnZ81fF5m+dkKVpRu7Npq3D5jtB6F20e7AFbeJ1wSDMBoayaOeLbM9FUMKHWHqrGg/HxWqmi7K0QAdjJwCdN/jTEXGLY8U3hvqSK62Dfq2XO1GHtMwTKXs1WkIDNwUOTBrOQA3I2L6r8VNOIGVdE27ElKLeBM6m8I9N2KOHfqLjZuTsyk34clI/gUfDpySsRxZrBAcut2JbrN0QP2knn53foY8SO6MybV1IWrF9f5k6SgEEOclEvZnAoq6+nLZLIeeigIJHNygfCkyXIUsGd6D9vAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXe8MHKvGJU1Z2aY6crZhTuImpC5e1XeBMnoiFIcmS4=;
 b=dRfUSO2eMw0N62Kc2F2CyEmEnrs4QzXlTW1KDkTJMLiV80bFmL9TrJMnVHRk5YN17tCdWDkBaVFskmETTfqtjuDO+lsycvPdKPLMwxNIw3pvbxo2c3CgeuulNMsC/Pj/tFnXvmg4U+m17++BMAq2bThO60zum+XujKjIJLSPFM9p6sLSlnHU1csopg2zEe3TbnRmWNqtl9tUR04MU7sVMh+6m4z06dZ/TU7LU1GAPqc0Dc/ozKO87RiNpsMBtJjYOVFRvV6xC1Oj+w/6oCSzFAw1APDCfFg/Ilwz2NxdCOsr1JAQ7WJZcArwU/S6lLH8LP9981L/gU0t0seALlA+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXe8MHKvGJU1Z2aY6crZhTuImpC5e1XeBMnoiFIcmS4=;
 b=kJkOU17ZrxVJSgoKbO1HJTEvQ3mUiR1i3fIRMrFKTqJNiY7NYLtnStMO+UAvXCRsOc65z8+9OgiJg2CuukBEci2BoQalHHQs4Qlg2fdB1EIPWmbF+Q7iVNWpYnGTn5BCM0cu9fJCfQa6hXhyGg4yDM00NsLUytuRvFvD+kam7uo=
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 28 Jan
 2022 07:05:33 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::53) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:29 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 3/7] drm/amd/pm: update the data type for retrieving
 enabled ppfeatures
Date: Fri, 28 Jan 2022 15:04:51 +0800
Message-ID: <20220128070455.202014-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128070455.202014-1-evan.quan@amd.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fb85a16-5aa1-4694-afa8-08d9e22c936d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB254334E184AD7466BB877C08E4229@SN1PR12MB2543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wPZvMfIPg/75DyhLue9S2EO1txjMm5K96Mko+QufStNInlpgDZ0UGH9N4d/SxE6X2AGSkSs0lv3bGjxJuj7lOBvggh0UQlS6jns2TGBIqSUApRaPAJU4hr2Zyz24GlmMhs3nN934Uxx1JWxRtNlXs+ROKPb1mJ5uIDIiTFX2FJMOPMyzxpetynnotNZ8V8BkBWVuu1l3rptnS3QoS4p5ZCy10dtqKC1/cwl9y/uulwUU84TA+Jy7VJmOUtcywrEtZVVJgKjNPJhlVNdm24Drdy7aFi17O4t1xufZTD6b2C3gcgUWj6wnSxH9AmB5q1oO7hnmGcX4jQskAEUajgwhahAdzxVt2p7/PFAA4v2BXdGVa+1iFKbNQluV+kgKKpJqaE3AN76bHq7LTvXHbAfPWXTmsPHbkKKpJlvob8TfqScO5Kmza5XSxyXxZmeF9Z/wvZU22Rj5e2ZDV2HkeGs30Z64ThQ1hS7qfRV98JvndJO89KamNaaC1SR6gR8HsVBvdGN6SLIiy6q8lKlNIQjAroXwnBC3t0y2DxirZxXOTzGGE8/XWWL2dMX88V+noK/znjX0FJ4PbAWd4cf/l/5IvHebzO9rrXOoMqBF2BB+fdYcgsDtzacMavi7IHW/OTAy4cBaJZoipoDhiYtWJGGQsDd8EunDAzP4+y4O2xkJhwizPR2slkdeE4imsNBIHZriI5m6TQ9fuY/Hzgco3t3LNSGQLNAvl1xH1fvuZxpJBbS+5aYt7fNrqUIUaszvCadPiOQ6mg1I8ib0yxz77gxkxF1mPQbY/54hmdoYd+dshA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(36860700001)(336012)(81166007)(316002)(26005)(4326008)(70586007)(2906002)(82310400004)(15650500001)(7696005)(186003)(2616005)(356005)(8936002)(70206006)(16526019)(8676002)(6666004)(30864003)(508600001)(83380400001)(5660300002)(54906003)(426003)(1076003)(36756003)(44832011)(40460700003)(47076005)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:32.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb85a16-5aa1-4694-afa8-08d9e22c936d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use uint64_t instead of an array of uint32_t. This can avoid
some non-necessary intermediate uint32_t -> uint64_t conversions.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I4e217357203a23440f058d7e25f55eaebd15c5ef
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  6 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++-----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  7 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 +--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  9 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 29 +++++++------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 14 files changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9861d70a5dad..ae48cc5aa567 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2310,7 +2310,7 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
-		ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
+		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
 		*size = 8;
 		break;
 	case AMDGPU_PP_SENSOR_UVD_POWER:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4c585241ef66..8cd1c3bb595a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -975,10 +975,9 @@ struct pptable_funcs {
 	/**
 	 * @get_enabled_mask: Get a mask of features that are currently enabled
 	 *                    on the SMU.
-	 * &feature_mask: Array representing enabled feature mask.
-	 * &num: Elements in &feature_mask.
+	 * &feature_mask: Enabled feature mask.
 	 */
-	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+	int (*get_enabled_mask)(struct smu_context *smu, uint64_t *feature_mask);
 
 	/**
 	 * @feature_is_enabled: Test if a feature is enabled.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index ee296441c5bc..63f2b50cd486 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2022,15 +2022,12 @@ static void arcturus_dump_pptable(struct smu_context *smu)
 static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index cc080a0075ee..2b38a9154dd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -350,20 +350,16 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[0] |
-				((uint64_t)feature_mask[1] << 32);
-
 	/*
 	 * cyan_skillfish specific, query default sclk inseted of hard code.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4a86520d01c3..84cbde3f913d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1639,15 +1639,12 @@ static int navi10_display_config_changed(struct smu_context *smu)
 static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 22dd372b8d24..b6759f8b5167 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1297,15 +1297,12 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b58a4c2823c2..b34d3a416939 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -799,7 +799,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
@@ -811,7 +811,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index b4a3c9b8b54e..65f30cdafc8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -500,21 +500,17 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-				((uint64_t)feature_mask[1] << 32));
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
@@ -1952,7 +1948,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
@@ -1965,7 +1961,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ba4c9771ffc5..57f21aa08767 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1450,14 +1450,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
-	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-					  ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1754a3720179..6b77fc4b4698 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -765,7 +765,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
@@ -777,7 +777,7 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
-		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index f425827e2361..a7aabb8079ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -197,7 +197,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t feature_mask[2];
+	uint64_t feature_mask;
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
@@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
 	if (ret)
 		return ret;
 
@@ -255,16 +255,13 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
-
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c2e6c8b603da..aae08ce62b80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -542,8 +542,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 }
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint32_t *feature_mask,
-			     uint32_t num)
+			     uint64_t *feature_mask)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
@@ -551,7 +550,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	uint32_t *feature_mask_low;
 	int ret = 0;
 
-	if (!feature_mask || num < 2)
+	if (!feature_mask)
 		return -EINVAL;
 
 	if (!bitmap_empty(feature->enabled, feature->feature_num)) {
@@ -561,8 +560,8 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		return 0;
 	}
 
-	feature_mask_low = &feature_mask[0];
-	feature_mask_high = &feature_mask[1];
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(11, 0, 8):
@@ -695,7 +694,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
 size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
-	uint32_t feature_mask[2] = { 0 };
+	uint64_t feature_mask;
 	int feature_index = 0;
 	uint32_t count = 0;
 	int8_t sort_feature[SMU_FEATURE_COUNT];
@@ -703,13 +702,12 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int ret = 0, i;
 
 	ret = smu_cmn_get_enabled_mask(smu,
-				       feature_mask,
-				       2);
+				       &feature_mask);
 	if (ret)
 		return 0;
 
 	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
-			feature_mask[1], feature_mask[0]);
+			upper_32_bits(feature_mask), lower_32_bits(feature_mask));
 
 	memset(sort_feature, -1, sizeof(sort_feature));
 
@@ -745,22 +743,17 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask)
 {
 	int ret = 0;
-	uint32_t feature_mask[2] = { 0 };
+	uint64_t feature_mask;
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
-	uint64_t feature_enables = 0;
 
 	ret = smu_cmn_get_enabled_mask(smu,
-				       feature_mask,
-				       2);
+				       &feature_mask);
 	if (ret)
 		return ret;
 
-	feature_enables = ((uint64_t)feature_mask[1] << 32 |
-			   (uint64_t)feature_mask[0]);
-
-	feature_2_enabled  = ~feature_enables & new_mask;
-	feature_2_disabled = feature_enables & ~new_mask;
+	feature_2_enabled  = ~feature_mask & new_mask;
+	feature_2_disabled = feature_mask & ~new_mask;
 
 	if (feature_2_enabled) {
 		ret = smu_cmn_feature_update_enable_state(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 4e34c18c6063..bfe3430829c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -58,8 +58,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 				enum smu_clk_type clk_type);
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint32_t *feature_mask,
-			     uint32_t num);
+			     uint64_t *feature_mask);
 
 uint64_t smu_cmn_get_indep_throttler_status(
 					const unsigned long dep_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index a290b5789195..0063346ed163 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -55,7 +55,7 @@
 #define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
-#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
+#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_disable_all_features_with_exception(smu, no_hw_disablement, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_hw_disablement, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
-- 
2.29.0

