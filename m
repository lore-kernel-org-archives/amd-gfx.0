Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5700AC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 01:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE3F10E20B;
	Thu,  1 Jun 2023 01:59:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5569E10E20B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 01:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWujeVRXOnbYiCF1gAoiZzXYmU875Xe0Bdqgr8DWRBelUgeqSXGgYrU7O64XB9vULEoFu5K9LM/ZeArESiD2XipMu8XEC+AtbVvI7/gfyQDpXCPrYtMX13XS6Je+shcanB8g9+oew/Eqmk48jiFYt+NtH43fmJAwyyCAzAQ4KqrM8L909qcWUHXfcONjzS1xKxkC7SBlT4Jfcm86OYLj+ui49hShnBCrUi3ob3TPHCo0Usf+6orxsx3UOMBhuE9yUMZw4OquoqvOHoUp8Bktpd0uKBZp3UDAOtiQBUP0Zw0cHfXXwcM8QZlT3iOamn/b5YAoOzHcGDjES7kXUyfa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOUlc+5MXRu+iKB7ojtyYccEJA4/mnJPedkwESHiuRk=;
 b=ZchX13KlDfs0Ee0zSHnEvaVTzvIui1Q4gdc3ACqmLtwNVOusM7qjc3kUGBYZQQc0CoXCDLm4ko48Umntg2owbCVyBRdlhL/lYeiO+jSGm42CXf1eGZwoeo1UAhHInECVFteDv1TyabGhTQ15jFyMbWkVlOtlEGyP0LYEY525YYQiaq6ATh3FrZkHBQA6Si1jtOOP/2j1lR/30lmt9RdsotksGwpoKLrwm6bg0km80UMe13La/jJ9pFhw6/4OpYWmoo2HbyHyw8hcyiyqxOeP/m/fEfvCuLt9yrA5R3sHQr3CA32/LlFTSEx5YvbBs/wMCwYM1b9K9tZDaADT9AjhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOUlc+5MXRu+iKB7ojtyYccEJA4/mnJPedkwESHiuRk=;
 b=G/w5ZY+hWHP1/gTCV2v9TsrzHq6raXN4yZQuoXY+OT/O4w2HnpozQ9Kz4a7pAVjfY17mc2gEPkxsA/y1Le7e3J6mZhanATcZUrQLWUJaVTNmUKhDSMTi4xbJamYmW97r7G58mvINegBSmO+Cpn+kE8wnSR4drb/JlSZrT8w8S00=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 01:59:37 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::32) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 01:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 01:59:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 20:59:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/pm: fulfill the OD support for SMU13.0.0
Date: Thu, 1 Jun 2023 09:59:04 +0800
Message-ID: <20230601015905.49427-4-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: e9df14a1-0c20-4585-dd11-08db6243dab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvHKeLG90F/R67QcjHIikgN3TcXmhOmMVf6xVyovhAizgGTg8BuulHs4oIxVzuUmGBi/9QhdzXl6Oy8YXjP5kKrr/fQvPlrAhfQQ34kInUY4vFXf98CsXi29VPHxpCe8Ei4T5hG4ZoC2HwCYbDDkkwXvEjB9b3UoV2DdD7474SMnkvKk3dkdDtgRQdrO0dTz+0CMeOQ6n0GZKpu9jNR1HgFrCE10Ap/egCsb8zEez9ByoZ/W403qCJMgWYgyzv/F2mee115vwpw3WJH/1+vPOMw2iWEPFd5W4fNLuo4/jWTX2CHxcvaRR3yr2jB1OHs5Cx4+y9G9MhwAg7jXD66K27d64U8q00yklWJY5AFkqFNAiAHkt9ISzVdj9e0hLWzmyl1vGMCP6wc2IxymzydT0ZqNKwUthB+cp/jZkeYjQvOLxYaH0F+UJdHG7IVl2Hi+MNdYJmR4xySzHmsgZVY6LorfkemJMJkEx+R3oNBK4Wu5T2t2wqnMaNUg7TsXpw94GcmJSVFP+9cIiaUBC3QX/3QYdEfEDiQqx65bL+MrmGDTaoOcVVOEYN2EL/0jOOqTMut3pqdUjoks7R8OwM4DQIBKyzz1CBi+WQnp/AgFQKlSjSR0Iy8rCEy2i/VhB+e/krykZugWf8X6MCbhHZm1IP+rO0z459GKd7E4RPQxkd+rI/OFSWmKMR3QIAgFUjf1WV73Xom9PbxnwucQnfMeb8vzZw6hda/Rd7vg3o6TmLma8jVwgv/UX9okZ+l8YSVTjhJtN21pQ4q0bKMz0qDobQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(81166007)(82740400003)(356005)(6666004)(478600001)(40480700001)(83380400001)(426003)(36860700001)(336012)(47076005)(26005)(186003)(1076003)(16526019)(2616005)(40460700003)(7696005)(36756003)(4326008)(6916009)(316002)(70586007)(70206006)(44832011)(8676002)(8936002)(5660300002)(30864003)(2906002)(41300700001)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:59:37.4245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9df14a1-0c20-4585-dd11-08db6243dab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 445 ++++++++++++++++--
 1 file changed, 402 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2a9840c54f72..e7eb517ed5f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1037,17 +1037,119 @@ static int smu_v13_0_0_get_current_clk_freq_by_table(struct smu_context *smu,
 						value);
 }
 
+static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
+						int od_feature_bit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+
+	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+}
+
+static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
+static void smu_v13_0_0_dump_od_table(struct smu_context *smu,
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
+static int smu_v13_0_0_get_overdrive_table(struct smu_context *smu,
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
+static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
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
 static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					char *buf)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = 0;
+	int32_t min_value, max_value;
 	int ret = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
@@ -1164,6 +1266,89 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					"*" : "");
 		break;
 
+	case SMU_OD_SCLK:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
+		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
+		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+
+		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
+			smu_v13_0_0_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_BIT,
+							  true,
+							  &min_value,
+							  NULL);
+			smu_v13_0_0_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_GFXCLK_BIT,
+							  false,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
+			smu_v13_0_0_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_BIT,
+							  true,
+							  &min_value,
+							  NULL);
+			smu_v13_0_0_get_od_setting_limits(smu,
+							  PP_OD_FEATURE_UCLK_BIT,
+							  false,
+							  NULL,
+							  &max_value);
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+		}
+
+		if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			smu_v13_0_0_get_od_setting_limits(smu,
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
@@ -1171,6 +1356,222 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
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
+				smu_v13_0_0_get_od_setting_limits(smu,
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
+				smu_v13_0_0_get_od_setting_limits(smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
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
+				smu_v13_0_0_get_od_setting_limits(smu,
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
+				smu_v13_0_0_get_od_setting_limits(smu,
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
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
+			dev_warn(adev->dev, "VF curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		if (input[0] >= PP_NUM_OD_VF_CURVE_POINTS ||
+		    input[0] < 0)
+			return -EINVAL;
+
+		smu_v13_0_0_get_od_setting_limits(smu,
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
+			smu_v13_0_0_dump_od_table(smu, od_table);
+
+			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
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
 static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type,
 					uint32_t mask)
@@ -1368,49 +1769,6 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
-static int smu_v13_0_0_get_overdrive_table(struct smu_context *smu,
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
-static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
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
-static void smu_v13_0_0_dump_od_table(struct smu_context *smu,
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
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTableExternal_t *od_table =
@@ -2317,6 +2675,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
 	.set_default_od_settings = smu_v13_0_0_set_default_od_settings,
 	.restore_user_od_settings = smu_v13_0_0_restore_user_od_settings,
+	.od_edit_dpm_table = smu_v13_0_0_od_edit_dpm_table,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v13_0_0_populate_umd_state_clk,
 	.set_performance_level = smu_v13_0_set_performance_level,
-- 
2.34.1

