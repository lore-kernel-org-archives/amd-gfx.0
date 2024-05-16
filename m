Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755ACC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B393710ECDA;
	Thu, 16 May 2024 12:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVpwPihj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD0310ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNWuNA3nRwb3/KAmeLFQfHsy7gJo5ZQRgG3Vv4/AKoea3VljRoBD7G+pOvRztF/H6BUc3fnjbO/DJn2Uqj8KxomlbxBxEodTpS+eDj86uzHnY+k/BLiLf1QLOl47Sn+A2b/hCR3qR4+oFa/JB9aetytYvVO6PKKGZK/Ljs4UiM81HoDWRPjJXvO/ZuQ5pVgZOFUyVgBra1voNOd8YE/euM7xvtVNV7q6Fzls7P1hsOI/e96Wx3a8n+IUW0MfK0oqpsfE7QmNkVy+2fiW2tXN1vcVLjUV/3yBqxqp4ztEn0SQlT+Zcw17R51iw2pP7/HuJBfNpYu1+Exo1ifF1HdgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jqXyJvpu8/jgY1b5k1Q+K+tcaQlpbsia8zzveHUM4U=;
 b=ctikHkGKgmyLNoyZFspsQCk704l6rU1Tk5n1BIzb/pj/TXWS+JkkJ/B0vYGsSqL51AbTj9KyGKxPaCpDDucHj6iCVngzwFrRH99RgRHJl/9erOODJTbbmq+nBozun73VNTWfXipGg1ZyQvfd97UnMTiZ+Qqk+2XnFsGxshagpA/j6wS3jflH3Gub0kBvhI0Bymrh5rlHdnYhzrytgelSD24qmi+qwLqYJRHAO7iKHTtUwYHOjwBbqfpqDmbUDTfuTDYxpW/S5Es+gFZyg1En6CSSIFEXsKX7CNgRVWQVqzJqrvnFPhOl0gImqhblA/p0Y0J+HcnmAuMxvdJvArxksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jqXyJvpu8/jgY1b5k1Q+K+tcaQlpbsia8zzveHUM4U=;
 b=sVpwPihjLomvIjJ8dIKwETVJdd4Uu57CS237Kmb2R5t0OJuPNRB1TpR2HcspWIslimk0+Nx4lEJtPZiMe1VlnXJdGjwqiAndftulifQs6BQ0RUia2DJmm+uWLwuWBA8t0EOfspzMu3bdVLdAOlsPhmVjkIOkdmtDedo/r8ZSDKo=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 12:43:42 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::7e) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 12:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 02/10] drm/amd/pm: Update PMFW messages for SMUv13.0.6
Date: Thu, 16 May 2024 18:13:10 +0530
Message-ID: <20240516124318.508785-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c18595e-3447-42bb-ae17-08dc75a5d190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G15/yhhJlAQsgXruQwIrerupNUSNf+1yQn+5w3EHVgoprO/tW4FHIJneoiXV?=
 =?us-ascii?Q?i+Pm7Wi0cwU557RoqI9Pa6pz3hka9+lCGBUH8ICqXPBmWRwDMKSwJKuk2Ko4?=
 =?us-ascii?Q?mbNLEnTxkVh5aLnFkJyGBcs1kz6KQeFXz5rVeFs9H/vrxWu5HN1nSjNVJfBw?=
 =?us-ascii?Q?+Da4ppGyQk4luzPtm12ydlWr6zTFoH6S+RHfFF5LNE6Ci4GgtTuw7VwxKa/x?=
 =?us-ascii?Q?7YQc8SMpu1dtmS4qW0Uj5om6S39mwC6i34Hvxd51ucoHCx/Lx/d0rgiSMr/X?=
 =?us-ascii?Q?yQ24XYN573e3COzXpn/Z8pb07Qdz73PyI7krf+x1LuzH5tefcHV1oFKUwXHA?=
 =?us-ascii?Q?bogH2f2EGDuvoTHsCDIQ16Q3i1aU044jrRaKg8WI5AqGRJg1/zt5SEDhOEoi?=
 =?us-ascii?Q?eSxLlIQ+f91b49TqVu+jPGfZOdvSzdcS0rX6WS2ZNz9T81pkib+htMMZTBKB?=
 =?us-ascii?Q?4UxIg0mWeYS5sjyr1IU8tQ+OwlIzDs3+tTORsbxnwjLmi0QMzGx70Kz0Ug7m?=
 =?us-ascii?Q?mn1qJ0p20tscepx0+M/ooI8/f03JxkaxZ+xzVc11aiQFb0U+SQjyBNeiOwDv?=
 =?us-ascii?Q?4mot6EvTlK8CVSGlW93u8RxftRORlkqY6X7UShvILK6CTvZlw9oEGoWL6x8l?=
 =?us-ascii?Q?MxjuayJVIQsE0inSpCUOlHhEzBkDignx+aOLw2nJMUpZ0weGIxGgTkm31DIJ?=
 =?us-ascii?Q?Br2hWSIVFO24S+9N1cKreNw2hi2OKydiIuvTVQlmvuOT0Tv56uhrC/y9DP2O?=
 =?us-ascii?Q?/i6b2+OBj6MD2EvASPTUhUq5TKqKWjfaQk9ymcNAhWGVTaY5fTOEr8cigdb0?=
 =?us-ascii?Q?yvEnOfLzPERBPpAIzwp0w46yIZ4rCrVUikwOpbh04Rg+TXwiRKyvk55d9gCD?=
 =?us-ascii?Q?N6jX4bUD99BvTvq5u2ljvyZ5l5d9LXcHJu4bIyJqX17BVLbwC8e3XGyXusOo?=
 =?us-ascii?Q?CxCSqBNCvQPWmU+FjQL76Hkb/KzQ1a7x1rK2D29upyQU5vh8HkoRyagVx91F?=
 =?us-ascii?Q?GM08wygfnF8u/nzIexUhsOGtfDyQiMZSBq0CRbSoQvUZAd10gzTiRBowZ3pN?=
 =?us-ascii?Q?0FIHzblevuYxAi2Y+7wcM9EwTAMKkNsCLVwXdAqTymS4afilnEqkD/Bn87AY?=
 =?us-ascii?Q?CO0/Fdq5VyMOifxgCFrbxBp7BgXaz6i2xpyyuDG0pjbIE8THAxooVxUwWpix?=
 =?us-ascii?Q?RFkrEzk6TTT+Bq5JQd/3CBG0w3qiEFqc1IpXnUPaPOGOA1fsMTfM6OY3RCaN?=
 =?us-ascii?Q?OckPJMrblPLwBOnZUIEZHibD6S11IMsTqWu6Za26c6dwcXBVFBv+iex6HU/c?=
 =?us-ascii?Q?Sl/rT5d0WMMpsCqfChmu+YiiBjzdHZow8ZlXNeVXsknGEky8E7QiHcrH8ogW?=
 =?us-ascii?Q?oB/Le3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:42.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c18595e-3447-42bb-ae17-08dc75a5d190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

Add PMF message to select a Pstate policy in SOCs with SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 86758051cb93..41cb681927e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,8 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_Message_Count                         0x44
+#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_Message_Count                         0x45
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index c48214e3dc8e..dff36bd7a17c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -272,7 +272,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
+	__SMU_DUMMY_MAP(SelectPstatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

