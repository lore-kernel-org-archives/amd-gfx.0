Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B1FCCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD7610E2DD;
	Sat, 11 Oct 2025 07:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKkXVQl7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB8D10E2DD
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLk2VMgQBw2oqDm0V1ogdRz7Gcsc6JATmiwUTz73TWWFEty8BVMxmVSEGGze32WX4HySTk4FIZy3pMeqxWYwLE1K/BdbQi7eeTc7/e8ByC5VIr82Z3V3ve+8orF8PdTRjbqJY8TiEBhO13ZAMTRcNmq6ROqNWc8SZKJteRILSTTB1TgoHAPp0O+6w7t1+4Yp7d4mXnlUkyj7iiuOh9XU+ewbIO2lYPaIlVa8KyzAtuNV+n9agqG3j/lfqxIGI+B1zOmte6l/f2jn46nDF0LamVahh1+dZVCPKOR3gEQoAHLkq8eDmMeIFTwes8CDxV3suaSllQbSGaEF852QpuERFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq54VINHKOUDijq9UjwZC+bPJ8MWMVVMjLpsmE7kQcs=;
 b=lU/bZVTIcGVOGVSVu/ksmoimpPf8ExVhKMtuH4lydLyuw6Hdns3JhpI42qafTaZYhy6CFc5SAS5qi10G0NpGl1p34N0BLYeWK9cec5HYpOncIKAD01y330yXaHffmd2Eu358ICkA5QbxpgSKp5fc0RV3nlsGez2gMuAhokXZ8a2nxp0ZM0GKlMWTzV2AmQVIjkHjp5UB+fSjczCtHExT7JmjgjOcZXzB4AHdvqe6R2HkUmLMS+VG0Pnw2pLroF0xhJrDh/AATNetkCEZtequRRHIBWwF5hgkg5my+OIyVdK3VLQgpMtqV5KZlmDVVSuImIdPzEoHGkvOL3Yvx0l3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq54VINHKOUDijq9UjwZC+bPJ8MWMVVMjLpsmE7kQcs=;
 b=yKkXVQl7Z6Qq+5gAGEwMPEgwG5FBYKMEBPOADNesOcwnRaSHSErb3Y1LUCuQ52xVf9zqae9yyo3/TgTlhGsCMgZfLLomCQBt59c/IL1Do9cwCeKNq6DCBMGYILp51nOoguUroKpRPfSBRBJF97eKucWwX0szHWok8f6IO62JipE=
Received: from CH2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:610:4c::12)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Sat, 11 Oct
 2025 07:49:58 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::4d) by CH2PR10CA0002.outlook.office365.com
 (2603:10b6:610:4c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:49:57 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:49:54 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: Add ras module files into amdgpu
Date: Sat, 11 Oct 2025 15:48:04 +0800
Message-ID: <20251011074811.533871-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecf3e9e-5007-4e44-d095-08de089ac608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3JsXMrO7pyo7tJgQh8Cnek9oUHSvnpD8l2YSG8cuMKXiuebMZJ5XGKVnmKw?=
 =?us-ascii?Q?g83w7RXIcA+QJM2/mGyonNsYduRxI92fSQqf0GV3o0/k/PZtVi0l4ftHvlYs?=
 =?us-ascii?Q?BLvpfvMnlIObpmcjAXInuUZ8qfhp9LDvoCZoMbqt5Dvrxt4M5OM6hWVQYLmN?=
 =?us-ascii?Q?mmavdWDB/TOh0MoIrrCJEp3nSh0Bw8nLbTIA/KREaoPX9yJw4HC0K9+FMQ2K?=
 =?us-ascii?Q?Hrl6TVoYO819v5YnlDWxn/a8ghHK3n4QbdFYvBOgwZGAT1qOrkEoEqwi/FG3?=
 =?us-ascii?Q?45hdr18R0yLlUzRtoSgDFyQc9jLjvFj67iYXYQV8kktLmOqIafqquoKjO921?=
 =?us-ascii?Q?obKNGRo28+dnzvUO83zUR2ZzmWylSuN0WtM85XeTb2lXkRfxlnEUFLljnG2E?=
 =?us-ascii?Q?LV9o33tjyPZ0IniJwKD99a90LUFZK+BszDoRravMhlsz+R0MQj/oa8eUomvy?=
 =?us-ascii?Q?CslohzzZCkTHqsgYFk+11huMH8clzTtiXxXnk6QAIAcgNcEO9YWz0QfKJPHq?=
 =?us-ascii?Q?LbE9S2xM8VqhCx2SYQf/Af0wIdKHk7kTtbyRt/V8CBalP4u6N/R/FOaK8QOG?=
 =?us-ascii?Q?BHin9WlYZ0f5JTv4aUTWMUXyHCuowCNbG4PAwfYHRfweFeY1zG5cUVzcBUv+?=
 =?us-ascii?Q?EHF3zv1F9M8ACYKeqaOC31ghwp3OYmfK0O60IAfwC2+PIWLCoowki5dfR3nC?=
 =?us-ascii?Q?hCNwbzYHMGrPIeLg1YcFnrAZ4sooV4WtDqON3/TL3QlxH0Pi61P1/LvDX8c1?=
 =?us-ascii?Q?ZLRmpgkV5ZSbDnmWUsIcf39C2t8YjxpHoidJqnUuMk+6iFrROlTn2C1+3r7R?=
 =?us-ascii?Q?dfTgApQv3VIRKBmv3pYnVQvy+KdmL5jka1axT31QSu/x+wzBM/oeTRpXtV62?=
 =?us-ascii?Q?ZPtNKw4boeRiah9pIieC7JBRyml11gWHEMjTWlkBGKvgkFNnXh1h+QTUVuC/?=
 =?us-ascii?Q?QUwdNxW8zYK4JmGYMObudaWbBUoofcfJAe57dgCazP16pYVb1ZdXBsQmz70w?=
 =?us-ascii?Q?j38RW9XJ9WVyM+e2wDTMY/uTiaXaiA4q9Z+Vnodc2A4hCN2C1UPcLB6mhswg?=
 =?us-ascii?Q?JTliq+UIUbrUB5tj4oK3sFFU2woEA4DMKfM8CHIpnaED/Z/9o+IPxaZfUBcY?=
 =?us-ascii?Q?qK0e68olA/qy4f6xQJ6GNOUVGdTqyXaSAbberiHh/aiJQ6Q+KcK3knj2Z5lP?=
 =?us-ascii?Q?h1Df2VZwUa6pQxJ13fjXJNfmwm+S+g8gIm11fZjZZuO54l5TgvkhTUr3cvWD?=
 =?us-ascii?Q?E37VW2wFQFtchMXQjxrFrPnlZQyZ/YJOq0IMB1qjKvkYc7gvZkfxGii52c9B?=
 =?us-ascii?Q?18M3TzhrEk/zAdaHcvxDTXFxbnQJFs7RvknMGQn8DkmpRE36fbcb6VHTR771?=
 =?us-ascii?Q?VEqiDTRm4j3eT0JMbtm33FbIEWiGgfb9na1GHs3oYbSEqEArYW3C7xYRzgII?=
 =?us-ascii?Q?cAJhyGBsXO8epV/T7AIMnLG/t16QQQBHOlSjF9IEysbHHsyUh8kvHSleoGcP?=
 =?us-ascii?Q?bFjSy3O/ie9EAHu4gTyEjHdAPvvOqnJo3mKZ9ybxwWDIUOXgyO7teflTF6VD?=
 =?us-ascii?Q?CGRczwvMwRD9ovDbHHc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:49:57.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf3e9e-5007-4e44-d095-08de089ac608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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

Add ras module files into amdgpu.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 64e7acff8f18..ebe08947c5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -37,7 +37,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/modules/inc \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
-	-I$(FULL_AMD_PATH)/amdkfd
+	-I$(FULL_AMD_PATH)/amdkfd \
+	-I$(FULL_AMD_PATH)/ras/ras_mgr
 
 # Locally disable W=1 warnings enabled in drm subsystem Makefile
 subdir-ccflags-y += -Wno-override-init
@@ -324,4 +325,9 @@ amdgpu-y += \
 	isp_v4_1_1.o
 endif
 
+AMD_GPU_RAS_PATH := ../ras
+AMD_GPU_RAS_FULL_PATH := $(FULL_AMD_PATH)/ras
+include $(AMD_GPU_RAS_FULL_PATH)/Makefile
+amdgpu-y += $(AMD_GPU_RAS_FILES)
+
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6cf0dfd38be8..9f21b6cf8724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -504,6 +504,7 @@ struct ras_critical_region {
 };
 
 struct amdgpu_ras {
+	void *ras_mgr;
 	/* ras infrastructure */
 	/* for ras itself. */
 	uint32_t features;
-- 
2.34.1

