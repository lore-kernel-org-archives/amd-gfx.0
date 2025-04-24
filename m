Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E769AC3ABA0
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA33D10E7CC;
	Thu, 24 Apr 2025 11:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sk3Ax//Q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD4110E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJUtTCAvW0cnYeW3zQK9u+wQV/JsW9teJRPhI0uVECvEPAA1vZVRKqRPE/8HltQGF45cLlGUm/cDSTCEv1UjSyWRXARPzyGU2MLTEv43WJr/bASogp58CMgS+QVvgHcbiXH/QLuXoOMuxn+5htWYeCl487BfwGuknU152QskB0BklYZyPTYT/1YgmvpyQJSDOfVdrI+jgo0S9PlcDkXvweoEs2/9qE8bWgkbapc27xa0smUUpcvQFrvD9qUh1/Diojv+cYuCFczNSPn+TRBUOlIfKryff78362YfkyGtt36F0qfw2bqFHb7buTDzWYCdutSoq4v71nZyirBfSqlwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=m7Kj1d5PQMAC84xnRp8fZJUWFMFgkExXlMdCrI5YjxiPlABX3dpHg8c5LFs3xv+vHYqSzWbj/45zoMOjVdH0ixEA1Ugu4Ocg9PHLwI2586D7SNhsz7RGd+6UM4Lqe+uv+rK6/+VCqEWlg/CLmQOKdpCWg2H7ePvZm6x9ndDxBCer4sFtL7K4UceVLJD9oSNvOly24EyOjggJ6K7tl9G5FX63JjPdhejRQ2GokmdJzzP5r/00LpyB84tjqiM0BIXx8gr6Eatj3o+xj/9rSQpre6OaMycMcF+qkPWb7pvuy8l0myGGE0eRK/tAreUhYIlU52iZKgYWU3QFhWsa4TeVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=Sk3Ax//QSrKRxnH6BHM+jnAhzENgsm2Hn1GiN8dySjn9DHwdCkLsv19Y1V5MRdSXaElJV+T4fyddUhSx3DwnSrVmTSQbt4NEWZ9n4hdsK0MF/SNuMBQNRQtmCkJVmy2vwcGh4hm653idumoGagtfSmMEuzHZeLJI+6fDw2bvbS0=
Received: from BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:39:50 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::e3) by BL1PR13CA0401.outlook.office365.com
 (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Thu,
 24 Apr 2025 11:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:39:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:47 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 2/7] drm/amd/pm: Update pmfw headers for smu_v_13_0_6
Date: Thu, 24 Apr 2025 19:39:25 +0800
Message-ID: <20250424113930.464303-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f3af036f-d264-43f7-5269-08dd8324b922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ihcg85CzqIBU1B42rVFzpML35iWJtXy/3Dcn/Xv8bQvmYzddGykgMRGe++BW?=
 =?us-ascii?Q?4wRQS1einiQcjLxj4RkDiFRpgCZbvritRn4DgHhyDc/aXlyunw4bvaH8ImMq?=
 =?us-ascii?Q?ApvIveP34h3m6LGna0gzRwf5LZnOP3aVVwF3jnDt3fSShb7vW2Bn7S+EUWeo?=
 =?us-ascii?Q?5oqRfYeDf6JcSzpTZ7YyUjM8ykcOrZFldm2riclJ1Zw3QVgyAM515Zlj3nZi?=
 =?us-ascii?Q?RRDG5qrbiR+r12MoKvj8RRNRTOzn8+Qh1WYSOpZ35J2O9zhyUgLSbOMO/bsY?=
 =?us-ascii?Q?WhHbQgr7UnscK+Vv/doKM5aaQq5ymWoaY7ic+TFp8B5sITZpkXHiNcYHAC3B?=
 =?us-ascii?Q?86SlvT6VBk6yQV0Pw+0tnqM8faFRBD4hcip52R6PzjvpfyIACj/IBYEGyG2f?=
 =?us-ascii?Q?ZtJlJBx2KJ4OPgx4kYlZCFEoBdseuKP9nXQaeEwfcj5b3OeIvNtFro2qopwJ?=
 =?us-ascii?Q?MOqF0kcNWYxT36lItaL3o4HIBXJ/TFK6oCfXJEFcw93sdV0EbAN876Dd3vlb?=
 =?us-ascii?Q?QjKZwjfmsW/ye93FSuEWW0X57LM6Tx24JuzrcK9K3miCaJT7fDB7XLsf7y95?=
 =?us-ascii?Q?JuBmZ/UNPaSLWHVSrWPFJMLlZzY3bY9VMYdarDMBO1j4xryyfZRqsjtrEbEd?=
 =?us-ascii?Q?8COIk74TWLBeQ5ANhSjP8YGUGgWaxdrF4du7Pyepec2pwJzkT4MKILQ346lj?=
 =?us-ascii?Q?LcQEn9OazAW+YeFTj7BV7Y8KkD9EP52uEm6iOD4ek37oWB+Vydi29Hv51lbS?=
 =?us-ascii?Q?8TnLuupZ7gt72m6Km2VbwvAsYXnkb+ycUZvcCd/93jv2PbmNbhYOnLuLI+gF?=
 =?us-ascii?Q?Jhn5KfCvSdE2pHVJWsghnvQSsUm6A3cOqYH647/HyNtsUwBtQcMJykykrfax?=
 =?us-ascii?Q?qJKt/lEVnVaiKPUjygkcSvSrvoy8Okw2+6STXNRRCxpuGRphXM3Tp3PfWDLx?=
 =?us-ascii?Q?KAYX26BIEhfBzv29Ne/nRKXolhhmgtv9eO0nNbpxAzCLqnpgckOAj1cbPBwN?=
 =?us-ascii?Q?syCv/Utn9DSU0RIgfpy1BGw7tuZr3/NDPd/HdRcaBudJPVpQXJEk2/zN2lDz?=
 =?us-ascii?Q?uisu3MRew5vOBcLJmi0t6Rcnr+EmK9w12rQQd+hKuqJ1mVVlrr+0qlp5l1Dr?=
 =?us-ascii?Q?dMZ2hMkVnCCJOLpYk7waFQgUyorPoK2XlE4/S68unrfZfNj/+OFdfe3j2VGT?=
 =?us-ascii?Q?sKx1QO3uPS81jQi/mI5bLQz81onQWg0TFcuuptC8vTUrvrCcGH8b9ENsG1B6?=
 =?us-ascii?Q?n7lERQLTbw7vZm7fFo2QxYoull2pCmEe40ierqw89Oc0kw/82ZscPGBSh7AN?=
 =?us-ascii?Q?f1jYqsxhxFAz16CDs813qJ7XEnGSgpoX8gdd5w7/eYlWrRgYw96IR5HqJvAn?=
 =?us-ascii?Q?G9r103GSKoJgDbhmdBgJyxdq8g5oBAost86oVr0PIU8eG2gvUfB4zDnlBE7M?=
 =?us-ascii?Q?9N/01JNgqMDMmlu+1F/yaHYu7Zkf0ZT6ZOpBMpYVV/rEVlieD5npEEacnJeT?=
 =?us-ascii?Q?eHJRYM6j3f1/G1t4Hr/IhHcRde5ROTARYm5o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:39:50.4128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af036f-d264-43f7-5269-08dd8324b922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
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

Update pmfw headers for smu_v_13_0_6 to include static metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 +++++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index d26f35119a12..3d9e5e967c94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -459,4 +459,11 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccGfxclkBelowHostLimit;
 } VfMetricsTable_t;
 
+#pragma pack(push, 4)
+typedef struct {
+  // Telemetry
+  uint32_t InputTelemetryVoltageInmV;
+} StaticMetricsTable_t;
+#pragma pack(pop)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 348d06a3200c..41f268313613 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -95,7 +95,8 @@
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_ResetVCN                          0x4E
-#define PPSMC_Message_Count                         0x4F
+#define PPSMC_MSG_GetStaticMetricsTable             0x59
+#define PPSMC_Message_Count                         0x5A
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

