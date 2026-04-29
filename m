Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E146FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9377610E3AE;
	Wed, 29 Apr 2026 01:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PrE0aQI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FEC10E3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpgSYqmX+Hk2d1ji53LiCv7ZwQ1DH8D2eTuQqXoQCpIrOKZUeR2DqH/+o+oCR52xoBYP5QXU9bjyHv2zyhdITzODSBq1zcX7VO6/4z3M9w41c+lUovE7fOjkPDWlnd3nh0nMvP8aajMLycPxWxDYJuYjXqWIU+6POTuBRma/nEFiCy1X6VHrqFIzklAiv0LKVRGIQ6KegrIp4UKffaD45hWSu4qm6jzCDwIgghnipcs5+T+2/mHkZ6hoOQbQK/xi17L9JofobHUc0XCG/e7K8Nck7t2fQvUwjfOL1smr79Da2AyKSW5thUYdGybQwWqi4qCp8Z/gDc6a1ht5+r4/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5baeFMnoZMSmSrt3bDlwenGyLJybf3LPdfF6L2tadSw=;
 b=w0LtslliPb5INuq3aipZFdvfU6ZRNkDrjLqg5jXEKLISkkF/YLUMEyHabNjYPUs8KDx1cQAoeUnn9R409G9cI30nsVJVQofnr5y0Np2F2RgYq+EflSZDhPQxIZ84qT89TsS9gRbnkW4TYpsfJtCStr689IipC7cpYRtU05iNwfsWrLhI9X0HlvGZ6G7Bb9CXTnQvHujcbSdrD+lLvDl6/LGaMjqoj4+lfvuhIesFgCNN5/Av7Wh5Lfu3ROysMQRu0B4Ko1WEgmnN8p7J/oRYhWNilMWP6HNgcqsxMEWxs2QrxFQQkeAtrsYrN5behDDlYyI5ytkxXuhI3J4BosTpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5baeFMnoZMSmSrt3bDlwenGyLJybf3LPdfF6L2tadSw=;
 b=5PrE0aQIGC9ssWRFwBzroyLaqloF2Ls3/6lO7/9jwLiwgHM5ylf65a+JVKQ5h/+0VwRtMROF0mqdYXH3tOdUyyvhnSZ1qSKnu4ygN/666hMcCveqAZj7BvKP63JcS/jLxZDvsoqx4Ujr6wuPzCUJN3c15VBUi4I/kMvCt/wXSbg=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 01:54:14 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::71) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:54:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 20:54:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 20:54:13 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:54:04 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Update tmz field for LSDMA
Date: Wed, 29 Apr 2026 09:19:24 +0800
Message-ID: <20260429012055.2065869-16-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: b683370b-83a4-4ac8-555a-08dea59236de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MEu7RVqcmVwU6lQPIHFlwbs3nsJUhtNRSyu2QwDw1SIE5em7ROHgGKITtkI7gxoL+ssmauYHHQjwEKZoXa7cYahHR7X+ypjQ4MKpy/5/GbTIAn9497waZ/bolZwFytundT6HBKs54uRS2Gzopoc1uI0ORWzsUlSFBl20BXXMLW90RbzFrHwJ7/MC2B0C2JiZEkshbImLR1mfIFwhMplkcpYCYBMM+o2qcDgIqLeM7KiGKY4lxQT/gMoBRHEZyaYZwfDNdfqA6sbPz6X5enEMyYkAYiWqY2xpRhcBSsl/b2BAnQHHIsp4OclA9dpo+LVVQtj9so0MinoHCO5CEMogVApvZk+HiLsZsfj6q6/DugPay+Q/Q6fMTUuAEA/WgrJ7pv044M/PRZldOH/c9yF/KpCz86I2zwm7+oogusLmyXxj29EXefnPbh0I/w658n23V1yoAjE3/m56VLNjK+onXCewM8zZHW34PZyV7TY9VLDpOA7mnOtw8STaeCAlPz5+YfZh8ULg6BCUfHSFg3v1a2CtyZaOKGTOMx2EvqZy6PSG6M3fpOnlYvT06XWbx1DUfwl5X2l7RvZ0v3GSVq83ZfG2M6B9TZF0IVSqjjz+5YYMn+zRJQK7cQFC2G8kcnzAK1bVzDXSPXhhtu/18wqEFkEYAHX8ilvNMqFvVv5yp5RGTB9iiauzgYett0+la3/KnPrmNinztVud/rDwZG1+iRxTrALsZLsCwzI1DBJk2cf3Suv9bkCXW2aJDVAnj+gmC2Bx7rYvtw3UnttiF63g8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2KqhcEb9b/AbGYwimm6BHJZLoPB5XGo1Bjk5vG7OSbc2FIKQAl9G4phZvBJ3TM6PTAsTYt3F28evXx37NnXY+fIthK9rEdHevOOSWjbYWKPif2DeoEfE+kBqy5giKgOdKiLvY8XoVUCRQgvQ0G66N5kjMC4RoH1cJ9vU2OE90HOd4hNMUuEGmpFZPZhOGNVlc1XYZ+yyGcqqYs9GFXbfo7FrmRkEVW7I0iStDFEqTaj9oQtC9VSSUGN/L/Hurge4ismmufo2fxZDe0+So5eeb+5zNsKCaKqVSP7CCVIpvvAu4ipy+pCAd7Udre9XXR/b6q2jyGohGh9wpsCMMmYYWEJshtkRf/1Z9TmwDqaOYEe5Xy1GiQ8De92DceRY4tUB/PO7YAyOXDjXnRxCV0EvwF/Kz218M5Y3hV0qXyWL4ccOAKMUZG0/ghE97fXz1suM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:54:13.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b683370b-83a4-4ac8-555a-08dea59236de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
TMZ field should be 4-bits wide instead of 1.
Also add missing src/dst_cache_policy fields to
tiled copy struct.

Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 7c8d179e3554..af487fa0db03 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2255,6 +2255,8 @@ bool dmub_lsdma_send_tiled_to_tiled_copy_command(
 	lsdma_data->u.tiled_copy_data.data_format      = params.data_format;
 	lsdma_data->u.tiled_copy_data.max_com          = params.max_com;
 	lsdma_data->u.tiled_copy_data.max_uncom        = params.max_uncom;
+	lsdma_data->u.tiled_copy_data.cache_policy_src = params.src_cache_policy;
+	lsdma_data->u.tiled_copy_data.cache_policy_dst = params.dst_cache_policy;
 
 	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 6579cf9cce3c..ebcaf49e5961 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -240,11 +240,11 @@ struct lsdma_linear_sub_window_copy_params {
 	uint32_t src_slice_pitch;
 	uint32_t dst_slice_pitch;
 
-	uint32_t tmz              : 1;
+	uint32_t tmz              : 4;
 	uint32_t element_size     : 3;
 	uint32_t src_cache_policy : 3;
 	uint32_t dst_cache_policy : 3;
-	uint32_t padding          : 22;
+	uint32_t padding          : 19;
 };
 
 bool dmub_lsdma_send_linear_sub_window_copy_command(
@@ -286,12 +286,13 @@ struct lsdma_send_tiled_to_tiled_copy_command_params {
 	uint32_t swizzle_mode     : 5;
 	uint32_t element_size     : 3;
 	uint32_t dcc              : 1;
-	uint32_t tmz              : 1;
+	uint32_t tmz              : 4;
 	uint32_t read_compress    : 2;
 	uint32_t write_compress   : 2;
 	uint32_t max_com          : 2;
 	uint32_t max_uncom        : 1;
-	uint32_t padding          : 9;
+	uint32_t src_cache_policy : 3;
+	uint32_t dst_cache_policy : 3;
 };
 
 bool dmub_lsdma_send_tiled_to_tiled_copy_command(
-- 
2.43.0

