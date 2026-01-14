Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB6D38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145CD10E64C;
	Wed, 14 Jan 2026 16:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wMUZKlsc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C9110E646
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfEW7AeU2E6VP9gEl83nKf40Ib8GjnQjekAGZKjXtwHZTdbsKHBoXtZw2rgP2bsaN8lCC902BPSMAL0F51PMSowgrCFGtWZ7VScwtHMDq5l43ndgJaYSkvjAv67em4W3Zy6w6qzdtLdKMmmSpVM4BqwswtGIrI8lIvBjSap278iTaB29NfEDAwJoX1Vnqdn6TP6i4Dsq8/NuYeLUIH3mf2WhEGDmkG/dE4jS6o2MUk4+mrezK09il161PY6H6VJ6vm0xezX4nIsspqCwfBnp1DmmJWHY+fSgGbN4EKwn2OPA0Iyjsx9xQPA5FkUBSCWIyx9iJzUPt9PXohzXTUcaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpFm/GuNa3b7m8exT9+C+9o04Xem/SleE4Rkg20Q6W8=;
 b=UhGc0N0iZYV5bpAMFVebn7vYjQk2fRxbcgu8HgJVK0gjz3mEWFLanOnsdh/3wSzkBIe5Yhmqh1CmWAQnQgYMVg8A3W15v+Nul9frcA47xfktCO2aWRW2ngANc/L0FGczckiuFxI4+fDA9wejZlg/IO1bkf3ztkDN9WnD0fLXTzXCTZsXrEal49sAQpXP6mVEZnuDH1bvZHf/kpSqjpAqJjbITlApZR2mttM0HjGeWAZJlLFgZnwa4CUIQKEjdboHh2gJL2ImSlKoPePp4UWuJuLGjACw2+K1oG9IZIXOsQRe4O3HfDRGoJx3crKwya4NCznikTfEkLazmn4mljZqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpFm/GuNa3b7m8exT9+C+9o04Xem/SleE4Rkg20Q6W8=;
 b=wMUZKlscaBmFZ/TCNR+ZSmV+jFLU+gUIxPTjQD04zoMPmYUmC5p45huQCX/Jlf/f3uhhNb7vUvUiEmZJ6WmVRoJU81zpfCPHjGPZ2B4Cr4AQ5sm4C8LjMCyJi+ZdTKYWRLpwN5H8jar12pIztygSMFvo41ksu1y1HJ4OAFvxyoE=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::995) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:52 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::cd) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/42] drm/amdgpu: drop drm_sched_increase_karma()
Date: Wed, 14 Jan 2026 11:47:13 -0500
Message-ID: <20260114164727.15367-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: f226ebc1-85ec-4c50-0926-08de538ca8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDVmO9eY4vyPu+gUpNnj7qlR0+gJJWuydeDy5tTK5rECYotNsombLXKobDzv?=
 =?us-ascii?Q?WoakngQDdHdympElzB2RBPEMI6qjbdgMoG/UBbhL4OmF9PmlxQSllo6pqOIu?=
 =?us-ascii?Q?OZ940rJarWI7k9CCRKwmN8MSK4abgEX8BbhibnsdV978/ikn1WEQ1RB+WFc0?=
 =?us-ascii?Q?uj9O5q3CPx+9p0pVOFSB9XATThTlOxiCLQaeKlgnpqvQSt3Flvaq+DXTsP9i?=
 =?us-ascii?Q?KQY99exUIWQ7v+jckrWUOSX679hRAm6JxtdPLKmGKQ3IIW6xygPtaO1WVy2h?=
 =?us-ascii?Q?q5805GnxCKNdjCXY1tlSt8u0g3EF5HAhgxN7+XiRHqmxlpB1/W2Yt3wdgiG3?=
 =?us-ascii?Q?LZnHMS3Uy/24WC/gdTl8DpFjyoHkZpCRoh9AaG3XKG0XDX1aC/E5/K8u0Xvs?=
 =?us-ascii?Q?gx7ZvU6ZYek0VibtXetAA8/T6sLg+Y66GyXPENbXtmTWnyiMEoBE3UIszcF3?=
 =?us-ascii?Q?GaYknYJmtmie8/rgsvk1N3co4Lm7GPv+qzW7vts8JM+8HUvIceILCBblcbpA?=
 =?us-ascii?Q?tIWoRTzQqcLlHSqCY+OFPdpGqoeGqjB5Z1Vs2SMkaELhqqgsCI3rP0GEje++?=
 =?us-ascii?Q?mx+YuUMOikfOS+KdFAsnzZCmB8c15LijBMebbNX/HryCSzKgS0Kr/v54I787?=
 =?us-ascii?Q?z+/ktFmGeLi0viCKbPTO5TqcVsCzsIkxaMFE9WT2HMH+v6snR24HQ8jfeuXJ?=
 =?us-ascii?Q?N3jtpNOx+NTs1uYye0OF+jsTD3SCRG0V93M3rS8Ftf1vm7je2yVjQYaIAEkH?=
 =?us-ascii?Q?Zc5ofCS2TnfCRDb7Mfa1J1MIvov1oDZRGGgjnbdSu0A9fx/SeV/8Bw3LCar0?=
 =?us-ascii?Q?i0MU8eaB4QqXj40Zy+6SYmp9ftYJTaqg8lJ9fK7kTrvhw0vyxyi9ZMOgA5ds?=
 =?us-ascii?Q?zZrzixBURmgPZwc4lIbdpTjgCib9csiozePt/1dGP6LAfCSX/J4Z5XpdfjqG?=
 =?us-ascii?Q?PoPfBWgXtyobkUToQwrj7OXcynCjIpyBwIuSphNLKMAdSklRT7emJdg/S83e?=
 =?us-ascii?Q?2ytJ7+OlStiQGhy8rEnUfMFrlmwCsDDqg7XNebYdmTUCyE8lW3fhI4I35uI+?=
 =?us-ascii?Q?5uPjXT8F8rtDijHWZvM0PwyfwrGd68YB+ABHBe9xebKmgzpti11fKZnOU7/u?=
 =?us-ascii?Q?VGWcJf2/jFSFj7x3GszGKulviepF8Jt7hwfi+7BtgiFpiF+lIZSGSmu2A2QB?=
 =?us-ascii?Q?fJyxSih0pzn0gzhRGFYJKVPUBUi5WLfi4Nle+q7OYZbdfMittnD8ztJA9Vt/?=
 =?us-ascii?Q?anv1aDhIeq96fRKfQHXD2KfBAc3OwQgE4OjnopD+edlOCIg/enqG6jxw49CV?=
 =?us-ascii?Q?3QCobN7CG4flRchzcGuAI30py4m9++tlG5P7QpH69psRRST9ASTQCpaoRHxO?=
 =?us-ascii?Q?66YlQ9xL9GFJKdvo4ypdPE4XEd0zrOIXLdslQWkfnpBt9EUOSSPrHLNIVpjy?=
 =?us-ascii?Q?4MwGwoEBj/93IYzFHgPUzq+/zd6Ll/vEJ1S3e717WEG9jK/rVv55U8eKVaF6?=
 =?us-ascii?Q?EokkhIluW4NTDmIHiswjT4bHSAnSJof00HvhRpt75cPRnhjmf14m8StDi54d?=
 =?us-ascii?Q?uRpIi59jPqTLgT3fkAbM2AcmVp0iPErdsDLXXFGFOXf6Vix6TS23RJmTF/DL?=
 =?us-ascii?Q?nUx17L5OhdCkCnSCiPkHqzEt/KTaAQ4nXI+kTjIxrJEHjyRgXnv/dJHBNAqp?=
 =?us-ascii?Q?Z4DdAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:52.7348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f226ebc1-85ec-4c50-0926-08de538ca8fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1
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

It was leftover from when the driver supported drm sched
resubmit.  That was dropped long ago, so drop this as well.
Leaving this in place also causes userspace to treat
the context as innocent.  Removing this fixes reset behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 673f65d54accd..4a16001434ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5816,9 +5816,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.52.0

