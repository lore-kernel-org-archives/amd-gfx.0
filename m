Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B799F606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uN66bRkS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406AE10F8EC;
	Wed, 11 Nov 2026 01:43:56 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607E910F8E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOBjr8eti0DCwLp7nILW6bUzaDPf7cu5kXPcqNZ2EB50jp7CjrPddMofX6U35II+4H9u/J95LZkNY9YgefQ4+5mVXwqEu2pbPcKPP6oiW4MrFPJJpf0y9czRHq0iEmAQCzsmn5N2r+mtZAVW+LFJAiL5avKDXsbmntGEj7jXQ0X8guFKE7R6l6XKVk0uxVo21cpKi8LI+2AYeoFAIbwVlQJ0Epb42sKLClI3/lB4iTufJm1ZI3sXyqV5ib6Xkp4HciOs/VjzY1Fhqsfcn/kC6P2l+R2dVzZEB2HZ74XZ8R3PNfVeB4FMLupLXytbYCrXgwXz5WsiCQYJJa1P/MVWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6wrv2/sTL8eE63zQV6tEoMlS3NiFvSIjAuSWPMr6Lk=;
 b=mB54x+GSBA7z2AZhwDsa4kDz8lEARXcNVqoPMe8TYIYCoa/OlGBFRvHBNWMrNH2vOMXYQ4OlkauCksFKBQ7ORZp0OEs3UKfCaTyFOw4UJcedzBy5tJSz+OlvDr8VwvKUQ6t6DceLOFaGCtwMehBvZjWCr0xNVE0ElEjS9z5zOJmtBA/VlH8kNuKkiXdKanLR6/EDWDTz4sqEq8DUXDeDXJg5SifcKDT/Tq1LoXrUn6h49g6WnIEPDDruMaE3IRKzFsTqJ0tyNkQIGIj2ziVzfxT38NbJXtzOAP7IGRb6Ju++Z1jmk578A4lpg5PXOsHVBi4RJs5i3Sl0OFqU61H5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6wrv2/sTL8eE63zQV6tEoMlS3NiFvSIjAuSWPMr6Lk=;
 b=uN66bRkSLTnoOAhb3/wQoi8cq2ez2+L/aKUHsgB9+jUiJt0dItmGQzh5ML4Lea1/WoxSEhCD8wyQWPVxqtUkAzIGcqwScDPwUkdiSPE1Bys/JUrMTZi4RUFFatQvXp7Z+kTMKfAI2bSi8+A7tqLK6Z/ccFCSh+NfHNN4KBV74BU=
Received: from CY8PR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:4e::29)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 01:43:40 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::96) by CY8PR12CA0009.outlook.office365.com
 (2603:10b6:930:4e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:38 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:34 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 50/74] drm/amd/display: Only force P-State on first plane if
 TTU is below WM
Date: Wed, 11 Nov 2026 09:28:56 +0800
Message-ID: <20261111014100.3596072-51-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 9948a91d-0ef9-4611-2d3a-08df3f9535c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 7fZd/i2/r/W5RloNksRjFoN0BdsSJ3bXXgLMKDh6LvSIKU6PVLZlebiPUYt8Hsb7Y41ScXHdWHJRiOkOrqVGCEgm5oXri1sxl8ZCtDH/FpdU2u5ihzQStDo/nl7mcHrbGFWR+N5jwgtnJt4OqnF4Qn6JofU9BkOTpACasMn67IfIb0fzzEgm53LzNSviKz37x7xnBmSMFl5gWKzD2qJeNkYD3Y1BlIVgZqcfyWJ5v98Xq+MHBhTc83YQxvODpOljt08oXT4e3LlMKg8de3e5qyL553P55hNtGYWyK8q/J4W8FKww3UVm1enAnqM+t95QLEfwiVKZKOXw+PoKryUkwO8vEt6a7DVEj4xUn+SCJeQIbNqhB9f293+VIstWphBkCJlsl0C8EjhAWp/MUp4Aw/HiTMq8n91GdgyW1Efv6C9GbXjh79JN4tDmPHuTetCKRXL29EOCS7OAm00xYJoWwE+0awCPZt47gCgcEC50aMEN+S0gBR6YrUtn5oyQssKDOhWmof1+AvyfNbqdaJRYgVB23hv+k10i3xTWkaN1yR6Ks3U1II/jtdO/DPsTi19vAYRYMClRhbsc9Z8+WzbZ6w9M41IvSqiWxLgjfZDrSWak6SRX9vqYtZBG/oD679dhE+Yj3rX5QGWuuJ1uHEbz0fd5stgwMU4CH0ayF03nEvhdA0YQ5Xie5h33oKoV2jn867R8x3A5d3OaqfU+mpybKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6fXhTc7fx/ESn540RBdha1sv5hLgnOX10zKklZ25n8exIuhKgM48LAWeE5soUkZk8M1Swg9TQj2e+2M0Y5LOXThBstSl7l9siwpuF3LVUc4uIcg4VebRN2hRJBTctKfH5fGq+x2UaCkez4KSBfiFcn/VDPVyROK8dYAZglLpScH+EDuZkwenSg5nt0vZC/ZCIR6ux8Nhh2eXdkkAifDM6bdjQtPWNwyz8dBjcAvz+kBXwDwwgLkeu4AaBbtFcIf0+owWr00IAFF9i0bGRR3n3WjxdfzvHHO8WC6oNFXokO1o6QR/xIkMH72zhkexrEsagIF5l/xOBWsu08Xhrqqj8VMQawUNbw6HufL0JEvV533/yVl7w6P8g4h+RA+f0wJWOe+Ss/LessH21FjBienyzHcQx20/Uq+fVA/hGUpvnAjA8E5tgXHqRzCj+mxyNGwS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:39.3265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9948a91d-0ef9-4611-2d3a-08df3f9535c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why]
When the first plane is enabled, P-State is forced to block UCLK
switching while the new HUBP is brought up. This is only needed when
the HUBP MIN_TTU_VBLANK is below UCLK_PSTATE_CHANGE_WATERMARK_A.
Otherwise the force is unnecessary and adds a 500us delay.

[How]
Track the smallest MIN_TTU_VBLANK across the new pipes and compare it
against watermark A. prepare_bandwidth only raises watermarks, so HW
holds the max of the old and new values; compare against that. Only
force P-State and wait when MIN_TTU_VBLANK is below the watermark.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index cc78b4794cef..bac9c5e18e6a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2591,6 +2591,7 @@ void dcn401_program_front_end_for_ctx(
 	unsigned int i;
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
+	unsigned int min_ttu_vblank = UINT_MAX;
 	struct dce_hwseq *hws = dc->hwseq;
 	struct pipe_ctx *pipe = NULL;
 
@@ -2623,17 +2624,31 @@ void dcn401_program_front_end_for_ctx(
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
 		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
 			prev_hubp_count++;
-		if (context->res_ctx.pipe_ctx[i].plane_state)
+		if (pipe->plane_state) {
 			hubp_count++;
+			min_ttu_vblank = min(min_ttu_vblank,
+				pipe->hubp_regs.ttu_regs.min_ttu_vblank);
+		}
 	}
 
 	if (prev_hubp_count == 0 && hubp_count > 0) {
-		if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-			dc->res_pool->hubbub->funcs->force_pstate_change_control(
-				dc->res_pool->hubbub, true, false);
-		udelay(500);
+		struct hubbub *hubbub = dc->res_pool->hubbub;
+		unsigned int pstate_wm_a;
+
+		/* WM_A is only raised in prepare_bandwidth, so HW holds the max of old and new */
+		pstate_wm_a = max(context->bw_ctx.bw.dcn.watermarks.dcn4x.a.uclk_pstate,
+			dc->current_state->bw_ctx.bw.dcn.watermarks.dcn4x.a.uclk_pstate);
+
+		/* MIN_TTU_VBLANK and UCLK_PSTATE_CHANGE_WATERMARK_A are both in refclk cycles */
+		if (min_ttu_vblank < pstate_wm_a) {
+			if (hubbub->funcs->force_pstate_change_control)
+				hubbub->funcs->force_pstate_change_control(hubbub, true, false);
+			udelay(500);
+		}
 	}
 
 	/* Set pipe update flags and lock pipes */
-- 
2.43.0

