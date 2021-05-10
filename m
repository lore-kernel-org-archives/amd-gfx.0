Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DEC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E805B61139
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 20:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E805B61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FD389FCA;
	Mon, 10 May 2021 20:29:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F6889FCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 20:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg3V7GjcVWcEMeM+q2K7dve6e5egqQ07GfLsZiogz99Uex2Vt86z4k3p0rDfZzNUFM76L6mS+qhBhJET4r9rPLX4gGIIynmlhAgHHIIgs0HaMXr4ouvl9HUU3LKZ/wNL1brG27jYh9f/sI2E2NMNRCtK/DixsnFMpnsebHfGyplnr8dyI5lZz1nVE0WXUZ0y/twWZ2174eF9jgoyyzmW480VxdJ3AM7fP5VRi/C4FDsNm5PMmLM+j9JnCfDAy2HT8xpSgxTLO+6l9nvHLFY6ITEyiNZtI2Wl5BNasATmToMajlsgvvvgKSEPhztatIUJyer8gFmPAQt/GY9iEbkYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtoMurjthAkmzEiq+FrGKNOYNEXZWrk7YnmJepucjTc=;
 b=AX0tXiKffdKkZ3QUjc4EuZSYMd/rExOVTkz4tiff1VNIq4AKfzUSt/bXSW0sYSN4THWpw9U36chv/H5KuxgAhWABhKiUNhF9jZ68ivp8lv9P+h6ARMbVjyWX3ObAypQLRrcdDfCaTcPgJqZeUzwA8650k8i3BJzE/KhUwmEZ+51CzJ0dgGc3Ebb4wijwy5B/NvHAoCQFSf8AYiJbT6rPhLGz5mCbhjw9CSaz/83XSA0D29iev/hAgMLJ56LXtQcuAFqZdvYfbFL2ixNz0JL1OCblQqF5o6Nd7KhWRvajrjpTFWu3XjO6jBr5wwt77QoqRHtE9WQ352KfbIlcRq8Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtoMurjthAkmzEiq+FrGKNOYNEXZWrk7YnmJepucjTc=;
 b=BZILxydjlYIya10HLCcSgE6fcbddanNb+9Z2+xnyBTZvk1YW6TQrTQGiNOD5pgg7URLvkqF/qAJtSL+89ewtq2xMzXHey+0OvgpUnaUt1zvnJGrsk3CBgs8NqD+zSAoVFjk7lG5v+ou8yvhVeLG+Et10LZGtzqbAXFkSkMVMXdo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 20:29:37 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 20:29:37 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix fence calculation
Date: Mon, 10 May 2021 13:29:15 -0700
Message-Id: <20210510202915.30502-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210510202915.30502-1-david.nieto@amd.com>
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
 <20210510202915.30502-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::8) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:a03:39d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 20:29:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54cad5aa-1d3a-4beb-200b-08d913f25477
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3384411A9D6DF8E3FDABB691F4549@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SIVw+wawuyx11RR078uDAm4eqKW9qHJkwgZUI6cU8cnALxCjG+N05wjs9LQf77GSs3JI1K0zPJpbdM/OHchJLnFFEIW31/kSqbAbp81VnPpp1IKDFBukfibcAQfLkw1btu3qSryFaUHACsMv8iYmZe7P/Pu+deyQJND9I8Ww/NkCvTI5PQ3SBrR8zS0v0HrKwP9E/QL1k13WNBwhZa3/XLLwRYZoDaUyrJQe2ztI4hKWviNpyZ5uRcUxhjloEOpeWiM3OsLCbumkyRk+8LU1iqHDKKdX+tCetjaridg+foSuod8tTezTamko+emnbod6kimvvanhEet/3v6FwA/ODm7wUgdAYjwhJZLqLP/lEYXI5CiAzJI9YkMHKzNQ17tP5Rg+3ZQVn9j5oZRCGLdvX4GkFWADnyKrQhg7LZK4H4ZUhnzMxuXuuOjqW6Y8kq3FDTzl08vZYPUcOARDKxbGGpIbG63ATKjAX/dKdnziGyikv4afxT7J5ABbC3O03HRlesbqd+sHtwgfpnyAoKSgBfm7wbNcTaa2eQq/TFXE4pNxNF85xtpIYUA4IjMh8EYDSRdUWQmPcKh6QKcx+WbSL1e/ttnVGrEKb3jMQDAfyGaxKFFvc4R0x4GpdCx0UZ0r1jiuYo+Ty72F/lQTma6ngi6DM0ZxETf2sDczIQPBSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(4326008)(8936002)(186003)(1076003)(6486002)(956004)(52116002)(6916009)(16526019)(2616005)(8676002)(7696005)(2906002)(66946007)(316002)(5660300002)(6666004)(478600001)(38350700002)(38100700002)(86362001)(83380400001)(26005)(66476007)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aCSXjVNjk35vzMW75VQtO9X1sL+caVOD4rI7WYMQxijxLndHMzm+cN2TQ/mi?=
 =?us-ascii?Q?Ueh6wxqWx7FWTeYMOhkrXR1hokhafcu8VSLgHXl/OtdaRHHyHeEzMuAj4Sug?=
 =?us-ascii?Q?G623GSq75Dnvg+/P5TFj0YrXhPBmNExm0wAJ5jJQNlQGj+jO1mo1S9XKnsx0?=
 =?us-ascii?Q?lXmDU5iqa0NARnn28OTUTM0fmkfOz6imeCJU2SfZrBzjSEWZTXLyUBXJ8ps5?=
 =?us-ascii?Q?J/PUII0d9flMQSfOuS+YPO/MPsQWGJ/q4uChvsu0mGG7Gg3pt0CM/eFCG3A6?=
 =?us-ascii?Q?ZfihPLEUozGgzb+fWG22L2CsEPB1cc9RZm/2t3fa8l9DNInjAr92EwDRYsKs?=
 =?us-ascii?Q?STS/9ScMz5aCdsCsszY0nEhiRwEq9VOPREkA9e/fEcExI+VFVPY6hnO/8O3K?=
 =?us-ascii?Q?o29cquylBXJFMw+M6k5qRbUWUiO4TdyV0TLK3WyriYqGjC8BCI10WKFpR/wF?=
 =?us-ascii?Q?tyBRf8p639cG5RqUm/Oy1BgbGtuOwaRXA2OuPQmSEf7A2BaasgMoMc0oGScA?=
 =?us-ascii?Q?AfNaZOZ5erhGb655gf8F7zkmZZSYDo92bnD6rtTfHf0x9cczKdr565BhjR+P?=
 =?us-ascii?Q?d2q2yKaQPpARNPXO8zpgTuZzocbUNGoHabt/XE+p0wUeP/q4wKKoU3sg/ZkN?=
 =?us-ascii?Q?MF1gX/1IucqCdqQj68GFVq1pOxWi0eR9x7JD5+BEkC+m//EPyS+p6mgWm88v?=
 =?us-ascii?Q?FIZGryuPhbRdvjXrfVogupieY8vvaV6MQXTDP9nxFPV6ffVjaNXYAhvXnUZC?=
 =?us-ascii?Q?jGCnoXK2VDjHKyFB+Q9i8y6W1TtXyfRooJBgsJSItvcCNlfcHlRuEQXzR4SW?=
 =?us-ascii?Q?Rh5VtMcUDdWRUVWLYI0K0UIaEHhTH8kV1eY+FV29N7/r6rA87sc1fbFX9NSn?=
 =?us-ascii?Q?osKSOsxS4sjrm658E2vsjrwEFK6cUnz39qljAFI6yc/JP7br1tbgi/r+hSaI?=
 =?us-ascii?Q?pauNsxMF1295cQfdzUeTi3QqB4zVvSlPv1roMxWJbSeTv4xGDBjcC8IJhate?=
 =?us-ascii?Q?+I3k1jmYHu2om5N43SdKsuD4Gu4PSIm3GDYulvynxUeoP1sGEFgz2EM+T41h?=
 =?us-ascii?Q?fP5IlLiF1ZWKgp1SukBPTN+GIlgH6r5+fTP9KjZyi3amRZHcyosKs0e3wok3?=
 =?us-ascii?Q?2dUosziAbOQCy6s4/EFWcxy3HO0BomciIhJmH9L3kXNJ0pqQCVp25QJZsfMq?=
 =?us-ascii?Q?j+PasYxD1vTtP7/Yut3wslwjQBNG7mvywGs/5sLEo9hO+wIRTdbX67zzLmpu?=
 =?us-ascii?Q?/VuX6u7nFlQoypuXHuK6ZATwJGoWB5a/H8bX3+lWsDc9w6sN/LIv+86nt6K2?=
 =?us-ascii?Q?U+NQOmijpWlZ+i8HNOl2izXY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cad5aa-1d3a-4beb-200b-08d913f25477
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 20:29:37.1041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89Ve7p1BLP+Wg/lfydPpbWvzsTGuK6fzYnxGBAmN5rm2jCrtEVgSHpQjn+4Jge/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 9036c93b4a0c..89ee464b9424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
 	struct amdgpu_ctx_entity *centity;
 	ktime_t total = 0, max = 0;
 
+
 	if (idx >= AMDGPU_MAX_ENTITY_NUM)
 		return 0;
 	idp = &mgr->ctx_handles;
 	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
+		ktime_t ttotal = tmax = ktime_set(0, 0);
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
