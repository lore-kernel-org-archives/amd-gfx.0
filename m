Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522BC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A0F10E47A;
	Wed, 31 May 2023 04:49:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5E510E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPke2ykOP3lQueCFhtx4ymCpWt0MlmvzLZt1co8q2cOU/IXZ0EfeEBLt0w1p6K+ZpVMKKslpTfy7P2oxxvgCf1Cad0yfuqLoqWKe0ikevhUP7pcvAYEbJeUh+bbceZ7Sap7B5cL6FA60pVvX/Bp5u6qserq6jTiI8M9rSbfdZ8G3Z9WRyJhzRDf/7ImsMrLAoD0GVwzY5vOFUvgcASOsaEi2VBEjIIZzEutsRAxmGs7u10Zn9eFCIWCeCzgia+S0aEfr14qPniqlBb+AEIa2le3BC1NIxLhtfwDpAk4YvWKTtmsjUHL1MHLQ602yrKyj1uaVp57nVkiIaZiXMWiCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIC9aPr8hU6r0ivDQpnCl/OrJlmaYYTigaZ5bu4td94=;
 b=USMnE0thSILf+CitxOnQVlQjZ9C2KyPYyUfKtiPrezAGBlL7J79bxRNojCs1rKBiiJQHzBTNb1R5QHJcPSZYRsXKEI8Mmkd+vryXOIOfuxYeE5BwXMkjQNSUt7MrTySnPsKvZUk1Wlebjes1Yu5gjHlfiQfUOW6gWpoNIyqAl1t/Vg3YTQWZ5UEgH0hx1auoDCN4EXjFDQ6RlZ8BGK6XwLEjgbn8XF72aJvovDPdMaiA37tijj6YLrbykyly0VPbbFZpyYW7AvS9njme35EGgtL6EPwE5wks4cWqrM0085YhJ6T2Q3Oz0TauSiTyB93tv9W+ol7Vd6KjZTuGyxrXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIC9aPr8hU6r0ivDQpnCl/OrJlmaYYTigaZ5bu4td94=;
 b=tp5yLVI/19QAWl00xihkI5PLg1lyDA7El30TbH9aNf5izThaZNqnbyGur+rSWeyM/b+rSWjxS6gRg5V6LA/V912GL659f8WBzjE7Q+Fe4TB/pOqzRhpiYeMVtfoI1NwxRouNx0muElLMwMc+vDwMt0vQENygxBn7LnMaAeMwd4M=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 04:49:48 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::f) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:47 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: Skip DPP DTO update if root clock is
 gated
Date: Wed, 31 May 2023 12:48:12 +0800
Message-ID: <20230531044813.145361-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ff7550-68bd-499e-57a5-08db6192761f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KzoKlHCjOZ7eC4GcAIrZmzgl0s1qGxHPlz4xgmOWvpUuZ33qX08298lq9Yxt82woUS18LUymlNQLfswHBTyXWPR6Rmpsk6trgV6juKNou/L6KrH4lrUXIwc5LiMxmJ632HnxEOqlDaMkCecG+3wQnkM45P7g5+bbI4lQGc/rUd1brWc6txzFMoAZfwXA2r/tXNN3XeALvdxQKHs6THga7hbyXmAjF3TKDjFZn1GWKmGR4Fwuxu+OCjhDqsSE2aAR/28VKWv9Uw7pz6Dnr0sPyTfxUYj7A1El070z/MIWWuewg0HkGF9E3Xn0apav5hmhcoce3G7cREef82bIJKeQAMOqWdl3y/UhkMEj//hBmgIyNbPIlrP+zcPDviiwd8FHRdShKR3odOkprTtOgcJpRIjaNwUwjvwkjrokNoToLurOiV3hXIs4JoaEbnJudASTjUF0J9a81OpuEbh8dMo75UlWpdSa7o7NothM3rt0WAHMIqZIgokN/BGmeC4T+22afrNQIv2+LKLJBPwqklZwnbWgmRVErodJf1EKxKVh5YP/hTZ0YVuSg0zxuZKfMf0VU5h8miaGL3iYXz996pH+qOT5N1QXNvSHsuOWD384Al9ZuBISlfFIlYRQWgS25OrLI103Uoxy8td7ZqYFf2uddx8Kc2sTb810IYAO8C+EaTL4ZjGgNlJOLUhSlS7u101M5YDYakxqzLwWeC/1MqJ/nDnQKs7OET6aXVc448Mx8i9WgC3IdXvKOvCzxmCBL/giaDrW9eOXNl4wmYg+TqO3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(16526019)(83380400001)(41300700001)(6666004)(1076003)(2616005)(186003)(36860700001)(26005)(336012)(426003)(7696005)(54906003)(40460700003)(478600001)(81166007)(6916009)(82740400003)(4326008)(356005)(70206006)(70586007)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(86362001)(2906002)(15650500001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:47.7473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ff7550-68bd-499e-57a5-08db6192761f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Hardware implements root clock gating by utilizing the DPP DTO registers
with a special case of DTO enabled, phase = 0, modulo = 1. This
conflicts with our policy to always update the DPPDTO for cases where
it's expected to be disabled.

The pipes unexpectedly enter a higher power state than expected because
of this programming flow.

[How]
Guard the upper layers of HWSS against this hardware quirk with
programming the register with an internal state flag in DCCG.

While technically acting as global state for the DCCG, HWSS shouldn't be
expected to understand the hardware quirk for having DTO disabled
causing more power than DTO enabled with this specific setting.

This also prevents sequencing errors from occuring in the future if
we have to program DPP DTO in multiple locations.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c   | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h        | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 4c2fdfea162f..65c1d754e2d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -47,6 +47,14 @@ void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst]) {
+		/*
+		 * Do not update the DPPCLK DTO if the clock is stopped.
+		 * It is treated the same as if the pipe itself were in PG.
+		 */
+		return;
+	}
+
 	if (dccg->ref_dppclk && req_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
 		int modulo, phase;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index e0e7d32bb1a0..cf23d7bc560a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -332,6 +332,9 @@ static void dccg314_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+		return;
+
 	if (clock_on) {
 		/* turn off the DTO and leave phase/modulo at max */
 		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
@@ -345,6 +348,8 @@ static void dccg314_dpp_root_clock_control(
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
 	}
+
+	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
 }
 
 static const struct dccg_funcs dccg314_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 0b700b3d7d97..8dc804bbe98b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -68,6 +68,7 @@ struct dccg {
 	const struct dccg_funcs *funcs;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
+	bool dpp_clock_gated[MAX_PIPES];
 	//int dtbclk_khz[MAX_PIPES];/* TODO needs to be removed */
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
 	//int ref_dtbclk_khz;/* TODO needs to be removed */
-- 
2.40.1

