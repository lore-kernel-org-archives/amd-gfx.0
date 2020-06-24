Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC13207DD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="feAbrvHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC13207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE106E7DD;
	Wed, 24 Jun 2020 06:36:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680041.outbound.protection.outlook.com [40.107.68.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DD06E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 06:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhMyMlyTQhP3KsvgvdcEMQ5n6cyUSrIEzlC3hnSfQyahiMRergzwkXyQWIYAIjQeZSIPmCyQaB1qPJijg0GAKYyWHUi8iEmMbN2xwfx1m5kUdWS6Kl9g3x1590tDwzApV5jxq8xQ91UcipFxuNGjSEvmFfG+VQuoMRiyciY9KvDg6loP20ZseCS85D7yUXXeSrXqQIQW6uQo3V5dnJSPgK2ZEDBXaqGCmrlmaG7tBd21dQZWJLuKDOavV0FsKVe4FuOWAdRosNl59TLYGfHL24TaFTUY+SoGUX4Hjj68Mecr76j0Nu4L+mms8Zv3SQQUnNR3H+hc+ptOSyLSXjZV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21o0zBZ1YZ9vH2ZsXBL9LsIF0KvAad7q1/TsCQOPEU0=;
 b=YJ3fGvV0LY9wGrcz81uY6v1Uo4DYHVvKzMQgr61nQlvywIut7YT9CC/b1XZneXlwsHx6AiNiQ/tbVJrlaHTaf/Coy2sQ1rMXJRLjITRhya60fuGPHGFeDC0K4HQ83Wpg++q+aoQAtMalufc5PbceWA2ceh4I4zqQs5zvX7Wj2V4vZZwvnkx3SUpzr4G9LXzpLru3J2yfph8b8VqIsnVoAAwYIwXrKijtANCY0ZMH3H0iZVWd+yf3i2VXl32A+Mb9UfNc3G9zqSaCuShQlFw/LqpE0XBL8vA90BcU+Mcqkf4eRORd2ZYrNjNjEQJ2swnDe75NzqGDf1bp1jtaMbIyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21o0zBZ1YZ9vH2ZsXBL9LsIF0KvAad7q1/TsCQOPEU0=;
 b=feAbrvHfEU7HFMkWKyfUOCWWu5J+Skx4DCs9vJ2+2FRFOJi3r3rOrVBV0GUjFTfA6ydYt5uFYBAqlzKGGPz2ijPd31Vt1Dlddz/2Sfn6O8je5tOkTddXHy+UL8kClRkOuXtC9nBSpdbJxNqKNtoAC6ZvxGVE3edQw/66fyB6JGo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 06:35:58 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3109.027; Wed, 24 Jun
 2020 06:35:58 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: change method to set board parameters
Date: Wed, 24 Jun 2020 14:35:33 +0800
Message-Id: <20200624063534.1953945-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 06:35:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1f920a0-5b5a-4f0c-4945-08d81808da77
X-MS-TrafficTypeDiagnostic: MWHPR12MB1599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB159981C8DE2E96171FB5B5E8EF950@MWHPR12MB1599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mW5JsRnAnG48e7NuLkOUU5cuV+G3PNXzYXjpDOfpL+T2Ry4+WwQv+QHodxqckSHsd7GNS2k8IG+t5Rp5DngDVPR3ZKnjARK2950Nywls63Ma4wMVXA7O0z+JKR+gCmmuGANgk1URjv2XAdxl+6LxpLpcXOU9vnfutbxvvOoSDm/eGf8eHSbTtKX1hbJ/D/pna0NCY7ZY3Y21zF0aFXF4sigwoaLgqX86dZ9px1W+StWH7nww6muDP7rOzIJbiU8XQM9F8Eswmlu8X01WyRZOhZhXIKOBm00zsLuqbh+/MAMH6gu/nZVMblWBOp7yntV2P6exAqsD2jKxtDIl+dtGDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(316002)(6666004)(54906003)(86362001)(36756003)(52116002)(2906002)(44832011)(2616005)(956004)(4326008)(7696005)(1076003)(186003)(16526019)(478600001)(26005)(5660300002)(6916009)(66556008)(6486002)(8676002)(83380400001)(66476007)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dglfLFw8EZKnLNPoZC1GfB5TLNyQ8oEZHTaogH+QOUulvJtPndGgN317YYa0Aagz5zpYN1kwnCWOgoBCBWXd9qvsJRnrrDmqIxf3TE8JW6XBS9ZkoXygqxYBVzJ+qfZFIT3rkj8RX0L6iBIMPJuhC4EHlEPnZTGYY4LGCCp7Sya9PDQ4HLTkc2T1vEnBRRQMN9RxTGl0Gg6AxqtW5uLx7HDtM6E1IyCJBXhfE2HBr782LfKL3foBbtlzs74PuhRbKWjXfzbC5/yH2dzUgUQbwvlJ1llQWny6zqjJQPRPLka64Op5z0Md2OUiCoc4jqyyoPwGlGn02GizgES60+FjKAL5SmFQoIprYatW17d+clofQYfX5Dz5E/ljIFvX+pK3AzjUEqYjxmJ2qpPMpJmFtdDqu+HQUp1mjAmWQptwNSWcFcy4/WYWqFB596oZutZSJONLKptxQujqjjwH1UWNuQ3RH7sLfzmMn3jURXy6Z4pVKDkJJ4lipvYDgymDJckg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f920a0-5b5a-4f0c-4945-08d81808da77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 06:35:58.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZnW8dabstdVoQhQtCkVOIEhoTkiHXK+immPil9U7QgkkyvRSg63ctFs9jOgNp+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1599
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Copy board parameters directly instead of set each parameter for
sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 89 +------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 769e031d489a..693ad8963d0a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -394,7 +394,6 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
 	int index, ret;
-	int i;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
@@ -405,92 +404,8 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 		return ret;
 
 	memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-	       sizeof(I2cControllerConfig_t) * NUM_I2C_CONTROLLERS);
-
-	/* SVI2 Board Parameters */
-	smc_pptable->VddGfxVrMapping = smc_dpm_table->VddGfxVrMapping;
-	smc_pptable->VddSocVrMapping = smc_dpm_table->VddSocVrMapping;
-	smc_pptable->VddMem0VrMapping = smc_dpm_table->VddMem0VrMapping;
-	smc_pptable->VddMem1VrMapping = smc_dpm_table->VddMem1VrMapping;
-	smc_pptable->GfxUlvPhaseSheddingMask = smc_dpm_table->GfxUlvPhaseSheddingMask;
-	smc_pptable->SocUlvPhaseSheddingMask = smc_dpm_table->SocUlvPhaseSheddingMask;
-	smc_pptable->VddciUlvPhaseSheddingMask = smc_dpm_table->VddciUlvPhaseSheddingMask;
-	smc_pptable->MvddUlvPhaseSheddingMask = smc_dpm_table->MvddUlvPhaseSheddingMask;
-
-	/* Telemetry Settings */
-	smc_pptable->GfxMaxCurrent = smc_dpm_table->GfxMaxCurrent;
-	smc_pptable->GfxOffset = smc_dpm_table->GfxOffset;
-	smc_pptable->Padding_TelemetryGfx = smc_dpm_table->Padding_TelemetryGfx;
-	smc_pptable->SocMaxCurrent = smc_dpm_table->SocMaxCurrent;
-	smc_pptable->SocOffset = smc_dpm_table->SocOffset;
-	smc_pptable->Padding_TelemetrySoc = smc_dpm_table->Padding_TelemetrySoc;
-	smc_pptable->Mem0MaxCurrent = smc_dpm_table->Mem0MaxCurrent;
-	smc_pptable->Mem0Offset = smc_dpm_table->Mem0Offset;
-	smc_pptable->Padding_TelemetryMem0 = smc_dpm_table->Padding_TelemetryMem0;
-	smc_pptable->Mem1MaxCurrent = smc_dpm_table->Mem1MaxCurrent;
-	smc_pptable->Mem1Offset = smc_dpm_table->Mem1Offset;
-	smc_pptable->Padding_TelemetryMem1 = smc_dpm_table->Padding_TelemetryMem1;
-	smc_pptable->MvddRatio = smc_dpm_table->MvddRatio;
-
-	/* GPIO Settings */
-	smc_pptable->AcDcGpio = smc_dpm_table->AcDcGpio;
-	smc_pptable->AcDcPolarity = smc_dpm_table->AcDcPolarity;
-	smc_pptable->VR0HotGpio = smc_dpm_table->VR0HotGpio;
-	smc_pptable->VR0HotPolarity = smc_dpm_table->VR0HotPolarity;
-	smc_pptable->VR1HotGpio = smc_dpm_table->VR1HotGpio;
-	smc_pptable->VR1HotPolarity = smc_dpm_table->VR1HotPolarity;
-	smc_pptable->GthrGpio = smc_dpm_table->GthrGpio;
-	smc_pptable->GthrPolarity = smc_dpm_table->GthrPolarity;
-
-	/* LED Display Settings */
-	smc_pptable->LedPin0 = smc_dpm_table->LedPin0;
-	smc_pptable->LedPin1 = smc_dpm_table->LedPin1;
-	smc_pptable->LedPin2 = smc_dpm_table->LedPin2;
-	smc_pptable->LedEnableMask = smc_dpm_table->LedEnableMask;
-	smc_pptable->LedPcie = smc_dpm_table->LedPcie;
-	smc_pptable->LedError = smc_dpm_table->LedError;
-	smc_pptable->LedSpare1[0] = smc_dpm_table->LedSpare1[0];
-	smc_pptable->LedSpare1[1] = smc_dpm_table->LedSpare1[1];
-
-	/* GFXCLK PLL Spread Spectrum */
-	smc_pptable->PllGfxclkSpreadEnabled = smc_dpm_table->PllGfxclkSpreadEnabled;
-	smc_pptable->PllGfxclkSpreadPercent = smc_dpm_table->PllGfxclkSpreadPercent;
-	smc_pptable->PllGfxclkSpreadFreq = smc_dpm_table->PllGfxclkSpreadFreq;
-
-	/* GFXCLK DFLL Spread Spectrum */
-	smc_pptable->DfllGfxclkSpreadEnabled = smc_dpm_table->DfllGfxclkSpreadEnabled;
-	smc_pptable->DfllGfxclkSpreadPercent = smc_dpm_table->DfllGfxclkSpreadPercent;
-	smc_pptable->DfllGfxclkSpreadFreq = smc_dpm_table->DfllGfxclkSpreadFreq;
-
-	/* UCLK Spread Spectrum */
-	smc_pptable->UclkSpreadEnabled = smc_dpm_table->UclkSpreadEnabled;
-	smc_pptable->UclkSpreadPercent = smc_dpm_table->UclkSpreadPercent;
-	smc_pptable->UclkSpreadFreq = smc_dpm_table->UclkSpreadFreq;
-
-	/* FCLK Spred Spectrum */
-	smc_pptable->FclkSpreadEnabled = smc_dpm_table->FclkSpreadEnabled;
-	smc_pptable->FclkSpreadPercent = smc_dpm_table->FclkSpreadPercent;
-	smc_pptable->FclkSpreadFreq = smc_dpm_table->FclkSpreadFreq;
-
-	/* Memory Config */
-	smc_pptable->MemoryChannelEnabled = smc_dpm_table->MemoryChannelEnabled;
-	smc_pptable->DramBitWidth = smc_dpm_table->DramBitWidth;
-	smc_pptable->PaddingMem1[0] = smc_dpm_table->PaddingMem1[0];
-	smc_pptable->PaddingMem1[1] = smc_dpm_table->PaddingMem1[1];
-	smc_pptable->PaddingMem1[2] = smc_dpm_table->PaddingMem1[2];
-
-	/* Total board power */
-	smc_pptable->TotalBoardPower = smc_dpm_table->TotalBoardPower;
-	smc_pptable->BoardPowerPadding = smc_dpm_table->BoardPowerPadding;
-
-	/* XGMI Training */
-	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++) {
-		smc_pptable->XgmiLinkSpeed[i] = smc_dpm_table->XgmiLinkSpeed[i];
-		smc_pptable->XgmiLinkWidth[i] = smc_dpm_table->XgmiLinkWidth[i];
-		smc_pptable->XgmiFclkFreq[i] = smc_dpm_table->XgmiFclkFreq[i];
-		smc_pptable->XgmiSocVoltage[i] = smc_dpm_table->XgmiSocVoltage[i];
-	}
-
+	       sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+	
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
