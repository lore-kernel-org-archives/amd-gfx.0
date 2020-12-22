Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2559C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 03:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFFF22B2D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 03:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFFF22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AB56E0B7;
	Tue, 22 Dec 2020 03:18:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4EC6E0B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 03:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeYAFpPXNy8QiZ/2cHngRyURGvoMmJqCo+n9flno09ZqQWxTvd0hONocZKyibY8M8RgghQSnyFTArZHQBALqHfXcc5vTr15dBHgIOfQrEUqwiZeAXqImsWjBjamlFJ7+8XLjNj0kjJyd8xCYd7sd3nfL4AK9T1bKP/CQlTNne6+KWH9vsy4UvkLEhmI32pS9WcN4vW8rzkxOM3yWIGVyyLk3E/StSrcq0M7nXxC6nFSW3zEpM/Yar8zuGzqk0c1ZHWW6Jdv4T6xC9RNetgXyBNZF98WBK5/kFk7gczXjgc5nIkdzr1aiXRwJ6tQVoPjjqlxN6I4c7nMPPeaGMrkynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOyYEaLdGCmjUso50C8n7ZLjfYQ3qOz2XL3X5CEIRRY=;
 b=G9ZjFCnnJj2fvEO/S8fjO1xo1LGIJQEnp5J6ZTU9+UAcB9TEEuCyRiVnQrC/13QHCXqOrrrIX/GVHL8wbBiyK34XOMxme8Xs1amXY9kkg8wERPmI32yxolbhuxLKkqX5qhoRkJn2AGSkJrZ0p5IaYTzvM/+BxnUPhbxRWq6MRYwZCDRBu4eTKGCXaXBjyW2H62CeRQSByuOJ9WXTcDUegd0GDCBBwJJePYHZMNFM4nyWgjVZxmwOq7nF7O7rpYOIx7tDuGL0NCTmf8lFkj4eF7HFciYeBL52YHGVjruZ8DFtcy/ejSc9kwKO5mul/izgJHuflcaqBGBXE65Ydqmj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOyYEaLdGCmjUso50C8n7ZLjfYQ3qOz2XL3X5CEIRRY=;
 b=cg/YAqdLNtpVLBX6OBIInY1o46AK5LMGbnlqik0HO/QfBk7GYw2jQE8kU/jsapPUhowGuZvIP/yJvXcaJfhyMeUsXzcd4E9o7GWIrsWLDd9y4TxLBmiSisVr+o3C4/ZyRjPzD94emjyHKFDgn+qPBXFogIV8AEGjQHd3xnvt9hw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM6PR12MB3161.namprd12.prod.outlook.com (2603:10b6:5:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 03:18:25 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::64a5:97ca:ceaf:17e0]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::64a5:97ca:ceaf:17e0%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 03:18:25 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, zhan.liu@amd.com, Nikola.Cornij@amd.com,
 Stylon.Wang@amd.com, Chao-kai.Wang@amd.com
Subject: [PATCH] drm/amdgpu: Do not change amdgpu framebuffer format during
 page flip
Date: Mon, 21 Dec 2020 22:18:12 -0500
Message-Id: <20201222031812.67228-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB2971.namprd12.prod.outlook.com
 (2603:10b6:5:118::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.amd.com (165.204.55.250) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Tue, 22 Dec 2020 03:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33afd28f-6b9c-4197-6143-08d8a6283eb9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3161AB45483B88585D7796099EDF0@DM6PR12MB3161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQKThWh83MvyC7vzgUQ3mDk7yehWX64a9/lmOlHeakEgVxtTz6rQlANH3wHOIYvqu3j0Ob9IVQNbcswLK5N++O110AhhFJlop6VtANTY7ZaUd+4kJDYoOfCzEzyjP6dlkuIexMT/AWjaqMbXdSxqpD4onAIyrIDB6s+9Gh+PnBr0JQXtMcaDlQ+TAK8KMhRLIoXxiaq5KGj6nZW7JyTyZzmcwlc3UOdR3bxUZrk1U2vgO5iamH/4w4SypRv3r/kTpFV5GuBO/dVUXEI1WC1hVVeYPSAXhaznalAsZN/ivmseH2I9/5AxYfxoh3Do8yE+xFghu2jVrN89Clgv3zMzKEPESZw1YQn3jpolBRWJwsqkyzjOUjgLd4+TspRij96YSwNtbuRmIMiTekhizN08Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(83380400001)(6486002)(66556008)(8676002)(2906002)(8936002)(26005)(186003)(5660300002)(16526019)(52116002)(44832011)(7696005)(478600001)(36756003)(66946007)(1076003)(2616005)(956004)(86362001)(6636002)(316002)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G1/yCdgnQLaDfXYbhzzo86yqiHPh+dACQEPm5Q+PuBcbuJxYL09jyRpjfnOp?=
 =?us-ascii?Q?C2Ag7yiSf3nzc6Q7M3facY/wOE/qB5dc4kj/NkTKX1oBCB5fWYh5GIzvOa8Q?=
 =?us-ascii?Q?4y/HgrTbvBoGi6j1L41SJA4ZD+ERGtT9w640ku2HuQW4RYjk9ErXqhM012P9?=
 =?us-ascii?Q?jAD7Sflnoa3Mx3DFDwUgzGgjiq5vmYeWe+3bEDGSzPoGSOhackU/q9IqYkS4?=
 =?us-ascii?Q?eA8hUgn+SnwNjWzRFqMwbDafV0hV3b6U4IzdIXHrISSaUifo2Ojw1mNMRn6a?=
 =?us-ascii?Q?kiM5lq8U/GXHduXQ3I/1nDiRNP7mvY9rnD0Hh5R2IlsDW4/9zn0uvxksIANh?=
 =?us-ascii?Q?ogPZ9ME8oohQyQfFZMTYcjoKS3q/ukt1fsBkp50Rk6Y07NWoqUrKS006thTv?=
 =?us-ascii?Q?LZ7Q652h2lqdQ9EJ4NyAEtYSFFV64PmIlLy+CjAV0jQbFx+E+c6LC16zRZzP?=
 =?us-ascii?Q?jtc8MFuIRIojGiveipD2HuDV0TdVY6Vbg+X8hWHZXpZGuHjK2wmOfMkUYIyP?=
 =?us-ascii?Q?1J6s9XAHyIuezzkMsLR8pzXc36LDEc7uLhvJy2pcZUouPSDp1n2CXk/5PD8C?=
 =?us-ascii?Q?xI6WcvhT/XAM06CEjvasxkV4zE/v23v8tVqFdCN6fsxrX7hIW2LsW6T3cVDV?=
 =?us-ascii?Q?JWFoeWMXMlaCvwLc7oBGWfNtHhB81gCHJkJVzFQxV/NWZxNIvty4cVvF8LQx?=
 =?us-ascii?Q?hOFEwDf+SCGZSNpNLrbu+qECTGFKcJV9JmElsAfEKFYShpWcyZGVva3jjk0i?=
 =?us-ascii?Q?75PYFNnfrMDLseYNcrmGjEYkuhJAA+GvrK0gSkk0jDYrku0oIbuRxN7iVecE?=
 =?us-ascii?Q?LUdzxfDi6pfCRLxxcPncGQjled0/xXoE/xaye6Kjy0RwifX9OLHbi/OVOpdN?=
 =?us-ascii?Q?e/nIXEaUrpwwBQHfR+PZFN1LGxj/toEBvRUPEuNCLOJv8mN3N0zN9oQ8rp0S?=
 =?us-ascii?Q?R4XuOHXVo+rduZ36BkVncUOz+ip6XLmd+1/K4BYTMiGPoOPCneHVmHy8MgYo?=
 =?us-ascii?Q?Mcdo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2971.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 03:18:25.3584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 33afd28f-6b9c-4197-6143-08d8a6283eb9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG9WnSY6HbmrMdJZ15Oz638fzeno0HLgsmhWnypHlGhzA23ShZRLmurC//rle5T2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3161
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Driver cannot change amdgpu framebuffer (afb) format while doing
page flip. Force system doing so will cause ioctl error, and result in
breaking several functionalities including FreeSync.

If afb format is forced to change during page flip, following message
will appear in dmesg.log:

"[drm:drm_mode_page_flip_ioctl [drm]]
Page flip is not allowed to change frame buffer format."

[How]
Do not change afb format while doing page flip. It is okay to check
whether afb format is valid here, however, forcing afb format change
shouldn't happen here.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index a638709e9c92..0efebd592b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -831,8 +831,6 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 								modifier);
 			if (!format_info)
 				return -EINVAL;
-
-			afb->base.format = format_info;
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
