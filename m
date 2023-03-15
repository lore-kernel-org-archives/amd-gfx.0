Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63900C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 07:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF1210E91A;
	Wed, 15 Mar 2023 07:29:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B06A10E023
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 07:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3jeD2RwsC8xcYUMslL/qfzU7/f//EFklmXtoNAuEK/T1WH2SW3qUFAD0xp3T2xxeOqDJ/O1dnbEIa4XVsHX99CnEt/YZtH2hzcUOgA7CeA05vK5hOrj+10G/C9yUgdQw8rV7bOzfmk4dRKcPI1010xiQek70JkWaqFExQ1dyotR3IClnaSmBgXYi1skq1IWTzF6uOX4z9NBVbG3aEiHC5B1c5myTLqPc5dg5ODWB+9svWRnsNcvideSAlNp5kOnFBQBj2Aw2xmoJGj0FkaHZUgrYlGXNalx94IPISuMDNHsViv43Xl3cHELTP+FIyOUNTL/k4s8qwo1aJQXh/Gnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvLXOAC9l/L4AkKjeMxOSIqjGoiv2+XCTgeECgE4Px8=;
 b=EtfJbw6pJWZUsDFyLuwp7soHWFAYsErLJqyaLKNI1XK42vcZlLnSUj5608MJccsI95l2gtguY7S0unsZaBhUY2FPixd5n3kPtnpLDbMRfBFD34IyfDd/aR45NHJIuyuuZWZHFCBaUAwZfgMUQaYpTOKs/TYUtX3DfPNEhD9fyTSZBhh0srQqCHByXJvrdljdSIZJnDrYv3+0AnlP3PmKTNYRNZyYeVfffrzWnjixtLrflrSVJwkAS95ECMP7xgbK7AysvKMl1vgXlpULD/e6svIPJYJ3Q1qKQ5+//y/hycPXtG0SOtDA5BhBLqwcRYysiplqtrSaQWh8DNwvt+8RfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvLXOAC9l/L4AkKjeMxOSIqjGoiv2+XCTgeECgE4Px8=;
 b=IVB5NprWGvgcU48uyWTgVuC521+6p3fVig3So14TGmWzClHQ5aWdxVudc5uTGq5rYQQ/WpgrmwJdtC592y/oOAkBv4qzEcU8bQb2UCbwDa1u2XNRE3hXs/HyOamQACDetiBIWOmJWPKAR13+l2DOP3D8kHYUMKRY0KQCjLB6wgw=
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 07:28:57 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::38) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 07:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Wed, 15 Mar 2023 07:28:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 02:28:57 -0500
Received: from bob-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Mar 2023 02:28:55 -0500
From: bobzhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Flora.Cui@amd.com>, <Yuliang.Shi@amd.com>, <majun@amd.com>
Subject: [PATCH] drm/amd: fix compilation issue with legacy gcc
Date: Wed, 15 Mar 2023 15:28:54 +0800
Message-ID: <20230315072854.45644-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b22c143-29b8-42a1-5e13-08db2526f079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQFzBYw5VelJNpOVuOQaCnJ1BcbeeSHhYyhH8QusU3jSUD3rpibwWyDw4DmjYDsS4b8dVOVLJXpsZn78kfetMvCthaxZl+L/OPLFSxEjVXRMJALppJfRQphuUwF3x+57SZu1UlVPam1IqH1YUrRnHJURsemVDfzrrmtxVaNN0FETyUJMEHyU8z+9webva8g7t3WGnwDnD2cTQBoHJXs7Iroehk7m+SHaX9eNBJn9ILiYbxIpXXy+RYUIWzZeGLUmgwIE48ui8VO2YOfyokb3ZQcaM5suV/ae9MJfVYO9FRN/J3R/uJjM/VUK8lAoGWCPq2+nEyw5KN6U1yypMDFKNP2kfxZaqP/onlv7ENZShMbib5eoQ6vQWDgZwywVyzi1QwcAqA4EB8EnZXCZvJNzNVpm9nwJFx8Wb+aVD9dtEbePCe8BArEchbXaIQRWlpybvd9HJJoHwj4r/f/JeKjgb5PkGphEiJyetL+DM9WBaSzyXBPyCGStzfy5rRThMO4H9/9Zaab9mlhM/nZ7wK2l1FJpkQHhQvh/WFgyvvGsq4xmquEb+aLNUEzBjB+Rg0Ho57tr9Rpq7/cWbegzvFMe1AURcrz9hOjwn7NRHJCyq7sizHGauri6gpOYWuhodq5jcCaRjx9sbQnLAFWldIpLjv/IlPrhdB4kz+Kr3J3bpp60xEVEU8TnU15f94A0V8KwDjXHu8w9lAYRTAwuUKM0+jIXUA/zXSyeQsopC2ONJ1pCoCh0RhBSWbfNiDzslpQpo9MlHQwcBToYHu/FZDMZJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(36860700001)(2616005)(7696005)(6636002)(36756003)(1076003)(40460700003)(478600001)(5660300002)(8936002)(82310400005)(316002)(110136005)(26005)(40480700001)(186003)(41300700001)(86362001)(83380400001)(336012)(356005)(4326008)(8676002)(70586007)(47076005)(426003)(70206006)(82740400003)(66574015)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 07:28:57.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b22c143-29b8-42a1-5e13-08db2526f079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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
Cc: bobzhou <bob.zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is used to fix following compilation issue with legacy gcc

error: ‘for’ loop initial declarations are only allowed in C99 mode

Signed-off-by: bobzhou <bob.zhou@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 9 ++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c     | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 2e251dcbb022..931f7c6446de 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -137,8 +137,9 @@ static uint8_t get_lowest_dpia_index(struct dc_link *link)
 {
 	const struct dc *dc_struct = link->dc;
 	uint8_t idx = 0xFF;
+	int i;
 
-	for (int i = 0; i < MAX_PIPES * 2; ++i) {
+	for (i = 0; i < MAX_PIPES * 2; ++i) {
 
 		if (!dc_struct->links[i] ||
 				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
@@ -165,8 +166,9 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
 	uint8_t idx = (link->link_index - lowest_dpia_index) / 2, idx_temp = 0;
 	struct dc_link *link_temp;
 	int total_bw = 0;
+	int i;
 
-	for (int i = 0; i < MAX_PIPES * 2; ++i) {
+	for (i = 0; i < MAX_PIPES * 2; ++i) {
 
 		if (!dc_struct->links[i] || dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
@@ -467,12 +469,13 @@ bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, uint8
 	bool ret = true;
 	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 };
 	uint8_t lowest_dpia_index = 0, dpia_index = 0;
+	uint8_t i;
 
 	if (!num_dpias || num_dpias > MAX_DPIA_NUM)
 		return ret;
 
 	//Get total Host Router BW & Validate against each Host Router max BW
-	for (uint8_t i = 0; i < num_dpias; ++i) {
+	for (i = 0; i < num_dpias; ++i) {
 
 		if (!link[i]->dpia_bw_alloc_config.bw_alloc_enabled)
 			continue;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 54d36df1306f..ea8f3d6fb98b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -325,6 +325,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	int ret;
+	int i;
 
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
@@ -339,7 +340,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 		pptable->MinGfxclkFrequency =
 			SMUQ10_TO_UINT(metrics->MinGfxclkFrequency);
 
-		for (int i = 0; i < 4; ++i) {
+		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
 				SMUQ10_TO_UINT(metrics->FclkFrequencyTable[i]);
 			pptable->UclkFrequencyTable[i] =
@@ -466,7 +467,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	uint32_t gfxclkmin, gfxclkmax, levels;
-	int ret = 0, i;
+	int ret = 0, i, j;
 	struct smu_v13_0_6_dpm_map dpm_map[] = {
 		{ SMU_SOCCLK, SMU_FEATURE_DPM_SOCCLK_BIT,
 		  &dpm_context->dpm_tables.soc_table,
@@ -513,7 +514,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	for (int j = 0; j < ARRAY_SIZE(dpm_map); j++) {
+	for (j = 0; j < ARRAY_SIZE(dpm_map); j++) {
 		dpm_table = dpm_map[j].dpm_table;
 		levels = 1;
 		if (smu_cmn_feature_is_enabled(smu, dpm_map[j].feature_num)) {
-- 
2.34.1

