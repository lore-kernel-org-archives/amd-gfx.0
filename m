Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACC4C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF9D112C76;
	Tue, 12 Mar 2024 09:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rii6dQWI";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D12112C76
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF5FfsFBGOjNfrQDjYcdi1EoLT5y6pQOpHFgQ2IpeRYmS1Rk488/4HHcUD1j1YHcjSrXEt77nkwBJO0phuP0oQ6zT+t7gc9on6+A5VEzEup3DMWTk5Urc2rA6a2mvLH2joEDPbB3D/0Q0DXWJ6rcwOkLrSlPz1BRwN0wbhih5+9s6Ie0jNhTvDLaNipbsHu6dIkUHan5rr5AH6ox6cJblKlssZ3Y/Pe/ObnIVbF4sSfJ/rzBE27FhzWIAIMj2LxDDZtPTKiWNA14/9yMz585E6ZGqf+y30YZaXPdmuGDRWDT8oECKcncxfyU781x2kzBZqr/tv4K0re2YjHh8v6M4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRMfbt5tMyVqqnUwq9W3dCf1IUKS9Isrt8Y5399xsas=;
 b=KH9tJBcgfGrr2Ogeysm+idfKRhvXzSN0l5BhcPKeWmOKXNH7fIh2MQag3a8q6W/g8SApPjJS+Zujt22FTCJ3gur+otE56VEZvu5x6bpdCzRe6126iUeWnY2eQ0cYiXiQSAGSYZH3iWizFH+horC3vDyIGxKpFdVHY/x69xYnfffMTTiwetX67CqyGQ1xjCjluHli0hscsLStJdwntgySvpRtMwBMEMSV1qPTDq8Eyp9qQbtK27GFqBcaPpwa08QwFaA/t94H4Ldsy0qnwgFoCfa1XUatsjRg8VoLi+EToZt/3MRze9r+0nV0GkURzvEnc6jDqMFzIef2NvjcQh13xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRMfbt5tMyVqqnUwq9W3dCf1IUKS9Isrt8Y5399xsas=;
 b=rii6dQWIBmusuQ5jaO3ZiWjGNJuZfSwGOZVxOS2mPlSwwdDdjQ730cH6YN/JTLLsCM7jwCOVz8IrzdGp/fVxLHUzGo15oNZ77HdT/z7qWG7OaKFmptenJ50IlxYP8gmv9AWhlYqxM7WEiBi2/sTnYmOEaNGxgtzpPz6jYJ1zfwo=
Received: from CY8PR19CA0018.namprd19.prod.outlook.com (2603:10b6:930:44::15)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:23:49 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::4e) by CY8PR19CA0018.outlook.office365.com
 (2603:10b6:930:44::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:48 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 28/43] drm/amd/display: fix debug key not working on dml2
Date: Tue, 12 Mar 2024 17:20:21 +0800
Message-ID: <20240312092036.3283319-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: c921baca-ce83-46ea-165b-08dc4276202a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEifMOyRk1Rg054FpUjqcL2BlecktJEc5gVEfWEI5DYlroqhVAg/EYsNGiNEFMN6c0hEGuHUpd3ACkHIdUxtHQJ563xYajYtL5jwP53TEnqMCGjth9my2gA7Fic90g3YuqTtQf54bWOiWAug0C2CQlUD1kVawutr1fsWybxawr1qB9DbmLLZYAmguqQKtcUADfAu3kw6EJv6D98UkxliEyPgzAM4Xj8ODSU+/HSxIA/jFZiVlH9B3OuEJo+dcb0lqExV0+WsKisuRuIfPsP3ZZqLzwZb9IuNi+8b1l7Cj/xBwJHLqQSTP8RW8LsbSX1fLKHxEVtdxzGfJ2i1qMnlXOIWRX4u6gF07n7i++R00bNqhL44KWGcCCCUG7ZPkFDd4jdreB2/t3w9e4VGw8P9i2sQJcOIg28uu24BmVkntEXHJ32TZFDHE8XhSEAXJRACuUMmXNA7RWyOWbmY6gfKDjtF7WwfCSSDckk/nvXquaQPBnlm0P3uGUWwFeIq7WJzCwR/p7imYoNAdH0Xi5HZgb2Cb+WP+MSCAm5RlqlPO0X24Xa0bSKHQcm7JmPbHARovGOvmfmNQobwwEwq8vqQTW7JPeVpQP39teSKabbb0pyCNzn7wz0Hza6UT7XF1At5Ao+SocLhC11lbI2qmzN/h59kt8ZT8e5U9C2aiznyJb74XBRRexpwQzLC0OX+5HRCk0WElzpVCaegPCwQXOEk2wsHFo7hp6WXv95WLYmylEkurE7im4jiVVNAZblb6g7R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:49.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c921baca-ce83-46ea-165b-08dc4276202a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
need to apply the debug key check for max displayclk.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index f15d1dbad6a9..ac2676bb9fcb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -374,10 +374,16 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
+
 	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dppclk_mhz
 		* 1000;
 	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dispclk_mhz
 		* 1000;
+
+	if (dc->config.forced_clocks || dc->debug.max_disp_clk) {
+		context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz;
+		context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz ;
+	}
 }
 
 void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display_mode_lib_st *dml_core_ctx)
-- 
2.37.3

