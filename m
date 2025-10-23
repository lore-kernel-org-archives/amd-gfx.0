Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A3CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C620610E92A;
	Thu, 23 Oct 2025 16:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/LJKZay";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E8410E92D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFXo2WrTb04co3ZtG/yrFKpE4Sgmk0a9CXfJbtblw5XfRo3eQs9Za+0QxgNoFIj8lIkb8Z9yacBp7iXXaMeU+IH5zSbQPoh63SXP89GN83eLZ9P/agn/oINkTL1WTNh/nxTZVCED1Jz715O12f5p/BjVhBdJ/+DixotJC7oXNTm+jm9chL2Q5RvSIjwfwmxBxoaTe2+Cwrhw8FqTyBLI+wd9zoErVEWesm1JQcZqq9Fbmf+AVgpK0XjCVJCSl+uxvMzDFdEjOSt5kODJx8itQcdpqhteXOgs1Um8rbbz7KTwQhgs0nMkKZ/GVr9hwkfgwWGjOxY5GoEFYsR+56ZbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SITSutzs4XeM3EbGLxcVDnD9jKKgIPdEjSxX4o4UJdw=;
 b=OJ+QTmzb5KbcL70yoZtk+Gti5GjyKDauqYpoSwcK3ZUdh1laLJtR7Vg9vYoMHjPpGCmBSjGXvdRI3AKyXtHDAXA2v+b7uLdocEMgUnJIQMy/i5zCgufoNxZGD0Xlm+Tap0MITJURYePvqhUIAaXsA5iNAW8Kke8tkLwKOBi2I3d6SOCfA86RbptNqLoHf31qR3rr3i9sDzd/XSnxbIKkjQtlvfPX6mZO14b43ozXuWmShRW/Wg/pPeq7cuqy6gM7jcMW46D9y48OJZBA2b6p6+bwz3BmZgFcnNDYD5qf8hCrALFpFjuKfV/GT1ahwiugJ6Nb96CVLbMtYgHlhey19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SITSutzs4XeM3EbGLxcVDnD9jKKgIPdEjSxX4o4UJdw=;
 b=T/LJKZayfKDAaNuWtJ2yN62lSlsARKpw5sNGoEHI7qT5KzntRzPFG0SiGKLqhpJ+x87yLonf7vh/mo5S9jJiDOdc+ncVDrn7UVJALOn2BjRB0wisD3hxcaGiaKu4J32iD8ME3LA1DX6vMOL8HJB7HmJCYqyHdj2G0cSB7mmRFog=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:16:36 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::4c) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 16:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 16:16:35 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:16:31 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amd: Unwind for failed device suspend
Date: Thu, 23 Oct 2025 11:16:18 -0500
Message-ID: <20251023161620.270811-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023161620.270811-1-mario.limonciello@amd.com>
References: <20251023161620.270811-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e818a2-5e41-4f11-9883-08de124f89f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?trgIIQv8KeCwzjLOR5YOdOW15410+hyf2pWnbL75kin32nUloicYdpSVUss7?=
 =?us-ascii?Q?1W2nqW1nxujMPgE/MdftAPctPjK95Jv3c8jcb0lC+L9ELCHVf+6AIZDOdz18?=
 =?us-ascii?Q?Gv6hiBm7M2IJKMJnNQGPmwAyYkByXWzWC8gEWfE47H2bKq5NBmWRCNoCJZGE?=
 =?us-ascii?Q?JV34RlJzb2H0fHtMFh16reAtp1lfzX2whgRkSpBdTczlqOEPqR9T+tEUMKKP?=
 =?us-ascii?Q?RZ1zFnsQTvXkY9K7tWJT5C8r35c1yCmZlaxdft+nZ2dmLiNn8IRORJLh61mF?=
 =?us-ascii?Q?ah1syAmG4h1rWFpbPYYuA15RawyUzMVCpVMqi0wsEeNdGUXV8+1PQJbKSYfC?=
 =?us-ascii?Q?I9AZuJKD9dqxZgYJZWliwa16SPGkBejE+9Iqfff1ZGbbaAqF8F6ZtNv/3gU2?=
 =?us-ascii?Q?pMYh41+J6MjergwXCUtymc4heJ+jVEthwjDFHP9m2IlbtF0TvTHwfOtZzDWY?=
 =?us-ascii?Q?O+iGv5DWTcEOAj8vRhyh6IfS9CeZBmyIzInc6rXSf5b/7AITUUGsuStIeneY?=
 =?us-ascii?Q?wgMjV3MUph9X4RhMv/ooieuT6NMHLbIFYwGLeZ/JR3f+I8a4hB43RW+r5xUA?=
 =?us-ascii?Q?S7hTize6Gt02Un205YMjiaMWDC1FbyA5x+a69coyzsXGmZnHSxnm44mhyhHQ?=
 =?us-ascii?Q?lOzXqF5YKDL8IWayRq8eCN4C7jJA6gW/JHlvqC4CVcBkH5qHzKPiUGqLsE8w?=
 =?us-ascii?Q?1ZCeWqMm+pv7Vooln6JGsvpv35SR7KG3YxvKnoZ4ka4dU7sCP6cjZvoNVIKH?=
 =?us-ascii?Q?I5kcTzWh2+pX96LgUy6RHHEvaODnntvVdd8OmHKlejMZRT/fnwg6bYTtERO2?=
 =?us-ascii?Q?VCibjMGgDDu+sBzgN7PZAgv+9dXd8jsFiOFMmZArrSnDlV4XLIQQ8LJNVcUu?=
 =?us-ascii?Q?hDm+AgJqNt0kFUkUuH6HJ+/0EvPolfLdhfy+mcnaBWCVGp4wb5+9R9PpZp6b?=
 =?us-ascii?Q?XbHcbZevnNITevZ4v0biwZm8H7AY4AUpOv59adw7mYVgJ/cYPus2jZudIXzw?=
 =?us-ascii?Q?Eif2yYYBe+MfKyisaRWCbE4HeGlbDBcBzKGeQscuLuzCbmJT863pLRUVoTqB?=
 =?us-ascii?Q?iaDV/RPXnW+hjNDI2cWWJeuhOLdBDTe2EBQJOgPHKudL0BDDGa86iFDRwJmF?=
 =?us-ascii?Q?jIKmnFLvofkvly9zfZUv5Tt2n/Ht+WiRVvPns6G/hwMwoxHcHi2G9O9SXU36?=
 =?us-ascii?Q?j5WbGUwv40/q76Ttw4BlqlAFaiAeMzO42jV176TMTmE5FuJJNDilPK5wVmie?=
 =?us-ascii?Q?cGRVFDAb/dCrshQflMVxdc0aNMMid5YO0gRVkKABf8RkAK2Op8AVhdRCZXKI?=
 =?us-ascii?Q?TeKGwLTB3biWMPL0MtZ45YMLn8DxlscIiYJVfTOMnzCfSCdQ/OeKCnzoOoPR?=
 =?us-ascii?Q?k0jgpHQg/gLG+k+SFrvFUN+K0cxDK6Qg5ZEcQJWURl0mQClcX0CxW0P9bw+f?=
 =?us-ascii?Q?UzScp3xYkJEJyBG7EUhRyH4/yQ+50oLida+3vmYNN8nrFezUY4on6WmckAn0?=
 =?us-ascii?Q?c8ymstKd3Vivtwhj+ZM4KYYL93/RIeSxYXYMa0UXKLrbI9eDBBaCKRkV5Hce?=
 =?us-ascii?Q?1LmC2qJmY/zBUeLCTVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:16:35.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e818a2-5e41-4f11-9883-08de124f89f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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

If device suspend has failed, add a recovery flow that will attempt
to unwind the suspend and get things back up and running.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ffb9bb1ec0b..fdb6cc09d7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5231,7 +5231,7 @@ void amdgpu_device_complete(struct drm_device *dev)
 int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r = 0;
+	int r, rec;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -5247,8 +5247,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
-	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
-		dev_warn(adev->dev, "smart shift update failed\n");
+	r = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
+	if (r)
+		goto unwind_sriov;
 
 	if (notify_clients)
 		drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5259,16 +5260,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		return r;
+		goto unwind_smartshift;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
 	if (r)
-		return r;
+		goto unwind_ip_phase1;
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto unwind_userq;
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -5276,14 +5277,14 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase2(adev);
 	if (r)
-		return r;
+		goto unwind_evict;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
 	r = amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
-		return r;
+		goto unwind_ip_phase2;
 
 	return 0;
 }
@@ -5312,6 +5313,69 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 
 	return 0;
+
+unwind_ip_phase2:
+	/* suspend phase 2 = resume phase 2 + resume phase 1 */
+	rec = amdgpu_device_ip_resume_phase2(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase2: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_device_fw_loading(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to reload firmwares: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_device_ip_resume_phase1(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
+		return r;
+	}
+
+unwind_evict:
+	if (adev->mman.buffer_funcs_ring->sched.ready)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_fence_driver_hw_init(adev);
+
+unwind_userq:
+	rec = amdgpu_userq_resume(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize user queues: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize kfd: %d\n", rec);
+		return r;
+	}
+
+unwind_ip_phase1:
+	/* suspend phase 1 = resume phase 3*/
+	rec = amdgpu_device_ip_resume_phase3(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
+		return r;
+	}
+
+unwind_smartshift:
+	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-update smart shift: %d\n", rec);
+		return r;
+	}
+
+unwind_sriov:
+	if (amdgpu_sriov_vf(adev)) {
+		rec = amdgpu_virt_request_full_gpu(adev, true);
+		if (rec) {
+			dev_warn(adev->dev, "failed to reinitialize sriov: %d\n", rec);
+			return r;
+		}
+	}
+
+	adev->in_suspend = false;
+
+	return r;
 }
 
 /**
-- 
2.51.1

