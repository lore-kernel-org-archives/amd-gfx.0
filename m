Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA5C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8CC60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8CC60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B456E92F;
	Mon,  7 Jun 2021 16:48:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84606E938
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9kldZsOtUpQnuJJJQJtqpaurIKxN2Qd6O2CE9TdQSkSNdMZQMpNJ0qzHX9JvNioLwjCSxGAXyVcfbRauTbugStcarsY8quRlaXOoKojeHY00QGtD456+I20qIjCxasKSkd7+SVRTL7wrV/mEJMrbp/hsJrPpDdAe8O7G02D8qQ7hk+QnGhIcpRzFZsYMb9XeCFpqhSwyIuevYZO9U/Nn13OSmfF1GlIw+AtOOyVc3KtE5zl5UajL3ipVI/vzLk9l/7TWyCIoNd/CQaTR89zks5ikD/JqFo6XaoNdpb5xeCtKnjtm6BPlutPV0fUb1XSmZ4sqKa5UmvNGnHWOySTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bJleqk3mfIWhN7wRta/jNWBKISfBrORDmOsyVmOrU4=;
 b=dPnoGwM7tWA6T/+gwoW+zqkci9U3AWpEqfsTFMcTNABv29WjH5R2PyUB5X6WO76dz7owNiLVEEv+6pbUnBq6YrrpNxG3LxkR1X6LHEd7woVKIz/OZ1+8v/oHw6uSK2JnWHortEi6BCBA0dLrqXwdSiAwx0+lDRI6eboJ5GcXNK8KfmDRkb/RQ+9f/nQykQohrS1LrMxAULlIVdeS43P5QDoa2lJlgsgmMBspPVk/U9qfkiQIChQHr1x5tuXMrh5U1NrumipHstJPYCS8pQkBrbBMTi5zDJdpURJrYv8CUr7LGMLQ0G6FL+5ws+SiEanbfwaAdgzoY8FU+zkFJHL1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bJleqk3mfIWhN7wRta/jNWBKISfBrORDmOsyVmOrU4=;
 b=nMnvQd3y9QUYuXO+4oJaDwIu3uXD06okgbsryIKFp0nqpVuIGfdlS2FGDeNHNm2+adxU8UUwXRb695a8oSOy6DQO8yEIeZ011rybyP3AlKtKxm82vLjpLVNnyjAX4QkLSpEYHjPl7alELHEeHsZ2dtDKd9V52kAMTidIaUlRg/g=
Received: from BN9PR03CA0487.namprd03.prod.outlook.com (2603:10b6:408:130::12)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:48:02 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::eb) by BN9PR03CA0487.outlook.office365.com
 (2603:10b6:408:130::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:00 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:56 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/30] drm/amd/display: Fix DCN 3.01 DSCCLK validation
Date: Tue, 8 Jun 2021 00:46:48 +0800
Message-ID: <20210607164714.311325-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b018cd-a0f3-4e02-36bb-08d929d4027b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37996BD912660B29FBDA3294FF389@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh6LfTDUTluRT7DYc/UbyCyPCXiv/T5UYyFH6gMN9HoChr/Xeq+V5tf5BoQekEfMOpL8r5bl2p6NVWOaGXNB8XXmRIyYsbwRw2JtwhOX1Tpx2QDKR7qpU3ZPvCsr2qtH4JTmUqGFtRhe4nWs5JR9zXO+AqY3PcY4gFTwPfu7sT1isOiWvySXqsY3GTVIVmpn7q8RQ2cauLqSj0nC6wUgkRBEvG6C9dOis0gDj9wxwhnYtPDn8OwDOdhH5Pcv3xIR5+DUDvCtwIvFzYzhLMTDqRHNPHEhuTF3O/tuAZd/pFtKLz+l3EiB/p3GBsR82XtmYjmRJqbdFHIFdJ6PHT5xtEnFPSWxm4Xrp7qGR8//3vY7jawh4PRnMJbGKIRBMKFys2P49/qOu0Kr6ZMenx2GGtsPPtUBDor+ZVwpE5BBt7lrfKH77GgB8Fz096S9dZXCFCV2IeCYSZYgm1fZRnx62fGpt1fw99G3FD9f8ae1ZUUV8YjYP1ibxrMOwx/ptd3tx1cJYAaIp8u1+CSuxqkhBuWh+gZ0+UXVXxkiQ7a2gnwJh27J5qtFp5wcCr7frSDAofNjKahwwKUaz9UuYOSsY+Ic2FpSltnl3ypgaeSI/SZeyxJv9l7M/W9UsXo2O/OT6YpPNNvEBs9wD/cfPW+1vzvp4fDMTSbkfUzY3e2d7xyNo8vFXWdyCl7dYUG3JOYkClTP64LPt0FuJpXztmEPKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(44832011)(70206006)(5660300002)(70586007)(2616005)(8676002)(7696005)(82740400003)(36756003)(8936002)(16526019)(54906003)(6916009)(47076005)(186003)(86362001)(81166007)(82310400003)(426003)(6666004)(356005)(316002)(336012)(478600001)(26005)(4326008)(83380400001)(2906002)(36860700001)(1076003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:00.0631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b018cd-a0f3-4e02-36bb-08d929d4027b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
DSCCLK validation is not necessary because DSCCLK is derrived from
DISPCLK, therefore if DISPCLK validation passes, DSCCLK is valid, too.
Doing DSCLK validation in addition to DISPCLK leads to modes being
wrongly rejected when DSCCLK was incorrectly set outside of DML.

[how]
Remove DSCCLK validation because it's implicitly validated under DISPCLK

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../dc/dml/dcn30/display_mode_vba_30.c        | 64 ++++++-------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index ec56210b6180..bd657029f8c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -64,6 +64,7 @@ typedef struct {
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
 #define DCN30_MAX_DSC_IMAGE_WIDTH 5184
+#define DCN30_MAX_FMT_420_BUFFER_WIDTH 4096
 
 static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
 static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
@@ -3987,19 +3988,30 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
-				} else if (v->DSCEnabled[k] && (v->HActive[k] > DCN30_MAX_DSC_IMAGE_WIDTH)) {
-					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
-					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
 				} else {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
-					/*420 format workaround*/
-					if (v->HActive[k] > 4096 && v->OutputFormat[k] == dm_420) {
+				}
+				if (v->DSCEnabled[k] && v->HActive[k] > DCN30_MAX_DSC_IMAGE_WIDTH
+						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
+					if (v->HActive[k] / 2 > DCN30_MAX_DSC_IMAGE_WIDTH) {
+						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
+						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
+					} else {
+						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
+						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
+					}
+				}
+				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN30_MAX_FMT_420_BUFFER_WIDTH
+						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
+					if (v->HActive[k] / 2 > DCN30_MAX_FMT_420_BUFFER_WIDTH) {
+						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
+						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
+					} else {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
 					}
 				}
-
 				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
 					v->MPCCombine[i][j][k] = false;
 					v->NoOfDPP[i][j][k] = 4;
@@ -4281,42 +4293,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < v->soc.num_states; i++) {
-		v->DSCCLKRequiredMoreThanSupported[i] = false;
-		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			if (v->BlendingAndTiming[k] == k) {
-				if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
-					if (v->OutputFormat[k] == dm_420) {
-						v->DSCFormatFactor = 2;
-					} else if (v->OutputFormat[k] == dm_444) {
-						v->DSCFormatFactor = 1;
-					} else if (v->OutputFormat[k] == dm_n422) {
-						v->DSCFormatFactor = 2;
-					} else {
-						v->DSCFormatFactor = 1;
-					}
-					if (v->RequiresDSC[i][k] == true) {
-						if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
-							if (v->PixelClockBackEnd[k] / 12.0 / v->DSCFormatFactor
-									> (1.0 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * v->MaxDSCCLK[i]) {
-								v->DSCCLKRequiredMoreThanSupported[i] = true;
-							}
-						} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
-							if (v->PixelClockBackEnd[k] / 6.0 / v->DSCFormatFactor
-									> (1.0 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * v->MaxDSCCLK[i]) {
-								v->DSCCLKRequiredMoreThanSupported[i] = true;
-							}
-						} else {
-							if (v->PixelClockBackEnd[k] / 3.0 / v->DSCFormatFactor
-									> (1.0 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * v->MaxDSCCLK[i]) {
-								v->DSCCLKRequiredMoreThanSupported[i] = true;
-							}
-						}
-					}
-				}
-			}
-		}
-	}
+	/* Skip dscclk validation: as long as dispclk is supported, dscclk is also implicitly supported */
+
 	for (i = 0; i < v->soc.num_states; i++) {
 		v->NotEnoughDSCUnits[i] = false;
 		v->TotalDSCUnitsRequired = 0.0;
@@ -5319,7 +5297,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (j = 0; j < 2; j++) {
 			if (v->ScaleRatioAndTapsSupport == 1 && v->SourceFormatPixelAndScanSupport == 1 && v->ViewportSizeSupport[i][j] == 1
 					&& v->DIOSupport[i] == 1 && v->ODMCombine4To1SupportCheckOK[i] == 1
-					&& v->NotEnoughDSCUnits[i] == 0 && v->DSCCLKRequiredMoreThanSupported[i] == 0
+					&& v->NotEnoughDSCUnits[i] == 0
 					&& v->DTBCLKRequiredMoreThanSupported[i] == 0
 					&& v->ROBSupport[i][j] == 1 && v->DISPCLK_DPPCLK_Support[i][j] == 1 && v->TotalAvailablePipesSupport[i][j] == 1
 					&& EnoughWritebackUnits == 1 && WritebackModeSupport == 1
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
