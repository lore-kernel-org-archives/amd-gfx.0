Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1D8C4741F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C384C206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ycPh235e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C384C206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEAB6EB51;
	Fri,  6 Nov 2020 23:19:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCB16EB51
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhhLykVPOwTIDY5arLumy7etRRsWXCK1LQ1bVNxD1bKiSETKG7idIkIiQji89CWTdZdi3ptvCLyZ4tseEL8KNkX63krNrokbT4bBDO0Ygk0Jom5/Y09he0z5Ne/jycnprGHgooIEsbGhZI5DE+TUdalkYOgVunnhohoYNkLP5T1m78GRj2xPlYJ2m56v4SW+rFVAW6Xf63Ru2Tc8phLd79MpvBT/Qul4OHfo1j3xOfViNU+YYd0llYQYoAjGOrXuiWTTDdlyjPDkyeBz9hXmPqujspOq+kbzM8X97t6tLccjInTlVEqVE0Nyobr9kea/nkFHy/PMS1jSN2PSTpd4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yXLU0127Quucl3rEx2VFPon/5fCfJooWfrjZF53MLM=;
 b=Y4L3yQVPxQCL085vBJ//uArZ0QrwH2sVR868K6b0TLuO1h8J8laU4y2pWfPKVu+hr1aaAs2Ie+TrT2f8A0ahz70WBPZhz8XHU09skZ8DVnYgvSQzN0Fa9PPKl+CFXaTNNeIq/jSs1OQRLxOzlAbP9XZI2UQng3N0rOU3juMLcoG/10jvLGQ3haf9mlk6cfNRRLGINmsWF4fzWMNKEaFnW42coXJud1J+QUEPv8FARlfipoonnPTB65k2d70vgiy6rZWfHWXTzxLOpgf1Jxm8SpZIWywi+X2DoMJhaY+uVpuWMR0AizfMWZY9+M96yGXAm/9QCQyvu2FKV46pdDbWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yXLU0127Quucl3rEx2VFPon/5fCfJooWfrjZF53MLM=;
 b=ycPh235eab42sX6I636In0AUgnLZx+scrLqUCdsXNzXJopI0HcnTIFWjMv0hSF/xoVoEGhoGei8NTvicdBzS8Awl2UALsKSuY8jKNAJsU6Zen5UUmygkuVqTipwhYeJPaP8TMn13MOvgfKqPri3nolAkLw/KyUJVj636di0w3mo=
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by DM6PR12MB3339.namprd12.prod.outlook.com (2603:10b6:5:119::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 23:19:22 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::7) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:21 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:20 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:19 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Move common speakersToChannels
 definition to hw_shared.h
Date: Fri, 6 Nov 2020 18:17:01 -0500
Message-ID: <20201106231710.1290392-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b415f4-eb2d-4303-6abe-08d882aa648e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3339:
X-Microsoft-Antispam-PRVS: <DM6PR12MB333905B65166FFF1593CC84EF5ED0@DM6PR12MB3339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kyki7x1iMNM5AXNs9rphVr4Vt8qoDNAMyNPh3tc5Rt5IohvWL1q3RCA2iWCfIHcDdHfHthwsu+pZoR2CoY65+sq9CIuWqn7niJgH1119D64VPXkMw+4VUuuqxTGppETeNatvTwWfEHkwlPQDxrgtvHwhL+8/O4/XdApGT8pFjNYgz3KZfTWC1epJ2MPoB7UC7l3raCWVlhU891NTwihAC1HrkYlQyQHZE4VcHx+KcpczyPRRK+mtZVbJsTTby/wwlqbfd+S3VkM0GWDgQfvtNJu363HTolm2Z0iWob/epa7laUIXWO3N6P3HXa2UsXFy8TmYaRmJDrrnMpd2DyM2Lkp1iNKKSQGb5EvzjjcFMAl067LnHl8EDM89j+Pcje3eua5TtlJKqCecrudbaLOAVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(26005)(186003)(70586007)(356005)(1076003)(30864003)(5660300002)(82310400003)(7696005)(6666004)(36756003)(70206006)(47076004)(81166007)(2616005)(4326008)(82740400003)(2906002)(83380400001)(316002)(8936002)(426003)(54906003)(336012)(8676002)(86362001)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:21.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b415f4-eb2d-4303-6abe-08d882aa648e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3339
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/dce/dce_stream_encoder.c   | 82 ------------------
 .../display/dc/dcn10/dcn10_stream_encoder.c   | 82 ------------------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h | 83 ------------------
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 84 +++++++++++++++++++
 5 files changed, 85 insertions(+), 247 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 5054bb567b74..ada57f745fd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1062,88 +1062,6 @@ static void dce110_reset_hdmi_stream_attribute(
 
 #include "include/audio_types.h"
 
-/**
-* speakersToChannels
-*
-* @brief
-*  translate speakers to channels
-*
-*  FL  - Front Left
-*  FR  - Front Right
-*  RL  - Rear Left
-*  RR  - Rear Right
-*  RC  - Rear Center
-*  FC  - Front Center
-*  FLC - Front Left Center
-*  FRC - Front Right Center
-*  RLC - Rear Left Center
-*  RRC - Rear Right Center
-*  LFE - Low Freq Effect
-*
-*               FC
-*          FLC      FRC
-*    FL                    FR
-*
-*                    LFE
-*              ()
-*
-*
-*    RL                    RR
-*          RLC      RRC
-*               RC
-*
-*             ch  8   7   6   5   4   3   2   1
-* 0b00000011      -   -   -   -   -   -   FR  FL
-* 0b00000111      -   -   -   -   -   LFE FR  FL
-* 0b00001011      -   -   -   -   FC  -   FR  FL
-* 0b00001111      -   -   -   -   FC  LFE FR  FL
-* 0b00010011      -   -   -   RC  -   -   FR  FL
-* 0b00010111      -   -   -   RC  -   LFE FR  FL
-* 0b00011011      -   -   -   RC  FC  -   FR  FL
-* 0b00011111      -   -   -   RC  FC  LFE FR  FL
-* 0b00110011      -   -   RR  RL  -   -   FR  FL
-* 0b00110111      -   -   RR  RL  -   LFE FR  FL
-* 0b00111011      -   -   RR  RL  FC  -   FR  FL
-* 0b00111111      -   -   RR  RL  FC  LFE FR  FL
-* 0b01110011      -   RC  RR  RL  -   -   FR  FL
-* 0b01110111      -   RC  RR  RL  -   LFE FR  FL
-* 0b01111011      -   RC  RR  RL  FC  -   FR  FL
-* 0b01111111      -   RC  RR  RL  FC  LFE FR  FL
-* 0b11110011      RRC RLC RR  RL  -   -   FR  FL
-* 0b11110111      RRC RLC RR  RL  -   LFE FR  FL
-* 0b11111011      RRC RLC RR  RL  FC  -   FR  FL
-* 0b11111111      RRC RLC RR  RL  FC  LFE FR  FL
-* 0b11000011      FRC FLC -   -   -   -   FR  FL
-* 0b11000111      FRC FLC -   -   -   LFE FR  FL
-* 0b11001011      FRC FLC -   -   FC  -   FR  FL
-* 0b11001111      FRC FLC -   -   FC  LFE FR  FL
-* 0b11010011      FRC FLC -   RC  -   -   FR  FL
-* 0b11010111      FRC FLC -   RC  -   LFE FR  FL
-* 0b11011011      FRC FLC -   RC  FC  -   FR  FL
-* 0b11011111      FRC FLC -   RC  FC  LFE FR  FL
-* 0b11110011      FRC FLC RR  RL  -   -   FR  FL
-* 0b11110111      FRC FLC RR  RL  -   LFE FR  FL
-* 0b11111011      FRC FLC RR  RL  FC  -   FR  FL
-* 0b11111111      FRC FLC RR  RL  FC  LFE FR  FL
-*
-* @param
-*  speakers - speaker information as it comes from CEA audio block
-*/
-/* translate speakers to channels */
-
-union audio_cea_channels {
-	uint8_t all;
-	struct audio_cea_channels_bits {
-		uint32_t FL:1;
-		uint32_t FR:1;
-		uint32_t LFE:1;
-		uint32_t FC:1;
-		uint32_t RL_RC:1;
-		uint32_t RR:1;
-		uint32_t RC_RLC_FLC:1;
-		uint32_t RRC_FRC:1;
-	} channels;
-};
 
 /* 25.2MHz/1.001*/
 /* 25.2MHz/1.001*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f70fcadf1ee5..73ac78b16bd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -1021,88 +1021,6 @@ void enc1_reset_hdmi_stream_attribute(
 
 #include "include/audio_types.h"
 
-/**
-* speakersToChannels
-*
-* @brief
-*  translate speakers to channels
-*
-*  FL  - Front Left
-*  FR  - Front Right
-*  RL  - Rear Left
-*  RR  - Rear Right
-*  RC  - Rear Center
-*  FC  - Front Center
-*  FLC - Front Left Center
-*  FRC - Front Right Center
-*  RLC - Rear Left Center
-*  RRC - Rear Right Center
-*  LFE - Low Freq Effect
-*
-*               FC
-*          FLC      FRC
-*    FL                    FR
-*
-*                    LFE
-*              ()
-*
-*
-*    RL                    RR
-*          RLC      RRC
-*               RC
-*
-*             ch  8   7   6   5   4   3   2   1
-* 0b00000011      -   -   -   -   -   -   FR  FL
-* 0b00000111      -   -   -   -   -   LFE FR  FL
-* 0b00001011      -   -   -   -   FC  -   FR  FL
-* 0b00001111      -   -   -   -   FC  LFE FR  FL
-* 0b00010011      -   -   -   RC  -   -   FR  FL
-* 0b00010111      -   -   -   RC  -   LFE FR  FL
-* 0b00011011      -   -   -   RC  FC  -   FR  FL
-* 0b00011111      -   -   -   RC  FC  LFE FR  FL
-* 0b00110011      -   -   RR  RL  -   -   FR  FL
-* 0b00110111      -   -   RR  RL  -   LFE FR  FL
-* 0b00111011      -   -   RR  RL  FC  -   FR  FL
-* 0b00111111      -   -   RR  RL  FC  LFE FR  FL
-* 0b01110011      -   RC  RR  RL  -   -   FR  FL
-* 0b01110111      -   RC  RR  RL  -   LFE FR  FL
-* 0b01111011      -   RC  RR  RL  FC  -   FR  FL
-* 0b01111111      -   RC  RR  RL  FC  LFE FR  FL
-* 0b11110011      RRC RLC RR  RL  -   -   FR  FL
-* 0b11110111      RRC RLC RR  RL  -   LFE FR  FL
-* 0b11111011      RRC RLC RR  RL  FC  -   FR  FL
-* 0b11111111      RRC RLC RR  RL  FC  LFE FR  FL
-* 0b11000011      FRC FLC -   -   -   -   FR  FL
-* 0b11000111      FRC FLC -   -   -   LFE FR  FL
-* 0b11001011      FRC FLC -   -   FC  -   FR  FL
-* 0b11001111      FRC FLC -   -   FC  LFE FR  FL
-* 0b11010011      FRC FLC -   RC  -   -   FR  FL
-* 0b11010111      FRC FLC -   RC  -   LFE FR  FL
-* 0b11011011      FRC FLC -   RC  FC  -   FR  FL
-* 0b11011111      FRC FLC -   RC  FC  LFE FR  FL
-* 0b11110011      FRC FLC RR  RL  -   -   FR  FL
-* 0b11110111      FRC FLC RR  RL  -   LFE FR  FL
-* 0b11111011      FRC FLC RR  RL  FC  -   FR  FL
-* 0b11111111      FRC FLC RR  RL  FC  LFE FR  FL
-*
-* @param
-*  speakers - speaker information as it comes from CEA audio block
-*/
-/* translate speakers to channels */
-
-union audio_cea_channels {
-	uint8_t all;
-	struct audio_cea_channels_bits {
-		uint32_t FL:1;
-		uint32_t FR:1;
-		uint32_t LFE:1;
-		uint32_t FC:1;
-		uint32_t RL_RC:1;
-		uint32_t RR:1;
-		uint32_t RC_RLC_FLC:1;
-		uint32_t RRC_FRC:1;
-	} channels;
-};
 
 /* 25.2MHz/1.001*/
 /* 25.2MHz/1.001*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
index 2b08b1d72177..fa981cd04dd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
@@ -25,6 +25,7 @@
 
 
 #include "dc_bios_types.h"
+#include "hw_shared.h"
 #include "dcn30_afmt.h"
 #include "reg_helper.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h
index 08b2d8a8170c..85d4619207e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h
@@ -100,89 +100,6 @@ struct dcn30_afmt_mask {
 };
 
 
-/**
-* speakersToChannels
-*
-* @brief
-*  translate speakers to channels
-*
-*  FL  - Front Left
-*  FR  - Front Right
-*  RL  - Rear Left
-*  RR  - Rear Right
-*  RC  - Rear Center
-*  FC  - Front Center
-*  FLC - Front Left Center
-*  FRC - Front Right Center
-*  RLC - Rear Left Center
-*  RRC - Rear Right Center
-*  LFE - Low Freq Effect
-*
-*               FC
-*          FLC      FRC
-*    FL                    FR
-*
-*                    LFE
-*              ()
-*
-*
-*    RL                    RR
-*          RLC      RRC
-*               RC
-*
-*             ch  8   7   6   5   4   3   2   1
-* 0b00000011      -   -   -   -   -   -   FR  FL
-* 0b00000111      -   -   -   -   -   LFE FR  FL
-* 0b00001011      -   -   -   -   FC  -   FR  FL
-* 0b00001111      -   -   -   -   FC  LFE FR  FL
-* 0b00010011      -   -   -   RC  -   -   FR  FL
-* 0b00010111      -   -   -   RC  -   LFE FR  FL
-* 0b00011011      -   -   -   RC  FC  -   FR  FL
-* 0b00011111      -   -   -   RC  FC  LFE FR  FL
-* 0b00110011      -   -   RR  RL  -   -   FR  FL
-* 0b00110111      -   -   RR  RL  -   LFE FR  FL
-* 0b00111011      -   -   RR  RL  FC  -   FR  FL
-* 0b00111111      -   -   RR  RL  FC  LFE FR  FL
-* 0b01110011      -   RC  RR  RL  -   -   FR  FL
-* 0b01110111      -   RC  RR  RL  -   LFE FR  FL
-* 0b01111011      -   RC  RR  RL  FC  -   FR  FL
-* 0b01111111      -   RC  RR  RL  FC  LFE FR  FL
-* 0b11110011      RRC RLC RR  RL  -   -   FR  FL
-* 0b11110111      RRC RLC RR  RL  -   LFE FR  FL
-* 0b11111011      RRC RLC RR  RL  FC  -   FR  FL
-* 0b11111111      RRC RLC RR  RL  FC  LFE FR  FL
-* 0b11000011      FRC FLC -   -   -   -   FR  FL
-* 0b11000111      FRC FLC -   -   -   LFE FR  FL
-* 0b11001011      FRC FLC -   -   FC  -   FR  FL
-* 0b11001111      FRC FLC -   -   FC  LFE FR  FL
-* 0b11010011      FRC FLC -   RC  -   -   FR  FL
-* 0b11010111      FRC FLC -   RC  -   LFE FR  FL
-* 0b11011011      FRC FLC -   RC  FC  -   FR  FL
-* 0b11011111      FRC FLC -   RC  FC  LFE FR  FL
-* 0b11110011      FRC FLC RR  RL  -   -   FR  FL
-* 0b11110111      FRC FLC RR  RL  -   LFE FR  FL
-* 0b11111011      FRC FLC RR  RL  FC  -   FR  FL
-* 0b11111111      FRC FLC RR  RL  FC  LFE FR  FL
-*
-* @param
-*  speakers - speaker information as it comes from CEA audio block
-*/
-/* translate speakers to channels */
-
-union audio_cea_channels {
-	uint8_t all;
-	struct audio_cea_channels_bits {
-		uint32_t FL:1;
-		uint32_t FR:1;
-		uint32_t LFE:1;
-		uint32_t FC:1;
-		uint32_t RL_RC:1;
-		uint32_t RR:1;
-		uint32_t RC_RLC_FLC:1;
-		uint32_t RRC_FRC:1;
-	} channels;
-};
-
 struct afmt;
 
 struct afmt_funcs {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index f62ccf242f56..308e9ea4f0cf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -266,4 +266,88 @@ enum dc_lut_mode {
 	LUT_RAM_A,
 	LUT_RAM_B
 };
+
+/**
+ * speakersToChannels
+ *
+ * @brief
+ *  translate speakers to channels
+ *
+ *  FL  - Front Left
+ *  FR  - Front Right
+ *  RL  - Rear Left
+ *  RR  - Rear Right
+ *  RC  - Rear Center
+ *  FC  - Front Center
+ *  FLC - Front Left Center
+ *  FRC - Front Right Center
+ *  RLC - Rear Left Center
+ *  RRC - Rear Right Center
+ *  LFE - Low Freq Effect
+ *
+ *               FC
+ *          FLC      FRC
+ *    FL                    FR
+ *
+ *                    LFE
+ *              ()
+ *
+ *
+ *    RL                    RR
+ *          RLC      RRC
+ *               RC
+ *
+ *             ch  8   7   6   5   4   3   2   1
+ * 0b00000011      -   -   -   -   -   -   FR  FL
+ * 0b00000111      -   -   -   -   -   LFE FR  FL
+ * 0b00001011      -   -   -   -   FC  -   FR  FL
+ * 0b00001111      -   -   -   -   FC  LFE FR  FL
+ * 0b00010011      -   -   -   RC  -   -   FR  FL
+ * 0b00010111      -   -   -   RC  -   LFE FR  FL
+ * 0b00011011      -   -   -   RC  FC  -   FR  FL
+ * 0b00011111      -   -   -   RC  FC  LFE FR  FL
+ * 0b00110011      -   -   RR  RL  -   -   FR  FL
+ * 0b00110111      -   -   RR  RL  -   LFE FR  FL
+ * 0b00111011      -   -   RR  RL  FC  -   FR  FL
+ * 0b00111111      -   -   RR  RL  FC  LFE FR  FL
+ * 0b01110011      -   RC  RR  RL  -   -   FR  FL
+ * 0b01110111      -   RC  RR  RL  -   LFE FR  FL
+ * 0b01111011      -   RC  RR  RL  FC  -   FR  FL
+ * 0b01111111      -   RC  RR  RL  FC  LFE FR  FL
+ * 0b11110011      RRC RLC RR  RL  -   -   FR  FL
+ * 0b11110111      RRC RLC RR  RL  -   LFE FR  FL
+ * 0b11111011      RRC RLC RR  RL  FC  -   FR  FL
+ * 0b11111111      RRC RLC RR  RL  FC  LFE FR  FL
+ * 0b11000011      FRC FLC -   -   -   -   FR  FL
+ * 0b11000111      FRC FLC -   -   -   LFE FR  FL
+ * 0b11001011      FRC FLC -   -   FC  -   FR  FL
+ * 0b11001111      FRC FLC -   -   FC  LFE FR  FL
+ * 0b11010011      FRC FLC -   RC  -   -   FR  FL
+ * 0b11010111      FRC FLC -   RC  -   LFE FR  FL
+ * 0b11011011      FRC FLC -   RC  FC  -   FR  FL
+ * 0b11011111      FRC FLC -   RC  FC  LFE FR  FL
+ * 0b11110011      FRC FLC RR  RL  -   -   FR  FL
+ * 0b11110111      FRC FLC RR  RL  -   LFE FR  FL
+ * 0b11111011      FRC FLC RR  RL  FC  -   FR  FL
+ * 0b11111111      FRC FLC RR  RL  FC  LFE FR  FL
+ *
+ * @param
+ *  speakers - speaker information as it comes from CEA audio block
+ */
+/* translate speakers to channels */
+
+union audio_cea_channels {
+	uint8_t all;
+	struct audio_cea_channels_bits {
+		uint32_t FL:1;
+		uint32_t FR:1;
+		uint32_t LFE:1;
+		uint32_t FC:1;
+		uint32_t RL_RC:1;
+		uint32_t RR:1;
+		uint32_t RC_RLC_FLC:1;
+		uint32_t RRC_FRC:1;
+	} channels;
+};
+
 #endif /* __DAL_HW_SHARED_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
