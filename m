Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B48E77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5127B10E2D0;
	Thu,  5 Dec 2024 17:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sHIouPeF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7521810E05B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avpN5OnuJIAav5JwcWC7BCY6RAz9tt4Osr3pWKGzYxt1F8Cutc8oAW9+Uk2Y/cvmD7od97Lc9SNj1LcS5rO/A3yTC1zQ/w67upZJd+gf3LhZJki6OhYPa+84Y1FZHYMWCemuZMdOIra23OIDJFjG+KgEOWASXGN/hCm+pPn6LyWi/QjyJvjXrPDxmM7s4qQa4BOCdu2W891jzhQa7ssdV+bjNU/W1Y4n/Qztqcvy3XMcEcA1SCZuFyr22ZpkZONECJqDWdw9QIR7MY0m/xmd15yU7C1yfxPwo99R8RdJAqAoyjD4rC92Tdb1Tj1wh/E2JBd3U2psXgJD+1q7i9sT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCPiLzY0bA/0TwUYrc6KpfTZ5aI4eGptR6SQHvrFKuc=;
 b=G+GKNKmSwnAw2YUK/pAsMIaZT/LRfC5Xph+qURT99RaZasZ4h01UA7yJGHzxOwXhWnk7VnqhGwBjl4LvroohvOutuHBjARfTJ4QEHAlGj64mIfdq/+CLc8104CpXnnNuQ3In43gs1UjbQkUdB0Y2+HV0O2RNf9Hv0E4aO4JMGRu2QlcMeNFLXTg8rQqZLPwQQk4T/r65QJmuyYnbrLGBdV+3mSBTmz5pwJUjSBBNaMej3jnBrTU46BmtUzgpAp+gISfBEXjDmN93gcct2iYyKJvSi+obXpLL8KrhbPEcKaGhz/dsFFe5zrkCEdLdeRqzyYchWrK4VaBjdZ9ghl11xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCPiLzY0bA/0TwUYrc6KpfTZ5aI4eGptR6SQHvrFKuc=;
 b=sHIouPeF1qJd3QvmYhi4UE6HWW+TDPkfgiXL6Z2IxS6RCaeV0Ei4k/G33kdF+bb0JFYJF7EyKie1lA5nnhuT0iNMXhY3MYqEfgoPwU44/P1g9Q7t2ClOEGw4fZ5QZ1v1Qjq3O856SV/OY6hqj8WOq94X6MVECyDCr4XqsigrDZQ=
Received: from BN9PR03CA0479.namprd03.prod.outlook.com (2603:10b6:408:139::34)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 17:36:28 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::97) by BN9PR03CA0479.outlook.office365.com
 (2603:10b6:408:139::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 17:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: Add VCN_5_0_1 firmware
Date: Thu, 5 Dec 2024 12:36:05 -0500
Message-ID: <20241205173610.334358-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: fe41ad6f-cd51-4943-9273-08dd1553596e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lMt2+yM1BzRtmnrOLHZCI/BoHnjhm+Ywqfl76Lv+KILMQ87ACKQOpL40K0yE?=
 =?us-ascii?Q?6gy2CB/cG0unrcG9Ma0pzWMY4+e2nIhHzpO2dztsK+0V9SSLyCKqpcY1/eP1?=
 =?us-ascii?Q?11wo/WuSmWDptcNX5PE70xtq9zGcWXCWtxkSig5vUUuw8Q51WWA4JuA66zZZ?=
 =?us-ascii?Q?DwvipzgzGxXVI0EfbHlj+fNbpdJsKY8xob5qp43aX/0LQoT0C6876mjAICiP?=
 =?us-ascii?Q?UqXRMciyg4Yf1FaO5PCaCWjT80TKC0PGVQizdoIgG+C5vpvN+efN/9SKick0?=
 =?us-ascii?Q?iI7PQskAO6ClSWnA7AE+kewjFB7ZyrA/d+Q1Pdlt8AXeDmMPre9rOwHjgB46?=
 =?us-ascii?Q?8DBbgPJhG06iKBDKKsPoL/IFvhPDl55zi+zz2NMUBGkc48RKferTjql8q5ah?=
 =?us-ascii?Q?HSVMfPJvmY+nqIgPilkXQyPbolcdbTU2rG9cZYsnJYspoE4afS0p49c9lwoa?=
 =?us-ascii?Q?jvX/JM+jcvYS0j6HaYbzyLPyGDSY/773a95J73rnErlGJFLI3ykl12cRSSbl?=
 =?us-ascii?Q?XiCnzhW85bgat0twOmc/0cHDBcPdbzV6iLkGiUHIJ8AuSKiD4JOTX+H67d0M?=
 =?us-ascii?Q?GfID3vC4Ta/zM7QAr49V4eqadE/dqaKfCMdsvRsWrX+ubbZG4wjVDd0ysxh8?=
 =?us-ascii?Q?iaQGJZMA4W3SCFU+u9gxxYvFT1mRyOzZIIYgkNhS+4XILPMQHl0U+aVJgKLD?=
 =?us-ascii?Q?kbKf8lTCXen+EY9rQ9EobpTp7IW/vdZ7P4IPm9xZN3XFHPBaBfeOGO7YUzV5?=
 =?us-ascii?Q?3RC/RlSMVzzkyEd920qXKUqlQgag9XmfGghhev5YLD8oe4MNBuzrNjuJk/Jf?=
 =?us-ascii?Q?npim7Jb9D/5hI6yjFVRhfKOv8U2mwbdkcP4dpRVmnVjr8ZJBohtwCwfCt9WS?=
 =?us-ascii?Q?2j/urYGXSKpof1VSy7GdNQxdTFVHLMUzM8j4cBhy1qZQdI4+RUvjnOfL8YUw?=
 =?us-ascii?Q?TItm/jAPCsYGI6CTtjyNG9lU/K1yMSWnni3ASePOIm9J/ex79bx/4gPdVcbM?=
 =?us-ascii?Q?DH/xYMROfeoqki1x9afT9v+RUV8qKk0q0i8QmmsGxFYNqMFUxfKHnSl748ut?=
 =?us-ascii?Q?3Zjmp8me67e+rxU+z1Wwnr3pywoNyhXaJZ6S0/4yihfZvkgbZFBvBDX4ODrR?=
 =?us-ascii?Q?6QVIUgNxvCqtzIUNvVR32hOENiQ4PmT1jckNvKDxcimB4hoCntFCh7ge1UaR?=
 =?us-ascii?Q?gg8hkCmtjZ1SMjorsnN6reDxIjWo/3bQCaaYCvfBImfd3Uw3wGfjmYoP0faL?=
 =?us-ascii?Q?dYW1KWL/E9ucuB4qBsfSz8h8nqvoNPCWhG6l7ASuTwbl5RpvNm2ihHZ6ml/E?=
 =?us-ascii?Q?oy7NUwBxa6WP+KK1X3778UFPBgtbCliz9ZpII6G+tBLY7BdVKrktpABZUDyS?=
 =?us-ascii?Q?EeaKmSqp3TeWdWWtncEE0CdVwBFuw8yCgRL51c4JO7ScaSCfK8OnV2mo3lpk?=
 =?us-ascii?Q?97wxLLTF72VgivMh857nL3evjwhwWn5o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:28.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe41ad6f-cd51-4943-9273-08dd1553596e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482
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

From: Sonny Jiang <sonjiang@amd.com>

Add vcn_5_0_1 firmware support

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2455cc126e591..e1101df541f1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2024 Advanced Micro Devices, Inc.
  * All Rights Reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
@@ -62,6 +62,7 @@
 #define FIRMWARE_VCN4_0_6		"amdgpu/vcn_4_0_6.bin"
 #define FIRMWARE_VCN4_0_6_1		"amdgpu/vcn_4_0_6_1.bin"
 #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
+#define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -88,6 +89,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
+MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-- 
2.47.0

