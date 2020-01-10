Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB8C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAB92080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rxSorhQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAB92080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B94B6EA49;
	Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B88D6EA49
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMomY/QK1IAFmhZWmh3b3n+vOT+0+2ENfhz3iS6cHC3ZpMZ1c/xMPdkoR4Y7HQ0gU7nOMgwGa8usxh/8i8DIVMBaMhsy1BMLZ3B9ehax+PvCHMGZGHO+OBI/KIuaLntudQGBys8dNVRkGaQAdtEqzS1F3kWtY1PxsI6FKWuQCA5YAZQrfVKP3IRv7kTZ0o3biJ7k7YeU9MpB6wstMUBnk44YMTXHMma8GV1O2SRwV6/8/oA6eRzPOvNkdAmulwx8KQYYBDaR7lSlHn//7e6AGxLmF1dsjnOx8TkoYHn9V62rplABFuldNug2koMJMB8xuEUjFeECuxPpOhoVt1X+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FarkDk4IJqOXre+MgZuOOy8e4PQi/tcUm2HafGfeMdU=;
 b=Fydt3Cj5WQxqbW9D2ANvlUnNDbmPtjKAsZT2DvluWPZLvBv4oOIU12Q3iIk3v/biqAEtcCQgfzu3Bh1C6TyylZlxNVABveonTzRuxf1fxWxq928YtKurDaNTiGYd7MEDK+jjmIX8EnBrC+vxx39F8RnBX+lUGzrWFbqgmlnKVa4OYU0q+P5iGB9r0wQD5GKr9Al5mwbTQue3T0HdS9+oCtvmuqd/5nyqtEENErO/upd3dYlKVBFJmNGpARcEfLS/d/EwXw5DItj0vsRHoWMB7EnAu00p8lzOMMc5YjJb3EQpddQnPkKUiDHZlOcvXUMzieIifZhwpLreFwL6IOYQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FarkDk4IJqOXre+MgZuOOy8e4PQi/tcUm2HafGfeMdU=;
 b=rxSorhQnniOA6Dvb8LFtGVeTHLfxIj1UTYzmFBVjxtUfmIPYfWZzJxzFnzS79MyGkSsKUdMqmZSFHgYr3ITOLP4JUX7vkDjePOPhMlmT+Zp8rfawsf99o/rCRAflV2+228A6gk0g0OJPCz73DSWCFg6lMY5wefAeKJVPokIVP6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:20 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/43] drm/amd/display: Enable double buffer for OTG_BLANK
Date: Fri, 10 Jan 2020 09:46:49 -0500
Message-Id: <20200110144655.55845-38-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:53 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5c5ed56-1b48-4530-3ff1-08d795dc12d9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23787A11CA785A86C2B3E0B398380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG9gmgugTqgkGohYVDjbDLNxyDdieZTb3B9wN/+wxV0O7kR+9fMp5W0VyFcFrPY4u/nC7GKJ86eJ4zysBNdWjOLMNkCwEIqqSX12hFepTDJH4+kFtJbN5KHdNqdvnTMACRuCYBl0zkX6i8FB5fpsyL6hhcV0maRe+yuuh6rIEZcEtQEsbCw+9pz+Pb8ojVJAKn+UoFJ40EZcKQ4IU6KsK2pI8SCYMbLh1X/41zasKp8Nu5yXXTHFTwYuDtx4fLk/NtfUkIjHg4ArCfwf7vPG7t0H3RExZ/cwrenLD69deL8asFWFGfZxxBhgMufsF16G9EPAk1qmBNzT3WUxhrglYpYJ6QTcz08FVRXZ3c4oTkwYchNbX072n/q0x70la/vwygNa3AepqiTxf3LO+qG5qX1omannxm+YkwxcpTKLd+1H6ulekW3dVgCfw+O97Iy1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c5ed56-1b48-4530-3ff1-08d795dc12d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:53.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNpjkDfvVXBC8aKY6xRaEkzbx+ytswp2i3jwR/Sj4SymViyEQATR1+je1DKV4IhWVEOkPt2pXBXVoDDYIxdd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
Currently if seamless boot is enabled, we will skip double buffer enable
for OTG_BLANK. However, we need the double buffer enable in order to
block global sync signals when OTG becomes blanked (for PSR). Blocking
global sync signals prevent pipe from requesting data.

[How]
Move tg_init before seamless boot check.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 5347a85f10d7..f2127afb37b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1188,8 +1188,14 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		if (can_apply_seamless_boot &&
 			pipe_ctx->stream != NULL &&
 			pipe_ctx->stream_res.tg->funcs->is_tg_enabled(
-				pipe_ctx->stream_res.tg))
+				pipe_ctx->stream_res.tg)) {
+			// Enable double buffering for OTG_BLANK no matter if
+			// seamless boot is enabled or not to suppress global sync
+			// signals when OTG blanked. This is to prevent pipe from
+			// requesting data while in PSR.
+			tg->funcs->tg_init(tg);
 			continue;
+		}
 
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
