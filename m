Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1DCC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 02:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A2220409
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 02:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w9ciQj6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A2220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441D56E56D;
	Tue, 10 Dec 2019 02:55:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4237E6E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 02:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9cxdZKFEejjSGdWND/Yp97AR5Vep+XZzA9RGL8gh9CclK7UGmFcd7je8Laf4mKRHHmk7esOc8bO7ToXykWD51BZLFMvf5q/lK22Ki7ZcKWQ7LcAfmrdS7Ct7k+V9HoSDm1A5Gi7filNZVACKUTB+Viw2VqffD+6NkepNypOw3HgU44wuy9qptX/lB8/xzkOK9qgs7MkKSsTUlzpBjBoU2riy8etFKmtg1cz8W7nMQqjr30QIbxdS5KqDQL+f+KExVSQ6cktFg682G1gpiMysUJm9eW0+Fg2GgXfn5TzQlFkZ8rc3YTgd6UFj85CR81gs/L1TneoSu6m7bXFFmCaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy9u6GkJzSJQ2NE4m1zYsld+7/A8NoSxfxHH5TC5TPY=;
 b=RqmHL0pgIxi+rz6UkYS43qA1t11uC3OndKXs130+Y3tij1tFF7c3cCaeC4geNJxu87lIaZB34PxR4fghv76cTCYPB598gY7vkxrfOXrj7Yr6MSo7T6LifJFvBYM9fvTYCogD8f6NrOrIctEtcWHK7JOjfem13HvWOePsA90gmkX4dPHK383JD8saTotW37dwTQTm26qcBSK69tFQqsk+p9BU4EOcKaTQ3ovXZfbYN2UktK4qyH8Dab8owS3oYpmu8qe0Urm7HgN5e7wTU7OqbwLgfEzVv9HNZjgIthrv9ygnQbeWwhAeCBVt92KJZ2PkH1TGOQ1RwAGDbueKNPaNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy9u6GkJzSJQ2NE4m1zYsld+7/A8NoSxfxHH5TC5TPY=;
 b=w9ciQj6j0CcMOHoCpFdHKmJrPMpU32a2VRQX9z6uAKNHMIkTgz5NUaEWSkg+iL4PPk/QdFvR3v63roOMTA9K6o8GZcTBzFWsSUqZ/ohpKd5t8Kbw1+dl27dum6cnzStKTLapqNNcX8q+KnSCsDwVNgmz6w/KswI2GOEnlGmOLNs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB2976.namprd12.prod.outlook.com (20.178.240.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 02:55:33 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 02:55:32 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: avoid using invalidate semaphore for picasso(v2)
Date: Tue, 10 Dec 2019 10:55:13 +0800
Message-Id: <20191210025513.14625-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d05ba571-f7e5-4938-37a4-08d77d1c6c53
X-MS-TrafficTypeDiagnostic: MN2PR12MB2976:|MN2PR12MB2976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2976001FD71D7A9C7F051F42FD5B0@MN2PR12MB2976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(36756003)(6666004)(305945005)(26005)(478600001)(186003)(2616005)(6506007)(5660300002)(52116002)(6486002)(66556008)(81166006)(8936002)(6636002)(66946007)(6512007)(66476007)(86362001)(81156014)(2906002)(4326008)(1076003)(316002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2976;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUPdOHGhtQghF2XCZHEGTYRGMv4JYrD88Ix3EDB7XIrXC/wwXCx88GxzBz33uPcmKB8g8m6oB17bJGDZ+q449m4YewQTTf0g7liBfrx+vF5Xijeq8D0Y33TlTNcsJciHeMxUoGKw2ZIDqv+0gBiEdFHBCye4gpq6VVnhr7f4pTPTpH3hzRFE4zOVogeIvZQimYZqruEwribKRe+cLehRMnhslJUdW+zR6tBEZ8p0H8VHPZ8fpbUSO2DIA2IWIHGVk6hSd6wAmvolie+4xDhrqnYfUZewhJqoY7hq5qyo+tvlYeyK7e1MWNG51uny9DhJu142ONA1SaHtPzIa+nBsvhs9o5+d1EgRDxYA3o8BosG46ExD8Cp0wlHyCBYISC/Do+o0TwZiVPkF/WNWbZ8hpnqMCsA2cQIK9qlZlcFg43x+rb1rn1rRJvWXrOI5G47q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05ba571-f7e5-4938-37a4-08d77d1c6c53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 02:55:32.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgZ/sVIpdDpI4BNeacFrTrYUHhT7Gs5NN8PIVysDR0n5UrMWpgefVKdnlN6kQBgrkFewT6VQ5tc9U+OsAFO7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

It may cause timeout waiting for sem acquire in VM flush when using
invalidate semaphore for picasso. So it needs to avoid using invalidate
semaphore for piasso.

Change-Id: I6dc552bde180919cd5ba6c81c6d9e3f800043b03
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 231ea9762cb5..601667246a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -464,8 +464,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1) {
+	if ((vmhub == AMDGPU_MMHUB_0 ||
+	     vmhub == AMDGPU_MMHUB_1) &&
+	    (!(adev->asic_type == CHIP_RAVEN &&
+	       adev->rev_id < 0x8 &&
+	       adev->pdev->device == 0x15d8))) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acuqire */
 			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
@@ -495,8 +498,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1)
+	if ((vmhub == AMDGPU_MMHUB_0 ||
+	     vmhub == AMDGPU_MMHUB_1) &&
+	    (!(adev->asic_type == CHIP_RAVEN &&
+	       adev->rev_id < 0x8 &&
+	       adev->pdev->device == 0x15d8)))
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
@@ -527,8 +533,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
+	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
+	    (!(adev->asic_type == CHIP_RAVEN &&
+	       adev->rev_id < 0x8 &&
+	       adev->pdev->device == 0x15d8)))
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
 					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
@@ -544,8 +553,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
+	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
+	    (!(adev->asic_type == CHIP_RAVEN &&
+	       adev->rev_id < 0x8 &&
+	       adev->pdev->device == 0x15d8)))
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
