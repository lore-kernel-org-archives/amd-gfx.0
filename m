Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D21C35FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE5F10E8C6;
	Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGrnjAhS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE2010E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6FoENDwLP7z7NA2Umxmxi4ZuRWPyJa4qDGFemHpxQqo6hkVFrE2LDDXARDAHxbdP3GFWDoJOVbU9R8ZOIKqVGhQp3Gi1k1r9mT9zyY5//LFmsXAnHW2eshaBvuptl5yJXGgSpswpKrXuRDG4QHjaWfZ85hRhy+GBvYWB1sxzSwNZ4rR4+267drh7578kYgqQ9P4Nj/ao1i8llOJbJaT1Ev4HkwSjpZx5b33X5/pdeTBLHQe6tJAIWBMjo98VE+xe2ap5uJeFYFK6YvUT+Xz7gPYFssVpCnsGf2KknapQlhVaBbiS/yBbx91OumtPIpny5moSPITM+pVf3P1/4CPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzfNlF+UtDlznjqUi0jOpu4mdLiEdnhKQiwHmp5SNr8=;
 b=m9qVMw3+m5iyE8u+zD3z00HVgVdaxtIHBt/6hR4xIc+JZ2Ai2FBYi6epCzY3R2fYRmlB/NsGL2YRj98eUQmXFWqf1ZhJlrHv95j2lpmJcqJHez0ZGulMqnAmsBib7bgOis0vu7sr/cnLtayFpjkvecIbQdjEaNpgeiFoJ5Wb17ywgFQsYM7SGeM5XL8Gdlavbs9H67lYuk2mtSWgMy6KMiWU2l11LWsBFGycD/nja+cr3d+83Op+J2tGgW1Q1oNp9HsBLRAtPkbmlriYF0wMit+keAFdYwUoCKL6etvcn3E6eLNFsigKnoO1u4QyQWKHHFXY/bFQIJ+3GNS+cj677g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzfNlF+UtDlznjqUi0jOpu4mdLiEdnhKQiwHmp5SNr8=;
 b=tGrnjAhSRfFJCyMLKIYcbVkkj+6cICfGaR1aMlB+ZJqz/H/gpVcbTvNreFCf3ejUeY2/JVnKenFky+rLXFE7bw0iuDlYZGORKtpIv6pLOQk4XbXdrLCnG0svFQzyRc+voG6712YcDRIde0ER9/SzPb7I+ERZpH3mg7KH7MATNGo=
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:41:56 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e9) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 14:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is set
Date: Thu, 13 Mar 2025 10:41:30 -0400
Message-ID: <20250313144136.1117072-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: fe673d46-ce57-44b6-efea-08dd623d3473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xsKwwA49lFV/2wcF6/I03eFoZanPIK/H/ubMyZDFrTALgbFSLZ+aSrsRrAs8?=
 =?us-ascii?Q?0VfxS3G7wPuALxxuS1RYzTEPkL0hLwO+Y4SPSn4pegKPdtGaIvY9KGn3dwOP?=
 =?us-ascii?Q?1Ysh2nHMvk3wm2VDjODYKBysYuTW5fx9k5fgIHyJgYpQi2I2wnVbxSG7MN0/?=
 =?us-ascii?Q?OjITEUQFKkoMIaFs6yaX6CLKs6WI83Ym7zmWZmQPbjbtK3pqlPNlAz5wfPy9?=
 =?us-ascii?Q?YY5N1xIiqv/Q2CWUdeAeoyRY2IStT1phjBJzncMe1cF5CdZXAPqRhQhxR0Z3?=
 =?us-ascii?Q?DTiuuTzWgxqvO0ADIfMiVhgk3ykSWfkCbLKTy2cPLTw/cZnt/Tufecqrfmnr?=
 =?us-ascii?Q?qR2jTs4NP61baeSkJefTUYnc6GXWmcpO36UvAMuFfFIGYcdSLQy+tq3tUt+I?=
 =?us-ascii?Q?I3q22F4it+q8mGymKTABnCZcMhlS9peBD96g9mADfPkEc3alqtfvWGBh8hse?=
 =?us-ascii?Q?X4mJUsVM+ZWEt/r+nvTe1wSEhM+fh4MZ6O4LCKz+UVjzB24LrJOFynENQ/N0?=
 =?us-ascii?Q?3zSGIkJFQFrtIs54niAQW0J3VnqYA5fT8HIhmmT0rnz1hfIHpPW01u7g04yY?=
 =?us-ascii?Q?FkwfWmCQEy1T6FRF0bi1uVzhMpu8I/zsqgXJTY3sNR1TSKk0MrgVua6MECjb?=
 =?us-ascii?Q?qvCJ2xV+g8Ncvtrp1FHuZwgTG5MTFRgILdbljTKp/o6LzdPbUohJBupPcLY1?=
 =?us-ascii?Q?tWONxzEZ5KPgF+sPpfmXGzzsPFw+Ewx8YRztSxjmk1uyy/5J31w3vQ5EtT71?=
 =?us-ascii?Q?kRGiNqw7XOnFmc5r7DUZl330xzDFK/2Hh1DYBc2+Ipc8pTgU75fgEoQc9PpA?=
 =?us-ascii?Q?Z+jR/l461ZrTnUWO/uI4OdkhKFKtQmVhdacAjXxuDnUOM7D9dvECgGRxt5S+?=
 =?us-ascii?Q?GrIGAinst7J/VSkgAzHW3YYPMo61zaWEYB/iCnB2dM9HJ/hKvWBd9dCeEe0M?=
 =?us-ascii?Q?MbEQ/oZDw+qKyGktAt9ieHMD1QQlGMXxaWO+wbDA41t7UBOJn3R5x9F97ezV?=
 =?us-ascii?Q?ZL0ujC9BoktzDSS9bFZixmIHLk2pSWp/89oT+HC5BKGY6fszd6+XRTOrnYVN?=
 =?us-ascii?Q?a534cRnECAmTqvdF/vrMzrLywN4wrEUOAyHYi14juHNplEb3kVVtpnuCGOrb?=
 =?us-ascii?Q?M9HUNichZb6GLP7n/ncvstPqfHArAya6b9rA57Umxc2h+qkfkm6j10czd8Gm?=
 =?us-ascii?Q?emFBNgSGNylbPlAVl+w5/WuvQEjvwxvqhgvQ9/OkpOyGtxuMuqGI+1Zs+yqM?=
 =?us-ascii?Q?DbYX9yhjhKgmN0AUgo7Abwd8RZHUFPIctQJWumGVGxqbY6r6qeR7Mp5l6Ux9?=
 =?us-ascii?Q?aQt9SUWua9LDmnjFKU8dAp/8/OxFVcZACvZMtCbqKCQBgLHSh0vHrido03We?=
 =?us-ascii?Q?HxAO13qId4k0LicUB9v/esvCrIa39qJd6TqA9El3xauHQswPrCSmzqpAIgZe?=
 =?us-ascii?Q?O28fFLWer4hxxDstqXS0XYPRRs2I42CxDV3tJXX9p8ssLWv5zb5VuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:56.8081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe673d46-ce57-44b6-efea-08dd623d3473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

Make all resources available to user queues.

Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5abc1ca0fee98..971bf01fe46a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -120,21 +120,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 * Set GFX pipe 0 queue 1-7 for MES scheduling
 			 * mask = 1111 1110b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0xFE;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
 		else
 			/*
 			 * GFX pipe 0 queue 0 is being used by Kernel queue.
 			 * Set GFX pipe 0 queue 1 for MES scheduling
 			 * mask = 10b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0x2;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
-		adev->mes.compute_hqd_mask[i] = 0xc;
+		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-- 
2.48.1

