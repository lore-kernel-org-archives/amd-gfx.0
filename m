Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2FC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m7KuyZ/f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3833910F8C2;
	Wed, 11 Nov 2026 01:42:15 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D24010F8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc8X6hieTtLW+h099eFbWKpmF5yo94/ZKsJLnhQljYwx7Z9QwKTfOb0swZD4Jqvg+mqncAeZiMrYfhCwV5iTnuqcgVVnD+Vc9gpiKI1o6/so2TT/wm4kqE0Mdv0a/SIsAW5fUWN4gwJeE843OWmAcysHQ3FQEx+nzqdUb2tnu/2L92F0+RpKYKLintC4wK/on6MKsuD/DijjhQuHxnG75B/f87Jm3NBqt3Dqzjs1jvcPsAEZWdl23UaCvaG0ESJKzIGULb5cdROSwSVm/9s18AUMSbkp60jL6SB66EydmVLngxRHEn3tr5QrfIppcPeaJ+66//4Jl6/uAOgoeNqg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJFaOX6BTkYPZ6mpspjkW3iHEn9Uc0ePApfw0UWxxJk=;
 b=f7ZpZNaeO/QSney1ATQDZzNSGNSs5D9Ta50WR8U4D5yF1wyTSjzaTcFdTr9yr9gShVR4zALIKD65JTuWO/yeh937S44FJl2/KaR2x5/BzQ4gXj53nQheAVhOZYBjXdMgU9U2etseGaAQ49A6qPuojR2rnjPsqyf1SxFsvhuNd+ioO022lwroDv9Sz/DAtLATUXr+K1WGvmJ0czenpKIYmwdprqtTlzyvyHfTT0uU8KxGkoMCbH0tLROYX9jBlvEK/r3qwowOzVbWrZUAXMOOh/fWpGPdxO9rLwVwgj5F/unLmc2VWqe+ua7QYssIXyWo45ikoTwWFL5FM1onEOeo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJFaOX6BTkYPZ6mpspjkW3iHEn9Uc0ePApfw0UWxxJk=;
 b=m7KuyZ/f0wOtT0KiQUBz44uzrO4Bs6UtZcw8InTREj69gmKuRKJiT1tWuuPHSweXkrrRf7rlgbIry3b4y6QT6poUw8qbzgLXxtriSgJwEo7qodb9IvcoMInw5SWQ0bkr8sxDrEMvFyzLH40JstkvuEOTCA6EmUKQk/as+vmKNGE=
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by CY0PR12MB628325.namprd12.prod.outlook.com (2603:10b6:930:130::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:06 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8e) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.6 via Frontend Transport; Wed, 11
 Nov 2026 01:42:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:05 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 27/74] drm/amd/display: Fix Stage Optimizer Parameter Naming
Date: Wed, 11 Nov 2026 09:28:33 +0800
Message-ID: <20261111014100.3596072-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CY0PR12MB628325:EE_
X-MS-Office365-Filtering-Correlation-Id: bc41ec0b-74cc-4f6d-def6-08df3f94fe87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|10067099003|11063799006|261028144727099003|261009223027099003|261026140227099003|261102123227099003|56012099006|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: j9bgOeipd9cqe5NXJgbRKvgQT/pGG/dUHi9ql8FcjwuGLMQFJvchgJAPGUt7ur0ay3zWeaNWkb4XvLWYc/O1NghsVEvUsxSR48h7hkKSlafuvKwpxi8qjcPvE58TdowZO5IxYb8aZTeyaPLGSIXI8l6X4bZeviK26IfE7ZJfx0P9QtgtgAobHIXIDh7CqXbzBlrSiDN1CeK/RwAXu/ZLpX3IP+ffsQ4/5Qa04IxYpGuG5ieOLWaK08crwRBnJ28XpIPAuwajGnN94PHW9Wi7TdcThQLMCD72nN6dyH0XGkpoh/tZAcdAQBMBkq/2hw0oJb/QK97cMePZJlUlzLs028Owp3109UT9b/a49l7IAttb7WBd9enmltRy6VMqMNrlY+0iWV7Hrs94RcCKDVyRqbMCcIeuv1a5gzQew1Ke43rAj6JqqCAWARS2RzFhPxPOVXgTddtnnnBCQFuS7uhQPEQE8BjiGHSDev7er4bgDfNTi2HS60uF6eK6xAeJhUERxnR7M+LDhgMveDCDljLvu9uzBZ+/Zg7C1FbTrnVCzEgKqQTMN6xkHohlLM/ZiCl65WnKR85tpbyQiqCbS5D5hWxK/bp0CC+7ze+3/8oHKigCCPAYp0fuqHhyvUWH6Vba+avyFK4GI70poy08baYug8whv/MlHHTs1JhBUQroGCzc5YAKUrGt62IWKu5EG2pXYwstJPU6pgTgZt+PBDNjbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y6V1PFclXC73I+w+VAAxwwcOrreZ5nSO70Tk2jlzElQSeis1OKsL2DUsC2uF7UanT841q+v2nPKqrZWxWnueeobPG6OB4VLpz0s15mVDRr3Ca2c2vF0RoAw5EPuROTvy1tqMPxgtTVVb53rDwCeaUV5WfQ5RbwqU/MfEM++w05/4Bx6RAaZ2Uw3a57wtZ/DfDx8abuk4OdV/W+JzC5VBxu1e5R9gmKARPkjEbYmyZmYVvypRtQTWDudfSNI4LPrOr0VzJA1AXAEi0Iwr7q6Nta+oefksJejiip5Xwn0C0qTRNuXOHGpXZWm0IHG5Ze/8KeftziaSS0bBLyWhax8Wccl1GvvZSBcETVoBOLRYPI/nbj9cGUHwy8NxJzlEHexjdtj5/Hxum94YaRT6VUVkYUgmGj5NTMIMCtJFfUODhV9u+nLDRn2bMWIZnrbH0usf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:06.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc41ec0b-74cc-4f6d-def6-08df3f94fe87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB628325
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Header declaration misspelled optimizer as optimer.
Use stages instead to match implementation.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h  | 4 ++--
 .../display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h  | 8 ++++----
 .../dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
index fdcc42b9bc32..ec41c06a4b1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
@@ -6,8 +6,8 @@
 #define __DML2_PMO_DCN5_H__
 #include "dml2_internal_shared_types.h"
 bool dml2_pmo_dcn5_initialize(struct dml2_pmo_initialize_in_out *in_out);
-int dml2_pmo_dcn5_get_ordered_mandatory_stage_optimizers(struct dml2_pmo_instance *pmo, struct dml2_pmo_stage_optimizer **optimers);
-int dml2_pmo_dcn5_get_ordered_optional_stages_optimizers(struct dml2_pmo_instance *pmo, struct dml2_pmo_stage_optimizer **optimers);
+int dml2_pmo_dcn5_get_ordered_mandatory_stage_optimizers(struct dml2_pmo_instance *pmo, struct dml2_pmo_stage_optimizer **stages);
+int dml2_pmo_dcn5_get_ordered_optional_stages_optimizers(struct dml2_pmo_instance *pmo, struct dml2_pmo_stage_optimizer **stages);
 void dml2_pmo_dcn5_initialize_worksheet(struct dml2_pmo_instance *pmo,
 		const struct dml2_display_cfg *dispcfg,
 		struct dml2_optimization_worksheet *worksheet);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
index b3b297aca47a..cc29e80a975a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
@@ -9,14 +9,14 @@
 void dml2_pmo_dcn6_assign_pstate_strategies(struct dml2_pmo_instance *pmo);
 bool dml2_pmo_dcn6a_initialize(struct dml2_pmo_initialize_in_out *in_out);
 int dml2_pmo_dcn6a_get_ordered_mandatory_stage_optimizers(struct dml2_pmo_instance *pmo,
-		struct dml2_pmo_stage_optimizer **optimers);
+		struct dml2_pmo_stage_optimizer **stages);
 int dml2_pmo_dcn6a_get_ordered_optional_stages_optimizers(struct dml2_pmo_instance *pmo,
-		struct dml2_pmo_stage_optimizer **optimers);
+		struct dml2_pmo_stage_optimizer **stages);
 bool dml2_pmo_dcn6b_initialize(struct dml2_pmo_initialize_in_out *in_out);
 int dml2_pmo_dcn6b_get_ordered_mandatory_stage_optimizers(struct dml2_pmo_instance *pmo,
-		struct dml2_pmo_stage_optimizer **optimers);
+		struct dml2_pmo_stage_optimizer **stages);
 int dml2_pmo_dcn6b_get_ordered_optional_stages_optimizers(struct dml2_pmo_instance *pmo,
-		struct dml2_pmo_stage_optimizer **optimers);
+		struct dml2_pmo_stage_optimizer **stages);
 void dml2_pmo_dcn6_convert_worksheet_to_solution(struct dml2_pmo_instance *pmo,
 		const struct dml2_optimization_worksheet *worksheet,
 		struct dml2_display_solution *solution);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index f06affe1fbbb..54ec7ef7cbae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -1220,7 +1220,7 @@ struct dml2_pmo_instance {
 	 * return - stage optimizer count
 	 */
 	int (*get_ordered_mandatory_stage_optimizers)(struct dml2_pmo_instance *pmo,
-			struct dml2_pmo_stage_optimizer **optimers);
+			struct dml2_pmo_stage_optimizer **stages);
 	/*
 	 * obtain a list of option stage optimizers ordered by priority, Caller must perform stage optimization in the
 	 * same order. Caller must complete stage optimization for all mandatory stage optimizers before performing
@@ -1228,7 +1228,7 @@ struct dml2_pmo_instance {
 	 * return - stage optimizer count
 	 */
 	int (*get_ordered_optional_stage_optimizers)(struct dml2_pmo_instance *pmo,
-			struct dml2_pmo_stage_optimizer **optimers);
+			struct dml2_pmo_stage_optimizer **stages);
 	/*
 	 * initialize an optimization worksheet based on the display config passed in.
 	 */
-- 
2.43.0

