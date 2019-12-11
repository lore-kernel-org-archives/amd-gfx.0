Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB99C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D103E208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N+kx1xll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D103E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88ACB6E9EE;
	Wed, 11 Dec 2019 07:37:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEE76E9EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 07:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAgm7rdHJaRJqOfG28epok1BILUnrHQIuzw417aJtijd4+zjTeuP88HzpmYwPXfwRnM9rtY+cUq6ooQ5+/fg0+Eq3zcWq5TbmiQhQ4EYimS8xYo7L76POfVNh49PmcPVxgMtoNu5/9pUYPJON7EPu5jeLSdaWR1bpJFczqXbzTJRly0g90cq9//TqVL7JZMkWsqt1fjZbThDINIo927FzIjRtYvqy2fD2dYwRkTs1dikOb0EiLriW4UkRClUCKYdV5e8ijDyrSXJrmhLugydVdUgaFucvYa1qKjQ8Hua+dpVLR9O99e9X/gOoM6A4YGHATGFIOc2ScKzWniec9Slow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u+96lUUr5IllICNgk7In1ZWHXbNavTPVsrSIWAZkys=;
 b=S42gSF8kLpgDBAWTY2HR/uCRsc8lGDGf0k3xNI3gGE+TgMbHsxVTWMVUO9wT2Tadb23jOQUPSVEQcDTSrGj1viSDwXO7cMrfwRCfBbltl5q5Ok4FFE0dDCcRlrTKmU8LWsBfmzuSoekx/plL8zC2phHzCrM7EpU3JyzX4c6hrET7QJs+mg68yPf2gMMP7Eb6tSi+pIR40zYu8n5W1Bx86pTJn0J1z25DzNTuY+jcf/Mt6YbbZSZknksKyXD31EHDw3WMCfwHi8Ztbc8ktaDLT4xoMz9Aw1x6canlMPEXjVKm0vMf4kFgXMotm8HFW8fokhT1q86uLJgSDpS6CBD3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u+96lUUr5IllICNgk7In1ZWHXbNavTPVsrSIWAZkys=;
 b=N+kx1xll9MX8hRIXmOVXslCorK0oNtz+qcbrLDbbFGjMsh0edzAqcC5SOHAtjm1IR6jQBmGcrtqwMOoqwcjdLq9N28NQ+Xl8qsbznvxgl0PsbO8cddYg8FwQbC8WzMvEnGLgcgUtuhT7SohWao0SQ+vLiOobadvc/56/i/fH130=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3901.namprd12.prod.outlook.com (10.255.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 07:37:02 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:37:02 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH 2/2] drm/amdgpu: add invalidate semaphore limit for SRIOV in
 gmc10
Date: Wed, 11 Dec 2019 15:36:40 +0800
Message-Id: <20191211073640.27905-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63b4b836-c9c2-4418-419f-08d77e0ce95f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:|MN2PR12MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39014BEA412A9EEBBA1F6A5EFD5A0@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(81166006)(4326008)(36756003)(81156014)(316002)(66476007)(6506007)(478600001)(8676002)(6636002)(66946007)(66556008)(186003)(1076003)(26005)(6486002)(6666004)(86362001)(2616005)(8936002)(5660300002)(2906002)(52116002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3901;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTmJqVV3xOLrQnKuvlaTdt1UaInfhurNl7cj4JvYPpbx5BtZRKxVXijZEXTtc4456jFXt7W5sCRkzjEvaDr8c0hWS/AjWN9PQFGxLQ2RSL3pvtxS25YrnCK5KWFvcYzBZ5yb4mI0gnd+tpCYoztZk4NtOdmzmOgCX7JUEhlk6cTR4ljhMw/lIlhHaUSYBHbSq8f05pcJkYfGLoGvaxQyn0x8lgT7MhO4ZCeAzYjpjKbXEXo+KsVyn7B83m06yIFkHNLNBpFo4bsVWSGLiLyc9U/5sWd+eZiKPSUELpksMaPSPPUn/bBF1MiAQZx3A5NzHfL0Qfwi+bBGB8MsZ2gMfZMxF8M0sNEhdKwHkvMAVxV5FjiUUfGIn88L9yNSuVEOoImbxtQLV9o3qI9W+9PgN059PzzICGEU98x4JBdLnFarh6Mn8pbIIwO6kh5v+dGl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4b836-c9c2-4418-419f-08d77e0ce95f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 07:37:01.8964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DFkM5r82gSd99lQhR1EyQID4d5yqFM9cq6QGAYBsfq3Z8axnd/WrhRHFUsbwUUqXPyHuH1z6bvNdcMtPEByJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 29 +++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 381bb709f021..5c5ced29fde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -218,6 +218,21 @@ static uint32_t gmc_v10_0_get_invalidate_req(unsigned int vmid,
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
+	return ((vmhub == AMDGPU_MMHUB_0 ||
+		 vmhub == AMDGPU_MMHUB_1) &&
+		(!amdgpu_sriov_vf(adev)));
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -228,6 +243,7 @@ static uint32_t gmc_v10_0_get_invalidate_req(unsigned int vmid,
 static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 				   unsigned int vmhub, uint32_t flush_type)
 {
+	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	u32 tmp = gmc_v10_0_get_invalidate_req(vmid, flush_type);
 	/* Use register 17 for GART */
@@ -243,8 +259,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1) {
+	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
 			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
@@ -277,8 +292,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (vmhub == AMDGPU_MMHUB_0 ||
-	    vmhub == AMDGPU_MMHUB_1)
+	if (use_semaphore)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
@@ -369,6 +383,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
+	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
 	uint32_t req = gmc_v10_0_get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
@@ -381,8 +396,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
 					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
@@ -398,8 +412,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if (use_semaphore)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
