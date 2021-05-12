Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A56DC43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2D86134F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2D86134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF366EC5F;
	Wed, 12 May 2021 17:03:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510146E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5P42KOthL63y/vSBRbUSYBeHH5zbPqKOW/z/drZZcmaODOt9SRppk17tFh7op2iAPDF8X56sBJ2Vywe2h8kPTcbdl0l7H6zYYVKoj9mdHNbZtCfTIv3UyXNjEOLvlaitBy1fMpTi4Dj6nsw6Aylnry+25Jqajm4JQHnue0q/iO5ScpEiw8aqFQoTb2Cjn8K9Lkw3/GCHVSg7K4kA01nQ6nsdnfAZp7nrhTgOaZ/OaMN0C79YrHtyB9e3yBdxYCGqvl/Q+teMouUqRJnDMt4QvORw/2ANUOM+ubIgHY4DJDd6j3ahrLVZRh1xeKE3qClbOyounipLqYjfqGhaZVrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFTldXmk7+K02iGUcHeValx97qZzM5AvFv06VI7doIw=;
 b=S/X+eOmKJkmZ3GZXcSXNdrGXxF4bMXHmeuUQcB14INEnT6kADmk8iyqzBSFZHIw726uWQYdYXlytlJmed6aVOh+SBFxC8u5XLSnzOS0xNVwjCajVfabLaPFfBr3HRaG4bIo1ItMOBtPrZBSzust7T2g8WmIewZSpbUwWT4IAg43SUTThoUV1cdQQvedcLWQS4yhnKPJFzciIRwWiarp2qPsfx2SFJfpJWBdK3eQqKrtljhdvJ6Fc/tCfvhWx6OR5xS2LCFX5Yo7kBb9GXIqLnuFdC2SQKTeCca1bhWsNajZOeBmIVEe6Jbdui1bR8sjckr79OwwzyEw4gTMJze3VaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFTldXmk7+K02iGUcHeValx97qZzM5AvFv06VI7doIw=;
 b=WJCoO7CYTw0qYNRbOikktXw4FU3pegdkzUzBFXgALd+yEpWKo8CbzHqFmbY0FRLLTfQOI3AFHxQGQEwv1odJti9set8kt6pIL5pW/WMwBdr6g4UWHwqL+APK4tIxKaHX/PS6+sgBC7tTzfn2Oq7lmjr0VgxtQi4jDZbNUWij6hc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 17:03:17 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::a5e6:2e22:512a:7d10]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::a5e6:2e22:512a:7d10%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:03:17 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Poll of RAS errors asynchronously
Date: Wed, 12 May 2021 13:03:02 -0400
Message-Id: <20210512170302.64951-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210512170302.64951-1-luben.tuikov@amd.com>
References: <20210512170302.64951-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Wed, 12 May 2021 17:03:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f0f66d-802e-468d-54ad-08d91567d649
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371751E2A436BB16617599C599529@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st6xIVehk75nSB2VYLmFsY6m3darOCc8eaq74NJ15DnKSUI4VDo+5pp1ckC+HqzvKddF3LvHne+OWu0Xgu0pFg7ZGqLunVd03MXYvpWCGXqIYGUub3pw+dBwUAlXF9fISjR1HkxWuMicOeiZZsgSJ+2zLfKAnyaLUczuJmDFO52VEzoOpPsNW5ootOelTPOlkub8dMuLdjp8aqXkhQa2AuOniS4DVzuPRO1cgPIoeNsz4q9f0EK4s6GaR1uG8FNdDzZl71JB0Nl+/iWzQSfX3S7DQWEU7elY8dNUYyDn1iFDISmlS0F+bTbCBAdB2fwao6dzKfoyUudFtlONstdHE/EfSqtXehDJenZVoxE4fsRO1x0FYeHkoNCpbr4Jm5b/BWc4APbBmLC0qoQcLshjNuz9wMHU3SHJcVWP08ZfokgWsbdsOrOQvmjgjDxkQiVFFprj1y7xi/1fEIrd9qNY/4oTuqdDWQwUVf7I+Qe6ks+SayxxlwepSXJDJfFM6eMoFhRoWx+5uTqvmTSMoiWEXQA1wWHkM/5J32sliEEALRuPXBbYichuh/mzAg2Oe/JupanhDbgnnHCeV1sQ00z/fWcHxWypMOlBv4GqMYhNq/yie/E2Pcvxh+u2d95kn9ZCcgt7Gy3ZkEbNUrGdAN76wU5axCTrl4HVieNVAXZAjxe9GXR8OzrOIr4cmnsuM/pj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(8936002)(4326008)(186003)(1076003)(6512007)(6486002)(55236004)(16526019)(6916009)(2616005)(8676002)(54906003)(6506007)(316002)(66946007)(66556008)(2906002)(52116002)(6666004)(478600001)(5660300002)(956004)(38350700002)(38100700002)(86362001)(83380400001)(44832011)(26005)(66476007)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WdShG2KJWfxEeSwS+x0Xxx8W5YWu9UsoHVvyAYuz/yqpX9xrnsxfoI9Kza2V?=
 =?us-ascii?Q?4kTFEp4+3XsTzPb8umXEBYCSEeuFoUarT6xVWZbGEORK1Gsg+dp8t8YN9Hm0?=
 =?us-ascii?Q?W+AoVBWcbXbwx77sR286g/r/h4fMNq1aY4TRtkEHjP/awHGhF+h7rlvL5cfm?=
 =?us-ascii?Q?jJhYbJwK8crcrE4FHnnehYzxbP8yZM/EWM/sa6Puffi1148+I6DQi61KKT43?=
 =?us-ascii?Q?NvJwgTWC3jHil0IiWv2RicYruEK5PQSDmWigJB6x8VEr3vn1uP8F8KR6HcWW?=
 =?us-ascii?Q?ae5wA6ZTR+uVYUdFZfeypWuNtuHlxz0umP9PrYAqO2M9X2HxdVTKbE4/Bo+U?=
 =?us-ascii?Q?th9X2Gscz7atBncNazvwD+ZtPXJAc/2HAQt2F1Zba3WwSMfVCMMXY+CLTsst?=
 =?us-ascii?Q?1ht9ZJSjtAN0Ebl8trYmeulGxThgTJ2lUv43hPQIi1wCqgUeNj4kmLCeyUq5?=
 =?us-ascii?Q?CAYts1tZsD7uGMkGlspnk1mNYWdqJGw8X6cHMZTYpuNTIe/FkA+Jt3htiQlY?=
 =?us-ascii?Q?T/TJdiWAG3uHDfRbUW7JuFgb9IDyda4nBH9mt+FG6qYPeh+jnR+m42hBuZsn?=
 =?us-ascii?Q?R4AYd4USxydzASOZ7MHOAAuvWOVFXdPKkxsnbU39umBRoXj3EYpxB3egDBl1?=
 =?us-ascii?Q?qQiL5UUjkif52+Tp713K0HiuXWkREJy2+5a4ySkgMN4Mlem149aYZjm8vA/l?=
 =?us-ascii?Q?SB93p5nsXniiH5QduOe6edE5uMV9TdvA+pWyCFBbE0t6TWjMcMh0GWu2sTkh?=
 =?us-ascii?Q?tec3ubYsUztReRIwnOWY8u2cbQ3m5kPt9+ZhVY4by6Kuhaos1NSSI5aJibop?=
 =?us-ascii?Q?Mx5DkD3b0u7KcxsduY4pl60ubb1DHwt/gb/m+upn5KFbx+AVqgnF20l57Le9?=
 =?us-ascii?Q?cV69L9G5GXkGn6/n6W/9YwSbKh2SdrNO2Dzj/w/hL057Cq5ohJGdB5/ukW8U?=
 =?us-ascii?Q?S/21onrqprDKl7/oWAzOy0JB1EIucLOmGD2U96bgbh4a8MmbPWPXw0ha/2Ur?=
 =?us-ascii?Q?mdgM8l49rZeix5JxzvXVLl1EW9/beqcKkvyeU/j6rYyUwKj+NEJABfYRHVNS?=
 =?us-ascii?Q?Ju4Pz3vkaw9qErkQkjCA5KLSxQAdYYIJSGtqRZnPvyndFCeI3Q4yE+cxao7L?=
 =?us-ascii?Q?YG4JhsqSs/hmi0NAhKBQFWa21urDSvwhRnwXR5rW7m5Swjt9zaH0yZrXCsme?=
 =?us-ascii?Q?Pl90ofPq4RsGvedNFujCMjQdtijnHxH80sxw2f+36b7HppsEokAn9AjNaC8x?=
 =?us-ascii?Q?SRcoJvGEB4k9adaa2z6OoZpgLtoRAwsvWg9dp9lT17cTl6PC/q6D0IjjV15q?=
 =?us-ascii?Q?c9Rq82Ic6H4ftT4qmIscRx2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f0f66d-802e-468d-54ad-08d91567d649
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:03:17.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZkHg7phA2qpBON1DulySnSqyv8UWNAtYyhFwtCzT/UjriUz6ugv4An9+p0UoX5J
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When using Vega 20 with RAS support and RAS is
enabled, the system interactivity is extremely
slow, to the point of being unusable. After
debugging, it was determined that this is due to
the polling loop performed for
AMDGPU_CTX_OP_QUERY_STATE2 under
amdgpu_ctx_ioctl(), which seems to be executed on
every ioctl from X/Mesa.

The latter seems to call amdgpu_ctx_query2() which
calls amdgpu_ras_query_error_count() twice, once
for each of ue_count and ce_count. This is
unnecessarily wasteful since
amdgpu_ras_query_error_count() calculates both,
but with the current interface it returns one or
the other, depending on its Boolean input, when it
can in fact return both, in a single invocation,
if it had a better interface.

Further down, the query_ras_error_count() callback
is called, which could be quite a large polling
loop, and very time consuming. For instance,
gfx_v9_0_query_ras_error_count() is at least
O(n^3). A similar situation is seen with
umc_v6_1_query_ras_error_count().

This commit implements asynchronous RAS error
count polling to that of the ioctl. A kernel
thread polls the RAS error counters once in a
while. The ioctl reads the values
asynchronously. The poll frequency is a module
parameter, with range [500, 10000] milliseconds,
default 3000.

v2: Enable setting the polling interval to 0,
    which disables the thread.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 36 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 66 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 +--
 5 files changed, 93 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3147c1c935c8..a269f778194f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -197,6 +197,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern uint amdgpu_ras_thread_poll_ms;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d481a33f4eaf..558e887e99b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -332,12 +332,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 }
 
 static int amdgpu_ctx_query2(struct amdgpu_device *adev,
-	struct amdgpu_fpriv *fpriv, uint32_t id,
-	union drm_amdgpu_ctx_out *out)
+			     struct amdgpu_fpriv *fpriv, uint32_t id,
+			     union drm_amdgpu_ctx_out *out)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
-	unsigned long ras_counter;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -362,20 +362,22 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
-	/*query ue count*/
-	/* ras_counter = amdgpu_ras_query_error_count(adev, false); */
-	/* /\*ras counter is monotonic increasing*\/ */
-	/* if (ras_counter != ctx->ras_counter_ue) { */
-	/* 	out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE; */
-	/* 	ctx->ras_counter_ue = ras_counter; */
-	/* } */
-
-	/* /\*query ce count*\/ */
-	/* ras_counter = amdgpu_ras_query_error_count(adev, true); */
-	/* if (ras_counter != ctx->ras_counter_ce) { */
-	/* 	out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE; */
-	/* 	ctx->ras_counter_ce = ras_counter; */
-	/* } */
+	if (con) {
+		int ce_count, ue_count;
+
+		ce_count = atomic_read(&con->ras_ce_count);
+		ue_count = atomic_read(&con->ras_ue_count);
+
+		if (ce_count != ctx->ras_counter_ce) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
+			ctx->ras_counter_ce = ce_count;
+		}
+
+		if (ue_count != ctx->ras_counter_ue) {
+			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
+			ctx->ras_counter_ue = ue_count;
+		}
+	}
 
 	mutex_unlock(&mgr->lock);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 877469d288f8..641c374b8525 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -183,6 +183,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = -1;
+uint amdgpu_ras_thread_poll_ms = 3000;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
 	.period = 0x0, /* default to 0x0 (timeout disable) */
@@ -534,6 +535,15 @@ module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
 MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 = disable, 1 = enable, -1 = auto (default))");
 module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 
+/**
+ * DOC: ras_thread_poll (uint)
+ * Number of milliseconds between RAS poll for errors.
+ * Valid range 0 and [500,10000]. Set to 0 to disable the thread.
+ * Default: 3000.
+ */
+MODULE_PARM_DESC(ras_thread_poll, "Number of milliseconds between RAS poll for errors. Valid range 0 and [500,10000]. Set to 0 to disable the thread. Default: 3000.");
+module_param_named(ras_thread_poll, amdgpu_ras_thread_poll_ms, uint, 0444);
+
 /**
  * DOC: ras_mask (uint)
  * Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1c57a5b6e89..30bec289e9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1043,15 +1043,17 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+static void amdgpu_ras_query_error_count(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
-	struct ras_err_data data = {0, 0};
+	int ce_count, ue_count;
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		return;
+
+	ce_count = 0;
+	ue_count = 0;
 
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
@@ -1059,13 +1061,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		};
 
 		if (amdgpu_ras_query_error_status(adev, &info))
-			return 0;
+			return;
 
-		data.ce_count += info.ce_count;
-		data.ue_count += info.ue_count;
+		ce_count += info.ce_count;
+		ue_count += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	atomic_set(&con->ras_ce_count, ce_count);
+	atomic_set(&con->ras_ue_count, ue_count);
 }
 /* query/inject/cure end */
 
@@ -2109,6 +2112,49 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 }
 
+static int amdgpu_ras_thread(void *data)
+{
+	struct amdgpu_device *adev = data;
+	struct amdgpu_ras    *con  = amdgpu_ras_get_context(adev);
+
+	con->ras_thread_poll_ms = amdgpu_ras_thread_poll_ms;
+	if (con->ras_thread_poll_ms == 0) {
+		atomic_set(&con->ras_ce_count, 0);
+		atomic_set(&con->ras_ue_count, 0);
+		return 0;
+	} else if (con->ras_thread_poll_ms < 500 ||
+		   con->ras_thread_poll_ms > 10000) {
+		con->ras_thread_poll_ms = 3000;
+	}
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+		if (kthread_should_park())
+			kthread_parkme();
+
+		amdgpu_ras_query_error_count(adev);
+		msleep_interruptible(con->ras_thread_poll_ms);
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_thread_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct task_struct *kt;
+
+	kt = kthread_run(amdgpu_ras_thread, adev,
+			 "amdras:%s", pci_name(adev->pdev));
+	if (IS_ERR(kt))
+		return PTR_ERR(kt);
+
+	con->ras_thread = kt;
+
+	return 0;
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2182,6 +2228,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	r = amdgpu_ras_thread_start(adev);
+	if (r)
+		goto release_con;
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 201fbdee1d09..fb9e4c7ab054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,11 @@ struct amdgpu_ras {
 
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
+
+	struct task_struct *ras_thread;
+	unsigned int        ras_thread_poll_ms;
+	atomic_t            ras_ue_count;
+	atomic_t            ras_ce_count;
 };
 
 struct ras_fs_data {
@@ -485,9 +490,6 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
-
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
-- 
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
