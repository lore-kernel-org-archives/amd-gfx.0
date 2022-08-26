Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2090ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F380910EB4D;
	Sat, 27 Aug 2022 02:27:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D56510EB4B
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUgs5srULW9ubnzayGtpc3fk7EDR9NS0HbMN9XEWfNkH4JKulEFJSAYdQm6to02Xouz6NZYb4rFhwWZjTwSmiL2BjI+iKDYr3GQWPy6q4tlJxN/0DlvaDx8Qyr871g8io7rGbsDkhsrfYCWneDBB6ecRrq4jHVaeNT6gr234+Urd2krcWdwbeKDGNq+7rMnxbTBFGHaHsejqgogfHKcIjViXXsK4o58eg69sJuurDLRnZs7BzMkZfwzcNU9Sw0o4ZtlLlRt1LQQaVIkupCd+AeeC9n0BfUyKAY9Matu0AafQ9u+SpeADZoIV3+TseMaKjgNs0zKWCUdKGo63GIx95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKHmttuQzskciWgZDMjW0GTtAjuON64k/Ks7sTg8ZB8=;
 b=cD1H4FgdPF23phv6BRWKVAxxknGzEJ98SwszOVtAItBjHGcyFLjzxYwNKjkyC71X5oUsQjcdhVC0gYezLv2ZYp8AgvF5XiUMFyg3VARwsIeXHy9Cc3I7Jk5i8AJbfQYh5BNcPtIlseCOM4CNr8WIOXYiYnQeu7F8Zw0w2RQOkpJx7me4NChMUSm7gwI3zSbgT4+3/i64qeOI/Q54i7iWtUIvdIXFpYuHVjOpcslaEZ42m5FlDu1/T6R7bnniq4JTJTaHE+IxYEptq63XgU/dOJ9zWP09nDZGMyK9pNZmMQ4aAmfU3J5TDtsNJPTdef9WufkQ9k6TWkpv0B1ACSiZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKHmttuQzskciWgZDMjW0GTtAjuON64k/Ks7sTg8ZB8=;
 b=tknhZNaxx7Cg23H8Rx1qlv6tW3doX144xyPRaUsh8U6Kcyqqs2uIA07usvHk1W2nUFmaivXzVCuKEpcOggsMuyDWkScbU6AfuyM+rgQ8AxFNVLuibdYtitbokLUQwry+f8Gp14tpylekOH9p76cSIphHaExcPdoxU4dAVtszaSs=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by MW2PR12MB2492.namprd12.prod.outlook.com (2603:10b6:907:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:27:27 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::44) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:26 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:27:23
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Remove assert from PHY state update
Date: Sat, 27 Aug 2022 06:26:57 +0800
Message-ID: <20220826222722.1428063-9-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cb926d-9850-4640-dfeb-08da87d3af42
X-MS-TrafficTypeDiagnostic: MW2PR12MB2492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4A/dmUUdC1+htvPNywoCHZz5gJwkWRqS/LCNFiqdFWgS28srLXaU0yqI4gd0aq4ozc8xp/7yECHSbFUJrTP1PzyipAi4iSBR1RZRU0R06AqNNvJZBM96qfgL+HnKkKyCQqOstK55csFeU6BhWT86j10/s/wS0XvqOdIzwmFZjyWkeruMDKZVlY7AIwW4A/nP4wZ2inmQ30yzz1QoL07Ap5TVLyHLrmHmfML5Ml0nK54JleohfkesDvznpmiVmYj+ckJfmiVTp/YzmqMfVVZzTTHD6C1Wfgtj+gugIdJsDbNekU0MC/6hqYjisESO3m5GBrBHI+Tz5R5ee5+iTvE5LoU9omAPdQpcRGyQfY/6f6a6QtyLrKtuj2qXGa3igBbWRL/dQj1/2V4XiZHGkmIyFhxl8jdelpPu91h1v4JJYsVXPFVaib8OMy6HtmfcSiQH5raZ1MCeT3hOGXhTM0v++AylAbMcFM1QQtEiudWC/cuh5pOo2MEpzaB5rySuqL/Fl33sTJb35D+h2maqNoM7lK1XAr6+cOJmA1/VCYcI2tFP2BrqbaaRYPEQ+UeMTxQLuDgK4n+bi0QO46JdwibyZn5H0uIBF9bgowf49b/i3q+iPwpM7Si4xpxTaQMJ0qtnPW7KkutPz2uQyM5KJ/vN3MrYNBENRmHja+QNfnPDu8EoJhQZQXE0QQHRakMEdc3QmKv0ZwCA21nKH0Txe36wakCig492mY2BMBcbdpr3An3EbXcLnRhoXqXVAmeb+AxMsynQJLWccP4q3z2uWhAOKI9JyBlQfgOyPxNFJBrBjlPkVm14lecrEnDwnXrx0Ofcl9vkQMUJVkuI2p49LF0+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(81166007)(356005)(70586007)(478600001)(316002)(4326008)(82310400005)(86362001)(1076003)(6916009)(40460700003)(70206006)(336012)(186003)(83380400001)(54906003)(8936002)(41300700001)(2616005)(26005)(5660300002)(36860700001)(47076005)(6666004)(7696005)(36756003)(2906002)(40480700001)(82740400003)(8676002)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:27.3653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cb926d-9850-4640-dfeb-08da87d3af42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2492
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
In some cases, there are calls to transition from TX_ON to TX_ON. This is
expected, so do not assert. However, these are redundant, so return
prematurely.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 3b1c6603ae0c..b7556111ee44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1224,10 +1224,8 @@ void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
 {
 	enum phy_state current_state = pipe_ctx->stream->link->phy_state;
 
-	if (current_state == target_state) {
-		BREAK_TO_DEBUGGER();
+	if (current_state == target_state)
 		return;
-	}
 
 	if (target_state == TX_OFF_SYMCLK_OFF) {
 		core_link_disable_stream(pipe_ctx);
-- 
2.25.1

