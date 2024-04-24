Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44080C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A993011392D;
	Wed, 24 Apr 2024 08:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndifNIsD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58BA113922
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XARXOKQtGsChln6s+yIrsVQCsWcepEibnw4JMgKwr+eEnlNboF7+ir0O09zwMaz3bVANm5YkRqiCUk2Me2Ki5ilbdbUv7cqgpoKFhnXi1WsS8VQz+QRi1DrVQRoImtf5y3qczBqJ1hJDm6itBDRgOUViNrc8Kj45SQpg7hYX6KjO6uU7QrQTiFrmkVh1B4TAVHult1bsv+aH9aacOr6c3+RpLsnfSIWHW48Ocjzrq03iqW3h1N6RiHcS5wWE7DKYIrPCTdw6z20K7+nm2ATzvM4mzoZQjEIxVtbEku1BVdzGLvOu3W2IYC4QGTbIK323dpddoLWoDJXs8Nko2QRbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BATmrmtFa6qebfCet9xJknDoYfQRW6f1bTbzyCwQcp0=;
 b=bY36Lg+UBVSN8/x28ws0i+X4+8P9avjf4lkYOwmCa1hvjctfZOkk5MVxxCnuQViTqmlplS2G1WZj2vLGoa7UbfcPl524IL3peTUu2FvUNDqdIeWN+q9VSPv5ttpnTbgwaT9Ri2mWSClg8kqCCOwhC6qwRzZinbiU+ZLrVMfl/fp9MyXvmoQ7aHeegSPG7kVpcNlgJF4obGbfPc43nWQRIduOcBdzpFg8ETqWJmfEWMfAuG/uaLu+txGLU8qJqhI/z6T8py/INXlaHlfZ21KNTjjub8dWKaVSZgqWQrNKgG7hOnHdsjtM8b70Qu4nb5jcEt1Vhj0Iy7xIdhLGTpqtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BATmrmtFa6qebfCet9xJknDoYfQRW6f1bTbzyCwQcp0=;
 b=ndifNIsDdtOYCAlwrXBoM+mGDljix9qCTeYkjeqzrDrDK6AhFMAzGsKvQ/Vlr7ryXIzUNHBvC4g09C4mU06SoZWbMTSpw1RJf22Ceh9vjqYqicHoUe9cSoN+LXjN4RElAo/qBYP2ekS9AbwZr54SEZcXT3O4fcqRmXoE5uW243s=
Received: from BLAPR03CA0091.namprd03.prod.outlook.com (2603:10b6:208:32a::6)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:40:20 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::72) by BLAPR03CA0091.outlook.office365.com
 (2603:10b6:208:32a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:40:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:40:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:40:19 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:40:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 10/46] drm/amd/display: Remove unnecessary files
Date: Wed, 24 Apr 2024 16:31:26 +0800
Message-ID: <20240424083202.2647227-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 549c756f-6e8b-41a8-2419-08dc643a2ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?he2y+3wiSXl9FJguOUTWc1CmGdugvl9vqZGkCzblHCqtiWuyvs0rVlH5666t?=
 =?us-ascii?Q?r7daudFVxpYUuOemOaHrGX6GxBOcQvSs6MxApXobuzsmFSv84mVIuikqLhf2?=
 =?us-ascii?Q?BHEzfqSrUxJ4s922OfvpPixqBDW9QeC8tR5ac8kSOczZZx6mZr752q6RGph8?=
 =?us-ascii?Q?UUSgl2s/c3TiqM8hxP1GN78ozaDvA/u75GE0BI4fwNgAH3HTAwgZgVnvrwYy?=
 =?us-ascii?Q?lukrdykFycz398sVj9zc9ahVTj93ZgCQ14Zgkw1NrVn9Tu3PC/mZxC02aDfh?=
 =?us-ascii?Q?GeZE4HaMtIVvH0lRv2KPq3+Lq1wgfeNTaD53VUk4GiICsAAoI9DwTlqVV5PL?=
 =?us-ascii?Q?nDuiUuM5O9e8+3zgOp1xbsI9uzlKD64FgZI4rAJEmdxMsqpqbJPaPrMdXeVz?=
 =?us-ascii?Q?KVapjlb7fbTgyj5L0DzWX/g4n6XMr+pQ5XRsG9fQo4ufu7ZDvzT+V12DWYoC?=
 =?us-ascii?Q?xfpLoy0VGa4J/dGms86BhpQXYPzjN+/WrTuAmwQDWPUga/FyOsF5VGFWRWf9?=
 =?us-ascii?Q?UWqeZep4xoflrj/aKXKsWyC+wTMBh6xxXSlrDJvT7tqzlI2Vvj2tJC2kz9nf?=
 =?us-ascii?Q?7kGimRIUiqn0ul7seRqkAjvi3wJpkMHYYUoBXEorqEsC+Y1Fk3uYIn+b9HJS?=
 =?us-ascii?Q?5VduC4HfqF4mfv3tPOJbRo97fcdM2LXHzcXUSBjvYxMlGwIJHQZBIDfEobD1?=
 =?us-ascii?Q?F2TSTgzSbVre1MLj6i9H/eycWSlKavHprQkpWE8rbBmYiWnaNqyEx47PD1ej?=
 =?us-ascii?Q?StXPxRxZFrHLEGTc4UZ6nL2s6PviWfjqkTvJ9hP9z4E6oCcpzYkAbELR6ap0?=
 =?us-ascii?Q?JXdPT/GeA+lc4E+9GXfq1RG5I2vd4gJCwSC3Ogw3ohmYJjR9g5vIlrz0+WTz?=
 =?us-ascii?Q?erERN95fvstDE0XOAwBab9CMv10Q7nRwoVPOsPjedKf+3WY4yZ+ITB9K6q+g?=
 =?us-ascii?Q?JNWLj/DJ1g7yHFNk66Eqm/eLdDUH7wvQrgqM4rKttGB+caHwEJ8Yytmge8Ot?=
 =?us-ascii?Q?RhTpykL/vooNRBkdt7T5YZwzFX9yklvH3iUScaJAFoC4GtA2ecrEOSV+lCH4?=
 =?us-ascii?Q?333lPgPBWwoMSogug0O07RQ5HU58eYm4ddJ5eFANvkMh2UJmSEZPRtvqfecj?=
 =?us-ascii?Q?r2uB8lOAXCVbmNyBTqSaALnbKLFyC01VruM3HGmEtxvEUs0QmXSsvziFq3Tb?=
 =?us-ascii?Q?9RBgu4e1db08d2MekmACHGb2G8KdIcyPsqy0+OWLDODUfhqSYMe9u7J1ztri?=
 =?us-ascii?Q?W+0jRT/mWB7CnYrBEmuOIWFldwM8HsI3EC34GypLK4keAa6DjIAYrjmCmCPj?=
 =?us-ascii?Q?gfgerjRDzV+OHnN1cedsJmpWjbrDz0GLKQFeziABaTBqd18D7CHqBrvTvoPH?=
 =?us-ascii?Q?Tyxlge0aXffy29eGU3S1QI/LLL3V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:40:20.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549c756f-6e8b-41a8-2419-08dc643a2ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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

[Why & How]
We accidentally upstream unnecessary files. Remove them.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt     | 6 ------
 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt     | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt    | 4 ----
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt     | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt     | 4 ----
 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt     | 4 ----
 .../gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt    | 4 ----
 7 files changed, 32 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
deleted file mode 100644
index 1318c6fba3e7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-dal3_subdirectory_sources(
-  dcn10_dpp.c
-  dcn10_dpp_cm.c
-  dcn10_dpp_dscl.c
-  dcn10_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
deleted file mode 100644
index 9c2d7096348e..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-dal3_subdirectory_sources(
-  dcn20_dpp.c
-  dcn20_dpp_cm.c
-  dcn20_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
deleted file mode 100644
index 7711cd3c47a7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-    dcn201_dpp.c
-    dcn201_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
deleted file mode 100644
index 0faee2a1e32b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-dal3_subdirectory_sources(
-  dcn30_dpp.c
-  dcn30_dpp_cm.c
-  dcn30_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
deleted file mode 100644
index 7743edc4599f..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dcn32_dpp.c
-  dcn32_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
deleted file mode 100644
index 91df5db26435..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dcn35_dpp.c
-  dcn35_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
deleted file mode 100644
index 19dd73bc9ab0..000000000000
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dce80_resource.c
-  dce80_resource.h
-  )
\ No newline at end of file
-- 
2.37.3

