Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A73BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04700613C4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04700613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C166E8C8;
	Tue, 20 Apr 2021 20:21:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1EE6E8C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/JsRb1i8HCeywa2YeQprX7wIrx6lt4svxpug94SKWZH6xSNi2p8NNqcTIU3+72pH75XvZ/e/97ewW+OgOZpQqium6qVdz5POMxxrb8WNy5geisCoHJ8qWKODrIrQMykB3u71+QFji+gnR6oQ5yQsvbfJHAyRVY9qc3UWAUZNJLkoBIkD/HIwHTWZ3PeSzR+ObQIOtxHpZt0tQov1NUkGNNtNWhDGkZmvoC/1NNTLZkZZDZ6j9fmUnEO8LmYa8i6b8Zz+x2elfkSy3GuDxnnzUtIl+RNDzmiw83j2YINsbo++GP5m9XqRUAQZIYezdILd4k7tBVjPOfuakRljcTkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd8k7Jwoi31bkoD4YeG2MAx2O4xAlO4iV1KuQamX2oo=;
 b=WUf+Kre/Kdpua8GXVj3F0a0XMXAJEca9a+Cx4ISXX9sgc/MKfxhGklvhxHvM9mrziKy24qWvPcAzqALVJzm9xiQ/h9W1qOJo43B+tyF5HJW305PmFY+6Zs1ZfjQtcI6joklln+r+EIaw/lUjQoc6oM6TbC1G16Y9l7vsKBD8MvVUfh+XvI4yM2lAScqFluQAyzsmW4bnGCpfw0aMNaZw1z5EoRawXiFF2LPb+FVROYZNgYlexN/0y6QAHVXRqxsl1JJKhdLr7ELsjRZ1JDgTRTuO2ZunBiHRzgAYZKW43duQpMyooHKWK3U6Ax5GPHRM2YCgzSU4QS6ASBMysPTijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd8k7Jwoi31bkoD4YeG2MAx2O4xAlO4iV1KuQamX2oo=;
 b=cpiltrhbz2yeWLRm1Iih80zO4ZkAgtbb288/iXlEmOO7CvDVEkPo7SZGF1vmmpHQuEKiZSpFq/e5I9sC6PXMI2YH6ODDotcKMOd0tldFzE2bc3DfflY4cyAaPNJJnccwzjAASVFXPIblqMTfn8h6TATvO6c39JGkP4+DU1tqaq8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 20:21:38 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:21:38 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: return IH ring drain finished if ring is empty
Date: Tue, 20 Apr 2021 16:21:19 -0400
Message-Id: <20210420202122.4701-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210420202122.4701-1-Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 20:21:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6536cf6c-51f1-4429-7c63-08d90439e6c5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488FC83B4E725BB96994C80E6489@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSrm5/blOpOX0BdrZD+BXgHk/UWg0u+ZRi6+yZfmGanWMUtlqT1ikJjk0DxHG+cAS/2SXitY2PztyvNJa4fyLoytIh2XGJcZp6OPF3wS1bhrkqK9grbJ3s09XOlrvgBzhBcO+cF8kXh88KekxNJALNOCSh/54y7+dpznCXITLyeagx3tR0VFV0VDSHq0D+qVGAoW7I29hrljI8CTYnbjZc8cSQcwvnEfuA7gIxEkv2v9a9eaE4g0+Zjj5NVnLd8C0HEcp6J9CkDSl0J7fAgxMwN8rtl+bbVUgiDJo0luD1tBIa7AibL59+LZ55VEuag1jFpVc0D+9w63Ilkjc81imKt5C7uv8d/h0p4Wstli5Iavf6xsIIIDRXOIYegtbmGWIKwTpb0OzNh304/K0w+aTurZ8p+UbaDEQpybC5Rf+EI2lofaBkQ5hVsOeggkz9MyOyTMHdqmabBiHyQ8qCFXOjSF7hRhChjXK7WObDVB4T1bVRK8I4aD98Un8Xm24+nOYvbNINozhNP8Q2+rbddoUvcZRnYfg1Ed26GO1iGg7k+SFMe5LpkO43NZIvgWl77gfuXzvjpdy2sY9/UIaQ/LriwljSmTUtb+7ZkecHJkgKp5o6S8VTP9IAD8vTpnB+3mSOubhrCoS3q2felKEDVjHrEQF1+9Ls5QeoxCPmfvRvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700002)(83380400001)(52116002)(66556008)(38350700002)(1076003)(2616005)(956004)(316002)(2906002)(6486002)(6916009)(36756003)(5660300002)(16526019)(7696005)(8676002)(6666004)(26005)(186003)(4744005)(478600001)(66476007)(8936002)(4326008)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BSnD3JxtVkEvgxAU9aYGyqSjOSecGZDZ76ZmGzcmTvOKxkH33i8nL06VBbCG?=
 =?us-ascii?Q?yooldRGXwK3OmkK0h0Pg305MU/DkJGrgMy8ifPx248VNE2YznFFiineSSRdV?=
 =?us-ascii?Q?hage5KylYZ4+0k6zLEsogaVIm1Czkcv9JdnDqOjJ0RqBerNO67QMErg/ZCd+?=
 =?us-ascii?Q?7vWAILJjVtIToz9Z6/NLeW/bKETAwizTU5dcokBZQFyx6U/u/hGEKPS4R/jt?=
 =?us-ascii?Q?rsCNFoEAYzs6eIMhrji7+0kbEm5kqimOIwtzmiiikw5gWyYqIC7HTu68Kr3g?=
 =?us-ascii?Q?J/lzJWk01m6huzw+pzTss7Hd/EWvnU5leeYkd8MZg8U4mIzkJVZDB352bJ/n?=
 =?us-ascii?Q?XWpUQU2hHZo4gI1AqtGLpaH9vj/sQ3oByAojjBPSNmYwTcyl3SKtPosV2y20?=
 =?us-ascii?Q?OTL6+pjLMHK3cx4ES6jFfUsKm3/PD8HzDg6icfHcEp71C1fF1cGKhXl4u+Q6?=
 =?us-ascii?Q?CZYXDqSEJDC6v2mQ1LAF7mB+qN9q80w45gcezlCGiMMJtxDcTa8jnlDrtd9D?=
 =?us-ascii?Q?gSwfLuAadRovb5r1T6lqFFXotJnGB4p9+9mGGac8sizZgz1GxyHD3A3eXObL?=
 =?us-ascii?Q?CO22CfSLibBCYg0UV0VWDTJ/3nO8CElw/kItPv6b4ihlu3QrT2sEQvSZSEld?=
 =?us-ascii?Q?+7SLCcOO3OX4egfl2ywVslQKMxP9L1MIo/49GBtgPZs3b75h7o1UIZofAuxy?=
 =?us-ascii?Q?NDOAPHm6nfIvVNMG1Pj8TNXGdaEK3oQ28ZzXT61FfbGyPkPcdwiMsYJZXr1k?=
 =?us-ascii?Q?dqR2mHi9VaanoZ5ZpmsjhKZG/2dSUOmMAxY+w2Xcd0ycEFw+ZjOVrpU40L3O?=
 =?us-ascii?Q?I/9L5QkDOk5EnAxo/dFSfmp4gYWdEq/c1OpjUVrNp6/ATJ3+VHGL9xVAm9ZM?=
 =?us-ascii?Q?FknU6OgyJ6ytJn92pypMamJOmDwOlHrJvzUStsM29F0X+v0l6AUq4wFc8Jd/?=
 =?us-ascii?Q?0YVKyAOSbXDZJwxOeIcR3bYWOKcA6J94WmMGf1mo8QiUV/OQZqUJcZC1upvU?=
 =?us-ascii?Q?4l2CDwKVJ1DNr0WgEaIRgOVBKpgLsWbj4IyREOYG6UIlryx6+pJ5R3LvST6J?=
 =?us-ascii?Q?37MjcI0kiDIvqR8ytbG7L2CPLnBSEn5ISsNDWR4kbJPbi9Zxq6qplMqnB9gX?=
 =?us-ascii?Q?Wv8aDgkRIBn675AW+dgmMIfWHshGTmXbv8BS9G5hhF1HTsulchGhq20XMq9W?=
 =?us-ascii?Q?Iu6wRp8J5y4SmMOgwixYeUkqOTzaGR0mkRf/z0iUSYMCNOzEWlODBswHUSR9?=
 =?us-ascii?Q?xg+eJy72aJRZyyZqWEy+NsyPMwcyD0TY/O2WSE8HvfKlHKR4hABBletmr1Fa?=
 =?us-ascii?Q?RMqV2yzOyfby0bNURGwSTpjo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6536cf6c-51f1-4429-7c63-08d90439e6c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 20:21:38.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdQmm6Cq/HC1IjEFj1Y3RcWugesvaIqhS3OcAp8oO/P80XiPmIqLNSANIwx5oRhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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

Sometimes IH do not setup ring wptr overflow flag after wptr exceed
rptr. As a workaround, if IH rptr equals to wptr, ring is empty,
return true to indicate IH ring checkpoint is processed, IH ring drain
is finished.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index faaa6aa2faaf..a36e191cf086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -175,7 +175,9 @@ static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
 		cur_rptr += ih->ptr_mask + 1;
 	*prev_rptr = cur_rptr;
 
-	return cur_rptr >= checkpoint_wptr;
+	/* check ring is empty to workaround missing wptr overflow flag */
+	return cur_rptr >= checkpoint_wptr ||
+	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
