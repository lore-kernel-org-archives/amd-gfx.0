Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD5C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3733E21D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2MY5Txs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3733E21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE296EBD7;
	Fri, 20 Dec 2019 06:25:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8216EBD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 06:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQQxjsrYndK50ueGEFw2ckjLWgyjFBPaxkBv9rEJK0QkuwLhkkOwjBFXQ2aia4mrgyvVbtYCkJwG6dwMMYaW1IKdHx8EKCmhdND7dQswuiv/rskCxu3Xzqd/AVWHE3LTQsEQCPrNzgz+fRt9AceD88hrv7fghSsH8OCzT4aSxYE+XcZBZRN6mdIMI3hhkkFy8EaIH3xC7UCHo7Y6ukYv66Hu5EZw+HEKEuuxcyXgcbEfC6I6N3O+AH12yPZ+ABY8jxhnfUtGGL947JNebzb+9W8WkJvKHahhNKg7l+y5stjSD5qL5kS8ihp3XNliD6YNwYksr2TPf4tTfXt7WzQddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGlQaGIZzzR5mKcVu2eUklh4TFxnb4DlKY/zbdeN0Nk=;
 b=GFeD0EjihgUrgnE6MTYxuZTh4vBn4F/6MZjp2T7BpaiN0EjJtkEJIUpVkyyl8jGoP9MM3e0lpo5FNDRZi4mlFpEztxJDosFRZlXCLZnHBo4+A6flktsC9XzidaoYwvtI5zbv4wM/3KtXLN9NPgvhIpi1vMTfnsmHmdpjdTua0fCNoV6BS+8ElohO/5g9A7cSNs3j3EVrvFYNP+6apCT9WTsDwhwxkh1ZaX+gqa56QeDlPt9kKgai+EP2oxBc8BwZGiuGrSjd8bTTOsDZRYjwD0ve+ITWPn4VKdbY9qnkYH8a3kluTJMoEGubToad8Ta3mjJk4NVs20EeYM94qs9few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGlQaGIZzzR5mKcVu2eUklh4TFxnb4DlKY/zbdeN0Nk=;
 b=2MY5Txs9h7eW5y9+VNOkF/3Dm3U9jRC2UMO/CCuvJcdV2SDBeWhO2SuWqQ9b0tZOUaVLthCbwKwLRAjmMaqnqdKXpQbksM6c/VtuW3kP4xsX+iqt26yTbVt61g4Huhk0fVSz6x/+5HHj2yOm47EzVjNCuyCRk98CQtaxO11dYMA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from BYAPR12MB2616.namprd12.prod.outlook.com (20.177.124.144) by
 BYAPR12MB2775.namprd12.prod.outlook.com (20.176.255.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 06:25:22 +0000
Received: from BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e]) by BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e%7]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 06:25:22 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: invalidate BO during userptr mapping
Date: Fri, 20 Dec 2019 00:24:42 -0600
Message-Id: <20191220062442.33635-5-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 754449a8-13ec-4cc1-043a-08d78515642d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:|BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB277568FFE332A98A91270CD2FD2D0@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
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
X-Microsoft-Antispam-Message-Info: WKWTTsAw6pbgoj9XJcy9RLMpsS0PUAtOhyC5Ol4B1FIptvQi/CSPQx83TVh3UnRpMWxvxbtlQo/MQ6QMxiwl3VoFwBi4hsC7EuQoId/OaoMS50tMj3JN3LJUah9aaXKeCM78nQeeLQhwxRiTmIaZHt3AbtZuclWf9S3KE7WkMqIaVnVkm2FdjBxLh6IlRrZzLFLE/b/vTNDkxa+znVJTWM51HYCJVKsTg85LQHQlAKY6oi+iTUD23rF6W+1ZEwGY4TGKdVfigjGENbIzpkQRN0Z4Udl5ecm5CYNSGM90ZI4/5uD9b/1Mn4mHm6qL+HrGt86dACuEbwCziqPBNplpGEsfKu8y3XmkCjr6uApd/hSzHStaL7Jz63oZCUrQBon1T94kvBsm/FUXMEC8h6HlrhgdXmNc/geMocGcBbTjTLO9zgwQiU7GIjftXP9E1+mK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754449a8-13ec-4cc1-043a-08d78515642d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 06:25:22.5659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StAi/R3dyL3hT3fPT5WEwvgL8GuovP++rBaoYgI4WgjG4Otg4Q2FZNY5XD1pD4gld5bKlsGRvdDcLYf+VyQzxg==
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

This is required for HMM functionality only on GFXv9 GPU, which supports
recoverable page faults.

[Why]
Instead of stopping all user mode queues during a userptr mapping.
The GFXv9 recoverable page fault is used to revalidate userptr mappings.
Now, this will be done on the page fault handler.

[How]
Invalidate buffer objects that correspond to the specific address range
on the mmu notifier.

Change-Id: I94b8fee8d88ff240b619cba1c5458aba98b17736
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 56 ++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 392300f77b13..06415d8ad3c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -187,6 +187,45 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
 	}
 }
 
+/**
+ * amdgpu_mn_invalidate_bo - invalidate a BO
+ *
+ * @bo: amdgpu buffer object to invalidate
+ * @adev: amdgpu device pointer
+ *
+ * Block for operations on BO while is cleared.
+ */
+static int amdgpu_mn_invalidate_bo(struct amdgpu_device *adev,
+				     struct amdgpu_bo *bo)
+{
+	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_bo_va *bo_va;
+	struct kgd_dev *kgd = (struct kgd_dev *)adev;
+	long r = 0;
+	long tmo;
+
+	tmo = msecs_to_jiffies(100);
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
+		bo_va = container_of(bo_base, struct amdgpu_bo_va, base);
+		r = amdgpu_vm_bo_update(adev, bo_va, true);
+		if (r)
+			break;
+
+		r = dma_fence_wait_timeout(bo_va->last_pt_update, false, tmo);
+		if (r <= 0) {
+			if (r == 0)
+				r = -ETIMEDOUT;
+
+			break;
+		} else {
+			r = 0;
+		}
+
+		amdgpu_amdkfd_flush_gpu_tlb_pasid(kgd, bo_base->vm->pasid);
+	}
+	return r;
+}
+
 /**
  * amdgpu_mn_sync_pagetables_gfx - callback to notify about mm change
  *
@@ -250,6 +289,7 @@ amdgpu_mn_sync_pagetables_hsa(struct hmm_mirror *mirror,
 			      const struct mmu_notifier_range *update)
 {
 	struct amdgpu_mn *amn = container_of(mirror, struct amdgpu_mn, mirror);
+	struct amdgpu_device *adev = amn->adev;
 	unsigned long start = update->start;
 	unsigned long end = update->end;
 	bool blockable = mmu_notifier_range_blockable(update);
@@ -275,11 +315,19 @@ amdgpu_mn_sync_pagetables_hsa(struct hmm_mirror *mirror,
 		it = interval_tree_iter_next(it, start, end);
 
 		list_for_each_entry(bo, &node->bos, mn_list) {
-			struct kgd_mem *mem = bo->kfd_bo;
 
-			if (amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
-							 start, end))
-				amdgpu_amdkfd_evict_userptr(mem, amn->mm);
+			if (amdgpu_ttm_tt_affect_userptr(
+						bo->tbo.ttm, start, end)){
+				if (!amdgpu_noretry &&
+				adev->family >= AMDGPU_FAMILY_AI) {
+					amdgpu_mn_invalidate_bo(adev, bo);
+				} else {
+					struct kgd_mem *mem = bo->kfd_bo;
+
+					amdgpu_amdkfd_evict_userptr(mem,
+								amn->mm);
+				}
+			}
 		}
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
