Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F83C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6377920768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qe6wP+mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6377920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DC76EC04;
	Fri, 14 Aug 2020 19:14:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981B56EC04
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 19:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/mT1HX39QXvyiyjcKPlM9kd1JA9UmgCeHolsgn32B5oMnFDmNysfulcST1LFBRbQh6fh6xON/Jafok426wibmLqbyKkWJRpyYv48GgL4m+o+Tad0XB162EoC80WVjviF/gYCDh+kC5wvgVbyWIpC80IRBuOiGRQ4KlAo5e+iz9ZSv0W0v+rx2AcV/Fygd3XVEukcfLzZyfy8RriHi53EHw1+SEavugF6TVa9s0RhokdE3NVNKOU5Ju5qSaKjYhx/5sO7PgcloLfhvk4vhcd47q/KlZYLqMeDSvgu+sEzbLlwMnoXDu5GZKMfrBFFN2gQMNsfDflbtWdQnqWTfyKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9rjje+XYOzPI0reViToH+8oYzPEzdkj+KxaqmujeeM=;
 b=VXM0H9xGhWvdls//pHPENh0+OPprlObAtJvCfwQ+EtW4nuk6qfqPqwsY9h1SsYgpOTteg1fVK7Z9NZqBs2Oh8JW6aYTW/hsqRFp1BZ9BRCmzHdFkzlAePWsUHg+78GPxPEVtRXO7WABKt3/I5lQORNo4Iomc6b9zgVgaDs6eetzGNTgzpF2JX1EFYVK47bBnEeJerj5/7C4QEIoi7SwZ0qxBWLarZ0vJkyukzmlWx1DvWxy3Nr0IGSBo9Ysu0DvnC4YGcHV62uvb0+fj/Qvo6cHx/z8paos8rbR9F9GorLi4mu+uEUjbWaFgv0aCho08yoRyFAvWVcQYnaoRBiPteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9rjje+XYOzPI0reViToH+8oYzPEzdkj+KxaqmujeeM=;
 b=Qe6wP+mmvR9W7NdQSZZxAmAxQRz7GUq4Bd1tvAvL5GPDbks1dScZ3qfNc7/uKqDBEfFQ/UStr3eBG7bbQSvleKMoiVHoGDI7CiJe0NNwPDgFVFR8jcA1zPMlYTga9IP9yuEtaY7eG29SvuH//Dk1dMQ8IM/HWWO664N+hcMahq8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 19:14:22 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:14:22 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Fixes to drm_sched_priority
Date: Fri, 14 Aug 2020 15:13:59 -0400
Message-Id: <20200814191401.25606-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:14:22 +0000
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84f2bef7-846e-4872-9225-08d840864089
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217598A1BB7D0F99590E8EA99400@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXj7uRvHEdK6On7veoNcNdxyu1uY6Gxe5quBtExNky1y5hqcd/h9DPtsyKYrD3XgFejuqASiaIUvwRnDHMfSPaUQYCVdbKHGbf3TnF8QeAGhntJFZrGtrzdkjZmONm5cSAGt2RO9iZ83JQH78EeKFBqvOaE/Y0gRIwIqu71C4SvIqe21uXuyn3N9lL3pgvW0moHD6rtTLJoVhDfclhXKoYcwEZsD9UtuNmnBBtCt63aer/PBnMa0y6JFf/ZwUmB5Ng1cvFi02UBsa9pyQs+sw5w9verj4tsnL6vPy+0SIJpgYwzejIiLgnRwD698+FHFAvTdfTMKsJYzuvAPXkAUCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6486002)(4326008)(7696005)(86362001)(36756003)(186003)(52116002)(956004)(16526019)(2616005)(1076003)(44832011)(26005)(66946007)(5660300002)(8676002)(8936002)(2906002)(83380400001)(316002)(478600001)(66556008)(6666004)(6916009)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wxguchcRQkrH6tE8r+wxxQit3knJTto3V4HPbZwagNogvLTZ8UrMdy6cBgZqIamPebtoL88n/llS5jeWep+2B5Pc6nkHHGq0clruiiBIsHxMI1WJvvpG30t2fivz89f5PyrtiuQU8qwbty+W3H+BLKZXSpR4cJoe/vOafIqISv7bzsQY5lzfKD0eUw2ILWBFOb3vpF/2TvFxosB8Kyd5INep4BVOQWu2NOEH63SHFHpp2IJF8wpXeEwFQZ5XEBv8WL+oJZdJvXpIyGN2jJC9b6FnTJQ3R/mDmcwV2RP3A/GDOiIoHjaS2WqTTAmWNqLwoUFoOWHn26MsaBTwJihEBkwT/MI8SXJPyjxJ8HYfH1T6PswVxi3gXFGRdWn5a7oX5mo3E4i2A17H3U3SCEWFIL6LMxpRD6hIh605rO1U+kR8yay0T7E8wEJZ+fZf9XfiTs0JzRaydiwNZTGGgUDuFvP5ykolImiV7CFvEB7vuwfYbM1aWTwGq8yl+u1yDN0Oq2yVrz3llwIJoHZuL/z9t9nHbCZwNOoTRla8IAyQVEoZsSBxKSNucXDbqAyVAYoYuEvz+zphU3bEdvmaetzeWOrk1p5YM2rTCAhDymPbsh6MlN54ljibqEpgXxFq4YV2ojWqw3Gxjhv99oJBZ+NVrw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f2bef7-846e-4872-9225-08d840864089
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:14:22.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63rHyB3aoU/atKva21BLuujCXPcdWR3ZRW3/pJ1PlYInhhlFTQlXyyJfANI3s92I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some fixes to enum drm_sched_priority which I'd wanted to do
since last year.

For instance, renaming MAX to COUNT, as usually a maximum value
is a value which is part of the set of values, (e.g. a maxima of
a function), and thus assignable, whereby a count is the size of
a set (the enumeration in this case). It also makes it clearer
when used to define size of arrays.

Removing some redundant naming and perhaps better naming could be
had for PRIORITY_SW and PRIORITY_HW, maybe "moderate" and
"temperate" respectively. However, I've left them as "sw" and
"hw".

Also remove a macro which was used in only a single place.

In the second patch, remove priority INVALID, since it is not a
priority, e.g. a scheduler cannot be assigned and run at priority
"invalid". It seems to be more of a directive, a status, of user
input, and as such has no place in the enumeration of priority
levels.

Something else I'd like to do, is to eliminate priority
enumeration "UNSET", since it is not really a priority level,
but  a directive, instructing the code to "reset the priority
of a context to the initial priority".

At the moment, this functionality is overloaded to this priority
value, and it should be an IOCTL op, as opposed to a priority value.

Tested on my desktop system, which is running a kernel with
this patch applied.

Luben Tuikov (2):
  drm/scheduler: Scheduler priority fixes
  drm/scheduler: Remove priority macro INVALID

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 27 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 62 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c    |  8 +--
 include/drm/gpu_scheduler.h               | 16 +++---
 9 files changed, 73 insertions(+), 51 deletions(-)

-- 
2.28.0.215.g878e727637

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
