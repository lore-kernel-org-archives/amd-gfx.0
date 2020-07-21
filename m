Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EAC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD8120684
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UV2AAjVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD8120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4771F6E527;
	Tue, 21 Jul 2020 08:43:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D886E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 08:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6xvkz1ZhULMbajwDXFgFrlx39rPB+8tFkfG9j+gPIcTb+wSoxFgdC1wq7Y31WGNAhR3bjdgzDG1uA7FrCdKkK6rkFNZ7nwhBpUPvIOoeE7tmZU/Jii9kob96aCdQ15UnGUcXo6VghDYk0TA9b8oTm3WIEg2dMlGscYkRYefCHIFTaEqkCXnXuutyTpLZv1S3kjJ+3/CqlXIBZYQr8EnqIa6XaQGEEpu5EgmRSkllQtY5OMW1rvcKEdURyW1QCEwjHoKtTYUR5D2Cyv4D4kFmLwaKTtnRTv0WPUDg95NTKPXu+bKoSQdPTcM/cwv3nX3rPnQm5uhxdCZxsJeh8cEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGRMsWf32LtVmi4kdpS5P4x75XRrr2A71x8VIdwYSg4=;
 b=biFD5wUozbgF0JpFHTUmukM1WT4U+b9ARdtuTNEYMd2/q226nGXqmNe1XyiZcUEAY3N9HY9OxLI/wf12C6gSjIxRsvaxn+w+uBOYzkkeyrVPKbYqdR0e3IrkyomKQwgHuRlqfWg/SpryNBXtyn4deIV4ToEmfRsFG98xCrPePmT2hMs/jkDEzyyEfc8AX4nP0LehFMlXQlzIqO5f2w7SuH7Y2cnS14iqRmPekwdDBLSUoQGAms2phYOg9dsKwXJDsl9SHm5YL/ba7mHlXkPQJdp4qbSGzpGpw2kdGMQCNOKWXzeFIrexMrZQpMGAkKpeLtQqIM2WKwD369f7538jOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGRMsWf32LtVmi4kdpS5P4x75XRrr2A71x8VIdwYSg4=;
 b=UV2AAjVxZLENF40+ARQOoimnB8pcEX3g0I9dVvgiX+oNDxWwgozhYbbQaN0oYiO7EzmtOVtL2ktyIcQgyEkqxfbz1SbaibQ7ms1AYtiJebQ6r5KkHyVn1C6jCJrzSwGFN4gQhma2sqyPjsKJeIORSbzHDfnNmyNYDzoPq2b+b0M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 08:43:05 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 08:43:04 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct smu message for vf mode
Date: Tue, 21 Jul 2020 16:42:45 +0800
Message-Id: <20200721084245.1256165-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR04CA0048.apcprd04.prod.outlook.com (2603:1096:202:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 08:43:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b6e5361-bd31-47f7-fdd8-08d82d52157b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571240A4C71DF90C0CF5DE9EF780@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFEGuZyxPKod1UwiVrCZ0V9Jh0gZ2BOuOdtFPvxRKvAZHTcw8FfXZ+XNdysKe5wvuePrnX8iMkFcZi6C59Mw7lprGgLZxE05WWfuNzRiPofn/PApA21U0W5iPSVEoh+vDZeS0uZr/3Tm3A5AnbdjNqbiuVK4FSoUP4+7zajyyn1bz45E2QQEcJhYBIu760f/IJMYff3qWmt6gvgsxA7YPa1NtDd95khXisoM9L7GkvWjGs9VTE74n2qJdMkEt3GC0hz4Lg40MYdMw3ZzII/E0Y/CbfvqiRrvMA7oZ/B3E840VTZxk1pPsnDAujT4lkcATvxNeerpGP/hQl8FrdYxJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(2616005)(956004)(1076003)(8676002)(5660300002)(186003)(36756003)(16526019)(478600001)(6666004)(6916009)(316002)(66946007)(86362001)(6486002)(2906002)(66556008)(66476007)(4326008)(83380400001)(8936002)(26005)(44832011)(52116002)(7696005)(54906003)(15650500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zfqeh9OBYOMYgn12xqWRMWoeajClmpisKH/Fmn/w8uYzDbRBL/fQdD/7hsndGySke9kXYQXX13rLLyEMNl2d6+0TtIyd03gMqot8vk6uiVUM4tHN0YQH/X/IZ52aX6P6fOSAitdREOOuGZRialkNMzKl1UqFjV5qljq7BqXIGdacp134lyt2CNq+6GKyl4El006hNF2W/X6v3eNJ59UbxxZUpEKK8+xJ6zyW4LTjzjs4pxJ6TTfqHBjDWmws49KPNZ4pfxmBs6f+xxMI/7Slp9ehutuKHhWPaplKHamdLuWNmwQpr8Xb3iOiwoBbbLHRgIIgH2BiWhr/kyoFzOhrjtZF291a6N1uXlKxutDoUapKCeDEfexqZKhnplCimaypeEdLzy5uDb5aIU/6zrc8TyRdP+l9hS3JoxlpqZ98Gq+9ag95bxBGvo8fFW976fSpxh/JbmSREkxXhbhs41MIKtRMNjCl/Q04Y+Gly8pXAnKKa8/XDb5aqnu90FPr58ji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6e5361-bd31-47f7-fdd8-08d82d52157b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 08:43:04.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4wlc/9+YYxAIunvrESv7p3o4Rd/4buyrWxPxFRmOBTFpHGoFM7YDl7ady9RI225
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Set valid_in_vf to false for the message not support in vf mode on
sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ib07fe7522eea39a14131945bb76be0b0935598ae
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 70 +++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index bf3d6bbba930..d4156804bf41 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -71,10 +71,10 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
 	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion,          1),
-	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,   1),
-	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,  1),
-	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,        1),
-	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,       1),
+	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,   0),
+	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,  0),
+	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,        0),
+	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,       0),
 	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,        1),
 	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,       1),
 	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,       1),
@@ -82,43 +82,43 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
-	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 1),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
-	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        1),
-	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         1),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       1),
-	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       1),
-	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           1),
-	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   1),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
+	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       0),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        0),
+	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        0),
+	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
+	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
+	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
+	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
-	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            1),
+	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
 	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
 	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex,           1),
-	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,               1),
-	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,       1),
-	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,        1),
-	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      1),
-	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       1),
-	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           1),
-	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,           1),
-	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,                 1),
+	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,               0),
+	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,       0),
+	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,        0),
+	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,           0),
+	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,                 0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
-	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 1),
-	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              1),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
+	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
+	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
-	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    1),
-	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  1),
-	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                1),
-	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 1),
-	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
-	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
-	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
-	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       1),
+	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
+	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
+	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
+	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
+	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
+	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              0),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
+	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
