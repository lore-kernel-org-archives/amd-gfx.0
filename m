Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F2BC5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83A910F6F1;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6eqPCOI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5C310F6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNqJYSJSzhUDr+vGFcut5tGMYwDM4RrwITJlIBZzcdcM0rIWqRA7XIaBOQXywovPIbxETWTPbVMGbxT5Gk7OZ0PPPCedRiBiBxveheHjq0Wd/lYHX7hWBsWHomF7Eb8baBOwFyz8zWPwOgLNhUPDIjBALB2m5PKpI0PkWu+GpkiNrrfVmy7PoiabMEy+tuOh/E9vrVHR5cBQLDZv/hAXuAgl+HOXqZSoSzlYGY2I2c9JymvHiiEqlE6fFPiaXgTeN4Jtyn49Y4CsiD7ibeHjk7OBp8b+k04gyd/Xt6AjXae+0Oyo+L7m9T2mydQHwXmrP6AlCSh9LGoa3GgQJ0493Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF5+sM3CATM2v+tJJ5KuJseU3YqTNj5g60wcL9Wh7/o=;
 b=gY+CBDgLqN1bNhf1gjRFSUPmUv0eP3XZHUF3pBwwL5b73vgj3zdhdlHpQQSHH0EVtap8WqWWY5hIHnJfRas/oMnhqSWwW6AqyB68PMQKCyhfgK6XWgI3uO05mqAqsOvR1GG7PBZ/W9tihl2JrZIGEcbSflLf23xxGLUiYQqmv/x3O9GkQ6U1q5+9oySXcoXXpTvy8ltl86F7PKtaXTbBe0lVLqVc3Ka9JHWR6ieAOLydiqCBDHGa6cZGVNWUchWe0zEuuLu/+Sc0/42rmLQcH+oeV7nyxGsx4md/m0gbRxLdF0mTsvDaMUBB5icNGmkOtL9E7qe47TEkGj19sWqikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5+sM3CATM2v+tJJ5KuJseU3YqTNj5g60wcL9Wh7/o=;
 b=P6eqPCOIXD1sabBbgfepa1C5MzruOdedIVSFbFj+z9dTUzJExqxANffaAfRtBhp2zlBrUQh9yVMghHK9U/XH7UuOJ05uhY9eQSH/CpOZP4nyRsuPv5p3JYvfNd5iFWt7mPclUNOIezV/ioyi4nzBoBHXsDg4hPkyJHw4TMePYQc=
Received: from PH7PR17CA0015.namprd17.prod.outlook.com (2603:10b6:510:324::26)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:14 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::17) by PH7PR17CA0015.outlook.office365.com
 (2603:10b6:510:324::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 014/109] drm/amd/ras: Change variable name to avoid confusion
Date: Fri, 14 Aug 2026 17:01:11 -0400
Message-ID: <20260814210246.3067612-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: e013b94d-c809-4bfd-b7ee-08defa47748c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: NS5JsedAKdS4wm4eE/fUjb8cC5zMKQQyM4ix4trRFu9e8dtoUqHogbkfYasQKcgjd+rZrdGmYghBadGd6jAia7c/0/CImXen0T4VyqYwWM7hNVX0XQF+LcpV72IYbhD9JQTizk6D52YRhvvbTfKlFDYkGqj7Jt4PPHbKWY0iK2q4jPoyKGg9WQ/kpNEWBcmjRgEW7ZI7yRlbjirzv8osY3XbHXWSup3jAouBwQVXr6ea2suI1WOLJ4Xn5N/uttrAa+ksr+g65HGwJwSV1zYl7uPoHe27Meewmkht2j7g0drfPouU04Hthlv15eWq1M7/hh0WzOVJy0oBBPX7SRZa7R2wF/mgNcwFZSzDaI07spblEm7Rbi7OeIWmqSBEBFFblwQmIgDFbxbRWdZ9Ww+I4o+/0FAIGxkWsYVJB2IJMjQhUGRrsigRhEc3t1/L6q4QE6QbVdJrWaG8F8QaRsen5BLAAui4zzb309sIqmJ0U2LpDSSN8eYHar03GGhpykzHW884k/5P145vsD3CLSYqr1csioJOIoF5lqWpEhgouuobGHAARxtiKaxTVRxnmLWXufi6nSm3fJeHdJI5RWJ8sLHqGwlsOz18oD7oQQFlV5GWjG42bxC+oygYBsBQPBq4YlNlwHuEzrVTThv9WF4xc8AwcxQKHm0zHATudG5lzTDAsKsRKStwGO570yZsbQvdxdLpKzNPP/W4MuBXyz6wIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xA6yz6oRIEZCcRU45i32vjrVqmYMoCHXJEkol8AD9Gi096jfduJE5LE1Vpxw+dBTWbe/CcGiccfHzpCNdm+zRF1/hNWqyfRKquQlr91ZzzMUG3aFUswz95tyZladCkrYul9cNYsyiI0Ao9il0+a/rQztwZzEEOE+LEhteQV5FdqJN3xzIUeEAen88mpmpQw8U82tBIhaBhwxbyOQh/uOICbNN5NlFusVf1nLBjuSaa5ruIPaXoZSstQV0lWzvxTfa2BQRvj69+1OnLv5ft+mEnbFtq+k9EMF1aw3asz4SZTGdBYOF9C9jAoAXPYnw2YVaTjEwXNre0w7DC2riYW2g9WV9L2bZfczqjTgGj47yPxcziBiW6VrVaK//I1f9OXcWJ3MfVSc4xKVUMnsDtr1iw0hnoD5ttG/85LYnP7RSvkqPmk7PwG3IqdVpTzgtvA9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:13.7522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e013b94d-c809-4bfd-b7ee-08defa47748c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Change variable name to avoid confusion.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            | 22 +++++++++----------
 drivers/gpu/drm/amd/ras/core/aca.h            |  6 ++---
 drivers/gpu/drm/amd/ras/core/ras.h            |  4 ++--
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 67269062f072b..032524b921c14 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -185,10 +185,10 @@ static int aca_parse_bank(struct ras_core_context *ras_core,
 static int aca_check_block_ecc_info(struct ras_core_context *ras_core,
 			struct aca_block *aca_blk, struct aca_ecc_info *info)
 {
-	if (info->socket_id >= aca_blk->ecc.socket_num_per_hive) {
+	if (info->socket_id >= aca_blk->ecc.socket_num_per_node) {
 		RAS_DEV_ERR(ras_core->dev,
 			"Socket id (%d) is out of config! max:%u\n",
-			info->socket_id, aca_blk->ecc.socket_num_per_hive);
+			info->socket_id, aca_blk->ecc.socket_num_per_node);
 		return -ENODATA;
 	}
 
@@ -457,7 +457,7 @@ int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core)
 	for (blk = RAS_BLOCK_ID__UMC; blk < RAS_BLOCK_ID__LAST; blk++) {
 		aca_blk = ras_aca_get_block_handle(ras_core, blk);
 		if (aca_blk) {
-			for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++)
+			for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++)
 				__clear_block_socket_ecc_count(ras_core,
 						blk, &aca_blk->ecc.socket[skt]);
 		}
@@ -476,7 +476,7 @@ int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
 	aca_blk = ras_aca_get_block_handle(ras_core, blk);
-	for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
+	for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
 		for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++) {
 			aid_ecc = &aca_blk->ecc.socket[skt].aid[aid];
 			if (blk == RAS_BLOCK_ID__GFX) {
@@ -562,7 +562,7 @@ int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
 	memset(&ecc, 0, sizeof(ecc));
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
-	for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
+	for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
 		memset(&skt_ecc, 0, sizeof(skt_ecc));
 		__get_block_socket_ecc_count(ras_core, blk,
 				&aca_blk->ecc.socket[skt], &skt_ecc);
@@ -586,21 +586,21 @@ int ras_aca_sw_init(struct ras_core_context *ras_core)
 	struct ras_aca *ras_aca = &ras_core->ras_aca;
 	struct ras_aca_config *aca_cfg = &ras_core->config->aca_cfg;
 	struct aca_block *aca_blk;
-	uint32_t socket_num_per_hive;
+	uint32_t socket_num_per_node;
 	uint32_t aid_num_per_socket;
 	uint32_t xcd_num_per_aid;
 	int blk, skt, aid;
 
-	socket_num_per_hive = aca_cfg->socket_num_per_hive;
+	socket_num_per_node = aca_cfg->socket_num_per_node;
 	aid_num_per_socket = aca_cfg->aid_num_per_socket;
 	xcd_num_per_aid = aca_cfg->xcd_num_per_aid;
 
 	if (!xcd_num_per_aid || !aid_num_per_socket ||
-		(socket_num_per_hive > MAX_SOCKET_NUM_PER_HIVE) ||
+		(socket_num_per_node > MAX_SOCKET_NUM_PER_NODE) ||
 	    (aid_num_per_socket > MAX_AID_NUM_PER_SOCKET) ||
 	    (xcd_num_per_aid > MAX_XCD_NUM_PER_AID)) {
 		RAS_DEV_ERR(ras_core->dev, "Invalid ACA system configuration: %d, %d, %d\n",
-			socket_num_per_hive, aid_num_per_socket, xcd_num_per_aid);
+			socket_num_per_node, aid_num_per_socket, xcd_num_per_aid);
 		return -EINVAL;
 	}
 
@@ -608,8 +608,8 @@ int ras_aca_sw_init(struct ras_core_context *ras_core)
 
 	for (blk = 0; blk < RAS_BLOCK_ID__LAST; blk++) {
 		aca_blk = &ras_aca->aca_blk[blk];
-		aca_blk->ecc.socket_num_per_hive = socket_num_per_hive;
-		for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
+		aca_blk->ecc.socket_num_per_node = socket_num_per_node;
+		for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
 			aca_blk->ecc.socket[skt].aid_num = aid_num_per_socket;
 			if (blk == RAS_BLOCK_ID__GFX) {
 				for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++)
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index a8aac196605aa..76fd511dfa7ef 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -26,7 +26,7 @@
 #define __ACA_H__
 #include "ras.h"
 
-#define MAX_SOCKET_NUM_PER_HIVE 8
+#define MAX_SOCKET_NUM_PER_NODE 8
 #define MAX_AID_NUM_PER_SOCKET 4
 #define MAX_XCD_NUM_PER_AID 2
 #define MAX_ACA_RAS_BLOCK  20
@@ -115,8 +115,8 @@ struct aca_socket_ecc {
 };
 
 struct aca_block_ecc {
-	struct aca_socket_ecc socket[MAX_SOCKET_NUM_PER_HIVE];
-	u32 socket_num_per_hive;
+	struct aca_socket_ecc socket[MAX_SOCKET_NUM_PER_NODE];
+	u32 socket_num_per_node;
 };
 
 struct aca_bank_hw_ops {
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 5baeb15473a83..3e0203d627985 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -262,7 +262,7 @@ struct ras_bank_ecc_node {
 };
 
 struct ras_aca_config {
-	u32 socket_num_per_hive;
+	u32 socket_num_per_node;
 	u32 aid_num_per_socket;
 	u32 xcd_num_per_aid;
 };
@@ -319,7 +319,7 @@ struct ras_core_config {
 struct ras_core_context {
 	void *dev;
 	struct ras_core_config *config;
-	u32 socket_num_per_hive;
+	u32 socket_num_per_node;
 	u32 aid_num_per_socket;
 	u32 xcd_num_per_aid;
 	int max_ue_banks_per_query;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 8ba6d8d76a5a4..e2d5f3d968895 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -34,7 +34,7 @@
 #include "amdgpu_ras_nbio_v7_9.h"
 #include "amdgpu_ras_mce.h"
 
-#define MAX_SOCKET_NUM_PER_HIVE		8
+#define MAX_SOCKET_NUM_PER_NODE		8
 #define MAX_AID_NUM_PER_SOCKET		4
 #define MAX_XCD_NUM_PER_AID			2
 
@@ -89,7 +89,7 @@ static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 {
 	struct ras_aca_config *aca_cfg = &config->aca_cfg;
 
-	aca_cfg->socket_num_per_hive = MAX_SOCKET_NUM_PER_HIVE;
+	aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE;
 	aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET;
 	aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID;
 
-- 
2.55.0

