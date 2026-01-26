Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A583D1950F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E1B10E483;
	Mon, 26 Jan 2026 20:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CTp2OgKZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C413010E482
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz4KwXqv1F5C5y5h7ufX+2MJGHG88Gz+satENpaUPXvSCo9fUBFq7jK4bI5RPByESoOT69bXU0Lv0a23IqumO7cUkcq7MgWQ9m/hsZ89jgPt7psFvYEs42sEBrbapuuVVFwWmlJL/OTyOdBxU5WAIWlYtlwXbgeSFmf5cBwrCXPSmx0kc67xLQf5dhMfmq6V631I+1VIeSvCwztsh6HuXM3MdTC8F1xl+TLobiuLQEdO7re5KXIwHYZFDCZkjaEe4JgXLXf7o9fWxNG2cgauR7jNTNRC3lwdKBaGpIkhitKvPcHySZGKB3SkX7LTtE5YLfI0Dy6E13ru4JNbAMsSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wemQIeBMmKJEsqSza/nn+Syz5Y1DaBtUbutlhQgK/5o=;
 b=RfVggfBLN2CTPXGRgoouKDL5lO6znyCBYbia5VOEheFlUs80aO//lqsCaoABDZDFltyNoyJYmuyI5/OiWEN7hRABWT/21kbjg4HzqtqNqcB+eccUxeXXuiZyrnEwUScP6aqbjXVH4lygSKyu+IxnZzNLNVh1+okbdv/zUVF0dGvvZ/u+81uegM6Jb2XflrwdirhC+s7O1BCsrPtveQ/j4vPyLcI/h654hqTaXc0SPati8MBxrYaezImGDyO7zyafCIpPQCCSZJ21nWKktenJCViKG0rHgz5sS4UqcgrUdLZ+/IUsNHy+LS6moDOyRBhHUt/OZYdDxv86PJWDWKZFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wemQIeBMmKJEsqSza/nn+Syz5Y1DaBtUbutlhQgK/5o=;
 b=CTp2OgKZ5/ACxdg6WfD8vMxrGN6xjzNVEJbGlJSWVHf/NcTVYCEqgy2gPlFGzCB7KKBUX173BPEdPtR7Yy589XgaoW0W7B5K3WHJIyjL63ZIvl5Eqat72AlA1vxwFHIFLqh5pU6euXwvNTcxnUJkixFzQq7R65xZ154dc8DVWss=
Received: from BYAPR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:74::30)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 20:08:10 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::95) by BYAPR05CA0053.outlook.office365.com
 (2603:10b6:a03:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 20:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 26 Jan
 2026 14:08:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Jan
 2026 14:08:02 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:08:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 11/12] drm/amdgpu/sdma7: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:46 -0500
Message-ID: <20260126200747.13527-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 699b07ec-8cde-4876-0ff5-08de5d16a10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8VyQF+eOnMd4qP3M4tHYGw7ynCBwKpAdMAFHMNvEg1uvu3XwTUGtDqvTdxhp?=
 =?us-ascii?Q?Pjqayo/FKkLBOxNXN9NORzdYuH4KufRWbcstHAEvAtTFCPgQwYaIenX/wem7?=
 =?us-ascii?Q?RQR99yVA5nyJb+d5KPmzQ/nVHNuS01Q/yvaqgbfokVUwI8oXMamTv1KlaqwB?=
 =?us-ascii?Q?ezlQ+97Tx4aYcMxyjl68EaDW+qXcO6bC2ZUVheeJ+kK6Cgy6xZJCCPxPJRNv?=
 =?us-ascii?Q?jbNwq+EGrnFqBtPP2qbUpOdOVepeoqj/ORDkDHFD2DT4wK4l/PH2yrqokoiO?=
 =?us-ascii?Q?ng0uSs9/cqqbqfkI3e9QX/nm79TVszM4RKtlD+kGWFsn5GFvjqtQZvLSYSvv?=
 =?us-ascii?Q?JiXNAOqjU1gZxHdRsglPvv0lOgI7ITGPzLkTF/2txXY/DjYFbF4KeG1rbdtZ?=
 =?us-ascii?Q?RRKhaErKRigSXCi6/ZVQJwt7jpciIsDsNOqSty8qNl9rPRzi3D4vQftdzsy2?=
 =?us-ascii?Q?bLdIgZXCUT8lgbxfFyW3Q0hO75vJZfCKwWZg4Jq1mVqtCVY2ESGmE4xEGmcL?=
 =?us-ascii?Q?yaUew5GwrFTKF6NPO0Ey+fpHdDkjYVRKS3bNh54ukPnCPkUJsc9iZMWflFue?=
 =?us-ascii?Q?r4f+PshbEyfdqptldgErLUuka0BY1cnkRDbbOrdd3QxPPRDW0DjtFvIpFFNh?=
 =?us-ascii?Q?uP/mvn5AASEle+StJ9cY82Qz8jfLWg5+g9KUbtRjqDiUyt8gVqs/qU03duwd?=
 =?us-ascii?Q?m8YY/vvmDfUqul2ThyuhPzzQKtRGzkt7WXCuegA1SDNOeVbnHpFbda9+Bkff?=
 =?us-ascii?Q?9O4aIYdVL56EH3KXENE6qR6xeAOaq6kRqG+au8MngeP6DMtOVELhsXhvRuT5?=
 =?us-ascii?Q?54P7bMy23uDeiWTUbgtm3zWSEiVq2ZKxKti1yfJccJntb/vF4SRn5eRBdBSz?=
 =?us-ascii?Q?x61Z1oixIKcDHNwkQjJfMRcqXv73fmBciKd/63FDtvui+zy4pmHhdmdmByNk?=
 =?us-ascii?Q?Khv8CKcLByO3/u39pBBnoIGUxTDGBNb/DoVFmmr3kAWVp9qjfWleGP72V0r/?=
 =?us-ascii?Q?HgMcJuGRO032KeiCWn6QLdUjmshtFXDxHzB2C4Fdne3XO+WYGd7dvlKJYVN4?=
 =?us-ascii?Q?/ZUpsfWkFUQBg9nzsH9RkioxIahiqYhSzGzuuDAZogn9DQXQSmpiO2+InPVk?=
 =?us-ascii?Q?WbaUEy8DaOD9XsT2E15T55eBiT4eu9lc98HG8CZsojbacjK0eYYNbzLkDh7k?=
 =?us-ascii?Q?tGUwesty1LOqMQjCtuH37O+r0u9bkL8jQynfxfT93grtXGAyvhf0haM2R3n0?=
 =?us-ascii?Q?WLEFmZJ9SlCAAb72OOeqj1CeWWVt6qFOxDypzWRQL9h9hxMlerwNzWgv17b1?=
 =?us-ascii?Q?HG/SNsCJgCABc9ZpzQ8wkhtGzIttCrhtDk0HhScHHcvKEt2E9XOlmHIxefkf?=
 =?us-ascii?Q?+jzY418Qe+CMJEEoyw5n/2n4OdIoubdj1GdCqErffGF8I86TNkCNy8IKw9ny?=
 =?us-ascii?Q?zaasrsbmhUXeytIlBJT6dTSna2l43Rdr9QubN70qFsBqABRZ9PAf9kky1JSo?=
 =?us-ascii?Q?+K8iPOfDRwLXFrLvYxUS8gdwIkaNjxqhOd2M0N+VFHQ7d0/ekQi67ELGsuxd?=
 =?us-ascii?Q?RfgWz4P3YQIFsMjavARKzsdBY8Rrj3sUTaQc0vakcFLinwbEl15Wk0YsJ2JY?=
 =?us-ascii?Q?aB1oR5jfyg3vCNH0BpNfBt8eq2EA02mzOcEGoq2W+R9v/N4PNqoGJDhEHVz2?=
 =?us-ascii?Q?QBRcVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:10.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699b07ec-8cde-4876-0ff5-08de5d16a10d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 3b4417d19212e..90d5b017d9e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1545,13 +1545,14 @@ static int sdma_v7_0_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)
 {
 	u32 sdma_cntl;
-
 	u32 reg_offset = sdma_v7_0_get_reg_offset(adev, type, regSDMA0_CNTL);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	sdma_cntl = RREG32(reg_offset);
 	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
 		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 	WREG32(reg_offset, sdma_cntl);
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

