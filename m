Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4912CCCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 20:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41E410E8F1;
	Wed, 15 Oct 2025 20:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCtzh4Bo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9353410E8F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 20:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iag3hvYWdSMAPMhhxfgOuTgxXPNOHjP5/PbGs1jrZYgLH94wTIulbHTFfy2l2NmYJuBpZ+31WTaK8kG/OYDVm+4TICn8gFYTQVPp7Pi57GbCRhfwivIbddbNmjYQQwBT9zykXoH86hkKZe2YwewjilVFm8YkP7g9aRfL0d3i6SfcuLUjoX5nitXNS7HBdUSlb1zNp5c/LWd9o3K1qs1IPdxXAateXW3xtT2DaS25FaZTkAJsIEPtZuavtXiamlrzjs6unrCZnrBPB/8oikYmHoaipT3K7URj5u15kNF1MbQbsmu01pkOrMIcbWBci1SssMXbnvJ1pSPvE/A5TPPAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/FcQg/mWJngd+DCFBmeT5jcIJylfZrDfV/+VZoVNNs=;
 b=x/oKO86eX6hAzQvb9FiVxclC+9ZxKbxB49Is0e8AtWZJJ7Ry51LukW2SZEfweFpA9XvoJ3PHKwQiJscu01a/Rv9l0rdfaFYlA48fGjUUlOpUot7sbX1l0qfMPRlkvoGiSe8gd0iZGRUJGH2/BsjB8NMdGN7bnNh2PWxWsVq8cE02Uopd72cqLDNF6WqAmXRez1onFU1TxFeOyrmYX3cUMaCiCzJAOJMpwTFRb2t3WqrOqaU7XXRUMAUIsq+5+4/QnX+NzEHyFefmpNBitKTcG4oESb7iQMYOidcuZzWRL+uyg3YmG+7bOXGI2RNyVlNbOWoMFcPD2CiK8b8xg5B3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/FcQg/mWJngd+DCFBmeT5jcIJylfZrDfV/+VZoVNNs=;
 b=iCtzh4Bopjr+jeLgglLxL9SUxAJgzuVFK3QfD+cIepsG5wCYHtZ+bGrR7jSj5ZkXzLxRIf3uXF34JYagnd1yn8HELBtyVMjUSEro8znuenO+e4nN7rok4/jYbRt9RbJP61wQjuLEP3vPUv+T6eyM9/PHfxlLaFFxOtgkN1nGoeA=
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 15 Oct
 2025 20:49:46 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::d3) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.4 via Frontend Transport; Wed,
 15 Oct 2025 20:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 20:49:45 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 13:49:45 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Resume the device on suspend failures
Date: Wed, 15 Oct 2025 15:49:20 -0500
Message-ID: <20251015204920.1305839-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 424619c6-3b63-45dd-90a9-08de0c2c5fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lf0I3NJinrS4o0Xtd0qoB5wcCaw5f3ADJU9cTHjoYtS+1pduOuv3aPPflXGO?=
 =?us-ascii?Q?9pGhyGEgO8cgaEzqUhlRUJTkYk6tDvemPGXppSlS8ePhdF0e6loDXMwxuf1/?=
 =?us-ascii?Q?H7DgYzDZilf+QrTqfApkc8eRtyKWbqQcyDx9ahSPO+bns5Hk1Op7tGp/mrn9?=
 =?us-ascii?Q?65z/sUjfJfLo5VA6jfGY1zCFCPpzj6q31iJ4LP7cRNvVqtEUedpi26jDiti9?=
 =?us-ascii?Q?gZLymu1LEPI8dk0p/erl8k9YJbFtSdoCIRTcLSc+rmJGS8VJVON3gqWYlJ9L?=
 =?us-ascii?Q?+10xKI1abVgKjaW8OA1H9CmVyqT9dJ4NoA58dcYlqiVaPeOtdPdKZ1x6rxzG?=
 =?us-ascii?Q?gQnjxgs2LY5wqhC3y9RqXe9Y8RfADyti81QJwu8s/U8Vey2cu7zTrKdfo0pU?=
 =?us-ascii?Q?Wvugj9GD8Arb53Fl689O96Tv3e4bkCRN0lBSAAh/neYu173vKUW+GadP0ZNx?=
 =?us-ascii?Q?NvkuEmJAYnPHfdlzBaaxrdBf6XcWZHNPr9+w2KDhqTkUC8z37ejw6LeDQI2c?=
 =?us-ascii?Q?hJ/f8QIHIOeC5X+iko4EJghQ2UC8yUNCQMkcinyelgRzrpv1QOpkHYq10jdG?=
 =?us-ascii?Q?oLQOsI9SzE4ZC5k5GejQmcdNuh+a9+qAiKqZ1v6n8A14zkm3tReBFY3VKOsD?=
 =?us-ascii?Q?YUbRnoHa+gQjzz14rT/Qzp85cY9ui/318HSh3q454Yukqf2/m3QcOu5kwqiH?=
 =?us-ascii?Q?jfIGAnUkEaMKT82o8qNmwGpRVLyhrnbC1ftfixXRjyWoIcVqTiOhfn9tAQgJ?=
 =?us-ascii?Q?bruOASP2AmbxXI75IgXBnxwXCqKQdUPIqpOXEYwT5YHCITB1WmlYQe3EvOkz?=
 =?us-ascii?Q?+j9eL0QynxMU5iHrHAgQtEfBtK2rEgfoI/Li8aTYawJO7buwYvxnuonjI1Gh?=
 =?us-ascii?Q?s5MAkMi/qDHNAFN3CFyxV2nAqgKC48DHx4a0Jz/KoxIQmVwiCU5lqzAzP1kp?=
 =?us-ascii?Q?llg8ycmMOctNaqrN1trGyHqpmItQQSBLY8h2dcu4f0yT6KU8cxbPrndxXQvK?=
 =?us-ascii?Q?R8X8woRjE4ol1XUZarqkPBrl+VnfRntZ5stqHoZW6XcYjJ63m2K5K/NyuX2V?=
 =?us-ascii?Q?yNbFtgUDsmvhF3+LjINDYO5sv3kwxu3dDo9VQqnus9s4GNs8XtxfnrNDVxIx?=
 =?us-ascii?Q?+GkYPt+aFcslgWb/aj/qight7gzb/PdcKte5KNRnBx87IbzcJBZHR9t9gDOH?=
 =?us-ascii?Q?AyyU9RcyK0Rz4Y9nEy3I4iXsZu4psYZZ+HPOzP6DrD0GgFL6v+yT/5NeDMgE?=
 =?us-ascii?Q?CqtVFJGLNKNO2vYNww8EwrPfHtPAx5PoJHCL9zE89NjUZp/c0Nz1NmPYeMV9?=
 =?us-ascii?Q?+Gtl3eBSvnl7CZ26A3FAIL5wFAbAlCcO/4l4mjvk7T5qMe8C3cZwmzBIoeLQ?=
 =?us-ascii?Q?o9Jd/ZlkWWxwEgD+7ABhbKalLIClag+6NKB1bOuvMVkWdCPb7tpfLXDqJ4CE?=
 =?us-ascii?Q?34YWoXNVzfif8b7jnRcxHlJQWZOZaQXFWNrkmJ1p1pHwEp0UQeORkMHyCYtZ?=
 =?us-ascii?Q?8zkQQ8+PpikiXrc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:49:45.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424619c6-3b63-45dd-90a9-08de0c2c5fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
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

If the GPU fails to suspend the return code is passed up to the caller
but it's left in an inconsistent state.  This could lead to hangs
if userspace tries to access it.

Instead of leaving it in this state, attempt to resume using
amdgpu_device_resume().  IP resume functions check the HW status
and thus should only resume the IP that got suspended if a failure
happened part way through.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a99185ed0642..59672b880d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5227,7 +5227,7 @@ void amdgpu_device_complete(struct drm_device *dev)
 int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r = 0;
+	int r, rec;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -5240,7 +5240,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
 		if (r)
-			return r;
+			goto resume;
 	}
 
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
@@ -5255,16 +5255,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		return r;
+		goto resume;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
 	if (r)
-		return r;
+		goto resume;
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto resume;
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -5272,16 +5272,22 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase2(adev);
 	if (r)
-		return r;
+		goto resume;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
 	r = amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
-		return r;
+		goto resume;
 
 	return 0;
+resume:
+	rec = amdgpu_device_resume(dev, notify_clients);
+	if (rec)
+		dev_err(adev->dev, "amdgpu_device_resume failed: %d\n", rec);
+
+	return r;
 }
 
 static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
-- 
2.51.0

