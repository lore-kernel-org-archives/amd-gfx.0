Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F61606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vDv3e0iB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48710F525;
	Wed, 25 Nov 2026 06:56:18 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBBE10F4ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYKrBHPndGdD1vDU/iHswadoJ/AD4dPrZmG78xbP5DWrVCSgMSfXVeYMCnHs+cBKDEgjfTsbcr4anCJFAt1XaLgkbTDvrjmSG5DsKydngUgSXdYnK+GUpK721Bs8SKymL4DZS+BOpYZqouDsgSf6PWH1JnpDiBEBsOqgcuP3oUQRL0tcekEY9SPEBxfYv412fZfpnk6PRJcpVokyVLvt2phQZ70Cg1Kgjwte4SsDsx2j78BIIIi3zC4SeWkWHpdIHmupqEd9aTNxTI15+PQtqIad5Cbj6YxZOIzc51/0DJjFtL0Igy53cvh0U5hibfhj46hmHmkjwBo861PNpsd5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P20vL5qckHD3moFiZSwlSncoxY+rmmSU5bvRJbUembk=;
 b=yJqrIDL22CtWB3pK6yYwuTHuc9TkPspB85QH3qTD/SG5NWDYeqW4UT9gfP1cZe8p7N5nccwcURg3Qy3uyQjeY5wRppuqNjpysHmX0WWh1TlpSGedOPIbxjkssRmSIGKkRM3IsWedCPA6iSp10a7saLLvh49rEVbye++2Pv+/4eW8ogOMkUbjS+sRTdiJqzHnwys7Kdv0RXRD/CmUIJFMdNb+xNHhx5egz/zwb7LTjQMPhsnKBtPGMl4eiCdhezlBbOAx2Il2jGaRXjdH4LQ+cTQhWkrL+z/aDhS8LK8QKGL4BmQpVel3HxbHLOEUzqdDUY6th8KRZLMDmtoEgFC1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P20vL5qckHD3moFiZSwlSncoxY+rmmSU5bvRJbUembk=;
 b=vDv3e0iBNz2983dzgkRoxedgxbxOuUbBoaB4iSEE3Fgtx9FR0NA+UxLc2k5Izqo1HNUVYHgrhl8A2IYxISiLbQO0L8y8j8ZbOj7n7qKkdithKsDJ+jSHkGac8MXmg0P5zqSrFlGXo8r1/i7Vd2tk0Rhq+1xP3m9voZfYA31yRaU=
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 06:56:06 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::8a) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:56:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:05 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:56 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 06/27] drm/amd/display: Add DPMS-v2 init
Date: Wed, 25 Nov 2026 14:54:55 +0800
Message-ID: <20261125065631.3889665-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a04c9-21ca-4d7a-3702-08df4ac12d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|6133799003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: SjfY8DGGPSoLFxMN8QXwzw9s8ex7zwOjzsaGCeIxEPUuNdO2xMDAPFw0YEa0sJ9uIwp+eta0Rn+fX/9XjCEBjvCwX8gWTgAk2FUhb0L8RXplxlkqW6bzqvncIyYJfMnNoNy9AaoZejP6j2CeNvaoTnPu7qCoWSt8dpmp3J1TTbRtIgTtTO5sk3t9pZWdeqMCadcXGWRhNdRqOvMfIAy9pN/MNQ4tdY5WL/JUsayKKLxDkZY70jthJg1WuwLT9t3omSWTsJ8G/B7DlI88LVRe0U8LNhKJcScEyfT6qFWmdDVXS8N1hsOYUdyAbgEgJm6QiBtWDjRdza5SiewUt3bKJzewJl2LX4Aorh43UuIhyR6mbOS9DOqd/odp7jGYJ8hugj63BkUo80LS7xDju6c8kjV15frDed7oORAepAju2Tu1pCWoOfyxa9hS/Zf1ZM74GXdG1hg5YggUAXN1UlfjNjQ/SKBQun4pTk1XFXHS0jFkwuDPPn/rVvfFrt6/1xm6nMMIKbPywMRlRYOXO25xSgK9D4hNemK4Acg2k6XHoWa8KgYaG6AW4+bMRom88au66Ye26Ap+Qtj1CjPyiQrLbIPLo4v6cQNnsuY6QhWKwBaKg9UoRG2kOFXdrgi28ZtPQi/bKWn1I2gyn+YfccKC8wfsVPjh5gqIxU8PcxPwn0TCl2Cg+EmYNu0dKzXm8eHCdxk5SnVv89Abdytperzz8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(6133799003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvEr9brsxPHHzQbD/c7EAWu0Vm4O5nl1OWC8MuHgDWdgeKW2UrB4gd1MhW5XRYnJBN7IcZRdxpxvi2w7WSqvhQkZ32qtR8HadKykAur+LP0UYe0nIqwHzbUiwnwBPr5kL/jhKNgQJhorOz5YyTZmsOTw8qphYg/b8Jgzhpxog88P08kGkx6K0H7+yqa3qpWWqU8eTo/i4Uy3T9x7tYEgxfvl7U4ULC7UsLmmkRc5FXRQDm7tjQskZ34ZApg7rtbybCzGkXiGlGwgsgDtv37rD3Cvcj3/VhZa7GDv7nCg9m0J5OFJNPzOpYnCoQ9SNSVqz1uVd+gxLeE2QVeBMJHhJ5wHXAh8QyAWEG6IDYq1WN2U0n9cDO0UPZ2FwA9WU7izEoip6KaF+9/mgti3tG9JeBEgyjR686mvJhimTboDmmTEVUHByIMWWitePhmgbjUX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:05.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a04c9-21ca-4d7a-3702-08df4ac12d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why & How]
Add allocation, deallocation and initialization of DPMS-v2 context.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/link/link_dpms_v2.c    | 25 ++++++++-
 .../drm/amd/display/dc/link/link_factory.c    | 55 ++++++++++++++++++-
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
index 43c3f7dfa343..14f5bf4f53b1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
@@ -25,10 +25,28 @@
 
 #include "dc/link/link_dpms_v2.h"
 
+#include "dc/inc/core_types.h"
+#include "dc/inc/link_tx.h"
+
+// TODO: This should be moved to dc_update_state_prepare
+static void link_dpms_ctx_init(struct link_dpms_ctx *dpms_ctx,
+			  struct pipe_ctx *pipe_ctx)
+{
+	dpms_ctx->link_config = pipe_ctx->link_config;
+
+	// TODO: Implement
+	dpms_ctx->stream_descriptor = (struct link_dpms_stream_descriptor){
+		.dummy = 0,
+	};
+}
+
 enum dc_status link_set_dpms_off_v2(struct pipe_ctx *pipe_ctx)
 {
+	struct dc_link *link = pipe_ctx->stream->link;
+
+	link_dpms_ctx_init(link->dpms_ctx, pipe_ctx);
+
 	// TODO: Implement
-	(void)pipe_ctx;
 	ASSERT(false);
 	return DC_ERROR_UNEXPECTED;
 }
@@ -36,9 +54,12 @@ enum dc_status link_set_dpms_off_v2(struct pipe_ctx *pipe_ctx)
 enum dc_status link_set_dpms_on_v2(struct dc_state *state,
 				   struct pipe_ctx *pipe_ctx)
 {
+	struct dc_link *link = pipe_ctx->stream->link;
+
+	link_dpms_ctx_init(link->dpms_ctx, pipe_ctx);
+
 	// TODO: Implement
 	(void)state;
-	(void)pipe_ctx;
 	ASSERT(false);
 	return DC_ERROR_UNEXPECTED;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 919f67b76f91..1e32f96348b7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -416,6 +416,29 @@ static bool encoder_is_external_dp(
 	}
 }
 
+static void link_destroy_dpms_ctx(struct link_dpms_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	kfree(ctx);
+}
+
+// Do not dereference the pointer, as it is mid-construction
+static struct link_dpms_ctx *link_create_dpms_ctx(struct dc_link *link)
+{
+	struct link_dpms_ctx *ctx = kzalloc_obj(*ctx);
+
+	if (!ctx)
+		return NULL;
+
+	*ctx = (struct link_dpms_ctx){
+		.link = link,
+	};
+
+	return ctx;
+}
+
 static void link_destruct(struct dc_link *link)
 {
 	unsigned int i;
@@ -445,6 +468,9 @@ static void link_destruct(struct dc_link *link)
 
 	for (i = 0; i < link->sink_count; ++i)
 		dc_sink_release(link->remote_sinks[i]);
+
+	if (link->dpms_ctx)
+		link_destroy_dpms_ctx(link->dpms_ctx);
 }
 
 static enum channel_id get_ddc_line(struct dc_link *link)
@@ -896,12 +922,22 @@ static bool construct_phy(struct dc_link *link,
 		}
 	}
 
+	if (init_params->dc->config.enable_dpms_v2) {
+		link->dpms_ctx = link_create_dpms_ctx(link);
+		if (!link->dpms_ctx) {
+			DC_ERROR("Failed to create dpms_ctx!\n");
+			goto fail;
+		}
+	}
+
 	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 	link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
+
+fail:
 hpo_enc_create_fail:
 device_tag_fail:
 link_enc_create_fail:
@@ -914,6 +950,8 @@ static bool construct_phy(struct dc_link *link,
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 	if (link->link_enc)
 		link->link_enc->funcs->destroy(&link->link_enc);
+	if (link->dpms_ctx)
+		link_destroy_dpms_ctx(link->dpms_ctx);
 
 	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
@@ -965,7 +1003,15 @@ static bool construct_dpia(struct dc_link *link,
 	link->ddc = link_create_ddc_service(&ddc_service_init_data);
 	if (!link->ddc) {
 		DC_ERROR("Failed to create ddc_service!\n");
-		goto ddc_create_fail;
+		goto fail;
+	}
+
+	if (init_params->dc->config.enable_dpms_v2) {
+		link->dpms_ctx = link_create_dpms_ctx(link);
+		if (!link->dpms_ctx) {
+			DC_ERROR("Failed to create dpms_ctx!\n");
+			goto fail;
+		}
 	}
 
 	/* Set dpia port index : 0 to number of dpia ports */
@@ -982,7 +1028,12 @@ static bool construct_dpia(struct dc_link *link,
 
 	return true;
 
-ddc_create_fail:
+fail:
+	if (link->ddc)
+		link_destroy_ddc_service(&link->ddc);
+	if (link->dpms_ctx)
+		link_destroy_dpms_ctx(link->dpms_ctx);
+
 	return false;
 }
 
-- 
2.43.0

