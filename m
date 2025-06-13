Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC87C7114A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237DF10EA5C;
	Fri, 13 Jun 2025 21:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dmZm69vD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7A110EA58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGegwV0baTIC4MYPu61QaLKp3qki0MIUu+3w69i7EvKIzDnmmr9n+edXbn02Etf70Uus6bObLc0cQnBDEZA14bSQZDJhvb2UPd4iYNm4GRxxbKH+5AVmzm4pzbF68F5sKIqrIhbrJqJPr8W3+WkiQcSwfTzW6nlFJe/WxONew7b7RHAYimblMxMNT5yQxDXLJPUwmn4MjM9UlIFnRzeFCiymVMzByeVLrJzGYCb7n8f+7I64L8V7CypZonZN+OgNzs56xRwZFcoSt+N/b+tbNRoJjNCixH4CX+Jt0zByPwB4yu/iVM2DONae/WOqgJrD1aoiVkiv9e8VDqEBNGBSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h7bTaDAtm8ENSZEyHks6z9FSTjMoyyGmmVoPfFUYsw=;
 b=x4h52TbSuZNP/SVJm691qbUxiWIz56Dn60jfHJc3SLK3NfMYpxcaVLOl6xcW+/KYSZrcDw7j+LOW22upKXZJP2xxsuAi0O6b3fMh9mLJtKS63y+60Dic5AMmI7anKdAlFyT4TajRUDDgwBH2Q8S6XsJUQco1WTFD9RP5G0CqNoCUHhKlfYzZcNqFJYs+iBi+F1i12S+a9mqW1uEDfPdCzltkm9veJ4I8S47bYWca2pi7/Z/04O1mfXDNlTG89oSvXcbF+KnE9I+wAUxALASe+LWpuCXVPu/ibrOKJi2WvLnQNYAe2xQjygiJonpvLJv44eX0aOLTk0Dr/9IeHfppZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h7bTaDAtm8ENSZEyHks6z9FSTjMoyyGmmVoPfFUYsw=;
 b=dmZm69vDutvSWNtmyRYjrnANODHAnOfz30gT6Z9mrTo7DwPs8XN0/dmbcvZc9RxxEJGFWmuRXNE4CL9Q0bY32ebCprW4O77032bN0oXxJ1LOFrlltO5CYyBeA+CUw141OJU6QjmTZR7f7YnrZ2raCogUBbPs1rLEFSTk7XJB4L0=
Received: from CH5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:1f4::28)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Fri, 13 Jun
 2025 21:48:05 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::93) by CH5PR04CA0012.outlook.office365.com
 (2603:10b6:610:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/27] drm/amdgpu/sdma: handle paging queues in
 amdgpu_sdma_reset_engine()
Date: Fri, 13 Jun 2025 17:47:23 -0400
Message-ID: <20250613214748.5889-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: ace0f03b-e416-4b9d-70e8-08ddaac3fa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ct9uusfQyLGRQgjtvrKJ25Q8ohfkPeAGC6lFuAUTO9jkvYPxn8fXoowQkVMW?=
 =?us-ascii?Q?tRse/w8Xzn1qkvpTEiQHb27ai68FenaEQD0cJ3oP2kJJRVjzshKf+kHwtVQJ?=
 =?us-ascii?Q?XvTh1TmyNW0TU7ASVNoRgj+NB1lg4OROsbMijIMfIc7Fe0tIaClnE4ntqYyJ?=
 =?us-ascii?Q?eGQpHkX0SIdSzo6nzw3FHfbpqCmP+3TglIdpiLTxtYfcKD/iNTd+wD/AfT7w?=
 =?us-ascii?Q?vj2tMpnh+CTWdTh5FSn//zqGP86rgS+h+Qh0ALqHTksPE3sXJkUzW7FLDtbV?=
 =?us-ascii?Q?n4qwIpCQ7b15q+gXvN/LKgugvAwkHsgm4HEpwiy48J7aBrX7XULTcBY+khzq?=
 =?us-ascii?Q?9vsTJEnYwgVg5BmTI3MNFYr8KkYwsgUeXuCkwWQ0vau5V77mKZbsLOo/X+zK?=
 =?us-ascii?Q?nUwEkAOAJNM7ZRU3ynLhPVrmzcNLKqyfY0Y92v1XaeOB5TJ2V9EVfUeQFB7X?=
 =?us-ascii?Q?4las1z0nZ+dSaH+J72ltdZo6H3vQjz31NZr4mb4RoFxjgjYmQequSAHoVSCR?=
 =?us-ascii?Q?xky/IfiY6frYmMcdiguw32tGORtfZ4ff6frjrKxT3p28xsdW631xpTZvykR4?=
 =?us-ascii?Q?mIj5zFBPo+h87Rfgtryz+7JUUTPPQplSPQ3T2Qv6KX6UOrt41n7A+Rs2k2ki?=
 =?us-ascii?Q?NaTEsGOIvDOpUogPyehp98fqJYut7qRYpYXVbQ/CyEbiozKCZlSjAbvnjEG/?=
 =?us-ascii?Q?UtLKFj00YZ/YoaytraqgtX7afAOyHdMtEON4SC6A5w1BOKRJOt8g9Durbzys?=
 =?us-ascii?Q?APEtpOhijFvcSBRsy1B73hiS/9Pqn9fU9kk2Vb9f7MfkDfjryvHsTdcjb0dz?=
 =?us-ascii?Q?1f8p1PPHK3XuNIlA6Qm0OBXcLKrVc/62wpCjL1uUBeR44PRTZJLBJJaymtFs?=
 =?us-ascii?Q?ARFTmIHx3aDcY4oDsHR8G5rYPggb/vvJ1jSBdh8DRNFlR/+dqlpQQfgP7ExU?=
 =?us-ascii?Q?IEPECDZeTkidtH9lIosHFm+2XkbEbTmGhpW/ZXL2YD7CBqDZJ43Sq0Z0TA8b?=
 =?us-ascii?Q?JCLR6fNyLd3sKwDKSCH72DFf/bHoVQGe5NUQBlQxY1oUW2qFjmWIx/MxzL0J?=
 =?us-ascii?Q?QuN1SDcrST74G4eRY6m154rKnxML/R5bZzwL1eVUEAe+ek6WfvR6GutgxxHu?=
 =?us-ascii?Q?AaDB+S0xo0OUGNdqrZONIXZ2EebaO7QNFeSvtNhAR+HFVvQ6eHTXGTIRnEFx?=
 =?us-ascii?Q?zExCQtoKd7rxhW0LuaoLs+23mqxmj6sbES2WzxYGsS7YmJ+zW7+gVAUIoJs7?=
 =?us-ascii?Q?ipdf7Fukb8OM9bwolTCg4Ab4ZrHGrYIEmqW9WhAViu0xb1PMvdwAyRZhDvXA?=
 =?us-ascii?Q?90gEk5oKW/v1NEFC/J0Mz+ubwS53Y2LgnuWCO/KKpg/dq7a+Qkqlqes0+R+o?=
 =?us-ascii?Q?Wtk7pyZTEO+mm0lD6Iet0WLV7a3lMqhbp+5xgvSI2xe7WzniPuVBaUS+gqfD?=
 =?us-ascii?Q?7H7YXNHv2PGZHqy1yUJnfIn+WrvDAXEE7Q3q1+fmTfRoZCaY0YwTe5G3YntL?=
 =?us-ascii?Q?UtWvKD1xFAN3uhXi2BfEuRbXeHGRKHzKIXVg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:05.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace0f03b-e416-4b9d-70e8-08ddaac3fa73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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

Need to properly start and stop paging queues if they are present.

This is not an issue today since we don't support a paging queue
on any chips with queue reset.

Fixes: ffe43cc82a04 ("drm/amdgpu: switch amdgpu_sdma_reset_engine to use the new sdma function pointers")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index a1e54bcef495c..cf5733d5d26dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -571,8 +571,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		page_sched_stopped = true;
 	}
 
-	if (sdma_instance->funcs->stop_kernel_queue)
+	if (sdma_instance->funcs->stop_kernel_queue) {
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
+		if (adev->sdma.has_page_queue)
+			sdma_instance->funcs->stop_kernel_queue(page_ring);
+	}
 
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_sdma_soft_reset(adev, instance_id);
@@ -581,8 +584,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		goto exit;
 	}
 
-	if (sdma_instance->funcs->start_kernel_queue)
+	if (sdma_instance->funcs->start_kernel_queue) {
 		sdma_instance->funcs->start_kernel_queue(gfx_ring);
+		if (adev->sdma.has_page_queue)
+			sdma_instance->funcs->start_kernel_queue(page_ring);
+	}
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
-- 
2.49.0

