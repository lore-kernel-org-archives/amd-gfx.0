Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D6C432BE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E1960FD8
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6E1960FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5613A89D46;
	Sun,  8 Aug 2021 05:33:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6954B89D3E
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm8gcz1HoqgYr2Qmufc5wKlJuDIICgXFTi1/GE/l/jvRXrdlYlkZSuFXZwrOaO2s5LlNKk4FVVAfBjcJa9H7XUPpFoDN5ihVwOaITkr9fgg6Ypmv1EerHR1KewbdXNUhYxRqLrXhGOWxlS3dXVps+uyvP9Uybz9ZM232JNFyt+7yLlwHBd2TvA45BwBkuLLF+nquda+p9dhnb4L+1a9Cm5PuiKM9UKmW8yAE+JS5CjgXXjA/sTFBibVQqC/MphfSdq+/IQGkn5Thq8ETnk/QLu621Jly4sm8hCCH2fXcZey2EHmOauLChw1EzhtuirK9etLIPkjHJ2rUt/fqM9er+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RFHzFKwjubIOZuv4/jivABg+fzCCyf7InNzotijBCg=;
 b=XFHcTaQHJgbWNGMX5yPBD4brkzEZkk0P850oofbAFlyKkr0YocPafo65U8xBcuX2c166U/042cKIqFFj4ClzqMdNcEejwaUCx9Ks4h5sBZeVLMaHQQM0XkwW7m/8IWV7SUGBcPoFZrwq8pR4nrZuUEvK7tAfArU24WkGjSL7NocBkSnImAYrEO+ifrEz6oph9tGMui7BOWaTvaKfL0u6AMTURQmGDpC1x2OSvAi6KRJ7ARD3eYaE1P3w/QHaJ0r77Z/IR8cSPK0m0pXXWYKdxYJHq9u7bWCopyxd1CsVKkmhkDVcwyqSKv4MjNpCSAOwfZ4X1kJDSubJLqDpbFiqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RFHzFKwjubIOZuv4/jivABg+fzCCyf7InNzotijBCg=;
 b=kDlurXNz5pMNqIbHYwr85yi2ShES/tHnadVWSF7IdEQRS/wmjUzrSr4bDKXO3TTB2b8io+QbInd5XyAJd+KgpMicxHFllqqcuYdPoUP5JBq99UM9jUvqbs6JRUO+Ix1No1DF30htE3Wk3AxSkPcCIjnCfRzhC6+kVbY1qVb2EU8=
Received: from BN6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:404:121::28)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Sun, 8 Aug
 2021 05:33:26 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::23) by BN6PR18CA0018.outlook.office365.com
 (2603:10b6:404:121::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:33:26 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:33:25 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 2/4] amdgpu/pm: Replace vega12,
 20 usage of sprintf with sysfs_emit
Date: Sun, 8 Aug 2021 01:33:10 -0400
Message-ID: <20210808053312.3423-3-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e22c7fd6-a4d0-4a9f-f098-08d95a2e0bcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138F687D0EEA439DDC56E10F0F59@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZDf7Bh7CCGazVHmBkq9tYcqBq8v2r3QkW0tUo29AQM6feoOF8iRdBCjR1phlUywLK1QdKPMHl37+qSfm/GRV2uJSmVso0JDfi8/iGDy8fj8UAf8rC6XPyGlqUlX3+2iWbIXWD+7N0uz9ZcthGOXJZmC+vkP3m8NFlNmo0e3HfbqH1urRpHAJP0+hpbjEVS6/jNeLyK5dwejBy4fxvGZfvDB7pS8C2XmBU13+JZProZbrXJ2RcwRtrJkpUc0k14pYBC7buQiLyIqZef7kZDYbS9aShlX344Cf2To2FEIAe8O8zrk/YjJp6evL+T4XeURT5HjU4Ed+7dq8YGcv1Y7Lh5VxCTxW7LKY3bfW2PBlFlFIcNUVVWoPMrRDF2EV2Hlj6JClaFgZzWrIEO6xLa0hVIBnePNbagQSTpwZbFmAg/3Zk3+hFqxUjFZU/SUk2qW8bc/xiv7T0zXD3pjFH2zRFGCo1rg/2B9taQ/D5gieEt2L5R5O+/wRfzs211N3tAfTLSQ/Vgl2kDEk7NH3WL3ttgrALiYnbh097s/U56S4uiM47Hxngu2PPtLKLEchk2dRjldX9Dfbpxsxi6oBD7z/YJrYls4D1hFWaVPkEf6MEXSspUnHzV8uhSkTlRnnsPjT5G4mlIDfwFwq6/NKWsdJ2N6nUMc7p8e1MzgwuKiqE2xsJDmzz14u0HHQpU0/YP2vFt3lHhK9S+NJuC8a9nNSUFhZBWgT9nid6aRnzys11MCO3Fm/RwitxFstF8WBunP9hF/j848jJOGwe2+0No2cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(36756003)(478600001)(34070700002)(356005)(186003)(16526019)(82310400003)(26005)(8676002)(81166007)(70586007)(316002)(70206006)(36860700001)(426003)(30864003)(86362001)(2906002)(44832011)(4326008)(1076003)(82740400003)(8936002)(7696005)(6916009)(47076005)(2616005)(336012)(6666004)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:33:26.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22c7fd6-a4d0-4a9f-f098-08d95a2e0bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 14 ++--
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 74 +++++++++----------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 29e0d1d4035a..8558718e15a8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2146,13 +2146,13 @@ static int vega12_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
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
@@ -2256,7 +2256,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get gfx clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
 		break;
@@ -2272,7 +2272,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get memory clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
 		break;
@@ -2290,7 +2290,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get soc clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
 		break;
@@ -2308,7 +2308,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get dcef clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
 		break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0791309586c5..0f07d17e9641 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3243,13 +3243,13 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
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
@@ -3372,13 +3372,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_sclks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
+			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3390,13 +3390,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_memclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
+			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3408,13 +3408,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_socclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
+			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3426,7 +3426,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		for (i = 0; i < fclk_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, fclk_dpm_table->dpm_levels[i].value,
 				fclk_dpm_table->dpm_levels[i].value == (now / 100) ? "*" : "");
 		break;
@@ -3438,13 +3438,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_dcefclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
+			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3458,7 +3458,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 			gen_speed = pptable->PcieGenSpeed[i];
 			lane_width = pptable->PcieLaneCount[i];
 
-			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
 					(gen_speed == 2) ? "8.0GT/s," :
@@ -3479,18 +3479,18 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	case OD_SCLK:
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 				od_table->GfxclkFmin);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 				od_table->GfxclkFmax);
 		}
 		break;
 
 	case OD_MCLK:
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size = sprintf(buf, "%s:\n", "OD_MCLK");
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 				od_table->UclkFmax);
 		}
 
@@ -3503,14 +3503,14 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size = sprintf(buf, "%s:\n", "OD_VDDC_CURVE");
-			size += sprintf(buf + size, "0: %10uMhz %10dmV\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_VDDC_CURVE");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq1,
 				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
-			size += sprintf(buf + size, "1: %10uMhz %10dmV\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq2,
 				od_table->GfxclkVolt2 / VOLTAGE_SCALE);
-			size += sprintf(buf + size, "2: %10uMhz %10dmV\n",
+			size += sysfs_emit_at(buf, size, "2: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq3,
 				od_table->GfxclkVolt3 / VOLTAGE_SCALE);
 		}
@@ -3518,17 +3518,17 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 
 	case OD_RANGE:
-		size = sprintf(buf, "%s:\n", "OD_RANGE");
+		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
 
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FMIN].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FMAX].max_value);
 		}
 
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_UCLK_FMAX].min_value,
 				od8_settings[OD8_SETTING_UCLK_FMAX].max_value);
 		}
@@ -3539,22 +3539,22 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ1].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ1].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ2].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ2].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ3].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ3].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value);
 		}
@@ -4003,7 +4003,7 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 
@@ -4016,10 +4016,10 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 				"[GetPowerProfile] Failed to get activity monitor!",
 				return result);
 
-		size += sprintf(buf + size, "%2d %14s%s:\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
 			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ");
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			0,
 			"GFXCLK",
@@ -4033,7 +4033,7 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 			activity_monitor.Gfx_PD_Data_error_coeff,
 			activity_monitor.Gfx_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			1,
 			"SOCCLK",
@@ -4047,7 +4047,7 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 			activity_monitor.Soc_PD_Data_error_coeff,
 			activity_monitor.Soc_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
 			"UCLK",
@@ -4061,7 +4061,7 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 			activity_monitor.Mem_PD_Data_error_coeff,
 			activity_monitor.Mem_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			3,
 			"FCLK",
-- 
2.32.0

