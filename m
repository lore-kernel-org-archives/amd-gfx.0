Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DACE77188
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 01:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4C010E467;
	Wed, 15 Jan 2025 01:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oSCjJVNK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDAC10E467
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 01:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvKhsJTVOay/qM28ihsWIgkUYGU04efHvy81KEkwQCkz+utHh793zy3Th8Mk2kUnA76WPkyiYXc8ULrd94LTPgIpGTdC+4j42XNMdfwJlwGCb420G7v3DIdErBLnxD4r4SXF8AbZ5Otr8ExcQS4uQHFkJG+Q4KazDyrb2Z3WAlE35LIXnb0hIVxE0uDN5qBWjnnevkafNJ6DH6LMfwf3qcDaebnEPhimnRgqeWTVIqGPmDp8NBFWSMWeKp6epfkfivewoErLqjrvtoXyd1hhPavogS7tOPgXskCq62V4+uDvr15gZhMqwxnC3SFtKKKybVwCWa6F5YYhlkd+Em6ZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFXNLJWwaWGdFrQsBXKGZxhbEhqXMjEr0ZXJw2pOHxc=;
 b=FrnEyWso80967gVl8M7qb91zdnNHmzIIrJaCaNFeYHo5mOSqT53Dxh56tKdQfWB2XEaZTMRp3LUzvUa6eGdeA6ImX3GdrP7yBsGMEAeBMYDra/ib1JDUhU/1fOYmWkNachvllHgWJh/dyiV99/6aXbcgT2hDLKjlkxvO0CIL9zojyeXkANeJlTB1LJnjKRARkSL8R3oUUzc/q4/0ee9cO8lREFrZS74UiCzJBkgD7T4/tohvGooMwg9lSxNPjooHtf3zXO3qP8Ww5vLY8YDCD0CCO4U2DN0UG8MqEehRyAXuA5YvdF9rYp8t0oywDkLWQK3IYcU+D1oUeq2KamVjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFXNLJWwaWGdFrQsBXKGZxhbEhqXMjEr0ZXJw2pOHxc=;
 b=oSCjJVNKBaYMoOFHjSD5hjiewbKMtppNTqQRGrZuYOBspNS9oWXyE0UliMGryrrNF9Q+u/ES0lg4sRmQTbBbzmeqdxYAdOqV4zBFnzSCVn/zjPza/sMNth08Jcw2yOHn9cQZK80d5O2cOquKCi5NFRa8i3f2sFNqgYQ65EQSLTc=
Received: from DS7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:3b8::30)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 01:41:14 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a7) by DS7PR03CA0025.outlook.office365.com
 (2603:10b6:5:3b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Wed,
 15 Jan 2025 01:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 01:41:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:40:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:40:47 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 14 Jan 2025 19:40:40 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] revert "drm/amdgpu/pm: add definition
 PPSMC_MSG_ResetSDMA2"
Date: Wed, 15 Jan 2025 09:40:33 +0800
Message-ID: <20250115014035.3681642-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: b018da16-590d-41f3-290e-08dd3505b28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dIaoks9kI7ECWHPcBxpXjvSeJaJFCh4oDAkduGgWSx+oR42WOf7lo+iMVX/+?=
 =?us-ascii?Q?GcvhQE2MrF/9+BOORoCX81+5IqCw+2veoEUsBtgzsdwan1SDUqSUGpFigPvo?=
 =?us-ascii?Q?M0IdU1R31hTL/0yWVbSGlWI4tskPmfuV8dcqKnYest3D2TCf7+3usptxFnaK?=
 =?us-ascii?Q?UV3ES+7gle2c7+TSttVnDPiilxoKx/Kf1E7beIRRyetufe9hl+mB2nz0jRU/?=
 =?us-ascii?Q?s0SxRodFGx8WizSe8GT+nqmG0cQ+wUlNA28NI9HWoIcBY4k6W3POG5/+YlZT?=
 =?us-ascii?Q?GDNis4Cwk6FGmGdP6vZg7QpWHihLrVL5aSJ2WcaRoj7jLhuwJzoLBUljjI5A?=
 =?us-ascii?Q?8q9IcmqY8D5tsKj5quY+bI1y5ST3Q7vQa43lrUeQ36ara8OdWRoTTuaD0GuV?=
 =?us-ascii?Q?EyVIEUBYTPofuQ00qFZ35Je6wPFq/dy/Sv8itrj/SiUJQjDneFu0oireYvxa?=
 =?us-ascii?Q?V3IQGX0W3vJgAYLrNTns13NYrsmFfQZ4l/WYGNl1hSiuniIbX2LLP/O2p1GZ?=
 =?us-ascii?Q?7jFTQPXqyGFZ+GlRA0rDGDcrFLA5MV0I3TuKGHRLuYmoil1bTBzCN4WQt83d?=
 =?us-ascii?Q?3KLbNOQdeBglsTsXfCyy3Xly3zVVi05P3NguCp6d0+C6cz0zW1acD+CT7Jwt?=
 =?us-ascii?Q?rVQQw+waHT9rRVxoRT2KhyGSbrSD5p+ZCYC7JzFDajw5og+0ZlpUnegioSej?=
 =?us-ascii?Q?OUBLgKIdSfBnmLEbQrhFRW7HCc5hDLoBgFIkTzMVNxRPEYC9s+11ZPzizr36?=
 =?us-ascii?Q?i2CYvypf/OcotndSdccVGHkKpo2LTri0Oly8qBWbpxYb8fbszIvSWdZIzkRp?=
 =?us-ascii?Q?sSkLuYB01u4EeztLDI9yXpTYpBwCDNRiSjUfGP7Y6mLcGBPSV4iCCzmmrjZJ?=
 =?us-ascii?Q?uDq3cIoAjTZ/u8p/7pTmZJydD6uYMdmizLqi2mQBEl4+dnfni71XPySr3htN?=
 =?us-ascii?Q?dM30qo2tMGFxE36HnO1FmjOi7Xhp3H/vnNtocjAGNHxfCMiXMSKvQ1tC3VwK?=
 =?us-ascii?Q?rWyDtkMAJjvrwLlRIleP4BXbtD81uDoori8T68wxg3rxQR2dS5D6NK5TNueW?=
 =?us-ascii?Q?Q2bU7Zx1KhkJ+7ln/tR6axQU8h2aERuNfVfdxYRqosKltOwBhHe1qc4gxhV5?=
 =?us-ascii?Q?yfzPEcQVbMT+BOp4Gh3Z6Buc6V9PV2iehiFLr7IBHkq4hq4fWhZOSMsgsgeO?=
 =?us-ascii?Q?wz+2yXm5OpG7iaqEn0rFaHSdy6pJrAwrvqHPg6qFlqfxhoUFmTVsGDOqzitR?=
 =?us-ascii?Q?u5wtcNGIMpf2S7crOYrMQn2+vtVvDATR6cOoFVdFVHzXLzNQsuso7chHrj4k?=
 =?us-ascii?Q?xxqZDS566dJahn3u7sDSPk6o+io8yLoFupkMZ6sbEuc4FKaPnEt5+Oo9D+M+?=
 =?us-ascii?Q?0avW35b5A/fjkTjWwA862aoxjNCgSBURrSY7LBTEwO5a0VN65OrkAbXRpSYI?=
 =?us-ascii?Q?Frx2+/StKWrwH5Ob0DiV/ceEDVhQgVDkvEx8TI+I23NnZZOrtkL/8tFaiMBW?=
 =?us-ascii?Q?syR0PIYpTp2MN/0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 01:41:14.1398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b018da16-590d-41f3-290e-08dd3505b28c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

pmfw now unifies PPSMC_MSG_ResetSDMA definitions for different devices.
PPSMC_MSG_ResetSDMA2 is not needed.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 +--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 7b65a27fb302..147bfb12fd75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,7 +93,6 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
-#define PPSMC_MSG_ResetSDMA2                        0x45
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index b0dab9797c70..e4cd6a0d13da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -276,8 +276,7 @@
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
-	__SMU_DUMMY_MAP(ResetSDMA), \
-	__SMU_DUMMY_MAP(ResetSDMA2),
+	__SMU_DUMMY_MAP(ResetSDMA),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8ab30b2f7119..4ec339d17499 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -209,7 +209,6 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
-	MSG_MAP(ResetSDMA2,                          PPSMC_MSG_ResetSDMA2,                      0),
 };
 
 // clang-format on
-- 
2.25.1

