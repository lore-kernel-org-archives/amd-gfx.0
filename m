Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDCACDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B150C10F08C;
	Wed, 24 Jun 2026 18:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2kX2+JB6";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E540A10F08C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8kfK+lAgZFpWGaUmJZm4zYOi3AFN6/26mKlnB1+N6PJ1f348Szkr8LUCiMKF4X++b5Al0+zZ3ptHTxF7iU275kkJVz7dvUckO2EiDHfgRv3g4RRYF2DHQVgQfd+awqVU9ncm35IC5zF2oYyljU8mrMJrNkrGqPPS5wfFHuzGUsxe68QZK5kFABkRw97QCF0GfOm6k6W3wg+eLXPkzvAJisQlw/36QLUQOY6N4gUqGMsRGHDBNADoXZbnQX7iZpDWxp30O1XF60fuHp40A7I72ybSrvj9mu9tPEBiwCBzNbUduVFDd0VtE2mxlXo6McvKyOwtLpWo8jyF3d0qIUioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb2XjxXE7h7rjMancLKsS7F66KVFa3DxBeVrYUuLnAg=;
 b=t/HyzGvG81rpBC+yBWXTg4rJEPJLbdgzla9qYsLos0Wsq+gYhAtVvMWE7zb+/WGi8ig3Kqlv7GYmq/CyhL6GJOAOiIL56kEHWIYgbtR8euBQzktD5weyosj/W9cWwGJnEufzis2abKuAH8sgEHbNmDEAjmxipU00zs5jzTcTxS/hLWlJ06EeaDarik26aOz8P0hOpTh3dfq3PsaYlJ9xFmtlOgSO0WxCrw2RbqpQI8Frydn6lrA0WiJP9kFjKOGoqlbYuscacaPr86yOI6zXGwnhLYG2M4A9ju0toLQ3vpPuSv+B6gdkeKLy4vNn32XxmSHMfkC2gtt3bdM8PQygCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb2XjxXE7h7rjMancLKsS7F66KVFa3DxBeVrYUuLnAg=;
 b=2kX2+JB6w1hootIA80jSdRbIC9VcqMzAcMR7fnbCgBzBHDOufAj4NWog+2VUFUrnTLfpXWNXi7ddD802A8fICq+XBDfk+ZiwEnT2LJXMuf4dHjA26ntzOKQxkBMVABDdht2r1kkyIhlFRdMBMhwVhtfg1n0jQFsgUEVig4j3+oE=
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:22 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::86) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:21 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:20 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhuvanachandra Pinninti
 <BhuvanaChandra.Pinninti@amd.com>, Aric Cyr <aric.cyr@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 12/28] drm/amd/display: Cleaned up headers
Date: Wed, 24 Jun 2026 14:03:10 -0400
Message-ID: <20260624180829.4775-13-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 4438877b-3f6a-4953-abe5-08ded21bb796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VvhkyWX7fOaeRbpQOaSgtsYdpxNoOV4PUws0KmmRQr/2PoMMqifyi5oNVE+/ep8TI9ZUxmsRBwyeyTisO1J01DRFOnwws33oi0STdP3daIU3dtTMXILKtIIPGKRPHYedVrvkGc9oyDswZlhHiy9EORVZRm7dHVFC0ujCZErkxbbOvCh8nvIj3+JxomsVkRx//V+Eea1kV7M1Cnw4f5iNNZHeBFc2SL2CECN9UgC98is5E6K8v/100bjo0Qq4gFL79Pzj+pg9MROethAo6PWf93aPTySenVYVMzIZfpSfCx4LWZkYVOa61z8P0+1ZJf0mk4SKNmij5z7MyTOzG10R4rPGjNIe0O1tVUxAnnKOYy4YhYpfThYVb6KT6AUKYGa3Z5aS7kl0SSzg8eH4pmy2hu4CrUfvkFC6UrVBGTnq7oJf1ipXr+V3GsIYn2IUJG32z74r3V94AjOmNpBj63+ve3pXBLrok/XrVuVJMAsCQUHYa0om8HSPxZ3kmP53tMUyWxDrPHhCmlPrsASTeReUKwncXs4IavIp6x1O2DqH+4nUEparL4nesOkmGTnCxAurZTW//VqcL3JtGOLFLoeTXJHZDD4tvfyKaRS1npJVY+xY4jQpbdmd/qIt9nw6MYNQoEbO97QV8mI+T9H6cMlRw79MiDSCQM6hZRoWaukDO3fUYiRimo7aSiFQ3WOqOGEMtfcrzoPLlGh4zlcShBi1Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WFBGCkguY0yOc18vRuF5ygOnkHJ66e51x3matnaCgt25KzKHAtbBl/uI29ksaqjZg0uDSQh9sqbvqSjT2BZw0S2Qis++/UhcpvC+XrFLGw3bNL+Ao254C9vnNT9Ku+1eoVgRbVRmGpesco6nA/voyDn/07plKJwelgQFwZ294UUjvtzxLYVPR9nVE0v/1Bu5ofNXeeQtRkCj8XkXKY/qfmr6EqeQFPng0JGMcC1aoX5emDudTs1ixHsKR+hL5Lp7ev6/Rk/0U3NPaSvpb9YAqcqfLee7hyvDh8FwU0nqSRgjmOKNPORTnOhFpVmZb6KkHXDR7DPvlZ9EzPmFbzVn1AhccxV7hBa73icDMF5SCZhqfHZIxSp/LZd5BR/GRUg2OfT/HZHzEQKyfgYi1XLqRffwMnbru7Vivq6ad9VzAg38UMPY6LhnwssAsvCLzSKp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:21.7891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4438877b-3f6a-4953-abe5-08ded21bb796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

From: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>

[why & how]
The register spec headers are duplicated in the external asic_reg path and maintaining a local copy is unnecessary.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c              | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c | 2 --
 .../gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c    | 2 --
 drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c | 8 ++++++--
 .../drm/amd/display/dc/gpio/dce80/hw_translate_dce80.c    | 5 ++++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index fa0d63de1aa4..6cb5e8152cf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -26,6 +26,7 @@
 #include "dm_services.h"
 #include "core_types.h"
 #include "dce_aux.h"
+#include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
 #include "dm_event_log.h"
 #include "dm_helpers.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 59a0961b49da..cf11666eb791 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -27,8 +27,6 @@
 
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
-#include "gmc/gmc_8_2_sh_mask.h"
-#include "gmc/gmc_8_2_d.h"
 
 #include "include/logger_interface.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index b265a72eeb70..095869912c09 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -27,8 +27,6 @@
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
 /* TODO: this needs to be looked at, used by Stella's workaround*/
-#include "gmc/gmc_8_2_d.h"
-#include "gmc/gmc_8_2_sh_mask.h"
 
 #include "include/logger_interface.h"
 #include "inc/dce_calcs.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
index 6b08cab32ee3..7424da78ac93 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
@@ -27,8 +27,12 @@
 
 #include "dce/dce_11_2_d.h"
 #include "dce/dce_11_2_sh_mask.h"
-#include "gmc/gmc_8_1_sh_mask.h"
-#include "gmc/gmc_8_1_d.h"
+
+#ifndef mmGMCON_LPT_TARGET
+#define mmGMCON_LPT_TARGET 0x0D53
+#define GMCON_LPT_TARGET__STCTRL_LPT_TARGET__SHIFT 0x00000000
+#define GMCON_LPT_TARGET__STCTRL_LPT_TARGET_MASK 0xffffffffL
+#endif
 
 #include "include/logger_interface.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce80/hw_translate_dce80.c b/drivers/gpu/drm/amd/display/dc/gpio/dce80/hw_translate_dce80.c
index fabb9da504be..19d148a85f12 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dce80/hw_translate_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce80/hw_translate_dce80.c
@@ -35,7 +35,10 @@
 
 #include "dce/dce_8_0_d.h"
 #include "dce/dce_8_0_sh_mask.h"
-#include "smu/smu_7_0_1_d.h"
+
+#ifndef mmGPIOPAD_A
+#define mmGPIOPAD_A 0x0183
+#endif
 
 /*
  * @brief
-- 
2.53.0

