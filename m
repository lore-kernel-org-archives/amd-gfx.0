Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B43D13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3B110E5A1;
	Tue, 29 Oct 2024 06:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3YPv3pI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E398610E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5VUiC1uC9PTyUYJNc6F7SE++1azAAZdQHf4I4uxCXpTTfguYNSgMcG/aboiQijBB+q+DXEuE6ldro8YueoFZwWaDfHuLg30d8slKJ2nxvwn2HPwC8WOCpoc8LkrFhPJTnRZNZdM1HCZQKDDuHEBDLA19hT8TDE3F0VKGFzGQUS5rUQvqp9lUYCrFTwBscSphTHNvIEk7GDC/QhPvppIU7L7jIBuwIzsjQXQqrlF5sxy4K5H1u0ffgUMyOfwSw6r0tm4PmX2h2CPH4x7BHhJM0X2Ysr7QcgD9BuamGpQHM6WkphZHTptmENKtDT32QXguuetVsYamkbQpNaP43Vb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDW6imHi1fassAcHzNXVnRfbVHpnQQib+CwvBNRW5mw=;
 b=JX70AvvRshqVCb405cxqKnwhMlDT3wmrZDuHgGv2vF/Y8jc2CWuWtXKwt1DKcy6dWJX1E9nMoespMmJA1XHVly6pN5W8yiZhEjUDDw3HIjQPlIbBG6KU8vrWkt5I0FkleOXVwuOCe7AmbxmSapNpFDKwWlSaMSZRfojQO7/15deeGMDEPQLq4kajCl4xkbnxV2bNgvCuzeVcQsUkRmfyJwebGs1UeFxR+wJkMZCpQBQmbahdrQm+ZVu8pbx7OW9K6tTcof4vd0cunrsgGdFlgull/M/iILexpA/Lvv6yxxIsGvDt+7JGRJtLEycipp2XEsd2KJLAakt4FKoJOV4KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDW6imHi1fassAcHzNXVnRfbVHpnQQib+CwvBNRW5mw=;
 b=S3YPv3pI49F0iTSCOQ3Aa0XrZa3iImPzvZzqL2LjUmjWrdkNeRK9aTE/iNpuSjNfkEyRBZMOtk8V/dqZjROFgNRU1hJestXRorgtdjIeqetn3K7gvDXwvOuOfH+/gconxuKLZDE+qaGhF8TRB/5QtmN+C0MhRAdEtH8su10igwk=
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Tue, 29 Oct
 2024 06:41:44 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::1f) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Tue, 29 Oct 2024 06:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:41:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:41:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 01:41:36 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Date: Tue, 29 Oct 2024 14:41:32 +0800
Message-ID: <20241029064136.3057034-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: ba942aef-7b99-4418-8d69-08dcf7e4c108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFo/JIUZ0CA3NMIuqj9tzcMnixnoYJMi6/3veOr8+iUx46a95kjQcNdYHEq5?=
 =?us-ascii?Q?ZOsf78n1Qey7tj9iu0nqc2RxllZVTmfN9qPKpbRjS3wNbDhrTKFVT56jejt6?=
 =?us-ascii?Q?F7AiUwRbLDyiHRMyxqNbCQWvbNtoKOmPZUTL1UNZ51B6QWS30bHxydaTuifb?=
 =?us-ascii?Q?BaYtF4RLQiZoXL4T7yCKon4HVW8k0Qw3cup07iWrl9TuS5IacnoTwsE8mZSy?=
 =?us-ascii?Q?QeDM2/biYvs4tgJSDua/i73YGbos7dLe9xf0G7BvWzgDX3ZmRhDeOVC+1q38?=
 =?us-ascii?Q?xSiwJCNKB40RzryNCMVE+gj3g2aDiloSYUFuoTNahwHUp5wvAKghkvDMlmFc?=
 =?us-ascii?Q?bWOCM7Wly2oP0D51IZpTHwUqeJ/L3WwMEqwQT0/hPx7xq4hX8KsoWQ8Jq5Nx?=
 =?us-ascii?Q?Gfyv/b12d4/wCka2SwYsjTLRAHK/qy+EjJE4eczeu98DaFuQil31LMv6UDJh?=
 =?us-ascii?Q?M164BA2OZ0gSqIlDGKQxnhp4qjsTsRigrv9YCQPTuaY6k1T9cHp8tppJmxJi?=
 =?us-ascii?Q?AO2vuhA9DQjucsHwWs0SuUwWJIRXiuDRxLiXOu75EPOJl9iPdaVdFAm62Vq0?=
 =?us-ascii?Q?xEGtElOTpxC9SW9QCzBXIMY9imQ3On/4ygGuzwFXIGcErpH7BW507upFO7n+?=
 =?us-ascii?Q?/h4PQiR17nEK0pvzwbjAMY2bQwK84yVoQBw02hsHK7cdn8zjQBvYFVnEMnsk?=
 =?us-ascii?Q?xNJVvs3ney4c/LZDGiTCxvqshsrgIBHj/I1CUDSh3QuCsm1EVPbdJPZO4Azm?=
 =?us-ascii?Q?y/XH9Np3nv2PBeaYNdaicqyK+tDaypb7QvtpiJ4hMlX5V3LjApaulB0pEcYI?=
 =?us-ascii?Q?CnJcKn+Y+bDd9uM/9y/gYSCYxHfUPbPCnUigJ+2kWOABlJf+MILfK07+Vd3b?=
 =?us-ascii?Q?jdMfiehJSqfYL4U6HFsCDqkQMLNLjAQPstxP1w7klfotbY5YvtBKWkr1hgRO?=
 =?us-ascii?Q?diRapFk8Nyl9Me/ov2yLRfokWcoFzqf/j9/ETCKhA14Q3MfURy6VljNJCqtW?=
 =?us-ascii?Q?/5vbbl5rT1ReBfKpylnYzVGDlaovSiihzTHy5bjHG4tE4pSP6QI5uQ5oDIm3?=
 =?us-ascii?Q?eyEwpLAqOTyHn2EHtH7gm/Gy1UXX52jT4P3o0PUFTiHt9iCf9CyUwDbyXpDZ?=
 =?us-ascii?Q?KdMbtshTbBW8eeHsNJfT2b6up8jI65O9cV83DPRKOMIpd3/Xv03iK9QPltou?=
 =?us-ascii?Q?lR6m5A3SrwnvuiYQPu41K/mEgwd+iv3dZZF1qnPcNMF9mhP4ThFo63S8lI3S?=
 =?us-ascii?Q?HXzAdrTcUYhvlUYcbvY1xVx8ZrlmKayPE02p+FZPMCl5WBc+3JnqFpMQP84M?=
 =?us-ascii?Q?AIgDLz9fw1/OGqJfYfc087ysZtBNCKEjriGeA2eeMkE8ppxbnyOB5suaQCVO?=
 =?us-ascii?Q?xzcYyVYFB5Z/8PmRzdCZ6NZGLIJDkpbh1+TKDuHD7Hmd2aiCNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:41:44.1997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba942aef-7b99-4418-8d69-08dcf7e4c108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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
index 5aff8f72de9c..89af21b57885 100644
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
+				adev->gfx.compute_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+				adev->gfx.gfx_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
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
index 016290f00592..bd1a0f9b7a37 100644
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
+			adev->gfx.compute_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
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

