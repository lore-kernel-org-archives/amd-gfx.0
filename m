Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945AC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F92420829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bJF/m03O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F92420829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D176E6E95D;
	Thu, 30 Jul 2020 19:12:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643B26E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsalQerbu0LCRSshqknEa+H+/SnZa+IzqOsmt87D4ViDjgVkauVVX538iG1uSuFke+g4o+NyIGvOQePA9Wscb+Wp+fKq8O4/8WsA0abRIvQrtHm2ByAQE3nmaUaqoJ/Xa/ASE9ur1a1qrK1miaPo6XmrHddpRSGt+g8Z1e67lnF0b/mqrttmODzJUGGmGZlruGuod/whk3KdvgSy1KFg76DUYKxI6VkpHGLUA3jKSML4Xr+38k+lrzU1R2qxLrXelSfW5kw3Wm9VauvwBxUPtavqklmusk388K/ymLsHz/GJ6emLKKaREiL3J2lJ3V9u4QAx4vVQvFjplftKwvfSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5pgWVTaGTyRxwVwHAbMQxzqiNpq11kEmx8KuLbP5oo=;
 b=PqwzRWA57F1z2gUbPg+SbVdsFYHi4fdEwbyCuf2m51/eYGG0waa1XItbciiLQj56gCh/7BeEf40JTWTHQWRTyjPzV/MMahv6WxEzVcWimAGrkj9krH4/BvemCuhAz2zrbgR9NQErhhJwOg8yA7hkSz13COXgn7HCUROFSC07M1nVqP29CsXYcfb8xlk6A1T82Orl8yoz4m7M9aTjZFYk/De7pSZhFD0BRqV349xy6BYnT2drTPNPD7sJszNRgxq+EMeZWG2oKtZvi4HXcrXx8klgPy7ROi6YavCO8hCyD07TKEDKUnr68VdDAMz5A1Q3ZLjamTrBRm+OdIEDlCoJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5pgWVTaGTyRxwVwHAbMQxzqiNpq11kEmx8KuLbP5oo=;
 b=bJF/m03O0LYH+DPbomM4qBrHXySdXzTOWVMJwEkYH3JJXA15LJMoG3W+QDHGAbSHlSsZiRy1t/Yof3pOTWjMcmcjYD88kshrrEy6T86ckp3Y1Mr0P6XbwCDQ+lVZUka5huxkG4JYjg6/7T7iSShs3qEhgR5oZVIO4o0RXC5Vkfk=
Received: from BN6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:404:23::18)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 19:12:34 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::72) by BN6PR03CA0008.outlook.office365.com
 (2603:10b6:404:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:33 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:32 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Change null plane state swizzle mode
 to 4kb_s
Date: Thu, 30 Jul 2020 15:11:41 -0400
Message-ID: <20200730191146.33112-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf46e8d-ebba-42d9-a348-08d834bc835f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42984A14301AEF562BB81D328B710@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zr3SNtd/OLQwnxiPpk3MQJZz92Nk2ukqqjRP73Rwzr4mieewCRQwoZJf7SbeSgaWu1pGcoVv/bGPxD4go7FOTuJum8hW9zUE/G+/OnzBpoVp8AyiEDjRV+8vYec/QsyiC0cdEACOP8kSrTpENuZmCjvGxMTtlat9PyqLYI9LRnsQyfi8jWzTbSVnapPNrBqtu53/eg41UFpShDtLwJd3Mp4E738dVsFSvEWYJo0MVPzoBurmkosC0qsdcAB0Yi/8+MoE5PLEaKwbYtG93CpR9/IGKN7DqMJaUgQYSYP/TsDd1ibyzSHZIm4yFikMLzBm8X5O6Hx7oO49IQsJwebiWahZOFqR/aMVLvSJLzNpMGJF+6UZVFMWK/1OkJpVGzq6q3jyhJktfywKOHMXe8yJxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(7696005)(54906003)(356005)(5660300002)(26005)(186003)(4326008)(83380400001)(70206006)(2906002)(36756003)(70586007)(478600001)(86362001)(8936002)(82310400002)(1076003)(316002)(81166007)(47076004)(8676002)(2616005)(82740400003)(44832011)(336012)(426003)(6666004)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:33.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf46e8d-ebba-42d9-a348-08d834bc835f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 George Shen <george.shen@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
During SetPathMode and UpdatePlanes, the plane state can be null. We default
to linear swizzle mode when plane state is null. This resulted in bandwidth
validation failing when trying to set 8K60 mode (which previously passed validation
during rebuild timing list).

[How]
Change the default swizzle mode from linear to 4kb_s and update pitch accordingly.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2a5e7175926a..790baf552695 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2223,7 +2223,7 @@ int dcn20_populate_dml_pipes_from_context(
 		if (!res_ctx->pipe_ctx[i].plane_state) {
 			pipes[pipe_cnt].pipe.src.is_hsplit = pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
 			pipes[pipe_cnt].pipe.src.source_scan = dm_horz;
-			pipes[pipe_cnt].pipe.src.sw_mode = dm_sw_linear;
+			pipes[pipe_cnt].pipe.src.sw_mode = dm_sw_4kb_s;
 			pipes[pipe_cnt].pipe.src.macro_tile_size = dm_64k_tile;
 			pipes[pipe_cnt].pipe.src.viewport_width = timing->h_addressable;
 			if (pipes[pipe_cnt].pipe.src.viewport_width > 1920)
@@ -2235,7 +2235,7 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.src.surface_width_y = pipes[pipe_cnt].pipe.src.viewport_width;
 			pipes[pipe_cnt].pipe.src.surface_height_c = pipes[pipe_cnt].pipe.src.viewport_height;
 			pipes[pipe_cnt].pipe.src.surface_width_c = pipes[pipe_cnt].pipe.src.viewport_width;
-			pipes[pipe_cnt].pipe.src.data_pitch = ((pipes[pipe_cnt].pipe.src.viewport_width + 63) / 64) * 64; /* linear sw only */
+			pipes[pipe_cnt].pipe.src.data_pitch = ((pipes[pipe_cnt].pipe.src.viewport_width + 255) / 256) * 256;
 			pipes[pipe_cnt].pipe.src.source_format = dm_444_32;
 			pipes[pipe_cnt].pipe.dest.recout_width = pipes[pipe_cnt].pipe.src.viewport_width; /*vp_width/hratio*/
 			pipes[pipe_cnt].pipe.dest.recout_height = pipes[pipe_cnt].pipe.src.viewport_height; /*vp_height/vratio*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
