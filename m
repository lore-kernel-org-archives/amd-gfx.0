Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F864CFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BF810E5FD;
	Tue,  2 Dec 2025 10:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZJZJg1v";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C5C10E5FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5n5hL3R3TtCYDukuviBpBMfZxP5blGPKOOuBeNLbV5Z1E7OTCrIeuOKwQCvQ9t7o7Ghghe1iVFQfAbL1FA3VoolHCnw5LXCu4tDErWUNm27o1+GywAqQiAB0X1ytR59N+dnq5dLbCLXpptQoFW/Qz0a3Ejehzwp8qQBKJ9ewN+vW1oU5l3QhFucpSbmlxwqPHMR3e55Hvkr03/82t/rpKfN1PGl3IfFlXQyoQ7nw/kJDRwdUnkbTO5nJqITPXwG3hjU1EtIwFB28Ss47DQ4QBG93XShgNM3C0H3AW/FdRvDrVy9DMXRWZwJ3Va8Cwb2IuBXWfPbSiluE9TIwHWoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRTEPKQr5JNFz/J6t3HoAyaNqPjVnLA1/d5z8Cv51JI=;
 b=UD3ACZQzm8r8V3dJURmav7nCdYWFTVvGnLhGcdUWa4K0IYL16UmfcP8UrMknExYBnHwOZvhOFPoLhoAElUOGtXF5alEHnhjgU6gMmzYtozkj/EjSrT4qWD/eDJNk/OyiYbHi8BSCDyYEUZqtstwgnnj+8knN+KE1gEmgqKDApaeZsi1M+qpJvQgRmp14eKUCfp8qG1bFM9KsP786DzJp3tn9KdIqe59FKx3qUbU95340XcB4h2HxtNe/gftVCiGy9ZqEDLnmBMehDfAorG/sD5gaOsqiFsj3x1B8q5A9CowatsfrVGvNW19TJ7abXyYze5NjL0Jo+rVngb7qxHTQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRTEPKQr5JNFz/J6t3HoAyaNqPjVnLA1/d5z8Cv51JI=;
 b=TZJZJg1vIekaWdJDxib/surSBQS8T73h421Pg1M+nFdKz3Xw0o6gwS1ywXA5zb2xz822Sna+RpiC6AnYSvkSUxxdxWeSQejXG7oswp8sGmqO9hus8GsAnNdVCEwDsXR2uN+dhXiER6Lk0yXLuNDJBMOGisdBtI8/k8vzZreKJDM=
Received: from BL1PR13CA0370.namprd13.prod.outlook.com (2603:10b6:208:2c0::15)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:28:41 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7e) by BL1PR13CA0370.outlook.office365.com
 (2603:10b6:208:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 10:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:28:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:38 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:37 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:34 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 0/6] DC Patches Dec 08 2025
Date: Tue, 2 Dec 2025 18:21:02 +0800
Message-ID: <20251202102437.3126523-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 581f688f-e8d3-4caa-47a3-08de318d8fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5R4Jc1Z9ZHXkqJQTygrus5uV18wbcea/MfnEdAc3HaYJIXt4FvZm19Wr0Xyg?=
 =?us-ascii?Q?E6viaOoq0ROX6RO+K0MzpTyVEErOa0KjktWZPztyspTtOJJLauISTceKQ77p?=
 =?us-ascii?Q?6/ypjLh8aN/JoavHhtyl6xnwFJBEIM6SkdasVfKekiImcJh1XDkxDune4DuT?=
 =?us-ascii?Q?VD3w2BLFbi6O+8bxJhmcANQ9ugx2Yzd1a85chERde2HEBGImh/f3R2kjPOAB?=
 =?us-ascii?Q?5HxxuYn3LcByVn1YgN0ZAW7XckrPFlTqZ3vpVkIfI7X4dN39OT1+72esbm7c?=
 =?us-ascii?Q?TaKRKP9dU3SPcvtOD3B4u9gt2CIsdcZiqtZuscXzc9BOs9RSo3M6TaKaOg7X?=
 =?us-ascii?Q?Ilqrr4uEOCQR4biQT1xuD6tmWZVDLFI1Mevcb5wLYM8uyoPXr3oGw/BuxIbD?=
 =?us-ascii?Q?7Do5aWFTlytpLfkbNhwaqgEBB97eJQkbL95X6szSDVVjWm9bmBpVDUChqvgf?=
 =?us-ascii?Q?eboallLkfyGCUGmX8N7mpqKgIMg5CpAJ88BKSMc15UmqQjHOjfVp9isz04KC?=
 =?us-ascii?Q?0MiMhINf/PPXc/FYw3RCgN0ApZ4Z3H3GZMdNi1khqARgtJ27xt8i40On/24p?=
 =?us-ascii?Q?nkAsO2kvI06u23wmytDhDFnlFHphtj1UHc5LDW/2HsfDPgGQ0as/S4MUW+z+?=
 =?us-ascii?Q?G9w0QH3w29WD4zmel7gu+5fDVjmLbDxeZXWI15EGU0043Q/QB69aWevVjFQQ?=
 =?us-ascii?Q?6HujmNyyHdECt+T0mFDbgBA8xSPIWeGUlC/BLeiEySP72RVqGaIHKY6oNAHV?=
 =?us-ascii?Q?6g3JKzcQAsK29+mY4hTF+QV1yAWu7g+jcega8PVVXhe7Ggw+3wJt64jACq/3?=
 =?us-ascii?Q?w1oFh1pWtbD0qWC1/1HnetvM4+gKsw9hPBu8IcBBHuEwEjqZnMhPD739U2Qx?=
 =?us-ascii?Q?WaPu8mzXNit8E3m48MISMwPXWcxChtUjdMjHqDVBmOShQ87eiHP6tgHkIcY1?=
 =?us-ascii?Q?tZUmcbvDzJnpL5H4o+M6uardeReZEHUtI8gXigKLbW80VX7/kVhB2CQ/0cSU?=
 =?us-ascii?Q?HrVu+9JD+od6jqmxDzwNBub6udzrgFarXz2f7sFmmJ2JtPBH9cmbMOhvEj9M?=
 =?us-ascii?Q?PCZCWZieIdRAYoow1lIQ3NB1eRldWBBuM+Y/mO1RCodo8FOmscxckueNNZhC?=
 =?us-ascii?Q?isehn1HWOb1topifxkP75wvZ1pPL5LIJxGKW1HdiPIyLHq1MgrQY0BT/E5UE?=
 =?us-ascii?Q?IQL3/jlFj8ELOmM8cXeCAXDDrsjJCMr3BQq+yeDoD05mxXEZrPXSxp/kDx05?=
 =?us-ascii?Q?A+WjLf2OemxaYzqmCMc8QO6GHXkH9zKfFKccmQD7CVC9RDQf9Bx6ap+b0GPb?=
 =?us-ascii?Q?RltSBgD3T1Dw21lK8V5tTMcv6lmwXpjZFc4eEYwR9rj5gp9wQYIkFhoh61Hw?=
 =?us-ascii?Q?vkSUa2T2l3SeQs7Bm83RNZkCf7YIsH1hq1G3Qx6h2VawVUurVciJYaWClGfR?=
 =?us-ascii?Q?ATonKIggQ9HUShbjpMDlbpIvgTi7fdf74ICZ0xMhf1DvtVP+e1U4G+LZmXiE?=
 =?us-ascii?Q?zQEMR3w48tUZdCcK25kM38ph7vcHiuFumKT9uFV/k4BFGb6D2QKTdS7FutSt?=
 =?us-ascii?Q?LXXDjwBGoz9gYnyR5P4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:28:40.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581f688f-e8d3-4caa-47a3-08de318d8fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
   
 - Defer transitions from minimal state to final state
 - Remove periodic detection callbacks from dcn35+
 - Fixes for S0i3 exit
 - Refactor dml_core_mode_support to reduce stack frame
 - Add additional info from DML for DMU
 
 Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Refactor dml_core_mode_support to reduce stack frame

Dillon Varone (1):
  drm/amd/display: Remove periodic detection callbacks from dcn35+

Joshua Aberback (1):
  drm/amd/display: Defer transitions from minimal state to final state

Nevenko Stupar (1):
  drm/amd/display: Additional info from DML for DMU

Ovidiu Bunea (1):
  drm/amd/display: Fixes for S0i3 exit

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.362

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 200 ++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   1 -
 .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++------
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   3 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +
 8 files changed, 218 insertions(+), 138 deletions(-)

-- 
2.43.0

