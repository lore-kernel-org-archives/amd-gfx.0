Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA3C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 10:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C81410E9D3;
	Fri, 28 Mar 2025 10:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="in15CG5R";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B779F10E9E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 10:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVZTRTJy/4qpSVHcgzKYUBJH6fUm8RWADMxjI/FwT0qh0qpC30upnYWcKKhyHB6gbuQR1lmu4usfJS1N/BS5JrC3kSNNxP24XSQqBE9zK6N4S3ef1wxeuIjMb52jUnRggMdpxZ3fD4kpTiPGM9LS5rO0QggG4qLqBM6JVlnfQPqRbVKEUZvUYWonuSAxne4wPVUOlc60Q8+VI5q90DDii79G7YA0LiF5bGl1Y6in/W3RcAeQH7+ymp3wA6JYrx8B7hE1K3cWkmkaMRvWcjlXDFquTux1Iqy+4NaLr+Ok4QW5yLoiXRC9WLU28YtH7VFo5n7RygJjAkqBWverp0EC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAYVvrLFbEiNFWAoCDLZHwXvmbVJN4ylbteV3eLw668=;
 b=e0b4Q69XvHcBJ2+RtjXnjazlfivdYJDaOFJQBrVp3YtbqXGlA45AfmkMBKaTMBjzU2bnn/Tyry/tZCB+lbeIcrRmJLWGSmL28o5L/5lkWSvqRUhxGxrkcIhr0CjWD6EtsCZwOEModchDCrYls+C9FS4sxdn4Q3YDb1HvzkV0dxSrmH0J7AjjzptCiC+7HX79uRsosx189bP4aiL0IXW4Fn4fHgY4/xk4zulR4UxWAVXW94pQdHeCLyAd50U7mBF1Dod8esENQezsJYmcRxWqkvmVEplOrdYfhhEa25xSdA1FR584KKMfKfsRX6kRFZ144onHeWaRjbgnFwBm7VCWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAYVvrLFbEiNFWAoCDLZHwXvmbVJN4ylbteV3eLw668=;
 b=in15CG5RQXFOpbrzuWCSnYT4dnrH9mezJCrv6xpzKdtXrCbiKR4z8y5RqKp14K8q2tHiew4w4lUR8bnGX3U0/yXTtPQwClGLUecDmeveRZrzj5xsV/zk/6bfywP88ooBNWhTxvDT2wd/LhgVgWiDZtyQv24nb8C+GxYLoLkRCFg=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:19:21 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::4b) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.45 via Frontend Transport; Fri,
 28 Mar 2025 10:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Fri, 28 Mar 2025 10:19:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 05:19:20 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Mar 2025 05:19:19 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jonathan.Kim@amd.com>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: sriov doesn't support per queue reset
Date: Fri, 28 Mar 2025 18:19:17 +0800
Message-ID: <20250328101917.4159629-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: cb45ae95-3c66-4b6e-8691-08dd6de2017a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xuh/9KoSDxk55yTpxq0aPtRDoeCsP/IHmOIaJiih+xIx8js6fapAt/3xrVlC?=
 =?us-ascii?Q?cqyrS9iSA72ElOG4dUoWJInHpR92N7Vg6zszyY6huNbYum1R2TqsO8DrJW0Y?=
 =?us-ascii?Q?J9DrznsjnJHGSDopMcdvmPL5NKo+YCuHHdqKKmcBOh/WGkRFmEck1fSGUl/Z?=
 =?us-ascii?Q?CRqstzbqEVitH47I9s19rnV5HhZULAoJoqqOBShibKHI9hh3MK4ya9eCs2gE?=
 =?us-ascii?Q?AEzdhDkLGoMzQ4nHBWB2fYG7OmazDH+aG/aJ4c32+xZjuJMtBuxi5EkjUPGy?=
 =?us-ascii?Q?DzZbNFPbZiMb/y3YruRNAKi2++9VzywemSDJDkfvDDOE/i9/1ceYs8cBDhha?=
 =?us-ascii?Q?a389vjE4e2PgBu7yACnAiOSOTVdtRlbcnB5l4gpHVNhCZP/CoEMI2r9XHKOl?=
 =?us-ascii?Q?m/rd2O4c+V1lCJC4KdZAn7Sv7t9awdJpE5GMqA7Ogncpzb6SU91lJ7t7ocOq?=
 =?us-ascii?Q?4jCfZZl4OdTX49uHHgcRr//lWDCTchrI6FKnYEUN+UcapWFPIjGDAML8bWa/?=
 =?us-ascii?Q?ZTDtP87xi5dyfqO32ITwoumaJZqfHOQgkoA98JzNaPRyan4kPbcPp315Sb3f?=
 =?us-ascii?Q?xGf2CRn4Ku04EvCaVRWofFyNiz46K7d+JfiKgOju90n6IB2EgTDrCjijas2Y?=
 =?us-ascii?Q?z0b6MMyfKnMrcP8QKVtCJXJCntnIHmjhKhzVSSEIAjecRhPNT5hDz1ZAua43?=
 =?us-ascii?Q?hARqQnAJ117ujoA6xKaM2ioQXmVfPOX3ya0jBE3IU5+8XWw9yqZf3EP5F82d?=
 =?us-ascii?Q?bmaOBn3uoqMkDMNDhfeji55f5XeLpGC/TEL5BZWM7Hr6orAO/SiTcg0BA9DK?=
 =?us-ascii?Q?nqwKrlOXn6rjSnGy8HSwn6oBHHwg+GAN44MJbbRP9LXlULECBVshnLoQrRPU?=
 =?us-ascii?Q?NL8fV2ngAURQP3wtiHHVbxPkT34xXgYrYNt1IpIoVOoUvmG3YUkF1L003T9L?=
 =?us-ascii?Q?a3bBUKnCYBvJvq1irnYNiwAlZcKDIif6fACoY4RTSQQLhFFC7m2yBcKMyVtE?=
 =?us-ascii?Q?wIJyUPcpTBTAvjcMRyjOdrynDemPhJbKIzAAikBRcxwim2QBU37Tx6HgGTV2?=
 =?us-ascii?Q?OHko6w81ESPa43NzOWvsC5bPLPjB9Ur05x1U1G6r+lfAgT5seWUZewRnjhUv?=
 =?us-ascii?Q?VM+9rqtBjAexkJUp9C3Vy+Bwxjfnnctr7Y38sdYoKyZzOtO3/8btDvE63zc1?=
 =?us-ascii?Q?Q2Y9LDPbFH8za7dCoHQEgBgg8JUeCwMOmc8an6wCkzsWzS9A3QRl4QvWK1kA?=
 =?us-ascii?Q?wUptMbNcd1i4sjsNt9grhP/QL2Sbfwk2BRe+YlrvQs6NjPRbrGV/YUXpHwO2?=
 =?us-ascii?Q?Au80JnDW/33ku7LELS6PJFhu6h9bgww2TFjdewbhQQ4tqwyiIV2EhtpsdJ8o?=
 =?us-ascii?Q?2XKFtAPmuhO7nIMTr6IUxKNtmoQhwUK74QT2mjXojPmTjkqE5FLODpOtOcav?=
 =?us-ascii?Q?E7sIGo/YatDAZlgDklCnHXRj/6ihIHQBLul52nnZYloGHi4H+6c5i+ivwf7d?=
 =?us-ascii?Q?aAy13CRS6bowRTI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 10:19:20.9938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb45ae95-3c66-4b6e-8691-08dd6de2017a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

Disable per queue reset for sriov.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index e477d7509646..2c4711c67d8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2001,7 +2001,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 
-		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
+		if (!amdgpu_sriov_vf(dev->gpu->adev))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-- 
2.34.1

