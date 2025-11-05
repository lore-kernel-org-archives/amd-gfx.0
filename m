Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8FCCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558ED10E771;
	Wed,  5 Nov 2025 15:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TL94PvWe";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB7E510E764
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTBSMbkD0ZvmG4VUq9xhbeWpbNatM/m4ASDPZS7NBsUWOokBDtJV7cp8BKjznD9s4uCsQN7sjMiqZe3X8FXewIMoMQjKIO3+gROs6PGX6eH8tQ2Db4ktzqOxq8Qr38ISquysQRMf1kVG+fSoJJxHvui9/mfIt46Uv+qMAsCYwi9xbVWYfIgiQ6HlzOx2W/AV+wZRzIsWLd53QRo4atWseXqv/H7uephqSmENlogxvhH9IGFYvLj3it0cBMuqDM90AIILuiOqZAZdVZ6I+nH2hrL5I2DjC61Oity7kCZlg3QHMa3VfUw8DD7bxeAKoc25a7AzgaTpKBw2CremJ/gqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/rj8wnNFmvL4v/O4oDtjEy8vyeNZZmhOEyg/G+R3rg=;
 b=xHJhka2CPCpHYxHFnwegyU1fCosQHTen4D4vsw3ZW82YAHKp5Dcr6b6cwkuGrOT6q8sLAIQ6e6t6MI29e/3PjKsswDrfVBjXf4j+B1t0EkkeiMztdV4DB1dUbTMelxgARduYfAXF+mHzhrkXO7zzECBCj0U6c88Szx+eIvLXm6FqnaINEPPebTSBhDhvneGKqNL3cPIYBrrn6UBIGoI1hWnmB9x6xEd5G03CA5AKtCB1f0SZgx4b6b5H0BGwJE1uDzc/ay7GyLQ2aMyi1hrp4At9+NJthMl71//z3VLipUXKkt7XAKXTRsVSGj8vUtRT+qPyxlyYVqeAijNDOk4lPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/rj8wnNFmvL4v/O4oDtjEy8vyeNZZmhOEyg/G+R3rg=;
 b=TL94PvWesrkg1Y/dpQvAvs6ptE+/gA1M6LHLSQGwifeq55oQMG2AtIRm4rf9S1y0RDA+HxVMjPT+lFcNg/cPuHtjJ2y1WxsEBAnIvF08MFzGr6yIH3tYVN/bniPVRmKsEPLFHH0hxHxsL8/Yz3KClHhtJgmr5f8BdLttdsFgfzc=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 5 Nov
 2025 15:41:09 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:303:dc:cafe::62) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 15:41:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:52 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:52 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:51 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Fix index bug for fill latency
Date: Wed, 5 Nov 2025 10:36:17 -0500
Message-ID: <20251105154035.883188-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: b91dde0a-a7b3-4952-22d3-08de1c81bd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ly5q+dqXDgeaechZLs/CVlUP1DqC0YkbtN9/u2O845rvC4YSIGzrPCK/LRvF?=
 =?us-ascii?Q?5lSSwppuT2Yc4LwE9ZVWhrisEzkqofQzjbneX2H9BCBixD9pzN91n18lzAcd?=
 =?us-ascii?Q?IrZexIG2kCYPubtj60lQLiQ8R+vQ5A9UOU6rYGzT4axH8EshlI/UaSYNYk8k?=
 =?us-ascii?Q?Dj7AcpU+8onADU9+ZgeZsVP9UBca7hr2hYTj9SjKY4/+Rb00b5GcvPHj2EHX?=
 =?us-ascii?Q?2dL4/EoIXmOy1LkqJqf+ECPBcXVq2YfE1hGo+VBDYi+1eSgd5e08l05VPmvG?=
 =?us-ascii?Q?LRzN/MMrx7/c3KtafAv6t3JzU74V3yFwkTO7jUS3GwJ0aWy3LO6JoLFemCN6?=
 =?us-ascii?Q?LU7yWnsld0hKVyLFMd5h9CozoHetkQYRbzRaCKCYYrTRgpT08HsmgtoQB0m9?=
 =?us-ascii?Q?ojJn6fdwgyv1gnBg6xQ4Q6xUlHajZGlPQJq8vZOUmiJje63ynDaAC5B7CDTY?=
 =?us-ascii?Q?25yWtjD4pUN2FOP1NyiY9m7/004Xi2WVEhjsOWxumlO+TI4uWcTrV4+SaTWK?=
 =?us-ascii?Q?eQNIh/3g6pwVrKZ77qW9JQOFmK7kILi0vttbssSXiZU6IvMKcLAl+aZCXiM8?=
 =?us-ascii?Q?yJSnLHkqygglfspEp6jVkQqwP/UsjTuQ2oduqzpFfoRHGIOoIvjuythe2ujH?=
 =?us-ascii?Q?1JuAMcQ4fF1eITpmJ9rDcgvj8oc8lC7TIhALmEl/t5KWQrs84tOQN76YrSBa?=
 =?us-ascii?Q?Rno3z9COsQPDLMpAVd8hh90B4mG72PpuITJ2OVmGg69BXqBGpLHQIUj2pO58?=
 =?us-ascii?Q?Wnyw+cYx12s6nulDjPz0HeKbeD/aY7Bori03Ud9FHEHvYTzAubQ2eNFornmj?=
 =?us-ascii?Q?491WxLve/gdXDvgBoSjpJRTK4WObNQLeW/2KuCNIaaZvWBdKmMeBUBcAUoi2?=
 =?us-ascii?Q?NahpCDC0jxmp1VhV5UiGq7dbIMggsX7hNYwM0cJlvhgxjrYPKz/q0W+zCjYs?=
 =?us-ascii?Q?WXBE+xL0ZkXNjSELLcbH4aY794rNx30gQ07iEHSIYy4PmY48+Fcs6yIo/U3V?=
 =?us-ascii?Q?DPTJPmGWi30wJN0AX/lN+hvifpVKMKBPcVw4d32HWVUlwnJw5EcnpDaBciaV?=
 =?us-ascii?Q?exWMNeFWU4ZmxfkCnycpQdyYgyov+38xbTIEC0rqpWoLuCPum+dbdLQOrHGb?=
 =?us-ascii?Q?d03lX75CeWQcxLvUyEKWoyDlt/9S/39chErIvJR00sYz4+g5GZ2iRFA0BQ9i?=
 =?us-ascii?Q?1mngLjTN9Of1f0/hRM5/ZL4pgfAbjWliRadat/eR6jq5+T6sHDOgeQh/x4mz?=
 =?us-ascii?Q?m6q3qlZv36W1bgdG7N2SG2xG7jI7NwAe7KRhnkBRivo8CQcE2BySoqXgcTL+?=
 =?us-ascii?Q?T4+IUPwF83jkuVRtuktNX3lmKs+uWEJj8pCQiE14eQ2902vVXO8WMgJ6KNNJ?=
 =?us-ascii?Q?/oyoyKjKS7gaEIsmDZvavBlHQPUbnNpCy8hCsU0bMi7WqTrtj5PE2Zts3J/M?=
 =?us-ascii?Q?JHoGXe1YxyvzoanY28L1Yr2sG1dL1dgoITRJALHyLQd+TZBXGzbyqjk5Iz+v?=
 =?us-ascii?Q?53wfC9fD3OGmrI1Q9zn+x2COvUnqliiFJc537d68AvL7BLISxlls7JN/kAZU?=
 =?us-ascii?Q?8YF2ykuHIEdGaAn4tN4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:08.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91dde0a-a7b3-4952-22d3-08de1c81bd80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
This array should be indexed by pstate type followed by plane index.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index df81bd963bb8..a02e9fd6b5ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12944,7 +12944,7 @@ void dml2_core_calcs_get_plane_support_info(const struct dml2_display_cfg *displ
 	out->active_latency_hiding_us = (int)mode_lib->ms.VActiveLatencyHidingUs[plane_idx];
 
 	out->vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
-			(unsigned int)math_ceil(mode_lib->ms.pstate_vactive_det_fill_delay_us[plane_idx][dml2_pstate_type_uclk]);
+			(unsigned int)math_ceil(mode_lib->ms.pstate_vactive_det_fill_delay_us[dml2_pstate_type_uclk][plane_idx]);
 }
 
 void dml2_core_calcs_get_stream_support_info(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct core_stream_support_info *out, int plane_index)
-- 
2.43.0

