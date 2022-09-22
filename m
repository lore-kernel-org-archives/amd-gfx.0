Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211F6C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EE510EA07;
	Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2898C10E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3H/ZiCDZ0Z5D2ZPvcMtDoYdF1uQE34aiI9P5X4yAiHtVhcyB7l4aOiDphVxFUSMX6Te9mB3TRx3jIwKE2pdWLjHooE+IM8PpR7AWqmEr+Q/jqElNfaiwl4UTO4WENFsQOr0OBWJdflKEvqx9culoOiVjytyInJ6mINsUpeOSzDaNgyc8EYKYOT1x9mnO+gvkT3CprYYYoGySiHVKYtqzWtNWfZWy49W+OCAqXe63t+Mx7Puaft7+JsHst9zy4g4YuElR5J4owHEpQBHA1z5FPNaeb810+zLPADI+4f3DJDqJO5p4+K10bSg6C7mU9Cj1slnT3xHNNJM8mqqSy9IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWsHa8GAPi8LSBVa6Libw/WQUpd2Fch+rqsh5SyXy+k=;
 b=UhTDkck4EEkVqwbl+82FbLbmTHufl1BNH6DhOU38BPTmwPVdhPTnYIN/5bhOr4p8Pq5GJuV7P/QfXA1kFm0Zc4z+Rc6u35uChveGy68WYOgtULBhL1DSEv13pBFsiQ07XP+FVsfPHGykL3/ioFrdr9d492PkpEwpHtaZbMT72D32rbmV45N/2UX8WoC1CFlPYb9PLxybv8vIgb4Ao8h3b9qjvwC1uPas0ol3WddkiCYGI40aOSwR+g0tNHiL7QM85CHrZn7UmhXOLPcTfqFy9TIOzZJ/9sboU/3pG8DXJ2QS+UQ8tOGWgxyz8t9hxPtecAbIT5tLKQypymFJZK1znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWsHa8GAPi8LSBVa6Libw/WQUpd2Fch+rqsh5SyXy+k=;
 b=nVGCQZecCiqY+5uhY5NTZjc4F+qgdqtFXVCfa5MQNR1JNSWpp55oiBQey4ZCQnNQWfqIvjpPWLdAHrHSNBolGxkh/SzMYnXfMPSkZMQQ8kNgEpLg0i0ZpfF+TCOkdUSMefV4SsRd1qv7C2XCghrF/OOTGzYpeq+YZGBcbibrAwo=
Received: from BN0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:141::29)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:19:07 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::14) by BN0PR07CA0027.outlook.office365.com
 (2603:10b6:408:141::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:06 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:05 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/31] drm/amd/display: add missing null check
Date: Wed, 21 Sep 2022 20:18:03 -0400
Message-ID: <20220922001821.320255-14-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed10989-5a2a-4eb1-a4d5-08da9c30101d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eBjdAxtDI+fuA5nAWkRXKfhLkqpGr74vKDhi6Sku634a+4T6Evo3BDIw00FHHRDmRmMUwt128tR9hL8DWmVqmsXh2mnUV9QqIGUTivkWEJw7PLMbNR0TsxfImhq84AU4kVwXIpj3Xen07O+Zi1pTtRcr9C8r7gUmXyUx0RJD5BrN1BIgtKj6x1MXgDrfPaugdWVwqdlbNEW7Ms8HZaLl+m6vo6hcACwp9dCIrKKPVmvJEwUzsbHHaQEcnhyRoKXTgD0aKkWcpryGB/XWA1YMj52vTUwzKr4aDGQTv9rYsp+LBo3ciLzu/dQS7cFAOexY03n8esRZ198U6NWncEsPLg67GBMr6RYCKWPV841GFvh5UbhXqZRiOpdPxvkuOCeSf8PJ8851/pkq1n1UC0CUv9v5Tp0NOFM7glJvgm7kbqA0AvP/G3tLMzQFXmfn3TXALce3Pv//eSUVYtpiPWiwBOrGJxOhV633CTAUnvotZ0B5Hw6LP/KPUgqcGwW3oi5jjpdP99k+qx3gB12NmTVmFrn++Iba0JSEfiqej0+ZRW/M138hIbVIM6vtQvPCEyG/j7YdLvid20rasrKRSpCgXog1edeTa5YRseuLfv1xh1wggaGSO8C7fkEL/VC3XzN+NzVHl+zgOwLdMVq2NAGGSpiedQHkYODDk/oYqgI7HYyx4vhiy9rYmQHZO65P9qQVCjkZ0/YaimaYaBKAf6GHKi2U67C7LCjrVo9V4wzBz/KTWQz5+xcMDyDKCY3V5ZvHZUrQiibQ8cWR3YrIX/U8zp+F5w5YlNPjV1JiLx674BP66J1wumS+hWUmuEzmaff
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(36756003)(40460700003)(82740400003)(356005)(82310400005)(81166007)(2906002)(5660300002)(336012)(36860700001)(186003)(70206006)(4326008)(8676002)(54906003)(6916009)(316002)(8936002)(70586007)(41300700001)(1076003)(426003)(83380400001)(16526019)(40480700001)(47076005)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:06.8306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed10989-5a2a-4eb1-a4d5-08da9c30101d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a coding error for a missing null check for stream pointer when iterating through
pipe_ctx.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index ab47475c18ae..133bc4085c78 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1289,7 +1289,7 @@ static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 	if (link->phy_state.symclk_ref_cnts.otg > 0) {
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+			if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
 				pipe_ctx->clock_source->funcs->program_pix_clk(
 						pipe_ctx->clock_source,
 						&pipe_ctx->stream_res.pix_clk_params,
-- 
2.25.1

