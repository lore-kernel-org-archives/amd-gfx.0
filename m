Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA138D5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E7F10E4CA;
	Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Gd6GRp/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE56010E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtJYqwVvLkSkp0U4XTnIcpJaBomvcZy+hPLduZCjWqmcMzO69oLs65QaSqRgCM0U2bjmTWI7S/1bZCozVYLRNf/D4lWZw4YKgyzZuNzE8myG6Q+06KGg6DOG148Y9TOYfPKfUZFwL/zi5Y6FBKyOxculwKkQ6/mr1Z0TQ0kcZ/lqkBpvjZCFGKvULCUFnxtIZRH/csmwqFwkDMRL7tGwDLqeTavSlgAAT4F+k/3p4sjD+YOz7faWBjcwfcdn4fEaEeumzEVhrtOf5n/mc17jPlJAid/zNdRXSLq17BkAmLTnKZ6mjIU11I8NIdD/Ghsm2LwIeSoPfl40arJ4ZIi3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy/Z59vY7QgOJ0+TQ2HwTpv6W2eKGIvp7Ll6Ixsbfd4=;
 b=PwZY2Y4/ft/idnivBatFLV0mlVtkz2EaxyiCR5CiCDo1JZwYe16O4cgYSiEBbloxJqerUcQPsrgBi44paq3IUTw1XZLCvzmod1Fzwr8uJ0sfhyV345/hTaJKDyJxNy98rUB+fsmUZmkhaqcl3tgzOyQ8s6GIDQI/wx4tSUVSk5qk68wN5sfampofhnCCsR6tPB17O6yBreoci+M9+QCn4GSLGBPp3clRleqlwcZGSe4G/jAALMnV+mNtJwo5gyc3yrhB8cf8qssMxMirLHGZh2X4os1H8RsDESEACsxu9+X2rGtAxR6Tt/0WmJ+a7ltMf5DN8EPQLwTNDliDia1J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy/Z59vY7QgOJ0+TQ2HwTpv6W2eKGIvp7Ll6Ixsbfd4=;
 b=2Gd6GRp/Q3XqDK8noOaWOyOrASyxMZpEglC/3OmyW0/AogFCdbJDe4LYwYZFi1S4DK/ztKvahtikTNcqniJOjptsf5azyKAAS0J4WiuAjd7uV9Owr6B4kEiw+nZqsfC+Z960Tv+22Ze0nEYFRW0RnOXqKTeAORW4LKkRI/0hNAY=
Received: from BL1PR13CA0239.namprd13.prod.outlook.com (2603:10b6:208:2bf::34)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Mon, 15 Dec
 2025 18:16:30 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c9) by BL1PR13CA0239.outlook.office365.com
 (2603:10b6:208:2bf::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add/remove queues on the correct XCC on GFX 12.1
Date: Mon, 15 Dec 2025 13:16:00 -0500
Message-ID: <20251215181607.29132-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 4606a812-a73b-446e-1975-08de3c0611ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mmjpt7527QzDfyIls1Tgf6VpEfPWprBbdNHs/WeKfWDEPCjOQmTVzd0S0/0?=
 =?us-ascii?Q?LRRR7ITwH27xwI0+nYyNTtRWHrbRRAvw6VUPMLJ22wxXv9w7+gP37lEv3YGs?=
 =?us-ascii?Q?eU/0csBpBRrCYU4GMM3tOT1uROK+MJM4cdROAUGbQZudo9HLLmlhXi6NZf+U?=
 =?us-ascii?Q?AJYrR2uNwEaCCRefTvGtzwCLGfXnKqNKtQ8pkHpRupiqs5C8Fsh4BrTOCgfX?=
 =?us-ascii?Q?bTqF0Yhh0ECzHR1DeuNjlxp3Z6y7tN7v+cGlr4DSdjzCSwcdjfIlqYrkxdAA?=
 =?us-ascii?Q?NNv2hKFUzMi6DLzVx1rGZA1DT2AApOFkPXyuqfCsL1378aRQB2G7/kJQJBs7?=
 =?us-ascii?Q?yrtohqRDV0mI9EJn7/hu1LC2g5CqQGH+LTJ3qPswRDkaaKC1/ycfz9FjV8IM?=
 =?us-ascii?Q?k/x9V68fzksN17wcqNMyWvliBjVrwKbwvoD+2erv8fX+6oP1eXGCO6w0TSZS?=
 =?us-ascii?Q?S5qVQcOtgqAfAAkJawsg0N7hypStIeOX+Ok7clEa317aSBoDOnSbIccHC0P+?=
 =?us-ascii?Q?rWu+Nw+75KDrKDKjwb1N2pg4lkLUVnusNBHiXDHkQfyXmuEml7eYEKHWc4ed?=
 =?us-ascii?Q?+MNOKrNcgMT9Sqo80oZm8c0DXEUJUtv/VU/cjMoVEnPUnwZLuSzQblbdi3PU?=
 =?us-ascii?Q?3M5sn7VSbsL6lbuvPlsUxmTYjpQYx8n8UjUahibDMrbeMEGwCiN8e/GXNyJ1?=
 =?us-ascii?Q?kO3a/nzr0JXUQ8fwD3oKPgsm9t2Or446UEHyA8EeeAEq6COH18RTpNYVJMrH?=
 =?us-ascii?Q?GVozYAtcxfI0gUlo5Hh5vdu8mY/06c8G/bB7IECrehsABjV+1q4tqIYDb3gr?=
 =?us-ascii?Q?SRvE/0IaPWjoLPXTNDARqCrVy1cPdY0e1vNKQoJYgM9O3QaAhpimwzalewJI?=
 =?us-ascii?Q?PAIN/EcB78WKFN00UJJNJGZ6E/z45v2FE81wh/MgQ8ploQA5t7HhjFNnR0N6?=
 =?us-ascii?Q?lA0PSq7b+G1hyES9e+/BQM7gucace4XyApHq4/u5NF6utzll/TDL/9igN+Y5?=
 =?us-ascii?Q?7IgyOS3eR7ZRJbyVbyIE/xpc0ZhHaD6JblGXSnCJkQm6uunOzoAK6t85VVRo?=
 =?us-ascii?Q?qjWB2mRN1K7/EIBaN4Hb0g5a0/g/Ext7LSoL2QDQXeMlRud5odVdJsS0Q8BL?=
 =?us-ascii?Q?UA1wkFDDJ1oG+/LxvNqtpSud8HLc+6wmzaDI+TKh1f38RSDCk1BMkI1qMlvU?=
 =?us-ascii?Q?hoh0FFMkCgK5RrMK7Y2REYwIWZFTqe7GadeWNo/cyIx1A+m7NnW70r5+dR5o?=
 =?us-ascii?Q?vZBWqSIjU8gJGSA0qDcMBvlsLPz2zYWWhDPxlpiCcl812Q2nvBlWGt2jFJYu?=
 =?us-ascii?Q?qD6fsC/IBMRZEu4ZRH+9iNTUSZ0fmUQBZA6AqlYGIrR+qoWrWmF5PS8t/rmc?=
 =?us-ascii?Q?VwlRqMVp3XDUrWBehu6J8kHOn0KTeuwfBC+IIIbTkVt1yXhu+kUtMsED41n4?=
 =?us-ascii?Q?nwI0/rtGrMRTXZq7b646hRnPDAv5XHBG2AxVULxH1s86jgfIHUmSxhklG7xq?=
 =?us-ascii?Q?vGLM9bLtbwudIh4p43b5HEMEQJJzrmYPXGPFiG6fXMk+RG9HTJAmx2AjlHqu?=
 =?us-ascii?Q?IDos+8I+5+FrGxS/334=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:30.0772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4606a812-a73b-446e-1975-08de3c0611ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1, pass the xcc id of the master XCC to choose the correct
MES Pipe to send the add_queue/remove_queue requests to MES.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1dbdf9465e590..9bc80f8ba7dcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -257,6 +257,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.exclusively_scheduled = q->properties.is_gws;
 	queue_input.sh_mem_config_data = qpd->sh_mem_config;
 	queue_input.vm_cntx_cntl = qpd->vm_cntx_cntl;
+	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -287,6 +288,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
-- 
2.52.0

