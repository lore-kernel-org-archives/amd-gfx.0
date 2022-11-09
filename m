Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0341C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF7210E068;
	Wed,  9 Nov 2022 06:14:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E95310E05E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llFToHtIz7w3YKYnfQr9YFJoFjOUEEJ1S93zy6Hi77RAzsVq0KeahNqeXIVyRicaNdRKOLSbltnJ2n9Q9IydjqjMUzMY2YHFcMPq4wg0g2Or9YWk6cafpWxs9XkMaPSDGy3EuvbW56yQ0j55OnLR39A4/jl6CqswVrOefaJTl+F/JKzaCLB+keKyI0cBmZ0hfjVlDTswxxsTZehGf81Fkk7cMl7yjAiI9/ROS6y9XicL34n4Pg8a6eyGss4tl/HVpPwOPzrMs3e4f+AfmiK67ndXswt6DhShqov6h+4B3TJDaBnUTjk4YoH91v8ChYktnohYGVISNRhtm2ldm87ZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZqHX/4ekTlVKwa++NEmuiMybANY/BfQkYsznfD+NF4=;
 b=lkbjAgjukuJV8ghgToNo6OZ1FRa6pQNuvdE7bNOFWCG3Rm5kWHmvldG9J0DG/2fertV1yEXfiysEUCxKy6Hb0ihvbirT1dFS2ixCJ5et3Piyqd7zRD8h9MXBfTZsMq841Ywafi8MHhEBwPN7un8cYkr6BnMiAOFKoKIadn3mCW3wNps35s6gVfr9ZW8GUV29zCbFixgnUcU81CEdKfovYT0xZWS6vZyzS+ZbU6o+TDeQtGvrInhHII+bfk8v7lC4powq5D62PS9sW5yWnwBFrPyCELd35I5vE4QLH14nmc2PKniEtpec4hsE5SNOhhVmqGK1T9nCwh17BaM6Uz5H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZqHX/4ekTlVKwa++NEmuiMybANY/BfQkYsznfD+NF4=;
 b=xgvt5uUgGYixA7bCaoUy4GKaIyHPB5Pvc005BXqC3E1p+Iu0A5U8oM5APHwJ0IdwIGmUtc7Ijj82B27SuMd9gcr1nIVLTntg1ZeKh61s5dAq9ir47VxwXsMjbsvYWRL4Npu4edVWNGb1io9X92Z3GJJvWcF65Dy6COuPDQhq1IE=
Received: from DM6PR02CA0090.namprd02.prod.outlook.com (2603:10b6:5:1f4::31)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:14:40 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::e0) by DM6PR02CA0090.outlook.office365.com
 (2603:10b6:5:1f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:14:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:14:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:14:03 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:13:58 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/29] DC Patches November 07, 2022
Date: Wed, 9 Nov 2022 14:12:50 +0800
Message-ID: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b9b950-b995-46a1-3c2c-08dac219af56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDQ+xL74rOS6rVIk2VlyKPZP6acJEUlIQkT3D6mmVCaVqGp+VmTS0qOkJ0Gs+mYT40AQMKOOSfe5Vak8bwCAbtAodT33uiFRa0s86RE9s1yuOHnZYUzLLPA6IKhkG/dMSLfSL2bZmR8YVYMPi8SbAzOhifEbxe837LcgzXtRCk2VEOmDlm55ThEtsnGTPxFln8Hm9CDseuUYPIy8pvNjSyglsfDEYOAUZij7uCj6BBl7KNdR27b4n7Levf6SHgudErRgK1Sz1xYvFEFKsdh5a8oxAALOUOx/vt+47aqNqb9bcLkUM/n1IHIQ0xG7nzGFgXLhUZtXpcRWynaYqRreq2XhEVhYc4WtslBRZ6mTh58V4ZwTovJPzm8VQT0EFV6FUP6Z+ODw87uQ9Cp/AUr08Fh3+rlxnF3zMvt1VT0gMqmvbAVsVB4++ila8FX2VTWxwQfBN0lU6a3PXolfVwEgqBLxa+6OIFCIdmzX74yuD3RUIDbp5a9wBl7mP52WfoUzCUEr7chLhhyHH+5bAH9pgtDjg876634RMPCCXCeJFRmKKMsoOunpj/lAKJ6QqI9wT39Fhky7zJre7ATGLSDTMcCZ4U7RwsdGpZQgG1VCTXHmPN8t+v0vUtXlbrCVvQO80slt2nALMO2/rNPMaU5Jt8gS6UGfu1X0g38RwkFdHhAS3Dunz+SlsRxsYjKPnViKmvSaY2NnlAPRhCqmfkMzl19VEccAJ++QqLAuI/JJZw8Q9RKfrIQTc1QdblreNaAhyfJJPOlIldzcv388u9t9FZFFckBkSGflfpouLZEtfYXzikQMCNYxLjO8Ugr3OmU/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(36756003)(356005)(36860700001)(82740400003)(5660300002)(2906002)(47076005)(426003)(26005)(83380400001)(7696005)(186003)(336012)(1076003)(2616005)(316002)(70586007)(70206006)(81166007)(40480700001)(82310400005)(6916009)(40460700003)(8676002)(4326008)(8936002)(478600001)(54906003)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:14:39.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9b950-b995-46a1-3c2c-08dac219af56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This version brings along following fixes:

- Fix DPIA AUX timeout issue
- Add HUBP surface flip interrupt handler
- Fix dpms_off issue when disabling bios mode
- Update SubVP Visual Confirm
- Program pipes for ODM when removing planes
- Use min transition for all SubVP plane add/remove
- Support parsing VRAM info v3.0 from VBIOS
- Enable dchub request limit for NV32
- Workaround to increase phantom pipe vactive in pipesplit
- Fix dcn3.1x mode validation on high bandwidth config
- Check context constructed for pipe split flags after pipesplit
- Align phantom pipe dst/src scaling with main for subvp
- Fix calculation for cursor CAB allocation
- Fix unbounded requesting for high pixel rate modes on dcn315
- Revert Disable DRR actions during state commit
- Fix array index out of bound error in bios parser
- Fix optc2_configure warning on dcn314
- Fix Subvp phantom pipe transition
- Fix prefetch calculations for dcn32
- Use uclk pstate latency for fw assisted mclk validation dcn32
- Set max for prefetch lines on dcn32
- Rework macros for DWB register access
- Adjust DP 8b10b LT exit behavior

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Use min transition for all SubVP plane add/remove
  drm/amd/display: Don't check output BPP for phantom
  drm/amd/display: Fix Subvp phantom pipe transition

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.143.0

Aric Cyr (1):
  drm/amd/display: 3.2.212

Aurabindo Pillai (2):
  drm/amd/display: fix array index out of bound error in bios parser
  drm/amd/display: rework macros for DWB register access

Charlene Liu (1):
  drm/amd/display: fix dcn3.1x mode validation on high bandwidth config

David Galiffi (1):
  drm/amd/display: Update SubVP Visual Confirm

Dillon Varone (6):
  drm/amd/display: Program pipes for ODM when removing planes
  drm/amd/display: Check context constructed for pipe split flags is
    still valid
  drm/amd/display: Align phantom pipe dst/src scaling with main for
    subvp
  drm/amd/display: Fix prefetch calculations for dcn32
  drm/amd/display: use uclk pstate latency for fw assisted mclk
    validation dcn32
  drm/amd/display: Set max for prefetch lines on dcn32

Dmytro Laktyushkin (2):
  drm/amd/display: use low clocks for no plane configs
  drm/amd/display: fix unbounded requesting for high pixel rate modes on
    dcn315

George Shen (3):
  drm/amd/display: Support parsing VRAM info v3.0 from VBIOS
  drm/amd/display: Workaround to increase phantom pipe vactive in
    pipesplit
  drm/amd/display: Fix calculation for cursor CAB allocation

Ilya Bakoulin (1):
  drm/amd/display: Adjust DP 8b10b LT exit behavior

Jun Lei (1):
  drm/amd/display: enable dchub request limit for NV32

Liu Xi (1):
  drm/amd/display: clean up some irq service code for dcn201

Martin Leung (1):
  drm/amd/display: revert Disable DRR actions during state commit

Rodrigo Siqueira (1):
  drm/amd/display: Add HUBP surface flip interrupt handler

Roman Li (1):
  drm/amd/display: Fix optc2_configure warning on dcn314

Stylon Wang (2):
  drm/amd/display: Fix access timeout to DPIA AUX at boot time
  drm/amd/display: Fix invalid DPIA AUX reply causing system hang

Zhongwei Zhang (1):
  drm/amd/display: fix dpms_off issue when disabling bios mode

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |  46 ++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   4 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 106 +++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h  | 363 ++++++++----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  49 ++-
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.h |   7 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  11 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h |   6 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  15 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   3 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.h |   7 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   5 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   5 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  38 +-
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   3 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |  12 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  18 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  44 ++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   3 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   5 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  23 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   5 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  54 ++-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  64 ++-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   4 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   7 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../dc/irq/dcn201/irq_service_dcn201.c        |  17 +-
 .../dc/irq/dcn201/irq_service_dcn201.h        |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   3 +-
 51 files changed, 667 insertions(+), 385 deletions(-)

-- 
2.25.1

