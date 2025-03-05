Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1920EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01BE10E328;
	Wed,  5 Mar 2025 20:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlmIvJXL";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065D710E334
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p++K6SnzWvycfmEiGi0ECBRkTFhHS4G/PuxQj6K91mn1kVmYU1T1oZAJE7iaI4m3/tsyCUeFhulH5xG9Mpwwn0s3M0ZBgnlWJpO7ZGP5T0HqOBhyqAzQSj8NW3bqujOUV/xwrYiB4g4VzUv2cf8nqHUa0JNRXbblugIWWycsFUHtcAbiQjlgJXpuNZGRGSfH1oZY89AxOoOdDLPIO4X3ndT87jp/K31LJUgqvyZE3IBfn7fLmGYuYmMth/YsjrVcWRTOcJS7u0gAHXj6gqfM0kCDQsr2dzyF/60TUR7AHhi1S6YmVWj9HZInniqamH+9GsSsNYl8e5wFIN4x8sGkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdHKzEkNRUN0tBYxmjt9Q3H7zcivg/YaX5AwMiDAjI4=;
 b=yN4mmTvgo0Cxs/AfGxtyHQks4LkAW0RyHb5g3mofGYTCFP4lSEfRo2l196Sc3YgXYN3VkAFVc4gh6W6KaAvNUgyADN5bq1ZoXdWAPSwgvFEj1lMln87MLQGbQjar2bHFgfpD+Q1su8FWD4b6oOhPWFeo11CzqIfBxNuFu/JhFi2iqIHpiRxmapeAOZkrPG3+kWsIq4VpasDPsVOx02+DBJ3O3GwTXPcXiQut9tzwiDa9Lk1RJXNpVEefLKBVMPNNLJPimeMkpWkk5QU6TZ8mFOIeoVwWmubKl0kPxdXMkrYYiORYknL3NZo/MBgMfTunLVwTPN+2hgYIrXeQFugdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdHKzEkNRUN0tBYxmjt9Q3H7zcivg/YaX5AwMiDAjI4=;
 b=IlmIvJXLKzXIosLMlq26ITF4p+L5dLHb35/ghk32EFVMh13+LfCgmSw8C86yALbkP3bbAmWLHgGSLL5SBXR9nFMe445rz+MiZ6FMrloCobYcWlBpkZ68WmQEP1le43rzStlCKlYnl0rOW7cik7du/cyDBMgKj85fm8s77c7Xrbo=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 20:47:41 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::fd) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 20:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Date: Wed, 5 Mar 2025 15:47:16 -0500
Message-ID: <20250305204721.1213836-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: eff27d47-24e9-4d04-de06-08dd5c26f91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NJlcYV9H78Nf9lEGRePAFBynH0Quh5rVbQPFI+qhANgdVel8kC/li4G74t3q?=
 =?us-ascii?Q?mTI/0nA5wmiWow/dplQYa9cgJreXlsqEZ8befvC4WkQM7ytZ8FUK1W4/KfiE?=
 =?us-ascii?Q?lPgkeBUZiuwbzNFw0ev5Bxa9i5QkMClsIocarmtP3C22c4AI1hOJ6J2i/P7F?=
 =?us-ascii?Q?/56RGm7cqsyBOR7DDhbRuy7P18TfUj+eqpWXNRkAzxnwQwmX0w8Dg3AyKaDn?=
 =?us-ascii?Q?Risi0YCx2fCiLsErqbTdo2ImKquE+6XBVOT/cRc1+24G7vKrq22Y/B1qeywS?=
 =?us-ascii?Q?HERioTKyQ1rbcy30J5mVVLJ+Jnu5Zze2ZbCxD8j7/w6KnzfXaPe+Xtvj5ih/?=
 =?us-ascii?Q?5oUnPiLDR4TP9vLDUoEr0WqQiVXr+vfXfM0sp088cvPPGP9qBn+2hmYmvuuV?=
 =?us-ascii?Q?Uyo7GPlOkObQfe99TFmGtAgJYJ9TN+40/wfdFCUoOV78TJX+sU1YnnXSBmvT?=
 =?us-ascii?Q?ehSI7D6PRdqcHnCu/bIWIWOnUhvx905anNNtR0vLD3ws8bheIQ5mjtiwSANC?=
 =?us-ascii?Q?7UlmQgTSoabRhgMGvtWfqvhqmj55QHXx2CChES7LcqhSgIDBGdlfF7XiHwNs?=
 =?us-ascii?Q?2E8v2sWlarPMzsp3MaQvfKXURLa8IuNmrih4ZwVRgqErX/Tg+LlomcEdqx1C?=
 =?us-ascii?Q?pnd266hEpXcThTapz/3tXkGmfbLcMsIF0xe8wpGwGDRbMMjfkIIIc5ynfaJ8?=
 =?us-ascii?Q?OmGDH3+t0XOJWQlGeG1dkOe0QAXEP3rG4mcgp41rkG9IUxuy20xtRBQCYeX9?=
 =?us-ascii?Q?FcyQBb0E2K0R73A8y5zrPvLiURvsRsancr1aB0gbuHh2Wstkh73cNL4hAc1g?=
 =?us-ascii?Q?D71ZOzQSjZt/NDkLKHpb0rTgKGErdUX4F2B9h2b4XYXRi5edUmO77/mfyz06?=
 =?us-ascii?Q?dlZirx2d3DCSqJPyN2v1KKzbW4zDpaxY1O+PyIgI8X66fI7E+AkBROiHvQ9v?=
 =?us-ascii?Q?selwBzPobGSfj7T6iAlhyYyAaJyVav48oSRrIT1xh2dkq3axn6uchxRtEsaC?=
 =?us-ascii?Q?0M1lgBkak1DS6OWc90MgtKQLnvlb0z1s4onxiPj0wjAL6577B5NxS7rJWWgs?=
 =?us-ascii?Q?g6wuuLHO5uypnv5YGv2Dw0qkpQf9l5UKFOmgPcgSDSrsR3Me2H2x9kVegsZq?=
 =?us-ascii?Q?uidgWoEL7/irY9E/IaA4f6poE+bn7NhwTrC9w/eLxFSqbOlWw46gy425qvpK?=
 =?us-ascii?Q?RelfeHa8zHcSCvd7HmAMcw5djsdoXDX0GwPYt79y0qnrsUfsRA+dHKqudR1m?=
 =?us-ascii?Q?YV5EW1vP29fclJohMuVWb5yoTkQfNV1SlcKGz4hWzu1BYn8ClAJtrg9FBicR?=
 =?us-ascii?Q?brPHOfSl3menU5a67rTe7gk9kBeU2S7bdv9NFTviosS2Ueuvx7jrWPFlSs2p?=
 =?us-ascii?Q?+GQEREWlv7f4W1AbCvA/iWSyWrnXMGQh4et5NSFTc3exWjQWAYfTIRCtaPUr?=
 =?us-ascii?Q?V2ZxHhLMGiU3YjuoxhcGWsCUFggMTrJVzDS/tnGrhftypr1ud/VQyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:41.2822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff27d47-24e9-4d04-de06-08dd5c26f91e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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

If we don't have kernel queues, the vmids can be used by
the MES for user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 71dce64a0ea32..e2007759f5b4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -142,7 +142,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
 
 	if (adev->gfx.num_gfx_rings) {
 		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 95d894a231fcf..19a5f196829f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ea7c32d8380ba..598324e736092 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -837,7 +837,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.48.1

