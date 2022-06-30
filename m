Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138C7CCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F4412A882;
	Thu, 30 Jun 2022 19:14:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F73B11369A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAalDG/Pdpq8jRxtDtHxWlCbdOtBHVdlQJy+82PXtNmmprTgHKn6qP25mlhJBvgGsT3xQ05gzmoB/Usg+25bUw6mZ7QC0eOoylm3r17ggtYYFQvxc9DAUihGJ33Oj8aE1VRj7OYgABNgYjlQ14LHgTAlv8BktxwhuiAlTwOIsqBU1VMRvNHPWZelrGVO7Q1kmDriUS24emC/5Qigttjd98K6uufFCSbJ1kPmygXVT0BZprMirholCJrBKZXubTg/hcC1fOJOWA1Hx8GH4cEXAYgf8oNQVJux4nXZI5HYF4wAZ6MYPakVbs53BrLqW4XeodafWoLkymW3nwPow2mwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwcB6gM3aiJFs7enXkWPxzsiXiTmwlrKbWey5Jc/htc=;
 b=MOoI+ccqYxlp11a98opUdiN1RQ9SeSUFIJsp9CF/Sb3h0iwqpHa5Yk44BFLrBRDBhyR+AZCVP56L8ZE9WkNKAgbyzK+kwMMIUhF2pziUw8X+dTv+tZId6FE2C4S1EhLvGPB4Zg4dNzH3TIBo9sPvU/nMM7hnaZqF+p7lg1mPeusLaIVX6uX64iaMZq9zMXo45w1ywTeHOzM0g4eD+6DwzHWZZFAhNvHmRkvyNjiXk0Hlp0ft3wV9YEmNmQermp6Chcw4n43hi6oCxu2PH2RtwyclHw2yhSH4XwTRHipeGS9V1SjlJ6NYziasbXNwpqsm4Wo1XkBX8N4igfHUsf71sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwcB6gM3aiJFs7enXkWPxzsiXiTmwlrKbWey5Jc/htc=;
 b=x9hqvLQtrIAT34sxeUgL3cqzhv9W3qodXyuItamqOUyOVwh0b1+YRlECHjR5sgiPE4uAi2ibYfM3scLr/eBn2Q1p/O5tcKk73BTY5hijcwvYzSJq5mitZWZBz85viuK+RZTUPKLgvNPRqHp0aLplDHTVdvDF7O+Xu4MbzzP8slE=
Received: from BN0PR04CA0170.namprd04.prod.outlook.com (2603:10b6:408:eb::25)
 by BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:13 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::9e) by BN0PR04CA0170.outlook.office365.com
 (2603:10b6:408:eb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:13 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/40] drm/amd/display: Remove incorrect ASSERT check for
 link_enc
Date: Thu, 30 Jun 2022 15:13:05 -0400
Message-ID: <20220630191322.909650-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23502fbc-6e70-43a2-7de2-08da5accb7e3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGZoF6muSKSK/TwLaOkb/Ql1R9O+s9onBdnzpESmX6ZxtGcaTX8mOSjWqiXDH5kc++Ii8QQPDh/X+42/p4igSPAJu5NvLllWGf/834FKpica6T9h/Sbk3e5FDMD3QO00vUTWJCwPzzNge620Mho+wQToP0xZAj6YqVUaTRB7G1BMHtnc8F5uuNl0cMZcuTmOZOukvgA+IT2tihQkExsWdl1DcfoXLWV48/OzuWRYShvDFZ5cOmy8brb5fBT9xDl8le0Rg0m/+WQAtQyUC10pBqyeeg1lPiYP/qSrRryRXszwlOc0nVgLQU2FvZI29Y7GrmZFGWsaUs+fQkP/yS2eJJpOdcn2EuLqWhdQovlJA8s9LG9cVrCwXcb8BLix1UQ5narBsYOKvdJyFtmI0gaLXkd9+XNyP1WlbAoNCi61qarh4muZpqNXZeFChYmmq8jfVvzR87r974ovnnUDaMsZEs5YVCxpm3YdxdhYicbsE3klhL1Xa2p2FD/ltlCYMiOitxHEsCB4sKgtzQKyQAQmmxPJM16NrQijxk0a41NDlIZ04/ozjREaKNQT6iM7kLYPlHj88JtVo8a3DZZQs8gRDwDBtvtp5ewX0+1fAaYyQSN8366BLf+fX4DKYOE6duiNCQTguv5ZBKLNIpBIkWxTepiK+gALhZPJouYUl9ZhrdEeQWtQ9Y3WWGAtchjTTfj1Gk1MhouRhGa4sz7uaarPxDaoeCJFCsH6sexqxvmhAG+/cnCl3crkLjaM5+uyrQuWZ4l3STcBv95BKC0S0cbShJs+6yGockyzrnbdEK4bBJRApMCG0/nKIZr/l45GpMfcSCrhcc5Zmc7zv7LqQVMGV0GsYSMzrpqSojfR5XhS30I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(86362001)(16526019)(26005)(336012)(70586007)(70206006)(316002)(6916009)(8936002)(40480700001)(47076005)(7696005)(83380400001)(478600001)(54906003)(41300700001)(81166007)(36860700001)(8676002)(6666004)(426003)(82740400003)(356005)(2616005)(1076003)(82310400005)(186003)(36756003)(40460700003)(2906002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:13.0689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23502fbc-6e70-43a2-7de2-08da5accb7e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <Michael.Strauss@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It's possible that we don't have a link encoder assignment if the
context is NULL but we're calling dc_add_stream_to_ctx from DM directly.

Link encoder assignment will happen later after global validation
runs with fast_validate = false.

[How]
Remove the ASSERTION. We already guard against NULL link_enc.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 0b1ef76e3268..a0a94ea58a57 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1246,10 +1246,9 @@ static void get_pixel_clock_parameters(
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
 	link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
-
 	if (link_enc)
 		pixel_clk_params->encoder_object_id = link_enc->id;
+
 	pixel_clk_params->signal_type = pipe_ctx->stream->signal;
 	pixel_clk_params->controller_id = pipe_ctx->stream_res.tg->inst + 1;
 	/* TODO: un-hardcode*/
-- 
2.25.1

