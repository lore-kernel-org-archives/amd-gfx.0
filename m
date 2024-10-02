Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890C7CF3199
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F2510E693;
	Wed,  2 Oct 2024 04:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zkjhWqtz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B6F10E686
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is7LjW9jTQyyPbAO3n6l/FoTNY4fK3QmYj0A0QVDCBptwAVyjhyevg4Ab1sw32TNJmIEeOyCDK96TedHWmoTNwkT1sbB0l+x37ZwbPOmktpGFe2m79q+IeO+akBQCnqm784sWVeRCEZ8o1wekXyTcz+yBwcOyhAp//PnI1w+yidPxIFi5mR730I841pbUxNTIygSFRxxs9MeHEM/RoCy5GTSb0wNzyIbdJgeDMndE/R80tAVUpOLxEbZiKpYGe7gs59xY47PUpk1hUEq5JxH4zHRV+S2GpPRnckPIcUn1MSJ9EScWFQuGO67ImdZFlMRmtA6tVxdM04PkJyjm6+GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00cYugmb7uIIxLN9peQdYY4Esp/Jg35Tjhw2B428nx8=;
 b=GPVV9EpoYL7PBlYrLCGq6YwuhBjHzacgFfwc5eibRZJTCZhCBWwrJMWP+ruC0+zR16iDZoH80sQf3KsMtd6gii1hYBnHzjkAs8ecCPXo6Jy0ydCb0t9hDYoU7DgE4SFswbMKF9UyUyHjh5az/mMB7rE+F01PmKN/tAOoRhLHPFrEReQShfO4AIe0aDbIHx+a5CvfBSKCjGHLfX6T+nQ7I8k4V3VVgGSzSOkLEak5IgDB2Z+af+6zpy2umhbNSfo1kYF6TyhYpimb2AeDbXKaf00WpTH6PUjrz7lhpwEHmNs3nVgqbhrjQ4WeLN0goo9VG4r53LHFdFu/ZSwhcBowQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00cYugmb7uIIxLN9peQdYY4Esp/Jg35Tjhw2B428nx8=;
 b=zkjhWqtzsuk1hFrQTsZgnOWRdG+YB0g+4pawkmEYXU6o7aMUXt+mlEOXR+tO4bizRa+sPBAcJRUs6wLe/fidS7PP4ObSWgj27v6XxjqZyNVcfAVZtOv96Sdl68pFe4IuXayePsoK9nshuxIF0M3AsXrdGJTTFX2E42E+DVsSAII=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:38:55 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::9) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:49 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 10/18] drm/amdgpu: add ip block with instance
Date: Wed, 2 Oct 2024 00:36:19 -0400
Message-ID: <20241002043627.102414-11-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d542862-ea25-4c62-decf-08dce29c1f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0v908gyWbWd0Hj/3j/l00AFjrN4pL1ckkbG4QYQSyriCwg7lryoKI43i68k?=
 =?us-ascii?Q?qBlrqE53DYBFUTWtSsyEDY6NrscZlaqfueJnc3OzUg7xI5n8k+bIGiyYzC9w?=
 =?us-ascii?Q?4Q9H7etfNTFKgmxiJxZq8Nb7XDAsmQQ6EWnziwJzXoCjBEUmLXdaE7DRbBMe?=
 =?us-ascii?Q?5mowbrUcfP7M7L3yJ9uRJ9uwx5fGbDqbHCzzV6Prhna0WKqwYwvftb9cRyCi?=
 =?us-ascii?Q?uihOVIIoenxXsXY2GwSLgbPI9F8C+EeyWHxIbKh/bp5Cv8B9S9cVwaAAe4+G?=
 =?us-ascii?Q?bACp2FZxHGH1igIPo8uJxdF897HhVXuno0VTgLvUFLAQwfHeb9mZI1Ku6rva?=
 =?us-ascii?Q?IKhtikcMOClG1K5HdnhVDqTXNfJ5j9Sp8k5iy5JjCCeLKP+9QpIqdYTcGvab?=
 =?us-ascii?Q?qufDbLya881t4IKD4rJj+/9bvl48F+RtloEYP0DivZ+Rk+DqTDJz/5nxgfFK?=
 =?us-ascii?Q?OtLvOm4q3o35UkWDpROOJih+yo/YwCXp8wbGhv6azsQ3YDqK7ofPzJlBar7S?=
 =?us-ascii?Q?KbuPx4BBPeBVcYzXv8sYGQTF2gRcF0dM/2yCow+z3bGTHyA0pXRosK75gFo0?=
 =?us-ascii?Q?b+hQnxzYmb1uQl9oPfI+HNm0W15GLyjfzEDyHJI2zZas6hl8oYBHk0j4KJcj?=
 =?us-ascii?Q?vZb7Y3LKPEatFARNOlFhRlN5shcLwKvI3FkC8Fu5q5t5elayvTTnQD8AV6yc?=
 =?us-ascii?Q?SEZv05gYBier/KwDhLVlKh4ogodxTjoJkZelrhMdJuyrah/tqnPXUMQo0ZmJ?=
 =?us-ascii?Q?hOefFNGX5U31tBngYL5AitEkpjN+sSaMd4tGGhFXE59fTvyLZtno7s0KECsx?=
 =?us-ascii?Q?qXht3LModym02twhT1d/chEQGCyDwaBcP+mDFksVehxpI5o66+7bnJM3NL5K?=
 =?us-ascii?Q?iy+6a95JkZD+ICpaGem4Rdt2maBuJO8wgBBhbtHL7GSFoakarV2x+fZUp/Jd?=
 =?us-ascii?Q?2RaLyVpFszauh/9vBcPl0ypDNqwF1O9AW1Wudc88X0ePGWNEahXmpcwT3x42?=
 =?us-ascii?Q?qPYn5AorEwLI+h0h6xLtvwz7sU/xvZrXF9CikN6veM7TtIjCyvILXAE4/ujX?=
 =?us-ascii?Q?C8Jr0guIksuP7Om4fu3I6Yo8nHwP3JIP0B3bHuDfhDsgC23RSy7AlMhRDE5i?=
 =?us-ascii?Q?M24sNbbdG662oOq0T0Ch3mS3rFb/c83RYOnNC7HxxFQw/BW3JSee/t8t4zHA?=
 =?us-ascii?Q?QHiJZ9In8km+vZQdmwbVQUS2KhS85e++3Yci8Lz6B/tMSJ7AH1zMNPRJrDfK?=
 =?us-ascii?Q?DSOm3Eb0Q7PxSkmaC+Blwl2QrhwJFLdzjAdmOlen1t8imHNZdb1dISeZTATH?=
 =?us-ascii?Q?xk9DL9bhgx9PYsWTCfk2mbWLDSU231ZbaBwZWrzvrTKLmk4kx0coVxDHfw0D?=
 =?us-ascii?Q?p5HzMqniJAc1wZkW66/rfIZaMeX5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:54.6530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d542862-ea25-4c62-decf-08dce29c1f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add instance number to ip block to track which instance the ip block
belongs to.

Also, add a new function to allow ip block to save the instance number
along with other ip block driver information.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 84a9749dcd7d..d77db73c71f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -386,6 +386,7 @@ struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
 	struct amdgpu_device *adev;
+	unsigned int instance;
 };
 
 int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
@@ -399,6 +400,10 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
+int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
+			       const struct amdgpu_ip_block_version *ip_block_version,
+			       unsigned int inst);
+
 /*
  * BIOS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 263f25ac2d63..4bc109a0d832 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2321,6 +2321,45 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_block_add_instance
+ *
+ * @adev: amdgpu_device pointer
+ * @ip_block_version: pointer to the IP to add
+ *
+ * Adds the IP block driver information and instance number
+ * to the collection of IPs on the asic.
+ */
+int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
+			       const struct amdgpu_ip_block_version *ip_block_version,
+			       unsigned int inst)
+{
+	if (!ip_block_version)
+		return -EINVAL;
+
+	switch (ip_block_version->type) {
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+			return 0;
+		break;
+	case AMD_IP_BLOCK_TYPE_JPEG:
+		if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
+			return 0;
+		break;
+	default:
+		break;
+	}
+
+	DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
+		  ip_block_version->funcs->name);
+
+	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
+	adev->ip_blocks[adev->num_ip_blocks].instance = inst;
+	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_enable_virtual_display - enable virtual display feature
  *
-- 
2.34.1

