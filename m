Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082A606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCXSMVxV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A46C10F8FE;
	Wed, 21 Oct 2026 06:25:57 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C9210F8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrDqI22yu82iMjKVdWmpKoeIU03qURAN7L3uxOgdXh6UmhzTOYnfUAM03nVWmAnShyiXFmdLe6cqrHRt0kQkgWDJrWcVwuj5CRExhtzDJlDI90t0aH8h/lerhST/ekTmV7oNp5BzLL7RZNctmkhd0nisP0dy7lZeHIXbZxgTyR3OPdzhSoBKHWtkkZdTD3GhpBrvkjl4KF+SzykJO+deH3pd/Mqup5H9MXjTZYlItK/BZfso4n4KaJizO1cKpFKULbiemW4eMfTNTllj2irIzJwR+RtUh4cMpHuDvRDtrakiSbXa1w06NdJahIEz/vhEdw+JOWsm2N5J7f41zlIVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFBzTrptsrSEhklCz2+LDV0KZ5gCPKPkeiyUzqStXAk=;
 b=ZwOxS9mc/d/rfLhFO4jV1Wwo4hTv0vkv4BPc43BqYZPFxTiVd9ib7wRxG3WpZaPzvMzH81SyuwKA9Jy92VrNwcsMy1RqjeB+bq4yM7S7wWBaeeGtbo0XFfz7OXB1Tlnn7RRVN5AEHv2z4ThCGhqhJ1K0qASkkIcCWIpxaiC8ssQPeO8RfyAZdPlspKGLbWShGr9CFmku9XG8rL25qHTWOZFhC/fcA/6ybGVp9xvntEACtSS9Pd0bZuGWOl/30AOyhKxAlUQ0jDdUq0RJz2HlI6gycDYmqyNgjCJG4nwDa/hTIUWZTsCe47rZ1eoICGmDwvR5JTaHM/GDslMwQCeMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFBzTrptsrSEhklCz2+LDV0KZ5gCPKPkeiyUzqStXAk=;
 b=rCXSMVxVjYMN/Zk58wN7rFUX3HoYp2iCAhE2DylGUs4Db5vye4YKpAVpNN3Dwz2SJ8H9QHGxFilCSDDPQUU05cUG4k0yzAQIvwsoAS1Q8cNvZ8M+I/Nqq9HrpRHaI8kQT4CdWbL17OLz4fCG0J2ub4AmgrowQfHI6cJMitlJKoM=
Received: from BY3PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:39b::11)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:44 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6c) by BY3PR05CA0036.outlook.office365.com
 (2603:10b6:a03:39b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:25:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 06/49] drm/amd/display: Scaffold DMUB STOP_FW on the init BLS
Date: Wed, 21 Oct 2026 14:22:12 +0800
Message-ID: <20261021062519.674697-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fa43fa-a9ae-4fc2-48f2-08df2f3c22ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 73zoKbrZ208ipb4VqFi0N54/RiEBS2TxpbUI+LdoQ64t5yrHCz3fCED8/KgPpnZ8ZWQ3/29qMuF012kV6V2UUjF/1p+xDDFSFsNaGexwrqjLyjSq7B3kWi+tFL5zKs0Qct5DAqHzkuq4t36yYpYktv1OTrrxImHEEKPPhYe7yUPcR+pYA4kWlss+akTI9s5tXvTCo9b3QhWHU3zK5O3FhUXrdvWtLsa/tbX6/W4VP/T5NHkXjGHSJoLNnoMOvvtGQCvL4AcXZ6XG68aHDj91gYzN0SfYjdXaLfKTPGuDxxA5YjX4NHpRJRt2CVl6FmYgKjHqsRDlBWKBGhbK82XkI9ys7GtBOKnJtc3jwxjpv8pHh5BsRg+ukFc9eVsS7TEEsd6w8isDzeB3dfNp4IRzbtj21aAJlriBXr3qn4VnCSCytMT+h+mnl/tduVqHOLLV2YVd+14R3uNN4QDZ9AMyJH32iu9/uEkjzwf6fx6IpjjE0u0SzVWWoPTQ5xfcoUnxXriDVlW5ErNBpmBnxkcXFckbbtsgA0r6PD/+CtC8qOiuF7QVrSaZ1viE7Aj4OO5WAJkwH3gMe24ENGUOj9PEMBIOsK6Eq2VgsZQrB4N8HKpxVUhWVlitXyIJ6X5m1HyMzPACpI9V3k9KB47FpEyjwFuVZP4N3EYflOUEwL0LmPliJb9W3tBZmy+1QJ6lL7GXrUz7zaKIOJ1UxagcNlfWzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WMbKJGxlnbFHApFBYR6s2SKAKzMUAmLB4wCVcB1ECgqPLWliLZnnffqZdYF39l/bz3NOnYxWEegRAz/3Pn+gghM9M11041FSIFoDwcoSAqyBsE+31tBxKiH2ixRvRCfmOkmbNaHKEE8+HtYEDd0+7kGIAXCxGz9q6kfx4cmG/WckWZau1WBZVjDx9Q9X624fWpyZrBy8SZtHzdlq48Q9R5m0ai3ED8Jy2JQ1B8GIDbiqj2tV+OwAoGH2fIDRh1Czli5y3oTa2azukxclZG8YHGaTD+gZ2RVJiuaMAb23NPBnjlNVGzMbBvYpCu72/1HNv31PsnlcPNV289iwrtM3goS38XnZXnjI/FY2tHkjFm7BfSOD+m3KysO7OhVPvSLctBBP3fckg9Yh6QCbGmFehmJiOBun3L2qcN+l++y0Tyys9p+Xd+eHFgIFFdDwQFGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:43.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fa43fa-a9ae-4fc2-48f2-08df2f3c22ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

Why:
This is still builder scaffolding, not a live init path. The legacy
hwseq is still in use; emitting a halt entry does not cut initialization
over.

How:
Append DMUB_GPINT_SEND_AND_WAIT to the DCN401 init sequence with
DMUB_GPINT__STOP_FW and param 0. Preflight the GPINT transport before
any append, and point the raw response at the init out-target. The
completed walk still returns UNSUPPORTED.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |  1 +
 .../dc/bls_builder/dcn401_init_builder.c      | 40 ++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index d7de73d1d3d2..c2156117b73f 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -39,6 +39,7 @@ struct bls_builder_output_init {
 	unsigned int dchub_ref_clock_inKhz_before;
 	unsigned int backlight;
 	bool dcmode_power_limits_present;
+	unsigned int dmub_stop_fw_response;
 	struct dmub_abi dmub_abi;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 802cd42f254e..99c34e2996ae 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -8,12 +8,15 @@
 #include "clk_mgr.h"
 #include "dccg.h"
 #include "resource.h"
+#include "dc_dmub_srv.h"
+#include "dmub_cmd.h"
 #include "bls_builder/bls_builder_internal.h"
 
 static const enum block_sequence_func dcn401_dc1_init_sequence[] = {
 	LEGACY_CLK_MGR_INIT_CLOCKS,
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
+	DMUB_GPINT_SEND_AND_WAIT,
 };
 
 static bool bls_append(struct block_sequence_state *sequence,
@@ -85,6 +88,19 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 		if (!dccg->funcs || !dccg->funcs->dccg_init)
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
+	case DMUB_GPINT_SEND_AND_WAIT: {
+		struct dc_context *ctx = params->dc->ctx;
+		struct dmub_srv *dmub;
+
+		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub || !out_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		dmub = ctx->dmub_srv->dmub;
+		if (!dmub->sw_init || !dmub->hw_funcs.set_gpint ||
+				!dmub->hw_funcs.is_gpint_acked ||
+				!dmub->hw_funcs.get_gpint_response)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
+	}
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
@@ -138,6 +154,24 @@ static inline enum bls_builder_result dcn401_build_dccg_init(
 	return BLS_BUILD_SUCCESS;
 }
 
+static inline enum bls_builder_result dcn401_build_dmub_stop_fw(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+
+	bls_params.dmub_gpint_params.command_code = DMUB_GPINT__STOP_FW;
+	bls_params.dmub_gpint_params.param = 0;
+	bls_params.dmub_gpint_params.response =
+			&out_init->dmub_stop_fw_response;
+	if (!bls_append(sequence, DMUB_GPINT_SEND_AND_WAIT, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
 static enum bls_builder_result dcn401_build_initialization_step(
 		struct bls_builder_declarative_params *params,
 		struct block_sequence_state *sequence,
@@ -150,6 +184,8 @@ static enum bls_builder_result dcn401_build_initialization_step(
 		return dcn401_build_dc_mode_read(params, sequence);
 	case DCCG_INITIALIZE_CLOCKS:
 		return dcn401_build_dccg_init(params, sequence);
+	case DMUB_GPINT_SEND_AND_WAIT:
+		return dcn401_build_dmub_stop_fw(params, sequence);
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
@@ -188,8 +224,10 @@ static enum bls_builder_result dcn401_build_initialization(
 	sequence.num_steps = &params->head_num_steps;
 	if (params->out_targets)
 		out_init = params->out_targets->DCN_DECL_INITIALIZATION;
-	if (out_init)
+	if (out_init) {
 		out_init->dcmode_power_limits_present = false;
+		out_init->dmub_stop_fw_response = 0;
+	}
 
 	/*
 	 * LEGACY/pmfw-msg: preserve the clock-manager entry points until
-- 
2.43.0

