Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B97C433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463D56186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463D56186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09B96E428;
	Thu, 11 Feb 2021 21:45:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CF36E428
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8ktH2VoX7gGSZmgbIi46J711qS1naYjk9TywgfXPxUItiim8/hozqvUKcNlJVXddFqm/SoXBLZgbfM12bwMBf6iIvc8eXaT++EFXjmOLHPNER5cY4uLELgiPyePx3/uivTpqGpc81Va2YD5lnMZ8/SF6WzleQC8NFuCzRRSB793VsJKvA3QGBL8Fyd1YckPdJ5udBOi6f+8y0FsTMZBi9dmM//8/TkIItEwz2mggc1ExdBjtBVOBkov1AeizB41G1PCLD0uUqX+JVtPezZGghHBsrRV7Fhe9hp8iNleZCMssBGK+bsX8xQDlP/b55TjJEjml5pHdQzTQkyitW/tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LBeez2lErt8fsnBbXj/KI7iaM69UPNmQxLDntsypR0=;
 b=Ik19v/SvZ6b1ZN7Ol/jWjdVZolPDlfjHDm+ehZqU1Af//cE4MZAPTM89E2hvq3ngL0DLsP33Ux80Wzc1UKLcTrgaHMM2gU9X9FKW6kD+NDMOt+SNIWtk++NuDamCIeuKpOOOQoXqWblTSTXVU/mp6PAICGw7eC/EgxahNv48e029qIAGVo0jt8Um0tVVySbUgW4vrAmb5feg6DEWzeOZO6vEtnd3ts2OAEseQF6WFVi0KprPBL8iy73R/YXei59JkE8LhMuDkfOp8Fs6o96kUWJ0M9yfEhVv/GfSYjvwmSEE/3UI9U/stLw/DQPcWPBWfvNS54bZnFFbitLwWNahVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LBeez2lErt8fsnBbXj/KI7iaM69UPNmQxLDntsypR0=;
 b=HiUDxbdMs8vxTx0hlaqKTd4LGfAo7iE2qaM2M5DKb+RxNG8+pKr6VJH/wQ5vHaftfXM5hZVIAas0dlzrtZj1AtSM0Esm0ZhogOQp1LfOOd/+0R0e6bgM2Jbvagta+ZcOmyKzrBsuc517X32YX0+xJN0KBVL9/lofGgbmacZMl8w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:00 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:00 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/14] drm/amd/display: Old path for enabling DPG
Date: Thu, 11 Feb 2021 16:44:33 -0500
Message-Id: <20210211214444.8348-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3936101a-eca9-4f31-d8e9-08d8ced647cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235692CFC4E895B0F4F5AC6FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:249;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iV7afk4p3R5NhY/vFlsB+gW6tJQ1DrCv439q6qzCuCGRqzTj2PfUkI5bAF7vy1UNjT5NYIpSjd4y7liBEdSdokKAKtozw8Ts6RZl48QI6gH+fsdMhzYcRyhpyAmHRnSKaFXUbpNLlO1P9mzTPXzqol7KU+OJVa280OuqJzmurYj5S2WHrQ+0SbucJo7rWtsPYXr3xBbNovoL/Sk8aKGnVt2a5BemfmdFCArj2OssYMDosLxtffXs0EjxwjtgzfIS0NUCXc5O7cK68o5cdQ3j0SfX3xJJVZ766Il//4PBGv2X7UIcvw1ufTDqpZefdxEzlUnhObZcZtXxOTXrQvY1xg60NSq0k/LPIj6bOqfWhrFa6FSJOWGZJLcEa1TsSVbcJ0bMPQQgqQVJu7HayUuQPpMXLA3WCVHONSoq70E52sloTy90A7Swkyx3d/HXL/h+4mbrcwNptyUqeNnAY6c7mtbtMoAgUg+FcicEsWM9fbfkzdpNlfS3Dutfik6B2x6LjoYjs/g1w4qlA02xt1vG6zA9jWpkUkK6nplTfWf0qenNY5d+tBMltMKNhxWXLaedy5AVg+X/QF9eX3DG5mxL0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mQ2y/N7JGHYnq5iBIlE7Uy0T2pSGXYD9iv7qoEk9hSH09ekY4hUywA7KtTDe?=
 =?us-ascii?Q?J7DYOkEV4idr93VteNh2PV8ot3izxcJMqtNdg3NZZt3lzxiiHe0BcJY3aMzl?=
 =?us-ascii?Q?r7790P0SXbb59SEUo9BJgFddR+PLOI6SkayMaBcIiw7m2D5JVJ4RoZCnV4st?=
 =?us-ascii?Q?PlpVdXtTBEzj+6Mbm36tsWSZcwIA2jX1WJOB81lNlsDOssU9MM0MUled6qQi?=
 =?us-ascii?Q?nJX9n4dpv4/JLWRceQ2Nk4+gfJpFsERa0qu+zz9qCImtlvI8OhwdcfRJ60d+?=
 =?us-ascii?Q?cCy7+xMnrCBZ88xSEvfAYgi41XtpV+cgdmke3veFgF0ODDu8BJTS7oHMUBHf?=
 =?us-ascii?Q?6n/TxqT7rMj6T/EZl6gCPAAlV2r8nu3ggARsNk2X5xHiTkv1gAwY924ZGt3C?=
 =?us-ascii?Q?Fo622yKU9WsPaXqP3YbQiHwpri4XzJLBbphyQtK8SP/0/DYKPcueqlwW/fGr?=
 =?us-ascii?Q?u+2Nd5AcwJb0oX1a6V4xSvEuiOv2OP7i39F4+m9oKi9w7xytLuxGhUTgiREE?=
 =?us-ascii?Q?U8QhH4WudYwipMxgbRzvP9YGe3EMqHRlz/lK0tDD6o9n7vjDMe4YbVYVpg9N?=
 =?us-ascii?Q?MmYntRqoROAYYRbMEpKM5Q2lOgjZABvWPwwU/b9YAGMakr+VvMOxxAlMIcfP?=
 =?us-ascii?Q?fOYJ1MUiAA4es+phswrCfjqPgtGjdcbHh/UNYjBgR+cRyIYSAr4468nRn3HE?=
 =?us-ascii?Q?HKUkgoWPQJKJcjgN6Xs9jFgl3OsaAXPieLGiLZbZILcG8ABi0AKbWHavG+1C?=
 =?us-ascii?Q?kvshDyiCq1aDpLbz2vI+Crei5Hi5bhZLCO9UwdVayFbZ/NGhClwBmmZNQgdX?=
 =?us-ascii?Q?WJLIO//4qajWyqrlxwFPRv8agfxvjTWi7Omv7T4P11nKadrhm95yyxGYr7oO?=
 =?us-ascii?Q?ROY28l15xhjtMQ+LisPOC/BSV0dIfYB8nM6NRC/qGZVyvcce09ZbCUilmnPJ?=
 =?us-ascii?Q?dyHz32cUfe7YsSEdLsoqIdJEm33Z4CzJqCtDilBq5JwkHhGzjsz7mTFDp+jf?=
 =?us-ascii?Q?h9FmNoIqFJgwSafJy+kGQGisT+lyIQ/gmetmKvtUoAKE7G3/ODZLQ1bul+Yo?=
 =?us-ascii?Q?NQEF+4w8W+qxC41FBTTYh9k+GLggzFB22FbybnN+vCDShIBQqmPpozbvq7Sd?=
 =?us-ascii?Q?OaWTk5dB4nPzEuhsD0c4jix6xAeh1tk+JTdfg+3Sja3y6LX6ECNZa9xlzzSw?=
 =?us-ascii?Q?aF/Q5H+vSjLlts5gaYapsWW4G9Yv4tHZJrd7ButerP/5XJQOKgJOFt+KkpUl?=
 =?us-ascii?Q?npUa0HvA1VrEolswLiBSeUxNTR2d1BOjkE3Tr/AyjR8VVUch2el9jYOfthRc?=
 =?us-ascii?Q?fwevhdESxcFtEv0xOGUWt6x9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3936101a-eca9-4f31-d8e9-08d8ced647cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:00.0108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE66YRmwsWpNvgaci+qZGsKbirFfXu+p276hUyJrUGD2KaXJvAHV85nxZk+9W4gt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[Why]
We are not implementing the planned new HW
sequence for HUBP disable.

[How]
Revert most related changes to minimize regressions.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 11 -----------
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2d8c6e63166f..e2cc1a141131 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2284,8 +2284,6 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->dither_option)
 		stream->dither_option = *update->dither_option;
 
-	if (update->pending_test_pattern)
-		stream->test_pattern = *update->pending_test_pattern;
 	/* update current stream with writeback info */
 	if (update->wb_update) {
 		int i;
@@ -2382,15 +2380,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
-			if (stream_update->pending_test_pattern) {
-				dc_link_dp_set_test_pattern(stream->link,
-					stream->test_pattern.type,
-					stream->test_pattern.color_space,
-					stream->test_pattern.p_link_settings,
-					stream->test_pattern.p_custom_pattern,
-					stream->test_pattern.cust_pattern_size);
-			}
-
 			/* Full fe update*/
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index a4f7ec888c67..e243c01b9672 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -130,14 +130,6 @@ union stream_update_flags {
 	uint32_t raw;
 };
 
-struct test_pattern {
-	enum dp_test_pattern type;
-	enum dp_test_pattern_color_space color_space;
-	struct link_training_settings const *p_link_settings;
-	unsigned char const *p_custom_pattern;
-	unsigned int cust_pattern_size;
-};
-
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -235,8 +227,6 @@ struct dc_stream_state {
 
 	uint32_t stream_id;
 	bool is_dsc_enabled;
-
-	struct test_pattern test_pattern;
 	union stream_update_flags update_flags;
 };
 
@@ -271,7 +261,6 @@ struct dc_stream_update {
 	struct dc_dsc_config *dsc_config;
 	struct dc_transfer_func *func_shaper;
 	struct dc_3dlut *lut3d_func;
-	struct test_pattern *pending_test_pattern;
 };
 
 bool dc_is_stream_unchanged(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
