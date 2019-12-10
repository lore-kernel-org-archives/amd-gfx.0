Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFADC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7897D2077B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LBjrFbsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7897D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6789DD2;
	Tue, 10 Dec 2019 16:21:27 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA6189DD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 16:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMg/l7iHdE/Oo3AwQnhvihAawdG6mvfDFFCV2ATHDeE/GIa8+RSdKfuFb+YbzbWqIBwifKIGXWTtwYfwjJvHkiflZRE7bwfg6SNEAPaykeBMYYRZPN6C18rk9JBOSmW9bowEXy7riGoJm+vDT0el76ZqYVMIG6SPDWPntm2HfIDKhkksRETanI7Ic9mxKPN/aIKwUc9jm980mhQxKukXCfky6KGih9nZPUiLhPsAqBw6bLsN6S62UrLwB6NbsY5GDKScyXFT6YlbnP4Bl6QI2ceRz3AxMzc7JfOcn7+RotQHajkSVsxIcEI/ZdJ8dRn6m9nSMQNS0q2+tdD3quQCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX85ARBREnbQZzHQeofk+0++idU6KWoPt3WsYo7Wgz4=;
 b=MQrRN2N5BIuiR3uBaPP8zirAe6EJpYBC35a1umZCB/OmDNktyf+yRPVPNTTpPXgIrlVe95+Pui7NxNDXCyBpKaqIFtaVsYMENRqQclrZ1hrNfnh2jVlEwErx5ckeUrZJyuX3w26VuLB/+AXrZMfmwrVuNIYcChkQojm95tk68ihrfaZr8ah5Kyw4plA0uNi+huzbJwD7ByaDkFM0oD6/lANyJKL7WNyb8dP8dkXLFPC484gv8HWiUi2JBwPLLlruKAcrHs8046Qp1E0HDu2t1ZP08R712c4l8dzSdULllr+ufC7yX+wW6KfG6Fo7s3ZXkQf60SSlsimrjIRKQu5Etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX85ARBREnbQZzHQeofk+0++idU6KWoPt3WsYo7Wgz4=;
 b=LBjrFbsFqCFWxA2z6T+VNeYTmHDm8FuEbtdUsDmDPYmpa5tX7DLBK+sctgNMh0HGvZ8iGaGC73JP3KpExciYTyBfwbvzVykrTbsIS+4bjq7PuV1NAogMfEgNFRr6em3rVygsvsjIpOkTlXxV1ZBOokTBiYzqZS0G534scm80rzs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3680.namprd12.prod.outlook.com (10.255.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 16:21:23 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 16:21:23 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH 1/2] drm/amdgpu: modify invalidate semaphore limit in gmc9
Date: Wed, 11 Dec 2019 00:20:08 +0800
Message-Id: <20191210162008.23482-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cadad73c-46a8-4a34-93e5-08d77d8cff74
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:|MN2PR12MB3680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3680B715473CFAD753B80778FD5B0@MN2PR12MB3680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(6666004)(6486002)(81156014)(8676002)(36756003)(8936002)(26005)(186003)(52116002)(81166006)(66476007)(66556008)(6512007)(4326008)(478600001)(2616005)(6506007)(66946007)(5660300002)(6636002)(316002)(1076003)(86362001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLGbhSK2ZAHfn90CXLlUduutIXiROVyCgvMSEYA5ZbghqJoq+uq+lPOmoVducHf36yabt4GHY/yMZ+H8TOGiglP1AM+Q9uXyVqQaSJVQFXFkt+u8f66hhdT3jk7h5xY+cSd7wP8U4AyCLXzRdkLjoF6mNL4vVuedLi+v8HMq15seKfSla/9Tl1MMC+9BBni0ZakjtgEFgOg1RIOSBqIKSf4NO5ZHwo6GsTZXiRMRXxKtSbAxzSb1W+A0EHqJLCe095PWx/qoeKcEeNAUWk8KYtE6T71IhreQzEHqwZhaKvXfW0YunOm8C19LkCF/rFj1efTJsIZ1p+jSkdqop0suUvADdMg8WPKy4FmgyzaiZL0AQXoSDzx8rr06BcvxaeHmECN6jozuuHuZwopmNMvQlTonB0DAgPTICwdJsnLdb1RSlhca/rzbsfcmNLqXEKDt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadad73c-46a8-4a34-93e5-08d77d8cff74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 16:21:23.3136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7dxqcwmbP+i8+eGe8uQJvfNlyAnXKS92SFFsnwOKg15GwYNvN7orrK7q4BAKNezmUKoDSWoNsoRNdci0aKJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 601667246a1c..552fd7f3fec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -412,6 +412,27 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
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
+	if ((vmhub == AMDGPU_MMHUB_0 ||
+	     vmhub == AMDGPU_MMHUB_1) &&
+	    (!amdgpu_sriov_vf(adev)) &&
+	    (!(adev->asic_type == CHIP_RAVEN &&
+	       adev->rev_id < 0x8 &&
+	       adev->pdev->device == 0x15d8)))
+		return true;
+	else
+		return false;
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -434,6 +455,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	const unsigned eng = 17;
 	u32 j, tmp;
 	struct amdgpu_vmhub *hub;
+	bool value = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 
 	BUG_ON(vmhub >= adev->num_vmhubs);
 
@@ -464,11 +486,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((vmhub == AMDGPU_MMHUB_0 ||
-	     vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8))) {
+	if (value) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acuqire */
 			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
@@ -498,11 +516,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((vmhub == AMDGPU_MMHUB_0 ||
-	     vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
+	if (value)
 		/*
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
@@ -524,6 +538,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	struct amdgpu_vmhub *hub = &adev->vmhub[ring->funcs->vmhub];
 	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
+	bool value = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -533,11 +548,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 */
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
+	if (value)
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
 					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
@@ -553,11 +564,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
-	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
-	    (!(adev->asic_type == CHIP_RAVEN &&
-	       adev->rev_id < 0x8 &&
-	       adev->pdev->device == 0x15d8)))
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
