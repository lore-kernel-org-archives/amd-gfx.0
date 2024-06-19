Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A7C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 04:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799DC10E89C;
	Wed, 19 Jun 2024 04:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jMHTBsr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ED610E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 04:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+CAbS39RJP48amVd0MX2Cm6z6ne+iCRv/4Dht9WoCATb8Hf7npc1NTQqbXQFyF72VCzJwhSG/MZSO1ffcZAdwPlpv4jNHK1GypHIYHJbcH7pEbK0Wu5G3+K6ZSKn7ibo3UXgfIFBOG6PpwF87v0UU+gpITtR/4sGiVwES+KXgLRJ02j6W+530qDNh68gQ0astM7tkTRd/fRVE7mxCR+hffEjulld2MblK19v5rgkzaotCqkrexIW5kFesC3zEoGYKophoYhiNOdYHYjIHePxhPFBkwekaMmTuja/44yXo+LbUy/WPtRilCmDLnuR1GQXiP0ScWVmE6Uf6Hd2L/08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbgkJLPvf+h6sa/ndx0jGcLMT9lRQE+018lvW4KzZaI=;
 b=IFdQ3dIbvaBJ59G+LBrKYiyNAXehesGOA4AzAbxVyxvtDfTNRvGksyrln5yhCE1enzFo0YwuBTfVexTQZ9IiVEaocAoR5ihHEjk7ZgDBCMqaIxF/V5Zlfps3215LUrjfpFvVMoQCVGN3uK8fu6TNnWXI3akNZhV7Ob7uXdYmn5YebcltNaecrrZBuwy90jEwet+5O6JVTGBzd51y+Et2rPanyeWdeBgF91aIrk/2BSMQ/CFHt9COfRZjYHy1gxQm+hVFEp9EtXdt1Xm8Cn4z+8Guw4gWuGavkFzHmmuPebXARS4qZM9+ptxK0L3oEozi5hq5n9w+JT5ZmDqV0Add+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbgkJLPvf+h6sa/ndx0jGcLMT9lRQE+018lvW4KzZaI=;
 b=5jMHTBsrnjihgGN+66C7pt+G/aZa1to2TTKRTr5NSfj7aBuZsRhM5LoWzVwb6efQ5FjcO8OQ8HNyDQ+Mo2ST20mZ2+dayFNdFgXGhp8rCdUNN6UgBiOIlkHGjT6BE4wB6vmlKD7D7Ss0fcG7ZxBytv0mDHqp/h+p5xk86o6niqA=
Received: from SA9PR13CA0074.namprd13.prod.outlook.com (2603:10b6:806:23::19)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 04:30:29 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::3a) by SA9PR13CA0074.outlook.office365.com
 (2603:10b6:806:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 04:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 04:30:28 +0000
Received: from jenkins-julia.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 23:30:25 -0500
From: Julia Zhang <julia.zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>, "Zhu
 Lingshan" <lingshan.zhu@amd.com>, Julia Zhang <julia.zhang@amd.com>, "Julia
 Zhang" <Julia.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: avoid using null object of framebuffer
Date: Wed, 19 Jun 2024 12:29:24 +0800
Message-ID: <20240619042924.1489294-1-julia.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: da26c2a7-549d-4ac5-9805-08dc90188c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NM8DCvgdeyACNPCTfqcmmTJpp1ry/STV8icZqdBf2Svtwu1xdteDW+Gv+6qw?=
 =?us-ascii?Q?J8nelmdbfpfnKPIcpGP/o3HtbgjHn5VlY/e8GOXy59vcP16128eIUTBFkV+1?=
 =?us-ascii?Q?2kLlanCd7xm4JoZ8PUzewa9avBGsQoiW3ybjCkBBIzIxq2jJiaB/NJNHW2aO?=
 =?us-ascii?Q?x0bAEyKsCEisUeNqpWJu+PHI/HEJUV2kQ3TXv49qKNnaNARXSlSXxLHZ1gA8?=
 =?us-ascii?Q?vxfyfP8ksc+iZ+7VcJasHS2kiQd6uZbQ+Kb7t6yc8E/Bi9pfVN7UNg67euKb?=
 =?us-ascii?Q?HlTUKfs/LwMuDsq0hgc1zDoFF0LzJHtuBkVQhJVc3VZKuwHHoMQLF9lERkJz?=
 =?us-ascii?Q?Kuho0SJjE6Z0J3dRlokKGoSnJL5q91k3xtnyvzbqG+5DmljJ0G9kQbBb0abi?=
 =?us-ascii?Q?Ba+0LBDak8YC3FsHE+oFbmrudjxDblkmcZT6I5cHhKc2SYXI24rwY6wAUJDo?=
 =?us-ascii?Q?67bEGg1QEBfGavD/YgVLBkUWmGO7k4fwDQ0M3HoxASeTwK5KWGHAFFLfByxT?=
 =?us-ascii?Q?48lG16NV5vcSvvy925dIpReAsG35sMcyFuSjhXq7iN0N+FZmFKC/mZBXm8dC?=
 =?us-ascii?Q?STLcRKueOfB52MD78btrtb05APK3UbfseLkm8JbR/zDTFNzXAWX4KDU1e7Fc?=
 =?us-ascii?Q?UlN9Lf2LOOZQpY9c4MnBZ923Z9Fd3WsDeViTGt32/M52Wucr0uFStAnZ6SAa?=
 =?us-ascii?Q?L/+1xIaSXoCr/28TZL52uuI0xg9zIo+YCPyezWWtXnngJ5oXeyryD/J/EVrD?=
 =?us-ascii?Q?Q2H4CDG1Nr8evFmtKj/72iVlyDVqzB0YqfhA8AjJNMhWKpSw+SKlKo9e2xlT?=
 =?us-ascii?Q?oG6KrAWoUAYr+JeyIc8j0kBXbMyc2JE9fMQcypSM9NLLxk7o4qipq2az0+fL?=
 =?us-ascii?Q?Y0zH0V0xy/9Mp0kVT2kgaaSLT/WgWamUoTNh5nRmmZcnLJ1fv7ApXTAHlhBF?=
 =?us-ascii?Q?cGDG5IOq10OPzz8mCx9c+5sLqSgUcGXUukybhGQpK2VQw+jowHbrRfXYDefy?=
 =?us-ascii?Q?dj06qCR6ZM11GLkzMYHOUuULt5xv/MwbwMMZ8GA7WKgQDrji2jb3EoA8LWRq?=
 =?us-ascii?Q?CpnngMpy1Kvp42QdB8kJvDcKSPeRHc9V5XIw6MktmMGQozQEI9VdEqnfx9GS?=
 =?us-ascii?Q?ZUj++O8B+MqJ6eiKcDoXcvAHc0CHkDqgx6UX9Dac3BwBJaJwc+VxitWzdN8r?=
 =?us-ascii?Q?TW+pA6KSKJJTVUFUw679G/mWZK676AVcouLeuVUihSo9I+KUawS2OSaVP0hJ?=
 =?us-ascii?Q?noGpc2/QBVHF4LZaG4ye7gk9dZdCTMFAdS6fBRnwfRP/c9aq/y5xUSEkCx75?=
 =?us-ascii?Q?Yuhgp4iMCvfaDQsxDDuK7iwCsmeH4ORhXyg5kDnrbIepOUTlvoPG1WhE6KmS?=
 =?us-ascii?Q?g3VMs8Aha9MD3HbLKE0ewh0T5JCecBvjmgSum55kjgADnv+7jQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 04:30:28.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da26c2a7-549d-4ac5-9805-08dc90188c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

Instead of using state->fb->obj[0] directly, get object from framebuffer
by calling drm_gem_fb_get_obj() and return error code when object is
null to avoid using null object of framebuffer.

v2: Call drm_gem_fb_get_obj after check old_state->fb for NULL.

Signed-off-by: Julia Zhang <Julia.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d60c4a2eeb0c..212f6522859d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -2,6 +2,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "amdgpu.h"
@@ -311,7 +312,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 		return 0;
 	}
 	afb = to_amdgpu_framebuffer(new_state->fb);
-	obj = new_state->fb->obj[0];
+
+	obj = drm_gem_fb_get_obj(new_state->fb, 0);
+	if (!obj) {
+		DRM_ERROR("Failed to get obj from framebuffer\n");
+		return -EINVAL;
+	}
+
 	rbo = gem_to_amdgpu_bo(obj);
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
 
@@ -365,12 +372,19 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
+	struct drm_gem_object *obj;
 	int r;
 
 	if (!old_state->fb)
 		return;
 
-	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
+	obj = drm_gem_fb_get_obj(old_state->fb, 0);
+	if (!obj) {
+		DRM_ERROR("Failed to get obj from framebuffer\n");
+		return;
+	}
+
+	rbo = gem_to_amdgpu_bo(obj);
 	r = amdgpu_bo_reserve(rbo, false);
 	if (unlikely(r)) {
 		DRM_ERROR("failed to reserve rbo before unpin\n");
-- 
2.34.1

