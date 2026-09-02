Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E7BC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C89C10E58B;
	Wed,  2 Sep 2026 05:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMBmcafY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74F410E58B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahfLf2lSJz6zDVUBiWe3MYM91eIkUENSHOftnOeds2PC9W7KCo+1PQ17uSF9BAonwiNrGtGHaYAiQxdj5cdCTF8lBMLr1gpCTqSJ3rSCCVeQp24Op75msoY0FrQz/1b/dJn01tiAXWG+HWlNelHjL8LeYptLdCkKgWNGGqpQ29gcPYWXfA4+PdWmvbmhe45hLwmikGscRdljISvlDHNC1r3cEcj9diYJG0dfDxRFERCeZ127G+84Eei2bA9zGqX2/EeEIplTY5QbOeQ+UN2HrKZq1xZPgLbE6zN/m8CxSYYNoURkrXoDh4+uRY/PLZU4+yMMwgqUmJr8luOEp1D6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ra1Vze/W7gDpIG6A4d8wrVIq0uF1RynS3UVrwN9mOs=;
 b=GzdMdgKhdJaUhhum+M6okmRkpRHT8/lYczLykE1E4f05xoRxij57znrFuV3qbNIrrtyojjKWSFzMPCU0D39MjdWBMJHBVDMdJFoSVvPGIJ7R5glyi2l+FK5cb1QoSioGtccxfOs0gtUza2g+sCi6RQFn5kCwjsyTpoYA4bKO8foFVksptwr3DMgmHBtHVWRhk21P8y2sCzfW/OiPuXisUxlIAGG3lh4PToxuIWWShlMfJSC149xO9LzOxBiXKj7eFJDwZbP0uyUHS/QxIiEYg4FeWH8Lm8DpUT+yPS5XYu8HgtZenoCCOz6jIP2se2f2eO/lzd7tIp++1MaxeNQONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ra1Vze/W7gDpIG6A4d8wrVIq0uF1RynS3UVrwN9mOs=;
 b=QMBmcafYIcs04vq5gTNKZh1Acdzpv1LI+jz4I51lfD7WsA7JGbeerkvabl02LeEkoWe3LWpyylfrPqqMx/TSzOHETAEtYUHlyOdAmKaT7+3l5q7h9nk6FqaGYXX2lFBLzRO5WuEFZFQCyNVzltwxY9pXU3uoB5cwEp1Obil6vgc=
Received: from MN0P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::27)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:19 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::32) by MN0P222CA0023.outlook.office365.com
 (2603:10b6:208:531::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:17 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:08 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/40] drm/amd/display: Add override for LSDMA BW in QoS table
Date: Wed, 2 Sep 2026 12:58:28 +0800
Message-ID: <20260902050411.3473916-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b35f54-874d-4bff-dcda-08df08afc8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: Dc+d3bZ7znbL4hgEW4dwfGK+OydIyy9riSokNuFVVLZxoGCxnXzE6CRdo91zWQAPIkCkOtHDuYiikP4k4itpDzoUhSp3/aTkD2Ec66o9lsKjJsVDadoexsTLCJ8/Yh4jC5JnCyOH47XIf14031ic7++/rLJallhpO6hAE7Pbgbl9jVS8LQ9ql6yUtLa5FeC/c0NoQPZEzLjpLbH3sonfCKnz6Mt4rGcWqlUR3e6sYQ0m4t/wQP727XZHqgeTmYQ8pTJjo9aADDPvFy+YROTjnrCmR2MxBd5hX8ssjp77N5gMo26Pgu0wkRxui3hPCone25zNIRFbFw9bMc+OUYmTuRwsXadEwhM1CnF/xKvj1dHHGp2Rc99wuzQ0Ez2EnQKL/SE/jVXuCdyNTApWVAYtqMjdNRj5sXj44xJPA0pJIlfRT+FkbY4yfZvxxmqK40ELOZQlJF8Ds/CC8g+WozmACQMiKVXH2UbPYETkj7Uy9hFiIJn6ufllgjio0rFclFo58j8JBcTr2GJlQGlNir6mbG1DP+B82fXCCIOyAiUWh9PZelfGgtnWbF4UF5tqLDOu3FEuvtbYMNLhDCi/mJSh1L71aTk1oUg09YM/cNavvEJpIvtn9G8h0BIRQsF081T0YHM3v/oQK2xP70UoYfUAgG0zbqwJYTJWWJjog5mtL2WVR1mSSQzbp9wo2oPnN/swmUzbbTsvCH/But+UV49JOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dtj9pMpKvn5PfSoWk64cNAtzmRcocDtWlsOPOV+RAdT49GZBbImmhLoi6lT26qNKqvOhovjn6jKlbdSdMPHty1aBXSxTUMgMOZc6esRe5f242EzYSEVHOzVsQojeELzeaLxz3EZCuajCFw+GCRe4JeQQ8697MrPXxw0UzyKkrn8sDXJ5tzcRS/4V6GquSvuSw8IYmfrWfzW+PfwlqztQwWmUEoPK/Clob/6EhTEUHiccamfjklsaZM7LglqlNe6VyZRjMi2lbXOKNJvCDoJ+ZTC95LbUysjHTZco57d08w1BRpFgJ+6s6hGhG9QhHM6KiH5Ysvb5NpLrMEaW7bKZAFy+FESwiP36QMa8nQYRfEYlyCBcbgUUQyL0t/YpL7AVqAYR8sugAjXzjQSAC9umPpBIAJx8QD8evrvMYhCtrHrEFBP8pIIjlfX2RtbGCfYb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:18.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b35f54-874d-4bff-dcda-08df08afc8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
Since PMFW does not yet populate LSDMA BW with correct values,
add an override interface for debug purposes until values are
populated correctly by PMFW.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index c6f90b90c10b..83989b4b1fdd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -13,6 +13,7 @@
 #include "soc_and_ip_translator.h"
 #include "bounding_boxes/utm_qos_model_types.h"
 #include "bounding_boxes/utm_qos_model_dchub_v3.h"
+#include "bounding_boxes/dcn6_soc_bb.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -603,6 +604,13 @@ static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 		bw_params->dc_mode_limit.dtbclk_mhz = 0;
 
 	bw_params->dc_mode_softmax_memclk = bw_params->dc_mode_limit.memclk_mhz;
+
+	/* The qos model stores dchub_v3 as a const view of a mutable table, so
+	 * cast away const to apply the override.
+	 */
+	if (bw_params->utm_qos_model && bw_params->utm_qos_model->dchub_v3)
+		dcn6_test_override_lsdma_bandwidth_v3(
+				(struct utm_qos_model_dchub_v3 *)bw_params->utm_qos_model->dchub_v3);
 }
 
 /**
-- 
2.43.0

