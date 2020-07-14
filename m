Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA2C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052421582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vgS4o00P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D548949C;
	Tue, 14 Jul 2020 08:09:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE8238949C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPsvxBXpNHB065wnBamfTRsX9cy8uMsQRjffUGK8VmyZaBDJO98ZgsaBR07r3M4e4KWtrVQ6puWf/rk3NjZCQD6ad4nAK4DyMkbnJcJPVqCWm0iEhTeBP+XnzTbXRv6gx1zB7Yy3u/AiEBOCJZgtu0rzogSq555aUQi5Thoq3wEQgMjgfJm2pERFt/oqiz6LYA5qCOKofyhcdrIupwLtXEj1V0sC+iEe+dyVdqrOWyECQf4I9Qwuk7tpqaXelFex2MGsGL+kAZXQM+/M2aEa6MVBkC69nvsDsAJgDT05oT08Zz9D/DSlrISfZzbgWFXKSM4h0yP6EzxVLTojoYj17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJif2gjkW8WAQR6K6NAks3coXADHxO7sYZjM8mqGelY=;
 b=Tq7ZhZo8WInz+4aJYL7L0QQhyDudmuu8SvvlkTs4G6ot4vdYwKmVBG1XilGNaKlu9XnzRjZCasXpirLoM8rXiDkL0IfgH/ME5Q6VL1W+wUa53Eo0QTQyl5RKEaUyp/JvlAQxtypRILQMmHjQZcQy7hCog1zmiZnMisgKlOU87TyvWGOfLC4tvcOBYZcQg/AAfAPnhClvu4L2v/kldyDVGU7cDYTcQP9OxvmPY4IgA5buVbVD1LZRYsi94fp1/1q/1SfCwTXPM/zYpAY5RMVOzWm3qSN+PdV/pJpM9bE8/KQhQtsaLh3e2Y3vPCyy23p00hirEsIXgAUvMvhkIh61Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJif2gjkW8WAQR6K6NAks3coXADHxO7sYZjM8mqGelY=;
 b=vgS4o00PY1WL3On/wjeD65t3H57ucVBfIyxZ5T0HnVxEz2cvBwC6lWxLl2xQLMLqZ/btLiJYYwrMr3n/3EJ3+ACJS0+R2AKYduxhk9QWHN5/FcDGA/Ci7ihTgZJxu8ekTwYj0NB68/ft+A+pKt0YZV10wZMQ6hhSOEwW4XiTneA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1456.namprd12.prod.outlook.com (2603:10b6:301:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 08:09:37 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:09:37 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
Date: Tue, 14 Jul 2020 16:09:24 +0800
Message-Id: <20200714080924.3722-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (58.247.170.242) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 08:09:35 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67afd4cd-1876-4c19-5c5b-08d827cd4008
X-MS-TrafficTypeDiagnostic: MWHPR12MB1456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1456057379B73F7108700FE889610@MWHPR12MB1456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZiaur062m3FiXmv1uB0so1ZdkOsLgd/vOBafgpGRSd9qn+0Bx4AO01XYIkZafSw+t83ufIP96HnCs4G/8XV151h4OvyG2Lxrb92Eq6ICgtuinwLT8mW7ikf1yiQCr+fqO7amcb2q/j6zxqtaQMjBFLWsFDWXusFHGJXvMVR6Ku4nmG5SvsY86sGyMjKw3p3oiq/bTWP3V29cnZbOTKUg3VhsLd8tDoOfUcfmSUVvhK4xuRCLLMaIO3sEMO8Acei1GEk7nnSv179oBqqHuEwaAG81X83ROi0jZUlP/1SMjFlVSmcdIXLzFVcrKorQVz9v8xznmy+bpAM+9atAPEd6wsiyXziH6AnfWRcjrYpF6YNDnVvOfDGjO/HWYB6apTR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(6916009)(186003)(16526019)(26005)(6666004)(8676002)(8936002)(7696005)(6486002)(4326008)(44832011)(1076003)(52116002)(36756003)(2906002)(2616005)(66556008)(956004)(66476007)(66946007)(86362001)(5660300002)(316002)(54906003)(478600001)(83380400001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eq8/2OqhJ9ByIghvNjaLw5PavtH78epsYSMMpvxeJ0dA9RORoQXs6+ZnH8pQLc29LuFevmGdze/+FP8859EEJbAxn1u0ggQGWWIRTuYtYvdwiDS7hvSoBgcDJjnCexpraaYzDeSzjUDeMNPOqq/5D6Tnygzb1WBRMv8WMtrrQexUC2nfzXBDZ2MY7lsbaEP82rrfbQtLCoqkVAz+1li5H6nLKk9fla0l+C/rcsb9nw8yMBtLfRat60qI6MVEkUv7rVi8qG1IPs0S1JeTQxfxYepSC/YqOpr9KFoUh5vg8jmYHUISUv9yrCrQxnWieKW9lWSMnaZILN3UAA2lbzPYafvE7t8Tu9+5wDweWBpQGOSB5kigWsSsAxm4xTqDRZCVxGdWdIBuigrdOjQtpc4FAXXJOdEgvFcLSQUTyWp0kCSxv5CJ5o/kfAipYiP+3K59uRkjWNtlkbG7xYS8MWgfdvCljj8dhD8G6gc8X7iBUWs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67afd4cd-1876-4c19-5c5b-08d827cd4008
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:09:37.1542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0i5Rs1SNXAtzdn6Nz7kE43zl0g++4shn2P5Kd+qu03AgIJ2i8157yYZCrzcnrMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1456
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
Cc: Le Ma <le.ma@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"u64 *wptr" points to the the wptr value in write back buffer and
"*wptr = (*wptr) >> 2;" results in the value being overwritten each time
when ->get_wptr() is called.

umr uses /sys/kernel/debug/dri/0/amdgpu_ring_sdma0 to get rptr/wptr and
decode ring content and it is affected by this issue.

fix and simplify the logic similar as sdma_v4_0_ring_get_wptr().

Suggested-by: Le Ma <le.ma@amd.com>
Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index abb0ab653b10..e2232dd12d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -315,30 +315,20 @@ static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
 static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u64 *wptr = NULL;
-	uint64_t local_wptr = 0;
+	u64 wptr;
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = ((u64 *)&adev->wb.wb[ring->wptr_offs]);
-		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", *wptr);
-		*wptr = (*wptr) >> 2;
-		DRM_DEBUG("wptr/doorbell after shift == 0x%016llx\n", *wptr);
+		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		u32 lowbit, highbit;
-
-		wptr = &local_wptr;
-		lowbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR)) >> 2;
-		highbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI)) >> 2;
-
-		DRM_DEBUG("wptr [%i]high== 0x%08x low==0x%08x\n",
-				ring->me, highbit, lowbit);
-		*wptr = highbit;
-		*wptr = (*wptr) << 32;
-		*wptr |= lowbit;
+		wptr = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = wptr << 32;
+		wptr |= RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
-	return *wptr;
+	return wptr >> 2;
 }
 
 /**
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
