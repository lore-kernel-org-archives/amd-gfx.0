Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C26D1CDAC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8BF10E603;
	Tue, 22 Oct 2024 07:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgYRwQ6v";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE8710E603
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl4mOfXxzd3Ql8XoQx/F0cTrobCinVqrHqXXTXi35cKfNaDXr40oGfsFCujpN0cp9R+cXz180H9J3GKA16OeYiToMPkdCmNFDJ1/HQOkX9A9zFgmWbO70E7cAu3eEDdWcmu/AYeatDn2G+YSBtuJH39gSc8QN5R3GxsPYKDod0K9bG1COgHjeWduEa8JQeAGUMzDtRh9OhaOvrG9zvsWbrwwq6Jf94gMavkN8xAkAMvKqQtINJcUOxjQFQE6eBdbS8sX15QaC323han4Hxw4LFqgZkrF/nPIGubcJEBsqRdE3ZGumrOjlA2Cb02e8n8GLiSrUhr9vnmMM4b/tABuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqylpsds3BTVP6Almh8FXIA2mqIHf5jk5Kx8NS6uP3Y=;
 b=pnAOtH8LErIq7Gn3BFM6a+apAPPCGp9WG/EfEgjpxlWglBaMb54kAEsoqlNEQEvcBBYing6hzTQYUBZEVYGv9zH26h4w93WY6UHPBzVh6XFBMT04SpxrklzLK0u9xoKbL5MVydayBcX6VQM5SchTl21i98dXtwa0PCvvp4S7NvKAK1VACXq4UX3UHbwbjAuPPi44S5amkd+8K4LDDTEmPeaAuqU934sP0ZxU3fxS+Vh/ZaJPbSCvY5b5nrf1Kp1pnOXOIbzKuQvfPM8xRhEH9jCR2jcHdfUpGZJ/55DcA65pxuUDOnUSnZEiCQix9fuZKVn5LU9tRTUJq8fSA6yZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqylpsds3BTVP6Almh8FXIA2mqIHf5jk5Kx8NS6uP3Y=;
 b=zgYRwQ6v/CVQQEeCV8JkaGQnriP7LZYJoWPCemEzwfJQLk2f8w7ip3pFN6OJsFM3OvAbkBRkSBWbkEQMWzNXhCXu8HvIA0E4Lqlez/o8LS9pmXn4iz2BY6OZ9hG6QWKY+9mnN+gFhsWt9GGGNmMcvmFuhwdLsGgxB0sU8HvAq1M=
Received: from BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:59:38 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9c) by BY5PR04CA0025.outlook.office365.com
 (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 07:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:59:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:36 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 02:59:30 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Add sysfs interface for vpe reset mask
Date: Tue, 22 Oct 2024 15:59:08 +0800
Message-ID: <20241022075909.2530386-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022075909.2530386-1-jesse.zhang@amd.com>
References: <20241022075909.2530386-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 858ccf46-6339-4ba9-c0a9-08dcf26f79f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dmI716wy/yeEI6i1KiCFr+althl9wZdj9E8TQceUYNYERck4Hf4nPhtesD2v?=
 =?us-ascii?Q?XCkv1/exLMVA5ldnFHS9Zz7HQLgt/emH1FNP3F/z0sJuMKUin3GNaEvO0ar8?=
 =?us-ascii?Q?TfmEkXl8Bj5zzH6fi9Edh49YBvnBWvIwC2gUDyoyHlEltRUIyyR/rioeQi05?=
 =?us-ascii?Q?6HzNG9xgVDKsgUFF/QUzlSjsCTjag+CL4WqDNg0j7JSxmVfPMAvZaw7VlKC4?=
 =?us-ascii?Q?r3sf7JEol9gR2/St/LSSKIzWa6kNVnYLtDZVjLaPpU2/LkAaf8DqyVLJGOM+?=
 =?us-ascii?Q?04UI/VoDaMzt4zNsvLBUvFTnYOtCdyIsChJit76+GEQrVGmbWa/3BMTfuyw5?=
 =?us-ascii?Q?BqqKCl7mCtptinPP7w0/BICKecr4BdbPIYW97YlUbskfzXfJRdzMYmLxfplP?=
 =?us-ascii?Q?5sA2vsHQ8yHUb7aYZFyP4/5rVQXnDXNfhwhK4W2rTCKAdy5s3Oe7qVSXmDeu?=
 =?us-ascii?Q?mD+N+BEq/DtVx+jhMlmGeg1SZsMBt0VGdO0qxciCz3Rs9FmEy9yAdTrKRiqM?=
 =?us-ascii?Q?FslhlEBfL5XEmBM/KsaEFLG1+mtspoW3kSIEcQRMiJo5qFoI1fDukuih0xY0?=
 =?us-ascii?Q?LskCtw67DH/FVpsMkzutxmw2ptlBTj5ynIVFU0PbGoA6jsR6JGjo5Ed+TeGV?=
 =?us-ascii?Q?c18/aeQnh0/um6QZFNBkVPXL0v3F9NQ1aLPeJtsLy2GFjGVZQR5eQ4PLesDJ?=
 =?us-ascii?Q?l2P+YDF3U5qGBk7Lla6OhL3Yu8CsMbJniT6u+66r/nI89vvDDppqC3goakyp?=
 =?us-ascii?Q?1hsIdighYpl+WM7LCC58PcsI6ylL/zn3KbIC/MNkPvVgMReG8fKBfdUYBg7V?=
 =?us-ascii?Q?74kLGDog4CDXQP/USeoUSW4de3lmpnVN9oBbkAzyJ+gY7LD9TThyLQWHyj89?=
 =?us-ascii?Q?5K26aA8quakaWYtT6lkq8+PI2C7V0gWFCHQ0xru+ELCFgQ//zbMvvNYi9HWb?=
 =?us-ascii?Q?iqZObvDo4u89gktRub1/yWYhpYKOzJm1ie1iKGkWsIvnWt4/rwTBrTFrKveP?=
 =?us-ascii?Q?GSMGqod04PQNYEOyxELXg1GtxJMwkd/ThYla1gDt4MNDPH73AwApyj7PFpKe?=
 =?us-ascii?Q?TFlLKHUBUYXQy2mpVbX41JQGFXQgeEDqRwhiDrardizGBQQFF+5tUNJEfgF3?=
 =?us-ascii?Q?xBYCtx2nmO3Hz3uptb2rEsPky4+8u9A5Jj9rWIfOoyhlk/sUGKJdBcKLmOIA?=
 =?us-ascii?Q?t/+93IoC5r1k7XFmPX7TPrraq32AKi2EwZaE3lsCD8y1Rr2iON1j5n9MQ+X6?=
 =?us-ascii?Q?amjY2KgdE6TLRZUKA9RwwE7gRLoRLpZIO/V/kV6+qlI4D/FycRiggVs/+Wkz?=
 =?us-ascii?Q?yb0c1+3Xo/Y7sePOM2cZupYwtLlYdkFRPfAsfPpSfzcjn8PiZL+sU3trYjfU?=
 =?us-ascii?Q?Av3tfnY9pAxOKEc8pp2cUlTvP9l33yHJVXOYA6INY0Fr9WwHAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:59:37.9605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858ccf46-6339-4ba9-c0a9-08dcf26f79f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Add the sysfs interface for vpe:
    vpe_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 53 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6d96e1f21e20..7df8ed6be2fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -377,6 +377,10 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = vpe_init_microcode(vpe);
 	if (ret)
 		goto out;
+
+	ret = amdgpu_vpe_sysfs_reset_mask_init(adev);
+	if (ret)
+		goto out;
 out:
 	return ret;
 }
@@ -389,6 +393,7 @@ static int vpe_sw_fini(struct amdgpu_ip_block *ip_block)
 	release_firmware(vpe->fw);
 	vpe->fw = NULL;
 
+	amdgpu_vpe_sysfs_reset_mask_fini(adev);
 	vpe_ring_fini(vpe);
 
 	amdgpu_bo_free_kernel(&adev->vpe.cmdbuf_obj,
@@ -865,6 +870,54 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->vpe.ring;
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset)
+		size |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	size = sysfs_emit_at(buf, 0, "%lu\n", size);
+	return size;
+}
+
+static DEVICE_ATTR(vpe_reset_mask, 0444,
+		   amdgpu_get_vpe_reset_mask, NULL);
+
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vpe.num_instances) {
+		r = device_create_file(adev->dev, &dev_attr_vpe_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vpe.num_instances)
+		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+}
+
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_VPE,
 	.align_mask = 0xf,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 231d86d0953e..015ba7aaf0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -86,6 +86,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev);
 
 #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
 #define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
-- 
2.25.1

