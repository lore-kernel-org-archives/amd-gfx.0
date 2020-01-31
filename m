Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265EC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070622082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Clpwg9sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070622082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7726FC44;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1026FC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRWRMOotnwhFARwRYg2w753QCrp5WhCH1eZoxwytW979CUsgSmDsLZdQlrOtiHJuIMJb4LRcpf8VMvXXnSL50xDc0gcPy9TZU167tVYlDt2Q57eJLcXXa2GhJ/YYXu6Y3shZgZPPfZlnfm6TXDZvfTUX4ZIJPJqR8CxACogXORQ9jbsXZ+oIaW4nMzMJb2VZSGJ1ZjYIRivrTZ/24XguYDXhmhQoMnUHUE+DfT5jjcNNDse+MKgGKXo2g7PVbZ9l6DGpp6eXdrTDa0z5iQd7bkpdKzyvPtagCVx/9gmKd9oM5H12kXLfB+q7J2H0VOqoQb/2YBrmf95RUtHg7TOiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kTLcBObAd2snhFGYbGA4ybLJo6yoXcEXZO8AJc/eLY=;
 b=SirYMfjZFLf2BqTgYbGa/e2uD0qoF2oBlZmNbeg/3wU5s2x5vMDw40fcuZ8lRNcwyBj9ZDnQdeCuFn6WX09yastrn06kzHCDlQO8UHMBvzgpVnzChf9h0IRB1wkDifC/0pnEIngGGwz2vSiyg6n5Suui12RHkxi/oroindVmf19gmpmUTYdIkXWRDRGVlHEC/olmOfGS2RAVhbnGUSy0FMTQRbvOiWT6VTuS27nFdTQ3VHT1IME+vLzWMYLS/bNU7D6jlh/XhyFMQ9LvrXmrYbeR4uqHJiuUV4jlJUzihP+CO5D1XuZZHHL3B+HonKN04y370lcXwrTikPX0ogw9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kTLcBObAd2snhFGYbGA4ybLJo6yoXcEXZO8AJc/eLY=;
 b=Clpwg9sn0fSdH23+vVh7cnUiA18lZp2y7Tr6zI8u5POWhH9b2QPbB3hfpqsSxM51cHtzTNmRr425IElGOIuN9/ZtzfSwkr3IQ1hwo3WDRpAE0GAbEgip/y/CMrALeL/9HaZG0s8sOJg2gySpIJGtEGMjoltMJ9bQME3O9vvTd7g=
Received: from SN1PR12CA0074.namprd12.prod.outlook.com (2603:10b6:802:20::45)
 by DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:21 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by SN1PR12CA0074.outlook.office365.com
 (2603:10b6:802:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:14 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:13 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:13 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: external monitor abm enabled in modern
 standby
Date: Fri, 31 Jan 2020 17:16:39 -0500
Message-ID: <20200131221643.10035-30-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(189003)(199004)(186003)(1076003)(5660300002)(26005)(336012)(70206006)(70586007)(2616005)(426003)(7696005)(36756003)(478600001)(86362001)(4326008)(2906002)(54906003)(356004)(6666004)(6916009)(316002)(8936002)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1738; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d718eb8-e6c2-4109-0e7a-08d7a69b5751
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-Microsoft-Antispam-PRVS: <DM5PR12MB173814D4F9008E3AB08571BBF9070@DM5PR12MB1738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4IfPeacmig0c4KSPY7Qyf96VyOxMRIjrs3Wut+FMwLOXnzlKKiQIXOxOinR+DdNdCsUyGncCVnS9zZEmpEr3tFZTQybhV5+wxv3C3qyCQY/25RStMJkm8TnHMc4LvgGEaGVPdumziTKevhYPXMNHOc92c/AziBkqgIRILzfCER8rLbc1u6d5r+vJLh8OUwA2pPgNeRBHuQB2IfKpHYsySlvyXtEzgt8j4OhwXv9UTod3LoIdiAStmWPxcDLdxK6P0WkuWvbiL6Gv5BlcD5auYTSVyRZXc9HYQeI4Xj/oFDMjd4fmZOdc8HSsH2h9bcYDpM7Lo9NRvOJhlOimpy8qNm4vSnwRLv23xl3eQ9raAiKC/BIUShjofXm4YNfsq7H3YWFiTTJFYl4oVYTiMdgb2Ta1xxTkZwoJLX+PRHQ9ru7waLE6RE0btW9BSUkZoeuh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:21.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d718eb8-e6c2-4109-0e7a-08d7a69b5751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Jing Zhou <Jing.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[why]
Resume from modern standby, edp stream disabled
but abm keep enabled. External monitor select OTG
source 0 which ABM enabled.
[how]
Disable abm before disable crtc when reset path
mode not call core link disable stream.

Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7fc559acffcd..0225f8d8bb82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -901,6 +901,10 @@ static void dcn10_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+
+		if (pipe_ctx->stream_res.abm)
+			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm);
+
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
 		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 52ef4d333112..b9ec40a31f5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2011,6 +2011,10 @@ static void dcn20_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+
+		if (pipe_ctx->stream_res.abm)
+			pipe_ctx->stream_res.abm->funcs->set_abm_immediate_disable(pipe_ctx->stream_res.abm);
+
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
 		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
