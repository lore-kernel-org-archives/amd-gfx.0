Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE64C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF92611C1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF92611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B6589C97;
	Tue, 13 Jul 2021 04:03:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F8489C89
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 04:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoywFdVcW0kK9pwMszGS5jdJaBlWLlw6FSRfFCk3qxSCPfhX2qLLLvhWpYVQaSVxY3UQ+7AryzV6pee9WL4canjolyVmLu6p99TvDgujdgE0WEmEJPgKAmvOYGqXUMI6A5k9NzE2V7B+h1QvBCSDwpp/gOEAGa1j9y+ClFa3EUqSkuIMM0cqKRDtB5e5HBhu5lORLaRK/Ct0DIeV9fyN+M85hujQPRc9ibRI3BAGLER0IC7hB2GJDDW6RudK8BVJEA3WDStJQ9Fu05qbuwd3vHxxZi3mWVIzOKv7OH+X7GS0ZjXjIntrodgHFvf6BflG3yAmN6MJRmoBfQDbzGr1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beR/Rx8xYE7c1Sbl6b6jxGUfhq0AvhLJsJIazAOIpg0=;
 b=DMj0c65/+VPEZr30eWRnPTgdl2iGwquXOrr3dkraFYoD0y+9w3ZZ+RHdWPOz/QaoPYm7yrTZhBzzDoFrSUgUmuPhEdl66YmfnfIMv355kNCWU35sRbZNnXh9daAvEiNHCRaBjROrrhcRKR/nR741x9zWB/xsjAt80jkpPx3sOIjtNKtPlQc8BFXEBlLms4NQKAIMrb/ZPlO3xnHtfb8NHJVV80Kgc5YaxYQEuZla6VXj990H10rBKJ1iO78QrQLMnD7PGv5pczjyfaGoBCh7LffPVAt6uwFp1uyW5A4pgUzNNWzcfDvhEa7A5uq4F9NH8U8etAq7HLCK7hV7IAni1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beR/Rx8xYE7c1Sbl6b6jxGUfhq0AvhLJsJIazAOIpg0=;
 b=uRkzwhtgW18Xk0FWzGIx8lPoDJRQkH0MhJwh8tOuL2XZdlp3fXz6SYemeIs0hYchW6cbSkWRKkHGQ2GVvyWHMc5T+tHgiYL9jxXp8ziZl4iTR63rZC+eTWIzPbTc0mXmZtHzTQJIC92+BAusiS4M/NCJX6chh/JMwFQa+9VpL9k=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 04:03:43 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::eb) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_2,
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
 15.1.2242.4; Mon, 12 Jul 2021 23:03:42 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
Date: Tue, 13 Jul 2021 00:03:19 -0400
Message-ID: <20210713040320.4657-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713040320.4657-1-darren.powell@amd.com>
References: <20210713040320.4657-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288d8ef9-931a-4b6d-dae9-08d945b334ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4013AE02DE83793C47D02A08F0149@MN2PR12MB4013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgoWT1Ispe7nZn4O1mE5hOZadct3z4Q/1kjHIL4V073HPdsjMcaS72S8lTEiAGtwF8wMZT7cXIJ2XczyLZmgkwusXWUXEwLFy465f2cbrPU7EAIUpAwbK9Nx4ARjEnmwFMY+lgAI5OWrLOLyo9wfiec+TlccB5velajvYDUeEfDhR1dzqQLVRnJsRPayzSyNrXJY+Rbq7QXTE0lD35KlpPRYFrI9JbSRnVQb/HpZzi/nFzHEdw5WEfDxgDrAlrYkh3RVrED7JUYq3keEBfgkLpjax0nK14hXu3eii0VVrE/0KVoU3TpDd/6mzZ5yYn7aJLasEcDpNt37yhc6QDv/Oj6aoqlhcSt0kOe7A2wr8DuF73zwJu2pasS+EtGxouIBjcc6dccDTgg/Vazb3Aeo6OJVCbCIG3TRB+VF9xVvoA/ETmu5Jko0F7g2Bk0bUruIfydE8n7Si3F8mYCUXYQbWh3ly5fj3ao6rVFpYk7DwetnCCKu05A6QBiOrF7KigpeWg9GO1+2UJsrih7PbFraqHkpW5hdoYl/va1HkKLn3k0j/IZ8DSV9FVdWpwSv8ZNSJFaPaFNpDvI64vu7PRuvKfFauI7+Awl/EAE7sPU1g/PLMBscEa7NL50L9dlpN1hazyXoflBPXdMBa11MCsx3oSAwXXmQWs6UK22+t01fhcbqe+fpkuQUJAeEpL8OvQmwdpFtB7vwey04qOVEla5wZHZHOhTpTDVL6yUxHd9TwdM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(36860700001)(5660300002)(2906002)(36756003)(478600001)(44832011)(356005)(2616005)(7696005)(8936002)(47076005)(8676002)(1076003)(82310400003)(81166007)(82740400003)(70206006)(6916009)(70586007)(16526019)(186003)(30864003)(6666004)(426003)(26005)(4326008)(316002)(336012)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 04:03:43.8627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d8ef9-931a-4b6d-dae9-08d945b334ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
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

 modification of smu11 files
  arcturus_ppt.c
  sienna_cichlid_ppt.c
  vangogh_ppt.c

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
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 +++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 46 +++++++++----------
 3 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 094df6f87cfc..2c8df8b2c325 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -756,7 +756,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	uint32_t gen_speed, lane_width;
 
 	if (amdgpu_ras_intr_triggered())
-		return snprintf(buf, PAGE_SIZE, "unavailable\n");
+		return sysfs_emit(buf, "unavailable\n");
 
 	dpm_context = smu_dpm->dpm_context;
 
@@ -780,7 +780,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		 * And it's safe to assume that is always the current clock.
 		 */
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
 					clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(arcturus_freqs_in_same_level(
@@ -803,7 +803,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -826,7 +826,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -849,7 +849,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -872,7 +872,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -895,7 +895,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -906,7 +906,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		size += sprintf(buf + size, "0: %s %s %dMhz *\n",
+		size += sysfs_emit_at(buf, size, "0: %s %s %dMhz *\n",
 				(gen_speed == 0) ? "2.5GT/s," :
 				(gen_speed == 1) ? "5.0GT/s," :
 				(gen_speed == 2) ? "8.0GT/s," :
@@ -1272,11 +1272,11 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		return result;
 
 	if (smu_version >= 0x360d00)
-		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+		size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 	else
-		size += sprintf(buf + size, "%16s\n",
+		size += sysfs_emit_at(buf, size, "%16s\n",
 			title[0]);
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
@@ -1302,11 +1302,11 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 			}
 		}
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
 		if (smu_version >= 0x360d00) {
-			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
 				"GFXCLK",
@@ -1320,7 +1320,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 				activity_monitor.Gfx_PD_Data_error_coeff,
 				activity_monitor.Gfx_PD_Data_error_rate_coeff);
 
-			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				1,
 				"UCLK",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c751f717a0da..2ee66afe0854 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1046,7 +1046,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 				if (ret)
 					goto print_clk_out;
 
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
 			}
 		} else {
@@ -1068,7 +1068,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			}
 
 			for (i = 0; i < count; i++) {
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, freq_values[i],
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
 						cur_value  == freq_values[i] ? "*" : "");
 			}
 
@@ -1079,7 +1079,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		GET_PPTABLE_MEMBER(LclkFreq, &table_member);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
-			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
@@ -1102,8 +1102,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS))
 			break;
 
-		size += sprintf(buf + size, "OD_SCLK:\n");
-		size += sprintf(buf + size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
 		break;
 
 	case SMU_OD_MCLK:
@@ -1113,8 +1113,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS))
 			break;
 
-		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
 		break;
 
 	case SMU_OD_VDDGFX_OFFSET:
@@ -1130,22 +1130,22 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		     (smu_version < 0x003a2900))
 			break;
 
-		size += sprintf(buf + size, "OD_VDDGFX_OFFSET:\n");
-		size += sprintf(buf + size, "%dmV\n", od_table->VddGfxOffset);
+		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "%dmV\n", od_table->VddGfxOffset);
 		break;
 
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 
-		size = sprintf(buf, "%s:\n", "OD_RANGE");
+		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
 
 		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
 							    &min_value, NULL);
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMAX,
 							    NULL, &max_value);
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 
@@ -1154,7 +1154,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 							    &min_value, NULL);
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_UCLKFMAX,
 							    NULL, &max_value);
-			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 		break;
@@ -1377,7 +1377,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 
@@ -1397,10 +1397,10 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
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
@@ -1414,7 +1414,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			activity_monitor->Gfx_PD_Data_error_coeff,
 			activity_monitor->Gfx_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			1,
 			"SOCCLK",
@@ -1428,7 +1428,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			activity_monitor->Fclk_PD_Data_error_coeff,
 			activity_monitor->Fclk_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
 			"MEMLK",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 18681dc458da..b3f2390696cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -592,28 +592,28 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
-			size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
 				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		}
 		break;
@@ -656,14 +656,14 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
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
 		break;
@@ -691,28 +691,28 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
-			size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
 				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		}
 		break;
@@ -755,14 +755,14 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
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
 		break;
@@ -1035,7 +1035,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
