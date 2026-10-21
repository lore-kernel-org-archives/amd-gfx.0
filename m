Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBC606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s3eH61Nw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134410F932;
	Wed, 21 Oct 2026 06:26:05 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5175610F92F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj7u+TDAm0hZRlvlKXvJUwQajij+Lg8nCds6EvyEZmgtQ8PrXM4DacOroQmefn819aqSJ2hP8VxtueKFQ6he2cA9MpBTvNJxA2q61YlR1aN3vZJOxPQrqVT9H9rrE5K3d7dW4iLHs3t5r2VfOk15Y5GhlwpwChrEM9iVHQ42Lj7EYa+xv2CxRn3bgSwZfPNCdG1ZMytvbc1wKMQ/jvB3elbiCt2Hk9sIp2fk+tQoGhmOoO0ApW1cjqL2NEcE/Dqi0RkiXdtlARvWq2izSFMAMMLxB9Rsv0MobpSBhvLvbTneTYbD67AdkJVypq+DxwOa50KGJSJJ+7ZY5X8pyZGmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM2VkJRXBJEg3yBnGQOpVd36mrdBhHbIRVbX70HiycE=;
 b=YwBR3OnqFDm+cKnMPEPi15L7z9nRDyIwF7EDk5S/OJJV0RnxPrvtnZnPvOM0rEXxHzzgyoAYXuHjKETzfydhAEzcGqFQpZ1He1oi7cpLyVJCZkWr+oW3kJL5t3JvskwMjDmuPcGQXzw+dXrZ3Gu0Sn4b9n+pa8GJbfdRZ4ROXHWU1EvKOKpgum6mR3gPluq2BZcss2FiGA6hQ1Q5SpAaksf9EBOVoq1o5BeOLi0BBZuRJq70K2UZpdhxV3j44DCb60KU6sbAEnDZVTfSuDvLYm+sYslP54+5vu3YhnaCJ3kSPDVlBy3J0t+Z1LiyoQromOOOS2eIjICK3HuPUs32lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM2VkJRXBJEg3yBnGQOpVd36mrdBhHbIRVbX70HiycE=;
 b=s3eH61Nw855hvul+WcCAwWVBJO9K8kDI/jf/muH6Pz0r06aA5xzGRGPrarSEJnLHJzYGAtAUYnL3RWqjHz8ubftvw7gZODkAg/hy8aaMNHWvRPMTDEY1LFhjKeXiN9MQT5vSaGo9yMX5TMx7WxqcFT6nOv7hhftau955VReOfqs=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:55 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::5f) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:25:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:54 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:51 -0500
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
Subject: [PATCH 09/49] drm/amd/display: Call the init BLS from Core2 hardware
 init
Date: Wed, 21 Oct 2026 14:22:15 +0800
Message-ID: <20261021062519.674697-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e900836-6a6b-45ed-e4aa-08df2f3c298f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pZCVgwoKTIHBCR6qKcvAH4jolqPywxiHyEkFEfWK7bjXWCPAqiQbnDPPdMk3xJDPgSci/HCZrj4BkSkinqrlkxYLH934w5nNJmp7TEJoOqGXRE8yZSnxc/ZqBT3CI9eqjrjcrdSUiOF82jgJ9cPPXc59sJiMNETEb07aEhu3Ci4kHNIBfr4ju7MyZgNsoytUICi9VgT/dhvLV8DH2VGcq4Qg2zZDtbCuXsedBsBbMYGrb/rRCOmVt2+SLEdx49LWkhpgIHfXzl4H+FG1npCBK05BTCJ4RMugVxsDIEsitdcubGGBzugHkFGdHlfCRGh2elaY08MBipTpxkMezOBpyc+48wEjif1quSS2L2XAD0jX761/o346Ah933Y6LuuN6nCvhqC6OJhIOmh44Xqkv7SQKNRCOUhTiGzscljTtSa5Np4SSrd93LkzDAQjskYiRte+kSiAwWvyr9B7R1jPPSQDjXDbrr0Bqwm7DX5L++Hg220zRSQPiJl9//mElDwUtJJnGDdRK86WxA+HNH0rGiri72+6QmZbayf/kvppKTPrDnLE3ODEcSaK9t2UwAc9xEJkaEVZCymS/uonCR4XKnN38bhgh/lsu6SpuPIdXI97I8MJHOt5IBCAqZASyYkWH167+x1w+ZORans00PopsO18GwhcKO6wd4byLjxlV3n8q/FnyHgeDyU+j1H6UA9tCF49w/U+USgPCwlOxFNas7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+Oe4/XnKw3+PyGs9HTSR6q+u2lANeErJiWkdtGoeFaulURCKGKR7fTSF3z8O4U9qJShc7B4lzotonwy3GWj6VCKLXP4UvTQyi2hApXWgpnnhgCbp04eZmyWtRQ9eMG4Vbz2AdRxFSodWBQUJ6pEuR4ldCbSLbEYo2WyOyT5l11rvKwo8gbWRFuhRF4S0u6SFvTeng1wju/uI75/IvykivzNebu9mGLYEqaSFm33xfxCQAd0RDr+fNC+bNG/Lm00rNOAVLZsZSH2eCCIKi28QkNsD7HoVGeOGdlqcRKIw+Yu8HAF1YkzOqPgAJ1KIQ9w7XKuQMZby5An8ksIpPmUI955/S7/4O1HvlTA656sy6vDrRkYkktlyrQC68eYtnxhOnbWS1+3NKFkUdHrO+fLf6Ms9D8SR+RSWfDzy6uPUBX9FY/Wrtsb+dV+awTVqG4l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:55.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e900836-6a6b-45ed-e4aa-08df2f3c298f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305
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
Core2 hardware init still delegated to legacy hwseq. The init head is
now a BLS, and a failed or unsupported build must not execute it or
fall back.

How:
core2_hardware_init builds DCN_DECL_INITIALIZATION and executes only
on BLS_BUILD_SUCCESS. A zero Initialize DCN command stays unsupported.
A non-zero test command type can succeed and execute. Product DC has
no DMUB window params and no opcode, so this path does not reload or
halt firmware.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dc/bls_builder/dcn401_init_builder.c      |  4 ++
 .../drm/amd/display/dc/core2/dc_core2_init.c  | 44 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index b63f255303d1..21ba6a9245dd 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -356,6 +356,10 @@ static enum bls_builder_result dcn401_build_initialization(
 			return result;
 	}
 
+	if (out_init &&
+			out_init->dmub_initialize_dcn_cmd.cmd_common.header.type)
+		return BLS_BUILD_SUCCESS;
+
 	return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
index d4777cdbd569..f3d01b14b360 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -5,9 +5,51 @@
 
 #include "dm_services.h"
 #include "dc.h"
+#include "bls_builder/bls_builder.h"
+#include "bls_executor/bls_executor.h"
 #include "core2/dc_core2_init.h"
+#include "dc_api_dispatch/api_shim.h"
 
 void core2_hardware_init(struct dc *dc)
 {
-	dc2_legacy_funcs()->hardware_init(dc);
+	struct bls_builder_declarative_params *params;
+	struct bls_builder_output_init *out_init;
+	struct bls_builder_output_targets out_targets = {0};
+	const struct bls_builder *builder;
+	enum bls_builder_result result;
+
+	if (!dc)
+		return;
+
+	builder = bls_builder_create(dc, DCN_DECL_INITIALIZATION);
+	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
+			!builder->build.declarative)
+		return;
+
+	/*
+	 * The declarative params hold 128 block-sequence entries, and the
+	 * init output holds DMUB command buffers. Keep both off the stack
+	 * so the kernel frame stays under the 2048-byte limit.
+	 */
+	params = kvzalloc(sizeof(*params), GFP_KERNEL);
+	out_init = kvzalloc(sizeof(*out_init), GFP_KERNEL);
+	if (!params || !out_init)
+		goto out;
+
+	params->dc = dc;
+	out_targets.DCN_DECL_INITIALIZATION = out_init;
+	params->out_targets = &out_targets;
+	/*
+	 * DC does not carry DMUB framebuffer windows. Missing hw_params
+	 * fails the build closed. Execute only a successful build, and
+	 * do not fall back to legacy hwseq.
+	 */
+	result = builder->build.declarative(params);
+	if (result == BLS_BUILD_SUCCESS)
+		dc2_bls_execute(TO_DC2(dc), params->head_sequence,
+				params->head_num_steps);
+
+out:
+	kvfree(params);
+	kvfree(out_init);
 }
-- 
2.43.0

