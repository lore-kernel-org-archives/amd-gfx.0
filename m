Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D836C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C744F10E1AF;
	Fri, 31 Jul 2026 21:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P+ywZg8Z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF2F10E1AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atq/sf5Y4WHAC6pVmq+lO/3AMhICzwp4yes+wYELXr43JGvbqyaxtuq+3ipkgN0+IgR10OMmSKTFcZVwa3/CGvuuGR13vhrCpPB0Yuzh3fOzpqzB7czlNuwaeRcstuWqlC9hGFeFL1uXRfemJEWUZSYhWgUM1r1sZXLEPEms/tKRxd7fN8hI9kKhTMz0edDn4LNAMZ9yjhyAuvsMIRyD+qAzq4RiIG2ZK6BqYdWsdsxRzyo1QED3oUhD5S5pRCLY6kPl4TfECgmw9unoweThCiILR3FuUH3+B9Gv9S2wM/iMfaF9uC2dpxffTjVyt6c5XnyUeSxf4W7BPE06H6feXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YUuvbtmZAwoRVgMBL9tbNT0aLwUtaJCqvzPo5y5adA=;
 b=NAJeH4FEQoz11gtMsoEkoIeXLEQc8QZQNMOsGs8hVtiN0bB35ayb4yXobpryvh2HhgALhxFeZRliiKhZyAe+sUsnN2xrrWtnHuw0lWRlxOle/dJS3j0qiuqa819lHomEJrZm0alKd0fas4kuW+hySzRCNfa4hIaA21ISOblbsz8ns8zW0LGCGlOCUb/oe9o7TveZMZzrQLTeh56/v4yapuu51TsftMX3fy1VeqV2iNkceoN3sA/6G4pgDTxU8RcB38G09h19IoDMn0F2toCW0MDZAUehaemZWJdTtjlIf2mFKENho+H7tRE11NEZaUyxFr//eJqikoCneURNvmPQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YUuvbtmZAwoRVgMBL9tbNT0aLwUtaJCqvzPo5y5adA=;
 b=P+ywZg8Zd2IFp0g33cw3szkdbp+uWZfFrjRwAe6UZusb3C2XNyyCAkwxdpWdiWyld+ZSMNqcbRz7k3S1WNWc2Jww2LBy0sbXN6XFCM2CD/ud5eVt+Yz/1fAZX5mkRTn+w8iPPQJsHnxtAN4/zYdwp3Gml9DlMYFeBcI+fzSru/c=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:14:41 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:14:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:14:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:14:39 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:14:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/41] DC Patches July 31, 2026
Date: Fri, 31 Jul 2026 17:12:21 -0400
Message-ID: <20260731211302.3040343-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: d81bfac7-44fb-4c96-33ca-08deef48bc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: ySrTBmHZTTIMHb3WWTigyNThdmY8XUK5PmqrOher/271oYWatsB+2i7aAt3iQlEXgt8EKCPtlJjENQsreUaA8In9QJrVijBp6fMJE/vsCvTcbvxoHTj/Bo5egRhc2Vid9byRAOkbfVhIdX8oolMkao0/HzZb3uT/QXIgjlEUrE97xLg+eT/rYhgWx0QovuRc5x4c1v7uxyzSEHF7xMniJF2/n7oZ1+C/XB45yG0LUz7NDzR4+dzP6dJRNxFW0sU91Oz0CLtdJDGo1GNBWxq/VA7Ect+xQHIjqP39bFarDxNo4Mdk04qEp1QZDoxji2CeTgOwbw8dvkATqOfaj+5rjy3KWj3u3U3nlM7Zn10bdBZn9/ujGbCkxF2HlAestOO+NaECZRg757f5k7v796sZ/e7h0K9GCi6cknCxQNnrWJMQ1UZ2pwhdRrNIkX3HRTsCkKZW6D0bts0OmxrM0t3ZXXjoKZlhg6IXizPryVUbLEU3q4sP1gaItGK7FHS3Eq1WhyGSCtIaEn7GI00bl4dq26KsAZQV7mv08tpxreAowsDcbv/EA8U9XfbMULR8h+PRJrLHYIgTwN/7JgLDqAcGhyVUbtr18lZz4eZWBMz/mZ7sLdoEUqVhw/Bh5enWEPNCCYDDXmElirED18HFp92yjbj4EywNXxKwFV+WAoOC4FQvsYSnBzpnpZSDH6C6Qw7uo3EMs/Nh4bN5eHY6mgVYpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oQFHHhcEnx+CWEo1uxKFPqkruQWkVgw0PgGSzPOmmk703OI5VuSd//LrwNgwimrMRf3fU4N1I28JHrPlk4+GXKW80Gi2oLByoI5Mhy0ivEN0Y/vx3t3kp/JP6cAdtRWR94pk7gyhigZYKwSZ2tIeccJpgO8Osc34AS8W+zRZzN3S887VOkqQrPs+WZJxEsZUDcGQJpXaiFl2nzOnzCoYVVjD1k0f3JlIOLcPwUff9EAdJuarERP981qQOP7RpCm24cS/7b8PwwLKB7mhuyOblK9jJmUEI70gK+tSv3b9zqblSPzBXJ1P0YpYh5ItV2nblmOSOMhHKbHnPjaPhL41YANjeV9X0d1efCXhgx98joC2zGnYeQUCU9wTocC32YMBJWx3laNudkcfAGC3qXmV8oBVMNucx1x+sRAcIg89s3i8NVxzrS57RcG7gXGGuBcu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:14:40.8112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81bfac7-44fb-4c96-33ca-08deef48bc52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 - Add KUnit tests for crtc functions
 - Enable DCN6
 - Fix ABM, CRC engine, MCM, writeback issues
 - Refactor stream validation.
  
Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Alex Hung (2):
  drm/amd/display: Fix wb_info leak and NULL deref in writeback
  drm/amd/display: Fix more KUnit connector use-after-free bugs

Alvin Lee (1):
  drm/amd/display: Update BW bounding box unconditionally for DCN6

Aurabindo Pillai (5):
  drm/amd: Add DCN6 register headers
  drm/amd/display: Add new sources for DCN6
  drm/amd/display: Enable DCN6 init
  drm/amd/display: Dependent changes for DCN6
  drm/amd/display: Enable DCN6 sources compilation

Bhawanpreet Lakha (12):
  drm/amd/display: Add KUnit tests for more crtc functions
  drm/amd/display: Add vblank handling tests for crtc
  drm/amd/display: Add idle worker tests for crtc
  drm/amd/display: Add active plane count tests for crtc
  drm/amd/display: Add KUnit test for crtc vblank event completion
  drm/amd/display: Add KUnit tests for crtc set_vupdate_irq
  drm/amd/display: Add KUnit tests for crtc set_static_screen_optimze
  drm/amd/display: Add KUnit tests for crtc set_vblank
  drm/amd/display: Cover crtc set_vblank workqueue branch
  drm/amd/display: Cover crtc vblank IPS self-refresh restore
  drm/amd/display: Cover crtc vblank restore replay-supported path
  drm/amd/display: Cover crtc destroy_state stream release

Charlene Liu (1):
  drm/amd/display: Ensure dtbclk is enabled

Fangzhi Zuo (1):
  drm/amd/display: Gate HDMI FRL status polling on active FRL link rate

Harry VanZyllDeJong (1):
  drm/amd/display: Update VRR info packet to support 12-bit refresh
    rates

Harry Wentland (2):
  drm/amd/display: Resize MST HDCP per-connector arrays to 32
  drm/amd/display: Bounds-check connector->index in dm_dp_mst_get_modes

Iswara Nagulendran (1):
  drm/amd/display: Fix ABM over VABC

Ivan Lipski (3):
  drm/amd/display: Refactor stream validation
  drm/amd/display: Unify force_yuv debugfs into force_yuv_pixel_format
  drm/amd/display: Align connector KUnit tests with stream validation
    refactor

Karthi Kandasamy (1):
  drm/amd/display: Fix seamless mode switch not triggering for HDR to
    SDR transition

Matthew Stewart (1):
  drm/amd/display: Add missing DCN42B register defines

Rafal Ostrowski (1):
  drm/amd/display: Migrate color manager HW and fix MCM blend LUT issues

Relja Vojvodic (2):
  drm/amd/display: switch max FFE level cap based on FRL link rate
  drm/amd/display: Add FFE level defaults

Roman Li (1):
  drm/amd/display: Remove duplicate in tests/Makefile

Sung-huai Wang (1):
  drm/amd/display: Increase fclk change latency on dcn351

Taimur Hassan (2):
  drm/amd/display: Add missing DMUB CACP and PR definitions
  drm/amd/display: Promote DC to 3.2.392

Wayne Lin (3):
  drm/amd/display: Add missing OTG_CRC1_SELECT mask for DCN3.2
  drm/amd/display: Fix CRC engine 1 enable/disable on DCN3.1.2+
  drm/amd/display: Configure all CRC engines in pipe CRC source path

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    31 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |     2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |     2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   289 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |     8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |     9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    57 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    10 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |     1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |    10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |     6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |     3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |     9 +-
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |     1 -
 .../tests/amdgpu_dm_connector_test.c          |   163 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  1436 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    29 +
 .../tests/amdgpu_dm_kunit_test_helpers.h      |     3 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    15 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    28 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |     1 +
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |   389 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  1673 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |   150 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  |   369 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h  |    35 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    76 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   428 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    47 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    12 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    27 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    41 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    44 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |    23 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    53 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    32 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |     5 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    13 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |     8 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    10 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |   187 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.h    |   182 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    28 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     9 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |     8 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.h |    16 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |    15 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |    10 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.c     |   373 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.h     |    43 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |   538 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.h   |   181 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |     8 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |     4 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    25 +
 .../dml2_0/dml21/dml21_translation_helper.c   |    57 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   129 +-
 .../dml21/inc/bounding_boxes/dcn5_soc_bb.h    |    36 +
 .../dml21/inc/bounding_boxes/dcn6_soc_bb.h    |   229 +
 .../bounding_boxes/utm_qos_model_dchub_v1.h   |   109 +
 .../bounding_boxes/utm_qos_model_dchub_v2.h   |   122 +
 .../bounding_boxes/utm_qos_model_dchub_v3.h   |    53 +
 .../inc/bounding_boxes/utm_qos_model_types.h  |    51 +
 .../dc/dml2_0/dml21/inc/dml_dmub_cmd.h        |   502 +
 .../dml21/inc/dml_top_display_cfg_types.h     |    10 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |     2 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    45 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c |   152 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h |     9 +
 .../dml21/src/dml2_cga/dml2_cga_factory.c     |    38 +
 .../dml21/src/dml2_cga/dml2_cga_factory.h     |     9 +
 .../dml2_core_calcs_dsc_shared_types.h        |    32 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |     1 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |  5893 ++
 .../dml2_core/dml2_core_dcn5_calcs_dchub.h    |   426 +
 .../dml2_core_dcn5_calcs_display_pipe.c       |  1029 +
 .../dml2_core_dcn5_calcs_display_pipe.h       |   151 +
 .../dml2_core_dcn5_calcs_dsc_latency.c        |   501 +
 .../dml2_core_dcn5_calcs_dsc_latency.h        |    23 +
 .../dml2_core_dcn5_funcs_initialize.c         |    78 +
 .../dml2_core_dcn5_funcs_initialize.h         |    12 +
 .../dml2_core_dcn5_funcs_mode_programming.c   |  1791 +
 .../dml2_core_dcn5_funcs_mode_programming.h   |    11 +
 .../dml2_core_dcn5_funcs_mode_support.c       |  2957 +
 .../dml2_core_dcn5_funcs_mode_support.h       |    11 +
 .../src/dml2_core/dml2_core_dcn6_calcs.c      |    11 +
 .../src/dml2_core/dml2_core_dcn6_calcs.h      |     8 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  1951 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.h    |   101 +
 .../dml2_core_dcn6_funcs_initialize.c         |   165 +
 .../dml2_core_dcn6_funcs_initialize.h         |    12 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |  1389 +
 .../dml2_core_dcn6_funcs_mode_programming.h   |    11 +
 .../dml2_core_dcn6_funcs_mode_support.c       |  4277 ++
 .../dml2_core_dcn6_funcs_mode_support.h       |    11 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |    25 +
 .../src/dml2_core/dml2_core_shared_types.h    |   160 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |     1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c      |   449 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h      |    19 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    12 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |     5 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    57 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c |   522 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h |    21 +
 .../dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c |  2228 +
 .../dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h |    97 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c |   506 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    22 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  1789 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h |    17 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    34 +
 .../alternate_pstate_shared_lib.c             |  1078 +
 .../alternate_pstate_shared_lib.h             |   109 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |     7 +
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.c  |   394 +
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.h  |     9 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |   144 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h    |    11 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   405 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h    |    12 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c |    29 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h |    11 +
 .../src/inc/dml2_internal_shared_types.h      |   485 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |     8 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |    17 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |    41 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |    26 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |     7 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h  |     6 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   391 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |    86 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |   346 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   525 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |   315 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |     7 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   447 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h  |   248 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |    10 +
 .../display/dc/gpio/dcn60/hw_factory_dcn60.c  |   228 +
 .../display/dc/gpio/dcn60/hw_factory_dcn60.h  |    11 +
 .../dc/gpio/dcn60/hw_translate_dcn60.c        |   168 +
 .../dc/gpio/dcn60/hw_translate_dcn60.h        |    13 +
 .../gpu/drm/amd/display/dc/gpio/ddc_regs.h    |    15 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |   302 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.h  |    28 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     4 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |     9 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |     8 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |    47 -
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c |   114 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h |    18 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |   358 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.h  |    32 +
 .../gpu/drm/amd/display/dc/hubbub/Makefile    |     8 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   108 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |  1816 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    |   207 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  |    16 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    29 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   201 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    78 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    10 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   532 +
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.h    |    48 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |   472 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.h    |   272 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |    16 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |     9 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    21 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    21 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |     5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |     8 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   483 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |     1 -
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   488 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |     6 -
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |     2 -
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   759 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.h   |    32 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  1164 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    32 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   181 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.h    |    12 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    19 +-
 .../display/dc/hwss/hw_sequencer_private.h    |     5 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    22 +
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |     7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    35 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |    81 +-
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |     1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |     2 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     9 +
 .../display/dc/irq/dcn60/irq_service_dcn60.c  |   417 +
 .../display/dc/irq/dcn60/irq_service_dcn60.h  |    12 +
 .../drm/amd/display/dc/link/link_detection.c  |    29 +
 .../drm/amd/display/dc/link/link_factory.c    |     5 +
 .../amd/display/dc/link/protocols/link_ddc.c  |     8 +
 .../display/dc/link/protocols/link_hdmi_frl.c |    23 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |     8 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   177 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |   405 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |    55 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |   330 +
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h  |   472 +
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |     8 +
 .../drm/amd/display/dc/opp/dcn60/dcn60_opp.c  |    25 +
 .../drm/amd/display/dc/opp/dcn60/dcn60_opp.h  |    64 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile  |     9 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |    36 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |     3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |     4 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |     1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |     2 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    26 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |     1 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |     9 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |     4 +
 .../amd/display/dc/optc/dcn60/dcn60_optc.c    |   107 +
 .../amd/display/dc/optc/dcn60/dcn60_optc.h    |   178 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |    10 +
 .../dc/resource/dcn10/dcn10_resource.c        |     1 +
 .../dc/resource/dcn20/dcn20_resource.c        |     1 +
 .../dc/resource/dcn201/dcn201_resource.c      |     1 +
 .../dc/resource/dcn21/dcn21_resource.c        |     1 +
 .../dc/resource/dcn30/dcn30_resource.c        |     2 +
 .../dc/resource/dcn301/dcn301_resource.c      |     1 +
 .../dc/resource/dcn302/dcn302_resource.c      |     2 +
 .../dc/resource/dcn303/dcn303_resource.c      |     2 +
 .../dc/resource/dcn31/dcn31_resource.c        |     1 +
 .../dc/resource/dcn314/dcn314_resource.c      |     2 +
 .../dc/resource/dcn315/dcn315_resource.c      |     6 +-
 .../dc/resource/dcn316/dcn316_resource.c      |     5 +-
 .../dc/resource/dcn32/dcn32_resource.c        |     2 +
 .../dc/resource/dcn321/dcn321_resource.c      |     2 +
 .../dc/resource/dcn35/dcn35_resource.c        |     2 +
 .../dc/resource/dcn351/dcn351_resource.c      |     2 +
 .../dc/resource/dcn36/dcn36_resource.c        |     2 +
 .../dc/resource/dcn401/dcn401_resource.c      |    34 +-
 .../dc/resource/dcn401/dcn401_resource.h      |     4 +
 .../dc/resource/dcn42/dcn42_resource.c        |     3 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |    20 +-
 .../dc/resource/dcn60/dcn60_resource.c        |  2377 +
 .../dc/resource/dcn60/dcn60_resource.h        |   676 +
 .../display/dc/soc_and_ip_translator/Makefile |     3 +
 .../dcn60/dcn60_soc_and_ip_translator.c       |   117 +
 .../dcn60/dcn60_soc_and_ip_translator.h       |    16 +
 .../soc_and_ip_translator.c                   |     4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   229 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |   732 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |   303 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    52 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |    18 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../amd/display/modules/freesync/freesync.c   |     8 +-
 .../drm/amd/display/modules/power/power_abm.c |   215 +-
 .../amd/display/modules/power/power_helpers.h |     9 +
 .../drm/amd/display/modules/power/power_psr.c |     7 +
 .../amd/display/modules/power/power_replay.c  |     7 +
 .../include/asic_reg/dcn/dcn_6_0_0_offset.h   | 15799 +++++
 .../include/asic_reg/dcn/dcn_6_0_0_sh_mask.h  | 58556 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_6_0_0_offset.h |    47 +
 .../asic_reg/dpcs/dpcs_6_0_0_sh_mask.h        |    55 +
 .../asic_reg/mmhub/mmhub_5_0_1_offset.h       |    17 +
 .../asic_reg/mmhub/mmhub_5_0_1_sh_mask.h      |    17 +
 286 files changed, 129427 insertions(+), 1800 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn5_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_dmub_cmd.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_calcs_dsc_shared_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dsc_latency.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h

-- 
2.34.1

