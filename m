Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9035C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EF122D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wDEY+B7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EF122D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D478A6E92B;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093116E924
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg2R780FiV+/V6/wVbrHTUved+gXIQ7JYZcm1raKiHbWPhyL3TcYyq1QOMMPTE4/MP2/XB6GQniSBZ3HkwHO2u9P21xSjQrzHTdLVYCc9crn50V4LrnCFST2VNvMWTq/aCvGzk3UIgcsCgat3moQKyEnmtGXAqKVxCtz5ERUZvDq8yo1JrkR9s0qEZO76ZBkInWLck7fJlP0DiJJ4IJYGeY6oomA0Q9m1fgr9v2CEiZA9BbU6r4lkkB2pr+PJCmbXcTjlJ0ejV4r68dw8Lt6VkmfvLGiR3a2hWzhpQl+51f9jFt4Mw/o/hGdd39XSQfIfI74JB46f9DpTb2WmId7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5ra1TINXfZoek30EAqb2CzZo136pPILqDjwU8tlgsI=;
 b=VDgtV8VK3BLUDeQD9OeDgPEgOFF6xRH1b8x9IBLXgbK1Nepo08Rkl0aQ9t2oPfigJrEb1ACrENIUolMXmam6Ojr2nrgjR/oTDCFQBtfhyeUn436sDsMEcuVlms+HjPtW6fTWZrIyvxlw6Gt8+l2Ysl445Kd/VqS1U5K8F8Wc0PK3WV8Kv1rd5s/VpMW+yxRvUKHZkQSByBnIckzSMdRdHfqSP7sgcBq6P6OKhzIZt/59JEGsLXMIHsTTan4q/g9YPOexMw6PEx7Ete6kJSYd1XNVVU6EnQ7hkr4O/iL1Gk174JNeTGNulBKgPaalfodXwnupnzJvjplm0Udxe0lyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5ra1TINXfZoek30EAqb2CzZo136pPILqDjwU8tlgsI=;
 b=wDEY+B7fOuhv/57TR1smU+fUXbduJGWubyqyi1MsSfzvlLLyEtZDWD0SJuus0Dz8DbrXLTRqKOpwjzOva5bkHMdJ0h+jkAp8SpOuzo79KPMLJv5cYu8wkrJQ0l0bpHTiRP165xbOdkRlR2R0Xammik14+jIFsU8UFo2R+io3VTc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:28 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:28 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/18] drm/amd/display: Clear sticky vsc sdp error bit
Date: Fri, 20 Nov 2020 15:19:49 -0500
Message-Id: <20201120201958.2455002-10-Rodrigo.Siqueira@amd.com>
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
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c76dddb-1ed5-4d4f-feba-08d88d91b8c1
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3717EE4ED940893B6C1EC4F498FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaFpn8kJmhV1mIm7rR34xO5HXRJFUAL4OaVcpL2zeUsYdJRv2GkI3x4UfoEJEvR7+sJbal7nYKkFrpKB+sKaBdUXn4f7+4rkT/ECz+NlgzOZdP+Mpexg3fCck/iU/4H72CWT00Aqq2hJkeRYmunvcBLQzITVdQhGL8pSA9lp70zIjkj6KZbcWjN7Q8dnZFM7N15i6EompfPbYLdZl/aRFnaPWhHt+B3red/ZQCON0Y2Gfy19Y03ROuJV6JLjLBxqHwodkoOUVFMLZzpxSgtEXhmKuYekVDMAYNBuNbYQWZUqEKLK85kxrcm7AQ/eWzXgye+bu2Ssan4GwYSHXRM36A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: R18KGYLfjRDix5dK90LMaRIcV9ytQohXrlEKCJpjOYMR8im/kMwErk8agX0zmn8jjGvE4lfR7uYlj1t+y4BjU9n+okVFSynpKCiBx7+LKJzvkY2ub4+u/Gdd3Pca3M0Ijhvp2PPRYnzKaxF4JbAb15APOV9GjFdO4K8SABFCT9LgTjVmsd6UmW2Xx3wClScTt6XMa+fWVptcKoe4JOZThgZrFHWGI5gi0YwhxwD3hgqtFHj1fwu/EMvBNuj/yZ69Gx+NoB8ythrjUNtwx8E6HiGHupiamDaDrxmMh9oebXf+PLz8+9AOpUMag5m6Zo3H6fwvCTYejJqmUfUXWqN0pRhevgyJBZueCA27s0TlEsSfjLNS5U3QB85KZugxV2gCR1/hdkcyudNJVI5vj+gXFUZQAeOrO76gbAJ/ozBjWN3VAXFirwKF37LUlLfpiiM1h1Zb6EIfmgIeul2Gq0hbfiu6C4Mjchgjv3YIQ4PqddZnF9cR8VrY2oLK7BdLEQx5eEBvQz+oAlrRLTh6m4mCP3tOrO/Os+DiNxMHQ9H67crCGMuj2/rOY2Fok5xnAHiSI4k+nbyvI9Ebu8jieyJTU2TMiNAjnU8T+y1Y2u3jigMeVZx6j0WrHlGTDmGstE5zQ5vW77/Vv/Xn4GzK+z2p/SKI+AYQO0/VjHW6dYVzkYYrYMhdvCOL1zGtmPZK6HO2TslQnoyBh4EMefcnZ3qy3jN2Nn54tlkoV+PA+EmW3lpuj/GQLRYZt73jDeobxQpVIw5zwSZHOflFxDKLcWPdIbHknInZRKc5KSsrhTE6o5OwtIX03CkBv76L+Bm3P/QUR0BU1OZjwJ3WqJMxxLHmIQ/vHq44wznQZ+mRwfHjfL9j4E2ukFatGQUjU0Btff5zpBCtLFS6m4b3eXNXlZxqgGk8ap7gXzwvwPhwK6il4iYe5YhfFBKcjgYI3YHnQo0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c76dddb-1ed5-4d4f-feba-08d88d91b8c1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:28.4519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyPI2z0Bl2LjKu6ze38y3vsZ1NUKUOQYS15Jwo6+lJeNJ+Ze+V7LrqGqH19NSd+rBFjtF5CHF7Ns6wfjAofPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Need to clear sticky error bits generated during hpd irq from receiver.

[How]
Clear sticky vsc sdp error bit.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1dfcaf1acbfc..93fbc646f53b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2570,7 +2570,8 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 		psr_sink_psr_status.raw = dpcdbuf[2];
 
 		if (psr_error_status.bits.LINK_CRC_ERROR ||
-				psr_error_status.bits.RFB_STORAGE_ERROR) {
+				psr_error_status.bits.RFB_STORAGE_ERROR ||
+				psr_error_status.bits.VSC_SDP_ERROR) {
 			/* Acknowledge and clear error bits */
 			dm_helpers_dp_write_dpcd(
 				link->ctx,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
