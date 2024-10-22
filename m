Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2EBD2CE12
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 17:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0D10E6E8;
	Tue, 22 Oct 2024 17:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1DRqrly";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3DD10E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 17:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOacFAVrcGjgQk1IY3qhLwCNKnAejG4/2fz5ZJ6pu6ONRakrTuf+T4t+V/HAtQG33LV4jJjQa0E0oyZ0DaAl4dod7tkT9MLKavNbEy9nsMcjuDwn5HKapg5OLFLIMMJ7el5najB9qYaiXycsQEUJRTNctHL4PyrfW/YXxbYpmbz7FHzoKtbX7F36BPuKo5qNh/PUZql341osubjR6+BLUqBfIuJTM9Law2O7IFEZigXAZEkZNJPIwEU1RBSwKfr+hay5QyAB77Il39y9mkmx8gy4KZt9TkpO3WR/DZtIo4owoKkMEE3r0r+LfcDkdLDBVOTRSxvlwUP9vPK7x+yh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZfHK/GJ5iHbyXeWP7V6FXvVLTz4M2T+lOIftcaP8EY=;
 b=qbqrW1B0C5B8iRX2RfAZM5lqoIjzdunXbDGbzRgQwmENIn/BqxHVUOJodwQ9ziCrqUTIJcN5rzXk0lHJT7o8+lX4MPrqtlyKZzC8gtbjADeaGJiXZEZxVH1+OS065H+RwERzDFB+Xdf7JgprL/W8QGFHeQeXvf81yS1K8VCgbOfQLRRfLvXZeInqAMFtz6FuHH0B6vNG7fFEoH/O4ri3nHDvvpf8AXmyethM8L9vOc+iFsefuewRa0Nq3l3t4CKh44GgzUtf3jWAxGpJd885P71Z5QIrdHJbR8YBYjMEuX4w7mdm/ahMxjAKebyn5dtomb1A3Dfy+DIvCYLy7yhMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZfHK/GJ5iHbyXeWP7V6FXvVLTz4M2T+lOIftcaP8EY=;
 b=Z1DRqrlyi2wV+kgrC2mB++8WgM7nMlpm0sgxVTLGDvAW33tOq/kf9oqpsJJ/1vFepzzHDXT4BHo6BpdSYgYP8ymvEbXU6KtsmUJaUJ0gyzUuQXzLQAJcEKAKQBspSVK1Av9Qdnr9QbEFP/v6LxfgPgsz5wxO5trEQU5g+N0OI1A=
Received: from CH2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:610:53::13)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 17:37:28 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::36) by CH2PR17CA0003.outlook.office365.com
 (2603:10b6:610:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 17:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 17:37:27 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 12:37:26 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: flag per-queue reset support for gfx9
Date: Tue, 22 Oct 2024 13:36:57 -0400
Message-ID: <20241022173657.2363931-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: c38d26cc-8673-4224-2d45-08dcf2c032a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xL/sRCPO0WLlvcKc09/zTbhGngZxCvDLYwBvnKcb8WlnB7aukK89VKcN2iZI?=
 =?us-ascii?Q?P9xYtOYjt0w++PjksKDseMLAlyP9GfpMS25W1P1Xd668EY7G0HPiXSXrSYy1?=
 =?us-ascii?Q?Jri92m4Kwg9j8BCKJm6TQ9djR9G7YwPQtgOTGQtfp0MVhRYg9k77v7+85OBV?=
 =?us-ascii?Q?XV/EwWgLb9YA2Ysj72R5QMEoGREsWo+HCatjUTNwtC4Ul6gdtW7UZ/4hdzKL?=
 =?us-ascii?Q?d9/FH1gA9C7WG+eeBIphEBO2m8lUNpYxyHK4iBVOt/TwBXPb1XGE6wNIQCuX?=
 =?us-ascii?Q?iiiKUI6gwXA01sWZtmfJ5nCHLdcwHJ6lpJtN1wL6u8rb5QSFworIBnZXPeeT?=
 =?us-ascii?Q?6GLxCO8pVJY/hrBND1ZDJXrm0rIUH/ke/Wif6JIhV6YSGcHds/czjjTDOq6I?=
 =?us-ascii?Q?sOSm2aAQlzZY2WWkUXKKpOXDxvvEc7mjrNK4QZ5Xpq/nmCzGwhtX9fdvozcc?=
 =?us-ascii?Q?L9zSvrZe7qpXDRTGj33eKr96sX/2b7vU/gzcH/l45bzzW6WYEQipJorbkKgj?=
 =?us-ascii?Q?a6ixxS05MAwTAhVRzD17k3mvEwJdlR7ryPMzVCjJcs3+gqOFkUmWr/6Hb5DD?=
 =?us-ascii?Q?HYA8TO/Qpe5ZA1jVYUu8AAI4kk0CkZHZM3OMx3fea8DlODXSygeNibnB8X3H?=
 =?us-ascii?Q?jAVL4l+hcFnyybGVvuHFzAqBSm6VholcBm2HCL1rFdpZp8j5StzXbB6pMscf?=
 =?us-ascii?Q?xNHYEyO3pjPlStTO7waMT7e7BJyR1VtV3Br//oTAyR5mpqdCnXjcVaCfyXFE?=
 =?us-ascii?Q?QoqGCt/Gon8DLQhYjYvpKGtD2och7HrdKpQ7XBAUGTOHwL6Cp4woOwzkJt/J?=
 =?us-ascii?Q?Hmse2drvU2l5epsrrCuo6FCQsDfN4Mo7QHvwoILrh8xDYRXCG/IkbrxespG9?=
 =?us-ascii?Q?eR4TFfee1wO3ywYJPILj0U5jgj3WwHMGZMvh5ppxz9MvJzaO7+FGyhB9+//f?=
 =?us-ascii?Q?JQNbMviBLmS6efVfUuUuHeUazEnh1p2YIGCCl+XngFikImycQpWRGtikfzfe?=
 =?us-ascii?Q?Js94JCEPtpQjVuGv/j7k3O8K9dD1tG2LKNMaAoKXOI8zAQZb5is0T6rffHR8?=
 =?us-ascii?Q?EK4CvWc9zQOjZu5MPJ4br6ztVOnvE5s3ak340fjujAJV0lwrY36rCqbv3AvA?=
 =?us-ascii?Q?DFCzg01abjR4zZErz3/AEhswc+hAoZKNaDonQ2IyeoSGEvh3FmoHx0GlmFGY?=
 =?us-ascii?Q?3e4k62JLr/8EuXmSO3KQqZlj8fwgS7a8UCGzsw9MgbRILU+9CcuMXpGlz3lM?=
 =?us-ascii?Q?qUGyM826UEVmIuoWocZrsLwdO3/t8FO6eYdWe1t4KQ7L2kVsOZUX7iZE70N9?=
 =?us-ascii?Q?cVgZo/TGg6YYmU5cZNBzVmcY3kkRM9oPBkxLji00gi4Uu+DmZJaHXcRYeqOQ?=
 =?us-ascii?Q?y26xCvLh4ZpXoBY5pLoKhXqLtWdVbZj7oPCCC5GoVgbpKJR1wA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 17:37:27.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38d26cc-8673-4224-2d45-08dcf2c032a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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

Flag KFD support for per-queue reset on GFX9 devices.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 ++
 include/uapi/linux/kfd_sysfs.h            | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3871591c9aec..9476e30d6baa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1998,6 +1998,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+
+		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index 5e8d28617efa..859b8e91d4d3 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -60,7 +60,8 @@
 #define HSA_CAP_FLAGS_COHERENTHOSTACCESS			0x10000000
 #define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED			0x20000000
 #define HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED	0x40000000
-#define HSA_CAP_RESERVED					0x800f8000
+#define HSA_CAP_PER_QUEUE_RESET_SUPPORTED			0x80000000
+#define HSA_CAP_RESERVED					0x000f8000
 
 /* debug_prop bits in node properties */
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
-- 
2.34.1

