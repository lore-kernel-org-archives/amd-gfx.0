Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E48C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F107610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F107610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C686ECE5;
	Wed,  6 Oct 2021 14:32:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C046E523
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdlJcFqMR/xzzNkof6mYUn871NB62JFmL1LFB1mys1VcZpCRkl6OrKM5cI2OdN6uqDvDXyk+zjLHvznqJPiXhPG6eZgmMiOGFPb6IZf5tfxX54gbeCE5DXZJPhnEvSyqpM42AGTDeVML0xW6XE82bn+mU+HOFXBbWLTYRgou7jhsqPU3YTEn2U/kqo4RB9wf322DFvecOmZE8UDCPeG8ATGdxvg4sXZKa2sIGEm/Ykski2qvV6TGjm6DEjPkRF8IjuAD2ibLFK8IqSV0ntvj1DfnMko7a3r/4SZ9+t07HnmoFTGsEe/TaDltC/P/bXfx/W3Bg7IFRoqxWiYtbXrOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUSkPfFHb4PNQDV/GxczRLiIOeeF7mJJKkhEAtPANKs=;
 b=M6wLIUWrRFMPbo+yOqnWLJqG3i4ch2aBy5Oy+bLatGkvT/Os41wmyVd196vxmeRQ3pkF2bGYZXAesI8uuhnp1kRht4mi2MuwZBRyhn3VqEHClxNPYKA8tehgqKQRL39Rul9R9RK25+IXcRpnu3uvGbcLvFZ4H6y73cxPQQXhCuh7YfHfAu/jkDbWj/84Sl7bNhg5Yv6q15Na3NwHFmk69Yh0sPgiTh2HSufTW0/1O0D39mMwPzZiZxozys6KfDE4tdEsPUUbMSvyQFA3gcJVqOUAnqTmC+DjkUJZt/7wGJEldiyOh+LQuP//qk6tgUSJSOZk2O1Rf1I+kOETBK5ANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUSkPfFHb4PNQDV/GxczRLiIOeeF7mJJKkhEAtPANKs=;
 b=yu7MhAwo4YrMTpq/aLwybqlXhtWCcnq4SWG5/Te7//Hx4TrCO2XXHl+Bno+yqZ4/D0LNKVNuZW5MAyyf15hFCxrsgjhjUKZRp8rlvcoOpgKQvhy/aOfNQw6e6MDC6DWWls4WzSivdJxol8lxmLYmHETJV6u5lERVVfHFarmFzac=
Received: from CO2PR04CA0114.namprd04.prod.outlook.com (2603:10b6:104:7::16)
 by BN8PR12MB3554.namprd12.prod.outlook.com (2603:10b6:408:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 14:32:31 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::fd) by CO2PR04CA0114.outlook.office365.com
 (2603:10b6:104:7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 14:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 14:32:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:32:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: create svm unregister range not overlap with
 userptr
Date: Wed, 6 Oct 2021 10:32:10 -0400
Message-ID: <20211006143210.4954-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211006143210.4954-1-Philip.Yang@amd.com>
References: <20211006143210.4954-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf0527eb-79dc-41c0-7c20-08d988d62106
X-MS-TrafficTypeDiagnostic: BN8PR12MB3554:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35549DAAE144E945A8AE0027E6B09@BN8PR12MB3554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taVbua1ZMwaYKLY7JvD2K5Uc2MTEI1Wswl0y6rQUCZo60ylH2jj+uRNU8bq04MRW0tVcKF0zwiDJ94vfMzbEgnexS6yXuWGkh9k/r4tEU/hbUuVpKeNZysv56fWEPgUO7iiUE+F6a1DCgthwMxyqJzs3MMKDHsETXCSPvIV6jNOi+ogQ5RB6p+1+nwR9McBlVGuhPJf6c3XU5eLpofv6qUObq9BY/SS7iu8bRN3J9SjVlSQ5heFbUjbO1PxsARplyCR+/PAVm0LOdfW0gRdibxd6W6QcFL9Ze+G/Il5yB0Ym++uwCGanEz39+Al9q15xKAp+R4Osp5UmB6ZtsAFTtsPBgcp8niSYet5bJ2tN9zNV0Az9ciALtrrRD59KiJ4rpnS9t7iqjZSsPAoG82o3EghC3SOzv8VqqD0hGOzMx6WZKJ05V/emBzfz9BueJMInNoD8m9fxG6XZKnG4qtpnFOPkfc8WzVJjAoNMVHRzylHpEAlEtSzLhhmMsX9/3INTOysQH3Nx0vbZ5DbOveW7rSj5RTQkC9aLjS3NJY6wboI82uhQ8bahDjm4EfsJQayW/0yd7iuDFVTWdAw2BDuTxfnR8kRu0xMP92qXloH8Gbm2FcX6naZauOQLXODB94H+RcwL/LO/ilUQovnsAC1dCpECwCZZS39uluZRbCgWCnO2PV2MSt2igYvUcjuZHFlTxLorMFLFyz/onQjCdSWOb0A5W6hhuzQKhL5EaC9ha10=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(7696005)(4326008)(36756003)(70206006)(186003)(8676002)(82310400003)(5660300002)(6666004)(1076003)(508600001)(2906002)(83380400001)(336012)(81166007)(70586007)(426003)(26005)(2616005)(47076005)(8936002)(6916009)(316002)(36860700001)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:32:30.6658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0527eb-79dc-41c0-7c20-08d988d62106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3554
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

When creating new svm range to recover retry fault, avoid svm range
to overlap with ranges or userptr ranges managed by TTM, otherwise
svm migration will trigger TTM or userptr eviction, to evict user queues
unexpectedly.

Add helper amdgpu_ttm_tt_get_userptr because amdgpu_ttm_tt structure is
not accessed from outside of amdgpu_ttm.c.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 13 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 28 ++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e2896ac2c9ce..93952e1bce5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1251,6 +1251,19 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 	return true;
 }
 
+/*
+ * amdgpu_ttm_tt_get_userptr - get userptr of the address range
+ */
+uint64_t amdgpu_ttm_tt_get_userptr(struct ttm_tt *ttm)
+{
+	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+
+	if (gtt == NULL)
+		return 0;
+	return  gtt->userptr;
+}
+
+
 /*
  * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e69f3e8e06e5..1dd1a882280d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -186,6 +186,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
+uint64_t amdgpu_ttm_tt_get_userptr(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
 uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d49c08618714..a2eb21deb06f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -45,6 +45,8 @@ static bool
 svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq);
+static struct amdgpu_bo *
+svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last);
 
 static const struct mmu_interval_notifier_ops svm_range_mn_ops = {
 	.invalidate = svm_range_cpu_invalidate_pagetables,
@@ -2308,6 +2310,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+
 static int
 svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 				unsigned long *start, unsigned long *last)
@@ -2355,8 +2358,8 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 		  vma->vm_end >> PAGE_SHIFT, *last);
 
 	return 0;
-
 }
+
 static struct
 svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 						struct kfd_process *p,
@@ -2366,10 +2369,33 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
 	uint32_t gpuid, gpuidx;
+	struct amdgpu_bo *bo;
 
 	if (svm_range_get_range_boundaries(p, addr, &start, &last))
 		return NULL;
 
+	bo = svm_range_check_vm(p, start, last);
+	if (bo) {
+		struct ttm_tt *ttm = bo->tbo.ttm;
+		unsigned long bo_s, bo_l;
+
+		if (amdgpu_ttm_tt_is_userptr(ttm)) {
+			bo_s = amdgpu_ttm_tt_get_userptr(ttm) >> PAGE_SHIFT;
+			bo_l = bo_s + ttm->num_pages - 1;
+			pr_debug("overlap userptr [0x%lx 0x%lx]\n", bo_s, bo_l);
+		} else {
+			bo_s = bo->kfd_bo->va;
+			bo_l = bo_s + ttm->num_pages - 1;
+			pr_debug("overlap range [0x%lx 0x%lx]\n", bo_s, bo_l);
+		}
+		if (addr >= bo_s && addr <= bo_l)
+			return NULL;
+		if (addr < bo_s)
+			last = bo_s - 1;
+		if (addr > bo_l)
+			start = bo_l + 1;
+	}
+
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
-- 
2.17.1

