Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13C0EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB2210E161;
	Wed, 14 Jun 2023 17:58:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0275210E462
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS10MHmkRsaoPzaXyQcZMCFzjcGSMQ3n4baqPZ/Kr+PpXrHpuoc1AFpH/h3xOcqvnVyHNz6RHEayX2uIqJz6hexJLxKYviSu9yVaH53WWEo8TUyybLBcm/gfHXW1peeb7tat5LqMckfG6ynmWGjHg5+g/WTM9d8XR4CfKx6e6RbBnjSc7zZbigZ6AT+cIA74tXpuGhAxNZip2eFOd/wlNbl09jwYLykV4nb0r5HW7oKxc3EufzM6SyB1VGchBxrOBAywzHPs/2Q4ygQl5gXjnRjUCB8J+Qsr7kzuCqqtZ6T7Pu+KxASm0yNwivodH0MNeTJ3BRaOqlaaNxI/qfhn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cov0l21uvfZsnjJVSFnRAHRErgcF5S5SHg4PYRXEyD0=;
 b=CVfFEoKeVbxaHKmAIjCRu29UgpyEWkgB2zCuK0D1FMawjxlycY0T58vIzhgKqbSa+uEL5U+bpPt3c2uMAL2twmDH7DlhXQLKIsREkcAEmzv/bSLk+qnOWNMa+pC5/yTWZbIoud6hpdLWR50eZMK2lCnKCjgWdm8F/8bsE/6RZeRDjvfIfiPK19IUhDR9BQRUB994JpIGtp4FxWYxRq1CaeT1YoFYSMjnIdgzSYiVeDGXP5oxQQbVwCt1CjjUeo344mY7WyaTA22oHkuZ8yUYAtDhK2rUnozBtUivvuz7DO1BkjHjfKrhib5YNmFA2vyLEMBK6IA7BuVfRZICrx/rUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cov0l21uvfZsnjJVSFnRAHRErgcF5S5SHg4PYRXEyD0=;
 b=zM0cQZEHdXN/VWkuTpVh9lm4x3hTJMeR0RZ23GiBTvs2g4BgPVnv83o+0HVtQcVL31bC+n5DjlV8jAPUHGMc6SAgZumRPNb1ASBnprWcgCGHatF3BMwSjonUO11qFJ/Ig/KgbAY59Rvf4RooLq+NurVbGgZNMvQ3VxUou6WjMYg=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:34 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::f4) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:33 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:32 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/17] drm/amd/display: fix odm k2 div calculation
Date: Wed, 14 Jun 2023 13:57:47 -0400
Message-ID: <20230614175750.43359-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e03e3-0063-4333-f530-08db6d00f876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDTz8/A8gii9Ht7KDW+jH2I5zEHGz6OjmFrKTuPZhjShsZEUaolu9pm3Zmfw1RJ067qYoloAWUn3q3MSIoNjp+IZip+Pz48LfmCaGu7YXDdjp1N+GUT7KWC+Q0vpipBMrafm+LJ1YcLQOOlfQB8ErWW0C7LJhJiqAwAYOVRuAxQXCykLgGOnbuIu1PrlJpgojEuJ05HcDB8bmp2X8TLJmiWCjy1vX5C3lE2lIl0YZ7RsP0NHRnKRK4rH5aPGqlOxhFkOx+S4h0hmwvx7EMrFO2lLbMFCz6xN5Ta6NP83qMGSuAqWPt7gIodUMbINIOOuw/ENf4NsF9H2zKexOgNWCws3GTuFbk3eoM2qAjz+V8QzxI9t6Z3RSAP5k+OIH8K7YE3p3GLnGTIIbZAXXQYR94j0dYqvntb5ILLlo8JqnjYATMMlV+jDxV/i9up+GHBbqRMzrdUfJHBEYxYX+uKjbCjHMRaFyOJ9YXEFQIUsABslS35/oviTq2nwuh1EX8s1XSVgPKoUuZrhLMEkF+1V4o7bo/tgVM2pSb4YvEtAqZoJzCoQqQUtohjWOg4oeAJnE2i3Aphms685/kb/p8mhFNkYxIdDrIIyCaaONbqx0FiI6q5FoczPtpYiRHddNSzXZCZ/S9LqaOlz9rwTcrC4/5SC9TNVKYgcssCkgPwUM+K9M+pWOqMtIhhnjsgaEAZZeR/1Ph4CA0//3FbJwfgR7SxRWcFxpwI7g3VmtaSrxJ15grOtUK2Inj3clrrHpw6j6NdyXNoHblNKp+q5YKkq+W9SH3qejrT+3o+XFpDbDP/eoFb1AoChBb8Ataw5cJo4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(70586007)(70206006)(54906003)(478600001)(5660300002)(8676002)(8936002)(6916009)(6666004)(4326008)(40460700003)(336012)(426003)(41300700001)(316002)(356005)(82740400003)(81166007)(83380400001)(44832011)(26005)(47076005)(2906002)(82310400005)(40480700001)(2616005)(86362001)(36860700001)(186003)(1076003)(16526019)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:33.7467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e03e3-0063-4333-f530-08db6d00f876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Correct setting is div by 2 for odm. Seamless odm transitions
are enabled with enable_dp_dig_pixel_rate_div_policy debug flag.

Fixes: 252e0b122f50 ("drm/amd/display: fix pixel rate update sequence")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c     | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c       | 8 ++++++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h       | 2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer_private.h    | 2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 32a1c3105089..4d2820ffe468 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -337,13 +337,14 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
-void dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
+	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
-	get_odm_config(pipe_ctx, NULL);
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
 	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
@@ -361,11 +362,15 @@ void dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
+			if (odm_combine_factor == 2)
+				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
 
 	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
 		ASSERT(false);
+
+	return odm_combine_factor;
 }
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 3841da67a737..eafcc4ea6d24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -37,7 +37,7 @@ void dcn314_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool po
 
 void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
-void dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c586468872e2..e5bd76c6b1d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1141,9 +1141,10 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	}
 }
 
-void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
+	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
 	// For phantom pipes, use the same programming as the main pipes
@@ -1151,6 +1152,7 @@ void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *
 		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
 	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
 	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
@@ -1168,13 +1170,15 @@ void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if (dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+			if ((odm_combine_factor == 2) || dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
 
 	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
 		ASSERT(false);
+
+	return odm_combine_factor;
 }
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index bf9bffabe0c0..2d2628f31bed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -71,7 +71,7 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
 
-void dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index a151865a3a20..4ca4192c1e12 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -156,7 +156,7 @@ struct hwseq_private_funcs {
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
-	void (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
+	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
 			unsigned int *k1_div,
 			unsigned int *k2_div);
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
-- 
2.40.1

