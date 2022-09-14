Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D655CECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A84310E244;
	Wed, 14 Sep 2022 03:48:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7675710E226
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJF/eIAzj71VSgRThvBKjJ2P6yjyhXYLl6j/kKCWFhf++G86cuf3TECgjE0P11JtIuQD7acSoAUolTMwGlFoa06qtDtAYj8zU7f9qRO+tiWEanNWfLmQXM1YjyfbH5aqmHuwitNrEvtWL1QkuV6TIUOyYSMxGNbiNMFyLV8I2rgxL6oMgVojOzRLOT7yye7uloPW5c+34QblZ6IYa08ShdHf7DvNkss4fcprkvceD0i/y5sYClCM1wti2Af4j9yd8qDWHj845gjALxCdSUlW3dTrbFE+Heu6Gv6PFoI/mr+stZXZpvhRYsNtqAiREsYwhVu6vDtZG34ZpoGIe2IgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=g7Hk12SO3ZkdgIkzi15r01Yw7TyGZGeMr58ivvj3IEzosoTGtCkG8pZowIGqpBMkzIsjCxI7fR5TLr6AuzdLKkAREDnLvfuxUYmzGenkND6KSG3Mg2qeEqFGFMbKLEwLm9yP6i4c65sguLSpR6QF9lz6oQMJ7kgwNItMq8kTYMCLpJzQJO+NXPK7me6ThPTCijbAjUWWubaCIkMVrLjsT79w/SeHRGNB8QT6NJ77kJFXnGMCcp8PMCF9zcHz68NUa1vUvKF4ov8vkjqFhTCpn7wf6WkBDzu92P0PlBX1Ys2GcmdtoB1d2Qbn2rlVNs8SjAH+Sz2zE0DKuvKfCybU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=roch2YXOMyGHkCW803UeQ63j7Nk/r++5xMj78pKDc9TId2/HE+owGwSQKDJ3aZTiSB7GNxynyvP+ATRoLL7hHNWKEH1WpFKkJXnbRy12rCbu9AmOwa0WhX+y22Lf6yNZHxp///YagD5OTMHfMdBgkBWlkg/vOmtwLWY/8ur0RaE=
Received: from BN0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:e6::8)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:48:32 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::f7) by BN0PR03CA0003.outlook.office365.com
 (2603:10b6:408:e6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:48:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:48:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:48:30 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:48:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 01/47] drm/amd/display: Port DCN30 420 logic to DCN32
Date: Wed, 14 Sep 2022 11:47:22 +0800
Message-ID: <20220914034808.1093521-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e641fa-0c25-41f0-a10e-08da9603fe1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5k0+9SgJdxi5WYWU51AyvTCD5glVphQQ+1JNrTGfytfzr7jR3v34EF4hZuXoS3mkZ25GlMFyrKoPTIfrGJbKb79cIHi0+GXgKhySJ5I/NVzmvhlrt5Ep+P9RFViBNpFPLzbgat7twRmggQlRCLjSxCT9RQbW5BxUIx2ba22gGhI00BxpwQhSO1xOKowc2kH1bMB9gouZ13iLGQVZRESoCKnLppwaxfSIVpjiJPFdyJIphuw+98vmxd3RCHLhP4iGWr2BGrjBPrUiABhwyKkSg6/Y3bz6V7JL1OwTGEo9nkmdx52tHC6OMeOzh0EK/8Awh+C90ADgRDRZ49xjBRPQZShAlKnWRBljQumy/Hwzzgn2HNt3D5MsB+DnZ8YUiAr746/7RGGhPdonnX7HEmM9qSG+Z5EPREKCIut9MsVv/810E+f8m22YqNxuyGqzb11p6YWvUF92HtTD9ziQMm4yrcWWEellm6nr4FPx6ddrgBGBBYSo98aDnAH+MiDX6aHfu9P1p+N8YDP9H/T4tkQBzBApka4CYwYAXixXm6R6iE4D+ckcMQvRNcAhQhQRtMypJTVw5vmmA/H/2ojTRkRTkiwL6Hy+QXEY9vb/c94Svy3CvsxHHGmidja3FSmbzuNpKnIOEfJbawKbIBgCPoe/zDgzvjlw4zlAELK0tQMBT2tQ7WTOCynIwHVZLDNy2+USXeGkq6AGyz1O3qQGGI46v78b7Wqbf2D507wWgkhH2K7IABsvZYQJoc2C14LmcMwQ2XobMyaKhj6bivHAwFnoNH5PbLQNwj4hn+7Jaboqg9X7UkAdQqiNAZu6dcl63W5S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(6916009)(54906003)(40480700001)(82310400005)(36860700001)(8936002)(36756003)(83380400001)(356005)(82740400003)(70586007)(1076003)(336012)(70206006)(2906002)(316002)(5660300002)(4326008)(41300700001)(40460700003)(426003)(186003)(8676002)(47076005)(2616005)(86362001)(81166007)(478600001)(6666004)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:48:31.8210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e641fa-0c25-41f0-a10e-08da9603fe1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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

