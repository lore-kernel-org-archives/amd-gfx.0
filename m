Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE52C5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB09210F085;
	Thu, 20 Aug 2026 14:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3nBKeC5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D2410F082
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAbfQaKlaslp6Vp0ChpqK9V/+Hb4MvRlEGC+v9XZ6tr3ZZyxSuJa9AM6Ko6r3FVm/8A8/CbPeZjQ29mSrDBcAwdMDstS9OdGuaDZcZDNQkaLdowR2vDuBQ8Xs9ImKlUpcWIG8kQhMsEhPzsAvh6FRAYXxa6+G8vs915IBGNlcAUdG/U/O43k402o83LiGy4UqjyBMGdjcG5w7u4G/LB3MerKr4Tulymm0/Vr9HZfijy0xBjKYZJT60tkV1pFAOPXxcYLukDLh351hrsPU3SVmcQj0MDt/rCxugrQo1src3NZlBZAJa6h6ucbHeyjQivZZaT1xIOMm8H32oQmObW4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftqpXU5YViG+O7yjToHPnxc6QDxxEmwPZesYcTUDW5I=;
 b=IjFvHjtLXqwKRHwVbE88+UYYsw+y8E7CdBJYBsdaXmPpznTQMAq3T0VRo84Cj6901cAbDj4b9yB5wM6+1pTNcMH1NlijMcnTWOUO3G3ooLnmbzeFxruXjncO8zbsiBmjTupvk9xg1rhG0FO7Y9sB8V0cUa1g6mRY5qzVywJwvIqNuQPFqhtAo4GvTPgPBJHM7OyC557zB2X21yiEWQW0W6qnOKGeeiMeN1SfrxKrCRJdd+2UJxId1ruEAnqubKT6doBto8NYTSvRUZHF7zXq9Gi8hGK/Zu4NXDYicxX4/1+4F2eh7+5iWhUXZLxbvl1ufvIOp4yoZjQE4uw8snlUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftqpXU5YViG+O7yjToHPnxc6QDxxEmwPZesYcTUDW5I=;
 b=i3nBKeC5bnjpOP8YTX/4LiTwhdVTsCUGk9qwRRiOrIVVNb0Q/eW8g+5EhchxSexE8h1D9SUTtaQX1/8JSHStvaZi6eGWXMWzuyknezrc4YIdmgP+y6g9gf9D3nkfixzLk5yyo2gL6qZBrNANavDW6zLr9ddTkC8aS8Yzxy7hJAM=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:52:41 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::95) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 14:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 14:52:41 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:52:39 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Fix VCE 3 ring align_mask
Date: Thu, 20 Aug 2026 16:47:28 +0200
Message-ID: <20260820144727.12484-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b57b398-9b93-421b-3b5e-08defecaaf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|30052699003|23010399003|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: iZZSH385ivkpvuEj7endkq1mEl1VRI6u8zSt1xCzHOKjtkCxos37wJ5RLsHX8KryQU3F7Y4/t9iQ3m+iML1z/NjhFTNBligGsdr0JvC5fXnVCIwsratQ26Ir1FaMGY/9MclYIwKnLw2dGsKxzeZKwloZdOB1IKlxJM5N15sGfHR1OxlNpNu3XihMLvCxlF5ScAcvlemaJruTKlknRMW3RzEwdYICCJ8caw4obZ5Bnb/nHyO/eiqawZp17mnDLUTqEd+1AbIM8vwJsDLPho6l8f943MeLjuo18aXHy2g5rKHDcNVM62SKYwz+ZfJ6RjUow3qXkSatUDcEMFRtOMcWHJFPy6SfIsdHtxwXP25eZxBwIbf+LtFOLCkZ053iBPeUjInXoMs/ZicxqXD+VqSj9HmSLT9+gw+jvjSk1LLfEWGBIAp/b16LJsmF7KoamKt0BPsN1R5UiXEZKV6Vv9zWGxjmd8gtn8OUuVqh6ytjfwO6PaatQSYAZPZ7IFB8PXdykVTx7I238fTT13+hjMl/Vqn2wgPcSp0mdXiR+a04R98hmnc32amMhdT05DLJBXslx5cgbkqJt3j8mrz1mj3OTVF5n+Y8gGe4ZJOsMQB3nLiik/1pP+Mt0CtdyrtjNNvYq6CYVgTReYRH0vkJ1HVgs/z5bwpSDPGzQp2H9NURwk14Ekg5tCIaE6Ox2V2yWvnic1V3xndSPRX493piKKrh/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(30052699003)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TzoMO3PDgT4Re5el/zkNn6X43lnSgx64Pkz8e4vIkAPmZtD45HDdIcvAIPotsdOFLqFe1y3+I+3eSKK9QtxAXQSn58Q/V1LLaBosXK8KdcDtWlpg3a0KHxqlzsi8ZshoeyzFxKYqCeLuLKjBZ6vgnQU9iRbuHIXbER9+Y7LEhuhvlZoB/UWxS5zvkrPpYOqPt5anJAcfHn9sbuCLAgvLYxQZSiUCG2ByEFmPQn9ADj++TZhwNeU+4ubtq5mo0krerFpUPghtCaMNL5M42OUTXdTH25OqxaNVW2+DprhDj5M0b1rwcOrEPDeMF1DOWmfrvPIp7aWdfUyKFPT+RPvDjdKGh7/U3l8muXPnOgSellQegrN87zNjaP7YfTH5Bxqk3ZJbbm7QcD/QfRqRa+tBWqG+CmOVKTHUpTsjLzXNcuYkt2NQ5UFXsTDYvMgDm3yr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:52:41.2442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b57b398-9b93-421b-3b5e-08defecaaf76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

The largest frame is 20 dwords, so 0xf mask is too small.
This was always wrong, but we were lucky with the VCE_CMD_END
commands inserted after fence and vm_flush.

Fixes: 7591335141a0 ("drm/amdgpu: Implement insert_end for VCE 3")
Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 9809a23fa521..d5adccd3e689 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -890,7 +890,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
 
 static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCE,
-	.align_mask = 0xf,
+	.align_mask = 0x1f,
 	.nop = VCE_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-- 
2.43.0

