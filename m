Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3667CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 09:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862B010E570;
	Wed, 14 Oct 2026 09:17:20 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5967B10E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ0P3Zv8cxptN8vsci4T3iDPAFlHGKg29/mNnGqwnljQLsM/8p2fEmiVkTRJnZAbGHJELQv5q9ReHrBDgiudJYs25VRk8U404FcRT+61ROrp/vXHzrbBV6U5jFEd5JPAFUhgRCxZbKgOxgcDIE+rkpK1GA3yIGlscxn0rHkvzfyLiXprIeA1lSI+DGBi3UEfbxpYXM0gizo5z3/aMN/TVLGKgy79yOMTE1CNgY1Uk9LTkxIiOQIL3JheehTMI5abWQEdC3KbV+UB7zqVOi8uDeLoXpJndwJQUr5XmN6CL4vjJbO0uqp5c4aIHKF2xmfKIot8mqZYS4RBjxSBwITNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3ec3Fm1e2B/soGFt+aSLSm6BzPKxbcTUKGO1l0FuW8=;
 b=QbRa4sIKDcbpl+nQNQcpUkZ8foxjoW+mxoWYXFXCbxnmYPd74dxsiHVUx2iUwXcrPhx2tEuBuOeN31PFJdy5ZJU3KghP2YUX2xozHQvAzVtUHa0008JKp/CPXBQgWBs+whw73Fizp54t5BpKy5G5kZfAC5X0DmkNuJICcAGA3MhatwQYTe0PrKI92OMCUzfc6zcFgFMClJzA+v7mKHg7SBRqXdVG0IufMgQXHDoBq+hjJ9FrHzFDnFqvfP98tZVYSE5SYHSWk0MISqFso4PhffSqw0RWqKSWH3QQTALWrMrkNR+ivwNkoPTwo588sBl+iic6lLYGjn8bBCWmy0Y90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3ec3Fm1e2B/soGFt+aSLSm6BzPKxbcTUKGO1l0FuW8=;
 b=j6bb7d8XoE9y++UV0WJllZPAKwHOMCXFhmPRrCqb29KdKeVYNfWQpsmGBANurM7GtCByBt/y8sb3Q17quqB9/6NVX8kH4pwTjOsOOwozu/XQtLK7RsB4/XIxZutXXisgXoRRVRfWkNzvj7MmdV3bMsoDlTc+u+i2oh9c7sJXXfs=
Received: from PH7P221CA0068.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::17)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:16:57 +0000
Received: from BY1PEPF0002695B.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::3a) by PH7P221CA0068.outlook.office365.com
 (2603:10b6:510:328::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 09:16:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0002695B.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:16:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 04:16:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 04:16:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 04:16:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: check every VMA of an ANONONLY userptr
Date: Wed, 14 Oct 2026 17:14:27 +0800
Message-ID: <20261014091653.2932409-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695B:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: aab31ead-b79c-4663-d719-08df29d3e552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gvvmUmVynbNRHs4Zwo5o8IFwM3g3IkZH/IuVbB1QtQSH+femg26f4Dva5su63+8RvX+dFnFdspw1zje+YS4KfuGTDgSMyTSg3XpRgqMpDOkH+l/nG2+LOYJZBrdtQEX2TpmXotLt5ndZAq8DF7NykEXQgkb5THzFxKvxh74NhZUZdg79iAzvl5sNjZsHqyCd6Y2Q1WBj5p9xdqiKBcVKBfgIYLLvTu+KOLl6lmFLdLFK+QazyzO4rv0E+F+Rkdc2iyguMxeMXcPbcFGvRiOiLsdrEbEc/QgLqGZOS2EzRgZ13Lxdsq9UfULSUjnf/LcPjez9PptQoRf4XK41FQqRTQq3SpejdyAuYgNnpp3NYAkhywvgUKpArqA02f+MGlITR6AXTudGjFYsmrf4o1H+kmu22GQm+F83xfFdbqhPdwLiQiEnmQbIOzaT3kHr4LGhN/G1THGYmhtoIDXtEqPeT2xSKRdiXWl62bGSo7wke737kXVCb1EhRRwObzRLSe4Ddgval8HIQXSRb5BGZUU8I+hk5rhmtozU77GnDxmI1dOuZVJvU5dffmbmC/yLsoZR2RLO62o5X7vEkIByZXmJVE9VrBHDcN/dNHYWXiJi2IsPSHMd9XAN9bAjGzlXQI8GHTwiR4g7iQu8pt3dlYJkoZJU4HjuY6lsTQbgJ4pSoFXz+nA4FP3qy38ksIy7TzPY0c6+O0CL11LbFfD2RchZsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TyyvSI+3ijHVTT2/s2LNvFGMa9g2VKAidOpMBoh3Y06gAt0wqbg96wsc6zIUz+UXUXeXokkQRzUiavc188ukXIxYWJR5npV8LyL43dlVfuPH4f1nAaAuucY5PTbXnhbEurvWYjw5Ib1kcsjzXkG4hIE6HBo1ILRkxgnZ1Cna3mkhlwqJ0Tv8xX5Pys3QnvP7xHnGAo+VibRVgdyAdngy49bomf6N8US2cj8+x3caqlENfeL4+11XIavShuVltLhROR13wLV6ibNkSMGfxJtZ4jIpA3Tjklbnv/fvmWGinGU84Szy0CQ37LDvtXkgCgQ8jAU0709f5SYtJyzBxp/DA3eJlz37sdu6TuIJi8WvHui0n3vBHdji7M0jRWuXY1ZugNrhosvKMXjb7SDH0GiGuHDAz4JvSdeVi4DgOk9s6d9bGqgFP+7x3A/De0/3NKU7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:16:57.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab31ead-b79c-4663-d719-08df29d3e552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
checks the VMA at the start of the range for a backing file, and
amdgpu_hmm_range_get_pages() then faults in the whole range, across any
other VMAs. The check used to reject ranges ending beyond the first VMA
(vma->vm_end < end), which got lost when the code moved to HMM.

An ANONONLY userptr over one page of file-backed memory is
rejected with -EPERM, but one over an anonymous page followed by the
same file-backed page is accepted.

Check every VMA in the range. The second userptr is now rejected too.
Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2103f8d6165d..d113618543a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -783,10 +783,17 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 		r = -EFAULT;
 		goto out_unlock;
 	}
-	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
-		vma->vm_file)) {
-		r = -EPERM;
-		goto out_unlock;
+	if (gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) {
+		unsigned long end = start + ttm->num_pages * PAGE_SIZE;
+		VMA_ITERATOR(vmi, mm, start);
+
+		/* the range may cover more than the VMA at its start */
+		for_each_vma_range(vmi, vma, end) {
+			if (unlikely(vma->vm_file)) {
+				r = -EPERM;
+				goto out_unlock;
+			}
+		}
 	}
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
-- 
2.50.1

