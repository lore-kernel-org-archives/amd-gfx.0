Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C1DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EE210FA84;
	Fri, 28 Jan 2022 07:05:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F57910FA84
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwKnYUhCC5uTAQJGozyL9YeDZRidRrD7Pp7x7C4BXEEis7Sio2wPT452c8qsbAmXH0+PdsdCO12uPoPSk7jJ9kCHWHPQmX86jyE7+bxOTjzx0eXabl/OoTa/dEQ5wejLlr9tZW3Jkslj2MUhSf9zft5xQuZlz5gnoT+RSx8F3X645WRK7HemOk8Uii3WCi47lzXTl6rxxG8sM5gWiuBccWOqxXbCY86p0PwZf4C7MrtEdOUtGSaeN62J9/1EpQWNJdVdTHO7m/q700wDW58zGXYJA55xPhsnnmERj86QUxLsAvI3E0jubL4Bo004/Cq0M3q4OU041iQZF13zabdGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p1tRuR3Mnghy1nbmjSU8WQ1/vo2yrNpysn/pg2Jy+8=;
 b=ZoofTnrRJYPvYSBCiK2t5wo+EIsqx6GqiinWl8H3vwbGCA5KHmkS+6KA4tu/pllMQ1ferSpxZq3yDfptNm2YlXZNrUlDPQYpR1Sw+aP9TVPFxcOj8t3oNAtvube7puzZXskHr/n6EmwB5AzwUdp4RBEXS5EAY+PCmNhRSJA42ev84j7wEsQX4QujY3zwMCFaSWTgu50+Cdbk9OCNW5crxa8nNFB446y7bIW+ziolO2pCw8/4EcCGXomUMW7To2trmMNy3l5PzrRVth5tfWQ/CPLUrGPeggGaSWPH4XeU4hB+kfEKkbg+wNKlC88lb5LwdlZhsVIagQM3rMAT2wPOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p1tRuR3Mnghy1nbmjSU8WQ1/vo2yrNpysn/pg2Jy+8=;
 b=eYC8kz5gRLLc/OFLbYN4PctqNXasxZAG/v6/2QemyDVmIsbB7D9jmjerqHXGgNH5+ffTrPd67osxhkCxHxCCLCrAcSBZeugo3izaRuiFstP03KT/dtbfWwcJYHHhXR5LSidvIVZlaWcwkab1y7h7XkPLyr7d593jRHFMiFezkNA=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 28 Jan
 2022 07:05:29 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7e) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:27 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 2/7] drm/amd/pm: unify the interface for retrieving enabled
 ppfeatures
Date: Fri, 28 Jan 2022 15:04:50 +0800
Message-ID: <20220128070455.202014-2-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f3e5c39-f84a-4753-cee0-08d9e22c917d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3125E43F4611AD160F1DDD5CE4229@BYAPR12MB3125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvevn5S+d73Qipmlb9CGUSZnCt9g3sL7EuTOxJJ7N5/h7IjpjJ82Cc3WoLQX5Gl6gGCCj6pShXB7zpPFRkZxTaPgcejgXJBPE8JihnIhzxJmN5TE71YRgvIhaWwjDALSFH6jKBvgQGudON/rk+PaCrdP9DjeXT/zFymi0JtU8BIoks7hGqtNCq7wsb7VMDVRVmlGRQQLESRHTMF5Pu7HbmV/xLcF3ziUqc0Im25af/u18uvc//7k20fKxxeYO1vEXWOTXNZ5mYCWe0QLnLwpHmNt2mCQZnOpLpxtVfWZcDHdI6OT0LJP4l6vWyqt0b5jk9MXgDmniRbCdqsTEKFCLJl+nA2jgmY2QMCRA5v2BBtbpsRUWPXeCQIc8eHQEM0iuUqB1fEHSSM2RtvdCFCG2s802EdPXiGJjq3d2oxeAz0DLtp74ffEpnvh8m0txtCFF/0w5yfpRmB5I0rHGyukj654M1q4+oBt0K0nSmN8/icb/7Ty1QNT8f5udAVuEgOi9UoVSwHaMhyqBITp1/k4oHq+1yS4FqHCIZ5xZkWy18Nr5FOKYjiz7lbjjrUUER6MoGYFbLgclnGIgVKcKf5rNTvXFzfuZYeeXAF/EazX2dQxknmXoS9gyiD2dJiacvhhlOAyQNd2csx8xSG6qw6e+kPt+fe+B4925XknaUighn5RBLqBmlwEoAYpjbPkL3ISCXb8kcBXw60H3TxX2Y40eTH0mshByStRVpasxm5vyuZXWX+/iRfvzzIU5WwpJbeYhNyGh3lSKPvswUwM+i12xuTvR2YVrzN85Mm1KAxE+0U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(36860700001)(81166007)(8936002)(40460700003)(36756003)(54906003)(83380400001)(356005)(186003)(16526019)(2616005)(7696005)(4326008)(70586007)(47076005)(1076003)(426003)(6666004)(44832011)(6916009)(26005)(8676002)(508600001)(82310400004)(336012)(70206006)(86362001)(2906002)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:29.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e5c39-f84a-4753-cee0-08d9e22c917d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of having two which do the same thing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I6302c9b5abdb999c4b7c83a0d1852181208b1c1f
--
v1->v2:
  - use SMU IP version check rather than an asic type check(Alex)
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  6 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 95 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 -
 5 files changed, 46 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2f57333e6071..cc080a0075ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -357,7 +357,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	if (ret)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 721027917f81..b4a3c9b8b54e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -507,7 +507,7 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 	if (adev->in_suspend)
 		return false;
 
-	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 
 	if (ret)
 		return false;
@@ -1965,7 +1965,7 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	if (ret)
 		return ret;
 
@@ -2182,7 +2182,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
 	.is_dpm_running = vangogh_is_dpm_running,
 	.read_sensor = vangogh_read_sensor,
-	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_watermarks_table = vangogh_set_watermarks_table,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index bd24a2632214..f425827e2361 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	if (!en)
 		return ret;
 
-	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	if (ret)
 		return ret;
 
@@ -258,7 +258,7 @@ static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
-	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 
 	if (ret)
 		return false;
@@ -1174,7 +1174,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.set_watermarks_table = yellow_carp_set_watermarks_table,
 	.get_gpu_metrics = yellow_carp_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c3c679bf9d9f..c2e6c8b603da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -545,67 +545,59 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num)
 {
-	uint32_t feature_mask_high = 0, feature_mask_low = 0;
 	struct smu_feature *feature = &smu->smu_feature;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t *feature_mask_high;
+	uint32_t *feature_mask_low;
 	int ret = 0;
 
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
-	if (bitmap_empty(feature->enabled, feature->feature_num)) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
-		if (ret)
-			return ret;
-
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
-		if (ret)
-			return ret;
-
-		feature_mask[0] = feature_mask_low;
-		feature_mask[1] = feature_mask_high;
-	} else {
-		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
+	if (!bitmap_empty(feature->enabled, feature->feature_num)) {
+		bitmap_copy((unsigned long *)feature_mask,
+			     feature->enabled,
 			     feature->feature_num);
+		return 0;
 	}
 
-	return ret;
-}
-
-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
-					uint32_t *feature_mask,
-					uint32_t num)
-{
-	uint32_t feature_mask_en_low = 0;
-	uint32_t feature_mask_en_high = 0;
-	struct smu_feature *feature = &smu->smu_feature;
-	int ret = 0;
-
-	if (!feature_mask || num < 2)
-		return -EINVAL;
-
-	if (bitmap_empty(feature->enabled, feature->feature_num)) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 0,
-										 &feature_mask_en_low);
+	feature_mask_low = &feature_mask[0];
+	feature_mask_high = &feature_mask[1];
 
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 8):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_GetEnabledSmuFeatures,
+						      0,
+						      feature_mask_low);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 1,
-										 &feature_mask_en_high);
-
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_GetEnabledSmuFeatures,
+						      1,
+						      feature_mask_high);
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+	/* other dGPU ASICs */
+	default:
+		ret = smu_cmn_send_smc_msg(smu,
+					   SMU_MSG_GetEnabledSmuFeaturesHigh,
+					   feature_mask_high);
 		if (ret)
 			return ret;
 
-		feature_mask[0] = feature_mask_en_low;
-		feature_mask[1] = feature_mask_en_high;
-
-	} else {
-		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
-				 feature->feature_num);
+		ret = smu_cmn_send_smc_msg(smu,
+					   SMU_MSG_GetEnabledSmuFeaturesLow,
+					   feature_mask_low);
+		break;
 	}
 
 	return ret;
-
 }
 
 uint64_t smu_cmn_get_indep_throttler_status(
@@ -710,20 +702,11 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size_t size = 0;
 	int ret = 0, i;
 
-	if (!smu->is_apu ||
-	    (smu->adev->asic_type == CHIP_RENOIR)) {
-		ret = smu_cmn_get_enabled_mask(smu,
-						feature_mask,
-						2);
-		if (ret)
-			return 0;
-	} else {
-		ret = smu_cmn_get_enabled_32_bits_mask(smu,
-					feature_mask,
-					2);
-		if (ret)
-			return 0;
-	}
+	ret = smu_cmn_get_enabled_mask(smu,
+				       feature_mask,
+				       2);
+	if (ret)
+		return 0;
 
 	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index f0b4fb2a0960..4e34c18c6063 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -61,10 +61,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num);
 
-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
-					uint32_t *feature_mask,
-					uint32_t num);
-
 uint64_t smu_cmn_get_indep_throttler_status(
 					const unsigned long dep_status,
 					const uint8_t *throttler_map);
-- 
2.29.0

