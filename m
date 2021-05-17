Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE6C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E434610A1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E434610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85AE6EA3A;
	Mon, 17 May 2021 19:08:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392E86E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 19:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaFguiKPpGJytXtADblng6YtWNne8BYqjivwPzyxMTUONc0CC1E0nneNemoVXwz/PE6q10o0OrFOSFMQelliw+DAvrLOwmGdx+nTOIKX/0Pafw/Zz1ogMkv8Pt8YQRfyGaJasrVEclZaXbCJT74/OZOQyJGmeyVz5q5aXoChO7MyVmC2nbSMH+gwJIS/IgO5yaKtbHunObzGyTKL2V1z/x3MI3CIpdNLdwzZrkXDEI4oSWWQ0dq6wereUa/V6RZqXoDsnlcNM4A1kjkDTdpyO+Do5LxM+cLr+JGy3Xj2xRkvDUvfvoVqDBhDOBcGvb4a2DcGUH5HKne/ROadvsTu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0+2zDLooNUrWLjSTG87oDNXVOT8MYKU0IFATYxH+zg=;
 b=fA8f0wVQCL3Pi5Im65sZTGDqAGYX0PQd1IsHwN7iofzqlKRQQEZlefM811XxI0CCQkmnEeNxN+sRKD3UOLOsLYL8IcNlQ5i3Ar1h7T2O55eqWWXw0bFfsy4J+tvc5y1hSOlnbqvUllfvFrEVq0WOoZUGcLDXjehqLk/Jgl98+Ke02imc8dPM4PWGqmXy+uSqNB+Nq70pxNPjrcRHqVM5nK84VF+luKesKo5BifW2Zqc+pmUbm3nCqxmZanfo4WoidD/mjUvGdMobFKbuh1s3ax+1kjNxmBKeeG8W4OawRuFhxduOlakhhVOwDscCtIC6R65206EewtQagPgxNTqFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0+2zDLooNUrWLjSTG87oDNXVOT8MYKU0IFATYxH+zg=;
 b=3dynhxqCtDzqGR/IrYG2M8V6jJiX0UeW3PlrifsUgaUXJxEjOeG56tdB8iyPeP0G6N7NY1tkRJmfYZcpefS3PggNAW2m5xLBhdaUjVRIXI7s9VoUrY/iDxybhkF2lz7gb9OE7wLuhYgbHJ78+diNsaiZLWObudZikSG2OrFENbM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 19:08:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 19:08:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display/dc: drop un used variables
Date: Mon, 17 May 2021 15:08:09 -0400
Message-Id: <20210517190809.1943517-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517190809.1943517-1-alexander.deucher@amd.com>
References: <20210517190809.1943517-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Mon, 17 May 2021 19:08:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: defa7ab2-dfdd-4486-0f8b-08d9196728dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4469FA0440B38C39D80EE709F72D9@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knrP6vtc2fSm6i0Z2y1yXCMlfs7lWLr3icEDFaVbtMIqCoTAH0kRUViHVfr02/B/c9aC2p0Cy1MKOjkEtp6Q7w3za+iVr16YOhUj6vP6HRH3F1w8P5n1Oe2QdlcS3wiiPxglWKMhu2AYMkpCDh+h1vzvG5wYES4EY332VKSuAtSRkCpY4UOXtRcBtbgFIX7U8J+/DBJ2m0HxElesOutu+kxf5HaS1IEon9fobHCQ5yDStKLypuqm84spa0GY/eeej2GvgHFGKvMPXUxWr67vjw6iTEjiZlUmsf1iFDALegx+xujTZoudBCuOv9POcu+be1kNwdbuh24gIlkXCMvA3WlsCRQowCnh7ZyOsMp1urAIuASmES4YwB2NFlwTYPB54NAjGM3MqMmCf/H6nNoUrdQ3iQFwQwPzWcSKq615r1+e2AOSWRNNKR+KG0oVeQApPjPb/S4IRQivZcCA/lvXyXB94g1fEdoGuiN6HV0alXLwfaXcGj/L1zM7wdhV7lHnwpeDYeNBhD9yQJet5Cgkcz5TL7LHBjpNzicM0b7GtR9e2DBlTnLlOABvidIe8kFgX2fRVAOIZs1ql9U8ffkDyYqVzi94JHGxlfFRFiZbUs11uzKWFHhHT1lIKxAtSDaLxB03euxLSKzguG3eT8o9RXeudrQeAAbYQXGcwehnc94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(36756003)(5660300002)(8936002)(316002)(8676002)(54906003)(4326008)(7696005)(52116002)(6916009)(86362001)(38100700002)(2906002)(478600001)(6666004)(1076003)(2616005)(956004)(16526019)(66946007)(186003)(26005)(83380400001)(6486002)(38350700002)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?elwKq/oeAIpgRiuB5svsMO1w4O64BoNUInNfnl9LSBEdmHS/FCaIzLgmisMv?=
 =?us-ascii?Q?FeMUaOLlVZ89ItiXoSNTJFoqwWV5d0Z7BZClaBb8eM3LYnW0aGnILDYzXXs4?=
 =?us-ascii?Q?WBjbjW8gT420GUm/BRAzpX/nBoYzFz5+ptFIbCudNIlsvr50b19AojJS/+p0?=
 =?us-ascii?Q?2rKuGgiaeirna1M8aRLn3Y/t0qL+2s509H/e1RptTBGu6YjaRjge3F7TjFrl?=
 =?us-ascii?Q?jyJv3UHMQDsrb3mMXqwLjpvo3HbL+N7cOE/TPFpEtVLXoiVM26YRfKX54qQG?=
 =?us-ascii?Q?AEIJYxM1jb+gn4/i8rY20tX/sDGA92vRSggSQmJSBwpy8P9fCQnrqmaH/kQy?=
 =?us-ascii?Q?CnZ9RyWXcfeqDhK8N/sLSQQCwJCM2vSN5mZrA5I9UwH0W4D3Mg87d39rDt9x?=
 =?us-ascii?Q?a0xsiZn6TasTygPAiS36tMZiyaa6Hx/2j9WJfd4iO9dluu4DqW7jT+3Lx/0o?=
 =?us-ascii?Q?d5/oHN1RigKgIKJqDntfwcQotXN98w2QcPYyBGBboYTk0PJ6szFZxdpf+Tfw?=
 =?us-ascii?Q?bTauHlT7HAfSpTxMlLd9QUl5qaySLs8xkvlZmWSZSgdhFENpFDlgA4ropDfj?=
 =?us-ascii?Q?a2mUrU7Vt1ZVefbeWYanEyVHxGjf8tg0QEYCQY8FGUM2TbfyVNam7iJQsGkU?=
 =?us-ascii?Q?FG1NnFLLdFazCkfRJY3BB0kKZlQR/mMR/c2UBpE4EM9pjY2l0MJMabwWV7fV?=
 =?us-ascii?Q?S+ByPXeRE6dBfmWZj+Q22H++jSVNoDDdKKA1vy/kNlQ9qa0zROAIfXXvTz6m?=
 =?us-ascii?Q?odSBv33Nzv8WxbGlDZqrXG0Pg1pAMlnxdwy2leVp+En2OXqzzmOp8kPgDdmr?=
 =?us-ascii?Q?GPn7PEegMcZkdbA0oIZgphVjoDTcRLwpiPrx5itIWmoGmwC5TOolDnJnkE5J?=
 =?us-ascii?Q?uM2x+qHJSofLnZ8yttGaTlV1+s78MfHRaw/rA940NmQ03kRPjhviWS5HYdmg?=
 =?us-ascii?Q?hTEZIrD2WqNqg+nsWi1o6TkiEZ4vPZeoUleVp2sdOaDwhDETiqvAJZnuQ7Is?=
 =?us-ascii?Q?wHf3/VTIvJCZC66Re3j0LGmjtXBN3B8DJXYBU/PuEGyEo+lZS4G17Hw7+bFE?=
 =?us-ascii?Q?SURf+A7jCMldta2pKXUbMlRAgqwIZLRasac39jrd1zkvMJRopYTS0gkR+YGA?=
 =?us-ascii?Q?SEcm1vvMtjdIlIqTVTgdk1bXAWf8q4uzBoa4mxmusfLeKyH28TtpVxEYRZDw?=
 =?us-ascii?Q?fSL9sabjq6YN0CERiXd797zG47ycZz5rIenl+O4NEKaT9stQe6yt4VCIaB3x?=
 =?us-ascii?Q?VH5iYA22HARxDObDb9+9Cr2hzljdx3DdbrHd3DQMAglGIv1gfWKZAprWrfdw?=
 =?us-ascii?Q?89ehDR+4mn0XmuffPaaQnnLp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defa7ab2-dfdd-4486-0f8b-08d9196728dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 19:08:30.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6k1vqDpvFtd0ODDOoRCLN5jWih1PxY6tzT87R35HOYQGSuSeU46mwZpIUVX7Qf0Ci10dxu/1PX8EKu1eyfPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unused so remove them.

Fixes: 5791d219561cb6 ("drm/amd/display: Refactor and add visual confirm for HW Flip Queue")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 85a947015945..81803463ca9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2521,7 +2521,6 @@ void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct mpcc_blnd_cfg blnd_cfg = {{0}};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 558821e5ed2f..25de15158801 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2286,7 +2286,6 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct mpcc_blnd_cfg blnd_cfg = { {0} };
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
