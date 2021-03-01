Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D58C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 15:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C21664DF2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 15:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C21664DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243EE6E489;
	Mon,  1 Mar 2021 15:58:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 858346E489
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 15:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e53w5s8z7/bqJhV4FRbflweaSM5h9STVtkAJvF7RIxBCEviEZi9yRqkN4pcBuSc0Meapg/ihgFNsiY9U6pEKIdwjZqzsqC2LbruoQg0vjdhp4V61+u2xnUUG3Dv6j6Ca67y14g9tBxo77pDWByIcE3fy4yft/B01A/s/0Hk1MT78vnaqbdChVcX6DzQO5DG/SAYnjwWpgfXKpcSqTDMpxX59El49y/KAm37YmYldYBb1iz8rhieI20JYitEHdlH2+8GNa0p1M0Bs/c9AZV/VIfIFi/zR2xmajtSr8WxClvPUOCZ374zfOtMIlLi6pfaU+q/aqXvSPL7UiGEItlnt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y9O/B7BAOrY7SA694YY7VMEUH6I32dcFgJwUafqCbI=;
 b=HVGXFZDD4I0/FKzLKAtaZWdr445XX+u2JmgUwICvpu+faShYPl0pBNSn/KiuxIG+mTe2y2I0pZb6CTN39gAKmnHv3YXZLvmiEMhgKrFpihLp6rU2U/g/h3EpkBZj22M4uLufPylTSpRstdoGzRI9Ep1rnwwC9++zzS9tpK3Yf8qMGCcdR41Tht+WiHzrvT+bE0Vl7fNKZmKtRIkrp73xI3dUxlBQnrsE3ukSDdQWtcIZqnb/HuDf9aXO4ILOC/3pj7K2GuXsqSNgWEgSczYACFNcmWERU3DO50UsNDlCQJbsQSlpWnFdcWP9TxzZ2QTJJQN8PsQlqvgaXyCpbI76qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y9O/B7BAOrY7SA694YY7VMEUH6I32dcFgJwUafqCbI=;
 b=jCr7QOw3mlkXOhxP8bkzEgfaKqvKRw6TUQM13iQ3Gdwa9IfZoyTLpTdt8dNw7akOPOB8uC8pKvo4+jTOUrHX98P9/5AXNyIhgfasttc8CaUzWgP0c93IdjdhKc+TbegaKgn544Pu8PYBoTDU9nsUZiGb5G2dKSScmuZp7zTfbq4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4723.namprd12.prod.outlook.com (2603:10b6:208:8a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 15:58:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:58:14 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable BACO runpm by default on sienna ciclid and
 navy flounder
Date: Mon,  1 Mar 2021 10:57:56 -0500
Message-Id: <20210301155756.1556369-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 15:58:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fdb4e25-cd8b-4589-1671-08d8dccad249
X-MS-TrafficTypeDiagnostic: BL0PR12MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47234151D4DDA969226ABF24F79A9@BL0PR12MB4723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RCtyQnAN2xG89NP/gz8r8yPpSMiMS0OsFT0mgHiubXzjQXbzFSkUd++Cs5SgElyOhfxMGSsnDl7nb3vHIC7bBAjxTacabCkOcu5O5gZ3AL76bpeE4PNlgnHufrXOyImQi2hcHC+YhgoeS48QWXw6W1I33at3MGKPAd41nuB+F87MiEbBosdNIWz4nJOJMcY3MqAr7P+bBp63W4CUi+EpbqyIOrE2MpIJZAPV+2xPFv7ZwYURL6wP1uIhdhweIiglv4fiSojOw+RtnEiz+UXCJQDgNFA/C/dGgqj6l+k6bvvk7xSwuCdrUECA3zaiXn4n8GF70HkNHMpeSyYN0AjdKfPmLBkXsnLEVqe84HR8/VaaJDccEYHfnt2GzdVz1si0Im0sZNNIkM4PU2l6AQ46eb0A9k1fE0ZFPGsKwV1NWXV6UOOii/Nq5PAIBfyv85DCLndEtrJmFD287PJz2HLcIYtXRhRKVTeZeLHFixOGMWM3TlIFO4st3R2nY0C0kGBMJIFNgvijyeRyBQ7B4BzdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(6666004)(2616005)(6916009)(16526019)(2906002)(36756003)(83380400001)(956004)(52116002)(186003)(7696005)(4744005)(66556008)(66476007)(86362001)(8936002)(26005)(66946007)(1076003)(5660300002)(316002)(6486002)(478600001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MubqjI+wwK1AfkeZT5k07rIo12k2JC7cCBYJmk5TGMrf6e+ysvwpTNudkjDY?=
 =?us-ascii?Q?IChLgtlaUc5eO5QEhQ6kgOWY4IMwWi2tTX7RHml4vQyWhbDhOO0DaeaFxzD9?=
 =?us-ascii?Q?uGHJMNEEIyb5TuAE8HGl1ZDoPnwhlHyYaTMNtmZ6UO/9zExi31ZHb0KRX8mE?=
 =?us-ascii?Q?6HXVcULB/tBbJTkSKY18qmeYZedmxNSNC1bGMnbdnC1U4Lqbh3iRwgl43RRT?=
 =?us-ascii?Q?0oGhFD+8loQ2jVn3gBsYmWXCrluwYgq2Rd6jZfRwRhlrGHx0i7h7rdMS+CbI?=
 =?us-ascii?Q?OmfGPHexVN+meYs0ZFzhhRxNC/pkurfPDhipSTWOtBNJYLfQAESd87K7e8Ez?=
 =?us-ascii?Q?vFAKg1KwEGUvoUDPO6A2N07cp9khQfcSxz8v4/E9VuQgjfAK+d5bUKT6LY5i?=
 =?us-ascii?Q?PHVSHfa+H+QreOtnJq4oOtiuqMHW+ixK+tGVUuG555AxhEOG9V+4FQiwGbd+?=
 =?us-ascii?Q?C3IZd6DZqUPxn6E3qPKDH+dqaNXRqcz5M95ag+7eYwvDsU+tLfM7ANcInz3z?=
 =?us-ascii?Q?IEuNRF7YaDS+IsZ9Gdq8JmqhlKjLRKev/IfLpMBnDl3bkaKuqIzU1WUONwaI?=
 =?us-ascii?Q?qRYINtmgExPfQBLbfiqUoIaVXiHWPP/Qk7BVwKTnUsScMAJG6fyMhppwY+vE?=
 =?us-ascii?Q?eSeKRJeQHBs3mrhsqK2FiJfx7JGnJsoVd3DB9kX06Aju8x7V5qPWvfmfOuWU?=
 =?us-ascii?Q?Xpoqv9VlyJg83HPck1mwie6X2KcDveeKqp3PWz0ggdLGhu5ea5an/iZt75dI?=
 =?us-ascii?Q?crFxqQ3wWDlmp+aV1A1JpRZI4G2miIOnZRQxmdjsis8gBPIWzWsHifeie28Z?=
 =?us-ascii?Q?NBIycJSuLqriP1Sa5zd28ENK6d6z1K0betwSB07wGDpCRIlVSHDqfq3aTEKb?=
 =?us-ascii?Q?Xw6rDei38pXT3hcQOAI9lL7fcDQGHmNdJJIr4F3ySUy1RPPgdHL1q3ZfgChG?=
 =?us-ascii?Q?a/XUBgl5IOkDybi+srjLIgaElRjapm+FTuMmSapVlNdjQlsq5ZM1k+8iY9Od?=
 =?us-ascii?Q?g5skKGwF4+e5QlJL8BzxMPa/DxF04c5gI1yfT7JMn2LEu3vQi7Pz8HAD4Ukv?=
 =?us-ascii?Q?dyXx8qzI/ufVA60KAcWtg7hvtzNc5/yBdjYGfgWKWIWs1YLDtqi/GHexXxIc?=
 =?us-ascii?Q?TQLRge2uPSXz3J1+s/NPkn03DOco1k0kdn/VhaCyrILIZkzL+udPpUCPZhXU?=
 =?us-ascii?Q?oVj6xlFp1iN6FC6MsU8PqfA4unFyotpICzbNpktDwkj2gEHum6QHvRZm2oRH?=
 =?us-ascii?Q?JQe1FbHVne7idLNW+LRWCEuICJDTBjCkyaTjZDX7zqxgMvqit9oWX6EZ6IR1?=
 =?us-ascii?Q?xVg+8uJEROm6bOle9Wj1UKSD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdb4e25-cd8b-4589-1671-08d8dccad249
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 15:58:14.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao7aWceKki+91dhSJRPR+kJel/jOAJ8qcrDrj6PRhMk84DFMTtduT966YXOtJQulF9vUJy2vvzPNzfk9YsDMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4723
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It works fine and was only disabled because primary GPUs
don't enter runpm if there is a console bound to the fbdev due
to the kmap.  This will at least allow runpm on secondary cards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c03e8f52dae4..fbb863c1cfcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -172,8 +172,6 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
 			/* enable runpm if runpm=1 */
 			if (amdgpu_runtime_pm > 0)
 				adev->runpm = true;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
