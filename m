Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB69C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A711C23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711C23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB9C6E8D4;
	Fri,  8 Jan 2021 21:50:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6016E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3XL8/sOBUkWLcUdjbPt8bqMz95ThloyARoKP442c4ogIkhR7QcVwGhL5Ef1ic9xkSs//YwQsF+yDWkDxdEouRdWj8h2EcweXowx8S2Ok1zMV7W2bdPsevtNXHm+jAxgdEI1LIVFB1simWpZSEhvNKIvD8N89z5KJZVYutEXFL6V266gmGANV+kpjoDng2HZ+qqs1a9t540kW8ztWTZBtvuoL08LHUK3RInosu/qI+sLPahpgQyvtU3/xZVRLLJ5nChQBSd1ESxlqxRCo3xIXLHe3Pva07qfkzP4ZQnB3mxX1gTnayBCCdfqd0OKUXXw+Yes7vIeI6S2ebGJSp1Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7MatjdOg8mt356nO98J1TTUfko8ZVSejV7VI3CJ3cw=;
 b=dLydpTl1HMwTnaq8gUfcQ+oyRvMn9/JE6Ues2QFLWSnY9fyX6T5QBh+R+oV88M+/jzDfoWyx8B6pd9B3c/PsM0+QIz8F4omFyM2R6YCMTzmJFEz7+LB29aqXUJtpLcR8hYq08OMh6Hqy9kSUgZuASjj6wNecO3ok9pkvt4VX5o2Q+8MfJKYdv63an9S83yMFWSJgN73CugiiccCyAKlFFsplwThmB7XPTroydVYbAItYUh1B+GIWuV0BcQSh/ywDV6UU6IGs5gIm2NysA0E/oKzOfHDQCGSJewggkxkfc/36soDwSspUcsozQT9h8DkqEKlBtaZFjAG8VFQtjdAa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7MatjdOg8mt356nO98J1TTUfko8ZVSejV7VI3CJ3cw=;
 b=n2ZbW1pxq7TqzOhbHTvHt3ANkbgie2DhVA/fjc8ZaC8SUMzNqIObrHVIvMO8dPJ/TNCO8NH772xPmGuKsGLwI0jEmBUatpGFui0c1iB1f8jn88WGvHON1TZSHdSUHohzMANxrc+6s8gO+9W0q8i2h2DurUK+1eOWe/avkiPVmWc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:41 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/21] drm/amd/display: New path for enabling DPG
Date: Fri,  8 Jan 2021 16:49:54 -0500
Message-Id: <20210108215007.851249-9-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f7e453a-4ac3-4bf4-7da7-08d8b41f7166
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882FA79C0C8A800E2ED898998AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWq8//f7kX/4kJHJVU5Q4WdL56Yb+Iae9e4Z7nxysq3t835x4Kj15vm/6zrpeJgpMk9lLlCChQqlRC7uAegmXs4iE4iE0m2TZM4CTPRDNKpqi0CBtpSddVsQe++2TrBUktytz/QFZMotwrBBnSj74BMY+K00JYYcJMsHNOmbIAL3YBgziNBBVZ/E3OCeojOZaZVrWxRxKJhmMwUd+WhSvmkw4n+vanGawpdG2stXnFfr6W35CKtWynSmcbiLecLB+fX/W+LCFWx03YSAb0XXc2PjBUfqrg4IiNeJ+v/CaQYL4HDSNYebdeH3TGEreHgqVQnHG8UIMV3ekOVrsZzHMxVVVbLlayp89/AwUiEF/53RM3DHx06VBdfeKCu0aReD0+4Vnih1euBFw5io9UvskA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VlzkzY/zTPyyzddUjrPQrm26+JqSM6WnhU+ybyLSc0WwttHgjLVcQCr01EnP?=
 =?us-ascii?Q?3aB6ui5M53Z2oNN9u09lo0xs3/Phg8pHwrFx/eHZ2ZVN5a41JDEsl7Sox/dx?=
 =?us-ascii?Q?AU7pdjXr8ixPiWSkapxTLt2bDfW/CHgTCd5hoOwWmz9yuCFTNtlbN3SburLN?=
 =?us-ascii?Q?YRZ7jezQYLzN30WsRV7PnBFcOwJrxbp6mAPvCjj7Q1//QhMhTRBg6jbW9rAp?=
 =?us-ascii?Q?Nnl3lkooaDo9ODkP1zyXYZtOS4fCmxWu3EyJhZcmJmqUT4RhJB0LeGiKT2nJ?=
 =?us-ascii?Q?Xw7FfbueYM5rlzkQhUK/dDL5NbLZhcJiz/ogNa/9kqLqh2sIjWx9MG5aApo+?=
 =?us-ascii?Q?nqRZtYhZqPmGHkOA5BjwNsXrasfJ+eCk/OkVpeU+XOdva1S9fF2iRWy8/b8f?=
 =?us-ascii?Q?G1GTV+ELjESZU1UAwO3HbQ8bc9iRI829AbAT3Q8H2LzBF0YhYBOqkXwSElCj?=
 =?us-ascii?Q?DH/XSyKqDau3XxcHHt4rs0iHwA98EzpFQweYRVX902T3yhBRHpblr9yBSX1z?=
 =?us-ascii?Q?8Jhe+MXtNjYd0hGMOmg/CwVU2x+S1qfRUlCgSSVLa54xhLxRm1It0fPVAut4?=
 =?us-ascii?Q?C0n501syDQkn07gNp3O3WQg12TXV9ha4qcxlsTU080vcEAITBx9jycD9zJk2?=
 =?us-ascii?Q?/mITLeHhF6Yz13N2cotgnPsFGyBS1NbeqErU0FgjxQksTuX8qmp7hGZXneYf?=
 =?us-ascii?Q?cbUC3C71xBqa6Fsx59t5pP/EkyvG3dCuv88D9Tnt79lUbYQ5OgUmniy1gU+S?=
 =?us-ascii?Q?xVkeKKpZZvHWaDexF2HRa0/y0ivJUSS/iHeVFQJDeBO6QHgEQmrjrPx5MCuy?=
 =?us-ascii?Q?QXRHyHLiWK7aNJkDEpgubty/+W+cTBWHMvuPALoY4zScfHRZgOj5SQ0CcFg/?=
 =?us-ascii?Q?/lWmolsyuRqA+jUOsdqZV2XufzmURVGhRmNZsKM4WCmy+AfuPdXZGfNE2wtj?=
 =?us-ascii?Q?g3iyQcZBXM9GDANFiDdYvluSVJopMlh9ELLPCeuVbQ9usfYJ5t52GE3y3d4R?=
 =?us-ascii?Q?ckmQcq0gTQZIXrClrX3VXA8Nfq+sollYMt1t0KYcVpKnkMJr2UMg8f+XeWAf?=
 =?us-ascii?Q?UBZf75V4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:41.0524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7e453a-4ac3-4bf4-7da7-08d8b41f7166
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIHd8URY0sDukWE6i/eqDGl+8VdNEp3pYgSHpAYoxrQ4yshh/icznTzQAfMiO/0Jpz/EW87EOA25yL5MYhPckw==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
We want to make enabling test pattern a part of the stream update code
path. This change is the first step towards that goal.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f1cadb823c7..7801b44cfaec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2265,6 +2265,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 
 	if (update->dither_option)
 		stream->dither_option = *update->dither_option;
+
+	if (update->pending_test_pattern)
+		stream->test_pattern = *update->pending_test_pattern;
 	/* update current stream with writeback info */
 	if (update->wb_update) {
 		int i;
@@ -2361,6 +2364,15 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
+			if (stream_update->pending_test_pattern) {
+				dc_link_dp_set_test_pattern(stream->link,
+					stream->test_pattern.type,
+					stream->test_pattern.color_space,
+					stream->test_pattern.p_link_settings,
+					stream->test_pattern.p_custom_pattern,
+					stream->test_pattern.cust_pattern_size);
+			}
+
 			/* Full fe update*/
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index b7910976b81a..80b67b860091 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -130,6 +130,14 @@ union stream_update_flags {
 	uint32_t raw;
 };
 
+struct test_pattern {
+	enum dp_test_pattern type;
+	enum dp_test_pattern_color_space color_space;
+	struct link_training_settings const *p_link_settings;
+	unsigned char const *p_custom_pattern;
+	unsigned int cust_pattern_size;
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -227,6 +235,8 @@ struct dc_stream_state {
 
 	uint32_t stream_id;
 	bool is_dsc_enabled;
+
+	struct test_pattern test_pattern;
 	union stream_update_flags update_flags;
 };
 
@@ -261,6 +271,7 @@ struct dc_stream_update {
 	struct dc_dsc_config *dsc_config;
 	struct dc_transfer_func *func_shaper;
 	struct dc_3dlut *lut3d_func;
+	struct test_pattern *pending_test_pattern;
 };
 
 bool dc_is_stream_unchanged(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
