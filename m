Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC7C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBFD10E4A3;
	Mon, 10 Feb 2025 07:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dNSANZ4S";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8522910E4A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDDInZcdYpipIpn/5uSRLxWmpgTL7+IYPeNWdLj3PPvz12Ls85gnEp5L1mMwHTQ3oYiY/n7zznWzHiUCX0SNekAkEroHPdsew6N/J6KGCjYNaNR23CR7OM/lLGMt2z3vH95lG6VVvrR8gEbxoy1tQe5NtOjjxwuqLn4DRyu2XS8CJQ7qeaOzLUl0v3dZIOFoAcsem3xXiAv1KIhJR8Ivtc01laHuDRaqtDX4ZjCw+dT/BxFudnXLSaMNA+naVldkXVWet3jsY8mrjQujZmZVP+mXQvbW+/465gI2bnxAhNOOpokP76aOp3HisHnj88zx3tV5IGLJGQfF7WEsTZH7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElPk17vOTi+h9gca4VIaF7+qUjZOT+BBWd5jJSCW+p4=;
 b=eCCtprZZvb7UX1y105bBMwW16XQzOJbPs5CKK3byuXbNS12P7xJBSD9xZUZpOTZAZ7Vau26OgkMtKAYgLPxzgLF0P5Hi3oAHEbjCJqe5/PQn3ChC1kiufZyB0SO+PrWQeS2sghMg13USJrCmZd4WiK7bnVLYaJ7k4DuSQN6OEaVBS59ND0wjiqpAaphfbBUXDqH/To/elD2Bm92Uvt2K6ufLXJmOTVm7+I16XS9wGt+wpdft/5f4X8783oP/QualqRG1DyouXp1KsYM2QxhX0JfGCyKffJzE84GeT5FQnF9opWqirp0bWDl/mlnwWHbFaRgh/VVO6sy2kXJEPJH5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElPk17vOTi+h9gca4VIaF7+qUjZOT+BBWd5jJSCW+p4=;
 b=dNSANZ4Sr3Dv20pxbp4bg4ULw0HM0x15es5iKlRQUMw1hu/bQEQBq8o1zt27rIz6xtpAEn7xenvfoTPHwx51VkaiXF7L13xf+5wFcsfYedl7CaVWmSiqoaVsijl2PY1XOPdZkZEQENAfDXBT1fnc1ia0VD/pSFDilFD6J4PeptQ=
Received: from BN8PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:70::23)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 07:00:53 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::b4) by BN8PR04CA0010.outlook.office365.com
 (2603:10b6:408:70::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:00:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:00:51 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add xgmi speed/width related info
Date: Mon, 10 Feb 2025 12:30:32 +0530
Message-ID: <20250210070034.1998011-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210070034.1998011-1-lijo.lazar@amd.com>
References: <20250210070034.1998011-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6b80eb-b93a-4d67-2b0d-08dd49a0a8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLKz+MOSqnFnoP2kHYcOMhbU4zP2/z5wZ1ArIx1hviLz3SVbf9n+Z6LkVHyj?=
 =?us-ascii?Q?14ww3Hd55p4L1t+lJQnFpVNVSUSC7JnxkuzFoP8oh9YXZQbk1qXz6kEfVB75?=
 =?us-ascii?Q?hzzhiRuzVqjJ6sIutztluyEP78UXfDMzGFZH+jGRYxrp2DRtfjUkAcKJ8RMr?=
 =?us-ascii?Q?auT4LfVNeSo3yOkXx4RQVHTtU8oJYdBGJ8WGWFM1Pe4n6j+CISiZCyG0KCDq?=
 =?us-ascii?Q?k3KCgddK5zYphOrrc1GB1AglPop23Mb/H89GUuL2AyUAohpK0xYgXyMsAYz5?=
 =?us-ascii?Q?gFZ01OXLaU54GSTbKiQ3xLKYZ+HTFCXXfIchbloL6yt8KRaMuEbOc389acSB?=
 =?us-ascii?Q?NnEoc3vsBIF769Kz8JTVcWJSaYJmjVuEU4lJz1WEnQEenFl5GZdFOYmUEAPK?=
 =?us-ascii?Q?/bRtAssnSC/T92f4SazlCRgqu+9EBaPzDZnqg2/9vmXvYyl5Sa1kfsLcs1kC?=
 =?us-ascii?Q?skSyUWkd3cK9wR5EsZANUoQHOvxAv6Wh8Zl2X6P0l6+5xzrWbrwL2oGQcwH2?=
 =?us-ascii?Q?+Sb0aAXVbHdJQ/EI3a1ptm0bsuENlUbH1CB5/40fWHTyMUnG7sFlRRxZNCXs?=
 =?us-ascii?Q?oNSJRCy0jl5LeCdVblEvp7oZWIhgQOO9O9FyfyCUjUwIyP6mppIxQmY/8m9/?=
 =?us-ascii?Q?v9VvegtEGLcF57ZSgvFIdC0EOawslz8yn9DQj7mWVMLCiI5G6vU2D5U9d1ta?=
 =?us-ascii?Q?LoIH0FpEd6/kOKFXG84WzR980jCRdTJS0zku0gbha0QWCKp+6OkvkCWAsyU/?=
 =?us-ascii?Q?W1NtqzHgEzcDSBBumJq9nKkVzFYUa5pP5LQ3vWBL5mtVvTxPP5qp7GtpCPbM?=
 =?us-ascii?Q?64V7FulOWZpZIGe2hLZVd7WezUdNQxKsjiRdLdbh1Qgg9k4fQBPHMJlQqfdR?=
 =?us-ascii?Q?q25BTD2ipotBisyYChOyD6TvEFIon+m9uusbzWMgij2Jjd+Ih1i8xxgKQk3G?=
 =?us-ascii?Q?vn8rSnXQsAcNlRu7nqqxk4xrbUDOcNKpC9WXKohK4wqzjJon0fi77eUghMPN?=
 =?us-ascii?Q?vs225IRJIB7ngHfIm+dd2vdpxSzTLst251rIHIYVb0eBSmwHcN5noy88XIdv?=
 =?us-ascii?Q?eCapcbmoQR6ZTw1AvRPUny0OD7zAqWHUFLeAhVNSvp4tR9/+tmIY7Camo6jy?=
 =?us-ascii?Q?kAKEhqv4bnAgKs+TB1ScVR3En+Y4QSGBA2+4K0kzUuNdF/PcQCq6/mlOWU2s?=
 =?us-ascii?Q?7JFsQdd8libYpPTWyazrLKFQsMbSByDO2AiFdOd8azQrlml13+XqrVZ7wzED?=
 =?us-ascii?Q?dPMJRyColG55qcftseONEyhNjvwc1AxnXMk0vko/YHOtcA55KzrJvQTBfFUT?=
 =?us-ascii?Q?g/DhXPY5O0DxHcTkg5dhv3tsxAxGsuVNbVC28Gcb+AXafDv/IAZZLEBQMlJU?=
 =?us-ascii?Q?2Pd/TDGw1GgATPi6XzkcPGsk4sYhiNRDfcBuqFErmA8dbP18jtVQMLVpwYDw?=
 =?us-ascii?Q?6KBHdX1vIRDwKnX8rm4Gq6HO9qIbGUsnUFJukOA9pzkCufe50864h5YzOBY/?=
 =?us-ascii?Q?4u7C/rJngMvWnHQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:00:53.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b80eb-b93a-4d67-2b0d-08dd49a0a8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

Add APIs to initialize XGMI speed, width details and get to max
bandwidth supported. It is assumed that a device only supports same
generation of XGMI links with uniform width.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Use GC versions as XGMI version is not populated for all SOCs (Hawking)
	Rename xgmi_init_info to early_init
	Denote speeds in MT instead of GT, rename enums accordingly. Don't
associate enum with protocol version as speed is dependent on PHY.

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 ++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 03d909c7b14b..f303ec159cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1679,3 +1679,51 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
+
+static inline uint32_t
+__amdgpu_xgmi_get_max_bandwidth(uint8_t link_width,
+				enum amdgpu_xgmi_link_speed max_speed)
+{
+	/* Returns unidirectional bandwidth in Mbps */
+	return max_speed * link_width;
+}
+
+/**
+ * amdgpu_xgmi_get_max_bandwidth - Get max possible bandwidth of a single XGMI
+ * link of the device in Mbps
+ * @adev: Target device.
+ *
+ * Gets the max possible bandwidth of a single XGMI link of the device in Mbps.
+ * Assumption is all links of the device have the same width and are of the
+ * same XGMI generation.
+ */
+uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.supported)
+		return 0;
+
+	return __amdgpu_xgmi_get_max_bandwidth(adev->gmc.xgmi.max_width, adev->gmc.xgmi.max_speed);
+}
+
+void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.supported)
+		return;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		adev->gmc.xgmi.max_speed = XGMI_SPEED_25MT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		adev->gmc.xgmi.max_speed = XGMI_SPEED_32MT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 044c4f6be44a..a711af24fb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,6 +25,12 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_ras.h"
 
+enum amdgpu_xgmi_link_speed {
+	XGMI_SPEED_16MT = 16000,
+	XGMI_SPEED_25MT = 25000,
+	XGMI_SPEED_32MT = 32000
+};
+
 struct amdgpu_hive_info {
 	struct kobject kobj;
 	uint64_t hive_id;
@@ -75,6 +81,8 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	struct amdgpu_xgmi_ras *ras;
+	enum amdgpu_xgmi_link_speed max_speed;
+	uint8_t max_width;
 };
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
@@ -102,4 +110,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
 				int global_link_num);
 
+void amdgpu_xgmi_early_init(struct amdgpu_device *adev);
+uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

