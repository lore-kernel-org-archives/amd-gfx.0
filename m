Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B038C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72E210E587;
	Thu, 27 Jul 2023 13:47:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D274810E587
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 13:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB+qCrprFEnIgSlnBN/J2GEKluVTuVEjEEO2R/QzIhmZxvs3miRjw3vGxRvFPvCjwZru9xo+wVHyRCfvzWwCre0PVZRtEXJ36Olhk740MhU6d1ZRxeAVmjBBsv0PsvFHiBFddLymno+mXqW6YyuLrZHODjpNBN4eNFccfcRwKWrTN8fBDlVxdRPM3oHHWpHwpnOLIyuzq6rTeaYLVsscr7i3QGgi1PbBz7ep2V55VJJJAzNn6zm9mVb8Z36hMfuQKQh4LdqPWD95l5u1K574C+1Wh61rjyJqTlUOw1mAQ9zQ2bZN6qW+ZenUlEEtJfKSvUapCl5Ekb7YNc27oX2c2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBWHA4vph/qzAs9d/kLXE+UlUR3ybvemiX+Pk15Q30U=;
 b=HzQ/08LUPQGler5XJOol+kODaKgAI1EBMvRPWGN7pRA4qjGcENgtOplXIDPXqAkyr2kYYtmXB6NmrbwPq0WFEmyKIbebmcV+Y40hv5+PBQj3efuss98zldircyPxwmJth3k09XpD8ogI01EQdaX8of7G+dluHCcl0pctLvmuRjeYvanwO2YOjb2UPSaUt3utzujgzfRIHR/k1HpuQ9QIzx/yu4N/XPJwGx7sI2snTMqXhRm7jr/hY1rmF3PsLPyFoAPxuNR/O27FDVHL0cJiIicWgwyKHICmcWO7kqTYtpdIdQ4S0izUJlBaWCmBAXB/UHXrA9yTrgkzXLyKBOLHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBWHA4vph/qzAs9d/kLXE+UlUR3ybvemiX+Pk15Q30U=;
 b=P9TH/IViO08Yu1uVE+cu/Kc/KOXk9WGSQd0r1NahahjR+Q05uBOmUCGb9bBbvr+MWVhymYIMzfPIht7PZmz7HjhlafAOKsTEQsSvQmACCzdHZnAkOLxZ1o4COAOYsMckcWGi0/voN5Ub5iQ2FOi97LD3D5i4z+jMqDVCvZdKGCA=
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:47:32 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::74) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 13:47:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 08:47:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/radeon: Remove the references of radeon_gem_ pread &
 pwrite ioctls
Date: Thu, 27 Jul 2023 19:17:12 +0530
Message-ID: <20230727134712.2577353-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 44478bf3-7f83-43ca-e34c-08db8ea806c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1bvQxShBIBsV6vAF1Kceid1mj+kKQVM01VY0OolifoJrloCY/MjA2d83WnZKcAe3x05wY/ZQ5l6cEaIZCxkzCd5InjAKQrviOvJTwOUQtuAdcOBX3H90EGsBqUOediNtfUObhjOt/5p7SZgzKdqgdXnk+KTE/MGaxonRtTk0GpxxTQ0cT4Iw2KRZ0R7xOXlBNRjeXsQDxYEA4PzzjtTxnbulRLaldYnD/wIHWuyaJNcl6q6+3DWkdjAYcX0OA1ot7IL+ezvvKThZALk1lLw+/UiPPFIQemdXZl2unw0p975ea+EsAzVADmc42HFV1KngJ7JzQht2oOSd4Zatwp2b9DSDm5ZiHr0oedZ0K0BR4jIdECYvRsoO64Kae7IJHO2o+93p0he1S4dUCu2S/+KD4kMoPM3zlIWPGshP4bBeD2Xdb6Jo7luoCDni4DMHKEXt4GyWCTTJ4U7UPa6iJSiAg39AWiO/TU9X8GZwgRhCUly8tB9p1gSv6cTQNjz9Ndq3xzK886DDDvPrG6g93OZLI+DJPrbp8f91dJQ5LxJJXEIR4Siktho8QBnlAq5uSxwI6a+2oNc3NN84tT44RF66lzWvE61NY2q/X1y9/HeoUENMmhUaTS1Qj/OU36PRuVCe4o5WThE2OAiYmZiARzpamMwOL48oayR6mFRP2nRJm1llVbsfqjXqyPzbqJRtEKvay6k+ncV0zbmw+6qrVwv/KPZLzWE1U7X2w2DiD48GIib5dtQN2fgx5BValLbsuVYYGBbDiaKpKDZgS9KckYfwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(83380400001)(44832011)(356005)(54906003)(2906002)(110136005)(40460700003)(47076005)(2616005)(6666004)(426003)(7696005)(40480700001)(1076003)(26005)(66574015)(86362001)(478600001)(36860700001)(5660300002)(41300700001)(336012)(316002)(186003)(82740400003)(70206006)(70586007)(81166007)(8936002)(8676002)(36756003)(4326008)(6636002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 13:47:32.0776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44478bf3-7f83-43ca-e34c-08db8ea806c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removing the functions of pread & pwrite & IOCTL defines, as their
existence allows an authorized client to spam the system logs.

'Fixes: 6f9e0e87b71f ("drm/radeon: Fix ENOSYS with better fitting error codes in radeon_gem.c")'
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h     |  4 ----
 drivers/gpu/drm/radeon/radeon_drv.c |  2 --
 drivers/gpu/drm/radeon/radeon_gem.c | 16 ----------------
 3 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index b1c3871f2a67..102f7e25faa6 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2254,10 +2254,6 @@ int radeon_gem_pin_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv);
 int radeon_gem_unpin_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv);
-int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *file_priv);
-int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
-			   struct drm_file *file_priv);
 int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 int radeon_gem_mmap_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index aa02697e5ea3..7fea9edafa67 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -555,8 +555,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_CREATE, radeon_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_MMAP, radeon_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_SET_DOMAIN, radeon_gem_set_domain_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(RADEON_GEM_PREAD, radeon_gem_pread_ioctl, DRM_AUTH),
-	DRM_IOCTL_DEF_DRV(RADEON_GEM_PWRITE, radeon_gem_pwrite_ioctl, DRM_AUTH),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_WAIT_IDLE, radeon_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_CS, radeon_cs_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_INFO, radeon_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 358d19242f4b..3fec3acdaf28 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -311,22 +311,6 @@ int radeon_gem_info_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
-int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
-			   struct drm_file *filp)
-{
-	/* TODO: implement */
-	DRM_ERROR("unimplemented %s\n", __func__);
-	return -EOPNOTSUPP;
-}
-
-int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
-{
-	/* TODO: implement */
-	DRM_ERROR("unimplemented %s\n", __func__);
-	return -EOPNOTSUPP;
-}
-
 int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-- 
2.25.1

