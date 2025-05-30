Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C0C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E88E10E82A;
	Fri, 30 May 2025 09:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOJOh0rx";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B1610E821
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vm35IPSPQ67MjX2q1PlmdKIYuFLy5B1BaNAngWiW2j6eDyn1R/wGyV8xkgUEl8JIcFHp/SE3bN65Ceo2ZhSthVpcRoiNa5VBIlnKfLPKetkm8LMRXiU/PoFmcmDqQXhc1Rn1MfVmlvK+Cm06vz7AHzO8dEme/yNS/NBZJRuP9e9HBmlraJlPZdY6A4QCSfLO6SlZQU83/U6+Kh9X55CWp9IbP+JQNHpgxfjueN6BELaeMQhbGOUtoWj4osGVKsbXpiL1DoA9yVanaox/wM+u0u5Xrk0Ca7oqxJTcce36GWbohPjkPdJ6uy0YxhFIjBx9cQgdrcC3aa96k74qf4KHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HfLc3x6y2B+GnY0H8HAqYTYneI0HJpH/buU6WuBjx4=;
 b=NCI/068G11KkXvTdgId2XjKX93X9PV+d4bZTwt3NyBLl2EJwv4/7xkytE6ii2gjjsgSoBdCYhhr+BBFEZO2UKrpxioFP1hWvpDCvr+msZp4EVvlgpKgrzW9uU4Q3jGPkKu2HXTzB7WRmwYfBnLHIWIZiWQ3iIg/ArEaXKyWcSSJYl+hczdex1tIp4nm9Q+VBo+Os+7Xu2cOL0qHBnAru2tIPl7R0mRiHor9cvVJ0sY2dO/ziMAQMrTS3KGV0sdPP/lQiwujQR+QWgNNcaJaaDu6KqaXF2YZLL5azWUZtnSsZmw34a3n2gL1hjPinxFDJwc5zdCk3K3j39hvUDLxZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HfLc3x6y2B+GnY0H8HAqYTYneI0HJpH/buU6WuBjx4=;
 b=kOJOh0rx0aXbUrBHW1ZNCfNSFmnk0fZf4hBIUMKcg/tAMbbB1BbWsgZUam8qKC8yFyhpiiymOXDMHkC/rc+oz5PxtJiB5mwdiVPj9RoC315DcR9f4/si9mHlzR3WM1gRyv0lWCGoOLDZnjTHONoz17KsYJFX3PQNkB/TBAhhWLE=
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 09:04:18 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::11) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Fri,
 30 May 2025 09:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:17 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:10 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 08/14] drm/amd/amdgpu: Add hang detection before GFX queue
 reset in MES
Date: Fri, 30 May 2025 17:00:09 +0800
Message-ID: <20250530090322.3589364-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0c4b40-f8fd-4082-20ef-08dd9f58f57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gw3p6nzqRFoOyOpD2McWFhcX4RSl9M9YHYC976VECitUi56ALVPDUwHjzTf?=
 =?us-ascii?Q?accOKZIHx4bhwSOOI+oVzQ92JaGaujr2GCvd5PX/HI2RXoM/mglMZiAtWv6K?=
 =?us-ascii?Q?DtLIOFBaoWxD8z0wF/oti2PPgp703LmiSELdTB2T4db88XL15F0kYp7dizNR?=
 =?us-ascii?Q?GQoXw6XhYNQdhhX/8aAxF/fDQUXj9ItiwjZS95I5sdXa5Q0QJMhdEvYSttnj?=
 =?us-ascii?Q?gFkTQXhE591zauKmCDqz+CR3SL2YOVx/E2o7m7KZ8TkvXMLZSIRqczC1oY7D?=
 =?us-ascii?Q?y+OP1ZMj9J8Liv3c/qvsQW6nN0+IF1uKvjWQVx/zS1FtVq2Cjl/hbNlHq7NW?=
 =?us-ascii?Q?ADpyMuBKxyLB+dI8YR01OQdTgDoGGHP7im2hIuTBQWL+Az+JJ9SE/zeVDWTw?=
 =?us-ascii?Q?a0Wbt14POGqjFMkFEO7KVrokt3Ha265AWD9CpzJ/DhzvUtitA4QszfRpxG02?=
 =?us-ascii?Q?TX8M5DjDIvRalvY77K8YAu63k8NRSJHdDBbrVskR4m99RupeoW6ZYQvXME10?=
 =?us-ascii?Q?CweqFfyUl9jmko4TDca2s6dJn1wUHDf5FhAeheBk+LCG7S5WD1jzvXgwyp1q?=
 =?us-ascii?Q?GyxL1r+GvzgTeLytk7vAYbUYybrdYjhKQ0bU5g4EE3u3uifV3WY2cV/PdjSQ?=
 =?us-ascii?Q?NB2Aqzd2hJCdBLoHpQHSot83WOajxSmdaLTeeC7OTGxm9yMd9pGm7al6NvgK?=
 =?us-ascii?Q?LLLkWQS9B9RGxmh2CtVDkHZ3ymU7/4R9ZMaWU5ZCABpGzWzKZnnZdXmUGBq6?=
 =?us-ascii?Q?8iqvMji/79bl2TTr8wHKiLkEw2FBWwnHb7K+CZvTsgwL51p8qib6GsGHIAcv?=
 =?us-ascii?Q?sj2VqLBY1NjMlVX50ZVusKVwMcGQAFWr2qXOoGmJRmLYp7YTln+9byPPQJ9z?=
 =?us-ascii?Q?5GpRzmBD7eEYutbOj60pai41irWrp99JGCf1jRRiKfTse033syk0XUuvGHdV?=
 =?us-ascii?Q?n03ZcqMaG3GkT831sOFM2DfZYoLPYvuKNO7Q9WgkqqKFeVMaQYREm6H8iotb?=
 =?us-ascii?Q?oz76m1UEJIKY/9VQ980woOnWrx+HC2lcjMF4pSU52idcCBjAH6qcDrcyfTiS?=
 =?us-ascii?Q?gwQ2k9kXUb6FZTx0wHJ2OuZVXRYQtU+xkQF79Ezo9Jo841skb52M5X+dzvvI?=
 =?us-ascii?Q?5ZcTKjlFpSwmHfNMW5w/UjrcP8bE0LHlG9Ow76loSOAUraB2/VKotgT2FerL?=
 =?us-ascii?Q?4UUai4BbXa54uZTB5pbVFZ6m622qE4Aov7WrrhGjDJH/6iIi8hRzoL7p0zIg?=
 =?us-ascii?Q?rADXubccTPWw153PWff0zZptLvq4y3kjJ7FdhS5YTEgx2Pg5mddrdg6I0WDv?=
 =?us-ascii?Q?PGfRY6ni/QboAtxywGxJQK19hpJIBZCeJSfiirTivOd51R5qpeCqfDbG3e3l?=
 =?us-ascii?Q?6gVVfdbet5kNljcZmHO8UdmyhL/rr4qbuI00/WQGhhi7k/m0F7mPSgihHvwt?=
 =?us-ascii?Q?2twH6keIpSFiNavJasnRWC6C8jav8f61tw6+1mgdvboWo7VKbsBamTFkhPCm?=
 =?us-ascii?Q?rXsYzwzIuQEp0N3akdnhNCgYT41Pp6qIpyqR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:18.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0c4b40-f8fd-4082-20ef-08dd9f58f57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

This change introduces a new parameter `hang_detect_then_reset` in the
MES reset queue input structure to handle GFX queue resets more robustly.

The change includes:
1. Adding the `hang_detect_then_reset` flag to `mes_reset_queue_input`
2. Setting this flag when resetting GFX queues in `mes_userq_reset`
3. Implementing the hang detection path in `mes_v11_0_reset_hw_queue`

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..31826a20c56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -277,6 +277,7 @@ struct mes_reset_queue_input {
 	uint64_t                           wptr_addr;
 	uint32_t                           vmid;
 	bool                               legacy_gfx;
+	bool				   hang_detect_then_reset;
 	bool                               is_kq;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 650fdb68db12..2b5bd3691766 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -358,6 +358,8 @@ static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
 
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.queue_type = queue->queue_type;
+	if (queue->queue_type == AMDGPU_RING_TYPE_GFX)
+		queue_input.hang_detect_then_reset = true;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c9eba537de09..25ea06b507c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -773,6 +773,9 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
 		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
 		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else if (input->hang_detect_then_reset) {
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	} else {
 		mes_reset_queue_pkt.reset_queue_only = 1;
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
-- 
2.49.0

