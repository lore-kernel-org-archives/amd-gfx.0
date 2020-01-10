Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484EAC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4C42075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DRhQ4Xds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4C42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEE66E981;
	Fri, 10 Jan 2020 00:43:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01F56E981
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNh2ECXhGopvcjziB1JrX+n5yG2QdeMUCCjhbtQerJnR5kDTJuSSi+2lud9+Bohb+pfyQctzl+4NTuP+X5qiixML+nH3jkDSdz10JKbw3h3CcAH+tiq4CaGR5YWnovdEOIfmXPKGM9rB6kWOAs4WPaaafwkZMvyAVQcGgiq7keog32H3fPqahIGN64IZFaVZrXZyB4o87qMSAMveNh/GU/VwM109lujG8TfVOHwxDzHVr1YkmArvv8zaeiziBnAITc32RNGVh6zsUCpt9/1W1EKF6nz9LLL/wMdhrGV7NTNPdFfixVxIg6DEFcXtpmMj3vvvonUDuVysPBPwK8tKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhOPaHJLzlXUQsIeAtAk/05uanJNKT0B6lGVfpILQJE=;
 b=kw88rUzHLi/OZOb+oiOK4A8ra/hXDIN5isYwIDziuLK004jcno2kccuL5qCbPFHBANICX7ncuJughDQz3M2tYV1OH/Lp9ORSfPfGGwdguD6ArJztEoqKb4Y/f3QOxhm1ieceaszee3Mn6RbyfwYimUjMYGvTJ9LaRsT0+tl7hmJRYuTO2aA9v+FZqOMjEKdJErmDnPoAvBfXOpsDWlfbHOGmBwX5S1VKkoSia19yHLiqbiy5OZLx8RC9LciBSyH5qv4i5b68zR5WgIuhfDrySNJ3zwF+sHqM0S2VCGSdm4m+C/uwtMp4GStR2kaERfdj7xMtOl4+fOpX2uFQtudTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhOPaHJLzlXUQsIeAtAk/05uanJNKT0B6lGVfpILQJE=;
 b=DRhQ4XdsOf+CmdFqKJO/G6GMt7PrARkWN9/ZDiWpaALgrP6gtYoDi/hRx6MSXhcS+lSPi7ZwBHcxVrBZNzfBM5Se38I5NKKYz6duLPrkw9Y8/6nozOrQWB0q220C3WBZM8wV7At+5WOQc3R5BKDux8VnYtLg6vnBIRb4G6fZzQY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:48 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:48 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
Date: Thu,  9 Jan 2020 18:43:30 -0600
Message-Id: <20200110004335.113095-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aea98683-fb74-43fd-f6c1-08d7956627e5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26727FE974ABFA4B8D8C8977FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/8bCIassJTveW65d37OOTquk6iXCDOqD09BgYyBdr47zk4N5Kkp8s18q0rUy4GKA9/vgIaRV9BAAxeE6ajpGc790TItCb5KmHUgLTj47HRA6U9cnkVK8u/CLwX0YQOZvlbVNpTSvd/STQscRWKIev0KREgznCZOqbvmRf+73hNBIuW9S50vWfyHrujoAJWzZNYGp08ce3q7Wafy8aB0BrFyBEi6XO5s6lUcbTvtkkOjumN6TorH2DNxzKHTMnoJ9f3axqCSxUbEPLZhKU+QHxhROczLAp+kKKWpOaWK+GkimFn5jQ5fx9ihvgpVJ9UsdzSKEJzd1o+uEwigt6ZRTX+6lSFHurACdxCkP0xGlfkn6/V+FkpMkXfBcU5AWzHeRWBjJ3CC4JH7s6XujVBMx6nWLQmMJ6YSzovkM1vX8i8ZRtjdPxKb1LEEbtr6XzsO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea98683-fb74-43fd-f6c1-08d7956627e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:48.6918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwsSy9S0PsIX71L5alXJVFP+AeB9AfT4SLpP3eGapZphfsahEDYurYSguzKEc8aYw8739fE22+Vu5nlVVdhEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
