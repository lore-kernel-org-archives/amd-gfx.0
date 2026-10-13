Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E8CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E7B10E75E;
	Tue, 13 Oct 2026 09:22:19 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A5010E791
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUceREnpV1c5ScAahbuRbdICYaC95mRAHCqAwH+i95zu1e3KeO8AhDhdEsrEmUdpJzcidjQ/lkXSHiPcX5vsWGbqxni1k65+O7LqrcYooWwUoiMZwtmujcM6j5fiATgExoMj1Is0fwrHBsjFheUwuLqqRAPl1aGXGS/pFdxFAkR5U61GquCnTpMbeEgvTJhDprsnHkX4tGQVZPpnyZVj6663bgUphP7WCKVCY7k5i69at+GO2qrlPpLQf3YDN4joeVMhgWCWgCIQKKbES9wXb6/NgvKcar8U2V3bQe9LYbnlG2gloY0pcHwvxZd++4U/D34EMFRLO3GvhThy9ASdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8JArCqRPJc2FfQvjFe0cw4FSXjngsnUwg+RtypeBXs=;
 b=GmhPZZIvm/OtIwfHfzhcjz9Z6hX6tJ23X4CptqsLokub0Zxy8S0Mp+ec18hbI8oscWwY6IN1A7Ptbdv2L1/333mPx5B8vOt5AWtIUJTjicjZTxvKH17qoWM4FmUUVTV+mdmgCEdi+8F4kox9zf3z/SHif0I1fKb/CnvAgSjsM3HQN8dFUJodJjt5xxby0QB+xTh0HPAqdLeWyJsVdJLU92MB0qQR1wVqpy61CQOB1s1xeQ2VzKJJL8t9R4L94K+EdLEdOY37HWdXv1hFFCtzPt4REfjcgx4hLD0FNv71IWA559ou4dRYR1/f2WsAqxQKs1/M46dZ9gqGrmDFV6DDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8JArCqRPJc2FfQvjFe0cw4FSXjngsnUwg+RtypeBXs=;
 b=bWL33cI4n0JcL9TZFPa8NUyT+kgNDWOSt8yAMttvRzL+01kd6idVvJ0qsIYlAd50OvEM5UiFz5iFdqoHpBJaDhhrpCvhU2FsJ1vpO9cpXrLQ7WCGkAclx0Fu1F1ogZUdm1RqTqqDDZwkTO6Jeg2UHpXKyo1oTvoyDK+serpjPF4=
Received: from CY8PR19CA0003.namprd19.prod.outlook.com (2603:10b6:930:44::12)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 13 Oct
 2026 09:22:09 +0000
Received: from CY8PEPF00000054.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::7c) by CY8PR19CA0003.outlook.office365.com
 (2603:10b6:930:44::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 09:22:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000054.mail.protection.outlook.com (10.167.247.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:22:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:22:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:22:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 04:22:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: split vram_pages of SVM ranges prefetched
 without a GPU mapping
Date: Tue, 13 Oct 2026 17:20:45 +0800
Message-ID: <20261013092158.2261502-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000054:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ad7981-8ee4-4488-742c-08df290b7493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: ew306oG3nQBsScvfJdqCYUUwQ/44h1klBLAE2VjvJEpM+2alIYHPkr2WfK/AB4GYu2rXAxP7vMuHRze3qyx2QsZwZx+5RHcSIEf/6Q7FaLcqBN6cDy5se6gSn0ELxoIuExByasU4yomVOyeomZtDOZh69FK64YAhjtIUN4hJ5T7Vxa62dYmGpEKkEuOg/gr0PdDsCK9lPfCsI/Y6E3oiGvd5YOaTTz1sb7QE+evaAoc+ubXahw9aIv09fvQ4mFtCDYMYxJxK+Oo9rTooQR3XCMsUBHLxVUVSlG/mXHFT2LaX61k9qCalJu5tROtK+dr10nvOEcI0NZkvrncijsowbyBhfwdJfkcD1bvPUnKOHnbpqfBUa2iI0G6dGR0LxhjOuUmRAyQ330SUocrA+SEW5oS63d+obhkVD9zS0yShkII1rXYOsHpl0mOLeF3f0h+KEgQhMNslaykjjfJ/hDGKPUTopVqAbdWesvLLtq25N5CzonPUqNdFxzo/nnF21MWm6gHSNi6Db1+KNzQUBgNNp6ySaUY/972zEtmcb8X39GGXi7pXyMErm9LmGLnF9nRQtmfm4EQyldldfol5QbS+H8RHamXXzTMYPb7nlRYQe5jqmlaZuwR2BbVYboXYcAzrK8RBqzfTqqqMt3AotSvZAwfTGSetelOUMfnrVwtT0bcbfjEYLLt2DamsjOOimWHn0hAVPNcXX+qMerHahBUBgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZBL6BovW1l6bx6IX3lPv+G7EzDqWjmPc012bBAWQqh3gkmYXi4W2VsK8O3ppbdsl4OpVdnaIWMdZVB0toOgHKL9rD21VzuIGwRkeWOg+lHqD7Oi92xFUvZGJ6honiOuHGpbGknxRJ/HH4Z5QK9jssGei0y6mSp3C7LeGXxMbrP9EdzWM272sSOkdn0/4DnPM4ueAv3/sYaW2pBdJCNEfca68xVJrjSBkE5MzrYprG7DwchZxHHC6G+/POxFG9UUhhsRbON/RsZ0vOWDMBEJJqOmdb/L4d/D62OA/gUjRPvg95LP8MM/juEYe5cc/l/S0MdbMAX2nIQQcjPtgwFWtkCK7NYPS0KWb7UT1peCpO9mODKt4n/HBUpJAqJOuJcb9vl2WZWQ+XmCUAEAIPljBh6e6LLBkVWZVGFd52QqVeUFau3iwhXBuTHPnG9GQcLX8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:22:08.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad7981-8ee4-4488-742c-08df290b7493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000054.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

When an SVM range is split, svm_range_split_pages() gives the new range
the number of VRAM pages counted in its part of the dma_addr arrays and
subtracts it from the old range. Pages migrated to VRAM by a prefetch
have no dma_addr entries until the range is mapped on a GPU, e.g. with
no ACCESS attribute or before the first fault, so the new range gets 0
and the old one keeps the count for both.

Migrating the parts back to system memory then gets the accounting
wrong: the old part keeps a VRAM page count after all its pages are
gone, so its svm_bo is never freed, and the new part underflows. On
navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
the upper 2 MiB and then the lower 2 MiB back to system memory:

  Recorded vram pages(0x0) should not be less than migration pages(0x200).
  WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]

and /sys/class/kfd/kfd/proc/<pid>/vram_<gpu_id> stays at 4194304 until
the process exits.

Without dma_addr arrays, the split is still exact when the old range is
completely in VRAM, which is what a prefetch of the whole range leaves.
Give the new range all its pages in that case. The warning is gone and
the VRAM usage drops back to 0.

Fixes: 006ad514a50c ("drm/amdkfd: Use partial hmm page walk during buffer validation in SVM")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1f5d73f0ebce..7680fd59ecff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
 {
 	uint64_t npages = last - start + 1;
+	bool counted = false;
 	int i, r;
 
 	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (old->dma_addr[i])
+			counted = true;
 		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
 					  sizeof(*old->dma_addr[i]), old->start,
 					  npages, new->start, new->npages,
@@ -1030,8 +1033,15 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc) {
+		/*
+		 * Pages migrated by prefetch have no dma_addr until they are
+		 * mapped on a GPU. A fully resident range still splits exactly.
+		 */
+		if (!counted && old->vram_pages == npages + new->npages)
+			new->vram_pages = new->npages;
 		old->vram_pages -= new->vram_pages;
+	}
 
 	return 0;
 }
-- 
2.50.1

