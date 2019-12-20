Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D28DC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F42921D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BW8yB1u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42921D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5E06EBD8;
	Fri, 20 Dec 2019 06:25:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD90A6EBD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 06:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZXddon9YCQ8e426PZHSgU46K0G0B3fdx/8iBS1hIj2Sx5MM9PRCzVv90XkwphMvhBcQDg28tZlc/pX0Vbw+mEK3D8uxCr5bGrtgIcM3ZqtUaTYlLRXdkuunjn+v3qVGGDvqVKbsAQ22ijSeXsYdyqhC4oSRgO8t/vZdgpihwGz2N+KCLUelrAQuWUV6WhyPxPAoSdNkeLNeATvdzvjQRc+FwLCIVvNC/W64oMfYMl9ug7gRLNMgcfJtQGpnZ4JbaUWnHbuR5/lycLo6q87AO/g4qel6NjFPQQTddaek+A18u+HWezqshj+ERhNhmbKvBZBgnNJRF1+OX7jV6I2iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRFvKnX5Y2s+H3QZI8UC2PKbfQb61uZjFo8jLDEEWd0=;
 b=hC286lWfvD3McmSN2mGbnIu7kxwdWyjwuCU/FGhBFq/fBLRQ4w6vwntceZsSgzdEGGmAK2i9m7CSZO/j5nnWaw9ZnAp+18wYaGymptqh3SXnn9GgnjiPJRLMqLvGJtsa/dU4vXHogFtiaqcX9d7ibaLtOX6WXn4ZKvF6FPSmw5uvDVMNMABq5nrXidOGnsVVnA8tAELjxdkMaESo1BWtPPBUzIu3Qd3swWRiwGVDiPETUIUxblVB/6H1p5ofIl1OLc7nOOKLokceMWlCFvnFydjei5Tk9u4VLtVhdZ+cUgns8Umxny812+dEBPOW7B3ddx9ApES9kqj+R8eUDfN/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRFvKnX5Y2s+H3QZI8UC2PKbfQb61uZjFo8jLDEEWd0=;
 b=BW8yB1u13i4MK0Y5zlJki7JHvt5knEPhpxL1gReOkhk4T1i2ftOXZJSvCZAMmvVfkc5j8WTIeyPdBU8rZav+PWLdk/LRcpi5JwZ0ddhsstXkMl/zPMfMMqlpoMgFpkl0Di7lAC2PsA8vPYzOiQgOxkqC3XgzDS/V1qpXV6yeqHU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from BYAPR12MB2616.namprd12.prod.outlook.com (20.177.124.144) by
 BYAPR12MB2775.namprd12.prod.outlook.com (20.176.255.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 06:25:16 +0000
Received: from BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e]) by BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e%7]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 06:25:16 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
Date: Fri, 20 Dec 2019 00:24:40 -0600
Message-Id: <20191220062442.33635-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062442.33635-1-alex.sierra@amd.com>
References: <20191220062442.33635-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To BYAPR12MB2616.namprd12.prod.outlook.com
 (2603:10b6:a03:66::16)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02cf24cd-3439-41da-97ce-08d785156071
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:|BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB277595098A17227FBBC55385FD2D0@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(5660300002)(6666004)(66476007)(8936002)(8676002)(2616005)(81156014)(81166006)(478600001)(44832011)(6512007)(1076003)(2906002)(66556008)(66946007)(6916009)(316002)(26005)(186003)(36756003)(6506007)(52116002)(86362001)(4326008)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2775;
 H:BYAPR12MB2616.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdQE2Jy3/XzYHK4j5U3ZH0ZlqhPB+lXQfp9MhLNZOg9l7SwtL+xUS90PKVcM86U6hP6SNGzWRyE7Ak0dHtn1I/pUXpSJ/hYzIDvOzn8UxC2rHyrK/0izeoihcdGK8MTLnFOy3dzcPDe1Y0mTTjDI1TGyTzRkT7omtY8waaVNSR5aa5WmA2nuN7Z+YvSwJWfL90WMQ74YSpVIE0mN5J6AqjXR3Wq7wuiMGP2OG4+xxVVQWcdIWM2NYVULekXHMXsVb8vMEpjRsMWgC9z6LZSD1iSjIAy7LX3pT7/do5Ps26uskeJ47mgDfiyGj06a39KPleFMEZDu3BRLpuXH8nxKXl6bv8N5vINoNBRifJLMqPEE6MMxb0gTxa2w/3eDH1hDbiwfetE+oUy68FCUNC7ZVRBXA87t+RKC6CGPghEcXcN0XTeZO2DPKL00rfnt3u4R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cf24cd-3439-41da-97ce-08d785156071
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 06:25:16.4793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEbj1urAjs97nHM9mkRLdUUc0sFshDzEXQdmvx/d7Wcwd2ab4N3VmPDbscDyrrDb/lyf4beGlbFQ4oNsJl84Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
TLB flush method has been deprecated using kfd2kgd interface.
This implementation is now on the amdgpu_amdkfd API.

[How]
TLB flush functions now implemented in amdgpu_amdkfd.

Change-Id: Ic51cccdfe6e71288d78da772b6e1b6ced72f8ef7
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  8 ++++--
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d3da9dde4ee1..b7f6e70c5762 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -634,6 +634,38 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 	return false;
 }
 
+int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	/* TODO: condition missing for FAMILY above NV */
+	if (adev->family == AMDGPU_FAMILY_AI) {
+		int i;
+
+		for (i = 0; i < adev->num_vmhubs; i++)
+			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
+	} else {
+		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
+	}
+
+	return 0;
+}
+
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	uint32_t flush_type = 0;
+	bool all_hub = false;
+
+	if (adev->gmc.xgmi.num_physical_nodes &&
+		adev->asic_type == CHIP_VEGA20)
+		flush_type = 2;
+
+	if (adev->family == AMDGPU_FAMILY_AI)
+		all_hub = true;
+
+	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
+}
+
 bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 069d5d230810..47b0f2957d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -136,6 +136,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 				uint32_t *ib_cmd, uint32_t ib_len);
 void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
+int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 536a153ac9a4..25b90f70aecd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -32,6 +32,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include "amdgpu_amdkfd.h"
+#include "amdgpu.h"
 
 struct mm_struct;
 
@@ -1152,16 +1153,17 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct kfd_dev *dev = pdd->dev;
-	const struct kfd2kgd_calls *f2g = dev->kfd2kgd;
 
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
 		 */
 		if (pdd->qpd.vmid)
-			f2g->invalidate_tlbs_vmid(dev->kgd, pdd->qpd.vmid);
+			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
+							pdd->qpd.vmid);
 	} else {
-		f2g->invalidate_tlbs(dev->kgd, pdd->process->pasid);
+		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
+						pdd->process->pasid);
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
