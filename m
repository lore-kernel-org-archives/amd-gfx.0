Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821CFD38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D8C10E66A;
	Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBBFO/u2";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD7110E65D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS8PcBb44JE4XjU7oSPEqjHCPF24bHxBAzKxTiJB/tDNfqAunZ92sBTBXpGW5O9AhHSwLILfw4x8UV3jFyTWW5W54fndRgPL6XI3R/oUDCnzq7Os1n93NsVyeqHQh1fFTzmuYyFFT7MW6R2nU/eOHJcRudZcvbUTiopvtuNh5Nvk5eks/jh+49OvdxC2y9lvYgSFu3eQd3GAhm3mgJ2aiaNDmccGJtQ5wtvfFor/ZahPVVDngJJcEeQ6K74RQTGMjeYHA2veyKSV5ola1XvKAlWscM8cTIarEIjwuV8PZfrHvkBpPEuQrmBfJusw0NZnMJ868xqogVVHul+0SP0yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw17zZjufnMlqD2efuDxp/SsT06X3wIJCLcdFaDHCbA=;
 b=nEdW1gbWE4Tuu07ocaMorRyH+rEGTgLwehmgRu3O5koEywjVaqgT8eMqgiPnUBAKfpq0ldMmLOpG7asylYhFlLXoCcOxAQEHpcv9lhwxbOAVyfFClwinm/ptuhYgn8oh1TlwHTTJ4O12RDeBZSJ5LD/Aj9CZsVJE+ogtOYqRMa7/qc0S//55U2s5KvpeR3QPOVJE4v5XpfVe55qq/eNGETzb35dgS/x3x1X1W3IXhdrppCYTMl8DHagGCC7q7rXAF/FK5/UnbvJPxsbAPXQVxZH3W+W55Yt7kkTGZr+3RKlSPqeXpjXCcEvHChhld/n623pEY0+/D/VcW4k6zmGV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw17zZjufnMlqD2efuDxp/SsT06X3wIJCLcdFaDHCbA=;
 b=pBBFO/u2Dm0uH7+JQjwLN5xp5nLE0BX0FsIl4hs/erRQYJRcPYC1uWWUFI7TODMd9cviaMb8B2IDrjjm6W4wKrybXXme/txqIOOzaJt0DyM7SfaRsp9XXKZcYmjRA3bTz1WK5zj6jJZJ4CnpCGRsx4xqs+SlnWyMfOqaxxfy5hI=
Received: from PH8PR02CA0015.namprd02.prod.outlook.com (2603:10b6:510:2d0::7)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:15 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ff) by PH8PR02CA0015.outlook.office365.com
 (2603:10b6:510:2d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:54 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/42] drm/amdgpu: move drm sched stop/start into
 amdgpu_job_timedout()
Date: Wed, 14 Jan 2026 11:47:23 -0500
Message-ID: <20260114164727.15367-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 168438ba-fa09-4c17-a482-08de538cb681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KG31t9DfPRxvB8gbRAuILmaPPikQML4IEuMJs9cLFBDn/Qh9e+F6flmd4IKl?=
 =?us-ascii?Q?CYml1W52QIAQX38EfXDRoqNniD6gNp5oAqTE9OqrHP4Sgo0QFunzXLhDKV0B?=
 =?us-ascii?Q?Tqf8TdtmDxEDYwvFCRUr1deRqBqsLYOFqGXG5cTMtZ+ZTrXkcksoQyBwfJXI?=
 =?us-ascii?Q?F+oPz3Gpyf6/hCgKg15FWjubrv4ldOHj0P9+VhmarPqQvqmk6Xltf9qSktJ1?=
 =?us-ascii?Q?gJ18TvyHJ5YheoN8DjW6jz6NcyZHxK2bZhLQivhVtvEYsi9uz2mLQvvmqkas?=
 =?us-ascii?Q?n6wFtmm//1/fTdYDAtnYiWTu05DD1tfUzS/MB2pqhgM4CTNSQJwBAHj/ildQ?=
 =?us-ascii?Q?pe4+A2KXQZoV7wax08+sbQrg1yC2Dnpa0EaJczO5Zz8JMacXt12UmvNTkWq+?=
 =?us-ascii?Q?F77zcTS1j63k90kvuq1aeoU9dpv64Zcc7Ql9gO7Z8Kc/XaCNn+Cl0bkPGPdO?=
 =?us-ascii?Q?sPLAdlkr4qpei4vS5Uyy8WLvAUPeyd12pgtx+8adxvfu3uG6V4A3W2q/djxt?=
 =?us-ascii?Q?lEmXYk/cpqVaiEN/5XvVp8vV+0TadaineA5q5+lK1po2PlSO4gktYHJUPYXg?=
 =?us-ascii?Q?+ZJSCk+gvng0CbptWMJAoInu7xE+cIyltH/T9cmGkwhWrEg960AEzXuTJV0C?=
 =?us-ascii?Q?0sENT7Bi635xMGJfm936s8/Bmone2DvyTLn/VTSFsnoW7Ir0mGAXnx7RfYXr?=
 =?us-ascii?Q?5y5JUqaPOLlJHl6aGHBEREtE0Y+rTKA43ol1jfi+P/4TGV0KWukr6EI9zv1Q?=
 =?us-ascii?Q?dF6vgrsMyTHNISY5ucvdYxGNtFMcjxJzopuXoV+EwTMNVlq8ML0RvAV6N2gO?=
 =?us-ascii?Q?IcXxXvlFzGTHJJ3bjZp7whiucrXJ7AbRd75nKYlkBE/D+eMYkSWFXBe9IAb0?=
 =?us-ascii?Q?+w16tkyWuuYR8JP2igKGaP8yK/K9Fgu0nB+gXGE3MyAlD3rxqiXKRBgiToM+?=
 =?us-ascii?Q?OMuApK8e6Slsi/EhE71WdPpY0OJhGSLCorTmnMReaywoHav9rNcscJH5G0H7?=
 =?us-ascii?Q?6pG2CoJnZxD2+FQRHZxcwDBwtW7LXl4ZUsoH7ocbJug0nmS0i6Y36eaKMd2o?=
 =?us-ascii?Q?ZhhrLMFK3Zvx9/D/C3ttaSzDsGM07rVACcMFOcdBV6teIe6swrv5NSgrlRw/?=
 =?us-ascii?Q?/4piowwH8asvLTUaJ0bsMpoYIT1ejxsSTnOMbtyftErlo2RbSqGV+RDsjDde?=
 =?us-ascii?Q?J8rUKG/TcUQNX/87xVt8TwaqqSTD1I4mRw0MTWZAomI7EUExODMHMvCJWal+?=
 =?us-ascii?Q?2P9q+TP3gKtTHZeWR2sX1wD5M6uW6RrLwIAeEq//JIDmhcQ6+3n1hYqdI3Xj?=
 =?us-ascii?Q?jMCDoo7tC+DsfmGF7/+G8OMbwlYoSGHcMRO0cOeO0g6T7xUqeGPUxVZT6gdr?=
 =?us-ascii?Q?4Csf35YF6V5+gMz4zWfotnWouf17yBj0f9aBs/cmihyjdgjlKOXaUlbPLnzF?=
 =?us-ascii?Q?iOQ8azkz2CLOEwGFOMPRdIMIY5Do3MM8V84gjuKX459P1V4IDBvROgrIHwam?=
 =?us-ascii?Q?05R/EQ61szEyHPvvvR0ZFqzThMKquONALK5kkdHQMYXKlhjd4uBzaWlN6T/U?=
 =?us-ascii?Q?thtzcKDDb8ZpZHbEHDov3tErx+6INf2QASxR+kgvX7a4oCIehdnmgR02+vmA?=
 =?us-ascii?Q?dUgTprgKp6r7rCwgNzhkthEq4jo2ayYbR/xp9WOwIKuVKUCN8XMucizecoz2?=
 =?us-ascii?Q?kso8bQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:15.4804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168438ba-fa09-4c17-a482-08de538cb681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
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

Centralize it in amdgpu_job_timedout() rather than the ring
reset helpers.  No intended functional change.  Needed for
upcoming reemit changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d96a4339e340c..af57e116126a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,8 +135,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 720abe280a769..2a53991eafd7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	/* set an error on all fences from the context */
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

