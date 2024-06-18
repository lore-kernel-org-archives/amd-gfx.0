Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810E9C2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BE510E6ED;
	Tue, 18 Jun 2024 15:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIgN+j2v";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4061C10E6EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idZ5T0DWr5s35D+MoKnQ0yqA3JjjsaY/Y5RqzMhjfs+hBWU7zWHSCVGkvhoZClf+Wt1onefYqICeCQb1kL1+4+UwdtC35dMAofglO4GiNn9vx8eWPl0jLvQnBm7GRD4Z6aRYP4/3nSXwm0caTTWPceb3f+YX99/hY90sebCnAgznHJZly8lMRApT5Ay9Tbs4obltezbwKP4lyiqf0TPcZqXO0rI/k9aCIYGEUkBvjSkyj9iU7ASpeGfKVnZ/kXDFthIo+ViArVpfFj2A7Cn++1y+TXQjVN7DGaaRw7N59dl+jj7pvxtMhRAXAX+JxxKg/icfHLxBEwA3BlMqXiBPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLWNml/5GaxC87qDGJxajJl/borBoMZnCIFBRaSdRK8=;
 b=Nhvt/PWSz8y/OLHWLj2aqSxId1TeAKYtdClOxU2Nzv4rwhS6EU/rOF+InGpUpXk1J04gtZSp0zyGmATAB504Z+/vz34Q9BJis2as8qJ7EIabk/rpJeGlyDc6eXtBwyRjyEUoGomZJr+A1SfZ0ZWGNVPV/+iZnKFbTzD/p94HcrxN/aUy//NSRNbQaKzxO3G20GWofPgBzpGCPHXJut6R8S7ozwdtxXBwsEQnOorzDEOMB4FPuZAmFpAVq0j+/SYM//hOrFQV7WdjBmfv1znZTh3xyWvB4cUWvcnWuRE/Et7GiSACBy2AufBC1RK6U6vf4wdBErJWw11F44C9D4UKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLWNml/5GaxC87qDGJxajJl/borBoMZnCIFBRaSdRK8=;
 b=tIgN+j2vWirox8/qa8/5FspECmAuyATNkJx7z1MpH5mEg1FlzpGYgVY4C0t4StBCK+yK7Rwuj0AoVaZrP0Y9vpO2zv8WJgJEYWyCuzFfLJf+gGYUeBMDtU5fEl3GcnQRCWJ9kL18Rsy2oLb7vhm3P1QXlyK6aElci+5RHCPDYMA=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:30:45 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::41) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:44 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:42 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: refactor amdgpu_info_ioctl to allow finer pm
Date: Tue, 18 Jun 2024 17:23:24 +0200
Message-ID: <20240618153003.146168-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 90905bf2-1278-4e49-ed4d-08dc8fab9eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEbvD5UTfNviCOoj75xxUkfD4HE3NbeqybdAh1+iEEWlQsO7T3qAvbPWeoOm?=
 =?us-ascii?Q?Zgplufi/II7N5Z12SUzk6yqwK+va5IQJnDr53bG/fSZI7Qs2HDuJRg8o+IpO?=
 =?us-ascii?Q?9whRZvCS9NI7TiZF5lYsOgTX1w64Xzw363SoLZcKSxYjd/6WCwLXgLNfofb3?=
 =?us-ascii?Q?VZHiZe6H5FNtON6NX+yg9yaYbmG947ksiFbCliHWBkndlwUb9dSm0y+Yzfe8?=
 =?us-ascii?Q?K2lOpU75hXhqgvN0Kxz1OxB6C72bC87SIUdlemD/driGGU/qVZwFJM1nmk9D?=
 =?us-ascii?Q?09KsK0s1dEhQNHpPUbn5MOrmzyMQ1ySXrp/Jv6j7YHrpNTIaxtYZrte/gRJq?=
 =?us-ascii?Q?/KMo+zFNZlpk7LjIBtYPD09AlocMgZLsTu6H8KY5wEerG4kB1rCELDWegVPm?=
 =?us-ascii?Q?61hxtg30J/UVJoqP5DS/rQQz8FW0xw5ul9orQchsXkbc+e1c3aki0+VgBnAc?=
 =?us-ascii?Q?VJc0QNG52agdLlFpn61Qq8fRkCaZYzgbJdtgxAKJIGAq2lwjaY3J1c1D8wtU?=
 =?us-ascii?Q?CoqKeLOUBdJu0OzuFi1OTHTlKF0VUMb/agVwY6DKe5/HDBT7InlYZSFZxm5N?=
 =?us-ascii?Q?1OqI1gMbPO6cKLeWi0x8rP8Q422mZEjY39ZNVRHBjZx4FN/mwy9f9QHh6nya?=
 =?us-ascii?Q?xWakenllzZccKP9fN5/6xfWILQTKq7F2WqTfJIPfYqvA1/z4gATGofMKVrGF?=
 =?us-ascii?Q?E3HBwBqXjHnk67zh7i4OsmWd41OJaPJ1kjhOldISFXnyNR3pMcq4i9Jc9Xs8?=
 =?us-ascii?Q?fDkYcYWFz0KiaVTd5JDctn5FYOGGiT+IVK0sGJGXAcFCEiKQyYbImdlGwx23?=
 =?us-ascii?Q?sjns7zcpMBqD4A5yFkk/XEGDI6QIUu75BSzi3M2ZMHtwgtlhAXh9CwYsqcSf?=
 =?us-ascii?Q?CbHnY7jnZQN8i/S3vr3dtgG5RxTavL4HEE5xvXS42NU/kmquZg/ueLLCq6lx?=
 =?us-ascii?Q?qAQEztnZnsa3/WTTVuu9GiCXudjTiDUf83kxDOHGF7o/cPCn/5x2cC64CNmR?=
 =?us-ascii?Q?jGLZLfZDN2vu3UKgFx8+bMmhAuTmNsgc7o5ufiShUq3GOXWcnpr+v86e9LRm?=
 =?us-ascii?Q?bt2ujwLC7HVLJCIR+kPG1GVsEF/4XBDqF/gZsRIS5EyoLv3SMI5JnhUynnfj?=
 =?us-ascii?Q?/ZGGYj3w1XKI+Tjrc4+jVMPeO7UMl8l2zCRyc6N8q9ZpAEgB6Lyop6EmNZou?=
 =?us-ascii?Q?7I+jto/32bFxwnktL4qyAorMos67PS8uu+N82iEz1yXOo0fwAvqZBea6zttu?=
 =?us-ascii?Q?+EQPz+rwvYUMnxlDIy3Zk2pAtoY7we7ljXYeXyu6QA4o5FBYrfM+YFc8v32o?=
 =?us-ascii?Q?3zsb4CdVq8r5WD9zk5MX8AdHk+wvTfLuWTVgPH9vg8ZXkr/g837UlMbb8TOR?=
 =?us-ascii?Q?wxN6gd/ugZMMt/vdJUtSCkoy9CMlGHEtlsWzEz9fd++mPy4Cmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:44.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90905bf2-1278-4e49-ed4d-08dc8fab9eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

AMDGPU_INFO_xxx has lots of different queries, and only a small
number of them actually reaches out to the GPU.

This commit extract the amdgpu_info_ioctl implementation to a
helper function, and then wrap it with the runtime pm logic
each query type needs.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 94 ++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d21d5af7f187..f51f121d804e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2871,6 +2871,8 @@ long amdgpu_drm_ioctl(struct file *filp,
 
 	if (is_driver_ioctl) {
 		switch (nr - DRM_COMMAND_BASE) {
+		/* amdgpu_info_ioctl will resume the device if it needs to. */
+		case DRM_AMDGPU_INFO:
 		/* These 4 only operate on kernel data structure. */
 		case DRM_AMDGPU_VM:
 		case DRM_AMDGPU_SCHED:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 260cd0ad286d..b32ff6e1baaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -543,22 +543,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
-/*
- * Userspace get information ioctl
- */
-/**
- * amdgpu_info_ioctl - answer a device specific request.
- *
- * @dev: drm device pointer
- * @data: request object
- * @filp: drm filp
- *
- * This function is used to pass device specific parameters to the userspace
- * drivers.  Examples include: pci device id, pipeline parms, tiling params,
- * etc. (all asics).
- * Returns 0 on success, -EINVAL on failure.
- */
-int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+static int amdgpu_info(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_info *info = data;
@@ -1278,6 +1263,83 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
+/*
+ * Userspace get information ioctl
+ */
+/**
+ * amdgpu_info_ioctl - answer a device specific request.
+ *
+ * @dev: drm device pointer
+ * @data: request object
+ * @filp: drm filp
+ *
+ * This function is used to pass device specific parameters to the userspace
+ * drivers.  Examples include: pci device id, pipeline parms, tiling params,
+ * etc. (all asics).
+ * Returns 0 on success, -EINVAL on failure.
+ */
+int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct drm_amdgpu_info *info = data;
+	bool need_runtime_pm;
+	int ret;
+
+	if (!info->return_size || !info->return_pointer)
+		return -EINVAL;
+
+	switch (info->query) {
+	case AMDGPU_INFO_ACCEL_WORKING:
+	case AMDGPU_INFO_CRTC_FROM_ID:
+	case AMDGPU_INFO_HW_IP_INFO:
+	case AMDGPU_INFO_HW_IP_COUNT:
+	case AMDGPU_INFO_FW_VERSION:
+	case AMDGPU_INFO_NUM_BYTES_MOVED:
+	case AMDGPU_INFO_NUM_EVICTIONS:
+	case AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS:
+	case AMDGPU_INFO_VRAM_USAGE:
+	case AMDGPU_INFO_VIS_VRAM_USAGE:
+	case AMDGPU_INFO_GTT_USAGE:
+	case AMDGPU_INFO_GDS_CONFIG:
+	case AMDGPU_INFO_VRAM_GTT:
+	case AMDGPU_INFO_MEMORY:
+	case AMDGPU_INFO_VCE_CLOCK_TABLE:
+	case AMDGPU_INFO_VBIOS:
+	case AMDGPU_INFO_NUM_HANDLES:
+	case AMDGPU_INFO_VRAM_LOST_COUNTER:
+	case AMDGPU_INFO_RAS_ENABLED_FEATURES:
+	case AMDGPU_INFO_VIDEO_CAPS:
+	case AMDGPU_INFO_MAX_IBS:
+	case AMDGPU_INFO_GPUVM_FAULT:
+		need_runtime_pm = false;
+		break;
+
+	case AMDGPU_INFO_TIMESTAMP:
+	case AMDGPU_INFO_READ_MMR_REG:
+	case AMDGPU_INFO_DEV_INFO:
+	case AMDGPU_INFO_SENSOR:
+		need_runtime_pm = true;
+		break;
+	default:
+		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
+		return -EINVAL;
+	}
+
+	if (need_runtime_pm) {
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0)
+			goto put_pm;
+	}
+
+	ret = amdgpu_info(dev, data, filp);
+
+put_pm:
+	if (need_runtime_pm) {
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+	}
+
+	return ret;
+}
 
 /*
  * Outdated mess for old drm with Xorg being in charge (void function now).
-- 
2.40.1

