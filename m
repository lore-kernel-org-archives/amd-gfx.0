Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929BACD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C25B10FA1C;
	Fri, 29 May 2026 07:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Obr0k7Av";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2E710FA1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIpz8Wi+dR2V5KpLnA9YPQA57oBT0sBERmtL6EfZOwI4EKSFpWB5c4Gs6ZZ886mE2HJrb+ZvnzhYy4Npn8U+q/Dxz8hwSa+8wDoh4IkmP+nL6zp+eyCJbnrxL07k6Qllhh16jIHJWkMmLCGeczEBaIfQl2L3A5/0UtYXrsKinhvxIhg2l1poAR/R9DpZW6dmJheTB6dO5NOCV7EKC0GN0hI++qWXUHwEHSGVEBfcaEkFAunCYzKHBI3eU2W77Nww2CShsrdAhWFW7CEDkFc6w5bwheyMa8ESz/wsKuW2bSsPjQlSZGW4Huc3kWPCIv2BiWvM2SGeIwB0Dsaw7IiV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+JMV2bShULBlFaFxW5Naiq5OFDeljKecyVqKiu8lMk=;
 b=HsOVsK3zIAFxL5KJVzO/SUWRzv2FHdJbnSs83XehLxxe/xmxO1sQcmfbUIHl3VWP2JFf4OOmDZjMr9fyUs5UB8HDVd/C4HfMXGbQ1FITJRR7mhsrCdH2ApIGcowUwK9ZI9EmLZSZkWBmfIorpPIZIR7Kpt/JfY2y/uAh4xxLcqRLq3M5vXUE+/wqIzyxp5OUnP88K2XjdvstrQ7oda7Sbr/ywSQWuTAzZFtQzAX1sFVFv7MZXcEgSpo3YR5DlK5Fs1eEU0Nd4jSdOTthQqaheeuLcmz+NYz+G685GBqhtU+o3cMGE4IiUtcBv8n6USGGqKS/YVM2kNQFFoZnflSocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+JMV2bShULBlFaFxW5Naiq5OFDeljKecyVqKiu8lMk=;
 b=Obr0k7AvJSeSOVJf6dYFkruWiIvlf9jfqyTKnR9H6abM4qdYGIX29uzDaPzG5MWM4g+iGTMdX94ptPYoo9bp7Msg/X9JMmmXQ5rB89HFSGTxVlNDLymzJppTPItYuMzJXAxqJaT8BAsKgeant7r8huYHHlb/Ah/cGQXyDj+d9xU=
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 07:36:07 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::a1) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 07:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 07:36:06 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 02:36:03 -0500
From: Honglei Huang <honghuan@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 <Vitaly.Prosyak@amd.com>, <Jenny-Jing.Liu@amd.com>, Honglei Huang
 <honghuan@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Date: Fri, 29 May 2026 15:35:44 +0800
Message-ID: <20260529073544.614561-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: df372f22-f094-4146-3e51-08debd54f1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|30052699003|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xmscdWX55Q/E/kl8o0evE6PcF5AbHDUu/aK4cTaA2dvjfWH+AHB55vsfEPNmUfCqWGL2eDXy/N0RU/Gc2fAuUPvrObpMUNCD/Gxao2cnyJJEuw+5SCtQR3uXjXEV88sDesuiL+No3c00F4hFPLiZkTdZZBiuHFZo0ks6v7RgqsLBev6qhZJ/kRfCcct33QGvQV1Ev9j9p/dgSsDjDIInfNBjZVNATHXvbLFgXfLcCduTiz/nWXnzbOszCdDMYn6x0eEs0vbLLdHiqeeDDthKEZrgFKHpTyQzoDGFUcnSxI6oQpOsn2jMohE78JV+tUWCQrR1AlmWsG3FFbsiAr6F5NKGyiYXsipZs2MIJlP0MhnnABWIar6egug4S/DGQtSlApKbBcqaIVGgKyXcvYncYZ0LcJK50xNAL01fh3iGVgKy5mpEJfOVwHF0eQF2KWpu6lMuY8gXi+b8vkh+dhmE9DwrR5wH/ncb2YqnqqP781ZdMWZyMqsOiqOaSYGrqSKLDOt0nxxGW5D6hx7mY7nVNcFGlxIckWMeVjK1LZYItsh5XwM4+2CBRfS2pr8evj5GYlsim1/y3I44QbmFu1q9vcVHcQ7lIqIt6gT1JQYQOeIEFdTBIcndDBRQgioHsHMQYcIGTazxUgo/amEJxK1BEdG8DK0Vx9HEmCoJM0JX/i1yDrbkShyqb8BuZi/p+68qoHPgLO5p9jSNg2eDkBq/oqjNp5kOwSAYCXqdlNZzuLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(30052699003)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cSiRZSbsPZs3GQwhswS338YKwGEopIU9bEhvl629BqFBEOct9s58Y4z8q6Op5/sBWe/SgR+SBnlVIaBgnzezS26rj/Yhs3DhcRUxkvuyrBs1NPQoqfEKl5r3QMmNA/wrLoFapbgbYuHhrCNohMKL5Ohy6/2Z4tZpEBFqvYHfSKRa8BvKlDfw5pHLYB7mkuem+40m3uCmeNrWQanVEoI7PmQH7/Nl8oxRyUoXgiycmMX9oK4Wf2yOwg129mmui0SADUCLZ1LOLWq0ncBdTZ9OwSOKIkr6ORY8rMSEUl5uYI8h4cjgMeHKf73+le0aJcPeSZhI3yIKA0seUOtNlT5UFzOrTdXOhCu5GPd9ZFLO0wKM3hIDMy3WZv4n7QrUVl3fFN9NhiTgJTZPREEux7fKI8DUexBj2glYRX+Mit3k1llodoSqYaPOhJGrahYRrtRf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:36:06.1647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df372f22-f094-4146-3e51-08debd54f1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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

Reviewed-by: Christian König <christian.koenig@amd.com>
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

