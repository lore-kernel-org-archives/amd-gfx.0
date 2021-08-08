Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8DAC4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376E060F4B
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 376E060F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E81E89CD8;
	Sun,  8 Aug 2021 05:30:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B192289CC4
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOl2n0YfnNvOYNyVEsOoftKRasY4rQj/VN895zWy8MB4IHBt29E3domKBMhjURHwJg/lFPXzsPv73/d+JN5xN184xSR3VHa7CKKDt5+eok2K5Q7sSg4D0a0D+LB7qlefTZ5z0F8CFzA7TSdC6mZi3z25KPhfhJhWsgOOZprgFlIA2naAcPbBQE3B1Moua3KaxOMqsBegJZSXrFd4prM5taZ41+IQ/R3O3vc2+dTPAtUuXK9fL1c2Hbz30wCjQPDef0j4GuJosHtiziSeBK5sO4uSesIAjFsKgeejnkb4actIfjLn9ia1Z9zq4bGNZiIEVoyybExVepiKHqkrWns5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36HN/l5u6goV4/jLUTzkm/78KnW0vH25xOMQ8gp3N8=;
 b=m3YDkS97xo5jzo1rBcVRKAfvSOgHHo1BhskF5O3J/KlPxOZHr41eYOpPWQ79r4bF4h4p5SG/cYFJguyh71/LtZecyJStgO/UMjamFLzk9bEfNmuvRi8iSKaQbhQIRGyas3MyxfcCjkhI85mAFowW9l/cPtNnWypIC1d67QBVSJha4ja/0PJIEf27iadWoPhw7sn8B1k4MpZFkB0H60CWj4aCzSIlzhS9Zjvma/G/kJUu8CVzOOdZLnD4+wwoNYhE8qec001Uuy7g2nEHGYyKnHT8981uZBqE6vHWa6Z1Zm666tdK5oqqU/Z3lJvHrXGegZ1pdQ2NRQxXvoyW4hefSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36HN/l5u6goV4/jLUTzkm/78KnW0vH25xOMQ8gp3N8=;
 b=x0NYinpIJxva+pMfeqi+YD5y1pfdrJsi80cTd40cQh/EIRveDF9X6IkYtzKcDxSEREmtGSip234YIxzdtWzmNzlKJwvSxSmgbli6cVmnRM/OAozJCQMDKaYxDc66bVEYs61ICrCJN6qAdUVgT1Layz9JNCaUs2yVdYoWvCDgQ7Y=
Received: from BN9PR03CA0301.namprd03.prod.outlook.com (2603:10b6:408:112::6)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Sun, 8 Aug
 2021 05:30:36 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::9) by BN9PR03CA0301.outlook.office365.com
 (2603:10b6:408:112::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:30:36 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:30:35 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 1/3] amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
Date: Sun, 8 Aug 2021 01:30:17 -0400
Message-ID: <20210808053019.3310-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808053019.3310-1-darren.powell@amd.com>
References: <20210808053019.3310-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465998dc-3735-45fb-e8eb-08d95a2da65c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4892377E824EDE9747E5FE87F0F59@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWfx4pPt9XV9SdrhPBWVsVCQmPMFwTRUc4WX1RzfiZwKBsZEpgCtDMfecUKtyP/tAhHbuRKDv7L2qUL0c1uulmeDzLXkRsnUI3MXiP4Xh/xFPJEuL/VPaH5KNG1DqNmwWpkXWRM85S7v/LJQGjqUmfQcOYsYLeDvMRQ1XYf941DdGfpnUOW/AqSZFs5Dqpy/ildX2yNtFmLJBk8zIgxQxISr0YxKLsANKRFQ3iQWlSFaGBwJl1AeOXZ7ok8GrJlMJbzC7zb1/J/MUFt2El3ikJh3TEjDLK+F8kwEGRPN7Tv7iRQaBgJFTh3pDPHICWspJ2WPuD6a4YbZDru8GGjaiico7ZJY4RERx3CfT8dN4MxbW6XrQ4dBeL8+nCu4CJdZ0YjzzMg2hf3MEyjPSD/Ad1cVJDnPFdIf4hVIkYybuauOOistFR0WL/sV1ojTohc6u5GC/5P9AWUS6kntBJiTu2j3YuzSAJFgcmrP7flGeqKp8lNsyp7UDjkWaUZeehuxsw4gV6vMhTNtc/IhoaftmjoztPDBl5CFZdUfiCEOhO8V59l18aQtHjrYy+LLOvQyemex22DM2/MrjXezQol83jnkW9pBph+lnbs5jsFkbbAqG1uxDj4gjYRa6z6065qR8JNITF+L3QVTdmud6tW/J6c7VHvvHZJ5n6Yq9ix6hR0IOrD+Fy1LhIq8Ram263wjEaFlatSDI7EaK0oVQpFzujAn+bqduuXLjcqahXmEYSdVUdyIPeTE6u+T33uhXHf/Lk8pvA2TqATRtib7iFwqqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(356005)(70586007)(34070700002)(82740400003)(83380400001)(8676002)(8936002)(426003)(70206006)(44832011)(336012)(2616005)(316002)(6666004)(1076003)(36860700001)(2906002)(47076005)(186003)(16526019)(5660300002)(82310400003)(81166007)(6916009)(26005)(4326008)(7696005)(86362001)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:30:36.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465998dc-3735-45fb-e8eb-08d95a2da65c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
index d7722c229ddd..2e5d3669652b 100644
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
index 415be74df28c..66711ab24c15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -710,7 +710,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 			return 0;
 	}
 
-	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
+	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
 
 	memset(sort_feature, -1, sizeof(sort_feature));
@@ -725,14 +725,14 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
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

