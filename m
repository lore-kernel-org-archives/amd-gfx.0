Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7C0CA0FE2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E947310E7F1;
	Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hf6aYt1f";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C4B10E7E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrJsY3PEEiVbDwcjCfz9lbcmzvcyWiIzUZ0QN2fuIJdDuSEJFDsIhaGZhrd2JHGNqr1UGG8N1EiOav07kYm/MsOwhLC6enO8P85pV2ymsdwad/KojamJqfE+FbeN7gmB9SLJ1Cq/yf0e1NGELFlgCyoxLS99c0ZupNi1CaRo7AzNjy1ijC4Sxuo7sxORxWIfum3NEf0zTYhlHewiYvTBKaQCPGHbHlCfAgAitvXFwkW7O/OIzn0JA4zlPswz2x1JdF88VMN3eGSOKCjtKkKxJGq81L9rrVD/1+70XVCXS97Dcy7fAfxeS/NDPPbs3nOvJDFB6iNd05gkC+PG7TX6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDkODVXejUHucqiS4pE53+E7W62ko2Jx52TDdvsJg3U=;
 b=sPHLHpANdILZDjJ1JhDroxGsWdMKbM/l55YN/Z2TsasRKCs6dEPJR+RVu03Of3PhtS1PjD4KtBATMW4rsPk0iCHVeKbCG3kYWoqmBbfAvXUwbq+RRHEX5sYSGI7ETBsigEXZttWhYl7FhjDZLOCs5NZv7In2tk8ZtG4la+v460dZ+QKO/3T48wl3l3xEpNEaB+obXbXX2i/zmTUCXT+V5tF3qjxhSSsjhe0xn8MozMUvPcglmiHHTVGT1EETkGQvWH+oxd61vZ5jaB9TkVT0+MjAH+MYhz32FPMcW6QUGaXeuN4zGvW3GXTy5bcQrdruKdMXXsFfkEqS89NPKBKuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDkODVXejUHucqiS4pE53+E7W62ko2Jx52TDdvsJg3U=;
 b=hf6aYt1fADPhcYV9y2Wq/YN3z7yLLrEN1cnWO6xH2p7sIr1DggD6e+rfb9kW/PAfB2jHXyEtBuG3uBcbMOpJPmRJ7J3EloB+d5tWSMk1dKVTgoG9iJKQcjkhcQMQvDfQ+G5nI2y0UyTLlTLyleDjL0pNxLiirl8nh4n5XOmu/1E=
Received: from DM6PR06CA0047.namprd06.prod.outlook.com (2603:10b6:5:54::24) by
 MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 20:21:13 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::e2) by DM6PR06CA0047.outlook.office365.com
 (2603:10b6:5:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:11 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 11/12] drm/amd/display: [FW Promotion] Release 0.1.24.0
Date: Wed, 20 Aug 2025 16:20:01 -0400
Message-ID: <20250820202103.1122706-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4277b1-aad9-4918-b7fb-08dde0271c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3FM+OS7QCnJQrKH1OOJ3b4mTOABQ4WshE9Ri7g3wm0v6QXo3wfNEwMlG3ORB?=
 =?us-ascii?Q?vw0iUZpsaI6h+Rdz8F2h1veh/ccCSvfhKfdsbIWqJjtBle774wgxRVQFSMMm?=
 =?us-ascii?Q?DsQMqCFt1ukuO8xd8siPHNO8k+ve/hG2jNHUAr/hC/l/nlj5B8FcCQ10BI94?=
 =?us-ascii?Q?Y06FqVe6404j6iYXa9oYZTqIstnpfekodPAKWs0q2fJP88ZkHF6wBdd5IRA2?=
 =?us-ascii?Q?rXEXOxWdjbxth0AgyGssDFe6+2y6sN4JKlMYTdx/9ZQ+y5MC0deB9P9eu0aH?=
 =?us-ascii?Q?OyjSUwz0OOy/vMENvBa6Tb++i5W8v93q5vHv/+GWfhGGenI77APeb3gzA6YF?=
 =?us-ascii?Q?4rUMsQIsFORHQq66QqAgAIMK6wuGDY5fUrRgoovOD9sEowfB7U7zYJEGOT2k?=
 =?us-ascii?Q?S3Kr0NKbQVnKa/qmcaCG1/csfoXNOBt0uzCsTl40/fziF/tAQHSllGabtufN?=
 =?us-ascii?Q?YXfdDmm0AwmPPlYH40gbevNOh5Gn+294uaifxekMdbHcTG2g8rlyL9hiW8LV?=
 =?us-ascii?Q?nNsYuh2M3jVNGGv4YdPl3URBEh/79Oeec+C8DvAUH0JZYw8BO4MgAFjfXCu3?=
 =?us-ascii?Q?/vuexoHpjMFeN9X59CcU3XCHEr1J2Yan2QDA93JE8f/C9kEp/KxaczNhoEl6?=
 =?us-ascii?Q?6nxS/qnDXoLEdo3LS7lzSt5TO5ztY/m+aaYJfa7L7o4JS3RgtbD6j288Z9pU?=
 =?us-ascii?Q?vimvCe/N3nVZ/CU07xlPVZdYSSuJL8vVmvTrq59Jec0HXXZFjuDpC87j/Hqk?=
 =?us-ascii?Q?1LcBg/eUWmzKxdtYzLjILJp0ZEks2b5HQrf7EuVfno9ZbScNaD55dyYhi+dl?=
 =?us-ascii?Q?PDBG2lNseEEywmnRpEd0IeBS6ihBUt1iVAqgHzwxECX4G8CuDps2ybSf2Hpm?=
 =?us-ascii?Q?sm5tbJ6gSeg6V3AUQgeGalxmacV1AQv+ODBPe3TNrsDu5npu4TOLPMd2W+oN?=
 =?us-ascii?Q?u3qtqnWGkhgFwNv4SMAq8LW02pWUzU4c2PUk2YxfBYj1hanq5M//EIody0tV?=
 =?us-ascii?Q?BqcSpAy6TxcLDe9gJgvBa7gv/ywH3AW4dNWB+LhRU8NR8G4N7Yjt75lekEDP?=
 =?us-ascii?Q?DCxXfJTQXLKwcZdjhHU0EU0XT6oSvAU3pzKEy3EyTaHFz2OYY6EyWjAeN2tf?=
 =?us-ascii?Q?m4yOKMhot84aaNI6BT67jZbk8y3FXBYw9ixNexW+XDZmJ72t8qQsjAFL3TG7?=
 =?us-ascii?Q?4VwaOhUKmNhxE5EnCptK5x986EvOJH1hVxdFeVBPW21eh/SLXDJo0WLpVqt8?=
 =?us-ascii?Q?ZnTyeGp/2aVv6dWLWhJGqqbEh8gOyELlIJXi4ACfqTZNYoskV8iMEtV8E7pc?=
 =?us-ascii?Q?27JL3gcj8w6rH7AmnNuTvjRdoMjU2PsjnrzFsDEFTmlO2BV9JHhS1iAOlFd3?=
 =?us-ascii?Q?Aej2nviTnQhYi8eRATNC47DWLA6eWEpDdbL5soo8cYBYwju8nNu1UTDwvP1W?=
 =?us-ascii?Q?wAZ2hgsEyVFNNHrtRjq7DLdmRZHO8++oFE5HbB9jCJyX+WfAmKboRoEsgwBd?=
 =?us-ascii?Q?CfQ/Zt66bOF6oy0afc3uvpqti1Uq5EO6ygUx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:13.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4277b1-aad9-4918-b7fb-08dde0271c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add two new IPS residency data modes.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d7008d84c1ec..b7d49a117fa7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -6021,6 +6021,8 @@ enum ips_residency_mode {
 	IPS_RESIDENCY__IPS1_RCG,
 	IPS_RESIDENCY__IPS1_ONO2_ON,
 	IPS_RESIDENCY__IPS1_Z8_RETENTION,
+	IPS_RESIDENCY__PG_ONO_LAST_SEEN_IN_IPS,
+	IPS_RESIDENCY__PG_ONO_CURRENT_STATE
 };
 
 #define NUM_IPS_HISTOGRAM_BUCKETS 16
@@ -6034,6 +6036,8 @@ struct dmub_ips_residency_info {
 	uint32_t histogram[NUM_IPS_HISTOGRAM_BUCKETS];
 	uint64_t total_time_us;
 	uint64_t total_inactive_time_us;
+	uint32_t ono_pg_state_at_collection;
+	uint32_t ono_pg_state_last_seen_in_ips;
 };
 
 /**
-- 
2.50.1

