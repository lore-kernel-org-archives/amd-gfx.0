Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBD7C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA12510E26C;
	Wed, 26 Jan 2022 04:55:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CF710E26C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8JSFL0KSJYTIP6eRoZ195CUZknh8zAB4B1C5VgTnZm4fH8iirLZf4LeXF5XISlvpNTt/4a2W9oc08LGkvxwVhRMAdSX2MfYJz5cLqDQRnYa5mD8BH1dROUE0XtVy0XNKVzW0PGPuUn/y0vcK5cEoEaBa11KrNlzJk21sigqq9MTZg1wV+Sret2crK0jt5R5dPxTz9t8pgM83K/qZerPYS/lPjm+TXov8jx/xwvbZToYZDhiOjCxty5nCxD8OsGW9Qc6j6KIUdcoT5uj7VPHxdsvC9ndySvpvUG6Ng7hVkTmEpdBxLiC7+25OmSUoeJx1+pELmScPd8uMjiLghD3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGWwkyzkogeWESafNIDps7dNncmsIHrNSDvnS/MG6SY=;
 b=GO5LUh4ZIeJQTyRHDFiTycwISIt490qrS1ohHlL5Dd2vxvha9DSGLvpcBH0pkn3pZcr5Bv9RXXC7NwY+XE/vjn37ApZdPiGjsK409i66fUGWpAJW/rRNms0gq4vvSK5CcO4HNDgLJ3OK0Obg5uv9oD9J595tQCXZ6qR3ZesEtDPmAZI1ImT+MkmYiTKwBcYBYGtRIDUnOzeF5ks118hc/biLyWCbd95OYhkVm6nAf2u1sLcCPXUWwV3rpc+/vcpvUzpx8RrxPN+tRf0jP0HNqzv9D6YAguenefEoJIIVVcVsX9sd7QTj3EmwlhcImvGetBQUXDk7SvodCtWip4IDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGWwkyzkogeWESafNIDps7dNncmsIHrNSDvnS/MG6SY=;
 b=l4cFmRFUxy7pF4LYM9hjBSPUG2LFHfXnbyHSzbF9yA/9iV8fVf2RaZzliio4bAJn1VBFgbmpIuu/ix9ZDKu+cBTHKTtCdehm0yaRY8Y/N8pWfiaehZ87sunLnSrgKF2IQxP1fMekOt93Fjqd7b15L1B0Zqcxh7nGgfIw/nOtwDc=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by DM5PR12MB1642.namprd12.prod.outlook.com (2603:10b6:4:7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.17; Wed, 26 Jan 2022 04:55:03 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::2f) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Wed, 26 Jan 2022 04:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:55:02 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 25 Jan 2022 22:54:58 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] amdgpu/pm: Implemention of emit_clk_levels for navi10
 that accepts buffer base and write offset
Date: Tue, 25 Jan 2022 23:54:40 -0500
Message-ID: <20220126045441.3891-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126045441.3891-1-darren.powell@amd.com>
References: <20220126045441.3891-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a163bade-9544-463b-51c3-08d9e088034f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1642:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16428F78FB232E98FE85FFB8F0209@DM5PR12MB1642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9AjDKMSLNxvfDU5QoAFHfkUT4FVo8NyBj9Txx8NZyCqiNHzEUKsCEQ+5NXzHu0vJfM5ybb4+WoQIvmrz+ZRbgw5gka2Pt2QKR98f8xYKZWqcCOaWPcK060IdmhER/Y6GAXGp9sWseQuDDgKyrgtd2l+5k1yy5jn/hxY+mpv5OeRYYsfUnbG1/sxGKe23Q/Fi7kCBhRt9DfchiWWK3IbxZqDT2pCq2So3hCazlSqY7Hc+WYhYZug8qz2ELc0rZwtA4j+jFVv4wcXpbzkwrw+i2WmjUcy6jw+cCeAQ0w3cFpwI4WaNdEp49QQQgwpIX8j9TBgXv+tXCVZ/MImsjbSiVpmoYPLqM1gNF18YVCDYqHTftbSjJ9XHDDjZxEcLHbNFJlbMT2OU27KosXKfJymvMEnj5Q3qTzLPoiNS8WmTAYhLnZj3v6HUo219aQehpvlRC69oBx/YPf+wvlP4EIKIrPIT65JhmUvVCkEAsVLEG3vQqFREpT46e7MIrEZQdq+FmgrewFU38JzRu+1OppS8DkVLpt4HKwdh50RDmXrPbQKod6AJ2Ovr2pCo+fteu4q2YjorkWT2dw9pr2+g0XaG/mZnu8E0s6NAzF507OOGb5nhdp1Kkoh6IBuBtniewMhEfrlUVWSyy/iPgdtE4axt9eiKTo9gbSrVRyiAK6SiNW54AK9lDX9bz8w5B1C/a3kZkAObsFMkwYyw8lSQd/NYwx65kY/mAAVoJA3xaoepKp4BhLkodGaAqw4Nub3lSGOr7jK4rr/G2YOdLmsb9ZSIo7GanlNSZHiNXAaghQdXHQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(36756003)(47076005)(356005)(83380400001)(86362001)(2906002)(44832011)(2616005)(4326008)(6916009)(6666004)(26005)(5660300002)(7696005)(8676002)(508600001)(40460700003)(426003)(1076003)(336012)(8936002)(186003)(82310400004)(16526019)(81166007)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:55:02.3621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a163bade-9544-463b-51c3-08d9e088034f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1642
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   (v3)
     Rewrote patchset to order patches as (API, hw impl, usecase)

     - implement emit_clk_levels for navi10, based on print_clk_levels, but
       using sysfs_emit without smu_cmn_get_sysfs() workaround

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 37e11716e919..4bcef7d1a0d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1261,6 +1261,193 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
 		*max = od_table->max[setting];
 }
 
+static int navi10_emit_clk_levels(struct smu_context *smu,
+			enum smu_clk_type clk_type, char *buf, int *offset)
+{
+	uint16_t *curve_settings;
+	int ret = 0;
+	uint32_t cur_value = 0, value = 0;
+	uint32_t freq_values[3] = {0};
+	uint32_t i, levels, mark_index = 0, count = 0;
+	struct smu_table_context *table_context = &smu->smu_table;
+	uint32_t gen_speed, lane_width;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)table_context->overdrive_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	uint32_t min_value, max_value;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+	case SMU_SOCCLK:
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_DCEFCLK:
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		if (ret)
+			return ret;
+
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			return ret;
+
+		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+			for (i = 0; i < count; i++) {
+				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
+				if (ret)
+					return ret;
+
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i, value,
+						cur_value == value ? "*" : "");
+
+			}
+		} else {
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			if (ret)
+				return ret;
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			if (ret)
+				return ret;
+
+			freq_values[1] = cur_value;
+			mark_index = cur_value == freq_values[0] ? 0 :
+				     cur_value == freq_values[2] ? 2 : 1;
+
+			levels = 3;
+			if (mark_index != 1) {
+				levels = 2;
+				freq_values[1] = freq_values[2];
+			}
+
+			for (i = 0; i < levels; i++) {
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i, freq_values[i],
+						i == mark_index ? "*" : "");
+			}
+		}
+		break;
+	case SMU_PCIE:
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			*offset += sysfs_emit_at(buf, *offset, "%d: %s %s %dMhz %s\n", i,
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
+					pptable->LclkFreq[i],
+					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
+					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
+					"*" : "");
+		}
+		break;
+	case SMU_OD_SCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			return -EOPNOTSUPP;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
+					  od_table->GfxclkFmin, od_table->GfxclkFmax);
+		break;
+	case SMU_OD_MCLK:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			return -EOPNOTSUPP;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
+		break;
+	case SMU_OD_VDDC_CURVE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			return -EOPNOTSUPP;
+		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
+			break;
+		*offset += sysfs_emit_at(buf, *offset, "OD_VDDC_CURVE:\n");
+		for (i = 0; i < 3; i++) {
+			switch (i) {
+			case 0:
+				curve_settings = &od_table->GfxclkFreq1;
+				break;
+			case 1:
+				curve_settings = &od_table->GfxclkFreq2;
+				break;
+			case 2:
+				curve_settings = &od_table->GfxclkFreq3;
+				break;
+			default:
+				break;
+			}
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMHz %umV\n",
+						  i, curve_settings[0],
+					curve_settings[1] / NAVI10_VOLTAGE_SCALE);
+		}
+		break;
+	case SMU_OD_RANGE:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			return -EOPNOTSUPP;
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_RANGE");
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
+						    &min_value, NULL);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
+						    NULL, &max_value);
+			*offset+= sysfs_emit_at(buf, *offset, "SCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
+						    &min_value, &max_value);
+			*offset+= sysfs_emit_at(buf, *offset, "MCLK: %7uMhz %10uMhz\n",
+					min_value, max_value);
+		}
+
+		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
+			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
+						    &min_value, &max_value);
+			*offset += sysfs_emit_at(buf, *offset, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+					      min_value, max_value);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -3238,6 +3425,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.i2c_init = navi10_i2c_control_init,
 	.i2c_fini = navi10_i2c_control_fini,
 	.print_clk_levels = navi10_print_clk_levels,
+	.emit_clk_levels = navi10_emit_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
 	.get_clock_by_type_with_latency = navi10_get_clock_by_type_with_latency,
-- 
2.34.1

