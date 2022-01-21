Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2C5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C08610E906;
	Fri, 21 Jan 2022 07:45:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3240C10E906
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3hNj6UsM/2ztKNlp6CgQbTFccMqeoF5HBtrJwCkK1hZ1CdhwR3xiSO92fVjiah83ybL9GnNjXeGFK/9fQJE5dfZHaKTYhggaApXcdsfx96LqZbbavWQJvuoGmnMa2OmbkXIUX3cLxC3loB1ijoQQK8KV8F6/qi5xx5w7prvawyP1spaEylWVPo8/BdWjfUBPkF6G+K5Q1orvrJtAVKLKTFAsOnrQtThNz7fuxhnS0B7yURSuwLEkfuTte8QND1O7+78Xp+189ReDnRzfaPlMHCbCS4f/S/956ujmUy7NTx/6qg+1JSI/KF6STP/cpfuFHNn2RE7G7C1lw6MWO+2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzATwrC6WorKMT8/juI+kSs7vociTKgcvGZ2bkz77mU=;
 b=ejdR7OgQu7bqGWwhQcuuC4KbMknzdEdBTrzRYFYvbr+mguVnw/qr1VdMdz9lSP74TArMRZfd6JUlNZqbbnGB8+sLqHD8EwZ178Nt6JSvboxogOw7qP96kmvGrV/+hb3soZbKYoKnQc5b+YYUDFhz0e/cadH6nkCn/dMuQO15OxEL7awJ/2XLJ0gJyRTsFSX7kfw/ZwlyROfDrfv1Ygf+oDyj97zmMCnZvjIj5aewenvG8+CslR32wG2tZ0umqRkEKXbkkx+HqgT+GjNaBB3d4OtMCucBSjN8YeQtAUTYB7yFPcwjsGt8Es1WcskH4e09KdRlKsUQALevvUixjgBTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzATwrC6WorKMT8/juI+kSs7vociTKgcvGZ2bkz77mU=;
 b=Drfx1vyAorqqzPnHbW1af14IRlDcji4qHvAkMrmDlLr0Ri/kzcrxvXRbilYym8tomqBaISTGb5Z5h57DrxzjyLvOAhXylYHrjQlQ2yillKkERFwEfQhaYRKN3W9KIgjFj1jYWyIXqbru+gXhiKy2a1GmiqwGzAhZn4z0Ue3h180=
Received: from MWHPR12CA0063.namprd12.prod.outlook.com (2603:10b6:300:103::25)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 07:45:10 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::4b) by MWHPR12CA0063.outlook.office365.com
 (2603:10b6:300:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:06 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: unify the interface for retrieving enabled
 ppfeatures
Date: Fri, 21 Jan 2022 15:44:38 +0800
Message-ID: <20220121074443.639392-2-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 284eb7cf-7595-4d8d-697b-08d9dcb1f3c8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4290:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4290EAFF16C581AF78CD5974E45B9@BY5PR12MB4290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcEGHjllWXqi/UIvLd/HhqibDJJp+hm71DtqdxyrllDLJm1M6Zval4RXFdbOJ3Jwrz2ckO7bXuozLnrZozPl1k51T42q43slozhEBL2hwiEUWyE6afWNvNceibGV6g5dL/Cisa+mGbZSeXVfSLwScqwi/MxQRHJ2r6HKjQcNtRS5a4+DqQsdYcpFrWnJeHHINW6/WVnxHh+E5RDZePr31B/dBa2Aa+bMx36+PQUw9yggp/STDs8QDc8ccTVG18GSIALkXiJb4QT8b/ItHqejW6pFCDh61LUhZMr7XmNnhNGnCnC6L0BDv+Kn8ay1W2N7x/gFeRdVxqzjCy/y4NP/aXa1PBgGwx8KhItfO86SUNqjDUMYRmZpqeQCtNhn6xv+Oi86tzMamyyqRmowtxVkftQxX5lau1zUE6MK44FQlpGsp6JP/U6c5x/ygo67vcRvP7AA8I+tmz2LX2r4hpqXueHfWrks95VE1+AZ4usHCX/3mKdneK3xTuKFcEKLo40zQF5uidG2QJpDjPO4D5w+RtZJ1wKCAxP9ENfTJKo/RGmUQMvWCs876u41yZxRFtSTzEId1hpMSdbtDkrVyHqEIvXDwMtRcOGMRLzi+4m59aThlAa/EHgvNAQHQR99FWE2lnbHOarjDhJgCRj4GCZIqLyCUqG0bIpuwdccJ/4QG2xQSqpZVHc07JNawMxf0A8KstQRn1RsKRZ3UkG+gqdrnyXQPZfLjDt/neAbZAaeg2LEBew0rylPUMVkibtmzJjsNVcoVcqXfPmeEgCFNlHgkefCN0Z0dggAsZpTsaxfnVM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(8676002)(356005)(5660300002)(36860700001)(86362001)(36756003)(6666004)(1076003)(316002)(81166007)(508600001)(6916009)(47076005)(2616005)(70586007)(70206006)(4326008)(336012)(54906003)(426003)(44832011)(83380400001)(2906002)(7696005)(16526019)(186003)(26005)(82310400004)(40460700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:10.5393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284eb7cf-7595-4d8d-697b-08d9dcb1f3c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

Instead of having two which do the same thing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I6302c9b5abdb999c4b7c83a0d1852181208b1c1f
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  6 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 93 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 -
 5 files changed, 44 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2acd7470431e..cabea4eb1566 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -373,7 +373,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
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
index c3c679bf9d9f..50164ebed1cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -545,67 +545,57 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
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
 
+	switch (adev->asic_type) {
+	case CHIP_CYAN_SKILLFISH:
+	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
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
+	case CHIP_RENOIR:
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
@@ -710,20 +700,11 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
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

