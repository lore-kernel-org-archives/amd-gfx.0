Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D22C3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 15:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA3410E2A1;
	Mon,  5 May 2025 15:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LVMirVp7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B283A10E2FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 15:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxHU+Qw7K1gJtn/NndYW+OoJdElunjEoOFkk0DB+TfLRBJYVPGy9KHjJtXh6QSQTiQ64OV7MqbzQXHxuDZwVkqzgobYXebFtqz4Nx/QjXL7+3TSeo4NrR1NQDTxUzBhN7YvOZNKrxLCWYiexAPgqf2gWv+uNBQcDr41VmqkVVeeBK4EJ0cwbkTqgicvhJp9Yh8Cro0BaYHxxRG94gE4OFoMHqqCbg0L/h3EhVUgjYXGwKyu4Cn7kzopIOoxfGpYFsNOIe2XUKi4MrT+WnfhutmO3dHlVYhR4hI54d0tWI+eSyWzuX900xb5O9MFFxrnZiAWApli038CW4BZeFi9HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSgz2/RbucfPpPLwPJloDIYewNXuRkN7Lb0jEn7uvCg=;
 b=A1/9XaxNPONCvC75+xc2AIIPowHY2mUal8GPFs1xEsrSrUSMmRalasJS4tZjTfG8HM85wzEYWsXYlaQeKhsQPMej22iGsw1CyanHdTE2SCHQDyinGROFF9rLRlTYXXGa0WVua8gYueION7hdSHLVRoLwt0g5KdVxU9ARHD0gxEH6xJUCN+qy1UD8FMkmOK4A3zhkBwT7oTQXyMr2vXhhmFWxVZh+Mz+1rsEvCqNst1sanKrpuZmqHefgge3BgrXlwkkfk/TnYa25xa2tUr32//vgWcPzS4kq6cNGlqCKZugXPKhcoHahCuW7WDjHt32ltef2YhuTjMaTu+mGdGvL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSgz2/RbucfPpPLwPJloDIYewNXuRkN7Lb0jEn7uvCg=;
 b=LVMirVp7XZ32mHSP6PsG+PbhFWpNI1SFr6dCRg3L+797aXaUMu3KN1g5x0/fU4Ts+xCZ75UVfmSbXjn5/4qp3kEANza/ifCOAPPJJon7P6y6ObpYIVazQuhcIiLIvcJIRv05HTjwuJ3L39Rf9/pnqA4fNAEWBkuFQjEo2Y1n0Qw=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 15:30:19 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::63) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 15:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:30:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 10:30:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
Date: Mon, 5 May 2025 11:30:03 -0400
Message-ID: <20250505153003.2047138-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505153003.2047138-1-alexander.deucher@amd.com>
References: <20250505153003.2047138-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4704a31f-c100-459e-6f6d-08dd8be9be12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YHYuS5VNn7pxDHb8B6Sy9J/n2foLXFWRHO8jH94N3VQUGp5+P51vqzM3DYiR?=
 =?us-ascii?Q?VBiClVZGT9WZxN44eaLt0MXLH7gvlQeZYOb+qyzaH3lF6ZDE7ub/k+8sgnhZ?=
 =?us-ascii?Q?D+R/JcYZUvoIefRkN/QWYpR21QNAzW4x4WgeFBIDyoh+8S1NfIALfGo2hNfg?=
 =?us-ascii?Q?Gm7IDwtRQcVhvuQ46UKLgXUcI3d4HdxdueuS5L/SwLWmZVhSHmeBhCpVbS3C?=
 =?us-ascii?Q?HylzFIBSQMdxgjSPvLWNTm36QAkdtxKU18w4lVtD4FAL3EItXkhMs0wtHXBt?=
 =?us-ascii?Q?jkvpiKZbCYRJz8DDLHl7fPhxuLBnCHoZ3It/jBTszhmGKIgYy15KbGG1JHB/?=
 =?us-ascii?Q?X3DfwoC6XaThUvvsmg9a7vQ3fkjLEn98KGDAG2eODu9sml4LFy4pGprL1v3T?=
 =?us-ascii?Q?NGc84ME6a+7qmlVJQXSUroAkpR2WOPcuVMCn8Ohx29DXZTrB2KTMLpX33vjD?=
 =?us-ascii?Q?9Pv986AriAfsSz4coVtdcqZe52a/A70acCc+ZoAurDK8r8OaVu67o2LfuMA8?=
 =?us-ascii?Q?eEBdS8kQQKOSpXgvdk4K83By1Tw0C9m5D3UUJqClltbF9rgqPKFr2L3M762X?=
 =?us-ascii?Q?gkgYMqj07zguoNo6+xRVPU7/8HIc8gg9EhrEbWcL53fStoY6JwtSIS8STVRV?=
 =?us-ascii?Q?0BHB/NIc+Vkt/h/JLvNUZWPfScsjCJYI3Zo29X2P52+1eofzLroPnXu4l6BG?=
 =?us-ascii?Q?yuSmji0k73rYqtvuwJTytfhB33O1mpbxg6I6eREQVw9thv87EEL0rRtXzQ25?=
 =?us-ascii?Q?LpLPiN0o878BvR8HyacLSwE7583KDIl9tHv10oTm3h0hmHvYY4kHikoRm09i?=
 =?us-ascii?Q?eF9JPiqTEqeaYPmXnCO8U2UUvAaopzNgYnB71yY+0UHK2wCzE0KC9gtReb3B?=
 =?us-ascii?Q?FQdCXZhSto10yyTPeV8yTSVzmUjFvyvLhMPlirvEGc0c9ksEXDQyQK1rChZK?=
 =?us-ascii?Q?fNHDmiubGnOkgL+VxGPPIDPiwtlCx4eZGZZCi7R5oJ4dxFTU8OKeLdZ0eoQq?=
 =?us-ascii?Q?GVECZWZR5cexOoqVHSRMEJuu8o8/syhiLeCLc8O7RjnphG3MIit8l7hQqkEz?=
 =?us-ascii?Q?2i7Nw5zxNy9Yd59ww0DJn+sCOgLQIam5arPTreLsLgAZRWqee+ELiMxh208i?=
 =?us-ascii?Q?QI0srJVyk1iJ1NcluvN6JJPw2/bRWoMG0o4ayvkjPrNS1KDqeti5D6dUN+z3?=
 =?us-ascii?Q?+WZCXnmcfbY06hrrd8h2myJs6Gjp96zKLFMqYqElGlrbbERCgya3f1ofjS20?=
 =?us-ascii?Q?A8XUcQBQztaW+N/9OjnnGN49eI6UIW6Wi0/9tRVjfyzdaa/XNNJs3c2n1BAA?=
 =?us-ascii?Q?HM9n7O5fFiGDG8aeEvjvTNAjPcRtbUDSaRqd2gVtYlKZkRXeT9xmvBRaAZJ+?=
 =?us-ascii?Q?cq5SEu3i6gSvK7M8PDUdGSmcItphWyx6Ccm5+qg14IJELFuh+A+3eycqEBhN?=
 =?us-ascii?Q?gGm5eYiUcBx5NCVSh+GVoz5cdd7u+olpXwyLki50LBfycDYCEhBlpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:30:18.7547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704a31f-c100-459e-6f6d-08dd8be9be12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
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

Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
the resource evictions properly in pm prepare based on whether
we are suspending or hibernating.  Drop the eviction as processes
are not frozen at this time, we we can end up getting stuck trying
to evict VRAM while applications continue to submit work which
causes the buffers to get pulled back into VRAM.

v2: Move suspend flags out of pm notifier (Mario)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 +---------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 368004b716ba8..5d25db16cb4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4979,28 +4979,20 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
  * @data: data
  *
  * This function is called when the system is about to suspend or hibernate.
- * It is used to evict resources from the device before the system goes to
- * sleep while there is still access to swap.
+ * It is used to set the appropriate flags so that eviction can be optimized
+ * in the pm prepare callback.
  */
 static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
 				     void *data)
 {
 	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
-	int r;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		fallthrough;
-	case PM_SUSPEND_PREPARE:
-		r = amdgpu_device_evict_resources(adev);
-		/*
-		 * This is considered non-fatal at this time because
-		 * amdgpu_device_prepare() will also fatally evict resources.
-		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
-		 */
-		if (r)
-			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
+		break;
+	case PM_POST_HIBERNATION:
+		adev->in_s4 = false;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8baeaa5d5b119..e0ca9405719e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2643,13 +2643,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
-
-	r = amdgpu_device_resume(drm_dev, true);
-	adev->in_s4 = false;
 
-	return r;
+	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2662,9 +2657,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-
-	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
-- 
2.49.0

