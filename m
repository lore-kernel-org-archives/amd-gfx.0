Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C126CC87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597DC10E95C;
	Fri,  8 Aug 2025 15:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mKMG4PLC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5E610E95C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 15:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBfqzBaF5NMB4lqZMuRq1c2AFczr1YqsKzPj23yReL2jJUXfQt0yuyu1i9Ck6unnJefZzSmpvTLi/sCS/PCpi4t9DxYpWMo/OwMOcvPeDGDBj8HdWmvcQcsJRtuPChMehivxl/37hKCBogAa2+kLS2w7MoAziijEXcKx/POTtgzLSgGPBuxCqgDBsS/RaNvLgTfQ0LGss91ExihpRhYnVMTbXCnZqJviMt7yNPc3yf95mAoOfBwPeQppJyzVjXnAefErTd91CiuDS/BALR7ssoZ0sKZOmBtqcXHJdVnqAtAve3atFjz6KVAbiNM1fjT3eYJouLbfII/xRn/Qek6kCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO2B/RgbvpVLP+T+D/5Fbj9vSQ6AOlEGyWFzNfwsEQM=;
 b=QJOQyJKE4vBCzhJDFqSElWCs0CxcCQJ8VEg4C7XgGfG2gI8dHPVzmqM0HZE64Pm81Scqh8GfND+J93IhzDX9i2xCfET3tz+yJn3eKR4i7ZIiNt+Kw9reQ1oZJ+xZUHmoHVdWftXCLPuLbreK8rwST/P8qWfwztyO49Gn3kfx6fYvRUIdPiUfv9IcwgnZ6MuZRuvomy+AlkdG1A/vf6lm8Le2sbwvnIWpZgRXoMYAXvcoSSGDgzYhs2YBeGsGPJySBSLhJ6KFpr9vTcrDFqvXrXWgE0FX6myWLBzsRrYnWzj4PWpGAVSSGldPUpepug/WBBxJcIh6FHXj5ong9f5LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO2B/RgbvpVLP+T+D/5Fbj9vSQ6AOlEGyWFzNfwsEQM=;
 b=mKMG4PLCQu0WsDuFoI7PAZJirejF3SWla7wJhltzzZVpOCL8aP9BqSBQ46dTCnvn5uvaFyKcA1VvP7G+vEQyAKhBlHOPD5K9ZUm99M08X8DeAsxlLZUj77T/3FJMVhR9p6kTNnktBnmT1BzqLKKCAgJy9aCDIFmDFwB80EYtdNU=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 15:01:41 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::ee) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.9 via Frontend Transport; Fri, 8
 Aug 2025 15:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 15:01:41 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Aug 2025 10:01:09 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH v2] drm/amdkfd: set uuid for each partition in topology
Date: Fri, 8 Aug 2025 11:00:56 -0400
Message-ID: <20250808150056.45206-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 636bf111-de95-4cce-4b60-08ddd68c7b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hlgZYLzQ0Q2orkmJkTvz6rNBLIgDRJ1qoUDttyLAfayixRMh7851FEH5JvCc?=
 =?us-ascii?Q?3NfrwX0RIZmeux8FoWFQUmCCHVC4hbBHZvV9XbMPoa/7C8ZQM4YiTEJjSSrq?=
 =?us-ascii?Q?xigsGrtAB7bXg58HLItO6KcRbAFz/s9TIDHlmsbpGPo4MhZhvmCCjSuabaBR?=
 =?us-ascii?Q?s+v5CfO23eP1qO2Ho2rTzMnct9IqWf/m1fatC7E3pFSblnHALVOurF/kFXKY?=
 =?us-ascii?Q?DjZz85+7NHI/PWlN+X/DOThxnpXnoZGl7mTDZ0iUqc2iA++Jurz5yr1YtYXG?=
 =?us-ascii?Q?ygQTWF/LJrVRFrKkddIDW3OwWgzel8oAEyh00F9CviYWlyk68eXU8JM6J0Vs?=
 =?us-ascii?Q?DRUO/szRiHvp5r77plT0Wtc+RA2538ri92mkvb4PB1yPQOXyceqhrzyKM/KW?=
 =?us-ascii?Q?e8DyLWcdfpDW+7/oAVW5nk6ufXJ6aClQROCcwU5fdiTu+PR6cIMT0oRMrVzP?=
 =?us-ascii?Q?REKtihgZOh8xduiHHu0XUOiURzbQLnx056orkBmOWWm9R64c7q4FDHDefZ1n?=
 =?us-ascii?Q?JZueLuTxfol1O2/J0KAP9RBIZpULp+mtW5fuKXxFgY8CZ/gdWXwNqhuD1i28?=
 =?us-ascii?Q?XmrqzM6I0jCQ0yoihdLhy1HdGQuUQ7WlS2ujR7CzcRemsfeXw9pDtqEJ0Kau?=
 =?us-ascii?Q?N5qUCzh7/zF8MG8v1al4m5UcjLqzQwNK+4Txjk23V68mHLNYcDurSmW8eke+?=
 =?us-ascii?Q?B4CLM1X57TSespWcyY2HQ8mcaRH/vdgtQ4RvgSWzKCoWwpFqki2HSGCUokhw?=
 =?us-ascii?Q?/TrSYgVDoxg8lXGm3UHRi1jOtnw2u8zxqWVdbRKvcFw7FryXxSBQfWRHTQ16?=
 =?us-ascii?Q?p6RTMzG/o926KU3G2IG33ylt4YXHfBfB5wq2xXHNgm6E3sdcVRuSEQCOHpN7?=
 =?us-ascii?Q?yPfDUNu+ZQTlqWUWgg4KmhEldaIjocyWw7gyV7tdDykh+9NZhEfeLfUnKKyo?=
 =?us-ascii?Q?l7p1n+3R6qYNsRvTlW56WSc7LkGo/WPIg7ETcBqxgm71O2epRMHCjfeNyCt1?=
 =?us-ascii?Q?3o1Y6q/DUUl/yDEcx37rONYE1tDbDaAZMAr81fHgWeSZ2Ry33Wn+OuzJVp5O?=
 =?us-ascii?Q?A6JbBQrv8S+5GBjwIS6hgQh08zpf99HNT3v84Wr8XyP+J2y5baIjxkGlzVBB?=
 =?us-ascii?Q?W1shHc/v0j0/by4uuptVUdpa0B3b8CGQXUY3ZFycWn98CiQ12OJB6n4oXTiE?=
 =?us-ascii?Q?qs+ch54ga3agPGdcWlpuKPcdblB9YarlmIe5kggNkorKaMt6Ze6WKnsw5XEK?=
 =?us-ascii?Q?1d+A9jrI8rr5yQ6v01GXVc1MkG+GTldKru+5wKX88udyNv7qrYlxtoZadzLw?=
 =?us-ascii?Q?RJhGvnuHEfEBYgXxip3oN6bgm153NvituiMlrAU6LzNL9PuIJoK1qa37IFdm?=
 =?us-ascii?Q?G0BaDvqL9Sn9D0tKILN7AjVuduJyltkTzFxveSXIsOqUOQVJXvBdUpIdoCsY?=
 =?us-ascii?Q?EsfAJsHFs/E6Rryje8ASuZrs/CZva6xK39bulvgnwon274IFLnGPLw8oDmqW?=
 =?us-ascii?Q?2s337Ov1+sdr4Mn0lREYjasmJv3R/zcy63MW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:01:41.0127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bf111-de95-4cce-4b60-08ddd68c7b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
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

Currently each kfd compute partition/node is sharing
the same uuid of AID, which doen't meet the CUDA spec
for visible device, so corresponding XCD id for each
partition in smu has been assigned to xcp, and exposed
to kfd topology.

v2: add NULL check (Lijo)

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4ec73f33535e..82dbd68d8c99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -530,6 +530,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->kfd->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
+				      dev->gpu->xcp ?
+				      dev->gpu->xcp->unique_id :
 				      dev->gpu->adev->unique_id);
 		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
 				      NUM_XCC(dev->gpu->xcc_mask));
-- 
2.34.1

