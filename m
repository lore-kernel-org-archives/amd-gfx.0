Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC11FEC0EC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F29410E60F;
	Tue, 24 Mar 2026 17:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nrYDqVq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9B010E614
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPBld2OfGcDAk/PjPCHg7HHtp9SSaMQFEqppBK2HAI4upwxM2KWwh8SpI6kVBCXu4tpZQnF/sPcdY45YmJCHysODl452Y3j3xXFr5v2Wzq9wRol2yei42TPcl4GpT7lFrUvs/1cLqyhfqbCTzQjCYMX5TwgoV8nJ97KEzYFf0GsSqhdqeaDYy+OSoG+5intnlASwX8AfuRjVVnaM/SvhIeOjrBBlcvo0volyCr8SYHEUZv8Jw5EBGz//quIZMStuiWyYFCI/VVnIy+1ZorZP/O/jzGGyRqxdrmuGM1iNikoDhc0cBWuQSD8mIjhPwTMTElZ075KtmI7Afh7YTzIvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Wkp++d5z5P2YSwLBu6ic2g4mnydPMc5xzH21QkBC0=;
 b=Ed3RBhBXQLXBt8K08cOnKwqX4ka0yKQ6AcUxzkfnAXMpYRGqj2eVcibO2l20th9zmXzMIRrMQY+vQSLtvbVpFwdX4AWIAHZy53UV7+GiUOeb+Wi/rg0VziRGn0KjVJZCr30gvMzLjypb29CLOYP1ja6NQWaANjy0CgBqGtahWmzvrLObIJZSfRGTM5fZ5VHTuNmuUjC+7kRIAql4od/HQO4Ih/kaMd3TsgXhcQOMk4M6MY8H6HSBNxyV78dtAlogBvYsXk7xKgiMCbTtRy9ooBcqxRcNHKLVOrRU/n6NMe0qnCOTzwcqztJc0CsGhPaj7Gg8qk14+pTPCiZGGs3bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Wkp++d5z5P2YSwLBu6ic2g4mnydPMc5xzH21QkBC0=;
 b=3nrYDqVqmk9U8y8Ee4zhCKqundC0dndK/Rj7VOok4ZNAzjs6d3K1LHuiLs1phQHQnh+hLlox4W9F5aIVWR4SeaW/pKZfMCrxexnXbggMwHtNYKasVTAXPmcrIZuvqaN4QFM7ORMrEIrdfqyhA5LXz9lgP1zOr7I1A1l9atWbohI=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:42 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::2b) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:41 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:39 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 01/10] drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
Date: Tue, 24 Mar 2026 13:56:43 -0400
Message-ID: <20260324175653.1325754-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 633e0673-c215-414c-8b55-08de89ced862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rUcKDpUeSen2jHMIgfYOEa2W0phyTJHaCGAHSwGvkqgu1lcCDITYBaPqebYxbQLXEqa/CLUciGQGM9LzJX9tX/mvZK7scvf8yqM3wXps76K6GS7iWdNR2xS7sUXZJ9QqxmZZQbAKEtjw+GalGXajP5n8i+ryb1TqtOGI7h512q9b+SXm8l7rNahuIqj+IyB9oUAHy4T4uwZKYeSEjzzuLl8LXOZ5OMgJgHMJ/rt0Fadyc2q7bU8PN1nCeWQQH8JEFCRfBXw6X1VkLpi9ZZR2+jmN49mwAjSwKLdxbLxHDvjpllbCbeKQEiH51Wt/MGtdoerWxOD8jZAPw+e0lIgy4KfSmWPgxTPqxLPoYLdFPTEuWNypX8OIbB6z2Lzgc81yJr2/IbXzo3o4aHQOlw/pvFTPU+F63anASa8vN98n1gVIEG1DLGiMZck/o828y3vEoHtaXmX0jO00UM7Uqk2+GWWuhZvF+VLmy1aX6LPr83SMiOy461ZHjZ/cHecKzga1ZDhStVW/xc7DiYZ+7L6PMayVM+9ZDJ55u3ZnTA+vcJUQWAqnCr/sA/bkVWHiHn3LB7XBKHv2Vl306syMxEa4pid8gRmxSN5bo5wR103oMkvnlIeWe9c95WSBvZTROESzPqDjFDRSKCfIWh+DGzOMfRfQAiDON2coJale9xdyPwS9U269eYmNqwEdSMROY2FrnUd/KKi0ABxCMwAlvY/Ib0AqApK0T8hcmBIsfjU51ct9Yf5/qG1WIfLNp2Ypw/DY1n6fdqWY5fJNPfiSp0yBSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1EEI01QGqH78OJhTa64jnkuebue/VLpcGPT4iBcKXP7adUbsaH4Jej2HTmdQrd5gjy/RM/IKlZtu4AloQQPfpafSc6ZDDoF9pahkZIglszlcv5/rvZy6T3HC4aYd/1vJp9hKOy/+MOdkbSdw8vFZj0lSITXgfuUgNLp/1xtXoR1fWAzqryjiMlHLuUPC/j+JLjSAqIcmjarC/WCq382J6t9YlBmQjpkuK64RrO+XuWYz9bI2gbDnnN+gZOn0ZDqIZJWE2smD8R59asGeZ8TdG8vbu4ZU5t4N84P+TcOt1UY8dfE2V6mBe1OOYDDacaFeq1TrO8agzAuqYww12Wa9Et2HW7rZJC2ANPW7ksaK+RLhmfleDFIQrz923eOK1+NC0xGQTexi2ttmexjTnK5tWKh4l0QA1SQtNG1HBPy0fODeQMpI9irmYnif8xhOjvK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:41.8454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633e0673-c215-414c-8b55-08de89ced862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

Same as compute and sdma, gfx_hqd_mask has been initialized properly in
amdgpu_mes_init. set_hw_res should use those initialization accordingly.
Hardcoding it causes the mismatch between driver and MES.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5dcc2c32644a..70d80c2aed52 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -633,17 +633,6 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_1_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 					int pipe, int xcc_id)
 {
@@ -667,7 +656,9 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_1_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.43.0

