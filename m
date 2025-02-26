Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBCEC19F2E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 20:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9139710E285;
	Wed, 26 Feb 2025 20:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oqk63F66";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E283210E268
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 20:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma7IS3fAUQ5V++3x01pljckcC6Bzlk03uilJe19/ziysYrL7HVdT3ATuPtJcl7851nmdoM2mnQsHkMPgssleO/Q5Y6cvnuVpLR2YA3LMSLnfV4UEgsPvlyZTa8JgKqiD5wygUAIrEfLhnhwmyLVnkh3188wrMCQtn8RHbH5OXnizVqAovUDKtCaXpF8odrQjYZwoSLEAmLOJE7eaVxeLZndWiSY2n8a1JjgP9NfFeq65BKkmBXxrqQHxAi/Ed9Idr3fMb5+pJEl4+tUT+rHWyRdTQJfYYGWFxXr628EUswWwC4N8bbdmll6xjwRilZeQgOBBw93Qb5OqFNYM9gPSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnmx5WW2dwF66wZhtgnYnOFTRPr9nWwF84bIGgl9C2U=;
 b=BV/x88FfZcEuI5R1/VVZqZlyrndGEFU73xZ0Pg7RkPcDBOouk0O7d7quVTUaDVcC+L81UNfOqMXMb9kGPHUI3h3YLMNdGoOGe6iaWmDRB2MSPXERwFvt5VXP26R5JWTiwuhDmlnaLl2P+d/KGuPBRfkkhk1aT0anqSNR2/XQBzDRW/zVi+FYvTBi8rfXF9/EyPv9DHA8Bg9+8fnFO3RBjWWjWgMdcph83i0LZ5IiPfLeUFRzWj+v3vjyU3GTq9ivM5uSOfk2+8a+a2FVoFpBoGnVl/fwSrHgI/Ix00tWDqY+QETemG0j4GyNrzW979ppajp4BUlFgMEFJmmgt88JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnmx5WW2dwF66wZhtgnYnOFTRPr9nWwF84bIGgl9C2U=;
 b=oqk63F66A7w+a71paKjJaFLHwFszOdeb3SCU0e9JwuqZRCeNN7v/cWYhNQRrVBHpsFAe5xYZWUrlg+idqp1T+6E5u0ZY/kSzi/e5AGiz/y2CCAFejmv5c9x6HzfEGZCc1KXYVtojI1VOiFBJYpOf3Bui39OIU4jdx1yIVxH9cC0=
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 20:58:04 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::57) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Wed,
 26 Feb 2025 20:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 20:58:03 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 14:58:01 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: flag per-sdma queue reset supported to user
 space
Date: Wed, 26 Feb 2025 15:57:34 -0500
Message-ID: <20250226205734.3108512-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226205734.3108512-1-jonathan.kim@amd.com>
References: <20250226205734.3108512-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: ad09be4b-5ac5-4455-d342-08dd56a842f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NYCHpJVKiQWLbfUxM79Wa7TFziJ5o9IOi8X4dHVy1rNqG5Z11xRE0aUNyuGQ?=
 =?us-ascii?Q?I2bfqJxXM4UDyFWmGlRAVdAUvyPdZu7O/2I9npvHDcKqXgCE7lrKZoGi4C+D?=
 =?us-ascii?Q?ca9eB3V4z3FH+2/eRy/32m+wSgi5HJ9uNDdwxs8wX43E1lpAoY4BxkMoHx1j?=
 =?us-ascii?Q?jv3/Dd+9O+jHVqD55+5n3OGkN2UxNdc4H2JFr/cKcFcliqhxgiXst9/kQenl?=
 =?us-ascii?Q?565qS5hpDgCCL/fw/cdflM6l3dI19tmRg+Z9mmqCVtw3N79Zz5WELZMMZCfS?=
 =?us-ascii?Q?/79svOKFzLqsdMR3r2IZutjEhY+FySrKdwfMZPYaj8gQOrqbYGzft7huLA7c?=
 =?us-ascii?Q?w6TXNYnyz9k447F1HxO0Q7lijnIYn30wdqaqrach5jhduB1nuJNOa+pvqd1k?=
 =?us-ascii?Q?RmFhuwcU+EEdDCi+An/3lxCIxd/IICEwbJL8MN5yhGMkfhOoDWMsCbZBm/Vz?=
 =?us-ascii?Q?8FvsWfMU+3gJvCL9W4oe077BurB4x8h8VtUrrv60r3tsoDj2M+5UCS5+6Auf?=
 =?us-ascii?Q?wpCE2aradhcJfc1SzsDAsaeiC50vcvqwPHW4xTT7joxE9Nmv6voWmL6B0IsP?=
 =?us-ascii?Q?ysoZJzwEtPxFwAQmg849B3zZmKOD08d9ugmwG+t0yp1LVeMPve46QHp+2aNy?=
 =?us-ascii?Q?sGnmtVqdhLtpNXBSYsGJLx22JbCXk90eONZXXyK+SGR7lFPd4esPVSxANGu1?=
 =?us-ascii?Q?cKSUE0V57Dqb3jZezbKK175EKlai3k23cBpBx7f7jQ/WQ9/sorJAgTpE2qnp?=
 =?us-ascii?Q?9p8HLoTbNqFzS3rOcCasSVudxemV/ycpZQ+go9R4+MfstvM3oroPWBCOV4cY?=
 =?us-ascii?Q?ig0E0ipWycEjZDyUPjBXfi7qYJSx073MtRpMdLWLwdS/tIZh1Svb8uZ7ZTze?=
 =?us-ascii?Q?h2P8Ca3XZc2PEpujLFxh+T7YOAKb3ldcMc4yDxqqEuAWlLCFOUhQmwdWtqnn?=
 =?us-ascii?Q?/TM15F2bnaH7a4CJhjaz+6rVa9BiOGuo8rzWghzHRkmH3fqf7Y5UBGJGo3/T?=
 =?us-ascii?Q?ZX4Rs54atgukQOM6DyOpOJQdoQVnPG9CB/sQiDGzRbcENXD7lwYpWfgizC+q?=
 =?us-ascii?Q?7ax1teOvW63NQrVyQwddFDuR5CZeeiNZnw1XTz9Lqbbctn2zFx2kIQRPZshO?=
 =?us-ascii?Q?lwr3yMlfAR0CkAfW7bQZoolyKnlRRkATvg6LGzmdrqPsNM1syU9vNpiMFxVU?=
 =?us-ascii?Q?Qp2Qx13nKNes7eMFZJZbv08nt9EvJJeoyE2mvVhmY3tMTwCM+heKASNIKLT9?=
 =?us-ascii?Q?xq1l47fVt/atI68oEP1J5cXrAfKJIeW9g7MrhfuWJlm94g2kqUPwiBIVvUtN?=
 =?us-ascii?Q?9AMRS0FS1Zf8m40/o0UEpla95TH4J8LTFb+98DIpkgJ3cbyrZqBohtxWrHgg?=
 =?us-ascii?Q?uRquH1r4SsIjDfgTVILqhQu5gmA/1QJOeKJg75oLKru95+GR2F0SyXZ+n8F+?=
 =?us-ascii?Q?9+TVW95eb2c9F6wUCDZ6ZPH36tbURLdlFTLp6E5jEeC8IhqfUv5ujZJCsw7N?=
 =?us-ascii?Q?zsco8Zvmilxg6n8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:58:03.2489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad09be4b-5ac5-4455-d342-08dd56a842f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Similar to compute queue reset, flag SDMA queue reset capabilities to
user space for safe testing.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 include/uapi/linux/kfd_sysfs.h            | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dbc5595e999a..27e7356eed6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -519,6 +519,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->gpu->kfd->mec_fw_version);
 		sysfs_show_32bit_prop(buffer, offs, "capability",
 				      dev->node_props.capability);
+		sysfs_show_32bit_prop(buffer, offs, "capability2",
+				      dev->node_props.capability2);
 		sysfs_show_64bit_prop(buffer, offs, "debug_prop",
 				      dev->node_props.debug_prop);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
@@ -1981,6 +1983,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
 		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
 
+	if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+		dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
+
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
 		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3) ||
 		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 4))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index f06c9db7ddde..3de8ec0043bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -51,6 +51,7 @@ struct kfd_node_properties {
 	uint32_t cpu_core_id_base;
 	uint32_t simd_id_base;
 	uint32_t capability;
+	uint32_t capability2;
 	uint64_t debug_prop;
 	uint32_t max_waves_per_simd;
 	uint32_t lds_size_in_kb;
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index 859b8e91d4d3..1125fe47959f 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -63,6 +63,9 @@
 #define HSA_CAP_PER_QUEUE_RESET_SUPPORTED			0x80000000
 #define HSA_CAP_RESERVED					0x000f8000
 
+#define HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED			0x00000001
+#define HSA_CAP2_RESERVED					0xfffffffe
+
 /* debug_prop bits in node properties */
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_SHIFT    0
-- 
2.34.1

