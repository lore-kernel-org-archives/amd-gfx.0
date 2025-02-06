Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1928C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAC610E828;
	Thu,  6 Feb 2025 13:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LtJ6rPNn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7339810E2FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz8X/dgYbMYCNJ4Et9HvzpyV7vjBT/Zd/acjsg/19NOdPQsRzwBb92qTG2SA4bME0A38nT76zo4xDK1BYtaP5v8tbiL07ERhTj9jtjr5CqkwE7ZKdCzpqkoKXHRAf4WcVLdJ4YTVzmqv2R0MlBwkHhT4sf4nvx27Si8DHAvDdNvQPqC3qUfuW7zi0gnsZe2aMOJI01sbgeUqbaF+Kc7pj5uZJyWtg3tG7XU8Uq6mpJKtpMrKBSEJffK4PkOjMQ0dD4NnsgjrZAYNrLoXu5mvlpy+ln4j+KT4+prHLJ6o9UyG52WZ86gz+gaCtYlThp+FIaUWqdlNqYKdv29F+kQQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYR+AtAbhIrNVLMIqWxmRGqfgrprIudL1T0Ap2WN22o=;
 b=ZJ5OTWG6KS3rVUWEnJZ/yKvHJ7d2Xxwr4VdE/CdFZ61ZHrvNJefQ3smoK7FhWOYQqSASG6UPRXUlXURN44S6JNpgzJPygVGcYQR55w7utawAgqoDUBM4/dV9KQi8BN+3S9s5MCDGt9IFtkg8eb9Md036M8Q7aSFuq7FFUjf+pjKlGFb7stdQlyxK85BF+H1TX6rd88UH5AI8nsooyGUDqdo3BRdl6+IIRGKJW09ckYcDtaIm2VtW6YqQ7n5gGoyp66cdTXocm52kDyEvqiVPK91IuqZaM937Djsh8FOASdwHoNWtYk9DO+CBotMnhRUaLr/R5xqx0Rc2FFy+E1ep0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYR+AtAbhIrNVLMIqWxmRGqfgrprIudL1T0Ap2WN22o=;
 b=LtJ6rPNnxrIv6DU7+KButKiftRjCGmi7+Vr7q6R6ER26YoCuW6Dj0CoOQ8mOPQZs3j3duEb8XS825D8wcxGdMngDWE57DfjH4Z8pwiVRjWxzrdhuYtTFP/dA3dfcACnNdVZTTQmxAZFt/2ZdLzu4G453bsP/3zIG1C2kX8dsTto=
Received: from SJ0PR03CA0143.namprd03.prod.outlook.com (2603:10b6:a03:33c::28)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:13:18 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a5) by SJ0PR03CA0143.outlook.office365.com
 (2603:10b6:a03:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 6 Feb 2025 13:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 13:13:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 07:13:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Jonathan.Kim@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
Date: Thu, 6 Feb 2025 18:42:56 +0530
Message-ID: <20250206131258.1970391-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206131258.1970391-1-lijo.lazar@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bd0128-267e-4e39-e3d9-08dd46b005d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N9XBqWo6nZ800PAp0U/ieOD20FkaIRvmoCnZsSKuARu+GNJfjJ9O6oeuJ7X9?=
 =?us-ascii?Q?0GA0I8NN0isi/UYRuGPgu3T0KpE0hpFIXScYfGfLZCKYCQ2atNETI4mgkF6j?=
 =?us-ascii?Q?aW15z/7a2fMKp+U7tUtcevH7oyN/SQ3I8DctJ5GfhgmgtR3BVe0mjtAmYwOa?=
 =?us-ascii?Q?zhqjFOSlWg61znkMvpQN/oMV2AbbH+WJ+OtV4stWYzpDdYwhNcEKKM8WcIwk?=
 =?us-ascii?Q?JaFzR03TGCPPYtCfQlPS1/Aj4ZLLDRyptw/M90YPEBhwvm53XyUG4Pd/+Wqy?=
 =?us-ascii?Q?1Vdi8ugMJw+mMQtXl6rZM4IkBEPxVl83ITrrURg0BcsdcgMLUYt8xetVcn6B?=
 =?us-ascii?Q?DQ3lHsocmmi+a5cnbArXyMCWEuJj51bv7czT5km7bdwn+CGgE0VZg3jfMRAg?=
 =?us-ascii?Q?9GjNHVujWCQ8ZdBQaagn4WkbtJDqqQH7vA3stIH2QRR5hknj+w4X5+xFfIAZ?=
 =?us-ascii?Q?IKsv/f9k1aUNfwn3GKYPgKbAbkbBZrjGPm483NjcDnMJ6J0N8Xp2It2QIo9w?=
 =?us-ascii?Q?XLD3wZKNJVH2efpqM4VQpPnftwAGQ9bvjZvlm2BMnngmJaXa/L263GVDSmpj?=
 =?us-ascii?Q?Hv8vecbNzRtVTj0/md8JmhpV9BjFbPb+pY9gOE8tapo/+LlZDsqLOfmHWz6A?=
 =?us-ascii?Q?Oy2EJ9ZcvYelTX9B/XceVC12AOEtlv/qpKE7cSVIayXNu4tgZLqKaSSHHCTI?=
 =?us-ascii?Q?9z6izd7NpyneB6CppsYKf/srRFaTVsEAVNXkvFm7sEFqxybfQFX4e6zKa5Uk?=
 =?us-ascii?Q?F2vm6gpVgaJugyEN2LQYM+O7hY6u/YerU6KF92PSWDGqP1h750xmLGFvgFFC?=
 =?us-ascii?Q?62HADV4HrmW6XoNDZTUO413vPdfWs2FNmt7efGwXcuEGbqPuxgYye2CLrN+z?=
 =?us-ascii?Q?ptWtp6uTpQ6R0qMGTfQrGtDUZU7TnlE2fYmjHyioBy+HIdKZ2HB1FJxXCYM+?=
 =?us-ascii?Q?WKzduslkS9ZvzARpgVsjfFB1ZVQaEUihTMw5CMiEfaD9xDuis+dwq/tSHqpE?=
 =?us-ascii?Q?ULgiwcjK9o1OHmIHKqXtnlofVX9z66ql3f1kgdFCx5duNmc4uYwVaFf8uUPk?=
 =?us-ascii?Q?/TFCIFm/MLB/KT1y2h6cX9+WH8fQ0CDHDIoD/xsfyAQrUksRAWx7qeyOWaq3?=
 =?us-ascii?Q?vOvMgjkLiCC+PPj90JHcW9tTa/zeg7aMrKnn7p7+mwNefwBx8vQd5zkfkvgq?=
 =?us-ascii?Q?jz7IJ915XNGn3iecW8DvpkZl3QUajO6U924QEJAxAgiWrd8LOHPl7/TF++Qi?=
 =?us-ascii?Q?s3/nmc+htlEQb3jIoK/vzyCYqlVWDDyXYsFFh8R95Oz3Wp/7bsEE4G2z0j2K?=
 =?us-ascii?Q?Y9BtlGlh5umPq4oIC8p06woZlEF6SaCtPRR7bcrDUCTNLkL0DLa9Oan8O7F1?=
 =?us-ascii?Q?drEE2bZhDPWGPTnuR1QgePi4EVBsc1k4weH8qufSoEEspsadb38W9C2P9KD6?=
 =?us-ascii?Q?oriCuNKKRPMQvFK08cZquvCYQ6CA/mYve/FnpMb3B/hAW059adCPGMvUIjlX?=
 =?us-ascii?Q?MMbmcHO1Lwumtls=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:13:18.0876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd0128-267e-4e39-e3d9-08dd46b005d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 +++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 03d909c7b14b..edef5763e2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1679,3 +1679,44 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
+
+static inline uint32_t
+__amdgpu_xgmi_get_max_bandwidth(uint8_t link_width,
+				enum amdgpu_xgmi_link_speed max_speed)
+{
+	/* Returns unidirectional bandwidth in Mbps */
+	return max_speed * 1000 * link_width;
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
+void amdgpu_xgmi_init_info(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 1, 0):
+		adev->gmc.xgmi.max_speed = XGMI2_5_SPEED_GT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	case IP_VERSION(6, 4, 0):
+		adev->gmc.xgmi.max_speed = XGMI3_SPEED_GT;
+		adev->gmc.xgmi.max_width = 16;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 044c4f6be44a..384c4ddef78a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,6 +25,12 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_ras.h"
 
+enum amdgpu_xgmi_link_speed {
+	XGMI2_SPEED_GT = 16,
+	XGMI2_5_SPEED_GT = 25,
+	XGMI3_SPEED_GT = 32
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
 
+void amdgpu_xgmi_init_info(struct amdgpu_device *adev);
+uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

