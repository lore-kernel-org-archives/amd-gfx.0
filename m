Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B4ECCD1A4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A9810EB68;
	Fri, 17 Oct 2025 08:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0DSOBAcw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DC910EB6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+3lPYGl9UlDo028Jgs1LKuTyqCQQ9q9ZHm19dqXBkQPk9+Se9QYT9SWHlNBxWJYahF3WoE9E4PGCRRB4p+/67qK9ccIKKvcX6F3yDSUTmTB0ndn+16pEwlpGvrQ/Tw5RzeRcIcTmMqKAI15hMmYqhy+Uxn3KjNOR3Geovq3slAJXKQVDVCc6YOKvnFIfjBEC6gfkS1tIFOQd47XcQVGhJqsroINuJOojR/Oz0khKM7s/GyrLJfB7LW9Fy9/ntp2Nd/a16sw+LCaHprh+Qijah8kt79vWcoHRQVL3Id2dxllx+rFLnKYkDic44U6updx7OQHslTVu6fnMo/4wmsI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=kswZQNoOWkMLmlLq9vTafwza8z7AJDwh5sBm3r22qQsNp3FyvGtDYTsohZ4w/XPmitW3ZSvbwJO6vic7jTVrbRgJBdfu98LzwXlVQuFhVJa2fePdXhkwSeIW9oHAuaeZ8jGwkHLNunOxC6yDU4OM8GRWaiYnF05Ay+VPX/FVoPnlYEOyh6gNueroxJG/Qoc1M0NTpth26U0auV+9tCX/OagFnFh5FKA/+fcmz5uM8ENGqd5DjjPjmMbYpDrxg8zi593xNOqVO942puLsk184G9IjRqbhls2CHZruF2Fs8X5yPUbBv1bc64jwaKA+89jjw5sswGGh7qjihb7CUsKDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=0DSOBAcw9tHylqzlQrvD4W6+GqZUZ+w7VyPHHMps/Q8kxrrk9GSnopr4YLsjG6MnuaHgX7vdwVtNx7w9/ACRStrT7PKbDPG1eF4fVb5kT+ws0ZHf7ypfHVZnyJ8JmaUIDdpWGqjUOuvUM12YuXoKaZOlQ5jbxMFowfYMSKHLJTc=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 17 Oct
 2025 08:43:29 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::62) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Fri,
 17 Oct 2025 08:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:29 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:27 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 12/18] amdkfd: remove test_kq
Date: Fri, 17 Oct 2025 16:42:16 +0800
Message-ID: <20251017084222.54721-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2718997a-f091-476e-d35c-08de0d593ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R2DgF+v7p6EiTbQeuNt2/lhQHkmF8kBG9+A0N+7zEE5tXZDFe5iEj1nxnNi1?=
 =?us-ascii?Q?U8O5KxgiNpCy9htZ60nnAIC4PKl4yjY1YXfA30P0ElZ8hBWFt7dCX0pNVJMY?=
 =?us-ascii?Q?G73O7/KoNEBsQADxM6Cq3QeVRPqXjqeCmwn9eSFvGR0IcLGFobtRQfDuJrle?=
 =?us-ascii?Q?4W26ui1BBPxn1cyMavicyhBBcTVvoOs0uOg4QtoD0rkZ62mXjWjZ89GMs1ZN?=
 =?us-ascii?Q?VLN5LYw9YCGdq7cDl6sftdX4r/jAWO9o0Uf9E6kJsEL3ETKvDdf//gQVrKTE?=
 =?us-ascii?Q?bEiQKyjezqzZVln9FPdkbQkdn/vsG9aPPo6YTrsYwag3OSHck+UMMPYqPGW6?=
 =?us-ascii?Q?cJNXY3cp2ZGKpJZVdtQxImyiYgjxNc5c+t4x0fDPypBFUP0pMbffy082itjZ?=
 =?us-ascii?Q?ZkgYtJWyejhDEMgbppmRjsWxYmK4Dart3zInrGSw10JprrzKxjzL47zPaYUJ?=
 =?us-ascii?Q?1JVOBH4SEMIhJXtw+jfidUZvhAQFIFZDVPopNyTlZ0+pLTbrISQTa4WMtbr/?=
 =?us-ascii?Q?NL2TC0I8u8yNW+FyehqTZ0hLOarHkzRepldEanj59BY9kEmHADIvvsn1EZv2?=
 =?us-ascii?Q?xGx4y1veny7S+sZ8wP9P5h3olydOfVShG04xj7CweVLqic+oMftJa0y8I0Nv?=
 =?us-ascii?Q?pEc/ncMrRVLpM5yJht3uqmGMucgL+4PYGWB2vqXfYzfgwBjd40IcGPQGZOh5?=
 =?us-ascii?Q?7M/YHj+vMTOv0IDM/8vtUM/AzsOmE/HZD0hUb0nOQcVZAU8iU5YrAavvcJN4?=
 =?us-ascii?Q?VIeGz3zMr7zGe95hJwURiiVLlLirNcRr05ttgYudlpipfZJZlWDSi+mIm2jB?=
 =?us-ascii?Q?1mwM01Os1BqeWrEPDqO21OSmkzYAED6zpibVwydKQrr62JqwBBfSFXTzWNDk?=
 =?us-ascii?Q?1GDCuC/Rubnqs3EvCfeIBg9p00ebRwqMZHbtll+Kx5bgML6ml7D6kXcb92kX?=
 =?us-ascii?Q?iGQ5qmpMT7x8IaHPVET09b1aiPXh0EpMEuog+kO89IqeBYS6iNi1/VVsbE8v?=
 =?us-ascii?Q?VaMlY7qBAVTQEqxvNCn1f6JMXgAOaBXdrMs8hzl9BawpPg03zAbyoohQF4AY?=
 =?us-ascii?Q?81X6ngn1GwhT9mQM7K0+QW+xvzSOu030DdUk7AyDyV9n7zABZ6qK5jxNQANq?=
 =?us-ascii?Q?/DLlMg78Fkwv/9MgAhH+T9gh9Kqhwuno6/iyjq/PDxYSUDbHz19KjcJWEWnf?=
 =?us-ascii?Q?qN8c1JOSQhs05KZf/9uQDHWT4T4ksnHblR0LLKVZpebYszprPzr6VkHHUh2X?=
 =?us-ascii?Q?u/FliOOfDyMYXwmMuyIV+KdG31olR25IDOc9zVzLHeOMJUW5asP5NOCTQWE6?=
 =?us-ascii?Q?fd5Him4GrNM9OK2h1RrPaIuLnE9fMW77EbAtcZjHmjEqiLhqbixdbBoRHayT?=
 =?us-ascii?Q?F0dEhPoP8YgHxF2QRRsI6HBCyDfjy6diyo8d1EItGeDX75kbT0bi2d23emey?=
 =?us-ascii?Q?DGe6/SQXLGWnxulcDsgwZoYV+lcFi2JCwMeAsZRXeeuLTz91ajoHnI0qDHTo?=
 =?us-ascii?Q?zqEuqlacnNSzSfncQL2OWA5wyUXxD+5h+SU+T/i/nKqF+rqwFOihPxvtcqd/?=
 =?us-ascii?Q?lrcH8t5puEI0eHVlqDg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:29.0749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2718997a-f091-476e-d35c-08de0d593ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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

This commit removes test_kq() function becuse it has been
marked as unused since 2014 and no other functions calls it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 19ea759568a6..baeabe3feef8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -327,34 +327,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
 	kq_uninitialize(kq);
 	kfree(kq);
 }
-
-/* FIXME: Can this test be removed? */
-static __attribute__((unused)) void test_kq(struct kfd_node *dev)
-{
-	struct kernel_queue *kq;
-	uint32_t *buffer, i;
-	int retval;
-
-	dev_err(dev->adev->dev, "Starting kernel queue test\n");
-
-	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
-	if (unlikely(!kq)) {
-		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-
-	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
-	if (unlikely(retval != 0)) {
-		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-	for (i = 0; i < 5; i++)
-		buffer[i] = kq->nop_packet;
-	kq_submit_packet(kq);
-
-	dev_err(dev->adev->dev, "Ending kernel queue test\n");
-}
-
-
-- 
2.51.0

