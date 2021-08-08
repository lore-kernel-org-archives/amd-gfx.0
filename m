Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974EC4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A19F60F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A19F60F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A003089D43;
	Sun,  8 Aug 2021 05:33:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD7189D49
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkuGbYb6A3kL/N/RPp2pzZDUK059kRXQCV1yqiS9dnKeEUGwU8yscNH1jHxKIhoIkM5TqGGD6y5XS7ka78GBYT85G8kLv3wo7Ln3qzYgV+RnOHKTjRUcwI/zDlJaH6D/V98dF6zOhx4yMpXg576jT/c/IMhJLy62X5zo2gFYcpkjHjiZDSnvrVForILCFxN6rS9fcw/J69jlg7MwxpqpuGeMrVDQdrj7Zy5S3o0K8udrrElm4KP/02mcUnOrxYcnwdZuLwcpec/p6LsBxr0LU1Q4wAG8rPeicWJg5gcbLjQZJvNksrficoUxpCu3B1j0xWqcL1VaJ5EHO7Ze2eaiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEXb2JneohAQNmWBvjFV8xcGIQyy/dLQEd7v1fXayn4=;
 b=lT0tsu30P0tMateGwpIR2EKCfRILz+XID/GJqn9dIslG4wZ7KaNFUctwHUThFHVOkeQwNGZC/HCVMBvQ/6JrneturKlMQvt0NL7oEvrau1Tr3rpYe2rB70pgnrmgsVoZPBJP97og1e8Kr5GTXwPXQlQWBjrRY3tt50zVisUS3WbWzc25wyPPvU5PMag6+fdnxGt7Jvzx6fhaxClwsRG/q57gvc8CS9V8K2EUHO0sVvV8G8qq6W84Mm1laP7Igw8FDRA3RwEeu06mRbClwCPEH2W4QeGdI3Ra1crrCFnQtflcHC0T5zLNw4qrVjp3USoTeALy+cfVkG5PZgC20B3+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEXb2JneohAQNmWBvjFV8xcGIQyy/dLQEd7v1fXayn4=;
 b=g4s1SAWAsdqpo6ZLVkV7D4ltGnMw02Mcybog5sS6NBo074f1byg2gAhDm2gdpJIJ5NxOVYqB0FjfKaFM2CrdBL9/tVbSzsCUHm1xmysvHjuqvkJKG70Y99lbe3cuP1PnHVo+st8s1KgtsPv/DlvCnelOGi9sPVJa4qRPRRt+aPM=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 05:33:25 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::9f) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:33:25 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:33:25 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 1/4] amdgpu/pm: Replace vega10 usage of sprintf with sysfs_emit
Date: Sun, 8 Aug 2021 01:33:09 -0400
Message-ID: <20210808053312.3423-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808053312.3423-1-darren.powell@amd.com>
References: <20210808053312.3423-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f232a39-a3da-4f06-5600-08d95a2e0b66
X-MS-TrafficTypeDiagnostic: MW3PR12MB4393:
X-Microsoft-Antispam-PRVS: <MW3PR12MB439369498EA502CFD85500D5F0F59@MW3PR12MB4393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08zUsDXEwi3Q/RpWtoDIsiQHzgzsiildcRUNCusbTWMjwMcqmoYPTg7PMvdf8zuJy87Q+3awhY7uNjqRU66qnhcTBNmS68KWPowigx7i/9giXDxhSuvQwiDWi/jrHFk3mU7Ztz1XBvWc9zvnu+9EghNq0u0AdXnTOHnMVwH/5mvgw/M+B87LBB/vF2NsZm5ZYGNTrppoXMfJdlWo4dEhKSWUBIoQ5SHzPeSNeWOk4LJgxqQKlLizUV5lsP3TcXg3BAq7cj0MqUQBAY3TVScT+k56f9JrL2F7yehVsZCr+XV0mYzms8EMEyA+8Dsfdu/U+u2seqECFK7z5ClhglvKXPvpzmnOsriK4ZrovRdVHuLHnID9q5ehHnOvipBz7pCSwu4GdCpoHPZAx8PBKnnbrdmoY4Ob70pBD2UG3nReRRppEtrbbOsy7SjAuxYMCQgjbcChq2tNR2yeWOrvMP/j6Vl3wykguaG5o1MesGXf5R2KrDFpdQqzOLqBSjdJdEYpSk0RbdahNgXjdW4LQHXTJQmR0fO+yfylAzZhWmXue7qU1LDMCH2fWQd6xiOhnidOCO1YXtGpwYoo2JqXH3/Mws7nZZXoWxznV3kCfYxC2tZwkPpffQx8vSbYp80fGfuV1oSaxEQ8QIe0LoFEpLF8xn7mamVZhQSxPWiZ5fq9RqRKB7tPy1p2k3Cvtb8CW9Ewpm7DU6zLdyT/bCi2HJm3gWg4K580DzrMWGo2uKnDfjXUEm8LoyXdS6HDFhvqBv4oegDZcGuRfwfqyK2SnnN5Qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(5660300002)(316002)(86362001)(2616005)(82310400003)(6666004)(70586007)(2906002)(82740400003)(70206006)(336012)(4326008)(26005)(83380400001)(47076005)(6916009)(8936002)(1076003)(36756003)(7696005)(34070700002)(81166007)(356005)(186003)(478600001)(16526019)(426003)(44832011)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:33:25.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f232a39-a3da-4f06-5600-08d95a2e0b66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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
  vega10_hwmgr.c

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_features
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 25979106fd25..621a49f86b0c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4553,13 +4553,13 @@ static int vega10_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 			"[EnableAllSmuFeatures] Failed to get enabled smc features!",
 			return ret);
 
-	size += sprintf(buf + size, "Current ppfeatures: 0x%016llx\n", features_enabled);
-	size += sprintf(buf + size, "%-19s %-22s %s\n",
+	size += sysfs_emit_at(buf, size, "Current ppfeatures: 0x%016llx\n", features_enabled);
+	size += sysfs_emit_at(buf, size, "%-19s %-22s %s\n",
 				output_title[0],
 				output_title[1],
 				output_title[2]);
 	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
-		size += sprintf(buf + size, "%-19s 0x%016llx %6s\n",
+		size += sysfs_emit_at(buf, size, "%-19s 0x%016llx %6s\n",
 					ppfeature_name[i],
 					1ULL << i,
 					(features_enabled & (1ULL << i)) ? "Y" : "N");
@@ -4650,7 +4650,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		else
 			count = sclk_table->count;
 		for (i = 0; i < count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, sclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4661,7 +4661,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, mclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4672,7 +4672,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
 
 		for (i = 0; i < soc_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, soc_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4684,7 +4684,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
 
 		for (i = 0; i < dcef_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, dcef_table->dpm_levels[i].value / 100,
 					(dcef_table->dpm_levels[i].value / 100 == now) ?
 					"*" : "");
@@ -4698,7 +4698,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			gen_speed = pptable->PcieGenSpeed[i];
 			lane_width = pptable->PcieLaneCount[i];
 
-			size += sprintf(buf + size, "%d: %s %s %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
 					(gen_speed == 2) ? "8.0GT/s," :
@@ -4717,34 +4717,34 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
+				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
 					i, podn_vdd_dep->entries[i].clk / 100,
 						podn_vdd_dep->entries[i].vddc);
 		}
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_MCLK");
+			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
+				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
 					i, podn_vdd_dep->entries[i].clk/100,
 						podn_vdd_dep->entries[i].vddc);
 		}
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.mem_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
+			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
 				data->odn_dpm_table.min_vddc,
 				data->odn_dpm_table.max_vddc);
 		}
@@ -5112,15 +5112,15 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%s %16s %s %s %s %s\n",title[0],
+	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
 			title[1], title[2], title[3], title[4], title[5]);
 
 	for (i = 0; i < PP_SMC_POWER_PROFILE_CUSTOM; i++)
-		size += sprintf(buf + size, "%3d %14s%s: %14d %3d %10d %14d\n",
+		size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n",
 			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			profile_mode_setting[i][0], profile_mode_setting[i][1],
 			profile_mode_setting[i][2], profile_mode_setting[i][3]);
-	size += sprintf(buf + size, "%3d %14s%s: %14d %3d %10d %14d\n", i,
+	size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n", i,
 			profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			data->custom_profile_mode[0], data->custom_profile_mode[1],
 			data->custom_profile_mode[2], data->custom_profile_mode[3]);
-- 
2.32.0

