Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ivAuQ1C0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDB810F88C;
	Tue, 27 Oct 2026 23:20:37 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2D310F88C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe9G0LyUZ8xhS/h9jcRDq9pGJG2SIgohq4nEyr7ARuY8Bs7G1qEO5wSnYNxjVH3wGArt3YdJyYZ6pjVfOflzkRwZ90bs/nQTznq9RiANTpBzSX+2EAOKA1Ae4L3f1pYRcGdX8y5l0rnv9neRQAhVd0EbrqyV3KafuAzGr8IMHWNO/PiXrH6fFyzRjA8JX5dSf+a/vkmDsmN18h4NhCEU9JtJXbkSsmqjz2Hx5jkXxuo7DtjMB5s7f/WUu0T8XL6qczatCilCs262u+YSJjh6XHwSaqZ2rmi5wWtKSFKs+PwxNoie4uE1wQhg96cDj7F5RBYcBObp//9B1cAMDi1LTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o7j1dzKSH/YmXFGhc/HEZXXXJu3MSc/zktIVNqRhuw=;
 b=n+MRyN9zHRJhkThWIPf+EaaTnYFrU1HwiHQlQPmRdWuMu1L+7Oaqv9HKPIg7TJJXu5bjaMG6E48mBY9mTf2VpQyEhkmLL1GNrTn2g6giXdhp9Kv5xG55gz7hFFWoCEiL1OBJ2lcDy2yn4+RWO949psM3GgV6XDeH3QEJZ8/9AyX1gvKCEq+HNLHlQkGOs2UkJLj/cZw9oWq/C9LRdBTSgYiz7z957Hb45UCsbiNq0Sn46Y0LHKH41GuYxkRbk56ny8f6ny5QNZ6imAGTH8l7nZoMUm6WbNVluaEVINoF3dRSYmpAIUIkZ9Qen2EI92GlffypYY3GH3ncrDcKF9NPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o7j1dzKSH/YmXFGhc/HEZXXXJu3MSc/zktIVNqRhuw=;
 b=ivAuQ1C0k01H0DS/Vc/WFYAlC8jgvOExt4LVWqpPK3plm6F36z8UW8H6Pw21SEXtRThYwwKGkMvMNYm9BXwbICMkWOWKCOOXulLWkqzBpKZtC28RnJ7AemUwjwxW9n0ORQ775As/gSAnG23xe5nSINp+38Bv/G4M0tOv7D7ciPU=
Received: from BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:20:25 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::99) by BL1PR13CA0012.outlook.office365.com
 (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.6 via Frontend Transport; Tue, 27
 Oct 2026 23:20:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:20:24 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:20:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/28] DC Patches Oct 27, 2026
Date: Tue, 27 Oct 2026 17:16:56 -0600
Message-ID: <20261027232005.2879750-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ce0cf5-5cd8-4c5f-32d9-08df3480e113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|261026121527099003|11063799006|261021123027099003|56012099006|261021121427099003|261022105027099003|261022075727099003|10067099003|261009223027099003|18002099003|10086099003|18092099006|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info: n9QnL+jAJXLfphbWNjpZK0KbXt9cMe/q3KPqD7+hhjFDhekhffqoy/uaRubbdjzryRwcTobXEWYo3YC8n2HmHuDvWwrs+7rm6MOdxdlTQPFZ1PRwB21BTgvzraSvcnMPRnm2zor4NFj8eC4kezDQcPw3KGZEJ9Biza7vZBuEOu8m9IHJPQVodffFhFZW8ex+Hy/I6EFLX8ASKPTxunh4WFAfyahlPwZBK7SalSQbswM4ghjXw6RDZwVXGCNqatKdpBvymmFsTkfiuEpwsFOfBit8IYedRJDvvTOiqo1wRJALZeZsajhFPJJoPPByIawD3lLNsa48caU57YeFx29Z68kS2/biklu/YwMIKitgKcum8+IpJA+1pZ1nzi7YmAmCxBIVxOEHWqgOtXb5lv9dgaL7rTGe040Y0UbYGstRkxik3GqW+otQF53jFD6atgCPg3uvRzVq4yR3CBEv8LCrLhmVSdGZ9Hq2udmxDt84t9CDOZt8QSUqWnnwfSJ9NzLsVOQDUNVYE3TyohzWFCpfgiUsmpn6SIJfwOgN4MS2C0WMoJjxqvvL8lw9zbLI5shOCvfaUEizf97pEd9abUSOIMLZQsqc1tcqvQHAz5As9GnGflj/bQ59FVz+MaqwxkW5CGd0zJ1OJjpWDjBKaiSJqgIvLb9ohoEonQDocmJpIaC5SajustuVZYycjokNz4M+QbTTl9vsTbOy7COy2u+dMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(261026121527099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(261009223027099003)(18002099003)(10086099003)(18092099006)(3023799007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: an1wbqV8zMaLC9C4x5jF9MDjTkIA91fm9hXhEhB3JTiwk0BuUAK7jFJaPKXjZZsFBmlWi8tbtiFGxJFl7SuL4vLa7mCyEDLdN3yU3RJopa5i5f5TGtJljLf8qo5dQIGwnCUlJPcEZhkVR9yPrew+XET9u4UpRWmJQntj1qGsmIK3Mk6zxqwmFA2b5TAkEqNIC2+Oiz6Vo2kIRe50+0QnNILEB0xly4FEcBTnJAyJRbKKVde4Yfj4DT+sPArLDEaRH0vQQHBJ6TSSatE9vvO+O7M+banLDq3/N1qHZCbTSe8rnwNXTEzOoAxCt9Q/0LbIjmkG1qScn2GVkKijnC/lVUNl6fBLvry+Q4F2sW8CkSjgsTh+mTOSYpZu4T6oYf/JidNg3Xerafxy4L1BtEVkxmG84u1CgFC4Nxz1qjb4zfR/ryhPrQ/aXxhQqFh20s4a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:20:24.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ce0cf5-5cd8-4c5f-32d9-08df3480e113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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

* Fixes on mode detection, DSC with DPMS off and HUBP DET reset
* Fixes on DDC pins and missing OTG_CRC1 regs for DCN3.1.x
* Improvements on DCN6 FAMS immediate restore and PPCLK_e enum
* Improvements on DSCCLK check and DSC slice calc policy
* Improvements on Replay frame update interval and debug mode
* Improvements on DML VM rounding and P-State optimizer
* Removal of DCN401 RDPCS PHY state reads
* New debug options for HDMI VRR and visual confirm
* More KUnit tests for connector, CRC, color and backlight

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (5):
  drm/amd/display: Avoid closing unowned DDC pins
  drm/amd/display: Add more backlight Kunit tests
  drm/amd/display: Add more color KUnit tests
  drm/amd/display: Add more CRC KUnit tests
  drm/amd/display: Add more connector KUnit tests

Allen Li (1):
  drm/amd/display: Allow bypassing link_off_frame_count check for replay
    debug mode

Alvin Lee (4):
  drm/amd/display: Add visual confirm full viewport debug option
  drm/amd/display: Indicate wait_resp based on FAMS even in disable path
  drm/amd/display: Enable immediate restore for FAMS on DCN6
  drm/amd/display: Update alt shared lib to use dynamic state

Austin Zheng (2):
  drm/amd/display: Update Rounding For VM stage groups
  drm/amd/display: Parameterize FCLK/PPT/Temp Read P-State Optimizer

Dmitry Artemenko (2):
  drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.4
  drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.2

Dominik Kaszewski (1):
  drm/amd/display: Clarify endianness error

Fangzhi Zuo (2):
  drm/amd/display: Fix unadvertised mode detection
  drm/amd/display: Add debugfs override for HDMI VRR

George Shen (1):
  drm/amd/display: Skip dsc sequence for stream if dpms off

Ilya Bakoulin (2):
  drm/amd/display: Adjust DSC slice calc. policy
  drm/amd/display: Expand DSCCLK support check

Ivan Lipski (2):
  drm/amd/display: Use DCN6 driver_if for PPCLK_e enum
  drm/amd/display: Configure alternate-channel apertures

Meenakshikumar Somasundaram (1):
  drm/amd/display: Support replay frame update interval

Rafal Ostrowski (1):
  drm/amd/display: Decouple FAMS2 config update from dc/dc_state and add
    BLS opcode

Roman Li (1):
  drm/amd/display: Reset DET of HUBPs without a plane before outstanding
    updates

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.82.0
  drm/amd/display: Promote DC to 3.2.405

Tony Cheng (1):
  drm/amd/display: Remove DCN401 RDPCS PHY state reads

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 110 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  30 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  63 +++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   2 +-
 .../tests/amdgpu_dm_backlight_test.c          |  79 ++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  18 +++
 .../tests/amdgpu_dm_connector_test.c          | 118 +++++++++++++++--
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 124 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  37 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  69 ++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  47 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 113 ++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  27 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   1 -
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  16 +--
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  22 +---
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   8 --
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   2 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |  24 +++-
 .../dml2_core_dcn6_funcs_mode_programming.c   |   1 +
 .../dml2_core_dcn6_funcs_mode_support.c       |  19 ++-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  25 ++--
 .../alternate_pstate_shared_lib.c             |   2 +-
 .../alternate_pstate_shared_lib.h             |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   1 +
 .../src/inc/dml2_internal_shared_types.h      |   4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  24 +++-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  64 ++++++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  20 ++-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 -
 .../dc/link/protocols/link_dp_capability.c    |   6 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  18 +++
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  18 +++
 .../dc/resource/dcn401/dcn401_resource.c      |  10 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  31 ++++-
 .../amd/display/include/link_service_types.h  |   2 +-
 49 files changed, 987 insertions(+), 206 deletions(-)

-- 
2.53.0

