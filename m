Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB09C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B374010E7F7;
	Wed, 25 Jun 2025 21:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkXQEfjC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2076710E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBV+EIdJXRZPemDI1xTWOWLESp2MMcDsVznTLpBmmMnUe1TVNxTInK0FFi+D5A+YbXEBR8pWcJZ1hJkcMm1F3Xsef1U+RtJOqcErjin+2UZWFyQ5YUxkC3n3JTqLjG5ZT/a71JPHY4hthqiTg/KrumBMQWlR8FV+Qu7qkA8LecT+NHozhOPb5MhGaIw292xQNcfoiMVpd28mzCtxOYPqh7zHu2Bhl6p+C+mCiacgT/uXs0HzYs7f6Wj3LFyY6SRxZpP8IbzOuw4hsqiyv83FPAmRMDFjmpXZETixN1+hTl30E6jBwgZGkcCQuxeuPOYwv1qVbM5tdQwmHdIey6vYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEXYglyiGwgPF5lKm9s64TN1Q2pWEUu/tD4bWI7ABoc=;
 b=vCcCCqqQGwq1YHdDlthC5jq55a2GsAg4D2xLQCStxFcha6IO0wXJS+qRcJ5F4GBei6X95hP1CeaIOOkA7BaJs+c1ftviD4jXVoayyojoAai1FdW82BTldr+6zAV6Zq2xYR1wXAYZLX8aGSWczKGSe7rkzHrnO1XXycbo9NjcpnLJ1205gQkV1sj8/u6uyMnpdpAuQxJMHG0XEgJGPQeOZmiOngB9VkAi+IoeSwA9Ty1h4w/Gjgc2uLD3jqe6Fv5nTqAqnnAmC0xDN3PVI0MYY+e+uOExS8B8VVNaLq2UlnbjjpwsdmhHfDvJIZeapxEwlhwoEFIMSRg6UwuvDjMRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEXYglyiGwgPF5lKm9s64TN1Q2pWEUu/tD4bWI7ABoc=;
 b=LkXQEfjCWzb+guXoD9WJ0BjJ2vIpPMqGbu8UOdUN7oDyaHYiLkKJYopXo2RWcmHrqNC60CIolol1h3LU7hwAtiEWMwz1CtrSlmwJdcvBvel9y05jXqLwrJqqEtmbEzNPjNnlAfRa2D1+oOx9S+/o/EOUhuVkdA+EP+q+OGvb1nY=
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Wed, 25 Jun 2025 21:07:01 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::a0) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/30] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:18 -0400
Message-ID: <20250625210638.422479-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 07425658-b04c-427a-ed67-08ddb42c3a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8HWWrqUmD+0Tf/9DdzpOvErUcRBM/xuBNKiwwpIWBLJVquqp5jU18HbM9H94?=
 =?us-ascii?Q?eEOkmmYyo1+fKbd00NH5LMLV8jpwGuvdjupp9MM+i8QjXnsNHhsqjqaJXjsi?=
 =?us-ascii?Q?u1aSOzF4GCJK9HFwfwz8ech4wuw03U39NldWxYWAYALvSzwTEMAUnqYE08X+?=
 =?us-ascii?Q?Gww/PDl7oU4QtffXK2aCSrGPDNib6pVHrtIhfP43YxP/bRa4kW55fXpInlXn?=
 =?us-ascii?Q?pwRryrn9hU0tZ0Jc78JFtLb6Kd2HB1D28kJHo855mg97KPgkOP3Lb0ndrfv3?=
 =?us-ascii?Q?gocpiT9agyxaN8lsljCVK1Xf8OkmZQjPgKfjwGOkucgrF6v0NzFoXbjkLyFO?=
 =?us-ascii?Q?KKzeALwQfjwK2BxSMbWKvTOmiZvWQDHTiNwDZQjkO+qk0URpSMK9wLE3xe5/?=
 =?us-ascii?Q?LvGExwMMhV0XALtHm30DmcvNxbUoXH4mS0MykhmRgCbR57bslwmJBsDe8m1F?=
 =?us-ascii?Q?EoTqzmaQ6JCxVRFGvvvIYPBAYIKWHmvsNjYzYAcSDilDLngH2+8nS8mue7BN?=
 =?us-ascii?Q?UfLYLyg9ntv8d3v7jfKTeCEkAWnaCJuP/UWNtqvaob31XvmDIltpjkbKQlFE?=
 =?us-ascii?Q?3FrVxYM5FcM42FsUoNipcqcQF2k1A+mGQsDHGHbLDOixiu0zw+IFGhZD1zlS?=
 =?us-ascii?Q?vkFSQKFxN1yyUq+MBUlXFjMKpUTR0gnaioXutue2+KJN7wgzLrM7NyDf7YBV?=
 =?us-ascii?Q?47/dacu5hsSae9YSfuceIhk5EfhI9NStsA3mkNdzNtH/+LB6jWYlWvwOAfZT?=
 =?us-ascii?Q?y0S7MQbCZeAxObI0UF1Dyv82wNXpfWvQcPyNeviWh/e0LdUKZMku3NQToSfD?=
 =?us-ascii?Q?YHJS5RJSqOy8/JZeNf/9aNTgmDnRO7V2BRyLVQGxqaZzDWu4Ha7OKYY8uqqq?=
 =?us-ascii?Q?1Gw6DGP57WsYTnDjw6rXROlIsgCzjxrEZbk22otge39Ar6x24nyfxUtuK0g8?=
 =?us-ascii?Q?qb1MVPSPfk/tA9b1FuWckRx+Frg4+6T/oluy7yierubg3NExIlQXsvx/wrU2?=
 =?us-ascii?Q?xFys7O495wFAMkup2YWFoXW5zQj+U8vo/dXUySAWUAgcSXUksjQ1Fnme/8Yc?=
 =?us-ascii?Q?Tg16yJHsQwGH+39Z47BOtu8zo5Gk82chLgeLjxW+t3kPafnmoEpT8RcyEQrk?=
 =?us-ascii?Q?zj5krO8T20JsbMcyga/HGZvF1luGtORKdc7xZI3UK0eapyfqL+H7x3tivLy4?=
 =?us-ascii?Q?2RHsh09rM24ZUcNLC3jU0c0kGpe/70R1bO9GEKxP0ChBmoIvl5VlmYvwrUDh?=
 =?us-ascii?Q?4TOkiz0kmmM1HpMLnbM4gOTYIos0vHfCYP08/2hprOyQ9t6OsacZNPcj0dPI?=
 =?us-ascii?Q?Kt/flr45q0BYTDvnH9sdbjqwH0M6x4ulR/XZfW4cY/7uV7TVdPaQ+6OsnPTd?=
 =?us-ascii?Q?t74zxq2IsWDA6iurz0UIk9JdxYOk38n7gWRkZv/YTSJybLhvIwM8ogCRhbtL?=
 =?us-ascii?Q?tTn3mQj/XdAnp+CNyAVOFEjhKmefOVNKEfk4/XL6Q9AsD2tIuKQSrRUqEChL?=
 =?us-ascii?Q?hxRCxjSRIyH0fFRk0SyD+UcKD17tGS0PTGoW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:00.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07425658-b04c-427a-ed67-08ddb42c3a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 45 ++++----------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8c377ecbb8a75..89010d9c9d5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9540,7 +9525,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9566,10 +9551,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9579,12 +9562,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9603,7 +9581,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -9615,9 +9593,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9653,18 +9630,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9899,7 +9870,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9940,7 +9910,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.50.0

