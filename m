Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F0E77179
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768B010E05B;
	Thu,  5 Dec 2024 17:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbUAzMFk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F110E05B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7gZ9reRA4Vr2QnEMudHsmwSvtk/EAm7VBRpXM2Gv+pb71ZJqgJvFu/tS7HL8QH+cksgpUmUkL3Ag4d+qrKREs54jYl9llCb+A0AO3Ow+Zwh0y+pgb4eF+bqSHt7pZohT0KDvZ6gd1xSc2DgrQ1pJo1wUjJF60qZSvsLvjI8if5/nFAFWKM5ec51mj1/vQ1llVotsC/P2SKpmHUVdlQpxwWd/Yg1O42FTWysG0OTk+s23m9kj5m/ws4IbiViDuWILvOg6HQlXvrGz/dHKzubuwClKPDYFw2QSnHfb6FeZEK3+cF8vVZTfYys5tdBaeOixUhf8T4R5oQyYCyOMF2jPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlT3FmY5t7TqJndl/2XiBLhNmDqFJFCMuN+ix0SOa5c=;
 b=f1vrwdrORU7zP5bv8c+pMR3D6sro8bl3eAx7Ucw0Euo035A7O+PnZQGzAHy70MdmSXbCfOuRhw+kFAuZXE0kOYBcJyWe58g1VE27mDa1k8b6nfM5dKIyi8XPxMo4BPc5vzBKB486fGdG1DWZhK3W9V+qTey0KZQ9xrFLIhVGSXTCRsBdb9igmq2v9ixeQJj+8nbVz3NL4hxi+yQeEQsXxKH8KASuOdwVyhsgV0t9XD7COMzK8V4eCDDobNi37Wp1p+hwLFN33W+AAjK9NfXI4vAzosGqw46gI/Yzqxyr3iU6CEer39CmRpSgpnPMWVh1s0v92Cc8BSrCj0QgqF1gPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlT3FmY5t7TqJndl/2XiBLhNmDqFJFCMuN+ix0SOa5c=;
 b=qbUAzMFkGj6CXeexolEtMvWdRdqJjrdU0ykKhY8F8stHXN4NW2l8drLojQ/S4NKc29+DmKdOdvsL5EEMZtcJie0lNV3iapEq5kEFepR31VLAKbh/yRDRoRWPYUBjxuIa9kogkrhezM+ZXuz5uzFoyB6x4FiOoG+A8TJdbMFbUvM=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 5 Dec
 2024 17:36:27 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::26) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 17:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu
 <leo.liu@amd.com>, Sonny Jiang <sonjiang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: update macro for maximum jpeg rings
Date: Thu, 5 Dec 2024 12:36:04 -0500
Message-ID: <20241205173610.334358-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: d94af04e-8173-426e-9a96-08dd155358b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Eac47vGmWj/+BMtz9U9DXUv/CUfsUsgVuy1g8YWnbXe3a+RHOlsBdZASKByn?=
 =?us-ascii?Q?wE8QPThgAuVSxFHrRueTN9FGu+M9tyhglsMzGM7nTatEOj08WNt2s3dRxaV1?=
 =?us-ascii?Q?d1TnASs9Y2ADzgDKfojwXIs7/8BCir4fIatrOMKe5rkWa2T3mJBzAbOPzZPF?=
 =?us-ascii?Q?oJpG4tzFY7JTUdJt/BWjVjkjR3eWnmf6VV8SmrQYU8rHuYWvCt0L3jTp06F1?=
 =?us-ascii?Q?OIF1yuil5TopNQuat7K0mUMAB+OcxmpH21q7bO06rrFNfza7pi687QP/w7Ou?=
 =?us-ascii?Q?BdGDRwSXS+KLsHChbIJnYeaRnAKTtQ/sFr+6lWh5CEgWgn3pLfgvMkE7PIpw?=
 =?us-ascii?Q?EWQv5q5gBSultoSJrL5DOY17L/k3aaejpcirNSLO63LjAljEQ/aaAjVCXpsf?=
 =?us-ascii?Q?yskM+iLlET3MvHlSwoA4P5WDfuZmNaW1p76+uTiNRFeVVVephHbM2fmPGfb3?=
 =?us-ascii?Q?Gl8rf5TtfizVyd/F8msth/eDmRD5DA7rOruumyfH5ilWA21OS4OBLu1qIARr?=
 =?us-ascii?Q?4CR2qLVQGthXbfnp3i3qhV3sYS+JEDIBF/EySZaetpH1bVymtPpQqCeQjn7C?=
 =?us-ascii?Q?BS9qeDWMatUKl6XXl8u8huxGjZBWy+1G7z8quCzDvbpdbjgoU7wa+dXkiFBV?=
 =?us-ascii?Q?HbdOMJNBsbpBJc1SNo88kwWrGZXlEmPKqewgkvuLMtoz6GZCFYXE3PCabqHz?=
 =?us-ascii?Q?sWRPPo5LLaWWgNHXairaRaHhpU94lqUcRBwhGGSO5Yc4mpscU7IolLTRD4Bb?=
 =?us-ascii?Q?g2I8Ye+JoCoKjkD9aC7/5QlWHCK561tse/KRs48ZkqQnVPd7h4DEP4iam2/A?=
 =?us-ascii?Q?yP+CKA4cpX6vG4hKg1SB7Z9BY7oUCgI07mV1yPXUrgoedFVTA5gOohzLd4ZK?=
 =?us-ascii?Q?KvYgXPEBbDe7QCnRV/lua12CLgWPS+qiBhC72PdCZXSPRkGgMm+ECwLoHJ8S?=
 =?us-ascii?Q?pbqnPWkU82ybCfXO/11D1SlGUKll7lzJ18vAPJy7/z0Cbqer/M240fDo6r8g?=
 =?us-ascii?Q?Kh08nRbBje8IBH590x9q+qb4OlPaM0TJNRXnHlDe6D702FNbMvL4RvO6Copj?=
 =?us-ascii?Q?yGDLWwKBxPDnKSVUpNRV+LpIk35O+OszmWgK5xWZi6aZYF+5O4BHRxf2Q40D?=
 =?us-ascii?Q?aFmbotXibnrFzNCAXFj6ep0do981+AftsjopXY+3+mR9p1V2dkAsBRHjcZBH?=
 =?us-ascii?Q?uA/ACisNtYypk8C0Iv5mH+zisb2GLQofk8fFDZEcRzsNGM8MJVnDJgEq6kAU?=
 =?us-ascii?Q?z76R2d+4hkloLFlnin2A8amsuIu7i1jH4qO+/5S5OXh+tYnAnZAfIvV2U1Nc?=
 =?us-ascii?Q?NUYhckscjWxCu2oawEROZOkUgKazLo96wn3nEo/YTFtb5VxBZUKCJWxZrQa+?=
 =?us-ascii?Q?gywo9W+sSUpLFZpp2wie0PiJvedPWIvkplvSNGH6JlU+IU+omENt6vP9S9my?=
 =?us-ascii?Q?vt999a6S+dInuOjk/dssK0B4cbXmTNVZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:27.0397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94af04e-8173-426e-9a96-08dd155358b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Update the macro to accomdate more rings.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Sonny Jiang <sonjiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 3eb4a4653fcee..d9cb343a87084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -27,7 +27,8 @@
 #include "amdgpu_ras.h"
 
 #define AMDGPU_MAX_JPEG_INSTANCES	4
-#define AMDGPU_MAX_JPEG_RINGS		8
+#define AMDGPU_MAX_JPEG_RINGS           10
+#define AMDGPU_MAX_JPEG_RINGS_4_0_3     8
 
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
 #define AMDGPU_JPEG_HARVEST_JPEG1 (1 << 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index fb10ae873e831..fd0490934f912 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -76,7 +76,7 @@ static int jpeg_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
+	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 
 	jpeg_v4_0_3_set_dec_ring_funcs(adev);
 	jpeg_v4_0_3_set_irq_funcs(adev);
-- 
2.47.0

