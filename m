Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DB606A323
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MhqE8gIM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F5D10E3B0;
	Wed, 25 Nov 2026 06:55:25 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454EB10E3B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmRfk+ZU22R/jNVJc3dFRCbhpiIhK4r8SdW3ltc6Dd6BN4lukdawq3qGU4Vye6o273lAJ6+gvJl8CTjt0mMSPj+3BndLgO2Nul5d5xBIFd/4D0b5XtbLtxerGQpv97M8q4hvqFphL+ay7ChO9njp/T1Anfz+269J8na+30mx7ywjRHh92EL5hbdxSJFwfluUD08OI9T45YTl3o8bxsLmWxkH6dc48jSJXkmTgibPS717ilBL8NoUkQVDVkjTJFVOfMHmFMRlPxSUYtuabRD/2vDsiXhJnWYUu7tkGirzo5APIHBP/dSkNteIHN0wu1VPsFlOE7euIgeuKhxDFsXcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPXPFF0RIFJIolSqmItdZ/4yck/2USunOIteqI8GKRw=;
 b=u/CQIbeD9wtulz5kgzkJ0+LDif4y0Vrju0jRGBZ3FOEuw8B85JxWBj3NRINuSCkcN13wcTm3ViuWJGq+9NxPeRRPLpvR+hospa/6W7V1v+Ef2SDN3g+QWu5UbDhIUjW2XWtOJUki+tI5QnGmqiWJ60Px0By7lCUxzdqNu3kB5V15RJxsX5XrEoO6T0OHnhr+pTxcMc8dzVtBR8oAn8RfZ6MlMjuKJjts8rj7ih128jkKZQuaMHt92bsvjZOhT0O8C9wBSp0xmdAIJvnDMWnrfE+5T1FDy/yZuG1KHmRKt89sv4s6S7xnJczN4lsCHtEhNHlbqMKDfKhb0LmqcxNB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPXPFF0RIFJIolSqmItdZ/4yck/2USunOIteqI8GKRw=;
 b=MhqE8gIM9hBWnnFPtBXsdpVo/zYt27Fvwo1lAbifeIn2k6CUystRuNy/sSKpyPq8gcCJrbQS0WmqmVht3nMmUJiyRqY72ZPI2l04KM4sRTkraiSaXXwg337RyC6gJ02PbWdKHtaPIJwWgHRj+wLayfqgAwlZAyYAxsdEGpWb++Y=
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:55:11 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a4) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:55:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:10 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:02 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 00/27] DC Patches Nov 30 2026
Date: Wed, 25 Nov 2026 14:54:49 +0800
Message-ID: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbb7a1a-e3cb-48e1-04a6-08df4ac10cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|261022075727099003|10067099003|261021123027099003|56012099006|11063799006|261009223027099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261026121527099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: gZl9UMeFm9GVkPFrPb9eWPIEWt0RUWpF6XorWsnd35DDN6aLpV7i/UZizKF0WYaugJTUUz6kxMdSJaFUbfEvjwUbNulbIminI2BeJqd5iV+NLKPGgD/ztYAKsjRIAOahGxKYvCUvvuY/bON5S76lsS4uUWJV9Dxq9zEt6T+yIRL6Q1l0T32FSPKZ8uHsIJT4OcTrSJ5nI1B9KV6WWYW2r6RVRgzlSRJxStiokomq2AQeiKfjRPJ5u+MaErKBepwSr/H/0oQQ/7/FnFEJGDphWnZXfQCpWbEvKhzvur2UU+/ywxJRG7NKjUP3v4H90+Cb/q4aVb8w9x2mVpCKEmmSu9UvnltOnjunYz/Hv4QYB+Lo8xp6Xuzvjp0TJwJ7DSVddWxq6h15y1kcEswlkyb4t3/tQJRi/aqJzQemMP5ghmYbgYB0AEG/29/ZFcYnprKoD1WRfPCMceTBZZ3nLT0qY1lHlDi+EQ5YmThev6INVMN5wmrHChVO+0vdvKxHW4DGOMjPUpuAwYsV63y4giYxy4xM1Fj8UYQ6BSmLxRISd96oOqoP6Nj9fZNvY5dKNkSmYD6DGUxZDdSZhvAIFKZiadEG+LBVuLGRmFvOFKOHVWJXlB1oWAsYAkvPWXZ747QqfqHtisInn5JJnU7aup0OCLSlXt8hDlCpwN+5shYLbwtctbVWu785BFdotuX+SB9YhZrKJmgurYZbSFiyk+qo9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(261022075727099003)(10067099003)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026121527099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCh95hBhX7mjTQrc1sXKQ/cQCkQYfemkzOB9435rAg7a8f9VZBM7qk3288zz1TjzziXXKe+3HQ1nFZR4RYn1wQJOxzHglgFtuTEQs7YdJiPW0fFWbwRYuMzHo06KuGK5ZBAo5OumrXU70yCvzyx8lQeNsQft0hmF/Mw5yS29taB836aqkyb+kjOcQdqiWJjYe3zFq9eOKjwUg0hsMVXkkPRSJNLdLxVaVPqnuTPhK3hGMSr6Q7cbUY+H9ImYrlqh4rydY0PPziX7AB80wvOdg1rIwZqpTkqEHb+rwJMAvuKLVT1VSMibfnjPy7mdYvpQmVBMxLVjZHKOatIxRtPs0j9aeHcPD1Ud8k/yvSx247fjZV2tzNVATK0kOWooAutADJzod4CsupTvWv+2+kWURSD7+tewDohHF4bGANWXYphB3CLjoZWEZHEBkXCtYQ8i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:11.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbb7a1a-e3cb-48e1-04a6-08df4ac10cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Avoid per-entry long division in __drm_lut32_to_dc_gamma
- Add more diagnostic logging, a debug option to force the DP link rate
  and per-CRTC pstate method in connector debugfs
- Reject Replay activation on an inactive link
- Decouple PROGRAM_CURSOR_UPDATE_NOW from dc and pipe_ctx
- Add DPMS-v2 init and tx init, and implement link_set_dpms_off_v2
- Derive DCN6 DSCCLK range from DISPCLK
- Carry stream and plane update bits in update_flags and add vsync and
  immediate flips to the DC2 seamless update
- Preserve bandwidth floors in overrides
- Set HDMI bypass earlier
- Add DMUB timer reference clock to ref_clocks
- Guard connector I2C transfer without DDC pin
- Refactor ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE
- Add amdgpu_dm_dmub tests for alt-ch apertures, SET_CONFIG sync wait,
  AUX transfer timeout and fused IO replies
- Use Z8 enter plus exit for vblank reserve
- Fix two streams sharing one OTG
- Count planes, not pipes, in the surface check
- Promote DMUB firmware to release 0.1.86.0

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (1):
  drm/amd/display: Avoid per-entry long division in
    __drm_lut32_to_dc_gamma

Alex Hung (4):
  drm/amd/display: Test amdgpu_dm_dmub alt-ch apertures
  drm/amd/display: Test amdgpu_dm_dmub SET_CONFIG sync wait
  drm/amd/display: Test amdgpu_dm_dmub AUX transfer timeout
  drm/amd/display: Test amdgpu_dm_dmub fused IO replies

Allen Pan (1):
  drm/amd/display: Add debug option to force DP link rate

Alvin Lee (1):
  drm/amd/display: Add DMUB timer reference clock to ref_clocks

Charlene Liu (1):
  drm/amd/display: Set HDMI bypass earlier

Dillon Varone (1):
  drm/amd/display: Capture more diagnostic register state

Dominik Kowalski (3):
  drm/amd/display: Add DPMS-v2 init
  drm/amd/display: Add DPMS-v2 tx init
  drm/amd/display: Implement link_set_dpms_off_v2

Gabe Teeger (1):
  drm/amd/display: Fix two streams sharing one OTG

Harry VanZyllDeJong (1):
  drm/amd/display: Reject Replay activation on an inactive link

Ivan Lipski (2):
  drm/amd/display: Expose per-CRTC pstate method in connector debugfs
  drm/amd/display: Derive DCN6 DSCCLK range from DISPCLK

James Lin (1):
  drm/amd/display: Guard connector I2C transfer without DDC pin

Ovidiu Bunea (1):
  drm/amd/display: Use Z8 enter plus exit for vblank reserve

Piotr Maziarz (1):
  drm/amd/display: Decouple PROGRAM_CURSOR_UPDATE_NOW from dc and
    pipe_ctx

Rafal Ostrowski (1):
  drm/amd/display: Refactor ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.86.0
  drm/amd/display: Promote DC to 3.2.409

Tony Cheng (4):
  drm/amd/display: Carry the stream and plane update bits in
    update_flags
  drm/amd/display: Add the vsync flip to the DC2 seamless update
  drm/amd/display: Add the immediate flip to the DC2 seamless update
  drm/amd/display: Count planes, not pipes, in the surface check

Wenjing Liu (1):
  drm/amd/display: Preserve bandwidth floors in overrides

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  21 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  34 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 283 ++++++++++
 .../bls_builder/bls_builder_private_types.h   |  12 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  14 +
 .../dc/bls_builder/dcn401_seamless_builder.c  | 482 +++++++++++++++---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 192 +++++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  64 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  76 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   8 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |   8 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  66 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h |   2 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  15 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   4 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |  12 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |   2 +-
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |   2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  35 +-
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   6 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   1 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.h    |   3 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 108 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  59 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  11 +
 .../drm/amd/display/dc/link/link_dpms_v1.c    |  84 +++
 .../drm/amd/display/dc/link/link_dpms_v1.h    |  29 ++
 .../drm/amd/display/dc/link/link_dpms_v2.c    | 250 ++++++++-
 .../drm/amd/display/dc/link/link_factory.c    |  90 +++-
 .../link/protocols/link_edp_panel_control.c   |   6 +
 .../drm/amd/display/dc/link/tx/link_tx_v1.c   |  55 ++
 .../drm/amd/display/dc/link/tx/link_tx_v1.h   |  34 ++
 .../drm/amd/display/dc/link/tx/link_tx_v2.c   |  83 +++
 .../drm/amd/display/dc/link/tx/link_tx_v2.h   |  38 ++
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |  82 ++-
 .../dc/resource/dcn42b/dcn42b_resource.h      |   6 +
 .../dc/resource/dcn60/dcn60_resource.c        |   4 +
 .../dc/resource/dcn60/dcn60_resource.h        |   1 +
 .../dcn60/dcn60_soc_and_ip_translator.c       |  15 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  12 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  40 ++
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |  39 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  37 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |  36 +-
 .../drm/amd/display/dmub/src/dmub_dcn42b.c    |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |  38 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |  36 +-
 69 files changed, 2331 insertions(+), 297 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h

-- 
2.43.0

