Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3FD38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FE310E669;
	Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5lPflfK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E04F10E65C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+m2f4dERI6Ys7Sw5kD0Gi4lyn3VnI7k0+8kFa2ZXmxnYZIlOhSiCACoRKJIp4tj/4JwWuKlZ4lQrSSmB0Bv8+JEfxdCt6kno4SzC5ryye3B8u7l6KyTX/QdpVHS5PLEJnLLFX1K4A4m144STNAcxukBwbgWJ6sA02r7wvztuxoCXgz4VmNkxO8DWdJP4M8LtGhVVvKHRxh11uKz/foZbn493R8RT44BRDvNtCSRXiQEexHPDsBWqHyXbEtMv58BMMcVbjihAtgjhaTs47/WBMNbaiSzmV4qmrcY5VCP8d7suQWAahjyDs/LrPAh3+jWoKdi5I81vhVJdH0PrylwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bfv8HHUJ30wWNinf2Y3OKfPFBBIU4kg3ekJG73kXY8=;
 b=Zajs7nSJwT0aeZaNXiG86oOLMrP63sU1i4Uouw/XdIn2I+f9KrH/jy0X8addnjPBJIRYKwbr/qBRjmaqIBBBRtcFJcYuGthQ6BCBqabfoZB41bur/Q42H1A9EuJ6Rd2x7yGX2rEjhqv8MTR8VzL2rRXilAdqzjrkMgdecthel6qfkdmzG7dzQKmOaT1TiMuBdXyKq0fHRzRNCnYZfiysIQQE8D4MC8CUnqv/p+ZYSAvpfBJBrYMBIn3llnblM5dAcIuo/uWcZmCnWv1vq6hGh6ju+yckcR97EttQg3diot7gdHducALXvqrXZSjPnGUETT+lbyRj0lCO3JyjBwJqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bfv8HHUJ30wWNinf2Y3OKfPFBBIU4kg3ekJG73kXY8=;
 b=Z5lPflfK4PNDgTncFmH1zOLmxkN8ZT4S9uWz+2VVtklCn04dltqmqm++qgDDD9nt00Sj/+S7LG9gls/VVDsKXWjS0nxQOB00kt1tX58nv+/9J226KZtLd8e+lC00iX+q9Brt6OAAqu8AbBdKUU7ppOF8H8FgJT7qqAHhcac3rW4=
Received: from PH8PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:2d0::8)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 16:48:11 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::c9) by PH8PR02CA0018.outlook.office365.com
 (2603:10b6:510:2d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/42] drm/amdgpu: rename
 amdgpu_fence_driver_guilty_force_completion()
Date: Wed, 14 Jan 2026 11:47:10 -0500
Message-ID: <20260114164727.15367-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ed6c2a-8615-4f5e-d4a7-08de538cb382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Wgw4ohNsJz2bDy6caSwu2skePV1OadQTlu/jVXdQvsIdceyzNMEqmt1OGne?=
 =?us-ascii?Q?h3h+UKpPeM4t65b+JkusqIjvqDNWalb9xKs7nQ+2z6aqUyM6IiNNcCkOxycG?=
 =?us-ascii?Q?P1kYYwQ3XXQt4711QSLY2fjBHlYqUK8Is5AAXvCQr1dds3EEJiv0Z4L0KSqU?=
 =?us-ascii?Q?AGzZHvxBc2YU/bgtH+474Kq8lxjPLu2sf/crTb6f45AhVUpw+W2VdrctvkYn?=
 =?us-ascii?Q?9eKsZ3w0cZ1JwbSmF/8DWSe13UR+9K25KOtwRqmZ5UQBRSM3B/lrlKqg12vD?=
 =?us-ascii?Q?/0BnwCYPNmkFpGszt2H7Ittwit7cXUGx6eZnKnVnjIi7SbWudG1GaoPQKn2T?=
 =?us-ascii?Q?B2eCDTi0l5/yCIbRh4ME8SAfVTtaiEzF+Px474aIeBTYOPj5i7yUL9s7T/4G?=
 =?us-ascii?Q?W0mH0fHODnRyF2gQb2fc4brY3BxqTjbdOLb0YhkBvK4LGMtring2Gg0btfXB?=
 =?us-ascii?Q?mkZlVLfEfBzyRm2XxvcMLfazO4kWB3B8jabrg3eXDRS0E+DOXXEVLrV/efks?=
 =?us-ascii?Q?xWBW927uq4cUiF/Dhioow1i15Nbe6CNr3FH9XK/AaB7qwe73lj53evIyz2bu?=
 =?us-ascii?Q?BEtKDI0canqYRjBdPhJjuSU4ggzHoi3PRi1HujocAFkB5bDmJ63SAfmWVT/s?=
 =?us-ascii?Q?uWRiPwYhad8DNydpleM2bHskQwdO7u7GdYH3owOuTKz38xwb9sE95NKG2j0c?=
 =?us-ascii?Q?bPJ8b8aAC00g/LKWvSTpnaKgiNpxI/fmmugT/J6mjEjWk7o4ZGJ+MW36tYO6?=
 =?us-ascii?Q?CZ7wQw8gI1uRypIeGXs37cYaga2rKymldFcXZCvfkTEJkI2wj95MF4g9EwII?=
 =?us-ascii?Q?Xxch58wngnaJKJ6XofzvyulasdeZJ98NB7lb7QAyxGnUPLcAOU//y/t79OCh?=
 =?us-ascii?Q?IFnQTmgGeC8yCUdy/f2qJtTuD6hIcbP0WZiYC0OV1MJsqLQcBYKCopyi9Q1z?=
 =?us-ascii?Q?PB7pjjyOMa6NCHJnJLrUux8XAptZzSa5V+mFDO0gMhuAxyoeDsy5F572XSod?=
 =?us-ascii?Q?bUPsWBI63rYrb5zbRysqFOraoOeaUbsU3IBmDDHU7qsBwwZoqKXHWIfYM8s+?=
 =?us-ascii?Q?8XtLRFBSVYDDvDxJWXSdYwJRH2Lm9bAOJs2YCo0thLh5TPzLX1ekMzneZnBk?=
 =?us-ascii?Q?Z8WXjvt6ua8Eg5e1+fp8TJDEv6wXPr86m8JJhY0v3N+TdIrBW9eICNngF+1c?=
 =?us-ascii?Q?x+LGWk5LJQsUvrtIVa+k/cs0VKGLW09C6cXO07RCUqtHd/yOkPx5RAy/S9cL?=
 =?us-ascii?Q?2nA6ux9uhLgOtHG8IYp18TamV09+HQ6at0kUzvr6Tghb7HAmZJvU6VojU+7o?=
 =?us-ascii?Q?GHcgDoj/ZHhuBTKgQulth282joXQdMJ9DXBkX3yortMSzSIxGa8A6kiywtw6?=
 =?us-ascii?Q?uBD569xvCTKNwv2U1hzLt82P+42EPlXY22ngFXGDZ2SKxU0Qi2tuCHQnDp3b?=
 =?us-ascii?Q?U4/pfq3JcNfmtyM9oU2f2UFl8BMxn3Ta1wKC+EyUx2K5TdR4yRg2fCVLbbpU?=
 =?us-ascii?Q?8bsR+whjTghQ7A62xgLFp90cg3Mfgf0z0eS5lRpXHjnOnZcW285JOkpfjsv/?=
 =?us-ascii?Q?zmFmalAI0DA8z0U0hqX4CVwQPNAWQzSyklMLibdN8KhyxULJl/iofRFsoFsK?=
 =?us-ascii?Q?P2hhVhDh5kpptYec6W3l7p16LBeGcNcQ3ye6tLj6qezr8KN3E1NpjNnM55Gm?=
 =?us-ascii?Q?XXhTUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:10.4574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed6c2a-8615-4f5e-d4a7-08de538cb382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

The function no longer signals the fence so rename it to
better match what it does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3a23cce5f769a..6f37fc45458a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -709,12 +709,12 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  */
 
 /**
- * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
  *
- * @af: fence of the ring to signal
+ * @af: fence of the ring to update
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 {
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 600e6bb98af7a..b82357c657237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -885,9 +885,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
+	/* set an error on all fences from the context */
 	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index cf56babb2527a..86a788d476957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -161,7 +161,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.52.0

