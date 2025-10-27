Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52923CCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 08:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D6010E155;
	Mon, 27 Oct 2025 08:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDkXi22E";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAF410E06B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 08:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giUcsiInEZcGFAVCjKyYFqKWiPPs3ryOxWd7xRs/WGbRpa3bxIVVJsxRC4apDRahzWW2Nha6ee7GTZJiuFDFFsWPjrM4UZIfSAZxvcPbOZkRXTKJMxBgz3oChqLkNiYgC1hm4hi4Pb8kWfda+6cOpJCbNLyUz0bEQS1/8tStJE+jJo6bHXsOmqVtDdWp9ZKyo4/uxXuTtvByfs3gpfzFZPUy0tqcNec7zSKTTJ9x2ODT1ucQPjTRUjvxQRklGzd1EVOt5jm+UDpXR090OlTuTUSQMLkUxQHK70PhGXvm3pmypOJvKWTB1H6BCO1PFO1H01J7tU/QMT8c3VXQubkHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e8qCzldfmcGy8angdZ2y57mGg9Z9ZOKfD+EAf6uvhg=;
 b=WaKeTDgzpohunxOTq+BmhVkhjPnIdqHNCYbB5i7YS2Tdu7VYOBy2olF/GV72Gk0N+UIgA2YQyUDsrrrVBWU/57sHc8vBFVZCBvxfbaG0RF39WhQYJgi9XiXE7alNen1+bDBMRhVxBoCnnFETZwqFqTBqQFmh02oXYXd+l6TbJpS9PD9C9grW5+W2oQpNbx1ZzwR/cTdAQoApe2hzbMLG+mfqz11GhsksQ2CR1nuZUDr/2aBvzTrB/2EAejtnWJ6+Fj49ndzXfDD24cYRIOOchts+BY1Ph0SvFIfI8lM54CmI33TAVnxJv3/T6YmEYQZtDaYEPTJNImWezzrE8PPbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e8qCzldfmcGy8angdZ2y57mGg9Z9ZOKfD+EAf6uvhg=;
 b=VDkXi22EHu3KPxSs3hstcK+xEb9x6vopIt+kI19lE77HN3fCg5qDTUfA1gxAvGHx32jmlIred5uDgA1ZGoEY7SZe2Maw9eaQJFKnjnKfBW/BpbKfss57rUJnaS/VYzdr/OLgSiHOuLBc8q9GACPlM85xtjOpsDHgk8zri30KiF4=
Received: from BYAPR08CA0005.namprd08.prod.outlook.com (2603:10b6:a03:100::18)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:40:11 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::8b) by BYAPR08CA0005.outlook.office365.com
 (2603:10b6:a03:100::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 08:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:40:11 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 01:40:06 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: fix the issue of size calculation error for
 smu 13.0.6
Date: Mon, 27 Oct 2025 16:39:56 +0800
Message-ID: <20251027083956.1278788-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4030c4-198e-4c8b-16b9-08de15347101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GybWy/gJriIyVInemlquY955RaWhFr4dmktGgPY/gUEMGaVv1UaMjMiB+4G?=
 =?us-ascii?Q?gnzrbbahxkFIq+M7eaY+gkrXG+BH7KTOhHYZ37EGZ98gZHQwUtS7TmOtfOLK?=
 =?us-ascii?Q?DhVdi3EmuZaGW4Ae0o2HfoQdJHjSV7+uSqCbXRh6fEnV9mCcjBktFJIPJjSB?=
 =?us-ascii?Q?3UZt1dOCcpBFzbtaV6vfxoAu7rJPgH4K6OCeVAhjAJyD1DL3Ui0dilwoL4DF?=
 =?us-ascii?Q?CBdbb7FXhCLgXZe2Gkyz38YY9RnfuWFH2QQDb7+kvNIb4TUo+0mHuEQ3wS+E?=
 =?us-ascii?Q?5RhV3PdFpHxOTwW/NbOBDKvKZwWDwBvR7VpAICz6V3BEzM01EuC2kYauCSGf?=
 =?us-ascii?Q?AtymkCXIYOjiIJUu6S1SVa9BA3WG0RRRKCxYE6Uq5Z52gTgIosDJxn962HZt?=
 =?us-ascii?Q?3BxJ0vD50H6CGsOo6ENB120JrOmIEbpOaGwFsIoyeYfmLQcR9SnNW8lEW/Tp?=
 =?us-ascii?Q?0lsprDMZT9QJDg3jJ5ZgF2TjD2DmWJLEazfEkMVthOKQ4Gj2oS+jfEs6KZpo?=
 =?us-ascii?Q?Wi9j69A1u8blOxuxrwQhEw+mC+kH9CnEvR3/5PoPtaJQhrX79C+ull2gN2NB?=
 =?us-ascii?Q?SfunGvllFCGCdDYRWjJxQaZOhnEWzcUPHuqTn8PP4IdTRjJma8ji3iBjcT7A?=
 =?us-ascii?Q?0nlV4GYDSXPx9h1tBPewd57WT5OIQd5UTo9gDBhx/UxkGGiWbV9NoiNv0gc+?=
 =?us-ascii?Q?Nk5YHVGCMKfw6T5zQ/czTVFzkr7jyitiLdZrBSVl1dWUnaeDvqtsSmTNZ0vA?=
 =?us-ascii?Q?0twz6+HDWtW+M085UH/I4vVovgAOd5Z/q4rvdpURnevvgiYR6np13jbpwYjo?=
 =?us-ascii?Q?20sMmlX/wTm0ykDmtNNFkAx/qk+TqhjYGCMZblRgwENKOHJmJkTRNrXvalAD?=
 =?us-ascii?Q?UrmR4BUr488uC7Xg6mAHakAHOoLIT+LOOgTMv4ZHKoaTds8UjGzHWiFpfsXT?=
 =?us-ascii?Q?d8iDf8t9clzseqr1VjXI1XyLS0NXG6V9MHr8lzrVw1XhXATj8d1VfBPqdnsL?=
 =?us-ascii?Q?uqtbQv7jGkF2WJ/IMrRXmdQDHPfNhgAXxEHXbdispvsIyDHwv37Y56quGfcB?=
 =?us-ascii?Q?WCxkDTbiY/P5So4KLmdS+1T3d13/TgvSBBSYMKAtGRatToKQejr60VMFtCDg?=
 =?us-ascii?Q?T2nPrSQlI01am0/CQK7F3yXeo00ZH61qLXh9KJwxpjZliX/BuD5P0m+aKd5/?=
 =?us-ascii?Q?08c347lHLHt+rbzecJxuyjcwJKvmWn7zTWjrpKLvomHSSnGELRPmiVtFJjv0?=
 =?us-ascii?Q?qTv6ERTDpqWNk2hK0p3nsN3aan1dFcXhYNUjh0N20HnTq8Ly7c/7zLtARlxp?=
 =?us-ascii?Q?Vzf2wzQUgmniNCnwq6jH4x536KLndhczzARQskpu3C7x2Q8xJivcP9xeF3lK?=
 =?us-ascii?Q?+ydpDbCHt5HSXTpMkDdxa9YDibI2JEVw7eyxus04aYXMvOC48HyW3JeeuXSd?=
 =?us-ascii?Q?Q7tEfl7HbH9N7ZN51xfuYkzqMD1SHRGOSxisj5ZyfPVWOKRLOYd9WZnSWwzT?=
 =?us-ascii?Q?CcIn8VIX5CYxIHaYPNjWcA/j5tWhbzV6pAM1meaZDGhEuNQHP3yRWsyUOvrJ?=
 =?us-ascii?Q?etio/W0GAtKGiocPnNE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:40:11.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4030c4-198e-4c8b-16b9-08de15347101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

v1:
the driver should handle return value of smu_v13_0_6_printk_clk_levels()
to return the correct size for sysfs reads.

v2:
fix the issue of size calculation error in smu_v13_0_6_print_clks()

Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 39ae6701147c..1d9cc384fc30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1394,7 +1394,7 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
 		return -EINVAL;
 
 	if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD) {
-		size = sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
+		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
 		for (i = 0; i < clocks.num_levels; i++)
 			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i,
 					      clocks.data[i].clocks_in_khz /
@@ -1514,9 +1514,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "mclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "mclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_SOCCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
 								&now);
@@ -1528,9 +1532,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "socclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "socclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_FCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
 								&now);
@@ -1542,9 +1550,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "fclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "fclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_VCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
 								&now);
@@ -1556,9 +1568,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "vclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "vclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_DCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
 							       &now);
@@ -1570,9 +1586,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "dclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "dclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

