Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02483CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB371121E5;
	Thu, 15 Oct 2026 08:37:57 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4784A1121EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxPka7Vh/S+Tk/i7UqHUIr1IoW3QQu/4iQXtGUseTSUzUkVlckd2sYJ0Q6RUQcBO6k4cMT2TRsDc8EOPj7RjO1bfDXK2g2bQGx7im4sQbmrk9ljbyN/9PWRhnEa3jo4xZ3b78rQj3XiV9VqpFxg7GmPf48u+FNIL2y9d+H5kB0mYOgi6SDw5zBKnle2VzumcHFMFOrfZEUn9buCbHKWRSiJhejjxQyzbOg6KXjoZSZMN1tn+E0fl3saE3N5JL2zLqsbsxtz7Bf/vUalpA0io3aN6KAQve2hQdEaERlymr6Y6Ba1fv5myJqgZ060ysB5DzBXvGCm+Hk2Jv/tIluaRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiCx5u2a7sfAOdrMqMcK44/IzC4mDB/g/EqTqkpUPkg=;
 b=SkjkQyhLqcdqhPbxcgZzWkDHmqcRYcK4E+wq40TWgSZKy44NIqRPF5UVZl/wrs/YTISB3ONnGUTyI803h44c9+mCP3Vk4+Lrmr3neq2A7roUAFV9rkQRZzE8dYgL57C8dukb+bxoXgK03WSpwE7jfEfqj7HcgoxAhgwTa0EZa+inmyuYLYY3oSLYImje3zRqN9kAY7kNghztOLWfVZAcH8VcWCYKMdmg3kE+ihfyu0VQ8DAq2kdKIpdMRgktL+FfQ6cNttgxI5yT3LT0CpMvo+xsWI7yylSHW/TnZcnSah3z2boeYLRMtyu5kdLKEE96tz3IAadRg1ySFI/kCSAj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiCx5u2a7sfAOdrMqMcK44/IzC4mDB/g/EqTqkpUPkg=;
 b=3YYJJDfaELfXoc5lbWzC4aiaGIswH1Qu7fyMvTVZSE52ogIxM610xn+uo9r5i5Pir4UZgQh6Vlr33IerKlhH4NRO2NzLyyiNRw7wybksOiW5JVM5kSwuXscyzQKE5pqddXDU6ohMkrxuztO93Tx/XW8r/PgxEjU7QqiHQiIMGQM=
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 08:37:47 +0000
Received: from DS2PEPF00006E22.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::26) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 08:37:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E22.mail.protection.outlook.com (10.167.23.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 08:37:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 03:37:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 03:37:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: reject ANONONLY userptrs that span multiple
 VMAs
Date: Thu, 15 Oct 2026 16:37:21 +0800
Message-ID: <20261015083744.3448696-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E22:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0aae21-1645-473a-4419-08df2a979705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: WEUtqPvjAYn2/E501dN4B6P0Uc3Sayxl8LiIVdcaXpyh/YFxh6g6NXIder+4Q9fOombQpMUcet7R40b4V0QsMd1+9xRHYYESYRmusem4bQEe3u1Rm3qwFl9rdnxolH616PmypTYEqaX3vTVX6TPgRtKODKJ1/ylTcTjqo+eSOOfBw3hvG5bN1DQOEcae2mJU3ArsPPURit1KBKk9JZWI+LjVXVfut+4wbswWAtin2LEE96A7Q0yTrE6tufdokTuKEML9J7b7UfQroEspgCl+hC4CZq8r/pNkySzHcGneDovnMG9kIQ+qXlBQPrqeQNUif85Lb10LBXDEgraGbDD1zUfDmjWFSd/kdsir2v8R/zcpjbwmiFfUCi5nYErgf5DDhMkD4HpQB+i9wT9cGE1FMQRuwW2lUrKv8lcMV40BV2xsKjVi3/vrYEqEqkTGsVfxFVdd5xiqJ2IOQRBsE7mpIkYQmr49/zeRv8OmbstOEOLB6ERj8FZe1EUM26hJjdZ2tPfKcADuc370YO738+Tw2846muazA5oN2qyOkZBnp3T14h4y+cEoEDOss1GXw+8Z5gtmVMXrZ0+GWjni8yoSWmlEyaTKAO7JgOkQJpYz0O9FTzTQalsqnwtb4jwtQLtMasY6q4pJ6WHLGRL7inYKSVUtXU+ICocwY3gEkmg4iyOqYvs1o8x3PYHKFP3Ocyfx9JMYH3NlqMPMHMSShx9w2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EbSfNTVcImHrk/Fk+owk1a/Cey8a4FJQuAQb49mRBadhZTMX5Wk8mPKNTw8wPpmnrqNeDG0vAce+jqEz7Gd7d04H/1HD0VGb+cUeRmgqUB2pKAh5nOsq1FOKTTSPKao4X4+Ikq8CW95vSaBXQLWv+fvVX7SlnNcoZQa46ryYsv0K5VM2N/Li3kveYc3lYdSo6by/C7CwNRJ/YOYu/YdPiswJQVJNyRqpEPQjBbZ+F0RwYKTmPfBznEpZlfCKSFr8YZhvQONQ0ZRP8srWblLvja/gUjlS5IjBSFmG+nwzq1GmS10IJ+XZVy+UtnadCBnVIKfZOqOASfLO4eMhAvug/UrFR1q+mmdRYNLbXOIH9HQp9SGQi3/rYiJXAiNNrNNWX/sB6bD/SLuHljUZLPrxq3tQQtz1JRauk1z3paeM2Pg5QbdW7Hk04F/2mWFBKGGv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:37:47.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0aae21-1645-473a-4419-08df2a979705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E22.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

An ANONONLY userptr over one page of file-backed memory is rejected
with -EPERM, but one over an anonymous page followed by the same
file-backed page is accepted.

Restore the check and reject ANONONLY userptrs that cross more than one
VMA. The second userptr is now rejected too.

v2: reject ranges spanning multiple VMAs instead of walking every VMA
    (Christian)
v3: cast num_pages to u64 to avoid an overflow (Christian)

Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
Cc: Christian König <christian.koenig@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2103f8d6165d..9c3efc27b363 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -784,7 +784,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 		goto out_unlock;
 	}
 	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
-		vma->vm_file)) {
+		     (vma->vm_file ||
+		      vma->vm_end < start + (u64)ttm->num_pages * PAGE_SIZE))) {
 		r = -EPERM;
 		goto out_unlock;
 	}
-- 
2.50.1

