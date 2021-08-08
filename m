Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE7C4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D2B60F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79D2B60F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C808F89CFA;
	Sun,  8 Aug 2021 05:30:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006C889CE0
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crnR4xcI4kp+Rzu4KZ7upRaCaaEAn4bOBTMGnt8Q/+Yod4fqAeMdr99ICQNj9mXpOsVOz74p0tyFyEro+0nfc2Hb9M6ABMS1jJisXerRjOCE1W3HKDQPK+73tQUAdW/oXNwIiFlCZDfQh/As96/cwP1YKReb9DkbHK3SkZnCg5XZ3lXQyyaDLKlDyzYhNtYvjtIoF+vRr7GQZTBzUo+rM9zTo/8Ad746/7E+qEFtsazUfIkeBUfLQbkJcG2WTBeHzfYGTYVgUk6mOenxgPH+By7bJbLxamfI3ZchH2RvRf8AWNk27qdsP8Qf0WiKJ1nO2q0cMumMtrkbfdv9pHUyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNp+4scF08fNn9FGHN7/7qexF9DEKbGpvgwPrPdiI5s=;
 b=ahvIIKCypNuZx3WLx/qZLpe3ZZf6hD9wnXykcNdgM0g572oec8oaovc85P1ELZbR58vZ/NDi2+acWeV3r4dCUmyT6zoeE4bRzN0ItEzK+6gmE2pbTVkRidLQbggAdSCE+d5/0hrUyI8s6ViClZVMyy8PaVNgVtpMdROey92VmUuzHwz/YtJS23y5jPKCy8BnxgTy/y/d5SOFj70tTzaFK74n95zXCAiydeeq0y/MnQfzwOEU3loqhJU75xy/UyhMbPUNgKcYqIsv6R9gk0eBNa9istkl5RtPB6HaSNY3nLPqUCblYknPQS7D8khb7z1zTaJbzlLwuABl9mUSVe7A/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNp+4scF08fNn9FGHN7/7qexF9DEKbGpvgwPrPdiI5s=;
 b=aX60oMIwgsC6NQteTUVrWvYGxH3ZbyQT0diXFp6KX042Xy+uNtO3GnndedYZrMUdqx0Aa2RGyl5WvDq550g8B5qgFMdB2g+PbVGK9VQSfLyPNVoXCw1uXwnaSmUZFEJcGCX2e/5Xrwm9QWPCUcseGZIrTcw4c0vTgLtNdcgoMz8=
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Sun, 8 Aug
 2021 05:30:41 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f3) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:30:40 +0000
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
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:30:40 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:30:36 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 3/3] amdgpu/pm: Replace smu12/13 usage of sprintf with
 sysfs_emit
Date: Sun, 8 Aug 2021 01:30:19 -0400
Message-ID: <20210808053019.3310-4-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89c96a69-44f6-492b-6b95-08d95a2da93c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4178:
X-Microsoft-Antispam-PRVS: <BY5PR12MB417833D8A5C1BD61FD37CAD4F0F59@BY5PR12MB4178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9mHenq1U5kK2tnkSblkLPGLE59AU7ZFq1ZX4f+/pI/zC/nBKP6ykhYQXOhOKhq2OPs2XlZZnxbUvzRwaEmPbAoxJY07VBThbPPoMbW0Ans6/y/XBbpP8V8ooQQSrkw3UBl/9QeFE400F0YJ1aeHUqu7JRZGl+UTSAwAx0HqkvbZih5TQNkqL/6AzEz9P0WW80aFv+jie2w5Scj118g7+ok2XJUqWPLOfXP03JC9qrH+PceP1s1svJz4XkW9s7Mg72uG+7Y2QHhCcq8MCgrsyQl872D/MJbePSkXjyi+9MC65yuEneM/4VKfVk1Cn/QujxMTO7kgOenR0nmvZox+CmEAkAya6I0u+3eZg5ge1WYBVv8AL+OTlr2I3CM1kQZGAnXzZivWhqEhXmUv8fHlYuU4XnCKDaPq3wGnhpsQdJ2XcXA5uZ7k2gG/l/ZUNL1io5qlgOG/hw/AEbQU/h6blJmlRkm1ubxmay0IqnX1dSQ6VhHLU9RP5c1risrVoxnZlI8XLGuODTgitJ/DMEy/x1nN+5KzbJ1WJiiFWSpwRJHISL+G+Yi+T6eFhhh1M6gVYS7uyTZE8xB4ceZNu1brG/q4M9NDU0m55mqSHZyz082cvoRUGXu8rR1aESq2lTL+ZtxoxzYXEdj4Kjqz/p1O27d2DiwGB+PQzLvb5+K5JgGqonEQkW2CJzUFr2o2m+4kHNlgc3Oh9wtoEqjWzr0UjsY/6PWq6sah0BdGbfZZHSIXDo8Z9DO2l47MqxyFzbT3c3TR44mXnleM72MudmvIrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(47076005)(34070700002)(6916009)(508600001)(4326008)(2616005)(70206006)(81166007)(70586007)(86362001)(2906002)(7696005)(6666004)(316002)(336012)(426003)(356005)(1076003)(83380400001)(16526019)(186003)(26005)(8936002)(8676002)(5660300002)(44832011)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:30:40.8543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c96a69-44f6-492b-6b95-08d95a2da93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
  renoir_ppt.c
  aldebaran_ppt.c
  yellow_carp_ppt.c

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 +++++++++---------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 21 +++++++++----------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 14 ++++++-------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 9a9c24a6ec35..b39138041141 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -510,16 +510,16 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 						0, &max);
 			if (ret)
 				return ret;
-			size += sprintf(buf + size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
+			size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
 		}
 		break;
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 			max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
-			size += sprintf(buf + size, "OD_SCLK\n");
-			size += sprintf(buf + size, "0:%10uMhz\n", min);
-			size += sprintf(buf + size, "1:%10uMhz\n", max);
+			size += sysfs_emit_at(buf, size, "OD_SCLK\n");
+			size += sysfs_emit_at(buf, size, "0:%10uMhz\n", min);
+			size += sysfs_emit_at(buf, size, "1:%10uMhz\n", max);
 		}
 		break;
 	case SMU_GFXCLK:
@@ -536,12 +536,12 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 			else
 				i = 1;
 
-			size += sprintf(buf + size, "0: %uMhz %s\n", min,
+			size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
 					i == 0 ? "*" : "");
-			size += sprintf(buf + size, "1: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
 					i == 1 ? cur_value : RENOIR_UMD_PSTATE_GFXCLK,
 					i == 1 ? "*" : "");
-			size += sprintf(buf + size, "2: %uMhz %s\n", max,
+			size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
 					i == 2 ? "*" : "");
 		}
 		return size;
@@ -588,14 +588,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 				return ret;
 			if (!value)
 				continue;
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
 			if (cur_value == value)
 				cur_value_match_level = true;
 		}
 
 		if (!cur_value_match_level)
-			size += sprintf(buf + size, "   %uMhz *\n", cur_value);
+			size += sysfs_emit_at(buf, size, "   %uMhz *\n", cur_value);
 
 		break;
 	default:
@@ -1118,7 +1118,7 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 562783d0302f..c8eefacfdd37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -735,14 +735,14 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	uint32_t min_clk, max_clk;
 
 	if (amdgpu_ras_intr_triggered())
-		return snprintf(buf, PAGE_SIZE, "unavailable\n");
+		return sysfs_emit(buf, "unavailable\n");
 
 	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
 
 	case SMU_OD_SCLK:
-		size = sprintf(buf, "%s:\n", "GFXCLK");
+		size = sysfs_emit(buf, "%s:\n", "GFXCLK");
 		fallthrough;
 	case SMU_SCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
@@ -779,8 +779,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		 */
 		if (display_levels == clocks.num_levels) {
 			for (i = 0; i < clocks.num_levels; i++)
-				size += sprintf(
-					buf + size, "%d: %uMhz %s\n", i,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
 					freq_values[i],
 					(clocks.num_levels == 1) ?
 						"*" :
@@ -790,14 +789,14 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 							 ""));
 		} else {
 			for (i = 0; i < display_levels; i++)
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
 						freq_values[i], i == 1 ? "*" : "");
 		}
 
 		break;
 
 	case SMU_OD_MCLK:
-		size = sprintf(buf, "%s:\n", "MCLK");
+		size = sysfs_emit(buf, "%s:\n", "MCLK");
 		fallthrough;
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
@@ -814,7 +813,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -837,7 +836,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -860,7 +859,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -883,7 +882,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -906,7 +905,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 0cfeb9fc7c03..0f17c2522c85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -572,7 +572,7 @@ static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
@@ -1054,15 +1054,15 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size = sprintf(buf, "%s:\n", "OD_SCLK");
-		size += sprintf(buf + size, "0: %10uMhz\n",
+		size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-		size += sprintf(buf + size, "1: %10uMhz\n",
+		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		break;
 	case SMU_OD_RANGE:
-		size = sprintf(buf, "%s:\n", "OD_RANGE");
-		size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 		break;
 	case SMU_SOCCLK:
@@ -1083,7 +1083,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				goto print_clk_out;
 
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
 		}
 		break;
-- 
2.32.0

