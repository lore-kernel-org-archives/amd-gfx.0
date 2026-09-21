Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18BC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54FC10EAA0;
	Mon, 21 Sep 2026 20:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JS4waNv9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C4D10EA8D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzQ5F8lD6OyYYNSNtuf54U+yrtfCmgZJBbryCKbr7Bo08hUko77UvqoI+AB8FVluFXQAosN29DIYWVmwmYcJcPvQtvX357Q8dA1O3SORr3E7YpcYE+byB22B/lfyYuZfrjrC1LwAUEUVUGS789U1QGWtgoQ1tT2lGrhj4LrtaVcSdb55We/vd1oFX/UVdCdk3+xpx8O2UGfc7K3uopZPqJYajajVR4JI6QkNV848QdtojZBVxpoK8grYQxi82Nt9ZRR81gvkAfoZjn/b+pVZQ1i/I5BHhbpTNaaDKpVelITlXtKij4zrsqJXU4VwaRBnqIwd2NbCaQ6aTk665qUx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3JUQI83b9Zf44Pdo2DslbIwEdnrQqhcwhRrt+3P9Pk=;
 b=txt/urbi5VeU9VQbR2lH2acsO2GE4Zv8b1wde6QCbzeN8fdzbH+UXKOtgzJxUIHrfNF6ijuYBHQJxg3Rs5q3cwiYomzZvLVREsXff41uV/t3hnZueVwd0McNQRLeTY5h/UK5nggFZFpJjemCA6aG3iR+0xvTAjKGLa36FyK2ZkmTVghdFDV88axnMMycWbPMuFRkeQG+mu+tqNBkZyr2+C/qr0azUWefbcs3KDSXhQNdY0/2z4rtGAU7d0Dj61M9TGWSkJFJGVmsumVY3i+s9d/RTdpeb6mGY+lUszw4E5DxSNQbBztaU6hYcvL9IarOaSJOvEUQfqDQK01G1AUc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3JUQI83b9Zf44Pdo2DslbIwEdnrQqhcwhRrt+3P9Pk=;
 b=JS4waNv9IMsMvxcYxaTI+MSDaZdycT6T2vDyD88Z8FuRPVToyErmqC/SepPHd8goC199mUOb0m2AiZnS6N/yc2aXfUGJPoZEFibk0WCOiORdnyJ7q3fG5k+mI/IeTXnqz+OMYK+pdM5vO7eLL3C1nuGxQxFm1XrBNmX+Ae4Dq3I=
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 20:10:42 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::3) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>, David Belanger
 <david.belanger@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix atomics on DF 5.0.2
Date: Mon, 21 Sep 2026 16:10:24 -0400
Message-ID: <20260921201026.2019083-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a219dd-e8c2-4778-d820-08df181c69d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WzfyajpvKbqDPMuzeJB0dQ92uYxWctvz3EvDH4Um5I0ru/CAUAupRMDGSfMiPl3zPh2WdlY9paeuek2qQ+gQVvLfdzSbDLqSrOadNb0Ws+MSfFLrT/nWHVXNxDF0w3Cxjj2xGrDN37sKIQTKen1kCQiwd4AbIcMLdrk52suCti87dS8g73L6BdT2LUtl1adMLAk1qL+h5rYpapzCROvZ5g+/q4HuiDTALv7OJOp2yNEK77gFUz4IbWBdsDhq5s2HotmLlfEDoA5wvAhUnootmJ/0MTNQcM1DElmDhOYfFJLVKwua2R5N9fqadb6hz7oZD3XWFG5wJbiNsIWaVjJ86H2+JSiMmquHCES3Mv5z37C/bvao+ulCu2udXcacR27SLhvmHgXOrWXScLqg2riUTA2tbLV6fon8SKpal6rsTtf967y3/b78UvP/Ww9FRsLGcT5ojBQvCJDALc8QNefRwAWYvn4abov6idZchpTRTlk040HJZmX6ch5tmRwFvWzh10R9naR10NRKQGjPfXX2u7AU400KBuzD30d4V6YxIubXMMoE+4rIEJUPtiL77L6pyIN1WlOgPjeDMCjvOZNHr3M54f8acbDeYu7kerZW9MQGoF57ji4fehXKy6mtcyGg+KKIVAIuKcfZ0l+sEacLrTSul0DNDo3JGkKjtZTwE9GXOTuV5L2dqXbIKf3STlnoMfrkTKXG0H+aGULWPVsNoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uq+EUEWbUKM378v6tO7474PAut5EHmqoW7BBWei6HL4JN91skbQ5S+/t8MNyELioxGBwTS3awo5L8J10T6jZa/BGkQVuSkR6eCGunb7cFALBOkvWKyLBveSL3ZUI4WjxDDay+J4MsEvIQX8MZvtuSrf3GRkGlKUBbLhohg/pch3l2IpDyp6X+LRpvU/oG2/7Xo1Axp0ljpuUQ1BEsfcYSVasPUP6MoHMwTWClE9xHQuEZIPLO9dgmciO2mr4S3Gt9VwYv3+GqyGLVMGxsT4t7G+0Cy3a5NZMT2uvUCk6GUPFBMtkr4iv6TMtxhcWSjpxPEqjtO2VoFIZCkaeuMQYGKwJkW0Y51xpVUd9jObQcLK6UcjnyG40Qijbck7I2AMkPmG8pU3MqGKe82Eutm9JbS3AMlIKRky9jKME3jCq0EKJYYc2ATeVgP9aKe3twnO0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:42.3048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a219dd-e8c2-4778-d820-08df181c69d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

From: Eric Huang <jinhuieric.huang@amd.com>

DF 5.0.2 needs to program DF config register as DF 4.15.x, so
share the functions, they have the same register layout.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9a04e681a0cb4..965063696308e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3871,6 +3871,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(4, 15, 0):
 	case IP_VERSION(4, 15, 1):
+	case IP_VERSION(5, 0, 2):
 		adev->df.funcs = &df_v4_15_funcs;
 		break;
 	default:
-- 
2.55.0

