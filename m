Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF7C982D4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FF710E8DA;
	Fri, 16 Jan 2026 16:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OW03sCjE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EEA10E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeEJI5Z8ll9sUgdjk8GalHDJL1qBzD4Xgt9/OcTHwL2medR75ggm5RXnKTDP88Af+f/Hh3wBFm1dAPF0coNKR+Nz+gw17FSE1dsAiBqhwxpva2Y/LBQwUfilHtpnLErASZB67PWZ5Hw5NoM/htSidj5yu9kwQ4Ewb4FEpji4+3XybzdNaZoYJ+UWimTWkoiD5gsu8yzbXSP2RY9IRKs3A4UKXPR+CFTI9szxYTDNIuAbdbxlEm/t80/AbEddFdNrFMFNsN96lTesGZwafwb5k2hVZBhvYf/XveSVTIuHf/ZcVEgSw4knwCHP+PxuKfAAG3czVdov0agFiRtvYxOdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utMtucYQs6Khisqxi+jXrBB+WLraSBUP7rnk56tq9KU=;
 b=hASB0xD73D2ILA3WKSN7Oxmfc1INoY/Rph02RVcNfKRRSTKPsH00p5mVMXJ4J5312wE+y74ez4iOdcDBfN5goPFcu3BSLefQgRtpApT6eXbT7Xz1+CGR2ATNvEkj6bkmio94IxQpysDb8ayKZrZz9dvyJhku2IefqmfMci03DhnV4zkP//Iuo8Yo8XuWfq/hZsC/HXt0dIpiJSowSZaJ5li0ZeqfB/dDBxJdLm5ULE5Eul/35jQysM0YS6EqoOqjxstuQSgj9PIbVfio+qMLQXFu/Vs0+PFXjODGgOK7BAFSyvEfbw3Vb6BVVcUV/2QPv12ahVt2FtWEdz7KvJ9LzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utMtucYQs6Khisqxi+jXrBB+WLraSBUP7rnk56tq9KU=;
 b=OW03sCjEekAlsIh7NhWZ9Yx+YXMsgzpjey9pbY6woS7u8aiC+OsAJV0iptl/WYPRjh2VWyIna2v3P1NgIUm9m/P6CkCNy6EeIEkkh6OtgJohRuHQHheky+VanaZngNQRSNdSeCAACcsskMUDSdD6qoNIzA8nMaISV55jdQxn7C8=
Received: from CH0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:610:33::16)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 16 Jan
 2026 16:20:44 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::6e) by CH0PR08CA0011.outlook.office365.com
 (2603:10b6:610:33::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 16:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 16:20:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:43 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: drop drm_sched_increase_karma()
Date: Fri, 16 Jan 2026 11:20:24 -0500
Message-ID: <20260116162027.21550-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ff4b3a-426d-4e66-ef30-08de551b3339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QVqXISsSEOqu8LZ77HfziVE/V5qxeZoHn1tQMPm/Ud0sqsJ2uKUXzJsoa93F?=
 =?us-ascii?Q?32Ns2Jy1KF2H1NAfsFGE5dvPezdUrHJI2eLqG409jV+K9ja54bK8JLPFnkUw?=
 =?us-ascii?Q?37CgsXvo0MxFQGfGAsL6tZr1g17Dj+50p9ifcSXO8I259iqD2Q+D2K/rPZd+?=
 =?us-ascii?Q?3PznaKzM/uDjo2efCfjAq8P51D5tGvN/cRQAsSxvAZXiutljeAlQk4+OSoxY?=
 =?us-ascii?Q?fqdd4e+ApuT2EpQf1AUGmNTGBXdbsQxz5ypLpoh1rKlzlYQW6fM0ybpVtQBY?=
 =?us-ascii?Q?MRWDb9ia6VPIFmF9vRvbW0Pq2B/g70mZhbc/ytPpPRRs0vLsrh1lSEZ5mCmD?=
 =?us-ascii?Q?PdrwVbiEZjLQnOYDPeEEeoS7oLgj949Kf5J7l7SEVhYAlywgEAkpLve2ACCK?=
 =?us-ascii?Q?MlADlv6K7+Tmlx7tGwMXMelLhklfgiUZ9BFcHz89O2JXdYONNb1Flt9L70dt?=
 =?us-ascii?Q?bwv2wpu5YnMqLfF+wmiy5KmTLq8Jm9aCHkOMY7X0eXzsqjkCoz8Zdm/bJEx9?=
 =?us-ascii?Q?pOtSgWv8BR6p8fG3f8o3N2k4GwfY0NcANy3srdtRgH+ptXlCP1fq2aZQuPUR?=
 =?us-ascii?Q?IRk5T26vk6gI4GbCwwNd1YsJq4xOnGDVRc2I2foU/BfLWMyl6hUyOoRH25Q3?=
 =?us-ascii?Q?mMNye3FgeGexEE/Z/BwVzghbQhCV4G10/Wxt0jnrKCELyGIVhByy0FTU4P0k?=
 =?us-ascii?Q?wNM+SzYVzNei3pxC0AvTCNJHR2iZJHLWUXnp+psTOga0u+cWRtmVtluF3nUF?=
 =?us-ascii?Q?ipsYxut7n2EoCMms8DVek1yQJoNWAPzvY97cGnUimObOG5+voQil5/yspyEL?=
 =?us-ascii?Q?09Byz4ZVtPJ7IPPXkWEXy5Aod28HhJ7D1xP8CjjjNJNIwv5f+6BXzBPU9RYR?=
 =?us-ascii?Q?z71bGUkU7+TXY8hFvZNQn5XcDDc9+z5UvD+uSCrq6T7MosPjbN73Pw0MX+Ei?=
 =?us-ascii?Q?t2wz9K99SDMPQdvET5Wir28eG4nhpk5LRGH9V+N37WCOPKqPcKFMk/VtWWE4?=
 =?us-ascii?Q?ZQiqBgC8aQ5NVLCcr9x/iQeZnEVawNEiA8q46xeB0cnllLvDTsy58wYTdVhc?=
 =?us-ascii?Q?shkbVvXe8ZsMQ4q0nApGhJ1JVPycGzeuzYJtx4aM8zJdLZjKph9n8DnyfGKa?=
 =?us-ascii?Q?F+qUTrPiO8YxYnf/wfpEPLnppxYvDBF5l1HMPnZW9+5Wu48d5gF5BNRBVlFl?=
 =?us-ascii?Q?2ZnrWx3sE3KwpZJ/LwPal2WgTKi0ke3TaIijux2KRE3FLCF8hjIMA4UzTrrq?=
 =?us-ascii?Q?efK58tIfJcACYS+PUmrjbPbGRhy0BJ0iQt4NuuGxUXRdeviB4Wjnyf5+cdzn?=
 =?us-ascii?Q?YJonFia04xxfKMLM/96TETLeUjjTGAA1LFlbF74UWLN0s7JVrOTlRf/v2V9/?=
 =?us-ascii?Q?i7k3TiJQ5Y+UMRI77Kh5ZaHev1MSke4BZSAwYora4zQAPwXsDyibCQyQMM62?=
 =?us-ascii?Q?yO1H3pRuerrzmBLDsGwl5wzyh0bm1CpcDO6D/u6pSdq2Nbl3kOBA25QoJX1I?=
 =?us-ascii?Q?hC9nznWFchZCBzwjQHJ0Z3UhuCRDmMzgJlqEVubmMOY32VwNLzfrU7mNUYMx?=
 =?us-ascii?Q?W4hXOtmpVPVd2cIa0X1wjp2nQeYC26FlGAKcVwHZ6Hp1QeBWnEqBYqd47M+N?=
 =?us-ascii?Q?ZwjY2EACw47oktgy6VL8VXKlw0yGMpeQz1Zq91Ur2jn+JatDXBbHkunIXL+6?=
 =?us-ascii?Q?i7p/MQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:44.3917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ff4b3a-426d-4e66-ef30-08de551b3339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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

It was leftover from when the driver supported drm sched
resubmit.  That was dropped long ago, so drop this as well.
Leaving this in place also causes userspace to treat
the context as innocent.  Removing this fixes reset behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ed7f13752f462..70faf914b4f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5817,9 +5817,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.52.0

