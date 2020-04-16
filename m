Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C6C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFB421841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qmvzr+5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFB421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9326C6E19C;
	Thu, 16 Apr 2020 23:41:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7AA6E0F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4MfYcn85g0FSOaCKMXS5JJJ8HrAmzH13V2oQ8mYHT135vDWZAE/n1hPWzhv8hvvyMg6ZgEiXvTEzmSn4xDKeTX5ROsSnXhuleXfQvkLPrk1puS0bhJL56sWjLjC8GLW9TLJjrDb6DPsZPYMAsBI0LqvXNCHhB3uV4YKId+Mmw8x/dLiYlBCAsFUYI+DmqC0Pp7wWx1tXROzapVu+lNMNKKdMXng3AEPomWljCajhHcB5+YeqSsmFCpqh/yb8lHqZph5rMwNOmsWkRdhaFd6Ph93OEkv4jUKAorRoJoVAsC9P3+h7OAO51XUM+PX0QkE9Fh/sO2nWo+p4V9sFLQ8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oLn0DN9ktc0nFjI5UkjGG/eAK3gi3s7hC4xtoOQsyE=;
 b=LHAcmVLUSq4cFfxbWzu20OQgX5wH0Ctyhc6YvouKXt1H3J3S2DkTDyqNgFUuZYGXiRgCI07vd9C7TfcsNFQZmuRPpcfCsOuQw3n+O+Y5gkBl5QgKlF6Mzy1dAnbruARREIwfHybP8ODOlza/9qAdPrhnVYJbHiF6+Lpcto2triUWX4oEhhq8fNeBjKDjwL8u0YTCbjcB/jVPEl9TzoIsQuGUfBYPOjd0fCVmPyDTsPbJOayPUfVg8wCHLFzMfvBg8+AyMPna+mba/N0c7oPfWpZe+syNEfShg9etrt/JHAzQKAuLMn0VVJ4fw/VUzqF+sm2huKl/LWqnTBrSB8Vq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oLn0DN9ktc0nFjI5UkjGG/eAK3gi3s7hC4xtoOQsyE=;
 b=Qmvzr+5IIkGol8AegeUfVhAcbtw8BI7/forSRRhS7shCokte8HAD8OAN9XxI8Sdpb/Rom6z9oH9QL2JkDGj8kQ9iyVwAwBva8ZsyXhrZjcgRwbDJo4bWrRRJvt0TK9rhmHANacCEP8lvwYHwTe7jmbTZL3w14sWYjwGKKrnAEm0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:14 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:14 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/35] drm/amd/display: Force watermark value propagation
Date: Thu, 16 Apr 2020 19:40:13 -0400
Message-Id: <20200416234044.2082886-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:12 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7993f7a9-f30e-408c-1859-08d7e25fa65b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24599889A961B528A0D6007A98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjwVycvbSUD7f4p3WoG9LEbpqRiLINU7nItkz1Yp2Z3OCKUftaX4sKYBg8Je5/jz/1tqpvg0qIzdEU+T6Pq75l0UMDPYObMr2NlpZyLD4Qc0cO1/NtK53t0Ho5YRpW5WjhQkiXOF0S5/5brd2f8SE9+1eUst3urZ8q1wuSu0ECmqnhtsiR5zfSFzbo2vjpeRh/zhCKgablzgHB/vHzJ/dhXhDUzwjbrq9LpXE3oJSVXqjfsxI8xoFBg0LbtFndPYA0ZhQRSEaSQ12iSg0oU8jtTSU8ApL/lYXoYo/IAf+TKX9DgCqaUfDjHGw9/hpzKt9PKDnlr3cY/Ie1gEpwtcvzz7Ukx9rHQ8DINr+IVjhXmaGvstnK+em7jPB2VdfyESj2JzjHdxgf1YcoCQrjTzu1iayCrvVAjgvh4F9k3CCryhIIzYhSk4VRopDLg55xAk
X-MS-Exchange-AntiSpam-MessageData: PDH6NIpCZXozY9VWiGP4jb5VBS8rYWy9YkTWWjPRtvJXhrDmo5w28GDuWQWjfi3uB0miuvh8e7mqnwAqwkgAp4OhOp2tl/VL4nYKJug6Ow2ld4PfVKn3SoaSxVjqhqeUDZQQhdGQzbxxY+It+JlyxxZ4WpW1GDb2scB57SL3s2Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7993f7a9-f30e-408c-1859-08d7e25fa65b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:13.9471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gamXmuXeA8cjuAsJJ1wlQVVUq4EahADNQTmb3A6EobrkH2yz0rdF8p8MdJbo6Mx7tMNDKEa/P4uVPfcwEkWoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The HUBBUB watermark registers are in an area that cannot be power
gated, but the HUBP copies of the watermark values are in areas that can
be power gated. When we power on a pipe, it will not automatically take
the HUBBUB values, we need to force propagation by writing to a
watermark register.

[How]
 - new HUBBUB function to re-write current value in a WM register
 - touch WM register after enabling the plane in program_pipe

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 7e65c774c800..efc7fb4cf44d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1478,8 +1478,11 @@ static void dcn20_program_pipe(
 	if (pipe_ctx->update_flags.bits.odm)
 		hws->funcs.update_odm(dc, context, pipe_ctx);
 
-	if (pipe_ctx->update_flags.bits.enable)
+	if (pipe_ctx->update_flags.bits.enable) {
 		dcn20_enable_plane(dc, pipe_ctx, context);
+		if (dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes)
+			dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes(dc->res_pool->hubbub);
+	}
 
 	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index f5dd0cc73c63..47a566d82d6e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -144,6 +144,8 @@ struct hubbub_funcs {
 	void (*allow_self_refresh_control)(struct hubbub *hubbub, bool allow);
 
 	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
+
+	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
 };
 
 struct hubbub {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
