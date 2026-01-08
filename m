Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A31D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4010610E781;
	Thu,  8 Jan 2026 14:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l+4LB3AS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E72810E775
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGZZj37Kz2ZgR/aJW+Q9ooS2FlHj11of7zkbUiLaCe9qOBsaqWOU2juX+BAQBf+8LeQNs2kxEc77vDBxeZm5RMLsNJOOLg1X7ym6DGnxXZvCigQko7XsXsKQHFyR4n18pnHp553m/nOgY7rxSq1LUO6HeKv52bGqCXaOpoJh7mhQJlqNkLewPD9K9rpzr/N4iLmt0HUXhxgNcF8Hzc5HLvJxMOx/crvBY8HRttgOICDtOfAA0C8a04U+Iv2ORjEKkw8SrZNzFCEM6v5AOEGKGjSdeockRK7H2CWXz2PjZrizsE2SdrSueZTN0TDd03jP0bhxPETEuf0ekeYfgcqAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKoR57bUqc0TxWVJlijBElrfWdmGjgNEtDkgiB3jP84=;
 b=VwfGeQHztXM2o/vT+51AhFU997RfoHSpTn1oroC12h+6Ot9P2B1bbS9xzWLGKSC0gzoFDYCoAyO1+go/Iw744ZumvwgzWtYPoTISu3k8gbXMu/ZrsR3z9XrtI00WuKV9hm8vmaqAfCtwIf06/FuAzIkPtCZ93A4t1slqFV7WcpPZkmWN14RqqWr/H/ALsxNw5vGCKDc+49Yc6nXFI6qfa7gnpuDc6u16mM6mYPDDDzWwjo77WciG7vK+DDYfy+SGc7/gdbSLTufQOGPEC6/RvB+L/OQKvEWShD1g1GDdwPxXhtZVidM9WI1F24SILYX8+0pUTnqWc+68/2RiLq0DUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKoR57bUqc0TxWVJlijBElrfWdmGjgNEtDkgiB3jP84=;
 b=l+4LB3ASS+bzbFpnej2tM79Z/2DMx5e8zY2j3D2d99bV/WV9eFCNMzb/+q3LncFay+nRghIIn2KSReWqlHb0srM/iXFhqAS2WTDwvT58ZH37vwurr+00CP0wwkK5auJbkI0RNjJ1+E+ThTyoaoNx/6uNaIcxXQfeN1pVyFwVIHs=
Received: from BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41)
 by DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:49:17 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::b5) by BL0PR02CA0136.outlook.office365.com
 (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:07 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/42] drm/amdgpu: move drm sched stop/start into
 amdgpu_job_timedout()
Date: Thu, 8 Jan 2026 09:48:40 -0500
Message-ID: <20260108144843.493816-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: 29654f22-1a5e-4224-d4d7-08de4ec51929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3KjrlfCzCYn26Fu85V040p+Gfi+jT2cGUGuM78L+DnRGyndE3nAisjks/0q?=
 =?us-ascii?Q?Db6808tgM0AJGiGo/OkfLHlnr07my1U266/6+6AZIx7zuyq+62KYwcBRtXg3?=
 =?us-ascii?Q?YaGyQO4IQ25M5/5mgWEqTw9h4lamQjnI/jU0B9V/qrAWPT2ok3VUYVlqhagi?=
 =?us-ascii?Q?++zq/4LgzOZEMHaC3tEwDjxLbYjv87X9U0/bMWiVsRv1VHT06+w9KFtmuXdM?=
 =?us-ascii?Q?ByIvXwn1ycbdfr4Lt1acmHPL7pMVHievfmBvJEm4GauFHkHSVseOGyQ1zZlv?=
 =?us-ascii?Q?WZ/vHSngsUms0TkaGJZs+qO+XrsJ2+BtB5e/njCrVveN2hPJaJciIqhBlkai?=
 =?us-ascii?Q?JiJugHluRbabbgHooPyH2m0CsLAehpHGAG9EORpGn4winWwsqtzzw7ZqqjMZ?=
 =?us-ascii?Q?mSYRgNkl0lAWMKLS09WldnAXcjCIziZW8MrvdpkIFuSQV5otQbRxHaqvZaX9?=
 =?us-ascii?Q?T6CRiaBK+1uhlQdIcRVhlBle80oZWaacGSAdKPTonmFtWDdcTMA/diIxiguL?=
 =?us-ascii?Q?u/FIJE6nDiMRbeoP9Z7t7vFe95hcIim7KvPyFDQUbm7ciR+6JykMVwPNH1El?=
 =?us-ascii?Q?jpRCpvc6lmSHy1xgy9rIDRj7lya3Zz6HuF77HpDQSgaDzxpAv5DFF+6VD+XI?=
 =?us-ascii?Q?Bg7h0y/JxglqCpLj8OzJ/3qCEwWDLNip5K8jasnFVHGIJPP/0h4A6AQ42/SF?=
 =?us-ascii?Q?q4dkjEojwcZUSpjwX4Po8e1qHPiKkgR2kV6mYHRfv9dPTN37LybI8FuRWlim?=
 =?us-ascii?Q?mtGE3l5x3VYN0jJCvLr4whrtxdDJS9v7BxCT2d3u2nnKa+jfM8W/UI98mFQ6?=
 =?us-ascii?Q?OXvHJEzJ/d3DZdu9/oWmUg13F0pBJC04SeVVKn4WKneizkKnlFmWjHcVxkRj?=
 =?us-ascii?Q?TMs/gMlDPqiAB6qL+s4HE41xNmvn5MXQuACT2JIkipRn4G+l5i/BOWi+u2sm?=
 =?us-ascii?Q?hhayVtO9gvAUCfitTfD+E0KHOtlD2YPwAb39zZjoYtzhN8OBNiMQkjqTn+g/?=
 =?us-ascii?Q?hGNZvgMTqMS7qCsQrchQ0wmlXfBp3A/v9SY1YwTIYc3bFyPeqSyzWJfUdSg1?=
 =?us-ascii?Q?F6KREMfBjqgExXUCjpGliknMu0vA5JhG42fuiputl1eEMKq1TQ6L1ZMRc9cW?=
 =?us-ascii?Q?p7kIdJ5u0guPqbVyFxLNiVUcpmPgjhwArksPRfC14pbR1VbSk8NPQ4aU9fYB?=
 =?us-ascii?Q?4jGZcGq+1dAAo25ZqM4Q5ZwzNxi2u/zShin90P9waZTjnQCbQQ7wBmOhQRUx?=
 =?us-ascii?Q?m8fFP/AsjoC19GUvNQSOGuJFHL0+HWlj5Nq2wXJXZ1bzy3aeKmYb+XNaMzLZ?=
 =?us-ascii?Q?CFfnuuUKwbcXN9dDKJNWxkKDrD78Od9+bWj05ityGJTor0AGjymL1VTPvJR5?=
 =?us-ascii?Q?wsU8RGzveldjWYnn3ALNXonDvhWStIDiKOdoehP9BkQN8f8l/Fu0tGFiM29m?=
 =?us-ascii?Q?ePhBCUoFz8iYHXgC4KnDmOKwm5fBrlKdfFKP5BFSQRhH5XI9koCOwMjnKXmZ?=
 =?us-ascii?Q?D+/r7vEKDLmbd+4o8yrG8SmefIAWzcH0OlcswYjDf1/LLZrp7M9GdTOWd7aG?=
 =?us-ascii?Q?ix3I6eJN9rWWSqyYNvI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:17.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29654f22-1a5e-4224-d4d7-08de4ec51929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734
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
index d94b85e4e28a4..3834c1b288eab 100644
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
index b03e3f5d40000..8cb10d71ee733 100644
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
 	/* signal the guilty fence and set an error on all fences from the context */
@@ -896,8 +894,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

