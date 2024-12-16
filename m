Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C0E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0021510E55F;
	Mon, 16 Dec 2024 09:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ppsRx9Zx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E56010E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNcIjlG+kYiFpmZD9QAVztLvyf1ny8dL2bSWyk0rI8W+0FRMeHakerNKqjxxOur0Wl4XnBDb3G9QlEMyJZcfNo0fN1eNjL0Oxw5/T04z98LPnRI8isTYrOdJEbOsoSMO+UbLD2oXXsaDYUKJLgKcQXnWezCN1qkEjR8KAf2WDbaKUKEKOvMTeSBmo4fOICriuS+AXhYmU2dGIHNvuXUf7bUT3OaiKNnjGHkjy4gxuhwVmUHjCEwjcHQBcg7ABdhKjFGDgdd1aaprgo/emHdm4j549PeN06uNVLOzsBxhaciDAVzi/X8Ii9BR6UtSzHYWx5G0Oglq/bxmzBUCRTUHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWuATZgtIzhPfNQm1NY20/gpLSgFunmtjg3ms5gqmXc=;
 b=XD0/7q1iRKG7Ro2esfGi2Zur21bsCqARGfktbTk5iwaV0AaztV5SFNCrOlZJRJ6FqckHG/BxV+p9sX2bptxVkw3caVsoDuuunkSc+jGIivvLXKU9a/WZ60h6ryoO7IxWQKaIEjVNCTS+s00JR2/FjHHbZKx6GNc3zG0unOF4YovG5dmpMhhgoZ+lpaTCOt6P/If3+AqSwCPcEDi4W1Cm9zfXHms9XMdQHMDw1p+Gx5z8J2ryFkmOlLSFe/jLLE1y3oJR/LBxH3LWqeGiny93i3ap7Y2y1rh0WbwZy90F29T32vLppayGNdHuoCFUqnoBCXXZeHr3MelieSq56/EoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWuATZgtIzhPfNQm1NY20/gpLSgFunmtjg3ms5gqmXc=;
 b=ppsRx9ZxiZ1dUCiv7tAhlN5O0/549z/KCymAGFn7bzpsfX0pOAEL/F3vyQU9mAs/0lCCyt2YZTptWPaVRTYhv1cd55R0WLjrk2W+rBlA2t7wOsdoqauR7OWlkXAXbEE74rmOdt82a2RXsywAAQa6MziMWLWhSAX9SaJFNJRFYMM=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:29:45 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::9) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Mon,
 16 Dec 2024 09:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:29:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:29:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:29:44 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 16 Dec 2024 03:29:42 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/pm: add PPSMC_MSG_ResetSDMA2 definition
Date: Mon, 16 Dec 2024 17:29:28 +0800
Message-ID: <20241216092929.105280-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216092929.105280-1-jesse.zhang@amd.com>
References: <20241216092929.105280-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a34fec-c5a3-4cc1-dddb-08dd1db42d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M3Z8Cg0jeCglkqQwS/qvyI11zaL6SQHRXeluaLjQow7bL1yZqLimNdZCHFkK?=
 =?us-ascii?Q?hBYOhqopB818e0lr+QhZHONKk3i/t+F/epU9wH9oRumX1dqoHNmQXdewgSZj?=
 =?us-ascii?Q?gS57qTmxhDrvo1AOJCFEmM30s5pk/O1NgRBDdTrdHt0BlRQ4qKMxBiongjyE?=
 =?us-ascii?Q?32Mxq0+9Q3P8GhpbqN/W6as5QsWJQlS9l73+5qRy+97NPhHn7fdaXjK8KLDz?=
 =?us-ascii?Q?GptyHj3ts9ZqxBcjGf3SQKKVHVrV8T7wUg5WZq/As4Utu3q+H++5oMVwL3/s?=
 =?us-ascii?Q?9wlGv9+LHin+0yl5HWRWk0WBTHM0KkDc0Twk/IvcLViH4Dy4wxd4gdsCBrX/?=
 =?us-ascii?Q?n8s5I7qw3JRPBIxPpjdIesIj5bRaGhX/2IOK0MndJr1kbmvOX55BFrVmBKnX?=
 =?us-ascii?Q?EVvZ+F6JtazvGLyP0XMh65b0S6yeIousoxMHDVKoTuVRe+C7+QjcuMo9sO9y?=
 =?us-ascii?Q?4gwsCq5By3uBwxCgvKt9opGvCFJsXelhmYmlRikK/TrrJ9p0nzFdqV3rkimf?=
 =?us-ascii?Q?aRu76ricldaSwT9k7utYDzX0+VaEc6c6Twte455J3Nk5J2LRe857xZ5S2T51?=
 =?us-ascii?Q?J47rWVf814aFfFj00cemxWiBEplX5vskdtUkzUyuC/wLXhNtMQ1F0VRwS8WG?=
 =?us-ascii?Q?pRmLGOVnfEeXiW72FcPo6oTMoaAChBExdUHoc4GtXyJu33vuNPHdSPQQfVrI?=
 =?us-ascii?Q?vvf6mNtxNNO3hE0MEs+fcrHS7VzN1i1eCfiLHc4RqstCsySeRaJw+ZDfFqyc?=
 =?us-ascii?Q?ESuD8979uSxnKZrBq6YXCwgugYHcGSVd7f9pj7joIJSTzgIDkFRphLW7GyiW?=
 =?us-ascii?Q?1VR776dciOCVTfICPjlzjK9WnjD5BUvOQXdfgvemor5JDIfRpCTQ303499tH?=
 =?us-ascii?Q?4vZM93RlEPHUd85fu/e2fd68iJcHVk46+GycukJzfC4+q6FrPzWc6UWRa4xC?=
 =?us-ascii?Q?IgR4GkD1gjJoK3TrWtdLdKnkoUtZOp4uTCpRXSlldJ18vO1ZUYdyjhIPAVEA?=
 =?us-ascii?Q?/SdI5Ff5RrSH98O48nPOXFBP5/PUD8vCR6ATVZa6CgTi8A8I8DOv3iwliQu9?=
 =?us-ascii?Q?sccyh07xbwD9oPx3/Nszdc3isWRsLju+n0IQerG47FoRwDs0GGRBzlETRmMr?=
 =?us-ascii?Q?hLmUKcswopgegq4XrRWrepCLjVenQDjrwxF9mWuACrHCiMUC56vwYtIRGFVe?=
 =?us-ascii?Q?OMdUlTkbdyI6jMpi8o2mZEVBZJ8HYZUXHSEcSNdeCrfjXfsWKim7HioQ68Es?=
 =?us-ascii?Q?OZKgzXS7SX1B5C9dLypWvzHMB4CsUjguFDr6aR6Zd1QVDBPwV1R54zhlQpoc?=
 =?us-ascii?Q?hYkVH0aRX92RVX1CkMy6w83ywkjT/Z66k8tptIs9f3bQt6ctDL0bam61jaGr?=
 =?us-ascii?Q?KJjuXQjuX01h7pujs+2fk9VxfhRNiS7OyE6mgeo3IN7u7tn5r7pXtK7U/ql5?=
 =?us-ascii?Q?Fn1rX/GJPlsFosDsAFHUad0kWHANR5qpEqAw9G8w+v/nVlnhCt05talQrRRB?=
 =?us-ascii?Q?R4dhhyvCmbv6u2o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:29:44.8928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a34fec-c5a3-4cc1-dddb-08dd1db42d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

add the PPSMC_MSG_ResetSDMA2 definition for smu 13.0.6

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 147bfb12fd75..7b65a27fb302 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,6 +93,7 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_MSG_ResetSDMA2                        0x45
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e4cd6a0d13da..b0dab9797c70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -276,7 +276,8 @@
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
-	__SMU_DUMMY_MAP(ResetSDMA),
+	__SMU_DUMMY_MAP(ResetSDMA), \
+	__SMU_DUMMY_MAP(ResetSDMA2),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b86df0c8536..9222e7a777a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -194,6 +194,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(ResetSDMA2,                          PPSMC_MSG_ResetSDMA2,                      0),
 };
 
 // clang-format on
-- 
2.25.1

