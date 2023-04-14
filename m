Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2DAC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B4C10EDDD;
	Fri, 14 Apr 2023 15:54:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480D610EDEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSbaLssvr1Cvi6vyvZxoA8BWweyMNqpcxrHOt5XOpHHHwBlZnETVh/ajxnvdnacHRhj3RnlQu9R1wIb3uGMARzl7kTZzwwCcVdCBPYqdVg0GnC3SjcJFG0dfZZrMK3r1UrZU6IOUos9lLYflv3yfqp0IN4jlFGZB1H/GP11xM7ik2aldfrx1PHdLBApSuVwJMwutjeu07WXbXSYM/yyv9i0IpfSomYCwzdt5k6QXbr4tOVLRal9FcWopyfzIA8ZyftPOKkIcgvnGH4NOa2v6Hl6N8HtjWGRy7SnfmCz2SOx5hja2PXwbU6CMDHyQmxr9NX1E46YZu4duOskxw6YY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaVpCv2lruXqGA8cEObz7fOQUq7swsMOGIjbI15jpvc=;
 b=AhtEVeaPlREbJ47fla609FKhrKeR6oP0w4VJOnUg7M9FZdmwylrUdeVTTrHxDAjP4AxTQWPGKien0vX4cMQewze7v8FSxfViT4ScpWazMTiz4kL8Kzrk7LNdEhmdim5a9LNDyRcGKlOseBPdmtec8TBB5ANt0CPfG0oDtyPJgUSz6T9NfLGLLHot++JqiMgK5JQMDVuNUpRZg9D3xzIV+X4Qle47sFcDs/G2OktMhgb13HDq8Eg415LKhxABKwD99KsrbN3dNTVwL0lmzuwGLhY0ctWmBzHdva8eyNfxxXqfbnVdUuQ65RyPDiK8+JUCdID+4gt7zIJy8eOLVLVFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaVpCv2lruXqGA8cEObz7fOQUq7swsMOGIjbI15jpvc=;
 b=dIJ4FEHZX7PwlRa19TJZrcKFT8i8B3PKSkoNi1Ww0Xi/gplyeoalxcKtGvfrWMuyEJLghU2XxgVtpAewdqnkJH6ZpCxIC5Pfl0QoesDlseZm65fwwZRRPmhYhg7l12JTZ5rOQC0OOHyqYfe7a9Su0tju3cqAtM3nhUNwCWwa0Vc=
Received: from BN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:e4::17)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:53 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::70) by BN0PR02CA0012.outlook.office365.com
 (2603:10b6:408:e4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:52 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:50 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 43/66] drm/amd/display: Update DTBCLK for DCN32
Date: Fri, 14 Apr 2023 11:53:07 -0400
Message-ID: <20230414155330.5215-44-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: acfaf319-121d-4c0b-c882-08db3d009605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwKkTdrWC4dzTuOo5y2OGM/DglN3nmjaB/csSjUAmhU0cft4j+ngc+56lDXe0Vs8ajGVDqW5OIXGHJCk7BYFzho0Kp6nlnDy8wVlEeDB1sSnyRYaY3Q7Lx8QwE5PLNnYevSdIpTzrHoBNgfFixey3Lynj9JWhA8pB8LCpiadEC4GSdozT+c4XOUM2yGoP9NIlFpKSltsdmiI7C0PyPrpsa1umgiBz2vXTJEoGuS0t/97OefmeMJJHVYo8O6cn2Lil+U7YIQf5er0FWTWeNeuHpZOQk6SLlLjKuTD27GGAKxaOV/H0+5Wirwjc8yZWWIn7PexvvCRlXoula6pgK7HC8UTug/8yN1YFyz2wOlPd3Pjh6RpDbe8jWkCv3M52J4842D1a2m4vyZWuXoTaSOz1p29muMgMGAvXdZnxzrP4fNKB2VjKJYMPmq9PGaiDKWx7LcY6f0q61hCNCN6gaWSZ0D6pUJkvQBkEXk1vT/MCX0VXYFNpbhYGx6SZbZOKDdPNs0b+SSMhzDEtTFrdmt8kmgRLOXbgciP3JLbIKU4P8vmCUp27WBGhdUZNyKrtOx1rUBbAavN3zsUAs9pI2cPvJOvWbn0DhujH4hnkYrkHKQ5Z/6W7k4HhqrpQv2/IUixTcLtigpO2MEUeFSmj3ioMlZ9k299ExYk3GSu0srKFUCTQ5vrY0TJKkkvgZmGTHNZrCzNluTkzlRssnThCTa9DnEP5DJv02WPgpJfwscZCWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:52.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfaf319-121d-4c0b-c882-08db3d009605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why&How]
- Implement interface to program DTBCLK DTO’s
  according to reference DTBCLK returned by PMFW
- This is required because DTO programming
  requires exact DTBCLK reference freq or it could
  result in underflow

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ea753f8fa175..2b8a81b6d53b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -233,6 +233,32 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	DC_FP_END();
 }
 
+static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
+			struct dc_state *context,
+			int ref_dtbclk_khz)
+{
+	struct dccg *dccg = clk_mgr->dccg;
+	uint32_t tg_mask = 0;
+	int i;
+
+	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct dtbclk_dto_params dto_params = {0};
+
+		/* use mask to program DTO once per tg */
+		if (pipe_ctx->stream_res.tg &&
+				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
+			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
+
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+
+			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
+			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
+		}
+	}
+}
+
 /* Since DPPCLK request to PMFW needs to be exact (due to DPP DTO programming),
  * update DPPCLK to be the exact frequency that will be set after the DPPCLK
  * divider is updated. This will prevent rounding issues that could cause DPP
@@ -570,6 +596,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* DCCG requires KHz precision for DTBCLK */
 		clk_mgr_base->clks.ref_dtbclk_khz =
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
+		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 	}
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
-- 
2.34.1

