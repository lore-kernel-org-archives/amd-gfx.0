Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF12C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 09:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1861207
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 09:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AE1861207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391376E92E;
	Thu, 11 Nov 2021 09:35:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946116E92E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 09:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJXQVrAyrXiIRAbEvVl1lyPtYe5IPEfs+UdNvdESnyhRlWzpiIjWw1Kpml0Iv7oSUJgQlRufH1Ry7lnL+fx6h1/Bz5q+gq7p2nwxIbIZW6JKoUsQa+Fqrl732VhxLqB2JIRjEkpiWPnQGWDAXH9dGWItEBifJsReST0r+rneCa8CWwv1mBQZIQR0FDo9T6MgaZ9UFn5G81Z+5AuTkhyoO2rXE8+bVsI4xZd2gu5lm4blH2gn0UW5HNDXaMEXFLF1vUxZ5HaV2y69kSOagD743I00kLF/eh28PUlTsZ/arruuGr2Hk/ywCIR06bFF1m9RQYcHgYO5YDd45D8jD1scMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+cVoF2o5diPOAya2E7f39wydm52LTl+Xb06we+1i5s=;
 b=VjMxRK4t6Pdhr/xY4n/zlEen+Ew+YZmFAHo6VgIYvmpCe9xme4Kx50ubGv+sKoW1vW+xllpXwOJdjLdf3xEKha2oMXIl2WDjlqDfA8LjfLzL1OwujCugz7BVDHQyJObzjpme0AILdvz3cGAC3+BEBlPGB7dHpnkg1VTlg3HcRQMTBue6a8JBTD13jlZtXP5lEFWKAC6S8zb0Nr+NxDAq7ms7vWmY7W94MeKTyJ6sjM6MzxbQILEgumE51iELo9X/vvtrO+cUvQs9Gd7sFcoOd+A+TunKhsE1uc4XcX8idVHEo8CeWwvb6KDZOYZrEPIELafm/ijlezz4jk1OlPPPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+cVoF2o5diPOAya2E7f39wydm52LTl+Xb06we+1i5s=;
 b=1eYnaa52FR4T20pe5OYSfiszlBjw5guVVSRhtZe6H1F2zMBbTzDtanCcJk5BRvil9EWS0OEc5T8AEaedyM2vIdB4rGKuaZOs5ypKoFpG0NcLDO7nwy96V6VO7tQrD6cmm7xv3EL37wTlLA06t3I/3jUQuc98VLUkMnuzLuasI/c=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 11 Nov
 2021 09:35:05 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::3) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Thu, 11 Nov 2021 09:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 09:35:04 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 03:35:02 -0600
From: Perry Yuan <Perry.Yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Ray.Huang@amd.com>
Subject: [PATCH v1] drm/amd/pm: add GFXCLK/SCLK clocks level print support for
 APUs
Date: Thu, 11 Nov 2021 04:34:51 -0500
Message-ID: <20211111093451.69243-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d6a6db4-0e22-42ea-359f-08d9a4f68afa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4245:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42459A5FCF01F14DA2E849A69C949@CH2PR12MB4245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUJxoTSRZwH4epFvactXLTtruXvPZHOrws94ifjVcqksqM18hHs12kfn83z2p7Mf6lIbiZxcOw4oHtez/jYx5q3fs/0wC8cjZ7fOIBs5ycV/CYCQEBPdodyZH6Ncdgm2MzEoh4yRY/sxtZY1JZtPs6cxa8H4pb3ojN4GWAGtlQs9pjLHb7LLli3rtXFiuET4kJMcXhaN9cSWB+c/YgPUVuE61YEVDnUNlkl+o3fpOcPRfGOm2S8kuJjQwj92OKojzVVJiso5x9f1XqTkApVIXr7ha2jkAA0AEmI53cRTtV8KeBz/699WXT1KEBviddvCz2ihxgDlHh4z0rz/SOLDGiK0TN8vZHgyF80JVeJ4eFuZUqS03C6Pb/TKtxOiDVTa7y092bXZs/CFgN3A1ldy5F4WNOyS3tSawr9GdeX2D+9k4r7b/H39NET9Ayu5YmUTFlnnj0LI2WBbngeEW0wckgLaqczDo1U0r3/Pt9L01UEmRF6UdH22dankRYIvY5jdO0punmV8kRpODiT9Eb1F9nJdSU/CvR9213T77BoVhNvqwvRixTWRCoo7fLbsVgcHNyF8sqaEIx6YOP3MzD/9e/Sox2dw6mSufKlmDZ9PEjhdWUvyEJZeOUJnaH2aAvOhUQFy2a4oX0OH550tsw7c8afO67iud8auMYZ0vBy0BBqXKONiCcWtz62U+SVM1/9m4PjCTDFI4/09YpE3E/vesUD+nkMK+mqVsNx3HS50+udElWHER0NAmdHDvN4iSjTu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(426003)(2616005)(82310400003)(47076005)(54906003)(336012)(110136005)(70586007)(356005)(6666004)(36756003)(2906002)(81166007)(86362001)(26005)(8676002)(8936002)(186003)(16526019)(966005)(5660300002)(508600001)(83380400001)(7696005)(316002)(6636002)(1076003)(70206006)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 09:35:04.9459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6a6db4-0e22-42ea-359f-08d9a4f68afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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
Cc: Xinmei.Huang@amd.com, Perry Yuan <Perry.Yuan@amd.com>,
 Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add support that allow the userspace tool like RGP to get the GFX clock
value at runtime, the fix follow the old way to show the min/current/max
clocks level for compatible consideration.

=== Test ===
$ cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 200Mhz *
1: 1100Mhz
2: 1600Mhz

then run stress test on one APU system.
$ cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 200Mhz
1: 1040Mhz *
2: 1600Mhz

The current GFXCLK value is updated at runtime.

BugLink: https://gitlab.freedesktop.org/mesa/mesa/-/issues/5260
Reviewed-by: Huang Ray <Ray.Huang@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 22 +++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 26 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 27 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  1 +
 4 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 3d4c65bc29dc..6e8343907c32 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -308,6 +308,7 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 {
 	int ret = 0, size = 0;
 	uint32_t cur_value = 0;
+	int i;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -333,8 +334,6 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "VDDC: %7umV  %10umV\n",
 						CYAN_SKILLFISH_VDDC_MIN, CYAN_SKILLFISH_VDDC_MAX);
 		break;
-	case SMU_GFXCLK:
-	case SMU_SCLK:
 	case SMU_FCLK:
 	case SMU_MCLK:
 	case SMU_SOCCLK:
@@ -345,6 +344,25 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 			return ret;
 		size += sysfs_emit_at(buf, size, "0: %uMhz *\n", cur_value);
 		break;
+	case SMU_SCLK:
+	case SMU_GFXCLK:
+		ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			return ret;
+		if (cur_value  == CYAN_SKILLFISH_SCLK_MAX)
+			i = 2;
+		else if (cur_value == CYAN_SKILLFISH_SCLK_MIN)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", CYAN_SKILLFISH_SCLK_MIN,
+				i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				i == 1 ? cur_value : CYAN_SKILLFISH_SCLK_DEFAULT,
+				i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", CYAN_SKILLFISH_SCLK_MAX,
+				i == 2 ? "*" : "");
+		break;
 	default:
 		dev_warn(smu->adev->dev, "Unsupported clock type\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f6ef0ce6e9e2..6852e4b45589 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -683,6 +683,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
+	uint32_t min, max;
 
 	memset(&metrics, 0, sizeof(metrics));
 
@@ -743,6 +744,13 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetGfxclkFrequency, 0, &cur_value);
+		if (ret) {
+			return ret;
+		}
+		break;
 	default:
 		break;
 	}
@@ -768,6 +776,24 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		if (!cur_value_match_level)
 			size += sysfs_emit_at(buf, size, "   %uMhz *\n", cur_value);
 		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
+		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
+		if (cur_value  == max)
+			i = 2;
+		else if (cur_value == min)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				i == 1 ? cur_value : VANGOGH_UMD_PSTATE_STANDARD_GFXCLK,
+				i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				i == 2 ? "*" : "");
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a403657151ba..cb5326d98f3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -781,6 +781,11 @@ static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
 	case SMU_FCLK:
 		return smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_GetFclkFrequency, 0, value);
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		return smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_GetGfxclkFrequency, 0, value);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1051,6 +1056,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 {
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t min, max;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1089,6 +1095,27 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 					cur_value == value ? "*" : "");
 		}
 		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			goto print_clk_out;
+		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
+		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
+		if (cur_value  == max)
+			i = 2;
+		else if (cur_value == min)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				i == 1 ? cur_value : YELLOW_CARP_UMD_PSTATE_GFXCLK,
+				i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				i == 2 ? "*" : "");
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
index b3ad8352c68a..a9205a8ea3ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,5 +24,6 @@
 #define __YELLOW_CARP_PPT_H__
 
 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
 
 #endif
-- 
2.25.1

