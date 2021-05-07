Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D66C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48200613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48200613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB296EE46;
	Fri,  7 May 2021 14:59:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B3B6EE46
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9djj/FMEIQ34lplmLDrGC5ksIaW3/A8ryGlVu/7+zRIEFAp7H9HQwmUXHJm1jxJe9Y3WXcIdYpT3LgGBX2L2AFIVSGLDXwPNb6T1qO+lg6kUB9YvqbvaAVhMLGGZmah8yapYbABO6UI3ievSkR6tKdQgMG117xts4nztkKXKpWqayauHlTM2MCk2erkMs2KhUPa9cZU1sHh2iqWGD21nee9cF6ItzosWx1pk9sz5JJVtxi3FWC4Todd1Lois+uClWJuIqh8L74K1oKBJ2o+etCVEbmSuA+8b64KkP6FcxWIii2Tft4Oz6vslrvzzOmMSY9/wEOfO5DLxcnOd0RWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DRYjF4mqY4TqOacIJVYR385+toNRoQXJAl3mHHGT+Y=;
 b=d3UKcmv3uwjKRcJPjJYgWfCeBCWQhSIYceE/VZ2XpUCNiC9Av6dJnOxDcm/fp5xCey4i3Qu4hVV6irCOynmdv89ynkGv6O1WC4wEXpfq5MejWsK8U2o3W7TxVFprReSG31yVTLf9CC/e5N6tBZ9319YNbf3Ou9srsPJWcOsW6atbJou6rnEZOpogH6RpHhM+56dn5J6cYfRlffJ/BlBAhTGAVVsddoIACM9ZzRSLkHhKa7siWhA92r8RRRCJMApSyqTBdRX1xihn31U4Ag42QFnV6l3ugncr8uVZAHfyQFegqUnktNqhuVpqH1ySQ/XWyFgOi1BR/FNw2JqssbqJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DRYjF4mqY4TqOacIJVYR385+toNRoQXJAl3mHHGT+Y=;
 b=HXNIO3/DaZXU+fDmE3pgNClcc5v+VX9vWTBE8csatfLPM/tA2l7ttZ0rSDpWMXsaecYswvArqCvS9i2BfUfLVTKMixVSv1WcIjoEYaXzEqXw6CwKXDmNwgyJzBwXaCI5GqgDaGRfUalY4UdpJ8daZdXYk7JLLnxCIS/vXeSnUlw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 7 May 2021 14:59:34 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:34 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amd/display: DETBufferSizeInKbyte variable type
 modifications
Date: Fri,  7 May 2021 22:58:14 +0800
Message-Id: <20210507145822.248029-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5efbdd-ed4f-4a98-49b8-08d91168b999
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB385241D54BBAB42319765E1AFF579@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNn+P7VIspiHAJlWNqADzHMMN5+ciCTD2oG5HFoJz9nkNxhaq5pFygUVF8Xu0yTZ9JxFySqJnep58Vq0G9cjnXhw56Fmc/s/eX6Mki1hCc+ezIt9TneIJzrXT2bbqvaFumGkefXPjqVJMp/1oJoMktxEavk8BxVa1+fzF621GikFtLp+g8ohF5MTw1rK6DYfSG3viQw0S5RucuRk5Bnh8PJHk3CZ/5o3n/TF4Q/LLIPmLWX5GA8cobaiFgj6N7jQUWs8Z8PVA6TOeTFaFH6o96PnOXcj4PF9uq0jFskjdul6laYaZWmAuQPEUbM+cxr23m/dGVUGbfH664qljlB/Pq/6gXEJBSOkydrmHj104nF5J+SVjjMrc5z6HPh6mjeFjt/NAwSa9M6sbTzf5aYUkSIrXaaReRDnLQrAn0Apg/mzCaUco1OAFsZqleh/pgIAikq1ikbG4cHsOetKoZupjE0VzktDd3lGEEzLCp9qgYy74+gmEanRzLfyv123hAYKnlk3LpDcZ3kt4mKyHGhpR25sNfgVueEAgULmu9sa1AWUVM9WWv4QjWwF29yDycNlN3IbpbMjTubgxAnYJKvvo4pAbtHA3oCDiXKAweDEHdLUimCKm30O3pc2Uzw/dpTtBwpvlV3dm9xxY8ZaSVcBUQL++fbzqqC+OworYMdGT3k1/8xoZZd9VMT4Zjdky4cF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(86362001)(38350700002)(38100700002)(4326008)(8676002)(478600001)(44832011)(30864003)(66946007)(66476007)(2906002)(26005)(52116002)(54906003)(7696005)(36756003)(8936002)(66556008)(83380400001)(6486002)(2616005)(956004)(1076003)(5660300002)(6666004)(6916009)(16526019)(186003)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1djb5Bi2qejAPmgISwAg/CKXa8Eak4EPKJHbEdtW76D+yFX9my2wW8/glQ1K?=
 =?us-ascii?Q?QOhgxpcL9U//mEfeIFaVqgm2ZIPlzRPex0VSmpL7LvfEBwVdnJ0LABS837Qv?=
 =?us-ascii?Q?lA+KfmhSqn4t1lRorNQBNvFEyUWRpba5ZHIQKV4DvoZMhvrYh0RZGvUUrXNz?=
 =?us-ascii?Q?2sLwTXnAqohGs0ho3VBbN/lboBNs7iapgHLNVArfGrl/S4rGbKoK5cFvHMbG?=
 =?us-ascii?Q?JTKeMnijFncQHQDxCvTvMHhcicbB/OEjrpmlb/EXMI29ejDz0B3kOxy3cZNN?=
 =?us-ascii?Q?jNt0KmEuaPoQoNx5OGMEy4xsCa70vBDbRtzvvEiymXGynnQcP9RM2C5XrKiF?=
 =?us-ascii?Q?cIpEfXvMd3l764ed7G89TDVo/tCQ8ZuAA4fir5kvGVI5QI0ujsgU4c3Zv75P?=
 =?us-ascii?Q?NGnJHYPY9m7JXj/7ChJwGKTtp7c9LDWdzUWT/ptgSnUu/xhwp23W7TNNwQCq?=
 =?us-ascii?Q?bLHjfxA+ZPeXPVC/B/rWh2tTiWBeHMAMN2rja2wZfkP36XWSn/DobrDcdEO7?=
 =?us-ascii?Q?uqeKeCQiPzJYru/YOIF6bv/HGyAJPOkF8E3E3fqtk6cEuAWIrNF8FwReStph?=
 =?us-ascii?Q?Qck/0ZYMIW2l+M+BZZReRK+SSJrcOItF07P/j69oqbh0JMVeX3JAUcitnFMw?=
 =?us-ascii?Q?BF2jg/y/oOZNEYzCdAy1hByi1VHbAI0Q5lvYClxQN27lCAIEymoRI+oawwZ5?=
 =?us-ascii?Q?LELJiapda/7RqjF+rczHv3DTadM8a8nTjj0r0hElPn0VUNP+58pNa8kT3T83?=
 =?us-ascii?Q?igs3/QRaBojGnClMObeZQI6zcwzCwz/cowEvQhQQ/pBpC1gAuFg5eopOjTBZ?=
 =?us-ascii?Q?NBef26livoSNP7uAvSwxAsGjwnEXsQbTDlFypPzPzK/x7vPwN1IbvaQ1AksG?=
 =?us-ascii?Q?6/LkYZpupSqN0UOcxhJRdcxxHJzLaricrxG7e49vdBQ+Mbc7TuJ9s9J4n5VP?=
 =?us-ascii?Q?zEo/RqFv8B0NFP3B1aZeZGYer/YHuEE+rq8u4wOFn4LjZLkX1OJX3PPd1mHu?=
 =?us-ascii?Q?n7SzpqmvHnWHa6JEgr3TvEF2CMccC8u/I69kkVgoE/MaJDMM/cCzcE2P5Z7w?=
 =?us-ascii?Q?eXzRiy3t+wZHGqHkPdfP6panvM45iOl4c+zCvfJSfJziG8s2CrgmkQp+Bp5q?=
 =?us-ascii?Q?c5Phna5kxySPGGb6aQQ9fNyuSsKfiBClbL7RN4iw7VkZ22oKWjNNrjnXWFpz?=
 =?us-ascii?Q?umgZjKbpaN/PeLBVHgrlxTzaEsr5gYRd6cCLRfvMZD9Fg6l2j8/VusiuZTxL?=
 =?us-ascii?Q?ZmbNVYIprkj9oO7shnHJYwseo80TPC+lan6eQidYvjfIwrsxKa0TyYhDjWDg?=
 =?us-ascii?Q?nnAG6lsbUjOOK/fJjE+JDoLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5efbdd-ed4f-4a98-49b8-08d91168b999
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:34.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4nIr3wLXmRzBVzy4xzquwFqGiZG/M2xsgRIedTaYrclOgqiG2QzeUpt5xtkQCFroVBSCwBu15ocwTYQBnnalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
DETBufferSizeInKByte is not expected to be sub-dividable, hence
unsigned int is a better suited data-type. Change it to an array
as well to satisfy current requirements.

[How]
Change the data-type of DETBufferSizeInKByte to an unsigned int
array. Modify the all the variables like DETBufferSizeY,
DETBufferSizeC that are involved in DETBufferSizeInKByte calculations
to unsigned int in all the display_mode_vba_xx files.

Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 26 ++++-----
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 26 ++++-----
 .../dc/dml/dcn21/display_mode_vba_21.c        | 58 +++++++++----------
 .../dc/dml/dcn30/display_mode_vba_30.c        | 48 +++++++--------
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h | 14 ++---
 6 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 9729cf292e84..d3b5b6fedf04 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2895,7 +2895,7 @@ static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 			RoundedUpMaxSwathSizeBytesC = 0.0;
 
 		if (RoundedUpMaxSwathSizeBytesY + RoundedUpMaxSwathSizeBytesC
-				<= mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0) {
+				<= mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0) {
 			mode_lib->vba.SwathHeightY[k] = MaximumSwathHeightY;
 			mode_lib->vba.SwathHeightC[k] = MaximumSwathHeightC;
 		} else {
@@ -2904,17 +2904,17 @@ static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 		}
 
 		if (mode_lib->vba.SwathHeightC[k] == 0) {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte * 1024;
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0] * 1024;
 			mode_lib->vba.DETBufferSizeC[k] = 0;
 		} else if (mode_lib->vba.SwathHeightY[k] <= mode_lib->vba.SwathHeightC[k]) {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 2;
-			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 2;
 		} else {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 * 2 / 3;
-			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 3;
 		}
 	}
@@ -3819,7 +3819,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		mode_lib->vba.MaximumSwathWidthInDETBuffer =
 				dml_min(
 						mode_lib->vba.MaximumSwathWidthSupport,
-						mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0
+						mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0
 								/ (locals->BytePerPixelInDETY[k]
 										* locals->MinSwathHeightY[k]
 										+ locals->BytePerPixelInDETC[k]
@@ -4322,7 +4322,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					locals->RoundedUpMaxSwathSizeBytesC = 0;
 				}
 
-				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte * 1024 / 2) {
+				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024 / 2) {
 					locals->SwathHeightYPerState[i][j][k] = locals->MaxSwathHeightY[k];
 					locals->SwathHeightCPerState[i][j][k] = locals->MaxSwathHeightC[k];
 				} else {
@@ -4331,15 +4331,15 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 
 				if (locals->BytePerPixelInDETC[k] == 0) {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
 					locals->LinesInDETChroma = 0;
 				} else if (locals->SwathHeightYPerState[i][j][k] <= locals->SwathHeightCPerState[i][j][k]) {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 / 2 / locals->BytePerPixelInDETY[k] /
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 / 2 / locals->BytePerPixelInDETY[k] /
 							locals->SwathWidthYPerState[i][j][k];
-					locals->LinesInDETChroma = locals->DETBufferSizeInKByte * 1024 / 2 / locals->BytePerPixelInDETC[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
+					locals->LinesInDETChroma = locals->DETBufferSizeInKByte[0] * 1024 / 2 / locals->BytePerPixelInDETC[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
 				} else {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 * 2 / 3 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
-					locals->LinesInDETChroma = locals->DETBufferSizeInKByte * 1024 / 3 / locals->BytePerPixelInDETY[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 * 2 / 3 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
+					locals->LinesInDETChroma = locals->DETBufferSizeInKByte[0] * 1024 / 3 / locals->BytePerPixelInDETY[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
 				}
 
 				locals->EffectiveLBLatencyHidingSourceLinesLuma = dml_min(locals->MaxLineBufferLines,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 51098c2c9854..fbed5304692d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2968,7 +2968,7 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 			RoundedUpMaxSwathSizeBytesC = 0.0;
 
 		if (RoundedUpMaxSwathSizeBytesY + RoundedUpMaxSwathSizeBytesC
-				<= mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0) {
+				<= mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0) {
 			mode_lib->vba.SwathHeightY[k] = MaximumSwathHeightY;
 			mode_lib->vba.SwathHeightC[k] = MaximumSwathHeightC;
 		} else {
@@ -2977,17 +2977,17 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 		}
 
 		if (mode_lib->vba.SwathHeightC[k] == 0) {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte * 1024;
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0] * 1024;
 			mode_lib->vba.DETBufferSizeC[k] = 0;
 		} else if (mode_lib->vba.SwathHeightY[k] <= mode_lib->vba.SwathHeightC[k]) {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 2;
-			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 2;
 		} else {
-			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeY[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 * 2 / 3;
-			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte
+			mode_lib->vba.DETBufferSizeC[k] = mode_lib->vba.DETBufferSizeInKByte[0]
 					* 1024.0 / 3;
 		}
 	}
@@ -3926,7 +3926,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 		mode_lib->vba.MaximumSwathWidthInDETBuffer =
 				dml_min(
 						mode_lib->vba.MaximumSwathWidthSupport,
-						mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0
+						mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0
 								/ (locals->BytePerPixelInDETY[k]
 										* locals->MinSwathHeightY[k]
 										+ locals->BytePerPixelInDETC[k]
@@ -4443,7 +4443,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 					locals->RoundedUpMaxSwathSizeBytesC = 0;
 				}
 
-				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte * 1024 / 2) {
+				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024 / 2) {
 					locals->SwathHeightYPerState[i][j][k] = locals->MaxSwathHeightY[k];
 					locals->SwathHeightCPerState[i][j][k] = locals->MaxSwathHeightC[k];
 				} else {
@@ -4452,15 +4452,15 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 				}
 
 				if (locals->BytePerPixelInDETC[k] == 0) {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
 					locals->LinesInDETChroma = 0;
 				} else if (locals->SwathHeightYPerState[i][j][k] <= locals->SwathHeightCPerState[i][j][k]) {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 / 2 / locals->BytePerPixelInDETY[k] /
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 / 2 / locals->BytePerPixelInDETY[k] /
 							locals->SwathWidthYPerState[i][j][k];
-					locals->LinesInDETChroma = locals->DETBufferSizeInKByte * 1024 / 2 / locals->BytePerPixelInDETC[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
+					locals->LinesInDETChroma = locals->DETBufferSizeInKByte[0] * 1024 / 2 / locals->BytePerPixelInDETC[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
 				} else {
-					locals->LinesInDETLuma = locals->DETBufferSizeInKByte * 1024 * 2 / 3 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
-					locals->LinesInDETChroma = locals->DETBufferSizeInKByte * 1024 / 3 / locals->BytePerPixelInDETY[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
+					locals->LinesInDETLuma = locals->DETBufferSizeInKByte[0] * 1024 * 2 / 3 / locals->BytePerPixelInDETY[k] / locals->SwathWidthYPerState[i][j][k];
+					locals->LinesInDETChroma = locals->DETBufferSizeInKByte[0] * 1024 / 3 / locals->BytePerPixelInDETY[k] / (locals->SwathWidthYPerState[i][j][k] / 2);
 				}
 
 				locals->EffectiveLBLatencyHidingSourceLinesLuma = dml_min(locals->MaxLineBufferLines,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 398210d1af34..c26e742e8137 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -148,7 +148,7 @@ static double CalculateDCCConfiguration(
 		bool                 DCCProgrammingAssumesScanDirectionUnknown,
 		unsigned int         ViewportWidth,
 		unsigned int         ViewportHeight,
-		double               DETBufferSize,
+		unsigned int         DETBufferSize,
 		unsigned int         RequestHeight256Byte,
 		unsigned int         SwathHeight,
 		enum dm_swizzle_mode TilingFormat,
@@ -289,7 +289,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int MaxLineBufferLines,
 		unsigned int LineBufferSize,
 		unsigned int DPPOutputBufferPixels,
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int WritebackInterfaceLumaBufferSize,
 		unsigned int WritebackInterfaceChromaBufferSize,
 		double DCFCLK,
@@ -354,11 +354,11 @@ static void CalculateDCFCLKDeepSleep(
 		double DPPCLK[],
 		double *DCFCLKDeepSleep);
 static void CalculateDETBufferSize(
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int SwathHeightY,
 		unsigned int SwathHeightC,
-		double *DETBufferSizeY,
-		double *DETBufferSizeC);
+		unsigned int *DETBufferSizeY,
+		unsigned int *DETBufferSizeC);
 static void CalculateUrgentBurstFactor(
 		unsigned int DETBufferSizeInKByte,
 		unsigned int SwathHeightY,
@@ -1074,7 +1074,7 @@ static double CalculateDCCConfiguration(
 		bool DCCProgrammingAssumesScanDirectionUnknown,
 		unsigned int ViewportWidth,
 		unsigned int ViewportHeight,
-		double DETBufferSize,
+		unsigned int DETBufferSize,
 		unsigned int RequestHeight256Byte,
 		unsigned int SwathHeight,
 		enum dm_swizzle_mode TilingFormat,
@@ -2246,7 +2246,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			}
 
 			CalculateUrgentBurstFactor(
-					mode_lib->vba.DETBufferSizeInKByte,
+					mode_lib->vba.DETBufferSizeInKByte[0],
 					mode_lib->vba.SwathHeightY[k],
 					mode_lib->vba.SwathHeightC[k],
 					locals->SwathWidthY[k],
@@ -2415,7 +2415,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.MaxLineBufferLines,
 				mode_lib->vba.LineBufferSize,
 				mode_lib->vba.DPPOutputBufferPixels,
-				mode_lib->vba.DETBufferSizeInKByte,
+				mode_lib->vba.DETBufferSizeInKByte[0],
 				mode_lib->vba.WritebackInterfaceLumaBufferSize,
 				mode_lib->vba.WritebackInterfaceChromaBufferSize,
 				mode_lib->vba.DCFCLK,
@@ -2588,7 +2588,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			false, // We should always know the direction DCCProgrammingAssumesScanDirectionUnknown,
 			mode_lib->vba.ViewportWidth[k],
 			mode_lib->vba.ViewportHeight[k],
-			mode_lib->vba.DETBufferSizeInKByte * 1024,
+			mode_lib->vba.DETBufferSizeInKByte[0] * 1024,
 			locals->BlockHeight256BytesY[k],
 			mode_lib->vba.SwathHeightY[k],
 			mode_lib->vba.SurfaceTiling[k],
@@ -2689,13 +2689,13 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	// Stutter Efficiency
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 		CalculateDETBufferSize(
-			mode_lib->vba.DETBufferSizeInKByte,
+			mode_lib->vba.DETBufferSizeInKByte[0],
 			mode_lib->vba.SwathHeightY[k],
 			mode_lib->vba.SwathHeightC[k],
 			&locals->DETBufferSizeY[k],
 			&locals->DETBufferSizeC[k]);
 
-		locals->LinesInDETY[k] = locals->DETBufferSizeY[k]
+		locals->LinesInDETY[k] = (double)locals->DETBufferSizeY[k]
 				/ locals->BytePerPixelDETY[k] / locals->SwathWidthY[k];
 		locals->LinesInDETYRoundedDownToSwath[k] = dml_floor(
 				locals->LinesInDETY[k],
@@ -2984,7 +2984,7 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 			RoundedUpMaxSwathSizeBytesC = 0.0;
 
 		if (RoundedUpMaxSwathSizeBytesY + RoundedUpMaxSwathSizeBytesC
-				<= mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0) {
+				<= mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0) {
 			mode_lib->vba.SwathHeightY[k] = MaximumSwathHeightY;
 			mode_lib->vba.SwathHeightC[k] = MaximumSwathHeightC;
 		} else {
@@ -2993,7 +2993,7 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 		}
 
 		CalculateDETBufferSize(
-				mode_lib->vba.DETBufferSizeInKByte,
+				mode_lib->vba.DETBufferSizeInKByte[0],
 				mode_lib->vba.SwathHeightY[k],
 				mode_lib->vba.SwathHeightC[k],
 				&mode_lib->vba.DETBufferSizeY[k],
@@ -3888,7 +3888,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		mode_lib->vba.MaximumSwathWidthInDETBuffer =
 				dml_min(
 						mode_lib->vba.MaximumSwathWidthSupport,
-						mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0
+						mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0
 								/ (locals->BytePerPixelInDETY[k]
 										* locals->MinSwathHeightY[k]
 										+ locals->BytePerPixelInDETC[k]
@@ -4437,7 +4437,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.RoundedUpMaxSwathSizeBytesC = 0.0;
 				}
 				if (mode_lib->vba.RoundedUpMaxSwathSizeBytesY + mode_lib->vba.RoundedUpMaxSwathSizeBytesC
-						<= mode_lib->vba.DETBufferSizeInKByte * 1024.0 / 2.0) {
+						<= mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0) {
 					locals->SwathHeightYThisState[k] = locals->MaxSwathHeightY[k];
 					locals->SwathHeightCThisState[k] = locals->MaxSwathHeightC[k];
 				} else {
@@ -4801,7 +4801,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					}
 
 					CalculateUrgentBurstFactor(
-							mode_lib->vba.DETBufferSizeInKByte,
+							mode_lib->vba.DETBufferSizeInKByte[0],
 							locals->SwathHeightYThisState[k],
 							locals->SwathHeightCThisState[k],
 							locals->SwathWidthYThisState[k],
@@ -4975,7 +4975,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.MaxLineBufferLines,
 					mode_lib->vba.LineBufferSize,
 					mode_lib->vba.DPPOutputBufferPixels,
-					mode_lib->vba.DETBufferSizeInKByte,
+					mode_lib->vba.DETBufferSizeInKByte[0],
 					mode_lib->vba.WritebackInterfaceLumaBufferSize,
 					mode_lib->vba.WritebackInterfaceChromaBufferSize,
 					mode_lib->vba.DCFCLKPerState[i],
@@ -5230,7 +5230,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int MaxLineBufferLines,
 		unsigned int LineBufferSize,
 		unsigned int DPPOutputBufferPixels,
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int WritebackInterfaceLumaBufferSize,
 		unsigned int WritebackInterfaceChromaBufferSize,
 		double DCFCLK,
@@ -5285,8 +5285,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double EffectiveLBLatencyHidingC;
 	double DPPOutputBufferLinesY;
 	double DPPOutputBufferLinesC;
-	double DETBufferSizeY;
-	double DETBufferSizeC;
+	unsigned int DETBufferSizeY;
+	unsigned int DETBufferSizeC;
 	double LinesInDETY[DC__NUM_DPP__MAX];
 	double LinesInDETC;
 	unsigned int LinesInDETYRoundedDownToSwath[DC__NUM_DPP__MAX];
@@ -5382,12 +5382,12 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 				&DETBufferSizeY,
 				&DETBufferSizeC);
 
-		LinesInDETY[k] = DETBufferSizeY / BytePerPixelDETY[k] / SwathWidthY[k];
+		LinesInDETY[k] = (double)DETBufferSizeY / BytePerPixelDETY[k] / SwathWidthY[k];
 		LinesInDETYRoundedDownToSwath[k] = dml_floor(LinesInDETY[k], SwathHeightY[k]);
 		FullDETBufferingTimeY[k] = LinesInDETYRoundedDownToSwath[k]
 				* (HTotal[k] / PixelClock[k]) / VRatio[k];
 		if (BytePerPixelDETC[k] > 0) {
-			LinesInDETC = DETBufferSizeC / BytePerPixelDETC[k] / (SwathWidthY[k] / 2.0);
+			LinesInDETC = (double)DETBufferSizeC / BytePerPixelDETC[k] / (SwathWidthY[k] / 2.0);
 			LinesInDETCRoundedDownToSwath = dml_floor(LinesInDETC, SwathHeightC[k]);
 			FullDETBufferingTimeC = LinesInDETCRoundedDownToSwath
 					* (HTotal[k] / PixelClock[k]) / (VRatio[k] / 2);
@@ -5574,11 +5574,11 @@ static void CalculateDCFCLKDeepSleep(
 }
 
 static void CalculateDETBufferSize(
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int SwathHeightY,
 		unsigned int SwathHeightC,
-		double *DETBufferSizeY,
-		double *DETBufferSizeC)
+		unsigned int *DETBufferSizeY,
+		unsigned int *DETBufferSizeC)
 {
 	if (SwathHeightC == 0) {
 		*DETBufferSizeY = DETBufferSizeInKByte * 1024;
@@ -5625,8 +5625,8 @@ static void CalculateUrgentBurstFactor(
 	double DETBufferSizeInTimeLumaPre;
 	double DETBufferSizeInTimeChroma;
 	double DETBufferSizeInTimeChromaPre;
-	double DETBufferSizeY;
-	double DETBufferSizeC;
+	unsigned int DETBufferSizeY;
+	unsigned int DETBufferSizeC;
 
 	*NotEnoughUrgentLatencyHiding = 0;
 	*NotEnoughUrgentLatencyHidingPre = 0;
@@ -5663,7 +5663,7 @@ static void CalculateUrgentBurstFactor(
 			&DETBufferSizeY,
 			&DETBufferSizeC);
 
-	LinesInDETLuma = DETBufferSizeY / BytePerPixelInDETY / SwathWidthY;
+	LinesInDETLuma = (double)DETBufferSizeY / BytePerPixelInDETY / SwathWidthY;
 	DETBufferSizeInTimeLuma = dml_floor(LinesInDETLuma, SwathHeightY) * LineTime / VRatio;
 	if (DETBufferSizeInTimeLuma - UrgentLatency <= 0) {
 		*NotEnoughUrgentLatencyHiding = 1;
@@ -5687,7 +5687,7 @@ static void CalculateUrgentBurstFactor(
 	}
 
 	if (BytePerPixelInDETC > 0) {
-		LinesInDETChroma = DETBufferSizeC / BytePerPixelInDETC / (SwathWidthY / 2);
+		LinesInDETChroma = (double)DETBufferSizeC / BytePerPixelInDETC / (SwathWidthY / 2);
 		DETBufferSizeInTimeChroma = dml_floor(LinesInDETChroma, SwathHeightC) * LineTime
 				/ (VRatio / 2);
 		if (DETBufferSizeInTimeChroma - UrgentLatency <= 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index cb3f70a71b51..ec56210b6180 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -299,7 +299,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int MaxLineBufferLines,
 		unsigned int LineBufferSize,
 		unsigned int DPPOutputBufferPixels,
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int WritebackInterfaceBufferSize,
 		double DCFCLK,
 		double ReturnBW,
@@ -318,8 +318,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int DPPPerPlane[],
 		bool DCCEnable[],
 		double DPPCLK[],
-		double DETBufferSizeY[],
-		double DETBufferSizeC[],
+		unsigned int DETBufferSizeY[],
+		unsigned int DETBufferSizeC[],
 		unsigned int SwathHeightY[],
 		unsigned int SwathHeightC[],
 		unsigned int LBBitPerPixel[],
@@ -570,7 +570,7 @@ static void CalculateStutterEfficiency(
 		double SRExitTime,
 		bool SynchronizedVBlank,
 		int DPPPerPlane[],
-		double DETBufferSizeY[],
+		unsigned int DETBufferSizeY[],
 		int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
@@ -603,7 +603,7 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		long DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -635,8 +635,8 @@ static void CalculateSwathAndDETConfiguration(
 		double SwathWidthChroma[],
 		int SwathHeightY[],
 		int SwathHeightC[],
-		double DETBufferSizeY[],
-		double DETBufferSizeC[],
+		unsigned int DETBufferSizeY[],
+		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport);
 static void CalculateSwathWidth(
@@ -2613,7 +2613,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			CalculateUrgentBurstFactor(
 					v->swath_width_luma_ub[k],
 					v->swath_width_chroma_ub[k],
-					v->DETBufferSizeInKByte,
+					v->DETBufferSizeInKByte[0],
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					v->HTotal[k] / v->PixelClock[k],
@@ -2635,7 +2635,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			CalculateUrgentBurstFactor(
 					v->swath_width_luma_ub[k],
 					v->swath_width_chroma_ub[k],
-					v->DETBufferSizeInKByte,
+					v->DETBufferSizeInKByte[0],
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					v->HTotal[k] / v->PixelClock[k],
@@ -2808,7 +2808,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->MaxLineBufferLines,
 			v->LineBufferSize,
 			v->DPPOutputBufferPixels,
-			v->DETBufferSizeInKByte,
+			v->DETBufferSizeInKByte[0],
 			v->WritebackInterfaceBufferSize,
 			v->DCFCLK,
 			v->ReturnBW,
@@ -3027,7 +3027,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->SurfaceWidthC[k],
 				v->SurfaceHeightY[k],
 				v->SurfaceHeightC[k],
-				v->DETBufferSizeInKByte * 1024,
+				v->DETBufferSizeInKByte[0] * 1024,
 				v->BlockHeight256BytesY[k],
 				v->BlockHeight256BytesC[k],
 				v->SurfaceTiling[k],
@@ -3177,7 +3177,7 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	CalculateSwathAndDETConfiguration(
 			false,
 			mode_lib->vba.NumberOfActivePlanes,
-			mode_lib->vba.DETBufferSizeInKByte,
+			mode_lib->vba.DETBufferSizeInKByte[0],
 			dummy1,
 			dummy2,
 			mode_lib->vba.SourceScan,
@@ -3911,7 +3911,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	CalculateSwathAndDETConfiguration(
 			true,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte,
+			v->DETBufferSizeInKByte[0],
 			v->MaximumSwathWidthLuma,
 			v->MaximumSwathWidthChroma,
 			v->SourceScan,
@@ -4399,7 +4399,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			CalculateSwathAndDETConfiguration(
 					false,
 					v->NumberOfActivePlanes,
-					v->DETBufferSizeInKByte,
+					v->DETBufferSizeInKByte[0],
 					v->MaximumSwathWidthLuma,
 					v->MaximumSwathWidthChroma,
 					v->SourceScan,
@@ -4622,7 +4622,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				CalculateUrgentBurstFactor(
 						v->swath_width_luma_ub_this_state[k],
 						v->swath_width_chroma_ub_this_state[k],
-						v->DETBufferSizeInKByte,
+						v->DETBufferSizeInKByte[0],
 						v->SwathHeightYThisState[k],
 						v->SwathHeightCThisState[k],
 						v->HTotal[k] / v->PixelClock[k],
@@ -5025,7 +5025,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					CalculateUrgentBurstFactor(
 							v->swath_width_luma_ub_this_state[k],
 							v->swath_width_chroma_ub_this_state[k],
-							v->DETBufferSizeInKByte,
+							v->DETBufferSizeInKByte[0],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k],
 							v->HTotal[k] / v->PixelClock[k],
@@ -5197,7 +5197,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					v->MaxLineBufferLines,
 					v->LineBufferSize,
 					v->DPPOutputBufferPixels,
-					v->DETBufferSizeInKByte,
+					v->DETBufferSizeInKByte[0],
 					v->WritebackInterfaceBufferSize,
 					v->DCFCLKState[i][j],
 					v->ReturnBWPerState[i][j],
@@ -5369,7 +5369,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int MaxLineBufferLines,
 		unsigned int LineBufferSize,
 		unsigned int DPPOutputBufferPixels,
-		double DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		unsigned int WritebackInterfaceBufferSize,
 		double DCFCLK,
 		double ReturnBW,
@@ -5388,8 +5388,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		unsigned int DPPPerPlane[],
 		bool DCCEnable[],
 		double DPPCLK[],
-		double DETBufferSizeY[],
-		double DETBufferSizeC[],
+		unsigned int DETBufferSizeY[],
+		unsigned int DETBufferSizeC[],
 		unsigned int SwathHeightY[],
 		unsigned int SwathHeightC[],
 		unsigned int LBBitPerPixel[],
@@ -6126,7 +6126,7 @@ static void CalculateStutterEfficiency(
 		double SRExitTime,
 		bool SynchronizedVBlank,
 		int DPPPerPlane[],
-		double DETBufferSizeY[],
+		unsigned int DETBufferSizeY[],
 		int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
@@ -6273,7 +6273,7 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		long DETBufferSizeInKByte,
+		unsigned int DETBufferSizeInKByte,
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -6305,8 +6305,8 @@ static void CalculateSwathAndDETConfiguration(
 		double SwathWidthChroma[],
 		int SwathHeightY[],
 		int SwathHeightC[],
-		double DETBufferSizeY[],
-		double DETBufferSizeC[],
+		unsigned int DETBufferSizeY[],
+		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2a967458065b..d764d784e279 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -299,7 +299,7 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.MaxDCHUBToPSCLThroughput = ip->max_dchub_pscl_bw_pix_per_clk;
 	mode_lib->vba.MaxPSCLToLBThroughput = ip->max_pscl_lb_bw_pix_per_clk;
 	mode_lib->vba.ROBBufferSizeInKByte = ip->rob_buffer_size_kbytes;
-	mode_lib->vba.DETBufferSizeInKByte = ip->det_buffer_size_kbytes;
+	mode_lib->vba.DETBufferSizeInKByte[0] = ip->det_buffer_size_kbytes;
 
 	mode_lib->vba.PixelChunkSizeInKByte = ip->pixel_chunk_size_kbytes;
 	mode_lib->vba.MetaChunkSize = ip->meta_chunk_size_kbytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 025aa5bd8ea0..86db86b7153e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -233,7 +233,7 @@ struct vba_vars_st {
 	// IP Parameters
 	//
 	unsigned int ROBBufferSizeInKByte;
-	double DETBufferSizeInKByte;
+	unsigned int DETBufferSizeInKByte[DC__NUM_DPP__MAX];
 	double DETBufferSizeInTime;
 	unsigned int DPPOutputBufferPixels;
 	unsigned int OPPOutputBufferLines;
@@ -351,8 +351,8 @@ struct vba_vars_st {
 
 	// Intermediates/Informational
 	bool ImmediateFlipSupport;
-	double DETBufferSizeY[DC__NUM_DPP__MAX];
-	double DETBufferSizeC[DC__NUM_DPP__MAX];
+	unsigned int DETBufferSizeY[DC__NUM_DPP__MAX];
+	unsigned int DETBufferSizeC[DC__NUM_DPP__MAX];
 	unsigned int SwathHeightY[DC__NUM_DPP__MAX];
 	unsigned int SwathHeightC[DC__NUM_DPP__MAX];
 	unsigned int LBBitPerPixel[DC__NUM_DPP__MAX];
@@ -631,8 +631,8 @@ struct vba_vars_st {
 	enum odm_combine_mode odm_combine_dummy[DC__NUM_DPP__MAX];
 	double         dummy1[DC__NUM_DPP__MAX];
 	double         dummy2[DC__NUM_DPP__MAX];
-	double         dummy3[DC__NUM_DPP__MAX];
-	double         dummy4[DC__NUM_DPP__MAX];
+	unsigned int   dummy3[DC__NUM_DPP__MAX];
+	unsigned int   dummy4[DC__NUM_DPP__MAX];
 	double         dummy5;
 	double         dummy6;
 	double         dummy7[DC__NUM_DPP__MAX];
@@ -872,8 +872,8 @@ struct vba_vars_st {
 	int PercentMarginOverMinimumRequiredDCFCLK;
 	bool DynamicMetadataSupported[DC__VOLTAGE_STATES][2];
 	enum immediate_flip_requirement ImmediateFlipRequirement;
-	double DETBufferSizeYThisState[DC__NUM_DPP__MAX];
-	double DETBufferSizeCThisState[DC__NUM_DPP__MAX];
+	unsigned int DETBufferSizeYThisState[DC__NUM_DPP__MAX];
+	unsigned int DETBufferSizeCThisState[DC__NUM_DPP__MAX];
 	bool NoUrgentLatencyHiding[DC__NUM_DPP__MAX];
 	bool NoUrgentLatencyHidingPre[DC__NUM_DPP__MAX];
 	int swath_width_luma_ub_this_state[DC__NUM_DPP__MAX];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
