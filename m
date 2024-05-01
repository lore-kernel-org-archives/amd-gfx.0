Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D0C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45B7112908;
	Wed,  1 May 2024 07:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAAY0VA6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB7D112908
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av6ESThBLsdq++C8c8+CrSVt8NJUT97Gj6G0MjUjEfvzd9CwZnt+7NPB/DbUSvoWFNWKMtDxoDobix3anwA2CSqMtABIy5d60v3wdoT6470zFOwJsNQYI8eoCuv9c0Q97lFyHiWV5Quvk9xcWvc6nZsuejTQ0esXQYGheMwQ9xnuyVsEIc36UsZcAjRf9qGmPHXvDV5netpSQN5+7WPE+zLPULRAwz2m9DNRwoUgAgvNCfMuyK7sIYVMD0HMusby7JoIrKPjcKjezUFIdwfxyBdc8DVN//NvOsletrqE0FbTueOE6URlvPmilJq32s98tXx9GFrGLczqh4x44KAVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLPJNvEp34RA/6xFJubFbr4osUu1YqDslbvyfLITB34=;
 b=K23fZ9O/uEO4W84rbXakaDy++M4SW8xfBjSF0Z//3R0IRXBmI1IKNkKKNiRoXDk+z1a0W116ge3+0Lnr+0zh1V8d0VYlX8AUNLvyTRT4q0qGdXUB3reMu2+K7uvhH5DBhQxMqxs9GxgPsE8fIM25Gbl2scQ8PVireEFIbDHo5l/3xYTY26MzlFCcnj2+LVih1QnrUcooQbrmPT74e1vZzDq1N/9ovFt7pgcUnjTv6hTNNQGFGqLCyFC+ZAeIevUdTMpmpVNAXuh19ua5JA7BxO6obu4EvshTFsl2uBzYuh5ctAkzGJNRjGGplMxyhu0jeqs4hH/9OI9VfVMrqdoMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLPJNvEp34RA/6xFJubFbr4osUu1YqDslbvyfLITB34=;
 b=LAAY0VA6d3ixYz//kLlL0Y5sfWdAP8yTqbQJQhK2dsBMcekmqVwFR0v+XxDk/11fKwRDwCfpRwNYdMSRyegKlKR+7+D18uOxj07CgblzinUBYAUjiNsR1hMLDCmjdgb/YGvo9XsAaLpwKuk5o4GlhKORjpkUvbYFqujCWmEwq1g=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:16:58 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::58) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:16:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:16:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:16:56 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:16:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/45] DC Patches May 06 2024
Date: Wed, 1 May 2024 15:16:06 +0800
Message-ID: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2cd79a-5acf-4283-0821-08dc69aeb011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElEg5jT3G5ps06bKF5CA/7f5OnWdM4Utnche4P+YvwcDsirrydmB7ers9y2p?=
 =?us-ascii?Q?R5qPSSkFiqN4QyydHCjBr0duH+TJXObLjqmT4wBmE/8nDWF2fhWVJ3pLr3Ux?=
 =?us-ascii?Q?2o+9LZAfjHewpWIjEkbr1l4qAYHabWDvMLddWhS9a7Of9afnhtHVPOraqVFm?=
 =?us-ascii?Q?QQy4w/0TLUYjNKevH6RRVxCKf7hqSFtRBfvJ19CqXiX5S7QRPidjPyuOdAnD?=
 =?us-ascii?Q?nsXhG+9E0nn5hdKK/20U4KynCZVCURlBtDzy96Pz9w5arj+Tcl+DqeeaBBzr?=
 =?us-ascii?Q?ELSuIjJo2fuMqd28l9DE+602Tj3F/4PnQvSdP1KLI9ZgOLWkL7CucuEeH2b+?=
 =?us-ascii?Q?YpAH008omu61ZASV0pPBx/pViWWEwQlOSy9luLitiVLl4cZkbV+Tr8NQySBJ?=
 =?us-ascii?Q?MInrUtNo5cIaVBHOjOrMV2FirlbpfTHCw/WqzIfhqbHwLA6TtO1hLP8tD7Iy?=
 =?us-ascii?Q?blUbEkQWoHgHbTem3Nma99Ka1AzEZPGA/IklVhbV/mJOjdrn/vrVGJKlKntP?=
 =?us-ascii?Q?172UOAoA0nffM8TM22MEmbOxBdmE4MHn7xwK1J8x4DsJmJ8WzGIw3Vulmxd9?=
 =?us-ascii?Q?XxKTvMRk0x511fFAqKq3MdIX+UHCmBkuKFxbi1T5Fnbmibi9cNCl4A22Omw/?=
 =?us-ascii?Q?h4/rAzMwAIOCU4p1VkQHXuU3A/T2yYitNAviVwQiGlJxeDehpkPjJj/iEyK7?=
 =?us-ascii?Q?oLncg1Jji/Ceu62+hrzGN0mBfcoRfKuhI9bmvEHq+ULWaxPDfCoX9KpjTv8K?=
 =?us-ascii?Q?avcPU1PFDxTNwkOAyrLYZ+gZN8gjwdqZMRiAzZGN8kzEJRXFnz9OYTaogCh0?=
 =?us-ascii?Q?oROxRPcR+ic7YDj4JNfVXWPwWVmhwP6CuGaTq1jtyur6Jj3HGWdpwwPJuuOY?=
 =?us-ascii?Q?VWR6k0+VXCtW3N62TJmyAHo4BMx90XveteJaP1SjagDzQgvNEv/mE70JcHVx?=
 =?us-ascii?Q?Z8DOvQ7IPA2VDlp/GnvW0Kxq4zVVe5qiPfWPai4d0oaPbu3TsVhCKmQmKCIZ?=
 =?us-ascii?Q?H5aFbJKoS6jEwwPAiDAIu9suikw66S1xsHRSesCClJhQS0d6Dt0eTTYpuNqC?=
 =?us-ascii?Q?/yB5RSCUJ2xOCZXDChQajYTrxx4FxpwqINtgk0sRtOKMqMzxX50+VZSxCiTb?=
 =?us-ascii?Q?25oo+nF4LjcRG4sbGA8aChQSPQSveylqkd8z9707LQu0Wm0MdcmKEUYvs1UK?=
 =?us-ascii?Q?wSzFyKZC38kEBrp103R42nlElvK37vHx0tFRp7wf6pVm+bJGEsJCAj2n0neZ?=
 =?us-ascii?Q?dYOY33corb82G/7MRK5MW+D9cSPRA082Mt6zk5HxfL9ehsGrqcYZPYQpWe4t?=
 =?us-ascii?Q?LmtnDnBIsCyJMgr5poow1yYosYYOP+DyzZNWeqLWL2Tz3jMpB7C0rlE3A9+o?=
 =?us-ascii?Q?X+J37doL04A+h7G9BbitDg49sMB3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:16:57.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2cd79a-5acf-4283-0821-08dc69aeb011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

- Fix some problems reported by Coverity
- Fix idle optimization checks for multi-display and dual eDP
- Fix incorrect size calculation for loop
- Fix DSC-re-computing
- Add Replay capability and state in debugfs
- Refactor DCCG into component folder
- Refactor input mode programming for DIG FIFO
- Reset DSC clock in post unlock update
- Clean-up recout calculation for visual confirm
- Enable urgent latency adjustments for DCN35

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Agustin Gutierrez (2):
  drm/amd/display: Fix DSC-re-computing
  drm/amd/display: MST DSC check for older devices

Alex Hung (14):
  drm/amd/display: Skip accessing array for unknown eng_id
  drm/amd/display: Ensure array index tg_inst won't be -1
  drm/amd/display: Check gpio_id before used as array index
  drm/amd/display: Fix incorrect size calculation for loop
  drm/amd/display: Check index for aux_rd_interval before using
  drm/amd/display: Check num_valid_sets before accessing
    reader_wm_sets[]
  drm/amd/display: Skip updating link encoder for unknown eng_id
  drm/amd/display: Check msg_id before processing transcation
  drm/amd/display: Check link_index before accessing dc->links[]
  drm/amd/display: Limit clock assignments by size of clk tables
  drm/amd/display: Spinlock before reading event
  drm/amd/display: Limit array index according to architecture
  drm/amd/display: Avoid overflow dc_clk_table->entries by limit to
    MAX_NUM_DPM_LVL
  drm/amd/display: Skip plane when not found by stream id

Alvin Lee (1):
  Revert "drm/amd/display: Only program P-State force if pipe config
    changed"

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.216.0

Aric Cyr (1):
  drm/amd/display: 3.2.284

Bhuvana Chandra Pinninti (1):
  drm/amd/display: Refactor HUBP into component folder.

Dillon Varone (2):
  drm/amd/display: Refactor input mode programming for DIG FIFO
  drm/amd/display: Reset input mode for DIG on encoder reset

Hersen Wu (13):
  drm/amd/display: Add NULL pointer and OVERRUN check within amdgpu_dm
    irq register
  drm/amd/display: Stop amdgpu_dm initialize when stream nums greater
    than 6
  drm/amd/display: Stop amdgpu_dm initialize when link nums greater than
    max_links
  drm/amd/display: Add missing NULL pointer check within
    dpcd_extend_address_range
  drm/amd/display: Add array index check for hdcp ddc access
  drm/amd/display: Release state memory if
    amdgpu_dm_create_color_properties fail
  drm/amd/display: Add otg_master NULL check within
    resource_log_pipe_topology_update
  drm/amd/display: Fix Coverity INTERGER_OVERFLOW within
    construct_integrated_info
  drm/amd/display: Fix Coverity INTEGER_OVERFLOW within
    dal_gpio_service_create
  drm/amd/display: Add NULL pointer check for kzalloc
  drm/amd/display: Fix wrong array size dummy_boolean of
    dml2_core_calcs_mode_support_locals
  drm/amd/display: Release clck_src memory if clk_src_construct fails
  drm/amd/display: Fix Coverity INTEGER_OVERFLOW within
    decide_fallback_link_setting_max_bw_policy

Leo Ma (1):
  drm/amd/display: Fix invalid Copyright notice

Nicholas Kazlauskas (1):
  drm/amd/display: Fix idle optimization checks for multi-display and
    dual eDP

Nicholas Susanto (1):
  drm/amd/display: Enable urgent latency adjustments for DCN35

Revalla Hari Krishna (1):
  drm/amd/display: Refactor DCCG into component folder

Samson Tam (1):
  drm/amd/display: Clean-up recout calculation for visual confirm

Sreeja Golui (1):
  drm/amd/display: Providing a mechanism to have a custom pwm frequency

Tom Chung (2):
  drm/amd/display: Add Replay capability and state in debugfs
  drm/amd/display: remove panel replay initialization for DCN316

Wenjing Liu (1):
  drm/amd/display: reset DSC clock in post unlock update

Xi Liu (1):
  drm/amd/display: add support for force ODM override

 drivers/gpu/drm/amd/display/Kconfig           |   2 +
 drivers/gpu/drm/amd/display/Makefile          |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 208 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  74 +++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   4 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   7 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   3 +-
 .../dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h  |   2 +-
 .../dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h  |   2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   2 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   9 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   3 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  28 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |  98 +++++++++
 .../display/dc/{ => dccg}/dcn20/dcn20_dccg.c  |   0
 .../display/dc/{ => dccg}/dcn20/dcn20_dccg.h  |   0
 .../dc/{ => dccg}/dcn201/dcn201_dccg.c        |   0
 .../dc/{ => dccg}/dcn201/dcn201_dccg.h        |   0
 .../display/dc/{ => dccg}/dcn21/dcn21_dccg.c  |   0
 .../display/dc/{ => dccg}/dcn21/dcn21_dccg.h  |   0
 .../display/dc/{ => dccg}/dcn30/dcn30_dccg.c  |   0
 .../display/dc/{ => dccg}/dcn30/dcn30_dccg.h  |   0
 .../dc/{ => dccg}/dcn301/dcn301_dccg.c        |   0
 .../dc/{ => dccg}/dcn301/dcn301_dccg.h        |   0
 .../dc/{ => dccg}/dcn302/dcn302_dccg.h        |   0
 .../dc/{ => dccg}/dcn303/dcn303_dccg.h        |   0
 .../display/dc/{ => dccg}/dcn31/dcn31_dccg.c  |   0
 .../display/dc/{ => dccg}/dcn31/dcn31_dccg.h  |   0
 .../dc/{ => dccg}/dcn314/dcn314_dccg.c        |   0
 .../dc/{ => dccg}/dcn314/dcn314_dccg.h        |   0
 .../display/dc/{ => dccg}/dcn32/dcn32_dccg.c  |   0
 .../display/dc/{ => dccg}/dcn32/dcn32_dccg.h  |   0
 .../display/dc/{ => dccg}/dcn35/dcn35_dccg.c  |   2 +-
 .../display/dc/{ => dccg}/dcn35/dcn35_dccg.h  |   0
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   8 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   4 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   3 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  14 ++
 .../amd/display/dc/dcn31/dcn31_panel_cntl.h   |   3 +
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   3 +-
 .../drm/amd/display/dc/dcn401/dcn401_dccg.c   |  31 +--
 .../dc/dcn401/dcn401_dio_stream_encoder.c     | 113 ++++------
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  14 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |   5 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   3 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  18 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |   3 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  17 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../drm/amd/display/dc/gpio/gpio_service.c    |  17 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |  17 +-
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  |  92 ++++++++
 .../display/dc/{ => hubp}/dcn10/dcn10_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn10/dcn10_hubp.h  |   0
 .../display/dc/{ => hubp}/dcn20/dcn20_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn20/dcn20_hubp.h  |   0
 .../dc/{ => hubp}/dcn201/dcn201_hubp.c        |   0
 .../dc/{ => hubp}/dcn201/dcn201_hubp.h        |   0
 .../display/dc/{ => hubp}/dcn21/dcn21_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn21/dcn21_hubp.h  |   0
 .../display/dc/{ => hubp}/dcn30/dcn30_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn30/dcn30_hubp.h  |   0
 .../display/dc/{ => hubp}/dcn31/dcn31_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn31/dcn31_hubp.h  |   0
 .../display/dc/{ => hubp}/dcn32/dcn32_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn32/dcn32_hubp.h  |   0
 .../display/dc/{ => hubp}/dcn35/dcn35_hubp.c  |   0
 .../display/dc/{ => hubp}/dcn35/dcn35_hubp.h  |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  46 +++-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  17 --
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  69 ++----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  33 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  99 ++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   6 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   1 -
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   5 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +-
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   4 +-
 .../amd/display/dc/link/protocols/link_dpcd.c |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 .../dc/resource/dce80/dce80_resource.c        |   1 +
 .../dc/resource/dcn20/dcn20_resource.c        |   9 +
 .../dc/resource/dcn31/dcn31_resource.c        |   1 +
 .../dc/resource/dcn314/dcn314_resource.c      |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  20 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 139 ++++++++++++
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  28 ++-
 117 files changed, 1059 insertions(+), 346 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn20/dcn20_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn20/dcn20_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn201/dcn201_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn201/dcn201_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn21/dcn21_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn21/dcn21_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn30/dcn30_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn30/dcn30_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn301/dcn301_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn301/dcn301_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn302/dcn302_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn303/dcn303_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn31/dcn31_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn31/dcn31_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn314/dcn314_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn314/dcn314_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn32/dcn32_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn32/dcn32_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn35/dcn35_dccg.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn35/dcn35_dccg.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn10/dcn10_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn10/dcn10_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn20/dcn20_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn20/dcn20_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn201/dcn201_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn201/dcn201_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn21/dcn21_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn21/dcn21_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn30/dcn30_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn30/dcn30_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn31/dcn31_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn31/dcn31_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn32/dcn32_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn32/dcn32_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn35/dcn35_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn35/dcn35_hubp.h (100%)

-- 
2.34.1

