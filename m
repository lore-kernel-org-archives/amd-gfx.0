Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAD1C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914BD10E797;
	Wed, 16 Sep 2026 17:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R19Oalse";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6B310E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBkSOwdv1qaG0yLYMfUEM6FS1HjiM+CD+aIJlzoDmBMN9auWuMAF1o9OzqIuVgBRzX+R1CcCv7Kk0G7TQj6hludyWRusHicKxxV34WaezJYJ/A9L9V0SNm5mc5r897IYJUMSKeguR53WXo6/miUxvR5++hUGkayReP9xbI1iy5zExFpTSAeaUVVvpKnrx22zrqkuqTXpUZveVjadOmcnmoVm4ot4iXOWLLiGEualR2f3VBxZsRVIabLsxUyaNp/1jzzU8RybnJMzb8HnKXH4yq4i5M+a0/digzs/hiFXX+4M6+4A0ivqf0/iHExXxrKnqr2hazB909zqeZR4t55XsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0A+sj2cX+Mt92JFjzjTZyQOPfixSJ+8c3/7T2sZqZg=;
 b=nLVFcVAvrYd29FgHXOXuSEg8Ty+hvmvfKj37m+Ns2Gc7QhA9Xwuskslp5bhjTWacEb+IBnJOk7osanCRZuxMOBPF8Sd2StfrMjwuUu1hMz4SjuwNKAxn5nSZ9hm6EgIkMwlb0qN5QjoMAgZHeaFH/MK16B5YMOKNWXCayj+mj9UfBQ7z14DRsGBczRYS5ihM3Z6aIz9pc46tCGW6wgvPpufzGadCcnJxgpO9hrLo1jB+qJP3L/AUckhd/RtSnUAoyCDpIkVmveFSQThtXl7F+CJ4YrvQznmKhptKWQolfGZPvhKH7QkfOs+6vz6qPigB59IU0ghUelNKr15glKTODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0A+sj2cX+Mt92JFjzjTZyQOPfixSJ+8c3/7T2sZqZg=;
 b=R19OalsewCH7V2hzRx54bP6gkg9LtnJ6K34x4Xm38LiTXUDDAdFSXoixI8PB1RtMKpTAK6sMRYpOCdYZAxwHB2CtC31Ex+bkopsJXtqbJI4WVC10LKa2LGou/R8VJWywwB0g39jker6DNgxzXhW16l5afvayQEILuvOauhTA/gE=
Received: from CH0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:610:e4::11)
 by DS4PR12MB248322.namprd12.prod.outlook.com (2603:10b6:8:509::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:16 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::29) by CH0PR03CA0186.outlook.office365.com
 (2603:10b6:610:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:16 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:09 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 00/64] DC Patches for September 16, 2026
Date: Wed, 16 Sep 2026 13:51:15 -0400
Message-ID: <20260916175301.368306-1-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS4PR12MB248322:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c85bf8-8816-41de-b64b-08df141b3ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2xBFQcu5htFDxpKR/9vBMPx+KJnaGO8lQHVR9CCn3wlG1D1ScW0WSbTPOOnWxB+/Kwx6r525PPEBE5xTC3Q7S1ou8JZJVZnvAZXDvQGaiGa9ZmMYU0oiZrIMpVKW/W6g0glwI1Ia4lH5JVZPKqEKDuzQmUxG5OEsY0vNQsSFswZYLwMqxw1ve2Ngb0jURYExJLMV1TyrUy+/FomriTPRT6iizP1QibLTAzaqPebc50b9BaxpiT/C5QLigV7iIpysoNJ9QxJlHuhfyhgL5xEEPERoFDYQFnOUcLn+qetjwgxLtID1e4fLkA8Z7DwZk3CkXm+OhjhWKD0GQoVKoAtJsDiAEL5t4/Y7ibH0l23PCYnQpIAcZQ1gtXyfiB1m5Tw/a+RbARt8Z82IwvZSUI1s5zrJvsqMzxQwRgmI0+KzOemfEMls5M0Tkb8VxFJ9xiv95yXppg8sHCpPf+jq+y9NoQb2S+nTIGtFAq9Ci8uTAFfRz8L7K3TjEN5fKLWM1z5TWbJtSdKPZODaV86x4UBUXK4Wt0oYhyCrvSXXZBajbcBBkkptnSPwMjVwWXccXU5IeuIUVCY8wmyR3Q02oeRud8ot0Q5S9XFNkURVv8lJZx7/xcKYhLIGISVwhp4+Ot09lWRJsmdnaLaUrNE3y+kwrnbKf3OrxTy4EFngYVSb1JWT25GehadpLlkBN0QmhqDhEyIYdkyODaiyoTpHuT42LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Piypp0rj3BTBDr7T9ZrY/48oG77z4pRkMb7Z1mAxY4F3rrieG9TqR/7nO/xacQF5GKCixWaaSf3edozTWI2sDyEYiFUvjP1VbmK43Wbxc03zWwxn4FrPwoUBeSNWMHWeIX60LiamWtRMw09/4zD4YwSVfGsyUwY40PKEjwOIBwUz7BQVR6BpyAiytZKONAwD+gcV+js3UVn1ztqjv7NLkIwTqjFGVkr6G5QX35+qWN8ROchTDuj6Yus5hDEzFVnTZkAIKNhkZPP9jd88+v3X+mSkHBnNxyvQ2ewCfXztHJh9kUuBcSmuZ6XnQr2D4PelLK1K9pWvrpFStDYJzpQ58nLeGWssHMfYqc2xKcToOuOPxo4Ro5wI90wGobyIzilcvkeasjHQWry0+o5PB79OGBBjD+3MS5qoCSS61u5RaQ+fyh+FvnSCgpksvftMpxw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:16.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c85bf8-8816-41de-b64b-08df141b3ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB248322
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
- Increased KUnit coverage
- Reverts a patch causing regression on DCN42
- Fixes for cursor
- Imporvements for ABM


Alex Hung (33):
  drm/amd/display: Select KUnit helpers
  drm/amd/display: Fold blending tests into two cases
  drm/amd/display: Fold universal overlay format test
  drm/amd/display: Fold plane modifier list tests
  drm/amd/display: Fold modifier append tests
  drm/amd/display: Fold GFX9 tiling info tests
  drm/amd/display: Fold GFX6-8 tiling and modifier tests
  drm/amd/display: Fold DCC validation tests
  drm/amd/display: Fold DCC block mode tests
  drm/amd/display: Fold plane scaling and cursor tests
  drm/amd/display: Fold plane state check tests
  drm/amd/display: Fix amdgpu_dm's kernel-doc warnings
  drm/amd/display: Test EDID helper paths
  drm/amd/display: Test AUX transfer paths
  drm/amd/display: Test MST topology start
  drm/amd/display: Test unassigned OTG CRTC lookup
  drm/amd/display: Test VRR pageflip completion
  drm/amd/display: Test HPD RX offload work branches
  drm/amd/display: Test HDMI HPD debounce re-detect
  drm/amd/display: Test HPD handler HDCP and detect
  drm/amd/display: Test HPD RX downstream handling
  drm/amd/display: Drop redundant amdgpu_dm_irq tests
  drm/amd/display: Fix KUnit connector warnings
  drm/amd/display: Fix KUnit CRTC warnings
  drm/amd/display: Fix KUnit cursor warning
  drm/amd/display: Fix KUnit VRR warnings
  drm/amd/display: Fix KUnit helper warnings
  drm/amd/display: Fix KUnit IRQ warnings
  drm/amd/display: Fix KUnit MST warnings
  drm/amd/display: Fix KUnit DM warnings
  drm/amd/display: Fix KUnit writeback warnings
  drm/amd/display: Fix KUnit checkpatch warnings
  drm/amd/display: Fix LSDMA divide by zero

Alvin Lee (3):
  drm/amd/display: Enable double buffering for DSCCLK updates
  drm/amd/display: Wait response should be based on fw_based_mclk_switch
  drm/amd/display: Re-enable P-State message to SMU

Austin Zheng (1):
  drm/amd/display: Add Back Unified CalculateFlipSchedule

Dillon Varone (1):
  drm/amd/display: Add more diagnostic logs for DMU

Fangzhi Zuo (1):
  drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks

Huang, Leon (1):
  drm/amd/display: Forward periodic ABM keep-alive scenario to DMU

Ivan Lipski (3):
  drm/amd/display: Expose 3 overlay planes on DCN6
  drm/amd/display: Remove DCN6 DCFCLK num assert
  drm/amd/display: Resync cursor cache after offload abort on DCN60

Matthew Stewart (1):
  drm/amd/display: Fix DCN42B plane alpha

Nicholas Kazlauskas (1):
  drm/amd/display: Fix missing gaps for link lock with inbox0

Piotr Maziarz (5):
  drm/amd/display: Refactor DPP_PROGRAM_UPSP to drop pipe_ctx
  drm/amd/display: Remove phantom SW state ops from block sequence
  drm/amd/display: fix cursor refactor fallout and sync UT headers
  drm/amd/display: clamp cursor hotspot at the register write
  drm/amd/display: Rename build_cursor_position to
    dcn10_build_cursor_pos_update_params

Rafal Ostrowski (2):
  drm/amd/display: Drop pipe_ctx from hwss block sequence operations
  drm/amd/display: refactor hwss SET_CURSOR_POSITION block sequence

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.76.0
  drm/amd/display: Promote DC to 3.2.399

Tony Cheng (9):
  drm/amd/display: add SPDX-License-Identifier
  drm/amd/display: Add inst field to struct hubbub
  drm/amd/display: Add inst field to struct clk_mgr
  drm/amd/display: Add inst field to struct abm
  drm/amd/display: Add inst field to struct dmub_psr
  drm/amd/display: Add inst field to struct dmub_replay
  drm/amd/display: Add inst field to struct pg_cntl
  drm/amd/display: Add inst field to encoder structs
  drm/amd/display: Add inst field to clock_source and dio

Tony Qi (1):
  drm/amd/display: Revert "request DMUB HW cursor offload"

 drivers/gpu/drm/amd/display/Kconfig           |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    7 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |    6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    9 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    1 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |    1 -
 .../tests/amdgpu_dm_connector_test.c          |   64 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   50 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |    4 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |   22 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  250 ++
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 1066 +++++----
 .../tests/amdgpu_dm_mst_types_test.c          |    9 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 2036 +++++------------
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   43 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |    4 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    1 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    7 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |    3 +-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |    3 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |    4 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  |   36 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  301 +--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   23 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  134 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    2 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    4 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |    4 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.h    |    4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |    2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |    1 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |    1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |    1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |    1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |    1 +
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.c  |    1 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    2 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |    2 +
 .../display/dc/dio/dcn20/dcn20_link_encoder.c |    2 +
 .../dc/dio/dcn20/dcn20_stream_encoder.c       |    2 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |    2 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |    1 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |    2 +
 .../dc/dio/virtual/virtual_link_encoder.c     |    3 +
 .../dc/dio/virtual/virtual_stream_encoder.c   |    1 +
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |    2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  164 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../alternate_pstate_shared_lib.c             |   22 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |    2 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |    2 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   19 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    1 +
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  |    2 +
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |    2 +
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |    2 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |    2 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn301/dcn301_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |    2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |    1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  105 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    2 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |    1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   20 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   14 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    1 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   11 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   71 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    1 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |    6 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   75 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |    1 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    2 +-
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |    1 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |    1 +
 .../dc/resource/dcn60/dcn60_resource.c        |    6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   58 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   53 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   84 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |    2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   98 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   98 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |   98 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   54 +-
 153 files changed, 2963 insertions(+), 2688 deletions(-)

--
2.55.0

