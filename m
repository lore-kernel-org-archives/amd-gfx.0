Return-Path: <SRS0=TlT6=JP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B7CC433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Apr 2021 17:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AAF6109F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Apr 2021 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AAF6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B7E89E5A;
	Sun, 18 Apr 2021 17:35:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F171589E5A
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Apr 2021 17:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZV7VUAalgLy6zCRQRD3+U/TnYnwGcrIs0OEYoe0zvcwfhS2Ve0L9xySV8X+ZO7UUHmAymGuAW2ZcCNY1FF66HaWu+e69lI1X7HlfwQdAY6RGtuuBJUcYevJ97BjDfBmGQVUC2OSvAtIxFJw8YXLTiD9eCfXZh4E7SyPU3hkwgD30oNW9Brvi++Ged3gtRYRHs2F6kPbt7AaU0qXQWP9LzkZJuXe2ndW85t6rQibqnfrJTwSwQOAz1IO/ek89m4frASK145D67Si1H3pN4oZ5i3D5HNLYg2GtDXyAJPqGrmS/mrXJWTb7r+vjO/zIhK+F+tofIhULb6ZECaoY1Grzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd8k7Jwoi31bkoD4YeG2MAx2O4xAlO4iV1KuQamX2oo=;
 b=gGqPuIf3Oi0IRXLlNT+ngdRgjPxEORigik2VuRZwx57TB4RJHFH9eB9Z1r6DcBRguyL6DVCAwQnUMZNpkE19SiAcOMf5lgdwt8ml5CYvl5VqdPavAKo5bZwQP3gYdAAieQYUFP+9adtsE2QhtlZtc30NqmkeRI5LUqTK+HndOkQUYgqOuPpSGnjbJU8kN5IXhXPlHWYqMluC2rppnaNCWtErFNcRSLWiOhmPaBny7Brs+xyoxQO4gd8+7v6pbi5Z88Z/x+d5ex0Sl3kULdNJinWCDUhrIzNbDLzijJomxye1lYaHFHcUU7LYbWw9dz5dMEDkdAJkpkgoZPQsN6dI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd8k7Jwoi31bkoD4YeG2MAx2O4xAlO4iV1KuQamX2oo=;
 b=JQpOJVCv36Or8Dwjnn8xGJHKCYn4XIFbu6aBt5vV+yIjr7uOpLz+1uBxYvlSCgsBrLLZ5gVGnnSet7uuYAi8Bm6ga0TFum0U1fsv+xVrbrE9Rh07wqCtQCuA81eL4HTrppviNfExh7IkAFA1b4qxzTmIAvuKwkSSlgkX3zw0GmM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Sun, 18 Apr 2021 17:35:54 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 17:35:54 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: return IH ring drain finished if ring is empty
Date: Sun, 18 Apr 2021 13:35:35 -0400
Message-Id: <20210418173536.5155-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Sun, 18 Apr 2021 17:35:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd34168-ac9d-4898-3ad7-08d902906ad2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01087880BF78535CF7C2E98AE64A9@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDGbh5cdUG4CCkNLzeLPf6232GoB4vKhUvKfL4KpyYVo9lXBClen22j2EYaHaQTqf1ePcv2lWZobg5dW6PWSVposH2saf0D6JLCoeVdNnn7mFO0VKCR6sJy309S5SNoXMzNurpQjs6bBy/XLjw9e+1XmK9pgv3mNVFBzC7kQhb6GVRLM0p/PrURdn9LGxQdKKGe10/ay3MtUQ6ejDFcT1pBDibACNMKyVMJcckbhHRCBXvqTuq6l87omJoVTvBQuQCvTpb3g7p4g2mlh1yHq+GYKPpKz/dWVpE6sGIWgiQS15b+7elV+fCZSwoXX1XKmh3jNGRo5sqBeTm9c0UoKeAVoHhJUqZ9Wex4+nrT0UNrKubyj4apOrex52JDHRaPJaKZ9nfEJ8DLYwLdLzuKWszwpF1NWLs474evmO3K/5YKFnR4bGs1/1zXYJr1Sgq408gWJj6hURKN+sIn0fgIj3111MMM65azIO6Q7Mg0Szc+j1BT3laAk8EmzL61eXwTV1fcKWAO09tfcIZuLKgFK18+7q9yXBLofnymMNiLn8wijufEpkqQriK9zHaucT26CcT8006mNe29gmcc9veM882QDvZaWIxq7lspCGvftuqVNPf+8HfawWTsoznGmS/BGYNKFUWFdk8BvQcJyeadM8JvrWIUVyQZoNnZ5nUr9ZK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66476007)(66556008)(66946007)(86362001)(52116002)(7696005)(316002)(83380400001)(4744005)(1076003)(5660300002)(2616005)(36756003)(16526019)(186003)(8676002)(6666004)(6486002)(38100700002)(26005)(38350700002)(956004)(6916009)(4326008)(8936002)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Sr+n6OjDWNAByN9qmtikd1n5rLCgBi4MvfDzwhmnuf639IWc/9nuB0SXj+yY?=
 =?us-ascii?Q?cZO1ls64qNGhtNsjdUCa9HnMyIO5jxThrYo6ajYfeMSg8fTf6/NfzbsW0rpx?=
 =?us-ascii?Q?S5/Qbh216lULo+joZ9rJWDmogg8HVHi5Y6OzVOZvi3LDESjS3IHJwVSFJ34M?=
 =?us-ascii?Q?YSP0QzrrHsxrs+qAKjrjWaSqRa8suy8lyb8cjsnsMupeLgMamTLTLpGIJb+8?=
 =?us-ascii?Q?VmNtEPYs8bMJdTauacfTM0TYL6HjZ6viPKcGYx+MqFN6yqUkq+2uBINj7tWU?=
 =?us-ascii?Q?PMLKw5YAGxlSbiNyu7bilSPCmYyhLtx1soR9tllvP6NDmaO+6Gn9R4iHBitc?=
 =?us-ascii?Q?lwmOoGOzoiTc8tvz7KFzkezCLgT+bkwG+pl03tc7A9PVZULCEvEinBG63H2D?=
 =?us-ascii?Q?U1hnutz2aTmiQhDtEAmGGtkChJrblwWTX5CNmLwq6KkSw7a1VSjkeQ2RoW1F?=
 =?us-ascii?Q?8ZDcW7/8BAr9VIH+psgp4VFbokhfNmh9kk6UyNXrU4U/VITnvTvCqkUTpkOc?=
 =?us-ascii?Q?0+m4nj5bgs0cr/6XJgKGBEmlV8ZXH3IvGrjd+p/+OYlnyorZ+YRJtUbq2u5R?=
 =?us-ascii?Q?3e/0At7ZwOY7+p8RerM0WWMvT1NQP/gsYa4SRVitTZWEzoy1yytsGYTGUtjR?=
 =?us-ascii?Q?rldbxZW7u91rQTZMs8pPcaNWn16tE8iAYs7J77dBOpAyZE4HbTMO27kZ0WRG?=
 =?us-ascii?Q?yBOqvTnfTZkT7V/KTACpIkfGcorV+Hdog3TjU0VAlSBmMonWjc55ZCs/Gh+w?=
 =?us-ascii?Q?qEv+Zo7/r/B6jLrvj2elx5KVhSsNaSPLNdWbgZawQhufO0Iue3teijU26AOs?=
 =?us-ascii?Q?SFWKJxs+mqU1Cb76lR9w4t240eTexl8EXrmvpXLA6Dzk5/J0613r7ERmiPAS?=
 =?us-ascii?Q?1r1IX/6x5p38qNx8irxu3wOrNJ8GVXIdwZfOPxRGBmPX+ztJyZulaYuiNDFC?=
 =?us-ascii?Q?ZsGvrO+CHyxKS/w+xNYTanqjs9LWlAlKft7cNIXMUybyYMbSiFO/IiOk+9Qo?=
 =?us-ascii?Q?iAr8Rdnnw+CHhSD5KzduurW+QYaAT+CvHHQDgxlzIJWJEuWIxROoTP5PeyYZ?=
 =?us-ascii?Q?2kvzIbZ7zcTZD4vf7r0x3JbEj86Dj4RJuc1qQK7BVivPU1I0poQ9pFZIir/v?=
 =?us-ascii?Q?/FkZ9tToWm5ZM64P8m4TmnSDWxowRrxAW0tnLxwf2MdJbrX9Sc+pVOU+D2dx?=
 =?us-ascii?Q?cR4Uu4aJNCFUJme51TjySx17cAo4I5qLWT107E2pIdwrN6JmczFlDbP0xwxR?=
 =?us-ascii?Q?aMzV45jEAuqPQPVCV5BJloJrg/QyhRnjjehXbc+/QyA/Pv022NuGujfbic3u?=
 =?us-ascii?Q?i4Vumd47xE7lhgLNawQMqnC2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd34168-ac9d-4898-3ad7-08d902906ad2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2021 17:35:54.2183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAEqv5XGH+Vig2D8PdaHb4W3SKYAQcVhjSZhhMHeQWa5d6pi8e48p/NnQV8xX7Iv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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
