Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA46C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11153895C1;
	Wed,  2 Nov 2022 16:04:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D6710E4EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvqbEcdZgPAjtG62EaUqzb7ltucui6/FLuiJTeY5bgWpaxHqIu0g/InNlvjiRZZfHWlA2carOOUzpUwwuDsma2X/XMU5VGew6K1t2Cne+nGY+VjDzJgy0L/8NNBsNNPstoSJ1XJM6F6ZO4/dsfUZXF1GBdF5fo7pef+hDfdMIJUS9uFY5LhxY85XDuO+iWdWMeXh5dY4lw2Ve9YVY6Ks5XM25Guhy8gIAnbdqHACkiHTubZIsNiJU8hY8asMgpZMkxVndSfWoxCHaeeqmplhGzKS5aLTlO4uJjD22o8rUAzYfv/uQTpvoNTz3zh9zp86sBfuHXYPBU58maMNd1Tm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlwvf8ElKkqSTBoZe2oqGpEdkAVaxB2QNORpJShXPZk=;
 b=NA22qAs1tNHpvyc3lWHb0IRISWYgZPP8R2uHqQEE13w3pIQvtTAZaeHCPbSUWr1dG7Ri5Yo+kp78JQYjdW9q/Z7B3mkxJYDs/NRGR7J9xoCJ/CwKAbTzdV4vhbLGpk7GP/W/yGAJVFiuRoDi6YSFcta1x7qz+tegSrzb431d4S6596h0txMR8Ar+4XdAJZG35yvjV9XpF7sxHUNNZYAa4TNQAppXT/i7+eaJbdJoyVsW6VwbdBQDvo++Px7YRm1w+p18esiUZrraQvsq0q86+czosfCBG7ek8I6pzDuLA2lXfu4X0Z1tYwYuYLssdturdDA5/lXhplYrq31eh2FHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlwvf8ElKkqSTBoZe2oqGpEdkAVaxB2QNORpJShXPZk=;
 b=qGPVTc6YPRsSvCMt/X1Bilo4S26Si4ZJ8XrM41OQwauNBOn5WuZDynH+072rVeXr8mApDsMPziEDAu+aq2XPuBACcA0KSlXr05TAQqOdl92nqH4DA0cmfdPlF89ioKTkPLsKCisRw4+B5G5vK0psdobZyuywgEjuLT3qVvzA4qY=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 16:04:09 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::63) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:09 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:05 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Fix gpio port mapping issue
Date: Thu, 3 Nov 2022 00:01:11 +0800
Message-ID: <20221102160117.506511-17-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 2195e944-118a-4897-23fc-08dabcebe08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHT2wLXBcsVQ1v1Dy9roM94pb/1gNn+yOoVWJLeJQJPe8kK9rYA+XCJ4aaJiBHC1xKNxaIMUYXEtM578fEZaZqSFySmiOuHp4sqWxyVeOviUer9p34X/KG6JopOrgp+/lZS9O332XKYVb3olHgGy1NBiJ2+6emSwC96DacgDtN4i2TzvbzajR1IMKUqamGA9g+uRElwDs7YIQAGdT4sHJuF6VP1lWHSrk+WEk5E2ON+JwcYd86nDljdkY30lV9TyqWAdRaa3+IatN56POEN5FbuQGy+JtS8/PBlx6unFzOeYUC7aJiijsH/Rlai8IM3IF7H1qPi4u46ayyhzOrNiRVJ0a+QuF7Gkm3KaEONmvnxHziNuxtsOwPQz5FYDKplHE0Sx3R8hOSCGDuUMLjKsrnNifM8KWJ6CutIeYukz1sGZ170I3fiQBDj4thffUbyE/oZVGOz1MKY0RPBFO5KMGttkdU/tSNgxcuHpCoa48mtn0slUkpyoJjO9dB5sInE4aDSvjpgWOnyGdkba3NlbPiECD2l4Kndcsomw/4dpONnwT1GtJmYMEVPPjL1OmB7tGcY3DR+km0VR1XvRJ/LJOLUF7wH9cHh4cW2v2vLeKe+hKAGzCyFFoErX5Vmdkl2uZotHEYWTiqQeLkg0dxBiHw6YY6heazudH9eWWBHACxvkKqq68o240HyjtJV1C+ad41SVdAE0Po5FfnJ4N39aO+FcVueKDH9Je7LDiWvHQO3NTikpoDN1tcyB7WYH43Vob0QIEyBldB9ZmuH8tQH4B0uLYMlw0T+/U7rHuxwb11MXNfvGM4chvyPtrfuJa8nZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(81166007)(356005)(86362001)(36860700001)(2906002)(82740400003)(5660300002)(70206006)(336012)(83380400001)(426003)(186003)(70586007)(47076005)(1076003)(26005)(478600001)(6916009)(7696005)(6666004)(316002)(54906003)(4326008)(40480700001)(36756003)(8676002)(8936002)(41300700001)(2616005)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:09.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2195e944-118a-4897-23fc-08dabcebe08c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Steve Su <steve.su@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Steve Su <steve.su@amd.com>

[Why]
1. Port of gpio has different mapping.

[How]
1. Add a dummy entry in mapping table.
2. Fix incorrect mask bit field access.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Steve Su <steve.su@amd.com>
---
 .../amd/display/dc/gpio/dcn32/hw_factory_dcn32.c   | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |  9 ++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
index d635b73af46f..0ea52ba5ac82 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -107,6 +107,13 @@ static const struct ddc_registers ddc_data_regs_dcn[] = {
 	ddc_data_regs_dcn2(3),
 	ddc_data_regs_dcn2(4),
 	ddc_data_regs_dcn2(5),
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
 	{
 			DDC_GPIO_VGA_REG_LIST(DATA),
 			.ddc_setup = 0,
@@ -121,6 +128,13 @@ static const struct ddc_registers ddc_clk_regs_dcn[] = {
 	ddc_clk_regs_dcn2(3),
 	ddc_clk_regs_dcn2(4),
 	ddc_clk_regs_dcn2(5),
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
 	{
 			DDC_GPIO_VGA_REG_LIST(CLK),
 			.ddc_setup = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index 6fd38cdd68c0..525bc8881950 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -94,11 +94,14 @@ static enum gpio_result set_config(
 		 * is required for detection of AUX mode */
 		if (hw_gpio->base.en != GPIO_DDC_LINE_VIP_PAD) {
 			if (!ddc_data_pd_en || !ddc_clk_pd_en) {
-
-				REG_SET_2(gpio.MASK_reg, regval,
+				if (hw_gpio->base.en == GPIO_DDC_LINE_DDC_VGA) {
+					// bit 4 of mask has different usage in some cases
+					REG_SET(gpio.MASK_reg, regval, DC_GPIO_DDC1DATA_PD_EN, 1);
+				} else {
+					REG_SET_2(gpio.MASK_reg, regval,
 						DC_GPIO_DDC1DATA_PD_EN, 1,
 						DC_GPIO_DDC1CLK_PD_EN, 1);
-
+				}
 				if (config_data->type ==
 						GPIO_CONFIG_TYPE_I2C_AUX_DUAL_MODE)
 					msleep(3);
-- 
2.25.1

