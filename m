Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124F8CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AC610E938;
	Mon, 28 Sep 2026 16:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZs5aDgN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC8F10E938
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF9npAAOZ+LnlDWzaswm47vr+FyBeujCijRPG/5iwbXcg/Ffr7FSZELBYzCnUWlkWPMkihw8RYaEx5jv92UVowlS3dBkRf0V32rl5sWdtLGAja/WsaSAPbiY82wOUkDrgA1h/si9ZVrFuL5bYBrycIZH4oMW4MMnoG6fIB7EvpXXcVm/m58zAA5kLqboJMD+UJHbkamyEMksrHbYThAFmSS9NX8GXLmOGjP202cee8mJe1TbX7w0YGhTCufPib4t9BV2pXcwiiwSuDi1GAQawBpA1qCFLBU1IJRsGGHHIpYfNNokaZwCqZZFRSl8ZAqS4bcd0RF3FWvvq/Q1Z09rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sDsXKdvJg6mjI9/A60xAvx4mf5EEqePsNQkSQ5+EOo=;
 b=vix+iXJpfZyihj3ytdvZ/3DuwYuETtfWbEujzs4DutEIk4lxp0MuGPf3V7DZtLovhBtu3nwhOaR/zpEOUREZr5IaDQUT5ObWwOvcoGx5sYa73WI/Pu0b12fdckfX3D4Wh1E66Lyc4DDUJMJDI9QX4SCIhP8V5MzYs35FXGfYCP8HcMV9zV5eO0IX5a6/gARGiYjy1XBtEHuzetOoTOSwwODxPLuU8URiJvP3ysBfAQW6XufweYbKXkPT1FMg1o/fAZ5AFKjYH72SCtuWtRTWYBgbG3mHjruA2f/2clXoSi2JTFUUor/mdN0HTqyShweMB2l94AJLkXUApv3T6R6lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sDsXKdvJg6mjI9/A60xAvx4mf5EEqePsNQkSQ5+EOo=;
 b=kZs5aDgN/x8CWeO8h12/vX0DApoUjBoF6M/GsEV6Ks3ARAdOJWlxngqdKQIGJeK/hNQzyrSgmtgoD1wjUFCDV5t5ozuQPXDWg6Fz+NRMnHPYmoEKDxx5MWtQ6IX1phiEoyOMcg9egnaqFAM6J+RtdvORB4hDUYiunJ6erZRD6Xk=
Received: from MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:44:51 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::e) by MN2PR11CA0001.outlook.office365.com
 (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 16:44:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:50 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:48 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Philip Yang <philip.yang@amd.com>
Subject: [PATCH 6/6] drm/amdkfd: mark A+A VF VRAM PTEs as system memory
Date: Mon, 28 Sep 2026 12:44:20 -0400
Message-ID: <20260928164421.10144-6-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164421.10144-1-Zhigang.Luo@amd.com>
References: <20260928164421.10144-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 824d77e3-8823-4190-f117-08df1d7fd0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SrVaz3TpuDoOgjs+s0leWAVtGzFuc/4VwEVheCPSI7w46Z5rfb4+9TPSc1PONPWTc/7bdpctDXqEZEISZgdwyPB+uVt9ufUlD89FTMau6tj8rN991kRClTXGyQ0PhMyXFNwxceYeu9jh2NXjW8f4XBh5lOCvJJ5L1Gf6XAo9rPGsVNJPrUzaDajsi76y/c29+g+kMmNVDV173+KSKhWk8ujqrNNRA/uYsq3JaxakB4WXmzZwFQO0oGI4TFGTHhjA47B5Ri5tXl5gjorOP9t5IVbYXzqSri3+9E99CUz9KbAnmebv7u/be3sDjXjbMR4qWFpFdAY6mCBj/QDKKm4CZ2WtmjxDLEsJQmS2d5nHhR/N+UjZn0blEVycqr4XzWmkd9xS0vjYJd0ZVXkCEU7QwWFnDQFpLOmd1ecbc0hmi++O3JD+5S4Uktu0M7ixbxXIJyEuVKmgjrDf9HWHe1mwkxl3XpVzSr5Nvv+XHYZ6PWktW+96i4QidlB8Goe8o0i/nwW3/Lfcu2h89s8LL6hnXb562wzdFyKVKpUla46CUb7pvzgJN0v6APwkx/ebD3cQs+rMcmLD/iLIp99I5ZG0OJHIeRMXNMr8wT138SmELPgsbqkFZsOznNZWMYgCRFxE8k6F+eHcHI8EwDxl45glUUBWIiSqWi8VOydOJbFZKLLqF3QSqTpu6kAS1P3iY+QN6aT7uyPTL0HkulmB0aVuuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7J+ftE5XNN/PvC75kyHqi3UAD/efez0++cfCCXmhLblkWwoHkWXVXQFOEnSqcaKquzEGNsvxkCRracSrfNt18r5osAv1jLyV3FQjy8AXH8LdBwCmjRd7Hy5geu6UOZh6JAocwfMLSFAQ/6raBwun42uNV4UePJSuScsqyO6GhRVmjpQYfRJT6g2rysK7mznR0XCnG9nl5+Xmu9ZkUemxwcWpFyNwm++5e5sxfrwxWvMxmjpoo7Yk+IvxlnfE0EQlzm6YmL4RMuRzu7WYL5v4nUplgejXm8TAIw6Sz3Yu3A21uZN1df7XsT+osiOnM5JS63AoeKYSoT/0f7WmAB9wBE1NbfrRf6+za4gfsq6xTt3rKvqDGT71PWC41JZ7XuJP2YAoayRrFkTtgXXby0RhKg+dWa89TAJ1b/bZehdIpNJNKBtBa0uDAngL/N5KFzMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:50.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d77e3-8823-4190-f117-08df1d7fd0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

On the A+A VF, VRAM is accessed through the system memory path, so SVM
range PTEs that point at VRAM need AMDGPU_PTE_SYSTEM set, matching what
the graphics paths already do.

v2:
- Use (sriov_vf || passthrough) and amdgpu_virt_vram_is_spm() for
  SVM VRAM PTE_SYSTEM.

v3:
- Rely on amdgpu_virt_vram_is_spm() without redundant VF/passthrough
  checks.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c521ec07bf3c..b3edb47dc2d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1374,7 +1374,13 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
 	pte_flags = AMDGPU_PTE_VALID;
-	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
+	/* SPM-backed VRAM is accessed through the system memory path and
+	 * requires the SYSTEM bit.
+	 */
+	if (amdgpu_virt_vram_is_spm(node->adev))
+		pte_flags |= AMDGPU_PTE_SYSTEM;
+	else
+		pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
-- 
2.43.0

