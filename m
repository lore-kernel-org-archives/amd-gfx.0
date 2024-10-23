Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A708DD2E008
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 02:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B0B10E049;
	Wed, 23 Oct 2024 02:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6c7OYC3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0804C10E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 02:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc527iNywGc90zfqvCMMyNlyOzoSTDK3QCJ8NXKRxokxpXP0mnxOVmxc8JDCgFWtB5nbYqoE/6CGo2k7VVlaQATKV9KEp0/hpJptWWJWzBuYit4RiVaUcoixZbMtFYcwsU/ghzNRwpsxAFDupuLknKGa/tV9CMZvYsZVj4Nw4RQGt/ogyfDk55sehG2YMI8WBOeAhs475tj0YPHu1s95PsjuNXkI1ySAiwicg0EkgopDDBGZKxX80sdeP1nMXawdHLtmfbPYNz8x/DP2kQtm8yXKBKwdpY+j1YkOKCiJM42C5oHqR8aCUYZFgDGM7EBVLBNSM18G1WBIwkuT02asXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vumwkEt0llNaDFrWqnVst9UHB/y87HDM2ovS2JwpIpI=;
 b=hWyYKI744+453WqQYRcgPj4Y/aB7Vz72EYJ+GFUgzlmVP8J1+jgEtdtatW/baajI0T06EWDkN5ks1F2eQ6ipBy24JsvkSvPHMqziStzGkki7bBXpEhQRiBVIugSQlvp2uXnCK0mgBqJejHo4nIosasF/XocoAC0zerrG1dzX+BVq86HrXBcuvEs5CRR01MKYqVS9PHHxrzIQgsDdPzQL2+KTdFrvnvSbL+Wc4UrNm/3/a2q4iYr/dyo3rVvmw1MGwmiwE+CNgsA4kRsTf1DjG1ULg86U0iDsuxjslFEi88SKDSKQsoA2Dff78kBRXaPAn93ZpJKboOXk2nnYCjfZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vumwkEt0llNaDFrWqnVst9UHB/y87HDM2ovS2JwpIpI=;
 b=F6c7OYC3KYyBSs4jwWOHHdbzm9PENzV+zQiKwvgpTBJG8+X9ACy5mN0bhRgKAc95k19gColgKIuLAbNoDMHyER47wRD1tzPEvHWtNFLAibXOCkcwi2i4Y8kVpjagJxMWvM2DE8ul7f9op+NIWWKiYLJ6sIX0rGsScz3bPTCZRC0=
Received: from BN8PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:94::23)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Wed, 23 Oct
 2024 02:43:58 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::4d) by BN8PR03CA0010.outlook.office365.com
 (2603:10b6:408:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 02:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 02:43:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:43:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:43:18 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 21:43:11 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/5 V2] drm/amdgpu: Add sysfs interface for gc reset mask
Date: Wed, 23 Oct 2024 10:43:11 +0800
Message-ID: <20241023024311.2578441-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ac20f2-6819-4d24-5496-08dcf30c8b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZODkV4WksZWDKP4jz3E7sD7zswuhN0T4WFpeSAjrR6Cs00DnaQMvuiG3KeR2?=
 =?us-ascii?Q?EJzMOPQLpFg3KtGEixJL39l+HTayHhVu6alY0Agt3AhhTTeFEAZHwW8f50cO?=
 =?us-ascii?Q?9NiaQgKUMhhXjdniNGrtAbuOQJTX3RUcRL7BrmE7m6DG2mGFZRw+7Vn8VVnz?=
 =?us-ascii?Q?6Hmt1oGxJ0dKXG4kiofceeFM+oIRCbq1StOWQOEjIPGMyEoDiyGU+yMMLMDH?=
 =?us-ascii?Q?kYbBgWoESVAVZPGvmHvkjQZEDk20c0rP4HcGwUW73F6n7PdAqSCIEUZRTiwk?=
 =?us-ascii?Q?r8FTpFX18urAmvBejOkK6KLpexvi5HaaipFoIA/E80n/5LAzHahbYTbot3RE?=
 =?us-ascii?Q?KzSrEO0L5jXVPCWMxaCfeXAPV6OoK/9jQsSYEK+Da4RsdvVfy6IBLMwJhWuc?=
 =?us-ascii?Q?VZ8hhVd/hLngs5yPBlN/fR3bmd3XYEvp9t/dBz1tbseTrw2Pnc/FzPz3FYAI?=
 =?us-ascii?Q?4LaP6qFUcklyQ6vce0UhihpSCo9fGNpN/CVpRIoUuw3vaIjjzaMGFfQC8E62?=
 =?us-ascii?Q?AwZlmIarS+5kI79Sn2iYY/if9jrjH0oPJi37bXZYb+nefn6IR7dyGmeWMugM?=
 =?us-ascii?Q?dMM7soFnMUbkVhjbgR+TiyEK6PenFJejii78LF87IP0wHUr0i57W2RgiL4rM?=
 =?us-ascii?Q?smnbRpW3QPimI1ELxBeeFoFs7ykucYiy44VIBl5uZq5d24hlQ/6iN2CgHB5S?=
 =?us-ascii?Q?K7ygaJrsoTjNctWbRYEtUJqdr/S0SVuO2FtsSV5aufd2Jfm35YHozJ6Ul+5o?=
 =?us-ascii?Q?hCZBKeL4dOnJrS88nbfrUn3Js4Anl4FCk3eoWfnI1s+OHTWaKHuB0+J/8uJJ?=
 =?us-ascii?Q?5ZPoDFdTtWNUdcG2tdmiqGPImTWJPyjjEEVw/eKAp3JKZIlWUYzBku4SHdPa?=
 =?us-ascii?Q?baVQT66BhlfytFDwjBQIQj+S8+UyV/rireAz9U+D1ZTpNyUuDrWwwdVbR6ee?=
 =?us-ascii?Q?IWnPnlJ+zhdkTaC2WiAp71D6yDqtndyZUlzqWNnF3g56mr74Z5U20YS2i3xI?=
 =?us-ascii?Q?q2hoj/+5kc5Amu42o2LTTdLFsbVd6iVcH8XLbEKK8E55X+8HUqeay+dJMD/s?=
 =?us-ascii?Q?FbSsJyEzGMv4uHfjse9mxkVVq78do5UhGsXDWQfdSbu0QDHHexGZx29gz4s+?=
 =?us-ascii?Q?lHax7UmhwcHh3FHydLcoqQnjrsKz6yEN7J66q3oYUXmoopGbLJmDfCnQdCgr?=
 =?us-ascii?Q?KHFyqNEKU3+yRM2/HgAlMzp/aoOYhp0aJRBcmf81azLaZIc66aESU4LALPwF?=
 =?us-ascii?Q?vW2skZuOWE5jNoGqtKQH0OTaKQl46PTWV/cOpfSazpGzb2sTE9cd+m1bWqYQ?=
 =?us-ascii?Q?nH4n++xvUfr6PSy0wE5U/iGg/Mx5Ft6rllLSEDGEsnFRRQOAGi3F0nZLOi0l?=
 =?us-ascii?Q?Dy3tZcCxEJAxIedIKYpZ3wGRSbz2xg4KbNxv58Soaof9KubsOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:43:58.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ac20f2-6819-4d24-5496-08dcf30c8b42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 122 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |   6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |   5 +
 7 files changed, 150 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..10d55755ee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1588,6 +1588,94 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size += sysfs_emit_at(buf, size, "full ");
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset) {
+                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+                case IP_VERSION(9, 2, 2): //reven2
+                case IP_VERSION(9, 3, 0): //renior
+                case IP_VERSION(9, 4, 0): //vega20
+                case IP_VERSION(10, 1, 0): //navi10
+                case IP_VERSION(10, 1, 1): //navi12
+                case IP_VERSION(10, 1, 2): //navi13
+                        /* Skip flag setting because some cases
+                         * are not supported by current firmware.
+                         */
+                        break;
+
+                default:
+			size += sysfs_emit_at(buf, size, "queue ");
+                        break;
+		}
+        }
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+
+static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size += sysfs_emit_at(buf, size, "full ");
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset) {
+                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+                case IP_VERSION(9, 2, 2): //reven2
+                case IP_VERSION(9, 3, 0): //renior
+                case IP_VERSION(9, 4, 0): //vega20
+                case IP_VERSION(10, 1, 0): //navi10
+                case IP_VERSION(10, 1, 1): //navi12
+                case IP_VERSION(10, 1, 2): //navi13
+                        /* Skip flag setting because some test cases
+                         * are not supported by current firmware.
+                         */
+                        break;
+
+                default:
+			size += sysfs_emit_at(buf, size, "queue ");
+                        break;
+		}
+        }
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b)
+			size += sysfs_emit_at(buf, size, "pipe ");
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
@@ -1602,6 +1690,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
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
@@ -1702,6 +1796,34 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 			    cleaner_shader_size);
 }
 
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
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
index f710178a21bc..0cf2151b3cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..2baa76095232 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4856,6 +4856,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
 	if (r)
 		return r;
+
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -4908,6 +4913,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_free_microcode(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..32d14b9cc6e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1721,6 +1721,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1783,6 +1787,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..925b7ca49b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1470,6 +1470,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1530,6 +1534,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..0de199c1cfdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2394,6 +2394,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2432,6 +2436,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..87cfd77e2fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1175,6 +1175,10 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1200,6 +1204,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
-- 
2.25.1

