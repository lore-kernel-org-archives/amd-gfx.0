Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD10C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9400910ECB5;
	Tue,  7 Jun 2022 17:06:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53BF10ECB5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyAkkCB7F9LO+yMpDo9MM9YEXuQRFjcaMolYt/vclQOYwXLiKcPAobtLL6vMeeqb3huQjsqH7d69OUZV3IIARM38IHpN4GrjeA7DsYLlmmE6gkUtoCo8Z8nt1M2O1QqSqbUkTukaYlIZVfeWH7ltgy+b/8XzIPQ3PW2JdDuKf7yTIwgWh6UZ8CTmB1zkv47RLIgmCSWnWcr3wcKhnNcejqch37B2Bwvfi4G31wV12FwYd/5sImZoI3Xmz0Fykm6V2xyc6gkyJV9yd3K0gpniSucgcVAcjo82ftjWSQ2riE1h7sdzaOibcAJ6/1fuTRlSRGXKyL0qKHGBRCoHgu2aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0zkdGpwENH0A7zPjNVKHLMJItsveFtIzFJqKFWQcN0=;
 b=jqZHGPV+LwQa1L9dlQK/PdqN48y4WsX28po0W6wknhXsU05YzbCHssSqoK8JW+BwcWewcgNYABPlJEQlfErs7puuDw6zyzXFFCK/WWzDwMR4KYECWtd7NllpNJWv39XlniaLT88VL3lvAXvWWr9cVd0E/mp6NK8thd5wsi08xMPfR4j2E7Qkbg/IE3TeGboicjueL6gjcVsHXAYl2Mn57EzcV2IztVGmdYyJsV118PdPjnoPStIJPslZQHpgzc6ltYnCPOJXjaVaDyB1yNn4VcrrTXcZrfiHvJMEJPW123Z5JRVURRN/Sm0kL9PwmQ+PTz/qj+Csq1661+xBpb2p6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0zkdGpwENH0A7zPjNVKHLMJItsveFtIzFJqKFWQcN0=;
 b=V8GiaT/J5aT4b8lSqYl7M3pG2N7UXgSxxbem7F3SydB0QySwd3PZlpe52xxb5/+rwO2XypammK8SxxXs53xLl5bbDfzVyb31yzEaBJNpgznN9rT+hDuJWNOAGk03jAkMossMySbdW2Qxh5x+weafuwBzHprk5x2EiNDCyzd/5QQ=
Received: from MWHPR20CA0002.namprd20.prod.outlook.com (2603:10b6:300:13d::12)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:06:49 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::61) by MWHPR20CA0002.outlook.office365.com
 (2603:10b6:300:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 7 Jun 2022 17:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 17:06:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 12:06:47 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 7 Jun 2022 12:06:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix null pointer deref error
Date: Tue, 7 Jun 2022 13:06:47 -0400
Message-ID: <20220607170647.217574-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aab3520-6a59-4fa6-b8da-08da48a81c3f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4320850727296D6FC028E0AF8BA59@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnt6DEWFPRYqj9Op+/5ozvjZVTEGepdbh7bic2eLfMONvlIQP9pnRxJNsjPl0dlceCadwaVXyl9n9IQXu1VCVdQLiDoiTBl9eVqswnY9U0A08TQJ77lX2qMbf/vE52+iAsiHk8nn7RDT/dJ0DiMZCo6AuMLehbt9HLm/PYcuNZ13npZbxmcOaluXnO/LuKsSsYT/0kYgAUbgd82+FIoP4fouExRWv2+skpDkjxtx0ZQZ+3LucpZCgbLHzy49W0dJNPCsh3jilAsexHyEFZdi6jnNWHD9Bme+gat9MAtCoEUna+2bwOOuOC1Hh7RxEsBmgulrPjFNp4xGRanPyIw0fbQLmEwlejJAJ9Pn1Xj+LEtUr8S3iqgIHMep44MoKln+CxR8e50n1chT5p0C3nQnvRFajpJ7Aw9aViwT2lpjG1ix8xtLlMGPoggNJ2FtIWgrCIEw0KysKv6EGw7WfAmBn/edU7AhYFIyXWjubp02w9P0ER6/Un7SGUAdRwiv9k1YwPQE/6R9TiH7c8eqN5LioIIcvt8XN+/96WLrgMzfODJdaUZAHuuyj31tudepnkFl82uz9SPPJA4Wna8AgcwxMb6Fi6sWtDRkpmVu6hE6bg9jMrMc8qISnF/v4WRWOUwAYfDBwycugoMS6LDT98OO+NTcnvOBgC/QET5C00s26dkZ7FEvbZNzicE/WuSJsG8L6G7uz7xbM6uqiN9mnqaE2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(86362001)(6916009)(82310400005)(54906003)(83380400001)(36860700001)(2906002)(7696005)(5660300002)(4326008)(36756003)(8676002)(356005)(316002)(1076003)(336012)(426003)(47076005)(508600001)(186003)(70206006)(8936002)(81166007)(70586007)(26005)(44832011)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:06:49.0115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aab3520-6a59-4fa6-b8da-08da48a81c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
Cc: jerry.zuo@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
0 was passed in place of a pointer which triggered null pointer
dereference.

[How]
Pass in a pointer that contains nullified parameters instead of null
pointer.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 631a8a2f9fc3..e7944c881148 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2191,15 +2191,18 @@ static void dce110_setup_audio_dto(
 			build_audio_output(context, pipe_ctx, &audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
-				/* disable audio DTBCLK DTO */
-				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
-					dc->res_pool->dccg, 0);
+				struct dtbclk_dto_params dto_params = {0};
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
 						&audio_output.crtc_info,
 						&audio_output.pll_info);
+
+				/* disable audio DTBCLK DTO */
+				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+					dc->res_pool->dccg, &dto_params);
+
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
-- 
2.36.1

