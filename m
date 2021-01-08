Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B489C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF9623A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C0A6E8E7;
	Fri,  8 Jan 2021 21:50:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B126A6E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+FWNXnTskEcAaZBDmTmC866krYgM4OBgsFlynZ+yBnMm5wituQ+ya0w1U8VjTDEaVMM8JKgiKeS4HMUvos5xS1Tf0dURrT6rQMOdxvxgRpcgEz+WT+p505PPpbZ8dZbuTWPojCoHoCK/XpeUzj1Z/cVdkbwqZtiGKOCD8jItU0bj8tCQtV982/69hmC8Ca8U/+8AhzYY9K3q2r+YgYGroj5mgrndUKOF8lM8e1BB1NYAaOMcrd36Hctm0YHrhuVnuiTYpx/iKJSQPORJHmhK/+fMjWYEkXagszEZQRyxGwzfR8IpC1Fx5RYuOExou4aWwjhqvBkwwfJtvfvzTk9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKPX3PGtcfrXhZDfjQztV3qgamDon5wm0rzkkRxwvwo=;
 b=aesoIazjD6XWWb3vXyk7TPaudLQr0Rd74QtzmsM0vPUJWTmrBk1Nh3FjLB4OsdxAkP5kA/c/EORkEvjqoaKrUwl8gxy8ZTZ6aSSz4izF6df7FukvZcR4VtshnOOdJmaBW096gS797VX94Bd1Zae+8dc5MQWRLxiJ8TFtHBnydlVaHfBqpVc93D6pYmIaIiAoLIG9jTjAy+JcFRCcYbVnqw8rJdACYqGMgEw/vkav7FPztvshLJfVzPhQkP2E3+DZnPuHem2QH6RVckUtlgRG9C47XLu9bPotSOQz6BkMD/4VG9doUeviHFGKZ6U5zpMoaeHwoIdLiZ2oEPJAG6CsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKPX3PGtcfrXhZDfjQztV3qgamDon5wm0rzkkRxwvwo=;
 b=yhodbjIaKMftP0XLQ6lmOHE9GgCh88vro7F/1rsjEHRHjBHq1keCpTpesHC38134eMbNktICRT85+/yYn1nVSaX5Nw5pRs1GE+SlqiCXukf8WZfXmTkrm83RLk+n2zVcquLxahEDmDno+gOhtApyA8C98sv9It+P1DujUufQtUM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:32 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:32 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/21] drm/amd/display: NULL pointer hang
Date: Fri,  8 Jan 2021 16:49:48 -0500
Message-Id: <20210108215007.851249-3-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:50:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5df0e21-f67d-4420-abc7-08d8b41f6c2d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882DC577072083BE49064F298AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daYpIycvbf5W7e2O7gyzk6GdpWCtH5dbN4622wo4Ke9htVr3ujeYk0/R4v5daY4ia1wdsICcVwOTiDiv0WSXUdy1IHRF1E71fF6nuMW4P6oZUFYWSz65MpbAO+wtHtX83UzZ95SPaSSrxKffc8YTizXePEc3PU2wigE5OKiGXX6No1vpNNoU5IHat79iRlsTA7LILGgl8cb8zlBJphWX6gL5MrrzbSYMiThadnXyQWV9o/SACuvTQ6QqQwHB3r8clEnw25X4Te31h46r+y36Pn4IpBiLCGxTzYbUH7oRGE8Pf4WHzKvFJaZDPZv4pJVce2u5rFgOanOnl/u3VttcBB8u7IFrs3shIfNSCZAnG9j+GRZo4qIyNaDW+WzUiLBfM6vIeFgaa9SrPrwYzKF9Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FrD2NAuMfqmXgEQW/pmMVDshZo40j1qXsRuHcNc0ApK/txVC902ewbUfQ0JA?=
 =?us-ascii?Q?QIGFcULvqPBPo9TvU6c+tVaOJIv9e3d4WpzhUPoTkW5kucHzCJuJdJxZfUzy?=
 =?us-ascii?Q?PelWY81DPMYgTopZyeUiH7BlzrI4aUkxrBQyarntws5Z3cahIGmf+1DRAFWF?=
 =?us-ascii?Q?Xd0grFe3dn7S1h6JX926lA+N1rLWJmRKJI/JtraNBPO7B4jc13OUdt+bamVp?=
 =?us-ascii?Q?e0k9+zJhLv6GG1x9cMPozwAOQ05jcRrWQ/a14+izv/ixd5bkYX63mwqvZxmx?=
 =?us-ascii?Q?rwbzZrfwidjPMxo1tmlFikP4hD36VVR7ZB4FJrQwyg8K8H2dTQiLb0U7908r?=
 =?us-ascii?Q?x1Pmv0Bj0f8aaMmjlGCGQiaF/JbAvdWRSQ7mUp1MzkH9gU9w/j13pV/IEzHj?=
 =?us-ascii?Q?GA4bdbiqpY4IR4rOLzV715GN7GCRnPBbP3YBmXUh/TBt1FUnOedxBqYmj7c7?=
 =?us-ascii?Q?eH7+lVMkhu5iiRfgjkH5Nu5X+WzjeeDwE5Vn8Di12bTAQLgITlW0OSKcSmyt?=
 =?us-ascii?Q?T3l9Bfu71oX59gCVJbhBi0CRyhebsS7ce00WKs4mvHGas9zhXfmeiN+iwZdI?=
 =?us-ascii?Q?j9THr5ie1U4XknEiVCmFDA0cbxzKFqwueXXRY+MdFJN0pf7A4Kim63IUv43y?=
 =?us-ascii?Q?m1qFAcKosGTsfs5gSpeXmrP4n2uADCeWfSsQ2X5J292tW3+N/RUlb6jrkyTY?=
 =?us-ascii?Q?Y2w76qJxOQqVjrzZQijpHXYzLycVCVnmwNGu62pyNi8fMUZwnpIYWdxwPe4R?=
 =?us-ascii?Q?X0u0qJun3O4Rl2PMfOIK10WuAo8Bimb/jnKHcvAy0UykMUn/W78pBYe7uX2q?=
 =?us-ascii?Q?etwcR1B/p2C9NC5JIVQhIuVhcD5LrdcY2yLa6ppr55TYQ68Mtl8DK14T8Btx?=
 =?us-ascii?Q?/1BfNUuBvuMVSyWCTmoaYGv2F0Uk6UkEFUABvw1yjEKwY1tDdx5MhG4gRzHg?=
 =?us-ascii?Q?j8JoVWm3lHBNYk5G/ZG7p7bJZXnhn0lMKfw/AuchuOx2TEG7bkIia5vNIuCk?=
 =?us-ascii?Q?FrGhv/mqgWbED+bkpnbwJ7OMvxSQC1i22vjRXLE0hhJmiW9wOXxBnUlULil+?=
 =?us-ascii?Q?d9kktBTZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:32.3234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f5df0e21-f67d-4420-abc7-08d8b41f6c2d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 804pr8XgurZjTIbrQx4b+xrZ7hTR0XhKM/I9ywbCSU19kbJPTqyJvvSkzkI42mNidl/kUfeKI1dhUwIYWnVIEQ==
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
In dc_link_dp_set_test_pattern, we assume all pipes have a stream, which
can cause null pointer dereference.

[How]
Add a null pointer check before accessing stream.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2fc12239b22c..1bd1a0935290 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3992,7 +3992,7 @@ bool dc_link_dp_set_test_pattern(
 	unsigned int cust_pattern_size)
 {
 	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
-	struct pipe_ctx *pipe_ctx = &pipes[0];
+	struct pipe_ctx *pipe_ctx = NULL;
 	unsigned int lane;
 	unsigned int i;
 	unsigned char link_qual_pattern[LANE_COUNT_DP_MAX] = {0};
@@ -4002,12 +4002,18 @@ bool dc_link_dp_set_test_pattern(
 	memset(&training_pattern, 0, sizeof(training_pattern));
 
 	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream == NULL)
+			continue;
+
 		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
 			pipe_ctx = &pipes[i];
 			break;
 		}
 	}
 
+	if (pipe_ctx == NULL)
+		return false;
+
 	/* Reset CRTC Test Pattern if it is currently running and request is VideoMode */
 	if (link->test_pattern_enabled && test_pattern ==
 			DP_TEST_PATTERN_VIDEO_MODE) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
