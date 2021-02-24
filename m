Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A70C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F412E64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F412E64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C7A89C25;
	Wed, 24 Feb 2021 22:19:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366CC89C27
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYQn5DkwS4S2yXKzGeiXtwDPjs+pMbcKVvFEIWebdpynEwmSvBoHtIrzfIZ/nI5CycJSHqa7+451B916pfzTmIzL50gqOJFAgGjKQZley0mmeJP8zvbLrdYaLIUeO7K18LTBafGxsCE7hhsXnxcHFm6OIepfrQgSPGWUfEJwCayztoYd1Bl7SgF54g0B/batJAtnQhBxdJQEVdrlNeJ3AaJ32937Yc9RqYHRGCXyHpLxsSpp4++GcANBIMyPlX8zh0c2BnDy0saBrMZqqHYR9gL4eSgI663u0OhqQwDNXJxY1Eb+vJvTU/6LigZZt5cScsmiOSjc8Au8hJAnLRwmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie5LEf5CggMgLrcqG2m5BFni/1/Obe56AWCVsNBUn3w=;
 b=VkgYecAHDR/wYgeevj/ZSwlBTNmQquxal9JyAOFnWgUNGwbq7Gqh/rET/XESpahT/1E8tX8sQyHwdl1wvGOe0Ub9ySQFuEGeQarFpY7nSxikAYGtRMPCjOIm1i6qcy8bFuoD7JoCAvvUCbOslBbIKuMtEh7kImoB6s/MXkvWZKvP95NwXa4/mkisSTBOAQDCfeAC8/oxYxVt4v1IVHaQpMvcyYqEor+O7Ohws82lNi00PjzAo2lD+UN5jiwfTy0Qvy6znOTwdKEN21pjphCfV8bqkUlmUAgLgy2YVGW5VrRHFBAcvYa1Ps6zQ7NfPAJpz5WHhPLM/AYr8IgVTowzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie5LEf5CggMgLrcqG2m5BFni/1/Obe56AWCVsNBUn3w=;
 b=WeqS8r+2PvcSMOFBuF5qlXOH9d6aBtvDb/MoPQcBwLZ34VhTm/POuTQS0ZCj0tZuFpX3+aRZ56hIng3SzcgJFS4CZn87MXrBWb7Xh9erouvbRSm5XQHG311CjHHO/nZDbwwcP2VSOoaKJDRQrINezsa/H8XSlZ5lHM5Usark6gQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 009/159] drm/amdgpu: add aldebaran asic type
Date: Wed, 24 Feb 2021 17:16:29 -0500
Message-Id: <20210224221859.3068810-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f65506d8-5f0c-4cf8-9086-08d8d9123d6d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24971D8A0D2C2045169E4D16F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+Yh3v3U1PaS0uA5ZiUTYdCLRv1OTDJJFHl7YnTxBMFtqctiicKEBsr6ntCkbeq+UpwqdxmK3CCODJQHB1CELEF/mGlVGUbBZzQhlFas5+CNzUJvzXHgDdnCJeN94JNGuXaRhDRI5nUP6t/FiIGJPArCoSa1ePT4PWw64o/0svefTp1TEtDXprr/fkwJtv8tmlkChf1BMUSRZD2DxPdeFwfPjZYNwyMxKwglUQTBjB+4fgFwR4NDPU2SID2jd6hlaThSsJjpxd5FPfVL1cT7k/XWWq8yHKGJxqTho33EOgUD4Ijpvxq/W8xoVF9SqPjLNVenWaWR8g22+anU68soZFwGhcrEhBKIInsfGaJVqZTzwxnglCC9cI7QggQ0Qn7QS31ph5V2MznGDeKAaQnOOJ5qDTa+bYVny7US8oheyiafh6Qa9TCdHvEGmm8N3rMP3jrGgQYohq1wizmZYH08wnkZMmSHKh47gJdQVgWsv9C255WFkg7mNnVu0adztsrGHHgoORLcJ4bp+DrbEi1uGcnztDf8zUF3pyIVFY0NNXMni9g+L1J5Z/rfGMRPPZ2x1x1tKOGdOokgk4BEIL4U1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?djctu8Ff8L5h8Hmfs/VplgmdHEvTUCqamiRYbgOqw/bfW3IPjMcfyexbwVJ/?=
 =?us-ascii?Q?7kli6iZoxP2YSDcOBywbdJM6BW30Tnu9D+txG1a/QP3hTRPeseB1h0Fl7ork?=
 =?us-ascii?Q?wGHN+UpG47BREz4Y4rfwNuf0IpdKrJxDUIV/HCTr4vf9sb16WjXRy+qyhVaS?=
 =?us-ascii?Q?6HiaVWj65Co+9YXbCg7wjdewLsF8LO2Avm7jsgp85fNK3aw4fbPj8ewydx4z?=
 =?us-ascii?Q?4MzUMze01ZgqXs1bgAXnOLL6rVyjVGwPe0oMCBWEegO3hFrwHO4tEBLkccNY?=
 =?us-ascii?Q?6NUWy0/urHR60wafwFQEfahUDqBoaoS2A0JwnA1/SBg6JTv3oW2VMRfsNJNr?=
 =?us-ascii?Q?SIsY2HCis40Mm6L1AOEdoJW8gEnGMrm59iqe53/XVFmJYNAiRLYYTsUYzDNm?=
 =?us-ascii?Q?NMTBRpWqTon/xWj6qyqH70/FX8n71QeDoNz25nlOmJv9gsX7TGbJU8pnHP1k?=
 =?us-ascii?Q?DUu/j+QSKB9J8cl5+VB/wAP2MUvYmJLPTDnAI7MeJxEshxC5JZhl3xZR3Vcd?=
 =?us-ascii?Q?my7a3sQe89NTj2rdzMZr6ggP9MgEDtGt9P7FC6h57eyLT+O86tDpSJveHuWe?=
 =?us-ascii?Q?YZBOmpWf4OfDuW2NNERETs5g6jyvZiFSziDJTkgxh022Rc+StolXLV/xXHJK?=
 =?us-ascii?Q?OwklzdY1jpenbhs/vIkrNMrZqgAiZ9oOgL5ziwD6ka1ZYmqhBlCpunRVn4JC?=
 =?us-ascii?Q?ZGFiIvw+rg4XDRJ21PlTA1Jl05xD2X0UR5mvpU7uf3kXtXt8ReEWw5Qy4UHN?=
 =?us-ascii?Q?DkdXHNZI1isMG+ck9M5YQK5kfx83tGrUmUzOzsaqDldzUtCE2JAEGfLQf9Y2?=
 =?us-ascii?Q?oD4EnDlureMeKLkE7tzXxGR7Di6Zd5PIlYRsfjdctbj0E+qeK6WVHQBjnjqm?=
 =?us-ascii?Q?kgH4U45cXTMGhbQbmEV4T0ELlbt0sNOU051GDRoCpfv+fdSnaedCd5q+J+GB?=
 =?us-ascii?Q?RPhJ0Q5aAbfWIyoxECfKkU0dp3Ts7ncDtFt2+M8GA6+xNKKQJjYvqy+tOkyP?=
 =?us-ascii?Q?iSzBbBmVh02ViRzbzsuKSr10uOQvR+tD1HQJPkGNOKdvY4McikRJeR6QD5VS?=
 =?us-ascii?Q?+c9N/B4EBwiekRpttFXGkIw7yrlR2dMnL4DotUUAcPKQqVkY4Se0i4aOuhLv?=
 =?us-ascii?Q?u9DDjZ5Fhsf5pMaoDryqKYjHMMfAWeRbeiSRbvSVTpa23CVavnWflR2EC2e/?=
 =?us-ascii?Q?POW9mAnjfrnal0ZnCDfds7/NBAP8ALx+hqnU5Zcsa5eHz6TiakQdgjiKZnOi?=
 =?us-ascii?Q?ecshXkFxeLUGgK5iTc2rdzV0MU03Dc5Bjck8dm/sHF8Alx4b/DSAxSh1mZGY?=
 =?us-ascii?Q?naJ1pftTiHnqPMqNepmI1+0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65506d8-5f0c-4cf8-9086-08d8d9123d6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:23.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMWLhPg+WwhbPdKPy+ZogADWF57HG87Frvw/+TjbiSoDU8pP3z6/2BvfXtF5kOW1N/oSH2MsXuNQ0w2zELAktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add aldebaran in amdgpu_asic_name array and amdgpu_asic_type enum

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 include/drm/amd_asic_type.h                | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..801bc1c31c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -110,6 +110,7 @@ const char *amdgpu_asic_name[] = {
 	"RAVEN",
 	"ARCTURUS",
 	"RENOIR",
+	"ALDEBARAN",
 	"NAVI10",
 	"NAVI14",
 	"NAVI12",
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index cde3c8c9f20c..336e36506910 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -51,13 +51,14 @@ enum amd_asic_type {
 	CHIP_RAVEN,	/* 22 */
 	CHIP_ARCTURUS,	/* 23 */
 	CHIP_RENOIR,	/* 24 */
-	CHIP_NAVI10,	/* 25 */
-	CHIP_NAVI14,	/* 26 */
-	CHIP_NAVI12,	/* 27 */
-	CHIP_SIENNA_CICHLID,	/* 28 */
-	CHIP_NAVY_FLOUNDER,	/* 29 */
-	CHIP_VANGOGH,	/* 30 */
-	CHIP_DIMGREY_CAVEFISH,	/* 31 */
+	CHIP_ALDEBARAN, /* 25 */
+	CHIP_NAVI10,	/* 26 */
+	CHIP_NAVI14,	/* 27 */
+	CHIP_NAVI12,	/* 28 */
+	CHIP_SIENNA_CICHLID,	/* 29 */
+	CHIP_NAVY_FLOUNDER,	/* 30 */
+	CHIP_VANGOGH,	/* 31 */
+	CHIP_DIMGREY_CAVEFISH,	/* 32 */
 	CHIP_LAST,
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
