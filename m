Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F73C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC1F10E47C;
	Wed, 14 Dec 2022 20:22:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA5910E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdt0sCjnDrM6dN08J/aNQXyWPS+2SDHkycpFVoZF24lw6EZEvam8qA9ZpvQMUX6g+6ZUhvNXHaB7M8YN/4BTVTf5CEmAV2a4cVTWtvqxPS3EuHvdGZimPle13PnJboI9gMLmqw5xMDxMtRjF1wDdo/vEMidMQQQAE4TwL++Xw+upLJmQCYzgZfLuQT9xCc8QkZXEy6gpXnftw73nTakeVqe/0xzk3e3jjkEwB83uAmexSsXTvIN3lPCzLmZVNKF8ECG+tSRWXulxHBOS+1LSjhMPjQkXfh56xo4AyiWpH7WiGsPRom045G8ZQ0dF2J4n0zc+oe3z9kpyuNwvpQnoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sv0FJq6b49KUzt5ssJ59JOwmUpSRMnyue1rQqMGj6A=;
 b=TISExLNEUITbGM5RAGCJNqAeKv68o9NHA0k6N70ZYDkTM2ZUkfufySKlVXlVPhj0fTZ6I/MX70xMth5kOsw8+4qYjFg+jEs7L7U80vKHa6PnPxY1HX5DYszX57g+mbArx46k4g7wlKYkidKumbceCccScndZoeriMuuMT8B+QHOol4SFQkULKaslPgKG9SpgUaHW/6WFoa2x7KqlWoYE1uT+r8PKkEczYgk9fON4QxmF0uPgpYwoNtfDRds83o9GQmGh4mWUZcQpVELV0tQyyQhTzJopkQ4Yqx09H2OHoQ4WznvNPh4U0g7iSWEEaNo/6DWi5Rqm6uhE2De6RWC1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sv0FJq6b49KUzt5ssJ59JOwmUpSRMnyue1rQqMGj6A=;
 b=FSPEIlqCcG0PndLqot1XJxtAxhER8ntSl47oBZSkA7uJD1hKzGuwjvz+x67vDtXE6vIRYj8b2VlduORxCafLAdTjwPZBL41FY5gfav2Fre1HmmlvjcCNxSTlMPFS68XlJaPO2LH6FXywsYwUQ6AIkJr0MK9edWHs88jM1q2N5t8=
Received: from MW4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:303:b7::13)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:22:06 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::69) by MW4PR03CA0098.outlook.office365.com
 (2603:10b6:303:b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:02 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:01 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/18] drm/amd/display: update pixel rate div in enable stream
Date: Wed, 14 Dec 2022 15:21:35 -0500
Message-ID: <20221214202141.1721178-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfb5c0d-b94a-4d5d-73a0-08dade10de70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCFtnMhG4BcxkoHIUVs0p5ofx/5fQiDbjlR1jpEMp82QQX8o29mLRHLM8U3GGwJtpJ/qk9PsEYp2WomU6634+ExYbbp8/dVxUEM/Hfd8/vrw5mKOtlQ6uMzuKyNkkIvSVZKbG+l4cTw1qXKciXr5RMrXoQZX8arztYYYMdOMp3pyahoBwlUCchqsVuEHb0yyNoatFBtGdYqMseKa7nvY8ucKd55JrNqFPqKDUd7STImRpQb2I6jpRn9tAZH3CKIcEtA7wbsjSZs3UARD+NbJCEyQnZP+eWZ93OvoVBS9AsXULxvgCnLVyz4+zwwMk3EFbIq3/k7DFPF42QguvlsXD0z9xSlkgGoFeT+DLewe72oi6IuPDYxIqhTYXAKXTN05twlobjrRECgG/g6gGpSwa738Kexb5YYbTGdQgDTBnKYvu39r7HfNoYmr9FemfkuVLZh1IkPSgkjasIWoLr82Nx5pHcOsAn+vjCdpfTbjmjV6NVoLbhCnIj3Msl1lQatyYhhmIcdtarnvxTRCnykYumd/yiDkL7YK9erEFIlau9HuQUC6G5F99HPKGV3ildv0C0sjA3TYlUqU7dC7MYr7+Iows/cpOgoVj4dL7p0+oOeUZbdiEZx04VYGgO/ywx3M7AlCcn94wuSZKSbqJMVS4/SR4b8uW40+yLKuXW1D/Q43hZYuztNWBShcB15majLZlCAez3a5pztdk1bFCqZu8GQite4QKOhZwGA0ml0D8Og=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(2906002)(40480700001)(426003)(336012)(1076003)(2616005)(36860700001)(478600001)(7696005)(6666004)(70586007)(70206006)(54906003)(6916009)(4326008)(5660300002)(8676002)(26005)(186003)(8936002)(356005)(41300700001)(40460700003)(81166007)(83380400001)(44832011)(36756003)(47076005)(316002)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:05.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb5c0d-b94a-4d5d-73a0-08dade10de70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Pixel rate div depends on the type of encoder
that we are enabling stream with. If we swap between
HPO and DIO encoder at the time we call enable stream
for the new encoder, we must reprogram pixel rate div
based on the new encoder type.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index c81b70c7f3f9..20c85ef2a957 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2687,6 +2687,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dccg *dccg = dc->res_pool->dccg;
 	enum phyd32clk_clock_source phyd32clk;
 	int dp_hpo_inst;
+	struct dce_hwseq *hws = dc->hwseq;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
 
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		if (dc->hwseq->funcs.setup_hpo_hw_control)
@@ -2708,6 +2711,15 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	}
 
+	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		dc->res_pool->dccg->funcs->set_pixel_rate_div(
+			dc->res_pool->dccg,
+			pipe_ctx->stream_res.tg->inst,
+			k1_div, k2_div);
+	}
+
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->flip_immediate != 1) {
-- 
2.39.0

