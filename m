Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C9C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 20:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A8710E356;
	Thu,  1 May 2025 20:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTRO9zaY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF0A10E356
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 20:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFyGz56zNy4qon+52Pf10kgVDcSr6ItRUJajl15nWmVp0+FqRHhX99gUzuGtqBsEMEuP/d3eZpTeW5Q/QG7U8OWSi+JwfUZEczzAHjszYN4Xndp10JL0m/8YCK6d6fjNBNVlycXhkeW3kFP+QbpUXsNdukm6jtHfg+2HDmtIwHu4Tl8SFB4TgHAsVLHx5z01NceZjDSWl/ZAESp8PNzhU+EpkHZp9J967HZkYvLvqmACc3BqIE7mmhToluiWzI3Gm8bYK8wOcv5FB0Vdc/keiWNRzfEPbUQuZXlIzIsSsk2xwPZK+xhGDk071bzzRyFWNJCV9NBuVIqQrrZWp3hxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/Pni3NpTbkydzygm5Wr86UmncE9iJ0rmHQkE3F+01U=;
 b=ty2d4djO6ABbHZ/saIZg0RrbLQWeaFdiYnRcIn7whGPVTcByhQbj/kgqggsQ+k/KKg7px0McZwbV30GF3m0qOq0vCsuyygc+TNT2udUkqggx+LNu+arO2CLKIb5hE7y1Kn3ddWGGAOhqKiVL9ksrRYjWCASAKTHyWqeF0yC3yO+FpHxBD6jwOC7nAMkly+7seAtR951dAgoQvmWaS4HpVZSrlK+qde2lDcK4uV0L6j0j+O7HYUx4HmLa5H7KYThUSywB/9g3kgyLqwFLnQ0TewuS6J5XyX7nHi4YkVgcvbOqBrEEnGIhGhNJtom9dQpCf32unvwPmiIMKY/9SjCAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/Pni3NpTbkydzygm5Wr86UmncE9iJ0rmHQkE3F+01U=;
 b=hTRO9zaYxKne3YGhpILoCIv4mYDqjEx+twybpoY7GTVDFiZlGi+eYOL/vhwNpuOQ6KWIG/TMd85qOUlTJfhxFfMxNrRRhhuBp8Vq7kV//ufU6FSzS9RBTJFLjQPrF/Yn76ZyOruBq6WertE7YIc5NnRoOTG2LaLJVqyYrYBpMnA=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 20:10:00 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::e0) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 1 May 2025 20:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 20:09:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 15:09:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd: Stop evicting resources on APUs in
 suspend"
Date: Thu, 1 May 2025 16:09:30 -0400
Message-ID: <20250501200931.358989-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a4bf0a-03cc-40d4-7a3d-08dd88ec2697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eivUVXUI44RGwlBPV0Tf+pm2tZJ0XKR5CPP3/DRMULRFGbbm6krXv1fTcKz/?=
 =?us-ascii?Q?5yflnWK4zWDjiUhrfXojCg2Hgl/JUvf0OuE8EIRScixtPYSEIrskld9n/hH4?=
 =?us-ascii?Q?FwKBHxqg8q1Jcm9rQufRhNR9bJGfJZU3A/cm5SF76XH75QiZl3WJ0X0E/kXR?=
 =?us-ascii?Q?SNlBgrNUNqIOM3rqCDer2uJUr0oFrF/CxV0Y/bWyOtZj3MvsYM+otQQyam2g?=
 =?us-ascii?Q?3mH06NqI3McKQwqHGImHd0kCe0BMCud3GRX+OygK2A1TRrik42d1c7X1EkFh?=
 =?us-ascii?Q?02pu8Pi1fmhQ1U88mt3nWxLsaS54sUVj6NNSebhuIldf4U4PvZIP5AfGx6M2?=
 =?us-ascii?Q?9hkdp1UVHlvyQnIvrS/DoyYlj1wRZLSTTsNb1hK3YMMa0eJqqPLOdGpR5a4W?=
 =?us-ascii?Q?TAxA8xmZo7EDmr6E/QKkbEjU6/NxiSPIQOKCWrMaaKchlE9VekNTR3f82aQ3?=
 =?us-ascii?Q?C3dn1TDwh4VRmCgJwHlxhjEcO6df1TowT/esQtq4A/3Py8iPlrpHOlhlemlp?=
 =?us-ascii?Q?3Zz/vQuYQxv5ezs1sL1MP8H7C2tDn3L3aK7aw138xz0XYVr9zGBaiQSQK7eD?=
 =?us-ascii?Q?vvtEMjh/Bf7vFak+W+PX0n9GSpV7IRk5/GYfeDO2BoqBCU1JL4/Bx0nGcD1j?=
 =?us-ascii?Q?jkaA2QOlCedyFey8Kr/Tgz8cw3cRJzE+7gxlTUsrJCQKsrXV/rAuFyW9H3Kj?=
 =?us-ascii?Q?sVK7KebukuOyVDGV1v3BSovP1CFJmNkqhtBeazsk/4kWPGEyXRyeLtd0372b?=
 =?us-ascii?Q?LAUskT+H1KuRjhReXdXAh5xihZoo+kZNoAbU9f40IOniBs+u1iw7xrvbItWl?=
 =?us-ascii?Q?3z08MbCnZsY1eJkiE6gQbNrA1RS5GOJbx0JcmduFs0HeNgq9k8JbuiNG8T+f?=
 =?us-ascii?Q?D6thPe8H2eP+i6s9qpoUcUO9jJYlDZYrW3IW14CZ7HhsEViRtO1vsvo8nbvE?=
 =?us-ascii?Q?EAYlWabkOD57Nq4/ZLZiXVtaxGAu9rSwLrPiKrj9rC+1nmCCtkGNWLywWnKJ?=
 =?us-ascii?Q?pP2wZMMZ8N19/2jMNnOkvjXexl5gh/0m4wi4N7CRb1BHuYz/sak+KtOqKSIj?=
 =?us-ascii?Q?vx/tB4wxUN25x2Lyz8p7wwrcgDbxukYYllVwLTHUrk0ydru/mFNennaGSgP1?=
 =?us-ascii?Q?ptWf7i+7ecvWFiD804LrUjDuhvNyzMDnJhH1PV/E5B90/eh/rrchZJ9Dkl3A?=
 =?us-ascii?Q?iq0fl+vw2CnU/CDDGMN4dXQ3b3a+4MU2JSQGjQ7rxdyVjJxbzPi3mdQ8KgHc?=
 =?us-ascii?Q?scZZRcStW/JeH/BLddNijojzOeTFp1uA5WhWs+YckYrGOWPZTQ5/+OUkGbfe?=
 =?us-ascii?Q?NdbgT13ozF0PT/qQi7rkxK4iRGgEdRR0/mVEOGDU1mWoct2RfGHG7lwSfJ0q?=
 =?us-ascii?Q?/sHGrQh26T/7ll5lbJ1InPFVomlE6xFTsWneSqciUpjbiEW9h26DVv2d38Uc?=
 =?us-ascii?Q?5l8TBJEuhFJ7wUpSWItLfvTsBPOJntS+pALKtzb3LeuZq7b0t56aVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 20:09:59.7156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a4bf0a-03cc-40d4-7a3d-08dd88ec2697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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

This reverts commit 3a9626c816db901def438dc2513622e281186d39.

This breaks S4 because we end up setting the s3/s0ix flags
even when we are entering s4 since prepare is used by both
flows.  The causes both the S3/s0ix and s4 flags to be set
which breaks several checks in the driver which assume they
are mutually exclusive.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3634
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843e..85063bcadeef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1656,11 +1656,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143dd..707e131f89d23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1533,22 +1533,4 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
-/**
- * amdgpu_choose_low_power_state
- *
- * @adev: amdgpu_device_pointer
- *
- * Choose the target low power state for the GPU
- */
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
-{
-	if (adev->in_runpm)
-		return;
-
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
-}
-
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b29d1bd1de07d..71d95f16067a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5016,15 +5016,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
-	amdgpu_choose_low_power_state(adev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		goto unprepare;
+		return r;
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
@@ -5035,15 +5033,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
 		if (r)
-			goto unprepare;
+			return r;
 	}
 
 	return 0;
-
-unprepare:
-	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
-
-	return r;
 }
 
 /**
-- 
2.49.0

