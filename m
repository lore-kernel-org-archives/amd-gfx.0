Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D2CC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 17:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948E910E6EC;
	Tue, 22 Jul 2025 17:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkKkeHrt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49F410E6EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 17:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs5bBQ5FPNhoXyf2JzknH7t2blMGQkOThT9VbHUxEYS69/IuPIZKROG6SLkga7U/MLI0TZnGjsumuPuNFKxMlcwwNJefangopKxIiadRq2httk9QCC5iFbt/i1hzxE9XPnssHXUcln3BP27bKWFR/x4hax2EtRg3YLFO2XlwzFhBcj0lsZetO4gPpqBeFBYTQuMI/h6ID/lZ+j4donyqY44U/Gy0a81MVByOSAu2a9wz9rVUJXKTSBe9wiISSzgMcc9pvURc0JXxBGWKb5MxRCQca6QRP2nhsAOfkitoDKhhTzf6ciEJ4adREH4NCdMP9CCNuvixMWHUGflmuT98iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmcrgkXk7l167GafNuToIl6yvw7lAi72NPXN5X4AfHc=;
 b=j0WGsUCqCY9vCQyazCyml4x1639rhpRVUTBZ1TNJYvf5wYavlSYJuK01ucJn4D+c/zYXds2GEVFv9nGej+wSZvN8Opi0QRLNBMiD6FWLjs0vNmnX/+44kijSLjL3YDJaJv+cN/4OqbDhp/OWgyTXAcarovEm0v00PTBpWTOs81oWnvd02KjX7ABshNrza4AslTtFjarxURplqJAp/S54dq3ZYr8DcaG4cBIDPeP9xOAJli3fD9UuMI5VslWIxzVRyPLV/zK88g7MmbwWawtb7Em9OhZTDHGn2sD16NTyKjGBJ7aqlAT91RsNuHPnF+cI6aZUZ2lsMNockbXCML4wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmcrgkXk7l167GafNuToIl6yvw7lAi72NPXN5X4AfHc=;
 b=jkKkeHrtH81++0iPs0EIpOQOh8eZWGaOR11XB82f2jcpvL7FC8mCN3+OE0czU95Wh7Ahgce9ysODq/wnw3v41NEtnH9pF8jAIZ/Bzt7BnA1lcGq0lQIpFp1YVeoIIKuGqDI+z/uY/OwWRvkmMhdygDLWb+MHDFfSvttsl595B/w=
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:47:26 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:20:cafe::6b) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 17:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Tue, 22 Jul 2025 17:47:26 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:47:24 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Rajneesh.Bhardwaj@amd.com>,
 <david.yatsin@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Restore SDMA queues with engine_id
Date: Tue, 22 Jul 2025 13:47:11 -0400
Message-ID: <20250722174712.450292-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: f90e20f3-fc0a-41a6-a812-08ddc947d249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zTyf+lczcGunvITaqlg2AJQHhhK4Y4anzeFIBgTUFlRgdQWTDmIIeaFny8vy?=
 =?us-ascii?Q?DBG7u8LzB8Upi0fb4TRChhDATZ2I04gqJe6Onfy9UDpikD81NLmnhDd+tzOe?=
 =?us-ascii?Q?03Ne5U0qf4fz4y+Z01FSv1bOdujnggc9B/8JckMU2KnNuyVxyZOHVaMBwFbW?=
 =?us-ascii?Q?vdXAP9KmwGSMrhxd35WBMP7AV1G8NsH4Xpkr80ReeO13yR7px+llwdlYq/NG?=
 =?us-ascii?Q?GTWbMcgRPMizs/GQ6Vm3kFKDncugNvfb6a7Pigy4DtTPAXmrC7n279SPoUmX?=
 =?us-ascii?Q?eWS6grZzICvQDO+cWqdDL/EyAcqV9RB4l4wwWEtwu7UUP39y9q0rivGHVuf7?=
 =?us-ascii?Q?+43ANzeCbvAdKXkPrOmNZaSz3NphLzzu1rIp/HWU4PUG5eWmNFH7IQgqbhfH?=
 =?us-ascii?Q?JBRjsSvqFmc6/cnYYiuznLzQUg+diJT19llKKPVnUe645U/13OpybOiflq3Z?=
 =?us-ascii?Q?+OB5HI/WYlbG6eU+yB3bo4V5RVhTbfNzpoNkV2MiIuG/2pAVLsSYmqz1G7f7?=
 =?us-ascii?Q?s5PVrqC+hlf52JX876MxXQD9D5XY614EMQ0gcp81DC1ZEItQkLCL+MqALafm?=
 =?us-ascii?Q?wSBojgQafAQ2fZxsR0x91v7aMYQZgdDn8wxRbi139nWF88ljU9mSPGDQDcxC?=
 =?us-ascii?Q?C1cV2bpScUo54N4mOPZ3rrTFRWMYpf56zezqaFvAaCmJZwArwCMFhjEuXgUQ?=
 =?us-ascii?Q?c0+b6QQiZPIxD6OC/B7+4ClPifKDJ5dfpM2b/knrw1CC7gkvdGnTcPpPCJ43?=
 =?us-ascii?Q?LT8vu44CTcHcHagRvZVzShr3lzDte0iXOjRMbw3z9qVb4fblImqzKeenRBGA?=
 =?us-ascii?Q?tygOnSTVfbb0ThcuOogjQvVDyUHEnvXcRyMSDOuTo109eI0d//1yO8Ynnssb?=
 =?us-ascii?Q?/IWu7mhFyaw8SnjwIXV91ZBwUOxEk9y9RugpqXBq0j7Lwb8SLPF/KFUsES8i?=
 =?us-ascii?Q?c+o8FTXL+uE4AMW8e1uIVXvfzfnhinK3E5PJUY9IUcl0sV6tMIsaW3MLJHYx?=
 =?us-ascii?Q?o2n9+clUCF13qlmKZl7lAfJPa+6WyWgdwx7Kyu0BOnuylP5JW+6Iw9RyDi4r?=
 =?us-ascii?Q?gVHcOEfT4m+TEZeSoN7uRngdYlgOJqtMfPDuUOJHVeDmN6bSYDDlMLiME9Nv?=
 =?us-ascii?Q?yO6t6wz9RIa4AIQ74lrGf69cs7VX6ZtUHbQR5peNmD0gzVbQPoaFvYJVIxge?=
 =?us-ascii?Q?p+e6VOcMSXqLuuaBF1cHuoiglG6uZhRiLmdancfr+CS7isxjLHEgPqkj3kNP?=
 =?us-ascii?Q?2hQUcnZwAsIwHmLiLR9lu/7kNIC+39+Nq26+Ibu37lFCi313H3cFWzUes1qK?=
 =?us-ascii?Q?QG3MxO8W9iMJknJ5C5MqU4N+lWTlzXzx7HFn71BqKI2E6YJSDiQx/jfuC6b5?=
 =?us-ascii?Q?YZ/r8+bXURLRr7vmNJp/g1lAYKbJ+NXt2mZRW0Lt/FkZQ+QyMxYZvyex2SKS?=
 =?us-ascii?Q?1xWV7gW8537PVilqPjHpy4KUnqu1Bo9YORtwVqpEzTsJ+Mt47DgHPi+0G6g9?=
 =?us-ascii?Q?P4fHM69/ADCGXEOf38FbCQngiqPvpp0HpkHH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:47:26.3946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90e20f3-fc0a-41a6-a812-08ddc947d249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

Add support for checkpoint/restore for SDMA queues of type
KFD_QUEUE_TYPE_SDMA_BY_ENG_ID.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd9464..837da09b5bec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1261,6 +1261,7 @@ struct kfd_criu_queue_priv_data {
 	uint32_t doorbell_id;
 	uint32_t gws;
 	uint32_t sdma_id;
+	uint32_t sdma_engine_id;
 	uint32_t eop_ring_buffer_size;
 	uint32_t ctx_save_restore_area_size;
 	uint32_t ctl_stack_size;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..fe4c48930aad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -846,6 +846,14 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
 
 	q_data->sdma_id = q->sdma_id;
 
+	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+		 q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		&& q->properties.sdma_engine_id) {
+		q_data->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
+	}
+
+	q_data->sdma_engine_id = q->properties.sdma_engine_id;
+
 	q_data->eop_ring_buffer_address =
 		q->properties.eop_ring_buffer_address;
 
@@ -972,6 +980,7 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->queue_size = q_data->q_size;
 	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
 	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
+	qp->sdma_engine_id = q_data->sdma_engine_id;
 	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
-- 
2.34.1

