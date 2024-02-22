Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB03C48BEB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 02:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619EA10E84E;
	Thu, 22 Feb 2024 02:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dGKQpWrM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194C810E84E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 02:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln6NzJfx1SUPJTUNcURIEZebtW/zqvBIrh75AuJhxK9gxGdmHEBCt5990dy52kZ7zdtB2mwiCY/BlNjIVwangLaAW7Q9bxbwWng0RzZe5Ze/Gir+SSyYAWoD6TcZeLruzGZ43s/oML9dGHZJ2wIay6mv1+7BoWXSNMfAyDSoI/nd/9fD9qYdwvfOiwY12VUnPvfNed3v77bt/AgNBQ7PwVT6uAEmdah067kD32Et5JTz8QTin0JVyI1D6YkPZl9zVqQ9U9IXw66cGlOHTY/CB3/19iPgeEzdmcWZRklZIzJAlQq11mRXUlf8F6/15Zm2BDOvmpq+E+naKuMVfu49jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ujICM443dh2Wy39V4822lrRm6O5VpmR6fOmmiRZCc=;
 b=SZJWiEF1cxYjJR9fsV0TE5trs/TjdBs1JeOC/HTA9lbvAwCkWIDC9FUig4cg08ZM5DusjaFv6h9aalxtca1iQc/gxDiQkxHIl8kuD6BRpkdkWcrv7krS60nyF43a6vP8OW/pXV2hrdb+b1ho8CXVKIt2ZJSbngGin7cyX9QW8FvTgJCcFQEJ2TbEF4UQdAunJw8CBojuv5tVQ2F/9YiOjnJLjSFxbP+/tV5fIEymyaRQJFRSKr6mXSUJLp/507n7/1t7cv5AUXXjG/PhRxnLhBPM7l6JNI/pvQZN2/Exzs6WV1Ni1kgu9JVBBh2D1Dh3LbcS2W/x6djCoHHWe1LsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ujICM443dh2Wy39V4822lrRm6O5VpmR6fOmmiRZCc=;
 b=dGKQpWrMehvokB+0ClwbPkOv9GhQ8/c8QeTK0jZHiBn9fbNTTZgYipvWMRqeIDbA580kEqPBf4SJUTV0Z8IfpXN2xhSElpr1w6h2egJr4lGm76WdDovyUua8e11n0nplkNMP6yn8BUf8uRt8zrr0l4TSz8qGPkOazHWZd6TpIJs=
Received: from MN2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:208:178::40)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 02:02:27 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::e) by MN2PR19CA0027.outlook.office365.com
 (2603:10b6:208:178::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Thu, 22 Feb 2024 02:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 02:02:23 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 20:01:37 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: break COW for user ptr during fork()
Date: Thu, 22 Feb 2024 10:01:24 +0800
Message-ID: <20240222020124.1302449-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 635846e6-342e-4ef9-3aac-08dc334a4fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuZnYxorqwSG1lZv1RejYOUFqQewv/Evv2xoGcCr2ziXWkjf113p2nSmGi1pT9v8lJ64ZJxU/Q+ASnfegFevrcsWCOWmqjF0amHkLWbzq/AMibYeFIQakOMu/twKd5S2J/o9qofNvs3BQG8VQSQAoqtFsSVIDS2f0WfOGjRqci9YhkNONaVGhYPDZqZhIwxFWB3LFdO4XPDval/XLf+Ye7NEPsoqxHMRcQNOO1TpSKEeTRwrnlQs6Sc9m7h83p4mNtRZFOvs8PTghFz3IkCDFsuf5ZVsoPdWLN2iFu+pq+9h5jURnzrIFauZl/BKw2RUTqsOydoK1S/y8enee1kxZCAXSF5PLh0v9YVcndqynG3WeCTPDQU/RkyaHr8qvauAUY3Kzh3WAVMjDEYGoggNaSQ4WlfjyIru7EEzaCAW2pdPYPAkxINqf9qp7GwNcHkMgJodrpVjkFodWtYRmlD8nKHH0sVJYZK456FWOs/vnXKl52p8Y8WPFfcP5OiDP1R+wkbeoEcA0XdydhqbrAagxfg2awothw5H3m6Gza017UPk0ve8dAUEfIs3I5OChGfQIa+SMbOOBrEa/u1A1mFwPH9N7/8pig+lKcODbJoVzGENEiSxSzKTjyreo4Gy0WotYBhjnbF8Wb99ADBPSGATuikzBtM8z1LhjVrU5hVPtkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:02:23.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635846e6-342e-4ef9-3aac-08dc334a4fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is useful to prevent copy-on-write semantics
from changing the physical location of a page if
the parent writes to it after a fork().

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a..2ee0af3c41b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -693,6 +693,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 	}
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
+	vm_flags_set(vma, VM_DONTCOPY);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
 				       readonly, NULL, pages, range);
 out_unlock:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6aa032731ddc..607a8f68f26f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1674,6 +1674,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			next = min(vma->vm_end, end);
 			npages = (next - addr) >> PAGE_SHIFT;
 			WRITE_ONCE(p->svms.faulting_task, current);
+			vm_flags_set(vma, VM_DONTCOPY);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner, NULL,
 						       &hmm_range);
-- 
2.25.1

