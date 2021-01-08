Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB51EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A8923A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A8923A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CCC6E8ED;
	Fri,  8 Jan 2021 21:50:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2356E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgWHreATVWnDM0uX2hTf2FYEs1OGn4KQ5Qh5882NAQGgGWy92EXm81ztwtyDOwhITQoX/TvnCUFqEG49foIkV5v5kN2reJZbB4mTz8Lb2Tp21a4jlcvloZ30AmOByD0SX4DTTd+dRyPb+mVAsvekYkrVCzaPOcV3s4GN93v4azf7QM0M5RLgwMq5fPnhGkwWIdTGLddCUba9P5tZDNkD9KsNlhJTpNErTTRbPaJwNwZMEfo8S6qDhFkbLxgZNdIAp/mDaQR6Z1eG9oFttyG+nqxu5Lk8hGuOm5f3A+ogaftwc1geEzoRmTP/wtzgauqQWlUo52BupVP4TJc8mVdc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBEds02+2a+UBxOT06/q7M5n/L1K04uj+6qYeAzMCV4=;
 b=eN5Z+TGM5v6q6I03FpUVAaDDrMPpJYXVlDAgror9GaMM7G/AnSW1/tiRZAL3h7Ibp9vL1rv7ciF02Km8EFEl1PRnth496EooJmtXb+Z9RTyRUgQyTaynDSmGw/R6LhEblmpXv44xaGJ2gnGn1CNH/Vukc8/MO1vbPez7CBtqDLrPeZPqTVNXoe2/8G8yYeeeLDkdQbQpKOYixCxb1+hWVAcdMWxYPflYYmrBecKR2dWG0hQsKGQCjnIfUjEtIhwISGYyWVejUjgvcGD5PIaQfd8WDiS4HHJ2d5gAE10t+uOLWeQUVYz6VxjXLc2ZVru2/VJpVDuzWofVAgsqzra//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBEds02+2a+UBxOT06/q7M5n/L1K04uj+6qYeAzMCV4=;
 b=GhNsmPM+2J5+w6K9CTCmJIXWqp25Z11po+o56VZX0udSIZ5W1jtW7ZMPlcY64xGibXbZprNaDh/iELx53CQcRBUo5EIortxwjuUxH7Bt7nl+toNlQZxdmT587IVYIYd7jTur1YvpzaXIGJySEXgALGgjl1ZAIo43nTH6APlubM4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:48 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/21] drm/amd/display: fix seamless boot stream adding
 algorithm
Date: Fri,  8 Jan 2021 16:49:59 -0500
Message-Id: <20210108215007.851249-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62a52b80-6157-4eaa-4778-08d8b41f75bd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB188292061ED5C79D5E4DB61898AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2nFNbG/xmMIxHSyW+YOm9BrUq/zOBs0z3t+D/gUqJI+HKsgJjK5cXCosSu+eMiY7qi2Kx/hOb8Uc1GD5wmb3FludMJTdm3zPWpJyhQwbh4GHrm6NS21Q8X0EJH6U64MkRGmZjBg48nNzO5V4JVHq41CyaRb/Wsvx5QJmH5flkUVQHsOmkZN/USJkLoHglEbiEgFD+FaMjvNw6fsaZ+f1ErbpAbBH0nCexxcuIIfPoRbfhvPpPrzfJKwhFde2QrSlXCeO1JiCMPQDejbQgl8siVGT+GkeQwBuyuhNFj7e63P1fd+95uPmYLkIHNIRy+N5xdLqeUisgBIP50ShdheCMzysfQHllDEkDTp8Uj3/EUw81dIP/IF3yzPbzG0NrNlo+qN+1RCNRz9eQb5iKJSWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O33CRiiQQEbxcyrE3znvVUbV1iJJocvytHTEoBw8+CCRsrVRh0K+Qg1W7ZCQ?=
 =?us-ascii?Q?7O79gEmulXhEeookPKn3+O2xqtuzuEeUI7RgM8V4XBW6edN+SG3xvstLarO5?=
 =?us-ascii?Q?cwqTSPYRTk6VPSvT8bUPo0MflkQwxFHC76Gms0Q9bON2BZQ4PWQ3pNYSyI7R?=
 =?us-ascii?Q?FhBPNil06S6fKFgQA9VCjne1WEhysjyEy+5THFK2R8VnePvj5OWHWQBECAfX?=
 =?us-ascii?Q?ife0Xl61krsUDZ/895A4UrKWVDwWgvgy9XlM7ZO3Aqcb+bAJKnqpNXfS9seH?=
 =?us-ascii?Q?O/7uZ4ihfcil0/gL9z9Sa9nvv22hLyT8WxM0iEb8UQFAedTe+ZEYSRjQ4NP8?=
 =?us-ascii?Q?DZKHr8Zp2la8xbfomJ+CLS/P4ZEWPd00PZJ6bgo6KNQC+UN92qZEKfQ+Vtvj?=
 =?us-ascii?Q?C2vOTIfb0fCvU5+29lOqv9EAZ4Ol6vo+Iw/94I7aLamkvdlDESYMb5By1QdK?=
 =?us-ascii?Q?ZTyhyq5NcNkTS6H4tH8CW7QB810k0oc9okryqnt1kUbouIEZXQ3FF83GUKqY?=
 =?us-ascii?Q?kZbTInTWdYIAlSHd3lMZe22uAtuu7PTSKGfezuRigv3w8l3TAQRQecH33DZN?=
 =?us-ascii?Q?01nMyqr7msf+5kH5CIjknKLjO6gjHmdqFCvafYrZO2Wi0auprh6CAxNR/iWJ?=
 =?us-ascii?Q?prkCFeKozlTe4y7IfVrBihjsIQ0vyRqf5Nlv2ae2Lgk9PS1XMqvWy9RcIPdq?=
 =?us-ascii?Q?Wr9T5Qd4bq8tG5672Cg25oVexZGT1BssDDfUd/4nJCmvgqBKQizDO8p3m/AB?=
 =?us-ascii?Q?ihrou+ZYiZsvqZlmFoRtcDVdqh++eiNKUFBTe3zt9vB/IebnuMP8wWumxzb8?=
 =?us-ascii?Q?6lszRBIKc8a5Occ9bgSsvyUdhprOWYSXJFVV1rc7+3FV2xUZ5O0ASeHpFBCC?=
 =?us-ascii?Q?ii0Jnnb3UUuVLa4YMO0G4PvUA5rBCDT3/Q3Xxt/G0ixyTuaQDOUMEmkjWB6T?=
 =?us-ascii?Q?+zUW1IZIymzUAbNas/gEHN+15JlYz+kBF6Fybyz1AVc5u27pMqUNwmlS6bTB?=
 =?us-ascii?Q?bLA5pS28Id4oR373PPsNcHlb/GWXpR7cjD/RvuRzB9NR2S61nX0PkK0Z5VuV?=
 =?us-ascii?Q?79XiQbFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:48.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a52b80-6157-4eaa-4778-08d8b41f75bd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ye+7DTN11v52jeB75lFsRGTb6FvfK9Ix951uiGNf5KwvWjEc9JNyEKlM8nGcvcthgvG5Y6XxHbam2hazGSzc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Eryk.Brol@amd.com, Raymond Yang <rayyang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Raymond Yang <rayyang@amd.com>

[Why]
Seamless boot stream has hw resource assigned, already.  'add' is
actually rebuild the assignment.

[How]
Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx
matches

Signed-off-by: Raymond Yang <rayyang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 07c22556480b..3e9ab047301e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2075,6 +2075,20 @@ static int acquire_resource_from_hw_enabled_state(
 	return -1;
 }
 
+static void mark_seamless_boot_stream(
+		const struct dc  *dc,
+		struct dc_stream_state *stream)
+{
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+
+	/* TODO: Check Linux */
+	if (dc->config.allow_seamless_boot_optimization &&
+			!dcb->funcs->is_accelerated_mode(dcb)) {
+		if (dc_validate_seamless_boot_timing(dc, stream->sink, &stream->timing))
+			stream->apply_seamless_boot_optimization = true;
+	}
+}
+
 enum dc_status resource_map_pool_resources(
 		const struct dc  *dc,
 		struct dc_state *context,
@@ -2085,22 +2099,20 @@ enum dc_status resource_map_pool_resources(
 	struct dc_context *dc_ctx = dc->ctx;
 	struct pipe_ctx *pipe_ctx = NULL;
 	int pipe_idx = -1;
-	struct dc_bios *dcb = dc->ctx->dc_bios;
 
 	calculate_phy_pix_clks(stream);
 
-	/* TODO: Check Linux */
-	if (dc->config.allow_seamless_boot_optimization &&
-			!dcb->funcs->is_accelerated_mode(dcb)) {
-		if (dc_validate_seamless_boot_timing(dc, stream->sink, &stream->timing))
-			stream->apply_seamless_boot_optimization = true;
-	}
+	mark_seamless_boot_stream(dc, stream);
 
-	if (stream->apply_seamless_boot_optimization)
+	if (stream->apply_seamless_boot_optimization) {
 		pipe_idx = acquire_resource_from_hw_enabled_state(
 				&context->res_ctx,
 				pool,
 				stream);
+		if (pipe_idx < 0)
+			/* hw resource was assigned to other stream */
+			stream->apply_seamless_boot_optimization = false;
+	}
 
 	if (pipe_idx < 0)
 		/* acquire new resources */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
