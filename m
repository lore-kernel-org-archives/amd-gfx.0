Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFBFE9A04C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E47610E302;
	Wed, 18 Feb 2026 19:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3iJmAUc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1C110E302
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmqj2blUeOdeuMhAa4q3THlaa27PYJsMKj0NJFGeiX/no28BQO3W+3WN0Ry/P+0J4PeeeN/ZF1udEYd2GoQU7lttXv+qpiwwbOSvMXw1rcOpUIssJlBaodE+UCCfnRAZQuGOyQciJR6fT5Iis1QD2KWMkz0cHQpD3r5RacNylPL1QGkmmzbAbgyDHhGNrNlPwsYXNz3JVwE78RoWFSSzs26q5TrcLlzSG32KxfeN5jxJE27/N7HH4OMDC97UKJCgt+S9giX6YdEIur8YBP8OxUqLryHlQ2qvCJkyeuzTDmSRiexgXCcgi5SaGG7Oyi6eOVpw7uWMa0zKSJiTLcdBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0+jgu1T9Q8DdDAn2pFaBn8nHMZ4DdfZH4P6vc2ePE8=;
 b=Ea2Y1T8arjzNqNVlaQ1xylPe6NabKKGQkDdDpc1AWVYskujvF02UBDuU9NoYzPiIHbzqwsgmenU3IMdoxTRro7ik21SwCnnIg+E1bdHYL7AXeR1jh5+nibcxFNkKdQUgQ1nIQNb90NwE2T4XEvsHQyv4dOR4PMKA1/ajnWvbUo8DMhLSknPCRIyDBSUBlQkkWVWtvtGLVkqqy0kEfEwR9ZZYO7uaufBMT2/pQKmAfN8jpxVC0Mx6TKlMle6q7m+/LchjIHCVDrmtSme4c4xEziv+EJywZ0ApNEDQ+yRCfmTa8AoL8IZvH1wAzJYX/jk1LZ1R+LaNDGCtm7HnMQnEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0+jgu1T9Q8DdDAn2pFaBn8nHMZ4DdfZH4P6vc2ePE8=;
 b=A3iJmAUcexe5Fy0VYYa/eaZDASwbSbxUeb8SyWrfwrKq1jbT1qSo+HM/BOac2AX7wTnm5h2LCebP06bqyI8Y4ZhmB7vnqTM31YrTUlCR7f+L6EZ4tS7YSfbFbIl6hcBCax8rMb0wNa43BOEuicGwksjkx9PYeyBk+JHYqXr1emI=
Received: from CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::28)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 19:34:24 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::a5) by CH3P221CA0027.outlook.office365.com
 (2603:10b6:610:1e7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 11:34:24 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx10: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:14 -0500
Message-ID: <20260218193416.1474441-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2960dad6-37cb-4c52-6fc7-08de6f24b8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJiRwRGXoCYmZYXhJ2mSMNiOBh37RQbEM0Ed5760TyL46IpWh6SdaclMZI6c?=
 =?us-ascii?Q?W9y0r+ejvrSOFsKZnHNv0oUP4GRkwDnYKCZoQTX1RDfn5olK+YiEPyRs0t+O?=
 =?us-ascii?Q?AGPjo50hp1XK4HxNhovUsduYu1VA2GH/TQOYnzTyNQbhxr3tPXj3ryRc2ROC?=
 =?us-ascii?Q?HSAxfyjx8ImwHq4Tk1gmZImbD2QfNmB7W/2YH9PrE36Q5iikzdzyrQPoVjiV?=
 =?us-ascii?Q?t2X1cS6viHE8idqi14g4vDJ9MQb/I3O6A3DRAsev2QSNsi/ddLEL2xdnbuTB?=
 =?us-ascii?Q?3p5VwQX36INir7l5HaXF8djyHeejo5kMpfhfLx8aE5sBlUARxW3N58V/aw17?=
 =?us-ascii?Q?5Khay5DrgfgL7MKfqI17bapdLsuo8FSwhrRTX2W6Vzc8ZOFxtq3pUKOzbHim?=
 =?us-ascii?Q?zO882ouT9OiE3OWY3OEtBc9NR1nkHceGIHnb6W4vjB8crAKx6MEJz62Z44q4?=
 =?us-ascii?Q?9ywe+r03+9oy/uWyQ0k3IN6JqEA2xb9TVvmqubD+3C2+O4lrnxrZA9RQbzCu?=
 =?us-ascii?Q?99lwJC3Pzl1xf0ZlPvA6N7KOZ388iinqoel85Uq36npM5CmRqiHNfRhXJGFS?=
 =?us-ascii?Q?4Neoekb+XWwZkK+FMaeUdqydH8FqIC5yk5gZkfrRaf2tqiucub1GLN7FW6rv?=
 =?us-ascii?Q?ih8RfO3p5/33eCwbO/wsRNC6VI+yAhepGwzNO4tmBjuZsvpuqoT4cZEaG+E8?=
 =?us-ascii?Q?V9GHNd/2d+6Va85TAwghVe+WcwP8bRVPXSQBwvjjpXR+lk2m/xuozqNieSsg?=
 =?us-ascii?Q?nWiEXiEW3mlSyG0VRRMc69u2tMcCvBB4SDtqGzbmtdu6AfdCuqFTIJQnH+KF?=
 =?us-ascii?Q?PriYPZi9/A8weok8TXZAIZYFp9JFJBTYsmHTokGjYIsUvj53xnbgWJQrTRGh?=
 =?us-ascii?Q?XtDOyqthrLnlVAloLzEp1kKE5iA6WYyVb4Xx9ad4P5elOSc6/9IZRT1VbWsZ?=
 =?us-ascii?Q?kotS5TF/7ZZ40kNvYUqMiT8rkNASThTwoq3MFLbAnsb9IILNL/rgSAPpxgqi?=
 =?us-ascii?Q?+NZmyg7cMmu0Lfwzn01isBSYJnzmRMJ/IDzzNG5WbBBngKj5hkubzaI+X7/H?=
 =?us-ascii?Q?edc/1JhWrbA0M2ukZzUFRhHYHqc5ghs1OXiXw0yKOkxD2LjyZAJ/icrrHiz6?=
 =?us-ascii?Q?jTdiozUn+EfWaw1cOLiHU1V4oXIU5rDDm9XAHGCt5KertxJZvOtS0GFv1kM5?=
 =?us-ascii?Q?fTQNM0prg5VRYwgA3fXuLOzfmBdceSG3z9uQIkM05fwd9BumL/c6hCIfKzjy?=
 =?us-ascii?Q?2IK3OZvGTanGgL3pbk0EA7AEb1A+L9HH3OGiUSmndiZFrcip9cBQdhqp5+MK?=
 =?us-ascii?Q?QT8EGahke4S5nRvwVOKi7tsN7Gi2Al5XmaJrZY2qnRqhTIf5KtkEH/5AkL+V?=
 =?us-ascii?Q?z8EUALhjIaIActxNBQRYw9OlfwpqEA7rOlQ6rDLZnrloVVO90jnc2FLGdHRj?=
 =?us-ascii?Q?jC9u91l8S1QXBCwRMnpAX/KUwq1ix1vHMykvfsf59RTh+LMW4mJt6+cChLg/?=
 =?us-ascii?Q?/CLPigRT5jwhj+E45hzkQuAP546OP6P5JSph1nRaU4Oo1/xjPUxr0oALyhAr?=
 =?us-ascii?Q?Q7RtOmD5aw1U5APmQ9THsefgPzqDqXP87Gm3AipiFi24y0DU0nAO6Pekm8IW?=
 =?us-ascii?Q?t71NPNz4Q88RyJuXKwZ4Nqw224cD27sO+pjmuRubxPytq/k5nhc0stX+uXqD?=
 =?us-ascii?Q?SRGYpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: trNZRFwJyevcegCiruWExGDBq24oNH4za16Vmc5IpwfOIJF6y6pk3d5csAl3jGVfEo3jWOzFaTdLM/SeIXl99rwM6624ohiJKdljGG4nS/riwLkkFmgQX0HYgJChNHA/8NfqU735Ib1ipwluH+Bk3x1zJUAJWH3v1JsqGlVnFABcM7ajjTMOcIxAYVxHFQKVhBlDkVsRaR7+YFkyB1Wl0EH7yKPy3rug6ZPLPluTD7gKRq+Z4fM4K1lx36HJibbDAH3IT1imvu4VEjVlw6EY0vZTp+xqYhKMMO+/uIMLbVLQhdw+Jk3GE4Q6+i30PQ8CnVYtyBS09z5VEc7Q0U8n9O5sTHX+AzET1KbKmmvhlmwl5jxj6CuyNcCh8PGA8LwsC+/C45ymRvna9dG7Qvd/biNry1ikH/eZwZMeFdYo4ABSEGP3lHmCVEREng7nYg+v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:24.5761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2960dad6-37cb-4c52-6fc7-08de6f24b8fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ef7d91a4437ec..afa9cb46ffd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7014,6 +7014,11 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	/* set static priority for a compute queue/ring */
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
-- 
2.53.0

