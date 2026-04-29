Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49B9FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F59510E0C2;
	Wed, 29 Apr 2026 01:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cNG3lHuq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAEF10E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVTSi6zJTd/lGt9lP1sSnpbum79dpeqJw4SQgEm+Eem97QXCU+f1V3s+vzP7315on3VQYxxjC7mkijSyLvHXYRjZcgfOYV0QZqsQhbvLGQ1tzqMgLlBrtM6Rq2KE6H6JBrH9InIFI9BHTCq7140F4U9RLO2cOhbjXC4GvhJqJi6mO/ROYwS5mF8SLg0D9OMpb4wsDX6d6EzPh0FcKV1KNly6pYseT7FSRMsBU9T1rgWdD5h1Kwu1MFJ2GbRXyBb3fIsvrdlc2Z2WRmFwKkuiaVUvzlS21L1TWRmrlZaMCF/GceDXkJaS3Z92wL0h7umvTGRT61yjfrsyvtpgZqj9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/3eB0sJpRcEbRQn7X4V7xnoM7ws1usMggHuqKbL8j4=;
 b=pirTNYGnQ3BmQBv2G87jP/zv6tWwVtxMYESDB4576ZSiPjUoRLEQ/ikTtHDVFwSa2xuypDfTapjgyqCq3phAIOHTyOrtK4lff81VP8Nyvp21mxqC1ZWn3c5ylvr/ONB++l8buORhKVxg5bSaBjirg6bbkjEwiAf96clrQLBY7MXTrxqXTnbEJFoD8zGtnDpY4BVQJelAk23Zqn6vb6PCc/oloJ7jp4H/0eybfx/Yih63x32sGBPYQbMklyHtMVeJPT4iWnenDJaT1l+soSzW7BjinU+pVsOjh57/SwTaYhKjT++RoK2R5Tkt6P9AQR3JdjL7NViBpaJBLRSXURXL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/3eB0sJpRcEbRQn7X4V7xnoM7ws1usMggHuqKbL8j4=;
 b=cNG3lHuqSHADGYTQsCI/f6Jc0EWalPBjsyv06ZY6B/jpWqyjD4a0r0JBHs6kU+wz2MKNuSPibVjOgHUqoQ/K6ysT9AwCrBJ7UJCpDh69DKwCoSU617vo2DKLk5NtptdNAGV41Xna/JenR2KpXHE52sbKB8SHTXuq9IeeH6PGwCs=
Received: from BL1PR13CA0076.namprd13.prod.outlook.com (2603:10b6:208:2b8::21)
 by SA6PR12MB999201.namprd12.prod.outlook.com (2603:10b6:806:450::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 01:51:51 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ed) by BL1PR13CA0076.outlook.office365.com
 (2603:10b6:208:2b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 01:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:51:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:51:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:51:50 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:51:47 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/17] DC Patches May 4 2026
Date: Wed, 29 Apr 2026 09:19:09 +0800
Message-ID: <20260429012055.2065869-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SA6PR12MB999201:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bf0ad0-b0fe-44fa-d5fd-08dea591e1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vhgWVSxK98srQx54sDL7n4UrOrUAzI7DV6ZGgLaFTnt1MJIR6+BVJT0jJeJTjoidQpXvB0VkSzKuwj7gRZNPx4WRiOQjgdDuAbdbJOqsOWkBx/sSezhEq7/eAwNTjHN8tI6A2eORCT6jwC153IZhLmR3SlGnn9qwlAfqUskYDCV6lAGgMtGusRUskBf/sQfDdwGqqL+/ZO0RHqNm1h903cygxu3l2YBZvuYSi/Fq5puhml19dkdMQHpKwRKzhQcWhW2y8W4N1/R7IOX92/YlmLOiGLfWgAv4JblsAhTYzSrB42mW6seK8eB0XWylizHfA9YBJRmZ2VDCs4wYCygpHkcexBhRShQW5g4NFk40j6OdOgaxVPOLO9GxqzmPL/NGK+7NJwyQtENfGLNZprkVmO372HyxborRDS5245G5cppzGLrG0QM+tHzk0CqvBFN86CyoAwEjOQa01ukYfEATX1yYDlGX+tcoonxjxmVO/VL7gcHTNkcqlMfnZnZcWUrndVGQ5ZicC3S3GlXqD3rYeV17h8kKKBhTGV/ZQjLWKpX4pR8fM6CT5Inxf6eQ5/mSF4YAaOEk8BeLrO7bDUSlzivLQV4b3idm+yVNpXvMWO96Buv5b6KEsA9M3swPipe7i70fsCwG/pKH5VydI70aacIpTlMcj4d54hIOObBjpemCb2eogO5vozqJy43OEl6tioaDzhbVTgjV30SK2M0lB8z8f/qhNPgaWYj+ZmlBSlQXgpobqlzpt74A0ziZASQNIglAut+kaow/TE/xkpaAew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oCM+c/sdyZ6vHTspajI3/7Gf4NEp7M42jc0PAQYmv0Dq3OirfhKafdxDHvNA/dpzR2AeeSrWqUf4ptH2jOs03+xXuIjmHPHBAg6gAWQZa4fQaXlg5Fp2Q8Jn7g/iLO1BjfbfTIw8YUVorIiyGLJvr+BVqIuoo+RoKXrqlb35AE65FONO48I8ksUgn6Lx+xffjFiwhOorr+Bzxi8CppjEZdDNf/qVpgOjpxhxlf9TiQuQo9iVdB1YPcZrRjqXybC/5BKDzmngi2s1HzAc1A9rX1qwKDYeST1fz0t2JZuRMmPjeA3b8RNWf/7vfmBxZwkPavD+MVumHTR82AcP5BecMZIIPluYV7LV7u4nSyf4hXmILYbP0wht/clhv9DYHqFVwrEGVk+DxR+m/mK/pOYRaIsd1gDM5/oA13mYh2RCLyoLs3bMn9J9WlsEaXFs1Zc1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:51:51.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bf0ad0-b0fe-44fa-d5fd-08dea591e1e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999201
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

Start from:
3bba7c80f8576f0cf68753abe25c1ca2a0f17018
SWDEV-553782 - test/diags: tcd-tts mapping - keyword search (#28664)

Stopped at:
6ee9f5160ad6e0bf672329f7680398e718fc56f5
SWDEV-114487 - modules: [BACKPORT] drm/amd/display: Fix divide by zero in calc_psr_num_static_frames

This version brings along following update:
-add max bandwidth budget to QoS interface -Update tmz field for LSDMA -fix buffer overruns warnings -add memory bandwidth override debug interface -Find link encoder for flexible DIG mapping cases -Fix type mismatches using guards and explicit casts -Fix type mismatches in DC and DMUB modules -Skip HDR metadata update when Smart Power OLED enabled -Rename backlight_properties to pwr_backlight_properties -remove watermark range notify -Clean Up Legacy DML Content -Implement block sequencing infrastructure for modular hardware operations. -Do DML float narrowing explicit -Fix type mismatches in DML and normalize loop bounds -Remove unused state param from enable_link_analog -Fix Color Manager (3DLUT, Shaper, Blend)

Alex Hung (1):
  drm/amd/display: Remove unused state param from enable_link_analog

Alvin Lee (1):
  drm/amd/display: Update tmz field for LSDMA

Bhuvanachandra Pinninti (1):
  drm/amd/display: Implement block sequencing infrastructure for modular
    hardware operations.

Charlene Liu (1):
  drm/amd/display: remove watermark range notify

Dillon Varone (1):
  drm/amd/display: Fix Color Manager (3DLUT, Shaper, Blend)

Gaghik Khachatrian (5):
  drm/amd/display: Fix type mismatches in DML and normalize loop bounds
  drm/amd/display: Do DML float narrowing explicit
  drm/amd/display: Fix type mismatches in DC and DMUB modules
  drm/amd/display: Fix type mismatches using guards and explicit casts
  drm/amd/display: fix buffer overruns warnings

Ian Chen (1):
  drm/amd/display: Skip HDR metadata update when Smart Power OLED
    enabled

Ovidiu Bunea (1):
  drm/amd/display: Find link encoder for flexible DIG mapping cases

Ray Wu (1):
  drm/amd/display: Rename backlight_properties to
    pwr_backlight_properties

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.381

Wenjing Liu (2):
  drm/amd/display: add memory bandwidth override debug interface
  drm/amd/display: add max bandwidth budget to QoS interface

Zheng, Austin (1):
  drm/amd/display: Clean Up Legacy DML Content

 .../drm/amd/display/dc/basics/conversion.c    |   2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   6 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  11 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  30 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  17 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  30 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  41 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  55 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  53 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  43 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  21 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 111 +--
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  19 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  26 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 643 +++++++++++++++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 597 ++++++++++++++--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  67 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  74 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 -
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   3 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  12 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  22 +-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   2 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   8 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  11 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |   6 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  34 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  36 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  36 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  36 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  14 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  83 +--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   5 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   2 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  15 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        | 121 ++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      | 129 ++--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  75 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  21 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   2 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  46 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   5 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   5 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   4 +-
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  18 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |   2 +-
 .../dml21/src/dml2_top/dml2_top_legacy.h      |   9 -
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  13 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   2 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   3 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   3 +-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   2 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   7 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   5 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++----
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  78 +--
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  10 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  38 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  55 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  34 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  15 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  68 +-
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 432 ++++++++----
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 520 ++++++++++++--
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   9 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 353 ++++++++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  35 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  79 +--
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../display/dc/inc/soc_and_ip_translator.h    |  19 +-
 .../drm/amd/display/dc/link/link_detection.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +-
 .../drm/amd/display/dc/link/link_validation.c |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |   4 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   2 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   4 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++--
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 388 ++++++++++-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  49 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   2 +-
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |   6 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   1 -
 .../dcn42/dcn42_soc_and_ip_translator.c       |   6 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   2 +-
 .../amd/display/modules/color/color_gamma.c   |  12 +-
 .../gpu/drm/amd/display/modules/power/power.c |  28 +-
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   6 +-
 121 files changed, 3870 insertions(+), 1702 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.h

-- 
2.43.0

