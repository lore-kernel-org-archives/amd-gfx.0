Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519EBC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2301A206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VZxNR8AT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2301A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3BE6E957;
	Thu, 30 Jul 2020 19:12:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D7D6E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCWJfdcMCNSkSGu7laRiKox5b6Dc+ofpOEVAPCLJ564bB5+H+zyqXvvgfPoVo97AStsk93jK3TA8zvpCpYiD12IDUYtzBIPVdQ+aStDHkCaDgShrwhhb6eWC9AIYrErzgxDYudq9C+r3zedCYQ6tYBvIXg2zeYwJeBYsO+0nqJAUHvzWpt69cHZUTCZo3/2Ma1GtgB2Z5KTP4fZge/QM+vP7ksfQ4tSyShGnwo0N7nozNJf/+Xt0TodNRzf6L82tJWsj7iR5bFmVtrbTM+pWWNyhr9Ht7DKvDYvagO12I+JkL3T4NmtgejQimjTWCp58pJDZcFgWkYHw5+0+LGh/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OejFnaZzVb0z+Ysor19ZQQfsbqvminF58YSk19yC/jY=;
 b=M/pHW7uViwcPmT9bGscTvVA0Naplj7aAwrH+6GhBj1n5S2niQTPR/DlCHe+4kW/TmLzbLzm/Wc+k5byZ+D8iPW/tCBo+kH9FZgqfTrEGuunaS75eDYvoZ4HZzPCYSsXEkNhSVPwqOimMr7P86d8t0k/KFHzFqkGLAo9+U6Ztu2X1GaSn2y4WFY/VkXnm9ZxaBXTlrogPSXG2QqLQsvVe6qV9brBz8/pz6hPxGVWXAL0bZYXgAv5qX+MVp1AmlM4ZI1ja8QUHHORMYy3hccuSp9xnsFQhCeeFI2LijwLfM0TYpER3x/wcBOyscwS2IXNSb0PNXu6coX829b3I0eWXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OejFnaZzVb0z+Ysor19ZQQfsbqvminF58YSk19yC/jY=;
 b=VZxNR8ATXOqGmllytExO5aGjT1mpZvwrB6XTbMgXRL32dtLstaVzpNGgzTNicQtdsxhqCzBuGNHIv3WCa+OyWkGOVbrA2URgl/M8i1gHTEaQIjwtRtiPMZ18nXGyBqxlrfPS96yDKsdR7Ntq0F7DsjvwNWk651qfFbDHAlM03sI=
Received: from BN8PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:60::31)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 30 Jul
 2020 19:12:02 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::bb) by BN8PR12CA0018.outlook.office365.com
 (2603:10b6:408:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:00 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:11:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Use parameter for call to set output
 mux
Date: Thu, 30 Jul 2020 15:11:33 -0400
Message-ID: <20200730191146.33112-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055da333-f716-43ac-b8de-08d834bc70a9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1952B838860D95E0FF0C3F3A8B710@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdoiliR63ACmBXImL09I0qPoqQrRm06SS65DBmUtGpNDMIeDH0le4BR8m+mvNMBcaOU4HlmQbptWaaw+bGlp3Jrr5x6+uJti6VNbc4kUGFhWijbfNHRV2GhLV9Z3B/OcUf2Ob6k7Ttrx5HF83DZIPSAWG9mAkFVIPMCsuReQv9ndDwb4O4d17b5GtZHDJQ1mR7CMyIkmWe4zuD+moGbq13IneEVoNf7jgYk0C6f6LI1X4a1hN7iFi7tlBaOVipxY6q0XmtsN1Y86uZeCBy22hxghc4ULT+X48QoYCId49n71RMEhPxuoRF2IGFsSabWVAlxSCfjDC4A2fWdieUpnKEhCGUn2kVfUeqviH4SXlDjm57BIgV0cJ28F5Td4KLWk9eTfnXn9KpEJdXyX1yqoCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(7696005)(478600001)(336012)(36756003)(426003)(8936002)(6666004)(1076003)(2906002)(316002)(82740400003)(54906003)(8676002)(83380400001)(2616005)(81166007)(5660300002)(186003)(356005)(86362001)(82310400002)(4326008)(26005)(47076004)(70206006)(44832011)(70586007)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:02.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055da333-f716-43ac-b8de-08d834bc70a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 02742cca4d84..9f8ab679616c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3102,6 +3102,9 @@ void core_link_enable_stream(
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_status status;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
+#endif
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
@@ -3136,8 +3139,8 @@ void core_link_enable_stream(
 	pipe_ctx->stream->link->link_state_valid = true;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-		if (pipe_ctx->stream_res.tg->funcs->set_out_mux)
-					pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, OUT_MUX_DIO);
+	if (pipe_ctx->stream_res.tg->funcs->set_out_mux)
+		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 #endif
 
 	if (dc_is_dvi_signal(pipe_ctx->stream->signal))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
