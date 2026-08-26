Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7116C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F9E8876A;
	Wed, 26 Aug 2026 23:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UgO9ZzL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C1310EE2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwJu0vWJqRhebCjDK3yPzrAHt2uJFqb3+0OaGmJSsR5oVAIH5PN1bR8j80dSlyFxMn+nt7cx2GZlFmyvz0v8pVVOjJRvFGDO1a3eWJmMbpCqqugxeH+EHwZ7Hk1UBiq7cWUqkC7aTswmpFJaieJ7XbijH48EbfTN5E4p/Rp9YQOSZ21T9Hg4IYx6h3iOPpjNu0qOlYJPrM79yCKu630SRR6Nj8CvPryDWV1R82qW86YrfwYdmfrPRSYPyJtWDQwL6G1BQ69LCv83ATcgD5aevY6p014HRAiqykYJ6enliVaktGmyJVYbsvdm1EnIdq6i9KcvrMZGI10yjvNxxHWOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvTtpLH3ozC0nETCvdZCfVr8XzHwgohY7Nc2+ZSGOos=;
 b=Gj1xkGwkaQM/uFj4YZ09htGfAUK9j2WBQn4ZHsJ49tIaEMekXfLg4fkb/5ZLdYA5a1QWnDZA+KXN31ydBCdYL9YRJsgr8zQQI2sbIkHUbr5bsH/X/v8rjzcndbsEk/hmIt/IF/G+jFBhdnqUgJiv3DmOsByZdUXw+9TcpjLs+weIeQ3VAqK2SwrCyGkATGI+wWqnvlU8LSbuseVJ+RAg8uSbFf8l2h4tpiEER0MkFRXgbxDKW4pXXdSUx4R2zdbdCPqyFYI3D5zW1+gilogm7sPZUjqNEN9Eyyv9+gAjFSe5V4LXmQ7GV0dvQLR5iebV4M5/N0O4FDYabCHs3/KnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvTtpLH3ozC0nETCvdZCfVr8XzHwgohY7Nc2+ZSGOos=;
 b=1UgO9ZzLvslxN4p7vEl8cwXS5Uo1CKgKnZ/MI9teMf14jJFqlhlKPKOFFhEq1ikEHigCnnuB0RU1ZoHn9wlShTmR+5NBrCxI050OIKDnnBun8OgEPhEDLhHt8nIpriaNqgex4mU6xCkUnTOPcXRLWugtVsEwYuBBbNEWGB8V1Wc=
Received: from DS1P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::18) by
 DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Wed, 26 Aug 2026 23:15:52 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:242:cafe::51) by DS1P221CA0019.outlook.office365.com
 (2603:10b6:8:242::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:15:51 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:15:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/59] DC Patches Aug 26, 2026
Date: Wed, 26 Aug 2026 17:04:31 -0600
Message-ID: <20260826231519.881949-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0f535b-f38e-4a58-de2e-08df03c7f8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10086099003|18002099003|11063799006|56012099006|5023799004|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 5Vy4sp3VWGOrvkhmM3/pMe9vxasBGtsK743ZEg2mMtPhZxtuPs98declVs1NdVZToHQ4pDc9ZVNhLzvfDYElFXNlSIuRjNgyNhdFXYkvHXHwWCy5mCa40c4ZunxEws7R1ORpgePlqMhjdLDIYWGMNZOzLpYCbiSTfzV+YpIQRuQMFlBjCzYe03pdM1rnH7beOez0So84sn7K5qi8b42zFr4Jah7RzGQIL+nmy54GhQ8kXF5md5dPRzMZDX15w0bP7+o5Gz7chOntzfrx8zSPfoaMGa+D+OlXLi5GQbsTYJJBaCLWpY0EBGILQnNCPotljJiJ+M/vfmYUp1NfvX94ybnQXdK/03+kwAWEc2vdyVRZEusskh6Rbd/I2heN1g6pyxai/kGZ/R5+x2KuIOOtrwg/unbIraCst85rY5/dK2gd1WSm8S33LceL5Sz3DukupD3nRZLmfYNPTAfgZKLMsZekZxR6n4+t2n3UxFnv4nDRHsJrseu/PGd1vWsrWhVzi+RhzdMiGZyi0hyoQq5yGXSE6wOuRZhI7KAXYhJqp5AVNOvv04I2KlkwEX2+gYBDxDDjauINkSKMaK0BQddeofIkP70spQ5sp9CEn7/0uZfp1XhRxpApwTKEvgJ3Is4Rpv2+BXGgP8WUftATi7Vu111vf7pxwnAw8nDMVqRElXrxx3ZYxCsDBt8N8GxfX7kvyp1NTi3kP7b6cmxtwnlfGQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10086099003)(18002099003)(11063799006)(56012099006)(5023799004)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2qL0wF7wfRNp4k/Dr79WzvhUy/+Cc5ETPOPH7JLTxIRU79HkadTIqhdtD2UP9OqJ6sKNHNRPwFRuR+Wfgt7v7wqhzjaHvdaf6+tFU9+vlB7qA/LZWCLv6mxY1axtCxaJufmlbPB5QpBJztHU2yIeNhoYO9G3Nl4Iij2OhT/XOOfFem2Pj6lVPSZmAd8rcgCXhide+Xmq+qEd/jIcG1q4EIIO/y7/zDVzcaKfVVZTo8m9Gb87CJDnOlyDv8H85urKxDJiS6vD+/vuMNw1DZWHdMMon9XSHiW0HkRRbFtfKVz6yOcercXCzFDZYqh04orwlvelVk+Y9R3LYVx9v+TLEJvLEnUJn612Rn8V4oDRyA1BgASA6FIcKDLRR0mbMElTegdnie0jvlU2sZCAH+yPvgybRy7V4O7J4sS07o0VEuJ+3h9mXHJLTxnzHB+8/3f4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:15:51.5584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0f535b-f38e-4a58-de2e-08df03c7f8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Move the DML wrapper into its own component.
* Fix DCN5/6 DML2 compilation warnings.
* Fix DCN60 DPP PRE_GAM offset, HDMI link rate and DSC handling.
* Fix backlight control for luminance-capable OLED.
* Restore native cursor mode early return for disabled CRTCs.
* Fix NULL hubp deref and CalculateFlipSchedule ordering.
* Remove duplicated fixpt and custom float code.
* Drop pipe_ctx param from MPC_VISUAL_CONFIRM.
* Move cursor SDR white level calc out of the hwss executor.
* Set gpuvm min page size to 4K on DCN35/36.
* Update RBBMIF timeout control conditions.
* Guard DAL port idle optimizations by ASIC rev.
* Re-enable multi-dwb support and clean up per-DPM struct.
* Add max_downscale_src_width debugfs for IGT validation.
* Expand amdgpu_dm KUnit coverage.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (34):
  drm/amd/display: Test ISM idle commit
  drm/amd/display: Test ISM idle exit arms
  drm/amd/display: Test ISM delayed workers
  drm/amd/display: Test colorop error paths
  drm/amd/display: Model ASSERT as path terminator
  drm/amd/display: Test backlight caps validation
  drm/amd/display: Skip ACPI backlight caps test
  drm/amd/display: Test vblank counter and scanout position
  drm/amd/display: Test DM atomic private state helpers
  drm/amd/display: Test affected MST DSC CRTC selection
  drm/amd/display: Test cursor commit
  drm/amd/display: Test vblank event arming
  drm/amd/display: Test page flip interrupt state update
  drm/amd/display: Test CRTC memory domain change detection
  drm/amd/display: Test PSR dirty rectangle filling
  drm/amd/display: Test plane reset decision
  drm/amd/display: Test link and sink dump
  drm/amd/display: Test HDCP update
  drm/amd/display: Test global modeset lock acquisition
  drm/amd/display: Test timing sync trigger
  drm/amd/display: Test IP block teardown and link emulation
  drm/amd/display: Test mod_power stream updates on modeset
  drm/amd/display: Test atomic commit setup
  drm/amd/display: Test MMHUB config read
  drm/amd/display: Test power module init
  drm/amd/display: Test vline0 irq control
  drm/amd/display: Test DMCU firmware load
  drm/amd/display: Test SW init and fini
  drm/amd/display: Test DM late init
  drm/amd/display: Test mode and plane init
  drm/amd/display: Test DM early init
  drm/amd/display: Test DC plane info fill
  drm/amd/display: Test DC plane attributes
  drm/amd/display: Test MST VCPI slot calc

Alvin Lee (1):
  drm/amd/display: Fix DPP PRE_GAM register offset on DCN60

Austin Zheng (5):
  drm/amd/display: Preparations To Move DML Wrapper Out Of DML
  drm/amd/display: Clean up Per-DPM Struct
  drm/amd/display: Fix Order Of Operation In Calculate Flip Schedule
  drm/amd/display: Remove const Qualifier From Non-Pointer Fields
  drm/amd/display: Move DML Wrapper into its own Component

Dillon Varone (3):
  drm/amd/display: Guard DAL port idle optimizations by ASIC rev
  drm/amd/display: Re-enable multi-dwb support
  drm/amd/display: Change RBBMIF timeout control conditions

Hansen Dsouza (1):
  drm/amd/display: Add debug bit for force p2cpm

Ivan Lipski (1):
  drm/amd/display: Fix DCN5/6 DML2 compilation warnings

James Lin (1):
  drm/amd/display: Avoid NULL hubp deref for remaining mpcc_id
    assignment

Peichen Huang (1):
  drm/amd/display: Do not use panel_inst in pr

Relja Vojvodic (1):
  drm/amd/display: Update HDMI link rate and DSC handling for DCN60

Roman Li (3):
  drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
  drm/amd/display: Fix backlight control for luminance-capable OLED
  drm/amd/display: Apply debug bit for force p2cpm

Samson Tam (3):
  drm/amd/display: Move custom float structures from opp.h to
    custom_float.h
  drm/amd/display: Remove fixpt and custom float duplicated code
  drm/amd/display: Remove internal references

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.396

Tom Chung (1):
  drm/amd/display: Restore the native cursor mode early return for
    disabled CRTCs

Tomasz Siemek (2):
  drm/amd/display: Move cursor SDR white level calculation out of hwss
    executor
  drm/amd/display: Remove pipe_ctx param from MPC_VISUAL_CONFIRM

Tony Qi (1):
  drm/amd/display: Add max_downscale_src_width debugfs for IGT
    validation

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  187 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   77 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   41 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  110 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   40 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   20 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    8 +
 .../tests/amdgpu_dm_backlight_test.c          |   53 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  232 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  101 +
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |  367 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 3552 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |    3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   75 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |    3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   18 +-
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |    8 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   13 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  106 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |   32 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |    8 +-
 .../dml2_core_dcn5_funcs_mode_programming.c   |    4 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |    5 -
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |    4 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |    4 -
 .../src/dml2_core/dml2_core_shared_types.h    |    4 +-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |    2 +-
 .../drm/amd/display/dc/dml2_wrapper/Makefile  |   61 +
 .../dml21_wrapper}/dml21_translation_helper.c |   15 +-
 .../dml21_wrapper}/dml21_translation_helper.h |    7 +-
 .../dml21_wrapper}/dml21_utils.c              |   11 +-
 .../dml21_wrapper}/dml21_utils.h              |    7 +-
 .../dml21_wrapper}/dml21_wrapper.c            |    2 +-
 .../dml21_wrapper/dml21_wrapper.h             |  107 +
 .../dml21_wrapper}/dml21_wrapper_fpu.c        |   19 +-
 .../dml21_wrapper}/dml21_wrapper_fpu.h        |    7 +-
 .../dml2_dc_resource_mgmt.c                   |   60 +-
 .../dml2_dc_resource_mgmt.h                   |    0
 .../{dml2_0 => dml2_wrapper}/dml2_dc_types.h  |    0
 .../dml2_internal_types.h                     |    2 +-
 .../dml2_mall_phantom.c                       |   70 +-
 .../dml2_mall_phantom.h                       |    0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.c |    2 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.h |    0
 .../dml2_translation_helper.c                 |   21 +-
 .../dml2_translation_helper.h                 |    0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.c  |   28 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.h  |    0
 .../{dml2_0 => dml2_wrapper}/dml2_wrapper.c   |    6 +-
 .../{dml2_0 => dml2_wrapper}/dml2_wrapper.h   |    0
 .../dml2_wrapper_fpu.c                        |   45 +-
 .../dml2_wrapper_fpu.h                        |    0
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |   11 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |    7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    8 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |    4 +-
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |  131 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    6 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.h    |    2 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   26 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |    3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   11 +-
 .../gpu/drm/amd/display/dc/inc/custom_float.h |   21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   14 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +-
 .../drm/amd/display/dc/link/link_detection.c  |    2 +
 .../drm/amd/display/dc/link/link_factory.c    |    2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   36 +-
 .../dc/link/protocols/link_dp_panel_replay.h  |    2 +-
 .../link/protocols/link_edp_panel_control.c   |   47 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   18 +
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    2 +-
 .../dc/resource/dcn60/dcn60_resource.c        |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/Makefile  |    5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  130 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   10 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |   88 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |   24 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   60 +-
 .../amd/display/dc/sspl/spl_custom_float.c    |  152 -
 .../amd/display/dc/sspl/spl_custom_float.h    |   29 -
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |  495 ---
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |  526 ---
 .../drm/amd/display/dc/sspl/spl_namespace.h   |   17 +
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   43 +-
 104 files changed, 5459 insertions(+), 2114 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.h (94%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.h (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper.c (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.h (95%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_internal_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.c (93%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.h (100%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h

-- 
2.43.0

