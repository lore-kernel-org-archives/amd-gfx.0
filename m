Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D125DC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979AA10F38D;
	Fri, 21 Aug 2026 16:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AHYOuZVU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F5E10F356
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mawe7GsFVcXcgO4V9ddQsYHQWYHcBjxX+MAjnrkFaK5+C8RHFWGfPuYkaMXIkURpXyTWCjVbasVjow5g4mkJVvmbB5V6rQ+5C5/u5dliR2QrkVm2nUGb4Gidgh055Q+Do58PS+j3Ew1IQsHtWm4pRD/wQ7KggZUmokFVfiZnbAXQeVdeLWZyV2QKt3TOaVXqRBHF1yJCyjTRMlZxh81uUmYYtlgm/W/14mJ9OuNVph1ZC4TOKeif5YiwqE9YXCxdgX63q5Mo4vEuV6/z1mh+3ALmOjuadQaZaW6zUb+IIdU8kMs28H308yTMnYgC73NaYAcpW2Hh44YElTTuQqh78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRj4PieusJY4EmqjVDk/su84yhrsbhEEY50HIp7dm1E=;
 b=oFVE06MJu2pFx855ExU0lg2vOHFMEIKHR4tgd2foONkvh2ISTH+EtZd1U4xfpEhK1GoG5SRGPRSshTFjpBM0TLvV5ZqoCm/GF3pen9Un142YM5XAOAH3CFsmCsR4mfgujGG4FWtystQCEptppSkG3BsFxHiBp5urDS6XrsqkDA6wBK1TV30sOB9UO0UbDHiGcjwQF0STmaKhc4JGeXaK+mLja1c6FcU4vMhZ6P+MMaYcUvaENy2BkzPHM+/mVvjlvhBOd9FjANZ6tzn72O9pwTzAcxs7KFvDIxBgJltHVLrTi9wjh0VFz22Sk/HK5zJCDLgk3aHLsLJcRiTxrbWCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRj4PieusJY4EmqjVDk/su84yhrsbhEEY50HIp7dm1E=;
 b=AHYOuZVUST30iKnxgi1UuwNQ7TUlTkbHwohSg03JgDoFHypDrODjpIe1THOCM2xNwAKbcfofQdoiefY41/EU5gDRHHqzNM6reyevjI3JXXtihHjlfL8GOLtq+tcXwifNO16FAivyI8EtRjFuo+gefy8IQgw5Kl32Z1qJHaxeig4=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:16:02 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::80) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: free memory partition info on gmc v12 sw_fini
Date: Fri, 21 Aug 2026 12:15:42 -0400
Message-ID: <20260821161546.754333-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 45045f9f-c107-483c-b569-08deff9f7eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: L0lDKSD/BchbaQjv7mQSf0BG/DXjMVrwOeUj4h1iNp88UfSjpEoMPgzGuqVnfRkOWY1W4wcuWei+FSvJ3TSVAmzGJqYCf97FMXk5biAq0l7p8FmxrJZ1jt20El45tEaW+QKFYL4hz6r9UaRfwA+5y8cab731zi4bQBt6z/9H58Bl7vi9jry1ib4CI3TNaH/p0dZT/hYt9q55XEZfncw6o3b9Szm0tHd4CbP80A2sRXPDF5PBVEbJNyL8AANIyhmQz4KvjwYDtIvqRvRCcYT3SSd7sXVbKHDQ/jsoyPMk/EcgxKp+5qe7Gq8XBVi5Q8ZPiUHFjJHCqAo1OThVfiKuP4jgX4SU5ihZpdxkg1QUOKDax9uwRYw8AqMeitWl45pedhDlWqH6fEtB3kMGxTxNTAUBjwgtWe8tiXg9LeytcsREKn8vWccLgM/4CRVN4j1gARuXRAwPluLu6dFLmlTzeEAD3AFj0PDJJ8sF15+YITf4gFQrt6n5o9Ad2JUteB4xS0soPDNBCKLZMMJFKU0NERveoinOvLKB9N1uSuat6sSI+l4qnnIAKzSRfjQo7sA0rBg2NMxSW9JrIKpKKK5B4siM/PrmsU4e3bBvkSIoSi8OMwpqasNvCwtKr/83Yex//QLDwH09FI4QAWiizEm6uox3Vj6cXh9YFWNVC75deJv9BA3KREgouicqbKVfiPikI9LKRN/a2yo26DpJwNRVHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8H1MiHJe7fVIszdgig0gBk217xxLR3FqGeooeVSVgzjbNVrKfE76NpZnwfdRi5yrhi1L3EEMlrN7X2OkENJwKrRo1jko3ORpvanCxA2vAurPyWcuRlPYhOH1zheuBdF5BNMUcnYCEIenPfPXQjL3N9Yd+Wtvo+Gk7DdxVa+0pOqoXPM4GDGzDYuGUKXlVJmsAmUPRlSGK8e59Pc6GnM51Rxr63pRcGpmLKNE1DIYe8DgpyzKVfyrkO0uudjjBhdzoPClZLwhgcqsSPy6IiJTN8H381vFgcwuABEijl97DT2uKlmDwLMSkS7rGvYV1mVWsFjOgTEL2FTGH9q2TmqcQZav/vqEswTpEDo408liNo1rVMgd0ez5wQhxLrkKzCbuFu1buV/2onwEqZOAwAWnQk+B93s4mROzFaXVZZoC4VAlYICxq4NF9ddUWluhjgvv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:01.6251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45045f9f-c107-483c-b569-08deff9f7eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

From: Le Ma <le.ma@amd.com>

Reset the partition count and free the buffer on gmc v12 sw_fini
during driver unload.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index a30942f35faaa..3add79c474f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -997,6 +997,9 @@ static int gmc_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
+	adev->gmc.num_mem_partitions = 0;
+	kfree(adev->gmc.mem_partitions);
+
 	return 0;
 }
 
-- 
2.55.0

