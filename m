Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AD606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r2QiEMkx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D32810F315;
	Mon, 16 Nov 2026 16:58:37 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D4F10F30E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvfHTfnbWulq7Tcr7UhU++JhGpi1TLu7vqZ+/tZp8LQNnN8aIvEINg+2bWDe55rEj/QhtMMhtqpuGMrpCX3AcPe1ctcbywRRiMPw4kVqZxXlNIXL5vnHAjuK0oNT7OKIXBdXFMfBa2/ewotfEvSFNjutuV3y1md4jy3H+582HqmOa4/D5ebnCvWqIlDqiWWFngOAKksQ7DMjvzgbQ8nCAIWFuh8yYg6Nb8htILKUh3PeDZ/4NYQaYJgIW+INjGMYxTxEoGPBd38KTgI5gv73hhItoHRRLLCNdolieA7V+BgHMlfSlSb7QliDl/dZo7KjDkNdaKeI6/7/sdhXIkvuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=479hg3iRhookcc6O0kZRjfs1euSF76wqRT6gtf/qC1Y=;
 b=AxmwQ9VWZP8n1ehasSz3ODto5A28pRixGfodSuycWTyR/UuxRnCsBh2zxiTOz0Ju37YfL+MwNY38WSnuqvAJg/DhB+NWi/P8jQRFfWj9GjIN+3PZ2V4Xp/8260CgIA7WUjsBgc5j11t1d9Z0vqkc3ZzLSLAF//LJN9QQizLileG3z3TlTpkS4zxOxt7iDp+zVFZ+B626jLLkOHfYgPKh5A+N97QPLVqQkFClr/fOC3lkLdvdJbNi9nJaheId4bjusMovdkBenOKV5gtxpkSC2UHn7BtsEFZj5mEbDU6e1S7VjlksxP2ggQaSS0Szr7GewoSdcn9pzHhJI+jFyGY6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=479hg3iRhookcc6O0kZRjfs1euSF76wqRT6gtf/qC1Y=;
 b=r2QiEMkx/Gbk3PiS1isstjrE9p4BxalwlAvLNS/af8tumdg9m3k7c1N6cKp60xniNey6wa01tRtGqu6UatR6tsP43B5V2RqjnZiaG0ji9O5IWBdLjwXRvi0AgdynDTzxJMyy718xj0zlmJgWuybTEeDOZ+2aVuEV2c3D4cthBts=
Received: from PH7P220CA0145.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::9)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 16:57:30 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::2b) by PH7P220CA0145.outlook.office365.com
 (2603:10b6:510:327::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 16:57:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:57:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:57:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 10:57:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] Revert "drm/amdgpu: reemit RLC SPM register in ring
 reemit"
Date: Mon, 16 Nov 2026 11:57:10 -0500
Message-ID: <20261116165713.1945549-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116165713.1945549-1-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|BN5PR12MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b48ee3-1dc8-4abe-7747-08df4402b3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261021121427099003|261026121527099003|261021123027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xzu/Vyr9oi+NJUk9Pruw1RINlB7eYrzXXt7NHhs4I7feXFYtLlPzRQjP62Zq58xrxlZFmZ2+hhtVFGmVo08hmjmatIJOsO9iXVBkkLfcg5dJiNPzet0lKVtoA/xg2wSF+ZsXrsBIWuQSFu1t5v/MLcMO9icyjdHbiSwUzMrOI9NyU0jNkS7cLJ8W2Y8Tlf/SocHNnXLaqMAWMpYLRFbo9+5BR5b2p1MiyZQsYEGciAkkkY2NXdfr6O+TNU2bkqHsCLbzFKrFccRn+pSxGtVaQqEVAEy9d5qbcV6k67PVjpKPr0lk7UI4lLU08yRbNmeJRe35ISdsKfKu/vRj2f8gR75qQfBV1RG08J+ELXEwvr6iGMo32rF/2tkE9XKGDQo6vwXANItw9+/QClW9cPffkeBELNdcEwcJJzhsRMywaoeWEnDoQ/xGSUuVSjG30H6mU/tGt1O56ehVk9TjzzRU0Yy/gxoKsp0xY0qL8QEyl4WDOXKNeqoXkrJ2SjAGsFL0Hn0v5yt2O7+5PKIn2sQBE/cywzkHZnyPRwWmdIEG/8Mcu52fasJjYLw+BJHOU8ae6Mzu+zEeqcGVWSQTR15yC8ogYD3UeBk2H61XvdGakc1WEtWfzqI5oh2ax50+u2mKibacvp6BHBbeLrY7yhgIonf6x55R+3saDPGjF0Gxn1xqvXe7CJB8UHLrpluOx1rm/LYuhLUF1xzQ1YXbdQf8rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DdQebTFY+4QhWwgOkeqa/YR4jEfmZSUT6ZpBKsjHSRgogliBIo6SEamdAX8sg29Z6amf5A8LiVSimTxEOoH1eDubjTg9gAE4fu/Y1HXC9R7H3hKY/C4k0ZH6988eAVx6ZCY6YP6gzNH6hMfYG3ZF8klu1MVoQY3e08Gp8TMLr0Ulj98EOpG1tuRUkO8HX51bAOo2Eo1BX3v/fnyZKg+ztsm72KcEVqTR4qGaa/1bYGyXLV7qrqjQtczqI1t0tRy3yj2/vkPGD/tks4aNZZLDhp4jM4B2+2l7/EEA3sER95p/Z4dllR5muHl6fWemFDPznZU/vaS44IcEA+4CVY55y7CleIjzCtWRVnN7j28onrHLMIocaWUF8dcsOXvtbawiEJ8+FS3nsku+nRP5wBankPGS1UKBg+YrGQT8xbih19pOqhLjgUCYTXsuozCgkIMv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:57:30.5852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b48ee3-1dc8-4abe-7747-08df4402b3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
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

This reverts commit 8a4dfdc0d2adfc362ec310ff70526e79ff8377b6.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 324d25c77897a..c3f56253d3b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -715,9 +715,6 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence)
 {
-	bool emit_spm_needed = ring->adev->gfx.rlc.funcs->update_spm_vmid &&
-		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
-		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
@@ -749,9 +746,6 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	}
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
-	if (emit_spm_needed)
-		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id,
-							   ring->adev->vm_manager.spm_vmid);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
-- 
2.56.1

