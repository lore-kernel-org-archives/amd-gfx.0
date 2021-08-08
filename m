Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E9C4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9472360F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9472360F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA8089D3E;
	Sun,  8 Aug 2021 05:33:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FDE89CE0
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbUydFrJdQzVZkqT2yAFCMJo4TRvuAE5/t3pjeaFCfMRW5+cXwAbqtsktjsv1QpPD9pfA2a4HXf3GunXplXIsov9chU1vknL6YhVU0yXwsfOSj+TSqrASnDG50ryLH2yft92cMxZjmoX0HEvR+EAQOBpbDeyfCtiHaY7he+w/oL9gYN8Wog779z1gxhjWouVxXRGAIxliqwHeOyRdIqNueQGpjoAg8kQwKhrTMPanS6KY9+zTGerxxfXLyId8YuMLtHtLsJTQTGSHww05QxW3B+SF2gJgIzzB8KeCK3vabD5cMDTAOFWMQ+aaAQFW/Z4qm7B89ACEQAlFQ1YCtGEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVsrEtAvyZSTVJYh9Wwznfe7SxmGY6ftZVUQulhvYqs=;
 b=NuucIcbz+n+tqaDy3TgbYK/6juVfK1gm7lZQ6xTFZI9pn+Liu8QgaSRP2qHjkeSOw4lYRouYKbp7kGOlr0v0E77zADLOluEnskQweuHxWi5EvF6zVg9oZn0djC5uKKcjOyJfqJ5cdxDdEJZn7CuB8aNm8/kbm+HLVs+VaHpMlDudjcsCZkeVabKpevU9laK3diXkZ9zjFxcJVuU56fhv6Ya5CM9dec7Y5AvOu+amKLE24KCNwJk9TC4tQcg1NGJSn3bbM58HceUkn9+ZcYGY9js0hC9dFHW7Lq8gqSlshRPkOOVZY2DqHMbNXnTNiBmCdFBSvtkRinA4FrsUoQrH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVsrEtAvyZSTVJYh9Wwznfe7SxmGY6ftZVUQulhvYqs=;
 b=lku0amMtJRtpSrzwH7tdfk0QxfxxZeXQllbg0q+zZl7wGWiIKpH0SnU7U5IUAvxbTsp3SaORnpcbKtOsSa2YEQEg9ioGQme0uG4JMPPfxaAy7TOHn1f4iSnKS6QLM4sB7Pv4EIL22K/Uf96l/hSnxPc/nEu0qzO6TS9A6sj5Jeo=
Received: from BN6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:404:121::28)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 05:33:27 +0000
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
 15.1.2242.12; Sun, 8 Aug 2021 00:33:26 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 3/4] amdgpu/pm: Replace hwmgr smu usage of sprintf with
 sysfs_emit
Date: Sun, 8 Aug 2021 01:33:11 -0400
Message-ID: <20210808053312.3423-4-darren.powell@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4e6a227-e236-41bf-4a8e-08d95a2e0c19
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02032B0747420BDD8315D183F0F59@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YcTdQUL6viQTeImeb2IrAsGGFCLRwvZTRyFDXQRMIEStAZMCA2pdXTAzgBgqCqdp/cvtEszqAhs9p1F/8EVUGUU3lqPxdt2TY6sTddceXPco+0fSOW54Wv1GSuyHBt06zMZ/bUw2TB4VpTPLL1K5WzRCv5W2tzZL4YT7Y2iJwi5ajp8you8lUua0c4h8HojmWm8oyg1bnRGqNhcgHGggBIo5bsdspy/7E3WpsnEwC4luxWycfiDXfWcJkZXBshccZLNif/ZrWfF5fGgF+KHs+Fz3lDcaFN4OHJl/3zYgaTu3SThZFkdZuoxJ41EV2aMbf8Zzkpmuh4/r6gHYsld39Bdp3uqQoft64yQK/aVj37TA3AT9Pk8gZsp50hR8GLNKtCk0pJLkIS89g/csNbbfxpc+iCTebhhR2hvaLRlJXxn5A2eBp1s/11sZtxitPeiarJPydP+g87Ize/23f5nU8EXqL00nFm0ZYC+5L5NcJXxemeCGvyqkEtvYWedQNOwKZd2/DvI3oKUPsOBbG8YdPIVARdg2QMphJsf/FKqEwP6OI0Kec37kG5DUqsykY+03Ti5SL7+twLwfyMYI+C9IhIQBOxWh1NQrIQtDLPSLAEK5gLB6dT6iabO8aITb8yxVRk4wJUogZemc6cXX7V1vPKFTDcTmcKRV1QRZCeAZi5c2B0/Ydd2mgyAM/76SlxWXL1IrujZP6W+ai0/SQRO+wrh+9YgNXRakbk/gcmw2qUS60gAJvC5q+KUTlsHWz/fC3sd1NTHCMLQV+sJ5EOtIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(4326008)(7696005)(356005)(82310400003)(70206006)(70586007)(8936002)(336012)(83380400001)(36860700001)(36756003)(26005)(30864003)(6666004)(86362001)(16526019)(44832011)(34070700002)(81166007)(2906002)(1076003)(8676002)(2616005)(5660300002)(47076005)(508600001)(426003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:33:26.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e6a227-e236-41bf-4a8e-08d95a2e0c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

 replacing printfs with sysfs_emit
 minor smu7 change to remove compiler warning comparison of int and uint32_t
 minor smu8 change to remove compiler warning comparison of int and uint32_t

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
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 22 +++++------
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 38 +++++++++----------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  7 ++--
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 7dd92bdf7ffb..1de3ae77e03e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1036,13 +1036,13 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		else
 			i = 1;
 
-		size += sprintf(buf + size, "0: %uMhz %s\n",
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
 					data->gfx_min_freq_limit/100,
 					i == 0 ? "*" : "");
-		size += sprintf(buf + size, "1: %uMhz %s\n",
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
 					i == 1 ? now : SMU10_UMD_PSTATE_GFXCLK,
 					i == 1 ? "*" : "");
-		size += sprintf(buf + size, "2: %uMhz %s\n",
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
 					data->gfx_max_freq_limit/100,
 					i == 2 ? "*" : "");
 		break;
@@ -1050,7 +1050,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i,
 					mclk_table->entries[i].clk / 100,
 					((mclk_table->entries[i].clk / 100)
@@ -1065,10 +1065,10 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(data->gfx_actual_soft_max_freq > 0) ? data->gfx_actual_soft_max_freq : max_freq);
 		}
 		break;
@@ -1081,8 +1081,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				min_freq, max_freq);
 		}
 		break;
@@ -1456,11 +1456,11 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%s %16s %s %s %s %s\n",title[0],
+	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
 			title[1], title[2], title[3], title[4], title[5]);
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_COMPUTE; i++)
-		size += sprintf(buf + size, "%3d %14s%s: %14d %3d %10d %14d\n",
+		size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n",
 			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			profile_mode_setting[i][0], profile_mode_setting[i][1],
 			profile_mode_setting[i][2], profile_mode_setting[i][3]);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..c67718c85e98 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4896,8 +4896,8 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct smu7_odn_dpm_table *odn_table = &(data->odn_dpm_table);
 	struct phm_odn_clock_levels *odn_sclk_table = &(odn_table->odn_core_clock_dpm_levels);
 	struct phm_odn_clock_levels *odn_mclk_table = &(odn_table->odn_memory_clock_dpm_levels);
-	int i, now, size = 0;
-	uint32_t clock, pcie_speed;
+	int size = 0;
+	uint32_t i, now, clock, pcie_speed;
 
 	switch (type) {
 	case PP_SCLK:
@@ -4911,7 +4911,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, sclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4926,7 +4926,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, mclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4940,7 +4940,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < pcie_table->count; i++)
-			size += sprintf(buf + size, "%d: %s %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s\n", i,
 					(pcie_table->dpm_levels[i].value == 0) ? "2.5GT/s, x8" :
 					(pcie_table->dpm_levels[i].value == 1) ? "5.0GT/s, x16" :
 					(pcie_table->dpm_levels[i].value == 2) ? "8.0GT/s, x16" : "",
@@ -4948,32 +4948,32 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
 			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
-				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
+				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
 					i, odn_sclk_table->entries[i].clock/100,
 					odn_sclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_MCLK");
+			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
 			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
-				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
+				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
 					i, odn_mclk_table->entries[i].clock/100,
 					odn_mclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.mclk_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
+			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
 				data->odn_dpm_table.min_vddc,
 				data->odn_dpm_table.max_vddc);
 		}
@@ -5503,7 +5503,7 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%s %16s %16s %16s %16s %16s %16s %16s\n",
+	size += sysfs_emit_at(buf, size, "%s %16s %16s %16s %16s %16s %16s %16s\n",
 			title[0], title[1], title[2], title[3],
 			title[4], title[5], title[6], title[7]);
 
@@ -5511,7 +5511,7 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 
 	for (i = 0; i < len; i++) {
 		if (i == hwmgr->power_profile_mode) {
-			size += sprintf(buf + size, "%3d %14s %s: %8d %16d %16d %16d %16d %16d\n",
+			size += sysfs_emit_at(buf, size, "%3d %14s %s: %8d %16d %16d %16d %16d %16d\n",
 			i, profile_name[i], "*",
 			data->current_profile_setting.sclk_up_hyst,
 			data->current_profile_setting.sclk_down_hyst,
@@ -5522,21 +5522,21 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 			continue;
 		}
 		if (smu7_profiling[i].bupdate_sclk)
-			size += sprintf(buf + size, "%3d %16s: %8d %16d %16d ",
+			size += sysfs_emit_at(buf, size, "%3d %16s: %8d %16d %16d ",
 			i, profile_name[i], smu7_profiling[i].sclk_up_hyst,
 			smu7_profiling[i].sclk_down_hyst,
 			smu7_profiling[i].sclk_activity);
 		else
-			size += sprintf(buf + size, "%3d %16s: %8s %16s %16s ",
+			size += sysfs_emit_at(buf, size, "%3d %16s: %8s %16s %16s ",
 			i, profile_name[i], "-", "-", "-");
 
 		if (smu7_profiling[i].bupdate_mclk)
-			size += sprintf(buf + size, "%16d %16d %16d\n",
+			size += sysfs_emit_at(buf, size, "%16d %16d %16d\n",
 			smu7_profiling[i].mclk_up_hyst,
 			smu7_profiling[i].mclk_down_hyst,
 			smu7_profiling[i].mclk_activity);
 		else
-			size += sprintf(buf + size, "%16s %16s %16s\n",
+			size += sysfs_emit_at(buf, size, "%16s %16s %16s\n",
 			"-", "-", "-");
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index d425b02b1418..b94a77e4e714 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1547,7 +1547,8 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct phm_clock_voltage_dependency_table *sclk_table =
 			hwmgr->dyn_state.vddc_dependency_on_sclk;
-	int i, now, size = 0;
+	uint32_t i, now;
+	int size = 0;
 
 	switch (type) {
 	case PP_SCLK:
@@ -1558,7 +1559,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_SCLK_INDEX);
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					i, sclk_table->entries[i].clk / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -1570,7 +1571,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_MCLK_INDEX);
 
 		for (i = SMU8_NUM_NBPMEMORYCLOCK; i > 0; i--)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					SMU8_NUM_NBPMEMORYCLOCK-i, data->sys_info.nbp_memory_clock[i-1] / 100,
 					(SMU8_NUM_NBPMEMORYCLOCK-i == now) ? "*" : "");
 		break;
-- 
2.32.0

