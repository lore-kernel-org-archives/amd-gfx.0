Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C5C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985E261447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985E261447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2126E219;
	Fri, 14 May 2021 04:51:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84236E21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6Ni7B2kZGXt8VuXIT4VG0m29POUUjoHIAwqtGtAKBKM9EJ8QlcfrkV1Y+sWgSnVUAu2Fn1um72ZZsKwh+byfckF22XS08FUDJosVIMdJ544D0LoPAT9WbVaXsSPxU4XF0zqH0TIsKG91DOmrddP8ZyMiDV0KAxUNjM+vzSmbhWliMMUrvfO1YjIrLSpHugUHEl5MXUH3uG/srHVb1bPJxcPOYd2/FdcEeLx7kpzpe9dQwOpSMG69r7I30ywEo8n6bSJnGoldyDtgtbCMqsFsm7CZRvStzqPSJ4f9x7k4llDp5R1nHpDQRuQtJsmCxm9USJI5ausIzkzhuoFE6Be0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S42xmxHj3CZFNEkTrJSVF2Iwc6G1rpX5E/ayMzNhn8A=;
 b=HcApwZrfRJvM/ntyKbjyiAQBQ5rhdJDcTZjRFcPCXCdNAm1Kh+3VDzSYOyzXUspHuNEAu632B5kQoYFZsb5IlYpq8GP7sE89rUsoK3U4xH+VyGQcbPzNwAuuZy4HA0P/TOF0WIXPb62uRj3R3uVnDYEd6gi1h+go83jhnxjpzBgfedf3iSsqNIqXLFhdpw8X5FonA1f0Dp6oTJZvCDAlG21dgJYbete9qmeZ+ONGL3FV4QMHbiU3auQCeZ897mePYHqh3po+ifxEEO+ynahkfd6jDA6Hof9s/DG3NITnOjXsMEaHN9f+M4CzZ3FkTkC7cE+oT2rMGdtKyLlxrnUtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S42xmxHj3CZFNEkTrJSVF2Iwc6G1rpX5E/ayMzNhn8A=;
 b=pUHnhAwgtyUqGuhgF4mnCSihT0FKsDJd6IyqW76TLVFyiAJR7pWeL7XtePNEPkINUz9Potw34423YLrI9JC9jJE7s+kZg8sS4160cmRwYrdZPR9Xv3fWwLLi4Zj/bJCLfW/EfUnh7nVdwfKc6eFIam3iJqdg5r4VV4qCCq0ZRRA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:06 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:06 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/20] drm/amd/display: rename perform_link_training_int
 function
Date: Fri, 14 May 2021 12:49:54 +0800
Message-Id: <20210514045003.3069681-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 479b6328-e654-4935-b708-08d91693e24d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129CD4D779ADAE7CB423F24FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2R5H8bfzOwjLhvqDHeEHrbcUl5OP4bSirjTzHSb7RfDpB5q2dA10X2nNKNbioxh+QSkXTEFYIPN6K2P0UqjsmNwjKknJrzjbM5zbik6a1ZspYMldIqzFOZZ91UUZjV8nqtMvi4guMiRxJ68k3BjyRwm+wjPbjh712hFkaliFnXpfX1L4Oq6lCMcAHkI3c62qPdirl75yqEqWYA9B4/o7xGgSf0uv16m9aHRxwX/iv2CGVYHPGZ/Ndo58veDJ1m8UK59wDlOgH1pHxqooZI2k9LoEqKlo9gnRrE0ZS2kJ1D4uMi3DrlVKzXla8xJDMw1FbUZON8ysHfzFs2bpiSpkZgvRr4GM4Q40N83dPdqoiXS2Kv/NieYSwGHT8AVdM+HZKpsrXPhqLyAujfnyZVRgdnHZ3e6J2IDTH5okVuOfnpLXSHv2NnCkQgTlulRrUa3mB6LB4/geNnnGIwD8ZhEXc2RGW3AW78u9ThIa+KAEr+WrkcCwAlHF3VmoLE5+ArMF6P6qJg3uBm0Ko+xloRvU+KudANZ/m8GKBNKRNl6f3kOXhJv13bm3OXv2mjRjypY2QRoaAi8QT/raNezHmO8mBwxh/mG89td7s51ABs47/0hjTTOWoPAIXwr3IZrWOkD4VSf7BLhPmDMujT2QyCKHW+XFC9a1vmk9YK08HT4g1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(498600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ou71RqQSVkgdtc0SWfhHAdxYDFHcpKJAIXRFCEPRZ1+0oq6IM2DafMw0UzAV?=
 =?us-ascii?Q?gNJS3XUN/QghtMjHFDzcCJBZA85CCVNqtlLJb81+tBJC/5zYbmNCN7/sR9WE?=
 =?us-ascii?Q?/6OJz0tott3mdjKtneah+l2h4iVti6YU/jTWxesdlbwihsv9zLROSpoWLRSN?=
 =?us-ascii?Q?boAdP/7xaal4AUSfv5zYlI5u2jZQokiIZHutg21g7pqKK6r91qUlFAQkk100?=
 =?us-ascii?Q?yDq4DKViAIvz9OeAv2B/eOKiWI6Ndf+EV7Zkr5rCIDOmxCnm3A3TX3BZIAgY?=
 =?us-ascii?Q?SH2nq9O3JYuLtRdl/hs+EmEl/Xk1s1qbbhc7eJ4P5mv9yIh7zpL7d/V/6hdM?=
 =?us-ascii?Q?oExfqH12LxQ8+aEGlP6KwCekgEa+/Hyw1jFMTMObnf5xIT81oMM6YOPQP33+?=
 =?us-ascii?Q?s0qJ5Zn3LHGIhL6SfBVOexDmNDMdZ6D7x1ye36N7vhuZKDGKF/iu7SKYMXkl?=
 =?us-ascii?Q?PJ3oGDt6QFl2ouP/b2uzs6mZk7VvmD4tQibICpgnTHzPYXiwnvyixOClUUHC?=
 =?us-ascii?Q?SIX54M6fcamGsvwXf1gRYQ+BfolIDPLB+g0sYh7g7MnU7Tfhp9quCMksv6kt?=
 =?us-ascii?Q?v4moun3xqcBgK+EZlhqmz/Hvu076dh6WFcStqsew13HmI/t+9svz3xDaS9nU?=
 =?us-ascii?Q?Ikof1iDq+J8nHeQIFsbRM8FiWEFnBmb//C71+9RotD7Q27mSfSouzjyglpqp?=
 =?us-ascii?Q?uHGzTw4JaEjj94LmEOojSWKcPPoIkO8wOURWJfjibBVzJhCBK+bCfXe6pslE?=
 =?us-ascii?Q?Q3LTC40k5iga9R3mMCGwrCv+ZRrsFQ71Y9Rbyyykxx/MMExoqWaCddKWJhA9?=
 =?us-ascii?Q?e0YcO2WTfb2XQ81h/tO7lgOdZSl0tAfNdBeatgvLyoY5qO+KojkfKobWfF6F?=
 =?us-ascii?Q?8MxRzEshn8Bj9Ibzw6zKVHW5hNRJ8nJzAQwoqrcP0FoTedIrX8Y87AujWDve?=
 =?us-ascii?Q?33O4hZEarM3db+yVFygEkxD6x0O0wiiGAAiAdYG2O9j+q9D4M3reNHAnLSJx?=
 =?us-ascii?Q?y9LAlmKrOatOcmzUirHNQ8eGNJSTtyLlKiXLdqRvv1wnzAdSMsYr8ThUdxzm?=
 =?us-ascii?Q?o7FLmFms1TgxYmkusjLjlhiMLPAclGVyoZ8U1dta6cB3OvXdde7U1WkrtOok?=
 =?us-ascii?Q?TiCkZnqYTCgZYgs2VTOaKMwL0Y+ujvXlKHJzfqwOYfVjzzXaLv4dfZ1yZJbI?=
 =?us-ascii?Q?B5PclUiuT3+O5Pk5hiVtomlmWIo14hsVPDFQpCmsm3wSljPw9hrAZvlBqK6S?=
 =?us-ascii?Q?QAM4rSag29VM8lu4xEzhJdhcZwUDSPV6sgMHeLehE2wcWilmCiukg5xp++tu?=
 =?us-ascii?Q?muxuNi7H2VifkNbbF4/ZjMXEygea9gaSSl9svAKtVgKCtw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479b6328-e654-4935-b708-08d91693e24d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:06.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pecyAbPTaY3AYwABLuuIQGrwRBrhADUNh5bRiG21tg53w1jIzygRE/5HDNHx7jtTrNpl8XYREf4uc/O2LOj7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The function's name doesn't represent what it actaully does.
The function implements necessary steps for our hardware to
transition from link training mode back to video idle mode.
Therefore, rename the function as dp_transition_to_video_idle
so everyone can understand it.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c295e48c697b..4b3467a5d2a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1157,7 +1157,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 	return get_cr_failure(lane_count, dpcd_lane_status);
 }
 
-static inline enum link_training_result perform_link_training_int(
+static inline enum link_training_result dp_transition_to_video_idle(
 	struct dc_link *link,
 	struct link_training_settings *lt_settings,
 	enum link_training_result status)
@@ -1665,7 +1665,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	/* 3. set training not in progress*/
 	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern) {
-		status = perform_link_training_int(link,
+		status = dp_transition_to_video_idle(link,
 				&lt_settings,
 				status);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
