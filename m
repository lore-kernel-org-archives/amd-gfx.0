Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FB0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 03:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF2B10ED53;
	Fri, 13 May 2022 03:15:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70F110E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 03:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6jLX9brfvHARylpHLyprZvyZiM9Y3HELHOpui9yU6H9oyq0OAYrRvwxYLu4M5obn2qLG9uXDqZvz0HZvdkXifvS7QchiPyxC1E1TQq3l6Jv66oJklRI0rRVQuUZgRB6GF/+/rjkLmRm1K7m5T9x1PJ3b23xAZExqinB5qG7qACt6XvI7cg/6Jv7R2ucHU/gK6CZpuNQmLlympbSSgoSmmTQfzb7YJOtkqSCKpHi4ptU7dCLRe8oTXQ25YjVan7Hnz8cgdGsOoCqF7xujvnP/b8mkqATwm7RDAsIEh4cvPsjxRKsIs/G1NQ3Yo6VkTVW1wtP0MswJAyFVE7qVyVKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4K7Y9girsdrowe0n4dR42ju7/93UwtbYjDqZdogTv8=;
 b=QLLWU2bX8oozMJwuoMtu8cnwkeUZkbNBVzhB1UxCvOqgbzda0OTofj1EyRXHNYg7PPMhQBqG/a258uJEyOal5qy+dhXd2nuuTwSxs2ViwZyv7p4uS97+sndWhVfEJoX8lbBsRxx7P4IPOEXO+b5UmxfNNxqxcJpeb1BxETRowDxnUdhRtL1UgKpfzKdHAAXg8Akn86kjcgo6o1ftC0XBn1c1cvHwkJ2YMfqSoAG7mG41VfzYd12vUhuN0CZpMIq4NzeyT4QD+O/0YBCN3Ro5d9zkB8CXshqC7x3+E+PDp0zU0mujlrT7e8B0QRquQxQt3nzVTjwSSnlKBzaec5Ud9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4K7Y9girsdrowe0n4dR42ju7/93UwtbYjDqZdogTv8=;
 b=bs3ROM/0k55U3ljTyUQJtAsdHVBZgJPeZ6AoWpmpHUw3XqSGCnY67dKtrQ73jzwyIp9Jo+B9yoqlFhRW/B8NrnJmlpG+NbRlMS5xQgRlUIzDzT/+LT35HCj/KfIPhvCvDfqBUfHuzScjmBXBsNfPuoHONzUQnbNMqKFmInYy4qA=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 03:15:52 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::d5) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5 via Frontend
 Transport; Fri, 13 May 2022 03:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 03:15:52 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 22:15:31 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 4/4] amdgpu/pm: Optimize aldebaran_emit_clk_levels
Date: Thu, 12 May 2022 23:15:06 -0400
Message-ID: <20220513031506.52099-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513031506.52099-1-darren.powell@amd.com>
References: <20220513031506.52099-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1e776a-f4b9-4440-2ad8-08da348ee2f6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB549476FF015ED9059C325F9CF0CA9@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyL7gqWDi65BQVDBA2H+ldKjix3bLdJ29wq1juVvIhVejEjqfN05zQ/2pV9f6u1BjMa6MUKkxpMta9nWJ5fFnYITI013RvB43jSNnGDwsCbxpLHf8vSJHbokpupGmvH739wb/P4kfTDB5XxAJE7+QdgUqFQq1S2saMf7YmDtVZclLgDpKOvKGf5DM6DA/APk/83KBlDMVgSg66g+lpGKxQKX1Gv8UaNHgP/bab3sHBANsvM44WWNxUNSdk2ZEiDN7xf1QxgGXV+dh5CAByGarzK6OHriws/qSOwA4+EiIjS2QY/6UFfNPTjWBHUD+VnyWj7kCZ1bsmFZy+xKH2o20GrFbiTgysku3PA6AtULQA2BRJgRkoS+ASwHSJ4E79jK9aMfQmpkJ7jjqll8zEIOn39e8oQtMFTjBaVFPkXwZ3ILpqF2wRVn4BOkt2XYzs8KGTrvzkWlxeXoamHPl7k+OrNXHKg78NPwzi6vkYP1arftx4F4kRP5SzBOgBW6Zcz1TFyycxi9uycs91Hm2nPR0m9Anah/UFEnVU5kc+IVLS2BfFn28wg3kJUccIynQq+jp3al+IoyJBoIm2WCbjChDf5DzsfQSSdJZHrHfW/hWKwhUFQcKPiN2N/bkv1g121yvchZGeogt2RUbWnNARjq//rpC6K+e/ir97dZQjGPYJso3V5JNIc65Q3N72u9GhSLBfsDk8UTAWOSuKCWCu9FlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(508600001)(47076005)(186003)(44832011)(7696005)(40460700003)(356005)(16526019)(6666004)(336012)(426003)(2906002)(8936002)(2616005)(316002)(82310400005)(36860700001)(6916009)(54906003)(70586007)(70206006)(4326008)(86362001)(1076003)(8676002)(36756003)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 03:15:52.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1e776a-f4b9-4440-2ad8-08da348ee2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
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
Cc: kevin1.wang@amd.com, kenneth.feng@amd.com, lijo.lazar@amd.com, Darren
 Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
 david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aldebaran_get_clk_table cannot fail so convert to void function
aldebaran_freqs_in_same_level now returns bool
aldebaran_emit_clk_levels optimized:
   split into two switch statements to gather vars, then use common output
   removed impossible error messages for failure of get_clk_table
   reduce size of string literals by creating static string var
   changed unsafe loop iterator from single_dpm_table->count to clocks.num_levels
       in case MAX_DPM_LEVELS > PP_MAX_CLOCK_LEVELS in future code
   added clock_mhz to remove double divide by 1000
   collapse duplicate case statements in second switch statement
   simplified code to output detect frequency level match to current level

== Test ==
LOGFILE=aldebaran.test.log
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_dpm_mclk
pp_dpm_pcie
pp_dpm_socclk
pp_dpm_fclk
pp_dpm_vclk
pp_dpm_dclk "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 173 +++++++-----------
 1 file changed, 62 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index e593878bc173..23a87bfb4429 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -545,9 +545,9 @@ static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int aldebaran_get_clk_table(struct smu_context *smu,
-				   struct pp_clock_levels_with_latency *clocks,
-				   struct smu_13_0_dpm_table *dpm_table)
+static void aldebaran_get_clk_table(struct smu_context *smu,
+				    struct pp_clock_levels_with_latency *clocks,
+				    struct smu_13_0_dpm_table *dpm_table)
 {
 	int i, count;
 
@@ -560,11 +560,11 @@ static int aldebaran_get_clk_table(struct smu_context *smu,
 		clocks->data[i].latency_in_us = 0;
 	}
 
-	return 0;
+	return;
 }
 
-static int aldebaran_freqs_in_same_level(int32_t frequency1,
-					 int32_t frequency2)
+static bool aldebaran_freqs_in_same_level(int32_t frequency1,
+					  int32_t frequency2)
 {
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
@@ -738,9 +738,12 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t i, display_levels;
+	uint32_t i, cur_value = 0;
 	uint32_t freq_values[3] = {0};
-	uint32_t min_clk, max_clk, cur_value = 0;
+	uint32_t min_clk, max_clk, display_levels;
+	bool freq_match;
+	unsigned int clock_mhz;
+	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
 		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
@@ -750,23 +753,18 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
-
 	case SMU_OD_SCLK:
 		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
 		fallthrough;
 	case SMU_SCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
+			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 
 		display_levels = clocks.num_levels;
 
@@ -782,152 +780,105 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 			freq_values[2] = max_clk;
 			freq_values[1] = cur_value;
 		}
-
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		if (display_levels == clocks.num_levels) {
-			for (i = 0; i < clocks.num_levels; i++)
-				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-					freq_values[i],
-					(clocks.num_levels == 1) ?
-						"*" :
-						(aldebaran_freqs_in_same_level(
-							 freq_values[i], cur_value) ?
-							 "*" :
-							 ""));
-		} else {
-			for (i = 0; i < display_levels; i++)
-				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-						freq_values[i], i == 1 ? "*" : "");
-		}
-
 		break;
-
 	case SMU_OD_MCLK:
 		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
 		fallthrough;
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
+			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < clocks.num_levels; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clocks.data[i].clocks_in_khz / 1000,
-					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_SOCCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
+			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < clocks.num_levels; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, clocks.data[i].clocks_in_khz / 1000,
-					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_FCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
+			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < single_dpm_table->count; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_VCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < single_dpm_table->count; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_DCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
-			return ret;
+		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case SMU_OD_SCLK:
+	case SMU_SCLK:
+		/*
+		 * For DPM disabled case, there will be only one clock level.
+		 * And it's safe to assume that is always the current clock.
+		 */
+		if (display_levels == clocks.num_levels) {
+			for (i = 0; i < clocks.num_levels; i++) {
+				clock_mhz = freq_values[i];
+				freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+				freq_match |= (clocks.num_levels == 1);
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
+							 clock_mhz,
+							 freq_match ? "*" : "");
+			}
+		} else {
+			for (i = 0; i < display_levels; i++)
+				*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
+							 freq_values[i], i == 1 ? "*" : "");
 		}
 
-		for (i = 0; i < single_dpm_table->count; i++)
+		break;
+	case SMU_OD_MCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
-					(aldebaran_freqs_in_same_level(
-								       clocks.data[i].clocks_in_khz / 1000,
-								       cur_value) ? "*" : ""));
+					i, clock_mhz,
+					freq_match ? "*" : "");
+		}
 		break;
-
 	default:
 		return -EINVAL;
-		break;
 	}
-
 	return 0;
 }
 
-- 
2.35.1

