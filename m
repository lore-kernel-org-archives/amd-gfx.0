Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3166C44515
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 19:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9C210E3C0;
	Thu, 16 Jul 2026 19:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1K0/wIS/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919D210E3BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 19:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSYXSLJk2NeWMZR1RK87v/1S3CgmzPUjJM5ephSkpPvTGD27tkDLPMJnz3rIzDuKYUPMMEcgiviPY5R07a1Jn+mvLq/Sga9ZzkcMR/cVKDjIsrzAkbhncnTosczXN+VPJ6nghYjfAhdBcSupCfA3kiO5hROBCtzA25tWnvgBPW50zC+k4AjrBpA6s0mqiUiayWxW2s04BYa9ckmMair4RB7vSluLhK+l5++GrbMhl/P7RQYZd1bAlzo5W1+CqaGWGjgf9BlUEWRS4sSBcVXdUMLlNckmg2a5zocDF4fOEkmMUy84PXISeX8S1q4CDbaJ2UjH9IhD4mf80Om/+vZblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3+y6QagqJtzATn6C9z+zJWCoAZUyUsDDJx/CQtLe9A=;
 b=X9G2IBcvye2k4+1AIzFJ05d3XnwibM4iMBSOcxw6lXEiGwoxzjBvnoCPgZLutg45AysxTq3Eimwm5WrBtz3b2EzYubC3hW7c1ym2tiPH9bsU9Wz5/4Ba6WSDWv2VY7PllALzJd1MxtOh5ARuXkNqHideyG07Ib9gFokKYL5CjCu1ndc9a8YmhhjE8da5I4xl0HkrfqbBkzr7qh58eTul9Ca0vuOxPs90zKzpqLAq9iGTudy31SocH2fgxNxGDJGJEdYktv0ILew4kFf3e5v24H/r/6m0niTbAZ+4obSO1/tYX7xWkn5W5bgtbHEcxrpjTF6E4RjwrUobT7yEqQAaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3+y6QagqJtzATn6C9z+zJWCoAZUyUsDDJx/CQtLe9A=;
 b=1K0/wIS/VqK72lB8oNw0aCtsMK3Cu8c/ArcudP3mbMzRgX3yXTeqtpc0XdaoXSCEum1nxkOIaIpfktrP2z3EpfgxRh0LtIu1AJRk4rNPlJP8QDyGe6O2zBT9LlYAIWyOVdIJl14G23G9jqQRNs+7aCXH76KLt17/gmkKTOTBdfg=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 19:06:58 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::56) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 19:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 19:06:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 14:06:56 -0500
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 14:06:56 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Ray Wu <Ray.Wu@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Switch order of GC and Display IP blocks
Date: Thu, 16 Jul 2026 15:07:35 -0400
Message-ID: <20260716190844.368565-2-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
References: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b2af0a-8cdd-4662-37b7-08dee36d683a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QqIeeVUuQe90v2io5FmLGeMIku6SbQnrwUjSVYS1cFWTNM863U8Dz+7t4hiXmDDL2LXmcUX4OXUKzwYjVWP4bjBNp4d2xtJg/HeKvGAe4cDIpxMzy2ZxR9tzdwEl5BIWvnKwBgZAaj0bc44TB2iT4IgkYSt6slEmprwhwuYYiFoxAQQ1rELMmq/Nn5ysA5Yw3KiJnv32pr9lhPhu3b2Shom5UFe5u9qRl4JZTQrR+keqJ2JUjRvD+sIBAUJMFXdBCzp6CB8ViR8jGlvJwZxNRw0VTUAA/UQvdTOfVlyc33G9huZoGhK8zF0DRV+49Z/YoVxHsGVKZm25hWb4BNGrXOi9r0DaXsq4nftoDOQBjSKvdtjBUQsIOjSgNsEDmWcdAuIVXVsmjQkQEfloVY/9bQdiBwSRx0hs34jxfR6uFRg35v1QBS2mjlKYuqkbyDM5EVMCyjcNkLzcWwosIWslsHWQ07nTGUcHEhqM+/mO4QRpmEQRm5DqaXZDhhbJ2GhhN4LoM3mL3wXbjayrHtiqd2a1N57r7c4yK2zgnB4hSGzjLfF4GC/hbD352fhg087Nnu4mtmvCQ3Wbv6cFcO3YoAqCMOZHikq+2Q4TKw8Pau3GbG5BNQan6lATuOooGU/OMJHLTt+9vQMqORPYdgX+EOvF9/4v/0ePA1ioJ/ytC22PF+5V/474wi/aVpvJt2TGDUaWRWec24+ZMJGhOIAKog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WtrsDcVLXqysl5o8B7AdPei15FbGbh095x4FS486K4i/tBCz/WgpHM+Q+pix5BiYeYRUXsAF7fJZdgVa36O2wKonL4RfGa/rHLC21sqTA9aBpsVoot7Yfn/GIYALBkHksIglJuuOunio8U9xnZqDu9BA7ClCWG3+RW2EDEx9owR0W+TVxyKyUFXyDr9qi2BpyOl9rOVYX7olTwpOn219vV43wCCIaXtUYSNHjvR1ojAuWXiFBLgTz3q/fJHAzi7G/v+TlCZaRhOnKkYTHCav3MNNQ2MTtZbaibxB6dNS8MB1ZYoHh14hZsHLn3BXSn+WIYc/KVoSD5pU+P4MpNQb35FiobfRq5Be/bL/RGi/ZAM2FZerCakrqlK99AcHiy+Pp7xcyDz9LVWUTziWNULPBfKVWbH0In7OBWwciImsSv/Hj69+zzAGyW589ka4kcG4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:06:57.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b2af0a-8cdd-4662-37b7-08dee36d683a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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

For DCN42B, GC hardware init should occur before display HW init.
Otherwise, the GB_ADDR_CONFIG register accessed in
amdgpu_dm_plane_add_gfx11_modifiers will have a value of 0, causing
plane modifiers to not be set correctly.

Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 44e7d2e3e6df..76b6efc8768b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3657,11 +3657,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			return r;
 	}
 
-	r = amdgpu_discovery_set_display_ip_blocks(adev);
+	r = amdgpu_discovery_set_gc_ip_blocks(adev);
 	if (r)
 		return r;
 
-	r = amdgpu_discovery_set_gc_ip_blocks(adev);
+	r = amdgpu_discovery_set_display_ip_blocks(adev);
 	if (r)
 		return r;
 
-- 
2.55.0

