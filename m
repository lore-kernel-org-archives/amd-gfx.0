Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E84606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FAx6Rkfq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF47B10F822;
	Tue, 17 Nov 2026 17:14:33 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D369310F822
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG2a7CXouTawiBLnez6+M66+YiiTGD5EZcLJVvDeSp6qqk4GSj441LWhOu/KGiUxI7TN5KryabPg/i63Vg3INnnEcVsb05ti/Tuc38+qcdfo4Kipuf4AoQgbj2IC1QBK2kM6lHnxmOQWEAUqVcZurkSq8MrlSGErieSUSiFju828DzprxNOfHF7Vt4oDQKy8occ12pzfSJM9anwUJRSBZMKNw76bqLykrDP9OOtS6BAV1gDdSjrdXc6A01+62Oz4odqF9KZyXud0nZt+iV5HjbD3v9oAwrocO6zgjHGRATqUKMSRKyMTtoKSEUh2SZqOIAV4gfEJQtA6TdWz1svsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Dmn9qGlEPNLxkTb+Oc8B+216O3QZO5kZzEJ3R1kA8=;
 b=EM3BK4HSfoDJP99shyL6Og6LK65mz/fSFcCEpY2nNQ5mpYbdc8z46Ll2ky4q4W26bjsL7bcAzVjTIAOikTkffS7bj2FPqcDOKaIrNhKKlrFvn8WDcAs7BPaRmkoJhctMsaQyQZL2y1xIoNLu6a+6Ek1ncGNTmnblgLmEQczcBEa6hPPvz3rFz47zLk/RZ+Bw0gUkNMRstd1yai2LHOfnosWwuZNhTxPy+LY8AFLDwMnESPcrb4+3f1YjE1AHTxXIBetRyDm8wc8/rbk+a7AA3VCrmO2mkZ7IQ+OaYeeMbr/o9oRuWSaEtQJtbNEMRJxo/qKibwuR9ZF+v6bTO+I7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Dmn9qGlEPNLxkTb+Oc8B+216O3QZO5kZzEJ3R1kA8=;
 b=FAx6RkfqqiCXVdsnj1fx5OM/pDb8A7LLIwrLDfdtuNwgaHjJXO8QD2BkGCCrNdSgS6HF1ChYHGXZvP4JHhditmLfIEZazkpDSVH2ZN8/QA7Uj1egQrxTyq13dXTRQ7vXKb2F1unq41SECAHUw7FPdZaq3VFFdQrio5cdyIgRIcQ=
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:14:14 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::17) by BN0PR04CA0114.outlook.office365.com
 (2603:10b6:408:ec::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 17:14:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:06 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:13:57 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "James
 Lin" <pinglei.lin@amd.com>
Subject: [PATCH 11/33] drm/amd/display: Add DPMS-v2 types
Date: Tue, 17 Nov 2026 05:50:48 +0800
Message-ID: <20261116215641.2800595-12-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 65eade94-7697-4080-872a-08df44ce3429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: u3/ZLxw8kXW7Kc7BzKx3T1lviruwpCuqkHOixqrGBMxZdQqLm5qZX+Bn32wJwW3DM0+l4s84DTpRhPflqUWp6TNQpuKKqtFY53SjIlPu6rctvkEQ9TmB9NW2ihYlJ6kx/NDLbgTaWn32UjZxvFZiZ9S1E8RXkDVzj9JXt8yXKO2nALiictJRikmXYyh1lc83NI7NyxxoT8GALbQDm9IcFoyROAgI7JbIbJjqusmitFXc/8Sats9QLhL5KsUckR17Jjp1mQ4Gzb0Ul9WhLUL3ufnfzSlmeltghqMV0qUslg1qHTPX5XJeVQfN5kTr1bYUym5sGaIyzphWfTIAs4HsqKtw3d2zO5nGsfqyr9HO9IsLL7N/HB6TLhnRf+dpakjRJVJaqtDfJlnXp1bUz9u7X1xDn1NuWyO6ZgHG6dDspyuWA4ZjUHCWR2zPth59Z9j9pdBZksj+L5jRq7NgM2NWdlwQ/btvfQ/6xf6UVJWPwL0nH8p0gaxLIWnzWGwKJQfN6vtuBgCu5iMXQspMrEaGWyhZbKfK2cc0Htcv0FM5Um/+4PhAvBdWqdKbt34BYOQHvTY+7JRE/5UbCU9Ub8BCPWJrI80bemikmhS0XUKCtuPVHnTqZGq23D/qXaydGOSCW0XYYyUDaqmQxayAnlbLjS3DZHextxeWyAd9xY7/agjvzrMDKUaTaoZgyMZJUEJXR3c2KxbdpjJUSzomEwj7cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ssRWH+RbQdDIgz7xKjWtymR0PiOCei1RGZoBOE3URLCj4p4DEyHEE0QL5Is1jhylQfvoU1KlNorbpspXPFZUAgCPeA/irH+rdbn3vhSGs6Fjg1U0e3xXUWPBEZq1iAnjuEja1omF/8f3jNbUZTRUUMYp9n6/qzEqV6L3a5vrmpKWZeXqjEbg8UZxo9q2tHf6dnFnTqYmqoi6++X72uoLCdBslXCL69/kyty7C3F8dcA+PQ9FpX1Xt3M0a/JlUAST8H64mv0OK78eyz0mbZ+df/VObDHKZKkh178/77Odc5psnWbYtMk254P9sMrX0kfmLcnRttQklOsF/0X+R8hpmah5rbrnQOoXQay4NE69BukM+drR29DBu1re2jRPdYf43IlM25KLpKbhWsrABRckWBRUvSnoimsluTVbG2IdHs2CzKkCVDex7cU8jvITYdQ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:13.8457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eade94-7697-4080-872a-08df44ce3429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why]
DPMS-v2 replaces pipe_ctx with link_dpms_ctx, aiming to narrow its
reach and responsibilities, enabling more precise and safe design.

[How]
* Add link_tx in dedicated file as new vtable for DPMS-v2 to call
* Add link_dpms_ctx in core_types
* Place link_dpms_ctx in dc_link
* No initialization or other use logic yet, TBD

Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 58 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/link_tx.h  | 59 +++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_tx.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 01f549010d07..c9bdfba11a01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -556,6 +556,7 @@ struct dc_update_descriptor {
 struct dc;
 struct dc_plane_state;
 struct dc_state;
+struct link_dpms_ctx;
 
 struct dc_cap_funcs {
 	bool (*get_dcc_compression_cap)(const struct dc *dc,
@@ -1931,6 +1932,7 @@ struct dc_scratch_space {
 	void *priv;
 
 	struct ddc_service *ddc;
+	struct link_dpms_ctx *dpms_ctx;
 
 	enum dp_panel_mode panel_mode;
 	bool panel_mode_initialized;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 695eaa5cbf65..1d6bb41312b7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -31,6 +31,7 @@
 #include "dcn_calcs.h"
 #include "ddc_service_types.h"
 #include "dc_bios_types.h"
+#include "dsc/dsc.h"
 #include "mem_input.h"
 #include "hubp.h"
 #include "hw/dchubbub.h"
@@ -807,4 +808,61 @@ struct dc_update_scratch_space {
 	int intermediate_count;
 };
 
+/**
+ * Snapshot of fields from dc_stream_state relevant to link_set_dpms_on_v2().
+ *
+ * Removes dependency on mutable stream object, which would otherwise create
+ * synchronization hazards.
+ */
+struct link_dpms_stream_descriptor {
+	// TODO: Implement
+	int dummy;
+};
+
+/**
+ * DPMS operation context variables.
+ *
+ * This struct is owned by dc_link, sharing its lifetime.
+ * The caller populates the context with update details and validates it.
+ * No other code aside from DPMS sequence itself is allowed to modify it during
+ * execution, while DPMS serialization prevents concurrent reuse.
+ *
+ * This struct is used by top-level link_set_dpms_on/off_v2() and the sequence
+ * steps link_dpms_step_xxx(). The step functions unpack relevant values
+ * and pass them directly as arguments into TX and HWSS. This is done to make
+ * TX and HWSS independent from DPMS, while preventing them from backtracking
+ * to shared state like DC and its state structs.
+ */
+struct link_dpms_ctx {
+	/**
+	 * Mutable link state.
+	 *
+	 * Steps use it to record protocol results and evaluate preconditions.
+	 * Should not be used to access dc_state, dc_stream_state, pipe_ctx.
+	 */
+	struct dc_link *link;
+
+	/**
+	 * Snapshot of relevant fields from dc_stream_state.
+	 *
+	 * Removes dependency on mutable stream object.
+	 */
+	struct link_dpms_stream_descriptor stream_descriptor;
+
+	/**
+	 * Stable validated link configuration.
+	 *
+	 * If unable to reach desired state, DPMS reports failure instead
+	 * of rewriting alternative configuration.
+	 */
+	struct link_config link_config;
+
+	/**
+	 * Source-side link HW transmitter.
+	 *
+	 * This is sole interface used to program all protocol operations.
+	 */
+	const struct link_tx *tx;
+};
+
 #endif /* _CORE_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_tx.h b/drivers/gpu/drm/amd/display/dc/inc/link_tx.h
new file mode 100644
index 000000000000..3b671eea15ef
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_tx.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef LINK_TX_H
+#define LINK_TX_H
+
+#include "dc/inc/core_types.h"
+#include "dc/inc/core_status.h"
+
+struct dc_link;
+struct link_resource;
+struct link_tx;
+struct link_tx_funcs;
+
+/**
+ * Private DPMS v2 context, opaque type forward-declared only.
+ */
+struct link_tx_v2_ctx;
+
+struct link_tx {
+	const struct link_tx_funcs *funcs;
+	struct dc_link *link;
+	struct link_tx_v2_ctx *ctx;
+};
+
+/**
+ * Virtual table of function pointers for link protocol programming.
+ *
+ * Analogous to HWSS, but takes link_tx instead of pipe_ctx, as the latter
+ * was deemed too broad and open, resulting in synchronization hazards.
+ */
+struct link_tx_funcs {
+	// TODO: Implement
+	void (*destroy)(struct link_tx *tx);
+};
+
+#endif
+
-- 
2.43.0

