Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AB606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Gk86peg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9555010F836;
	Tue, 17 Nov 2026 17:15:59 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D5010F833
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiIY9FKrb/0bD4f/KIbtxCdz1x5G3h0JEaFvs94LWaWWbuFFuvBRoDa0KKqbczM5AB7Eeby5JNIMFw5N8/VdC6s8jfsTf9MJn3fv6kdTFdZJu7khBmAEhjqXpZEwDomx5xdxU5YHVXR8R8f0eaKiSTPf/72mgDdHG/cVro39SV2uaxhIQ1DV0EoDwfD+STHIQDhc/ZA65kH0pjAZPI52eJ8ZoohO/SDzpfUQlU3fFaz8klbROBJ2bzoZLv7zp+8cwywK/RpCyj5CPTrAWFYfM+E4iuTB4x41MzrQaQ8Uf7LFm+9zT0ojcbVfTYq63v+VmbeNlc5p9E7MLsAKjiKynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afTmSL03L1RVBAOw4jjWdDj359rDzN0qL+Gw1oK5unc=;
 b=ormZ7vCIp1k+ZkPsui2r4OUatS2NIIAN1MTv3GIoIUelAYkM4ek/ANuqpJmImhLTh6WBhf4qTUpCjgtLxlkiM8grtwyV0ucO3kYS2nQoVgeLIOSmRlOSGYuG/ZfO6MleEwjoGmp2PcwVXNmtRx194f1N+BbJZ1AwsRDG9cqHdTPbuajf++Is9hlE+kT3VQqfH/ybde3ksWdaF68PoFpDQNyrNh07JftaULoHV5qUCTEKRaHbGszHuUg1EgEkxNy3OCqWUqjSlKG+Fix7yhFCxRMNyAecE2t7vhP65nMatbjJR0y+qlbEmMa3CbV9ack6Nuo43+PHlWp0C9SmlF6jZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afTmSL03L1RVBAOw4jjWdDj359rDzN0qL+Gw1oK5unc=;
 b=0Gk86pegJdSxo4Yazp4JYy50Gx37Up2wdiDJeUVZR9kzQKBgMY398559RwGei/jPhjDbig+pQRVGeKDYFBJeGLOxX/FhM1uuRNqxJc7kETGKW25re1yErvKrdn8eSS7nh/rdwRKoUvwjKnQEe52+tG7rnrj9XRPYkbjuZTGfhY0=
Received: from BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:15:39 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::86) by BL1PR13CA0404.outlook.office365.com
 (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Tue, 17
 Nov 2026 17:15:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:15:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:19 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:15:10 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Jun Lei
 <jun.lei@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 19/33] drm/amd/display: Add DC2 wrapped initialization for
 DCN401
Date: Tue, 17 Nov 2026 05:50:56 +0800
Message-ID: <20261116215641.2800595-20-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c728d0-97c7-45f5-8064-08df44ce6746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|6133799003|261009220027099003|261009221727099003|261009221227099003|261009223327099003|261009223027099003|3023799007|11063799006|56012099006|5023799004|260925022911599003|260925021911599003|260925021311599003|261026135527099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261026130827099003|261022105027099003|261022113327099003|261021123027099003|261022115727099003|261021130227099003|261021133027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: bDfNFJC/tK7Zd/ZmurQ6IgNyHqRsz4HgkLxOTJz3H3CjGgm9nAWHm3v6LAY0ke8d7Fu5Fk0PiiiZp2u+cmyk8qP6roevuc2xA7zIZr+qloTNUg+1l58/pREW9YoCxNOMYG+Im2Q38WkVFgluerinTXsnipqxgqn33sNtt/vtw9q0Y+HwQ+zuXTAqq8mvpLRNzPtrQmGklvhqXX5jtFAv5YUQ4VGZOHk0RW/hlevKBPyCg1THhPR/SvlpKfFdXWN3HTIDEh0GWykf4OKA8RSakFibI9hSTUcl5ut/1/P+0OEb4XkBpht/UQdvQdCR6ete+6CR/3Bekq16LLz53Y+1wftrJrOy79NBlETQOkgNwyz0JGQIs2RYz/bTfucwk5EQZKpK3EMqbm5gjB24ToBtDns+udDmHPJVD4kz8dBWhyKNktY62Eqb8/eNHUBZeEaLpiprS3MQwNHvm7+82MQLo8Fl4eslFV1506zMEA1OGpRxeToFWXPCfFNTWwifH4//kmcGjae2spycU/drUTldS5RXf1EyMPDU68HvrGEPgkNPHTtrJlH0ZXWoj/n5Zy1UaPf3N+8FMEJjgTf8uU+FzoMgao1Oy/MoKw26WjRw6VY4T/JEExIn4gFds7JcMwWZr+9hd+weyb1FgL71hI4WOs81I5Xe4FqPnta6/Z6TiaGOgWBbpN863OoC+dQ9srQ63aEGk7sNWDEw9g39tpNM7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(260925022911599003)(260925021911599003)(260925021311599003)(261026135527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026130827099003)(261022105027099003)(261022113327099003)(261021123027099003)(261022115727099003)(261021130227099003)(261021133027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2u0JXvjO4aGFp6YgTFLo4+8wwoh6Jyi3oel96zVW2LHMUE/RhYkFbgQzXP2tBRp43FOwYiE/MmypIgHH6zMFC4rpqD8E2qCSs1e2g15EIkIrVM4Ew/ozAujdQif1nzT4I89xWeQ/DJtU8y9sG7h7VpZki6wd5W+ZjlFjRQ7iJATpYyfuWQtk2usVTV4bMTLUmYopefEBPhOHOUBEt1YAxAUKQvrDGmeh4Ny+bF8ulD0PKyOd6kV2DEyPCDkb3HGVwyYX/eqdX6GxL058RiWgoFxeuVbeSwcJXMoRN9ub0RbtIxiVqUjoyutO+qG8o/p6aDIG3x8kLVnMLOFykuJQB2XbKFCOmX/hlg8+h8tZa+mIIQG96fH1hTzFjqBv9J5YvcPCOXP4igAsUHJx9UHtsNHwP6bmj/EENO88r5nN3BSlVyCS1a6UbgNrEXH94f90
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:39.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c728d0-97c7-45f5-8064-08df44ce6746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
DC2 needs a wrapped hardware initialization path with software state
management separated from hardware sequencing.

[how]
- Add staged DCN401 initialization with builder postprocessing and
  workaround application before each sequence is executed.
- Add a PMFW messenger for firmware communication and DPM clock queries.
- Resolve DMUB capabilities, reference clocks, DPM limits, bandwidth
  parameters and watermark ranges in core2 instead of clk_mgr.
- Add wrapped initialization selection through DAL_DC2_INIT while
  retaining legacy initialization as the default.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   3 +
 .../amd/display/dc/bls_builder/bls_builder.c  |  19 +
 .../amd/display/dc/bls_builder/bls_builder.h  |  68 +-
 .../dc/bls_builder/bls_builder_internal.h     |   3 +
 .../dc/bls_builder/dcn401_init_builder.c      | 812 ++++++++++--------
 .../dc/bls_builder/dcn401_init_builder.h      |  16 -
 .../bls_builder/dcn401_init_builder_legacy.c  |  77 ++
 .../dc/bls_builder/dcn401_query_builder.c     |  41 +
 .../display/dc/bls_executor/bls_executor.c    |  79 +-
 .../display/dc/bls_executor/bls_executor.h    |   2 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |   2 +
 .../drm/amd/display/dc/core2/dc_core2_init.c  | 298 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../amd/display/dc/dc_api_dispatch/api_shim.c |   1 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |   3 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  19 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../amd/display/dc/inc/dc_core_interface.h    |   6 +
 .../dc/pmfw_messenger/dcn401_pmfw_messenger.c | 211 +++++
 .../dc/pmfw_messenger/pmfw_messenger.c        |  62 ++
 .../dc/pmfw_messenger/pmfw_messenger.h        | 118 +++
 21 files changed, 1395 insertions(+), 449 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index a7dd6a7ba492..4dac84158822 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -91,9 +91,12 @@ FILES += bls_builder/dcn401_init_builder.o
 FILES += bls_builder/dcn401_init_builder_legacy.o
 FILES += bls_builder/dcn401_non_seamless_builder.o
 FILES += state_facts/state_facts.o
+FILES += bls_builder/dcn401_query_builder.o
 FILES += bls_executor/bls_executor.o
 FILES += workaround_manager/workaround_manager.o
 FILES += dmub_messenger/dmub_messenger.o
+FILES += pmfw_messenger/pmfw_messenger.o
+FILES += pmfw_messenger/dcn401_pmfw_messenger.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
index 8ac202487189..80771e7751bb 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
@@ -6,6 +6,25 @@
 #include "dm_services.h"
 #include "bls_builder/bls_builder_internal.h"
 
+const struct bls_builder *dcn401_bls_builder_create(
+		enum bls_builder_name name)
+{
+	switch (name) {
+	case DCN_DECL_INITIALIZATION:
+		return dcn401_initialization_builder();
+	case DCN_DECL_INITIALIZATION_LEGACY:
+		return dcn401_legacy_initialization_builder();
+	case DCN_DECL_NON_SEAMLESS_COMMIT:
+		return dcn401_non_seamless_commit_builder();
+	case DCN_DECL_SEAMLESS_UPDATE:
+		return dcn401_seamless_update_builder();
+	case DCN_DECL_QUERY_ACCELERATED_MODE:
+		return dcn401_accelerated_mode_query_builder();
+	default:
+		return NULL;
+	}
+}
+
 const struct bls_builder *bls_builder_create(struct dc *dc,
 		enum bls_builder_name name)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index ad0348b3cae5..627c6186d135 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -11,6 +11,7 @@
 #include "hwss/hw_sequencer.h"
 #include "bls_builder/dmub_abi.h"
 #include "bls_builder/bls_builder_legacy_init.h"
+#include "pmfw_messenger/pmfw_messenger.h"
 
 #define DC2_BLS_MAX_STEPS 192
 
@@ -18,7 +19,6 @@ enum bls_builder_result {
 	BLS_BUILD_SUCCESS,
 	BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE,
 	BLS_BUILD_ERROR_RESOURCE_MAPPING,
-	BLS_BUILD_ERROR_DMUB_ABI_UNRESOLVED,
 };
 
 enum bls_builder_name {
@@ -35,22 +35,59 @@ enum bls_builder_kind {
 	BLS_BUILDER_IMPERATIVE,
 };
 
-struct bls_builder_output_init {
+#define BLS_BUILDER_INIT_MAX_STAGE_COUNT 4
+
+struct bls_builder_dpm {
+	uint32_t num_levels;
+	uint32_t dpm_level[PMFW_MAX_NUM_DPM_LVL];
+	uint32_t dc_mode_max;
+};
+
+struct bls_builder_dpm_levels {
+	uint32_t levels[PMFW_MAX_NUM_DPM_LVL];
+};
+
+struct dcn401_bls_builder_initialization_stage_1 {
 	unsigned int xtalin_clock_inKhz;
 	unsigned int dccg_ref_clock_inKhz;
+	struct dmub_feature_caps feature_caps;
+	uint32_t smu_version;
+	uint32_t num_umc_channels;
+	uint32_t dpm_level_count[PMFW_CLOCK_COUNT];
+	int32_t dc_mode_max[PMFW_CLOCK_COUNT];
+};
+
+struct dcn401_bls_builder_initialization_stage_2 {
 	unsigned int dchub_ref_clock_inKhz;
-	unsigned int dchub_ref_clock_inKhz_before;
-	unsigned int backlight;
-	bool dcmode_power_limits_present;
-	unsigned int dmub_stop_fw_response;
+	struct bls_builder_dpm_levels dpm_levels[PMFW_CLOCK_COUNT];
+};
+
+struct bls_builder_initialization_output {
 	struct dmub_abi dmub_abi;
-	union dmub_rb_cmd dmub_query_feature_caps_cmd;
-	union dmub_rb_cmd dmub_initialize_dcn_cmd;
+	uint32_t smu_version;
+	uint32_t num_umc_channels;
+	unsigned int xtalin_clock_inKhz;
+	unsigned int dccg_ref_clock_inKhz;
+	unsigned int dchub_ref_clock_inKhz;
+	struct bls_builder_dpm dpm_clocks[PMFW_CLOCK_COUNT];
+};
+
+struct dcn401_bls_builder_initialization_stages {
+	struct dcn401_bls_builder_initialization_stage_1 stage_1;
+	struct dcn401_bls_builder_initialization_stage_2 stage_2;
+};
+
+struct bls_builder_initialization {
+	uint32_t stage;
+	union {
+		struct dcn401_bls_builder_initialization_stages dcn401_stages;
+	};
+	struct bls_builder_initialization_output output;
 };
 
 struct bls_builder_output_targets {
 	union {
-		struct bls_builder_output_init *DCN_DECL_INITIALIZATION;
+		struct bls_builder_initialization *DCN_DECL_INITIALIZATION;
 		struct bls_builder_legacy_hw_init_info *DCN_DECL_INITIALIZATION_LEGACY;
 		bool *DCN_DECL_QUERY_ACCELERATED_MODE;
 	};
@@ -66,16 +103,6 @@ struct bls_builder_declarative_params {
 	struct dc *dc;
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
-	const struct dmub_abi *dmub_abi;
-	const struct dmub_srv_hw_params *dmub_hw_params;
-	/*
-	 * Filled when the caller does not pass dmub_hw_params and dmub_srv
-	 * already retained framebuffer windows. fb_info on dmub_srv is
-	 * const, so the window table is copied here before the PSP entry
-	 * points at owned_dmub_hw_params.
-	 */
-	struct dmub_srv_hw_params owned_dmub_hw_params;
-	struct dmub_srv_fb_info owned_dmub_fb_info;
 	struct bls_builder_output_targets *out_targets;
 	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
 	unsigned int head_num_steps;
@@ -89,6 +116,8 @@ typedef bool (*bls_builder_check_capability)(
 typedef enum bls_builder_result (*bls_builder_build_declarative)(
 		struct bls_builder_declarative_params *params);
 
+typedef void (*bls_builder_postprocess)(struct bls_builder_declarative_params *params);
+
 struct bls_builder {
 	enum bls_builder_name name;
 	enum bls_builder_kind kind;
@@ -96,6 +125,7 @@ struct bls_builder {
 	union {
 		bls_builder_build_declarative declarative;
 	} build;
+	bls_builder_postprocess postprocess;
 };
 
 const struct bls_builder *bls_builder_create(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
index ebf315e31ad8..265c4c2b4b9e 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
@@ -9,5 +9,8 @@
 
 const struct bls_builder *dcn401_bls_builder_create(
 		enum bls_builder_name name);
+const struct bls_builder *dcn401_initialization_builder(void);
+const struct bls_builder *dcn401_legacy_initialization_builder(void);
+const struct bls_builder *dcn401_accelerated_mode_query_builder(void);
 const struct bls_builder *dcn401_non_seamless_commit_builder(void);
 const struct bls_builder *dcn401_seamless_update_builder(void);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 1dc502c0839c..cdf5e7ee04fd 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -9,441 +9,521 @@
 #include "dccg.h"
 #include "resource.h"
 #include "dc_dmub_srv.h"
+#include "dc_bios_types.h"
 #include "dmub_cmd.h"
 #include "bls_builder/bls_builder_internal.h"
 #include "bls_builder/dcn401_init_builder.h"
 #include "bls_builder/dcn401_init_builder_legacy.h"
 
-static const enum block_sequence_func dcn401_dc2_init_sequence[] = {
-	LEGACY_CLK_MGR_INIT_CLOCKS,
-	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
-	DCCG_INITIALIZE_CLOCKS,
-	DMUB_HALT_FW,
-	PSP_RELOAD_DMUB_FW,
-	DMUB_GPINT_SEND_AND_WAIT,
-	DMUB_SEND_DMCUB_CMD,
-	DMUB_INITIALIZE_DCN,
+enum dcn401_init_builder_stages {
+	DCN401_INIT_BUILDER_STAGE1,
+	DCN401_INIT_BUILDER_STAGE2,
+	DCN401_INIT_BUILDER_DONE,
+	DCN401_INIT_BUILDER_STAGE_COUNT,
 };
 
-static enum bls_builder_result dcn401_check_initialization_support(
-		const struct bls_builder_check_capability_params *params)
-{
-	struct dc *dc;
-
-	if (!params || !params->dc)
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+static_assert(DCN401_INIT_BUILDER_DONE <= BLS_BUILDER_INIT_MAX_STAGE_COUNT,
+		"Core runs at most BLS_BUILDER_INIT_MAX_STAGE_COUNT stages");
+
+enum dcn401_pmfw_clk {
+	DCN401_PMFW_CLK_SOCCLK  = 1,
+	DCN401_PMFW_CLK_UCLK    = 2,
+	DCN401_PMFW_CLK_FCLK    = 3,
+	DCN401_PMFW_CLK_DISPCLK = 6,
+	DCN401_PMFW_CLK_DPPCLK  = 7,
+	DCN401_PMFW_CLK_DCFCLK  = 9,
+	DCN401_PMFW_CLK_DTBCLK  = 10,
+};
 
-	dc = params->dc;
-	if (!dc->ctx || !dc->res_pool || !dc->res_pool->dccg)
-		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-	if (dc->config.seamless_boot_edp_requested)
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+#define DCN401_PMFW_CLK_PARAM(clk) ((uint32_t)(clk) << 16)
+#define DCN401_PMFW_DPM_FREQ_PARAM(clk, level) (DCN401_PMFW_CLK_PARAM(clk) | ((uint32_t)(level) & 0xFF))
+
+#define DCN401_PMFW_LEVEL_COUNT_INDEX 0xFF
+#define DCN401_PMFW_LEVEL_COUNT(clk) DCN401_PMFW_DPM_FREQ_PARAM(clk, DCN401_PMFW_LEVEL_COUNT_INDEX)
+
+#define DCN401_PMFW_SOCCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_SOCCLK)
+#define DCN401_PMFW_UCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_UCLK)
+#define DCN401_PMFW_FCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_FCLK)
+#define DCN401_PMFW_DISPCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_DISPCLK)
+#define DCN401_PMFW_DPPCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_DPPCLK)
+#define DCN401_PMFW_DCFCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_DCFCLK)
+#define DCN401_PMFW_DTBCLK_LEVEL_COUNT DCN401_PMFW_LEVEL_COUNT(DCN401_PMFW_CLK_DTBCLK)
+
+static const enum dcn401_pmfw_clk dcn401_pmfw_clocks[PMFW_CLOCK_COUNT] = {
+	[PMFW_CLOCK_DCFCLK] = DCN401_PMFW_CLK_DCFCLK,
+	[PMFW_CLOCK_SOCCLK] = DCN401_PMFW_CLK_SOCCLK,
+	[PMFW_CLOCK_DTBCLK] = DCN401_PMFW_CLK_DTBCLK,
+	[PMFW_CLOCK_DISPCLK] = DCN401_PMFW_CLK_DISPCLK,
+	[PMFW_CLOCK_DPPCLK] = DCN401_PMFW_CLK_DPPCLK,
+	[PMFW_CLOCK_UCLK] = DCN401_PMFW_CLK_UCLK,
+	[PMFW_CLOCK_FCLK] = DCN401_PMFW_CLK_FCLK,
+};
 
-	return BLS_BUILD_SUCCESS;
-}
+static const struct block_sequence dcn401_init_stage1_sequence[] = {
+	{
+		.func = DMUB_SEND_DMCUB_CMD2,
+		.params.send_dmcub_cmd2_params.cmd.cmd_common.header =  {
+			.type = DMUB_CMD__DC_BLS,
+			.sub_type = DMUB_CMD__DC_BLS_DCN_INIT,
+			.payload_bytes = 0,
+		},
+		.params.send_dmcub_cmd2_params.wait_type = DM_DMUB_WAIT_TYPE_WAIT,
+	},
+	{
+		.func = DMUB_SEND_DMCUB_CMD2,
+		.params.send_dmcub_cmd2_params.cmd.query_feature_caps.header =  {
+			.type = DMUB_CMD__QUERY_FEATURE_CAPS,
+			.ret_status = 1,
+			.payload_bytes = sizeof(struct dmub_cmd_query_feature_caps_data),
+		},
+		.params.send_dmcub_cmd2_params.wait_type = DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY,
+	},
+	{
+		.func = DMUB_SEND_DMCUB_CMD2,
+		.params.send_dmcub_cmd2_params.cmd.idle_opt_set_dc_power_state = {
+			.header = {
+				.type = DMUB_CMD__IDLE_OPT,
+				.sub_type = DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE,
+				.payload_bytes = sizeof(struct dmub_idle_opt_set_dc_power_state_data),
+			},
+			.data.power_state = DMUB_IDLE_OPT_DC_POWER_STATE_D0,
+		},
+		.params.send_dmcub_cmd2_params.wait_type = DM_DMUB_WAIT_TYPE_WAIT,
+	},
+	{
+		.func = DCCG_GET_REF_FREQ,
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.message = {
+				.msg_id = PMFW_MSG_GET_SMU_VERSION,
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.message = {
+				.msg_id = PMFW_MSG_GET_DRIVER_IF_VERSION,
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.message = {
+				.msg_id = PMFW_MSG_GET_MSG_HEADER_VERSION,
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_NUM_UMC_CHANNELS,
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_SOCCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_UCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_FCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_DISPCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_DPPCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_DCFCLK_LEVEL_COUNT },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = { DCN401_PMFW_DTBCLK_LEVEL_COUNT },
+			}
+		}
+	},
+
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_SOCCLK) },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_UCLK) },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_FCLK) },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_DISPCLK) },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_DCFCLK) },
+			}
+		}
+	},
+	{
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+				.param_count = 1,
+				.params = { DCN401_PMFW_CLK_PARAM(DCN401_PMFW_CLK_DTBCLK) },
+			}
+		}
+	},
+	{
+		.func = HWSS_ENABLE_ACCELERATED_MODE,
+	},
+};
 
 static bool dcn401_initialization_check_capability(
 		const struct bls_builder_check_capability_params *params)
 {
-	return dcn401_check_initialization_support(params) ==
-			BLS_BUILD_SUCCESS;
+	return params && params->dc &&
+			!params->dc->config.seamless_boot_edp_requested;
 }
 
-static enum bls_builder_result dcn401_validate_initialization_step(
-		const struct bls_builder_declarative_params *params,
-		enum block_sequence_func func)
+static enum bls_builder_result dcn401_build_initialization_step(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence *step)
 {
-	struct bls_builder_output_init *out_init = NULL;
-	struct clk_mgr *clk_mgr = params->dc->clk_mgr;
-	struct dccg *dccg = params->dc->res_pool->dccg;
-
-	if (params->out_targets)
-		out_init = params->out_targets->DCN_DECL_INITIALIZATION;
-
-	switch (func) {
-	case LEGACY_CLK_MGR_INIT_CLOCKS:
-		if (!clk_mgr || !clk_mgr->funcs ||
-				!clk_mgr->funcs->init_clocks)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
-	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
-		if (!clk_mgr || !clk_mgr->funcs ||
-				!clk_mgr->funcs->is_dc_mode_present ||
-				!out_init)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
-	case DCCG_INITIALIZE_CLOCKS:
-		if (!dccg->funcs || !dccg->funcs->dccg_init)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
-	case DMUB_GPINT_SEND_AND_WAIT:
-	case DMUB_HALT_FW: {
-		struct dc_context *ctx = params->dc->ctx;
-		struct dmub_srv *dmub;
-
-		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub || !out_init)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		dmub = ctx->dmub_srv->dmub;
-		if (!dmub->sw_init || !dmub->hw_funcs.set_gpint ||
-				!dmub->hw_funcs.is_gpint_acked ||
-				!dmub->hw_funcs.get_gpint_response)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
-	}
-	case PSP_RELOAD_DMUB_FW: {
-		struct dmub_srv *dmub;
-
-		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
-				!params->dc->ctx->dmub_srv->dmub)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		/*
-		 * An explicit caller pointer wins, including a test double
-		 * whose fb_info is still empty. Otherwise use the windows
-		 * dmub_srv retained from the DM's earlier hw init.
-		 */
-		if (params->dmub_hw_params)
-			return BLS_BUILD_SUCCESS;
-		dmub = params->dc->ctx->dmub_srv->dmub;
-		if (!dmub->fb_info ||
-				dmub->fb_info->num_fb < DMUB_WINDOW_TOTAL)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
-	}
-	case DMUB_SEND_DMCUB_CMD:
-	case DMUB_INITIALIZE_DCN:
-		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
-				!params->dc->ctx->dmub_srv->dmub || !out_init)
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-		return BLS_BUILD_SUCCESS;
+	struct dc *dc = params->dc;
+	struct dcn401_bls_builder_initialization_stages *stages =
+			&params->out_targets->DCN_DECL_INITIALIZATION->dcn401_stages;
+	struct block_sequence_state sequence = {
+		.steps = params->head_sequence,
+		.num_steps = &params->head_num_steps,
+	};
+
+	switch (step->func) {
+	case DMUB_SEND_DMCUB_CMD2:
+		step->params.send_dmcub_cmd2_params.ctx = dc->ctx;
+		break;
+	case DCCG_GET_REF_FREQ:
+		step->params.dccg_get_ref_freq_params.dccg = dc->res_pool->dccg;
+		step->params.dccg_get_ref_freq_params.xtalin_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		step->params.dccg_get_ref_freq_params.out_xtalin_khz =
+				&stages->stage_1.xtalin_clock_inKhz;
+		step->params.dccg_get_ref_freq_params.out_dccg_ref_khz =
+				&stages->stage_1.dccg_ref_clock_inKhz;
+		break;
+	case HUBBUB_GET_DCHUB_REF_FREQ:
+		step->params.hubbub_get_dchub_ref_freq_params.hubbub = dc->res_pool->hubbub;
+		step->params.hubbub_get_dchub_ref_freq_params.dccg_ref_khz =
+				stages->stage_1.dccg_ref_clock_inKhz;
+		step->params.hubbub_get_dchub_ref_freq_params.out_dchub_ref_khz =
+				&stages->stage_2.dchub_ref_clock_inKhz;
+		break;
+	case HWSS_ENABLE_ACCELERATED_MODE:
+		step->params.dc_init_call_params.dc = dc;
+		break;
+	case PMFW_SEND_MESSAGE_AND_WAIT:
+		break;
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
-}
-
-enum bls_builder_result dcn401_build_clk_mgr_init(
-		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence)
-{
-	union block_sequence_params bls_params = {0};
 
-	bls_params.legacy_clk_mgr_init_clocks_params.clk_mgr = clk_mgr;
-	if (!bls_append(sequence, LEGACY_CLK_MGR_INIT_CLOCKS, &bls_params))
+	if (!bls_append(&sequence, step->func, &step->params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
 	return BLS_BUILD_SUCCESS;
 }
 
-enum bls_builder_result dcn401_build_dc_mode_read(
-		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
-		struct block_sequence_state *sequence)
+static enum bls_builder_result dcn401_build_stage1(struct bls_builder_declarative_params *params)
 {
-	union block_sequence_params bls_params = {0};
-
-	bls_params.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr = clk_mgr;
-	bls_params.legacy_clk_mgr_is_dc_mode_present_params
-			.out_dcmode_power_limits_present =
-			out_dcmode_power_limits_present;
-	if (!bls_append(sequence, LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
-			&bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	struct dcn401_bls_builder_initialization_stage_1 *stage_1 =
+			&params->out_targets->DCN_DECL_INITIALIZATION->dcn401_stages.stage_1;
+	enum bls_builder_result result;
+	uint32_t step;
 
-	return BLS_BUILD_SUCCESS;
-}
+	stage_1->xtalin_clock_inKhz = params->dc->res_pool->ref_clocks.xtalin_clock_inKhz;
+	stage_1->dccg_ref_clock_inKhz = params->dc->res_pool->ref_clocks.dccg_ref_clock_inKhz;
 
-enum bls_builder_result dcn401_build_dccg_init(
-		struct dccg *dccg, struct block_sequence_state *sequence)
-{
-	union block_sequence_params bls_params = {0};
+	for (step = 0; step < ARRAY_SIZE(dcn401_init_stage1_sequence); step++) {
+		struct block_sequence block = dcn401_init_stage1_sequence[step];
 
-	bls_params.dccg_initialize_clocks_params.dccg = dccg;
-	if (!bls_append(sequence, DCCG_INITIALIZE_CLOCKS, &bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+		result = dcn401_build_initialization_step(params, &block);
+		if (result != BLS_BUILD_SUCCESS)
+			return result;
+	}
 
 	return BLS_BUILD_SUCCESS;
 }
 
-static inline enum bls_builder_result dcn401_build_dmub_halt_fw(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+static enum bls_builder_result dcn401_build_pmfw_get_dpm_freq(
+		struct bls_builder_declarative_params *params, enum pmfw_clocks clock, uint32_t level)
 {
-	union block_sequence_params bls_params = {0};
-	struct bls_builder_output_init *out_init =
-			params->out_targets->DCN_DECL_INITIALIZATION;
-
-	bls_params.dmub_gpint_params.command_code = DMUB_GPINT__STOP_FW;
-	bls_params.dmub_gpint_params.param = 0;
-	bls_params.dmub_gpint_params.response =
-			&out_init->dmub_stop_fw_response;
-	if (!bls_append(sequence, DMUB_HALT_FW, &bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-
-	return BLS_BUILD_SUCCESS;
-}
+	struct block_sequence block = {
+		.func = PMFW_SEND_MESSAGE_AND_WAIT,
+		.params.pmfw_send_and_wait_params = {
+			.continue_on_error = true,
+			.message = {
+				.msg_id = PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+				.param_count = 1,
+				.params = {
+					DCN401_PMFW_DPM_FREQ_PARAM(dcn401_pmfw_clocks[clock], level),
+				}
+			}
+		}
+	};
 
-static const struct dmub_srv_hw_params *dcn401_psp_hw_params(
-		struct bls_builder_declarative_params *params)
-{
-	struct dmub_srv *dmub;
-
-	if (params->dmub_hw_params)
-		return params->dmub_hw_params;
-
-	dmub = params->dc->ctx->dmub_srv->dmub;
-	params->owned_dmub_fb_info = *dmub->fb_info;
-	memset(&params->owned_dmub_hw_params, 0,
-			sizeof(params->owned_dmub_hw_params));
-	params->owned_dmub_hw_params.fb_info = &params->owned_dmub_fb_info;
-	params->owned_dmub_hw_params.soc_fb_info = dmub->soc_fb_info;
-	params->owned_dmub_hw_params.psp_version = dmub->psp_version;
-	return &params->owned_dmub_hw_params;
+	return dcn401_build_initialization_step(params, &block);
 }
 
-static inline enum bls_builder_result dcn401_build_psp_reload(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+static enum bls_builder_result dcn401_build_stage2(struct bls_builder_declarative_params *params)
 {
-	union block_sequence_params bls_params = {0};
-
-	bls_params.psp_reload_dmub_fw_params.dmub =
-			params->dc->ctx->dmub_srv->dmub;
-	bls_params.psp_reload_dmub_fw_params.hw_params =
-			dcn401_psp_hw_params(params);
-	if (!bls_append(sequence, PSP_RELOAD_DMUB_FW, &bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-
-	return BLS_BUILD_SUCCESS;
-}
+	struct dcn401_bls_builder_initialization_stages *stages =
+			&params->out_targets->DCN_DECL_INITIALIZATION->dcn401_stages;
+	struct block_sequence block = { .func = HUBBUB_GET_DCHUB_REF_FREQ };
+	enum bls_builder_result result;
+	uint32_t clock, level;
 
-static inline enum bls_builder_result dcn401_build_dmub_fw_version(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
-{
-	union block_sequence_params bls_params = {0};
-	struct bls_builder_output_init *out_init =
-			params->out_targets->DCN_DECL_INITIALIZATION;
+	stages->stage_2.dchub_ref_clock_inKhz =
+			params->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz;
+	result = dcn401_build_initialization_step(params, &block);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
 
-	bls_params.dmub_gpint_params.command_code =
-			DMUB_GPINT__GET_FW_VERSION;
-	bls_params.dmub_gpint_params.param = 0;
-	bls_params.dmub_gpint_params.response =
-			&out_init->dmub_abi.fw_version;
-	if (!bls_append(sequence, DMUB_GPINT_SEND_AND_WAIT, &bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	if (stages->stage_1.smu_version != 0) {
+		for (clock = 0; clock < PMFW_CLOCK_COUNT; clock++) {
+			for (level = 0; level < stages->stage_1.dpm_level_count[clock]; level++) {
+				result = dcn401_build_pmfw_get_dpm_freq(params, clock, level);
+				if (result != BLS_BUILD_SUCCESS)
+					return result;
+			}
+		}
+	}
 
 	return BLS_BUILD_SUCCESS;
 }
 
-bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
-		struct dc_context *ctx, union dmub_rb_cmd *cmd,
-		enum dm_dmub_wait_type wait_type, bool continue_on_error)
-{
-	union block_sequence_params bls_params = {0};
-
-	bls_params.send_dmcub_cmd_params.ctx = ctx;
-	bls_params.send_dmcub_cmd_params.cmd = cmd;
-	bls_params.send_dmcub_cmd_params.wait_type = wait_type;
-	bls_params.send_dmcub_cmd_params.continue_on_error = continue_on_error;
-	return bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params);
-}
-
-void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd)
+static void dcn401_process_pmfw_response(
+		struct dcn401_bls_builder_initialization_stages *stages,
+		const struct pmfw_send_and_wait_params *pmfw, uint32_t response)
 {
-	memset(cmd, 0, sizeof(*cmd));
-	cmd->query_feature_caps.header.type = DMUB_CMD__QUERY_FEATURE_CAPS;
-	cmd->query_feature_caps.header.sub_type = 0;
-	cmd->query_feature_caps.header.ret_status = 1;
-	cmd->query_feature_caps.header.payload_bytes =
-			sizeof(struct dmub_cmd_query_feature_caps_data);
+	uint32_t level = pmfw->message.params[0] & 0xFF;
+	uint32_t clock;
+
+	switch (pmfw->message.msg_id) {
+	case PMFW_MSG_GET_SMU_VERSION:
+		stages->stage_1.smu_version = response;
+		break;
+	case PMFW_MSG_GET_NUM_UMC_CHANNELS:
+		stages->stage_1.num_umc_channels = response;
+		break;
+	case PMFW_MSG_GET_DPM_FREQ_BY_INDEX:
+	case PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ:
+		for (clock = 0; clock < PMFW_CLOCK_COUNT; clock++) {
+			if ((pmfw->message.params[0] >> 16) != (uint32_t)dcn401_pmfw_clocks[clock])
+				continue;
+			if (pmfw->message.msg_id == PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ)
+				stages->stage_1.dc_mode_max[clock] = (int32_t)response;
+			else if (level == DCN401_PMFW_LEVEL_COUNT_INDEX)
+				stages->stage_1.dpm_level_count[clock] = min(
+						(response & (1U << 31)) ? 2U : response & 0xFF,
+						(uint32_t)PMFW_MAX_NUM_DPM_LVL);
+			else if (level < stages->stage_1.dpm_level_count[clock])
+				stages->stage_2.dpm_levels[clock].levels[level] = response & 0xFFFF;
+			break;
+		}
+		break;
+	default:
+		break;
+	}
 }
 
-static inline enum bls_builder_result dcn401_build_dmub_feature_caps(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+static void dcn401_fill_initialization_output(struct bls_builder_declarative_params *params)
 {
-	struct bls_builder_output_init *out_init =
+	struct bls_builder_initialization *initialization =
 			params->out_targets->DCN_DECL_INITIALIZATION;
-	union dmub_rb_cmd *cmd = &out_init->dmub_query_feature_caps_cmd;
-
-	dcn401_fill_query_feature_caps_cmd(cmd);
-	if (!dcn401_add_dmub_cmd(sequence, params->dc->ctx, cmd,
-			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY, false))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-
-	return BLS_BUILD_SUCCESS;
+	const struct dcn401_bls_builder_initialization_stages *stages =
+			&initialization->dcn401_stages;
+	struct bls_builder_initialization_output *output = &initialization->output;
+	uint32_t clock;
+
+	output->dmub_abi.fw_version = params->dc->ctx->dmub_srv->dmub->fw_version;
+	output->dmub_abi.feature_caps = stages->stage_1.feature_caps;
+	output->smu_version = stages->stage_1.smu_version;
+	output->num_umc_channels = stages->stage_1.num_umc_channels;
+	output->xtalin_clock_inKhz = stages->stage_1.xtalin_clock_inKhz;
+	output->dccg_ref_clock_inKhz = stages->stage_1.dccg_ref_clock_inKhz;
+	output->dchub_ref_clock_inKhz = stages->stage_2.dchub_ref_clock_inKhz;
+	for (clock = 0; clock < PMFW_CLOCK_COUNT; clock++) {
+		struct bls_builder_dpm *dpm = &output->dpm_clocks[clock];
+
+		dpm->num_levels = stages->stage_1.dpm_level_count[clock];
+		dpm->dc_mode_max = (uint32_t)stages->stage_1.dc_mode_max[clock];
+		memcpy(dpm->dpm_level, stages->stage_2.dpm_levels[clock].levels,
+				sizeof(dpm->dpm_level));
+	}
 }
 
-static inline enum bls_builder_result dcn401_build_dmub_initialize_dcn(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+static void dcn401_postprocess_initialization(struct bls_builder_declarative_params *params)
 {
-	union block_sequence_params bls_params = {0};
-	struct bls_builder_output_init *out_init =
+	struct bls_builder_initialization *initialization =
 			params->out_targets->DCN_DECL_INITIALIZATION;
-	union dmub_rb_cmd *cmd = &out_init->dmub_initialize_dcn_cmd;
-
-	/*
-	 * No Initialize DCN opcode exists in dmub_cmd.h. A caller-supplied
-	 * non-zero type is preserved for tests; zero stays an undefined
-	 * command and cannot complete a successful build.
-	 */
-	if (!cmd->cmd_common.header.type)
-		memset(cmd, 0, sizeof(*cmd));
-	bls_params.send_dmcub_cmd_params.ctx = params->dc->ctx;
-	bls_params.send_dmcub_cmd_params.cmd = cmd;
-	bls_params.send_dmcub_cmd_params.wait_type =
-			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY;
-	if (!bls_append(sequence, DMUB_INITIALIZE_DCN, &bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-
-	return BLS_BUILD_SUCCESS;
-}
-
-static enum bls_builder_result dcn401_build_initialization_step(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence,
-		enum block_sequence_func func)
-{
-	switch (func) {
-	case LEGACY_CLK_MGR_INIT_CLOCKS:
-		return dcn401_build_clk_mgr_init(params->dc->clk_mgr, sequence);
-	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
-		return dcn401_build_dc_mode_read(params->dc->clk_mgr,
-				&params->out_targets->DCN_DECL_INITIALIZATION
-				->dcmode_power_limits_present, sequence);
-	case DCCG_INITIALIZE_CLOCKS:
-		return dcn401_build_dccg_init(params->dc->res_pool->dccg,
-				sequence);
-	case DMUB_HALT_FW:
-		return dcn401_build_dmub_halt_fw(params, sequence);
-	case PSP_RELOAD_DMUB_FW:
-		return dcn401_build_psp_reload(params, sequence);
-	case DMUB_GPINT_SEND_AND_WAIT:
-		return dcn401_build_dmub_fw_version(params, sequence);
-	case DMUB_SEND_DMCUB_CMD:
-		return dcn401_build_dmub_feature_caps(params, sequence);
-	case DMUB_INITIALIZE_DCN:
-		return dcn401_build_dmub_initialize_dcn(params, sequence);
-	default:
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	struct dcn401_bls_builder_initialization_stages *stages = &initialization->dcn401_stages;
+	uint32_t step;
+
+	if (initialization->stage >= DCN401_INIT_BUILDER_DONE)
+		return;
+
+	for (step = 0; step < params->head_num_steps; step++) {
+		const struct block_sequence *block = &params->head_sequence[step];
+		const struct pmfw_send_and_wait_params *pmfw;
+
+		switch (block->func) {
+		case DMUB_SEND_DMCUB_CMD2: {
+			const union dmub_rb_cmd *cmd = &block->params.send_dmcub_cmd2_params.cmd;
+
+			if (cmd->cmd_common.header.type == DMUB_CMD__QUERY_FEATURE_CAPS &&
+					cmd->cmd_common.header.ret_status == 0)
+				memcpy(&stages->stage_1.feature_caps,
+						&cmd->query_feature_caps.query_feature_caps_data,
+						sizeof(stages->stage_1.feature_caps));
+			break;
+		}
+		case PMFW_SEND_MESSAGE_AND_WAIT:
+			pmfw = &block->params.pmfw_send_and_wait_params;
+			if (!pmfw->response.response_count)
+				break;
+			dcn401_process_pmfw_response(stages, pmfw, pmfw->response.response[0]);
+			break;
+		default:
+			break;
+		}
 	}
+
+	initialization->stage++;
+	if (initialization->stage == DCN401_INIT_BUILDER_DONE)
+		dcn401_fill_initialization_output(params);
 }
 
-static enum bls_builder_result dcn401_build_initialization(
-		struct bls_builder_declarative_params *params)
+static enum bls_builder_result dcn401_build_initialization(struct bls_builder_declarative_params *params)
 {
-	struct bls_builder_check_capability_params check_params = {0};
-	enum bls_builder_result result;
-	struct block_sequence_state sequence;
-	struct bls_builder_output_init *out_init = NULL;
-	unsigned int i;
-
-	if (!params)
-		return dcn401_check_initialization_support(NULL);
-
-	check_params.dc = params->dc;
-	check_params.current_state = params->current_state;
-	check_params.new_state = params->new_state;
-	result =
-			dcn401_check_initialization_support(&check_params);
-	if (result != BLS_BUILD_SUCCESS)
-		return result;
+	struct bls_builder_initialization *initialization =
+			params->out_targets->DCN_DECL_INITIALIZATION;
 
 	params->head_num_steps = 0;
 	params->tail_num_steps = 0;
-	for (i = 0; i < ARRAY_SIZE(dcn401_dc2_init_sequence); i++) {
-		result = dcn401_validate_initialization_step(params,
-				dcn401_dc2_init_sequence[i]);
-		if (result != BLS_BUILD_SUCCESS)
-			return result;
-	}
-
-	sequence.steps = params->head_sequence;
-	sequence.num_steps = &params->head_num_steps;
-	if (params->out_targets)
-		out_init = params->out_targets->DCN_DECL_INITIALIZATION;
-	if (out_init) {
-		out_init->dcmode_power_limits_present = false;
-		out_init->dmub_stop_fw_response = 0;
-		out_init->dmub_abi.fw_version = 0;
-		memset(&out_init->dmub_abi.feature_caps, 0,
-				sizeof(out_init->dmub_abi.feature_caps));
-	}
-
-	/*
-	 * LEGACY/pmfw-msg: preserve the clock-manager entry points until
-	 * PMFW Messenger can express the same calls, order, and output.
-	 */
-	for (i = 0; i < ARRAY_SIZE(dcn401_dc2_init_sequence); i++) {
-		result = dcn401_build_initialization_step(params, &sequence,
-				dcn401_dc2_init_sequence[i]);
-		if (result != BLS_BUILD_SUCCESS)
-			return result;
-	}
 
-	if (out_init &&
-			out_init->dmub_initialize_dcn_cmd.cmd_common.header.type)
+	if (initialization->stage >= DCN401_INIT_BUILDER_DONE)
 		return BLS_BUILD_SUCCESS;
-
-	return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	if (initialization->stage == DCN401_INIT_BUILDER_STAGE1)
+		return dcn401_build_stage1(params);
+	return dcn401_build_stage2(params);
 }
 
-/* Reads the VBIOS accelerated-mode bit into the caller's out-target. */
-static enum bls_builder_result dcn401_build_accelerated_mode_query(
-		struct bls_builder_declarative_params *params)
+const struct bls_builder *dcn401_initialization_builder(void)
 {
-	union block_sequence_params bls_params = {0};
-	struct block_sequence_state sequence;
-	struct dc_bios *dcb;
-
-	if (!params || !params->dc || !params->dc->ctx || !params->out_targets ||
-			!params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE)
-		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-	dcb = params->dc->ctx->dc_bios;
-	if (!dcb || !dcb->funcs || !dcb->funcs->is_accelerated_mode)
-		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-
-	sequence.steps = params->head_sequence;
-	sequence.num_steps = &params->head_num_steps;
-	bls_params.bios_is_accelerated_mode_params.dcb = dcb;
-	bls_params.bios_is_accelerated_mode_params.out_accelerated_mode =
-			params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE;
-	if (!bls_append(&sequence, BIOS_IS_ACCELERATED_MODE, &bls_params))
-		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
-	return BLS_BUILD_SUCCESS;
-}
-
-const struct bls_builder *dcn401_bls_builder_create(
-		enum bls_builder_name name)
-{
-	static const struct bls_builder initialization_builder = {
+	static const struct bls_builder builder = {
 		.name = DCN_DECL_INITIALIZATION,
 		.kind = BLS_BUILDER_DECLARATIVE,
 		.check_capability = dcn401_initialization_check_capability,
 		.build.declarative = dcn401_build_initialization,
-	};
-	static const struct bls_builder legacy_initialization_builder = {
-		.name = DCN_DECL_INITIALIZATION_LEGACY,
-		.kind = BLS_BUILDER_DECLARATIVE,
-		.check_capability = dcn401_dc1_initialization_check_capability,
-		.build.declarative = dcn401_build_dc1_initialization,
-	};
-	static const struct bls_builder accelerated_mode_query_builder = {
-		.name = DCN_DECL_QUERY_ACCELERATED_MODE,
-		.kind = BLS_BUILDER_DECLARATIVE,
-		.build.declarative = dcn401_build_accelerated_mode_query,
+		.postprocess = dcn401_postprocess_initialization,
 	};
 
-	switch (name) {
-	case DCN_DECL_INITIALIZATION:
-		return &initialization_builder;
-	case DCN_DECL_INITIALIZATION_LEGACY:
-		return &legacy_initialization_builder;
-	case DCN_DECL_NON_SEAMLESS_COMMIT:
-		return dcn401_non_seamless_commit_builder();
-	case DCN_DECL_SEAMLESS_UPDATE:
-		return dcn401_seamless_update_builder();
-	case DCN_DECL_QUERY_ACCELERATED_MODE:
-		return &accelerated_mode_query_builder;
-	default:
-		return NULL;
-	}
+	return &builder;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
index fe70971cb8a5..714990f1fd9a 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
@@ -7,10 +7,6 @@
 
 #include "bls_builder/bls_builder.h"
 
-struct clk_mgr;
-struct dccg;
-struct dc_context;
-
 static inline bool bls_append(struct block_sequence_state *sequence,
 		enum block_sequence_func func,
 		const union block_sequence_params *params)
@@ -28,15 +24,3 @@ static inline bool bls_append(struct block_sequence_state *sequence,
 	(*sequence->num_steps)++;
 	return true;
 }
-
-enum bls_builder_result dcn401_build_clk_mgr_init(
-		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence);
-enum bls_builder_result dcn401_build_dc_mode_read(
-		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
-		struct block_sequence_state *sequence);
-enum bls_builder_result dcn401_build_dccg_init(
-		struct dccg *dccg, struct block_sequence_state *sequence);
-bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
-		struct dc_context *ctx, union dmub_rb_cmd *cmd,
-		enum dm_dmub_wait_type wait_type, bool continue_on_error);
-void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
index e13c16920a0c..b47d2deed2a9 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
@@ -21,6 +21,7 @@
 #include "dce/dce_hwseq.h"
 #include "hwss/hw_sequencer_private.h"
 #include "dcn32/dcn32_resource.h"
+#include "bls_builder/bls_builder_internal.h"
 #include "bls_builder/dcn401_init_builder.h"
 #include "bls_builder/dcn401_init_builder_legacy.h"
 
@@ -60,6 +61,70 @@ static bool dcn401_dc1_has_dmub(struct dc *dc)
 	return dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
 }
 
+static enum bls_builder_result dcn401_build_clk_mgr_init(
+		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.legacy_clk_mgr_init_clocks_params.clk_mgr = clk_mgr;
+	if (!bls_append(sequence, LEGACY_CLK_MGR_INIT_CLOCKS, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_build_dc_mode_read(
+		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr = clk_mgr;
+	bls_params.legacy_clk_mgr_is_dc_mode_present_params
+			.out_dcmode_power_limits_present =
+			out_dcmode_power_limits_present;
+	if (!bls_append(sequence, LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
+			&bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_build_dccg_init(
+		struct dccg *dccg, struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dccg_initialize_clocks_params.dccg = dccg;
+	if (!bls_append(sequence, DCCG_INITIALIZE_CLOCKS, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
+		struct dc_context *ctx, union dmub_rb_cmd *cmd,
+		enum dm_dmub_wait_type wait_type, bool continue_on_error)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.send_dmcub_cmd_params.ctx = ctx;
+	bls_params.send_dmcub_cmd_params.cmd = cmd;
+	bls_params.send_dmcub_cmd_params.wait_type = wait_type;
+	bls_params.send_dmcub_cmd_params.continue_on_error = continue_on_error;
+	return bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params);
+}
+
+static void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->query_feature_caps.header.type = DMUB_CMD__QUERY_FEATURE_CAPS;
+	cmd->query_feature_caps.header.sub_type = 0;
+	cmd->query_feature_caps.header.ret_status = 1;
+	cmd->query_feature_caps.header.payload_bytes =
+			sizeof(struct dmub_cmd_query_feature_caps_data);
+}
+
 static enum bls_builder_result dcn401_validate_dc1_links(struct dc *dc)
 {
 	struct dc_bios *dcb = dc->ctx->dc_bios;
@@ -1069,3 +1134,15 @@ bool dcn401_dc1_initialization_check_capability(
 	return params && params->dc && params->dc->ctx &&
 			params->dc->res_pool;
 }
+
+const struct bls_builder *dcn401_legacy_initialization_builder(void)
+{
+	static const struct bls_builder builder = {
+		.name = DCN_DECL_INITIALIZATION_LEGACY,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_dc1_initialization_check_capability,
+		.build.declarative = dcn401_build_dc1_initialization,
+	};
+
+	return &builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
new file mode 100644
index 000000000000..d2c67d1df637
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
@@ -0,0 +1,41 @@
+#include "dm_services.h"
+#include "core_types.h"
+#include "dc_bios_types.h"
+#include "bls_builder/bls_builder_internal.h"
+#include "bls_builder/dcn401_init_builder.h"
+
+/* Reads the VBIOS accelerated-mode bit into the caller's out-target. */
+static enum bls_builder_result dcn401_build_accelerated_mode_query(
+		struct bls_builder_declarative_params *params)
+{
+	union block_sequence_params bls_params = {0};
+	struct block_sequence_state sequence;
+	struct dc_bios *dcb;
+
+	if (!params || !params->dc || !params->dc->ctx || !params->out_targets ||
+			!params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	dcb = params->dc->ctx->dc_bios;
+	if (!dcb || !dcb->funcs || !dcb->funcs->is_accelerated_mode)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+	bls_params.bios_is_accelerated_mode_params.dcb = dcb;
+	bls_params.bios_is_accelerated_mode_params.out_accelerated_mode =
+			params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE;
+	if (!bls_append(&sequence, BIOS_IS_ACCELERATED_MODE, &bls_params))
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	return BLS_BUILD_SUCCESS;
+}
+
+const struct bls_builder *dcn401_accelerated_mode_query_builder(void)
+{
+	static const struct bls_builder builder = {
+		.name = DCN_DECL_QUERY_ACCELERATED_MODE,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.build.declarative = dcn401_build_accelerated_mode_query,
+	};
+
+	return &builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 297ddbed2eac..47278d7057d5 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -66,6 +66,16 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 		ctx = step->params.send_dmcub_cmd_params.ctx;
 		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
 				!step->params.send_dmcub_cmd_params.cmd ||
+				!step->params.send_dmcub_cmd_params.cmd->cmd_common
+				.header.type ||
+				(ctx->dmub_srv->idle_allowed && !ctx->dc))
+			return false;
+		return true;
+	case DMUB_SEND_DMCUB_CMD2:
+		ctx = step->params.send_dmcub_cmd2_params.ctx;
+		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
+				!step->params.send_dmcub_cmd2_params.cmd.cmd_common
+				.header.type ||
 				(ctx->dmub_srv->idle_allowed && !ctx->dc))
 			return false;
 		return true;
@@ -89,15 +99,6 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 				hw_params && hw_params->fb_info &&
 				hw_params->fb_info->num_fb >= DMUB_WINDOW_TOTAL;
 	}
-	case DMUB_INITIALIZE_DCN:
-		ctx = step->params.send_dmcub_cmd_params.ctx;
-		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
-				!step->params.send_dmcub_cmd_params.cmd ||
-				!step->params.send_dmcub_cmd_params.cmd->cmd_common
-				.header.type ||
-				(ctx->dmub_srv->idle_allowed && !ctx->dc))
-			return false;
-		return true;
 	case OPTC_SET_ODM_MEM_POWER: {
 		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
 
@@ -638,6 +639,11 @@ static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 	case MPC_SET_OUTPUT_GAMMA:
 		mpc = step->params.mpc_set_output_gamma_params.mpc;
 		return mpc && mpc->funcs && mpc->funcs->set_output_gamma;
+	case PMFW_SEND_MESSAGE_AND_WAIT:
+		return dc2 && dc2->pmfw_messenger.funcs &&
+				dc2->pmfw_messenger.funcs->send_message_and_wait &&
+				step->params.pmfw_send_and_wait_params.message
+				.param_count <= PMFW_MESSENGER_MAX_MESSAGE_PARAMS;
 	default:
 		return false;
 	}
@@ -662,29 +668,56 @@ static noinline_for_stack void dc2_bls_exec_initialize_min_clocks(
 }
 
 static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
-		const struct block_sequence *entry)
+		struct block_sequence *entry)
 {
 	struct dmub_messenger messenger;
 	struct dmub_messenger_init_data init_data;
 	struct dmub_send_cmd_params params;
 	struct dc_context *ctx;
-
-	ctx = entry->params.send_dmcub_cmd_params.ctx;
+	bool continue_on_error;
+
+	if (entry->func == DMUB_SEND_DMCUB_CMD2) {
+		struct send_dmcub_cmd2_params *send = &entry->params.send_dmcub_cmd2_params;
+
+		ctx = send->ctx;
+		params.cmd = &send->cmd;
+		params.wait_type = send->wait_type;
+		continue_on_error = send->continue_on_error;
+	} else {
+		struct send_dmcub_cmd_params *send = &entry->params.send_dmcub_cmd_params;
+
+		ctx = send->ctx;
+		params.cmd = send->cmd;
+		params.wait_type = send->wait_type;
+		continue_on_error = send->continue_on_error;
+	}
 	init_data.ctx = ctx;
 	init_data.dc_dmub_srv = ctx->dmub_srv;
-	params.cmd = entry->params.send_dmcub_cmd_params.cmd;
-	params.wait_type = entry->params.send_dmcub_cmd_params.wait_type;
 
 	dmub_messenger_construct(&messenger, &init_data);
 	if (messenger.funcs->inbox_cmd_send_and_wait(&messenger, &params) !=
 			DMUB_MSG_OK)
-		return entry->params.send_dmcub_cmd_params.continue_on_error ?
+		return continue_on_error ?
 				DC2_BLS_EXEC_CONTINUED_ON_ERROR :
 				DC2_BLS_EXEC_ERROR;
 
 	return DC2_BLS_EXEC_OK;
 }
 
+static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_pmfw_send_and_wait(
+		struct dc2 *dc2, struct block_sequence *entry)
+{
+	struct pmfw_send_and_wait_params *p = &entry->params.pmfw_send_and_wait_params;
+	struct pmfw_messenger *messenger = &dc2->pmfw_messenger;
+
+	if (messenger->funcs->send_message_and_wait(messenger, p->message,
+			&p->response) == PMFW_MSG_OK)
+		return DC2_BLS_EXEC_OK;
+
+	return p->continue_on_error ? DC2_BLS_EXEC_CONTINUED_ON_ERROR :
+			DC2_BLS_EXEC_ERROR;
+}
+
 static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_dmub_gpint(
 		struct dc2 *dc2, const struct block_sequence *entry)
 {
@@ -776,11 +809,11 @@ static noinline_for_stack void dc2_bls_program_surface_config(
 
 enum dc2_bls_exec_result dc2_bls_execute(
 		struct dc2 *dc2,
-		const struct block_sequence *steps,
+		struct block_sequence *steps,
 		unsigned int num_steps)
 {
 	enum dc2_bls_exec_result result = DC2_BLS_EXEC_OK;
-	const struct block_sequence *entry;
+	struct block_sequence *entry;
 	enum dc2_bls_exec_result sent;
 	struct timing_generator *tg;
 	struct output_pixel_processor *opp;
@@ -826,6 +859,7 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					entry->params.dccg_initialize_clocks_params.dccg);
 			break;
 		case DMUB_SEND_DMCUB_CMD:
+		case DMUB_SEND_DMCUB_CMD2:
 			sent = dc2_bls_exec_dmub_send(entry);
 			if (sent == DC2_BLS_EXEC_ERROR)
 				return DC2_BLS_EXEC_ERROR;
@@ -844,10 +878,6 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					DMUB_STATUS_OK)
 				return DC2_BLS_EXEC_ERROR;
 			break;
-		case DMUB_INITIALIZE_DCN:
-			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
-				return DC2_BLS_EXEC_ERROR;
-			break;
 		/*
 		 * S-INT/bld-seq: dce_hwseq init functions. Remove when the
 		 * OPTC, MMHUBBUB, DCCG and HPO BLCs expose them.
@@ -1769,6 +1799,13 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					p->params);
 			break;
 		}
+		case PMFW_SEND_MESSAGE_AND_WAIT:
+			sent = dc2_bls_exec_pmfw_send_and_wait(dc2, entry);
+			if (sent == DC2_BLS_EXEC_ERROR)
+				return DC2_BLS_EXEC_ERROR;
+			if (sent == DC2_BLS_EXEC_CONTINUED_ON_ERROR)
+				result = DC2_BLS_EXEC_CONTINUED_ON_ERROR;
+			break;
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
index d686f03c34c2..88a2ca8b3694 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
@@ -17,5 +17,5 @@ enum dc2_bls_exec_result {
 
 enum dc2_bls_exec_result dc2_bls_execute(
 		struct dc2 *dc2,
-		const struct block_sequence *steps,
+		struct block_sequence *steps,
 		unsigned int num_steps);
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 0e92c2e7a4e6..d05d74595829 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -46,6 +46,8 @@ void core2_construct(struct dc *dc)
 
 	for (name = 0; name < BLS_BUILDER_NAME_COUNT; name++)
 		dc2->builders[name] = bls_builder_create(dc, name);
+
+	pmfw_messenger_construct(&dc2->pmfw_messenger, dc->ctx);
 }
 
 void core2_destruct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
index 319aa3e219d2..6d5dd6f00b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -5,6 +5,10 @@
 
 #include "dm_services.h"
 #include "dc.h"
+#include "core_types.h"
+#include "clk_mgr_internal.h"
+#include "dc_dmub_srv.h"
+#include "dc_bios_types.h"
 #include "bls_builder/bls_builder.h"
 #include "bls_executor/bls_executor.h"
 #include "workaround_manager/workaround_manager.h"
@@ -34,56 +38,300 @@ static void core2_detect_edp_presence(struct dc *dc)
 	}
 }
 
-static void core2_run_native_hardware_init(struct dc *dc)
+static void core2_resolve_dmub_abi(struct dc *dc,
+		const struct bls_builder_initialization_output *initialization)
 {
+	struct dc2 *dc2 = TO_DC2(dc);
+
+	dc2->dmub_abi = initialization->dmub_abi;
+	dc2->dmub_abi_resolved = true;
+	dc->ctx->dmub_srv->dmub->feature_caps = initialization->dmub_abi.feature_caps;
+	dc->caps.dmub_caps.psr = initialization->dmub_abi.feature_caps.psr;
+	dc->caps.dmub_caps.mclk_sw = initialization->dmub_abi.feature_caps.fw_assisted_mclk_switch_ver > 0;
+	dc->caps.dmub_caps.fams_ver = initialization->dmub_abi.feature_caps.fw_assisted_mclk_switch_ver;
+	dc->debug.fams2_config.bits.enable &= dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
+}
+
+static void core2_build_dcn401_wm_ranges(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	enum {
+		DCN401_WATERMARKS_CLOCK_RANGE = 0,
+		DCN401_WATERMARKS_DUMMY_PSTATE = 1,
+	};
+
+	bw_params->wm_table.nv_entries[WM_A].valid = true;
+	bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = DCN401_WATERMARKS_CLOCK_RANGE;
+	bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk =
+			(uint16_t)bw_params->clk_table.entries[0].dcfclk_mhz;
+	bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk =
+			(uint16_t)bw_params->clk_table.entries[0].memclk_mhz;
+	bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
+	bw_params->wm_table.nv_entries[WM_B].valid = false;
+	bw_params->wm_table.nv_entries[WM_1A].valid =
+			dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF;
+	if (bw_params->wm_table.nv_entries[WM_1A].valid) {
+		bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown =
+				bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown;
+		bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.wm_type = DCN401_WATERMARKS_DUMMY_PSTATE;
+	}
+	bw_params->wm_table.nv_entries[WM_1B].valid = false;
+}
+
+static void core2_build_wm_ranges(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	switch (dc->ctx->dce_version) {
+	case DCN_VERSION_4_01:
+		core2_build_dcn401_wm_ranges(dc, bw_params);
+		break;
+	default:
+		break;
+	}
+}
+
+static void core2_resolve_dpm_limits(struct dc *dc, struct clk_bw_params *bw_params,
+		const struct bls_builder_initialization_output *initialization)
+{
+	struct clk_limit_num_entries *counts = &bw_params->clk_table.num_entries_per_clk;
+	unsigned int *num_levels[PMFW_CLOCK_COUNT] = {
+		[PMFW_CLOCK_DCFCLK] = &counts->num_dcfclk_levels,
+		[PMFW_CLOCK_SOCCLK] = &counts->num_socclk_levels,
+		[PMFW_CLOCK_DTBCLK] = &counts->num_dtbclk_levels,
+		[PMFW_CLOCK_DISPCLK] = &counts->num_dispclk_levels,
+		[PMFW_CLOCK_DPPCLK] = &counts->num_dppclk_levels,
+		[PMFW_CLOCK_UCLK] = &counts->num_memclk_levels,
+		[PMFW_CLOCK_FCLK] = &counts->num_fclk_levels,
+	};
+	unsigned int *dc_mode_max[PMFW_CLOCK_COUNT] = {
+		[PMFW_CLOCK_DCFCLK] = &bw_params->dc_mode_limit.dcfclk_mhz,
+		[PMFW_CLOCK_SOCCLK] = &bw_params->dc_mode_limit.socclk_mhz,
+		[PMFW_CLOCK_DTBCLK] = &bw_params->dc_mode_limit.dtbclk_mhz,
+		[PMFW_CLOCK_DISPCLK] = &bw_params->dc_mode_limit.dispclk_mhz,
+		[PMFW_CLOCK_DPPCLK] = &bw_params->dc_mode_limit.dppclk_mhz,
+		[PMFW_CLOCK_UCLK] = &bw_params->dc_mode_limit.memclk_mhz,
+		[PMFW_CLOCK_FCLK] = &bw_params->dc_mode_limit.fclk_mhz,
+	};
+	unsigned int clock;
+
+	dc->caps.dcmode_power_limits_present = false;
+	for (clock = 0; clock < PMFW_CLOCK_COUNT; clock++) {
+		const struct bls_builder_dpm *dpm = &initialization->dpm_clocks[clock];
+
+		*num_levels[clock] = dpm->num_levels;
+		*dc_mode_max[clock] = dpm->dc_mode_max;
+		if (dpm->num_levels && dpm->dc_mode_max == dpm->dpm_level[dpm->num_levels - 1])
+			*dc_mode_max[clock] = 0;
+		dc->caps.dcmode_power_limits_present |= *dc_mode_max[clock] != 0;
+	}
+}
+
+static void core2_resolve_dpm_frequencies(struct clk_bw_params *bw_params,
+		const struct bls_builder_initialization_output *initialization)
+{
+	unsigned int clock, level;
+
+	for (level = 0; level < ARRAY_SIZE(bw_params->clk_table.entries); level++) {
+		struct clk_limit_table_entry *entry = &bw_params->clk_table.entries[level];
+		unsigned int *frequency[PMFW_CLOCK_COUNT] = {
+			[PMFW_CLOCK_DCFCLK] = &entry->dcfclk_mhz,
+			[PMFW_CLOCK_SOCCLK] = &entry->socclk_mhz,
+			[PMFW_CLOCK_DTBCLK] = &entry->dtbclk_mhz,
+			[PMFW_CLOCK_DISPCLK] = &entry->dispclk_mhz,
+			[PMFW_CLOCK_DPPCLK] = &entry->dppclk_mhz,
+			[PMFW_CLOCK_UCLK] = &entry->memclk_mhz,
+			[PMFW_CLOCK_FCLK] = &entry->fclk_mhz,
+		};
+
+		for (clock = 0; clock < PMFW_CLOCK_COUNT; clock++)
+			if (level < initialization->dpm_clocks[clock].num_levels)
+				*frequency[clock] = initialization->dpm_clocks[clock].dpm_level[level];
+	}
+}
+
+static void core2_apply_clock_debug_overrides(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	const struct clk_limit_num_entries *counts = &bw_params->clk_table.num_entries_per_clk;
+	unsigned int level;
+
+	if (dc->debug.min_disp_clk_khz) {
+		unsigned int min_dispclk_mhz = (unsigned int)khz_to_mhz_ceil(dc->debug.min_disp_clk_khz);
+
+		for (level = 0; level < counts->num_dispclk_levels; level++)
+			bw_params->clk_table.entries[level].dispclk_mhz =
+					max(bw_params->clk_table.entries[level].dispclk_mhz, min_dispclk_mhz);
+	}
+	if (dc->debug.min_dpp_clk_khz) {
+		unsigned int min_dppclk_mhz = (unsigned int)khz_to_mhz_ceil(dc->debug.min_dpp_clk_khz);
+
+		for (level = 0; level < counts->num_dppclk_levels; level++)
+			bw_params->clk_table.entries[level].dppclk_mhz =
+					max(bw_params->clk_table.entries[level].dppclk_mhz, min_dppclk_mhz);
+	}
+}
+
+static void core2_resolve_bandwidth_clocks(struct dc *dc, struct clk_mgr_internal *clk_mgr,
+		struct clk_bw_params *bw_params,
+		const struct bls_builder_initialization_output *initialization)
+{
+	const struct clk_limit_num_entries *counts = &bw_params->clk_table.num_entries_per_clk;
+
+	bw_params->dc_mode_softmax_memclk = bw_params->dc_mode_limit.memclk_mhz;
+	if (counts->num_memclk_levels)
+		bw_params->max_memclk_mhz = initialization->dpm_clocks[PMFW_CLOCK_UCLK].dpm_level[
+				counts->num_memclk_levels - 1];
+	bw_params->clk_table.num_entries = max(counts->num_memclk_levels, counts->num_fclk_levels);
+	if (!bw_params->clk_table.num_entries)
+		bw_params->clk_table.num_entries = 1;
+	clk_mgr->dpm_present = counts->num_dcfclk_levels && counts->num_dtbclk_levels &&
+			counts->num_dispclk_levels && (counts->num_memclk_levels || counts->num_fclk_levels);
+	bw_params->num_channels = initialization->num_umc_channels;
+	if (dc->ctx->dc_bios) {
+		if (!bw_params->num_channels)
+			bw_params->num_channels = dc->ctx->dc_bios->vram_info.num_chans;
+		bw_params->dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+	}
+}
+
+static void core2_resolve_clocks(struct dc *dc,
+		const struct bls_builder_initialization_output *initialization)
+{
+	struct clk_mgr_internal *clk_mgr;
+	struct clk_bw_params *bw_params;
+
+	if (!dc->clk_mgr)
+		return;
+
+	clk_mgr = TO_CLK_MGR_INTERNAL(dc->clk_mgr);
+	bw_params = dc->clk_mgr->bw_params;
+	if (bw_params) {
+		memset(&dc->clk_mgr->clks, 0, sizeof(dc->clk_mgr->clks));
+		dc->clk_mgr->clks.p_state_change_support = true;
+		dc->clk_mgr->clks.prev_p_state_change_support = true;
+		dc->clk_mgr->clks.fclk_prev_p_state_change_support = true;
+	}
+	clk_mgr->smu_ver = initialization->smu_version;
+	clk_mgr->smu_present = initialization->smu_version != 0;
+	clk_mgr->dpm_present = false;
+	if (!clk_mgr->smu_present || !bw_params)
+		return;
+
+	core2_resolve_dpm_limits(dc, bw_params, initialization);
+	core2_resolve_dpm_frequencies(bw_params, initialization);
+	core2_apply_clock_debug_overrides(dc, bw_params);
+	core2_resolve_bandwidth_clocks(dc, clk_mgr, bw_params, initialization);
+	if (dc->res_pool->funcs->update_bw_bounding_box)
+		dc->res_pool->funcs->update_bw_bounding_box(dc, bw_params);
+	core2_build_wm_ranges(dc, bw_params);
+}
+
+/* dcn401_init_hw refreshes the bounding box after the DMUB caps query. */
+static void core2_update_bw_bounding_box(struct dc *dc,
+		bool dchub_ref_freq_changed)
+{
+	if (dc->ctx->dmub_srv &&
+			(!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
+			dc->res_pool->funcs->update_bw_bounding_box &&
+			dc->clk_mgr && dc->clk_mgr->bw_params)
+		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+}
+
+/* Build, apply workarounds, execute, and let the builder read the replies. */
+static bool core2_run_init_stage(struct dc *dc,
+		const struct bls_builder *builder,
+		const struct workaround_manager *wam,
+		struct bls_builder_declarative_params *params)
+{
+	struct workaround_context wa_ctx = {0};
+	struct block_sequence_state sequence;
+	enum dc2_bls_exec_result exec_result;
+
+	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS)
+		return false;
+
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+	wa_ctx.current_state = dc->current_state;
+	wa_ctx.builder_name = builder->name;
+	wa_ctx.dcn_version = dc->ctx->dce_version;
+	wa_ctx.bug_wa = &dc->work_arounds;
+	wa_ctx.debug = &dc->debug;
+	if (workaround_manager_apply(wam, &sequence, &wa_ctx) != WAM_OK ||
+			params->head_num_steps > DC2_BLS_MAX_STEPS)
+		return false;
+
+	exec_result = dc2_bls_execute(TO_DC2(dc), params->head_sequence,
+			params->head_num_steps);
+	if (exec_result != DC2_BLS_EXEC_OK &&
+			exec_result != DC2_BLS_EXEC_CONTINUED_ON_ERROR)
+		return false;
+
+	builder->postprocess(params);
+	return true;
+}
+
+static void core2_run_wrapped_hardware_init(struct dc *dc)
+{
+	const struct workaround_manager *wam = dc2_workaround_manager_get();
 	struct bls_builder_declarative_params *params;
-	struct bls_builder_output_init *out_init;
 	struct bls_builder_output_targets out_targets = {0};
+	struct bls_builder_initialization *initialization;
+	const struct bls_builder_initialization_output *output;
 	const struct bls_builder *builder;
-	enum bls_builder_result result;
+	bool dchub_ref_freq_changed;
+	unsigned int stage;
 
 	builder = TO_DC2(dc)->builders[DCN_DECL_INITIALIZATION];
 	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
-			!builder->build.declarative)
+			!builder->build.declarative || !builder->postprocess || !wam ||
+			!dc->current_state)
 		return;
+	TO_DC2(dc)->dmub_abi_resolved = false;
 
 	/*
-	 * The declarative params hold 128 block-sequence entries, and the
-	 * init output holds DMUB command buffers. Keep both off the stack
-	 * so the kernel frame stays under the 2048-byte limit.
+	 * The declarative params hold 128 block-sequence entries. Keep them
+	 * and the init output off the stack so the kernel frame stays under
+	 * the 2048-byte limit.
 	 */
-	params = kvzalloc(sizeof(*params), GFP_KERNEL);
-	out_init = kvzalloc(sizeof(*out_init), GFP_KERNEL);
-	if (!params || !out_init)
+	params = kvzalloc_obj(*params, GFP_KERNEL);
+	initialization = kvzalloc_obj(*initialization, GFP_KERNEL);
+	if (!params || !initialization)
 		goto out;
 
 	params->dc = dc;
-	out_targets.DCN_DECL_INITIALIZATION = out_init;
+	out_targets.DCN_DECL_INITIALIZATION = initialization;
 	params->out_targets = &out_targets;
-	/*
-	 * The builder copies DMUB windows retained on dmub_srv. Missing
-	 * windows fail the build closed. Execute only a successful build,
-	 * and do not fall back to legacy hwseq.
-	 */
-	result = builder->build.declarative(params);
-	if (result == BLS_BUILD_SUCCESS)
-		dc2_bls_execute(TO_DC2(dc), params->head_sequence,
-				params->head_num_steps);
+
+	/* Builders emit empty sequences for stages past their last one. */
+	for (stage = 0; stage < BLS_BUILDER_INIT_MAX_STAGE_COUNT; stage++) {
+		if (!core2_run_init_stage(dc, builder, wam, params))
+			goto out;
+	}
+
+	dc->current_state->bls_builder_initialization = *initialization;
+	output = &dc->current_state->bls_builder_initialization.output;
+
+	dchub_ref_freq_changed = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 !=
+			output->dchub_ref_clock_inKhz / 1000;
+	dc->res_pool->ref_clocks.xtalin_clock_inKhz = output->xtalin_clock_inKhz;
+	dc->res_pool->ref_clocks.dccg_ref_clock_inKhz = output->dccg_ref_clock_inKhz;
+	dc->res_pool->ref_clocks.dchub_ref_clock_inKhz = output->dchub_ref_clock_inKhz;
+	core2_resolve_dmub_abi(dc, output);
+	core2_resolve_clocks(dc, output);
+	core2_update_bw_bounding_box(dc, dchub_ref_freq_changed);
 
 out:
 	kvfree(params);
-	kvfree(out_init);
+	kvfree(initialization);
 }
 
-/* CORE2 runs the DC2_DC1_Wrapped init until dcn401 init is native. */
 void core2_hardware_init(struct dc *dc)
 {
 	if (!dc)
 		return;
 
 	core2_detect_edp_presence(dc);
-	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
-		core2_run_legacy_hardware_init(dc, dc2_workaround_manager_get());
+	if (TO_DC2(dc)->init_method == DC2_INIT_METHOD_WRAPPED)
+		core2_run_wrapped_hardware_init(dc);
 	else
-		core2_run_native_hardware_init(dc);
+		core2_run_legacy_hardware_init(dc, dc2_workaround_manager_get());
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c235520b908..775259e5e478 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1414,6 +1414,7 @@ struct dc_init_data {
 	uint32_t *clk_reg_offsets;
 	void *bb_from_dmub;
 	enum dc2_selection dc2_selection;
+	enum dc2_init_method dc2_init_method;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
index 5d7117501428..ec3b14ba8509 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
@@ -14,6 +14,7 @@ void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params)
 {
 	/* DM override today; ASIC allow-list later. Owned only by this shim. */
 	TO_DC2(dc)->selection = init_params->dc2_selection;
+	TO_DC2(dc)->init_method = init_params->dc2_init_method;
 }
 
 void dc_hardware_init(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
index 93dd2d47c8dc..297d2920f733 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -8,16 +8,19 @@
 #include "dc.h"
 #include "inc/dc_core_interface.h"
 #include "bls_builder/bls_builder.h"
+#include "pmfw_messenger/pmfw_messenger.h"
 
 struct dc2 {
 	/* First member: TO_DC2 is a typed upcast, not container_of. */
 	struct dc dc;
 	enum dc2_selection selection;
+	enum dc2_init_method init_method;
 	/* Resolved by hardware init; later builds take it as dmub_abi. */
 	struct dmub_abi dmub_abi;
 	bool dmub_abi_resolved;
 	/* Set once by core2_construct; NULL where this DCN has no builder. */
 	const struct bls_builder *builders[BLS_BUILDER_NAME_COUNT];
+	struct pmfw_messenger pmfw_messenger;
 };
 
 #define TO_DC2(ptr) ((struct dc2 *)(ptr))
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index e447dd2c69ec..6e009ba37ff9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -38,6 +38,7 @@
 #include "link_service_types.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "dc_dmub_srv.h"
+#include "pmfw_messenger/pmfw_messenger.h"
 
 struct pipe_ctx;
 struct dc_state;
@@ -147,6 +148,13 @@ struct send_dmcub_cmd_params {
 	bool continue_on_error;
 };
 
+struct send_dmcub_cmd2_params {
+	struct dc_context *ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	bool continue_on_error;
+};
+
 struct dmub_gpint_params {
 	unsigned int command_code;
 	unsigned int param;
@@ -1350,6 +1358,12 @@ struct dccg_initialize_clocks_params {
 	struct dccg *dccg;
 };
 
+struct pmfw_send_and_wait_params {
+	struct pmfw_message message;
+	struct pmfw_response response;
+	bool continue_on_error;
+};
+
 struct hubbub_program_watermarks_params {
 	struct hubbub *hubbub;
 	/* Workaround: watermarks by value would add ~160 B to every step (~158 KiB per dc_state).
@@ -1398,6 +1412,7 @@ union block_sequence_params {
 	struct update_info_frame_params update_info_frame_params;
 	struct program_manual_trigger_params program_manual_trigger_params;
 	struct send_dmcub_cmd_params send_dmcub_cmd_params;
+	struct send_dmcub_cmd2_params send_dmcub_cmd2_params;
 	struct lsdma_send_pio_copy_params lsdma_send_pio_copy_params;
 	struct setup_dpp_params setup_dpp_params;
 	struct program_bias_and_scale_params program_bias_and_scale_params;
@@ -1634,6 +1649,7 @@ union block_sequence_params {
 	struct hubp_program_3dlut_fl_config_params
 			hubp_program_3dlut_fl_config_params;
 	struct hubp_set_3dlut_fl_params hubp_set_3dlut_fl_params;
+	struct pmfw_send_and_wait_params pmfw_send_and_wait_params;
 };
 
 enum block_sequence_func {
@@ -1811,7 +1827,6 @@ enum block_sequence_func {
 	DMUB_GPINT_SEND_AND_WAIT,
 	DMUB_HALT_FW,
 	PSP_RELOAD_DMUB_FW,
-	DMUB_INITIALIZE_DCN,
 	OPTC_SET_ODM_MEM_POWER,
 	MMHUBBUB_SET_MEM_POWER,
 	DCCG_GET_REF_FREQ,
@@ -1879,6 +1894,8 @@ enum block_sequence_func {
 	DPP_PROGRAM_GAMCOR_LUT,
 	HUBP_PROGRAM_3DLUT_FL_CONFIG,
 	HUBP_SET_3DLUT_FL,
+	PMFW_SEND_MESSAGE_AND_WAIT,
+	DMUB_SEND_DMCUB_CMD2,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 1d6bb41312b7..f1b6053fa5c6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -42,6 +42,7 @@
 #include "panel_cntl.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "bls_builder/bls_builder_legacy_init.h"
+#include "bls_builder/bls_builder.h"
 #include "pg_cntl.h"
 #include "sspl/dc_spl.h"
 
@@ -730,6 +731,8 @@ struct dc_state {
 	 * outputs of each stage run so far
 	 */
 	struct bls_builder_legacy_hw_init_info hw_init_info;
+
+	struct bls_builder_initialization bls_builder_initialization;
 };
 
 struct replay_context {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
index 4cd01e34a959..6e21ddb839a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
@@ -20,6 +20,12 @@ enum dc2_selection {
 	DC2_SELECTION_CORE2,
 };
 
+/* Temporary: picks the CORE2 hardware init flow for bring-up testing. */
+enum dc2_init_method {
+	DC2_INIT_METHOD_LEGACY = 0,
+	DC2_INIT_METHOD_WRAPPED,
+};
+
 enum dc2_hw_ownership {
 	DC2_HW_OWNERSHIP_RELEASED = 0,
 	DC2_HW_OWNERSHIP_OWNED,
diff --git a/drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c
new file mode 100644
index 000000000000..79910c2dc16d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+
+#include "reg_helper.h"
+#include "pmfw_messenger/pmfw_messenger.h"
+
+#define mmDAL_MSG_REG  0x1628A
+#define mmDAL_ARG_REG  0x16273
+#define mmDAL_RESP_REG 0x16274
+
+#define REG(reg_name) \
+	mm ## reg_name
+
+#define CTX pmfw_messenger->ctx
+
+#define DCN401_PMFW_STATUS_IN_PROGRESS 0x00
+#define DCN401_PMFW_STATUS_OK          0x01
+
+#define DCN401_PMFW_POLL_DELAY_US    10
+#define DCN401_PMFW_POLL_MAX_RETRIES 200000
+
+#define DALSMC_VERSION 0x1
+#define DALSMC_Result_OK                          0x1
+#define DALSMC_Result_Failed                      0xFF
+#define DALSMC_Result_UnknownCmd                  0xFE
+#define DALSMC_Result_CmdRejectedPrereq           0xFD
+#define DALSMC_Result_CmdRejectedBusy             0xFC
+#define DALSMC_MSG_TestMessage                    0x1
+#define DALSMC_MSG_GetSmuVersion                  0x2
+#define DALSMC_MSG_GetDriverIfVersion             0x3
+#define DALSMC_MSG_GetMsgHeaderVersion            0x4
+#define DALSMC_MSG_SetDalDramAddrHigh             0x5
+#define DALSMC_MSG_SetDalDramAddrLow              0x6
+#define DALSMC_MSG_TransferTableSmu2Dram          0x7
+#define DALSMC_MSG_TransferTableDram2Smu          0x8
+#define DALSMC_MSG_SetHardMinByFreq               0x9
+#define DALSMC_MSG_SetHardMaxByFreq               0xA
+#define DALSMC_MSG_GetDpmFreqByIndex              0xB
+#define DALSMC_MSG_GetDcModeMaxDpmFreq            0xC
+#define DALSMC_MSG_SetMinDeepSleepDcfclk          0xD
+#define DALSMC_MSG_NumOfDisplays                  0xE
+#define DALSMC_MSG_SetExternalClientDfCstateAllow 0xF
+#define DALSMC_MSG_BacoAudioD3PME                 0x10
+#define DALSMC_MSG_SetFclkSwitchAllow             0x11
+#define DALSMC_MSG_SetCabForUclkPstate            0x12
+#define DALSMC_MSG_SetWorstCaseUclkLatency        0x13
+#define DALSMC_MSG_DcnExitReset                   0x14
+#define DALSMC_MSG_ReturnHardMinStatus            0x15
+#define DALSMC_MSG_SetAlwaysWaitDmcubResp         0x16
+#define DALSMC_MSG_IndicateDrrStatus              0x17
+#define DALSMC_MSG_ActiveUclkFclk                 0x18
+#define DALSMC_MSG_IdleUclkFclk                   0x19
+#define DALSMC_MSG_SetUclkPstateAllow             0x1A
+#define DALSMC_MSG_SubvpUclkFclk                  0x1B
+#define DALSMC_MSG_GetNumUmcChannels              0x1C
+#define DALSMC_Message_Count                      0x1D
+
+static uint32_t dcn401_pmfw_message_id(enum pmfw_message_id message_id)
+{
+	switch (message_id) {
+	case PMFW_MSG_TEST_MESSAGE: return DALSMC_MSG_TestMessage;
+	case PMFW_MSG_GET_SMU_VERSION: return DALSMC_MSG_GetSmuVersion;
+	case PMFW_MSG_GET_DRIVER_IF_VERSION: return DALSMC_MSG_GetDriverIfVersion;
+	case PMFW_MSG_GET_MSG_HEADER_VERSION: return DALSMC_MSG_GetMsgHeaderVersion;
+	case PMFW_MSG_SET_DAL_DRAM_ADDR_HIGH: return DALSMC_MSG_SetDalDramAddrHigh;
+	case PMFW_MSG_SET_DAL_DRAM_ADDR_LOW: return DALSMC_MSG_SetDalDramAddrLow;
+	case PMFW_MSG_TRANSFER_TABLE_SMU_TO_DRAM: return DALSMC_MSG_TransferTableSmu2Dram;
+	case PMFW_MSG_TRANSFER_TABLE_DRAM_TO_SMU: return DALSMC_MSG_TransferTableDram2Smu;
+	case PMFW_MSG_SET_HARD_MIN_BY_FREQ: return DALSMC_MSG_SetHardMinByFreq;
+	case PMFW_MSG_SET_HARD_MAX_BY_FREQ: return DALSMC_MSG_SetHardMaxByFreq;
+	case PMFW_MSG_GET_DPM_FREQ_BY_INDEX: return DALSMC_MSG_GetDpmFreqByIndex;
+	case PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ: return DALSMC_MSG_GetDcModeMaxDpmFreq;
+	case PMFW_MSG_SET_MIN_DEEP_SLEEP_DCFCLK: return DALSMC_MSG_SetMinDeepSleepDcfclk;
+	case PMFW_MSG_NUM_OF_DISPLAYS: return DALSMC_MSG_NumOfDisplays;
+	case PMFW_MSG_SET_EXTERNAL_CLIENT_DF_CSTATE_ALLOW: return DALSMC_MSG_SetExternalClientDfCstateAllow;
+	case PMFW_MSG_BACO_AUDIO_D3_PME: return DALSMC_MSG_BacoAudioD3PME;
+	case PMFW_MSG_SET_FCLK_SWITCH_ALLOW: return DALSMC_MSG_SetFclkSwitchAllow;
+	case PMFW_MSG_SET_CAB_FOR_UCLK_PSTATE: return DALSMC_MSG_SetCabForUclkPstate;
+	case PMFW_MSG_SET_WORST_CASE_UCLK_LATENCY: return DALSMC_MSG_SetWorstCaseUclkLatency;
+	case PMFW_MSG_DCN_EXIT_RESET: return DALSMC_MSG_DcnExitReset;
+	case PMFW_MSG_RETURN_HARD_MIN_STATUS: return DALSMC_MSG_ReturnHardMinStatus;
+	case PMFW_MSG_SET_ALWAYS_WAIT_DMCUB_RESP: return DALSMC_MSG_SetAlwaysWaitDmcubResp;
+	case PMFW_MSG_INDICATE_DRR_STATUS: return DALSMC_MSG_IndicateDrrStatus;
+	case PMFW_MSG_ACTIVE_UCLK_FCLK: return DALSMC_MSG_ActiveUclkFclk;
+	case PMFW_MSG_IDLE_UCLK_FCLK: return DALSMC_MSG_IdleUclkFclk;
+	case PMFW_MSG_SET_UCLK_PSTATE_ALLOW: return DALSMC_MSG_SetUclkPstateAllow;
+	case PMFW_MSG_SUBVP_UCLK_FCLK: return DALSMC_MSG_SubvpUclkFclk;
+	case PMFW_MSG_GET_NUM_UMC_CHANNELS: return DALSMC_MSG_GetNumUmcChannels;
+	default: return 0;
+	}
+}
+
+static uint32_t dcn401_pmfw_poll_status(struct pmfw_messenger *pmfw_messenger)
+{
+	unsigned int max_retries = DCN401_PMFW_POLL_MAX_RETRIES;
+	uint32_t status;
+
+	do {
+		status = REG_READ(DAL_RESP_REG);
+		if (status != DCN401_PMFW_STATUS_IN_PROGRESS)
+			break;
+
+		udelay(DCN401_PMFW_POLL_DELAY_US);
+	} while (max_retries--);
+
+	return status;
+}
+
+static enum pmfw_msg_result dcn401_pmfw_send_message(struct pmfw_messenger *pmfw_messenger,
+		struct pmfw_message message)
+{
+	uint32_t param;
+	uint32_t firmware_message_id;
+
+	if (pmfw_messenger->request_outstanding || message.param_count > 1)
+		return PMFW_MSG_ERROR;
+
+	firmware_message_id = dcn401_pmfw_message_id(message.msg_id);
+	if (!firmware_message_id)
+		return PMFW_MSG_ERROR;
+
+	param = message.param_count ? message.params[0] : 0;
+
+	/* DCN401 sends even if the previous request never completed. */
+	dcn401_pmfw_poll_status(pmfw_messenger);
+
+	TRACE_SMU_MSG_ENTER(firmware_message_id, param, pmfw_messenger->ctx);
+
+	REG_WRITE(DAL_RESP_REG, DCN401_PMFW_STATUS_IN_PROGRESS);
+	REG_WRITE(DAL_ARG_REG, param);
+	REG_WRITE(DAL_MSG_REG, firmware_message_id);
+
+	pmfw_messenger->request_outstanding = true;
+
+	return PMFW_MSG_OK;
+}
+
+static enum pmfw_msg_result dcn401_pmfw_wait_for_response(struct pmfw_messenger *pmfw_messenger,
+		struct pmfw_response *response)
+{
+	uint32_t status;
+
+	if (!response)
+		return PMFW_MSG_ERROR;
+
+	response->response_count = 0;
+
+	if (!pmfw_messenger->request_outstanding)
+		return PMFW_MSG_ERROR;
+
+	status = dcn401_pmfw_poll_status(pmfw_messenger);
+
+	if (status == DCN401_PMFW_STATUS_IN_PROGRESS) {
+		TRACE_SMU_MSG_EXIT(false, 0, pmfw_messenger->ctx);
+		/* A timed-out request is still owned by firmware; the Builder may wait again. */
+		return PMFW_MSG_TIMEOUT;
+	}
+
+	pmfw_messenger->request_outstanding = false;
+
+	if (status != DCN401_PMFW_STATUS_OK) {
+		TRACE_SMU_MSG_EXIT(false, 0, pmfw_messenger->ctx);
+		return PMFW_MSG_ERROR;
+	}
+
+	response->response[0] = REG_READ(DAL_ARG_REG);
+	response->response_count = 1;
+
+	TRACE_SMU_MSG_EXIT(true, response->response[0], pmfw_messenger->ctx);
+
+	return PMFW_MSG_OK;
+}
+
+static enum pmfw_msg_result dcn401_pmfw_send_message_and_wait(struct pmfw_messenger *pmfw_messenger,
+		struct pmfw_message message, struct pmfw_response *response)
+{
+	enum pmfw_msg_result result;
+
+	if (!response)
+		return PMFW_MSG_ERROR;
+
+	response->response_count = 0;
+
+	result = dcn401_pmfw_send_message(pmfw_messenger, message);
+	if (result != PMFW_MSG_OK)
+		return result;
+
+	result = dcn401_pmfw_wait_for_response(pmfw_messenger, response);
+	pmfw_messenger->request_outstanding = false;
+
+	return result;
+}
+
+static const struct pmfw_messenger_funcs dcn401_pmfw_messenger_funcs = {
+	.send_message = dcn401_pmfw_send_message,
+	.wait_for_response = dcn401_pmfw_wait_for_response,
+	.send_message_and_wait = dcn401_pmfw_send_message_and_wait,
+};
+
+void dcn401_pmfw_messenger_construct(struct pmfw_messenger *pmfw_messenger,
+		struct dc_context *ctx)
+{
+	pmfw_messenger->funcs = &dcn401_pmfw_messenger_funcs;
+	pmfw_messenger->ctx = ctx;
+	pmfw_messenger->inst = 0;
+	pmfw_messenger->request_outstanding = false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c
new file mode 100644
index 000000000000..b35ffea381df
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc_types.h"
+#include "pmfw_messenger/pmfw_messenger.h"
+
+static enum pmfw_msg_result pmfw_absent_send_message(
+		struct pmfw_messenger *pmfw_messenger, struct pmfw_message message)
+{
+	(void)pmfw_messenger;
+	(void)message;
+	return PMFW_MSG_NOT_PRESENT;
+}
+
+static enum pmfw_msg_result pmfw_absent_wait_for_response(
+		struct pmfw_messenger *pmfw_messenger, struct pmfw_response *response)
+{
+	(void)pmfw_messenger;
+	if (response)
+		response->response_count = 0;
+
+	return PMFW_MSG_NOT_PRESENT;
+}
+
+static enum pmfw_msg_result pmfw_absent_send_message_and_wait(
+		struct pmfw_messenger *pmfw_messenger, struct pmfw_message message,
+		struct pmfw_response *response)
+{
+	(void)message;
+	return pmfw_absent_wait_for_response(pmfw_messenger, response);
+}
+
+static const struct pmfw_messenger_funcs pmfw_absent_funcs = {
+	.send_message = pmfw_absent_send_message,
+	.wait_for_response = pmfw_absent_wait_for_response,
+	.send_message_and_wait = pmfw_absent_send_message_and_wait,
+};
+
+void pmfw_messenger_construct(struct pmfw_messenger *m, struct dc_context *ctx)
+{
+	if (!m)
+		return;
+
+	m->funcs = &pmfw_absent_funcs;
+	m->ctx = ctx;
+	m->inst = 0;
+	m->request_outstanding = false;
+
+	if (!ctx)
+		return;
+
+	switch (ctx->dce_version) {
+	case DCN_VERSION_4_01:
+		dcn401_pmfw_messenger_construct(m, ctx);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h
new file mode 100644
index 000000000000..5c7233d48df9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dm_services_types.h"
+
+struct dc_context;
+struct pmfw_messenger;
+
+#define PMFW_MESSENGER_MAX_MESSAGE_PARAMS 4
+#define PMFW_MESSENGER_MAX_RESPONSE_WORDS 1
+#define PMFW_MAX_NUM_DPM_LVL 8
+
+enum pmfw_message_id {
+	PMFW_MSG_TEST_MESSAGE,
+	PMFW_MSG_GET_SMU_VERSION,
+	PMFW_MSG_GET_PMFW_VERSION,
+	PMFW_MSG_GET_DRIVER_IF_VERSION,
+	PMFW_MSG_GET_MSG_HEADER_VERSION,
+	PMFW_MSG_SET_DAL_DRAM_ADDR_HIGH,
+	PMFW_MSG_SET_DAL_DRAM_ADDR_LOW,
+	PMFW_MSG_SET_DRAM_ADDR_HIGH,
+	PMFW_MSG_SET_DRAM_ADDR_LOW,
+	PMFW_MSG_TRANSFER_TABLE_SMU_TO_DRAM,
+	PMFW_MSG_TRANSFER_TABLE_DRAM_TO_SMU,
+	PMFW_MSG_SET_HARD_MIN_BY_FREQ,
+	PMFW_MSG_SET_HARD_MAX_BY_FREQ,
+	PMFW_MSG_GET_DPM_FREQ_BY_INDEX,
+	PMFW_MSG_GET_DC_MODE_MAX_DPM_FREQ,
+	PMFW_MSG_SET_MIN_DEEP_SLEEP_DCFCLK,
+	PMFW_MSG_NUM_OF_DISPLAYS,
+	PMFW_MSG_SET_EXTERNAL_CLIENT_DF_CSTATE_ALLOW,
+	PMFW_MSG_BACO_AUDIO_D3_PME,
+	PMFW_MSG_SACO_AUDIO_D3_PME,
+	PMFW_MSG_SET_FCLK_SWITCH_ALLOW,
+	PMFW_MSG_SET_CAB_FOR_UCLK_PSTATE,
+	PMFW_MSG_SET_WORST_CASE_UCLK_LATENCY,
+	PMFW_MSG_DCN_EXIT_RESET,
+	PMFW_MSG_RETURN_HARD_MIN_STATUS,
+	PMFW_MSG_SET_ALWAYS_WAIT_DMCUB_RESP,
+	PMFW_MSG_INDICATE_DRR_STATUS,
+	PMFW_MSG_ACTIVE_UCLK_FCLK,
+	PMFW_MSG_IDLE_UCLK_FCLK,
+	PMFW_MSG_SET_UCLK_PSTATE_ALLOW,
+	PMFW_MSG_SUBVP_UCLK_FCLK,
+	PMFW_MSG_GET_NUM_UMC_CHANNELS,
+	PMFW_MSG_SET_DISPCLK_FREQ,
+	PMFW_MSG_SET_DPPCLK_FREQ,
+	PMFW_MSG_SET_HARD_MIN_DCFCLK_BY_FREQ,
+	PMFW_MSG_UPDATE_PME_RESTORE,
+	PMFW_MSG_GET_FCLK_FREQUENCY,
+	PMFW_MSG_SET_DISPLAY_IDLE_OPTIMIZATIONS,
+	PMFW_MSG_GET_DPREFCLK_FREQ,
+	PMFW_MSG_GET_DTBCLK_FREQ,
+	PMFW_MSG_ALLOW_ZSTATES_ENTRY,
+	PMFW_MSG_ALLOW_ZSTATES_ENTRY_SPARE0,
+	PMFW_MSG_SET_DTB_CLK,
+	PMFW_MSG_DISP_IPS2_EXIT,
+	PMFW_MSG_DISP_IPS2_EXIT_SPARE1,
+	PMFW_MSG_QUERY_IPS2_SUPPORT,
+	PMFW_MSG_DF_CSTATE_DISABLE,
+	PMFW_MSG_BANDWIDTH_REQUEST,
+	PMFW_MSG_UPDATE_UTM_QOS_PARAMS,
+	PMFW_MSG_STUTTER_EFFICIENCY,
+	PMFW_MSG_GET_DISPCLK_FREQ,
+	PMFW_MSG_GET_DPPCLK_FREQ,
+	PMFW_MSG_INDICATE_PSTATE_STATUS,
+};
+
+enum pmfw_clocks {
+	PMFW_CLOCK_DCFCLK,
+	PMFW_CLOCK_SOCCLK,
+	PMFW_CLOCK_DTBCLK,
+	PMFW_CLOCK_DISPCLK,
+	PMFW_CLOCK_DPPCLK,
+	PMFW_CLOCK_UCLK,
+	PMFW_CLOCK_FCLK,
+	PMFW_CLOCK_COUNT,
+};
+
+struct pmfw_message {
+	enum pmfw_message_id msg_id;
+	uint32_t param_count;
+	uint32_t params[PMFW_MESSENGER_MAX_MESSAGE_PARAMS];
+};
+
+struct pmfw_response {
+	uint32_t response_count;
+	uint32_t response[PMFW_MESSENGER_MAX_RESPONSE_WORDS];
+};
+
+enum pmfw_msg_result {
+	PMFW_MSG_OK,
+	PMFW_MSG_NOT_PRESENT,
+	PMFW_MSG_TIMEOUT,
+	PMFW_MSG_ERROR,
+};
+
+struct pmfw_messenger_funcs {
+	enum pmfw_msg_result (*send_message)(struct pmfw_messenger *pmfw_messenger, struct pmfw_message message);
+	enum pmfw_msg_result (*wait_for_response)(struct pmfw_messenger *pmfw_messenger, struct pmfw_response *response);
+	enum pmfw_msg_result (*send_message_and_wait)(struct pmfw_messenger *pmfw_messenger, struct pmfw_message message,
+		struct pmfw_response *response);
+};
+
+struct pmfw_messenger {
+	const struct pmfw_messenger_funcs *funcs;
+	struct dc_context *ctx;
+	unsigned int inst;
+	bool request_outstanding;
+};
+
+void pmfw_messenger_construct(struct pmfw_messenger *m, struct dc_context *ctx);
+
+void dcn401_pmfw_messenger_construct(struct pmfw_messenger *m, struct dc_context *ctx);
-- 
2.43.0

