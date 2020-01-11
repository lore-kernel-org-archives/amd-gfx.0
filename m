Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C9C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E318C20880
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4QTIezGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E318C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00486E248;
	Sat, 11 Jan 2020 18:40:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D746E23D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0m0aHseZRNhUYdBnfliLDILMt1Z0CFZJCstbdtf+kmLfWbLvAkbzDRVoCnq3eytp3K2DDtEsgdmpNoppLTwSakCCRiNzdcJdWwhNIAKoiaaJgEEaI8QrcM8ksH0gUziP40wrO5Ksi9/Lz8KHWAwf0Ch7Pid0SSfKQzs7XiyAus0aoTIITtdtLv0WH3j0AP4HPP15KVnXjtpmoEB6KR7uxOWC9KBVN9VH6vK4l5n4hRI+BtFONE7q6NyHraJV4UOwSQYiaJAv/jMvzAfGzz2ZeUobihVUXX6l1/FDLjvi9L2aYuGF2vDbqT9sIXgUHUBylKSz8xA77jucVNta7rN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhOPaHJLzlXUQsIeAtAk/05uanJNKT0B6lGVfpILQJE=;
 b=IS8F6bTnbWtqKt9YeOVwA55hC8gRCRGXE8tEvJw6+ayGjlAKcsyyJvTWvz+Qv5dWthRRPoEX1Cy9Cs5N0bZbMARVqkPduHGb+9CkKS75uTLYfM22bKPo4l5W/8+51y/FyArgL1r2P3Hh1XKyUxcsW2DquPnHrGf4vdpjTbjuMC2YVJ+0mKU+1YUcagrVkA2Q4VW8ZaX+9myScuUI9xkAKt1XrlKr4022LCrNlOJdaiBMCcDk4iMiOwpteVu/K2Jz+WgYz2UA7igrisKnGflegOnu6rijJgGJm8sQ51I0iGpxoEV+LZG/geCcTEqrthr/ODxuKCMj9Q2cIJNpAsXffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhOPaHJLzlXUQsIeAtAk/05uanJNKT0B6lGVfpILQJE=;
 b=4QTIezGO+S3yyUOHJYN89c/D3G9zi83lhKSrTaPfPyd/4C/8iD0zmlgx4pt5zNjuqwfEYnPFPIU7bP4RRRoL/lunJGY47KY8a1QYEencd36j+OYDLyG3tj3P2lswmD4p9P0GKWCtVw8rj7qZ4sJnm+U3QispnI5Ol31HUwKA2+4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:57 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:57 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
Date: Sat, 11 Jan 2020 12:39:37 -0600
Message-Id: <20200111183938.126310-6-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200111183938.126310-1-alex.sierra@amd.com>
References: <20200111183938.126310-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3372351f-8e6a-402d-9245-08d796c5a720
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814AC7F9731C40DCA095FEFFD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aa/3EzMg9T3RltAGhdwro/KYPdEH+7KDs79mpAG6IoEZmbkNiUudYOaWlvRXtCZ+HyUofYpzrv4/D/xwddY2mV6rUD/RqSLr1NmjUKCQk+dDioQWnZHgR4opTr4F3Ge/Vj0oR6yqRxXhON8v0/OPkN0ohOp972hYyIFGY6sRO5o28sTAGWPEEEOAdDTLxx4ohB7D8S2jg3jseg8dc/TuwHrZPXRuvcgMojMlxNgVqjnYa1rMiYnXYlO9B4DlJsuvMlaCVMdMfntDcDKYGZC8ZX8OvIL4MZCX5qrdOUWmF4ISSBr7w823fy/BtAIu8bNtIDpS4ihIEVTxY4jLTOJG69D627xWbd+EzifLZTBxKo33lSltmHtmNBWbP+19jGmBDhO6W1m5IJNcLuwWhsd2WmFv3mJ/LZF1nae7D6he1OVzaJvXJhF2tjhz7TRGR99M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3372351f-8e6a-402d-9245-08d796c5a720
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:57.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKVL0Uja6iZeMmGynoYVrDbQk1oriIXN7V/pBMOnTWnruaHDFsdYGNE7IgDf4Oe3wW3AsqqyQ97ax063UxaaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
index 88e10b956413..8609287620ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -628,6 +628,38 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 	return false;
 }
 
+int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+
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
