Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0BD10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6931F10E5F9;
	Wed, 26 Nov 2025 13:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXOOqTbK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262FC10E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKFjd7iFQR7cEwTf2WP+5rdVnlbXvO5Js+mCmrY/+WG7GxYIn1foefD5/7PeOMFbi/Xp3GWDZ1y2Vuyj5fb0BXYjunb57A6Qyj+3rnATMpSno7y9m3qkiL8jZDtqHhwf7HlrBO78wuhUzuec36ByIHge/NVVHRoehxO56YF9afvbbgtmqG/MscpF6WVSDKOTqGXC3vT4R2nRt1AWSqNo3eiEU+P1DlmU4uaPFklQf4ep/eZZIiJEVxWdPsnfvQEwB/wYZ56pWwwHbEkCkU1OzpEbRHnJnO1eZZMGRVdW1qN0YJN83u/oCNYaDjfQ24cWTqspV47whVaNwr77EBAJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ExuNRl/iPXm1cSLi9fCNvFNIwAzlajQJ5axBZiy7M=;
 b=Te0qJIA2ef8AxnzjYqB8axTBL2jH3RL/89xUI56qh9Zi6pbPhJTLlRlpVm2DVJvRWtwyVgFJ19+cNhc6VO5EvqOogArZvautcYnXd/7de21beLKPjmaSp2Oz5MQ19T70qiPeTosRc/5nHm/RvsT8PWC5mVKqZqgPESbDcggaqCfs1ZM5hExtQStXCQNN9Q/uLGFEfXCghwILtXpiOuQUXd1YJtJugwgHPOuklaPWKsgQtlXdiUOJqJs0VNZi00r3yGEfen3CL/Du7Pm0JmTSs8oM0+xvI4yOHbtVG/SI5HCbCzSHxW/22NVGNqns3KEiSQm7rXC95lvyHM9ml78V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ExuNRl/iPXm1cSLi9fCNvFNIwAzlajQJ5axBZiy7M=;
 b=KXOOqTbKuX9AJoAoUhcMDlIJgxo0bpFxj3qKtINGBTogIHMIAHN6hcERrbE8Z3GwlVc6ZvPKmxhCBIKvyKl5wfZM7cMnB+ZL/M5mkfoy+qQsrxOskMPZjnBpK5i/ltr3MPv+uUCajf65ABqBUeLCabd8RALKz/6L8PwxAyuukGY=
Received: from SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:47 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::57) by SJ0PR03CA0166.outlook.office365.com
 (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 03/20] drm/amd/pm: Use emit_clk_levels in cyan skillfish
Date: Wed, 26 Nov 2025 18:53:50 +0530
Message-ID: <20251126132822.3266730-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 621a7d75-0d2f-4c85-bc2b-08de2cefbab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kY+4rPvmiuEemQ0D2Uex+fzy4xIJRn7w2Y3XunvlknnpNqJS5zI4U6eASAAa?=
 =?us-ascii?Q?b760KhcLKj677MDmaO+TUDH+8vwkWcK/V0wIN6VTVaGsw3jr7bvh8eoEzMJz?=
 =?us-ascii?Q?4W8iYMZztVG8mqbj+48UwGadV4c2gCtGFnH4facHOdjU7+2L5Pq50aF88Uxy?=
 =?us-ascii?Q?GhGVYwtdRZNGHZjyV9PTLjOvegIkdP5ZYTgeiPs3J0JPTk6MCPISerbYwAZY?=
 =?us-ascii?Q?cfcxwRsXhVby2+CMuLuoFZTCKF+pEk7D8DHmL/qfPxWwqc9jjiYmmLGvOFJ9?=
 =?us-ascii?Q?s1bxSHy/yX6swrW4JMudXHg96HVag+acCuDvCMjjWphMjjnFnZJvR9EhYrEa?=
 =?us-ascii?Q?y41Dywgs6WJ7h1zrWBcx7MmFhatk9rjoq0bOYR+OOQlP1bWfWHdnZTdkkp6U?=
 =?us-ascii?Q?10uynj8mvNwZ//FWCHg/uW1s8wzcJNoYErEFA20HlLFGbof4n0pfgAMDSAY1?=
 =?us-ascii?Q?hFXITgm6IA9ORT7ar2GOML+MMvze8HMZ2jSPaTA5gqFXc0adffkIvjWcGWQ4?=
 =?us-ascii?Q?40u/7S0BRw2KDrCnTHCukGmJj5Xr5HUuzuxAuJkNxRjOf4O9/B355Lbnbi/J?=
 =?us-ascii?Q?mbu0QWiXtLJK7OeD0yKER5iezt3eLx2l2mDL6FDUjZ1Lx4G9rLWiF0DU27HJ?=
 =?us-ascii?Q?5mscD0cbJDP8R/oHTk7RxKnEs7ZqnvgJT32ErtV5I1+16PWEEnqh9bMBa0U0?=
 =?us-ascii?Q?lYMcatuar3iiyLTaZea3t+8H6yFho9r76B6YdE2zme5cLNaMbh4Qo3/WzH0Y?=
 =?us-ascii?Q?X7ohdXD0zExp2SrjmYvhlT/eEj8PPnoxarD7/Ecb50oFN60DmgePwy2BFRNW?=
 =?us-ascii?Q?UODHTKCtGY3enKH7onL9UAduoKmF17vFJtq3FgQjMPN/7uBFthKeFDP+kwIX?=
 =?us-ascii?Q?zFxjVdosVBLBlD8bofu8zr6ZiuNcD7+m1V+oKRi6QDwdIaT5SjLWNV/MVm08?=
 =?us-ascii?Q?q7WogQsUut0I2nK/zi4hBfFUES3X8ZLA9LNCdVAccrSsQIJF+RxJAxWuUs3s?=
 =?us-ascii?Q?yOkWeB43euJc5Emb0D9Aik6E+zzY5vGv48tTW0JRGnW+QClfQnBf4HSqoxOM?=
 =?us-ascii?Q?8yXDSEVvgr0/POKiHo6rdj9Pic2SMQqeN+9oS8+9yUE1kNwoThNrL/ZQkUOF?=
 =?us-ascii?Q?WaQVaAthjN9C9SyTuE8k+FEBwXxfzSAA4uIQnaiOCx+2LyLh4vtTO0pXKCRc?=
 =?us-ascii?Q?6lASqv2kc6CS2OXTKGTLIvUnMgqZ/37BaBgPwbxMyHxf/zFvlxmkZcCgsK0q?=
 =?us-ascii?Q?OMzh2Jdvqf3c7Fs8dE1+7RO47vFLJIDi/HU6lCb3k7fW3V8iQPsIpGHPqpts?=
 =?us-ascii?Q?aClij2gbMDydN6dlZ1Szi+lO9Car2mFkmWnO08Ek4ul9PT7GMfFsqWubeEUI?=
 =?us-ascii?Q?M7a6fmc44oPzDWfZYSxGHauAkhD7o6cdLApLwrG4hIcSLa4Q92aPg9o1us1r?=
 =?us-ascii?Q?5MyJVZNn9V6Xo8kbLTPSyQbW1+sON6P/IV+Q7B5BIb8eHpb7NTD97SdQKQCt?=
 =?us-ascii?Q?Y0Vz5Zo+wMRTcXefh9gHkwj1kTdwbcve/0UFa3vQKzf3DkJb06nZ2yh3juku?=
 =?us-ascii?Q?NvKlEh9lsf/NnJBTkPw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:47.2780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621a7d75-0d2f-4c85-bc2b-08de2cefbab0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 55401e6b2b0b..e0e829ea6579 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -287,17 +287,14 @@ static int cyan_skillfish_get_current_clk_freq(struct smu_context *smu,
 	return cyan_skillfish_get_smu_metrics_data(smu, member_type, value);
 }
 
-static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type,
-					char *buf)
+static int cyan_skillfish_emit_clk_levels(struct smu_context *smu,
+					  enum smu_clk_type clk_type, char *buf,
+					  int *offset)
 {
-	int ret = 0, size = 0, start_offset = 0;
+	int ret = 0, size = *offset, start_offset = *offset;
 	uint32_t cur_value = 0;
 	int i;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		ret  = cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK, &cur_value);
@@ -354,7 +351,9 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 		return ret;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
@@ -582,7 +581,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.init_smc_tables = cyan_skillfish_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.read_sensor = cyan_skillfish_read_sensor,
-	.print_clk_levels = cyan_skillfish_print_clk_levels,
+	.emit_clk_levels = cyan_skillfish_emit_clk_levels,
 	.get_enabled_mask = cyan_skillfish_get_enabled_mask,
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
-- 
2.49.0

