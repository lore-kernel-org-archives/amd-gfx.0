Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D5BD10F37
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 04:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A83410E241;
	Mon, 18 Nov 2024 04:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4SQnWF5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED21210E241
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 04:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfDLeNRO+fkkfvrRHLI8jN1rGQC14dt2DwH/BTZXe+XvTKO+Manho6z9h4I9ppQGZQLpu/FrsWcRT8OVPdcTtkuyaNrzFJ3YXXeNknanAwpOY3BTwBCueG5BiS2Pa/CQQGWmHscdQQTiYw6pxpcDqOft8OI/CU1t7jSGSQFeLxK6Kw3xdaiOBsHEDKdHsSSJhiFSuFtDu+XalVhF5l+UU3Ziq93sz/prKXfgbY0Iy2QVIzrYg3xIUqdYvby0Ztorxxum9fbEklD/LA+rputtyBRjxC465Fol66/s1qF47gcjiYS2et++MJLW4bf8xFa9g2B6xQu09ZtxwEFDjZO5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fbmLVVO04fReIa191BnCjfXTFC9Qgze/IJbtyMexd0=;
 b=n44MtNgsZnyIpmaSH4nosIJe4/g31LuTafSCGltO/1VfQ53YUWEuUG0OKPKmfg1f/idBwzfIx2qb4tSSB3jBlpdYr9bB6OUf/Am+HTAjr5+fhBBWUT7fFWasHcU58Je4ylRsu/K/HJUQZvOSvmIE6DnfMDmirKyhezxuU/YSTXrLsK4dovoAX8TWPXZ4o7KTXYzNZNcrjSM68bJTxcGZCagxcr/08J9V6+4TB3e3IzjD3u+BTYcsvjaIteqhDhZ7FMD45JFk7guypGnwADyz2c2kUqkebzSyuoeMgQ+28izkZXzkU8oRfC5mGYPdOwLgRczwSpk8yFj8K/iCKGzn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fbmLVVO04fReIa191BnCjfXTFC9Qgze/IJbtyMexd0=;
 b=q4SQnWF5MxdIe5/VdDNfcyQALVsbYwo4qbpVv9XmR/ACje6ysyroD2jwiPluovUrNCly8SwVDREYKiGZk0qS6fOZ7alr5FZeB0FF9n2dhcGiFowA+pPaq3y8ttgXw/O5rR0oYCfvC5JL3Q7ZcUXHpjakBTfwn5N8fVl6LW5tnGY=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 04:32:05 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::ee) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Mon,
 18 Nov 2024 04:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Mon, 18 Nov 2024 04:32:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 22:31:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 22:31:46 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 17 Nov 2024 22:31:44 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Andy Dong <andy.dong@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
Date: Mon, 18 Nov 2024 12:31:28 +0800
Message-ID: <20241118043128.3834919-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118043128.3834919-1-jesse.zhang@amd.com>
References: <20241118043128.3834919-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 9429b88b-26b9-4b40-72e8-08dd0789f46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xAVUgiKymZUBTpeCLL/9uXPocW1TUN82FXJDSu2ZaXMj16uJxWiChWhRurTu?=
 =?us-ascii?Q?4D/JUAUbkpO6kNEnB+yNsHka6PqWIYcidhOh+uPVVzFiUR1N1Spv2+2ZgWkX?=
 =?us-ascii?Q?/a+D3Hspfy1f3HDRrdDDTv2p0aDNBOQOl0U/XzhcNmcXoM5erp5Lo7nsVLK+?=
 =?us-ascii?Q?cnluj708Tyspmsl5CokEZCNaqrDad/MH33oX7bj5kmfzp/6uFDgKucHjAo4M?=
 =?us-ascii?Q?ITWu6bKWj1r+qFJkGqpasZGvPPbp0MtNEvIUVQe6uU5sTAfl9fSxQcPK6mp2?=
 =?us-ascii?Q?im+cXIE/EnExJsW6qzvGHgYY9JNTIOwbD+iVFCukMIH0WHWIfGzsbDVCE6Fw?=
 =?us-ascii?Q?Lj/n8TEvwtGj/BlFsqh6nCUlKRgcbKa7kMZTvt8WQdsnbD0+CkwejQQZHqO8?=
 =?us-ascii?Q?+kEkpKOFDIfC+UOVYx3QJjgCzRIk9559c7eV3L1gH58IBntLxS4T07dvDzhA?=
 =?us-ascii?Q?kdKlm8shodyP6T2rKBEicB+XvWQJl2lj1iCAUPrGb4a6eGWrY88UiEKVMcu3?=
 =?us-ascii?Q?LGC6jNZAwemPP4DA64bmFomOsu+iivXF9N+WwebHSrhUpkob6m/BI5Jqfp4G?=
 =?us-ascii?Q?eLwZ4uaENvvos5zSbTWFJV4O5QqyYrTkCBdGw2sMjs3hhm7THBLDDGAC36RG?=
 =?us-ascii?Q?if0lWGnYhg/WcvntjEOpndbESn95UlL50DsiH3SVkPe1Feb+1c1WqoqwuZCA?=
 =?us-ascii?Q?gw37x04mW+CVbgkfh7ExaVAjypXdcxB15SLpItagrySurTy/YGHgwaCzzMGa?=
 =?us-ascii?Q?+UoWfqGeboSlW87wYIl42g1YOCqM/cetkTdWvu/sb+e4TCJ5VQ9dzURXONbN?=
 =?us-ascii?Q?iu0WpzgYizJCfrHmiNvfbyU8xe531vfmAnm23POYe31FhwJN/IqW7hAlNQYX?=
 =?us-ascii?Q?PdZIc8H0q/eXXdvBzocKja2MZC65hPy50Cly8zfDwqwaB87IirEKZDlS5sRY?=
 =?us-ascii?Q?w6fvD1+pfceLOp32XOPvcQt3I4MktJTNi3JukDo6x7he5SvJL0wo116HJIEI?=
 =?us-ascii?Q?UtXK3Q0p/1/fKQAdIVJrMpfOAov6qDk5lAyytqnk8L+1/u3vGU1JgeY6w98E?=
 =?us-ascii?Q?gJgA3ZTDejIEA4JXjAkLO/BAC052A12R3FRVnKGs+S9amPNp+uAlU7xwSbQt?=
 =?us-ascii?Q?9HOwDT96iX6TzW/jOvIjmXBqEbSERMuYFrgXRFD+nlr8D5giVjfmr8GAs2zn?=
 =?us-ascii?Q?iE/6cxHVkJ0vCI7n08QBPMeAyknkGk3kHLuoKaPKQzYGNZYzNivXV2BS9FPv?=
 =?us-ascii?Q?xHltaKSc5QR80R4WKJk3sS7S5nQpKPWqPd2EozUeDUvuFnezfuS5e4ME6SZc?=
 =?us-ascii?Q?4K5mXX1m0KHGHYOSdW2fEBL5i4bENuJ2icN+AHWGvbXdpL3cHJELd1xw5k19?=
 =?us-ascii?Q?AJ/Y2MNy6hloc+ojwUmvDpckWBEaufjS+KOXMFDVpxA+WMwqJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 04:32:04.8293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429b88b-26b9-4b40-72e8-08dd0789f46b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

Replace the check drm_dev_enter with sysfs directory entry.
Because the dev->unplugged flag will also be set to true,
Only uninstall the driver by amdgpu_exit, not actually unplug the device.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reported-by: Andy Dong <andy.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
 7 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3c89c74d67e0..e54f42e3797e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	amdgpu_gfx_sysfs_xcp_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	if (adev->dev->kobj.sd) {
+		amdgpu_gfx_sysfs_xcp_fini(adev);
+		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+		amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	}
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 43ea76ebbad8..9a1a317d4fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->jpeg.num_jpeg_inst)
-		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->jpeg.num_jpeg_inst)
+			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index e8adfd0a570a..34b5e22b44e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+	if (adev->dev->kobj.sd)
+		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8c89b69edc20..113f0d242618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	if (adev->sdma.num_instances)
-		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->sdma.num_instances)
+			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 60e19052a1e2..ed9c795e7b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vcn.num_vcn_inst)
-		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->vcn.num_vcn_inst)
+			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 02bda187f982..dc96e81235df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vpe.num_instances)
-		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->vpe.num_instances)
+			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+	}
 }
 
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 483a441b46aa..621aeca53880 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
-
-	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
+	if (adev->dev->kobj.sd)
+		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
 
 }
 
-- 
2.25.1

