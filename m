Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9F3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B32E112C90;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fS6MlYnt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC5B112CA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJvha1xt355xTVIpSzsbYQxP1Mxp4ZD6+aEh/BDPF5JoN0KKYibHEgkJQZj3Kh+vOWseTBLcR2bP9YrGk7v+oFaP1HEJvTLs0j1CY1wRbehsr3+/L0cQIDGkwzc0D0f/h1ZseP1q6OEPs6YL7TIxIIVDPCLlcW726AejQjAOqxytc2476V1Vn+JtPFwN5Dkw5LGDu3LsP03Lh/YBPrUtz+dt2Sl+vVRFcyKxSqZlPbxGfor03OOl6QtO7EKcdpqhgDfnjBICRY7dVgw4+aUkKyqrmZKJb6dD1lDTahxxIxvRCCJn9WGieDOH4ODVEsblh8bmtYEGEX7yWEgvqx5Cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XuJ3kidDDq7zUZLeqV29vg1rKY34q6U6PiCW0nmYbo=;
 b=LGLKLmEC9jJaOP8WBvkyV0rfp7jwGgCkhZPdM2QO18r4kY+i8kqsYLzKX+01gxQHczKDq4L72koVExm1vtvdB7JiuA/8jHlrK0nbkYEYjExQd4LHCg8TI5PAtQbvzTUb8h9sQTiRYE/7ocVMbcA9W2d1q7wbsR/NrjwUVLfSq11IUu+BbuGXDzWs28KC8fvwgGZKhSJ1Jf9FV702Sr0rA0tyZVJ726xPSQeQqOhDQ9JrSxbXdC46ApTjtnvpYSE+P0xAwbAo5hI0RjQtax4kOugJfb3nVMwk4m7c5bpr5Gd5Jdq1PeACltpmsLjnI7WAIzrtcOfw56iQicHoF+u5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XuJ3kidDDq7zUZLeqV29vg1rKY34q6U6PiCW0nmYbo=;
 b=fS6MlYntPPIRm9b7ZbTrWH4BY1fSU14lyJf+qx6UD6jAej7mOrMX6YBKmDRyqdopW5nppJbfoH9VnapROnmxHYB7Xb97Yj1mdyRjjpP7YqWiqTOtUkHYKXDHsXC5y3Vj7piELk2iy9rnUW6J6LEW7AOuXWs4kAEK1RxA2+EAbSE=
Received: from BY5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:a03:1f4::21)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:25 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::4b) by BY5PR20CA0008.outlook.office365.com
 (2603:10b6:a03:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>, Harish Kasiviswanthan
 <Harish.Kasiviswanthan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/31] drm/amdgpu: Enable unmapped doorbell handling basic
 mode on mes 12
Date: Mon, 29 Apr 2024 10:33:38 -0400
Message-ID: <20240429143339.3450256-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a6f063-2ba4-426a-d7b1-08dc68597809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cEge4kxuBNUZeFHt59Z/tFkzUYFzdCbirQBaPPzDp1LjlIPJo1w0trYrPdqb?=
 =?us-ascii?Q?asz+9c+SaPnMcNaVnHk7v3sx8lPXoyowcsIiQA788IDEa0R9rsZiDk9h359w?=
 =?us-ascii?Q?HKqq64NRW2XSKqWzZ+PyumnlnmBM9rl55X+6NkSpgVpkBBRmsai4UVBdmSIz?=
 =?us-ascii?Q?wZAbQwBvin4t+JlfH0g7ul9vUlZ1X4sds/aN2wEwXuRMQYLhwR47zzeNwIVW?=
 =?us-ascii?Q?Pg93zcm57VuN4vTXO3xmPA/koQwVytCVKxYNEHUigubjQoaQ0uzo3wGDCLAZ?=
 =?us-ascii?Q?XV+eWSWNO+JgbQQez4y7KS9RRnEF6KZyJiQp+98teKoN3evlbxZwZvSxZ2cR?=
 =?us-ascii?Q?XpkICXnW5e5QRIulzymHe+Z31YTojpaOm+HZVe7XrlgR5PxLSbF8OEbYS+Gy?=
 =?us-ascii?Q?QpIISK9PMNUspq7JQkX1WhEKbw5ZF19vzE9zA4iK1RJqM7EPmmrXiR+gaCx/?=
 =?us-ascii?Q?E2UtXnjEZB68OyCOEhME8ZXxVxVkp2LA+3OmragJc3zEXIyqntQ+spxAG/CM?=
 =?us-ascii?Q?NLhD+H2GRXa256fk4mpzDhuj8auM8Cn3sOhjVHmTUSJdxmTel3I1Op//vFLf?=
 =?us-ascii?Q?0wYcDDbM0eXPydZP9arn1G8mcM2dsrxHeW+QQhxsKGlmBdEER8KnpvUuFFv3?=
 =?us-ascii?Q?dEVUhhT/5vjasBrRh4fAwDKEEE30jmdZcwXYZMIIVBAw7D22oeytXSFlVC+o?=
 =?us-ascii?Q?zY/OhpEmJeobW1uVHwMAmnARryoBNvwTnz/7v21+zm4qfuqZxhQsNdERFNHY?=
 =?us-ascii?Q?6mHjZ1jC2vV9TL+z171I7iWbmzMDmoDdlDU5w27ojFDb8X8RQVXrrIDXTtLH?=
 =?us-ascii?Q?vQro8jxaG/8hyTh0i7K+mQsPpekdv1G/NviBgzfvL/0PO3fuBuWgzC05psNU?=
 =?us-ascii?Q?ycHEPh2q8uZvrvGqtk0qbqpupxUihccYnE60n5M6YzZKgjTkVGgzGpne6Vr6?=
 =?us-ascii?Q?vlXkIcsHBkoe9SeV/PxfdjOKvy/etodHNKxspVwwo/czVQ1weADBLCUlElUH?=
 =?us-ascii?Q?YRfpiwwn5Cku50vGWgko8LbidnH/iZR0eQNb1wYRVAjl5PjoPXyrDpPE84eI?=
 =?us-ascii?Q?XWW7zXyOdEBnp1EiApJGfgFStPMmL/+xoFfhEnHnjV3djq/5ngJQS1O4YtWJ?=
 =?us-ascii?Q?GcB4p6DbGHOpyHhj122q2puV1J3PGrIulhQcIef8KDRVe4dRg5MPBh/7FGum?=
 =?us-ascii?Q?YtyA/uv9uP4TYb61HLM80gDZtR2AIZHTk6GMJUVrNX4EhErd8cxx+gM4viIq?=
 =?us-ascii?Q?BCa0Up1KbE/AJs3dfdNo2+mMm7PyeA1rxDGfZeTw1E8w7r13bwVF45urLG7g?=
 =?us-ascii?Q?Dxb6H0/qSBOkZAeBoEAu4itLV9YzL8mxhhf1zV8dpiGeCeHirQU2GARhsfsH?=
 =?us-ascii?Q?Whz0MGwjp8sGIArNEq+ED4w47ZJj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:25.3806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a6f063-2ba4-426a-d7b1-08dc68597809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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

From: shaoyunl <shaoyun.liu@amd.com>

Enable basic mode handling for doorbell ring on unmapped CP queue.
In this mode, MES can start schedule the queue mapping based on HW
interrupt instead of timer.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Harish Kasiviswanthan <Harish.Kasiviswanthan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 ++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 2d713e7b976aa..4a041cc22f68a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -394,7 +394,14 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+
+	/*
+	 * No need to enable oversubscribe timer when we have unmapped doorbell
+	 * handling support.
+	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
+	 */
+	mes_set_hw_res_pkt.oversubscription_timer = 0;
+	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
@@ -831,6 +838,13 @@ static int mes_v12_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
+	/*
+	 * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmapped
+	 * doorbell handling. This is a reserved CP internal register can
+	 * not be accesss by others
+	 */
+	mqd->reserved_184 = BIT(15);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 81cc0a5540492..2cdecf937acef 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t send_write_data : 1;
 				uint32_t os_tdr_timeout_override : 1;
 				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
-				uint32_t reserved : 17;
+				uint32_t unmapped_doorbell_handling: 2;
+				uint32_t reserved : 15;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.44.0

