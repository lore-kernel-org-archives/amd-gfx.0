Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3890C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E405310E8D5;
	Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OJEmPvUy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D9710E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRzwbUByOUOr2ojZu7ca0yFbuPn0OzEKaCNtwPK/j74pHaTYvHCzBKPhwbRUBl4CfntD4dAu5Rb19NR/IYUyAfswgZOXIqrLICc69lt4Hk038NvhG0lBfRHfCqSELg8AkmE3pM2KKDCEueAw78m2fmxpuClLbK87ygf3QlWzYs4JGDi6avJ0knwUzKwfBAJLlIsKo7/5lk4i+CtC/ZwqWbqaGYQRkGUvgVdpuPXwtko7vSPBOI9c34uIoWRLEJBh+Rkwl+HLzFRo0YIERCiOpWT7G35tGShstHYN4dTMgXDJQt4B/ql7+I0xjz0EHR5haSPmaVTfD+BbEq9SW0WOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXHOuSuXFJkO7M1RgrvWS2ssdNTn7NoFktl3E10HzxE=;
 b=ksqhePJ7NvElpT2s3g9Bn10ShciUmA6wLM/nIQkCIV8c2YvfftIU9QTZDqEPnpGJXC6zOvYLHfvv5QfybGb+f1NlQ3m2+VkOjV9qnVS+D94V+NZRHVJxQ/xOYJN8VZQhblnCPgBPVcVcoMw2bGnOMUd1d/8V+GNAx1NX9s694UUaYed3bt30P6OR3y14kq5p4Jt8/OMSugdUjpjUg0j1vpJqhkP4VTzdSoCOHGlDc9M5eobYvqsp4QXUTaqeWMuufNTWRWVNWRnyWuURYKZmqN7hX9FjquJ/RttN6ELuJzXmn4qn0cT1g7SUQgfZa0qf4URdeiJUQ4Lk2pA2UUl6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXHOuSuXFJkO7M1RgrvWS2ssdNTn7NoFktl3E10HzxE=;
 b=OJEmPvUyGhrFYPRzONnl7GclB2s7JY+qcXsIpHdEd1XEjo2XpJncnwWI+beDA/18ZAPPZ4RTPcHAfX4ceflxh4b6s+uqLmeXFhjsf0ewy7msrbSMKZ/mqV5k++m2BmeV8LvusjvlceGCallGDh9IQZmwnuGBVbrUtxj2T0bZzo0=
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 14:08:00 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::5a) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/34] drm/amdgpu: add new ring reset callback
Date: Thu, 18 Jul 2024 10:07:06 -0400
Message-ID: <20240718140733.1731004-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 8866385a-bd2a-4344-4a4b-08dca7330831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tdBx8yLcF6XqFh0YkAn1mNp6/Vcqxcy/4LgNNfw8QCaG9dgUWsANbLnJd5qR?=
 =?us-ascii?Q?dsd42d9Xqw2aOa85JQ98pJgUr4sc+D+xNK3/m2xdG6SIyfOQcRNGzk2ZCt+V?=
 =?us-ascii?Q?wn87NLkiOtdCZqTgrDPpI0cXQtJV3t9HEeCTWWarubwAnuctDvgUwkwv7euh?=
 =?us-ascii?Q?2Ay685cbsGUeosPDRlDkfEF6Sh5c/IJOsNdTCQCXn4u5lXkYIaUiZBzcJFrn?=
 =?us-ascii?Q?9GuX5C1Lov7CZDkeEczwMZBZfjV+lP9FI2KirGTmWmBGWkNy0378wttepbjt?=
 =?us-ascii?Q?q0viBmYwYmFYq7IWZnpNY0NO1jphEeEV+aNGYXOOsYYFtdySVCnKBciRrN1y?=
 =?us-ascii?Q?5CDHi1btgwLi7yp2FHMTh/Yb8Vsie6WijKekdDVFEa0cdIrsXTGKfo2B1RZ2?=
 =?us-ascii?Q?ExwcKmJn/0mOhHh6nFrU3f812L/NZjUFnbv4et4Q8+x29Bhm1yp1V2+0e8Gw?=
 =?us-ascii?Q?cF6mLydad27phpufKiawGj0UdUg4FrGUYjkDYw+mID97fQbZ8EWJGGSHGQw1?=
 =?us-ascii?Q?b8rbZrYeSJqxXgk4zleluct2o6coyD+BEVLkW2ed4EeKcyJz93ruWzlx1PX0?=
 =?us-ascii?Q?5+rgl6PuG6hDAMbAHRObTY12yk08aDLKpFaKRTfKMgM8WlUQ5M6uLK6iKmmy?=
 =?us-ascii?Q?mkxD4wyoCyayB/BkfemLrTBZDNjEIrsFti3lyZkIGk0ise61gzdate8xygoP?=
 =?us-ascii?Q?fI8hvP3y4kbzy/PK6zcxAG1HEwVnN/ocuBf83AcShZ+xINcTeey8d4inDe6U?=
 =?us-ascii?Q?4Qu0rZzpzubmVqtm9h7eZ6WOkXnpIxfJrXLSIhHw/OWsCpb9Ysbc9qs9MwP/?=
 =?us-ascii?Q?5jRk95yJsCYygWp2g3xmRzlAaTHo8DTQ6Q+Qf395IwDfZ2BCfjTECOnBkaQb?=
 =?us-ascii?Q?gtsZO6kdmFw97mjP4cUxvWnHpNl73AeyI+016iscaYo8jYvmjrBcrKfNoxa1?=
 =?us-ascii?Q?UdajiwUEtXg5WeNYBuYRPyWgly0qE6dyhZ/zTjfKTXKlZ3sluPqvhA+xAASq?=
 =?us-ascii?Q?3DLGhN17Z8MpN5cyOJIdoXAXL4RHcBUEouzJDfjp3P3vip/y5YCh2EhVsKKW?=
 =?us-ascii?Q?avCT87IBj/rkqvZlWdoIqpoH6Vm59fn8/4CirnoXJAsuicpLLTpk8iWaEK0K?=
 =?us-ascii?Q?EIJOwkwAP71/CoUebCN9sSBAwpV+Jz4jcjBCIWjlK9jZ8rjlRB3N+qQQEqz4?=
 =?us-ascii?Q?K5fpqJpU19MVb+1MGbKzuWZELLDAXegodLEHLvF5gByNeSsMct/bePH7kH90?=
 =?us-ascii?Q?s7okX49Nn2DI+lJS2cG+cI3j2q6FNljM4Z5Qrok/4uYBSpi1VegZ5hMcB1Vn?=
 =?us-ascii?Q?ZpPcjJFiWsQqaV7NGTm6yvoWx90vMi9Jgdni4wK1cjLqSjFp5qlsXg0dSNty?=
 =?us-ascii?Q?efRLOegZrvX5mEx9tKa/J/jOfq1dIlJqmn3498olxo3b/rut2MBUpZo9buoG?=
 =?us-ascii?Q?UR/z2xexIQUG3poq01ePsqlDFwdd4LeG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:00.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8866385a-bd2a-4344-4a4b-08dca7330831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

Use this to reset just a single ring.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 582053f1cd56..c7f15edeb367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -235,6 +235,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
 };
 
 struct amdgpu_ring {
@@ -334,6 +335,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
+#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
-- 
2.45.2

