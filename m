Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B5AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6731A20774
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Veg5zUis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6731A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1F689A1E;
	Wed,  8 Jul 2020 05:48:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F7089A1E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 05:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c53umcwFfQaC7Q1r8o/Ld6dAt/fhmkAudPWH0imHFVmVzdvPCkLT+L8m1aqIG84zIiKPlai6yvJ8PVmrV7nQGioE0wk+ElH+2ynpX9M343RXsyh2O15EfdRHzxN5mamyNwbb4zogAquJi3RTVx72RcULVgCJ5N6r/bz+UELSclcZUjydr0Btpv9GLoruJUDm7OjuCnyIWncsIvSYA5BmGw8RP7gSV/uMWJS5StAZp3+DzPORhgnmwd5mnNSgdLNDiK6BrjgHVbt7xRJtMZHsCp2umUf5TgaLFIZMbQkJxe8tD/pGlU8L4JeitpIDw+t5ZeTdMLCvAMZs4FIkYGLPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qsa+C4UcTGkLKTnhyt2IkLMoP5w0O3b9PnKfaxm8N4=;
 b=ZB7mvy9I0g1+qiIITBB9+5UPmWb5V0qecReeOXmSx5ROq0/tGjxGGoAD6gcHQWrF+Wcmae3/g6GKGU/R8C9AfKyqwHRWFgdnvb4ZlYrbf5yUJ/UjoO3dL8lgCTVaX+qeez5/qwtggucmBpKLADefNtmKfar9Huff0zzzPam/YOuTFpbvT1wkAj3dm90hawWX1rjmxAy9XNztHpIOUlksO1uXq0a7cgyr7XKSpwIkv/sjtpKzVxO9nhV8qJcFKIVhBUK0En2nkGmwr57MoDlEnZk3PlnOqiXvTIYO+mv3dq1s90+WtU+4d0WgyNnWOqfgp+We/hvPa3xIrBNZeVjF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qsa+C4UcTGkLKTnhyt2IkLMoP5w0O3b9PnKfaxm8N4=;
 b=Veg5zUisLAQTU1/tZ8j024M0dQnDjWjPhEdcSgb4JEgXAoq4gacrUh0+fG/wbtWe4G2zrrWz1mYNUF2dv6KJPx/ta2DJ4W9mLtDWsTqbU+OajSnzUkYni5JCrr8XaDjgUPn5qnU2Ht1OZglhsye4Ohj0//8zHs7sJcqvfuRFeNg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 05:48:17 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 05:48:16 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [v2] drm/amdgpu: remove unnecessary logic of ASIC check
Date: Wed,  8 Jul 2020 13:47:37 +0800
Message-Id: <20200708054737.3015735-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.5 via Frontend Transport; Wed, 8 Jul 2020 05:48:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ef5bd3e-de2b-4879-1473-08d8230282b4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB174462AC50C283810C5D5D0CEF670@MWHPR12MB1744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlB+PDHCiZyKQi0Gx/sCKfFQtolKNpzWq/SjuIRTgKWHkMnSrhFkwPZJCNihadL+ygsiMWOl3SpHdAzi7/kgdXyrQISxAEkxlO7zce066Puh7pIpAIqV2xWF93g5y4S6f1MrPYEtlhuK/+zcO6xc9w736BlRwUPjkwhXV+D2EgTfNSDgQsSQIQXrBqNc661HHMMWSQPi/GR0JTML9birwHeQIqzix+5FslBKhpcPKsVwdwSCcgHzssSC92SzRIef/jYeXjChoOj7NkmsnHq1cpDe2Qw1Gwm/8LmLmwUTesidJvDmzD+jjmfQxG9cZoh7qnZo0gJxgCvRWq+xa7eXoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(16526019)(478600001)(8676002)(26005)(1076003)(44832011)(2616005)(956004)(6666004)(83380400001)(66946007)(66556008)(66476007)(5660300002)(6486002)(86362001)(36756003)(2906002)(186003)(8936002)(7696005)(52116002)(316002)(4326008)(6916009)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cx/czxyTISZCOcVRBH5ZAmjhPEnbnumHMGtO293x2MBf0QhbUjFqX6QbT7tnc6wu49qUYxIteLKoZA/FG1z4Zi5aYczK3+O8hRcDv1OnVT80y3oMPdm6aYWwTVy9i1W5KIiMA945LJFQMDAofA7DcBSqHWcfTxv4PsHUBMeAEVQ7K1iLEfVMzAqjmdIcIJbgoyG5PxBctx4N+9qH/llX3ejlyPAMhv8MSxiLUmAmgm8kY5AeBzHIacUfI69hwnyVCdDOyKhX0WRiLeTGkSfb6KTH0bpZLuBBrhV0KNmf73WaPhy0K0LES+dQz8o/x4j7AQ6Zwj2l7dkxRKgs42xt9aaXpbasDoIK9QC2fE/2Pbdg/iefPUZnmSe4nR9GYCh0NI5mtBATdH+Cf8vq2dltQLSz1lxCDrug6dNZCQXQpEh9jJCu8rwl6dI34PBX4EKnsjXGyLqNuGY2FnvlH3G63Kelnzd6k2U3AdiGQfkqzxXoJ7nfATxdwyIWu7S+uFQC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef5bd3e-de2b-4879-1473-08d8230282b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 05:48:16.5550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INsgY1oFwusfm7cm+BwfZcyXGybvp7zg9Z7i+ZDSoKvmwC4Ox6PvyNlZNAYYSwPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Remove some unused ASIC check logic.
Remove some definition of amdgpu_device which only used by
the removed ASIC check logic.(V2)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I5b06a51b41790b4df1078099848025851f79c320
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 +-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 +---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 82680ce51cd1..786193a38689 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7683,14 +7683,9 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				     u64 seq, unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if (adev->pdev->device == 0x50)
-		int_sel = false;
-
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1baeddf2f1e6..abb0ab653b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -485,7 +485,6 @@ static void sdma_v5_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				      unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
@@ -508,8 +507,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
@@ -887,10 +885,6 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 		r = sdma_v5_0_load_microcode(adev);
 		if (r)
 			return r;
-
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1 && adev->pdev->device == 0x4d)
-			msleep(1000);
 	}
 
 	/* unhalt the MEs */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4dbc11907bc6..1ef14b610a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -417,7 +417,6 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				      unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
@@ -440,8 +439,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
