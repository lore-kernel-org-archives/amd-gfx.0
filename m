Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E297ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443E110E7E0;
	Wed, 14 Sep 2022 03:26:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFF410E7DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyP2WS1s4z+JJg+yNpvPB5SuVbhnP7D77RcGbZAolKhEvU5zztq1yW3Ws4hEEyCpj6o7hjQGyUF8iOqi2y/zMAM6xiA4xk3JT0dfOGjd7BYR9PxRic8iQOSKVLFlJ98bdnLWzbVq/jvo/htEp29OiavhZttPply077AxSnU6yvxy74cVXPncQ0g/cL+457jhwEuSUS1hkikyXMg6z9i+JZUGCJHCuZNXqm0j4j6Gen4AiIaB8FHTCPDCgHWm1mRfGfrKEGiSiPdTF0Sqz6I16yDCy+bh7MRZjGoZJjXeIDFRgaaZ8YoFMMAYdnmRzxzPaKzdAHvF9fIWXoCPnxX0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=i6SupMHxXW8qxyg/KdTMupfde9Z2xYWg14ookaJ+s3A9aGUj1xB7Dm9sArZSlKtGWSqpuCuQ+eh/T1jEWCSNGHQtLAnLdDKd92TTb35aP0hhjwlDv5YRylaBnoR4/S5r4bWbn9MQ8t0brja0Vdl590n8cmg0P9S0yZpp3WPYlTXCo9CGzpdOAowxzqD27YWKA1tA7QV+dd7K8A5cQuK+MgIUdStN8PSYdRmVmhjKjBZWOIbK9TWJHzKwjSqAIMg5h+X6rLK6JwO0iFvBtTYuwu9uVzmWc1MtgSHzUzVEQcHT/5zeBjT+6z+O+VEW82ORvEQoGQ2iEHGKAF2c9kmm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=Nktu9Z7Aruge6l+qZSgZmxg+1npe8UPXx0oIBMmrRYCZwqqHt25uhV6ItkBAALc+NT01XPRw1QKDK4Ce2a+8iiMfMURIXDHUrTWH8b/BGzX+aFhHEwUisqNQysaAzzyS+7ki16r/r/gEiLRh5fiyFTnyuRbbtchql9cDDu6qWT4=
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:26:00 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::9b) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:25:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:25:39 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:25:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/47] drm/amd/display: Port DCN30 420 logic to DCN32
Date: Wed, 14 Sep 2022 11:23:55 +0800
Message-ID: <20220914032441.1075031-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 547cb262-b741-4c40-3960-08da9600d89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bm3sCrhWc0vZ0kNPMna1b7Ux/Me0gtbuhuTYeK5ijpBCv7JcmGzMlLIMhz8rUcJFfjGftFE2nd1qcCNQGONL6VfLb97zOzWX9yEUba6BJs3X8wcaBRBpJYkusBqyA2XK6OL49GtEA+VtIhD/3w/fh0J/3YRTCqKUbNJZRSFr5q18wKyqRkolxyu3GNie0nyRdrTThyt4MRuxWHYIiubDkLQpNBz3VY+cCa7n3Un1wW0LibjaJr7eTVkslWf64GjkmPaj1iE5M8ZpeStIER7jw5YXFbnDS5SBpJAZ7Z+JCitQQmenQtqYQ2gltCu2btAvgm+gYUD+tzbCVONVZwmLKc9RJacpAKta5QKXB7g4MyMOd7aeRZkkbgPv4mlNFrBlWaHjr7/CBBxvVwY0MZAMN+R7ZOnudfAZ4zOC4KGLQ6CuyFWgd/Ei6enDQAgLTlzgiUUuXfAdB4nFcmwq/1EPwp8WDBBKLi7MPXbaRS7myq7oebxLUmjPcJwDZdPPPW8NudzPMssM0RAjWPCW3MIKH12kDpk7SGpZZA/SpB0qnd9Z6szzklV5Z7ZFM/VLbF07Nsh1sX15uqG8RLj0xg8ZkPLOqHx54qNJFPPbiNmCc+wGZFlAOAdHhYRrZwEXQCrEnhT2oP+bC2IXthUGIo2QFqRtOra1EM84hbROMZ6CK0XOzeNVXg8hY3pJmG0ZFEb5pND5nshdq0C3cp6Yb3gzo5uIAWyzRtFNg8E/maoW1+p5dht31R2J+r2Ggbzo5Hjwf6UKU71FhrWOO2h9bhepScEVv7X3gCsiyvvcsQe+h3Y4uBqjg7HOfU1FjvPBZqAB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(36860700001)(8936002)(40480700001)(1076003)(82310400005)(2616005)(6666004)(2906002)(8676002)(356005)(36756003)(81166007)(426003)(82740400003)(336012)(316002)(6916009)(40460700003)(41300700001)(70586007)(86362001)(54906003)(47076005)(70206006)(186003)(83380400001)(26005)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:00.3692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547cb262-b741-4c40-3960-08da9600d89c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
420 modes are limited by FMT buffer width of 4096
which requires multi-pipe support in form of ODM
combine.  If 420 modes have greater HActive than
4096, the DML logic should accomodate whether
it should be rejected, or ODM combine 2:1 or 4:1
is triggered accordingly.

[How]
FMT Buffer limit of 4096 in DCN32. Force ODM
combine depending on HActive and FMT Buffer limit.
Reject modes if TMDS 420 and above 4096.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  2 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 26 +++++++++++++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index ad100658132f..75be1e1ce543 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1992,6 +1992,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				dml32_CalculateODMMode(
 						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
 						mode_lib->vba.HActive[k],
+						mode_lib->vba.OutputFormat[k],
 						mode_lib->vba.Output[k],
 						mode_lib->vba.ODMUse[k],
 						mode_lib->vba.MaxDispclk[i],
@@ -2014,6 +2015,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				dml32_CalculateODMMode(
 						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
 						mode_lib->vba.HActive[k],
+						mode_lib->vba.OutputFormat[k],
 						mode_lib->vba.Output[k],
 						mode_lib->vba.ODMUse[k],
 						mode_lib->vba.MaxDispclk[i],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5b5b94f1024d..ad66e241f9ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -27,6 +27,8 @@
 #include "display_mode_vba_32.h"
 #include "../display_mode_lib.h"
 
+#define DCN32_MAX_FMT_420_BUFFER_WIDTH 4096
+
 unsigned int dml32_dscceComputeDelay(
 		unsigned int bpc,
 		double BPP,
@@ -1179,6 +1181,7 @@ void dml32_CalculateDETBufferSize(
 void dml32_CalculateODMMode(
 		unsigned int MaximumPixelsPerLinePerDSCUnit,
 		unsigned int HActive,
+		enum output_format_class OutFormat,
 		enum output_encoder_class Output,
 		enum odm_combine_policy ODMUse,
 		double StateDispclk,
@@ -1253,6 +1256,29 @@ void dml32_CalculateODMMode(
 		else
 			*TotalAvailablePipesSupport = false;
 	}
+	if (OutFormat == dm_420 && HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH &&
+			ODMUse != dm_odm_combine_policy_4to1) {
+		if (HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH * 4) {
+			*ODMMode = dm_odm_combine_mode_disabled;
+			*NumberOfDPP = 0;
+			*TotalAvailablePipesSupport = false;
+		} else if (HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH * 2 ||
+				*ODMMode == dm_odm_combine_mode_4to1) {
+			*ODMMode = dm_odm_combine_mode_4to1;
+			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineFourToOne;
+			*NumberOfDPP = 4;
+		} else {
+			*ODMMode = dm_odm_combine_mode_2to1;
+			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineTwoToOne;
+			*NumberOfDPP = 2;
+		}
+	}
+	if (Output == dm_hdmi && OutFormat == dm_420 &&
+			HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH) {
+		*ODMMode = dm_odm_combine_mode_disabled;
+		*NumberOfDPP = 0;
+		*TotalAvailablePipesSupport = false;
+	}
 }
 
 double dml32_CalculateRequiredDispclk(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 3dbc9cf46aad..55cead0d4237 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -216,6 +216,7 @@ void dml32_CalculateDETBufferSize(
 void dml32_CalculateODMMode(
 		unsigned int MaximumPixelsPerLinePerDSCUnit,
 		unsigned int HActive,
+		enum output_format_class OutFormat,
 		enum output_encoder_class Output,
 		enum odm_combine_policy ODMUse,
 		double StateDispclk,
-- 
2.37.3

