Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362E2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 03:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74F310ED77;
	Fri, 13 May 2022 03:16:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264DD10E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 03:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P35T0Kvm05y3EKXSj34yYAXj/EnSKlQPXTFLklMdz5l+e5Xiwx2gj3dFxeiBDhzKjzvbT4XNhNqQ3Rj9k5Pl6VjvYhnTOxOyo6e3EYUnBzrypgYUOizmm/Ti7Q964xEKhutRqKXsHdQtsgSr5okRxaHPf+LoM3I1edRiUrZDpozWUq2IQjlEv7uLmh5/B92Ur1pqS0lMBUYNVaWjeR5JFGBf4n+Jlfgd9r6P+1VtC+HCv+qy2jsgeropJC7K9F+fYAMW3yYmp6oTh3c17eqtEpVeS5EUijkxaYYfGE9sEZRyYHSpZXrd511mXjLyyiV0HmBrbg5qCpe5rSUTMvbC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHA5ZyF7+ejQpMR6Gf8ls0QJ5aW2jvPfUI20U88LKpI=;
 b=HtVoO3qMF2SXGjnyC/nB4fYgvXWAKQJg+7eZsbj354j+RxA1lJ17oRxILUGinc9fh/IQID8c5qo8ExF7TD6OCxVxVyDMNKBrgpzcLReIUD60YRNSpd9nE6EJ1E4lLgr5dvvQtElSOmsxq6nsSIltt2h5cpKJ7/kmtKG5pnEGjWh48yNTgQumdf+R66JfJfJTbWnn/63nlHbsGJq1tjs3zwAquk347EU4IK0LzVAbZ7ejZJPJPKmdewPYAMxSLd68EW1IgapsVq3n4/mm3etXqYCqkEhu/Lfpzz+5Bm1VkzZaHv13XPrWJfSnjDRMcn4HTTHYURBmzCrHHsgibC4uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHA5ZyF7+ejQpMR6Gf8ls0QJ5aW2jvPfUI20U88LKpI=;
 b=bFmKzUGuXd++UaaKQxAytki4jzysqUqrbi5yjM0WIA34OC4aIVrqJ60QkGRD5iPCfQqzBmKADqW1txWWxaG0AO6MyHI4Hk/7L7OtvkoQLmuK8nBNg1GDsEhbidzBLSpJYtennqhsXyI1Zs+2Et4YNVRVdI2MttGrOnQKChkyrV4=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 03:15:52 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 03:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 03:15:51 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 22:15:29 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 2/4] amdgpu/pm: Optimize arcturus_emit_clk_levels
Date: Thu, 12 May 2022 23:15:04 -0400
Message-ID: <20220513031506.52099-2-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 953b9429-53f8-456b-ad88-08da348ee263
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5064B0A1BD82D0149166DD9DF0CA9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EVDN/Tug5sowkynTaPP6vd2tEyuKFkIZzrYVdBVwF30srT9hrhQ+ldxRgfJ0/AatnrHcQvhQc7wRdOqgrYB28FeKLPxy87/1TK/qjrPj9TUwKbhcwwt9/6a9bytVnH6bZeZwvVH6vV932K3SgSZArp/fZmH+cUEqUAApe74xcq6gMa6nsv3FQDX3VkeHb+TLrDmmVjBQe6d+iL+duYBp9h+/3/Palafdsf9levYMmCP89M9nb0axXbSzycW1FRgGHGA5MEFES5jyEoR6NhQtKUHNKJ5QqZjgZEPc8g4H6l68jitvPGLXV5J1g8RrEktvOe6dkvb/RepPn0WlDNmICd4/Lry0oYvlZCh+fbcY3MpVjfN8/K7qN03YPVckVjy4w9ZjYIMFyztfGl19IYhv7G1o7MoVsmTz8B4yaxSzOtXbm4VTdDHKBHaLCiCG0iPg+rP7rdSby7MYGcWcMzxsbrawzSUin/HqQCUrgvFjfx5LSpIvKYSA8Yg0e5AwlgAVWunO2tZtg47epo3O3lOttSkib3RQYGUtpV3yk9BVM++GjfwE8borR9rt19LAAlrXSU8HP7pPYihxJ2hXakecSp+GT6oqR5dbYy0fS8+jlwebwSyRoSHcFBsbRTu/OUA4OqtP5CI7uaxBb8EAo1TzJOcOld6ZpB3pAJUfew/R9xTTeUuHut0afVGYlcfXMbjVdOw5E1M15lpaZNRoltzMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(47076005)(2906002)(6666004)(7696005)(86362001)(8676002)(83380400001)(4326008)(5660300002)(70206006)(70586007)(40460700003)(336012)(426003)(186003)(81166007)(316002)(54906003)(16526019)(44832011)(36860700001)(8936002)(6916009)(26005)(2616005)(508600001)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 03:15:51.2811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953b9429-53f8-456b-ad88-08da348ee263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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

Optimized arcturus_emit_clk_levels
   split into two switch statements to gather vars, then use common output
   reduce size of string literals by creating static string var
   removed impossible error messages for failure of get_clk_table
   added clock_mhz to remove double divide by 1000
   changed unsafe loop iterator from single_dpm_table->count to clocks.num_levels
       in case MAX_DPM_LEVELS > PP_MAX_CLOCK_LEVELS in future code
   simplified code to output detect frequency level match to current level
   combined common output code into single switch case
arcturus_get_clk_table cannot fail so convert to void function
arcturus_freqs_in_same_level now returns bool

== Test ==
LOGFILE=arcturus.test.log
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
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 144 ++++++------------
 1 file changed, 49 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 163adab2843d..df8d870125da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -569,9 +569,9 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int arcturus_get_clk_table(struct smu_context *smu,
-			struct pp_clock_levels_with_latency *clocks,
-			struct smu_11_0_dpm_table *dpm_table)
+static void arcturus_get_clk_table(struct smu_context *smu,
+				   struct pp_clock_levels_with_latency *clocks,
+				   struct smu_11_0_dpm_table *dpm_table)
 {
 	int i, count;
 
@@ -584,11 +584,11 @@ static int arcturus_get_clk_table(struct smu_context *smu,
 		clocks->data[i].latency_in_us = 0;
 	}
 
-	return 0;
+	return;
 }
 
-static int arcturus_freqs_in_same_level(int32_t frequency1,
-					int32_t frequency2)
+static bool arcturus_freqs_in_same_level(int32_t frequency1,
+					 int32_t frequency2)
 {
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
@@ -766,6 +766,9 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
 	uint32_t i, cur_value = 0;
+	bool freq_match;
+	unsigned int clock_mhz;
+	static const char attempt_string[] = "Attempt to get current";
 
 
 	if (amdgpu_ras_intr_triggered()) {
@@ -779,148 +782,100 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
+			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
-
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		for (i = 0; i < clocks.num_levels; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-					clocks.data[i].clocks_in_khz / 1000,
-					(clocks.num_levels == 1) ? "*" :
-					(arcturus_freqs_in_same_level(
-					clocks.data[i].clocks_in_khz / 1000,
-					cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_MCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
+			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < clocks.num_levels; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_SOCCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
+			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < clocks.num_levels; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_FCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
+			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < single_dpm_table->count; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_VCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < single_dpm_table->count; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_DCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
 		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
 			return ret;
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
-			return ret;
-		}
-
-		for (i = 0; i < single_dpm_table->count; i++)
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-				(arcturus_freqs_in_same_level(
-				clocks.data[i].clocks_in_khz / 1000,
-				cur_value) ? "*" : ""));
+		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
 
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case SMU_SCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		/*
+		 * For DPM disabled case, there will be only one clock level.
+		 * And it's safe to assume that is always the current clock.
+		 */
+		for (i = 0; i < clocks.num_levels; i++) {
+			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
+			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
+
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
+						 clock_mhz,
+						 freq_match ? "*" : "");
+		}
+		break;
+	case SMU_PCIE:
 		*offset += sysfs_emit_at(buf, *offset, "0: %s %s %dMhz *\n",
 				(gen_speed == 0) ? "2.5GT/s," :
 				(gen_speed == 1) ? "5.0GT/s," :
@@ -937,7 +892,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	return 0;
-- 
2.35.1

