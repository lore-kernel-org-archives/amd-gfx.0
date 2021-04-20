Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3230A613C4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3230A613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AB16E8CD;
	Tue, 20 Apr 2021 20:21:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF656E8CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqSZMxzi1kt+3rt8PMDzvLvm+BDW/I1W2P0xOimPcZ0xa4Sxug/XMd1D7M2wqx3rdgLKyBiBOcKA/HLskupursgcEDLXqzHMo7VNaQpposBSREOpjWnkjU0smP5DJWBykCWwP6/wioc/lDcHRjfoCHbYtFKrfl253oLKFwefYCQpfYqgHodVN/WbyVtzehPuSWqKa3AdQMUeto3Wxu5UMsCwZtFLHFHGVS3wJiHsrcZeSWO+baOlBhR4YpiQwvBQwager9YDFycBuiRI7x62O6Nu3W7ohSRMqdx1l3ll10wmiwSOWc3UnBNU6M0AFJJS8qrshpVbyAe4gH+mSVLdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjRkGWAach51kqjY33GduhVNp25jMGTt5XHzsuLjjb0=;
 b=FSk4gdpohg6aHdS7VHcvD+3RlgaCTfEfOxcq1xzn5VGeqK/r2IUzZOD7/AgvQZFJ4/toWmDQV/nzwG7aFU+FFeY43X10QJlVAi5Fy8HMvW8GNUHJ7xkHPTHtytz4DD8fFmXFZDPnaaQEnx67UWLBG787cw1Vp1GEV90B2DZjywFUh5PrUTYEhfyZ9XyBT4bPQ5SGX2hksPf1K4ILtEdK0fxz2Hd1UrTSjYXMaOx16OZ6tIRXVEi61la/Vs6oEkUwEg8Ju5OGy3trxdLJuskeE61nOCnd3QRh24OTRGV4OqaH3d6N1FWdo2SlRySPifFr37iao7OPhybbQkLEC0Neew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjRkGWAach51kqjY33GduhVNp25jMGTt5XHzsuLjjb0=;
 b=GSJtg9z5HsKN2qdEvcAFuCDwEKGuEt/rpmxNzpnv+wVNiQwUskiPYOLiWl0njL0nRuAeeA1Fq/iv0vs52YDpt9u1XFcZ15SOi9fL6pPNFdaMbKkIscHIyi5lrbrLr10C5Pjosoh4UpkLJ25xRFunuy90HtmZTwu06GROyFUdZ2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 20:21:43 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:21:43 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdkfd: enable subsequent retry fault
Date: Tue, 20 Apr 2021 16:21:22 -0400
Message-Id: <20210420202122.4701-5-Philip.Yang@amd.com>
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
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 20:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca7d108-f272-4235-3e6d-08d90439e9ab
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24887AFFE7AF6724930E3E4DE6489@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3YnJ4lq8QXxdnNpllIqsDh5CX+/8FN6Ssry+maFQyOJ0h3eBoAApx4Jg7yDovFXCu+I0o+k3/AZuJqgvsgjLFihsvoU92LKh+ZQa9S+xvLMt6zPHoXGzQaImmN/440N2wnXyoo1GOqpVW/3dZJ21hz+Ajgyxxygs9/CrDoxi857NWgxvf6lbJn3gEDHSLt1bVcJqnC3EWQcWDa6GDjhqDU51RPJkTqbzo5sHVYfn/9UqpAl7wraNiqPOjqmFK/dk4YRJKhaEzPJZ2QUUswCNTIGhSi3Bxluirryl607/v7TtnASXMznKzs3v0QTBrwJ6QnY6tTL3Z/J4oHrN7GkXtyFoRoE86f3A3S7J5WgiZX1ZoVBre7r6AamRZhLKUfhVs46uEilibcK3BU/cphnHUOoDb6ug9lx06fRgKzdhU0ZH+FgmAdjiKuGehDyaqnh7Z4R5FwfhW+PLAbabwY+doSrT06gsnHBx3XCXGTRqmf+HQe6uPIyLy3KyRsTP09V3xevi+NHJp0QbuIIC/PltRXim/AZ8vKvlHrdVsfVQFZQiAMD87fwioIoUjo0RDNqJYfsElBSIlja0+YQULg1vNRZd/Ei/2vImoQmdEYAVM1giLkwCT4pXkyc4LUKpLU8+2H1c/LlySEODjIW9sK2+9NF7ZOKStB/97GA/97IQwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700002)(83380400001)(52116002)(66556008)(38350700002)(1076003)(2616005)(956004)(316002)(2906002)(6486002)(6916009)(36756003)(5660300002)(16526019)(7696005)(8676002)(6666004)(26005)(186003)(478600001)(66476007)(8936002)(4326008)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UZ8FTXFeEVNEXy2WEahSZ43+uUngVWzVVErTb5I1odFMTOiepuL9hIH+VL5C?=
 =?us-ascii?Q?tM+G73M228aTUQDWnZv8rTZ8+vyeElaGRHz2iTbBAD6xX8asM15LUFsn2Dco?=
 =?us-ascii?Q?bz8x4AZ9tiyjqm7e+FPl6eEZz7Cb0WCd7GhXhd/UHf1P5gnw494C46kusOlv?=
 =?us-ascii?Q?00zViJHyFSmEBlXdF2yrW9u/CT2LBg51Uam/yui+oxHgBZ4KOjwZRvivYLNQ?=
 =?us-ascii?Q?fUwfIssUm+/DvbqxJAtiNTVWhVaNic+OmH/BQy6nghAVwNyJjjQ0saxhL0UT?=
 =?us-ascii?Q?7f9wiwJcAE2HsD/nOimp1b3jTAfnjrasyHlmdgg+fuPf7sSKp3tyGJy6FQDo?=
 =?us-ascii?Q?1d5cIcmoCwnw7o3s+5B5baaqdK8hUZGSPASlVPoUuZtTf2KR8nuYvPLbwVWv?=
 =?us-ascii?Q?l3Y5Xi+8VhEa3b+/OPHMMJzbgXSWKa1dqDwiypnk6edQYu+/R3gkYfEFyRmq?=
 =?us-ascii?Q?7mIL5x6NrxqCtOQLqKJ6hDfPqkhNNCaENAfBpAglSItveWmJ6SeRJLVx1tT3?=
 =?us-ascii?Q?LKFlkEnJQwTNrx5nCl2ea+jYQYrb0FHTBXC/oY6fmQlxbj9ZW2aKGAS386Is?=
 =?us-ascii?Q?1UmlJgG8q7A3NGIFrdTrTrRx6SY8i6c0KAx6qRk7JruEHr7mOOChl831vP3Q?=
 =?us-ascii?Q?f7JfRFmNxiYiERwHRsnBkE3uvrKTY+fyDhiB4l3eTct9gwiHpCBJ3sRpjU0w?=
 =?us-ascii?Q?hEzrw0sUuEF85RmDIxJ1Be91C3Vx0Q/T5LPDSt+ALWc1LTu/wv/s8O+5nDtA?=
 =?us-ascii?Q?8XFXFodsvTHPNzpfLdpelLFG4o+k01EabYa4/oiWoCifWq/xRKVrhVMJKJdl?=
 =?us-ascii?Q?eEf6LbNC6Rcwb18za6IV/IxpMDReJYVh8fFhG+glzEpvBEKF0DRl+w7S1bau?=
 =?us-ascii?Q?quXW50abcjtF/2u5bBj7IAbshLxdKjd99O4yuocIezGpDbsSCM6FoYXaBFHY?=
 =?us-ascii?Q?k3lkCyVWRxsk2H3vHkLA+SWHVvy3hNkdWB06gVwbf17U8TXJZMcuPbhqVM/r?=
 =?us-ascii?Q?L4iTuU8jrv2zxHV6R1RxbvXJ5oq97lOMATcLYAAtUG1/yl5j3kbkH5VgojZz?=
 =?us-ascii?Q?W83CsVYgqRpy+jJQf66kUaJIFbLGAYM9K3z0a2xQxnKEB/9lrXmN24yXSppM?=
 =?us-ascii?Q?MjpCfKLpSOeDEcBMgoBflwoj3TK3RYTYf35QZZWeUFhAVAruG70eHx3Vl5Gj?=
 =?us-ascii?Q?8yoowDYl4cqS7IXPo1G9yxmp4JEFZXFExnCBFlTQHX1oJ/2AXNkBzcyHHaMO?=
 =?us-ascii?Q?JY4dsXjJIk2wB4qyKrRY3ZC0KmM85TrjVH5oabCs49TvW+a/7mZ6KD5sBcNr?=
 =?us-ascii?Q?tXt2OG0EQHIRcrm5MsH+tvIa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca7d108-f272-4235-3e6d-08d90439e9ab
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 20:21:43.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN4xhvqqdZ1S6J9D6V1oB+/y62epUTj0/EWkMBsoSOTY34IXptzkQ01yrGKOtFUH
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

After draining the stale retry fault, or failed to validate the range
to recover, have to remove the fault address from fault filter ring, to
be able to handle subsequent retry interrupt on same address. Otherwise
the retry fault will not be processed to recover until timeout passed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..d90e0cb6e573 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2262,8 +2262,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	mutex_lock(&prange->migrate_mutex);
 
-	if (svm_range_skip_recover(prange))
+	if (svm_range_skip_recover(prange)) {
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		goto out_unlock_range;
+	}
 
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
@@ -2325,6 +2327,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		r = 0;
 	}
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
