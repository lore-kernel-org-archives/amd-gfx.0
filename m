Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7FC43462
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419656138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419656138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC72A6ECE1;
	Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D6E6ECE1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXoiP2iKQtqW5xmVXDVZrzNxU2Vm+QW8bai1WpAxQEdl2HgPTafg+J30z9GwIPBhmi7l1FpqGtaaZhRdZ7dOp7svlAr9FARLU33hl6Zw8BYWuU5eVCki2j2XTF3h0tmz3ggZRYZRtjrL622YHOD0Ya4xusWJBt0TOB0YIj8WhjqcuEY3qaHwq4/tUzf2VBe381LDXV0bZMi6qDnY+G9JayqHfYKgtqEthJSPB4PD+0+OGct81yrvFps/Ba2ovZ9ioNHH/eW/VNil1jCIWlaJGmQx9Z+7ZblyC1/lNPY+aaJy0pPbz8LC/h9HfcUEVyWzL8q6fMtoULh63svJoYgIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTqKfdFtFDgui7QI+yVfjN78b/Ss9LSiie+7sNAOEJo=;
 b=f8gXdgnOANtW0AGaPIaF1d4t4kD20ctOReqIm//SoyFVlAoWyzGWvIcAlV+FOKygXc77nHCiZuKWpBByvbbIp1g5aWzzoZjD78sSRQv8MxJdwsk5qe1p+Pq4bbCB+DzhS2xKR4H4RKN32+MYnyWXn1aRFOuIrzuLz6Z5Ey64BkYhQIyftvaKyL3VO4GeqZphsvjudO14hsp24KVesVelnPqSbulxPi88DMc2iXjhmcqJk4Xx3bVsAIGhLqgl06Eiqyg7NlEHSBfZl+MMp6aoAmQb+PA54xoTLrzry+uD6H1NPoy3oORxHkUO2P4652QCMD4OK0S4KeQWp1YkyPKjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTqKfdFtFDgui7QI+yVfjN78b/Ss9LSiie+7sNAOEJo=;
 b=rrto594Py2yugWGpMgpLzfsnM6VyS/pQN2XdHL88yXOh6tr0l/ghzccqega25tXY2ka2S3P5zgB1TGq2CKZgjHXxoSRLEmJMfBaKf6NbmJbS9BM44BpSZ3Elkde2tE+BDWW26TmF1VvOhTl1K+w6+v8ogJv3Ok9VqaekyA3Ym4Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:45:59 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:59 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/21] drm/amd/display: add NULL check to avoid kernel crash
 in DC.
Date: Thu,  1 Apr 2021 12:45:11 -0400
Message-Id: <20210401164527.26603-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 731e097a-eef4-43e8-65ac-08d8f52da08d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46193963D4497428560542E6FB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OthIVuAD0Li7fBlT3JZCC/ekWJ/jFhN7lVBeHTYbTWgahLpiXDDiT7Uwo1ysbe7qDGTra668MumC4okW3n5vOZ0j4aUD8vCBGP/bnpOWA2A06kU/IKI7O/rNm+FPqsB+yGLT+sjFbGRIiaY4UhhWBG3ZMLFiI0YMHWpTfRx8mVi6ccPuHGS8CWdNPAqXn85lGwoSnriDRCOQypjs0s240BWaTBMQsB9o9JxR9hMVKssdw3zN+D+gwogg1qG/V8z3I4THDrZNik6jRWMDOrOdV4wslFVDQAK7dwo0hRhtwiu5KJsGBVdyWUvVArFk8bHbU5eKeDEQxjk0pZ6gTMDBrd/8nPGNiDSxDUmqWn4/4HK41SghKCJsfUpMaKc5zCBLEgp36IxnCNj9H/b2PFiu9raseW/x2UrZKIpwwD3zI4qiRwwBAiq7TewXBeXcQeZQHOuCPFuJTwSQlE7RL8dt/HqLdR3/xp3wMajHh9QJN3Is40CngYkSGgCnnJLFpLqQaDgHeAJBxrnbzPi7Hqewz6n9SkerYLfUH4nkbfYIhh6E5MDB2QznUj7k2DYnGvtIQo3qe7pawHUvS/OCQdZiO3WEdZJTZgWg/VJ6KXWQWuxyfrj/S58H7PuDo5rZ0xDLx5u8B4q4ehjkaF/2GNgOcEVo2ruVZ4n7P0I3bfbYSG03d/woFGvROXGfSqfuVKma
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m25zDqUTZzepdFP27WJy/XTJXG2NRQMm092TQrgVgbOWfy8RmhI/dR0HIrPp?=
 =?us-ascii?Q?/+3KNa15eq7n7EKDHeq4xObabHuFmBKNLcE6b7mXybe+YHV4CUHBhsJMddbw?=
 =?us-ascii?Q?zAg3wHH4g/VdxCP+bAlcKZJJe/am5KStnuO4hPhBOTJk3fgOpcjX93GiS8ni?=
 =?us-ascii?Q?d9wwalRdWHW2UXt1qNwjXRij+xjJzgMy/vTqpeGosnFMXIijei/Zjh/r/sAF?=
 =?us-ascii?Q?pWFdRaAW152QMOAulmUMF3ExTsp17uZKixd515ZiIWPiz6zUgNCJmHOWcTE4?=
 =?us-ascii?Q?5xtnuY06d4N16WFxBfE3tXsquPhBy7hlvrcL8Nv0ZZWD7+m1AimolH9oVMzW?=
 =?us-ascii?Q?we6SaNPxKSD1zW3rIZJ5pCscuuEU8nwO+gaE0B6r31jMGIOHA1F+jxGIl7lV?=
 =?us-ascii?Q?PrOgCkLMy4TUIlZNydUKGxvBhJahLDJL6pj/tgb04o17PHgK9MczyYPPx3Mf?=
 =?us-ascii?Q?xGgVJV1c+spMXPYdfc1VoJzxJtRuk74uEJM9TApYz44wOMs1flP8byEQYyZu?=
 =?us-ascii?Q?mYlSzzVQ04YFtSBPOIrgvtYbAFJr6KyWiFUmtuDd2QfyxUoNko4OrqZyasho?=
 =?us-ascii?Q?EdDiBwnnG2tDQ24Yn6/dwLgPoXVWbDlmGSbySMOBIptPbzo0XKuca0ye80fp?=
 =?us-ascii?Q?V+L1BsnN5DW9hcC0JxDhPh87NWILNFTS7SRB4zxm7zkKNIEquKHs/Ht1QWqQ?=
 =?us-ascii?Q?lmDiQ6ZtmGeTjZXAFIHY5CBqcpq/stJxaCgDHazwAoTcr0LQIaIGPZV6+v5V?=
 =?us-ascii?Q?yDL9DNGX+qxVD9jcn0rr8QaaCiTvKVmY15sL73bm/u9tyG2B+hwp2/VHkpYA?=
 =?us-ascii?Q?Bb0+bUd10amA++BeCIVPJEqCcCOavfIUWR+Js9LBmGp0aVZRR6HBOht5qCv0?=
 =?us-ascii?Q?VThjgMBJe53VY7aiCT4/2NQn+1NS5vvvE9CxK1vMxvHO/PCKf6k+wEE/xon8?=
 =?us-ascii?Q?tI4sSYdKN1OJ1k2W80g5Vrg//BK8zw4jH7lKVWl5+SlTCqH5HW3UZwSnrg36?=
 =?us-ascii?Q?+wSgnbWlWub2NcSM0xXf44KIAinGV54p98ad/PI08v3XNJJ0Qm+67UMzBJzp?=
 =?us-ascii?Q?SYf8Oh//9ZuBjbTO+UdrJhcsyZwVA2KqjiGU6Qo65v1fgJkwMYgJ16LKNfjC?=
 =?us-ascii?Q?Jzw+kCsFn6XDSy33ad9CYcPQfsBneS3UNy6lYGITergqYMTql5B6zrOzAZjB?=
 =?us-ascii?Q?QmapHHXChccumHpMKvMTRCsLij3vWyjRTndXq2t49IDikc5JX0eWv/b40hQh?=
 =?us-ascii?Q?ZK1c4pJtO3scaGpyolaulaeHKtcvCfPSaEOQtLPh5xlUZC017jiT8gy2NK8U?=
 =?us-ascii?Q?VkgSRC5xB298+AoVnmRKTlhM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e097a-eef4-43e8-65ac-08d8f52da08d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:59.0798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to5nxJL5y9AuRyRdaDj/aHztQ+eXqBaw3PcsJZYlBqN9ujzcrfzdcU2fOgfxq8lT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Robin Singh <robin.singh@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Singh <robin.singh@amd.com>

[why]
There is case when the userspace like IGT test updates the custom
timings, i.e. the number of active lines CRTC property value,
and without committing the change, followed by
resetting the display, creating FB and plane to the pipe
and committing. The NULL pointer of pipe_ctx->plane_state
occurs and result in kernel crash. We need to avoid that.

[how]
add pointer check for the dc_plane_state of the pipe context in
the call of committing planes for stream in DC component.

Signed-off-by: Robin Singh <robin.singh@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d9ab134a178f..c0ecedac83a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2815,6 +2815,9 @@ static void commit_planes_for_stream(struct dc *dc,
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
+		if (!pipe_ctx->plane_state)
+			continue;
+
 		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
 				!pipe_ctx->stream || pipe_ctx->stream != stream ||
 				!pipe_ctx->plane_state->update_flags.bits.addr_update)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
