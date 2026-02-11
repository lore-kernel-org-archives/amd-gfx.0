Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3487DECD6F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 22:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F8210E666;
	Wed, 11 Feb 2026 22:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mCIwzmA2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A2710E665
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 22:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMQ5VEzNntvm48EZr5LePe8K1IkzmJALncP1fYxtAbhfgwHZd92CAk9qekt6EM4bS2ZBgVAIKz9KWk88cz0m4BLAKCh91qqO4XJ1XieVpZuKLz1CqFYpZFaE2uWbMBGi9bUHiLp9yBWv8SgsWTyD0Rv2R5pAoSccrJfafnApIbvSlodUDpgdBqhW2wHbmFu8hZL6KbXZjrloGglaR+bpJznccRaBeW4/CYaZ3kE1gzevhry/nNU7HGISkIFKM3yjK22Jm4BuNo0fcubScUUImXIbM4fpWz9KBdbQSXz+Q/eV8BlUlW9p2VloaikEsx8NvjXCNaEug7G/hg4WAKQiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Og5qshFPC5653YVMGNr16ao4Rpz1Fel60fQ7Wq+9EM=;
 b=Xhxptiu4QXchNBeWU7aZxPCaTy+COUIPYX+dW840XXLKAQgrg9bHvgO93f3vXhuDmRkt/p4xY4MMBevKgfdeKrCjazpGVhdrSm+0ttW3VWwK16Aa+FmzmGXfgHfbtY7uRn4WimxKGMqoXqPM+RWQiTgEGdWb4vU9+0XcdTO3HiXW6PQMjrgJ5mrzsUv8kanRwA4R7Nytdy7LjRE23IYeohgetbWICUEQJTBp3BEwXJAjkP+a+URX4NNlxDYgbS0ptfJMYqHk4cM27LyAxMTM0hfe4/HnOvhFJ2ueHDhARNkNsSEjKmArVAQrq6b57Gsec5Rcj+FD87IMIsxR+YZMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Og5qshFPC5653YVMGNr16ao4Rpz1Fel60fQ7Wq+9EM=;
 b=mCIwzmA214rQKI4ZdunVYfQenswRivVge2z+WBIYJUtcyUuEOuH69X+PFWfCyccUxGPm5sgRRaeHt+VhRMuqNgRqRDy8VBAXGFJSIaBklVHgVvYIgfD36O1bfuKhgNutE3RhHq9H4FlOqsi0CwB9kp6s7g1vnMua1YagP3Dhb3k=
Received: from MN2PR06CA0022.namprd06.prod.outlook.com (2603:10b6:208:23d::27)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:13:53 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::c9) by MN2PR06CA0022.outlook.office365.com
 (2603:10b6:208:23d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 11 Feb 2026 22:13:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 11 Feb 2026 16:13:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <Stella.Laurenzo@amd.com>, 
 <Slobodan.Josic@amd.com>, <Filip.Jankovic@amd.com>
Subject: [RFC] amdkfd: Add GPU family name property to KFD topology
Date: Wed, 11 Feb 2026 16:13:36 -0600
Message-ID: <20260211221336.1443070-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 899d23ca-b6a0-4bab-1f14-08de69bad79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E6nRvK2IUiPkNweeODV/e/znDBr9w2N4RwaY79cv0+fgf/8p/pva3jEvmgxl?=
 =?us-ascii?Q?fnLsgr5BpJR03HMpBfvBnMF7TM+ha7EQ5m9s8mek22D6d90M9KmOHHqvIFpC?=
 =?us-ascii?Q?XMGVdhVP0YVQElM3jPHJlATp20Vryz4mPuTQIzJM/CoUdHB+7QrSRfo2wAlh?=
 =?us-ascii?Q?jSWdtaFjanFGtOeky9aYeXTajlOKqXYRFEz9j2xxiRWSFaw6Pq7blL/t7J5y?=
 =?us-ascii?Q?CM12pvjj1McbWmaxnXTXxR0UiOqYuI+mJNmoI4KUq7ul4K34RX0Tf7aO4GWo?=
 =?us-ascii?Q?lvDM2/XcJICoN2TpGs+mR8hBd6+6qQ4MfzrqMe4/7zC0GoNHH/f6UasZVzMF?=
 =?us-ascii?Q?UHSgA0yDseN6JbM3K/BgWC72ZzIvRn3PmLSjg1QKlR/XEYlfA8E5z3RxX6i3?=
 =?us-ascii?Q?pWVEiuIpDf2cCHTQW+xw0G/hSTcFZ4IIF+nI5pn2o9uP6msR2TAnmeNPbiJT?=
 =?us-ascii?Q?yge1/MdNsr56vTUcXr2Sx9ZajGzO3dQ2lGPgvExjAdy7/k8ghd/jzPVGVYeh?=
 =?us-ascii?Q?1qrEGVOx3GzvV0I88J8Kd/hkYzSJ/F6m4tgehCLzeS3ixpOz6HIjubAriJsR?=
 =?us-ascii?Q?qPE5Abma6sDEqr97W8qpspMgOD0LorKsNZj/n+muEL/krMq5baABz5OODolx?=
 =?us-ascii?Q?C/LEXm7onaYuxt8255xaZWmGCN7LSndCj4iPLEi0Ukr2cCIB8eSalEJ2ALKK?=
 =?us-ascii?Q?gKWaOhhVScMnGBLY5XYll47wnXuL6JrgulMFp4s5DgA+WxhRp2o7npsoT7Am?=
 =?us-ascii?Q?CqXbcKP075otOdxqS+lWDPVyVe/ZDyrPz/rlWY+A0hD0Zv3YkvMR4NUjdOgv?=
 =?us-ascii?Q?gsy0GINDYNfBfeAP1u1P4seLwIq5uOtED44zowtu4W2rBndNa/SXKH0TCGLo?=
 =?us-ascii?Q?tV8po7ozUju+LRVcsErVHZqxFGrcel9xWCGDxnXNGWIvSs+bFjLznMQJ8loe?=
 =?us-ascii?Q?DBTZlAU8ey+QXRy4R6iJtF8HrKdT9IUgTwJu1Ra0/u0HtKLEW+WlvYypT9br?=
 =?us-ascii?Q?N5oCeBqXLMUyAqW/cnKsZJAwrluVcLQikYjLq4VMI5IannoY+tAeHGwh30cb?=
 =?us-ascii?Q?bNBirfWgZKsv81lbjvagfxwTVoRH90u6vcvU2rxpGhv3d8kMhuq4oTWq9apT?=
 =?us-ascii?Q?2ei3Y3xxlVRaCcsaVOXMcKapv8wVXSTzVHmOyS5vT/FXjX6OFOg0DAXc9Us4?=
 =?us-ascii?Q?Lk1/dqFIXFxjwc5jAxtiSZgJCNdrrxF9kRyydYW9wNd2z5lf/pSefduPS4z2?=
 =?us-ascii?Q?VVP+cKn0DyvtVrSqvmWdcAxt9sHwJqtHq2ldyH8oTpVUzPiAVBbeLWmdgZox?=
 =?us-ascii?Q?8kYlNFKPl6R4E1rCdP4J6EF+0pxaJjbp7heLrRpJpH+3uSv94vxOVQ/52MT3?=
 =?us-ascii?Q?Vq9bUhGMdr8wSwFb2M23AgLmVHm+thltalkAbT8bnUt4WRAUoBFGsTZHmPbl?=
 =?us-ascii?Q?qS+Ua4ZzclDbsRoA5wtpS2kr2qghui/vWD9y7fYY1vKHLKyRozSVcgiFbHU8?=
 =?us-ascii?Q?ER7P59xbXZHC+amC8XyniedzdYBFQQ0eHqU9KNTJeEBjKoxBqJeBtd+Ia4Iv?=
 =?us-ascii?Q?2IyJhVXJ+OC8onzYJIGkgNc+SBA0VhDXsaDK37jcx8taea+pEKuqHIAYZpw0?=
 =?us-ascii?Q?AerVaWkXpeIyygb7fysWLtTSBUrtrXowMl8Ry4I77NhhzLROYWPAPLhkfwCv?=
 =?us-ascii?Q?flUmtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6KF/nrEQwxqv/FDd/9FOLVs9CyCiv04uY6ZuOntmWSF1GHJNqMWiMA3IdPYyeRsl9lgLb/jzhRy0pE0IeoGWdJiOfN4NvybhPZNtxS0hIYVeGhjag4j+kSZPZgldjQv/3XUXbAKESloc6tAqgJhRBFv8AQWYi8ETP+6YhLMlaPja7chM3LB5t1PDJae2ux1K3+aAC7Yjn9MID0UtraWT3zOojGQ60Ed1YlquaDZABLMfbK0gMYi9giH7whU9osDTJ2KgxF+3W071x+rALkvkNTCIkGp4Y3zGBnPD4/gXi38dldQmARCjY+DMzDZ6c62uN2HD1lGZuidxOpf1rQWKdA+lt0Hrb251WYhJYRxGqI8qSRqZUkPTMSOpkl+3V0Q+pNceupoMZ2SJCFJeE7ruEdfR4r0IsW2hBkodU0F3EhnyDWpDv008MUOaiDDl+8zr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:13:53.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d23ca-b6a0-4bab-1f14-08de69bad79b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

Add a new 'gpu_family' property to the KFD topology sysfs interface that
exposes the GPU family name in ROCm TheRock format (e.g., gfx110X, gfx90X).

The property is algorithmically derived from gfx_target_version, which
encodes the version as MMMNNRR (major.minor.revision). The family name
follows the pattern "gfx{major}{minor}X", making it easy for users and
tools to identify which ROCm compiler target to use.

The property only appears for GFX9 and newer GPUs, as older generations
predate TheRock targets. Unknown or unsupported GPUs will not display
the property.

Example usage:
  $ cat /sys/class/kfd/kfd/topology/nodes/1/properties | grep gpu_family
  gpu_family gfx115X

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
The idea is that this can help a user figure out which wheels they need
for their hardware.

Cc: Stella.Laurenzo@amd.com
Cc: Slobodan.Josic@amd.com
Cc: Filip.Jankovic@amd.com
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 37 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 08c63b4cc9a5f..ab029d87eb9ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -471,6 +471,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.max_slots_scratch_cu);
 	sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
 			      dev->node_props.gfx_target_version);
+	if (dev->node_props.gpu_family[0])
+		sysfs_show_gen_prop(buffer, offs, "gpu_family %s\n",
+				    dev->node_props.gpu_family);
 	sysfs_show_32bit_prop(buffer, offs, "vendor_id",
 			      dev->node_props.vendor_id);
 	sysfs_show_32bit_prop(buffer, offs, "device_id",
@@ -2048,6 +2051,37 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	kfd_topology_set_dbg_firmware_support(dev);
 }
 
+/**
+ * kfd_get_gpu_family_name - Get GPU family name from gfx_target_version
+ * @gfx_target_version: Numeric GPU target version
+ * @family_name: Output buffer for family name
+ * @size: Size of output buffer
+ *
+ * Converts gfx_target_version to TheRock family format (e.g., "gfx110X").
+ * The gfx_target_version encodes version as MMMNNRR where:
+ *   MMM = major version
+ *   NN  = minor version
+ *   RR  = revision
+ * Family format is "gfx{major}{minor}X", e.g., 110501 (11.5.01) -> "gfx115X"
+ * If the version is not recognized, family_name is set to empty string.
+ */
+static void kfd_get_gpu_family_name(uint32_t gfx_target_version,
+				    char *family_name, size_t size)
+{
+	int major, minor;
+
+	/* Only support TheRock GPU families (GFX9 and newer) */
+	if (gfx_target_version < 90000) {
+		family_name[0] = '\0';
+		return;
+	}
+
+	major = gfx_target_version / 10000;
+	minor = (gfx_target_version / 100) % 100;
+
+	snprintf(family_name, size, "gfx%d%dX", major, minor);
+}
+
 int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
@@ -2105,6 +2139,9 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
+	kfd_get_gpu_family_name(dev->node_props.gfx_target_version,
+				dev->node_props.gpu_family,
+				sizeof(dev->node_props.gpu_family));
 	dev->node_props.vendor_id = gpu->adev->pdev->vendor;
 	dev->node_props.device_id = gpu->adev->pdev->device;
 	dev->node_props.capability |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 3de8ec0043bb4..8e52dd59b53dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -81,6 +81,7 @@ struct kfd_node_properties {
 	uint32_t eop_buffer_size;
 	uint32_t debug_memory_size;
 	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
+	char gpu_family[8];  /* GPU family name in TheRock format (e.g., gfx110X) */
 };
 
 struct kfd_mem_properties {
-- 
2.53.0

