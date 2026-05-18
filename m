Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C134ACD4F48
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C432510E6C2;
	Mon, 18 May 2026 07:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YEaKqpgr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3D010E6BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZs1G3aKsKN+JyW6t2DusDxtu/b4+UcayBVX5TQwvQBSbLx8vbSE1HLG3yib37YA+PBF/dzeJGmvYJdgynZRTdZqpG5aOWkZ6W52CDUPD+TEn+80KRObXAKebK8Gl1wmM/DXB4DjZmOd+u/UL4ki6TW6cX7o9NKq1AG9eyF+2If+EfNNclZLzVnq71iipZZc8VXGI7G31qYfNXLy201ccMnZ8auZj5iwfZWLUTSomcXCGZua1q8ziZj68qZ/waVdVxT862u3w3+SUSQ2bPWXePYm0SEP2eag9mqejv7gu39Mjq3PcgrSL6mdDLTWDfRwmmXRFdgioQpYpjK57CH/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq8BOEKUjBsDmfLWziJt9AC0gqA1vMlPgAJoLKU/95g=;
 b=YBG2LLX4GnH+MLrD2mPA/ZczBSDJdIjxeDprdKqnPgmZI0P4LnR/fOTm169BYBT85Fk8tHF8iy1ILN3p0A7xh3d8CHTmXK86tZBXWg+nt2GzS13p5xdmFzApHr3zLBuRzG3J/neLwk/QrLecrxrp2yyYUFXrJy3Rbtd6LtzTtiIsR1Xr2VO6cEyoD66ye5UVg0y3H2p8BvlK+jd7k2NUsC9hpv7F3CFsSgQ+l9BwINW1ynIKdUHwblEw2INcVei6ca9exwUgcDpA0R3DlaFp7B6QJXW15ktgAUmS28UVM6wADxGft9R0O/bvAqC6c06BShZZNExYGpLcL+J6R3SY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq8BOEKUjBsDmfLWziJt9AC0gqA1vMlPgAJoLKU/95g=;
 b=YEaKqpgr5LoN+s3j88z0bYN+zyeud4k89XMvOBxWJTzjv+3q1CzoWKVsO48XM5JwUTcFLOwJtta6vFnP2Qi3DaHS4n49ooGARRjJ7dQXH+c6aIDw5FcxWmrEGgyehefTpRFHDV7PQ2gtd/l95cIeEpFBhQuyl1m/7MifbHHbp60=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:23:19 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::6c) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:18 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:16 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 3/7] drm/amd/ras: remove unused code
Date: Mon, 18 May 2026 15:22:11 +0800
Message-ID: <20260518072215.3647120-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d407aff-9ee2-4ad3-e79f-08deb4ae55cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dUFmr3NQPmIz7dAFDRxE//HCvH+0aBDKoyh/0Mv4V+MKGK+zfiCdljmdrJ1IMjhfweGzyY1PgMCO2aFH7IFjs8LcyyUpk+7SqLEWV8LmXBMAmgh16ZUy9O9rNmajszU6t2z086X1YHL1Hzbl51V1jl2cLwc988iakb5ZPZj+6GTlsJcmqK21xgGBSKzS/BALfJ/6fBX79ck0BVX/OPjRABpmQpxffVFXnprnRTg/x108nqkisZwRj0dUYPHVYCRjeayaOso62p9Uhh6+MhDMxnXcRaWN5dp2ZE9AwvDZz5ghn8DKILFt84Li/zEPeAyMVnDLcFxEtqg0Qnfm2R5XmJ4tLkpSTMHAi44VprkvPwJYDJXQCtj9APOwvmwxn53dKPZXZbEzsCbhCar2ZTC2dnr8Tys7prQZJzqTVBoC03SJqyPjUXIIaRowx1xlHlia4Pw+lU2y1dvHDKpWd+zNtaZ/LpxgDsOGQML3gd9ibwR1wLxG7PIqqelNJO9FgMbfnCZEh9sp2rFGUslEuDqWYMBhIWbkgaVihRl0oNubeLUYrU0Pc2x2biNy4on/WC6eRUXXkDvh3mHb9KOLZNXJkGPkDkn9B4MYK8b4x41u46hTABb3cx/cr5LPOLCppnVX6fPZ/LWB9j188hfBU2SmsyiUU0+/Zr4a54Qq4F39JchBJ+w9HRJQHqxJzPY13qxD+oDhjbtTG8/xhgwTmSZ6Vwt2EtH8kbaW8DdGW3av2cs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EOeRspHRX9H22YGF4KqBUWij6mtraEo8BDYLhz94ZyphVfQA34ghD5Fy91MxSARxIFSYT7mrT3zQSy2NAoraq+QMq+RnbWWjd7g6BW51Ig72tvxg4X9NiYxXy+gQace/RtW8pbaiXf1xFyVq3HzZ2iL2tx5OfhHi4WVmgh3DtA2AhbHbG9C46s0uZ06evc+WuIF2WDWWO/STtE4S+beZfr68HoHyrT8ih72K6wvOtPvEJw1CXqrtY80gkj1rNzB117ZOs46FyRcfkSaNMyt/N6V1dnPM1JMNGXKVjXBN6RT5NHc1ptGk56NDyIpIPR15LYE5vAtCK315Evpkb5f0jiYM9A79uLKZSiIrKB9vnoZ+4i1a9MTaRYQfd4aJyewb7xDO+3PGanBW/MeDTUhQCbVW8m+joDMB0TkikN5Rh3k5LAOee9/m1INn+4WDyk6N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:18.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d407aff-9ee2-4ad3-e79f-08deb4ae55cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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

Remove unused code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h     |  1 -
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c | 22 +---------------------
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h |  9 ---------
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 6449d7b8627d..c059fcebaf00 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -329,7 +329,6 @@ struct ras_core_context {
 	struct ras_gfx ras_gfx;
 	struct ras_mp1 ras_mp1;
 	struct ras_process ras_proc;
-	struct ras_cmd_mgr ras_cmd;
 	struct ras_log_ring ras_log_ring;
 
 	const struct ras_sys_func *sys_fn;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 39136db34bb2..1136db9e29c4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -28,20 +28,6 @@
 #define RAS_CMD_MINOR_VERSION 0
 #define RAS_CMD_VERSION  (((RAS_CMD_MAJOR_VERSION) << 10) | (RAS_CMD_MINOR_VERSION))
 
-static int ras_cmd_add_device(struct ras_core_context *ras_core)
-{
-	INIT_LIST_HEAD(&ras_core->ras_cmd.head);
-	ras_core->ras_cmd.ras_core = ras_core;
-	ras_core->ras_cmd.dev_handle = (uintptr_t)ras_core ^ RAS_CMD_DEV_HANDLE_MAGIC;
-	return 0;
-}
-
-static int ras_cmd_remove_device(struct ras_core_context *ras_core)
-{
-	memset(&ras_core->ras_cmd, 0, sizeof(ras_core->ras_cmd));
-	return 0;
-}
-
 static int ras_get_block_ecc_info(struct ras_core_context *ras_core,
 				struct ras_cmd_ctx *cmd, void *data)
 {
@@ -483,12 +469,11 @@ int rascore_handle_cmd(struct ras_core_context *ras_core,
 
 int ras_cmd_init(struct ras_core_context *ras_core)
 {
-	return ras_cmd_add_device(ras_core);
+	return 0;
 }
 
 int ras_cmd_fini(struct ras_core_context *ras_core)
 {
-	ras_cmd_remove_device(ras_core);
 	return 0;
 }
 
@@ -537,8 +522,3 @@ int ras_cmd_translate_bank_to_soc_pa(struct ras_core_context *ras_core,
 
 	return ras_umc_translate_soc_pa_and_bank(ras_core, soc_pa, &umc_bank, true);
 }
-
-uint64_t ras_cmd_get_dev_handle(struct ras_core_context *ras_core)
-{
-	return ras_core->ras_cmd.dev_handle;
-}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index a1a73e6452e7..4f76c849865e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -29,8 +29,6 @@
 #include "ras_log_ring.h"
 #include "ras_cper.h"
 
-#define RAS_CMD_DEV_HANDLE_MAGIC 0xFEEDAD00UL
-
 #define RAS_CMD_MAX_IN_SIZE 256
 #define RAS_CMD_MAX_GPU_NUM 32
 #define RAS_CMD_MAX_BAD_PAGES_PER_GROUP 32
@@ -107,12 +105,6 @@ enum ras_error_type {
 struct ras_core_context;
 struct ras_cmd_ctx;
 
-struct ras_cmd_mgr {
-	struct list_head head;
-	struct ras_core_context *ras_core;
-	uint64_t dev_handle;
-};
-
 struct ras_cmd_func_map {
 	uint32_t cmd_id;
 	int (*func)(struct ras_core_context *ras_core,
@@ -482,7 +474,6 @@ struct ras_cmd_blocks_ecc_rsp {
 int ras_cmd_init(struct ras_core_context *ras_core);
 int ras_cmd_fini(struct ras_core_context *ras_core);
 int rascore_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd, void *data);
-uint64_t ras_cmd_get_dev_handle(struct ras_core_context *ras_core);
 int ras_cmd_query_interface_info(struct ras_core_context *ras_core,
 	struct ras_query_interface_info_rsp *rsp);
 int ras_cmd_translate_soc_pa_to_bank(struct ras_core_context *ras_core,
-- 
2.43.0

