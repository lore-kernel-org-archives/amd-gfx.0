Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288CC2D0E0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30B821D90
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wfJQqxT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30B821D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38906E952;
	Thu, 10 Sep 2020 13:47:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9E56E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI4bx+6J8VWbjxEb2JjxwiEH7HUkg+nCq+jwi2bmyJ2C3Cr+j0F/nrSc9ZXMrRBknfKCI8nIOEQOjFqUTW+Ix0BN04UG/v5HBIneaFBhDyMixnIBpmiaD/iQXjkrIqWHauYMJUJihScj3ATbB+UiX2EmRLftrjg1wAjiY9y9hkg8HyqtoA56H1s0/Ck6oKJq2ohxDch1o2MX3IzYRMz25oW47jmCJe07hUEP4wcoqKFDz/yWhvwr7kewHHzsBrxiKo4KFOHGnh5pf052d5UDJYRXDrobvYMgMR/EZWrlzHkyE2gtLlgGmqzD6azaXtowig9BRuepGX3UVdrLMYY1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyX7Sf2dcIt6IGB1GFXMUFRtFjxc8ozemmNUJfqJYAo=;
 b=gPwUEvAk87jlm8Ep5oZW9LzXp2iA4IbIzfmD3MrhIHcM1ggD4VjgU3STGUNPlv5fPvW8GbhzTej2VTqFq5bHqN5dx2RL9hbax8rcdVHfP0r1iyO6o6uv8YBncAjk0QxkeCRQ1YNz6BbVVMgkWbzbgtMETFxBVqQPYQRDd+X1riQ3quJ02r2r/XJuMuNx9veazibrnxe8nIeQDxrotDrfHGCcz4Frh/V2losLcqE9eLEm0pst1PA//S210jbQGtq0NgOy8IRLBUQQiQskW5GGvjdaG2wct7r9ZYa8eGKzh3or0RMPskQkj3DeAIAkZLtAoOAeP8iE+A379I/lHrOxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyX7Sf2dcIt6IGB1GFXMUFRtFjxc8ozemmNUJfqJYAo=;
 b=wfJQqxT0ZIdCMNlnI9A2g2EfDVnnt0PNEQ5St3U1NhlKX2i0lcIF53ThL7fCHE0i6kOn3IJu6kVauGI+Mzc0MF8C1SLzS1c7klOysLG+JG1kVxMCQUgSkw+2MrKQlYR68OeyVWyiSQgph6vEo/oBPkXGEWsEVZHbgjRegnR3MHY=
Received: from BN6PR2001CA0031.namprd20.prod.outlook.com
 (2603:10b6:405:16::17) by BN6PR12MB1746.namprd12.prod.outlook.com
 (2603:10b6:404:104::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 13:47:40 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ea) by BN6PR2001CA0031.outlook.office365.com
 (2603:10b6:405:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:39 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:39 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/42] drm/amd/display: Disable idle optimization when PSR is
 enabled
Date: Thu, 10 Sep 2020 09:47:04 -0400
Message-ID: <20200910134723.27410-24-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e69c2573-c352-4996-5d0f-08d8559015ae
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:
X-Microsoft-Antispam-PRVS: <BN6PR12MB17467DB0EA6B3B872490E92C8B270@BN6PR12MB1746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rgzbpk0lCy8pzxbEo2S0Uumk3LIhi+yGnCOJOYv8KH+u8Bwiwry/LlDWU7HmpcfhDfsAiCunfgfwhQTDoTyzXxfRKs4WVwrT5uif1VFNdZxnZylem28YiFurKX5Yb3d1fgxhyITEUa2NRg2oxWx6WW1dbhq3yGMot8SeGvAlNhG2J9BZrQS/XaokBG18gXPeq/ND1/FAiBOrP3TxroxSoO0EqXUjbnZErGm06KamOXL8eF4SFKb9sK6ghqN4fvipxYAG8Ktbg4PoTwwtoRIdtQeNM5L3RFnhWiCAr6PN84qwezqKWD57mUbgyWX7vkhZsjhmvA1H7wkCCaX8eeRDT4WTLenMrjmgMUoWZMcisXAOKOj3XU5B03o9Wy8JYG6guuhFVd2uPMjXSJlaGlpPLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(356005)(54906003)(47076004)(478600001)(6666004)(7696005)(336012)(2906002)(6916009)(86362001)(5660300002)(82310400003)(83380400001)(44832011)(2616005)(26005)(8676002)(36756003)(8936002)(316002)(70206006)(186003)(82740400003)(70586007)(1076003)(426003)(4326008)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:39.9895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69c2573-c352-4996-5d0f-08d8559015ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
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
Cc: Zhan Liu <zhan.liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <zhan.liu@amd.com>

[Why]
Idle optimization and PSR conflict each other. If both enabled
at the same time, display flickering will be observed.

[How]
Disable idle optimization when PSR is enabled.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 1390ff1ce7be..7886c32d8315 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -690,26 +690,23 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
 
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
-	unsigned int surface_size;
-
 	if (!dc->ctx->dmub_srv)
 		return false;
 
 	if (enable) {
-		if (dc->current_state
-				&& dc->current_state->stream_count == 1 // single display only
-				&& dc->current_state->stream_status[0].plane_count == 1 // single surface only
-				&& dc->current_state->stream_status[0].plane_states[0]->address.page_table_base.quad_part == 0 // no VM
-				// Only 8 and 16 bit formats
-				&& dc->current_state->stream_status[0].plane_states[0]->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
-				&& dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
-
-			surface_size = dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_pitch *
-					dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_size.height *
-					(dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
-
+		if (dc->current_state) {
+			int i;
+
+			/* First, check no-memory-requests case */
+			for (i = 0; i < dc->current_state->stream_count; i++) {
+				if (dc->current_state->stream_status[i]
+					    .plane_count)
+					/* Fail eligibility on a visible stream */
+					break;
+			}
 		}
 
+		/* No applicable optimizations */
 		return false;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
