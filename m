Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF36CCD187
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D7B10E16D;
	Fri, 10 Oct 2025 21:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RF9ick4W";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0375510E16D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnSKxLXYZy60uetc+E+kPCEsI0/AaPTV7o74ycJQMctH9IIaSEet7bPZfkA6ZKWxs7ufLTt9GkNUI6iX/zpT135KWgiwoC1YgAbgEiyMw2ZPokEGPNU/hvr4elTWoUPjeEukdPAI4WdTpP/XeAvcR9nBGawv2tNlekmWYUdSjqyGvm4qaSwZK+EhmZTWEHZ7JXNE6Rfj9rd02R3aEn6opPdET4eniuZasIkAKYxT0zO/dRj3cPCXbluRMwyF/AKUCbTJZBo0MWS47jEaQAn4AnLS4h5ylYsySvflov0UIEfzqlwaRNbtDX8oSDJ1iLwMbK5Vaq73HO3DngKXKJ90oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yguzcWLMCzB9wcekjeNT+h3WVn4Vb69YJKYdw5co/+A=;
 b=tNBHsdN9KUY9lHupihwM6zDOVXbqX08Q7DovDQDt35pvKQht7NcJPhNOG4uUu2JpjxNVeuxjFLaJhJwqhvE5rfxicK8WHHWaElJTGsIDrP3hL/0AHag2cw8sYJkcO3UBHDs3vKEHt0PW0QhoWSzjTQr1toteE6rcjbsThsZD9iOyL5zphvlAohlQGd4JwnYHGULipzuqI2CfNLiFOedXNUyvE4je5e11q8AUIsGMSQaQHwh8GjOHC59+EiBNmPVKPyaI6iVRAIhvqD/Z9BUolabOb43wqVgI27AcoBA7zVmyODIBDxiiikK6hllm1TzQYQGk0PktTg8i1XeZRhtfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yguzcWLMCzB9wcekjeNT+h3WVn4Vb69YJKYdw5co/+A=;
 b=RF9ick4W/ca1y7wLLHC8B6jwtMlxCXciubc+OMXiyy3B/9m7mpT/yaSzk98oZthu7AOgoDapuqvK8pVTN4kwKJ6szT/cbNUgbPHLgBBtFDQWLlqBGjMkiZHFk0hsXCeSsct9Gkc6gcsGkiX9B/thEYCNTzQJBf+8oU+EIKcrmco=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:15:40 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::b7) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 21:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:39 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:36 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow info
Date: Fri, 10 Oct 2025 17:15:06 -0400
Message-ID: <20251010211510.1528572-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 062ed91e-3e00-4d51-f0ce-08de08422a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEwvqjBf6yMNl3ONlTPxzai1WBPkz0oMY0H7stfB9g4wfePuK5I3VZACFyZI?=
 =?us-ascii?Q?xjSIM/jPiLH9J6qY2Ko6AmFNCyB4YQ8EClzQUknTz1mh0uUhFOjMrtcnqw/D?=
 =?us-ascii?Q?jhVrg67CKDFbgai5gV76pKnhNF9622rslHI1PivgnzpGucSvcBl8MRQIi3r3?=
 =?us-ascii?Q?kk5U9MJ5u9b0yfzZu8W7rg37aOicFPj4a1GdWnIyQKQkrrWjcXQb9HhkQD2p?=
 =?us-ascii?Q?NbjbDHcCiI1UYhCssx0YCbNe936L7HSxHIxCqOMYLSiqGmra/NHf3IJSCqQK?=
 =?us-ascii?Q?zeaHjH35fFp+2/a7c6u+/kXNNx/QsbVgdq2ckaaCeHSKO6uVuJ31B+jhQmiA?=
 =?us-ascii?Q?Lw0Ha6MQc6oefiBUZ5Jl7wlGBhH0rijK0avXUoECH6OKd0y22H/Qn9um+tlw?=
 =?us-ascii?Q?4yWqER/6zJdRzT1q0Ctzpj/A9E+WIqUnYjx8G6ylZxIveLrTQXvGfXf2ysgw?=
 =?us-ascii?Q?1sLuGH6sc74gGXnAwasJ+NMaBeeB55BJIZbVvg59ytQLNLjcAIAhunFaNVwH?=
 =?us-ascii?Q?hjnfhMy9ddjrDL0pZl3kgZfcJVNWd/FM7Hwggb/9ZED5f7K68iDvk46v7/1J?=
 =?us-ascii?Q?awI+ewsD6i8QbETxCLLidlP+T9GAVJDjamcwuANSFsETmPK/0XQNcC87ztMj?=
 =?us-ascii?Q?A75+YXF/zvBPjn1SOP5lIHppAu+M75SD6Q5Il1i8NnzzTC+lp1AQtZSlJR6q?=
 =?us-ascii?Q?tmNNtg62C6Umz/uDL326QNS16+fn3tUt5/ltc+/mHUWO/2XVpZec5YjuLnru?=
 =?us-ascii?Q?Ii2s+cZv9KVAAQICOBt2lmp3a70Cp6KgrZKToE9mhTHsFGT6yL5OQOkP6hVU?=
 =?us-ascii?Q?yjGes/hCrEXZMsLivW//tOJ4bJfSACZuzfLIlKv9Nrj8AfVtaAAQlxBywg3H?=
 =?us-ascii?Q?VckaSkdI4eKsgqGm9wI4yp3W4Lr8Du3+hStfLx+zlnNGfSb+38JfRltTAcLr?=
 =?us-ascii?Q?0Dx7CypsTng351CXxfUQ8e8/0XTwx7G8Yx/yx+q7tDqn1GSCWfzXyspKsLo9?=
 =?us-ascii?Q?mU/VmfLcVIoSZSIRJ8ZAyoZGwyIpGkPSeIjTO7H6EL9uQNhDv6Xx4XJy5IU2?=
 =?us-ascii?Q?F8r7562hLxH86w33UQRyv/kVbBimbByokwoklU+ID1zykx2G+KJaeAYmsR/7?=
 =?us-ascii?Q?UfAgD3aKp8BWUVX9VtU5MLYCakxQTaGlwreTLakLi/1uoxqvidCRhgswiCh7?=
 =?us-ascii?Q?heIJk+lfjCPJPqKEnJbKH1OPjdGSLwkWIKzUIYVm1N54Fm+WjiwZTAkH7DCV?=
 =?us-ascii?Q?c5okcK4XlsoOvRSW/DdGjJ5PwHRBbMsrtLjQFDI+Cpr4fXigio7Cc3Cjy/L+?=
 =?us-ascii?Q?luLITgbIjzqRdisYFZfZLoJD3Uwyv1zdWSZMTNC0tAQVFA65c1jqSkIlylat?=
 =?us-ascii?Q?hQD4AgyPy6Vtl3e7F9EMuUWIdMmEizMfZ/ArH53fEPwlXNKSzaR93JlW2XkB?=
 =?us-ascii?Q?NmwB3L/qcE7JijaCAU+GuUn/EOkN6S0p05Kk86pQvmukAsTYkceobxSi0yZ/?=
 =?us-ascii?Q?1kkbT4fzAuKzMRp5hyvty6FC1f1DmRz5vwVtoRhQniUIFHZAT6IvCodnLZZC?=
 =?us-ascii?Q?SI1aMrdLGRqKEh21Zp4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:39.8841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062ed91e-3e00-4d51-f0ce-08de08422a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
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

This is used by firmware for compute user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029f..7109a2ad9ec36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
 	u32 shadow_alignment;
 	u32 csa_size;
 	u32 csa_alignment;
+	u32 eop_size;
+	u32 eop_alignment;
 };
 
 struct amdgpu_gfx_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6f4c2e746165e..9c79bfa4f1ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1052,10 +1052,14 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 static void gfx_v11_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
 					 struct amdgpu_gfx_shadow_info *shadow_info)
 {
+	/* for gfx */
 	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
 	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
 	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
 	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	/* for compute */
+	shadow_info->eop_size = GFX11_MEC_HPD_SIZE;
+	shadow_info->eop_alignment = 256;
 }
 
 static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 453e4034389f2..fd37f2355f86e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct amdgpu_device *adev,
 static void gfx_v12_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
 						  struct amdgpu_gfx_shadow_info *shadow_info)
 {
+	/* for gfx */
 	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
 	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
 	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
 	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	/* for compute */
+	shadow_info->eop_size = GFX12_MEC_HPD_SIZE;
+	shadow_info->eop_alignment = 256;
 }
 
 static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
-- 
2.51.0

