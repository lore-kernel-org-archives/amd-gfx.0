Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE84FC07E96
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA2D611C1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA2D611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D00A89C89;
	Tue, 13 Jul 2021 04:03:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DA089C89
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 04:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqnXCv3kWGnrbmnUkt8fZdemZ1W9zf7OldMHA0RnYDGZWB3ozodUKQXSBiW3d2FB10Qu+KaM+BLkU2K5bvFjBm2LSFtr7iusOc3dCcOztr/ksz9Hd0hxRt2FBM9acdm7d5naH0rpFIT+uWESgZbgnXvzUpbFFjy3UXQkgEn7EHXv1akM9Qf4d1L+XKR24RuS+ZvP8W66dIVUtsbNYkJg4YvPBnnNqlkHZJt2otX9mI5iMumfzNlup6peWE1bvcmubC8vRn7dqZbOpQkItH3s+B10TegXS8qXoqZmiKLiOtLbI47aSdIiuCPtQKYIvHSqkmvsie4bjiUYjW6DZXJilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYuZVKUnI1HHxHSdokZUhuVEAIhLJSFkQDzO2Uxhzhs=;
 b=jdsnv/XGiOEimoOR2ZtQQAQxG4pm7umiGFIna+WXs3wbpnoVl+ON5rqDZ+wQrU2QXE5K0U2lNcOWqtbcaztxWdvDmzTOF6woN7MkRMFtm2IgcuCW/M7jLgODST7/O8WVXqiofjogwfXWYl7dGg0mEnZPnJyPgQqFLeFPnKL5BRp5KjOCXssX9B85Rr3Yhib2FJdoIyJWlDgQ20HW8Js3GNbTw8GXZw5xbTYniNn8+5AGfJQW7H2n2Oe3ts52Dq5mIyrz5G4sxkwjMVXStai/5A2O/mSb+MOoPCm1K0MKsNYDpILfvfzjdp3hdMf93DijKXVOAiLxZWMQbkoyasoygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYuZVKUnI1HHxHSdokZUhuVEAIhLJSFkQDzO2Uxhzhs=;
 b=llfru+vt3nmQK4qt71AF4mct0rDAVbGDORILbo41uDo0Y3taGbZMtpe5rGJ36e5HiwKXbh09EkXN6OMiZRknZ+xbTUBwVWx3Mk1v1FHnWsVm6LpPiCJu3sqxdo5nJvHQdrJDJfrNu13Yh9toXSc70n/yMy+cEWQwq77Za0QYJxc=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 04:03:43 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::9d) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 04:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 04:03:43 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 23:03:41 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
Date: Tue, 13 Jul 2021 00:03:18 -0400
Message-ID: <20210713040320.4657-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713040320.4657-1-darren.powell@amd.com>
References: <20210713040320.4657-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad9fe8d-5ada-4b02-3303-08d945b33493
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3080C00B6F5A1005CACAF37CF0149@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x01K6HXrTrkVwvEanGfs5AxJAQEXYOnNT5MVQkLsKgLZzRyCaOQct/Cl4aOD0tBiOzUckLZ+iWQm+ZbDPSmvnzLus47SQCiPs1CXPJ2ej5cESOg8M8KGQtABW0s7ZMlwRD+VRYJIYBIFD0pSwDe0EfFfKCF3q+8AKYLUeDZo2Iwyz5HCkjIVyAS/nxeVWKFK3KoNeZlWIlqsRhIwoh6VIBzQLjMb9BIBudmaMdAppELXMtzCTw/gixU+L+dN3aRA3tFjXiyaqJOXqOQeCYC99/53qUyJLfdKZOdKu9HY/dVjuNQXOjrhOvH0/O8bWHhkF3eN7zntY1sp25nLNyNXmFS5NhKgGi27grTPgyMpUvNjCXPSuWMjv29sT5cnNrRFCNXN7pFJYfewX3WykTwBxXg+gB9HnsUqz/QeoEPt+30NtAIq8j80Sh/mwC618VPZBu/3bhqtiYB5XMGmP8OcxHqpoBEIkANwh6sni2d1vanYpdeBkhvj7FcPLom1ZaZpyuScE+AnlkoTRM4HHSbM97a1bynAK4UsuYwXQozTJE4ppnfVrQQzCvXicxJpGZrgNp7COA4uPu+MO/bC/Vm7ELrwcl0asMR075c97ZL4arAeTNsIi8Jleh31v9NwTjuO/+EF20BPEGVbMv2F9uK1Bp20nTIQlnbZSj0jJkqQeVcJsG65gs00KECT6y9rV91m3ETm/1o7QnGl07lXRCdvO+bTeqNaTljIPDPXsnf0c3g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(44832011)(70206006)(86362001)(2906002)(70586007)(1076003)(6916009)(2616005)(316002)(426003)(336012)(26005)(16526019)(36860700001)(186003)(36756003)(4326008)(81166007)(8676002)(356005)(82310400003)(83380400001)(7696005)(6666004)(82740400003)(8936002)(47076005)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 04:03:43.2630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad9fe8d-5ada-4b02-3303-08d945b33493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 initial modification of files
  smu_cmn.c
  navi10_ppt.c

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_sclk_od
pp_mclk_od
pp_dpm_pcie
pp_od_clk_voltage
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 61 ++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +-
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 1ba42b69ce74..409019b733dd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1303,7 +1303,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 				if (ret)
 					return size;
 
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
 			}
 		} else {
@@ -1321,7 +1321,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
 			for (i = 0; i < 3; i++) {
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, freq_values[i],
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
 						i == mark_index ? "*" : "");
 			}
 
@@ -1331,7 +1331,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
-			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
@@ -1352,23 +1352,24 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			break;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
 			break;
-		size += sprintf(buf + size, "OD_SCLK:\n");
-		size += sprintf(buf + size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      od_table->GfxclkFmin, od_table->GfxclkFmax);
 		break;
 	case SMU_OD_MCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
 			break;
-		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "1: %uMHz\n", od_table->UclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		size += sysfs_emit_at(buf, size, "1: %uMHz\n", od_table->UclkFmax);
 		break;
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
 			break;
-		size += sprintf(buf + size, "OD_VDDC_CURVE:\n");
+		size += sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
 		for (i = 0; i < 3; i++) {
 			switch (i) {
 			case 0:
@@ -1383,55 +1384,57 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			default:
 				break;
 			}
-			size += sprintf(buf + size, "%d: %uMHz %umV\n", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
+			size += sysfs_emit_at(buf, size, "%d: %uMHz %umV\n",
+					      i, curve_settings[0],
+					curve_settings[1] / NAVI10_VOLTAGE_SCALE);
 		}
 		break;
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		size = sprintf(buf, "%s:\n", "OD_RANGE");
+		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
 						    &min_value, NULL);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
 						    NULL, &max_value);
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+					      min_value, max_value);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+					      min_value, max_value);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+					      min_value, max_value);
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
 						    &min_value, &max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
-					min_value, max_value);
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+					      min_value, max_value);
 		}
 
 		break;
@@ -1730,7 +1733,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 
@@ -1750,10 +1753,10 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 			return result;
 		}
 
-		size += sprintf(buf + size, "%2d %14s%s:\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			0,
 			"GFXCLK",
@@ -1767,7 +1770,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 			activity_monitor.Gfx_PD_Data_error_coeff,
 			activity_monitor.Gfx_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			1,
 			"SOCCLK",
@@ -1781,7 +1784,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 			activity_monitor.Soc_PD_Data_error_coeff,
 			activity_monitor.Soc_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
 			"MEMLK",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c902fdf322c1..02e80d3adf25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -516,7 +516,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 			return 0;
 	}
 
-	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
+	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
 
 	memset(sort_feature, -1, sizeof(sort_feature));
@@ -531,14 +531,14 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 		sort_feature[feature_index] = i;
 	}
 
-	size += sprintf(buf + size, "%-2s. %-20s  %-3s : %-s\n",
+	size += sysfs_emit_at(buf, size, "%-2s. %-20s  %-3s : %-s\n",
 			"No", "Feature", "Bit", "State");
 
 	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
 		if (sort_feature[i] < 0)
 			continue;
 
-		size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
+		size += sysfs_emit_at(buf, size, "%02d. %-20s (%2d) : %s\n",
 				count++,
 				smu_get_feature_name(smu, sort_feature[i]),
 				i,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
