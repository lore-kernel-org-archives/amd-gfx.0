Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0806C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489E9613AA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489E9613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88A46E342;
	Wed, 12 May 2021 19:45:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0823D6E342
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 19:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHjpbfJIqtmHldLibcvSIv/bkgew6lsmTcvgl833wglrMjwv5Tx/a47JD9yK2gPAoO2IL1XPxq2RCo8hFiJplA6sb4tsLk/RcJ3i+qM0HcfDyTV3q9uGuPjKDwnPCCe2vqNUAAO1HqH6V3lSQQjZy4DAeo5tApCh2nJZL39qDA/eGleC3UD3BEUTtFnhOmvzzGw8BgHfWQ9fv15r4CZgRRqKbVpbdNBMNXRHzgaxS6+k3iU8fshAWAEuavuQCt6r1Xip0SWvhdHXAwIZraqTzo+Vy/gc5072zO90xigXR1glnQD9y/CC8vc5kFgjpm2PPeL4B5y9L/d9+FlfQM92zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIarX8dzxjybkjkVvKfgAD/3DX002dN7XZuOjk8Hz1c=;
 b=S7nCI9TYjzHJdHsqgziiKYpBUm3T3gXedNvd4neu+dAQ2Zq5lb3fJIqLzqYQoOmrHfzk0WIEVH/45M06ShVG2UYSZhPmkRgEYXkg3Vbnhea1sY0ZKXWFKIQADjW/m6VMXfzicdoK3nn+rtg0RTTq5BDtiPoJIqca2yrs0Vpm/GVT46TNwWcsN96TfOD7syfzIevqkJnigztoxAVdqdY5IqZkc1KXar19m8KlGFWauYbbm1Y2BdeG6+c4gStMokhI9SC9Z+ZCve6jUwuooEzrossv85UaRA4upR9qmufPPEpYWmI7Z3S+ql1Hme+dj8omcjVF6gIFXDqToHJy9izfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIarX8dzxjybkjkVvKfgAD/3DX002dN7XZuOjk8Hz1c=;
 b=OBXWGfJaMFgymb9WibenkVKSJYiQfxaoowpu3mgJcofM9uD8Uxnf9zq5+Hrkc/uroSmufSe3TweRztr55VPyMeQ0gLgh7PHv2rnpmaEY91a2T7gmD8DqksIYUXvRlk0S46NazXOTHESBYuGXija5ACsJYY+VHkekoFq8ylUbx0U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 19:45:40 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 19:45:40 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix fence calculation
Date: Wed, 12 May 2021 12:45:27 -0700
Message-Id: <20210512194527.7687-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512194527.7687-1-david.nieto@amd.com>
References: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
 <20210512194527.7687-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 19:45:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61671fc1-bfe8-4502-805f-08d9157e858e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3794374CCD673C3A49562199F4529@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFZQOzgMcEEzacamWkwYB7+0hZM25f9lvl5ckP7jrabI0ETVr38VHNgDSt7BGYGg0gpxZ7pNzEcrqsiwG4mLcRW1mF3LDDPJ4SmGrOQMkJqUhccnYgW6+mBw6SVRMIK/nkfsKpk+s4qXYTr2z10cdqYajYrwS7sAEUn+nl8SF4lQH3EFwgtnzqTozJAxdE1xrNno0aDy4VoSOn2ev78Z20QodISx8yPct51/W1v3V2DfxbqMBpxR3Ty7VvNxfdUASqKzhwQHNK8Tda8T3GbKql4y/9Rk3omIq1Me1tmW7tw8/n+JflyHRjXkxz3VcdDCyZLt//ZO4bZqxB2z7L7WMdqfVFjBvvpPt2AWUR2D3Yd8vYrf8A53y98S2aoWnmA/yDpy9G/FOj2xsE/8qId5pSYnKEg+A1hiLoyOZTphBtZsh4Rxz1h+RhlCu5GXKylqmAQSmxUzNsoIn24qFRviwrs3bO5OxGF4sXy+4rC7zr1Esr4yqLl4ea2CeVTaRJw3l6d3lEOEQg8R8/EbpHrmQ4CNIC4bpDu5redvkIEJ4Q3RVmVN7kDCm/bsJ4pS8qoFZgdu8bORbYpMh6fCiEqSta2Khps6HK6Yi6Ya8IdN1VasIDcHzzaPzxw2+MVldpD5F75eH66qaVjTgZe8KuF6zbHQZXq95j2eef81wj9R6Ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(186003)(16526019)(38350700002)(38100700002)(316002)(956004)(6916009)(66946007)(83380400001)(36756003)(86362001)(478600001)(5660300002)(1076003)(26005)(2906002)(7696005)(66476007)(8676002)(8936002)(6486002)(6666004)(66556008)(4326008)(52116002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iUooe2oXdC8vtZ/Dzw1i/XR+B38S5ilcvc98qF1nrPNXD+XqcozAdBLbipy1?=
 =?us-ascii?Q?/PwDbLnh/GEYb3fx/QOEu8i8JX77bRdHPlijor/Bht84UG5XZXa56MKsF2iP?=
 =?us-ascii?Q?BaidSGeMWnng4mzeiaqtpgc1Xzfjp6rzJYOTm4MD/kCxROZiZqjfW7mu+DIJ?=
 =?us-ascii?Q?rJ8gzRoRuqtpolLCjDSXFtD32WIj+7v19U+5OeBimQwAbP2WamJpYU3nLOih?=
 =?us-ascii?Q?pdi0quYKEe7pPXXLlyS4jMq4PwgFcUUI11B0rOYMWxpLtM/ohIQoc3VqBW3b?=
 =?us-ascii?Q?1FdgusQTbX0C7cbIIRztSqLefAdaEd8mv+wXiq8RE5viTM464ZuJh9yXSCZL?=
 =?us-ascii?Q?u8w6l0VcSwIs6OMRZmOtEv4K4C8C0TmtKiSPW2raOrnCt8gRo7nli4AKoopX?=
 =?us-ascii?Q?AaxCx1BKwmvLC0ujyJD1+LTBzf/oXC9glI9I93FnViwykSJzuORqAOLDSeoF?=
 =?us-ascii?Q?BZlFwBCqwtHrZTunk9tQrnjl65AIIx3zCcnJh6btQQ37zcWtMDMh/10YGQ61?=
 =?us-ascii?Q?q+BfXNVYITEv6xcv7WBZhJTH8Jk6V5uqEpTa9dWhGUWtynhJAkoqU21TCrNq?=
 =?us-ascii?Q?nLYCe+1DvAMEQPjF3hIqO1tHIqVcvfS2cyWr1WFa0m17nVYULeQE+mdjYP2d?=
 =?us-ascii?Q?/AbH2sGtlOOi1GtAoAJs9YufxH00D9BkN38CX0dTOB68B1q79ro1iC9yc/cp?=
 =?us-ascii?Q?vt7IKAOCH/jbi3/W9oQ6pIlZzPdWt11Z/DNPqoSrGq+ehQlDt5821ZwLnKHo?=
 =?us-ascii?Q?w3gwD/xd8Fx1I4XBfwjYYj8nI/tr+gOcriLMWf6mO+klgjCR8+IrIp/kJqwU?=
 =?us-ascii?Q?2SymRklqnsq7ECJ3WzMl2GlhK0LfmVklh544NqsyKooZtyqKt7YIVYYD/afs?=
 =?us-ascii?Q?gDYhOqFMVG4YDgPFcJ3PM1fc5kh6l+FZ+qpHHjeaFzE0Bn5i0IVt3btvnhdc?=
 =?us-ascii?Q?nn1UMR+GNHXAWBw51Aid8II8pKVf687zbADoYrjOlZmT0vDQB9Gw3LlmRlfQ?=
 =?us-ascii?Q?M1S5s3o++ubdb+IX7T3tmu1qt2Ez5QmZncdNGtcx2p4+ApONJJx5QMf9rDox?=
 =?us-ascii?Q?JctxMtQIZ7sIkgKcBL0TXhP1hD0Fx+n4nEhWCAaMj6o4KIdPvWxGcQKtJRRB?=
 =?us-ascii?Q?urIhMjrdHEDNwT4LBDwWjbD4dLCL1x6PlEqCufVuovfOfACRFIO25zIEsGn2?=
 =?us-ascii?Q?HBR6Rr3goLHjWqW0ArrjT7fCyZRu0fw5KOV5hqZwcBZsx4zoEIPfHi9huJuL?=
 =?us-ascii?Q?Iy2iXiYD+0/nj1ZJ78SlJo5chkS0iuFOYHe07bJ54GSl6chyZ66BDmn06MXL?=
 =?us-ascii?Q?rFL/GbKflaCU3tQpPHesv5I1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61671fc1-bfe8-4502-805f-08d9157e858e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 19:45:40.1826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9hiyDKkaTCmQQdo80S8B4Uvp3AqKJAOKDDw25CzU8O9wrIoo2xryF/dkM5tJnQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 9036c93b4a0c..b919615e6644 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -652,12 +652,14 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	mutex_destroy(&mgr->lock);
 }
 
-void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
+static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
 		ktime_t *total, ktime_t *max)
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
