Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5508CEEB59B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 12:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5E710EB60;
	Thu, 12 Sep 2024 12:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EcBa47Nv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B5110EB60
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 12:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMtIPl19OR/w48wWDm+YuZ1CYw4pyxyeHQjGXuTn6X7a6ezvqTRThA59o3h80IDyeow+MYA8/vcsEOTgoZZYoK41ZStgGXCKqgimZUuWhZnsnEjQp1wMyxJZ6sGNhax67USogNnfaIyFO5DLHjX0CootIahK/UCqPuDuIZSHvZi5n7ZSlxpFEmZkmBpcfmWfV482zHTJp+lw/QIVwoEfx9g5V2IghLe/b+kdFkmjsv6g2Che7skoG85tUXVWW95vigtAOrUliJSPXCPGgUnAI1s5ggWPydJyshZrBuKhq1GX6UEvxyMYzhyI8hq2JLIK0nUkXu1pMtjqOZ6TvvrdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsPaL1CilD53UbYIHYYzOOthtdJa8jbQtDS+bs5eJwI=;
 b=pkX/YP1SiA9KPNHxBajSi49uWTZok+AkAy7m2HdRuTChfQuuoOe72X54UMPDGZGYH/nSfX1XdL2RrW/DItET5E2KpsLkkNjuAc5gs7141l26ZwJVidMkisoTtYkcScSQT9IO2GbUVdDgYQOHQiNqXAgOsa1NXnLOHHD8R+vGc9BUPVfwnbXu5DQ/XrnRxQ659AH9exAAezEzNo/MOMcoLh3JVt1HjZzbzB3maoqlwvq6By2QjAonKWr9r/twAtYQW+RmnewVyWvCqiP90sXq1FIhL9txTQIEssQO+uaH/4LE5VO8RuZMH+Ibyp997ahESdq422PJtrO1KrYGRw6wlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsPaL1CilD53UbYIHYYzOOthtdJa8jbQtDS+bs5eJwI=;
 b=EcBa47NvUTxNE+SuoqkJfGnqNtBXAq9mmMAgXj51Sx4f/A+UNOOCCcEVVnMFeC3HjzFQ17zd8X7sdVQMAsZc9dLwEehynmBSmZ3Kd4MnEr96ANwerp7Xd2IrcZAtz6DLh/b/lyCj7Fc4Hiq3y3a5XBieWU5me8aJw3f6QXkKYzo=
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 12:00:12 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::2d) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 12:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:00:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:00:07 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 1/5] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Thu, 12 Sep 2024 19:59:43 +0800
Message-ID: <20240912115947.2208807-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 2950ae2b-0ce9-4d0d-8058-08dcd32274d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XW/411V8QQBBWxQ/b2AHrNblCh5wrvCyyJ5Z5yK1znUXinLEUBT0jelDF+ZQ?=
 =?us-ascii?Q?ptMwnQ5MqKQS6Kbzmqwu/Dd6hDOBNbQlWg8WOjDhgkrb7OdmNudL+tkd5/3f?=
 =?us-ascii?Q?5VEzPv5A6Gzn9tCF7u0+xtGxqBGfvpq7gMYu8crMj3UITRJZvHyXgHowLUzB?=
 =?us-ascii?Q?yfsqEkgOzb6AohvlPL+Yvh5JPsuW4vq7CqI54JEY5vgQEvmC2ES2Mx/RYeQh?=
 =?us-ascii?Q?ZI8PmdpZFtqiJrjfP9FYJ0nK7WpNIRGm9JIUpGrnejHqDeQA6p1mhbM8ItcJ?=
 =?us-ascii?Q?bjqqhiAkHEdMR6Kpg7C+SGgLIIJnIE5ij+J1XHm9QYETTFTz8u0LBlULfMPa?=
 =?us-ascii?Q?PRjuQJQvkhWEzM7w10H1ir77Bz1+G6+QQczFKa7Z5Z1z3RRHPbZOti3NyN0r?=
 =?us-ascii?Q?O01Vhi5VvWiZ5hP8Zf6tLDlj7bIggflfs2gDMz8t444c29mVLv9esWzr4XuA?=
 =?us-ascii?Q?WOyHYnZbvkYqOXy0Z943l2Syz0Zp5CmHslM+GI7CvmKZDBFEEaCPrAH2H4f6?=
 =?us-ascii?Q?+DIKH1ZjqYlG9SWt7kQg9J8LSIhysNLkMtCPaciveUmJ5lXU9wXtF6sVNrnj?=
 =?us-ascii?Q?vFkbW+aZ6UmRhPUKJv1/l/OI+Nik4o3yVh0VOLQSrcgtbx0+ZeBMGYrHbdAU?=
 =?us-ascii?Q?wbJnmY6LqthEJqwED3z3DCLCaqenP7SkD0HoSLu4zl6NRV4oUFtNuaY52jhe?=
 =?us-ascii?Q?NsAOMFiJB//YFajUw60TrRhboNrx6Q+T8NoEABEX+CczyVToIG57trNC6UKq?=
 =?us-ascii?Q?j3aWHcevgfCzLxr3auviku+jLScltxuNZpYsgTnMChFAwrh54XS7hJpUooMP?=
 =?us-ascii?Q?8zNNy90rKEqay1BuwPNCBIOfDR56dckiIk4NxL8GmOyF2TS+vBCr/mC3Y9W2?=
 =?us-ascii?Q?Zw9EdMBsmL1tnA/UXibAkG/2XDyQMOVBOhh4BemF/sh1tCPpVg3JYhArZ3jH?=
 =?us-ascii?Q?R1Pu9bEeN7KxxIqKBEXAHo7hV0cPsOX+QmEVEeIM/Fy0gzPHq4P6AMAUnw0C?=
 =?us-ascii?Q?MiLwzHJzrtZ1nwZcD1IPM5RcivpdBaY7l6XJuvMfl6CLNuCdMvXpo7P9DqCa?=
 =?us-ascii?Q?m1q56n9u8/NX+HssM+2YdwJqrSWGTLNaPB0QsYmB9O/d4Cwe5E8xXWSJPz7D?=
 =?us-ascii?Q?SLWsjUTtFyd6AdHvfv/crObxoXh5mOS5KPtjyq2ScpsiU5DwG6ZheKnem4BZ?=
 =?us-ascii?Q?mXCMjwVav0gt1ROytLD6rpcFBvKhQud9GGrRUJ6gwTcBO+YupC/1wOTYYgOv?=
 =?us-ascii?Q?pXA27YBV3f3r2hT0cyyALhSWqMx13cahH2JAaksky0oMhAc8Y8KMvDyT+fsb?=
 =?us-ascii?Q?KDIN7G71iTMmYUtEu0Ezx4aWFdnwliTk1gBYSYCzqDiNM9rtOeuKHU4NyFGW?=
 =?us-ascii?Q?87yu+4lrXEQT0Y/iF15PenGjPgd0XS1DIHCyD6xaWF9j1QKOIh8CZktPoDr8?=
 =?us-ascii?Q?jyHRSneFqQkvjYZKEI9okXuyQn3i8NiT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:00:12.1222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2950ae2b-0ce9-4d0d-8058-08dcd32274d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

Update PMFW interface headers for updated metrics
table with gfx activity per xcd

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 0b3c2f54a343..822c6425d90e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xC
+#define SMU_METRICS_TABLE_VERSION 0xD
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -227,6 +227,10 @@ typedef struct __attribute__((packed, aligned(4))) {
   // PCIE LINK Speed and width
   uint32_t PCIeLinkSpeed;
   uint32_t PCIeLinkWidth;
+
+  // PER XCD ACTIVITY
+  uint32_t GfxBusy[8];
+  uint64_t GfxBusyAcc[8];
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.46.0

