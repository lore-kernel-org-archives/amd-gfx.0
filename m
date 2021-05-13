Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D67C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F56613CA
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F56613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938386ED7C;
	Thu, 13 May 2021 16:59:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689B06ED7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 16:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+KnIQNGZikaWmAMbeE/cxmOLLl0col8WCppnnVaMIOye4z55Qos/UWECxRoqFkTZmhP+4YyuG+TsSFX3bnezKBPh4iR9zINh2amWIkQURL7E1hfGlZh6XAi3ZuYgkwidvsFIYyX2kCVl2uHHs1bbE2dkqvfwfYzERTZCs62ys2gUBTwF/SEo+bfZjV1PA+dp7bNTGgA/S7A6aNk1LHjdSsBKTxHHteQ4faN7NNdWrdNRJ8juWSdAl1vzSpo5MDhWghxQt/syQHNhER7Qv+nv+dvdpACTOg11AA6IGCfm7yyoVB7P+eh9rJlJapWx23lQLvuPxldMt9bBQJYpW5osQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErxJjb9gYJ7HDyBuDjJbEXpbhKbj3snCWdIJaQer/3Y=;
 b=gPVwGGYz/GVERYgeIj78fN/DEnk3wVADXePjoi3SCtZwzP40f3y/2Ylet/gZ1IJpOE8fvsOr+kbV47+KxSXq4/nkaYUIZaFMgzq0ZX4BIhmAj3WqPPiQs780ViheYV1Wp4k5c2iIoDgHOrCYu4yDuQi8XuURtz/23QUYq7jIMBlBXUGPFpizNIOdxMCKynv0pTswbDawd29gmjhJ+XdbvjYjRl1KZrwnf0pFZe9BGV9CoSdm2fj0z02dpp3NKDMqUbhsY16t8NQA5RfFxEgqF0xVfC4GBa0VYqqy6S3ShDBxlpCKMbzGelwXITX6idaRKkm5bQHPIm6Vocpo2u/Glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErxJjb9gYJ7HDyBuDjJbEXpbhKbj3snCWdIJaQer/3Y=;
 b=hT4/cTXjH6+WC3yxmN6Jn9J/Yl3+h60N68nnxM8g/oG+bwJguN0UPWtYicHxH1cpgSJYiIv8Rr4ukkNqTLokXUJHqumKv1O4g5dKe0HxzLrngfCYFvQtGWm43LDMZCkyOFQBqkPxsJXhUOLStOhmzGdgQAV/9NbTmev6Vrkxj8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.29; Thu, 13 May 2021 16:59:07 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 16:59:07 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdkfd: flush TLB after updating GPU page
 table"
Date: Thu, 13 May 2021 12:58:54 -0400
Message-Id: <20210513165855.16395-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 16:59:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebdd0012-441d-44e1-36ab-08d916306ba8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB293887FECC443BA5AC0346EDE6519@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+rLLGlsDLLG/7alUGg0wLAPc85DF21yzZNdyAONWOUxcG8YoCFx8laZ9rXDoYsZPlobqs1i6MYNH4w0QEqn2gF10AzNw8Gw80IaCdEv3/8PP/y02iVk1z046vaqhrvGXjb+J3Ks69VCPNY9pZ08gXrE3o9nm7uXWLo5VlHDN7IKuTkBJyQXW9p5+jNCAaBOWaPV508RXvUm0Y9RVqC6f53LHZ6i87t3Ngj+JaDJX/slTMu/qE35VUxHAyEU2pW0Y2ZFjkVSkd+13NlO74UNmcGIlteUAtK2mfwjjw0RropD2SQ5k7cbMzQueTaxsl+yvZRMBM/xWdyCYfW8mUB03ZN+ZIFiZ7ix9JZBkFAVECY6EpjO5c2ZwQvsoItmRIbabfA8LMUw5hsN2Wbm9Cgd9Dy5qCWNQfOVgOPYFkLifOloq/lTR8OLQsTH0D9YEOTeY2FBHzj9wjTZQLpAzeH0I0sEuXbpeaai0ltBcobsz5YNlW8nB+LS/HLQRL4S6Qlx3DcV4FVK0jbRayamI1FgCsWz/8C+LXVkuzm3n5IGXVA9pHAH30PnSzw624hZz8Sdi0P9zle4b8+wW4zXzynlWHEoP/MjPeFRyPGQnbSjaL9L1B62hVWV7EVwsVXCklvdTh41dlDO+t4QUAWtzOui3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(478600001)(2906002)(186003)(26005)(5660300002)(36756003)(52116002)(4744005)(16526019)(6666004)(7696005)(83380400001)(6486002)(8936002)(1076003)(86362001)(956004)(38350700002)(2616005)(66946007)(316002)(4326008)(38100700002)(8676002)(6916009)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5gQali7BNQcKkVysninQsnnNqLPfvtFGC2IC+ed9kbEc1g/otTa/tJOwOBAX?=
 =?us-ascii?Q?5176FrPW/JFJk9+oNhKc3xQR1mAt9+sb8Rh0PhgdxdC0qIMH7cPHIxpoRIbc?=
 =?us-ascii?Q?YALZATuR7ShXw3vTPXzAOEbveZbYA9iBhuz3EauFIjFTDBom2V6KRZtVgk/A?=
 =?us-ascii?Q?guBm0J/laUe+jwHAvsAmg3nIhCoHrxGS9gmWIXzTHZYdw5C0B+doV0/pGGY3?=
 =?us-ascii?Q?5dBPclx7+8bVrPache8K+7STHveAUoDX1SfknkAX8RPQg+0TYz2mSeVsNpFe?=
 =?us-ascii?Q?BxJ8IPp6lrvxhycKCn0VPMaWr+FkILBcAZd0wV/r4ZQgX7oIjKbUC2EFmS3H?=
 =?us-ascii?Q?KHzYsP9+EFeRJgk+L/8kT6A/SDoooyxJBpBtFiXE/sq9ZjZEt0m5mdxGeMA7?=
 =?us-ascii?Q?P+g5RiGsQjhpthoBzGNpL1Tiu+zUP1HLOv8sOAyFAETVszKBSKR2Ft4qIPon?=
 =?us-ascii?Q?frUoI9lMXC+W2tkzX1khfeIIt06Q/qfqLlrDe13KSKv6JK+Dmzr5pAxUl11X?=
 =?us-ascii?Q?cy4I0WATEnfbJOSLEi8qpJEPnEU2x8+XyN4fEQvHKN4LHTZL97sMMxVnQP4K?=
 =?us-ascii?Q?yytVemehAgGe8JDnHaeJYZ8x9REfAO9IH3m/EdPLnHZsiMomT7bPlY94cICQ?=
 =?us-ascii?Q?CmoGs1JE4Tk5ZgZahqLTjQH3oTMoA4ipPzWY14mF9Gn84fzxJbaWtIY78paI?=
 =?us-ascii?Q?HZOpn1pA1THRB17Z9iYZHifMuDZl9prAW5pmRDbJKY0Nybfpu07ZpEOocsg1?=
 =?us-ascii?Q?rWLGqZcyX2lmXlgL0R2OEZnbOijwj7/35foEdPSlPuW5hyjdh+DAJTbmrWe7?=
 =?us-ascii?Q?KonYz/A4T73DJ83VUQEVBXOpBBXaSXvolpNbdqc6PmxdkAAe+9audvr91K/H?=
 =?us-ascii?Q?iKDQbFLhH2r/xqUVZ4DG/5hcRIwN34uTb4XhjXlLro0sS5WzED0U5oQ2ptZd?=
 =?us-ascii?Q?vHmNZ2cqH9TIHKxEpzoXDUgQG7FkXDi3MG6BLY+1ZcH66LEU7yBJQ08z3QU6?=
 =?us-ascii?Q?yyYlTBAMYqJEb0hn5nnahev5bPVkAM4yg9//+nHalvuXcInt8gEtLwRsO6SP?=
 =?us-ascii?Q?8Nt3OOL5o5L4bzWE8LTfUyzZ+Mem3GSeMN6CjdpxGaoa5+N9iNVOsEimv4+8?=
 =?us-ascii?Q?j0Qq6lv+J0xsIqH7AY2GJxSH/qenRLWlA9wdNKe6fvRu7R/ItnRBS9q8gJm2?=
 =?us-ascii?Q?lhp01/sbusxfBJKFSMZxIrIm5rTDj8mmYTNFEvr1cVQ5BU6QXdPXTfrMWj7V?=
 =?us-ascii?Q?DiYgj4Gf5/ANUhSLBmJeipg3rJoLl90YvNcCR3GHYYJbY9BNMu6Wo9vMrGYH?=
 =?us-ascii?Q?lbgUsu2D+ptCzCpHqncuE4sV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd0012-441d-44e1-36ab-08d916306ba8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 16:59:07.1472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f6/B0GFnbYRKVscCMzJEwrwceSDSzZLwGUhz/hwPxAUv2kDnW+Bd6p3XZ2nT+mW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit bcbc99676607d4ff9fd15f27481cb1794a567d65.

After "drm/amdgpu: flush TLB if valid PDE turns into PTE" is checked
in, this workaround is not needed.
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a518ad26ceec..50da0d1fb9c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1240,9 +1240,6 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
 				break;
 			}
 		}
-
-		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						  p->pasid);
 	}
 
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
