Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED8EC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411C86052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 411C86052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B63D89EB4;
	Sun, 24 Oct 2021 13:32:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061A189CAC
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+0aJDFFG1LzAL0o1NsSQdF4fgm78WXx19y/VkEjrfy3ETjPMED0oZ6AZsmW2IpLzCUBVsx/XQ78h5TbRnnnA9bmyEYSQsAOlxMJGpB4fAQSZOnaVscaY9Ex7FuJMW082Z7G66924So2OlbANJe1EZ5ccDNwlzrDvdt+/qmZlP0t79/cvluR57C49Jq21UqXyDxkmJC2NUahNpw+HxULuCCUiGed9QisQSxIb1pTROYHKXZkhJVZRSsRe0r0glVayWyrfLXKiwaGTdyYW87kXGdp7STEZexNjDxyhn0aaqw4NySHo12oXgMZW/V84ZHGCR1Iwc+ryz1tNHsuIQMDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQFAn7E5YpmX71CMiTayoNt0WXSV0Abg6YzSQnuZd08=;
 b=coTWwJdc3XNhcT2uWl3JKrUq9f+c0LGRCwVnSWDxX/hOlJ3YHQDsV60wk1FuhEemIRHytMgrwDKt8WTAfp/ovc7NHxFrYiAePEd+Jee/jxCIBndpQae0K4NZrijZlMpOD18Lc2ZnJJbfillEuO7rx1tUiEo4PodAY0SZuhWebyDWMEEQSMBMqhRjAi7BtblzS1ja1V9Cirbmqs4no+Uu6dOFYmI+fF4ucW8I9/b02cqtjzqTmaZjrYpRAHWzrPmyvaK/z0KMrfOnp+RM+pa8VmZ78geP8EfeBBhDdFfgB792rlfyxilKp9/peeB7N0FldDjsHVkcp8vWh5QIAZWWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQFAn7E5YpmX71CMiTayoNt0WXSV0Abg6YzSQnuZd08=;
 b=kFC61zWhltYx9qGdqjiRT6CB39NVK+jTsZ4UEyQGdofEKz+itzBw36Q1Kjm13a9l/WHNkUbvn5+18cH2cFbMwiwjGt8TipyYswnGfvM63NLBsb9MkI99Md7d7ZX3p8AqfwXJq/6GKy3AkhiF0TAbpXSZCCJypYqqckEz+IcH/cY=
Received: from MWHPR1401CA0019.namprd14.prod.outlook.com
 (2603:10b6:301:4b::29) by CH0PR12MB5233.namprd12.prod.outlook.com
 (2603:10b6:610:d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:19 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::fb) by MWHPR1401CA0019.outlook.office365.com
 (2603:10b6:301:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:18 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Ahmad Othman <Ahmad.Othman@amd.com>, "Nikola
 Cornij" <Nikola.Cornij@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>
Subject: [PATCH 07/33] drm/amd/display: fix a crash on USB4 over C20 PHY
Date: Sun, 24 Oct 2021 09:31:15 -0400
Message-ID: <20211024133141.239861-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f7b58f-5cbb-4f5e-9cdb-08d996f2b385
X-MS-TrafficTypeDiagnostic: CH0PR12MB5233:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5233A3B556D8ABD922229FA398829@CH0PR12MB5233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm2WVBbBCkGmV5daw05aRkSyeS8qHQKJjqBqpjPXTipcC0/uOB4alChBxf6WD01HcSrLLAtjIhR2Yyyo9Ka98kumqwhtQUSwU/xZTfwuat7gMmyPwhzq7ZWfnuJvW/Zjtri2dBfqNhPScQre5LsaBwLCO0bynLsQQ04hW5QLWerR9dUT+L+tds7G161nzHZMGnjTxlYb1fA+hJeUCKUtf0FVWI1vZ8bXvUNdPS8IvKHIhCLQuDG6BxQrT0vOv26vwYiWoifORiiNrzrLaYYvKgsYLn8YWOr1WydhiDyUjR/UMRLcFDpQH8wXPKBcPCbe2pK6bvKeFD7tnYNKN5WsAZAITsyqXwdRRY64zOdkR57BQmJCMdbXSr/JzYb4D1sq7sw5l1GGd2E9y1Y9jhbEwTsifGpCiikLly25bmVI4DBE0Y66o2oJHzmKzY9LL19yVrEQPWTz99NZmF9PL42kq9AOmzUEYG93ydsZ+t0Xm/d3cymoTBgwVmNgeNEF7ak1qF7Lx40ChQxFkVwU0+DAHMJqm9SJlOIqeSx8C/UTGkwCujQUFOxovBxNmMUoN1hVUGuu5/4r4r5rE0WlOPI8SWH0iiznjOSOXfkDgCsiHk4ObTl3TKYj8Sn9bt3UnLP0nGqdMp67BL72aMSRLCKt/JeAly9vNHJDoXy0+XQZJWy8/QSePYseU3bW3Ab4EhbzG+BsdcgfmaYYoBEHL5SUd/kKx4UIA6lJgO80ajAx2Ok=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(356005)(26005)(16526019)(1076003)(54906003)(2906002)(336012)(186003)(82310400003)(8676002)(36860700001)(6916009)(70586007)(70206006)(86362001)(4326008)(8936002)(508600001)(47076005)(5660300002)(2616005)(316002)(36756003)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:18.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7b58f-5cbb-4f5e-9cdb-08d996f2b385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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

From: Ahmad Othman <Ahmad.Othman@amd.com>

[Why]
Crash when USB4 is connected.

[How]
Added an ASIC specific code guard.

Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Ahmad Othman <Ahmad.Othman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 42f96de496cb..c278d134c44b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3604,6 +3604,14 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 			link_enc = pipe_ctx->stream->link->link_enc;
 			config.dio_output_type = pipe_ctx->stream->link->ep_type;
 			config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+			if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
+				link_enc = pipe_ctx->stream->link->link_enc;
+			else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+				if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
+					link_enc = link_enc_cfg_get_link_enc_used_by_stream(
+							pipe_ctx->stream->ctx->dc,
+							pipe_ctx->stream);
+			}
 			// Initialize PHY ID with ABCDE - 01234 mapping except when it is B0
 			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 
@@ -3613,14 +3621,21 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 					link_enc_assign = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 				}
 			}
-
-			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0)
+			// Add flag to guard new A0 DIG mapping
+			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true) {
 				config.dig_be = link_enc_assign.eng_id;
+				config.dio_output_type = pipe_ctx->stream->link->ep_type;
+				config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+			} else {
+				config.dio_output_type = 0;
+				config.dio_output_idx = 0;
+			}
 
-			// Add RegKey to guard B0 implementation
-			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 && link_enc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+			// Add flag to guard B0 implementation
+			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true &&
+					link_enc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
 				if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-					link_enc = pipe_ctx->stream->link->link_enc;
+					link_enc = link_enc_assign.stream->link_enc;
 
 					// enum ID 1-4 maps to DPIA PHY ID 0-3
 					config.phy_idx = link_enc_assign.ep_id.link_id.enum_id - ENUM_ID_1;
-- 
2.25.1

