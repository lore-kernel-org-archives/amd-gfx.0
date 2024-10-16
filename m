Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C9D2069A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 06:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519FD10E162;
	Wed, 16 Oct 2024 06:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWmMTaiH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5A210E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 06:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG9ojvXdorfi64flAJHsC+xKghzOMXPA+z6D99v5OlmIz51jAqqDtD6l+u4mGnGFyZbL+u7Ql7KJeEbh4HZzzWrMOh5XpYTRXWKggMonmaaawJHZ8CzaMk6pyNE+8qvuFR3bOkth7WKAr1++jjkM07jhdZKrZ5vBuqaZYLXBlMnK/iaok9OojI03Am1OrR+vgJXYCHkiEZoQJ+9VNzR7u7bkV1jyMBIksalmPjVUqlnOthePS0Lzeah2/ACNzi47XK9ktrTUWMfjJ3qxVuhilfQrDbsyBzVOPbrdnOtsdXG9bNPMeHK4kQI+BxhaVxr21cxnvBXN743CSlmpMssQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=CsF98kweqg20GSGDZu4AevPpeP0FN9kSH9Qu66x3EoOvRBMQHJvdh/AC0XrRIY+s8/3ew1o3tizsfZMM81M9I9vsEnoxCmOyNTPtYLo+FTkVef/F7UrxKMBickSe+H31NN6nfoUUozwd3SyQ+Bqc8R/ez2w6CdG1lYgwUB2RpS2cbuxHEq2DbbyPdozeArhZKoBfXPuNm3Gcjv1MTaOUPavrSkpgaYuNJTAzrWcQ/U8CG8ioMJ0Vyx7B4E7QYzKQEAMwIugpMzFrWwzILgM7jXDYB7aMeHyKlXGgNQoKFX9KthZ0evDwTcNIdTQoLZSoGoQilrEFTgSuCwmDDW2xXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=xWmMTaiHmWSkh2FFx1eNIB3lWIh0OKkgJv/SPGsSOZXT5hEKbb2ZFVkwXN1pS+FurEjSylC95KCYQjOTYFCTh9sin+F2DzQxPJOS2WXtKAvx24vXrjr9uaBqBLFAEGzCpCKTPtZNHD3wCVDagBRCu+upDputSuTq2mCjB3YSsTo=
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 06:03:31 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::8) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 06:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:03:30 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:03:28 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v4 1/3] drm/amd/pm: update smu_v13_0_6 smu header
Date: Wed, 16 Oct 2024 14:02:17 +0800
Message-ID: <20241016060219.1811607-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 302cef90-39df-4556-b2ec-08dceda842bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oV645On8abdNXjT6Nx2WswST49mTiFaoYaxa4xCJ1I/nSSsmOmpyme9/5In8?=
 =?us-ascii?Q?I0+EGRsge1d61aqu+cexuflMNZLgHz4OosEG/5nnX5O9s4pb6LGl0gNCCFuh?=
 =?us-ascii?Q?IAKGSUKgW2Bf/t8sNija2Z7bvAB0MWx4n8UPeTMuBBKzk+hg9DeC25xemvzL?=
 =?us-ascii?Q?Alde6OnNOZ7+Uc9V85X60fnNlVjjSIFFebAu893Y63blojGIv3TIJFhc9ifJ?=
 =?us-ascii?Q?zXRI4Qkc88M5+p+RyEvUWV6rtlB+bCjjpZskmQ7Uywa9km43KEeJQ4O5xdrB?=
 =?us-ascii?Q?4Lzjozo9Mu406IY8IBzLVR7SEoOqk5i8XxZKBPC6kpChD78NsLJFvCuIdv7H?=
 =?us-ascii?Q?hYr6bMwK/kWEZt199Zj7pSXZm71HRZucv3x5ob/G935EC8e1vqIyIVt5pjyI?=
 =?us-ascii?Q?6USgiK5Qx3YiqnjRoqGslExat4qIau8uIgj8lHDxfWtSr0XqZ6068T9M1oZ1?=
 =?us-ascii?Q?uCwzHElVAlrI15pWPdbfrtUVq0Z91RHWYX9q1FfCquglkDEf9Er7vqFZn/hs?=
 =?us-ascii?Q?e98iPBhAdOVXb/32hlZeAPjzozzv+nuVURF+bHDdiM2G3IA9jGDLQv5X4Tdf?=
 =?us-ascii?Q?ok2k7Mi8dYu9SH9ysLcvwUQ2qlGULINuCJp+mViBeBT/D41Nwljsl2e+6Dsc?=
 =?us-ascii?Q?Uw2sMF/1o4wTb0ik+ZV7SySZdWGeRTAlKQV0aVvKBZwnZhYZiwoNKOSJ7+eh?=
 =?us-ascii?Q?H2lYvq6rkju0p7jnEZiNS+wfPIyEI5opLtINl97IC5xYvmScxagcVCjrXB1z?=
 =?us-ascii?Q?F5Lta1PJCze5RKPOqNRWhyEULm7HTlVq6dIBf6BVdQx3sQUuM4RVxnzBwp+f?=
 =?us-ascii?Q?VV3Xjre4qmRbMoCvIiBSoOr9FYF1/OaPFiGAQj7zNJV7tLSWzMKEmpLUQJis?=
 =?us-ascii?Q?YQt+32MS7Ht6f0KFkqGlqkbzidXLKCUE7R0ePRRBDduv7EY2iRcOqTxd6Vg7?=
 =?us-ascii?Q?/8rVo0ugbPGA88cgkTNLG8ic/3XrIWlslA5MoearoycjJXIzmDyx2Gljc2CC?=
 =?us-ascii?Q?Ho4ri/SSX8HjZeZbsY/R42nHNkVDwxC1Vfwcmxsux/mGAbqyIDRc/b2jtqpB?=
 =?us-ascii?Q?RHtS7AhXf90y6LokQwaAsP/dIxFZQpO5J0fmSopgpeCxpVOD0PduHcGcDtDk?=
 =?us-ascii?Q?BNaasWAHHXo6Z2mXXtd2252yZnV4i5jMRMr1OfBUVlieFPgL819sb5Y5bDjD?=
 =?us-ascii?Q?7yVVL9RN0qAYHNfQf1L3mCJujWlr80kolZqmqI+5gElYhZCFoUEaPxAViJu6?=
 =?us-ascii?Q?L5DGPkqeWDlyYA14z3QPkeiBSKKnphLXzoL6UjEtW2UcD3KxDva9edR+5z6n?=
 =?us-ascii?Q?8NH1B2+t7RwpAhu4pd6CLdcgO6DuJ2w9+aV08Mx6VC8EPtzs0LK+6ldAtkkF?=
 =?us-ascii?Q?La7RbVM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:03:30.8091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302cef90-39df-4556-b2ec-08dceda842bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

update smu header for sdma soft reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41cb681927e2..147bfb12fd75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,7 +93,8 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
-#define PPSMC_Message_Count                         0x45
+#define PPSMC_MSG_ResetSDMA                         0x4D
+#define PPSMC_Message_Count                         0x4E
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.25.1

