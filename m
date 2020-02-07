Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EAC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233B021775
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X8G50bqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233B021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E2F6FD10;
	Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F5E6FD0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab3nd9NEB0V87a2LsK7oXmfmp/eNEoMWVVv5VOSmN9xIGYVULDN/6dVf+fzQMsaQ59EjVy9isFqlti5/DvKYSCo8pJlcHeoWDr1GVf9HkadgLippps+uK1hB2RRaLzY9cythKXZ6uNrEPVjj4m0u3PH65Zn3g0oAlGTgfCyI9CQQdv3mci6PaCgiPOE92Hbm5z0d58n4mnvjiDuGmxsSS0KFcSU+iIoe+/oszEVjlP5/bBoAbnlpuxw5BTOAjE0voWSz059QqUK0NcDvjHS7swHoAw426Y/RdVu4rroUrSPEenHG4UHz4Msq2NlMXBpmlLGoMUsWNrHnCxWrICa/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7xcQeRqO9Pe5LbxvfXT+hf/cWl4JpVzIFmdB0tSDxc=;
 b=oJ3TlpOrRJDmCI0LSCXFOB75nUuCOhfgjyqHfULO3xKcLg3cknvMSY5seIp7cg7E/NqYqB/yFr6ZtNiucoWsdzF4VPb9D7jqkYpGVoWWqaRJcS6MV4+HI9SPoR0BYHt7UQf8Sv8Kb92GSlFpOuFU8PhCsIrjHB64xoqzGtXcMpfzR18cH1a2ElTsTOxnW654XYeQKaISTudsqSwxHJWPSfBS+XPaQ3HOVq47NebTA2eAMivdvft0zF8Mgg1jkLf/ZcVSHzkG7vC6CT7sUWnxxUywWyvrg2I17aLN1WAdJl8HKsBJufGAn02cJh05iBuMe9LIBZS+X0xpaDsG0Be6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7xcQeRqO9Pe5LbxvfXT+hf/cWl4JpVzIFmdB0tSDxc=;
 b=X8G50bqb9B3vAkfnRKtBBcfYPgWfwCZvX+geJN78QSFAyPlONjNvdvPih38+iAv/4fNHLRwqN4MIFHMVCIa6PlRE7NyxtF6xpZk98wkSqljABXSEet2XUUHoVuRxRbR3B53vq42r4d9uSNrOvraCnHX+YUIdZh8PYjQzbffpujc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:47 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amd/display: Toggle VSR button cause system crash
Date: Fri,  7 Feb 2020 10:50:01 -0500
Message-Id: <20200207155010.1070737-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:45 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54ffa137-66bf-4f55-db97-08d7abe57ef0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440CF5D8560A163895D1A9C981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYj1U7bqaTc/EMcgVBiXKLaZ9DZ47puiuO8VL9DLYGzM56vFppH5iUtyRBvJG1pGcLt4W807FuWJ5pkF78RD9Se3kadEgpIx4tV8z5C0ffxh6bxmJXNWvn+XY1vjsbfTuilJ6ReMU0nurLshPY6oLCc5YGJLk4xPWZ/ImcAY3yppA7kNrJYzw8Dxk7zsk5rihlbj1DlOiXFtuoL9f4o8CLTtTXI2MhlHB3dy/YZR9JLYLL2B03YHpNy+tspqCcQjj2Z++bBcC5NVakeeWbgJRNc3KT8oSa/07+q8+N+y7+gErrQWzvosP3N/dwL6ddvmS+MZmnPy2khc04l3ditW2hOP7GOeMTXdDQ5CBlbYoDBcGaO7cvX9lgixGYSH2nUSjO2s/6N353mJlOkYS7G4mIEtal4PkCO3xJtYiUDXsC2ytjbDOoX+iDSPmnYt4Mbr
X-MS-Exchange-AntiSpam-MessageData: XMO83Z7TA6NkIjTvgfo1RhJwaYacMSMOiiGRWxai1YCDg2qgXHLYt2k79BEWIH1Pekb+D7sTN4Cs3KJiDMA4Ye8ciFNguVeA+sYKx3v/W3lEnl8iJUhOEJ1FXHbdIOhZqaF77gs4UPbmzTa/GhsvZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ffa137-66bf-4f55-db97-08d7abe57ef0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:46.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z1Cb4pLVjN7xY6koj05CChAGpZoxQ7wM4Z9P7SarNJhe7o115HqgrEVegAsEZSeRaLoIwxKmd7MOpldO1hSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Peikang Zhang <peikang.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
in dcn10_apply_ctx_for_surface(), if we hit !top_pipe_to_program,
pipe_ctx->update_flags could not get cleared.

[How]
Moved clearing pipe_ctx->update_flags logic before if
(!top_pipe_to_program) to gurantee pipe_ctx->update_flags get cleared.

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 42fcfee2c31b..87e30f60cee6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2540,6 +2540,12 @@ void dcn10_apply_ctx_for_surface(
 			dcn10_find_top_pipe_for_stream(dc, context, stream);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	// Clear pipe_ctx flag
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		pipe_ctx->update_flags.raw = 0;
+	}
+
 	if (!top_pipe_to_program)
 		return;
 
@@ -2570,8 +2576,6 @@ void dcn10_apply_ctx_for_surface(
 		struct pipe_ctx *old_pipe_ctx =
 				&dc->current_state->res_ctx.pipe_ctx[i];
 
-		pipe_ctx->update_flags.raw = 0;
-
 		if ((!pipe_ctx->plane_state ||
 		     pipe_ctx->stream_res.tg != old_pipe_ctx->stream_res.tg) &&
 		    old_pipe_ctx->plane_state &&
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
