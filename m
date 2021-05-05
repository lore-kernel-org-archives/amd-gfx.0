Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E9C43460
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1242E613C3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1242E613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BF86EC31;
	Wed,  5 May 2021 17:56:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105366EC31
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 17:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kobYmsKaMCjYyDRFu3unnhxKJxTgdijqlpMi97c6X4QZq0Lr7Z+KghvZYmnPcWDDDntaqjBGBSjdH/zS7CbL+v3u6O3mgcfIXSkBFx08EAhgC8CWpLppOr/Zg8i/ZgrIesT+U+L3DeDpUhkn28CtAb081pMHDibs3yHbExWgned/YqIvZwnTH2qewlsyQ76oMCZEIa7x0woBqjTU7ZgjRvDKYAlK3nWu2B2zpwKtyKnHeX2upyrsC7ZBpT5uCLrSDGto6HtE/RfT0RWdaEJlNmHu6p56tYjICPsUwq7YeCtEA8RZL41yQIsf/SdIulFLQvQdAr7pN+0Sb9UIwKs+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxKrvUiMGVxTVTMvN073X4MQBxEudH9fcytosn+3ytc=;
 b=i3wVr9J8++dpP/IdfqhoDfUXLq3ZamcqgYa/cECAPjYgHss8JP89GHO7bWH7tunLNSZcbeSxc5J4Txvr9ldGXaZ4rivIFOwnPyccjk+vq8uvn0NJ0IfKzg0q3nCBvBIRaFn1/i1+VZPN0ylUnmzpjMb1lOKG3VdF8DZz9AVsv/ApYGHG8xotP0B9TcL3zi8E+kIImLCa0jRZOg3VOBeX3Nx9wDYwg9HsHZCZKFNlcbtwNVBOHpEAeq8nT9BBXLl3J27X47L8VSPqbnlciCINCkqLAHP+E/LCmjmeck1jvbcYRet4olJ+8VcV6GurmNP6Ft1k369gaQG7RjjI3NQJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxKrvUiMGVxTVTMvN073X4MQBxEudH9fcytosn+3ytc=;
 b=nKEuiqUvbaVWiTEKvuGi23woObhl3BVzLJdhUsLWTkWknCSpgZz87bB1Se63+wwB27cu5OEEnulRAeddif37W8vk5dE1DUvplFfM9OUOJEzqxliQr5lho8OgaO1nJ7N7nIYpmtXH6SjZFb1JeAxAKVzc4cF4OvIj7Kr7Y6vvnoc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Wed, 5 May 2021 17:56:35 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 17:56:35 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: set new unregistered range accessible by GPU
Date: Wed,  5 May 2021 13:56:17 -0400
Message-Id: <20210505175617.30404-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505175617.30404-1-Philip.Yang@amd.com>
References: <20210505175617.30404-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Wed, 5 May 2021 17:56:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf83d705-f021-4fa9-b9ab-08d90fef1fc5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210413EC14B24E4F58D4DF9E6599@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++wAD9aIQIrRyr59cy3ZMV1c63RlPtckz/IddQtgo8onF1DsvN8yUG1sipxfyFyGF7eq/rYZ4EIP32VB1vWOr5tc7R4PsXKV/r+O5K9pmSJTJGWcPaaz/JRJbkMsD25wtbxRIpfDIGyj6RmJGqiv5GQ85jkuIG5aNZPGIxlU/2VUhZTqHo6xz3qgDDQnCQKSQCjGN3t9yK0g/Lk/6WT6zuOWY7ejVEl8v88Y0sX5CWImImXyIG/CGPSC7JsZVNwisU1nji/fTkBsrWFx04vyeBLjfuSbAnO4WpwyCHyuW4AnsD/I7SI7RfEntE90olYX6hUJLwTSqI4JYfKHyc8c31D/dXnRKgpZeh5NnOxvMqx2SngbSjX+gQMWrjXuVeliXnDj5R4NGHauBGpRFliOrnmyqmb6W/mWLdNJJtdKGN10LU7rxJX/e/1OCbZ5AJvX6ke7lj5e/peCLQ3AVp/4zsbEEGRmm6T47fWiIPyFd8N8BNFlD7uzB3APheVAPS/k35Xa9NeGxyFEAmNBhSA/C/s2jQBjceot1ZnNHdD0NHZiNCGnQDLS/SYIuSmRFj0m/LhuvSV7Qm4pLTbQTw0QKH40nfW41O/1hswZxqDVAL6VvBO9qbTxoBwJ6/HXnpta+FovydatmuBRVWTrsONCAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(4326008)(83380400001)(52116002)(7696005)(8936002)(86362001)(8676002)(2906002)(66946007)(36756003)(38100700002)(478600001)(6486002)(2616005)(26005)(6916009)(316002)(186003)(66476007)(66556008)(1076003)(956004)(38350700002)(16526019)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DiL7oG9DXX9n++PN237cyUOIjVRiwllRC71CHjSyLgxz72kcb8KUx+dQx78I?=
 =?us-ascii?Q?NFHbJKNlbCMyNkDxBK/EOVH3+93CuZhcdiwkzVqB1rMG18hHBXutIqwfL83h?=
 =?us-ascii?Q?HvOi/BGU2qeDba00J82yYqmczxeR1FcLn4xUhI+28Zn0V25gZ2y6WCn4LdLC?=
 =?us-ascii?Q?l4xC9Id2VwhUVSnc3VcSW/hZf6wZ1hwLM7i6Jvfn4EQEFH5im6oIfNfjepPm?=
 =?us-ascii?Q?ktUOstGyOs9WnAdAw2BjJkRBFcB1s7IWea3b+ryHUOkfXf2iB4eNFC0/wy2g?=
 =?us-ascii?Q?A39WzZILw+MeGnj26qyFAw9B2b2jDq0Jy2tzeyxuKbnX7yZ8IfGoXKC+l0V8?=
 =?us-ascii?Q?j/J5JvlGb5Hc4/hmE9rEirx+AxBOmDJSVxYNO9wApSnAqY1RucjGtC40OVvN?=
 =?us-ascii?Q?S144z52cZ+3kom4ptD6fYLHUkvuD6ZCvUvB4t1krrenFBXY+QRcdBU7nm+kR?=
 =?us-ascii?Q?i+0WHBfhrKaNS4Q4d1x+qZQNqCqpvr6/2D8P6MXwX5b37WcWL06bKZnhD1OO?=
 =?us-ascii?Q?M122oT1N1Gk1RDt72Qh/z3l1qlPwGXE+DXVNxxcKCrZV8O7bdMvgTwDxx3tF?=
 =?us-ascii?Q?zp16VoxP+5ZoRq5Bz9G5YX758lKNy/Jss08YmnsJxvewU0+wLF4UvrKH25hI?=
 =?us-ascii?Q?NTh+QWXZlJlhVAuKkwyFvNTRxRXcZqT2T44BbhoXq1qFaXSKzllqdCvuae4T?=
 =?us-ascii?Q?Dx1nC9SdxQPrRa+9CcRQinjIPofJGuYCNcsO3ZTWY4rQOTVUS7exmJ/RZhrg?=
 =?us-ascii?Q?z1RN7pxM2mR+oz/CfsCee7FfvdOEGV6kvnrHiWlRk9bjeE1WMyutHxxCEubx?=
 =?us-ascii?Q?o37HIie7KbazPtsGgH1GuWzULEY045Ftz3IK4y4u4qg/cnmZAWdBV31fxyrV?=
 =?us-ascii?Q?YssskxHMpyu4XC2rCdcPDi8vOVNxqEhkE0/Pe1g4uL6h+b4mhRAmJsBTAM0P?=
 =?us-ascii?Q?1kuF0zptaSOcWarYHX6DR+BLyFSwWsEwMLmxUO6dqv3LwpLk0E3lxOFwxDrE?=
 =?us-ascii?Q?FJLt73m5wdy9tyJh3k6o7gNK+pgNvYtFqWurd1JvCVK9VsyqFcm0VSsdI/zO?=
 =?us-ascii?Q?aO/Vuj4j5xYWX80OmbN7F2uZGYSb6ONj9SW43ZWxMuFLAQ1daCqblpadsHCw?=
 =?us-ascii?Q?ncLdC/nDNM4RAUyrkjuRlrbleLS3ZvmodId6lsO4/ormhHN40v2ZpFEcEGT0?=
 =?us-ascii?Q?IY5anNv1zdEQp7S6gvA++cFE95cN80FZ50J1g4ZV3N2XtZ2SXipC3NcEOInh?=
 =?us-ascii?Q?pVfvfimo7s013SczHm3+Kithloak29GdQb3OXr4cij3mdbS1dIoj8YjK3UgG?=
 =?us-ascii?Q?Wf3Mth3vl5mTnDpULZ0tdiaX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf83d705-f021-4fa9-b9ab-08d90fef1fc5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:56:35.5657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4HHGi2VYqPMhSrs6KYaW2FIYvb8tZCnpNM2mcn5TvqwvSG3v4GliPJIi5iyMg3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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

GPU retry vm fault on unregistered address, new range is created to
recover the retry vm fault. Instead of setting new range perferred_loc
to GPU, add GPU to new range access_bitmap, to be able to update GPU
page table after new range migrate to VRAM. The new range preferred_loc
is default value KFD_IOCTL_SVM_LOCATION_UNDEFINED.

Correct one typo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3b640772d9c5..5a486e0fbf18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2243,7 +2243,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
-		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
+		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
@@ -2251,9 +2251,8 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		svm_range_free(prange);
 		return NULL;
 	}
-	prange->preferred_loc = gpuid;
-	prange->actual_loc = 0;
-	/* Gurantee prange is migrate it */
+
+	bitmap_set(prange->bitmap_access, gpuidx, 1);
 	svm_range_add_to_svms(prange);
 	svm_range_add_notifier_locked(mm, prange);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
