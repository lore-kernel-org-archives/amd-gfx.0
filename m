Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C49C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 08:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EBE10E0C1;
	Fri,  7 Jun 2024 08:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y2RJ/L8U";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA27210E0C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 08:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOF+rRWWUt/LOfhsfakinNDjnhnTJwBTocgCEXRB0/ueRkSOtQa8tD4ite50bFuGdVz+Znsm11bWNc2+3dzqOS8FrrVRjhR2Jx8btKn9jf5TvpBG9zKZqwHkfMEE4co/9p6Gq+pmU3HeQvc7H+cFUr5wevxosQa1c23O64SpnjyrmbowtgDTV+wuf7pw2+VFV/hJzhWzzlfAvkwx6svV7dM9R/evF2wkrs+6b1h509Uaub4s85O1VqqdZ+xNbJKTvxhQKQmkdoSEk69yOsKAC0qQVUL4zwblOi1dWpbTUih2Sisecjk0tqQG5Amawcwl5kdtHIkHjN9815WmpWZ6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZFLpBbfiOJe1UdGknJYqOmUHoInPp22Vzb6/l59xFI=;
 b=QPIHWXzXQoRxHXCo9ULJTE4pw9wRyTA44DfLm/9hZy46WWHXshDvWP8vjicrWpwwRL6mw/i2AHg7nQmZEz7qzKATmKyex9P+d7HblSlp7HhTNASw/eE1nY4U7nBASEIFHCmTw9yp9tne1sTQUX33tzH1elYCHbF3REGBwZ3OE1f5aZdyFwZzZ6eWWdxQrNqj0Ai1f9T+gxfA8v83wf0x8OZkf/vv3PeOUIGJ5rFmb3PYQVtJoSaNswSE0MqLLDmLffNIN6mYDdWm2pYFS741go5Q/MUlQ1AcPTZhQjZcju+0k3ReYxG5KTw4m5mv/bmDsfEymekVGZl5si8wJ34BCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZFLpBbfiOJe1UdGknJYqOmUHoInPp22Vzb6/l59xFI=;
 b=Y2RJ/L8UsWgaljA/i8JA/nPNemW4KBibhJpYGYJf55nqragitHDCUb2zWzf5vass/vp1Ls4qv7kTlEV0fhz9bhfHe4x0mQ/VHFHblWNgeR1ZZNSgnKZCL8Zzl21TAYY20itgydtDsPLjuDkcsng6q6ZB+UXbV2IrsspNk0LpgbA=
Received: from CH2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:5a::32)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 08:33:40 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::57) by CH2PR08CA0022.outlook.office365.com
 (2603:10b6:610:5a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 08:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 7 Jun 2024 08:33:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 03:33:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 03:33:38 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 03:33:37 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix overflowed constant warning in
 mmhub_set_clockgating()
Date: Fri, 7 Jun 2024 16:33:35 +0800
Message-ID: <20240607083336.65752-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f591bbd-81a9-4bf6-7ea9-08dc86cc8870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mog02fLXgVdgZw2raDd7DyPlWCdABr4PiE9CPAwUHBPH4HTSL8DrSYTxp8bb?=
 =?us-ascii?Q?QyL8B7y1XycR/AUEwrM/HnAaO2ECpp/pqlkzqlm3wLVFxPTJoVy84T4vIoTc?=
 =?us-ascii?Q?S8osvf7acedoaVloq73zjERewX3VUI7GYlz4QOqaj/igc17+LbK1IFvGcgsl?=
 =?us-ascii?Q?dvFRngLTB4IjCIOuccTy961CMgJ+j8t2LxWFQjhsQpnLNJa0GNumAeTUF4sl?=
 =?us-ascii?Q?vxgvAjkx7FawOx/RjLT3q3RRbVQ/mNd2NuoHXx/3Vw+Vsr/PxvZG82bKTK5C?=
 =?us-ascii?Q?Xt8zOFzieH0k1dPVeuJ3JPaE2Gi/gIaMW8zuWaTIuOZ4+XgfE3kcxsP/ZJTR?=
 =?us-ascii?Q?FdBSBlNo5XSXD2IN7VJ5XkKcpgmQ+SwrlqJLwx2TvDblqY1aDrT+BW56sKw7?=
 =?us-ascii?Q?374IVYUzhyHNsDQMVBI3vhzvfgt0WkfaU8ujegUKgaHG+Z6hPeRhP+8g257/?=
 =?us-ascii?Q?EU25j9jDbhIIi/B2hjk6o66j7cj55C49PyG14b3LoFA28ZsVBMId+ZkDk9g3?=
 =?us-ascii?Q?KSBMJ4DxgRv/PlftnWZnnDakZ8CoEWcD+/88szpT2BaQ+DsMe7OG2uZAI8k+?=
 =?us-ascii?Q?JrYSZhTBkIClBUZZvIV/NrgyF0axAy6v4KkYkFpRdvU6LnnmwR7G6jHStTH4?=
 =?us-ascii?Q?a9wTyQz69sDUf/e6gt22TQQMi4niBXSi6IRJoiFTL+mFoLJT4M8NC+RiceBs?=
 =?us-ascii?Q?+HRx0HWms4qTO9fRowDP632awFGDr0Wctkn1Os+biU7cShcqapUzAXnMPC2x?=
 =?us-ascii?Q?6vvqBWrrzqLaHXEKnmzT71Xt5hzZngzJVgxj3WUzfIOTMWcrWB9cdHMa26bY?=
 =?us-ascii?Q?zaHABnD9+MvLDth0bRrCQ+Rwk/Gqaud7vybDAAOaDEInM7IcNcYKN4Utr0vZ?=
 =?us-ascii?Q?uTQxIKHybNnNEp4/ceT9aIfyzA8AF8FgS4bhVD64W33PSO5NHE/GNC9OnZ7S?=
 =?us-ascii?Q?mrUiwKTAl39VCuG8eHu4rgvZ8Eo5ptxM7dx7MPnzH1cHB/pIQN1IvThCoSR5?=
 =?us-ascii?Q?LZFooVhFM2QV+lP68Ngm8yQSrbuu6sn8Fj9cXtTJPuhyCFcKg88rhuw+5l5X?=
 =?us-ascii?Q?uU2r2+YTRf8yRE8FvaNw/uw8gUKZP7y3aRbqZPwVSnn/ofsPB776pZZAVQWX?=
 =?us-ascii?Q?58Xap6rBF79+9y+PkWZgLkoH7lDycEIZGpD5zrhBkGHUVbcEhMBUGmMs14LK?=
 =?us-ascii?Q?ykZARLWPDFZ3Xr2w8J7nQ1dCQD4Q0JA6fIBsiCc3KthqwonraeFd1a2eWVSB?=
 =?us-ascii?Q?QC1J/qC/1wEOS0UCrXrCNB9A/ZKHpgVuxpowlevFZueNiElK+BdGaJMqbj3/?=
 =?us-ascii?Q?TOoAAIgYlnLBBaBwUveJr6puuwPEJljgIPhtj8fX/SheTo1wDxEQthFi2sxs?=
 =?us-ascii?Q?9cHe01Bpm8hGtyOlA30Ozq8AS3uE51tDFzjdveE0XNbeOFGCxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:33:39.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f591bbd-81a9-4bf6-7ea9-08dc86cc8870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

To fix potential overflowed constant warning, modify the variables to u32
for getting the return value of RREG32_SOC15().

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 92432cd2c0c7..9689e2b5d4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -544,7 +544,7 @@ static int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	int data, data1;
+	u32 data, data1;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 02fd45261399..a0cc8e218ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -671,7 +671,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	int data, data1;
+	u32 data, data1;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index 8928f9160822..b4ce3375d3fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -613,7 +613,7 @@ static int mmhub_v3_3_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v3_3_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	int data;
+	u32 data;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 1b7da4aff2b8..ff1b58e44689 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -657,7 +657,7 @@ static int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	int data, data1;
+	u32 data, data1;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
-- 
2.34.1

