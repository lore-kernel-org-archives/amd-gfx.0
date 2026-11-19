Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB733606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=opEKQKm/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE6F1124CD;
	Thu, 19 Nov 2026 14:41:19 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F091124D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2UP6fdT/gDUqZmFqM+dlZ7LyjJds8HHZUiGeBgf0bPJYetEhKS1W3Xiwspgvl7Hh5614IxdMMqjDIbm6oenya6o8kl8e1tF07qQ0kt9LRgYkim5GSsgnnf4lNUBXQF5Kcm/2IVP36cat7nIlSEsywW6nMlo3sM+FSg/ClLhDP8P40Snbv3ZqRbURQd/uvMzEX1a/fVhRcmV374+VzIuYG9tgsqpHc/8e/0G8joFZpDwy08vtNv27uvoPTYFetmInDTVdaBjEtK2DxN09W8Lb3ypSpN3xk8j8uOgvmtL6S1t527bHrrYUKDt5Gi8ht4q0yf33EkDE7LKH+hchFK7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPvouJm7JdjDNubGnjEylp7nJaj+LMcnwnMWHOEyTY4=;
 b=MSlRoKiFhZD1J55Oh5rG224bZVR8yuMyJu6w5Z9FwqVkEYvc/v8D/ZANkZntJuChg4LRsKfPNFv2nt/K7YgpI9jNGDX718UOLPkjzb56A+f8BPCqRcXcxHm6BUhqPSy89ysbIUWG3/lhRMQsxE+xGkZZfvP/O2c+FqZldzKLWsZ8GQYDMn61aSGBAeAcwzCrESV/RR61X+bdpxA2FLxcvNK1+prvn4OOku9cc2yJmGcQihFS8ngoye75cIoKza8cU1hfFmSQQpqYIa8aKn4Iib6xDT6iXedzR33XEjXguNCp7qciZvizUARgHiJZFV/kqJZm02qoDWwxr3Om+1wTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPvouJm7JdjDNubGnjEylp7nJaj+LMcnwnMWHOEyTY4=;
 b=opEKQKm/11BpgiLryfR6TLZST6Ea1IBZeuOs3zhEOKZeEcD6hpUvtoLUi3IktdGyE03XVfk2au5JRXcAZCtAqnG6BzVdiR49jO4EgQ9koiCpL0QR1T4W9R0F9NWaszruQk6c5a01XAGIXWZlGv7tj3BFA45tEomnQjE/u5av4OA=
Received: from CY5PR19CA0124.namprd19.prod.outlook.com (2603:10b6:930:64::21)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:41:04 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::9d) by CY5PR19CA0124.outlook.office365.com
 (2603:10b6:930:64::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 14:41:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:41:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:41:02 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:41:02 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 4/7] drm/amdgpu/vm: reserve space for last_unlocked in
 handle_fault
Date: Thu, 19 Nov 2026 09:40:46 -0500
Message-ID: <20261119144049.2057674-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ea1c03-9845-4c62-8b2a-08df464b23a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|261102123227099003|261026140227099003|261028144727099003|11063799006|261021123027099003|261021121427099003|261022105027099003|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: iF0FEbacryji8aZKVOUZGKMwtVYrYxWYnL48ZlQCH9qm0na5vMZegij7IBLybtkStFA/6XAoDi+aXlZAdPAtF0UM0g8kAlAztCzN5DoagyU+1/uv944YTYcAtLAvVbaAvcYvzWDHdrr+q900vQZQtZUkoSZh6NJsvCD/vKIA0ap1D4iPuFo9L4cPCVyZKlIKLWr4dpTf/GG40NQo2tHwX7cH5CjBzEbUEExhDOc3kgZ1gdMlMrZDxsxSQndlUA5LjsszK/qvAtYGsyhwnd/RPzGRFO4+fMWkDG9uZX3Cqc5mzfHXW07KYZYlHl8Rb0VHPqP/00Muu9la78qs3Dh5rp8FPAuUOZYzJRpxhq0m/u6YF77tZG3ki+4GmPNgif2js6ETBYbl7toynKeaZXKfEGQ5Bj8u14sCx32uW1TOjY4v0d2B1aVYsltsyQZ6QBsrosFQqNo3jYubqI8ugU2etyQ4wXYoovJ4kI+fzieGe47og8I0LKYeDlAIwdDuAQUpHIPemg3BsIfdv2//y0pA+0NPHSxlZLlflZcLI/gTslS3dw06qLDrNH25cGWKTqICjewrxEiEJw3DEd7X8djC470+6q7nflvMBTf475wnHgYPev6BAwqptRUG/kyUJcU3/nGoc45ksXfhtkGwrfuj9TQEoQD4Nc4N+zyeeOfqEkvcw9+fSRt62cO8131kdldfI0VM9WpQ1NTT250lXrweOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261028144727099003)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HaCfXObXl3XUm0lBp11BzjLynVuLGKE0AlXeAV0se7UALMoEoqh5pp1N3idMi9M8qWnuNpT88qYWmp3vyI83neSUGJ7NINxND9Pql4jTzg0eSa2FrU7Fq2w570uzCCp7fIJXJn1uF+WU6klLtlRDW4tebfyORj1HiDE/xQKbfgBbpGeSL2pJF+4mRPIHxIWXYQPxa2C5v9+Ivn1/2iri+c/WHTlmhVWN0WWWY2q9wsxcf3p1NXL/zhOH814DKRRVujapWXV9mUc9ZBGBr32GuzqbFxjNuzFJATmiQQQFB2C2yzDTeY1Smy7oKsxue/fh807VemJtlC3Kt/uvIhPMrvYE/80SxJEVUe/ZfKb3R8q9NMuBhdeRSV3s4Uko0Jm5NegjsJ/FxShvCLprnyNMB5u1MqSjl3LqPlkFmnuXQXUNVU5oeoj6FsCodh1rSZG4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:41:04.3847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ea1c03-9845-4c62-8b2a-08df464b23a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

Normally last_unlocked lives on the same entity (vm->delayed) as the
SDMA commit so they would use the same slot, but in this case handle_fault
calls update_range in immediate mode, making the SDMA commit live in the
immediate entity.

Since the two fences are not in the same entity, we need to reserve two
fence slots here.

Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3:
(Christian)
- No TLB fence or TTM_NUM_MOVE_FENCES need to be added here.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4d31c41fb684..b1d2779a2aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3187,7 +3187,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
+	/* update_range operates in immediate mode here meaning the SDMA commit
+	 * is on the immediate entity, while the last_unlocked comes from the
+	 * delayed entity.
+ 	 */
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 2);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
-- 
2.56.1

