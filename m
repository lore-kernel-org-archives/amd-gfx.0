Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CECD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 02:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DA410F7DD;
	Fri, 29 May 2026 02:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDnX4Er4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B753510F7DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 02:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE/82jVgV+TQpoSREh7R68MjU+VDmMBtLozgV8L9ikVxtesOQgQQrK9gsgygwCobzSUsrWg84dSp5bdfWqagm9TriIT6T126PSUUIEV3PfCUCTQ/BfwjQeV30QhGpeyZPSn90QcS4088uYuMtJjfzoFq7ZdACZIRw2A8I807bwNXRMAsR7sY29CHtGnCsv3b9qIXvhMB2F/ljc20Iq7Ys/kexSc9O7uKpruJLnzoopSoHKyyqGHcdYPNKBVH69ywKRGzrWSaS3F/y4ZEQZOEviRc7vckwyeV/IOaHwY43wYm6x+LhwKwH+C46NFZpIc+wLY1nMqrRgEK2TsWHN0vYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbyYTLlS31YnpW4Brg5cZj1akgcj6vF+nVLUBMQj8cQ=;
 b=XxEGNNcyYDTwC1SghyjuMsyQeZ7N4YMxUcdVKRz1pY+QeWboBrPtiXtUhq2CQI/j0j59nWps3aB2zrZvgiN/xCRKYV6hUMcPSoO2mtKIltFcZ3pimGk3ppO22IOVyNGVhYfH2y0ZwJcpEL16CMqUSebWf1YCe5cGN204YulbLVoCppu3d6QQWIiaNRzFXrVCuUcwf5Kw53H7Zk+iU5aJ6+jaP17WRnQkEq+le/dgTQoQgJH6wL1l2wbCUFc+ubK9AIJItej77HRFPKoEnKROCG3PqYkqdPhYFBmRxb1FFDyoTfOzaegBqaOjUa06zLZSlnKNLUfxLptSA3LJwHc+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbyYTLlS31YnpW4Brg5cZj1akgcj6vF+nVLUBMQj8cQ=;
 b=vDnX4Er4sYjlU3PNeerr/SRnXqn6M08S01s19S1YwEJafRkRe5ZiiUOzuRtjFgZniFjVLuXYDvEReWMtRYH4EOiz4bQDRj3U3DNcx+Vy1JKNOQKnLrMsjkwdY6NNqxLe5OOdnALLvwQM50YXfDzSeQuCb6entiUYMlkDDwN9rZU=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:28:11 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::47) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 02:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 02:28:09 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 21:28:07 -0500
From: Honglei Huang <honghuan@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 <Vitaly.Prosyak@amd.com>, <Jenny-Jing.Liu@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Date: Fri, 29 May 2026 10:27:45 +0800
Message-ID: <20260529022745.552737-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c8163-da50-4dd2-9ab3-08debd29ec8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|30052699003|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 03B4eMu3y1sCARZXGCapAnGVu+FdgYP/oNCFCNsvrFDKh1WUBvU7rTyCqdCEZdpgQ9dsOuM1iTrObhpmb71/rO7Nroj2gv1SEsJ93LRvS1TKB64hJNF794vHdW9Y+4rcllmvRmBWQKygnvg9MCrriDuDNEGau3Lv2/oK0i2b1yPaFHwCpc/osJD6i7AiB6T5eZ2bz/FEmUYuBGvPi1kTrihYhgLim567GEDmQ2sI0/JFuISVaaSXQ0lPKz+AHCwA6mNlfTWOdj9qOjUZIWzOa7aKNfk/6dcIZjE1iZrSnA/h65j4T9+XOcqL83VtIAstm0Ycz3xx3vB2+BMT4moytsmH7a7cxeFsSUsMgHi4Q6NKLHe6bJfX8Cn3ZVSH85Xrvks2nJ+zm1Mpn1QzZ7nolYp7HOyrdHYizC0VepUAtst1+s/sRfoq+pWMdxbjFGKdOXFdlQIo8muegO7sQtdctZlNiJ2uiYBV6Dn5BX+AoVZ4sD9Zbt8jlvPHrYQu+g0Sn7GVq8/WXNaiONnwZk/PW02WOxKdkchXhpUi+OH2IyON0lEHStivoIOCT4HRCxgZhsJgLh5MRMympiPbTsNNoPOC1o8MoUlI9KCI/Ydm88wjqapdlD7P5MMZ3Bz81lmYguCk+IIC6CsXXs1K5JMMlx0n1a4fPKS4UPCBTKQ9A/2i99eh+LheepeTA03xeIyuECtkGM5yh4+rS7KNU+XfhCTsYNyN3Ve6hyTumH/49n8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(30052699003)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: stNnKG3px03TQRFWiHu2LUSl0HepUiphr2gWKN6dJiyvCGMQOtLs22pPsNvK7pn8DHXS6o0WkTlYRX72+XLPPB8yX4q1Zm3+N2G1aNjhIIq6BjDUD7lIJe+GRMiPF9OT4jMM51DdI4fKjZ7qAeoKNQ2VMmhMPqFqruVjP/Fq/xQO0vYEXLZcLHWz/PBmuzHT2ENa4Xqh3KxMkrvcPOfDIF01WV6QIzQxxTX6s1slyFilihcmQMUppVckCvGcniCmUmAknPWvKsEX3fWZ5Gm5S46HcwE9gBL1rcpxC4Nfr79+y69IEc5iWTwQBe99br6umV6Knv17Z+Magzt+SdnSaHp1/yPCFgNMkMmaw3E4AeTzxAQNqabcFWppQoV1VKqPvHUQBD+JMiJlxHlzL5k/KvvRf+1WCX4FFz6fIo48RcniAwEao/OiYTvM+WMhmSgY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:28:09.2878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c8163-da50-4dd2-9ab3-08debd29ec8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
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

Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
moved mmu_interval_read_begin() out of the per-chunk loop, the
captured notifier_seq is no longer refreshed across retries. As a
result, the existing -EBUSY retry path can never make progress:

  hmm_range_fault() returns -EBUSY only when
  mmu_interval_check_retry(notifier, notifier_seq) reports that the
  sequence is stale. Once the sequence has advanced, the stored seq
  will never match again, so every subsequent call within the same
  invocation returns -EBUSY immediately.

The "goto retry" therefore degenerates into a busy spin that simply
burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
finally bailing out with -EAGAIN. This is pure latency with no chance
of recovery, and it actively hurts the KFD userptr stack: the caller
ends up blocked for a second while holding mmap_lock, only to return
-EAGAIN to the restore worker (or to userspace) which would have
re-driven the operation immediately anyway.

Drop the retry/timeout entirely and let -EBUSY propagate straight to
out_free_pfns, where it is already translated to -EAGAIN. Recovery is
handled at a higher level: the KFD restore_userptr_worker reschedules
itself, and the userptr ioctl path returns -EAGAIN to userspace.

No functional regression: the previous behaviour on -EBUSY was already
to fail with -EAGAIN after a 1s stall; we just skip the stall.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 5d72878c8..229c30867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	const u64 max_bytes = SZ_2G;
 
 	struct hmm_range *hmm_range = &range->hmm_range;
-	unsigned long timeout;
 	unsigned long *pfns;
 	unsigned long end;
 	int r;
@@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-
-retry:
 		r = hmm_range_fault(hmm_range);
-		if (unlikely(r)) {
-			if (r == -EBUSY && !time_after(jiffies, timeout))
-				goto retry;
+		if (unlikely(r))
 			goto out_free_pfns;
-		}
 
 		if (hmm_range->end == end)
 			break;
-- 
2.34.1

