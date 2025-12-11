Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C214D41D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 20:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6C710E2AD;
	Thu, 11 Dec 2025 20:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkj3Mjkt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9871B10E2AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 20:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpT1MqUM2MsrJCoYk541/19XuJsQlDC0dRJY3mwd4miN/efEJfUK4TFO6iMUgVFeDa24n6O7gGKhGJt90uCHZs5LidhNn1nhDhXsNaS+KhZdU7ZhQw6gPn9tBeeFquE98szHOsr16IEwrDlB3XBp5tkfpaOEhXa11XJiBk0+Qkc6rZuZiLd4DKBGff3PMBHoGnYOTLrVQageCzU6tSDhe9S/q4PRNupaUvzCn52DoxDloluQE5n3+06oHCGDsMQ++E1z3HQIU84kF9g7uA5m7nr5E2Fb50ozD4yvmCQnkA3bWQs7iFX2LbEMeFqowuqCQdI36IDglo2oAgqrYdvv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW6/58QIAnsmXQCtg42rN/dHjp1AZAlhGwAdgm2rSx0=;
 b=SNBHq7JUmJO13oicXBheCqkIuit4fYTJD3XiYFg77kx6/L08HQxrErxZD9RL3l2Ucrj9gUjz0WTIUNLaGFyH4H8ZkGYTjsn1ag/8WAh2mk/zBrZC79k9TnQrmOQldmXV/KpJsphtl6eG4mBaDOflx2Ejpz3FVPz+sbkdme8WXYVs2QhgsrAocHFaJW1wcPfe5lp1hjvXdXGBAThdkvucJQTzD826y+GcLp3xeM7SuF/bMjyA1U9mc00NoLe00isjpB7CpjK2ic78J2IkuzShHfgnei7W5q0h8OIOhExxFADOHyC7oED1bddXORVAaQOjgjk2M+WMYqn68+aHcYhHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW6/58QIAnsmXQCtg42rN/dHjp1AZAlhGwAdgm2rSx0=;
 b=nkj3Mjkt9xqlQdB6/X+TG1TrJt4kaKzwG6hCd9AraVTnuXEiSa/BcgIo1AjY9A2pBke7SHsLYU7DTNYykY6SdBMZk0VnsF6xiElRpG2icda85Z23IFTdvcYWtN9ejTqol2txcOKA8cwxqw5mPFmxu1YjWuYPJ9dON51vccj5z/A=
Received: from CH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:32::18)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 20:16:52 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::f9) by CH0PR07CA0013.outlook.office365.com
 (2603:10b6:610:32::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Thu,
 11 Dec 2025 20:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Thu, 11 Dec 2025 20:16:51 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 14:16:50 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <mlimonci@amd.com>, <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Gjorgji Rosikopulos <grosikop@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Date: Thu, 11 Dec 2025 15:16:07 -0500
Message-ID: <20251211201631.1360423-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a3f84-e058-43f9-c658-08de38f2389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XwDLJc4Hv1pd2eucngRyFsVYAQL+c0MdLFet0Evbi6bOfSDO28VeszToxReG?=
 =?us-ascii?Q?R9BYTnokZ0xg6Uz81GYI/A1trdFkVOR5j/3huJiK3DyuRbELa2u9PtmSuVaQ?=
 =?us-ascii?Q?o/h+SXRW+CO4y2Nqm5WT+zd1gMkdeEroo6ZTVFG6Dlj3bjnb6pVqZTZIE+OX?=
 =?us-ascii?Q?JhSIPRJFOjJXzG3YfPH/iXVtdjSQVs3lrh4NCbN2ycsLB/NRx644hC1hlTUD?=
 =?us-ascii?Q?TBPhGHLWjwd3b6Yhxi3lmqv8ZWKDHWXbUnkaM1fj/7doxHqAB+2OVaGMSL6V?=
 =?us-ascii?Q?Q9wxg1Y3bVp9KxTpY0Xv8jackdQtzwojBRJdMmoXEhH7yAokwOwEnA5kDy+H?=
 =?us-ascii?Q?mMJ7fclR2eNWK6tMcAE+h71R2gyflmLTw+8Pa6UMD81u7NFypofC2Z4+1DLI?=
 =?us-ascii?Q?rKl4pUWtzStEuR709Kipat+tJ8e7OuYqE3vfyp+cCY/AsJ5bp4pYmBgItxOR?=
 =?us-ascii?Q?1KBqXrQybMc4ihptjD+iVrYE1DsBNeods1FDrgKQTe0QKZ0ZvazZysMj/yK3?=
 =?us-ascii?Q?Xv6QZnCH42R5TNJ+6OQWScPQ0NukzDs8G7Vx0EYa9h43W+WxaNX8E/3RBdVQ?=
 =?us-ascii?Q?B+PhlaS7R43ipWLlDfoswcTZ4hCjlO1j4/EfU7LHg5jTHsEOoPp2qPPvHBKL?=
 =?us-ascii?Q?3ey5wdwaPcA9CrwYRQwqOZZT10L6Rl4hPKDutTCf1jyXk6giCaKJFnOSMrJ+?=
 =?us-ascii?Q?nVjQb5vPhpDZGuAOesghzRoOmemdVClm03P027Z93KkG4dweBLW5wKDOQrfR?=
 =?us-ascii?Q?jWoKeaDVhGhb7zOaUNosAEfCgiKlsYo6EWSAs8u6vRXVE2zTJozlXZlT18xl?=
 =?us-ascii?Q?XEs2xdCW82Ft1dNKrVe9tXOv38m1bVygv98C5g35O7ZNuUjMO6VAOte2CrmG?=
 =?us-ascii?Q?lo6aHwdr2eyhlZ5TwQMNCAWo9v3gkWBLgXpzJd0qtPR3KKoBn8ZkhIREe1Lo?=
 =?us-ascii?Q?FCP6emMQ6Cdee5fPW8WqS5n+v+QhEEKiOC4DulRbashSQQKRGg5Md7Q3A5gj?=
 =?us-ascii?Q?Qs/1RD25/uvjLvGQZVjCbmUNBIYPabP0p/7d8fXt4JFNdOuno6WSQxjy/2g8?=
 =?us-ascii?Q?vmnc4fz15pgjR8KNrvVH86IyL/0ilob8gasM8LfFraSiff6rScu2nANWoMBi?=
 =?us-ascii?Q?0Tc2eFha4yD1/my7YE1vuPc8wba9Z1vBTU4oIuKuliSKyBo9eWbxcpd1uIZb?=
 =?us-ascii?Q?HhM/JlWZCQ1Jo53S+KFpk0+6hbThHrgtHFiwvA1x1Zgjmin2KgG0beD2cXDQ?=
 =?us-ascii?Q?moZt9CD7dfaM9Bb45+UrTzVXo5CGHBIXBL6CL6JYc4hWSF2+7avSenQfJYnP?=
 =?us-ascii?Q?a0O54qKrj336nkyz3qPDdYWnzg9kKb7et41l2OuNu9i8WTpE4ajlhKQwX7mJ?=
 =?us-ascii?Q?7iTBneJegO+492AHtTJFJPis0SjAMPGJVqyPv6MiN0j1vW3fClKE6SVMPO7C?=
 =?us-ascii?Q?j3jUXsRy3cq/Kzz8sNW9muS8mhQCTVM5hLaiCYtT0lxgMfezZ53vGIimb2gh?=
 =?us-ascii?Q?7WWPksuVITz7MFYGYKoAZHNWNQXGZ1nR86PCTiOr9DLLtuNMcYSfbgisBWRj?=
 =?us-ascii?Q?QYCZ/rshCHy3hvRpdXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 20:16:51.5688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a3f84-e058-43f9-c658-08de38f2389c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

Co-developed-by: Gjorgji Rosikopulos <grosikop@amd.com>
Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
Signed-off-by: Bin Du <bin.du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 41 +++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

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
index 4258d3e0b706..0002bcc6c4ec 100644
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
 
+	/* The devices will be managed by the pm ops from the parent */
+	dev_pm_syscore_device(dev, true);
+
 exit:
 	/* Continue to add */
 	return 0;
@@ -177,12 +181,47 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
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
+	return pm_runtime_force_suspend(dev);
+}
+
+static int isp_resume_device(struct device *dev, void *data)
+{
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
+	return r;
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
+	return r;
+}
+
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	const struct software_node *amd_camera_node, *isp4_node;
@@ -369,6 +408,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
 static const struct isp_funcs isp_v4_1_1_funcs = {
 	.hw_init = isp_v4_1_1_hw_init,
 	.hw_fini = isp_v4_1_1_hw_fini,
+	.hw_suspend = isp_v4_1_1_hw_suspend,
+	.hw_resume = isp_v4_1_1_hw_resume,
 };
 
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
-- 
2.43.0

