Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8425606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rsksKy+M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7F610F8CC;
	Wed, 11 Nov 2026 01:42:29 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3A710F8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIm/MeJcOz1j7GgiRtmLEQW+PApf237xiGvlO/dPAIpvfEOCy3Ccdgzc2klyxxYOKiqv8xHYa59U9hf7nNuzdz8iywf+29Z8HGh4/72aP2Cvz151aL/UZ6Dh7yTjKjEsQiFAWvRWpYV/gM6C91p7qOWMTh1iofb2zbnOam24mNqDEkDJEnG1Lz9HokOxkmfyRTRBSwEcRhq6co2JVjjbLTS8oD2IEckGfDEfrdnvNM65jm0Cd+ResPO3b3W18LXVBLy1RO8pTxgxmrtJsHKScA9elnzG5yb4pFYe+Kd2sYUJ9FF5+e/vl+2IB/Hc6lAKz6mWK8l5kOf3k9I7KWTf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrMgixocFwjp9Oxt0BMAXzRdz0XZBh2epRFbGaNkoYA=;
 b=UNvf5vPqF9qQLPDa9syiNTXpBHD9DM7Tcr4uQnEJ1z+OoSoMTOs89Lxqn+9Vf/btNLlK5qwC4yjH5XQ9Qzwe1FJ+R9wn5z+cTqv4y7zwxw9ao6+1nBwhLP5Nz+oN6A95qwtotpxI1i8QR3R5QFcblxPUiMDVlP7bp54TLJpcDxSH1cifQo3G+2oQ/fw9/tKNH6S5OEbK61HLP/8WC76NFo6LPzEfA0ySpXW4cdQZcUvWstGWpBGkdP1xrjq8hPvBWJvD8YJw20wFY3Zr3EHql9sAtS/lGpgKVehQ5EseBlJxKd+E2BEPhLuYQBXmaRXalSk35LmeqoFWF3kGrDWVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrMgixocFwjp9Oxt0BMAXzRdz0XZBh2epRFbGaNkoYA=;
 b=rsksKy+MiA/eCIUQUICnZ1y/KbrZlnlK7qcB45FQCD80s3oP9TT48zJDFyZxOBMOwQvOblGdl3H296oY9M2agtfxD2m2Uqn+qkZE1XpcXxi/pjvnrWNhrE192FxLdZuN+UUlTaMiigPV4f5bPeX90pY/Gurf1xOxKz1Q9R0VdEg=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:13 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::3f) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:09 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:06 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 28/74] drm/amd/display: Build the dcn401 seamless update in DC2
Date: Wed, 11 Nov 2026 09:28:34 +0800
Message-ID: <20261111014100.3596072-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb6f232-9fff-4a72-a9cc-08df3f95020b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|5023799004|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009221727099003|261009220027099003|261009221227099003|261009223027099003|261009223327099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: MT9K1juzmhQ2wRP6DjPMkL6GBc7uV/r813p1XAAICZEjyEY8ZQmduyFVOPxVqCjbLu1D2q531DQ3yhL4vb2e6CwUBFLWjmuetTLmQPv9TKPok/JH0T4yNvKXIlJfcikstyYWT5IzexWkuGS4qXIJdSDIv0HvHl+6aDiszHJi1igvI/AM3o3hxuBnGTfwIYLZDKgmFTialNqrDEXiswTwALqgHol0xN+dLF9f6M3RLa9zpgJ6I5Nw1eIIC+dovabpZUeYq3tLM9tvPTBRwDNniVxxUIcjqDE1fwL+ysq8dIqy99UJuGMi80poW4YpdNAZWmNSADiOIyonrkXdCSIqwoWo8AzF5BtDymwc+jG+TZ3XF5/cdJWGFKtmCMORG9MPE4Gc+DGAyx5uqRSmAp3jVegA4puwVENACO/Hic5r/oCMm3tUDLq/grY08WwcPaBpfO+DfRI/K/+qMYPYCx7Bu1CzIte/EMavAdgAZ24IpYbssMyLpqU2lVN4AavJkv4v+H6lt/0HSTyPEmPlpMXRjfs+WlKmOBxoFQBDQtf0sQbUZ5NFHfMMudU5ll3dw9zXkYQoYRLCc7y1BXTKr8Fp0xGkfedmYqAQ+NUqme55D5WOfmtRBBCVNyndKhEDm7l7xEeJDHWnl2xnX0HGgf3wXZx8Me3uLcrJLwXx0TOKQB0ztGh3iudJckY1h+IHg+V+c6JqPuDALuY24sadEvJrcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009223327099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPLUwIO/5Gk5Bp5LwJsM098OYb/PSAUXcHjjuJb4Bra8FoUC9j+pKP6cu4V1AHaxer2+QrO0BuYtAU5y9i1u5bvJ0UYtT5e0oFxeRITHwo7tWRfaDAUgVPJaKEb8eFWpIrF1RtG9ER0/fx8MzHuELkhYC6+EiTiTlYKwewHjWhM+Tfhpk0U1QWKT8LioAFllb6bvuRwjuHmvcM6rsf3AcbI1ulqFJ3J3xNSbN35/LyQpeJ0jDSwIKd4+IxNkuEn5KuQofJyrZk9T6WuuPF7qOSu/wreDqo/bpIEu5uGjh8tPN/qW5BFufqrMmHxPwrbnqbnSDWfD2fIBPpUuwbWXalbW/aKg1E7WoIB9Cku2tZnh5RoR2UuRmxREa4W12UCHYmEeBCQVQ+G00iHCgH+nBH2oNFQFecL//VcTy5KHnVeV0k0iH3Rqh71qQR2joU12
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:12.5614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb6f232-9fff-4a72-a9cc-08df3f95020b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
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

From: Tony Cheng <tony.cheng@amd.com>

[Why]
With DC2 selected, a full update that adds a plane to a stream has no
DC2 builder. dc_update_planes_and_stream rejects the update, and the
stream stays without a plane. A tail must run on the vsync after the
head, and DC2 has no wait for that vsync.

[How]
DC2 now runs only the head of a commit and rejects a builder that
emits a tail. The update goes through the API shim. DC2 accepts only
a full update on a new context. Add the block calls the plane add
makes, and a dcn401 builder that emits them in one head. The stream
checks reject a virtual signal, so DC2 builds no update yet. The
builder does not call floating-point-only code, and it checks the OTG
master before use.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |    3 +-
 .../dc/bls_builder/bls_builder_internal.h     |    1 +
 .../bls_builder/bls_builder_private_types.h   |   52 +
 .../dc/bls_builder/dcn401_commit_builder.c    | 1242 ++++++++++++++++-
 .../dc/bls_builder/dcn401_init_builder.c      |    2 +
 .../display/dc/bls_executor/bls_executor.c    |  466 +++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   15 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  204 ++-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |   18 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    4 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   89 ++
 .../amd/display/dc/inc/dc_core_interface.h    |    7 +
 12 files changed, 2003 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 485e877df5d2..954adc590ed4 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -12,7 +12,7 @@
 #include "bls_builder/dmub_abi.h"
 #include "bls_builder/bls_builder_legacy_init.h"
 
-#define DC2_BLS_MAX_STEPS 64
+#define DC2_BLS_MAX_STEPS 128
 
 enum bls_builder_result {
 	BLS_BUILD_SUCCESS,
@@ -25,6 +25,7 @@ enum bls_builder_name {
 	DCN_DECL_INITIALIZATION,
 	DCN_DECL_INITIALIZATION_LEGACY,
 	DCN_DECL_NON_SEAMLESS_COMMIT,
+	DCN_DECL_SEAMLESS_UPDATE,
 	BLS_BUILDER_NAME_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
index a641941a2f2f..ebf315e31ad8 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
@@ -10,3 +10,4 @@
 const struct bls_builder *dcn401_bls_builder_create(
 		enum bls_builder_name name);
 const struct bls_builder *dcn401_non_seamless_commit_builder(void);
+const struct bls_builder *dcn401_seamless_update_builder(void);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index 025b2e3b62ad..2f3cb1457ebe 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -31,7 +31,55 @@ struct dcn401_commit_step_meta {
 		} hubbub_program_arbiter;
 		struct {
 			bool safe_to_lower;
+			/*
+			 * Set: program the current state's compbuf size, as
+			 * dcn401_program_outstanding_updates does. Clear:
+			 * program the new state's size.
+			 */
+			bool use_current_state_size;
 		} hubbub_program_compbuf_segments;
+		struct {
+			bool enable;
+		} hubbub_force_pstate_change_control;
+		struct {
+			bool enable;
+		} hubp_clk_cntl;
+		struct {
+			bool power_on;
+		} hubp_pg_control;
+		struct {
+			bool unblank;
+		} hubp_set_blank;
+		struct {
+			bool enable;
+		} dpp_dppclk_control;
+		struct {
+			bool unblank;
+		} opp_set_disp_pattern_generator;
+		struct {
+			/*
+			 * Set: program the pipe's hubp_regs.det_size, which
+			 * gives the HUBP its DET segments, as dcn401_program_pipe
+			 * does. Clear: program size 0, which releases the
+			 * HUBP's segments, as the DC1 plane disable does.
+			 */
+			bool allocate;
+		} hubp_program_det_segments;
+		struct {
+			/*
+			 * Set: program the MALL selection and cursor caching
+			 * that dcn401_program_mall_pipe_config_sequence computes
+			 * for the new state. Clear: program no MALL and no
+			 * cursor caching, as the DC1 plane disable does.
+			 */
+			bool from_new_state;
+		} hubp_update_mall_sel;
+		struct {
+			enum mpcc_gamut_remap_id block_id;
+		} mpc_set_gamut_remap_bypass;
+		struct {
+			enum MCM_LUT_ID id;
+		} mpc_program_lut_mode;
 		struct {
 			bool state;
 		} bios_set_scratch_critical_state;
@@ -63,6 +111,10 @@ struct dcn401_commit_step_meta {
 		bool stream_mode_unchanged;
 		/* The new state has a stream. */
 		bool new_state_has_stream;
+		/* dc->optimized_required is clear. */
+		bool optimized_not_required;
+		/* The plane has no address update, or skips the manual trigger. */
+		bool no_manual_trigger;
 	} skip_if;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index 5fe4a1ec7166..b6208a0ad164 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -5,12 +5,15 @@
 
 #include "dm_services.h"
 #include "core_types.h"
+#include "resource.h"
 #include "link_encoder.h"
 #include "stream_encoder.h"
 #include "clk_mgr.h"
 #include "dccg.h"
 #include "dc_bios_types.h"
 #include "dc_dmub_srv.h"
+#include "custom_float.h"
+#include "dcn32/dcn32_resource.h"
 #include "bls_builder/bls_builder_internal.h"
 #include "bls_builder/dcn401_init_builder.h"
 #include "bls_builder/bls_builder_private_types.h"
@@ -23,18 +26,35 @@
  * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
  * The new state has no stream, or one stream with no plane; the current
  * state has no stream, or one stream with one plane. A plane is added
- * later by commit_planes, not by this commit.
+ * later by DCN_DECL_SEAMLESS_UPDATE, not by this commit.
  *
  * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
- * calls in the same order, including the calls DC1 repeats. head_sequence
- * holds everything through the ODM double-buffer and blank waits.
- * tail_sequence is the deferred bandwidth lower, and it runs only after
- * that head has finished.
+ * calls in the same order, including the calls DC1 repeats. Everything is
+ * in head_sequence: the ODM double-buffer and blank waits come before the
+ * bandwidth lower, so no tail is needed.
+ *
+ * DCN_DECL_SEAMLESS_UPDATE adds one plane to that stream. The sequence
+ * follows the full update in commit_planes_for_stream on dcn401, all in
+ * head_sequence: the outstanding updates, prepare_bandwidth and the
+ * pending-update waits, then the locked front-end programming and
+ * post_unlock_program_front_end. The bandwidth lower stays with
+ * dc_post_update_surfaces_to_stream.
+ *
+ * Neither builder emits a tail_sequence. A tail runs only after a vsync,
+ * and Core has no wait-for-vsync imperative yet, so Core rejects a tail.
  */
 
 #define DCN401_DPG_POLL_INTERVAL_US 100
 #define DCN401_DPG_POLL_TIMEOUT_US 100000
 #define DCN401_STATIC_SCREEN_NUM_FRAMES 2
+#define DCN401_PENDING_UPDATE_POLL_INTERVAL_US 1
+#define DCN401_PENDING_UPDATE_TIMEOUT_US 100000
+#define DCN401_FLIP_PENDING_POLL_INTERVAL_US 100
+#define DCN401_PLANE_ENABLE_DELAY_US 500
+/* 1.0 in the HDR multiplier and MPCC gain format. */
+#define DCN401_UNITY_GAIN 0x1f000
+#define DCN401_MALL_SEL_SS 2
+#define DCN401_CACHE_CURSOR_BYTES 16384
 
 /*
  * Each helper takes the same arguments. CHECK_CONDITION logs the reason
@@ -308,6 +328,16 @@ static const struct pipe_ctx *dcn401_checked_otg_master(
 			new_state), &not_one_pipe);
 }
 
+/* The OTG master of one state, or NULL when that state is not one pipe. */
+static const struct pipe_ctx *dcn401_otg_of(const struct dc_state *state)
+{
+	bool not_one_pipe = false;
+
+	if (!state)
+		return NULL;
+	return dcn401_state_otg_master(state, &not_one_pipe);
+}
+
 static bool check_one_otg_pipe(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -457,7 +487,8 @@ static bool check_link_enc_assignment(const struct dc *dc,
 			pipe->stream->link->link_enc;
 }
 
-static enum bls_builder_result dcn401_check_commit_state_support(
+/* What both builders need of a state's stream, apart from its planes. */
+static enum bls_builder_result dcn401_check_stream_support(
 		const struct dc *dc, const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
@@ -480,15 +511,11 @@ static enum bls_builder_result dcn401_check_commit_state_support(
 	CHECK_CONDITION(no_boot_dpms_writeback,
 			"seamless boot, dpms, or writeback is set");
 	CHECK_CONDITION(abm, "ABM level is set");
-	CHECK_CONDITION(plane_count, "plane count does not match the state");
 	CHECK_CONDITION(one_otg_pipe, "stream is not on one pipe");
 	CHECK_RESOURCE(otg_master_present, "stream has no otg master");
 	CHECK_CONDITION(odm_combine, "odm is set");
 	CHECK_CONDITION(mpc_blend, "top or bottom pipe is set");
-	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
 	CHECK_RESOURCE(otg_master_blocks, "otg master is missing a block");
-	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
-	CHECK_CONDITION(mpcc_alone, "mpcc is not alone in the opp tree");
 	CHECK_CONDITION(pipe_audio, "audio is set");
 	CHECK_CONDITION(pipe_dsc, "dsc is set");
 	CHECK_CONDITION(pipe_gsl, "gsl is set");
@@ -496,6 +523,25 @@ static enum bls_builder_result dcn401_check_commit_state_support(
 	return BLS_BUILD_SUCCESS;
 }
 
+static enum bls_builder_result dcn401_check_commit_state_support(
+		const struct dc *dc, const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	enum bls_builder_result result;
+
+	result = dcn401_check_stream_support(dc, current_state, new_state);
+	if (result != BLS_BUILD_SUCCESS ||
+			!dcn401_checked_state(current_state,
+			new_state)->stream_count)
+		return result;
+
+	CHECK_CONDITION(plane_count, "plane count does not match the state");
+	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
+	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
+	CHECK_CONDITION(mpcc_alone, "mpcc is not alone in the opp tree");
+	return BLS_BUILD_SUCCESS;
+}
+
 static bool check_stream_not_kept(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -546,6 +592,442 @@ static enum bls_builder_result dcn401_check_non_seamless_commit_support(
 	return BLS_BUILD_SUCCESS;
 }
 
+/* The seamless update keeps the one stream and only adds its plane. */
+static bool check_stream_kept(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	return current_state->stream_count == 1 &&
+			new_state->stream_count == 1 &&
+			current_state->streams[0] == new_state->streams[0];
+}
+
+static bool check_plane_added(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	return !current_state->stream_status[0].plane_count &&
+			new_state->stream_status[0].plane_count == 1;
+}
+
+static bool check_same_otg_master_blocks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *current_pipe = dcn401_otg_of(current_state);
+	const struct pipe_ctx *new_pipe = dcn401_otg_of(new_state);
+
+	(void)dc;
+	if (!current_pipe || !new_pipe)
+		return false;
+	return current_pipe->stream_res.tg == new_pipe->stream_res.tg &&
+			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
+}
+
+static bool check_new_plane_blocks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	(void)dc;
+	(void)current_state;
+	return pipe && pipe->plane_state && pipe->plane_res.hubp &&
+			pipe->plane_res.dpp && pipe->plane_res.dpp->funcs;
+}
+
+static bool check_pool_funcs(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return dc->res_pool->funcs && dc->res_pool->hubbub->funcs;
+}
+
+/* DC1 uses the HUBP instance as the MPCC and DPP instance. */
+static bool check_plane_instances(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	int inst;
+
+	(void)dc;
+	(void)current_state;
+	if (!pipe || !pipe->plane_res.hubp || !pipe->plane_res.dpp)
+		return false;
+	inst = pipe->plane_res.hubp->inst;
+	return inst < MAX_MPCC && pipe->plane_res.mpcc_inst == inst &&
+			pipe->plane_res.dpp->inst == inst;
+}
+
+/* dcn401 programs DET by segments only. */
+static bool check_det_by_segments(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->res_pool->hubbub->funcs->program_det_size;
+}
+
+/* The update always emits the two triple-buffer calls DC1 makes with it. */
+static bool check_triple_buffer(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return dc->debug.enable_tri_buf;
+}
+
+/* With sanity_checks DC1 adds p-state verification the update lacks. */
+static bool check_no_sanity_checks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->debug.sanity_checks;
+}
+
+static bool check_no_pipe_wait(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && !pipe->wait_is_required;
+}
+
+/* dcn20_blank_pixel_data does nothing while a test pattern is on. */
+static bool check_no_test_pattern(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_stream_state *stream = new_state->streams[0];
+
+	(void)dc;
+	(void)current_state;
+	return !stream->link->test_pattern_enabled &&
+			stream->test_pattern.type == DP_TEST_PATTERN_VIDEO_MODE;
+}
+
+/* With force_dpg_enable DC1 unblanks to colour squares, not video. */
+static bool check_no_forced_dpg(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	(void)dc;
+	return true;
+}
+
+/* dcn20_blank_pixel_data sets the ABM pipe on unblank when there is one. */
+static bool check_no_abm_pipe(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && !pipe->stream_res.abm;
+}
+
+/* enable_plane programs the system aperture when VM is valid. */
+static bool check_no_vm_aperture(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->vm_pa_config.valid;
+}
+
+/* enable_plane sets the flip interrupt when the plane asks for one. */
+static bool check_no_flip_int(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_state &&
+			!pipe->plane_state->flip_int_enabled;
+}
+
+/* With an empty tree, DC1 removes no MPCC before the insert. */
+static bool check_opp_tree_empty(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	const struct output_pixel_processor *opp;
+	unsigned int i;
+
+	(void)dc;
+	(void)current_state;
+	if (!pipe)
+		return false;
+	opp = pipe->stream_res.opp;
+	if (!opp || opp->mpc_tree_params.opp_list)
+		return false;
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (opp->mpcc_disconnect_pending[i])
+			return false;
+	}
+	return true;
+}
+
+/* The update bypasses the plane gamut remap. */
+static bool check_no_plane_gamut_remap(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	(void)dc;
+	(void)current_state;
+	return pipe && pipe->plane_state &&
+			!pipe->plane_state->gamut_remap_matrix.enable_remap;
+}
+
+/* The update bypasses the stream gamut remap. */
+static bool check_no_stream_gamut_remap(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return !new_state->streams[0]->gamut_remap_matrix.enable_remap;
+}
+
+/* The update sets the default output CSC. */
+static bool check_no_output_csc(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return !new_state->streams[0]->csc_color_matrix.enable_adjustment;
+}
+
+/* The update programs the surface and its address without DCC. */
+static bool check_no_dcc(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_state && !pipe->plane_state->dcc.enable;
+}
+
+/* The update programs a single graphics address, not stereo or video. */
+static bool check_graphics_address(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_state &&
+			pipe->plane_state->address.type == PLN_ADDR_TYPE_GRAPHICS;
+}
+
+/* DC1 programs triple buffering and the flip only for a queued flip. */
+static bool check_no_immediate_flip(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_state &&
+			!pipe->plane_state->flip_immediate;
+}
+
+/*
+ * DC1 translates a distributed-points curve into a LUT while it programs
+ * the plane. The update programs only the predefined and bypass curves.
+ */
+static bool check_no_degamma_curve(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_state &&
+			pipe->plane_state->in_transfer_func.type !=
+			TF_TYPE_DISTRIBUTED_POINTS;
+}
+
+/* dcn32_set_input_transfer_func calls dpp_set_pregam_state if present. */
+static bool check_no_dpp_pregam(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+
+	return pipe && pipe->plane_res.dpp && pipe->plane_res.dpp->funcs &&
+			!pipe->plane_res.dpp->funcs->dpp_set_pregam_state;
+}
+
+/* dcn401_set_mcm_luts then programs every MCM LUT off. */
+static bool check_no_mcm_luts(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
+	const union dc_plane_cm_flags *flags;
+
+	(void)dc;
+	(void)current_state;
+	if (!pipe || !pipe->plane_state)
+		return false;
+	flags = &pipe->plane_state->cm.flags;
+	return !flags->bits.blend_enable && !flags->bits.shaper_enable &&
+			!flags->bits.lut3d_enable && !flags->bits.rmcm_enable;
+}
+
+static bool check_no_shaper_curve(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_transfer_func *shaper = new_state->streams[0]->func_shaper;
+
+	(void)dc;
+	(void)current_state;
+	return !shaper || shaper->type != TF_TYPE_DISTRIBUTED_POINTS;
+}
+
+static bool check_no_stream_3dlut(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_3dlut *lut3d = new_state->streams[0]->lut3d_func;
+
+	(void)dc;
+	(void)current_state;
+	return !lut3d || !lut3d->state.bits.initialized;
+}
+
+static bool check_no_regamma_curve(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return new_state->streams[0]->out_transfer_func.type !=
+			TF_TYPE_DISTRIBUTED_POINTS;
+}
+
+static bool check_no_cursor(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return !new_state->streams[0]->cursor_attributes.address.quad_part;
+}
+
+static bool check_no_dsc_change(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	return !new_state->streams[0]->update_flags.bits.dsc_changed;
+}
+
+/*
+ * The checks follow the update in the order it programs the pipe. Each one
+ * rejects a state for which DC1 would make a call the update does not emit.
+ */
+static enum bls_builder_result dcn401_check_seamless_update_support(
+		const struct dc *dc, const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	enum bls_builder_result result;
+
+	if (!dc || !current_state || !new_state)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	CHECK_RESOURCE(dc_resources, "dc resources are missing");
+	CHECK_CONDITION(fams2_debug, "FAMS2 debug is enabled");
+	CHECK_CONDITION(cursor_offload, "cursor offload is enabled");
+	CHECK_CONDITION(dc_mode_softmax, "dc mode softmax is enabled");
+	CHECK_CONDITION(visual_confirm, "visual confirm, dpg, hblank borrow, or frame sync is set");
+	CHECK_CONDITION(dsc_power_gate, "DSC power gate is enabled");
+
+	result = dcn401_check_stream_support(dc, current_state, NULL);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+	result = dcn401_check_stream_support(dc, NULL, new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	/* The transition: one stream, kept, gains one plane on its OTG. */
+	CHECK_CONDITION(stream_kept, "stream is not kept across the update");
+	CHECK_CONDITION(plane_added, "update does not add exactly one plane");
+	CHECK_CONDITION(same_otg_master_blocks, "otg or opp changes");
+	CHECK_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
+	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
+	CHECK_CONDITION(plane_instances, "mpcc or dpp is not the hubp instance");
+	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
+
+	/* Under the lock, before the pipe is programmed. */
+	CHECK_CONDITION(triple_buffer, "triple buffer is disabled");
+	CHECK_CONDITION(no_sanity_checks, "sanity checks are enabled");
+	CHECK_CONDITION(no_pipe_wait, "pipe wait is required");
+
+	/* Unblank. */
+	CHECK_CONDITION(no_test_pattern, "test pattern is set");
+	CHECK_CONDITION(no_forced_dpg, "dpg is forced");
+	CHECK_CONDITION(no_abm_pipe, "abm is set");
+
+	/* enable_plane. */
+	CHECK_CONDITION(no_vm_aperture, "vm system aperture is valid");
+	CHECK_CONDITION(no_flip_int, "flip interrupt is enabled");
+
+	/* update_dchubp_dpp. */
+	CHECK_CONDITION(opp_tree_empty, "opp tree is not empty");
+	CHECK_CONDITION(no_plane_gamut_remap, "plane gamut remap is set");
+	CHECK_CONDITION(no_stream_gamut_remap, "stream gamut remap is set");
+	CHECK_CONDITION(no_output_csc, "output csc is set");
+	CHECK_CONDITION(no_dcc, "dcc is enabled");
+	CHECK_CONDITION(graphics_address, "address is not graphics");
+	CHECK_CONDITION(no_immediate_flip, "flip is immediate");
+
+	/* Input, MCM and output transfer functions. */
+	CHECK_CONDITION(no_degamma_curve, "plane degamma is distributed points");
+	CHECK_CONDITION(no_dpp_pregam, "dpp has a pregam state");
+	CHECK_CONDITION(no_mcm_luts, "an mcm lut is enabled");
+	CHECK_CONDITION(no_shaper_curve, "shaper is distributed points");
+	CHECK_CONDITION(no_stream_3dlut, "stream 3dlut is set");
+	CHECK_CONDITION(no_regamma_curve, "regamma is distributed points");
+
+	/* Not programmed by this update. */
+	CHECK_CONDITION(no_cursor, "cursor is set");
+	CHECK_CONDITION(no_dsc_change, "dsc changes");
+	return BLS_BUILD_SUCCESS;
+}
+
 static struct pipe_ctx *get_otg_master_from_state_by_stream(
 		struct dc_state *state, const struct dc_stream_state *stream)
 {
@@ -681,7 +1163,7 @@ static const struct dcn401_commit_step
  * the head's double buffering. legacy_commit_state_hw sets up stereo for
  * a mode-changed stream, then dc_enable_stereo sets it up again for every
  * stream; dcn10_setup_stereo with no 3D format is the two STEREO calls.
- * The deferred tail starts only after these waits.
+ * The bandwidth lower starts only after these waits.
  */
 static const struct dcn401_commit_step
 		bls_head_per_stream_per_otg_master_pipe_new_front_end[] = {
@@ -710,7 +1192,7 @@ static const struct dcn401_commit_step
  * Net effect: release the forced p-state when no OTG master did, then
  * dcn401_optimize_bandwidth without FAMS2, SubVP or DC-mode softmax.
  */
-static const struct dcn401_commit_step bls_tail_per_state_new[] = {
+static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {
 	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
 	  .meta.skip_if.new_state_has_stream = true },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
@@ -728,21 +1210,187 @@ static const struct dcn401_commit_step bls_tail_per_state_new[] = {
  * state, and never one in both.
  */
 static_assert(ARRAY_SIZE(bls_head_per_state_new) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current) <=
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current) +
+		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
 		DC2_BLS_MAX_STEPS,
 		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
 static_assert(ARRAY_SIZE(bls_head_per_state_new) +
 		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_new) +
 		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_new_front_end) <=
+		bls_head_per_stream_per_otg_master_pipe_new_front_end) +
+		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
 		DC2_BLS_MAX_STEPS,
 		"dcn401 commit enable head exceeds DC2_BLS_MAX_STEPS");
-static_assert(ARRAY_SIZE(bls_tail_per_state_new) <= DC2_BLS_MAX_STEPS,
-		"dcn401 commit tail sequence exceeds DC2_BLS_MAX_STEPS");
+
+/*
+ * Net effect: hwss_process_outstanding_hw_updates on the current state,
+ * which commit_planes_for_stream runs while optimized_required is set.
+ * The OTG master has no plane yet, so no MPCC disconnect is pending.
+ */
+static const struct dcn401_commit_step
+		bls_update_head_per_stream_per_otg_master_pipe_preamble[] = {
+	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES,
+	  .meta.skip_if.optimized_not_required = true },
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR,
+	  .meta.skip_if.optimized_not_required = true },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE,
+	  .meta.skip_if.optimized_not_required = true },
+};
+
+/* Net effect: dcn401_program_outstanding_updates on the current state. */
+static const struct dcn401_commit_step bls_update_head_global_preamble[] = {
+	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true,
+	  .meta.hubbub_program_compbuf_segments.use_current_state_size = true,
+	  .meta.skip_if.optimized_not_required = true },
+};
+
+/*
+ * Net effect: hwss_wait_for_outstanding_hw_updates on the current state,
+ * which a full update runs before it takes the pipe lock.
+ */
+static const struct dcn401_commit_step
+		bls_update_head_per_stream_per_otg_master_pipe_current_pending[] = {
+	{ .func = TG_WAIT_FOR_ALL_PENDING_UPDATES },
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+};
+
+/*
+ * After the waits, the head adds the plane. Each table runs once per
+ * stream, on the OTG master of the new state, and is named for the DC1
+ * call it replaces in commit_planes_for_stream and dcn401_program_pipe.
+ *
+ * Pipe lock: the two triple-buffer offs, from commit_planes_for_stream and
+ * dcn401_program_front_end_for_ctx, then the forced p-state and delay for
+ * the first HUBP.
+ */
+static const struct dcn401_commit_step bls_update_head_new_lock[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
+	{ .func = HUBP_PROGRAM_TRIPLEBUFFER },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	  .meta.hubbub_force_pstate_change_control.enable = true },
+	{ .func = DC_UDELAY },
+};
+
+/* blank_pixel_data (unblank), dcn401_program_tg and update_odm. */
+static const struct dcn401_commit_step bls_update_head_new_stream[] = {
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR,
+	  .meta.opp_set_disp_pattern_generator.unblank = true },
+	{ .func = TG_PROGRAM_GLOBAL_SYNC },
+	{ .func = TG_WAIT_FOR_STATE },
+	{ .func = TG_SET_VTG_PARAMS },
+	{ .func = TG_SETUP_VERTICAL_INTERRUPT2 },
+	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+};
+
+/* enable_plane, then the watermark propagate and the DET segments. */
+static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
+	{ .func = HUBP_PG_CONTROL, .meta.hubp_pg_control.power_on = true },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
+	{ .func = HUBP_CLK_CNTL, .meta.hubp_clk_cntl.enable = true },
+	{ .func = HUBP_INIT },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES },
+	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
+	  .meta.hubp_program_det_segments.allocate = true },
+};
+
+/* update_dchubp_dpp, with the MPC insert from dcn401_update_mpcc. */
+static const struct dcn401_commit_step
+		bls_update_head_new_update_dchubp_dpp[] = {
+	{ .func = DPP_DPPCLK_CONTROL, .meta.dpp_dppclk_control.enable = true },
+	{ .func = DCCG_UPDATE_DPP_DTO },
+	{ .func = HUBP_VTG_SEL },
+	{ .func = HUBP_SETUP2 },
+	{ .func = HUBP_SET_UNBOUNDED_REQUESTING },
+	{ .func = HUBP_SETUP_INTERDEPENDENT2 },
+	{ .func = DPP_SETUP_DPP },
+	{ .func = DPP_SET_CURSOR_MATRIX },
+	{ .func = DPP_PROGRAM_BIAS_AND_SCALE },
+	/* insert_plane programs the blending; no update_blending follows. */
+	{ .func = MPC_INSERT_PLANE },
+	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
+	{ .func = DPP_SET_SCALER },
+	{ .func = HUBP_MEM_PROGRAM_VIEWPORT },
+	{ .func = HUBP_PROGRAM_MCACHE_ID },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id =
+			MPCC_MCM_FIRST_GAMUT_REMAP },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id =
+			MPCC_MCM_SECOND_GAMUT_REMAP },
+	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
+	  .meta.mpc_set_gamut_remap_bypass.block_id = MPCC_OGAM_GAMUT_REMAP },
+	{ .func = MPC_POWER_ON_MPC_MEM_PWR },
+	{ .func = MPC_SET_OCSC_DEFAULT },
+	{ .func = HUBP_PROGRAM_SURFACE_CONFIG },
+	{ .func = HUBP_UPDATE_PLANE_ADDR },
+	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true },
+};
+
+/*
+ * set_hdr_multiplier, the input and MCM transfer functions, the output
+ * transfer function and the OPP format.
+ */
+static const struct dcn401_commit_step
+		bls_update_head_new_transfer_funcs[] = {
+	{ .func = DPP_SET_HDR_MULTIPLIER },
+	{ .func = DPP_SET_PRE_DEGAM },
+	{ .func = DPP_PROGRAM_GAMCOR_LUT },
+	{ .func = MPC_SET_MOVABLE_CM_LOCATION },
+	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_1DLUT },
+	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_SHAPER },
+	{ .func = MPC_PROGRAM_LUT_MODE,
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_3DLUT },
+	{ .func = HUBP_PROGRAM_3DLUT_FL_CONFIG },
+	{ .func = HUBP_SET_3DLUT_FL },
+	{ .func = MPC_SET_OUTPUT_GAMMA },
+	{ .func = OPP_SET_DYN_EXPANSION },
+	{ .func = OPP_PROGRAM_FMT },
+};
+
+/*
+ * The pipe unlock, then dcn401_post_unlock_program_front_end: the
+ * flip-pending wait, the p-state release and the MALL selection. Last,
+ * the manual trigger.
+ */
+static const struct dcn401_commit_step bls_update_head_new_unlock[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+	{ .func = HUBP_WAIT_FLIP_PENDING },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+	{ .func = HUBP_UPDATE_MALL_SEL,
+	  .meta.hubp_update_mall_sel.from_new_state = true },
+	{ .func = OPTC_PROGRAM_MANUAL_TRIGGER,
+	  .meta.skip_if.no_manual_trigger = true },
+};
+
+/* The support check allows one stream, kept across the update. */
+static_assert(
+		ARRAY_SIZE(
+		bls_update_head_per_stream_per_otg_master_pipe_preamble) +
+		ARRAY_SIZE(bls_update_head_global_preamble) +
+		ARRAY_SIZE(bls_head_per_state_new) +
+		ARRAY_SIZE(
+		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
+		ARRAY_SIZE(bls_update_head_new_lock) +
+		ARRAY_SIZE(bls_update_head_new_stream) +
+		ARRAY_SIZE(bls_update_head_new_enable_plane) +
+		ARRAY_SIZE(bls_update_head_new_update_dchubp_dpp) +
+		ARRAY_SIZE(bls_update_head_new_transfer_funcs) +
+		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
+		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
 
 /* pipe is NULL only for the bandwidth and p-state steps. */
 struct dcn401_commit_step_args {
 	struct dc *dc;
+	struct dc_state *current_state;
 	struct dc_state *new_state;
 	struct pipe_ctx *pipe;
 };
@@ -787,15 +1435,19 @@ static uint32_t dcn401_early_cntl(const struct pipe_ctx *pipe)
 	return early_cntl ? early_cntl : lane_count;
 }
 
-/* dcn20_blank_pixel_data(blank): sRGB black over the whole OTG. */
+/*
+ * dcn20_blank_pixel_data: sRGB black over the whole OTG, or the video
+ * on unblank.
+ */
 static void dcn401_opp_blank_params(const struct dc *dc,
-		const struct pipe_ctx *pipe,
+		const struct pipe_ctx *pipe, bool unblank,
 		struct opp_set_disp_pattern_generator_params *p)
 {
 	const struct dc_crtc_timing *timing = &pipe->stream->timing;
 
 	p->opp = pipe->stream_res.opp;
-	p->test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
+	p->test_pattern = unblank ? CONTROLLER_DP_TEST_PATTERN_VIDEOMODE :
+			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
 	p->color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
 	p->color_depth = timing->display_color_depth;
 	p->use_solid_color = true;
@@ -848,6 +1500,111 @@ static void dcn401_update_clocks_params(const struct dc *dc,
 			context->bw_ctx.bw.dcn.clk.p_state_change_support;
 }
 
+/* dcn401_update_mpcc_sequence's blending for the plane. */
+static void dcn401_blnd_cfg(const struct dc_plane_state *plane,
+		struct mpcc_blnd_cfg *cfg)
+{
+	cfg->overlap_only = false;
+	cfg->global_gain = 0xff;
+	if (plane->per_pixel_alpha) {
+		cfg->pre_multiplied_alpha = plane->pre_multiplied_alpha;
+		if (plane->global_alpha) {
+			cfg->alpha_mode =
+				MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
+			cfg->global_gain = plane->global_alpha_value;
+		} else {
+			cfg->alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+		}
+	} else {
+		cfg->pre_multiplied_alpha = false;
+		cfg->alpha_mode = MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
+	}
+	cfg->global_alpha = plane->global_alpha ?
+			plane->global_alpha_value : 0xff;
+	cfg->background_color_bpc = 4;
+	cfg->bottom_gain_mode = 0;
+	cfg->top_gain = DCN401_UNITY_GAIN;
+	cfg->bottom_inside_gain = DCN401_UNITY_GAIN;
+	cfg->bottom_outside_gain = DCN401_UNITY_GAIN;
+	if (plane->format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
+		cfg->pre_multiplied_alpha = false;
+}
+
+/* dcn401_set_hdr_multiplier_sequence: 1.0 unless the plane sets one. */
+static uint32_t dcn401_hdr_mult(const struct dc_plane_state *plane)
+{
+	struct custom_float_format fmt = {
+		.exponenta_bits = 6,
+		.mantissa_bits = 12,
+		.sign = true,
+	};
+	uint32_t hw_mult = DCN401_UNITY_GAIN;
+
+	if (!dc_fixpt_eq(plane->hdr_mult, dc_fixpt_from_int(0)) &&
+			!convert_to_custom_float_format(plane->hdr_mult, &fmt,
+			&hw_mult))
+		hw_mult = DCN401_UNITY_GAIN;
+	return hw_mult;
+}
+
+/* dcn401_program_mall_pipe_config_sequence for one non-phantom pipe. */
+static void dcn401_mall_sel_params(struct dc *dc, struct dc_state *state,
+		struct pipe_ctx *pipe, struct hubp_update_mall_sel_params *p)
+{
+	const struct hubp *hubp = pipe->plane_res.hubp;
+	const struct dc_plane_address *address = &pipe->plane_state->address;
+	int cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
+	uint32_t mall_ss_size_bytes;
+	uint32_t num_ways = 0;
+
+	switch (hubp->curs_attr.color_format) {
+	case CURSOR_MODE_MONO:
+		cursor_size /= 2;
+		break;
+	case CURSOR_MODE_COLOR_1BIT_AND:
+	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+		cursor_size *= 4;
+		break;
+	default:
+		cursor_size *= 8;
+		break;
+	}
+
+	/*
+	 * dcn401_calculate_cab_allocation also adds the cursor mall bytes.
+	 * This builder rejects a cursor, so those bytes are zero. The helper
+	 * that computes them is built only with CONFIG_DRM_AMD_DC_FP.
+	 */
+	mall_ss_size_bytes = state->bw_ctx.bw.dcn.mall_ss_size_bytes;
+	if (dc->debug.force_mall_ss_num_ways > 0)
+		num_ways = dc->debug.force_mall_ss_num_ways;
+	else if (dc->res_pool->funcs->calculate_mall_ways_from_bytes)
+		num_ways = dc->res_pool->funcs->calculate_mall_ways_from_bytes(
+				dc, mall_ss_size_bytes);
+
+	p->hubp = pipe->plane_res.hubp;
+	p->cache_cursor = cursor_size > DCN401_CACHE_CURSOR_BYTES;
+	p->mall_sel = num_ways <= dc->caps.cache_num_ways &&
+			pipe->stream->link->psr_settings.psr_version ==
+			DC_PSR_VERSION_UNSUPPORTED &&
+			address->type != PLN_ADDR_TYPE_GRPH_STEREO &&
+			!address->tmz_surface ? DCN401_MALL_SEL_SS : 0;
+}
+
+/* dcn401_set_mcm_luts clears the HUBP 3DLUT fast load with this. */
+static const struct dc_3dlut_dma dcn401_3dlut_dma_off = {0};
+
+/* dcn401_set_mcm_luts sizes the off 3DLUT by the plane's LUT. */
+static enum dc_cm_lut_size dcn401_lut_mode_size(
+		const struct dc_plane_state *plane, enum MCM_LUT_ID id)
+{
+	if (id != MCM_LUT_3DLUT)
+		return CM_LUT_SIZE_NONE;
+	return plane->cm.lut3d_func.lut_3d.use_tetrahedral_9 ?
+			CM_LUT_SIZE_999 : CM_LUT_SIZE_171717;
+}
+
 /* Writes one entry; build sized every sequence before adding to it. */
 static void dcn401_add_step(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *args,
@@ -858,11 +1615,65 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	union block_sequence_params *p = &entry->params;
 	struct dc *dc = args->dc;
 	struct dcn_bw_output *bw = &args->new_state->bw_ctx.bw.dcn;
-	struct pipe_ctx *pipe = args->pipe;
+	struct pipe_ctx *pipe;
+	struct dpp *dpp;
+	struct dc_plane_state *plane;
 	const struct dcn401_commit_step_meta *m = &step->meta;
 
 	memset(entry, 0, sizeof(*entry));
 	entry->func = step->func;
+	/*
+	 * Bandwidth and p-state steps have no pipe. Handle them before the
+	 * pipe is used, then every later case can use the pipe directly.
+	 */
+	if (!args->pipe) {
+		switch (step->func) {
+		case CLK_MGR_UPDATE_CLOCKS_FOR_STATE:
+			dcn401_update_clocks_params(dc, args->new_state,
+					m->clk_mgr_update_clocks_for_state
+					.safe_to_lower,
+					&p->clk_mgr_update_clocks_for_state_params);
+			return;
+		case HUBBUB_PROGRAM_WATERMARKS:
+			p->hubbub_program_watermarks_params =
+					hwss_prepare_hubbub_program_watermarks(dc,
+					dc->res_pool->hubbub, &bw->watermarks,
+					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz /
+					1000,
+					m->hubbub_program_watermarks.safe_to_lower);
+			return;
+		case HUBBUB_PROGRAM_ARBITER:
+			p->hubbub_program_arbiter_params =
+					hwss_prepare_hubbub_program_arbiter(
+					dc->res_pool->hubbub, &bw->arb_regs,
+					m->hubbub_program_arbiter.safe_to_lower);
+			return;
+		case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
+			p->hubbub_program_compbuf_segments_params.hubbub =
+					dc->res_pool->hubbub;
+			p->hubbub_program_compbuf_segments_params.compbuf_size =
+					m->hubbub_program_compbuf_segments
+					.use_current_state_size ?
+					args->current_state->bw_ctx.bw.dcn.arb_regs
+					.compbuf_size : bw->arb_regs.compbuf_size;
+			p->hubbub_program_compbuf_segments_params.safe_to_lower =
+					m->hubbub_program_compbuf_segments
+					.safe_to_lower;
+			return;
+		case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL:
+			p->hubbub_force_pstate_change_control_params.hubbub =
+					dc->res_pool->hubbub;
+			p->hubbub_force_pstate_change_control_params.enable =
+					m->hubbub_force_pstate_change_control.enable;
+			return;
+		default:
+			(*sequence->num_steps)--;
+			return;
+		}
+	}
+	pipe = args->pipe;
+	dpp = pipe->plane_res.dpp;
+	plane = pipe->plane_state;
 	switch (step->func) {
 	case CLK_MGR_UPDATE_CLOCKS_FOR_STATE:
 		dcn401_update_clocks_params(dc, args->new_state,
@@ -888,7 +1699,10 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->hubbub_program_compbuf_segments_params.hubbub =
 				dc->res_pool->hubbub;
 		p->hubbub_program_compbuf_segments_params.compbuf_size =
-				bw->arb_regs.compbuf_size;
+				m->hubbub_program_compbuf_segments
+				.use_current_state_size ?
+				args->current_state->bw_ctx.bw.dcn.arb_regs
+				.compbuf_size : bw->arb_regs.compbuf_size;
 		p->hubbub_program_compbuf_segments_params.safe_to_lower =
 				m->hubbub_program_compbuf_segments
 				.safe_to_lower;
@@ -896,6 +1710,8 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 	case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL:
 		p->hubbub_force_pstate_change_control_params.hubbub =
 				dc->res_pool->hubbub;
+		p->hubbub_force_pstate_change_control_params.enable =
+				m->hubbub_force_pstate_change_control.enable;
 		break;
 	case BIOS_SET_SCRATCH_CRITICAL_STATE:
 		p->bios_set_scratch_critical_state_params.dcb =
@@ -996,6 +1812,7 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		break;
 	case OPP_SET_DISP_PATTERN_GENERATOR:
 		dcn401_opp_blank_params(dc, pipe,
+				m->opp_set_disp_pattern_generator.unblank,
 				&p->opp_set_disp_pattern_generator_params);
 		break;
 	case OPP_WAIT_FOR_BLANK_COMPLETE:
@@ -1084,6 +1901,9 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->program_det_segments_params.hubbub = dc->res_pool->hubbub;
 		p->program_det_segments_params.hubp_inst =
 				pipe->plane_res.hubp->inst;
+		if (m->hubp_program_det_segments.allocate)
+			p->program_det_segments_params.det_size =
+					pipe->hubp_regs.det_size;
 		break;
 	case MPC_REMOVE_MPCC:
 		p->mpc_remove_mpcc_params.mpc = dc->res_pool->mpc;
@@ -1100,19 +1920,27 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		break;
 	case HUBP_SET_BLANK:
 		p->hubp_set_blank_params.hubp = pipe->plane_res.hubp;
-		p->hubp_set_blank_params.blank = true;
+		p->hubp_set_blank_params.blank = !m->hubp_set_blank.unblank;
 		break;
 	case HUBP_UPDATE_MALL_SEL:
-		p->hubp_update_mall_sel_params.hubp = pipe->plane_res.hubp;
+		if (m->hubp_update_mall_sel.from_new_state)
+			dcn401_mall_sel_params(dc, args->new_state, pipe,
+					&p->hubp_update_mall_sel_params);
+		else
+			p->hubp_update_mall_sel_params.hubp =
+					pipe->plane_res.hubp;
 		break;
 	case HUBP_SET_FLIP_CONTROL_GSL:
 		p->set_flip_control_gsl_params.hubp = pipe->plane_res.hubp;
 		break;
 	case HUBP_CLK_CNTL:
 		p->hubp_clk_cntl_params.hubp = pipe->plane_res.hubp;
+		p->hubp_clk_cntl_params.enable = m->hubp_clk_cntl.enable;
 		break;
 	case DPP_DPPCLK_CONTROL:
-		p->dpp_dppclk_control_params.dpp = pipe->plane_res.dpp;
+		p->dpp_dppclk_control_params.dpp = dpp;
+		p->dpp_dppclk_control_params.enable =
+				m->dpp_dppclk_control.enable;
 		break;
 	case DC_IP_REQUEST_CNTL:
 		p->dc_ip_request_cntl_params.hws = dc->hwseq;
@@ -1123,13 +1951,240 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 		p->hubp_pg_control_params.hws = dc->hwseq;
 		p->hubp_pg_control_params.hubp_inst =
 				pipe->plane_res.hubp->inst;
-		p->hubp_pg_control_params.power_on = false;
+		p->hubp_pg_control_params.power_on =
+				m->hubp_pg_control.power_on;
 		break;
 	case HUBP_RESET:
 		p->hubp_reset_params.hubp = pipe->plane_res.hubp;
 		break;
 	case DPP_RESET:
-		p->dpp_reset_params.dpp = pipe->plane_res.dpp;
+		p->dpp_reset_params.dpp = dpp;
+		break;
+	case TG_WAIT_FOR_ALL_PENDING_UPDATES:
+		p->tg_wait_for_all_pending_updates_params.tg =
+				pipe->stream_res.tg;
+		p->tg_wait_for_all_pending_updates_params.include_pipe_update =
+				plane != NULL;
+		p->tg_wait_for_all_pending_updates_params.polling_interval_us =
+				DCN401_PENDING_UPDATE_POLL_INTERVAL_US;
+		p->tg_wait_for_all_pending_updates_params.timeout_us =
+				DCN401_PENDING_UPDATE_TIMEOUT_US;
+		break;
+	case HUBP_PROGRAM_TRIPLEBUFFER:
+		p->program_triplebuffer_params.hubp = pipe->plane_res.hubp;
+		p->program_triplebuffer_params.enableTripleBuffer =
+				plane->triplebuffer_flips;
+		break;
+	case DC_UDELAY:
+		p->dc_udelay_params.us = DCN401_PLANE_ENABLE_DELAY_US;
+		break;
+	case TG_PROGRAM_GLOBAL_SYNC:
+		p->tg_program_global_sync_params.tg = pipe->stream_res.tg;
+		p->tg_program_global_sync_params.vready_offset =
+				pipe->global_sync.dcn4x.vready_offset_pixels;
+		p->tg_program_global_sync_params.vstartup_lines =
+				pipe->global_sync.dcn4x.vstartup_lines;
+		p->tg_program_global_sync_params.vupdate_offset_pixels =
+				pipe->global_sync.dcn4x.vupdate_offset_pixels;
+		p->tg_program_global_sync_params.vupdate_vupdate_width_pixels =
+				pipe->global_sync.dcn4x
+				.vupdate_vupdate_width_pixels;
+		p->tg_program_global_sync_params.pstate_keepout_start_lines =
+				pipe->global_sync.dcn4x.pstate_keepout_start_lines;
+		break;
+	case TG_WAIT_FOR_STATE:
+		p->tg_wait_for_state_params.tg = pipe->stream_res.tg;
+		p->tg_wait_for_state_params.state = CRTC_STATE_VACTIVE;
+		break;
+	case TG_SET_VTG_PARAMS:
+		p->tg_set_vtg_params_params.tg = pipe->stream_res.tg;
+		p->tg_set_vtg_params_params.timing = &pipe->stream->timing;
+		p->tg_set_vtg_params_params.program_fp2 = true;
+		break;
+	case HUBP_INIT:
+		p->hubp_init_params.hubp = pipe->plane_res.hubp;
+		break;
+	case HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES:
+		p->hubbub_force_wm_propagate_to_pipes_params.hubbub =
+				dc->res_pool->hubbub;
+		break;
+	case DCCG_UPDATE_DPP_DTO:
+		p->dccg_update_dpp_dto_params.dccg = dc->res_pool->dccg;
+		p->dccg_update_dpp_dto_params.dpp_inst = dpp->inst;
+		p->dccg_update_dpp_dto_params.dppclk_khz =
+				pipe->plane_res.bw.dppclk_khz;
+		break;
+	case HUBP_VTG_SEL:
+		p->hubp_vtg_sel_params.hubp = pipe->plane_res.hubp;
+		p->hubp_vtg_sel_params.otg_inst = pipe->stream_res.tg->inst;
+		break;
+	case HUBP_SETUP2:
+		p->hubp_setup2_params.hubp = pipe->plane_res.hubp;
+		p->hubp_setup2_params.hubp_regs = &pipe->hubp_regs;
+		p->hubp_setup2_params.global_sync = &pipe->global_sync;
+		p->hubp_setup2_params.timing = &pipe->stream->timing;
+		break;
+	case HUBP_SET_UNBOUNDED_REQUESTING:
+		p->hubp_set_unbounded_requesting_params.hubp = pipe->plane_res.hubp;
+		p->hubp_set_unbounded_requesting_params.unbounded_req =
+				pipe->unbounded_req;
+		break;
+	case HUBP_SETUP_INTERDEPENDENT2:
+		p->hubp_setup_interdependent2_params.hubp = pipe->plane_res.hubp;
+		p->hubp_setup_interdependent2_params.hubp_regs =
+				&pipe->hubp_regs;
+		break;
+	case DPP_SETUP_DPP:
+		p->setup_dpp_params.dpp = dpp;
+		p->setup_dpp_params.format = plane->format;
+		p->setup_dpp_params.input_csc_color_matrix =
+				plane->input_csc_color_matrix;
+		p->setup_dpp_params.color_space = plane->color_space;
+		p->setup_dpp_params.upsp_mode = resource_is_upsp_required(
+				plane->format, plane->scaling_linearity);
+		break;
+	case DPP_SET_CURSOR_MATRIX:
+		p->dpp_set_cursor_matrix_params.dpp = dpp;
+		p->dpp_set_cursor_matrix_params.color_space =
+				plane->color_space;
+		p->dpp_set_cursor_matrix_params.cursor_csc_color_matrix =
+				&plane->cursor_csc_color_matrix;
+		break;
+	case DPP_PROGRAM_BIAS_AND_SCALE:
+		p->program_bias_and_scale_params.dpp = dpp;
+		p->program_bias_and_scale_params.bias_and_scale =
+				plane->bias_and_scale;
+		break;
+	case MPC_INSERT_PLANE:
+		p->mpc_insert_plane_params.mpc = dc->res_pool->mpc;
+		p->mpc_insert_plane_params.mpc_tree_params =
+				&pipe->stream_res.opp->mpc_tree_params;
+		dcn401_blnd_cfg(plane, &p->mpc_insert_plane_params.blnd_cfg);
+		p->mpc_insert_plane_params.dpp_id = pipe->plane_res.hubp->inst;
+		p->mpc_insert_plane_params.mpcc_id = pipe->plane_res.hubp->inst;
+		break;
+	case MPC_UPDATE_VISUAL_CONFIRM:
+		p->update_visual_confirm_params.mpc = dc->res_pool->mpc;
+		p->update_visual_confirm_params.color =
+				&pipe->visual_confirm_color;
+		p->update_visual_confirm_params.mpcc_id = pipe->plane_res.hubp->inst;
+		break;
+	case DPP_SET_SCALER:
+		p->dpp_set_scaler_params.dpp = dpp;
+		p->dpp_set_scaler_params.scl_data = &pipe->plane_res.scl_data;
+		break;
+	case HUBP_MEM_PROGRAM_VIEWPORT:
+		p->hubp_mem_program_viewport_params.hubp = pipe->plane_res.hubp;
+		p->hubp_mem_program_viewport_params.viewport =
+				&pipe->plane_res.scl_data.viewport;
+		p->hubp_mem_program_viewport_params.viewport_c =
+				&pipe->plane_res.scl_data.viewport_c;
+		break;
+	case HUBP_PROGRAM_MCACHE_ID:
+		p->program_mcache_id_and_split_coordinate.hubp = pipe->plane_res.hubp;
+		p->program_mcache_id_and_split_coordinate.mcache_regs =
+				&pipe->mcache_regs;
+		break;
+	case MPC_SET_GAMUT_REMAP_BYPASS:
+		p->mpc_set_gamut_remap_bypass_params.mpc = dc->res_pool->mpc;
+		p->mpc_set_gamut_remap_bypass_params.mpcc_id =
+				pipe->plane_res.mpcc_inst;
+		p->mpc_set_gamut_remap_bypass_params.block_id =
+				m->mpc_set_gamut_remap_bypass.block_id;
+		break;
+	case MPC_POWER_ON_MPC_MEM_PWR:
+		p->power_on_mpc_mem_pwr_params.mpc = dc->res_pool->mpc;
+		p->power_on_mpc_mem_pwr_params.mpcc_id = pipe->plane_res.hubp->inst;
+		p->power_on_mpc_mem_pwr_params.power_on = true;
+		break;
+	case MPC_SET_OCSC_DEFAULT:
+		p->set_ocsc_default_params.mpc = dc->res_pool->mpc;
+		p->set_ocsc_default_params.opp_id = pipe->stream_res.opp->inst;
+		p->set_ocsc_default_params.color_space =
+				pipe->stream->output_color_space;
+		p->set_ocsc_default_params.ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
+		break;
+	case HUBP_PROGRAM_SURFACE_CONFIG:
+		p->program_surface_config_params.hubp = pipe->plane_res.hubp;
+		p->program_surface_config_params.format = plane->format;
+		p->program_surface_config_params.tiling_info =
+				&plane->tiling_info;
+		p->program_surface_config_params.plane_size =
+				plane->plane_size;
+		p->program_surface_config_params.plane_size.surface_size =
+				pipe->plane_res.scl_data.viewport;
+		p->program_surface_config_params.rotation = plane->rotation;
+		p->program_surface_config_params.dcc = &plane->dcc;
+		p->program_surface_config_params.horizontal_mirror =
+				plane->horizontal_mirror;
+		break;
+	case HUBP_UPDATE_PLANE_ADDR:
+		p->update_plane_addr_params.hubp = pipe->plane_res.hubp;
+		p->update_plane_addr_params.address = plane->address;
+		p->update_plane_addr_params.flip_immediate =
+				plane->flip_immediate;
+		p->update_plane_addr_params.dcc = plane->dcc.enable;
+		break;
+	case DPP_SET_HDR_MULTIPLIER:
+		p->dpp_set_hdr_multiplier_params.dpp = dpp;
+		p->dpp_set_hdr_multiplier_params.hw_mult =
+				dcn401_hdr_mult(plane);
+		break;
+	case DPP_SET_PRE_DEGAM:
+		p->dpp_set_pre_degam_params.dpp = dpp;
+		p->dpp_set_pre_degam_params.in_transfer_func =
+				&plane->in_transfer_func;
+		break;
+	case DPP_PROGRAM_GAMCOR_LUT:
+		p->dpp_program_gamcor_lut_params.dpp = dpp;
+		if (plane->in_transfer_func.type == TF_TYPE_HWPWL)
+			p->dpp_program_gamcor_lut_params.params =
+					&plane->in_transfer_func.pwl;
+		break;
+	case MPC_SET_MOVABLE_CM_LOCATION:
+		p->mpc_set_movable_cm_location_params.mpc = dc->res_pool->mpc;
+		p->mpc_set_movable_cm_location_params.location =
+				MPCC_MOVABLE_CM_LOCATION_BEFORE;
+		p->mpc_set_movable_cm_location_params.mpcc_id =
+				pipe->plane_res.mpcc_inst;
+		break;
+	case MPC_PROGRAM_LUT_MODE:
+		/*
+		 * Every LUT is off. DC1 reads the bank back with get_lut_mode;
+		 * the build reads no hardware, so it assumes bank A for an
+		 * MPCC that held no plane.
+		 */
+		p->mpc_program_lut_mode_params.mpc = dc->res_pool->mpc;
+		p->mpc_program_lut_mode_params.id = m->mpc_program_lut_mode.id;
+		p->mpc_program_lut_mode_params.lut_bank_a = true;
+		p->mpc_program_lut_mode_params.size = dcn401_lut_mode_size(
+				plane, m->mpc_program_lut_mode.id);
+		p->mpc_program_lut_mode_params.mpcc_id =
+				pipe->plane_res.mpcc_inst;
+		break;
+	case HUBP_PROGRAM_3DLUT_FL_CONFIG:
+		p->hubp_program_3dlut_fl_config_params.hubp = pipe->plane_res.hubp;
+		p->hubp_program_3dlut_fl_config_params.config =
+				&dcn401_3dlut_dma_off;
+		break;
+	case HUBP_SET_3DLUT_FL:
+		p->hubp_set_3dlut_fl_params.hubp = pipe->plane_res.hubp;
+		break;
+	case MPC_SET_OUTPUT_GAMMA:
+		p->mpc_set_output_gamma_params.mpc = dc->res_pool->mpc;
+		p->mpc_set_output_gamma_params.mpcc_id =
+				pipe->plane_res.mpcc_inst;
+		if (pipe->stream->out_transfer_func.type == TF_TYPE_HWPWL)
+			p->mpc_set_output_gamma_params.params =
+					&pipe->stream->out_transfer_func.pwl;
+		break;
+	case HUBP_WAIT_FLIP_PENDING:
+		p->hubp_wait_flip_pending_params.hubp = pipe->plane_res.hubp;
+		p->hubp_wait_flip_pending_params.polling_interval_us =
+				DCN401_FLIP_PENDING_POLL_INTERVAL_US;
+		break;
+	case OPTC_PROGRAM_MANUAL_TRIGGER:
+		p->program_manual_trigger_params.tg = pipe->stream_res.tg;
 		break;
 	default:
 		/* The step tables use only the funcs above. */
@@ -1147,6 +2202,13 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 	if (step->meta.skip_if.new_state_has_stream &&
 			args->new_state->stream_count)
 		return true;
+	if (step->meta.skip_if.optimized_not_required &&
+			!args->dc->optimized_required)
+		return true;
+	if (step->meta.skip_if.no_manual_trigger &&
+			(!args->pipe->plane_state->update_bits.addr_update ||
+			args->pipe->plane_state->skip_manual_trigger))
+		return true;
 	return false;
 }
 
@@ -1164,15 +2226,14 @@ static void dcn401_add_steps(struct block_sequence_state *sequence,
 
 /* The support check found an OTG master for each stream of state. */
 static void dcn401_add_steps_per_stream_per_otg_master_pipe(
-		struct block_sequence_state *sequence, struct dc *dc,
-		struct dc_state *new_state, struct dc_state *state,
+		struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		struct dc_state *state,
 		const struct dcn401_commit_step *steps, unsigned int count)
 {
-	struct dcn401_commit_step_args args = {0};
+	struct dcn401_commit_step_args args = *state_args;
 	unsigned int i;
 
-	args.dc = dc;
-	args.new_state = new_state;
 	for (i = 0; i < state->stream_count; i++) {
 		args.pipe = get_otg_master_from_state_by_stream(state,
 				state->streams[i]);
@@ -1182,20 +2243,37 @@ static void dcn401_add_steps_per_stream_per_otg_master_pipe(
 
 #define DCN401_ADD_STEPS(sequence, args, steps) \
 	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
-#define DCN401_ADD_STEPS_PER_STREAM(sequence, dc, new_state, state, steps) \
-	dcn401_add_steps_per_stream_per_otg_master_pipe(sequence, dc, \
-			new_state, state, steps, ARRAY_SIZE(steps))
+#define DCN401_ADD_STEPS_PER_STREAM(sequence, args, state, steps) \
+	dcn401_add_steps_per_stream_per_otg_master_pipe(sequence, args, \
+			state, steps, ARRAY_SIZE(steps))
+
+/*
+ * Points the step arguments at the states and the sequence at
+ * head_sequence, both empty. The entries point into the states; the build
+ * writes neither.
+ */
+static void dcn401_init_and_unpack_params(
+		struct bls_builder_declarative_params *params,
+		struct dcn401_commit_step_args *state_args,
+		struct block_sequence_state *head)
+{
+	state_args->dc = params->dc;
+	state_args->current_state = (struct dc_state *)params->current_state;
+	state_args->new_state = (struct dc_state *)params->new_state;
+	state_args->pipe = NULL;
+
+	params->head_num_steps = 0;
+	params->tail_num_steps = 0;
+	head->steps = params->head_sequence;
+	head->num_steps = &params->head_num_steps;
+}
 
 static enum bls_builder_result dcn401_build_non_seamless_commit(
 		struct bls_builder_declarative_params *params)
 {
-	struct dcn401_commit_step_args state_args = {0};
+	struct dcn401_commit_step_args state_args;
 	struct block_sequence_state head;
-	struct block_sequence_state tail;
-	struct dc_state *current_state;
-	struct dc_state *new_state;
 	enum bls_builder_result result;
-	struct dc *dc;
 
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
@@ -1204,28 +2282,58 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	/* The entries point into the states. The build writes neither. */
-	dc = params->dc;
-	current_state = (struct dc_state *)params->current_state;
-	new_state = (struct dc_state *)params->new_state;
-	state_args.dc = dc;
-	state_args.new_state = new_state;
-
-	params->head_num_steps = 0;
-	params->tail_num_steps = 0;
-	head.steps = params->head_sequence;
-	head.num_steps = &params->head_num_steps;
-	tail.steps = params->tail_sequence;
-	tail.num_steps = &params->tail_num_steps;
-
+	dcn401_init_and_unpack_params(params, &state_args, &head);
 	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
-	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, current_state,
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+			state_args.current_state,
 			bls_head_per_stream_per_otg_master_pipe_current);
-	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, new_state,
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
 			bls_head_per_stream_per_otg_master_pipe_new);
-	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, new_state,
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
 			bls_head_per_stream_per_otg_master_pipe_new_front_end);
-	DCN401_ADD_STEPS(&tail, &state_args, bls_tail_per_state_new);
+	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new_postamble);
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_build_seamless_update(
+		struct bls_builder_declarative_params *params)
+{
+	struct dcn401_commit_step_args state_args;
+	struct block_sequence_state head;
+	enum bls_builder_result result;
+
+	if (!params)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	result = dcn401_check_seamless_update_support(params->dc,
+			params->current_state, params->new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	dcn401_init_and_unpack_params(params, &state_args, &head);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+			state_args.current_state,
+			bls_update_head_per_stream_per_otg_master_pipe_preamble);
+	DCN401_ADD_STEPS(&head, &state_args,
+			bls_update_head_global_preamble);
+	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+			state_args.current_state,
+			bls_update_head_per_stream_per_otg_master_pipe_current_pending);
+
+	/* One stream, so adding each table per stream keeps the DC1 order. */
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_lock);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_stream);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_enable_plane);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_update_dchubp_dpp);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_transfer_funcs);
+	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+			bls_update_head_new_unlock);
 
 	return BLS_BUILD_SUCCESS;
 }
@@ -1249,3 +2357,23 @@ const struct bls_builder *dcn401_non_seamless_commit_builder(void)
 
 	return &builder;
 }
+
+static bool dcn401_seamless_update_check_capability(
+		const struct bls_builder_check_capability_params *params)
+{
+	return params && dcn401_check_seamless_update_support(params->dc,
+			params->current_state, params->new_state) ==
+			BLS_BUILD_SUCCESS;
+}
+
+const struct bls_builder *dcn401_seamless_update_builder(void)
+{
+	static const struct bls_builder builder = {
+		.name = DCN_DECL_SEAMLESS_UPDATE,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_seamless_update_check_capability,
+		.build.declarative = dcn401_build_seamless_update,
+	};
+
+	return &builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 4c0043c84907..75fd4be3690a 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -409,6 +409,8 @@ const struct bls_builder *dcn401_bls_builder_create(
 		return &legacy_initialization_builder;
 	case DCN_DECL_NON_SEAMLESS_COMMIT:
 		return dcn401_non_seamless_commit_builder();
+	case DCN_DECL_SEAMLESS_UPDATE:
+		return dcn401_seamless_update_builder();
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 3a80c9261710..6a875add72e2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -486,6 +486,151 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 		return mpc && mpc->funcs && mpc->funcs->remove_mpcc &&
 				step->params.mpc_remove_mpcc_params.mpc_tree_params &&
 				step->params.mpc_remove_mpcc_params.mpcc_to_remove;
+	case MPC_INSERT_PLANE:
+		mpc = step->params.mpc_insert_plane_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->insert_plane &&
+				step->params.mpc_insert_plane_params.mpc_tree_params;
+	case MPC_UPDATE_BLENDING:
+		mpc = step->params.mpc_update_blending_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->update_blending;
+	case MPC_POWER_ON_MPC_MEM_PWR:
+		mpc = step->params.power_on_mpc_mem_pwr_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->power_on_mpc_mem_pwr;
+	case MPC_SET_OCSC_DEFAULT:
+		mpc = step->params.set_ocsc_default_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->set_ocsc_default;
+	case DPP_SET_SCALER:
+		dpp = step->params.dpp_set_scaler_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_set_scaler &&
+				step->params.dpp_set_scaler_params.scl_data;
+	case DPP_PROGRAM_BIAS_AND_SCALE:
+		dpp = step->params.program_bias_and_scale_params.dpp;
+		return dpp && dpp->funcs &&
+				dpp->funcs->dpp_program_bias_and_scale;
+	case DPP_SET_HDR_MULTIPLIER:
+		dpp = step->params.dpp_set_hdr_multiplier_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_set_hdr_multiplier;
+	case HUBP_INIT:
+		hubp = step->params.hubp_init_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_init;
+	case HUBP_VTG_SEL:
+		hubp = step->params.hubp_vtg_sel_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_vtg_sel;
+	case HUBP_SET_UNBOUNDED_REQUESTING:
+		hubp = step->params.hubp_set_unbounded_requesting_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->set_unbounded_requesting;
+	case HUBP_MEM_PROGRAM_VIEWPORT:
+		hubp = step->params.hubp_mem_program_viewport_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->mem_program_viewport &&
+				step->params.hubp_mem_program_viewport_params.viewport;
+	case HUBP_PROGRAM_TRIPLEBUFFER:
+		hubp = step->params.program_triplebuffer_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_enable_tripleBuffer;
+	case OPTC_PROGRAM_MANUAL_TRIGGER:
+		tg = step->params.program_manual_trigger_params.tg;
+		return tg && tg->funcs && tg->funcs->program_manual_trigger;
+	case DCCG_UPDATE_DPP_DTO:
+		dccg = step->params.dccg_update_dpp_dto_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->update_dpp_dto;
+	case TG_PROGRAM_GLOBAL_SYNC:
+		tg = step->params.tg_program_global_sync_params.tg;
+		return tg && tg->funcs && tg->funcs->program_global_sync;
+	case TG_SET_VTG_PARAMS:
+		tg = step->params.tg_set_vtg_params_params.tg;
+		return tg && tg->funcs && tg->funcs->set_vtg_params &&
+				step->params.tg_set_vtg_params_params.timing;
+	case TG_WAIT_FOR_ALL_PENDING_UPDATES: {
+		const struct tg_wait_for_all_pending_updates_params *p =
+				&step->params.tg_wait_for_all_pending_updates_params;
+
+		return p->tg && p->tg->funcs && p->tg->funcs->is_tg_enabled &&
+				p->polling_interval_us;
+	}
+	case DC_UDELAY:
+		return true;
+	case HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES:
+		hubbub = step->params.hubbub_force_wm_propagate_to_pipes_params
+				.hubbub;
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->force_wm_propagate_to_pipes;
+	case HUBP_SETUP2: {
+		const struct hubp_setup2_params *p =
+				&step->params.hubp_setup2_params;
+
+		return p->hubp && p->hubp->funcs && p->hubp->funcs->hubp_setup2 &&
+				p->hubp_regs && p->global_sync && p->timing;
+	}
+	case HUBP_SETUP_INTERDEPENDENT2:
+		hubp = step->params.hubp_setup_interdependent2_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_setup_interdependent2 &&
+				step->params.hubp_setup_interdependent2_params
+				.hubp_regs;
+	case HUBP_PROGRAM_MCACHE_ID:
+		hubp = step->params.program_mcache_id_and_split_coordinate.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_program_mcache_id_and_split_coordinate &&
+				step->params.program_mcache_id_and_split_coordinate
+				.mcache_regs;
+	case HUBP_PROGRAM_SURFACE_CONFIG:
+		hubp = step->params.program_surface_config_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_program_surface_config &&
+				step->params.program_surface_config_params
+				.tiling_info &&
+				step->params.program_surface_config_params.dcc;
+	case HUBP_UPDATE_PLANE_ADDR:
+		hubp = step->params.update_plane_addr_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_program_surface_flip_and_addr;
+	case HUBP_WAIT_FLIP_PENDING:
+		hubp = step->params.hubp_wait_flip_pending_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_is_flip_pending &&
+				step->params.hubp_wait_flip_pending_params
+				.polling_interval_us;
+	case HUBP_PROGRAM_3DLUT_FL_CONFIG:
+		hubp = step->params.hubp_program_3dlut_fl_config_params.hubp;
+		return hubp && hubp->funcs &&
+				hubp->funcs->hubp_program_3dlut_fl_config &&
+				step->params.hubp_program_3dlut_fl_config_params
+				.config;
+	case HUBP_SET_3DLUT_FL:
+		hubp = step->params.hubp_set_3dlut_fl_params.hubp;
+		return hubp && hubp->funcs && hubp->funcs->hubp_enable_3dlut_fl;
+	case DPP_SETUP_DPP:
+		dpp = step->params.setup_dpp_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_setup;
+	case DPP_SET_CURSOR_MATRIX:
+		dpp = step->params.dpp_set_cursor_matrix_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->set_cursor_matrix &&
+				step->params.dpp_set_cursor_matrix_params
+				.cursor_csc_color_matrix;
+	case DPP_SET_PRE_DEGAM:
+		dpp = step->params.dpp_set_pre_degam_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_set_pre_degam &&
+				step->params.dpp_set_pre_degam_params
+				.in_transfer_func;
+	case DPP_PROGRAM_GAMCOR_LUT:
+		dpp = step->params.dpp_program_gamcor_lut_params.dpp;
+		return dpp && dpp->funcs && dpp->funcs->dpp_program_gamcor_lut;
+	case MPC_UPDATE_VISUAL_CONFIRM:
+		mpc = step->params.update_visual_confirm_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->set_bg_color &&
+				step->params.update_visual_confirm_params.color;
+	case MPC_SET_GAMUT_REMAP_BYPASS:
+		mpc = step->params.mpc_set_gamut_remap_bypass_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->set_gamut_remap;
+	case MPC_SET_MOVABLE_CM_LOCATION:
+		mpc = step->params.mpc_set_movable_cm_location_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->set_movable_cm_location;
+	case MPC_PROGRAM_LUT_MODE:
+		mpc = step->params.mpc_program_lut_mode_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->program_lut_mode;
+	case MPC_SET_OUTPUT_GAMMA:
+		mpc = step->params.mpc_set_output_gamma_params.mpc;
+		return mpc && mpc->funcs && mpc->funcs->set_output_gamma;
 	default:
 		return false;
 	}
@@ -564,6 +709,64 @@ static noinline_for_stack bool dc2_bls_wait_for_blank_complete(
 	return w->opp->funcs->dpg_is_blanked(w->opp);
 }
 
+static noinline_for_stack void dc2_bls_wait_for_all_pending_updates(
+		const struct tg_wait_for_all_pending_updates_params *w)
+{
+	struct timing_generator *tg = w->tg;
+	unsigned int waited_us;
+	bool pending;
+
+	if (!tg->funcs->is_tg_enabled(tg))
+		return;
+
+	for (waited_us = 0; waited_us < w->timeout_us;
+			waited_us += w->polling_interval_us) {
+		pending = false;
+		if (tg->funcs->get_optc_double_buffer_pending)
+			pending |= tg->funcs->get_optc_double_buffer_pending(tg);
+		if (tg->funcs->get_otg_double_buffer_pending)
+			pending |= tg->funcs->get_otg_double_buffer_pending(tg);
+		if (w->include_pipe_update && tg->funcs->get_pipe_update_pending)
+			pending |= tg->funcs->get_pipe_update_pending(tg);
+		if (!pending)
+			return;
+		udelay(w->polling_interval_us);
+	}
+}
+
+static noinline_for_stack void dc2_bls_wait_flip_pending(
+		const struct hubp_wait_flip_pending_params *w)
+{
+	const unsigned int timeout_us = 100000U;
+	unsigned int j;
+
+	for (j = 0; j < timeout_us / w->polling_interval_us &&
+			w->hubp->funcs->hubp_is_flip_pending(w->hubp); j++)
+		udelay(w->polling_interval_us);
+}
+
+static noinline_for_stack void dc2_bls_set_gamut_remap_bypass(
+		const struct mpc_set_gamut_remap_bypass_params *p)
+{
+	struct mpc_grph_gamut_adjustment adjust = {
+		.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS,
+		.mpcc_gamut_remap_block_id = p->block_id,
+	};
+
+	p->mpc->funcs->set_gamut_remap(p->mpc, p->mpcc_id, &adjust);
+}
+
+static noinline_for_stack void dc2_bls_program_surface_config(
+		const struct program_surface_config_params *p)
+{
+	struct plane_size size = p->plane_size;
+
+	p->hubp->funcs->hubp_program_surface_config(p->hubp, p->format,
+			p->tiling_info, &size, p->rotation, p->dcc,
+			p->horizontal_mirror, p->compat_level);
+	p->hubp->power_gated = false;
+}
+
 enum dc2_bls_exec_result dc2_bls_execute(
 		struct dc2 *dc2,
 		const struct block_sequence *steps,
@@ -1278,6 +1481,269 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					p->mpcc_to_remove);
 			break;
 		}
+		case MPC_INSERT_PLANE: {
+			const struct mpc_insert_plane_params *p =
+					&entry->params.mpc_insert_plane_params;
+			struct mpcc_blnd_cfg blnd_cfg = p->blnd_cfg;
+
+			p->mpc->funcs->insert_plane(p->mpc, p->mpc_tree_params,
+					&blnd_cfg, p->sm_cfg, p->insert_above_mpcc,
+					p->dpp_id, p->mpcc_id);
+			break;
+		}
+		case MPC_UPDATE_BLENDING: {
+			const struct mpc_update_blending_params *p =
+					&entry->params.mpc_update_blending_params;
+			struct mpcc_blnd_cfg blnd_cfg = p->blnd_cfg;
+
+			p->mpc->funcs->update_blending(p->mpc, &blnd_cfg,
+					p->mpcc_id);
+			break;
+		}
+		case MPC_POWER_ON_MPC_MEM_PWR: {
+			const struct power_on_mpc_mem_pwr_params *p =
+					&entry->params.power_on_mpc_mem_pwr_params;
+
+			p->mpc->funcs->power_on_mpc_mem_pwr(p->mpc, p->mpcc_id,
+					p->power_on);
+			break;
+		}
+		case MPC_SET_OCSC_DEFAULT: {
+			const struct set_ocsc_default_params *p =
+					&entry->params.set_ocsc_default_params;
+
+			p->mpc->funcs->set_ocsc_default(p->mpc, p->opp_id,
+					p->color_space, p->ocsc_mode);
+			break;
+		}
+		case DPP_SET_SCALER: {
+			const struct dpp_set_scaler_params *p =
+					&entry->params.dpp_set_scaler_params;
+
+			p->dpp->funcs->dpp_set_scaler(p->dpp, p->scl_data);
+			break;
+		}
+		case DPP_PROGRAM_BIAS_AND_SCALE: {
+			const struct program_bias_and_scale_params *p =
+					&entry->params.program_bias_and_scale_params;
+			struct dc_bias_and_scale bias_and_scale = p->bias_and_scale;
+
+			p->dpp->funcs->dpp_program_bias_and_scale(p->dpp,
+					&bias_and_scale);
+			break;
+		}
+		case DPP_SET_HDR_MULTIPLIER: {
+			const struct dpp_set_hdr_multiplier_params *p =
+					&entry->params.dpp_set_hdr_multiplier_params;
+
+			p->dpp->funcs->dpp_set_hdr_multiplier(p->dpp, p->hw_mult);
+			break;
+		}
+		case HUBP_INIT:
+			hubp = entry->params.hubp_init_params.hubp;
+			hubp->funcs->hubp_init(hubp);
+			break;
+		case HUBP_VTG_SEL: {
+			const struct hubp_vtg_sel_params *p =
+					&entry->params.hubp_vtg_sel_params;
+
+			p->hubp->funcs->hubp_vtg_sel(p->hubp, p->otg_inst);
+			break;
+		}
+		case HUBP_SET_UNBOUNDED_REQUESTING: {
+			const struct hubp_set_unbounded_requesting_params *p =
+					&entry->params.hubp_set_unbounded_requesting_params;
+
+			p->hubp->funcs->set_unbounded_requesting(p->hubp,
+					p->unbounded_req);
+			break;
+		}
+		case HUBP_MEM_PROGRAM_VIEWPORT: {
+			const struct hubp_mem_program_viewport_params *p =
+					&entry->params.hubp_mem_program_viewport_params;
+
+			p->hubp->funcs->mem_program_viewport(p->hubp, p->viewport,
+					p->viewport_c);
+			break;
+		}
+		case HUBP_PROGRAM_TRIPLEBUFFER: {
+			const struct program_triplebuffer_params *p =
+					&entry->params.program_triplebuffer_params;
+
+			p->hubp->funcs->hubp_enable_tripleBuffer(p->hubp,
+					p->enableTripleBuffer);
+			break;
+		}
+		case OPTC_PROGRAM_MANUAL_TRIGGER:
+			tg = entry->params.program_manual_trigger_params.tg;
+			tg->funcs->program_manual_trigger(tg);
+			break;
+		case DCCG_UPDATE_DPP_DTO: {
+			const struct dccg_update_dpp_dto_params *p =
+					&entry->params.dccg_update_dpp_dto_params;
+
+			p->dccg->funcs->update_dpp_dto(p->dccg, p->dpp_inst,
+					p->dppclk_khz);
+			break;
+		}
+		case TG_PROGRAM_GLOBAL_SYNC: {
+			const struct tg_program_global_sync_params *p =
+					&entry->params.tg_program_global_sync_params;
+
+			p->tg->funcs->program_global_sync(p->tg, p->vready_offset,
+					p->vstartup_lines, p->vupdate_offset_pixels,
+					p->vupdate_vupdate_width_pixels,
+					p->pstate_keepout_start_lines);
+			break;
+		}
+		case TG_SET_VTG_PARAMS: {
+			const struct tg_set_vtg_params_params *p =
+					&entry->params.tg_set_vtg_params_params;
+
+			p->tg->funcs->set_vtg_params(p->tg, p->timing,
+					p->program_fp2);
+			break;
+		}
+		case TG_WAIT_FOR_ALL_PENDING_UPDATES:
+			dc2_bls_wait_for_all_pending_updates(&entry->params
+					.tg_wait_for_all_pending_updates_params);
+			break;
+		case DC_UDELAY:
+			udelay(entry->params.dc_udelay_params.us);
+			break;
+		case HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES: {
+			struct hubbub *hubbub = entry->params
+					.hubbub_force_wm_propagate_to_pipes_params
+					.hubbub;
+
+			hubbub->funcs->force_wm_propagate_to_pipes(hubbub);
+			break;
+		}
+		case HUBP_SETUP2: {
+			const struct hubp_setup2_params *p =
+					&entry->params.hubp_setup2_params;
+
+			p->hubp->funcs->hubp_setup2(p->hubp, p->hubp_regs,
+					p->global_sync, p->timing);
+			break;
+		}
+		case HUBP_SETUP_INTERDEPENDENT2: {
+			const struct hubp_setup_interdependent2_params *p =
+					&entry->params.hubp_setup_interdependent2_params;
+
+			p->hubp->funcs->hubp_setup_interdependent2(p->hubp,
+					p->hubp_regs);
+			break;
+		}
+		case HUBP_PROGRAM_MCACHE_ID: {
+			const struct program_mcache_id_and_split_coordinate *p =
+					&entry->params
+					.program_mcache_id_and_split_coordinate;
+
+			p->hubp->funcs->hubp_program_mcache_id_and_split_coordinate(
+					p->hubp, p->mcache_regs);
+			break;
+		}
+		case HUBP_PROGRAM_SURFACE_CONFIG:
+			dc2_bls_program_surface_config(&entry->params
+					.program_surface_config_params);
+			break;
+		case HUBP_UPDATE_PLANE_ADDR: {
+			const struct update_plane_addr_params *p =
+					&entry->params.update_plane_addr_params;
+
+			p->hubp->funcs->hubp_program_surface_flip_and_addr(p->hubp,
+					&p->address, p->flip_immediate, p->dcc);
+			break;
+		}
+		case HUBP_WAIT_FLIP_PENDING:
+			dc2_bls_wait_flip_pending(&entry->params
+					.hubp_wait_flip_pending_params);
+			break;
+		case HUBP_PROGRAM_3DLUT_FL_CONFIG: {
+			const struct hubp_program_3dlut_fl_config_params *p =
+					&entry->params
+					.hubp_program_3dlut_fl_config_params;
+
+			p->hubp->funcs->hubp_program_3dlut_fl_config(p->hubp,
+					p->config);
+			break;
+		}
+		case HUBP_SET_3DLUT_FL:
+			hubp = entry->params.hubp_set_3dlut_fl_params.hubp;
+			hubp->funcs->hubp_enable_3dlut_fl(hubp,
+					entry->params.hubp_set_3dlut_fl_params.enable);
+			break;
+		case DPP_SETUP_DPP: {
+			const struct setup_dpp_params *p =
+					&entry->params.setup_dpp_params;
+
+			p->dpp->funcs->dpp_setup(p->dpp, p->format,
+					EXPANSION_MODE_ZERO,
+					p->input_csc_color_matrix, p->color_space,
+					NULL, p->upsp_mode);
+			break;
+		}
+		case DPP_SET_CURSOR_MATRIX: {
+			const struct dpp_set_cursor_matrix_params *p =
+					&entry->params.dpp_set_cursor_matrix_params;
+
+			p->dpp->funcs->set_cursor_matrix(p->dpp, p->color_space,
+					*p->cursor_csc_color_matrix);
+			break;
+		}
+		case DPP_SET_PRE_DEGAM: {
+			const struct dpp_set_pre_degam_params *p =
+					&entry->params.dpp_set_pre_degam_params;
+
+			p->dpp->funcs->dpp_set_pre_degam(p->dpp,
+					p->in_transfer_func->type == TF_TYPE_PREDEFINED ?
+					p->in_transfer_func->tf :
+					TRANSFER_FUNCTION_UNITY);
+			break;
+		}
+		case DPP_PROGRAM_GAMCOR_LUT:
+			dpp = entry->params.dpp_program_gamcor_lut_params.dpp;
+			dpp->funcs->dpp_program_gamcor_lut(dpp,
+					entry->params.dpp_program_gamcor_lut_params
+					.params);
+			break;
+		case MPC_UPDATE_VISUAL_CONFIRM: {
+			const struct update_visual_confirm_params *p =
+					&entry->params.update_visual_confirm_params;
+
+			p->mpc->funcs->set_bg_color(p->mpc, p->color, p->mpcc_id);
+			break;
+		}
+		case MPC_SET_GAMUT_REMAP_BYPASS:
+			dc2_bls_set_gamut_remap_bypass(&entry->params
+					.mpc_set_gamut_remap_bypass_params);
+			break;
+		case MPC_SET_MOVABLE_CM_LOCATION: {
+			const struct mpc_set_movable_cm_location_params *p =
+					&entry->params
+					.mpc_set_movable_cm_location_params;
+
+			p->mpc->funcs->set_movable_cm_location(p->mpc, p->location,
+					p->mpcc_id);
+			break;
+		}
+		case MPC_PROGRAM_LUT_MODE: {
+			const struct mpc_program_lut_mode_params *p =
+					&entry->params.mpc_program_lut_mode_params;
+
+			p->mpc->funcs->program_lut_mode(p->mpc, p->id, p->enable,
+					p->lut_bank_a, p->size, p->mpcc_id);
+			break;
+		}
+		case MPC_SET_OUTPUT_GAMMA: {
+			const struct mpc_set_output_gamma_params *p =
+					&entry->params.mpc_set_output_gamma_params;
+
+			p->mpc->funcs->set_output_gamma(p->mpc, p->mpcc_id,
+					p->params);
+			break;
+		}
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 464a5b7810d9..85de12c558ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6790,6 +6790,7 @@ static const struct dc2_funcs dc2_legacy_funcs_table = {
 	.hardware_init = legacy_hardware_init,
 	.hardware_release = legacy_hardware_release,
 	.commit_state_hw = legacy_commit_state_hw,
+	.update_state_execute = legacy_update_state_execute,
 };
 
 const struct dc2_funcs *dc2_legacy_funcs(void)
@@ -8512,6 +8513,9 @@ bool dc_update_state_prepare(struct dc_update_scratch_space *scratch)
 	if (!dc_update_probes_prepare(scratch))
 		goto release_scratch;
 
+	if (!api_shim_update_state_supported(scratch))
+		goto release_scratch;
+
 	return true;
 
 release_scratch:
@@ -8520,9 +8524,7 @@ bool dc_update_state_prepare(struct dc_update_scratch_space *scratch)
 	return false;
 }
 
-void dc_update_state_execute(
-		const struct dc_update_scratch_space *scratch
-)
+void legacy_update_state_execute(const struct dc_update_scratch_space *scratch)
 {
 	if (scratch->stream)
 		scratch->update_v3
@@ -8533,6 +8535,13 @@ void dc_update_state_execute(
 		dc_update_probes_execute(scratch);
 }
 
+void dc_update_state_execute(
+		const struct dc_update_scratch_space *scratch
+)
+{
+	api_shim_update_state_execute(scratch);
+}
+
 bool dc_update_state_cleanup(
 		struct dc_update_scratch_space *scratch
 )
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 43bb5f461ef2..052f29df1797 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -7,6 +7,7 @@
 #include "dc.h"
 #include "core_types.h"
 #include "resource.h"
+#include "vm_helper.h"
 #include "dc_bios_types.h"
 #include "bls_builder/bls_builder.h"
 #include "bls_executor/bls_executor.h"
@@ -20,10 +21,17 @@ static void core2_hardware_release(struct dc *dc)
 	dc2_legacy_funcs()->hardware_release(dc);
 }
 
+static bool core2_update_state_supported(
+		const struct dc_update_scratch_space *scratch);
+static void core2_update_state_execute(
+		const struct dc_update_scratch_space *scratch);
+
 static const struct dc2_funcs core2_funcs_table = {
 	.hardware_init = core2_hardware_init,
 	.hardware_release = core2_hardware_release,
 	.commit_state_hw = core2_commit_state_hw,
+	.update_state_supported = core2_update_state_supported,
+	.update_state_execute = core2_update_state_execute,
 };
 
 const struct dc2_funcs *core2_funcs(void)
@@ -136,27 +144,69 @@ static void core2_commit_disable_done(struct dc *dc, struct pipe_ctx *pipe)
 	dc->optimized_required = true;
 }
 
-/* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
-enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
+/* Builds and runs one declarative builder from dc->current_state to new_state. */
+static enum dc_status core2_build_and_run(struct dc *dc,
+		enum bls_builder_name name, struct dc_state *new_state)
 {
-	const struct bls_builder *builder =
-			TO_DC2(dc)->builders[DCN_DECL_NON_SEAMLESS_COMMIT];
+	const struct bls_builder *builder = TO_DC2(dc)->builders[name];
 	const struct workaround_manager *wam = dc2_workaround_manager_get();
+	struct bls_builder_declarative_params *params;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	/* 256 block-sequence entries; keep them off the kernel stack. */
+	params = kvzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return DC_ERROR_UNEXPECTED;
+	params->dc = dc;
+	params->current_state = dc->current_state;
+	params->new_state = new_state;
+
+	/*
+	 * A tail runs on the vsync after the head, so Core would have to wait
+	 * for that vsync on the stream first. Core has no wait-for-vsync
+	 * imperative yet, so a builder that emits a tail is not supported.
+	 */
+	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS ||
+			params->tail_num_steps) {
+		status = DC_NOT_SUPPORTED;
+		goto out;
+	}
+	if (!core2_run_commit_sequence(dc, builder, wam,
+			params->head_sequence, &params->head_num_steps))
+		goto out;
+	status = DC_OK;
+
+out:
+	kvfree(params);
+	return status;
+}
+
+static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
+		struct dc_state *new_state)
+{
+	const struct bls_builder *builder = TO_DC2(dc)->builders[name];
 	struct bls_builder_check_capability_params check = {
 		.dc = dc,
 		.current_state = dc->current_state,
-		.new_state = context,
+		.new_state = new_state,
 	};
-	struct bls_builder_declarative_params *params;
+
+	return builder && builder->check_capability &&
+			builder->kind == BLS_BUILDER_DECLARATIVE &&
+			builder->build.declarative &&
+			dc2_workaround_manager_get() &&
+			builder->check_capability(&check) &&
+			core2_is_accelerated_mode(dc);
+}
+
+/* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
+enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
+{
 	struct pipe_ctx *old_pipe;
 	struct pipe_ctx *new_pipe;
-	enum dc_status status = DC_ERROR_UNEXPECTED;
+	enum dc_status status;
 
-	if (!builder || !builder->check_capability ||
-			builder->kind != BLS_BUILDER_DECLARATIVE ||
-			!builder->build.declarative || !wam ||
-			!builder->check_capability(&check) ||
-			!core2_is_accelerated_mode(dc))
+	if (!core2_builder_supports(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context))
 		return DC_NOT_SUPPORTED;
 
 	old_pipe = core2_otg_master(dc->current_state);
@@ -170,38 +220,114 @@ enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 	if (new_pipe)
 		resource_build_info_frame(new_pipe);
 
-	/* 128 block-sequence entries; keep them off the kernel stack. */
-	params = kvzalloc(sizeof(*params), GFP_KERNEL);
-	if (!params)
-		return DC_ERROR_UNEXPECTED;
-	params->dc = dc;
-	params->current_state = dc->current_state;
-	params->new_state = context;
-
-	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS) {
-		status = DC_NOT_SUPPORTED;
-		goto out;
-	}
-	if (!core2_run_commit_sequence(dc, builder, wam,
-			params->head_sequence, &params->head_num_steps))
-		goto out;
-	/*
-	 * The head ends with the ODM double-buffer and blank waits when it
-	 * programs an OTG. The tail is deferred until that head returns, so
-	 * it runs after double buffering completes.
-	 */
-	if (!core2_run_commit_sequence(dc, builder, wam,
-			params->tail_sequence, &params->tail_num_steps))
-		goto out;
+	status = core2_build_and_run(dc, DCN_DECL_NON_SEAMLESS_COMMIT, context);
+	if (status != DC_OK)
+		return status;
 
 	core2_commit_prepare_done(dc, context);
 	if (old_pipe)
 		core2_commit_disable_done(dc, old_pipe);
 	if (new_pipe)
 		core2_commit_enable_done(new_pipe);
-	status = DC_OK;
+	return DC_OK;
+}
 
-out:
-	kvfree(params);
-	return status;
+/*
+ * The stream update may move the stream's source and destination
+ * rectangles, which the new context already holds. Anything else asks
+ * for stream programming that the full update does not build.
+ */
+static bool core2_stream_update_supported(
+		const struct dc_stream_update *update)
+{
+	if (!update)
+		return true;
+	return !update->hdr_static_metadata && !update->abm_level &&
+			!update->periodic_interrupt &&
+			!update->vrr_infopacket && !update->vsc_infopacket &&
+			!update->vsp_infopacket && !update->hfvsif_infopacket &&
+			!update->vtem_infopacket &&
+			!update->adaptive_sync_infopacket &&
+			!update->avi_infopacket && !update->dpms_off &&
+			!update->gamut_remap && !update->output_color_space &&
+			!update->dither_option &&
+			!update->output_csc_transform && !update->dsc_config &&
+			!update->mst_bw_update && !update->func_shaper &&
+			!update->lut3d_func && !update->pending_test_pattern &&
+			!update->crtc_timing_adjust &&
+			!update->cursor_attributes && !update->cursor_position &&
+			!(update->wb_update && update->wb_update->num_wb_info);
+}
+
+static bool core2_update_state_supported(
+		const struct dc_update_scratch_space *scratch)
+{
+	/* Probes and v2 updates have no DC2 path. */
+	if (!scratch->stream || !scratch->update_v3 || scratch->probe_updates)
+		return false;
+	/*
+	 * Only a full update on a new context has a builder. A context-full
+	 * flow keeps dc->current_state, so its update type is below FULL.
+	 */
+	if (scratch->update_type != UPDATE_TYPE_FULL ||
+			scratch->flow != UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS)
+		return false;
+	/* The full-update builder adds one plane. */
+	if (scratch->surface_count != 1)
+		return false;
+	if (!core2_stream_update_supported(scratch->stream_update))
+		return false;
+	return core2_builder_supports(scratch->dc, DCN_DECL_SEAMLESS_UPDATE,
+			scratch->new_context);
+}
+
+/*
+ * The software state commit_planes_for_stream writes while it programs
+ * the plane. The swap to the new context stays in
+ * dc_update_state_cleanup.
+ */
+static void core2_update_done(struct dc *dc, struct dc_state *context)
+{
+	struct pipe_ctx *pipe = core2_otg_master(context);
+	struct dc_plane_state *plane;
+	struct hubp *hubp;
+
+	if (!pipe || !pipe->plane_state || !pipe->plane_res.hubp ||
+			!pipe->stream_res.opp)
+		return;
+	plane = pipe->plane_state;
+	hubp = pipe->plane_res.hubp;
+
+	vm_helper_mark_vmid_used(dc->vm_helper, plane->address.vmid,
+			(uint8_t)hubp->inst);
+	plane->status.requested_address = plane->address;
+	hubp->opp_id = pipe->stream_res.opp->inst;
+	hubp->mpcc_id = hubp->inst;
+	hubp->power_gated = false;
+	core2_commit_prepare_done(dc, context);
+}
+
+static void core2_update_state_execute(
+		const struct dc_update_scratch_space *scratch)
+{
+	struct dc *dc = scratch->dc;
+	struct dc_state *context = scratch->new_context;
+	struct pipe_ctx *pipe = core2_otg_master(context);
+
+	/*
+	 * The values DC1 computes into the context before it programs the
+	 * plane. The builder reads them from the context.
+	 */
+	if (!pipe || !pipe->plane_state)
+		return;
+	if (dc->res_pool->funcs->prepare_mcache_programming)
+		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
+	pipe->plane_res.scl_data.lb_params.alpha_en =
+			pipe->plane_state->per_pixel_alpha;
+
+	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context) != DC_OK) {
+		ASSERT(false);
+		return;
+	}
+	core2_update_done(dc, context);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
index eca9b2de92fa..5d7117501428 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
@@ -5,6 +5,7 @@
 
 #include "dm_services.h"
 #include "dc.h"
+#include "core_types.h"
 #include "dc_api_dispatch/api_shim.h"
 #include "core2/dc_core2.h"
 #include "inc/dc_core_interface.h"
@@ -37,3 +38,20 @@ enum dc_status api_shim_commit_state_hw(struct dc *dc, struct dc_state *context)
 		return core2_funcs()->commit_state_hw(dc, context);
 	return legacy_commit_state_hw(dc, context);
 }
+
+bool api_shim_update_state_supported(
+		const struct dc_update_scratch_space *scratch)
+{
+	if (TO_DC2(scratch->dc)->selection == DC2_SELECTION_CORE2)
+		return core2_funcs()->update_state_supported(scratch);
+	return true;
+}
+
+void api_shim_update_state_execute(
+		const struct dc_update_scratch_space *scratch)
+{
+	if (TO_DC2(scratch->dc)->selection == DC2_SELECTION_CORE2)
+		core2_funcs()->update_state_execute(scratch);
+	else
+		legacy_update_state_execute(scratch);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
index 6d9ad4192296..93dd2d47c8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -24,3 +24,7 @@ struct dc2 {
 
 void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params);
 enum dc_status api_shim_commit_state_hw(struct dc *dc, struct dc_state *context);
+bool api_shim_update_state_supported(
+		const struct dc_update_scratch_space *scratch);
+void api_shim_update_state_execute(
+		const struct dc_update_scratch_space *scratch);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a6c743d0cc58..6996ce12a17d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -423,6 +423,68 @@ struct bios_set_scratch_critical_state_params {
 	bool state;
 };
 
+struct tg_wait_for_all_pending_updates_params {
+	struct timing_generator *tg;
+	bool include_pipe_update;
+	unsigned int polling_interval_us;
+	unsigned int timeout_us;
+};
+
+struct dc_udelay_params {
+	unsigned int us;
+};
+
+struct hubbub_force_wm_propagate_to_pipes_params {
+	struct hubbub *hubbub;
+};
+
+struct mpc_set_gamut_remap_bypass_params {
+	struct mpc *mpc;
+	int mpcc_id;
+	enum mpcc_gamut_remap_id block_id;
+};
+
+struct mpc_set_movable_cm_location_params {
+	struct mpc *mpc;
+	enum mpcc_movable_cm_location location;
+	int mpcc_id;
+};
+
+struct mpc_program_lut_mode_params {
+	struct mpc *mpc;
+	enum MCM_LUT_ID id;
+	bool enable;
+	bool lut_bank_a;
+	enum dc_cm_lut_size size;
+	int mpcc_id;
+};
+
+struct mpc_set_output_gamma_params {
+	struct mpc *mpc;
+	int mpcc_id;
+	const struct pwl_params *params;
+};
+
+struct dpp_set_pre_degam_params {
+	struct dpp *dpp;
+	const struct dc_transfer_func *in_transfer_func;
+};
+
+struct dpp_program_gamcor_lut_params {
+	struct dpp *dpp;
+	const struct pwl_params *params;
+};
+
+struct hubp_program_3dlut_fl_config_params {
+	struct hubp *hubp;
+	const struct dc_3dlut_dma *config;
+};
+
+struct hubp_set_3dlut_fl_params {
+	struct hubp *hubp;
+	bool enable;
+};
+
 struct lsdma_send_pio_copy_params {
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint64_t src_addr;
@@ -1525,6 +1587,22 @@ union block_sequence_params {
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
+	struct tg_wait_for_all_pending_updates_params
+			tg_wait_for_all_pending_updates_params;
+	struct dc_udelay_params dc_udelay_params;
+	struct hubbub_force_wm_propagate_to_pipes_params
+			hubbub_force_wm_propagate_to_pipes_params;
+	struct mpc_set_gamut_remap_bypass_params
+			mpc_set_gamut_remap_bypass_params;
+	struct mpc_set_movable_cm_location_params
+			mpc_set_movable_cm_location_params;
+	struct mpc_program_lut_mode_params mpc_program_lut_mode_params;
+	struct mpc_set_output_gamma_params mpc_set_output_gamma_params;
+	struct dpp_set_pre_degam_params dpp_set_pre_degam_params;
+	struct dpp_program_gamcor_lut_params dpp_program_gamcor_lut_params;
+	struct hubp_program_3dlut_fl_config_params
+			hubp_program_3dlut_fl_config_params;
+	struct hubp_set_3dlut_fl_params hubp_set_3dlut_fl_params;
 };
 
 enum block_sequence_func {
@@ -1754,6 +1832,17 @@ enum block_sequence_func {
 	DIO_LINK_ENC_ENABLE_DP_OUTPUT,
 	DIO_LINK_ENC_DISABLE_OUTPUT,
 	BIOS_SET_SCRATCH_CRITICAL_STATE,
+	TG_WAIT_FOR_ALL_PENDING_UPDATES,
+	DC_UDELAY,
+	HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES,
+	MPC_SET_GAMUT_REMAP_BYPASS,
+	MPC_SET_MOVABLE_CM_LOCATION,
+	MPC_PROGRAM_LUT_MODE,
+	MPC_SET_OUTPUT_GAMMA,
+	DPP_SET_PRE_DEGAM,
+	DPP_PROGRAM_GAMCOR_LUT,
+	HUBP_PROGRAM_3DLUT_FL_CONFIG,
+	HUBP_SET_3DLUT_FL,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
index 383d14af91f1..4cd01e34a959 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
@@ -9,6 +9,7 @@
 
 struct dc;
 struct dc_state;
+struct dc_update_scratch_space;
 
 /*
  * Construction-time Core implementation selection. Zero is LEGACY so existing
@@ -28,9 +29,15 @@ struct dc2_funcs {
 	void (*hardware_init)(struct dc *dc);
 	void (*hardware_release)(struct dc *dc);
 	enum dc_status (*commit_state_hw)(struct dc *dc, struct dc_state *context);
+	/* Checked in prepare; execute returns void, so it cannot reject. */
+	bool (*update_state_supported)(
+			const struct dc_update_scratch_space *scratch);
+	void (*update_state_execute)(
+			const struct dc_update_scratch_space *scratch);
 };
 
 void legacy_hardware_init(struct dc *dc);
 void legacy_hardware_release(struct dc *dc);
 enum dc_status legacy_commit_state_hw(struct dc *dc, struct dc_state *context);
+void legacy_update_state_execute(const struct dc_update_scratch_space *scratch);
 const struct dc2_funcs *dc2_legacy_funcs(void);
-- 
2.43.0

