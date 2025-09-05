Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2791FCA1002
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 02:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9014210E0A1;
	Fri,  5 Sep 2025 02:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXdLBcJv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A44B10E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 02:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQG+61fJPYjJEQz1t//voNd6vDZ2QUICJHpCMIzpHE+9gDp7TxHJwu4MgRtu0AYQIl1JS2pihtSZgl2rQEYeDxWFJIcrYtfNWzJ7PHOjWp8x18AyY9vTY5PneiWDeoaeWsh8/DxcTFOncbojEmvoxihn/6lPwsiAiUdgzdrqisn7azlmSgLwin5Fth0h1RrtvL0hpRpG+RMV9Ja1eTiBR/67pJj0a7SQZX26Bo+GrkDGL+6MjiT6yfur4xo73SLEdVmf+16elXKVJ+w9nYAN1kobHPeNcupNMB9eQ3IHKoWgAtieiXzgNFz18sqct9Zujw9buCAFRuQEbT+qFoe/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0wqC8vWDbOV/osdrjD4yAEf+vGYyoKigRnWuFw2nTs=;
 b=kWRFNoeDf86esdHDsLZKfOx5qo5KmiuwP7GpUb5ytp9bPLfqH7AX1K/u1aw8yQy7o3/KJQIOaEFHIFe/P4FwA3dSXYyyPCqOVc10FNHEBT3nWH6tr+zhZpYHwRARtyEdMqROyb+zYWWKre4yOK6B549ZyHow9sj+Daq80i8XH8iKlPwSSTGQyEgWJU9kQ2roMFzIMZSe1yiGAWZ0FaoWNiuDrGUs7D81nY2a2XrV4ilpk1WkYXMn/OG6rLdkEgw5DIy3zmuyufDNQY6H5H8v3HDa8FkMnKWwSMCoKBQUVSzC2VY9IZO6Dzsz9M+ZWT1d4k8VkIKUbuJMXRQ1QdHGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0wqC8vWDbOV/osdrjD4yAEf+vGYyoKigRnWuFw2nTs=;
 b=SXdLBcJv9LmC7sDq4ZxaTJ/MTz5FM6q/LZjUTZf3D/IvNFnd1h2uTFGnrVCShHZROWdSXENXVHygqFiDgiYXND5o8WXoqRs9x0XY5XmxvlgMWNxYvZ7Nr7ilQDoa189cjB7PtcVl0rJCKtwVazwxJ5wpGDfIHXWlAzmBoZk/b1A=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 02:35:11 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d7) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 02:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 02:35:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 21:35:08 -0500
Received: from lcaoubuntu-server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 4 Sep 2025 21:35:07 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix memleak of ring sched and fence driver
Date: Fri, 5 Sep 2025 10:34:32 +0800
Message-ID: <20250905023432.929822-1-lincao12@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0054d2a7-3d98-4d29-e901-08ddec24d538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JP1VHsfpcTFoPYfH4JWLtPsGSVrTYbHlH09HcJsrk/ed67QEYe2+LKDUJr/k?=
 =?us-ascii?Q?+Z7CskSjjMN7ddk3h1Rk7dBvAVg2Ag/odKFrNlMFRJNATcq7JoA74vO31ia0?=
 =?us-ascii?Q?x+5Mv47dl5xfuTbw0Oe4cXcrXZ5pIRYYpKDLfYZAfbOwm+8X0BJoJNfUxDqs?=
 =?us-ascii?Q?5roK5s0noD+f1olY2N3KOjo8c0P3BH2Tmp6qtxMGPwhqMfmfmdfGlreK8ZFJ?=
 =?us-ascii?Q?WbaNPlsQKnV6yY2MW62X18mGpMaCj+93I6oLNViGURAd9BWuH71RADl23Cax?=
 =?us-ascii?Q?LJGOZytLPpp7Qt3kyCDkBKQEaMSsTrihQT2DNGLaArGUczI6RSA5ORyDiaOD?=
 =?us-ascii?Q?Hf4Q1Oz307A/U/ht4M6okP4UVi7JOcaaSHHDBGugcPUvPsTnvTDb9ZEivvaS?=
 =?us-ascii?Q?RTFvm6gbZ7/V/UeBuXyfLCeF5YnK4W/KMRkeibHKvZzr/hBBJnEfyNgxsc7K?=
 =?us-ascii?Q?gBVeM2V9S+irhXT2LH9cfiWZvQCP+Wb86KvpCT1TqWQvysQKMH1KOXobRMEf?=
 =?us-ascii?Q?4dnuqg7/WFrLToNEWGyN6eiq42md416A5+T7G5PPB947w2AEHKj3yio58UAm?=
 =?us-ascii?Q?4gMkdcRAzwFAPHeJF+QvR/g0k6jGlc255RmkHaopjXSY5zZ35qHvakrcLJOk?=
 =?us-ascii?Q?mEicqr5SaziVTOgxD0QDfarMCAcjDHDnW4LZHLxK+Ux+LDwPq8ydB3jvqOcM?=
 =?us-ascii?Q?KUjLoh7QWAvYO0ak2hGgP5vby+GLZQS4XEkI7l7eg0SW0ZuiP8iMg4UVjS+t?=
 =?us-ascii?Q?Nh0finSRUdtVQg6VAEsdVOJiUQss8ibE/4U8H14nNf7+DQ95JLMJ+ZJjd7F9?=
 =?us-ascii?Q?4Qb4j9jONyKVBBumRPMz9I8hYEabWd+VfV05gL94McSe1JRcs1JLR5US6ASU?=
 =?us-ascii?Q?bUyzo2oSFKP650O0WeRbeGl4SRlxm57ug3d/Kq7+07nQjdjlXH4FFqTA6ZRg?=
 =?us-ascii?Q?DBsngB1OBnuRSvbqmMXvuZzLf62bBvdUXCq5VLZAgHo4h+NcntTSzrotZvR6?=
 =?us-ascii?Q?2pT0yB3P1TPrK6J0MSuuvagtwFR25nXaT+n3I3UDJtN/wCLz+qkNVV1TN7fl?=
 =?us-ascii?Q?v3B8+gd86ws0kxcT3iFmUuDgunMzE78PAWe01VjJijo33ZDTB5EENGrKa5Ri?=
 =?us-ascii?Q?C/FQEItFN3sHygefZieLSpVsl3kQJd24AVR7HRE5h6UugnKymqC+LPnVX4Zy?=
 =?us-ascii?Q?4D7xEgeOayCllU/Lm68CB7yDjt9XdbSbZcgtKOxGSokRwnbWJRZV1DVhd5oi?=
 =?us-ascii?Q?6ExETyeKn6nD2+pcGmpvM4+eofxr9xaG21y3Zd29xM9BA14JyYx97cCy5CAO?=
 =?us-ascii?Q?bNmYy5YHumDNJdGasx/SSIE96elHbd8RhylkeNqLiCc3Z96tNP9jIbwpuzvb?=
 =?us-ascii?Q?NuqJi5bNVQCR1n5jJaN67taJXD7omrPhBucEwyURfk42bFo3rQi3TYtfYqCc?=
 =?us-ascii?Q?3Xq64+og0Zpl8W7hgTc/WQFX77Lkxeuhid2EiY0QQyYyw6u8lttUBaWRYYDs?=
 =?us-ascii?Q?7SkNh2gqUypOISPEoleRg33mBujd4l619CK7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:35:09.5388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0054d2a7-3d98-4d29-e901-08ddec24d538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

commit 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag") set
ring->adev->ring[ring-idx] as NULL at the end of function amdgpu_ring_fini()
which will cause function amdgpu_fence_driver_sw_fini() skip
drm_sched_fini() and free fence_drv.fence then cause memory leak.

Remove set rings[ring->idx] as NULL to fix this issue

Fixes: 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag")
Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..486c3646710c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -421,8 +421,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.50.1

