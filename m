Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA91BC369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF4D10E89C;
	Wed, 16 Apr 2025 08:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pFyDm3wI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9D110E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSFqrimTc4nBqdJSDcW+77H2F8hpjAgBw7DEimrlWaPVsjTVRkHbgaahu5Cjwyt9AgGEKXhDexZ0//85QNLinFe/fAEsaiyq9a4Pc4NnYCncfpJPq6Nu6lLwXmQS1RBblsZb4aM37+8oLBURK1zIAcyAGB/OutM18ixcqGLnvZvOoludGnQoXnouAPMB5+py4YfEWeH3XHgdP3STw37u9j151PONqdxxCczBajom7ha9MrnY7A2iLOAi7ClhvpyR/ZMeiCOr31ikdp3b71bKZYHq1pzrSgpr4jFcQuSorn/Y+8zigRCBrdD5wjVne1pqdPpksiwWSuFtIaYG4FleiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPYCFOOfORaQ3LREnnRmaEwZOpQg82tuh4yz+3ebRm0=;
 b=zNT7uxrhLaJURVNyuyEmJc/buX6TEF9XMS+HTh4ICYCkM6y29k6nppz5ZtG3rmICSGEUXrY3P4uTPw9mos2YzmzcOwpHLXfUatupnavV0Z+OILB7i1nACEtYzL9L4+JGZYcuUedsvIjjROMlApJahknbxQyFpCBX9F1Eb2HoYVaj2rdXH26WfoqzTuVj7bUqQM7HAkEhKjepcBx8ixir1vRD8je3JN6G9Qia5JwHsrQWk1GWgKoBayCTeY5imo/noetZkBkVXZK+9t0OJL/spD/ckMGtFqc66phMEPd2thojuhmnpJcBqkib4bpGu5iFdYCQe5A0pUA03STvQg51Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPYCFOOfORaQ3LREnnRmaEwZOpQg82tuh4yz+3ebRm0=;
 b=pFyDm3wIjnVQqDgfAvX7vbpTajgZ2J/m8zuIYhuGZuhYdeCuoLBZedpV7wTXQofagnlCBQ/c8zwwzm+CpX9k2YxpsYEDPaSxKpoqsqQjahnHjG4thNcE2FoifcgsHJ920hXbvqkVGA7m5453wgMzKMGCHCZnvVhyU2HwgIXDVmw=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Wed, 16 Apr
 2025 08:50:45 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::dc) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Wed,
 16 Apr 2025 08:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:50:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:50:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence name
Date: Wed, 16 Apr 2025 16:50:28 +0800
Message-ID: <20250416085029.2278563-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416085029.2278563-1-Prike.Liang@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6f0f05-ccd4-4ca6-3315-08dd7cc3c6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LX5F31Li2Vgk4knP2v3N0cvLfPJ6RhHBGDxKKPv2ftXIr8Sz7fIo0yCDmuPp?=
 =?us-ascii?Q?ZvzC1uhrUq/AW20GAmlluk59LvrltXBKdeoEMiR5Q7wxKivl20/4qtY4B+qE?=
 =?us-ascii?Q?EK+jMwVD0ewbyKt4ADsd+6XyBvn2v/9lik+/K++hvVOojYqug/hZmbt0yx7A?=
 =?us-ascii?Q?usbEq2m1eU3ESE1ssiyz/YwuPlWlnglzYXwW8AcU0InyMDGBAZ3OnKycMLzu?=
 =?us-ascii?Q?8u4TA9EmFN3CE8fVKkP9cDy31pZhbkeZRcnDcHpeKy08Q2b5toVnGkgEGTLH?=
 =?us-ascii?Q?uKRaK94vvRdofI0HvzE+bxTAAgtGaHGYlRGtA4UKqBGMvtzBo0LMSgH4kO94?=
 =?us-ascii?Q?4XoyNBqUoiHhyelvmxhKaSpla4NuR6L5bu882CaVy8BVAeSLKKXa65dL3Khe?=
 =?us-ascii?Q?0uw3BQeQu2iK6tG9HyQKTZUS4xG0HdpMeF7BeLSCMK9AzWWIdPz4sSlBmKYl?=
 =?us-ascii?Q?HGqIKPm6VxCDs1CGk/ZjbK86Sd6gWUTcmsMJHpKxd61geY67oQepaVoxRxEA?=
 =?us-ascii?Q?K9puKOOT8llB4rCG2gbQ5ryMZRWc0Mn1tuNuWchuV42EX7kz+HDsSqIEyUWk?=
 =?us-ascii?Q?yBZyrk3P6+iCNv05RcXbvSlUy98GrHSxJ5QjnZIzcPBkpqc9LI/KV/JWPx0S?=
 =?us-ascii?Q?ystTK83f0LVj78msKkI/aTukGna86OCGMecJ52HT8iQbBwMeC3Ba9D9msWsF?=
 =?us-ascii?Q?E520usR7LNd2uErBDTeSbkKHHPfpQAMGcXfvr/9Ie9NiP6WmK/V6UBxuddW3?=
 =?us-ascii?Q?LiSr6KW51bDt8ap7Tv6vBr+btynZb5yBKRZJ9bXWjFmIhiP3oZjhOTF+2jPm?=
 =?us-ascii?Q?JW0Sp3P6OFMf//l5Qo0X2CrIlqMUOzZc0KRBJEeu3HV0l9mP+l0uWteFdXW3?=
 =?us-ascii?Q?tSDll7EhQppeH6fNpm22Pb1Ha7e43x9D04uCrWTDRw94OEMYl8rPnmpqR/02?=
 =?us-ascii?Q?MYvG0Z2WYiDMUpk65SjaM6MlgRxDWKyjWpjaNSJuWce0UVA5mJxP9xo/p0Sn?=
 =?us-ascii?Q?z/GgSIUsaIr7cPKl8oy0/ozv8MXxX/pg5dAPZVHJaRVF3gQinvxaCf3YXqQU?=
 =?us-ascii?Q?FCQGyFhmj+6gwsR1bJPLKGb994AjHhzEjKQ8vm/hk/W/i0COqqBOblgplYRX?=
 =?us-ascii?Q?ooWZJzFwcxbgxLL13Aw69208zb6qMADhT/9TkjwKZG6NISlzGFyftJ6YjvJO?=
 =?us-ascii?Q?eZtDS44brEzBiFvscFUhqLYSx6eduBK4wrZrQif3C/KtAiVK2J4ETWy1xAJS?=
 =?us-ascii?Q?JOMThiX8RxRa0nAKHcV6I72Ph8igKn0KTrBjZaru7bxoEdNtKvmuwDIelQo+?=
 =?us-ascii?Q?39YTaSOkGhlN2BIyhCcK2E6EdrSWWPqOvEjA4ewZSPG4s8HVS6fhehGh6dOA?=
 =?us-ascii?Q?f/HOK4rEwoa81J+dSf7Zm4NO4fVjM2rMrbmjbZ7LM2LMzADWi0nxSw7/95Z1?=
 =?us-ascii?Q?8fXTPeI5r1JVA59lQz6wRNb1OEW3QyoXWaakGzyWujsWfHs2WiYb0zKZ7Cnm?=
 =?us-ascii?Q?N3COZnlHI6vi3a2YaDCVGCWQoxyTfhpH4L6Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:50:44.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6f0f05-ccd4-4ca6-3315-08dd7cc3c6a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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

This trace will help in tracking the scheduler dependent
job fence.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index c75302ca3427..473a2cbbd7bd 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -91,6 +91,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 			     __field(struct dma_fence *, fence)
 			     __field(uint64_t, ctx)
 			     __field(unsigned, seqno)
+			     __string(dep_fence_name, fence->ops->get_driver_name(fence))
 			     ),
 
 	    TP_fast_assign(
@@ -99,9 +100,11 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 			   __entry->fence = fence;
 			   __entry->ctx = fence->context;
 			   __entry->seqno = fence->seqno;
+			   __assign_str(dep_fence_name);
 			   ),
-	    TP_printk("job ring=%s, id=%llu, depends fence=%p, context=%llu, seq=%u",
+	    TP_printk("job ring=%s, id=%llu, depends fence(name: %s) addr =%p, context=%llu, seq=%u",
 		      __get_str(name), __entry->id,
+		      __get_str(dep_fence_name),
 		      __entry->fence, __entry->ctx,
 		      __entry->seqno)
 );
-- 
2.34.1

