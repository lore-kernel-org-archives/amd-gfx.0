Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E3606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z/vK16Ou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D75E10E0CE;
	Wed, 21 Oct 2026 06:25:31 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B46810E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPLv/qNzqeaRQbQhmW5duk3uS+yr/F8iKHpmI4LVuawOqBBFA2U3bJHrRmUyrQSBxM0kawgwdWFv1yGMPN2f0Wz3F/XW9ck7W4452bY0KgWO/8291yN27/RGrOq1RPIFB08OxNazGbKwVaDvOEIwOYOb7A/ydzPZdVHMmT28fbOG/mYCr5r0uaKqF4JsiIcTk4ZWRIgLYOtnUi80R0fNJ3OXL3uvz5IT+aawkCn/f1mrnDkH/jvbnqk38BQEfW9xIaa9YoOWEkJuAP7CaubKGEOgnCEGfGfHeKZouwILvgHwulToPvfS3547oklHW6sEhPpG58+bvb+l39HcRvpctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLMHvmyCO1ImjaVg6PMzlpmAy0cLKlpzSc1YYGhbbEY=;
 b=G+vKZdS4+8khkvKUuWVTLbY/oXi1XQvGW1vHJmdFXEudqG9U/Zy0uClf4Kb8kLsapAibMYE/4WrAC3n5HZSNKzmN3p7lcpFZW8DuNYCHcffbbl+G1DW1nyJe5odNsTjTIcZZEdKObrfiiVMx8L1iC1kS5GJz3AQn7CShDqZYzZfujnh1LyMv8R5sU3eGtcr6mgdBhWpmsocmZdGbThWf2aWf3Rnc3t24iG+HykFahJhtER4QafkWGMzspv6DjgAeWqe8i8gM95yj4o+iWBFa/Cxgaf77g+LeBbF9+EIWot8Q3dtTWt6WGb9etLGnWxwJhy51NNGdHwAshRD8xIXcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLMHvmyCO1ImjaVg6PMzlpmAy0cLKlpzSc1YYGhbbEY=;
 b=Z/vK16OurjHhOlxyIlPECOsHAtliflk2zjPM/1nc8auVaW4LrxH6egjEsRjak1xO2E2v03VWuRqAjw8/3u/kLkZd3kEey3oKZnCzEHhIirMnzLDWc7NgC9Y+l0ENMNXtPE/NNCw1s0KnCHxEMSKa+IzIlMHjBFkvO7R+Bvu6SIs=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:20 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::aa) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:19 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/49] DC Patches Oct 26 2026
Date: Wed, 21 Oct 2026 14:22:06 +0800
Message-ID: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: 262bc4b9-2cbb-4365-dac3-08df2f3c14a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: HjSLHRySUFugEzngvvaFET1uRuhcKgj1tJmxBmd/+ggPnb2s37esZNMNkISRKOrxuxFMBYEcljNN37d3X90F00t388y7S33sWCaKrkjC3Y3irMzbOj03ApAZCrb1myloeXA0WBqX/3ho4xJbYA8S6aNEq+kPjCk9/GmBF0P7iLC4ujCKxotjf7v9W2f73mRwazvrwqBVcvH6w1E4pvUqT/kPg/pn5YkfbzfJvu5EiMMcjuEZrEu7OvZuIYfFSbCfohpon3DjMYD5Qim6ocysLxM5jeaI12qdn2/Nqh5MJnrFmAb+7fM5tiEkul1mLrLH5lWBe96qkj8qjQpC+Jl4d810pRBMXDbgLchrNJT1c/qz3eHiscyGPLePatBIo01cDvQmorNwMvlnNRFPeIW7R4F8hcD/mousG/kWM3ZIaaLXj7gFFbZhczUkJyivbUpD7pfqfqQDbVWkfPh64XISCRuTgSC4cbMiorVHD2Xkoq0HhkDJwxEFBcWMv0QAkaAPOAfwSLVxKZs8BmB80G1opnb2Wi8jVureWlf87VY3fbIfGidfxWuIKKT9LZa63OEQMMU8gvSf9BkBbKiDY7xUpI8N482Z7TVTM+dS9LPplknLQfOaysrBj0j2qPewZxf5ROw/RQ42saZyZGcKdQwVJAfANpDdozCzkXqfkPvuY7bSJ9jORY+HP1mgf2hgLHULkjAjDXHvHkH1peb6TL4osA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HdZv9rZBCoy7oqDEzyeCoaYCE/06iZ+hx2PUD3QolQb4hiz29aB/94aIP6yYKvu7UZwHpVPt8b+dIjFQpLtfi3vHN86662QWHgqCuSfnUbqSTEVftgqze7bM6Q59G6Nai1iZ/a8E8VA+OWL90kXAvuh1Zga+d0atkJHHp/CiSjSQRixxyFvW4YrwKC0cRU9d3AZR4BQPP7nG8wKBQOtM2EEb4CtaXnPqh1OJVGIh16zQlgB97JJ6Ke6ct68Ey2uoneHt17oGxIyJHp/t0NoB4ZSVHArTYeTEsYCOlXjt16Lg/EPPSPr2h+6Qi2BpqdkmZ40ToS/DN4DtQmzw0p/+MYdr9R56+X9W5sbC3R0HyvNrI8V2WwnHroV4Ivj/ipbgPG12CIEBtp2bfMXW6bBudwe7IXd9hdrf3SeeGyeg6RYL/uw2iae0OaCedTyn1AzY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:20.0188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262bc4b9-2cbb-4365-dac3-08df2f3c14a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This DC patchset brings improvements in multiple areas. In summary, we have:
 - Add Core 2 BLS initialization scaffolding with builder, executor,
   workaround manager and DMUB dispatch.
 - Run DC2_DC1_Wrapped dcn401 init as staged BLS builds.
 - Split dcn401 init register writes into hwseq funcs.
 - Read MPCC LUT modes, cursor lock and DCN401 PHY state, and add BIOS,
   link and DSC sections to get_hw_state.
 - Fix QoS bandwidth fields copied from DML.
 - Convert update scratch to memory pool.
 - Pre-allocate DC state for atomic-context commits.
 - Preserve planes on DPMS-on during DP test link retrain.
 - Poll passive DVI sinks for EDID readiness.
 - Re-init cursor offload to DMUB after resume.
 - Add fec_status check flow for 8b10b links.
 - Revert DSC programming changes for DCN60.
 - Update alt-ch size calc to handle MPO + ODM correctly.
 - Cap DSC bpp for USB4 DP tunnels.
 - Add debug options for DMCUB FW loading and forcing MPC combine.
 - Fix CRTC init cleanup and pipeline name OOM handling.
 - Various cleanups, coding style and KUnit test fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (11):
  drm/amd/display: Handle pipeline name OOM
  drm/amd/display: Fix CRTC init cleanup
  drm/amd/display: Flatten CRC update flow
  drm/amd/display: Clean up allocation handling
  drm/amd/display: Fix coding style errors
  drm/amd/display: Fix KUnit connector leaks
  drm/amd/display: Use kunit_kcalloc for arrays
  drm/amd/display: Destroy dup connector state
  drm/amd/display: Drop single-entry kcalloc
  drm/amd/display: Use kzalloc_obj in tests
  drm/amd/display: Assert NOT_NULL on allocs

Alvin Lee (1):
  drm/amd/display: Update alt-ch size calc to handle MPO + ODM correctly

Ashwin Santhosh (1):
  drm/amd/display: Pre-allocate DC state for atomic-context commits

Austin Zheng (1):
  drm/amd/display: Expose Generic Function That Can Be Reused

Charlene Liu (1):
  drm/amd/display: remove not used code

Dominik Kaszewski (1):
  drm/amd/display: Convert update scratch to memory pool

Fangzhi Zuo (2):
  drm/amd/display: Poll passive DVI sinks for EDID readiness
  drm/amd/display: Cap DSC bpp for USB4 DP tunnels

George Shen (1):
  drm/amd/display: Preserve planes on DPMS-on during DP test link
    retrain

Ivan Lipski (1):
  drm/amd/display: Re-init cursor offload to dmub after resume

Matthew Stewart (1):
  drm/amd/display: Reuse mpc401_read_mpcc_state on dcn42, dcn60

Ovidiu Bunea (1):
  drm/amd/display: Add debug flag to support for different DMCUB FW
    loading

Peichen Huang (1):
  drm/amd/display: fec_status check flow

Samson Tam (3):
  drm/amd/display: Revert "Program DSC prior to OTG enable starting
    DCN60"
  drm/amd/display: Revert "Add new config_dsc hwseq function for dcn60"
  drm/amd/display: Revert "Split link_set_dsc_on_stream into encoder and
    DSC components"

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.81.0
  drm/amd/display: Promote DC to 3.2.404

Tony Cheng (18):
  drm/amd/display: Add Core 2 initialization BLS scaffolding
  drm/amd/display: Scaffold Core2 BLS builder and executor
  drm/amd/display: Add Core 2 Workaround Manager scaffolding
  drm/amd/display: Scaffold DMUB inbox BLS dispatch
  drm/amd/display: Scaffold generic DMUB GPINT BLS dispatch
  drm/amd/display: Scaffold DMUB STOP_FW on the init BLS
  drm/amd/display: Name the init STOP_FW entry DMUB_HALT_FW
  drm/amd/display: Scaffold PSP reload, ABI query, and Initialize DCN
  drm/amd/display: Call the init BLS from Core2 hardware init
  drm/amd/display: Attach retained DMUB windows to PSP reload
  drm/amd/display: Split dcn401 init register writes into hwseq funcs
  drm/amd/display: Add dal_gpio_ddc_open_aux_once
  drm/amd/display: Dispatch the dcn401_init_hw calls from the Executor
  drm/amd/display: Narrow the DMUB-driven dcn401 init builder helpers
  drm/amd/display: Run DC2_DC1_Wrapped init as staged BLS builds
  drm/amd/display: Read DCN401 PHY reset and lane enable state
  drm/amd/display: Read cursor update lock into mpcc_state
  drm/amd/display: Add BIOS, link, DSC and cursor lock to get_hw_state

Wenjing Liu (3):
  drm/amd/display: Fix QoS bandwidth fields copied from DML
  drm/amd/display: Remove deprecated bandwidth Kbps fields
  drm/amd/display: Add debug option to force MPC combine

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   69 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    4 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |    8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   24 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |    5 +-
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |   84 +-
 .../tests/amdgpu_dm_backlight_test.c          |   48 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |    8 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |    2 +-
 .../tests/amdgpu_dm_connector_test.c          |   80 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  248 ++--
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  168 +--
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |   24 +-
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |    4 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  329 +++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    2 +-
 .../tests/amdgpu_dm_mst_types_test.c          |   12 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |    6 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    7 +
 .../amd/display/dc/bls_builder/bls_builder.c  |   21 +
 .../amd/display/dc/bls_builder/bls_builder.h  |   98 ++
 .../dc/bls_builder/bls_builder_internal.h     |   11 +
 .../dc/bls_builder/bls_builder_legacy_init.h  |  128 ++
 .../dc/bls_builder/dcn401_init_builder.c      |  413 +++++++
 .../dc/bls_builder/dcn401_init_builder.h      |   42 +
 .../bls_builder/dcn401_init_builder_legacy.c  | 1071 +++++++++++++++++
 .../bls_builder/dcn401_init_builder_legacy.h  |   18 +
 .../drm/amd/display/dc/bls_builder/dmub_abi.h |   13 +
 .../display/dc/bls_executor/bls_executor.c    |  703 +++++++++++
 .../display/dc/bls_executor/bls_executor.h    |   21 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  125 +-
 .../drm/amd/display/dc/core2/dc_core2_init.c  |   78 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |  236 ++++
 .../display/dc/core2/dc_core2_legacy_init.h   |   17 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   33 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    4 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  173 +++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |   22 +-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |    8 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |    7 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c |    2 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    1 +
 .../dml21_wrapper/dml21_translation_helper.c  |   11 +-
 .../dc/dmub_messenger/dmub_messenger.c        |   81 ++
 .../dc/dmub_messenger/dmub_messenger.h        |   55 +
 .../drm/amd/display/dc/gpio/gpio_service.c    |   19 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   48 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    4 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |   97 --
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    1 -
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  229 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |    8 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    7 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |    1 +
 .../display/dc/link/accessories/link_dp_cts.c |   19 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  336 +++---
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    2 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |    2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    5 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |   10 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   10 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    5 -
 .../dc/resource/dcn42/dcn42_resource_fpu.c    |   22 -
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |    1 -
 .../workaround_manager/workaround_manager.c   |   74 ++
 .../workaround_manager/workaround_manager.h   |   46 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   11 +-
 .../display/include/gpio_service_interface.h  |    6 +
 84 files changed, 4603 insertions(+), 997 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h

-- 
2.43.0

