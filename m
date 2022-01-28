Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14150C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8234710E364;
	Fri, 28 Jan 2022 14:05:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB88A10E364
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkOQDw5ItZtn/0CzwQcoJTFzD7AbQ5CkaABahf1UrWr/7/ph9WgM9EMEDWfcb1/iNAWRocEFwdKeU3nQnKgeNo1QKg3j7PVXijiVaGZZv1WvdCJ4b38zcjWhlWwH5NtigNJzEU/ORg/1VBnK+mCgrwn1oePIlY6JDLrmz8AU4NkRLHuOPQmklvC8PJqYFa3kyezWTqWfi2/P+tEfiBaWMvRwZ52biNK3HCoRqhlPGdi/BVvgsOkQ1U2ifCX5I1zN0e2nMkwpi5XpRude0zyhmoa3By7X1/TA+frQamVpmCupQ9gg2nqSFpoe6obk2VuuDrlKZkZH8LKpWsblmHMaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqeO+sAfuIUiA7eeAoo8WreYKonbo2VWHu301GJACso=;
 b=nlZkbXdj2asNHLG3nD4wDezIwUfgP9jipespe2AKIv+sASr4mZMtebUDF3d8x6sM3/7GNSX+hvdmpw+pUP3Dy3VeaRpVTM9kwvrfRl23ykQdVldH4c7lL8jvYnQSGE3YRjIlT5K6yyHllZI0zJ8rRlu6YMEARawuREwqPcieU7VmibRph2a9HwZzG/4CKVQljKIetTx2EDtkt1pupqXxxAyv1LmHcBDRsDUVuGJd2STPvkSlXpvY5ldUXhmyjUjpROqpoANqP6S/IqPYSZdFPFF5xNDiu5AWYMqLMU/EHP4u9SY1Mja36dpGlrXsmii5l4UY5LWI6y5hXfWDnx/Cvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqeO+sAfuIUiA7eeAoo8WreYKonbo2VWHu301GJACso=;
 b=mKV0inKxU+2BXfLyhc9UqLRmU/2E44Ky/kqS9bQ+1AmoHIhqYuFvFV801O3CV43lW/eWf6jtOEq3qnr7Sn1KYgu6Oap4srz1tDpk0SUKBLalzifC85iuGKrcOAP2ranSAqqDmA4Dbfl8u3OAS2GgG3EHBq0b9Fbd5rHQxgew+yU=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Fri, 28 Jan
 2022 14:05:10 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b7) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:10 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:03 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/17] drm/amd/display: watermark latencies is not enough on
 DCN31
Date: Fri, 28 Jan 2022 22:03:57 +0800
Message-ID: <20220128140411.3683309-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e69f521-859b-4796-e305-08d9e2673237
X-MS-TrafficTypeDiagnostic: PH7PR12MB5656:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5656D0C809B2CEC3768557FBFF229@PH7PR12MB5656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnycu9D9SGc8A7F4ZRJbSAFoEKAHPyuHslx1Wi0qSN2ay6yKj9cSuWglAE2eFG3G+SgwZ5bG5bQqoyuB4Mdf43iDLV5DZtrsdlSCLADVEZ4z+acZRACjBMG0LX+onlVTokQcWohX6zQfmSg0Hqu/yeXeaTIP0QLgeeWo6WlUx+3RwgEfPXmFHeRDoeZC6cn6iBZFY2C4zrGKuDphha7VTuQootfNu6W+B64jAIGgXtivXT+ugxrS9WRe0ZNXNvhfkUIjasq/1wobhfDQu3SBBRcpW/+NjntxGgAjGDvXp21p3vRLn7xY/DQg/lhMI/AKOzs3ARVKbx5d4nRdI6NKsOO9XlQIlZZ1yWR5I6upO9ZD0NE7DLpcpDOsxPkmfV58uWZrsa9fGihHdGZ26FrxdiUCoC+GEOB9karSz4cubVyZH3h6GLcEOxKYf6uq3Phknmbng9KChbFBDFRb1acdF20WMA+RgKSoaRJk8OVD9RkCdpI+4GA3oveB+0tcUCC2did9HAVt9iYcThnKUSmLlm4NxrPNJdXi4vPMaZ/RMaE5NLiw8rFQtvZkrtwLycbdZ5hYu2pmPX2h6Xgzjvx+fykBUm5JMOz8HiYj70lIiAA3K7+2Ue+roilUm7UKETi21haIx42oR1FafGM9p4QHw7DFVmd1hZOfs6NvOeKXqFz9OtB6x31S+3hU05kkvCC+Pyzc7LoR/vRta8tNb8bzWCjDmwot+WjDc2fbQ4iy95ZhcOJde/QPvRFlwBkfpFOrQAD1KO+/Etq5AT/+znOcsUgf8fvc4Vxs9Sun/oAcI70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(336012)(186003)(82310400004)(8936002)(6916009)(26005)(4326008)(7696005)(2906002)(356005)(83380400001)(426003)(44832011)(5660300002)(70586007)(47076005)(40460700003)(81166007)(54906003)(36860700001)(508600001)(2616005)(1076003)(36756003)(8676002)(86362001)(316002)(6666004)(70206006)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:10.0574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e69f521-859b-4796-e305-08d9e2673237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
The original latencies were causing underflow in some modes.
Resolution: 2880x1620@60p when HDR enable

[How]
1. Replace with the up-to-date watermark values based on new measurments
2. Correct the ddr_wm_table name to DDR5 on DCN31

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 66bd0261ead6..e17c9938cee5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -329,38 +329,38 @@ static struct clk_bw_params dcn31_bw_params = {
 
 };
 
-static struct wm_table ddr4_wm_table = {
+static struct wm_table ddr5_wm_table = {
 	.entries = {
 		{
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 6.09,
-			.sr_enter_plus_exit_time_us = 7.14,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 9,
+			.sr_enter_plus_exit_time_us = 11,
 			.valid = true,
 		},
 	}
@@ -687,7 +687,7 @@ void dcn31_clk_mgr_construct(
 		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
 			dcn31_bw_params.wm_table = lpddr5_wm_table;
 		} else {
-			dcn31_bw_params.wm_table = ddr4_wm_table;
+			dcn31_bw_params.wm_table = ddr5_wm_table;
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		 dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
-- 
2.34.1

