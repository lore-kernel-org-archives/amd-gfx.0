Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D904ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2AB10E81D;
	Wed, 14 Sep 2022 03:56:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E728910E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNp8LRyNBOw1AjF476aCHzLHDk8akzAq71htk445R1P414d3VIQchYAxPgDPAgS6hheTakiJ1GxxztXR0J3s9T653YbLK/eCXsbc7vIj+a1vept1kCqqYslIwgdE3lX8zrplx7sps5M125vxHk73cwKNQZyONaRdoJkmsTh3d0DVCZNfakNAvnD1SUdHsfuFCQnpl8MXRnzWHx69A8aIdfBhaeZwRdXbc08TS40XShcRlRiNRnwSqrCErmNoBdwMpd7i4MsNuE4z1LP7cHo1XwSNEUu4//ipEvx2reLjg7cGFBTDJPm5PPVv35iFfW1NTPVQIiIh55mwYKZ6DWmkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxXoIZjR0MG8hoA5R2lrcy+ti4Zfe0rP1tg8BCv5dCU=;
 b=fHjuUm3IyR756/vYxJkhGag35MyuxJ/XTFaSXEbMSTNB8i6dP93KFdrLF/oczlpzK5td+ur2W2vCk/RmVAFFixPKxw0HfJi3VLKAgV22c2iut7/ONdF/ZigQjH4Y0hsFCcGGZy7id6nZghqGgo9V3+zuLS9aJ5dyz0BWKaCcxfU9DCgHeuN3n+HjeXPLs0CXLqFxLkbewQujLQii9EAxXCHUzi00rHvVwbrbBtiiABZByKzNLmsfUMmF8HRcDCuGYGI83ynI4AuntIHDhELv/4AXnLSvfR2H37hygjkGHuCvpymYCwj2R3nwJN3gtVUAJEO9BtFxViiGNStxlAaz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxXoIZjR0MG8hoA5R2lrcy+ti4Zfe0rP1tg8BCv5dCU=;
 b=q1G+y0+JlkgDGfSYE+QDPaSipa2rz1TiuK9Yc8TNYc+5F2qTaG7NajYpeNfpGu+i9/McuAkQmWePaOMEquj0ZPUQL8PYV6nwCUsFNoaBt6mgtdWzbxWwxn6MzBrI8vgJ7VXkxXZHIkytLe4ss9hHKbIJUZmUQ0nLtk9BNOGlhPw=
Received: from BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:56:04 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::20) by BN7PR02CA0019.outlook.office365.com
 (2603:10b6:408:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:56:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 32/47] drm/amd/display: Ignore k1/k2 values for virtual
 signal
Date: Wed, 14 Sep 2022 11:47:53 +0800
Message-ID: <20220914034808.1093521-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 7285d708-2e65-4667-5347-08da96050bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR5ivPKBQpQYMPs3E8KNk3WkyUW2Ny9saayrPwfOjHMXsshjxHBqmDWx3VCGpi1FmOUsdPb6ClnYpJkRPAxajIRjNFkFvIFIPj2ihLHNxTfHn5IhKvRZb8vvv1Lw7qIaPa8j8yuSk10c2nz01lv95TbI5RlRihnfBwhNGnrkeSaSOS8WGrwyvPhtIcTcSKloKbdCKWC05ntv5avzRoXjWMnrbsSMENNuLDZ1rXgyqUi+ifnUC4bt5mPCrO91PnPu5au5wEmYx2E3xhfDhI6ppqvIVBaOYCUud3jODAliqTyyVB+9JpM7uXWbKdGZXe8fG21uRcOkJJE0T7O2mVkukwBPnKFdMflpE6BqEfnJoz0wkpE/e/t060/nQN0ipevuf/OFp3uUH4GOd43wzIpSUp/uuWkR2KPHBOYvOzOEk14AEgZ0DikrZMHBHDR7FZsVP5AdN2M/dFUMU+Y3iugAWvYslbBv43fYB3AT6aYTMmGLNyBv0SWlb391p58pVjRBYWby1cfEe/TIw1l8sg01T7S6aKawNw6/DfM0heOMgi4fjIjNFjDCZ0SG08OqW47FETfxWAzG5c/2CyAA2NeU6YQprYrfGG7kSwr57t00j4V2ss0sbktCHfVYNkmAcYgKKFrjy7zmeZm2pcXvSvbVAihA1pyF2DqY/aDrrj/rK4QpcK5ZWRsWqCu1CxvUBASPQ2eBS+9oG3O9vzJPiEezzNp/+fnYjWE1bEdU9a4wzcn0n50y4aBvyfRBQmHiHzr08rfPnQL9928EbXaXvCfVS8c2YbiIuEQ5N3K8QAVpNh4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(356005)(8936002)(40480700001)(82310400005)(2906002)(5660300002)(4326008)(70586007)(8676002)(70206006)(81166007)(186003)(26005)(36756003)(1076003)(336012)(2616005)(82740400003)(47076005)(41300700001)(7696005)(316002)(40460700003)(54906003)(6666004)(6916009)(426003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:04.2533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7285d708-2e65-4667-5347-08da96050bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why and How]
We are hitting k1/k2 assert when we are using a virtual signal in the
test; as a result, we are failing some automated tests with a false
positive. This commit addresses this issue by ignoring the assert
condition if we use SIGNAL_TYPE_VIRTUAL.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index f4d1b83979fe..588c1c71241f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -348,6 +348,9 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
+		return odm_combine_factor;
+
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 931dcf3e5ada..c1261cb0e001 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1184,6 +1184,9 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
+		return odm_combine_factor;
+
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
-- 
2.37.3

