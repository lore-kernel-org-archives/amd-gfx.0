Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF85C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 03:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DBF10E3B7;
	Mon,  9 May 2022 03:58:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5E010E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 03:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwxuWjReto11j3IprLL42ttwryptvGD0DIxXq62ygORLumxQWj5u1cK7ITGZfXMuPpCXmaF3WFKa7FbdUVBZsKMup2L3dPdiisFaq1f+zR5M5DK9v1hdu3JFGOr1OPiUzzVXGLhN80CCijQKVKrGn1/VpXAbTQ0jOgX3NnLMVOkopXV15rHukuVTPr6A455YTz4o+IJM//HLM8GROS/dBhd4kNspa6dOjvXHWaI45MRngxXrN0zNXb9JEM/VTrUzRjG9yn8TJM5lcXXURy0RoEBId3hGkHC/fYbbkzKPV9R42ET0KpSNaTZ+iSxoRjz6o8b5W62FNIbfiGibmY//zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVLQaHbeSNb5bkqs/VARKIdq148EdNrI/UMm5f0AoZE=;
 b=VJsXUp2VTNG/w6s/fQ0jYsF1+LfAFsx+LpNAATEK6v5WubZ+m40lDI2avoNFak3KAhX4deF6JRNcM2cE14ckY4W+P5o9U2Mhp4hSQnRbN7dPuTKJy7HX/XsCLLwQLvaOFq5pkQcekN7fvmPbsF7D9C0ta0MotEmU108X/d8r47r9JzBoaC42Irww9P2SdYMA4rxY/1G+5o8GxuWWMYHGUz4gVyh88+W+jJhCvQEyMCU7BVS1mONbE579LCBqfzUbopMbATXWB/PJlosqb4jatUGwaaVLje2KdwRFPgsOAb7eTITW6iMrCji7VCFJAxX1+Wj+KPHyUo8NtHEq8BN8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVLQaHbeSNb5bkqs/VARKIdq148EdNrI/UMm5f0AoZE=;
 b=S4Ad9KrZjhI/pMvjCp0qO9GiivHu7lO7vxDnL6cHbpA1X1esIB1bu3vktMRnUi1bAFvG3vf+2zU6pon49ziqz0m2ny4Bggnje2HHJTm6eQsUeJ3+L16nMPP9WyKWuskdgmmpq93oM2jLbw+hJMXD3/Q4evKTtZNetfXjr6zTb1A=
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 03:58:55 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::43) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 03:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 03:58:54 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 22:58:53 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bounds if SCLK
 levels != 2
Date: Sun, 8 May 2022 23:58:38 -0400
Message-ID: <20220509035838.17410-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509035838.17410-1-darren.powell@amd.com>
References: <20220509035838.17410-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3d3aae-57aa-48fa-3f0e-08da31703c63
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4307FECFA388BFC2474D2B58F0C69@BY5PR12MB4307.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJlDUVqAJYk7wJONkz08drQx4WuS03Jn78TP0VOhLKSfYHIVNVBX7ZYy6aWwZAR/1/lVrJGgEC5j1/MW0t+STM3moagEM4NDUTWPUSY6rGSj5jua/WXhm8ok2E3fuRcIoMZ86248z9fXYvt6I/JY86HWE1p4j15FFTyMDpvzYYFEVNIhDoBOuas69VsKNOyfcDIISnBMA2JV5tw9KZ3fkAAenfUiGTMSxmBuXcQKMpUjE+mZBDR1Gug4WKH4lbN+AVapPR0pzP/v5VNEbOVe2AowMauPi93ykkmz38unnxUuI/XEFZXKMlMKAv9FL5qDvPXTf2FEPFRB2mkVcK7fyAcRSZC+N1wClCqkGDSRlKFW6KEN3ZQ6MHL0R4qleDqsMsOxcV0exfpMLxizeKGh/11ejnrzo62qNbyDf1NsELftPq6wnEXekSWHaBeLn7Eme05ClaAzIi6HY4gGZnMpqWxJMNi7Q4nPdA0E8CvMxngFiso6BZw/194nuX6kSvEt+YbEDgkZPpPGr/wtOuRH9X8nm3G5IvH9621BrxhttnGFCrO49bG77JXUCew86mF2KrWAWf08S65hLnS+oIjE95l15tQA+DfttsgZTraXO+f+JLO4560TpmLK3v43zZQ+VTBoSzQSQUn2jWucAef5iCYgx0gzrwVUw41NkBii9grNMracZoYXOocFc5u1RE+n1wWwKUEcVRwCiwVEBjEeQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(356005)(26005)(86362001)(82310400005)(36756003)(5660300002)(8936002)(83380400001)(1076003)(47076005)(508600001)(44832011)(6666004)(70586007)(316002)(70206006)(426003)(8676002)(4326008)(54906003)(6916009)(336012)(81166007)(7696005)(186003)(16526019)(2906002)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 03:58:54.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d3aae-57aa-48fa-3f0e-08da31703c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: kevin1.wang@amd.com, lijo.lazar@amd.com, Le.Ma@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, kenneth.feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 added a check to populate and use SCLK shim table freq_values only
   if using dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL or
                         AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM
 removed clocks.num_levels from calculation of shim table size
 removed unsafe accesses to shim table freq_values
   output gfx_table values if using other dpm levels
 added check for freq_match when using freq_values for when now == min_clk

== Test ==
LOGFILE=aldebaran-sclk.test.log
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_od_clk_voltage
pp_dpm_sclk"

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6a4fca47ae53..a653668e8402 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -740,9 +740,8 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t display_levels;
 	uint32_t freq_values[3] = {0};
-	uint32_t min_clk, max_clk;
+	uint32_t min_clk, max_clk, display_levels = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -765,46 +764,45 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
-
-		display_levels = clocks.num_levels;
-
-		min_clk = pstate_table->gfxclk_pstate.curr.min;
-		max_clk = pstate_table->gfxclk_pstate.curr.max;
-
-		freq_values[0] = min_clk;
-		freq_values[1] = max_clk;
-
-		/* fine-grained dpm has only 2 levels */
-		if (now > min_clk && now < max_clk) {
-			display_levels = clocks.num_levels + 1;
-			freq_values[2] = max_clk;
-			freq_values[1] = now;
-		}
+		if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+		     smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
+			single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+			ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+			if (ret) {
+				dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
+				return ret;
+			}
 
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		if (display_levels == clocks.num_levels) {
 			for (i = 0; i < clocks.num_levels; i++)
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-					freq_values[i],
+					clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ?
 						"*" :
 						(aldebaran_freqs_in_same_level(
-							 freq_values[i], now) ?
+							 clocks.data[i].clocks_in_khz / 1000, now) ?
 							 "*" :
 							 ""));
 		} else {
+			/* fine-grained dpm has only 2 levels */
+			display_levels = 2;
+
+			min_clk = pstate_table->gfxclk_pstate.curr.min;
+			max_clk = pstate_table->gfxclk_pstate.curr.max;
+
+			freq_values[0] = min_clk;
+			freq_values[1] = max_clk;
+
+			if (now > min_clk && now < max_clk) {
+				display_levels++;
+				freq_values[2] = max_clk;
+				freq_values[1] = now;
+			}
+
 			for (i = 0; i < display_levels; i++)
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-						freq_values[i], i == 1 ? "*" : "");
+						freq_values[i],
+						aldebaran_freqs_in_same_level(freq_values[i], now) ?
+							"*" : "");
 		}
 
 		break;
-- 
2.35.1

