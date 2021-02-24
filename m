Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF63C4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D684E64ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D684E64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0604B6EB6D;
	Wed, 24 Feb 2021 22:21:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9CC6EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niCuffXAM1cPuu733XGcOlDIisqWyws35gqBTPreu/JncBP2tUmZ+XpIfbQ+SoxDXWYmUHizvdArYR4zVobFRVOAgtbMWROf60XSsTUuJpll/femhGhDQR5TuDP8XSB2M69k425dtPuHmTFdHw0H3+vKtvoEJxIJpB3H0Q/1Db5tcZeD9xXmd5i762QA40uyE/zqmvNY5rcOy/VaM/I3uD1agYCdB8AEA4OwRybypOPg0kIu/qF1i7BvCvBAHQn7ai/JmhMlTgZX4IXBijojUp6NswKAzmoKuMNZ1xyEmDp4sAa5aHd1AdKckbM2S3NclQHiHapvEiUXEuCCzleWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv+2U47kOoOJZ+cZFH6CZDfB4i5xheUvVHNuwvwVxnE=;
 b=BMFePQZPZEoFIz9ACCzg+vIIJYYaf4U39u73KRVUuqjYtpgc465YHAMvEk7yg1rD+co3P7NWh22SkeIkLMHUfDfoThrJ5zaEc1q+vi7KUoRshRcr2Yo2QAddK82gFgDsjq1F07EFQ/z1ecklwk/0POL8U2NPBTdBO03kTh1CKUAR9PjPMRuJYYrARvhcmmNc48OCF/bWw0y4HjS9uCgopdPLgzNtEIwTCdxI/0iZL29DkCe8mCZ9TgB3ILqfjMyjTYV6jHdciry2H1wJH6s2liL48yjfqdDfML4y3q5mp3GF7GO4rAx2f9aM6vJiQ5WQM7ah/IG3JLv/Y7fQsRu93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv+2U47kOoOJZ+cZFH6CZDfB4i5xheUvVHNuwvwVxnE=;
 b=bWFcQcSMR7Jy/3+zAMs0t3czw8KsNBLJ86daTudvZxpiRqamYrmtHRT2dDeAiQoJwZB7fxSjNEDfFG+lCGNbTPteVCWLR9W3s6R0bPuH/kcBcPB+5oa+1YLKKD4MVVOxCnxBNOm1czZCjlzVN9Dy15d67L+CP7WebnkJ9uf0Zr0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 090/159] drm/amd/pm: Add atom_smc_dpm_info_v4_10 for aldebaran
Date: Wed, 24 Feb 2021 17:17:50 -0500
Message-Id: <20210224221859.3068810-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b742cf27-2aec-4053-98ab-08d8d91260d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046140D2E2C9F17BC01D8AFF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJqJbLcJk3iNn6OAtFFa1bieqMobQcEBtu6F80KyfpHu1S8XBLPaS7qk6Yl6hNIRuMK/bclh9ABvoTiTdoqcHWpMEjBS9VqcC9O5SeSdR7bf7PxKAsGnDVIXu5Gyqv7w+hC01jHVMxKMOLxj6rweoXZhGfz62L/4WNmhlq2pj0KKhj5AO3aBRSOBHmvXKoOmf1KP5rHgT1Tms+f5o/rl57uvID5+RWNUFFWJM+W/phf59VBHD8IDWDr2zanc3WkJmt6cx4cJP8Ytvd7+v8ssJ2bQBXzgfnX2zv19NAzCqhHc22l2fyGqPxKb3BYJNx83k7BZLfL+PwXyv4h1/4Vc9p9mtOkU8ubFnpU1sDLX2brnUt0M8h2FZEEaRFD6XmsBZXe793oaUQH6m9Y2E/EMd8LcY1//onSWP5laWYtSzqY9wfDV8IqECxcV4FEg8JtTCOQ8FaGvt8c+489D8277XDNnpUglYiw10Gtkr9z0aUR5XKl/JJRAQb2LOqNLq7u0HmmojQufdOqFUkbTJwyJx7GE4HmtNU3LPhVpPgfV3W6UHu3mSLAhPW7zVh8dgTbzzSavYb4QuiE8vdpVht1Fmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SkLWa1J06Y2INo9NzjjkA8vTg6hficsRFhV3t4HYPvFIuYGm/rZH406/v53m?=
 =?us-ascii?Q?nLQWl5PSFpT+ZjbvwMX5P2+KL597EjJu+MMzyEqZftomPyg5dmx4dqZD+lqV?=
 =?us-ascii?Q?1i3LqlUCaZUkszCNYXJ2G6ujefgkgVzysd8q/V31fb/6HfiHAL76NTwiKIZf?=
 =?us-ascii?Q?Td41hxu2AUQF58waGNXK0R6a+sTB+zerM6g53L6oklEi0f7J2EgSILs2F/OZ?=
 =?us-ascii?Q?AT51yYl/Mz+uglC8TfZ790Rt2y0pyGUO8EUkiHqqNOPpCwMe47oEWtiYHpEj?=
 =?us-ascii?Q?DfS1lQRGnprhshUL2XAp9XdKplXCUwVzeaBG4X14j/sERvE1uF/7pN2mIKlZ?=
 =?us-ascii?Q?VPaqZRFdNx1xzxSQe1XQwRM8RTea+NqYZAgyHCTLQIcEMCWcibOU2KjfkEZ8?=
 =?us-ascii?Q?LCTGCS7Kad9KqPnLEoB9lrbmP31W4H4mDOVIuOdlJG/mA9cVh4Gwk39x0eMA?=
 =?us-ascii?Q?XbWmGbIxwlJ+sO037nJ/rI/+7PnDEmUWq4LQC2ruCV/zGiX+vUMI4xu/sEGJ?=
 =?us-ascii?Q?OqrBrgRfqtSd6UtIPM3ey5Mh1gXuv9MSIY5o/tw7e+9jHDR+yIm9++jYOBM/?=
 =?us-ascii?Q?3JoztyuSebmMDU8+LhdrOjq/2UwqwEqGwFP4BQNhySjfMaZkrZJMnpRl2SFO?=
 =?us-ascii?Q?0iabxF/mybLi1sSIL+Uglsl1Dq9fdg3WGNTOS7YNywHgtCTTFj8HE1wUlCFU?=
 =?us-ascii?Q?IzC5jpbqeAn4762w/LIaHGOYqbFX/VX2Z/x7B05HM+cfGkWgBRLuqyslbQUB?=
 =?us-ascii?Q?zsoCBUMjcG05gnk14Gy43ZDErY6r3Qf0uXAA47uoMiZsFy4bAhKM56P0hIr4?=
 =?us-ascii?Q?FSWqff8PDQnnVTSgGhivvXCDUWnld7SqhuQaxwa5LTn7oJwj0gwKaPfBVuAv?=
 =?us-ascii?Q?WCSF3X0jEAabO42Ao9nw2CFNM9Ur5rVmNDu5/muuvLSxLpTS10iDPW0YFPZW?=
 =?us-ascii?Q?p5BggibH+LqnCd4WukUJlIN8+KYAdLLABuaqOtRGqPMo83qR+U8Tx5RvXER1?=
 =?us-ascii?Q?b14FLuDcFDIYiQxsxKkS9/tapOFme7GPUQdBrJLYLVPNE8YKPGwFyyF+mRB7?=
 =?us-ascii?Q?1n6CMKejeWBK2YE+fAEL4VwfbcXQ3bmLGgkJQThrC/Clg7bwA11v7HM6u9G6?=
 =?us-ascii?Q?H3carkwyRrs/T/YC8lV3Ue79EkXMKFltV+DuyVpsFxvd3+v12jlxeGdGdbAe?=
 =?us-ascii?Q?GwOqxkpNiEqIpikL7mqSBerHbJ/EgDD8+s6usF3MgzvJZ7EHcayG9ZU2p723?=
 =?us-ascii?Q?1++xcKIlpFn1pGszckFLeHhfc8fZAr4umgoxrvDekw+8SusFxOK4P3cHi7gk?=
 =?us-ascii?Q?4nmW+b/iJNXYhM/4XeESkN8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b742cf27-2aec-4053-98ab-08d8d91260d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:23.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILQIPPz5Yfx9piyHAcSn3U3RgpAqyUKKHTZDcmpbhAzjoixGtwv6kBcvuWRDwwTZjHqs/khQNJLnaKYeF/LDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add atom_smc_dpm_info_v4_10 that defines board parameters for aldebaran

Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Kenneth Feng <Kenneth.Feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h    | 53 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 22 ++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 1c0034df59f8..dd34f16b17fd 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2335,6 +2335,59 @@ struct atom_smc_dpm_info_v4_9
 
 };
 
+struct atom_smc_dpm_info_v4_10
+{
+  struct   atom_common_table_header  table_header;
+
+  // SECTION: BOARD PARAMETERS
+  // Telemetry Settings
+  uint16_t GfxMaxCurrent; // in Amps
+  uint8_t   GfxOffset;     // in Amps
+  uint8_t  Padding_TelemetryGfx;
+
+  uint16_t SocMaxCurrent; // in Amps
+  uint8_t   SocOffset;     // in Amps
+  uint8_t  Padding_TelemetrySoc;
+
+  uint16_t MemMaxCurrent; // in Amps
+  uint8_t   MemOffset;     // in Amps
+  uint8_t  Padding_TelemetryMem;
+
+  uint16_t BoardMaxCurrent; // in Amps
+  uint8_t   BoardOffset;     // in Amps
+  uint8_t  Padding_TelemetryBoardInput;
+
+  // Platform input telemetry voltage coefficient
+  uint32_t BoardVoltageCoeffA; // decode by /1000
+  uint32_t BoardVoltageCoeffB; // decode by /1000
+
+  // GPIO Settings
+  uint8_t  VR0HotGpio;     // GPIO pin configured for VR0 HOT event
+  uint8_t  VR0HotPolarity; // GPIO polarity for VR0 HOT event
+  uint8_t  VR1HotGpio;     // GPIO pin configured for VR1 HOT event
+  uint8_t  VR1HotPolarity; // GPIO polarity for VR1 HOT event
+
+  // UCLK Spread Spectrum
+  uint8_t  UclkSpreadEnabled; // on or off
+  uint8_t  UclkSpreadPercent; // Q4.4
+  uint16_t UclkSpreadFreq;    // kHz
+
+  // FCLK Spread Spectrum
+  uint8_t  FclkSpreadEnabled; // on or off
+  uint8_t  FclkSpreadPercent; // Q4.4
+  uint16_t FclkSpreadFreq;    // kHz
+
+  // I2C Controller Structure
+  struct smudpm_i2c_controller_config_v3  I2cControllers[8];
+
+  // GPIO pins for I2C communications with 2nd controller for Input Telemetry Sequence
+  uint8_t  GpioI2cScl; // Serial Clock
+  uint8_t  GpioI2cSda; // Serial Data
+  uint16_t spare5;
+
+  uint32_t reserved[16];
+};
+
 /* 
   ***************************************************************************
     Data Table asic_profiling_info  structure
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 079b5dd719ab..2f3c87bf535b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -377,6 +377,28 @@ static int aldebaran_store_powerplay_table(struct smu_context *smu)
 
 static int aldebaran_append_powerplay_table(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+	struct atom_smc_dpm_info_v4_10 *smc_dpm_table;
+	int index, ret;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					   smc_dpm_info);
+
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
+				      (uint8_t **)&smc_dpm_table);
+	if (ret)
+		return ret;
+
+	dev_info(smu->adev->dev, "smc_dpm_info table revision(format.content): %d.%d\n",
+			smc_dpm_table->table_header.format_revision,
+			smc_dpm_table->table_header.content_revision);
+
+	if ((smc_dpm_table->table_header.format_revision == 4) &&
+	    (smc_dpm_table->table_header.content_revision == 10))
+		memcpy(&smc_pptable->GfxMaxCurrent,
+		       &smc_dpm_table->GfxMaxCurrent,
+		       sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_10, GfxMaxCurrent));
 	return 0;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
