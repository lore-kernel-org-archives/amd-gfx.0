Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C82C433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA6D6186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA6D6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94B96E41A;
	Thu, 11 Feb 2021 21:45:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879F76E41A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxSZo/ny1rPturaRJeqd1hfHKBNBpmha/YGh/kejsaYszXd4YRk/jpPOmP/XBE22DsRDkGRqmEcwTYWDVYiZTCG+pSclBJ16PsVzVIvlhWq/q70u2qFCQ8FE7OO5McvM+a7DDnusAFl5D0cMpI55YkqHPSO/kK16j5dj+Ew+3S+kT6bB8aVUmuSsHR1/6ZBJfmKP8SR5pVDrClsjXmi1BknhLXgI3O7BoGU5ZvAex7ttOOyz4xk49WwEaC2xP1+8ZRUh6vMRjNMjDGz+mEMr9Jz8qxx2K3o+RNx8UNw8MzxuQW5j8D1qq0K7cqC65zK14reYZ31OMLpJOLDLSyyFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XdYO1pPyX+C0x2RJcXWk76/KXYsLC4BbOnLrIxx18s=;
 b=cfe06sygWThM3KHp1ix9NiwqCdYCvfPOvnKErbaLqxbnHDOeTG37S5bjAvIEzlJUfsV/uUQ8fr9/6VT6mGzs4lCHGojJ6O42W6ZB8aCwuJHhVWgSi2gJp12Dm6xmtwXCIdDYYFmBtqMCZa3FTzaTgEtVhsJUlARvIZBswtNBUIDs34S8aLb4TgSoSDaR60u+D15CQQxdirRMq+CsSacEWl7t5Ge2HQcrrDHfiUV8VkeEQ0xYiHiGQ5qX7jI1GkZuuPjX7zqMvPg9w85pSJh2qHQSItnJP6YVTZe4PiigKP41Vn+2y5tv/4uaiZWLJC2RCyixWy6F2bH1xMf6XJcIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XdYO1pPyX+C0x2RJcXWk76/KXYsLC4BbOnLrIxx18s=;
 b=0qUIzohV6DYqUI2OyVrBDMjiYIX9qLFnkq4tKGN1QxCt+ZjdWGbtVavsasimRhCHR3QAgyJP9sXXHLpKCCieFOMd0qMSVxVlX3nZBW++n/8Fi1u9OXHfoP2LpvdonAnUPjzO25Cwzk9mJib/M7gLSI0hIrViilKX8sjdnbusfGk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:01 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/14] drm/amd/display: Unblank hubp based on plane enable
Date: Thu, 11 Feb 2021 16:44:34 -0500
Message-Id: <20210211214444.8348-5-qingqing.zhuo@amd.com>
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
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07b1751f-cef5-427a-b334-08d8ced648a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB423507736FBAF8A77BB9FC76FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KfzGV8QKAkzUHJw6ApniXjZl3TYpMdQVWY29SrNBXi3bneGjDvl5YVVnc4c9skBQRx5AgwkIt7wJCE7YMrIxah74sSzfGJRjYsDBGDVDzpd1EbwwQ+aF6exLUS9ipBJjxRtNTGe+zb0HOlGrV3FY5npDXOi+pd7rpoMrMvHcWelfc6R2nUxvBilvSGBx9iNkHFxgYenMsocp+eXAprKahVGApo8apCgcZ+ko9kbWg6ALk2o5dXwopVcfjS3FVSHGJI1Dh/zHFfemOytZdCcrgHo+GsKOV6uf4Ck2pbCv0WoNK+bpvEdB0v+2ki4D6t0G+rrfMVgGVb94OBghev1lS9Xoy3cCm+qPI+tKaDfVrb2OAZIx1b9kvN9q0jrh44KHBJzLG8cL6ahLLLmvaCiliG2fFQn1K6cqZTzmg5woGP3aVes4w2gsLkyO1GE58KHOf3drUHs6K7KCpnQRK3W38vsL60f6oPscqSn6hh/brs0luL+lRMEqouJCgfmXEDiDks0WO+KCmtpVu6kzSefdzOEs/zzWGJlwU8L+EQt71MNkvRvfWT4OuyoJgk7LmAHOFYJJ5bTuQt/L4Cj14/RFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vXQPdebFqgT4SPd7SVNkGOe4vFYfrc0KoViB0XzehXZnPwmsDsGGFq+LQ1k/?=
 =?us-ascii?Q?DMVxwbv5tJO1XqkCFEbh/fHNM2HwvVIbzunfqhlys1aKz/uriyPL0xlJhqas?=
 =?us-ascii?Q?gJ/+QRRpNkcN6hhFrJivR8sIiJ1hj+016I8SBJAUv0ftYmvnG33k1Gz+oW/E?=
 =?us-ascii?Q?/gInZt8UH/DQyQaGYj4IDMrWbeY7Rryw+nznkivKK75ZJ64vpbHQZ//PswI7?=
 =?us-ascii?Q?Bncfy7HDPsGqDu4FiB9Vnt9PV9eApJ9QkZMu7Dzaz/EAL2NOJg03qRfw+l/G?=
 =?us-ascii?Q?+tjfyl7UeBCdNj4VV8sa6Bno8CN06wKmhOC1wEyh5sJFnrChJZ6FvohVcLJ/?=
 =?us-ascii?Q?dhfiVigJvTk2Gc1yhdjO7Z3yw/XPfPIRm6ix9YMqYO6iABhJDl/F1b1UTKGP?=
 =?us-ascii?Q?HZCxT52XW8uZ59DG1qL2xxKF58ekD2QmWndebrrYstcLhANo07PfJUf0bPfW?=
 =?us-ascii?Q?Ey2bpbvf9h/iNfh1YrLoth6fDLiMFs5H/IoGcbZukF3nfvRXUAThsxLzy60x?=
 =?us-ascii?Q?EOpWx/zil/fkrUO6Q1M3+D71OIkrBTlDkipuBbMIvz0w4WEuKA4qXKSmYSBs?=
 =?us-ascii?Q?LrIGfR9fY6xlyiNgTRT0jEqMKnQnd4mLmh1IOcfqG2fm0jeElJg7Oi6xWxOd?=
 =?us-ascii?Q?BabCgCHdEaHg1rd0eWWkm47dVGwudcexp+Piu6lJ/J8RjcQMn6fdEnWobdfG?=
 =?us-ascii?Q?sOo1swv0bAGiqDGkP+izx4DEoOanAnQThUd7OWEw4qmQHDC+PUQG+QTTQKSD?=
 =?us-ascii?Q?wubuper8g0SNZTGihf0b6UgV8WROESFyyrknou7nttMAw+552jjSV5GGoEWR?=
 =?us-ascii?Q?YWpPAAiuK+xKi3UPKMFqK0nlw4BuqL6P4cc/pOWD3StcpS9YRD/M2cJeBjBf?=
 =?us-ascii?Q?XWcXxnWZaeJHMMfYDuX+RhQe9LthRHOTeCnWM/GNl/0CdWf9amx3mePZHlhI?=
 =?us-ascii?Q?MGyt5lINUQCpRWCFs/CIYz6FWFfXOftcexTDEBnIldCPMDKbShSZV+7CADTn?=
 =?us-ascii?Q?EQx/Z49sg/BtQ8MAl9AsaHV/L8RCs/mv1W0HG+gCT/yuK6xaqTIZLrSq3LrY?=
 =?us-ascii?Q?TYptGT7YyoWXtflUZ6a8IsL5ZIJo6dHF52TYUca0xqjUK6HykL7cJOSGr6Xh?=
 =?us-ascii?Q?CEQB9+Q1monZ9OlHfOcBU0BRunjtz1BwdDVhrJM/cpKMxzsT+eOCovDvab1l?=
 =?us-ascii?Q?OoREFdgQFD+oS3oEvdepamG5sb7yFpy18EhWKNhKxkLMdYi4SMm1plQvAZTH?=
 =?us-ascii?Q?LggBelF6kpM0Rs9gm4G4fodq4WH7TIFfpOAPmzytXW0Ru40QjYlUyffsGNE+?=
 =?us-ascii?Q?9mFC5a2ydmiXSeDKgaKFrpGN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1751f-cef5-427a-b334-08d8ced648a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:01.2961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI5qhEaEZlBDkTdJ9HEM/c4BWS9CXVwiOlbFTdZP4VMN47ibbWGMMLFuMr6dv0ip
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
We are not implementing the planned new HW sequence
to disable HUBP.

[How]
Revert most related changes to minimize possibility
of regression.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/basics/dc_common.c | 20 ++++++-------------
 .../gpu/drm/amd/display/dc/basics/dc_common.h |  4 ++--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
index ad04ef98e652..b2fc4f8e6482 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
@@ -49,24 +49,20 @@ bool is_rgb_cspace(enum dc_color_space output_color_space)
 	}
 }
 
-bool is_child_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
+bool is_lower_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->bottom_pipe && is_child_pipe_tree_visible(pipe_ctx->bottom_pipe))
-		return true;
-	if (pipe_ctx->next_odm_pipe && is_child_pipe_tree_visible(pipe_ctx->next_odm_pipe))
+	if (pipe_ctx->bottom_pipe && is_lower_pipe_tree_visible(pipe_ctx->bottom_pipe))
 		return true;
 	return false;
 }
 
-bool is_parent_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
+bool is_upper_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->top_pipe && is_parent_pipe_tree_visible(pipe_ctx->top_pipe))
-		return true;
-	if (pipe_ctx->prev_odm_pipe && is_parent_pipe_tree_visible(pipe_ctx->prev_odm_pipe))
+	if (pipe_ctx->top_pipe && is_upper_pipe_tree_visible(pipe_ctx->top_pipe))
 		return true;
 	return false;
 }
@@ -75,13 +71,9 @@ bool is_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->top_pipe && is_parent_pipe_tree_visible(pipe_ctx->top_pipe))
-		return true;
-	if (pipe_ctx->bottom_pipe && is_child_pipe_tree_visible(pipe_ctx->bottom_pipe))
-		return true;
-	if (pipe_ctx->prev_odm_pipe && is_parent_pipe_tree_visible(pipe_ctx->prev_odm_pipe))
+	if (pipe_ctx->top_pipe && is_upper_pipe_tree_visible(pipe_ctx->top_pipe))
 		return true;
-	if (pipe_ctx->next_odm_pipe && is_child_pipe_tree_visible(pipe_ctx->next_odm_pipe))
+	if (pipe_ctx->bottom_pipe && is_lower_pipe_tree_visible(pipe_ctx->bottom_pipe))
 		return true;
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.h b/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
index b061497480b8..7c0cbf47e8ce 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
@@ -30,9 +30,9 @@
 
 bool is_rgb_cspace(enum dc_color_space output_color_space);
 
-bool is_child_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
+bool is_lower_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
-bool is_parent_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
+bool is_upper_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
 bool is_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 0726fb435e2a..b79a17f6a9cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1575,7 +1575,7 @@ static void dcn20_update_dchubp_dpp(
 
 
 
-	if (is_pipe_tree_visible(pipe_ctx))
+	if (pipe_ctx->update_flags.bits.enable)
 		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
