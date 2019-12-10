Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C6C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E6F206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TXtG/1Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E5589FE8;
	Tue, 10 Dec 2019 16:22:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB3B89FE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 16:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRHJaHbqG8BcIdBmNtMT33KUGaHxvByd7F3LPNaZ47x2STne5kP9Oep1Me/dEYhNowQ9acqNcDDX4tfx3mpFI2d/RZLwn1mHPIYxJW+AbZ0pXEB2rjxw3YSEG/anVXdMNao7/PZ2cHI8q1q8uYbcNwZLNbFJ4wGhLUOsYH8z8AyqiT8sk/6bvRc62wO1bq4Q+1WcYHrWDOaHmocGQmO7Ljdq1iAALGiTHlw86O4d+o7FM8k6w+Cr83YN5+Uk5JMEhRvlS2oiZXhI6JH6UX6gQ4BTLDGRciLyeIqYFAXSGf1OYROZBCIDOjJkdKBzm8S/RKg+u2XL47G7MR3a9pKNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8silYL6EPc6gK1JTAIypM176Nta28tkA8uAdsv67/w=;
 b=ieYR046tDjooXPnOm5l3PquYiDyHyjaTu7K0iyO//Pzn+LGSUzrxtITEShHNaQJDLbAr4l440CesPa5XAJf5jmuCWTYHSqAODJr44tWIBkL55zp4mr1RTa7/eU8/Bok9nmYbq3Zs3qQbo5zo3E3ysBfjpYLKtAs+wXy8JfW4J/kQobMFyOVywsWEOx1FFw49N+Au1VMeZcbLxgGN9lmb2694kWzN/xW9+0D/0RcusT3QTXKCh37pjnlQcAxI3kJ0v3HO4XJXpOhUK7sAEW1pujDwRoASRytrqic/89ZSmJNHhmQS4jVrcbIPpFXPh0TAsFndmzEzANBFSpk/lh5FjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8silYL6EPc6gK1JTAIypM176Nta28tkA8uAdsv67/w=;
 b=TXtG/1EgwolcLafmVk3g2u0Nhmwk32tJKulLfdLMwpvEIBXujJcdggSCGaXBSbvSUapNx1xbtC6ooT1JIG62u5cKw9gXk+CsLW+GYJezjSeTkRsrUE/B4jQeUQLkUMRTm/sfr+Q5fwaAfA0qiAYepTPf7HFv09doqly/BPBDS8M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 16:21:58 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 16:21:58 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH 2/2] drm/amdgpu: modify invalidate semaphore limit in gmc10
Date: Wed, 11 Dec 2019 00:21:37 +0800
Message-Id: <20191210162137.23538-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fafc15a-583b-425d-1883-08d77d8d1437
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:|MN2PR12MB3215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB321584531EBD6E69ACC8128BFD5B0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(1076003)(2616005)(6506007)(478600001)(86362001)(2906002)(5660300002)(6636002)(316002)(81156014)(8936002)(186003)(6666004)(81166006)(26005)(66556008)(52116002)(6512007)(6486002)(66476007)(4326008)(8676002)(36756003)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKma71EFK1G+xJmG8QJycUqvfxtHacugktiZwV060MlrkNPbPgbb/xsBhGvni1b3+sR38cq7KbnNj9jgS/GKOx1GAIo2Xn2ET5HclLUppx+jvweB9By6m1xj4gDUWwZK82nz2q7E4OeED1ImxyBO9fYX5ReOvq+eIqxsAwnVemUPPZwnshoEDVaOqXPr+LxfF1zU4YWAqDdUIFHEX4EWxKAKYr6FCKyr6wLjLpDHdJ3Amo0MflzHawqnu24fDbkS1paSa2KLR86TO4cR6YgZ2fCWt2KXtoaZM1zE8632wgWgLQ/pZUacf3KYVGO1T3GnQoCnkcegT/HIr1a/TekiR9/uNW5elFjtzBgOWeKOpSiZf+jN2bBrMGxdhZmVJesqCxcjoNayO4XQi7TOBqMzs3jlFfgVwoEKH+N/hGwHalTLBkfIIURbQg4E/hvtRxxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fafc15a-583b-425d-1883-08d77d8d1437
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 16:21:58.0809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuk5D1dRzucjff9XPYXnx6KpB22eIL1Lb5yVJijvF/iUY5dM3RfwhSnSQIKO+UmSrRq+fSGkxbGUjdtqhGLvpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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

It may fail to load guest driver in round 2 when using invalidate
semaphore for SRIOV. So it needs to avoid using invalidate semaphore
for SRIOV.

Change-Id: I2719671cf86a1755b05c5f2ac7420a901abbe916
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 32 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 381bb709f021..fd6e3b3b8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -218,6 +218,24 @@ static uint32_t gmc_v10_0_get_invalidate_req(unsigned int vmid,
 	return req;
 }
 
+/**
+ * gmc_v10_0_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
+				       uint32_t vmhub)
+{
+	if ((vmhub == AMDGPU_MMHUB_0 ||
+	     vmhub == AMDGPU_MMHUB_1) &&
+	    (!amdgpu_sriov_vf(adev)))
+		return true;
+	else
+		return false;
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -233,6 +251,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
 	unsigned int i;
+	bool value = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
@@ -243,8 +262,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1) {
+	if (value) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
 			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
@@ -277,8 +295,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1)
+	if (value)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
@@ -372,6 +389,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
 	uint32_t req = gmc_v10_0_get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
+	bool value = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -381,8 +399,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if (value)
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
 					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
@@ -398,8 +415,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if (value)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
