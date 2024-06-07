Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9694BC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 07:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A741110E29A;
	Fri,  7 Jun 2024 07:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzVfq6iO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF97E10E29A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 07:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkK51Pb5bsNpl48b34pcmuxTWix6cul01LiLFeB/RsflAXwgsRLA1ROVoImSpemBw2cZytF6QefKitIQhKHCmc58/yWEi2QpOt/COjVOzCbYhARJI7JwM0rF7eaqlA5of6KM9s5ZPQPRz+50Jq5IhrS70wHpAIjJMfnEcnLGNyIPq3wZ6SM07lEnLY2izmeT/5hxtp+5fcCaIpadDtHQMf06aZrnLZgdJUqGSLKBuH1LVKubCC8GrJySHn1e9q4slyYQwP+cLEVAv0vzvbcICPZzeKJ9ucXwDGU5b/Q0NDMdqVBgLLnLSngWwuR3QI0j8NTHf33LPxvcztcu9eA/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A56j9hDXXdyfsbJpdd0++9SQfvTfXJUXHLUK7uCPkGk=;
 b=LwmN4k9my6BQ2ojhFz6gJMLGBIcg/AzdfQxJbhPYvev0OmKovmXfjPZFCSTb0V05ZALRD12YM9+RNbsS/AA6yRqut5dP0/KquUbjSO4CDFXmZsaHi2TwDKF4/LZfMqq6aEu85GrvwuwbjmEdNN2dKfkVhuQeGwfxNJW/cpt4v1MLO4ycZS4xWtPN1kcOXU5MiM+3J1Wu2nItU0MCJ1UMOvPzIVZhrz1wy89dRBqIh6SvAcG1TpcE57SwdYw3Y3jJDc1qaftWWgFWuzY+0+aznK2u4OnYc05oyVRQkv646pZTPjn8uPpZoQMOeYf14EQylfMbAsw4HdJWypSOCq3suQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A56j9hDXXdyfsbJpdd0++9SQfvTfXJUXHLUK7uCPkGk=;
 b=rzVfq6iOSuijilSMOXDZQze4atvheDXR3cDDnAZJDqAOb+0PV/NXEmWtzgGTS7gz+QO2GH+/fnUNEwt6GfErELRO9qWCdlGmcdEJzBCLk2Fkc5vPIouESLHSrj213zEN9LcPYFggmLA26++bRvCopowSD1Yc0fdn2hdBlYIdbDk=
Received: from BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Fri, 7 Jun
 2024 07:06:42 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::b2) by BYAPR06CA0024.outlook.office365.com
 (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 07:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 07:06:41 +0000
Received: from jenkins-julia.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 02:06:38 -0500
From: Julia Zhang <julia.zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>, "Julia
 Zhang" <julia.zhang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: avoid using null object of framebuffer
Date: Fri, 7 Jun 2024 15:04:55 +0800
Message-ID: <20240607070455.125522-1-julia.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: fdae3f47-13e9-4ba3-0e32-08dc86c06232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0D6JHVwol49rs1yS+T4PIGrJonZTEHZbusMkQXfrXEs1p3tNO0KFVK6TCHCr?=
 =?us-ascii?Q?903M4Xj3pkbchzGZuMcmjvwOaNDuEFUOn9R7eoOfajMmGhMWpnMdDWzyo1me?=
 =?us-ascii?Q?9fcjtoMHOWl7Z9kGKykiZzMsKo5/eeJhF/n+MXbMeCczFkm+DHto6bYhTIRo?=
 =?us-ascii?Q?mbKFJ4TZ98YMYqR6EeGms8CQSrG+PQUbm7QirULzbxoBAnWgaDUjxQ0OwM9U?=
 =?us-ascii?Q?zvv7jtCdwXEC7U3K704jfcPyoeUyxNZH0y0ni6uHOF4p8UJIK36n6N8s1ll6?=
 =?us-ascii?Q?k48LbZNbhKTQ0Ex5ihmUaKn9gXTqxuzIsWhOQcE05MsmTXC/57LBnG4LXf5q?=
 =?us-ascii?Q?12tpWzQ4ZO/wuJqfrrdeiwHJicAccSLuFnB1gx6tO8cw6aUfJvx1STeWMpwV?=
 =?us-ascii?Q?8yZAp+mK04WpSTpp1bx0Lr1JOZq7Fvw7KZKUaaQ2pa7N3YGhqCoO5Tr+8YTq?=
 =?us-ascii?Q?018MNwVBdZvj3E6rbL82so3CAL2Gf68j0HnfREdS3fChOFpmH2vvJucGvbe2?=
 =?us-ascii?Q?/Sqcq/znjLquRmagxXX9VgFGuS3Wlx2sTmz8OervV1Q9uXwY3fqe8OjPabf6?=
 =?us-ascii?Q?2HhkCaDjNu+XbT+IYZWfFre3/qe3zAlxs2umcm2qncc+ZohCr5o4zPFuD3ua?=
 =?us-ascii?Q?0qzLCeAMIFPe8oC2YSsEkP6kifPqetPGCSPtOH5xTQU3otsX/zyE8PweVG8N?=
 =?us-ascii?Q?a12EtJ79IOCRir5jRIYea0DbECAS3+jpkj7ZTNolhiw6XPJKhoHF49iQcvnV?=
 =?us-ascii?Q?rjs6xVDfafpj05XeBt8q5XN4tlZdSW996P8MHmJyS/lpN+vsvlAmJ7qt9ZT9?=
 =?us-ascii?Q?OMIvxoXoWs6KgFQT+AP5bB5+7fyvh0gFNpZQpHnJGg0R8RLmmE8AGC0sSjUQ?=
 =?us-ascii?Q?kbWO54l6DKXpEtWOVGRNn2IYJJ+4Tf0cadyJyKNimKe/tCYM8wYYG8eqlnmJ?=
 =?us-ascii?Q?VRLFnIcBjVYQC5IPL0HdcgyYsL7cgwgJKrS6rTqdEtc12bUpilfu+pIe8eYB?=
 =?us-ascii?Q?aDkQxrfV2SNVpecHtmhe6YXNoXyd0Q891WRP+cGUmFRPsC2dQTNVDKxyDbI1?=
 =?us-ascii?Q?FZZgs92oYTn6Z7/MVdoEajtpgcVmjZqNqMFfvmBa15KZ7QyZclnEUn50/2vB?=
 =?us-ascii?Q?V7KIW1aE2g1TaFWxYs8dTNcg5yv9sXunklMVNIZTo3YOLgkaUncdx2m729ZL?=
 =?us-ascii?Q?+tq3ql2OmZr4uNIRz9Ny49m1HrT7KC773aPzzskQ8codGG/1Gj0nVDur2Rh1?=
 =?us-ascii?Q?nnE750KVC8U2ZnuSZqk3fIcjMffpajSslpbOgEFuQduVgeC+8vADkEqBWjTH?=
 =?us-ascii?Q?UoUEKLsJSQzrnfRo7FtDBtRknEP4JJUCRcGoDznBc5I8fUB7TF/WRj5J4W7Z?=
 =?us-ascii?Q?K6UsOA9ht0tmKeA51BZU/bN3WzARsvLW7EcZ/rNQZW5P/fbQiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:06:41.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdae3f47-13e9-4ba3-0e32-08dc86c06232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

Signed-off-by: Julia Zhang <Julia.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d60c4a2eeb0c..d50ee0828935 100644
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
 
@@ -365,12 +372,18 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
+	struct drm_gem_object *obj = drm_gem_fb_get_obj(old_state->fb, 0);
 	int r;
 
 	if (!old_state->fb)
 		return;
 
-	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
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

