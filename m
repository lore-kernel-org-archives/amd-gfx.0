Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC430D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 06:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0C10E10E;
	Wed, 10 Dec 2025 06:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jXcmPJYM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865D610E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iymtXTbHYJURAJCIfC9MY/CqOmllYIaFQq4Q4KGilju3GZwtCVS7WvSy1SU9rkSnCbSlWVPHCfhX0CKcBpc4a/6c5uvNTRto+S6b+W67ezgtt5F2rAiDCtG0XhpmkkKQQpbuvY2g/pkDikxepvyNyFwa69dgPL9HrRceHy2nibfD4BVtVDYHKudMxRoRc07pBMclL3mI3QlF+vDwM2sAaZOX0zQJTNew8bBcK4s4hhYe5g3G3bUzl9OkLNQerZHSCdDR0GvxpFLOHqOHLX1TgUHMHFsDTfN12r/0GtgHUQskadg4J4a6h7cHtSSGU/XXotjyOwDiSd1aqeGQ5xHv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC4FU+BsIL0PGQRr06axooKaV5+2dTwQ2pVc518CALs=;
 b=lQQ3SHvCwr7YBRr/Gbq39Rm7cJzhvd9D5lsmC2mtC1zt11N4Rpa+fQDm1G2tPfS6XKSEio3QGsLm8VTu3S0CMfrK2DmDiyxiI3Ci1cw/sVn+L7z7Sht3zJNP79x0FSKQ7040uJW/4piJ51ufBXZNa+egIB6acV/sO4QuxtVeXdnSe6bD9dODqhNAMBCsxZ1APCyz6s1ZAR2htnyRR275VeAbFeJjcPRNJmhIX1OeKIkU0ANn379YpJ1zv3bIMIvP2RbU3HxDnIuq32bW7MQP3+US35uaHjbabcIf3vMIMQ47TroN7pl/rz2aY/zmZ19vsj98G1LF0f7Kc4XIqvPknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC4FU+BsIL0PGQRr06axooKaV5+2dTwQ2pVc518CALs=;
 b=jXcmPJYM/YrXkEEcASScAuNO+ZeuQU1CYpqsrDwTohSFw2xJ6JnJVi8S+qbp2scDjRaI3k2pIwLqcx2rKIpnQqCHy8pYd41rKwPRV2n18tOb0f3nlKpgszKmKOMJ2rr/Wn5qWBFQeMcysTwooNU6oDzHFIezGUs07vLB8O5hz88=
Received: from MN2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:208:178::14)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 06:53:35 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::a4) by MN2PR19CA0001.outlook.office365.com
 (2603:10b6:208:178::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 06:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 06:53:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Dec 2025 00:53:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Robin Chen <robin.chen@amd.com>, Jack Chang
 <jack.chang@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Roman Li
 <roman.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64-bit state pointer passed as 32-bit
 GPINT response buffer
Date: Wed, 10 Dec 2025 12:23:19 +0530
Message-ID: <20251210065319.540578-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: eec9adf3-b7df-442e-8dc2-08de37b8d671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ngTyDXnekFYTeAHLk6PLY9+mB8LT0MXm7h8V7Tp8RWvMn3Dh0av9tD0BeR4A?=
 =?us-ascii?Q?XrChbuvj1kmWVWeMUL7lx+Va+NnefseuVyUgdJGKpZQzpkhZmvgL9f5YBqIK?=
 =?us-ascii?Q?rUEe4ug4lB7kSnH0jvTZB9orJ8aQWjeR4dPIuGNcrRcO7qNo4iV11ka+1P2h?=
 =?us-ascii?Q?sbrKiy86W8RqxU1+B1GJaPHr4bs9PuupG6N7y6zaJzgX/taMZQbjWm60WyMv?=
 =?us-ascii?Q?TxwcQaOA2EUIcxpZNUXHFYo7UxJss+z3He8cOfgtdLMr+C1Es7Iyxf9vP+xy?=
 =?us-ascii?Q?PIYNYqnWNsGCJZvUHzNp5gba3eXObPekbf74oClpnAPIC2DTEy9f+RFtr0OS?=
 =?us-ascii?Q?Qed3PiZFJ9w5Jsq8VQLwl4EiS/Cvd7skzKG90uMvK9cz1ROCgSLlQ7YwOVFK?=
 =?us-ascii?Q?1vVdqVRIl0WLuSzJES6gRfnq5qA1VmUmyFDUpT786DeQNGNiE2lIqQCC6abZ?=
 =?us-ascii?Q?0nagwOpL06ABOy8O69sKbYrsCYWHBl2D7iEY+DxpVvrqmRR6XlsoMYJdoNTx?=
 =?us-ascii?Q?iyU3DCHgQU8riR61h4n/2MhXJtpe0pAHHCNJqf22TNwakRWG4jum6sm1mXzj?=
 =?us-ascii?Q?3uH7IIMuIpf9C35DySqpKansFbXx2h8WA/kfBxUYGr5q3NXNLi/4htQW37Ou?=
 =?us-ascii?Q?MHJ8GXVgCl3If5UvwXNdpCiNM7CEpBA0PQGqvpfUTb1sZY5uNkeDLe9xn+f7?=
 =?us-ascii?Q?bvHXP+yJoA7gNVYmr0wv5zpoe0HpSh+PTATqdmtWwK/rI9lqX2coCbJNLxG8?=
 =?us-ascii?Q?FN09GuIKmyctUKi/QBUXrHtWdMdBiGI6hRi3vyKWNOASDnFwvtK4v8JV011E?=
 =?us-ascii?Q?43jozUmmKWZKUvafAthgHd2G0vxwSOYN6XYEINITwgsanKdqXGcbcb/FIqLw?=
 =?us-ascii?Q?gg52kDEjDc3gZFbr8qu3da4fLXGy5iUIWNmccDvNBt740z62aT6EvnNNNF/h?=
 =?us-ascii?Q?kauXCIVW5+PPIKxSPVyrs7DpJ1kk+c8AtqMUZdr+mjM+wC/hQuTdL3aF37dZ?=
 =?us-ascii?Q?lLIHFFDqnquYaNXhYivbTOU3IvHiia1qLJATZuAkQ66U4kIo3rclsXJvoPL0?=
 =?us-ascii?Q?eeXRmgXyCx5/1KiPV6tG/aSEN0WZhNIjdoWtY2GtnzCc9HOWofN82Y1IczYu?=
 =?us-ascii?Q?hXWvRUO3zXDQdh97efIKr84O2M9ZDIB/XczoN0SlXI6GTNYvuM0MyGiBLn6R?=
 =?us-ascii?Q?tTIjYLHtLggHCVXeKhyryZEgBj3oZSnkWGEyW6XaRMl4E6AtLgCIPBFL7Zkt?=
 =?us-ascii?Q?IY0XRl3Zy1sHXe0kSZ9MToFQqXv80M5Yzuit0ePltIRiwMjn6lpsCNMnqfWI?=
 =?us-ascii?Q?VdUgmHYEdbs5Gf4QBwshxKWyDO6CHbdOaNxhI4xKNlIvkhiguIAfE1a8W3MP?=
 =?us-ascii?Q?MpnfqJAB6CKBPJGxfrd1eiNs8kgf943qRZ39wrKhlrv5qAAnOIK6fpKstURx?=
 =?us-ascii?Q?tTELjBogVZDIHHzIeHaNpmnWVNoEhIWqmkrrOtkZxLbY8Kk7FtX68zxaE+r2?=
 =?us-ascii?Q?pvwrvlYDgpyrbdcv0oUPx7PTsCDBlzWogI2bbCrr5cj/0La1JbM3I3uz5bRa?=
 =?us-ascii?Q?P3+ER8NYYBk4zffe0Ds=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:53:34.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec9adf3-b7df-442e-8dc2-08de37b8d671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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

edp_pr_get_state() incorrectly casts a uint64_t * to uint32_t * when
calling dc_wake_and_execute_gpint(). The GPINT path writes only 32 bits,
leaving the upper 32 bits of the u64 output uninitialized. Replace the
cast with a u32 temporary and copy the result into the u64 pointer.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c
    1448 bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
                                                           ^^^^^^^^^^^^^^^
    1449 {

    ...

    1457         do {
    1458                 // Send gpint command and wait for ack
--> 1459                 if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
    1460                                                (uint32_t *)state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
                                                        ^^^^^^^^^^^^^^^^^

The dc_wake_and_execute_gpint() function doesn't take a u64, it takes a
u32.  It tries to initialize the state to zero at the start but that's
not going to work because of the type mismatch.  It suggests that
callers are allowed to pass uninitialized data to edp_pr_get_state() but
at present there are no callers so this is only a bug in the code but
doesn't affect runtime.

    1461                         // Return invalid state when GPINT times out
    1462                         *state = PR_STATE_INVALID;
    1463                 }

Fixes: f2429468b582 ("drm/amd/display: Refactor panel replay set dmub cmd flow")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Robin Chen <robin.chen@amd.com>
Cc: Jack Chang <jack.chang@amd.com>
Cc: Leon Huang <Leon.Huang1@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 0b05ee9f6ea1..cf06b9b62e1d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1450,6 +1450,7 @@ bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
 	const struct dc  *dc = link->ctx->dc;
 	unsigned int panel_inst = 0;
 	uint32_t retry_count = 0;
+	uint32_t replay_state = 0;
 
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
@@ -1457,10 +1458,12 @@ bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
 	do {
 		// Send gpint command and wait for ack
 		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
-					       (uint32_t *)state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
+					       &replay_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
 			// Return invalid state when GPINT times out
-			*state = PR_STATE_INVALID;
+			replay_state = PR_STATE_INVALID;
 		}
+		/* Copy 32-bit result into 64-bit output */
+		*state = replay_state;
 	} while (++retry_count <= 1000 && *state == PR_STATE_INVALID);
 
 	// Assert if max retry hit
-- 
2.34.1

