Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184A4C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F5D10EC75;
	Thu, 22 May 2025 10:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBseQ/0V";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F72010EC75
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9XwxIvvb4Rg3fPUMHvk5B3BuwYZtS3cuwMTts4WAqv6d/DCIbA6LH5l0NNcBd1fgWxZPLMhQ4Ab+uppuI/LzpL60lUiNblTToDFkSQWNCs6VhSNgbZ9tx1r/5IsQc8R0Sfj86VYGyybdyd1BPiW/jEbGj8gFlgEAE2q/tx6YX1nlK6koeN33YE2xf4ppvvRqQCM85lRDgOQgAbVHDt9oVC97Ot0kE8Yj9QZn5qZwAdk/kPEwztwokRE1bQeHDB2/cEmBp8xUdirA2bUL63dfYbf3IrFgAogwJi+Q5kUUx5Qh5X3cWlKtiJ8xHPJIehykaIG+n0h+taJMLUSr1yQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d15tWSpXxMJjeK4Oimtpj8+EEREgW8wJwmlZW/ceww=;
 b=skia42oBkGBkRSSI4F+AO0q5Pm877qxp7ZqMUCJ0G/+Jiu+Gy2ljSyEl/lrLWfLSvzrdcpvvvTQxlwwJiVSvwk+xEbXTqts9QKuz9jOXYGD+zhSR5cVQDAMBQbTk2a8ZinTdUgs0A3rjV/e/hMKA5D6MLJW0dXED71HhYYS5LvVpObDWXh8gOWLU3K1uOxUVq+yTABgbJ6hR4u48va8aa/vf/tgMxyL8W+YtgNdsCVaVWXrNYqjfP2TtyAWvKVl/AALqzHeuu3irJjEei4un4OoaVsq4CbquFJpEYPbe7pPTb/8aNAQIvk4zlUX+JIlPFU/a5uc3MzLI+eQ68WpwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d15tWSpXxMJjeK4Oimtpj8+EEREgW8wJwmlZW/ceww=;
 b=bBseQ/0VUMGKE/fo2rulik3rHMepagQRW8wM3ED/i18jKcf/DCLEcm0nbArlhjDzDGFOiY2VKJRZvXsvLVY0mitF1QUd0DF2rjR1TKaAPOn2XPDTjgjBN7LiCjyPX1FfOUtXig/38s1IhYtHsBZ2tSBP1P8BjEKdLlZuiSOLWck=
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 10:41:21 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::51) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Thu,
 22 May 2025 10:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:41:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:41:20 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:41:18 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v8 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Thu, 22 May 2025 18:40:48 +0800
Message-ID: <20250522104048.569456-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522104048.569456-1-guoqing.zhang@amd.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 078e7ff4-8248-4c38-6247-08dd991d3156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GoLJR2vPXyQGbYQ7Ia9sxHezQKLBHHmy7rs2F5StAaJuZur2lKJy8qEM/vzs?=
 =?us-ascii?Q?BzkAk7fMYjjxPpXAwdg6DtiKK5ThkYz2XwfSpMvwTfp/+h7Ms+Z78J/Y49+K?=
 =?us-ascii?Q?DDgd+q7PTkn/DhOv4WyvbWIN9eiKxXhY2lmwZ0tbV2LoYaqh0vRxAIIgCORl?=
 =?us-ascii?Q?5d5tivC5fChtd+LSyNO//gIqXzcHTlEhiAXYGBxrquuX0waMn6zKj0VFYja2?=
 =?us-ascii?Q?Ux7EqvU7NeuxxUO9REqVmYSFzzOM9xMYhX9ad9EYpnMNWUOAvpVjl59lwG3c?=
 =?us-ascii?Q?Fyy+CDfB7y2O7KV+sP/hRQrJfKEidKoE1nQKzsCT7sfpBrhg9sycPo3Q7gQj?=
 =?us-ascii?Q?zV3OrhuiaJpojfIK2y+/RTAHRh2WZVoR+/3cY+yYzmDU2KSKi98LgBfO06Nz?=
 =?us-ascii?Q?ScAVC6AHzuzauSe4ZKJ8CMBMh699mgtyVIr2a10BI+vLXhTpd0b4CHkT7x8a?=
 =?us-ascii?Q?kx7tKIUSpK+zJcDuBzfhOfZSQXhE40iQ0yQ+0OuHXwkUfj0nJ0pSR3ziTxQq?=
 =?us-ascii?Q?JQXF7CvWGPnrkVG9OoJQKQZEIfdDmPAx/OC4D1eNuOI9EBB/K8pZsHE8gSfX?=
 =?us-ascii?Q?yg1GrLdzHRgK/v+AxYFydK4WlhW00I42nYrbkhhh+v08o6pzQ2v+Iqha+lzX?=
 =?us-ascii?Q?VyOk0n6ZlM7XkoTOi9upITdGFXwfKdwS9Haj5scWuYaxzjn2yjnDrNdMnRSx?=
 =?us-ascii?Q?hhSvGoS5+HBLPQY9sGOABqkonTbzGc4wPYCvCwNQWFoKJyaF3XGAgdItBxVR?=
 =?us-ascii?Q?JiGWn3lgBTUJqV2vLuDPjH3RKJKn8AEDUqHvI2DmLW/nM9pXGWchTYCQbuvu?=
 =?us-ascii?Q?PHrS4J6XgCRmRW4nlLTWYNLhgDH6+hxPI34nVeKD1tjmZnshpHpYy60G57RX?=
 =?us-ascii?Q?KFOZAZaBplOx+r9vTRPzoAiK7MPaKNKMFPHQLYxNXOPdBvMXaPG10df4CmJk?=
 =?us-ascii?Q?Qr12Q2Py7ejnr8DkPnQrTSqSdPM+K1Td58tgvIVrjkhITMaIlYeyeV9c1OAC?=
 =?us-ascii?Q?kTw9yuDfTBmNPkcSR61vw5ypgAqHhZ73zg1qrP/Q/tfuSQz1nW/xyWRLkyKx?=
 =?us-ascii?Q?sqQwVN/4osZ2QUuVE8b64GHTtwRcM5psRRb44Ad2XOP9+vaM69HMGsckQKlA?=
 =?us-ascii?Q?E5wHldQFnt/2jhfSHa2jtJ6rYZA3rLowWI+DZInjb4dsygrjyDOph4RmZDSV?=
 =?us-ascii?Q?xC2rqJ8bMcYPbuWFkmJ6uYhXA26nc1xsrZitBEtGX9BeSD+YLf3jw1oer0+t?=
 =?us-ascii?Q?G60EoxBVBJlo1o0dcdg81lk/cvMDtjbo7NBOZzG950Xb9r04toKYAEWsE48j?=
 =?us-ascii?Q?7mJGjOTRzD5GYpERDJj+GCzGTboRq8uNn1jV15KI/IxUpra6/ZKM93EcLPVI?=
 =?us-ascii?Q?DizA9GS/EIuovhm+ebo8smtH/mpZE8qZtnXIJL2zdraav4NC2KrpiV3H2d2o?=
 =?us-ascii?Q?hNGXpajXCrI6dNrKdIKIijvDaZVTWa096+hUlasr1PlxuUTHsGggSq52VF4I?=
 =?us-ascii?Q?tQWGVAzl1qlUWG4AtITZnzDRJZv92Vv9WzU+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:41:21.6065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078e7ff4-8248-4c38-6247-08dd991d3156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

IH is not working after switching a new gpu index for the first time.

The msix table in virtual machine is faked. The real msix table will be
programmed by QEMU when guest enable/disable msix interrupt. But QEMU
accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
by nBIF protection if the VF isn't in exclusive access at that time.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0246a33b90af..82dba152101b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,6 +5051,13 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	int r;
 	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 
+	/* The msix table in VM is faked. The real msix table will be
+	 * programmed by QEMU when guest enable/disable msix interrupt. But QEMU
+	 * accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
+	 * by nBIF protection if the VF isn't in exclusive access at that time.
+	 */
+	amdgpu_restore_msix(adev);
+
 	r = adev->gfxhub.funcs->get_xgmi_info(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
-- 
2.43.5

