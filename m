Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4215606A336
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aJE9BTyB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8387B10FA1A;
	Wed, 11 Nov 2026 09:35:46 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A305910FA20
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmqJuQF3MLMIdAs3khDgpdmVK3Hhg0B8M7wO6dbjw7Rxp6muBvqQzPR/ogVxiWj2jLzYE1aVm4pIVeJYDpmAF8DQJ6jqrKz+CgCyomcQyMHo72ATyXyGnS1P8UVT6pZmZ/NRg/J/UFo0QyQ3z24Cp8Nif3Z0Y7Kx3GkePLdXhGVKPckFo/IVgqrbqm0w5NQKcEhVZ1INdHNsvHrDBD9+g0Ds5W7ENN47lwspMScExjjV/iRtEMeC/uOtFnXVjTtTeAub9zOKeF9fwnGFVfDSYkAJdPIqQ0R/zjsHtDVpHK87JS4dlTsfzEee7ZHT5IFDO5JvkmkLIXnCYAqjHRd48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kM7KIqgi/5fHgDcXg3DlYaq7cGbhjFcgSwR5rMhD/s=;
 b=RyY74F1VQ8G1dY6VKx+rp88wvRGu88IbddpRBXlQY1Uj08KL47UDzUf409x2jgDYdie4AfZ0KkA5jfQN9h262481IpSfQ9Qtb0q8rACb2VOpVi+H3i05ZNS/3iwOIFQajbX23ba/aWWx3kEWoyzjlPQI/LjLUhjlr5+wMgvkh5JTVI9vWV2BoCNgPGTdM8tCo852BYsQJXZjv6BxS6nngLAicyNPcq1ZUlulU+s9D2n+G/wS7OQvOG2FcYfcAqlo9A6ZwtKuXhtZg+pjc+3qr/ULS4b4vvhalMkTmufrrrwuC8lzFuQLKVPUwHo6tPppFZs/7cwHO2x71t2BIblN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kM7KIqgi/5fHgDcXg3DlYaq7cGbhjFcgSwR5rMhD/s=;
 b=aJE9BTyB9P+DmPZ8CTulZPs6VqC9/nX7h3ueIkhl55nWnDCbG2JIlHx1GBVxVmUtSfzG6pWkQxvZ+dZt0SaChKe1087QGsGvYRsL24mJv7IXDxomQqzbSlZXRA764oiQQAUPxIrW1SPBTxey4adevWQD8XDvXPgQCG1USfjkUKE=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:35:37 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::85) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:35:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 09:35:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 03:35:36 -0600
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 03:35:29 -0600
From: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <raghavendraprasad.mallela@amd.com>, <HemaLatha.Pinnamreddy2@amd.com>,
 Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>
Subject: [PATCH] drm/amd/display: Fix aux timeout callback across engines
Date: Wed, 11 Nov 2026 15:05:28 +0530
Message-ID: <20261111093528.2918607-1-raghavendraprasad.mallela@amd.com>
X-Mailer: git-send-email 2.17.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: c251511e-0006-4514-8106-08df3fd72405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|3023799007|261022105027099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: tYor7+jbWvJ63yyjDyeu0wKJ+frrp5q9HI7Ayq3MWCsr84Yaj+I3dEjUp2/WQxquOKggyqFjLxBBSx2nyIbFLgSZHlzXjNVt+Pi4DyI/FQECbkHNDoOD7u2KNmcC8Cdozm+yqQbjmODLQWL33IKnxDYZQNWLXY5yMHKRu96Knxu94pM6Xdax58SF5E7Uld+BlXBdKw7s/dhZWyDroF19KMmJeRqCxSyOrfCQJFBkR44fb4P+VDNcZ21ZmJMbxFv/iju9EuCaWb+lWbsC2qxv8cIr06+whoHJxqEEpCRXX81UKx+nYyJCTmt1vz/addKTra3r3QHMKB/HFT8qATKzn0SlB4AwFjlgAMbkE6bm/Sou9mjMDr2BXQ4CDXCruYPd1kOucRPXoMl3OiyL/KYmrRYf5Z0v39+H1/WfBzDagx0+bXT590JOcUWUmW1zPsJ0hLLdzd5wAp7om1/YNK99mpTr4+7cGxuuIWx3g2bsVAdCkdIDtsTyvvbmhyaDmsTHMSvI+O4bOby/mPuRMuz98haQUsdDkDWvcmGAATc6WoqcAA/mGXQLc61t15nCHl1BLhN7yrwnYGC2UNph8fYME8sImJixTTX0pjjAPtxHapUMxBRt9bWeO/PBx2zAy0rGoDKZcs1X/PlZKyXPsaoOhYECZQlz5RWGlPk5H6R+rY5DKqmICndnW5BJC4ARHHetJmdDROCkGeDbBfHkMMerLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(3023799007)(261022105027099003)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q31YZIDKjKxAZgT97/WdOdJ5ic9ldZzyzxBxcWXGCrR+W+Kpg88pE3hu/4p/O4SZiVj3o4bRaZOS93s2dlZsAA8omem2xRHfuab37Zfe3iEVavR4318ucVqSwMZmStZr4ZA9eiGEA7wQ9rDssIdXNF5EwHDESW9pGlum0Qf24biiAyATHEmzjL100gBjSoObLhpoIRdVHOX1xon3pV82SenpRYpNNPOx8853thetXZebloUojiW5idWmWteI5lu4Sr9n5Hr6GOD3hZ93nf8H2HUICYWEseHGlHxInQwxm2N1TLPgAl1u/YWhbUgVEo2V6IPd+cgpObuSmOEOHILKrjPU695ov1IyeMBYzZMSXArD6RGdiF2lDMpsHT341+o7CU1SQGZJZJWpN4HQK23s5pUnNoqHSe0jvxuEtk2HrXmxZ8cm2hwHS1Gbml/loHTt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:35:36.4316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c251511e-0006-4514-8106-08df3fd72405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

From: Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>

[Why]
Aux engines across multiple GPUs share single static
dce_aux_funcs. When an engine supporting configurable
AUX timeout is initialized, it updates the shared table,
causing unsupported engines, including DCN1, to inherit
the configure_timeout callback. As a result, these engines
incorrectly attempt to program the AUX_RX timeout.

[How]
Embed dce_aux_funcs in each dce_aux instance to maintain a
separate callback table per engine. Set configure_timeout
only for engines that support configurable AUX timeout.

Signed-off-by: Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c   | 11 ++++-------
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h   | 18 +++++++++---------
 .../amd/display/dc/link/protocols/link_ddc.c   |  8 ++++----
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 4abf51c8ab52..10eac67ac784 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -602,11 +602,6 @@ static uint32_t dce_aux_configure_timeout(struct ddc_service *ddc,
 	return prev_timeout_val;
 }
 
-static struct dce_aux_funcs aux_functions = {
-	.configure_timeout = NULL,
-	.destroy = NULL,
-};
-
 struct dce_aux *dce110_aux_engine_construct(struct aux_engine_dce110 *aux_engine110,
 		struct dc_context *ctx,
 		uint32_t inst,
@@ -626,9 +621,11 @@ struct dce_aux *dce110_aux_engine_construct(struct aux_engine_dce110 *aux_engine
 
 	aux_engine110->mask = mask;
 	aux_engine110->shift = shift;
-	aux_engine110->base.funcs = &aux_functions;
+	aux_engine110->base.funcs.configure_timeout = NULL;
+	aux_engine110->base.funcs.destroy = NULL;
+
 	if (is_ext_aux_timeout_configurable)
-		aux_engine110->base.funcs->configure_timeout = &dce_aux_configure_timeout;
+		aux_engine110->base.funcs.configure_timeout = &dce_aux_configure_timeout;
 
 	return &aux_engine110->base;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index b2153cb03b51..126768f098c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -238,6 +238,14 @@ enum {	/* This is the timeout as defined in DP 1.2a,
 	SW_AUX_TIMEOUT_PERIOD_MULTIPLIER = 6
 };
 
+struct dce_aux_funcs {
+	uint32_t (*configure_timeout)
+		(struct ddc_service *ddc,
+		 uint32_t timeout);
+	void (*destroy)
+		(struct aux_engine **ptr);
+};
+
 struct dce_aux {
 	uint32_t inst;
 	struct ddc *ddc;
@@ -247,7 +255,7 @@ struct dce_aux {
 	uint32_t max_defer_write_retry;
 
 	bool acquire_reset;
-	struct dce_aux_funcs *funcs;
+	struct dce_aux_funcs funcs;
 };
 
 struct dce110_aux_registers_mask {
@@ -318,12 +326,4 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *cmd);
 
-struct dce_aux_funcs {
-	uint32_t (*configure_timeout)
-		(struct ddc_service *ddc,
-		 uint32_t timeout);
-	void (*destroy)
-		(struct aux_engine **ptr);
-};
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index db798656c8a8..0a44382ccfa2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -549,13 +549,13 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
 		return true;
 
 	if (ddc->link->force_to_use_aux) {
-		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout) {
-			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout(ddc, timeout);
+		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs.configure_timeout) {
+			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs.configure_timeout(ddc, timeout);
 			result = true;
 		}
 	} else {
-		if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
-			ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
+		if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs.configure_timeout) {
+			ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs.configure_timeout(ddc, timeout);
 			result = true;
 		}
 
-- 
2.17.1

