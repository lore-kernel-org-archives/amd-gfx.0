Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90787C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1644B61288
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1644B61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8638E6EAB2;
	Tue, 11 May 2021 18:28:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B2F6EAB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 18:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFWQ7NSsTAstuA4Fn5Svfn03/B0FXk124V+Y9ZMNRXrTjhJeJcmuBM0Fcl796cNqP+uACts5OE6Ayuiv6hhV8ozLM+9uZsxQWHzVi50cDndD1YURpfWGhmEySufhuM3uPRscY2/EQQQXOg1mFvOUh1Gq9lho9WR6kqU4KDWgetWWkbvhumQntRJbv8Og1WWtmPlBADFzxZKy/dDOW1uCy3VTp4jZxaT/WYfxdZJzAwM5UxAvcz50xqef1O87s+829p0CJUNnUduAB3dEKUTF6yTuIS/NW/nVOEkcg4TFv1VEatPRg0T8leQO+Z9TIgkHSBEI25APSQclNoy9Xz9Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=KXzkRnTtI6WZh1xFbWybQYs2I8GH7CtKcOJWOMhMT3UKh66sEBiCKjPPK3kwmBKCWKhiT6n+WrVQRHDpBRN00Sdx6go/dJsB3NXX/vq7uFxKX66pGi2w1D0bIdyNBQWdSlEOa3/B76NG8BI24xoXz+k98qERY72pIaO4mk5ZhozIg6+VkiMTm4PRuZvkZZpS7spb1GjL3F3DXWtA4s0nNAjjDnm0im8dKx1adhC962WnloRYrNbgYesGPIUVpBTopB/EWQ04oEKbrmXmMM61b4qkADDTAu6t++3Mq+m+kZtfEcogCDbxREDVjiC/+yxisz0iu+w/DTHScKwhDUu9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=v7h1OD65CffTelidNRLZLvZ/UWnAEaPvlW2V3NmHS8TmXoq6RjqipWW3GmBRYudaGdUyhA/X2Wqnk3Ffh4Gp4Pk0iZrpaBuXah6CrKJmfWQf45mb3EPoIqmgqP6nOxgiAZYd9wCW2aE9A40GXzzBtJ6cUu8Mtm1rTZtHonMVfME=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 18:27:59 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 18:27:59 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
Date: Tue, 11 May 2021 11:27:46 -0700
Message-Id: <20210511182747.13367-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
References: <579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 18:27:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cc663a-0983-452b-958d-08d914aa8146
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2839B215F8A0E42638F0BE75F4539@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8X8InU1DKudlywRPCHOjZLBJyZFXHCRfqzP7+5U6ZvFZ8R4ybzO0pyijy9REnN+sjszo4C6WGKlBo3QMwKzik2lrprLRjAo1tickFZGuMzkoqaUj2QKwJvG7nEI/YccEvzbs1eIzeh6F+zGo5hQVG0f0l+OZ03Zg4LnNBQjQtWfp8vGR7Qy1iX0A/cyjxPaUX9oNa1FB/83c984pG+80vIQtAtka8F8S6uTw7rdedwXG7lBQ0Tf5ysjoo2hE3j0KueaadM3xY80ZBGfnE6Bl7yK8wA5EL0M9vKdt2kqqxEympi+mcom81tomSWKrm4ZTQJiwZPuyqEmoDqn5Rki15qKV4HzzKv1jdd+u+pYr9QFMHXZnQNuPc1kTTjKpSTLjuuw2sndRInPXFNdRQ6ubRSp4t1FIVBh/CPuv4uwavDRx+wjYeSxKGxlSVO0S4hTLtK3/wiUL3+5iYk9L+pA0cFbvkXRlyEm+EIaqGcA9jndrdXH9gNwPItGYc6bTaZX/TUgHKfm5r1A5dctPvZvfUzcwiNKvOH7l7lUNm345WOK/GCz+a1V2BZz9HHZo3ZCZAsTJriAs6GbyZhqU3h3auUFTGqNV5D3Esld19n5EVBIn/C323wL5ckGJLPNuT5MElmtVA/pq43oyLHBgQo55Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(6666004)(86362001)(4326008)(956004)(8676002)(52116002)(7696005)(26005)(2616005)(6916009)(6486002)(186003)(316002)(66946007)(66556008)(478600001)(36756003)(66476007)(1076003)(2906002)(38350700002)(38100700002)(16526019)(5660300002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gG9a3qMNSE3W1FO/wbcU6FeE4DLKZpTVYEHChX7x72gPtWTvRSldofPmb39X?=
 =?us-ascii?Q?v3k2ortvjlWxyZ43/J/G1f1XNyHC9l+lycBHpP51uhIHg3wfRMQUjHVTDNLZ?=
 =?us-ascii?Q?Qg0gNVjmukTvUnggmls8aI30sfjlGl146fzjS4wsv58RvlHusazdO0/4+7m0?=
 =?us-ascii?Q?SRiyzZsLoml/0TiAe4PlgS/dO3HR5qIEj92Rw4LC86/Yvn8LBH2qosIgUPmX?=
 =?us-ascii?Q?Iivw1lmVU7OPxDSv/FSWO5cxb9yAFy6/G8AhEdmUTKmLC9Ow8YoliG97pQVb?=
 =?us-ascii?Q?lkwIlOqV4i1hjd9IoGQxi6tptIkL2ggsIWk6FFDsEYUFeU0LaJ9LxgsLAKgl?=
 =?us-ascii?Q?u/F7r9TSL/Er4LZEoLn0gEyBK0f+k/DqOeZP63w5tAF/I7bb8mgykrpIf5zO?=
 =?us-ascii?Q?P+6fmQ6N/7rJdbYlqpEg9LnLCYg4+tl/spw8vI7yqtXseU9PVtMOAdmC0Z+H?=
 =?us-ascii?Q?9zz3J+SkEhLYkEmdIvqfGbmqUUscHu8lJLrLcmrw5zPGG+IfrtOvikItkqH3?=
 =?us-ascii?Q?oUuAzt1M2kCzrcgaJlIfyqM2GB2EAzQRJB++39MKnNKwhx8+Hq7tNFBs2wB3?=
 =?us-ascii?Q?f3GTxFflcCjGhjxc4eNJczCQLRIVeqAoo5Gh540pQQgJc3viOy/Wblz6IR8x?=
 =?us-ascii?Q?hjsse674X0nILtISwOmQPoAkllfiGimEFIaskF2KvhQ/uhA6nvXN4Wy7e62R?=
 =?us-ascii?Q?blIsk6ItU+fMJRl1xaRbSJBRWgeO/X8tdxS9QW4DF++nndPlBDwxlnFmPJZj?=
 =?us-ascii?Q?HOGN9iGs2OOi91TfXd8BGHtiSqm12VK5TeEbZqUU4pJtz6SH/hcdG3bFZ7KE?=
 =?us-ascii?Q?z0fLUu9GaCNHa3pdDUrMSt+BEB9dBDOl9eWypa9/p76C/zgru/pTaoJC26nQ?=
 =?us-ascii?Q?zexm7D8ICUJ0JJrP7aRr99oNapCaETM/aIXoP966hQ91Hfy15eHkCIh4Xsqu?=
 =?us-ascii?Q?Mq2UHdJCeIkMpoWwvO/DoszZ8cAtmQv6/giRlxPJ4XbnDZTbn2hJPgLLnfIr?=
 =?us-ascii?Q?M+iCUyi+qTFs1FeU509PQjXtaE1R/3NXmjxe+8jmfzb1KHoTryFd8NlRrbuq?=
 =?us-ascii?Q?6WhQIK57fYqLgFz50NSKzZvOPEHgt5lSWzJDEqL1+x+xev+9P4recltNTMlN?=
 =?us-ascii?Q?aXhTBNHGeaiwLMYVsaKKgc1BEnEVvyCGVVTFRs/ZJ9rUijWQk85G7hmrVgkj?=
 =?us-ascii?Q?LXyw6djjbagcIYx36Hj7opBTLw+b9HXrMMpsVZw8AyBkZzcKR+lCqbdNZElj?=
 =?us-ascii?Q?JSmNUl2TNJogMOcPBN6CZ8JIYJYv4uEB15S9jAjDTahaB0/9DBIacZuUpSC3?=
 =?us-ascii?Q?24ugkszXM6hxmu31yf8tTZWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc663a-0983-452b-958d-08d914aa8146
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 18:27:59.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oVsTvESfafRwIKIaZIPolY3RsG9UPkAecDEeYORVcGVkSh3ma1AcZePus/P84+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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

Free the resources if the fence needs to be ignored
during the ratio calculation

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: Ibfc55a94c53d4b3a1dba8fff4c53fd893195bb96
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..9036c93b4a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (!ktime_before(t1, now)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
