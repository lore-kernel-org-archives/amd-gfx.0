Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00720C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9533010E9C4;
	Thu, 20 Feb 2025 18:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsVG3zJe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4020510E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jExcQ23MawPi/5PVimSFHi8B/W3uBOzQhfdxELemsU9N8U/rkH1Po48DUaBZGUCi8DAHFzOVCnGlSJtvjYQGCdsUn7XAQ3wjuQeZD6RFzB+fi7Ldqt2Rew7FcHi9RJ+AhRUytDrC7mcuL0gkWyLsSM/0qzPLrBo3mraWcUZYl5tXLd5oCyEqkE7Q0CgVjizPA2zUrZJ5H6W7ElmMsAH5nLTBKndb3Zjqvkvv407sjJdQJtaOQBJr1Vx8U86yDFYZaEerWx6brixDnYUlU84FNsQ+wmR0weqKraNJnGBNpt3fRTCKz7me9UGSEU8Ke+yHMimk74+ufqKZ/eBWJGQ+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W86jixlNexr2oBBhAAuPtp0d6frXakh/uQ2lt03sxM=;
 b=KCoXyij0ISUxzlO9PylqYJScpJ+wFDu/jaDHgE0TEZV2i6L5bpZRG2HXkuCieeW6XPwgzfOFpQTzwDQcGwAdygqnTIwRwexEtjfnt8wgbpV4g2e23tOVt51u9JzWR5szjuSum1TS7QAz9ZgFazUaJrC5dcAvBr4HyfEB+VEvb1Y9Qf4vP5NP/CRdGbrAm4/qx9sNNe89o6lxuMMySFb8EB6byzIia+DMXE/OML7ZNGAz/79lVT7y9o0Qav6St8hQG5ujWXwKgNc2NUsC4nMwXo4+zHnCDBrVaPKXnljoHFP68HOQgqF/Cqqpg+im39fgbJzMGb7wgZJjtFOtP5zbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W86jixlNexr2oBBhAAuPtp0d6frXakh/uQ2lt03sxM=;
 b=wsVG3zJelf45n0mqGLaynN1iKKg+rzQ4HL3e1+JJ+hYBHY/YgYhQfKzIq6jHnMGoHzb0dYp1I4HIHHFNEiymg5rq42tyE/Nd2iLIczT7JldduLq+OaQv9NnwChP/78619vduFvYaLZPSoIqSCRtuOo6WKbiBF9gofsH9I59dhPA=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 18:33:42 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::c3) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 18:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:33:42 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 12:33:41 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Replace DRM_ERROR() with drm_err()
Date: Thu, 20 Feb 2025 13:31:10 -0500
Message-ID: <20250220183326.2957649-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
References: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d533a7-3015-4f00-37f1-08dd51dd1a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6G0j+seQRH0RM5zm0/Kybqy1Jb3mlUleo9EmPfKoRzgT4bvEdMmbEnkFAqY?=
 =?us-ascii?Q?reJvn5v+L9+vgY77/JLRh43woACSOWQl/UqzmOZOwK2bmQAEk86BqEW4aQZp?=
 =?us-ascii?Q?Zpno+KoqXPl2OoLzUfJihhjvRnqVFSVC9fse8zZgq3owJJLTsGK1E3/8+/wr?=
 =?us-ascii?Q?9YzhgZeIW/mB0uBHj/OMgvNt68Bx83+BHtDL1ugeOQR7awlt5HmxS84dXHrq?=
 =?us-ascii?Q?FuzLPU2rk/L/PyDAgS5RElAL3CUOtCEx2v1hn5nJi/dV2W6IaTJtO5y5Jv98?=
 =?us-ascii?Q?AJOkXrQRZvMp8K+eoGBzsPrAgUwSp58qEko4cTuMlLGO1SrX5XG9Oln2yeFS?=
 =?us-ascii?Q?cLnRg1lo00MHt7NcFzZ7YMceBcjRfxQ/Y9ua7Ruh+16MWRwl+mBtVVDz4q3P?=
 =?us-ascii?Q?lSLBLxZ/+TPb82iStq6SJ0Jnoa05/bB/iZD6Yv62Fdk0MT9boL9xXB5qhrfH?=
 =?us-ascii?Q?WmiBGnJPvBCD5Wj4AwJyIQqkNEc7YQBrAFvVHlK9ZDzryqJ3K1fQzlgOTo0/?=
 =?us-ascii?Q?zpFaHFnH3t1El9QtA3JSbO8Bbf37DQIUKgdGkHTR2eG3gW3Zx9Zh3GIIZK6O?=
 =?us-ascii?Q?80mfgFOkfnHIWwaZ4bFwzBS3DPZHbuP5Bm9AzPceUA9fq2/RkuYW9AE6JnSb?=
 =?us-ascii?Q?cYN0svcCyGYsgi+L+ZgN820IGnRiuF4lvxmqaRS7mYKP6PYBUe4POT9BayqY?=
 =?us-ascii?Q?eALVy83MdxIjBcKiURNK+Y2ZqSD5x1/FPrsci2ALNJyDOnworx2RkiP+kT/0?=
 =?us-ascii?Q?0/1xGPrN5dBrugRCSwpjkgqhOuvCCPg7kQvdHOaq2wTL6uGKZjuuBz361AjF?=
 =?us-ascii?Q?cKzO5Gqe/4U/OwvBPhGN+vBoXYQiZ1iIhwzl6j8iU2AWIuF2QCWEALsS+kA0?=
 =?us-ascii?Q?Alo5Hr2L7RLbNtVVg6wMw+rMUEbrrG0kBGHr76gYXdZiYb1CSdwjU3bmh//r?=
 =?us-ascii?Q?3t/wlav419LEPnwK+VjZosq7WruxJu5++SfTLhPv1Lti+Jo6wS1afXglQs5S?=
 =?us-ascii?Q?138IOnqTKOLyConNu3pXTFQeHj7CWBQHwxF+RRnCv8qONX1mwU/E5eRffBYA?=
 =?us-ascii?Q?qE0EoC2DCIhMSB9Hu/tUHeG4LMC8bGKQvvw1YSSGp4Sy7I3BVzn9ub/YnryX?=
 =?us-ascii?Q?1ZzTTsa+i45H7m8EhtvJ4T2KmRZdbs2Y0hl3xZaoLTj0k1V210VNBonxfrpD?=
 =?us-ascii?Q?Xhdtt8xhRjTiTE+voikKv3MuuSG55hxRAJ9x4qLLRYw3ssosRt1r4uVDBRoV?=
 =?us-ascii?Q?w5JNM5Y1pwh+ywpl3x3XU5jFXw/2YWIb3p3x5wAt38QKX22JKm3bDY0nKYB5?=
 =?us-ascii?Q?O3qlMpDcX5IHYXSe1/I5VFJ7F3981PiN+O/oflemnjLUKvhnGKn/CTJEtsqo?=
 =?us-ascii?Q?Eae7/3Hpa2B6BNwnQRPkdPoGKFg5GBU4wABBHHN/3NPP1AZuhhh8AJPna1Iy?=
 =?us-ascii?Q?HhKySlY7kIuYO7gMRCL0zSRa3tGg848eoWwAE9WWAedoSI2XvBwLg8n9QgeI?=
 =?us-ascii?Q?GgAg/4reBCjkXeY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:33:42.3885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d533a7-3015-4f00-37f1-08dd51dd1a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

DRM_ERROR() is no longer preferred. Replace DRM_ERROR() usage
with drm_err() in isp driver.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 15 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index 964c29ef25dc..2475564b2c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -53,7 +53,8 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd cell alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -62,14 +63,16 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd res alloc failed\n", __func__);
 		goto failure;
 	}
 
 	isp->isp_pdata = kzalloc(sizeof(*isp->isp_pdata), GFP_KERNEL);
 	if (!isp->isp_pdata) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp platform data alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -114,7 +117,8 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 				   GFP_KERNEL);
 	if (!isp->isp_i2c_res) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd res alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -131,7 +135,8 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
 
 	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
-		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: add mfd hotplug device failed\n", __func__);
 		goto failure;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index b56f27295468..3ee5942bc24d 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -53,7 +53,8 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell = kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd cell alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -63,14 +64,16 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd res alloc failed\n", __func__);
 		goto failure;
 	}
 
 	isp->isp_pdata = kzalloc(sizeof(*isp->isp_pdata), GFP_KERNEL);
 	if (!isp->isp_pdata) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp platform data alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -114,7 +117,8 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
 	if (!isp->isp_i2c_res) {
 		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: isp mfd res alloc failed\n", __func__);
 		goto failure;
 	}
 
@@ -131,7 +135,8 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 
 	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
-		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
+		drm_err(&adev->ddev,
+			"%s: add mfd hotplug device failed\n", __func__);
 		goto failure;
 	}
 
-- 
2.43.0

