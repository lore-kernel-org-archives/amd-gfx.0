Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217FBC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 01:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4ED10E207;
	Thu,  1 Jun 2023 01:59:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAC510E20D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 01:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaqv9XYXEtiWpGN0YTTQ+D3NQQhIFD1Qma5iP1slD+SyyabR+xqS9uE7Zf1DqHZLC2uuIJ+C3qUGIDi5zfHo9zSkhnM+Q1qzlfWCwfoCppHaeCqkTRJq66x2vPjIbbcoO1jqXDdhKCE+nmb9yV+dTdsM/DIXnzHQnPUGqCVdm4ltFmXBcihsX+fJG91wcqfF9p2VPQO++lqHiGZALVL1afvqWH9rYw2RcUT68VnmTiwvh/+1tRQLLjgd3/jDKMkIUtU0Keaa4dioomj1rfIjRkQzeeWbvLKWlsjgFG8vEra6xc3MJaBbEEGkFsO6STF5u6HHS0vVBygQpn4rs8jnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1KdyDdDrVO1rjK57peqUu0y2u1rtfG8iNFKxM1J+9M=;
 b=CH22nlmKp/KSAS532QiIBuLzR85wTW3hw6PVLZglzVnZWQteh4IQWBBKMISC2F0qgqANfh2TQuQwSkl5kdN9VJrUvELYhgXB1o/FmbKuU5Xn/skdsNEvs+bWEUGwAdkCJrY98i6HXjeAow1MaIsHRj29kF6uSdlzULEjnSadfrZks1KT1S//DgaFAkhBfFcft6X9g56rODPXIf/oXJm0SuQ4IiHwiYqaE9l5BCy62yywq4Mzm8dVAkHwDIhvfFbzO5wMm/gQl0ljvvkFVv+p97WdvMmCIHlkJViV++pdRFiPm1/De8SDe7K7VsJeBM9JnwU1wi0Me9oLakoMcx0Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1KdyDdDrVO1rjK57peqUu0y2u1rtfG8iNFKxM1J+9M=;
 b=JwdaGNrhFcrxBMMW2CJCO3GH+NXIOrjhJiC6qgm3mQVV7Q8wckKou/wsL9sGMT9Nx1ug9jDcBwikkriipu1LhomDsQNEM3gQfDPR8HuXwcPwOIRPhv53rDpYbZJvHOhXArDVD8LebVzGd8b1sktKpTI68mmZW7j9kMRz1LrdgFo=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 01:59:39 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::35) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Thu, 1 Jun 2023 01:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 01:59:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 20:59:37 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/pm: fulfill the OD support for SMU13.0.7
Date: Thu, 1 Jun 2023 09:59:05 +0800
Message-ID: <20230601015905.49427-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601015905.49427-1-evan.quan@amd.com>
References: <20230601015905.49427-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d648e1-5a1e-4939-4545-08db6243dbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs3vUog7T9AMYW1owpxomqcJ4LtLd6GuwNidm5d+vE+xi/YGRuHErPnqUiBTeO5HO3tlFvEwmAoRhF5rRs8/tWNfSkcu0d0DDf83/8krMxyaXhwCT3gGwl+NKEGTyGHbCuZ97+Q9a+ErH82c7WZUn3Mtau6sTqNlKvlFBzNI0GrgdQVbMeXcqL6Cs8O03bh12l6tsI4FuoM7YjsWVotEr9zuTUKMKWb9MsPnaD4yTuJxvJ3C7DoUkt4VRdY3PMRa4U5yn3WITnFFxKMX3/djKqRimAUlB9G3WJTMtXcA43KABCKQp/RLdY9vPCSN5CCS1cA7y0jiz1jc9W5wkTqBuoLaVCIKA0rFcEa4LUoYFHPGfh8T59FHiiZnNRO5bd+mUuDHMEGsiIUJdTSQhKeGcAHNmrYzcSr1eVINy+tPNJr51VihwVaCgIqlso+ngczQ/MsGzyPFEW3wYcZOflqLLSksrWRMMUQRualoexAhLz1O8SE2w1pL4pujW7XjL91+jn/QAB2aXPyultEOyO4WGUScC6oQsBwbs9F/Kf8Px2sG4wxD7oYLembjf7cIvX+XBP7WTgR6oRY1IgiRRGt1gpkRvZU2Wmtla6MT1X+9JKUESbvjeN8wNB4xPyLUMnTUMtiQnM2C8FeL1IYX9ChI2RvzMif8uRZ5phZDTRPby5HxgKsEV1Eh1ljeG/DF9HXiGRGD4vHAR0+FwwupwARu3X+n62oez6njsgvH5SejOElHI+UWeeAM790BjeKosbnvJwTfHfMo9rULj2sSC6YTKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(30864003)(2906002)(81166007)(16526019)(186003)(336012)(356005)(82310400005)(86362001)(41300700001)(7696005)(8936002)(8676002)(82740400003)(2616005)(478600001)(426003)(26005)(1076003)(54906003)(6666004)(316002)(47076005)(83380400001)(6916009)(70586007)(70206006)(4326008)(36756003)(36860700001)(44832011)(5660300002)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:59:39.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d648e1-5a1e-4939-4545-08db6243dbbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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

Fulfill the interfaces for OD settings retrieving and setting.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 445 ++++++++++++++++--
 1 file changed, 402 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3ba88033c766..8d4a0c3cedbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1027,16 +1027,118 @@ static int smu_v13_0_7_get_current_clk_freq_by_table(struct smu_context *smu,
 						value);
 }
 
+static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
+						int od_feature_bit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+
+	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+}
+
+static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      bool lower_boundary,
+					      int32_t *min,
+					      int32_t *max)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+				&pptable->SkuTable.OverDriveLimitsMin;
+	int32_t od_min_setting, od_max_setting;
+
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_GFXCLK_BIT:
+		if (lower_boundary) {
+			od_min_setting = overdrive_lowerlimits->GfxclkFmin;
+			od_max_setting = overdrive_upperlimits->GfxclkFmin;
+		} else {
+			od_min_setting = overdrive_lowerlimits->GfxclkFmax;
+			od_max_setting = overdrive_upperlimits->GfxclkFmax;
+		}
+		break;
+	case PP_OD_FEATURE_UCLK_BIT:
+		if (lower_boundary) {
+			od_min_setting = overdrive_lowerlimits->UclkFmin;
+			od_max_setting = overdrive_upperlimits->UclkFmin;
+		} else {
+			od_min_setting = overdrive_lowerlimits->UclkFmax;
+			od_max_setting = overdrive_upperlimits->UclkFmax;
+		}
+		break;
+	case PP_OD_FEATURE_GFX_VF_CURVE_BIT:
+		od_min_setting = overdrive_lowerlimits->VoltageOffsetPerZoneBoundary;
+		od_max_setting = overdrive_upperlimits->VoltageOffsetPerZoneBoundary;
+		break;
+	default:
+		break;
+	}
+
+	if (min)
+		*min = od_min_setting;
+	if (max)
+		*max = od_max_setting;
+}
+
+static void smu_v13_0_7_dump_od_table(struct smu_context *smu,
+				      OverDriveTableExternal_t *od_table)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
+						     od_table->OverDriveTable.GfxclkFmax);
+	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
+						   od_table->OverDriveTable.UclkFmax);
+}
+
+static int smu_v13_0_7_get_overdrive_table(struct smu_context *smu,
+					   OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   false);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
+
+	return ret;
+}
+
+static int smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
+					      OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+
+	return ret;
+}
+
 static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					char *buf)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = 0;
+	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
@@ -1153,6 +1255,89 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 					"*" : "");
 		break;
 
+	case SMU_OD_SCLK:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_GFXCLK_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+					od_table->OverDriveTable.GfxclkFmin,
+					od_table->OverDriveTable.GfxclkFmax);
+		break;
+
+	case SMU_OD_MCLK:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_UCLK_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
+					od_table->OverDriveTable.UclkFmin,
+					od_table->OverDriveTable.UclkFmax);
+		break;
+
+	case SMU_OD_VDDC_CURVE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_GFX_VF_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			size += sysfs_emit_at(buf, size, "%d: %dmv\n",
+						i,
+						od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i]);
+		break;
+
+	case SMU_OD_RANGE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
+		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
+		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+
+		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
+			smu_v13_0_7_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_BIT,
+							  true,
+							  &min_value,
+							  NULL);
+			smu_v13_0_7_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_BIT,
+							  false,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
+			smu_v13_0_7_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_BIT,
+							  true,
+							  &min_value,
+							  NULL);
+			smu_v13_0_7_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_BIT,
+							  false,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			smu_v13_0_7_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
+							  true,
+							  &min_value,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE: %7dmv %10dmv\n",
+					      min_value, max_value);
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -1160,6 +1345,222 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
+					 enum PP_OD_DPM_TABLE_COMMAND type,
+					 long input[],
+					 uint32_t size)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t offset_of_featurectrlmask;
+	int32_t minimum, maximum;
+	uint32_t feature_ctrlmask;
+	int i, ret = 0;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
+			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				smu_v13_0_7_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_GFXCLK_BIT,
+								  true,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "GfxclkFmin (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.GfxclkFmin = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
+				break;
+
+			case 1:
+				smu_v13_0_7_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_GFXCLK_BIT,
+								  false,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.GfxclkFmax = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
+				break;
+
+			default:
+				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+		}
+
+		if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDriveTable.GfxclkFmax) {
+			dev_err(adev->dev,
+				"Invalid setting: GfxclkFmin(%u) is bigger than GfxclkFmax(%u)\n",
+				(uint32_t)od_table->OverDriveTable.GfxclkFmin,
+				(uint32_t)od_table->OverDriveTable.GfxclkFmax);
+			return -EINVAL;
+		}
+		break;
+
+	case PP_OD_EDIT_MCLK_VDDC_TABLE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
+			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		for (i = 0; i < size; i += 2) {
+			if (i + 2 > size) {
+				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				return -EINVAL;
+			}
+
+			switch (input[i]) {
+			case 0:
+				smu_v13_0_7_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_UCLK_BIT,
+								  true,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "UclkFmin (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.UclkFmin = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_UCLK_BIT;
+				break;
+
+			case 1:
+				smu_v13_0_7_get_od_setting_limits(smu,
+								  PP_OD_FEATURE_UCLK_BIT,
+								  false,
+								  &minimum,
+								  &maximum);
+				if (input[i + 1] < minimum ||
+				    input[i + 1] > maximum) {
+					dev_info(adev->dev, "UclkFmax (%ld) must be within [%u, %u]!\n",
+						input[i + 1], minimum, maximum);
+					return -EINVAL;
+				}
+
+				od_table->OverDriveTable.UclkFmax = input[i + 1];
+				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_UCLK_BIT;
+				break;
+
+			default:
+				dev_info(adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				return -EINVAL;
+			}
+		}
+
+		if (od_table->OverDriveTable.UclkFmin > od_table->OverDriveTable.UclkFmax) {
+			dev_err(adev->dev,
+				"Invalid setting: UclkFmin(%u) is bigger than UclkFmax(%u)\n",
+				(uint32_t)od_table->OverDriveTable.UclkFmin,
+				(uint32_t)od_table->OverDriveTable.UclkFmax);
+			return -EINVAL;
+		}
+		break;
+
+	case PP_OD_EDIT_VDDC_CURVE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			dev_warn(adev->dev, "VF curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		if (input[0] >= PP_NUM_OD_VF_CURVE_POINTS ||
+		    input[0] < 0)
+			return -EINVAL;
+
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_GFX_VF_CURVE_BIT,
+						  true,
+						  &minimum,
+						  &maximum);
+		if (input[1] < minimum ||
+		    input[1] > maximum) {
+			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
+				 input[1], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[input[0]] = input[1];
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+		break;
+
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
+		memcpy(od_table,
+		       table_context->boot_overdrive_table,
+		       sizeof(OverDriveTableExternal_t));
+		od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+		fallthrough;
+
+	case PP_OD_COMMIT_DPM_TABLE:
+		/*
+		 * The member below instructs PMFW the settings focused in
+		 * this single operation.
+		 * `uint32_t FeatureCtrlMask;`
+		 * It does not contain actual informations about user's custom
+		 * settings. Thus we do not cache it.
+		 */
+		offset_of_featurectrlmask = offsetof(OverDriveTable_t, FeatureCtrlMask);
+		if (memcmp(od_table + offset_of_featurectrlmask,
+			   table_context->user_overdrive_table + offset_of_featurectrlmask,
+			   sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask)) {
+			smu_v13_0_7_dump_od_table(smu, od_table);
+
+			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+			if (ret) {
+				dev_err(adev->dev, "Failed to upload overdrive table!\n");
+				return ret;
+			}
+
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			memcpy(table_context->user_overdrive_table + offset_of_featurectrlmask,
+			       od_table + offset_of_featurectrlmask,
+			       sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask);
+
+			if (!memcmp(table_context->user_overdrive_table,
+				    table_context->boot_overdrive_table,
+				    sizeof(OverDriveTableExternal_t)))
+				smu->user_dpm_profile.user_od = false;
+			else
+				smu->user_dpm_profile.user_od = true;
+		}
+		break;
+
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					uint32_t mask)
@@ -1354,49 +1755,6 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
-static int smu_v13_0_7_get_overdrive_table(struct smu_context *smu,
-					   OverDriveTableExternal_t *od_table)
-{
-	int ret = 0;
-
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_OVERDRIVE,
-				   0,
-				   (void *)od_table,
-				   false);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
-
-	return ret;
-}
-
-static int smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
-					      OverDriveTableExternal_t *od_table)
-{
-	int ret = 0;
-
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_OVERDRIVE,
-				   0,
-				   (void *)od_table,
-				   true);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
-
-	return ret;
-}
-
-static void smu_v13_0_7_dump_od_table(struct smu_context *smu,
-				      OverDriveTableExternal_t *od_table)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
-						     od_table->OverDriveTable.GfxclkFmax);
-	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
-						   od_table->OverDriveTable.UclkFmax);
-}
-
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -1925,6 +2283,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
 	.set_default_od_settings = smu_v13_0_7_set_default_od_settings,
 	.restore_user_od_settings = smu_v13_0_7_restore_user_od_settings,
+	.od_edit_dpm_table = smu_v13_0_7_od_edit_dpm_table,
 	.set_performance_level = smu_v13_0_set_performance_level,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
 	.get_fan_speed_pwm = smu_v13_0_7_get_fan_speed_pwm,
-- 
2.34.1

