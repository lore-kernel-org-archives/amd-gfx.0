Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A83DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E59D10EE29;
	Tue, 25 Jan 2022 09:00:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA44210E8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 09:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIUvaKeY54QmBqdXWOnMTZ/dtXG0vyAPO2sGmnANAUX2Gec+7Xe7+aNAlMvsZLwRTcsQ4Yq7S3bWxNL/UJ+rwVMEpBFS0vEnkrZt64PidKqeBtOBhJAJaBGrqnejQKW3EMm2KZZCdcgqRHLKl9S3CNNTedIPGL6fLGdQDnoRICOfaqqqDK/nuifZreTEB3Km0V+1pGPWlFMEReeDqkMRXIGMp0jRCTwlY/t0wyp3cQNBWlo63tzJANfeOKYHpfLQwogixA8s5e5aJEd+Xbtmgcy863uPHLZ38XZ1cetPdwLqXMhGMZThsCdYR12vtuiTzAHFlq0687tp9H4R1sNUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E810vCZUkymeYRiCYLtoPgbq/+OgqMahvYjyyOC0W6U=;
 b=VMBVYNJuxwhKVWzBvbTkU7bfrty4pxlSh8XdnrAc+Ah2LbMjumO1PjkVOr6nqkIP9yO6Df6hm3/GiwpNdnpSBUDOTDDBaw1j5KdzV9u4jqx/25L4Ft/vVhqj7ZnGK7CXecVyTAyWP7Ul1GPLNWQkXF/X11vxVCPEe77HPxdnveJ6od8+ld7qM3dU5F1N51EOJOoYSfYXPmh1BqsrXifsKbavS7LJ6qBJ/OgnW/iwCFC1H5AzIhmO8a/4XHfQGOKb/tyov17T4K+ItuZOLi6ZBaze2tWJa5b4tdP1fwwy7pHzJlIsEpgNIH4D6LydiYkX/QMXiinL54Jvax3O6YN12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E810vCZUkymeYRiCYLtoPgbq/+OgqMahvYjyyOC0W6U=;
 b=uvU39mwggpBRtWxBz8eH3SapykYYes1mK+VjPi+2VA96PTCrU36df8NC2ilWFwCfUyYDB+5+49x58QQs+aTGF3t5MUnb9c9Fkl8iDIVF9SqrRP/8XSB8y7pjg5aZJUER8z78uQ59BvDBxNSmPc6hW7+FYJ0mxmT+zBYHdrUEX4w=
Received: from MWHPR22CA0020.namprd22.prod.outlook.com (2603:10b6:300:ef::30)
 by MWHPR12MB1535.namprd12.prod.outlook.com (2603:10b6:301:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 09:00:34 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::15) by MWHPR22CA0020.outlook.office365.com
 (2603:10b6:300:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 09:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 09:00:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 03:00:32 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/7] drm/amd/pm: unify the interface for retrieving enabled
 ppfeatures
Date: Tue, 25 Jan 2022 17:00:08 +0800
Message-ID: <20220125090013.102080-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220125090013.102080-1-evan.quan@amd.com>
References: <20220125090013.102080-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4066d845-d493-4578-65d1-08d9dfe125f3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1535:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15356FD5391ADBCAF6E9A522E45F9@MWHPR12MB1535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zS2yBjU9iSoW7dty08Qnz/oWEi+jxQSVVpwpdKrZPXB868uABMPTheArlqXxg66fBoscGStY1FU4jY0/2qgx5ptkI9sB0iFY2mTsPhjlW/GE0OzaCkB//8/tEFtaAYX6RQWSilalwwch5Zk41uthmJWQFFfAZ1HjHb+42ffZ/evnI3LZBXlUtEpQApDvgH+jRiCNrzUMDcHSJ4DtonOl+oeKqCaLjVF3bIlB03eO93+ce2SYeIwQZvw8gevtM1tQFzSvWVm4+KMftksmZ2WbC5qT8U35yCgZobBh7pDsobKn2gF0N58YlNADoaNHKb+05jy/JRAD/KwXBhbbwHGCybhDUBvtMOOe1LNnV6oQ86s9sY+gsVjogleGDI5RZezI49+3wabLSnnQfMKtPbpl+/zPYgyAIrPBLM73d3RNlGvEhFU8CaTo2MYaq5q8iBnys2pouvwaXcnNk9i+Tnv3PK2+dQOSFASDOg8w6MpbZnYCFWMGljI+g8YPN9QCGW8Tt6V8e58Oujiu0mskz3IFP+kaOX5lXH0vi3nHsACYiExb5yLIEKZ1JAd/kIpGWbmGSSCdHfMXgKmwy0r8OVmKlW/frhJdiNSvaObVFZPWuzqHwbJ4kTlcdke7eYKMAioezAYGlZPrqx+qu7ngyll+B6OuiIrXXQ1UNGjnDXlM0yL+SWoSEImclB0t4+Dqm98Mi1C3Ox7jtol71DZWKxi8cb+vdM7Uf7oj0myAe8u2dM4Z/PYVLxrXMN+tHGdwp6PsQgt5d35zeXHNaQ4KDuyKCNtGXz8JMvdFU6Zjiffb1og=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(6916009)(81166007)(47076005)(316002)(70586007)(6666004)(26005)(44832011)(8936002)(426003)(83380400001)(70206006)(356005)(186003)(16526019)(54906003)(2906002)(82310400004)(2616005)(508600001)(86362001)(336012)(1076003)(36756003)(36860700001)(7696005)(8676002)(40460700003)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:00:34.5417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4066d845-d493-4578-65d1-08d9dfe125f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1535
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
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  6 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 93 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 -
 5 files changed, 44 insertions(+), 67 deletions(-)

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

