Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987DFC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4318760FED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4318760FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5818489D6C;
	Tue, 13 Jul 2021 04:03:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D367B89C97
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 04:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpg7v/RPjUjwRT5KkdDBk5sTWK58F3wGqO1yJOLhFPh30OgLSkHY6ZV4T6vFOg2oCkEVs3fiqQrYEWv81PsmuhkPagtdgYyMIoRmASSxCVcqJ9dBrMwBeaVv6XrSM1BLHN5CaP1vzEwGWdCzza16iHGZ3K3WPKR14DyulzWJ6BqkZJl0lAtY4QoH1yv0sWfqC7GXqj8ApHNEPkb9aFPIR4sWPyg2wy+s+hiUWcOZf3P5oTI0rnezMd+nzZ0lvuTdEb8dC7wI//mvVWmD4i+JvqCVqNjlLCvbbnfLczMmoRgSNgNbTnip81v4Y3VR5S1K27UCf9cMNa4540MNewKdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMMKnuq+21diSlSa65WODwAD11ds3joV+kFuKFvo9+Y=;
 b=O8qQ3hPrbh0iPxKhY5QGZws+nMu3EzfRsTBKiMqd/RWYfZtoSry91AiwRR+fzHJdM5slK74b0ctW/OMWe5k9RJvhHk4uKJga5xtP1o14/DtaiWw/2wFqDIdQ7+qjEV/llM5/Rw5UP5G7v/Rah8E6jgA77O07tNfroLIkLOY01R9DfEjX4d2M79gEX4CNS3UfTW9tbZLYRBXgPiJMDED7WzbOEggOOc6RzgR3TUUeZjiX3PbvPke4ryVf173DxlhocUEugeH6mxDq+XPszEWkkPSrYihqTXX38ognRxWDxR+zartFasYzCRifvDoO0YysEgHex52yph1yAeKaXbThWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMMKnuq+21diSlSa65WODwAD11ds3joV+kFuKFvo9+Y=;
 b=KXshuNzNgH5C1dwbICgUnVbENJjnQ+WXu5MZMGVATAQk23QKE0CkohE0/8ujvcakmP8BdnaHvo2TIvjY2ekJ2pk8XLe6KP/D1h4yRPSa78uhI3g9dMgRG1FhW+urWI/BY+KBRvh7nnPO0dR7L7x5O/vRhH3ujFb//5j0DDZv6U4=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 04:03:45 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::60) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 04:03:45 +0000
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
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 04:03:45 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 23:03:42 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] amdgpu/pm: Replace smu12/13 usage of sprintf with
 sysfs_emit
Date: Tue, 13 Jul 2021 00:03:20 -0400
Message-ID: <20210713040320.4657-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713040320.4657-1-darren.powell@amd.com>
References: <20210713040320.4657-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c617859-762d-44a8-e3ea-08d945b335bc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1403A9817AADCE2FE1BF3437F0149@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+PsTNm898MirGGQpi+14C1tDy4gJFqOHhjbtHeSShArUwsqIsHVzu8htkei2/KWsSuRUPipN+2YdYY1EtHys3PTIfE/8KW8vFSbDjdFCpfRoEQdSHv76tQbcnMaSV48T38Ob58FBDeYQAGAa5ei1ANnhVkijIpjdqgLK7ACIta78fnFqepuLjfCt2kUV4vF+Zdn5mrpZlFzPVIREVH+5E4bUg3iuHuzogggdqsvtpFpMV4DDU+Yn/biPTXJk3TxAZPFxhuHgQrx/2lNFxAMszjF1ydl51iFnZLvImHa6S+yhv+KWepI5zkjuTaQHhJ4MZRp5kPwEvdycLFqGM62iR/5PGECtz0fIt4kCiq5M8l5UesEqEAe+8FP95kP/Ppupykev1tJlxHDMii1bjXKKwaeCYPdmJvDEszotzmOJbzPdPbaA86W8CJvFuItqlwtoKvybff+7kawbk5fU2r2Sr+IBzl6Y7pbVYNHK7n7y3vwmsVTUlJVj0zIL9etgT4mMk2PuZ67/jVMuXkrobuQrYzZnzbT8ClePjMRUNogvbNm2Bo3AKUu6wGd6MzEjrtGL4DQokQgiJUAS2y7xPPgnvhE4rANsK6tARk0VcTHheohnm9eGJJHkqQDTsB3XHc7oiX163Ky5jrfoBZqyYEjxjzGvu65EI/uCliL4+8cwpaZujujhhM7Wz9CpLEItfA7ndzgmDbuDnx7GfpodAb2QwjyIa56CONi+GyQYg19vfs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(6916009)(316002)(7696005)(82310400003)(16526019)(86362001)(36756003)(8936002)(2906002)(426003)(82740400003)(4326008)(36860700001)(5660300002)(81166007)(8676002)(336012)(186003)(6666004)(44832011)(70586007)(83380400001)(26005)(70206006)(478600001)(356005)(47076005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 04:03:45.1920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c617859-762d-44a8-e3ea-08d945b335bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
index 9316a726195c..37c9d7966022 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -709,14 +709,14 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -753,8 +753,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		 */
 		if (display_levels == clocks.num_levels) {
 			for (i = 0; i < clocks.num_levels; i++)
-				size += sprintf(
-					buf + size, "%d: %uMhz %s\n", i,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
 					freq_values[i],
 					(clocks.num_levels == 1) ?
 						"*" :
@@ -764,14 +763,14 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
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
@@ -788,7 +787,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -811,7 +810,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -834,7 +833,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -857,7 +856,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
@@ -880,7 +879,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, single_dpm_table->dpm_levels[i].value,
 					(clocks.num_levels == 1) ? "*" :
 					(aldebaran_freqs_in_same_level(
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 7664334d8144..f61976b08eb8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -559,7 +559,7 @@ static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
@@ -1034,15 +1034,15 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 
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
@@ -1063,7 +1063,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				goto print_clk_out;
 
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
 		}
 		break;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
