Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D36C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F1B2054F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AcnDWQJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F1B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85E66E9F8;
	Wed, 11 Dec 2019 07:36:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B0C6E9F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 07:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6sugP4VfLchm40sVt8PHyxtH34Dq4mV9ALiAGZNetkqTmN5W38G2cFdfO0hlmTAqQfNaM1dDy1OoqJ7vEIJgck2RwZzaZ80yH7coXD4TX3pDi84tFRhCi+Eil+eMQftUjf10f+SPVHx+ff8rjQJO6nmNBTg6I+MMenbUb9Sh232GhXEdB7SQ5d+tXFDXKFHc90aNv3E0uiVp+/4yJjYJuTnqcWVOtUX+oNujrG/d7wu6FthLb48zc9gwg1WV79qU4esqRytzGAt+58BYgcSunLKUTANqY0CQTwGdbLtN179iC5vxDRMkydGek8xiokVvig7XhOEEgNV/1spW+gngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmZBjnpqdT3fV+wkJ+H+KwGSVCNffy/ZkfRBhXyMnnM=;
 b=cPIYTaLfM746y14aKekBNlMEZpPbOomzKNI7H4csnqBvi5alzqFklvdel5MlXSWO7o98DNA/8f+lkRT3TXxKSzepgb58X+mYmei/9sy0JdJvVdQiNlvBA5qkblo6LPsbXucAW+lE/hgZpup0Vnqz0A/JLm9TJxHAJDm6wpwrEIG8rl8u30aWA8hvs+HHBsSf8Dll3EbbjvOL3PSoe6nR/m2HKYMj6T4qNHE6EVKIOYLIrGx216b74RGoh+CH7KvP/X8MSK40+q62wSxQzeqPAA561bspHtBAbfyziTMtq27EVrJHw9nhmUV+2uFjWNPqHSnUVhQsjxFzXvAmkFc4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmZBjnpqdT3fV+wkJ+H+KwGSVCNffy/ZkfRBhXyMnnM=;
 b=AcnDWQJrSCTVqH7ZIB/brgSHXoC+EW2Vy6hXs04vHLD/8hQRLX8dvFgo7wOyqLKFkRzbAXufHWOFoaQ91opcKn37kqI0cScrnFS9PFwR5HUQAgkOZEptV4LJUDBR+4jEXUz37w4e0meEXhtI1vePkbUeGkfDuiO2UGL/onXF8GI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3901.namprd12.prod.outlook.com (10.255.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 07:36:26 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:36:26 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH 1/2] drm/amdgpu: add invalidate semaphore limit for SRIOV and
 picasso in gmc9
Date: Wed, 11 Dec 2019 15:36:05 +0800
Message-Id: <20191211073605.27847-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30b88a65-1aa5-47dc-5441-08d77e0cd425
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:|MN2PR12MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3901A397EF934D9F320E89E5FD5A0@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
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
X-Microsoft-Antispam-Message-Info: e2rlL9dk9y8OkVGYBcMGoXz5HFJGktJ74eOO7LC8AZeLxnBi7AGJ0ZW0KNfExtuCbwpuq9rUPwbDn22/F8MwYkw8uXhNQxETahfQmrSqQjOmDurILsMh153YxDEC8t9T21hojOsYCn29TSzBJ4r+vUAOi7+Ih1T8jYcvXoPoE3cM7J05IJAupiaZUj7lexSjrcqF+xtO4q1+1BtgmT2Uei3XskFoN72toZxtbWQLICnn9WyYKFQxRBEzLlKjXlZc+WTIQuDg0SjUm4mJ/BYTExWE25hFpAyKOgv0OJ9R8zFIW5tVIyGvj8/HkoMS8oevrwy1lY2bzuWkYFKf4aCoX7yaf7PuyP9deCCouaIQAzK3bHR7YangxeB9eTkTxeeLpa0iWgL/20y+xtYJAfKR81kYC/btYvEznJ0jrGian2+eM6nwO6cNURKOBANKlFD2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b88a65-1aa5-47dc-5441-08d77e0cd425
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 07:36:26.2546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3hlAXXDPHmKzhcRHzqlC1IKdNOH8XEZI1qe4ZpnmBTQs+Vym3P4qO1IS+fjFFHV11vkMOpb5Yqk8Hoty1Lh0w==
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

It may fail to load guest driver in round 2 or cause Xstart problem
when using invalidate semaphore for SRIOV or picasso. So it needs avoid
using invalidate semaphore for SRIOV and picasso.

Change-Id: I806f8e99ec97be84e6aed0f5c499a53b1931b490
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 44 +++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 601667246a1c..efa55e9676be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -412,6 +412,24 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 	return req;
 }
 
+/**
+ * gmc_v9_0_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
+				       uint32_t vmhub)
+{
+	return ((vmhub == AMDGPU_MMHUB_0 ||
+		 vmhub == AMDGPU_MMHUB_1) &&
+		(!amdgpu_sriov_vf(adev)) &&
+		(!(adev->asic_type == CHIP_RAVEN &&
+		   adev->rev_id < 0x8 &&
+		   adev->pdev->device == 0x15d8)));
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -431,6 +449,7 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
+	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 	const unsigned eng = 17;
 	u32 j, tmp;
 	struct amdgpu_vmhub *hub;
@@ -464,11 +483,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((vmhub == AMDGPU_MMHUB_0 ||
-	     vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8))) {
+	if (use_semaphore) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acuqire */
 			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
@@ -498,11 +513,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((vmhub == AMDGPU_MMHUB_0 ||
-	     vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
+	if (use_semaphore)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
@@ -520,6 +531,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    unsigned vmid, uint64_t pd_addr)
 {
+	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[ring->funcs->vmhub];
 	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
@@ -533,11 +545,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
+	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
 					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
@@ -553,11 +561,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
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
