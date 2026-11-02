Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15060A260A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TtOidhFE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFD510EC18;
	Mon,  2 Nov 2026 08:31:47 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC0410EC09
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 08:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngiiiyjNHTkGORCzvZ3dofyfjL5xYof7lazLwmAUhGHUhDNlIJiXXpgPhNB9BnI8m5/ONpNXfju2tHw8JqcpmxiM8yhH/jNnFoPgeum3DtwNxkD8sc6SOMuJfMy/3k6qOiILoClYiaCW3R4zOkhEGcy8KT+VZg1WHor+TiSDWmXeqMfS8JrlNWC58wUGnc7T+1O//Xl67w04x2pgKG/YdGbMaTU8fBnp542QfpuEfFBiiINfv3WjARiCWo2jhZ4WyDQWU3SPOzI7CeHPfeZ9RKoSa9cwlnoTVuuX/ykLeG2GHRNl4cchMCcnRE1bb3YmN4nXocP3NiI+vFg/4tbKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtjhyXSIKb9bNEPQJmZDrBW8jMBjcKCHg2snxXL52ro=;
 b=nacKEJ4HfxOQRv7CI8pnroJnCEYl4wBsABeDJm04no/Jmkwcb2L2jInBY4ZYOXsJxLxtN5SQssAfQP/vGDaYlgEbd4gT4kTiJEykgHd/sRZtbKHEIQ8qpkAVupfw+4QugfxvZGjlj/xZTLbKfcZ0bWzZl1jSH8qn1rRPgGs/H8VgEQiix5cVo12f7VAROC2bfzUv6Djm6y4xO7TH4T7DxkOjTWpdHEcVFG/gK3xPFi5oufI4YwHuLoy5DBAS5PQFt/FXnPH6dv783DfDeYSxRtwCFqc4nhi0yyXurYIAx1m8RWBqNFK0g6D5hEn7aQRoAQ3Z4UbgBvRndNalnODn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtjhyXSIKb9bNEPQJmZDrBW8jMBjcKCHg2snxXL52ro=;
 b=TtOidhFENgM7JFK17VVnTf1wBNcx6SnGJRbkSmq4zF75X1PFpoVEF1nj/nb7mRckoBacrSA3EtSO0jFLY95+TvK4/2pz0XcaZpaLVzFT1qqTMGz0kCRhZ58s+q/4UtZkdqe4SiTVHjq6GivS9s21GFymCP/Las7abu7pWhNsib4=
Received: from MW4PR03CA0201.namprd03.prod.outlook.com (2603:10b6:303:b8::26)
 by LV1PR12MB702339.namprd12.prod.outlook.com (2603:10b6:408:50e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:29:30 +0000
Received: from CO1PEPF0001885C.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::73) by MW4PR03CA0201.outlook.office365.com
 (2603:10b6:303:b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 08:29:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885C.mail.protection.outlook.com (10.167.249.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:29:29 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 02:29:26 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
Date: Mon, 2 Nov 2026 16:29:15 +0800
Message-ID: <20261102082915.2289352-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885C:EE_|LV1PR12MB702339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2975ee3d-bb11-43c7-705d-08df38bb6a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|56012099006|5023799004|11063799006|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: FdUhAuwfkvSI8pS6zWObnN4DRdhB+eyARpkWFywfpVVu4KiA+j9vlIXmMk6w19W2e7kKy27+7TLN96MucNxTUANZZK/YrPJz/duJlu9y3sE1jAd8Zzb1sufD9mkBF3fL4SsyxXf+z9KRoLix1J3AbShPfTsaDWO5Sktjmh5Tp/bgWdQ4fdUidz0eTqxwLiB4oTMLNrxb3AI6kkD9JOWUgSNofUJU0GbUPdCQisiYjECZy/UJrxwq1bCozFFncgVNzPCBR1zSFmiLVMVClmb+bGZYtKUxsjCMb3qg7ohrLwObGL36AyP8vD8yT6DqT0MDFPW/5G1RDbv6zu96DxhjFeb/vbzU8tUFyjtjMEMEu15s0f0IIJdXytHkpVdGNDnjBliN2IGV8Mxdbp26r0GCQ7EC0WGmrW6BGfqdLVKwDr+t9OZ4aU2Rbrj5r2IzKlPCfHpMtgYMZ0HJ7P3xjY5jZHuv7oy6ZLCCoskeJc5P79an7nSd5R1ydZ861mFJOehwD/7VNW4W6zS+G/WGYX1p7KEsM8YbRm+MtXYVfMKrRNbnXG2B3HrWdU4yDxg1CU7KvrTWlwWZQnPwd9n2QpRXiBPt1KjEZZq7ICZY901DGqcsyEA7LaNoUuORvVISNTEet+Z0dE9VgeDhGRY7AVv+RVHlkQTvfd9C8ZISWE/g5qPuANDH6jtXMkKCYGZlFZhsWryYpESr08brVm23/QhQWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qiDTFSY0wbbP1DYHxAlMsr6U6s82u/2Z0CJ7Qzt3hj3gJpoq82K8oYeEZjyOmATjrL8M+4ugJiaaihtHwMDoTt5W1SViZgzgCDQtn73j1aEI/H3+lEwm8BnYPds8eL7KMX0MttRK0Qhd1lVoOWVbOkFtp8m8ukr408s05w4W/yRSIWar43G8GMvEI0oeOZfLeLtKSW73sjunzo6/ORRB5+bW+nsIlyZbA1J6Y2ztW0a9318gZ6mo0tUXXzPNir5kHJy0TJk0+ZqLi4S0SP5lOHnxA7yWsN9t5xsWmgYiiGmTUotY3kfcrfXwyjUibJq1Pj+iV7arpkV3+AfPIqnDYRBMKfzzuFHk2KuknAxa9w7wKOL87PfynCL5i4p26we1Uv+J1pbrB2x0Zr/qJm5WCTug/DeqhONDhzhJgbc5nRtzpO7m7RLGe2vnh0nVW3bu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:29:29.8229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2975ee3d-bb11-43c7-705d-08df38bb6a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB702339
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing limits args->size in amdgpu_gem_userptr_ioctl(), only the
alignment and access_ok() are checked. Acquiring the DMA addresses for a
huge range and cleaning everything up again whenever it changes is
expensive enough that a sufficiently large userptr can keep the machine
busy more or less indefinitely.

On top of that the interface is increasingly used as a replacement for
real driver or udmabuf backed allocations, which it was never meant for.

Reject a zero size and anything above 1GiB. That is far more than a
temporary upload buffer needs and stops the ioctl from being abused as a
general purpose memory allocator.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c982d102614e..348693023563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -566,6 +566,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
 		return -EFAULT;
 
+	/* Userptrs are for temporary uploads, not a general memory allocator */
+	if (args->size == 0 || args->size > SZ_1G)
+		return -EINVAL;
+
 	/* reject unknown flag values */
 	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
 	    AMDGPU_GEM_USERPTR_ANONONLY | AMDGPU_GEM_USERPTR_VALIDATE |
-- 
2.34.1

