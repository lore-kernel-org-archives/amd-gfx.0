Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5582DC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D00B21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3NxuBd0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D00B21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CD388FFE;
	Thu, 16 Apr 2020 23:41:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D3A6E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT9tbMPPlT72e8M/MX1Po3GTWb1ckOANy2sVIHEzCuw2MixTAxA7+EEU1tfAI1kuWg+68Du94N35dJ7CIcnL1of/bNNmw+7Vi0HL6RQGHt5XyCEfiGARDy5wqfJoTVhIEYglMKfLHsr1IIkiTaL0fjmkW6QNsh9wGmsVFWveB72lS3SmI78hMl92cmMDC6yNLMobNWTkbN/Ly1/npRwwx5Pbxxe/cKgGJoc/F08Hquuox1Dt0OCwUkzS8z+6WPjWZe0D+MxGvJTsfMve9EqGq/ft9Ey/cUqYaR/4MM2+hIakeP6Qq82cyey8GcvNkxRYxo2jAVg/x4U4OUfIY7Bwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpaXqRla1jzZN8+WGTz/dg1IvLicRYNfugJhJUzvdsw=;
 b=TpMtqlK03R9fSBUqUMvbRN8j2LsohNFmp0emwehqqBNzbU2ig/9Y7qBtq1WLQi7z3a3dOTR32rWiTj9DRbQO5/2cnlaS+MHGriteYlDzLtHPv0Hnz49ezuZfEw7r5w7Z4J5MCyVeO8fJT0PjYClP3/s0naQclorhUo81d5wFdEspt2ifQnkjRt3SX6yFBP6lVf0afDwnQEkypMp+epZ/hIVHDgXOiAmqWshu/ETmu2iNk8SPPll9+BWNFQfgHaqEknJFiIprCaFggfe7DXOMtCYbgP8ddte6Kbm/SP/HdnMRUsCslmxqybDsTADx3qbrvjG1/L4WnhRX3kjNp/En7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpaXqRla1jzZN8+WGTz/dg1IvLicRYNfugJhJUzvdsw=;
 b=3NxuBd0YA9FJFxqjLImQiAFRI188xo3ma8A8heaRPF16tvqJiC3GTU+bJ+5IRhs0IUOSjPGGg7ITa/kKlkSuYOi3kSFUl96+DuWVhCefjGdWaJWarepo8WGF1Ivl/PL66QttVy6hUAGcGfRLPsJjLhNzofPqNA8AC0gGV3pYisk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:29 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/35] drm/amd/display: fix stream setting for diags on silicon
Date: Thu, 16 Apr 2020 19:40:23 -0400
Message-Id: <20200416234044.2082886-15-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:27 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1882b5c6-3437-468a-9185-08d7e25faf3e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459BBA61CE2B8EBD1C996F498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKK3pGlDCt5i7661wj9LkwdEUxophz73V2K9ENEafTaf9+mYz2gCQXk1Pfv8Mnbvhlfzbn/1ptcYx29IPMUTD27XMyef6uTfyQcYYd2cbTSlvPtSQ6brit4Hh+/bxkfwY1T5JVLdwixwQXilGdOLW7uvnr/nOFfWh+9RP+wnM4No+JfswJuVUokLCYy5343WfTMPzUikqe1bu7564j0AHs9vXWmY20rpEF0cfSeChQjNsNyEPUOjau7lHjWBbRDFq4aNltkpb7uR0rihDYwRQmB3BXavufHUEpYTM4C8L2+KSFWHy1WEdkeZsQDI+ky5g+5IFWIvGUFDEh7Eo925+m5ForbIrYxMlhW1WFaDb8OWrjoynw2QWDWmQzq2BTA4JHRk0gv/wTO53Yzd6x6FOuGSFMKxyanKGZjMUd5KYhlhp1UELNIMumiFcRDG5Z69
X-MS-Exchange-AntiSpam-MessageData: Mh7Vc+cHR6mIyicroAWTsgBY/L+ZhlOAa2oNfS2LrRJkpI5LZXfVLgS0Nve1aHztHemNfpo3BSxXi6h3hPFJy5VBPPy1CjStFf46WW7x65enTeCdN6yw3FuBk2CkU7wKM4Vz6Tfb4jjAHR0CKe8fv7XRrNhz0YDP7MIhZUBZcvo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1882b5c6-3437-468a-9185-08d7e25faf3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:28.9146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkcC9jh76pM9rA4XJSuHaTjNEyGoT1FYAYlUowWEgNuWlTi9fGQnqMKDBWvBQikG0qboZaCrRTxJ2WFwtvozjQ==
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

We need to set up stream even with virtual displays when running
diags.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 44b8efa3510b..1c5c11d6347e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3067,7 +3067,7 @@ void core_link_enable_stream(
 	enum dc_status status;
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) &&
+	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
@@ -3217,7 +3217,7 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->sink->link;
 
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) &&
+	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
