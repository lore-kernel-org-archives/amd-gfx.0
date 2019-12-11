Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B5C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C390C2073B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N3qz1UeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B31B6EB71;
	Wed, 11 Dec 2019 15:46:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884226EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0HjV3ObWN4LYlpHEjfngWQ36MvyoLmPafftkdXnQO/pX3Oo7E+b8OkTUGkcK4gu5Qt5FtNe4Z98EwfHzKOwYP+vrrdY2UxFtnaNmr5tTSeo7yasvvKx/vFXrkM/Ht+pSo8i/se1XMzlzIFb31r0d1lJsiqYXN2BweBfDlAm2saSUkqM+dDbe886Hg9/KDftVhZQhhOdno2+G9wwjJE58w/etXGsEHFJEfONuJPikbTaYBUv8ZCokvZPELB+6cG8wWkscYqu2wgWfbEmj8i5AQy9q4Z81KvNQazH1+aIamD4HDv2NjRB37ZDjSI6uhWwZGcalGqbM+30VDLotY2cmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOyJXGsyQ2tQqHtTydFL9idH4usD/mGfg8uKCf76GhU=;
 b=WCve4FkcG+wOIZC8N+DGpElcMDj90Bvr3HRZuXojrLnYpUgp2EW8ZD/RjKq9OgvFBjAkOABuwJgK5jhBiOjpAhJT0AiPeBQDWyk+Tan1BL2fjWX1xRwfHBs62KHOqLrPj9hDVJUbbVmd4qFkrIZMilPaZKPqNuy5qyDw14Z1GE6kN+H2i4CVJfN0AKey+hdeMRggG2QUTEpEL0ZI5AkCXhYUYKoicZzhB+r0K3sZ7RMZ1+ksGNboOD+0199UNNgIFVu9kWi1UqO7h7IOlAh0ndF10aJkaCel+cvPBU49WoV/9obdQWCX/1ed27FB9LTYFcN0w0dC0fUq4+0SL4WvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOyJXGsyQ2tQqHtTydFL9idH4usD/mGfg8uKCf76GhU=;
 b=N3qz1UeWuG5MO4Dews0kV1sOd0oUBR3bunbCuC50fcdguAN2bZe/6erdXQnpmsMP3/dy5AP4b389h0uUvm/oUGG6yxQT0yXWX55okl8AJJg67VnZIBTNUlSH6TWR9MOXEAxsMB+vIt5ob9B9CcVEDLR9p1GNDUrthA/twBsNTCo=
Received: from DM5PR12CA0056.namprd12.prod.outlook.com (2603:10b6:3:103::18)
 by MN2PR12MB3357.namprd12.prod.outlook.com (2603:10b6:208:d1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Wed, 11 Dec
 2019 15:46:04 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by DM5PR12CA0056.outlook.office365.com
 (2603:10b6:3:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 15:46:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 15:46:04 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 09:46:03 -0600
Received: from roma-lnx-dev.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Dec 2019 09:46:03 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tony.Cheng@amd.com>, <harry.wentland@amd.com>
Subject: [PATCH 3/3] drm/amd/display: add missing dcn link encoder regs
Date: Wed, 11 Dec 2019 10:45:43 -0500
Message-ID: <1576079143-5675-3-git-send-email-Roman.Li@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576079143-5675-1-git-send-email-Roman.Li@amd.com>
References: <1576079143-5675-1-git-send-email-Roman.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(199004)(189003)(7696005)(30864003)(81166006)(8676002)(336012)(8936002)(81156014)(478600001)(426003)(2616005)(2906002)(6666004)(2876002)(356004)(5660300002)(70206006)(54906003)(26005)(6636002)(316002)(110136005)(70586007)(186003)(86362001)(4326008)(36756003)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3357; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe970d1-ed2b-4942-14dd-08d77e513b2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3357:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33571A701201FCB33BBE548D895A0@MN2PR12MB3357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5+wnHQzqMWcYeB1JuI348MpXHRha/D2bo3FlqAt0SqyYzW1FZuw2gzDvfWJIPK9cpkq+pye0MbeAL8Fx56HhpVUnhfmbZe9QhABLxapFJGnPWHLettkSEFHZKi2TPOgu7AP1W/NymGkQvP/NQqX1TxVfGEest+RP1S1iayRiTDqMoKAOO2RxEGuVNmLTovL73FDofMMIbLaxfLfeKMurVagfDqMJr7+J/BzFCgdML7grDi/mdDCXXEM0Fc/rnSLVIGG32HmJsrV3WnwzY/2hHC5SnPXCDJiA3c3Hy3ZnQv55ymTd8i+r199dR+qIZSrGmihrgvHtj7ONbL5zAMpHxr/O2jl+neimzOpNQo2WydIlr7vIJmgChECvpLEIsoFRPOz3TAGlJSUh4WubkHEb7LJYRMjAM6vzlH5jyXWL4TGKaVa+Ku2+dTfCMO/B/A2oWbtJ5pS7IFbU5YKtJJs/Gz+sAA1evqi0Aio/gEwQGc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:46:04.4899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe970d1-ed2b-4942-14dd-08d77e513b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3357
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
Cc: sunpeng.li@amd.com, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
The earlier change: "check phy dpalt lane count config"
uses link encoder registers not defined properly.
That caused regression with mst-enabled display not
lighting up.

[How]
Add missing reg definitions.

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |  20 +++
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  | 180 ++++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   9 +-
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.h  |  39 +++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  11 +-
 5 files changed, 253 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index 7493a63..eb13589 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -124,6 +124,26 @@ struct dcn10_link_enc_registers {
 	uint32_t RDPCSTX_PHY_CNTL13;
 	uint32_t RDPCSTX_PHY_CNTL14;
 	uint32_t RDPCSTX_PHY_CNTL15;
+	uint32_t RDPCSTX_CNTL;
+	uint32_t RDPCSTX_CLOCK_CNTL;
+	uint32_t RDPCSTX_PHY_CNTL0;
+	uint32_t RDPCSTX_PHY_CNTL2;
+	uint32_t RDPCSTX_PLL_UPDATE_DATA;
+	uint32_t RDPCS_TX_CR_ADDR;
+	uint32_t RDPCS_TX_CR_DATA;
+	uint32_t DPCSTX_TX_CLOCK_CNTL;
+	uint32_t DPCSTX_TX_CNTL;
+	uint32_t RDPCSTX_INTERRUPT_CONTROL;
+	uint32_t RDPCSTX_PHY_FUSE0;
+	uint32_t RDPCSTX_PHY_FUSE1;
+	uint32_t RDPCSTX_PHY_FUSE2;
+	uint32_t RDPCSTX_PHY_FUSE3;
+	uint32_t RDPCSTX_PHY_RX_LD_VAL;
+	uint32_t DPCSTX_DEBUG_CONFIG;
+	uint32_t RDPCSTX_DEBUG_CONFIG;
+	uint32_t RDPCSTX0_RDPCSTX_SCRATCH;
+	uint32_t RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG;
+	uint32_t DCIO_SOFT_RESET;
 	/* indirect registers */
 	uint32_t RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_2;
 	uint32_t RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_3;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index 62dfd34..8cab810 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -33,7 +33,142 @@
 	SRI(AUX_DPHY_TX_CONTROL, DP_AUX, id)
 
 #define UNIPHY_MASK_SH_LIST(mask_sh)\
-	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_LINK_ENABLE, mask_sh)
+	LE_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, mask_sh),\
+	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_LINK_ENABLE, mask_sh),\
+	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL0_XBAR_SOURCE, mask_sh),\
+	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL1_XBAR_SOURCE, mask_sh),\
+	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL2_XBAR_SOURCE, mask_sh),\
+	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL3_XBAR_SOURCE, mask_sh)
+
+#define DPCS_MASK_SH_LIST(mask_sh)\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX0_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX1_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX2_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX3_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_MPLLB_MULTIPLIER, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_RATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_RATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_QUOT, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_DEN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL8, RDPCS_PHY_DP_MPLLB_SSC_PEAK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL10, RDPCS_PHY_DP_MPLLB_FRACN_REM, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_REF_CLK_MPLLB_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_HDMI_MPLLB_HDMI_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_SSC_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_TX_CLK_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_STATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_FRACN_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_PMIX_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE0_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE1_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE3_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_EXT_REFCLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_BYPASS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_CLOCK_ON, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_CLOCK_ON, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_GATE_DIS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_CR_MUX_SEL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_REF_RANGE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_BYPASS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_EXT_LD_DONE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_HDMIMODE_ENABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_INIT_DONE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DP4_POR, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PLL_UPDATE_DATA, RDPCS_PLL_UPDATE_DATA, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_REG_FIFO_ERROR_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_TX_FIFO_ERROR_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_DISABLE_TOGGLE_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_4LANE_TOGGLE_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCS_TX_CR_ADDR, RDPCS_TX_CR_ADDR, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCS_TX_CR_DATA, RDPCS_TX_CR_DATA, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_V2I, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_FREQ_VCO, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_INT, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_PROP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_FINETUNE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_RANGE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_CLOCK_ON, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_GATE_DIS, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_EN, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_SWAP, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_EN, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
+	LE_SF(DPCSTX0_DPCSTX_DEBUG_CONFIG, DPCS_DBG_CBUS_DIS, mask_sh)
+
+#define DPCS_DCN2_MASK_SH_LIST(mask_sh)\
+	DPCS_MASK_SH_LIST(mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_RX_LD_VAL, RDPCS_PHY_RX_REF_LD_VAL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_RX_LD_VAL, RDPCS_PHY_RX_VCO_LD_VAL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX0_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX1_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX0_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX1_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_REF_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX2_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX2_RATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX3_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX3_RATE, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYA_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYB_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYC_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYD_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh)
 
 #define LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)\
 	LINK_ENCODER_MASK_SH_LIST_DCN10(mask_sh),\
@@ -63,6 +198,49 @@
 	SRI(CLOCK_ENABLE, SYMCLK, id), \
 	SRI(CHANNEL_XBAR_CNTL, UNIPHY, id)
 
+#define DPCS_DCN2_CMN_REG_LIST(id) \
+	SRI(DIG_LANE_ENABLE, DIG, id), \
+	SRI(TMDS_CTL_BITS, DIG, id), \
+	SRI(RDPCSTX_PHY_CNTL3, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL4, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL5, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL6, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL7, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL8, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL9, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL10, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL11, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL12, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL13, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL14, RDPCSTX, id), \
+	SRI(RDPCSTX_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_CLOCK_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_INTERRUPT_CONTROL, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL2, RDPCSTX, id), \
+	SRI(RDPCSTX_PLL_UPDATE_DATA, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_ADDR, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_DATA, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
+	SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
+	SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
+	SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
+	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
+	SR(RDPCSTX0_RDPCSTX_SCRATCH)
+
+
+#define DPCS_DCN2_REG_LIST(id) \
+	DPCS_DCN2_CMN_REG_LIST(id), \
+	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
+	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
+
+#define LE_DCN2_REG_LIST(id) \
+		LE_DCN10_REG_LIST(id), \
+		SR(DCIO_SOFT_RESET)
+
 struct mpll_cfg {
 	uint32_t mpllb_ana_v2i;
 	uint32_t mpllb_ana_freq_vco;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index cfc6991..186277d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -65,6 +65,8 @@
 
 #include "dcn/dcn_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_sh_mask.h"
+#include "dpcs/dpcs_2_0_0_offset.h"
+#include "dpcs/dpcs_2_0_0_sh_mask.h"
 
 #include "nbio/nbio_2_3_offset.h"
 
@@ -548,6 +550,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 [id] = {\
 	LE_DCN10_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	DPCS_DCN2_REG_LIST(id), \
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
@@ -561,11 +564,13 @@ static const struct dcn10_link_enc_registers link_enc_regs[] = {
 };
 
 static const struct dcn10_link_enc_shift le_shift = {
-	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT)
+	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT),\
+	DPCS_DCN2_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dcn10_link_enc_mask le_mask = {
-	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK)
+	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK),\
+	DPCS_DCN2_MASK_SH_LIST(_MASK)
 };
 
 #define ipp_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
index 1d7a1a5..033d5d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
@@ -33,6 +33,45 @@ struct dcn21_link_encoder {
 	struct dpcssys_phy_seq_cfg phy_seq_cfg;
 };
 
+#define DPCS_DCN21_MASK_SH_LIST(mask_sh)\
+	DPCS_DCN2_MASK_SH_LIST(mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_TX_VBOOST_LVL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_MPLLB_CP_PROP_GS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_RX_VREF_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_CP_INT_GS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCS_DMCU_DPALT_DIS_BLOCK_REG, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_SUP_PRE_HP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX0_VREGDRV_BYP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX1_VREGDRV_BYP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX2_VREGDRV_BYP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX3_VREGDRV_BYP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_FINETUNE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_RANGE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYA_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYB_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYC_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYD_SOFT_RESET, mask_sh),\
+	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh)
+
+#define DPCS_DCN21_REG_LIST(id) \
+	DPCS_DCN2_REG_LIST(id),\
+	SRI(RDPCSTX_PHY_CNTL15, RDPCSTX, id),\
+	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
+
 #define LINK_ENCODER_MASK_SH_LIST_DCN21(mask_sh)\
 	LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh),\
 	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL0_XBAR_SOURCE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8fa6392..caafdc9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -60,6 +60,8 @@
 
 #include "dcn20/dcn20_dwb.h"
 #include "dcn20/dcn20_mmhubbub.h"
+#include "dpcs/dpcs_2_1_0_offset.h"
+#include "dpcs/dpcs_2_1_0_sh_mask.h"
 
 #include "renoir_ip_offset.h"
 #include "dcn/dcn_2_1_0_offset.h"
@@ -1495,8 +1497,9 @@ static const struct encoder_feature_support link_enc_feature = {
 
 #define link_regs(id, phyid)\
 [id] = {\
-	LE_DCN10_REG_LIST(id), \
+	LE_DCN2_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	DPCS_DCN21_REG_LIST(id), \
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
@@ -1535,11 +1538,13 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 };
 
 static const struct dcn10_link_enc_shift le_shift = {
-	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT)
+	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT),\
+	DPCS_DCN21_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dcn10_link_enc_mask le_mask = {
-	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK)
+	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK),\
+	DPCS_DCN21_MASK_SH_LIST(_MASK)
 };
 
 static int map_transmitter_id_to_phy_instance(
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
