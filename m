Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B65606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zMfCVdsu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28E810F8B0;
	Wed, 11 Nov 2026 01:41:03 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A7710F8B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpcbiz3fe67Sq1FK2d6iTCRbHwF7u5orhE5Oyj6Xz16LjLUgij9nVznabCJpU9IpYedbGXxtNind0EirBDHs6Sbp8qaGUsSDYa1bsaLvHddDO2g9tMfdQbuNJBEYnw/VxEXe7v+Uq3dz1CVbl5oFQ8dVu94csOTINPcUcUis9YM3W/KGMeldbtnOorWdeICEhWvPucJ0pA/uJBS/Z/81ruqKXUKEUUK4c17mZVz8/8Irlb7Ys+dj9jjrM1Ryq8iNChxQKYxLQWFxotna+FtkHTYJFx7cn5kTkPK4R+1T6hIngC9MuL6aN9gj7B23urVO37th1njLeGpbbEWFct80UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZu06d+PUz7TNFMSp1TBwiCQPZ9byJGmn4gp9mgPW7k=;
 b=L+CDsdVxiaGbazB5/oHG6gG3dEzEXADsLpEg8VuGUNdkcmMWW4QeCFriZV8x37t8A+oS62lBBcawWzV9Y3Uua9voQz4pk9cQDJaCgcaxELdtfIxdRFpqhEEjJoKOiHk+4q5D2dUk8wy8qpp2oDnHP4X2xd0r3Yn+BYzlp05JBIksYgS+Eht2nnWUnwvGCxUa4MKyjxdHiRMGbUX4RXtE52tIdL2r9d4UgGCkG1/z+dmGVLjDjgykwxy/fHE4FXJPAPALypb+bzmqstH1An6RkgJvLXlye7t1MJz5q3ADTc1ifBJ1PQ0G69ZX27JGC3qEuR5yF46Aj60p4SY85VXzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZu06d+PUz7TNFMSp1TBwiCQPZ9byJGmn4gp9mgPW7k=;
 b=zMfCVdsucO3eie5Kpn3e0ZJwq6jdK/qCQ+QQ5+pyW8Mh2IPxUpZ9kiC9vWpjSBJabiMqFWRmMuxWw0LTimCSifdNn05mDskU3mFYUeiDwUHHquYZ40xIJXhZGhlSn91UrkfVd/dJPcl7Ear8mcU64jogG0aMBwJzq3k5zzbg8DI=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 01:40:51 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::45) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:50 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:46 -0600
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
Subject: [PATCH 07/74] drm/amd/display: Build the dcn401 virtual commit
 natively
Date: Wed, 11 Nov 2026 09:28:13 +0800
Message-ID: <20261111014100.3596072-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cca38dc-dbd5-45d1-5ef0-08df3f94d181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|6133799003|3023799007|10067099003|261009221727099003|11063799006|5023799004|261028144727099003|261026140227099003|261026121527099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261009223327099003|261009220027099003|261102123227099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: nUhNXBdbfO2kmoBfIAC0ncTU/zH/u54VCpzeV6Ei0zSMK7PpWuSOrtObQpDLwKbRSENBXTDLXL1EE7clGI5md1NPkOSOPbkr8Ocr0qwkiZwjKu3/mVjC4HDpjtyzT/aQ1PX5dJZ1AepQEMo4get1D6QuG6a+MET8a44Ir0tjitwUaIqszIOiPShntP2I2HiwtEHwHokJHOTBgcxDV2z/nAJAhymZUbfvaFFbSP2KvZjomgXhoaqXZ/cSI3l4oX7y4g5yOpXT5/nWiXOYh2oaJZ1BENvzb6C1RedncoeCwzg3Pevy5r3j3tGjkn8hmq4sP8Lbm/mzagnsjSr+h1ZVZZdXYEO6PsHvzC4agoRNk0fKcPRrIKSoz2sHQNgPFcIGt+WL3MunlCAUwdBsyHPujLBXiGligX7iwp9S3i5kY+JXcJ7i+ZDWnwPvrXpXskHWXeO03QijoFxj51g/868FD2xAjcqBqwQ5JY/Uug9kcd+A0jfOC13apssnn09zmhAvSlWKS6ZcdE5btnvK2GQz9epPXHwmSPi1dgxWLmAM6ckyVjx6a664/XQZypnnYbH89RZlg71HHp1NJgMd3uSSM60BGHkaSvUUgxa4lB1e48M9TSS6h4kugxYwKjDNDh3kHCfOvPiV8erA4idDhbb6YpA5p62o2hme2zAID3yk745CIq6nBK25YuuzTa0yhKjfHLsxDDcVNJKcmg2wx69uMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261009221727099003)(11063799006)(5023799004)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261102123227099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gxubQrcRr8OEThKHPihvzD0gN8qJouJoL4SPt8KHWkRZumq0TX/3Q75SU39hcwpI7+IeEA+A6RFpCeJc7uzyZnSAA1rWS03We+Jn/96ADmfk2T9um4cQab456r1hkHc6SK0oizrdkX6Nk8tYiLoQ/tW24kjxOT7dAe250FhWSOoog6jPWWn1dujQUzNkJV7EXODhKH7QtWfCbm2CwBs5/jACg8o62faoTgWYNfNV/FQyD8hYlKUX0AOhE/qNq2yy9Sun6KnZ/GABEUrVokHoS6fXQU9kY74nR74PBqHYvQw+WP70Lg7ziHAqH3mX0Le5oowuJE9EXyc+fjCrs0rWProVsGGACoOHBqMolEu/U8GoKkvC1GoCpOkGvAaEDog9aTs575akNZ+G8tcNmq6QMAHKAfNzx4kH9uncA7yw/Oep35OjiIno+qFMmdkhvOLk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:51.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cca38dc-dbd5-45d1-5ef0-08df3f94d181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

core2_commit_state_hw returns DC_NOT_SUPPORTED for every state, so
selecting Core2 cannot light a display. Start the native commit
with the smallest transition: one virtual stream.

Register a declarative non-seamless commit builder for dcn401. Its
support check covers no stream to no stream, no stream to one
stream with no plane, and one stream with one plane back to no
stream. A stream is never in both states. The stream must be
virtual, one pipe, RGB and sRGB, with no audio, DSC, ODM, MPO,
stereo, DRR or seamless boot. FAMS2, visual confirm and the DSC
power gate must be off. On stream-off the plane's MPCC must be the
only one in the OPP tree. link_set_dpms_on and link_set_dpms_off
program nothing for a virtual signal, so a virtual stream is
rejected here, and only a commit with no stream in either state is
built. Anything else returns DC_NOT_SUPPORTED.

Emit the leaf calls legacy_commit_state_hw makes on dcn401, in
that order. Leave out dcn10_setup_stereo's generic GPIO mux: it
routes no signal for a virtual stream. Skip dig_connect_to_otg for
virtual, as DC1 does. The head runs through the ODM double-buffer
and blank waits. The tail is only the deferred bandwidth lower,
plus a p-state release when no OTG master released it, and it
runs after the head returns so that double buffer can complete at
vupdate.

The steps are static arrays named for where they land, not for
stream-on or stream-off. skip_if carries "stream mode unchanged"
and "new state has a stream", so those conditions are data instead
of branches. Parameters come from the validated state. The support
check requires an OTG master for each stream, and both sequences
fit in DC2_BLS_MAX_STEPS, so building the list has no error path.
A failed check logs which condition failed with DC_LOG_DEBUG.

If the VBIOS scratch still says VBIOS mode, return
DC_NOT_SUPPORTED. This builder has no accelerated-mode entries,
and dcn401_init_hw leaves VBIOS mode only when
debug.disable_boot_optimizations is set. On success, write the
software state DC1 writes. A failed build returns
DC_NOT_SUPPORTED, a failed execution returns DC_ERROR_UNEXPECTED,
and neither writes that state or falls back to DC1.

Do not call set_wait_for_update_needed_for_pipe. It is an hwss
helper that reads the OTG, and this commit stays on leaf calls.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 +
 .../amd/display/dc/bls_builder/bls_builder.h  |    1 +
 .../dc/bls_builder/bls_builder_internal.h     |    1 +
 .../bls_builder/bls_builder_private_types.h   |   72 +
 .../dc/bls_builder/dcn401_commit_builder.c    | 1256 +++++++++++++++++
 .../dc/bls_builder/dcn401_init_builder.c      |    2 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  164 ++-
 7 files changed, 1494 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 84c55a253ebc..ec3ef6ed6ed4 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -86,6 +86,7 @@ FILES += core2/dc_core2.o
 FILES += core2/dc_core2_init.o
 FILES += core2/dc_core2_legacy_init.o
 FILES += bls_builder/bls_builder.o
+FILES += bls_builder/dcn401_commit_builder.o
 FILES += bls_builder/dcn401_init_builder.o
 FILES += bls_builder/dcn401_init_builder_legacy.o
 FILES += bls_executor/bls_executor.o
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 422ee25cf348..485e877df5d2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -24,6 +24,7 @@ enum bls_builder_result {
 enum bls_builder_name {
 	DCN_DECL_INITIALIZATION,
 	DCN_DECL_INITIALIZATION_LEGACY,
+	DCN_DECL_NON_SEAMLESS_COMMIT,
 	BLS_BUILDER_NAME_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
index 216879c93f9e..a641941a2f2f 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
@@ -9,3 +9,4 @@
 
 const struct bls_builder *dcn401_bls_builder_create(
 		enum bls_builder_name name);
+const struct bls_builder *dcn401_non_seamless_commit_builder(void);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
new file mode 100644
index 000000000000..025b2e3b62ad
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "hw_sequencer.h"
+#include "dccg.h"
+
+/*
+ * Step tables for the declarative builders. A change here changes what
+ * a builder can express; a change to a builder's .c alone does not.
+ */
+
+/*
+ * One dcn401 commit step is one BLS entry. The union holds the
+ * arguments that differ between the times DC1 makes that call; the
+ * rest come from the state. skip_if names when the step is left out.
+ */
+struct dcn401_commit_step_meta {
+	union {
+		struct {
+			bool safe_to_lower;
+		} clk_mgr_update_clocks_for_state;
+		struct {
+			bool safe_to_lower;
+		} hubbub_program_watermarks;
+		struct {
+			bool safe_to_lower;
+		} hubbub_program_arbiter;
+		struct {
+			bool safe_to_lower;
+		} hubbub_program_compbuf_segments;
+		struct {
+			bool state;
+		} bios_set_scratch_critical_state;
+		struct {
+			bool lock;
+		} tg_lock;
+		struct {
+			bool enable;
+		} tg_enable_optc_clock;
+		struct {
+			bool from_adjust;
+			bool with_mid;
+		} tg_set_drr;
+		struct {
+			enum streamclk_source src;
+		} dccg_set_dtbclk_p_src;
+		struct {
+			enum pixel_rate_div k1;
+		} dccg_set_pixel_rate_div;
+		struct {
+			bool connect;
+		} link_enc_connect_dig_be_to_fe;
+		struct {
+			bool enable;
+		} dc_ip_request_cntl;
+	};
+	struct {
+		/* The OTG master's stream has mode_changed clear. */
+		bool stream_mode_unchanged;
+		/* The new state has a stream. */
+		bool new_state_has_stream;
+	} skip_if;
+};
+
+struct dcn401_commit_step {
+	enum block_sequence_func func;
+	struct dcn401_commit_step_meta meta;
+};
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
new file mode 100644
index 000000000000..340d1aec2f4c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -0,0 +1,1256 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "link_encoder.h"
+#include "stream_encoder.h"
+#include "clk_mgr.h"
+#include "dccg.h"
+#include "dc_bios_types.h"
+#include "dc_dmub_srv.h"
+#include "bls_builder/bls_builder_internal.h"
+#include "bls_builder/dcn401_init_builder.h"
+#include "bls_builder/bls_builder_private_types.h"
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+	dc->ctx->logger
+
+/*
+ * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
+ * The new state has no stream, or one stream with no plane; the current
+ * state has no stream, or one stream with one plane. A plane is added
+ * later by commit_planes, not by this commit.
+ *
+ * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
+ * calls in the same order, including the calls DC1 repeats. head_sequence
+ * holds everything through the ODM double-buffer and blank waits.
+ * tail_sequence is the deferred bandwidth lower, and it runs only after
+ * that head has finished.
+ */
+
+#define DCN401_DPG_POLL_INTERVAL_US 100
+#define DCN401_DPG_POLL_TIMEOUT_US 100000
+#define DCN401_STATIC_SCREEN_NUM_FRAMES 2
+
+/*
+ * Each helper takes the same arguments. CHECK_CONDITION logs the reason
+ * and returns. current_state or new_state is NULL when the helper looks
+ * at only one of them.
+ */
+
+static void dcn401_commit_check_failed(const struct dc *dc, const char *msg)
+{
+	if (dc && dc->ctx && dc->ctx->logger)
+		DC_LOG_DEBUG("%s\n", msg);
+}
+
+#define CHECK_CONDITION(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
+		} \
+	} while (0)
+
+#define CHECK_RESOURCE(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING; \
+		} \
+	} while (0)
+
+static const struct dc_state *dcn401_checked_state(
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	return current_state ? current_state : new_state;
+}
+
+static bool check_dc_resources(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return dc->res_pool && dc->res_pool->hubbub && dc->res_pool->dccg &&
+			dc->res_pool->mpc && dc->hwseq && dc->clk_mgr &&
+			dc->ctx && dc->ctx->dc_bios;
+}
+
+static bool check_fams2_debug(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->debug.fams2_config.bits.enable;
+}
+
+static bool check_cursor_offload(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->ctx->dmub_srv || !dc->ctx->dmub_srv->cursor_offload_enabled;
+}
+
+static bool check_dc_mode_softmax(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->clk_mgr->dc_mode_softmax_enabled;
+}
+
+static bool check_visual_confirm(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE &&
+			!dc->debug.force_dpg_on_flip &&
+			!dc->debug.enable_hblank_borrow &&
+			!dc->debug.enable_otg_frame_sync_pwa;
+}
+
+/* With the DSC power gate disabled, update_dsc_pg only reads. */
+static bool check_dsc_power_gate(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return dc->debug.disable_dsc_power_gate;
+}
+
+static bool check_stream_config_update(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->ctx->cp_psp.funcs.update_stream_config;
+}
+
+static bool check_one_stream(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+
+	(void)dc;
+	return state->stream_count <= 1 && !state->phantom_stream_count;
+}
+
+static bool check_fams2_state(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+
+	(void)dc;
+	return !state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+}
+
+static bool check_stream_link(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+	const struct dc_stream_state *stream = state->streams[0];
+
+	(void)dc;
+	return stream && stream->link;
+}
+
+/* link_set_dpms_on and _off program nothing for a virtual signal. */
+static bool check_virtual_signal(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+
+	(void)dc;
+	(void)state;
+	return false;
+}
+
+static bool check_link_encoder(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_link *link = dcn401_checked_state(current_state,
+			new_state)->streams[0]->link;
+
+	(void)dc;
+	return link->ep_type == DISPLAY_ENDPOINT_PHY && link->link_enc;
+}
+
+static bool check_timing_flags(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_crtc_timing *timing = &dcn401_checked_state(
+			current_state, new_state)->streams[0]->timing;
+
+	(void)dc;
+	return !timing->flags.DSC && !timing->flags.INTERLACE &&
+			timing->timing_3d_format == TIMING_3D_FORMAT_NONE;
+}
+
+/* The DPG black and the pixel rate divider are fixed for RGB. */
+static bool check_rgb_srgb(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_stream_state *stream = dcn401_checked_state(
+			current_state, new_state)->streams[0];
+
+	(void)dc;
+	return stream->timing.pixel_encoding == PIXEL_ENCODING_RGB &&
+			stream->output_color_space == COLOR_SPACE_SRGB;
+}
+
+static bool check_no_drr(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_stream_state *stream = dcn401_checked_state(
+			current_state, new_state)->streams[0];
+
+	(void)dc;
+	return !stream->ignore_msa_timing_param &&
+			!stream->adjust.v_total_min &&
+			!stream->adjust.v_total_max;
+}
+
+static bool check_no_boot_dpms_writeback(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_stream_state *stream = dcn401_checked_state(
+			current_state, new_state)->streams[0];
+
+	(void)dc;
+	return !stream->apply_seamless_boot_optimization && !stream->dpms_off &&
+			!stream->num_wb_info;
+}
+
+static bool check_abm(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_stream_state *stream = dcn401_checked_state(
+			current_state, new_state)->streams[0];
+
+	(void)dc;
+	return !stream->abm_level ||
+			stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE;
+}
+
+static bool check_plane_count(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+	/*
+	 * The current state carries the removed plane. The new state has
+	 * none.
+	 */
+	bool has_plane = current_state != NULL;
+
+	(void)dc;
+	return state->stream_status[0].plane_count == (has_plane ? 1 : 0);
+}
+
+/* The pipe for this state's one stream, or NULL when it is not exactly one. */
+static const struct pipe_ctx *dcn401_state_otg_master(
+		const struct dc_state *state, bool *not_one_pipe)
+{
+	const struct pipe_ctx *otg_master = NULL;
+	unsigned int i;
+
+	*not_one_pipe = false;
+	for (i = 0; i < MAX_PIPES; i++) {
+		const struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+		if (pipe->stream != state->streams[0] || otg_master) {
+			*not_one_pipe = true;
+			return NULL;
+		}
+		otg_master = pipe;
+	}
+	return otg_master;
+}
+
+static const struct pipe_ctx *dcn401_checked_otg_master(
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	bool not_one_pipe = false;
+
+	return dcn401_state_otg_master(dcn401_checked_state(current_state,
+			new_state), &not_one_pipe);
+}
+
+static bool check_one_otg_pipe(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	bool not_one_pipe = false;
+
+	(void)dc;
+	dcn401_state_otg_master(dcn401_checked_state(current_state, new_state),
+			&not_one_pipe);
+	return !not_one_pipe;
+}
+
+static bool check_otg_master_present(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	return dcn401_checked_otg_master(current_state, new_state) != NULL;
+}
+
+static bool check_odm_combine(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && !pipe->next_odm_pipe && !pipe->prev_odm_pipe;
+}
+
+static bool check_mpc_blend(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && !pipe->top_pipe && !pipe->bottom_pipe;
+}
+
+static bool check_pipe_plane(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+	/*
+	 * The current state carries the removed plane. The new state has
+	 * none.
+	 */
+	bool has_plane = current_state != NULL;
+
+	(void)dc;
+	return pipe && !!pipe->plane_state == has_plane;
+}
+
+static bool check_otg_master_blocks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && pipe->stream_res.tg && pipe->stream_res.opp &&
+			pipe->stream_res.stream_enc && pipe->clock_source;
+}
+
+static bool check_plane_blocks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	if (!current_state)
+		return true;
+	return pipe && pipe->plane_res.hubp && pipe->plane_res.dpp &&
+			pipe->plane_res.mpcc_inst < MAX_MPCC;
+}
+
+static bool check_mpcc_alone(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+	const struct mpcc *mpcc;
+
+	if (!current_state)
+		return true;
+	if (!pipe || !dc->res_pool || !dc->res_pool->mpc)
+		return false;
+	mpcc = &dc->res_pool->mpc->mpcc_array[pipe->plane_res.mpcc_inst];
+	/* The removed MPCC must be the only one in the OPP's tree. */
+	return pipe->stream_res.opp->mpc_tree_params.opp_list == mpcc &&
+			!mpcc->mpcc_bot &&
+			mpcc->dpp_id == pipe->plane_res.dpp->inst;
+}
+
+static bool check_pipe_audio(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && !pipe->stream_res.audio;
+}
+
+static bool check_pipe_dsc(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && !pipe->stream_res.dsc;
+}
+
+static bool check_pipe_gsl(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	(void)dc;
+	return pipe && !pipe->stream_res.gsl_group;
+}
+
+static bool check_link_enc_assignment(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
+			new_state);
+
+	if (!dc->config.unify_link_enc_assignment)
+		return true;
+	return pipe && pipe->link_res.dio_link_enc ==
+			pipe->stream->link->link_enc;
+}
+
+static enum bls_builder_result dcn401_check_commit_state_support(
+		const struct dc *dc, const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+
+	if (!state)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	CHECK_CONDITION(one_stream, "more than one stream");
+	CHECK_CONDITION(fams2_state, "fams2 is enabled");
+	if (!state->stream_count)
+		return BLS_BUILD_SUCCESS;
+
+	CHECK_RESOURCE(stream_link, "stream has no link");
+	CHECK_CONDITION(virtual_signal, "signal is not virtual");
+	CHECK_RESOURCE(link_encoder, "link encoder is not DIO");
+	CHECK_CONDITION(timing_flags, "timing is DSC, interlace, or stereo");
+	CHECK_CONDITION(rgb_srgb, "stream is not RGB sRGB");
+	CHECK_CONDITION(no_drr, "DRR is set");
+	CHECK_CONDITION(no_boot_dpms_writeback,
+			"seamless boot, dpms, or writeback is set");
+	CHECK_CONDITION(abm, "ABM level is set");
+	CHECK_CONDITION(plane_count, "plane count does not match the state");
+	CHECK_CONDITION(one_otg_pipe, "stream is not on one pipe");
+	CHECK_RESOURCE(otg_master_present, "stream has no otg master");
+	CHECK_CONDITION(odm_combine, "odm is set");
+	CHECK_CONDITION(mpc_blend, "top or bottom pipe is set");
+	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
+	CHECK_RESOURCE(otg_master_blocks, "otg master is missing a block");
+	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
+	CHECK_CONDITION(mpcc_alone, "mpcc is not alone in the opp tree");
+	CHECK_CONDITION(pipe_audio, "audio is set");
+	CHECK_CONDITION(pipe_dsc, "dsc is set");
+	CHECK_CONDITION(pipe_gsl, "gsl is set");
+	CHECK_CONDITION(link_enc_assignment, "link encoder assignment differs");
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool check_stream_not_kept(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	/* A stream is either removed or added, never kept. */
+	return !current_state->stream_count || !new_state->stream_count;
+}
+
+static bool check_link_not_active(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	if (!new_state->stream_count)
+		return true;
+	return !new_state->streams[0]->link->link_status.link_active;
+}
+
+static enum bls_builder_result dcn401_check_non_seamless_commit_support(
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
+	CHECK_CONDITION(visual_confirm, "visual confirm, dpg, hblank borrow, "
+			"or frame sync is set");
+	CHECK_CONDITION(dsc_power_gate, "DSC power gate is enabled");
+	CHECK_CONDITION(stream_config_update, "stream config update is set");
+
+	result = dcn401_check_commit_state_support(dc, current_state, NULL);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+	result = dcn401_check_commit_state_support(dc, NULL, new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	CHECK_CONDITION(stream_not_kept, "stream is kept across the commit");
+	CHECK_CONDITION(link_not_active, "link is already active");
+	return BLS_BUILD_SUCCESS;
+}
+
+static struct pipe_ctx *get_otg_master_from_state_by_stream(
+		struct dc_state *state, const struct dc_stream_state *stream)
+{
+	unsigned int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (state->res_ctx.pipe_ctx[i].stream == stream)
+			return &state->res_ctx.pipe_ctx[i];
+	}
+	return NULL;
+}
+
+/*
+ * Net effect: dcn401_prepare_bandwidth without FAMS2, SubVP or DC-mode
+ * softmax.
+ */
+static const struct dcn401_commit_step bls_head_per_state_new[] = {
+	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
+	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_WATERMARKS,
+	  .meta.hubbub_program_watermarks.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_ARBITER,
+	  .meta.hubbub_program_arbiter.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = false },
+};
+
+/*
+ * Net effect: disable the stream of the current state.
+ * - disable_dangling_plane: disconnect the MPCC under the OTG lock, then
+ *   dcn20_disable_plane.
+ * - link_set_dpms_off for the virtual signal: dcn401_disable_stream, then
+ *   disable_link, which disables the output as DisplayPort.
+ * - dcn401_reset_back_end_for_pipe after link_set_dpms_off, then the
+ *   clock source power-down from dcn401_reset_hw_ctx_wrap.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
+	{ .func = MPC_REMOVE_MPCC },
+	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+	{ .func = MPC_ASSERT_IDLE_MPCC },
+	{ .func = HUBP_SET_BLANK },
+	{ .func = HUBP_UPDATE_MALL_SEL },
+	{ .func = HUBP_SET_FLIP_CONTROL_GSL },
+	{ .func = HUBP_CLK_CNTL },
+	{ .func = DPP_DPPCLK_CONTROL },
+	/*
+	 * dcn10_plane_atomic_power_down sets IP_REQUEST_EN only when it
+	 * reads 0. Every writer clears it again, so it always reads 0 here.
+	 */
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
+	{ .func = HUBP_PG_CONTROL },
+	{ .func = HUBP_RESET },
+	{ .func = DPP_RESET },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+
+	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
+	  .meta.link_enc_connect_dig_be_to_fe.connect = false },
+	{ .func = DCCG_DISABLE_SYMCLK_SE },
+	{ .func = DIO_LINK_ENC_DISABLE_OUTPUT },
+
+	{ .func = TG_DISABLE_CRTC },
+	{ .func = TG_ENABLE_OPTC_CLOCK,
+	  .meta.tg_enable_optc_clock.enable = false },
+	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = TG_SET_DRR },
+	/* link_set_dpms_off disabled the output already. */
+	{ .func = DCCG_SET_DTBCLK_P_SRC,
+	  .meta.dccg_set_dtbclk_p_src.src = REFCLK },
+	{ .func = CLK_SRC_POWER_DOWN },
+};
+
+/*
+ * Net effect: enable the stream of the new state. Between the BIOS
+ * critical-state calls:
+ * - dcn401_enable_stream_timing plus the dce110_apply_single_controller
+ *   calls around it, up to the DIG connect.
+ * - link_set_dpms_on for the virtual signal: enable_link_virtual, then
+ *   dcn401_enable_stream. The virtual stream encoder has no enable, map,
+ *   input-mode or FIFO funcs, and update_info_frame programs nothing.
+ *   DC1 skips dig_connect_to_otg for the virtual signal.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_new[] = {
+	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
+	  .meta.bios_set_scratch_critical_state.state = true },
+
+	{ .func = OPP_PROGRAM_FMT },
+	{ .func = OPP_SET_DYN_EXPANSION },
+	{ .func = DCCG_SET_PIXEL_RATE_DIV,
+	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_4 },
+	{ .func = DCCG_SET_DTBCLK_P_SRC,
+	  .meta.dccg_set_dtbclk_p_src.src = DPREFCLK },
+	{ .func = TG_ENABLE_OPTC_CLOCK,
+	  .meta.tg_enable_optc_clock.enable = true },
+	{ .func = CLK_SRC_PROGRAM_PIX_CLK },
+	{ .func = TG_PROGRAM_TIMING },
+	{ .func = TG_SET_H_TIMING_DIV_MANUAL_MODE },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+	{ .func = TG_ENABLE_CRTC },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true,
+	  .meta.tg_set_drr.with_mid = true },
+	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
+	{ .func = TG_SETUP_VERTICAL_INTERRUPT2 },
+	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true },
+	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
+
+	{ .func = TG_SET_OUT_MUX },
+	{ .func = DIO_LINK_ENC_ENABLE_DP_OUTPUT },
+	{ .func = DCCG_ENABLE_SYMCLK_SE },
+	/* dcn401_enable_stream divides by one unless the signal is HDMI or DVI. */
+	{ .func = DCCG_SET_PIXEL_RATE_DIV,
+	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_1 },
+	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
+	  .meta.link_enc_connect_dig_be_to_fe.connect = true },
+	{ .func = TG_SET_EARLY_CONTROL },
+
+	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
+	  .meta.bios_set_scratch_critical_state.state = false },
+};
+
+/*
+ * Net effect: finish the head for the new OTG master. program_front_end
+ * for a master with no plane, then stereo, then the waits that complete
+ * the head's double buffering. legacy_commit_state_hw sets up stereo for
+ * a mode-changed stream, then dc_enable_stereo sets it up again for every
+ * stream; dcn10_setup_stereo with no 3D format is the two STEREO calls.
+ * The deferred tail starts only after these waits.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_new_front_end[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+	{ .func = OPP_SET_DYN_EXPANSION },
+	{ .func = OPP_PROGRAM_FMT },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+
+	{ .func = OPP_PROGRAM_STEREO,
+	  .meta.skip_if.stream_mode_unchanged = true },
+	{ .func = TG_PROGRAM_STEREO,
+	  .meta.skip_if.stream_mode_unchanged = true },
+	{ .func = OPP_PROGRAM_STEREO },
+	{ .func = TG_PROGRAM_STEREO },
+
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+};
+
+/*
+ * Net effect: release the forced p-state when no OTG master did, then
+ * dcn401_optimize_bandwidth without FAMS2, SubVP or DC-mode softmax.
+ */
+static const struct dcn401_commit_step bls_tail_per_state_new[] = {
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	  .meta.skip_if.new_state_has_stream = true },
+	{ .func = HUBBUB_PROGRAM_WATERMARKS,
+	  .meta.hubbub_program_watermarks.safe_to_lower = true },
+	{ .func = HUBBUB_PROGRAM_ARBITER,
+	  .meta.hubbub_program_arbiter.safe_to_lower = true },
+	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true },
+	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
+	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = true },
+};
+
+/*
+ * Bounds on what build adds. The support check allows one stream per
+ * state, and never one in both.
+ */
+static_assert(ARRAY_SIZE(bls_head_per_state_new) +
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current) <=
+		DC2_BLS_MAX_STEPS,
+		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
+static_assert(ARRAY_SIZE(bls_head_per_state_new) +
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_new) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_new_front_end) <=
+		DC2_BLS_MAX_STEPS,
+		"dcn401 commit enable head exceeds DC2_BLS_MAX_STEPS");
+static_assert(ARRAY_SIZE(bls_tail_per_state_new) <= DC2_BLS_MAX_STEPS,
+		"dcn401 commit tail sequence exceeds DC2_BLS_MAX_STEPS");
+
+/* pipe is NULL only for the bandwidth and p-state steps. */
+struct dcn401_commit_step_args {
+	struct dc *dc;
+	struct dc_state *new_state;
+	struct pipe_ctx *pipe;
+};
+
+/* enable_stream_timing_calc: manual mode unless every span is even. */
+static bool dcn401_h_timing_div_manual_mode(
+		const struct dc_crtc_timing *timing)
+{
+	unsigned int h_blank_start = timing->h_total - timing->h_front_porch;
+	unsigned int h_blank_end = h_blank_start - timing->h_addressable;
+
+	return (timing->h_total % 2) || (h_blank_start % 2) ||
+			(h_blank_end % 2) || (timing->h_sync_width % 2);
+}
+
+/* dcn10_get_vupdate_offset_from_vsync for progressive timing. */
+static int dcn401_vupdate_start_line(const struct pipe_ctx *pipe)
+{
+	const struct dc_crtc_timing *timing = &pipe->stream->timing;
+	int front_porch = timing->v_front_porch ? timing->v_front_porch : 1;
+	int vesa_sync_start = timing->v_addressable + timing->v_border_bottom +
+			front_porch;
+	int asic_blank_end = timing->v_total - vesa_sync_start -
+			timing->v_border_top;
+	int start_line = asic_blank_end -
+			(int)pipe->pipe_dlg_param.vstartup_start + 1;
+
+	return start_line < 0 ? 0 : start_line;
+}
+
+/* dcn401_enable_stream_calc's early control for this lane count. */
+static uint32_t dcn401_early_cntl(const struct pipe_ctx *pipe)
+{
+	const struct dc_crtc_timing *timing = &pipe->stream->timing;
+	unsigned int lane_count =
+			pipe->stream->link->cur_link_settings.lane_count;
+	uint32_t early_cntl = 0;
+
+	if (lane_count)
+		early_cntl = (timing->h_addressable + timing->h_border_left +
+				timing->h_border_right) % lane_count;
+	return early_cntl ? early_cntl : lane_count;
+}
+
+/* dcn20_blank_pixel_data(blank): sRGB black over the whole OTG. */
+static void dcn401_opp_blank_params(const struct dc *dc,
+		const struct pipe_ctx *pipe,
+		struct opp_set_disp_pattern_generator_params *p)
+{
+	const struct dc_crtc_timing *timing = &pipe->stream->timing;
+
+	p->opp = pipe->stream_res.opp;
+	p->test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
+	p->color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
+	p->color_depth = timing->display_color_depth;
+	p->use_solid_color = true;
+	p->width = timing->h_addressable + timing->h_border_left +
+			timing->h_border_right;
+	p->height = timing->v_addressable + timing->v_border_top +
+			timing->v_border_bottom;
+	p->disable_dyn_exp_for_test_pattern =
+			dc->debug.disable_dynamic_expansion_for_test_pattern;
+}
+
+static void dcn401_program_timing_params(const struct pipe_ctx *pipe,
+		struct tg_program_timing_params *p)
+{
+	const union dml2_global_sync_programming *sync = &pipe->global_sync;
+
+	p->tg = pipe->stream_res.tg;
+	p->timing = &pipe->stream->timing;
+	p->vready_offset = sync->dcn4x.vready_offset_pixels;
+	p->vstartup_start = sync->dcn4x.vstartup_lines;
+	p->vupdate_offset = sync->dcn4x.vupdate_offset_pixels;
+	p->vupdate_width = sync->dcn4x.vupdate_vupdate_width_pixels;
+	p->pstate_keepout = sync->dcn4x.pstate_keepout_start_lines;
+	p->signal = pipe->stream->signal;
+	p->use_vbios = true;
+}
+
+static void dcn401_drr_params(const struct pipe_ctx *pipe, bool with_mid,
+		struct drr_params *drr)
+{
+	const struct dc_crtc_timing_adjust *adjust = &pipe->stream->adjust;
+
+	drr->vertical_total_min = adjust->v_total_min;
+	drr->vertical_total_max = adjust->v_total_max;
+	if (with_mid) {
+		drr->vertical_total_mid = adjust->v_total_mid;
+		drr->vertical_total_mid_frame_num =
+				adjust->v_total_mid_frame_num;
+	}
+}
+
+static void dcn401_update_clocks_params(const struct dc *dc,
+		struct dc_state *context, bool safe_to_lower,
+		struct clk_mgr_update_clocks_for_state_params *p)
+{
+	p->clk_mgr = dc->clk_mgr;
+	p->context = context;
+	p->safe_to_lower = safe_to_lower;
+	p->disallow_p_state_change = !safe_to_lower &&
+			context->bw_ctx.bw.dcn.clk.p_state_change_support;
+}
+
+/* Writes one entry; build sized every sequence before adding to it. */
+static void dcn401_add_step(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *args,
+		const struct dcn401_commit_step *step)
+{
+	struct block_sequence *entry =
+			&sequence->steps[(*sequence->num_steps)++];
+	union block_sequence_params *p = &entry->params;
+	struct dc *dc = args->dc;
+	struct dcn_bw_output *bw = &args->new_state->bw_ctx.bw.dcn;
+	struct pipe_ctx *pipe = args->pipe;
+	const struct dcn401_commit_step_meta *m = &step->meta;
+
+	memset(entry, 0, sizeof(*entry));
+	entry->func = step->func;
+	switch (step->func) {
+	case CLK_MGR_UPDATE_CLOCKS_FOR_STATE:
+		dcn401_update_clocks_params(dc, args->new_state,
+				m->clk_mgr_update_clocks_for_state
+				.safe_to_lower,
+				&p->clk_mgr_update_clocks_for_state_params);
+		break;
+	case HUBBUB_PROGRAM_WATERMARKS:
+		p->hubbub_program_watermarks_params.dc = dc;
+		p->hubbub_program_watermarks_params.hubbub =
+				dc->res_pool->hubbub;
+		p->hubbub_program_watermarks_params.watermarks =
+				&bw->watermarks;
+		p->hubbub_program_watermarks_params.refclk_mhz =
+				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz /
+				1000;
+		p->hubbub_program_watermarks_params.safe_to_lower =
+				m->hubbub_program_watermarks.safe_to_lower;
+		break;
+	case HUBBUB_PROGRAM_ARBITER:
+		p->hubbub_program_arbiter_params.dc = dc;
+		p->hubbub_program_arbiter_params.hubbub = dc->res_pool->hubbub;
+		p->hubbub_program_arbiter_params.arb_regs = &bw->arb_regs;
+		p->hubbub_program_arbiter_params.safe_to_lower =
+				m->hubbub_program_arbiter.safe_to_lower;
+		break;
+	case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
+		p->hubbub_program_compbuf_segments_params.hubbub =
+				dc->res_pool->hubbub;
+		p->hubbub_program_compbuf_segments_params.compbuf_size =
+				bw->arb_regs.compbuf_size;
+		p->hubbub_program_compbuf_segments_params.safe_to_lower =
+				m->hubbub_program_compbuf_segments
+				.safe_to_lower;
+		break;
+	case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL:
+		p->hubbub_force_pstate_change_control_params.hubbub =
+				dc->res_pool->hubbub;
+		break;
+	case BIOS_SET_SCRATCH_CRITICAL_STATE:
+		p->bios_set_scratch_critical_state_params.dcb =
+				dc->ctx->dc_bios;
+		p->bios_set_scratch_critical_state_params.state =
+				m->bios_set_scratch_critical_state.state;
+		break;
+	case TG_LOCK:
+		p->tg_lock_params.dc = dc;
+		p->tg_lock_params.tg = pipe->stream_res.tg;
+		p->tg_lock_params.lock = m->tg_lock.lock;
+		break;
+	case TG_ENABLE_CRTC:
+		p->tg_enable_crtc_params.tg = pipe->stream_res.tg;
+		break;
+	case TG_DISABLE_CRTC:
+		p->tg_disable_crtc_params.tg = pipe->stream_res.tg;
+		break;
+	case TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR:
+		p->tg_wait_odm_doublebuffer_pending_clear_params.tg =
+				pipe->stream_res.tg;
+		break;
+	case TG_ENABLE_OPTC_CLOCK:
+		p->tg_enable_optc_clock_params.tg = pipe->stream_res.tg;
+		p->tg_enable_optc_clock_params.enable =
+				m->tg_enable_optc_clock.enable;
+		break;
+	case TG_SET_DRR:
+		p->tg_set_drr_params.tg = pipe->stream_res.tg;
+		if (m->tg_set_drr.from_adjust)
+			dcn401_drr_params(pipe, m->tg_set_drr.with_mid,
+					&p->tg_set_drr_params.drr);
+		break;
+	case TG_SET_STATIC_SCREEN_CONTROL:
+		/* DRR is off, so no static-screen event triggers the OTG. */
+		p->tg_set_static_screen_control_params.tg = pipe->stream_res.tg;
+		p->tg_set_static_screen_control_params.num_frames =
+				DCN401_STATIC_SCREEN_NUM_FRAMES;
+		break;
+	case TG_PROGRAM_TIMING:
+		dcn401_program_timing_params(pipe,
+				&p->tg_program_timing_params);
+		break;
+	case TG_SET_H_TIMING_DIV_MANUAL_MODE:
+		p->tg_set_h_timing_div_manual_mode_params.tg =
+				pipe->stream_res.tg;
+		p->tg_set_h_timing_div_manual_mode_params.manual_mode =
+				dcn401_h_timing_div_manual_mode(
+				&pipe->stream->timing);
+		break;
+	case TG_SETUP_VERTICAL_INTERRUPT2:
+		p->tg_setup_vertical_interrupt2_params.tg = pipe->stream_res.tg;
+		p->tg_setup_vertical_interrupt2_params.start_line =
+				dcn401_vupdate_start_line(pipe);
+		break;
+	case TG_SET_OUT_MUX:
+		p->tg_set_out_mux_params.tg = pipe->stream_res.tg;
+		p->tg_set_out_mux_params.dest = OUT_MUX_DIO;
+		break;
+	case TG_SET_EARLY_CONTROL:
+		p->tg_set_early_control_params.tg = pipe->stream_res.tg;
+		p->tg_set_early_control_params.early_cntl =
+				dcn401_early_cntl(pipe);
+		break;
+	case TG_PROGRAM_STEREO:
+		p->tg_program_stereo_params.tg = pipe->stream_res.tg;
+		p->tg_program_stereo_params.timing = &pipe->stream->timing;
+		break;
+	case OPTC_SET_ODM_BYPASS:
+		p->set_odm_bypass_params.tg = pipe->stream_res.tg;
+		p->set_odm_bypass_params.timing = &pipe->stream->timing;
+		break;
+	case OPP_PIPE_CLOCK_CONTROL:
+		p->opp_pipe_clock_control_params.opp = pipe->stream_res.opp;
+		p->opp_pipe_clock_control_params.enable = true;
+		break;
+	case OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL:
+		p->opp_program_left_edge_extra_pixel_params.opp =
+				pipe->stream_res.opp;
+		p->opp_program_left_edge_extra_pixel_params.pixel_encoding =
+				pipe->stream->timing.pixel_encoding;
+		p->opp_program_left_edge_extra_pixel_params.is_otg_master =
+				true;
+		break;
+	case OPP_PROGRAM_FMT:
+		p->opp_program_fmt_params.opp = pipe->stream_res.opp;
+		p->opp_program_fmt_params.fmt_bit_depth =
+				&pipe->stream->bit_depth_params;
+		p->opp_program_fmt_params.clamping = &pipe->stream->clamping;
+		break;
+	case OPP_SET_DYN_EXPANSION:
+		p->opp_set_dyn_expansion_params.opp = pipe->stream_res.opp;
+		p->opp_set_dyn_expansion_params.color_space =
+				COLOR_SPACE_YCBCR601;
+		p->opp_set_dyn_expansion_params.color_depth =
+				pipe->stream->timing.display_color_depth;
+		p->opp_set_dyn_expansion_params.signal = pipe->stream->signal;
+		break;
+	case OPP_SET_DISP_PATTERN_GENERATOR:
+		dcn401_opp_blank_params(dc, pipe,
+				&p->opp_set_disp_pattern_generator_params);
+		break;
+	case OPP_WAIT_FOR_BLANK_COMPLETE:
+		p->opp_wait_for_blank_complete_params.opp =
+				pipe->stream_res.opp;
+		p->opp_wait_for_blank_complete_params.polling_interval_us =
+				DCN401_DPG_POLL_INTERVAL_US;
+		p->opp_wait_for_blank_complete_params.timeout_us =
+				DCN401_DPG_POLL_TIMEOUT_US;
+		/* DC1 ignores the result of dcn20_wait_for_blank_complete. */
+		p->opp_wait_for_blank_complete_params.continue_on_error = true;
+		break;
+	case OPP_PROGRAM_STEREO:
+		p->opp_program_stereo_params.opp = pipe->stream_res.opp;
+		p->opp_program_stereo_params.timing = &pipe->stream->timing;
+		break;
+	case DCCG_SET_DTBCLK_P_SRC:
+		p->dccg_set_dtbclk_p_src_params.dccg = dc->res_pool->dccg;
+		p->dccg_set_dtbclk_p_src_params.src =
+				m->dccg_set_dtbclk_p_src.src;
+		p->dccg_set_dtbclk_p_src_params.otg_inst =
+				pipe->stream_res.tg->inst;
+		break;
+	case DCCG_SET_PIXEL_RATE_DIV:
+		p->dccg_set_pixel_rate_div_params.dccg = dc->res_pool->dccg;
+		p->dccg_set_pixel_rate_div_params.otg_inst =
+				pipe->stream_res.tg->inst;
+		p->dccg_set_pixel_rate_div_params.k1 =
+				m->dccg_set_pixel_rate_div.k1;
+		p->dccg_set_pixel_rate_div_params.k2 = PIXEL_RATE_DIV_NA;
+		break;
+	case CLK_SRC_PROGRAM_PIX_CLK:
+		p->clk_src_program_pix_clk_params.clock_source =
+				pipe->clock_source;
+		p->clk_src_program_pix_clk_params.pix_clk_params =
+				&pipe->stream_res.pix_clk_params;
+		/* DC1 gives virtual a dummy 8b/10b DP link setting. */
+		p->clk_src_program_pix_clk_params.encoding = DP_8b_10b_ENCODING;
+		p->clk_src_program_pix_clk_params.pll_settings =
+				&pipe->pll_settings;
+		break;
+	case CLK_SRC_POWER_DOWN:
+		p->clk_src_power_down_params.clock_source = pipe->clock_source;
+		/* dcn401_reset_hw_ctx_wrap ignores a failed power-down. */
+		p->clk_src_power_down_params.continue_on_error = true;
+		break;
+	case DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE:
+		p->link_enc_connect_dig_be_to_fe_params.link_enc =
+				pipe->stream->link->link_enc;
+		p->link_enc_connect_dig_be_to_fe_params.engine =
+				pipe->stream_res.stream_enc->id;
+		p->link_enc_connect_dig_be_to_fe_params.connect =
+				m->link_enc_connect_dig_be_to_fe.connect;
+		break;
+	case DIO_LINK_ENC_ENABLE_DP_OUTPUT:
+		p->link_enc_enable_dp_output_params.link_enc =
+				pipe->stream->link->link_enc;
+		p->link_enc_enable_dp_output_params.link_settings =
+				&pipe->link_config.dp_link_settings;
+		p->link_enc_enable_dp_output_params.clock_source =
+				pipe->clock_source->id;
+		break;
+	case DIO_LINK_ENC_DISABLE_OUTPUT:
+		p->link_enc_disable_output_params.link_enc =
+				pipe->stream->link->link_enc;
+		p->link_enc_disable_output_params.signal =
+				SIGNAL_TYPE_DISPLAY_PORT;
+		break;
+	case DCCG_ENABLE_SYMCLK_SE:
+		p->dccg_enable_symclk_se_params.dccg = dc->res_pool->dccg;
+		p->dccg_enable_symclk_se_params.stream_enc_inst =
+				pipe->stream_res.stream_enc->stream_enc_inst;
+		p->dccg_enable_symclk_se_params.link_enc_inst =
+				pipe->stream->link->link_enc->transmitter -
+				TRANSMITTER_UNIPHY_A;
+		break;
+	case DCCG_DISABLE_SYMCLK_SE:
+		p->dccg_disable_symclk_se_params.dccg = dc->res_pool->dccg;
+		p->dccg_disable_symclk_se_params.stream_enc_inst =
+				pipe->stream_res.stream_enc->stream_enc_inst;
+		p->dccg_disable_symclk_se_params.link_enc_inst =
+				pipe->stream->link->link_enc->transmitter -
+				TRANSMITTER_UNIPHY_A;
+		break;
+	case HUBP_PROGRAM_DET_SEGMENTS:
+		p->program_det_segments_params.hubbub = dc->res_pool->hubbub;
+		p->program_det_segments_params.hubp_inst =
+				pipe->plane_res.hubp->inst;
+		break;
+	case MPC_REMOVE_MPCC:
+		p->mpc_remove_mpcc_params.mpc = dc->res_pool->mpc;
+		p->mpc_remove_mpcc_params.mpc_tree_params =
+				&pipe->stream_res.opp->mpc_tree_params;
+		p->mpc_remove_mpcc_params.mpcc_to_remove =
+				&dc->res_pool->mpc->mpcc_array[
+				pipe->plane_res.mpcc_inst];
+		break;
+	case MPC_ASSERT_IDLE_MPCC:
+		p->mpc_assert_idle_mpcc_params.mpc = dc->res_pool->mpc;
+		p->mpc_assert_idle_mpcc_params.mpcc_id =
+				pipe->plane_res.mpcc_inst;
+		break;
+	case HUBP_SET_BLANK:
+		p->hubp_set_blank_params.hubp = pipe->plane_res.hubp;
+		p->hubp_set_blank_params.blank = true;
+		break;
+	case HUBP_UPDATE_MALL_SEL:
+		p->hubp_update_mall_sel_params.hubp = pipe->plane_res.hubp;
+		break;
+	case HUBP_SET_FLIP_CONTROL_GSL:
+		p->set_flip_control_gsl_params.hubp = pipe->plane_res.hubp;
+		break;
+	case HUBP_CLK_CNTL:
+		p->hubp_clk_cntl_params.hubp = pipe->plane_res.hubp;
+		break;
+	case DPP_DPPCLK_CONTROL:
+		p->dpp_dppclk_control_params.dpp = pipe->plane_res.dpp;
+		break;
+	case DC_IP_REQUEST_CNTL:
+		p->dc_ip_request_cntl_params.hws = dc->hwseq;
+		p->dc_ip_request_cntl_params.enable =
+				m->dc_ip_request_cntl.enable;
+		break;
+	case HUBP_PG_CONTROL:
+		p->hubp_pg_control_params.hws = dc->hwseq;
+		p->hubp_pg_control_params.hubp_inst =
+				pipe->plane_res.hubp->inst;
+		p->hubp_pg_control_params.power_on = false;
+		break;
+	case HUBP_RESET:
+		p->hubp_reset_params.hubp = pipe->plane_res.hubp;
+		break;
+	case DPP_RESET:
+		p->dpp_reset_params.dpp = pipe->plane_res.dpp;
+		break;
+	default:
+		/* The step tables use only the funcs above. */
+		ASSERT(false);
+		break;
+	}
+}
+
+static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
+		const struct dcn401_commit_step *step)
+{
+	if (step->meta.skip_if.stream_mode_unchanged &&
+			!args->pipe->stream->mode_changed)
+		return true;
+	if (step->meta.skip_if.new_state_has_stream &&
+			args->new_state->stream_count)
+		return true;
+	return false;
+}
+
+static void dcn401_add_steps(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *args,
+		const struct dcn401_commit_step *steps, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (!dcn401_skip_step(args, &steps[i]))
+			dcn401_add_step(sequence, args, &steps[i]);
+	}
+}
+
+/* The support check found an OTG master for each stream of state. */
+static void dcn401_add_steps_per_stream_per_otg_master_pipe(
+		struct block_sequence_state *sequence, struct dc *dc,
+		struct dc_state *new_state, struct dc_state *state,
+		const struct dcn401_commit_step *steps, unsigned int count)
+{
+	struct dcn401_commit_step_args args = {0};
+	unsigned int i;
+
+	args.dc = dc;
+	args.new_state = new_state;
+	for (i = 0; i < state->stream_count; i++) {
+		args.pipe = get_otg_master_from_state_by_stream(state,
+				state->streams[i]);
+		dcn401_add_steps(sequence, &args, steps, count);
+	}
+}
+
+#define DCN401_ADD_STEPS(sequence, args, steps) \
+	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
+#define DCN401_ADD_STEPS_PER_STREAM(sequence, dc, new_state, state, steps) \
+	dcn401_add_steps_per_stream_per_otg_master_pipe(sequence, dc, \
+			new_state, state, steps, ARRAY_SIZE(steps))
+
+static enum bls_builder_result dcn401_build_non_seamless_commit(
+		struct bls_builder_declarative_params *params)
+{
+	struct dcn401_commit_step_args state_args = {0};
+	struct block_sequence_state head;
+	struct block_sequence_state tail;
+	struct dc_state *current_state;
+	struct dc_state *new_state;
+	enum bls_builder_result result;
+	struct dc *dc;
+
+	if (!params)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	result = dcn401_check_non_seamless_commit_support(params->dc,
+			params->current_state, params->new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	/* The entries point into the states. The build writes neither. */
+	dc = params->dc;
+	current_state = (struct dc_state *)params->current_state;
+	new_state = (struct dc_state *)params->new_state;
+	state_args.dc = dc;
+	state_args.new_state = new_state;
+
+	params->head_num_steps = 0;
+	params->tail_num_steps = 0;
+	head.steps = params->head_sequence;
+	head.num_steps = &params->head_num_steps;
+	tail.steps = params->tail_sequence;
+	tail.num_steps = &params->tail_num_steps;
+
+	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
+	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, current_state,
+			bls_head_per_stream_per_otg_master_pipe_current);
+	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, new_state,
+			bls_head_per_stream_per_otg_master_pipe_new);
+	DCN401_ADD_STEPS_PER_STREAM(&head, dc, new_state, new_state,
+			bls_head_per_stream_per_otg_master_pipe_new_front_end);
+	DCN401_ADD_STEPS(&tail, &state_args, bls_tail_per_state_new);
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool dcn401_non_seamless_commit_check_capability(
+		const struct bls_builder_check_capability_params *params)
+{
+	return params && dcn401_check_non_seamless_commit_support(params->dc,
+			params->current_state, params->new_state) ==
+			BLS_BUILD_SUCCESS;
+}
+
+const struct bls_builder *dcn401_non_seamless_commit_builder(void)
+{
+	static const struct bls_builder builder = {
+		.name = DCN_DECL_NON_SEAMLESS_COMMIT,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_non_seamless_commit_check_capability,
+		.build.declarative = dcn401_build_non_seamless_commit,
+	};
+
+	return &builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 589a950e078b..4c0043c84907 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -407,6 +407,8 @@ const struct bls_builder *dcn401_bls_builder_create(
 		return &initialization_builder;
 	case DCN_DECL_INITIALIZATION_LEGACY:
 		return &legacy_initialization_builder;
+	case DCN_DECL_NON_SEAMLESS_COMMIT:
+		return dcn401_non_seamless_commit_builder();
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 8ef078e01dd4..43bb5f461ef2 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -5,6 +5,12 @@
 
 #include "dm_services.h"
 #include "dc.h"
+#include "core_types.h"
+#include "resource.h"
+#include "dc_bios_types.h"
+#include "bls_builder/bls_builder.h"
+#include "bls_executor/bls_executor.h"
+#include "workaround_manager/workaround_manager.h"
 #include "core2/dc_core2.h"
 #include "core2/dc_core2_init.h"
 #include "dc_api_dispatch/api_shim.h"
@@ -39,11 +45,163 @@ void core2_destruct(struct dc *dc)
 	(void)dc;
 }
 
+/*
+ * The VBIOS scratch read legacy_commit_state_hw makes
+ * before it enables accelerated mode. The commit has no accelerated-mode
+ * entries, so it runs only after init has left VBIOS mode. Remove when a
+ * BLC exposes the accelerated-mode bit.
+ */
+static bool core2_is_accelerated_mode(struct dc *dc)
+{
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+
+	return dcb && dcb->funcs && dcb->funcs->is_accelerated_mode &&
+			dcb->funcs->is_accelerated_mode(dcb);
+}
+
+static struct pipe_ctx *core2_otg_master(struct dc_state *state)
+{
+	unsigned int i;
+
+	if (!state->stream_count)
+		return NULL;
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (state->res_ctx.pipe_ctx[i].stream == state->streams[0])
+			return &state->res_ctx.pipe_ctx[i];
+	}
+	return NULL;
+}
+
+static bool core2_run_commit_sequence(struct dc *dc,
+		const struct bls_builder *builder,
+		const struct workaround_manager *wam,
+		struct block_sequence *steps, unsigned int *num_steps)
+{
+	struct workaround_context wa_ctx = {0};
+	struct block_sequence_state sequence;
+	enum dc2_bls_exec_result result;
+
+	sequence.steps = steps;
+	sequence.num_steps = num_steps;
+	wa_ctx.current_state = dc->current_state;
+	wa_ctx.builder_name = builder->name;
+	wa_ctx.dcn_version = dc->ctx->dce_version;
+	wa_ctx.bug_wa = &dc->work_arounds;
+	wa_ctx.debug = &dc->debug;
+	if (workaround_manager_apply(wam, &sequence, &wa_ctx) != WAM_OK ||
+			*num_steps > DC2_BLS_MAX_STEPS)
+		return false;
+
+	result = dc2_bls_execute(TO_DC2(dc), steps, *num_steps);
+	return result == DC2_BLS_EXEC_OK ||
+			result == DC2_BLS_EXEC_CONTINUED_ON_ERROR;
+}
+
+/*
+ * dcn401_prepare_bandwidth's optimized_required writes. The Executor ORs
+ * in the watermark and arbiter results.
+ */
+static void core2_commit_prepare_done(struct dc *dc, struct dc_state *context)
+{
+	if (context->bw_ctx.bw.dcn.clk.p_state_change_support ||
+			context->bw_ctx.bw.dcn.arb_regs.compbuf_size !=
+			dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size)
+		dc->optimized_required = true;
+}
+
+/* The software state DC1 writes while it enables the stream. */
+static void core2_commit_enable_done(struct pipe_ctx *pipe)
+{
+	struct dc_stream_state *stream = pipe->stream;
+	struct dc_link *link = stream->link;
+
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+	link->link_state_valid = true;
+	link->link_status.link_active = true;
+	link->psr_settings.psr_feature_enabled = false;
+	link->replay_settings.replay_feature_enabled = false;
+	stream->timing_adjust_pending = false;
+	pipe->plane_res.scl_data.lb_params.alpha_en = false;
+}
+
+/* The software state DC1 writes while it disables the stream. */
+static void core2_commit_disable_done(struct dc *dc, struct pipe_ctx *pipe)
+{
+	struct dc_link *link = pipe->stream->link;
+
+	pipe->plane_res.hubp->power_gated = true;
+	link->link_status.link_active = false;
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	pipe->stream->timing_adjust_pending = true;
+	dc->optimized_required = true;
+}
+
 /* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
 enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
 {
-	(void)dc;
-	(void)context;
+	const struct bls_builder *builder =
+			TO_DC2(dc)->builders[DCN_DECL_NON_SEAMLESS_COMMIT];
+	const struct workaround_manager *wam = dc2_workaround_manager_get();
+	struct bls_builder_check_capability_params check = {
+		.dc = dc,
+		.current_state = dc->current_state,
+		.new_state = context,
+	};
+	struct bls_builder_declarative_params *params;
+	struct pipe_ctx *old_pipe;
+	struct pipe_ctx *new_pipe;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	if (!builder || !builder->check_capability ||
+			builder->kind != BLS_BUILDER_DECLARATIVE ||
+			!builder->build.declarative || !wam ||
+			!builder->check_capability(&check) ||
+			!core2_is_accelerated_mode(dc))
+		return DC_NOT_SUPPORTED;
+
+	old_pipe = core2_otg_master(dc->current_state);
+	new_pipe = core2_otg_master(context);
+
+	/*
+	 * link_set_dpms_on builds the info frame into the
+	 * pipe before it programs the packets. Remove when the builder
+	 * computes it.
+	 */
+	if (new_pipe)
+		resource_build_info_frame(new_pipe);
+
+	/* 128 block-sequence entries; keep them off the kernel stack. */
+	params = kvzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return DC_ERROR_UNEXPECTED;
+	params->dc = dc;
+	params->current_state = dc->current_state;
+	params->new_state = context;
+
+	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS) {
+		status = DC_NOT_SUPPORTED;
+		goto out;
+	}
+	if (!core2_run_commit_sequence(dc, builder, wam,
+			params->head_sequence, &params->head_num_steps))
+		goto out;
+	/*
+	 * The head ends with the ODM double-buffer and blank waits when it
+	 * programs an OTG. The tail is deferred until that head returns, so
+	 * it runs after double buffering completes.
+	 */
+	if (!core2_run_commit_sequence(dc, builder, wam,
+			params->tail_sequence, &params->tail_num_steps))
+		goto out;
+
+	core2_commit_prepare_done(dc, context);
+	if (old_pipe)
+		core2_commit_disable_done(dc, old_pipe);
+	if (new_pipe)
+		core2_commit_enable_done(new_pipe);
+	status = DC_OK;
 
-	return DC_NOT_SUPPORTED;
+out:
+	kvfree(params);
+	return status;
 }
-- 
2.43.0

