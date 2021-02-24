Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A8864F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A8864F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9366EB37;
	Wed, 24 Feb 2021 22:19:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C25F6EB2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkLg+Q72m8XXqlBRb3Coh7Qa/Lf9p7bahoNrllgRKvGo5Fext+NK8/CNTEc9+UnEYTqtliJjD95PE6u9T/0sE//ZgOMxsbYX+GHVOeMiIJZeXcaHCrZgBKJXaoUUF8njs92XgD2PqhbDnqT9ZbopJS4caDRBnA2+JlHiqIAEHtxyMoxHBfIT+k9jm0TzqnLMtI6PsKa30fi4NYK+id7p5RHEKcJ9+VmIpQA7zKZ10z0AAKtxpLkizLjUkrxEDEta4qQpW0Y+4ow85WKLPiocfDUQ292d0Xqu+dUGzGdYcKx8iagiPDIAPob6ZToqwnef2KsUWBa9Nk1OcBtF9v8/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0OPvhYaLAg6Wfw+G5r/OLtB2uaiuuu8jCCqRdVfCc=;
 b=SUgf8Ehz+c2pviboBDy3wIbhTMfv4ShDkfzDC7UVSHeondwFIQhPKS++vWfyviVgYiF1nmtREKFyDH7pSJsDHjzbzP6NShj2/ugNvBux2j5Hi93wetluJZmkQWdyOIyX7IxYmJd0kuuomu7rXJ6aNYN6lIP0LCNDV6gdXLETmzRfN/FtWpbPpKiOsnwdBGJzN3MHCuL0A26t1frLglIluzXhYzB4Hg+LaRNQI7GnkOCtwiqyL7UVN2g8bzhQOYXQg7eADErH9RSXT15snpYm0Twv1Hx525JLm3NpnXAYhboga+zaQxdJvXYM41ntXnX0mGsIWpEYNVN3Ttnmfl3TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0OPvhYaLAg6Wfw+G5r/OLtB2uaiuuu8jCCqRdVfCc=;
 b=WCPlqwucyzFGMj+u9RLlY/ZIbicpvrux6Ji8luCbO16npNNtAOppMIJPszesgPhlZcjjRoqvdHLN35uwhg7bRkMjFjaXk4rN1E/QRP5ixwS/uALLxTLuOCuz+TRs4oX3RkgYP29G/g6UjCQIoEC1aAXjOjZYNXZ++voEIFXElak=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:41 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 032/159] drm/amdgpu: load pmfw prior to other non-psp fw for
 aldebaran
Date: Wed, 24 Feb 2021 17:16:52 -0500
Message-Id: <20210224221859.3068810-25-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24e676ea-6e3f-461b-a752-08d8d91247ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175D96636E395DCE111942AF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gq8x+pHbfv6EHF7PMKqO8fke3uyRuCJHn2/D6IC735ZmqiNKNvqmgByBNzAMgvgXd2u2L8sADaBuanllWJ2P7ZD4CiqBVwGgKrqs6LesVphWVoXzPpdL8jKciyq0QxaWnw6GZg3zxXo6sB89eGL5AJF11v4AatGwCtqSeINleY5PSoTVp0hIU82gk8d6AbI96xzVixEx+bNAy5wpJvELciQErdwaZImzcH70YX1jeyW6f4+vKE4jgQNZZV2h7CyS5VncwjKqDDeG2X1LmrKMTlMQdxibiOKFOGEIOiA/i5EiT4Z0dGv5iDoden+jqv6RdW/12tHc3mdtf0b7ciSd+1Tf52/LARp//jgd8nB9hOCE5Rx4NBN5R34DkdFtWzXfPAyq5WiMqDcAifn4RDp64sm/ovMO081DX1+ZLU0ls//yQ3P/mybEthJHvH2HvlDm3MSXWRc9ADhhmgJUsmCnL5QQZ00ZgCMOV4adr3//K6SsOicyOGTr7+8CJ1o5j0NekRDYiWqahSoy7evwjMEIFFt6fKJxJbyLE9yv7mw1OSpdnt4GGrSHYsjyANn6ecZD9rqHzN43M4zGMrBoVJ2Ngg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eEyZYEdx/fEcKFdTEVkXc1D2Mvm1S9XiYSh1XZs1UkwK4d6AuoETYgVYlegN?=
 =?us-ascii?Q?LfI572FCAf2Qfi2T6fsnroWXJnpM3UiWYg7lKrVIczvSIuzOMkgoV4YH89qs?=
 =?us-ascii?Q?QOe1oSGuv+3xVi/FJPo/GtXuk7ShaSWcFuDXfjJ4HF5EDmwA9SVAt9XS7VQr?=
 =?us-ascii?Q?XRRxV8rwqMs4MZMMP/GZt+BFf0EZDEXMUGgg9gGELJ2A1qn3xEem20U84eCq?=
 =?us-ascii?Q?oggjfw0O/vHj9kgA6vjhrx70P86fNg1aOZALS3Xl/+pcM044Tt6GNfSJu4oQ?=
 =?us-ascii?Q?g5DBCRfP/9DQY9PtvPaozgzLX54aHXESLyNyBqdzL8f8TUJPbrWrYb/8vPjj?=
 =?us-ascii?Q?fz64GEc9lLmnq96/Zb5ZV4iGahXeynzvC0j5ZOwW1zCnZIPZF++Cg+GMC6Yb?=
 =?us-ascii?Q?0NR89S6FfOwY+TlW1PPIR2IV6EyiIJPHr0qhUdF030QyzbC6fOj0W+Tn4rYr?=
 =?us-ascii?Q?vBNqnDDFUeHymZbf9XhUkheklTGsjVWuKMI+7G+yQ/b7nFIC9hu/u03nZvTO?=
 =?us-ascii?Q?UYzxfL0Vdwdv94NB8U5x4FNbJUnP0+majTuTqgdakaobz3EMSamS3JLiISTa?=
 =?us-ascii?Q?ILTmkXQ9HuiBBlhDdbaJFsVhoE2Be0u794jlClp83WB2z5aYRklqS51260kL?=
 =?us-ascii?Q?wNf0s622AsWoEP7gN0ZNiS6GB9EgIm7MmZ6laOs64ruRpR2hmk4JGIVBjoat?=
 =?us-ascii?Q?95ifawvi3qKyL1eghXTEyib4QjaNHkZxTpGytaBzRtPMZd2+yu+SKCg6fU94?=
 =?us-ascii?Q?cNSj5DOh1oxrT3LgVD46xR6b1fw+H9VApNvVMEIyxVXl3dwsu7GE4oys6tg0?=
 =?us-ascii?Q?4NGFDJJH913JYrw6CIsO9PnOU6GYP9wo57l1gpgF29xjUuo7E4w5fNsDlY6T?=
 =?us-ascii?Q?pA3ciHO4p1Dhv6gHzfpL8UCZEmzYM/VTABki2irSBjIP9s3lsTf20iL8VLAo?=
 =?us-ascii?Q?cnC8g1ktufX+d1mdhyl53rZRoB3fYuGeFsXlA1ZVKhPKX7gmvqNjMvlS0NFq?=
 =?us-ascii?Q?ySDucRcD5pjLK2sc/X3yKHxNnOo9DNYZ4rkLRdzVxAnDpqIi3UbvBWZkv9Pj?=
 =?us-ascii?Q?7uUelsk2c+szSZP/JAbX7qir+zKjzoy0+XUrA4snIRAGKGv6+N9AMzRCsSE2?=
 =?us-ascii?Q?BsqjC33LXtjTGp9+ZDxggIxCof9JxbDNf4sOuKqlwko6/u8KMAuKVFPu5jCU?=
 =?us-ascii?Q?TD0r+CPa8btnOjWfoTnE1kt2BQU3EzDPdzt8Xx/2QDCAOm2vIQ/HV+ba7eTH?=
 =?us-ascii?Q?p58K7l8y8MlS3qtCFvwRliUaaahSYQ38y2GQkU5vwdQPwaU2MrG1ih4SE0+8?=
 =?us-ascii?Q?mMhP4WWNdCQwArNi6FZn1k/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e676ea-6e3f-461b-a752-08d8d91247ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:41.4889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRqWqjZ5dDr5vyX37W6wjjl7VE+gu/HQbK1sKUVIoOf12MFmjAne4IKMMA30rMyJOKbaUwqa4EMfDElxTr0e+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

PMFW should be loaded before any operation that
may toggling DF-Cstate. otherwsie, tOS has no
choice but to locally toggle DF Cstate (i.e.
disable DF-Cstate even it already enabled by VBIOS)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 88518897c17c..a5f79b09de9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -72,7 +72,8 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 	if (adev->flags & AMD_IS_APU)
 		return;
 
-	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	if ((adev->asic_type == CHIP_ARCTURUS)	||
+	    (adev->asic_type == CHIP_ALDEBARAN)	||
 	    (adev->asic_type >= CHIP_NAVI12))
 		psp->pmfw_centralized_cstate_management = true;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
