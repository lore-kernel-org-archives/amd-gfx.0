Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C59DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968B910FDD8;
	Thu, 25 Apr 2024 09:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gwNo2na7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D5110FDD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqTmQXMbBsWJdSh5bQ6YP3TFgpA1Ptgwcg1MMIlmkrBUyAzZig4xLAfWgVRTz6uWsyraXxcpkKaO+rQC71vKzEDY3NXW1FcvU97yP/UQUELcg9w3up5TiANxzTNUb3fiNfdNbf7gYhFGDMGsGWbzmOvNONkx4HxEzUaLVRuHD2km5+BvjD1Uuw8mL2jN6RqpR+G++ScKqmtDoJSubGJdevq6i9kkE7/y5RZCeGbYFYdLgi6fN1NO4BWvysoqY4Noy1IZMr8VKteBhVZbtcBEtMNw62ynfBE6kMEIJHDUP7gVeIbuWVsXZiOn2CE7QKgo5V1EtcE/EvzSweiqFDGGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmw4k47YhhjutnEg/5UcQpz2mAh9Ysbw5pjZFZRumME=;
 b=DTB3ZmzJra2nKH3CPxg/jmdrs2sMI1R1hPU2KTaR/azY+2BVaNXAXh1cdwRacPtwyRs4QbiNJnP1ir582MwC8tKiRS/U+aJbC6c3Mk+aXhkPFbTSY4E9MsI+ILB72zNgeCBuYO4EYwLyiMdPijqbiR2PmB1HDTTi/WuJa9tABYXJ7sc+niWo/uw7pII6aOlgNgdmPqI4eEo0DPyc1w3zaqVnJlVE+Hpc/DINd0FZo30Vq5PSIhEmN3qNjSOHFnULTy7CwJKcMG0WLxt45fVxLhR2cXJwVIr566wEFlD1Oc29JKSa6qpfTxHfXWSPVnwRrGJ44h8R5lqtPe3EFG+KlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmw4k47YhhjutnEg/5UcQpz2mAh9Ysbw5pjZFZRumME=;
 b=gwNo2na76pxupHuHfgUnFgDkJ89e3oqySdUXhPrXOdOFJ8u10mddQogbslpuR+QgrbyWlTwI4SzdykwfB4tirpmrajr71Aujs+NYkti/9EPv/xoTjvhdxkybKCoPwoX63pe8h08tNEV6LvtkA6CD+/KewWhNWxeRadGBk7gH0q8=
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:48:19 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::36) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:19 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:16 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/mes11: add mes mapping legacy queue support
Date: Thu, 25 Apr 2024 17:47:41 +0800
Message-ID: <20240425094743.134248-4-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425094743.134248-1-Jack.Xiao@amd.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6518584b-e968-40ca-429d-08dc650cd68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvfDSqb4o4WPaGFiKeg2HfJum3NQGkO/sllBCCEad2Sb6rRXFajMWbQHD3+O?=
 =?us-ascii?Q?IlMVMhZvmE6FHvK7mWCxV2mN6QTLlG97px+TchpwS33K0CGS0+IfmbnmAWXY?=
 =?us-ascii?Q?79dCATe25vAnFA5gpoB4YnTeWk+wj3iZI17cBoYudgFm5nUwI4Hg20jUJVa4?=
 =?us-ascii?Q?tO1SQ3E2W9MklfPRxQV2oHaA798QVVdUlpkIkhvGgLcDwHivwjxIoioNFdcZ?=
 =?us-ascii?Q?XMx6U9arbO2tmfbH9xfwW21/nazL5+75ULELdJ3uwxSZSQa4tpsYYEwLubBh?=
 =?us-ascii?Q?xL66zr5/i9CE4q5MqLFF2xNaLbHhsjGIZW7h1X9bF9ebAJBnZu5ELjTjX8C9?=
 =?us-ascii?Q?1XCVfHnrJvp4oCBAdkC3bxItFU4g5z/OzI/Z5+eCZOJV4I34vO9GKK82nCuU?=
 =?us-ascii?Q?OhR7r21L2RlRzJXWmrqO1beRgJ6gB830jwVlxs6lYPRRYQhEVexVQQL7bsOV?=
 =?us-ascii?Q?gXnfIJ3slj6GDzXjMhsiOCumzB7H1RN1mu6vLtJQtnO1BrKlQ7t9EGxPkAjV?=
 =?us-ascii?Q?10u1E9OlblhucPoRHzuiEfdoM01Ge/egaot73AIYkM4HeimrRFcbvUH4xxDT?=
 =?us-ascii?Q?yfudkzWdDv1iajcE6/EAqGN0gPzoA8v6mwBmeuVw1NDVLrQ9uHsRpHtFw5jp?=
 =?us-ascii?Q?Nr/n/PfFIbpii+nJhr0UPXvckxfQHxd6oaBY8B06uT3fE35tWq4dEIubNMXg?=
 =?us-ascii?Q?JuxZJM92uq5cir2l3Mm6E7Wgc8FECz6gEWwDl3lll8RJAtt/ObVC/AHzH6Pu?=
 =?us-ascii?Q?5+0BBrlvSQLJcQqqe+l1vTWW4wI/nMhkMR19tYPWhLPNbj2byycBVudEpABw?=
 =?us-ascii?Q?5Lz09DG9sWpBbdr2FtmWGcg2Dqnx4//A3L2zznKKzMfUEyoRrhA1Z2Vgrpub?=
 =?us-ascii?Q?vulTVgf2rJf0REBX6E5s40HXdo0kov/eHNy57rBpxPMnCO3Is4zYaAFBlYFS?=
 =?us-ascii?Q?6V7Liu5wKRTd0chTzXVlN8+Zki0fsbAsH0ZBRdqZjTubX2VZ3vY4ixc3+Pll?=
 =?us-ascii?Q?NQ9baa8sla1GsQ0EcEIfkJ31JrrZh0yOn2u9EP1zk+GpOYlntNI2SfnlgVu1?=
 =?us-ascii?Q?wkr+oWEPz1yytAraIp9hK+e1aYmRueVFW6QHgTD38ktt2WOR08wyLCkHr1O+?=
 =?us-ascii?Q?6YUu41r/uNd/jg2cpzzWMpujgiznXk1kYU0JXZVurkbAOLts9NbGeKQwCfOA?=
 =?us-ascii?Q?4GmKCyYrXGo4+36PtSUUjwbIigDgYR+4W0oiSd9k0E9v7xgHqn85+RjPcwBY?=
 =?us-ascii?Q?d93g7vaJrD21M719n8AfuIf4aN27sxJ1F+Dtx7uSiCwnE3Pj17iWCHViQ1MT?=
 =?us-ascii?Q?z3HyFQzzm2DCzTDYHkKT6/cfGmsHYDYt9etxr/htLwLEvtOT2PPYn1q5qa4X?=
 =?us-ascii?Q?EqS/LYg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:19.3024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6518584b-e968-40ca-429d-08dc650cd68f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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

Add mes11 map legacy queue packet submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0d1407f25005..91e4e38b30c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -325,6 +325,31 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
+				      struct mes_map_legacy_queue_input *input)
+{
+	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+
+	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
+
+	mes_add_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_add_queue_pkt.header.opcode = MES_SCH_API_ADD_QUEUE;
+	mes_add_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_add_queue_pkt.pipe_id = input->pipe_id;
+	mes_add_queue_pkt.queue_id = input->queue_id;
+	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
+	mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+	mes_add_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_add_queue_pkt.map_legacy_kq = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
+}
+
 static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			struct mes_unmap_legacy_queue_input *input)
 {
@@ -538,6 +563,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
+	.map_legacy_queue = mes_v11_0_map_legacy_queue,
 	.unmap_legacy_queue = mes_v11_0_unmap_legacy_queue,
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
-- 
2.41.0

