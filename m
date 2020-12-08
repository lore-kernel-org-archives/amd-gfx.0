Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F912C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1598923B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1598923B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0419C6E9BE;
	Tue,  8 Dec 2020 19:29:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DB96E9BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI5ZFYoZkkUoKj7T00T7BxmEFb9D5RkLj2BlMo5v51LicmqKh2l/695WipsdZPsv588LMV9oupqCoSK/gNJ+wYGR9Zx3p0IXKtnXV/PR5MMn6dv2JasPgMLJxEzh0jFbhn5MIPifCdb2r6AR/BA1fur1HY4OlEYqzMwJEmAIBZFEUle0wOXuSWAjfFzp1kt5LVfQQ+KL+VF7w2NtfNz+4UQ7fnASpdPrXLkOC2zRPSJccIHzIbcLdfgyHVWPUzpQ6UL28HiAcab3keM7U89leS6KMb0hUeVJKN1M4Vuz6usp5HdRMEskoBnK3CUNLApdDh857V+68cJVxEr6A8Tmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55so1mF43flw9avCXCrITQVmtvBqtaQvr/1Ib4Ujk+U=;
 b=EwAje4+SJHs7JNo53/X6/Onrq9jvURZXFe3rrfoYIRhlranCBpL8YRo/AmoOIharXVYVRjrD1+WqDFq65Mj3H1HVamflrBtZy/YIDq1SKgUur+WkmsTLBXV4IkvnzL8vIZfmJVukRjVHqUWISMmKFeTMQ7C2QCGyafDSFr7P2NMo7SGZM5yATdxYuv+95r8JHQ6AaNIeyXXTDQKmCuW+hW7uaUecwDVgdEDeYirVN2x+v8xDETKAf1097i4vLPRxRkJovsHa0UtQD8Zyf+cdv6Wfg/ER+7vk8T+wxsu+sQJK/DdYOhctGo0+hKU1OVLVbz6AYRWltVoEWi6epyhZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55so1mF43flw9avCXCrITQVmtvBqtaQvr/1Ib4Ujk+U=;
 b=ldfKytiRePYC1AkNiJYzAJ2FlmeMfKdBcaFtIW4nP2cNHWZS8vlRL9npS7odnNK1Q9TyhBcNz28YQpMfpwUWYa221bthkfOM7DMiYGwk61evHQez9kqOuRbXNeT0m4rLqAulgxs4KMbKXFsRAIEIZE4EobmIjRQfPfkZQczVr74=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:29:00 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:00 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/13] drm/amd/display: Add DP info frame update for dcn30
Date: Tue,  8 Dec 2020 14:28:37 -0500
Message-Id: <20201208192844.23580-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4123db1e-6505-44ec-e3e5-08d89baf83aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388920FD1731C02C4D12503FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OH1GtToNSf75A6QkA+zpIdXwEH/cD4Ut5Z6XUE45+8mZkqyDmhaSeSmOoMqiZufgjzeSXJyCOsXR4SZvdZ4jhxZFbcG+1xtA7Vv16PPqoQsA2vB6ihBr5KD594WymJzRTBr/tKzbnismw5Jaey6W+Ou8L4PdgozxbeDWmorhGxEhQBCjMigcBczNccKk4VGS31GLmUSyQbt8ltTIt8LcAcCN8AHXcltJvYsHfKepkBQDJ/tGihWrvMAvD8CQJ1FbjiTE1CAo9okLGhp+5/F5oFbbMq9LadsVf2bIKy5PBFMVgIYhKpCF5pEANW24YtabhQ+mvw0CUzbDmw82Av/EPQ9JhzORnYhyvk1B4j2sWmrqPzCscmh9vcANM0SP1lon2YAsJGa+MYj/rvY5oxs01cn/pnlyIykci4juDO1n9XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(15650500001)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(4744005)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5/laQSs9KtWFvLex/7csV3XNKUzi0C4EXtZ0dB3vt5xjIRixbpgiqy2jO4EG?=
 =?us-ascii?Q?lumideApUTocUvgMxZccHLXKE8g88McAFt2EoDBlNGEOGI/9l9/rQ14rhJCs?=
 =?us-ascii?Q?gcPFpt+2hmz8DLs9uayJDMIXEObBxBN3EQ/QRaZdK7mQ4NxZxplaAcx+mxwN?=
 =?us-ascii?Q?cF1EW01HH7ZEVEB8u72T8FruFIthXtjtAaYmky2hcIutmSYkFYXIRPtxF+EY?=
 =?us-ascii?Q?b0Ee8GczBqU0MbIHbYFcDnqL4tARfdZGfi0ze3xHNaazj8LoXbxN/mkTa98J?=
 =?us-ascii?Q?lDRgeRD1qHrWYoLnAmAAkEUuQOEzPLzRT8P7lc2+puu3/hqCd9Alsi/DA5vb?=
 =?us-ascii?Q?umg01E81c5MUj2lu/EXtfFV3+WH8+IB3wL3aRaa478Y9Qp9k3a67P0uko3Ei?=
 =?us-ascii?Q?4LCzhMih3LyaJQ654E0e2kooFKjosFVDJG5DycxUDiMH761dztZ1Mu1FHz0j?=
 =?us-ascii?Q?l2q4eR5OCm9CdvSk9S8BujY4u0lEAshiePQ0DQ4SZBm2xG9/wKs5fgdNaaOZ?=
 =?us-ascii?Q?Ylx9Wj60A60LDIXGbsFFNgJgdBUyIqBfwygytMMwFGlvazmfhTEr9AeoBcI1?=
 =?us-ascii?Q?Cm1dtBeZUyNqpGg6auAw6teQ33CmWrdvDv7HRGzBEN2qmGaE7+FAXOKnYn51?=
 =?us-ascii?Q?+UWu4SeCFDjDMyw5VNA8DQDX7Fzm01kcxV4zJhCgs9BPRY1yhdGwyle096Rh?=
 =?us-ascii?Q?IQ9K+Dpa5wzfsNfTbdv/GUh1PBUZTFpEaycA0+y1r540YnzUMINCs/AEMBpd?=
 =?us-ascii?Q?sp2TMPzI9shxoAMrrsh/9DBVOPEhXToc1uECBycANwxChnZ041d7cPbS7bSP?=
 =?us-ascii?Q?wOV17AgZAdQ2WSACOzVBCFfJxQA0PoxVjgGL3/gkVUtdBwanCwHRJSkxOcu4?=
 =?us-ascii?Q?zyhGPDLkvtbVpenhylxZcIQf7x3WkaGLyVy2fgFm+72soInnLD0BiqOxqzpt?=
 =?us-ascii?Q?fbrWqfG3ywvEQQIlkclENpyWCODR8U6ijW7okVYgDHiCAvO5oQa/0dboJ3Y6?=
 =?us-ascii?Q?phYO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:00.2442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4123db1e-6505-44ec-e3e5-08d89baf83aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WfSQswTc4Gz+5shQHx5ogPvMm9djPxb0ipY1YRvFVXIOPgqGvnyKiY4pnk2To43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We are missing the DP info frame update on dcn30, and this will
lead to DP SDPs not being sent;

[How]
Add the DP info frame update for dcn30;

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 283995ab9eeb..3deb3fb1724d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -668,7 +668,7 @@ void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
 	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
-	if (!is_hdmi_tmds)
+	if (!is_hdmi_tmds && !is_dp)
 		return;
 
 	if (is_hdmi_tmds)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
