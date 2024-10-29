Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5C1D13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 07:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7B510E247;
	Tue, 29 Oct 2024 07:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kdepPqMU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C9C10E247
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbulDzjW5nmfe+FmOydckxKo9oL+dua1Tc83/zH9tfVPnk5IoRwGsgUQ+n2R8VoWdsH4QUbADoJCHmcMsB3WkWcnM2hwwC5WfCy/Zlog/6tuxPs0A4XAIS8N4syMy/ilzD9lC0XIkBvpsMdj7UsfG0bYpKug+y5/YcsfT0oenN9tooRJo2laNCOfOFCovUCciJjRwJfJwSR9CgGTgpegrLR40qqM4p79aMk0DickuioJGbsx7pvZR7R9lBNT1munfAGT3xVx2yn3lBsTpJfNCjgQiVmu9HUY8kuegGrlHoCtz7KjM8iM9NrbsYF/1i42N4y0Jhu+0AhAYosVySQ2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J31tToGkPgDF4b4ufy6ztxhnwpkTAE3qEsUfSsNsaxk=;
 b=ukw0drUvwwT9ms0W3BOi31ZTp7FDjt/pL/s9ajvbqSnv88iPJQ1fu3QAA5Kys/JR6XvmyMLkYvxZZnFI2EQg4nyq/A9zHOwRRb7jW3vdKeYDRVy3eGrgVUtACdOnWjWV0Um63EMuZR2i1sstL/mYAUFYzVGscB8HCLYUyUqQMuZEPYhtgLTBAQ7ROAN9IKAhXuZY9mT8N9k955IoOrgS3rEYk6I4LuiiG6fGHEZ8wHlL1MINJy29AjgtDgejyoDcAPlNWfCdOu27KVPKHyshCHAGvyvwHCaFgLZjAie9dtCqCGo5sWhRs5zKmxTdxXJ5u4/AqXvWI8dxyhvg9ZPpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J31tToGkPgDF4b4ufy6ztxhnwpkTAE3qEsUfSsNsaxk=;
 b=kdepPqMUkjA2LOpOlH0GZlsdXWPaT+PMewSeRxMW3hbnIsE86fshwrNoGrIY+3x7fZhC2V+sTTUQ/7vkmvrlh0jRtSRt+H458LIZkpx6np7b12mBaFzgiyBxACKm4y4UZQ/LhVRYvJvmnu4Ul6VURC1NlnR5/X7Nuj8hRlslSTY=
Received: from PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::24)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 07:15:01 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::a5) by PH7P222CA0024.outlook.office365.com
 (2603:10b6:510:33a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 07:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 07:15:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 02:14:59 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 02:14:52 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Date: Tue, 29 Oct 2024 15:14:47 +0800
Message-ID: <20241029071447.3077959-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f047dc6-b1f6-4857-0620-08dcf7e96709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YiOqQgJZKDKbjOyjqEyftc4AczV6nntrXjFLrOsiudW5skZL6wyFXuMGyuzS?=
 =?us-ascii?Q?VphhCMjtuvL3ImPaSLsWVtwwbJd6HqY9vnhvjblFRPS4eDKke/h+1cvZUC8l?=
 =?us-ascii?Q?vkO+eBWq1qT+th6q6ow0vRlFOy07u4aR0ItC6BHGC72IxWQld9Tc5o6pmRPF?=
 =?us-ascii?Q?Ae8HIkOliN4Wv61iuGpFnBv9lK7oO54fHOZd2V8H8j3+YLouO5LbQ+I+SUAl?=
 =?us-ascii?Q?L6dZnu7g/M5tq9b23rUbptFrxLE4B+4iWPuEMCLnbCesRGAgqShFcz2s8Zjy?=
 =?us-ascii?Q?vBio15Vi2aoRwhsquorC7k6cHNl4rP1jErU1nADRrN1lNra9EJ9TUNm6e7da?=
 =?us-ascii?Q?LVG06Fc2TMwp37KEk2XbaetxPytgixgN2sZ9IC2sOLkHttzlDwLik1tkzZzv?=
 =?us-ascii?Q?iIaKqmh9Zg2TuukwRT4j0gG+gZ+QldvL2bzbLWvaunljvoN8GElfHgauhpKZ?=
 =?us-ascii?Q?R0K04E5SbxTa1L/9bNFUe75fPpqe2mFT9AKKWCVSNErJnjFlh31rt8YjNyht?=
 =?us-ascii?Q?Hc8lfS2xlv5GtNrqvqtrQtY2UxUZVoTmE8O/y9iiG/ZTrFoI/gnFFaiEzl8s?=
 =?us-ascii?Q?Y/hh25HFIyWWZsMtjqM9o+GZ4aJyIYEnwQyA9DU0NhgpY/+RdLXWQMWx2tgU?=
 =?us-ascii?Q?MA9mEPbexHW/FEF41UWqgNreuLUBx78HuQil5be7RPxSlchSH0+6xk6HdgeO?=
 =?us-ascii?Q?eQk0/EPnng6PB+bj4Pnz/MScrtOEBlYucVJvDDEQCyYq+LK2JVi3ndBGfJjn?=
 =?us-ascii?Q?zfscY0dKKEZswycvKuw3KCeM+dV0QAm1WRexpwv2WhYtxA8ay89nHBGzOofL?=
 =?us-ascii?Q?hAITYEbHJ3TtUICZKDhIQMIH/ESUkQ2p9TPaB5K7FuxckAJpXwDa2cIVfBOP?=
 =?us-ascii?Q?5l+wtSM4qIfbSXzlHIRr+eQxLYBnuIaazn3BD8ovpGa6/rvS5o4rTkCIiLYg?=
 =?us-ascii?Q?ncv1GSuPdrpZ6RgcvKbr7r/HMLQ8XH99824Z8Pwqn8Z8wGfVMyuRJv+/52MU?=
 =?us-ascii?Q?l4JnSD3of/909LmpAvtOT370EoAU4oIYf9b9S0XykzEZDzQiPdJDiqxE++3r?=
 =?us-ascii?Q?7pe9bqTprqNYnPbiRcisH8NiR2aE3RQ1piKthNVEJAA3FJuo70YwwJJAvAC/?=
 =?us-ascii?Q?qpmo41eUA7+5gtxq17qmZHum6+Uax0gHtZSA9zV+XQhfmqWneodZSKEjD9c0?=
 =?us-ascii?Q?I3mKwI22w3Z/gJuTm1tqlK2tIEWub5sw8MpZaN/aXb7aj4n4YOu2FmlXsFQp?=
 =?us-ascii?Q?wROS/vP+4KbLewURUlnHEjvlqLO8kO65Saglx1QWqnhP67qid7h3GdCGlwcd?=
 =?us-ascii?Q?sq32zJNPN3L1BZ/FL9Y4SePqqA+yl0x60Jv9OrB/2+U+DIaj/fG4j+GzS6pH?=
 =?us-ascii?Q?6fhg2ePsUJvguwORGAW8t5YLYRAF+pDUvWpIGHUr6945BxgQ1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:15:00.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f047dc6-b1f6-4857-0620-08dcf7e96709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Add two sysfs interfaces for gfx and compute:
gfx_reset_mask
compute_reset_mask

These interfaces are read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)
v4: Fixing uninitialized variables (Tim)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  9 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 23 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 10 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 17 ++++++
 9 files changed, 184 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..aea1031d7b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
+/* reset mask */
+#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
+#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
+#define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
+#define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
+
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
@@ -1466,6 +1472,8 @@ struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
+ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
+ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef715b2bbcdb..cd1e3f018893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
 	}
 	return ret;
 }
+
+ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
+{
+	ssize_t size = 0;
+
+	if (!ring)
+		return size;
+
+	if (amdgpu_device_should_recover_gpu(ring->adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
+	    !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	return size;
+}
+
+ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
+{
+	ssize_t size = 0;
+
+	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+		size += sysfs_emit_at(buf, size, "queue ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
+		size += sysfs_emit_at(buf, size, "pipe ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_FULL)
+		size += sysfs_emit_at(buf, size, "full ");
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..6de1f3bf6863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1588,6 +1588,32 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset);
+}
+
+static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
@@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
+static DEVICE_ATTR(gfx_reset_mask, 0444,
+		   amdgpu_gfx_get_gfx_reset_mask, NULL);
+
+static DEVICE_ATTR(compute_reset_mask, 0444,
+		   amdgpu_gfx_get_compute_reset_mask, NULL);
+
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1702,6 +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 			    cleaner_shader_size);
 }
 
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (!amdgpu_gpu_recovery)
+		return r;
+
+	if (adev->gfx.num_gfx_rings) {
+		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
+		if (r)
+			return r;
+	}
+
+	if (adev->gfx.num_compute_rings) {
+		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_gpu_recovery)
+		return;
+
+	if (adev->gfx.num_gfx_rings)
+		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
+
+	if (adev->gfx.num_compute_rings)
+		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
+}
+
 /**
  * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..fb0e1adf6766 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -424,6 +424,8 @@ struct amdgpu_gfx {
 	/* reset mask */
 	uint32_t                        grbm_soft_reset;
 	uint32_t                        srbm_soft_reset;
+	uint32_t 			gfx_supported_reset;
+	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
 	bool                            gfx_off_state;      /* true: enabled, false: disabled */
@@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..e2b2cdab423b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4825,6 +4825,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
 	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
 	if (r) {
@@ -4854,6 +4859,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v10_0_alloc_ip_dump(adev);
 
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
 	return 0;
@@ -4896,6 +4904,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_fini(adev, 0);
 
 	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	gfx_v10_0_pfp_fini(adev);
 	gfx_v10_0_ce_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..ec24e8d019b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1683,6 +1683,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+		if ((adev->gfx.me_fw_version >= 2280) &&
+			    (adev->gfx.mec_fw_version >= 2410)) {
+				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		}
+		break;
+	default:
+		break;
+	}
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -1721,6 +1739,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init (adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1783,6 +1805,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..f5ffa2d8b22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1437,6 +1437,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -1467,6 +1473,9 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_alloc_ip_dump(adev);
 
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
 
@@ -1530,6 +1539,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..94007a9ed54b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2362,6 +2362,12 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
 	if (r) {
 		DRM_ERROR("Failed to init KIQ BOs!\n");
@@ -2391,6 +2397,9 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v9_0_alloc_ip_dump(adev);
 
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
 
@@ -2419,6 +2428,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_fini(adev, 0);
 
 	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	gfx_v9_0_mec_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..028fda13ac50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1157,6 +1157,19 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		if (adev->gfx.mec_fw_version >= 155) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
+		}
+		break;
+	default:
+		break;
+	}
 	r = gfx_v9_4_3_gpu_early_init(adev);
 	if (r)
 		return r;
@@ -1175,6 +1188,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -1200,6 +1216,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
-- 
2.25.1

