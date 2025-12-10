Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A96D3B9B7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 01:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F50510E234;
	Wed, 10 Dec 2025 01:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zjVWUiqr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479010E234
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 01:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6Thf1GgwsXrk7Zr+6JVG4bN1FmMwybS3zHJiTxlYh359y8apd6AX2GSmY+sphPOp2fNX/tBfSnroouA96BYn8vb4iCUkZVn7G4E8CFthNFg2uAsKAVodibMACideII6KE2RGYzsNbTDCQK1LDqENnx5Lc71z7oLh/T95DDoAJPDXDkS4CAc02uWFwadkTmGWmi2FJv9r8d+/2v03aRIdPBAo3OVWoIZC3zrajxMrw2IgSs9YdNbui5h0RAKNuw088w3HNqCab+AIK6mz0cAuV+yG/B7nJ2vqNEql7T21lLioztvMqq+gDaLwCvM1NtAhmWigcK+o8JUvcyJ+hltoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXWrHVTcad7Hg6igR8NNMkVDsFXi+LsbsOLAwB0zwfQ=;
 b=FYcVkj1g+zGh2MWMWK7vO2cAcFTuWM4UsXdnq5C9Zpe781BpU5inbw//GFSddZk73x8wMp29zlkR4W9y8W/p4MNJfM9cz5fBOJefkxulyVQebAE/37Ir6ksV6PldtQ9hnYmhAHlolX6qE8Q2EwLXjNlmwe+2wsupNhXCzpWtLOU+w8h9dEl2Qo9n3dySnsDWZ9muZLG6+o/6uy4guMsESwbzsIhKECz0N/g95RNM6ZTXmT95EcOESBtnaC03J+Nbm5Up9JkxINGs3XFS+8v3wbazuASweFXMppguEPG53xUIRN15C/ouqhMiVnT7/N+FSzeyOI5mYPDfWK3j7j7HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXWrHVTcad7Hg6igR8NNMkVDsFXi+LsbsOLAwB0zwfQ=;
 b=zjVWUiqrVJ6HtcNRoD7K6mDUJUKsdZR7o6M30nGI5PL3Ky7OVP54HAQZ++nDcVZDXZoNdc64cqwJSMml1gaqWxhTh+V7K+5+lmXNg1b3mImnwEpZKkVOlSOWDIk5iVuQL0OWDe5BRQzFquC59qTPz78y8j1KlrTUlI8e7tdVZBU=
Received: from BN9PR03CA0121.namprd03.prod.outlook.com (2603:10b6:408:fe::6)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 01:51:59 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::b4) by BN9PR03CA0121.outlook.office365.com
 (2603:10b6:408:fe::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 01:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 01:51:58 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 19:51:58 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Gjorgji Rosikopulos <grosikop@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Date: Tue, 9 Dec 2025 20:50:26 -0500
Message-ID: <20251210015140.568540-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b457c2-58bf-4b61-a916-08de378eb4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vjX7WMDDtbusgGkq3YoZP+xrj8QFEyHajnWoAMY4s2BVZRYJhbMapX2o9l9?=
 =?us-ascii?Q?IsoiBtBVTptmsNDr3Z8qotES6ybLp+tVOYmz9Wm327cQy919geVCO2MOM7PX?=
 =?us-ascii?Q?t/5buNtbSMz/RMP3lqoqUhhX8khcL2aXV0agPJ4+B4n3mzo1PGgs6jvOZ2mo?=
 =?us-ascii?Q?yXhzSFiJzDNjWoRgN76HdvVdsIWEQ4dDKbKT+JGBENU04stTYAQcpBfRQMPM?=
 =?us-ascii?Q?UuhtVazZf3lsGnJCR/ySaNPKSVsiZAIU9b1HBNI4RemDCfU4mAZK3LKHRanL?=
 =?us-ascii?Q?K0cSGbOFx/vUStp7k/uSTsy2peml2vvYjGVcdoQPzTwZmf1gLPXIkUKvSSMX?=
 =?us-ascii?Q?mOB2UtND+Z78A8GWoMzWZm4gFFiiHlB4qSvuzwc0ychtWBBAAaEkQg/Ngi5o?=
 =?us-ascii?Q?BdLvcf84pvByYmYD1JMIySWL7HEnD5B+owWjJrrr501eDhCgUUDtkuD+loNH?=
 =?us-ascii?Q?4/Uiksw3t2vujoAt5k83UXfoinzj2sTDQXwB9Wbu9X9LA6xnJxL3Ae/ASVph?=
 =?us-ascii?Q?ctT9I6w7F3NjHiaLEamdBjPtMMpYKhu7gTKgWYszUemLnFVmGolI6B4r28rE?=
 =?us-ascii?Q?TQrqkCWrFvyeo8IZDFobYjmdmZBs3glGwVR0jyE8a0OXDqbgOBj7jiQr7/VR?=
 =?us-ascii?Q?QEJw4q0OFLQyP01QqcQg39SknAuSKocR3ZT56qapAxAYtXtpZFy9VNwQLi76?=
 =?us-ascii?Q?b6dQGD4Pnlyqp/CTEbyPNDW3gsUrvmmE40W8H1BwGUiJLRdgS6R+RKTuflKF?=
 =?us-ascii?Q?BYjl2j80gXH/yScgryS5gBEBySgvZh7OeNE7e0EPrfKFQbyd57RdUAT5hO8h?=
 =?us-ascii?Q?a7RIMkoJQzjGeLc3/IrbRYDMX92aEDEHZIiPmJc+XFAyo/2V1L3KS+Grg/kT?=
 =?us-ascii?Q?yAMl8sajpCDEYYIcsoCUxHFxd9gJiRO2Kp0w5/sIBVSbR7AAkskmI4SQjtl+?=
 =?us-ascii?Q?Lx6gl9ZYsWa+K/X4+3ZhBmk+9nLgYX6vTsYQh4XQs4P0LARiG8REV58I8aHq?=
 =?us-ascii?Q?TrLGvlHXCTZmJdQloCKc1BQlPLIHFLCUZnNoVNrfTP7GMzPHWWOHn+o8vGyQ?=
 =?us-ascii?Q?CjKYIajzLhi5DGFFs6dEeem438g4nK5exQGNbb4kWPwlaGnVX+TcR+M9Ujrc?=
 =?us-ascii?Q?unyBZ9wJvuEEimNW4+ju+4YXbIdWkLChgjqbGz64A+L9IlGHMG4AJYMrlf+g?=
 =?us-ascii?Q?GXLERB0GDn+YS4M0DDQO4Nbk7WzOV6UkkdXW0oo+RwAnmBOJSLPYb8GqJOhf?=
 =?us-ascii?Q?20sLiQlhnW25nrDJOe946BWcFKthh0bsMWwRyd57sU3RpsqkA0hpsnG5xxK5?=
 =?us-ascii?Q?H7OQdgWkM/vEd3zNRteQd23ivpqbuJvV6kwpmMLZCQP9Ms8xGHRtyXbyg36o?=
 =?us-ascii?Q?sSU9PSN5jp+pxENvvUPJEYM3y4H5toop/KP9nvueUQa6uUfD32nuWrninmPG?=
 =?us-ascii?Q?CODGmggk+a+I4Iew5URQdVwsTjgTLDP5CgXRsSoshMmzluuG5Ykk0TUypwk/?=
 =?us-ascii?Q?G4J8lfqGn3sbYnOHmVS7+cx2fwC2PfvlR7i5iIGLCLQLz13ycrxE/dem5XTd?=
 =?us-ascii?Q?lD1EIuVyEdhzWVXoGnA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 01:51:58.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b457c2-58bf-4b61-a916-08de378eb4a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

ISP mfd child devices are using genpd and the system suspend-resume
operations between genpd and amdgpu parent device which uses only
runtime suspend-resume are not in sync.

Linux power manager during suspend-resume resuming the genpd devices
earlier than the amdgpu parent device. This is resulting in the below
warning as SMU is in suspended state when genpd attempts to resume ISP.

WARNING: CPU: 13 PID: 5435 at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398 smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]

To fix this warning isp suspend-resume is handled as part of amdgpu
parent device suspend-resume instead of genpd sequence. Each ISP MFD
child device is marked as dev_pm_syscore_device to skip genpd
suspend-resume and use pm_runtime_force api's to suspend-resume
the devices when callbacks from amdgpu are received.

Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
Signed-off-by: Bin Du <bin.du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 37270c4dab8d..532f83d783d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
 }
 EXPORT_SYMBOL(isp_kernel_buffer_free);
 
+static int isp_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_isp *isp = &adev->isp;
+
+	if (isp->funcs->hw_resume)
+		return isp->funcs->hw_resume(isp);
+
+	return -ENODEV;
+}
+
+static int isp_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_isp *isp = &adev->isp;
+
+	if (isp->funcs->hw_suspend)
+		return isp->funcs->hw_suspend(isp);
+
+	return -ENODEV;
+}
+
 static const struct amd_ip_funcs isp_ip_funcs = {
 	.name = "isp_ip",
 	.early_init = isp_early_init,
 	.hw_init = isp_hw_init,
 	.hw_fini = isp_hw_fini,
 	.is_idle = isp_is_idle,
+	.suspend = isp_suspend,
+	.resume = isp_resume,
 	.set_clockgating_state = isp_set_clockgating_state,
 	.set_powergating_state = isp_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index d6f4ffa4c97c..9a5d2b1dff9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -38,6 +38,8 @@ struct amdgpu_isp;
 struct isp_funcs {
 	int (*hw_init)(struct amdgpu_isp *isp);
 	int (*hw_fini)(struct amdgpu_isp *isp);
+	int (*hw_suspend)(struct amdgpu_isp *isp);
+	int (*hw_resume)(struct amdgpu_isp *isp);
 };
 
 struct amdgpu_isp {
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 4258d3e0b706..560c398e14fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/gpio/machine.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
@@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 		return -ENODEV;
 	}
 
+	/* The devcies will be managed by the pm ops from the parent */
+	dev_pm_syscore_device(dev, true);
+
 exit:
 	/* Continue to add */
 	return 0;
@@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
 		return -ENODEV;
 	}
+	dev_pm_syscore_device(dev, false);
 
 exit:
 	/* Continue to remove */
 	return 0;
 }
 
+static int isp_suspend_device(struct device *dev, void *data)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+
+	if (!dev->type || !dev->type->name)
+		return 0;
+	if (strncmp(dev->type->name, "mfd_device", 10))
+		return 0;
+	if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
+		return 0;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int isp_resume_device(struct device *dev, void *data)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+
+	if (!dev->type || !dev->type->name)
+		return 0;
+	if (strncmp(dev->type->name, "mfd_device", 10))
+		return 0;
+	if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
+		return 0;
+
+	return pm_runtime_force_resume(dev);
+}
+
+static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
+{
+	int r;
+
+	r = device_for_each_child(isp->parent, NULL,
+				  isp_suspend_device);
+	if (r)
+		dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
+
+	return 0;
+}
+
+static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
+{
+	int r;
+
+	r = device_for_each_child(isp->parent, NULL,
+				  isp_resume_device);
+	if (r)
+		dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
+
+	return 0;
+}
+
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	const struct software_node *amd_camera_node, *isp4_node;
@@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
 static const struct isp_funcs isp_v4_1_1_funcs = {
 	.hw_init = isp_v4_1_1_hw_init,
 	.hw_fini = isp_v4_1_1_hw_fini,
+	.hw_suspend = isp_v4_1_1_hw_suspend,
+	.hw_resume = isp_v4_1_1_hw_resume,
 };
 
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
-- 
2.43.0

