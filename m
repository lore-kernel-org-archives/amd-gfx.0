Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4B606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YHgMIEry
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C4C10F8F8;
	Wed, 11 Nov 2026 01:45:24 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAE710F8F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbAxenBtjPKDJVZNEWU2wqjGNs9/3fJEejVk3ATts/z66zgZ91etDKkYYk7oM3Lceg02OAdzua+AaoEfLedjrcCoYiS45PXwZ5CZGx0WNQO63vDIPfbOGI57AmzlKNq/UL0v8En8Tc7vQvQHoXzSfsQrBTtvVLXw7N8jxy1H8oWw3if4knoEm+G6uXFUjyVCyl0tqMq5RkeRg/BEH2DAq3MdQ7g3FpFEjJSpCKqfv3Qj9vx6YeF5raidJ4W3YkpIaqH7h7XbZ26SOSQzFOxv+upMyrx5+uVJdWnv8OYhUeiAAJTEtcLhWLOpVkUC5n2Dl6VwSGjKtrpcFVR7PGKkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBFQph21bcqeS/wRsajJW/N8QupHGo5ORcs5Ti1ubAA=;
 b=l966aKFTtsOxnVMVvOe9apkH8PJjancWsCNwNW7E0Fzxm3HjHuXJoAG4wNVGKoSMxeWfkX/s45G5yp3e0/+GZ1t6T4wabjs2LpY+DBfSbvxaTTi6cjjP15jl9aWBmvaeQojv8BQKRFNMV4kV8n/HvBf9fpyJL/uNtlwqnG3AsyaB/a+k+IgA3RYmzMtS8Qw/P0VJ5P2pBMjNWUTCNW/XvNZtR291LSAATNwsWsrNcVcSIMnESKk6nIO/QeAqTlfW+xh3D0F0JRzPx7iz1NCiS51aBvW2kp5uotKVDhO65zb13h6ZI9OP3Bv5FrHwRUyUfNzCOAoq+1ga3Eh9pJOrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBFQph21bcqeS/wRsajJW/N8QupHGo5ORcs5Ti1ubAA=;
 b=YHgMIErysms8FuOy1v6w+udz+6NfyDxYyynbgLRb609eR4uO51IXDT5HMGzuLkV1cVVzlyE6QTH62YNB0Onh6VeEHo19C1cK0Zcor1VVpTzsaUAIZHgqIQ6Xd6fii5jdOcllSXssRWIoAAxS/fioL0m9JZq4H95lj0BG0skC/yw=
Received: from PH7PR17CA0043.namprd17.prod.outlook.com (2603:10b6:510:323::9)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:45:13 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::24) by PH7PR17CA0043.outlook.office365.com
 (2603:10b6:510:323::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:11 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:08 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 67/74] drm/amd/display: Make DPP_PG_CONTROL and
 HUBP_PG_CONTROL BLS compliant
Date: Wed, 11 Nov 2026 09:29:13 +0800
Message-ID: <20261111014100.3596072-68-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: 445f547a-51a8-493c-1ee7-08df3f956d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261102123227099003|5023799004|261009223027099003|261028144727099003|56012099006|11063799006|261009221227099003|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4KnsKCWfRbg2MVVj4MKUWbX1n1piVSOCcLJU2aSZyDPGCBDz4dLvbrtxWxED7hM3zcLuX58Zc80qRZgRFa1niIOrUfGuhdKZ2hfKALorTzGJF5gvTiTqGGsquXRbbmPPC3ysFiHiEKAPcWQsLKNI4QVr8SWSeAgTcRzTatWAsF2opweLQFHTlK5Qb7oVnJ6hu5ydRbUxmI+ccKdOdy1MY0SSFmGpspj4RCQwUAkt8kqzI6RBmFKta0/nar5+uKLpxjynVLRVhGXG+Z9FUOe4Zqpso4JGzjs0jaHQYEahTEruH8TPSMRiX1qU62pG9Z7VpcxMCx57VGIt6CkMUgIhrS6cN67r3p1vyvhCH2FWqlm86Xxcbcx9MvT0RtgLUG/TjMOnH3oD60bbpVeHsDKA6PXpRXNJwDN4mvUp8cKQ9uzCzLZ/+5O8rgbzyZCeKJlwtZnaxYujPoZ7Oo5LcLkG/JKoQC2GtJSpSRI+BB6AY+tNdJNhTaxwh9v2Ws5BzcLFCrFNDQ6eBo2NZvxVEz2fzVahuxJSRc8nOS5idsZ3P6mJzfu1EKk7oOC7UCc4znYn95syeYtpO6YBVeg7UWedNpbVa/PKjIyLcNpgjV81gqh53D0NwatgUUvYzcnR0CGAc5JaMTtJICS/rzWR+7BrQgPiiWU7v7BBtUMx/OmRhqvIyuBzhVHLhkUBoXJ2PkPmFGI7BJCPzMj/cm6pwMmD8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261102123227099003)(5023799004)(261009223027099003)(261028144727099003)(56012099006)(11063799006)(261009221227099003)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bmZZnZcWYKRROxRabG+1d1wIH/uoFvw1FHWmibcjkL334m1O8O+6xAvT5w4b82eaPpiIMiw3hZd9M4ee3W8pogt8Chdo93Q+vHEKSSZdF464NnKMQaEfldry9g8hXn82Bg8z0Z3RHyutNEM6yN4Tld2UP7gy4xAh10ClcTyMR/GYhL/65JJNZCaQJZbUFyY52zylk73RWzMwf0Sp1h9cHte1AIk/FzIIqoTcc6lEu0GecKmM4e/ezk3RNv4g+OAW55ixX/sRjK3QzfIINYkvd/46elwEBz0u/qzZCo/uiTDWrORqU3UpDyq8lDEV1fYb9+BX77aTP/JGVuzctdnfimlQu/hbvRsz98ZUDWOE//bbE7PBa2nnt4aIsNhxktrDoRWNXC1kS79WgnhZhTxe8xwySx1YuOk/oZT+gKtY4fmUNYtoPGVI/36fSHmO7/Wf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:12.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445f547a-51a8-493c-1ee7-08df3f956d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
- The DCN401 builders read IP_REQUEST_EN from HW to decide whether to
  emit DC_IP_REQUEST_CNTL, so the sequence depended on HW state at build
  time.
- The PG hooks read the PG policy from dc->debug at execute time.
- The DCN20 and DCN314 cursor workarounds found the DPP by indexing
  res_pool->dpps[] with dpp_inst instead of using the DPP being gated.

[How]
- Add DC_IP_REQUEST_STATUS. The DCN401 status hook reads IP_REQUEST_EN
  at execute time and keeps it in hws->ip_request_already_enabled. When
  it was already 1, dcn401_dc_ip_request_cntl writes nothing for the
  pair, as in the direct path, and the closing call clears the flag.
  Both executors only dispatch.
- Emit the status step and the pair only when
  dcn401_pg_needs_ip_request() is true: both hooks exist and a PG hook
  can gate (DPP PG enabled, or HUBP PG enabled and ignore_pg clear).
- The DC2 commit builder asks the same check through the new
  hws->funcs.pg_needs_ip_request hook, bound on DCN401. It is built
  without CONFIG_DRM_AMD_DC_FP, so it must not call dcn401_hwseq.c, and
  its include of dcn401_hwseq.h is dropped.
- Pass disable_power_gate and ignore_pg to the PG hooks, and the DPP
  handle to dpp_pg_control instead of dpp_inst.
- Adders validate their arguments and hooks; executors only program.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |  2 +
 .../bls_builder/dcn401_non_seamless_builder.c | 11 +--
 .../dc/bls_builder/dcn401_seamless_builder.c  | 20 +++-
 .../display/dc/bls_executor/bls_executor.c    | 12 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 62 +++++++++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 44 ++++++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  9 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 31 ++++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  9 +-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.c | 15 ++-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.h |  6 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c | 11 ++-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h |  6 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  8 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 15 +--
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  7 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 92 ++++++++++++++-----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 25 ++++-
 .../display/dc/hwss/hw_sequencer_private.h    | 14 ++-
 24 files changed, 303 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index 784a3cb4d311..cc301a02c494 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -126,6 +126,8 @@ struct dcn401_commit_step_meta {
 		 * so a plane add always programs the scaler and viewport.
 		 */
 		bool scaling_unchanged;
+		/* funcs.pg_needs_ip_request() is false: no PG hook can gate. */
+		bool no_ip_request;
 	} skip_if;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
index d28e162a6632..965004f6e49b 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -231,15 +231,14 @@ static const struct dcn401_commit_step
 	{ .func = HUBP_SET_FLIP_CONTROL_GSL },
 	{ .func = HUBP_CLK_CNTL },
 	{ .func = DPP_DPPCLK_CONTROL },
-	/*
-	 * dcn10_plane_atomic_power_down sets IP_REQUEST_EN only when it
-	 * reads 0. Every writer clears it again, so it always reads 0 here.
-	 */
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
+	{ .func = DC_IP_REQUEST_STATUS, .meta.skip_if.no_ip_request = true },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.no_ip_request = true },
 	{ .func = HUBP_PG_CONTROL },
 	{ .func = HUBP_RESET },
 	{ .func = DPP_RESET },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.no_ip_request = true },
 };
 
 static const struct dcn401_commit_step
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 8a563386d725..863919e0967e 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -14,6 +14,7 @@
 #include "dc_dmub_srv.h"
 #include "custom_float.h"
 #include "dcn32/dcn32_resource.h"
+#include "dce/dce_hwseq.h"
 #include "bls_builder/bls_builder_internal.h"
 #include "bls_builder/dcn401_init_builder.h"
 #include "bls_builder/bls_builder_private_types.h"
@@ -1001,12 +1002,17 @@ static const struct dcn401_commit_step bls_update_head_new_stream[] = {
 
 /* enable_plane, then the watermark propagate and the DET segments. */
 static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
+	{ .func = DC_IP_REQUEST_STATUS,
+	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.no_ip_request = true },
 	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.no_ip_request = true },
 	{ .func = HUBP_PG_CONTROL, .meta.hubp_pg_control.power_on = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
-	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	  .meta.skip_if.hubp_dpp_already_enabled = true,
+	  .meta.skip_if.no_ip_request = true },
 	{ .func = HUBP_CLK_CNTL, .meta.hubp_clk_cntl.enable = true,
 	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_INIT,
@@ -1690,6 +1696,9 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->dpp_dppclk_control_params.enable =
 				m->dpp_dppclk_control.enable;
 		break;
+	case DC_IP_REQUEST_STATUS:
+		p->dc_ip_request_status_params.hws = dc->hwseq;
+		break;
 	case DC_IP_REQUEST_CNTL:
 		p->dc_ip_request_cntl_params.hws = dc->hwseq;
 		p->dc_ip_request_cntl_params.enable =
@@ -1701,6 +1710,9 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 				pipe->plane_res.hubp->inst;
 		p->hubp_pg_control_params.power_on =
 				m->hubp_pg_control.power_on;
+		p->hubp_pg_control_params.disable_power_gate =
+				dc->debug.disable_hubp_power_gate;
+		p->hubp_pg_control_params.ignore_pg = dc->debug.ignore_pg;
 		break;
 	case HUBP_RESET:
 		p->hubp_reset_params.hubp = pipe->plane_res.hubp;
@@ -1967,6 +1979,10 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			!args->pipe->plane_state->update_bits.position_change &&
 			!args->pipe->stream->update_flags.bits.scaling)
 		return true;
+	if (step->meta.skip_if.no_ip_request &&
+			(!args->dc->hwseq->funcs.pg_needs_ip_request ||
+			!args->dc->hwseq->funcs.pg_needs_ip_request(args->dc)))
+		return true;
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 6a875add72e2..47c7137eeeaf 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -453,6 +453,9 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 	case HUBP_PG_CONTROL:
 		hws = step->params.hubp_pg_control_params.hws;
 		return hws && hws->funcs.hubp_pg_control;
+	case DC_IP_REQUEST_STATUS:
+		hws = step->params.dc_ip_request_status_params.hws;
+		return hws && hws->funcs.dc_ip_request_status;
 	case DC_IP_REQUEST_CNTL:
 		hws = step->params.dc_ip_request_cntl_params.hws;
 		return hws && hws->funcs.dc_ip_request_cntl;
@@ -1415,7 +1418,14 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					&entry->params.hubp_pg_control_params;
 
 			p->hws->funcs.hubp_pg_control(p->hws, p->hubp_inst,
-					p->power_on);
+					p->power_on, p->disable_power_gate, p->ignore_pg);
+			break;
+		}
+		case DC_IP_REQUEST_STATUS: {
+			struct dce_hwseq *hws =
+					entry->params.dc_ip_request_status_params.hws;
+
+			hws->funcs.dc_ip_request_status(hws);
 			break;
 		}
 		case DC_IP_REQUEST_CNTL: {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 82ac4ca4a13b..ecf90e3a770c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2094,6 +2094,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case DPP_ROOT_CLOCK_CONTROL:
 			hwss_dpp_root_clock_control(params);
 			break;
+		case DC_IP_REQUEST_STATUS:
+			hwss_dc_ip_request_status(params);
+			break;
 		case DC_IP_REQUEST_CNTL:
 			hwss_dc_ip_request_cntl(params);
 			break;
@@ -4066,11 +4069,11 @@ void hwss_dccg_set_ref_dscclk(union block_sequence_params *params)
 void hwss_dpp_pg_control(union block_sequence_params *params)
 {
 	struct dce_hwseq *hws = params->dpp_pg_control_params.hws;
-	unsigned int dpp_inst = params->dpp_pg_control_params.dpp_inst;
+	struct dpp *dpp = params->dpp_pg_control_params.dpp;
 	bool power_on = params->dpp_pg_control_params.power_on;
+	bool disable_power_gate = params->dpp_pg_control_params.disable_power_gate;
 
-	if (hws->funcs.dpp_pg_control)
-		hws->funcs.dpp_pg_control(hws, dpp_inst, power_on);
+	hws->funcs.dpp_pg_control(hws, dpp, power_on, disable_power_gate);
 }
 
 void hwss_hubp_pg_control(union block_sequence_params *params)
@@ -4078,9 +4081,10 @@ void hwss_hubp_pg_control(union block_sequence_params *params)
 	struct dce_hwseq *hws = params->hubp_pg_control_params.hws;
 	unsigned int hubp_inst = params->hubp_pg_control_params.hubp_inst;
 	bool power_on = params->hubp_pg_control_params.power_on;
+	bool disable_power_gate = params->hubp_pg_control_params.disable_power_gate;
+	bool ignore_pg = params->hubp_pg_control_params.ignore_pg;
 
-	if (hws->funcs.hubp_pg_control)
-		hws->funcs.hubp_pg_control(hws, hubp_inst, power_on);
+	hws->funcs.hubp_pg_control(hws, hubp_inst, power_on, disable_power_gate, ignore_pg);
 }
 
 void hwss_hubp_reset(union block_sequence_params *params)
@@ -4109,6 +4113,13 @@ void hwss_dpp_root_clock_control(union block_sequence_params *params)
 	dccg->funcs->dpp_root_clock_control(dccg, dpp_inst, clock_on, root_clock_optimization_dpp);
 }
 
+void hwss_dc_ip_request_status(union block_sequence_params *params)
+{
+	struct dce_hwseq *hws = params->dc_ip_request_status_params.hws;
+
+	hws->funcs.dc_ip_request_status(hws);
+}
+
 void hwss_dc_ip_request_cntl(union block_sequence_params *params)
 {
 	struct dce_hwseq *hws = params->dc_ip_request_cntl_params.hws;
@@ -5018,6 +5029,23 @@ void hwss_add_dpp_program_cm_hist(struct block_sequence_state *seq_state,
 	}
 }
 
+bool hwss_add_dc_ip_request_status(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws)
+{
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			!hws || !hws->funcs.dc_ip_request_status)
+		return false;
+
+	if (*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return false;
+
+	seq_state->steps[*seq_state->num_steps].func = DC_IP_REQUEST_STATUS;
+	seq_state->steps[*seq_state->num_steps].params.dc_ip_request_status_params.hws = hws;
+	(*seq_state->num_steps)++;
+
+	return true;
+}
+
 void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		bool enable)
@@ -5561,14 +5589,21 @@ void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
 
 void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on)
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !hws ||
+			!hws->funcs.dpp_pg_control || !dpp)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DPP_PG_CONTROL;
 		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.hws = hws;
-		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.dpp_inst = dpp_inst;
+		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.dpp = dpp;
 		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.power_on = power_on;
+		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.disable_power_gate =
+				disable_power_gate;
 		(*seq_state->num_steps)++;
 	}
 }
@@ -5576,13 +5611,22 @@ void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
 void hwss_add_hubp_pg_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on)
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !hws ||
+			!hws->funcs.hubp_pg_control)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBP_PG_CONTROL;
 		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.hws = hws;
 		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.hubp_inst = hubp_inst;
 		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.power_on = power_on;
+		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.disable_power_gate =
+				disable_power_gate;
+		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.ignore_pg = ignore_pg;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 79c0f55d11e8..08fff8d42cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -935,25 +935,27 @@ void dcn10_disable_vga(
  * dcn10_dpp_pg_control - DPP power gate control.
  *
  * @hws: dce_hwseq reference.
- * @dpp_inst: DPP instance reference.
+ * @dpp: DPP instance reference.
  * @power_on: true if we want to enable power gate, false otherwise.
+ * @disable_power_gate: true if DPP power gating is disabled by debug policy.
  *
  * Enable or disable power gate in the specific DPP instance.
  */
 void dcn10_dpp_pg_control(
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on)
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? PGFSM_POWER_ON : PGFSM_POWER_OFF;
 
-	if (hws->ctx->dc->debug.disable_dpp_power_gate)
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN1_PG_CONFIG) == 0)
 		return;
 
-	switch (dpp_inst) {
+	switch (dpp->inst) {
 	case 0: /* DPP0 */
 		REG_UPDATE(DOMAIN1_PG_CONFIG,
 				DOMAIN1_POWER_GATE, power_gate);
@@ -998,18 +1000,24 @@ void dcn10_dpp_pg_control(
  * @hws: dce_hwseq reference.
  * @hubp_inst: DPP instance reference.
  * @power_on: true if we want to enable power gate, false otherwise.
+ * @disable_power_gate: true if HUBP power gating is disabled by debug policy.
+ * @ignore_pg: unused on DCN10.
  *
  * Enable or disable power gate in the specific HUBP instance.
  */
 void dcn10_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on)
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? PGFSM_POWER_ON : PGFSM_POWER_OFF;
 
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+	(void)ignore_pg;
+
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
 		return;
@@ -1055,8 +1063,11 @@ void dcn10_hubp_pg_control(
 
 static void power_on_plane_resources(
 	struct dce_hwseq *hws,
+	struct dpp *dpp,
 	int plane_id)
 {
+	struct dc *dc = hws->ctx->dc;
+
 	DC_LOGGER_INIT(hws->ctx);
 
 	if (hws->funcs.dpp_root_clock_control &&
@@ -1068,10 +1079,12 @@ static void power_on_plane_resources(
 				IP_REQUEST_EN, 1);
 
 		if (hws->funcs.dpp_pg_control)
-			hws->funcs.dpp_pg_control(hws, plane_id, true);
+			hws->funcs.dpp_pg_control(hws, dpp, true,
+					dc->debug.disable_dpp_power_gate);
 
 		if (hws->funcs.hubp_pg_control)
-			hws->funcs.hubp_pg_control(hws, plane_id, true);
+			hws->funcs.hubp_pg_control(hws, plane_id, true,
+					dc->debug.disable_hubp_power_gate, dc->debug.ignore_pg);
 
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
@@ -1093,7 +1106,8 @@ static void undo_DEGVIDCN10_253_wa(struct dc *dc)
 	REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 1);
 
-	hws->funcs.hubp_pg_control(hws, 0, false);
+	hws->funcs.hubp_pg_control(hws, 0, false, dc->debug.disable_hubp_power_gate,
+			dc->debug.ignore_pg);
 	REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 0);
 
@@ -1122,7 +1136,8 @@ static void apply_DEGVIDCN10_253_wa(struct dc *dc)
 	REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 1);
 
-	hws->funcs.hubp_pg_control(hws, 0, true);
+	hws->funcs.hubp_pg_control(hws, 0, true, dc->debug.disable_hubp_power_gate,
+			dc->debug.ignore_pg);
 	REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 0);
 
@@ -1546,10 +1561,12 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 				IP_REQUEST_EN, 1);
 
 		if (hws->funcs.dpp_pg_control)
-			hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+			hws->funcs.dpp_pg_control(hws, dpp, false,
+					dc->debug.disable_dpp_power_gate);
 
 		if (hws->funcs.hubp_pg_control)
-			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+			hws->funcs.hubp_pg_control(hws, hubp->inst, false,
+					dc->debug.disable_hubp_power_gate, dc->debug.ignore_pg);
 
 		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
@@ -2806,6 +2823,7 @@ static void dcn10_enable_plane(
 	undo_DEGVIDCN10_253_wa(dc);
 
 	power_on_plane_resources(dc->hwseq,
+		pipe_ctx->plane_res.dpp,
 		pipe_ctx->plane_res.hubp->inst);
 
 	/* enable DCFCLK current DCHUB */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 383998531503..c62a32115e11 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -90,11 +90,14 @@ void dcn10_post_unlock_program_front_end(
 void dcn10_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on);
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg);
 void dcn10_dpp_pg_control(
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on);
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate);
 void dcn10_enable_power_gating_plane(
 	struct dce_hwseq *hws,
 	bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 696c0d5b8132..356ca90bf9bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -556,18 +556,19 @@ void dcn20_dsc_pg_control(
 
 void dcn20_dpp_pg_control(
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on)
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
-	if (hws->ctx->dc->debug.disable_dpp_power_gate)
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN1_PG_CONFIG) == 0)
 		return;
 
-	switch (dpp_inst) {
+	switch (dpp->inst) {
 	case 0: /* DPP0 */
 		REG_UPDATE(DOMAIN1_PG_CONFIG,
 				DOMAIN1_POWER_GATE, power_gate);
@@ -622,11 +623,8 @@ void dcn20_dpp_pg_control(
 		 */
 
 		/* Force disable cursor on plane powerdown on DPP 5 using dpp_force_disable_cursor */
-		if (!power_on) {
-			struct dpp *dpp5 = hws->ctx->dc->res_pool->dpps[dpp_inst];
-			if (dpp5 && dpp5->funcs->dpp_force_disable_cursor)
-				dpp5->funcs->dpp_force_disable_cursor(dpp5);
-		}
+		if (!power_on && dpp->funcs->dpp_force_disable_cursor)
+			dpp->funcs->dpp_force_disable_cursor(dpp);
 
 		break;
 	default:
@@ -639,12 +637,16 @@ void dcn20_dpp_pg_control(
 void dcn20_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on)
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+	(void)ignore_pg;
+
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
 		return;
@@ -1321,10 +1323,13 @@ static void dcn20_power_on_plane_resources(
 					IP_REQUEST_EN, 1);
 
 		if (hws->funcs.dpp_pg_control)
-			hws->funcs.dpp_pg_control(hws, pipe_ctx->plane_res.dpp->inst, true);
+			hws->funcs.dpp_pg_control(hws, pipe_ctx->plane_res.dpp, true,
+					hws->ctx->dc->debug.disable_dpp_power_gate);
 
 		if (hws->funcs.hubp_pg_control)
-			hws->funcs.hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true);
+			hws->funcs.hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true,
+					hws->ctx->dc->debug.disable_hubp_power_gate,
+					hws->ctx->dc->debug.ignore_pg);
 
 		if (org_ip_request_cntl == 0)
 			REG_SET(DC_IP_REQUEST_CNTL, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 9a5addaa9a03..e2f65c3748de 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -107,12 +107,15 @@ void dcn20_enable_power_gating_plane(
 	bool enable);
 void dcn20_dpp_pg_control(
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on);
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate);
 void dcn20_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on);
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg);
 void dcn20_program_triple_buffer(
 	struct hubp *hubp,
 	bool enable_triple_buffer);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c
index 0a6d58dd8f6d..ba4b1492825f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c
@@ -29,6 +29,7 @@
 
 #include "reg_helper.h"
 #include "dc.h"
+#include "core_types.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -42,17 +43,18 @@
 	hws->shifts->field_name, hws->masks->field_name
 
 
-void dcn302_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on)
+void dcn302_dpp_pg_control(struct dce_hwseq *hws, struct dpp *dpp, bool power_on,
+		bool disable_power_gate)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
-	if (hws->ctx->dc->debug.disable_dpp_power_gate)
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN1_PG_CONFIG) == 0)
 		return;
 
-	switch (dpp_inst) {
+	switch (dpp->inst) {
 	case 0: /* DPP0 */
 		REG_UPDATE(DOMAIN1_PG_CONFIG,
 				DOMAIN1_POWER_GATE, power_gate);
@@ -99,12 +101,15 @@ void dcn302_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool po
 	}
 }
 
-void dcn302_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
+void dcn302_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+	(void)ignore_pg;
+
+	if (disable_power_gate)
 		return;
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h
index 1e5126a0e695..2c4268970a2d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h
@@ -28,8 +28,10 @@
 
 #include "hw_sequencer_private.h"
 
-void dcn302_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
-void dcn302_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
+void dcn302_dpp_pg_control(struct dce_hwseq *hws, struct dpp *dpp, bool power_on,
+		bool disable_power_gate);
+void dcn302_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg);
 void dcn302_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on);
 
 #endif /* __DC_HWSS_DCN302_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
index 6e1877a8682d..ecc70952aabb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
@@ -43,19 +43,24 @@
 	hws->shifts->field_name, hws->masks->field_name
 
 
-void dcn303_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on)
+void dcn303_dpp_pg_control(struct dce_hwseq *hws, struct dpp *dpp, bool power_on,
+		bool disable_power_gate)
 {
-	(void)dpp_inst;
+	(void)dpp;
 	(void)hws;
 	(void)power_on;
+	(void)disable_power_gate;
 	/*DCN303 removes PG registers*/
 }
 
-void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
+void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg)
 {
 	(void)hubp_inst;
 	(void)hws;
 	(void)power_on;
+	(void)disable_power_gate;
+	(void)ignore_pg;
 	/*DCN303 removes PG registers*/
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
index 7fdfc4175f80..494ad66f68d6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
@@ -29,8 +29,10 @@
 
 #include "hw_sequencer_private.h"
 
-void dcn303_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
-void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
+void dcn303_dpp_pg_control(struct dce_hwseq *hws, struct dpp *dpp, bool power_on,
+		bool disable_power_gate);
+void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg);
 void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on);
 void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b6f3c0480ab6..7acf6af7e472 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -459,12 +459,16 @@ void dcn31_z10_restore(const struct dc *dc)
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
+void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+
+	(void)ignore_pg;
+
+	if (disable_power_gate)
 		return;
 
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
index 0d09aa8cfb65..5aebb31fe2ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
@@ -46,7 +46,8 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn31_z10_restore(const struct dc *dc);
 void dcn31_z10_save_init(struct dc *dc);
 
-void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
+void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg);
 int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config);
 void dcn31_reset_hw_ctx_wrap(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index de7dde2b036b..8af325a21267 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -550,28 +550,29 @@ void dcn314_disable_link_output(struct dc_link *link,
  * dcn314_dpp_pg_control - DPP power gate control.
  *
  * @hws: dce_hwseq reference.
- * @dpp_inst: DPP instance reference.
+ * @dpp: DPP instance reference.
  * @power_on: true if we want to enable power gate, false otherwise.
+ * @disable_power_gate: true if DPP power gating is disabled by debug policy.
  *
  * Enable or disable power gate in the specific DPP instance.
  * If power gating is disabled, will force disable cursor in the DPP instance.
  */
 void dcn314_dpp_pg_control(
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on)
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
 
-	if (hws->ctx->dc->debug.disable_dpp_power_gate) {
+	if (disable_power_gate) {
 		/* Workaround for DCN314 with disabled power gating */
 		if (!power_on) {
 
 			/* Force disable cursor if power gating is disabled */
-			struct dpp *dpp = hws->ctx->dc->res_pool->dpps[dpp_inst];
-			if (dpp && dpp->funcs->dpp_force_disable_cursor)
+			if (dpp->funcs->dpp_force_disable_cursor)
 				dpp->funcs->dpp_force_disable_cursor(dpp);
 		}
 		return;
@@ -579,7 +580,7 @@ void dcn314_dpp_pg_control(
 	if (REG(DOMAIN1_PG_CONFIG) == 0)
 		return;
 
-	switch (dpp_inst) {
+	switch (dpp->inst) {
 	case 0: /* DPP0 */
 		REG_UPDATE(DOMAIN1_PG_CONFIG,
 				DOMAIN1_POWER_GATE, power_gate);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index e33237fb74be..a631aa7c56d5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -49,6 +49,7 @@ bool dcn314_is_dpp_root_clock_control_supported(bool root_clock_optimization_dpp
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
-void dcn314_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
+void dcn314_dpp_pg_control(struct dce_hwseq *hws, struct dpp *dpp, bool power_on,
+		bool disable_power_gate);
 
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 9135b01fe388..b78041ba94e9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -164,15 +164,16 @@ void dcn32_enable_power_gating_plane(
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
-void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
+void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+	if (disable_power_gate)
 		return;
 
-	if (hws->ctx->dc->debug.ignore_pg)
+	if (ignore_pg)
 		return;
 
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 734727015b3f..3db34bff3847 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -39,7 +39,8 @@ void dcn32_enable_power_gating_plane(
 	struct dce_hwseq *hws,
 	bool enable);
 
-void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
+void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on,
+		bool disable_power_gate, bool ignore_pg);
 
 bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index bac9c5e18e6a..c39189deb244 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3191,10 +3191,11 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	}
 
 	if (hws->funcs.dpp_pg_control)
-		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+		hws->funcs.dpp_pg_control(hws, dpp, false, dc->debug.disable_dpp_power_gate);
 
 	if (hws->funcs.hubp_pg_control)
-		hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+		hws->funcs.hubp_pg_control(hws, hubp->inst, false,
+				dc->debug.disable_hubp_power_gate, dc->debug.ignore_pg);
 
 	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
@@ -3261,26 +3262,41 @@ void dcn401_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_id
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe_idx);
 }
 
+bool dcn401_pg_needs_ip_request(const struct dc *dc)
+{
+	const struct dce_hwseq *hws = dc->hwseq;
+
+	/* The status step and the pair need both hooks. */
+	ASSERT(!hws->funcs.dc_ip_request_cntl == !hws->funcs.dc_ip_request_status);
+	if (!hws->funcs.dc_ip_request_cntl || !hws->funcs.dc_ip_request_status)
+		return false;
+
+	/* dcn32_hubp_pg_control, bound on DCN401, also honors ignore_pg. */
+	return (hws->funcs.dpp_pg_control && !dc->debug.disable_dpp_power_gate) ||
+		(hws->funcs.hubp_pg_control && !dc->debug.disable_hubp_power_gate &&
+		 !dc->debug.ignore_pg);
+}
+
 void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp,
 		struct block_sequence_state *seq_state)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	uint32_t org_ip_request_cntl = 0;
+	bool ip_request = false;
 
-	/* Check and set DC_IP_REQUEST_CNTL if needed */
-	if (REG(DC_IP_REQUEST_CNTL)) {
-		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-		if (org_ip_request_cntl == 0)
-			hwss_add_dc_ip_request_cntl(seq_state, dc, true);
-	}
+	if (dcn401_pg_needs_ip_request(dc))
+		ip_request = hwss_add_dc_ip_request_status(seq_state, hws);
+
+	if (ip_request)
+		hwss_add_dc_ip_request_cntl(seq_state, dc, true);
 
 	/* DPP power gating control */
-	hwss_add_dpp_pg_control(seq_state, hws, dpp->inst, false);
+	hwss_add_dpp_pg_control(seq_state, hws, dpp, false, dc->debug.disable_dpp_power_gate);
 
 	/* HUBP power gating control */
-	hwss_add_hubp_pg_control(seq_state, hws, hubp->inst, false);
+	hwss_add_hubp_pg_control(seq_state, hws, hubp->inst, false,
+			dc->debug.disable_hubp_power_gate, dc->debug.ignore_pg);
 
 	/* HUBP reset */
 	hwss_add_hubp_reset(seq_state, hubp);
@@ -3288,8 +3304,7 @@ void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
 	/* DPP reset */
 	hwss_add_dpp_reset(seq_state, dpp);
 
-	/* Restore DC_IP_REQUEST_CNTL if it was originally 0 */
-	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL))
+	if (ip_request)
 		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
 
 	DC_LOG_DEBUG("Power gated front end %d\n", hubp->inst);
@@ -3672,12 +3687,39 @@ void dcn401_post_unlock_reset_opp_sequence(
 	}
 }
 
+/*
+ * Called in pairs after dcn401_dc_ip_request_status(). Writes nothing when
+ * IP_REQUEST_EN was already 1; the disable call clears that status.
+ */
 void dcn401_dc_ip_request_cntl(struct dce_hwseq *hws, bool enable)
 {
+	bool already_enabled;
+
 	if (!hws || !hws->ctx || !hws->regs || !hws->shifts || !hws->masks)
 		return;
+
+	already_enabled = hws->ip_request_already_enabled;
+
+	if (!enable)
+		hws->ip_request_already_enabled = false;
+
+	if (already_enabled || !REG(DC_IP_REQUEST_CNTL))
+		return;
+
+	REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, enable ? 1 : 0);
+}
+
+void dcn401_dc_ip_request_status(struct dce_hwseq *hws)
+{
+	uint32_t ip_request_en = 0;
+
+	if (!hws || !hws->ctx || !hws->regs || !hws->shifts || !hws->masks)
+		return;
+
 	if (REG(DC_IP_REQUEST_CNTL))
-		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, enable ? 1 : 0);
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &ip_request_en);
+
+	hws->ip_request_already_enabled = ip_request_en != 0;
 }
 
 void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
@@ -3686,32 +3728,32 @@ void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	(void)context;
 	struct dce_hwseq *hws = dc->hwseq;
-	uint32_t org_ip_request_cntl = 0;
+	bool ip_request = false;
 
 	if (!pipe_ctx->plane_res.dpp || !pipe_ctx->plane_res.hubp || !pipe_ctx->stream_res.opp)
 		return;
 
-	if (REG(DC_IP_REQUEST_CNTL))
-		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-
 	/* Step 1: DPP root clock control - enable clock */
 	if (hws->funcs.dpp_root_clock_control)
 		hwss_add_dpp_root_clock_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
 
 	/* Step 2: Enable DC IP request (if needed) */
-	if (hws->funcs.dc_ip_request_cntl)
+	if (dcn401_pg_needs_ip_request(dc))
+		ip_request = hwss_add_dc_ip_request_status(seq_state, hws);
+
+	if (ip_request)
 		hwss_add_dc_ip_request_cntl(seq_state, dc, true);
 
 	/* Step 3: DPP power gating control - power on */
-	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.dpp_pg_control)
-		hwss_add_dpp_pg_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
+	hwss_add_dpp_pg_control(seq_state, hws, pipe_ctx->plane_res.dpp, true,
+			dc->debug.disable_dpp_power_gate);
 
 	/* Step 4: HUBP power gating control - power on */
-	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.hubp_pg_control)
-		hwss_add_hubp_pg_control(seq_state, hws, pipe_ctx->plane_res.hubp->inst, true);
+	hwss_add_hubp_pg_control(seq_state, hws, pipe_ctx->plane_res.hubp->inst, true,
+			dc->debug.disable_hubp_power_gate, dc->debug.ignore_pg);
 
-	/* Step 5: Disable DC IP request (restore state) */
-	if (org_ip_request_cntl == 0 && hws->funcs.dc_ip_request_cntl)
+	/* Step 5: Disable DC IP request */
+	if (ip_request)
 		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
 
 	/* Step 6: HUBP clock control - enable DCFCLK */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index fef0dd59a81f..c95d929b453c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -191,6 +191,8 @@ void dcn401_post_unlock_reset_opp_sequence(
 		struct block_sequence_state *seq_state);
 
 void dcn401_dc_ip_request_cntl(struct dce_hwseq *hws, bool enable);
+void dcn401_dc_ip_request_status(struct dce_hwseq *hws);
+bool dcn401_pg_needs_ip_request(const struct dc *dc);
 
 void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
 				 struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1e79b4945801..09737dddce3e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -176,6 +176,8 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
 	.program_pipe_sequence = dcn401_program_pipe_sequence,
 	.dc_ip_request_cntl = dcn401_dc_ip_request_cntl,
+	.dc_ip_request_status = dcn401_dc_ip_request_status,
+	.pg_needs_ip_request = dcn401_pg_needs_ip_request,
 	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
 	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c4f3ec532572..bfe9afb434af 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1005,14 +1005,17 @@ struct disable_phantom_crtc_params {
 
 struct dpp_pg_control_params {
 	struct dce_hwseq *hws;
-	unsigned int dpp_inst;
+	struct dpp *dpp;
 	bool power_on;
+	bool disable_power_gate;
 };
 
 struct hubp_pg_control_params {
 	struct dce_hwseq *hws;
 	unsigned int hubp_inst;
 	bool power_on;
+	bool disable_power_gate;
+	bool ignore_pg;
 };
 
 struct hubp_reset_params {
@@ -1030,6 +1033,10 @@ struct dpp_root_clock_control_params {
 	bool root_clock_optimization_dpp;
 };
 
+struct dc_ip_request_status_params {
+	struct dce_hwseq *hws;
+};
+
 struct dc_ip_request_cntl_params {
 	struct dce_hwseq *hws;
 	bool enable;
@@ -1461,6 +1468,7 @@ union block_sequence_params {
 	struct hubp_reset_params hubp_reset_params;
 	struct dpp_reset_params dpp_reset_params;
 	struct dpp_root_clock_control_params dpp_root_clock_control_params;
+	struct dc_ip_request_status_params dc_ip_request_status_params;
 	struct dc_ip_request_cntl_params dc_ip_request_cntl_params;
 	struct dsc_pg_status_params dsc_pg_status_params;
 	struct dsc_wait_disconnect_pending_clear_params dsc_wait_disconnect_pending_clear_params;
@@ -1699,6 +1707,7 @@ enum block_sequence_func {
 	HUBP_RESET,
 	DPP_RESET,
 	DPP_ROOT_CLOCK_CONTROL,
+	DC_IP_REQUEST_STATUS,
 	DC_IP_REQUEST_CNTL,
 	DCCG_UPDATE_DPP_DTO,
 	HUBP_VTG_SEL,
@@ -2547,6 +2556,8 @@ void hwss_dpp_reset(union block_sequence_params *params);
 
 void hwss_dpp_root_clock_control(union block_sequence_params *params);
 
+void hwss_dc_ip_request_status(union block_sequence_params *params);
+
 void hwss_dc_ip_request_cntl(union block_sequence_params *params);
 
 void hwss_dccg_update_dpp_dto(union block_sequence_params *params);
@@ -2786,6 +2797,9 @@ void hwss_add_dpp_program_cm_hist(struct block_sequence_state *seq_state,
 		struct cm_hist_control cm_hist_control,
 		enum dc_color_space color_space);
 
+bool hwss_add_dc_ip_request_status(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws);
+
 void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		bool enable);
@@ -2938,13 +2952,16 @@ void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
 
 void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
-		unsigned int dpp_inst,
-		bool power_on);
+		struct dpp *dpp,
+		bool power_on,
+		bool disable_power_gate);
 
 void hwss_add_hubp_pg_control(struct block_sequence_state *seq_state,
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
-		bool power_on);
+		bool power_on,
+		bool disable_power_gate,
+		bool ignore_pg);
 
 void hwss_add_hubp_set_blank(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 91a84fb50b59..e4001656a330 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -150,11 +150,14 @@ struct hwseq_private_funcs {
 			unsigned int phy_inst,
 			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
-			unsigned int dpp_inst,
-			bool power_on);
+			struct dpp *dpp,
+			bool power_on,
+			bool disable_power_gate);
 	void (*hubp_pg_control)(struct dce_hwseq *hws,
 			unsigned int hubp_inst,
-			bool power_on);
+			bool power_on,
+			bool disable_power_gate,
+			bool ignore_pg);
 	void (*dsc_pg_control)(struct dce_hwseq *hws,
 			unsigned int dsc_inst,
 			bool power_on);
@@ -237,6 +240,8 @@ struct hwseq_private_funcs {
 	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
 	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*dc_ip_request_cntl)(struct dce_hwseq *hws, bool enable);
+	void (*dc_ip_request_status)(struct dce_hwseq *hws);
+	bool (*pg_needs_ip_request)(const struct dc *dc);
 	void (*program_cm_hist)(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		const struct dc_plane_state *plane_state);
@@ -254,6 +259,9 @@ struct dce_hwseq {
 	struct hwseq_wa_state wa_state;
 	struct hwseq_private_funcs funcs;
 
+	/* Set by dc_ip_request_status(), cleared by the closing dc_ip_request_cntl(). */
+	bool ip_request_already_enabled;
+
 	PHYSICAL_ADDRESS_LOC fb_base;
 	PHYSICAL_ADDRESS_LOC fb_top;
 	PHYSICAL_ADDRESS_LOC fb_offset;
-- 
2.43.0

