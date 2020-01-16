Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B7C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB77F20663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h4rfCYZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB77F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821F56E48C;
	Thu, 16 Jan 2020 20:14:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896456E47E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9LaX7cOUVE5dhs9E7UJGCy17C0ZuY4BjsLIlwrAsoEQVU2mkGfBUHOOblYUZTO0zLxW8UWx09YtVbCURxiiDATPAkvtfe3HfIaUuY3Eo79mt+JTU/tufnneW0zks4UdedwwbOPBD9tzTJdV9Q5cg+PHEdmnihWfzKl7z+qRClJK4sibB4cj+OuGCRbWze2NhehIX+W27JrmONEpmM6yMG5rABu/hlzgWu+FwlTfdiAiG++sNLGbYrJgcdcz03RFRWAaWTvET6sojm0blU/+NNgWKw5js216BJ3Kr5G3X5Rz59l21jV5p/qmPG6GoEbXmqUitpROHSFuZV88zBDBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a/6UdB3KYQtZnN6qeDYuo5JCe6ShoUlmnGjmbOCmR4=;
 b=AN9/u8DU97gOtshLQzVHLh+bUZslkUV3T2M03Pr/kJKrHjMKLgIgSkzBWccPHOU9KGdl9RVC4vYj/W7p15qJR5NmhClrrCIke8+YRRsx8bC7XoorPpae5lpD/FEeTpPAwaz2mGAFdnixyO0BUG3vvz/kSw/RcclGivIOne9dQV/ETc/m7o+Z8wG82icRoR+lJ4XlLFYZmJG5ctrL7RTNnkKltGAkX01FAlSO9PC8m8bWrLhTl5ZbtA9Vf/kBGh0/wnEFhGGJ2w4uPyxHDVW8Us+fxddao5sxAUsvkZaxBGCxu7NAwPEGujekmoiO7wyffL4bQ1lANjnO2CVa4LhgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a/6UdB3KYQtZnN6qeDYuo5JCe6ShoUlmnGjmbOCmR4=;
 b=h4rfCYZGyMngvZ0szopy1Z0oHdvv9zYZELMMNRFt7eal6XmYcFQ2c0zvyg0F3OHOE+3X0dQTNDWlsr3vXqnHuP5C5I4Oefpv4lveafu+s0T/gEkK7UZYXEGilREUie5C3AeESIToP9Un+ElK9TWTdBdfhcAG3tE9NyyZ2+WRn30=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan
 2020 20:14:38 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:33 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:33 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: use odm combine for YCbCr420 timing
 with h_active greater than 4096
Date: Thu, 16 Jan 2020 15:14:18 -0500
Message-ID: <20200116201418.2254-23-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(6029001)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(189003)(199004)(356004)(5660300002)(6666004)(6916009)(478600001)(2616005)(2906002)(7696005)(1076003)(26005)(426003)(54906003)(186003)(336012)(8936002)(316002)(86362001)(8676002)(70586007)(81156014)(81166006)(36756003)(70206006)(4326008)(44824005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3762; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc2393cd-85d6-4b08-3637-08d79ac0b6a5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37626DFBA31E92B1EEBFE85CF9360@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vnj+6RXobUHiRAPgXTfBuAJhIIVeYDPmJ1hHHOnsSdXI6aYHe7t92YqKVF4p3uAuurR4SqDsMwsWAVWEcxyFlEUIhhc1JmGRBx3HqmFMJO9EHiL+aV95gAZwX1FtWn/3KcOPzUr0o+kLg1gdays5pqBo9ApGmMC0Qmk7lqMbIes7+/7Pf8PRKR/9d9DKKM8WBF6XsVGqcGcglMOepUsEwAa1OT4uZTFwrgDKThmDi8K9LYlDMPp1lLrpsdF6AxuR8AqyKvIXMciv6kycAnSnAasIFJXDy4SIGMuzGkkyIV9oUuLg6bMAlW/Odm1bfoy97CDjCiFXHNhJ+5b7nNiO1kUWGC3KApHgD2J15K8QV5kyc/wuLtcwTLMTuRcEAYcvEYu4VQkH6LNUXyW8w26d87Jd7JZzHoPMwK5VCEa/gpPK+sRBKqOQabTYd3Pan68Jn+LnkAwn2Z3qImN9A9sdySNvrCnH7znb9upnRLArJabzq9o3aG07oIC0UlzjRryc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:38.3862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2393cd-85d6-4b08-3637-08d79ac0b6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
FMT has limitation to support YCbCr420 with h_active greater than 4096.

[how]
Use odm combine to overcome the limitation.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 19 ++++++++++-----
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 24 ++++++++++++-------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 24 ++++++++++++-------
 3 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index e7a8ac7a1f22..45f028986a8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -38,6 +38,7 @@
 
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
+#define DCN20_MAX_420_IMAGE_WIDTH 4096
 
 static double adjust_ReturnBW(
 		struct display_mode_lib *mode_lib,
@@ -3894,13 +3895,19 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						&& i == mode_lib->vba.soc.num_states)
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
-				if (mode_lib->vba.ODMCapability == false || mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine <= mode_lib->vba.MaxDispclkRoundedDownToDFSGranularity) {
-					locals->ODMCombineEnablePerState[i][k] = false;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
-				} else {
-					locals->ODMCombineEnablePerState[i][k] = true;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+
+				locals->ODMCombineEnablePerState[i][k] = false;
+				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
+				if (mode_lib->vba.ODMCapability) {
+					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > mode_lib->vba.MaxDispclkRoundedDownToDFSGranularity) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					} else if (locals->HActive[k] > DCN20_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					}
 				}
+
 				if (locals->MinDPPCLKUsingSingleDPP[k] * (1.0 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) <= mode_lib->vba.MaxDppclkRoundedDownToDFSGranularity
 						&& locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]
 						&& locals->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 22f3b5a4b3b9..485a9c62ec58 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -39,6 +39,7 @@
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
 #define DCN20_MAX_DSC_IMAGE_WIDTH 5184
+#define DCN20_MAX_420_IMAGE_WIDTH 4096
 
 static double adjust_ReturnBW(
 		struct display_mode_lib *mode_lib,
@@ -3935,15 +3936,22 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						&& i == mode_lib->vba.soc.num_states)
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
-				if (mode_lib->vba.ODMCapability == false ||
-						(locals->PlaneRequiredDISPCLKWithoutODMCombine <= MaxMaxDispclkRoundedDown
-							&& (!locals->DSCEnabled[k] || locals->HActive[k] <= DCN20_MAX_DSC_IMAGE_WIDTH))) {
-					locals->ODMCombineEnablePerState[i][k] = false;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
-				} else {
-					locals->ODMCombineEnablePerState[i][k] = true;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+
+				locals->ODMCombineEnablePerState[i][k] = false;
+				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
+				if (mode_lib->vba.ODMCapability) {
+					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > MaxMaxDispclkRoundedDown) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					} else if (locals->DSCEnabled[k] && (locals->HActive[k] > DCN20_MAX_DSC_IMAGE_WIDTH)) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					} else if (locals->HActive[k] > DCN20_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					}
 				}
+
 				if (locals->MinDPPCLKUsingSingleDPP[k] * (1.0 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) <= mode_lib->vba.MaxDppclkRoundedDownToDFSGranularity
 						&& locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]
 						&& locals->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index af35b3bea909..e6617c958bb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -65,6 +65,7 @@ typedef struct {
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
 #define DCN21_MAX_DSC_IMAGE_WIDTH 5184
+#define DCN21_MAX_420_IMAGE_WIDTH 4096
 
 static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
 static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
@@ -3971,15 +3972,22 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						&& i == mode_lib->vba.soc.num_states)
 					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
 							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
-				if (mode_lib->vba.ODMCapability == false ||
-						(locals->PlaneRequiredDISPCLKWithoutODMCombine <= MaxMaxDispclkRoundedDown
-							&& (!locals->DSCEnabled[k] || locals->HActive[k] <= DCN21_MAX_DSC_IMAGE_WIDTH))) {
-					locals->ODMCombineEnablePerState[i][k] = false;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
-				} else {
-					locals->ODMCombineEnablePerState[i][k] = true;
-					mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+
+				locals->ODMCombineEnablePerState[i][k] = false;
+				mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine;
+				if (mode_lib->vba.ODMCapability) {
+					if (locals->PlaneRequiredDISPCLKWithoutODMCombine > MaxMaxDispclkRoundedDown) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					} else if (locals->DSCEnabled[k] && (locals->HActive[k] > DCN21_MAX_DSC_IMAGE_WIDTH)) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					} else if (locals->HActive[k] > DCN21_MAX_420_IMAGE_WIDTH && locals->OutputFormat[k] == dm_420) {
+						locals->ODMCombineEnablePerState[i][k] = true;
+						mode_lib->vba.PlaneRequiredDISPCLK = mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine;
+					}
 				}
+
 				if (locals->MinDPPCLKUsingSingleDPP[k] * (1.0 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) <= mode_lib->vba.MaxDppclkRoundedDownToDFSGranularity
 						&& locals->SwathWidthYSingleDPP[k] <= locals->MaximumSwathWidth[k]
 						&& locals->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
