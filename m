Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E79C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5912408E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V0vsJuVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5912408E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EB26E91C;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847B589A08
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc2rBYSQIwcdX9OK97aHipoEDq7F7JXSuOJ9bOuAxhZ1P0ZRbx0c9YVCWZoJIh9JmOgfzMB8GNnzozwE8vNfDNd6WBlPvF1IZhlBKdoWJ4BPHDEdLVHPgGD4/6Rfnh9suYz6tBINZlfr7WQgaE1rC2CLFRl2B3YjbFNwuWdYgYRjcs7m8qOP2RozFrPv/jAN10kpBbjq6qHSLXOGe5yjWpqT89iTEdNr2IngCshbY3HW5SB0TRi66VDPdNIGc86cnyp02wDEI5mEfSpniuu06jinApBVS3ptVW5adcW1yl4F4CAkl11jlO26eIH71yGiWMzAekj0pE8rKJsJgz5IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3+aGnJyGIgUbyVB2GLMn2MbGf979TPPr9261thzuvc=;
 b=l1j/64uUJMOHJ0B/Pg5nP8lTPtH4dmVeOYSkX5jnLG8t3fITkHvtGpfCxTPHZbiE+2bo/7Nf40Sk8dzhY5pUOk28mENdKpfJocsJoCajMqHVgl4ufNiOh2+7BR4/Sq25kP2U9CjboCvuNT4+URnJQzEXqwHW4D2QKsCcqjR9N/oHdtYm88DDrQA0pngvb4heh9qox1snUyPjzo7hLLt7RtlaikOJDaZhlE46jMa6MdoCi19rUXYH7brS3As0RI0NXJkBugQ5pu68PVeEUrwKxochC00GdAYi5k2BroxGd6KGYa/HxSYn3FwphTu5od+Ao2JGXAvGW9E17EycKWISlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3+aGnJyGIgUbyVB2GLMn2MbGf979TPPr9261thzuvc=;
 b=V0vsJuVMphhf1Mi/YVqT6kbGO0zU+6NYb6bIOxwknytL1I0Q93sOlGKwGKr//jABKP/V4VaIj3tGv+X97eC9mxqGHBddeCkcoVS8/q2yba7MW6DoMOxXyaMTMRYdw6omitwexRviGDtavokwZmiv1B28utrJ9Q0jPpQfuBHsKcM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 20:20:26 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:26 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/18] drm/amd/display: intermittent underflow observed when
 PIP is toggled in Full screen
Date: Fri, 20 Nov 2020 15:19:46 -0500
Message-Id: <20201120201958.2455002-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b413b58c-415f-4663-0753-08d88d91b764
X-MS-TrafficTypeDiagnostic: CH2PR12MB4216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB421611050DDC5EA0B0063B9C98FF0@CH2PR12MB4216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm0vAGpbVAo7LPzhc+aCCC7SmEwoCEX5Tb7xoP73QLrE1OE5WDlVgeNFxfig0sMTQ34HwBD57DbrAs+yWoIvRBFYwEl+TxViEwOC+g4EQdfmTqhB9uqP+Cw4BqHJlypO52kYvDk4ltbTTs60mAkcbMx9IoklosP4idLhCh0DDBpz14mCbOc2hInEzKEaiSOifbOuUGb1L5XqdhRVR2XjND8Iv5xD4QXazVN2PO9ZMEYXCDvECZAB8IlYRINIFXcdFNKTqMRday72EqH3LtiBbHYIGKS9108aBfnO/kMOyqepYbXiHbsu8fHyZgFEbZmPeDIQ1kvZibk6HRCmHqQ+pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(8676002)(2616005)(66556008)(66476007)(16526019)(66946007)(6486002)(186003)(6666004)(316002)(54906003)(478600001)(6512007)(83380400001)(8936002)(86362001)(6916009)(36756003)(4326008)(5660300002)(6506007)(52116002)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oNpQtU/AR3qJL54RgT/sm+S2Mcuk7y6ch7FqDMDspf2lu9dAmZgXaM5BwPbGHtvhtBZmNiYJs9zkXJr3ApSooXYBH/RSC3Ebwo7lSOIlon6GN9IbuuNgLVJuIkdHayTP/ArySLKWVfNn7UYb9yoK2yFTF3JofYGzXPjWQx1vugIJptY1+nG2XOQrzaQEHVk1Z91+bUPYDmNWSmQ+1N/D4OtiPlz3nnTKnQnboBwo0kQrpenDdk0Wu8heEfNvDq6Rz2zlKUL68CeQb0pRbTH6Dm58Qe4L+umomQOW9M3T1YQKHMfvr+kMCFFDaV3c5wSsq8IW0wvMrFt/9wF/jzceQN4hAEOiq9SDNCfKr+0sPIhhhG5vZ7wQu3bJ8XywCMpKFZAzE0mNnrJJsXoj1sbR9etsK33XPeUp/m4tut0Z0FiyJcUiMisZAYeFTFjAtUTxatSo2zO1MYIOUpIkz0pWr0VpVtE0oOwaLguaRHIanj0zgpzST8Vn4ubepPM3Gyhp4oA91FRoVkQIC2cw73SLtQ9I9V0xq54Zn+ADeAYskDySXiloVoP/fU2ealWKlfgjWCynmCw6zbL3ZnW2lMyZISX1OfiQLn5GufIbwLHv8wcxRxRaY2fwK3wVBNe6xnqnz0Y15nSFAEG+xmqyNSt/7lJFteBGvBj9obb076B4KGoNRdX4on+DEFMWPb9zh/ucbR5i+gLGxiXxDqdvHYw5oZHQ03wbzvz0HJlMjN7jLEnSzDbuEAPtijm3FBgfNYLy+7bahBsvDVCUBti+I83JHyKrLyG3HP2icROanDDHSz4FG7+uOBd6wxFWyfXWUNmEcn5yxYaVm3T7mnyHZ4fKA680rdpfB64srmP5Hx5V6otfYdPp/m+SBRu9XVtu2/eK8p8UFyKgt53I8zxYrhRfbZ2Fd9IDw2YDl4R5DPOAnPZrk3U7ytdtOY1AgBEX7gr6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b413b58c-415f-4663-0753-08d88d91b764
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:26.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqtzm69teu4XgM5VrGKIf2LvFq4hjz2f5kFiegQEkG+q+hr48a3S6yps98kiQMPkHBPTxVjAfau5RPdhhAavvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Tashfique Abdullah <Tashfique.Abdullah@amd.com>,
 Aurabindo.Pillai@amd.com, Tashfique Abdullah <tabdullah@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tashfique Abdullah <tabdullah@amd.com>

[Why]
The MPCC may change and request data when the pipes are switching from 2
to 1 or 1 to 2. During the switch there is a possibility of underflow
and flicker/missing data.

[How]
During VBlank the MPCC won't request data. The trick is to delay and
wait on VBlank, ONLY when pipes are either turning on or off, right
before MPCC is reset for the pipes.

Signed-off-by: Tashfique Abdullah <Tashfique.Abdullah@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b9c20e30d99d..abcb06044e6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1695,6 +1695,15 @@ void dcn20_program_front_end_for_ctx(
 				&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
+	/* wait for outstanding pending changes before adding or removing planes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable ||
+				context->res_ctx.pipe_ctx[i].update_flags.bits.enable) {
+			dc->hwss.wait_for_pending_cleared(dc, context);
+			break;
+		}
+	}
+
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
