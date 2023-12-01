Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16697C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5909C10E87F;
	Fri,  1 Dec 2023 13:28:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA8810E8A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkYXVVxn0j1tJ93JthdC0nWN7AXd/IfyN1LFadA1LKDvnaRPZvWzLOfq+KK0e/G3xv2fDwF1ArwvaCljsqK1p22+Yje2gbMTL86zndz9jbHYpuXsknNq1+TKsd+ygMI0IhVbQD+EOavk9uyRq+dIAUtug2aus9mblVS0M4dYmkz5dpD/tZQtTSvzLm3bJAZqa48cNp53dbb/amA94FiAwmuKDC6zAlIxoJDmM5meQbi025dqdufhhhTms/JbviMJI9xByghSzuSQ4LxvdcxX9amWSfumKoKFVEonHngo/myQuYc58sbIpoi2oRrYDtuENKe0eZY+m6JeBhFouyP5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAE8FiH0HrNu0J7Hnb5PWQ0RUOXX3fiaWotX69EM1OY=;
 b=NJf/BfNKSbX2cPTkhkaq+1rvuF7VTFuMF7X0OscOJF1iJs5DbMks3v0ZJg1xAOR0qVxu3rW3YsGV3wUw4qIpr7ispL+PXwf3dHBr37N8/xyLl8SPhcO1k0YVnJGDwOgZOb2L4ZMPl1nRNsuX9TTvGtR0OLd83X8IdwS0IuxIikRq2Bhd8Fy3h2EcnUHgpFaWYZBLhoHPE9RrS2h2MeuiToCnnheHtQ/vFXVkyob892UZ54HNCULIIkd8NCG2uep6l1I1NHItFTGhQ1ASUCfWAJAjWS1Yf7nLifec14l899ZzgHAnI49ff7kFZww2xEEo8sjwmMXcPIchyt5EUuZJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAE8FiH0HrNu0J7Hnb5PWQ0RUOXX3fiaWotX69EM1OY=;
 b=vCjKX2qOUJWM8OKXvHj5AVnt9IN/7j3YEIjORhT4Hn44OHuZmuxgMXxB8GlFuYiH2gMLgTRegzHv8/4K/Lk2yagbgJZ2i1PptjbOxhwbmO2Goo4uUo3KTHb9ScbFe0rGKg+yp0XMuIQUyiZ6fMuYsmt71uybvAuIszW8QdR9eNo=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:35 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::77) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:33 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/47] drm/amd/display: Fix disable_otg_wa logic
Date: Fri, 1 Dec 2023 06:25:15 -0700
Message-ID: <20231201132731.2354141-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 652f8e2f-fb59-4bdf-103b-08dbf2716bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqdDNi/Vg0kXWTnpEhiq1firTcdbeu7IxwgMfnqBWWSdl/VYeQcqxt+cMwjZ4SODOqo0ZDQS32bi6V878HD/p1ihWjjnkxRNrt4rBpoEOXHmF5zqh0aictvGR2y6RSD6O32KGLOGr9I39d/jRPYkZJCUZJ//IMueGQV2IAACBfH6fUPlyB2Xg6Ab+yz+UAn4xTepGtuB+cS4iV8p9Eq93inEUM432ik9uzYerPkS1/cPaI8YexcQ6iBDHj6kuTV0kt4jwFD8Lkg0DG7DAyhxIeGDXMFkNBDnOXCKSKn3lNuW23sR18MF924jOF9dT5M5unVaUqwpw4gahCNo3CTKccCyRLUapU5TDP9QRBqC8kDr4aQGxFKNly30iR14B7uDhiKY4CqOZZ4qerL7S3YBb8l98/3FJa0Zy5yTRdzBzAc3TB8mh6TIJUmRRueUjnYNWuYTPpy6jte3FrEqLB9Xts3gYt0leu85AiadL1dwzEWcCsvLkLY2ke3HHR+9bfTKZvb/LS8JhDbRH4Leqz6xsPhmMMBI8vpUpfVkmcPNbsfqeCxgO7aMjIpL+HgNzFH/wGDXwZ+hoXumIHA2aT1xaRgIs1Mjk/OkLlHmmTCBXuY2YR2LaPtUHJ/eveYboARjU0BLsoML+qF5UWHIJCFKI34dHr7/Y0C0SGMQhMs6P2vZ4KpG/RxNK6Ubu2ComDnrHl1w+NlPdsZIVhnOIW/bGJQ7XansYpTuZkYkqPzY1ojbfU0Z2JXo0BTk0euV0bCt4WXTDlVojGnnarvtDJz6wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(4326008)(8676002)(8936002)(336012)(26005)(16526019)(316002)(41300700001)(54906003)(6916009)(70206006)(70586007)(1076003)(5660300002)(426003)(2616005)(83380400001)(40480700001)(47076005)(36860700001)(356005)(81166007)(82740400003)(40460700003)(86362001)(6666004)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:35.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f8e2f-fb59-4bdf-103b-08dbf2716bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com,
 Nicholas Susanto <nicholas.susanto@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]
When switching to another HDMI mode, we are unnecesarilly
disabling/enabling FIFO causing both HPO and DIG registers to be set at
the same time when only HPO is supposed to be set.

This can lead to a system hang the next time we change refresh rates as
there are cases when we don't disable OTG/FIFO but FIFO is enabled when
it isn't supposed to be.

[How]
Removing the enable/disable FIFO entirely.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 439414ef464a..8d4c0b209872 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -127,21 +127,13 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
 				     !pipe->stream->link_enc)) {
-			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
-
 			if (disable) {
-				if (stream_enc && stream_enc->funcs->disable_fifo)
-					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
-
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
 					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-
-				if (stream_enc && stream_enc->funcs->enable_fifo)
-					pipe->stream_res.stream_enc->funcs->enable_fifo(stream_enc);
 			}
 		}
 	}
-- 
2.42.0

