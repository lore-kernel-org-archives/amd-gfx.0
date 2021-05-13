Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD9C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F19613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F19613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6D36E0CC;
	Thu, 13 May 2021 17:45:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD4E6E0CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 17:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CucOBOYoSVC5lecXAKJtpdFDqPn6uB8YUqvrc++UTywyHezjrk5fJ7zZ9hRcqlHxPYOt4O2rUg1WiJrgFG7Mx/Jlm/M0xkaU8KQ/7IK+t1ihvCoe7488W19qMuSC78JOxvFj/KoB/xNU80ydu1GeiRAwaKcHt13tfkQeNe92hnWZynEP7pva/ZsMhoKrx5OMy3iaK4SV5nHx03bh5Aq6QzuTDv93wiqzXPzLTUEYT2t6cueAJwm+gf97e8eC4pCOSODDK17nlkutSkznLaZbEoABgvWQdkP7A3TBe31Ts37Gha+OUfs31qMFEbS51L+VXQcYDltYYDSaafKWK+nxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTzX4yG7kC1NqOOJDCX2rLLLbidKSj38WX/JG3in9sA=;
 b=ULr17wJ6to7rj+obMosP1Y7p2HNeFE/AfrSDcM+2GacPmh+MwItf2YgbLRFHDs2r42Fdd/CongMN2HV+i3OvpN8noXBCbi7EfhzxLkiU8/yGmFs2EzxeAyn7XNCtOwqWeE+6fhvxC6ZZi3EuC+YE0m8VySPTJdy8z71kMslI3QInpAx7UnBkEPGVNWGD4CS3NVmFiAdiKT41zOe/thZg7pqlkpy8upNUi+HDAyi0WWhiJhVohiX6Cvm9lR/pcGvk2j626qOmbNqVYxw98HhWK8tC5BUAVamAGDgCH2D3Mf9Wnhd/yLa8MoAhDxWXNTG6xmADdtDcPgb1XSZEN1fcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTzX4yG7kC1NqOOJDCX2rLLLbidKSj38WX/JG3in9sA=;
 b=JblCtccAG6J5nzlxZsglnndcAJ4F1czQdD5n07kCNrXMS9fcCa/2TclNORY7C//qei+GvSfhhcQ4O5IjpQ8+RxI6ulICp6T6FfJK6JAE+j5+iVmLwcCMrqom2dscfB0wsuXUots2tI0V/GAWNRX5dd0RKPOtKKGefn2W8OBk1fg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 13 May
 2021 17:45:52 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 17:45:52 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix fence calculation (v2)
Date: Thu, 13 May 2021 10:45:39 -0700
Message-Id: <20210513174539.27409-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513174539.27409-1-david.nieto@amd.com>
References: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
 <20210513174539.27409-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Thu, 13 May 2021 17:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18eb693e-8c71-4064-2141-08d91636f3bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30625C24121874235733A544F4519@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLBx1aviNJVnIphvZY22TnRYiaiQp8CRynDYg0ppvBFy+XanFAPJO+9gQ4wUsn/pgTUin9ZhZ5yMRojNK68C1hX1qBK+9MqM9FV4RjS9hb2rvFNExWm+yiDMpP2FNK6+BsuIP5+wo0sYkOCur9BvGpt1x+FtXS7i97ug8Dq30DX89AmOt4dlueltFmrnMCPl5wicV3Xg1s7I5poHmlGh8i7qxs+5zIzAjhIdUUDhF5fWVuzdUQkzDwl/4r+Tgfu5N37rVejLRnNv/4Ds9AXtvaPEQ7h4raZCXvCWrmSMdMHfm5DsRvLllT6VPl5mWMGOIkAeCid9119iLVxguH3WOgamEgb/3hdMISWmFYo6IJ071gVXCJfSb0Ii+u6wt/YIqtIYYZUym6YpiSZoGPvR4CBqQmjp6InAwARLiW/sRNFvBcWVyE42+mDir9+l9jwm7dGsbE4LASm4IsqsoyCEm98kEx5WXqAiINl5bk3aiNFIBks7rhajNDsBnd/z8dh6W7YyK8upajZwTUwJi8FLdzktJEqP3bTtA5ik/wMVZNSTneA0Yit7GtqTqahSCTbXKNROVnAYIU68Abz4keR6ZcKMfKOfVP46GPfPDMxBx84YYKso67TmRtZtvlBKBbA/DKxQ9ebHZx8diJqSEG5GmBha3hjJn55Q48lit1bInH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(956004)(8676002)(4326008)(2616005)(36756003)(6666004)(478600001)(52116002)(7696005)(83380400001)(38100700002)(26005)(6486002)(38350700002)(186003)(66946007)(1076003)(16526019)(86362001)(316002)(66476007)(6916009)(8936002)(66556008)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VnkpDQf9a9PTlXGvF1FEg3czxdyXhTzdY5IziPySyJfbz36nPEnB19PVqpMp?=
 =?us-ascii?Q?euVRqi2+U48mJdhJJi687mUufSSU17jkMwEY7PjByLdgpEUkX+Uz24kBVbOm?=
 =?us-ascii?Q?wBLK4rCqLAZQAm7KCBojAWHNX2nIyAoZsErIUIAGAhubDGSmpw/V11fLoqHh?=
 =?us-ascii?Q?IHTrLt8QwVd2kGc4In1XnLc6AYgpRtoy15Ggmr5kidFiQGTn5ztjgPxb5Qur?=
 =?us-ascii?Q?vP+sh6lvuzxzMO+CDJie7LmYimsixllnttdlVjetOiy2f/dpCLGoctBKHl/a?=
 =?us-ascii?Q?h5Acjoprnqu9E/73dMCDKXLeVPtRJ4wXnlS+pYxRBN206H6hJyHpSeSYLIBG?=
 =?us-ascii?Q?XQg3kSaQewzpOCpMHpBUt1c9Je5ZghMEm5Zn8BMPb0uFjmhB5MK2NIvWk/cX?=
 =?us-ascii?Q?rkGSIlOxSw3AFp7x6yQ81goJ1t8qbQUYdj9tcnP7lpry8alylTttjynVF5OJ?=
 =?us-ascii?Q?dZ+jiCEdsz6WNTE2VW5n9gBKqvthAFKIQ5whEkAA2x6O2wqf1f+UwudmJtca?=
 =?us-ascii?Q?D6prZwgvi5zcbVjaDoY4bgX+gWzc78ZN4wbCfEyIQEVQOWlRoCu2BNJjpD+P?=
 =?us-ascii?Q?OScPwwy0YxZqP1DZyUMXLlCEr/JyGHhQyu91qDvw0n1iRoh6EYnXG+bZSDeT?=
 =?us-ascii?Q?bpv5+tAx1c1fMAv0O/Pmfz0dnX9iYX24f62zfVuA4psraNt5E0XGOz+Q2q1b?=
 =?us-ascii?Q?cUWaqhan75wB3dRn5+4/aKnyjwLlCwkJCUOFXmwhMcNtaLEO3rqNVZFUMZIE?=
 =?us-ascii?Q?c6wqWXG76UZFIKyZABf0qRXgbj1aDtziuwb9fGJIY85r3MSSO5avE1ORGKFg?=
 =?us-ascii?Q?9Ds/k89vPzbWHOLHGk/rGXkD/azpA/b2zarTtuSBO07qvmR4Gq7oRiA8u2wR?=
 =?us-ascii?Q?a14uZssWr6dKAKPO1ibeHZaefASTk8u317pXAZodmd3V8piqCD97lsYpb4zH?=
 =?us-ascii?Q?LBF1lAsO6iQQANGDNTPmbydcE0zD2c2RsXypzOxb+uicCAmQ+EBVXZDfb0DL?=
 =?us-ascii?Q?wOJ9vd5RWrVTB2+PeDNwQ73eUOqZQowc7d9ektLJKHWFert2pb39V1QfPzo5?=
 =?us-ascii?Q?3Jqiv64YKGe9dIwywKiW913qvqNGoDTn2oVAGmvkChFaxoUwFR0yxrE2UTnF?=
 =?us-ascii?Q?mcM+T8ENTUYnPBr9HP5ZamW8fHI/mJ0ZKWI7UNdLICErt3XHU8+N28Rvp6lf?=
 =?us-ascii?Q?cWWVaQgZJVZm/p3YI1PL8keWOBL2GKrgVJHtDcJIwEFZ6g8+csYMUN0wQ+OF?=
 =?us-ascii?Q?dcRgGteMqqg+SwAYpaK1vlGH8+0+dbKIeFwEv8KaJRsJyXW6uGWCjGHQzamH?=
 =?us-ascii?Q?ny1NSCouTflm01EXDE+CLKrn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eb693e-8c71-4064-2141-08d91636f3bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 17:45:52.5057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIBQIvXQ5gDqd4m2/pMiqISrfpZ7fhsr1Mj7FcW1nPxQ1CGIUCdoGeSvKZHEgh9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The proper metric for fence utilization over several
contexts is an harmonic mean, but such calculation is
prohibitive in kernel space, so the code approximates it.

Because the approximation diverges when one context has a
very small ratio compared with the other context, this change
filter out ratios smaller that 0.01%

v2: make the fence calculation static and initialize variables
within that function

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 19 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 9036c93b4a0c..fc83445fbc40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -652,12 +652,14 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	mutex_destroy(&mgr->lock);
 }
 
-void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
-		ktime_t *total, ktime_t *max)
+static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx,
+		struct amdgpu_ctx_entity *centity, ktime_t *total, ktime_t *max)
 {
 	ktime_t now, t1;
 	uint32_t i;
 
+	*total = *max = 0;
+
 	now = ktime_get();
 	for (i = 0; i < amdgpu_sched_jobs; i++) {
 		struct dma_fence *fence;
@@ -703,11 +705,22 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 	idp = &mgr->ctx_handles;
 	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
+		ktime_t ttotal, tmax;
+
 		if (!ctx->entities[hwip][idx])
 			continue;
 
 		centity = ctx->entities[hwip][idx];
-		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
+
+		/* Harmonic mean approximation diverges for very small
+		 * values. If ratio < 0.01% ignore
+		 */
+		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
+			continue;
+
+		total = ktime_add(total, ttotal);
+		max = ktime_after(tmax, max) ? tmax : max;
 	}
 
 	mutex_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 10dcf59a5c6b..3541dfb059ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -30,6 +30,7 @@ struct drm_file;
 struct amdgpu_fpriv;
 
 #define AMDGPU_MAX_ENTITY_NUM 4
+#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)
 
 struct amdgpu_ctx_entity {
 	uint64_t		sequence;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
