Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF6C25B07
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCDFB92CD;
	Fri,  5 Aug 2022 17:59:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DE910EF47
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDClWor64lCyXCN8JvCLtOywPW6+PPxGMiWd3PmxD9slcs3SdZv13cOKEboQ5/JIdCK/TCnOmIrldtyoKNibSzrF9euyxQgvSxBUwVKtG8ms5mNd9kpx+ST+wZHtriVN3Xv6rjFb8dgYogaqaanquEy1UFD7ExySFVbJ+M92cCs0WTvjY27zkjDJpEx5lZQ/wVYGZFJKoe3h86xhaNgTV0UbuoCoPNbc+Km0436D2vd4Dxr5026v3tVGPqZjwvQo8Rngrr6MIWHgDcu+zKx1TKFC6J3pCMJaftQeVbEBWBQX3euldReCqKv4cxRRAgj+6ABllt4Ad6fccoU5mU9ddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8krQukiaUq156EWjt45BTmR8uFcyANC6uevSxRnZYTg=;
 b=E9B9cVGJ2ugUeg3NEPV4d/0YYhxFrBgSVOhKm8j2HF0CWWzxAxc5mZTlYWAIEjkfLwdcuV3ZLxDTogdGdunSvYQ6tF+89s5tXZgX2PIAiGc6F2jYxYELMk10trX+7eeatx0DviFbHhzVbF7gcLe/plGPhGvrFVvk3A2A8m4mYCHfJnmgaLQqjBzE4tesa1oxOWIr3cAGVFcYoDO0G7Z+WeIbPgkpwrAxQ7CPiIHZLUL5lL5+cjodLdtvQcOqc1hhYL6bIqql/Dzby2KqonE9626TZMJpU1nmyyetOZkCt3ZJkvyyMYqtRVLzydr38bB17MovXhE8sZxjgk6wlVggaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8krQukiaUq156EWjt45BTmR8uFcyANC6uevSxRnZYTg=;
 b=p7DdJN0u/g02b5tF6dDYawy6NphnQJZIh5yy8U/gQiipL/NChMzdxsgf8BoVz+f6ChotD9mL5+/nhCOuqqu8jyJlZ6rlsQCpH5ltY25N1IyCW7mNWu0C2qKhuwaGWlYN+pncbG1Xu1w5yGCcs/F3fHm8UNFQC9eG0phF2WmpJWs=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
 by MN2PR12MB3072.namprd12.prod.outlook.com (2603:10b6:208:c5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:37 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::6d) by BN8PR12CA0036.outlook.office365.com
 (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:36 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:30 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/32] drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption
 issue
Date: Sat, 6 Aug 2022 01:58:03 +0800
Message-ID: <20220805175826.2992171-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3519a2-68d6-41d6-8cc2-08da770c42db
X-MS-TrafficTypeDiagnostic: MN2PR12MB3072:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoZTxPsLTMYAbgkDUxdBLXio9jPkaej++S0iPiIgfDmDet9xc/uK60k2+h4LemXAtHJmxPnY7ob3cARf6iu4tGxVMVIZ+kgiXWOT8ue1aqLmwqJGVOUdkxn4LpTX5LH51owFWL/9SfnlNKu/Gr9kW0p1++nj8taXYB+WC1Ist+uHZ44HozyY22FQBCBqoybOuRO6iPpZtNidcDRkX3uZCPuZO+VGrXjw5UYjnQut98muB7FS858yCCpoi9AQUjygEnkr6jQv904Ep2fHf0B4xaUUc/TS1tkwjZ9VlBuL1KzGst+ImhFVXNBO8tz89lTDXTBbQaG+SVA/hHst2F6fdr7myE7QnOd/eD1sR/ovy0i2OSmBhnNfqKM4yTlK2eyXQfd57C1ybz8InsAFmW6oF2fq2IjV5abay5L88sTUKT+60EzWTg0rL6bM3Edg1DbWRTtfEYvTRvO0OLa9f1/2mWkyGV6nOCPTz/XVdzrK/N2NG1TlOgDz9MuB++ccJPMhSxhZepByRaKCRLbQaNP5c0JY+LuHVcZoFiZnFp+G4dZIlFrKZxBPL2PPpaw1krwMfzWPJe7zwvZePkh4TRAiVedFTgic75HqpTuRYUTSQ5mi2DqawMZoVA1S2RTU0ReiGU/EuZqVpFBg0gE6uwPR3KAXnm0PSPMmDeIytoofSLkKV6CGpkHLDMmlyueiMiQM0O0fBkd3imYVT+QRvdMRD81BWtA4OROYpgh79DkLBlJEpWVNR5S+cF+gmKP4Cc22poD5jUHDPdYxY/X7qnIvpm81ioqPGvMHOAcd0A59YYmqq8eUof6kyRqR7jnWWEqjv/PuPXV28xnxKEMkBZazag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(6029001)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(41300700001)(40480700001)(1076003)(426003)(54906003)(2616005)(40460700003)(47076005)(6666004)(26005)(7696005)(336012)(186003)(86362001)(36860700001)(36756003)(82310400005)(316002)(6916009)(70206006)(70586007)(4326008)(8676002)(2906002)(5660300002)(478600001)(8936002)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:37.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3519a2-68d6-41d6-8cc2-08da770c42db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
DIG_FIFO_OUTPUT_PIXEL_MODE not being set for dcn314
resulting in incorrect timing for YCbCr4:2:0

[How]
Copy the implementation of set_pixels_per_cycle from dcn32
over to dcn314

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 28 +++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  4 +++
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 452f4a9bf251..39931d48f385 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -374,3 +374,31 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 
 	return odm_combine_factor;
 }
+
+void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
+{
+	uint32_t pix_per_cycle = 1;
+	uint32_t odm_combine_factor = 1;
+
+	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
+		return;
+
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1
+		|| dcn314_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+		pix_per_cycle = 2;
+
+	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
+		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
+				pix_per_cycle);
+}
+
+bool dcn314_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !is_dp_128b_132b_signal(pipe_ctx) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy)
+		return true;
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index be0f5e4d48e1..d014580592ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -39,4 +39,8 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
+void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
+
+bool dcn314_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index b9debeb081fd..fcf67eb3478f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -145,6 +145,8 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
+	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
+	.is_dp_dig_pixel_rate_div_policy = dcn314_is_dp_dig_pixel_rate_div_policy,
 };
 
 void dcn314_hw_sequencer_construct(struct dc *dc)
-- 
2.25.1

