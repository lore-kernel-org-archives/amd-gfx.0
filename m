Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B50C44512
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918A210F706;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HB0Ae4wf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959B510F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5f801HtOS1LErIKgZ6izFnu5JE+pk8lbClv/XiN9AXQ52tN68+0/NN2UVS6UaNIfj7zN11Kb9oXRnmoGLM+2JdelJALcr/9HRGTvio0ULTR8ag06M/u/WIw//hBpVW7NP6HwEmHk2SPc5Hxy2KvNVoottL/Y1FUWO4oNEZLXO/Q6yIHU7hF2n7FffiKY/gU/EScEcV4J65bjDxIR/uadV8ZswQJXNWHOSuoF9u8TXPlTvfR36Wgu7DOqwY89lhmHzoQkYIXMiMPAIAABPfFzAhXv/49HLaQxU970DtmqyFZDBievm95EP+feUBESB6bi5GXnKGtO0nEvrI9JvxLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB63SOKvjhFEz+Roqcbj6M/kN4WUqhQGQ/nG9OfjqBA=;
 b=HwE9MKpg+jboa2UE76w8UHhbz/O4bzRWVwMfY+bzUFvFBHsJDs+bvacrKSfLF83gZq3m/3aOOD4eEik0xszdtFsuVRtQTOpFCPaJDPChgtFXhDArWlibUEa9nP2Y8VW3A7eML2gKEvrAvHkLqm+8nya6LGa+ZZzGz09Nc8iBGqz2JUyL10/PMK5lWgm5Iq2wUwnwMKXUuBSi6iEtCwWSjQF2oIqNLjVQkEvU6PaxwJ8a42YOeEmjE+V/Vnwl25X9e0eHrEQv2KELkQzy3blP3VZw0joipk/C7DA3SPhQFACtK2PO/2qp1PZkcdAOL5sn5mn3iLOGk0lQW96IJZOesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB63SOKvjhFEz+Roqcbj6M/kN4WUqhQGQ/nG9OfjqBA=;
 b=HB0Ae4wf9ufbNRDM4tOjYr7uZ6vtLgJutIbWJFFTgzLJepE2l/dAMtt9xAJoN96uykHuYIMc9ur5yokViX034cKZjdws3begtW2hzVr5+TgZtoxwjtUVUuxvgw9LnD3Qt2k9AbGCxsC+HZyrI9Fjjpy+wif/Ar3b4ZLnyGOTOEo=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:34 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::85) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:33 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:18 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 55/80] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
Date: Thu, 9 Jul 2026 16:48:23 -0400
Message-ID: <20260709205936.5719-56-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 597082fd-bac5-4dc6-9b4e-08deddfd65e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /PFX8zGepD38YA7WH6T9kGmjmDwwmZlhCNiz+HasiOe8F5EsQ/EfkIHmMl1EwWP9uSyquA4W/iTjWxRwbw6kCz2jrVlk6knWLqoMPl1paJ5EvEqioasmZvNJ7bPqdpQmJISxxqOwpcjoruQTcFyWj6IIurVJPlF/hNN7/lJjLu+hqIrpg8cnIkDhyEqXD89cHAEHBnyhpoNd3bk0lbOLyQuN94qne5x1yPrWRxkyLijOp4kSh+xSo9Ezu7VV0z2qAuTbNU0PTDPnHRsV3IdPCO14Xco0jqAMCHEIIrHLZMvcCrrJv2wIVp8WNC/CHOP1YBWs17AIHl4HWe5ACagNooPNtLUuOK7mPD6JOks4GFhOO0OFo4ReNdVI/qRhcnlzTcUlRrwmM90LxPbkXGOeqDHDSfvJO6XI1rb/BeplkSLvtYsY+z0UmKPIvqP8Zv3ho7vMbUH6vf5xAMD9UmvsziHZxO/2OYkp9daRxhqFIRyEIw4xqJVGqsT4bnuBWR0ng1ZJZkrPpMy9kTQ8eE8hDIrCAjAsqWuJDwqH1rMbrjDuisC0aImxNoV0ykHBb9MRZwL4LPk/y4UDuk1zy538avSd5tnPCamjBdDihHZBXlbARaqlflnFlKaGyQX7ze+VaQlhyzM5V7IblgwD52q1275fuO+aKi3q7gOWY3HCMT947GmoUc7IYNbPnSO15/Df9+F99RuCQnXfdlCSdOJRhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6PSfaeaJHfkLt8IyAIhqWD38XE0CISGhTluXtmlmNXNQ1xowD9lMJmGEegBlFy480PuCssamfDRlgZUEwZ2WU/Kj/qofzbvacpT1V9Kp4OhwzyU9q4TAl8rwK9l436mirs/+hrlV8FpwDRDb5l58zGbfZykmTa+/tQs+vi8xhgtWgXym05Njs8DeoZ0/BW0KjNyOAZZTzVyjY8kGKnO4S4xrlF5SE5qnBSzSfHskjepU9VpuhS6aaBacMBgGyKM2THO7mM6mWLDA2OEk08iBTV0dOkxrFBmb22FcjlcdA59NFgoeODRWuOBzWjnp1kegK8dhnboU3Xp5MlfoholqciRtAy55aunZF0XavEmWVfB5B64FYibaOkMpp+ezaWWec434/ZT6h7htY2VRdZCAOKISoiquqtXWcVsqrKwGsaj9GEodPAHKycXIoOYuyE/f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:33.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597082fd-bac5-4dc6-9b4e-08deddfd65e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
On DCN32/321  sometimes DMCUB takes a long time to flush.
This adds a delay before the data is available on the driver side even
after driver receives notification from DMCUB via inbox

[How]
Allocating DMUB memory to GTT gives much better latency. Limit this to
DCN32/1 for now; it will be made general to all other dGPUs later.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9d08a3055996..d2148b62073d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -506,6 +506,7 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
+	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -639,13 +640,19 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	/* Limit to allocate dmub to GTT on DCN32/1
+	 * TODO: Other asics with GDDR7 may have worse latency
+	 */
+	if (dmub_asic != DMUB_ASIC_DCN32 &&
+	    dmub_asic != DMUB_ASIC_DCN321)
+		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
+
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT,
+				    mem_domain,
 				    &adev->dm.dmub_bo,
 				    &adev->dm.dmub_bo_gpu_addr,
 				    &adev->dm.dmub_bo_cpu_addr);
-- 
2.55.0

