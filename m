Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EAC388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0D620708
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v7sOKXZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0D620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350FB6EB4A;
	Tue, 27 Oct 2020 09:42:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A826EB49
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9JP7HKIguR9Ftl3LCzlmoLdYVe8UziH0dpjmq6VMBvb47NBTtOVfzirxzP8U/R9pITqmefePVcCEU9vnGijGn8nOV2iht9S5NeoLidlmkDXDHh3NHcUBuC+xskWAi2pIJoQn/4EaFXP2ZJm9Lbh8OVsZ/912bF3fk8MW5Ugm5F5QMNzcP51tOWCV7WSXkmNrCJ7PgXHtTz1z+4HZ/sWUZ8t0T24W1sEiUXJCYyvPziLBMdQ+whrjgr5yZiAczA5rn0y5PDDZcewav/LUvYN2ie+SUK+hX993e5M0OSd5M9jy0G2Jnj/Dp401w4d4G9r+pwK/TR2DoyV3L2XAS740Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyf6RlGBFXOpcH9LVo/7wlS0JL7VSCdXcTNPPpr5V98=;
 b=HcasGMd0Ium5ixNr25aip3tHMumTzSPVGSBw18RUrtqXf1ct3+7TS+yFXH1QP9VdlsYe88kZxOhX+lcY0OAg46/P3rZXvZ4z5O9JtK7Iutmk0bx+bwWRb4/FXiV1LWFmHrX7mioRjj1+YxjPewGzlY07hXsa0bpVQSVyoLQZ3Vw08P6R/g7Qxnevw1Qxu1qGer1HbElCRmkbbNu5/p8hWodBotovgWAs8Bby6n5ITnz+dd6d1OgP9FuVPPNLVpes5j+trvUSJ9mtWS0HcAYLZ+Apm6D2NZqp5IC9xUkdF82z5a+aTms1nfEQSrltRstATBEqDht5NyOmHcVAI1xR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyf6RlGBFXOpcH9LVo/7wlS0JL7VSCdXcTNPPpr5V98=;
 b=v7sOKXZQXTmaatqTVCS+qTHDcRth84p9CMZe7Mz516AK5nq+IoWgKulqX35W6dU0npwILk6u2SZA7lQqEi+jGlZEvZHtVoCOq0ENpiNkUomIHNOFPj9GH27Oc7QyM96gj9IMbUaI6TjU76GUKGweyGK6rnEQ4owGIEceXP6RYTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:28 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:28 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 09/10] drm/amd/pm: add some swSMU functions for vangogh.
Date: Tue, 27 Oct 2020 17:41:32 +0800
Message-Id: <20201027094133.21881-9-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d68a6949-af57-4a8d-fe08-08d87a5c9d6b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18450C731FB65A4C9D8F36F8F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFKNz0do6gZcaRwmrV1k5lXO8asxCR6x5PgFq+89o29Dk07B8Cs5fJWn7zAKtK4RLl5gJnJX3rmLWelOJThhs2NbSGBqpmTTb0aZG/LZuKXoq4vNIKyFgRt2LiWImjiM9p1VQBCPkcTNc3MzisYrXOAV35TtIF74KqefDKiZY0c/IlEuomkDHLkTdzD9wOVvVG8lsaOMqrOOkQUND9+sQclLU4gpyMhrmdOz4hxReBDnBikGkTu2ejmBt7g/G0AO5ySUrGmmenj7RZ8dUwCSE7SKCxmFbAwHLn5EqNTcHp3KeqWyXllVncmbtonJk+//
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(30864003)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4rzs7n1h2OQIXOj0J0hhvlwkJlumfiUAljzwPyQSTj685CQA39zZ/5eq/nJ8LLMpW5aml7p8W3HxtXoHqJH+76R89R5FzcuDblnLDMxRV1pYSqWJeu6UdASiTm80xWNP8DW1mz/wH2fp558B/jLJ3/ndSB5L6KaZYCTRnkTuRiKlcwg9tU1/5+HKn+gsOLHJTMCEzPU1mgY49S9CxMVxbaIuslBONGeCQreZWNReCJArXWqj1calGgQ5XklCUOCTgizBdUPV7Ac37XgCfhIRyOY6cva9kGrIulqOZM/G3pOuSk9labmbvzVKzMlUsgHaifvHxwjwqVM5fMBY1z9IcF4qsBVIY9D04w9jmmhs3Vyw66ts7zBE2DBGCplPU+oi+upjjXBXoR/Ttlf9CAlzCAbGXQx1HqPIXX+Umf/qlNrA/HAtzRfOY5YKUrG8mldTZVCRP+m5PWReWaIKoDZvhs2YBFEHSn5Mx8rH4nec2nKOA+ns9SzfzNg105Sv07jMqNZQvjlzdN/mjktV3fWOaHxUOFRZ/qY9GP7wyerGnKmzC+jqcye4KTUI32tVD2Z0TnHny/WDEb/2qdg7ypY1AtewQkTTKRXMug/ZIbM2vzHMMPUfWMr21HuZdBH9om4/BcqtYpM+kFmcM05pkL3nsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a6949-af57-4a8d-fe08-08d87a5c9d6b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:28.4068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGVRymNlh4gaAtPu1uB4MOxBDbSBtrp0LuaQn8nmSY87wiYEftj6CL6VkthvA3dC0dfa+3NTzuA63spommLBBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add some swSMU functions for vangogh, to support the
sensor info on "hwmon" and pm info.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 411 ++++++++++++++----
 1 file changed, 338 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 145712a24b80..83a1b0a04eb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -52,53 +52,72 @@
 	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
 	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
 	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_ISP_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_A55_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_CVIP_DSP_DPM_BIT))
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
 
 static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
-	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
-	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
-	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_EnableGfxOff,			1),
-	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisableGfxOff,		1),
-	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,		1),
-	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		1),
-	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
-	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
-	MSG_MAP(Spare,                          PPSMC_MSG_spare,			1),
-	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
-	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,	1),
-	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
-	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,	1),
-	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,	1),
-	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
-	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
-	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
-	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
-	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
-	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,			1),
-	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	1),
-	MSG_MAP(SetMinVideoFclkFreq,            PPSMC_MSG_SetMinVideoFclkFreq,		1),
-	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		1),
-	MSG_MAP(EnablePostCode,                 PPSMC_MSG_EnablePostCode,		1),
-	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,		1),
-	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,		1),
-	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,		1),
-	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		1),
-	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
-	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
-	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,		1),
-	MSG_MAP(GpuChangeState,                 PPSMC_MSG_GpuChangeState,		1),
-	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	1),
-	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,		1),
-	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,			1),
-	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		1),
-	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
-	MSG_MAP(PowerUpCvip,                    PPSMC_MSG_PowerUpCvip,			1),
-	MSG_MAP(PowerDownCvip,                  PPSMC_MSG_PowerDownCvip,		1),
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,	0),
+	MSG_MAP(EnableGfxOff,                   PPSMC_MSG_EnableGfxOff,			0),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisableGfxOff,		0),
+	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,	0),
+	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		0),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			0),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			0),
+	MSG_MAP(Spare,                          PPSMC_MSG_spare,				0),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
+	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
+	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
+	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,	0),
+	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,	0),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	0),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		0),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	0),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	0),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		0),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	0),
+	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,					0),
+	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	0),
+	MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,		0),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		0),
+	MSG_MAP(EnablePostCode,                 PPSMC_MSG_EnablePostCode,		0),
+	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,	0),
+	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,		0),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,		0),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		0),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	0),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		0),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,			0),
+	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,					0),
+	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	0),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,			0),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,				0),
+	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		0),
+	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	0),
+	MSG_MAP(PowerUpCvip,                    PPSMC_MSG_PowerUpCvip,				0),
+	MSG_MAP(PowerDownCvip,                  PPSMC_MSG_PowerDownCvip,			0),
+	MSG_MAP(GetPptLimit,                        PPSMC_MSG_GetPptLimit,			0),
+	MSG_MAP(GetThermalLimit,                    PPSMC_MSG_GetThermalLimit,		0),
+	MSG_MAP(GetCurrentTemperature,              PPSMC_MSG_GetCurrentTemperature, 0),
+	MSG_MAP(GetCurrentPower,                    PPSMC_MSG_GetCurrentPower,		 0),
+	MSG_MAP(GetCurrentVoltage,                  PPSMC_MSG_GetCurrentVoltage,	 0),
+	MSG_MAP(GetCurrentCurrent,                  PPSMC_MSG_GetCurrentCurrent,	 0),
+	MSG_MAP(GetAverageCpuActivity,              PPSMC_MSG_GetAverageCpuActivity, 0),
+	MSG_MAP(GetAverageGfxActivity,              PPSMC_MSG_GetAverageGfxActivity, 0),
+	MSG_MAP(GetAveragePower,                    PPSMC_MSG_GetAveragePower,		 0),
+	MSG_MAP(GetAverageTemperature,              PPSMC_MSG_GetAverageTemperature, 0),
+	MSG_MAP(SetAveragePowerTimeConstant,        PPSMC_MSG_SetAveragePowerTimeConstant,			0),
+	MSG_MAP(SetAverageActivityTimeConstant,     PPSMC_MSG_SetAverageActivityTimeConstant,		0),
+	MSG_MAP(SetAverageTemperatureTimeConstant,  PPSMC_MSG_SetAverageTemperatureTimeConstant,	0),
+	MSG_MAP(SetMitigationEndHysteresis,         PPSMC_MSG_SetMitigationEndHysteresis,			0),
+	MSG_MAP(GetCurrentFreq,                     PPSMC_MSG_GetCurrentFreq,						0),
+	MSG_MAP(SetReducedPptLimit,                 PPSMC_MSG_SetReducedPptLimit,					0),
+	MSG_MAP(SetReducedThermalLimit,             PPSMC_MSG_SetReducedThermalLimit,				0),
+	MSG_MAP(DramLogSetDramAddr,                 PPSMC_MSG_DramLogSetDramAddr,					0),
+	MSG_MAP(StartDramLogging,                   PPSMC_MSG_StartDramLogging,						0),
+	MSG_MAP(StopDramLogging,                    PPSMC_MSG_StopDramLogging,						0),
+	MSG_MAP(SetSoftMinCclk,                     PPSMC_MSG_SetSoftMinCclk,						0),
+	MSG_MAP(SetSoftMaxCclk,                     PPSMC_MSG_SetSoftMaxCclk,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -116,13 +135,9 @@ static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
 	FEA_MAP(FAN_CONTROLLER),
 	FEA_MAP(ULV),
 	FEA_MAP(VCN_DPM),
-	FEA_MAP(FCLK_DPM),
-	FEA_MAP(SOCCLK_DPM),
-	FEA_MAP(MP0CLK_DPM),
 	FEA_MAP(LCLK_DPM),
 	FEA_MAP(SHUBCLK_DPM),
 	FEA_MAP(DCFCLK_DPM),
-	FEA_MAP(GFX_DPM),
 	FEA_MAP(DS_DCFCLK),
 	FEA_MAP(S0I2),
 	FEA_MAP(SMU_LOW_POWER),
@@ -195,6 +210,65 @@ static int vangogh_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static int vangogh_get_smu_metrics_data(struct smu_context *smu,
+				       MetricsMember_t member,
+				       uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->GfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->SocclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->MemclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->GfxActivity / 100;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->UvdActivity;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = metrics->CurrentSocketPower;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->GfxTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->SocTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
 static int vangogh_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -230,13 +304,13 @@ static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
 		}
 	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
 			if (ret)
 				return ret;
@@ -251,13 +325,13 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
@@ -267,13 +341,6 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-static int vangogh_set_default_dpm_table(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
-}
-
 static int vangogh_get_allowed_feature_mask(struct smu_context *smu,
 					    uint32_t *feature_mask,
 					    uint32_t num)
@@ -308,23 +375,217 @@ static int vangogh_get_allowed_feature_mask(struct smu_context *smu,
 
 static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	uint32_t feature_mask[2];
+	uint64_t feature_enabled;
+
+	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
 
-	/*
-	 * Until now, the pmfw hasn't exported the interface of SMU
-	 * feature mask to APU SKU so just force on all the feature
-	 * at early initial stage.
-	 */
-	if (adev->in_suspend)
+	if (ret)
 		return false;
-	else
-		return true;
 
+	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+				((uint64_t)feature_mask[1] << 32));
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
+
+static int vangogh_get_current_activity_percent(struct smu_context *smu,
+					       enum amd_pp_sensors sensor,
+					       uint32_t *value)
+{
+	int ret = 0;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = vangogh_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_GFXACTIVITY,
+						  value);
+		break;
+	default:
+		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vangogh_get_gpu_power(struct smu_context *smu, uint32_t *value)
+{
+	if (!value)
+		return -EINVAL;
+
+	return vangogh_get_smu_metrics_data(smu,
+					   METRICS_AVERAGE_SOCKETPOWER,
+					   value);
+}
+
+static int vangogh_thermal_get_temperature(struct smu_context *smu,
+					     enum amd_pp_sensors sensor,
+					     uint32_t *value)
+{
+	int ret = 0;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = vangogh_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_HOTSPOT,
+						  value);
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = vangogh_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_EDGE,
+						  value);
+		break;
+	default:
+		dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int vangogh_get_current_clk_freq_by_table(struct smu_context *smu,
+				       enum smu_clk_type clk_type,
+				       uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+		member_type = METRICS_AVERAGE_GFXCLK;
+		break;
+	case SMU_MCLK:
+	case SMU_UCLK:
+		member_type = METRICS_AVERAGE_UCLK;
+		break;
+	case SMU_SOCCLK:
+		member_type = METRICS_AVERAGE_SOCCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return vangogh_get_smu_metrics_data(smu,
+					   member_type,
+					   value);
+}
+
+static int vangogh_read_sensor(struct smu_context *smu,
+				 enum amd_pp_sensors sensor,
+				 void *data, uint32_t *size)
+{
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	mutex_lock(&smu->sensor_lock);
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = vangogh_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		ret = vangogh_get_gpu_power(smu, (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = vangogh_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = vangogh_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = vangogh_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+	mutex_unlock(&smu->sensor_lock);
+
+	return ret;
+}
+
+static int vangogh_set_watermarks_table(struct smu_context *smu,
+				       struct pp_smu_wm_range_sets *clock_ranges)
+{
+	int i;
+	int ret = 0;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
+
+	if (!table || !clock_ranges)
+		return -EINVAL;
+
+	if (clock_ranges) {
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		    clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
+			return -EINVAL;
+
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+			table->WatermarkRow[WM_DCFCLK][i].MinClock =
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
+		}
+
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
+		}
+
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+	}
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_cmn_write_watermarks_table(smu);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
 }
 
 static const struct pptable_funcs vangogh_ppt_funcs = {
-	.dpm_set_vcn_enable = vangogh_dpm_set_vcn_enable,
-	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
+
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.init_smc_tables = vangogh_init_smc_tables,
@@ -336,10 +597,14 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
-	.set_default_dpm_table = vangogh_set_default_dpm_table,
+	.dpm_set_vcn_enable = vangogh_dpm_set_vcn_enable,
+	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
 	.is_dpm_running = vangogh_is_dpm_running,
+	.read_sensor = vangogh_read_sensor,
+	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.set_watermarks_table = vangogh_set_watermarks_table,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.interrupt_work = smu_v11_0_interrupt_work,
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
