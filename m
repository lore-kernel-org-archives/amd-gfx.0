Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFBBC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5319F10EB04;
	Tue,  8 Sep 2026 11:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sScEZs2o";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC78010EB04
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB+qprDdl/DH5XmhP9/PE12YwuZuHm4KX40TOocV4DFXrk8QFDPDET6U67X1pc5jg/j7CJ0XTkXWWmcsibusjZ1u3AGjm2QWj8oTg5Y+NJbRNcBNFd/3M5z+Wid0il0BRF837TwqeFrwI9s2/PDpqV8FCiEAG0IhmlN11RTjXXW18l9OH1gUidYqbN/N2uwBLIAnvEdD2Ql0A94WvsIvmv0Q73LDpL/ccf1UhJZcwHfGjmqzO8h6LnhppaIrlIHmN/G+ng7z+syPZ9keHkgRI4D4JmrtZWUwLP6LzzCu7TACyImXmxSbM8Ab5ZtdNfnTv33shnR8lMs7ljnuTl5e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWuKe9r0c0AFlWDXZDby+GFiqfx656/lP7dp6zBqvms=;
 b=r87eTgUnDPRl0iIt3itBKlDGhU/QJqlXxFIWJYGw/h46L6ADcHEaIMZ/Sg9IrUiUQe+baUUicdjr1ZwV1Es+Cwgsf6yaIzCRWr8KccLlPSpERmlMlq61Uu6rMHi3KuZOrW/68CfQuzc0mUQmHe5NUnauOXIO5lmu3pWzFwl/Lb/zwymP7Cxeg3cW0kHBu7o9ajoy7ANK9yZ7kTqBdcL8xLFOk3pJOTwBpjx8/VGU9uQX8wOevNoLlQPmVcmdE0Z+POqM7oGSRWuIXSzfhxqrtyo0WJ2SCqvBo7ot1y/8Uj0KmzjWDHho85ghExWzJZyNLz8O7TI2Ltj4GUkGO9V3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWuKe9r0c0AFlWDXZDby+GFiqfx656/lP7dp6zBqvms=;
 b=sScEZs2ov7koMZdppXToHNaWdXiY7axrISNlWcsm8v4Dq+Pod3szMngJcaR0IfPhSLPAr6+unt1pGg95Ufe6D9mUEjVsFoQ0WFDumt3FNBB/NDPgLiEPswgsh/9bsZOQS6MavvOknNXCQ3dg3SLkW9iFgd1pFS2PPPfdqgA9yeg=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:33:45 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::7e) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:33:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:33:44 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:33:35 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 00/66] DC Patches Sep 14 2026
Date: Tue, 8 Sep 2026 19:30:53 +0800
Message-ID: <20260908113338.2433445-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 92af9cdb-0c53-46c2-a6bf-08df0d9d0b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|30052699003|82310400026|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0eFn9YcUoVgkutvFYVElKl5xUy/42QYKCedgmmlF6+NpMpULMATGGC2XWnzM88mCu7Y0zlUcsSqMfW6ZMt4xIA0gJc1Gmpz1sNVjM9zOpxxmafQhAcOK3a5rjfmKQO5KVWabSO2qMT5xsS2Cv3COoWFLTZ7rPPootzKcF6EJV89kU+JB+odDZUEbQde7pEiW8JiuXuTvp4ZurlGQLvYet4GkPWT0sQCUMBP0jKJMo5PPvIILZ58FYq9FCPFXiW9WWli8JNxygcvZ1dLuPs9eKshivypQVRb91/um3lJn/2J7GfpBfRVBHA0bE/DrW/DK5pwc01yeusGywzl3BlRnBuEAI4KAxutd1oUY3xtm7RZkmk50bYBGSOlzkRXH5YVHJfuY7C9dLmHoQecJa9mnQgHlS4FJf0ozG5RuE+CsZCQ/jSckVEguFKFs4jo5TyZns4gl+hR/iMWicpviBcbJrNVXuC0acyCrzufOWxGLX6CdHJ9WznmFQJk0PjUqKFZG2x2mAzK07MKH27Av/5ZAU2fivPb4FzgWFJpmdqC4sKn8F+blBN06loSpMDN6rmdWHbfXKOppPScNJ0x55WGMHknnWIpvKHN7rsgFc69xlMQAF0yo8s7BDR9NoXv7ajCW8ZidrJ08eHO3LV/T6YNenjrA52v3ucUKx8zrNfDGtjIVqOhupFLKH8+xGu9Hc9mG9NPfB3hwabunxPXlE+Feig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(30052699003)(82310400026)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 21KYCFde2p6TQKX4SK8AlzGG6t5BuO9CJOHDyUsaCTWUjC6hlCra+H93K4GRljw+qAnZWQ8F0Gcbmve0sg2q4lGhkdMMtcADCsgDXVmTCBTTuU1r1Th7BLqovJTMePM3VZoAwuZH1v+q7YOJnEPdnhW77D2bR+UvUpElmtV6F6dykgqQTrAQJjVi9hxBcG7a3/MdBvrF7BY5K/5Zm5hvHIfSsVwID1UFbQspAV07eXGYMWudN8BcT2Q+hMJR17Z6kVa8orWJYUuRz3eX1M0gABJFz4cav1Q8knz5MZhk16LUNuY/ZnOdzu5uYar2O1mlumdRt16Non69OmlM4ZXpwi82H87Mgx+kQQqs4Aasp5KhgjV48jYi5fuGc7Bz0oMSMgQ8LakKtAD4fzDqESKVcpPJek6/xCccKq3kwomCIU9tMw09Pkt42X2ciBs0UAeE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:33:45.5052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92af9cdb-0c53-46c2-a6bf-08df0d9d0b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

 - Expand amdgpu_dm KUnit coverage across connector init, sink stream
   creation, FreeSync caps, forced atomic commit, plane modifiers, cursor
   updates, panic flush, MST connector creation, AUX transfers, link
   bandwidth readback and MST DSC configuration.
 - Refactor RMCM into a separate module.
 - Decouple cursor offload hwss executors from pipe context.
 - Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx.
 - Rename lock_and_validation_needed to needs_dc_state_realloc.
 - Drop the dead update_type param from update_planes_and_stream_adapter.
 - Attach only plane updates and stream updates that actually changed.
 - Unify fast update classification paths.
 - Request DMUB HW cursor offload.
 - Program DCC as part of address update.
 - Update LLS and UPSP programming paths.
 - Add lock-free memory pool.
 - Add instance field to struct mpc and struct dccg.
 - Cleanup DMUB command submission interfaces.
 - Add inbox0 HW lock helpers for DCN35.
 - Atomize IRQ register read/modify/write ops.
 - Add Replay cumulative residency query.
 - Add urgent assertion counter probe.
 - Add debug option to force optional UCLK support.
 - Force DSC to 8bpp for SST and MST DP tunneling over USB4.
 - Honor forced RGB pixel encoding.
 - Add option for certain panels to disable FEC.
 - Cap DML2.1 vmin ODM combine at 2:1 for eDP.
 - Add is_odm_enabled callback to skip init_odm on active ODM pipes.
 - Remove MALL capabilities from DCN42B.
 - Skip MALL calculations when there is no MALL.
 - Enable power gating on dcn42b.
 - Remove SDPIF_PORT_CONTROL programming for DCN31/35/42.
 - Enable back alt-ch.
 - Flush ISM work before releasing the stream.
 - Fix HDMI FRL audio enable.
 - Fix peak bandwidth measurement sequence.
 - Bound the DSC power gating loop by num_dsc.
 - Cast DP DTO pixel clock math to avoid overflow and narrowing.
 - Use unsigned types for FRL cap check params and HPO read_state.
 - Return success status from check_mode_supported.
 - Add SPDX license identifier to dcn30_dpp_cm.c.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (25):
  drm/amd/display: Test sink stream creation
  drm/amd/display: Test connector init helper
  drm/amd/display: Test HDMI connector init
  drm/amd/display: Test FreeSync caps update
  drm/amd/display: Test connector init
  drm/amd/display: Test forced atomic commit
  drm/amd/display: Test DCC reject for multi-plane format
  drm/amd/display: Test modifier list growth failure
  drm/amd/display: Test pre-GFX9 plane buffer attributes
  drm/amd/display: Test accepted plane atomic check
  drm/amd/display: Test cursor update without DC stream
  drm/amd/display: Test panic flush DCC teardown
  drm/amd/display: Test optional plane property creation
  drm/amd/display: Build MST DSC helpers for KUnit
  drm/amd/display: Test oversized AUX transfer
  drm/amd/display: Test MST connector creation
  drm/amd/display: Test link bandwidth readback
  drm/amd/display: Test cascaded Panamera check
  drm/amd/display: Test DSC caps validation
  drm/amd/display: Test MST port mode support
  drm/amd/display: Test FRL bandwidth lookup
  drm/amd/display: Test DSC precompute helpers
  drm/amd/display: Test DSC recompute check
  drm/amd/display: Test DSC config computation
  drm/amd/display: Test per-link DSC configs

Alvin Lee (5):
  drm/amd/display: Update LLS and UPSP programming paths
  drm/amd/display: Add debug option to force optional UCLK support
  drm/amd/display: Enable back alt-ch
  drm/amd/display: Program DCC as part of address update
  drm/amd/display: Return success status from check_mode_supported

Chenyu Chen (1):
  drm/amd/display: Use unsigned types for FRL cap check params and HPO
    read_state

Dillon Varone (1):
  drm/amd/display: Cleanup DMUB command submission interfaces

Dominik Kaszewski (1):
  drm/amd/display: Add lock-free memory pool

Fangzhi Zuo (2):
  drm/amd/display: Force DSC to 8bpp for MST DP tunneling over USB4
  drm/amd/display: Force DSC to 8bpp for SST DP tunneling over USB4

Gabe Teeger (4):
  drm/amd/display: Enable power gating on dcn42b
  drm/amd/display: Bound DSC power gating loop by num_dsc
  drm/amd/display: Remove MALL capabilities from DCN42B
  drm/amd/display: Remove MALL capabilities from DCN42B bounding box

Ilya Bakoulin (1):
  drm/amd/display: Fix HDMI FRL audio enable

Ivan Lipski (1):
  drm/amd/display: Honor forced RGB pixel encoding

James Lin (6):
  drm/amd/display: Rename lock_and_validation_needed to
    needs_dc_state_realloc
  drm/amd/display: Attach only plane updates that actually changed
  drm/amd/display: Request DMUB HW cursor offload
  drm/amd/display: Send stream_update to DC only when it changed
  drm/amd/display: Drop dead update_type param from
    update_planes_and_stream_adapter
  drm/amd/display: Cast DP DTO pixel clock math to avoid overflow and
    narrowing

Leo Chen (1):
  drm/amd/display: Cap DML2.1 vmin ODM combine at 2:1 for eDP

Leo Li (1):
  drm/amd/display: Atomize IRQ register read/modify/write ops

Ovidiu Bunea (2):
  drm/amd/display: Remove SDPIF_PORT_CONTROL programming for DCN31/35/42
  drm/amd/display: Add condition to skip MALL calculations if there is
    no MALL

Rafal Ostrowski (2):
  drm/amd/display: Refactor RMCM into a separate module
  drm/amd/display: Unify fast update classification paths

Ray Wu (1):
  drm/amd/display: Flush ISM work before releasing the stream

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.398

Tom Chung (1):
  drm/amd/display: Add inbox0 HW lock helpers for DCN35

Tomasz Siemek (2):
  drm/amd/display: Decouple cursor offload hwss executors from pipe
    context
  drm/amd/display: Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx

Tony Cheng (3):
  drm/amd/display: Add instance field to struct mpc
  drm/amd/display: Add instance field to struct dccg
  drm/amd/display: Add SPDX license identifier to dcn30_dpp_cm.c

Wang, Sung-huai (1):
  drm/amd/display: Add is_odm_enabled callback to skip init_odm on
    active ODM pipes

Wei-Guang Li (1):
  drm/amd/display: Add Replay cumulative residency query

Wenjing Liu (2):
  drm/amd/display: Add urgent assertion counter probe
  drm/amd/display: Fix peak bandwidth measurement sequence

Yi-Ling Chen (1):
  drm/amd/display: Add option for certain panels to disable FEC

 drivers/gpu/drm/amd/display/Makefile          |    1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  113 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   27 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   19 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   64 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   28 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   21 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   61 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   19 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   33 +
 .../tests/amdgpu_dm_connector_test.c          | 1345 +++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   16 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |    8 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   34 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |   83 +-
 .../tests/amdgpu_dm_mst_types_test.c          | 2041 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  357 ++-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  254 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  246 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  147 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  124 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   48 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   50 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   12 +-
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   |  277 +++
 .../gpu/drm/amd/display/dc/dc_memory_pool.h   |  107 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   14 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn201/dcn201_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |    2 +
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |    1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    6 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   25 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |    2 +
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   11 +-
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.c  |    2 +-
 .../dml21_wrapper/dml21_translation_helper.c  |    1 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    2 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   20 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |    3 +-
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  |    6 +-
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |    9 +-
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |    9 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    5 -
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    7 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   13 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   44 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    9 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    3 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    6 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   28 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.h    |    3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  108 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   40 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    1 +
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   27 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |    2 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   43 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  117 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   14 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   39 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  283 ++-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   17 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    6 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   10 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  194 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    5 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    8 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   70 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   65 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h  |  140 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   18 +-
 .../drm/amd/display/dc/link/link_factory.c    |    1 +
 .../link/protocols/link_edp_panel_control.c   |   22 +
 .../link/protocols/link_edp_panel_control.h   |    2 +
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |    1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |    1 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |  680 +-----
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  714 +-----
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |   41 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h  |  238 --
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   10 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |    1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    1 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |    1 +
 drivers/gpu/drm/amd/display/dc/os_types.h     |    1 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |    4 +
 .../dc/resource/dcn42/dcn42_resource.c        |   56 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |  123 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   20 +-
 drivers/gpu/drm/amd/display/dc/rmcm/Makefile  |   44 +
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.c    |  867 +++++++
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.h    |  717 ++++++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.c    |  251 ++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.h    |   35 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    7 +-
 .../drm/amd/display/modules/inc/mod_power.h   |    3 +
 .../amd/display/modules/power/power_replay.c  |   13 +
 148 files changed, 8132 insertions(+), 2808 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h

-- 
2.43.0

