Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5538DCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDFB10E86D;
	Wed, 10 Jun 2026 09:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xLVIJ0D";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBC710E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awk5UXTSvaW3H+Z+gtab+UStxhkj7M87gOUXwhOPWcFj2sU/4wUkuaNsmJfwyeH9CA5NyJnrBJQ7PtDiY0LbBCuPzB5OF5r+nnjz6NfqzG7a9+NaDboPb4gBoxk6fWkNv+5rSffAiMyO4oOt6emcmuWyOq+kt96DTue3VNO6nTQyJDyDJu6IGAhO/DL8oKwoeoSe8tpumk3Eiad7GTildmQ1IfW3qC5DMZkmrDy5CFH6z5Id42b1CwoaA427KCb+gs4QOMP3jKMHc1/0s8cPFMm89Rimrdj86sMtb1qCkG6cWhBETO6Q+o298bFzwHr6bP3c0AUADn7+eyxIVXCqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqbSC7SdBlKeQ237wYKPfQQ/OW0WCtbYDgMfpSe2naQ=;
 b=xYwDibrzNp8g1LiwFg6GWBH3HRx/s5AVdFfs59PBnA9hggyu5TKLU6YwoqVt54truNCCE/fN1icupK0zTWp+8HICvtcPXD2/RZSxzK5GvMS91+qcsVAnDXrh31jqV1SXqizpuLjuAPvXqeErm6KMYYwSEe7GF63MemHSQkLvyThArFdr9o9/N9R5J4aGFArNxQZ2X9SHkl4E41/m4cNuqd9Z399rOmGKWctZU3ucR2oKhqjUSjbCYcE49nTmv06pY6M7yXJapXDrUjvwoZRSzfpbBUhfRNA/b8Bs87jI6wmPHNN2cbo+MubFKQnXr3kBNb5kaQPTVo4LTNvAQwbd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqbSC7SdBlKeQ237wYKPfQQ/OW0WCtbYDgMfpSe2naQ=;
 b=3xLVIJ0DrkjlVTkBNhemHxvdIdEnuTeMxcon629QBKDPNcZ+XZ503KspznZQxDTSKwrnuYpObqiVAtBVDabP4Ks2m2E4lsErHVWUotw/R6a1N+6rgLW9MrpQW2rW6Xeu/MVmc6/zxIimzfa/z+ZPBKaTtFctdGBbFNpJ1f7Zwyg=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 09:48:24 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::73) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:48:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:48:23 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:48:15 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 03/32] drm/amd/display: Add utm_qos_model pointer to
 clk_bw_params
Date: Wed, 10 Jun 2026 17:44:47 +0800
Message-ID: <20260610094639.1965367-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 39175b6d-bc63-4680-999a-08dec6d56a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CNEGepjAvPAPganLbVsNvQEvF0nLxMzNAcDqfEx84dqiNneoHp1UP2GVGYh6ekVlN9xUzNfa5b1wbhgb8m5e57lFbMrbSxZs6ao3pyUcAUUjWTVh66EFlWlktp+3NFRsp+0FcI1ksv14XwVH+yKd2iP9+wgMQMjr/FPLgHC4lQUnXQzQM3lnpgMPfJqXKHaLROI3BFH14aWHm0bj/f8kHorbiMbHMXX9ZPPCcutiDA8+kzgDInUcYs+YwCui92ejT1P+au4YdPkSQWVO6Nwo0zewIkPm2zkroSjQPCOJRXaFFvSo33qM4YN+YRmXUnVj2TkQwmRa2IxIp71h+dctjp4JhfMOS/u6aEewkEXwCOUujXbKBIk187fOPwz8gzaoWwfFot+cDtGAlMeCQdUB5RsjxP6yNPBd4JiCTxjSPj4f7vY+VBE6K/14G85EHfJGhAXSNUmFrDxNQbzRlXvTs6dcmffnvS5O7T36Pmai5rghjyoKPeLoaVY2lSjp8JjKgJJwnBiD3ieEY/2nirPQEjbkwN3jKb4LPyiCsr9mxzzBf5/mFk1YYKl5GJwv74i6To8dhsIJr7BkB6STt0RIB5OP0mJ5p8oVHXf+PZR3GnTtjTmUcbTzQqibb/oOA5+BAayURsy/0NrdKiRfCf9U/UNADZfB9Q4xt18p8NnT8ndbkvwiqD6HDqMJ6tCl5jcx8zkKJaZzHP+GLFefqzjrXI4odYaHZi+Rf7y9+Ja8K7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hl4m1hWtLGCqAlpFectCsX59HIZfLQTmtJ+w/Pb1bqt86PAQxHAZpVignCy/4SGa5zDxt55a7o8X4xIoB+/E3x+dYPI7VGLeq8yHOSewS2MhY/UeP5L2AnvFMgiV0yNnujRH4cDoO4PuWlrIdxKbJ285jRdsBPrd5mtzgQv/Q3Z0f7LhirGyaqWh45PqHllKPEPwenKcDOFvv6sYxjGCeBeDLHFy9NkG+w+cdN/vEkXwJ6qOEPbzHlU6Y8i1Z7feHEJFg54iuUty0coq+cbnU8kcxikRIxMOpEMcLH8LFKgnEDrD/pyZR2z1Ao/MWptvRpNkfvMaHv+48Q05j1zs7G8IFXu0aCVSPpmWPoFWyyb+9w5J9WaIZgntH1/wZna7UfIiYhRUTqiVlatdalZI6MNqTukKeCeQ/W8UHbc3BhUPI6uvMOUhaQ/2PHmKkRqb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:48:24.3123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39175b6d-bc63-4680-999a-08dec6d56a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Add support for passing QoS model data from clock manager
to bandwidth calculation consumers.

[How]
- Add forward declaration and const pointer for utm_qos_model
  in clk_bw_params

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 9b5bdcddfa7a..69c4a49a40fc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -30,6 +30,7 @@
 #include "dc.h"
 #include "core_types.h"
 #include "dm_pp_smu.h"
+struct utm_qos_model;
 
 /* Constants */
 #define DDR4_DRAM_WIDTH   64
@@ -311,6 +312,7 @@ struct clk_bw_params {
 	struct wm_table wm_table;
 	struct dummy_pstate_entry dummy_pstate_table[4];
 	struct clk_limit_table_entry dc_mode_limit;
+	const struct utm_qos_model *utm_qos_model;
 };
 /* Public interfaces */
 
-- 
2.43.0

